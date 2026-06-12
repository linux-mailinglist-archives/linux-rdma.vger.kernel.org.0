Return-Path: <linux-rdma+bounces-22177-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id ufABHL3+K2rUJAQAu9opvQ
	(envelope-from <linux-rdma+bounces-22177-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Fri, 12 Jun 2026 14:42:37 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B9E36796C5
	for <lists+linux-rdma@lfdr.de>; Fri, 12 Jun 2026 14:42:36 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=ionos.com header.s=google header.b=GZwGc796;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-22177-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="linux-rdma+bounces-22177-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=ionos.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 12D75300D564
	for <lists+linux-rdma@lfdr.de>; Fri, 12 Jun 2026 12:40:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4F533DD86A;
	Fri, 12 Jun 2026 12:39:38 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06D0C3BB107
	for <linux-rdma@vger.kernel.org>; Fri, 12 Jun 2026 12:39:35 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781267978; cv=pass; b=fB3kRsNTJH1Fm01cGe144pNXL+0cQ1G6qCKhgrWpt6JTlFV3kAY+YIrh8eU/1qOMYu0V1buuUHmASSxTlzwLihOJb9JLKl+8wkR7kB4wAA+ZMT8nMjDPTKKoXue2K3Vwd9tAWd8/BAXCTUZgBLGf7Ms8PJOT60TesmZWWZXQ/+g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781267978; c=relaxed/simple;
	bh=r2fdDj0/BkEr+P6BAfJ9Q5rQxtdCtewNTe5fNz1w9g4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rtQV8uPNX9lvTLDIMXWdU4yEA6jmzpzYCJaSWNAY/aeeS1Z1ooBPFYp2klKBpSMEg77MowhEn+xqoYXM2bgTrIgMrl6kXV96A+JYhkIZm/YdBPmK6CRQ05CG31F+RXRt/UBi6ocvQdL88m5hsDLCGb5RpAvmswBQUtk9RuM62FE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=GZwGc796; arc=pass smtp.client-ip=209.85.167.47
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-5aa5be9ab1aso884900e87.1
        for <linux-rdma@vger.kernel.org>; Fri, 12 Jun 2026 05:39:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781267974; cv=none;
        d=google.com; s=arc-20240605;
        b=P02nSRMKLc6GNa68DTU2VYw4Cpfp9I9C0PkF6mJQoZGpchIHzG8qWYGKyqBp9N/Gwi
         JZp16j4QvO7fia3vEuc7kb/pqyj0wU6o3yX6u5e2HHClFbb9831N8XitMVsp4z2uKzRt
         a3Tq4aRw/hiJ7KurGAr0GHOYSEKkAOyjQCL4eYEwJfl94VL4rZAnsTKpaBWH8qDEpllu
         CYZGn/+ANPEKskdTlEXn8zdopAEcB4o7m3MUECEuAJIIl5RWukVbFCJs6YKj3EVsZfER
         CNdy4v+vBO6W/8wNGio6/eE4eRW1aHPAeCSBruzPaxnQbT4lnLThuLHGqqptnZHUnlW4
         ex8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=61AMVtU6oLpUm/BQhOmCZGzPwVVVsT8h8unaKjzD1K8=;
        fh=H0F7RoYZ9uEoxNSY3T3CZBDVD2ULgvPDP6mJGilCgOI=;
        b=G2N55sMm9tPpUuwCb7bZnlvsqIgwHYpTvNNczha0twaAyQbFOZ/NxMj/iLoS3a3jIP
         8ErmGwv/nGpdKigIHPe8pTxfifwp4xCdpblKfvDTj4Qkp3TOfl3K9qaou9ElN8yJAEZ3
         X7WSfFvD+urM+awuetFvXvdlijk6W7y457cvXWKBrQ1MVZKiN0Zc0bHM/d8JHWMG4kso
         eRNSjXG1bVcbL6jOCJQLOX7/NE5JzAK9W/xcjrIwfhaPFsoWfb0XuojdGEh/PcKGvndx
         HVtc6V9LJ3oREJEaVJ9aG0hPHViWuLfEhbUZW9edLAAJ0VYcON/vUFdX0Xq8Yr1MXnVY
         fWqA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1781267974; x=1781872774; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=61AMVtU6oLpUm/BQhOmCZGzPwVVVsT8h8unaKjzD1K8=;
        b=GZwGc796kBTTSrHCxNwRE8h17LBGwYvfZz5IR6p8c/J4XZnjOsJY8IiV0WDVke0WbU
         yHcEmzYVheUJBWlvzhJR20RAUXmFkNiBwm8h5zCp1El+HjhUYPnzRZUkWsxJ3HfbJZ3g
         5hb7o8byTLgMHT4umhcn1IlkEJb7sQZ68XmP4vd1fTTK16EcG3OpoH7oPt40S0NLzJaf
         NZPvIez9FNBZG+uvWHDqU2Knz/dPOQHizWqG6L962fbFA+NC3bQn42vP23pZnv4GJuHZ
         /s0aRwmRS8Y37EHmmWMZVOglUXV6+dQc5PE0moddTAMDuOLgpQOumNDcQClv3vViTjNj
         /peg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781267974; x=1781872774;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=61AMVtU6oLpUm/BQhOmCZGzPwVVVsT8h8unaKjzD1K8=;
        b=gos7ebOfx2dW2Q9RQh4jIKt7SFVEBqNuR1OX8TMJfjwmsV8BChXKfNXxYnMFnToohG
         +wXRZOWJwfseNU0o+zDB5S4fbId8dwYCeZLIHXa4xAMDl6WOZ9Iy0QjJ4PFk3YXy/YDy
         PvSTVrS4ZxlQriL/hTqiAH55xKyEtLMC4xQS6PhbwD35wEXNoupRnEGwEASPThHt/iP9
         8n9/VVyBNeKy9uUvk5L09SW92njUMsB4jIjGnoZSTcj8E65kG6XiKRIY1y23IFQgUA95
         DVmM6uC1FIrfkeHgL2JAw/tr9yXuR4CLM/PdVlOLtPu6BSUGr9c4Ov/8GupCPCb5xuti
         HRYw==
X-Forwarded-Encrypted: i=1; AFNElJ9gCrcNgR/v4Ku1ppM1gMd4wP7CuKZB/Q8pi+96r7sYmr0jEtgPrGKYGYmqugsXc5krvDun+ZpQ2TKd@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2DOoltAF2bpg71Wez4jcgQpc6vDMj2ACQpyoGnpXC0XYaKstc
	euYnpvBsYaWIoMjzCgAyHrK0Gfo/ke0RvOn6+QM8WVlPjNpCSZAYmgbr4U55rLHUCg+3mY48xMp
	F2uss7FGi9BqhUpvtSQBIXJoZz30Iqy6VsMFM1yAojw==
X-Gm-Gg: Acq92OFSUw8S0XscVNfV6JSUCI0E1zMOtHEKgLgJPWGv5vYO0XkyqwviMy4kEnFKc99
	iPkZyytPcFSTaao00XyWzuPLJNK4fxe+H491chq+oTC/HANP+/IOLvMRY/T/U/vzxeb9NkqZ+Zk
	YokLrqeCQdKTGLJVTK+7RORYcbnbatOPrKZrLQk7+Oz5zVU0gvb5uCMFBfXP/7L/VXj3Z9SDo/i
	l+l0BYsfp6jjVlITSG/xfsQ6vMq6Pc+Z8st83QEGG+wafd9x22TO4U0IZM4JlKL0S1NaKuA9qP4
	1brsldJjUn2w/eCzYIi9h5erHNml+OZk3eNhdMqoGxMPl3Zkvhr4K9XaY4ywNkQW9YoL
X-Received: by 2002:ac2:5632:0:b0:5aa:6c57:32c6 with SMTP id
 2adb3069b0e04-5ad2db1e479mr635970e87.17.1781267973946; Fri, 12 Jun 2026
 05:39:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260612-master-v1-1-70cde5c6fdc9@gmail.com>
In-Reply-To: <20260612-master-v1-1-70cde5c6fdc9@gmail.com>
From: Haris Iqbal <haris.iqbal@ionos.com>
Date: Fri, 12 Jun 2026 14:39:22 +0200
X-Gm-Features: AVVi8Cf1ZgRl8fAik84-gu83jr0ddYKJixeZyFQ48Kd-1UN8I2bJVg8YEnHSUZI
Message-ID: <CAJpMwyiOcvz1XoVpdEZ6h1zdizkKBmsfnrnnb3LGziNv51q1KA@mail.gmail.com>
Subject: Re: [PATCH] RDMA/rtrs-srv: Bound RDMA-Write length to chunk size in rdma_write_sg
To: Zhenhao Wan <whi4ed0g@gmail.com>
Cc: Jack Wang <jinpu.wang@ionos.com>, Jason Gunthorpe <jgg@ziepe.ca>, 
	Leon Romanovsky <leon@kernel.org>, Danil Kipnis <danil.kipnis@cloud.ionos.com>, 
	Jack Wang <jinpu.wang@cloud.ionos.com>, linux-rdma@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Yuhao Jiang <danisjiang@gmail.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-9.16 / 15.00];
	WHITELIST_DMARC(-7.00)[ionos.com:D:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[ionos.com,reject];
	R_DKIM_ALLOW(-0.20)[ionos.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-22177-lists,linux-rdma=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:whi4ed0g@gmail.com,m:jinpu.wang@ionos.com,m:jgg@ziepe.ca,m:leon@kernel.org,m:danil.kipnis@cloud.ionos.com,m:jinpu.wang@cloud.ionos.com,m:linux-rdma@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:danisjiang@gmail.com,m:stable@vger.kernel.org,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[ionos.com,ziepe.ca,kernel.org,cloud.ionos.com,vger.kernel.org,gmail.com];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[haris.iqbal@ionos.com,linux-rdma@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[haris.iqbal@ionos.com,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[ionos.com:+];
	RCPT_COUNT_SEVEN(0.00)[10];
	TAGGED_RCPT(0.00)[linux-rdma];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,vger.kernel.org:from_smtp,ionos.com:dkim,ionos.com:email,ionos.com:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 6B9E36796C5

On Thu, Jun 11, 2026 at 7:18=E2=80=AFPM Zhenhao Wan <whi4ed0g@gmail.com> wr=
ote:
>
> When the server answers an RTRS READ, rdma_write_sg() builds the source
> scatter/gather entry for the IB_WR_RDMA_WRITE that returns data to the
> peer. Its length is taken directly from the wire descriptor:
>
>   plist->length =3D le32_to_cpu(id->rd_msg->desc[0].len);
>
> rd_msg points into the chunk buffer that the remote peer filled via
> RDMA-WRITE-WITH-IMM (rtrs_srv_rdma_done() -> process_io_req() ->
> process_read()), so desc[0].len is attacker-controlled and, before this
> change, was only rejected when zero. The source address is the fixed
> chunk start (dma_addr[msg_id]) and the source lkey is the PD-wide
> local_dma_lkey, which is not tied to the chunk's MR mapping, so the verbs
> layer does not constrain the transfer length to max_chunk_size. msg_id
> and off are bounded against queue_depth and max_chunk_size in
> rtrs_srv_rdma_done(), but desc[0].len is a separate field that was not
> checked against the chunk size.
>
> A peer that advertises desc[0].len larger than max_chunk_size can make
> the posted RDMA write read past the chunk's mapped region. The resulting
> behaviour depends on the IOMMU configuration: with no IOMMU or in
> passthrough mode the read may extend into memory adjacent to the chunk
> and be returned to the peer, which can disclose host memory; with a
> translating IOMMU the out-of-range access is expected to fault and abort
> the connection. In either case the transfer exceeds what the protocol
> permits and is driven by a remote peer.
>
> Reject a descriptor length above max_chunk_size, mirroring the existing
> off >=3D max_chunk_size bound in rtrs_srv_rdma_done(). Legitimate clients
> do not exceed it: the client sets desc[0].len to its MR length, which is
> capped at the negotiated max_io_size (max_chunk_size - MAX_HDR_SIZE).
>
> Fixes: 9cb837480424 ("RDMA/rtrs: server: main functionality")
> Reported-by: Yuhao Jiang <danisjiang@gmail.com>
> Cc: stable@vger.kernel.org
> Signed-off-by: Zhenhao Wan <whi4ed0g@gmail.com>

Looks good.
Reviewed and tested.

Reviewed-by: Md Haris Iqbal <haris.iqbal@ionos.com>

> ---
>  drivers/infiniband/ulp/rtrs/rtrs-srv.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/infiniband/ulp/rtrs/rtrs-srv.c b/drivers/infiniband/=
ulp/rtrs/rtrs-srv.c
> index 6482ad859bd1..f81e122a3ccb 100644
> --- a/drivers/infiniband/ulp/rtrs/rtrs-srv.c
> +++ b/drivers/infiniband/ulp/rtrs/rtrs-srv.c
> @@ -225,8 +225,9 @@ static int rdma_write_sg(struct rtrs_srv_op *id)
>         /* WR will fail with length error
>          * if this is 0
>          */
> -       if (plist->length =3D=3D 0) {
> -               rtrs_err(s, "Invalid RDMA-Write sg list length 0\n");
> +       if (plist->length =3D=3D 0 || plist->length > max_chunk_size) {
> +               rtrs_err(s, "Invalid RDMA-Write sg list length %u\n",
> +                        plist->length);
>                 return -EINVAL;
>         }
>
>
> ---
> base-commit: a48671671df5158a0b8e564cd509e04a090a941b
> change-id: 20260612-master-7cbc156da1f8
>
> Best regards,
> --
> Zhenhao Wan <whi4ed0g@gmail.com>
>

