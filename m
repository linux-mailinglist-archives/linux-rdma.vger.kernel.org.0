Return-Path: <linux-rdma+bounces-10463-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C717BABEEAD
	for <lists+linux-rdma@lfdr.de>; Wed, 21 May 2025 10:57:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 88FE64A4B94
	for <lists+linux-rdma@lfdr.de>; Wed, 21 May 2025 08:57:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 105F0238145;
	Wed, 21 May 2025 08:57:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="f05Yi26W"
X-Original-To: linux-rdma@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58F1A238143
	for <linux-rdma@vger.kernel.org>; Wed, 21 May 2025 08:57:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747817822; cv=none; b=TsqyXkGXRcODItFlwU3gtgdk5sI58hCHgV7DfVvz+buZvjJ3qBfxiEhOo+4ut2aLg3t0VI5Np0Q6vNFxNkgpBsd3ZUVX7s5l0TXFkkXiVroj30tqApbXoVW0AAsUXuH0vD7KoGEu5b00n1g1LOMQirvF7DMxZyMXI+LdMlPG2s0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747817822; c=relaxed/simple;
	bh=XSVAWIQJLeLQ+EnAe2fX432Jiet3EaT40S7A2jVLi7Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZHJ0dpXtzGs9Kc5JruTBxcjaJfY0oE0qnibpcEIiNO9OwmLoh387hstvbic98yf1kBu7orbcxl5/Nac04BYp586oip4wY5wHekH+FJ8BkvNdcrggvo4DibeX5yd+/HzVMovYEYFBTmIcPiETnekBwg5rkKgwC4jCGhNzOFjbZbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=f05Yi26W; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1747817820;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=z5ISw/s/gG2J/o4w18hQ658TJ8AN+hELaWEkOZaX4Ho=;
	b=f05Yi26We9j/BQYxoHcPfBL4QnY44Kn1ZdxkZJHiowgTTeFxHS76GtNZzgpcA87zG6eemJ
	u5mY+pEjda+/MV64cXgh8wBl7bcJpPJKl0PLYvTJ2CuOTxR+/5eeikI9kyDtwDW+NPFHhl
	OWvuG7066wYKAArxj5lmr9Om0UoUjAI=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-399-dSKhOwq3N9ifioPzacWTIg-1; Wed, 21 May 2025 04:56:58 -0400
X-MC-Unique: dSKhOwq3N9ifioPzacWTIg-1
X-Mimecast-MFC-AGG-ID: dSKhOwq3N9ifioPzacWTIg_1747817818
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-6f8c8a36dddso75378496d6.1
        for <linux-rdma@vger.kernel.org>; Wed, 21 May 2025 01:56:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747817818; x=1748422618;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=z5ISw/s/gG2J/o4w18hQ658TJ8AN+hELaWEkOZaX4Ho=;
        b=qVlLE43eKsqO8eoFwUhGriXlpjmWyw/pnoRUSU7SZUIaZwiVIb+QZ9jV4+F9dhqIkj
         3deLtvObNsyCtdgVRECvPbAEH28WgsWL4ZJawmh4R4tmyy8/ZqDke3/QPmzAS2kxFREF
         toGDlqBCjzGVzqnzSlVY6uCCc8+UEEhrhHBb6NnepLI8pqsBt+Emz7b48y9uUFC4xwE0
         n1YVJM5fEgBCunXAc0lMtkMPeXtA25C1KcnS559nubWwzeoxQYmmgeInh98pZ5WplsK2
         NBpUgRu2KyRAU2tZldJzUrBUOWS15OUZT4xUWbNHEWnC3dz1D/OmHvvJ+SF83rqpcWXN
         oFtg==
X-Forwarded-Encrypted: i=1; AJvYcCU3wNvG4cO7fgCzqq8UoK1NPCAHk2Sx847/76WnhatdDyoafaH68GpCQrcRfkAklbEZVRctp8UCExJx@vger.kernel.org
X-Gm-Message-State: AOJu0YwmO6n2uxjqPk26w6YAFoBCk2Pac3PmbqiEUCQRcEQyX1QMTU0K
	eO355t9sXrF2T+iMucuG1tCC6wHTwc7ZArF5dpfPg3WO06qyxYkNilED49PIxfBfUSEY4P3ElD7
	QD9jkAMEB4+LO8d44Ex+eZVwlmEZf55oX0SIH2IahtjZxdOMGhnZnls+Kl2ta1hzqkdSZ0pdSE2
	k0F3O9OAizM7EFc5gt2TdHfAluMA2Ddnq08nBMcg==
X-Gm-Gg: ASbGncvB1SnacP1wU2wvdN6VV8A2yKQEoSot0126DVY5eJaZBjvj2hdsMAaQd9ZRaGr
	jcDQ2RvqLDgcQpO7of/Km/QEBxRc7jNlO9xc/Lidw/jPb7cRUvM54111LS/JcwAaKOUU=
X-Received: by 2002:a05:6214:2681:b0:6f8:8df1:648 with SMTP id 6a1803df08f44-6f8b2c37a19mr343338896d6.7.1747817818420;
        Wed, 21 May 2025 01:56:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGaO4WTOV6fJAlmH9DP3inkXOYir+cNPdLYhrMs4mbVZjO2ZBdSoayKvQmU0Z4z5PR9AxBgDQglVFmrFM7Wvjg=
X-Received: by 2002:a05:6214:2681:b0:6f8:8df1:648 with SMTP id
 6a1803df08f44-6f8b2c37a19mr343338606d6.7.1747817818106; Wed, 21 May 2025
 01:56:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1747253032-663457-1-git-send-email-tariqt@nvidia.com>
 <CAADnVQLSMvk3uuzTCjqQKXs6hbZH9-_XeYo2Uvu2uHAiYrnkog@mail.gmail.com>
 <dcb3053f-6588-4c87-be42-a172dacb1828@gmail.com> <09377c1a-dac5-487d-9fc1-d973b20b04dd@kernel.org>
In-Reply-To: <09377c1a-dac5-487d-9fc1-d973b20b04dd@kernel.org>
From: Samuel Dobron <sdobron@redhat.com>
Date: Wed, 21 May 2025 10:56:47 +0200
X-Gm-Features: AX0GCFu5dfswcCWTTkSyc0z9SXYg_lElASwlqEtz7krxELOPksJgTCJdKDQl7-M
Message-ID: <CA+h3auNLbmQFXrN1A5Ashek4UiMGa_j+EHaFFp-d74kGZvyjsA@mail.gmail.com>
Subject: Re: [PATCH net-next] net/mlx5e: Reuse per-RQ XDP buffer to avoid
 stack zeroing overhead
To: Jesper Dangaard Brouer <hawk@kernel.org>
Cc: Tariq Toukan <ttoukan.linux@gmail.com>, 
	Alexei Starovoitov <alexei.starovoitov@gmail.com>, "David S. Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, Saeed Mahameed <saeedm@nvidia.com>, 
	Leon Romanovsky <leon@kernel.org>, Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	John Fastabend <john.fastabend@gmail.com>, Network Development <netdev@vger.kernel.org>, 
	linux-rdma@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, 
	bpf <bpf@vger.kernel.org>, Moshe Shemesh <moshe@nvidia.com>, Mark Bloch <mbloch@nvidia.com>, 
	Gal Pressman <gal@nvidia.com>, Carolina Jubran <cjubran@nvidia.com>, 
	Sebastiano Miano <mianosebastiano@gmail.com>, Benjamin Poirier <bpoirier@redhat.com>, 
	Toke Hoiland Jorgensen <toke@redhat.com>
Content-Type: text/plain; charset="UTF-8"

Hey,
I ran tests just on stack zeroing kernel.

> The XDP_TX number are actually lower than I expected.
> Hmm... I wonder if we regressed here(?)

The absolute numbers look more or less the same,
so I would say no. The first results we have for TX is from
6.13.0-0.rc1.20241202gite70140ba0d2b.14.eln144
comparing it to 6.15.0-0.rc5.250509g9c69f8884904.47.eln148
there is actually 1% improvement. But that might be a
random fluctuation (numbers are based on 1 iteration).
We don't have data for earlier kernels...

However, for TX I get better results:

XDP_TX: DPA, swap macs:
- baseline: 9.75 Mpps
- patched 10.78 Mpps (+10%)

Maybe just different test configuration? We use xdp-bench
in dpa mode+swapping macs.

XDP_DROP:
> >>> Stack zeroing enabled:
> >>> - XDP_DROP:
> >>>      * baseline:                     24.32 Mpps
> >>>      * baseline + per-RQ allocation: 32.27 Mpps (+32.7%)

Same results on my side:
- baseline 16.6 Mpps
- patched  24.6 Mpps (+32.5%)

Seems to be fixed :)

Sam.


