Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D4843EF1FA
	for <lists+linux-rdma@lfdr.de>; Tue, 17 Aug 2021 20:37:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232769AbhHQSiD (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 17 Aug 2021 14:38:03 -0400
Received: from mail-dm6nam08on2098.outbound.protection.outlook.com ([40.107.102.98]:48416
        "EHLO NAM04-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232605AbhHQSiC (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 17 Aug 2021 14:38:02 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AmA08A/N7nxLXeh3OIB31h7d8x/QHomb3Qe1n1aFINALMyMzYh0volxJkz2cGYvklSfibnVe3dRQ1ZcKuBj5Iv0/u+bmhTkUPOtEJU1cD1LWYLvAHDI/kWqwriQ10YZ0sSUE8zG3H2MccOI5CPTzu4Uz6z0hAqQ+gzQsLDFlUfMfKq4zrZcW6PMlZm+1K+SJBIE8b3n30j513/eKJkcsxC1QsJ5dCcqc53xhH4Ud7r+1/N/13mL5D0BZFYtxioFkK3y0C+qxpBJEsH2BPOEPfEO+5w3NJid+Ilgacvuvc6HKU8S3Z42aDZNX347nTN8Bk12BG09LQ8pKQcOAFgG4GQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MqkShWvz+43XvVkFludBjXY+aK3slCI7ENbvxI5sjCc=;
 b=NArbPbSfNRCIXNwDTn9f9sUCiuvr/FP4wio4KOSBdTOSu/3J0z+4Lf0A6DgNbiURF/HmLZwBeIx4yA7ecVncTOPQN1GlwiyNrJn4Va/vXe9lsniSIRigz9Brogm+S0+18xQhy5UfceZ+HyJNCl3it3If5RXvT6fwWIcfBj4FM27/0uH93DRDcjHWjlAL9kMtxLfVHmIIEIcrnoleSXj6NZzuwb9/yHkBnpfcBIjn0+1ejSSFamUmve/Htf+XUHjzdDBR3PgPQ7bXu/AbOIv7rBvOiCgoryeemUebZrIk/Ls3g7Pf9ZgeBkU49TXvkvTV/6vs9T2h1o8QpHBycoo1tg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cornelisnetworks.com; dmarc=pass action=none
 header.from=cornelisnetworks.com; dkim=pass header.d=cornelisnetworks.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cornelisnetworks.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MqkShWvz+43XvVkFludBjXY+aK3slCI7ENbvxI5sjCc=;
 b=ga4GGKK0Xw4YK+tpR5jdMTjeo6rUBb4zLKshYBnrOARMePKRdL/LpWuE42Ddp/tcD/tg4xi75qnDA0grG7hb+0s3YudIsoqmqUWtLset52wUZEv1RIqQvCzaZm8TT7sgxR2SiOkyPLJ68TqHQp20aNVADXBaGVqqe6Vb5Y63BcLIePmI4t5bqxurSMJTuEWn0ARw5jKuiTv+tG/nnXS0WABCxjwRsLRmTQafEofRim0noQHtCBZBYn7mcUmnWtQlkM99ybghu++T+SmST4wY3UycC831TDPn7pbIkUAz3XuRx71fN+DYkgVf7TeMR3TUUQ+3nzUDjyUQGysJ3NxHpg==
Received: from CH0PR01MB7153.prod.exchangelabs.com (2603:10b6:610:ea::7) by
 CH2PR01MB5656.prod.exchangelabs.com (2603:10b6:610:21::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4415.17; Tue, 17 Aug 2021 18:37:25 +0000
Received: from CH0PR01MB7153.prod.exchangelabs.com
 ([fe80::d897:7ba8:32ef:e745]) by CH0PR01MB7153.prod.exchangelabs.com
 ([fe80::d897:7ba8:32ef:e745%8]) with mapi id 15.20.4415.024; Tue, 17 Aug 2021
 18:37:25 +0000
From:   "Marciniszyn, Mike" <mike.marciniszyn@cornelisnetworks.com>
To:     Tuo Li <islituo@gmail.com>,
        "Dalessandro, Dennis" <dennis.dalessandro@cornelisnetworks.com>,
        "dledford@redhat.com" <dledford@redhat.com>,
        "jgg@ziepe.ca" <jgg@ziepe.ca>
CC:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        "baijiaju1990@gmail.com" <baijiaju1990@gmail.com>
Subject: RE: [BUG] RDMA/hw/qib/qib_iba6120: possible buffer underflow in
 rcvctrl_6120_mod()
Thread-Topic: [BUG] RDMA/hw/qib/qib_iba6120: possible buffer underflow in
 rcvctrl_6120_mod()
Thread-Index: AQHXj0yz3j6i/QAMWUyKAFPjwbGrqat4C51A
Date:   Tue, 17 Aug 2021 18:37:25 +0000
Message-ID: <CH0PR01MB71533F43952BA6C56AC21C4EF2FE9@CH0PR01MB7153.prod.exchangelabs.com>
References: <9c03a5f4-865b-000e-0206-9e01f876261a@gmail.com>
In-Reply-To: <9c03a5f4-865b-000e-0206-9e01f876261a@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none
 header.from=cornelisnetworks.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f6ef81d3-8c69-40be-291c-08d961ae0f0f
x-ms-traffictypediagnostic: CH2PR01MB5656:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CH2PR01MB56563E3A72341B223222DBCAF2FE9@CH2PR01MB5656.prod.exchangelabs.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: cNXO+qCgQw/KQTHhIZUWx9S9r+12qVql/Ny3cUm/Ys3fRjJNk4LdIcsgpYP4bI3F8moLGjLotPrWuYzn2iSCRCxyDv7p1h+KvcuAFx6qs8RPwSEY+ZjvOKe6dLnSHj8/g0Op1PtqoGbbm0oO93jjSyeg4ZXmJvcdtGsOIoS0TocTCaWMTA3oCqu764gpvmIBl/xMqnvaZZ2KGWzbFB8hQO+rPoSF3wjfQT31zw6tHt6rKvhg5g+GL/cOPcIY61yrUtZmwfbi6xYOrJAW+Tzpj6SRifNWM+GtFKjVpYYfI4bHQLCiKa9FenENVe2jyczO1FtKuL1/TWncM6VtAx+QfXIluMGvT1lW2EBXchyRKs6b9yNV2UL7J3rXwlDblXX7o5pupu1vJxob03mFMGs/vdjytVBBmFHQn69qW0XUV9xpETFduKzhapR0ii1K0demnzp/X1Xx5Sbu80A/a0u/6u6B6GVcfXw56Tm2oRNlPWBNZqP7rYICqfsbc447EV0OmAVYTqLJgXMDf2j7lv87JM5geCFm7aM13W+QmfJPsaryMqH3+XxdEA65rj/auiT51Xh/SqK3lVHfywHAQ/CQGJ2A0xt2yM6+aQDn6QP+Z0dwrchRqIQz635GTXSS2XCXwB9NeIG//AJJNVMatYAGvVygj1txKdataKFzQ2cu46smISWlmtbv6qPigJH+vhXYyDuwSBbRv87S7P9h0Mg/NA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR01MB7153.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(136003)(366004)(396003)(39840400004)(346002)(52536014)(66446008)(64756008)(66476007)(66556008)(38070700005)(33656002)(66946007)(8936002)(5660300002)(2906002)(71200400001)(76116006)(86362001)(8676002)(9686003)(6506007)(38100700002)(55016002)(478600001)(4326008)(122000001)(316002)(26005)(186003)(7696005)(110136005)(54906003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?M3NMTTEyUzRhYkgxZWZRMjNoMlpkT29BRENpZlFFb0J6UmdPeGU0WXBrMzFB?=
 =?utf-8?B?NU5hWkZRVmZTa0RHRHBtVDJaYTNNSGVuejF4VWlmMFFEbEdZcVJHOHludldq?=
 =?utf-8?B?ci9DK2w2R05MeGZDcDZiclM2TVZYZ1VySjd3WGRyT1M5OXo5ZmRhSXlxQWdQ?=
 =?utf-8?B?byt5TjJLL0pyRHZLNzByazBCanJoSUdsaDdIc1BnNU9QVC9rWkFPRGpUb1Bi?=
 =?utf-8?B?R2t3Y3FuZUhmZ1ZLSmFvM2ZtNkRKRVl0azdadm51d0hvTTJidUNXN3hCN2NI?=
 =?utf-8?B?WUs2a0pyK0ZTRHQ2MURBd3dwcEtXekVVYlZuVHdBV3ZUVGNTeFBaVE1sWjQv?=
 =?utf-8?B?cmxGazVQc0VvbDlpdzRHUCtVakJycVBrUS84clVnUll5aXNHZFhNUTNwK1Vk?=
 =?utf-8?B?Z3ZWQWF5TVhRNnZRcldQSGlaN01RZmxSL0lDZnQrcjJUL1NQaU5KQWJ1K1FN?=
 =?utf-8?B?THpSYm5yTFhMMDRzSTROL0p4N2lBUEtIcldoVmIwck9MdktpU2E0RnpzT3h5?=
 =?utf-8?B?czJ5ZzhpRUtVNDBDV1NPV1piR3hRYXMvVm9WZHY3N2ZyTnNvSDFNV3gyNVFS?=
 =?utf-8?B?WG1rUWRUTVJlTVk5a2U5dUFwQkI5RzJvSHFhWXc0UkNKM2JjUHpacHVLMTBs?=
 =?utf-8?B?WjRCVWZncWNXN0lKaWZjaC8reHUxelNDRFpJYmlWeHV5MGZFdjE0MVJSYkRr?=
 =?utf-8?B?Y3E2K2RPcXpKL2JieWF4WTVzekg1RXFqMXlTUjdxdVZIcUxVdjQxbWQzTXNY?=
 =?utf-8?B?ODFaZStEbDc2aUN3UDdOK1R2MFY5R2RySnJqZVIycnNSNlZoOFBzQlRXTUsw?=
 =?utf-8?B?RUh6elpGVnczbG5lY1NIbW1OWmNJRjVwRW9YamJIbURWbHE4UUNtVEhQWkRq?=
 =?utf-8?B?ZUp5UnB0eDBpMUUvUVZheDNzbHJYbkxHTTZtM3JSYjAzNHFNNEVVend5UDMw?=
 =?utf-8?B?NVBpMFRxc3lBRVZrQjI5MDJPVnArNi9LT3V0c1lmdXJiekdpMlVFcndGNW44?=
 =?utf-8?B?MUw0d05odCtITUx4SnZscmlWWkJkTDhXOUV4T1lURFlWNEI3VGV1VHpPdlJo?=
 =?utf-8?B?dWZtcUlpQjdJRlNXUlAwSVVGNGp4SmNRY3hsY1VWZVk3V0ZDaDlMa1RWUldN?=
 =?utf-8?B?UHBpN2VpbVlvT3Nhai84cmt5WHNaTzY5NHdabEJvZVVKZUY3d1B1cUtyNkhW?=
 =?utf-8?B?NXJ4Y0l4T091U2IybVBTcXc2UnlhdFJIMUFwdEE3dTlUSUFZZWx0TUI5ZnJK?=
 =?utf-8?B?dW5CY2NwS2hIZEhjWmxxYUFQcU5KUldzMzd3NkJ3MTJaZVZMaVBJL1E0MXZF?=
 =?utf-8?B?eUN6Ry9TWm84SmZPRmMzWDVvZmVQcldZUmhUWFNXQ0pMTmZOZFZvcC9qM1pZ?=
 =?utf-8?B?SURRZjgzRW1Nc0Nhd3NIT3hIclluTERnQUwrL3dmT1FkWFJSUm5ROTdoVS93?=
 =?utf-8?B?RnRsVzF6SVR4ZkhydlpoZVlBcUc3QSs3QncycEsrMldNSHF0bEc4bnArWHAv?=
 =?utf-8?B?ZEhHU3VIYzJyeW1qSGtiOWFrWG5qbVMxMWtkU1p6QmgwTXAyckViUzRxeFRV?=
 =?utf-8?B?aVdoSVpid1V4TG5Id2V6ckZhQW1XTm9YOVpGTlNPSFJ1V2NJN0psQzVQOXdr?=
 =?utf-8?B?Vi9uT2ZZZkpDMTYzV01QaWdSc3lCMmphQ2xZcHU3a1BNbWJJWnl1TWtYMUdu?=
 =?utf-8?B?K0Z6OHBhSjRSVmNoM0dmWlNpTU43NXU4MHYvYXhaQjJpMGk4V2pvbWhtV25Z?=
 =?utf-8?Q?4qoVBT5nVAZzufl69A=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: cornelisnetworks.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR01MB7153.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f6ef81d3-8c69-40be-291c-08d961ae0f0f
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Aug 2021 18:37:25.3062
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4dbdb7da-74ee-4b45-8747-ef5ce5ebe68a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YKZhPs+F5o8Xb7W3rsX1LHk91BAotNUgfqVA33aGgy4X6WxRasI+GUrkwIXu7sXN6rxhzcMW62AGLhE1tybV/yA8lMNGQ1iqg0+ZZIgMYGJcbHcuSJE5W22zNFGmgc9V
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR01MB5656
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

PiBTdWJqZWN0OiBbQlVHXSBSRE1BL2h3L3FpYi9xaWJfaWJhNjEyMDogcG9zc2libGUgYnVmZmVy
IHVuZGVyZmxvdyBpbg0KPiByY3ZjdHJsXzYxMjBfbW9kKCkNCj4gDQo+IEhlbGxvLA0KPiANCj4g
T3VyIHN0YXRpYyBhbmFseXNpcyB0b29sIHJlcG9ydHMgYSBwb3NzaWJsZSBidWZmZXIgdW5kZXJm
bG93IGluIHFpYl9pYmE2MTIwLmMgaW4NCj4gTGludXggNS4xNC4wLXJjMzoNCj4gDQo+IFRoZSB2
YXJpYWJsZSBjdHh0IGlzIGNoZWNrZWQgaW46DQo+IDIxMTA6wqDCoMKgIGlmIChjdHh0IDwgMCkN
Cj4gDQo+IFRoaXMgaW5kaWNhdGVzIHRoYXQgY3R4dCBjYW4gYmUgbmVnYXRpdmUuDQo+IElmIHNv
LCBwb3NzaWJsZSBidWZmZXIgdW5kZXJmbG93cyB3aWxsIG9jY3VyOg0KPiAyMTIwOsKgwqDCoCBx
aWJfd3JpdGVfa3JlZ19jdHh0KGRkLCBrcl9yY3ZoZHJ0YWlsYWRkciwgY3R4dCwNCj4gZGQtPnJj
ZFtjdHh0XS0+cmN2aGRycXRhaWxhZGRyX3BoeXMpOw0KPiAyMTIyOsKgwqDCoCBxaWJfd3JpdGVf
a3JlZ19jdHh0KGRkLCBrcl9yY3ZoZHJhZGRyLCBjdHh0LA0KPiBkZC0+cmNkW2N0eHRdLT5yY3Zo
ZHJxX3BoeXMpOw0KPiANCj4gSG93ZXZlciwgSSBhbSBub3Qgc3VyZSB3aGV0aGVyIGN0eHQgPCAw
IGFuZCBvcCAmIFFJQl9SQ1ZDVFJMX0NUWFRfRU5CDQo+IGNhbiBiZSB0cnVlIGF0IHRoZSBzYW1l
IHRpbWUuDQo+IA0KPiBBbnkgZmVlZGJhY2sgd291bGQgYmUgYXBwcmVjaWF0ZWQsIHRoYW5rcyEN
Cj4gDQoNCkxvb2sgYXQgdGhlIGFzc2lnbm1lbnQgdG8gZl9yY3ZjdHJsIGFuZCB0aGUgY2FsbHMg
dXNpbmcgdGhhdCB2YXJpYWJsZToNCjUgcWliX2liYTYxMjAuYyAgcWliX2luaXRfaWJhNjEyMF9m
dW5jcyAzNDYzIGRkLT5mX3JjdmN0cmwgPSByY3ZjdHJsXzYxMjBfbW9kOw0KNiBxaWJfaWJhNzIy
MC5jICBxaWJfaW5pdF9pYmE3MjIwX2Z1bmNzIDQ1MDggZGQtPmZfcmN2Y3RybCA9IHJjdmN0cmxf
NzIyMF9tb2Q7DQo3IHFpYl9pYmE3MzIyLmMgIHFpYl9pbml0X2liYTczMjJfZnVuY3MgNzE5OCBk
ZC0+Zl9yY3ZjdHJsID0gcmN2Y3RybF83MzIyX21vZDsNCg0KQWxsIHRoZXNlIGZ1bmN0aW9ucyBo
YXZlIHRoZSBzYW1lICJpc3N1ZSIuICAgVGhlIC0xIHBhcmFtZXRlciBpbXBsaWVzIGFsbCBjb250
ZXh0cyBhbmQgdGhlIC0xIGN0eHQgaGFwcGVucyBmcm9tIGluaXRfYWZ0ZXJfcmVzZXQoKSBhbmQg
cWliX3NodXRkb3duX2RldmljZSgpIGFuZCBieSBjb2RlIGluc3BlY3Rpb24sICB0aGV5IG9ubHkg
b3IgaW4gb3BlcmF0aW9ucyB0aGF0IGxhY2sgUUlCX1JDVkNUUkxfQ1RYVF9FTkIsIHRodXMgYXZv
aWRpbmcgdGhlIGNvZGUgcGF0aCB0aGF0IHdyaXRlcyBhIHBlciBjb250ZXh0IENTUiB1c2luZyB0
aGUgY3R4dCBhcyBhbiBpbmRleC4NCg0KSSBkb24ndCB0aGluayB0aGlzIGlzIGFuIGlzc3VlLg0K
DQpNaWtlDQoNCg0K
