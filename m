Return-Path: <linux-rdma+bounces-14256-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8738EC35199
	for <lists+linux-rdma@lfdr.de>; Wed, 05 Nov 2025 11:29:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8960D3A846A
	for <lists+linux-rdma@lfdr.de>; Wed,  5 Nov 2025 10:28:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EACAF3016EE;
	Wed,  5 Nov 2025 10:27:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PXZkYDXt"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FD7F30100B;
	Wed,  5 Nov 2025 10:27:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762338475; cv=none; b=r+mkKQUXAbHQuN407iwPQD1FIjcRYmTkZ9i90sZu/WNUdFWM5aDq6bru4IWAUh+g55ZjfFmVBUqolGWDpQHZkhE7uRUfo0BdLSO3ejl+z2oLO28DCnLxE34MgZzwREo6gZKsf8vU4geyCrVtDE9Sq/SJb3InL7P4tAXzq+71od8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762338475; c=relaxed/simple;
	bh=q31WPEl8Jt9/OnM8b/MAO6fymcrIH34q+vbmU3aPbzs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ain+ewAsdMDkPMi4+Drlp293I0TipYmpp3C7Iwi3/yRKl44TG6mtng3FGqLoKh2e0+uPHINqwyO8TH9wXcYKaKrVMaPktX1bDdNQp31QkVy3HSOoiNUSzo5xKYa0GDzB+N2MICzxR5PmME01GM1Tm5i8f2l4y5dCNblCiIZuWSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PXZkYDXt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91C5AC4CEF8;
	Wed,  5 Nov 2025 10:27:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762338475;
	bh=q31WPEl8Jt9/OnM8b/MAO6fymcrIH34q+vbmU3aPbzs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PXZkYDXtvsQy+Pzv3J2aSV2+V4MWDiTjER5x6xBRlKx2lK8Pmu24r56zb/A7V9UJP
	 KejKVl8EOOhLXQ1b6vSj1jyZ9cnAFlJ9qYxNBhXGBcVc/S7xpLESJ6hkJMGMdh/+yU
	 k6ffT7PDMbf6y8AWVUwmPBmFECPY1icDYLfzictk3yvzwo1q5NS5Bi3m11GHAMuv9r
	 TILKZAil/CIcwYYpCKT0GsIZeFDmpiweS1D6tuNmiPNlZsZU/c7rKgno31OOWILemw
	 BDwEBmoe3tzhxKAE28EMd2xGSkCcvtyJJWAomvYEqHLbm1b228MmHSbqjA/RCJ+9Kk
	 QXT5EgWJXddBw==
Date: Wed, 5 Nov 2025 10:27:50 +0000
From: Simon Horman <horms@kernel.org>
To: Tariq Toukan <tariqt@nvidia.com>
Cc: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Saeed Mahameed <saeedm@nvidia.com>, Mark Bloch <mbloch@nvidia.com>,
	Leon Romanovsky <leon@kernel.org>, netdev@vger.kernel.org,
	linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
	Gal Pressman <gal@nvidia.com>, Alex Lazar <alazar@nvidia.com>
Subject: Re: [PATCH net] net/mlx5e: Fix return value in case of module EEPROM
 read error
Message-ID: <aQsmpgIU-cbbRykF@horms.kernel.org>
References: <1762265736-1028868-1-git-send-email-tariqt@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1762265736-1028868-1-git-send-email-tariqt@nvidia.com>

On Tue, Nov 04, 2025 at 04:15:36PM +0200, Tariq Toukan wrote:
> From: Gal Pressman <gal@nvidia.com>
> 
> mlx5e_get_module_eeprom_by_page() has weird error handling.
> 
> First, it is treating -EINVAL as a special case, but it is unclear why.
> 
> Second, it tries to fail "gracefully" by returning the number of bytes
> read even in case of an error. This results in wrongly returning
> success (0 return value) if the error occurs before any bytes were
> read.
> 
> Simplify the error handling by returning an error when such occurs. This
> also aligns with the error handling we have in mlx5e_get_module_eeprom()
> for the old API.
> 
> This fixes the following case where the query fails, but userspace
> ethtool wrongly treats it as success and dumps an output:
> 
>   # ethtool -m eth2
>   netlink warning: mlx5_core: Query module eeprom by page failed, read 0 bytes, err -5
>   netlink warning: mlx5_core: Query module eeprom by page failed, read 0 bytes, err -5
>   Offset		Values
>   ------		------
>   0x0000:		00 00 00 00 05 00 04 00 00 00 00 00 05 00 05 00
>   0x0010:		00 00 00 00 05 00 06 00 50 00 00 00 67 65 20 66
>   0x0020:		61 69 6c 65 64 2c 20 72 65 61 64 20 30 20 62 79
>   0x0030:		74 65 73 2c 20 65 72 72 20 2d 35 00 14 00 03 00
>   0x0040:		08 00 01 00 03 00 00 00 08 00 02 00 1a 00 00 00
>   0x0050:		14 00 04 00 08 00 01 00 04 00 00 00 08 00 02 00
>   0x0060:		0e 00 00 00 14 00 05 00 08 00 01 00 05 00 00 00
>   0x0070:		08 00 02 00 1a 00 00 00 14 00 06 00 08 00 01 00
> 
> Fixes: e109d2b204da ("net/mlx5: Implement get_module_eeprom_by_page()")
> Signed-off-by: Gal Pressman <gal@nvidia.com>
> Reviewed-by: Alex Lazar <alazar@nvidia.com>
> Signed-off-by: Tariq Toukan <tariqt@nvidia.com>

Thanks for the detailed description.

Reviewed-by: Simon Horman <horms@kernel.org>

