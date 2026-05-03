Return-Path: <linux-rdma+bounces-19891-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oPDKIcu092lDlQIAu9opvQ
	(envelope-from <linux-rdma+bounces-19891-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Sun, 03 May 2026 22:49:15 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D08C74B7619
	for <lists+linux-rdma@lfdr.de>; Sun, 03 May 2026 22:49:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D601D3003EA7
	for <lists+linux-rdma@lfdr.de>; Sun,  3 May 2026 20:49:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 999213A3E72;
	Sun,  3 May 2026 20:49:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="msmafhPA"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C4C0273D8D;
	Sun,  3 May 2026 20:49:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777841347; cv=none; b=g6Az8Yucoky9Scm3ZUt3YTObBn8DnRYQkU1cL68RLs/KcJt6/b1LpLQ+wb/8V47PWkDOaoTVsGH2MesEIKlDJVeUbN1pA6cLfJHBkYNVeYQguauqwDwC1UCasMxy+aBQWXPQmbsIOYaFNblUnTxZ6T1ZjJo8nww+I/Db65UOmow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777841347; c=relaxed/simple;
	bh=gIzNU8LwzMqNY/QvnB3HnKQNrOCeJtWknK8enZSajg4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=rO5ZSV2NCOgceH41UsjLicfVBRBeV6dJ2rTqCoYo/xUn1cJr2p0aFmD8dVYX9qoJ1Wr6BbaprP9Quxig+6UsySaREzpU385enPLmG0XS1JdPkl0tDP0dioIHaBp3EQ3hOdj2d6HcbI1RNYUD/F6yE/B8i9lN+gSpSNzjHYwkiPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=msmafhPA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72A86C2BCB4;
	Sun,  3 May 2026 20:49:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777841346;
	bh=gIzNU8LwzMqNY/QvnB3HnKQNrOCeJtWknK8enZSajg4=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=msmafhPA+a9sLz+TjeUHuWC9VbUej4MPjd0Ksk8bn4rclAqcGZtmR+ux1ycsa1K11
	 zvJm7MkodqitHMWSeOs/efMsvBS7tTHb+617Hf7kfvC2AuZ2+lwEs2IIoBiY1BbQkc
	 psggVeEp4QQVgjm3sz7E0RciVMY+xOo7vpnHr29wHQPqIoYskOB6e2DC1UZT2FJjs+
	 sqINfq5V7StOyBf9zUDKlfBgD3SNejyIVw0yiMghGJuwqWOLAZJkscgfwFikPg8KOf
	 UwlzoSYFFPC/e0LEfS4r1qv3nrZDkLxzdzopv8IZW3+QQamg5Gkao7lM7YlsHPdOKE
	 9faPAygmAUmlw==
Message-ID: <418cb8a0d079594ee5117487de1a1190a6a617d2.camel@kernel.org>
Subject: Re: [PATCH net-next v2 5/7] selftests: rds: Fix gcov and pcap
 collection
From: Allison Henderson <achender@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, pabeni@redhat.com, edumazet@google.com, 
 horms@kernel.org, linux-rdma@vger.kernel.org,
 linux-kselftest@vger.kernel.org,  shuah@kernel.org
Date: Sun, 03 May 2026 13:49:05 -0700
In-Reply-To: <20260502093858.35b27793@kernel.org>
References: <20260428222716.2960871-6-achender@kernel.org>
	 <20260430024206.2452353-1-kuba@kernel.org>
	 <20260429194806.6ae176a9@kernel.org>
	 <843faae8c03ce534fad28e73b155d33c84f69bee.camel@kernel.org>
	 <20260502093858.35b27793@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.3-0ubuntu1.1 
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Rspamd-Queue-Id: D08C74B7619
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-19891-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[achender@kernel.org,linux-rdma@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[run.sh:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

On Sat, 2026-05-02 at 09:38 -0700, Jakub Kicinski wrote:
> On Fri, 01 May 2026 22:43:04 -0700 Allison Henderson wrote:
> > > point #2 my vng does have an overlayfs mounted over /tmp so the
> > > mountpoint check doesn't trigger IDK if this is what you meant=20
> > > or I have a different version. =20
> >=20
> > I did try using --overlay-rwdir, and I think that gives rw to the
> > guest, but it's ro to the host, so we dont get to keep the pcaps post
> > mortem.
> >=20
> > What we can do, if it sounds ok to you, is set up a temp scratch area
> > in the rds_logs folder so it's not mounting over /tmp, and then
> > run.sh can handle the mount with a cleanup trap addressing Sashiko's
> > concern
> >=20
> > Let me know what you think?
>=20
> Oh, you need these files for a post mortem analysis? I missed that
> point. IDK if there's a well established way to save extra debug info
> from the tests. runner has per_test_log_dir but I don't think it's
> exposed to tests? Until ksft has such a thing I'd probably go with
> an extra env variable to point the test to a specific dir.
> Which dir will depend on the CI harness. If var is not set - don't
> output the logs or use /tmp and clean up when test exits.

Ok, I will see if I can do some refactoring and pull the log dir out
of the test scripts and into an environment variable.  I think that
should work if I adopt the $SUDO_USER pattern the other tests use.

Thank you for the reviews!
Allison


