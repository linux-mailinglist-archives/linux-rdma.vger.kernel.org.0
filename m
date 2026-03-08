Return-Path: <linux-rdma+bounces-17718-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mChoBJZvrWme2wEAu9opvQ
	(envelope-from <linux-rdma+bounces-17718-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Sun, 08 Mar 2026 13:46:14 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 66D082304A1
	for <lists+linux-rdma@lfdr.de>; Sun, 08 Mar 2026 13:46:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C3683301573A
	for <lists+linux-rdma@lfdr.de>; Sun,  8 Mar 2026 12:46:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6C7F37757B;
	Sun,  8 Mar 2026 12:46:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sYmN8yI7"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6458C3783A3
	for <linux-rdma@vger.kernel.org>; Sun,  8 Mar 2026 12:46:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772973969; cv=none; b=FeutSIHqsKadolF3TMNtT9uPZlw2sD+Bcv+G9XoBi4bTYcMIhsBXJmahocbarJ75TQ4VL7bef1KLTYGJTWHmLLC8ZVHbH8mzDtVug82kCh2NoEQL2Jlfi4yyJ487EqEbUk/LhbUdtVRjII2dkjIqLHUdU8nsAqaWJVFXvsDEaBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772973969; c=relaxed/simple;
	bh=a+KZk0fvKXSh+YTSr6nh8f4GRerhYTUihdEuo0KutN8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DLvifZVbuEeyTN8y0wwdCxE6IACPSHE9Twive/QoWaW5tZjY6gCpaIYdsEwP6ZGabYRKgiSbjsPpLoy1VVO+xnk9bzBcCESQAb3AtltEhITIHvh3F+3bqEf4YrWdlg0MpMSo5bj7sUt3abujtOIT2kxGokM8puI/cSCw7K4o7mo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sYmN8yI7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69AABC116C6;
	Sun,  8 Mar 2026 12:46:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772973968;
	bh=a+KZk0fvKXSh+YTSr6nh8f4GRerhYTUihdEuo0KutN8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sYmN8yI7JGzH1iKfoVdKAFi2sjNGd/hazM4XjqeKAeuJ8XMi2vV9MxZZZ3Feb/x4T
	 gz+P1ykkG/Ql7uKp2wBtozmkDhTIy6y5Dqdl2BiiEAWsrnO+YMtctk/Wp+aNm0hIuB
	 C/K2doJ76IIj8PQ9ySO4+0Aq6Ql/CFahWRpm629knljotPkaKFd0Z+bakbl4zsdSHB
	 R1wvKJLnNZV9+ASmbmfj4T4P7dorEB8J+9BdP8PKqofPsxQ3fa0CE5t//UI8stsJz1
	 /nKKaosTnldYYMtkrcz4i3o52i7vBUq2R2kxBohqC3Ky6kPk+qS99RGmY2hV80dqZR
	 GQRwP1BGHNIaA==
Date: Sun, 8 Mar 2026 14:46:04 +0200
From: Leon Romanovsky <leon@kernel.org>
To: "Li,Rongqing(ACG CCN)" <lirongqing@baidu.com>
Cc: Jason Gunthorpe <jgg@ziepe.ca>,
	"linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: Re: =?utf-8?B?562U5aSNOiBbUEFUQ0hdW3JkbWEt?=
 =?utf-8?Q?next=5D_RDMA=2Fmlx5?= =?utf-8?Q?=3A?= Use NUMA-aware allocation
 for memory region descriptors
Message-ID: <20260308124604.GP12611@unreal>
References: <20260224090757.1761-1-lirongqing@baidu.com>
 <ccaf962222eb41a6a909ec434ccb80c6@baidu.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ccaf962222eb41a6a909ec434ccb80c6@baidu.com>
X-Rspamd-Queue-Id: 66D082304A1
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-17718-lists,linux-rdma=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	FORGED_SENDER_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.953];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leon@kernel.org,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-rdma];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

On Fri, Mar 06, 2026 at 05:23:07AM +0000, Li,Rongqing(ACG CCN) wrote:
> 
> > The mlx5_alloc_priv_descs() function currently uses kzalloc(), which allocates
> > memory on the NUMA node of the calling CPU. On multi-socket systems, this
> > can lead to cross-node memory access if the HCA is attached to a different
> > NUMA node than the process allocating the Memory Region (MR).
> > 
> > Switch to kzalloc_node() and specify the node associated with the HCA's DMA
> > device. This ensures that the MR descriptors are resident on the local NUMA
> > node, reducing latency for hardware access.
> > 
> > Signed-off-by: Li RongQing <lirongqing@baidu.com>
> 
> ping
> 
> [Li,Rongqing] 

I have no plans to merge these patches in RDMA subsystem. It is unlikely
can give any benefit to the performance.

Thanks

