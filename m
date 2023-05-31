Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3FEE718539
	for <lists+linux-rdma@lfdr.de>; Wed, 31 May 2023 16:43:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237106AbjEaOnY (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 31 May 2023 10:43:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236778AbjEaOnW (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 31 May 2023 10:43:22 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8F77121;
        Wed, 31 May 2023 07:43:17 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1685544195;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=c4lVqdGdK8BRTQNLToiTY/4Q4NvhmcknCNjStMQx6W0=;
        b=rZ/V/o0aGz/ctsUA1nERPJX7d6dGP2mvGvqfIAgNFVyRFEoPBj7aJR6u2/kefIj2nktziO
        Umn0c1Uhd1Hyk61lIYmK7nQdFkI02BstFGLOBzGSd13JIsJL2GxIEKSoAtVe+i9USe/0U1
        ccGGWKalRxKG19r+oUgeiERFuE7Z53KGCbwnseh2CSPB+ixUY83zud3XOPQeoAQgxkIaIX
        PAywNtMDDIHGEQ+kxSrnghCYfzF479YXr5lZhIJcxL2snHnUF0DqDhL8MYYMw1VV5GglbZ
        015qNa0+rnaDAIosij2srvAKCDbBjsE00uNQNaG8FQRLXfqHWMMzgYYS+b3CpA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1685544195;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=c4lVqdGdK8BRTQNLToiTY/4Q4NvhmcknCNjStMQx6W0=;
        b=LYi0M59nky+w1t94qVhUvS1/3kwQWDl/Bs5TA6G5kncEqxrXtjzRpbo0dLH6xu/0xTNci4
        HprG3yfmhHpfGsCg==
To:     Chuck Lever III <chuck.lever@oracle.com>
Cc:     Eli Cohen <elic@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
        Saeed Mahameed <saeedm@nvidia.com>,
        linux-rdma <linux-rdma@vger.kernel.org>,
        "open list:NETWORKING [GENERAL]" <netdev@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: system hang on start-up (mlx5?)
In-Reply-To: <C34181E7-A515-4BD1-8C38-CB8BCF2D987D@oracle.com>
References: <A1E5B427-897B-409E-B8E3-E417678E81F6@oracle.com>
 <DM8PR12MB54003FBFCABCCB37EE807B45AB6C9@DM8PR12MB5400.namprd12.prod.outlook.com>
 <91176545-61D2-44BF-B736-513B78728DC7@oracle.com>
 <20230504072953.GP525452@unreal>
 <46EB453C-3CEB-43E8-BEE5-CD788162A3C9@oracle.com>
 <DM8PR12MB54001D6A1C81673284074B37AB709@DM8PR12MB5400.namprd12.prod.outlook.com>
 <A54A0032-C066-4243-AD76-1E4D93AD9864@oracle.com> <875y8altrq.ffs@tglx>
 <0C0389AD-5DB9-42A8-993C-2C9DEDC958AC@oracle.com> <87o7m1iov9.ffs@tglx>
 <C34181E7-A515-4BD1-8C38-CB8BCF2D987D@oracle.com>
Date:   Wed, 31 May 2023 16:43:15 +0200
Message-ID: <87ttvsftoc.ffs@tglx>
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

On Tue, May 30 2023 at 21:48, Chuck Lever III wrote:
>> On May 30, 2023, at 3:46 PM, Thomas Gleixner <tglx@linutronix.de> wrote:
>> Can you please add after the cpumask_copy() in that mlx5 code:
>> 
>>    pr_info("ONLINEBITS: %016lx\n", cpu_online_mask->bits[0]);
>>    pr_info("MASKBITS:   %016lx\n", af_desc.mask.bits[0]);
>
> Both are 0000 0000 0000 0fff, as expected on a system
> where 12 CPUs are present.

So the non-initialized mask on stack has the online bits correctly
copied and bits 12-63 are cleared, which is what cpumask_copy()
achieves by copying longs and not bits.

> [   71.273798][ T1185] irq_matrix_reserve_managed: MASKBITS: ffffb1a74686bcd8

How can that end up with a completely different content here?

As I said before that's clearly a direct map address.

So the call chain is:

mlx5_irq_alloc(af_desc)
  pci_msix_alloc_irq_at(af_desc)
    msi_domain_alloc_irq_at(af_desc)
      __msi_domain_alloc_irqs(af_desc)
1)      msidesc->affinity = kmemdup(af_desc);
        __irq_domain_alloc_irqs()
          __irq_domain_alloc_irqs(aff=msidesc->affinity)
            irq_domain_alloc_irqs_locked(aff)
              irq_domain_alloc_irqs_locked(aff)
                irq_domain_alloc_descs(aff)
                  alloc_desc(mask=&aff->mask)
                    desc_smp_init(mask)
2)                    cpumask_copy(desc->irq_common_data.affinity, mask);
                irq_domain_alloc_irqs_hierarchy()
                  msi_domain_alloc()
                    intel_irq_remapping_alloc()
                      x86_vector_alloc_irqs()
                        reserve_managed_vector()
                          mask = desc->irq_common_data.affinity;
                          irq_matrix_reserve_managed(mask)

So af_desc is kmemdup'ed at #1 and then the result is copied in #2.

Anything else just hands pointers around. So where gets either af_desc
or msidesc->affinity or desc->irq_common_data.affinity overwritten? Or
one of the pointers mangled. I doubt that it's the latter as this is 99%
generic code which would end up in random fails all over the place.

This also ends up in the wrong place. That mlx code does:

   af_desc.is_managed = false;

but the allocation ends up allocating a managed vector.

This screams memory corruption ....

Can you please instrument this along the call chain so we can see where
or at least when this gets corrupted? Please print the relevant pointer
addresses too so we can see whether that's consistent or not.

> The lowest 16 bits of MASKBITS are bcd8, or in binary:
>
> ... 1011 1100 1101 1000
>
> Starting from the low-order side: bits 3, 4, 6, 7, 10, 11, and
> 12, matching the CPU IDs from the loop. At bit 12, we fault,
> since there is no CPU 12 on the system.

Thats due to a dubious optimization from Linus:

#if NR_CPUS <= BITS_PER_LONG
  #define small_cpumask_bits ((unsigned int)NR_CPUS)
  #define large_cpumask_bits ((unsigned int)NR_CPUS)
#elif NR_CPUS <= 4*BITS_PER_LONG
  #define small_cpumask_bits nr_cpu_ids

small_cpumask_bits is not nr_cpu_ids(12), it's NR_CPUS(32) which is why
the loop does not terminate. Bah!

But that's just the symptom, not the root cause. That code is perfectly
fine when all callers use the proper cpumask functions.

Thanks,

        tglx



