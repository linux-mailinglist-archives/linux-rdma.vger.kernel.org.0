Return-Path: <linux-rdma+bounces-10582-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3758EAC1802
	for <lists+linux-rdma@lfdr.de>; Fri, 23 May 2025 01:32:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BE47C3A26D3
	for <lists+linux-rdma@lfdr.de>; Thu, 22 May 2025 23:31:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D1692D8DA2;
	Thu, 22 May 2025 23:26:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="joyQYIP5"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB20A2D193F
	for <linux-rdma@vger.kernel.org>; Thu, 22 May 2025 23:26:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747956409; cv=none; b=YsfLQCl5MYZeS1L6dW56+uTOyAUxHpgWSrFXtNLUKHxoX9R3x0gWbGfX2z9p6sXPvkbE+fG+uREz41LDTVdaHn9EhGlOlrIpSBQm2DZdk4e7c+xcd65Lhg0Xg0o8vZue2GVlBDq6wSeXpIsXZt/4+vlhZHwsBwB8yefA2wD+MaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747956409; c=relaxed/simple;
	bh=Fm5MsU6AnFNe0fev7Fs8otIjBCU2BZ0zw3QOQzdznoM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JM6Atr7eEvfBpuvLZ6SZWNXOmy98PriE9n9GX/RWEYLTo1y6O7qxF9bSx8J+yxIHl0ruyqdjGkdIB6YbYmHD7ln7eIW8ykgrL/ZLrsOfcAvX+EUBCmfCSDJP1vLNL3QFxoLY4DZRW4rKTiIdojwm4RGhfMfX+sT+yYHgc4UtTqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=joyQYIP5; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-231f61dc510so88595ad.0
        for <linux-rdma@vger.kernel.org>; Thu, 22 May 2025 16:26:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1747956407; x=1748561207; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tewI1VjF8jaVqlFssXh4UdHKoEk0InUXOTIkBmq7a7w=;
        b=joyQYIP5G5JKzxPoy8Bug1EEzJ3QUquHJKX6sPEF0uURoIOR6WSZ5UtIiLfmMNPRgG
         cZ3QHbXx57fb42W2r1ncSvLQhmZMzgq/1kJIb/2BxqbhqREsjtLxGQ3cT8IY883112MS
         cenfMCLDj7ud6EPugHUsXjO1C3511VBrp8hSaT6oDJnfhafiP7h6aj3HZoUQgInyGPeR
         y2kouFhqjbOpd5l+Vu3LsSH4kJG16jIVwdzwTRw/TCXdgvdxA2jo4GDURQRqR+Uu8acG
         s4ecj+6yUkti0HueJm+PmHTAtYgSDA/yoIEysfa8UE1AbJjior4228mRK4Vn3UkxZqTC
         DOJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747956407; x=1748561207;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tewI1VjF8jaVqlFssXh4UdHKoEk0InUXOTIkBmq7a7w=;
        b=Jw1BUR5nS0lj9T9BVwQTx9CBaem1zh5ITlm4StG8o0sc3KkqV7xi7Uzbr8amqbLGjj
         cGDLAUy/FiarTGdpdFwkFeOQPVia/dm8rQ3Y9hLotBcuk+s4fdPhLt/N+d3od9kbbt4A
         UPACVBroGW+N9B9RNWwOgNGOXklztCaE6ok3cnZh+OI5JLexOrBvxY7wFYkYdAIe5ER6
         fn3kZGZevXbR4AefU6q/VRO0H/gJgOfWgcuZsD+DTB3wX2kiPmM9Fkb8k+Fy+DkCe8FJ
         4yG9+GnMUYzyhmWULh1AcRNrvVyT8OoYX+1LVkk3+0SyDm5QEphfMRnGtyOtiMpxtUW0
         rA0Q==
X-Forwarded-Encrypted: i=1; AJvYcCUFOL08vPt2nYLDuMBALCdQKAI6hPRlY09ZR0WX7dYuwuLb6Ij0zUtgaBTfwXbBZVJ0uw8Q3qZh2RDx@vger.kernel.org
X-Gm-Message-State: AOJu0YztvLNUI0NCpac9sXbG0D+duEoHGJRxsYka/qCQX7CSOKutBcgF
	a9qPU/f7J+NT6QY12XK3kzYOtb0f5RPkVJ5vReQ6Wu3fHwR5ucEq79317MfrlvVKMGFVTpgiPtd
	1Gp4kw5IG3VKu5jUqSKHZDIFSjFH23RN4tIG9+k3b
X-Gm-Gg: ASbGnctpUgp4NgUD8rEs/48Qy1X/u7riw0g7gK20y+Ok/YspApyNN7Ou2CjRdQfVZFH
	j3Yvoc8jta7gD5Qxk3FLIQjHIQq3XYmqKMTEsPpJHiXPGSumU9daqvLeuHkWxt+oD4l1vUgQmV7
	w9fuJl3U3bNOYcvQCS2mK0dxAytc+v14+GYp9UlaBPPJ7nv2C32BbqWjZ+Hh/Tq7EtSIcto2Db3
	wfhACUL+X5i
X-Google-Smtp-Source: AGHT+IExQXp+kRhsr+xvbueIPx3isSBUAU+UOZQ8m1D2lTDyLYVrFiHMIU2uzePo0K4IVU4P7DIGc96cabT65kW5Pfk=
X-Received: by 2002:a17:903:120b:b0:224:6c8:8d84 with SMTP id
 d9443c01a7336-233f306b22emr758395ad.4.1747956406406; Thu, 22 May 2025
 16:26:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1747950086-1246773-1-git-send-email-tariqt@nvidia.com> <1747950086-1246773-10-git-send-email-tariqt@nvidia.com>
In-Reply-To: <1747950086-1246773-10-git-send-email-tariqt@nvidia.com>
From: Mina Almasry <almasrymina@google.com>
Date: Thu, 22 May 2025 16:26:33 -0700
X-Gm-Features: AX0GCFtsIvmK98xADj6rEGCHUjIbzbhFEii4WAzkg0iSDJXH2J3dXgYsjaSUVc4
Message-ID: <CAHS8izOwPVSKQJBSOjmtfXfA6ZBHVqvWRV=WSYM41XXninsSSw@mail.gmail.com>
Subject: Re: [PATCH net-next V2 09/11] net/mlx5e: Add support for UNREADABLE
 netmem page pools
To: Tariq Toukan <tariqt@nvidia.com>
Cc: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, Saeed Mahameed <saeedm@nvidia.com>, 
	Leon Romanovsky <leon@kernel.org>, Richard Cochran <richardcochran@gmail.com>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, netdev@vger.kernel.org, 
	linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
	Moshe Shemesh <moshe@nvidia.com>, Mark Bloch <mbloch@nvidia.com>, Gal Pressman <gal@nvidia.com>, 
	Cosmin Ratiu <cratiu@nvidia.com>, Dragos Tatulea <dtatulea@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 22, 2025 at 2:46=E2=80=AFPM Tariq Toukan <tariqt@nvidia.com> wr=
ote:
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
> Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
> Reviewed-by: Dragos Tatulea <dtatulea@nvidia.com>
> Signed-off-by: Cosmin Ratiu <cratiu@nvidia.com>
> Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
> ---
>  drivers/net/ethernet/mellanox/mlx5/core/en_main.c | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c b/drivers/=
net/ethernet/mellanox/mlx5/core/en_main.c
> index 9e2975782a82..485b1515ace5 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
> @@ -952,6 +952,11 @@ static int mlx5e_alloc_rq(struct mlx5e_params *param=
s,
>                 pp_params.netdev    =3D rq->netdev;
>                 pp_params.dma_dir   =3D rq->buff.map_dir;
>                 pp_params.max_len   =3D PAGE_SIZE;
> +               pp_params.queue_idx =3D rq->ix;
> +
> +               /* Shampo header data split allow for unreadable netmem *=
/
> +               if (test_bit(MLX5E_RQ_STATE_SHAMPO, &rq->state))
> +                       pp_params.flags |=3D PP_FLAG_ALLOW_UNREADABLE_NET=
MEM;
>

This patch itself looks good to me for FWIW, but unreadable netmem
will return netmem_address(netmem) =3D=3D NULL, which from an initial look
didn't seem like you were handling in the previous patches. Not sure
if oversight or you are sure you're not going to have unreadable
netmem in these code paths for some reason.


--=20
Thanks,
Mina

