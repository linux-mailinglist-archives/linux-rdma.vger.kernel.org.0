Return-Path: <linux-rdma+bounces-12190-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 22F8EB05974
	for <lists+linux-rdma@lfdr.de>; Tue, 15 Jul 2025 14:00:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7A2A517DBA5
	for <lists+linux-rdma@lfdr.de>; Tue, 15 Jul 2025 12:00:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C93422DCF6C;
	Tue, 15 Jul 2025 11:59:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="VJewBGZ3"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out30-100.freemail.mail.aliyun.com (out30-100.freemail.mail.aliyun.com [115.124.30.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48456255F56;
	Tue, 15 Jul 2025 11:59:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752580747; cv=none; b=Z4Fqfj+/IY70fZe6tUXokZ/oBaYZ8yRena7m7GfxDaBcfQT4QcXCiOLiiaBbu+UNYidesMfAkSSqvDKgShZi2W8YIVHxt7cciFxU8ZFIpe99g7Fz35wqyhWi9IZKk5IL1l08VkSAxmLE48X7MMn5uRqhVAMhvoYWWteMH5s2dDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752580747; c=relaxed/simple;
	bh=YmPNxGKjS1dEpn30AMRe4G0TS7iLo75lESz+IwrMYA4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QsLFkYolU+K4rqqc+PFcAbF9iVgCUKTu+oTK1iRUwkkznhMwYVz8obc48aXIfMJNj58WVm4Wgm5Z/ZF8M8FAMvU39A8LLI2TnqkGBf4e01VOa3pFHD9hTUz8QQl4ft5i8gE60H8EtCODenQOnvoatpBPhyWG/F7DZPaF5mZ4bPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=VJewBGZ3; arc=none smtp.client-ip=115.124.30.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1752580734; h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type;
	bh=0o9QFjXw4TW4GuCjZSOcW5pP6pwzDy8uoogLDMEQgFU=;
	b=VJewBGZ30Kug2CoQAVV5CRwmI6LTl1A7i0oULWFQLqId3pgmJgz8HqYLtveN9+nL8EG0ccP3NxQPWR6w14YPcR4vWKoaS9hGeV0WLc4qOSolsB4x3PhOhhpvbD7HxDW4/NNNmKWIfNvWwRLVLzApDN/kkQZuOkfE5LLROZsA2sM=
Received: from localhost(mailfrom:alibuda@linux.alibaba.com fp:SMTPD_---0Wj0NmO9_1752580733 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 15 Jul 2025 19:58:53 +0800
Date: Tue, 15 Jul 2025 19:58:52 +0800
From: "D. Wythe" <alibuda@linux.alibaba.com    >
To: Alexandra Winter <wintera@linux.ibm.com>
Cc: Kuniyuki Iwashima <kuniyu@google.com>,
	"D. Wythe" <alibuda@linux.alibaba.com>,
	Dust Li <dust.li@linux.alibaba.com>,
	Sidraya Jayagond <sidraya@linux.ibm.com>,
	Wenjia Zhang <wenjia@linux.ibm.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Mahanta Jambigi <mjambigi@linux.ibm.com>,
	Tony Lu <tonylu@linux.alibaba.com>,
	Wen Gu <guwen@linux.alibaba.com>, Simon Horman <horms@kernel.org>,
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org,
	linux-rdma@vger.kernel.org, linux-s390@vger.kernel.org,
	syzbot+40bf00346c3fe40f90f2@syzkaller.appspotmail.com,
	syzbot+f22031fad6cbe52c70e7@syzkaller.appspotmail.com,
	syzbot+271fed3ed6f24600c364@syzkaller.appspotmail.com
Subject: Re: [PATCH v1 net] smc: Fix various oops due to inet_sock type
 confusion.
Message-ID: <20250715115852.GA20773@j66a10360.sqa.eu95>
References: <20250711060808.2977529-1-kuniyu@google.com>
 <965af724-c3b4-4e47-97d6-8591ca9790db@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <965af724-c3b4-4e47-97d6-8591ca9790db@linux.ibm.com>
User-Agent: Mutt/1.5.21 (2010-09-15)

On Mon, Jul 14, 2025 at 09:42:22AM +0200, Alexandra Winter wrote:
> 
> 
> On 11.07.25 08:07, Kuniyuki Iwashima wrote:
> > syzbot reported weird splats [0][1] in cipso_v4_sock_setattr() while
> > freeing inet_sk(sk)->inet_opt.
> > 
> > The address was freed multiple times even though it was read-only memory.
> > 
> > cipso_v4_sock_setattr() did nothing wrong, and the root cause was type
> > confusion.
> > 
> > The cited commit made it possible to create smc_sock as an INET socket.
> > 
> > The issue is that struct smc_sock does not have struct inet_sock as the
> > first member but hijacks AF_INET and AF_INET6 sk_family, which confuses
> > various places.
> > 
> > In this case, inet_sock.inet_opt was actually smc_sock.clcsk_data_ready(),
> 
> I would like to remind us of the discussions August 2024 around a patchset
> called "net/smc: prevent NULL pointer dereference in txopt_get".
> That discussion eventually ended up in the reduced (?)
> commit 98d4435efcbf ("net/smc: prevent NULL pointer dereference in txopt_get")
> without a union.
> 
> I still think this union looks dangerous, but don't understand the code well enough to
> propose an alternative.
> 
> Maybe incorporate inet_sock in smc_sock? Like Paoplo suggested in
> https://lore.kernel.org/lkml/20240815043714.38772-1-aha310510@gmail.com/T/#maf6ee926f782736cb6accd2ba162dea0a34e02f9
> 
> He also asked for at least some explanatory comments in the union. Which would help me as well.
> 

Just caught this suggestion... The primary risk with using a union is the
potential for the sk member's offset within the inet_sock structure to
change in the future, although this is highly improbable. But in any
case, directly using inet_sock is certainly a safer approach.

Uncertain if @Kuniyuki will still get to revise a version, If there's no further
follow-up, I'll make the changes when I get a change.

Best wishes,
D. Wythe


