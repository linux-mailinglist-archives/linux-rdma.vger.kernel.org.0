Return-Path: <linux-rdma+bounces-22077-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id gKEmLGNsKWqIWgMAu9opvQ
	(envelope-from <linux-rdma+bounces-22077-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 10 Jun 2026 15:53:39 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DBE15669F97
	for <lists+linux-rdma@lfdr.de>; Wed, 10 Jun 2026 15:53:38 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=HByY1jT4;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-22077-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-rdma+bounces-22077-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9D14F321FADE
	for <lists+linux-rdma@lfdr.de>; Wed, 10 Jun 2026 13:48:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B001F403AF6;
	Wed, 10 Jun 2026 13:48:30 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69C6C246781;
	Wed, 10 Jun 2026 13:48:29 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781099310; cv=none; b=sd538jh9zlrisVlaKTUOh6QV2/7095dCVYlUMfkkOou0fpEQkwygrKSlXiii5wpmXdJQ/nQXZaCpB+ToMk7cXiM66ZY2QTP2QMkhQvdw0qtuPJxtpMcugTp189CRcAs1voc5IBnTNcYW4IB/fMHdJsghU8QMpXS4VL8NonlLOIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781099310; c=relaxed/simple;
	bh=nor53385O356Z+OlOFXefPr/mrdluA8TGllazvObhG0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QoPdDhUh1Nh2HWW5DosGL9erJK6nkUHw6E2173SqULf6mSx4VuTgrqH8+BZFEN88k5geuU33oVAIyPcX7LYfY8ukFgK0VzUSIsfhkIJ6YRtCvIJnh+ZN7rCjo7SQSIUM6AAACJbfd/ShgphXtesmlbum66XIhBp3O+/ejTiHGpw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HByY1jT4; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 666741F00893;
	Wed, 10 Jun 2026 13:48:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781099309;
	bh=9/4cOrSUA22CrxeE/skHmpDQje82SWlSmbmyXcI6dmk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=HByY1jT4j9hwLMnvTrdzI33k8l2eqPanYTcIXRmLDsRede3Vd5+U8OBk8MGO8nOPM
	 yNP5ySHYk4qDNVrcgwnsGE5DzROwFVedhxmvbmp1b35MkjrBiFiSeXkuKoIb2MwRu6
	 kxPlZTKtjIcHuzaHUAxlZ+mOchLD6OaeffK7oggb+8qjPDrGcGwgSJe0TLPzYZvets
	 70YHVKglVJkZR0oN//7pfWKtHwoCW6RaPAmuMYYaI4AnSid3zExeDL8y9Mb7/5dD5a
	 HHUBs+jFWjTcGgL/dIEjpC5iPu0J4yl7CB9mOtUDYW4dr1zUPJ4M3WjshssQBD9ncy
	 Cf8fXckofvIEg==
Date: Wed, 10 Jun 2026 16:48:23 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Saeed Mahameed <saeedm@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>,
	Mark Bloch <mbloch@nvidia.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Subject: Re: [PATCH mlx5-next] net/mlx5: Consolidate UAR index to PFN helpers
Message-ID: <20260610134823.GH327369@unreal>
References: <20260519-mlx5-uar-index-v1-1-1027ae724bff@nvidia.com>
 <20260519153237.GN7702@ziepe.ca>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260519153237.GN7702@ziepe.ca>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[leon@kernel.org,linux-rdma@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[12];
	FORGED_RECIPIENTS(0.00)[m:jgg@ziepe.ca,m:saeedm@nvidia.com,m:tariqt@nvidia.com,m:mbloch@nvidia.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:linux-rdma@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:netdev@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-22077-lists,linux-rdma=lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leon@kernel.org,linux-rdma@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,nvidia.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: DBE15669F97

On Tue, May 19, 2026 at 12:32:37PM -0300, Jason Gunthorpe wrote:
> On Tue, May 19, 2026 at 06:08:18PM +0300, Leon Romanovsky wrote:
> > From: Leon Romanovsky <leonro@nvidia.com>
> > 
> > mlx5_core's uar2pfn() and mlx5_ib's uar_index2pfn() compute the same
> > value via slightly different idioms.  Given:
> > 
> >   MLX5_ADAPTER_PAGE_SHIFT = 12
> >   MLX5_UARS_IN_PAGE       = PAGE_SIZE / MLX5_ADAPTER_PAGE_SIZE
> >                           = 1 << (PAGE_SHIFT - 12)
> > 
> > when uar_4k is set, uar2pfn()'s "index >> (PAGE_SHIFT - 12)" reduces to
> > "index / MLX5_UARS_IN_PAGE", which is exactly what uar_index2pfn() does.
> > When uar_4k is clear, both fall through to the identity case.  The same
> > arithmetic is also open-coded a third time in uar_index2paddress(), which
> > just multiplies the result by PAGE_SIZE.
> > 
> > The duplication is historical: uar_index2pfn() landed with the original
> > mlx5_ib driver in 2013 (e126ba97dba9), uar2pfn() was added in 2017
> > (a6d51b68611e) when the bfreg allocator moved into mlx5_core, and no
> > shared header ever exposed the helper.  The two were last touched in
> > parallel by aa8106f137b9 ("net/mlx5: Add explicit bar address field"),
> > confirming they are meant to behave identically.
> > 
> > Replace all three local copies with two static inlines in
> > include/linux/mlx5/driver.h returning phys_addr_t, which is the
> > appropriate type for a value that subsequently feeds ioremap*() and
> > rdma_user_mmap_io().  No functional change.
> > 
> > Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
> > ---
> > mlx5_core's uar2pfn() and mlx5_ib's uar_index2pfn() compute the same
> > value via slightly different idioms. Let's consolidate them.
> > ---
> >  drivers/infiniband/hw/mlx5/main.c             | 25 ++-----------------------
> >  drivers/net/ethernet/mellanox/mlx5/core/uar.c | 14 +-------------
> >  include/linux/mlx5/driver.h                   | 16 ++++++++++++++++
> >  3 files changed, 19 insertions(+), 36 deletions(-)
> > 
> > diff --git a/drivers/infiniband/hw/mlx5/main.c b/drivers/infiniband/hw/mlx5/main.c
> > index 428811fa805b..e61db29bc166 100644
> > --- a/drivers/infiniband/hw/mlx5/main.c
> > +++ b/drivers/infiniband/hw/mlx5/main.c
> > @@ -2373,27 +2373,6 @@ static void mlx5_ib_dealloc_ucontext(struct ib_ucontext *ibcontext)
> >  	}
> >  }
> >  
> > -static phys_addr_t uar_index2pfn(struct mlx5_ib_dev *dev,
> > -				 int uar_idx)
> > -{
> > -	int fw_uars_per_page;
> > -
> > -	fw_uars_per_page = MLX5_CAP_GEN(dev->mdev, uar_4k) ? MLX5_UARS_IN_PAGE : 1;
> > -
> > -	return (dev->mdev->bar_addr >> PAGE_SHIFT) + uar_idx / fw_uars_per_page;
> > -}
> > -
> > -static u64 uar_index2paddress(struct mlx5_ib_dev *dev,
> > -				 int uar_idx)
> > -{
> > -	unsigned int fw_uars_per_page;
> > -
> > -	fw_uars_per_page = MLX5_CAP_GEN(dev->mdev, uar_4k) ?
> > -				MLX5_UARS_IN_PAGE : 1;
> > -
> > -	return (dev->mdev->bar_addr + (uar_idx / fw_uars_per_page) * PAGE_SIZE);
> > -}
> > -
> >  static int get_command(unsigned long offset)
> >  {
> >  	return (offset >> MLX5_IB_MMAP_CMD_SHIFT) & MLX5_IB_MMAP_CMD_MASK;
> > @@ -2643,7 +2622,7 @@ static int uar_mmap(struct mlx5_ib_dev *dev, enum mlx5_ib_mmap_cmd cmd,
> >  		uar_index = bfregi->sys_pages[idx];
> >  	}
> >  
> > -	pfn = uar_index2pfn(dev, uar_index);
> > +	pfn = mlx5_uar_index_to_pfn(dev->mdev, uar_index);
> >  	mlx5_ib_dbg(dev, "uar idx 0x%lx, pfn %pa\n", idx, &pfn);
> >
> >  	err = rdma_user_mmap_io(&context->ibucontext, vma, pfn, PAGE_SIZE,
> > @@ -4327,7 +4306,7 @@ alloc_uar_entry(struct mlx5_ib_ucontext *c,
> >  		goto end;
> >  
> >  	entry->page_idx = uar_index;
> > -	entry->address = uar_index2paddress(dev, uar_index);
> > +	entry->address = mlx5_uar_index_to_paddr(dev->mdev, uar_index);
> >  	if (alloc_type == MLX5_IB_UAPI_UAR_ALLOC_TYPE_BF)
> >  		entry->mmap_flag = MLX5_IB_MMAP_TYPE_UAR_WC;
> >  	else
> > diff --git a/drivers/net/ethernet/mellanox/mlx5/core/uar.c b/drivers/net/ethernet/mellanox/mlx5/core/uar.c
> > index 1513112ecec8..a85d8fed1546 100644
> > --- a/drivers/net/ethernet/mellanox/mlx5/core/uar.c
> > +++ b/drivers/net/ethernet/mellanox/mlx5/core/uar.c
> > @@ -66,18 +66,6 @@ static int uars_per_sys_page(struct mlx5_core_dev *mdev)
> >  	return 1;
> >  }
> >  
> > -static u64 uar2pfn(struct mlx5_core_dev *mdev, u32 index)
> > -{
> > -	u32 system_page_index;
> > -
> > -	if (MLX5_CAP_GEN(mdev, uar_4k))
> > -		system_page_index = index >> (PAGE_SHIFT - MLX5_ADAPTER_PAGE_SHIFT);
> > -	else
> > -		system_page_index = index;
> > -
> > -	return (mdev->bar_addr >> PAGE_SHIFT) + system_page_index;
> > -}
> > -
> >  static void up_rel_func(struct kref *kref)
> >  {
> >  	struct mlx5_uars_page *up = container_of(kref, struct mlx5_uars_page, ref_count);
> > @@ -132,7 +120,7 @@ static struct mlx5_uars_page *alloc_uars_page(struct mlx5_core_dev *mdev,
> >  		goto error1;
> >  	}
> >  
> > -	pfn = uar2pfn(mdev, up->index);
> > +	pfn = mlx5_uar_index_to_pfn(mdev, up->index);
> >  	if (map_wc) {
> >  		up->map = ioremap_wc(pfn << PAGE_SHIFT, PAGE_SIZE);
> 
> The only places using PFN here immediately shift it, this should be
> using mlx5_uar_index_to_paddr()

<...>

> 
> Then there is only one caller of the pfn version in uar_mmap which can
> just be written using phys and open code the >> PAGE_SHIFT
> 
> No reason to duplicate this

Sure, let's change it v1.

Thanks

> 
> Jason

