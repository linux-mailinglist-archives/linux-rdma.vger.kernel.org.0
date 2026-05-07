Return-Path: <linux-rdma+bounces-20160-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0IUGOhOa/Gk6RwAAu9opvQ
	(envelope-from <linux-rdma+bounces-20160-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 07 May 2026 15:56:35 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 411E34E9B13
	for <lists+linux-rdma@lfdr.de>; Thu, 07 May 2026 15:56:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 258203008206
	for <lists+linux-rdma@lfdr.de>; Thu,  7 May 2026 13:53:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E7903F65F7;
	Thu,  7 May 2026 13:53:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hVYCFLir"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 708E03321A3
	for <linux-rdma@vger.kernel.org>; Thu,  7 May 2026 13:53:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778162017; cv=pass; b=Y8NLDF3RKsMa6BnRjvIknQGBA06hifMpe4DG9V87OouS8ARgEMJhyqKZK9JQs8eij3PeiJkq9I0+M1RRhA8YM8Fe+5FRUKnGFrcHI4csAebzJkeOwnbKLWsZ50VZ1lAhwOOIPkYuy4ZUpvTGdnwKtcYANt1Ju3BDE1g7Bm9Jpgs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778162017; c=relaxed/simple;
	bh=QUOVF58orNIzbap3jmAonthzrZhQjZnQOV9FX2z8+Ew=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gjZlK+QNP0TfGvFhKvmIFXxauHYQJ09a6YWCTakwjgPyoCPistfJz794T6a3DNl28TBVKCD5zNVXF/ovgjUyF1KcBHLxvjLyodsAj83ofJR6TdgJ65jw6oYKpE13VDZoaqItA2PLF52ErwPrz0YLNN+5yztJDVRjFfui5/3DbBc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hVYCFLir; arc=pass smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-79a535e7c00so9952427b3.3
        for <linux-rdma@vger.kernel.org>; Thu, 07 May 2026 06:53:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778162015; cv=none;
        d=google.com; s=arc-20240605;
        b=DklGz8CjUE7exWO1ExGYyv5XzIVB8PMlX8Xfw/P5yx09eroAqJv/vJj877bgqLJeZp
         j+d8NbNm9T2QLcM43gI9Mcu1GEDS9iTBRJpwlcXVLRgcvm4iGJlauxctmzAFzwimYgx0
         T7emvHBFCJOilTmdAlzX62i781JomBRpxPi+eOBimQ4NAiZelPxYK6SLv2/TBNLk4kB0
         U6d3GoY1C6FC+atuMO7bNAkcbrhWZTD/IllrT9E0/gqfP1IDTlryxT7MtLbcXURS56av
         1si7ZVJp9RB5ixQi9EMYMQGtdvim9VgCZvFy9PRW2dUGzTzQgn+ECrhKFb/gOchVIJWg
         3ybQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=2UqAGYVwxx8g720PgR4EoCQGsE47vpJLPP3a4vKzw1s=;
        fh=PuPRYSJDoFSeC9FYnGyVu7lDufA9Ap+nwx+mcWG8Wtg=;
        b=GPHQTrDU4PP/UkoQ/ezqFe2AUU0q96yCvxyYNIsOlnMFeudYLpBdlobYOmrIw6NBIg
         jn6q8tYqLnxTNpGvdRlX388fnte/C1b19iDscePyfGnKm66ZGOGNKuhR52kElcUXHnKH
         bY5Rw37KnutoBEYEjv5lPECgt/0CEioMc/xMbZ5q3p6bN+/ooMNjNvbfmTZJDdaphpSn
         tlBC2xCdEKxqLbXMtT/aVLWWvhDO19hgAUX/TF6PbWpUnvLjZ5sVHvwntmfh3RceCjvH
         vkCSCLNQZEkFiKQU+hMmnmeKlKwl2vDO3q6FPDGNTK7rtkKp7AmFE6SlvQbJ1o9Ec8rX
         scKg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778162015; x=1778766815; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2UqAGYVwxx8g720PgR4EoCQGsE47vpJLPP3a4vKzw1s=;
        b=hVYCFLirrJWCD5Y4RSvGek4T5FbDwBtYKD+y/633CN/uPI8rSCsDqy1faBsQ1JjRpV
         QXLmX7YZHie1caW4f9Q9wBtcdKO9B05KJb3g7jgxkhjf5JWv460U60rPOmElaHtq5l4C
         lhhzCgQIA8aratgYahmBUTHmZhBjzbvj7/dr0GATRGTRgHaU+h0DBOU0vgyb/Eov38mr
         YIkar3lw3pdPHTM7r9ubJc6B0JQdzIGTRCeh7FFltGCnRHniQkjBj8HgLsS+vPIoHIcA
         Rgd2OGljNlkjuq8M2oWVtBx1BHBtvceTwmmQle3WgZ83A/nhM/JWQUptrsvWROjjLFeb
         in4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778162015; x=1778766815;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=2UqAGYVwxx8g720PgR4EoCQGsE47vpJLPP3a4vKzw1s=;
        b=XARjprMVjY+H+vGIFfFvi8J6PHvhxrx6RIzZgVCT+bq5FkTZnJquOIcJ8b625eRFhc
         zq6uibY0BxBmwSgk7WE7u52Emj52xn1FdO336N91ePEdE844TRq8U5d+SeUqqD0Acpaw
         0tzfFc68iQjIRV3qRtBHrogPcX6BUupa2bI6D1KQj4c1M4Cn9Sdr7zfDh7ZtDKcgDeov
         IbcN+dD1ChqtNtiw7CaGfSyV4CzPVohlaGRJtLmz2VIIe5ZDRIdsTBF0Wja+zHlYTc3k
         ie9kJVFnV/QA3Zo91+NbwYx+iV7KywUQ3Zeud2PFOH7nXhgbMlEFngs0qG1Lr5gpYeC9
         cxVQ==
X-Forwarded-Encrypted: i=1; AFNElJ992Qfg1ij6OcQcrJ/k4HF8KV6sroOnwRzGCGsnfXU1AYSOqEKYDuATHh1FkMRh758YS7FuNSNCUPg0@vger.kernel.org
X-Gm-Message-State: AOJu0YxfOPGnKbCk4lbGeMU729T1jB6zAP1ercuHrCcosAXsR2tRmWA+
	9j0kPayKtGQRLqU7SQ9rSImM7XCRYv+ork/8hlXOzYvfmn7kqmqI6/He0V1OkmpwGUG+whzDkvS
	sLiEeHZgoTka3xr/mANCQlXHZaqRKMhE=
X-Gm-Gg: Acq92OHn5ikFbS1wjoPRMjUKuDY4MVyZTgeB2k6zBH/3IH8hMrEzt6ju1O3NPqs/Dwo
	bLA1SV8qGpwsL4RT0Y96Ly/5SCOjYmGb7w+NIKQ48m08oGFlPogZUjamdRiG9wL0CK+M+Y2/s+A
	azPIRktDqtbd/DskO8JkTRsAEFGS1cGL7+ekUQwXALQPF+7y5Jq3bUN5GB8JkZu8QrqKR1MzNy1
	/F967cNb7k6Kz8/iPMez5PLCVlgLpbe46INlqkfl7jyE95wvCkNkhh1u8l6eM7mZOWhnLji7lUp
	w0c5PxHyPSwi2fmeP0o=
X-Received: by 2002:a05:690c:6b01:b0:7bd:d4f4:261e with SMTP id
 00721157ae682-7bdf5e65d97mr83478287b3.31.1778162014408; Thu, 07 May 2026
 06:53:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260507095330.318892-1-tariqt@nvidia.com> <20260507095330.318892-3-tariqt@nvidia.com>
In-Reply-To: <20260507095330.318892-3-tariqt@nvidia.com>
From: Amery Hung <ameryhung@gmail.com>
Date: Thu, 7 May 2026 15:53:23 +0200
X-Gm-Features: AVHnY4Lb8J0kuDFjKRP6NISwMX2khi2ZT2JxvUh-epEwthNyT24xcZ-TVmlu8Os
Message-ID: <CAMB2axOFQN2f=veYgeJs+4tbZmb9PuNHk03TH_bmE8UL_REd7w@mail.gmail.com>
Subject: Re: [PATCH net-next V6 2/3] net/mlx5e: Avoid copying payload to the
 skb's linear part
To: Tariq Toukan <tariqt@nvidia.com>
Cc: Christoph Paasch <cpaasch@openai.com>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Saeed Mahameed <saeedm@nvidia.com>, Mark Bloch <mbloch@nvidia.com>, 
	Leon Romanovsky <leon@kernel.org>, netdev@vger.kernel.org, linux-rdma@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Gal Pressman <gal@nvidia.com>, 
	Dragos Tatulea <dtatulea@nvidia.com>, Daniel Borkmann <daniel@iogearbox.net>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, 
	Stanislav Fomichev <sdf@fomichev.me>, Alexei Starovoitov <ast@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 411E34E9B13
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20160-lists,linux-rdma=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[20];
	FREEMAIL_CC(0.00)[openai.com,google.com,kernel.org,redhat.com,lunn.ch,davemloft.net,nvidia.com,vger.kernel.org,iogearbox.net,gmail.com,fomichev.me];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ameryhung@gmail.com,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,openai.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

On Thu, May 7, 2026 at 10:54=E2=80=AFAM Tariq Toukan <tariqt@nvidia.com> wr=
ote:
>
> From: Christoph Paasch <cpaasch@openai.com>
>
> mlx5e_skb_from_cqe_mpwrq_nonlinear() copies MLX5E_RX_MAX_HEAD (256)
> bytes from the page-pool to the skb's linear part. Those 256 bytes
> include part of the payload.
>
> When attempting to do GRO in skb_gro_receive, if headlen > data_offset
> (and skb->head_frag is not set), we end up aggregating packets in the
> frag_list.
>
> This is of course not good when we are CPU-limited. Also causes a worse
> skb->len/truesize ratio,...
>
> So, let's avoid copying parts of the payload to the linear part. We use
> eth_get_headlen() to parse the headers and compute the length of the
> protocol headers, which will be used to copy the relevant bits of the
> skb's linear part.
>
> We still allocate MLX5E_RX_MAX_HEAD for the skb so that if the networking
> stack needs to call pskb_may_pull() later on, we don't need to reallocate
> memory.
>
> This gives a nice throughput increase (ARM Neoverse-V2 with CX-7 NIC and
> LRO enabled):
>
> BEFORE:
> =3D=3D=3D=3D=3D=3D=3D
> (netserver pinned to core receiving interrupts)
> $ netperf -H 10.221.81.118 -T 80,9 -P 0 -l 60 -- -m 256K -M 256K
>  87380  16384 262144    60.01    32547.82
>
> (netserver pinned to adjacent core receiving interrupts)
> $ netperf -H 10.221.81.118 -T 80,10 -P 0 -l 60 -- -m 256K -M 256K
>  87380  16384 262144    60.00    52531.67
>
> AFTER:
> =3D=3D=3D=3D=3D=3D
> (netserver pinned to core receiving interrupts)
> $ netperf -H 10.221.81.118 -T 80,9 -P 0 -l 60 -- -m 256K -M 256K
>  87380  16384 262144    60.00    52896.06
>
> (netserver pinned to adjacent core receiving interrupts)
>  $ netperf -H 10.221.81.118 -T 80,10 -P 0 -l 60 -- -m 256K -M 256K
>  87380  16384 262144    60.00    85094.90
>
> Additional tests across a larger range of parameters w/ and w/o LRO, w/
> and w/o IPv6-encapsulation, different MTUs (1500, 4096, 9000), different
> TCP read/write-sizes as well as UDP benchmarks, all have shown equal or
> better performance with this patch.
>
> Reviewed-by: Eric Dumazet <edumazet@google.com>
> Reviewed-by: Saeed Mahameed <saeedm@nvidia.com>
> Signed-off-by: Christoph Paasch <cpaasch@openai.com>
> Signed-off-by: Dragos Tatulea <dtatulea@nvidia.com>
> Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
> ---
>  drivers/net/ethernet/mellanox/mlx5/core/en_rx.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c b/drivers/ne=
t/ethernet/mellanox/mlx5/core/en_rx.c
> index 75ccf40a7f17..301b33419207 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
> @@ -1976,6 +1976,8 @@ mlx5e_skb_from_cqe_mpwrq_nonlinear(struct mlx5e_rq =
*rq, struct mlx5e_mpw_info *w
>                                         ALIGN(headlen, sizeof(long)),
>                                         rq->buff.map_dir);
>
> +               headlen =3D eth_get_headlen(rq->netdev, head_addr, headle=
n);
> +
>                 frag_offset +=3D headlen;
>                 byte_cnt -=3D headlen;
>                 linear_hr =3D skb_headroom(skb);
> @@ -2012,9 +2014,13 @@ mlx5e_skb_from_cqe_mpwrq_nonlinear(struct mlx5e_rq=
 *rq, struct mlx5e_mpw_info *w
>
>         if (prog) {
>                 u8 nr_frags_free, old_nr_frags =3D sinfo->nr_frags;
> +               skb_frag_t *frag =3D &sinfo->frags[0];
>                 u8 new_nr_frags;
>                 u32 len;
>
> +               headlen =3D eth_get_headlen(rq->netdev, skb_frag_address(=
frag),
> +                                         skb_frag_size(frag));
> +
>                 if (mlx5e_xdp_handle(rq, prog, mxbuf)) {

Hello,

Am I understanding correctly that the better performance comes with
the assumption that the XDP does not change headers?

headlen is determined before the XDP program runs. If it push/pop
headers, there could be headers in frags or data in the linear region
after __pskb_pull_tail().

>                         if (__test_and_clear_bit(MLX5E_RQ_FLAG_XDP_XMIT, =
rq->flags)) {
>                                 struct mlx5e_frag_page *pfp;
> @@ -2060,8 +2066,7 @@ mlx5e_skb_from_cqe_mpwrq_nonlinear(struct mlx5e_rq =
*rq, struct mlx5e_mpw_info *w
>                                 pagep->frags++;
>                         while (++pagep < frag_page);
>
> -                       headlen =3D min_t(u16, MLX5E_RX_MAX_HEAD - len,
> -                                       skb->data_len);
> +                       headlen =3D min_t(u16, headlen - len, skb->data_l=
en);

headlen - len can underflow but will be capped by skb->data_len, so
this should be okay, right?

>                         __pskb_pull_tail(skb, headlen);
>                 }
>         } else {
> --
> 2.44.0
>

