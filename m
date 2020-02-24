Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AC44A16AE60
	for <lists+linux-rdma@lfdr.de>; Mon, 24 Feb 2020 19:12:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727673AbgBXSMW (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 24 Feb 2020 13:12:22 -0500
Received: from mail-eopbgr70049.outbound.protection.outlook.com ([40.107.7.49]:10597
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726208AbgBXSMV (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 24 Feb 2020 13:12:21 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aPRVtlJap4NvHKGVpN/hBuU/+T3zEmE3Hwyv6Y8BxEs72JV+N7LFzCLXS18kIsNSZsDzl2EbgjJGtIRF+JolihzOTEby6sW//U82zuUlQvX8KZead4m/Dlr2ZeZInyLTrfbtLAx4lkKEsQOf1PF4QgcbVuJgmeZhCncU8PpOihQxRXVSGoR7M4bdsmfDqkb7Rem67Q5E+VdXMJ07HytIzM7pU5VfXC6DodxoEgEOx8bcRKXSPfdEjlOET3M8+84B5xNGl/3C7s6PU86CfRFJ2KZ6j23jySqXsrsb4+YiHBaPWZBGlzFpHMurKWwQP91mxMITWGE1beEd5a0isJ5pYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0exL+F7kH/NpZ0gG4MrHt73RtVA+sYjpVlNlSfFq0Xs=;
 b=TvJduXIQhW9s5P21XgJZyL1hxgnGr2FeSQ8fB4y4+Nc85bnjE7DBCthRngLZnIMix3QCz7lvJZJ2B4+2+9RTdQjATfBlF2PyOnhx7vfpaAYMhnsV2upiD+ojMb/vmO14pewpYqU1Ep7lYUo7+1pu2YStA0phPs8E77Hg9Dr7XANmOSz+XatGAlmJATRb02EREjaUZ16kVKVOiBtB3+JG+YEgH1e5leMoj0P1OFxDA+gJqjzJHKEKfJKbBlbEajmactno3Xh0L2amby+whouMdhtHQmq/Vm5KHYeUwz17+JiPvF8PGemp+wm/SZVlalkkXGRHTFmjFoyqt1BjVsJfEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mellanox.com; dmarc=pass action=none header.from=mellanox.com;
 dkim=pass header.d=mellanox.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0exL+F7kH/NpZ0gG4MrHt73RtVA+sYjpVlNlSfFq0Xs=;
 b=sxSZE5zSFSp/TRllThtSPUNkPHWo+DYVYEdLyw2hRTn5FCvGoeUD0SPW5rrwat8nfRWNO7HseSrIGze0gOjtLaJUgOE7FDqk+hJa4MeIYHjtw2KAHGUOVmkE1v1mMWBe21g8eGWXQ/U05xiMR7cKGuJ0SHWt8fD5ofGJufZi8nc=
Received: from AM0PR05MB4866.eurprd05.prod.outlook.com (20.176.214.160) by
 AM0PR05MB6209.eurprd05.prod.outlook.com (20.178.113.20) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2750.18; Mon, 24 Feb 2020 18:12:15 +0000
Received: from AM0PR05MB4866.eurprd05.prod.outlook.com
 ([fe80::8c4:e45b:ecdc:e02b]) by AM0PR05MB4866.eurprd05.prod.outlook.com
 ([fe80::8c4:e45b:ecdc:e02b%7]) with mapi id 15.20.2750.021; Mon, 24 Feb 2020
 18:12:15 +0000
From:   Parav Pandit <parav@mellanox.com>
To:     Leon Romanovsky <leon@kernel.org>
CC:     Jason Gunthorpe <jgg@ziepe.ca>, Weihang Li <liweihang@huawei.com>,
        "dledford@redhat.com" <dledford@redhat.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "linuxarm@huawei.com" <linuxarm@huawei.com>,
        Shiraz Saleem <shiraz.saleem@intel.com>
Subject: Re: Is anyone working on implementing LAG in ib core?
Thread-Topic: Is anyone working on implementing LAG in ib core?
Thread-Index: AQHV6TLqRqVlI00f7kyTjr5i8r/fvKgn4IQAgAARzwCAAJhaAIABZdYAgAA9/wCAAHr5AA==
Date:   Mon, 24 Feb 2020 18:12:15 +0000
Message-ID: <19aa0408-4d8b-4708-d0a9-3afa8b67ae8b@mellanox.com>
References: <280d87d0-fbc0-0566-794b-f66cb4fadb63@huawei.com>
 <20200222234026.GO31668@ziepe.ca>
 <98482e8a-f2eb-5406-b679-0ceb946ac618@mellanox.com>
 <20200223094928.GB422704@unreal>
 <5db0d4f8-1893-33c2-fb25-e6012e0fc6d6@mellanox.com>
 <20200224105206.GA468372@unreal>
In-Reply-To: <20200224105206.GA468372@unreal>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=parav@mellanox.com; 
x-originating-ip: [208.176.44.194]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 4d250655-b47c-4226-cbb7-08d7b95513f1
x-ms-traffictypediagnostic: AM0PR05MB6209:
x-microsoft-antispam-prvs: <AM0PR05MB62094D66CF31F571B4D65553D1EC0@AM0PR05MB6209.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 032334F434
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(39860400002)(366004)(396003)(136003)(376002)(346002)(189003)(199004)(81156014)(8676002)(2616005)(71200400001)(5660300002)(316002)(81166006)(31696002)(86362001)(4326008)(478600001)(31686004)(6916009)(54906003)(8936002)(26005)(6512007)(6506007)(66476007)(91956017)(2906002)(6486002)(66556008)(66946007)(76116006)(66446008)(186003)(64756008)(36756003)(53546011);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR05MB6209;H:AM0PR05MB4866.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: mqyP0eX3T3bRBrNKNm0QkPLmgmKSCBe/cqp6tUPRAh+9IBjMGGchPhPNG+ZkYqxHIQIKAYymGTo2RRR0rBS0DoDq3+MuPNy71aaHSDCo4nFf12MMk/4PUUWe6vCXlplQ72TjQ/kPAMNKx7qveL2eC4sqVoNzSpCINuMH4B4hzlkt7FaB3XVSfQqayj0dtvAartS8zzQ5oCYckMviuSe/KRlsPacFw3tpwAwc/OnRn+dyXv57I9n36Cbv1bmSIE53Yx4qnSaFcdVFNY17I6gCuHv/Jrw1T5gOItZnzAt+Z8UZrZQ6r5XPox1z1UxWLgUOTh6x73VuNQ4c0vCH/Nk6DyJQ82uUF05i/s/m8LDyRB1ZGM9UdpnNWWZGqdU4cL9Muehk5/h6hlQ3/pnVLXvQvmZNQtsSAp/PJFfNmy+xr+Tx0eRXapnQurggtSKQ2DIv
x-ms-exchange-antispam-messagedata: 1oqRUcwXhBEUoeSAcfgx0B1N8e0n6qfJlLOju03hFF1HIBrxa62Pp1YdH6M8KXGE8ZE7XCTgVcrdtUG1oNdyzIwLCLayIVGhNfyOXlUWiAqhzdefcuEWVg8oAfiUELoXhbMklFHbRKQ7ebKbpsPFjg==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <95978F20AA7B1D45940ECC5A777AE84D@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d250655-b47c-4226-cbb7-08d7b95513f1
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Feb 2020 18:12:15.3117
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: astDMXmvCtEUOE7AkysTU5jCjTeqo1jJYYDadzEN6bQENZMMCX3uZRdwZXUX7CYRSS3367pxyvIpCZoKe1yDvw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR05MB6209
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

T24gMi8yNC8yMDIwIDQ6NTIgQU0sIExlb24gUm9tYW5vdnNreSB3cm90ZToNCj4gT24gTW9uLCBG
ZWIgMjQsIDIwMjAgYXQgMDc6MTA6MTNBTSArMDAwMCwgUGFyYXYgUGFuZGl0IHdyb3RlOg0KPj4g
SGkgTGVvbiwNCj4+DQo+PiBPbiAyLzIzLzIwMjAgMzo0OSBBTSwgTGVvbiBSb21hbm92c2t5IHdy
b3RlOg0KPj4+IE9uIFN1biwgRmViIDIzLCAyMDIwIGF0IDEyOjQ0OjEyQU0gKzAwMDAsIFBhcmF2
IFBhbmRpdCB3cm90ZToNCj4+Pj4gSGkgSmFzb24sIFdlaWhhbmcsDQo+Pj4+DQo+Pj4+IE9uIDIv
MjIvMjAyMCA1OjQwIFBNLCBKYXNvbiBHdW50aG9ycGUgd3JvdGU6DQo+Pj4+PiBPbiBTYXQsIEZl
YiAyMiwgMjAyMCBhdCAxMTo0ODowNEFNICswODAwLCBXZWloYW5nIExpIHdyb3RlOg0KPj4+Pj4+
IEhpIGFsbCwNCj4+Pj4+Pg0KPj4+Pj4+IFdlIHBsYW4gdG8gaW1wbGVtZW50IExBRyBpbiBobnMg
ZHJpdmVycyByZWNlbnRseSwgYW5kIGFzIHdlIGtub3csIHRoZXJlIGlzDQo+Pj4+Pj4gYWxyZWFk
eSBhIG1hdHVyZSBhbmQgc3RhYmxlIHNvbHV0aW9uIGluIHRoZSBtbHg1IGRyaXZlci4gQ29uc2lk
ZXJpbmcgdGhhdA0KPj4+Pj4+IHRoZSBuZXQgc3Vic3lzdGVtIGluIGtlcm5lbCBhZG9wdCB0aGUg
c3RyYXRlZ3kgdGhhdCB0aGUgZnJhbWV3b3JrIGltcGxlbWVudA0KPj4+Pj4+IGJvbmRpbmcsIHdl
IHRoaW5rIGl0J3MgcmVhc29uYWJsZSB0byBhZGQgTEFHIGZlYXR1cmUgdG8gdGhlIGliIGNvcmUg
YmFzZWQNCj4+Pj4+PiBvbiBtbHg1J3MgaW1wbGVtZW50YXRpb24uIFNvIHRoYXQgYWxsIGRyaXZl
cnMgaW5jbHVkaW5nIGhucyBhbmQgbWx4NSBjYW4NCj4+Pj4+PiBiZW5lZml0IGZyb20gaXQuDQo+
Pj4+Pj4NCj4+Pj4+PiBJbiBwcmV2aW91cyBkaXNjdXNzaW9ucyB3aXRoIExlb24gYWJvdXQgYWNo
aWV2aW5nIHJlcG9ydGluZyBvZiBpYiBwb3J0IGxpbmsNCj4+Pj4+PiBldmVudCBpbiBpYiBjb3Jl
LCBMZW9uIG1lbnRpb25lZCB0aGF0IHRoZXJlIG1pZ2h0IGJlIHNvbWVvbmUgdHJ5aW5nIHRvIGRv
DQo+Pj4+Pj4gdGhpcy4NCj4+Pj4+Pg0KPj4+Pj4+IFNvIG1heSBJIGFzayBpZiB0aGVyZSBpcyBh
bnlvbmUgd29ya2luZyBvbiBMQUcgaW4gaWIgY29yZSBvciBwbGFubmluZyB0bw0KPj4+Pj4+IGlt
cGxlbWVudCBpdCBpbiBuZWFyIGZ1dHVyZT8gSSB3aWxsIGFwcHJlY2lhdGUgaXQgaWYgeW91IGNh
biBzaGFyZSB5b3VyDQo+Pj4+Pj4gcHJvZ3Jlc3Mgd2l0aCBtZSBhbmQgbWF5YmUgd2UgY2FuIGZp
bmlzaCBpdCB0b2dldGhlci4NCj4+Pj4+Pg0KPj4+Pj4+IElmIG5vYm9keSBpcyB3b3JraW5nIG9u
IHRoaXMsIG91ciB0ZWFtIG1heSB0YWtlIGEgdHJ5IHRvIGltcGxlbWVudCBMQUcgaW4NCj4+Pj4+
PiB0aGUgY29yZS4gQW55IGNvbW1lbnRzIGFuZCBzdWdnZXN0aW9uIGFyZSB3ZWxjb21lLg0KPj4+
Pj4NCj4+Pj4+IFRoaXMgaXMgc29tZXRoaW5nIHRoYXQgbmVlZHMgdG8gYmUgZG9uZSwgSSB1bmRl
cnN0YW5kIHNldmVyYWwgb2YgdGhlDQo+Pj4+PiBvdGhlciBkcml2ZXJzIGFyZSBnb2luZyB0byB3
YW50IHRvIHVzZSBMQUcgYW5kIHdlIGNlcnRhaW5seSBjYW4ndCBoYXZlDQo+Pj4+PiBldmVyeXRo
aW5nIGNvcGllZCBpbnRvIGVhY2ggZHJpdmVyLg0KPj4+Pj4NCj4+Pj4+IEphc29uDQo+Pj4+Pg0K
Pj4+PiBJIGFtIG5vdCBzdXJlIG1seDUgaXMgcmlnaHQgbW9kZWwgZm9yIG5ldyByZG1hIGJvbmQg
ZGV2aWNlIHN1cHBvcnQgd2hpY2gNCj4+Pj4gSSB0cmllZCB0byBoaWdobGlnaHQgaW4gUSZBLTEg
YmVsb3cuDQo+Pj4+DQo+Pj4+IEkgaGF2ZSBiZWxvdyBub3Qtc28tcmVmaW5lZCBwcm9wb3NhbCBm
b3IgcmRtYSBib25kIGRldmljZS4NCj4+Pj4NCj4+Pj4gLSBDcmVhdGUgYSByZG1hIGJvbmQgZGV2
aWNlIG5hbWVkIHJib25kMCB1c2luZyB0d28gc2xhdmUgcmRtYSBkZXZpY2VzDQo+Pj4+IG1seDVf
MCBtbHg1XzEgd2hpY2ggaXMgY29ubmVjdGVkIHRvIG5ldGRldmljZSBib25kMSBhbmQgdW5kZXJs
eWluZyBkbWENCj4+Pj4gZGV2aWNlIG9mIG1seDVfMCByZG1hIGRldmljZS4NCj4+Pj4NCj4+Pj4g
JCByZG1hIGRldiBhZGQgdHlwZSBib25kIG5hbWUgcmJvbmQwIG5ldGRldiBib25kMSBzbGF2ZSBt
bHg1XzAgc2xhdmUNCj4+Pj4gbWx4NV8xIGRtYWRldmljZSBtbHg1XzANCj4+Pj4NCj4+Pj4gJCBy
ZG1hIGRldiBzaG93DQo+Pj4+IDA6IG1seDVfMDogbm9kZV90eXBlIGNhIGZ3IDEyLjI1LjEwMjAg
bm9kZV9ndWlkIDI0OGE6MDcwMzowMDU1OjQ2NjANCj4+Pj4gc3lzX2ltYWdlX2d1aWQgMjQ4YTow
NzAzOjAwNTU6NDY2MA0KPj4+PiAxOiBtbHg1XzE6IG5vZGVfdHlwZSBjYSBmdyAxMi4yNS4xMDIw
IG5vZGVfZ3VpZCAyNDhhOjA3MDM6MDA1NTo0NjYxDQo+Pj4+IHN5c19pbWFnZV9ndWlkIDI0OGE6
MDcwMzowMDU1OjQ2NjANCj4+Pj4gMjogcmJvbmQwOiBub2RlX3R5cGUgY2Egbm9kZV9ndWlkIDI0
OGE6MDcwMzowMDU1OjQ2NjAgc3lzX2ltYWdlX2d1aWQNCj4+Pj4gMjQ4YTowNzAzOjAwNTU6NDY2
MA0KPj4+Pg0KPj4+PiAtIFRoaXMgc2hvdWxkIGJlIGRvbmUgdmlhIHJkbWEgYm9uZCBkcml2ZXIg
aW4NCj4+Pj4gZHJpdmVycy9pbmZpbmliYW5kL3VscC9yZG1hX2JvbmQNCj4+Pg0KPj4+IEV4dHJh
IHF1ZXN0aW9uLCB3aHkgZG8gd2UgbmVlZCBSRE1BIGJvbmQgVUxQIHdoaWNoIGNvbWJpbmVzIGli
IGRldmljZXMNCj4+PiBhbmQgbm90IGNyZWF0ZSBuZXRkZXYgYm9uZCBkZXZpY2UgYW5kIGNyZWF0
ZSBvbmUgaWIgZGV2aWNlIG9uIHRvcCBvZiB0aGF0Pw0KPj4+DQo+Pg0KPj4gSSByZWFkIHlvdXIg
cXVlc3Rpb24gZmV3IHRpbWVzLCBidXQgSSBsaWtlbHkgZG9uJ3QgdW5kZXJzdGFuZCB5b3VyIHF1
ZXN0aW9uLg0KPj4NCj4+IEFyZSB5b3UgYXNraW5nIHdoeSBib25kaW5nIHNob3VsZCBiZSBpbXBs
ZW1lbnRlZCBhcyBkZWRpY2F0ZWQNCj4+IHVscC9kcml2ZXIsIGFuZCBub3QgYXMgYW4gZXh0ZW5z
aW9uIGJ5IHRoZSB2ZW5kb3IgZHJpdmVyPw0KPiANCj4gTm8sIEkgbWVhbnQgc29tZXRoaW5nIGRp
ZmZlcmVudC4gWW91IGFyZSBwcm9wb3NpbmcgdG8gY29tYmluZSBJQg0KPiBkZXZpY2VzLCB3aGls
ZSBrZWVwaW5nIG5ldGRldiBkZXZpY2VzIHNlcGFyYXRlZC4gSSdtIGFza2luZyBpZiBpdCBpcw0K
PiBwb3NzaWJsZSB0byBjb21iaW5lIG5ldGRldiBkZXZpY2VzIHdpdGggYWxyZWFkeSBleGlzdGlu
ZyBib25kIGRyaXZlcg0KPiBhbmQgc2ltcGx5IGNyZWF0ZSBuZXcgaWIgZGV2aWNlIHdpdGggYm9u
ZCBuZXRkZXYgYXMgYW4gdW5kZXJseWluZw0KPiBwcm92aWRlci4NCj4gDQpBaCBJIHVuZGVyc3Rh
bmQgbm93Lg0KWWVzLCBpZiBib25kX25ld2xpbmsoKSBjYW4gYmUgZXh0ZW5kZWQgdG8gYWNjZXB0
IHJkbWEgZGV2aWNlIHNwZWNpZmljDQpwYXJhbWV0ZXJzLCBpdCBzaG91bGQgYmUgcG9zc2libGUu
DQoNCkZvciBleGFtcGxlIHdlIGFscmVhZHkgaGF2ZSB0d28gY2xhc3Mgb2YgdXNlcnMgd2hlcmUg
b25lIHdhbnRzIHRvIGhhdmUNCnJkbWEgYm9uZCBkZXZpY2UgY3JlYXRlZCBhbmQgb25lIGRvZXNu
J3Qgd2FudCB0byBjcmVhdGUgZm9yIGEgZ2l2ZW4gYm9uZA0KbmV0ZGV2Lg0KDQpZb3UgbWlnaHQg
YmUgYWxyZWFkeSBhd2FyZSB0aGF0IG5ld2xpbmsoKSBpcyBjYWxsZWQgdW5kZXIgcnRubCBsb2Nr
IGFuZA0KaWJfcmVnaXN0ZXJfZGV2aWNlKCkgYWxzbyBuZWVkIHRvIGFjcXVpcmUgcnRubCBsb2Nr
LiBCdXQgdGhpcyBpcw0KaW1wbGVtZW50YXRpb24gdGhhdCBjYW4gYmUgZGlzY3Vzc2VkIGxhdGVy
IG9uY2UgYm9uZCBkcml2ZXIgZXh0ZW5zaW9uDQpmb3IgcmRtYSBtYWtlIHNlbnNlLiA6LSkNCg0K
SWYgb25lIHdhbnRzIHRvIGNyZWF0ZSBhIHZsYW4gbmV0ZGV2aWNlIG9uIHRvcCBvZiBib25kIGRl
dmljZSwgdXNlcg0KdXN1YWxseSBjcmVhdGVzIGl0IGFmdGVyIGJvbmQgbmV0ZGV2aWNlIGlzIGNy
ZWF0ZWQuDQpTaW1pbGFybHkgSSBzZWUgdGhhdCBib25kIHJkbWEgZGV2aWNlIGlzIGNvbXBvc2Vk
IG9mIHVuZGVybHlpbmcgYm9uZA0KbmV0ZGV2IGFuZCB1bmRlcmx5aW5nIHJkbWEgZGV2aWNlIG9y
IGF0IGxlYXN0IGl0cyBwYXJlbnQgJ3N0cnVjdCBkZXZpY2UnDQpmb3IgcHVycG9zZSBvZiBpcnEg
cm91dGluZywgcGNpIGFjY2VzcyBldGMuDQoNCkNvbXBhcmUgdG8gb3ZlcmxvYWRpbmcgYm9uZF9u
ZXdsaW5rKCkgd2l0aCByZG1hIHBhcmFtZXRlcnMsIGluZGVwZW5kZW50DQpyZG1hIGJvbmQgZGV2
aWNlIGNyZWF0aW9uIGxpbmtlZCB0byBib25kIG5ldGRldiwgYXBwZWFycyBtb3JlIGVsZWdhbnQN
CmFuZCBtb2R1bGFyIGFwcHJvYWNoLg0KDQo+IEknbSBub3Qgc3VnZ2VzdGluZyB0byBpbXBsZW1l
bnQgYW55dGhpbmcgaW4gdmVuZG9yIGRyaXZlcnMuDQo+IA0KPj4NCj4+IEluIGFuIGFsdGVybmF0
aXZlIGFwcHJvYWNoIGEgZ2l2ZW4gaHcgZHJpdmVyIGltcGxlbWVudHMgYSBuZXdsaW5rKCkNCj4+
IGluc3RlYWQgb2YgZGVkaWNhdGVkIGJvbmQgZHJpdmVyLg0KPj4gSG93ZXZlciB0aGlzIHdpbGwg
ZHVwbGljYXRlIHRoZSBjb2RlIGluIGZldyBkcml2ZXJzLiBIZW5jZSwgdG8gZG8gaW4NCj4+IGNv
bW1vbiBkcml2ZXIgYW5kIGltcGxlbWVudCBvbmx5IG5lY2Vzc2FyeSBob29rcyBpbiBodyBkcml2
ZXIuDQo+IA0KPiBJJ20gbm90IHN1cmUgYWJvdXQgaXQuDQo+IA0KPj4NCj4+PiBUaGFua3MNCj4+
Pg0KPj4NCg0K
