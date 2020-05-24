from flask_sqlalchemy import Model
from sqlalchemy import Integer, Column
from sqlalchemy_utils import generic_repr


@generic_repr
class BaseModel(Model):
    """Base that _always_ includes a primary key and disables soft deletes"""

    __abstract__ = True
    __soft_deletes__ = False

    id = Column(Integer, primary_key=True)
