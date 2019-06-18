Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4FE4E4AB8F
	for <lists+linux-rdma@lfdr.de>; Tue, 18 Jun 2019 22:19:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730341AbfFRUTw (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 18 Jun 2019 16:19:52 -0400
Received: from mail-eopbgr50043.outbound.protection.outlook.com ([40.107.5.43]:52855
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730176AbfFRUTw (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 18 Jun 2019 16:19:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N4p31Pc6fI6EzWmWRihPyXPyp0ocak9w0gH7wHzBI5k=;
 b=OPZRrMEEp4fEZUAF3YPJqR7GQdXwFL6Y8tOHTZvs0adg85L0FoQoiwZ3NwtTKYOohDEted0lEtJofJQMs9v+A7FuduYwNilFIVv6DozdnRJGlZ08gjCy8sQocb0xuhqYazra1x6LJri7txxBwV5zviyidi+OQAmuiVVfxLv62Io=
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com (10.171.182.144) by
 VI1PR05MB3294.eurprd05.prod.outlook.com (10.170.238.27) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1987.13; Tue, 18 Jun 2019 20:19:45 +0000
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::c16d:129:4a40:9ba1]) by VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::c16d:129:4a40:9ba1%6]) with mapi id 15.20.1987.014; Tue, 18 Jun 2019
 20:19:45 +0000
From:   Jason Gunthorpe <jgg@mellanox.com>
To:     oulijun <oulijun@huawei.com>
CC:     Leon Romanovsky <leon@kernel.org>,
        Parav Pandit <pandit.parav@gmail.com>,
        linux-rdma <linux-rdma@vger.kernel.org>,
        Linuxarm <linuxarm@huawei.com>
Subject: =?utf-8?B?UmU6IOOAkEEgcXVlc3Rpb24gYWJvdXQga2VybmVsIHZlcmJzIEFQSeOAkQ==?=
Thread-Topic: =?utf-8?B?44CQQSBxdWVzdGlvbiBhYm91dCBrZXJuZWwgdmVyYnMgQVBJ44CR?=
Thread-Index: AQHVIk7mqDOtaTjejkaKbdly1E4VPKah4bIA
Date:   Tue, 18 Jun 2019 20:19:45 +0000
Message-ID: <20190618201940.GF6945@mellanox.com>
References: <8e80779d-7c1f-4644-3fa7-6fca24734eb8@huawei.com>
In-Reply-To: <8e80779d-7c1f-4644-3fa7-6fca24734eb8@huawei.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BL0PR0102CA0021.prod.exchangelabs.com
 (2603:10b6:207:18::34) To VI1PR05MB4141.eurprd05.prod.outlook.com
 (2603:10a6:803:4d::16)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=jgg@mellanox.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [156.34.55.100]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ad43af98-10a9-42f6-b9c9-08d6f42a4dfd
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:VI1PR05MB3294;
x-ms-traffictypediagnostic: VI1PR05MB3294:
x-microsoft-antispam-prvs: <VI1PR05MB3294B0602CC2DE9BFBE8D93DCFEA0@VI1PR05MB3294.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5236;
x-forefront-prvs: 007271867D
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(396003)(366004)(346002)(376002)(136003)(199004)(189003)(71200400001)(71190400001)(68736007)(86362001)(256004)(36756003)(76176011)(2906002)(8936002)(102836004)(81156014)(4326008)(478600001)(1076003)(386003)(6506007)(14454004)(81166006)(6246003)(6916009)(25786009)(52116002)(5660300002)(6436002)(6486002)(33656002)(7736002)(305945005)(6512007)(66446008)(4744005)(66476007)(66556008)(73956011)(64756008)(54906003)(66946007)(66066001)(99286004)(53936002)(316002)(2616005)(476003)(11346002)(486006)(446003)(26005)(3846002)(229853002)(6116002)(186003);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR05MB3294;H:VI1PR05MB4141.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: NxRCj2kbz0qvNhGBbURyguM4fCqiHv8xhNLdlcWNsIP2MWI5uLZlGnf4AyWd+4TuyPh9Q6A4V91uuP3Xc+VI/Xtnt4WeJPLLDkLQSulnvMk8/mMtfai+fWwUC5sB1gdtjQp1pZt88mIa8oLsbQJsrFXVR9Xdf6KiwGCb9FbKCHpTRFfm+ZG452Km3l2lw+wMBydA6mgATvIMD6M/u0TOMTuVt8P/hDOx7YZ0SEy0rmf91kB3dzAokv+szO0QUbH6EgMOa28E1WsHpwjbmQB/psPUqbXuiNxN5hGvOZ0FCExSBM/gOGUaeUp5J5epRn6SvZKVtus5RsQ5UPX8vFQef7w1fPXaegPldv0BcBYF0e6a9cN6HOW7Puet01iuMZUo1yDxsNiZbUcQhJfZz3JqMM2v432SwxVhOURxCBtBFWo=
Content-Type: text/plain; charset="utf-8"
Content-ID: <628B39ED463A9D448A75B8D7092D7905@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ad43af98-10a9-42f6-b9c9-08d6f42a4dfd
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jun 2019 20:19:45.6939
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jgg@mellanox.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR05MB3294
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

T24gRnJpLCBKdW4gMTQsIDIwMTkgYXQgMDk6MTY6MTVBTSArMDgwMCwgb3VsaWp1biB3cm90ZToN
Cj4gSGnvvIwgSmFzb24gR3VudGhvcnBlICYgTGVvbiBSb21hbm92c2t5JiBQYXJhdiBQYW5kaXQN
Cj4gICAgUmVjZW50bHkgd2hlbiBJIHdhcyBsZWFybmluZyBrZXJuZWwgb2ZlZCBjb2RlLCBJIGZv
dW5kIGFuIGludGVyZXN0aW5nIHRoaW5nIGFib3V0IHZlcmJzLCB0aGUgaW1wbGVtZW50YXRpb24g
cmVseSBvbg0KPiByb2NlIGRyaXZlciwgIHRha2luZyBpYl9kZXJlZ19tciBmb3IgZXhhbXBsZS4N
Cj4gDQo+IFdoZW4gdGhlIGRyaXZlciByZXR1cm5zIGVycm9yLCB0aGUgcmVmZXJlbmNlIGNvdW50
IG9mIHJkbWENCj4gcmVzb3VyY2UocGQsIG1yLCBldGMuKSB3b24ndCBiZSBkZWNyZWFzZWQuIEkg
d29ycmllZCB0aGF0IGl0IHdpbGwNCj4gY2F1c2UgYSBtZW1vcnkgbGVhay4NCg0KVGhlIG9iamVj
dCB3YXMgbm90IGRlc3Ryb3llZCwgdGhlIGNhbGxlciBoYXMgdG8gdHJ5IGFnYWluLg0KDQpKYXNv
bg0K
