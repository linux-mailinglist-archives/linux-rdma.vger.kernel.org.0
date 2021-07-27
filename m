Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E01E13D7EF8
	for <lists+linux-rdma@lfdr.de>; Tue, 27 Jul 2021 22:17:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231211AbhG0URd (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 27 Jul 2021 16:17:33 -0400
Received: from mail-co1nam11on2130.outbound.protection.outlook.com ([40.107.220.130]:9184
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230425AbhG0URa (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 27 Jul 2021 16:17:30 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SqdvZSuZcgBj4InZg8GyAH9GYVF/YeVaRG82jIu24VkONHWlrfuR31qmsXLegxNaPiQPzwrU+F/DeC82FbTc9dzoHdVdi2NC0PxABfo7QaIjR4qVKZ+nehEO3czLKpqH/SbGCBjhqfoIUVnoQyM3bmcFW2zsiIpUY76pN3rGyy61Z+Z520oyZYUHj4jH1BE6lVlLFD59FMQk4JwphYWyumOcA0BiOLAgVQbLIA3Hj2+suiVGXRscE1ONzxWuTDzMr0OTmLZLNKLqPQsFu0vdRNJEu4waZ5gHonSEoIgt0u4J3BcC2G3NvHXonnc7gQqJr907SjQz/NiuLrBlW1wMlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OpeumTgSsw+x38FYTW5SjES0HsSwCs6O8jdaVJlPL/k=;
 b=DaNnZ+TQhVixXfQ0sh4DbEHWFuQwh53eO3n3RmetdKQS3Fj4Ud7lvuXDwxyw9Zq93tqNtrGB/1ruso4EM5FvIIVObr/SjWk1+B5L8Yy8r9lx1Ad8PSTOp/B/txeWSY/QnOEa0h+jyy6dNfHtPKWcNYtteHWI7QHeIL5E++z986+A53ilD8G7p/JaXwI8RIr+KFnabDyLMdFGGSVfTBqB6OmmXkCXjY6gsAoTqGI86ZOI238WBcTKYnNxajnCunVXi00DpOxl6Sz4OAfFdaQN9XjgCv9C3rPpuKaanXxwQtpda3ONY2OZqworx4gFFIS0hPt0XzG+XYwLdqC9LQtndg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cornelisnetworks.com; dmarc=pass action=none
 header.from=cornelisnetworks.com; dkim=pass header.d=cornelisnetworks.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cornelisnetworks.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OpeumTgSsw+x38FYTW5SjES0HsSwCs6O8jdaVJlPL/k=;
 b=ZVa+bp281qCw336n8XeoHOdtxD1rq+u6IwXjyuGFe1o16HoP6FUibwGNxDEMmi4PzhQ43cK2Jti0Kvl1zX8Vx84zGeFUQgm2NSrWYjyuaRSF5KHfH21GVJsmqnTVXPZFyksMG12DTP12bCsnKq5+/0QZmrmBBrSZPSbCEXc8eJonQc1pkFBn7liloddWno7nLPtHa4olBsW4TVzT/oKQBMwr2uku2vkc5NIW7JeOfP4YxM4ykNno2Tkq1MRSrHCJYlEvCs6cL7kCVi/QbLPy63F3KB46+TmmlQbVAti4bA3cDqPYWMkTWaeH6XdNRKXABf+Jlf/teiV63V4JdGU1ew==
Received: from CH0PR01MB7153.prod.exchangelabs.com (2603:10b6:610:ea::7) by
 CH2PR01MB5734.prod.exchangelabs.com (2603:10b6:610:3d::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4352.25; Tue, 27 Jul 2021 20:17:27 +0000
Received: from CH0PR01MB7153.prod.exchangelabs.com
 ([fe80::f16e:8a3e:3b8d:8a34]) by CH0PR01MB7153.prod.exchangelabs.com
 ([fe80::f16e:8a3e:3b8d:8a34%5]) with mapi id 15.20.4373.018; Tue, 27 Jul 2021
 20:17:27 +0000
From:   "Marciniszyn, Mike" <mike.marciniszyn@cornelisnetworks.com>
To:     Jason Gunthorpe <jgg@nvidia.com>,
        Doug Ledford <dledford@redhat.com>
CC:     Chuck Lever III <chuck.lever@oracle.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "Dalessandro, Dennis" <dennis.dalessandro@cornelisnetworks.com>,
        Leon Romanovsky <leonro@nvidia.com>,
        Haakon Bugge <haakon.bugge@oracle.com>
Subject: RE: NFS RDMA test failure as of 5.14-rc1
Thread-Topic: NFS RDMA test failure as of 5.14-rc1
Thread-Index: AdeC6xneRTsXNTlrTWuqxyNIUrjEqgAOO93Q
Date:   Tue, 27 Jul 2021 20:17:26 +0000
Message-ID: <CH0PR01MB715358BA093A504AED855CCBF2E99@CH0PR01MB7153.prod.exchangelabs.com>
References: <CH0PR01MB7153D5381BBC3D1D0F146E8AF2E99@CH0PR01MB7153.prod.exchangelabs.com>
In-Reply-To: <CH0PR01MB7153D5381BBC3D1D0F146E8AF2E99@CH0PR01MB7153.prod.exchangelabs.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: nvidia.com; dkim=none (message not signed)
 header.d=none;nvidia.com; dmarc=none action=none
 header.from=cornelisnetworks.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: fbdf9184-b292-4e22-d21c-08d9513b8d9c
x-ms-traffictypediagnostic: CH2PR01MB5734:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CH2PR01MB5734C76CEFD0AF778315102CF2E99@CH2PR01MB5734.prod.exchangelabs.com>
x-ms-oob-tlc-oobclassifiers: OLM:2276;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: mkFdMgGsUAX63UASjSvRIrxxBksCBIEX57ikGbmAqFt/8I6h7zABwrfmiT0zROqp+5eq/mWFmzBI4BsSEeZc4Z66kM6ux5QJnXiF5CzuPxxDpSSrdfNR4s0rldRK7kEEYMm0DA4aYN22+KX9XFgD+4pAjjUcWNZk0paZFmpI7EHRDnSG7gWdEbvq/8XO7BASi1wVQZqcnETPznCL29QzhSkHesIzYb/5r/vlZ4RN1zPSeBpBnjxzcBze/MmBh0eLE8rc+vlPvw/cyWGAEQGIGWooUn83A3ogbCWPjPIH9oOR2Q7FAI7W3oEF1Su4LQyB30jhcJtGzbUn2/fFPMn43nkESCZpDU/6YHLIhUg7uU6w+cYu2pS/bEHCWYfQmBSjYvgazGixD821ADVQR9cUSCIKA+J31bmnDyNKY0j/5P2OMgWtyF1NJUO77TW1dk6dBozrl7ACEqMxawHM26AGHW5oIiP47GjPr4HOmoY5P0ETBDrmPjXGWIQ8q9zL33VyjdZ4Ky2tmi82tlWWJJuNnUuKyd0VxE0usZ3G0RdZgB/stLDpJ/q1201FLkaXFxBAtTdDPjld7w3z/XoQtLm9wEhIvnYW78ktE+taDcose1zDRhC3DBaQ3MQbMdh522g/XyEv2w2ARrKaBjT4AJHJYoqPpWoIUB13ytqY/qCieBBz+2bSL4oTBkH/W+6492xoT3fdivWOKgBCLBV0d9Si3lAH8glDqwsD1TfkHyNljwDy4i/dJnNo5U4b0kgQ3V46PXwZvoKHDWwuLx2qHRbOsDf80jyrmJeVyEnGHwxDSZw=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR01MB7153.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(4636009)(39840400004)(366004)(136003)(396003)(376002)(346002)(2940100002)(54906003)(38100700002)(5660300002)(4326008)(83380400001)(110136005)(122000001)(66556008)(64756008)(38070700005)(66446008)(66476007)(33656002)(86362001)(76116006)(52536014)(6506007)(186003)(7696005)(316002)(66946007)(55016002)(966005)(8936002)(9686003)(2906002)(26005)(71200400001)(8676002)(478600001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dXFCdFk2eXpYU1JkOTRTWkRHMUxWUnRYR21UWGdxUjFGU1pHWnRXY21xRmM0?=
 =?utf-8?B?dVhEQ0JVcTliWStZaEFKTUwzM0x5amU0SE9ISjhpbHo1cUR5ZjRZRUtncVlY?=
 =?utf-8?B?c3ZBVVdOeFdXdVZMQnlnbGZTUFA5Z3hvaEROaTZoTlVPWG5PYTlkdGEybW9a?=
 =?utf-8?B?TWRWYWtwVzlMVyttNHVDcHIzRmhWUCt2OGNtVzRhNkdGV09wcVRhczJIN3Fk?=
 =?utf-8?B?eGE5bHhWRnp0NFdVaXRBdW01aTYvYmlXQnZLQnBmSmJxYWZuSXBmdStnRWlP?=
 =?utf-8?B?L3g4STFUUVRDNXV3K25xZFl0Q29kQlRNNDk5Y0NFUktOQjFpZFpSbFBDUW04?=
 =?utf-8?B?K2dwNGw2UVBieStWU2ZyNnJ6VTZjMVNjQzFoQnBvOFZtdDN6SlNjSDFEU0xh?=
 =?utf-8?B?STVNZjZ5cUx6N0FZbENPNjVVeFkrMlAxWXAzS1JsSXVMY3dGU1FEcHIvNlJR?=
 =?utf-8?B?Zi9OdVpwTnJQTVBFUEtVa1R1MEUzdG15d1hQZzFDVDVjVnNIcjZZTXh4VzRF?=
 =?utf-8?B?bFppcXlYUzdSUEVBeUR4TTJBT2lYdGVHUkFvVUhTZUJWeVY3YnlEWGd1TXQr?=
 =?utf-8?B?d1RpSXNxcS9EdWF5NWFSS1B6MzVnM2JwZThUanpudmFEb0lxaUd4d1RMZ2xi?=
 =?utf-8?B?N0NRNXBVa2VaWGxEZ0lsY1dESkhsRGNjK3dVMlBHd0lkTFRrRTRjbTduVmVO?=
 =?utf-8?B?NkYwcE94OE13TDQ3MTVQQ2Qwb3FUVGtuQTIrOGhJdCtLeEF4M0l4YmtxTDZj?=
 =?utf-8?B?b2ZBSXZsU3N4V3ZISkZMZE1JWDQ1bDJjM3dYaE5mQ1NmMUR2dXJTdjZXUGl4?=
 =?utf-8?B?N3NDQStaNWh6VkVITUhyeTcweEtESk5obm5DNUlGcHp2M1BWVjVkbDk5QTg5?=
 =?utf-8?B?b2ExQ3VvNm1XVEx4T3Y4MyttbnIvbnNqTHg4enRYdWROZi9FMDNLUGFsWktu?=
 =?utf-8?B?ck5QZEZQM2lDMlpKZEE3eDdUdGs4TE54SDNDM1o2OUNIZ0xsTFloSEVEN3kv?=
 =?utf-8?B?MFNrLzJhR2RWNWw0SldYZmV4dkN2TDJJVng0ZVpJS3ZhQldFV0VWbTMwVVd5?=
 =?utf-8?B?OWFUZFl4Yjh6K2Z4UDZ1UmRoN05XbmIvektQUFQzNVZHUStJU1AvbGYxZmlG?=
 =?utf-8?B?ZVY3VVY2V0VDQ2xGbjRTZ0UxeW8rRlN2bFBJcy9OVmh3ekQxdWlkS0pGSk8w?=
 =?utf-8?B?U2xLYXdFd3FERlFreGJUNjZqekYvakFsNUwwNW9vc2NKZTlMTHJmWmgwMk5W?=
 =?utf-8?B?R1hTV0dET0NkbFg5UlVScDhOUTNibjhJQXB1WkV2U3lLNlZGMWpLZTk3YzVk?=
 =?utf-8?B?NWlvdU02N1NLTVBKeEdNV3BVMVFONksvQXdNTGlhNzIxb2E3cW8zbzFlbXVh?=
 =?utf-8?B?OHc1U2Y1SXJ0aTJrTVJVcjg2c2EwWWFzc3VQeDFjWXFoYUZqZnkxcjhLNVRL?=
 =?utf-8?B?dFYwa2xkT2trYWJNOVF6QWRRYW81VkJWUFdydThKOUc5UzFhQW10dmVXc0tv?=
 =?utf-8?B?U1VPSStYdkgwZHdNYWhWaUpyNlMyWEE2YW5mU3B4c1U2UllmWG9hM1VEV29Q?=
 =?utf-8?B?N2lCK0NYTGsyeEhvNUtLNUZoalllV3pzb3BEamNrWG16d28vOXFEeUFGZDkr?=
 =?utf-8?B?SGlENTNiR0M1ZStiSXFxamY1TjdXYWNTaEZFaW1oUXZqUE02Q3UrODBoZm1t?=
 =?utf-8?B?NndQS203K1dJTVZVNkpOMVprQUd4Nk5HU3NlMjlNUFQ5OEdPZnlaNXNBeVRO?=
 =?utf-8?Q?fOWGJgNuGRalwxYJ5E=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: cornelisnetworks.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR01MB7153.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fbdf9184-b292-4e22-d21c-08d9513b8d9c
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jul 2021 20:17:26.9544
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4dbdb7da-74ee-4b45-8747-ef5ce5ebe68a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PI2UL17a7DCYxlfkmRHgN0rsuDg3RwMNj4s98qRUEEJ9SZH0dGojU4gqIrQ10MTRZ/nHgxk4ee1nVM0JZan8KP5k0U40xhZuMvLbwlVhZODbZ54bq3T/2b3cPQvq8ubz
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR01MB5734
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

PiBTdWJqZWN0OiBORlMgUkRNQSB0ZXN0IGZhaWx1cmUgYXMgb2YgNS4xNC1yYzENCj4gDQo+IE91
ciBDSSB0ZXN0aW5nIGhhcyBiZWVuIGZhaWxpbmcgZm9yIE5GUyBSRE1BIHNpbmNlIDUuMTQtcmMx
Lg0KPiANCj4gQmFzZWQgb24ga3Byb2JlcywgdGhlIE5GUyBSRE1BIGNsaWVudCBjcmVhdGVzIGl0
cyBRUCB1c2luZw0KPiByZG1hX2NyZWF0ZV9xcCgpLCBhbmQgZG9lcyBwb3N0IHJlY2VpdmVzIHJp
Z2h0IGF3YXkuDQo+IA0KPiBUaGlzIHBhdGNoIGJlbG93IGxvb2tzIGxpa2UgaXQgZGVsZXRlZCB0
aGUgdHJhbnNpdGlvbiBmcm9tIFJFU0VUIHRvIElOSVQsDQo+IGJyZWFraW5nIHRoZSBjbGllbnQg
c2lkZSBORlMgUkRNQSBzaW5jZSBwb3N0IHJlY2VpdmVzIGFyZSBub3QgdmFsaWQgaW4gUkVTRVQu
DQo+IA0KPiBJIHN1c3BlY3QgdGhlIHBhdGNoIG5lZWRzIHRvIGJlIHJldmVydGVkIG9yIE5GUyBS
RE1BIG5lZWRzIHRvIGhhbmRsZSB0aGUNCj4gdHJhbnNpdGlvbiB0byBJTklUPw0KPiANCj4gY29t
bWl0IGRjNzBmN2MzZWQzNGIwODFjMDJhNjExNTkxYzUwNzljNTNiNzcxYjgNCj4gQXV0aG9yOiBI
77+9a29uIEJ1Z2dlIDxoYWFrb24uYnVnZ2VAb3JhY2xlLmNvbT4NCj4gRGF0ZTogICBUdWUgSnVu
IDIyIDE1OjM5OjU2IDIwMjEgKzAyMDANCj4gDQo+ICAgICBSRE1BL2NtYTogUmVtb3ZlIHVubmVj
ZXNzYXJ5IElOSVQtPklOSVQgdHJhbnNpdGlvbg0KPiANCj4gICAgIEluIHJkbWFfY3JlYXRlX3Fw
KCksIGEgY29ubmVjdGVkIFFQIHdpbGwgYmUgdHJhbnNpdGlvbmVkIHRvIHRoZSBJTklUDQo+ICAg
ICBzdGF0ZS4NCj4gDQo+ICAgICBBZnRlcndhcmRzLCB0aGUgUVAgd2lsbCBiZSB0cmFuc2l0aW9u
ZWQgdG8gdGhlIFJUUiBzdGF0ZSBieSB0aGUNCj4gICAgIGNtYV9tb2RpZnlfcXBfcnRyKCkgZnVu
Y3Rpb24uIEJ1dCB0aGlzIGZ1bmN0aW9uIHN0YXJ0cyBieSBwZXJmb3JtaW5nIGFuDQo+ICAgICBp
Yl9tb2RpZnlfcXAoKSB0byB0aGUgSU5JVCBzdGF0ZSBhZ2FpbiwgYmVmb3JlIGFub3RoZXIgaWJf
bW9kaWZ5X3FwKCkgaXMNCj4gICAgIHBlcmZvcm1lZCB0byB0cmFuc2l0aW9uIHRoZSBRUCB0byB0
aGUgUlRSIHN0YXRlLg0KPiANCj4gICAgIEhlbmNlLCB0aGVyZSBpcyBubyBuZWVkIHRvIHRyYW5z
aXRpb24gdGhlIFFQIHRvIHRoZSBJTklUIHN0YXRlIGluDQo+ICAgICByZG1hX2NyZWF0ZV9xcCgp
Lg0KPiANCj4gICAgIExpbms6IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL3IvMTYyNDM2OTE5Ny0y
NDU3OC0yLWdpdC1zZW5kLWVtYWlsLQ0KPiBoYWFrb24uYnVnZ2VAb3JhY2xlLmNvbQ0KPiAgICAg
U2lnbmVkLW9mZi1ieTogSO+/vWtvbiBCdWdnZSA8aGFha29uLmJ1Z2dlQG9yYWNsZS5jb20+DQo+
ICAgICBSZXZpZXdlZC1ieTogTGVvbiBSb21hbm92c2t5IDxsZW9ucm9AbnZpZGlhLmNvbT4NCj4g
ICAgIFNpZ25lZC1vZmYtYnk6IEphc29uIEd1bnRob3JwZSA8amdnQG52aWRpYS5jb20+DQoNCkEg
YnJpZWYgdW5pdCB0ZXN0IHdpdGggdGhlIHBhdGNoIHJldmVydGVkIGluIDUuMTQtcmMzIHNob3dz
IHRoYXQgdGhpcyBwYXRjaCBtYXkgYmUgcmVzcG9uc2libGUgZm9yIGlTZXIgQ0kgcmVncmVzc2lv
bnMgdGhlcmUgYXMgd2VsbC4NCg0KTWlrZQ0K
