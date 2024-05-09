Return-Path: <linux-rdma+bounces-2381-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B68D88C188A
	for <lists+linux-rdma@lfdr.de>; Thu,  9 May 2024 23:39:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E5D9C1C21988
	for <lists+linux-rdma@lfdr.de>; Thu,  9 May 2024 21:39:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2482D128820;
	Thu,  9 May 2024 21:38:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IluzAOm8"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-vk1-f178.google.com (mail-vk1-f178.google.com [209.85.221.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EB2B7FBBE;
	Thu,  9 May 2024 21:38:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715290727; cv=none; b=EYvrXs0QBqxpC5PMx7h4xCL9jtjKg7HEzavBLK8ZCl6IAMg/CVWKb4rMdUyE0kXUENTs0YVpPr7dfjbxt/lYnZaT8cMzTFJuYLq7T+zMpMYbdF79d5Mz52ZdP0OqOM4y1rAHkxFT3oXVuUPYYx8W0jx9FgpvtoC0rw4keFT6gOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715290727; c=relaxed/simple;
	bh=9NrpOMaXb9IZHzVgmR1XogNQf6JD+O7Gz/0hR5AmBeM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lWb4N48xgqu1nt0OyG3M+Mot8ZzdU5iM75bShKtR20Dbq18EzvZChYs7BXCk4pu2uUv/GFMlKswtKoiYEkweR3bNQ6Pq3sft7ozsbq8PTF2X4OILlLBDZEtR26z84n3u/uB9snHyeUdyGcA1iXbLq5n1VgxZpicQJrdzVbVSOJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IluzAOm8; arc=none smtp.client-ip=209.85.221.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f178.google.com with SMTP id 71dfb90a1353d-4df4016b3c9so504907e0c.1;
        Thu, 09 May 2024 14:38:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715290725; x=1715895525; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ZcXomuFTNs6kAOjv+oYFgSUhkraR2OB9WxwHOqU2kw0=;
        b=IluzAOm86GUXj5wiPoJJsbyot2kWu8ojleIJiM5T7sW70X72h3A6wS36Fyf8KY7CGL
         Q/VHUKRxqoSVP26gVY5GZwXth7lrP7GyCkKsPr1DasfVSlPERZIJ1sEyX6vGU9GdRVQ5
         5kVl4NYddr734STrSed8ZCiUtlAVsZSgu9Foeka57REr8uTQg85GEBi4WBT9Wl0bZAcX
         MEBjFKJkgavWP1g1twzbpVITbcAANmvSspl/RARD4BoFG7mIEOx4MR/Meesw3/X+Wno2
         mjymLFA4EMchRJsdYVLCFKJoXROuSB1WwycMjU2KxCUoYrnztX0kW74ogBn81xUB1LUo
         WOOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715290725; x=1715895525;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZcXomuFTNs6kAOjv+oYFgSUhkraR2OB9WxwHOqU2kw0=;
        b=dboOzGkTHbO+SyRYjONZ/R3Cb8zHML6XPKJt6FMWyHd+uoeWoRKp0uiYpUzELZEBir
         WcY9Ut830/cC9gJ/8TG4fiuoFaZhB6ETnX48lR152OurmDGfnV055aurZZRbCftwJVIx
         pYE3pngd2Sfz6hrDlwLWNyGOV8gREJp7XypI9mU6j6gcGz2Iv4UD+EVCL9QJ1OKBaPcr
         v5oxSeVI3viwOmk5mloV+hb8//iA0ja7SU4jccFhIlK0Nlw8Eej4w+P6KPR9O7pJ8SAM
         B8Vj3eImxAHfettkWYmOlZzu1r02t7WJ+vS6GbM7L2vrC468gnodjyMIZSS6ZL18CIsp
         5XJA==
X-Forwarded-Encrypted: i=1; AJvYcCU/eELKvbXOLD1rI63aR+fBpVgB7dnd1zB0N4btSVdcIv/CKKiTBAYSCvt/yL+V/z7TM5c3+/cxcxdQySxb9CFZYIsXTa7Nbxv9emOBDn5UF27ljQV67B/7w7YynSl1FecTObi2WWRQTaZinpj10jF6MLOOc5VD1DVTHWR2NX5L8Q==
X-Gm-Message-State: AOJu0YwotvHKVCcnkF0yQ8MYjgwnKSDg+VIyJgVN0YvntBSiAp+OJSRh
	6Lpf5eMJQ7oI6T/o9DKw6VzTk4RPvCPE8HAwjAwfCEeJzA4fZdE20z5x4IIvY0KL7q6w4XJWGcJ
	YHWNugoz23UcYzHFPvxdJlSiR144=
X-Google-Smtp-Source: AGHT+IGDPdAnAHFbOGEVVQfuthPYBDUFn04X97C8h8u5g41EhAQrrR+vQZTM+R921KKRTb5redHLdvkWlrvB0RI6wnw=
X-Received: by 2002:a05:6122:2a51:b0:4d8:75ca:8cbe with SMTP id
 71dfb90a1353d-4df8839a7cemr976657e0c.16.1715290725239; Thu, 09 May 2024
 14:38:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240507190111.16710-1-apais@linux.microsoft.com>
 <20240507190111.16710-2-apais@linux.microsoft.com> <Zjp/kgBE2ddjV044@shell.armlinux.org.uk>
 <CAOMdWSKfkT4K9MAOn-rL44pycHPhVDj4CtiYkru5y_s0S-sPeQ@mail.gmail.com>
 <20240508201654.GA2248333@kernel.org> <e9633d41d0d004db3ec6e2b6d9dcb95d029dbb94.camel@redhat.com>
In-Reply-To: <e9633d41d0d004db3ec6e2b6d9dcb95d029dbb94.camel@redhat.com>
From: Allen <allen.lkml@gmail.com>
Date: Thu, 9 May 2024 14:38:34 -0700
Message-ID: <CAOMdWS+WRC7KOqPUXJ88ikCDPS-6oZ0i6OFTUk95DFTfYtNZcA@mail.gmail.com>
Subject: Re: [PATCH 1/1] [RFC] ethernet: Convert from tasklet to BH workqueue
To: Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, "Russell King (Oracle)" <linux@armlinux.org.uk>, 
	Allen Pais <apais@linux.microsoft.com>, netdev@vger.kernel.org, jes@trained-monkey.org, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	kda@linux-powerpc.org, cai.huoqing@linux.dev, dougmill@linux.ibm.com, 
	npiggin@gmail.com, christophe.leroy@csgroup.eu, aneesh.kumar@kernel.org, 
	naveen.n.rao@linux.ibm.com, nnac123@linux.ibm.com, tlfalcon@linux.ibm.com, 
	cooldavid@cooldavid.org, marcin.s.wojtas@gmail.com, mlindner@marvell.com, 
	stephen@networkplumber.org, nbd@nbd.name, sean.wang@mediatek.com, 
	Mark-MC.Lee@mediatek.com, lorenzo@kernel.org, matthias.bgg@gmail.com, 
	angelogioacchino.delregno@collabora.com, borisp@nvidia.com, 
	bryan.whitehead@microchip.com, UNGLinuxDriver@microchip.com, 
	louis.peens@corigine.com, richardcochran@gmail.com, 
	linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-acenic@sunsite.dk, linux-arm-kernel@lists.infradead.org, 
	linuxppc-dev@lists.ozlabs.org, linux-mediatek@lists.infradead.org, 
	oss-drivers@corigine.com, linux-net-drivers@amd.com
Content-Type: text/plain; charset="UTF-8"

Paolo,

> On Wed, 2024-05-08 at 21:16 +0100, Simon Horman wrote:
> > * As this patch seems to involve many non-trivial changes
> >   it seems to me that it would be best to break it up somehow.
> >   To allow proper review.
>
> I would like to stress this latest point: it looks like the changes to
> all the drivers are completely independent. If so, you have to break
> the series on a per driver basis. Since the total number of patch will
> be higher then 15 (maximum size allowed on netdev) you will have to
> split this in several smaller series.
>

 Right, it's a valid point. Per-driver might not work. Depending on the
driver and changes, I will try and make it an independent series.

> Beyond making the change reviewable, it will allow eventually reverting
> the changes individually, should that cause any regressions.
>

Thank you, I understand the concern here. Will work on it in v2.

Thank you very much for your time and suggestions.

 - Allen

