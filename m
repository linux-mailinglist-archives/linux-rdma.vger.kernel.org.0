Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4141B125990
	for <lists+linux-rdma@lfdr.de>; Thu, 19 Dec 2019 03:22:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726700AbfLSCWh (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 18 Dec 2019 21:22:37 -0500
Received: from mail-eopbgr150070.outbound.protection.outlook.com ([40.107.15.70]:29367
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726463AbfLSCWh (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 18 Dec 2019 21:22:37 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gm+PrasuA3C8hfZSxkFnj3B2bLdm548M2musEI99eATKAE8ykNOegN9GZ2yoU752IdpOCVPtZBI/la5oG9MrKWD6420n4H4YpJptaqLkCig08QtN8/J+4Ga8WSko2GS+jjwBqI8uE0CuTXXwQlL6XNRPAj6XpoMgU+OZNDH5mv/Sai4re5oLBVeHj08wrZ9fdF/HfXWRN5k4GizH1MVEUrrnkRGUI0/R2C0TuT9gM3gRClmTEISYPekHDreCR4FxCpsH8byycIjHPeEZAyAdmUjzXp0JLONsbI++6YEBQp3gstWoz6En5jV1cv6sfRnLFI+xP6Tk/zNKYklup+vCoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9JHW2+W46af974hckrwfguneoJCs78BgaHbpBS8xHFQ=;
 b=fZP490BYfvgWqGFLEAG8bKSKtE1wergTFQGWHJdmxGtFZi+T2vJ+JzmGbmwmxBrBVXakRo2GrzkJi7bI5Snq4nTFk5Ka7rLFcFigPYrAKiH7UbR4jeZRO+LAa0xDiLjv/JnFR4u08g6bRHYRIypSty48zCEeV0gLLq1QxmikVOY6pxZkFkMsK8qYgEpkrGFiMBiPK5PD/UWa28+RLtZW6yVxfExiQPpQee5fbRDWOQ1XcIWl16r4CpWjWsN+w7RBF0pkG+sMX1Tku9Q1RVD3LzP4/wQZEtBWjI75pOdbdzVH8y+oY2ykc+k7PjNBBxiK5med2/+WNHXcQhCaJ5BScg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mellanox.com; dmarc=pass action=none header.from=mellanox.com;
 dkim=pass header.d=mellanox.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9JHW2+W46af974hckrwfguneoJCs78BgaHbpBS8xHFQ=;
 b=rIyGLTauOMIdUxEmh9GfzBYG3400ttflm1rMCM/FZmCaQS/XOYsnQFsLmXOkacnhxnc14l04QtRocc4WriNHFJbpLV/+K8Vox341cimNIiFl4i/DZFpv0B9VdfJdl9e5hNrK/IvVCxKj17/iHI5cLS2cqPngOCQ0XznpxxP81Zk=
Received: from AM0PR05MB4866.eurprd05.prod.outlook.com (20.176.214.160) by
 AM0PR05MB6721.eurprd05.prod.outlook.com (10.141.190.17) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2538.14; Thu, 19 Dec 2019 02:22:34 +0000
Received: from AM0PR05MB4866.eurprd05.prod.outlook.com
 ([fe80::16:9951:5a4b:9ec6]) by AM0PR05MB4866.eurprd05.prod.outlook.com
 ([fe80::16:9951:5a4b:9ec6%7]) with mapi id 15.20.2538.019; Thu, 19 Dec 2019
 02:22:34 +0000
From:   Parav Pandit <parav@mellanox.com>
To:     Jason Gunthorpe <jgg@ziepe.ca>,
        Selvin Xavier <selvin.xavier@broadcom.com>
CC:     "dledford@redhat.com" <dledford@redhat.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Devesh Sharma <devesh.sharma@broadcom.com>
Subject: Re: [PATCH for-next v2 1/2] IB/core: Add option to retrieve driver
 gid context from ib_gid_attr
Thread-Topic: [PATCH for-next v2 1/2] IB/core: Add option to retrieve driver
 gid context from ib_gid_attr
Thread-Index: AQHVs9joIC1ino5CSUSDDFqQZLjadqe/8ZSAgADNEYA=
Date:   Thu, 19 Dec 2019 02:22:34 +0000
Message-ID: <903a4154-8237-0178-dc5f-34c58fa06aaa@mellanox.com>
References: <1576477201-2842-1-git-send-email-selvin.xavier@broadcom.com>
 <1576477201-2842-2-git-send-email-selvin.xavier@broadcom.com>
 <20191218140835.GG17227@ziepe.ca>
In-Reply-To: <20191218140835.GG17227@ziepe.ca>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=parav@mellanox.com; 
x-originating-ip: [106.51.20.239]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 3a5f09ed-2ece-4c6c-682e-08d7842a4f0b
x-ms-traffictypediagnostic: AM0PR05MB6721:
x-microsoft-antispam-prvs: <AM0PR05MB67218497B2611F7F8BDBF03BD1520@AM0PR05MB6721.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 0256C18696
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(396003)(136003)(346002)(376002)(39860400002)(366004)(189003)(199004)(4326008)(186003)(66446008)(64756008)(66556008)(66476007)(4744005)(6506007)(53546011)(55236004)(26005)(6486002)(71200400001)(6512007)(66946007)(478600001)(76116006)(91956017)(316002)(36756003)(8676002)(110136005)(54906003)(31686004)(5660300002)(2906002)(31696002)(86362001)(2616005)(8936002)(81156014)(81166006);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR05MB6721;H:AM0PR05MB4866.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ikkaLIiSMOpRun+/dwma1ZcNOtTdW39wgZx7Oky0PEn35Fweu8VquPVCxKxqcLbnt6U9X75QvYZ11kUaBl7+b68KJq6U4oXc02RtPa86bAx3C0TG49CWrp8qWT2USLfrATdX6j5ABnByMpwbYHxA6LnAqPnPRopYbHbDZ42o+1THsGeNEYz8+qj4d4yAOJqr5JAHofWKS/0OoYWtPFW0hDo6uZaqn9/aQmIf3bC0H+e/V6aYIrKGHxDfnnfrfnk63tlliIACDJ0Em2j1Zz9UpfajVJ9VkioBXfHjiki/G/f+GUdbAA3M59r9hvtHFxp/lznW2rTIMAAyMZ9XgmKG2/I27Ioxo3giK6P7p2bExveiIfUZt4V7m/9GAhLTPp1w9JXykPcBQtqf1beOaR3Di+2OCumm7X/fnO9SDkGIlrLOPrw4p9BD+LFdUHjJZJjs
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <8CC3149788D1E94E9884B57862C3698E@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a5f09ed-2ece-4c6c-682e-08d7842a4f0b
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Dec 2019 02:22:34.5005
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bZT0SvJWolXO9h+qZbadFRgr+soyZFDEkd6iHqj5cdkQqARuNi0xys/2fQ/0K5yJalVmFnHTJhXZHLbwcqyuXA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR05MB6721
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

T24gMTIvMTgvMjAxOSA3OjM4IFBNLCBKYXNvbiBHdW50aG9ycGUgd3JvdGU6DQo+IE9uIFN1biwg
RGVjIDE1LCAyMDE5IGF0IDEwOjIwOjAwUE0gLTA4MDAsIFNlbHZpbiBYYXZpZXIgd3JvdGU6DQo+
PiBQcm92aWRlIGFuIG9wdGlvbiB0byByZXRyaWV2ZSB0aGUgZHJpdmVyIGdpZCBjb250ZXh0IGZy
b20gaWJfZ2lkX2F0dHINCj4+IHN0cnVjdHVyZS4gSW50cm9kdWNlIGliX2dpZF9hdHRyX2luZm8g
c3RydWN0dXJlIHdoaWNoIGluY2x1ZGUgYm90aA0KPj4gZ2lkX2F0dHIgYW5kIHRoZSBHSUQncyBI
VyBjb250ZXh0LiBSZXBsYWNlIHRoZSBhdHRyIGFuZCBjb250ZXh0DQo+PiBtZW1iZXJzIG9mIGli
X2dpZF90YWJsZV9lbnRyeSB3aXRoIHRoZSBuZXcgaWJfZ2lkX2F0dHJfaW5mbw0KPj4gc3RydWN0
dXJlLiBWZW5kb3IgZHJpdmVycyBjYW4gcmVmZXIgdG8gaXRzIG93biBIVyBnaWQgY29udGV4dA0K
Pj4gdXNpbmcgdGhlIGNvbnRhaW5lcl9vZiBtYWNyby4NCj4gDQo+IFRoaXMgc2VlbXMgcmVhbGx5
IHdlaXJkLiBXaHkgYXJlIHdlIGFkZGluZyBhIG5ldyBzdHJ1Y3QgaW5zdGVhZCBvZg0KPiBhZGRp
bmcgY29udGV4dCB0byB0aGUgbm9ybWFsIGdpZF9hdHRyLCBvciBhZGRpbmcgc29tZQ0KPiAnZ2V0
X2liX2F0dHJfcHJpdicgY2FsbD8NCg0KUmVzdCBvZiB0aGUgc3RhY2sgZGlkbid0IG5lZWQgdG8g
dG91Y2ggY29udGV4dCwgc28gaXQgaXMgYWRkZWQgb25seSBhcw0KdmVuZG9yIGRyaXZlciBmYWNp
bmcgY29udGFpbmVyX29mKCkuDQoNCkluc3RlYWQgSSBndWVzcyBhIG5ldyBzeW1ib2wgYXMgcmRt
YV9nZXRfZ2lkX2F0dHJfY29udGV4dCgpIGNhbiBiZSBhZGRlZA0KdG9vLg0K
