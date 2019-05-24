Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 63CE529103
	for <lists+linux-rdma@lfdr.de>; Fri, 24 May 2019 08:34:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388841AbfEXGeE (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 24 May 2019 02:34:04 -0400
Received: from smtp-fw-33001.amazon.com ([207.171.190.10]:42053 "EHLO
        smtp-fw-33001.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388260AbfEXGeE (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 24 May 2019 02:34:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1558679639; x=1590215639;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=4Kek1DRDobORNplhFlh1zgqEM2pm7Q/uG7IMvssMjiw=;
  b=KCdiCgclponkjG2RECFB+1AvnyReIh5z/qo+Uq5oGIW6Tl5s7jitGNtd
   tWW0j/px1sSaHjmAYYLZfVdIOKj5RPr/Xib8rLcHEdSJoRXVomoZVQz04
   QG98YCRGZH3ESg07qiWOHOQbArSW+NUky6MqmUSEFFb3yTxgsaG2XtJNs
   Q=;
X-IronPort-AV: E=Sophos;i="5.60,506,1549929600"; 
   d="scan'208";a="801491935"
Received: from sea3-co-svc-lb6-vlan2.sea.amazon.com (HELO email-inbound-relay-1d-98acfc19.us-east-1.amazon.com) ([10.47.22.34])
  by smtp-border-fw-out-33001.sea14.amazon.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 24 May 2019 06:33:57 +0000
Received: from EX13MTAUEA001.ant.amazon.com (iad55-ws-svc-p15-lb9-vlan3.iad.amazon.com [10.40.159.166])
        by email-inbound-relay-1d-98acfc19.us-east-1.amazon.com (8.14.7/8.14.7) with ESMTP id x4O6XsgM019871
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=FAIL);
        Fri, 24 May 2019 06:33:55 GMT
Received: from EX13D19EUB003.ant.amazon.com (10.43.166.69) by
 EX13MTAUEA001.ant.amazon.com (10.43.61.243) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Fri, 24 May 2019 06:33:54 +0000
Received: from 8c85908914bf.ant.amazon.com (10.43.162.94) by
 EX13D19EUB003.ant.amazon.com (10.43.166.69) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Fri, 24 May 2019 06:33:50 +0000
Subject: Re: [PATCH for-rc] RDMA/uverbs: Pass udata on uverbs error unwind
To:     Jason Gunthorpe <jgg@ziepe.ca>
CC:     <linux-rdma@vger.kernel.org>, Leon Romanovsky <leon@kernel.org>,
        "Doug Ledford" <dledford@redhat.com>,
        Yossi Leybovich <sleybo@amazon.com>
References: <20190522080643.52654-1-galpress@amazon.com>
 <20190522145601.GC6054@ziepe.ca>
From:   Gal Pressman <galpress@amazon.com>
Message-ID: <7514a42a-8052-81a9-97b6-125a14a3eccc@amazon.com>
Date:   Fri, 24 May 2019 09:33:41 +0300
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:60.0)
 Gecko/20100101 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190522145601.GC6054@ziepe.ca>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.43.162.94]
X-ClientProxiedBy: EX13D12UWC004.ant.amazon.com (10.43.162.182) To
 EX13D19EUB003.ant.amazon.com (10.43.166.69)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 22/05/2019 17:56, Jason Gunthorpe wrote:
> On Wed, May 22, 2019 at 11:06:43AM +0300, Gal Pressman wrote:
>> When destroy_* is called as a result of uverbs create cleanup flow a
>> cleared udata should be passed instead of NULL to indicate that it is
>> called under user flow.
>>
>> Fixes: bc38a6abdd5a ("[PATCH] IB uverbs: core implementation")
>> Fixes: 67cdb40ca444 ("[IB] uverbs: Implement more commands")
>> Fixes: 42849b2697c3 ("RDMA/uverbs: Export ib_open_qp() capability to user space")
>> Fixes: 9ee79fce3642 ("IB/core: Add completion queue (cq) object actions")
>> Signed-off-by: Gal Pressman <galpress@amazon.com>
>> ---
>>  drivers/infiniband/core/uverbs_cmd.c          | 9 +++++----
>>  drivers/infiniband/core/uverbs_std_types_cq.c | 2 +-
>>  2 files changed, 6 insertions(+), 5 deletions(-)
> 
> Yes, but I think this only got broken by Shamir's latest work, so
> those fixes lines are a bit overbroad
>  
>> diff --git a/drivers/infiniband/core/uverbs_cmd.c b/drivers/infiniband/core/uverbs_cmd.c
>> index a9b32ebb9beb..63fe14c7c68f 100644
>> --- a/drivers/infiniband/core/uverbs_cmd.c
>> +++ b/drivers/infiniband/core/uverbs_cmd.c
>> @@ -1053,7 +1053,7 @@ static struct ib_ucq_object *create_cq(struct uverbs_attr_bundle *attrs,
>>  	return obj;
>>  
>>  err_cb:
>> -	ib_destroy_cq(cq);
>> +	ib_destroy_cq_user(cq, uverbs_get_cleared_udata(attrs));
>>  
>>  err_file:
>>  	if (ev_file)
>> @@ -1489,7 +1489,7 @@ static int create_qp(struct uverbs_attr_bundle *attrs,
>>  
>>  	return uobj_alloc_commit(&obj->uevent.uobject, attrs);
>>  err_cb:
>> -	ib_destroy_qp(qp);
>> +	ib_destroy_qp_user(qp, uverbs_get_cleared_udata(attrs));
> 
> Blah, the more I look at this, the more wrongly it seems.
> 
> The ioctl code handles this by destroying the uobject as part of
> alloc_abort - which automatically uses the right flow.
> 
> We hacked up a special uobj_alloc_abort/rdma_alloc_abort_uobject that
> nulls the uobj->object to prevernt this.
> 
> But this now seems like a mistake
> 
> I once sketched out a patch to remove *all* of these destroys from the
> uverbs_cmd.c, so maybe we should do that as well.. Here is the old version:

Do you think you'll submit this fix to for-rc? If not, we should apply Leon's
patch (that removed the udata checks from EFA) to for-rc in order to prevent
kernel panic.

> 
> From cf37a512ad366f4634fa7a9c7358bdf91b7b5c73 Mon Sep 17 00:00:00 2001
> Date: Wed, 13 Feb 2019 19:07:05 +0200
> Subject: [PATCH] RDMA/uverbs: Rely on abort_uobject to cleanup
> 
> Make write commands more like ioctl commands and rely on the
> abort_uobject flow to clean up and destroy the HW object during error
> unwind.
> 
> Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
> ---
>  drivers/infiniband/core/rdma_core.c           |  1 -
>  drivers/infiniband/core/uverbs_cmd.c          | 85 ++++++-------------
>  .../core/uverbs_std_types_counters.c          | 10 +--
>  drivers/infiniband/core/uverbs_std_types_cq.c | 10 +--
>  4 files changed, 28 insertions(+), 78 deletions(-)
> 
> diff --git a/drivers/infiniband/core/rdma_core.c b/drivers/infiniband/core/rdma_core.c
> index a260d2f8e0b771..3599b97b00b59b 100644
> --- a/drivers/infiniband/core/rdma_core.c
> +++ b/drivers/infiniband/core/rdma_core.c
> @@ -679,7 +679,6 @@ void rdma_alloc_abort_uobject(struct ib_uobject *uobj)
>  {
>  	struct ib_uverbs_file *ufile = uobj->ufile;
>  
> -	uobj->object = NULL;
>  	uverbs_destroy_uobject(uobj, RDMA_REMOVE_ABORT);
>  
>  	/* Matches the down_read in rdma_alloc_begin_uobject */
> diff --git a/drivers/infiniband/core/uverbs_cmd.c b/drivers/infiniband/core/uverbs_cmd.c
> index 5ac143f22df009..15f31c915cd1fd 100644
> --- a/drivers/infiniband/core/uverbs_cmd.c
> +++ b/drivers/infiniband/core/uverbs_cmd.c
> @@ -430,12 +430,10 @@ static int ib_uverbs_alloc_pd(struct uverbs_attr_bundle *attrs)
>  
>  	ret = uverbs_response(attrs, &resp, sizeof(resp));
>  	if (ret)
> -		goto err_copy;
> +		goto err;
>  
>  	return uobj_alloc_commit(uobj);
>  
> -err_copy:
> -	ib_dealloc_pd(pd);
>  err_alloc:
>  	kfree(pd);
>  err:
> @@ -609,20 +607,20 @@ static int ib_uverbs_open_xrcd(struct uverbs_attr_bundle *attrs)
>  	memset(&resp, 0, sizeof resp);
>  	resp.xrcd_handle = obj->uobject.id;
>  
> +	ret = uverbs_response(attrs, &resp, sizeof(resp));
> +	if (ret)
> +		goto err;
> +
>  	if (inode) {
>  		if (new_xrcd) {
>  			/* create new inode/xrcd table entry */
>  			ret = xrcd_table_insert(ibudev, inode, xrcd);
>  			if (ret)
> -				goto err_dealloc_xrcd;
> +				goto err;
>  		}
>  		atomic_inc(&xrcd->usecnt);
>  	}
>  
> -	ret = uverbs_response(attrs, &resp, sizeof(resp));
> -	if (ret)
> -		goto err_copy;
> -
>  	if (f.file)
>  		fdput(f);
>  
> @@ -630,16 +628,6 @@ static int ib_uverbs_open_xrcd(struct uverbs_attr_bundle *attrs)
>  
>  	return uobj_alloc_commit(&obj->uobject);
>  
> -err_copy:
> -	if (inode) {
> -		if (new_xrcd)
> -			xrcd_table_delete(ibudev, inode);
> -		atomic_dec(&xrcd->usecnt);
> -	}
> -
> -err_dealloc_xrcd:
> -	ib_dealloc_xrcd(xrcd);
> -
>  err:
>  	uobj_alloc_abort(&obj->uobject);
>  
> @@ -754,15 +742,12 @@ static int ib_uverbs_reg_mr(struct uverbs_attr_bundle *attrs)
>  
>  	ret = uverbs_response(attrs, &resp, sizeof(resp));
>  	if (ret)
> -		goto err_copy;
> +		goto err_put;
>  
>  	uobj_put_obj_read(pd);
>  
>  	return uobj_alloc_commit(uobj);
>  
> -err_copy:
> -	ib_dereg_mr(mr);
> -
>  err_put:
>  	uobj_put_obj_read(pd);
>  
> @@ -905,13 +890,11 @@ static int ib_uverbs_alloc_mw(struct uverbs_attr_bundle *attrs)
>  
>  	ret = uverbs_response(attrs, &resp, sizeof(resp));
>  	if (ret)
> -		goto err_copy;
> +		goto err_put;
>  
>  	uobj_put_obj_read(pd);
>  	return uobj_alloc_commit(uobj);
>  
> -err_copy:
> -	uverbs_dealloc_mw(mw);
>  err_put:
>  	uobj_put_obj_read(pd);
>  err_free:
> @@ -1025,16 +1008,13 @@ static struct ib_ucq_object *create_cq(struct uverbs_attr_bundle *attrs,
>  
>  	ret = uverbs_response(attrs, &resp, sizeof(resp));
>  	if (ret)
> -		goto err_cb;
> +		goto err;
>  
>  	ret = uobj_alloc_commit(&obj->uobject);
>  	if (ret)
>  		return ERR_PTR(ret);
>  	return obj;
>  
> -err_cb:
> -	ib_destroy_cq(cq);
> -
>  err_file:
>  	if (ev_file)
>  		ib_uverbs_release_ucq(attrs->ufile, ev_file, obj);
> @@ -1404,12 +1384,9 @@ static int create_qp(struct uverbs_attr_bundle *attrs,
>  		ret = PTR_ERR(qp);
>  		goto err_put;
>  	}
> +	obj->uevent.uobject.object = qp;
>  
>  	if (cmd->qp_type != IB_QPT_XRC_TGT) {
> -		ret = ib_create_qp_security(qp, device);
> -		if (ret)
> -			goto err_cb;
> -
>  		qp->real_qp	  = qp;
>  		qp->pd		  = pd;
>  		qp->send_cq	  = attr.send_cq;
> @@ -1430,13 +1407,15 @@ static int create_qp(struct uverbs_attr_bundle *attrs,
>  			atomic_inc(&attr.srq->usecnt);
>  		if (ind_tbl)
>  			atomic_inc(&ind_tbl->usecnt);
> +
> +		ret = ib_create_qp_security(qp, device);
> +		if (ret)
> +			goto err_put;
>  	} else {
>  		/* It is done in _ib_create_qp for other QP types */
>  		qp->uobject = &obj->uevent.uobject;
>  	}
>  
> -	obj->uevent.uobject.object = qp;
> -
>  	memset(&resp, 0, sizeof resp);
>  	resp.base.qpn             = qp->qp_num;
>  	resp.base.qp_handle       = obj->uevent.uobject.id;
> @@ -1449,7 +1428,7 @@ static int create_qp(struct uverbs_attr_bundle *attrs,
>  
>  	ret = uverbs_response(attrs, &resp, sizeof(resp));
>  	if (ret)
> -		goto err_cb;
> +		goto err_put;
>  
>  	if (xrcd) {
>  		obj->uxrcd = container_of(xrcd_uobj, struct ib_uxrcd_object,
> @@ -1470,8 +1449,6 @@ static int create_qp(struct uverbs_attr_bundle *attrs,
>  		uobj_put_obj_read(ind_tbl);
>  
>  	return uobj_alloc_commit(&obj->uevent.uobject);
> -err_cb:
> -	ib_destroy_qp(qp);
>  
>  err_put:
>  	if (!IS_ERR(xrcd_uobj))
> @@ -1594,7 +1571,7 @@ static int ib_uverbs_open_qp(struct uverbs_attr_bundle *attrs)
>  
>  	ret = uverbs_response(attrs, &resp, sizeof(resp));
>  	if (ret)
> -		goto err_destroy;
> +		goto err_xrcd;
>  
>  	obj->uxrcd = container_of(xrcd_uobj, struct ib_uxrcd_object, uobject);
>  	atomic_inc(&obj->uxrcd->refcnt);
> @@ -1603,8 +1580,6 @@ static int ib_uverbs_open_qp(struct uverbs_attr_bundle *attrs)
>  
>  	return uobj_alloc_commit(&obj->uevent.uobject);
>  
> -err_destroy:
> -	ib_destroy_qp(qp);
>  err_xrcd:
>  	uobj_put_read(xrcd_uobj);
>  err_put:
> @@ -2440,14 +2415,11 @@ static int ib_uverbs_create_ah(struct uverbs_attr_bundle *attrs)
>  
>  	ret = uverbs_response(attrs, &resp, sizeof(resp));
>  	if (ret)
> -		goto err_copy;
> +		goto err_put;
>  
>  	uobj_put_obj_read(pd);
>  	return uobj_alloc_commit(uobj);
>  
> -err_copy:
> -	rdma_destroy_ah(ah, RDMA_DESTROY_AH_SLEEPABLE);
> -
>  err_put:
>  	uobj_put_obj_read(pd);
>  
> @@ -2950,14 +2922,12 @@ static int ib_uverbs_ex_create_wq(struct uverbs_attr_bundle *attrs)
>  	resp.response_length = uverbs_response_length(attrs, sizeof(resp));
>  	err = uverbs_response(attrs, &resp, sizeof(resp));
>  	if (err)
> -		goto err_copy;
> +		goto err_put_cq;
>  
>  	uobj_put_obj_read(pd);
>  	uobj_put_obj_read(cq);
>  	return uobj_alloc_commit(&obj->uevent.uobject);
>  
> -err_copy:
> -	ib_destroy_wq(wq);
>  err_put_cq:
>  	uobj_put_obj_read(cq);
>  err_put_pd:
> @@ -3105,6 +3075,7 @@ static int ib_uverbs_ex_create_rwq_ind_table(struct uverbs_attr_bundle *attrs)
>  		goto err_uobj;
>  	}
>  
> +	wqs = NULL;
>  	rwq_ind_tbl->ind_tbl = wqs;
>  	rwq_ind_tbl->log_ind_tbl_size = init_attr.log_ind_tbl_size;
>  	rwq_ind_tbl->uobject = uobj;
> @@ -3121,7 +3092,7 @@ static int ib_uverbs_ex_create_rwq_ind_table(struct uverbs_attr_bundle *attrs)
>  
>  	err = uverbs_response(attrs, &resp, sizeof(resp));
>  	if (err)
> -		goto err_copy;
> +		goto err_uobj;
>  
>  	kfree(wqs_handles);
>  
> @@ -3130,8 +3101,6 @@ static int ib_uverbs_ex_create_rwq_ind_table(struct uverbs_attr_bundle *attrs)
>  
>  	return uobj_alloc_commit(uobj);
>  
> -err_copy:
> -	ib_destroy_rwq_ind_table(rwq_ind_tbl);
>  err_uobj:
>  	uobj_alloc_abort(uobj);
>  put_wqs:
> @@ -3293,23 +3262,20 @@ static int ib_uverbs_ex_create_flow(struct uverbs_attr_bundle *attrs)
>  		goto err_free;
>  	}
>  
> -	ib_set_flow(uobj, flow_id, qp, qp->device, uflow_res);
> -
>  	memset(&resp, 0, sizeof(resp));
>  	resp.flow_handle = uobj->id;
>  
>  	err = uverbs_response(attrs, &resp, sizeof(resp));
>  	if (err)
> -		goto err_copy;
> +		goto err_free;
> +
> +	ib_set_flow(uobj, flow_id, qp, qp->device, uflow_res);
>  
>  	uobj_put_obj_read(qp);
>  	kfree(flow_attr);
>  	if (cmd.flow_attr.num_of_specs)
>  		kfree(kern_flow_attr);
>  	return uobj_alloc_commit(uobj);
> -err_copy:
> -	if (!qp->device->ops.destroy_flow(flow_id))
> -		atomic_dec(&qp->usecnt);
>  err_free:
>  	ib_uverbs_flow_resources_free(uflow_res);
>  err_free_flow_attr:
> @@ -3441,7 +3407,7 @@ static int __uverbs_create_xsrq(struct uverbs_attr_bundle *attrs,
>  
>  	ret = uverbs_response(attrs, &resp, sizeof(resp));
>  	if (ret)
> -		goto err_copy;
> +		goto err;
>  
>  	if (cmd->srq_type == IB_SRQT_XRC)
>  		uobj_put_read(xrcd_uobj);
> @@ -3452,9 +3418,6 @@ static int __uverbs_create_xsrq(struct uverbs_attr_bundle *attrs,
>  	uobj_put_obj_read(pd);
>  	return uobj_alloc_commit(&obj->uevent.uobject);
>  
> -err_copy:
> -	ib_destroy_srq(srq);
> -
>  err_put:
>  	uobj_put_obj_read(pd);
>  
> diff --git a/drivers/infiniband/core/uverbs_std_types_counters.c b/drivers/infiniband/core/uverbs_std_types_counters.c
> index 309c5e80988d2e..9b096d7e36cf59 100644
> --- a/drivers/infiniband/core/uverbs_std_types_counters.c
> +++ b/drivers/infiniband/core/uverbs_std_types_counters.c
> @@ -54,7 +54,6 @@ static int UVERBS_HANDLER(UVERBS_METHOD_COUNTERS_CREATE)(
>  		attrs, UVERBS_ATTR_CREATE_COUNTERS_HANDLE);
>  	struct ib_device *ib_dev = uobj->context->device;
>  	struct ib_counters *counters;
> -	int ret;
>  
>  	/*
>  	 * This check should be removed once the infrastructure
> @@ -65,10 +64,8 @@ static int UVERBS_HANDLER(UVERBS_METHOD_COUNTERS_CREATE)(
>  		return -EOPNOTSUPP;
>  
>  	counters = ib_dev->ops.create_counters(ib_dev, attrs);
> -	if (IS_ERR(counters)) {
> -		ret = PTR_ERR(counters);
> -		goto err_create_counters;
> -	}
> +	if (IS_ERR(counters))
> +		return PTR_ERR(counters);
>  
>  	counters->device = ib_dev;
>  	counters->uobject = uobj;
> @@ -76,9 +73,6 @@ static int UVERBS_HANDLER(UVERBS_METHOD_COUNTERS_CREATE)(
>  	atomic_set(&counters->usecnt, 0);
>  
>  	return 0;
> -
> -err_create_counters:
> -	return ret;
>  }
>  
>  static int UVERBS_HANDLER(UVERBS_METHOD_COUNTERS_READ)(
> diff --git a/drivers/infiniband/core/uverbs_std_types_cq.c b/drivers/infiniband/core/uverbs_std_types_cq.c
> index a59ea89e3f2b06..f9f4c1460c7a58 100644
> --- a/drivers/infiniband/core/uverbs_std_types_cq.c
> +++ b/drivers/infiniband/core/uverbs_std_types_cq.c
> @@ -128,14 +128,8 @@ static int UVERBS_HANDLER(UVERBS_METHOD_CQ_CREATE)(
>  	cq->res.type = RDMA_RESTRACK_CQ;
>  	rdma_restrack_uadd(&cq->res);
>  
> -	ret = uverbs_copy_to(attrs, UVERBS_ATTR_CREATE_CQ_RESP_CQE, &cq->cqe,
> -			     sizeof(cq->cqe));
> -	if (ret)
> -		goto err_cq;
> -
> -	return 0;
> -err_cq:
> -	ib_destroy_cq(cq);
> +	return uverbs_copy_to(attrs, UVERBS_ATTR_CREATE_CQ_RESP_CQE, &cq->cqe,
> +			      sizeof(cq->cqe));
>  
>  err_event_file:
>  	if (ev_file)
> 
