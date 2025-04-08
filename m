Return-Path: <linux-rdma+bounces-9231-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C3C44A7FF2F
	for <lists+linux-rdma@lfdr.de>; Tue,  8 Apr 2025 13:19:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4FB8F172A9A
	for <lists+linux-rdma@lfdr.de>; Tue,  8 Apr 2025 11:12:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82915267F77;
	Tue,  8 Apr 2025 11:11:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z/yAmvEs"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40ACD224F6
	for <linux-rdma@vger.kernel.org>; Tue,  8 Apr 2025 11:11:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744110716; cv=none; b=ZWbKiYc/7wCXA14waVRi4jW2WAAWZBqJmA2n0wUESOGJs765emHah/JJg6wSx7d8TPdoHwb35TuRbECXt8d/FIBQhWdRREj72sFEOLAf37pVP0RWf6AyYJaa/SvLi3PYyHxpR/kbMaCT2W2WXqdAw8eSGPyHUZJf+u5V4CaGg48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744110716; c=relaxed/simple;
	bh=2qxbCTqwWP2/dWBQR7s0eP/4bLt7VvfBGz7nLWEvkpk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Kb2w3bLdHnEJXIyzgBmlcvWGLsjKeql0SjPwVi6gNjgoUu/vMv0QN25HXuxb2sMRQgvOlHH8l83AngNIDIcJoA7YUINESzhrjgdVQx+qe0Kh8nNHFKj01zuWJZudpVSXkE68GdAaH9NN9WW630UVZsN7GtgNlOog/sf2eObw7T4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z/yAmvEs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7BAECC4CEE7;
	Tue,  8 Apr 2025 11:11:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744110716;
	bh=2qxbCTqwWP2/dWBQR7s0eP/4bLt7VvfBGz7nLWEvkpk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Z/yAmvEsssBoal29FC7quFDS/5Xe00s9Jfc+7yuJP9bd0PkEwAXXyg46Xfwp3TPuO
	 8kDAQlJoSxd87dnoT/CJIYZ08AfivZ2eRFX+BxDCfSpcv8yQpsWGHuXkoSexSpx30b
	 qHE2yswbSSooNMKSe/0woxfVc7KP/BbkqiyXlDMXat4pmtCKgygC2C3/2wJPylXgbs
	 hNwWAyOchey6AYxG746yUVt8Uqy5k4MReIBdGgE0b95f7f3bVTvzlIThyGXoxESn+L
	 qlZp50SbcLggWsGQQZysYA0rGUc2gssPMrwH2dX4B5QTx0Jog8gg7YvKJaVLzynSe1
	 YaM33v0YKbc/g==
Date: Tue, 8 Apr 2025 14:11:48 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Daisuke Matsuda <matsuda-daisuke@fujitsu.com>
Cc: linux-rdma@vger.kernel.org, jgg@ziepe.ca, zyjzyj2000@gmail.com,
	lizhijian@fujitsu.com
Subject: Re: [PATCH for-next v3 0/2] RDMA/rxe: RDMA FLUSH and ATOMIC WRITE
 with ODP
Message-ID: <20250408111148.GA197338@unreal>
References: <20250324075649.3313968-1-matsuda-daisuke@fujitsu.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250324075649.3313968-1-matsuda-daisuke@fujitsu.com>

On Mon, Mar 24, 2025 at 04:56:47PM +0900, Daisuke Matsuda wrote:
> RDMA FLUSH[1] and ATOMIC WRITE[2] were added to rxe, but they cannot run
> in the ODP mode as of now. This series is for the kernel-side enablement.

<...>

> Daisuke Matsuda (2):
>   RDMA/rxe: Enable ODP in RDMA FLUSH operation
>   RDMA/rxe: Enable ODP in ATOMIC WRITE operation
> 
>  drivers/infiniband/sw/rxe/rxe.c      |   2 +
>  drivers/infiniband/sw/rxe/rxe_loc.h  |  18 ++++-
>  drivers/infiniband/sw/rxe/rxe_mr.c   |  48 ++++++------
>  drivers/infiniband/sw/rxe/rxe_odp.c  | 108 ++++++++++++++++++++++++++-
>  drivers/infiniband/sw/rxe/rxe_resp.c |  15 ++--
>  include/rdma/ib_verbs.h              |   2 +

I applied the series, but not sure that extending cap_bits for RXE only
is justified.

--- a/include/rdma/ib_verbs.h
+++ b/include/rdma/ib_verbs.h
@@ -325,6 +325,7 @@ enum ib_odp_transport_cap_bits {
        IB_ODP_SUPPORT_READ     = 1 << 3,
        IB_ODP_SUPPORT_ATOMIC   = 1 << 4,
        IB_ODP_SUPPORT_SRQ_RECV = 1 << 5,
+       IB_ODP_SUPPORT_FLUSH    = 1 << 6,
 };

Thanks

>  6 files changed, 159 insertions(+), 34 deletions(-)
> 
> -- 
> 2.43.0
> 

