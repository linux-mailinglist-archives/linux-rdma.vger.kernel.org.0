Return-Path: <linux-rdma+bounces-18883-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OLltCvTezGm0XAYAu9opvQ
	(envelope-from <linux-rdma+bounces-18883-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 01 Apr 2026 11:01:40 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 2048B377357
	for <lists+linux-rdma@lfdr.de>; Wed, 01 Apr 2026 11:01:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id B3ADC302F549
	for <lists+linux-rdma@lfdr.de>; Wed,  1 Apr 2026 09:01:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C6753C945E;
	Wed,  1 Apr 2026 09:01:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qARDjemd"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D028A2F25F5;
	Wed,  1 Apr 2026 09:01:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775034083; cv=none; b=IR11yheea26UnQAz5ODEBjmJBAHH/8nb1KVIF9J2pnP2+TwpnLO/ie9Od4+/VNhbzSgxeJyR3KjQtyo3S6Ro14zPuiQT9OIB99kwLhXYOTJnD650591kNTx5+LNKESGpeePHXcg5WpjGb5yHKCZJxOXWSbZdfAVa/rQlqiCW7c8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775034083; c=relaxed/simple;
	bh=iR6p726Vx3bevLhC656rHILGz9ugQ6cSzG3NR/Vm22g=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=JcavMEp3h69fHvkzh5+98ZFmiHadVgzpZi3bP0rLKV9Svo/fruv1cn46hoCJeHyQEzWTJSlVA7yZlxqU05IM9nGYcPltKUZNgUN7OpJkAAkLmeo8HsVZ1tDrdjYMkLIHOlVJG/lEkUtOSv1lD5Kewj/63o3k0I2HNxPXsKw0hAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qARDjemd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81E6DC4CEF7;
	Wed,  1 Apr 2026 09:01:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775034083;
	bh=iR6p726Vx3bevLhC656rHILGz9ugQ6cSzG3NR/Vm22g=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=qARDjemd1EvA1xE2sa3+hGkNoS37XWCki0HO64TVDxlEmmhlg7qqXLzkKOHX5nvB+
	 DvxwXfIdgM4Eq6IXppcTlrxIc05N3MeYeMoDP5KlE6LbSx/wY55eXZS4o87LEmYFws
	 yeNZ2kRKtBYSTQI/oxu+ASHCtFj7f2mjgr4jMIeoNxNobn75WluwABH9VfeWYO0xmU
	 rjqUwRSV5uC9tjnxAQY9gB8lXBgqEyjxgV2Dm+fwOdY8yBOBpndiuqaL5MtLkR10GC
	 nSGqoJ8YmZ7QaK5vhR4pokxctYt4Wood9E+MOKRjkVcC/oKqBHuDCq5lGALlfk8Btn
	 tnx33Ks42j7bQ==
Content-Type: multipart/mixed; boundary="===============0152651961399380914=="
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <28a65821fb1b7b1a5d0a8e2580b0b96f7d29ba3b3fb90f49c025418672f78057@mail.kernel.org>
In-Reply-To: <20260401074509.1897527-3-dwmw2@infradead.org>
References: <20260401074509.1897527-3-dwmw2@infradead.org>
Subject: Re: [PATCH 2/6] net: Add CONFIG_LEGACY_IP option
From: bot+bpf-ci@kernel.org
To: dwmw2@infradead.org,saeedm@nvidia.com,leon@kernel.org,tariqt@nvidia.com,mbloch@nvidia.com,andrew+netdev@lunn.ch,davem@davemloft.net,edumazet@google.com,kuba@kernel.org,pabeni@redhat.com,horms@kernel.org,razor@blackwall.org,idosch@nvidia.com,martin.lau@linux.dev,daniel@iogearbox.net,john.fastabend@gmail.com,sdf@fomichev.me,ast@kernel.org,andrii@kernel.org,eddyz87@gmail.com,song@kernel.org,yonghong.song@linux.dev,kpsingh@kernel.org,haoluo@google.com,jolsa@kernel.org,kuniyu@google.com,willemb@google.com,dsahern@kernel.org,ncardwell@google.com,johannes@sipsolutions.net,pablo@netfilter.org,fw@strlen.de,phil@nwl.cc,gnault@redhat.com,dwmw@amazon.co.uk,kees@kernel.org,alazar@nvidia.com,gal@nvidia.com,paul@paul-moore.com,netdev@vger.kernel.org,linux-rdma@vger.kernel.org,linux-kernel@vger.kernel.org,oss-drivers@corigine.com,bridge@lists.linux.dev,bpf@vger.kernel.org,linux-wireless@vger.kernel.org,netfilter-devel@vger.kernel.org,coreteam@netfilter.org,torvalds@linux-foundation.org,jon.maddo
 g.hall@gmail.com
Cc: ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Wed,  1 Apr 2026 09:01:22 +0000 (UTC)
X-Spamd-Result: default: False [2.64 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	CTYPE_MIXED_BOGUS(1.00)[];
	ARC_REJECT(1.00)[signature check failed: fail, {[1] = sig:subspace.kernel.org:reject}];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[multipart/mixed,text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_NEQ_ENVFROM(0.00)[bot@kernel.org,linux-rdma@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-18883-lists,linux-rdma=lfdr.de,bpf-ci];
	RCVD_COUNT_THREE(0.00)[4];
	R_DKIM_REJECT(0.00)[kernel.org:s=k20201202];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[infradead.org,nvidia.com,kernel.org,lunn.ch,davemloft.net,google.com,redhat.com,blackwall.org,linux.dev,iogearbox.net,gmail.com,fomichev.me,sipsolutions.net,netfilter.org,strlen.de,nwl.cc,amazon.co.uk,paul-moore.com,vger.kernel.org,corigine.com,lists.linux.dev,linux-foundation.org];
	NEURAL_SPAM(0.00)[0.991];
	FREEMAIL_CC(0.00)[kernel.org,iogearbox.net,gmail.com,linux.dev,meta.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:-];
	RCPT_COUNT_GT_50(0.00)[58];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	DMARC_POLICY_ALLOW(0.00)[kernel.org,quarantine];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	MIME_TRACE(0.00)[0:+,1:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_NO_DN(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.kernel.org:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 2048B377357
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

--===============0152651961399380914==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64

PiBUaGlzIGlzIHRoZSBmaXJzdCBzdGVwIHRvd2FyZCBtYWtpbmcgTGVnYWN5IElQIG9wdGlvbmFs
LiBUaGUgb3B0aW9uCj4gZGVmYXVsdHMgdG8geSBhbmQgY3VycmVudGx5IGhhcyBubyBlZmZlY3Qg
4oCUIHN1YnNlcXVlbnQgcGF0Y2hlcyB3aWxsIHVzZQo+IGl0IHRvIGd1YXJkIElQdjQgZW50cnkg
cG9pbnRzLgoKVGhlIGNvbW1pdCBtZXNzYWdlIHNheXMgIlRoZSBvcHRpb24gZGVmYXVsdHMgdG8g
eSIsIGJ1dCB0aGUgS2NvbmZpZwplbnRyeSBoYXMgbm8gImRlZmF1bHQgeSIgbGluZS4gIEEgYm9v
bCB3aXRob3V0IGFuIGV4cGxpY2l0IGRlZmF1bHQKaXMgbiBpbiBLY29uZmlnLCBzbyBMRUdBQ1lf
SVAgd2lsbCBiZSBkaXNhYmxlZCBvbiBhbnkgZnJlc2ggY29uZmlnCmJ1aWx0IHdpdGggbWFrZSBk
ZWZjb25maWcgb3IgbWFrZSBvbGRkZWZjb25maWcuCgpMYXRlciBwYXRjaGVzIGluIHRoaXMgc2Vy
aWVzIChiZTJmMDUxMTUwZjksIGYwNGEwNzE3YzI3ZCkgYWRkCiJkZXBlbmRzIG9uIExFR0FDWV9J
UCIgdG8gYWxsIElQdjQtc3BlY2lmaWMgS2NvbmZpZyBzeW1ib2xzIGFuZCBndWFyZApJUHY0IGVu
dHJ5IHBvaW50cyBpbiBDIGNvZGUuICBXaXRoIExFR0FDWV9JUCBkZWZhdWx0aW5nIHRvIG4sIHRo
b3NlCnBhdGNoZXMgd2lsbCBzaWxlbnRseSBkaXNhYmxlIElQdjQgbmV0d29ya2luZyBmb3IgYW55
IG5ld2x5IGdlbmVyYXRlZAprZXJuZWwgY29uZmlndXJhdGlvbi4KClNob3VsZCB0aGUgS2NvbmZp
ZyBlbnRyeSBpbmNsdWRlICJkZWZhdWx0IHkiIHRvIG1hdGNoIHRoZSBzdGF0ZWQKaW50ZW50PwoK
PiBkaWZmIC0tZ2l0IGEvbmV0L2lwdjQvS2NvbmZpZyBiL25ldC9pcHY0L0tjb25maWcKPiBpbmRl
eCBkZjkyMmY5ZjUyODkuLmFlZjJjNTM0OWU2MiAxMDA2NDQKPiAtLS0gYS9uZXQvaXB2NC9LY29u
ZmlnCj4gKysrIGIvbmV0L2lwdjQvS2NvbmZpZwo+IEBAIC0yLDYgKzIsMTcgQEAKPiAgIwo+ICAj
IElQIGNvbmZpZ3VyYXRpb24KPiAgIwo+ICtjb25maWcgTEVHQUNZX0lQCj4gKwlib29sICJUaGUg
SVB2NCBwcm90b2NvbCAoTGVnYWN5IElQKSIKPiArCWhlbHAKPiArCSAgU3VwcG9ydCBmb3IgSVAg
dmVyc2lvbiA0IChJUHY0KS4KPiArCj4gKwkgIExlZ2FjeSBJUCBpcyB0aGUgcHJvdG9jb2wgdXNl
ZCBieSB0aGUgZWFybHkgQVJQQU5FVCwgYmVmb3JlIElQdjYKPiArCSAgd2FzIHN0YW5kYXJkaXNl
ZCBpbiB0aGUgZmluYWwgZGVjYWRlIG9mIHRoZSAxOTAwcy4gSXQgc2hvdWxkIG9ubHkKPiArCSAg
YmUgbmVjZXNzYXJ5IHRoZXNlIGRheXMgdG8gaW50ZXJvcGVyYXRlIHdpdGggbGVnYWN5IG5ldHdv
cmtzLgo+ICsKPiArCSAgSWYgdW5zdXJlLCBzYXkgTi4KClRoZSBoZWxwIHRleHQgc2F5cyAiSWYg
dW5zdXJlLCBzYXkgTi4iICBDb21iaW5lZCB3aXRoIHRoZSBtaXNzaW5nCmRlZmF1bHQsIHRoaXMg
Z3VpZGVzIHVzZXJzIHRvIGRpc2FibGUgSVB2NC4gIElmIHRoZSBpbnRlbnQgaXMgYQpiYWNrd2Fy
ZC1jb21wYXRpYmxlIGludHJvZHVjdGlvbiB3aGVyZSBJUHY0IHN0YXlzIGVuYWJsZWQgdW5sZXNz
CmV4cGxpY2l0bHkgdHVybmVkIG9mZiwgdGhpcyBzaG91bGQgcHJvYmFibHkgYmUgIklmIHVuc3Vy
ZSwgc2F5IFkuIgoKCi0tLQpBSSByZXZpZXdlZCB5b3VyIHBhdGNoLiBQbGVhc2UgZml4IHRoZSBi
dWcgb3IgZW1haWwgcmVwbHkgd2h5IGl0J3Mgbm90IGEgYnVnLgpTZWU6IGh0dHBzOi8vZ2l0aHVi
LmNvbS9rZXJuZWwtcGF0Y2hlcy92bXRlc3QvYmxvYi9tYXN0ZXIvY2kvY2xhdWRlL1JFQURNRS5t
ZAoKQ0kgcnVuIHN1bW1hcnk6IGh0dHBzOi8vZ2l0aHViLmNvbS9rZXJuZWwtcGF0Y2hlcy9icGYv
YWN0aW9ucy9ydW5zLzIzODM4NDExODU5

--===============0152651961399380914==--

