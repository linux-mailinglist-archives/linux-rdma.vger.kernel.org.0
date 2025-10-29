Return-Path: <linux-rdma+bounces-14125-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CED9C1BE38
	for <lists+linux-rdma@lfdr.de>; Wed, 29 Oct 2025 17:00:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8EE08585FE9
	for <lists+linux-rdma@lfdr.de>; Wed, 29 Oct 2025 15:51:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3ED1633F8BC;
	Wed, 29 Oct 2025 15:50:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZRdaOinI"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5F77258CEF;
	Wed, 29 Oct 2025 15:50:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761753047; cv=none; b=piP1qA6vXSH//j8+Xqombe/U4hh+mEjOm0naHv3N+HRwq07gB9HeLLMSNNfiA2Gxzk985fkHMtQaj2Ma8Bn8Krnij3tjA7f/CEiuAtUCl00eoIMmVp+Og6Nlc9sgFNAElZZZYoPXL68mVFhH5bzuSOGRW+hzmlR6fk1Fs65eapk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761753047; c=relaxed/simple;
	bh=xiFnKhDvDCgGSqdY8HtE2ivJ6Wc0+hEJCMnS/4j3jZw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qYTIuFIJpTaevbKY8IOkT/qd79shH+OoKPOqUdV+MGyCOFLkujDx/hxaokOGlXRo9V9ZUrzDABkM1dT5kSibWLXL9ketzjLMZJOLuoIhVicO16+DqrNlmo8iR+z/NAnonzzC2R+BwvvHHy/2gKaAa4J9e4VqXtfvVvTTUd+n4Ks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZRdaOinI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF2BDC4CEF7;
	Wed, 29 Oct 2025 15:50:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761753046;
	bh=xiFnKhDvDCgGSqdY8HtE2ivJ6Wc0+hEJCMnS/4j3jZw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZRdaOinI6k5nlobzl2MEpY+Z/oAMRjDKf2sh+ZlhNN+fAj3lrhdCnraO1OHdRJjgD
	 SgsxO5XIIAa+HTshrJsmvQDOfgG9H2+SFhypYtUAAxGvDcyxelGspYGOm1rRJztdFU
	 fTNCbLJ2wiaj8hRCz8vJg1LOntsgx9xW94wjeaNkyF5QKVUDI1isKmvqOnR4dtW5MS
	 uwtr0l83vgv7Xa6oBO+5RjOSjX9DifgRzWSO2ypa63RQB0QRCc7i96/ahG8QpD6z90
	 98Fs+DyJR1wiQ4WyVqg+het+W03A4aaWaNKr4u+ERw2dcuUi9TkprxV/Hv2utv5ORf
	 wWmAaQVsdqT/A==
Date: Wed, 29 Oct 2025 15:50:41 +0000
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
	Dragos Tatulea <dtatulea@nvidia.com>
Subject: Re: [PATCH net 2/3] net/mlx5e: SHAMPO, Fix skb size check for 64K
 pages
Message-ID: <aQI30QptJw-xRGWQ@horms.kernel.org>
References: <1761634039-999515-1-git-send-email-tariqt@nvidia.com>
 <1761634039-999515-3-git-send-email-tariqt@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1761634039-999515-3-git-send-email-tariqt@nvidia.com>

On Tue, Oct 28, 2025 at 08:47:18AM +0200, Tariq Toukan wrote:
> From: Dragos Tatulea <dtatulea@nvidia.com>
> 
> mlx5e_hw_gro_skb_has_enough_space() uses a formula to check if there is
> enough space in the skb frags to store more data. This formula is
> incorrect for 64K page sizes and it triggers early GRO session
> termination because the first fragment will blow up beyond
> GRO_LEGACY_MAX_SIZE.
> 
> This patch adds a special case for page sizes >= GRO_LEGACY_MAX_SIZE
> (64K) which will uses the skb->data_len instead. Within this context,
> this check will be safe from fragment overflow.

The above mentions skb->data_len, but the code uses skb->len.

Also, I think it would be worth describing why this is safe
in this context.

> 
> It is expected that the if statement will be optimized out as the
> check is done with constants.
> 
> Fixes: 92552d3abd32 ("net/mlx5e: HW_GRO cqe handler implementation")
> Signed-off-by: Dragos Tatulea <dtatulea@nvidia.com>
> Signed-off-by: Tariq Toukan <tariqt@nvidia.com>

...

