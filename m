Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CEDBF15D057
	for <lists+linux-rdma@lfdr.de>; Fri, 14 Feb 2020 04:11:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728052AbgBNDLx (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 13 Feb 2020 22:11:53 -0500
Received: from mail-am6eur05on2078.outbound.protection.outlook.com ([40.107.22.78]:18480
        "EHLO EUR05-AM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728004AbgBNDLx (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 13 Feb 2020 22:11:53 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XKjfq4EtwasYj9+Iuz1ZlsqRPTU5WIZyQ6PVlxnzWjjX6EpWItb2sJorGtWxasB+pE3gcwHsJvTb8lzsVb1OqcoyaPRq6G83HAs5PP0Uu+wBhMH/+AZAVC+IBiqoGzESweClEJMfH/Dz9WkAq5xxgkF1GdIle+UOMuqVL0UYCEhrxEz8jPRXju8tSrDTEHabL+hE7py8qBPkaJVo33+fxfKXNN5e9VuOZyXVUJBFjTcxpIRpBSoXIUeekejhdZh87JAkIptx61UiVb3mO/AztHFXjSq5M43ObQVJUk3NN2aqlUV5bD6kiKicN9PpWyHYMKrIZGLCQ88ik2XsS2YYew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WtyFPtIGoM+J5fCUIrrEFYp2JhoHzdu7JOePsxtiU0s=;
 b=kMIfJii4Uwr9ULJN/V39YEBlK8/JMLfUrARwTdY5MLI+H1zZCybNRwyWkFzOS03FQtcLnYDDVo0J2FWeNpkKHJOc6iwNB7yE90Q8+AQ/blAMMIXHNyyebH0fa9dGq/eixgkiEPJt5dtW8nIXk3UNQ8KFs4biRsMPNXK0FH0HHXLs9Mx5IQ9TXijmR+uOptoRQCr08V37cm6QX7cpLvruEUy7eO7aBfSHA5LwfmgZ4kgKsGAKgRr0RyvGjjMOkhZmXSn+y4ycklrAVWwgEe1vjzvmDxaa1ffIkE8Zcsg7opfUgEBymcm4FfhMMXdKPrSIsK9vwupCgKe0Ouh6K3o4hw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mellanox.com; dmarc=pass action=none header.from=mellanox.com;
 dkim=pass header.d=mellanox.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WtyFPtIGoM+J5fCUIrrEFYp2JhoHzdu7JOePsxtiU0s=;
 b=QMJGbwf9i9leBp+7E1NLwKEnwDvtLmqisBkzN8q0f23qS77epb7djiy95rKe5fr1dnP+FPDhF+FoKS2afg3SZiOYr7Rpdkk1dKcaJK7qeBL+H4w8kgtOm2aBs+KKtyPu0TQibhJhutqaRch0VnbfPucahgOcRcn1ZQO7tStST4Q=
Received: from AM0PR05MB4866.eurprd05.prod.outlook.com (20.176.214.160) by
 AM0PR05MB4227.eurprd05.prod.outlook.com (52.134.125.20) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2707.23; Fri, 14 Feb 2020 03:11:49 +0000
Received: from AM0PR05MB4866.eurprd05.prod.outlook.com
 ([fe80::8c4:e45b:ecdc:e02b]) by AM0PR05MB4866.eurprd05.prod.outlook.com
 ([fe80::8c4:e45b:ecdc:e02b%7]) with mapi id 15.20.2729.025; Fri, 14 Feb 2020
 03:11:48 +0000
From:   Parav Pandit <parav@mellanox.com>
To:     Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>
CC:     Doug Ledford <dledford@redhat.com>,
        Leon Romanovsky <leonro@mellanox.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Daniel Jurgens <danielj@mellanox.com>,
        Erez Shitrit <erezsh@mellanox.com>,
        Maor Gottlieb <maorg@mellanox.com>,
        Michael Guralnik <michaelgur@mellanox.com>,
        Moni Shoua <monis@mellanox.com>,
        Sean Hefty <sean.hefty@intel.com>,
        Valentine Fatiev <valentinef@mellanox.com>,
        Yishai Hadas <yishaih@mellanox.com>,
        "Yonatan Cohen (SW)" <yonatanc@mellanox.com>,
        Yanjun Zhu <yanjunz@mellanox.com>
Subject: Re: [PATCH rdma-rc 3/9] Revert "RDMA/cma: Simplify
 rdma_resolve_addr() error flow"
Thread-Topic: [PATCH rdma-rc 3/9] Revert "RDMA/cma: Simplify
 rdma_resolve_addr() error flow"
Thread-Index: AQHV4XXZDpMNYi4JcEeEoEwaOCBrJagZILUAgADlW4A=
Date:   Fri, 14 Feb 2020 03:11:48 +0000
Message-ID: <c0e73246-a421-5619-a7e6-f955612fd1b9@mellanox.com>
References: <20200212072635.682689-1-leon@kernel.org>
 <20200212072635.682689-4-leon@kernel.org> <20200213133054.GA10333@ziepe.ca>
In-Reply-To: <20200213133054.GA10333@ziepe.ca>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=parav@mellanox.com; 
x-originating-ip: [68.203.16.89]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 939ec986-54bb-4807-7062-08d7b0fba17e
x-ms-traffictypediagnostic: AM0PR05MB4227:|AM0PR05MB4227:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM0PR05MB4227FA7E149DD67643BC72D2D1150@AM0PR05MB4227.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1002;
x-forefront-prvs: 03137AC81E
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(39860400002)(136003)(366004)(376002)(346002)(396003)(189003)(199004)(6506007)(53546011)(107886003)(6512007)(4326008)(71200400001)(81156014)(54906003)(36756003)(81166006)(186003)(110136005)(31696002)(26005)(6486002)(31686004)(86362001)(5660300002)(2616005)(66556008)(8936002)(8676002)(64756008)(478600001)(2906002)(66476007)(91956017)(76116006)(66446008)(316002)(66946007);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR05MB4227;H:AM0PR05MB4866.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: KZAsp2CAQv/h/UhuVlelEsELeJyOsMpfFsT0rmONrUAiPcVe5EQE45bTELkum03SEZr5xd6nY/Otf0Wr25idrLwDtLKm72wlN7m89BN9LAsKDV9DIzB+R4Voa7VONMMUBoKuGXzVZro477Wjv90ZHmJdy2+pQ1m/9yq2Psy5NmYy9pnHtbLIclNSTjeskMucU+XPnHp0eEhAWgd0mJEDYRg61O+cFlMdiZE9pgwbUMT6r7D7c2/3Ouk/+0fUmwLYjY1mN9/ypVr4caoznJssitFOPvc7XFmLDRNUsuADbrgjOZfZB1jcW08bRv9ZCcK+rzu/7gxj9gdoEBaEAdbZH8hTr9D/Mt8AOHuxyIBz5XCpGeGC8JXoOht9AWt1TE7/ZIOQSmqwJ6uGoD0lo6Wa2iLTD8ZAULJXoGBcUAvAQhrd3O0C93fUtPsFoNxMN7LG
x-ms-exchange-antispam-messagedata: bMh8zG8hKkXwaaVxgvvCFp9676b/I5ZP9TUBnWqoOLnzZr3K3/R35gxTLkfR1tNGEm5TuU1606GOiCJHNSX9b/Kt8xzgW3kyRF4xYcvZDsHWDYoqEi8tJzkBSDAULlEukBmRdV7HgAJP8H8nLzZ+Vg==
Content-Type: text/plain; charset="utf-8"
Content-ID: <C81D74075FD3D1489032700577764CD6@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 939ec986-54bb-4807-7062-08d7b0fba17e
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Feb 2020 03:11:48.7823
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ITeUbo+Qu30xR9duOCyWnMrQF/DYscK8Q5KSHp4obK0JfAOS/77N8eypA6Vm+GSh929fmjJhFrHPXE02lZp/aw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR05MB4227
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

T24gMi8xMy8yMDIwIDc6MzAgQU0sIEphc29uIEd1bnRob3JwZSB3cm90ZToNCj4gT24gV2VkLCBG
ZWIgMTIsIDIwMjAgYXQgMDk6MjY6MjlBTSArMDIwMCwgTGVvbiBSb21hbm92c2t5IHdyb3RlOg0K
Pj4gRnJvbTogUGFyYXYgUGFuZGl0IDxwYXJhdkBtZWxsYW5veC5jb20+DQo+Pg0KPj4gVGhpcyBy
ZXZlcnRzIGNvbW1pdCAyMTlkMmU5ZGZkYTk0MzFiODA4YzI4ZDVlZmM3NGI0MDRiOTViNjM4Lg0K
Pj4NCj4+IEJlbG93IGZsb3cgcmVxdWlyZXMgY21faWRfcHJpdidzIGRlc3RpbmF0aW9uIGFkZHJl
c3MgdG8gYmUgc2V0dXANCj4+IGJlZm9yZSBwZXJmb3JtaW5nIHJkbWFfYmluZF9hZGRyKCkuDQo+
PiBXaXRob3V0IHdoaWNoLCBzb3VyY2UgcG9ydCBhbGxvY2F0aW9uIGZvciBleGlzdGluZyBiaW5k
IGxpc3QgZmFpbHMNCj4+IHdoZW4gcG9ydCByYW5nZSBpcyBzbWFsbCwgcmVzdWx0aW5nIGludG8g
cmRtYV9yZXNvbHZlX2FkZHIoKQ0KPj4gZmFpbHVyZS4NCj4gDQo+IEkgZG9uJ3QgcXVpdGUgdW5k
ZXJzdGFuZHMgdGhpcyAtIHdoYXQgaXMgIndoZW4gcG9ydCByYW5nZSBpcyBzbWFsbCIgPw0KPiAg
DQpUaGVyZSBpcyBzeXNmcyBrbm9iIHRvIHJlZHVjZSBzb3VyY2UgcG9ydCByYW5nZSB0byB1c2Ug
Zm9yIGJpbmRpbmcuDQpTbyBpdCBpcyBlYXN5IHRvIGNyZWF0ZSB0aGUgaXNzdWUgYnkgcmVkdWNp
bmcgcG9ydCByYW5nZSB0byBoYW5kZnVsIG9mIHRoZW0uDQoNCj4+IHJkbWFfcmVzb2x2ZV9hZGRy
KCkNCj4+ICAgY21hX2JpbmRfYWRkcigpDQo+PiAgICAgcmRtYV9iaW5kX2FkZHIoKQ0KPj4gICAg
ICAgY21hX2dldF9wb3J0KCkNCj4+ICAgICAgICAgY21hX2FsbG9jX2FueV9wb3J0KCkNCj4+ICAg
ICAgICAgICBjbWFfcG9ydF9pc191bmlxdWUoKSA8LSBjb21wYXJlZCB3aXRoIHplcm8gZGFkZHIN
Cj4gDQo+IERvIHlvdSB1bmRlcnN0YW5kIHdoeSBjbWFfcG9ydF9pc191bmlxdWUgaXMgZXZlbiB0
ZXN0aW5nIHRoZSBkc3RfYWRkcj8NCj4gSXQgc2VlbXMgdmVyeSBzdHJhbmdlLg0KDQptYV9wb3J0
X3VuaXF1ZSgpIHJldXNlcyB0aGUgc291cmNlIHBvcnQgYXMgbG9uZyBhcw0KZGVzdGluYXRpb24g
aXMgZGlmZmVyZW50IChkZXN0aW5hdGlvbiA9IGVpdGhlciBkaWZmZXJlbnQNCmRlc3QuYWRkciBv
ciBkaWZmZXJlbnQgZGVzdC5wb3J0IGJldHdlZW4gdHdvIGNtX2lkcyApLg0KDQpUaGlzIGJlaGF2
aW9yIGlzIHN5bm9ueW1vdXMgdG8gVENQIGFsc28uDQoNCj4gT3V0Ym91bmQgY29ubmVjdGlvbnMg
c2hvdWxkIG5vdCBhbGlhcyB0aGUgc291cmNlIHBvcnQgaW4gdGhlIGZpcnN0DQo+IHBsYWNlPz8N
Cj4NCkkgYmVsaWV2ZSBpdCBjYW4gYmVjYXVzZSBUQ1Agc2VlbXMgdG8gYWxsb3cgdGhhdCB0b28g
YXMgbG9uZyBkZXN0aW5hdGlvbg0KaXMgZGlmZmVyZW50Lg0KDQpJIHRoaW5rIGl0IGFsbG93cyBp
ZiBpdCByZXN1bHRzIGludG8gZGlmZmVyZW50IDQtdHVwbGUuDQo=
