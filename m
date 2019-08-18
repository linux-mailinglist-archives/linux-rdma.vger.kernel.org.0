Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 88A9D91561
	for <lists+linux-rdma@lfdr.de>; Sun, 18 Aug 2019 09:31:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726097AbfHRHbw (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 18 Aug 2019 03:31:52 -0400
Received: from mail-eopbgr30064.outbound.protection.outlook.com ([40.107.3.64]:59513
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726073AbfHRHbw (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Sun, 18 Aug 2019 03:31:52 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kOMjVy5y7NloEpEvVzA/B/nA5nI8VmYSgAVpFduffzt30xtfIguhoRoN7F1CB87NzqMj25pMvcvaCbNz+uV4alOz3XvbprqdfXCtAYgirB/pkb3cVV+3Q/FwyiuxWZqLVF4vEtljiPAVT92xBriPggCNgLzUgzfmN9BczhKKXdLOolZyujcS1mcozFHY5ilkzn8tbSDAXDYv4Fyz7msv+Q4g7QedtAZKqY3oZMJpx4IbnhhdfFuA9lrmDxS7WANGj9mGZ9fzh44CGq4gKECgYeow3h3u1BXCaqeDdu1iKJG3DL05WICMcpiL9iFNp3bfJpqDkZkg6R2ScHyHs1WJdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jE62dvrIaTK5HfnSj5vNtCQXqyY5JRuP2DXzgkxmLck=;
 b=TV8gMqmyI/PNufUtQ8dUbAy22MLSn0467S1WDJAUC0Z2ErdH/JLUHiHX9UVgTp0QD+rsHSbeGGJrOu3ZsbYBmF0plY/Fl1jbBD7VuipBlW/9SBEYc45luaJUmuf+JMmdzJuSpo36WbY18tO1QU8NFbPixqBzvMvocSGbjlcygq44cHHScv63NDfpxC7dHyPo8yaCzwfDPeR36V6hpxk6lHnl6JylHmct6myUkZFDblCdE73pxZjWjYqLoSU6bTdK4LYKtYCilj3jF3uUQBmMcGtymMIkxYvuvpsbR/KQayYSQNKHU6n2PhIEmx81SM1nXp/ESZR9FIQS6XXFTEVtIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mellanox.com; dmarc=pass action=none header.from=mellanox.com;
 dkim=pass header.d=mellanox.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jE62dvrIaTK5HfnSj5vNtCQXqyY5JRuP2DXzgkxmLck=;
 b=CREfuoA0pX0ph9BmFT6K6gZFD0JtbjXEvAbQ+TEt2xT4E4axY1JlVDENnVG3SCb0LoyNUjSZirovLAmniZymtKWfKjIejjw8InlxDaJ4oLD4sl/sG3zXKx3yRUp02pvNZzp5KsnmVZky8d3mGicyTdWQPdhGufE39SJwG+ikvb4=
Received: from AM0PR05MB5347.eurprd05.prod.outlook.com (20.178.20.95) by
 AM0PR05MB4610.eurprd05.prod.outlook.com (52.133.58.28) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2178.16; Sun, 18 Aug 2019 07:31:46 +0000
Received: from AM0PR05MB5347.eurprd05.prod.outlook.com
 ([fe80::98a7:edef:79af:2eb5]) by AM0PR05MB5347.eurprd05.prod.outlook.com
 ([fe80::98a7:edef:79af:2eb5%7]) with mapi id 15.20.2157.022; Sun, 18 Aug 2019
 07:31:46 +0000
From:   Haim Boozaglo <haimbo@mellanox.com>
To:     Ira Weiny <ira.weiny@intel.com>
CC:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Vladimir Koushnir <vladimirk@mellanox.com>
Subject: Re: [PATCH 1/3] libibumad: Support arbitrary number of IB devices
Thread-Topic: [PATCH 1/3] libibumad: Support arbitrary number of IB devices
Thread-Index: AQHVUGH5AYUdrM/REEWk6Pl27mjoIqb5SqMAgAdCkIA=
Date:   Sun, 18 Aug 2019 07:31:45 +0000
Message-ID: <f94e74f1-a4de-0457-6860-f7ee7ac5e1bb@mellanox.com>
References: <1565540962-20188-1-git-send-email-haimbo@mellanox.com>
 <1565540962-20188-2-git-send-email-haimbo@mellanox.com>
 <20190813163939.GA11882@iweiny-DESK2.sc.intel.com>
In-Reply-To: <20190813163939.GA11882@iweiny-DESK2.sc.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MRXP264CA0030.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:500:14::18) To AM0PR05MB5347.eurprd05.prod.outlook.com
 (2603:10a6:208:f8::31)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=haimbo@mellanox.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [193.47.165.251]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8abac68b-a06d-4f8a-392e-08d723ae1f92
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:AM0PR05MB4610;
x-ms-traffictypediagnostic: AM0PR05MB4610:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM0PR05MB4610D485BDBA392A4D4E5B1FA5A90@AM0PR05MB4610.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-forefront-prvs: 01334458E5
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(346002)(136003)(39850400004)(376002)(396003)(366004)(199004)(189003)(107886003)(2906002)(6436002)(6246003)(446003)(6512007)(2616005)(476003)(229853002)(26005)(11346002)(4326008)(31686004)(6486002)(7736002)(305945005)(66946007)(186003)(5660300002)(66556008)(66476007)(64756008)(66446008)(25786009)(71200400001)(99286004)(52116002)(36756003)(31696002)(71190400001)(54906003)(14454004)(6916009)(316002)(256004)(66066001)(81156014)(102836004)(8676002)(53546011)(6506007)(386003)(3846002)(486006)(6116002)(86362001)(76176011)(478600001)(53936002)(81166006)(8936002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR05MB4610;H:AM0PR05MB5347.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: BQY4nvMPHoAOpt1t8FnGKEo7u/eZhiHtVtJ0u8u6jkNuLVdEyXCWLMWR6ABvxFT7Q9bexBJByOf55EbpNIBFXVkXVSVmd9vPx7z5uL4NKZ/TiaBrtcFlPaX4EMEC1eernWfvSRAA1FXgAHneCeKlXgner56JR7xWRbkwtFfT3kE4rAK3SjftDK0aEHJKVQFyQ5ksF4GdJUf+fgFc++bNe5mdp8bta/rFGor1QT33On5TS9sog2lsGsd1kN0RE+ad3yRj92UqCruk/klvSUVmJ98iuoWbJ6W3vGvLeWX9ssqIDVVkdOkl5AlwGp7pZwLebBToJA38xwSCwHWuH8sLpDZrD7D0v3pjMZmN/oAIOXxl5V9qa2IttTCNr0BT8ZJGqkGaG6bV5dRGxSCbZhxcpFu5FxcwtPT/eALdf50E140=
Content-Type: text/plain; charset="utf-8"
Content-ID: <0AFD7834A335F444BD9CAA70223CB4F6@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8abac68b-a06d-4f8a-392e-08d723ae1f92
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Aug 2019 07:31:45.8891
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oEbON3YjxPWi8hVdvtTXyJ/e9zd6w+igWAezua01O9Bb5IA2f6Am4uZpvo0Q9OUN1ap8pICXRLerRBgSlP4N9w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR05MB4610
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

DQoNCk9uIDgvMTMvMjAxOSA3OjM5IFBNLCBJcmEgV2Vpbnkgd3JvdGU6DQo+IE9uIFN1biwgQXVn
IDExLCAyMDE5IGF0IDA0OjI5OjIwUE0gKzAwMDAsIEhhaW0gQm9vemFnbG8gd3JvdGU6DQo+PiBG
cm9tOiBWbGFkaW1pciBLb3VzaG5pciA8dmxhZGltaXJrQG1lbGxhbm94LmNvbT4NCj4+DQo+PiBB
ZGRlZCBuZXcgZnVuY3Rpb24gcmV0dXJuaW5nIGEgbGlzdCBvZiBhdmFpbGFibGUgSW5maW5pQmFu
ZCBkZXZpY2UgbmFtZXMuDQo+PiBUaGUgcmV0dXJuZWQgbGlzdCBpcyBub3QgbGltaXRlZCB0byAz
MiBkZXZpY2VzLg0KPj4NCj4+IFNpZ25lZC1vZmYtYnk6IFZsYWRpbWlyIEtvdXNobmlyIDx2bGFk
aW1pcmtAbWVsbGFub3guY29tPg0KPj4gU2lnbmVkLW9mZi1ieTogSGFpbSBCb296YWdsbyA8aGFp
bWJvQG1lbGxhbm94LmNvbT4NCj4+IC0tLQ0KPiANCj4gW3NuaXBdDQo+IA0KPj4gZGlmZiAtLWdp
dCBhL2xpYmlidW1hZC91bWFkLmMgYi9saWJpYnVtYWQvdW1hZC5jDQo+PiBpbmRleCA1Zjg2NTZl
Li45ZDAzMDNiIDEwMDY0NA0KPj4gLS0tIGEvbGliaWJ1bWFkL3VtYWQuYw0KPj4gKysrIGIvbGli
aWJ1bWFkL3VtYWQuYw0KPj4gQEAgLTExMjMsMyArMTEyMyw0NCBAQCB2b2lkIHVtYWRfZHVtcCh2
b2lkICp1bWFkKQ0KPj4gICAJICAgICAgIG1hZC0+YWdlbnRfaWQsIG1hZC0+c3RhdHVzLCBtYWQt
PnRpbWVvdXRfbXMpOw0KPj4gICAJdW1hZF9hZGRyX2R1bXAoJm1hZC0+YWRkcik7DQo+PiAgIH0N
Cj4+ICsNCj4+ICtpbnQgdW1hZF9nZXRfY2FfbmFtZWxpc3QoY2hhciAqKmNhcykNCj4+ICt7DQo+
PiArCXN0cnVjdCBkaXJlbnQgKipuYW1lbGlzdDsNCj4+ICsJaW50IG4sIGksIGogPSAwOw0KPj4g
Kw0KPj4gKwluID0gc2NhbmRpcihTWVNfSU5GSU5JQkFORCwgJm5hbWVsaXN0LCBOVUxMLCBhbHBo
YXNvcnQpOw0KPj4gKw0KPj4gKwlpZiAobiA+IDApIHsNCj4+ICsJCSpjYXMgPSAoY2hhciAqKSBj
YWxsb2MoMSwgbiAqIHNpemVvZihjaGFyKSAqIFVNQURfQ0FfTkFNRV9MRU4pOw0KPj4gKwkJZm9y
IChpID0gMDsgaSA8IG47IGkrKykgew0KPj4gKwkJCWlmICgqY2FzICYmIHN0cmNtcChuYW1lbGlz
dFtpXS0+ZF9uYW1lLCAiLiIpICYmDQo+PiArCQkJICAgIHN0cmNtcChuYW1lbGlzdFtpXS0+ZF9u
YW1lLCAiLi4iKSkgew0KPj4gKwkJCQlpZiAoaXNfaWJfdHlwZShuYW1lbGlzdFtpXS0+ZF9uYW1l
KSkgew0KPj4gKwkJCQkJc3RybmNweSgqY2FzICsgaiAqIFVNQURfQ0FfTkFNRV9MRU4sDQo+PiAr
CQkJCQkJbmFtZWxpc3RbaV0tPmRfbmFtZSwNCj4+ICsJCQkJCQlVTUFEX0NBX05BTUVfTEVOKTsN
Cj4+ICsJCQkJCWorKzsNCj4+ICsJCQkJfQ0KPiANCj4gVGhpcyBhbGwgc2VlbXMgb3Zlcmx5IGNv
bXBsaWNhdGVkIHRvIGF2b2lkIGFsbG9jYXRpbmcgdGhlIHN0cmluZ3Mgc2VwYXJhdGUgZnJvbQ0K
PiB0aGUgcG9pbnRlciBhcnJheS4gIFdoeSBub3QganVzdCBhbGxvY2F0ZSB0aGUgcG9pbnRlciBh
cnJheSBhbmQgc3RyZHVwKCkgdGhlDQo+IG5hbWVzIGludG8gdGhlIGFycmF5PyAgQW5kIHRoZW4g
bWFrZSB1bmFtZF9mcmVlX2NhX25hbWVsaXN0KCkgZG8gc29tZSB3b3JrPw0KPiANCj4gSXJhDQoN
CkhpIElyYSwNClRoYXRzIHdoYXQgSSBhbSBnb2luZyB0byBkbyBhbmQgZml4ICh0byB1c2Ugc3Ry
ZHVwKSwNCg0KVGhhbmtzLA0KSGFpbS4NCg0KPiANCj4+ICsJCQl9DQo+PiArCQkJZnJlZShuYW1l
bGlzdFtpXSk7DQo+PiArCQl9DQo+PiArCQlERUJVRygicmV0dXJuICVkIGNhcyIsIGopOw0KPj4g
Kwl9IGVsc2Ugew0KPj4gKwkJLyogSXMgdGhpcyBzdGlsbCBuZWVkZWQgPyAqLw0KPj4gKwkJaWYg
KCgqY2FzID0gY2FsbG9jKDEsIFVNQURfQ0FfTkFNRV9MRU4gKiBzaXplb2YoY2hhcikpKSkgew0K
Pj4gKwkJCXN0cm5jcHkoKmNhcywgZGVmX2NhX25hbWUsIFVNQURfQ0FfTkFNRV9MRU4pOw0KPj4g
KwkJCURFQlVHKCJyZXR1cm4gMSBjYSIpOw0KPj4gKwkJCWogPSAxOw0KPj4gKwkJfQ0KPj4gKwl9
DQo+PiArCWlmIChuID49IDApDQo+PiArCQlmcmVlKG5hbWVsaXN0KTsNCj4+ICsNCj4+ICsJcmV0
dXJuIGo7DQo+PiArfQ0KPj4gKw0KPj4gK3ZvaWQgdW1hZF9mcmVlX2NhX25hbWVsaXN0KGNoYXIg
KmNhcykNCj4+ICt7DQo+PiArCWZyZWUoY2FzKTsNCj4+ICt9DQo+PiBkaWZmIC0tZ2l0IGEvbGli
aWJ1bWFkL3VtYWQuaCBiL2xpYmlidW1hZC91bWFkLmgNCj4+IGluZGV4IDNjYzU1MWYuLjcwYmMy
MTMgMTAwNjQ0DQo+PiAtLS0gYS9saWJpYnVtYWQvdW1hZC5oDQo+PiArKysgYi9saWJpYnVtYWQv
dW1hZC5oDQo+PiBAQCAtMjA4LDYgKzIwOCw4IEBAIGludCB1bWFkX3JlZ2lzdGVyKGludCBwb3J0
aWQsIGludCBtZ210X2NsYXNzLCBpbnQgbWdtdF92ZXJzaW9uLA0KPj4gICBpbnQgdW1hZF9yZWdp
c3Rlcl9vdWkoaW50IHBvcnRpZCwgaW50IG1nbXRfY2xhc3MsIHVpbnQ4X3Qgcm1wcF92ZXJzaW9u
LA0KPj4gICAJCSAgICAgIHVpbnQ4X3Qgb3VpWzNdLCBsb25nIG1ldGhvZF9tYXNrWzE2IC8gc2l6
ZW9mKGxvbmcpXSk7DQo+PiAgIGludCB1bWFkX3VucmVnaXN0ZXIoaW50IHBvcnRpZCwgaW50IGFn
ZW50aWQpOw0KPj4gK2ludCB1bWFkX2dldF9jYV9uYW1lbGlzdChjaGFyICoqY2FzKTsNCj4+ICt2
b2lkIHVtYWRfZnJlZV9jYV9uYW1lbGlzdChjaGFyICpjYXMpOw0KPj4gICANCj4+ICAgZW51bSB7
DQo+PiAgIAlVTUFEX1VTRVJfUk1QUCA9ICgxIDw8IDApDQo+PiAtLSANCj4+IDEuOC4zLjENCj4+
DQo=
