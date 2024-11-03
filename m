Return-Path: <linux-rdma+bounces-5720-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C2289BA7E6
	for <lists+linux-rdma@lfdr.de>; Sun,  3 Nov 2024 21:21:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EE008281709
	for <lists+linux-rdma@lfdr.de>; Sun,  3 Nov 2024 20:21:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0CD818BB89;
	Sun,  3 Nov 2024 20:21:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hbPRZL05"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 499257C0BE;
	Sun,  3 Nov 2024 20:21:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730665302; cv=none; b=f8jO5OFbF4aPJsndKXAxBcfktN4K9zo27t8jeb5YFjgjwYJKPN/wT1pS4uuy1epLniWIQqAPPtW5bLCoUNW/DnuqivMbcSfsYUHcxfTI0NAO7nWpLQgnQEgyhbzyuO1trNnR7C83YAZDEhLkoNsoDu12/SNbETXPZTpMSbebj0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730665302; c=relaxed/simple;
	bh=8Ukc+M8CZYwlrpkjWIRwsZhzje/hVh2caYXefeqy6UU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uVozJLcZW2r6j1htm7KQGm80vj9xv2PP2q2c3EE+vlpExFUj26JGHRP/k6fLRj9/0onUz9+WI1tV1+oJWG4a2nKCl0RHdDw8Nsud6/5HZ6vIa4vrB9g7zD6TbmtF2BYEPzBwHKtlawUrfpCOJSfXS4cMRheZTmjd4BX8nNQqX6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hbPRZL05; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD122C4CECD;
	Sun,  3 Nov 2024 20:21:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730665301;
	bh=8Ukc+M8CZYwlrpkjWIRwsZhzje/hVh2caYXefeqy6UU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=hbPRZL054fJi30LppOH0pHtwRISF1ZSCdVrUtYIu0ppNa8ioEdfJ/dm3YYfLz3NtM
	 FDDzikzL4fj4/2tA7J1E2L9mrUIuRitDbxRchOPRHLYcpY+eVOIJJUF/2sw3Nv+KC/
	 MkKYL5CoKKRrOmeBncDVf/hgEJBxRSJtwv+KWf1H5OACVRVjFtm4ZhiLiklw82+0AM
	 m+Qj20+jgyR1zDpVDBdBJVbyxI0vaXCMLviA7xAjCakdiPWw7LkGP1wzsNIVt0xcPl
	 p/Kmu0WgZ75pRzFzZgf6IDZpKyq49AkrdXRhOn5GT7MpWMd7DiNlI4obZ4xpQ3JFue
	 qRzwHjaAGgKpw==
Date: Sun, 3 Nov 2024 12:21:38 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Caleb Sander Mateos <csander@purestorage.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, AngeloGioacchino Del Regno
 <angelogioacchino.delregno@collabora.com>, Arthur Kiyanovski
 <akiyano@amazon.com>, Brett Creeley <brett.creeley@amd.com>, Broadcom
 internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
 Christophe Leroy <christophe.leroy@csgroup.eu>, Claudiu Manoil
 <claudiu.manoil@nxp.com>, David Arinzon <darinzon@amazon.com>, "David S.
 Miller" <davem@davemloft.net>, Doug Berger <opendmb@gmail.com>, Eric
 Dumazet <edumazet@google.com>, Eugenio =?UTF-8?B?UMOpcmV6?=
 <eperezma@redhat.com>, Felix Fietkau <nbd@nbd.name>, Florian Fainelli
 <florian.fainelli@broadcom.com>, Geetha sowjanya <gakula@marvell.com>,
 hariprasad <hkelam@marvell.com>, Jason Wang <jasowang@redhat.com>, Jonathan
 Corbet <corbet@lwn.net>, Leon Romanovsky <leon@kernel.org>, Lorenzo
 Bianconi <lorenzo@kernel.org>, Louis Peens <louis.peens@corigine.com>, Mark
 Lee <Mark-MC.Lee@mediatek.com>, Matthias Brugger <matthias.bgg@gmail.com>,
 Michael Chan <michael.chan@broadcom.com>, "Michael S. Tsirkin"
 <mst@redhat.com>, Noam Dagan <ndagan@amazon.com>, Paolo Abeni
 <pabeni@redhat.com>, Przemek Kitszel <przemyslaw.kitszel@intel.com>, Roy
 Pledge <Roy.Pledge@nxp.com>, Saeed Bishara <saeedb@amazon.com>, Saeed
 Mahameed <saeedm@nvidia.com>, Sean Wang <sean.wang@mediatek.com>, Shannon
 Nelson <shannon.nelson@amd.com>, Shay Agroskin <shayagr@amazon.com>, Simon
 Horman <horms@kernel.org>, Subbaraya Sundeep <sbhatta@marvell.com>, Sunil
 Goutham <sgoutham@marvell.com>, Tal Gilboa <talgi@nvidia.com>, Tariq Toukan
 <tariqt@nvidia.com>, Tony Nguyen <anthony.l.nguyen@intel.com>, Vladimir
 Oltean <vladimir.oltean@nxp.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
 intel-wired-lan@lists.osuosl.org, linux-arm-kernel@lists.infradead.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-mediatek@lists.infradead.org, linuxppc-dev@lists.ozlabs.org,
 linux-rdma@vger.kernel.org, netdev@vger.kernel.org,
 oss-drivers@corigine.com, virtualization@lists.linux.dev
Subject: Re: [resend PATCH 2/2] dim: pass dim_sample to net_dim() by
 reference
Message-ID: <20241103122138.6d0d62f6@kernel.org>
In-Reply-To: <20241031002326.3426181-2-csander@purestorage.com>
References: <20241031002326.3426181-1-csander@purestorage.com>
	<20241031002326.3426181-2-csander@purestorage.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 30 Oct 2024 18:23:26 -0600 Caleb Sander Mateos wrote:
> In a heavy TCP workload, mlx5e_handle_rx_dim() consumes 3% of CPU time,
> 94% of which is attributed to the first push instruction to copy
> dim_sample on the stack for the call to net_dim():

Change itself looks fine, so we can apply, but this seems surprising.
Are you sure this is not just some measurement problem?
Do you see 3% higher PPS with this change applied?

