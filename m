Return-Path: <linux-rdma+bounces-2981-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 924B48FFDFD
	for <lists+linux-rdma@lfdr.de>; Fri,  7 Jun 2024 10:28:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 71F871C208DE
	for <lists+linux-rdma@lfdr.de>; Fri,  7 Jun 2024 08:28:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B41AE15B0F7;
	Fri,  7 Jun 2024 08:28:36 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A74E715B0F2
	for <linux-rdma@vger.kernel.org>; Fri,  7 Jun 2024 08:28:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717748916; cv=none; b=kjnla+Ws9/KUhcQROo3zlcCjyzWrAsUc54jel8a4FUAAWkgduSaI8sy4crh8FAi6HNyYL0iINm5BGd+Vh3FmOtIATSrZJWBlhm7vLGlGjb5nvWk3UyG7Xql4bm6pj9v2Wju3SqeQQJ8iiRJWLjiVMGKeyDcnwJLZbfDpDdGX1MU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717748916; c=relaxed/simple;
	bh=3HZbfz94YyJLLWZau8mRnXynX13RQHVOAz7YFfXVDW0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=PE77FTEgEGFXFbEPH87/HqgdiQ+u7XWkg5z88bZal2w+/x0yGWWDOdwjcF1w66Kxmhmze+Eo705uFIPBqPzj45RGfvC8VeDy3Hg558P8fuQZMxSZ5icgwoZPUkp2q8GKv892e0/YgkugjkLdkyilZ64dGPD9zNmJreD9/uRQABk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.48])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4VwZ52262HzPprJ;
	Fri,  7 Jun 2024 16:25:10 +0800 (CST)
Received: from dggpeml500013.china.huawei.com (unknown [7.185.36.41])
	by mail.maildlp.com (Postfix) with ESMTPS id C2C1B18007A;
	Fri,  7 Jun 2024 16:28:29 +0800 (CST)
Received: from dggpemf200006.china.huawei.com (7.185.36.61) by
 dggpeml500013.china.huawei.com (7.185.36.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 7 Jun 2024 16:28:29 +0800
Received: from dggpemf200006.china.huawei.com ([7.185.36.61]) by
 dggpemf200006.china.huawei.com ([7.185.36.61]) with mapi id 15.02.1544.011;
 Fri, 7 Jun 2024 16:28:29 +0800
From: "Gonglei (Arei)" <arei.gonglei@huawei.com>
To: Jinpu Wang <jinpu.wang@ionos.com>
CC: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "peterx@redhat.com"
	<peterx@redhat.com>, "yu.zhang@ionos.com" <yu.zhang@ionos.com>,
	"mgalaxy@akamai.com" <mgalaxy@akamai.com>, "elmar.gerdes@ionos.com"
	<elmar.gerdes@ionos.com>, zhengchuan <zhengchuan@huawei.com>,
	"berrange@redhat.com" <berrange@redhat.com>, "armbru@redhat.com"
	<armbru@redhat.com>, "lizhijian@fujitsu.com" <lizhijian@fujitsu.com>,
	"pbonzini@redhat.com" <pbonzini@redhat.com>, "mst@redhat.com"
	<mst@redhat.com>, Xiexiangyou <xiexiangyou@huawei.com>,
	"linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>, "lixiao (H)"
	<lixiao91@huawei.com>, Wangjialin <wangjialin23@huawei.com>
Subject: RE: [PATCH 0/6] refactor RDMA live migration based on rsocket API
Thread-Topic: [PATCH 0/6] refactor RDMA live migration based on rsocket API
Thread-Index: AQHatni5B+Psi4bf8k2CmAL8rvKhtrG7SwIAgACwxiA=
Date: Fri, 7 Jun 2024 08:28:29 +0000
Message-ID: <b637ce3cac16409c83a3391b05011eec@huawei.com>
References: <1717503252-51884-1-git-send-email-arei.gonglei@huawei.com>
 <CAMGffEkUd2EOS3+PQ9Yfp=8V1pZB_emo7gcmxmvOX=iWVG6Axg@mail.gmail.com>
In-Reply-To: <CAMGffEkUd2EOS3+PQ9Yfp=8V1pZB_emo7gcmxmvOX=iWVG6Axg@mail.gmail.com>
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

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogSmlucHUgV2FuZyBbbWFp
bHRvOmppbnB1LndhbmdAaW9ub3MuY29tXQ0KPiBTZW50OiBGcmlkYXksIEp1bmUgNywgMjAyNCAx
OjU0IFBNDQo+IFRvOiBHb25nbGVpIChBcmVpKSA8YXJlaS5nb25nbGVpQGh1YXdlaS5jb20+DQo+
IENjOiBxZW11LWRldmVsQG5vbmdudS5vcmc7IHBldGVyeEByZWRoYXQuY29tOyB5dS56aGFuZ0Bp
b25vcy5jb207DQo+IG1nYWxheHlAYWthbWFpLmNvbTsgZWxtYXIuZ2VyZGVzQGlvbm9zLmNvbTsg
emhlbmdjaHVhbg0KPiA8emhlbmdjaHVhbkBodWF3ZWkuY29tPjsgYmVycmFuZ2VAcmVkaGF0LmNv
bTsgYXJtYnJ1QHJlZGhhdC5jb207DQo+IGxpemhpamlhbkBmdWppdHN1LmNvbTsgcGJvbnppbmlA
cmVkaGF0LmNvbTsgbXN0QHJlZGhhdC5jb207IFhpZXhpYW5neW91DQo+IDx4aWV4aWFuZ3lvdUBo
dWF3ZWkuY29tPjsgbGludXgtcmRtYUB2Z2VyLmtlcm5lbC5vcmc7IGxpeGlhbyAoSCkNCj4gPGxp
eGlhbzkxQGh1YXdlaS5jb20+OyBXYW5namlhbGluIDx3YW5namlhbGluMjNAaHVhd2VpLmNvbT4N
Cj4gU3ViamVjdDogUmU6IFtQQVRDSCAwLzZdIHJlZmFjdG9yIFJETUEgbGl2ZSBtaWdyYXRpb24g
YmFzZWQgb24gcnNvY2tldCBBUEkNCj4gDQo+IEhpIEdvbmdsZWksIGhpIGZvbGtzIG9uIHRoZSBs
aXN0LA0KPiANCj4gT24gVHVlLCBKdW4gNCwgMjAyNCBhdCAyOjE04oCvUE0gR29uZ2xlaSA8YXJl
aS5nb25nbGVpQGh1YXdlaS5jb20+IHdyb3RlOg0KPiA+DQo+ID4gRnJvbTogSmlhbGluIFdhbmcg
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
DQo+IHRoYW5rIHlvdSENCj4gRmlyc3QgdGh4IGZvciB0aGUgZWZmb3J0LCB3ZSBhcmUgcnVubmlu
ZyBtaWdyYXRpb24gdGVzdHMgb24gb3VyIElCIGZhYnJpYywgZGlmZmVyZW50DQo+IGdlbmVyYXRp
b24gb2YgSENBIGZyb20gbWVsbGFub3gsIHRoZSBtaWdyYXRpb24gd29ya3Mgb2ssIHRoZXJlIGFy
ZSBhIGZldw0KPiBmYWlsdXJlcywgIFl1IHdpbGwgc2hhcmUgdGhlIHJlc3VsdCBsYXRlciBzZXBh
cmF0ZWx5Lg0KPiANCg0KVGhhbmsgeW91IHNvIG11Y2guIA0KDQo+IFRoZSBvbmUgYmxvY2tlciBm
b3IgdGhlIGNoYW5nZSBpcyB0aGUgb2xkIGltcGxlbWVudGF0aW9uIGFuZCB0aGUgbmV3IHJzb2Nr
ZXQNCj4gaW1wbGVtZW50YXRpb247IHRoZXkgZG9uJ3QgdGFsayB0byBlYWNoIG90aGVyIGR1ZSB0
byB0aGUgZWZmZWN0IG9mIGRpZmZlcmVudCB3aXJlDQo+IHByb3RvY29sIGR1cmluZyBjb25uZWN0
aW9uIGVzdGFibGlzaG1lbnQuDQo+IGVnIHRoZSBvbGQgUkRNQSBtaWdyYXRpb24gaGFzIHNwZWNp
YWwgY29udHJvbCBtZXNzYWdlIGR1cmluZyB0aGUgbWlncmF0aW9uDQo+IGZsb3csIHdoaWNoIHJz
b2NrZXQgdXNlIGEgZGlmZmVyZW50IGNvbnRyb2wgbWVzc2FnZSwgc28gdGhlcmUgbGVhZCB0byBu
byB3YXkgdG8NCj4gbWlncmF0ZSBWTSB1c2luZyByZG1hIHRyYW5zcG9ydCBwcmUgdG8gdGhlIHJz
b2NrZXQgcGF0Y2hzZXQgdG8gYSBuZXcgdmVyc2lvbg0KPiB3aXRoIHJzb2NrZXQgaW1wbGVtZW50
YXRpb24uDQo+IA0KPiBQcm9iYWJseSB3ZSBzaG91bGQga2VlcCBib3RoIGltcGxlbWVudGF0aW9u
IGZvciBhIHdoaWxlLCBtYXJrIHRoZSBvbGQNCj4gaW1wbGVtZW50YXRpb24gYXMgZGVwcmVjYXRl
ZCwgYW5kIHByb21vdGUgdGhlIG5ldyBpbXBsZW1lbnRhdGlvbiwgYW5kDQo+IGhpZ2ggbGlnaHQg
aW4gZG9jLCB0aGV5IGFyZSBub3QgY29tcGF0aWJsZS4NCj4gDQoNCklNTyBJdCBtYWtlcyBzZW5z
ZS4gV2hhdCdzIHlvdXIgb3Bpbmlvbj8gQFBldGVyLg0KDQoNClJlZ2FyZHMsDQotR29uZ2xlaQ0K
DQo+IFJlZ2FyZHMhDQo+IEppbnB1DQo+IA0KPiANCj4gDQo+ID4NCj4gPiBKaWFsaW4gV2FuZyAo
Nik6DQo+ID4gICBtaWdyYXRpb246IHJlbW92ZSBSRE1BIGxpdmUgbWlncmF0aW9uIHRlbXBvcmFy
aWx5DQo+ID4gICBpbzogYWRkIFFJT0NoYW5uZWxSRE1BIGNsYXNzDQo+ID4gICBpby9jaGFubmVs
LXJkbWE6IHN1cHBvcnQgd29ya2luZyBpbiBjb3JvdXRpbmUNCj4gPiAgIHRlc3RzL3VuaXQ6IGFk
ZCB0ZXN0LWlvLWNoYW5uZWwtcmRtYS5jDQo+ID4gICBtaWdyYXRpb246IGludHJvZHVjZSBuZXcg
UkRNQSBsaXZlIG1pZ3JhdGlvbg0KPiA+ICAgbWlncmF0aW9uL3JkbWE6IHN1cHBvcnQgbXVsdGlm
ZCBmb3IgUkRNQSBtaWdyYXRpb24NCj4gPg0KPiA+ICBkb2NzL3JkbWEudHh0ICAgICAgICAgICAg
ICAgICAgICAgfCAgNDIwIC0tLQ0KPiA+ICBpbmNsdWRlL2lvL2NoYW5uZWwtcmRtYS5oICAgICAg
ICAgfCAgMTY1ICsrDQo+ID4gIGlvL2NoYW5uZWwtcmRtYS5jICAgICAgICAgICAgICAgICB8ICA3
OTggKysrKysrDQo+ID4gIGlvL21lc29uLmJ1aWxkICAgICAgICAgICAgICAgICAgICB8ICAgIDEg
Kw0KPiA+ICBpby90cmFjZS1ldmVudHMgICAgICAgICAgICAgICAgICAgfCAgIDE0ICsNCj4gPiAg
bWVzb24uYnVpbGQgICAgICAgICAgICAgICAgICAgICAgIHwgICAgNiAtDQo+ID4gIG1pZ3JhdGlv
bi9tZXNvbi5idWlsZCAgICAgICAgICAgICB8ICAgIDMgKy0NCj4gPiAgbWlncmF0aW9uL21pZ3Jh
dGlvbi1zdGF0cy5jICAgICAgIHwgICAgNSArLQ0KPiA+ICBtaWdyYXRpb24vbWlncmF0aW9uLXN0
YXRzLmggICAgICAgfCAgICA0IC0NCj4gPiAgbWlncmF0aW9uL21pZ3JhdGlvbi5jICAgICAgICAg
ICAgIHwgICAxMyArLQ0KPiA+ICBtaWdyYXRpb24vbWlncmF0aW9uLmggICAgICAgICAgICAgfCAg
ICA5IC0NCj4gPiAgbWlncmF0aW9uL211bHRpZmQuYyAgICAgICAgICAgICAgIHwgICAxMCArDQo+
ID4gIG1pZ3JhdGlvbi9vcHRpb25zLmMgICAgICAgICAgICAgICB8ICAgMTYgLQ0KPiA+ICBtaWdy
YXRpb24vb3B0aW9ucy5oICAgICAgICAgICAgICAgfCAgICAyIC0NCj4gPiAgbWlncmF0aW9uL3Fl
bXUtZmlsZS5jICAgICAgICAgICAgIHwgICAgMSAtDQo+ID4gIG1pZ3JhdGlvbi9yYW0uYyAgICAg
ICAgICAgICAgICAgICB8ICAgOTAgKy0NCj4gPiAgbWlncmF0aW9uL3JkbWEuYyAgICAgICAgICAg
ICAgICAgIHwgNDIwNSArLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQ0KPiA+ICBtaWdyYXRp
b24vcmRtYS5oICAgICAgICAgICAgICAgICAgfCAgIDY3ICstDQo+ID4gIG1pZ3JhdGlvbi9zYXZl
dm0uYyAgICAgICAgICAgICAgICB8ICAgIDIgKy0NCj4gPiAgbWlncmF0aW9uL3RyYWNlLWV2ZW50
cyAgICAgICAgICAgIHwgICA2OCArLQ0KPiA+ICBxYXBpL21pZ3JhdGlvbi5qc29uICAgICAgICAg
ICAgICAgfCAgIDEzICstDQo+ID4gIHNjcmlwdHMvYW5hbHl6ZS1taWdyYXRpb24ucHkgICAgICB8
ICAgIDMgLQ0KPiA+ICB0ZXN0cy91bml0L21lc29uLmJ1aWxkICAgICAgICAgICAgfCAgICAxICsN
Cj4gPiAgdGVzdHMvdW5pdC90ZXN0LWlvLWNoYW5uZWwtcmRtYS5jIHwgIDI3NiArKw0KPiA+ICAy
NCBmaWxlcyBjaGFuZ2VkLCAxMzYwIGluc2VydGlvbnMoKyksIDQ4MzIgZGVsZXRpb25zKC0pICBk
ZWxldGUgbW9kZQ0KPiA+IDEwMDY0NCBkb2NzL3JkbWEudHh0ICBjcmVhdGUgbW9kZSAxMDA2NDQg
aW5jbHVkZS9pby9jaGFubmVsLXJkbWEuaA0KPiA+IGNyZWF0ZSBtb2RlIDEwMDY0NCBpby9jaGFu
bmVsLXJkbWEuYyAgY3JlYXRlIG1vZGUgMTAwNjQ0DQo+ID4gdGVzdHMvdW5pdC90ZXN0LWlvLWNo
YW5uZWwtcmRtYS5jDQo+ID4NCj4gPiAtLQ0KPiA+IDIuNDMuMA0KPiA+DQoNCg==

