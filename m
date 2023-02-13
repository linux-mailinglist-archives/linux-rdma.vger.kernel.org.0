Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A44C694464
	for <lists+linux-rdma@lfdr.de>; Mon, 13 Feb 2023 12:27:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230334AbjBML1V (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 13 Feb 2023 06:27:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229802AbjBML1U (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 13 Feb 2023 06:27:20 -0500
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CFD21630B;
        Mon, 13 Feb 2023 03:27:19 -0800 (PST)
Received: by mail-wm1-f53.google.com with SMTP id k8-20020a05600c1c8800b003dc57ea0dfeso11046264wms.0;
        Mon, 13 Feb 2023 03:27:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1676287637;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hIL3XzSoAZq5kfhV936ehGclWBEQc0HJLgA3mlziLPo=;
        b=4jE1L15Sa1lCyDJWtZVPNgZsO/gXosNN0EO695wgF2RO/09XbQm/YkQaJGmPKXVfhH
         +lBEf182NJXX+5M4gI7llDMFw6I7nBbu5i0xJhj+DNVKvmA0voQue9d1f41s/vzR0P6S
         O3r/g1rpUUyeZBsh5dIfTqCUSNLdvMYitAbMy4VUpOQrzw23g7+eM94Zo7Cp1FIqNckY
         VxunClwcPGpzyolbNK1R2VFdha4qHgX26Mvbb62dh7N8x1ptrNjbbJ/zmSB8AqP032Sv
         vd4jp8AUot75AA206ZXAIzCU9/DrkhKnU/i5iAn9d7AK9bBhQ4cdeTpoRLbffN3ctjDu
         E69g==
X-Gm-Message-State: AO0yUKXRfE9OSAH10G0XnQbtCReMI4uAyalFsM7p2c5JeNEJv1ILYgUD
        0CcJAm4ptwn4wrlt5i15IkQ=
X-Google-Smtp-Source: AK7set+9ggo2RmRzo1bjD8lgyGtevFIEQNmJcjhf1O/ZtMZZx81zgsVneg25D1/QTbtsgk/VhG4x3g==
X-Received: by 2002:a05:600c:3ca5:b0:3df:f7ba:14f8 with SMTP id bg37-20020a05600c3ca500b003dff7ba14f8mr22660152wmb.1.1676287637812;
        Mon, 13 Feb 2023 03:27:17 -0800 (PST)
Received: from [192.168.64.80] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id h33-20020a05600c49a100b003dc54eef495sm12841710wmp.24.2023.02.13.03.27.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Feb 2023 03:27:17 -0800 (PST)
Message-ID: <4df68538-6027-712b-8dac-e089d6f2192d@grimberg.me>
Date:   Mon, 13 Feb 2023 13:27:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH for-rc] IB/isert: Fix hang in iscsit_wait_for_tag
Content-Language: en-US
To:     "Devale, Sindhu" <sindhu.devale@intel.com>,
        "Saleem, Shiraz" <shiraz.saleem@intel.com>,
        "jgg@nvidia.com" <jgg@nvidia.com>
Cc:     "leon@kernel.org" <leon@kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "devel@vger.kernel.org" <devel@vger.kernel.org>,
        Mike Christie <michael.christie@oracle.com>,
        "Ismail, Mustafa" <mustafa.ismail@intel.com>,
        "Marciniszyn, Mike" <mike.marciniszyn@intel.com>,
        "target-devel@vger.kernel.org" <target-devel@vger.kernel.org>
References: <20230119210659.1871-1-shiraz.saleem@intel.com>
 <909684d4-f169-792b-7f84-ba18a6e19824@grimberg.me>
 <SA2PR11MB495347CE35C9ED97CD80C422F3CC9@SA2PR11MB4953.namprd11.prod.outlook.com>
 <SA2PR11MB4953D102791B458434A775FDF3D39@SA2PR11MB4953.namprd11.prod.outlook.com>
From:   Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <SA2PR11MB4953D102791B458434A775FDF3D39@SA2PR11MB4953.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org



On 1/30/23 20:22, Devale, Sindhu wrote:
> 
> 
>> Subject: Re: [PATCH for-rc] IB/isert: Fix hang in iscsit_wait_for_tag
>>
>>
>>> From: Mustafa Ismail <mustafa.ismail@intel.com>
>>>
>>> Running fio can occasionally cause a hang when sbitmap_queue_get()
>>> fails to return a tag in iscsit_allocate_cmd() and
>>> iscsit_wait_for_tag() is called and will never return from the
>>> schedule(). This is because the polling thread of the CQ is suspended,
>>> and will not poll for a SQ completion which would free up a tag.
>>> Fix this by creating a separate CQ for the SQ so that send completions
>>> are processed on a separate thread and are not blocked when the RQ CQ
>>> is stalled.
>>>
>>> Fixes: 10e9cbb6b531 ("scsi: target: Convert target drivers to use
>>> sbitmap")
>>
>> Is this the real offending commit? What prevented this from happening
>> before?
> 
> Maybe going to a global bitmap instead of per cpu ida makes it less likely to occur.
> Going to single CQ maybe the real root cause in this commit:6f0fae3d7797("iser-target: Use single CQ for TX and RX")

Yes this is more likely.

> 
>>> Reviewed-by: Mike Marciniszyn <mike.marciniszyn@intel.com>
>>> Signed-off-by: Mustafa Ismail <mustafa.ismail@intel.com>
>>> Signed-off-by: Shiraz Saleem <shiraz.saleem@intel.com>
>>> ---
>>>    drivers/infiniband/ulp/isert/ib_isert.c | 33 +++++++++++++++++++++++--
>> --------
>>>    drivers/infiniband/ulp/isert/ib_isert.h |  3 ++-
>>>    2 files changed, 25 insertions(+), 11 deletions(-)
>>>
>>> diff --git a/drivers/infiniband/ulp/isert/ib_isert.c
>>> b/drivers/infiniband/ulp/isert/ib_isert.c
>>> index 7540488..f827b91 100644
>>> --- a/drivers/infiniband/ulp/isert/ib_isert.c
>>> +++ b/drivers/infiniband/ulp/isert/ib_isert.c
>>> @@ -109,19 +109,27 @@ static int isert_sg_tablesize_set(const char *val,
>> const struct kernel_param *kp
>>>    	struct ib_qp_init_attr attr;
>>>    	int ret, factor;
>>>
>>> -	isert_conn->cq = ib_cq_pool_get(ib_dev, cq_size, -1,
>> IB_POLL_WORKQUEUE);
>>> -	if (IS_ERR(isert_conn->cq)) {
>>> -		isert_err("Unable to allocate cq\n");
>>> -		ret = PTR_ERR(isert_conn->cq);
>>> +	isert_conn->snd_cq = ib_cq_pool_get(ib_dev, cq_size, -1,
>>> +					    IB_POLL_WORKQUEUE);
>>> +	if (IS_ERR(isert_conn->snd_cq)) {
>>> +		isert_err("Unable to allocate send cq\n");
>>> +		ret = PTR_ERR(isert_conn->snd_cq);
>>>    		return ERR_PTR(ret);
>>>    	}
>>> +	isert_conn->rcv_cq = ib_cq_pool_get(ib_dev, cq_size, -1,
>>> +					    IB_POLL_WORKQUEUE);
>>> +	if (IS_ERR(isert_conn->rcv_cq)) {
>>> +		isert_err("Unable to allocate receive cq\n");
>>> +		ret = PTR_ERR(isert_conn->rcv_cq);
>>> +		goto create_cq_err;
>>> +	}
>>
>> Does this have any noticeable performance implications?
> 
> Initial testing seems to indicate this change causes significant performance variability specifically only with 2K Writes.
> We suspect that may be due an unfortunate vector placement where the snd_cq and rcv_cq are on different numa nodes.
> We can, in the patch, alter the second CQ creation to pass comp_vector to insure they are hinted to the same affinity.

Even so, still there are now two competing threads for completion
processing.

> 
>> Also I wander if there are any other assumptions in the code for having a
>> single context processing completions...
> 
> We don't see any.
> 
>> It'd be much easier if iscsi_allocate_cmd could accept a timeout to fail...
>>
>> CCing target-devel and Mike.
> 
> Do you mean add a timeout to the wait or removing the call to iscsit_wait_for_tag() iscsit_allocate_cmd()?

Looking at the code, passing it TASK_RUNNING will make it fail if there
no available tag (and hence drop the received command, let the initiator
retry). But I also think that isert may need a deeper default queue
depth...
