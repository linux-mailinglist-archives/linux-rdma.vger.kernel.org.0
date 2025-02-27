Return-Path: <linux-rdma+bounces-8193-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AE638A48C78
	for <lists+linux-rdma@lfdr.de>; Fri, 28 Feb 2025 00:13:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5EC031890A2A
	for <lists+linux-rdma@lfdr.de>; Thu, 27 Feb 2025 23:13:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FE5C272934;
	Thu, 27 Feb 2025 23:13:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XipCgQP5"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7A76272913
	for <linux-rdma@vger.kernel.org>; Thu, 27 Feb 2025 23:13:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740697984; cv=none; b=haYDvTt27pVXJpmLFDduo2d7j9Y0Z9YTYra9R7li2YdTzeqz5im5L0TzrCsqFFX+FJ8Aaaa6gzu092Bam8TnuUSspnD74fjP2fcFogbAiq++BwRIa+ikS/624nYCIqf0CVznifSH1lFECmLAYvQRupOORcTpL2JopWuoVsuIxoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740697984; c=relaxed/simple;
	bh=VrMyULN9yRhX0362jZvsXqzL/blFpYThDTo1AkO/c30=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=E9MvKPOHO8lASXYiEqgkbOoNseYXmimB80+Qnj4/eYxg+1ZdkuunPl9VxmFUWfRykdue9zl4qpaNFYIEFHp1cE/WLCH4XPkW2KSdr+yzzoFKVpA2h2Z9MFnHuYzPSFf4Cnr5Ta4FHymzo/4OHwnpgGGwO7U+m7RnkcdXOdK94YA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=XipCgQP5; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-54524740032so1480003e87.3
        for <linux-rdma@vger.kernel.org>; Thu, 27 Feb 2025 15:13:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740697981; x=1741302781; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YmkybCOSFne6yK3kY+Du84AtHtcKYiWZlsF8gbRhEyU=;
        b=XipCgQP5AMF9HQZrYR98rzjGwiwORxjbfuqc08WQYkF5sJfbva3dXBMA18/bZAYruq
         lYzFIm066i1nKA/I7Wzwj6MRBy+0n/39lK+vm6FC6CVRgGDu7WVqIrB8ipuDCvhsn2zX
         gv0fpICwmOY5QulyxYLrcoOFj5IBGXjw4THDC8H5KzFtAVKQ4BSA0oM7EMfJbsaTTsxD
         VZVNpjtUVnbHGmSynxMcIgz16aEeDQ4C2vuh5WGjDtLxJlH3J37QUF3px8FPH2CV6ejF
         XHzz6NQx80JJCWwT0F7ydmGCbLFt4WTzVd+9gutJtxv6qDO2V0i8yvXAaddp2Q2ZPUFr
         Z/gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740697981; x=1741302781;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YmkybCOSFne6yK3kY+Du84AtHtcKYiWZlsF8gbRhEyU=;
        b=tmf/DroCt0AzXdoQhPRMtvCtAcunXruTryHYR5e/Obkf3U+NAEqh7rLnpK2/77fVMz
         y6XzQTxqH0MRgN7TbH19xWaMByzAuhdo5tvb36BMmWLwWfq7SlSPYIOWeH9cxjGeCFSB
         Kmq69ukY+6A9guagXjk1aA5JLjqNwjynoclG6AZXxXVk1ek3StmiKRwQAuCgfWELvoHO
         1+bMvo+c8Eo/FTzpr8pZQm8XTChkiW4UExQyjCnTWG4popf+LNRsTmTP2pV4iXuSyPvX
         sIPLjZAkEtU9kqEaWRT6I9Y2VVHKxuwbyCPIDMfx2XVRUC/4uUGKM6TC2rhispSanXYe
         EsXA==
X-Forwarded-Encrypted: i=1; AJvYcCVGe7s7c8GiztjgAg3M/PVe7Q2XFskHay0WRDiioyRhMeYy1VB84KNr3JrdIufGcYoB4HvYbyrFhsS9@vger.kernel.org
X-Gm-Message-State: AOJu0YxKnYLr5FGYx/YqzCqq6UkyKShMQjbFvlZ/8jmXXPRyzJdRVZaZ
	BXwKRcGu5cOZx4M9CskQB3lRCQwsJ8dXxnjDs7Ttup9uS36AktyvxoBK47U3f2lNmZ2GWYAgBJ0
	GdICok9+KFcT4KssQAha8faHfAtAVhTZv3tUdxA==
X-Gm-Gg: ASbGnctabn4ArJh5qPPd8NNIsC65Xvkzx9fEgvsnxcaBOfRMF92vaEfRpEb7BqkgcYt
	zQfV8Y7NtgLhB5LUl1cy5NUGfWiBkzas91RzmmLR4XmSXKzu8aDYjVEJ+eeHh/pzrMCQWUM9eHu
	MBMTol7Tc=
X-Google-Smtp-Source: AGHT+IHLcUchRQ5RHejMZKQOgPdGa2RgldlYInULBrGmDbyHiaxGOnJDGcYbTPdwNuvGN5wuzKGCGgT0iWuzwLntJq0=
X-Received: by 2002:ac2:4e0e:0:b0:545:2fa9:8cf5 with SMTP id
 2adb3069b0e04-5494c354e58mr578980e87.49.1740697980909; Thu, 27 Feb 2025
 15:13:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250221-rmv_return-v1-0-cc8dff275827@quicinc.com> <20250221-rmv_return-v1-15-cc8dff275827@quicinc.com>
In-Reply-To: <20250221-rmv_return-v1-15-cc8dff275827@quicinc.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Fri, 28 Feb 2025 00:12:48 +0100
X-Gm-Features: AQ5f1Jra6Y1TNly1NYmSkFPtENvNIwlGHtsux17X3bXg-g3qhlo7h9G9hMQoxr8
Message-ID: <CACRpkdZV4EHGxYrX77FgsZvPrHohCEixXX6dkEoVSYSsaAzbYg@mail.gmail.com>
Subject: Re: [PATCH *-next 15/18] mfd: db8500-prcmu: Remove needless return in
 three void APIs
To: Zijun Hu <quic_zijuhu@quicinc.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Will Deacon <will@kernel.org>, 
	"Aneesh Kumar K.V" <aneesh.kumar@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Nick Piggin <npiggin@gmail.com>, Peter Zijlstra <peterz@infradead.org>, Arnd Bergmann <arnd@arndb.de>, 
	Thomas Gleixner <tglx@linutronix.de>, Herbert Xu <herbert@gondor.apana.org.au>, 
	"David S. Miller" <davem@davemloft.net>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Danilo Krummrich <dakr@kernel.org>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Johannes Berg <johannes@sipsolutions.net>, Jamal Hadi Salim <jhs@mojatatu.com>, 
	Cong Wang <xiyou.wangcong@gmail.com>, Jiri Pirko <jiri@resnulli.us>, 
	Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>, Bartosz Golaszewski <brgl@bgdev.pl>, 
	Lee Jones <lee@kernel.org>, Thomas Graf <tgraf@suug.ch>, Christoph Hellwig <hch@lst.de>, 
	Marek Szyprowski <m.szyprowski@samsung.com>, Robin Murphy <robin.murphy@arm.com>, 
	Miquel Raynal <miquel.raynal@bootlin.com>, Richard Weinberger <richard@nod.at>, 
	Vignesh Raghavendra <vigneshr@ti.com>, Zijun Hu <zijun_hu@icloud.com>, linux-arch@vger.kernel.org, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	linux-crypto@vger.kernel.org, netdev@vger.kernel.org, 
	linux-wireless@vger.kernel.org, linux-rdma@vger.kernel.org, 
	linux-gpio@vger.kernel.org, linux-pm@vger.kernel.org, iommu@lists.linux.dev, 
	linux-mtd@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 21, 2025 at 2:03=E2=80=AFPM Zijun Hu <quic_zijuhu@quicinc.com> =
wrote:

> Remove needless 'return' in the following void APIs:
>
>  prcmu_early_init()
>  prcmu_system_reset()
>  prcmu_modem_reset()
>
> Since both the API and callee involved are void functions.
>
> Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

