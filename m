Return-Path: <linux-rdma+bounces-12004-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B7DEAFEFBE
	for <lists+linux-rdma@lfdr.de>; Wed,  9 Jul 2025 19:24:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 27D5E4E7597
	for <lists+linux-rdma@lfdr.de>; Wed,  9 Jul 2025 17:23:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D21FD225A24;
	Wed,  9 Jul 2025 17:23:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YUUQigDE"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A5751C8632;
	Wed,  9 Jul 2025 17:23:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752081836; cv=none; b=eruJtDIJ/8kKNqTKT+6ct14COPp56FcaVJudkebgNqyUSRx+GLH5QobYcf0sJa43/s1MyZuUXI30grXBx1vyhClX8Ijo+h5pPhUR8rboLngO872F5XV27CqvoioDMcTnkqItYFLIgfzmBqCEUaCRKYwE4l+2FHnlPhdYTLztLHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752081836; c=relaxed/simple;
	bh=spYPf+hN+6VEuQD/cFj4F2M8BbifQfOBKlaIvGJJy2k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PPceQIEA9NkX7FthRLuaiPiTUpBoaxKxCer7HMytEBCw0z9kcQ2NGDWA64Z6RiaJoDpUXhdvamGteGvEzShiQoqzkdeQKpupHSGwIaKlSUgthuXTj4fSc72J6AMlO4RM9Mub8BiDtiI0Xo4N3ZqyxwT49PyQ8unUiizD77swlIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YUUQigDE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 433DDC4CEEF;
	Wed,  9 Jul 2025 17:23:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752081836;
	bh=spYPf+hN+6VEuQD/cFj4F2M8BbifQfOBKlaIvGJJy2k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YUUQigDEVdw/WGzpfMsfZJpKudAJcZK1ag4BOOngOh3LJiPg0aJtKDEmWmMKbJUbh
	 lTLgO77dP093pmSrqtlHuRHvOAaG+gnJmmKNvCVhzxMkPTCD2QKxQAp47Cb9SFDwSU
	 9cf7VXE1Q288kJhox4/HJN43ucKxIx6naJl/CLHhP0w8YZ2FHQDOKkUK0nBU0gYubh
	 HjQVmSFMlagJXvroLg3Z9/n7OJdusmcufuzZzg7lg28f7lgSI91nwNatp1eW4j1XmB
	 +ig8QB0zFwJUJeQTz0BW4rjCQ0EB93MpdrmHABbOjNIrsM24Evq6NF4oQ3ZI+Alar4
	 Cbn1C248FTD/g==
Date: Wed, 9 Jul 2025 18:23:51 +0100
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
	linux-kernel@vger.kernel.org, Carolina Jubran <cjubran@nvidia.com>
Subject: Re: [PATCH net-next 1/5] net/mlx5e: Remove unused VLAN insertion
 logic in TX path
Message-ID: <20250709172351.GB721198@horms.kernel.org>
References: <1752009387-13300-1-git-send-email-tariqt@nvidia.com>
 <1752009387-13300-2-git-send-email-tariqt@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1752009387-13300-2-git-send-email-tariqt@nvidia.com>

On Wed, Jul 09, 2025 at 12:16:23AM +0300, Tariq Toukan wrote:
> From: Carolina Jubran <cjubran@nvidia.com>
> 
> The VLAN insertion capability (`wqe_vlan_insert`) was never enabled on
> all mlx5 devices. When VLAN TX offload is advertised but this
> capability is not supported, the driver uses inline headers to insert
> the VLAN tag.
> 
> To support this, the driver used to set the
> `MLX5E_SQ_STATE_VLAN_NEED_L2_INLINE` bit to enforce L2 inline mode
> when `wqe_vlan_insert` was not supported. Since the capability is
> disabled on all devices, this logic was always active, and the SQ flag
> has become redundant. L2 inline is enforced unconditionally for
> VLAN-tagged packets.
> 
> The `skb_vlan_tag_present()` check in the else-if block of
> `mlx5e_sq_xmit_wqe()` is never true by this point in the TX flow,
> as the VLAN tag has already been inserted by the driver using inline
> headers. As a result, this code is never executed.
> 
> Remove the redundant SQ state, dead VLAN insertion code block, and
> related logic.
> 
> Signed-off-by: Carolina Jubran <cjubran@nvidia.com>
> Signed-off-by: Tariq Toukan <tariqt@nvidia.com>

Reviewed-by: Simon Horman <horms@kernel.org>


