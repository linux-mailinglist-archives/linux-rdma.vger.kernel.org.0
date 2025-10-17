Return-Path: <linux-rdma+bounces-13914-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id EA055BE67BD
	for <lists+linux-rdma@lfdr.de>; Fri, 17 Oct 2025 07:51:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 10ACF4FD6FD
	for <lists+linux-rdma@lfdr.de>; Fri, 17 Oct 2025 05:51:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4893630CD91;
	Fri, 17 Oct 2025 05:51:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="leproxXA"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FE3F23EA8D
	for <linux-rdma@vger.kernel.org>; Fri, 17 Oct 2025 05:51:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760680276; cv=none; b=ttElnrF9hJxNq1FFYNI+T01FpkCbYp1tcAIAdoNkTg+ds2TmLTSGgN8Y0swFwQU/bdCkW/qFgPbnzXaryAgLVpNq9PdjTDkUkgNTbeM6D0dtuZDR58xb4//BwOpzllurCSUvnSBEifd4hvv2tbJNwnIvOmhQTEQgD6VuURBaQ7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760680276; c=relaxed/simple;
	bh=13KaXPPBpbfcG6C8nBRjdaf4oecJDmYDO7c9uepKSiE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=IAqkl5GyykcA1y3+1W7I5KOaAcxuMw2T4dEo+Jsqn4hHSW0nkAHYc/ukhwYAk7bk69uZfTVSn4UdR38b48/Hy6ED0umU4wUTrcUoOBwlTfjyy2ReRTfG5UjjdxWQ1RINs2gHfgLW3La7bD4KGndRzE68V2GEE/iZR5/PCT0sjWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=leproxXA; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-33428befc49so2617056a91.0
        for <linux-rdma@vger.kernel.org>; Thu, 16 Oct 2025 22:51:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1760680274; x=1761285074; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=+ehYGuUNYau4pdQan1QOF5/3bIPq29aJSlHS/4iCE5o=;
        b=leproxXArdzVgcOAox240/ISo8GzS2a9RUTRCqJ7mEQ43Wyo2yAZSusg3tScp5mOGD
         Y1pO83PYtShvug1kou5dlutUOtuKw8HNdO1kTKaL6iP4uK4gc9RQRYX8cRtNgO2FN4V+
         fzXGSoQvO3I5A7arscY+fj13hWp+Wv7CEOzPPTcGnKLM2HTYMPiGVLDpwNu93eU/iZdu
         1zXwBy0VwsaCmHacWIjokno5ttLWyQPUEQ2OriBXsuCzWgU5r8TKMb2oBvJleW0Jimxi
         6f8NOhPPaRk5gyLkI2Q9sn2gOeV1mxq733Mf9VYT5SwWMVzJ+b9JV7GwKjZfb7oIy9fK
         k2VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760680274; x=1761285074;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+ehYGuUNYau4pdQan1QOF5/3bIPq29aJSlHS/4iCE5o=;
        b=l+BNXMjbeKeo9RZo1TNzpdO+/fTVU1eLqGbg77OBH9MKdPjEfdLRhQL195aSzLwytD
         lY0amYZHZAIiYkQ8cmv/JLwSppyXtES1UOno+aFlNTDcFJG1FeKnlUos8fpVn5I77nFo
         x9vbOQ/LvQddbewYDGjO2QwVU+3DRbvRWdyYlDNiGkZYJyVQFne7ya6bDZb46W67bQFT
         YPnDBHpV+RskglS5lW589OWtck3/cGwd71rWETH8cnaNPRJY7M0luqmadM44Sk68RrYq
         tyXyU9cUWn2r/AD5ZjRnfr+bykJgvmK7n31uNm375+6iTO5l6fq7E335XhAhRkXbW4X0
         I9Qg==
X-Forwarded-Encrypted: i=1; AJvYcCXuLpFy6JfzBhRbe8upHmVtuAsLMZTrb3q5mdxISBf2IPMeER24341KBq5wIJG6OTohfI0VAh2AZCPa@vger.kernel.org
X-Gm-Message-State: AOJu0YwcftLZ841jzmHhksiSoUscuZAUl0FNzJthvp+w2znTalUVafvo
	L3pGj6RXvyCHp+ycKWqRjhnZT5tYeOxusCJbcsptTjozqC48RFsyHhG5ZjChgvBZqG9oClyCadT
	XsxQVwA==
X-Google-Smtp-Source: AGHT+IF/lzWram1mWybPkde6TISe124U50FS51hqLQw7Zc7FZYIDpxH+DNi5gWGs/h3xtwwt9cS60OYOz6I=
X-Received: from pjbse5.prod.google.com ([2002:a17:90b:5185:b0:33b:51fe:1a88])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:1dc4:b0:32e:716d:4d2b
 with SMTP id 98e67ed59e1d1-33bc9b77638mr3445872a91.3.1760680273652; Thu, 16
 Oct 2025 22:51:13 -0700 (PDT)
Date: Fri, 17 Oct 2025 05:48:50 +0000
In-Reply-To: <20251017024827.3137512-1-wangliang74@huawei.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251017024827.3137512-1-wangliang74@huawei.com>
X-Mailer: git-send-email 2.51.0.858.gf9c4a03a3a-goog
Message-ID: <20251017055106.3603987-1-kuniyu@google.com>
Subject: Re: [PATCH net v2] net/smc: fix general protection fault in __smc_diag_dump
From: Kuniyuki Iwashima <kuniyu@google.com>
To: wangliang74@huawei.com
Cc: alibuda@linux.alibaba.com, davem@davemloft.net, dust.li@linux.alibaba.com, 
	edumazet@google.com, guwen@linux.alibaba.com, horms@kernel.org, 
	kuba@kernel.org, linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org, 
	linux-s390@vger.kernel.org, mjambigi@linux.ibm.com, netdev@vger.kernel.org, 
	pabeni@redhat.com, sidraya@linux.ibm.com, tonylu@linux.alibaba.com, 
	wenjia@linux.ibm.com, yuehaibing@huawei.com, zhangchangzhong@huawei.com, 
	Kuniyuki Iwashima <kuniyu@google.com>
Content-Type: text/plain; charset="UTF-8"

From: Wang Liang <wangliang74@huawei.com>
Date: Fri, 17 Oct 2025 10:48:27 +0800
> The syzbot report a crash:
> 
>   Oops: general protection fault, probably for non-canonical address 0xfbd5a5d5a0000003: 0000 [#1] SMP KASAN NOPTI
>   KASAN: maybe wild-memory-access in range [0xdead4ead00000018-0xdead4ead0000001f]
>   CPU: 1 UID: 0 PID: 6949 Comm: syz.0.335 Not tainted syzkaller #0 PREEMPT(full)
>   Hardware name: Google Compute Engine/Google Compute Engine, BIOS Google 08/18/2025
>   RIP: 0010:smc_diag_msg_common_fill net/smc/smc_diag.c:44 [inline]
>   RIP: 0010:__smc_diag_dump.constprop.0+0x3ca/0x2550 net/smc/smc_diag.c:89
>   Call Trace:
>    <TASK>
>    smc_diag_dump_proto+0x26d/0x420 net/smc/smc_diag.c:217
>    smc_diag_dump+0x27/0x90 net/smc/smc_diag.c:234
>    netlink_dump+0x539/0xd30 net/netlink/af_netlink.c:2327
>    __netlink_dump_start+0x6d6/0x990 net/netlink/af_netlink.c:2442
>    netlink_dump_start include/linux/netlink.h:341 [inline]
>    smc_diag_handler_dump+0x1f9/0x240 net/smc/smc_diag.c:251
>    __sock_diag_cmd net/core/sock_diag.c:249 [inline]
>    sock_diag_rcv_msg+0x438/0x790 net/core/sock_diag.c:285
>    netlink_rcv_skb+0x158/0x420 net/netlink/af_netlink.c:2552
>    netlink_unicast_kernel net/netlink/af_netlink.c:1320 [inline]
>    netlink_unicast+0x5a7/0x870 net/netlink/af_netlink.c:1346
>    netlink_sendmsg+0x8d1/0xdd0 net/netlink/af_netlink.c:1896
>    sock_sendmsg_nosec net/socket.c:714 [inline]
>    __sock_sendmsg net/socket.c:729 [inline]
>    ____sys_sendmsg+0xa95/0xc70 net/socket.c:2614
>    ___sys_sendmsg+0x134/0x1d0 net/socket.c:2668
>    __sys_sendmsg+0x16d/0x220 net/socket.c:2700
>    do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
>    do_syscall_64+0xcd/0x4e0 arch/x86/entry/syscall_64.c:94
>    entry_SYSCALL_64_after_hwframe+0x77/0x7f
>    </TASK>
> 
> The process like this:
> 
>                (CPU1)              |             (CPU2)
>   ---------------------------------|-------------------------------
>   inet_create()                    |
>     // init clcsock to NULL        |
>     sk = sk_alloc()                |
>                                    |
>     // unexpectedly change clcsock |
>     inet_init_csk_locks()          |
>                                    |
>     // add sk to hash table        |
>     smc_inet_init_sock()           |
>       smc_sk_init()                |
>         smc_hash_sk()              |
>                                    | // traverse the hash table
>                                    | smc_diag_dump_proto
>                                    |   __smc_diag_dump()
>                                    |     // visit wrong clcsock
>                                    |     smc_diag_msg_common_fill()
>     // alloc clcsock               |
>     smc_create_clcsk               |
>       sock_create_kern             |
> 
> With CONFIG_DEBUG_LOCK_ALLOC=y, the smc->clcsock is unexpectedly changed
> in inet_init_csk_locks(). The INET_PROTOSW_ICSK flag is no need by smc,
> just remove it.
> 
> After removing the INET_PROTOSW_ICSK flag, this patch alse revert
> commit 6fd27ea183c2 ("net/smc: fix lacks of icsk_syn_mss with IPPROTO_SMC")
> to avoid casting smc_sock to inet_connection_sock.
> 
> Reported-by: syzbot+f775be4458668f7d220e@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=f775be4458668f7d220e
> Tested-by: syzbot+f775be4458668f7d220e@syzkaller.appspotmail.com

nit: looks like this diff is not tested by syzbot, you may
want to send diff to syzbot.


> Fixes: d25a92ccae6b ("net/smc: Introduce IPPROTO_SMC")
> Signed-off-by: Wang Liang <wangliang74@huawei.com>

Change itself looks good.

Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>

Thanks!

