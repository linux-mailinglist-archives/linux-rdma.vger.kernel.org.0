Return-Path: <linux-rdma+bounces-6505-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B9A69F0985
	for <lists+linux-rdma@lfdr.de>; Fri, 13 Dec 2024 11:31:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C1EC528403D
	for <lists+linux-rdma@lfdr.de>; Fri, 13 Dec 2024 10:31:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F3281C0DF0;
	Fri, 13 Dec 2024 10:31:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ns5jBd4n"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4887D1B6D18;
	Fri, 13 Dec 2024 10:31:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734085877; cv=none; b=YAtOHXBfaTICzCuWYlLeyKyglyRc+AvCLuIAUgFtDpiZHSKTnDvHqqd2gHzvG9dZgoJUXGUlYG5q0sDtWhaTtPvN4LVJFx21aqjoY7alOfLacSLrna248skVYdJfgGZRWV83GNH5lEo+EjOcAJJKEeJWquODRFheSNEpY010oUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734085877; c=relaxed/simple;
	bh=/8iniFQvnGJIKJPWz05htIpfqg9daPca7yXgUoAFhkk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ngKwh+hE80Afh/7oJKmUMjelpNz5xcwP218/vZCnRTKum+RdW3WT1zgtYg282G4bYzrDXfic1YgXg8piGz6zS4UoXj/cxJxous7mvPbECA7HCJ8Rmtd5l6SqOWkJ+zEFCMriaE1kKI8k8G9n9pvv/0V7tMwMUCFhxFUDiETs4Nc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ns5jBd4n; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27325C4CED0;
	Fri, 13 Dec 2024 10:31:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734085876;
	bh=/8iniFQvnGJIKJPWz05htIpfqg9daPca7yXgUoAFhkk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ns5jBd4n6dnKDYXGm8c2JD4Uk7oaX/h0fk6OD7+z3hmdTSBpqhlFKEcRwSl8IVqyy
	 CIhHDFUEypC4bTzsbKmoqbvL9ML0qUFjkE7qeBtC90q6C55rDiOH4WUwucGMOQEGhM
	 DT1JPnZwVhIh3sPYfkSEaMWP+Vx+z7iBosi9i2KAlmFkF2rKvl1ZWy/Kfu+qUlDONj
	 ZUzE+GBGMx1Lqwdhu5tPmwOFJLdJa9tJZV88QYiMr7vEEZjuT1xUsT6HDXzq8z7uH4
	 hge52TUnO2CHGTCxwWkkir5D31eDV+JZVQRXkAMORWAcPftHKAbKvd2UN+ETzOSbxX
	 v6KGvLEYFTlag==
Date: Fri, 13 Dec 2024 10:31:11 +0000
From: Simon Horman <horms@kernel.org>
To: Tariq Toukan <ttoukan.linux@gmail.com>
Cc: Tariq Toukan <tariqt@nvidia.com>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Leon Romanovsky <leonro@nvidia.com>, netdev@vger.kernel.org,
	Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman <gal@nvidia.com>,
	linux-rdma@vger.kernel.org, Itamar Gozlan <igozlan@nvidia.com>,
	Yevgeny Kliteynik <kliteyn@nvidia.com>
Subject: Re: [PATCH net-next 10/12] net/mlx5: DR, add support for ConnectX-8
 steering
Message-ID: <20241213103111.GJ2110@kernel.org>
References: <20241211134223.389616-1-tariqt@nvidia.com>
 <20241211134223.389616-11-tariqt@nvidia.com>
 <20241212173113.GF73795@kernel.org>
 <5b6c8feb-c779-428a-bcca-2febdae5bb0f@gmail.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5b6c8feb-c779-428a-bcca-2febdae5bb0f@gmail.com>

On Thu, Dec 12, 2024 at 08:31:30PM +0200, Tariq Toukan wrote:
> 
> 
> On 12/12/2024 19:31, Simon Horman wrote:
> > On Wed, Dec 11, 2024 at 03:42:21PM +0200, Tariq Toukan wrote:
> > > From: Itamar Gozlan <igozlan@nvidia.com>
> > > 
> > > Add support for a new steering format version that is implemented by
> > > ConnectX-8.
> > > Except for several differences, the STEv3 is identical to STEv2, so
> > > for most callbacks STEv3 context struct will call STEv2 functions.
> > > 
> > > Signed-off-by: Itamar Gozlan <igozlan@nvidia.com>
> > > Signed-off-by: Yevgeny Kliteynik <kliteyn@nvidia.com>
> > > Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
> > > ---
> > >   .../net/ethernet/mellanox/mlx5/core/Makefile  |   1 +
> > >   .../mlx5/core/steering/sws/dr_domain.c        |   2 +-
> > >   .../mellanox/mlx5/core/steering/sws/dr_ste.c  |   2 +
> > >   .../mellanox/mlx5/core/steering/sws/dr_ste.h  |   1 +
> > >   .../mlx5/core/steering/sws/dr_ste_v3.c        | 221 ++++++++++++++++++
> > >   .../mlx5/core/steering/sws/mlx5_ifc_dr.h      |  40 ++++
> > >   .../mellanox/mlx5/core/steering/sws/mlx5dr.h  |   2 +-
> > >   7 files changed, 267 insertions(+), 2 deletions(-)
> > >   create mode 100644 drivers/net/ethernet/mellanox/mlx5/core/steering/sws/dr_ste_v3.c
> > > 
> > > diff --git a/drivers/net/ethernet/mellanox/mlx5/core/Makefile b/drivers/net/ethernet/mellanox/mlx5/core/Makefile
> > > index 79fe09de0a9f..10a763e668ed 100644
> > > --- a/drivers/net/ethernet/mellanox/mlx5/core/Makefile
> > > +++ b/drivers/net/ethernet/mellanox/mlx5/core/Makefile
> > > @@ -123,6 +123,7 @@ mlx5_core-$(CONFIG_MLX5_SW_STEERING) += steering/sws/dr_domain.o \
> > >   					steering/sws/dr_ste_v0.o \
> > >   					steering/sws/dr_ste_v1.o \
> > >   					steering/sws/dr_ste_v2.o \
> > > +					steering/sws/dr_ste_v3.o \
> > >   					steering/sws/dr_cmd.o \
> > >   					steering/sws/dr_fw.o \
> > >   					steering/sws/dr_action.o \
> > > diff --git a/drivers/net/ethernet/mellanox/mlx5/core/steering/sws/dr_domain.c b/drivers/net/ethernet/mellanox/mlx5/core/steering/sws/dr_domain.c
> > > index 3d74109f8230..bd361ba6658c 100644
> > > --- a/drivers/net/ethernet/mellanox/mlx5/core/steering/sws/dr_domain.c
> > > +++ b/drivers/net/ethernet/mellanox/mlx5/core/steering/sws/dr_domain.c
> > > @@ -8,7 +8,7 @@
> > >   #define DR_DOMAIN_SW_STEERING_SUPPORTED(dmn, dmn_type)	\
> > >   	((dmn)->info.caps.dmn_type##_sw_owner ||	\
> > >   	 ((dmn)->info.caps.dmn_type##_sw_owner_v2 &&	\
> > > -	  (dmn)->info.caps.sw_format_ver <= MLX5_STEERING_FORMAT_CONNECTX_7))
> > > +	  (dmn)->info.caps.sw_format_ver <= MLX5_STEERING_FORMAT_CONNECTX_8))
> > 
> > A definition for MLX5_STEERING_FORMAT_CONNECTX_8 seems to be missing
> > from this patch.
> > 
> 
> Should be pulled from mlx5-next, as described in the cover letter.
> 
> Copying here for your convenience:
> 
> It requires pulling 4 IFC patches that were applied to
> mlx5-next:
> https://git.kernel.org/pub/scm/linux/kernel/git/mellanox/linux.git/log/?h=mlx5-next

Thanks, sorry for missing that.

