Return-Path: <linux-rdma+bounces-164-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BA1B17FEACF
	for <lists+linux-rdma@lfdr.de>; Thu, 30 Nov 2023 09:35:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EB60A1C20DFD
	for <lists+linux-rdma@lfdr.de>; Thu, 30 Nov 2023 08:35:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31C872FE30;
	Thu, 30 Nov 2023 08:34:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b="V3nZmbrZ"
X-Original-To: linux-rdma@vger.kernel.org
Received: from m126.mail.126.com (m126.mail.126.com [220.181.12.37])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9285D10E3;
	Thu, 30 Nov 2023 00:34:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:From:
	Content-Type; bh=pwyyFXR5L70ZJ8FPQyXi6jY077+aCkzfGDt1mqIwdzE=;
	b=V3nZmbrZ5q6LG1K/fZBVt1dEMxCb2xjK6w29EzrqRE273tW7gwPG5mOlIKkqAd
	dlHZXCZJnEzrWUvl2R0mtWEBjNz+y9iz8gc0R/MRSuZHPDytGuk+tAUmqkyf5GYl
	TIYKn0IKQBq6oCYD/sw18IBGt5BZsjr1fcfhRrpk7A8O0=
Received: from [172.23.69.7] (unknown [121.32.254.146])
	by zwqz-smtp-mta-g5-1 (Coremail) with SMTP id _____wBXf+oRSWhlh50DDQ--.64943S2;
	Thu, 30 Nov 2023 16:34:26 +0800 (CST)
Message-ID: <3f16610f-31bb-4b78-8fb0-96fd1eacd6f9@126.com>
Date: Thu, 30 Nov 2023 16:34:22 +0800
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] RDMA/irdma: Avoid free the non-cqp_request scratch
To: Shifeng Li <lishifeng@sangfor.com.cn>, mustafa.ismail@intel.com,
 shiraz.saleem@intel.com, jgg@ziepe.ca, leon@kernel.org, gustavoars@kernel.org
Cc: linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
 dinghui@sangfor.com.cn
References: <20231130081415.891006-1-lishifeng@sangfor.com.cn>
From: Shifeng Li <lishifeng1992@126.com>
In-Reply-To: <20231130081415.891006-1-lishifeng@sangfor.com.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:_____wBXf+oRSWhlh50DDQ--.64943S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxCrykurW3Wr4fZF47uFyDZFb_yoWrWw47pr
	WUJry2krZYyrWUGw1UC398JFy5JF1jyasrXFsFy34ft3W7u3WYvF1UJrWkursxAr15Ja17
	Jr1qqFsY9r1akaUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07j8cTPUUUUU=
X-CM-SenderInfo: xolvxx5ihqwiqzzsqiyswou0bp/1S2mtgs4r1pD4YBZCQABsD

On 2023/11/30 16:14, Shifeng Li wrote:
> When creating ceq_0 during probing irdma, cqp.sc_cqp will be sent as
> a cqp_request to cqp->sc_cqp.sq_ring. If the request is pending when
> removing the irdma driver or unplugging its aux device, cqp.sc_cqp
> will be dereferenced as wrong struct in irdma_free_pending_cqp_request().
> 
> crash> bt 3669
> PID: 3669   TASK: ffff88aef892c000  CPU: 28  COMMAND: "kworker/28:0"
>   #0 [fffffe0000549e38] crash_nmi_callback at ffffffff810e3a34
>   #1 [fffffe0000549e40] nmi_handle at ffffffff810788b2
>   #2 [fffffe0000549ea0] default_do_nmi at ffffffff8107938f
>   #3 [fffffe0000549eb8] do_nmi at ffffffff81079582
>   #4 [fffffe0000549ef0] end_repeat_nmi at ffffffff82e016b4
>      [exception RIP: native_queued_spin_lock_slowpath+1291]
>      RIP: ffffffff8127e72b  RSP: ffff88aa841ef778  RFLAGS: 00000046
>      RAX: 0000000000000000  RBX: ffff88b01f849700  RCX: ffffffff8127e47e
>      RDX: 0000000000000000  RSI: 0000000000000004  RDI: ffffffff83857ec0
>      RBP: ffff88afe3e4efc8   R8: ffffed15fc7c9dfa   R9: ffffed15fc7c9dfa
>      R10: 0000000000000001  R11: ffffed15fc7c9df9  R12: 0000000000740000
>      R13: ffff88b01f849708  R14: 0000000000000003  R15: ffffed1603f092e1
>      ORIG_RAX: ffffffffffffffff  CS: 0010  SS: 0000
> --- <NMI exception stack> ---
>   #5 [ffff88aa841ef778] native_queued_spin_lock_slowpath at ffffffff8127e72b
>   #6 [ffff88aa841ef7b0] _raw_spin_lock_irqsave at ffffffff82c22aa4
>   #7 [ffff88aa841ef7c8] __wake_up_common_lock at ffffffff81257363
>   #8 [ffff88aa841ef888] irdma_free_pending_cqp_request at ffffffffa0ba12cc [irdma]
>   #9 [ffff88aa841ef958] irdma_cleanup_pending_cqp_op at ffffffffa0ba1469 [irdma]
>   #10 [ffff88aa841ef9c0] irdma_ctrl_deinit_hw at ffffffffa0b2989f [irdma]
>   #11 [ffff88aa841efa28] irdma_remove at ffffffffa0b252df [irdma]
>   #12 [ffff88aa841efae8] auxiliary_bus_remove at ffffffff8219afdb
>   #13 [ffff88aa841efb00] device_release_driver_internal at ffffffff821882e6
>   #14 [ffff88aa841efb38] bus_remove_device at ffffffff82184278
>   #15 [ffff88aa841efb88] device_del at ffffffff82179d23
>   #16 [ffff88aa841efc48] ice_unplug_aux_dev at ffffffffa0eb1c14 [ice]
>   #17 [ffff88aa841efc68] ice_service_task at ffffffffa0d88201 [ice]
>   #18 [ffff88aa841efde8] process_one_work at ffffffff811c589a
>   #19 [ffff88aa841efe60] worker_thread at ffffffff811c71ff
>   #20 [ffff88aa841eff10] kthread at ffffffff811d87a0
>   #21 [ffff88aa841eff50] ret_from_fork at ffffffff82e0022f
> 
> Fixes: 44d9e52977a1 ("RDMA/irdma: Implement device initialization definitions")
> Suggested-by: Leon Romanovsky <leon@kernel.org>

The Suggested-by should be "Ismail, Mustafa" <mustafa.ismail@intel.com>.
Could you help me correct it?

Thanks.

> Signed-off-by: Shifeng Li <lishifeng@sangfor.com.cn>
> ---
>   drivers/infiniband/hw/irdma/hw.c | 4 +---
>   1 file changed, 1 insertion(+), 3 deletions(-)
> 
> ---
> v1->v2: replace fix solution and massage the git log.
> 
> diff --git a/drivers/infiniband/hw/irdma/hw.c b/drivers/infiniband/hw/irdma/hw.c
> index 8fa7e4a18e73..df6259c73d28 100644
> --- a/drivers/infiniband/hw/irdma/hw.c
> +++ b/drivers/infiniband/hw/irdma/hw.c
> @@ -1180,7 +1180,6 @@ static int irdma_create_ceq(struct irdma_pci_f *rf, struct irdma_ceq *iwceq,
>   	int status;
>   	struct irdma_ceq_init_info info = {};
>   	struct irdma_sc_dev *dev = &rf->sc_dev;
> -	u64 scratch;
>   	u32 ceq_size;
>   
>   	info.ceq_id = ceq_id;
> @@ -1201,14 +1200,13 @@ static int irdma_create_ceq(struct irdma_pci_f *rf, struct irdma_ceq *iwceq,
>   	iwceq->sc_ceq.ceq_id = ceq_id;
>   	info.dev = dev;
>   	info.vsi = vsi;
> -	scratch = (uintptr_t)&rf->cqp.sc_cqp;
>   	status = irdma_sc_ceq_init(&iwceq->sc_ceq, &info);
>   	if (!status) {
>   		if (dev->ceq_valid)
>   			status = irdma_cqp_ceq_cmd(&rf->sc_dev, &iwceq->sc_ceq,
>   						   IRDMA_OP_CEQ_CREATE);
>   		else
> -			status = irdma_sc_cceq_create(&iwceq->sc_ceq, scratch);
> +			status = irdma_sc_cceq_create(&iwceq->sc_ceq, 0);
>   	}
>   
>   	if (status) {


