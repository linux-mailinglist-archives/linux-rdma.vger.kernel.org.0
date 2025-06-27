Return-Path: <linux-rdma+bounces-11709-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 471F9AEAD7D
	for <lists+linux-rdma@lfdr.de>; Fri, 27 Jun 2025 05:42:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2B137189EC74
	for <lists+linux-rdma@lfdr.de>; Fri, 27 Jun 2025 03:42:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56BAD199FD0;
	Fri, 27 Jun 2025 03:41:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="fOrM8CqI"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out-184.mta0.migadu.com (out-184.mta0.migadu.com [91.218.175.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3083618FDA5
	for <linux-rdma@vger.kernel.org>; Fri, 27 Jun 2025 03:41:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750995716; cv=none; b=QoRob3VfMK7BECf2b4ISV6gD78MtL705vofGh2MEMOitfz9CMtww5eBgnuSCg/nBw0byuoD7217E9s20/3HAj+TJogvwD+EfnVi7dSbKC5IRCehfbarlG+BZ+i8afrQw6HJ31JXxg6/sdRsAB2WmNuxwiki8zDe36Z5VlevHLgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750995716; c=relaxed/simple;
	bh=pscJpDocHzQEwfM0ISB9o23WUvu3qh0oi9KEI3rLjQU=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Io3a8sK/tFUurxXKwhRkNL6zlKknBGLbrT3UHru6elOtbGWuSDonPMJ/fu5mSmjiDH1f/1CXEeI6QInHvKat6nqSvTm5C/2561RpEOnckpD8jIwE0ZsRhKIZgNH0SVTt1esY1nRrYpnzTofxMMwAyaT0OancZb5hzE4FSOI6Pd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=fOrM8CqI; arc=none smtp.client-ip=91.218.175.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <95a8efa9-eca2-4b07-a762-e08de6ae61b3@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1750995711;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AcDbBYNskwk3MUaCY1HljWelTu7lN93TvRLSopaVW7Q=;
	b=fOrM8CqIucoMF6doyEXmS8mMCfA9GapUq8o8gsYdF3fQM33ghqaynd1s1H9G7nh//n192c
	C+/Ieh/5O+7wQ9ZltnCTQ3Yk9YlOWy21a02ORexxMKpG6GdwsV1lePIvAzptbyecwXynia
	GKsb2NEct6Z/+akar/3JzMR9v2JnuVI=
Date: Thu, 26 Jun 2025 20:41:39 -0700
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [syzbot] [rdma?] WARNING in rxe_skb_tx_dtor
To: syzbot <syzbot+8425ccfb599521edb153@syzkaller.appspotmail.com>,
 jgg@ziepe.ca, leon@kernel.org, linux-kernel@vger.kernel.org,
 linux-rdma@vger.kernel.org, syzkaller-bugs@googlegroups.com,
 zyjzyj2000@gmail.com
References: <685e0bc7.050a0220.d71a0.0006.GAE@google.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Zhu Yanjun <yanjun.zhu@linux.dev>
In-Reply-To: <685e0bc7.050a0220.d71a0.0006.GAE@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

#syz test: https://github.com/zhuyj/linux.git v6.16_fix_rxe_skb_tx_dtor

在 2025/6/26 20:11, syzbot 写道:
> Hello,
> 
> syzbot has tested the proposed patch and the reproducer did not trigger any issue:
> 
> Reported-by: syzbot+8425ccfb599521edb153@syzkaller.appspotmail.com
> Tested-by: syzbot+8425ccfb599521edb153@syzkaller.appspotmail.com
> 
> Tested on:
> 
> commit:         f648fc0a Revert "RDMA/rxe: Let destroy qp succeed with..
> git tree:       https://github.com/zhuyj/linux.git v6.16_fix_rxe_skb_tx_dtor
> console output: https://syzkaller.appspot.com/x/log.txt?x=14372f0c580000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=79da270cec5ffd65
> dashboard link: https://syzkaller.appspot.com/bug?extid=8425ccfb599521edb153
> compiler:       Debian clang version 20.1.6 (++20250514063057+1e4d39e07757-1~exp1~20250514183223.118), Debian LLD 20.1.6
> 
> Note: no patches were applied.
> Note: testing is done by a robot and is best-effort only.


