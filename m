Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A32C4B6304
	for <lists+linux-rdma@lfdr.de>; Tue, 15 Feb 2022 06:43:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229773AbiBOFnw (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 15 Feb 2022 00:43:52 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:51914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232208AbiBOFnv (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 15 Feb 2022 00:43:51 -0500
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com [IPv6:2607:f8b0:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F3BD70F5A
        for <linux-rdma@vger.kernel.org>; Mon, 14 Feb 2022 21:43:42 -0800 (PST)
Received: by mail-ot1-x32f.google.com with SMTP id b12-20020a9d754c000000b0059eb935359eso13105193otl.8
        for <linux-rdma@vger.kernel.org>; Mon, 14 Feb 2022 21:43:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=6H8mzaQIecKgBXvToFsEYx5s7xJdKsyTf+VQpbsnsco=;
        b=BixrJkJHFkLdhgvJ5e2Z79raBRLBY1Fys2jpx8nqHyAheYTaP6nw2LmgEdpQWMnLIH
         G4feAkGDgDE2X+65l+3BFMGJ4lwJAIiq6n3EKq76StLfKYGIrpVuhK/4d4vp3YK8XLOc
         UECUM9tgcFiGZAt1bF9pnr6An05orDcYMjX84VskEM+pGo4Mto2l6TjO4pZsRbfmnkmd
         VKdG4oTTBwNoJkxRLou9xnlt4FG8PPbSKz3H0CLe8av6QjUrGRt8sONsBDqrCkZorCh7
         UiNWFRH130LE9g7PrPGa7NfJp7RmMUqOaKlDDSi647v6xxDeJ3rZprP2Q5jc6wdpp0QH
         Od/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=6H8mzaQIecKgBXvToFsEYx5s7xJdKsyTf+VQpbsnsco=;
        b=mFD27/MXdwYBW4LBzEMlrcJvMQzYIgd7Iryga2R/5s83a0rlLrQgs5l3UDGFYNXDDL
         fN0Pi0lQT7AFzIPxz+ID8P/BjagRg8eckeo9r2re9jRiBzjac9FEbYPTLKsgGh1Oo9YR
         ToWHitI3YLhRKOxR2qFN1A3E8C3i+IB3TTRwLc8S/3Mr1TCo/tkJi+UH/udSSGnymrD4
         NkEms3czb1+AnJQWhxtvC39Rl2I2vG0nYBhvg0F8RAySDg9sY2bedKq8QBVz+h7ZRG4G
         MQtQDWaJ3XlzWamzORLNdHJ6utQfYdrASLjj7r/2o8e0SaWjSHA5TRvWcwPtZpWsZESZ
         VuWA==
X-Gm-Message-State: AOAM5335ncQvrpLYG2pYLeFnW4rnLVerTI40JKkTa78RVOz9ukMSSHjz
        ltHDMAEAv6OZpV42OiYS4VY=
X-Google-Smtp-Source: ABdhPJy89LDQgCA6rlN/Lr3h+bXqAlBSzLYmvxQceftXrTykaMioaS3eJ3aZ7TGgg1lW25qveMgyKA==
X-Received: by 2002:a9d:628a:: with SMTP id x10mr810048otk.264.1644903821594;
        Mon, 14 Feb 2022 21:43:41 -0800 (PST)
Received: from ?IPV6:2603:8081:140c:1a00:b7b3:eedc:416b:8b61? (2603-8081-140c-1a00-b7b3-eedc-416b-8b61.res6.spectrum.com. [2603:8081:140c:1a00:b7b3:eedc:416b:8b61])
        by smtp.gmail.com with ESMTPSA id 52sm307256otc.54.2022.02.14.21.43.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Feb 2022 21:43:41 -0800 (PST)
Message-ID: <1f781fd6-a5e6-aa73-c43d-d16771fdef3c@gmail.com>
Date:   Mon, 14 Feb 2022 23:43:40 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: Inconsistent lock state warning for rxe_poll_cq()
Content-Language: en-US
To:     Bart Van Assche <bvanassche@acm.org>,
        Guoqing Jiang <guoqing.jiang@linux.dev>
Cc:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Jason Gunthorpe <jgg@nvidia.com>
References: <8f9fe1da-c302-0c45-8df8-2905c630daad@acm.org>
 <a300f716-718d-9cfe-a95f-870660b92434@gmail.com>
 <89e17cc9-6c90-2132-95e4-4e9ce65a9b08@acm.org>
 <04a372ee-cb82-2cbe-b303-d958af5e47f5@gmail.com>
 <95f08f0e-da4e-13fb-a594-a6d046230d76@acm.org>
From:   Bob Pearson <rpearsonhpe@gmail.com>
In-Reply-To: <95f08f0e-da4e-13fb-a594-a6d046230d76@acm.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 2/14/22 14:48, Bart Van Assche wrote:
> On 2/14/22 12:25, Bob Pearson wrote:
>> It helps. I am trying to run blktests -q srp but I need to install
>> xfs first it seems. Do I need two nodes or can I run it with just
>> one?
> 
> XFS? All SRP tests use the null_blk driver if I remember correctly and hence don't need any physical block device. Some tests outside the SRP directory require xfstools but the SRP tests do not. If blktests are run as follows, XFS should not be required:
> 
> ./check -q srp
> 
> Thanks,
> 
> Bart.

I am now able to reproduce what I think is the same trace you are seeing.

The first error is the warning:

	[ 1808.574513] WARNING: CPU: 7 PID: 3887 at kernel/softirq.c:363 __local_bh_enable_ip+0xac/0x100

which is called from __local_bh_enable_ip()

	void __local_bh_enable_ip(unsigned long ip, unsigned int cnt)

	{

	        WARN_ON_ONCE(in_irq());

	        lockdep_assert_irqs_enabled();

	#ifdef CONFIG_TRACE_IRQFLAGS

	        local_irq_disable();

	#endif


in lockdep_assert_irqs_enabled()

and this is in turn called from __rxe_add_index() which looks like

	int __rxe_add_index(struct rxe_pool_elem *elem)

	{

	        struct rxe_pool *pool = elem->pool;

	        int err;


	
	        write_lock_bh(&pool->pool_lock);

	        err = __rxe_add_index_locked(elem);

	        write_unlock_bh(&pool->pool_lock);


	
	        return err;

	}


in the write_unlock_bh() call. This appears to complain if hardirqs are not enabled on the current cpu. This only happens if CONFIG_PROVE_LOCKING=y. The problem with all this is that the pool->pool_lock is never held by anyone
else except __rxe_add_index when the first error occurs. Perhaps someone else has disabled hard irqs and lets us gain
control of this cpu. If instead of _bh locks we use _irqsave locks in rxe_pool.c, which was the case a while ago
the test is different and passes. If you don't set CONFIG_PROVE_LOCKING this error does not happen.

Somehow just using _irqsave locks because it makes this error vanish doesn't seem right. There should be a root
cause that makes sense.

Any ideas.

Bob
