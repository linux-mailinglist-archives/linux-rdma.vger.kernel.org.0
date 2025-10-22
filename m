Return-Path: <linux-rdma+bounces-13968-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 90658BF9AFC
	for <lists+linux-rdma@lfdr.de>; Wed, 22 Oct 2025 04:12:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 57B8019A82FE
	for <lists+linux-rdma@lfdr.de>; Wed, 22 Oct 2025 02:12:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3802C212564;
	Wed, 22 Oct 2025 02:12:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MWuOtdQ9"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E085220458A;
	Wed, 22 Oct 2025 02:12:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761099144; cv=none; b=lC7+XMIiUw5pVabXN5IE7QCa8ZRP4JT4nCvTNGuHfX38suAq8oYKMmwt/PmmEwvHe3WOb1gTFu7uqcEorPUcYeIxWgmid5pwNb0j5PeYSgBq8GUOPvQxgWmJR2/SD703BrE+daj+6OClTxi/OrPmvGE862kJ1SvPUJ1uFY523yA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761099144; c=relaxed/simple;
	bh=gAkvGRuwev6aA7j0NLPJmn5MTYfW/6H3MmdzWIHKM+g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AyMUItJDH0r10zRCM3DIcNAoTtcrbJJMy0PKYXdFTaJKbIBKIl4znqes7hNYp4nShCig9VGXyTu5x0kOJ2TrFzkOM2UegMhAOkpMZsMICGTrYvrDzPZr+5xNMbyhaHMzl4+gdpX97gTprFl3D2zevfTcVSODMearOSSGA9+FYA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MWuOtdQ9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 516A1C4CEF1;
	Wed, 22 Oct 2025 02:12:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761099143;
	bh=gAkvGRuwev6aA7j0NLPJmn5MTYfW/6H3MmdzWIHKM+g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MWuOtdQ9tThNlydhnrJH1VgFh2IxR5HDlpg2L0rx2/QUUZzbeuLWqkQU+2SoUTuF3
	 nx9rfU1Bb6G3Jg/65HV1oKT+yEGJs5zXyu8qT7WMCnU/tM3vMIOI6RpnlCJ+jNFCgK
	 ra5XDoRGKk27ajozO7a9te43PnNRuD4PVlcvYW5o8+88mpXYvfV7ij028e+OudVpO+
	 w70wBzTBOAWnYrwd5T4ysnOBKhkC2JIjLDHzeBgu8ZktdZLh3GCYffvRwlCskXaOt3
	 rtKKFBY6KLP8gJiwoe+MvdIeu9yMvRFp35BziA8Vg3RNN2Tw7DoroaZWXXMJLAh/5W
	 a8tWxukYCv5qA==
Date: Tue, 21 Oct 2025 19:12:21 -0700
From: Saeed Mahameed <saeed@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>,
	Jason Gunthorpe <jgg@nvidia.com>, linux-rdma@vger.kernel.org,
	netdev@vger.kernel.org, Tariq Toukan <tariqt@nvidia.com>,
	Adithya Jayachandran <ajayachandra@nvidia.com>,
	Mark Bloch <mbloch@nvidia.com>
Subject: Re: [PATCH mlx5-next] {rdma,net}/mlx5: Query vports mac address from
 device
Message-ID: <aPg9hQjpXeR-mJG2@x130>
References: <20251016014055.2040934-1-saeed@kernel.org>
 <20251021164759.2c6a5dc9@kernel.org>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20251021164759.2c6a5dc9@kernel.org>

On 21 Oct 16:47, Jakub Kicinski wrote:
>On Wed, 15 Oct 2025 18:40:55 -0700 Saeed Mahameed wrote:
>> Before this patch during either switchdev or legacy mode enablement we
>> cleared the mac address of vports between changes. This change allows us
>> to preserve the vports mac address between eswitch mode changes.
>
>Not knowing what exactly a vport is I can't tell whether this preserves
>MAC addrs of reprs, the uplink, something else?

vport == vf or sf, so VF/SF permanent mac address. It can be set either by
iproute vf interface or devlink function interface. For no obvious reason
we reset it to 0 on switchdev legacy mode changes.. this patch is fixing
that. 

Of course vport holds more information than just the mac address, e.g GUID,
mtu, promisc mode, mulitcast mode, and other stuff.

