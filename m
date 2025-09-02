Return-Path: <linux-rdma+bounces-13040-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD6BBB409BC
	for <lists+linux-rdma@lfdr.de>; Tue,  2 Sep 2025 17:52:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1132F17D158
	for <lists+linux-rdma@lfdr.de>; Tue,  2 Sep 2025 15:52:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 098A832A81A;
	Tue,  2 Sep 2025 15:52:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=openai.com header.i=@openai.com header.b="Qq+etEVM"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FE572F530E
	for <linux-rdma@vger.kernel.org>; Tue,  2 Sep 2025 15:52:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756828335; cv=none; b=Ekt04AD72cGLsf7s82rPQ8Hy8J7DFp3fTncL0eXT8wbkJbiu+/fJsxV9EXOd5aVYvswPZ8dmpeeJEVbs4+58fXKz0yG85av58bDyXSt7TjUdaV9LTm0wWCdPm7eRvpMaO680dC7ROsf5KlgJyyhmjHvHeMaW7Q3uNxQkfFWNfCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756828335; c=relaxed/simple;
	bh=stLhhV7bm1vUFI/iU1WBQlYtrw7OG6XE8jShsR81V70=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nJ4vq9r7IMQQAbatHsZUowjsafb/3g6gQ7gPfhX/sCd/SG21kUIUq13/xWY9f8FVRRTT/NaBWHGlQ/MIi8pw3fOWGOiHVwrUSLr+8WqvT44bJQ0te/4kaU0H0mYUnohVg9RJm81QlQUXaAkpEe4w5H7U7pz4AKIPT6/Nu50upM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=openai.com; spf=pass smtp.mailfrom=openai.com; dkim=pass (1024-bit key) header.d=openai.com header.i=@openai.com header.b=Qq+etEVM; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=openai.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openai.com
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-333f92a69d4so42610891fa.2
        for <linux-rdma@vger.kernel.org>; Tue, 02 Sep 2025 08:52:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openai.com; s=google; t=1756828332; x=1757433132; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=stLhhV7bm1vUFI/iU1WBQlYtrw7OG6XE8jShsR81V70=;
        b=Qq+etEVMTaV7CZJy7fbVjo+Myg6LqBVoCHuuF77GYt9ClZywNx/aUME0GgLd8w5dha
         WLLGLNEzAyVQ/KF5pK90CRxR4fTHDQi0nRTNbkxcgrq/1y4xKSex43PcaZkA5VtaS8TJ
         aQeWwu0wgTvY/uvT8GfAvDg/8qd7zu9cF8dbs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756828332; x=1757433132;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=stLhhV7bm1vUFI/iU1WBQlYtrw7OG6XE8jShsR81V70=;
        b=mHfH0ebymvzhmRtF5pEOyomq0OGrRmmPe4L3vfaIPkhk+DqZeWjzDcf3fufM7mx3ez
         H9FnFThiAp7r01gUngDJJZoVJUnXc1vxwNsa9TNiEN5E90wihynOtBad6CoxiYtfSK1b
         rr3/s01W3ublZ5TikjbpZK3strOh274lfqLDG2x7YU7YuWlNZCOj2RzYchGayTKZf+Lm
         RNJgxB61z6+2AqEdEKkvnv1GCgFq11wzKU0Vqjo5tt2unNYWexJLr55zX/ITS3jorJAd
         7Q9Yt55ArWAsjHuM8qXJYtfz/hA9DlAuLVmKlAibyllnpSBVejGjlAxwWKkV+CaK4y69
         Jpqg==
X-Forwarded-Encrypted: i=1; AJvYcCVxz7tRewlM1XragtacU1GP8UhR95CBrOy2mg+e9+gicDJVF6mCXtVBvr/iS/i2+WW8+1bbd7/+P+af@vger.kernel.org
X-Gm-Message-State: AOJu0YxDreDbq1Ktx9CynLzGtH3yi9ui3fhZMMtyzUeoW9g5WR/hxher
	kW/5IvOCOa9dDDd7OphuifT0gc7AOBn2MKItBMU4OT14sxchN2QgqzbSIVhlF3vxTmGdAEE7wqs
	l3nrss9y0H0AX/xpptZVdD+7tBeO0ETyJ1GYmzwJYjw==
X-Gm-Gg: ASbGncvLgvNGE6cgh35pSGqxkXFOuXKKdwzJwpIwgIcGpdUKPmBQScBBuJTJhhDF+VX
	SpdlvICzzvEw9le+ynEMj3HzWLfQjm+116HXrVCqSryBqNXxm7cSeEmKMd5cEBgw5If0FH5a/hE
	R9FJeOKVAVCNrjnXvZ8CHiP16pUdwJ+TxXSD83Lm7oGUfSxQLrvJA1I4LZNrR7YxgGvp/a80d18
	a0V8CfGhFgnhpl2j90jy+Z8gLOGhnk6KwOuzYCxBU8Cm1bAEwEDqtj8rrOZjblI
X-Google-Smtp-Source: AGHT+IFLBXCpi7DHnKmwPh1wQEtdxsg94/MOK5AfXLAdui68Z928N/2/I1UOJHxa5Rdvs1rNz3Fh7wKz3/vUOpXEgLw=
X-Received: by 2002:a05:651c:4183:b0:335:2d39:efe8 with SMTP id
 38308e7fff4ca-336cb148b70mr30923391fa.44.1756828332127; Tue, 02 Sep 2025
 08:52:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250828-cpaasch-pf-927-netmlx5-avoid-copying-the-payload-to-the-malloced-area-v4-0-bfcd5033a77c@openai.com>
 <aLIs_-lDKHCLTrTy@x130> <e0786dbc-4681-4bee-a54a-e58c1b9b7557@gmail.com>
In-Reply-To: <e0786dbc-4681-4bee-a54a-e58c1b9b7557@gmail.com>
From: Christoph Paasch <cpaasch@openai.com>
Date: Tue, 2 Sep 2025 08:51:59 -0700
X-Gm-Features: Ac12FXzhLOJq0ytlrXGx13ITo2PO1Hdam1DCDF49TdzDn0Pda0hF-4fNTx9ov7Y
Message-ID: <CADg4-L8+c+kHHzJhEaxKoNowbONqfMPVuqyOw7_DqhKFqzzLFw@mail.gmail.com>
Subject: Re: [PATCH net-next v4 0/2] net/mlx5: Avoid payload in skb's linear
 part for better GRO-processing
To: Tariq Toukan <ttoukan.linux@gmail.com>
Cc: Saeed Mahameed <saeed@kernel.org>, Gal Pressman <gal@nvidia.com>, 
	Dragos Tatulea <dtatulea@nvidia.com>, Saeed Mahameed <saeedm@nvidia.com>, 
	Tariq Toukan <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>, Leon Romanovsky <leon@kernel.org>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, 
	Stanislav Fomichev <sdf@fomichev.me>, netdev@vger.kernel.org, linux-rdma@vger.kernel.org, 
	bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello Tariq,

On Sun, Aug 31, 2025 at 2:28=E2=80=AFAM Tariq Toukan <ttoukan.linux@gmail.c=
om> wrote:
>
>
>
> On 30/08/2025 1:43, Saeed Mahameed wrote:
> > On 28 Aug 20:36, Christoph Paasch via B4 Relay wrote:
> >> When LRO is enabled on the MLX, mlx5e_skb_from_cqe_mpwrq_nonlinear
> >> copies parts of the payload to the linear part of the skb.
> >>
> >> This triggers suboptimal processing in GRO, causing slow throughput,..=
.
> >>
> >> This patch series addresses this by using eth_get_headlen to compute t=
he
> >> size of the protocol headers and only copy those bits. This results in
> >> a significant throughput improvement (detailled results in the specifi=
c
> >> patch).
> >>
> >> Signed-off-by: Christoph Paasch <cpaasch@openai.com>
> >
> > LGTM, I would love to take this to net-next-mlx5 and submit it back to
> > netdev after regression testing if that's ok? Christoph? Anyway I will
> > wait for Jakub to mark this as "awaiting-upstream" or if he
> > applies it directly then fine.
> >
> >
> >
>
> Hi,
>
> I recall trying out similar approach internally a few years ago.
>
> eth_get_headlen() function didn't work properly for non-Eth frames
> (ipoib). I believe this is still the case.
>
> Extra care is needed for the ipoib flow, which I assume gets broken here.

Are you actually sure that ipoib goes through
mlx5e_skb_from_cqe_mpwrq_nonlinear() ? Because, as far as I can see,
IPoIB disables striding in mlx5i_build_nic_params().

It's rather mlx5e_skb_from_cqe_nonlinear() that handles both, ethernet
and ipoib.


Christoph

>
> According to the perf gain, it is worth splitting to multiple code paths
> via branches/function pointers.
>
> Regards,
> Tariq

