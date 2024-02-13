Return-Path: <linux-rdma+bounces-1017-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 91F88853665
	for <lists+linux-rdma@lfdr.de>; Tue, 13 Feb 2024 17:45:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B5D081C215A5
	for <lists+linux-rdma@lfdr.de>; Tue, 13 Feb 2024 16:45:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D27235EE87;
	Tue, 13 Feb 2024 16:45:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O5+1+hgK"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-oi1-f179.google.com (mail-oi1-f179.google.com [209.85.167.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF4C95FB9F
	for <linux-rdma@vger.kernel.org>; Tue, 13 Feb 2024 16:45:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707842724; cv=none; b=rveT/7vfxNWcOq8kjB0pF/1FGr9D6+KAVMbDal7SzTKMrjEM+/gAzllVeqjhRk9881+RJW4OCz83/4bMph1/INVDFcwcFmDOMeccvqnaqEMC8SZ0igySpYH31nFbPXzzISeT4xNk4yPlNksNlnt70JlZxcj9/2ei1t6bSAwIyJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707842724; c=relaxed/simple;
	bh=pSLYvSt/8PzUHgN5EUQ/2/pGtSesBtQ8YGMdRlgtWOo=;
	h=From:Content-Type:Mime-Version:Subject:Message-Id:Date:Cc:To; b=lr49khM4BhZ3u/kgcxiHZGNeZzng57yzKefAwLWX9RHiwr6iYo+Niia9+TYEck0xMNNL5trSW+/NeAn7pHdQUaUoY165DssRF+QNSmjTKr1MrPQHn2cL1BVYeEETnVPkc1zH8OfmAUve9zsZ9Vor7HxxPxi9AGnYLgw0qrquCxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O5+1+hgK; arc=none smtp.client-ip=209.85.167.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f179.google.com with SMTP id 5614622812f47-3bbbc6bcc78so3506513b6e.1
        for <linux-rdma@vger.kernel.org>; Tue, 13 Feb 2024 08:45:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707842722; x=1708447522; darn=vger.kernel.org;
        h=to:cc:date:message-id:subject:mime-version
         :content-transfer-encoding:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nEe68ag24mMYWM3bbVBncgAbH7koQp4AnIGrXE+SjA8=;
        b=O5+1+hgK7H2422HEt9TJySsNl2HB/iqNxxoJTI6WUAHKkb3dSvU/uEAFf+sfPVy0ZY
         QxxKQ4jkw9F1Xy8mXoRbtSc4PGLhniyctnu61tZphx9r+/YZbNobYK5DdQ3Op50DU1qP
         7AqxMjHHs96Th8oP4KikmQOXQHhlk+BTkhWRpDuHCPV92Me/F+YsjXOUM8IrpLqpk1Cu
         pzCEXbmXo0WbGt+9n71tvd99rhtSMMUxMpBA5A+CkIRag7uCWf3MF9vi9zcZtPNLBIYj
         B11inG30HL4fAItIMxqckgI5XZfA7+FOTL75sUmPxtNtj87V4+MzR8k4JwiWQbhsHaKp
         uRtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707842722; x=1708447522;
        h=to:cc:date:message-id:subject:mime-version
         :content-transfer-encoding:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nEe68ag24mMYWM3bbVBncgAbH7koQp4AnIGrXE+SjA8=;
        b=n5aJlLVyf1Nuafnmcmsf2P53KaXU8pzQe8S97nnxWhsB80Sh2XI/UgMCwFcB5B+xXS
         DwTwB/VS964uEn+8eHBm1m5d5RsXHAxIWVDn1oxVQuCQl4CG+qa3JMsfGkTtrMpMGsEz
         j8+laXL/Ojx05ykvAkuW9nEU2IjPZ2H0p81fnTYWlr3srRuBI5rZGVuISNh5dsUiNuXV
         gqfRPKSy9tnbpx+wMN+pygJEdA0mZOl9S9eEb5c9z/PmQP/jonrZvaF08CjvchhyUlyi
         LM4sX+/Q+7KsjYeSiNKw+JreiidZiKYErueFMesx6B4R+Nju6oGpE4PYYuJuHWuv2F+U
         bS+A==
X-Forwarded-Encrypted: i=1; AJvYcCUQnisNCK8FCvXBhUt8iPVDvvNfAOw/SY8eEkK8UY0zLyCohoE5fwC5h1SCZEKhBDgiIwFl0xexst7qnmuM4ED9VFwWvUPVnlbs+w==
X-Gm-Message-State: AOJu0YzcoTRUgf7AWObfuJ0zftZ2HIV5tsXT8d5+vZEC6+vlXtbmniQs
	ZXHWbUY3I47hahbtNaH9DhyJDnQz6mVzGzCeHsEqNBJNckEnoXEc9dhm6FZ7lS5Tyg==
X-Google-Smtp-Source: AGHT+IEuf5iS8Vx8DanuKIgU4FbGEJIj6+G22IkXrD3GypZTyagZjh8XfKzpks2sJLSlUj+0xH48dA==
X-Received: by 2002:a05:6808:138b:b0:3c0:31e5:35ff with SMTP id c11-20020a056808138b00b003c031e535ffmr10499706oiw.46.1707842721702;
        Tue, 13 Feb 2024 08:45:21 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXweElYj+2f0GiwObEZVUg2NF+yVlGbbslRKojHvN0hpqN3uqteOppziALd3skpqOIW9j1yzEPEPskDLiRlPCnAp/ipHzvsvOqZWSmgq+Fou3b3CxaNTDBW1BMhO+RBMYQyGabpNNSXf5oQOgEkMNbVQQdKXDkJiHNuWaJn7MLKMXFFMm3XEtgoqls4S3YckOHLLyRBaQ/uVShk30hu
Received: from smtpclient.apple ([2601:6c1:500:2c60:fd11:4656:46e2:ba24])
        by smtp.gmail.com with ESMTPSA id t20-20020a05680800d400b003bfe6ba810fsm485928oic.33.2024.02.13.08.45.20
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 13 Feb 2024 08:45:21 -0800 (PST)
From: Kevan Rehm <kevanrehm@gmail.com>
Content-Type: text/plain;
	charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.300.61.1.2\))
Subject: Re: Segfault in mlx5 driver on infiniband after application fork
Message-Id: <FC41CCD6-816F-4A59-9500-5759CDF736D2@gmail.com>
Date: Tue, 13 Feb 2024 11:45:09 -0500
Cc: Mark Zhang <markzhang@nvidia.com>,
 Leon Romanovsky <leon@kernel.org>,
 linux-rdma@vger.kernel.org,
 Yishai Hadas <yishaih@nvidia.com>,
 chien.tin.tung@intel.com,
 kevan.rehm@hpe.com
To: Jason Gunthorpe <jgg@ziepe.ca>
X-Mailer: Apple Mail (2.3774.300.61.1.2)

Newer kernels are detected and disable the DONT_FORK calls in verbs.
>=20
> rdma-core support is present since:
>=20
> commit 67b00c3835a3480a035a9e1bcf5695f5c0e8568e
> Author: Gal Pressman <galpress@amazon.com>
> Date:   Sun Apr 4 17:24:54 2021 +0300
>=20
>    verbs: Report when ibv_fork_init() is not needed
>=20
>    Identify kernels which do not require ibv_fork_init() to be called =
and
>    report it through the ibv_is_fork_initialized() verb.
>=20
>    The feature detection is done through a new read-only attribute in =
the
>    get sys netlink command. If the attribute is not reported, assume =
old
>    kernel without COF support. If the attribute is reported, use the
>    returned value.
>=20
>    This allows ibv_is_fork_initialized() to return the previously =
unused
>    IBV_FORK_UNNEEDED value, which takes precedence over the
>    DISABLED/ENABLED values. Meaning that if the kernel does not =
require a
>    call to ibv_fork_init(), IBV_FORK_UNNEEDED will be returned =
regardless
>    of whether ibv_fork_init() was called or not.
>=20
>    Signed-off-by: Gal Pressman <galpress@amazon.com>
>=20
> The kernel support was in v5.13-rc1~78^2~1
>=20
> And backported in a few cases.
>=20
> Jason

The above info was immensely helpful, and I am running MOFED =
23.10-OFED.23.10.0.5.5.1 so my kernel already has the fork improvements. =
 However, there are still issues, as the above requires all callers to =
check ibv_is_fork_initialized() before every call to ibv_fork_init.  Not =
everyone does this.

Routine ibv_get_device() unconditionally calls ibverbs_init() on the =
first call, and that routine calls ibv_fork_init() if either =
RDMA_FORK_SAFE or IBV_FORK_SAFE are set, even if the kernel has the fork =
enhancements.  I wrapped that check with a call to =
ibv_is_fork_initialized, and skipped the ibv_fork_init() call if =
IBV_FORK_UNNEEDED was returned.  This caused my little test program to =
run successfully, but the original benchmark still bombed.

The benchmark uses MPI.  It turns out that mpi4py calls PMPI_Init() =
which eventually makes UCX calls, and routine uct_ib_md_open() in UCX =
calls ibv_fork_init() without first calling ibv_is_fork_initialized.  =
It=E2=80=99s looking at some md_config->fork_init variable, not checking =
the kernel support.    In order to cover all potential cases, I changed =
my rdma patch to instead call ibv_is_fork_initialized() inside =
ibv_fork_init() itself, and return 0 without creating mm_root if kernel =
support is there.   This causes MPI and the original benchmark to work.

Is this a reasonable fix that could be added to rdma?

[root@delphi-029 libibverbs]# diff -C 5 memory.c.orig memory.c
*** memory.c.orig 2024-02-13 09:45:28.078997178 -0600
--- memory.c 2024-02-13 09:27:46.901699958 -0600
***************
*** 140,149 ****
--- 140,152 ----
huge_page_enabled =3D 1;

if (mm_root)
return 0;

+ if (ibv_is_fork_initialized() =3D=3D IBV_FORK_UNNEEDED)
+ return 0;
+
if (too_late)
return EINVAL;

fprintf(stderr, "ibv_fork_init creating mm_root\n");
page_size =3D sysconf(_SC_PAGESIZE);

