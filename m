Return-Path: <linux-rdma+bounces-10576-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 85919AC174F
	for <lists+linux-rdma@lfdr.de>; Fri, 23 May 2025 01:08:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AC2131BC268C
	for <lists+linux-rdma@lfdr.de>; Thu, 22 May 2025 23:08:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB4062C2AA9;
	Thu, 22 May 2025 23:07:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dN0xssO/"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B1002C0337
	for <linux-rdma@vger.kernel.org>; Thu, 22 May 2025 23:07:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747955241; cv=none; b=KLVY8PW1DrHEst3zLOArpAbPuV9NcJcqGGmgTvKjl7WClBDfb93lgjG9VD3QATP7AIFzMJ1RpDyoUrWtAsTx8/A62+kUihRQiAbiQuoh93jXu8IWHvY++0uQ/EUo+Tmo2xUwpxZKv2CbqFPHtWfYHqT5gbiz/Pr8FQw0sLLwIVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747955241; c=relaxed/simple;
	bh=9k3VME5bwvvpc/ullR/HlyYZhFldfmD97iNNOe9Kyvw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Nk+qV5LlvAEkVmD7wUQRQTxRyOisOAyXjxUCpEMuM/OlkVbfJnhZdh3VvtxcKDnvHpv1u3ae8lGUqQIOYB2Wq9X5UCB2eyTvcqmXfF9x0KIBDGzpGWwuVQreI8GTufZdlXlJevl2xebdDYPfQW4f6Q4vHTYJArkhhIYnCWKqCaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dN0xssO/; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-231ba6da557so42595ad.1
        for <linux-rdma@vger.kernel.org>; Thu, 22 May 2025 16:07:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1747955239; x=1748560039; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9k3VME5bwvvpc/ullR/HlyYZhFldfmD97iNNOe9Kyvw=;
        b=dN0xssO/yLKwBNBu/SpBp4hXBIjmC+ZgcbRmx2yK8CwMpMdU4rfSrAQm9lsNuLZw08
         GKKFiSQl+b8yjPCaSra2AaVJl6AK9JzKaN6v/H5VRAgtBDX0q0TFAmGaZaczBFoiP0Pw
         6P4RjCXA4luqZZrng/F8hBd/PsD5lCZ+EGoNlsD4r50kttqAz5RCwq56OpCbfJ6Nj8YZ
         r4O+pOQkE8Y3XeGaD508x1RSzObtL1aM8k5EZQIvzjS6dUhkV7vwHI95aRmo6823/svr
         u0OjCJw2x92eVpVA7QznywEvIJsGEspC1ptM16+eUdSnvIO+epRIL8ZaZ6tsIuNM6SyN
         UBSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747955239; x=1748560039;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9k3VME5bwvvpc/ullR/HlyYZhFldfmD97iNNOe9Kyvw=;
        b=Aq7ojqZrFZlpyt88hQFHN4xajWTOOsnNRwTBk9e50xBtUhzUAivRFnVzs8w8NGMnbi
         jxVrxNkSQRDmLrQZbE7k2q1edQ3KP8qi+hCw0qkEpcc3h7UrCvf3VQ0whKWLMBzN7Vyh
         wKilq5yvuSX0Q0NcCB6AvwyyvAeNW04wCam0HpKOmaUKrWgI07FymfY4nxyZQjCmflfi
         AzfH5A3CkrfJ6xKE7GLNxFIHaTkBp7+cjgfLtiYZ/Gn6IiepznmCo8+y/Bw9mL70ITFG
         WcLK5PIjCcuGCbXxWqat2gSsQTd4P5z/woSrX4Qc8O5cB0wE3SMYZGyBa6w6ZaU8zwQJ
         3W9g==
X-Forwarded-Encrypted: i=1; AJvYcCWUvmI8/emW5Pto3rBY942C7OW7/3xygoYb3a5M0jQAnaULXiDeRwpFVYMb2UGTmXHzGBj/vwODRrXB@vger.kernel.org
X-Gm-Message-State: AOJu0Yzr/kxXcy7OFsqELQaUuhc6TXA2A6sWaS4J6N7vfIF+QI2GN/gu
	QhHCE1A5W23RqKgRvgs4Z+W7BKTZbkej3BeaB3eRCRbaG8NT8CffxssOAuIKOz9eAKn1eBwXiJY
	/rrRt8e0x6iO6F6PGnDe9rDsvMIYh521u0Gyqa1aO
X-Gm-Gg: ASbGncuuJTCA0pbUUcqe0GhIWvZc8Rzo8EEN2bbXs3ho3Y4TrQfTtjfzs2bYz42xd9r
	Oupe2kyGL/UYnI0s79d9gal6lC43opR3SU/0UNFeT7bL2xTXHux3d1xuGZ31Vkab7ylMPjMWjV/
	AQPKeci9GoaqE1MkHD5Hzdiuv6dkUuA1v+bm+F/9yaNyhcQUOi2OGoOn7tsJbxg6MV2T3avf9vQ
	A==
X-Google-Smtp-Source: AGHT+IHU4w0zFDczr9krT/bEYfz6eUrChXM9C2DLD3YJztsZ4hg5mbDDQkqfKBOb6e0hru6SRzufp2/mwXiVYMr87dI=
X-Received: by 2002:a17:903:2f82:b0:21f:631c:7fc9 with SMTP id
 d9443c01a7336-233f2f5c39amr718885ad.0.1747955238967; Thu, 22 May 2025
 16:07:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1747950086-1246773-1-git-send-email-tariqt@nvidia.com> <1747950086-1246773-2-git-send-email-tariqt@nvidia.com>
In-Reply-To: <1747950086-1246773-2-git-send-email-tariqt@nvidia.com>
From: Mina Almasry <almasrymina@google.com>
Date: Thu, 22 May 2025 16:07:05 -0700
X-Gm-Features: AX0GCFtg6n-BJbnwZ4ncUt-OvxE-HSzTGHOggSVSO4oEhmp8jL0GlZSc61OGYLI
Message-ID: <CAHS8izMANyVqznTjt_3qkcUdpbT96FK=m6Hc6AU4WGqhyq7zmQ@mail.gmail.com>
Subject: Re: [PATCH net-next V2 01/11] net: Kconfig NET_DEVMEM selects GENERIC_ALLOCATOR
To: Tariq Toukan <tariqt@nvidia.com>
Cc: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, Saeed Mahameed <saeedm@nvidia.com>, 
	Leon Romanovsky <leon@kernel.org>, Richard Cochran <richardcochran@gmail.com>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, netdev@vger.kernel.org, 
	linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
	Moshe Shemesh <moshe@nvidia.com>, Mark Bloch <mbloch@nvidia.com>, Gal Pressman <gal@nvidia.com>, 
	Cosmin Ratiu <cratiu@nvidia.com>, Dragos Tatulea <dtatulea@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 22, 2025 at 2:43=E2=80=AFPM Tariq Toukan <tariqt@nvidia.com> wr=
ote:
>
> From: Saeed Mahameed <saeedm@nvidia.com>
>
> GENERIC_ALLOCATOR is a non-prompt kconfig, meaning users can't enable it
> selectively. All kconfig users of GENERIC_ALLOCATOR select it, except of
> NET_DEVMEM which only depends on it, there is no easy way to turn
> GENERIC_ALLOCATOR on unless we select other unnecessary configs that
> will select it.
>
> Instead of depending on it, select it when NET_DEVMEM is enabled.
>
> Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
> Reviewed-by: Dragos Tatulea <dtatulea@nvidia.com>
> Signed-off-by: Cosmin Ratiu <cratiu@nvidia.com>
> Signed-off-by: Tariq Toukan <tariqt@nvidia.com>

Reviewed-by: Mina Almasry <almasrymina@google.com>


--=20
Thanks,
Mina

