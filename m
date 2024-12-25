Return-Path: <linux-rdma+bounces-6735-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6048D9FC392
	for <lists+linux-rdma@lfdr.de>; Wed, 25 Dec 2024 06:11:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B921D1645FA
	for <lists+linux-rdma@lfdr.de>; Wed, 25 Dec 2024 05:11:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCE7085628;
	Wed, 25 Dec 2024 05:11:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cyOAF9WZ"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-oi1-f194.google.com (mail-oi1-f194.google.com [209.85.167.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11A5F17BD5;
	Wed, 25 Dec 2024 05:11:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735103504; cv=none; b=dzPIeN0osLDkYBEgeWBFaz4Y7IMzulk1BYrtN6Gngz4ZjTP8drhRNgBcsiBtDjPkQr75GUcy76LD+/dVqRO1+9sNX5nbW/4w6KA7A5tB6dhkdlVMrFbXzMPfvpI7Gp7Wm9lRZ4RFTsfIK/qyEDB5SVt/VAV5NvnPdn6aYGMzkeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735103504; c=relaxed/simple;
	bh=MHUtLgX2FgZLkFvUWFMlj6dZEQCHyzGLF3sNfi4PujY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NXOR8NSurYbI9b+H5h9y8XL9ohGMs8m/XsZqsyWlpaGFyYbxMpzh97ZI+1hModnzTVjK4CoRT5dPXtpt523+em/Ybj6VuIDP3DN7h7RtS7FqUj0t0MxzyD22P/0OdDsHO2UFL83Idju6vHkR77R6byNneMMjM7MrtsgRd0vDbR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cyOAF9WZ; arc=none smtp.client-ip=209.85.167.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f194.google.com with SMTP id 5614622812f47-3eb9ba53f90so1404424b6e.1;
        Tue, 24 Dec 2024 21:11:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1735103501; x=1735708301; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h9y1NrjQdNnlewCnCtL0H5ZrmT/ffvt8WagiVTsajB4=;
        b=cyOAF9WZxctoHiaZKId80UzN0LhQnlI8RYx5NwP5bWVJTMxLMU47xrlO0yZFbS1M0K
         ev2vouzEh4BARvOq92gjNM6UN86R0pNu0E3o9jP3yZc/rRvYCRhc1LvqOaPvg7xY8457
         gLIN9/dywNj5JPxzG/Wlq7VbWo2GF7g7pgypm17OOJ9r9JRd/Lu7Wcqf7nLJprxO1SZT
         tv7OpFr8qCzTx6vjehnpMn0xo1O04rPc4Gy2afmN5VCgqQVpdsjk14TJTa07Y1R51JlM
         HC+OiChv+Hal1mO3/gzBSArUkwrTg9Y7orr9uzEWsqF/fhPMthvk/zgZEFYM++NQhQl6
         4npQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735103501; x=1735708301;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=h9y1NrjQdNnlewCnCtL0H5ZrmT/ffvt8WagiVTsajB4=;
        b=c6QDQmaiGT1E1cnMd6apqKN2BvwRK297vDFGf4IK6cjwjXmRtIdhHvAxmLjEk1SanW
         T/dlpqjy8poDGK0FXJvkqW/F8zSLxwHnUrxk2gY+7MnODdUpRPQFuFmlTLzwdpRntYi5
         jW6JFa8wx1UptNEmc29P0cm5aZqoNMn8Bx9dzZfTdymMyBFvNsCF9Xe7ZNYpWoZFS4aP
         m8phSGO4oRQK+E5TONN7BRPcP4GXe0u2AtzSMFOWpaUPNJLG6eoDWy2y2sKB90D2w8YO
         WRZjzFAnZc9/7VQKVXck1Fjx8Ebr60wJHEkuyhh5N6i3HFgdCPVDc99og4MV3JfX6QfC
         QhsA==
X-Forwarded-Encrypted: i=1; AJvYcCUoSYw4dFDg4QZLEGFpkYjF6XMQY6BGAAeudzFU9g/52Bo37a1KhY8n+1Gjl2jNb3QmE6aXPh67VHvphw==@vger.kernel.org, AJvYcCVhJZcZjNsc8tVsI3AEoDWgB81NqDQxMRNOFyxaKHUQgIDK5aqSkrAuTjl7KEuF8g1alnT4smtWOd7QTjg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9qcCZn58gMg6/ZcrkjJO5XL9T6Sa5OEK8wBooswIydsJtWwEd
	dnrFNs+Q9vMe1diCQiHjNOOuA7aPJ1Q715xzranLREXZk8KQ0hgGwvMUwxO6viUtUTu+ofZWStG
	ne53xkh1e5xecQ3xUUrAM3FLKE9M=
X-Gm-Gg: ASbGncutXlrrRwWp+aeUAsEmk7VPK+/QX5wcJWRiO1IGCmccIiKgVvmMkFDcAIlLMRl
	HDCpMkFNVnyLc46H3B0AGkKZT8VwYhg0IVrf4OA==
X-Google-Smtp-Source: AGHT+IGVQovdAvRvUckQB4uy/O6k2iiHlumwhgx2+GKqfg9m/blsQhN38+7tmZ53jnfaZ0wPWWuzYRqC4aqaMOz9xh0=
X-Received: by 2002:a05:6871:80cc:b0:29e:2bbd:51cb with SMTP id
 586e51a60fabf-2a7fb1619cdmr10529436fac.24.1735103501090; Tue, 24 Dec 2024
 21:11:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <8328f0ab-fbd8-5d43-fbb3-f2954ccbd779@praktifix.dwd.de> <7f0908c3-f730-4c5d-88d7-85677810082a@linux.dev>
In-Reply-To: <7f0908c3-f730-4c5d-88d7-85677810082a@linux.dev>
From: Joe Klein <joe.klein812@gmail.com>
Date: Wed, 25 Dec 2024 06:11:30 +0100
Message-ID: <CAHjRaAcO866yePi_XJdPm5R05bkyLVYyzzMRCbPNwko5d=rY1A@mail.gmail.com>
Subject: Re: failed to allocate device WQ
To: Zhu Yanjun <yanjun.zhu@linux.dev>
Cc: Holger Kiehl <Holger.Kiehl@dwd.de>, Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>, 
	linux-rdma@vger.kernel.org, linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Dec 21, 2024 at 9:38=E2=80=AFAM Zhu Yanjun <yanjun.zhu@linux.dev> w=
rote:
>
> =E5=9C=A8 2024/12/20 18:10, Holger Kiehl =E5=86=99=E9=81=93:
> > Hello,
> >
> > since upgrading from kernel 6.10 to 6.11 (also 6.12) one Infiniband
> > card sometimes hits this error:
> >
> >     kernel: workqueue: Failed to create a rescuer kthread for wq "ipoib=
_wq": -EINTR
> >     kernel: ib0: failed to allocate device WQ
> >     kernel: mlx5_1: failed to initialize device: ib0 port 1 (ret =3D -1=
2)
> >     kernel: mlx5_1: couldn't register ipoib port 1; error -12
> >
> > The system has two cards:
> >
> >     41:00.0 Infiniband controller: Mellanox Technologies MT28908 Family=
 [ConnectX-6]
> >     c4:00.0 Infiniband controller: Mellanox Technologies MT28908 Family=
 [ConnectX-6]
> >
> > If that happens one cannot use that card for TCP/IP communication. It d=
oes
> > not always happen, but when it does it always happens with the second
> > card mlx5_1. Never with mlx5_0. This happens on four different systems.
> >
> > Any idea what I can do to stop this from happening?
> >
> > Regards,
> > Holger
> >
> > PS: Firmware for both cards is 20.41.1000
>
> It is very possible that FW is not compatible with the driver. IMO, you
> can make tests with Mellanox OFED.
>
> If the driver is compatible with FW, this problem should disappear.

Thanks, Zhu. We have the similar problem and have been fixed by your soluti=
on.
We are in the same boat. Appreciate your help.

>
> Zhu Yanjun
>

