Return-Path: <linux-rdma+bounces-11727-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A4F0AEC348
	for <lists+linux-rdma@lfdr.de>; Sat, 28 Jun 2025 01:44:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B118116D3FD
	for <lists+linux-rdma@lfdr.de>; Fri, 27 Jun 2025 23:44:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53A44292B41;
	Fri, 27 Jun 2025 23:42:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="io6B7POp"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out-188.mta1.migadu.com (out-188.mta1.migadu.com [95.215.58.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DEE3291C0C
	for <linux-rdma@vger.kernel.org>; Fri, 27 Jun 2025 23:42:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751067770; cv=none; b=qdeTST5r/zn3bgKEKF7EOmnYxQI1e6hJ0jVmJgsuNNMAqgPy3G5eq0+jo2gVDMNoXcb+ERIvSM9IERRrgNM2eOqePIoB++B7AZ4IOamMpVZxfx+yH6+osl0dAcHYCC1uKbfRRGf7DAsEGPQFFRp0MsRbcSlCxxDHsBrRrb/oFBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751067770; c=relaxed/simple;
	bh=EXVZrWdeK08gDTT2gx0Qlq6xUB8FimH0zKu9T6MTZEU=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=YETX4Hm2tkRQjoAZXr3D2gGpQ3wCfsS+azzPmgCvVdh76FzyW+C1sCf/nJuCGoPp2ACPXGFHiyynVfTwOgQmFcoCAqyLsPDPrsKiRGDV/g1Nt0nu/Jn76P7429humNJkGWU/8OAuW4Q+ijxA1PTK0R6j/JV1IDTLlvAgDuvEUiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=io6B7POp; arc=none smtp.client-ip=95.215.58.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <382ffa5e-41bc-4632-9ff0-789e7d47158c@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1751067765;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CkjB4ZKuREl223wiqo2m7uxwq9VOLlBeeYY6Aq2JiDw=;
	b=io6B7POpBuozOF3YUj++6fivErAopYfkzh/0LGxiJA2C6lj2AV+0oZ0iREwRngI0DkWJS2
	KPounk2SQXdkfFeFKOBNY0QNaj0Y33lIPEjJevOXY1AV12Z0spBDb73Y/b7subHBfsXQOJ
	goBVqi7K69BsH4QwJvXjen6HaOKvEcA=
Date: Fri, 27 Jun 2025 16:42:39 -0700
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [syzbot] [rdma?] WARNING in rxe_skb_tx_dtor
To: syzbot <syzbot+8425ccfb599521edb153@syzkaller.appspotmail.com>,
 linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
 Leon Romanovsky <leon@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>,
 linux-rdma@vger.kernel.org
References: <685f29f2.a00a0220.274b5f.0003.GAE@google.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Yanjun.Zhu" <yanjun.zhu@linux.dev>
In-Reply-To: <685f29f2.a00a0220.274b5f.0003.GAE@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

Thanks a lot.

I will organize the code, add a commit log, and then send the commit to 
the RDMA mailing list for review.

Best Regards,

Yanjun.Zhu

On 6/27/25 4:32 PM, syzbot wrote:
> Hello,
>
> syzbot has tested the proposed patch and the reproducer did not trigger any issue:
>
> Reported-by: syzbot+8425ccfb599521edb153@syzkaller.appspotmail.com
> Tested-by: syzbot+8425ccfb599521edb153@syzkaller.appspotmail.com
>
> Tested on:
>
> commit:         fac5dcad RDMA/rxe: Fix rxe_skb_tx_dtor problem
> git tree:       https://github.com/zhuyj/linux.git v6.16_fix_rxe_skb_tx_dtor
> console output: https://syzkaller.appspot.com/x/log.txt?x=17db0982580000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=79da270cec5ffd65
> dashboard link: https://syzkaller.appspot.com/bug?extid=8425ccfb599521edb153
> compiler:       Debian clang version 20.1.6 (++20250514063057+1e4d39e07757-1~exp1~20250514183223.118), Debian LLD 20.1.6
>
> Note: no patches were applied.
> Note: testing is done by a robot and is best-effort only.

