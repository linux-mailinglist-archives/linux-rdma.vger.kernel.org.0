Return-Path: <linux-rdma+bounces-2878-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 30CBA8FC890
	for <lists+linux-rdma@lfdr.de>; Wed,  5 Jun 2024 12:02:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 557911C2218B
	for <lists+linux-rdma@lfdr.de>; Wed,  5 Jun 2024 10:02:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB4D96CDAB;
	Wed,  5 Jun 2024 10:02:22 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21B1E257B
	for <linux-rdma@vger.kernel.org>; Wed,  5 Jun 2024 10:02:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717581742; cv=none; b=Nc1HG75xyyaR5SCbPAdLHuJE1vRfYxGxqQcC+0v5W/LxQou0Z2XR2YGn+OlpjW0ya3yHR+VmnNz+hNw1/B/R3u0iD5diY2UgjHS0UuFx6NO+E7I7DBWT7Kp2+JNGoCzwn7RrL6IarXWKRFXNsuZns12qZmGCB4OwlGnd0rPwlCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717581742; c=relaxed/simple;
	bh=DmUSl9anv2QkY57bdyDBuFT/TUB9tWBYqlMekujVL1w=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=YxDLZJ1oHH5tUhatY+Ia2zWUsH3sb1rml/G+hZvpTWGFtTnEIEuOfiS5hH7/nsCmcDRj/2QkTodUM9AclHFDY1dw7lWK9S3mWzGWkE2uuZf0dq7davHkffUpZ9iABCsMnQMnRJKJ9/RGf7oYcqVfNOLmom1O9V0NxgB0bOaItSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.17])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4VvNFf2BSvz2Cjsl;
	Wed,  5 Jun 2024 17:58:30 +0800 (CST)
Received: from dggpeml500014.china.huawei.com (unknown [7.185.36.63])
	by mail.maildlp.com (Postfix) with ESMTPS id AA0131A0188;
	Wed,  5 Jun 2024 18:02:11 +0800 (CST)
Received: from dggpemf200006.china.huawei.com (7.185.36.61) by
 dggpeml500014.china.huawei.com (7.185.36.63) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 5 Jun 2024 18:02:11 +0800
Received: from dggpemf200006.china.huawei.com ([7.185.36.61]) by
 dggpemf200006.china.huawei.com ([7.185.36.61]) with mapi id 15.02.1544.011;
 Wed, 5 Jun 2024 18:02:11 +0800
From: "Gonglei (Arei)" <arei.gonglei@huawei.com>
To: David Hildenbrand <david@redhat.com>, "qemu-devel@nongnu.org"
	<qemu-devel@nongnu.org>
CC: "peterx@redhat.com" <peterx@redhat.com>, "yu.zhang@ionos.com"
	<yu.zhang@ionos.com>, "mgalaxy@akamai.com" <mgalaxy@akamai.com>,
	"elmar.gerdes@ionos.com" <elmar.gerdes@ionos.com>, zhengchuan
	<zhengchuan@huawei.com>, "berrange@redhat.com" <berrange@redhat.com>,
	"armbru@redhat.com" <armbru@redhat.com>, "lizhijian@fujitsu.com"
	<lizhijian@fujitsu.com>, "pbonzini@redhat.com" <pbonzini@redhat.com>,
	"mst@redhat.com" <mst@redhat.com>, Xiexiangyou <xiexiangyou@huawei.com>,
	"linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>, "lixiao (H)"
	<lixiao91@huawei.com>, "jinpu.wang@ionos.com" <jinpu.wang@ionos.com>,
	Wangjialin <wangjialin23@huawei.com>
Subject: RE: [PATCH 1/6] migration: remove RDMA live migration temporarily
Thread-Topic: [PATCH 1/6] migration: remove RDMA live migration temporarily
Thread-Index: AQHatni6DJD3CiQfS0m1DFPrsMEherG3HGyAgAHVElA=
Date: Wed, 5 Jun 2024 10:02:11 +0000
Message-ID: <78de06918788452ea46d27700dcc9010@huawei.com>
References: <1717503252-51884-1-git-send-email-arei.gonglei@huawei.com>
 <1717503252-51884-2-git-send-email-arei.gonglei@huawei.com>
 <11017c4b-e0db-4f2e-af1d-54bc2c416e5e@redhat.com>
In-Reply-To: <11017c4b-e0db-4f2e-af1d-54bc2c416e5e@redhat.com>
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

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogRGF2aWQgSGlsZGVuYnJh
bmQgW21haWx0bzpkYXZpZEByZWRoYXQuY29tXQ0KPiBTZW50OiBUdWVzZGF5LCBKdW5lIDQsIDIw
MjQgMTA6MDIgUE0NCj4gVG86IEdvbmdsZWkgKEFyZWkpIDxhcmVpLmdvbmdsZWlAaHVhd2VpLmNv
bT47IHFlbXUtZGV2ZWxAbm9uZ251Lm9yZw0KPiBDYzogcGV0ZXJ4QHJlZGhhdC5jb207IHl1Lnpo
YW5nQGlvbm9zLmNvbTsgbWdhbGF4eUBha2FtYWkuY29tOw0KPiBlbG1hci5nZXJkZXNAaW9ub3Mu
Y29tOyB6aGVuZ2NodWFuIDx6aGVuZ2NodWFuQGh1YXdlaS5jb20+Ow0KPiBiZXJyYW5nZUByZWRo
YXQuY29tOyBhcm1icnVAcmVkaGF0LmNvbTsgbGl6aGlqaWFuQGZ1aml0c3UuY29tOw0KPiBwYm9u
emluaUByZWRoYXQuY29tOyBtc3RAcmVkaGF0LmNvbTsgWGlleGlhbmd5b3UNCj4gPHhpZXhpYW5n
eW91QGh1YXdlaS5jb20+OyBsaW51eC1yZG1hQHZnZXIua2VybmVsLm9yZzsgbGl4aWFvIChIKQ0K
PiA8bGl4aWFvOTFAaHVhd2VpLmNvbT47IGppbnB1LndhbmdAaW9ub3MuY29tOyBXYW5namlhbGlu
DQo+IDx3YW5namlhbGluMjNAaHVhd2VpLmNvbT4NCj4gU3ViamVjdDogUmU6IFtQQVRDSCAxLzZd
IG1pZ3JhdGlvbjogcmVtb3ZlIFJETUEgbGl2ZSBtaWdyYXRpb24gdGVtcG9yYXJpbHkNCj4gDQo+
IE9uIDA0LjA2LjI0IDE0OjE0LCBHb25nbGVpIHZpYSB3cm90ZToNCj4gPiBGcm9tOiBKaWFsaW4g
V2FuZyA8d2FuZ2ppYWxpbjIzQGh1YXdlaS5jb20+DQo+ID4NCj4gPiBUaGUgbmV3IFJETUEgbGl2
ZSBtaWdyYXRpb24gd2lsbCBiZSBpbnRyb2R1Y2VkIGluIHRoZSB1cGNvbWluZyBmZXcNCj4gPiBj
b21taXRzLg0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTogSmlhbGluIFdhbmcgPHdhbmdqaWFsaW4y
M0BodWF3ZWkuY29tPg0KPiA+IFNpZ25lZC1vZmYtYnk6IEdvbmdsZWkgPGFyZWkuZ29uZ2xlaUBo
dWF3ZWkuY29tPg0KPiA+IC0tLQ0KPiANCj4gWy4uLl0NCj4gDQo+ID4gLQ0KPiA+IC0gICAgLyog
QXZvaWQgcmFtX2Jsb2NrX2Rpc2NhcmRfZGlzYWJsZSgpLCBjYW5ub3QgY2hhbmdlIGR1cmluZyBt
aWdyYXRpb24uDQo+ICovDQo+ID4gLSAgICBpZiAocmFtX2Jsb2NrX2Rpc2NhcmRfaXNfcmVxdWly
ZWQoKSkgew0KPiA+IC0gICAgICAgIGVycm9yX3NldGcoZXJycCwgIlJETUE6IGNhbm5vdCBkaXNh
YmxlIFJBTSBkaXNjYXJkIik7DQo+ID4gLSAgICAgICAgcmV0dXJuOw0KPiA+IC0gICAgfQ0KPiAN
Cj4gSSdtIHBhcnRpY3VsYXJseSBpbnRlcmVzdGVkIGluIHRoZSBpbnRlcmFjdGlvbiB3aXRoIHZp
cnRpby1iYWxsb29uL3ZpcnRpby1tZW0uDQo+IA0KPiBEbyB3ZSBzdGlsbCBoYXZlIHRvIGRpc2Fi
bGUgZGlzY2FyZGluZyBvZiBSQU0sIGFuZCB3aGVyZSB3b3VsZCB5b3UgZG8gdGhhdCBpbg0KPiB0
aGUgcmV3cml0ZT8NCj4gDQoNClllcywgd2UgZG8uIFdlIGRpZG4ndCBjaGFuZ2UgdGhlIGxvZ2lj
LiBUaGFua3MgZm9yIHlvdXIgY2F0Y2hpbmcuDQoNClJlZ2FyZHMsDQotR29uZ2xlaQ0KDQo+IC0t
DQo+IENoZWVycywNCj4gDQo+IERhdmlkIC8gZGhpbGRlbmINCg0K

