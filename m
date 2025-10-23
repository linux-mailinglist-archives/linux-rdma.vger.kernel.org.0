Return-Path: <linux-rdma+bounces-13987-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E27EABFEB62
	for <lists+linux-rdma@lfdr.de>; Thu, 23 Oct 2025 02:10:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ECCA13A658E
	for <lists+linux-rdma@lfdr.de>; Thu, 23 Oct 2025 00:10:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB7C61DFFD;
	Thu, 23 Oct 2025 00:10:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KbS8FCgo"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 983E579F2;
	Thu, 23 Oct 2025 00:10:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761178234; cv=none; b=rHpg7AFlG7z9do/uumSmaiHvc7MPhorY2EEt8jSlwwl1e8cUGhmg2dB2wx4Oxl4Gml9p9xdFk+6nAkCEMWtXi74dXbi0fZi4TkG3lo3KAQOz4L1LPu/lr4I6JYVC5eryHzrSIFjz8YFQSd3jZTOx4RsOHnkAHcqdVxxF3gqqV2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761178234; c=relaxed/simple;
	bh=8z7vPbHZpnKdrK9KUqXpcwoJKkgigenyGCKqGNWy/rc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VNUrdZIemAztHMjEtxGsa4j8q0yjww6l/Iun41CVR8qoa+nBU1T2D+ZCjx3VS1klelfmjbppxAoPBGd2E1zDkxxNqu0xDjp+M2ktYkoaPOJj2gCOHyx1VlsPkCbHDvDuREsdABPG8H+yo1SI/BBzHatFt1jrladvtl0u5ttzJVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KbS8FCgo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1BFA2C4CEE7;
	Thu, 23 Oct 2025 00:10:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761178234;
	bh=8z7vPbHZpnKdrK9KUqXpcwoJKkgigenyGCKqGNWy/rc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=KbS8FCgoVEUdU6nCgfATpFMBZFmEJfIUP48vsqB58u5bdsh++0d/HBeZ8JcosWz4c
	 gGK8K750RX6YSXh6aww+wmYvV13vLrw/Gh5qhHT6Be/+R/BekNXoxb4r+kTBXLTYkh
	 acJHVV2go0bgGK/ehjtTpU3tIgBeVRHvwzXtRKehMgsljxfmC9I30riUnDUh9rZEfN
	 jH6NlWiYCSJrhAyNi7mHwLzvAONUX4ZcCZeJ5Mp6hQ4Px/fp9ROJFYLw+BDS0mStps
	 0Z7w8+x4faQBpT8J3QX5s6jW1PyVo83FE32BDDuFOOvq9uuPOfglUfugC0se6sMGYZ
	 uzw/YpEzKv7fw==
Date: Wed, 22 Oct 2025 17:10:33 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Saeed Mahameed <saeed@kernel.org>
Cc: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>,
 Jason Gunthorpe <jgg@nvidia.com>, linux-rdma@vger.kernel.org,
 netdev@vger.kernel.org, Tariq Toukan <tariqt@nvidia.com>, Adithya
 Jayachandran <ajayachandra@nvidia.com>, Mark Bloch <mbloch@nvidia.com>
Subject: Re: [PATCH mlx5-next] {rdma,net}/mlx5: Query vports mac address
 from device
Message-ID: <20251022171033.43ae5dc8@kernel.org>
In-Reply-To: <aPg9hQjpXeR-mJG2@x130>
References: <20251016014055.2040934-1-saeed@kernel.org>
	<20251021164759.2c6a5dc9@kernel.org>
	<aPg9hQjpXeR-mJG2@x130>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 21 Oct 2025 19:12:21 -0700 Saeed Mahameed wrote:
> On 21 Oct 16:47, Jakub Kicinski wrote:
> >On Wed, 15 Oct 2025 18:40:55 -0700 Saeed Mahameed wrote:  
> >> Before this patch during either switchdev or legacy mode enablement we
> >> cleared the mac address of vports between changes. This change allows us
> >> to preserve the vports mac address between eswitch mode changes.  
> >
> >Not knowing what exactly a vport is I can't tell whether this preserves
> >MAC addrs of reprs, the uplink, something else?  
> 
> vport == vf or sf, so VF/SF permanent mac address. It can be set either by
> iproute vf interface or devlink function interface. For no obvious reason
> we reset it to 0 on switchdev legacy mode changes.. this patch is fixing
> that. 
> 
> Of course vport holds more information than just the mac address, e.g GUID,
> mtu, promisc mode, mulitcast mode, and other stuff.

SG! Would be good to incorporate that into the commit msg if possible.

