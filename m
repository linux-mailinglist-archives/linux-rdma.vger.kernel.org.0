Return-Path: <linux-rdma+bounces-14097-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 44CDBC13F92
	for <lists+linux-rdma@lfdr.de>; Tue, 28 Oct 2025 10:59:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 56271423A95
	for <lists+linux-rdma@lfdr.de>; Tue, 28 Oct 2025 09:55:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BD532EE617;
	Tue, 28 Oct 2025 09:55:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="HV9/KtV3"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out30-124.freemail.mail.aliyun.com (out30-124.freemail.mail.aliyun.com [115.124.30.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 849D0224AEF;
	Tue, 28 Oct 2025 09:55:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761645304; cv=none; b=ck6FkEJka4jI8LFa7ho9EJRieLRbpPcmosl2Jm7oqNt9skphrB9Nurfc63F0EquuUOFO80lc94zmPUp7DaNM+qsEb9OTQPQW4rlvMJxpmqElMA3nsxZnAD2DSQ5U4weWulpuvuSBwqPnOMcGZlc30l5wYfOfZH5/cGM3GSVgKCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761645304; c=relaxed/simple;
	bh=VkJJoaOgwKx/MG13uYO7dg2VnmHe+0dHluraTr6UaSo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sJS7FSQPfhoY7zoqwLh9WaTfUpYwstwn2ys3vYF5VEc8N3Py4xMZ7ZkhgByoi7yEjM5b2qk30A9tGOjdMQWfwIOjJlK8of3B1GU82MumfqBPPqJwhX8DJ2rUwGLXF3g1VK2x1xQiOiDDR8c08oiz2gX4lFKrc6BfJ9f+DLYIuP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=HV9/KtV3; arc=none smtp.client-ip=115.124.30.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1761645292; h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type;
	bh=XnLIEDazUQh+n+XUoqVL4fWSLTw/nU5T94rbHzt7llw=;
	b=HV9/KtV3MWuOHoAmi/5IgrzXlJdAI7AHcQ506tZuCnqigQ36UdNTARhTKdy5kIPtBJt5RjHN4SoyWgiXrwPFmL02Zv/Qt8b6nJPSass6Nck5a74D0fWthBb3WkdjP15qC4jGPAiOyZ6UBtQGLpWfbXShbGrUwwYI8ZpM+mjf/I0=
Received: from localhost(mailfrom:alibuda@linux.alibaba.com fp:SMTPD_---0WrBkTrX_1761645290 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 28 Oct 2025 17:54:51 +0800
Date: Tue, 28 Oct 2025 17:54:50 +0800
From: "D. Wythe" <alibuda@linux.alibaba.com    >
To: Leon Romanovsky <leon@kernel.org>
Cc: "D. Wythe" <alibuda@linux.alibaba.com>, mjambigi@linux.ibm.com,
	wenjia@linux.ibm.com, wintera@linux.ibm.com,
	dust.li@linux.alibaba.com, tonylu@linux.alibaba.com,
	guwen@linux.alibaba.com, kuba@kernel.org, davem@davemloft.net,
	netdev@vger.kernel.org, linux-s390@vger.kernel.org,
	linux-rdma@vger.kernel.org, pabeni@redhat.com, edumazet@google.com,
	sidraya@linux.ibm.com, jaka@linux.ibm.com
Subject: Re: [PATCH net-next v2] net/smc: add full IPv6 support for SMC
Message-ID: <20251028095450.GA38488@j66a10360.sqa.eu95>
References: <20251022032309.66386-1-alibuda@linux.alibaba.com>
 <20251027134227.GL12554@unreal>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251027134227.GL12554@unreal>
User-Agent: Mutt/1.5.21 (2010-09-15)

On Mon, Oct 27, 2025 at 03:42:27PM +0200, Leon Romanovsky wrote:
> On Wed, Oct 22, 2025 at 11:23:09AM +0800, D. Wythe wrote:
> > The current SMC implementation is IPv4-centric. While it contains a
> > workaround for IPv4-mapped IPv6 addresses, it lacks a functional path
> > for native IPv6, preventing its use in modern dual-stack or IPv6-only
> > networks.
> > 
> > This patch introduces full, native IPv6 support by refactoring the
> > address handling mechanism to be IP-version agnostic, which is
> > achieved by:
> > 
> > - Introducing a generic `struct smc_ipaddr` to abstract IP addresses.
> > - Implementing an IPv6-specific route lookup function.
> > - Extend GID matching logic for both IPv4 and IPv6 addresses
> > 
> > With these changes, SMC can now discover RDMA devices and establish
> > connections over both native IPv4 and IPv6 networks.
> 
> Why can't you use rdma-cm in-kernel API like any other in-kernel RDMA consumers?
> 
> Thanks
> 
> >

Hi Leon,

Regarding RDMA-CM, I’m not sure if I’ve fully grasped your point, but
based on my current understanding, I believe SMC cannot use RDMA-CM.
There are a few reasons for this:

Firstly, SMC is designed to work not only with RDMA devices but also
needs to negotiate with DIBS(DIRECT INTERNAL BUFFER SHARING) devices. This
means we must support scenarios where no RDMA device is present.
Therefore, we require a round of out-of-band negotiation regardless of
the final device choice. In this context, even if we ultimately select
an RDMA device, using rdma-cm to establish the connection would be
redundant.

Additionally, SMC requires multiplexing multiple connections over a
single QP. We need to decide during the out-of-band negotiation which
specific QP to reuse for the connection. From what I know, rdma-cm does
not seem to offer this capability either.

Best regards,
D. Wythe

