Return-Path: <linux-rdma+bounces-22364-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id oe7aGhNtNGp7XwYAu9opvQ
	(envelope-from <linux-rdma+bounces-22364-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Fri, 19 Jun 2026 00:11:31 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id D90D46A2E7E
	for <lists+linux-rdma@lfdr.de>; Fri, 19 Jun 2026 00:11:30 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=proton.me header.s=protonmail header.b=bgYRoWzM;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-22364-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-rdma+bounces-22364-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=proton.me;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 10A9730422F4
	for <lists+linux-rdma@lfdr.de>; Thu, 18 Jun 2026 22:11:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5190341057;
	Thu, 18 Jun 2026 22:11:23 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-24416.protonmail.ch (mail-24416.protonmail.ch [109.224.244.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A8612C324C;
	Thu, 18 Jun 2026 22:11:16 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781820682; cv=none; b=gGR+mbZWs6Gmnqa05lzeaVJ5lozeCbImEiolWXM3N1fLGApTH+6B4K3yVVEFporuiUXJfwIh1QjCw259GDTTp2JWwpmmdDIR8jQqWoVatORgY+n3G0NgQyJ1v2JvaqBX/RvJDV3L++vQCwWmFnV2BF8Q4l5s3CoEnmjQYs2s/PY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781820682; c=relaxed/simple;
	bh=ehQ+2ki73VFPFugqmxLEvSOix82ktdRhDV2+UfUWFzk=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=b2jHgmuanirQlwMwG48Yq5lfk+vAHK2DXVP2FeG2IA0QsV0da3/jq16uSaaTVsp7es24HPc4+YsU1TJ+5qL+3lNE+maznVNmHpVCn0HfQ6aj0dyx6TZ9kneyRRyazhQdaYYLJymALfXafXpzy6HGusWV9GUY+/lGy40hh209awA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=bgYRoWzM; arc=none smtp.client-ip=109.224.244.16
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1781820668; x=1782079868;
	bh=pt+NtAQ+3A8GkJGwIllHQDgpWnwbUGIJzwmAJjCCD1Y=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=bgYRoWzMVBKHrMS7bxQuhIzZIUZrMHUXWBvoJAm+Uzo5YiB98ptLz1rSCUmKBnTOS
	 8f/qi82nxMti/vhgg5CXxTiPw2SEKZjrck2obNYI5Ksq6jIVsoDCRPkT07dDGd3wJ1
	 7Nqyh1Knk6DDV305Cn/cZP/EyIpWgAWabz0EFPvwpgAGWws170Fx1jMnjg4IsgGwfM
	 ddNXnZLXqVhFEgEpw/jBGico71NXk56mjE7fZzvRGk8rjEpKYyJG6/y9n9XoEMYDR6
	 Kr//IciYqcobxjha5zD/JX2qQ84dab52glXvsdrMMFVFeQhSIbfFUDEfkJedqSMgnh
	 3UzuNb6T+tsDw==
Date: Thu, 18 Jun 2026 22:11:05 +0000
To: Dust Li <dust.li@linux.alibaba.com>
From: Bryam Vargas <hexlabsecurity@proton.me>
Cc: Wenjia Zhang <wenjia@linux.ibm.com>, "D . Wythe" <alibuda@linux.alibaba.com>, Sidraya Jayagond <sidraya@linux.ibm.com>, Eric Dumazet <edumazet@google.com>, "David S . Miller" <davem@davemloft.net>, Mahanta Jambigi <mjambigi@linux.ibm.com>, Wen Gu <guwen@linux.alibaba.com>, Simon Horman <horms@kernel.org>, Ursula Braun <ubraun@linux.ibm.com>, Stefan Raspl <raspl@linux.ibm.com>, Tony Lu <tonylu@linux.alibaba.com>, Paolo Abeni <pabeni@redhat.com>, Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org, linux-s390@vger.kernel.org, linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/3] net/smc: bound the wire-controlled producer cursor to the RMB
Message-ID: <20260618221057.236673-1-hexlabsecurity@proton.me>
In-Reply-To: <ajQAwBMzCJfO9SM1@linux.alibaba.com>
References: <20260614-b4-disp-edd64be9-v3-0-551fa514257e@proton.me> <20260614-b4-disp-edd64be9-v3-1-551fa514257e@proton.me> <ajQAwBMzCJfO9SM1@linux.alibaba.com>
Feedback-ID: 199661219:user:proton
X-Pm-Message-ID: c358c3babde8b7fdb5b9b37d35e3aa6ad853e1d3
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[proton.me,quarantine];
	R_DKIM_ALLOW(-0.20)[proton.me:s=protonmail];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:dust.li@linux.alibaba.com,m:wenjia@linux.ibm.com,m:alibuda@linux.alibaba.com,m:sidraya@linux.ibm.com,m:edumazet@google.com,m:davem@davemloft.net,m:mjambigi@linux.ibm.com,m:guwen@linux.alibaba.com,m:horms@kernel.org,m:ubraun@linux.ibm.com,m:raspl@linux.ibm.com,m:tonylu@linux.alibaba.com,m:pabeni@redhat.com,m:kuba@kernel.org,m:netdev@vger.kernel.org,m:linux-s390@vger.kernel.org,m:linux-rdma@vger.kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-22364-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[hexlabsecurity@proton.me,linux-rdma@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	RCVD_COUNT_THREE(0.00)[3];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hexlabsecurity@proton.me,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[proton.me:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,proton.me:dkim,proton.me:mid,proton.me:from_mime,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: D90D46A2E7E

On Thu, 18 Jun 2026 22:29:20 +0800, Dust Li wrote:
> once we detect that the peer is misbehaving, I think the right action is
> to abort the connection and record the event, rather than silently clamp.
[...]
>         u32 prod_count =3D ntohs(cdc->prod.count);
> ...
>             cdc->prod.wrap > 1 || cdc->cons.wrap > 1) {

Thanks for taking a look, Dust. I'm on board with the direction for net-nex=
t --
aborting and recording a bad CDC is cleaner than clamping something we alre=
ady know
we can't trust, and as you say, the clamp just papers over the peer bug. So=
: minimal
clamp stays for -stable, and net-next gets the wire-boundary check + abort =
(through
abort_work, with an smc_stats counter and a ratelimited warn).

A few things I ran into on the check itself, though:

- count is __be32, so it wants ntohl() rather than ntohs() -- ntohs() ends =
up reading
  the wrong half.

- I'd drop the wrap > 1 tests. wrap is a free-running counter (smc_curs_add=
 does
  wrap++), so a connection that legitimately wraps its RMB ends up with wra=
p > 1; and
  since it's a __be16 read raw, on little-endian wrap=3D=3D1 already reads =
as 0x0100 and
  we'd abort on the very first wrap. I don't think there's a sane upper bou=
nd to put
  on wrap.

- the check is typed for SMC-R, but the SMC-D path hands a host-order smcd_=
cdc_msg to
  smc_cdc_msg_recv() cast as smc_cdc_msg (smc_cdc.c:456), so ntohl/ntohs wo=
uld
  double-swap it there. The simplest thing I found is one check on the host=
 cursor
  right after smc_cdc_msg_to_host(), before the diff/atomic_add block -- th=
at covers
  SMC-R and SMC-D in one place.

Minor: >=3D len rather than > len (count is an offset in [0,len)), and peer=
_rmbe_size
is signed so worth guarding. The cons vs peer_rmbe_size bound looks right t=
o me.

Happy to spin it whichever way you prefer.

Bryam


