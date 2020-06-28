Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B9F720C75B
	for <lists+linux-rdma@lfdr.de>; Sun, 28 Jun 2020 12:08:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726069AbgF1KI2 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 28 Jun 2020 06:08:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725928AbgF1KI1 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 28 Jun 2020 06:08:27 -0400
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CCB5C061794
        for <linux-rdma@vger.kernel.org>; Sun, 28 Jun 2020 03:08:27 -0700 (PDT)
Received: by mail-ej1-x644.google.com with SMTP id w16so13398246ejj.5
        for <linux-rdma@vger.kernel.org>; Sun, 28 Jun 2020 03:08:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dev-mellanox-co-il.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=/4aHcL8MjWuJ+fnUvvGreMseIkiBGE+HfI0c/fiXd8o=;
        b=ngQBWQAN1PdUWSajgxxeefZnchloj2Z3nXcyxvNrnTzqRu8QvlyXJ5zFWy5PIE3je1
         f4Grwq8Hq5KuJvIW+3lTNDSJqOw1tw9iP7X2o9w/9tT0rd+Tzo5u/dLATj/N8HoEX+JH
         V6Uc6rT79z3uf/UbgIJ0bbKo2LwOePupEgaoNEMNaIlqLwGbcKoyNM/3uawCKfXXg/5S
         VKDALXDDOXNNumCvh1H4te+TOPJGNAWrPboWDWxG+ExPnxrbjLb+A1iHST+2l3VQyOAi
         OW0EeXRJQEUsxe2i9Rz/82I3vKgzwEeV0QKDGJpOYOLAAuJX6tS5+uxv5KIQuGLmvIGv
         MuKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=/4aHcL8MjWuJ+fnUvvGreMseIkiBGE+HfI0c/fiXd8o=;
        b=i4uqK3DsaeLr+jdDX2CVGxV8myjs3HLBGMj93p+0RojPqt24Oilfm/yXsAwp0RmgRF
         2Oc76jbt+BCMJc7smG2WcVko8CkTumG5tuZ8O4pEbVBRhW6oROshidwgduf690FibIsf
         gc5Pn346VKrtwsJgvtQpTASAmpEVkQfKvDE++cUyIltgb+KHvoS0nhEnzJz7EidLWOpU
         honxcCBWNn0A6HKulOKCAIv6tPKo49knglrKy/7BL6jvv8yLyinhaA/0wpNFMfuXn7Bc
         w8ysA0fFQyRythbMibwu7rLyI2d6tltLJX1g8dkyBRFHpWaF9MqHCoiyAzBKSj4Yk7ZE
         mycw==
X-Gm-Message-State: AOAM5324+JuCeTQAt1snDAXBFbQ7xELUqnxHf7wBsegjZR6L3JUJzx0h
        +M67G0KspH0Q0LpLUSTMdWlkMA==
X-Google-Smtp-Source: ABdhPJyMCYkobaCHEp+WaOYQfCPWvhGDYb/8BOUsorPDm0wqLAFpaWKrf/NzM7tQU2LrWi2fIz5xFw==
X-Received: by 2002:a17:906:7283:: with SMTP id b3mr10029180ejl.163.1593338905877;
        Sun, 28 Jun 2020 03:08:25 -0700 (PDT)
Received: from [10.0.0.57] ([141.226.208.144])
        by smtp.googlemail.com with ESMTPSA id f17sm10138925ejr.71.2020.06.28.03.08.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 28 Jun 2020 03:08:25 -0700 (PDT)
Subject: Re: [PATCH rdma-next 5/5] RDMA/core: Convert RWQ table logic to
 ib_core allocation scheme
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>, linux-rdma@vger.kernel.org,
        Yishai Hadas <yishaih@mellanox.com>,
        Maor Gottlieb <maorg@mellanox.com>
References: <20200624105422.1452290-1-leon@kernel.org>
 <20200624105422.1452290-6-leon@kernel.org>
 <71aa016a-a212-24b8-0d4c-e254635ea744@dev.mellanox.co.il>
 <20200628094113.GC6281@unreal>
From:   Yishai Hadas <yishaih@dev.mellanox.co.il>
Message-ID: <70727e67-b5dd-e90a-afb6-718d6f59eec3@dev.mellanox.co.il>
Date:   Sun, 28 Jun 2020 13:08:24 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200628094113.GC6281@unreal>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 6/28/2020 12:41 PM, Leon Romanovsky wrote:
> On Sun, Jun 28, 2020 at 12:11:41PM +0300, Yishai Hadas wrote:
>> On 6/24/2020 1:54 PM, Leon Romanovsky wrote:
>>> From: Leon Romanovsky <leonro@mellanox.com>
>>>
>>> Move struct ib_rwq_ind_table allocation to ib_core.
>>>
>>> Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
>>> ---
>>>    drivers/infiniband/core/device.c           |  1 +
>>>    drivers/infiniband/core/uverbs_cmd.c       | 37 ++++++++++++-------
>>>    drivers/infiniband/core/uverbs_std_types.c | 13 ++++++-
>>>    drivers/infiniband/core/verbs.c            | 25 +------------
>>>    drivers/infiniband/hw/mlx4/main.c          |  4 +-
>>>    drivers/infiniband/hw/mlx4/mlx4_ib.h       | 12 +++---
>>>    drivers/infiniband/hw/mlx4/qp.c            | 40 ++++++--------------
>>>    drivers/infiniband/hw/mlx5/main.c          |  3 ++
>>>    drivers/infiniband/hw/mlx5/mlx5_ib.h       |  8 ++--
>>>    drivers/infiniband/hw/mlx5/qp.c            | 43 +++++++++-------------
>>>    include/rdma/ib_verbs.h                    | 11 +++---
>>>    11 files changed, 86 insertions(+), 111 deletions(-)
>>>
>>> diff --git a/drivers/infiniband/core/device.c b/drivers/infiniband/core/device.c
>>> index b15fa3fa09ac..85d921c8e2b5 100644
>>> --- a/drivers/infiniband/core/device.c
>>> +++ b/drivers/infiniband/core/device.c
>>> @@ -2686,6 +2686,7 @@ void ib_set_device_ops(struct ib_device *dev, const struct ib_device_ops *ops)
>>>    	SET_OBJ_SIZE(dev_ops, ib_cq);
>>>    	SET_OBJ_SIZE(dev_ops, ib_mw);
>>>    	SET_OBJ_SIZE(dev_ops, ib_pd);
>>> +	SET_OBJ_SIZE(dev_ops, ib_rwq_ind_table);
>>>    	SET_OBJ_SIZE(dev_ops, ib_srq);
>>>    	SET_OBJ_SIZE(dev_ops, ib_ucontext);
>>>    	SET_OBJ_SIZE(dev_ops, ib_xrcd);
>>> diff --git a/drivers/infiniband/core/uverbs_cmd.c b/drivers/infiniband/core/uverbs_cmd.c
>>> index a5301f3d3059..a83d11d1e3ee 100644
>>> --- a/drivers/infiniband/core/uverbs_cmd.c
>>> +++ b/drivers/infiniband/core/uverbs_cmd.c
>>> @@ -3090,13 +3090,13 @@ static int ib_uverbs_ex_create_rwq_ind_table(struct uverbs_attr_bundle *attrs)
>>>    {
>>>    	struct ib_uverbs_ex_create_rwq_ind_table cmd;
>>>    	struct ib_uverbs_ex_create_rwq_ind_table_resp  resp = {};
>>> -	struct ib_uobject		  *uobj;
>>> +	struct ib_uobject *uobj;
>>>    	int err;
>>>    	struct ib_rwq_ind_table_init_attr init_attr = {};
>>>    	struct ib_rwq_ind_table *rwq_ind_tbl;
>>> -	struct ib_wq	**wqs = NULL;
>>> +	struct ib_wq **wqs = NULL;
>>>    	u32 *wqs_handles = NULL;
>>> -	struct ib_wq	*wq = NULL;
>>> +	struct ib_wq *wq = NULL;
>>>    	int i, j, num_read_wqs;
>>>    	u32 num_wq_handles;
>>>    	struct uverbs_req_iter iter;
>>> @@ -3151,17 +3151,15 @@ static int ib_uverbs_ex_create_rwq_ind_table(struct uverbs_attr_bundle *attrs)
>>>    		goto put_wqs;
>>>    	}
>>> -	init_attr.log_ind_tbl_size = cmd.log_ind_tbl_size;
>>> -	init_attr.ind_tbl = wqs;
>>> -
>>> -	rwq_ind_tbl = ib_dev->ops.create_rwq_ind_table(ib_dev, &init_attr,
>>> -						       &attrs->driver_udata);
>>> -
>>> -	if (IS_ERR(rwq_ind_tbl)) {
>>> -		err = PTR_ERR(rwq_ind_tbl);
>>> +	rwq_ind_tbl = rdma_zalloc_drv_obj(ib_dev, ib_rwq_ind_table);
>>> +	if (!rwq_ind_tbl) {
>>> +		err = -ENOMEM;
>>>    		goto err_uobj;
>>>    	}
>>> +	init_attr.log_ind_tbl_size = cmd.log_ind_tbl_size;
>>> +	init_attr.ind_tbl = wqs;
>>> +
>>>    	rwq_ind_tbl->ind_tbl = wqs;
>>>    	rwq_ind_tbl->log_ind_tbl_size = init_attr.log_ind_tbl_size;
>>>    	rwq_ind_tbl->uobject = uobj;
>>> @@ -3169,6 +3167,12 @@ static int ib_uverbs_ex_create_rwq_ind_table(struct uverbs_attr_bundle *attrs)
>>>    	rwq_ind_tbl->device = ib_dev;
>>>    	atomic_set(&rwq_ind_tbl->usecnt, 0);
>>> +	err = ib_dev->ops.create_rwq_ind_table(rwq_ind_tbl, &init_attr,
>>> +					       &rwq_ind_tbl->ind_tbl_num,
>>> +					       &attrs->driver_udata);
>>> +	if (err)
>>> +		goto err_create;
>>> +
>>>    	for (i = 0; i < num_wq_handles; i++)
>>>    		atomic_inc(&wqs[i]->usecnt);
>>> @@ -3190,7 +3194,13 @@ static int ib_uverbs_ex_create_rwq_ind_table(struct uverbs_attr_bundle *attrs)
>>>    	return 0;
>>>    err_copy:
>>> -	ib_destroy_rwq_ind_table(rwq_ind_tbl);
>>> +	for (i = 0; i < num_wq_handles; i++)
>>> +		atomic_dec(&wqs[i]->usecnt);
>>> +
>>> +	if (ib_dev->ops.destroy_rwq_ind_table)
>>> +		ib_dev->ops.destroy_rwq_ind_table(rwq_ind_tbl);
>>> +err_create:
>>> +	kfree(rwq_ind_tbl);
>>>    err_uobj:
>>>    	uobj_alloc_abort(uobj, attrs);
>>>    put_wqs:
>>> @@ -4018,8 +4028,7 @@ const struct uapi_definition uverbs_def_write_intf[] = {
>>>    			IB_USER_VERBS_EX_CMD_DESTROY_RWQ_IND_TBL,
>>>    			ib_uverbs_ex_destroy_rwq_ind_table,
>>>    			UAPI_DEF_WRITE_I(
>>> -				struct ib_uverbs_ex_destroy_rwq_ind_table),
>>> -			UAPI_DEF_METHOD_NEEDS_FN(destroy_rwq_ind_table))),
>>> +				struct ib_uverbs_ex_destroy_rwq_ind_table))),
>>>    	DECLARE_UVERBS_OBJECT(
>>>    		UVERBS_OBJECT_WQ,
>>> diff --git a/drivers/infiniband/core/uverbs_std_types.c b/drivers/infiniband/core/uverbs_std_types.c
>>> index e4994cc4cc51..cd82a5a80bdf 100644
>>> --- a/drivers/infiniband/core/uverbs_std_types.c
>>> +++ b/drivers/infiniband/core/uverbs_std_types.c
>>> @@ -82,12 +82,21 @@ static int uverbs_free_rwq_ind_tbl(struct ib_uobject *uobject,
>>>    {
>>>    	struct ib_rwq_ind_table *rwq_ind_tbl = uobject->object;
>>>    	struct ib_wq **ind_tbl = rwq_ind_tbl->ind_tbl;
>>> -	int ret;
>>> +	u32 table_size = (1 << rwq_ind_tbl->log_ind_tbl_size);
>>> +	int ret = 0, i;
>>> +
>>> +	if (atomic_read(&rwq_ind_tbl->usecnt))
>>> +		ret = -EBUSY;
>>> -	ret = ib_destroy_rwq_ind_table(rwq_ind_tbl);
>>>    	if (ib_is_destroy_retryable(ret, why, uobject))
>>>    		return ret;
>>> +	for (i = 0; i < table_size; i++)
>>> +		atomic_dec(&ind_tbl[i]->usecnt);
>>> +
>>
>> Upon destroy we first expect to destroy the object that is pointing to other
>> objetcs and only then descraese their ref count, this was the orignal logic
>> here. (See also ib_destroy_qp_user(), ib_destroy_wq() and others).
> 
> It is a bug, proper logic is to allocate HW object, elevate reference
> counting, decrease reference counter and deallocate HW object.
> 

I don't agree, only upon a succesfull destroy the we can go a ahead and 
safely decraese ref count from the pointed objects. This pevents any 
race from parallel desctrcution of the pointed object and consider any 
potenaial failure on the original object before decaresing ref counts as 
of in the QP case.

> Everything else should be fixed too.

I beleive that this patch should be fixed and not all other places.
By the way, see your previous patch from this series regarding MW that 
follows same logic, first dealloc_mw() and only then does atomic_dec() 
on the pointed PD.

> 
>>
>>> +	if (rwq_ind_tbl->device->ops.destroy_rwq_ind_table)
>>> +		rwq_ind_tbl->device->ops.destroy_rwq_ind_table(rwq_ind_tbl);
>>
>> This doesn't really make sense, if no destroy function was set, the
>> allocation should be prevented as well.
> 
> Should we delete mlx4 RWQ implementation too?
> After this refactoring, mlx4 won't have .destroy_rwq_ind_table.
> 

We can expect from symetric reasons to have always alloc/destroy from 
drivers point of view. The IB layer will not check whether the destroy 
function exist but will always call it, the driver in its turn may do 
nothing.

Yishai
