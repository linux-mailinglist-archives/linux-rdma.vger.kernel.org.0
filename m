Return-Path: <linux-rdma+bounces-14319-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D05DC42637
	for <lists+linux-rdma@lfdr.de>; Sat, 08 Nov 2025 04:48:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 40160188F6C2
	for <lists+linux-rdma@lfdr.de>; Sat,  8 Nov 2025 03:48:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DDE7285CA8;
	Sat,  8 Nov 2025 03:48:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AmEDBOKL"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92C51227BB9
	for <linux-rdma@vger.kernel.org>; Sat,  8 Nov 2025 03:48:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762573697; cv=none; b=gAZCgEAXq4GeYVGjHnrpoJSMUXL9aVWU6OQkAdZWz2PoEX+RaZu60aWxNB31jsL+VJMv2BBHNYDPO1A2NRrgNC2kjA4ECO4Eq4T4t6uRoQEV6LwSA3cUDl7NOYxHHYEbT+a0Hn+7EmwR1VNylqQ3ft+y6/56NJ732gwEsVyBWm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762573697; c=relaxed/simple;
	bh=g6qBYlNsvEJP9TH5pmvQjVY0nV0/L4FtBPDF1Q4xoxc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cy17b0gM/qp+LQwmSH5sG9M2oxp8epr1IR0x+BLboCVP60KCRZFw3cqhS2ZCqt4JQsoAdloMlaWxFVijPjJkaDoPJLSUBFqT9QcaUV5HP0Vg8p6BfAVg1I6Uli7Elm9O7oHPCJs0/67/6IgTI+Sst2XIFDKgHHrNpnPKrrhYyE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AmEDBOKL; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-b4755f37c3eso1089316a12.3
        for <linux-rdma@vger.kernel.org>; Fri, 07 Nov 2025 19:48:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762573696; x=1763178496; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g6qBYlNsvEJP9TH5pmvQjVY0nV0/L4FtBPDF1Q4xoxc=;
        b=AmEDBOKLB2bUB/U7pjK6ugmcuEFR+wq4eAIM9eGWt6q7T6Cm+DK1dOa38I2jO+PQZ8
         agdW4pGdAXzMVrTzTVxq7fl8gAChwdGtbudaNursP7rIrsHImMVvQXbJcQL+eNmlRg3o
         bNyCmOIKVbyUJPyxULHaOg7/+xBFp/MbTlQ0SQ8xTFI5+f3jXGmuO8zz9ZyGxr8l17I5
         zVWQLIHZbG9UZiZD70Lkz+nIeff4rvoQi7sx3wI97jOY38FpTHVrFUmASLAtSguF5jcH
         s3GgeAa9Oz7pRD5ImNdzqXvPUCL5Oq5gbb79ewnfta9CfG9hyg9LsRg1Ttev1TyT5l7v
         aBgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762573696; x=1763178496;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=g6qBYlNsvEJP9TH5pmvQjVY0nV0/L4FtBPDF1Q4xoxc=;
        b=h/H7wxw07/MUFrT+aLaYa1dtcZJbcKArWMMIXVDi7GFQwAWTzDTxNwV2Hm2+ISk5RO
         7daZUsmdlTqPHfBmDPlRTBEDh4Ghwx719vVUH48yIcqmIAj27njPTqQCdnZhWoqyH4Yt
         bzL4rTm5aXjvSi7EdC882mbVzJJ3g2IWl7kz6GjPpgiueX1272lnMMeFPm9M6R/EAryt
         x0W7mgBhFS40d3u4sIn+EBS/t0xbkqU+J9QLsFabXtsm2Zrt6fdQJ0/pXE4xqLNAiWub
         LVryViL3DI7yh7I26flVWDRmAkijgaDqcg42ZN66yrT5X5q+CKbRNp7JI18GFEtJGLif
         3axw==
X-Forwarded-Encrypted: i=1; AJvYcCXmGourWCT+533/jusNta5BRtjl6+2qm94IRePC3ucILO0089rS3sl81fFE5AnTPxfZYZYacWg02NMa@vger.kernel.org
X-Gm-Message-State: AOJu0YxiKQbVyPwDtNaLbCM1boCyUT6rMzD5Dq+O+9HxeOti0D06pajR
	2quh6iJeGOn/1IxuaAJUeCGWkkaLmMA2vrFOuvFdETg9YHtwoLOChxVrOIz8fUbTU6FVjuNTJy2
	BMCHsmqir9agGKscu1d9Li/saysNoUe4=
X-Gm-Gg: ASbGnctYsrg6/0bQMZTJP93FAdJQk8KYK7G7AgzPEN+4BGtB5xv5w+tanzlkxHugGKS
	BKxXLuPv83YTaLRgw+lTDdU4uHuqZaw+XihRldVK1eYhAd8SHPWjznP8MsH25XfPxL8TMZiOEgX
	mnT62N+iAmH6hvWBNtjaLzJekMtrwa62T7L2i4XFa004V7eoWUhnDh1nB9H+5/hke3z1P89zq5w
	PrT2EB4n1EV8aJBuLUE44CxNuUprqQVoOjrSdkgFQwIz3ln++dYGANh1URCpslqz3EyElI=
X-Google-Smtp-Source: AGHT+IHa9akAHnfXW7MjrEDntgAgmnsrMoOU0VMEeysg8ikJ47x2hE8nWs2Zn11ikMGKssYt6R8rrK0WBG76j7RjdQ8=
X-Received: by 2002:a17:903:198d:b0:297:d4e7:3066 with SMTP id
 d9443c01a7336-297e562ea48mr17028595ad.18.1762573695851; Fri, 07 Nov 2025
 19:48:15 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251107041002.2091584-1-kriish.sharma2006@gmail.com>
 <20251107153733.GA1859178@ziepe.ca> <c9c8b90f-4edb-47da-8ad0-94f9e58d71e0@nvidia.com>
 <20251107191736.GC1859178@ziepe.ca> <CAL4kbRO+p0f6cKLONf=qqTU32G2YCEtkgQpu6shX=zBeAa1vFA@mail.gmail.com>
 <1b9b26a0-ebc1-44d6-ab6e-ac49126bd6a9@nvidia.com>
In-Reply-To: <1b9b26a0-ebc1-44d6-ab6e-ac49126bd6a9@nvidia.com>
From: Kriish Sharma <kriish.sharma2006@gmail.com>
Date: Sat, 8 Nov 2025 09:18:04 +0530
X-Gm-Features: AWmQ_bktDRxKXHdnQRQkgDiqctnok3Lp4iS-hqmxZbQneqmRzpHV1JgL4zPlHao
Message-ID: <CAL4kbROVnD4BVB3=BuOCQ1=JUnD8UaZXJ2rV1Qaq1To6xvfofA@mail.gmail.com>
Subject: Re: [PATCH] RDMA/core: Fix uninitialized gid in ib_nl_process_good_ip_rsep()
To: Vlad Dumitrescu <vdumitrescu@nvidia.com>
Cc: Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>, Parav Pandit <parav@nvidia.com>, 
	Edward Srouji <edwards@nvidia.com>, linux-rdma@vger.kernel.org, 
	linux-kernel@vger.kernel.org, 
	syzbot+938fcd548c303fe33c1a@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Vlad, Jason,

Thanks for the confirmation. I=E2=80=99ve sent a v2 patch incorporating the
suggested check in ib_nl_is_good_ip_resp().

link to v2 : https://lore.kernel.org/all/20251108034336.2100529-1-kriish.sh=
arma2006@gmail.com/

On Sat, Nov 8, 2025 at 2:36=E2=80=AFAM Vlad Dumitrescu <vdumitrescu@nvidia.=
com> wrote:
> Can we have syzkaller test it?

It has been tested with syzbot, and no KMSAN or other alarms were raised.
Best regards,
Kriish

