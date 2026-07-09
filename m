Return-Path: <linux-rdma+bounces-22968-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Utl8Lm7FT2qhoAIAu9opvQ
	(envelope-from <linux-rdma+bounces-22968-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 09 Jul 2026 17:59:42 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 36562733397
	for <lists+linux-rdma@lfdr.de>; Thu, 09 Jul 2026 17:59:42 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=infotecs.ru header.s=mx header.b=kVza1cYS;
	dmarc=pass (policy=reject) header.from=infotecs.ru;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-22968-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="linux-rdma+bounces-22968-lists+linux-rdma=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B3719311A6A7
	for <lists+linux-rdma@lfdr.de>; Thu,  9 Jul 2026 15:52:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 751CB428474;
	Thu,  9 Jul 2026 15:51:58 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx0.infotecs.ru (mx0.infotecs.ru [91.244.183.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4523C381AE0;
	Thu,  9 Jul 2026 15:51:53 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783612318; cv=none; b=npnzlw8B56VlmWLmkW3LOZdS2QVv5HMxJ40ohesvtmr2iICl9P1GeQBFENJqe9c1ZNLV4r+oTRKSRXufB1nTvAxEDMOR7aQjI8DVDl7gxNa59tlUZHJik3pCamOolJd82NEkKUOCPwEdaC1++H/y3HLEGYPG78w4kGl/eq9mvSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783612318; c=relaxed/simple;
	bh=qZokTdFXcgSfazJoafBNlRc/K/h9T8rmtQ40ju2qrsY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=tNH4iJv9pqTc7sErF+quIoKWEACUldmAY2opkILmUGv4PJ2nw4MjSmMwGrKZR1C173fJCm7u8oxmhQAkyqXVo23oOSJq63OkKCDV0oCY3te/ZTzxpJ6pzLonpq/UeFHNUikUjv2wYsLRjqBM1QNc8OMFK9kUmQM5OIJCMQKv8ek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=infotecs.ru; spf=pass smtp.mailfrom=infotecs.ru; dkim=pass (1024-bit key) header.d=infotecs.ru header.i=@infotecs.ru header.b=kVza1cYS; arc=none smtp.client-ip=91.244.183.115
DKIM-Filter: OpenDKIM Filter v2.11.0 mx0.infotecs.ru 48C062C0BCF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=infotecs.ru; s=mx;
	t=1783612306; bh=qZokTdFXcgSfazJoafBNlRc/K/h9T8rmtQ40ju2qrsY=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:From;
	b=kVza1cYSWn5euyxBVWucfyQbjzroE0WWnctvYSCthw6SxBOsPhW2A7zUzn7GSj+Z9
	 b4G3tfI8gce65NHiWUAo70NMEp3N/c69grrODjzLf2nc+tSe4qNJXfg2dcb4J/+Cva
	 CfkX8q4c1C6wIz0glyIJMA8vapA0LgcNI2+Uvv90=
Received: from mx0.infotecs-nt (localhost [127.0.0.1])
	by mx0.infotecs.ru (Postfix) with ESMTP id 48C062C0BCF;
	Thu,  9 Jul 2026 18:51:46 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx0.infotecs-nt 0F82B2C0ACD
Received: from msk-exch-02.infotecs-nt (msk-exch-02.infotecs-nt [10.0.7.192])
	by mx0.infotecs-nt (Postfix) with ESMTP id 0F82B2C0ACD;
	Thu,  9 Jul 2026 18:51:46 +0300 (MSK)
From: Ilia Gavrilov <Ilia.Gavrilov@infotecs.ru>
To: Allison Henderson <achender@kernel.org>
CC: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Ka-Cheong Poon
	<ka-cheong.poon@oracle.com>, Santosh Shilimkar
	<santosh.shilimkar@oracle.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "linux-rdma@vger.kernel.org"
	<linux-rdma@vger.kernel.org>, "rds-devel@oss.oracle.com"
	<rds-devel@oss.oracle.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "lvc-project@linuxtesting.org"
	<lvc-project@linuxtesting.org>
Subject: Re: [PATCH net] rds: Fix inet6_addr_lst NULL dereference when IPv6 is
 disabled
Thread-Topic: [PATCH net] rds: Fix inet6_addr_lst NULL dereference when IPv6
 is disabled
Thread-Index: AQHdDtFJkzJE74BSrkynIWuhoK5tUrZlIweAgAACtwA=
Date: Thu, 9 Jul 2026 15:51:45 +0000
Message-ID: <01d99faa-c8c3-438e-852b-92ba230b8b4a@infotecs.ru>
References: <20260708115922.2226279-1-Ilia.Gavrilov@infotecs.ru>
 <a724cf77f2338776f44b465a25009c22a0ee7c43.camel@kernel.org>
In-Reply-To: <a724cf77f2338776f44b465a25009c22a0ee7c43.camel@kernel.org>
Accept-Language: ru-RU, en-US
Content-Language: ru-RU
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-exclaimer-md-config: 208ac3cd-1ed4-4982-a353-bdefac89ac0a
Content-Type: text/plain; charset="utf-8"
Content-ID: <566EC7F9B2FCF146AC35704173D34FB6@infotecs.ru>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-KSMG-AntiPhishing: NotDetected
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Envelope-From: Ilia.Gavrilov@infotecs.ru
X-KSMG-AntiSpam-Info: LuaCore: 112 0.3.112 7c8d497b0e572fbfa504a2ee62037c045a8cb4ec, {Tracking_msgid_8}, {Tracking_from_domain_doesnt_match_to}, 127.0.0.199:7.1.2;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;infotecs.ru:7.1.1, FromAlignment: s
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiSpam-Lua-Profiles: 204370 [Jul 09 2026]
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Version: 6.1.1.22
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 3.0.0.9059, bases: 2026/07/09 08:43:00 #28414782
X-KSMG-AntiVirus-Status: NotDetected, skipped
X-KSMG-LinksScanning: NotDetected
X-KSMG-Message-Action: skipped
X-KSMG-Rule-ID: 8
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.06 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[infotecs.ru,reject];
	R_DKIM_ALLOW(-0.20)[infotecs.ru:s=mx];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_BASE64_TEXT(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-22968-lists,linux-rdma=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	FORGED_RECIPIENTS(0.00)[m:achender@kernel.org,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:ka-cheong.poon@oracle.com,m:santosh.shilimkar@oracle.com,m:netdev@vger.kernel.org,m:linux-rdma@vger.kernel.org,m:rds-devel@oss.oracle.com,m:linux-kernel@vger.kernel.org,m:lvc-project@linuxtesting.org,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[Ilia.Gavrilov@infotecs.ru,linux-rdma@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[infotecs.ru:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Ilia.Gavrilov@infotecs.ru,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linuxtesting.org:url,vger.kernel.org:from_smtp,infotecs.ru:from_mime,infotecs.ru:email,infotecs.ru:mid,infotecs.ru:dkim]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 36562733397

T24gNy85LzI2IDY6NDEgUE0sIEFsbGlzb24gSGVuZGVyc29uIHdyb3RlOg0KPiBPbiBXZWQsIDIw
MjYtMDctMDggYXQgMTE6NTkgKzAwMDAsIElsaWEgR2F2cmlsb3Ygd3JvdGU6DQo+PiBXaGVuIGJv
b3Rpbmcgd2l0aCB0aGUgJ2lwdjYuZGlzYWJsZT0xJyBwYXJhbWV0ZXIsIGluZXQ2X2FkZHJfbHN0
DQo+PiBpcyBuZXZlciBpbml0aWFsaXplZCBiZWNhdXNlIGluZXQ2X2luaXQoKSBleGl0cyBiZWZv
cmUgYWRkcmNvbmZfaW5pdCgpDQo+PiBpcyBjYWxsZWQgdG8gaW5pdGlhbGl6ZSBpdC4gQW4gYXR0
ZW1wdCB0byBiaW5kIGFuIFJEUyBzb2NrZXQgdG8NCj4+IGFuIGlwdjYgYWRkcmVzcyByZXN1bHRz
IGluIGEgY3Jhc2ggaW4gX19pcHY2X2Noa19hZGRyX2FuZF9mbGFncygpDQo+IA0KPiBIZWxsbyBJ
bGlhLA0KPiANCj4gVGhhbmtzIGZvciB0aGUgY2F0Y2guICBTb21lIGNvbW1lbnRzIGJlbG93Og0K
PiANCj4+DQo+PiBLQVNBTjogbnVsbC1wdHItZGVyZWYgaW4gcmFuZ2UgWzB4MDAwMDAwMDAwMDAw
MDAwOC0weDAwMDAwMDAwMDAwMDAwMGZdDQo+PiBSSVA6IDAwMTA6X19pcHY2X2Noa19hZGRyX2Fu
ZF9mbGFncysweDFkZi8weDdlMA0KPj4gQ2FsbCBUcmFjZToNCj4+ICA8VEFTSz4NCj4+ICBpcHY2
X2Noa19hZGRyKzB4M2IvMHg1MA0KPj4gIHJkc190Y3BfbGFkZHJfY2hlY2srMHgxNTUvMHgzYjAg
W3Jkc190Y3BdDQo+PiAgcmRzX3RyYW5zX2dldF9wcmVmZXJyZWQrMHgxNWQvMHgyZDAgW3Jkc10N
Cj4+ICA/IHRyYWNlX2hhcmRpcnFzX29uKzB4MmQvMHgxMTANCj4+ICByZHNfYmluZCsweDE0MzMv
MHgxZDYwIFtyZHNdDQo+PiAgPyByZHNfcmVtb3ZlX2JvdW5kKzB4ZDUwLzB4ZDUwIFtyZHNdDQo+
PiAgPyBhYV9hZl9wZXJtKzB4MjUwLzB4MjUwDQo+PiAgPyBfX21pZ2h0X2ZhdWx0KzB4ZGUvMHgx
OTANCj4+ICA/IF9fc3lzX2JpbmQrMHgxZGMvMHgyMTANCj4+ICBfX3N5c19iaW5kKzB4MWRjLzB4
MjEwDQo+PiAgPyBfX2lhMzJfc3lzX3NvY2tldHBhaXIrMHgxMDAvMHgxMDANCj4+ICA/IHJlc3Rv
cmVfZnByZWdzX2Zyb21fZnBzdGF0ZSsweDUzLzB4MTAwDQo+PiAgX194NjRfc3lzX2JpbmQrMHg3
My8weGIwDQo+PiAgPyBzeXNjYWxsX2VudGVyX2Zyb21fdXNlcl9tb2RlKzB4MWMvMHg1MA0KPj4g
IGRvX3N5c2NhbGxfNjQrMHgzNC8weDgwDQo+PiAgZW50cnlfU1lTQ0FMTF82NF9hZnRlcl9od2Zy
YW1lKzB4NmUvMHhkOA0KPj4gUklQOiAwMDMzOjB4N2Y0N2Y4MjY5ZWE5DQo+PiAgPC9UQVNLPg0K
Pj4NCj4+IFRoZSBmb2xsb3dpbmcgY29kZSByZXByb2R1Y2VzIHRoZSBpc3N1ZToNCj4+DQo+PiBz
dHJ1Y3Qgc29ja2FkZHJfaW42IGFkZHI7DQo+PiBzID0gc29ja2V0KFBGX1JEUywgU09DS19TRVFQ
QUNLRVQsIDApOw0KPj4NCj4+IG1lbXNldCgmYWRkciwgMCwgc2l6ZW9mKGFkZHIpKTsNCj4+IGlu
ZXRfcHRvbihBRl9JTkVUNiwgQUREUkVTUywgJmFkZHIuc2luNl9hZGRyKTsNCj4+IGFkZHIuc2lu
Nl9mYW1pbHkgPSBBRl9JTkVUNjsNCj4+IGFkZHIuc2luNl9wb3J0ID0gaHRvbnMoUE9SVCk7DQo+
Pg0KPj4gYmluZChzLCAmYWRkciwgc2l6ZW9mKGFkZHIpOw0KPiBuaXQ6IG1pc3NpbmcgcGFyZW4g
aGVyZQ0KPiANCj4+DQo+PiBGb3VuZCBieSBJbmZvVGVDUyBvbiBiZWhhbGYgb2YgTGludXggVmVy
aWZpY2F0aW9uIENlbnRlcg0KPj4gKGxpbnV4dGVzdGluZy5vcmcpIHdpdGggU3l6a2FsbGVyLg0K
Pj4NCj4+IEZpeGVzOiBlZWUyZmE2YWIzMjIgKCJyZHM6IENoYW5naW5nIElQIGFkZHJlc3MgaW50
ZXJuYWwgcmVwcmVzZW50YXRpb24gdG8gc3RydWN0IGluNl9hZGRyIikNCj4+IEZpeGVzOiAxZTJi
NDRlNzhlZWEgKCJyZHM6IEVuYWJsZSBSRFMgSVB2NiBzdXBwb3J0IikNCj4+IFNpZ25lZC1vZmYt
Ynk6IElsaWEgR2F2cmlsb3YgPElsaWEuR2F2cmlsb3ZAaW5mb3RlY3MucnU+DQo+PiAtLS0NCj4+
ICBuZXQvcmRzL2liLmMgIHwgNCArKysrDQo+PiAgbmV0L3Jkcy90Y3AuYyB8IDggKysrKystLS0N
Cj4+ICAyIGZpbGVzIGNoYW5nZWQsIDkgaW5zZXJ0aW9ucygrKSwgMyBkZWxldGlvbnMoLSkNCj4+
DQo+PiBkaWZmIC0tZ2l0IGEvbmV0L3Jkcy9pYi5jIGIvbmV0L3Jkcy9pYi5jDQo+PiBpbmRleCAz
OWY4NzI3MmUwNzEuLjhmOWNmNDkxOTg0ZiAxMDA2NDQNCj4+IC0tLSBhL25ldC9yZHMvaWIuYw0K
Pj4gKysrIGIvbmV0L3Jkcy9pYi5jDQo+PiBAQCAtNDI5LDYgKzQyOSwxMCBAQCBzdGF0aWMgaW50
IHJkc19pYl9sYWRkcl9jaGVja19jbShzdHJ1Y3QgbmV0ICpuZXQsIGNvbnN0IHN0cnVjdCBpbjZf
YWRkciAqYWRkciwNCj4+ICAJCXNhID0gKHN0cnVjdCBzb2NrYWRkciAqKSZzaW47DQo+PiAgCX0g
ZWxzZSB7DQo+PiAgI2lmIElTX0VOQUJMRUQoQ09ORklHX0lQVjYpDQo+PiArCQlpZiAoIWlwdjZf
bW9kX2VuYWJsZWQoKSkgew0KPj4gKwkJCXJldCA9IC1FQUREUk5PVEFWQUlMOw0KPj4gKwkJCWdv
dG8gb3V0Ow0KPj4gKwkJfQ0KPj4gIAkJbWVtc2V0KCZzaW42LCAwLCBzaXplb2Yoc2luNikpOw0K
Pj4gIAkJc2luNi5zaW42X2ZhbWlseSA9IEFGX0lORVQ2Ow0KPj4gIAkJc2luNi5zaW42X2FkZHIg
PSAqYWRkcjsNCj4+IGRpZmYgLS1naXQgYS9uZXQvcmRzL3RjcC5jIGIvbmV0L3Jkcy90Y3AuYw0K
Pj4gaW5kZXggYTFkZTExNGQ1ZTJlLi45NTVkOTIyNzdkNWEgMTAwNjQ0DQo+PiAtLS0gYS9uZXQv
cmRzL3RjcC5jDQo+PiArKysgYi9uZXQvcmRzL3RjcC5jDQo+PiBAQCAtMzY2LDkgKzM2NiwxMSBA
QCBpbnQgcmRzX3RjcF9sYWRkcl9jaGVjayhzdHJ1Y3QgbmV0ICpuZXQsIGNvbnN0IHN0cnVjdCBp
bjZfYWRkciAqYWRkciwNCj4+ICAJCXJjdV9yZWFkX3VubG9jaygpOw0KPj4gIAl9DQo+PiAgI2lm
IElTX0VOQUJMRUQoQ09ORklHX0lQVjYpDQo+PiAtCXJldCA9IGlwdjZfY2hrX2FkZHIobmV0LCBh
ZGRyLCBkZXYsIDApOw0KPj4gLQlpZiAocmV0KQ0KPj4gLQkJcmV0dXJuIDA7DQo+PiArCWlmIChp
cHY2X21vZF9lbmFibGVkKCkpIHsNCj4+ICsJCXJldCA9IGlwdjZfY2hrX2FkZHIobmV0LCBhZGRy
LCBkZXYsIDApOw0KPj4gKwkJaWYgKHJldCkNCj4+ICsJCQlyZXR1cm4gMDsNCj4+ICsJfQ0KPiAN
Cj4gVGhlcmUncyBhbm90aGVyIGlwdjZfY2hrX2FkZHIoKSBpbiBfX3Jkc19maW5kX2lmaW5kZXgo
KSB3aXRoIHRoZSBzYW1lIGlzc3VlIHRoYXQgYWZmZWN0cyBpbmJvdW5kIGxpbmstbG9jYWwgSVB2
Ng0KPiBjb25uZWN0cy4gIENhbiB5b3UgYWRkIGEgc2ltaWxhciBndWFyZCB0aGVyZSB0b28/ICBU
aGVuIEkgdGhpbmsgdGhhdCBzaG91bGQgY292ZXIgYWxsIHRoZSBwb2ludHMgb2YgZXhwb3N1cmUu
ICBUaGFua3MNCj4gZm9yIHdvcmtpbmcgb24gdGhpcy4NCj4gDQo+IEFsbGlzb24NCj4gDQoNClRo
YW5rcyBmb3IgdGhlIHJldmlldywgSSdsbCBhZGQgdGhlIGd1YXJkIGluIHRoZSBuZXh0IHBhdGNo
IHZlcnNpb24uDQoNCj4+ICAjZW5kaWYNCj4+ICAJcmV0dXJuIC1FQUREUk5PVEFWQUlMOw0KPj4g
IH0NCj4gDQoNCg==

