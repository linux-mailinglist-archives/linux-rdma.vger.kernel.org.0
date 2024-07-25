Return-Path: <linux-rdma+bounces-3985-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE3D893C311
	for <lists+linux-rdma@lfdr.de>; Thu, 25 Jul 2024 15:31:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A4A4B282B86
	for <lists+linux-rdma@lfdr.de>; Thu, 25 Jul 2024 13:31:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DEC319CD04;
	Thu, 25 Jul 2024 13:29:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XAbhtwJu"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE55D19ADBF;
	Thu, 25 Jul 2024 13:29:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721914182; cv=none; b=frlHHzShQsreSYPWDyPfDFIy6kfV2EjZ4crYm5DK+ZDWFspID8JpsgMNptzyJoFB+jeNLfRpwrU1KHKHVjaHYjboJfL1EzCUwz/Y7DwRyODuivCBOFBYch2U/rKcDWmoUhSLfVFK7nH5qQ0NFwAunjLCPbwnexhVBpDLAb4q8+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721914182; c=relaxed/simple;
	bh=xEl4g+jfnQQ95R0U9ai2sNK4NaNYst3ZH4oOk77jtEI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gLQmCLdB4XvLPiUaYCQYYETJUtPjADbr8xTakiJ6IFFlSIwuMFvYYJxETaD0aT/rI1IWTj79tleCfpugiRAj03UsN1YmSVsFWY0EcussMy9lgKgE+WFN9QzXIPNP/CyHTK2p6o/0BySOAs3agMcc5lLzL1rE/dtnlSJnyxh6NFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XAbhtwJu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27FE2C116B1;
	Thu, 25 Jul 2024 13:29:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721914181;
	bh=xEl4g+jfnQQ95R0U9ai2sNK4NaNYst3ZH4oOk77jtEI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XAbhtwJu7CMtWWmlYbmux7Izy1j8xDrySEO6C5rlpn/12KYjVsUarHtpvOsqK883u
	 WyrF3g6lkC+GsiEwrQ+PgGzeVyoyD2Sm45aEWVCQCb7i/+h3eZZbXs91fqDvJ54iR4
	 8NomEodY959rHbsgpl380psQcNsUfOd8ZyIhqlTmrxHe8xsp4eqn18KRNLT7pnY7HM
	 BEsFU94TVr/1S4+8FP34NawGiWOubf1WDUme2DtPKmF/yLXzmZnhuFTrBzPh2BxrAz
	 T3YAFfOjlK+73exZ0cP3uLYznJ7HY3r6mIVoesk4pQF8kS1KWivV/+WgQe7p36mxJK
	 yulzbsR0Chgug==
Date: Thu, 25 Jul 2024 14:29:36 +0100
From: Mark Brown <broonie@kernel.org>
To: Leon Romanovsky <leon@kernel.org>
Cc: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	James Bottomley <James.Bottomley@hansenpartnership.com>,
	Jiri Kosina <jikos@kernel.org>,
	Dan Williams <dan.j.williams@intel.com>, ksummit@lists.linux.dev,
	linux-cxl@vger.kernel.org, linux-rdma@vger.kernel.org,
	netdev@vger.kernel.org, jgg@nvidia.com
Subject: Re: [MAINTAINERS SUMMIT] Device Passthrough Considered Harmful?
Message-ID: <1d7a4437-d072-42c4-b5fe-21e097eb5b9c@sirena.org.uk>
References: <668c67a324609_ed99294c0@dwillia2-xfh.jf.intel.com.notmuch>
 <nycvar.YFH.7.76.2407231320210.11380@cbobk.fhfr.pm>
 <1e82a5c97e915144e01dd65575929c15bc0db397.camel@HansenPartnership.com>
 <20240724200012.GA23293@pendragon.ideasonboard.com>
 <CAPybu_0SN7m=m=+z5hu_4M+STGh2t0J-hFEmtDTgx6fYWKzk3A@mail.gmail.com>
 <20240725122315.GE7022@unreal>
 <CAPybu_1XsNq=ExrO+8XLqnV_KvSaqooM=yNy5iuzcD=-k5CdGA@mail.gmail.com>
 <20240725132035.GF7022@unreal>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="pzCKUTHk8oZsWqsa"
Content-Disposition: inline
In-Reply-To: <20240725132035.GF7022@unreal>
X-Cookie: To err is human, to moo bovine.


--pzCKUTHk8oZsWqsa
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jul 25, 2024 at 04:20:35PM +0300, Leon Romanovsky wrote:
> On Thu, Jul 25, 2024 at 03:02:13PM +0200, Ricardo Ribalda Delgado wrote:

> > As a user, and as an open source Distro developer I have a small hint.
> > But you could also ask users what they think about not being able to
> > use their notebook's cameras. The last time that I could not use some
> > basic hardware from a notebook with Linux was 20 years ago.

> Lucky you, I still have consumer hardware (speaker) that doesn't work
> with Linux, and even now, there is basic hardware in my current
> laptop (HP docking station) that doesn't work reliably in Linux.

FWIW for most audio issues (especially built in stuff) with laptops if
you report it upstream it'll generally be relatively easy to quirk.
Unfortunately it's idiomatic for ACPI systems to quirk off DMI
information for almost everything which means a constant stream of per
system quirks for subsystems like audio.

--pzCKUTHk8oZsWqsa
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmaiUz8ACgkQJNaLcl1U
h9CoUwf+P+0tRbdeRE+7FjAR5pVhjO0EwslwfxlribwZ/xLob1JreMrbEyuNzKPZ
8BMlvbD3zr0vTpaoGl5IeNJuq7XKDLN4Ir4xQlRt0bXHWvabUTibRTMC2YYqN9Gd
gQqRJzrKw9EVhvOGBvoqaW42x7CizQpe/K4VKGb10bZvolstjqU2EO5W76k51FZ+
POtBxpwMYV3Xi1GCI74SLdvRseHYilVdxJ4s7sHu91vsBBdnLAT/6JJxxYs3QxZV
+I9u3KTnh6XkoM6cc4xL66Z1Ab8j6LrxxJm4lqb8VGfjaWdc3DfdUDODuhDY+LoF
qHOpqQzRTPymj2pMHfvF2phV7TdCkw==
=G4zx
-----END PGP SIGNATURE-----

--pzCKUTHk8oZsWqsa--

