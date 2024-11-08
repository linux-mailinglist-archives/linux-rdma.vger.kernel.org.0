Return-Path: <linux-rdma+bounces-5855-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AF1B19C1838
	for <lists+linux-rdma@lfdr.de>; Fri,  8 Nov 2024 09:40:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E17591C23208
	for <lists+linux-rdma@lfdr.de>; Fri,  8 Nov 2024 08:40:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F364D1DF753;
	Fri,  8 Nov 2024 08:40:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eYwheXCe"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42D2D1401B;
	Fri,  8 Nov 2024 08:40:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731055237; cv=none; b=iP8Mj3QNG0WCqdydGBvV/ylY3gTHNiEjHmTE8nTOdpeWfWtxFteyvS+ZLK5rJ/yw5xVYe1xCRHAT3B0Q5WYc1SthoTqHXSG+HUhQiRDsGswKr8qqRKaZWFVAdPkHBtWGUj5NofqtV2Ggo3Vsqsxyyf06cClSJANYzO+Dd4HCV1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731055237; c=relaxed/simple;
	bh=EM8Dh5tie9IEjjF8do6TDj51/7ihEIDXiOF4JLqHEzE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tA5M4NXkSjRCPhoH0MR2ORuN4wJR4aF33lov+yvzyAstnre4U2aSz0QK7euv+emPwpl5JMnz3qFvHds0N680oJM8U7DtrK1o2kwIS/OF8wXZeA9FIhGKHrmJvTwRFXZ+OK2pSwNhXOsm6KPBIwx0LBUuyUpgDZ+k4msmkFor+y0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eYwheXCe; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-6cbe3ea8e3fso11653816d6.0;
        Fri, 08 Nov 2024 00:40:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731055235; x=1731660035; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GL2lyjzT+FtKmh9gYSOJWQLwDI+A1zp6yGWbnO7Ggvk=;
        b=eYwheXCeeQKZPaodpm440B/3Caod+2STJZKD22nKdQ2aD3KQIOv+tMwnd/YOz4uqYW
         5/Dk/v8pfIz4CQPyzSxZ6ezt4UL+XcLQAcJLHkSgTnOguqVQqdHRYl6pfvQdYN1JXHSH
         J3LzdodT+6GDpdPf0Ht+Y5gbpAv8dSyVwkgvP1E4k3VKFGUCAhmvft47phs5k45EWDWV
         QHrRmF8GSfxifnA/LztxfjvkmSBtpjO0tfOVQ9B6irVGIRWecpHPT2ZlPtQVpIFHMGZi
         DsaWVYnm95qTJ1J2HS5dA3nqzWBlBaLn932K8bBMFNYU8Ysf2FRS2d4lHprZvRJiSDYo
         GrIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731055235; x=1731660035;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GL2lyjzT+FtKmh9gYSOJWQLwDI+A1zp6yGWbnO7Ggvk=;
        b=OgNagXL5ZDeuGyt7v2XEXMZYnUCz37Lg0Yn2aoNhSNdtamqxssKGcF5b8g+wnw/h6S
         Ot8jw0QWoHB+e5nve00wQLnm3xwrwynvetk3/Pk4xYTMlH5Kcp9w6S9gVN/zHT4xE2yv
         YuloDNJ6gTQ0r1RkCr1y5vMPgrA5kAvNtGO7+mGJN91/DDl3HcGW/ruCwdhCVtuLNvBa
         A9axEVQKEmt03k0yGC+uZFK+tmW607NsqEueLlBA8BkMLEvr/sClyoHgRAbAzKeDvxbr
         WO0LDV4xxoPbeSYUN/MF1OFNuDkyviiJ/CiOmc+Y5O0EBgVfBwEGQik/auejXnhCpU7N
         f7zg==
X-Forwarded-Encrypted: i=1; AJvYcCUbyd2dmk5yN3oLczch6qWt8BK7O/LP4N4++dMiLD8b0ZHA1aXR085oN6YClq0do2bY9ZhaOyiZ@vger.kernel.org, AJvYcCVlejGMbaJIG3N2zey5z+Kfw9LnlES0MU8+7AdJ7SB/yG9Wt3NtMPngi+yvAheXa9Em5x/DQc29QAWh@vger.kernel.org
X-Gm-Message-State: AOJu0YyNzDTxCIzWNzBC6m1LxcZhrKt411H52Y4869JA4H/+y3kFhhwv
	giBnegkkFbemiUoElgX/kS30WpVd3gju8QTZmj4tTq1QCG7yTbYImsN5se269ir7fenlMaSIQIo
	EK/gc6ByOxY0RhWOuWTnYODvDv1c=
X-Google-Smtp-Source: AGHT+IHZ9m+pYdCxXZGYug0M4ZN2U10Xit5mM96LDWUVDxWNPhA4yfTmGXUyjIwB3wWmfvdOeMJsIf9HI7EY/oaUyQ8=
X-Received: by 2002:a05:6214:570a:b0:6cb:ec7e:4fba with SMTP id
 6a1803df08f44-6d39e19782emr27465396d6.25.1731055235064; Fri, 08 Nov 2024
 00:40:35 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241106064015.4118-1-laoar.shao@gmail.com> <b3c6601b-9108-49cb-a090-247d2d56e64b@gmail.com>
 <CALOAHbDPbwH7vqV2_NAm=_YnN2KnmVLOe7avWOYG+Rynd295Vg@mail.gmail.com>
 <9b3af2dd-8b56-4817-b223-c6a85ba80562@nvidia.com> <20241106171717.1bf7331f@kernel.org>
In-Reply-To: <20241106171717.1bf7331f@kernel.org>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Fri, 8 Nov 2024 16:39:58 +0800
Message-ID: <CALOAHbB0Ura366LyxH2Buy=11bezbqB+4DZVnZRRo-=q=tMgpg@mail.gmail.com>
Subject: Re: [PATCH] net/mlx5e: Report rx_discards_phy via rx_missed_errors
To: Jakub Kicinski <kuba@kernel.org>
Cc: Gal Pressman <gal@nvidia.com>, Tariq Toukan <ttoukan.linux@gmail.com>, saeedm@nvidia.com, 
	tariqt@nvidia.com, leon@kernel.org, netdev@vger.kernel.org, 
	linux-rdma@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 7, 2024 at 9:17=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> wro=
te:
>
> On Wed, 6 Nov 2024 21:23:47 +0200 Gal Pressman wrote:
> > > It appears that rx_fifo_errors is a more appropriate counter for this=
 purpose.
> > > I will submit a v2. Thanks for your suggestion.
> >
> > Probably not a good idea:
> >  *   This statistics was used interchangeably with @rx_over_errors.
> >  *   Not recommended for use in drivers for high speed interfaces.
>
> FWIW we can change the definition. Let me copy paste below the commit
> which added the docs because it has the background.
>
> tl;dr is that I was trying to push drivers towards a single stat to
> keep things simple. If we have a clear definition of how rx_fifo_errors
> would differ - we can reuse it and update the doc. For example if
> rx_discards_phy usually means that the adapter itself is overwhelmed
> (too many rules etc) that would be a pretty clear, since rx_missed is
> supposed to primarily indicate that the host rings are full or perhaps
> the PCIe interface of the NIC is struggling. But not the packet
> processing.

Thanks for providing the background.
What do you suggest=E2=80=94should we report rx_discards_phy via
rx_fifo_errors and update the documentation accordingly?

--=20
Regards
Yafang

