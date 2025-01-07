Return-Path: <linux-rdma+bounces-6871-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EA2FDA038E3
	for <lists+linux-rdma@lfdr.de>; Tue,  7 Jan 2025 08:38:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D2347164F4A
	for <lists+linux-rdma@lfdr.de>; Tue,  7 Jan 2025 07:38:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05CBB1662F1;
	Tue,  7 Jan 2025 07:38:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="PWBJOlhH"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AAEF194A7C
	for <linux-rdma@vger.kernel.org>; Tue,  7 Jan 2025 07:38:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736235502; cv=none; b=prRmWGe/QcPrYL0/lr8JVhWUX/bX51L6KidCXg1iXTctsSOrKD3Wdbwu0viXe00zPLuFBwmQFMGR/G2/bFB2UTsWoTmUyo2LZDquQztg9XDiTviHVW5btFLyyeLSntpLqSyFr4QMQK1jBF+9Jl1tYERUQoYPPbcu/UXL+CXjSek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736235502; c=relaxed/simple;
	bh=MeHjwlmHyRYJwqF55zIqyHrTafSLhdOwEGgkfNw2/cA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uY1fEPv2FXRU1KHuruVOWgE5CKbTM0i8fOif5mY1mIQvkctXkmSu4u4/5jEjbRU301q3fsqOTYNZJJwsMLovBaRYWUq4GZfRjVZ/cAvjVpyd2S3XLCy3VXYuKovUxhsWOuHaoPx3fqy386w0Bkt6tEjYMM4CD953uCk0CCZjFys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=PWBJOlhH; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5d44550adb7so3664209a12.2
        for <linux-rdma@vger.kernel.org>; Mon, 06 Jan 2025 23:38:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1736235495; x=1736840295; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+K5NTtkkHH0F4j1K3TcqwFsH8+ooT4rladtnvSGOOpM=;
        b=PWBJOlhHnrza5YuqS+/eAUU/E7AJYPJNX5NTjD4Jq2xbCGX9xjRHThB2uleP/MMWRb
         /uDWgRg+DmWDNfxN7jScC6fQ4X962sGfiWe8CwAQGm1i/4l4U8C7xyuKTCtPzbbo2Flg
         Ntg7KSCogu7U6uz8wOOHuKcYxTTR5ZShdc4f2yKUZYS1awUmzoLEb9cGOUP/749qxlPf
         WMfF42Q/nraqjamWDz/Ao9kYAwUFOX98dRqPTzyoDnRuvzRyQc1AfpLbdwnrG7/qAEPA
         lJkMTsjcS7f71L+OuyUEr1dmK/9b2wsByl18SqlIesLK5HXDw0Dm52A75CJbWNiO6Cwu
         +Smw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736235495; x=1736840295;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+K5NTtkkHH0F4j1K3TcqwFsH8+ooT4rladtnvSGOOpM=;
        b=J+tPr3pPy4E4sgW+3juIwmDH38h9z5Qk4u9StDU/opzgWk8N3S6bzho7b+Go5szogM
         4l15I1ORzguH8dc2hRShRmWNvmXjqMJy9cqtY09aPvt3odXd5O3mlgWPqKYUjHadrhsA
         VUzswvPBOLN7Zq+V/wGMqnzF/cT1jEP7J2YRxCBzbK79JrEKCwDxsZ/ClrDXTIeGtCd9
         Y9LhMa5iBEWn/zqr1sqdpgcQi6VcxL5UquyKAFpwMBZRp4rR9Dh3yNN+mjnWD5U4R7bp
         eizMgr3PkBQI5+dhkAHHGzeL/6Xwp1SvXr9Lk8hssJozYouQOR9B7bzbeVos/24Lsjoh
         NW1w==
X-Forwarded-Encrypted: i=1; AJvYcCUdpEXD+WseUu4glTe/Q81Kh6qvhathpf1wcX0VTXtX5gyyPifeDNrgCPH30a9LO6ySerVvWyx2IMUz@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+YCVLo4fSsPX2Al3VSA16Xmmhpv3MtMYW5A5Ggv9wAchFpaJT
	rJ7Y2H+CS2pP95BO7TiU0vIoJAexIK2o2hXGEC758lxaZqn6lBdM5P/whcLvMoNgGJeCxGZpeov
	1duuLxTE6VQgZp/kBwpO3uWhe6+ykuOg/H4JEzCioacQXxlddlKg=
X-Gm-Gg: ASbGncv5TmLnQL4/PR0hgdjdly4rkJi//W+gIzQk/KfNqyFu567yChfAewvDsC7+G4h
	zMfqS5Ry4MTin6fBGYwcXsIPLisTy/DnyOhJx2HX2CKYkBFI7lwlOQubG6z7ZZsgfMa3qKsU=
X-Google-Smtp-Source: AGHT+IH0yHgQYI52xxhkAl+Pv+y2nSjW7oz6dhILeey3Yd3VP16wJofS2RwX7ROj0q0KGDxt7BeW9iSgKHibBj84w+w=
X-Received: by 2002:a05:6402:5187:b0:5d0:bf79:e925 with SMTP id
 4fb4d7f45d1cf-5d81de07d1dmr19780495a12.6.1736235495597; Mon, 06 Jan 2025
 23:38:15 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250107060810.91111-1-lizhijian@fujitsu.com> <20250107060810.91111-2-lizhijian@fujitsu.com>
In-Reply-To: <20250107060810.91111-2-lizhijian@fujitsu.com>
From: Jinpu Wang <jinpu.wang@ionos.com>
Date: Tue, 7 Jan 2025 08:38:05 +0100
Message-ID: <CAMGffEnkqZSEts7Cu9pCUmi9uYtP-vgjQ4qPYkDdkZpG=A_HNw@mail.gmail.com>
Subject: Re: [PATCH blktests v4 2/2] tests/rnbd: Implement RNBD regression test
To: Li Zhijian <lizhijian@fujitsu.com>
Cc: linux-block@vger.kernel.org, shinichiro.kawasaki@wdc.com, 
	linux-rdma@vger.kernel.org, Jason Gunthorpe <jgg@ziepe.ca>, 
	Leon Romanovsky <leon@kernel.org>, "Md. Haris Iqbal" <haris.iqbal@ionos.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 7, 2025 at 7:08=E2=80=AFAM Li Zhijian <lizhijian@fujitsu.com> w=
rote:
>
> This test case has been in my possession for quite some time.
> I am upstreaming it now because it has once again detected a regression i=
n
> a recent kernel release[0].
>
> It's just stupid to connect and disconnect RNBD on localhost and expect
> no dmesg exceptions, with some attempts actually succeeding.
>
> rnbd/002 (Start Stop RNBD repeatedly)                        [passed]
>     runtime                   13.252s  ...  13.099s
>     start/stop success ratio  100/100  ...  100/100
>
> [0] https://lore.kernel.org/linux-rdma/20241223025700.292536-1-lizhijian@=
fujitsu.com/
>
> Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
Thx for the patch, LGTM
Reviewed-by: Jack Wang <jinpu.wang@ionos.com>
> ---
> V4:
>   - Fix a typo and update the passed condition # Shinichiro Kawasaki <shi=
nichiro.kawasaki@wdc.com>
>   - rename test_start_stop() to test_start_stop_repeatedly()
>
> V3:
>   - Always stop the rnbd regardless of the result of start
>
> V2:
>   - address comments from Shinichiro
>   - minor fixes
>
> Copy to the RDMA/rtrs guys:
>
> Cc: Jack Wang <jinpu.wang@ionos.com>
> Cc: Jason Gunthorpe <jgg@ziepe.ca>
> Cc: Leon Romanovsky <leon@kernel.org>
> Cc: "Md. Haris Iqbal" <haris.iqbal@ionos.com>
> ---
>  tests/rnbd/002     | 47 ++++++++++++++++++++++++++++++++++++++++++++++
>  tests/rnbd/002.out |  2 ++
>  2 files changed, 49 insertions(+)
>  create mode 100755 tests/rnbd/002
>  create mode 100644 tests/rnbd/002.out
>
> diff --git a/tests/rnbd/002 b/tests/rnbd/002
> new file mode 100755
> index 000000000000..7d7da9401974
> --- /dev/null
> +++ b/tests/rnbd/002
> @@ -0,0 +1,47 @@
> +#!/bin/bash
> +# SPDX-License-Identifier: GPL-3.0+
> +# Copyright (c) 2024 FUJITSU LIMITED. All Rights Reserved.
> +#
> +# Commit 667db86bcbe8 ("RDMA/rtrs: Register ib event handler") introduce=
d a
> +# new element .deinit but never used it at all that lead to a
> +# 'list_add corruption' kernel warning.
> +#
> +# This test is intended to check whether the current kernel is affected.
> +# The following patch resolves this issue.
> +#  RDMA/rtrs: Add missing deinit() call
> +#
> +. tests/rnbd/rc
> +
> +DESCRIPTION=3D"Start Stop RNBD repeatedly"
> +CHECK_DMESG=3D1
> +QUICK=3D1
> +
> +requires() {
> +       _have_rnbd
> +       _have_loop
> +}
> +
> +test_start_stop_repeatedly()
> +{
> +       _setup_rnbd || return
> +
> +       local loop_dev i j=3D0
> +       loop_dev=3D"$(losetup -f)"
> +
> +       for ((i=3D0;i<100;i++))
> +       do
> +               _start_rnbd_client "${loop_dev}" &>/dev/null
> +               # Always stop it so that the next start has change to wor=
k
> +               _stop_rnbd_client &>/dev/null && ((j++))
> +       done
> +
> +       TEST_RUN["start/stop success ratio"]=3D"${j}/${i}"
> +
> +       _cleanup_rnbd
> +}
> +
> +test() {
> +       echo "Running ${TEST_NAME}"
> +       test_start_stop_repeatedly
> +       echo "Test complete"
> +}
> diff --git a/tests/rnbd/002.out b/tests/rnbd/002.out
> new file mode 100644
> index 000000000000..2f055b8c82f9
> --- /dev/null
> +++ b/tests/rnbd/002.out
> @@ -0,0 +1,2 @@
> +Running rnbd/002
> +Test complete
> --
> 2.47.0
>

