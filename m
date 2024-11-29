Return-Path: <linux-rdma+bounces-6161-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 889B49DC2D8
	for <lists+linux-rdma@lfdr.de>; Fri, 29 Nov 2024 12:30:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0A185B20F86
	for <lists+linux-rdma@lfdr.de>; Fri, 29 Nov 2024 11:30:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84AEB1991B4;
	Fri, 29 Nov 2024 11:30:44 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from out-174.mta0.migadu.com (out-174.mta0.migadu.com [91.218.175.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B5E514F135
	for <linux-rdma@vger.kernel.org>; Fri, 29 Nov 2024 11:30:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732879844; cv=none; b=I9sPdhRl8j9UOpQQn0rB5AVoJZa5YerIB7PKVZ/WDrW1sHr4mcOuvenGhXc1LaZK8jQ0r7EQqoYXW6BQCLSzkzostuLyG1RG78olxI1v3iWXLOYbAvPwQFUtM6YabVHkwy5SVMIxQTwTG4NgvdkgnacCWAd0YoV5XxOjydGO388=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732879844; c=relaxed/simple;
	bh=6uaLJMqLsPsEWzHNGlMuyMyYRQ3mlFzbbXO9ueEmorI=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=NCjHwcYHGNkAZDmmuw/hhdL8dEuEiFEAwZy66xcFOlqNCZbeQXCSIUlGJ6Oxbjz6to20agd5slzYnUcfzAWC+IpFNFye2yB/PjJ91g/pvpmyBzqcBAX424xFVTGrQCpBFMUx4Dn+M5Hbx/rzVsKBiZG48Wr1gWitCqHRoHqsHCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; arc=none smtp.client-ip=91.218.175.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <4b5cbf38-ce6b-48ee-aa50-e23a64ba7279@linux.dev>
Date: Fri, 29 Nov 2024 12:30:37 +0100
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [syzbot] Monthly rdma report (Nov 2024)
To: syzbot <syzbot+list61c5ef3632c5b9ec2d7d@syzkaller.appspotmail.com>,
 linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
 netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com
References: <67498180.050a0220.253251.00a9.GAE@google.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Zhu Yanjun <yanjun.zhu@linux.dev>
In-Reply-To: <67498180.050a0220.253251.00a9.GAE@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 29.11.24 09:55, syzbot wrote:
> Hello rdma maintainers/developers,
> 
> This is a 31-day syzbot report for the rdma subsystem.
> All related reports/information can be found at:
> https://syzkaller.appspot.com/upstream/s/rdma
> 
> During the period, 2 new issues were detected and 0 were fixed.
> In total, 8 issues are still open and 61 have already been fixed.
> 
> Some of the still happening issues:
> 
> Ref Crashes Repro Title
> <1> 350     No    INFO: task hung in disable_device
>                    https://syzkaller.appspot.com/bug?extid=4d0c396361b5dc5d610f
> <2> 231     No    INFO: task hung in rdma_dev_change_netns
>                    https://syzkaller.appspot.com/bug?extid=73c5eab674c7e1e7012e
> <3> 51      No    WARNING in rxe_pool_cleanup
>                    https://syzkaller.appspot.com/bug?extid=221e213bf17f17e0d6cd

To this rxe problem, I found the following bug reports.
"
[syzbot] Monthly rdma report (Nov 2024)	0 (1)	2024/11/29 08:55
[syzbot] Monthly rdma report (Oct 2024)	0 (1)	2024/10/28 20:45
[syzbot] Monthly rdma report (Sep 2024)	0 (1)	2024/09/27 13:28
[syzbot] Monthly rdma report (Aug 2024)	1 (2)	2024/08/31 04:02
[syzbot] [rdma?] WARNING in rxe_pool_cleanup	0 (1)	2024/05/13 02:22
"
It means that pd_pool is not empty when rxe link is removed in many 
testcases.

But to the pd, the caller should call the following to allocate a pd and 
destroy a pd.

"
.alloc_pd = rxe_alloc_pd,
...
.dealloc_pd = rxe_dealloc_pd,
"

That is, the caller should create a pd when rdma link is created. And 
the caller should destroy a pd when rdma link is removed.

When pd pool is not empty, it seems that at least one pd is not removed 
when rdma link is removed. The caller should check the application to 
remove this pd before a rdma link is removed.

It is the caller to create and destroy pd, not rxe.

I am not sure whether we should add logs into rxe_alloc_pd and 
rxe_dealloc_pd to notify the caller or not.

Zhu Yanjun

> <4> 46      No    INFO: task hung in add_one_compat_dev (3)
>                    https://syzkaller.appspot.com/bug?extid=6dee15fdb0606ef7b6ba
> <5> 12      Yes   possible deadlock in sock_set_reuseaddr
>                    https://syzkaller.appspot.com/bug?extid=af5682e4f50cd6bce838
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


