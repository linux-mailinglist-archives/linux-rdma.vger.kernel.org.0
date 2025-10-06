Return-Path: <linux-rdma+bounces-13781-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E261BBD5F9
	for <lists+linux-rdma@lfdr.de>; Mon, 06 Oct 2025 10:43:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BF8331894DCB
	for <lists+linux-rdma@lfdr.de>; Mon,  6 Oct 2025 08:44:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B385262FC2;
	Mon,  6 Oct 2025 08:43:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cJ8YUCzB"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E37E726158C
	for <linux-rdma@vger.kernel.org>; Mon,  6 Oct 2025 08:43:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759740216; cv=none; b=l5EpeigctGuQ8mcI/DPMfvKPl+ULBwMWzurVBqzFRFQ1/VeM1UapguELuY0779ifccFBBZHmmUyMEGbS0C+nbwnrd5d1387+uJushmeFHLI+yscItKjKhsTdxVfPhz38vMgm24PN8HXAUOLvSn8uokV4JCBiSA2WjvTs9bY03Ow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759740216; c=relaxed/simple;
	bh=0rqNTIzuAUmGUZmDFajGT6N8yRPrwxMpdo1LXU+gh4k=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=rE4S0y41cE6lrv9XBXqdGuApLzuEsmqDPQJK6QIS36w3FR2jbgT7QabqZgjEJ84yTk3/JEPB1htQIyPsfqtyU9P9uhsC9PNFW9zehpSehThefIpejwNaIyT5G5a+Oe22OXQ5wVbXGySNug47mi2TnywtFQloMnKbCw2DgkSdcG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=cJ8YUCzB; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-b62e7221351so1841902a12.1
        for <linux-rdma@vger.kernel.org>; Mon, 06 Oct 2025 01:43:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1759740214; x=1760345014; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=XbkOLsSeEc4de19QVHiox7c6UUo78PKyegeBXplGkhg=;
        b=cJ8YUCzBb5G9PfkgAPSMa4Iy5wp8EC8wwtX5dLd6yab9UyLYGfLtlB13fZ8tkOPFCj
         SsafTvLDf8M7ksnNllYQlRCCChJ5rrr0dDGXTAb0Ujq2BYRjhlDiWNEyOKNWN7t5mtzf
         oyKYAh525eoDu59Xd/ecekpQkJUuh0Uzbz5rrcSnAyvVda3GKVch8xj5XeQfGGqDTuq2
         wGgq82HHwMo8gpuB+CEk5x9Ri3FmQY4vlAHAcQ3gaa/mXcc471cdwegDcl6PFUGx2axn
         pRprrRAUGmyvYb+BE0GTSVrGay2gZa+hhYgmHtMAzg/PRe2Pydl6H7cUB+jJwS/WbZq8
         3rIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759740214; x=1760345014;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XbkOLsSeEc4de19QVHiox7c6UUo78PKyegeBXplGkhg=;
        b=F+zksrlYCT8JopxYeFn7+4ff3yLJIszRNv6/V6dagseg1bX3Js8j0W2D5YZcHUhcac
         HsbLezCHxeaxGRa/O0y4GGSsEvy2I1KkAPOS6yFhHfK2FsqnBbRRFMmKoSRmN5IcVXXC
         oKuTxdqQ0/Qq58iji1U/3FbUbanBsFtvSvnbLjSNDDezmncjErPOxoryBAm1FgdZueTJ
         WM3bDbfuQomGZ7jKaXjq/0euD79s2xT+pcP7OSMwTmFdWNkdxwTClw2dGQQ3KteN+rbt
         CQh2+elpF9FT4mWB/mSj6DU0O28UZFNlbjTkcVgWe2iMfN5OTUiA/BH8AhM6xMZSdaTY
         jFWQ==
X-Gm-Message-State: AOJu0YyvMLAmMyGwu73ixCyLrLunotZrNdAO1WrCJ2J2s30rJnKjn6Un
	YmmrBYjKH3lzQKgm5j4vIKKBgfBSlegLXPwRIQVmrSgNA02XYRo5hfZEyyaD77P4wgze0NYpTLW
	8/2npvXs2e85Q6hk//Ztkkoj6/tQLrBuZXJDqqPDo6ohc+Dp+p+0mMq6YpA==
X-Gm-Gg: ASbGncvPKnPFNDnuGJRDc0tUTBJcyy4VLdb05qIH02HTQVHzWDXbNakaryVRCdrhKOb
	x9GpCsp1SUKLKHvYF+SFY89603OB52jQDbb3VxejTZVULa0jWSEYRQJmnne6pCjehu2mKIpVo+j
	CLw43rN6b3MX7C6/Wy59QOdRdCfyl4W8Hqy6Fu2NdNmCTGXBLAUYLHxTXh0D/K87M7TeC4FZwvk
	x3gcgAfjglh8U1/i8QaJtvN7zEd4DvASiFXHJNkmJyp1cQ5zOW0KEjRXBHMxxgUF4N8ltTIHGio
	wl1HXaAtN4ojHwqg/kIGlw6PxsdiXcbRqgIO20rGmt0J4g==
X-Google-Smtp-Source: AGHT+IG70fTPRSenFkY+h0Ci4bsOWclGRtd5+NQm5QtlMXDZUWAfWyV7v3HpmAz+QpEftxA1fNt3+ZAYzqOOG5usHHU=
X-Received: by 2002:a17:903:2f4c:b0:27e:d4a8:56ad with SMTP id
 d9443c01a7336-28e9a6a2eb6mr138892325ad.61.1759740213842; Mon, 06 Oct 2025
 01:43:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Mon, 6 Oct 2025 14:13:22 +0530
X-Gm-Features: AS18NWA6yLhMUIQR5RWLa0LAv-ggCbP2Rb4RY4ONcT6ZxSvFVMy57u3jDGKEbJ4
Message-ID: <CA+G9fYsZvF1f25x10oL=Gs=+f_AFmaUFtUT8Qs1bXugEaJeoMA@mail.gmail.com>
Subject: next-20250102: arm64: gcc-8-defconfig: Assembler messages: Error:
 unknown architectural extension `simd;'
To: linux-rdma@vger.kernel.org, Netdev <netdev@vger.kernel.org>, 
	Linux ARM <linux-arm-kernel@lists.infradead.org>, 
	open list <linux-kernel@vger.kernel.org>, lkft-triage@lists.linaro.org, 
	Linux Regressions <regressions@lists.linux.dev>
Cc: Ard Biesheuvel <ardb@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
	Patrisious Haddad <phaddad@nvidia.com>, Michael Guralnik <michaelgur@nvidia.com>, 
	Moshe Shemesh <moshe@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>, Jakub Kicinski <kuba@kernel.org>, 
	Dan Carpenter <dan.carpenter@linaro.org>, Anders Roxell <anders.roxell@linaro.org>, 
	Ben Copeland <benjamin.copeland@linaro.org>
Content-Type: text/plain; charset="UTF-8"

The arm64 defconfig builds failed on the Linux next-20251002 tag build due
to following build warnings / errors with gcc-8 toolchain.

* arm64, build
  - gcc-8-defconfig

First seen on next-20251002
Good: next-20250929
Bad: next-20251002..next-20251003

Regression Analysis:
- New regression? yes
- Reproducibility? yes

Build regression: next-20250102: arm64: gcc-8-defconfig: Assembler
messages: Error: unknown architectural extension `simd;'

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

### Build error log
/tmp/cclfMnj9.s: Assembler messages:
/tmp/cclfMnj9.s:656: Error: unknown architectural extension `simd;'
make[8]: *** [scripts/Makefile.build:287:
drivers/net/ethernet/mellanox/mlx5/core/wc.o] Error 1

Suspecting commit,
$ git blame -L 269 drivers/net/ethernet/mellanox/mlx5/core/wc.c
fd8c8216648cd8 (Patrisious Haddad 2025-09-29 00:08:08 +0300 269)
         (".arch_extension simd;\n\t"
fd8c8216648cd net/mlx5: Improve write-combining test reliability for
ARM64 Grace CPUs

## Source
* Kernel version: 6.17.0
* Git tree: https://kernel.googlesource.com/pub/scm/linux/kernel/git/next/linux-next.git
* Git commit: 47a8d4b89844f5974f634b4189a39d5ccbacd81c
* Architectures: arm64
* Toolchains: gcc-8
* Kconfigs: defconfig

## Build
* Build log: https://storage.tuxsuite.com/public/linaro/lkft/builds/33YUHcFKTLSBTOxNIJqF9vJqcxt/build.log
* Build details:
https://regressions.linaro.org/lkft/linux-next-master/next-20251003/build/gcc-8-defconfig/
* Build plan: https://tuxapi.tuxsuite.com/v1/groups/linaro/projects/lkft/builds/33YUHcFKTLSBTOxNIJqF9vJqcxt
* Build link: https://storage.tuxsuite.com/public/linaro/lkft/builds/33YUHcFKTLSBTOxNIJqF9vJqcxt/
* Kernel config:
https://storage.tuxsuite.com/public/linaro/lkft/builds/33YUHcFKTLSBTOxNIJqF9vJqcxt/config

--
Linaro LKFT

