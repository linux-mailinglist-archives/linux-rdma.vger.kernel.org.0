Return-Path: <linux-rdma+bounces-8594-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C3720A5D7DA
	for <lists+linux-rdma@lfdr.de>; Wed, 12 Mar 2025 09:08:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 478CA3B68E8
	for <lists+linux-rdma@lfdr.de>; Wed, 12 Mar 2025 08:07:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61B7D230BC7;
	Wed, 12 Mar 2025 08:07:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="noGXJoUi"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FAF12309BD
	for <linux-rdma@vger.kernel.org>; Wed, 12 Mar 2025 08:07:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741766842; cv=none; b=HbjgNOi+wk56whhhOCXk5EbDFlmvoGLR+9Ykw0z4Q7Pr3DmLsJBQJmhIt3zTR5aSLGxV525MaVv3HxYyhgUAsWTl1xvPM0OC59/SO9XokvRyQ+MgJqAjJRtRYlNOsrcMxdIjjhKIIO5zMaa3YZbCFiL1lP4IgDCp6H0EjkcXLog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741766842; c=relaxed/simple;
	bh=s+puKnnXsyFcdGKqo8HAPjaOCPt90fQJ+Pdssx4/YZU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LwhYYrNKy7E5qzlHv1UyoCiAlhrakOIACEZwFRmC5hdVIbosrx34o46HczNGgOKGq8vVGcsKQAcim55D7M76wqCUG654SEj7h4amIkxbaxj+i/4ncQHDFFIyirfwRGRJnJA/xHaCL5/rhrfaa0WFnBPLP1H036LwsyPIaxAgygA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=noGXJoUi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57AD7C4CEE3;
	Wed, 12 Mar 2025 08:07:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741766842;
	bh=s+puKnnXsyFcdGKqo8HAPjaOCPt90fQJ+Pdssx4/YZU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=noGXJoUi9ftKZ0DxStOhMyxyuRnDwrmFLzdgdkgMlzSnp3UFYXU8eQwn8M85pT6Cf
	 YJ8BOJoo3yY0RYfs5tyA7bz62pCy6rM0LRm8E7M81DuPYldGhz0oJTgCiDrCyDSbkX
	 HhQ/E1d5+pxyCsM6SzEm/Ve1i//wNcvCkjjz4kEjGedXauNrKWi9nOdi2yAJq33IQM
	 JozM11j7AIwtIiA2UFL5fsRwRAFv7B/JTrGJ2C3jjSqiANUAIq5EFdWLDj0o5EkIsE
	 SRwrVrrVYZba4EYc4o6dQ0mfpluj37m6UVCy4fdPqpisbEY0liLTZ7Xnej7Pj2svLt
	 xyZAYG7EdTcCw==
Date: Wed, 12 Mar 2025 10:07:17 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Chiara Meiohas <cmeiohas@nvidia.com>, linux-rdma@vger.kernel.org
Subject: Re: [bug report] RDMA/uverbs: Introduce UCAP (User CAPabilities) API
Message-ID: <20250312080717.GH7027@unreal>
References: <9f676f55-f5d7-4be5-88a5-4f1f5c5c997a@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <9f676f55-f5d7-4be5-88a5-4f1f5c5c997a@stanley.mountain>

On Wed, Mar 12, 2025 at 09:53:17AM +0300, Dan Carpenter wrote:
> Hello Chiara Meiohas,
>=20
> Commit 61e51682816d ("RDMA/uverbs: Introduce UCAP (User CAPabilities)
> API") from Mar 6, 2025 (linux-next), leads to the following Smatch
> static checker warning:
>=20
> 	drivers/infiniband/core/ucaps.c:209 ib_release_ucap()
> 	error: buffer overflow 'ucaps_list' 2 <=3D 2 (assuming for loop doesn't =
break)

The thing is that we must have "break", so writing if(WARN_ON(type =3D=3D
"RDMA_UCAP_MAX)) return;" instead of existing WARN_ON is very
misleading.

Thanks

>=20
> drivers/infiniband/core/ucaps.c
>     198 static void ib_release_ucap(struct kref *ref)
>     199 {
>     200         struct ib_ucap *ucap =3D container_of(ref, struct ib_ucap=
, ref);
>     201         enum rdma_user_cap type;
>     202=20
>     203         for (type =3D RDMA_UCAP_FIRST; type < RDMA_UCAP_MAX; type=
++) {
>     204                 if (ucaps_list[type] =3D=3D ucap)
>     205                         break;
>     206         }
>     207         WARN_ON(type =3D=3D RDMA_UCAP_MAX);
>=20
> This prints a warning if we're out of bounds, but it doesn't handle the
> error.  This is called from kref_put() and with kref_put() this could
> actually be done in a different thread with a delay from when
> ib_remove_ucap() is called.  I wouldn't advise that for production systems
> but it's supposed to work.
>=20
> So this code makes me quite nervous.
>=20
>     208=20
> --> 209         ucaps_list[type] =3D NULL;
>     210         cdev_device_del(&ucap->cdev, &ucap->dev);
>     211         put_device(&ucap->dev);
>     212 }
>=20
> regards,
> dan carpenter
>=20

