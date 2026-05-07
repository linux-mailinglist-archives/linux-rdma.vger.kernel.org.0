Return-Path: <linux-rdma+bounces-20163-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MCRMAB2m/GmwSQAAu9opvQ
	(envelope-from <linux-rdma+bounces-20163-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 07 May 2026 16:47:57 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id C6E824EA7CC
	for <lists+linux-rdma@lfdr.de>; Thu, 07 May 2026 16:47:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id DF8EA301D269
	for <lists+linux-rdma@lfdr.de>; Thu,  7 May 2026 14:47:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24D7240FDB9;
	Thu,  7 May 2026 14:47:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p/RDsfzi"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B162C3F7A99;
	Thu,  7 May 2026 14:47:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778165241; cv=none; b=gCErKk524oZ6sNavGxRFL/+hES2xF8eJ7kKW2zyth8LE0xxtY5qX5+O72b7ehN9FRuwVVAtcboeAnr/pMSCIYrotUA80ML3gLBUewUqQCqDq467JbUFsC75Y5O3dWfx3TWLJmYb2Mz1K7O7Llb4qTPMv2+UgMtXpg66yfUAvvuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778165241; c=relaxed/simple;
	bh=6CV7HdbeNSl06n0xuhXim80DuThX9YsPcrFRthI9Zis=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PxnZ9tXqhIgPhdHn+I9HFrHPaygBPmSco45mRmPi4FviPDvyrmnGhwAgUg/4et9CgNsSID1+l4r5B+k6/3d1cXppDdo8hDEGjZ4r6hFovUquiRvcal1QaRDqrFraAHToV2utaA3UIE7Ue+WvvOis/96f/rWZp0zjsOvgJELqPLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p/RDsfzi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5250FC2BCB2;
	Thu,  7 May 2026 14:47:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778165241;
	bh=6CV7HdbeNSl06n0xuhXim80DuThX9YsPcrFRthI9Zis=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=p/RDsfzie5IRYBke1O6tkDC53ZoU/YhMkdkQaTZqKFmqQrBqZB4z3Fr/adK9X3Cx8
	 L89ecUd4stm1RVchXddl/ykR3/h0TxwFA5CpyPPzTvcITK2uwxdUQDQcuiwNZ15myj
	 XVWr7meT6cZCpoixmj6zkkmFkybmYQ7V4wM7LmR3cI7G2A95wNyaExHc5gz7S790bN
	 YWUIeEdQCR6aMcfH/sZ62FSmIbnMvHSI7i+1x/VlCQFTrrD75eW79M3teQpDXXoF0n
	 Oa7iC2Mrb6YYT4wypYpwQZhwJlsgqFl27nkZr7gM9pdbH93jTA5GzcfH9ZfCmEzmLD
	 qrdPNEp5H0Keg==
Date: Thu, 7 May 2026 07:47:19 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Ivan Vecera <ivecera@redhat.com>
Cc: Jiri Pirko <jiri@resnulli.us>, netdev@vger.kernel.org, Andrew Lunn
 <andrew+netdev@lunn.ch>, Arkadiusz Kubalewski
 <arkadiusz.kubalewski@intel.com>, "David S. Miller" <davem@davemloft.net>,
 Donald Hunter <donald.hunter@gmail.com>, Eric Dumazet
 <edumazet@google.com>, Jonathan Corbet <corbet@lwn.net>, Leon Romanovsky
 <leon@kernel.org>, Mark Bloch <mbloch@nvidia.com>, Michal Schmidt
 <mschmidt@redhat.com>, Paolo Abeni <pabeni@redhat.com>, Pasi Vaananen
 <pvaanane@redhat.com>, Petr Oros <poros@redhat.com>, Prathosh Satish
 <Prathosh.Satish@microchip.com>, Saeed Mahameed <saeedm@nvidia.com>, Shuah
 Khan <skhan@linuxfoundation.org>, Simon Horman <horms@kernel.org>, Tariq
 Toukan <tariqt@nvidia.com>, Vadim Fedorenko <vadim.fedorenko@linux.dev>,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-rdma@vger.kernel.org
Subject: Re: [PATCH net-next v3 1/2] dpll: add fractional frequency offset
 to pin-parent-device
Message-ID: <20260507074719.51bc4954@kernel.org>
In-Reply-To: <541f767d-222b-4dfa-a95a-19a5ed7a46bf@redhat.com>
References: <20260504155340.411063-1-ivecera@redhat.com>
	<20260504155340.411063-2-ivecera@redhat.com>
	<20260506183342.767b5fbc@kernel.org>
	<541f767d-222b-4dfa-a95a-19a5ed7a46bf@redhat.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: C6E824EA7CC
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-20163-lists,linux-rdma=lfdr.de];
	FREEMAIL_CC(0.00)[resnulli.us,vger.kernel.org,lunn.ch,intel.com,davemloft.net,gmail.com,google.com,lwn.net,kernel.org,nvidia.com,redhat.com,microchip.com,linuxfoundation.org,linux.dev];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[24];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TO_DN_SOME(0.00)[]
X-Rspamd-Action: no action

On Thu, 7 May 2026 08:12:01 +0200 Ivan Vecera wrote:
> >> @@ -299,6 +299,10 @@ zl3073x_dpll_input_pin_ffo_get(const struct dpll_=
pin *dpll_pin, void *pin_priv,
> >>   {
> >>   	struct zl3073x_dpll_pin *pin =3D pin_priv;
> >>  =20
> >> +	/* Only rx vs tx symbol rate FFO is supported */
> >> +	if (dpll)
> >> +		return -ENODATA;
> >> +
> >>   	*ffo =3D pin->freq_offset; =20
> >=20
> > It's easy for driver authors to forget this sort of validation.
> > We should fail close, so it's better to have some "capability"
> > bits or something for the driver to opt into getting given format
> > of the call. =20
>=20
> Regarding the fail-close concern =E2=80=94 I agree that relying on drivers
> to check dpll=3D=3DNULL is fragile. A capability bit alone wouldn't help
> though, since the driver still needs to distinguish which FFO context
> is being requested.
>=20
> I can think of two approaches:
> 1. An explicit bool parameter (e.g. `bool per_parent`) instead of
>     overloading the dpll pointer for context distinction.
> 2. Separate callbacks for each FFO context (e.g. ffo_get for the
>     top-level and ffo_parent_get for the per-parent).
>=20
> Do you have a preference, or something else in mind?

TAL at the fields at the beginning of struct ethtool_ops
If we had two bits in the ops struct for driver to declare / opt-in
to each context the core can avoid calling the driver if it doesn't
support a context.

