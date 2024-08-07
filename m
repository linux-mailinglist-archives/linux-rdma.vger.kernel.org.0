Return-Path: <linux-rdma+bounces-4233-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AC1C194A88E
	for <lists+linux-rdma@lfdr.de>; Wed,  7 Aug 2024 15:26:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 372121F24318
	for <lists+linux-rdma@lfdr.de>; Wed,  7 Aug 2024 13:26:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7DDF1EA0D6;
	Wed,  7 Aug 2024 13:26:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DKwI0Lvf"
X-Original-To: linux-rdma@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14B361E7A5F
	for <linux-rdma@vger.kernel.org>; Wed,  7 Aug 2024 13:26:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723037175; cv=none; b=I4PaY6P+gDFfLpeAkJZl6qgpfiyp0k9lxWdUijqUbYpud11SZqKlPX8hjhXru7v+HQ28IdNiae3lt4hM/MZxeMvBWYc5P93meD6+F5skAwGA4cPCIXJ0pVARd0H28dlDW/wDzVrxO3CeRGae4yfLErj+V5pgPt7YlWIP21C8PPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723037175; c=relaxed/simple;
	bh=i08Eu++Bs5ZfYyhmfDLsgMllWxZSyJTGvRtL9wXdWUY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HmcF9YyWgitXILuFIZGn0rzn9z15Pc/BhYafgHTiM8Xn19EfzVC/T4k0S1eTf7BaExT7rZNnsLqK/GEJnG/MNtogvuiul8nlAHZ8bYF95lKYZ0dbEixC8iHVAPdcf2r2exvFmADGab1KbanWFwC0nbvDZUK3rnOG/k1KbBQ42PM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DKwI0Lvf; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1723037173;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vloTJ8N6rDB2OVVpi1DvU3M2IhFk9AAWb0s6CTF2pM4=;
	b=DKwI0LvfHkL4BUq9ow0saOLB9sRuDRr0FrcmOKeZI8LmRR+OzzSE10AIwWxbgvU/0FQ3F/
	eJHKkGb55Ror4y3uUbwzx3x6InC1xSTe96Dyka3GCeSe02JGoJPiRh9enxEJK89lSm62CB
	o0Z89Dwg16RGrbwHDuHQeaUemTvRpoA=
Received: from mail-yw1-f197.google.com (mail-yw1-f197.google.com
 [209.85.128.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-322-rT3OzVQuMlCf4ZG6VJqWcg-1; Wed, 07 Aug 2024 09:26:08 -0400
X-MC-Unique: rT3OzVQuMlCf4ZG6VJqWcg-1
Received: by mail-yw1-f197.google.com with SMTP id 00721157ae682-68fd6ccd4c8so37318127b3.0
        for <linux-rdma@vger.kernel.org>; Wed, 07 Aug 2024 06:26:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723037168; x=1723641968;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vloTJ8N6rDB2OVVpi1DvU3M2IhFk9AAWb0s6CTF2pM4=;
        b=KvdLWqAzr+J1qvAxE1kSHbZtwE/3M26yPamwcIsZqNINKHrbTXViQJ37PnO07Nuajm
         iIO58GNGvqN/9QT1RaMShmp/ApaDcxQM3gZQM5lrQwANm7AyKfK9U9p9zYoN10qxCZs2
         45RhBee1BC8x795ePCk94FGqt1zyMNE14cOO0s0IKiMBmRsvItcjNCCOoHvJkBpc4K53
         6njFOLwmPxgYaE07NicbtFMr/SZlCJw0zCDZJ8N4mZXdM9/RNxt/lRWy+BQjHpxUTSfj
         pWqnzt7+DjNRR5736mtIlPoHECgiBiRhuJVaOHfxhzmuVJSan+lX73X6+TvTl0MWWLIJ
         llQA==
X-Forwarded-Encrypted: i=1; AJvYcCUvixAED63GSL/fsICO5WSeTJP5HMVVgLtmpT1hyg91lZ+eLiokJ/Z7A6D7yCN/vt0gRAakPcCTEl/GPjTkDa88Wn98i+5cw/7Riw==
X-Gm-Message-State: AOJu0Yy93hEY6eboADg5kUgIIpmLV4Xh+x8dMuS4yCpuErwQn/t28oVs
	kABVviz7RvFqB3mZ/5v2OxMmWj7cv+l9ou3wbz/NtITP6zRCtC/zMa6g+iQc3vwjTn6VzvIRBa1
	j5J2CLNh1wwlVMnu7iqKEYNaUh+CF7XnHu4zwA7WoouEEEgL4UgFsWrDTFshIf0SUIzV5h3Y7yA
	zaRertEeoyx8oQOF4/U9xOc16r0zxU90jf4Q==
X-Received: by 2002:a81:8887:0:b0:63b:b3b8:e834 with SMTP id 00721157ae682-68963423819mr222073737b3.32.1723037168332;
        Wed, 07 Aug 2024 06:26:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHlaQzWaMhaOL8yyUTkscgvdFCW3vr0eHO4IPz4j2TIsmeWnld07fIgPnkUYUvyGyLGq+dpPFUOtl3iXD2ZKEw=
X-Received: by 2002:a81:8887:0:b0:63b:b3b8:e834 with SMTP id
 00721157ae682-68963423819mr222073587b3.32.1723037168001; Wed, 07 Aug 2024
 06:26:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240802072039.267446-1-dtatulea@nvidia.com>
In-Reply-To: <20240802072039.267446-1-dtatulea@nvidia.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Wed, 7 Aug 2024 15:25:32 +0200
Message-ID: <CAJaqyWdGNfJ3n-E2-PvkuvCiOMsLkEzYaUi5wi-C_n84-a_LAw@mail.gmail.com>
Subject: Re: [PATCH vhost 0/7] vdpa/mlx5: Parallelize device suspend/resume
To: Dragos Tatulea <dtatulea@nvidia.com>
Cc: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>, Tariq Toukan <tariqt@nvidia.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	"Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Si-Wei Liu <si-wei.liu@oracle.com>, 
	netdev@vger.kernel.org, linux-rdma@vger.kernel.org, 
	linux-kernel@vger.kernel.org, virtualization@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 2, 2024 at 9:24=E2=80=AFAM Dragos Tatulea <dtatulea@nvidia.com>=
 wrote:
>
> This series parallelizes the mlx5_vdpa device suspend and resume
> operations through the firmware async API. The purpose is to reduce live
> migration downtime.
>
> The series starts with changing the VQ suspend and resume commands
> to the async API. After that, the switch is made to issue multiple
> commands of the same type in parallel.
>

There is a missed opportunity processing the CVQ MQ command here,
isn't it? It can be applied on top in another series for sure.

> Finally, a bonus improvement is thrown in: keep the notifierd enabled
> during suspend but make it a NOP. Upon resume make sure that the link
> state is forwarded. This shaves around 30ms per device constant time.
>
> For 1 vDPA device x 32 VQs (16 VQPs), on a large VM (256 GB RAM, 32 CPUs
> x 2 threads per core), the improvements are:
>
> +-------------------+--------+--------+-----------+
> | operation         | Before | After  | Reduction |
> |-------------------+--------+--------+-----------|
> | mlx5_vdpa_suspend | 37 ms  | 2.5 ms |     14x   |
> | mlx5_vdpa_resume  | 16 ms  | 5 ms   |      3x   |
> +-------------------+--------+--------+-----------+
>

Looks great :).

Apart from the nitpick,

Acked-by: Eugenio P=C3=A9rez <eperezma@redhat.com>

For the vhost part.

Thanks!

> Note for the maintainers:
> The first patch contains changes for mlx5_core. This must be applied
> into the mlx5-vhost tree [0] first. Once this patch is applied on
> mlx5-vhost, the change has to be pulled from mlx5-vdpa into the vhost
> tree and only then the remaining patches can be applied.
>
> [0] https://git.kernel.org/pub/scm/linux/kernel/git/mellanox/linux.git/lo=
g/?h=3Dmlx5-vhost
>
> Dragos Tatulea (7):
>   net/mlx5: Support throttled commands from async API
>   vdpa/mlx5: Introduce error logging function
>   vdpa/mlx5: Use async API for vq query command
>   vdpa/mlx5: Use async API for vq modify commands
>   vdpa/mlx5: Parallelize device suspend
>   vdpa/mlx5: Parallelize device resume
>   vdpa/mlx5: Keep notifiers during suspend but ignore
>
>  drivers/net/ethernet/mellanox/mlx5/core/cmd.c |  21 +-
>  drivers/vdpa/mlx5/core/mlx5_vdpa.h            |   7 +
>  drivers/vdpa/mlx5/net/mlx5_vnet.c             | 435 +++++++++++++-----
>  3 files changed, 333 insertions(+), 130 deletions(-)
>
> --
> 2.45.2
>


