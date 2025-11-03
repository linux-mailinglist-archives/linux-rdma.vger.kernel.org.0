Return-Path: <linux-rdma+bounces-14203-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AE082C2C477
	for <lists+linux-rdma@lfdr.de>; Mon, 03 Nov 2025 14:57:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2A5411884F33
	for <lists+linux-rdma@lfdr.de>; Mon,  3 Nov 2025 13:57:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5251D2E611B;
	Mon,  3 Nov 2025 13:57:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Vs83dZXC"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07AA6274B23;
	Mon,  3 Nov 2025 13:57:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762178232; cv=none; b=B3JT5+0Uvkh8xV4f3V/qQVxR+6fBfeU3jGgA8bMzBdXOjM+wopdVi3qB8pOkxucR5jpyn1Hos5By1CWzxjGNtbXJY6TO3zaCew5HK2voXoik7nKxqCfW/kY96AMJWDr4vYg412k81g3HgRUx2gJNc6csGMscVjYEOf+yPYCIoNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762178232; c=relaxed/simple;
	bh=hzY6n+eX6J17ms7RYj6QcyV+5xeIMI7YII9U78eOm4Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TyuyDRPpDMl9mJR6cnaFFXtQE6zpQWKvZVPKM/Yu1p1a79Qh4cZsNckv7akK1DkWwRnCe/oVE9LFjPnZQGyyTpKWoowzgRF+9eaFW6nMAcChFSCMjLFLJxphMTtrNxeLStC+ocgkm+/klb7S7DxVIuefBVuSe9fTLjz4BC3Na7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Vs83dZXC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8168C116B1;
	Mon,  3 Nov 2025 13:57:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762178231;
	bh=hzY6n+eX6J17ms7RYj6QcyV+5xeIMI7YII9U78eOm4Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Vs83dZXCssl3QeZOddSsshHZYo13LiOT2XDeEv7OUTXtQtK+a1F/HfaY1J0GtBFjJ
	 SvGRcKYhmUyhcI9uiSWV56oARNtEr+3atK3gG5vjFlf3E1FFLFe9myS3GTXJAx51PV
	 m3BQu+MC7L8HIYbENzpsGfWUftaUFhxIiZwa/oDOS7an08ATHw1MS/CKuOFYLbsLFa
	 Vt+gldEXPLK39Y7XTn+v1IR0BWUEze5aHzNGGuT9NknUmclxKDtVRfcReNmumxZAjd
	 K7qAM3rNaZh2VZh8icq5T4uzNDTz0GFw4iDMqr/AjFNcpPM39wUbu8Ofrn8f9RJj6W
	 ARxiQE7UX6dMw==
Date: Mon, 3 Nov 2025 13:57:06 +0000
From: Simon Horman <horms@kernel.org>
To: Tariq Toukan <tariqt@nvidia.com>
Cc: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Leon Romanovsky <leon@kernel.org>, Mark Bloch <mbloch@nvidia.com>,
	netdev@vger.kernel.org, linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org, Gal Pressman <gal@nvidia.com>,
	Carolina Jubran <cjubran@nvidia.com>
Subject: Re: [PATCH net-next V2 1/7] net/mlx5e: Enhance function structures
 for self loopback prevention application
Message-ID: <aQi0shozCDYfK1X2@horms.kernel.org>
References: <1761831159-1013140-1-git-send-email-tariqt@nvidia.com>
 <1761831159-1013140-2-git-send-email-tariqt@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1761831159-1013140-2-git-send-email-tariqt@nvidia.com>

On Thu, Oct 30, 2025 at 03:32:33PM +0200, Tariq Toukan wrote:
> The re-application of self loopback prevention attributes in TIRs is
> necessary in old firmwares (where tis_tir_td_order cap is cleared) after
> recreation of SQs.
> 
> However, this is not needed in new firmware with tis_tir_td_order=1.
> 
> As a preparation patch, enhance the function structures to differentiate
> between an explicit loopback prevention configuration apply, and the
> re-apply operation required by old firmware.
> 
> Loopback selftests should now call mlx5e_modify_tirs_lb() directly, as
> their use case is not related to the firmware limitation.
> 
> Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
> Reviewed-by: Carolina Jubran <cjubran@nvidia.com>

Reviewed-by: Simon Horman <horms@kernel.org>


