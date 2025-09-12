Return-Path: <linux-rdma+bounces-13323-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A63B9B556FE
	for <lists+linux-rdma@lfdr.de>; Fri, 12 Sep 2025 21:38:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 678A9AC238F
	for <lists+linux-rdma@lfdr.de>; Fri, 12 Sep 2025 19:38:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F195432A81F;
	Fri, 12 Sep 2025 19:38:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="oIMNpUsC"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out-184.mta0.migadu.com (out-184.mta0.migadu.com [91.218.175.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C608A29ACF6
	for <linux-rdma@vger.kernel.org>; Fri, 12 Sep 2025 19:38:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757705894; cv=none; b=Lczm9V/OgdI9ZjpPoY1eV8rV6XF92Q1D72XUfAEEbw14lO3qcwpF4Tr5lqE63zgfuXzWrreEHD5fxdYONb4GUDMuq2So47TX2GJGrRwZMEXngSk+GbWzsnMSnmjWbjBR4Y1uwNjobfMeSTTk/6tY9IFCxDpU7KDT3V7x/I0kSO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757705894; c=relaxed/simple;
	bh=kVdVoE4gybFTANwmPEdaeati0u3esKOiokiwd3mxlRI=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=CdIfHTTs54m7amIAQ+HoQ/8p0UjK+q4Q5M8Z6KVm75xr5uN9mN6o2DueVbkI1I+pGAnCmC3yyQk1aCDLUPPWbDdARjAdMGB2UpKM7W1VDoDBZnDr/t+galwV30qh8hQUbNto/isFN7uj6ymNbKmutMyHyH7+wGeaIPYLDZrQlB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=oIMNpUsC; arc=none smtp.client-ip=91.218.175.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <6f3b9149-2a2d-4532-b38f-946b98e72000@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1757705889;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vX5FNfh32HsPx94JItMdCOB+Unc0XHjjtrYR8Ey18iY=;
	b=oIMNpUsCfpeP+kxppfx25DKocOWjO4sb0uvbGFmLKlcjXViKRfGGN+3S4gr3W3RAFffmX7
	P7c8jKJ5A5AzZDHSAQCWM9Uv0KSQnCDIcGKZ5v/cJKWMD4Shuuz4wDWg+HBDeJwT5dp0fd
	xGN/d7YquKZfbC5iNORdRvVAI+F2mkQ=
Date: Fri, 12 Sep 2025 12:38:05 -0700
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [syzbot] [rdma?] WARNING in gid_table_release_one (3)
To: syzbot <syzbot+b0da83a6c0e2e2bddbd4@syzkaller.appspotmail.com>,
 edwards@nvidia.com, hdanton@sina.com, jgg@ziepe.ca, leon@kernel.org,
 leonro@nvidia.com, linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
 syzkaller-bugs@googlegroups.com
References: <68c3a49a.a70a0220.3543fc.0031.GAE@google.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "yanjun.zhu" <yanjun.zhu@linux.dev>
In-Reply-To: <68c3a49a.a70a0220.3543fc.0031.GAE@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 9/11/25 9:42 PM, syzbot wrote:
> syzbot has bisected this issue to:
> 
> commit a92fbeac7e94a420b55570c10fe1b90e64da4025
> Author: Leon Romanovsky <leonro@nvidia.com>
> Date:   Tue May 28 12:52:51 2024 +0000
> 
>      RDMA/cache: Release GID table even if leak is detected

Maybe this commit just detects ref leaks and reports ref leak.
Even though this commit is reverted, this ref leak still occurs.

The root cause is not in this commit.

"
GID entry ref leak for dev syz1 index 2 ref=615
"

Ref leaks in dev syz1.

Zhu Yanjun

> 
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=13fc9642580000
> start commit:   5f540c4aade9 Add linux-next specific files for 20250910
> git tree:       linux-next
> final oops:     https://syzkaller.appspot.com/x/report.txt?x=10029642580000
> console output: https://syzkaller.appspot.com/x/log.txt?x=17fc9642580000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=5ed48faa2cb8510d
> dashboard link: https://syzkaller.appspot.com/bug?extid=b0da83a6c0e2e2bddbd4
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15b52362580000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16b41642580000
> 
> Reported-by: syzbot+b0da83a6c0e2e2bddbd4@syzkaller.appspotmail.com
> Fixes: a92fbeac7e94 ("RDMA/cache: Release GID table even if leak is detected")
> 
> For information about bisection process see: https://goo.gl/tpsmEJ#bisection


