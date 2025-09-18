Return-Path: <linux-rdma+bounces-13504-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DD810B86624
	for <lists+linux-rdma@lfdr.de>; Thu, 18 Sep 2025 20:08:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1D76817E8D5
	for <lists+linux-rdma@lfdr.de>; Thu, 18 Sep 2025 18:08:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C6412D027F;
	Thu, 18 Sep 2025 18:07:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PxclFLwb"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED7872D0611;
	Thu, 18 Sep 2025 18:07:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758218875; cv=none; b=cq7eSaEdaeWY9cOFsm/eo1aMjSMPwTZFqCXwezfZ3MuYonoNneEIgpUIB0lU9TEslf9giA81XxNmb5wsKvQrxr0zTByiDDq04f8WBZcCf04tP4jbSksFOfzx8GPxrzGCmj9xFbtfl/xJziisheBz/UQlMNtNrVmJ6AJEOvtUJl0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758218875; c=relaxed/simple;
	bh=YNevYmGrFg8ms4fHGj/XC+C4DFhAFFfn8I+VWFqP+KU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F0cqPhmB7r77CNTtGHyjJWNAhcgdl1FzGlt2G/a0R9yzb62rIpIvnardUwbcIyO7xg7kIFuTxhFFuCcGoH44xnuUly06XGogQneGLQ1qEcHmAP974ncUpeYg8CVKVmGeN3yrjHMcUPZKd98XeGwl9gGhzXWrzogr/+dVuybv9Bo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PxclFLwb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1800DC4CEFB;
	Thu, 18 Sep 2025 18:07:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758218874;
	bh=YNevYmGrFg8ms4fHGj/XC+C4DFhAFFfn8I+VWFqP+KU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PxclFLwb2uhaBdzRGwXa+VctRb8QOdwRB5UcCwBmlOfV+Te50DgMCykzJqAtrL4m6
	 Le57iTfcMEnp649AGoZxo7xOeOvUsrqkWifVY6Z0p81/6cOyENppG4RlAYQFgKQP5M
	 mZDXh8skyK+Z5/6nOBiKV/cWVoXD9wNnvi9kFzhvtcHzBzrRLHyuIF4K1CB8NW9OEp
	 mTLmI5zXe8ZQ9CJVWGBDgpQM/1Zq40AyI+iLK7r0siiNkHOFqVckCiW+VKFxwQD9Oq
	 Psf4uBgtqyApWfIuWqSqcRSEz4+6GtAomOK3dsPpi+XPeHyEw1Gnbu++jdm3APW3DT
	 4qXmbOSzQNjaw==
Date: Thu, 18 Sep 2025 21:07:50 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Abhijit Gangurde <abhijit.gangurde@amd.com>
Cc: brett.creeley@amd.com, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, corbet@lwn.net, jgg@ziepe.ca,
	andrew+netdev@lunn.ch, sln@onemain.com, allen.hubbe@amd.com,
	nikhil.agarwal@amd.com, linux-rdma@vger.kernel.org,
	netdev@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 00/14] Introduce AMD Pensando RDMA driver
Message-ID: <20250918180750.GA135135@unreal>
References: <20250903061606.4139957-1-abhijit.gangurde@amd.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250903061606.4139957-1-abhijit.gangurde@amd.com>

On Wed, Sep 03, 2025 at 11:45:52AM +0530, Abhijit Gangurde wrote:
> This patchset introduces an RDMA driver for the AMD Pensando adapter.
> An AMD Pensando Ethernet device with RDMA capabilities extends its
> functionality through an auxiliary device.
> 
> The first 6 patches of the series modify the ionic Ethernet driver
> to support the RDMA driver. The ionic RDMA driver implementation is
> split into the remaining 8 patches.
> 
> The user-mode of the driver is being reviewed at:
> https://github.com/linux-rdma/rdma-core/pull/1620

<...>

> Abhijit Gangurde (14):
>   net: ionic: Create an auxiliary device for rdma driver
>   net: ionic: Update LIF identity with additional RDMA capabilities
>   net: ionic: Export the APIs from net driver to support device commands
>   net: ionic: Provide RDMA reset support for the RDMA driver
>   net: ionic: Provide interrupt allocation support for the RDMA driver
>   net: ionic: Provide doorbell and CMB region information
>   RDMA: Add IONIC to rdma_driver_id definition
>   RDMA/ionic: Register auxiliary module for ionic ethernet adapter
>   RDMA/ionic: Create device queues to support admin operations
>   RDMA/ionic: Register device ops for control path
>   RDMA/ionic: Register device ops for datapath
>   RDMA/ionic: Register device ops for miscellaneous functionality
>   RDMA/ionic: Implement device stats ops
>   RDMA/ionic: Add Makefile/Kconfig to kernel build environment

This series generates CI warnings:
1. In my local CI

➜  kernel git:(rdma-next) yo ci
e81ec02df1e47 (HEAD -> rdma-next) RDMA: Use %pe format specifier for error pointers
In file included from ./include/linux/string.h:382,
                 from ./include/linux/bitmap.h:13,
                 from ./include/linux/cpumask.h:12,
                 from ./arch/x86/include/asm/paravirt.h:21,
                 from ./arch/x86/include/asm/cpuid/api.h:57,
                 from ./arch/x86/include/asm/processor.h:19,
                 from ./arch/x86/include/asm/timex.h:5,
                 from ./include/linux/timex.h:67,
                 from ./include/linux/time32.h:13,
                 from ./include/linux/time.h:60,
                 from ./include/linux/stat.h:19,
                 from ./include/linux/module.h:13,
                 from drivers/infiniband/hw/ionic/ionic_controlpath.c:4:
In function ‘fortify_memcpy_chk’,
    inlined from ‘ionic_set_ah_attr.isra’ at drivers/infiniband/hw/ionic/ionic_controlpath.c:609:3:
./include/linux/fortify-string.h:580:25: error: call to ‘__read_overflow2_field’ declared with attribute warning: detected read beyond size of field (2nd parameter); maybe use struct_group()? [-Werror=attribute-warning]
  580 |                         __read_overflow2_field(q_size_field, size);
      |                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
cc1: all warnings being treated as errors
make[6]: *** [scripts/Makefile.build:287: drivers/infiniband/hw/ionic/ionic_controlpath.o] Error 1
make[5]: *** [scripts/Makefile.build:556: drivers/infiniband/hw/ionic] Error 2
make[5]: *** Waiting for unfinished jobs....
make[4]: *** [scripts/Makefile.build:556: drivers/infiniband/hw] Error 2
make[3]: *** [scripts/Makefile.build:556: drivers/infiniband] Error 2
make[2]: *** [scripts/Makefile.build:556: drivers] Error 2
make[1]: *** [/tmp/tmp53nb1nwr/Makefile:2011: .] Error 2
make: *** [Makefile:248: __sub-make] Error 2

2. From kbuild

Unverified Error/Warning (likely false positive, kindly check if interested):

    ERROR: modpost: "__xchg_called_with_bad_pointer" [drivers/infiniband/hw/ionic/ionic_rdma.ko] undefined!

Error/Warning ids grouped by kconfigs:

recent_errors
`-- sparc-allmodconfig
    `-- ERROR:__xchg_called_with_bad_pointer-drivers-infiniband-hw-ionic-ionic_rdma.ko-undefined


