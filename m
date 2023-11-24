Return-Path: <linux-rdma+bounces-74-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 25A337F7657
	for <lists+linux-rdma@lfdr.de>; Fri, 24 Nov 2023 15:29:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4DE481C210A1
	for <lists+linux-rdma@lfdr.de>; Fri, 24 Nov 2023 14:29:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0FDF2C1B7;
	Fri, 24 Nov 2023 14:29:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b="gTf2VwWs"
X-Original-To: linux-rdma@vger.kernel.org
Received: from m15.mail.126.com (m15.mail.126.com [45.254.50.224])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2EC6E199B;
	Fri, 24 Nov 2023 06:29:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:From:
	Content-Type; bh=1+GDZ56cch6chx8Q0eFyp6YcBjnDxD6iAU8M1CHMcoo=;
	b=gTf2VwWsekr/uKsX23ZR9KzF3F63yYz7Q/abazOHmmYLpUrrv3Qs8QcJ9ZoGt8
	NPBRemwfukzPjDRmKmd1aJxXgkwyTwent1p77y7M7mcnprsCBvf+6qRQuBgZoAkD
	r+ScRi9qTwXz8goefsooa8ie9vKE3qyFTURyGqQ+UpEC0=
Received: from [172.23.69.7] (unknown [121.32.254.149])
	by zwqz-smtp-mta-g1-0 (Coremail) with SMTP id _____wAXnoYts2BlcFQgDA--.21753S2;
	Fri, 24 Nov 2023 22:29:03 +0800 (CST)
Message-ID: <15f80347-e9e9-49f9-bcab-784974856332@126.com>
Date: Fri, 24 Nov 2023 22:28:58 +0800
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] RDMA/irdma: Avoid free the non-cqp_request scratch
To: "Ismail, Mustafa" <mustafa.ismail@intel.com>
Cc: "Saleem, Shiraz" <shiraz.saleem@intel.com>, "jgg@ziepe.ca"
 <jgg@ziepe.ca>, "leon@kernel.org" <leon@kernel.org>,
 "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "Ding, Hui" <dinghui@sangfor.com.cn>
References: <20231120083122.78532-1-lishifeng1992@126.com>
 <PH7PR11MB6403F06E4A2984375BF121758BBBA@PH7PR11MB6403.namprd11.prod.outlook.com>
From: Shifeng Li <lishifeng1992@126.com>
In-Reply-To: <PH7PR11MB6403F06E4A2984375BF121758BBBA@PH7PR11MB6403.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:_____wAXnoYts2BlcFQgDA--.21753S2
X-Coremail-Antispam: 1Uf129KBjvJXoW3XF1xJF4kWF1DZw1DZFWxtFb_yoW7Xr1xpr
	48Jr12krWFvrW5Kw17C3s8AFyUJr4jyas7JFsFy34ayw1Uuw1YqF18ArW09rnxAr1xJF4x
	Jr1DXr4vvr1akaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UceOXUUUUU=
X-CM-SenderInfo: xolvxx5ihqwiqzzsqiyswou0bp/1S2mthEyr1pD4TUlwwAAsR

On 2023/11/22 1:25, Ismail, Mustafa wrote:
>> -----Original Message-----
>> From: Shifeng Li <lishifeng1992@126.com>
>> Sent: Monday, November 20, 2023 2:31 AM
>> To: Ismail, Mustafa <mustafa.ismail@intel.com>
>> Cc: Saleem, Shiraz <shiraz.saleem@intel.com>; jgg@ziepe.ca;
>> leon@kernel.org; linux-rdma@vger.kernel.org; linux-kernel@vger.kernel.org;
>> Ding, Hui <dinghui@sangfor.com.cn>; Shifeng Li <lishifeng1992@126.com>
>> Subject: [PATCH] RDMA/irdma: Avoid free the non-cqp_request scratch
>>
>> When creating ceq_0 during probing irdma, cqp.sc_cqp will be sent as a
>> cqp_request to cqp->sc_cqp.sq_ring. If the request is pending when removing
>> the irdma driver or unplugging its aux device, cqp.sc_cqp will be dereferenced
>> as wrong struct in irdma_free_pending_cqp_request().
>>
>> crash> bt 3669
>> PID: 3669   TASK: ffff88aef892c000  CPU: 28  COMMAND: "kworker/28:0"
>>   #0 [fffffe0000549e38] crash_nmi_callback at ffffffff810e3a34
>>   #1 [fffffe0000549e40] nmi_handle at ffffffff810788b2
>>   #2 [fffffe0000549ea0] default_do_nmi at ffffffff8107938f
>>   #3 [fffffe0000549eb8] do_nmi at ffffffff81079582
>>   #4 [fffffe0000549ef0] end_repeat_nmi at ffffffff82e016b4
>>      [exception RIP: native_queued_spin_lock_slowpath+1291]
>>      RIP: ffffffff8127e72b  RSP: ffff88aa841ef778  RFLAGS: 00000046
>>      RAX: 0000000000000000  RBX: ffff88b01f849700  RCX: ffffffff8127e47e
>>      RDX: 0000000000000000  RSI: 0000000000000004  RDI: ffffffff83857ec0
>>      RBP: ffff88afe3e4efc8   R8: ffffed15fc7c9dfa   R9: ffffed15fc7c9dfa
>>      R10: 0000000000000001  R11: ffffed15fc7c9df9  R12: 0000000000740000
>>      R13: ffff88b01f849708  R14: 0000000000000003  R15: ffffed1603f092e1
>>      ORIG_RAX: ffffffffffffffff  CS: 0010  SS: 0000
>> --- <NMI exception stack> ---
>>   #5 [ffff88aa841ef778] native_queued_spin_lock_slowpath at ffffffff8127e72b
>>   #6 [ffff88aa841ef7b0] _raw_spin_lock_irqsave at ffffffff82c22aa4
>>   #7 [ffff88aa841ef7c8] __wake_up_common_lock at ffffffff81257363
>>   #8 [ffff88aa841ef888] irdma_free_pending_cqp_request at ffffffffa0ba12cc
>> [irdma]
>>   #9 [ffff88aa841ef958] irdma_cleanup_pending_cqp_op at ffffffffa0ba1469
>> [irdma]
>>   #10 [ffff88aa841ef9c0] irdma_ctrl_deinit_hw at ffffffffa0b2989f [irdma]
>>   #11 [ffff88aa841efa28] irdma_remove at ffffffffa0b252df [irdma]
>>   #12 [ffff88aa841efae8] auxiliary_bus_remove at ffffffff8219afdb
>>   #13 [ffff88aa841efb00] device_release_driver_internal at ffffffff821882e6
>>   #14 [ffff88aa841efb38] bus_remove_device at ffffffff82184278
>>   #15 [ffff88aa841efb88] device_del at ffffffff82179d23
>>   #16 [ffff88aa841efc48] ice_unplug_aux_dev at ffffffffa0eb1c14 [ice]
>>   #17 [ffff88aa841efc68] ice_service_task at ffffffffa0d88201 [ice]
>>   #18 [ffff88aa841efde8] process_one_work at ffffffff811c589a
>>   #19 [ffff88aa841efe60] worker_thread at ffffffff811c71ff
>>   #20 [ffff88aa841eff10] kthread at ffffffff811d87a0
>>   #21 [ffff88aa841eff50] ret_from_fork at ffffffff82e0022f
>>
>> Fixes: 44d9e52977a1 ("RDMA/irdma: Implement device initialization
>> definitions")
>> Signed-off-by: Shifeng Li <lishifeng1992@126.com>
>> ---
>>   drivers/infiniband/hw/irdma/utils.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/infiniband/hw/irdma/utils.c
>> b/drivers/infiniband/hw/irdma/utils.c
>> index 445e69e86409..222ec1f761a1 100644
>> --- a/drivers/infiniband/hw/irdma/utils.c
>> +++ b/drivers/infiniband/hw/irdma/utils.c
>> @@ -541,7 +541,7 @@ void irdma_cleanup_pending_cqp_op(struct
>> irdma_pci_f *rf)
>>   	for (i = 0; i < pending_work; i++) {
>>   		cqp_request = (struct irdma_cqp_request *)(unsigned long)
>>   				      cqp->scratch_array[wqe_idx];
>> -		if (cqp_request)
>> +		if (cqp_request && cqp_request != (struct irdma_cqp_request
>> +*)&cqp->sc_cqp)
>>   			irdma_free_pending_cqp_request(cqp, cqp_request);
>>   		wqe_idx = (wqe_idx + 1) % IRDMA_RING_SIZE(cqp-
>>> sc_cqp.sq_ring);
>>   	}
>> --
>> 2.25.1
> 
> Hi Li,
> 
> Could you describe how you hit this issue? It seems like the probe would not have completed successfully if the create cceq request was still pending.
> 
> A better fix might be to set the scratch to 0 in this case: In irdma_create_ceq(), pass 0 for scratch in call to irdma_sc_cceq_create(&iwceq->sc_ceq, 0), since it doesn't appear to be used in this case. Is it possible to test this fix? Thanks!

1. The firmware of net card or the hardware may enter into some kind of error state. And I observed
that the sq_ring of sc_cqp is full through crash. This means that all the 2048 cqp_requests were pending.

crash> struct irdma_cqp.sc_cqp ffff88afe3e4eee8
   sc_cqp = {
     ...
     sq_ring = {
       head = 91,  (The queue head caught up with the queue tail.)
       tail = 92,
       size = 2048
     },
     ...
   }

2. The issue is not reproducible. But I have tested the solution that pass 0 for scratch in
call to irdma_sc_cceq_create(&iwceq->sc_ceq, 0) in irdma_create_ceq(). It works well.

Thanks!


