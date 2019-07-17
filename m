Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 438C96C2D3
	for <lists+linux-rdma@lfdr.de>; Wed, 17 Jul 2019 23:55:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727217AbfGQVzm (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 17 Jul 2019 17:55:42 -0400
Received: from smtp6out.l-3com.com ([166.20.51.117]:19547 "EHLO
        smtp6out.l-3com.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727382AbfGQVzm (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 17 Jul 2019 17:55:42 -0400
X-filenames: 
X-filesizes: None
X-filetypes: 
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,275,1559520000"; 
   d="scan'208";a="399711529"
X-L3Internal: true
Received: from ex06dag01azusva.rootforest.com (HELO mail.l3t.com) ([141.199.128.136])
  by smtp6out.l-3com.com with ESMTP; 17 Jul 2019 21:55:41 +0000
Received: from EX09DAG01AZUSVA.rootforest.com (141.199.128.139) by
 EX06DAG01AZUSVA.rootforest.com (141.199.128.136) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Wed, 17 Jul 2019 21:55:40 +0000
Received: from USG02-BN3-obe.outbound.protection.office365.us (23.103.199.151)
 by smtp.l3t.com (141.199.128.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5 via Frontend
 Transport; Wed, 17 Jul 2019 21:55:39 +0000
Received: from CY1P110MB0295.NAMP110.PROD.OUTLOOK.COM (23.103.32.214) by
 CY1P110MB0200.NAMP110.PROD.OUTLOOK.COM (23.103.25.219) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2052.25; Wed, 17 Jul 2019 21:55:37 +0000
Received: from CY1P110MB0295.NAMP110.PROD.OUTLOOK.COM ([23.103.32.214]) by
 CY1P110MB0295.NAMP110.PROD.OUTLOOK.COM ([23.103.32.214]) with mapi id
 15.20.2052.024; Wed, 17 Jul 2019 21:55:37 +0000
From:   <ANDREW.LUCAS@L3T.com>
To:     <linux-rdma@vger.kernel.org>
Subject: RE: Does GPUDirect support IBV_WR_RDMA_WRITE_WITH_IMM?
Thread-Topic: Does GPUDirect support IBV_WR_RDMA_WRITE_WITH_IMM?
Thread-Index: AdU8ujJi6Yt/J6CMQ+WNC5B/WTUl7AAL+UCA
Date:   Wed, 17 Jul 2019 21:55:37 +0000
Message-ID: <CY1P110MB0295FB7F8F39ACF5C574752CD3C90@CY1P110MB0295.NAMP110.PROD.OUTLOOK.COM>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=ANDREW.LUCAS@L3T.com; 
x-originating-ip: [128.170.224.12]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f1365db8-05d6-4b2a-7130-08d70b0180b1
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:CY1P110MB0200;
x-ms-traffictypediagnostic: CY1P110MB0200:
x-microsoft-antispam-prvs: <CY1P110MB020070D7FD0CA2B3A076060FD3C90@CY1P110MB0200.NAMP110.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-forefront-prvs: 01018CB5B3
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(199004)(189003)(66476007)(6246003)(52536014)(66556008)(5660300002)(66946007)(8936002)(76116006)(81156014)(81166006)(66446008)(64756008)(3846002)(6116002)(6916009)(2351001)(9686003)(476003)(498600001)(71190400001)(71200400001)(68736007)(6436002)(86362001)(5640700003)(55016002)(229853002)(53936002)(74316002)(256004)(305945005)(25786009)(7696005)(2501003)(2906002)(99286004)(33656002)(7736002)(8676002)(956004)(186003)(26005)(486006)(66066001)(102836004)(6506007);DIR:OUT;SFP:1102;SCL:1;SRVR:CY1P110MB0200;H:CY1P110MB0295.NAMP110.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:3;MX:3;
x-ms-exchange-senderadcheck: 1
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: f1365db8-05d6-4b2a-7130-08d70b0180b1
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jul 2019 21:55:37.7158
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: ba488c5e-f105-4a2b-a8b1-b57b26a44117
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ANDREW.LUCAS@is.L3T.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1P110MB0200
X-OriginatorOrg: l3t.com
Content-Transfer-Encoding: base64
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

4oCLV2l0aCB0aGUgbGF0ZXN0wqBwZXJmdGVzdCB0b29sLCBJJ20gc2VlaW5nIHNvbWV0aGluZyBz
aW1pbGFyIChmYWlsZWQgc3RhdHVzIDQgd2hpY2ggaXMgdGhlIGxvY2FsIHByb3RlY3Rpb24gZmF1
bHQpIGJ1dCB3aXRoIHRoZSBpYl93cml0ZV9idyBpZiBJIHVzZSB0aGUgLS11c2VfY3VkYS4NCg0K
c2VydmVyOg0KLi9pYl93cml0ZV9idyAtZCBtbHg1XzAgLWkgMSAtRiAtLXJlcG9ydF9nYml0cyAt
UiAtLXVzZV9jdWRhDQoNCmNsaWVudDoNCi4vaWJfd3JpdGVfYncgLWQgbWx4NV8wIC1pIDEgLUYg
LS1yZXBvcnRfZ2JpdGdzIDE1LjE1LjE1LjXCoC1SIC0tdXNlX2N1ZGENCg0KSXQgd29ya3Mgd2l0
aG91dCB0aGUgIi0tdXNlX2N1ZGEiLg0KVGhlIGliX3JlYWRfYncgZmFpbHMgaW4gdGhlIHNhbWUg
bWFubmVyLg0KQW55IGhpbnRzPw0KDQo+U2VudDogV2VkbmVzZGF5LCBKdWx5IDE3LCAyMDE5IDEx
OjE0IEFNDQo+VG86IGxpbnV4LXJkbWFAdmdlci5rZXJuZWwub3JnDQo+U3ViamVjdDogRG9lcyBH
UFVEaXJlY3Qgc3VwcG9ydCBJQlZfV1JfUkRNQV9XUklURV9XSVRIX0lNTT8NCg0KPkRvZXMgR1BV
RGlyZWN0IHN1cHBvcnQgSUJWX1dSX1JETUFfV1JJVEVfV0lUSF9JTU0/DQo+SSBjYW4gbWFuYWdl
IGEgaG9zdCBtZW1vcnkgdG8gZ3B1IG1lbW9yeSB0cmFuc2ZlciwgYnV0IG5vdCBhIGdwdSBtZW1v
cnkgdG8gZ3B1IG1lbW9yeSwgbm9yIGEgZ3B1IG1lbW9yeSB0byBob3N0IG1lbW9yeSB0cmFuc2Zl
ciB1c2luZyBpdC4NCj5XaGVuIEkgdHJ5IGl0LCBJIGFtIGdldHRpbmcgYSBsb2NhbCBwcm90ZWN0
aW9uIGZhdWx0IHRvIHRoZSBXUi4NCj5UaGUgcGVyZnRlc3QgYXBwZWFycyB0byBvbmx5IHVzZSBJ
QlZfV1JfUkRNQV9XUklURSBhbmQgSUJWX1dSX1JETUFfUkVBRC4NCj5JdCBtYXkgYmUgbXkgdXNl
IGNhc2UgaXMgZmF1bHR5IGFuZCB0aGVyZSBpcyBhIGJldHRlciB3YXksIGJ1dCBpcyBJQlZfV1Jf
UkRNQV9XUklURV9XSVRIX0lNTSBzdXBwb3J0ZWQgYnkgR1BVRGlyZWN0Pw0KDQo+QXBvbG9naWVz
IGlmIHRoaXMgaXNu4oCZdCB0aGUgY29ycmVjdCBsaXN0Lg0KPlRoYW5rcw0KPkFuZHkNCg0KCiAg
CgpDT05GSURFTlRJQUxJVFkgTk9USUNFOiBUaGlzIGVtYWlsIGFuZCBhbnkgYXR0YWNobWVudHMg
YXJlIGZvciB0aGUgc29sZSB1c2Ugb2YgdGhlIGludGVuZGVkIHJlY2lwaWVudCBhbmQgbWF5IGNv
bnRhaW4gbWF0ZXJpYWwgdGhhdCBpcyBwcm9wcmlldGFyeSwgY29uZmlkZW50aWFsLCBwcml2aWxl
Z2VkIG9yIG90aGVyd2lzZSBsZWdhbGx5IHByb3RlY3RlZCBvciByZXN0cmljdGVkIHVuZGVyIGFw
cGxpY2FibGUgZ292ZXJubWVudCBsYXdzLiBBbnkgcmV2aWV3LCBkaXNjbG9zdXJlLCBkaXN0cmli
dXRpbmcgb3Igb3RoZXIgdXNlIHdpdGhvdXQgZXhwcmVzc2VkIHBlcm1pc3Npb24gb2YgdGhlIHNl
bmRlciBpcyBzdHJpY3RseSBwcm9oaWJpdGVkLiBJZiB5b3UgYXJlIG5vdCB0aGUgaW50ZW5kZWQg
cmVjaXBpZW50LCBwbGVhc2UgY29udGFjdCB0aGUgc2VuZGVyIGFuZCBkZWxldGUgYWxsIGNvcGll
cyB3aXRob3V0IHJlYWRpbmcsIHByaW50aW5nLCBvciBzYXZpbmcuCgo=

