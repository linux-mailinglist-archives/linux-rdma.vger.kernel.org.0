Return-Path: <linux-rdma+bounces-14204-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B8280C2C50A
	for <lists+linux-rdma@lfdr.de>; Mon, 03 Nov 2025 15:05:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1A2263B6410
	for <lists+linux-rdma@lfdr.de>; Mon,  3 Nov 2025 13:57:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DB4930E838;
	Mon,  3 Nov 2025 13:57:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rJK+hXBe"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17FF2291C19;
	Mon,  3 Nov 2025 13:57:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762178252; cv=none; b=SO0/P8wy8RkeNtxiZNKqHxbSIaAbvlJicOktUVXAMxMI2VfJnlfodRIKLHRcHMVTpnDcfh1ARGtUwFK5OnTmnIDxNDInsDibX5Ox0ohti/OSAnNHQ/nnF4NtOJPjsx++igwfgT6IwBzNRS9hkhkUm21AxXH7AYGiwn21NDoQwhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762178252; c=relaxed/simple;
	bh=cpGGgtOoU/nhwXahujjlsp47ByjjBmijG07MPfVCKNQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YlOGXFV+gnR9hVTiooOo0UnVKggsfNvz8qkvJeH4H4LaC3ZSaLQHEXxFVBYIMTkUWuIj/Ftm0GHcWPH/OZS/A0o8DxZLKbqkPGNKJN5bYuMRChWHJiC+7mpszItyV722Hd0QgblF/NTj8eia9+CaWf2WtetD27r5oAGkVFDyMw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rJK+hXBe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0A16C4CEFD;
	Mon,  3 Nov 2025 13:57:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762178251;
	bh=cpGGgtOoU/nhwXahujjlsp47ByjjBmijG07MPfVCKNQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rJK+hXBed15wVkBd2o1mqWDjbTICqTJJmNHE8aK9VgSF+57OFeodJR/dBz42V/ypl
	 96jzN6i1oQJxC+s+uThHKmjfB2GfxDP64IttOJZvtvVXOc7sCFaWyo612lH0c00Z8d
	 T0WObQEVZAbclMLNzYETnZ7gHRyeWOKYDxRVxx2+qrf//GqyEVJyBXfk5C68LygpYO
	 hQY3cQ6ZQ0fYIpnfCDQUGy1ykRaM25xiSWnshexTxGc/8jbhPvxCgTMYrV+KUF12eZ
	 6t/sa/v+7qL4Ni51pVvZy3B2q2yRNUyepJZpWf7OUgwVUJ/2Qm/HsY11sNPYEktg3y
	 2oaUo05/1NQbA==
Date: Mon, 3 Nov 2025 13:57:26 +0000
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
Subject: Re: [PATCH net-next V2 2/7] net/mlx5e: Use TIR API in
 mlx5e_modify_tirs_lb()
Message-ID: <aQi0xj8cnb6Isxj6@horms.kernel.org>
References: <1761831159-1013140-1-git-send-email-tariqt@nvidia.com>
 <1761831159-1013140-3-git-send-email-tariqt@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1761831159-1013140-3-git-send-email-tariqt@nvidia.com>

On Thu, Oct 30, 2025 at 03:32:34PM +0200, Tariq Toukan wrote:
> Extend the TIR API and use it in mlx5e_modify_tirs_lb() instead of the
> explicit modify_tir code.
> 
> Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
> Reviewed-by: Carolina Jubran <cjubran@nvidia.com>
> Reviewed-by: Dragos Tatulea <dtatulea@nvidia.com>

Reviewed-by: Simon Horman <horms@kernel.org>


