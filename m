Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5CEEEEF239
	for <lists+linux-rdma@lfdr.de>; Tue,  5 Nov 2019 01:48:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729737AbfKEAsX (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 4 Nov 2019 19:48:23 -0500
Received: from mail-eopbgr40078.outbound.protection.outlook.com ([40.107.4.78]:8256
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729443AbfKEAsX (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 4 Nov 2019 19:48:23 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VveCAZu5BC1d5AT8gqQIV40/6DcXzhv6ootwyh/dvFsIPnrS7RhbojwEna0ErXYo6OJU1JVPWH8EVOESGo8rqx4/I9w4/52S8tdkh8IMoVMBuvnjtQ0iXjnYUp8dHtWSWIsQU6oJBIy64MoU7y/ndlBHal7i0Q2d6VMRm8PsSX60qwU7ARCKNGrsW2K080awXID0kHnb8RSLf+9T3x1uPsVB3uTXpMrMbffAby3zVJ2z0nDSQA0SQRtWxUcCXRQAECWPqzyV0lCH6sjxW1CqFFuOTIsVgrDr8nRvcVSGsBMMWcNqmHpFb8HhvU8kqZ4LJl9jj70J4boGdDZa4Ulo/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E3AcGgE295wPfkQ8WQ/NJGalyuIcE86QnkJKbzGU3m4=;
 b=PNnA70YRuXGVk+Kvu+3PcpHeEtmpNKNFtdUpQU7SSQHAgJ7EHAb4kN2ds6RWxrtkgGkEHTRNxk59OF4/Ge0of2+j0Ewm+j72DX+VgcyqRihULG4XtL/IHVz3kVO9XTtELP3QZUkzBc8mLM+Jo0m5dVZ1unSmktazgejMUo/ScyEs9VSEfkc2+j9prKnmmW5QCj//TFxfOUAperUS+1xYrjY3sI7RO0nhHkRjYnYrv+IBrBIvBQ8rFTdKCxx7VYclFlduSjHcJtMxoxJ9l51TgQ6ik334S0bxAC3sMD7mZEqpeqq8JMSoMpTJO/jzDiTkCsXNyam8uAIgSigdoW5jCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mellanox.com; dmarc=pass action=none header.from=mellanox.com;
 dkim=pass header.d=mellanox.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E3AcGgE295wPfkQ8WQ/NJGalyuIcE86QnkJKbzGU3m4=;
 b=Z85kf0VAZ/Ets6AXeHdsw4FjDHpfXCalGKrjZyvicfSOpLgIYJLTWpMmsNhb6xzwTvl7NNUp3ph7sDH0BB/pNiK6AQuK1M/+i62nF9UdlUlecH+SYtKCjvL4jfK64RwiAk3WxV+JR5e6RtRE+nUXKXlZg2WIyGyqEmWO5jFo7OY=
Received: from VI1PR05MB3342.eurprd05.prod.outlook.com (10.170.238.143) by
 VI1PR05MB6128.eurprd05.prod.outlook.com (20.178.205.26) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2408.24; Tue, 5 Nov 2019 00:48:16 +0000
Received: from VI1PR05MB3342.eurprd05.prod.outlook.com
 ([fe80::60cb:2e60:375e:8670]) by VI1PR05MB3342.eurprd05.prod.outlook.com
 ([fe80::60cb:2e60:375e:8670%4]) with mapi id 15.20.2408.024; Tue, 5 Nov 2019
 00:48:16 +0000
From:   Mark Bloch <markb@mellanox.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Leon Romanovsky <leon@kernel.org>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>
CC:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] IB: mlx5: no need to check return value of debugfs_create
 functions
Thread-Topic: [PATCH] IB: mlx5: no need to check return value of
 debugfs_create functions
Thread-Index: AQHVkuNSu/GyPpr3oU65xoNBaZChdqd7v5gA
Date:   Tue, 5 Nov 2019 00:48:16 +0000
Message-ID: <50a30aa3-3924-4fd1-f644-2fd2b184ec0e@mellanox.com>
References: <20191104074141.GA1292396@kroah.com>
In-Reply-To: <20191104074141.GA1292396@kroah.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MWHPR1701CA0021.namprd17.prod.outlook.com
 (2603:10b6:301:14::31) To VI1PR05MB3342.eurprd05.prod.outlook.com
 (2603:10a6:802:1d::15)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=markb@mellanox.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [208.186.24.68]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 145d671f-728a-4787-8ded-08d76189d815
x-ms-traffictypediagnostic: VI1PR05MB6128:
x-microsoft-antispam-prvs: <VI1PR05MB6128611A67018DE1830BE431D27E0@VI1PR05MB6128.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 0212BDE3BE
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(396003)(376002)(39860400002)(346002)(136003)(366004)(189003)(199004)(26005)(66946007)(110136005)(76176011)(305945005)(86362001)(486006)(6246003)(14454004)(186003)(478600001)(446003)(11346002)(476003)(2616005)(6436002)(256004)(52116002)(8936002)(81156014)(229853002)(81166006)(66066001)(8676002)(4326008)(316002)(64756008)(66476007)(66556008)(66446008)(5660300002)(99286004)(2906002)(7736002)(3846002)(6506007)(6116002)(53546011)(386003)(36756003)(31686004)(55236004)(102836004)(31696002)(54906003)(71190400001)(71200400001)(6512007)(25786009)(6486002);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR05MB6128;H:VI1PR05MB3342.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 8qfYYxzIqLyrnSjjJlny11uN3YkeM19NoXB0KvKJ9jIsdT1+S0alM79pNFf2KadCUgXxqrghJBE2CxdlKFr2HNNrNdJ/vYjS8z9yWoHiCav5xmsDaX8u2FcegPwWlOVKnrXYYL/b1Xt0LP9Vtk7IBIfPFM3+5DCVtB1F5806fH8EGnlITSIOKkdP8Gbk7MaFIdqgad8Wftd7TgjO9tj8NAZ2NFxGSV2XYw8zi/mb9rehCsnk++okauM9+hUEF8maZ0iGxA+vn48JB5zVBlwaD0fWNZzsLlLucSkRGKKICYmvivKg5cTfivW0XTIoZOE2QksA+wNLQ7fU10QQ2iCsAxxBYppuMJgAUtdat4FSePGMZfKHFFTKssNZuY3zwfNakMhexyKh7sD/v/Bh/NCUdwi4ZMmSlVvBfgWSndNWoXkv2D/jpGVfvIXzHiI6ZWai
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <FF3301372338564B90D5F451B1219EFF@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 145d671f-728a-4787-8ded-08d76189d815
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Nov 2019 00:48:16.2827
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /Kz7+uZUcGWkrBv7htsM/Xp5HyWXmmQN36Amc7nR1yJi6Trvbm6nPE+4wcuTZUOO/t8BRWEZfa+OFUy9+H6xvA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR05MB6128
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

DQoNCk9uIDExLzMvMTkgMTE6NDEgUE0sIEdyZWcgS3JvYWgtSGFydG1hbiB3cm90ZToNCj4gV2hl
biBjYWxsaW5nIGRlYnVnZnMgZnVuY3Rpb25zLCB0aGVyZSBpcyBubyBuZWVkIHRvIGV2ZXIgY2hl
Y2sgdGhlDQo+IHJldHVybiB2YWx1ZS4gIFRoZSBmdW5jdGlvbiBjYW4gd29yayBvciBub3QsIGJ1
dCB0aGUgY29kZSBsb2dpYyBzaG91bGQNCj4gbmV2ZXIgZG8gc29tZXRoaW5nIGRpZmZlcmVudCBi
YXNlZCBvbiB0aGlzLg0KPiANCj4gQ2M6IExlb24gUm9tYW5vdnNreSA8bGVvbkBrZXJuZWwub3Jn
Pg0KPiBDYzogRG91ZyBMZWRmb3JkIDxkbGVkZm9yZEByZWRoYXQuY29tPg0KPiBDYzogSmFzb24g
R3VudGhvcnBlIDxqZ2dAemllcGUuY2E+DQo+IFNpZ25lZC1vZmYtYnk6IEdyZWcgS3JvYWgtSGFy
dG1hbiA8Z3JlZ2toQGxpbnV4Zm91bmRhdGlvbi5vcmc+DQo+IC0tLQ0KPiAgZHJpdmVycy9pbmZp
bmliYW5kL2h3L21seDUvbWFpbi5jICAgIHwgNjIgKysrKysrKy0tLS0tLS0tLS0tLS0tLS0tLS0t
LQ0KPiAgZHJpdmVycy9pbmZpbmliYW5kL2h3L21seDUvbWx4NV9pYi5oIHwgIDkgKy0tLQ0KPiAg
MiBmaWxlcyBjaGFuZ2VkLCAxNiBpbnNlcnRpb25zKCspLCA1NSBkZWxldGlvbnMoLSkNCj4gDQo+
IE5vdGUsIEkga2luZCBvZiBuZWVkIHRvIHRha2UgdGhpcyB0aHJvdWdoIG15IHRyZWUgbm93IGFz
IEkgYnJva2UgdGhlDQo+IGJ1aWxkIGR1ZSB0byBtZSBjaGFuZ2luZyB0aGUgdXNlIG9mIGRlYnVn
ZnNfY3JlYXRlX2F0b21pY190KCkgaW4gbXkNCj4gdHJlZSBhbmQgbm90IG5vdGljaW5nIHRoaXMg
YmVpbmcgdXNlZCBoZXJlLiAgU29ycnkgYWJvdXQgdGhhdCwgYW55DQo+IG9iamVjdGlvbnM/DQo+
IA0KPiBBbmQgMC1kYXkgc2VlbXMgcmVhbGx5IGJyb2tlbiB0byBoYXZlIG1pc3NlZCB0aGlzIGZv
ciB0aGUgcGFzdCBtb250aHMsDQo+IHVnaCwgSSBuZWVkIHRvIHN0b3AgcmVseWluZyBvbiBpdC4u
Lg0KPiANCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2luZmluaWJhbmQvaHcvbWx4NS9tYWlu
LmMgYi9kcml2ZXJzL2luZmluaWJhbmQvaHcvbWx4NS9tYWluLmMNCj4gaW5kZXggODMxNTM5NDE5
YzMwLi4wNTlkYjA2MTA0NDUgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvaW5maW5pYmFuZC9ody9t
bHg1L21haW4uYw0KPiArKysgYi9kcml2ZXJzL2luZmluaWJhbmQvaHcvbWx4NS9tYWluLmMNCj4g
QEAgLTU3MTAsMTEgKzU3MTAsMTAgQEAgc3RhdGljIGludCBtbHg1X2liX3JuX2dldF9wYXJhbXMo
c3RydWN0IGliX2RldmljZSAqZGV2aWNlLCB1OCBwb3J0X251bSwNCj4gIA0KPiAgc3RhdGljIHZv
aWQgZGVsYXlfZHJvcF9kZWJ1Z2ZzX2NsZWFudXAoc3RydWN0IG1seDVfaWJfZGV2ICpkZXYpDQo+
ICB7DQo+IC0JaWYgKCFkZXYtPmRlbGF5X2Ryb3AuZGJnKQ0KPiArCWlmICghZGV2LT5kZWxheV9k
cm9wLmRpcl9kZWJ1Z2ZzKQ0KDQpTaG91bGRuJ3QgdGhpcyBiZToNCmlmIChJU19FUlIoZGV2LT5k
ZWxheV9kcm9wLmRpcl9kZWJ1Z2ZzKSkNCglyZXR1cm47DQo/DQo+ICAJCXJldHVybjsNCj4gLQlk
ZWJ1Z2ZzX3JlbW92ZV9yZWN1cnNpdmUoZGV2LT5kZWxheV9kcm9wLmRiZy0+ZGlyX2RlYnVnZnMp
Ow0KPiAtCWtmcmVlKGRldi0+ZGVsYXlfZHJvcC5kYmcpOw0KPiAtCWRldi0+ZGVsYXlfZHJvcC5k
YmcgPSBOVUxMOw0KPiArCWRlYnVnZnNfcmVtb3ZlX3JlY3Vyc2l2ZShkZXYtPmRlbGF5X2Ryb3Au
ZGlyX2RlYnVnZnMpOw0KPiArCWRldi0+ZGVsYXlfZHJvcC5kaXJfZGVidWdmcyA9IE5VTEw7DQoN
ClRoaW5raW5nIGFib3V0IHRoaXMgbW9yZSwgd2UgYWxyZWFkeSBkbyBzb21ldGhpbmcgbGlrZSB0
aGlzOg0KaWYgKElTX0VSUl9PUl9OVUxMKGRlbnRyeSkpDQoJCXJldHVybjsNCmluc2lkZSBkZWJ1
Z2ZzX3JlbW92ZV9yZWN1cnNpdmUoKSwgc28gdGhpcyBlbnRpcmUgZnVuY3Rpb24gY2FuIGJlIHJl
ZHVjZWQNCnRvIGp1c3QgY2FsbGluZyBkZWJ1Z2ZzX3JlbW92ZV9yZWN1cnNpdmUoKS4NCg0KTWFy
aw0KDQo+ICB9DQo+ICANCj4gIHN0YXRpYyB2b2lkIGNhbmNlbF9kZWxheV9kcm9wKHN0cnVjdCBt
bHg1X2liX2RldiAqZGV2KQ0KPiBAQCAtNTc2NSw1MiArNTc2NCwyMiBAQCBzdGF0aWMgY29uc3Qg
c3RydWN0IGZpbGVfb3BlcmF0aW9ucyBmb3BzX2RlbGF5X2Ryb3BfdGltZW91dCA9IHsNCj4gIAku
cmVhZAk9IGRlbGF5X2Ryb3BfdGltZW91dF9yZWFkLA0KPiAgfTsNCj4gIA0KPiAtc3RhdGljIGlu
dCBkZWxheV9kcm9wX2RlYnVnZnNfaW5pdChzdHJ1Y3QgbWx4NV9pYl9kZXYgKmRldikNCj4gK3N0
YXRpYyB2b2lkIGRlbGF5X2Ryb3BfZGVidWdmc19pbml0KHN0cnVjdCBtbHg1X2liX2RldiAqZGV2
KQ0KPiAgew0KPiAtCXN0cnVjdCBtbHg1X2liX2RiZ19kZWxheV9kcm9wICpkYmc7DQo+ICsJc3Ry
dWN0IGRlbnRyeSAqcm9vdDsNCj4gIA0KPiAgCWlmICghbWx4NV9kZWJ1Z2ZzX3Jvb3QpDQo+IC0J
CXJldHVybiAwOw0KPiAtDQo+IC0JZGJnID0ga3phbGxvYyhzaXplb2YoKmRiZyksIEdGUF9LRVJO
RUwpOw0KPiAtCWlmICghZGJnKQ0KPiAtCQlyZXR1cm4gLUVOT01FTTsNCj4gLQ0KPiAtCWRldi0+
ZGVsYXlfZHJvcC5kYmcgPSBkYmc7DQo+IC0NCj4gLQlkYmctPmRpcl9kZWJ1Z2ZzID0NCj4gLQkJ
ZGVidWdmc19jcmVhdGVfZGlyKCJkZWxheV9kcm9wIiwNCj4gLQkJCQkgICBkZXYtPm1kZXYtPnBy
aXYuZGJnX3Jvb3QpOw0KPiAtCWlmICghZGJnLT5kaXJfZGVidWdmcykNCj4gLQkJZ290byBvdXRf
ZGVidWdmczsNCj4gLQ0KPiAtCWRiZy0+ZXZlbnRzX2NudF9kZWJ1Z2ZzID0NCj4gLQkJZGVidWdm
c19jcmVhdGVfYXRvbWljX3QoIm51bV90aW1lb3V0X2V2ZW50cyIsIDA0MDAsDQo+IC0JCQkJCWRi
Zy0+ZGlyX2RlYnVnZnMsDQo+IC0JCQkJCSZkZXYtPmRlbGF5X2Ryb3AuZXZlbnRzX2NudCk7DQo+
IC0JaWYgKCFkYmctPmV2ZW50c19jbnRfZGVidWdmcykNCj4gLQkJZ290byBvdXRfZGVidWdmczsN
Cj4gLQ0KPiAtCWRiZy0+cnFzX2NudF9kZWJ1Z2ZzID0NCj4gLQkJZGVidWdmc19jcmVhdGVfYXRv
bWljX3QoIm51bV9ycXMiLCAwNDAwLA0KPiAtCQkJCQlkYmctPmRpcl9kZWJ1Z2ZzLA0KPiAtCQkJ
CQkmZGV2LT5kZWxheV9kcm9wLnJxc19jbnQpOw0KPiAtCWlmICghZGJnLT5ycXNfY250X2RlYnVn
ZnMpDQo+IC0JCWdvdG8gb3V0X2RlYnVnZnM7DQo+IC0NCj4gLQlkYmctPnRpbWVvdXRfZGVidWdm
cyA9DQo+IC0JCWRlYnVnZnNfY3JlYXRlX2ZpbGUoInRpbWVvdXQiLCAwNjAwLA0KPiAtCQkJCSAg
ICBkYmctPmRpcl9kZWJ1Z2ZzLA0KPiAtCQkJCSAgICAmZGV2LT5kZWxheV9kcm9wLA0KPiAtCQkJ
CSAgICAmZm9wc19kZWxheV9kcm9wX3RpbWVvdXQpOw0KPiAtCWlmICghZGJnLT50aW1lb3V0X2Rl
YnVnZnMpDQo+IC0JCWdvdG8gb3V0X2RlYnVnZnM7DQo+ICsJCXJldHVybjsNCj4gIA0KPiAtCXJl
dHVybiAwOw0KPiArCXJvb3QgPSBkZWJ1Z2ZzX2NyZWF0ZV9kaXIoImRlbGF5X2Ryb3AiLCBkZXYt
Pm1kZXYtPnByaXYuZGJnX3Jvb3QpOw0KPiArCWRldi0+ZGVsYXlfZHJvcC5kaXJfZGVidWdmcyA9
IHJvb3Q7DQo+ICANCj4gLW91dF9kZWJ1Z2ZzOg0KPiAtCWRlbGF5X2Ryb3BfZGVidWdmc19jbGVh
bnVwKGRldik7DQo+IC0JcmV0dXJuIC1FTk9NRU07DQo+ICsJZGVidWdmc19jcmVhdGVfYXRvbWlj
X3QoIm51bV90aW1lb3V0X2V2ZW50cyIsIDA0MDAsIHJvb3QsDQo+ICsJCQkJJmRldi0+ZGVsYXlf
ZHJvcC5ldmVudHNfY250KTsNCj4gKwlkZWJ1Z2ZzX2NyZWF0ZV9hdG9taWNfdCgibnVtX3JxcyIs
IDA0MDAsIHJvb3QsDQo+ICsJCQkJJmRldi0+ZGVsYXlfZHJvcC5ycXNfY250KTsNCj4gKwlkZWJ1
Z2ZzX2NyZWF0ZV9maWxlKCJ0aW1lb3V0IiwgMDYwMCwgcm9vdCwgJmRldi0+ZGVsYXlfZHJvcCwN
Cj4gKwkJCSAgICAmZm9wc19kZWxheV9kcm9wX3RpbWVvdXQpOw0KPiAgfQ0KPiAgDQo+ICBzdGF0
aWMgdm9pZCBpbml0X2RlbGF5X2Ryb3Aoc3RydWN0IG1seDVfaWJfZGV2ICpkZXYpDQo+IEBAIC01
ODI2LDggKzU3OTUsNyBAQCBzdGF0aWMgdm9pZCBpbml0X2RlbGF5X2Ryb3Aoc3RydWN0IG1seDVf
aWJfZGV2ICpkZXYpDQo+ICAJYXRvbWljX3NldCgmZGV2LT5kZWxheV9kcm9wLnJxc19jbnQsIDAp
Ow0KPiAgCWF0b21pY19zZXQoJmRldi0+ZGVsYXlfZHJvcC5ldmVudHNfY250LCAwKTsNCj4gIA0K
PiAtCWlmIChkZWxheV9kcm9wX2RlYnVnZnNfaW5pdChkZXYpKQ0KPiAtCQltbHg1X2liX3dhcm4o
ZGV2LCAiRmFpbGVkIHRvIGluaXQgZGVsYXkgZHJvcCBkZWJ1Z2ZzXG4iKTsNCj4gKwlkZWxheV9k
cm9wX2RlYnVnZnNfaW5pdChkZXYpOw0KPiAgfQ0KPiAgDQo+ICBzdGF0aWMgdm9pZCBtbHg1X2li
X3VuYmluZF9zbGF2ZV9wb3J0KHN0cnVjdCBtbHg1X2liX2RldiAqaWJkZXYsDQo+IGRpZmYgLS1n
aXQgYS9kcml2ZXJzL2luZmluaWJhbmQvaHcvbWx4NS9tbHg1X2liLmggYi9kcml2ZXJzL2luZmlu
aWJhbmQvaHcvbWx4NS9tbHg1X2liLmgNCj4gaW5kZXggMWE5OGVlMmUwMWM0Li41NWNlNTk5ZGI4
MDMgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvaW5maW5pYmFuZC9ody9tbHg1L21seDVfaWIuaA0K
PiArKysgYi9kcml2ZXJzL2luZmluaWJhbmQvaHcvbWx4NS9tbHg1X2liLmgNCj4gQEAgLTc5Miwx
MyArNzkyLDYgQEAgZW51bSB7DQo+ICAJTUxYNV9NQVhfREVMQVlfRFJPUF9USU1FT1VUX01TID0g
MTAwLA0KPiAgfTsNCj4gIA0KPiAtc3RydWN0IG1seDVfaWJfZGJnX2RlbGF5X2Ryb3Agew0KPiAt
CXN0cnVjdCBkZW50cnkJCSpkaXJfZGVidWdmczsNCj4gLQlzdHJ1Y3QgZGVudHJ5CQkqcnFzX2Nu
dF9kZWJ1Z2ZzOw0KPiAtCXN0cnVjdCBkZW50cnkJCSpldmVudHNfY250X2RlYnVnZnM7DQo+IC0J
c3RydWN0IGRlbnRyeQkJKnRpbWVvdXRfZGVidWdmczsNCj4gLX07DQo+IC0NCj4gIHN0cnVjdCBt
bHg1X2liX2RlbGF5X2Ryb3Agew0KPiAgCXN0cnVjdCBtbHg1X2liX2RldiAgICAgKmRldjsNCj4g
IAlzdHJ1Y3Qgd29ya19zdHJ1Y3QJZGVsYXlfZHJvcF93b3JrOw0KPiBAQCAtODA4LDcgKzgwMSw3
IEBAIHN0cnVjdCBtbHg1X2liX2RlbGF5X2Ryb3Agew0KPiAgCWJvb2wJCQlhY3RpdmF0ZTsNCj4g
IAlhdG9taWNfdAkJZXZlbnRzX2NudDsNCj4gIAlhdG9taWNfdAkJcnFzX2NudDsNCj4gLQlzdHJ1
Y3QgbWx4NV9pYl9kYmdfZGVsYXlfZHJvcCAqZGJnOw0KPiArCXN0cnVjdCBkZW50cnkJCSpkaXJf
ZGVidWdmczsNCj4gIH07DQo+ICANCj4gIGVudW0gbWx4NV9pYl9zdGFnZXMgew0KPiANCg==
