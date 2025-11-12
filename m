Return-Path: <linux-rdma+bounces-14436-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E2F36C51C94
	for <lists+linux-rdma@lfdr.de>; Wed, 12 Nov 2025 11:55:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 95D871899C42
	for <lists+linux-rdma@lfdr.de>; Wed, 12 Nov 2025 10:55:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10638306B33;
	Wed, 12 Nov 2025 10:54:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bfFtztmy";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="ouS84kuU"
X-Original-To: linux-rdma@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B920301473
	for <linux-rdma@vger.kernel.org>; Wed, 12 Nov 2025 10:54:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762944896; cv=none; b=AbSQXzs7yrCN7BACaeo/YDtU38k+XdF3xsyK8kJ1ZTVqKIntGpXc54woBbFJQnXx4yQkbe3lX5NVM1EBLsHwRj95HQkvJJtsITV8tawkSDdG5hErhQTRQl/EDUdcwTIFdkw6Ttug4zTZJBbXybtmw/DVTDF7oqgtYoTZ4TIjrn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762944896; c=relaxed/simple;
	bh=+d5+14LmUROJgkDGR1Oe1xzly7s950/vBN51axGk9eE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Bz+GJ1ZiHWPY9neMuHCCSKDUG8OQBdMtp4FThqRNTuQvJ3p/kM4rfc8qG/85e+CYwA/CkXr1HW52hAEL+jce+brDLLO2JzT9ZElPkRsPdEqahzmCZcy3tY6vYhrjfetrqCqJ2Qx0ov6kyncku3vqMPdfpNQrvw9iuc9vo2FPYcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bfFtztmy; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=ouS84kuU; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762944894;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+d5+14LmUROJgkDGR1Oe1xzly7s950/vBN51axGk9eE=;
	b=bfFtztmytfdE6x5j0yYJYxs6YUPIDZcj+5WogYYuG8w5+0GeptZHB27x6HRjN9m6YitI2U
	Z0ieIQ4sqY9RLpo4L/LtoFje9/BurODfu9ZvH0u/gxYQQK+OUOj47guZeRP6Kh82zMXoQU
	8sWwscCmHLX59MsmhWGBsY6lc2ZmJX8=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-641-svX2hAP4OFyRjqxMiDeqqw-1; Wed, 12 Nov 2025 05:54:53 -0500
X-MC-Unique: svX2hAP4OFyRjqxMiDeqqw-1
X-Mimecast-MFC-AGG-ID: svX2hAP4OFyRjqxMiDeqqw_1762944892
Received: by mail-ed1-f69.google.com with SMTP id 4fb4d7f45d1cf-640b8d02165so733205a12.2
        for <linux-rdma@vger.kernel.org>; Wed, 12 Nov 2025 02:54:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1762944892; x=1763549692; darn=vger.kernel.org;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=+d5+14LmUROJgkDGR1Oe1xzly7s950/vBN51axGk9eE=;
        b=ouS84kuUOqxjVYqyd2JOu0jUlGc5vfFvzdwstviQTaLYhw8J2jsATzKrk4pQlzj+nz
         3SDInp1Oyl2KGpOUK3UAKQDS4CqC1hD0Bc2Fc17OGlOhabo+kx6fxQB8HYLWhtqD80wd
         YQtI3xqBfZ2Pab0LH9IUp5O5fmI/DngbV2UaT03XJBDCgNXG5Rb6PDN6A3WhDr1u6BqA
         +xgfr1jlmmfDnceNpGwq6Y0uuZnXPHdksJro8mgAzxx1AW5BvgdAQem08bJa6Nm3HoJH
         8iwWQwf5Qbq21J84bzKqHSMvYttTQdqOGB2HI+xTkP7MnKlrGNPpL4x3Vea60WT4cPXO
         1Syw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762944892; x=1763549692;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+d5+14LmUROJgkDGR1Oe1xzly7s950/vBN51axGk9eE=;
        b=wYUQF7biH47kD807rsfBr1kn++jRZiq0N9pzc1l+t6IA+QAVUzjYVwagc37TeM4uwK
         sctCCtU53iin5wfW0dTX78u8cDxYXGFXqXX872M60ldbvH++LKgCFGanAu9PIq/Wg2Sv
         Tbx4Ao08XjVYnG2NquciAlnOAx+ZNGnkxiBtsX7Dvz5l84Y6TgeCcv9dPAnGpBd3Xue0
         uypOGFgADPNVybzXujQ3W949GIPqH29A6BWZdYWzJyEXayh2JoGyh9n4mhqO/I4Tse+l
         x5+oJidamw7lBEXByYYl6VLRRivvoVNqedH6lFYKStxpkSeGYeOAaDcddSihcnFyDR1T
         MLbQ==
X-Forwarded-Encrypted: i=1; AJvYcCWHhCtZns8tPDR9ahiGngwr5t+CtRTVsLqzafl9E5xPpca6pmYOdh2n7hmKj8qZqONZoqwdBOxXVMSy@vger.kernel.org
X-Gm-Message-State: AOJu0YyTH91TjHXISugnKTKZLtBDHZkAcYDZKoTMsRzSWkk8mKx2sRSy
	HoHFlJts1FjaPHbsiDG7vg6f8BMrNx0BTGmntLH+nliqz3/y6UCDvsntP3dyFrAiq5FHi/US/S+
	3UlwuDA86KMMGriwV1U7xFFS/0rsskTE257kE5DSHHNGSw3xCZghm1DxWci2XxD8=
X-Gm-Gg: ASbGncuTY119FoFNN7jt1CWa1NsDUVPNKPHzCUrN6Ln8qTD4xxpeUH/AKPLaI5tvlXY
	mFrZnqE7LGKNAlKyLWOdBha/RkfmAHiUjjPKpIvkZ/ztLL2DS77nukOvf9siPc+xQ6O5Px6wAqo
	JKKMv5jmcfAGyWH8R/fDUUeoGdLRpBn0s+ZM7HeLjF+3/APetEz3VcsRYdAVFpMIx+d30SfOWog
	WwTyyXyeMnqqnGW03Ko2RXG1WzAteeHvs29zwrn6BCQXEkKNRzcMIqpBhniMgOiOe3+xHz/01kF
	V+xMCrLYlNqTZNP8CEIvuPFRQBdF+pD7yZBSKIwTj5EogyszHtiL190QaxgiUzj5NQgp8gx3pBQ
	62LokIaOQFxGQeWE5Z+iDO0g=
X-Received: by 2002:a05:6402:2689:b0:640:e75a:f95d with SMTP id 4fb4d7f45d1cf-6431a4ca1c7mr2289588a12.15.1762944891883;
        Wed, 12 Nov 2025 02:54:51 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH6zPMnNj6//iJFyS3LCsJH7VDDk53FJ+jsm5ERoxaP9Mj04HNN3IWqXw7M8jI38CxB8FzfIA==
X-Received: by 2002:a05:6402:2689:b0:640:e75a:f95d with SMTP id 4fb4d7f45d1cf-6431a4ca1c7mr2289545a12.15.1762944891443;
        Wed, 12 Nov 2025 02:54:51 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6411f8578d4sm15715451a12.18.2025.11.12.02.54.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Nov 2025 02:54:50 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 00886329685; Wed, 12 Nov 2025 11:54:49 +0100 (CET)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: Tariq Toukan <tariqt@nvidia.com>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Andrew
 Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>
Cc: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
 Tariq Toukan <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>, Alexei
 Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend
 <john.fastabend@gmail.com>, netdev@vger.kernel.org,
 linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
 bpf@vger.kernel.org, Gal Pressman <gal@nvidia.com>, Leon Romanovsky
 <leonro@nvidia.com>, Moshe Shemesh <moshe@nvidia.com>, William Tu
 <witu@nvidia.com>, Dragos Tatulea <dtatulea@nvidia.com>, Nimrod Oren
 <noren@nvidia.com>, Alex Lazar <alazar@nvidia.com>
Subject: Re: [PATCH net-next 0/6] net/mlx5e: Speedup channel configuration
 operations
In-Reply-To: <1762939749-1165658-1-git-send-email-tariqt@nvidia.com>
References: <1762939749-1165658-1-git-send-email-tariqt@nvidia.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Wed, 12 Nov 2025 11:54:49 +0100
Message-ID: <874iqzldvq.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Tariq Toukan <tariqt@nvidia.com> writes:

> Hi,
>
> This series significantly improves the latency of channel configuration
> operations, like interface up (create channels), interface down (destroy
> channels), and channels reconfiguration (create new set, destroy old
> one).

On the topic of improving ifup/ifdown times, I noticed at some point
that mlx5 will call synchronize_net() once for every queue when they are
deactivated (in mlx5e_deactivate_txqsq()). Have you considered changing
that to amortise the sync latency over the full interface bringdown? :)

-Toke


