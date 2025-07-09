Return-Path: <linux-rdma+bounces-12008-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A00F3AFEFCC
	for <lists+linux-rdma@lfdr.de>; Wed,  9 Jul 2025 19:26:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 236CE4E8A25
	for <lists+linux-rdma@lfdr.de>; Wed,  9 Jul 2025 17:25:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 771B723908B;
	Wed,  9 Jul 2025 17:24:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ek/d6c5u"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 307D7233707;
	Wed,  9 Jul 2025 17:24:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752081892; cv=none; b=EWWGprXUXxtCuS3/OI+q+gN8FCFEiDGaocc5CCgi1XJ5ImFUOMHBpvdbIhz7N3YCw5JlWCmn8dQbhoo0pkV6gLCaVG3F9RR/nDqOzv5+OiY0ackJ1YrfecnDDlPD1luTgsXY8UJPgcMz0tjOVSw90ESW6dGX3sfvSdiL3kdHELQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752081892; c=relaxed/simple;
	bh=PpxpsCUmWXh+r3iT6P3oX331Jckhe/cc+FUBdsFASvI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GBK7/XQPScr2cdHok9v0E50pXH/ILlZWfNFCV482xy7Joxz3/wyfhyqIaGf/KuTISIMPLnrMbg/ronJ1Ov9Sc5FM3HAmTkXgRK+LifgXoOH0ybh7F6VfHtCNQjxKif4e8lMt7erOm92uWH94LVBpHF93cnmSGKOPJgmZ/n2tN1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ek/d6c5u; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1ABA2C4CEEF;
	Wed,  9 Jul 2025 17:24:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752081891;
	bh=PpxpsCUmWXh+r3iT6P3oX331Jckhe/cc+FUBdsFASvI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ek/d6c5uKl8jQLY42GtwpkcKZl1BbybXnYf6DEbHqpreI59Py53NjrQi3BYoMR0tA
	 AoIn9lDfDsj++sqXq3w9ZSEsNa5zyhoMQPD+b1TB/oFO3NbGhl7kf4MNvGbZGD4rE2
	 zKaqy4xuPVGqSY5ttqJdIcHcCFG3gt34ei7yMt1REa41AFheREEchkQITxrNcaZGSs
	 8yyJYRXl/Yn34KZqOPnTvM3G9q5+3SzE8oQ8s7q9cNBY95c77yAzY6PwrF4L+jdNF7
	 9+71QcGv7kvJrbJ2EDMIbjS3k2GbsRVZAncDcmYdAmwSZi5uvSFcurfGZ9hpfTs9nO
	 xCMjUVrWzOZpg==
Date: Wed, 9 Jul 2025 18:24:46 +0100
From: Simon Horman <horms@kernel.org>
To: Tariq Toukan <tariqt@nvidia.com>
Cc: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Saeed Mahameed <saeed@kernel.org>, Gal Pressman <gal@nvidia.com>,
	Leon Romanovsky <leon@kernel.org>,
	Saeed Mahameed <saeedm@nvidia.com>, Mark Bloch <mbloch@nvidia.com>,
	netdev@vger.kernel.org, linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 5/5] net/mlx5e: RX, Remove unnecessary RQT
 redirects
Message-ID: <20250709172446.GF721198@horms.kernel.org>
References: <1752009387-13300-1-git-send-email-tariqt@nvidia.com>
 <1752009387-13300-6-git-send-email-tariqt@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1752009387-13300-6-git-send-email-tariqt@nvidia.com>

On Wed, Jul 09, 2025 at 12:16:27AM +0300, Tariq Toukan wrote:
> RQTs (Receive Queue Table) should redirect traffic to the channels' RQs
> when they're active.  Otherwise, redirect to the designated "drop RQ".
> 
> RQTs are created in "inactive" state, pointing to the "drop RQ".
> In activate and de-activate flows, do not "deactivate" the rest of RQTs
> (beyond the num of channels), as they are already inactive.
> 
> This cuts down unnecessary execution of FW commands (MODIFY_RQT), and
> improves the latency of open/close channels or configuration change.
> 
> Perf:
> NIC: Connect-X7.
> Configuration: 1 combined channel, max num channels 248.
> Measure time for "interface up + interface down".
> 
> Before: 0.313 sec
> After:  0.057 sec (5.5x faster)
> 
> 247 MODIFY_RQT commands saved in interface up.
> 247 MODIFY_RQT commands saved in interface down.
> 
> Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
> Reviewed-by: Dragos Tatulea <dtatulea@nvidia.com>

Reviewed-by: Simon Horman <horms@kernel.org>


