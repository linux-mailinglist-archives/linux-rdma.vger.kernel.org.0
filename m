Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1D3C4105349
	for <lists+linux-rdma@lfdr.de>; Thu, 21 Nov 2019 14:38:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726554AbfKUNiy (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 21 Nov 2019 08:38:54 -0500
Received: from mail-eopbgr10059.outbound.protection.outlook.com ([40.107.1.59]:25650
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726532AbfKUNix (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 21 Nov 2019 08:38:53 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AnpRpXbdpzhucvmMTjcD4FQz6VS9xQSk7befPccR+h8woQ4b5vVhoXZxvM80UdKx9LdUxy4Z1B7rYUY1mwfG+GJyn7Wv3d+ctNTsWoTVxwxyYCPanZwlbCaeyrfnZqW578liLh/QSwoH4dVU2bype93ZW0vk2cTXXa5YOB/ml/HdpVLGO6UNLwsaVLcLH7Qrav0+PahcFqQn9Ncq0zBkZRvVkb920UEvH/nPQ/HUbRd2aj3MIej4O8c193iHgz+G1+HctxbsRs9wAf11QBJ9UtzgpD4ap9uFEebQXE8JjwUMJ+Sr5CZj2mOpMg0ZvhTUcLaskJCuegKI8c2wfG9rkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cY4q9UEMZZkqYIHlgGnJJy5bsix1Ex2jmf2K3PxFmbM=;
 b=cPb47mUt/jJ4HLwXYQZECyUmN9oFou/nlAtWoz1AiYuX1ijKtprJgmVIX+2YTz/3vogxTitnqHFQ7N24aEChgkiU5Da6HmaBq3/F4KuGJ+ly5O3YcFs4WrMfUtGWcPy4pDrOuF/hEWPX0shkVgGBU9S1V6neLHyyfZKZjcjS9XBhCgNI3FpDrymtJMk8AojEhlOIDEsYetX59Y6T0PiiUuczmzrddFLixDurEMAWx0ApwcT894BdWQ/ytF+DPJmwmCONqRqHEgEr0mTmCmpyI6NUYpxYzaFRhXj3ITeQ3sFbQs2DWAfENQbMXucsgEVqOWp0AjqMGJEjzG3D5TncBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mellanox.com; dmarc=pass action=none header.from=mellanox.com;
 dkim=pass header.d=mellanox.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cY4q9UEMZZkqYIHlgGnJJy5bsix1Ex2jmf2K3PxFmbM=;
 b=F/lxChIScESzdizlowtJX6cB2rcRqYiGqn6xz4Y7HfvA1Ix6/TNbodawzGkmOhJlugS7VPmSmJCZ17B0i40+T4CLyou129JsFmlYyBpFwXC5q9ZE7YubMMwVKTxi4VHIJu7xfQU3qTZUgS+QwsU9TSUCP9LiBvR/rVOGcKTXHG0=
Received: from AM6PR05MB4167.eurprd05.prod.outlook.com (52.135.166.156) by
 AM6PR05MB6087.eurprd05.prod.outlook.com (20.179.0.81) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2474.17; Thu, 21 Nov 2019 13:38:50 +0000
Received: from AM6PR05MB4167.eurprd05.prod.outlook.com
 ([fe80::e9ad:6a8:bed8:306]) by AM6PR05MB4167.eurprd05.prod.outlook.com
 ([fe80::e9ad:6a8:bed8:306%5]) with mapi id 15.20.2474.019; Thu, 21 Nov 2019
 13:38:50 +0000
From:   Haggai Eran <haggaie@mellanox.com>
To:     Jason Gunthorpe <jgg@ziepe.ca>
CC:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Yishai Hadas <yishaih@mellanox.com>,
        Michael Guralnik <michaelgur@mellanox.com>
Subject: Re: [PATCH RFC rdma-core] verbs: relaxed ordering memory regions
Thread-Topic: [PATCH RFC rdma-core] verbs: relaxed ordering memory regions
Thread-Index: AQHVnRp3D2/R564WAkqHJj8pbuc4PKeS5RGAgALCq4A=
Date:   Thu, 21 Nov 2019 13:38:49 +0000
Message-ID: <ceb93ff8-80f0-f321-531f-4c534da38e07@mellanox.com>
References: <1573976488-24301-1-git-send-email-haggaie@mellanox.com>
 <20191119192919.GA16030@ziepe.ca>
In-Reply-To: <20191119192919.GA16030@ziepe.ca>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: AM4PR0501CA0055.eurprd05.prod.outlook.com
 (2603:10a6:200:68::23) To AM6PR05MB4167.eurprd05.prod.outlook.com
 (2603:10a6:209:4b::28)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=haggaie@mellanox.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [193.47.165.251]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 3b5e4933-9bf0-4da8-ecd1-08d76e882422
x-ms-traffictypediagnostic: AM6PR05MB6087:|AM6PR05MB6087:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM6PR05MB6087442B9297907826ADE724C14E0@AM6PR05MB6087.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-forefront-prvs: 0228DDDDD7
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(136003)(39860400002)(396003)(376002)(346002)(366004)(199004)(189003)(6116002)(8936002)(25786009)(8676002)(66946007)(66066001)(6246003)(99286004)(4326008)(86362001)(6486002)(53546011)(6506007)(386003)(4744005)(64756008)(54906003)(66446008)(3846002)(66556008)(14444005)(36756003)(71200400001)(71190400001)(107886003)(446003)(11346002)(2616005)(256004)(66476007)(26005)(81166006)(316002)(186003)(81156014)(2906002)(229853002)(6436002)(14454004)(6512007)(7736002)(102836004)(52116002)(478600001)(5660300002)(31696002)(305945005)(6916009)(31686004)(76176011);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR05MB6087;H:AM6PR05MB4167.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: AgnjvcPxYjKKOVFgUNf00NCKynNePI+Y4vT5Unvm4JOV60yld/xGxtLDoc/v/ppqtBHamUe4u6EJ5YIB+E49ALpR+ZSQChlTsmEoyFXNOE2KkwNxvhVSYbtdvsKl6zSMzktH2v5GSHpIWeBmvnldQeGQf5EmFPzgs3sn6qJ5wzmrzO0cqJhWd0uYfICyxFjoJRRvBqNVuT/rNimQhzhh5eNS+BCyEkKucwqb8KYX21wE23VXqGd18pX9TyBmX10uzqtg4k6hICtdQXnjCXTKmsXU0jx2s3IvtsV0jYP9DUMtgjR6ZgEs8ipR+euiHAsaTyIlBRKJeLz5YCwcRPy7QwZ6vq6wTnb3lVJ4PKcmB6gfV4iAYn6GzAVVxmd3i4IKyu0zruNOis8V+m65uweIvDbKQAXOkO7/c/q108shOH9x9gmnzmnBTTI5PM8bQ/ld
Content-Type: text/plain; charset="utf-8"
Content-ID: <0957FCBE4185B3429002E0FD38C281A7@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b5e4933-9bf0-4da8-ecd1-08d76e882422
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Nov 2019 13:38:49.9419
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7d27Y+Iqg0ulguIPt4CPLVhsKsJNnqh/y0VBkQwlxOUHDGBKC45ZpZ/hQfzAocXfT6oGOL1rKU570yPAC+QyuQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR05MB6087
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

T24gMTEvMTkvMjAxOSA5OjI5IFBNLCBKYXNvbiBHdW50aG9ycGUgd3JvdGU6DQo+IE9uIFN1biwg
Tm92IDE3LCAyMDE5IGF0IDA5OjQxOjI4QU0gKzAyMDAsIEhhZ2dhaSBFcmFuIHdyb3RlOg0KPj4g
Ky8qIFVzZSB0aGUgbmV3IHZlcnNpb24gb2YgaWJ2X3JlZ19tciBvbmx5IGlmIGZsYWdzIHRoYXQg
cmVxdWlyZSBpdCBhcmUgdXNlZC4gKi8NCj4+ICsjZGVmaW5lIGlidl9yZWdfbXIocGQsIGFkZHIs
IGxlbmd0aCwgYWNjZXNzKSAoe1wNCj4+ICsJY29uc3QgaW50IG9wdGlvbmFsX2FjY2Vzc19mbGFn
cyA9IElCVl9BQ0NFU1NfUkVMQVhFRF9PUkRFUklORzsNCj4+IFwNCj4gDQo+IFdlIG5lZWQgdG8g
c2V0IGFzaWRlIG1vcmUgYml0cyBmb3Igb3B0aW9uYWwgYXMgd2UgY2FuJ3Qga2VlcCByZXZpc2lu
Zw0KPiB0aGlzDQoNClN1cmUuIElzIDEwIGJpdHMgb2theT8NCg0KI2RlZmluZSBJQlZfQUNDRVNT
X09QVElPTkFMICgoMSA8PCAxMCkgLSAxKSA8PCA4DQoNCj4gDQo+PiArCXN0cnVjdCBpYnZfbXIg
Kl9fbXI7IFwNCj4+ICsJXA0KPj4gKwlpZiAoX19idWlsdGluX2NvbnN0YW50X3AoYWNjZXNzKSAm
JiBcDQo+PiArCSAgICAhKChhY2Nlc3MpICYgb3B0aW9uYWxfYWNjZXNzX2ZsYWdzKSkgXA0KPj4g
KwkJX19tciA9IGlidl9yZWdfbXIocGQsIGFkZHIsIGxlbmd0aCwgYWNjZXNzKTsgXA0KPj4gKwll
bHNlIFwNCj4+ICsJCV9fbXIgPSBpYnZfcmVnX21yX2lvdmEyKHBkLCBhZGRyLCBsZW5ndGgsICh1
aW50cHRyX3QpYWRkciwgXA0KPj4gKwkJCQkJYWNjZXNzKTsgXA0KPiANCj4gTWlzc2luZyBicmFj
a2V0cyBhcm91bmQgYWRkcg0KPiANCj4gVGhpcyBhbHNvIHdhbnRzIHRvIGJlIGEgPzogZXhwcmVz
c2lvbiB0byBhdm9pZCB0aGUgKHt9KSBleHRlbnNpb24NClN1cmUsIEknbGwgZG8gdGhhdC4NCg0K
VGhhbmtzLA0KSGFnZ2FpDQo=
