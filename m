Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 357926ADDF2
	for <lists+linux-rdma@lfdr.de>; Tue,  7 Mar 2023 12:49:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230495AbjCGLtn (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 7 Mar 2023 06:49:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230497AbjCGLtR (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 7 Mar 2023 06:49:17 -0500
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A41052906;
        Tue,  7 Mar 2023 03:48:12 -0800 (PST)
Received: by mail-wm1-f50.google.com with SMTP id m25-20020a7bcb99000000b003e7842b75f2so7004772wmi.3;
        Tue, 07 Mar 2023 03:48:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678189641;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ra5PRdpIZQYUrJUUjlJ0BpmIbEosPgS6xoJWXVnRxug=;
        b=38dCkao6jwPFMQGq+341wqBt23DERf/N3AttbJ3nMRWb3usEvnEQ/NG8V/M9YKFLYW
         3M/TgUNilY2iq/4/6zfNMsQRUNpgcQ6Dk5rNgAh0eRUBmWWw2ZDy37AjOKOBFJUJp139
         /XIeF+hREckW0+kCKcmYTSdKmtymGnwKycEZXQ55HnaByVYebibpUfyOkQmT269nG2SC
         HGKPIqJi5e7iSe2dXtX7gXoxRIJwL0nWfy4nFmehg/6HGRIvH5SihhkoGFBJ+FJZmM4J
         LloM7R0RY0EJyVoD1+hKEM1N5NDtHxIzHPF4mx8k4rV8B843gMFTCmKELdN/BgVfVeUB
         14eg==
X-Gm-Message-State: AO0yUKXXmjUH7RwlZWWzPDBk+qbRVqGFnZpDV9f/PfKVqNqrJkQPWPOi
        IFUDKLWwBj9sXDaMCxPQWBw=
X-Google-Smtp-Source: AK7set9yAfRpPEt4dFOrNiqmptImiWJmNxGfpTo3fiZA+NAZYlVT6nbPvBpKUlmV67igW/KDg8SblA==
X-Received: by 2002:a05:600c:1c16:b0:3eb:2e2a:be95 with SMTP id j22-20020a05600c1c1600b003eb2e2abe95mr11080106wms.2.1678189641327;
        Tue, 07 Mar 2023 03:47:21 -0800 (PST)
Received: from [10.100.102.14] (46-116-231-83.bb.netvision.net.il. [46.116.231.83])
        by smtp.gmail.com with ESMTPSA id v7-20020a05600c444700b003eb0d6f48f3sm17782904wmn.27.2023.03.07.03.47.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Mar 2023 03:47:21 -0800 (PST)
Message-ID: <0731e4a4-0683-0b36-a0b7-a3e7fecf0e70@grimberg.me>
Date:   Tue, 7 Mar 2023 13:47:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH for-rc] IB/isert: Fix hang in iscsit_wait_for_tag
Content-Language: en-US
To:     "Saleem, Shiraz" <shiraz.saleem@intel.com>,
        "Devale, Sindhu" <sindhu.devale@intel.com>,
        "jgg@nvidia.com" <jgg@nvidia.com>,
        Mike Christie <michael.christie@oracle.com>
Cc:     "leon@kernel.org" <leon@kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "devel@vger.kernel.org" <devel@vger.kernel.org>,
        "Ismail, Mustafa" <mustafa.ismail@intel.com>,
        "Marciniszyn, Mike" <mike.marciniszyn@intel.com>,
        "target-devel@vger.kernel.org" <target-devel@vger.kernel.org>
References: <20230119210659.1871-1-shiraz.saleem@intel.com>
 <909684d4-f169-792b-7f84-ba18a6e19824@grimberg.me>
 <SA2PR11MB495347CE35C9ED97CD80C422F3CC9@SA2PR11MB4953.namprd11.prod.outlook.com>
 <SA2PR11MB4953D102791B458434A775FDF3D39@SA2PR11MB4953.namprd11.prod.outlook.com>
 <4df68538-6027-712b-8dac-e089d6f2192d@grimberg.me>
 <MWHPR11MB00294E08888B739ADB064BC2E9B79@MWHPR11MB0029.namprd11.prod.outlook.com>
From:   Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <MWHPR11MB00294E08888B739ADB064BC2E9B79@MWHPR11MB0029.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org



On 3/7/23 02:09, Saleem, Shiraz wrote:
>> Subject: Re: [PATCH for-rc] IB/isert: Fix hang in iscsit_wait_for_tag
>>
>>
>>
>> On 1/30/23 20:22, Devale, Sindhu wrote:
>>>
>>>
>>>> Subject: Re: [PATCH for-rc] IB/isert: Fix hang in iscsit_wait_for_tag
>>>>
>>>>
>>>>> From: Mustafa Ismail <mustafa.ismail@intel.com>
>>>>>
>>>>> Running fio can occasionally cause a hang when sbitmap_queue_get()
>>>>> fails to return a tag in iscsit_allocate_cmd() and
>>>>> iscsit_wait_for_tag() is called and will never return from the
>>>>> schedule(). This is because the polling thread of the CQ is
>>>>> suspended, and will not poll for a SQ completion which would free up a tag.
>>>>> Fix this by creating a separate CQ for the SQ so that send
>>>>> completions are processed on a separate thread and are not blocked
>>>>> when the RQ CQ is stalled.
>>>>>
>>>>> Fixes: 10e9cbb6b531 ("scsi: target: Convert target drivers to use
>>>>> sbitmap")
>>>>
>>>> Is this the real offending commit? What prevented this from happening
>>>> before?
>>>
>>> Maybe going to a global bitmap instead of per cpu ida makes it less likely to
>> occur.
>>> Going to single CQ maybe the real root cause in this
>>> commit:6f0fae3d7797("iser-target: Use single CQ for TX and RX")
>>
>> Yes this is more likely.
>>
>>>
>>>>> Reviewed-by: Mike Marciniszyn <mike.marciniszyn@intel.com>
>>>>> Signed-off-by: Mustafa Ismail <mustafa.ismail@intel.com>
>>>>> Signed-off-by: Shiraz Saleem <shiraz.saleem@intel.com>
>>>>> ---
>>>>>     drivers/infiniband/ulp/isert/ib_isert.c | 33
>>>>> +++++++++++++++++++++++--
>>>> --------
>>>>>     drivers/infiniband/ulp/isert/ib_isert.h |  3 ++-
>>>>>     2 files changed, 25 insertions(+), 11 deletions(-)
>>>>>
>>>>> diff --git a/drivers/infiniband/ulp/isert/ib_isert.c
>>>>> b/drivers/infiniband/ulp/isert/ib_isert.c
>>>>> index 7540488..f827b91 100644
>>>>> --- a/drivers/infiniband/ulp/isert/ib_isert.c
>>>>> +++ b/drivers/infiniband/ulp/isert/ib_isert.c
>>>>> @@ -109,19 +109,27 @@ static int isert_sg_tablesize_set(const char
>>>>> *val,
>>>> const struct kernel_param *kp
>>>>>     	struct ib_qp_init_attr attr;
>>>>>     	int ret, factor;
>>>>>
>>>>> -	isert_conn->cq = ib_cq_pool_get(ib_dev, cq_size, -1,
>>>> IB_POLL_WORKQUEUE);
>>>>> -	if (IS_ERR(isert_conn->cq)) {
>>>>> -		isert_err("Unable to allocate cq\n");
>>>>> -		ret = PTR_ERR(isert_conn->cq);
>>>>> +	isert_conn->snd_cq = ib_cq_pool_get(ib_dev, cq_size, -1,
>>>>> +					    IB_POLL_WORKQUEUE);
>>>>> +	if (IS_ERR(isert_conn->snd_cq)) {
>>>>> +		isert_err("Unable to allocate send cq\n");
>>>>> +		ret = PTR_ERR(isert_conn->snd_cq);
>>>>>     		return ERR_PTR(ret);
>>>>>     	}
>>>>> +	isert_conn->rcv_cq = ib_cq_pool_get(ib_dev, cq_size, -1,
>>>>> +					    IB_POLL_WORKQUEUE);
>>>>> +	if (IS_ERR(isert_conn->rcv_cq)) {
>>>>> +		isert_err("Unable to allocate receive cq\n");
>>>>> +		ret = PTR_ERR(isert_conn->rcv_cq);
>>>>> +		goto create_cq_err;
>>>>> +	}
>>>>
>>>> Does this have any noticeable performance implications?
>>>
>>> Initial testing seems to indicate this change causes significant performance
>> variability specifically only with 2K Writes.
>>> We suspect that may be due an unfortunate vector placement where the
>> snd_cq and rcv_cq are on different numa nodes.
>>> We can, in the patch, alter the second CQ creation to pass comp_vector to
>> insure they are hinted to the same affinity.
>>
>> Even so, still there are now two competing threads for completion processing.
>>
>>>
>>>> Also I wander if there are any other assumptions in the code for
>>>> having a single context processing completions...
>>>
>>> We don't see any.
>>>
>>>> It'd be much easier if iscsi_allocate_cmd could accept a timeout to fail...
>>>>
>>>> CCing target-devel and Mike.
>>>
>>> Do you mean add a timeout to the wait or removing the call
>> to iscsit_wait_for_tag() iscsit_allocate_cmd()?
>>
>> Looking at the code, passing it TASK_RUNNING will make it fail if there no
>> available tag (and hence drop the received command, let the initiator retry). But I
>> also think that isert may need a deeper default queue depth...
> 
> Hi Sagi -
> 
> 
> Mustafa reports - "The problem is not easily reproduced, so I reduce the amount of map_tags allocated when I testing a potential fix. Passing TASK_RUNNING and I got the following call trace:
> 
> [  220.131709] isert: isert_allocate_cmd: Unable to allocate iscsit_cmd + isert_cmd
> [  220.131712] isert: isert_allocate_cmd: Unable to allocate iscsit_cmd + isert_cmd
> [  280.862544] ABORT_TASK: Found referenced iSCSI task_tag: 70
> [  313.265156] iSCSI Login timeout on Network Portal 5.1.1.21:3260
> [  334.769268] INFO: task kworker/32:3:1285 blocked for more than 30 seconds.
> [  334.769272]       Tainted: G           OE      6.2.0-rc3 #6
> [  334.769274] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> [  334.769275] task:kworker/32:3    state:D stack:0     pid:1285  ppid:2      flags:0x00004000
> [  334.769279] Workqueue: events target_tmr_work [target_core_mod]
> [  334.769307] Call Trace:
> [  334.769308]  <TASK>
> [  334.769310]  __schedule+0x318/0xa30
> [  334.769316]  ? _prb_read_valid+0x22e/0x2b0
> [  334.769319]  ? __pfx_schedule_timeout+0x10/0x10
> [  334.769322]  ? __wait_for_common+0xd3/0x1e0
> [  334.769323]  schedule+0x57/0xd0
> [  334.769325]  schedule_timeout+0x273/0x320
> [  334.769327]  ? __irq_work_queue_local+0x39/0x80
> [  334.769330]  ? irq_work_queue+0x3f/0x60
> [  334.769332]  ? __pfx_schedule_timeout+0x10/0x10
> [  334.769333]  __wait_for_common+0xf9/0x1e0
> [  334.769335]  target_put_cmd_and_wait+0x59/0x80 [target_core_mod]
> [  334.769351]  core_tmr_abort_task.cold.8+0x187/0x202 [target_core_mod]
> [  334.769369]  target_tmr_work+0xa1/0x110 [target_core_mod]
> [  334.769384]  process_one_work+0x1b0/0x390
> [  334.769387]  worker_thread+0x40/0x380
> [  334.769389]  ? __pfx_worker_thread+0x10/0x10
> [  334.769391]  kthread+0xfa/0x120
> [  334.769393]  ? __pfx_kthread+0x10/0x10
> [  334.769395]  ret_from_fork+0x29/0x50
> [  334.769399]  </TASK>
> [  334.769442] INFO: task iscsi_np:5337 blocked for more than 30 seconds.
> [  334.769444]       Tainted: G           OE      6.2.0-rc3 #6
> [  334.769444] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> [  334.769445] task:iscsi_np        state:D stack:0     pid:5337  ppid:2      flags:0x00004004
> [  334.769447] Call Trace:
> [  334.769447]  <TASK>
> [  334.769448]  __schedule+0x318/0xa30
> [  334.769451]  ? __pfx_schedule_timeout+0x10/0x10
> [  334.769453]  ? __wait_for_common+0xd3/0x1e0
> [  334.769454]  schedule+0x57/0xd0
> [  334.769456]  schedule_timeout+0x273/0x320
> [  334.769459]  ? iscsi_update_param_value+0x27/0x70 [iscsi_target_mod]
> [  334.769476]  ? __kmalloc_node_track_caller+0x52/0x130
> [  334.769478]  ? __pfx_schedule_timeout+0x10/0x10
> [  334.769480]  __wait_for_common+0xf9/0x1e0
> [  334.769481]  iscsi_check_for_session_reinstatement+0x1e8/0x280 [iscsi_target_mod]
> [  334.769496]  iscsi_target_do_login+0x23b/0x570 [iscsi_target_mod]
> [  334.769508]  iscsi_target_start_negotiation+0x55/0xc0 [iscsi_target_mod]
> [  334.769519]  iscsi_target_login_thread+0x675/0xeb0 [iscsi_target_mod]
> [  334.769531]  ? __pfx_iscsi_target_login_thread+0x10/0x10 [iscsi_target_mod]
> [  334.769541]  kthread+0xfa/0x120
> [  334.769543]  ? __pfx_kthread+0x10/0x10
> [  334.769544]  ret_from_fork+0x29/0x50
> [  334.769547]  </TASK>
> 
> 
> [  185.734571] isert: isert_allocate_cmd: Unable to allocate iscsit_cmd + isert_cmd
> [  246.032360] ABORT_TASK: Found referenced iSCSI task_tag: 75
> [  278.442726] iSCSI Login timeout on Network Portal 5.1.1.21:3260
> 
> 
> By the way increasing tag_num in iscsi_target_locate_portal() will also avoid the issue"
> 
> Any thoughts on what could be causing this hang?

I know that Mike just did a set of fixes on the session teardown area...
Perhaps you should try with the patchset "target: TMF and recovery
fixes" applied?
