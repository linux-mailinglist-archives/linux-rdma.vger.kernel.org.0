Return-Path: <linux-rdma+bounces-13770-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AB85BB7817
	for <lists+linux-rdma@lfdr.de>; Fri, 03 Oct 2025 18:15:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B73024EDA53
	for <lists+linux-rdma@lfdr.de>; Fri,  3 Oct 2025 16:15:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92B962BE7D9;
	Fri,  3 Oct 2025 16:15:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SfsOhdde"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 876A8281371
	for <linux-rdma@vger.kernel.org>; Fri,  3 Oct 2025 16:15:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759508116; cv=none; b=EeDipkY04zE56Tf6OKJMklRd1HXQyh2+7fg+EG1OPcOzcECUk0onQUDqbbwrSLj5z/j90jRrTFJZvV1Mzz7Y67NLgupkVBL3eqVjs4mSDs+RBD+fkU2LMXFwDxFSgEkCwbJ4bMQmVelRvNWgySpV5LJ/WT6ZSM84pAylgDS9hOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759508116; c=relaxed/simple;
	bh=7wuFMGs0dHFY4V1AjLX74sWwcF/NB+Jk1Zc5be1peEw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LSPO52+i4fBcwyElVP/lXfxDjHe5j7w9qOb4h8s3222sjaX15UZG4juLinOHJhgVpBj1IyHmVCmxKoGO6e6C348GhdVMQd4B7EB9Ui2EPPyBxyNw5U2nD/SxbT6OK/1rxZO3tESI/NrbCdCrJ9cQvXO+x/QIV1qOFHcSW3HkmqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=SfsOhdde; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-4db7e5a653cso24167781cf.1
        for <linux-rdma@vger.kernel.org>; Fri, 03 Oct 2025 09:15:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1759508112; x=1760112912; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mRT/iYpKxpou3nIU4G8aZA9jml41omx9hIjrGCgXioY=;
        b=SfsOhdde7T+jjBRwgvdZO4pqAshekPhkCM4BYg+935xeBWdsFT70GSpgqlwuZS1YsH
         sauWqezY5eXtwfpTEvFr9uvlc2YDYoPzqLXh97WsdwtzbtWi27D5+Ep8ARwmbghoFJ66
         EiwmTTfh5CVGUZGc25ow25iNXk6bwxKJxSlBq4EY+0UT0Li8V61DhAt+EsnuUzhyx49I
         Cbbzbvl6rZwUCr0eQWTp4NRe4n5Db6oo7X11J01B/Wh12jTyNg+c+GMtOZM0pn9t1Tzl
         x3QtZsgXaN09yCNPUas8lxPyEHyAsOAnYuf2z2XswptlQvdIgJkkSWjCm95NVqTlQxS1
         +gcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759508112; x=1760112912;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mRT/iYpKxpou3nIU4G8aZA9jml41omx9hIjrGCgXioY=;
        b=YAqeELsG7pAkLdtMbgP2o3fsF3c6x/wh77iq8af4FFLQZ/zwt6ETspS1Homolx8ttU
         HGnPbhCJK7m0x8HzDMihHwJWB8ZkqIoBsg0uoK+F7t9nYSqqSTWr83KHrjDAaU+gO4jg
         II3nh8B+kTOt6nnrIrLGc/s5z8BTp/iOkTL6ujfDSCVUvhmHv/xGUbRO7ifiSwjkWZtO
         7ntuCBw+swFgqL5vVRgvw0UM/DAzxsbqoOlRmkCeGFeRaNsyKwhgPGACs2nBduUswWwK
         AZN2llkZ78+i10X0HPsZtVijewDxMpUnYNTfwsoEYb0comkDq00f+OkcpUiXIkGqD87a
         4kYQ==
X-Forwarded-Encrypted: i=1; AJvYcCUgRJVdpPEQJucTrtx2kJQWCjJ+inLz/I7xc4GeO+3BECa273scHJ3PFRLDD+MANVzTZOEFlp7W3rXI@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3j4kvBluGFG04tZlEFtM5fDrcXY2vFQk/tJQTlDv7zu40KgNt
	U3QDFfneZiOaFOw8iWXp2h5EXNgRRJMs+/r2NyHT6SSMtXHlRSFTQbdrsWIJkm6DLcCX1wnlIkS
	ey92VXUR8P4yn1rQV/9IjeTUfdZlALVqEVWq70c1V
X-Gm-Gg: ASbGnctwC+n9HEhJvDMXA2GO9pS2OwBJC1akXMBQaEgDxSI7tTEhUXARREvXp3fgrap
	Z11J+f4n2JmPFYH5pZipFKS+zTeLItlSx4jAFJPcSkCjmDZMUTR8zOUwGaG3oZIWGcrXWFZPlie
	JcLX9EHlhnXayugIPaUmHrJxZXJoBtJ6l2ZedNTwUtMd6zkVKol32Teeuev1fSn22mbz7pTG4el
	tQFGH26E4Y0LfQqiRZWY53LrJnW+RU8Emi7SjiFpTrFhl5LMlrZe0Iz0TwwWLdCtiQZmGdD
X-Google-Smtp-Source: AGHT+IF7ePNKC/efflqXHwYHgjxSxDTK8C6+GyU9k0GrT7S6haFlI4McuaUxqH1svu1wQ3PG3W0WiRmSfLdQYtAxFzc=
X-Received: by 2002:a05:622a:5813:b0:4b7:b1cb:5bd8 with SMTP id
 d75a77b69052e-4e576ae6a76mr55687871cf.73.1759508111841; Fri, 03 Oct 2025
 09:15:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251003154724.GA15670@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
In-Reply-To: <20251003154724.GA15670@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 3 Oct 2025 09:15:00 -0700
X-Gm-Features: AS18NWBvRkA8XJUstYFSzhKHyU5fYwBegMPqLVfkMF5poIlBOyx5qh3MF6NBsnY
Message-ID: <CANn89iJwkbxC5HvSKmk807K-3HY+YR1kt-LhcYwnoFLAaeVVow@mail.gmail.com>
Subject: Re: [PATCH net-next] net: mana: Linearize SKB if TX SGEs exceeds
 hardware limit
To: Aditya Garg <gargaditya@linux.microsoft.com>
Cc: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org, 
	decui@microsoft.com, andrew+netdev@lunn.ch, davem@davemloft.net, 
	kuba@kernel.org, pabeni@redhat.com, longli@microsoft.com, 
	kotaranov@microsoft.com, horms@kernel.org, shradhagupta@linux.microsoft.com, 
	ernis@linux.microsoft.com, dipayanroy@linux.microsoft.com, 
	shirazsaleem@microsoft.com, linux-hyperv@vger.kernel.org, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-rdma@vger.kernel.org, gargaditya@microsoft.com, 
	ssengar@linux.microsoft.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 3, 2025 at 8:47=E2=80=AFAM Aditya Garg
<gargaditya@linux.microsoft.com> wrote:
>
> The MANA hardware supports a maximum of 30 scatter-gather entries (SGEs)
> per TX WQE. In rare configurations where MAX_SKB_FRAGS + 2 exceeds this
> limit, the driver drops the skb. Add a check in mana_start_xmit() to
> detect such cases and linearize the SKB before transmission.
>
> Return NETDEV_TX_BUSY only for -ENOSPC from mana_gd_post_work_request(),
> send other errors to free_sgl_ptr to free resources and record the tx
> drop.
>
> Signed-off-by: Aditya Garg <gargaditya@linux.microsoft.com>
> Reviewed-by: Dipayaan Roy <dipayanroy@linux.microsoft.com>
> ---
>  drivers/net/ethernet/microsoft/mana/mana_en.c | 26 +++++++++++++++----
>  include/net/mana/gdma.h                       |  8 +++++-
>  include/net/mana/mana.h                       |  1 +
>  3 files changed, 29 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/net/ethernet/microsoft/mana/mana_en.c b/drivers/net/=
ethernet/microsoft/mana/mana_en.c
> index f4fc86f20213..22605753ca84 100644
> --- a/drivers/net/ethernet/microsoft/mana/mana_en.c
> +++ b/drivers/net/ethernet/microsoft/mana/mana_en.c
> @@ -20,6 +20,7 @@
>
>  #include <net/mana/mana.h>
>  #include <net/mana/mana_auxiliary.h>
> +#include <linux/skbuff.h>
>
>  static DEFINE_IDA(mana_adev_ida);
>
> @@ -289,6 +290,19 @@ netdev_tx_t mana_start_xmit(struct sk_buff *skb, str=
uct net_device *ndev)
>         cq =3D &apc->tx_qp[txq_idx].tx_cq;
>         tx_stats =3D &txq->stats;
>
> +       BUILD_BUG_ON(MAX_TX_WQE_SGL_ENTRIES !=3D MANA_MAX_TX_WQE_SGL_ENTR=
IES);
> +       #if (MAX_SKB_FRAGS + 2 > MANA_MAX_TX_WQE_SGL_ENTRIES)
> +               if (skb_shinfo(skb)->nr_frags + 2 > MANA_MAX_TX_WQE_SGL_E=
NTRIES) {
> +                       netdev_info_once(ndev,
> +                                        "nr_frags %d exceeds max support=
ed sge limit. Attempting skb_linearize\n",
> +                                        skb_shinfo(skb)->nr_frags);
> +                       if (skb_linearize(skb)) {

This will fail in many cases.

This sort of check is better done in ndo_features_check()

Most probably this would occur for GSO packets, so can ask a software
segmentation
to avoid this big and risky kmalloc() by all means.

Look at idpf_features_check()  which has something similar.

