Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1039F2665D
	for <lists+linux-rdma@lfdr.de>; Wed, 22 May 2019 16:56:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729615AbfEVO4F (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 22 May 2019 10:56:05 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:38082 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728450AbfEVO4E (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 22 May 2019 10:56:04 -0400
Received: by mail-qt1-f195.google.com with SMTP id l3so2709297qtj.5
        for <linux-rdma@vger.kernel.org>; Wed, 22 May 2019 07:56:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=HQVmL1XslkyXkEyJp0w6QknhjQ2WsAibdoqZqGDdYAc=;
        b=Gl5SVwuvoytuWn64mskENDq9Mhc+JDAVi300LPOEWqLghnKjC5kbbN4wXhIGdFoXbv
         zy5rzKMGHPsr9U7kZt6M2N1Z8QHD7c+Y4Bpqx+ZxDAN9cJSq1QiRfhNKrfKWiCQzzADo
         QiTmAm4AIdRomjPrenvp8PEDLXrIhluIQYyTDy8BznAloaWH/N3fXByxeT62Jb0QIs08
         6VQw2DlZ5JeGIl9TRpPFsvPdy0FtdKXq0dHNbBYBtMiA4CknvGDfpLIPXbTUqSE6M6Q8
         l5anj2LSqqLrQgkJuLONbN0uxwGGxxYlauB7UQPmYT7hjw/JkkCfcMgI+9nXSKqUA0fs
         AoiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=HQVmL1XslkyXkEyJp0w6QknhjQ2WsAibdoqZqGDdYAc=;
        b=Oa1hxkAHIsR8f56Um1KFBU3raXvfykbXTRFdhAeqC8ryIZEckxG/sS0Es0yyaUEufv
         PRiobomDPpQRPG6kdMfWbsHAg2MGmbcygn7WZr/5ywOjWXj801FiuKBRAh+ski7TH1xF
         KKkZPr97b/kwqwzZ69X0jRPBSAT2ynorrD0v3FSCl2+x0uEOJYCMLXz10AIAaeo+QY/b
         8PDpqPKHPXtZfv8Ru66l1QQu7+8cQ3b5OtigIkSKD3f+YOjXpnXoHzUB4DIiD1NU5fUd
         q2zH6y4GJvWbFOg9ClWGSQ3OlUj9IPPGC4rsBu7j+5dg3Qb0L2sJ519YDMtpQuZ330op
         e2tw==
X-Gm-Message-State: APjAAAW6X1olKfMbfjw6HYrYDjQNnnJin40IURBURaaFrzqoQvWUodM0
        aOFzYnBOBb3LavPZNjV6QFjfOQ==
X-Google-Smtp-Source: APXvYqzvWCnu1texe54nrlEAXS/0gsAML5JRFFLkOK9wDxRc83w86Ts+UnjZ85PIvxc3A85xiGY2kw==
X-Received: by 2002:ac8:3804:: with SMTP id q4mr74784534qtb.139.1558536963279;
        Wed, 22 May 2019 07:56:03 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-49-251.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.49.251])
        by smtp.gmail.com with ESMTPSA id s188sm1146910qkd.67.2019.05.22.07.56.02
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 22 May 2019 07:56:02 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1hTSev-0003S6-La; Wed, 22 May 2019 11:56:01 -0300
Date:   Wed, 22 May 2019 11:56:01 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Gal Pressman <galpress@amazon.com>
Cc:     linux-rdma@vger.kernel.org, Leon Romanovsky <leon@kernel.org>,
        Doug Ledford <dledford@redhat.com>,
        Yossi Leybovich <sleybo@amazon.com>
Subject: Re: [PATCH for-rc] RDMA/uverbs: Pass udata on uverbs error unwind
Message-ID: <20190522145601.GC6054@ziepe.ca>
References: <20190522080643.52654-1-galpress@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190522080643.52654-1-galpress@amazon.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, May 22, 2019 at 11:06:43AM +0300, Gal Pressman wrote:
> When destroy_* is called as a result of uverbs create cleanup flow a
> cleared udata should be passed instead of NULL to indicate that it is
> called under user flow.
> 
> Fixes: bc38a6abdd5a ("[PATCH] IB uverbs: core implementation")
> Fixes: 67cdb40ca444 ("[IB] uverbs: Implement more commands")
> Fixes: 42849b2697c3 ("RDMA/uverbs: Export ib_open_qp() capability to user space")
> Fixes: 9ee79fce3642 ("IB/core: Add completion queue (cq) object actions")
> Signed-off-by: Gal Pressman <galpress@amazon.com>
> ---
>  drivers/infiniband/core/uverbs_cmd.c          | 9 +++++----
>  drivers/infiniband/core/uverbs_std_types_cq.c | 2 +-
>  2 files changed, 6 insertions(+), 5 deletions(-)

Yes, but I think this only got broken by Shamir's latest work, so
those fixes lines are a bit overbroad
 
> diff --git a/drivers/infiniband/core/uverbs_cmd.c b/drivers/infiniband/core/uverbs_cmd.c
> index a9b32ebb9beb..63fe14c7c68f 100644
> --- a/drivers/infiniband/core/uverbs_cmd.c
> +++ b/drivers/infiniband/core/uverbs_cmd.c
> @@ -1053,7 +1053,7 @@ static struct ib_ucq_object *create_cq(struct uverbs_attr_bundle *attrs,
>  	return obj;
>  
>  err_cb:
> -	ib_destroy_cq(cq);
> +	ib_destroy_cq_user(cq, uverbs_get_cleared_udata(attrs));
>  
>  err_file:
>  	if (ev_file)
> @@ -1489,7 +1489,7 @@ static int create_qp(struct uverbs_attr_bundle *attrs,
>  
>  	return uobj_alloc_commit(&obj->uevent.uobject, attrs);
>  err_cb:
> -	ib_destroy_qp(qp);
> +	ib_destroy_qp_user(qp, uverbs_get_cleared_udata(attrs));

Blah, the more I look at this, the more wrongly it seems.

The ioctl code handles this by destroying the uobject as part of
alloc_abort - which automatically uses the right flow.

We hacked up a special uobj_alloc_abort/rdma_alloc_abort_uobject that
nulls the uobj->object to prevernt this.

But this now seems like a mistake

I once sketched out a patch to remove *all* of these destroys from the
uverbs_cmd.c, so maybe we should do that as well.. Here is the old version:

Jason

From cf37a512ad366f4634fa7a9c7358bdf91b7b5c73 Mon Sep 17 00:00:00 2001
Date: Wed, 13 Feb 2019 19:07:05 +0200
Subject: [PATCH] RDMA/uverbs: Rely on abort_uobject to cleanup

Make write commands more like ioctl commands and rely on the
abort_uobject flow to clean up and destroy the HW object during error
unwind.

Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
---
 drivers/infiniband/core/rdma_core.c           |  1 -
 drivers/infiniband/core/uverbs_cmd.c          | 85 ++++++-------------
 .../core/uverbs_std_types_counters.c          | 10 +--
 drivers/infiniband/core/uverbs_std_types_cq.c | 10 +--
 4 files changed, 28 insertions(+), 78 deletions(-)

diff --git a/drivers/infiniband/core/rdma_core.c b/drivers/infiniband/core/rdma_core.c
index a260d2f8e0b771..3599b97b00b59b 100644
--- a/drivers/infiniband/core/rdma_core.c
+++ b/drivers/infiniband/core/rdma_core.c
@@ -679,7 +679,6 @@ void rdma_alloc_abort_uobject(struct ib_uobject *uobj)
 {
 	struct ib_uverbs_file *ufile = uobj->ufile;
 
-	uobj->object = NULL;
 	uverbs_destroy_uobject(uobj, RDMA_REMOVE_ABORT);
 
 	/* Matches the down_read in rdma_alloc_begin_uobject */
diff --git a/drivers/infiniband/core/uverbs_cmd.c b/drivers/infiniband/core/uverbs_cmd.c
index 5ac143f22df009..15f31c915cd1fd 100644
--- a/drivers/infiniband/core/uverbs_cmd.c
+++ b/drivers/infiniband/core/uverbs_cmd.c
@@ -430,12 +430,10 @@ static int ib_uverbs_alloc_pd(struct uverbs_attr_bundle *attrs)
 
 	ret = uverbs_response(attrs, &resp, sizeof(resp));
 	if (ret)
-		goto err_copy;
+		goto err;
 
 	return uobj_alloc_commit(uobj);
 
-err_copy:
-	ib_dealloc_pd(pd);
 err_alloc:
 	kfree(pd);
 err:
@@ -609,20 +607,20 @@ static int ib_uverbs_open_xrcd(struct uverbs_attr_bundle *attrs)
 	memset(&resp, 0, sizeof resp);
 	resp.xrcd_handle = obj->uobject.id;
 
+	ret = uverbs_response(attrs, &resp, sizeof(resp));
+	if (ret)
+		goto err;
+
 	if (inode) {
 		if (new_xrcd) {
 			/* create new inode/xrcd table entry */
 			ret = xrcd_table_insert(ibudev, inode, xrcd);
 			if (ret)
-				goto err_dealloc_xrcd;
+				goto err;
 		}
 		atomic_inc(&xrcd->usecnt);
 	}
 
-	ret = uverbs_response(attrs, &resp, sizeof(resp));
-	if (ret)
-		goto err_copy;
-
 	if (f.file)
 		fdput(f);
 
@@ -630,16 +628,6 @@ static int ib_uverbs_open_xrcd(struct uverbs_attr_bundle *attrs)
 
 	return uobj_alloc_commit(&obj->uobject);
 
-err_copy:
-	if (inode) {
-		if (new_xrcd)
-			xrcd_table_delete(ibudev, inode);
-		atomic_dec(&xrcd->usecnt);
-	}
-
-err_dealloc_xrcd:
-	ib_dealloc_xrcd(xrcd);
-
 err:
 	uobj_alloc_abort(&obj->uobject);
 
@@ -754,15 +742,12 @@ static int ib_uverbs_reg_mr(struct uverbs_attr_bundle *attrs)
 
 	ret = uverbs_response(attrs, &resp, sizeof(resp));
 	if (ret)
-		goto err_copy;
+		goto err_put;
 
 	uobj_put_obj_read(pd);
 
 	return uobj_alloc_commit(uobj);
 
-err_copy:
-	ib_dereg_mr(mr);
-
 err_put:
 	uobj_put_obj_read(pd);
 
@@ -905,13 +890,11 @@ static int ib_uverbs_alloc_mw(struct uverbs_attr_bundle *attrs)
 
 	ret = uverbs_response(attrs, &resp, sizeof(resp));
 	if (ret)
-		goto err_copy;
+		goto err_put;
 
 	uobj_put_obj_read(pd);
 	return uobj_alloc_commit(uobj);
 
-err_copy:
-	uverbs_dealloc_mw(mw);
 err_put:
 	uobj_put_obj_read(pd);
 err_free:
@@ -1025,16 +1008,13 @@ static struct ib_ucq_object *create_cq(struct uverbs_attr_bundle *attrs,
 
 	ret = uverbs_response(attrs, &resp, sizeof(resp));
 	if (ret)
-		goto err_cb;
+		goto err;
 
 	ret = uobj_alloc_commit(&obj->uobject);
 	if (ret)
 		return ERR_PTR(ret);
 	return obj;
 
-err_cb:
-	ib_destroy_cq(cq);
-
 err_file:
 	if (ev_file)
 		ib_uverbs_release_ucq(attrs->ufile, ev_file, obj);
@@ -1404,12 +1384,9 @@ static int create_qp(struct uverbs_attr_bundle *attrs,
 		ret = PTR_ERR(qp);
 		goto err_put;
 	}
+	obj->uevent.uobject.object = qp;
 
 	if (cmd->qp_type != IB_QPT_XRC_TGT) {
-		ret = ib_create_qp_security(qp, device);
-		if (ret)
-			goto err_cb;
-
 		qp->real_qp	  = qp;
 		qp->pd		  = pd;
 		qp->send_cq	  = attr.send_cq;
@@ -1430,13 +1407,15 @@ static int create_qp(struct uverbs_attr_bundle *attrs,
 			atomic_inc(&attr.srq->usecnt);
 		if (ind_tbl)
 			atomic_inc(&ind_tbl->usecnt);
+
+		ret = ib_create_qp_security(qp, device);
+		if (ret)
+			goto err_put;
 	} else {
 		/* It is done in _ib_create_qp for other QP types */
 		qp->uobject = &obj->uevent.uobject;
 	}
 
-	obj->uevent.uobject.object = qp;
-
 	memset(&resp, 0, sizeof resp);
 	resp.base.qpn             = qp->qp_num;
 	resp.base.qp_handle       = obj->uevent.uobject.id;
@@ -1449,7 +1428,7 @@ static int create_qp(struct uverbs_attr_bundle *attrs,
 
 	ret = uverbs_response(attrs, &resp, sizeof(resp));
 	if (ret)
-		goto err_cb;
+		goto err_put;
 
 	if (xrcd) {
 		obj->uxrcd = container_of(xrcd_uobj, struct ib_uxrcd_object,
@@ -1470,8 +1449,6 @@ static int create_qp(struct uverbs_attr_bundle *attrs,
 		uobj_put_obj_read(ind_tbl);
 
 	return uobj_alloc_commit(&obj->uevent.uobject);
-err_cb:
-	ib_destroy_qp(qp);
 
 err_put:
 	if (!IS_ERR(xrcd_uobj))
@@ -1594,7 +1571,7 @@ static int ib_uverbs_open_qp(struct uverbs_attr_bundle *attrs)
 
 	ret = uverbs_response(attrs, &resp, sizeof(resp));
 	if (ret)
-		goto err_destroy;
+		goto err_xrcd;
 
 	obj->uxrcd = container_of(xrcd_uobj, struct ib_uxrcd_object, uobject);
 	atomic_inc(&obj->uxrcd->refcnt);
@@ -1603,8 +1580,6 @@ static int ib_uverbs_open_qp(struct uverbs_attr_bundle *attrs)
 
 	return uobj_alloc_commit(&obj->uevent.uobject);
 
-err_destroy:
-	ib_destroy_qp(qp);
 err_xrcd:
 	uobj_put_read(xrcd_uobj);
 err_put:
@@ -2440,14 +2415,11 @@ static int ib_uverbs_create_ah(struct uverbs_attr_bundle *attrs)
 
 	ret = uverbs_response(attrs, &resp, sizeof(resp));
 	if (ret)
-		goto err_copy;
+		goto err_put;
 
 	uobj_put_obj_read(pd);
 	return uobj_alloc_commit(uobj);
 
-err_copy:
-	rdma_destroy_ah(ah, RDMA_DESTROY_AH_SLEEPABLE);
-
 err_put:
 	uobj_put_obj_read(pd);
 
@@ -2950,14 +2922,12 @@ static int ib_uverbs_ex_create_wq(struct uverbs_attr_bundle *attrs)
 	resp.response_length = uverbs_response_length(attrs, sizeof(resp));
 	err = uverbs_response(attrs, &resp, sizeof(resp));
 	if (err)
-		goto err_copy;
+		goto err_put_cq;
 
 	uobj_put_obj_read(pd);
 	uobj_put_obj_read(cq);
 	return uobj_alloc_commit(&obj->uevent.uobject);
 
-err_copy:
-	ib_destroy_wq(wq);
 err_put_cq:
 	uobj_put_obj_read(cq);
 err_put_pd:
@@ -3105,6 +3075,7 @@ static int ib_uverbs_ex_create_rwq_ind_table(struct uverbs_attr_bundle *attrs)
 		goto err_uobj;
 	}
 
+	wqs = NULL;
 	rwq_ind_tbl->ind_tbl = wqs;
 	rwq_ind_tbl->log_ind_tbl_size = init_attr.log_ind_tbl_size;
 	rwq_ind_tbl->uobject = uobj;
@@ -3121,7 +3092,7 @@ static int ib_uverbs_ex_create_rwq_ind_table(struct uverbs_attr_bundle *attrs)
 
 	err = uverbs_response(attrs, &resp, sizeof(resp));
 	if (err)
-		goto err_copy;
+		goto err_uobj;
 
 	kfree(wqs_handles);
 
@@ -3130,8 +3101,6 @@ static int ib_uverbs_ex_create_rwq_ind_table(struct uverbs_attr_bundle *attrs)
 
 	return uobj_alloc_commit(uobj);
 
-err_copy:
-	ib_destroy_rwq_ind_table(rwq_ind_tbl);
 err_uobj:
 	uobj_alloc_abort(uobj);
 put_wqs:
@@ -3293,23 +3262,20 @@ static int ib_uverbs_ex_create_flow(struct uverbs_attr_bundle *attrs)
 		goto err_free;
 	}
 
-	ib_set_flow(uobj, flow_id, qp, qp->device, uflow_res);
-
 	memset(&resp, 0, sizeof(resp));
 	resp.flow_handle = uobj->id;
 
 	err = uverbs_response(attrs, &resp, sizeof(resp));
 	if (err)
-		goto err_copy;
+		goto err_free;
+
+	ib_set_flow(uobj, flow_id, qp, qp->device, uflow_res);
 
 	uobj_put_obj_read(qp);
 	kfree(flow_attr);
 	if (cmd.flow_attr.num_of_specs)
 		kfree(kern_flow_attr);
 	return uobj_alloc_commit(uobj);
-err_copy:
-	if (!qp->device->ops.destroy_flow(flow_id))
-		atomic_dec(&qp->usecnt);
 err_free:
 	ib_uverbs_flow_resources_free(uflow_res);
 err_free_flow_attr:
@@ -3441,7 +3407,7 @@ static int __uverbs_create_xsrq(struct uverbs_attr_bundle *attrs,
 
 	ret = uverbs_response(attrs, &resp, sizeof(resp));
 	if (ret)
-		goto err_copy;
+		goto err;
 
 	if (cmd->srq_type == IB_SRQT_XRC)
 		uobj_put_read(xrcd_uobj);
@@ -3452,9 +3418,6 @@ static int __uverbs_create_xsrq(struct uverbs_attr_bundle *attrs,
 	uobj_put_obj_read(pd);
 	return uobj_alloc_commit(&obj->uevent.uobject);
 
-err_copy:
-	ib_destroy_srq(srq);
-
 err_put:
 	uobj_put_obj_read(pd);
 
diff --git a/drivers/infiniband/core/uverbs_std_types_counters.c b/drivers/infiniband/core/uverbs_std_types_counters.c
index 309c5e80988d2e..9b096d7e36cf59 100644
--- a/drivers/infiniband/core/uverbs_std_types_counters.c
+++ b/drivers/infiniband/core/uverbs_std_types_counters.c
@@ -54,7 +54,6 @@ static int UVERBS_HANDLER(UVERBS_METHOD_COUNTERS_CREATE)(
 		attrs, UVERBS_ATTR_CREATE_COUNTERS_HANDLE);
 	struct ib_device *ib_dev = uobj->context->device;
 	struct ib_counters *counters;
-	int ret;
 
 	/*
 	 * This check should be removed once the infrastructure
@@ -65,10 +64,8 @@ static int UVERBS_HANDLER(UVERBS_METHOD_COUNTERS_CREATE)(
 		return -EOPNOTSUPP;
 
 	counters = ib_dev->ops.create_counters(ib_dev, attrs);
-	if (IS_ERR(counters)) {
-		ret = PTR_ERR(counters);
-		goto err_create_counters;
-	}
+	if (IS_ERR(counters))
+		return PTR_ERR(counters);
 
 	counters->device = ib_dev;
 	counters->uobject = uobj;
@@ -76,9 +73,6 @@ static int UVERBS_HANDLER(UVERBS_METHOD_COUNTERS_CREATE)(
 	atomic_set(&counters->usecnt, 0);
 
 	return 0;
-
-err_create_counters:
-	return ret;
 }
 
 static int UVERBS_HANDLER(UVERBS_METHOD_COUNTERS_READ)(
diff --git a/drivers/infiniband/core/uverbs_std_types_cq.c b/drivers/infiniband/core/uverbs_std_types_cq.c
index a59ea89e3f2b06..f9f4c1460c7a58 100644
--- a/drivers/infiniband/core/uverbs_std_types_cq.c
+++ b/drivers/infiniband/core/uverbs_std_types_cq.c
@@ -128,14 +128,8 @@ static int UVERBS_HANDLER(UVERBS_METHOD_CQ_CREATE)(
 	cq->res.type = RDMA_RESTRACK_CQ;
 	rdma_restrack_uadd(&cq->res);
 
-	ret = uverbs_copy_to(attrs, UVERBS_ATTR_CREATE_CQ_RESP_CQE, &cq->cqe,
-			     sizeof(cq->cqe));
-	if (ret)
-		goto err_cq;
-
-	return 0;
-err_cq:
-	ib_destroy_cq(cq);
+	return uverbs_copy_to(attrs, UVERBS_ATTR_CREATE_CQ_RESP_CQE, &cq->cqe,
+			      sizeof(cq->cqe));
 
 err_event_file:
 	if (ev_file)
-- 
2.21.0

