Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECC1F718832
	for <lists+linux-rdma@lfdr.de>; Wed, 31 May 2023 19:12:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229861AbjEaRMK (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 31 May 2023 13:12:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229898AbjEaRMJ (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 31 May 2023 13:12:09 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8485C185;
        Wed, 31 May 2023 10:12:02 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1685553120;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=H7f7WF2URNiflveRGF5Lr50wqjEuR+NR1KeDUShTYig=;
        b=fI+Xi8kXmkxol6LV+rpVleASS7ix9dbZIzOdocjPNt7uwHZmM5iTUHJfQ/uzmP1gKEAOw+
        LHN3JJkmXI2Lez1JgqAY2hY7kyn6UO2N5PKjTVno72YBqoZ2Qpd07pgt7szuTbfSz//CJJ
        HFNbsZ5exMvwqoEdetlX3BxCxKtrHdn/yOlLvTZ/0FxwkFNOEQDhOlI8U81WFcvUW7OOPF
        Es7T5aw1ye7UOaO+Rakemth/Q4P2uHDuLfUlQvB2lq9fy23GyAqj8T2dRYXxUwNOo7dMdg
        tK0a3KZwz/eiwEAZr+A3NWvyY5SSwNVLRsVTcgybPdogtZCy3ZBPwONSc0Sxog==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1685553120;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=H7f7WF2URNiflveRGF5Lr50wqjEuR+NR1KeDUShTYig=;
        b=Y057VP5m+/QVrylghEdFLobAX2xe5mZ2XzbRLaAQiald5JictUdNU9xWYw2pV8DIF5kfdR
        LHADu5rKsVy6ztBw==
To:     Chuck Lever III <chuck.lever@oracle.com>
Cc:     Eli Cohen <elic@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
        Saeed Mahameed <saeedm@nvidia.com>,
        linux-rdma <linux-rdma@vger.kernel.org>,
        "open list:NETWORKING [GENERAL]" <netdev@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: system hang on start-up (mlx5?)
In-Reply-To: <48B0BC74-5F5C-4212-BC5A-552356E9FFB1@oracle.com>
References: <A1E5B427-897B-409E-B8E3-E417678E81F6@oracle.com>
 <DM8PR12MB54003FBFCABCCB37EE807B45AB6C9@DM8PR12MB5400.namprd12.prod.outlook.com>
 <91176545-61D2-44BF-B736-513B78728DC7@oracle.com>
 <20230504072953.GP525452@unreal>
 <46EB453C-3CEB-43E8-BEE5-CD788162A3C9@oracle.com>
 <DM8PR12MB54001D6A1C81673284074B37AB709@DM8PR12MB5400.namprd12.prod.outlook.com>
 <A54A0032-C066-4243-AD76-1E4D93AD9864@oracle.com> <875y8altrq.ffs@tglx>
 <0C0389AD-5DB9-42A8-993C-2C9DEDC958AC@oracle.com> <87o7m1iov9.ffs@tglx>
 <C34181E7-A515-4BD1-8C38-CB8BCF2D987D@oracle.com> <87ttvsftoc.ffs@tglx>
 <48B0BC74-5F5C-4212-BC5A-552356E9FFB1@oracle.com>
Date:   Wed, 31 May 2023 19:11:59 +0200
Message-ID: <87leh4fmsg.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, May 31 2023 at 15:06, Chuck Lever III wrote:
>> On May 31, 2023, at 10:43 AM, Thomas Gleixner <tglx@linutronix.de> wrote:
>> 
>> mlx5_irq_alloc(af_desc)
>>  pci_msix_alloc_irq_at(af_desc)
>>    msi_domain_alloc_irq_at(af_desc)
>>      __msi_domain_alloc_irqs(af_desc)
>> 1)      msidesc->affinity = kmemdup(af_desc);
>>        __irq_domain_alloc_irqs()
>>          __irq_domain_alloc_irqs(aff=msidesc->affinity)
>>            irq_domain_alloc_irqs_locked(aff)
>>              irq_domain_alloc_irqs_locked(aff)
>>                irq_domain_alloc_descs(aff)
>>                  alloc_desc(mask=&aff->mask)
>>                    desc_smp_init(mask)
>> 2)                    cpumask_copy(desc->irq_common_data.affinity, mask);
>>                irq_domain_alloc_irqs_hierarchy()
>>                  msi_domain_alloc()
>>                    intel_irq_remapping_alloc()
>>                      x86_vector_alloc_irqs()
>
> It is x86_vector_alloc_irqs() where the struct irq_data is
> fabricated that ends up in irq_matrix_reserve_managed().

Kinda fabricated :)
     
     irqd = irq_domain_get_irq_data(domain, virq + i);

Thats finding the irqdata which is associated to the vector domain. That
has been allocated earlier. The affinity mask is retrieved via:

    const struct cpumask *affmsk = irq_data_get_affinity_mask(irqd);

which does:

      return irqd->common->affinity;

irqd->common points to desc->irq_common_data. The affinity there was
copied in #2 above.

>> This also ends up in the wrong place. That mlx code does:
>> 
>>   af_desc.is_managed = false;
>> 
>> but the allocation ends up allocating a managed vector.
>
> That line was changed in 6.4-rc4 to address another bug,
> and it avoids the crash by not calling into the misbehaving
> code. It doesn't address the mlx5_core initialization issue
> though, because as I said before, execution continues and
> crashes in a similar scenario later on.

Ok.

> On my system, I've reverted that fix:
>
> -       af_desc.is_managed = false;
> +       af_desc.is_managed = 1;
>
> so that we can continue debugging this crash.

Ah.

>> Can you please instrument this along the call chain so we can see where
>> or at least when this gets corrupted? Please print the relevant pointer
>> addresses too so we can see whether that's consistent or not.
>
> I will continue working on this today.
>> But that's just the symptom, not the root cause. That code is perfectly
>> fine when all callers use the proper cpumask functions.
>
> Agreed: we're crashing here because of the extra bits
> in the affinity mask, but those bits should not be set
> in the first place.

Correct.

> I wasn't sure if for_each_cpu() was supposed to iterate
> into non-present CPUs -- and I guess the answer
> is yes, it will iterate the full length of the mask.
> The caller is responsible for ensuring the mask is valid.

Yes, that's the assumption of this constant optimization for the small
number of CPUs case. All other cases use nr_cpu_ids as limit and won't
go into non-possible CPUs. I didn't spot it yesterday night either.

Thanks,

        tglx
