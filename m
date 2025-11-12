Return-Path: <linux-rdma+bounces-14415-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 550C5C51305
	for <lists+linux-rdma@lfdr.de>; Wed, 12 Nov 2025 09:51:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A6CC2189E109
	for <lists+linux-rdma@lfdr.de>; Wed, 12 Nov 2025 08:50:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E7012FF14D;
	Wed, 12 Nov 2025 08:49:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K5gy+rox"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22A952FE59F;
	Wed, 12 Nov 2025 08:49:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762937370; cv=none; b=ugzPs0lcUwFmJJ5TPmi7CUgGb+9hbpudMMLYHJgk9vC5JBq8WSFAxxoh6UjFdkCCdTAhyXCp0Le3qZ31RrZvVGTgk9Oz1GEKqRN1V6KZagIIwx191HFuEgagxnGC/TTK2hbxod3kwkF8eJqaKT12Ne7BnrtAq4Ix0P7zOb7nSP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762937370; c=relaxed/simple;
	bh=2bO5GWa+ksv9jGsVNAnzNxpubiaRSvTea9kOBIEkY9U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ELuj7VTFNA4NpFJOvqCJfS/aiqB9Jv5YGkM9+IAIiPumDslQVcg5T2FGfrSgFERQ5ybcaEUkSyWfPtupzLIY2MQdfUw/r+CStPjhAa/YCNCBdXSlrUhnnulGMFEJrHfOK7W8DaUaowSSudZ0l5CPTnZTLVSdNWGje0U+VF6Z8Jw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K5gy+rox; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1A04C19423;
	Wed, 12 Nov 2025 08:49:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762937369;
	bh=2bO5GWa+ksv9jGsVNAnzNxpubiaRSvTea9kOBIEkY9U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=K5gy+roxD18z3MEqbjnOvxq6B5kD3+i+UwwtlGkDQDdcM4ZHNNvOlmpTtmuxX1jzy
	 zjBjml3qpPwjw/f4KZkv7XfN8iSfVoMIDmjNJZoTxjMDmd93/3ES9To+jWx70yXAOT
	 FgheutwT+AvgEnoWpUqyirE6GahkdS9SvYgT5ip0NJvTjmNUAOaaTHOuk1Msx44f8d
	 kPWanXzUZ1baLPJGKkMRflcfN62C+07EK78hcLoTzSZdCffLT1LngDpu5TNkV1Cfod
	 29VoGLgLf9ER9jlqfagt+9IXOVkaao3olRdxwVLXHLW/0AnQr5Uwl4O4XZE/nwWOeM
	 B+qlu2rRUtRHA==
From: Leon Romanovsky <leon@kernel.org>
To: Saeed Mahameed <saeedm@nvidia.com>,
	Leon Romanovsky <leon@kernel.org>,
	Mark Bloch <mbloch@nvidia.com>,
	netdev@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Tariq Toukan <tariqt@nvidia.com>
Cc: Leon Romanovsky <leonro@nvidia.com>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Gal Pressman <gal@nvidia.com>,
	Yael Chemla <ychemla@nvidia.com>,
	Moshe Shemesh <moshe@nvidia.com>,
	Shahar Shitrit <shshitrit@nvidia.com>,
	Maher Sanalla <msanalla@nvidia.com>
Subject: Re: [PATCH mlx5-next] net/mlx5: Expose definition for 1600Gbps link mode
Date: Wed, 12 Nov 2025 10:49:13 +0200
Message-ID: <176293717267.866356.6687904087070835949.b4-ty@nvidia.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <1762863888-1092798-1-git-send-email-tariqt@nvidia.com>
References: <1762863888-1092798-1-git-send-email-tariqt@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Leon Romanovsky <leonro@nvidia.com>


On Tue, 11 Nov 2025 14:24:48 +0200, Tariq Toukan wrote:
> This patch exposes new link mode for 1600Gbps, utilizing 8 lanes at
> 200Gbps per lane.
> 
> 

Applied, thanks!

[1/1] net/mlx5: Expose definition for 1600Gbps link mode

Best regards,
-- 
Leon Romanovsky <leonro@nvidia.com>

