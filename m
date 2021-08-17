Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B6D63EF234
	for <lists+linux-rdma@lfdr.de>; Tue, 17 Aug 2021 20:47:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233020AbhHQSrc (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 17 Aug 2021 14:47:32 -0400
Received: from mail-bn1nam07on2138.outbound.protection.outlook.com ([40.107.212.138]:11502
        "EHLO NAM02-BN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233257AbhHQSr0 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 17 Aug 2021 14:47:26 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PbalMKEYGrpFJ3VxBuSjPjA+jcwp/7dTvc7vneAUCc8HaJCHNpy8PK/kTYqtIa8Rj31f8cF9GMCk06JkZuwseagobVrw1KU0CZY7nNjTgdGOSgvSnUk8ubobN2hfNgL06s6lewjTcREb8g5buLgkNvbkPwENNAdSh2zsQWemmH9JFGws2FVkzBTy7sHyxYbXomN8S/FQ97UkCbFPKkssfWetPhJB/UvtN2OmfiSlROmcV5zoUUxcFQAc/M1IQ7C9fdjh0yh+uQqbCNK40NSx7ylsrFcbd/tepw7lqoJciC0oGLu4tEZV1UQoCp4euVJNbvPbnxl7pMCw0ZawAOLllg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cY9ed4xmu7ybTVfu6hKfVohSu1WMRNHDvuary7aSSzg=;
 b=e4ppDj5dBzNkI3mc0uJbJ0/RdAg8Ohsx2eDGvhxIB3ydyvwwBBwlUGj3edi19wykU+LiAFb0qEmn+ueSS9fcfUDy5PlvrqQhA9qXTdOOqFnh8Ir/DCUbQgvkNemSVxXabUAqV0YTU66GjZWQgV9Ih7aIJgwOLcrR6mj+cVLTlXueBqHBtmx0M/aWMJzMXzUuiHEchbA1XUl6kwmHFEqFY8qC4mvJwUPI12WMa5xxQWwWfZQzNtQk1qCEiT4XGh+V54VBwaY/7ltJ0pwcGtAUx7wlF2dC0v6BqvbZgr4Qc5JBSEQIP6G3Yh/5b6tQFCcmdSisSP+hEgkrR0c0p8dr1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cornelisnetworks.com; dmarc=pass action=none
 header.from=cornelisnetworks.com; dkim=pass header.d=cornelisnetworks.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cornelisnetworks.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cY9ed4xmu7ybTVfu6hKfVohSu1WMRNHDvuary7aSSzg=;
 b=iMjfvtcGfkxjULT+m6+VtSHZzxBISCNuhlqAhzW0BLeKy/6GUA1T8Zp9cAXV58BN5hvDUZEWuLlr0d88IFHw78o0e+7CzTf5g9THWSPcjzCb6bzrQIa3sRd8owmz8Pi8qvZ+AAe+37saVc8MigdxIs0MBFl9rQNVind8kIAVeRrrw/K2H/95XOVkpd8eG2EW0FZGJn3u/hR0mWKIWjNdvftGfilV8uZiGawI5PnK0dbKBy/NBCgSyZzexxGL+oQIMdiZ9TAKN20JhCpIYQYppue0cy+rfOZF+srhDx1ka0J0OmGT/wYU8PCcs/49KFrGfTPVbkvXvLQY2wHf0hrUCQ==
Received: from CH0PR01MB7153.prod.exchangelabs.com (2603:10b6:610:ea::7) by
 CH2PR01MB6053.prod.exchangelabs.com (2603:10b6:610:48::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4415.19; Tue, 17 Aug 2021 18:46:50 +0000
Received: from CH0PR01MB7153.prod.exchangelabs.com
 ([fe80::d897:7ba8:32ef:e745]) by CH0PR01MB7153.prod.exchangelabs.com
 ([fe80::d897:7ba8:32ef:e745%8]) with mapi id 15.20.4415.024; Tue, 17 Aug 2021
 18:46:50 +0000
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
Thread-Index: AQHXj0yz3j6i/QAMWUyKAFPjwbGrqat4C51AgAAElkA=
Date:   Tue, 17 Aug 2021 18:46:49 +0000
Message-ID: <CH0PR01MB71533E6E001E18D387AFF604F2FE9@CH0PR01MB7153.prod.exchangelabs.com>
References: <9c03a5f4-865b-000e-0206-9e01f876261a@gmail.com>
 <CH0PR01MB71533F43952BA6C56AC21C4EF2FE9@CH0PR01MB7153.prod.exchangelabs.com>
In-Reply-To: <CH0PR01MB71533F43952BA6C56AC21C4EF2FE9@CH0PR01MB7153.prod.exchangelabs.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none
 header.from=cornelisnetworks.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1ebfdc44-d0bc-4897-9147-08d961af5fa2
x-ms-traffictypediagnostic: CH2PR01MB6053:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CH2PR01MB6053CEAB6DE5136C7D72D740F2FE9@CH2PR01MB6053.prod.exchangelabs.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: GYMHaBbBtnHGau00kYzKH1jHZfjmxucGhgMqUS0wd3miYsquGAZ7UD5WnvE9k1gj3QoYKvB8sG7HtJxiUbJ3zh2aMWo01XmzZb4fVGJ25HV+Obd8aoOE9QPh43D1PIR75uwxvEa2B5ynD6j+gtTuZAWVxxVAn8pycyl8bhXt9QYLfK8BDk3BvnlJXIuuZaBjMqUHQiEbS5+AcYx0XoTDhqImhjDbtt5n7lfYe/xRLIK386AuhvvNtv0Zwf1WXMv1t1AZRSX42JqRgnc6EWuqL3hxwmTyBr71lAbCEfYL0t/Go3qmnyZyKmou4zJydw0pu6TZjmV49G8075M8q0hH4OCHTKvbetje7716sutdaCpPGrJK9yDvDTgolIm9zGICy5RhfRcgnvZJV7c3/HzsAXm/euzBNGvjhJ0v+HJ4E/R/wYiWPcdwkJMuZschJiIWSIYETOSvrazGTWYSBvL8byuPU7M9rwqQNhazouHKwMSSnH7KAMh0I4JGvSbP9bU1WrzRGCDcAMd6gB9YfLtS1qL5PjD1jNbqWyWDm7FGyfyv4NfbQGufaQ1uAGZTy4qynIbHDUc2rT0B2Bf/mEOVwnR2Ou9wWYP9qK8zG+QhvElhkUNefUxInpQxtgM79pjBRetOnnZho1Bq3I80xlnPU3LBd39yDH2rgPH8H0SLLck8lEsvIO5afeoxoGZZDi3G+LafGlSzJfS8W2vtsc8Fgw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR01MB7153.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(366004)(346002)(39840400004)(376002)(396003)(64756008)(38070700005)(66556008)(66446008)(66476007)(66946007)(76116006)(26005)(7696005)(9686003)(8676002)(186003)(5660300002)(4326008)(122000001)(2906002)(8936002)(6506007)(52536014)(478600001)(38100700002)(55016002)(71200400001)(110136005)(54906003)(316002)(86362001)(33656002)(2940100002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Y0xpWW5mcTE1SGJzM21IUUo1Y0IwZEIzOHB2dnArOW9GSS9MU3p0bGp5OFVr?=
 =?utf-8?B?eGxENHVVc25jVThpY00yaWhnb2hxRFpQVEtmS0t0MGF2Z1Y2SVJYREkzS2lD?=
 =?utf-8?B?bEFNUWQ4eHh6ZFcycFRIZXRZUkQveFlhcWFlOWlicS8venIyQS9rUW0rcGxw?=
 =?utf-8?B?MEtZZW95VE95a2N6UXRHSS9QTkEwYUNYZCtFdlV6YzFHbytSZjR2dDRvV0xr?=
 =?utf-8?B?U2JVOVJOT21mNERDQ0xWeC8vV0R6MEZHUE1wRDNQaG5GWFF6UCtqeFpSTTBP?=
 =?utf-8?B?bGUrV3pKeUtvTktrNjRCdGRVMFoweVJoeG8vOTZGSEMxQ2tCWVFxNVRZNWd6?=
 =?utf-8?B?QWhIV1k0aUYvOGZOeEdxdGxNNGZtdHhhMjdhT1F3U1U5NE9Nekp5MVhqVnRC?=
 =?utf-8?B?S0NSZ1pXU2s1QjdKSUwveU5tcjNCN3VxNmNibWY2UzFvSXlTR2tPd2hwNHhj?=
 =?utf-8?B?ZkdFdzl4OWd0MnExVGw1NURiN3Q5NzZhVi9pWXBVZnV3MlV3OEdjNmhZWFo1?=
 =?utf-8?B?SzVmVjFNS254OFVLY3VyWlRmOWk2MjNBaDVTV2Iva1dOcmlvbVFkalpXZFRM?=
 =?utf-8?B?MzRlTTRWYlI0dzVGT2IvSFJlb2JzNThIdGQ4NEVSckhhOXp3bEZoQ0liVHRC?=
 =?utf-8?B?SHpMTDNoYm8wbG1MQXp1ZUlKWG5tdlcyakwwYXViUUo5cDJJQ3JwSWRSbzY3?=
 =?utf-8?B?WUxlUFJiV0RITnVLeFd1bEgyamFQS2oyaVIyb0xqWmsya2Q4c05jc3QvRWZC?=
 =?utf-8?B?SnRNTHBpNEJJNUhLRWFNL0hyTzB3V252QnJLSUJrR1BBQWxkdU14RWpRVG0w?=
 =?utf-8?B?enNMcTh5QzZCaVpNbUdBNTkyelpkN21xeXJMWnpLMENIUnVYc3lQYnJtOVo4?=
 =?utf-8?B?VGlTV0lPUzBIWDVsWlJlelJRaHVYZ09VeldWemQwK3pNR0o2WFhUMGd3czVP?=
 =?utf-8?B?ODUvcHQzY25yWjdKQnRSK0dCU2swR1NjQnlXM1FQNTQwTUNiVUtJaUNZSGlM?=
 =?utf-8?B?WXhqVzIybnp3UjdMYWJTZkJ1Ynp0QlA3WW1WOU9RbldtSE12ZlZXWkd2czZM?=
 =?utf-8?B?dTRhQld3dFg1VHdyZisyeVQ1aWd3T3BGcWFuMi9JUm1Bb3E5aG1VY1d2KytF?=
 =?utf-8?B?TlAzeGphU2swbTZlSFlYQVo2UzYvaUgva1RsR3dHejdCWU5YZklma2VKYlhW?=
 =?utf-8?B?WDRXUUl0R2pOc2dURWl3b1JpS0VnNjdSanRQeG9pa0tNSDVEVUFNbVYvVSs5?=
 =?utf-8?B?NnpqTm1LK2Y2ZEZMckNmWXRuUXR5THM0dkszdGhvVWxSQzk0WWU1Q1RMYmxR?=
 =?utf-8?B?MkY5REhMb0xTZk9yUURFRVd1SEsvNytTcGJaWExNZzM3NkE5UXlZbHJEQ09z?=
 =?utf-8?B?dkdhamZ0WGhKeVIzZ1BxeWw1Z2NlKzBraU1rSmMxdEZqQWZTZEFteU03MG40?=
 =?utf-8?B?SFJRM0dtNStvQlhid3ZkQTM2aURRT0R3cnZoYitMR1BobGswTVRaR2FPbTdC?=
 =?utf-8?B?VWRTTHp6NlNOeHk2akJvbENzTzNKWStYZ251My9YUFUvcWk3YlRhMEwwakVX?=
 =?utf-8?B?TksrQWF5R1c4R3I4VVBheWVvMHRrVFAzYnlUK3R1TkNIcUc4ejhhUHNVSi9k?=
 =?utf-8?B?UFpnTkh3R0VZaThLQkhra1NpMm5GbUQ2NXpXTkdVd2w0TkhmOGt4UkdKOHgw?=
 =?utf-8?B?MmFCZXBMRHIrcVVGcTJKVzZnVEF2eXNaMDlSWDlERjlzMjJINlVoQTJDTVpJ?=
 =?utf-8?Q?gJ97R9bCL/mj+EhWtQ=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: cornelisnetworks.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR01MB7153.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ebfdc44-d0bc-4897-9147-08d961af5fa2
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Aug 2021 18:46:49.9882
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4dbdb7da-74ee-4b45-8747-ef5ce5ebe68a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3nQ5vVCd14N8R6/BIA3Jk+Lg1P+H4zj8reynMf+E4yhI5KbXO/o0WupGf9THQqYXQg4BQT6lYNR1BRYtjNyQC2/18jujKeAGoRedzI18d5ANea0i8OkbT2jAVhI9XVin
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR01MB6053
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

PiBTdWJqZWN0OiBSRTogW0JVR10gUkRNQS9ody9xaWIvcWliX2liYTYxMjA6IHBvc3NpYmxlIGJ1
ZmZlciB1bmRlcmZsb3cgaW4NCj4gcmN2Y3RybF82MTIwX21vZCgpDQo+IA0KPiA+IFN1YmplY3Q6
IFtCVUddIFJETUEvaHcvcWliL3FpYl9pYmE2MTIwOiBwb3NzaWJsZSBidWZmZXIgdW5kZXJmbG93
IGluDQo+ID4gcmN2Y3RybF82MTIwX21vZCgpDQo+ID4NCj4gPiBIZWxsbywNCj4gPg0KPiA+IE91
ciBzdGF0aWMgYW5hbHlzaXMgdG9vbCByZXBvcnRzIGEgcG9zc2libGUgYnVmZmVyIHVuZGVyZmxv
dyBpbg0KPiA+IHFpYl9pYmE2MTIwLmMgaW4gTGludXggNS4xNC4wLXJjMzoNCj4gPg0KPiA+IFRo
ZSB2YXJpYWJsZSBjdHh0IGlzIGNoZWNrZWQgaW46DQo+ID4gMjExMDrCoMKgwqAgaWYgKGN0eHQg
PCAwKQ0KPiA+DQo+ID4gVGhpcyBpbmRpY2F0ZXMgdGhhdCBjdHh0IGNhbiBiZSBuZWdhdGl2ZS4N
Cj4gPiBJZiBzbywgcG9zc2libGUgYnVmZmVyIHVuZGVyZmxvd3Mgd2lsbCBvY2N1cjoNCj4gPiAy
MTIwOsKgwqDCoCBxaWJfd3JpdGVfa3JlZ19jdHh0KGRkLCBrcl9yY3ZoZHJ0YWlsYWRkciwgY3R4
dCwNCj4gPiBkZC0+cmNkW2N0eHRdLT5yY3ZoZHJxdGFpbGFkZHJfcGh5cyk7DQo+ID4gMjEyMjrC
oMKgwqAgcWliX3dyaXRlX2tyZWdfY3R4dChkZCwga3JfcmN2aGRyYWRkciwgY3R4dCwNCj4gPiBk
ZC0+cmNkW2N0eHRdLT5yY3ZoZHJxX3BoeXMpOw0KPiA+DQo+ID4gSG93ZXZlciwgSSBhbSBub3Qg
c3VyZSB3aGV0aGVyIGN0eHQgPCAwIGFuZCBvcCAmDQo+IFFJQl9SQ1ZDVFJMX0NUWFRfRU5CDQo+
ID4gY2FuIGJlIHRydWUgYXQgdGhlIHNhbWUgdGltZS4NCj4gPg0KPiA+IEFueSBmZWVkYmFjayB3
b3VsZCBiZSBhcHByZWNpYXRlZCwgdGhhbmtzIQ0KPiA+DQo+IA0KPiBMb29rIGF0IHRoZSBhc3Np
Z25tZW50IHRvIGZfcmN2Y3RybCBhbmQgdGhlIGNhbGxzIHVzaW5nIHRoYXQgdmFyaWFibGU6DQo+
IDUgcWliX2liYTYxMjAuYyAgcWliX2luaXRfaWJhNjEyMF9mdW5jcyAzNDYzIGRkLT5mX3JjdmN0
cmwgPQ0KPiByY3ZjdHJsXzYxMjBfbW9kOw0KPiA2IHFpYl9pYmE3MjIwLmMgIHFpYl9pbml0X2li
YTcyMjBfZnVuY3MgNDUwOCBkZC0+Zl9yY3ZjdHJsID0NCj4gcmN2Y3RybF83MjIwX21vZDsNCj4g
NyBxaWJfaWJhNzMyMi5jICBxaWJfaW5pdF9pYmE3MzIyX2Z1bmNzIDcxOTggZGQtPmZfcmN2Y3Ry
bCA9DQo+IHJjdmN0cmxfNzMyMl9tb2Q7DQo+IA0KPiBBbGwgdGhlc2UgZnVuY3Rpb25zIGhhdmUg
dGhlIHNhbWUgImlzc3VlIi4gICBUaGUgLTEgcGFyYW1ldGVyIGltcGxpZXMgYWxsDQo+IGNvbnRl
eHRzIGFuZCB0aGUgLTEgY3R4dCBoYXBwZW5zIGZyb20gaW5pdF9hZnRlcl9yZXNldCgpIGFuZA0K
PiBxaWJfc2h1dGRvd25fZGV2aWNlKCkgYW5kIGJ5IGNvZGUgaW5zcGVjdGlvbiwgIHRoZXkgb25s
eSBvciBpbiBvcGVyYXRpb25zDQo+IHRoYXQgbGFjayBRSUJfUkNWQ1RSTF9DVFhUX0VOQiwgdGh1
cyBhdm9pZGluZyB0aGUgY29kZSBwYXRoIHRoYXQgd3JpdGVzIGENCj4gcGVyIGNvbnRleHQgQ1NS
IHVzaW5nIHRoZSBjdHh0IGFzIGFuIGluZGV4Lg0KPiANCj4gSSBkb24ndCB0aGluayB0aGlzIGlz
IGFuIGlzc3VlLg0KPiANCg0KU2Vjb25kIHRob3VnaHMuDQoNClNlZSBzZW5kY3RybF83MzIyX21v
ZCgpLg0KDQpUaGVyZSBpcyBhbiBlYXN5IGZpeCBhcyBzaG93biBpbiB0aGUgNzMyMiB2ZXJzaW9u
IG9mIHRoZSBmX3JjdmN0cmw6DQoNCiAgICAgICAgaWYgKGN0eHQgPCAwKSB7DQogICAgICAgICAg
ICAgICAgbWFzayA9ICgxVUxMIDw8IGRkLT5jdHh0Y250KSAtIDE7DQogICAgICAgICAgICAgICAg
cmNkID0gTlVMTDsNCiAgICAgICAgfSBlbHNlIHsNCiAgICAgICAgICAgICAgICBtYXNrID0gKDFV
TEwgPDwgY3R4dCk7DQogICAgICAgICAgICAgICAgcmNkID0gZGQtPnJjZFtjdHh0XTsNCiAgICAg
ICAgfQ0KICAgICAgICBpZiAoKG9wICYgUUlCX1JDVkNUUkxfQ1RYVF9FTkIpICYmIHJjZCkgew0K
DQpUaGUgYXNzaWdubWVudCB0byB0aGUgcmNkIHBvaW50ZXIgZW5zdXJlcyB0aGUgY29kZSBjYW4g
bmV2ZXIgYmUgcmVhY2hlZC4NCg0KVGhpcyB0ZWNobmlxdWUgY291bGQgYmUgcG9ydGVkIHRvIHRo
ZSBvdGhlciB0d28gcm91dGluZXMuDQoNCk1pa2UNCg==
