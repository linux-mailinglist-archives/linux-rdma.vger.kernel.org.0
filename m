Return-Path: <linux-rdma+bounces-11480-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E3F76AE0F87
	for <lists+linux-rdma@lfdr.de>; Fri, 20 Jun 2025 00:19:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8ED8717AC7D
	for <lists+linux-rdma@lfdr.de>; Thu, 19 Jun 2025 22:19:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 719BB22488B;
	Thu, 19 Jun 2025 22:19:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DxsjNcKl"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCFA930E826
	for <linux-rdma@vger.kernel.org>; Thu, 19 Jun 2025 22:19:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750371591; cv=none; b=TSbsSsL25iVHtIQHfZXQeQ5Wq/9A00u2a/ZKtyFeYx9UEdD3xMw3h7tp3ntU9hSAU+uBSgsuBPakSyQMxN6Glgm0ygmSiJpbOPST81gn2QJGM8+7YzDTr1Ru35hihGN2BrxxDI3kZhNucpsdioywUXUtFh1PSMeIaJYW2pHct20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750371591; c=relaxed/simple;
	bh=jzE7STPASTWXr5d4DzsQEgZiCI9HTUGx9Hsc5oeFyWk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HV7StC1KG5UZarQEmWKImt/2eqd443zZhB24Ozx6LizWD+c+GpxB5QwTUqjx4my7NYlByWPPyV1zGSEqWe0N8Jxym5cHfbe7YjKR6Mlp90iXo7G8cwQZpb1DRGH2t8ojG8gkXJQJICU5QTYdF+8XmVnpiHP+zFmR/lERqvlVBCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=DxsjNcKl; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-235e389599fso267955ad.0
        for <linux-rdma@vger.kernel.org>; Thu, 19 Jun 2025 15:19:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1750371589; x=1750976389; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jzE7STPASTWXr5d4DzsQEgZiCI9HTUGx9Hsc5oeFyWk=;
        b=DxsjNcKl51AXRSRLfvtYmNUjfUAYw/9VBR7r+MshkTMmzuQphgo7pzLeU8cLmcEUac
         obPM1ecWgPitNNkAbskbX7ouXh+ct4VvOH57K+fMv+R9sR8s980nlkYI6LVcPld23S0J
         Po55ByiAQ/qFQHSioTFiaqs8HB2JtwzLbfCQH8+NroDx91Cm3MwpbWlnfHqbhR59gjvY
         staNRyNhkm98LQpdkJ6kJ784K94aNva7GEGFxYOSYX0AueAUmJmfiB+iHFt9M0SJsBOM
         uozh5NGafx+aWvw/BHxWt5MVV18PXy45GDptDXgnFw8IHi4s2oy2HzSe7WpQJCteftCe
         HGcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750371589; x=1750976389;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jzE7STPASTWXr5d4DzsQEgZiCI9HTUGx9Hsc5oeFyWk=;
        b=PM2Sk/sNhPvh8XxG597UAfWnoyafEuzkw0Zaf3HFNxnv7HuHo/iWtKtn3x3GAhay/X
         ihv6mcPnFYbnoscnoqDEcBz64LEHYPEX29OdCwtG+sLOyxSev/rt4Xrk24UsNbh22AbB
         M+EM7l/GQqtOwpK3s0IfAkPmy/xxa6V0qlRcSfIfgs0UF0ELZAkyPmCgzcwoOvj3Ia27
         NkKfHz0yNzes5Cduvf8YCufGCqoi7j2LH+OOQn9q5bTr3Fqzvb1dWK4ynaYea8KSIqYY
         x6FqQZ5bV9FlP5q4hlfjYBi4apzPhnuN39jLmwJkn5P2Q1jEe9155HNIaGdmsb8QHMMZ
         ChIA==
X-Forwarded-Encrypted: i=1; AJvYcCVKxkiYBfhf41CMzgGDDUPAN4g76ytHHaO8GY6jDGwcer2IfCmwvvngWzTTcxvh7EjtfyLEqAKfHZZF@vger.kernel.org
X-Gm-Message-State: AOJu0YxjbAambOwD+tuvYLCkHEV+Gkp+OE4Q1L0g9XW9XoXmWEZjbX3d
	xsnHM+MtSVgcgynuHQPAXnFD9NtZC6uVtND2vrD1UMoFscR0i03f05YIqjpNtkYRn92qp709cmu
	QHViEahTa8B37JYVl1UmkmYPN9J0KgcT/lTmh3tv3
X-Gm-Gg: ASbGnctslCurirSHV2gkYk7aKhRF2AWuz43sGzABr9hvRhJIa6crJq3EGvic0C2edqr
	hWHvxpQ2N5cFGXkc2QY2wXhAKwOwe94gdUCssS1OpCemYUFjt9AtKMpjZkXY01BJJX121dQPzqz
	0vfnfzVJYK3wyuzZf6RxRYC6idEu5uT9roxpg0t3kmqh+K
X-Google-Smtp-Source: AGHT+IEIuigoQw9BiLSxf1qtBH8TQCN6oIl0OunjJBmsKS0D6b25SrS5tvIo5+EfAZz5fwtG0XZyMihlM2iaVGUlOzY=
X-Received: by 2002:a17:903:19cf:b0:234:9f02:e937 with SMTP id
 d9443c01a7336-237ce047dccmr3307715ad.25.1750371588876; Thu, 19 Jun 2025
 15:19:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250616141441.1243044-1-mbloch@nvidia.com> <20250616141441.1243044-13-mbloch@nvidia.com>
 <aFM6r9kFHeTdj-25@mini-arch> <q7ed7rgg4uakhcc3wjxz3y6qzrvc3mhrdcpljlwfsa2a7u3sgn@6f2ronq35nee>
 <CAHS8izM-9vystQMRZrcCmjnT6N6KyqTU0QkFMJGU7GGLKKq87g@mail.gmail.com> <xguqgmau25gnejtfrgx3szhneacyg2cjj6vlsi5g7fouyn2s43@nemy5ewelqrh>
In-Reply-To: <xguqgmau25gnejtfrgx3szhneacyg2cjj6vlsi5g7fouyn2s43@nemy5ewelqrh>
From: Mina Almasry <almasrymina@google.com>
Date: Thu, 19 Jun 2025 15:19:35 -0700
X-Gm-Features: AX0GCFvxm9EEgLCdwq7qt68RwaSnO_IWyvBob_0iL-n-QjvMmTutgFl2WipSVW8
Message-ID: <CAHS8izNQ+eRH3L-npJXDO7cCYo82jPL0jROBnYXu2U7Kko65Kg@mail.gmail.com>
Subject: Re: [PATCH net-next v6 12/12] net/mlx5e: Add TX support for netmems
To: Dragos Tatulea <dtatulea@nvidia.com>
Cc: Stanislav Fomichev <stfomichev@gmail.com>, Mark Bloch <mbloch@nvidia.com>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Eric Dumazet <edumazet@google.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	Simon Horman <horms@kernel.org>, saeedm@nvidia.com, gal@nvidia.com, leonro@nvidia.com, 
	tariqt@nvidia.com, Leon Romanovsky <leon@kernel.org>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
	Richard Cochran <richardcochran@gmail.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, John Fastabend <john.fastabend@gmail.com>, 
	Stanislav Fomichev <sdf@fomichev.me>, netdev@vger.kernel.org, linux-rdma@vger.kernel.org, 
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 19, 2025 at 9:07=E2=80=AFAM Dragos Tatulea <dtatulea@nvidia.com=
> wrote:
> > You have to test ncdevmem tx on a platform with iommu enabled. Only in
> > this case the netmem_dma_unmap_page_attrs() may cause a problem, and
> > even then it's not a sure thing. It depends on the type of iommu and
> > type of dmabuf i think.
> >
> Is it worth adding a WARN_ON_ONCE(netmem_is_net_iov())
> in netmem_dma_unmap_page_attrs() after addr check to catch these kinds
> of misuse?
>

I would say it's worth it, but it's the same challenge you point to in
your reply: netmem_dma_unmap_page_attrs currently doesn't take in a
netmem, and it may be a big refactor not worth it if it's callers also
don't have a reference to the netmem readily available to pass it.

--=20
Thanks,
Mina

