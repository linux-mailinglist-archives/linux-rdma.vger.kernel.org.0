Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 983A0732695
	for <lists+linux-rdma@lfdr.de>; Fri, 16 Jun 2023 07:26:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230420AbjFPFZ7 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 16 Jun 2023 01:25:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239202AbjFPFZ4 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 16 Jun 2023 01:25:56 -0400
Received: from out-36.mta1.migadu.com (out-36.mta1.migadu.com [IPv6:2001:41d0:203:375::24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 650FB2965
        for <linux-rdma@vger.kernel.org>; Thu, 15 Jun 2023 22:25:54 -0700 (PDT)
Message-ID: <55ea83ec-f102-6a57-6108-5848bb47def3@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1686893150;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FJxEw1GNgWKkkHuIyX9Ym/mOsYQC6Qv71Ffy22HARzk=;
        b=qP/cLKpRjngMBBsRO60A0qG2OR4i5ZjaCDsWad6stZZuQBjhPIb+zVL3n/EwYS3cb492Df
        iP094wMj2KhV2FZrD5F3OhZDco7+fbhQYhBDg5+usPriE9+zwpSDL0KSKA+7H7dp1VAc2o
        6w+OQ1Wff/MAlrc/OHNnVeqDi0kYsNg=
Date:   Fri, 16 Jun 2023 13:25:42 +0800
MIME-Version: 1.0
Subject: Re: shared variables between requester and completer threads - a
 concern
To:     Bob Pearson <rpearsonhpe@gmail.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Zhu Yanjun <zyjzyj2000@gmail.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Cc:     "Hack, Jenny (Ft. Collins)" <jhack@hpe.com>
References: <8bbd8118-ef8f-f156-6b13-f317bc90de58@gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Zhu Yanjun <yanjun.zhu@linux.dev>
In-Reply-To: <8bbd8118-ef8f-f156-6b13-f317bc90de58@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

在 2023/6/16 0:01, Bob Pearson 写道:
> I am still on a campaign to tighten the screws in the rxe driver. There are a lot of variables that are shared
> between the requester task and the completer task (now on work queues) that control resources and error recovery.
> There is almost no effort to make sure changes in one thread are visible in the other. The following is a summary:
> 
> 				In requester task		In completer task
> 	qp->req.psn			RW				R
> 	qp->req.rd_atomic (A)		RW				W
> 	qp->req.wait_fence		W				RW
> 	qp->req.need_rd_atomic		W				RW
> 	qp->req.wait_psn		W				RW
> 	qp->req.need_retry		RW				RW
> 	qp->req.wait_for_rnr_timer	RW				W
> 
> These are all int's except for rd_atomic which is an atomic_t and all properly aligned.
> Several of these are similar to wait_fence:
> 
> 				if (rxe_wqe_is_fenced(qp, wqe) {
> 					qp->req.wait_fence = 1;
> 					goto exit; (the task thread)
> 				}
> 						...
> 								// completed something
> 								if (qp->req.wait_fence) {
> 									qp->req.wait_fence = 0;
> 									rxe_sched_task(&qp->req.task);
> 									// requester will run at least once
> 									// after this
> 								}
> 
> As long as the write and read actually get executed this will work eventually because the caches are
> coherent. But what if they don't? The sched_task implies a memory barrier before the requester task
> runs again but it doesn't read wait_fence so it doesn't seem to matter.
> 
> There also may be a race between a second execution of the requester re-setting the flag and the completer
> clearing it since someone else (e.g. verbs API could also schedule the requester.) I think the worst
> that can happen here is an extra rescheduling which is safe.
> 
> Could add an explicit memory barrier in the requester or matched smp_store_release/smp_load_acquire,
> or a spinlock, or WRITE_ONCE/READ_ONCE. I am not sure what, if anything, should be done in this case.
> It currently works fine AFAIK on x86/x64 but there are others.

Thanks a lot for your great work. Bob.

I confirm that RXE can work well in aarch64 hosts.

In the following host,
"
Architecture:                    aarch64
CPU op-mode(s):                  32-bit, 64-bit
Byte Order:                      Little Endian
CPU(s):                          8
On-line CPU(s) list:             0-7
Thread(s) per core:              1
Core(s) per socket:              8
Socket(s):                       1
NUMA node(s):                    1
Vendor ID:                       ARM
Model:                           0
Model name:                      Cortex-A57
Stepping:                        r1p0
BogoMIPS:                        125.00
NUMA node0 CPU(s):               0-7
"
I built RXE, load/unload rxe and simple rping between rxe clients.
It can work well.

Not sure if rxe can work well on other architectures or not.
If someone can make tests on other architectures, please let us know.

Best Regards,
Zhu Yanjun

> 
> Thanks for your advice.
> 
> Bob

