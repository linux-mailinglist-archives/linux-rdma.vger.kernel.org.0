Return-Path: <linux-rdma+bounces-6015-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5465B9D0241
	for <lists+linux-rdma@lfdr.de>; Sun, 17 Nov 2024 07:34:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 014471F239EF
	for <lists+linux-rdma@lfdr.de>; Sun, 17 Nov 2024 06:34:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A351029CEF;
	Sun, 17 Nov 2024 06:34:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fZ/gAa/V"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0887A28F5;
	Sun, 17 Nov 2024 06:34:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731825249; cv=none; b=W8qW581gJnfya0nUzsAKSw6XYRItrOtANP6MVE+JVZMOVu+1vfq41uTg/mT62bA5QwYgo9SzlvIjK4lkuzk8msv3CyltgcdPVn98srTOTxQNe1OzjgcYTOWfZd8wBaJFr3mHepkAZcxDUyl4aeHejbrXHVYF6VB/7xPEMeshZNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731825249; c=relaxed/simple;
	bh=gsX8/Mr6ZipynmvwjhuvN3wQ0AEi5mBidtZOhIGQLjM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aZqttbMnZK4anSQzEDhpB2EPMN7ITjiJcgVpjLbElKkwsNz44jx/x0i4+Xp9g9ISMQnNvG8eXha/b75TfTtZkgySml8kFE96yiS6xWcvWc8O6M3sS30lVPMrLJwptNk0YglJRSRkXl/C8fsJdhNxyVzKB2TLusAJVrdlLtnALOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fZ/gAa/V; arc=none smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-6d41f721047so199356d6.1;
        Sat, 16 Nov 2024 22:34:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731825247; x=1732430047; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Llp461Ox5dWCJI8j4xlqQdNbwBiK+AxIcle+FmhTh/M=;
        b=fZ/gAa/VzuQEORV6OZAVgUt9VTMfPzhir6ieT5kP/wLlAqmqppGOexfS3HJscwWzYc
         cZQ/BtBrtSf7gvZiYILeJgdybmLZzUr3+bCfcZOGGrc4wSKk7QK/g+MKYE3n3/Nz2Txn
         clKjCczrHnSag2rrBcbQYCWWrGDrvNARUcI+UgTZ5yP8wsmN+m9fSqwUpV7SGuQQuEeL
         P7ryXDJfmxMMUzERnK7+CoShpIuTwaZem09vo39jhCP6WeJX86ctFOWPfDRwFTfZSfj5
         uV1CgISzKedHrx5fx1vYHgmx1cn2/532FZ4deTBG4CL4XpWeb6dEUFS/pHMGwpcaaVd6
         B45Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731825247; x=1732430047;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Llp461Ox5dWCJI8j4xlqQdNbwBiK+AxIcle+FmhTh/M=;
        b=laJseaAqmdhQjZuWJ4N9OoyLTK1xwkZFrF7+8Ol9ntyciEM2TDPMQ612d4WLoB5yJV
         sH3lNhMbQlEbcCmeyFE4JyCeUabs5i2CTZtAJELCZ0Oju1rQQuQ1DcAyj+z/0ZqzwF/z
         t2rO/Doe2gmGeTIJ9a/i0ULBf5CaXTrOdvuq6HU+KMl1hjOdjzqc2uPLKZMxzgO+Kw9C
         O334TQGuyl6z/4RQ0INi5qJftdExJg3xx8DGitYBqQkoVt+nxvAMGA4ntWtJjrSsDYZj
         dCdi0rDn23vc7IIVzkPQQjnd1h2RyH/hA7ZNAWjiHF+BKRw3u1UA9/7Mx/aQf94nJhJW
         vq7A==
X-Forwarded-Encrypted: i=1; AJvYcCW95rsbVw7S8V6ckw1wWCfVZ+4SR7Hzxnskx5BWeZ4LgqGQUZ9loEP9FrYJaZiDFCOzmwwhCSAXng5I@vger.kernel.org, AJvYcCXL3EWPWxByzOu5QF4PAZSc4uixV2UrHL4bYvhBfBY5cC5De6YxoUvUXpfBSEa5homY6lXTlwfp@vger.kernel.org
X-Gm-Message-State: AOJu0Yy34c/2BAGmRGlWH4jJvp+UxXIQ9LQbLeYGGyx4oTNQowHlfzeV
	w5TfsVcz0GOTBrxHpE2GkGCjbsUAbD7Fiw5+bPkW1TNEf0NEz7CHsrH11t7X79VCi7GOBo+OCLK
	OYVhuLVCrPlfEC1p7QJusAWpt24g=
X-Google-Smtp-Source: AGHT+IHfgygckDfPXX0L1LnLV1/q7U0/z5MeorMgYMcjfj7om6vSM+2og4ShWwnigTq+SJ/Sd/9W6ld5RoL4TU9DZVk=
X-Received: by 2002:a05:6214:242a:b0:6d4:b1b:8b9c with SMTP id
 6a1803df08f44-6d40b1b8cc3mr84667596d6.3.1731825246961; Sat, 16 Nov 2024
 22:34:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241114021711.5691-1-laoar.shao@gmail.com> <20241114182750.0678f9ed@kernel.org>
 <CALOAHbCQeoPfQnXK-Zt6+Fc-UuNAn12UwgT_y11gzrmtnWWpUQ@mail.gmail.com>
 <20241114203256.3f0f2de2@kernel.org> <CALOAHbBJ2xWKZ5frzR5wKq1D7-mzS62QkWpxB5Q-A7dR-Djhnw@mail.gmail.com>
 <Zzb_7hXRPgYMACb9@x130> <20241115112443.197c6c4e@kernel.org> <Zzem_raXbyAuSyZO@x130>
In-Reply-To: <Zzem_raXbyAuSyZO@x130>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Sun, 17 Nov 2024 14:33:31 +0800
Message-ID: <CALOAHbC2E4-7EhE=ZXBT_bF5Cuvcrt0Grf51EAcebzFa7tLB=w@mail.gmail.com>
Subject: Re: [PATCH v2 net-next] net/mlx5e: Report rx_discards_phy via rx_fifo_errors
To: Saeed Mahameed <saeed@kernel.org>
Cc: Jakub Kicinski <kuba@kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, ttoukan.linux@gmail.com, 
	gal@nvidia.com, tariqt@nvidia.com, leon@kernel.org, netdev@vger.kernel.org, 
	linux-rdma@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 16, 2024 at 3:54=E2=80=AFAM Saeed Mahameed <saeed@kernel.org> w=
rote:
>
> On 15 Nov 11:24, Jakub Kicinski wrote:
> >On Fri, 15 Nov 2024 00:01:50 -0800 Saeed Mahameed wrote:
> >> not rx_missed_errors please, it is exclusive for software lack of buff=
ers.
> >>
> >> Please have a look at thtool_eth_XXX_stats IEEE ethnl_stats, if you ne=
ed to
> >> extend, this is the place.
> >>
> >> RFC2863[1] defines this type of discards as ifInDiscards. So let's add
> >> it to ehttool std stats. mlx5 reports most of them already to driver c=
ustom
> >> ethtool -S
> >
> >We can, but honestly I'd just make sure they are counted in rx_dropped
>
> rx_dropped: Number of packets received but not processed,
>   *   e.g. due to lack of resources or unsupported protocol.
>   *   For hardware interfaces this counter may include packets discarded
>   *   due to L2 address filtering but should not include packets dropped
>                                   ^^^^^^^^^^^^^^
>   *   by the device due to buffer exhaustion which are counted separately=
 in
>                            ^^^^^^^^^^^^^^^^^
>   *   @rx_missed_errors (since procfs folds those two counters together).
>       ^^^^^^^^^^^^^^^^^
>
> I think we should use rx_fifo_errors for this and update documentation:

Hello Saeed,

Could we apply the change to
`drivers/net/ethernet/mellanox/mlx5/core/en_main.c` first and update
the documentation in a future patch? Updating the documentation
perfectly seems like a challenging task, and I=E2=80=99m not the best perso=
n
for that job ;)


--
Regards
Yafang

