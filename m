Return-Path: <linux-rdma+bounces-22236-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Byz/Gzj6L2raKwUAu9opvQ
	(envelope-from <linux-rdma+bounces-22236-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 15 Jun 2026 15:12:24 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C00FE686938
	for <lists+linux-rdma@lfdr.de>; Mon, 15 Jun 2026 15:12:23 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=baidu.com header.s=selector1 header.b=Ps+6eyxW;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-22236-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-rdma+bounces-22236-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=baidu.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 72FE93055C7B
	for <lists+linux-rdma@lfdr.de>; Mon, 15 Jun 2026 13:10:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65FA33F1ACA;
	Mon, 15 Jun 2026 13:10:04 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from outbound.baidu.com (mx20.baidu.com [111.202.115.85])
	by smtp.subspace.kernel.org (Postfix) with SMTP id F1C573033D6;
	Mon, 15 Jun 2026 13:09:49 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781529003; cv=none; b=Vm+te4q0ZCig+13jOhedn4j7kF74kVJyLakvVHpLeTnphlyNZp/kZfS4mWwar+ZnU0hDbvsvjytHUM4Ts6XHYK//xfJWhVYeibJHVJiNqiPeRVugxeVs78deBWXkmoVeQFT932a/TXX+og+VqqjnXLvKShx2Cdj/g1xzno2XoEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781529003; c=relaxed/simple;
	bh=yjRveC/Ny5P046IIQQKVErWIjiFRKRLI+nLgEnLfAMI=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=XeLLZEfGNvD88iqh/+iwTfK0aLR4pROT3NL8qfK7QzIKAyewE3IMuvHNvM3Lt9KEvHz+KVBNzz5f8eARCYG06Xpsiwx/096e3/c1+Ogtg8x3I8WKJTtzZcydqDXaDcDKLcz1O5AGoKgMSg15Tms3+5wBr/NLWEBbCQb1OUcCiJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=baidu.com; spf=pass smtp.mailfrom=baidu.com; dkim=pass (2048-bit key) header.d=baidu.com header.i=@baidu.com header.b=Ps+6eyxW; arc=none smtp.client-ip=111.202.115.85
X-MD-Sfrom: lirongqing@baidu.com
X-MD-SrcIP: 172.31.50.46
From: "Li,Rongqing" <lirongqing@baidu.com>
To: Gal Pressman <gal@nvidia.com>, Saeed Mahameed <saeedm@nvidia.com>, "Leon
 Romanovsky" <leon@kernel.org>, Tariq Toukan <tariqt@nvidia.com>, Mark Bloch
	<mbloch@nvidia.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S . Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "linux-rdma@vger.kernel.org"
	<linux-rdma@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: =?utf-8?B?562U5aSNOiBb5aSW6YOo6YKu5Lu2XSBSZTogW1BBVENIXSBuZXQvbWx4NTog?=
 =?utf-8?B?Rml4IHdyb25nIHJlZ2lzdGVyIGFjY2VzcyBpbiBtbHg1X3F1ZXJ5X210cHBz?=
 =?utf-8?Q?e()?=
Thread-Topic: =?utf-8?B?W+WklumDqOmCruS7tl0gUmU6IFtQQVRDSF0gbmV0L21seDU6IEZpeCB3cm9u?=
 =?utf-8?B?ZyByZWdpc3RlciBhY2Nlc3MgaW4gbWx4NV9xdWVyeV9tdHBwc2UoKQ==?=
Thread-Index: AQHc+0p9Wgl4lHOZMUa1M1jqzwhaL7Y/AR4AgACYlyA=
Date: Mon, 15 Jun 2026 13:09:38 +0000
Message-ID: <abd68535f27f41079c6d541924c02121@baidu.com>
References: <20260613153654.1810-1-lirongqing@baidu.com>
 <054e047e-84a3-4dab-ad5d-604d16fc347d@nvidia.com>
In-Reply-To: <054e047e-84a3-4dab-ad5d-604d16fc347d@nvidia.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=baidu.com;
	s=selector1; t=1781528981;
	bh=yjRveC/Ny5P046IIQQKVErWIjiFRKRLI+nLgEnLfAMI=;
	h=From:To:Subject:Date:Message-ID:Content-Type;
	b=Ps+6eyxWSKec39zRJ/53n/huOaWopBWsY1mWZ1desS8kUrGHypNh/IfYG4DhFIVWD
	 vuhEDcgwb+Ag/pXWp9ZP0kMGRSxry3CWzZ5CQFy4RZXfbQm3bF6V6faTU3QLGExFCa
	 fUXEsyMTr1zcOxwmfU3hpm6QjuwMg+jkcJ0f+WO2gT0ioL7BtV0k/XVNh7v53W74LF
	 pigihYmfUWFHfuRtNFTWjfPZ5KHfdIL5tYJDrhZgGGcgo2XK0uK7JesihP7CgUamZO
	 z6boZPw7l5pts7fgfB+cp+OwG9UPmwQnoNRZjghqkl5RY4rUUh3QNpC2o/AKD2l7Ya
	 t/lK8vn5JFqJw==
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.44 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[baidu.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[baidu.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-22236-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_RECIPIENTS(0.00)[m:gal@nvidia.com,m:saeedm@nvidia.com,m:leon@kernel.org,m:tariqt@nvidia.com,m:mbloch@nvidia.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:netdev@vger.kernel.org,m:linux-rdma@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[lirongqing@baidu.com,linux-rdma@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[13];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lirongqing@baidu.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[baidu.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: C00FE686938

PiBUaGlzIGlzIGNsZWFybHkgY29tcGxldGVseSBicm9rZW4sIHdoaWNoIHBvaW50ZWQgbWUgdG8g
dGhlIGZhY3QgdGhhdA0KPiBtbHg1X3F1ZXJ5X210cHBzZSgpIGlzIG5vdCB1c2VkIGFueXdoZXJl
Lg0KPiANCj4gQ2FuIHlvdSBwbGVhc2Ugc3VibWl0IGEgcGF0Y2ggdG8gcmVtb3ZlIGl0Pw0KDQpP
aywgSSB3aWxsIHJlbW92ZSBpdCAgDQoNCltMaSxSb25ncWluZ10gDQoNCg==

