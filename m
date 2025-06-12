Return-Path: <linux-rdma+bounces-11232-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 155C1AD672B
	for <lists+linux-rdma@lfdr.de>; Thu, 12 Jun 2025 07:16:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 068131BC1197
	for <lists+linux-rdma@lfdr.de>; Thu, 12 Jun 2025 05:16:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 010091DF75D;
	Thu, 12 Jun 2025 05:16:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sDHB2qpn"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F751199FAF
	for <linux-rdma@vger.kernel.org>; Thu, 12 Jun 2025 05:16:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749705395; cv=none; b=Niu+D+N2FLk1atcooD0f6TFBgasbjNkeUxb2KDON/KhYkkqhpKEF2rmqaiimAVZYu5Pk1Je0XDU3lWC4NIyk9E9Xfo/4Pan0icJI6K9oxViW56EocXTTsAOv0Yr96zLkKT/TqH4VkzoKeNC3dHXYl03s4GQ02o4PbSQ1xjwCQL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749705395; c=relaxed/simple;
	bh=GYwJDBqm5ype1Fn87+cuFdQQ7WJUMfaovIJl6GLLetg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gKzFASI068mjw8pEvxkWautuIthCkLPJTZGF+/XFjHDFixuOoxwUHRvh4H7NVbbANsBReCDp+eqk44ByzhMn+hoy+2BHi0iayW4HlD8xtjY/rNx+R/+U/7pA4C75J1wJ829cCrpMqEXxGxAxgDYyRoUMx7Q51B3CHMoyCJo1bw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=sDHB2qpn; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2357c61cda7so62585ad.1
        for <linux-rdma@vger.kernel.org>; Wed, 11 Jun 2025 22:16:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1749705393; x=1750310193; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p6diRbRZRukPlWo9M8OnwMyyu0ZftkgUDqdamePSBwg=;
        b=sDHB2qpnwXvcOKxsQtQo/Q4WJS5QK/HrPfBdYCgUz3W9Eb04KykuWqhl8HcDa/Ui90
         axXTHe8gHVxfSpsaif29YE6UFLQLgPSZjo3pZQsiipao9Hc+MgySlvYCGRbA6n/daot1
         0i2dHxn3azMLq5dqxMEHnTkWa5nErRAYU/4E7rbAZTXIDpbg9B5mQP/f8LoP3rrU2Pzu
         5WPIERiQUhvpR7KlmSo08l3oU+d+H0MhdgcFmy2J5JzkIi8SjDUWmh/hu0QTjgEJsdzm
         HIjOux2C1tnk7asVgoLvImgThko8L5Kqu5XFZFK5F8iV0LBxsCpIEOw2i+MrMYp2UKrh
         0CqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749705393; x=1750310193;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=p6diRbRZRukPlWo9M8OnwMyyu0ZftkgUDqdamePSBwg=;
        b=xTUy6Dj+eHMVXk0241NMt65IAlfxmeVs8D278xN+LgxzNpu6KMaMBGm60uRNblCBlA
         NrZNHuNvbItqg6BhMnDr30Un2KkUJXZ3mekZVkZv1lMqJA1kquwCGaNivnnRccwCWowm
         c2ExoUjphEO5rzWpaR/njK/CMWIa/2SBPxB+3m8CmIOXgxLG1IfTK89oShboLNp2qy1e
         fpvmGAy2q3kBogy9lvgu7m0V4U2xAGX2BWh/Fxt1QD834zn2ng3vUsFFkqx5qNzwcESZ
         We1TMijzuqrssdxY1ykFm+gXIyhK6gpKtDMiIGTdvh0REhrHNO/mesfce3QCstfk4oJJ
         ffEA==
X-Forwarded-Encrypted: i=1; AJvYcCXhU9HFSHky0zHw3/EVhOSIAiFM/L2wz6ovJnN7945Tci9lKh9lEJzTmVPwt0AyOzhGone+vmlR8FmF@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/NWVXY8LdhwxsP7VLJH8VyI88oWZ41CHxbBojQejuMyNcNEt/
	1evrMn6AZuBsV+Y+nA5WHkIyYb+KYdpquaHhJp2ywkXYRNQU6RChZMW3rABSLsP0VA9RHgzNZ9h
	GVXAOohRmKZUE8JhqfMQpu0Hbz8aGp7hIlDdxhWDz
X-Gm-Gg: ASbGnctwfhJfkrGJggDIPdmfY55vzYLFT5RcG0aJFYICgC5GiJWbk6t53ybL+i9y2UL
	wXjH1b0P3Pn1dcwG3vMFGcpDgl1D+6duhNxKZzh/7jGJ53uUtOB58V7amsuKYG6+W0ohKLVjgos
	ZIHd4zEgibhFM5TXxjGhGZZNhyDzbp8bZYfm7g8G+c8eWV
X-Google-Smtp-Source: AGHT+IFsS2B5lC69yG+ZIzDjoB42cEDFFoUNubkkslLP3SlQB8j7he9Gt0R5igTKHstKDOVSt4yEWMRv9eqcqO1H2bY=
X-Received: by 2002:a17:902:d4cf:b0:235:e1e4:efc4 with SMTP id
 d9443c01a7336-2364dc69fc5mr1822195ad.14.1749705392972; Wed, 11 Jun 2025
 22:16:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250610150950.1094376-1-mbloch@nvidia.com> <20250610150950.1094376-9-mbloch@nvidia.com>
In-Reply-To: <20250610150950.1094376-9-mbloch@nvidia.com>
From: Mina Almasry <almasrymina@google.com>
Date: Wed, 11 Jun 2025 22:16:18 -0700
X-Gm-Features: AX0GCFtSea24S64oBWfvhRVn2iiOFXlEz1l-q8Ml6dx4ayAJvrSCDhs5kdtjaHM
Message-ID: <CAHS8izOEn+C5QexSPZT3_ekUr2zR1dm9R6OsoGBPaqg5MFvBRQ@mail.gmail.com>
Subject: Re: [PATCH net-next v4 08/11] net/mlx5e: Add support for UNREADABLE
 netmem page pools
To: Mark Bloch <mbloch@nvidia.com>
Cc: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, saeedm@nvidia.com, gal@nvidia.com, 
	leonro@nvidia.com, tariqt@nvidia.com, Leon Romanovsky <leon@kernel.org>, 
	netdev@vger.kernel.org, linux-rdma@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Dragos Tatulea <dtatulea@nvidia.com>, 
	Cosmin Ratiu <cratiu@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 10, 2025 at 8:20=E2=80=AFAM Mark Bloch <mbloch@nvidia.com> wrot=
e:
>
> From: Saeed Mahameed <saeedm@nvidia.com>
>
> On netdev_rx_queue_restart, a special type of page pool maybe expected.
>
> In this patch declare support for UNREADABLE netmem iov pages in the
> pool params only when header data split shampo RQ mode is enabled, also
> set the queue index in the page pool params struct.
>
> Shampo mode requirement: Without header split rx needs to peek at the dat=
a,
> we can't do UNREADABLE_NETMEM.
>
> The patch also enables the use of a separate page pool for headers when
> a memory provider is installed for the queue, otherwise the same common
> page pool continues to be used.
>
> Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
> Reviewed-by: Dragos Tatulea <dtatulea@nvidia.com>
> Signed-off-by: Cosmin Ratiu <cratiu@nvidia.com>
> Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
> Signed-off-by: Mark Bloch <mbloch@nvidia.com>
> ---
>  drivers/net/ethernet/mellanox/mlx5/core/en_main.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c b/drivers/=
net/ethernet/mellanox/mlx5/core/en_main.c
> index 5e649705e35f..a51e204bd364 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
> @@ -749,7 +749,9 @@ static void mlx5e_rq_shampo_hd_info_free(struct mlx5e=
_rq *rq)
>
>  static bool mlx5_rq_needs_separate_hd_pool(struct mlx5e_rq *rq)
>  {
> -       return false;
> +       struct netdev_rx_queue *rxq =3D __netif_get_rx_queue(rq->netdev, =
rq->ix);
> +
> +       return !!rxq->mp_params.mp_ops;

This is kinda assuming that all future memory providers will return
unreadable memory, which is not a restriction I have in mind... in
theory there is nothing wrong with memory providers that feed readable
pages. Technically the right thing to do here is to define a new
helper page_pool_is_readable() and have the mp report to the pp if
it's all readable or not.

But all this sounds like a huge hassle for an unnecessary amount of
future proofing, so I guess this is fine.

Reviewed-by: Mina Almasry <almasrymina@google.com>

--=20
Thanks,
Mina

