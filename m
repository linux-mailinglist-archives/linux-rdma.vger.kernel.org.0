Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 919C0415C75
	for <lists+linux-rdma@lfdr.de>; Thu, 23 Sep 2021 13:03:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240491AbhIWLEn (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 23 Sep 2021 07:04:43 -0400
Received: from mail-dm6nam10on2113.outbound.protection.outlook.com ([40.107.93.113]:25601
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S240448AbhIWLEm (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 23 Sep 2021 07:04:42 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PSwjAUH/zpF8cnn3nMWbMA3JnAd3IsCf3NNwxbJBF16Uv1nVXWpY8uxcjr9Ekw17c1iZIo8DrVArY6kQUJvPC64DXGgpr9eXD5itoORg08thjnSGNpoP4lX11wKJantYI2yJ4e7g2YSCS7MnVszczGFJriqHdR12Xxr+CUFzBKBvsVJ/gcmidMiFF1zx3m/ly4Uc5VYX9wgWS+J80whla2UX2NO0SzKbf7rS/Qe6uICdv4KhymbCmsOMKIyqaNiIW0ipXpcYKwYMvBsHGp70r/HXEPd7iUqHYlT5CLg4MSTrNaleK9ILd1r1bZJvjGVEd0SLn6nf8ArSU4VJQ8AP0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=6Fb9/osvoM6CxwBmU3l7rqo5eOA6xxp66VLR3BQPwgI=;
 b=D/uw7kQsDLExqh0+8m02AWjbIAUj7am14HamtVH2FFCPTGSF6O8NIHR25emPcNFFu8XMVb3IKKVJr1ZZ/CCI9tc87cc10HP/Ox7lRC/i1UusKedWBSnTjwJvb2deF+f0Crb/jGJrg7qBW4Osq7Tx4xfdTIyF+PNArtAsItUb/flyTRgbVwO7/rV+VI5cA40Ab0GFhlGH6DOkQif+lUJQaF7LtlSCNbIYDr/ccw+y7coyGhbD3RRmJ18HVpkIvVQnLmuH3MyT/Fx3KkTxv0AUjcRhbwdBKAyVjtd6QurL/+uvosaHTcPbQfe6ZmKJbt9vySmE9sK3AlteqhlHNveCSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cornelisnetworks.com; dmarc=pass action=none
 header.from=cornelisnetworks.com; dkim=pass header.d=cornelisnetworks.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cornelisnetworks.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6Fb9/osvoM6CxwBmU3l7rqo5eOA6xxp66VLR3BQPwgI=;
 b=SnckvjINpy2LdnnXT+++eEd5CqxqjwGRribIR947EqJzy65evkEDA7ewHRQMZMkHXtWdh9QZbhFfdU5u37oWCXTlqFpesZxn8DACvPQO6+H0e/IJvD4BU6p0xBhBHUZ+0UBWLlsWj3GuM/oKw4XLNbgDyoKj+KJWFMuAXVKPyh03fW+Tym+64KI86sN9TPxf3eiPbxxEafpJT3xt0d+6Xqab0Qzmjsvv8eLIPgucJhU0bexUFOOwhvHLNzR+bRWnZyvyd3Q1d9+ZcwZK8tAKOKohAaJxkx0n5RtzJ5Zi2uHfjtnWS08AD2XcaFsFGyW2SZPgc7zn5BDtPbG5sts6rg==
Received: from CH0PR01MB7153.prod.exchangelabs.com (2603:10b6:610:ea::7) by
 CH0PR01MB6923.prod.exchangelabs.com (2603:10b6:610:104::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4544.15; Thu, 23 Sep 2021 11:03:07 +0000
Received: from CH0PR01MB7153.prod.exchangelabs.com
 ([fe80::30a8:19a9:b5c7:96cd]) by CH0PR01MB7153.prod.exchangelabs.com
 ([fe80::30a8:19a9:b5c7:96cd%9]) with mapi id 15.20.4544.015; Thu, 23 Sep 2021
 11:03:06 +0000
From:   "Marciniszyn, Mike" <mike.marciniszyn@cornelisnetworks.com>
To:     Bart Van Assche <bvanassche@acm.org>,
        Guo Zhi <qtxuning1999@sjtu.edu.cn>,
        "Dalessandro, Dennis" <dennis.dalessandro@cornelisnetworks.com>,
        "dledford@redhat.com" <dledford@redhat.com>
CC:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] infiniband hfi1: fix misuse of %x in ipoib_tx.c
Thread-Topic: [PATCH] infiniband hfi1: fix misuse of %x in ipoib_tx.c
Thread-Index: AQHXr7imk55risfKAUmS2+aCDTMROauwTzmggAAKPwCAARuAEA==
Date:   Thu, 23 Sep 2021 11:03:06 +0000
Message-ID: <CH0PR01MB71532C0E55A47C6910F47B79F2A39@CH0PR01MB7153.prod.exchangelabs.com>
References: <20210922134857.619602-1-qtxuning1999@sjtu.edu.cn>
 <CH0PR01MB71536ECA05AA44C4FAD83502F2A29@CH0PR01MB7153.prod.exchangelabs.com>
 <276b9343-c23d-ac15-bb73-d7b42e7e7f0f@acm.org>
In-Reply-To: <276b9343-c23d-ac15-bb73-d7b42e7e7f0f@acm.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: acm.org; dkim=none (message not signed)
 header.d=none;acm.org; dmarc=none action=none
 header.from=cornelisnetworks.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f2821988-2e8c-430f-a723-08d97e81b8e6
x-ms-traffictypediagnostic: CH0PR01MB6923:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CH0PR01MB69238D3D89813BD03D751701F2A39@CH0PR01MB6923.prod.exchangelabs.com>
x-ms-oob-tlc-oobclassifiers: OLM:5236;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 9b/0gK/CF3e+bRg31giczHjBPfXT9V07KIkRVZ9U6BJSMQ0+KpgbZwt7vea3qMmLVTu2RdXXpuHYJirCvWsJhi/IfEt36Lf3WN6OdltVtjjZAtkaRrKpb6le+R+noQR0uTT1R+nvcAN6HPuqJ/UVaYmnOX+5fHcXKMP2KAxXblFP8LM96982je++gmUHisqOvaLyjfeH3ceqWEvzMD/xOGBwYNILJXUKg21iaoWYHTIsjmGzKlBj28b++4ZnE0LwfTuIIAMuq4iNXXR8QrNi3nUpMU3TZfq3ECllhC/guyE/Ix0Mv8ilPPPSrsYOG/upnPS2g/kTs/wVwv6UKvcFCToCX/oiJQ+3KyX9gsPVwlSEHyDY/vQOqhEyXBFRKcLzD0LMIpVW7odtNffBjYlMHJnnBnyB7FcWb2pVpUeXbxil49/SRRHuakxyRvYXNUDCiSqHq2TvzhRO4sMSPerSY8d0Y5Ie1/sM4LzYHrcsEi9ZC/qpCTjt1eJpi0moOlJSj1+iiinzmhpieJ2DWHt0Q9KV8EqaIhfHvgXAuGHCb1ZQMmI7GZON98bBZ2Ir/E1hVRNjssEV3zT0t8rSlXFaWSD4EdSIWf09WOw/HUCf7fVuM09mxsVmRkIexNHbL4nLJBspj9mGVn+klBm5bTvPVzxmLjaNZlfSkr8V5tT7mp+kjs0K7nLM+GWmMd+uoR6JnNUM6UZ0mM6STU/5NDYNIw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR01MB7153.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(136003)(396003)(346002)(39840400004)(366004)(54906003)(2906002)(8936002)(76116006)(110136005)(55016002)(4326008)(66476007)(66446008)(9686003)(66946007)(122000001)(4744005)(71200400001)(64756008)(38100700002)(5660300002)(52536014)(66556008)(316002)(8676002)(33656002)(508600001)(38070700005)(7696005)(26005)(186003)(6506007)(86362001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?b2hjZit6VDZLWFlsQTRPUHVFYjRhNHNOeDVaNzFIdWNBV1MxL3M3RW5QdlpZ?=
 =?utf-8?B?ZnRPa3VVZnpOaXVPRVZYazhjd3B3c1JSOXBPem9lRXJCQWlZVVBkdHRkSHR3?=
 =?utf-8?B?ekR4U1NLNVl4R1M4eFlLcXBUSEpNVy9mM096a2U2clhhTWZWZno4UlRwRm81?=
 =?utf-8?B?RUdsLzB2aE9YWk5Ba3EzczQ1dE9BUkN2Y01ROGNlMFpsd2QwWlk0SEpNMkdm?=
 =?utf-8?B?d1N2NHBKMDBYV3pUMll4ZXRHNnlxZTV5cEoxZGNCekU1SGdNMnYyOTc3SEww?=
 =?utf-8?B?dkFyN2NoZi92NVBvR0NMbUgzbm10eGh3WnNNZnZOVlZDWXIzMjF5dVl6cjRm?=
 =?utf-8?B?SThaNitCOXpCVVg2MGwydGxCN0h6anBjNmhrbzdhWFV6VTJ5cjVrWjhWb1ZV?=
 =?utf-8?B?TytFSnREd0RPT0lIaFdhZ1pWVXRaZ2wvVW84VVZqemI1bS9ETVA0Um1UY3B5?=
 =?utf-8?B?OWg2MW0wU01hbTJFbWFtMzk3cHpjT3dNbUhKUkVscU5FV0drWSt6Mnd1N1JB?=
 =?utf-8?B?cTFKY1k0M0E2Ulppck9Fc0pqdnZseExMWFpnZm9SY1k2TFRGNTAzM3E4WTFt?=
 =?utf-8?B?WlBndXlZK1I3NUN0LzROZlBaZ0UzaGNtSW8xNklrR1ZXWi94VHNqMCs3bkg5?=
 =?utf-8?B?VkJHRmpwRlc0azd3SFJKbVFmd3MrNHBPUEJNT2NnazN4b00wZE4vcWlWcVQ1?=
 =?utf-8?B?MnRLQTFCNHZLb1EraExNWTYyRUQ2dWpGODZ3M2docTFEcytscnVXUGpqTmpY?=
 =?utf-8?B?RStJTnJqRUxobFZ3WDdXT1Q0cUY0RlRwVVpjNnBIelFCcnJOVHZuYTBSSUhm?=
 =?utf-8?B?ZFpuYlBodjIvUm9SYkhRYTVyVEpoNmx0WVlRYkZQYzh3V1NUWEpIMld2bzFC?=
 =?utf-8?B?UzFJZmwrZHAvMXQyWjVYYWhTSVoxcVRXek9oS2paS3RmT0VKbWFLTjJ4MHRn?=
 =?utf-8?B?MlNDbHp2YjBpdlk5VmFMSGlLMjk3ZjBsZHg0YmlxV0U3cGk5djFySzVYVlJX?=
 =?utf-8?B?dDUycWlsNVpySG82UGZtbk9GMjdKMUVJWTgwSEVKSmlEUDQzemVvL00zVWxR?=
 =?utf-8?B?dEU4UlQwVHR1aTE0b3dtVlV6SUtQUk1MQVRITy9xMEZ2Y3dZZXNpLzEvRzJD?=
 =?utf-8?B?SGx2Z1lQMVI5bjczVmVSY0NEeTNoNFFXYWlURm9vUlp5b2hDSFl1bjUvUjFI?=
 =?utf-8?B?cjlLb1pqTjM3NEZtREpHbS9LaXBIUUN3OEdkRGc4SGZVd2ZpTFUydFpveWZH?=
 =?utf-8?B?WjVZTFZKWmJjOXZ3NG1meU13b08xanlVeWRqT0tES0pVQ1lsN09UUGhZQVpN?=
 =?utf-8?B?bnJLZm5DdmJwemZlNmdXekJGdElwYXdOejN4UUs1dGc0SFMySG1nZEIwSUNr?=
 =?utf-8?B?a09YWWFvbStwTlY2Y3I0dmozaUhxdktua2NHN2dSVEdSMjg3YVlYOVVZT2Fr?=
 =?utf-8?B?V1F4b0FqMGdZenFqN09jSHBPUmxwcTl5MGJiY3VueG5JTU9PMEJVcUdMQzNm?=
 =?utf-8?B?YStQVGhSWktPcVB6cmtQTDRCdWZGbHd2Yk9hT3dsQjlwVitwWHZYSXNFZnZp?=
 =?utf-8?B?aXlkaTR1aWtuVGt0aGFnOFBQUnZKdzhNeDRaUFRwWDVtTUs1a0RNaEFHTnh1?=
 =?utf-8?B?T0xXbGRHVlNNRmwvamF5VVJ6dDBjVXpkYjFUS0FZanpHN1ZmaG5TdjNVdnQw?=
 =?utf-8?B?MklGYVhDT09DSTZzWFJnVG5uaG5HcmpJa2FUYi9TT004K3NRaE1neWhoTkpj?=
 =?utf-8?Q?w74mGfSas0EzN/CYtg=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: cornelisnetworks.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR01MB7153.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f2821988-2e8c-430f-a723-08d97e81b8e6
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Sep 2021 11:03:06.3847
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4dbdb7da-74ee-4b45-8747-ef5ce5ebe68a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6sxxb8+1QSJ3G/tYp24zk+zcXU2fwUDmcaWPG3a9NzQ6C0jO8TokhuFW9oU3EeyBRrn3Xkb+gbzy+ofQnCee+lGLqxW2FuHXePkezAfEBy+72vOxYGox3lKlRgrmwh3K
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR01MB6923
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

PiBIb3cgYWJvdXQgYXBwbHlpbmcgR3VvJ3MgcGF0Y2ggYW5kIGFkZGluZyBhIGNvbmZpZ3VyYXRp
b24gb3B0aW9uIHRvIHRoZQ0KPiBrZXJuZWwgZm9yIGRpc2FibGluZyBwb2ludGVyIGhhc2hpbmcg
Zm9yICVwIGFuZCByZWxhdGVkIGZvcm1hdCBzcGVjaWZpZXJzPw0KPiBQb2ludGVyIGhhc2hpbmcg
aXMgdXNlZnVsIG9uIHByb2R1Y3Rpb24gc3lzdGVtcyBidXQgbm90IG9uIGRldmVsb3BtZW50DQo+
IHN5c3RlbXMuDQo+IA0KDQpUaGUgcHJpbnRzIGFuZCB0cmFjZXMgYXJlIGxlYXZlLWJlaGluZCBh
bmQgaW50ZW5kZWQgb25jZSBpbiBhIGRpc3RybyBmb3IgZmllbGQgc3VwcG9ydC4NCg0KUmUtZ2Vu
ZXJhdGluZyBhIGRpc3RybyBrZXJuZWwgaXMgbm90IHJlYWxseSBhbiBvcHRpb24uDQoNCk1pa2UN
Cg==
