Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 326E217CC1
	for <lists+linux-rdma@lfdr.de>; Wed,  8 May 2019 17:02:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726163AbfEHPCe (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 8 May 2019 11:02:34 -0400
Received: from mail-eopbgr130053.outbound.protection.outlook.com ([40.107.13.53]:65210
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726649AbfEHPCd (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 8 May 2019 11:02:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=32pbzUUrFMaUtff+CTZcMi3HKbsNoU73kyKTLzbCt1w=;
 b=U0BGZsrRTIPi1eN7ezPTcrMhTlSX2dXZZWY+/WT/9sO2pESLtY0apSzbHvEjnbGfiSTpWuSmejimrvysuu8qXevUbHPw1M5nk1A455XcYnSQpncXHmeHk9s+6AtjCP5T0VK+KLjRgHkdu2FlPc2/h43yepg1/klCgropL5zRbG0=
Received: from VI1PR0501MB2701.eurprd05.prod.outlook.com (10.172.15.23) by
 VI1PR0501MB2607.eurprd05.prod.outlook.com (10.168.137.19) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1878.20; Wed, 8 May 2019 15:02:25 +0000
Received: from VI1PR0501MB2701.eurprd05.prod.outlook.com
 ([fe80::21a9:b659:2332:4e9a]) by VI1PR0501MB2701.eurprd05.prod.outlook.com
 ([fe80::21a9:b659:2332:4e9a%6]) with mapi id 15.20.1878.019; Wed, 8 May 2019
 15:02:25 +0000
From:   Majd Dibbiny <majd@mellanox.com>
To:     Jason Gunthorpe <jgg@mellanox.com>,
        Adit Ranadive <aditr@vmware.com>
CC:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "dledford@redhat.com" <dledford@redhat.com>
Subject: Re: [PATCH] libibverbs: Expose the get neighbor timeout for dmac
 resolution
Thread-Topic: [PATCH] libibverbs: Expose the get neighbor timeout for dmac
 resolution
Thread-Index: AQHVBJQ03rON3H5UMUmK3O/KPKwCrqZfnnCAgABUfYCAAVligIAACKCq
Date:   Wed, 8 May 2019 15:02:25 +0000
Message-ID: <ED61DBC4-5762-47C8-89D5-89FAE763F915@mellanox.com>
References: <20190507051537.2161-1-aditr@vmware.com>
 <20190507125259.GT6186@mellanox.com>
 <266697af-bf5e-07a1-489e-fed7cf8c695a@vmware.com>,<20190508143133.GG32297@mellanox.com>
In-Reply-To: <20190508143133.GG32297@mellanox.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=majd@mellanox.com; 
x-originating-ip: [2.53.63.129]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4a632c3c-2b39-4c7c-a1e1-08d6d3c62e96
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:VI1PR0501MB2607;
x-ms-traffictypediagnostic: VI1PR0501MB2607:
x-microsoft-antispam-prvs: <VI1PR0501MB2607F0853DFEE056CF3C73C6A7320@VI1PR0501MB2607.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-forefront-prvs: 0031A0FFAF
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(346002)(396003)(39860400002)(376002)(366004)(189003)(199004)(86362001)(33656002)(68736007)(71190400001)(316002)(99286004)(3846002)(229853002)(5660300002)(54906003)(110136005)(102836004)(66476007)(66556008)(76116006)(64756008)(53546011)(186003)(91956017)(2616005)(73956011)(66446008)(486006)(476003)(66946007)(11346002)(6436002)(6116002)(6486002)(2906002)(26005)(66066001)(36756003)(446003)(6506007)(256004)(14454004)(478600001)(76176011)(71200400001)(82746002)(83716004)(25786009)(8936002)(81166006)(81156014)(8676002)(7736002)(305945005)(53936002)(4326008)(6246003)(6512007);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR0501MB2607;H:VI1PR0501MB2701.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 0WDId7b1rRQ36JJBctjNEdMD/Mf+Wl38xIg/VcBg2rK0gEUXG1qZRQ2RGxv7PLNLBsR5txlZ02OzXT3lBUGp9XWseS9n3eHNEdsSUTYqHKSA4jDNi+Plj0ET3YfugI7yZBK7wHoe3+C8CST/OduTNudF4ubiSvIhNJu6R44vy4klFMsYJWnQd7IIpQlOZrcRzHdYUlZiXjb0Dg1BLL6zIe16yyXQdeMtdLK+soxzFShpifVCdsl+I2gpaMMZ4RiU/umgOWwPuAsvwc0BC6YJpBjIPnbd5mnAC/5TCVTwEdSwaVXTcMcg/MMnDmrxSvMZ9Ag0e3LG5K5Z15kKr3Y2JzeMcyaT4blHUBuJ3hqh/yA95zm3lYeAQS4qMThvvY2YJD8OIGVNGx3GsFMdnYYw+L5K8aLxgywSSM3SYA0z/YQ=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a632c3c-2b39-4c7c-a1e1-08d6d3c62e96
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 May 2019 15:02:25.7542
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0501MB2607
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

DQo+IE9uIE1heSA4LCAyMDE5LCBhdCA1OjMxIFBNLCBKYXNvbiBHdW50aG9ycGUgPGpnZ0BtZWxs
YW5veC5jb20+IHdyb3RlOg0KPiANCj4gT24gVHVlLCBNYXkgMDcsIDIwMTkgYXQgMDU6NTU6MjVQ
TSArMDAwMCwgQWRpdCBSYW5hZGl2ZSB3cm90ZToNCj4+Pj4gLy8gQ29uZmlndXJhdGlvbiBkZWZh
dWx0cw0KPj4+PiANCj4+Pj4gI2RlZmluZSBJQkFDTV9TRVJWRVJfTU9ERV9VTklYIDANCj4+Pj4g
ZGlmZiAtLWdpdCBhL2xpYmlidmVyYnMvdmVyYnMuYyBiL2xpYmlidmVyYnMvdmVyYnMuYw0KPj4+
PiBpbmRleCAxNzY2YjlmNTJkMzEuLjJjYWI4NjE4NGUzMiAxMDA2NDQNCj4+Pj4gKysrIGIvbGli
aWJ2ZXJicy92ZXJicy5jDQo+Pj4+IEBAIC05NjcsNyArOTY3LDYgQEAgc3RhdGljIGlubGluZSBp
bnQgY3JlYXRlX3BlZXJfZnJvbV9naWQoaW50IGZhbWlseSwgdm9pZCAqcmF3X2dpZCwNCj4+Pj4g
ICAgcmV0dXJuIDA7DQo+Pj4+IH0NCj4+Pj4gDQo+Pj4+IC0jZGVmaW5lIE5FSUdIX0dFVF9ERUZB
VUxUX1RJTUVPVVRfTVMgMzAwMA0KPj4+PiBpbnQgaWJ2X3Jlc29sdmVfZXRoX2wyX2Zyb21fZ2lk
KHN0cnVjdCBpYnZfY29udGV4dCAqY29udGV4dCwNCj4+Pj4gICAgICAgICAgICAgICAgc3RydWN0
IGlidl9haF9hdHRyICphdHRyLA0KPj4+PiAgICAgICAgICAgICAgICB1aW50OF90IGV0aF9tYWNb
RVRIRVJORVRfTExfU0laRV0sDQo+Pj4gDQo+Pj4gUmVhbGx5IGNvbXBpbGUgdGltZSBjb25maWd1
cmF0aW9ucyBhcmUgbm90IHNvIHVzZWZ1bCwgd2hhdCBpcyB0aGUgdXNlDQo+Pj4gY2FzZSBoZXJl
PyANCj4+PiANCj4+IA0KPj4gSW4gdGhlIGdlbmVyYWwgc2Vuc2UgSSBhZ3JlZSB3aXRoIHlvdS4g
UHJlLWJ1aWx0IFJQTXMgbWF5IG5vdCBoYXZlIHRoaXMNCj4+IHNldCB0byBhbnl0aGluZyBvdGhl
ciB0aGFuIHRoZSBkZWZhdWx0IHZhbHVlLiANCj4+IEhvd2V2ZXIsIGluIG91ciBpbnRlcm5hbCB0
ZXN0aW5nIHdlJ3ZlIHNlZW4gdGltZW91dHMgd2hlbiB0cnlpbmcgdG8NCj4+IHJlc29sdmUgdGhl
IERNQUMgd2hlbiBjcmVhdGluZyBhbiBBSC4NCllvdSBjYW4gZG8gdGhpcyB1c2luZyB1dmVyYnMg
aW5zdGVhZCBvZiBuZXRsaW5rIGJ5IGNoYW5naW5nIHRoZSBjcmVhdGVfYWggcHJvdmlkZXLigJlz
IGltcGxlbWVudGF0aW9uLi4gYW5kIEFGQUlSIGl04oCZcyBtb3JlIHNjYWxhYmxlIHRoYW4gbmV0
bGluay4uDQo+PiBJbnN0ZWFkLCBvZiBzaW1wbHkgaW5jcmVhc2luZw0KPj4gdGhlICNkZWZpbmUg
dmFsdWUgaGVyZSBJIHRob3VnaHQgaXQgd291bGQgYmUgbWlsZGx5IGhlbHBmdWwgdG8gZXhwb3Nl
IA0KPj4gdGhpcyBvdXQuDQo+PiANCj4+IElmIHRoaXMgaXMgbm90IGdvaW5nIHRvIGJlIHVzZWZ1
bCBJIGNhbiBkcm9wIGl0IGJ1dCBJIHRob3VnaHQgaXQgd291bGQgDQo+PiBhdGxlYXN0IG1ha2Ug
cmRtYS1jb3JlIGEgYml0IG1vcmUgY29uZmlndXJhYmxlLi4NCj4gDQo+IFN0dWZmIGxpa2UgdGhp
cyBzaG91bGQgbm90IGJlIGNvbmZpZ3VyZWQuLiBpZiB5b3UgYXJlIGhpdHRpbmcgdGltZW91dA0K
PiBpdCBzb3VuZHMgbGlrZSBhIGJ1ZyBvZiBzb21lIHNvcnQgdG8gbWUuDQo+IA0KPiBKYXNvbg0K
