Return-Path: <linux-rdma+bounces-21609-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +PRTMmtkHmrCiwkAu9opvQ
	(envelope-from <linux-rdma+bounces-21609-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 02 Jun 2026 07:04:43 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FE54628583
	for <lists+linux-rdma@lfdr.de>; Tue, 02 Jun 2026 07:04:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 38606300C306
	for <lists+linux-rdma@lfdr.de>; Tue,  2 Jun 2026 05:04:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE09227466A;
	Tue,  2 Jun 2026 05:04:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DoI0f47D"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF2ED2877F7;
	Tue,  2 Jun 2026 05:04:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780376678; cv=none; b=KIHspsvq22nGPIIJtD74ekpUwtP2rpNZ4803Kj+3jfHa3vzc5BkvfbmFOOgS6XHuC1YNpsowD8s78N+drgGYRMgm27CDO3QtyLs6P610pwyjFDW28ydbqB9ezEsfVln9EIjttudLg8Sdygeik3rsxsM476U9tM/Fyt0jyirFzF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780376678; c=relaxed/simple;
	bh=1yCY4Tm11Ve0rurH9KdOroMpYXs96kX8GwqppF8Muhw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=KtyIhHPkTA2mNnF4Z+0sJhD8MQ1+Jn6zuIJNIhBOqefPGtMwP1XsOQikX8CVAj6ovL3ZB9LKZNHIO5ebyvJxtl//QugfF7aZHTVAI9mBhKImryEYKIq5Ncgk/h0wWAh14P892xddkevsszgTc/kQWFgvjBv7WGqJWtc1qwhuhM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DoI0f47D; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18BAA1F00893;
	Tue,  2 Jun 2026 05:04:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780376677;
	bh=BEFyxiwlSr2KHbrQxImIjpt54/S03h4ARTIPEn9Z6p8=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=DoI0f47DbyMCyOwDZIrdI7HMeOKVuXMtV1Fun45XtXJ4oUxUM960u3iv9UZl042Wg
	 +J5e+pNzx2sEmjqSohr6wgzZLzlPo2bxkf46pCprpfK627x6vIjW3Y+WAHYnf7wg/e
	 xg7uz5CF2tvrLNs2ggnVYPWi/YVDEJWZ/gUlku25B8OZyDG3Ky6CrexhQc84bAjOQw
	 kYhn2wGwx02W4ldVpmI1UGkF071x8Zsm9QnGfMIBjQf2ncPa7eX8ye2KR7M7Y3277h
	 +Qcjp9h8uRxcyHlWzdlorQyq1irRuE1xBTNXDuenJk3WHYvYh6FYbvldhVs5VW0U+c
	 jIgKsmXIGbrGw==
Message-ID: <9a99b71acb54c2062d4ec5c1cf83fe3e45748c25.camel@kernel.org>
Subject: Re: [PATCH net-next v2 4/4] selftests: rds: report missing RDMA
 prereqs as XFAIL
From: Allison Henderson <achender@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, pabeni@redhat.com, edumazet@google.com, 
 horms@kernel.org, linux-rdma@vger.kernel.org,
 linux-kselftest@vger.kernel.org,  shuah@kernel.org
Date: Mon, 01 Jun 2026 22:04:36 -0700
In-Reply-To: <20260602022449.1634587-1-kuba@kernel.org>
References: <20260527023423.387792-5-achender@kernel.org>
	 <20260602022449.1634587-1-kuba@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21609-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[achender@kernel.org,linux-rdma@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,runner.sh:url]
X-Rspamd-Queue-Id: 6FE54628583
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, 2026-06-01 at 19:24 -0700, Jakub Kicinski wrote:
> This is an AI-generated review of your patch. The human sending this
> email has considered the AI review valid, or at least plausible.
> ---
> selftests: rds: report missing RDMA prereqs as XFAIL
>=20
> This commit changes the exit code and message tag for RDMA prerequisites =
in
> the RDS selftests to report as an expected failure instead of a skip.
>=20
> > diff --git a/tools/testing/selftests/net/rds/rds_run.sh b/tools/testing=
/selftests/net/rds/rds_run.sh
> > --- a/tools/testing/selftests/net/rds/rds_run.sh
> > +++ b/tools/testing/selftests/net/rds/rds_run.sh
> > @@ -123,10 +123,10 @@ check_rdma_conf_enabled() {
> >  		probe_module "$2"
> >  		return
> >  	fi
> > -	echo "selftests: [SKIP] rdma transport requires $1 enabled"
> > +	echo "selftests: [XFAIL] rdma transport requires $1 enabled"
> >  	echo "To enable, run" \
> >  	     "tools/testing/selftests/net/rds/config.sh -r and rebuild"
> > -	exit 4
> > +	exit 5
>=20
> [Severity: High]
> Is exit code 5 the correct value for an expected failure in the kselftest
> framework?
>=20
> Looking at the kselftest framework in tools/testing/selftests/kselftest.h
> and ktap_helpers.sh, the expected failure code (KSFT_XFAIL) is defined as=
 2.
>=20
> When runner.sh receives an exit code of 5, it does not match KSFT_XFAIL.
> Instead, it falls through to the default case and calls ktap_test_fail,
> which logs a hard test failure.
>=20
> Could this actively fail the test in the continuous integration environme=
nts
> rather than marking it as an expected failure?

You're right its 2, good catch.  I will fix that and config.sh in a v3.  Th=
anks!
Allison

>=20
> [ ... ]


