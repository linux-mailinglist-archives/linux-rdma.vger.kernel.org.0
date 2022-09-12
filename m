Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30CCF5B5623
	for <lists+linux-rdma@lfdr.de>; Mon, 12 Sep 2022 10:28:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229815AbiILI2C (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 12 Sep 2022 04:28:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229736AbiILI1i (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 12 Sep 2022 04:27:38 -0400
Received: from out2.migadu.com (out2.migadu.com [IPv6:2001:41d0:2:aacc::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49D8F32BA7;
        Mon, 12 Sep 2022 01:26:43 -0700 (PDT)
Message-ID: <dcacaaf8-8d5c-00cd-f2b7-3a4258f5779c@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1662971133;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TBY/n+1M8LwfiyqrH6vsAKHFwyw47fD1VJdk+JKwca8=;
        b=lUazoE3OnpJzoP68QrKoMCIkSrmFo7MoeJxbRPyBf4+3E5q75cN5VpZHyk0LvVo9+EWuRs
        Coqc27GVxoZyPOfXV7i35UpZbOdgEVx4MP+I6PgvXptFrJ8QD8sHGGgLDleUQJoDZ4AXGg
        e4bF5hcdXKFK1bKL+SaGEivQSNTpS9Y=
Date:   Mon, 12 Sep 2022 16:25:24 +0800
MIME-Version: 1.0
Subject: Re: [RFC PATCH 2/7] RDMA/rxe: Convert the triple tasklets to
 workqueues
To:     Bart Van Assche <bvanassche@acm.org>,
        Daisuke Matsuda <matsuda-daisuke@fujitsu.com>,
        linux-rdma@vger.kernel.org, leonro@nvidia.com, jgg@nvidia.com,
        zyjzyj2000@gmail.com
Cc:     nvdimm@lists.linux.dev, linux-kernel@vger.kernel.org,
        rpearsonhpe@gmail.com, yangx.jy@fujitsu.com, lizhijian@fujitsu.com,
        y-goto@fujitsu.com
References: <cover.1662461897.git.matsuda-daisuke@fujitsu.com>
 <41e5476f4f14a0b77f4a8c3826e3ef943bf7c173.1662461897.git.matsuda-daisuke@fujitsu.com>
 <0b3366e6-c0ae-7242-5006-b638e629972d@linux.dev>
 <fd1d7c49-a090-e8c7-415b-dfcda94ace9d@acm.org>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Yanjun Zhu <yanjun.zhu@linux.dev>
In-Reply-To: <fd1d7c49-a090-e8c7-415b-dfcda94ace9d@acm.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


在 2022/9/11 23:08, Bart Van Assche 写道:
> On 9/11/22 00:10, Yanjun Zhu wrote:
>> I also implemented a workqueue for rxe. IMO, can we add a variable to
>> decide to use tasklet or workqueue?
>>
>> If user prefer using tasklet, he can set the variable to use
>> tasklet. And the default is tasklet. Set the variable to another
>> value to use workqueue.
>
> I'm in favor of removing all uses of the tasklet mechanism because of 
> the disadvantages of that mechanism. See also:
> * "Eliminating tasklets" (https://lwn.net/Articles/239633/).
> * "Modernizing the tasklet API" (https://lwn.net/Articles/830964/).
> * Sebastian Andrzej Siewior's opinion about tasklets 
> (https://lore.kernel.org/all/YvovfXMJQAUBsvBZ@linutronix.de/).

Thanks, Bart

https://lwn.net/Articles/239633/ is to remove tasklet. But 
https://lwn.net/Articles/240323/ describes the difference between 
workqueue and tasklet.

I am not sure whether the difference between tasklet and workqueue in 
the link https://lwn.net/Articles/240323/ is resolved. If you know, 
please also let me know.

And in the link https://lwn.net/Articles/830964/ and 
https://lore.kernel.org/all/YvovfXMJQAUBsvBZ@linutronix.de/, tasklet can 
be replaced by workqueue, timers or thread interrupts.

"

In current kernels, tasklets can be replaced by workqueues, timers, or 
threaded interrupts. If threaded interrupts are used, the work may just 
be executed in the interrupt handler itself. Those newer mechanisms do 
not have the disadvantages of tasklets and should satisfy the same 
needs, so developers do not see a reason to keep tasklets. It seems that 
any migration away from tasklets will be done one driver (or subsystem) 
at a time. For example, Takashi Iwai already reported having the 
conversion ready for sound drivers.

"

And in the link 
https://lore.kernel.org/all/YvovfXMJQAUBsvBZ@linutronix.de/, Sebastian 
thought that threaded interrupts are a good substitute to tasklet.

To me, after I have implemented workqueue in rxe, I did not find any 
benefits with workqueue. And sometime the latency is worse with workqueue.

This is why I do not send the workqueue commits to upstream maillist.

I am not sure whether it is a good idea to replace tasklet with 
workqueue or not.

Let me do more readings in linux upstream maillist.

Zhu Yanjun

>
> Thanks,
>
> Bart.
>
