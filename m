Return-Path: <linux-rdma+bounces-3051-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A911903D0D
	for <lists+linux-rdma@lfdr.de>; Tue, 11 Jun 2024 15:22:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C33FC2873CD
	for <lists+linux-rdma@lfdr.de>; Tue, 11 Jun 2024 13:22:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C421317C9FF;
	Tue, 11 Jun 2024 13:22:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OJvxpd51"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75D6617C7C6;
	Tue, 11 Jun 2024 13:22:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718112161; cv=none; b=QeSr/gDBzHCYQyshOw4fDD/DYxLm7RobRq1x6cr49v/QZ1fJRyQ87TmaMo2Mqvd7eL1QEqwXq4ba4zKbvamwR/PgF0TQlbDYdCs04bR8lXeEbpWqCi21Jvcg4802Fv4pdcGc1HdPvXl0rUZBw1gNQ/ava5+ktWIxc503dk0FLNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718112161; c=relaxed/simple;
	bh=jA9dvE7L9ZJmw9za/ZknPNMPAQ+nyOtSi6kn/GimkXY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g54z85g8RnxBY7o7Q2k1GWuk9F9q8BAMt2KKz/k99+luPOiKo/w7Ik97a3x3kLy9+af16mLnzWr4ChnBbjf+pxft1+uE6Chxux0kV8YGh6F0HwwSz0YEdvjZ2j/hPZZAXLJ/CEHPV0+dgX1yPtuTir1gayAEgwH3z4PH273vg7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OJvxpd51; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46807C2BD10;
	Tue, 11 Jun 2024 13:22:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718112160;
	bh=jA9dvE7L9ZJmw9za/ZknPNMPAQ+nyOtSi6kn/GimkXY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OJvxpd51vL1fgaAMZi+67oKms4QBWh1elR9Hk7cG6nG9e9gXGeFrMfWIIAEael+i3
	 lAkE99VPxEfh5CyATJUju6DP+t3VIiBAQTucjgQ0ijMajJBcxew3jixbWnwkA4lB3w
	 ugE0bmKSv4ByzTWhXiqCIEtwrFfOxt+cNpxRnb5kV3Pnz4F4fIUqKNgxjQoYWWx4Qh
	 8zpY0odtnULrAV/ck1rMQnSKWXf63qG4qt6DqqFfTrBr+8cSR+V1A2y62QjUtMw5og
	 nm+chU1m0V08cd11shPoWB/8gBRuAnigd/2INuHL6WAuyjUDRqmNsS6XCFFfwI6dMG
	 6+fylC4MotZmw==
Date: Tue, 11 Jun 2024 14:22:37 +0100
From: Mark Brown <broonie@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org, Dave Ertman <david.m.ertman@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Bingbu Cao <bingbu.cao@intel.com>,
	Tianshu Qiu <tian.shu.qiu@intel.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Michael Chan <michael.chan@broadcom.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Jesse Brandeburg <jesse.brandeburg@intel.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Leon Romanovsky <leon@kernel.org>, Tariq Toukan <tariqt@nvidia.com>,
	Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
	Bard Liao <yung-chuan.liao@linux.intel.com>,
	Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
	Daniel Baluta <daniel.baluta@nxp.com>,
	Kai Vehmanen <kai.vehmanen@linux.intel.com>,
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
	Richard Cochran <richardcochran@gmail.com>,
	linux-media@vger.kernel.org, netdev@vger.kernel.org,
	intel-wired-lan@lists.osuosl.org, linux-rdma@vger.kernel.org,
	sound-open-firmware@alsa-project.org, linux-sound@vger.kernel.org
Subject: Re: [PATCH 1/6] auxbus: make to_auxiliary_drv accept and return a
 constant pointer
Message-ID: <ZmhPnQqYFXWP4heL@finisterre.sirena.org.uk>
References: <20240611130103.3262749-7-gregkh@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Xh2Kj1DQz4GcFSrR"
Content-Disposition: inline
In-Reply-To: <20240611130103.3262749-7-gregkh@linuxfoundation.org>
X-Cookie: Your love life will be... interesting.


--Xh2Kj1DQz4GcFSrR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jun 11, 2024 at 03:01:04PM +0200, Greg Kroah-Hartman wrote:
> In the quest to make struct device constant, start by making
> to_auziliary_drv() return a constant pointer so that drivers that call
> this can be fixed up before the driver core changes.

Acked-by: Mark Brown <broonie@kernel.org>

--Xh2Kj1DQz4GcFSrR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmZoT5wACgkQJNaLcl1U
h9BOJwf/aeKGbgsNQMBhINPc1+PAR8b5cph+EiF+ikcvcatJwJlRp44vA9jbRubp
RmTlt5cENNxdSPxZ4L1agVt+lbemBcTfLZFQLj+KvZjLhC2oeXhkcbjY3eLmIsVw
yQjm6MBnwdVo/8KD/jHCX4VMeCIcqtyTSjXqy3Q7kWlquqICAer7jB2riTxPOsUA
AZ8DvqF1TQees1OHELAdmRRkcSOufQXeZRHCfeiDTpAFFnOazvtPmeAPcQpA5c8v
JITj6HWMZxHRs9efcbyOOTVYnUcE3cZY3lUuqKJqzEfI08F75CJiZvb1hS/fRrPU
6Nig9Tiir3XUu0ajZMrfXBdbm+3HOg==
=XJxc
-----END PGP SIGNATURE-----

--Xh2Kj1DQz4GcFSrR--

