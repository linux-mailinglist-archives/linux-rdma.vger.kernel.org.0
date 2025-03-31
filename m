Return-Path: <linux-rdma+bounces-9035-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 45CDFA76382
	for <lists+linux-rdma@lfdr.de>; Mon, 31 Mar 2025 11:46:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DEB27168DAF
	for <lists+linux-rdma@lfdr.de>; Mon, 31 Mar 2025 09:46:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DD451DE3A8;
	Mon, 31 Mar 2025 09:46:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RTaQDn90"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D924015530C;
	Mon, 31 Mar 2025 09:46:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743414387; cv=none; b=LCQtycd/+8l7RNjEc3SRpjJ2Nq4xLcO/uYDrtpAcjbOufl/jqAO24som3h6wbsDN/yrC58D/H7+okOYfWeDCpDOJLJhl/uKGPkSK2j5bpHFslY6C3nEqkf4ImF67WUS+9D+se5edfHHW6wYs/rqLJWlsX1wxUj5hGtQUdGD/BWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743414387; c=relaxed/simple;
	bh=g1+ij7m0OuhsbiPM4u6lgUBTe8ieZRUPTVC9ILI4Mfo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LITJHDBVhSGboapM9ynD6Fo9Zu3IKIyyeFT81iCREAV0r2RpWOFhrNMw82GRTTOdKEZGibv2RE3JZ2otL7Y7AD59bCF8q1M6/I6IQwcHW80kJvb+GXaXvvyn9I3IQIrOKFS7RIGiyx22s21jSZWfTq4kqQt4dS3I0pAeGzhvY4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RTaQDn90; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2BA57C4CEE3;
	Mon, 31 Mar 2025 09:46:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743414386;
	bh=g1+ij7m0OuhsbiPM4u6lgUBTe8ieZRUPTVC9ILI4Mfo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RTaQDn909pe4vv4mKnVRT7nCZ0o2An68NrLMEUGsTiHFtaYXbtAC2Paz51E6bzasG
	 0nQpnj526W+XVS4ETeWdV0TrNC86cLGT/XCJ4ucXA/JXVlRlYKbiIUWTue1L8s4c+w
	 RMT6hmuRZUWLKBbppzGYc1l4AevCX+3TGzMcgEawVC7PiSi2boQfxjb7oUNChhBHf1
	 R3wVq+mRvTwz+UU70ghJ1ZKWiPleUmOGGuiDaGYCcnwOOS/WHm0+dgkwkto3RkNDSN
	 vCfNAnSQmjJDqZeQgTjHAe0BG5kq8bVIUQdD27oyoNqqVcbtGLKjbda6TfjwedAjUI
	 bP4ATE+jt9AoA==
Date: Mon, 31 Mar 2025 10:46:20 +0100
From: Simon Horman <horms@kernel.org>
To: Tariq Toukan <ttoukan.linux@gmail.com>
Cc: Tariq Toukan <tariqt@nvidia.com>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>, Gal Pressman <gal@nvidia.com>,
	Leon Romanovsky <leonro@nvidia.com>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Leon Romanovsky <leon@kernel.org>, netdev@vger.kernel.org,
	linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
	Moshe Shemesh <moshe@nvidia.com>, Mark Bloch <mbloch@nvidia.com>,
	Lama Kayal <lkayal@nvidia.com>
Subject: Re: [PATCH net] net/mlx5e: SHAMPO, Make reserved size independent of
 page size
Message-ID: <20250331094620.GA185681@horms.kernel.org>
References: <1742732906-166564-1-git-send-email-tariqt@nvidia.com>
 <20250325140431.GQ892515@horms.kernel.org>
 <ea6a499b-c267-4fa3-8ed6-983ab96b3b9e@gmail.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ea6a499b-c267-4fa3-8ed6-983ab96b3b9e@gmail.com>

On Thu, Mar 27, 2025 at 07:58:30PM +0200, Tariq Toukan wrote:
> 
> 
> On 25/03/2025 16:04, Simon Horman wrote:
> > On Sun, Mar 23, 2025 at 02:28:26PM +0200, Tariq Toukan wrote:
> > > From: Lama Kayal <lkayal@nvidia.com>
> > > 
> > > When hw-gro is enabled, the maximum number of header entries that are
> > > needed per wqe (hd_per_wqe) is calculated based on the size of the
> > > reservations among other parameters.
> > > 
> > > Miscalculation of the size of reservations leads to incorrect
> > > calculation of hd_per_wqe as 0, particularly in the case of large page
> > > size like in aarch64, this prevents the SHAMPO header from being
> > > correctly initialized in the device, ultimately causing the following
> > > cqe err that indicates a violation of PD.
> > 
> > Hi Lama, Tariq, all,
> > 
> > If I understand things correctly, hd_per_wqe is calculated
> > in mlx5e_shampo_hd_per_wqe() like this:
> > 
> > u32 mlx5e_shampo_hd_per_wqe(struct mlx5_core_dev *mdev,
> >                              struct mlx5e_params *params,                                                    struct mlx5e_rq_param *rq_param)
> > {
> >          int resv_size = BIT(mlx5e_shampo_get_log_rsrv_size(mdev, params)) * PAGE_SIZE;
> >          u16 num_strides = BIT(mlx5e_mpwqe_get_log_num_strides(mdev, params, NULL));
> >          int pkt_per_resv = BIT(mlx5e_shampo_get_log_pkt_per_rsrv(mdev, params));
> >          u8 log_stride_sz = mlx5e_mpwqe_get_log_stride_size(mdev, params, NULL);
> >          int wqe_size = BIT(log_stride_sz) * num_strides;                                u32 hd_per_wqe;
> > 
> >          /* Assumption: hd_per_wqe % 8 == 0. */
> >          hd_per_wqe = (wqe_size / resv_size) * pkt_per_resv;                             mlx5_core_dbg(mdev, "%s hd_per_wqe = %d rsrv_size = %d wqe_size = %d pkt_per_resv = %d\n",                                                                                    __func__, hd_per_wqe, resv_size, wqe_size, pkt_per_resv);
> >          return hd_per_wqe;
> > }
> > 
> > I can see that if PAGE_SIZE was some multiple of 4k, and thus
> > larger than wqe_size, then this could lead to hd_per_wqe being zero.
> > 
> > But I note that mlx5e_mpwqe_get_log_stride_size() may return PAGE_SHIFT.
> > And I wonder if that leads to wqe_size being larger than expected by this
> > patch in cases where the PAGE_SIZE is greater than 4k.
> > 
> > Likewise in mlx5e_shampo_get_log_cq_size(), which seems to have a large overlap
> > codewise with mlx5e_shampo_hd_per_wqe().
> > 
> > > 
> 
> Hi Simon,
> 
> Different settings lead to different combinations of num_strides and
> stride_size. However, they affect each other in a way that the resulting
> wqe_size has the expected (~preset) value.
> 
> In mlx5e_mpwqe_get_log_num_strides() you can see that if stride_size grows,
> then num_strides decreases accordingly.
> 
> In addition, to reduce mistakes/bugs, we have a few WARNs() along the
> calculations, in addition to a verifier function
> mlx5e_verify_rx_mpwqe_strides().

Hi Tariq,

Sorry for the slow response, I was AFK for a few days.

Thanks for confirming that this is as expected.

