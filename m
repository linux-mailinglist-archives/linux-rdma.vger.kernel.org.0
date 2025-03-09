Return-Path: <linux-rdma+bounces-8519-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E3ACA58789
	for <lists+linux-rdma@lfdr.de>; Sun,  9 Mar 2025 20:28:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5BEDF169710
	for <lists+linux-rdma@lfdr.de>; Sun,  9 Mar 2025 19:28:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C5E91F0980;
	Sun,  9 Mar 2025 19:27:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qn2YikpJ"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE52F1A3BD7;
	Sun,  9 Mar 2025 19:27:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741548476; cv=none; b=UFQXyS6DWRcody8iy4vSGpl38ZOhqyAuedzD9DIZ2vsuw55ydZ69R1ts4AKRMIZaw4yS6X5V0H+bEBC1vn7rQWh5pyAqYBPiv4TLrpKwXHngEtxqPwhC4YGJIOVK9CrrC+emLrUlIGu5gULFrNW8g3Mlerb3Rbz5qrXL+11/Nfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741548476; c=relaxed/simple;
	bh=JYaY8MKtsgOY+Detg3srKTHyA3OWinQ5pCvNMEp0BeY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fGc9dQfKLfXShD1AQwLbRb84Sya/PuEUHTHXxR9ZCAyFX6BJZI/BInOTfpm42C6u9caOSjPniHm2zmQ1/DVulHHOsSLMTnS/JzuVPJsd2vHJm1tPYNO42ExPZejm38M+bbyLnA1ZZZFEktY4RGYjySYXIgupXVW5yBF9qvogESA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qn2YikpJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF2A8C4CEE3;
	Sun,  9 Mar 2025 19:27:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741548476;
	bh=JYaY8MKtsgOY+Detg3srKTHyA3OWinQ5pCvNMEp0BeY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qn2YikpJwGMwava0sNGyH5F8PNTUz3txm8ljZ+vFMbYBAzo3zHUYl2C7Tc7MmRwmm
	 oFM7gFki4bbfzC3N3IRRJi6ebq0YiGY0CvmItk1v6u7rfxzrwdZyrX6Rw2QRZZ1Rwm
	 yqdvvyyojmu5oCx8AX0c9IS12StFxJpvPH+VWPtxoGy2MzLuGo5MURmIbW20414tjI
	 q0aNjGdP7W2DdGpnk2jPWpBjC+k2ZUpUSDBHe+Kjo7obKueFuHI+gkCgyL2FsMZMJA
	 UMH2OeVJR3hgRgu7FSgg5EHZ0YU8W2Vsv2QNxRS0V5+Vb/pgLolr1Xu+a7D6oHyPzo
	 AUakDOXLMW3yw==
Date: Sun, 9 Mar 2025 21:27:51 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Abhinav Jain <jain.abhinav177@gmail.com>
Cc: jgg@ziepe.ca, linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] RDMA/core: Publish node GUID with the uevent for
 ib_device
Message-ID: <20250309192751.GA7027@unreal>
References: <20250309175731.7185-1-jain.abhinav177@gmail.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20250309175731.7185-1-jain.abhinav177@gmail.com>

On Sun, Mar 09, 2025 at 05:57:31PM +0000, Abhinav Jain wrote:
> As per the comment, modify ib_device_uevent to publish the node
> GUID alongside device name, upon device state change.
>=20
> Have compiled the file manually to ensure that it builds. Do not have
> a readily available IB hardware to test. Confirmed with checkpatch
> that the patch has no errors/warnings.

I'm missing motivation for this patch. Why is this change needed?

Thanks

>=20
> Signed-off-by: Abhinav Jain <jain.abhinav177@gmail.com>
> ---
>  drivers/infiniband/core/device.c | 13 +++++++++----
>  1 file changed, 9 insertions(+), 4 deletions(-)
>=20
> diff --git a/drivers/infiniband/core/device.c b/drivers/infiniband/core/d=
evice.c
> index 0ded91f056f3..1812038f1a91 100644
> --- a/drivers/infiniband/core/device.c
> +++ b/drivers/infiniband/core/device.c
> @@ -499,12 +499,17 @@ static void ib_device_release(struct device *device)
>  static int ib_device_uevent(const struct device *device,
>  			    struct kobj_uevent_env *env)
>  {
> -	if (add_uevent_var(env, "NAME=3D%s", dev_name(device)))
> +	const struct ib_device *dev =3D
> +		container_of(device, struct ib_device, dev);
> +
> +	if (add_uevent_var(env, "NAME=3D%s", dev_name(&dev->dev)))
>  		return -ENOMEM;
> =20
> -	/*
> -	 * It would be nice to pass the node GUID with the event...
> -	 */
> +	__be64 node_guid_be =3D dev->node_guid;
> +	u64 node_guid =3D be64_to_cpu(node_guid_be);
> +
> +	if (add_uevent_var(env, "NODE_GUID=3D0x%llx", node_guid))
> +		return -ENOMEM;
> =20
>  	return 0;
>  }
> --=20
> 2.34.1
>=20

