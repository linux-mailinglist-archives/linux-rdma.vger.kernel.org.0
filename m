Return-Path: <linux-rdma+bounces-13783-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id AF4A6BBDDF8
	for <lists+linux-rdma@lfdr.de>; Mon, 06 Oct 2025 13:32:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 05DA44E05B8
	for <lists+linux-rdma@lfdr.de>; Mon,  6 Oct 2025 11:32:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FDFF2652A6;
	Mon,  6 Oct 2025 11:32:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="S/A/w20Y"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E38C1CAA6C
	for <linux-rdma@vger.kernel.org>; Mon,  6 Oct 2025 11:31:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759750321; cv=none; b=QOkxenEWrsb+XDRxEpoyd2G0kSRmn77odhjwpG4OP6zSO3hyuQcJ0n/7pgXZKyEIYLVytoDI8gXIE7KHpjGPFPkANNkMqxX/GCZnl69TZm1gIvRxDmuu1OTprAlzHfKBP8nKtxerLtrUUjQxY0m7O4O8ViiOt9HVN0Iz+5ftah0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759750321; c=relaxed/simple;
	bh=e5CBSXrn4RtHdVZca6FSaw5ibW+hSpYdEP3TSjb1z80=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=U6c/BTYjYe48o2SLhhOvjcEs0fYEO69wvQ7tqsY1s2pKuZWnzkKRH68st18ZO1pLJaIPwRunoyoJ8uYuiAOpP+RylDU9FZaEwfYtAB0h0Q30Io+Cpt/tDlU2DG9P47HzOIpDetLEUb3o+v1oWktefzTs+iZ12VIDSzZeCw/cu+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=S/A/w20Y; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2698d47e776so38005805ad.1
        for <linux-rdma@vger.kernel.org>; Mon, 06 Oct 2025 04:31:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1759750319; x=1760355119; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=MCdUfSq56tzjd9BJmamnogQpujr952D9LtJP/K+DvPM=;
        b=S/A/w20YELdAPXUSmXi7Wlxl1HoO/Au9vya4EXq69dQE6cEjIKsO13B/XKhp9EEbky
         4AfZM3CbsGFvJlVpH7qUmtG72dt1TliYrbNQBtEusJJkIU/7hRgkPWVcuezCrRGHBJQ4
         YF7e1ZBEPuOlmSatcUSldUp+EhPqHri1mPkbu+w/JLtewkw74L+BYbm3LiKdMcvNKO1a
         1ugrk6A7JxtEkhyLPqOZdxMdwF1zxfC08NlOMSPd59m4qSzCnkLsrguk8bmLQ67oRvhO
         O6UuM7lsTXoDLJRbBTt1Rb4uRm2SqYak/NyQ1ab8wZpm3hV9jXOFDuLF5q8ExEQ+5hbO
         UxIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759750319; x=1760355119;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MCdUfSq56tzjd9BJmamnogQpujr952D9LtJP/K+DvPM=;
        b=dwlV504QHwkU3stHzwguHG5Aiv3DgcnVL4U5oNMJ9S8avfoKCtyMqNpwceoQj5PCoG
         3pA9DMMgboch8o5Zcv15QeBrKjXF/hMZTk0tuu6P5hixgHCC0G+zAVaDW5/c6pASxnrc
         5wGwH6raFzYZEfx0FCgzFJznMMh2jNfMrlQLx5BXp8uQOV9YjxMkgM9iZkQ+6SyZtQI6
         lGMXbmLk0GX5MVscwq8TssTynn39YkdzHkpXPUKOHHHRlBM93jZyzx6YNuztoUZ6LNAV
         GVeSS8AjT7BLzPdTD3iozs54lshitwNOdiIzEW0KfZsdVQ+nTCXThJLfqqmkQS1feW+B
         OktA==
X-Forwarded-Encrypted: i=1; AJvYcCXUXwWVMEoJ9Hrikf/wW2pDwIpQL1Yar5QdYHlouSm5Yp7Q9YpopM5CQo7kqkigUxTtpH8E+L5uqO0t@vger.kernel.org
X-Gm-Message-State: AOJu0YzWJPdYv6/k9D3TR9W/PxyB8ZgFrppg+pINyt03SyeBH2tbJyjv
	hKeRIk4QWLB+eVKlk2DZ7LaFr77LsTeLKGvKBEfo1W+uZwdhU59YI00kvsxQWuArhzE39WeuZKB
	am4Vn3cDAEfmwlRxCfHiwM3o2K2PPMkYZjf6bZU9ggNadjQ6bHgnAnxeqZA==
X-Gm-Gg: ASbGnctmXeCLh6CDinfMvsW25BcukZ8L013C8CfaTNztTCtc3J3LefpR1vRwsGL34OG
	b0EdaVR/dc4gQxGFncGLpSATiqsuAylBzJsr+ozMOC0pd1xKeFQbvr9eKRSjpWVtXj5sjsxnNZU
	jTaVva8CUBKo+2NfJRn0t6BC6Bw13Oa1zchtDW08VIm+uvWq+PLQ2vDsZmlw4lF5ohm/C2kkF9b
	icExJWd/Vb9eD8eBiyMGDRTMWrOgys7Uy7EoLzAy9DTBFuX0Z1O+OFnvNYR02jBz6PC+N8wdqH3
	L4CH2JUjRVsftc6CzO44seuAdLckhMVLRA==
X-Google-Smtp-Source: AGHT+IHk0BcyHGNjd8fw0KaD/j6uqPvdrOPp0sarkJmj00XawyQpO8GAec8OzHweFlDyK5jRXRrJR1iEX/aJ4XaNBSg=
X-Received: by 2002:a17:902:c94f:b0:267:b6f9:2ce with SMTP id
 d9443c01a7336-28e9a6dc5cbmr138177325ad.41.1759750318721; Mon, 06 Oct 2025
 04:31:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CA+G9fYu-5gS0Z6+18qp1xdrYRtHXG_FeTV0hYEbhavuGe_jGQg@mail.gmail.com>
In-Reply-To: <CA+G9fYu-5gS0Z6+18qp1xdrYRtHXG_FeTV0hYEbhavuGe_jGQg@mail.gmail.com>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Mon, 6 Oct 2025 17:01:47 +0530
X-Gm-Features: AS18NWB4sx-MUkILVHxbXiSvIkCbaL1n4-3C_QY4dTO4nEO29p1EMqNEWalh0DA
Message-ID: <CA+G9fYt+9QZ4TwEx7+m2S5Vtn7cq1N54oGceSR72upZJTrzkng@mail.gmail.com>
Subject: Re: next-20251002: arm64: gcc-8-defconfig: Assembler messages: Error:
 unknown architectural extension `simd;'
To: Netdev <netdev@vger.kernel.org>, 
	Linux ARM <linux-arm-kernel@lists.infradead.org>, 
	open list <linux-kernel@vger.kernel.org>, lkft-triage@lists.linaro.org, 
	Linux Regressions <regressions@lists.linux.dev>, linux-rdma@vger.kernel.org
Cc: Ard Biesheuvel <ardb@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
	Patrisious Haddad <phaddad@nvidia.com>, Michael Guralnik <michaelgur@nvidia.com>, 
	Moshe Shemesh <moshe@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>, Jakub Kicinski <kuba@kernel.org>, 
	Dan Carpenter <dan.carpenter@linaro.org>, Anders Roxell <anders.roxell@linaro.org>, 
	Ben Copeland <benjamin.copeland@linaro.org>
Content-Type: text/plain; charset="UTF-8"

+ linux-rdma@vger.kernel.org

On Mon, 6 Oct 2025 at 17:00, Naresh Kamboju <naresh.kamboju@linaro.org> wrote:
>
> [Resending with typo correction in the subject next tag]
>
> The arm64 defconfig builds failed on the Linux next-20251002 tag build due
> to following build warnings / errors with gcc-8 toolchain.
>
> * arm64, build
>   - gcc-8-defconfig
>
> First seen on next-20251002
> Good: next-20250929
> Bad: next-20251002..next-20251003
>
> Regression Analysis:
> - New regression? yes
> - Reproducibility? yes
>
> Build regression: next-20251002: arm64: gcc-8-defconfig: Assembler
> messages: Error: unknown architectural extension `simd;'
>
> Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
>
> ### Build error log
> /tmp/cclfMnj9.s: Assembler messages:
> /tmp/cclfMnj9.s:656: Error: unknown architectural extension `simd;'
> make[8]: *** [scripts/Makefile.build:287:
> drivers/net/ethernet/mellanox/mlx5/core/wc.o] Error 1
>
> Suspecting commit,
> $ git blame -L 269 drivers/net/ethernet/mellanox/mlx5/core/wc.c
> fd8c8216648cd8 (Patrisious Haddad 2025-09-29 00:08:08 +0300 269)
>          (".arch_extension simd;\n\t"
> fd8c8216648cd net/mlx5: Improve write-combining test reliability for
> ARM64 Grace CPUs
>
> ## Source
> * Kernel version: 6.17.0
> * Git tree: https://kernel.googlesource.com/pub/scm/linux/kernel/git/next/linux-next.git
> * Git commit: 47a8d4b89844f5974f634b4189a39d5ccbacd81c
> * Architectures: arm64
> * Toolchains: gcc-8
> * Kconfigs: defconfig
>
> ## Build
> * Build log: https://storage.tuxsuite.com/public/linaro/lkft/builds/33YUHcFKTLSBTOxNIJqF9vJqcxt/build.log
> * Build details:
> https://regressions.linaro.org/lkft/linux-next-master/next-20251003/build/gcc-8-defconfig/
> * Build plan: https://tuxapi.tuxsuite.com/v1/groups/linaro/projects/lkft/builds/33YUHcFKTLSBTOxNIJqF9vJqcxt
> * Build link: https://storage.tuxsuite.com/public/linaro/lkft/builds/33YUHcFKTLSBTOxNIJqF9vJqcxt/
> * Kernel config:
> https://storage.tuxsuite.com/public/linaro/lkft/builds/33YUHcFKTLSBTOxNIJqF9vJqcxt/config
>
> ## Steps to reproduce
>   - tuxmake --runtime podman --target-arch arm64 --toolchain gcc-8
> --kconfig defconfig
>
>
>
> --
> Linaro LKFT

