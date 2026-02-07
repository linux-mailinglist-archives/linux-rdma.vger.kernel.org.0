Return-Path: <linux-rdma+bounces-16662-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uOhIG2iahmnMPAQAu9opvQ
	(envelope-from <linux-rdma+bounces-16662-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Sat, 07 Feb 2026 02:50:32 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EDD510490E
	for <lists+linux-rdma@lfdr.de>; Sat, 07 Feb 2026 02:50:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 939FE302A2F0
	for <lists+linux-rdma@lfdr.de>; Sat,  7 Feb 2026 01:50:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F5FB330679;
	Sat,  7 Feb 2026 01:50:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z18bC+bK"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 597E51FE47B;
	Sat,  7 Feb 2026 01:50:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770429025; cv=none; b=Mx/skDxjEiioc5QKDZb9EQu+jD4QtCxPvAqbvxBEaoimNhVkJYsc2qPC00Ok89TykndXaudsmIpXW9XCCyICgA/hmh3k1PW+yJCElbTyQz31Wf1IvjYm56SYSnuS4oJNNX+p5MHMvrkQbKmLbUS4sZlWk7mDL6Pe+zhPTOqQZpc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770429025; c=relaxed/simple;
	bh=AeZzWJJ3eLzOMDYijrOnV9Cvj9sBq8VrqxbcdEVuF9w=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EYYUzj9PiQyv+YzEfo9h7BSVafed0vOkEga51mLqJUa1BnJXc4dOjk0SFnbhtJi/83wEkAUvoU+o9yW0bjty7MP5rB6M2tfsI3Vs4z0VHHcINMD6rqFIOVThWiGR/WccY6Zxf8rEmi/KulvduXjjZKSze4GjJ5Tc9rBdA5XJj9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z18bC+bK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EBD81C116C6;
	Sat,  7 Feb 2026 01:50:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770429025;
	bh=AeZzWJJ3eLzOMDYijrOnV9Cvj9sBq8VrqxbcdEVuF9w=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Z18bC+bKhdS99kEMAqdiL3lOhQtzzAe24vw1VQN6s4pRbZ/X71enNfEdvDRj0LU6n
	 e8hj2zTXJ1FGgMcZDkUu/IAOeT/ipsoqE2osqBE1vHkOl8A9GFPHbYttyuCjLwqwqe
	 FJws9OOttsiv9lIAg+1omzYMwa96uzOhPFa2QcZeKmTxToPpTN2V/d8xNdAO3fuFbD
	 qwBQUEH3S+BzQVsnGiv/dgKxW9wcQLzgW6HO5PTcI6yRl+IQWLSurt4ZKmvQ+5B5Uz
	 xyiqJuny1IGalN7NnWRT4FaBlkBWS51JrNjaEcEUuH7QctdZLqfRdI3NRYu9H7e+c9
	 n2KPnZFcd1ujQ==
Date: Fri, 6 Feb 2026 17:50:23 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Jiri Pirko <jiri@resnulli.us>
Cc: Tariq Toukan <tariqt@nvidia.com>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Donald Hunter
 <donald.hunter@gmail.com>, Jonathan Corbet <corbet@lwn.net>, Saeed Mahameed
 <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>, Mark Bloch
 <mbloch@nvidia.com>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-rdma@vger.kernel.org, Gal Pressman
 <gal@nvidia.com>, Moshe Shemesh <moshe@nvidia.com>, Carolina Jubran
 <cjubran@nvidia.com>, Cosmin Ratiu <cratiu@nvidia.com>, Jiri Pirko
 <jiri@nvidia.com>, Randy Dunlap <rdunlap@infradead.org>, Simon Horman
 <horms@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>
Subject: Re: [PATCH net-next V7 01/14] documentation: networking: add shared
 devlink documentation
Message-ID: <20260206175023.34ffd9d6@kernel.org>
In-Reply-To: <khee3ri33uvtp4ssaqu7a6vy4mkbrp2zq6nghpbmyyc5pup6rq@hyryulfrhfl6>
References: <20260128112544.1661250-1-tariqt@nvidia.com>
	<20260128112544.1661250-2-tariqt@nvidia.com>
	<20260202194023.412bb454@kernel.org>
	<u7uicnxkcirhacpzjimss2pqsuhbngg4ticqrz45iqchkk2ha2@t3eem6w6hhur>
	<20260203190105.2cc28e71@kernel.org>
	<3edheaanzxgutuyryorfzlfjvizlorpj4y3ard5js7mp44hfii@4a36de6wazfd>
	<20260204180256.1476f537@kernel.org>
	<khee3ri33uvtp4ssaqu7a6vy4mkbrp2zq6nghpbmyyc5pup6rq@hyryulfrhfl6>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-16662-lists,linux-rdma=lfdr.de];
	FREEMAIL_CC(0.00)[nvidia.com,google.com,redhat.com,lunn.ch,davemloft.net,gmail.com,lwn.net,kernel.org,vger.kernel.org,infradead.org];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[23];
	NEURAL_HAM(-0.00)[-0.998];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 0EDD510490E
X-Rspamd-Action: no action

On Fri, 6 Feb 2026 11:52:21 +0100 Jiri Pirko wrote:
> Thu, Feb 05, 2026 at 03:02:56AM +0100, kuba@kernel.org wrote:
> >On Wed, 4 Feb 2026 08:12:00 +0100 Jiri Pirko wrote: =20
> >> What's the backing device / handle (busname/devname)? Best would be to
> >> draw a picture, as always :) =20
> >
> >Either the bus/dev that shows up first or we go back to index. =20
>=20
> That may be tricky in case you bind/unbind the PFs randomly. You may and
> up with devlink handle of PF1 with only member PF2. Confusing at least.
> You need to expose the members to the user anyway somehow. That is
> exactly the list of nested instances these patchset is adding.

Yes, simpler setup would likely be to have one function designated=20
as "main". This could get fairly complicated, OTOH most current use
cases are fairly rigid, with the function config being per device SKU.
=46rom uAPI perspective having the list of currently present functions
and ports should be flexible for current and future use cases.

> >(My main point being that the single instance is strictly better
> >than shared, ie. no problem exists in single instance multi func
> >which does not exist in multi instance + extra instance multi func.
> >But some problems do exist in multi instance which do not in single
> >like the locking) =20
>=20
> I think that my shared and your shared are basically the same as far as
> the nested PF instances are not really used for anything except the
> modelling purposes. That should be up to the driver how he wants to play
> it, shouldn't it?

Man, seeing the locking shenanigans that the driver developers end up
doing just in the last two weeks makes me question the "leave it to=20
the driver" attitude. I'd much rather have code that works than code
that is adaptive to multiple levels of incompetence.

> >I think I was trying to sell you on "more stable identifiers"=20
> >as a alternative to ALT_NAMEs for netdevs at some point ;) =20
>=20
> I don't recall that. Anyway, everyone loves ALT_NAMEs at this point :)

:)

> >> Okay, what's your suggestion going foreward then? =20
> >
> >Add the ID back, make bus/dev optional, forgo the faux dev?
> >Would that work? Would exiting CLI become very unhappy? :S =20
>=20
> Ha, that would break so many things, everything is based on
> bus/dev on UAPI level :/
>=20
> I was thinking about having some sort of *special-bus-name* for indexes,
> like:
>=20
> none/1
> none/2
> or
> devlink_id/1
> devlink_id/2
> or something like that.
>=20
> But it would be either that or original bus/dev, not both :/
>=20
> Perhaps we can add ID attr as optional/alternative handle? Then legacy
> userspace can use existing bus/dev handle and new can use the ID attr?
> Then the example output would look something like:
>=20
> $ devlink dev
> pci/0000:08:00.0: id 1
>   nested_devlink:
>     auxiliary/mlx5_core.eth.0
> devlink_id/2: id 2
>   nested_devlink:
>     pci/0000:08:00.0
>     pci/0000:08:00.1
> auxiliary/mlx5_core.eth.0: id 3
> pci/0000:08:00.1: id 4
>   nested_devlink:
>     auxiliary/mlx5_core.eth.1
> auxiliary/mlx5_core.eth.1: id 5
>=20
> Makes sense?

Yup, seems reasonable.

Alternatively we could add a socket or request flag to dumps that
indicates that user space is aware that some instances will not
have the bus/dev identifier?


