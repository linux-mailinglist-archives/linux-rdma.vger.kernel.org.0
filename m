Return-Path: <linux-rdma+bounces-4418-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE4B6956F10
	for <lists+linux-rdma@lfdr.de>; Mon, 19 Aug 2024 17:42:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 817F3B26D76
	for <lists+linux-rdma@lfdr.de>; Mon, 19 Aug 2024 15:42:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18AF317556C;
	Mon, 19 Aug 2024 15:41:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UNHxM9lx"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-vs1-f42.google.com (mail-vs1-f42.google.com [209.85.217.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E9E21741D9;
	Mon, 19 Aug 2024 15:41:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724082090; cv=none; b=fdxuR87Tf6byWRfwOGTUd0smOltLnjf4L1GJ32szEifvXoCwVfmnhdqNsMiH5PB8+DwUEvfjSmFNhhJ++KxH+0hOPx3z2hR5/64mntv6fdXeB/0fW9oHlbVMEKpo+Plsujq5Mb8tvLI3SBgjkONqjXungl/8H49ZtloS4qGcKFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724082090; c=relaxed/simple;
	bh=oprzWa5GL+TSCuCr+mr2wDNoTLYKfJod4ftEajoS/eE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qkAXkzqLzd3ntJjwfUrh+zVga512UzlxxwGmHKv6FFpxNI38q70JLnGCT9vVUgBdMdvNKFbW339qzjRgjpahx6Ut5MupBLvssh1CZgFG/UGdZTZwljcsAzE5Z3BbX7hKW2ilApBFl+UDQvPD/erpNSZOdXV6cGACQ+qtXBfzN9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UNHxM9lx; arc=none smtp.client-ip=209.85.217.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f42.google.com with SMTP id ada2fe7eead31-4928989e272so1709322137.2;
        Mon, 19 Aug 2024 08:41:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724082088; x=1724686888; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oprzWa5GL+TSCuCr+mr2wDNoTLYKfJod4ftEajoS/eE=;
        b=UNHxM9lxdxk/sR3KZY2Tj8BMEdHkLEWsmolmCt7mWqvlp5urh2uJbp0BnJhErbdn1f
         QvZUQoDgqgQt3RiIJLY/VBRAQ4gDBFjAhJl2zzMhn2kPZJelUWYKtbfJHtQ4vdxYS9N6
         INpCiG7OqMNiqUfIg1877R/LiGI+8kuSvniOnUBO9L0CsuEOrUthJgsprP9lraNLWmfp
         3sMLEpYoOwj6xEw0tJHndgzxzUEvXCvfW2RPELfmvv93vPaSnosGHOXmqq07p6JBseFU
         Nj/LwxMvz71UBvl2K/CgvB4IF0uO54cV8idqt+9LCruuRc4KAIxKpiKC0u+1PbfuBs0I
         gEkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724082088; x=1724686888;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oprzWa5GL+TSCuCr+mr2wDNoTLYKfJod4ftEajoS/eE=;
        b=kEuGQuG5MxHSbM8Q17h2JQr1DUdIEXH/FJXCDQBEBbpYMNjTK1gHU+Q2Q1hUVQMMPN
         x627hdQCHKjqqxDJrdUEFDUbFptfGKiUqHXiY5bcoQl6boWEBGDudC3LsadJTF7mzLQ9
         y9mmXkTKF1AKPCZJeY1rBt9yCZM/AJPy8JYqh9S3tqUB3w8SFLgIfd+t+3lACdbPS3nX
         iaJzVOP/hTq4Denet2oPKHDvB885sj8aKoHosSPCJggEH/6n0WByqwDpOgyh1KxZKhfZ
         meKEbSSe1v80YxCEXm7UrwlLKfLBtXbEul5G4a5I1WrYDjR10822J98ImDC/yYIlMegD
         wT8g==
X-Forwarded-Encrypted: i=1; AJvYcCUPcVtIw87vULtPBKCzWvDmlVOhmG+KGZqVD+MiD/t5a8g7Gx7DKUz35NQZCBtHMG5e1A2etJr/@vger.kernel.org, AJvYcCUSO+QxGspyepGSxfxdifAHMTibaTrmLkfQS4amphqqh7W7eF9Ko5zHYnymbBZqugwWy9PXaunc6iE6gw==@vger.kernel.org, AJvYcCUrjP8Z1WeFtF56CQkQlwHLaQ6dyKgh0RkOpb1e9Kb02eCEhG7ya93qEVnqjL77DZBQ/xrs1cU+x+8VJIg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8OGFIYI5TYxKGeeJ4fCP/OsyoMvPhbLXWO67ykHmp/HRh1B/v
	X6/w/ZQLp88s7F9uIM72S2ObQ9dcTcdLzhXMAq7NhJUf2NudV5Et4ac+LCXpClpanKPlYBtHI1b
	3E+PjecMdzsYbPBYZPFM1T13NzSs=
X-Google-Smtp-Source: AGHT+IEy4xd3HhUbPJ7ZgCIz6rOYwvi/cIePWW1SuBMdt1qqZRdmxIOGvY1KJaTDdoWsRzjD7MH7xfWYwSqrHrlybTQ=
X-Received: by 2002:a05:6102:dce:b0:48f:95aa:ae2b with SMTP id
 ada2fe7eead31-4978859e54cmr10497831137.28.1724082088045; Mon, 19 Aug 2024
 08:41:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240812082244.22810-1-e.velu@criteo.com> <3dcbfb0d-6e54-4450-a266-bf4701e77e08@gmail.com>
 <ZrzDAlMiEK4fnLmn@yury-ThinkPad> <CAL2JzuzEBAdkQfRPLXQHry2a2M7_EsScOV_kheo+oXUuKM9rWA@mail.gmail.com>
 <20240819083426.1aebc18f@kernel.org>
In-Reply-To: <20240819083426.1aebc18f@kernel.org>
From: Erwan Velu <erwanaliasr1@gmail.com>
Date: Mon, 19 Aug 2024 17:41:16 +0200
Message-ID: <CAL2Jzuy8UBnALFfFYpC4-whbWB9CkZC7vwXm4PRxWxzpeO2u2Q@mail.gmail.com>
Subject: Re: [PATCH] net/mlx5: Use cpumask_local_spread() instead of custom code
To: Jakub Kicinski <kuba@kernel.org>
Cc: Yury Norov <yury.norov@gmail.com>, Tariq Toukan <ttoukan.linux@gmail.com>, 
	Erwan Velu <e.velu@criteo.com>, Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>, 
	Tariq Toukan <tariqt@nvidia.com>, Yury Norov <ynorov@nvidia.com>, Rahul Anand <raanand@nvidia.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, linux-rdma@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Le lun. 19 ao=C3=BBt 2024 =C3=A0 17:34, Jakub Kicinski <kuba@kernel.org> a =
=C3=A9crit :
>
> On Mon, 19 Aug 2024 12:15:10 +0200 Erwan Velu wrote:
> > 2/ I was also wondering if we shouldn't have a kernel module option to
> > choose the allocation algorithm (I have a POC in that direction).
> > The benefit could be allowing the platform owner to select the
> > allocation algorithm that sys-admin needs.
> > On single-package AMD EPYC servers, the numa topology is pretty handy
> > for mapping the L3 affinity but it doesn't provide any particular hint
> > about the actual "distance" to the network device.
> > You can have up to 12 NUMA nodes on a single package but the actual
> > distance to the nic is almost identical as each core needs to use the
> > IOdie to reach the PCI devices.
> > We can see in the NUMA allocation logic assumptions like "1 NUMA per
> > package" logic that the actual distance between nodes should be
> > considered in the allocation logic.
>
> I think user space has more information on what the appropriate
> placement is than the kernel. We can have a reasonable default,
> and maybe try not to stupidly reset the settings when config
> changes (I don't think mlx5 does that but other drivers do);
> but having a way to select algorithm would only work if there
> was a well understood and finite set of algorithms.

I totally agree with this view, I'm wondering if people who used to
work on the mlx driver can provide hints about this task.
I have no idea if that requires any particular task at the fw level.
Is this a complex task to perform?
That feature would be super helpful to get precise tuning.

> IMHO we should try to sell this task to systemd-networkd or some other
> user space daemon. We now have netlink access to NAPI information,
> including IRQ<>NAPI<>queue mapping. It's possible to implement a
> completely driver-agnostic IRQ mapping support from user space
> (without the need to grep irq names like we used to)
Clearly that would be a nice path to achieve this feature.

