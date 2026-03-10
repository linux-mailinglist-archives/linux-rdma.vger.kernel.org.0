Return-Path: <linux-rdma+bounces-17922-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sGB0KhmwsGnGmAIAu9opvQ
	(envelope-from <linux-rdma+bounces-17922-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 11 Mar 2026 00:58:17 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A9B625971A
	for <lists+linux-rdma@lfdr.de>; Wed, 11 Mar 2026 00:58:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 41305305328B
	for <lists+linux-rdma@lfdr.de>; Tue, 10 Mar 2026 23:58:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D7FF391E58;
	Tue, 10 Mar 2026 23:58:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YWyPij26"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60B4631A7E4;
	Tue, 10 Mar 2026 23:58:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773187090; cv=none; b=Vpdd7CqjmwTzLrTPO/vhL/thdnPsmTdApotUtD5d0XD0ng5qBS9ACP97DnmjLDCdlw8fdB/YjC+uCXmTB6iqbpTYTy689edMxAG876inVlA/EzgR5mxjfHpecDgrbNsgcGJVSSesj/ZL5bCTswcGqOabVcyOwnYOQge6J6om48Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773187090; c=relaxed/simple;
	bh=sOArtoQGyiH6UdnGufIAEk8BopJ6QZnslTNEH+JMmUY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ajGcp44CzJR4dwYYlwn4pXUwFmYaC2GL1v/QqjAWDcyi77lhla1E+ESexpDNMTCsjdL2LGeu1oWbPEAISjaN6l/SABqlisf8KNbwbqOiO/b1USpYCL5GpFhtgCn2sqBJiM5XG5jf6uCoidWVQitB/yEBIlfSpmAfYv7Kj3GsUVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YWyPij26; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C84DC19423;
	Tue, 10 Mar 2026 23:58:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773187089;
	bh=sOArtoQGyiH6UdnGufIAEk8BopJ6QZnslTNEH+JMmUY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=YWyPij26+AL5mrAHWqWGaYKCVO7s8prJHb3pzvCy69M91oUIOUNFH5UkRXKJk3PWi
	 uN8pEN7CEic2Xw5vWxZI18t7qlFwuTW7uFbP1M5YjKAypf/b8XGUw0dlIiziKkbu4b
	 8prrF/MYU6DjI2TM23oWpFL/hX/0fYtSCoPgy3kRJPRbMq7qI2rQj8sr03PgdYWChP
	 p7CqRNPr4ainoradYR2n9n2R2NdJja4u4iMz67PhPJw3pg7IoEOdZ7wduKKN0zUmgS
	 J+GHHCTsP0j7MuAaaSTFTtKmT0lW4GlivC3sxHLt186ahE4BAn3QyY2dpUZkR94uxe
	 y0JhcRdsJM6eQ==
Date: Tue, 10 Mar 2026 16:58:08 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Mark Bloch <mbloch@nvidia.com>
Cc: Tariq Toukan <tariqt@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
 Jason Gunthorpe <jgg@ziepe.ca>, Saeed Mahameed <saeedm@nvidia.com>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>,
 linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
 netdev@vger.kernel.org, Gal Pressman <gal@nvidia.com>, Dragos Tatulea
 <dtatulea@nvidia.com>, Moshe Shemesh <moshe@nvidia.com>, Shay Drory
 <shayd@nvidia.com>, Alexei Lazar <alazar@nvidia.com>
Subject: Re: [PATCH mlx5-next 8/8] {net/RDMA}/mlx5: Add LAG demux table API
 and vport demux rules
Message-ID: <20260310165808.11b88b7f@kernel.org>
In-Reply-To: <020de4ef-17bc-43a3-83e0-469073ffa22b@nvidia.com>
References: <20260308065559.1837449-1-tariqt@nvidia.com>
	<20260308065559.1837449-9-tariqt@nvidia.com>
	<20260308085248.2427feed@kernel.org>
	<a10faf04-36c2-4070-ac8b-86b110e6976c@nvidia.com>
	<20260309143320.1cee163d@kernel.org>
	<020de4ef-17bc-43a3-83e0-469073ffa22b@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 2A9B625971A
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-17922-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Action: no action

On Tue, 10 Mar 2026 08:05:39 +0200 Mark Bloch wrote:
> On 09/03/2026 23:33, Jakub Kicinski wrote:
> > On Sun, 8 Mar 2026 20:34:26 +0200 Mark Bloch wrote: =20
> >> Thanks for catching this. We=E2=80=99ll address it.
> >>
> >> Also, I saw IA flagged issues con
> >> =E2=80=9Cnet/mlx5: LAG, replace pf array with xarray=E2=80=9D.
> >> Just for context, lag_lock is already a known problematic
> >> area for us, and we do have plans to remove it. I ran the
> >> review prompts locally in ORC mode, so I assume I saw the
> >> same comments as NIPA.
> >>
> >> So the issue raised there is not really a new one. lag_lock
> >> already has some known issues today, but we do not expect to
> >> hit this particular case in practice, since by the time
> >> execution reaches mdev removal, the LAG should already have
> >> been destroyed and the netdevs already removed for the driver
> >> internal structures. =20
> >=20
> > Ack, I haven't looked at the AI reivew TBH.
> > As usual with known AI flags - should the explanation be part=20
> > of the commit message? =20
>=20
> That's an interesting question.
> I'll try to give my 0.02$ about the general case.
> Out of curiosity I ran one of our upcoming internal series
> through both Mason's prompts with Claude and our internal
> AI review tool.
>=20
> Mason's + Claude reported 3 false positives.
>=20
> Our internal AI tool also reported 3 false positives (interestingly,
> they were different issues) and 1 real issue, which I already knew
> about since the author hasn't fixed it yet.
>=20
> So in theory we could add a note like =E2=80=9CAI tools may flag issues
> X/Y/Z but those are not valid here=E2=80=9D, but in practice it really
> depends on which tool is used and how it's configured.
>=20
> At the moment it seems that netdev/NIPA is using Mason's prompts
> with Claude, so if anything that would probably be the default
> reference.
>=20
> The larger question is that running NIPA before submission is
> not currently required. Are there any plans to make that part
> of the submission expectations, and not just encouraged?

No, no, the process angle is not how I look at this.
We should only add comments to the commit message or code if there's
genuine ambiguity. Basically if someone reading the code may also get
confused there should be an explanation somewhere. We should not be
adding any code or explanations to make tools happy.=20

