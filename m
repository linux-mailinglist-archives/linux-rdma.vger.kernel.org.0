Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 039AA15D9B7
	for <lists+linux-rdma@lfdr.de>; Fri, 14 Feb 2020 15:48:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729345AbgBNOsT (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 14 Feb 2020 09:48:19 -0500
Received: from mail-eopbgr80049.outbound.protection.outlook.com ([40.107.8.49]:57152
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726191AbgBNOsT (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 14 Feb 2020 09:48:19 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K9iHmgKGUh4ykG5YfcReYliLqfVHaRnz1XeU4xD38CtH5FjrxpVc+Apx4IJxPgnB9vCbcFmUmL87hXGH48m5FfZjVqVic2Igcd+eAZlnVoiDL5OINeQT6nLtLEGD5ndgsKGV9B7PSxIZ2EYyE4naPEsvCiZOZgtgtkdqCpvxVY6zK0cILFYWTKk3FlL9GTI2r9vNI33GrfpzjOTOObe1myBJXpmSrtl0+9zr5+rWeMWI55PSlZlWp5wmYqNVRLH5CqW/TyMASTON0nyPuyV1nptGvXRfOgmpWC9YPZvogS5a91onmiSolDHxDAAXQ9zkLokMKNLI8DEBO/KUf0o1rg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=En5eBwx8NDK1MNSbx3EjGt3aXTFd9WbNdoE5fuRxvPI=;
 b=AgaonGAUrGZyKbL5oPWw0PZdg15wiV5fmAnLkA5INmSW6liu3LKZh1+qqDrhv8W/D7DAt2DYUOQ1Wm17yfxhrH981LPcpI4aQTx+frBfx6MKO/PRBzA1hU9YcIDNEc1aNqUCDpnrLqfsxP0Sd+T5LBZPdkY/Y/laBrNkHD6OgtN13Q8N3NF2mCfut8peN5j9Pr+cQy+Ez+4mMSlW8faKm/CHtyAHvz3uitNrOUX+h576GkoyjWg/oXaJf73IsSkdP9QjttTz1mVltgZP40aynGFWx8Yh0C5VcMKiAqLbe10SlsnArgF7PcRGnmsoWWyU3YCSZBTopv4LA2AOW5od7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mellanox.com; dmarc=pass action=none header.from=mellanox.com;
 dkim=pass header.d=mellanox.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=En5eBwx8NDK1MNSbx3EjGt3aXTFd9WbNdoE5fuRxvPI=;
 b=n7vQG6lPpdaeYBSOfobpQeY9vHxTscWsZ8g9czQAdfE4Sn8eYTCBa9duv8ney+Vya0nEm64bHAUXIJRFeQNT3Nn9ksNb7BbBVThDqqR4fwscwX95Z0QKTpTHfS1r4Y0l3SmRueOyR5QHhYq3oMd9x4SVaeeChuRtg3+y6QBz4UU=
Received: from AM0PR05MB4866.eurprd05.prod.outlook.com (20.176.214.160) by
 AM0PR05MB5828.eurprd05.prod.outlook.com (20.178.116.33) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2729.22; Fri, 14 Feb 2020 14:48:14 +0000
Received: from AM0PR05MB4866.eurprd05.prod.outlook.com
 ([fe80::8c4:e45b:ecdc:e02b]) by AM0PR05MB4866.eurprd05.prod.outlook.com
 ([fe80::8c4:e45b:ecdc:e02b%7]) with mapi id 15.20.2729.025; Fri, 14 Feb 2020
 14:48:14 +0000
From:   Parav Pandit <parav@mellanox.com>
To:     Jason Gunthorpe <jgg@ziepe.ca>
CC:     Leon Romanovsky <leon@kernel.org>,
        Doug Ledford <dledford@redhat.com>,
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
Thread-Index: AQHV4XXZDpMNYi4JcEeEoEwaOCBrJagZILUAgADlW4CAALdegIAACzgA
Date:   Fri, 14 Feb 2020 14:48:14 +0000
Message-ID: <1e9749f8-ce55-8b69-71be-9e1eec8c82db@mellanox.com>
References: <20200212072635.682689-1-leon@kernel.org>
 <20200212072635.682689-4-leon@kernel.org> <20200213133054.GA10333@ziepe.ca>
 <c0e73246-a421-5619-a7e6-f955612fd1b9@mellanox.com>
 <20200214140805.GS31668@ziepe.ca>
In-Reply-To: <20200214140805.GS31668@ziepe.ca>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=parav@mellanox.com; 
x-originating-ip: [2605:6000:ec82:1c00:2dcc:6515:77fb:e8b6]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: ee69936d-b6fc-4bf8-62bf-08d7b15cebcf
x-ms-traffictypediagnostic: AM0PR05MB5828:|AM0PR05MB5828:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM0PR05MB5828C39B0B1CB22CF685C37DD1150@AM0PR05MB5828.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1002;
x-forefront-prvs: 03137AC81E
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(366004)(396003)(376002)(39850400004)(346002)(136003)(199004)(189003)(8676002)(8936002)(6486002)(6512007)(81166006)(81156014)(478600001)(4326008)(86362001)(107886003)(31686004)(31696002)(6916009)(54906003)(6506007)(71200400001)(36756003)(2616005)(316002)(5660300002)(2906002)(66476007)(53546011)(186003)(76116006)(64756008)(66446008)(66946007)(66556008)(91956017);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR05MB5828;H:AM0PR05MB4866.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: KSTNdoUj1WG7A/fEbbh4bnSKQsArLYeiiihhlAOGKlVa3QO3SiLWk0HWpErTTfYDgoMjayhjMTw7NW9g90gxZ1DS3jVirbrhClphTxQBjPwvrGQT/dzdkeQGwAFEilj51AwxUJJc8InUQv70o90eL0cYNplusZsWdnIozCYwt5hE5mF1AvaTB7KgCoe0SBrKTyE6X5Jv9NiOVLltBDYUg6LU9x6tYfGAmdRc9qk+5EgpjvVuIPdFTKRka5ISIqjnCgtFuHIonP/mkCNb5v2jrv6BvqBUiv2Ejd0m01JkIo2vlsyrm2JsDJed0AmGQAi4ed5OCRNACLHhmuvL9gUkK8P3sTxW76hZm40QSfPIXr7bPkPC3Px25FWvsLixUmcBI4bPixBuuDPZbTDaK4GAI3sIs0ZJ8EN3Z9ilz0IIoaFXrLISE7hYAiplYbBLiMnf
x-ms-exchange-antispam-messagedata: r8E4eMTdTFuVfNGtIbN0pEHb278VHpu6gRbX9tAcK+jzi+0S5SOv92D3vqeKII5e9b/FI6FK4Ya1TKzUNYcR0u/c7H3EguY0/TEm4owFwACjpk+eZmPeEQI8gay90cw1DcRXApYZ+mpRe9+h9XqzxRWDLjPJVBxkVq8j4okuX49BGZzbiiEB8H2vmbrxG66oMH5uEFKsDEhgbOHgyuo1cw==
Content-Type: text/plain; charset="utf-8"
Content-ID: <9A1249CA521C6B49A4BF749EE02A6677@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ee69936d-b6fc-4bf8-62bf-08d7b15cebcf
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Feb 2020 14:48:14.5710
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uqUqtFEKu6LH6njhXBfwK/y4KPVK+Dp/rHd/TKy+mSzHAUGnpoFMGNofJcb0istzfPN30c8iKRUktCbhJsR5YQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR05MB5828
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

T24gMi8xNC8yMDIwIDg6MDggQU0sIEphc29uIEd1bnRob3JwZSB3cm90ZToNCj4gT24gRnJpLCBG
ZWIgMTQsIDIwMjAgYXQgMDM6MTE6NDhBTSArMDAwMCwgUGFyYXYgUGFuZGl0IHdyb3RlOg0KPj4g
T24gMi8xMy8yMDIwIDc6MzAgQU0sIEphc29uIEd1bnRob3JwZSB3cm90ZToNCj4+PiBPbiBXZWQs
IEZlYiAxMiwgMjAyMCBhdCAwOToyNjoyOUFNICswMjAwLCBMZW9uIFJvbWFub3Zza3kgd3JvdGU6
DQo+Pj4+IEZyb206IFBhcmF2IFBhbmRpdCA8cGFyYXZAbWVsbGFub3guY29tPg0KPj4+Pg0KPj4+
PiBUaGlzIHJldmVydHMgY29tbWl0IDIxOWQyZTlkZmRhOTQzMWI4MDhjMjhkNWVmYzc0YjQwNGI5
NWI2MzguDQo+Pj4+DQo+Pj4+IEJlbG93IGZsb3cgcmVxdWlyZXMgY21faWRfcHJpdidzIGRlc3Rp
bmF0aW9uIGFkZHJlc3MgdG8gYmUgc2V0dXANCj4+Pj4gYmVmb3JlIHBlcmZvcm1pbmcgcmRtYV9i
aW5kX2FkZHIoKS4NCj4+Pj4gV2l0aG91dCB3aGljaCwgc291cmNlIHBvcnQgYWxsb2NhdGlvbiBm
b3IgZXhpc3RpbmcgYmluZCBsaXN0IGZhaWxzDQo+Pj4+IHdoZW4gcG9ydCByYW5nZSBpcyBzbWFs
bCwgcmVzdWx0aW5nIGludG8gcmRtYV9yZXNvbHZlX2FkZHIoKQ0KPj4+PiBmYWlsdXJlLg0KPj4+
DQo+Pj4gSSBkb24ndCBxdWl0ZSB1bmRlcnN0YW5kcyB0aGlzIC0gd2hhdCBpcyAid2hlbiBwb3J0
IHJhbmdlIGlzIHNtYWxsIiA/DQo+Pj4gIA0KPj4gVGhlcmUgaXMgc3lzZnMga25vYiB0byByZWR1
Y2Ugc291cmNlIHBvcnQgcmFuZ2UgdG8gdXNlIGZvciBiaW5kaW5nLg0KPj4gU28gaXQgaXMgZWFz
eSB0byBjcmVhdGUgdGhlIGlzc3VlIGJ5IHJlZHVjaW5nIHBvcnQgcmFuZ2UgdG8gaGFuZGZ1bCBv
ZiB0aGVtLg0KPj4NCj4+Pj4gcmRtYV9yZXNvbHZlX2FkZHIoKQ0KPj4+PiAgIGNtYV9iaW5kX2Fk
ZHIoKQ0KPj4+PiAgICAgcmRtYV9iaW5kX2FkZHIoKQ0KPj4+PiAgICAgICBjbWFfZ2V0X3BvcnQo
KQ0KPj4+PiAgICAgICAgIGNtYV9hbGxvY19hbnlfcG9ydCgpDQo+Pj4+ICAgICAgICAgICBjbWFf
cG9ydF9pc191bmlxdWUoKSA8LSBjb21wYXJlZCB3aXRoIHplcm8gZGFkZHINCj4+Pg0KPj4+IERv
IHlvdSB1bmRlcnN0YW5kIHdoeSBjbWFfcG9ydF9pc191bmlxdWUgaXMgZXZlbiB0ZXN0aW5nIHRo
ZSBkc3RfYWRkcj8NCj4+PiBJdCBzZWVtcyB2ZXJ5IHN0cmFuZ2UuDQo+Pg0KPj4gbWFfcG9ydF91
bmlxdWUoKSByZXVzZXMgdGhlIHNvdXJjZSBwb3J0IGFzIGxvbmcgYXMNCj4+IGRlc3RpbmF0aW9u
IGlzIGRpZmZlcmVudCAoZGVzdGluYXRpb24gPSBlaXRoZXIgZGlmZmVyZW50DQo+PiBkZXN0LmFk
ZHIgb3IgZGlmZmVyZW50IGRlc3QucG9ydCBiZXR3ZWVuIHR3byBjbV9pZHMgKS4NCj4+DQo+PiBU
aGlzIGJlaGF2aW9yIGlzIHN5bm9ueW1vdXMgdG8gVENQIGFsc28uDQo+Pg0KPj4+IE91dGJvdW5k
IGNvbm5lY3Rpb25zIHNob3VsZCBub3QgYWxpYXMgdGhlIHNvdXJjZSBwb3J0IGluIHRoZSBmaXJz
dA0KPj4+IHBsYWNlPz8NCj4+Pg0KPj4gSSBiZWxpZXZlIGl0IGNhbiBiZWNhdXNlIFRDUCBzZWVt
cyB0byBhbGxvdyB0aGF0IHRvbyBhcyBsb25nIGRlc3RpbmF0aW9uDQo+PiBpcyBkaWZmZXJlbnQu
DQo+Pg0KPj4gSSB0aGluayBpdCBhbGxvd3MgaWYgaXQgcmVzdWx0cyBpbnRvIGRpZmZlcmVudCA0
LXR1cGxlLg0KPiANCj4gU28gdGhlIGlzc3VlIGhlcmUgaXMgaWYgdGhlIGRlc3QgaXMgbGVmdCBh
cyAwIHRoZW4gdGhlDQo+IGNtYV9hbGxvY19hbnlfcG9ydCgpIGlzbid0IGFibGUgdG8gYWxpYXMg
c291cmNlIHBvcnRzIGFueSBtb3JlPw0KPg0KQ29ycmVjdC4NCg0KDQo+IEphc29uDQo+IA0KDQo=
