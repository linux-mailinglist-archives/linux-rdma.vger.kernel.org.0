Return-Path: <linux-rdma+bounces-14100-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 77B49C14117
	for <lists+linux-rdma@lfdr.de>; Tue, 28 Oct 2025 11:20:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7830D565A56
	for <lists+linux-rdma@lfdr.de>; Tue, 28 Oct 2025 10:18:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D59EB2C3770;
	Tue, 28 Oct 2025 10:18:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="TKGSypdL"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 789052DEA96;
	Tue, 28 Oct 2025 10:18:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761646715; cv=none; b=fvT/IXgnH9KKC6qZMeJJI97nJLKz/Omyw1xQR2ssz2xyKoOsOTHpOQ2mSskOGPyMoggR5QyRMgWXwJ7q6x62x4bawE3oWTTFN3cCaIMQCp9OsZfQKUEb3i/I8jYYhfd/8c0jSTWs7JEKUksHSUktpvK1imqe6B95WNRAq4aTWGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761646715; c=relaxed/simple;
	bh=0dl7aNojFkS4FkGh0OZhE+c1lQHg15xh2XWAgpYjbKQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jj8Vw4jDLU7kef3z88uopE76p1I+XIypmeljxfn2BC2G3Aw4zcf90RYjfsbRKg74NgYo1ZJcUZMfLbVrDA8T1MkIuDX1ewrn0Umb1TB/YKn4mT9r2LhXZRdbvEM8hoa8elM80n1Xhp5jEbJNNhhY+a0G25s+3nal273wcllxqlU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=TKGSypdL; arc=none smtp.client-ip=115.124.30.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1761646703; h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type;
	bh=DpysrkxeeMCeHuAoOyQJZHU3zVl6/suIplaCsQZ0xkA=;
	b=TKGSypdLWpu3HTaDrb0Ai/knfXKtTiU07wfOEadci1LvedQI+PAPqhv53IAAeSZ19xXTsh0AAPIJahAwpyo/M4lYPAEkK2YitAjv0s1em8eu9BQyRttDQXiDc1OwJ54wJVl288Y9cnWg+z7YMjzoMmdQzYXi4kT8zG/PiJwY88s=
Received: from localhost(mailfrom:alibuda@linux.alibaba.com fp:SMTPD_---0WrBkanQ_1761646702 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 28 Oct 2025 18:18:23 +0800
Date: Tue, 28 Oct 2025 18:18:22 +0800
From: "D. Wythe" <alibuda@linux.alibaba.com    >
To: Dust Li <dust.li@linux.alibaba.com>
Cc: "D. Wythe" <alibuda@linux.alibaba.com>, mjambigi@linux.ibm.com,
	wenjia@linux.ibm.com, wintera@linux.ibm.com,
	tonylu@linux.alibaba.com, guwen@linux.alibaba.com, kuba@kernel.org,
	davem@davemloft.net, netdev@vger.kernel.org,
	linux-s390@vger.kernel.org, linux-rdma@vger.kernel.org,
	pabeni@redhat.com, edumazet@google.com, sidraya@linux.ibm.com,
	jaka@linux.ibm.com
Subject: Re: [PATCH net-next v2] net/smc: add full IPv6 support for SMC
Message-ID: <20251028101822.GB38488@j66a10360.sqa.eu95>
References: <20251022032309.66386-1-alibuda@linux.alibaba.com>
 <aPmGHm9qLwqJEtjF@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aPmGHm9qLwqJEtjF@linux.alibaba.com>
User-Agent: Mutt/1.5.21 (2010-09-15)

On Thu, Oct 23, 2025 at 09:34:22AM +0800, Dust Li wrote:
> On 2025-10-22 11:23:09, D. Wythe wrote:
> >The current SMC implementation is IPv4-centric. While it contains a
> >workaround for IPv4-mapped IPv6 addresses, it lacks a functional path
> >for native IPv6, preventing its use in modern dual-stack or IPv6-only
> >networks.
> >
> >This patch introduces full, native IPv6 support by refactoring the
> >address handling mechanism to be IP-version agnostic, which is
> >achieved by:
> >
> >- Introducing a generic `struct smc_ipaddr` to abstract IP addresses.
> >- Implementing an IPv6-specific route lookup function.
> >- Extend GID matching logic for both IPv4 and IPv6 addresses
> >
> >With these changes, SMC can now discover RDMA devices and establish
> >connections over both native IPv4 and IPv6 networks.
> 
> Tested it with link local ipv6 address, it still doesn't work as
> expected, while TCP works fine.
> 
> #smc_run ./sockperf tp --tcp -i fe80::c679:7b0:4a4b:d5cc%eth2
> sockperf: == version #3.10-23.gited92afb185e6.dirty ==
> sockperf: ERROR: Can`t connect socket (errno=104 Connection reset by peer)
> 
> Best regards,
> Dust
>

This is a long-standing bug. When both smcd and smcrv1 devices are
present in the system, if the smc_clc_prfx_set function fails, the
current logic only clears pclc_base->hdr.typev1 = SMC_TYPE_N, but
neglects to clear ini->smc_type_v1.

This leads to a serious issue: when subsequently constructing the smc
proposal message, the message content is organized according to the v1 +
smcd format based on the uncleared ini->smc_type_v1.

However, because pclc_base->hdr.typev1 has been cleared, When the server
receives such a proposal message, where the type in the header does not
match the content, it immediately fails.

Previously, I considered this issue to be logically unrelated to IPv6
support, so I didn't plan to send this bugfix along. However, in an
IPv6-only environment, this function is guaranteed to return an error
when only link-local address is present. This inevitably triggers the
problem in your test cases, which I hadn't anticipated. I will include
its fix in the next release.

Best wishes,
D. Wythe


