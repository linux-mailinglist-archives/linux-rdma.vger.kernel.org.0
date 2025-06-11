Return-Path: <linux-rdma+bounces-11195-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 96D87AD56EE
	for <lists+linux-rdma@lfdr.de>; Wed, 11 Jun 2025 15:27:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D0AF817E01F
	for <lists+linux-rdma@lfdr.de>; Wed, 11 Jun 2025 13:27:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86CA6288CAC;
	Wed, 11 Jun 2025 13:26:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e9ddoPFR"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C5121E485;
	Wed, 11 Jun 2025 13:26:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749648416; cv=none; b=IsbCzJXSay9xPlAn1u7xoTk0YsyoP9+/256pVedACSzgU/pDP1y7whPDCBmUkySI8dW2Ikfg0dGibF6V9Pbp26+v+OwB0YIHOslhTaFkfMG1PzzHmwu579UsOiB9+tJqZJbdFdAAp4TPkZffTtvtPDik99H0hfDKKhaJF0INnfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749648416; c=relaxed/simple;
	bh=vbwcuWtgss35ajrLrHboTtuHCKz3So3tZuLGqqgzqxg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LEO5gBILa5SkaGdym82y4fVLFb5l/I2IAsexEyp3L2Oy6CVAfcSbf+/lOblAiaD/RfyU35vBBmbY/hGFhsCwU5wRuTkz2eGxjbJ+0NAceOOQUjvH81gnRCch73YzijGPnW2tjWWI6X4QT7s6bwnZL3xr7i2s1h4G9f19bPqWSbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e9ddoPFR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43654C4CEEE;
	Wed, 11 Jun 2025 13:26:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749648415;
	bh=vbwcuWtgss35ajrLrHboTtuHCKz3So3tZuLGqqgzqxg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=e9ddoPFR/62sJ9VNWweEfQqnVjz3CpbLj+bvFc2SdYnWdlnov6I6J1AhB9rTatYv4
	 damu10gthPC8BqmorY4pXnsScsut0Uy5e+wQbe3cBRsKHPGq+5LKsksNC1R1qDMe3h
	 EeBGVnisaXHNHmAyUi4bIWTS9yvmVFU0zpg6cKHoR31LkRfvNWjAzdMS2WPncyvgt+
	 dciuLCKCB8/Os9ZTQTX4aV3YKL1nEzDH5OzXEAnUcEzkXmMdaoUrg4BA/mx9dOmuPx
	 20WwMbgFeKocBim/wYVONCKxrOWGo2kU9WPHInKAnHeT8sy9QHjoBkHilrNpPUaDfh
	 1X5iv0LmvKboA==
Date: Wed, 11 Jun 2025 06:26:54 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Mark Bloch <mbloch@nvidia.com>
Cc: "David S. Miller" <davem@davemloft.net>, Paolo Abeni
 <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, "Andrew Lunn"
 <andrew+netdev@lunn.ch>, <saeedm@nvidia.com>, <gal@nvidia.com>,
 <leonro@nvidia.com>, <tariqt@nvidia.com>, Leon Romanovsky
 <leon@kernel.org>, <netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, Dragos Tatulea <dtatulea@nvidia.com>,
 "Cosmin Ratiu" <cratiu@nvidia.com>
Subject: Re: [PATCH net-next v4 09/11] net/mlx5e: Implement queue mgmt ops
 and single channel swap
Message-ID: <20250611062654.5121229b@kernel.org>
In-Reply-To: <20250610150950.1094376-10-mbloch@nvidia.com>
References: <20250610150950.1094376-1-mbloch@nvidia.com>
	<20250610150950.1094376-10-mbloch@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 10 Jun 2025 18:09:48 +0300 Mark Bloch wrote:
> +	mdev = mlx5_sd_ch_ix_get_dev(priv->mdev, queue_index);
> +	err = mlx5e_build_channel_param(mdev, &params, &new->cparam);
> +	if (err) {
> +		return err;
> +		goto unlock;

missed this nugget yesterday, sorry..

> +	}

