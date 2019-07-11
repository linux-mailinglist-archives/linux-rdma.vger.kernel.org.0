Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DC75E65B5D
	for <lists+linux-rdma@lfdr.de>; Thu, 11 Jul 2019 18:18:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728643AbfGKQSv (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 11 Jul 2019 12:18:51 -0400
Received: from mail-eopbgr40061.outbound.protection.outlook.com ([40.107.4.61]:30275
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728045AbfGKQSv (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 11 Jul 2019 12:18:51 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Zrs9gP1tD9ItrYMGihphFukQCo31jKf/OVD/GB+TPfULifepSGR3UGxsGLtUVjlglo/4ZAxMdtl6MFzxBltTyHDxxYB4CVeUl5v+4rgcdt/0l/1vktueFggAkOgwyh6izlkNC/K1adtVsMQUPHyqjSOAM4Echkeab3DC1wyY9rsUv+XKOC1/5v5hUojBAQsKjn0+mCUKd0+kkb0aG3ztW3gYxT4ULIx+FzLCCKRMUazgXl6U6X4sLYOp5Oq2L8CLNwNwABmV9m/3mSZj+zAWwqpHiMLM1n15D63iDOC8x2a7HrLDfLwVvmGTAaan8vynD+wbppj5MeWYN4v73gyjlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+HvnIk+80qWWKXe+ojnEDXJ1snfbHtfV8m4VtYKZFks=;
 b=BIChcD/ByR7jeLRRT8BrQkKr+gKCtcjQiFtLevokHKGvM05GhtUT1FVJMjzJnh/r2g9RYVMcSzQ2vEbd7KsodY/AlV3yVh2YOjut4l8Bj/7OXczVhAc18tPyczGBIDcJ17olTeyj1V5i7ZsilRsvCg+w1XOEv4Csts/m0hNtLQz0fhoLPUdMNK+BExwO86ab454eSf7Z4OHxkfh6wKx42yz/PGafDV060guc7yVQB+kDsG1DVkdLM5OJXygQwoZe5+O+jEEcxbr41aHLBf/dR0MPk3z0sxhKn2ad7DtodAcU/5WOLiHB4i+WcH7cP09IvBQ00tkmIMMHV1u3c2Wd6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=mellanox.com;dmarc=pass action=none
 header.from=mellanox.com;dkim=pass header.d=mellanox.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+HvnIk+80qWWKXe+ojnEDXJ1snfbHtfV8m4VtYKZFks=;
 b=CyUjlCW+Q9DRbjhwuL2wrnlQTKA247RZoKAxbVSYYt+FxEYsW1jQsg9YziUpGV36llXS7cYYXC4Mcum8KO840zuOBokQeJ477KQDWO34uKXSFf8vubDNHNRqc7uSPIdii0jQ06fswJ0aSy2gR7R17/8ByGAYgbZlqAXi/gJWEx4=
Received: from AM0PR05MB4866.eurprd05.prod.outlook.com (20.176.214.160) by
 AM0PR05MB6434.eurprd05.prod.outlook.com (20.179.32.84) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2073.10; Thu, 11 Jul 2019 16:18:46 +0000
Received: from AM0PR05MB4866.eurprd05.prod.outlook.com
 ([fe80::217d:2cd7:c8da:9279]) by AM0PR05MB4866.eurprd05.prod.outlook.com
 ([fe80::217d:2cd7:c8da:9279%5]) with mapi id 15.20.2052.020; Thu, 11 Jul 2019
 16:18:46 +0000
From:   Parav Pandit <parav@mellanox.com>
To:     Yi Zhang <yi.zhang@redhat.com>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
CC:     Daniel Jurgens <danielj@mellanox.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Devesh Sharma <devesh.sharma@broadcom.com>,
        "selvin.xavier@broadcom.com" <selvin.xavier@broadcom.com>
Subject: RE: regression: nvme rdma with bnxt_re0 broken
Thread-Topic: regression: nvme rdma with bnxt_re0 broken
Thread-Index: 2UfSPBB7aurhIBgBOMtlZZ/Acg5lQJrLV3lwgAA5BsA=
Date:   Thu, 11 Jul 2019 16:18:45 +0000
Message-ID: <AM0PR05MB4866070FBADCCABD1F84E42ED1F30@AM0PR05MB4866.eurprd05.prod.outlook.com>
References: <1310083272.27124086.1562836112586.JavaMail.zimbra@redhat.com>
 <619411460.27128070.1562838433020.JavaMail.zimbra@redhat.com>
 <AM0PR05MB48664657022ECA8526E3C967D1F30@AM0PR05MB4866.eurprd05.prod.outlook.com>
In-Reply-To: <AM0PR05MB48664657022ECA8526E3C967D1F30@AM0PR05MB4866.eurprd05.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=parav@mellanox.com; 
x-originating-ip: [49.207.52.95]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0e9cdeef-6933-46d0-a320-08d7061b730c
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:AM0PR05MB6434;
x-ms-traffictypediagnostic: AM0PR05MB6434:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <AM0PR05MB643466E437C7BF2985148778D1F30@AM0PR05MB6434.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:241;
x-forefront-prvs: 0095BCF226
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(136003)(346002)(366004)(39860400002)(396003)(376002)(189003)(199004)(13464003)(66476007)(66066001)(6436002)(71190400001)(71200400001)(55016002)(14454004)(66556008)(66946007)(66446008)(76116006)(33656002)(54906003)(2940100002)(2906002)(229853002)(64756008)(7696005)(99286004)(25786009)(6116002)(53936002)(3846002)(7736002)(6246003)(305945005)(2501003)(8936002)(52536014)(9686003)(6306002)(81166006)(14444005)(5660300002)(966005)(74316002)(186003)(76176011)(26005)(6506007)(53546011)(102836004)(55236004)(11346002)(476003)(486006)(316002)(446003)(68736007)(256004)(86362001)(478600001)(110136005)(81156014)(8676002)(4326008);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR05MB6434;H:AM0PR05MB4866.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: eLCjRMtAzIfBdi0qltIJdSZZNi/lpWZDVal/fuAkyP3jui0K7y4wHm8IzaHujcr/QKNglN4M++U2bGWApYW0aW44KItts8MvgA5DF5q6mhsPJnOI/e25+szVh5r9J1chPlPVs08zTzxWL1aZmcKfcuo/AJtmlJLATYEk92CpgxodcJhhO5V7d3xv4ksLalaeJJWS5boJEpTSmwQQ7ezWZlqVtfs8JsZsGSQ45mx3CP/mplwv0sk6EP1uevemLLk6rkfNf1ES9nYoG3kR6xIVDkQ0qGeRb+s2SoT5/NEYf7gVFTijqg6oPMGL6TJ7Avfw2+qoW5GOJtZc+YzRr4ioNnrTkYgD/xgWqtpjHQVM0LUxOyAla7HsC/oK4frfAiDgWMiHBZKP/3O/86ju9mVZkOfQU4RXiTXZ22FPSrr5VzI=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e9cdeef-6933-46d0-a320-08d7061b730c
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jul 2019 16:18:45.9366
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: parav@mellanox.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR05MB6434
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

U2FnaSwNCg0KVGhpcyBpcyBiZXR0ZXIgb25lIHRvIGNjIHRvIGxpbnV4LXJkbWEuDQoNCisgRGV2
ZXNoLCBTZWx2aW4uDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogUGFy
YXYgUGFuZGl0DQo+IFNlbnQ6IFRodXJzZGF5LCBKdWx5IDExLCAyMDE5IDY6MjUgUE0NCj4gVG86
IFlpIFpoYW5nIDx5aS56aGFuZ0ByZWRoYXQuY29tPjsgbGludXgtbnZtZUBsaXN0cy5pbmZyYWRl
YWQub3JnDQo+IENjOiBEYW5pZWwgSnVyZ2VucyA8ZGFuaWVsakBtZWxsYW5veC5jb20+DQo+IFN1
YmplY3Q6IFJFOiByZWdyZXNzaW9uOiBudm1lIHJkbWEgd2l0aCBibnh0X3JlMCBicm9rZW4NCj4g
DQo+IEhpIFlpIFpoYW5nLA0KPiANCj4gPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiA+
IEZyb206IFlpIFpoYW5nIDx5aS56aGFuZ0ByZWRoYXQuY29tPg0KPiA+IFNlbnQ6IFRodXJzZGF5
LCBKdWx5IDExLCAyMDE5IDM6MTcgUE0NCj4gPiBUbzogbGludXgtbnZtZUBsaXN0cy5pbmZyYWRl
YWQub3JnDQo+ID4gQ2M6IERhbmllbCBKdXJnZW5zIDxkYW5pZWxqQG1lbGxhbm94LmNvbT47IFBh
cmF2IFBhbmRpdA0KPiA+IDxwYXJhdkBtZWxsYW5veC5jb20+DQo+ID4gU3ViamVjdDogcmVncmVz
c2lvbjogbnZtZSByZG1hIHdpdGggYm54dF9yZTAgYnJva2VuDQo+ID4NCj4gPiBIZWxsbw0KPiA+
DQo+ID4gJ252bWUgY29ubmVjdCcgZmFpbGVkIHdoZW4gdXNlIGJueHRfcmUwIG9uIGxhdGVzdCB1
cHN0cmVhbSBidWlsZFsxXSwNCj4gPiBieSBiaXNlY3RpbmcgSSBmb3VuZCBpdCB3YXMgaW50cm9k
dWNlZCBmcm9tIHY1LjIuMC1yYzEgd2l0aCBbMl0sIGl0DQo+ID4gd29ya3MgYWZ0ZXIgSSByZXZl
cnQgaXQuDQo+ID4gTGV0IG1lIGtub3cgaWYgeW91IG5lZWQgbW9yZSBpbmZvLCB0aGFua3MuDQo+
ID4NCj4gPiBbMV0NCj4gPiBbcm9vdEByZG1hLXBlcmYtMDcgfl0kIG52bWUgY29ubmVjdCAtdCBy
ZG1hIC1hIDE3Mi4zMS40MC4xMjUgLXMgNDQyMA0KPiA+IC1uIHRlc3RucW4gRmFpbGVkIHRvIHdy
aXRlIHRvIC9kZXYvbnZtZS1mYWJyaWNzOiBCYWQgYWRkcmVzcw0KPiA+DQo+ID4gW3Jvb3RAcmRt
YS1wZXJmLTA3IH5dJCBkbWVzZw0KPiA+IFsgIDQ3Ni4zMjA3NDJdIGJueHRfZW4gMDAwMDoxOTow
MC4wOiBRUExJQjogY21kcVsweDRiOV09MHgxNSBzdGF0dXMNCj4gPiAweDUgWyA0NzYuMzI3MTAz
XSBpbmZpbmliYW5kIGJueHRfcmUwOiBGYWlsZWQgdG8gYWxsb2NhdGUgSFcgQUggWw0KPiA+IDQ3
Ni4zMzI1MjVdIG52bWUgbnZtZTI6IHJkbWFfY29ubmVjdCBmYWlsZWQgKC0xNCkuDQo+ID4gWyAg
NDc2LjM0MzU1Ml0gbnZtZSBudm1lMjogcmRtYSBjb25uZWN0aW9uIGVzdGFibGlzaG1lbnQgZmFp
bGVkICgtMTQpDQo+ID4NCj4gPiBbcm9vdEByZG1hLXBlcmYtMDcgfl0kIGxzcGNpICB8IGdyZXAg
LWkgQnJvYWRjb20NCj4gPiAwMTowMC4wIEV0aGVybmV0IGNvbnRyb2xsZXI6IEJyb2FkY29tIElu
Yy4gYW5kIHN1YnNpZGlhcmllcyBOZXRYdHJlbWUNCj4gPiBCQ001NzIwIDItcG9ydCBHaWdhYml0
IEV0aGVybmV0IFBDSWUNCj4gPiAwMTowMC4xIEV0aGVybmV0IGNvbnRyb2xsZXI6IEJyb2FkY29t
IEluYy4gYW5kIHN1YnNpZGlhcmllcyBOZXRYdHJlbWUNCj4gPiBCQ001NzIwIDItcG9ydCBHaWdh
Yml0IEV0aGVybmV0IFBDSWUNCj4gPiAxODowMC4wIFJBSUQgYnVzIGNvbnRyb2xsZXI6IEJyb2Fk
Y29tIC8gTFNJIE1lZ2FSQUlEIFNBUy0zIDMwMDggW0Z1cnldDQo+ID4gKHJldg0KPiA+IDAyKQ0K
PiA+IDE5OjAwLjAgRXRoZXJuZXQgY29udHJvbGxlcjogQnJvYWRjb20gSW5jLiBhbmQgc3Vic2lk
aWFyaWVzIEJDTTU3NDEyDQo+ID4gTmV0WHRyZW1lLUUgMTBHYiBSRE1BIEV0aGVybmV0IENvbnRy
b2xsZXIgKHJldiAwMSkNCj4gPiAxOTowMC4xIEV0aGVybmV0IGNvbnRyb2xsZXI6IEJyb2FkY29t
IEluYy4gYW5kIHN1YnNpZGlhcmllcyBCQ001NzQxMg0KPiA+IE5ldFh0cmVtZS1FIDEwR2IgUkRN
QSBFdGhlcm5ldCBDb250cm9sbGVyIChyZXYgMDEpDQo+ID4NCj4gPg0KPiA+IFsyXQ0KPiA+IGNv
bW1pdCA4MjNiMjNkYTcxMTMyYjgwZDlmNDFhYjY2N2M2OGIxMTI0NTVmM2I2DQo+ID4gQXV0aG9y
OiBQYXJhdiBQYW5kaXQgPHBhcmF2QG1lbGxhbm94LmNvbT4NCj4gPiBEYXRlOiAgIFdlZCBBcHIg
MTAgMTE6MjM6MDMgMjAxOSArMDMwMA0KPiA+DQo+ID4gICAgIElCL2NvcmU6IEFsbG93IHZsYW4g
bGluayBsb2NhbCBhZGRyZXNzIGJhc2VkIFJvQ0UgR0lEcw0KPiA+DQo+ID4gICAgIElQdjYgbGlu
ayBsb2NhbCBhZGRyZXNzIGZvciBhIFZMQU4gbmV0ZGV2aWNlIGhhcyBub3RoaW5nIHRvIGRvIHdp
dGggaXRzDQo+ID4gICAgIHJlc2VtYmxhbmNlIHdpdGggdGhlIGRlZmF1bHQgR0lELCBiZWNhdXNl
IFZMQU4gbGluayBsb2NhbCBHSUQgaXMgaW4NCj4gPiAgICAgZGlmZmVyZW50IGxheWVyIDIgZG9t
YWluLg0KPiA+DQo+ID4gICAgIE5vdyB0aGF0IFJvQ0UgTUFEIHBhY2tldCBwcm9jZXNzaW5nIGFu
ZCByb3V0ZSByZXNvbHV0aW9uIGNvbnNpZGVyIHRoZQ0KPiA+ICAgICByaWdodCBHSUQgaW5kZXgs
IHRoZXJlIGlzIG5vIG5lZWQgZm9yIGFuIHVubmVjZXNzYXJ5IGNoZWNrIHdoaWNoIHByZXZlbnRz
DQo+ID4gICAgIHRoZSBhZGRpdGlvbiBvZiB2bGFuIGJhc2VkIElQdjYgbGluayBsb2NhbCBHSURz
Lg0KPiA+DQo+ID4gICAgIFNpZ25lZC1vZmYtYnk6IFBhcmF2IFBhbmRpdCA8cGFyYXZAbWVsbGFu
b3guY29tPg0KPiA+ICAgICBSZXZpZXdlZC1ieTogRGFuaWVsIEp1cmdlbnMgPGRhbmllbGpAbWVs
bGFub3guY29tPg0KPiA+ICAgICBTaWduZWQtb2ZmLWJ5OiBMZW9uIFJvbWFub3Zza3kgPGxlb25y
b0BtZWxsYW5veC5jb20+DQo+ID4gICAgIFNpZ25lZC1vZmYtYnk6IEphc29uIEd1bnRob3JwZSA8
amdnQG1lbGxhbm94LmNvbT4NCj4gPg0KPiA+DQo+ID4NCj4gPiBCZXN0IFJlZ2FyZHMsDQo+ID4g
ICBZaSBaaGFuZw0KPiA+DQo+IA0KPiBJIG5lZWQgc29tZSBtb3JlIGluZm9ybWF0aW9uIGZyb20g
eW91IHRvIGRlYnVnIHRoaXMgaXNzdWUgYXMgSSBkb27igJl0IGhhdmUgdGhlDQo+IGh3Lg0KPiBU
aGUgaGlnaGxpZ2h0ZWQgcGF0Y2ggYWRkZWQgc3VwcG9ydCBmb3IgSVB2NiBsaW5rIGxvY2FsIGFk
ZHJlc3MgZm9yIHZsYW4uIEkgYW0NCj4gdW5zdXJlIGhvdyB0aGlzIGNhbiBhZmZlY3QgSVB2NCBB
SCBjcmVhdGlvbiBmb3Igd2hpY2ggdGhlcmUgaXMgZmFpbHVyZS4NCj4gDQo+IDEuIEJlZm9yZSB5
b3UgYXNzaWduIHRoZSBJUCBhZGRyZXNzIHRvIHRoZSBuZXRkZXZpY2UsIFBsZWFzZSBkbywgZWNo
byAtbg0KPiAibW9kdWxlIGliX2NvcmUgK3AiID4gL3N5cy9rZXJuZWwvZGVidWcvZHluYW1pY19k
ZWJ1Zy9jb250cm9sDQo+IA0KPiBQbGVhc2Ugc2hhcmUgYmVsb3cgb3V0cHV0IGJlZm9yZSBkb2lu
ZyBudm1lIGNvbm5lY3QuDQo+IDIuIE91dHB1dCBvZiBzY3JpcHQgWzFdDQo+ICQgc2hvd19naWRz
IHNjcmlwdA0KPiBJZiBnZXR0aW5nIHRoaXMgc2NyaXB0IGlzIHByb2JsZW1hdGljLCBzaGFyZSB0
aGUgb3V0cHV0IG9mLA0KPiANCj4gJCBjYXQgL3N5cy9jbGFzcy9pbmZpbmliYW5kL2JueHRfcmUw
L3BvcnRzLzEvZ2lkcy8qDQo+ICQgY2F0IC9zeXMvY2xhc3MvaW5maW5pYmFuZC9ibnh0X3JlMC9w
b3J0cy8xL2dpZF9hdHRycy9uZGV2cy8qDQo+ICQgaXAgbGluayBzaG93DQo+ICRpcCBhZGRyIHNo
b3cNCj4gJCBkbWVzZw0KPiANCj4gWzFdIGh0dHBzOi8vY29tbXVuaXR5Lm1lbGxhbm94LmNvbS9z
L2FydGljbGUvdW5kZXJzdGFuZGluZy1zaG93LWdpZHMtDQo+IHNjcmlwdCNqaXZlX2NvbnRlbnRf
aWRfVGhlX1NjcmlwdA0KPiANCj4gSSBzdXNwZWN0IHRoYXQgZHJpdmVyJ3MgYXNzdW1wdGlvbiBh
Ym91dCBHSUQgaW5kaWNlcyBtaWdodCBoYXZlIGdvbmUgd3JvbmcNCj4gaGVyZSBpbiBkcml2ZXJz
L2luZmluaWJhbmQvaHcvYm54dF9yZS9pYl92ZXJicy5jLg0KPiBMZXRzIHNlZSBhYm91dCByZXN1
bHRzIHRvIGNvbmZpcm0gdGhhdC4NCg==
