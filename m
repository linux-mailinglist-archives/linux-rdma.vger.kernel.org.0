Return-Path: <linux-rdma+bounces-21145-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SA2RNybfD2rQQwYAu9opvQ
	(envelope-from <linux-rdma+bounces-21145-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Fri, 22 May 2026 06:44:22 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 423B45AEBEF
	for <lists+linux-rdma@lfdr.de>; Fri, 22 May 2026 06:44:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CC4B6301FF90
	for <lists+linux-rdma@lfdr.de>; Fri, 22 May 2026 04:39:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F21F835674D;
	Fri, 22 May 2026 04:39:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Cz+h84c4"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6E9527A12F;
	Fri, 22 May 2026 04:39:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779424782; cv=none; b=M3zB0Gq6Okn+ea1qpSz5+xlPkY7eNZt7c2/G7BD0J6jBj/h97/sZfu0eXqJLFpjhhUAOv875kghtncNHWO2mKGp2lYqMKAcNWKBi7XOWRZ7r2T6UBXi21/lI8eN4NHozPFMr9q5rBs2NgRVC3JghoKc7FqCA3hebXRhHEeHof0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779424782; c=relaxed/simple;
	bh=C7+YzVYtsz/EZFWqgdGMLr2EyKYkV7ac23n7pAyctBE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=TGrGRApYT9BfzRrFGuqiiS/SARKM/yWTj6kyvQileaEWKtczducC60rvex3SEgIfyTy30ZLvaOOad5TVZ1Qh0fI6WoVk88pNu14hDzaRLTXGbfF1IzXK0CbtbkWSaejB4NIHXm1+9smPyBGOKrgB+IZrXRQGM9tRpx5+5H114Vc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Cz+h84c4; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB78F1F00A3D;
	Fri, 22 May 2026 04:39:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779424781;
	bh=5LgnvYKTPbZg7JogF97PcfSYs8oii2zGLF8FAHnz2ys=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=Cz+h84c4ZapqclyCiNsbvntPZ4t/NTEe88Kp67BZP4kdPes3UFrl6ApY12biAVQZs
	 a/uLaNTBJlTstmKWv64EYe1dZ7kc9JxLh0nLmPID7tKPfTRx8nVIrLTnf+07/tKqqX
	 D/PYvnM5nDXCwLMMg7E/fmST4JmORgpESjG5wUockS1rVQG/s6a90GziX+O7H0jnC9
	 5n14J26n12t8xHUd4NmrDhlWWeGokROvQxmlUnNDVO64Bu8a7Gr49hWQXRkOQeNCtp
	 olUxqY1YDaNZ1YuKW7vNOj62nJwJGpuNjWgMLRjLW2s7Y5Az5zcVPLHdcfMijWl7JD
	 azqc59E4naqUw==
Message-ID: <732da40e8718513c0f4799fcb93dd8148951a7d7.camel@kernel.org>
Subject: Re: [PATCH net] selftests: rds: config: disable modules
From: Allison Henderson <achender@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>, "Matthieu Baerts (NGI0)"
	 <matttbe@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>,  Paolo Abeni <pabeni@redhat.com>, Simon Horman
 <horms@kernel.org>, Shuah Khan <shuah@kernel.org>,  netdev@vger.kernel.org,
 linux-rdma@vger.kernel.org, rds-devel@oss.oracle.com, 
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Thu, 21 May 2026 21:39:40 -0700
In-Reply-To: <20260521074212.66205e90@kernel.org>
References: <20260520-net-rds-config-modules-v1-1-2100df02fe9a@kernel.org>
	 <20260521074212.66205e90@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.3-0ubuntu1.1 
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21145-lists,linux-rdma=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[achender@kernel.org,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-rdma];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,run.sh:url]
X-Rspamd-Queue-Id: 423B45AEBEF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, 2026-05-21 at 07:42 -0700, Jakub Kicinski wrote:
> On Wed, 20 May 2026 11:34:43 +1000 Matthieu Baerts (NGI0) wrote:
> > The run.sh script explicitly checks that CONFIG_MODULES is disabled.
> >=20
> > By default, this config option is enabled. Explicitly disable it to be
> > able to run the RDS tests.
> >=20
> > Note that writing '# CONFIG_(...) is not set' is usually recommended to
> > disable an option in the .config, but it looks like selftests usually
> > set 'CONFIG_(...)=3Dn', which looks clearer.
> >=20
> > Fixes: 0f5d68004780 ("selftests: rds: add tools/testing/selftests/net/r=
ds/config")
> > Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
> > ---
> >  tools/testing/selftests/net/rds/config | 1 +
> >  1 file changed, 1 insertion(+)
> >=20
> > diff --git a/tools/testing/selftests/net/rds/config b/tools/testing/sel=
ftests/net/rds/config
> > index 97db7ecb892a..3d62d0c750a8 100644
> > --- a/tools/testing/selftests/net/rds/config
> > +++ b/tools/testing/selftests/net/rds/config
> > @@ -1,3 +1,4 @@
> > +CONFIG_MODULES=3Dn
> >  CONFIG_NET_NS=3Dy
> >  CONFIG_NET_SCH_NETEM=3Dy
> >  CONFIG_RDS=3Dy
>=20
> Hm, okay, if it works it works, but IIUC disabling modules turns all =3Dm
> from the default config into =3Dn (not =3Dy as one would naively hope?) s=
o
> this may come back to bite us. Unless there's a strong reason to not use
> modules it may be good to follow up in net-next and life this
> requirement.

Ok, thanks for the feedback. I will work on a follow up set to rework the m=
odule configs as well as rename the scripts.
I think the initial motivation for CONFIG_MODULES=3Dn was to simplify gcov =
collection, but it should work either way.  I
will try to get a patch set out later this week.  Thank you!

Allison


