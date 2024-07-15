Return-Path: <linux-rdma+bounces-3865-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0107A930FC6
	for <lists+linux-rdma@lfdr.de>; Mon, 15 Jul 2024 10:29:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AC1631F21D89
	for <lists+linux-rdma@lfdr.de>; Mon, 15 Jul 2024 08:29:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2B251850A4;
	Mon, 15 Jul 2024 08:29:29 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.85.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E056C1849EB
	for <linux-rdma@vger.kernel.org>; Mon, 15 Jul 2024 08:29:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.58.85.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721032169; cv=none; b=nqZ1KEOd0tn04diK5AJ82iDqn1e46meMGyaqlWtiJzsd9rQZJrP8LT9uMCkM/ldDAPPNc3uuZUYtLk5lxP9+xF3xTvMQL02jTsDnkGrH0oNASRqNFoOjHI/yP524crtTH1Bf0Nr5+AE8naTvyhzSMbm4HD9R/J/AxLlo4Hg5qVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721032169; c=relaxed/simple;
	bh=nECqzgQeJCUkIbhKy2dALBkVbJRmMcagzco/i7WPIuU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 MIME-Version:Content-Type; b=Tnb4JjyjjR270nfaSJ/QV6CIdERGhR6nlNPXIZ8DyMldIppCkiP64ceDRZ9D415j7wHFSHaMOBtfI3M4FGelzZyB5IruQR0QaRTxsmzx7b1xCIkHqHnoitICvAEXEOEZvUehbcihtfO9zGXF58MEjtiVArdJO4GdyK5HCwkFo6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM; spf=pass smtp.mailfrom=aculab.com; arc=none smtp.client-ip=185.58.85.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aculab.com
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-401-__Fg5qv0Ne-51TWVsBpF6A-1; Mon, 15 Jul 2024 09:23:05 +0100
X-MC-Unique: __Fg5qv0Ne-51TWVsBpF6A-1
Received: from AcuMS.Aculab.com (10.202.163.6) by AcuMS.aculab.com
 (10.202.163.6) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Mon, 15 Jul
 2024 09:22:19 +0100
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Mon, 15 Jul 2024 09:22:19 +0100
From: David Laight <David.Laight@ACULAB.COM>
To: 'Leon Romanovsky' <leon@kernel.org>
CC: Anand Khoje <anand.a.khoje@oracle.com>, "linux-rdma@vger.kernel.org"
	<linux-rdma@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "saeedm@mellanox.com" <saeedm@mellanox.com>,
	"tariqt@nvidia.com" <tariqt@nvidia.com>, "edumazet@google.com"
	<edumazet@google.com>, "kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>, "davem@davemloft.net"
	<davem@davemloft.net>
Subject: RE: [PATCH v4] net/mlx5: Reclaim max 50K pages at once
Thread-Topic: [PATCH v4] net/mlx5: Reclaim max 50K pages at once
Thread-Index: AQHaxhzvGGuhtyfXHkeZpMTT2X9CjbHdTe4QgARuooCAFdXiMA==
Date: Mon, 15 Jul 2024 08:22:19 +0000
Message-ID: <c702670609914da89e934879b5c89de7@AcuMS.aculab.com>
References: <20240619132827.51306-1-anand.a.khoje@oracle.com>
 <20240624095757.GD29266@unreal>
 <3d5b16d332914d4f810bc0ce48fd8772@AcuMS.aculab.com>
 <20240701114949.GB13195@unreal>
In-Reply-To: <20240701114949.GB13195@unreal>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: aculab.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64

RnJvbTogTGVvbiBSb21hbm92c2t5DQo+IFNlbnQ6IDAxIEp1bHkgMjAyNCAxMjo1MA0KPiBUbzog
RGF2aWQgTGFpZ2h0IDxEYXZpZC5MYWlnaHRAQUNVTEFCLkNPTT4NCi4uLg0KPiA+ID4gQlRXLCB0
aGlzIGNhbiBiZSB3cml0dGVuIGFzOg0KPiA+ID4gCXJlcS0+bnBhZ2VzID0gbWF4X3QoczMyLCBu
cGFnZXMsIE1BWF9SRUNMQUlNX05QQUdFUyk7DQo+ID4NCj4gPiBUaGF0IHNob3VsZG4ndCBuZWVk
IGFsbCB0aGUgKHMzMikgY2FzdHMuDQo+IA0KPiAjZGVmaW5lIGRvZXNuJ3QgaGF2ZSBhIHR5cGUs
IHNvIGl0IGlzIGJldHRlciB0byBiZSBleHBsaWNpdCBoZXJlLg0KDQpUaGUgY29uc3RhbnQgaGFz
IGEgdHlwZSwgdGhlIGNhc3QganVzdCBoaWRlcyBhbnkgY2hlY2tpbmcgdGhhdCBtaWdodCBiZSBk
b25lLg0KV291bGQgeW91IHJlYWxseSB3cml0ZToNCglpZiAoKHMzMilucGFnZXMgPiAoczMyKS01
MDAwMCkNCgkJLi4uDQpCZWNhdXNlIHRoYXQgaXMgd2hhdCB5b3UgYXJlIGdlbmVyYXRpbmcuDQoN
CkhlcmUgaXQgcHJvYmFibHkgZG9lc24ndCBtYXR0ZXIsIGJ1dCBpdCBpcyByZWFsbHkgYmFkIHBy
YWN0aXNlLg0KSWYsIGZvciBleGFtcGxlLCAnbnBhZ2VzJyBpcyA2NCBiaXQgdGhhbiB0aGUgY2Fz
dCBjYW4gY2hhbmdlIHRoZSB2YWx1ZS4NCg0KVGhlcmUgYXJlIHBsYWNlcyB3aGVyZSB0aGUgdHlw
ZSBvZiB0aGUgcmVzdWx0IGhhcyBiZWVuIHVzZWQgYW5kIGNhdXNlZA0KYnVncyBiZWNhdXNlIGEg
dmFsdWUgZ290IG1hc2tlZCB0byAxNiBiaXRzLg0KDQpJbiByZWFsaXR5IHRoZXJlIHNob3VsZCBi
ZSBhIGJpZyB0cmF3bCB0aHJvdWdoIHRoZSBjb2RlIHRvIHRyeSB0bw0KcmVtb3ZlIGFsbCB0aGUg
J3BvaW50bGVzcycgbWluX3QoKSBhbmQgbWF4X3QoKS4NCkFkZGluZyBuZXcgb25lcyBqdXN0IG1h
a2VzIGl0IHdvcnNlLg0KDQoJRGF2aWQNCg0KLQ0KUmVnaXN0ZXJlZCBBZGRyZXNzIExha2VzaWRl
LCBCcmFtbGV5IFJvYWQsIE1vdW50IEZhcm0sIE1pbHRvbiBLZXluZXMsIE1LMSAxUFQsIFVLDQpS
ZWdpc3RyYXRpb24gTm86IDEzOTczODYgKFdhbGVzKQ0K


