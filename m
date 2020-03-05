Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1B83F17B210
	for <lists+linux-rdma@lfdr.de>; Fri,  6 Mar 2020 00:11:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726269AbgCEXLN (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 5 Mar 2020 18:11:13 -0500
Received: from mail-am6eur05on2054.outbound.protection.outlook.com ([40.107.22.54]:37119
        "EHLO EUR05-AM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726162AbgCEXLM (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 5 Mar 2020 18:11:12 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EAAhgeKRPY+drwFMOA+mfmEM4GvX7OUZz2PB77kZ0jayFP+n+GVc9EXfKHC7yRIdLF5e3ffXlygHU/fl0ZakJ7fzgIU5X5sHGad52lyyPSrm9H6MW7SsON/7gdOVTN1jfRq63gZJQ/MVnTZuZRvs0EG4Pi1zBCiAz9YcSMh0JhD7b9pDZaxMRRZxVi5Q/+WyrHuqjrpTGolVagbUFxAER5xExDCr/SV4QFyssTFWqXYyMJ9/uvSRBApyN49W3S9d2q0kBTPUpBk42hUFqtk7H1B+cd1Mz9+Cdawg/Ulq+do4+yanbsPcD8J5O4uhCp80lD1l0K1sBz7AY6YZN7Fj0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QPETXP19srjbHqxT729Lvx3+eXKlX1bOGrfUgTNz/Sk=;
 b=KindISNgBNNeuN2PbZ84X6jhd6fA0G8lPXmoeSL8it8FFXJM/hz2Ti7p5rD9gN4DheU3N647hkzeL6TLhIO5sikjWMs9VxKv12B0KeIVvpdWGQkaKVt2T6tGgPQCnbA12OUWxnIhd2gKJBULDWCQsMjdXjjP9AppvRz/Y3DkwA+9/JbKv2YITKnCbv+247pIFSMfaHIuzu333X72uGHizEybFvDoT49Qmn/69tmzVghKK87ibz08p4jvEQ5uB3Vw6MBYdKe7w+7ZN3S8CG5DtvP2lG7kYTn8nalm5WresmQXgMQNKs2sQYoAYhzaX7fQelBkIsjnlDNCqVjxUzv5ng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mellanox.com; dmarc=pass action=none header.from=mellanox.com;
 dkim=pass header.d=mellanox.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QPETXP19srjbHqxT729Lvx3+eXKlX1bOGrfUgTNz/Sk=;
 b=aOgBtm7noo2HwS9TVowmfh/jBgjFU0+Ywn92aD/7yleNVogx2guXRh1pIgGpfweh/ZDVLVLaMgdOOHMx4cjO2gSMDdrdenF5Z8V4GVv6mqZjp2NWbSHox7tud3Ry7KcrBDpBYUiOVRzg6mjlZ+MJhrsiZFtu0qDlY+VeoIck43g=
Received: from VI1PR05MB5102.eurprd05.prod.outlook.com (20.177.51.151) by
 VI1PR05MB4189.eurprd05.prod.outlook.com (52.133.14.156) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2793.15; Thu, 5 Mar 2020 23:11:09 +0000
Received: from VI1PR05MB5102.eurprd05.prod.outlook.com
 ([fe80::8cea:6c66:19fe:fbc2]) by VI1PR05MB5102.eurprd05.prod.outlook.com
 ([fe80::8cea:6c66:19fe:fbc2%7]) with mapi id 15.20.2772.019; Thu, 5 Mar 2020
 23:11:09 +0000
From:   Saeed Mahameed <saeedm@mellanox.com>
To:     "dan.carpenter@oracle.com" <dan.carpenter@oracle.com>
CC:     Eli Cohen <eli@mellanox.com>,
        "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>,
        Mark Bloch <markb@mellanox.com>,
        Paul Blakey <paulb@mellanox.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "leon@kernel.org" <leon@kernel.org>
Subject: Re: [PATCH] net/mlx5e: Fix an IS_ERR() vs NULL check
Thread-Topic: [PATCH] net/mlx5e: Fix an IS_ERR() vs NULL check
Thread-Index: AQHV8jBcG8P0LrMi6U+EuXhIUs9Pzqg440EAgADAhgCAAP6IAA==
Date:   Thu, 5 Mar 2020 23:11:09 +0000
Message-ID: <9f205ed72a7a892ed8efda3a236bd533fc991c45.camel@mellanox.com>
References: <20200304142151.qivcobp6ngrynb2p@kili.mountain>
         <10527910074442142431505e9d424af9128e8c5c.camel@mellanox.com>
         <20200305080004.GA19839@kadam>
In-Reply-To: <20200305080004.GA19839@kadam>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.34.4 (3.34.4-1.fc31) 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=saeedm@mellanox.com; 
x-originating-ip: [209.116.155.178]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: abd1b808-62ac-4552-d55a-08d7c15a7d97
x-ms-traffictypediagnostic: VI1PR05MB4189:|VI1PR05MB4189:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VI1PR05MB4189A63B9810D99104193F2CBEE20@VI1PR05MB4189.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 03333C607F
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(366004)(189003)(199004)(86362001)(2616005)(498600001)(6916009)(26005)(186003)(8936002)(81156014)(64756008)(6486002)(4326008)(8676002)(81166006)(6506007)(5660300002)(2906002)(6512007)(76116006)(66476007)(66446008)(66946007)(91956017)(36756003)(71200400001)(54906003)(66556008);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR05MB4189;H:VI1PR05MB5102.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: MlPloW3ytr/NnqnZWb0+wlLV7rz18bIBIfraMkHCfEoCX1BIbT8qkHEecIi48tV/JSnsbOVHtjwKNb1NOZTCx+upfeALlyXjMzO3ujHnayNczNVFertCN4r4nhsRHHE4wkLH8dHakQVlPD5UYRPvCWLAKSaK1gXyjbTbzdhp4OQ6+aq8erOiaZ15uYxf/dGgYBZME99DH7K/c4dHlz6yTZdljLQ7PdteWNq6IKmLzKOdvsliZSPm5rvdvEU+1iWR3GXjj7JtFzh4NCaSp80NGsmlZ3NNq/iJRJco7njzRRdNuLJS6UgU9X4bIDfnGpLsLQKyPqC0Y2zGmA7E83gHQqiiNsQRfCSTShJ0BDs6E1ZScjUq+/+5m7HsN4EYa32p/3A21E1LROUemzptU3Z+nqDlWTfkmMwvY2N08QhBykgus+TQ7W3l8nboUN03D0hp
x-ms-exchange-antispam-messagedata: 1Ks2jPps6zTru+2919ZytAS9LD/oRg7+PfhzRCoHsiznVkNzgFv7sCWIj9KdJEM6m97v8PTnEpp1Rs/zTF5PCu7tev8X+hciA+E1QTVnsKQUMi+91m5dcYQff3sv4QYt7wQv8XytHCuZOY9xxjAvGw==
Content-Type: text/plain; charset="utf-8"
Content-ID: <988C5E04DB6E9D48B69158BC37FCB6F1@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: abd1b808-62ac-4552-d55a-08d7c15a7d97
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Mar 2020 23:11:09.3295
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: R9mK+9Zl45oSag8M5jR2ugvSPQD0drBtGszVGpWldkntrf5zAQq6ODv0uzC9RKlTiv/c/OaRpb0tCBi0PsGEkQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR05MB4189
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

T24gVGh1LCAyMDIwLTAzLTA1IGF0IDExOjAwICswMzAwLCBEYW4gQ2FycGVudGVyIHdyb3RlOg0K
PiBPbiBXZWQsIE1hciAwNCwgMjAyMCBhdCAwODozMToxM1BNICswMDAwLCBTYWVlZCBNYWhhbWVl
ZCB3cm90ZToNCj4gPiBPbiBXZWQsIDIwMjAtMDMtMDQgYXQgMTc6MjIgKzAzMDAsIERhbiBDYXJw
ZW50ZXIgd3JvdGU6DQo+ID4gPiBUaGUgZXN3X3Zwb3J0X3RibF9nZXQoKSBmdW5jdGlvbiByZXR1
cm5zIGVycm9yIHBvaW50ZXJzIG9uIGVycm9yLg0KPiA+ID4gDQo+ID4gPiBGaXhlczogOTZlMzI2
ODc4ZmE1ICgibmV0L21seDVlOiBFc3dpdGNoLCBVc2UgcGVyIHZwb3J0IHRhYmxlcw0KPiA+ID4g
Zm9yDQo+ID4gPiBtaXJyb3JpbmciKQ0KPiA+ID4gU2lnbmVkLW9mZi1ieTogRGFuIENhcnBlbnRl
ciA8ZGFuLmNhcnBlbnRlckBvcmFjbGUuY29tPg0KPiA+IA0KPiA+IEhpIERhbiB0aGUgcGF0Y2gg
bG9va3MgZmluZSwgYnV0IHlvdSBkaWRuJ3QgY2MgbmV0ZGV2IG1haWxpbmcgbGlzdA0KPiA+IFR3
byBvcHRpb25zOg0KPiA+IA0KPiA+IDEpIEkgY2FuIHBpY2sgdGhpcyBwYXRjaCB1cCBhbmQgcmVw
b3N0IGl0IG15c2VsZiBpbiBhIGZ1dHVyZSBwdWxsDQo+ID4gcmVxdWVzdA0KPiANCj4gSSBhc3N1
bWVkIHdlIHdvdWxkIGRvIHRoaXMsIGJlY2F1c2UgdGhlIG9yaWdpbmFsIHBhdGNoIGRpZG4ndCBo
YXZlDQo+IERhdmUncyBzaWduZWQtb2ZmLWJ5Lg0KPiANCg0KV2UgbWFpbnRhaW4gdGhlIG5ldC1u
ZXh0LW1seDUgYnJhbmNoIHVuZGVyIG5ldGRldiBtYWlsaW5nIGxpc3QuDQoNCj4gPiAyKSB5b3Ug
Y2FuIHJlLXBvc3QgaXQgYW5kIGNjIG5ldGRldiBhbHNvIG1hcmsgaXQgZm9yIG5ldCBbUEFUQ0gN
Cj4gPiBuZXRdDQo+IA0KPiBJZiB3ZSB3ZXJlIGdvaW5nIHRvIGdvIHRoYXQgcm91dGUgdGhlbiBp
dCB3b3VsZCBoYXZlIHRvIFtQQVRDSCBuZXQtDQo+IG5leHRdDQo+IGJlY2F1c2UgaXQgZG9lc24n
dCBhcHBseSB0byB0aGUgbmV0IHRyZWUuDQo+IA0KDQpJIHNlZSwgaSB3aWxsIHRha2UgaXQgbXlz
ZWxmIHRvIG5ldC1uZXh0LW1seDUgYW5kIHdpbGwgc3VibWl0IHRvIG5ldC0NCm5leHQgc29vbiBp
biBteSBuZXh0IHB1bGwgcmVxdWVzdCB0byBkYXZlLg0KDQpUaGFua3MsDQpTYWVlZC4NCg0K
