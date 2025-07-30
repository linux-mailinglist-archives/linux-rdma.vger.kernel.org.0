Return-Path: <linux-rdma+bounces-12543-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D4E44B16058
	for <lists+linux-rdma@lfdr.de>; Wed, 30 Jul 2025 14:29:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 11B2B18C63BA
	for <lists+linux-rdma@lfdr.de>; Wed, 30 Jul 2025 12:29:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF9F5293C42;
	Wed, 30 Jul 2025 12:29:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="POxEB0zN"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E67511CFBC
	for <linux-rdma@vger.kernel.org>; Wed, 30 Jul 2025 12:28:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753878541; cv=none; b=cn55VfdOy8QJiuTatPFHmJTxzyYNHcAXZJ6Q/tydAY6ODfNGcRNM/jl6w+5P6zbeXa8+9O/TW/h/ucrmSY5sWB3SNdajz79qOCA+ci8SUPsilxQyLW4JHbB5gFWnDml7aRmHhRKzoBxzz7NyJ31p1eps8l1Q3JZ7IhjQn7K5ecY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753878541; c=relaxed/simple;
	bh=IZ/OTngZy2Mi6vj/vOpyQEjcgA4q1OyqQRRfcttTFco=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Vc6RfcwxIOCmmhVcUZagyWwbzVg3aV3hS8NMgc5TxHHGVpUrYzQTrdK8ZfhRHRCSYlfpU547ApfQKCTR/xmeD/UMfupJ4gN1DLYJA0pe7SM7nr+ZSAjSzLF/hwLzp81cMQNbWBnfCnySJvku08yygCCEhGuIY6ySzzd1Gpr1CGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=POxEB0zN; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-4ab5953f5dcso63772921cf.0
        for <linux-rdma@vger.kernel.org>; Wed, 30 Jul 2025 05:28:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753878539; x=1754483339; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ppl7GfCvdi8WhvermZiN9U0bWxGPulu5aSA9xogTY4A=;
        b=POxEB0zNsPTMwsS7aGPkyQEh3FHDJCPxAEwaAtO8MJbFZFFTI7+eDoTNyqiChdz6+m
         0WeCVjh10V+q7/xv4DjctVLfHPK3xBYSK+XAmBE5P88bK1p+ePkVogJ3NNdUvLJhSllc
         XTcLOY63beSCPN3OW1z7lfB/ZxUP70ZHOI0Qj1G18yU9VC7DRQN4KECJsEsaW46I1ytx
         JHm+wolQb3jdPS88HPrROloniVwlFibWPT8ZMK0YA9P7T6U24zmKVij5ZmattaXAAHRH
         PNGSB+rmPWO2Uoi5iH+lSentmolXDNKQOURX0XqUA3Lewq4l0XRfbLQ/GUTCbzBKlGt8
         kSMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753878539; x=1754483339;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ppl7GfCvdi8WhvermZiN9U0bWxGPulu5aSA9xogTY4A=;
        b=pZPiO8aqKs1anNtRIWP3KMt2IEnFVz60EcPPia6g/2xrvFk++bkQdIGSdu1yV4FQ9G
         Cxz5hSlXBzatRqN7YSn/XpbBRUztxz28nlxV9gs4NvbomfblQ7tifAAwmmnAEKoOE2B5
         frKqlX3ParyCrFxFPoDLvcTXZ2v87xkHXtbZeKFlFsiqvaB+q7+pEWsxdbYTJTPcqC+9
         qcmo6D1QOQdABRyk3dgqwtwFVB1CcOQRHXOLVDLevPtnmyU+/mEpPeda0C5lpTVT4fWO
         9GxfcRkU1sjeIYbvGabikOLeEnpNBYxLK73LGgKBDGEwmTGtw85/vdfLtDwrBeO+RXK5
         b0EA==
X-Forwarded-Encrypted: i=1; AJvYcCXDZPwUIE5A/7/gJnih51Z7VqYYQZj6XTWKHG7f1BNkKbQolBflWFBkTiFRSv7w5rglUHUcEw1jEm7f@vger.kernel.org
X-Gm-Message-State: AOJu0YywrWzP+GkezW8uaCMYZmbLOoIXfQwZ79/QJ+STagQVzoP2DQcg
	6oYOx6RwMz9pjIB6Y0AkM+g31ArIlQ8K89vIlMwEAzyJXcJRTaiz+bRfodOlZ1SIZOd7fJboUbg
	kL+Dc5eojlCz2sUZXcIro30ip7dXcKPNaYDUnMbNm
X-Gm-Gg: ASbGncsEuFDGNt7h8MQmX6UqS4lhNpo3AGQR2KlfwCzjUGKzL5Rp5GJZ6/bUnkshXO/
	a7exlQ3c6JRGXBDwxwJ/4k891FxgFinpjEcd6BDXcw7sZYl93AF+pi8IZFEAOemO+vQcbfnWBBN
	lxgAu5LV0fWQ90ypwVfEhcGtgXVriJwY9g5P+HkXZW8NJjGcElmlwEa1Yfn5NeHx0disTVAoi5Y
	KQhsf5Q
X-Google-Smtp-Source: AGHT+IGyt82CSrQgUTCp8qFoyWfEguWgEPkJ8Pc4196lTsGbL2lAl7A0t6foErdTcvVN622HhtW15B/qjJX71dikROs=
X-Received: by 2002:ac8:5a8a:0:b0:4ab:6880:729e with SMTP id
 d75a77b69052e-4aedb9ce199mr51332091cf.18.1753878538163; Wed, 30 Jul 2025
 05:28:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250729-mlx5_gso_segs-v1-1-b48c480c1c12@openai.com> <195d0388-57ca-4a1a-bc92-65da899443ab@nvidia.com>
In-Reply-To: <195d0388-57ca-4a1a-bc92-65da899443ab@nvidia.com>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 30 Jul 2025 05:28:46 -0700
X-Gm-Features: Ac12FXzl3fKAdaw8-GZUbfgXIu120SIVvri8Vnh_xHQM3WTTAvTeu_WCjzZobn4
Message-ID: <CANn89iJo5Fxx4kqhE4S+z4N0BtLW2462Pc6uBB2OvPDpo7-pKw@mail.gmail.com>
Subject: Re: [PATCH net] net/mlx5: Correctly set gso_segs when LRO is used
To: Gal Pressman <gal@nvidia.com>, Willem de Bruijn <willemb@google.com>, Bailey Forrest <bcf@google.com>, 
	Catherine Sullivan <csully@google.com>
Cc: cpaasch@openai.com, Saeed Mahameed <saeedm@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>, 
	Mark Bloch <mbloch@nvidia.com>, Leon Romanovsky <leon@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Amir Vadai <amirv@mellanox.com>, netdev@vger.kernel.org, linux-rdma@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 30, 2025 at 4:06=E2=80=AFAM Gal Pressman <gal@nvidia.com> wrote=
:
>
> On 29/07/2025 21:34, Christoph Paasch via B4 Relay wrote:
> > From: Christoph Paasch <cpaasch@openai.com>
> >
> > When gso_segs is left at 0, a number of assumptions will end up being
> > incorrect throughout the stack.
> >
> > For example, in the GRO-path, we set NAPI_GRO_CB()->count to gso_segs.
> > So, if a non-LRO'ed packet followed by an LRO'ed packet is being
> > processed in GRO, the first one will have NAPI_GRO_CB()->count set to 1=
 and
> > the next one to 0 (in dev_gro_receive()).
> > Since commit 531d0d32de3e
> > ("net/mlx5: Correctly set gso_size when LRO is used")
> > these packets will get merged (as their gso_size now matches).
> > So, we end up in gro_complete() with NAPI_GRO_CB()->count =3D=3D 1 and =
thus
> > don't call inet_gro_complete(). Meaning, checksum-validation in
> > tcp_checksum_complete() will fail with a "hw csum failure".
> >
> > Even before the above mentioned commit, incorrect gso_segs means that o=
ther
> > things like TCP's accounting of incoming packets (tp->segs_in,
> > data_segs_in, rcv_ooopack) will be incorrect. Which means that if one
> > does bytes_received/data_segs_in, the result will be bigger than the
> > MTU.
> >
> > Fix this by initializing gso_segs correctly when LRO is used.
> >
> > Fixes: e586b3b0baee ("net/mlx5: Ethernet Datapath files")
>
> Maybe we should put an additional Fixes line for the gso_size patch?
> It doesn't directly fix it, but it will clearly emphasize the importance
> of picking up this patch together with the other one.
>
> > Reported-by: Gal Pressman <gal@nvidia.com>
> > Closes: https://lore.kernel.org/netdev/6583783f-f0fb-4fb1-a415-feec8155=
bc69@nvidia.com/
> > Signed-off-by: Christoph Paasch <cpaasch@openai.com>
>
> Thanks Christoph,
> Reviewed-by: Gal Pressman <gal@nvidia.com>

I do not think we need many Fixes: tag.

Reviewed-by: Eric Dumazet <edumazet@google.com>

If we really want to be precise, the issue also came when GRO got
support for GRO packets ;)

commit 5eddb24901ee    gro: add support of (hw)gro packets to gro stack

This commit really implied that both gso_size and gso_segs had to be
set by drivers RX paths.

It seems drivers/net/ethernet/google/gve/gve_rx_dqo.c has a similar issue.

gve_rx_complete_rsc() sets gso_size but not gso_segs

shinfo->gso_size =3D le16_to_cpu(desc->rsc_seg_len);

