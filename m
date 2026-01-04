Return-Path: <linux-rdma+bounces-15292-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 18DBFCF1145
	for <lists+linux-rdma@lfdr.de>; Sun, 04 Jan 2026 15:37:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C64163024137
	for <lists+linux-rdma@lfdr.de>; Sun,  4 Jan 2026 14:37:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00183281368;
	Sun,  4 Jan 2026 14:37:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VZBFYeAo"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAF8427FD43
	for <linux-rdma@vger.kernel.org>; Sun,  4 Jan 2026 14:37:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767537441; cv=none; b=N1Qh2r06T5Po6ajE7+Jcd5c/T+rrBuh5SJNWug9nAphhmcpcScq+6SLcmWFBAYuz3wHAOhVahHNOTxkArtQPt34tOcQi+KOn9DDSMsWEhcC/bW17V2yBr8kR8jBwt0revq5o06tEzemk06JIZ4rX2CuES1ke+bV9y2hIJOGDMPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767537441; c=relaxed/simple;
	bh=GRNB/NiAIeXtHA+BNkxrmBNBIp4cjFTbTvnrrpZCG6w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g3ODOl3XGG5bQs/IjVhugIPw6De2AjQK2Rb+vnrIvVZo+V6bNBvv7yKq46o2TXxviiWoT8Q3klUlx6l3PBi9w7CITjof0C3dc/NqcY42EP0Pq0xPFCL3j5mkkx+wbyKddotwXDTmOb13mfWAXgrdm/PfawTfXfW0YpB34yVo70I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VZBFYeAo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0DC8C4CEF7;
	Sun,  4 Jan 2026 14:37:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767537441;
	bh=GRNB/NiAIeXtHA+BNkxrmBNBIp4cjFTbTvnrrpZCG6w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VZBFYeAowztL4swd98PxGKsm/DxHiUGoH7/CfC73tskt0gR43eWK5U7MelKYygiIx
	 wzZnyim6CNcunBEe0c53JVUb4Y8gkG4xOl/pmfFHeKPv7Qx3z73bverRmUdxMvEQdI
	 LOx4b0G12Q27uEuw66PBA/ZMV33XGE+kDtp8uy1OA208un48ykl+bFc338LsJy8o+j
	 3+RbWc9EM4iThirHEp/f3w01KjpTYPDngg3p862r31syEmozAW3FpanhZ1PQUwDMIS
	 eU1uUyluq/1vavdlECXBXjimCTcFkSk9XIUb/VoFgplWaHTS4wW1Onf1RWo2Wd7v25
	 tmDmv7/mxPusQ==
Date: Sun, 4 Jan 2026 16:37:16 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Parav Pandit <parav@nvidia.com>
Cc: Etienne AUJAMES <eaujames@ddn.com>,
	"linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
	Romain Fihue <romain.fihue@cea.fr>, Gael Delbary <gdelbary@ddn.com>
Subject: Re: [PATCH] IB/cache: update gid cache on client reregister event
Message-ID: <20260104143716.GD27868@unreal>
References: <aVUfsO58QIDn5bGX@eaujamesFR0130>
 <SJ0PR12MB680626630DE34A9FDA4DE8C2DCB8A@SJ0PR12MB6806.namprd12.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <SJ0PR12MB680626630DE34A9FDA4DE8C2DCB8A@SJ0PR12MB6806.namprd12.prod.outlook.com>

On Sat, Jan 03, 2026 at 02:11:49PM +0000, Parav Pandit wrote:
> 
> > From: Etienne AUJAMES <eaujames@ddn.com>
> > Sent: 31 December 2025 06:38 PM
> > 
> > Some HCAs (e.g: ConnectX4) do not trigger a IB_EVENT_GID_CHANGE on
> > subnet prefix update from SM (PortInfo).
> > 
> > Since the d58c23c92548, the GID cache is updated exclusively on
> > IB_EVENT_GID_CHANGE. If this event is not emitted, the subnet prefix
> > in the IPoIB interface’s hardware address remains set to its default
> > value (0xfe80000000000000).
> > Then rdma_bind_addr() failed because it relies on hardware address to
> > find the port GID (subnet_prefix + port GUID).
> >
> Commit message should be referenced as d58c23c92548 ("IB/core: Only update PKEY and GID caches onrespective events").
> (instead of just above commit id).
> Please change the reference to full.

I fixed it and applied.

Thanks

