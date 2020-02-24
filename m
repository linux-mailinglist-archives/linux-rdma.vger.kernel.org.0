Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B7A6716B061
	for <lists+linux-rdma@lfdr.de>; Mon, 24 Feb 2020 20:41:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726628AbgBXTlL (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 24 Feb 2020 14:41:11 -0500
Received: from mail-eopbgr80043.outbound.protection.outlook.com ([40.107.8.43]:12372
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726452AbgBXTlL (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 24 Feb 2020 14:41:11 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AmPOKPfw8ViUD55DMArBGd8rZq4x7AzmRAs8wiqD8tXiPp/2bKJYP+fE8y42uv3dJoEppu1TXS+zlZsDeH1qZyVbZ8R7sk8Z3PMI7p6BtX1P2y5NGR3a3jdQ2ViierOokrLg8UeaJ+92q12fmwl9gEv8Ej0vJFblSGUmBujhs0+8Tl74tidTaSSFlmTd+QMsVnKm5fmzYd9HNKTHl2/SO9iAFOW3Lp5ePQcVDBYKds5D/RvDqHkMpkALB1QsKDtGp4YyDLGo2rbWbI43VHgciJ4C0jyuV/CPxW/4AXpahRY8NVo7AC4IRZayta/mzHlqtKcrU7EQhK0assSuBYeF/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zHSXRazhTbxwixs7Jwuqvk2I2UHG79tNZz4COn6IxnQ=;
 b=HdDt3U2ciXe45fQw58Z73v0ZDXd32C4SNPIWyB1dsasV30fRhsUHW5D4NgK4o21QcUCDHyMx4q0JDnFnsPxevfMul3BCnHykbi1nFCpC/ZidmOBbyugTDxBA5v42fOVzEYB8vLicy6p3yRNfLHhCA2kknmAqHhQVl0JfpeZ5zuC/gE4uQnoN3YKJjHAFzqk5eCPJoMYQHMZwW/lnacw1vBYRSo1JvZz/1ojngDwV2V+o5j4SFT6GUjo7VPOSiOSzwjothXjQe3UfWagEmFX7yUGNlodQ2FE8Xc5QXa4t4FeXXGjwz4K0CyBXC6tdBh46Qn44m/AbPO7w79vmbgKaww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mellanox.com; dmarc=pass action=none header.from=mellanox.com;
 dkim=pass header.d=mellanox.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zHSXRazhTbxwixs7Jwuqvk2I2UHG79tNZz4COn6IxnQ=;
 b=lHGhQpdkK1oPrWYEVQOqz87f/FTtNCC7GCujUZflETzjkvSlnnRwnTOFmJLLEwEFcO0otIK1sKA8VyiwdzDIjtr99I8ZQ8mJip61o7hr5LjF6W30dAjp7RbhseWGLA1vLjMAr3YncWxU9EOZhwmOV4/h8ra7kz9LCt8rdJI6CFo=
Received: from AM0PR05MB4866.eurprd05.prod.outlook.com (20.176.214.160) by
 AM0PR05MB6642.eurprd05.prod.outlook.com (10.141.190.86) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2750.21; Mon, 24 Feb 2020 19:41:07 +0000
Received: from AM0PR05MB4866.eurprd05.prod.outlook.com
 ([fe80::8c4:e45b:ecdc:e02b]) by AM0PR05MB4866.eurprd05.prod.outlook.com
 ([fe80::8c4:e45b:ecdc:e02b%7]) with mapi id 15.20.2750.021; Mon, 24 Feb 2020
 19:41:06 +0000
From:   Parav Pandit <parav@mellanox.com>
To:     Jason Gunthorpe <jgg@ziepe.ca>
CC:     Leon Romanovsky <leon@kernel.org>,
        Weihang Li <liweihang@huawei.com>,
        "dledford@redhat.com" <dledford@redhat.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "linuxarm@huawei.com" <linuxarm@huawei.com>,
        Shiraz Saleem <shiraz.saleem@intel.com>
Subject: Re: Is anyone working on implementing LAG in ib core?
Thread-Topic: Is anyone working on implementing LAG in ib core?
Thread-Index: AQHV6TLqRqVlI00f7kyTjr5i8r/fvKgn4IQAgAARzwCAAJhaAIABZdYAgAA9/wCAAH+rAIAACSAAgAAGM4CAAATNAA==
Date:   Mon, 24 Feb 2020 19:41:05 +0000
Message-ID: <b3e3600a-84ad-8ac4-b52d-efce4f95556b@mellanox.com>
References: <280d87d0-fbc0-0566-794b-f66cb4fadb63@huawei.com>
 <20200222234026.GO31668@ziepe.ca>
 <98482e8a-f2eb-5406-b679-0ceb946ac618@mellanox.com>
 <20200223094928.GB422704@unreal>
 <5db0d4f8-1893-33c2-fb25-e6012e0fc6d6@mellanox.com>
 <20200224105206.GA468372@unreal> <20200224182902.GS31668@ziepe.ca>
 <8c2df0c3-db07-4f18-1b7f-f648539d52d1@mellanox.com>
 <20200224192353.GU31668@ziepe.ca>
In-Reply-To: <20200224192353.GU31668@ziepe.ca>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=parav@mellanox.com; 
x-originating-ip: [208.176.44.194]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 8c78f979-1232-4284-e4f5-08d7b9617db1
x-ms-traffictypediagnostic: AM0PR05MB6642:
x-microsoft-antispam-prvs: <AM0PR05MB66425437AB94CB45796CFC83D1EC0@AM0PR05MB6642.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 032334F434
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(346002)(366004)(136003)(376002)(396003)(39860400002)(199004)(189003)(316002)(26005)(71200400001)(8676002)(2616005)(81156014)(54906003)(478600001)(31686004)(81166006)(53546011)(6506007)(6486002)(2906002)(66556008)(64756008)(6512007)(8936002)(91956017)(186003)(6916009)(76116006)(4326008)(36756003)(5660300002)(66946007)(86362001)(66476007)(66446008)(31696002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR05MB6642;H:AM0PR05MB4866.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Ue/JfSnVDIECAlD3LmSyXe5gpasjgkP0sqXxQJm0m8P1LJqzJPOVZDPPnImOCz6cQgXMLi82GpEC/Oz6K5u6scitCKZZB+LD9sN/jW2BwqdpC8QRxYxLQzPDHsQN1QktoH6zNgB6Xi6DkHPchCOZAbUbP7p0RAPN680aEsh1LBKw6rPi4ThwT1c12k8AVH4rIaazz5IimsUmXri4kVhVPUPR5hs0OnuJDSIr+ydVQZvdBEWuHL/c7b5Ywq4YlgQWN+ez7zNTKUEGur5sByYvCBt5xyNWoDGK2pwagGRn+M2/uCTFIhNYPTXljLfioDaFisRZ27rLL3zjDR8oIZ2JXqkyupdA4+P1Xo2/7ChAHIaPnpPbfOtnWwAgZZS0QM4XZieuHRanzlY5yaJXaXZhiEYQjW7fe8GoeA3eHB55XxRQiRcDvJ4q2RmhcnUNhsMk
x-ms-exchange-antispam-messagedata: 1/e2ZCrg9Yi66ku046K+ZY8Yx6VmrlQD1/bf1/RXQLZMShlK/UoceHhhLMKrgEGBruq7VSrIe0EviwApou4wGuEPzsATVhj3zhLLNxuCuTmk4n8c2xf43vCTHx5ZO02LKiHKwo+r+TP6i18n/xbnNg==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <B77C0E1FD1DCD841B6B57FF6E05D7482@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c78f979-1232-4284-e4f5-08d7b9617db1
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Feb 2020 19:41:06.1944
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: X4Kny1a5au+pBNGERcSvGM08D/l5GdZrIjDYihhQBjUyygB1cfa7mt2srVmrxKJE5yFNFlHT+1x7sOKCkvor0g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR05MB6642
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

T24gMi8yNC8yMDIwIDE6MjMgUE0sIEphc29uIEd1bnRob3JwZSB3cm90ZToNCj4gT24gTW9uLCBG
ZWIgMjQsIDIwMjAgYXQgMDc6MDE6NDNQTSArMDAwMCwgUGFyYXYgUGFuZGl0IHdyb3RlOg0KPj4g
T24gMi8yNC8yMDIwIDEyOjI5IFBNLCBKYXNvbiBHdW50aG9ycGUgd3JvdGU6DQo+Pj4gT24gTW9u
LCBGZWIgMjQsIDIwMjAgYXQgMTI6NTI6MDZQTSArMDIwMCwgTGVvbiBSb21hbm92c2t5IHdyb3Rl
Og0KPj4+Pj4gQXJlIHlvdSBhc2tpbmcgd2h5IGJvbmRpbmcgc2hvdWxkIGJlIGltcGxlbWVudGVk
IGFzIGRlZGljYXRlZA0KPj4+Pj4gdWxwL2RyaXZlciwgYW5kIG5vdCBhcyBhbiBleHRlbnNpb24g
YnkgdGhlIHZlbmRvciBkcml2ZXI/DQo+Pj4+DQo+Pj4+IE5vLCBJIG1lYW50IHNvbWV0aGluZyBk
aWZmZXJlbnQuIFlvdSBhcmUgcHJvcG9zaW5nIHRvIGNvbWJpbmUgSUINCj4+Pj4gZGV2aWNlcywg
d2hpbGUga2VlcGluZyBuZXRkZXYgZGV2aWNlcyBzZXBhcmF0ZWQuIEknbSBhc2tpbmcgaWYgaXQg
aXMNCj4+Pj4gcG9zc2libGUgdG8gY29tYmluZSBuZXRkZXYgZGV2aWNlcyB3aXRoIGFscmVhZHkg
ZXhpc3RpbmcgYm9uZCBkcml2ZXINCj4+Pj4gYW5kIHNpbXBseSBjcmVhdGUgbmV3IGliIGRldmlj
ZSB3aXRoIGJvbmQgbmV0ZGV2IGFzIGFuIHVuZGVybHlpbmcNCj4+Pj4gcHJvdmlkZXIuDQo+Pj4N
Cj4+PiBJc24ndCB0aGF0IGJhc2ljYWxseSB3aGF0IHdlIGRvIG5vdyBpbiBtbHg1Pw0KPj4+DQo+
PiBBbmQgaXRzIGJyb2tlbiBmb3IgZmV3IGFzcGVjdHMgdGhhdCBJIGRlc2NyaWJlZCBpbiBRJkEg
cXVlc3Rpb24tMSBpbg0KPj4gdGhpcyB0aHJlYWQgcHJldmlvdXNseS4NCj4+DQo+PiBPbiB0b3Ag
b2YgdGhhdCB1c2VyIGhhcyBubyBhYmlsaXR5IHRvIGRpc2FibGUgcmRtYSBib25kaW5nLg0KPiAN
Cj4gQW5kIHdoYXQgZG9lcyB0aGF0IG1lYW4/IFRoZSByZWFsIG5ldGRldnMgaGF2ZSBubyBJUCBh
ZGRyZXNlcyBzbyB3aGF0DQo+IGV4YWN0bHkgZG9lcyBhIG5vbi1ib25kZWQgUm9DRXYyIFJETUEg
ZGV2aWNlIGRvPw0KPiANCk5vdCBzdXJlLiBUaGVyZSBpcyBzb21lIGRlZmF1bHQgR0lEIG9uIGl0
Lg0KDQo+PiBVc2VyIGV4YWN0bHkgYXNrZWQgdXMgdGhhdCB0aGV5IHdhbnQgdG8gZGlzYWJsZSBp
biBzb21lIGNhc2VzLg0KPj4gKG5vdCBvbiBtYWlsaW5nIGxpc3QpLiBTbyB0aGVyZSBhcmUgbm9u
LXVwc3RyZWFtIGhhY2tzIGV4aXN0cyB0aGF0IGlzDQo+PiBub3QgYXBwbGljYWJsZSBmb3IgdGhp
cyBkaXNjdXNzaW9uLg0KPiANCj4gQmFoLCBJJ20gYXdhcmUgb2YgdGhhdCAtIHRoYXQgcmVxdWVz
dCBpcyBoYWNrIHNvbHV0aW9uIHRvIHNvbWV0aGluZw0KPiBlbHNlIGFzIHdlbGwuDQo+IA0KPj4+
IExvZ2ljYWxseSB0aGUgaWJfZGV2aWNlIGlzIGF0dGFjaGVkIHRvIHRoZSBib25kLCBpdCB1c2Vz
IHRoZSBib25kIGZvcg0KPj4+IElQIGFkZHJlc3NpbmcsIGV0Yy4NCj4+Pg0KPj4+IEknbSBub3Qg
c3VyZSB0cnlpbmcgdG8gaGF2ZSAzIGliX2RldmljZXMgbGlrZSBuZXRkZXYgZG9lcyBpcyBzYW5l
LA0KPj4+IHRoYXQgaXMgdmVyeSwgdmVyeSBjb21wbGljYXRlZCB0byBnZXQgZXZlcnl0aGluZyB0
byB3b3JrLiBUaGUgaWIgc3R1ZmYNCj4+PiBqdXN0IGlzbid0IGRlc2lnbmVkIHRvIGJlIHN0YWNr
ZWQgbGlrZSB0aGF0Lg0KPj4+DQo+PiBJIGFtIG5vdCBzdXJlIEkgdW5kZXJzdGFuZCBhbGwgdGhl
IGNvbXBsaWNhdGlvbnMgeW91IGhhdmUgdGhvdWdodCB0aHJvdWdoLg0KPj4gSSB0aG91Z2h0IG9m
IGZldyBhbmQgcHV0IGZvcndhcmQgaW4gdGhlIFEmQSBpbiB0aGUgdGhyZWFkIGFuZCB3ZSBjYW4N
Cj4+IGltcHJvdmUgdGhlIGRlc2lnbiBhcyB3ZSBnbyBmb3J3YXJkLg0KPj4NCj4+IFN0YWNraW5n
IHJkbWEgZGV2aWNlIG9uIHRvcCBvZiBleGlzdGluZyByZG1hIGRldmljZSBhcyBhbiBpYl9jbGll
bnQgc28NCj4+IHRoYXQgcmRtYSBib25kIGRldmljZSBleGFjdGx5IGF3YXJlIG9mIHdoYXQgaXMg
Z29pbmcgb24gd2l0aCBzbGF2ZXMgYW5kDQo+PiBib25kIG5ldGRldi4NCj4gDQo+IEhvdyBkbyB5
b3Ugc2FmZWx5IHByb3h5IGV2ZXJ5IHNpbmdsZSBvcCBmcm9tIHRoZSBib25kIHRvIHNsYXZlcz8N
CkJvbmQgY29uZmlnIHNob3VsZCB0ZWxsIHdoaWNoIHNsYXZlIHRvIHVzZSwgaW5zdGVhZCBvZiBj
dXJyZW50IGltcGxpY2l0IG9uZS4NCg0KPiANCj4gSG93IGRvIHlvdSBmb3JjZSB0aGUgc2xhdmVz
IHRvIGFsbG93IFBEcyB0byBiZSBzaGFyZWQgYWNyb3NzIHRoZW0/DQo+IA0KRm9yIHNsYXZlIGl0
IGRvZXNuJ3QgbWF0dGVyIGlmIGNhbGxlciBpcyBib25kIG9yIGRpcmVjdC4NCg0KPiBXaGF0IHBy
b3ZpZGVyIGxpdmVzIGluIHVzZXIgc3BhY2UgZm9yIHRoZSBib25kIGRyaXZlcj8gV2hhdCBoYXBw
ZW5zIHRvDQo+IHRoZSB1ZGF0YS9ldGM/DQpTYW1lIGFzIHRoYXQgb2YgcHJpbWFyeSBzbGF2ZSB1
c2VkIGZvciBwY2ksIGlycSBhY2Nlc3Mgd2hvc2UgaW5mbyBpcw0KcHJvdmlkZWQgdGhyb3VnaCBu
ZXcgbmV0bGluayBkaXNjb3ZlcnkgcGF0aC4NCg0KPiANCj4gQW5kIGl0IGRvZXNuJ3Qgc29sdmUg
dGhlIG1haW4gcHJvYmxlbSB5b3UgcmFpc2VkLCBjcmVhdGluZyBhIElCIGRldmljZQ0KPiB3aGls
ZSBob2xkaW5nIFJUTkwgc2ltcGx5IHNob3VsZCBub3QgZXZlciBiZSBkb25lLiBNb3ZpbmcgdGhp
cyBjb2RlDQo+IGludG8gdGhlIGNvcmUgbGF5ZXIgZml4ZWQgaXQgdXAgc2lnbmlmaWNhbnRseSBm
b3IgdGhlIHNpbWlsYXIgcnhlL3Npdw0KPiBjYXNlcywgSSBleHBlY3QgdGhlIHNhbWUgaXMgcG9z
c2libGUgZm9yIHRoZSBMQUcgc2l0dWF0aW9uIHRvby4NCj4gDQokIHJkbWEgYWRkIGRldiBjb21t
YW5kIHdvbid0IGhvbGQgcnRubCBsb2NrLCB3aGVuIG5ldyByZG1hIGJvbmQgZGV2aWNlDQppcyBh
ZGRlZCB0aHJvdWdoIHJkbWEgbmV0bGluayBzb2NrZXQuDQo=
