Return-Path: <linux-rdma+bounces-22365-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 2FNVJxttNGqFXwYAu9opvQ
	(envelope-from <linux-rdma+bounces-22365-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Fri, 19 Jun 2026 00:11:39 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BB946A2E84
	for <lists+linux-rdma@lfdr.de>; Fri, 19 Jun 2026 00:11:39 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=proton.me header.s=bfrxb2nnezcp3cvh3sa6jyynqa.protonmail header.b=ZjaAxUZa;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-22365-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="linux-rdma+bounces-22365-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=proton.me;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1631A3045C93
	for <lists+linux-rdma@lfdr.de>; Thu, 18 Jun 2026 22:11:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC32D341057;
	Thu, 18 Jun 2026 22:11:27 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-106119.protonmail.ch (mail-106119.protonmail.ch [79.135.106.119])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEAF325B0B0
	for <linux-rdma@vger.kernel.org>; Thu, 18 Jun 2026 22:11:19 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781820685; cv=none; b=hYuGrd1wRzbHOAD59gbxduDSnoWepzW0z0JgBO/OBvGvW8y5YHUYg8WY5IYjnON1b1I619wOAArSM89HluIiPAGE6Lc2tdtsQ3PA7cYMmLOByQgbCEpH4jLZko32NSyanYUPMh7YUs4fB7OL3tfIaYPClXfTPNWC9Ag/i7YLIgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781820685; c=relaxed/simple;
	bh=wNM4VsONE318crg3+U6Q5LwgFyg/2FxR/2mNll/CtWs=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dQbBipy7HNWZHd83D5XbR/y/JFymWULzN5kLd12LmXu30/Nb7OWUFeDgDa6vSQZXEKuvQlRcvL7H1hmm+EXY6nR9HiEDHHyCKG6eGImOFHCudkLCG13gbyxHjrVf2hFvtkDyV+EwZTsru5BidxOjUcgXjwWDzWeuZauPlTmQB7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=ZjaAxUZa; arc=none smtp.client-ip=79.135.106.119
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=bfrxb2nnezcp3cvh3sa6jyynqa.protonmail; t=1781820677; x=1782079877;
	bh=wNM4VsONE318crg3+U6Q5LwgFyg/2FxR/2mNll/CtWs=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=ZjaAxUZal6qkruJdBMwnNi/nexF4r7Uy+xUrPJ1CX7TiFdHMKdBUCVciyvr0W1ZCt
	 H7ZcjwghdlQyw5IZFQnD/AC6qPz6IUn92++klv4ghrfMIOgOOTGakIIJoHAPpEn/Ai
	 qvMD+oz67G0FC7uT71eyxDI/j/lEaGwyzSOYo3CLSy9SExIBwU9oA56AKwkVycp4Xt
	 BntiiKrFOJtpRT4NXo2djL1Gho/QkRCSZ1mESpao7XiP/8CJrjj8z6S0wPRpSkqdXS
	 kk3QHJ/TTEtetCPICjPkBdRhMYgRgyHlrclay99qcmTrwM9bI8h4NIxADKn/gqVOwX
	 R7Fy5nS3dLjuA==
Date: Thu, 18 Jun 2026 22:11:12 +0000
To: Dust Li <dust.li@linux.alibaba.com>
From: Bryam Vargas <hexlabsecurity@proton.me>
Cc: Wenjia Zhang <wenjia@linux.ibm.com>, "D . Wythe" <alibuda@linux.alibaba.com>, Sidraya Jayagond <sidraya@linux.ibm.com>, Eric Dumazet <edumazet@google.com>, "David S . Miller" <davem@davemloft.net>, Mahanta Jambigi <mjambigi@linux.ibm.com>, Wen Gu <guwen@linux.alibaba.com>, Simon Horman <horms@kernel.org>, Ursula Braun <ubraun@linux.ibm.com>, Stefan Raspl <raspl@linux.ibm.com>, Tony Lu <tonylu@linux.alibaba.com>, Paolo Abeni <pabeni@redhat.com>, Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org, linux-s390@vger.kernel.org, linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/3] net/smc: bound the receive length to the RMB in smc_rx_recvmsg()
Message-ID: <20260618221106.236699-1-hexlabsecurity@proton.me>
In-Reply-To: <ajQWxQZXzM2J8kaZ@linux.alibaba.com>
References: <20260614-b4-disp-edd64be9-v3-0-551fa514257e@proton.me> <20260614-b4-disp-edd64be9-v3-2-551fa514257e@proton.me> <ajQWxQZXzM2J8kaZ@linux.alibaba.com>
Feedback-ID: 199661219:user:proton
X-Pm-Message-ID: 5100352f2f77c08d62559cf1ad0c25f5129699b2
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
	R_DKIM_ALLOW(-0.20)[proton.me:s=bfrxb2nnezcp3cvh3sa6jyynqa.protonmail];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:dust.li@linux.alibaba.com,m:wenjia@linux.ibm.com,m:alibuda@linux.alibaba.com,m:sidraya@linux.ibm.com,m:edumazet@google.com,m:davem@davemloft.net,m:mjambigi@linux.ibm.com,m:guwen@linux.alibaba.com,m:horms@kernel.org,m:ubraun@linux.ibm.com,m:raspl@linux.ibm.com,m:tonylu@linux.alibaba.com,m:pabeni@redhat.com,m:kuba@kernel.org,m:netdev@vger.kernel.org,m:linux-s390@vger.kernel.org,m:linux-rdma@vger.kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-22365-lists,linux-rdma=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,proton.me:dkim,proton.me:mid,proton.me:from_mime,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 1BB946A2E84

On Fri, 19 Jun 2026 00:03:17 +0800, Dust Li wrote:
> Once we validate the CDC message at the input boundary (as in the
> previous patch), bytes_to_rcv can never exceed rmb_desc->len, so
> this check becomes unreachable. So I don't think this patch is needed.

This one I'd actually like to keep, and let me walk through why -- I don't =
think the
boundary check closes it.

bytes_to_rcv isn't set to a cursor count, it's a running accumulator:
smc_cdc_msg_recv_action does atomic_add(diff_prod, &bytes_to_rcv), where
diff_prod =3D smc_curs_diff(rmb_desc->len, old, new). So bounding each curs=
or's count at
the boundary doesn't bound the sum of the deltas.

The differing-wrap branch of smc_curs_diff returns (len - old.count) + new.=
count,
which is up to 2*len-1 even when both cursors pass count <=3D len. With len=
=3D16, a prod
going (0,0) -> (1,15) gives diff=3D31, so bytes_to_rcv is already 31 > len =
after one
message; alternating wrap 0<->1 at count=3D15 keeps adding ~len and eventua=
lly wraps the
atomic_t negative. I have an A/B for this -- happy to send it along.

So to make this truly unreachable from the boundary check, we'd need to bou=
nd
prod - cons <=3D len there, not just the absolute count. The consumer-side =
clamp is two
lines and race-free against the tasklet, so my preference would be to keep =
it as a
backstop -- but if you'd rather fold it into a stronger boundary check inst=
ead, I'm
open to that.

Bryam


