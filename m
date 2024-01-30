Return-Path: <linux-rdma+bounces-806-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A1E0C8419A4
	for <lists+linux-rdma@lfdr.de>; Tue, 30 Jan 2024 03:53:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 111FB289B9B
	for <lists+linux-rdma@lfdr.de>; Tue, 30 Jan 2024 02:53:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 646A336B1C;
	Tue, 30 Jan 2024 02:53:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rUCjDFcT"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-vk1-f169.google.com (mail-vk1-f169.google.com [209.85.221.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 987BB36AFE
	for <linux-rdma@vger.kernel.org>; Tue, 30 Jan 2024 02:53:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706583192; cv=none; b=HoTG4B9yCIGNWMNYwllDykmNcNt3kJBVPiZBF7kwT6PH6FGoBFysZeN3K0avQxM8rjNTdQLmKlYZRYjzTFg0MRYjrm6UiGWXYWjS9P8DrVT+yQptlGEdz2XjrZ+fSk4ntYM2GbjjSrrv8e1YXuRwXc2gxI2smYhyMkyatP9oK7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706583192; c=relaxed/simple;
	bh=OOF/JDmoqHvxt3xDStMdND3Dl+I0UaElu3NVskxz6QI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iaLaBlzPemAhO8ggpyL2ELDyWeYVYu1PIw+lSIjfQMTdu/xMVtr+/0+SAS07lvQznvLRhLnQH0aUmV/uycb/29hM6ca1MhjCNPBmzxjGYNp+COxXoCpjmQ0FZdakNE1VoBlXN25m4vOgT7I5NCTy5ylDxh5pll1lC2k1yczWSBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=rUCjDFcT; arc=none smtp.client-ip=209.85.221.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-vk1-f169.google.com with SMTP id 71dfb90a1353d-4bd81be18a1so772721e0c.1
        for <linux-rdma@vger.kernel.org>; Mon, 29 Jan 2024 18:53:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706583189; x=1707187989; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=57LE80XzKkgz02q7vJPpQ7bcLsrc6ltxHobo6paNwmk=;
        b=rUCjDFcTCg+BfuzSHV0N88CKReKiYRpF1kdOUGx0toW5+M+XmZ7Gmhw02fSHY/kvOn
         b5909k6zYnPFcyXnwPe7dC/Mz+GE3imEwB4TrDo3NZ4KMEvA1XCfwQcih85h/vf7JkBA
         qMgaIr7DSsPuFzSugqiBjNNREUKYcTTgyWCC80QGPv70q4zELYhMTHgyh5aH9l14+4CK
         jj0mlmbIMqwOOBIJEzFz6AVcbZF4dtwsSsB7Zh1Repf9XLHUNq0MLbCHqEyZyvnZZDbE
         nkdbKcntVXOICuVNrMFWeT3vVoQkZ6dQvetir7spAvQC3kd2IQeMdQAM+wfuxpOxawBD
         F/8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706583189; x=1707187989;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=57LE80XzKkgz02q7vJPpQ7bcLsrc6ltxHobo6paNwmk=;
        b=osGhQMPemCqjK9dHkJ9bW9/xcNFJkvskTKfSaRdprr+yRZA4TgBePZJIGjU+CfXNsR
         wEwq2roYMIbr29luLNWWvldIVh0ENHcX/jjuyL6xnfbmgQmJ2QX/p9TR6fhaJDH64AKZ
         WaxZEq3PNbDLylpI3Sw0bpsV5CBQ5d052TBtzwaMIADpwl7cXLR8isjjPhpgSK+Vum8T
         m9xoRyCjLfKRX1SI8J2J8gpPZWV6Uu1CFPlF+hevj90GHqq1G9754YZpTdMW5qPfxHhk
         GAXNoMMpIQxOG2on5w+IUjOQFrT+t1zGLW8y2GXBMbgkLqP/VIcsAUL0zf0XH8eoHiDA
         5dBQ==
X-Gm-Message-State: AOJu0YwPQ2C9p5nPv982TQpaW67UAwkF8ggQlvA819Hp58EeZUfkypY3
	fMqFbaEIvlEUnQoTyzPEMj2ruLPW0yNOcuioDej/Dfy7hqwwBBbWUlPASIaIgIxzA/Nvb2MNf2v
	kodWcsxAWTL+T9qRp4Qq0ghSmgkY5GGkC9c2opSxeX3nSnwKLmVw=
X-Google-Smtp-Source: AGHT+IFPagv02V2zOXAR72eV7Vs2i0Z8fygeiffO01wqRFPgeSauIELXHJpdbzeVRYwyL5VmLdct4Vw6DioyPFoo6Q8=
X-Received: by 2002:a05:6122:288b:b0:4bd:73cb:e6d1 with SMTP id
 fl11-20020a056122288b00b004bd73cbe6d1mr3120076vkb.15.1706583189172; Mon, 29
 Jan 2024 18:53:09 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CA+G9fYvYQRnBbZhHknSKbwYiCr_3vPwC5zPz2NsV9_1F7=paQQ@mail.gmail.com>
 <2024012915-enlighten-dreadlock-54e9@gregkh>
In-Reply-To: <2024012915-enlighten-dreadlock-54e9@gregkh>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Tue, 30 Jan 2024 08:22:57 +0530
Message-ID: <CA+G9fYs3_M9E3w+uWky5X1hEgoJU4e92ECqSywerqSkF8KVGvA@mail.gmail.com>
Subject: Re: stable-rc: 6.1: mlx5: params.c:994:53: error: 'MLX5_IPSEC_CAP_CRYPTO'
 undeclared (first use in this function)
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-stable <stable@vger.kernel.org>, Netdev <netdev@vger.kernel.org>, 
	linux-rdma@vger.kernel.org, lkft-triage@lists.linaro.org, 
	Sasha Levin <sashal@kernel.org>, Leon Romanovsky <leonro@nvidia.com>, 
	Saeed Mahameed <saeedm@nvidia.com>, "David S. Miller" <davem@davemloft.net>, 
	Dan Carpenter <dan.carpenter@linaro.org>, Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"

On Mon, 29 Jan 2024 at 21:58, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Mon, Jan 29, 2024 at 09:17:31PM +0530, Naresh Kamboju wrote:
> > Following build errors noticed on stable-rc linux-6.1.y for arm64.
> >
> > arm64:
> > --------
> >   * build/gcc-13-lkftconfig
> >   * build/gcc-13-lkftconfig-kunit
> >   * build/clang-nightly-lkftconfig
> >   * build/clang-17-lkftconfig-no-kselftest-frag
> >   * build/gcc-13-lkftconfig-devicetree
> >   * build/clang-lkftconfig
> >   * build/gcc-13-lkftconfig-perf
> >
> > Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
> >
> > Build errors:
> > ------
> > drivers/net/ethernet/mellanox/mlx5/core/en/params.c: In function
> > 'mlx5e_build_sq_param':
> > drivers/net/ethernet/mellanox/mlx5/core/en/params.c:994:53: error:
> > 'MLX5_IPSEC_CAP_CRYPTO' undeclared (first use in this function)
> >   994 |                     (mlx5_ipsec_device_caps(mdev) &
> > MLX5_IPSEC_CAP_CRYPTO);
> >       |
> > ^~~~~~~~~~~~~~~~~~~~~
> >
> > Suspecting commit:
> >   net/mlx5e: Allow software parsing when IPsec crypto is enabled
> >   [ Upstream commit 20f5468a7988dedd94a57ba8acd65ebda6a59723 ]
>
> Something looks very odd here, as the proper .h file is being included,
> AND this isn't a build failure on x86, so why is this only arm64 having
> problems?  What's causing this not to show up?

As per the Daniel report on stable-rc review on 6.1, these build failures also
reported on System/390.

- Naresh

