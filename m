Return-Path: <linux-rdma+bounces-5507-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 21D039AE9D5
	for <lists+linux-rdma@lfdr.de>; Thu, 24 Oct 2024 17:08:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B4F9DB22B5B
	for <lists+linux-rdma@lfdr.de>; Thu, 24 Oct 2024 15:08:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3AE41E5735;
	Thu, 24 Oct 2024 15:08:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VRX0N7si"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB4491DE88A;
	Thu, 24 Oct 2024 15:08:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729782513; cv=none; b=sV5M70aKFzsXaRSscRjzPGGi7HtF7TGOVCbZMhgSHrlzmPI/m+dQD/All1ypRnlQEnEnEqbcUMmIRrN59xZcW8nZC00JmdzZEyKg0kzXLnWZGjpO+VxrCeA7DU7e/eEVhF09Trv3Wt3FiTIMYPtTf0hxfMwuH4NubKyptv2cxzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729782513; c=relaxed/simple;
	bh=zvFy7SMRV7RIE8qBQI90d7gJxb1Onz9z6tlm3SkmxMw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gqcwov5rwg2TuzlXUf3ARS883Z4Ng2wNCB0JcR9Lof/QyyH7OoWFIgU90zgVamn01QJ0/xawKIGPf2OjVRGgrTtNkLAK+0Abl20Bt/7RX42ghwaP4VSkC3t4h5RVqxsjRytn+xEdPciJ4F08x3DjWPZZ5JOPstk6JTm/WJ9fWLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VRX0N7si; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF334C4CEE3;
	Thu, 24 Oct 2024 15:08:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729782513;
	bh=zvFy7SMRV7RIE8qBQI90d7gJxb1Onz9z6tlm3SkmxMw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VRX0N7si/W7zicqC3qmbFhJrfTBECTKDVFMuaumaC9VRecF29k8z9jp57fhcXOgqy
	 FwoSpRQ6MHFPy6OgDT30RUq8P1VRLgA/YTrPPgQOEXeg4QUzS6Ji4hvgAFuAd/bseH
	 GcaMENgyrUFUud3ZmA6AFvmgNdfuUjK9l2kxfMTYJtOGJ8kXl/CIz2UlqKHgH1EHhn
	 19rvV2ceFRRDXJmStsKP9/KHxTXtJtAWUcucLZSttHisrttJDIS3Nscv1I8t0hkHLT
	 EWTX55674DURM5zChwAPSsSVAqTV92m5ev2nv9V+K1wUV5/O9/un6X+16uq4QnANdR
	 9sisW1CXJ8fow==
Date: Thu, 24 Oct 2024 16:08:28 +0100
From: Simon Horman <horms@kernel.org>
To: Caleb Sander Mateos <csander@purestorage.com>
Cc: Saeed Mahameed <saeedm@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>,
	Leon Romanovsky <leon@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mlx5: fix typo in "mlx5_cqwq_get_cqe_enahnced_comp"
Message-ID: <20241024150828.GW1202098@kernel.org>
References: <20241023164840.140535-1-csander@purestorage.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241023164840.140535-1-csander@purestorage.com>

On Wed, Oct 23, 2024 at 10:48:38AM -0600, Caleb Sander Mateos wrote:
> "enahnced" looks to be a misspelling of "enhanced".
> Rename "mlx5_cqwq_get_cqe_enahnced_comp" to
> "mlx5_cqwq_get_cqe_enhanced_comp".
> 
> Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>

Reviewed-by: Simon Horman <horms@kernel.org>


