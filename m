Return-Path: <linux-rdma+bounces-11275-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E26D3AD7AB4
	for <lists+linux-rdma@lfdr.de>; Thu, 12 Jun 2025 21:05:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ABD65189687C
	for <lists+linux-rdma@lfdr.de>; Thu, 12 Jun 2025 19:05:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0C942D8DC4;
	Thu, 12 Jun 2025 19:01:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="A4L79eJ5"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09F342D8DB7
	for <linux-rdma@vger.kernel.org>; Thu, 12 Jun 2025 19:01:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749754862; cv=none; b=b3Q9tSbVqOL1mKI/OFW+j0vQky1jMx7sC3zFOSMFc5IhN2lsYRYBJ6dUEPPQjVLhhKTrjuvwBYJo2yS3AOJRbbc5Ee8nXdE1B62KyYo3OjwFPnlMHXW9vrvn3YfSXwBJvDiGLnoWb7rN1JbrDi/TVIw9AiCH+wweLZ24oUaggOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749754862; c=relaxed/simple;
	bh=ZwlMsaTHjZOtEXv/YqtnnEPbYBwwh6k+wD4c3F2kUr0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ba5XxZpDFgmhb8OfdG+ZoidbDUe43wxP/wQzr93g1lJU99McyT9AjT12qQDxfsSHCbNHZi9ml44Ux/Iig32zPZ82TUw3zz8qARdRypxuaaDVRPyKSOHE05n4nRqgWsDVen1qJrkhOazlyHJOahv6zNb+Hf99iUmM3wAQNBisyHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=A4L79eJ5; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2357c61cda7so30775ad.1
        for <linux-rdma@vger.kernel.org>; Thu, 12 Jun 2025 12:01:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1749754860; x=1750359660; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZwlMsaTHjZOtEXv/YqtnnEPbYBwwh6k+wD4c3F2kUr0=;
        b=A4L79eJ54S8X/R6hdBRCGJERy7H+zrEjPyMVVBDEq73jX4tDGzH3TXGyFFeViSYU5x
         IGzAXqwuH26ZZPVqh2BTD5c3EpOFjYyeo1I9HO28R5rcfjJlc2TAXXEdCVOvI8HMDWfp
         M7wJn59bo/R0KEjXzu89S81WRPMoZVOOhkc21AJp4jsxBc+Z1Ovope1S+Euh07I4obrz
         XE0AA8khB6StZ406/4PRkf1tmhWHpT5xPcwwyRiaVgrHj8YsHyvkoiansK9tWjlLAHxI
         FYIg/BMQu0jDDqJ66Tbft8Y7n2iHJ/TnY54dW18edX+W/DKljg8uhbbwI+IRKCUqSyD8
         Ja2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749754860; x=1750359660;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZwlMsaTHjZOtEXv/YqtnnEPbYBwwh6k+wD4c3F2kUr0=;
        b=RKsFsMRL0Cka3vcBDY1Xx5/Ki4YkYxIF+IvTautDykBZ6/PJ0UlV8irmyPh4pV1Mdq
         YoDyYKYVwxRF18ZNbdiH8/i7NCrpvJyCjvxSmjgYC3NJDGhC1RJgePhnZtJ2GMzIwm/m
         PLHYv4sx7eH7vs0coEx0fXf1/x2rN0JN1JdeRr8yV/v+whNNsHvRs0nDSX3V4uWIDyt9
         zE+AqMcTYm5H5YcS8A9+RYqa5KB0U/yrUf3qafp5Xc8h1Z/dBg0F1Jp5nS3ggjEhkmdo
         +CJzxqr2H7zEXlTiSrGNKqgR5ZHrOyj348IqSUMgBsCvv97+jYbRNk2UW7kawSUVpqSO
         6HxQ==
X-Forwarded-Encrypted: i=1; AJvYcCUCfuqSfYy03bh3u6pwjKLRgMLXeFzeeJ/5rf2pID3pXQ0sU8xxFXK4ZTyOkzfONEm/roY4LxrdvTw/@vger.kernel.org
X-Gm-Message-State: AOJu0YxS22/FWTCYwlM0ta71tjMFq7SxzXKZYt2KvPjrthzK+WnrFjec
	Hg0M7i9QiPKOEnoYst7quwy0ZP5gmtN8Ie478l42pD8I0Kn9XPDgUmdFv7OAdpJSez3jvMr3x2I
	GmUDYyn/br9Ru1QonBxeNyZE3Pzf0qnR8WUeYWVIE
X-Gm-Gg: ASbGncv45tR6gXU1sE/NX7jLJWaP0JtU0gcg2Xu9X0LtWPZ60lOeLUYz9tEm5OU3sBn
	gWCiVRsU26eAPLlNSoGEYq1l5m3DdKo0HF/u70TwSJ/t9mJLEfieqSpTzYgVitaVLWr0NVQfpJI
	/1fBvfSlZFaR7x2HG/4hoGolYPiBVJv3WPGQIumOkwTE8eiHDAEcyUepj1Idcfe5Av/rb9AvGc4
	A==
X-Google-Smtp-Source: AGHT+IF+DrhTdw1EVP33Lsxs8pEmeKyxPiFeWCjxcFQq5i+dtpZuy+WTSh+WvsQ3zeAWf1tAffKMVahMPLgaOisNCFA=
X-Received: by 2002:a17:902:d54a:b0:235:e1d6:5339 with SMTP id
 d9443c01a7336-2365e950001mr97625ad.26.1749754859927; Thu, 12 Jun 2025
 12:00:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250612154648.1161201-1-mbloch@nvidia.com> <20250612154648.1161201-4-mbloch@nvidia.com>
In-Reply-To: <20250612154648.1161201-4-mbloch@nvidia.com>
From: Mina Almasry <almasrymina@google.com>
Date: Thu, 12 Jun 2025 12:00:45 -0700
X-Gm-Features: AX0GCFs8bIh3dxPetT87B5xeJSISXmwVqrXxvRLSdCTJ2AOZNbM701RU8f8TtdA
Message-ID: <CAHS8izNe_g9o92C0RbOe6vtbSfBMbJJJc4K1HubpozN4xwrcuA@mail.gmail.com>
Subject: Re: [PATCH net-next v5 03/12] page_pool: Add page_pool_dev_alloc_netmems
 helper
To: Mark Bloch <mbloch@nvidia.com>
Cc: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, Simon Horman <horms@kernel.org>, saeedm@nvidia.com, 
	gal@nvidia.com, leonro@nvidia.com, tariqt@nvidia.com, 
	Leon Romanovsky <leon@kernel.org>, Jesper Dangaard Brouer <hawk@kernel.org>, 
	Ilias Apalodimas <ilias.apalodimas@linaro.org>, Richard Cochran <richardcochran@gmail.com>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	John Fastabend <john.fastabend@gmail.com>, netdev@vger.kernel.org, 
	linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
	Dragos Tatulea <dtatulea@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 12, 2025 at 8:52=E2=80=AFAM Mark Bloch <mbloch@nvidia.com> wrot=
e:
>
> From: Dragos Tatulea <dtatulea@nvidia.com>
>
> This is the netmem counterpart of page_pool_dev_alloc_pages() which
> uses the default GFP flags for RX.
>
> Signed-off-by: Dragos Tatulea <dtatulea@nvidia.com>
> Signed-off-by: Mark Bloch <mbloch@nvidia.com>

Thank you!

Reviewed-by: Mina Almasry <almasrymina@google.com>

--=20
Thanks,
Mina

