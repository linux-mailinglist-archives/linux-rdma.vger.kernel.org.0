Return-Path: <linux-rdma+bounces-3978-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 694C693C06F
	for <lists+linux-rdma@lfdr.de>; Thu, 25 Jul 2024 12:51:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9C7E5B20B2D
	for <lists+linux-rdma@lfdr.de>; Thu, 25 Jul 2024 10:51:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 089C81991A1;
	Thu, 25 Jul 2024 10:51:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="BKL4KzhZ"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7718196DA2
	for <linux-rdma@vger.kernel.org>; Thu, 25 Jul 2024 10:51:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721904708; cv=none; b=qlKRqZ3cB/aVH71HNUJA/XZlJOz/tCBMmXqXRfScIed+XUmKPHBvuZgXSqZaFM5w74LA0Jhil2rrfYy4/FOhENJc6hfyxR8R6aRA+XVBYTZMMO9WPZViU/T69QTHJcM2HF8xNF7cDJ1JBhpru/U7ScshvjKe4JJeF1/6E4XIQYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721904708; c=relaxed/simple;
	bh=3fcLBujA8oEJ6hlp8dEqRtvI9FgUBp6fr0LxMsx9NvQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R8u8co6pj3MWAdj0ZgTmfHYqWuHTywJMgXSzLdxZnnJ16w6lP4uL+3fc15aFe67FE7wzIGnBplCbANmuIkVxdwbXsrr6NkaD43ejvPzGlASHWUOYu/OKJGd+v8lEzedYPt7WgMttDfM0ks4GgGrnzvieftv4bCpqs9gN5tm8xeg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=BKL4KzhZ; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=date:from:to:cc:subject:message-id
	:references:mime-version:content-type:in-reply-to; s=k1; bh=kcFe
	Yku6GJhrCR24Aw9mdE9/gi7I04NxDXXehgOMSOk=; b=BKL4KzhZz7eoQX4DqhK/
	/6oba79W938TvUqntDFMmBEZS6VRRAlblh2z985GTl9t4+21pFopA03vBYYI8Y7C
	zlBPlfqu2OEY5EzpwWRQ4Xr4m0PX/6ohTIDtIL/HT9SO7KdN6Es7M7RiekR+PmEj
	dOZZWW+CxXu98k5CQCJ/SLJE+hp2rAV4h6AklD5Jzr5hwFvu1H8ej7vPaO+eExrK
	Lp+9OB5x0sgnlWBQ4olz9vE4psZGaxbSggZ2px+cqe/IorBDjNs6oda4KhWsF3id
	QGj9qbsrjGme2P054wEqHqbNavIVtRKhEc1M5OnyqBN74JKsMS3vujEBfGMt9qdu
	bg==
Received: (qmail 2964050 invoked from network); 25 Jul 2024 12:51:35 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 25 Jul 2024 12:51:35 +0200
X-UD-Smtp-Session: l3s3148p1@Hxu0LRAehq0ujnsv
Date: Thu, 25 Jul 2024 12:51:35 +0200
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	James Bottomley <James.Bottomley@hansenpartnership.com>,
	Jiri Kosina <jikos@kernel.org>,
	Dan Williams <dan.j.williams@intel.com>, ksummit@lists.linux.dev,
	linux-cxl@vger.kernel.org, linux-rdma@vger.kernel.org,
	netdev@vger.kernel.org, jgg@nvidia.com
Subject: Re: [MAINTAINERS SUMMIT] Device Passthrough Considered Harmful?
Message-ID: <ZqIuN2JR_mRgZiJ1@shikoro>
Mail-Followup-To: Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	James Bottomley <James.Bottomley@hansenpartnership.com>,
	Jiri Kosina <jikos@kernel.org>,
	Dan Williams <dan.j.williams@intel.com>, ksummit@lists.linux.dev,
	linux-cxl@vger.kernel.org, linux-rdma@vger.kernel.org,
	netdev@vger.kernel.org, jgg@nvidia.com
References: <668c67a324609_ed99294c0@dwillia2-xfh.jf.intel.com.notmuch>
 <nycvar.YFH.7.76.2407231320210.11380@cbobk.fhfr.pm>
 <1e82a5c97e915144e01dd65575929c15bc0db397.camel@HansenPartnership.com>
 <20240724200012.GA23293@pendragon.ideasonboard.com>
 <CAPybu_0SN7m=m=+z5hu_4M+STGh2t0J-hFEmtDTgx6fYWKzk3A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="25JKoLVFGJsXZT50"
Content-Disposition: inline
In-Reply-To: <CAPybu_0SN7m=m=+z5hu_4M+STGh2t0J-hFEmtDTgx6fYWKzk3A@mail.gmail.com>


--25JKoLVFGJsXZT50
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Ricardo,

> It would be great to define what are the free software communities
> here. Distros and final users are also "free software communities" and
> they do not care about niche use cases covered by proprietary
> software.
> They only care (and should care) about normal workflows.

Don't you think there are distros and final users who do care about
proprietary influences, in general. For sure, though, I think they
should not be told what they should care about?

> If we want vendors involved, we need to build an ecosystem where they
> feel invited.

Definitely. Invited as in "you are welcome to work with us on this",
though. Not as in "come here and do what you want". This is why we have
a coding-style etc...

> We should not take as hostages our users and impose rules on how they
> should build or even sell their product.

Right, it should be a plain buisness decision. I totally agree with your
"clear rules" request below. And yeah, face to face is probably best
suited.

> - Vendor passthrough mechanisms are allowed for niche use cases or
> development/experimentation.

Problem with "niche" is that it can grow really big. See Linux :)

All the best,

   Wolfram


--25JKoLVFGJsXZT50
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmaiLjMACgkQFA3kzBSg
KbYVFxAAo3/PCWMxZwmHL8MWxA34jXcOM9odcmry6DNofkZ5hGEHjT8XjhaYB9l4
7jbWHf78CsCBAT5g+km2MfYbpy7INfWa+7whZAwNVMuDSndFG4lbCpG6x7qA/dVw
bM5eRdbS6EUkP9oSSpJ/RvFH3dmtEZ7CULl/wYdUiCjn6JbjVF/0+q0m0SKNskA3
3HDjVebHimY3oMM37njXTO3Gv0W4H83VEvHt8ExPXwoq8pdr0SflaGFxQ0Bv7dfX
5pSarLw/Xn2kFx/8MbHigRX74iApoxeUsI94N9uZx7pnSc8Hhxa5vVueKjFOg2/A
4+TbumL0y5cQYga5Mav5FEStXEj6Lc1ICvrQfpYmiEqsf/TbtTUOmtwpKxV2WZvw
9egngAuxTOs1WS1MEBWjc7rR1Cvij9zJc0XEPlcgWbd6zMGJSlm5uG7xMudP49Hh
tuyjr4B08bK5K4ilNfT2E6OkRZSQ3yjHHlj/p0SUj19q9uL+anxvPP7RIbH+/wDT
mQ0iMoVsIyxtKSzE7YdDg2U5XQJc+jjX7BJ3jotxn0nvMLoHgrmv+6MRCBVR5jvE
eQdI0dOx1WQr/oJs6Eu+YxWynjLFhEp+keIYerWqAsCUFADBH+2zeu4hpI/SBOz8
X5vzHqMEh/YaYBF4OH2ZT91fRlXfQQajzDzKhcTkee/z5Nq1Vxw=
=z870
-----END PGP SIGNATURE-----

--25JKoLVFGJsXZT50--

