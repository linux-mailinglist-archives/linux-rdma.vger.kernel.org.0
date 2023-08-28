Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 642CE78A85C
	for <lists+linux-rdma@lfdr.de>; Mon, 28 Aug 2023 10:57:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229449AbjH1I5K (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 28 Aug 2023 04:57:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbjH1I4n (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 28 Aug 2023 04:56:43 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AED3BF;
        Mon, 28 Aug 2023 01:56:41 -0700 (PDT)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1693212998;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=oQceVJwbfnJziP8tGTmnglMv0U/OynJlKuV/VxugPsI=;
        b=0lpq3q0YURZB4mOKnNPjl4+tDwTJJTA7GtobAxmkr2mrcqOVSOvp9kiBMNCqRWjKNbaVX1
        iTkKMbcvNRO+Yt3Q3EjovbifZJakn5YCNClS597uSI8O8UYVLXRjyfOhbl81FKCLY88oVr
        a/Dr0+YYKLHxfI2amIecllE3njEeUBeA8MFeJfixecZm0aIJyc86o442d+5k0HLhhghkwI
        vHlcekNa6zR72kjk0SCjlyBNvzBVlTpKWsn4KIixmnmedVOq4pdGlOz7x2s9FdoRTU82Pv
        DSglUhyOGqwbYEygPMlgOLaMhN9dvFgZZiWgNlquBGlmQYZEYafecXnoegrvIw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1693212998;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=oQceVJwbfnJziP8tGTmnglMv0U/OynJlKuV/VxugPsI=;
        b=0kTO3nqmWcJUNtqCWg3XJAIxR2LytU5ZEUji5/w9qxDAe7j1rWFs4s2p6MdjrOCLn6IYvi
        Lxgmz0/jabU+F3Bg==
To:     Zhu Yanjun <yanjun.zhu@linux.dev>,
        Li Zhijian <lizhijian@fujitsu.com>, linux-rdma@vger.kernel.org,
        "pmladek@suse.com" <pmladek@suse.com>,
        "senozhatsky@chromium.org" <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>
Cc:     zyjzyj2000@gmail.com, jgg@ziepe.ca, leon@kernel.org,
        linux-kernel@vger.kernel.org, rpearsonhpe@gmail.com,
        Daisuke Matsuda <matsuda-daisuke@fujitsu.com>
Subject: Re: [PATCH v2 1/2] RDMA/rxe: Improve newline in printing messages
In-Reply-To: <f3f30d46-379a-8730-5797-400a77db61c3@linux.dev>
References: <20230823061141.258864-1-lizhijian@fujitsu.com>
 <f3f30d46-379a-8730-5797-400a77db61c3@linux.dev>
Date:   Mon, 28 Aug 2023 11:02:36 +0206
Message-ID: <87r0nnczp7.fsf@jogness.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,INVALID_DATE_TZ_ABSURD,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Hi Zhu,

On 2023-08-23, Zhu Yanjun <yanjun.zhu@linux.dev> wrote:
>> Previously rxe_{dbg,info,err}() macros are appened built-in newline,
>> sut some users will add redundent newline some times. So remove the
>> built-int newline for this macros.
>
> This commit is based on this statement "A newline help flushing
> message out.".
>
> All the rxe_xxx log functions will finally call printk.
>
> To pirntk, there is no such statement in kernel document. Not sure if
> Jason and Leon can decide this statement correct or not.

I also could not find any documentation explaining the semantics of
printk with regard to LOG_CONT and "\n". I suppose this should be added
somewhere.

However, the above statement is correct. You can see this in the code
[0]. All printk messages should have a trailing newline unless it is
only a partial message that will be appended.

John Ogness

[0] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/kernel/printk/printk.c?h=v6.5#n2254
