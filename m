Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2C1B6FB6FD
	for <lists+linux-rdma@lfdr.de>; Wed, 13 Nov 2019 19:03:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727145AbfKMSDS (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 13 Nov 2019 13:03:18 -0500
Received: from mail-eopbgr00075.outbound.protection.outlook.com ([40.107.0.75]:18499
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726120AbfKMSDS (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 13 Nov 2019 13:03:18 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L6r2gYNdxbLJpYw+SeQCxzN+ndHiYEiSvSrpipH8riaZm6DS6cyGVX6la96B+6Kfh/VIpS9vYsEsFnuLsuzWF1M88H4yheji1gzw12smdL/qWH3sM8WteOLiqXNZcmJLB2CAOncYTMf3Ke4nb6nfm0RosHXuXdWHpcFjVeQuBg5pWzuW2bidA+LM6NNlDvK5GGz75mGr69nQDaNRoSA1YMQS+tfkE4LlWrf9Px68PIReunDF6wPWl54ECMwGj1nExeCy5bu3smRcAFxxdmnfzD+DDbQASLT9GgALShynhOkoam5FZ7+T3EMvCXkrJ8eMHyaFnPjv516XRkZB/+jtSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b5ia2lM0S6f28hYL7oV7SMADxo4pzY9ek99Iwmvo0as=;
 b=ITkifikb5nJdh3340/niGcUnOATFllZ11gsAU7+QKZUwsH9AqvhvV1fECy5Bz/acqZYg4w2tx+4TxCd8cqKwSsZwC9n5fgelA/XwYGKGAF15/oOcVjBEhGUjvPBS0l1ethTRjeCgxmAgzGlAeV7ZUIVF6dA76Pra2M/7r7Q6x8tZEW/Khi+4x0MB27sUVhQl+PpKXh7LIhZlVvepaLrajSKR7Vi38BzKcre5MzJQ1cBWCBIXplRBL2pgjraozwbigqiVXjoTi54ANKtO6Dxu/U6HOVBL0bvf2vJ6D632LCDttkD5uWziz5m6VJ1GIq9FmgUw8xmpNTb1omIseiIsCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mellanox.com; dmarc=pass action=none header.from=mellanox.com;
 dkim=pass header.d=mellanox.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b5ia2lM0S6f28hYL7oV7SMADxo4pzY9ek99Iwmvo0as=;
 b=lN4i1m53U7Ake1bQsJWYdz7ddmX2v0n3F3V8//Bt/qviz2ojONMy5fuS7t2Vi9/jKsV7GZKUHi35i5plqJLMqqALzAstQsunNdd6YRjrhnY2f3fCGmX4IFg8RiK6TYl1j/HzAqoEERpXoYjiEJ3uIA+p5HnTyv6npt0pRBnrK5A=
Received: from AM0PR05MB4866.eurprd05.prod.outlook.com (20.176.214.160) by
 AM0PR05MB4481.eurprd05.prod.outlook.com (52.134.125.144) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2430.23; Wed, 13 Nov 2019 18:03:14 +0000
Received: from AM0PR05MB4866.eurprd05.prod.outlook.com
 ([fe80::e5c2:b650:f89:12d4]) by AM0PR05MB4866.eurprd05.prod.outlook.com
 ([fe80::e5c2:b650:f89:12d4%7]) with mapi id 15.20.2430.027; Wed, 13 Nov 2019
 18:03:14 +0000
From:   Parav Pandit <parav@mellanox.com>
To:     oulijun <oulijun@huawei.com>, Jason Gunthorpe <jgg@ziepe.ca>
CC:     Doug Ledford <dledford@redhat.com>,
        linux-rdma <linux-rdma@vger.kernel.org>
Subject: =?utf-8?B?UkU6IOOAkEFzayBmb3IgaGVscOOAkSBBIHF1ZXN0aW9uIGZvciBfX2liX2Nh?=
 =?utf-8?B?Y2hlX2dpZF9hZGQoKQ==?=
Thread-Topic: =?utf-8?B?44CQQXNrIGZvciBoZWxw44CRIEEgcXVlc3Rpb24gZm9yIF9faWJfY2FjaGVf?=
 =?utf-8?Q?gid=5Fadd()?=
Thread-Index: AQHVkJfhnQfcRJI2EkWYHU+fh643xqd2SO8AgAAtUBCAEqZKAIAAWQcQ
Date:   Wed, 13 Nov 2019 18:03:13 +0000
Message-ID: <AM0PR05MB4866E920E2A2A0DA150CFF56D1760@AM0PR05MB4866.eurprd05.prod.outlook.com>
References: <fd2a9385-f6c7-8471-b20c-476d4e9fada7@huawei.com>
 <20191101130540.GB30938@ziepe.ca>
 <AM0PR05MB4866715D6F149927D4B31C46D1620@AM0PR05MB4866.eurprd05.prod.outlook.com>
 <a1b0cf5f-e52e-99b2-9888-6a40c4d71702@huawei.com>
In-Reply-To: <a1b0cf5f-e52e-99b2-9888-6a40c4d71702@huawei.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=parav@mellanox.com; 
x-originating-ip: [208.176.44.194]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 8754b9b9-0b07-4d5d-e725-08d76863c0bc
x-ms-traffictypediagnostic: AM0PR05MB4481:
x-microsoft-antispam-prvs: <AM0PR05MB4481B6812A10B5951519A3E5D1760@AM0PR05MB4481.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 0220D4B98D
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(376002)(39860400002)(366004)(346002)(396003)(136003)(199004)(54094003)(189003)(13464003)(5660300002)(14444005)(9686003)(71190400001)(71200400001)(256004)(6246003)(478600001)(446003)(11346002)(486006)(76176011)(476003)(81156014)(81166006)(305945005)(7736002)(229853002)(8936002)(4326008)(14454004)(52536014)(74316002)(6116002)(66556008)(316002)(3846002)(66446008)(66476007)(64756008)(6436002)(66946007)(76116006)(6506007)(25786009)(186003)(33656002)(110136005)(102836004)(2906002)(7696005)(86362001)(54906003)(66066001)(99286004)(53546011)(55016002)(26005);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR05MB4481;H:AM0PR05MB4866.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: LwMaMwuXpqV9xaEC15raij7u9dW2FqzImEuR02KAvNAsdBhd3/Oh7QysYE+nxxkc+NSvyxMdoG9q+TbH6LgQ2uO7/t/misKg0cX03wTTJ8g2bOU9uiQTY0F+kzOaTsMZY4/ZDBlRKyRsn0yAYr71cc2PuC1yeNqwKDIBxZAILAkXiKz13juKmcclgNRWAU8tm/93Sb0M9Fs1eKRumGxThbi1TO/s13lts6pr11m9CTuiiJ9RRvxLGthCi7RaRzj226ZuNCHm7TTOV12TQQ04pc/3qi8xsPVGsy1w9DEYXwb2t47Yd8oNNxmrfm3v0uj7Y5YK6bMBq6EceaNL74LLePMEu7eITwTw7/QEoxn++yyobzPdxzZ5r8ccRrfPZ66prOWYb9AfqIF6gaEpaoMU+e7A2O5z/6r9P57Jv7M6fkEO5z0fV9q8uQDZHhvNffkg
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8754b9b9-0b07-4d5d-e725-08d76863c0bc
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Nov 2019 18:03:13.9961
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MjQO6B1pZ95NzC/f+Gub/qtWZRlbhCjv3jMUT0Go3drtORZaO1YwnqwiQaAkPYORJBbxxx6OlVBZbQB+FhDyXA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR05MB4481
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

SGkgTGlqdW4sDQoNCj4gRnJvbTogbGludXgtcmRtYS1vd25lckB2Z2VyLmtlcm5lbC5vcmcgPGxp
bnV4LXJkbWEtDQo+IG93bmVyQHZnZXIua2VybmVsLm9yZz4gT24gQmVoYWxmIE9mIG91bGlqdW4N
Cj4gU2VudDogV2VkbmVzZGF5LCBOb3ZlbWJlciAxMywgMjAxOSA2OjM2IEFNDQo+IOWcqCAyMDE5
LzExLzIgMDowMCwgUGFyYXYgUGFuZGl0IOWGmemBkzoNCj4gPiBIaSBMaWp1biwNCj4gPg0KPiA+
PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiA+PiBGcm9tOiBKYXNvbiBHdW50aG9ycGUg
PGpnZ0B6aWVwZS5jYT4NCj4gPj4gU2VudDogRnJpZGF5LCBOb3ZlbWJlciAxLCAyMDE5IDg6MDYg
QU0NCj4gPj4gVG86IG91bGlqdW4gPG91bGlqdW5AaHVhd2VpLmNvbT47IFBhcmF2IFBhbmRpdCA8
cGFyYXZAbWVsbGFub3guY29tPg0KPiA+PiBDYzogRG91ZyBMZWRmb3JkIDxkbGVkZm9yZEByZWRo
YXQuY29tPjsgbGludXgtcmRtYSA8bGludXgtDQo+ID4+IHJkbWFAdmdlci5rZXJuZWwub3JnPg0K
PiA+PiBTdWJqZWN0OiBSZTog44CQQXNrIGZvciBoZWxw44CRIEEgcXVlc3Rpb24gZm9yIF9faWJf
Y2FjaGVfZ2lkX2FkZCgpDQo+ID4+DQo+ID4+IE9uIEZyaSwgTm92IDAxLCAyMDE5IGF0IDA1OjM2
OjM2UE0gKzA4MDAsIG91bGlqdW4gd3JvdGU6DQo+ID4+PiBIaQ0KPiA+Pj4gICBJIGFtIHVzaW5n
IHRoZSB1YnVudHUgc3lzdGVtKDUuMC4wIGtlcm5lbCkgdG8gdGVzdCB0aGUgaGlwMDggTklDDQo+
ID4+PiBwb3J0LC4gV2hlbiBJIG1vZGlmeSB0aGUgcGVyciBtYWMxIHRvIG1hYzIsdGhlbiByZXN0
b3JlIHRvIG1hYzEsIGl0DQo+ID4+PiB3aWxsDQo+ID4+IGNhdXNlIHRoZSBnaWQwIGFuZCBnaWQg
MSBvZiB0aGUgcm9jZSB0byBiZSB1bmF2YWlsYWJsZSwgYW5kIGNoZWNrDQo+ID4+IHRoYXQgdGhl
DQo+ID4+IC9zeXMvY2xhc3MvaW5maW5pYmFuZC9obnNfMC9wb3J0cy8xL2dpZF9hdHRycy9uZGV2
cy8wIGlzIHNob3cgaW52YWxpZC4NCj4gPj4+IHRoZSBwcm90b2NvbCBzdGFjayBwcmludCB3aWxs
IGFwcGVhci4NCj4gPj4+DQo+ID4+PiAgIE9jdCAxNiAxNzo1OTozNiB1YnVudHUga2VybmVsOiBb
MjAwNjM1LjQ5NjMxN10gX19pYl9jYWNoZV9naWRfYWRkOg0KPiA+Pj4gdW5hYmxlIHRvIGFkZCBn
aWQgZmU4MDowMDAwOjAwMDA6MDAwMDo0NjAwOjRkZmY6ZmVhNzo5NTk5IGVycm9yPS0yOA0KPiA+
Pj4gT2N0IDE2IDE3OjU5OjM3IHVidW50dSBrZXJuZWw6IFsyMDA2MzYuNzA1ODQ4XSA4MDIxcTog
YWRkaW5nIFZMQU4gMA0KPiA+Pj4gdG8gSFcgZmlsdGVyIG9uIGRldmljZSBlbnAxODlzMGYwIE9j
dCAxNiAxNzo1OTozNyB1YnVudHUga2VybmVsOg0KPiA+Pj4gWzIwMDYzNi43MDU4NTRdIF9faWJf
Y2FjaGVfZ2lkX2FkZDogdW5hYmxlIHRvIGFkZCBnaWQNCj4gPj4+IGZlODA6MDAwMDowMDAwOjAw
MDA6NDYwMDo0ZGZmOmZlYTc6OTU5OSBlcnJvcj0tMjggT2N0IDE2IDE3OjU5OjM5DQo+ID4+PiB1
YnVudHUga2VybmVsOiBbMjAwNjM4Ljc1NTgyOF0gaG5zMyAwMDAwOmJkOjAwLjAgZW5wMTg5czBm
MDogbGluayB1cA0KPiA+Pj4gT2N0IDE2IDE3OjU5OjM5IHVidW50dSBrZXJuZWw6IFsyMDA2Mzgu
NzU1ODQ3XSBJUHY2Og0KPiA+Pj4gQUREUkNPTkYoTkVUREVWX0NIQU5HRSk6IGVucDE4OXMwZjA6
IGxpbmsgYmVjb21lcyByZWFkeSBPY3QgMTYNCj4gPj4+IDE4OjAwOjU2IHVidW50dSBrZXJuZWw6
IFsyMDA3MTUuNjk5OTYxXSBobnMzIDAwMDA6YmQ6MDAuMCBlbnAxODlzMGYwOg0KPiA+Pj4gbGlu
ayBkb3duIE9jdCAxNiAxODowMDo1NiB1YnVudHUga2VybmVsOiBbMjAwNzE2LjAxNjE0Ml0NCj4g
Pj4+IF9faWJfY2FjaGVfZ2lkX2FkZDogdW5hYmxlIHRvIGFkZCBnaWQNCj4gPj4+IGZlODA6MDAw
MDowMDAwOjAwMDA6NDYwMDo0ZGZmOmZlYTc6OTVmNCBlcnJvcj0tMjggT2N0IDE2IDE4OjAwOjU4
DQo+ID4+PiB1YnVudHUga2VybmVsOiBbMjAwNzE3LjIyOTg1N10gODAyMXE6IGFkZGluZyBWTEFO
IDAgdG8gSFcgZmlsdGVyIG9uDQo+ID4+PiBkZXZpY2UgZW5wMTg5czBmMCBPY3QgMTYgMTg6MDA6
NTggdWJ1bnR1IGtlcm5lbDogWzIwMDcxNy4yMjk4NjNdDQo+ID4+PiBfX2liX2NhY2hlX2dpZF9h
ZGQ6IHVuYWJsZSB0byBhZGQgZ2lkDQo+ID4+PiBmZTgwOjAwMDA6MDAwMDowMDAwOjQ2MDA6NGRm
ZjpmZWE3Ojk1ZjQgZXJyb3I9LTI4DQo+ID4+Pg0KPiA+Pj4gSGFzIGFueW9uZSBlbHNlIGVuY291
bnRlcmQgYSBzaW1pbGFyIHByb2JsZW0gPyBJIHdvbmRlciBpZiB0aGUNCj4gPj4gX2liX2NhY2hl
X2FkZF9naWQoKSBpcyBkZWZlY3RpdmUgaW4gNS4wIGtlcm5lbD8NCj4gPj4NCj4gPj4gTWF5YmUg
UGFyYXYga25vd3M/DQo+ID4gSSB1c2VkIHRoZSBrZXJuZWwgZnJvbSBbMV0sIHdoaWNoIHNlZW1z
IHRvIGJlIGZpbmU7IGl0IGhhcyB0aGUgcmVxdWlyZWQNCj4gY29tbWl0cyBbMl0sIFszXSwgWzRd
Lg0KPiA+DQo+ID4gQXJlIHlvdSBydW5uaW5nIFJETUEgdHJhZmZpYy9hcHBsaWNhdGlvbnMgd2hp
Y2ggYXJlIHVzaW5nIEdJRCAwIGFuZCAxIHdoZW4NCj4gY2hhbmdpbmcgTUFDPw0KPiA+IElmIHNv
LCBhZG1pbmlzdHJhdGl2ZSBvcGVyYXRpb24gc3VjaCBhcyBNQUMgYWRkcmVzcyBjaGFuZ2UgZHVy
aW5nIGFjdGl2ZQ0KPiBSRE1BIHRyYWZmaWMgaXMgdW5zdXBwb3J0ZWQsIHdoaWNoIGNhbiBsZWFk
IHRvIHRoaXMgZXJyb3IuDQo+ID4gQ2FuIHlvdSBwbGVhc2UgY29uZmlybT8NCj4gSGksIHBhcmF2
IFBhbmRpdA0KPiAgICAgaWYgcnVubmluZyBSRE1BIHRyYWZmaWMvYXBwbGljYXRpb24gd2hpY2gg
YXJlIHVzaW5nIHZsYW4gZ2lkIHdoZW4gdmNvbmZpZw0KPiByZW0gdGhlIHZsYW4sIGl0IHdpbGwg
aGFwcGVuIHRoZSBmb2xsb3dpbmcgZXJyb3I/DQoNClllcywgdGhhdCBpcyBjb3JyZWN0LiBBcHBs
aWNhdGlvbiBpcyBib3VuZCB0aGUgcmRtYSBkZXZpY2UgYW5kIGl0cyBhc3NvY2lhdGVkIHZsYW4g
bmV0ZGV2aWNlLCBob2xkaW5nIHJlZmVyZW5jZSB0byBpdCB3aGlsZSBRUHMgYXJlIGFjdGl2ZS4N
Ck9uY2UgYXBwbGljYXRpb24gcmVsZWFzZXMgdGhlIFFQcywgdW5yZWdpc3RyYXRpb24gc2hvdWxk
IHByb2dyZXNzLg0KDQpTdXBwb3J0aW5nIGR5bmFtaWMgZGV0YWNobWVudCBvZiBuZXRkZXZpY2Vz
IGZyb20gdGhlIFJvQ0UgZGV2aWNlIHdhcyBhZGRlZCB1c2luZyBiZWxvdyA3IHBhdGNoZXMsIHRo
b3NlIGFyZSBub3QgcHJlc2VudCBpbiB0aGUgVWJ1bnR1IDUuMC4wLiBrZXJuZWwgdGhhdCBJIGxv
b2tlZCBhdC4NCg0KM2JmM2UyYjg4MWMxIFJETUEvcnhlOiBDb25zaWRlciBza2IgcmVzZXJ2ZSBz
cGFjZSBiYXNlZCBvbiBuZXRkZXYgb2YgR0lEDQo4Zjk3NDg2MDI0OTEgSUIvY206IFJlZHVjZSBk
ZXBlbmRlbmN5IG9uIGdpZCBhdHRyaWJ1dGUgbmRldiBjaGVjaw0KYTcwYzA3Mzk3ZmQ4IFJETUE6
IEludHJvZHVjZSBhbmQgdXNlIEdJRCBhdHRyIGhlbHBlciB0byByZWFkIFJvQ0UgTDIgZmllbGRz
DQphZGI0YTU3YTdhMWQgUkRNQS9jbWE6IFVzZSByZG1hX3JlYWRfZ2lkX2F0dHJfbmRldl9yY3Ug
dG8gYWNjZXNzIG5ldGRldg0KZGFiMjE3NTgwMGVmIFJETUEvcnhlOiBVc2UgcmRtYV9yZWFkX2dp
ZF9hdHRyX25kZXZfcmN1IHRvIGFjY2VzcyBuZXRkZXYNCjUxMDJlY2E5MDM5YiBuZXQvc21jOiBV
c2UgcmRtYV9yZWFkX2dpZF9sMl9maWVsZHMgdG8gTDIgZmllbGRzDQo5NDNiZDk4NGIxMDggUkRN
QS9jb3JlOiBBbGxvdyBkZXRhY2hpbmcgZ2lkIGF0dHJpYnV0ZSBuZXRkZXZpY2UgZm9yIFJvQ0UN
Cg0K
