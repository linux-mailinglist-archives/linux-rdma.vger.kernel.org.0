Return-Path: <linux-rdma+bounces-3565-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F14ED91C2D7
	for <lists+linux-rdma@lfdr.de>; Fri, 28 Jun 2024 17:45:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AE3442818E1
	for <lists+linux-rdma@lfdr.de>; Fri, 28 Jun 2024 15:45:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62C851C688B;
	Fri, 28 Jun 2024 15:44:57 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.86.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A8691DFFB
	for <linux-rdma@vger.kernel.org>; Fri, 28 Jun 2024 15:44:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.58.86.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719589497; cv=none; b=OHp7Cxzi+y3CT2rxnypSDqca9f2zjLFNVDZ/h3cDSFnKt2m6NzNz1dVtA/jUhXu096rRkpKeHE2YITgaN9ydwffi1ti5jNxQeD57Ayq+yub46rjCMaPBVqlaWGtJd7aSBAuhWKY+p1g/Rfr9pJIHZUEPP90FjNPwQbQe58743tE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719589497; c=relaxed/simple;
	bh=XsXz7tj4MWXfO0oeuOwwAxT/XW/MBVtvfAwz/ynTj5E=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 MIME-Version:Content-Type; b=EJRhRsh33EovLegKHwYFy2HBrRnHEVic2ZNSmVaGKUkmfmjHhdGyMDc9dSlll/Gs//s+E8h36PtWb1LyRz1pPdd5mMOwVFfufWaa8743rHTQIJCd24zUaVvsyf96BCNf3M15BGBMp98NABSbpdyOAbjqQ3hjzEXzIEQW+g7o/vU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM; spf=pass smtp.mailfrom=aculab.com; arc=none smtp.client-ip=185.58.86.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aculab.com
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-403-_-9d1xoqMG6pjkY9001tZQ-1; Fri, 28 Jun 2024 16:44:52 +0100
X-MC-Unique: _-9d1xoqMG6pjkY9001tZQ-1
Received: from AcuMS.Aculab.com (10.202.163.4) by AcuMS.aculab.com
 (10.202.163.4) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Fri, 28 Jun
 2024 16:44:15 +0100
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Fri, 28 Jun 2024 16:44:15 +0100
From: David Laight <David.Laight@ACULAB.COM>
To: 'Anand Khoje' <anand.a.khoje@oracle.com>, Jesse Brandeburg
	<jesse.brandeburg@intel.com>, "linux-rdma@vger.kernel.org"
	<linux-rdma@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>
CC: "saeedm@mellanox.com" <saeedm@mellanox.com>, "leon@kernel.org"
	<leon@kernel.org>, "tariqt@nvidia.com" <tariqt@nvidia.com>,
	"edumazet@google.com" <edumazet@google.com>, "kuba@kernel.org"
	<kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"davem@davemloft.net" <davem@davemloft.net>
Subject: RE: [PATCH v5] net/mlx5: Reclaim max 50K pages at once
Thread-Topic: [PATCH v5] net/mlx5: Reclaim max 50K pages at once
Thread-Index: AQHaxrywOgnvsJUo4Uq4JrrB7H2fV7HdVSZA
Date: Fri, 28 Jun 2024 15:44:15 +0000
Message-ID: <666c79de2adf4959bd167f3f1c45e1fc@AcuMS.aculab.com>
References: <20240624153321.29834-1-anand.a.khoje@oracle.com>
 <0b926745-f2c9-4313-a874-4b7e059b8d64@intel.com>
 <1f9868a7-a336-4a79-bc51-d29461295444@oracle.com>
In-Reply-To: <1f9868a7-a336-4a79-bc51-d29461295444@oracle.com>
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

Li4uDQo+IFRoZSB3YXkgTWVsbGFub3ggQ29ubmVjdFg1IGRyaXZlciBoYW5kbGVzICdyZWxlYXNl
IG9mIGFsbG9jYXRlZCBwYWdlcw0KPiBmcm9tIEhDQScgb3IgJ2FsbG9jYXRpb24gb2YgcGFnZXMg
dG8gSENBJywgaXMgYnkgc2VuZGluZyBhbiBldmVudCB0byB0aGUNCj4gaG9zdC4gVGhpcyBldmVu
dCB3aWxsIGhhdmUgbnVtYmVyIG9mIHBhZ2VzIGluIGl0LiBJZiB0aGUgbnVtYmVyIGlzDQo+IHBv
c2l0aXZlLCB0aGF0IGluZGljYXRlcyBIQ0EgaXMgcmVxdWVzdGluZyB0aGF0IG51bWJlciBvZiBw
YWdlcyB0byBiZQ0KPiBhbGxvY2F0ZWQuIEFuZCBpZiB0aGF0IG51bWJlciBpcyBuZWdhdGl2ZSwg
aXQgaXMgdGhlIEhDQSBpbmRpY2F0aW5nIHRoYXQNCj4gdGhhdCBudW1iZXIgb2YgcGFnZXMgY2Fu
IGJlIHJlY2xhaW1lZCBieSB0aGUgaG9zdC4NCg0KQSBvbmUgbGluZSBjb21tZW50IHdvdWxkIGRv
Lg0KUG9zc2libHkgZXZlbiBuZWdhdGluZyB0aGUgYmUzMnRvaCgpIHJlc3VsdD8NCg0KPiBJbiB0
aGlzIHBhdGNoIHdlIGFyZSByZXN0cmljdGluZyB0aGUgbWF4aW11bSBudW1iZXIgb2YgcGFnZXMg
dGhhdCBjYW4gYmUNCj4gcmVjbGFpbWVkIHRvIGJlIDUwMDAwIChlZmZlY3RpdmVseSB0aGlzIHdv
dWxkIGJlIC01MDAwMCBhcyBpdCBpcw0KPiByZWNsYWltKS4gVGhpcyBsaW1pdCBpcyBiYXNlZCBv
biB0aGUgY2FwYWJpbGl0eSBvZiB0aGUgZmlybXdhcmUgYXMgaXQNCj4gY2Fubm90IHJlbGVhc2Ug
bW9yZSB0aGFuIDUwMDAwIGJhY2sgdG8gdGhlIGhvc3QgaW4gb25lIGdvLg0KDQpIYW5nIG9uLCB3
aHkgYXJlIHlvdSBzb2Z0IGxpbWl0aW5nIGl0IHRvIHRoZSBoYXJkIGxpbWl0Pw0KSSB0aG91Z2h0
IHRoZSBwcm9ibGVtIHdhcyB0aGF0IHJlbGVhc2luZyBhIGxvdCBvZiBwYWdlcyB0b29rIGEgbG9u
Zw0KdGltZSBhbmQgJ3N0dWZmZWQnIG90aGVyIHRpbWUtY3JpdGljYWwgdGFza3MuDQoNClRoZSBv
bmx5IHdheSB0byByZXNvbHZlIHRoYXQgd291bGQgc2VlbSB0byBiZSB0byBkZWZlciB0aGUgYWN0
dWFsIGZyZWVpbmcNCnRvIGEgbG93IChvciBhdCBsZWFzdCBub3JtYWwgdXNlcikgcHJpb3JpdHkg
dGhyZWFkLg0KWW91IHdvdWxkIGRlZmluaXRlbHkgd2FudCB0byBnZXQgb3V0IG9mICdzb2Z0aW50
JyBjb250ZXh0Lg0KKFdoaWNoIGlzIG91dCBvZiBuYXBpIHVubGVzcyBmb3JjZWQgdG8gYmUgdGhy
ZWFkZWQgLSBhbmQgdGhhdCBvbmx5IHJlYWxseQ0Kd29ya3MgaWYgeW91IGZvcmNlIHRoZSB0aHJl
YWRzIHVuZGVyIHRoZSBSVCBzY2hlZHVsZXIuKQ0KDQoJRGF2aWQNCg0KLQ0KUmVnaXN0ZXJlZCBB
ZGRyZXNzIExha2VzaWRlLCBCcmFtbGV5IFJvYWQsIE1vdW50IEZhcm0sIE1pbHRvbiBLZXluZXMs
IE1LMSAxUFQsIFVLDQpSZWdpc3RyYXRpb24gTm86IDEzOTczODYgKFdhbGVzKQ0K


