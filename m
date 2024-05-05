Return-Path: <linux-rdma+bounces-2273-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EEDE68BC08B
	for <lists+linux-rdma@lfdr.de>; Sun,  5 May 2024 15:27:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9AF301F21495
	for <lists+linux-rdma@lfdr.de>; Sun,  5 May 2024 13:27:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 990241CA92;
	Sun,  5 May 2024 13:26:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="TLUFnYId"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail.zeus03.de (www.zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CD18847C
	for <linux-rdma@vger.kernel.org>; Sun,  5 May 2024 13:26:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714915615; cv=none; b=sOhlA9GEx7zV3ei4EVNzZ+5FqFlcZSlkZmxN+3TK/GS5oGtFRmgvX1isCpdE24s9BiVKtAcgubTAEd/WENiM2L/8mGd6RdHKUdhUpKQgXAL2sUilEGZqj+xnF3gq1iTXhhuRLZjfY1qwi3cNCYtyIssFe2oFruMF1U4lj48mW5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714915615; c=relaxed/simple;
	bh=mpiUYOnVxI/amzNfIWC+aCOLo8uUXS9xO5s3OcIyyQk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ez03U8WRX8lJaxD09zbGpfZdnQPn+T84WzgIJR5qiLAdk/hB4TT7JEEzqhPURP6QLudzcFp4fXnf087+2ZHyRzla08qyg8zuhPvxfLb3oOphTc8IY+F6wczkH1qClSzZJhM08ii9eq4FKXS6o8Vinp3Jv/g8xZhBBrmei05cmS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=TLUFnYId; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=date:from:to:cc:subject:message-id
	:references:mime-version:content-type:in-reply-to; s=k1; bh=bDMQ
	pHvXDNxhE22UjKoMHYpRBi1DbEz3e7NVMs0aIgU=; b=TLUFnYIdfg37CcLyyKWh
	9WFG4L9t0bNkGHvjtkR+XiZsK/GwmWBP+1PgeKr0EDxz+/JKFsVMUDE96aJAKZJE
	2xiWtduWDaffKhskFJ+PdlFVMVSZO2/YPQluE+F+PAEubZwtFW2achaf6YlyGoov
	kEekD3AGLXVXHwBJTxkFCoEGSGh9eg7biAKIxfZWcmixRABNZ6c3Fhv5vnoh+LGu
	RFCdngxXQ5fgHirwvULhGhqQjgRVFLKM7tpL67URxx09g2IPAnoLzGRX+ruupHJd
	XIa5SsOMxO0l5tDOmNPs1IOg+CefU4zCph/04lVL0rEV+bcxLaJTQe4700MIJq/d
	aQ==
Received: (qmail 4096196 invoked from network); 5 May 2024 15:20:07 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 5 May 2024 15:20:07 +0200
X-UD-Smtp-Session: l3s3148p1@gla5z7QXorcujnsp
Date: Sun, 5 May 2024 15:20:06 +0200
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: Leon Romanovsky <leon@kernel.org>
Cc: Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>, 
	linux-rdma@vger.kernel.org, Jason Gunthorpe <jgg@ziepe.ca>
Subject: Re: [PATCH 1/1] IB: sw: rdmavt: mr: use 'time_left' variable with
 wait_for_completion_timeout()
Message-ID: <ziljba4xsziurwc2espkmpmraoekfp7zymblt3ktstsjppcm4f@7apyyzi3g3zn>
Mail-Followup-To: Wolfram Sang <wsa+renesas@sang-engineering.com>, 
	Leon Romanovsky <leon@kernel.org>, Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>, 
	linux-rdma@vger.kernel.org, Jason Gunthorpe <jgg@ziepe.ca>
References: <20240502210559.11795-2-wsa+renesas@sang-engineering.com>
 <dc2783fa-de8b-4609-8ce6-f168b5dbfeff@cornelisnetworks.com>
 <20240505130309.GA68202@unreal>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ll45js3sy4saf5zz"
Content-Disposition: inline
In-Reply-To: <20240505130309.GA68202@unreal>


--ll45js3sy4saf5zz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> > > -	timeout =3D wait_for_completion_timeout(&mr->comp, 5 * HZ);
> > > -	if (!timeout) {
> > > +	time_left =3D wait_for_completion_timeout(&mr->comp, 5 * HZ);
> > > +	if (!time_left) {
> > >  		rvt_pr_err(rdi,
> > >  			   "%s timeout mr %p pd %p lkey %x refcount %ld\n",
> > >  			   t, mr, mr->pd, mr->lkey,
> >=20
> > Nah. Disagree. I think the code is just fine as it is.
>=20
> I agree with Dennis. Let's drop this patch.

Okay, I added your subsystem to the discard-list. Thanks for the review
nonetheless!


--ll45js3sy4saf5zz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmY3h4IACgkQFA3kzBSg
KbYfKQ/+JERDBgsg6oHn/xsxrrHU8Nnool5Y3ad6lUtl0vprIXMFt/sOSOs4D96A
kVlvOqrW3+zLgu5OqQ3dvpvDC1pfrvRMjryjkqbs4KZRBvtccvUtWzx2bFsqos9h
od4m6wRHYGcBuYwHDCPIm+kx7VqF7UKTJSuCmvvU5+f6PLzVFp28bFdkmFhIbt2/
yENq4QELXM4LzK8pU/XFzq7/TIthKuryc925ex1F5Cgqxs1FjKb1OPqJ5vFgLukv
xy6/OeShnWcxHlYNqYYmdkE1QoFzfc/fD2vHZ3CCQgvBZRaQCgRy0fo6RW7ZW11r
Dfv7aTFahbnkHRD12BT18988oSASGcMHrXnUUawQgPi/xaXVzlndooVvVLgA3DDg
79Lf1EIQeFuyV8zlp7Ew43ZVlWl3TOVG4vPj2JXbMGIhBAFS6f1BswpeoIclt31o
2fO0CFccTag9Otru9ADYeEpQzV3HNCzT49JUZFtDqTtRqxnWwvFKff05IUDaWdIj
U9hg98W9nF+jGUEK4wCjHydVbpMuzGuRc86GZW7vp1wvvD8PmgJoakdPl3KrXXMG
IWhR1Su2u6maUjQNnABYdsU6Aq4ijl5QuaHk0AwCfggegvpS9+O943L2FjYYr6/f
wZPg5K0wipJvgbhndNBhH80W7Uq+Tt/3anGmCe7beS2p/mj0PWc=
=tMtG
-----END PGP SIGNATURE-----

--ll45js3sy4saf5zz--

