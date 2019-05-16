Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6F7BE20F43
	for <lists+linux-rdma@lfdr.de>; Thu, 16 May 2019 21:38:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726814AbfEPTi1 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 16 May 2019 15:38:27 -0400
Received: from mail-eopbgr800079.outbound.protection.outlook.com ([40.107.80.79]:63664
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726586AbfEPTi1 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 16 May 2019 15:38:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LeCCauCROJqZbr5HafUyNVW3xRDyR0Lw75901kKq5/w=;
 b=x8uI/n0r80g4l46q9XbqWpKQGW8BMEtOowcaAE6yHhBdtMPcODk3HP7+PQSXhkmCC+L7HMCAI4DMNsDG33FxEapyDDPOiAVxfcUQMxiUQ+kmjlRrNVvufdLRpd1Kp1k0ZSw6L45SMgU529oSLT70Yi6ueC442mQWSLGUBpNxZjY=
Received: from BYAPR05MB5511.namprd05.prod.outlook.com (20.177.186.28) by
 BYAPR05MB5526.namprd05.prod.outlook.com (20.177.186.79) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1900.15; Thu, 16 May 2019 19:38:20 +0000
Received: from BYAPR05MB5511.namprd05.prod.outlook.com
 ([fe80::d99b:a85f:758a:f04b]) by BYAPR05MB5511.namprd05.prod.outlook.com
 ([fe80::d99b:a85f:758a:f04b%7]) with mapi id 15.20.1922.002; Thu, 16 May 2019
 19:38:20 +0000
From:   Adit Ranadive <aditr@vmware.com>
To:     Jason Gunthorpe <jgg@mellanox.com>
CC:     "dledford@redhat.com" <dledford@redhat.com>,
        Bryan Tan <bryantan@vmware.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Pv-drivers <Pv-drivers@vmware.com>
Subject: Re: [Suspected Spam] Re: [PATCH for-next] RDMA/vmw_pvrdma: Use
 resource ids from physical device if available
Thread-Topic: [Suspected Spam] Re: [PATCH for-next] RDMA/vmw_pvrdma: Use
 resource ids from physical device if available
Thread-Index: AQHVDBSlkap1QWBkwEm57ccCex0bMqZuEk2A//+TToCAAHj7gIAAByYA
Date:   Thu, 16 May 2019 19:38:20 +0000
Message-ID: <94537058-49f0-63b6-26c5-70e85d9e9c82@vmware.com>
References: <1558031071-14110-1-git-send-email-aditr@vmware.com>
 <20190516182901.GH22573@mellanox.com>
 <9b951e0f-e662-197a-8af2-a0fd57744aee@vmware.com>
 <20190516191253.GJ22573@mellanox.com>
In-Reply-To: <20190516191253.GJ22573@mellanox.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BYAPR07CA0090.namprd07.prod.outlook.com
 (2603:10b6:a03:12b::31) To BYAPR05MB5511.namprd05.prod.outlook.com
 (2603:10b6:a03:1a::28)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=aditr@vmware.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [66.170.99.1]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9760514c-08b0-4c42-9c3e-08d6da360cf8
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(2017052603328)(7193020);SRVR:BYAPR05MB5526;
x-ms-traffictypediagnostic: BYAPR05MB5526:
x-ld-processed: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0,ExtAddr
x-microsoft-antispam-prvs: <BYAPR05MB552695801669907C260E6B3EC50A0@BYAPR05MB5526.namprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 0039C6E5C5
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(376002)(39860400002)(396003)(366004)(136003)(189003)(199004)(31696002)(86362001)(36756003)(6246003)(11346002)(81156014)(2616005)(107886003)(8676002)(81166006)(316002)(8936002)(486006)(6916009)(476003)(305945005)(446003)(7736002)(478600001)(68736007)(14454004)(4326008)(2906002)(14444005)(256004)(229853002)(31686004)(53546011)(66066001)(71190400001)(6512007)(6506007)(5660300002)(186003)(99286004)(73956011)(64756008)(66476007)(26005)(66946007)(66556008)(66446008)(71200400001)(102836004)(52116002)(25786009)(386003)(6116002)(3846002)(6486002)(54906003)(76176011)(53936002)(6436002);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR05MB5526;H:BYAPR05MB5511.namprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: vmware.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: +MXcyh5yKXC4h3Cov1ouV0g1hyMbI6cUyyhG0fcOU2RdlzBNuhoUSha7ujXzfPuLgl7msMLIVriwL/ndmQJ+NXiHZVjpnwjeBg9WwWZTw8hqKZkjJ6Pf0Lu8cVpXBiads40LbFdFCMF2uI+qG84G29W62RJm31UOzIHQO7S3V92jPLU2YICP/rmr88MJvjKbA/MWJeTsoS8ES1yXWAf7bMAPVB0C9vWCq9G3eKAS7R83ftwNnP96zXQGCK/OQ+ZFctMGP6JwB0usUryWc8d71PF1pqrI9ltivpZNGturxxw38D1+vqi7Om7nKon7lbRI4ibhpe8G2Eq3dFOrAKAP92bzLhD/A70DAmtg3/sFoZMcKyc6hYFfxpv5GJCYvj/m8K1xFEAtmZDO0saqGwqmRjMQOnBN4pwIIlDUPoJALAY=
Content-Type: text/plain; charset="utf-8"
Content-ID: <849C883131EED1459E9796C7BEBA29D3@namprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9760514c-08b0-4c42-9c3e-08d6da360cf8
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 May 2019 19:38:20.3760
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR05MB5526
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

T24gNS8xNi8xOSAxMjoxMiBQTSwgSmFzb24gR3VudGhvcnBlIHdyb3RlOg0KPiBPbiBUaHUsIE1h
eSAxNiwgMjAxOSBhdCAwNjo1OTo0NVBNICswMDAwLCBBZGl0IFJhbmFkaXZlIHdyb3RlOg0KPj4+
PiBkaWZmIC0tZ2l0IGEvaW5jbHVkZS91YXBpL3JkbWEvdm13X3B2cmRtYS1hYmkuaCBiL2luY2x1
ZGUvdWFwaS9yZG1hL3Ztd19wdnJkbWEtYWJpLmgNCj4+Pj4gaW5kZXggNmU3M2YwMjc0ZTQxLi44
ZWJhYjExZGFkY2IgMTAwNjQ0DQo+Pj4+ICsrKyBiL2luY2x1ZGUvdWFwaS9yZG1hL3Ztd19wdnJk
bWEtYWJpLmgNCj4+Pj4gQEAgLTQ5LDcgKzQ5LDkgQEANCj4+Pj4gIA0KPj4+PiAgI2luY2x1ZGUg
PGxpbnV4L3R5cGVzLmg+DQo+Pj4+ICANCj4+Pj4gLSNkZWZpbmUgUFZSRE1BX1VWRVJCU19BQklf
VkVSU0lPTgkzCQkvKiBBQkkgVmVyc2lvbi4gKi8NCj4+Pj4gKyNkZWZpbmUgUFZSRE1BX1VWRVJC
U19OT19RUF9IQU5ETEVfQUJJX1ZFUlNJT04JMw0KPj4+PiArI2RlZmluZSBQVlJETUFfVVZFUkJT
X0FCSV9WRVJTSU9OCQk0CS8qIEFCSSBWZXJzaW9uLiAqLw0KPj4+DQo+Pj4gRG9uJ3QgbWVzcyB3
aXRoIEFCSSB2ZXJzaW9uIHdoZW4gYWxsIHlvdSBhcmUgZG9pbmcgaXMgbWFraW5nIHRoZQ0KPj4+
IHJlc3BvbnNlIG9yIHJlcXVlc3Qgc3RydWN0IGxvbmdlci4NCj4+DQo+PiBIbW0sIEkgdGhvdWdo
dCB3ZSBhbHdheXMgaGFkIHRvIHVwZGF0ZSB0aGUgQUJJIGluIGNhc2Ugb2Ygc3VjaA0KPj4gY2hh
bmdlcyBhcyB3ZWxsPw0KPiANCj4gTm8uIE9ubHkgaWYgeW91IGJyZWFrIHRoZSBBQkkuIERvbid0
IGJyZWFrIHRoZSBBQkkuDQo+IA0KPj4gUHJldmlvdXNseSwgd2Ugd2VyZW4ndCBjb3B5aW5nIG91
dCBxcHJlc3AgdG8gdWRhdGEgYXQgYWxsIGFuZCB0aGlzDQo+PiBhZGRzIGEgbmV3IHJlc3BvbnNl
IHRvIHVzZXItc3BhY2UuICBBbHNvLCB3b3VsZG4ndCBvbGRlciByZG1hLWNvcmUNCj4+IHByb2Jh
Ymx5IGJyZWFrIGJlY2F1c2Ugb2YgdGhpcyBzaW5jZSBpdCBhc3N1bWVzIHRoZSBxcG4gcmVwb3J0
ZWQgaXMNCj4+IHRoZSB2aXJ0dWFsIG9uZT8gSSBndWVzcyB0aGF0J3MgYSBidWcgYWxyZWFkeSBm
cm9tIGEgYmFja3dhcmQgY29tcGF0DQo+PiBwZXJzcGVjdGl2ZS4uDQo+IA0KPiBJbmRlZWQsIGRv
bid0IGJyZWFrIHRoZSBBQkkgOikNCg0KTGV0IG1lIHNlbmQgb3V0IGEgZml4IGZvciB0aGF0IGZp
cnN0IGFuZCB0aGVuIEknbGwgbG9vayBhdCByZW1vdmluZyB0aGUNCkFCSSB1cGRhdGVzIHRvIHRo
aXMgcGF0Y2guDQoNCj4gDQo+IEphc29uDQo+IA0KDQo=
