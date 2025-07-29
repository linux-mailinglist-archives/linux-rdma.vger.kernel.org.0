Return-Path: <linux-rdma+bounces-12518-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 670EAB14582
	for <lists+linux-rdma@lfdr.de>; Tue, 29 Jul 2025 03:01:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 86DD017FA8D
	for <lists+linux-rdma@lfdr.de>; Tue, 29 Jul 2025 01:01:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8987618DB03;
	Tue, 29 Jul 2025 01:01:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=openai.com header.i=@openai.com header.b="CpmZcbHf"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DB9626290
	for <linux-rdma@vger.kernel.org>; Tue, 29 Jul 2025 01:01:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753750891; cv=none; b=B9sXCuLVYFTtty+fjruBivG/7m59ey6+8UGlOZ/ASC2OJD9+8gyoEHNfQksrM0ta8ApTlaQbc1I5sxPeI1GI7CdyoAo2jJ1jANODUNsU6ib1Ca802Bb2Lh3jfB20DFNZxLV41bBSxWcx7CQ7jgU2eUKvYOW7wXinDkfL3hk5S64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753750891; c=relaxed/simple;
	bh=YmYvO4FWfw/auTRrGHq/3PqRNQTKh1IL/8v263lla2U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=S6uR8VoHKVNDI+G7PfJi8oeenaWb2CFM72/fG58B8evOQiQHzlvQyt+9dJ9yAESOzRMGgdaeNz+RTpS0vbTRMVTT7xlEKw/tTBR5DbS3cGvhsEpyP2AkkwqvHEWYcKsmtwapIsmavHx9pQvwgTLSbQTNEkovkLBFt24mYpiNK+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=openai.com; spf=pass smtp.mailfrom=openai.com; dkim=pass (1024-bit key) header.d=openai.com header.i=@openai.com header.b=CpmZcbHf; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=openai.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openai.com
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-55a10c74f31so5373618e87.1
        for <linux-rdma@vger.kernel.org>; Mon, 28 Jul 2025 18:01:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openai.com; s=google; t=1753750888; x=1754355688; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gDIT0nBpRVtuwBCG7gDLBrg2ssrS3F+2Uf8dT4SCT8w=;
        b=CpmZcbHfhBWiGfqK70sbqTAJzekMmwHX2nszNIiSzP5I6N/1gZ2FMJYGJnn9SKEztz
         UXklrTIG+TmpTpp9MBjQb0j74xY8DEpRBVvXB1kFmCnTJzhLrZ4xpbzEPtjvSS+jtcDo
         uyVVRlfgqwWHVhN21aWuw6CzIsRPGjho94vos=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753750888; x=1754355688;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gDIT0nBpRVtuwBCG7gDLBrg2ssrS3F+2Uf8dT4SCT8w=;
        b=wLGBbhSvQ+pkpJEcUY4y9/XnPnU+XDRLLqEcsQNBuBpVxAbzOC1bVIZYu78bW7Tqyl
         x5asoIO5thHwcYJidaZi/2/w/1L2OAXiiHGBBCH4SbU9hysKVNjjMvPb1UPyIFj6vVM4
         4v10M93P537FJzWQ2D8ZcdNXR1cPK4ChzDKkpBXQ7VUlGY+FgyZXc8ZCs4nlqAZIoU6z
         nyvmovtu5PDFlW8DjmKKfCeawkBNCjxVjd3WHzj28iEA0PctwanvKSv10Eubc1aFBcwz
         Y3APck4Z8xPThlXiXzFNzEwhzA+jPJ+3jZX66mdnN0i1Fvrin9xqMOr/fKC4pyghLnQU
         sOGg==
X-Forwarded-Encrypted: i=1; AJvYcCX+VAlkfOKY04xqZbzpjajKv/V8BzlXvtCHGr2Yv3Zzli00MgxF9+8yd3/u8QgTA42eQjJS7xX8gLwY@vger.kernel.org
X-Gm-Message-State: AOJu0YzXOi21/97pGZoXsXS2Nqf3v8ZUJ6joXV/3quB8QW8Imletaipg
	E2hPiiVc2UghV+2y4awatgc5qTheqHvUHrDxbDcWVImsMzX1PA5vfIBKGjyxlwkhMbppnCT0Yog
	rLGYGpDO8d9OUHw1dhXQ1+i1zpb5aO1xl/Jb7OaNMBw==
X-Gm-Gg: ASbGnct4C8/vGgG2INRYoNxXZhmW6Apfl4MGaqxc3RxsYP8xUgBf+pCGlQASyqbZpXf
	Rgyfv/wUzAOP4qVtrt9of/A7T+6FVdn8eGnKaI8nfBBaqpFfHB4ncYHrtdSAN65l0FZvHmY9pqE
	gowW2wMqehN2+I/cHzMiukiaaNgVWxFntsQF6Z0hnnNQEHsashX7/eRdBa7R/1NZPywE+EaxN7h
	8iUTBq980knocLxJQ==
X-Google-Smtp-Source: AGHT+IHZHYWPwrjCjyN3Pco3uAktH4UaV+w/6J5hon8rvvA1SU2NwaCn7/rkoQQC5Lp4hAo9W4qudp/AWBLzHde2GYo=
X-Received: by 2002:a05:6512:2213:b0:553:51a2:4405 with SMTP id
 2adb3069b0e04-55b5f4f0e02mr3346475e87.45.1753750887575; Mon, 28 Jul 2025
 18:01:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250715-cpaasch-pf-925-investigate-incorrect-gso_size-on-cx-7-nic-v2-1-e06c3475f3ac@openai.com>
 <6583783f-f0fb-4fb1-a415-feec8155bc69@nvidia.com> <CADg4-L9osR02Aey319fMVAyAYXxOfaKqWcQ2AsfQCrdFKA5vsQ@mail.gmail.com>
In-Reply-To: <CADg4-L9osR02Aey319fMVAyAYXxOfaKqWcQ2AsfQCrdFKA5vsQ@mail.gmail.com>
From: Christoph Paasch <cpaasch@openai.com>
Date: Mon, 28 Jul 2025 18:01:16 -0700
X-Gm-Features: Ac12FXx34w-5NNkKbSzLrNHUmUDt-mDcYsz7pUlimEBGF8InxuFiNX1qQROyU7Q
Message-ID: <CADg4-L_SNAKy3mBn7ssq7uw0_+wZ_=zyqrQ23yVTOo5J7z7Q=g@mail.gmail.com>
Subject: Re: [PATCH net v2] net/mlx5: Correctly set gso_size when LRO is used
To: Gal Pressman <gal@nvidia.com>
Cc: Saeed Mahameed <saeedm@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>, 
	Leon Romanovsky <leon@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, 
	linux-rdma@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 28, 2025 at 10:57=E2=80=AFAM Christoph Paasch <cpaasch@openai.c=
om> wrote:
>
> Hi!
>
> On Mon, Jul 28, 2025 at 7:36=E2=80=AFAM Gal Pressman <gal@nvidia.com> wro=
te:
>>
>> On 15/07/2025 23:20, Christoph Paasch via B4 Relay wrote:
>> > From: Christoph Paasch <cpaasch@openai.com>
>> >
>> > gso_size is expected by the networking stack to be the size of the
>> > payload (thus, not including ethernet/IP/TCP-headers). However, cqe_bc=
nt
>> > is the full sized frame (including the headers). Dividing cqe_bcnt by
>> > lro_num_seg will then give incorrect results.
>> >
>> > For example, running a bpftrace higher up in the TCP-stack
>> > (tcp_event_data_recv), we commonly have gso_size set to 1450 or 1451 e=
ven
>> > though in reality the payload was only 1448 bytes.
>> >
>> > This can have unintended consequences:
>> > - In tcp_measure_rcv_mss() len will be for example 1450, but. rcv_mss
>> > will be 1448 (because tp->advmss is 1448). Thus, we will always
>> > recompute scaling_ratio each time an LRO-packet is received.
>> > - In tcp_gro_receive(), it will interfere with the decision whether or
>> > not to flush and thus potentially result in less gro'ed packets.
>> >
>> > So, we need to discount the protocol headers from cqe_bcnt so we can
>> > actually divide the payload by lro_num_seg to get the real gso_size.
>> >
>> > v2:
>> >  - Use "(unsigned char *)tcp + tcp->doff * 4 - skb->data)" to compute =
header-len
>> >    (Tariq Toukan <tariqt@nvidia.com>)
>> >  - Improve commit-message (Gal Pressman <gal@nvidia.com>)
>> >
>> > Fixes: e586b3b0baee ("net/mlx5: Ethernet Datapath files")
>> > Signed-off-by: Christoph Paasch <cpaasch@openai.com>
>>
>> Hi Christoph,
>>
>> This commit results in hw csum failures [1] when running iperf tcp
>> traffic with LRO enabled for a few seconds.
>>
>> I don't think the patch is wrong, but I suspect it exposes a new flow in
>> GRO which we did not exercise before.
>>
>> I am still debugging this, maybe you have some ideas as well. If the
>> debug takes too long I recommend submitting a revert until the issue is
>> properly resolved.
>
>
> I'm looking into it. I can reproduce it indeed and when disabling GRO the=
 issue goes away.

The below fixes it. The problem is that because gso_segs is not set,
NAPI_GRO_CB()->count is 0 when processing the packets.
So, if we have a non-LRO'ed packet followed by an LRO'ed packet being
processed, the first one will have NAPI_GRO_CB()->count set to 1 the
next one to 0 (in dev_gro_receive()).

This means we end up in gro_complete() with count =3D=3D 1 and thus don't
call inet_gro_complete().

I'm still unclear why this only fails much later then when checking
the checksum, but I'm sure the below diff fixes it (and also gets rid
of all packet-loss, so throughput goes up)

Will submit a proper patch tomorrow.


----
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
b/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
index 7462514c7f3d..da3e340c99b7 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
@@ -1567,6 +1567,7 @@ static inline void mlx5e_build_rx_skb(struct
mlx5_cqe64 *cqe,
  unsigned int hdrlen =3D mlx5e_lro_update_hdr(skb, cqe, cqe_bcnt);

  skb_shinfo(skb)->gso_size =3D DIV_ROUND_UP(cqe_bcnt - hdrlen, lro_num_seg=
);
+ skb_shinfo(skb)->gso_segs =3D lro_num_seg;
  /* Subtract one since we already counted this as one
  * "regular" packet in mlx5e_complete_rx_cqe()
  */

