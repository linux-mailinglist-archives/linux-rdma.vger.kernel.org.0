Return-Path: <linux-rdma+bounces-19844-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mOfwKvGO9WmyMQIAu9opvQ
	(envelope-from <linux-rdma+bounces-19844-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Sat, 02 May 2026 07:43:13 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CAFA4B10E8
	for <lists+linux-rdma@lfdr.de>; Sat, 02 May 2026 07:43:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B83C03010D8D
	for <lists+linux-rdma@lfdr.de>; Sat,  2 May 2026 05:43:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F4522E173B;
	Sat,  2 May 2026 05:43:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VUM/ilRS"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5212C1F5EA;
	Sat,  2 May 2026 05:43:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777700586; cv=none; b=KbmSP3+RcoNEWkaXnm5KVmaN1bu09IwXDqd4mDmtDMKEokrxkFlydynS2sKwz7A/eUhSHQWHerbTtImFIYzPG5sxZbHqq23xMGPEqdFyyHstjk8+enpn/YzQNrU29MigYQiYHazhQmgJQ0/hmoe7E8TeGekQlyd1wKdhKqyNYAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777700586; c=relaxed/simple;
	bh=Nr7AV1GzCHWBC8xql0XXEM349ProPu1/5328GUpuDRY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=K51YzWrOoWokZHHUE6x10pxCm3LagXqfKd9+Fvo9VW2W8WsBC24BFVKpk7OqikxQrgh81fSOsM0ZZF5ZdoLPb75RUcLSGtI6nIW4rVnVuFBBjMmbHovBzaDSks6iwo+R+MkHA5X5Jtjn8sGgQt4Vi6DI7SiAefCtFOLTPDS4MS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VUM/ilRS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85CC8C19425;
	Sat,  2 May 2026 05:43:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777700586;
	bh=Nr7AV1GzCHWBC8xql0XXEM349ProPu1/5328GUpuDRY=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=VUM/ilRSVApNL2bTxhJGsPkQJJ4gnCKJHKFHumKW7eT8JuoeuyeF5KGpBOStH1Feu
	 oaq6O0TNmk8ILGZJ9i0IRRihkgZ6sZTz575JHVW2VcbMjBYXqOnUkRyTr7rHPWSsv7
	 j6aG6Xq/Nhnd95+wo/iQ/rJtZvj7N+ClEwxvsFmyj35E7Rxj64Ku50CMYXSeyqEHqZ
	 BXNOSSHVCDEs/Ao9ZXBrE8D6krakOWl0TFWkCH9sBRKNv1YDDPHkpt+OPHRHiZmvrr
	 JhHgerIlXAzFKOryPPmaj/wKdKFVse/csFKJ+EBF0iXMhHsvq1QTq9RGoUxXK6Fnh3
	 36tq50/aNKysg==
Message-ID: <843faae8c03ce534fad28e73b155d33c84f69bee.camel@kernel.org>
Subject: Re: [PATCH net-next v2 5/7] selftests: rds: Fix gcov and pcap
 collection
From: Allison Henderson <achender@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, pabeni@redhat.com, edumazet@google.com, 
 horms@kernel.org, linux-rdma@vger.kernel.org,
 linux-kselftest@vger.kernel.org,  shuah@kernel.org
Date: Fri, 01 May 2026 22:43:04 -0700
In-Reply-To: <20260429194806.6ae176a9@kernel.org>
References: <20260428222716.2960871-6-achender@kernel.org>
	 <20260430024206.2452353-1-kuba@kernel.org>
	 <20260429194806.6ae176a9@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.3-0ubuntu1.1 
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Rspamd-Queue-Id: 5CAFA4B10E8
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
	TAGGED_FROM(0.00)[bounces-19844-lists,linux-rdma=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,simult_flows.sh:url,run.sh:url]

On Wed, 2026-04-29 at 19:48 -0700, Jakub Kicinski wrote:
> On Wed, 29 Apr 2026 19:42:06 -0700 Jakub Kicinski wrote:
> > > +# tcpdump saves pcaps to /tmp because it requires chown to save the
> > > +# pcap but chown is not supported by 9p.  Mount tmpfs on /tmp if it =
is
> > > +# not already a separate filesystem
> > > +if ! mountpoint -q /tmp 2>/dev/null; then
> > > +	mount -t tmpfs tmpfs /tmp
> > > +fi
> > > + =20
> >=20
> > Could this introduce a regression when the test is run directly on a ho=
st
> > workstation rather than inside an isolated VM?
> >=20
> > If /tmp is a regular directory on the root filesystem, mounting tmpfs o=
ver it
> > will instantly hide all existing files and UNIX domain sockets in /tmp.
> >=20
> > Since there is no cleanup trap to unmount it on exit or failure, does t=
his
> > leave the host system in a degraded state?
>=20
> I share Sashiko's mixed feelings here. Do other tests mount /tmp ?
> Seems like something that belongs in the "CI setup", external
> to ksft itself.
Ok, I did some looking around, and while I dont see any tests that mount /t=
mp, I did notice that mptcp_join.sh and
simult_flows.sh use a $SUDO_USER, presumably to get away from the chown iss=
ue. But without getting off the 9p fs
with some sort of scratch area, we still end up with empty pcaps.

>=20
> point #2 my vng does have an overlayfs mounted over /tmp so the
> mountpoint check doesn't trigger IDK if this is what you meant=20
> or I have a different version.

I did try using --overlay-rwdir, and I think that gives rw to the guest, bu=
t it's ro to the host, so we dont get to keep
the pcaps post mortem.

What we can do, if it sounds ok to you, is set up a temp scratch area in th=
e rds_logs folder so it's not mounting over
/tmp, and then run.sh can handle the mount with a cleanup trap addressing S=
ashiko's concern

Let me know what you think?

Thank you for the reviews!
Allison


