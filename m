Return-Path: <linux-rdma+bounces-6268-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0921D9E5102
	for <lists+linux-rdma@lfdr.de>; Thu,  5 Dec 2024 10:17:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B8FB7287D54
	for <lists+linux-rdma@lfdr.de>; Thu,  5 Dec 2024 09:17:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 967461D54FE;
	Thu,  5 Dec 2024 09:17:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CIhxntrY"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 531921D5144;
	Thu,  5 Dec 2024 09:17:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733390230; cv=none; b=Pr1rcJaI5699fp0K+w+9m53SNDuqpclAft7wVclGtm8Owouy2N9QkcbRgfwX+XTTt3PQ11wLlAtQOMweulInGZkcGuup8EJkwjr7/XlnxiMt901Kr6KgzJMiweWu058NRBYpS5E4oqIHBTqM/gPT/jSSTKtnfMHK9jtwNjlBbaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733390230; c=relaxed/simple;
	bh=JoR9zv5U1zLSf1+NY4SjdMS+lbxT9iCKPsKkj/thgSg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a/v4KQGxvPZqRlVNyajP7dZdeeQjI2bKn604YfozJ9T6lX03PAToUvxjJJv3+9mqqxdFXDvrZhlVdOhBXe1hm7opxUFOHaVtw0tWD0fBQr8grLKtXHrYX7uBhjTBt3pTyq1VlB1mjsPBMykfV9ru9jlLmcKXZ7MN24PUm/Gwo3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CIhxntrY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F70FC4CEDE;
	Thu,  5 Dec 2024 09:17:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733390229;
	bh=JoR9zv5U1zLSf1+NY4SjdMS+lbxT9iCKPsKkj/thgSg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CIhxntrYlWm074svVwsKL0ZAUFr4CDMhka/QSL+SNspnPB3gwr0L14rdojW8GmUpX
	 nbAQAN5ES4ntqZPnm7CUJ/1z4fpCZ4Ep7kLbp0FKlZPyaVdEROFXbUOczlNMmc+u/o
	 AoVsA70mCMJ9QViP/nlXJXyiz3f4+SV1u9vA8E+Xx/z3m4rQZY/lw3zVLW4B3QBgju
	 uPNHUVp2yanvSFbBZ4cmtYbAOlyqb5eV+TwqXejYROfMx5dZQvlZUVRujiGmJfEuOn
	 MhWZKA7gLPeNZzvpL9i6ho/0HWHh+Itm8Zb131vC6VxeV4HHVzS5uasmrAaQM1cpGP
	 SjZ+ZcDr8P2jw==
Date: Thu, 5 Dec 2024 11:17:05 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Francesco Poli <invernomuto@paranoici.org>
Cc: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <ukleinek@debian.org>,
	1086520-done@bugs.debian.org, Mark Zhang <markzhang@nvidia.com>,
	linux-rdma@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: Bug#1086520: linux-image-6.11.2-amd64: makes opensm fail to start
Message-ID: <20241205091705.GW1245331@unreal>
References: <173040083268.16618.7451145398661885923.reportbug@crunch>
 <20241118200616.865cb4c869e693b19529df36@paranoici.org>
 <nvs4i2v7o6vn6zhmtq4sgazy2hu5kiulukxcntdelggmznnl7h@so3oul6uwgbl>
 <20241125195443.0ddf0d0176d7c34bd29942c7@paranoici.org>
 <20241125193837.GH160612@unreal>
 <20241127184803.75086499e71c6b1588a4fb5a@paranoici.org>
 <173040083268.16618.7451145398661885923.reportbug@crunch>
 <20241127200413.GE1245331@unreal>
 <acpo6ocggcl66fjdllk5zrfs2vwiivpetd5ierdek5ruxvdbyl@tfbc3mfnp23o>
 <20241204181356.932c49619598e04d8ad412e0@paranoici.org>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241204181356.932c49619598e04d8ad412e0@paranoici.org>

On Wed, Dec 04, 2024 at 06:13:56PM +0100, Francesco Poli wrote:
> On Wed, 4 Dec 2024 17:37:05 +0100 Uwe Kleine-König wrote:
> 
> > Hello Francesco,
> 
> Hello Uwe,
> 
> [...]
> > I wonder if you could test a firmware upgrade or the above patch. Would
> > be nice to know if there are still some things to do for us (= Debian
> > kernel team) here.
> 
> Yes, I've finally got around to upgrading the firmware.
> 
> And today I had a time window, where I could reboot the cluster head
> node.
> After the reboot, the InfiniBand network works correctly:
> 
>   $ uname -v
>   #1 SMP PREEMPT_DYNAMIC Debian 6.11.10-1 (2024-11-23)
>   $ ls -altrF /sys/class/infiniband_mad/
>   total 0
>   lrwxrwxrwx  1 root root    0 Dec  4 10:15 umad0 -> ../../devices/pci0000:80/0000:80:01.1/0000:81:00.0/infiniband_mad/umad0/
>   lrwxrwxrwx  1 root root    0 Dec  4 10:15 umad1 -> ../../devices/pci0000:80/0000:80:01.1/0000:81:00.1/infiniband_mad/umad1/
>   drwxr-xr-x  2 root root    0 Dec  4 10:17 ./
>   drwxr-xr-x 73 root root    0 Dec  4 10:17 ../
>   -r--r--r--  1 root root 4096 Dec  4 10:17 abi_version
>   lrwxrwxrwx  1 root root    0 Dec  4 18:08 issm1 -> ../../devices/pci0000:80/0000:80:01.1/0000:81:00.1/infiniband_mad/issm1/
>   lrwxrwxrwx  1 root root    0 Dec  4 18:08 issm0 -> ../../devices/pci0000:80/0000:80:01.1/0000:81:00.0/infiniband_mad/issm0/
>   # ethtool -i ibp129s0f0
>   driver: mlx5_core[ib_ipoib]
>   version: 6.11.10-amd64
>   firmware-version: 20.43.1014 (MT_0000000224)
>   expansion-rom-version:
>   bus-info: 0000:81:00.0
>   supports-statistics: yes
>   supports-test: yes
>   supports-eeprom-access: no
>   supports-register-dump: no
>   supports-priv-flags: yes
>   # ethtool -i ibp129s0f1
>   driver: mlx5_core[ib_ipoib]
>   version: 6.11.10-amd64
>   firmware-version: 20.43.1014 (MT_0000000224)
>   expansion-rom-version:
>   bus-info: 0000:81:00.1
>   supports-statistics: yes
>   supports-test: yes
>   supports-eeprom-access: no
>   supports-register-dump: no
>   supports-priv-flags: yes
>   $ ps aux | grep opens[m]
>   root        1150  0.0  0.0 1560776 3636 ?        Ssl  10:15   0:00 /usr/sbin/opensm --guid 0x9c63c00300033240 --log_file /var/log/opensm.0x9c63c00300033240.log
> 
> 
> > 
> > If everything is fine for you, I'd like to close this bug.
> 
> I am closing the Debian bug report right now.
> Thanks to everyone who has been involved for the great and kind help!

Thanks a lot for your help. You helped a lot.

BTW, we have an official fix [1], but it wasn't sent yet as we want to
finish all various tests first (E2E, QA e.t.c).

[1] https://git.kernel.org/pub/scm/linux/kernel/git/leon/linux-rdma.git/commit/?h=rdma-next&id=09754c1e5d0d204747928290cc8c6f4371fd4c6a

> 
> > 
> > Best regards
> 
> Have a nice evening.   :-)
> 
> -- 
>  http://www.inventati.org/frx/
>  There's not a second to spare! To the laboratory!
> ..................................................... Francesco Poli .
>  GnuPG key fpr == CA01 1147 9CD2 EFDF FB82  3925 3E1C 27E1 1F69 BFFE



