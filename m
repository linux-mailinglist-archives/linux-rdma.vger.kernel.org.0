Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2F52B150FE8
	for <lists+linux-rdma@lfdr.de>; Mon,  3 Feb 2020 19:48:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728185AbgBCSsA (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 3 Feb 2020 13:48:00 -0500
Received: from mail-eopbgr770075.outbound.protection.outlook.com ([40.107.77.75]:38215
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728176AbgBCSsA (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 3 Feb 2020 13:48:00 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ELq/cOQXy6sNRp+gZHFZC9qHE9z7upYQ+VoCi1g+S9Sqf9JUddurXlaw4Kq5kQ2YxNZReNKME6V3yJ7cP58oEgFNrKoneisjFQ7uhP0+ataI91N0uAVVzDt/sioLNLrLrHPF9ITzQQ8Sz7BRfFwO9RBrJmgRNptHFeIMgWf+cMdp2Ggt7fpI2PZzQFG6qhPn9gKt5CKHCkR04/ikKQJ5Oax9maZFmvvW+11CPC/5MlHl1B8wiKRQn/cIm6EdzoxGBd/SsOqrVT0YIlmol4t1s1IB2rfWKzgmtvk9h63+YW1vB2B4sqz9jD9QuzbvsTtAszzqWx/dep/Q7Oshcn6MnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jLiD5yLk2dbbm5MSLHo7duCTq07/ShuDjuWPUzbHDWs=;
 b=CSZFdqB9CowIm58Cm4KBacMUVip3FydnRRKOizY4ty8fscyhuUWIXr5wDiZSvW0v0SrWYGgdPbSyQB49h4IYH5bjsTRgbNqvezZgQt54Pi5dx+U+BmL8kjTRvjnzY2ZifSjEquEsDZsALLgUjtbVbGTsLC62oHChrezMSgUOXxcc7gTyOD8yuILp+I3WyK0h+YkCfdrHEpfStvKpzFBnyFWVB1NQ3pHG+L0NO8kLAUI+I4USjpN5mMOUuM8Kg5Vnx594G08tB4T+/IWAl54p3qW9WGZztD6jK+dx327w4a3A/YPQ7U/bZLzRRrxIHVXgztculZOcDfrdopzCbqVsUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vmware.com; dmarc=pass action=none header.from=vmware.com;
 dkim=pass header.d=vmware.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jLiD5yLk2dbbm5MSLHo7duCTq07/ShuDjuWPUzbHDWs=;
 b=Ee8+TwqcV1OmWGhVmu4qKGs3QpBv02E73w7PvgNkbhf/qEYonH6Si4u6T8M1XwbWEJmdj2sKIJUCh45/PykKj6issCBtxUCNLbO+/Q4uE861SnBeG4bUqV4MxCPAZjCgWF8xs698HArb6gn4YcAWVAIVZqb8mxCmBdUjXchUZHw=
Received: from BYAPR05MB5511.namprd05.prod.outlook.com (20.177.186.28) by
 BYAPR05MB4856.namprd05.prod.outlook.com (52.135.235.146) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2707.14; Mon, 3 Feb 2020 18:47:57 +0000
Received: from BYAPR05MB5511.namprd05.prod.outlook.com
 ([fe80::2cad:e39c:df45:c1c6]) by BYAPR05MB5511.namprd05.prod.outlook.com
 ([fe80::2cad:e39c:df45:c1c6%6]) with mapi id 15.20.2707.016; Mon, 3 Feb 2020
 18:47:57 +0000
Received: from elrond.eng.vmware.com (66.170.99.1) by MWHPR04CA0050.namprd04.prod.outlook.com (2603:10b6:300:6c::12) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2686.32 via Frontend Transport; Mon, 3 Feb 2020 18:47:56 +0000
From:   Adit Ranadive <aditr@vmware.com>
To:     "\"Yuval Shaia yuval.shaia.ml\"@gmail.com" 
        <"Yuval Shaia yuval.shaia.ml"@gmail.com>,
        Pv-drivers <Pv-drivers@vmware.com>,
        "dledford@redhat.com" <dledford@redhat.com>,
        "jgg@ziepe.ca" <jgg@ziepe.ca>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
CC:     Yuval Shaia <yuval.shaia.ml@gmail.com>
Subject: Re: [Suspected Spam] [PATCH] RDMA/vmw_pvrdma: Disable device before
 releasing PCI region
Thread-Topic: [Suspected Spam] [PATCH] RDMA/vmw_pvrdma: Disable device before
 releasing PCI region
Thread-Index: AQHV2sDVjnVvDFwChEa67g57GPVvqagJz2EA
Date:   Mon, 3 Feb 2020 18:47:57 +0000
Message-ID: <11a5cd4a-ea10-4068-e3ee-332f5608a2bb@vmware.com>
References: <20200203183604.10801-1-yuval.shaia.ml@gmail.com>
In-Reply-To: <20200203183604.10801-1-yuval.shaia.ml@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MWHPR04CA0050.namprd04.prod.outlook.com
 (2603:10b6:300:6c::12) To BYAPR05MB5511.namprd05.prod.outlook.com
 (2603:10b6:a03:1a::28)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=aditr@vmware.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [66.170.99.1]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 235ca642-da93-4c2e-643a-08d7a8d995cf
x-ms-traffictypediagnostic: BYAPR05MB4856:|BYAPR05MB4856:
x-ld-processed: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR05MB485696FC02D592D5EE81B832C5000@BYAPR05MB4856.namprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:989;
x-forefront-prvs: 0302D4F392
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(136003)(39860400002)(366004)(396003)(346002)(376002)(199004)(189003)(71200400001)(8936002)(52116002)(86362001)(31686004)(110136005)(4326008)(8676002)(31696002)(186003)(6486002)(7696005)(53546011)(81156014)(16526019)(2616005)(2906002)(956004)(81166006)(26005)(316002)(66556008)(66476007)(478600001)(64756008)(36756003)(66946007)(5660300002)(66446008)(2621003);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR05MB4856;H:BYAPR05MB5511.namprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: vmware.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: u2TY0lvIF8Zd/Gucie9URr1Tn3LaPmUoGCU2G94eoj6f1l57d0y/U3FxUhBgUIhyRFNdjQsiis5jQf27yGlCcifRKEc0enOXYVZxK8m2r1n+GvL4GOKAeK7mcVzJrW4HUK5Wz0EPOQHqCo7cxBgFIO1QrqiMJyWpzZNdhDLVtLAkRl0ygafCr/MqLCZ6jkaKTICmYdPTaKr6XE/gcndZ3dbjZCIRQI39/hEeM0Lpqc5ynYQyqOqcv83KqtfCplLziuEypDzDCtmFlxSaUs6fI1hXlOpDwNg/D0IMlbbhDk2EuojM2h6i4VpxKM4Nt2kSd1IrjU3xjDXvxGC2Vc9xr1SNJG9sOqUef07k6V54AnQBifshmU3YVjFJbN4bAsRWjb3K1gnUb7AX9u1soS5azPgDaQRw1AuMsIAX75gECLWXmsJZHingS+aBuMYp7C5sF7xfs358ewRa2c/lA4/zU6D+sNqSCtqwo66QhQw+OFU=
x-ms-exchange-antispam-messagedata: 0RRoQ/36vbRxyKnQ3Kb3Xn+c9cYXdq3/VQuPFxnOWY86EXe+t5sA9omCzGiTjsUHoTk/dEUQVOzSFCpN64QBbWXD/sD5C2JJf+KbLA+gdDEjZNjC/gb5NdzLV5rZWzJIziPPpO2E9pP3yQLeV7V2TA==
Content-Type: text/plain; charset="utf-8"
Content-ID: <B0AFEA75DEBF54468AE240E2A019FD55@namprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 235ca642-da93-4c2e-643a-08d7a8d995cf
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Feb 2020 18:47:57.4888
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: appcB9hQ799+oqZy2U+l4YRB7fGu1FmdaRN+KfU0cIO+J6ufOWQfVOxcIg3/t7K5qXIj40bbmw5aBcYOf2oP6w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR05MB4856
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

T24gMi8zLzIwIDEwOjM2IEFNLCAiWXV2YWwgU2hhaWEgeXV2YWwuc2hhaWEubWwiQGdtYWlsLmNv
bSB3cm90ZToNCj4gRnJvbTogWXV2YWwgU2hhaWEgPHl1dmFsLnNoYWlhLm1sQGdtYWlsLmNvbT4N
Cj4gDQo+IEZyb20gRG9jdW1lbnRhdGlvbi9QQ0kvcGNpLnR4LnR4dDoNCj4gRHJpdmVycyBzaG91
bGQgY2FsbCBwY2lfcmVsZWFzZV9yZWdpb24oKSBhZnRlciBjYWxsaW5nDQo+IHBjaV9kaXNhYmxl
X2RldmljZSgpIGluIG9yZGVyIHRvIHByZXZlbnQgdHdvIGRldmljZXMgY29sbGlkaW5nIG9uIHRo
ZQ0KPiBzYW1lIGFkZHJlc3MgcmFuZ2UuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBZdXZhbCBTaGFp
YSA8eXV2YWwuc2hhaWEubWxAZ21haWwuY29tPg0KPiAtLS0NCj4gIGRyaXZlcnMvaW5maW5pYmFu
ZC9ody92bXdfcHZyZG1hL3B2cmRtYV9tYWluLmMgfCAyICstDQo+ICAxIGZpbGUgY2hhbmdlZCwg
MSBpbnNlcnRpb24oKyksIDEgZGVsZXRpb24oLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJz
L2luZmluaWJhbmQvaHcvdm13X3B2cmRtYS9wdnJkbWFfbWFpbi5jIGIvZHJpdmVycy9pbmZpbmli
YW5kL2h3L3Ztd19wdnJkbWEvcHZyZG1hX21haW4uYw0KPiBpbmRleCA3ODBmZDJkZmMwN2UuLjNl
ZjViNGI2MGY0MiAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9pbmZpbmliYW5kL2h3L3Ztd19wdnJk
bWEvcHZyZG1hX21haW4uYw0KPiArKysgYi9kcml2ZXJzL2luZmluaWJhbmQvaHcvdm13X3B2cmRt
YS9wdnJkbWFfbWFpbi5jDQo+IEBAIC0xMTM3LDggKzExMzcsOCBAQCBzdGF0aWMgdm9pZCBwdnJk
bWFfcGNpX3JlbW92ZShzdHJ1Y3QgcGNpX2RldiAqcGRldikNCj4gIAlpYl9kZWFsbG9jX2Rldmlj
ZSgmZGV2LT5pYl9kZXYpOw0KPiAgDQo+ICAJLyogRnJlZSBwY2kgcmVzb3VyY2VzICovDQo+IC0J
cGNpX3JlbGVhc2VfcmVnaW9ucyhwZGV2KTsNCj4gIAlwY2lfZGlzYWJsZV9kZXZpY2UocGRldik7
DQo+ICsJcGNpX3JlbGVhc2VfcmVnaW9ucyhwZGV2KTsNCj4gIAlwY2lfc2V0X2RydmRhdGEocGRl
diwgTlVMTCk7DQo+ICB9DQo+ICANCj4gDQoNCkxvb2tzIGZpbmUgdG8gbWUuIFBsZWFzZSBhZGQg
YSBGaXhlcyB0YWcgYW5kIGNjIHN0YWJsZS4NCkFja2VkLWJ5OiBBZGl0IFJhbmFkaXZlIDxhZGl0
ckB2bXdhcmUuY29tPg0K
