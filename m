Return-Path: <linux-rdma+bounces-2879-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 345AD8FC8AC
	for <lists+linux-rdma@lfdr.de>; Wed,  5 Jun 2024 12:09:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C1705B22DF5
	for <lists+linux-rdma@lfdr.de>; Wed,  5 Jun 2024 10:09:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E155518C335;
	Wed,  5 Jun 2024 10:09:48 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C1B71946CA
	for <linux-rdma@vger.kernel.org>; Wed,  5 Jun 2024 10:09:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.255
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717582188; cv=none; b=X7LXgBD/1svaS5RhbjqEgnWMOz2FZEP4KHYHSTUZ4OKgjfxQEiZHVmf7RcTvqWugN2TCntbyeBtKEQcUFcIXgRG+EvCm0ft2WOuacT9/W4dRN8QRmYfU3CHEiSKsKAHVD7l5POjpyE64R/RrOYSofrgxl4CoBT4n3M5NOPO8SGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717582188; c=relaxed/simple;
	bh=WyYrJaq2PoPIVb95fjCxKrnK6M6IM6UdJf72FBFoMaA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=G0C1Gff6J9JV9dw6UskiBFRrqGCrJz+NRMzugPszCxrcstp8vf+/FodK7Jn2xHLrCrKVNcjaNwsBtGVkjk82JllppLr2hceKYAgnTxahukOwdQ8ZnRSStiOt4UwSiR3u55FeGwEmxKeOL0wRuI3sJtAI+wb3xqP7rbXPY809ipU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.255
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.48])
	by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4VvNQ34hZ3z1S9P6;
	Wed,  5 Jun 2024 18:05:47 +0800 (CST)
Received: from kwepemf200001.china.huawei.com (unknown [7.202.181.227])
	by mail.maildlp.com (Postfix) with ESMTPS id 161F718007A;
	Wed,  5 Jun 2024 18:09:44 +0800 (CST)
Received: from dggpemf200006.china.huawei.com (7.185.36.61) by
 kwepemf200001.china.huawei.com (7.202.181.227) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 5 Jun 2024 18:09:43 +0800
Received: from dggpemf200006.china.huawei.com ([7.185.36.61]) by
 dggpemf200006.china.huawei.com ([7.185.36.61]) with mapi id 15.02.1544.011;
 Wed, 5 Jun 2024 18:09:43 +0800
From: "Gonglei (Arei)" <arei.gonglei@huawei.com>
To: Peter Xu <peterx@redhat.com>
CC: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "yu.zhang@ionos.com"
	<yu.zhang@ionos.com>, "mgalaxy@akamai.com" <mgalaxy@akamai.com>,
	"elmar.gerdes@ionos.com" <elmar.gerdes@ionos.com>, zhengchuan
	<zhengchuan@huawei.com>, "berrange@redhat.com" <berrange@redhat.com>,
	"armbru@redhat.com" <armbru@redhat.com>, "lizhijian@fujitsu.com"
	<lizhijian@fujitsu.com>, "pbonzini@redhat.com" <pbonzini@redhat.com>,
	"mst@redhat.com" <mst@redhat.com>, Xiexiangyou <xiexiangyou@huawei.com>,
	"linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>, "lixiao (H)"
	<lixiao91@huawei.com>, "jinpu.wang@ionos.com" <jinpu.wang@ionos.com>,
	Wangjialin <wangjialin23@huawei.com>, Fabiano Rosas <farosas@suse.de>
Subject: RE: [PATCH 0/6] refactor RDMA live migration based on rsocket API
Thread-Topic: [PATCH 0/6] refactor RDMA live migration based on rsocket API
Thread-Index: AQHatni5B+Psi4bf8k2CmAL8rvKhtrG3eMaAgAF5NUA=
Date: Wed, 5 Jun 2024 10:09:43 +0000
Message-ID: <de950e0e2cda4f8dacd15892a6328861@huawei.com>
References: <1717503252-51884-1-git-send-email-arei.gonglei@huawei.com>
 <Zl9rw3Q9Z9A0iMYV@x1n>
In-Reply-To: <Zl9rw3Q9Z9A0iMYV@x1n>
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

SGkgUGV0ZXIsDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogUGV0ZXIg
WHUgW21haWx0bzpwZXRlcnhAcmVkaGF0LmNvbV0NCj4gU2VudDogV2VkbmVzZGF5LCBKdW5lIDUs
IDIwMjQgMzozMiBBTQ0KPiBUbzogR29uZ2xlaSAoQXJlaSkgPGFyZWkuZ29uZ2xlaUBodWF3ZWku
Y29tPg0KPiBDYzogcWVtdS1kZXZlbEBub25nbnUub3JnOyB5dS56aGFuZ0Bpb25vcy5jb207IG1n
YWxheHlAYWthbWFpLmNvbTsNCj4gZWxtYXIuZ2VyZGVzQGlvbm9zLmNvbTsgemhlbmdjaHVhbiA8
emhlbmdjaHVhbkBodWF3ZWkuY29tPjsNCj4gYmVycmFuZ2VAcmVkaGF0LmNvbTsgYXJtYnJ1QHJl
ZGhhdC5jb207IGxpemhpamlhbkBmdWppdHN1LmNvbTsNCj4gcGJvbnppbmlAcmVkaGF0LmNvbTsg
bXN0QHJlZGhhdC5jb207IFhpZXhpYW5neW91DQo+IDx4aWV4aWFuZ3lvdUBodWF3ZWkuY29tPjsg
bGludXgtcmRtYUB2Z2VyLmtlcm5lbC5vcmc7IGxpeGlhbyAoSCkNCj4gPGxpeGlhbzkxQGh1YXdl
aS5jb20+OyBqaW5wdS53YW5nQGlvbm9zLmNvbTsgV2FuZ2ppYWxpbg0KPiA8d2FuZ2ppYWxpbjIz
QGh1YXdlaS5jb20+OyBGYWJpYW5vIFJvc2FzIDxmYXJvc2FzQHN1c2UuZGU+DQo+IFN1YmplY3Q6
IFJlOiBbUEFUQ0ggMC82XSByZWZhY3RvciBSRE1BIGxpdmUgbWlncmF0aW9uIGJhc2VkIG9uIHJz
b2NrZXQgQVBJDQo+IA0KPiBIaSwgTGVpLCBKaWFsaW4sDQo+IA0KPiBUaGFua3MgYSBsb3QgZm9y
IHdvcmtpbmcgb24gdGhpcyENCj4gDQo+IEkgdGhpbmsgd2UnbGwgbmVlZCB0byB3YWl0IGEgYml0
IG9uIGZlZWRiYWNrcyBmcm9tIEppbnB1IGFuZCBoaXMgdGVhbSBvbiBSRE1BDQo+IHNpZGUsIGFs
c28gRGFuaWVsIGZvciBpb2NoYW5uZWxzLiAgQWxzbywgcGxlYXNlIHJlbWVtYmVyIHRvIGNvcHkg
RmFiaWFubw0KPiBSb3NhcyBpbiBhbnkgcmVsZXZhbnQgZnV0dXJlIHBvc3RzLiAgV2UnZCBhbHNv
IGxpa2UgdG8ga25vdyB3aGV0aGVyIGhlIGhhcyBhbnkNCj4gY29tbWVudHMgdG9vLiAgSSBoYXZl
IGhpbSBjb3BpZWQgaW4gdGhpcyByZXBseS4NCj4gDQo+IE9uIFR1ZSwgSnVuIDA0LCAyMDI0IGF0
IDA4OjE0OjA2UE0gKzA4MDAsIEdvbmdsZWkgd3JvdGU6DQo+ID4gRnJvbTogSmlhbGluIFdhbmcg
PHdhbmdqaWFsaW4yM0BodWF3ZWkuY29tPg0KPiA+DQo+ID4gSGksDQo+ID4NCj4gPiBUaGlzIHBh
dGNoIHNlcmllcyBhdHRlbXB0cyB0byByZWZhY3RvciBSRE1BIGxpdmUgbWlncmF0aW9uIGJ5DQo+
ID4gaW50cm9kdWNpbmcgYSBuZXcgUUlPQ2hhbm5lbFJETUEgY2xhc3MgYmFzZWQgb24gdGhlIHJz
b2NrZXQgQVBJLg0KPiA+DQo+ID4gVGhlIC91c3IvaW5jbHVkZS9yZG1hL3Jzb2NrZXQuaCBwcm92
aWRlcyBhIGhpZ2hlciBsZXZlbCByc29ja2V0IEFQSQ0KPiA+IHRoYXQgaXMgYSAxLTEgbWF0Y2gg
b2YgdGhlIG5vcm1hbCBrZXJuZWwgJ3NvY2tldHMnIEFQSSwgd2hpY2ggaGlkZXMNCj4gPiB0aGUg
ZGV0YWlsIG9mIHJkbWEgcHJvdG9jb2wgaW50byByc29ja2V0IGFuZCBhbGxvd3MgdXMgdG8gYWRk
IHN1cHBvcnQNCj4gPiBmb3Igc29tZSBtb2Rlcm4gZmVhdHVyZXMgbGlrZSBtdWx0aWZkIG1vcmUg
ZWFzaWx5Lg0KPiA+DQo+ID4gSGVyZSBpcyB0aGUgcHJldmlvdXMgZGlzY3Vzc2lvbiBvbiByZWZh
Y3RvcmluZyBSRE1BIGxpdmUgbWlncmF0aW9uDQo+ID4gdXNpbmcgdGhlIHJzb2NrZXQgQVBJOg0K
PiA+DQo+ID4gaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvcWVtdS1kZXZlbC8yMDI0MDMyODEzMDI1
NS41MjI1Ny0xLXBoaWxtZEBsaW5hcg0KPiA+IG8ub3JnLw0KPiA+DQo+ID4gV2UgaGF2ZSBlbmNv
dW50ZXJlZCBzb21lIGJ1Z3Mgd2hlbiB1c2luZyByc29ja2V0IGFuZCBwbGFuIHRvIHN1Ym1pdA0K
PiA+IHRoZW0gdG8gdGhlIHJkbWEtY29yZSBjb21tdW5pdHkuDQo+ID4NCj4gPiBJbiBhZGRpdGlv
biwgdGhlIHVzZSBvZiByc29ja2V0IG1ha2VzIG91ciBwcm9ncmFtbWluZyBtb3JlIGNvbnZlbmll
bnQsDQo+ID4gYnV0IGl0IG11c3QgYmUgbm90ZWQgdGhhdCB0aGlzIG1ldGhvZCBpbnRyb2R1Y2Vz
IG11bHRpcGxlIG1lbW9yeQ0KPiA+IGNvcGllcywgd2hpY2ggY2FuIGJlIGltYWdpbmVkIHRoYXQg
dGhlcmUgd2lsbCBiZSBhIGNlcnRhaW4gcGVyZm9ybWFuY2UNCj4gPiBkZWdyYWRhdGlvbiwgaG9w
aW5nIHRoYXQgZnJpZW5kcyB3aXRoIFJETUEgbmV0d29yayBjYXJkcyBjYW4gaGVscCB2ZXJpZnks
DQo+IHRoYW5rIHlvdSENCj4gDQo+IEl0J2xsIGJlIGdvb2QgdG8gZWxhYm9yYXRlIGlmIHlvdSB0
ZXN0ZWQgaXQgaW4taG91c2UuIFdoYXQgcGVvcGxlIHNob3VsZCBleHBlY3QNCj4gb24gdGhlIG51
bWJlcnMgZXhhY3RseT8gIElzIHRoYXQgb2theSBmcm9tIEh1YXdlaSdzIFBPVj8NCj4gDQo+IEJl
c2lkZXMgdGhhdCwgdGhlIGNvZGUgbG9va3MgcHJldHR5IGdvb2QgYXQgYSBmaXJzdCBnbGFuY2Ug
dG8gbWUuICBCZWZvcmUNCj4gb3RoZXJzIGNoaW0gaW4sIGhlcmUncmUgc29tZSBoaWdoIGxldmVs
IGNvbW1lbnRzLi4NCj4gDQo+IEZpcnN0bHksIGNhbiB3ZSBhdm9pZCB1c2luZyBjb3JvdXRpbmUg
d2hlbiBsaXN0ZW4oKT8gIE1pZ2h0IGJlIHJlbGV2YW50IHdoZW4gSQ0KPiBzZWUgdGhhdCByZG1h
X2FjY2VwdF9pbmNvbWluZ19taWdyYXRpb24oKSBydW5zIGluIGEgbG9vcCB0byBkbyByYWNjZXB0
KCksIGJ1dA0KPiB3b3VsZCB0aGF0IGFsc28gaGFuZyB0aGUgcWVtdSBtYWluIGxvb3AgZXZlbiB3
aXRoIHRoZSBjb3JvdXRpbmUsIGJlZm9yZSBhbGwNCj4gY2hhbm5lbHMgYXJlIHJlYWR5PyAgSSdt
IG5vdCBhIGNvcm91dGluZSBwZXJzb24sIGJ1dCBJIHRoaW5rIHRoZSBob3BlIGlzIHRoYXQNCj4g
d2UgY2FuIG1ha2UgZGVzdCBRRU1VIHJ1biBpbiBhIHRocmVhZCBpbiB0aGUgZnV0dXJlIGp1c3Qg
bGlrZSB0aGUgc3JjIFFFTVUsIHNvDQo+IHRoZSBsZXNzIGNvcm91dGluZSB0aGUgYmV0dGVyIGlu
IHRoaXMgcGF0aC4NCj4gDQoNCkJlY2F1c2UgcnNvY2tldCBpcyBzZXQgdG8gbm9uLWJsb2NraW5n
LCByYWNjZXB0IHdpbGwgcmV0dXJuIEVBR0FJTiB3aGVuIG5vIGNvbm5lY3Rpb24gDQppcyByZWNl
aXZlZCwgY29yb3V0aW5lIHdpbGwgeWllbGQsIGFuZCB3aWxsIG5vdCBoYW5nIHRoZSBxZW11IG1h
aW4gbG9vcC4NCg0KPiBJIHRoaW5rIEkgYWxzbyBsZWZ0IGEgY29tbWVudCBlbHNld2hlcmUgb24g
d2hldGhlciBpdCB3b3VsZCBiZSBwb3NzaWJsZSB0byBhbGxvdw0KPiBpb2NoYW5uZWxzIGltcGxl
bWVudCB0aGVpciBvd24gcG9sbCgpIGZ1bmN0aW9ucyB0byBhdm9pZCB0aGUgcGVyLWNoYW5uZWwg
cG9sbA0KPiB0aHJlYWQgdGhhdCBpcyBwcm9wb3NlZCBpbiB0aGlzIHNlcmllcy4NCj4gDQo+IGh0
dHBzOi8vbG9yZS5rZXJuZWwub3JnL3IvWmxkWTIxeFZFeHRpTWRkQkB4MW4NCj4gDQoNCldlIG5v
dGljZWQgdGhhdCwgYW5kIGl0J3MgYSBiaWcgb3BlcmF0aW9uLiBJJ20gbm90IHN1cmUgdGhhdCdz
IGEgYmV0dGVyIHdheS4NCg0KPiBQZXJzb25hbGx5IEkgdGhpbmsgZXZlbiB3aXRoIHRoZSB0aHJl
YWQgcHJvcG9zYWwgaXQncyBiZXR0ZXIgdGhhbiB0aGUgb2xkIHJkbWENCj4gY29kZSwgYnV0IEkg
anVzdCBzdGlsbCB3YW50IHRvIGRvdWJsZSBjaGVjayB3aXRoIHlvdSBndXlzLiAgRS5nLiwgbWF5
YmUgdGhhdCBqdXN0DQo+IHdvbid0IHdvcmsgYXQgYWxsPyAgQWdhaW4sIHRoYXQnbGwgYWxzbyBi
ZSBiYXNlZCBvbiB0aGUgZmFjdCB0aGF0IHdlIG1vdmUNCj4gbWlncmF0aW9uIGluY29taW5nIGlu
dG8gYSB0aHJlYWQgZmlyc3QgdG8ga2VlcCB0aGUgZGVzdCBRRU1VIG1haW4gbG9vcCBpbnRhY3Qs
DQo+IEkgdGhpbmssIGJ1dCBJIGhvcGUgd2Ugd2lsbCByZWFjaCB0aGF0IGlycmVsZXZhbnQgb2Yg
cmRtYSwgSU9XIGl0J2xsIGJlIG5pY2UgdG8NCj4gaGFwcGVuIGV2ZW4gZWFybGllciBpZiBwb3Nz
aWJsZS4NCj4gDQpZZXAuIFRoaXMgaXMgYSBmYWlybHkgYmlnIGNoYW5nZSwgSSB3b25kZXIgd2hh
dCBvdGhlciBwZW9wbGUncyBzdWdnZXN0aW9ucyBhcmU/DQoNCj4gQW5vdGhlciBuaXRwaWNrIGlz
IHRoYXQgcWlvX2NoYW5uZWxfcmRtYV9saXN0ZW5fYXN5bmMoKSBkb2Vzbid0IGxvb2sgdXNlZCBh
bmQNCj4gbWF5IHByb25lIHRvIHJlbW92YWwuDQo+IA0KDQpZZXMuIFRoaXMgaXMgYmVjYXVzZSB3
aGVuIHdlIHdyb3RlIHRoZSB0ZXN0IGNhc2UsIHdlIHdhbnRlZCB0byB0ZXN0IHFpb19jaGFubmVs
X3JkbWFfY29ubmVjdF9hc3luYywgDQphbmQgYWxzbyBJIGFkZGVkIHFpb19jaGFubmVsX3JkbWFf
bGlzdGVuX2FzeW5jLiBJdCBpcyBub3QgdXNlZCBpbiB0aGUgUkRNQSBob3QgbWlncmF0aW9uIGNv
ZGUuDQoNClJlZ2FyZHMsDQotR29uZ2xlaQ0KDQo=

