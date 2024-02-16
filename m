Return-Path: <linux-rdma+bounces-1037-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 046BF858673
	for <lists+linux-rdma@lfdr.de>; Fri, 16 Feb 2024 20:57:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 286C81C20E42
	for <lists+linux-rdma@lfdr.de>; Fri, 16 Feb 2024 19:57:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A99BA1369A9;
	Fri, 16 Feb 2024 19:57:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X1VGHrwS"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-oi1-f175.google.com (mail-oi1-f175.google.com [209.85.167.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0227E320F
	for <linux-rdma@vger.kernel.org>; Fri, 16 Feb 2024 19:57:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708113432; cv=none; b=QpDtdO+Zyrlz/EHapndtJOztx2ODc9KXy3ZLgod1oox9/WjjLmgJRgchNrf+z34zMez90gzySYwYTfAJIT023krpXxDDg8yMk+PsP7/G/hmrmeuaW+g/nc466RpXKVfdo1290LI/mT5bB5aensVjy/I8jBXZ/WHyci4lV4E/JMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708113432; c=relaxed/simple;
	bh=0LebUfHjcpowRmQq1/6lSbsFovF9fY12gBKkCg2sNOg=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=AAcjSTR2vsirwZkCg7PAuO5HGcWsOdyef/j5fjbtpDVeIUA1jP9rj9U7HuOQXG6UPUOVf2aHZT18dJaj7L+Ej6YhDXwLBepAjmYRGNbmk5/kRJfuuWJ/oQBBYGv4WmTY17ieHIpTkNYD/WEhl32pNj1OGdEEZrBWi5DUNgVHKBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X1VGHrwS; arc=none smtp.client-ip=209.85.167.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f175.google.com with SMTP id 5614622812f47-3c03b92998eso1880047b6e.3
        for <linux-rdma@vger.kernel.org>; Fri, 16 Feb 2024 11:57:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708113430; x=1708718230; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=azLhwnyjCmg1DzB9v8cmittJKRjJLvaIdM5oGlc9mys=;
        b=X1VGHrwS40YQ0AX1HXRKP3nWOCXm4cKcosAcL2KQDxCIx1ILmn2hCg292FqIIcHBif
         Jak0yCeAFmpSFj6CDuu4nadPizIn3aUjebbpDZMELD7iksaqwd5tHM9uN9QHoC7jo6h9
         jeJ4UMln8bxtbk9+3R1aBujxM3oN7YC4eRTy35NVUZqzb7tJeLnpY9G4XdXdnV7Elclk
         DIkvxsau6fnsfmbKnA+rtM6KHfUNCGBHej4XGJ8n4DVXgnNzAEg0A0Elh9I3P3o8KAQj
         PCqswbw49tLYOLsgc1zjiT7Ped/TQqktliPUgFYhlLgdcaIVP2gleTQSpUUp+43Ead7K
         A2uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708113430; x=1708718230;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=azLhwnyjCmg1DzB9v8cmittJKRjJLvaIdM5oGlc9mys=;
        b=LCAmHU3XP2D/oEx5TEJvt2wf/vEKJPmgIOMdMsG0bAXwTP059+ozSotouNu7OmJ+DB
         yukvWkwc69vi9rZtnCXqRNmaSaT0oKLgQsuNTD9Wi23a3aPZLe0k3VWxOgFaYV9PLxns
         Bj9SZY0+8WZsBG4igDvjRTYVkl4Giye6S021ltvqMLivFfMKxj+xlyeivfuMNwLbD4a1
         5YaxEeHPoriwr9jinFP4/2opUR0B+pVVsV7VOM2ixZBf8uFLDT8Gf7ZFVyg7hzoe+DGl
         HmBjvO/UdM7qsbXAfVduDkmPL3t5Pk19uNYlnOcMKlyJ0Vlmqs/DdgM1+JidLJSDGEdV
         npDQ==
X-Forwarded-Encrypted: i=1; AJvYcCXoilB3jLKkX6nrqoA2PvSq0SQSIEMa8IIy4wyMCm8E69wIAffjt6VNUDeQPKR7dWxzJ8h9Sietus3BMoORu02/BU7tsHFNQXJYDw==
X-Gm-Message-State: AOJu0YyrHC2CPAHstoVGYQGTIprtA2/s9Rn7amVtnQmXd3o8xC4lGYPz
	DGAvWJdCI7afOnSOlNppSq7sJH77guxXhm/q4Zfukw4xnoxffKH3
X-Google-Smtp-Source: AGHT+IGmSbFoDW+PYivn2r2qvbuClkLYWXb2LQbXUyqcwvnEfSETyTPLrJJb1IIYqoGltbNilmtS0Q==
X-Received: by 2002:a05:6870:440e:b0:21a:2944:5e68 with SMTP id u14-20020a056870440e00b0021a29445e68mr6142901oah.48.1708113429854;
        Fri, 16 Feb 2024 11:57:09 -0800 (PST)
Received: from smtpclient.apple ([2601:6c1:500:2c60:ad27:7f92:1374:d116])
        by smtp.gmail.com with ESMTPSA id eb46-20020a056870a8ae00b0021e17b6f410sm131382oab.44.2024.02.16.11.57.08
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 16 Feb 2024 11:57:09 -0800 (PST)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.300.61.1.2\))
Subject: Re: Segfault in mlx5 driver on infiniband after application fork
From: Kevan Rehm <kevanrehm@gmail.com>
In-Reply-To: <20240212164533.GG765010@ziepe.ca>
Date: Fri, 16 Feb 2024 14:56:56 -0500
Cc: Mark Zhang <markzhang@nvidia.com>,
 Leon Romanovsky <leon@kernel.org>,
 "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
 Yishai Hadas <yishaih@nvidia.com>,
 kevan.rehm@hpe.com,
 chien.tin.tung@intel.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <54DF121B-B413-4977-9F57-FCEB92FF4BB9@gmail.com>
References: <3CAF66C4-32E1-4258-9656-D886843D7771@gmail.com>
 <20240212133303.GA765010@ziepe.ca>
 <8BB93F6F-14EC-4B43-B1F0-5FE185A64073@gmail.com>
 <20240212144013.GD765010@ziepe.ca>
 <53992378-7BB2-4E8C-BD3F-8A2B1FC837BD@gmail.com>
 <20240212161238.GF765010@ziepe.ca>
 <0BC5DF9E-53A2-4224-8EDE-87B4F2407D56@gmail.com>
 <20240212164533.GG765010@ziepe.ca>
To: Jason Gunthorpe <jgg@ziepe.ca>
X-Mailer: Apple Mail (2.3774.300.61.1.2)

>=20
> Newer kernels are detected and disable the DONT_FORK calls in verbs.
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

To work around this, I had to use gdb on my benchmark to set a =
breakpoint in ibv_fork_init() in order to track down all the callers of =
that function, which turned out to be both UCX and Libfabric.  I then =
had to download source repos, examine the code, and for each repo =
determine what environment variable controls the calls to =
ibv_fork_init().  For Libfabric I had to ensure that RDMA_FORK_SAFE and =
IBV_FORK_SAFE were not set, which my team members routinely use.  For =
UCX I had to set UCX_IB_FORK_INIT=3Dno, otherwise by default UCX always =
calls ibv_fork_init.   With UCX_IB_FORK_INIT set to no, scary error =
messages about registered memory corruption print to stderr whenever =
there is a fork, even though that=E2=80=99s not true any more with =
up-to-date kernels.   Folks that don=E2=80=99t know the details of =
ibv_fork_init() behavior are going to be reluctant to set =
UCX_IB_FORK_INIT=3Dno.

If ibv_fork_init() would check the kernel and just return without =
initializing mm_root when the kernel has enhanced fork support, then all =
the environment variable hassles go away, the environment variable =
settings don=E2=80=99t matter, ibv_fork_init() will always do the right =
thing.  This seems like a big win to me, am I missing some downside =
perhaps?

Thanks, Kevan





