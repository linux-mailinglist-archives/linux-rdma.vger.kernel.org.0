Return-Path: <linux-rdma+bounces-14031-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 35448C03229
	for <lists+linux-rdma@lfdr.de>; Thu, 23 Oct 2025 21:06:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E89C94EEAF8
	for <lists+linux-rdma@lfdr.de>; Thu, 23 Oct 2025 19:06:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17A7D34C98F;
	Thu, 23 Oct 2025 19:06:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="OUlOL9MU"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out-181.mta0.migadu.com (out-181.mta0.migadu.com [91.218.175.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B05982777FC
	for <linux-rdma@vger.kernel.org>; Thu, 23 Oct 2025 19:06:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761246375; cv=none; b=P1XdUAvQdWxKxM6KVBcOUygXmY2zZXsgQMz8kFJkA2UCYwnyXSQOSrvqp6gK76mmTuPUOErTj5aDJ4vWNOMKxTB+8jDZWQThXoh8aNi8QrMNnraqYgg7SJScVqNxBhUtNaAJGckabuerKluM0srgRtzD26lPvkjRHOpgA+lxMFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761246375; c=relaxed/simple;
	bh=StvHp5UObVjVm7tLhNdlQMufvln7h8BV/q1UNPIthQs=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=AxbFKpZluKQgp2mZCSqG7EZQqd2gAlJGZ+QNHxmfUx0q/I7SBpTfA3QdfSvS3zEwnAOGz3Q5WxsM1varG9IxCgsF8Z7NRkdPfnyxCDo7xLivAfM7Ex9x4TipCOw/rkPKJpXbGfg0pqXxA5LPuYtkXpL7znBfANxaNz9QfRB0yoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=OUlOL9MU; arc=none smtp.client-ip=91.218.175.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <9fdc4b67-71dc-4a03-a852-bb7b0c8fd04b@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1761246360;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=C4AJeE4xO7Fumodyay+VPlK+zaxJFsD0YxOqqUA94S8=;
	b=OUlOL9MU+Nqp4hS85YoT+W928FVANYvGQIBEokYIdEHCSq95EUELLkCISE28kw+MWeIVzM
	5FlUXwmCaBIi3vFoPje93kzahEeP55/pR1UO3QtC++E5HuaBSgAB9NihEJFGiKAC8snzM2
	jwEN+C9i3gWvZpngrKJe4F1o++rXZEE=
Date: Thu, 23 Oct 2025 12:05:49 -0700
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [syzbot] Monthly rdma report (Oct 2025)
To: syzbot <syzbot+list0ee54e0d9d6647c72420@syzkaller.appspotmail.com>,
 linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
 syzkaller-bugs@googlegroups.com
References: <68f9d8a1.050a0220.346f24.0070.GAE@google.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "yanjun.zhu" <yanjun.zhu@linux.dev>
In-Reply-To: <68f9d8a1.050a0220.346f24.0070.GAE@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 10/23/25 12:26 AM, syzbot wrote:
> Hello rdma maintainers/developers,
> 
> This is a 31-day syzbot report for the rdma subsystem.
> All related reports/information can be found at:
> https://syzkaller.appspot.com/upstream/s/rdma
> 
> During the period, 1 new issues were detected and 0 were fixed.
> In total, 8 issues are still open and 66 have already been fixed.
> 
> Some of the still happening issues:
> 
> Ref Crashes Repro Title
> <1> 969     No    INFO: task hung in rdma_dev_change_netns
>                    https://syzkaller.appspot.com/bug?extid=73c5eab674c7e1e7012e
> <2> 546     Yes   WARNING in rxe_pool_cleanup
>                    https://syzkaller.appspot.com/bug?extid=221e213bf17f17e0d6cd
> <3> 100     No    INFO: task hung in rdma_dev_exit_net (6)
>                    https://syzkaller.appspot.com/bug?extid=3658758f38a2f0f062e7
> <4> 94      No    INFO: task hung in add_one_compat_dev (3)
>                    https://syzkaller.appspot.com/bug?extid=6dee15fdb0606ef7b6ba
> <5> 89      Yes   WARNING in gid_table_release_one (3)
>                    https://syzkaller.appspot.com/bug?extid=b0da83a6c0e2e2bddbd4

About this problem ("WARNING in gid_table_release_one (3)"), I have a 
commit that can solve this problem. I will send it out for code review soon.

Yanjun.Zhu

> <6> 5       Yes   KASAN: slab-use-after-free Read in ucma_create_uevent
>                    https://syzkaller.appspot.com/bug?extid=a6ffe86390c8a6afc818
> 
> ---
> This report is generated by a bot. It may contain errors.
> See https://goo.gl/tpsmEJ for more information about syzbot.
> syzbot engineers can be reached at syzkaller@googlegroups.com.
> 
> To disable reminders for individual bugs, reply with the following command:
> #syz set <Ref> no-reminders
> 
> To change bug's subsystems, reply with:
> #syz set <Ref> subsystems: new-subsystem
> 
> You may send multiple commands in a single email message.


