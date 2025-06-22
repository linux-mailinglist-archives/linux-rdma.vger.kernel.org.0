Return-Path: <linux-rdma+bounces-11527-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E4FB6AE32DA
	for <lists+linux-rdma@lfdr.de>; Mon, 23 Jun 2025 00:40:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 23ED53A65A8
	for <lists+linux-rdma@lfdr.de>; Sun, 22 Jun 2025 22:40:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1300E21D3EC;
	Sun, 22 Jun 2025 22:40:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="kBR0oqsd"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out-188.mta0.migadu.com (out-188.mta0.migadu.com [91.218.175.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAAD71FE470
	for <linux-rdma@vger.kernel.org>; Sun, 22 Jun 2025 22:40:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750632022; cv=none; b=WkrrNV1gG5jMjfI7n6nW9vRJsPeGm5iyrScsHQ8ZNbItN2comVuJhcmQ53fS25Rqgp8xmPWHLicaoomAKBC/nNyQQchbUahSKueODCsaiESS0pzy8+AAC9NG/WPoJSOasHw+5llJppdT9W4NDvsPMQhsjWBWP5fBRqXDmEO8Wjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750632022; c=relaxed/simple;
	bh=NtNiMvKdOWr3HqkXnYgNIycEVjCa6Icct59Mbr/Nz2k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mZP/mJwgEnzayl2+B+ZWvs96gseOZvYqh8wCyT6mpTLI4OWWX8y4H2UkQOIsghH9juqgdYBFwktI7W7zoZYkGOhFAPjIm9R6/H24N3FlcQYd/mdbgSDMpJwsbi/ZlgtAxTSMhLjcRZieRfRe82GENrxYHYDBmSsLnqL4JCkBPPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=kBR0oqsd; arc=none smtp.client-ip=91.218.175.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <8ed873ce-619d-4bdd-8fba-222320229efe@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1750632008;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Y7Sy6lOD9pKGTeDWHlQhBUIbqmjZyBGP1EAU8WiJo4s=;
	b=kBR0oqsdgRAxdmgUMJDEVuGLu8q7wZFZrkw2kY2Ty5EzASKQorg1pEsBMR70YK25OhD7K3
	XYxxKHegpUhVvZ76kB7HSR5/RqIez09ZtrG5AZzqHqwR5pnUkMSQQI+JWJwnGHBgV0MOi9
	slP+7NTxaCfXk70+nJc87idbF+oItI4=
Date: Sun, 22 Jun 2025 15:39:54 -0700
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net-next v2 0/8] net/mlx5: HWS, Optimize matchers ICM
 usage
To: Mark Bloch <mbloch@nvidia.com>, "David S. Miller" <davem@davemloft.net>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Eric Dumazet <edumazet@google.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 Simon Horman <horms@kernel.org>
Cc: saeedm@nvidia.com, gal@nvidia.com, leonro@nvidia.com, tariqt@nvidia.com,
 Leon Romanovsky <leon@kernel.org>, netdev@vger.kernel.org,
 linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org, moshe@nvidia.com
References: <20250622172226.4174-1-mbloch@nvidia.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Zhu Yanjun <yanjun.zhu@linux.dev>
In-Reply-To: <20250622172226.4174-1-mbloch@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

在 2025/6/22 10:22, Mark Bloch 写道:
> This series optimizes ICM usage for unidirectional rules and
> empty matchers and with the last patch we make hardware steering
> the default FDB steering provider for NICs that don't support software
> steering.

In this patchset, ICM is not explained. I googled this ICM. And I got 
the following

"
ICM stands for Internal Context Memory, a specialized memory region used 
by Mellanox/NVIDIA network devices (e.g., ConnectX series NICs) to store 
hardware context and rule tables for offloaded operations like flow 
steering, filtering, and traffic redirection.

ICM is crucial when using hardware steering (HWS), where the NIC itself 
performs packet matching and forwarding without involving the host CPU.
"
If I am missing something, please correct me.

Zhu Yanjun

> 
> Hardware steering (HWS) uses a type of rule table container (RTC) that
> is unidirectional, so matchers consist of two RTCs to accommodate
> bidirectional rules.
> 
> This small series enables resizing the two RTCs independently by
> tracking the number of rules separately. For extreme cases where all
> rules are unidirectional, this results in saving close to half the
> memory footprint.
> 
> Results for inserting 1M unidirectional rules using a simple module:
> 
> 			Pages		Memory
> Before this patch:	300k		1.5GiB
> After this patch:	160k		900MiB
> 
> The 'Pages' column measures the number of 4KiB pages the device requests
> for itself (the ICM).
> 
> The 'Memory' column is the difference between peak usage and baseline
> usage (before starting the test) as reported by `free -h`.
> 
> In addition, second to last patch of the series handles a case where all
> the matcher's rules were deleted: the large RTCs of the matcher are no
> longer required, and we can save some more ICM by shrinking the matcher
> to its initial size.
> 
> Finally the last patch makes hardware steering the default mode
> when in swichdev for NICs that don't have software steering support.
> 
> Changelog
> =========
> Changes from v1 [0]:
> - Fixed author on patches 5 and 6.
> 
> References
> ==========
> [0] v1: https://lore.kernel.org/all/20250619115522.68469-1-mbloch@nvidia.com/
> 
> Moshe Shemesh (1):
>    net/mlx5: Add HWS as secondary steering mode
> 
> Vlad Dogaru (5):
>    net/mlx5: HWS, remove unused create_dest_array parameter
>    net/mlx5: HWS, Refactor and export rule skip logic
>    net/mlx5: HWS, Create STEs directly from matcher
>    net/mlx5: HWS, Decouple matcher RX and TX sizes
>    net/mlx5: HWS, Track matcher sizes individually
> 
> Yevgeny Kliteynik (2):
>    net/mlx5: HWS, remove incorrect comment
>    net/mlx5: HWS, Shrink empty matchers
> 
>   .../net/ethernet/mellanox/mlx5/core/fs_core.c |   2 +
>   .../mellanox/mlx5/core/steering/hws/action.c  |   7 +-
>   .../mellanox/mlx5/core/steering/hws/bwc.c     | 284 ++++++++++++++----
>   .../mellanox/mlx5/core/steering/hws/bwc.h     |  14 +-
>   .../mellanox/mlx5/core/steering/hws/debug.c   |  20 +-
>   .../mellanox/mlx5/core/steering/hws/fs_hws.c  |  15 +-
>   .../mellanox/mlx5/core/steering/hws/matcher.c | 166 ++++++----
>   .../mellanox/mlx5/core/steering/hws/matcher.h |   3 +-
>   .../mellanox/mlx5/core/steering/hws/mlx5hws.h |  36 ++-
>   .../mellanox/mlx5/core/steering/hws/rule.c    |  35 +--
>   .../mellanox/mlx5/core/steering/hws/rule.h    |   3 +
>   11 files changed, 403 insertions(+), 182 deletions(-)
> 
> 
> base-commit: 091d019adce033118776ef93b50a268f715ae8f6


