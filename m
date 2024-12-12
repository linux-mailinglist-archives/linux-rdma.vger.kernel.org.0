Return-Path: <linux-rdma+bounces-6456-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE5389EDD3A
	for <lists+linux-rdma@lfdr.de>; Thu, 12 Dec 2024 02:49:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B2C3016185F
	for <lists+linux-rdma@lfdr.de>; Thu, 12 Dec 2024 01:49:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80F7754723;
	Thu, 12 Dec 2024 01:49:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J4tAqf45"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CFE91F60A;
	Thu, 12 Dec 2024 01:49:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733968192; cv=none; b=RoQzcfSLvPLVoHhHzSVBc16P0U9F0lf1ZXGrvnq0kPrr9vWUqDeftdSCyfW6dkfz+nlgxEwROt7l6DCJXgtqNqaKnKIycXqIDlDTpVgUw+KFvnD0g9Ji5iZ98yuO8HJK1yFVpmue7f2dEjXL9BqIxv9fuvhFnoMS20judsSC7W0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733968192; c=relaxed/simple;
	bh=z2XI7T4EjCRq7CgiIW1pZjNAMgPXm+a1Tb1PfcY/dHw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KVmBrFnwfcB4mnyEYeYLuQyVabvLkgoAjlsQmuYu47D9SRrKxF6OYyIHY9mXH8T8X32NLXHRuHtp7h71/OY+fJIAv+2zZvOLhhbacYU4Ye2xesZ7OWqqWCC3owj9kFSHDAHmGZb6O0PgRVb8iraCz18C7f6O9wygdLdJHz0AWN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J4tAqf45; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D6BFC4CED2;
	Thu, 12 Dec 2024 01:49:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733968191;
	bh=z2XI7T4EjCRq7CgiIW1pZjNAMgPXm+a1Tb1PfcY/dHw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=J4tAqf45R63ofHw0Xrp/fvGz5j1t769aDtNO6/Ai+BvpKkDC+/7u2cWxNELs5uPJ7
	 gXP5br4vngFc+sl7rDWLDiPgAD9uIn7HH8QI1thgEjnInYncpFPTThKQ6bpyc/S9lr
	 K/M1vpdQy0KLj9Xcg/T5xnLCqMicCNlkkppkPMhAOkGdLmKfc8La8Pg8MsIZUMyovW
	 fEWXYyAgU1zmRiJ1Uf/xkTrVObufRhhswjUBp5dipvDLxQAB4QhEouBFDdYBxH+31z
	 gFZMTuadsaZJb+hhjCEBtfdjoQG6Xy0epR6pXZgEoTf19BGhARMaviuxg/YKSBE43S
	 ox1+CKHtT9Esg==
Date: Wed, 11 Dec 2024 17:49:49 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Cosmin Ratiu <cratiu@nvidia.com>
Cc: "ttoukan.linux@gmail.com" <ttoukan.linux@gmail.com>, "jiri@resnulli.us"
 <jiri@resnulli.us>, "andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>,
 "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
 "davem@davemloft.net" <davem@davemloft.net>, Tariq Toukan
 <tariqt@nvidia.com>, Gal Pressman <gal@nvidia.com>, Leon Romanovsky
 <leonro@nvidia.com>, "pabeni@redhat.com" <pabeni@redhat.com>,
 "edumazet@google.com" <edumazet@google.com>, Saeed Mahameed
 <saeedm@nvidia.com>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: [PATCH net-next V5 00/11] net/mlx5: ConnectX-8 SW Steering +
 Rate management on traffic classes
Message-ID: <20241211174949.2daa6046@kernel.org>
In-Reply-To: <1593e9dd015dafcce967a9c328452ff963a69d68.camel@nvidia.com>
References: <20241204220931.254964-1-tariqt@nvidia.com>
	<20241206181345.3eccfca4@kernel.org>
	<d4890336-db2d-49f6-9502-6558cbaccefa@gmail.com>
	<20241209134141.508bb5be@kernel.org>
	<1593e9dd015dafcce967a9c328452ff963a69d68.camel@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Wed, 11 Dec 2024 09:49:28 +0000 Cosmin Ratiu wrote:
> I've looked over the latest version of the net-shapers API.
> There is some conceptual overlap between this patchset and net-shapers
> ability to define a group of device queues and manipulate its tx
> limits. But as far as I am aware ([1]), the net-shapers API doesn't
> intend to shape entities above netdev level.

It's not about the uAPI but about having a uniform way of representing
the shaping hierarchy.

> So there are two things to discuss here:
> 1. Integrating device-level TC shaping into net-shapers. The net-
> shapers model would need to be extended with the ability to define TC
> queues. At the moment I see it's concerned with device tx queues which
> don't necessarily map 1:1 to traffic classes.

What are "TC queues"? NIC queues with assigned TC? Your patches shape
on a group of VFs, so the equivalent would be a group of queues=20
(e.g. group of queues assigned to a container).

> Then, it would need to have the ability to group TC queues into a node.

=F0=9F=A7=90=EF=B8=8F .. grouping of queues was the main direct use case fo=
r net-shapers,
so it's definitely there, perhaps I don't understand what you mean.

> Then the integration should be easy. Either API can call the device
> driver implementation or one API can call the other's function to do
> so.
>=20
> Paolo, what are your thoughts on tc shaping in the net-shapers API?
>=20
> 2. VF-group TC shaping. The current patchset offers the ability to
> split TC bandwidth on a devlink rate node, applying to all VFs in the
> node. As far as I am aware, net-shapers doesn't intend to address this
> use case. Do we want to have two completely different APIs to
> manipulate tc bandwidth?

Exactly my point. We have too many disjoint APIs. net-shapers was
merged on the premise that it will at least align the internal and
driver facing APIs, even if we still need multiple uAPIs.

