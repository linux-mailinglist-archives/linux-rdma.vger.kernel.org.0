Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BAE853D7703
	for <lists+linux-rdma@lfdr.de>; Tue, 27 Jul 2021 15:43:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232136AbhG0Nn4 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 27 Jul 2021 09:43:56 -0400
Received: from mail-mw2nam10on2094.outbound.protection.outlook.com ([40.107.94.94]:50912
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232123AbhG0Nnz (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 27 Jul 2021 09:43:55 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MoCpaVSE+TXSYrNwybMmBisa8N4jrn+6UvfHwfXVxM1v1vUKPEEjCurtbgv5Nw5SUBQxbhp0yGMd7c3DcNtXyAU3eKMTYBadt9oelHclnrKwZYguSSAScNOeni6TgL+z5qiYfhuQmiL8R3pb5+g1wEUeY7cAiryNCErQcLgBwta/wreqdgaTiKIy+L58eJSxmk+rIyn8GSDm7OImPqgRUO9btn8PSdiEpK+rDbZA5CRptYlAD/ms1ChnESDHJ9mipMOTt677b4Br6a5dW/sKVP6y290pbM428tDwtFUS3I3N7lHHG2tk8z4iuYDHQBCv9S1LZhRryfFDgmh4PFs9yA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UAqwGM9Hkz5M4z+B/Xeqb5tV4mlIsH8s97412QSwrbk=;
 b=GtiRTIllrVqhA6CcJaGLqw1zaeWWGPz9CvPFOrZqu/ESbxsVMlvp6tC9sf0YztEVKxJaWkGfyicB1UamjAm7WH5Z2RODwMX/h1OnYEu5oMhpy/I+7lDo0CH2lcZQ0D3YvZ//xbLnQNDmHHRdgRYSGHgDK5Gjf2LuutkLpiPR3E8PLP6oZ1PBi1ies0AIppeiOwmdLpGYDsojAmqHuyGBgnOM/QG6ahQv2ldF02R/B69f79QG2FkJ44kFcDDGqYbDAq/+vZ0ldqhFLzFPmx7JruVY4o5T5U7+CREy8xEuYwnDrI/IFju66LD1isbefPh4hVQGaqYEba1+I9p67yixIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cornelisnetworks.com; dmarc=pass action=none
 header.from=cornelisnetworks.com; dkim=pass header.d=cornelisnetworks.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cornelisnetworks.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UAqwGM9Hkz5M4z+B/Xeqb5tV4mlIsH8s97412QSwrbk=;
 b=augv+vI2s8yIEGXJ+HmCcvhtXQia68Z19kSPKO20/3a2gKcZN9/NBrAAH4qfKL9N3YQiEcWUFtwryZXeT/+IjCTWKmnY5RYAubLHbcJ34TZ16c+u8aplYiSSTS9iVjEmmfwSKQ/7U6NGdx9tA0s5foxQR+EwZLZvNjkwa9LwGJ+ZTO6vxavofyVWms08tHiV5obkhwZOSzNw2IhkbuGAIvnAhoxkvnE/QoqqVkzyzI9IN3EG8qGQZTxxvTiWK6zheVuYLb6V8BmspcKOnSOcd3e6qzv0Km/j8tqmELEtzUPw3RDIA/NFXbEzWZNoJgJdTFzcLh4A/4GUaivC2yotkw==
Received: from CH0PR01MB7153.prod.exchangelabs.com (2603:10b6:610:ea::7) by
 CH2PR01MB5896.prod.exchangelabs.com (2603:10b6:610:39::30) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4352.29; Tue, 27 Jul 2021 13:43:53 +0000
Received: from CH0PR01MB7153.prod.exchangelabs.com
 ([fe80::f16e:8a3e:3b8d:8a34]) by CH0PR01MB7153.prod.exchangelabs.com
 ([fe80::f16e:8a3e:3b8d:8a34%5]) with mapi id 15.20.4373.018; Tue, 27 Jul 2021
 13:43:53 +0000
From:   "Marciniszyn, Mike" <mike.marciniszyn@cornelisnetworks.com>
To:     Haakon Bugge <haakon.bugge@oracle.com>
CC:     Chuck Lever III <chuck.lever@oracle.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "Dalessandro, Dennis" <dennis.dalessandro@cornelisnetworks.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Leon Romanovsky <leonro@nvidia.com>,
        Doug Ledford <dledford@redhat.com>
Subject: NFS RDMA test failure as of 5.14-rc1
Thread-Topic: NFS RDMA test failure as of 5.14-rc1
Thread-Index: AdeC6xneRTsXNTlrTWuqxyNIUrjEqg==
Date:   Tue, 27 Jul 2021 13:43:53 +0000
Message-ID: <CH0PR01MB7153D5381BBC3D1D0F146E8AF2E99@CH0PR01MB7153.prod.exchangelabs.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: oracle.com; dkim=none (message not signed)
 header.d=none;oracle.com; dmarc=none action=none
 header.from=cornelisnetworks.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 652dca56-85b2-49f6-6942-08d9510492f7
x-ms-traffictypediagnostic: CH2PR01MB5896:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CH2PR01MB58966901CA61F5E9F47A05A7F2E99@CH2PR01MB5896.prod.exchangelabs.com>
x-ms-oob-tlc-oobclassifiers: OLM:1247;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: wMR+/Q2nyyKTa8Ftv3xDmxwpnBy0bpiFncMyf45YmNzPIBF6DAh8Hk5BBnI52UbieGQr1ctjZCDNE3fuSwHFSXXFrNKrCUP1RRi9fkabRykoUOWFnChaQ9msdDt9rH79IF1WyLZmStLvMz/guzmEO8CocLwSG3tlukGdUD+8/VFuvLsSDW4Nohj4BslfZ8yv3XxP9wsmbkRhsW9XYPGzFcxp5mXj3pj/yojV7lXShlZVeq5dK80VAJY4VnyVgy3a3RdI7SdI2OBXusQ/3Uf4LD0w7DtZa4IEBTGOOdcFJ6GJxikfyg7N2InzkEvNFA3yW0UWTaSU0S3un9NgVV5V3NH1IdH1L9EhUARWmuemQhvUUpzEG9sW9vo7UDK59zRhmcXNncQZz5kXbhFVxJa/QKZF6zuH1sKPvLE6xsW97WvLnzPLfotTrumM5Z3fvwP9p+NyuTzT1pQs9wDm/XdnX7CjQXdeOyT7uAWyfDflPONLWJCgFShb12Kon6W7BYYSGeWZoOZLfJE8mpsSncOYaO+Oq/DWDlQrxszKh12az8vTHfW75nnenU/ETFEBqgxFQ0sTLjV/UVaPfj5C0jmtPJVpltW0OnxvalGGUNgusaVRbUXNso/MouAcaGOpzjMbs29vL8jp3+XQB8o7npU0XSnYVRE2XT1LZuqyawRIjukp+Ys5/gBL6F21mtvAUL38wnY9NJQgbJ4qZF0J3XhDPSbol//SeCGt+4PdAk1XKX6UXYz7NoBox6ad5SiqLvqnKtI/dTf4OwKlazXOjKriAEuQs2SPhlWOaMG8lIHJ9Rw=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR01MB7153.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(39840400004)(396003)(346002)(376002)(366004)(316002)(66446008)(6506007)(86362001)(8676002)(52536014)(2906002)(38100700002)(7696005)(83380400001)(508600001)(8936002)(54906003)(76116006)(6916009)(4326008)(9686003)(26005)(71200400001)(64756008)(55016002)(66556008)(33656002)(186003)(966005)(66946007)(122000001)(5660300002)(66476007)(38070700004);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?YTZuVnFKNmJvRllkeU15T2N6dFA5M3RucXM0U09qOGRYQk5JWlBHK3Y0SkpF?=
 =?utf-8?B?L3hzcW81ZDBxNVBvaGlBU09IMFpWWVl1UTNUTkxMRis4UW51UEQ4ajlkVFJ0?=
 =?utf-8?B?VGdDaFZ0akRZZ242NmJUb2dUQWxxWHlaQmlPTXZobzJNVFovOUEyWGpZV25r?=
 =?utf-8?B?ZVhqY0g5U3Vkd0dZZmhWcmhXVUpRNGJyelljd1M5Zks5Ums0dk5sci9JeEti?=
 =?utf-8?B?TjFTcDNmdEtUTmVJS0NqdEpmN1c1NHI2djZoME1KclNSdDMrMlBOK3dCdmhD?=
 =?utf-8?B?bU1xV09EcWtTRUdTd3AzVm1CbHJvUm90OUQ5OUlUbkJpcnhJQ2NSZXluS0Zt?=
 =?utf-8?B?VGxsOENLdlM4VTJNN1JEemxIU3hVNjNJL1ltcnlKTEltd1pwUUlKZncrM3I0?=
 =?utf-8?B?bDdHai80Q1RWWFMvZDhtdERDdHZMQ3IrVUx2a3k0dHh4aWh2L2RiSHdiWGth?=
 =?utf-8?B?MkV1UkFKdkw3ZTJiSXc3ejl4RzZPL3MrUzlWVjdvdHBpcElMcXdQMnVJcWtk?=
 =?utf-8?B?ZUZPQVd3RUtXaElKbzQ4YXNxeVgrL2w4eXZoejM4enhPWStvOUpFNW1TRWtk?=
 =?utf-8?B?cktDdFhsM2UyYm5jQW1ad2JoVEJMTnE3VXo5anczVndGNHl4cGVzSVpBLzUy?=
 =?utf-8?B?a0JGdFRqR0xDRytYQWI4eDloMGdxcFpzVXVHNE4zZmlJTjBUNFRJUW5yeTlR?=
 =?utf-8?B?cEFtN1dEQlQvUTVPeEJ5dlY0Y0RVU2tDOWFRUmpuL1JQczh0ZGk5Zys1U2R2?=
 =?utf-8?B?VlhpcENBMFRBNTkrUDFjZTc0Um1pVjlXUnBJQW8vNWZZelNKR1U4TldGVldu?=
 =?utf-8?B?OXo0bUlEV09ITG5OZmlyZWxyZ2F5L05jeHRWQmNCNG5RbXlPSmtnRXBjRVRs?=
 =?utf-8?B?dkl0OUkyL3R5WTlLOXN4c3hJbHV4QVVsbEduTTlxaWltMjZRZms4OW1VL0Z2?=
 =?utf-8?B?dFM4Y2NRSFlFb2YvRjV4eGtnOSt1anJHRTZEZ1VpRnRpc1NicjN1TXB3VCtN?=
 =?utf-8?B?ODFYSUx6a3JtdjBOTjZ1OHIyUzYvb3FKMVBzNmVNLzVpY3JtYkJ3ckZYWmtI?=
 =?utf-8?B?dTlnUDBCNXp1Q0dXMmlackR0by9Pd3lJNU9QWjNiMTBYdFZacTVHTEtaMUpE?=
 =?utf-8?B?emhPUWJMS0g5K2VPUUVNNE9qSE1qTEtWQ1h3UVFTUmczbzBOajF1ZVB6cU9H?=
 =?utf-8?B?aURsSXdGUEQ4OERtbURCMjNDUjdUOGpZd1ZQK21acGhucSs5UXlCRDNTdUdM?=
 =?utf-8?B?KzBLZWwyclNiclk2OFU5QTNqTzlGMGVtV3hVNWtKUGw0TGZDZG0rNW1vLzlv?=
 =?utf-8?B?YmhTbHc3emRxN05SZG1ESkFsOHFCOEllOXFpMyttY0tUTkxObTBlY205NGZN?=
 =?utf-8?B?cWFyUE9Xa3RYbDNkRGJwRVNDdmMvTkNNV2NFTCtNd1NXaVFaMWM0QlZ0dWEr?=
 =?utf-8?B?V1B4L1Q0YlJLUEozdzE5NGVhUHhJL1VCMzJSWm1kWkhyTFhvRDVzc01UaFU1?=
 =?utf-8?B?Mlppakp2SDE4Y1lxWG4rcWJnOGhuR3BYd3JDdDEzY1hVYXFrZmsrcHh4dlo5?=
 =?utf-8?B?K2hxd0h2RUNMaFJjZ0MzMjBvQTh6ei90d0ZEejIrOVBONVg3Rzc0cUVzdndR?=
 =?utf-8?B?amZkWkQwMVNWMzFRMGp6bkttalUxR1RiWjN4TDFjbzhmN3k4VktwMS81RVpS?=
 =?utf-8?B?RmRlb0dvdk9FbjZGWEMzSG9pVkVFV1dLdVR5blJmQ3lMWlgwaVFoLzUyR09H?=
 =?utf-8?Q?NKqL2DXciXam6Ikfa4=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: cornelisnetworks.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR01MB7153.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 652dca56-85b2-49f6-6942-08d9510492f7
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jul 2021 13:43:53.5748
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4dbdb7da-74ee-4b45-8747-ef5ce5ebe68a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7dNXAv+hhD950HqhVoBPQJt+y3sQJ0UIP9iiVciJW9U75YRddNYdbq+FD4QIq0KSgQy6I8qF7a0nKodugiwAbYfoHltmiPq7LS83tRN1yhBqWW+7rScrXp0GQ6vRcBsq
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR01MB5896
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

T3VyIENJIHRlc3RpbmcgaGFzIGJlZW4gZmFpbGluZyBmb3IgTkZTIFJETUEgc2luY2UgNS4xNC1y
YzEuDQoNCkJhc2VkIG9uIGtwcm9iZXMsIHRoZSBORlMgUkRNQSBjbGllbnQgY3JlYXRlcyBpdHMg
UVAgdXNpbmcgcmRtYV9jcmVhdGVfcXAoKSwgYW5kIGRvZXMgcG9zdCByZWNlaXZlcyByaWdodCBh
d2F5Lg0KDQpUaGlzIHBhdGNoIGJlbG93IGxvb2tzIGxpa2UgaXQgZGVsZXRlZCB0aGUgdHJhbnNp
dGlvbiBmcm9tIFJFU0VUIHRvIElOSVQsIGJyZWFraW5nIHRoZSBjbGllbnQgc2lkZSBORlMgUkRN
QSBzaW5jZSBwb3N0IHJlY2VpdmVzIGFyZSBub3QgdmFsaWQgaW4gUkVTRVQuDQoNCkkgc3VzcGVj
dCB0aGUgcGF0Y2ggbmVlZHMgdG8gYmUgcmV2ZXJ0ZWQgb3IgTkZTIFJETUEgbmVlZHMgdG8gaGFu
ZGxlIHRoZSB0cmFuc2l0aW9uIHRvIElOSVQ/DQoNCmNvbW1pdCBkYzcwZjdjM2VkMzRiMDgxYzAy
YTYxMTU5MWM1MDc5YzUzYjc3MWI4DQpBdXRob3I6IEjvv71rb24gQnVnZ2UgPGhhYWtvbi5idWdn
ZUBvcmFjbGUuY29tPg0KRGF0ZTogICBUdWUgSnVuIDIyIDE1OjM5OjU2IDIwMjEgKzAyMDANCg0K
ICAgIFJETUEvY21hOiBSZW1vdmUgdW5uZWNlc3NhcnkgSU5JVC0+SU5JVCB0cmFuc2l0aW9uDQoN
CiAgICBJbiByZG1hX2NyZWF0ZV9xcCgpLCBhIGNvbm5lY3RlZCBRUCB3aWxsIGJlIHRyYW5zaXRp
b25lZCB0byB0aGUgSU5JVA0KICAgIHN0YXRlLg0KDQogICAgQWZ0ZXJ3YXJkcywgdGhlIFFQIHdp
bGwgYmUgdHJhbnNpdGlvbmVkIHRvIHRoZSBSVFIgc3RhdGUgYnkgdGhlDQogICAgY21hX21vZGlm
eV9xcF9ydHIoKSBmdW5jdGlvbi4gQnV0IHRoaXMgZnVuY3Rpb24gc3RhcnRzIGJ5IHBlcmZvcm1p
bmcgYW4NCiAgICBpYl9tb2RpZnlfcXAoKSB0byB0aGUgSU5JVCBzdGF0ZSBhZ2FpbiwgYmVmb3Jl
IGFub3RoZXIgaWJfbW9kaWZ5X3FwKCkgaXMNCiAgICBwZXJmb3JtZWQgdG8gdHJhbnNpdGlvbiB0
aGUgUVAgdG8gdGhlIFJUUiBzdGF0ZS4NCg0KICAgIEhlbmNlLCB0aGVyZSBpcyBubyBuZWVkIHRv
IHRyYW5zaXRpb24gdGhlIFFQIHRvIHRoZSBJTklUIHN0YXRlIGluDQogICAgcmRtYV9jcmVhdGVf
cXAoKS4NCg0KICAgIExpbms6IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL3IvMTYyNDM2OTE5Ny0y
NDU3OC0yLWdpdC1zZW5kLWVtYWlsLWhhYWtvbi5idWdnZUBvcmFjbGUuY29tDQogICAgU2lnbmVk
LW9mZi1ieTogSO+/vWtvbiBCdWdnZSA8aGFha29uLmJ1Z2dlQG9yYWNsZS5jb20+DQogICAgUmV2
aWV3ZWQtYnk6IExlb24gUm9tYW5vdnNreSA8bGVvbnJvQG52aWRpYS5jb20+DQogICAgU2lnbmVk
LW9mZi1ieTogSmFzb24gR3VudGhvcnBlIDxqZ2dAbnZpZGlhLmNvbT4NCg==
