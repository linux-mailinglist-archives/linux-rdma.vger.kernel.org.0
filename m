Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BCB2BFFD6
	for <lists+linux-rdma@lfdr.de>; Tue, 30 Apr 2019 20:43:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726733AbfD3SnR (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 30 Apr 2019 14:43:17 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:51380 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726006AbfD3SnR (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 30 Apr 2019 14:43:17 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x3UIdbE8092711;
        Tue, 30 Apr 2019 18:42:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=YyBSpvZVGUoae149gAMXoC8czWhOgz53XILRtlHeb5U=;
 b=ZeB2/pfF1rl27+iyaGLxGD/9nwLUwpHVvHFkt4/7ZCj3oy7dC+Ud87SG1y0a44BRXpFH
 zJBaotqNaDK8vtvV9uWdqS3x+J6JqyOIWnztXnFo+h7aWhNvJGN/lhQXKyIuDDLvDESe
 buzpydnkeJ/T/e+lkoFDsbdUF0EFmPERB+n1YT648A0npON7EtmWpx/ZfVm09H3IXPUm
 usg87WJefq6DanrgkgygVkacBguvDCpSJIrRfO4Oef8heacsyh41Nx9cDcF7JtG1SkhF
 8O/zjWToagjXXII8280bhgQqDwi6FJYTinuI2aOPpqnXKK8Ny4aQHW+alY4YH4z5ucZw Jg== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2130.oracle.com with ESMTP id 2s4ckdekk4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 30 Apr 2019 18:42:57 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x3UIfaxg001200;
        Tue, 30 Apr 2019 18:42:56 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3030.oracle.com with ESMTP id 2s4yy9q78e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 30 Apr 2019 18:42:56 +0000
Received: from abhmp0006.oracle.com (abhmp0006.oracle.com [141.146.116.12])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x3UIgsAt003825;
        Tue, 30 Apr 2019 18:42:54 GMT
Received: from srabinov-laptop (/10.175.1.252)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 30 Apr 2019 11:42:54 -0700
Date:   Tue, 30 Apr 2019 21:42:49 +0300
From:   Shamir Rabinovitch <shamir.rabinovitch@oracle.com>
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     dledford@redhat.com, linux-rdma@vger.kernel.org,
        Leon Romanovsky <leon@kernel.org>,
        Yishai Hadas <yishaih@mellanox.com>
Subject: Re: [PATCH for-next v1 2/4] RDMA/uverbs: uobj_get_obj_read should
 return the ib_uobject
Message-ID: <20190430184249.GB30695@srabinov-laptop>
References: <20190430142333.31063-1-shamir.rabinovitch@oracle.com>
 <20190430142333.31063-3-shamir.rabinovitch@oracle.com>
 <20190430175408.GA8101@ziepe.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190430175408.GA8101@ziepe.ca>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9243 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1904300111
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9243 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1904300111
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Apr 30, 2019 at 02:54:08PM -0300, Jason Gunthorpe wrote:
> On Tue, Apr 30, 2019 at 05:23:22PM +0300, Shamir Rabinovitch wrote:
> > future patch will remove the ib_uobject pointer from the ib_x
> > objects. the uobj_get_obj_read and uobj_put_obj_read macros
> > were constructed with the ability to reach the ib_uobject from
> > ib_x in mind. this need to change now.
> > 
> > Signed-off-by: Shamir Rabinovitch <shamir.rabinovitch@oracle.com>
> >  drivers/infiniband/core/uverbs_cmd.c | 165 +++++++++++++++++++++------
> >  include/rdma/uverbs_std_types.h      |   8 +-
> >  2 files changed, 137 insertions(+), 36 deletions(-)
> > 
> > diff --git a/drivers/infiniband/core/uverbs_cmd.c b/drivers/infiniband/core/uverbs_cmd.c
> > index 76ac113d1da5..93363c41e77e 100644
> > +++ b/drivers/infiniband/core/uverbs_cmd.c
> > @@ -37,6 +37,7 @@
> >  #include <linux/fs.h>
> >  #include <linux/slab.h>
> >  #include <linux/sched.h>
> > +#include <linux/list.h>
> >  
> >  #include <linux/uaccess.h>
> >  
> > @@ -700,6 +701,7 @@ static int ib_uverbs_reg_mr(struct uverbs_attr_bundle *attrs)
> >  	struct ib_uverbs_reg_mr      cmd;
> >  	struct ib_uverbs_reg_mr_resp resp;
> >  	struct ib_uobject           *uobj;
> > +	struct ib_uobject           *pduobj;
> >  	struct ib_pd                *pd;
> >  	struct ib_mr                *mr;
> >  	int                          ret;
> > @@ -720,7 +722,8 @@ static int ib_uverbs_reg_mr(struct uverbs_attr_bundle *attrs)
> >  	if (IS_ERR(uobj))
> >  		return PTR_ERR(uobj);
> >  
> > -	pd = uobj_get_obj_read(pd, UVERBS_OBJECT_PD, cmd.pd_handle, attrs);
> > +	pd = uobj_get_obj_read(pd, UVERBS_OBJECT_PD, cmd.pd_handle, attrs,
> > +			       pduobj);
> 
> This should be &pduobj in all places so it reads sensibly..

OK. Will change the macro.

> 
> > @@ -2009,6 +2034,12 @@ static int ib_uverbs_post_send(struct uverbs_attr_bundle *attrs)
> >  	const struct ib_sge __user *sgls;
> >  	const void __user *wqes;
> >  	struct uverbs_req_iter iter;
> > +	struct uobj_list_item {
> > +		struct list_head list;
> > +		struct ib_uobject *uobj;
> > +	};
> > +	struct uobj_list_item *item, *tmp;
> > +	LIST_HEAD(ud_uobj_list);
> 
> I'd rather not add this for AH's if we don't plan to drop the uobject
> pointer right away.. Same for the other place making a big logic
> change

What's the concern? We drop the uobject in (almost) same line of code
where the current code do that. The uobjects are not held beyond the
function. Can you elaborate? 

Thanks

> 
> Jason
