Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F3946AD703
	for <lists+linux-rdma@lfdr.de>; Mon,  9 Sep 2019 12:39:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729372AbfIIKjt (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 9 Sep 2019 06:39:49 -0400
Received: from mail-eopbgr130047.outbound.protection.outlook.com ([40.107.13.47]:6894
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726407AbfIIKjt (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 9 Sep 2019 06:39:49 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Kf+Kf9qYZQ+QmzBS0B99/JE3v6l0Ksp9uo5wldZWAqne0MVJ+4F6RoshRJAoKBZsip6Qnm2dEeUCOR0TDzEtasiG+hKR0lrMHtWqdHrmnqyLNtFcuRmNN6XwvLzhGuOJsIruUeW0Kt28snVzvjZa0oA0oVxRh0fnh5d184tt3ivk/nK0YIIoUP8dQjuWQrkm4bJ+cOEkWQ0bGmYcSBBNwOSi7CGAMN3U4ag/yQKv51xWABpMCNmJPfhCtFptjofKnKbx2j9BhgSIkNd1etXm6F1GzTXi1Gben582d5+AblHjazuAqlZArBKIi87kdPoIsQ7s68NnJMaGfMA3EqA/DQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fBQo9TVOjB76G1NUXy8jY1dMvtJdUNCNwZXQ+zEi8fo=;
 b=ZFoBODN5E2Olf+xRzjTt6sKwbvciK6oRJOC/Eg7H8c6XUEbnd8pzrUQe2MrxRrHMhw6vH8uQ/L8yixo4qPC8LGJzkr/IRYD16EFAEd81XbGYoGxKYLI3aa3EXalIAr8gFLVpAHfevhfahNBlVNcypcgasZCKbJlrDc5DxfmezPfRCXUUpqZ2T7ZCAShoxVCps/i8rqPh50ZcSBozxBRW5mp0G9vv3fBq6Wj1GcrD480gGWYbB6w8EQe66wjiCFJAZyaRY0+h9bOpyRW1liJOpGg4r2djwEm4XrH1GvoXnwWmQJ6BnhU280VQA3+rVWtJN93yoYdwTgnwxna0U2gTfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mellanox.com; dmarc=pass action=none header.from=mellanox.com;
 dkim=pass header.d=mellanox.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fBQo9TVOjB76G1NUXy8jY1dMvtJdUNCNwZXQ+zEi8fo=;
 b=ElEZWvQseehqgc/VZ2v0U+Lk8AtB2ezdpnhJzW0IfVANPM5NtfzMP8xf4amF9rqMfkls/u8RsCTMU8MeBhnfwuUFGHoGh2AqhcLHjusiBb+nnH74MkWsG6zevyD7bFyMVLP80bJvu36rgBb673VwLRQk9DVJW64gNgnyOLzgi/4=
Received: from AM6PR05MB4968.eurprd05.prod.outlook.com (20.177.33.17) by
 AM6PR05MB6565.eurprd05.prod.outlook.com (20.179.4.206) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2199.21; Mon, 9 Sep 2019 10:39:44 +0000
Received: from AM6PR05MB4968.eurprd05.prod.outlook.com
 ([fe80::f536:b35c:7fe4:4908]) by AM6PR05MB4968.eurprd05.prod.outlook.com
 ([fe80::f536:b35c:7fe4:4908%5]) with mapi id 15.20.2241.018; Mon, 9 Sep 2019
 10:39:44 +0000
From:   Noa Osherovich <noaos@mellanox.com>
To:     Leon Romanovsky <leonro@mellanox.com>
CC:     Jason Gunthorpe <jgg@mellanox.com>,
        "dledford@redhat.com" <dledford@redhat.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH rdma-core 03/14] build: Add pyverbs-based test to the
 build
Thread-Topic: [PATCH rdma-core 03/14] build: Add pyverbs-based test to the
 build
Thread-Index: AQHVVluKi/1wMEsI4UWSJliEROGNkacCfWOAgAGEcwCAA1vkAIAACaEAgA9+4wCADGATgIAAAr2A
Date:   Mon, 9 Sep 2019 10:39:44 +0000
Message-ID: <4caab234-7f8f-781c-68c6-672f961d9fd9@mellanox.com>
References: <20190819065827.26921-1-noaos@mellanox.com>
 <20190819065827.26921-4-noaos@mellanox.com>
 <20190819135019.GF5080@mellanox.com>
 <2ac30209-2c89-15ef-3907-98d3cd552f4d@mellanox.com>
 <20190822161813.GI29433@mtr-leonro.mtl.com>
 <20190822165247.GB8325@mellanox.com>
 <88435e1e-676b-f948-1c34-22cd471af4c9@mellanox.com>
 <20190909102949.GF6601@unreal>
In-Reply-To: <20190909102949.GF6601@unreal>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: PR0P264CA0178.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:100:1c::22) To AM6PR05MB4968.eurprd05.prod.outlook.com
 (2603:10a6:20b:4::17)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=noaos@mellanox.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [193.47.165.251]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 24ec6db7-2049-41c6-ed04-08d7351206f9
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:AM6PR05MB6565;
x-ms-traffictypediagnostic: AM6PR05MB6565:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM6PR05MB6565A4EC2539A99A7AEB6763D9B70@AM6PR05MB6565.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 01559F388D
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(136003)(366004)(39860400002)(396003)(376002)(346002)(189003)(199004)(66476007)(71190400001)(66446008)(486006)(6486002)(446003)(71200400001)(31686004)(305945005)(11346002)(478600001)(6862004)(76176011)(2906002)(14454004)(26005)(386003)(6506007)(53546011)(186003)(102836004)(14444005)(316002)(99286004)(37006003)(31696002)(36756003)(52116002)(66556008)(64756008)(6246003)(54906003)(5660300002)(6512007)(2616005)(66066001)(256004)(476003)(7736002)(8936002)(81166006)(81156014)(229853002)(25786009)(4326008)(86362001)(53936002)(6636002)(6436002)(66946007)(6116002)(3846002)(8676002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR05MB6565;H:AM6PR05MB4968.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: bSbvwrvdkPjHgdfEE0YSkFC/QrKifFDJRhVuCNfPLHhz9+rY7AO0zg7nMQvQYmfMjcYuZbcvSZWfB6uuX77SKZwHnSu5gwaC6GWob1dpczCcK/RF1+U8iTrljWEujFvK0v3EA8Sg+B4z66gPbnXFM7J1/1nzmxSMpCrD/jd5XqQf29WI2Qf4PW1UtVz9QG+0eW4PQULPiQqY9T+1U4xhVVSfv6hVh5rGGQwHWbORqM/fVjfo5iNiYgggM/e5LtlbEhEgTwxP9juiHKV5CuYayz3y0alofsMZHMQ4Kon3jzn/HJnoiawkYWV3E0mBXduz66gUCIFBRdBdCLLrIU8F7qkzvzu1hoWmjsLKL7SmNzxacT11EaRFDZRut7JAYJ8Ieg/YP+JkBXrCwaXRxxGwv1boL3RrtXxeIJ9Jg6gwyNo=
Content-Type: text/plain; charset="utf-8"
Content-ID: <7B0B7155AC29CA4A831EE10BC12FF7C1@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 24ec6db7-2049-41c6-ed04-08d7351206f9
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Sep 2019 10:39:44.1209
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cy2aXyBf8rt5d75fbJf0xA81HwMyo26uZozGjBcHEuwndWvSWYsVtZ98FSTOd4t3sofeiiqBuFfJrpq11haUwg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR05MB6565
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

DQpPbiA5LzkvMjAxOSAxOjI5IFBNLCBMZW9uIFJvbWFub3Zza3kgd3JvdGU6DQo+IE9uIFN1biwg
U2VwIDAxLCAyMDE5IGF0IDAxOjMwOjU2UE0gKzAwMDAsIE5vYSBPc2hlcm92aWNoIHdyb3RlOg0K
Pj4gT24gOC8yMi8yMDE5IDc6NTIgUE0sIEphc29uIEd1bnRob3JwZSB3cm90ZToNCj4+DQo+Pj4g
T24gVGh1LCBBdWcgMjIsIDIwMTkgYXQgMDE6MTg6MjRQTSAtMDMwMCwgTGVvbiBSb21hbm92c2t5
IHdyb3RlOg0KPj4+PiBPbiBUdWUsIEF1ZyAyMCwgMjAxOSBhdCAwMTowMDo0N1BNICswMDAwLCBO
b2EgT3NoZXJvdmljaCB3cm90ZToNCj4+Pj4+IE9uIDgvMTkvMjAxOSA0OjUwIFBNLCBKYXNvbiBH
dW50aG9ycGUgd3JvdGU6DQo+Pj4+Pg0KPj4+Pj4+IEknZCBwcmVmZXIgcnVuX3Rlc3RzIHRvIGJl
IGluIHRoZSB0ZXN0cyBkaXJlY3RvcnkuLg0KPj4+Pj4+DQo+Pj4+Pj4gSmFzb24NCj4+Pj4+IFBS
IHdhcyB1cGRhdGVkDQo+Pj4+IDEuDQo+Pj4+IElNSE8sIHJ1bl90ZXN0cy5weSBzaG91bGQgYmUg
cGxhY2VkIGluc2lkZSB0ZXN0cyBkaXJlY3RvcnkgdG9vIGFuZCBub3QNCj4+Pj4gb25seSBpbnN0
YWxsZWQgaW50byB0ZXN0cy8uDQo+Pj4gWWVzLCB0aGlzIGlzIHdoYXQgSSBtZW50LiBUaGUgZmls
ZSBzaG91bGQgYmUgaW4gdGVzdHMvIGFuZCBpdCBzaG91bGQNCj4+PiBiZSBidWlsdCBpbnRvIGJ1
aWxkL2JpbiwgYW5kIGluc3RhbGxlZCBpbnRvIHRoZSBleGFtcGxlcw0KPj4+PiAyLg0KPj4+PiBF
eGVjdXRpb24gb2YgcnVuX3Rlc3RzLnB5IHByb2R1Y2VzIGEgbG90IG9mIHVudHJhY2tlZCBmaWxl
ZA0KPj4+PiDinpwgIHJkbWEtY29yZSBnaXQ6KG5vYW9zLXByLXRlc3RzKSDinJcgZ2l0IHN0DQo+
Pj4+IE9uIGJyYW5jaCBub2Fvcy1wci10ZXN0cw0KPj4+PiBVbnRyYWNrZWQgZmlsZXM6DQo+Pj4+
ICAgKHVzZSAiZ2l0IGFkZCA8ZmlsZT4uLi4iIHRvIGluY2x1ZGUgaW4gd2hhdCB3aWxsIGJlIGNv
bW1pdHRlZCkNCj4+Pj4NCj4+Pj4gCXB5dmVyYnMvX19pbml0X18ucHljDQo+Pj4+IAlweXZlcmJz
L3B5dmVyYnNfZXJyb3IucHljDQo+Pj4+IAl0ZXN0cy9fX2luaXRfXy5weWMNCj4+Pj4gCXRlc3Rz
L2Jhc2UucHljDQo+Pj4+IAl0ZXN0cy90ZXN0X2FkZHIucHljDQo+Pj4+IAl0ZXN0cy90ZXN0X2Nx
LnB5Yw0KPj4+PiAJdGVzdHMvdGVzdF9kZXZpY2UucHljDQo+Pj4+IAl0ZXN0cy90ZXN0X21yLnB5
Yw0KPj4+PiAJdGVzdHMvdGVzdF9vZHAucHljDQo+Pj4+IAl0ZXN0cy90ZXN0X3BkLnB5Yw0KPj4+
PiAJdGVzdHMvdGVzdF9xcC5weWMNCj4+PiAqLnB5YyB3aWxsIGhhdmUgdG8gYmUgYWRkZWQgdG8g
dGhlIC5naXRpZ25vcmUNCj4+Pj4gMy4gcnVuX3Rlc3RzLnB5IGxhY2tzIG9mIHB5dGhvbjMgc2hl
YmFuZw0KPj4+IE9yaWdpbmFsbHkgaXQgd2FzIG5vdCBpbnN0YWxsZWQsIHNvIHRoaXMgd2FzIGZp
bmUsIGFzIHRoZSBidWlsZC9iaW4NCj4+PiBzY3JpcHQgZG9lcyBhbGwgdGhlIHJlcXVpcmVkIHNl
dHVwLCBob3dldmVyIG5vdyB0aGF0IGl0IGlzIHRvIGJlDQo+Pj4gaW5zdGFsbGVkIGl0IHNob3Vs
ZCBoYXZlIHRoZSAjISAtIGFuZCBpdCBzaG91bGQgYWxzbyB3b3JrIHdpdGhvdXQgYW55DQo+Pj4g
dHJvdWJsZSBmcm9tIGl0J3MgZXhhbXBsZSBsb2NhdGlvbi4NCj4+Pg0KPj4+IEphc29uDQo+PiBQ
UiB3YXMgdXBkYXRlZC4NCj4gSSB0cmllZCBpdCBub3cgYW5kIGdvdCB2ZXJ5IGNvbmZ1c2luZyBy
ZXN1bHRzLg0KPg0KPiBPbiBteSBtYWNoaW5lIHRoZXJlIGFyZSBubyBpYl9kZXZpY2VzLCBhbmQg
SSBleHBlY3RlZCB0byBzZWUgQUxMIHRlc3RzDQo+IG1hcmtlZCBhcyBza2lwcGVkLCBidXQgZ290
IHR3byBza2lwcGVkIG9ubHksIGlzIGl0IGV4cGVjdGVkIGJlaGF2aW91cj8NCg0KWWVzLiBJZiB5
b3UgcmVjYWxsLCBvdXIgcHJldmlvdXMgdW5pdHRlc3RzIHdvcmtlZCBkaWZmZXJlbnRseSB0aGFu
IHRoZSBuZXcgb25lczsgZWFjaA0KdGVzdCB3b3VsZCBpdGVyYXRlIG92ZXIgYW4gYXJyYXkgb2Yg
YWxsIGF2YWlsYWJsZSBkZXZpY2VzIGFuZCB3b3VsZCBydW4gb24gZWFjaCBkZXZpY2UuDQpUaGUg
YXJyYXkgY2FuIGJlIG9mIGxlbmd0aCAwLiBJZiBubyBmYWlsdXJlIHdhcyBmb3VuZCwgdGhleSdy
ZSBtYXJrZWQgYXMgcGFzc2VkLg0KVGhlIG5ldyB0ZXN0cyBza2lwICh0aGUgcmVwb3J0ZWQgJ3Mn
IHlvdSBzYXcpIGluIGNhc2UgYSBjb21iaW5hdGlvbiBvZiBkZXZpY2UvcG9ydC9HSUQNCmluZGV4
IHdhc24ndCBmb3VuZC4NCg0KVGhhbmtzLA0KTm9hDQoNCj4NCj4gXyAgcmRtYS1jb3JlIGdpdDoo
bm9hb3MtcHItdGVzdHMpIC4vYnVpbGQvYmluL3J1bl90ZXN0cy5weQ0KPiAuLi4uLi4uLi4uLi4u
Li4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi5zcy4uLi4uLi4uLi4uLi4uLg0KPiAtLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tDQo+IFJhbiA1OSB0ZXN0cyBpbiAwLjAwNHMNCj4NCj4gT0sgKHNraXBwZWQ9MikNCj4N
Cj4gVGhhbmtzDQo+DQo+PiBUaGFua3MsDQo+Pg0KPj4gTm9hDQo+Pg0K
