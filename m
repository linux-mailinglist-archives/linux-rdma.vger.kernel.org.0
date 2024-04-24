Return-Path: <linux-rdma+bounces-2041-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D1EC8AFD7B
	for <lists+linux-rdma@lfdr.de>; Wed, 24 Apr 2024 02:57:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5EED5B2368E
	for <lists+linux-rdma@lfdr.de>; Wed, 24 Apr 2024 00:57:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A62284C61;
	Wed, 24 Apr 2024 00:57:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f3wRJQCj"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57BF363D0;
	Wed, 24 Apr 2024 00:57:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713920240; cv=none; b=uR/Vw/i1dUUBO1nRukaOcCBGxFjQVX4Hpkd1Bttb0iuz00cXf3ySQ+Kx916/Z18iOXuUIwhHep4zQXM4lDYlBrLIRxE3q6+Fc5WNatIcRmwZkiXsyLVNRtB8ENvGXktFycFaa93uPc+DanP4T4MjNc9CXkzn18vrYqfz8HDoKvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713920240; c=relaxed/simple;
	bh=dU/mSRR2DatpobRTvXfLbp4WxXu8S7T6ZNvWUPBTg5M=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oYZv6BrySxepzzUSlxwLaF3OCxKD4PTT+cNHuF8UztfWJKJK4icKyXp7UnFxVsr/bb/IhR/7o7Oos8G4nrT7f0zgXE5OwP10aPZc9EtfCdyyyp7vFk18HTS9q1dd5MY0T5tf6sodcIu02LwPQfTXUSg/031cfhU9hcC82JBJrkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f3wRJQCj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89F2CC116B1;
	Wed, 24 Apr 2024 00:57:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713920239;
	bh=dU/mSRR2DatpobRTvXfLbp4WxXu8S7T6ZNvWUPBTg5M=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=f3wRJQCjsRcBM8RFohLzlN9w61SLc4vWIOw0/yk7WdOAeo720eTDQXlMTyAnVX1b5
	 wUDbNfJ2Z8ezexX7Id6xCXQa4ymc9yiOzlvZBJerdUk7HooTxgIq7TMvZtI78Ppvxl
	 EN/mhrVeSqu1xahRWiMcMVIKC/WtONrkXEFOiLhvsljLCZ49t4fNIcSaqpDw4DMvup
	 8T9mN9bo+MbWwcm7lqsVtq1FzRsq+MZzdnyEzzrBFujSFBzIFbcs7IwiiNN1dBsryl
	 QgjhvJRJx7GMSi6jGJQd3lvQREE8vsskCvLfCmgqjTHUMILXY98IYfxz4IB4W/5Y8B
	 ValZweNVWasrw==
Date: Tue, 23 Apr 2024 17:57:18 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Joe Damato <jdamato@fastly.com>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org, tariqt@nvidia.com,
 saeedm@nvidia.com, mkarsten@uwaterloo.ca, gal@nvidia.com,
 nalramli@fastly.com, "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, "open list:MELLANOX
 MLX4 core VPI driver" <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH net-next 3/3] net/mlx4: support per-queue statistics via
 netlink
Message-ID: <20240423175718.4ad4dc5a@kernel.org>
In-Reply-To: <Zig5RZOkzhGITL7V@LQ3V64L9R2>
References: <20240423194931.97013-1-jdamato@fastly.com>
	<20240423194931.97013-4-jdamato@fastly.com>
	<Zig5RZOkzhGITL7V@LQ3V64L9R2>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, 23 Apr 2024 12:42:13 -1000 Joe Damato wrote:
> I realized in this case, I'll need to set the fields initialized to 0xff
> above to 0 before doing the increments below.

I don't know mlx4 very well, but glancing at the code - are you sure we
need to loop over the queues is the "base" callbacks?

The base callbacks are for getting "historical" data, i.e. info which
was associated with queues which are no longer present. You seem to
sweep all queues, so I'd have expected "base" to just set the values=20
to 0. And the real values to come from the per-queue callbacks.

The init to 0xff looks quite sus.

Also what does this:

>	if (!priv->port_up || mlx4_is_master(priv->mdev->dev))

do? =F0=9F=A4=94=EF=B8=8F what's a "master" in this context?

> Sorry about that; just realized that now and will fix that in the v2 (alo=
ng
> with any other feedback I get), probably something:
>=20
>   if (priv->rx_ring_num) {
>           rx->packets =3D 0;
>           rx->bytes =3D 0;
>           rx->alloc_fail =3D 0;
>   }
>=20
> Here for the RX side and see below for the TX side.

FWIW I added a simple test for making sure queue stats match interface
stats, it's tools/testing/selftests/drivers/net/stats.py

You have to export NETIF=3D$name to make it run on a real interface.

To copy the tests to a remote machine I do:

make -C tools/testing/selftests/ TARGETS=3D"net drivers/net drivers/net/hw"=
 install INSTALL_PATH=3D/tmp/ksft-net-drv
rsync -ra --delete /tmp/ksft-net-drv root@${machine}:/root/

HTH

