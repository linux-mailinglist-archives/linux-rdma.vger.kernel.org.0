Return-Path: <linux-rdma+bounces-4672-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F2526966F2B
	for <lists+linux-rdma@lfdr.de>; Sat, 31 Aug 2024 06:02:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5A224B20A1A
	for <lists+linux-rdma@lfdr.de>; Sat, 31 Aug 2024 04:02:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38A6D5674E;
	Sat, 31 Aug 2024 04:02:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="aR9OUDy1"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out-182.mta1.migadu.com (out-182.mta1.migadu.com [95.215.58.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93E0622086
	for <linux-rdma@vger.kernel.org>; Sat, 31 Aug 2024 04:02:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725076955; cv=none; b=W17Q+xyREp2JvpeCXAEPhohLdB322kza8T91q5rbRSp5JbGANqdT5mnGsbTpCp+T2HlDBjZVbdUWvdp1+xlhqyJ31Jml2MI460rFU90Ww82FZ9ABJAmZav/Pb7gBMFTi79e/3rY7+CzHC8nIuAiFiUVIvUPmu75cumhnf4VrdW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725076955; c=relaxed/simple;
	bh=4BAtJaQXgVeqYMzMwUQ8qu1XdfrtnNL9ejMZuleH900=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=L0BSfuJ8r/kz7LAWfR1oq1ph1r0EYrRXF/MOJdFT3fsz4ztxMIMJKHLe+M1Aj2LbdIoLJCS/pLnigba2uTOTfrDh8Ne7017hTn6ZsqlqtS6ZYw4gn2Um56bki8drpdH04h+g5EIQXSa4nfaeux1/wHMJzUJmFcYzIQRtqA+Htwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=aR9OUDy1; arc=none smtp.client-ip=95.215.58.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <dc333b90-d8a4-488f-8c3e-9b2f3ed8b89c@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1725076950;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WklWTeZwdSq0goljOedo5b3AtXb4lzfT3jFQjbRMGx0=;
	b=aR9OUDy1hinNxJd+9g/y/mhzVHAYZ+ySpKfup4Ydcy2f6yKtbRaUXaPv2+PVK3V/iLDRe3
	gUpFA/4NPAb0NVznxQHJByZVzHQPZIGnSGMAT56Z/Xu64nVU6bI5XEUQQLTK/EQRXjJ9Qz
	qLKPyXryj+Lp5XmS85exmlFf9IH7yXM=
Date: Sat, 31 Aug 2024 12:02:21 +0800
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [syzbot] Monthly rdma report (Aug 2024)
To: syzbot <syzbot+list6d1c113d5d8954339576@syzkaller.appspotmail.com>,
 linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
 netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com
References: <000000000000e629df0620a63b2a@google.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Zhu Yanjun <yanjun.zhu@linux.dev>
In-Reply-To: <000000000000e629df0620a63b2a@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

在 2024/8/27 16:43, syzbot 写道:
> Hello rdma maintainers/developers,
> 
> This is a 31-day syzbot report for the rdma subsystem.
> All related reports/information can be found at:
> https://syzkaller.appspot.com/upstream/s/rdma
> 
> During the period, 1 new issues were detected and 0 were fixed.
> In total, 5 issues are still open and 60 have been fixed so far.
> 
> Some of the still happening issues:
> 
> Ref Crashes Repro Title
> <1> 33      No    INFO: task hung in disable_device
>                    https://syzkaller.appspot.com/bug?extid=4d0c396361b5dc5d610f
> <2> 24      No    WARNING in rxe_pool_cleanup
>                    https://syzkaller.appspot.com/bug?extid=221e213bf17f17e0d6cd

I devled into this problem. From the call trace,we can go to this function:

void rxe_dealloc(struct ib_device *ib_dev)
{
	struct rxe_dev *rxe = container_of(ib_dev, struct rxe_dev, ib_dev);

	rxe_pool_cleanup(&rxe->uc_pool);
	rxe_pool_cleanup(&rxe->pd_pool);    <---- Here
	rxe_pool_cleanup(&rxe->ah_pool);
...
}

rxe_dealloc -- > rxe_pool_cleanup

It seems that pd_pool is not empty when pd_pool is cleaned up.

But from the call trace, it is difficult to find out why pd_pool not empty.

I am not sure if this problem can be reproduced or not.
If it can be reproduced, we can monitor alloc_pd and dealloc_pd 
functions to check if these 2 functions are matched.
Normally the number of invoked alloc_pd should be equal to the number of 
dealloc_pd.

And alloc_pd and dealloc_pd functions can be called via function 
pointers. So these 2 functions can be called from many places. Thus, it 
is difficult to check these 2 functions in source codes.

If it can be reproduced, we can use kprobe,bpf or add call traces to 
mointor the usages of the 2 functions. Then it is easier to find out why 
pd_pool not empty.

This is based on the fact that we can reproduce this problem.^_^

Zhu Yanjun

> <3> 2       No    possible deadlock in sock_set_reuseaddr
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


