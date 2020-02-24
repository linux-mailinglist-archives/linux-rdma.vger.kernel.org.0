Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A6BAC16AFE5
	for <lists+linux-rdma@lfdr.de>; Mon, 24 Feb 2020 20:01:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727187AbgBXTBs (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 24 Feb 2020 14:01:48 -0500
Received: from mail-eopbgr10081.outbound.protection.outlook.com ([40.107.1.81]:25672
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727000AbgBXTBr (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 24 Feb 2020 14:01:47 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cJ3EdthWz+QBNSFC5B7Myda84u6eoEuVtBcBbOVzP4qiA3TfYPcyQElMWPycOxaByZVqaW6F11MFfWa46wieL9aGfcv13pI530oMDsMIdPSHjqmyolGTvSACG2UjyEDMZfE4npjpLb+CN2CcnYxfGxsYjtdogtGHTiZ6R0MoCnejFdEPFOWfwdRzsW/jLuPBQPbg15CdkDbBSUOhU0DCFco7+qdXIm9Xw8MNBT4ZlIx/ULbNl97F/9vUVk5SCkKy2L0o2mfNBkvuXfgmWDgZlxmcsauJWa0/pdnS8H+WG9Fga0EV03ZIQtCQPNpXJ/8x0BEvifh4B5uEFyqML9L7TA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ipNDPx8nrtPokwDC0kplummvwKuW4ACu44JrLKP4R4Y=;
 b=YroZon7uxgSpC9bX9AvamxCCaqFtTGXZuMAsOWaMjQw6u1Y2m0p7Z1Ji0Fv1M7Bkbse6OiLG8HcxsoqjlbPZFOeYWuCZAlR4l+12WOtRPZTDAQjK5CgZFkCGY1Up0qBkQ8h1k+C6pWVW10OuUa5GSC6h8hZpzYCWBkn6dHb5upNy50vVqGsyl+22LRzQ99VErae75OYpNv2MVB0CWWzJd+oVoXJ8RorN4kICOqZ/Ym9MZNIGeja8+7H7A89YeyoPEbU/t4Y8Ys/4CvClahbTBrzHxSL8fbBMEH/RpkR1rdRmdhSiBStIatNlvPSoxHcpUFZJygBcfMRukHMvPmyLvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mellanox.com; dmarc=pass action=none header.from=mellanox.com;
 dkim=pass header.d=mellanox.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ipNDPx8nrtPokwDC0kplummvwKuW4ACu44JrLKP4R4Y=;
 b=sMbJMY/cisZt5fyjG6mt8ex+T3X0hEaZL0xVrcLh9gPEk3sGaGdSUe05CdZ4AeE0fN8G7jl2XkcQG45qgPbv7KAdlF/vnRYXA5EFVF/Kpa1TKocKco0dBaT/diyfLcS7o4aAvqWCNmPo+VhNgMkT3IFMzO4PWg//Y4hTGvH4ng0=
Received: from AM0PR05MB4866.eurprd05.prod.outlook.com (20.176.214.160) by
 AM0PR05MB4995.eurprd05.prod.outlook.com (20.176.215.138) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2729.29; Mon, 24 Feb 2020 19:01:43 +0000
Received: from AM0PR05MB4866.eurprd05.prod.outlook.com
 ([fe80::8c4:e45b:ecdc:e02b]) by AM0PR05MB4866.eurprd05.prod.outlook.com
 ([fe80::8c4:e45b:ecdc:e02b%7]) with mapi id 15.20.2750.021; Mon, 24 Feb 2020
 19:01:43 +0000
From:   Parav Pandit <parav@mellanox.com>
To:     Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>
CC:     Weihang Li <liweihang@huawei.com>,
        "dledford@redhat.com" <dledford@redhat.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "linuxarm@huawei.com" <linuxarm@huawei.com>,
        Shiraz Saleem <shiraz.saleem@intel.com>
Subject: Re: Is anyone working on implementing LAG in ib core?
Thread-Topic: Is anyone working on implementing LAG in ib core?
Thread-Index: AQHV6TLqRqVlI00f7kyTjr5i8r/fvKgn4IQAgAARzwCAAJhaAIABZdYAgAA9/wCAAH+rAIAACSAA
Date:   Mon, 24 Feb 2020 19:01:43 +0000
Message-ID: <8c2df0c3-db07-4f18-1b7f-f648539d52d1@mellanox.com>
References: <280d87d0-fbc0-0566-794b-f66cb4fadb63@huawei.com>
 <20200222234026.GO31668@ziepe.ca>
 <98482e8a-f2eb-5406-b679-0ceb946ac618@mellanox.com>
 <20200223094928.GB422704@unreal>
 <5db0d4f8-1893-33c2-fb25-e6012e0fc6d6@mellanox.com>
 <20200224105206.GA468372@unreal> <20200224182902.GS31668@ziepe.ca>
In-Reply-To: <20200224182902.GS31668@ziepe.ca>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=parav@mellanox.com; 
x-originating-ip: [208.176.44.194]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: c3e10dc4-406a-4a29-ccac-08d7b95bfd3b
x-ms-traffictypediagnostic: AM0PR05MB4995:
x-microsoft-antispam-prvs: <AM0PR05MB4995DD408AB40DD96D003CFDD1EC0@AM0PR05MB4995.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 032334F434
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(346002)(136003)(39860400002)(396003)(376002)(366004)(189003)(199004)(71200400001)(66446008)(66556008)(66476007)(91956017)(2906002)(2616005)(31686004)(4326008)(6512007)(6486002)(64756008)(66946007)(76116006)(110136005)(54906003)(8936002)(36756003)(186003)(86362001)(6506007)(81156014)(8676002)(5660300002)(26005)(316002)(478600001)(81166006)(53546011)(31696002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR05MB4995;H:AM0PR05MB4866.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: u2Rs9Wa3v0Xa9XgrapQvb//CL9WxlJDjJroEoyN63Z47nLAwZJwTr4l2DvH97IOYxi1KAz26sUFbIiuFVC5QEhOFAjxxFGFndIOChzsk5UXURMbs+YmETqUU8gRi3PJsJToY+VMmkcJ/knyhHNgYUgM5sdsyV9cr3f3oZePftKauhid3L0Pm3yyuLa0jSa5MR032OVe1ijo21q8Qz+UNIOCPXgznRkswg675rjN7kbjnXqEkYuyrUkOlXnOlsOZsGqu21bNJKo49duNE+sAjiTpnkAAvWOutnaZ6TFURqafie9aftCutDRSDONJ5VkyxY3Kw50PBrz3YOwzQ0SZ1Hy/NWL0wQo7NT+Cf6SjXQhcMkgKbIdBM46JXnCmsrUbk8RAi9wuU5jXFc4ofUZEzeidPghbzP3bbe6qSAXctRJocBIg9pJrtZSX9OyH8pMtM
x-ms-exchange-antispam-messagedata: xrsjkg08PLzbkhTrp2ufbvJg7XWm6XM098i5hmQGS/UCNGEJp8pTj2zPJ8T0lQrjWoFvWv5U5WRwcIEbeAkwcINzrXC7EaT6UxKw/PkLAeUvq/jlxYbc6RB0vvZibHiMqu5L5u9mmbWrhyKbJwnBTw==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <723EAAE05CE6284DA8B5270CAF1D87E9@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c3e10dc4-406a-4a29-ccac-08d7b95bfd3b
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Feb 2020 19:01:43.5403
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IBWmDOuEOxQhX0pG01jMsRc/YTWz1fEZ6r0ivGJe78h4/gxOebX+TC/o3v5O/Yyc5Dd5ONQjSwUgwlrzYjMhKQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR05MB4995
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

T24gMi8yNC8yMDIwIDEyOjI5IFBNLCBKYXNvbiBHdW50aG9ycGUgd3JvdGU6DQo+IE9uIE1vbiwg
RmViIDI0LCAyMDIwIGF0IDEyOjUyOjA2UE0gKzAyMDAsIExlb24gUm9tYW5vdnNreSB3cm90ZToN
Cj4+PiBBcmUgeW91IGFza2luZyB3aHkgYm9uZGluZyBzaG91bGQgYmUgaW1wbGVtZW50ZWQgYXMg
ZGVkaWNhdGVkDQo+Pj4gdWxwL2RyaXZlciwgYW5kIG5vdCBhcyBhbiBleHRlbnNpb24gYnkgdGhl
IHZlbmRvciBkcml2ZXI/DQo+Pg0KPj4gTm8sIEkgbWVhbnQgc29tZXRoaW5nIGRpZmZlcmVudC4g
WW91IGFyZSBwcm9wb3NpbmcgdG8gY29tYmluZSBJQg0KPj4gZGV2aWNlcywgd2hpbGUga2VlcGlu
ZyBuZXRkZXYgZGV2aWNlcyBzZXBhcmF0ZWQuIEknbSBhc2tpbmcgaWYgaXQgaXMNCj4+IHBvc3Np
YmxlIHRvIGNvbWJpbmUgbmV0ZGV2IGRldmljZXMgd2l0aCBhbHJlYWR5IGV4aXN0aW5nIGJvbmQg
ZHJpdmVyDQo+PiBhbmQgc2ltcGx5IGNyZWF0ZSBuZXcgaWIgZGV2aWNlIHdpdGggYm9uZCBuZXRk
ZXYgYXMgYW4gdW5kZXJseWluZw0KPj4gcHJvdmlkZXIuDQo+IA0KPiBJc24ndCB0aGF0IGJhc2lj
YWxseSB3aGF0IHdlIGRvIG5vdyBpbiBtbHg1Pw0KPiANCkFuZCBpdHMgYnJva2VuIGZvciBmZXcg
YXNwZWN0cyB0aGF0IEkgZGVzY3JpYmVkIGluIFEmQSBxdWVzdGlvbi0xIGluDQp0aGlzIHRocmVh
ZCBwcmV2aW91c2x5Lg0KDQpPbiB0b3Agb2YgdGhhdCB1c2VyIGhhcyBubyBhYmlsaXR5IHRvIGRp
c2FibGUgcmRtYSBib25kaW5nLg0KVXNlciBleGFjdGx5IGFza2VkIHVzIHRoYXQgdGhleSB3YW50
IHRvIGRpc2FibGUgaW4gc29tZSBjYXNlcy4NCihub3Qgb24gbWFpbGluZyBsaXN0KS4gU28gdGhl
cmUgYXJlIG5vbi11cHN0cmVhbSBoYWNrcyBleGlzdHMgdGhhdCBpcw0Kbm90IGFwcGxpY2FibGUg
Zm9yIHRoaXMgZGlzY3Vzc2lvbi4NCg0KPiBMb2dpY2FsbHkgdGhlIGliX2RldmljZSBpcyBhdHRh
Y2hlZCB0byB0aGUgYm9uZCwgaXQgdXNlcyB0aGUgYm9uZCBmb3INCj4gSVAgYWRkcmVzc2luZywg
ZXRjLg0KPiANCj4gSSdtIG5vdCBzdXJlIHRyeWluZyB0byBoYXZlIDMgaWJfZGV2aWNlcyBsaWtl
IG5ldGRldiBkb2VzIGlzIHNhbmUsDQo+IHRoYXQgaXMgdmVyeSwgdmVyeSBjb21wbGljYXRlZCB0
byBnZXQgZXZlcnl0aGluZyB0byB3b3JrLiBUaGUgaWIgc3R1ZmYNCj4ganVzdCBpc24ndCBkZXNp
Z25lZCB0byBiZSBzdGFja2VkIGxpa2UgdGhhdC4NCj4gDQpJIGFtIG5vdCBzdXJlIEkgdW5kZXJz
dGFuZCBhbGwgdGhlIGNvbXBsaWNhdGlvbnMgeW91IGhhdmUgdGhvdWdodCB0aHJvdWdoLg0KSSB0
aG91Z2h0IG9mIGZldyBhbmQgcHV0IGZvcndhcmQgaW4gdGhlIFEmQSBpbiB0aGUgdGhyZWFkIGFu
ZCB3ZSBjYW4NCmltcHJvdmUgdGhlIGRlc2lnbiBhcyB3ZSBnbyBmb3J3YXJkLg0KDQpTdGFja2lu
ZyByZG1hIGRldmljZSBvbiB0b3Agb2YgZXhpc3RpbmcgcmRtYSBkZXZpY2UgYXMgYW4gaWJfY2xp
ZW50IHNvDQp0aGF0IHJkbWEgYm9uZCBkZXZpY2UgZXhhY3RseSBhd2FyZSBvZiB3aGF0IGlzIGdv
aW5nIG9uIHdpdGggc2xhdmVzIGFuZA0KYm9uZCBuZXRkZXYuDQoNCk9uIHRvcCBvZiB0aGF0IEkg
YW0gZW5qb3lpbmcgYmVsb3cgbGlzdCBkZWxldGUgY29ycnVwdGlvbiBjYWxsIHRyYWNlIGZvcg0K
YSB3aGlsZSBub3cgY29taW5nIGZyb20gdGhpcyBsYWcgY29kZSBpbiBhIHNpbGx5IGRldmVsIHRl
c3Qgb2YgbG9hZA0KdW5sb2FkIGRyaXZlciAzMCsgdGltZXMgKG5vdCBldmVuIHJ1bm5pbmcgdHJh
ZmZpYykuIDotKQ0KDQpSSVA6IDAwMTA6X19saXN0X2RlbF9lbnRyeV92YWxpZCsweDdjLzB4YTAN
CnVucmVnaXN0ZXJfbmV0ZGV2aWNlX25vdGlmaWVyX2Rldl9uZXQrMHgxZi8weDcwDQptbHg1X2xh
Z19yZW1vdmUrMHg2MS8weGYwIFttbHg1X2NvcmVdDQptbHg1ZV9kZXRhY2hfbmV0ZGV2KzB4MjQv
MHg1MCBbbWx4NV9jb3JlXQ0KbWx4NWVfZGV0YWNoKzB4MzYvMHg0MCBbbWx4NV9jb3JlXQ0KbWx4
NWVfcmVtb3ZlKzB4NDgvMHg2MCBbbWx4NV9jb3JlXQ0KbWx4NV9yZW1vdmVfZGV2aWNlKzB4YjAv
MHhjMCBbbWx4NV9jb3JlXQ0KbWx4NV91bnJlZ2lzdGVyX2ludGVyZmFjZSsweDM5LzB4OTAgW21s
eDVfY29yZV0NCmNsZWFudXArMHg1LzB4ZGQxIFttbHg1X2NvcmVdDQoNCkFuZCB0aGVyZSBpcyBz
b21lIExBRyBjb2RlIGluIGEgaHcgZHJpdmVyIHRoYXQgcmVzY2hlZHVsZXMgdGhlIHdvcmsgaWYN
Cml0IGNhbm5vdCBhY3F1aXJlIHNvbWUgbXV0ZXggbG9jay4uLg0K
