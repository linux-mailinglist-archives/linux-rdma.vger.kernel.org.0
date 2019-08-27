Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E380F9F025
	for <lists+linux-rdma@lfdr.de>; Tue, 27 Aug 2019 18:29:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726678AbfH0Q3Y (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 27 Aug 2019 12:29:24 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:39474 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727064AbfH0Q3Y (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 27 Aug 2019 12:29:24 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x7RGFY0C177790;
        Tue, 27 Aug 2019 16:28:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2019-08-05;
 bh=YK7gRhbHUDLyxukzYG8KPX9xAkK+aVeam7Mmjg6hY1o=;
 b=eFQks6brOX0KN1jV/QF0vR8QOgb9ovqOH3+xwu76Ex3Awxwf9qzjUYHNsjrJ4RjUzipr
 Haq7RDclBvmNtkYJfVhUD29qUxE7ZCGozc60sdkShyZ1aTaBWOcu/xwVYixp/58OH4ni
 uy1PDHQQV3RpjBdp1BVMWBtZGHRL9L5qn1kBTgOQm8UqdbfUTZSe2ZrOo5qYIBnYYOso
 SzS8xSDxKYB5+y8IytsaQ/XAFswzgs0YV5SD8Dc3pmnZ5TlbxME/cipUVI0Z0t1g92F/
 XgJZBdrAHgVBq/qYF/cumUV/lTNs0MC0a3SXhyfbR1wIgpOXq5kwEp/S+/TigPjgxqUO Lg== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2130.oracle.com with ESMTP id 2un7b4gcnd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 27 Aug 2019 16:28:28 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x7RGIUxM103791;
        Tue, 27 Aug 2019 16:28:28 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3020.oracle.com with ESMTP id 2un5rjpyex-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 27 Aug 2019 16:28:28 +0000
Received: from abhmp0013.oracle.com (abhmp0013.oracle.com [141.146.116.19])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x7RGSM1M019585;
        Tue, 27 Aug 2019 16:28:22 GMT
Received: from lap1 (/77.138.183.59)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 27 Aug 2019 09:28:22 -0700
Date:   Tue, 27 Aug 2019 19:28:14 +0300
From:   Yuval Shaia <yuval.shaia@oracle.com>
To:     Jason Gunthorpe <jgg@mellanox.com>
Cc:     "dledford@redhat.com" <dledford@redhat.com>,
        "leon@kernel.org" <leon@kernel.org>,
        Moni Shoua <monis@mellanox.com>,
        Parav Pandit <parav@mellanox.com>,
        Daniel Jurgens <danielj@mellanox.com>,
        "kamalheib1@gmail.com" <kamalheib1@gmail.com>,
        Mark Zhang <markz@mellanox.com>,
        "swise@opengridcomputing.com" <swise@opengridcomputing.com>,
        "shamir.rabinovitch@oracle.com" <shamir.rabinovitch@oracle.com>,
        "johannes.berg@intel.com" <johannes.berg@intel.com>,
        "willy@infradead.org" <willy@infradead.org>,
        Michael Guralnik <michaelgur@mellanox.com>,
        Mark Bloch <markb@mellanox.com>,
        "dan.carpenter@oracle.com" <dan.carpenter@oracle.com>,
        "bvanassche@acm.org" <bvanassche@acm.org>,
        Max Gurtovoy <maxg@mellanox.com>,
        Israel Rukshin <israelr@mellanox.com>,
        "galpress@amazon.com" <galpress@amazon.com>,
        Denis Drozdov <denisd@mellanox.com>,
        Yuval Avnery <yuvalav@mellanox.com>,
        "dennis.dalessandro@intel.com" <dennis.dalessandro@intel.com>,
        "will@kernel.org" <will@kernel.org>,
        Erez Alfasi <ereza@mellanox.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Shamir Rabinovitch <srabinov7@gmail.com>
Subject: Re: [PATCH v1 05/24] IB/core: ib_uobject need HW object reference
 count
Message-ID: <20190827162813.GA4737@lap1>
References: <20190821142125.5706-1-yuval.shaia@oracle.com>
 <20190821142125.5706-6-yuval.shaia@oracle.com>
 <20190821145324.GB8667@mellanox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190821145324.GB8667@mellanox.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9362 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1906280000 definitions=main-1908270161
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9362 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1906280000
 definitions=main-1908270161
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Aug 21, 2019 at 02:53:29PM +0000, Jason Gunthorpe wrote:
> On Wed, Aug 21, 2019 at 05:21:06PM +0300, Yuval Shaia wrote:
> > From: Shamir Rabinovitch <shamir.rabinovitch@oracle.com>
> > 
> > This new refcnt will points to the refcnt member of the HW object and will
> > behaves as expected by refcnt, i.e. will be increased and decreased as a
> > result of usage changes and will destroy the object when reaches to zero.
> > For a non-shared object refcnt will remain NULL.
> > 
> > Signed-off-by: Shamir Rabinovitch <shamir.rabinovitch@oracle.com>
> > Signed-off-by: Shamir Rabinovitch <srabinov7@gmail.com>
> >  drivers/infiniband/core/rdma_core.c | 23 +++++++++++++++++++++--
> >  include/rdma/ib_verbs.h             |  7 +++++++
> >  2 files changed, 28 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/infiniband/core/rdma_core.c b/drivers/infiniband/core/rdma_core.c
> > index ccf4d069c25c..651625f632d7 100644
> > +++ b/drivers/infiniband/core/rdma_core.c
> > @@ -516,7 +516,26 @@ static int __must_check destroy_hw_idr_uobject(struct ib_uobject *uobj,
> >  	const struct uverbs_obj_idr_type *idr_type =
> >  		container_of(uobj->uapi_object->type_attrs,
> >  			     struct uverbs_obj_idr_type, type);
> > -	int ret = idr_type->destroy_object(uobj, why, attrs);
> > +	static DEFINE_MUTEX(lock);
> > +	int ret, count;
> > +
> > +	mutex_lock(&lock);
> > +
> > +	if (uobj->refcnt) {
> > +		count = atomic_dec_return(uobj->refcnt);
> > +		WARN_ON(count < 0); /* use after free! */
> 
> Use a proper refcount_t

uobj->refcnt points to HW object's refcnt (e.x ib_pd.refcnt)

> 
> > +		if (count) {
> > +			mutex_unlock(&lock);
> > +			goto skip;
> > +		}
> > +	}
> > +
> > +	ret = idr_type->destroy_object(uobj, why, attrs);
> > +
> > +	if (ret)
> > +		atomic_inc(uobj->refcnt);
> > +
> > +	mutex_unlock(&lock);
> >  
> >  	/*
> >  	 * We can only fail gracefully if the user requested to destroy the
> > @@ -525,7 +544,7 @@ static int __must_check destroy_hw_idr_uobject(struct ib_uobject *uobj,
> >  	 */
> >  	if (ib_is_destroy_retryable(ret, why, uobj))
> >  		return ret;
> > -
> > +skip:
> 
> This doesn't seem to properly define who owns the rdmacg count - it
> should belong to the HW object not to the uobject.
> 
> > +
> > +	/*
> > +	 * ib_X HW object sharing support
> > +	 * - NULL for HW objects that are not shareable
> > +	 * - Pointer to ib_X reference counter for shareable HW objects
> > +	 */
> > +	atomic_t	       *refcnt;		/* ib_X object ref count */
> 
> Gross, shouldn't this actually be in the hw object?

It is belongs to the HW object, this one just *points* to it and it is
defined here since we like to maintain it when destroy_hw_idr_uobject is
called.

The actual assignment is only for object that *supports* import and it is
set in function ib_uverbs_import_ib_pd (patch "IB/uverbs: Add PD import
verb").

Hope it make sense.

> 
> Jason
