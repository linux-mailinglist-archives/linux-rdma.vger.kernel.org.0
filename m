Return-Path: <linux-rdma+bounces-13765-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B9FBBBB4883
	for <lists+linux-rdma@lfdr.de>; Thu, 02 Oct 2025 18:27:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BDB857B6CB3
	for <lists+linux-rdma@lfdr.de>; Thu,  2 Oct 2025 16:25:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D630259CB6;
	Thu,  2 Oct 2025 16:26:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q3KwLwoY"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 660E817A586
	for <linux-rdma@vger.kernel.org>; Thu,  2 Oct 2025 16:26:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759422398; cv=none; b=MEFvdgGV27J9qz+PtPDjSfzeMEy5LhE+muDkeK0rR8eC8KdNmzZoOAiT29S2n21XkFiL4V8MxtwfEW5fnJnvpYoZXRZ7rCaFxRahwqS4/WDSxmrlmJaYwZFftcfaTWKofnfp7+O+3IBrhNVPQlYf/pfHE96NSlgaXDSZZJE5ZaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759422398; c=relaxed/simple;
	bh=RDxFvlg72f/lSXbDrZ3EoR5QbnP7TNw4xC6FjhYPZbs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JVKa92lBnrW7J9epjhdLPbUSePz5H8tsEiB6RpO62tQKw6nT/1tx3W/QOzBN2xT9vmeRSTXYqvto4sMWbs0f0AOAR3ohQEmAdV/39TOwHJ+WvQ6V/XAB8g2q4hDHNxpQX0Tk0gKsINAehLGhCQhikOEXnP+GIpwmUBnOFqENTfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q3KwLwoY; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-3322e63602eso1855273a91.0
        for <linux-rdma@vger.kernel.org>; Thu, 02 Oct 2025 09:26:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759422397; x=1760027197; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JEl7XEhzoZTfrEG35GV29SFkrgNgycUaXOG7zaQQy0M=;
        b=Q3KwLwoY+gLJjwYP0bvMzKE5VlRX5L7vKxnf7F+JF6n0BlztIw30ZtaLV2oTSg3Hpa
         mD8b+7or7ef0J49xSVa0bS8Ik/1Kd+ceiyJc1MtS4gjCDc5n2reSeqznv6iT79NnGxoP
         t92dGwAxK0g7n0ke7/zkUcEp3Qpfbyz3PZ0SeNLt+ivbR4S9FbOfodTYRrzcnlSzgQhh
         yiEAgA99EkQfxAhBcCDHt8GG5FbxkbJBtE1lH10b1odflVvwUoWowi8ns2s2SY1rLtui
         GSFoMR/cFRCi6az1myfMxMZczs9Vgdo+epBVEMZrQn1NkhSTrqUzPfZhXOmxHYoroCuR
         hLzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759422397; x=1760027197;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JEl7XEhzoZTfrEG35GV29SFkrgNgycUaXOG7zaQQy0M=;
        b=EhEpf8iN7BAJA96sOlJuCEVdIZMd+0W06VboS8TGhdu23tWGtMaxMjp4j+pNDFmNGO
         Pbba/tnK2K9Opw8R8dHZ8WL7QdTwMg6imVNGlncAtkrFJEEKWDQLUEFT2Bw4twv7tyum
         jfiX5FkSUohZSWV6B1x92Bdo704rhMfJk9vkZ0uiYH2/lARxNA97IWRZZBlY3q0wUusJ
         UqD81jIMCw16el8tItCO7liqEm7Ng4cy0m07hWWEuHicqKNkzBtKnleff4/GSrT4gyzG
         NNuUEPdAZ4ruK9b1uLYxXzkPXLn8wu/AnRPEjMzvG0lWxZAzuhXzmyAHzP7PE2JJPNJK
         A3vA==
X-Forwarded-Encrypted: i=1; AJvYcCWEfvKuatPElKxtH6/XifTxK/ySkVK9JzBrDLY/lEUjHf6cvT+yXtSP57wpxDcPp0txnLZKxYS0vhn2@vger.kernel.org
X-Gm-Message-State: AOJu0YynZ9HZblcSiVXmOXlKSQ/jBK2D6jWucRH0S9cPCdVvExQ4kgjK
	+mNtx0xC4j7vqGyXIoNyY12XlqSo9RfufXdYTsELM+sxGN1zk5WxFLZPCEfuh5IsvNejLELR7HK
	ZrDXRT/KJJuYZpVsodeobQGOMj8ydi2I=
X-Gm-Gg: ASbGncvoXWq1k6UxaVTSwLmaOOMMHVttjv7zq2V/m8lFqDbc0/XqzjI7b4Ovms+JhGh
	E670heM0Ndf1Nu0SOWEbEvuLHwYVSQ3E2DgDVnyXnGKmbG3Wow3tYwnRZqfttRuOJFjYX6Q2WqF
	b7/eV3QbserOK1+oGeArZV+8b0gM0V8GWaFKBTDsw7D4YiO6Odrc19IeCrRgtJKFm5/oe7DIUsz
	DnPif3V0pU+mXevJXz3OlzSh+G13yY=
X-Google-Smtp-Source: AGHT+IGHD2+2E8K4vJLrKLdazZjBTXnk9FPpgrQ9I3hiACihPhpo2kv/hmAK0UembqrM3UH/3wW323YnXfoDzzpoJwY=
X-Received: by 2002:a17:90b:4f86:b0:327:e018:204a with SMTP id
 98e67ed59e1d1-339c267cdafmr12153a91.0.1759422396742; Thu, 02 Oct 2025
 09:26:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250820133209.389065-1-mbloch@nvidia.com> <20250820133209.389065-4-mbloch@nvidia.com>
In-Reply-To: <20250820133209.389065-4-mbloch@nvidia.com>
From: ChaosEsque Team <chaosesqueteam@gmail.com>
Date: Thu, 2 Oct 2025 12:31:34 -0400
X-Gm-Features: AS18NWBMrAtI4XnmoNczD-HkkKE2yx9dtJFB--xC8gtNJ5qupFEyGmU7-QLGrbA
Message-ID: <CALC8CXdAXnYSQqskwc=0V9oRiRh92L32zyKDBLPPAUX65Sawsw@mail.gmail.com>
Subject: Re: [PATCH V2 net 3/8] net/mlx5e: Preserve tc-bw during parent changes
To: Mark Bloch <mbloch@nvidia.com>
Cc: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, przemyslaw.kitszel@intel.com, 
	Tariq Toukan <tariqt@nvidia.com>, Leon Romanovsky <leon@kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, 
	netdev@vger.kernel.org, linux-rdma@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Gal Pressman <gal@nvidia.com>, 
	Carolina Jubran <cjubran@nvidia.com>, Cosmin Ratiu <cratiu@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Mark Bloch.
Finally a normal name on this list.

(the rest is "Massive Dong Wang", and similar)

On Wed, Aug 20, 2025 at 10:03=E2=80=AFAM Mark Bloch <mbloch@nvidia.com> wro=
te:
>
> From: Carolina Jubran <cjubran@nvidia.com>
>
> When changing parent of a node/leaf with tc-bw configured, the code
> saves and restores tc-bw values. However, it was reading the converted
> hardware bw_share values (where 0 becomes 1) instead of the original
> user values, causing incorrect tc-bw calculations after parent change.
>
> Store original tc-bw values in the node structure and use them directly
> for save/restore operations.
>
> Fixes: cf7e73770d1b ("net/mlx5: Manage TC arbiter nodes and implement ful=
l support for tc-bw")
> Signed-off-by: Carolina Jubran <cjubran@nvidia.com>
> Reviewed-by: Cosmin Ratiu <cratiu@nvidia.com>
> Signed-off-by: Mark Bloch <mbloch@nvidia.com>
> ---
>  .../net/ethernet/mellanox/mlx5/core/esw/qos.c | 24 +++++++++----------
>  1 file changed, 12 insertions(+), 12 deletions(-)
>
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/esw/qos.c b/drivers/=
net/ethernet/mellanox/mlx5/core/esw/qos.c
> index cd58d3934596..4ed5968f1638 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/esw/qos.c
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/esw/qos.c
> @@ -102,6 +102,8 @@ struct mlx5_esw_sched_node {
>         u8 level;
>         /* Valid only when this node represents a traffic class. */
>         u8 tc;
> +       /* Valid only for a TC arbiter node or vport TC arbiter. */
> +       u32 tc_bw[DEVLINK_RATE_TCS_MAX];
>  };
>
>  static void esw_qos_node_attach_to_parent(struct mlx5_esw_sched_node *no=
de)
> @@ -609,10 +611,7 @@ static void
>  esw_qos_tc_arbiter_get_bw_shares(struct mlx5_esw_sched_node *tc_arbiter_=
node,
>                                  u32 *tc_bw)
>  {
> -       struct mlx5_esw_sched_node *vports_tc_node;
> -
> -       list_for_each_entry(vports_tc_node, &tc_arbiter_node->children, e=
ntry)
> -               tc_bw[vports_tc_node->tc] =3D vports_tc_node->bw_share;
> +       memcpy(tc_bw, tc_arbiter_node->tc_bw, sizeof(tc_arbiter_node->tc_=
bw));
>  }
>
>  static void
> @@ -629,6 +628,7 @@ esw_qos_set_tc_arbiter_bw_shares(struct mlx5_esw_sche=
d_node *tc_arbiter_node,
>                 u8 tc =3D vports_tc_node->tc;
>                 u32 bw_share;
>
> +               tc_arbiter_node->tc_bw[tc] =3D tc_bw[tc];
>                 bw_share =3D tc_bw[tc] * fw_max_bw_share;
>                 bw_share =3D esw_qos_calc_bw_share(bw_share, divider,
>                                                  fw_max_bw_share);
> @@ -1060,6 +1060,7 @@ static void esw_qos_vport_disable(struct mlx5_vport=
 *vport, struct netlink_ext_a
>                 esw_qos_vport_tc_disable(vport, extack);
>
>         vport_node->bw_share =3D 0;
> +       memset(vport_node->tc_bw, 0, sizeof(vport_node->tc_bw));
>         list_del_init(&vport_node->entry);
>         esw_qos_normalize_min_rate(vport_node->esw, vport_node->parent, e=
xtack);
>
> @@ -1231,8 +1232,9 @@ static int esw_qos_vport_update(struct mlx5_vport *=
vport,
>                                 struct mlx5_esw_sched_node *parent,
>                                 struct netlink_ext_ack *extack)
>  {
> -       struct mlx5_esw_sched_node *curr_parent =3D vport->qos.sched_node=
->parent;
> -       enum sched_node_type curr_type =3D vport->qos.sched_node->type;
> +       struct mlx5_esw_sched_node *vport_node =3D vport->qos.sched_node;
> +       struct mlx5_esw_sched_node *curr_parent =3D vport_node->parent;
> +       enum sched_node_type curr_type =3D vport_node->type;
>         u32 curr_tc_bw[DEVLINK_RATE_TCS_MAX] =3D {0};
>         int err;
>
> @@ -1244,10 +1246,8 @@ static int esw_qos_vport_update(struct mlx5_vport =
*vport,
>         if (err)
>                 return err;
>
> -       if (curr_type =3D=3D SCHED_NODE_TYPE_TC_ARBITER_TSAR && curr_type=
 =3D=3D type) {
> -               esw_qos_tc_arbiter_get_bw_shares(vport->qos.sched_node,
> -                                                curr_tc_bw);
> -       }
> +       if (curr_type =3D=3D SCHED_NODE_TYPE_TC_ARBITER_TSAR && curr_type=
 =3D=3D type)
> +               esw_qos_tc_arbiter_get_bw_shares(vport_node, curr_tc_bw);
>
>         esw_qos_vport_disable(vport, extack);
>
> @@ -1258,8 +1258,8 @@ static int esw_qos_vport_update(struct mlx5_vport *=
vport,
>         }
>
>         if (curr_type =3D=3D SCHED_NODE_TYPE_TC_ARBITER_TSAR && curr_type=
 =3D=3D type) {
> -               esw_qos_set_tc_arbiter_bw_shares(vport->qos.sched_node,
> -                                                curr_tc_bw, extack);
> +               esw_qos_set_tc_arbiter_bw_shares(vport_node, curr_tc_bw,
> +                                                extack);
>         }
>
>         return err;
> --
> 2.34.1
>
>

