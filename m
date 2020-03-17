Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DC2281890BE
	for <lists+linux-rdma@lfdr.de>; Tue, 17 Mar 2020 22:47:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726730AbgCQVrs (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 17 Mar 2020 17:47:48 -0400
Received: from mail-dm6nam10on2137.outbound.protection.outlook.com ([40.107.93.137]:22874
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726388AbgCQVrs (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 17 Mar 2020 17:47:48 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hYDwdkdKSMkq6D9WeUgcm/kQz+RahGmox/sJHNxibQo04JJZpN5VKWCA9usOMWekUzWz6uUQpL7MiDEDiwVwYhStzrfNdwxkqUWwC5OxE/s1oJcKjRm4ru5qjSEKdCHiDgrepHMR+5NwimtoL7SJ8wEJQELMBLyK26gPBAX0juyk58U+b39K3mbIaAAaSj9Gs07x3ZOBZArmVr2k1eQYRrAAInbfZd+PgUF7OPscGOA1zWjZZXH1IgA7GNWEUyCHs0RXfbMPO0xNwUj7Rgud4MVnUd4Q8qxrzVx4dH97rFtY+MBE8c06SWrMNdc+Ya3tXCkx/mI1hC7EShNClGtcMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CwVOhu3pAPOVrQlzNqNgb2e7Y+JAQ+18ssauC/5cvG4=;
 b=Z0DI45fsfRjBZuoOYDJdADFJyODqz7ayEqZSZLNU7vQ5RsPxI4+KgX/wlbr+ir0j8aTpqJtI5GUSAiQBHfettPr0EZPeQzuvHpF+algNy+FA9Jwx4sMH442SsodOSKWnC0EY0prF/V7ntyheJ5T7nwvVcsBk+NudtlKk7EdtGdBPAoRTD1thHh0+sBrATb46yKJyafnDpaWsxQbXKCh7KrTZkuI7N4rukOFiuRSam/2dSl9A9mGdkE7wzC2zl/KU33HMokhj1mEBSRcj9a1wwvz0EaGDsm32KWMp1G3VFQDDdBgrMtI1QYR68socf/kXCUiL5Kc04t/IRBAwMd9cxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CwVOhu3pAPOVrQlzNqNgb2e7Y+JAQ+18ssauC/5cvG4=;
 b=RoP0BlQo+1ulwIUgygGLbY7jkE89dsnj6DN9+BOYXH37E5NbU6fN5Q56XktNPYE1A2dKeVy2N3NzM5ZuGSgp5U8UTz9h969yYiDOWEJ9jcSLzhK/A79YSTQfQOga9tqTmW1pSIwflgzqMxLJwFgcyB01XT6y705+PNXqE0yGni0=
Received: from BYAPR21MB1223.namprd21.prod.outlook.com (2603:10b6:a03:107::14)
 by BYAPR21MB1639.namprd21.prod.outlook.com (2603:10b6:a02:cb::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2835.2; Tue, 17 Mar
 2020 21:47:44 +0000
Received: from BYAPR21MB1223.namprd21.prod.outlook.com
 ([fe80::8d1f:f622:2bc1:a518]) by BYAPR21MB1223.namprd21.prod.outlook.com
 ([fe80::8d1f:f622:2bc1:a518%8]) with mapi id 15.20.2856.001; Tue, 17 Mar 2020
 21:47:44 +0000
From:   Ju-Hyoung Lee <juhlee@microsoft.com>
To:     Mark Bloch <markb@mellanox.com>, Jason Gunthorpe <jgg@ziepe.ca>
CC:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Ju-Hyoung Lee <juhlee@microsoft.com>
Subject: RE: [EXTERNAL] Re: Find rdma-core version
Thread-Topic: [EXTERNAL] Re: Find rdma-core version
Thread-Index: AdX8G/w1CIvOVTxSRQyfs/GZbAPOgwAeKZaAAAOjc5AAAEtsAAAATO6Q
Date:   Tue, 17 Mar 2020 21:47:44 +0000
Message-ID: <BYAPR21MB12234A2E5A2C7199518EF360DAF60@BYAPR21MB1223.namprd21.prod.outlook.com>
References: <BYAPR21MB1223A416AA7FE380D8DDFFC9DAF60@BYAPR21MB1223.namprd21.prod.outlook.com>
 <20200317194539.GW20941@ziepe.ca>
 <BYAPR21MB1223AC2B4C82BC7287D3665FDAF60@BYAPR21MB1223.namprd21.prod.outlook.com>
 <f6b69016-c578-2720-6976-89d588cff768@mellanox.com>
In-Reply-To: <f6b69016-c578-2720-6976-89d588cff768@mellanox.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=juhlee@microsoft.com; 
x-originating-ip: [2601:1c2:4b00:8ff0:9b9:5798:e241:7820]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 8de9f5fe-5d1e-4644-0a3a-08d7cabcd35f
x-ms-traffictypediagnostic: BYAPR21MB1639:|BYAPR21MB1639:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR21MB16391B24D07E351DCD953999DAF60@BYAPR21MB1639.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-forefront-prvs: 0345CFD558
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(39860400002)(376002)(396003)(346002)(366004)(136003)(199004)(4326008)(107886003)(33656002)(5660300002)(186003)(52536014)(55016002)(9686003)(6506007)(2906002)(53546011)(71200400001)(54906003)(10290500003)(81166006)(81156014)(8676002)(478600001)(110136005)(7696005)(8936002)(76116006)(8990500004)(66476007)(66556008)(66946007)(316002)(66446008)(86362001)(64756008);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR21MB1639;H:BYAPR21MB1223.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: UoBNkOOmdq2P97s5Otan4ZWslhZMo6hHDgCn/Apr3HmiP8G2GIN0iVeg90tWhgDUoPjCZ/VydTBB0tnHSYGR/ABnRFWyXUfzfXdpCvx8nJetKa4nOjRNd6v5zFr8Vq3MOwXWhmAU6QPVe7qLTkmDnHXIZ1KyGHcz8E/L5IxJz9bTtwl8IklY4P+K11pv3I2LhnTFk3T6OPxkC0qa11A+Nv6DIxr06F1cteU9fLc4APz1Ujj5KwUpt6AXogDNWSNdacN1QnWKRpcqi/7j/mErur7RoR+uKqcuxMjtbxSm50wCSy6PP90BApvE8XGdkoChmtvpQ/KSP+8UpW+u7lcEYBB4sTSzLdiicz2V5GEdr7rgqjtZNQXvjMA8jRUcWibpKNm29stdl+NKEF69VvhKzulNfuzoiTpscKaY6NuTYxeN2aXfKO2bBG0B5zrPtRkc
x-ms-exchange-antispam-messagedata: VJyEwJVjFcZROOg3SdtDDzFo47RXsARFCH6CS4gPcGMy9aHfYTNjSl2zE/G69tcodjmHMOzS7NefdRsFV7O6NKuiIKUl9jB8CSQIBkkV6hKI5eD1+MUAxr5rwDGUp1iGmgdkX6Bcaq9Owrs8oU5yzfhw9wbp3jZSy59U5g1L+idYqiRKwbQyccFp7Fdazj8/MjS0fxsLbi86AH3MHOw/4w==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8de9f5fe-5d1e-4644-0a3a-08d7cabcd35f
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Mar 2020 21:47:44.3399
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: i15ONFTA6dBPEW94PUdIP+0LOTZLP887/BFbpwlavcqQkJUkUt+KdBvbcLnjNWHqpkfkn+hcv0ZcOmRacSBGIw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR21MB1639
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

QXdlc29tZSwgTWFyay4gVGhhbmsgeW91LiANCkl0IG1ha2VzIHNlbnNlIHRoZW4sIEkgc2hvdWxk
IHJlcGxhY2UgYSBuZXcgbGluayB0byB0aGUgZmlyc3QgcGxhY2Ugd2l0aCBuZXcgdmVyc2lvbi4N
Cg0KZGVwZW5kZW5jeS12bTp+L3JkbWEtY29yZS0yOC4wICMgbHMgLWFsIC9yb290L3JkbWEtY29y
ZS0yOC4wL2J1aWxkL2xpYi9saWJpYnZlcmJzLnNvLjENCmxyd3hyd3hyd3ggMSByb290IHJvb3Qg
MjIgTWFyIDE3IDIwOjU5IC9yb290L3JkbWEtY29yZS0yOC4wL2J1aWxkL2xpYi9saWJpYnZlcmJz
LnNvLjEgLT4gbGliaWJ2ZXJicy5zby4xLjguMjguMA0KDQpKdQ0KLS0tLS1PcmlnaW5hbCBNZXNz
YWdlLS0tLS0NCkZyb206IE1hcmsgQmxvY2ggPG1hcmtiQG1lbGxhbm94LmNvbT4gDQpTZW50OiBU
dWVzZGF5LCBNYXJjaCAxNywgMjAyMCAyOjM4IFBNDQpUbzogSnUtSHlvdW5nIExlZSA8anVobGVl
QG1pY3Jvc29mdC5jb20+OyBKYXNvbiBHdW50aG9ycGUgPGpnZ0B6aWVwZS5jYT4NCkNjOiBsaW51
eC1yZG1hQHZnZXIua2VybmVsLm9yZw0KU3ViamVjdDogUmU6IFtFWFRFUk5BTF0gUmU6IEZpbmQg
cmRtYS1jb3JlIHZlcnNpb24NCg0KSGV5IEp1LA0KDQpPbiAzLzE3LzIwIDI6MzIgUE0sIEp1LUh5
b3VuZyBMZWUgd3JvdGU6DQo+IE15IG9yaWdpbmFsICByZG1hLWNvcmUgdmVyc2lvbiB3YXMgMjIg
dGhlbiBidXQgaXQgc3RpbGwgc2hvd3MgYWZ0ZXIgaW5zdGFsbGVkIHJkbWEtY29yZS0yOC4NCj4g
DQo+IFRoaXMgaXMgbXkgbG9nIG9mIHRoZSBvcmlnaW5hbCBzdGF0ZS4NCj4gZGVwZW5kZW5jeS12
bTp+ICMgbGRkIGB3aGljaCBpYnZfZGV2aWNlc2ANCj4gICAgICAgICBsaW51eC12ZHNvLnNvLjEg
KDB4MDAwMDdmZmRlYjdlYzAwMCkNCj4gICAgICAgICBsaWJpYnZlcmJzLnNvLjEgPT4gL3Vzci9s
aWI2NC9saWJpYnZlcmJzLnNvLjEgKDB4MDAwMDdmNjhjN2VjZDAwMCkNCj4gICAgICAgICBsaWJj
LnNvLjYgPT4gL2xpYjY0L2xpYmMuc28uNiAoMHgwMDAwN2Y2OGM3YjEyMDAwKQ0KPiAgICAgICAg
IGxpYm5sLXJvdXRlLTMuc28uMjAwID0+IC91c3IvbGliNjQvbGlibmwtcm91dGUtMy5zby4yMDAg
KDB4MDAwMDdmNjhjNzg5YzAwMCkNCj4gICAgICAgICBsaWJubC0zLnNvLjIwMCA9PiAvdXNyL2xp
YjY0L2xpYm5sLTMuc28uMjAwICgweDAwMDA3ZjY4Yzc2N2EwMDApDQo+ICAgICAgICAgbGlicHRo
cmVhZC5zby4wID0+IC9saWI2NC9saWJwdGhyZWFkLnNvLjAgKDB4MDAwMDdmNjhjNzQ1YjAwMCkN
Cj4gICAgICAgICBsaWJkbC5zby4yID0+IC9saWI2NC9saWJkbC5zby4yICgweDAwMDA3ZjY4Yzcy
NTcwMDApDQo+ICAgICAgICAgL2xpYjY0L2xkLWxpbnV4LXg4Ni02NC5zby4yICgweDAwMDA3ZjY4
YzgyZTkwMDApIA0KPiBkZXBlbmRlbmN5LXZtOn4gIyBscyAtYWwgL3Vzci9saWI2NC9saWJpYnZl
cmJzLnNvLjEgbHJ3eHJ3eHJ3eCAxIHJvb3QgDQo+IHJvb3QgMjIgRGVjICA5IDEyOjMxIC91c3Iv
bGliNjQvbGliaWJ2ZXJicy5zby4xIC0+IA0KPiBsaWJpYnZlcmJzLnNvLjEuNS4yMi41IGRlcGVu
ZGVuY3ktdm06fiAjDQo+IA0KPiBBZnRlciBidWlsZC5zaCBpbiByZG1hLWNvcmUtMjguMCwNCg0K
YnVpbGQuc2ggYnVpbGRzIHJkbWEtY29yZSBsb2NhbGx5IGFuZCBkb2Vzbid0IGluc3RhbGwgaXQg
aW4gdGhlIHN5c3RlbS4NCg0KeW91IGNhbiBkbzogbHMgLWFsIGJ1aWxkL2xpYi9saWJpYnZlcmJz
LnNvLjEgbm90ZSB5b3UgY2FuIGFsc28gcnVuIHRoZSBiaW5hcmllcyB0aGlzIHdheSwgZm9yIGV4
YW1wbGUgZnJvbSB0aGUgcm9vdCByZG1hLWNvcmUgZGlyOg0KLi9idWlsZC9iaW4vaWJ2X2Rldmlu
Zm8NCg0KTWFyaw0KDQo+IA0KPiBkZXBlbmRlbmN5LXZtOn4vcmRtYS1jb3JlLTI4LjAgIyBscyAt
YWwgL3Vzci9saWI2NC9saWJpYnZlcmJzLnNvLjEgDQo+IGxyd3hyd3hyd3ggMSByb290IHJvb3Qg
MjIgRGVjICA5IDEyOjMxIC91c3IvbGliNjQvbGliaWJ2ZXJicy5zby4xIC0+IA0KPiBsaWJpYnZl
cmJzLnNvLjEuNS4yMi41DQo+IA0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9t
OiBKYXNvbiBHdW50aG9ycGUgPGpnZ0B6aWVwZS5jYT4NCj4gU2VudDogVHVlc2RheSwgTWFyY2gg
MTcsIDIwMjAgMTI6NDYgUE0NCj4gVG86IEp1LUh5b3VuZyBMZWUgPGp1aGxlZUBtaWNyb3NvZnQu
Y29tPg0KPiBDYzogbGludXgtcmRtYUB2Z2VyLmtlcm5lbC5vcmcNCj4gU3ViamVjdDogW0VYVEVS
TkFMXSBSZTogRmluZCByZG1hLWNvcmUgdmVyc2lvbg0KPiANCj4gT24gVHVlLCBNYXIgMTcsIDIw
MjAgYXQgMDU6MjM6MjhBTSArMDAwMCwgSnUtSHlvdW5nIExlZSB3cm90ZToNCj4+IEhpLA0KPj4N
Cj4+IENhbiBhbnlvbmUgaGVscCBtZSBmaW5kIHdoYXQgcmRtYS1jb3JlIHZlcnNpb24gSSBpbnN0
YWxsZWQgaW4gdGhlIA0KPj4gc3lzdGVtPyBJdCdzIGEgc2V0IG9mIGxpYiBhbmQgdXRpbGl0aWVz
LCBidXQgdGhlcmUgbWlnaHQgYmUgYSB3YXkgSSANCj4+IGNhbiB2ZXJpZnkgdGhlIHZlcnNpb24g
YWZ0ZXIgdGhlIG9mZmljaWFsIHJlbGVhc2UgaW5zdGFsbGF0aW9uLiAgQW55IA0KPj4gaGVscD8N
Cj4gDQo+ICQgbGRkIGB3aGljaCBpYnZfZGV2aW5mb2ANCj4gCWxpbnV4LXZkc28uc28uMSAoMHgw
MDAwN2ZmYzYzYmQ2MDAwKQ0KPiAJbGliaWJ2ZXJicy5zby4xID0+IC9saWI2NC9saWJpYnZlcmJz
LnNvLjEgKDB4MDAwMDdmM2RlNjdjNDAwMCkgWy4uXQ0KPiANCj4gJCBscyAtbCAvbGliNjQvbGli
aWJ2ZXJicy5zby4xDQo+IGxyd3hyd3hyd3ggMSByb290IHJvb3QgMjIgTWFyICA2IDE5OjQzIC9s
aWI2NC9saWJpYnZlcmJzLnNvLjEgLT4gbGliaWJ2ZXJicy5zby4xLjcuMjcuMCoNCj4gICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgIA0KPiBeXl5eDQo+IA0KPiByZG1hLWNvcmUgdmVyc2lvbiBpcyAy
Nw0KPiANCj4gSmFzb24NCj4gDQo=
