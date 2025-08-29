Return-Path: <linux-rdma+bounces-13003-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 11D08B3C0D6
	for <lists+linux-rdma@lfdr.de>; Fri, 29 Aug 2025 18:34:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7506D162648
	for <lists+linux-rdma@lfdr.de>; Fri, 29 Aug 2025 16:34:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E69C2E1C4E;
	Fri, 29 Aug 2025 16:34:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="yZzcFSeT"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BAF930F957
	for <linux-rdma@vger.kernel.org>; Fri, 29 Aug 2025 16:34:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756485248; cv=none; b=thSyRSTbrWZ7sBqcyEiykYQDEuxFEgnRagAi1qeMUYsnflJ2ylK1bEx/MLWXCOKh/tRYlHfJHlzf7Tu8JVUU84YFYyrvWkrEtpzHOclhz2EKIfFVAesEFLq2Kw9bONsttyATuMREM1TPr3JSyd8NNIie1OdvqZel7Z06O7DbC68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756485248; c=relaxed/simple;
	bh=BEpZQhYzjwsLfJeudrqgmT2DRJfFRuBpsoElnQM3kF4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ubLl8pLRnzdP5ZUBlVYgTgkiK8DPRx99Hfdqd8exF2a04zCP4+hxumyaS56vmfo4eEPjd8UuUqIzb4WxLzKP+eu1A7hih6lsPAvff8LkOEQyWXV8hoLb8eZ8hFIHlPBMqQW7N6vFHzUSTyiukXGmBX2zPcZTc15ohKDL3AqYklU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=yZzcFSeT; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-7f901afc2fbso205112485a.0
        for <linux-rdma@vger.kernel.org>; Fri, 29 Aug 2025 09:34:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756485246; x=1757090046; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BEpZQhYzjwsLfJeudrqgmT2DRJfFRuBpsoElnQM3kF4=;
        b=yZzcFSeTDXtfG7Io66w+4NDacXOOjav1C0B35w5lxY6j1aX9bK3x//As59NIOj7xJi
         /JxrPS7mMQhVF3xl1MZOQWk9G66ugVlwYd90mG31i4G4Mepfwo2NyFJdiHq77idXJEez
         X8EV+uUto469lwnDZ0OqjuEwkG5N4nRYf5x1iWSYdOehIW2vpzgrds1LlMGhSkIOGhGE
         Di6gDbSYB1J57eHce+omAmcBqHDvXve+hQqkY95p+3tOxrQf87PyBu3Ry7SEosgPsQFK
         XQoFrCxN0Dthwz9ZHeaiF6h55KteB+uHgeuz3Ra3p8wS7xUGNotxBULYzYAxCYWORXKI
         +rEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756485246; x=1757090046;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BEpZQhYzjwsLfJeudrqgmT2DRJfFRuBpsoElnQM3kF4=;
        b=Ly/KOQkJwDhcvlykqrpIAytk//VXpebsezpuVJf32zlwQ1K4ah2Oog5tA8HnD6ewZt
         D6zfE6njqx6i5Q8caJniC5pL80TQguNxZq3mt1M1e+ELF/8QC2e12oQ6RJ/PaC4fpriA
         1+wrRAW3KxHa4I7VpyesNNjIURexP0JZTxJL2TigTZppvK05VBqCV5NTPxi3fIiP/8jg
         xUu1JCn1zMEKYYRMRRsZRJn/yRP7RTVoqykY48fsNvw+Tbc+ZpQ4ETJcTtqsRE/+3NIZ
         2+xwrl+PXmF27+nCOkeeiFhv9FiCISnuiIFa2yuv8VQ2dgkU9JxQFdnxq3KTn63/xMel
         0E1A==
X-Forwarded-Encrypted: i=1; AJvYcCV2ZbKYSdDpL/mpk/+s3CSZbrZuQF9qI1T29D7Q5y9e4i+mU7F+GZBGIAfqteiHakD2BrzH9KN2oOSY@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3GMgGerbTPHdqDPBrlAp2e4KqOxQ6Jf9A19+xxXE4rvck8ESG
	C3PjQcdPs23UBFVtxpO4Xfqm39Gd/mxeSvvC14TvzRpYNEWSOxrMVV4NMaCZ6BYjjI7SMQweO+U
	21ICDWquiSB31RyaBM2E6t882V8dW0wreyIvoOIwK
X-Gm-Gg: ASbGnctqfykaEpedQ9JZ+GrFRbTZDgysSTSCvlcvAu6K6aL8NTuG71B7br49qMuLagU
	Y3d8h0WbPKN3KTAo/fSigIQtLDjF0HLrK2ibPG41SoJN542yW3m+HeuQPn23Li+I5NRjRxHkGkC
	qgBuncS6jNY3Rrlj9gjCjfCsGCRz71MoLasZcUAV3ELCmb1M5tSp1B0ooXm8XcgUxOgzLGh1L/Q
	XSKhtN6QRLW4nKXH7GxE6nM5WeqGZdUoX3mJ40Ilk+zNYD0NhzfbjJPn0c=
X-Google-Smtp-Source: AGHT+IHtYMp7MaCT41dAq1EckC1KoVCTKnXamBjtK+0KAq3RniwlNivEAWcGZmijh3OPLqGjBp/iT2msuf372hEp+iY=
X-Received: by 2002:a05:620a:a80a:b0:7f6:f290:d7a2 with SMTP id
 af79cd13be357-7f6f290d81emr1339269085a.26.1756485245616; Fri, 29 Aug 2025
 09:34:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250828-cpaasch-pf-927-netmlx5-avoid-copying-the-payload-to-the-malloced-area-v4-0-bfcd5033a77c@openai.com>
 <20250828-cpaasch-pf-927-netmlx5-avoid-copying-the-payload-to-the-malloced-area-v4-1-bfcd5033a77c@openai.com>
In-Reply-To: <20250828-cpaasch-pf-927-netmlx5-avoid-copying-the-payload-to-the-malloced-area-v4-1-bfcd5033a77c@openai.com>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 29 Aug 2025 09:33:54 -0700
X-Gm-Features: Ac12FXzVKBKIpycRTThoYnOUy1NOmMvnFdIRovbc3ZCcjbrQ-vjmY06SJZt7nbo
Message-ID: <CANn89i+Zw7o+iGoN4Qf+wS-hL==DSZn8sMTT_7HerNuVd+uVPw@mail.gmail.com>
Subject: Re: [PATCH net-next v4 1/2] net/mlx5: DMA-sync earlier in mlx5e_skb_from_cqe_mpwrq_nonlinear
To: cpaasch@openai.com
Cc: Gal Pressman <gal@nvidia.com>, Dragos Tatulea <dtatulea@nvidia.com>, 
	Saeed Mahameed <saeedm@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>, 
	Leon Romanovsky <leon@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, 
	Stanislav Fomichev <sdf@fomichev.me>, netdev@vger.kernel.org, linux-rdma@vger.kernel.org, 
	bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 28, 2025 at 8:36=E2=80=AFPM Christoph Paasch via B4 Relay
<devnull+cpaasch.openai.com@kernel.org> wrote:
>
> From: Christoph Paasch <cpaasch@openai.com>
>
> Doing the call to dma_sync_single_for_cpu() earlier will allow us to
> adjust headlen based on the actual size of the protocol headers.
>
> Doing this earlier means that we don't need to call
> mlx5e_copy_skb_header() anymore and rather can call
> skb_copy_to_linear_data() directly.
>
> Signed-off-by: Christoph Paasch <cpaasch@openai.com>
> ---

Reviewed-by: Eric Dumazet <edumazet@google.com>

