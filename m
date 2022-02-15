Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD3424B6BD5
	for <lists+linux-rdma@lfdr.de>; Tue, 15 Feb 2022 13:16:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234633AbiBOMQU (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 15 Feb 2022 07:16:20 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:53396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233984AbiBOMQT (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 15 Feb 2022 07:16:19 -0500
X-Greylist: delayed 26723 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 15 Feb 2022 04:16:09 PST
Received: from out1.migadu.com (out1.migadu.com [91.121.223.63])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A1381074CA
        for <linux-rdma@vger.kernel.org>; Tue, 15 Feb 2022 04:16:09 -0800 (PST)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1644927367;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MW2RTx++OSQaudhb1Kdv18QIo9b5Jxsozg1Wh19X7VU=;
        b=cf0/BzA7MqGB54e3fzgkbnIw1DpeyUbJSUdOqjAKw5ApqvSB7Ecv2g7cNED35/1JNkV6dx
        55g7jg7DFNpYUyflk9qCqjAQ4mQ4Xy0tRXZUAG3kcmEXfgxJkdHzayy6mtpCSNhW81TkVC
        hK+bNi41lxehIZN/60uHgq9mqGoUcTk=
From:   Guoqing Jiang <guoqing.jiang@linux.dev>
Subject: Re: Inconsistent lock state warning for rxe_poll_cq()
To:     Bob Pearson <rpearsonhpe@gmail.com>,
        Bart Van Assche <bvanassche@acm.org>
Cc:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Jason Gunthorpe <jgg@nvidia.com>
References: <8f9fe1da-c302-0c45-8df8-2905c630daad@acm.org>
 <a300f716-718d-9cfe-a95f-870660b92434@gmail.com>
 <89e17cc9-6c90-2132-95e4-4e9ce65a9b08@acm.org>
 <04a372ee-cb82-2cbe-b303-d958af5e47f5@gmail.com>
 <95f08f0e-da4e-13fb-a594-a6d046230d76@acm.org>
 <1f781fd6-a5e6-aa73-c43d-d16771fdef3c@gmail.com>
Message-ID: <97333dc0-3d0e-b0e5-c9cd-73e011ccde8a@linux.dev>
Date:   Tue, 15 Feb 2022 20:16:04 +0800
MIME-Version: 1.0
In-Reply-To: <1f781fd6-a5e6-aa73-c43d-d16771fdef3c@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org



On 2/15/22 1:43 PM, Bob Pearson wrote:
> On 2/14/22 14:48, Bart Van Assche wrote:
>> On 2/14/22 12:25, Bob Pearson wrote:
>>> It helps. I am trying to run blktests -q srp but I need to install
>>> xfs first it seems. Do I need two nodes or can I run it with just
>>> one?
>> XFS? All SRP tests use the null_blk driver if I remember correctly and hence don't need any physical block device. Some tests outside the SRP directory require xfstools but the SRP tests do not. If blktests are run as follows, XFS should not be required:
>>
>> ./check -q srp
>>
>> Thanks,
>>
>> Bart.
> I am now able to reproduce what I think is the same trace you are seeing.
>
> The first error is the warning:
>
> 	[ 1808.574513] WARNING: CPU: 7 PID: 3887 at kernel/softirq.c:363 __local_bh_enable_ip+0xac/0x100
>
> which is called from __local_bh_enable_ip()
>
> 	void __local_bh_enable_ip(unsigned long ip, unsigned int cnt)
>
> 	{
>
> 	        WARN_ON_ONCE(in_irq());
>
> 	        lockdep_assert_irqs_enabled();
>
> 	#ifdef CONFIG_TRACE_IRQFLAGS
>
> 	        local_irq_disable();
>
> 	#endif
>
>
> in lockdep_assert_irqs_enabled()
>
> and this is in turn called from __rxe_add_index() which looks like
>
> 	int __rxe_add_index(struct rxe_pool_elem *elem)
>
> 	{
>
> 	        struct rxe_pool *pool = elem->pool;
>
> 	        int err;
>
>
> 	
> 	        write_lock_bh(&pool->pool_lock);
>
> 	        err = __rxe_add_index_locked(elem);
>
> 	        write_unlock_bh(&pool->pool_lock);
>
>
> 	
> 	        return err;
>
> 	}
>
>
> in the write_unlock_bh() call. This appears to complain if hardirqs are not enabled on the current cpu.

Let's suppose only NIC is involved at the moment, once NIC driver has
switched to NAPI which means no hard irq is enabled, is it possible?

> This only happens if CONFIG_PROVE_LOCKING=y. The problem with all this is that the pool->pool_lock is never held by anyone
> else except __rxe_add_index when the first error occurs. Perhaps someone else has disabled hard irqs and lets us gain
> control of this cpu. If instead of _bh locks we use _irqsave locks in rxe_pool.c, which was the case a while ago
> the test is different and passes. If you don't set CONFIG_PROVE_LOCKING this error does not happen.
>
> Somehow just using _irqsave locks because it makes this error vanish doesn't seem right. There should be a root
> cause that makes sense.

At least I can find two similar fixes, just FYI.

4956b9eaad45 io_uring: rsrc ref lock needs to be IRQ safe
2800aadc18a6 iwlwifi: Fix softirq/hardirq disabling in 
iwl_pcie_enqueue_hcmd()

Thanks,
Guoqing
