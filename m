Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 13D74169EF2
	for <lists+linux-rdma@lfdr.de>; Mon, 24 Feb 2020 08:10:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726765AbgBXHKU (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 24 Feb 2020 02:10:20 -0500
Received: from mail-eopbgr50049.outbound.protection.outlook.com ([40.107.5.49]:6807
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725895AbgBXHKT (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 24 Feb 2020 02:10:19 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Uz5C18ySDzFHq98z3Usw6jpcxFKtUztODAUDniSXU54tE8v+YPxs29huJTYh+Xb44xjOBAG1aLGL/JP4V6hptdqrHu+qwDvnI9U97dFFEdv8mbgXpiLN9Xb09oyRWTmY9jnmvCVpP+djHqeBx1qCFpD7fDlpnKRcKi8tevtYfOLp65M8RGmRHaHuC7Q4Vp00rk+nsCPn4d4hTo4pwJbz6As72XAaci+WQyCpZeZBN7B7bZqfZtThS9y/GA42g0+qGRdVUIGBPu1co5CruTxrHF/eRuwu464ns58jCiaNOUx4fnzoQ7FD1/zgUApMNrb6VGFWjDNLu6wnRKQVWpKEbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BTgNPK0gU1H55ANK3fFSAyRzP38+mnZv1/Y6xtECg88=;
 b=WlLlw9HcakzBsbjdf97FG11uDLdWoAPkC7umqqYX88+HkgLbmVMGEhJjsCytJ8qaLeBn69KCoxAiSd3aHtY8zcGQ4w7LiRxM/uZpT6VYTsk685WSHm4ohI/uq9c+LdVTLwg3zHMR+W/ncZTw6J2B+zS12unEy2KvfulImmMSudJJWWYqoldNaNrvsDehLkzfLwDb7MtuElYkUlSBpyqpto3eLXuovIEf8HhDfTfExPS36l5LUh1cSxofH28HzY1m+mdIY1GYK3kRnioz2IYdvDYQaN8CjDjENn0034p1zrZP6xdaGdWb7m6ZZ8JC7/MZZe5gscLQ8EwY+oz2cqJw8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mellanox.com; dmarc=pass action=none header.from=mellanox.com;
 dkim=pass header.d=mellanox.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BTgNPK0gU1H55ANK3fFSAyRzP38+mnZv1/Y6xtECg88=;
 b=ip69QdiP4Ex4HNQWcDtXmWqUGlkD6EtiGK/J/QmrKNIYXgkB0ZAZ3Fwgxpw2s061ICXmmoH9mnHvblgqs0ukPIWzOiaiO+zPGhHO7GupGvFgeeWHGm0RbKjDOk6Rtk+TTzT9O3otiDTCpx3iiDJqICHz4q2ydHfxyVat8411QSE=
Received: from AM0PR05MB4866.eurprd05.prod.outlook.com (20.176.214.160) by
 AM0PR05MB5202.eurprd05.prod.outlook.com (20.178.19.15) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2750.18; Mon, 24 Feb 2020 07:10:13 +0000
Received: from AM0PR05MB4866.eurprd05.prod.outlook.com
 ([fe80::8c4:e45b:ecdc:e02b]) by AM0PR05MB4866.eurprd05.prod.outlook.com
 ([fe80::8c4:e45b:ecdc:e02b%7]) with mapi id 15.20.2750.021; Mon, 24 Feb 2020
 07:10:13 +0000
From:   Parav Pandit <parav@mellanox.com>
To:     Leon Romanovsky <leon@kernel.org>
CC:     Jason Gunthorpe <jgg@ziepe.ca>, Weihang Li <liweihang@huawei.com>,
        "dledford@redhat.com" <dledford@redhat.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "linuxarm@huawei.com" <linuxarm@huawei.com>,
        Shiraz Saleem <shiraz.saleem@intel.com>
Subject: Re: Is anyone working on implementing LAG in ib core?
Thread-Topic: Is anyone working on implementing LAG in ib core?
Thread-Index: AQHV6TLqRqVlI00f7kyTjr5i8r/fvKgn4IQAgAARzwCAAJhaAIABZdYA
Date:   Mon, 24 Feb 2020 07:10:13 +0000
Message-ID: <5db0d4f8-1893-33c2-fb25-e6012e0fc6d6@mellanox.com>
References: <280d87d0-fbc0-0566-794b-f66cb4fadb63@huawei.com>
 <20200222234026.GO31668@ziepe.ca>
 <98482e8a-f2eb-5406-b679-0ceb946ac618@mellanox.com>
 <20200223094928.GB422704@unreal>
In-Reply-To: <20200223094928.GB422704@unreal>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=parav@mellanox.com; 
x-originating-ip: [68.203.16.89]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: b52cc019-3adf-4ff6-769a-08d7b8f897f9
x-ms-traffictypediagnostic: AM0PR05MB5202:
x-microsoft-antispam-prvs: <AM0PR05MB5202C4ABC8F850FC19B440FED1EC0@AM0PR05MB5202.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 032334F434
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(366004)(39860400002)(136003)(376002)(346002)(396003)(199004)(189003)(81156014)(8676002)(2616005)(71200400001)(5660300002)(81166006)(316002)(31696002)(86362001)(478600001)(31686004)(4326008)(6916009)(54906003)(8936002)(26005)(6512007)(6506007)(66476007)(91956017)(2906002)(66556008)(66946007)(6486002)(76116006)(66446008)(186003)(64756008)(36756003)(53546011);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR05MB5202;H:AM0PR05MB4866.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: lulf2OlCsKpQ7BG6KB8NCR7Rtg42GbdykcY0maMOt4vU0JjuLTog/w7xwDkYxshv46uSnpQ7APJMUPz2OFo8HVKqidE3rfaMcXWhiEpFlpb7UTfpbEbjAPZx9wpBRL/wfAU6RG0F/PAKCy2H8jha5nhTSyExYMJcX036MObh1VkqiKpmZQAa4V1hrSdr27u8e2XuSrt5WIDpjbkEzhl8R8GcQFmE6244nVR0SUaKE3nuo/BXry4IOro/o9EghJ/q8Y/WqzrIZb5kZM8djGShdwRVPhUhv5fgMTkJJZCixasRNBEwiai5k+Hq8uAbWnWYxOQsuWbVZ+UW5S241mbLb/awRu4Kf1TMkzdqDhZFunmRxLgCigemPUOJcDDjvpfHEn4bB6TZVgneurjKpaYFlGYdfoQ6jpBzDXYaKfD3UgY1wUJAHwJ/m1qxh1S6KTrH
x-ms-exchange-antispam-messagedata: HQxEHJ0HiQ9N295uNhMfzbHN581S97i4wQeO+TnxKaW65mWYImq/206eIqXr14vNqYgsnFXVqHF4KXSL6rKr3CTI9cmYe14QvAohF2WDKT6kRUesLFNjEqR7AAxE+PCsbF8q0X3sagg17n39wstc7Q==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <E5F5D7A69101674F829B0F8C2B5FFFB5@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b52cc019-3adf-4ff6-769a-08d7b8f897f9
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Feb 2020 07:10:13.5724
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EZ9He/W9vmwCtVlyXTbdh3pwLHv+K0c3rl3untQTwr3o7uV2LJ+BAK3MBvFn1CFA7AGNZ7+6zvTFW9d07nhnPw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR05MB5202
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

SGkgTGVvbiwNCg0KT24gMi8yMy8yMDIwIDM6NDkgQU0sIExlb24gUm9tYW5vdnNreSB3cm90ZToN
Cj4gT24gU3VuLCBGZWIgMjMsIDIwMjAgYXQgMTI6NDQ6MTJBTSArMDAwMCwgUGFyYXYgUGFuZGl0
IHdyb3RlOg0KPj4gSGkgSmFzb24sIFdlaWhhbmcsDQo+Pg0KPj4gT24gMi8yMi8yMDIwIDU6NDAg
UE0sIEphc29uIEd1bnRob3JwZSB3cm90ZToNCj4+PiBPbiBTYXQsIEZlYiAyMiwgMjAyMCBhdCAx
MTo0ODowNEFNICswODAwLCBXZWloYW5nIExpIHdyb3RlOg0KPj4+PiBIaSBhbGwsDQo+Pj4+DQo+
Pj4+IFdlIHBsYW4gdG8gaW1wbGVtZW50IExBRyBpbiBobnMgZHJpdmVycyByZWNlbnRseSwgYW5k
IGFzIHdlIGtub3csIHRoZXJlIGlzDQo+Pj4+IGFscmVhZHkgYSBtYXR1cmUgYW5kIHN0YWJsZSBz
b2x1dGlvbiBpbiB0aGUgbWx4NSBkcml2ZXIuIENvbnNpZGVyaW5nIHRoYXQNCj4+Pj4gdGhlIG5l
dCBzdWJzeXN0ZW0gaW4ga2VybmVsIGFkb3B0IHRoZSBzdHJhdGVneSB0aGF0IHRoZSBmcmFtZXdv
cmsgaW1wbGVtZW50DQo+Pj4+IGJvbmRpbmcsIHdlIHRoaW5rIGl0J3MgcmVhc29uYWJsZSB0byBh
ZGQgTEFHIGZlYXR1cmUgdG8gdGhlIGliIGNvcmUgYmFzZWQNCj4+Pj4gb24gbWx4NSdzIGltcGxl
bWVudGF0aW9uLiBTbyB0aGF0IGFsbCBkcml2ZXJzIGluY2x1ZGluZyBobnMgYW5kIG1seDUgY2Fu
DQo+Pj4+IGJlbmVmaXQgZnJvbSBpdC4NCj4+Pj4NCj4+Pj4gSW4gcHJldmlvdXMgZGlzY3Vzc2lv
bnMgd2l0aCBMZW9uIGFib3V0IGFjaGlldmluZyByZXBvcnRpbmcgb2YgaWIgcG9ydCBsaW5rDQo+
Pj4+IGV2ZW50IGluIGliIGNvcmUsIExlb24gbWVudGlvbmVkIHRoYXQgdGhlcmUgbWlnaHQgYmUg
c29tZW9uZSB0cnlpbmcgdG8gZG8NCj4+Pj4gdGhpcy4NCj4+Pj4NCj4+Pj4gU28gbWF5IEkgYXNr
IGlmIHRoZXJlIGlzIGFueW9uZSB3b3JraW5nIG9uIExBRyBpbiBpYiBjb3JlIG9yIHBsYW5uaW5n
IHRvDQo+Pj4+IGltcGxlbWVudCBpdCBpbiBuZWFyIGZ1dHVyZT8gSSB3aWxsIGFwcHJlY2lhdGUg
aXQgaWYgeW91IGNhbiBzaGFyZSB5b3VyDQo+Pj4+IHByb2dyZXNzIHdpdGggbWUgYW5kIG1heWJl
IHdlIGNhbiBmaW5pc2ggaXQgdG9nZXRoZXIuDQo+Pj4+DQo+Pj4+IElmIG5vYm9keSBpcyB3b3Jr
aW5nIG9uIHRoaXMsIG91ciB0ZWFtIG1heSB0YWtlIGEgdHJ5IHRvIGltcGxlbWVudCBMQUcgaW4N
Cj4+Pj4gdGhlIGNvcmUuIEFueSBjb21tZW50cyBhbmQgc3VnZ2VzdGlvbiBhcmUgd2VsY29tZS4N
Cj4+Pg0KPj4+IFRoaXMgaXMgc29tZXRoaW5nIHRoYXQgbmVlZHMgdG8gYmUgZG9uZSwgSSB1bmRl
cnN0YW5kIHNldmVyYWwgb2YgdGhlDQo+Pj4gb3RoZXIgZHJpdmVycyBhcmUgZ29pbmcgdG8gd2Fu
dCB0byB1c2UgTEFHIGFuZCB3ZSBjZXJ0YWlubHkgY2FuJ3QgaGF2ZQ0KPj4+IGV2ZXJ5dGhpbmcg
Y29waWVkIGludG8gZWFjaCBkcml2ZXIuDQo+Pj4NCj4+PiBKYXNvbg0KPj4+DQo+PiBJIGFtIG5v
dCBzdXJlIG1seDUgaXMgcmlnaHQgbW9kZWwgZm9yIG5ldyByZG1hIGJvbmQgZGV2aWNlIHN1cHBv
cnQgd2hpY2gNCj4+IEkgdHJpZWQgdG8gaGlnaGxpZ2h0IGluIFEmQS0xIGJlbG93Lg0KPj4NCj4+
IEkgaGF2ZSBiZWxvdyBub3Qtc28tcmVmaW5lZCBwcm9wb3NhbCBmb3IgcmRtYSBib25kIGRldmlj
ZS4NCj4+DQo+PiAtIENyZWF0ZSBhIHJkbWEgYm9uZCBkZXZpY2UgbmFtZWQgcmJvbmQwIHVzaW5n
IHR3byBzbGF2ZSByZG1hIGRldmljZXMNCj4+IG1seDVfMCBtbHg1XzEgd2hpY2ggaXMgY29ubmVj
dGVkIHRvIG5ldGRldmljZSBib25kMSBhbmQgdW5kZXJseWluZyBkbWENCj4+IGRldmljZSBvZiBt
bHg1XzAgcmRtYSBkZXZpY2UuDQo+Pg0KPj4gJCByZG1hIGRldiBhZGQgdHlwZSBib25kIG5hbWUg
cmJvbmQwIG5ldGRldiBib25kMSBzbGF2ZSBtbHg1XzAgc2xhdmUNCj4+IG1seDVfMSBkbWFkZXZp
Y2UgbWx4NV8wDQo+Pg0KPj4gJCByZG1hIGRldiBzaG93DQo+PiAwOiBtbHg1XzA6IG5vZGVfdHlw
ZSBjYSBmdyAxMi4yNS4xMDIwIG5vZGVfZ3VpZCAyNDhhOjA3MDM6MDA1NTo0NjYwDQo+PiBzeXNf
aW1hZ2VfZ3VpZCAyNDhhOjA3MDM6MDA1NTo0NjYwDQo+PiAxOiBtbHg1XzE6IG5vZGVfdHlwZSBj
YSBmdyAxMi4yNS4xMDIwIG5vZGVfZ3VpZCAyNDhhOjA3MDM6MDA1NTo0NjYxDQo+PiBzeXNfaW1h
Z2VfZ3VpZCAyNDhhOjA3MDM6MDA1NTo0NjYwDQo+PiAyOiByYm9uZDA6IG5vZGVfdHlwZSBjYSBu
b2RlX2d1aWQgMjQ4YTowNzAzOjAwNTU6NDY2MCBzeXNfaW1hZ2VfZ3VpZA0KPj4gMjQ4YTowNzAz
OjAwNTU6NDY2MA0KPj4NCj4+IC0gVGhpcyBzaG91bGQgYmUgZG9uZSB2aWEgcmRtYSBib25kIGRy
aXZlciBpbg0KPj4gZHJpdmVycy9pbmZpbmliYW5kL3VscC9yZG1hX2JvbmQNCj4gDQo+IEV4dHJh
IHF1ZXN0aW9uLCB3aHkgZG8gd2UgbmVlZCBSRE1BIGJvbmQgVUxQIHdoaWNoIGNvbWJpbmVzIGli
IGRldmljZXMNCj4gYW5kIG5vdCBjcmVhdGUgbmV0ZGV2IGJvbmQgZGV2aWNlIGFuZCBjcmVhdGUg
b25lIGliIGRldmljZSBvbiB0b3Agb2YgdGhhdD8NCj4gDQoNCkkgcmVhZCB5b3VyIHF1ZXN0aW9u
IGZldyB0aW1lcywgYnV0IEkgbGlrZWx5IGRvbid0IHVuZGVyc3RhbmQgeW91ciBxdWVzdGlvbi4N
Cg0KQXJlIHlvdSBhc2tpbmcgd2h5IGJvbmRpbmcgc2hvdWxkIGJlIGltcGxlbWVudGVkIGFzIGRl
ZGljYXRlZA0KdWxwL2RyaXZlciwgYW5kIG5vdCBhcyBhbiBleHRlbnNpb24gYnkgdGhlIHZlbmRv
ciBkcml2ZXI/DQoNCkluIGFuIGFsdGVybmF0aXZlIGFwcHJvYWNoIGEgZ2l2ZW4gaHcgZHJpdmVy
IGltcGxlbWVudHMgYSBuZXdsaW5rKCkNCmluc3RlYWQgb2YgZGVkaWNhdGVkIGJvbmQgZHJpdmVy
Lg0KSG93ZXZlciB0aGlzIHdpbGwgZHVwbGljYXRlIHRoZSBjb2RlIGluIGZldyBkcml2ZXJzLiBI
ZW5jZSwgdG8gZG8gaW4NCmNvbW1vbiBkcml2ZXIgYW5kIGltcGxlbWVudCBvbmx5IG5lY2Vzc2Fy
eSBob29rcyBpbiBodyBkcml2ZXIuDQoNCj4gVGhhbmtzDQo+IA0KDQo=
