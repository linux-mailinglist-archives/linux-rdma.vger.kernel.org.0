Return-Path: <linux-rdma+bounces-18701-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QKF5BAYCxWlZ5gQAu9opvQ
	(envelope-from <linux-rdma+bounces-18701-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 26 Mar 2026 10:53:10 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id B2BBB332B28
	for <lists+linux-rdma@lfdr.de>; Thu, 26 Mar 2026 10:53:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 15A0231198C6
	for <lists+linux-rdma@lfdr.de>; Thu, 26 Mar 2026 09:45:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 980D537417D;
	Thu, 26 Mar 2026 09:44:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qk4SWL0B"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6662D377550
	for <linux-rdma@vger.kernel.org>; Thu, 26 Mar 2026 09:44:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774518297; cv=none; b=rd2PcimUQ1N+Az4qN1ocLDC27BzT/vaAqp7lEAMLH9C3UeQqQzDsn/Wtz9wD9UVqGFWiIn2iUyKofHAZjKbVVnfvdu2Vjo6EOsr253vG9BTjvTFty5N5XCy3AfuEwx5T0dxgZrPtAj1mtbT8m811XIYID4cOdV90/dH5WeTNV2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774518297; c=relaxed/simple;
	bh=SwK+xrVkILMxAk+bQOoYhEd8oWiRnuLGcIQjwqqEHC8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Z/iOCz1kTanOC5OPGcLFemjNLSLbbVnWDodf4VJgTlFAk20lxpZtH+krhBsqYapNhs1+sHXCAc6ohHFnaGnHpKBygPrvlyJIOr+SoFSu9vpdkAjYUPSs4oOUYY4fg2zitBC3dLwqYp//KCEwsALgydbEs9+PDo5oScb7BrFCtJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qk4SWL0B; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B83FDC2BC87
	for <linux-rdma@vger.kernel.org>; Thu, 26 Mar 2026 09:44:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774518296;
	bh=SwK+xrVkILMxAk+bQOoYhEd8oWiRnuLGcIQjwqqEHC8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=qk4SWL0BS2oZHiDUvBW/bAxeHx1BXEOWfGKaMh4imMYuvXydMJQxKaiYS4vQGqpRA
	 KJl5vGs3KFn0zqG0hGubfZQ+ieLSVRDmDy4ZSjU3fJsf8ou+XPp7UrwCZQjAx4+Fdu
	 ZZAKnISxQ6mTuselNzsg55K0hHAUs+POyB9XWBxXtVgER803OVVJnlcmKnCqjdp2Yk
	 UqDAEyiskT00D6jK1ygmtILaGQQsgpSA65xFiHQpIs2ARMLeNmYQHUHzujjwsiSvdM
	 2RgAAohQUjLJ0+9FITXef3rwVKFdyy8oNfMnF589By3bfREuGCIqEb+lyyzZQ2U7dh
	 bivJsHrC9DzCg==
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-505a1789a27so4395331cf.3
        for <linux-rdma@vger.kernel.org>; Thu, 26 Mar 2026 02:44:56 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCV7ljmRSb7sPlwfxzIHzTMssSyShUKfDYy7b67vi3dq5KFeLfJbjN66d3lixNx13MFlzGQ8enkhwg/8@vger.kernel.org
X-Gm-Message-State: AOJu0YxZo0qsHouEkCfqkj5mzMSiW8Md+zTojlBaZ/yY0S9JXfu4fVzq
	ZFDs3Qo9GOUkmQl1iqEIgpOZR4UAb0rxBw4KXddrrh7gXS53V0NR92x+lPAjx5DzhA6RqRUQogf
	iyIux+j3sCFOSpYGL4+eaHOGMt6MpyCI=
X-Received: by 2002:ac8:5a8f:0:b0:50b:2d93:97b2 with SMTP id
 d75a77b69052e-50b80d1aa89mr96117381cf.23.1774518295241; Thu, 26 Mar 2026
 02:44:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260325145022.2607545-1-bjorn@kernel.org> <20260325145022.2607545-10-bjorn@kernel.org>
 <acT8O5vHc7gl6hzG@gmail.com>
In-Reply-To: <acT8O5vHc7gl6hzG@gmail.com>
From: =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
Date: Thu, 26 Mar 2026 10:44:44 +0100
X-Gmail-Original-Message-ID: <CAJ+HfNh0su+Ei+ET8YYNsZwNR+MuHCBakuof6akavQR0kLx0jg@mail.gmail.com>
X-Gm-Features: AQROBzBqP5kFyddHgaLVB_TU1Jo_YEll9H_X4UmnFm7jfjc29GXNVciOBMmOjNg
Message-ID: <CAJ+HfNh0su+Ei+ET8YYNsZwNR+MuHCBakuof6akavQR0kLx0jg@mail.gmail.com>
Subject: Re: [PATCH net-next v2 09/12] selftests: drv-net: Add MAC loopback
 netdevsim test
To: Breno Leitao <leitao@debian.org>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, Donald Hunter <donald.hunter@gmail.com>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Maxime Chevallier <maxime.chevallier@bootlin.com>, Naveen Mamindlapalli <naveenm@marvell.com>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Danielle Ratson <danieller@nvidia.com>, Hariprasad Kelam <hkelam@marvell.com>, 
	Ido Schimmel <idosch@nvidia.com>, Kory Maincent <kory.maincent@bootlin.com>, 
	Leon Romanovsky <leon@kernel.org>, Michael Chan <michael.chan@broadcom.com>, 
	Oleksij Rempel <o.rempel@pengutronix.de>, Pavan Chebbi <pavan.chebbi@broadcom.com>, 
	Piergiorgio Beruto <piergiorgio.beruto@gmail.com>, Russell King <linux@armlinux.org.uk>, 
	Saeed Mahameed <saeedm@nvidia.com>, Shuah Khan <shuah@kernel.org>, Tariq Toukan <tariqt@nvidia.com>, 
	Willem de Bruijn <willemb@google.com>, Kees Cook <kees@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-rdma@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.10 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MIXED_CHARSET(0.56)[subject];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,davemloft.net,lunn.ch,gmail.com,google.com,kernel.org,bootlin.com,marvell.com,redhat.com,nvidia.com,broadcom.com,pengutronix.de,armlinux.org.uk];
	TAGGED_FROM(0.00)[bounces-18701-lists,linux-rdma=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[29];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[bjorn@kernel.org,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: B2BBB332B28
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Breno!

On Thu, 26 Mar 2026 at 10:33, Breno Leitao <leitao@debian.org> wrote:
>
> On Wed, Mar 25, 2026 at 03:50:16PM +0100, Bj=C3=B6rn T=C3=B6pel wrote:
>
> > +def _dfs_write_u32(cfg, path, val):
> > +    with open(os.path.join(_nsim_dfs_path(cfg), path), "w",
> > +              encoding=3D"utf-8") as f:
> > +        f.write(str(val))
>
> This function doesn't seem to be called, right?

Indeed -- another leftover! Thank you!

> > +def main() -> None:
> > +    """Run netdevsim loopback tests."""
> > +    with NetDrvEnv(__file__) as cfg:
> > +        cfg.ethnl =3D EthtoolFamily()
>
> Given some functions above assume this is nsim, should you call
> cfg.require_nsim() ?

Yeah, or directly from NetDrvEnv() statement above! Good point! Will fix!


Bj=C3=B6rn

