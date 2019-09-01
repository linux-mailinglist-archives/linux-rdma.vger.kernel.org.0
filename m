Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7E838A4993
	for <lists+linux-rdma@lfdr.de>; Sun,  1 Sep 2019 15:31:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726275AbfIANbB (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 1 Sep 2019 09:31:01 -0400
Received: from mail-eopbgr40046.outbound.protection.outlook.com ([40.107.4.46]:2248
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726121AbfIANbB (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Sun, 1 Sep 2019 09:31:01 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CKZO6zbnAqCiNYrddciNAk/2+d6TkPXsITNvA7hj2nH3V/8tJtSRZgaFVt5MTErfUBIT6lubDuo69saln/2gW2U9eDRAAWUNIYBErwID6PMfzsv2j8bEpgLAkdCtu2JQ3suTwjRicYu5AZuIX8+jXp0oyAmhPdOIqaEeaKnQ6tLcuU65oa4MsluWe+BXK/dTbBw2a0qGb/HMamJ4QPjfjsYEnqnYtRbFgQD6PCfMWxsmGWCHlsU4iVolfLZUDM26g/7/Epbb20eCfXFCrlgwDiWczS7OR4wz5vPAV441L81i6Ka9Pf7A+4k6vcsJu1bwI5ZzCZYPCEAwaEaEKfPbMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YkI5/QSM/kT0ol8+5VrMP8+4MGooBFh8cnESHiGNOSA=;
 b=WF7JeZXNfsjNoEgHgIDSYN7xS7AktlOZsGm1t+IRCBvPBaQsYASGVvkM6U9XA6Iqdc/gRNnnbDXOrsfV9+TEjofKq5JL5GU2mUFM93bjaYqWuhAtntL4StXR6woX/GggcHQdz9dk3at4/IFXgvP2pBK14l68kHA0sBOMVeX23sZgiJzEqGMcI3CQqkNSZ+Q40VkzGLPZEv92WcPZeNFaS+kNpJPh9MMQbTnEgeIu4MC8jF7QS4z0Rba1osShQCs4HCNcUXBc6A6NQxfqmFnyBgmQ1AIcp/DU1jnXSw+y8LR4FzhzuVSZXZ/PzoVCz10NZMMgp0UDeUWRhjWyR0gDGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mellanox.com; dmarc=pass action=none header.from=mellanox.com;
 dkim=pass header.d=mellanox.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YkI5/QSM/kT0ol8+5VrMP8+4MGooBFh8cnESHiGNOSA=;
 b=aws1NNE6SQMjTUWUnc7EAxAva7ZW4tEM1Zea6rH74rHm/XalqkikfSc7gRZP1ZFEJmoBiJ/CaoPETzP7LHEfO+MItWvl8sW7g/F8o/lCUyYtgKHST8CedU64EaUxRhD/Jn94VUSwpRASk+uN2QyBPWz1FJfT/NbM6T+cf5V8EDI=
Received: from AM6PR05MB4968.eurprd05.prod.outlook.com (20.177.33.17) by
 AM6PR05MB5624.eurprd05.prod.outlook.com (20.178.95.210) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2199.21; Sun, 1 Sep 2019 13:30:56 +0000
Received: from AM6PR05MB4968.eurprd05.prod.outlook.com
 ([fe80::945c:650b:dd85:c2ce]) by AM6PR05MB4968.eurprd05.prod.outlook.com
 ([fe80::945c:650b:dd85:c2ce%6]) with mapi id 15.20.2199.021; Sun, 1 Sep 2019
 13:30:56 +0000
From:   Noa Osherovich <noaos@mellanox.com>
To:     Jason Gunthorpe <jgg@mellanox.com>,
        Leon Romanovsky <leonro@mellanox.com>
CC:     "dledford@redhat.com" <dledford@redhat.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH rdma-core 03/14] build: Add pyverbs-based test to the
 build
Thread-Topic: [PATCH rdma-core 03/14] build: Add pyverbs-based test to the
 build
Thread-Index: AQHVVluKi/1wMEsI4UWSJliEROGNkacCfWOAgAGEcwCAA1vkAIAACaEAgA9+4wA=
Date:   Sun, 1 Sep 2019 13:30:56 +0000
Message-ID: <88435e1e-676b-f948-1c34-22cd471af4c9@mellanox.com>
References: <20190819065827.26921-1-noaos@mellanox.com>
 <20190819065827.26921-4-noaos@mellanox.com>
 <20190819135019.GF5080@mellanox.com>
 <2ac30209-2c89-15ef-3907-98d3cd552f4d@mellanox.com>
 <20190822161813.GI29433@mtr-leonro.mtl.com>
 <20190822165247.GB8325@mellanox.com>
In-Reply-To: <20190822165247.GB8325@mellanox.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: AM0PR01CA0060.eurprd01.prod.exchangelabs.com
 (2603:10a6:208:e6::37) To AM6PR05MB4968.eurprd05.prod.outlook.com
 (2603:10a6:20b:4::17)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=noaos@mellanox.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [193.47.165.251]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3419115b-7d8a-497f-c81d-08d72ee09ea7
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:AM6PR05MB5624;
x-ms-traffictypediagnostic: AM6PR05MB5624:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM6PR05MB5624E0CB63351E1280983FEBD9BF0@AM6PR05MB5624.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 0147E151B5
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(346002)(376002)(136003)(396003)(366004)(39860400002)(189003)(199004)(8936002)(478600001)(52116002)(81166006)(81156014)(7736002)(305945005)(14454004)(25786009)(53936002)(446003)(76176011)(6246003)(2906002)(8676002)(66066001)(6116002)(486006)(2616005)(3846002)(71190400001)(476003)(71200400001)(11346002)(36756003)(31696002)(110136005)(229853002)(31686004)(386003)(316002)(6506007)(186003)(53546011)(54906003)(102836004)(6486002)(6436002)(4326008)(5660300002)(99286004)(256004)(6636002)(6512007)(26005)(86362001)(66946007)(64756008)(66446008)(66556008)(66476007);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR05MB5624;H:AM6PR05MB4968.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: vUQN915ckwDSYO8qj3bkYZuZNHdUPh9h4kaRyanty+vh4e3l1wnFGz66dw6osH1TyBlxE/R5eWs710mG6ZfH1y0cvcDu8gQCFHcFWRP5p9zpjXl4WU9Xm9MLkAvxb+f/iiM7REf8wZAROb+Z7I4+yuhdc0MIb9+ISdAoUH4a/MOQWFIlbE3iTKyS6ItZNgGSPzs6Y78xkawoW2zZDn7gGmY5VW0yslXYRLWC9ZysPryvGNsHdtxgZ6BPBov8QHNVbNtnKynb6cJkeSAz9vReW8hVULmgMeK/3umQLmir/ogGSs7MHT+2SEAlA2Ar0hR6/3o5JaaRV3Rh3lan4zcHt6KtuTP9/Xo0/EaUKLJVomc/G3YDepBBKu3MdMvixuHMDTZthV1oG/SYfBsHgJANboKEIMD2myaNTWP7XriVtlg=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E97EAE033DF8DB4E9939C14C580F7ED6@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3419115b-7d8a-497f-c81d-08d72ee09ea7
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Sep 2019 13:30:56.7501
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WRrgOWh3lxB+n/ZmzHypSpObPme5UWuJezIszb+Xt7g+6BUzdS6yRntgYJ9lRWlo/Fk7yjhNapHFR3qHf+gghw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR05MB5624
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

T24gOC8yMi8yMDE5IDc6NTIgUE0sIEphc29uIEd1bnRob3JwZSB3cm90ZToNCg0KPiBPbiBUaHUs
IEF1ZyAyMiwgMjAxOSBhdCAwMToxODoyNFBNIC0wMzAwLCBMZW9uIFJvbWFub3Zza3kgd3JvdGU6
DQo+PiBPbiBUdWUsIEF1ZyAyMCwgMjAxOSBhdCAwMTowMDo0N1BNICswMDAwLCBOb2EgT3NoZXJv
dmljaCB3cm90ZToNCj4+PiBPbiA4LzE5LzIwMTkgNDo1MCBQTSwgSmFzb24gR3VudGhvcnBlIHdy
b3RlOg0KPj4+DQo+Pj4+IEknZCBwcmVmZXIgcnVuX3Rlc3RzIHRvIGJlIGluIHRoZSB0ZXN0cyBk
aXJlY3RvcnkuLg0KPj4+Pg0KPj4+PiBKYXNvbg0KPj4+IFBSIHdhcyB1cGRhdGVkDQo+PiAxLg0K
Pj4gSU1ITywgcnVuX3Rlc3RzLnB5IHNob3VsZCBiZSBwbGFjZWQgaW5zaWRlIHRlc3RzIGRpcmVj
dG9yeSB0b28gYW5kIG5vdA0KPj4gb25seSBpbnN0YWxsZWQgaW50byB0ZXN0cy8uDQo+IFllcywg
dGhpcyBpcyB3aGF0IEkgbWVudC4gVGhlIGZpbGUgc2hvdWxkIGJlIGluIHRlc3RzLyBhbmQgaXQg
c2hvdWxkDQo+IGJlIGJ1aWx0IGludG8gYnVpbGQvYmluLCBhbmQgaW5zdGFsbGVkIGludG8gdGhl
IGV4YW1wbGVzDQo+PiAyLg0KPj4gRXhlY3V0aW9uIG9mIHJ1bl90ZXN0cy5weSBwcm9kdWNlcyBh
IGxvdCBvZiB1bnRyYWNrZWQgZmlsZWQNCj4+IOKenCAgcmRtYS1jb3JlIGdpdDoobm9hb3MtcHIt
dGVzdHMpIOKclyBnaXQgc3QNCj4+IE9uIGJyYW5jaCBub2Fvcy1wci10ZXN0cw0KPj4gVW50cmFj
a2VkIGZpbGVzOg0KPj4gICAodXNlICJnaXQgYWRkIDxmaWxlPi4uLiIgdG8gaW5jbHVkZSBpbiB3
aGF0IHdpbGwgYmUgY29tbWl0dGVkKQ0KPj4NCj4+IAlweXZlcmJzL19faW5pdF9fLnB5Yw0KPj4g
CXB5dmVyYnMvcHl2ZXJic19lcnJvci5weWMNCj4+IAl0ZXN0cy9fX2luaXRfXy5weWMNCj4+IAl0
ZXN0cy9iYXNlLnB5Yw0KPj4gCXRlc3RzL3Rlc3RfYWRkci5weWMNCj4+IAl0ZXN0cy90ZXN0X2Nx
LnB5Yw0KPj4gCXRlc3RzL3Rlc3RfZGV2aWNlLnB5Yw0KPj4gCXRlc3RzL3Rlc3RfbXIucHljDQo+
PiAJdGVzdHMvdGVzdF9vZHAucHljDQo+PiAJdGVzdHMvdGVzdF9wZC5weWMNCj4+IAl0ZXN0cy90
ZXN0X3FwLnB5Yw0KPiAqLnB5YyB3aWxsIGhhdmUgdG8gYmUgYWRkZWQgdG8gdGhlIC5naXRpZ25v
cmUNCj4+IDMuIHJ1bl90ZXN0cy5weSBsYWNrcyBvZiBweXRob24zIHNoZWJhbmcNCj4gT3JpZ2lu
YWxseSBpdCB3YXMgbm90IGluc3RhbGxlZCwgc28gdGhpcyB3YXMgZmluZSwgYXMgdGhlIGJ1aWxk
L2Jpbg0KPiBzY3JpcHQgZG9lcyBhbGwgdGhlIHJlcXVpcmVkIHNldHVwLCBob3dldmVyIG5vdyB0
aGF0IGl0IGlzIHRvIGJlDQo+IGluc3RhbGxlZCBpdCBzaG91bGQgaGF2ZSB0aGUgIyEgLSBhbmQg
aXQgc2hvdWxkIGFsc28gd29yayB3aXRob3V0IGFueQ0KPiB0cm91YmxlIGZyb20gaXQncyBleGFt
cGxlIGxvY2F0aW9uLg0KPg0KPiBKYXNvbg0KDQpQUiB3YXMgdXBkYXRlZC4NCg0KVGhhbmtzLA0K
DQpOb2ENCg0K
