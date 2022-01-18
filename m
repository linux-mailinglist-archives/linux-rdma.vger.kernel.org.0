Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 948F14920E1
	for <lists+linux-rdma@lfdr.de>; Tue, 18 Jan 2022 09:04:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343888AbiARIEt (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 18 Jan 2022 03:04:49 -0500
Received: from esa17.fujitsucc.c3s2.iphmx.com ([216.71.158.34]:33031 "EHLO
        esa17.fujitsucc.c3s2.iphmx.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1343504AbiARIEs (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 18 Jan 2022 03:04:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1642493089; x=1674029089;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=Z/JhxL3v7s5vbbolAZTvMbAskYNxsqhHUeQX3aoYKt0=;
  b=nrK1fY5Xm7FW0CgRQ5ErvhCLXIG5fW6bedo+7yaQ7RXAde5+B+dKIjxX
   jEoJqDcz5vdB6GzRweauxRFvujp1DyHqnxDZY1UwxHuG61sJt9kOsTS1u
   jCgyfFHDPWRfZ6a0KKMO2H/J73byMh9WLgnFVxCj9Kr0nr256Hl9mmmlo
   FC0eat2gnfZ5ZCpia22sKiFgQuoX6SVzRPGsDBkMLvu2R2zN6dpZ3EUgk
   k+4AvYKrS8nwc8FrH+qD7grcezGJE4cHeY9hY5MWsn5HJgxgxK5XbrT1x
   +puXC4mE56R6daEjFSLLNwiRc1R29+EOLD/G1eLtg97S+RTekbsD6dLUs
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10230"; a="47828747"
X-IronPort-AV: E=Sophos;i="5.88,296,1635174000"; 
   d="scan'208";a="47828747"
Received: from mail-tycjpn01lp2173.outbound.protection.outlook.com (HELO JPN01-TYC-obe.outbound.protection.outlook.com) ([104.47.23.173])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jan 2022 17:04:46 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NhzaieqpUBTbt/IlPw6ZvSFXfI6vcey0V472ckHUeuroNwmvC/SUSW6U9YCcv75TghxT/y1H8hivEwtQcHNDG6Dwt8IjA5IJobHxZEuP3zUfqzLJ7WTt43kwne3fB/tcFaRpBrd7Ekews5h83LZ+ad+h/+P4ZfjBCY4lQ0Qt6y+UWEa9as4FwnR8mId3KUYkxWT+PqS17kyjGjZ3xqaK1YLUPtTpR1YlGhjrbFdst97EyMYsvSu7XprV8zWEMZ+kdHS1kwhVu/SHZ06xXuDV0/adt2plKoSNhbmsjOMu5A7UqGyv0M/PJRob1Y8s71CC9jmkxeTuPBaIEPCiSqn7AQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z/JhxL3v7s5vbbolAZTvMbAskYNxsqhHUeQX3aoYKt0=;
 b=GuMJTZm5HdKeMdCIoFhVp8pg5q4MVaq1MXP83QbrQPdBsJQ3VhFo4hWqWBXcESCjCpASStU5GDnFZhu4kexwozZbpsWUO5U4alvqhiKQNVyRTrChrsSuBkxYXH3fC7wsjt42asFcDdi8NY3h2lBOFsa/9wJ6RX4RHWrESqriN2TcCSVqTc2KeKUBFzkBT+gQScl1tCshNVCfOhThjxh3eWEFt5+jdXvogdVPiS7vzkvFQDLatYLTWhNye8Jc92nwUmR99+dkplBpl9DA2jJTQdozlTpyBVgDCuVU8M+NBIqxDFzrEbLdCTdYSHzmgFD6BUilgNt1bYxeFqvbKAzxKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z/JhxL3v7s5vbbolAZTvMbAskYNxsqhHUeQX3aoYKt0=;
 b=hpqSpEUQJHYLPwxHy6e3SpcJ9mZSAj/9YgBhIZZysj3UudO4u4cBLPZm0ELJT4dDEO15NTYXknAxd/huzMjdDj50NXgAHbrcgWvxGxiPAN330vrs7t+gpQchjGEeUZyDwYlqaWpx129NLfgmMxIIs1j1UiuN+lCmlc79SuCpSRY=
Received: from OS0PR01MB6371.jpnprd01.prod.outlook.com (2603:1096:604:104::9)
 by TYCPR01MB7580.jpnprd01.prod.outlook.com (2603:1096:400:f7::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.12; Tue, 18 Jan
 2022 08:04:42 +0000
Received: from OS0PR01MB6371.jpnprd01.prod.outlook.com
 ([fe80::99c6:1a48:180d:dfd1]) by OS0PR01MB6371.jpnprd01.prod.outlook.com
 ([fe80::99c6:1a48:180d:dfd1%5]) with mapi id 15.20.4888.014; Tue, 18 Jan 2022
 08:04:42 +0000
From:   "yangx.jy@fujitsu.com" <yangx.jy@fujitsu.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
CC:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "tom@talpey.com" <tom@talpey.com>,
        "yanjun.zhu@linux.dev" <yanjun.zhu@linux.dev>,
        "rpearsonhpe@gmail.com" <rpearsonhpe@gmail.com>,
        "y-goto@fujitsu.com" <y-goto@fujitsu.com>,
        "lizhijian@fujitsu.com" <lizhijian@fujitsu.com>,
        "tomasz.gromadzki@intel.com" <tomasz.gromadzki@intel.com>
Subject: Re: [RFC PATCH v2 2/2] RDMA/rxe: Support RDMA Atomic Write operation
Thread-Topic: [RFC PATCH v2 2/2] RDMA/rxe: Support RDMA Atomic Write operation
Thread-Index: AQHYCCpUccBUAPZcPEOP46lbsjIBJKxnOIUAgAE7PYA=
Date:   Tue, 18 Jan 2022 08:04:42 +0000
Message-ID: <61E67499.4010408@fujitsu.com>
References: <20220113030350.2492841-1-yangx.jy@fujitsu.com>
 <20220113030350.2492841-3-yangx.jy@fujitsu.com>
 <20220117131624.GB7906@nvidia.com>
In-Reply-To: <20220117131624.GB7906@nvidia.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: aaac8a94-b1db-4619-20c5-08d9da592f35
x-ms-traffictypediagnostic: TYCPR01MB7580:EE_
x-microsoft-antispam-prvs: <TYCPR01MB75808EDBE2C2DD89E22C4CB783589@TYCPR01MB7580.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3173;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: WOvrTcPaelgzcxy9C1yz7kwtKlwyGpvRH65D8mkn6FRVflFUvCvGSB+eHFo3RUQUDt1iue35i5GB3/kEwOS/IZnjsXB8l5UZn//2Q5WGua3t/Qt3HiPwTPm50JZaVR5KccWiP6Hr3RajwUK17OLv8QG+lefGva18sP0VWwMbpXU3d3PHyYtOkbvk+WuGFCmo2/uPlnmtRI8OG4aJO7HkAPfoNY66H5ERASHFD4BO0Dkfd6xL33ydWNQYdLcSkDzqvyHUFie7yNLVXi2WoYMbGOGeOTzRhB7lBeimXR6O+AbmYpkUfKr/csKi6VdNpDpahfz1lFWS3QXPx0prnuCkaaAOpKtt1GAu0rocrd5buTwF6/gk2MR4+pMc73EMJfgjMZDVi/x/8RzoIAqrkGKZRlaTb+I16kjVFeeCHjAf+LWcuD+OJwBnluAQwnrIL0RemE1CiK5C+cVUlrG4NJGnvkSHO3kgT085GxYvUati8lBnPs50xyp6qKPOX+I3iZtFPj1A1KvbkC3aGwu+qZfmP/NumHTZSxbX7BQ9hr/DdyTpmXjPeBenObzWs4FqJgzQLcy1d08se/29d6cPtygr3kT1oQDZ/0agNABUbhGqSuSU+PnPUA5uzrtzLke7XSJKv3hVSb0hyLRd85+ZSno7gu+UjXuzsvqcUoA2kPavFYqgBCSsjGPK53fXZom+ji9Ag4RHmxCcs0VQ3WmF1+KbBA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB6371.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(91956017)(6486002)(82960400001)(85182001)(86362001)(186003)(38070700005)(76116006)(71200400001)(8676002)(6506007)(4326008)(26005)(5660300002)(36756003)(53546011)(66446008)(2906002)(38100700002)(66946007)(64756008)(8936002)(87266011)(6916009)(316002)(66476007)(4744005)(122000001)(508600001)(6512007)(54906003)(2616005)(33656002)(66556008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?Y2N6ZzlwYWY5LzBDQVdkQ2wvNXJ2QVpSdFJaeWQrMWNxMWk3T1FybWhWTHFT?=
 =?gb2312?B?MG9ONnl4T08vQlFXUWo0VWpRS0lzMlhwd3ZJOUxpZVZmMURTQlF1V3NkMW1a?=
 =?gb2312?B?YU8rWGZsVEI5cStCeXN4S2hPMENXYWNOUFRYUW9SZGc4aTlFeEQxbmpIaWNH?=
 =?gb2312?B?cXMrV0wya1BpVDF0Ylp6UXRkZE9IejMrLzgzb0FmZERLUWM2ZG5sMnZRUzlJ?=
 =?gb2312?B?cG1xY3JGdkZGS3RzVjNsbkw0UVg1WVBpQzZtSVlCd3d3bkYzcGtreFFYTFRt?=
 =?gb2312?B?Q0JOZzlrQjNxKzh5ZkxGLzh2V2Z6U21ZVlR1cmNseWNkL09LRFdLQ0pmSEZi?=
 =?gb2312?B?Q21yckFpdCtQZ3JyUDNqSGZHSWZ3TmFlSXVYdmFIT2VEMkdUWFhYOTZNeVlB?=
 =?gb2312?B?SEdRSUVoaHhNMnBpQ1BManVoWW9MMUxSUEhFSitiVmJTS0ZBS2RKK2d6bWhE?=
 =?gb2312?B?WGVUd2o1ZUFQUUxqSnhTcGtzTDFCcFdaR0grSjNjdnV0Z3g5U20vd2E5UkxL?=
 =?gb2312?B?Qlc4d0NkQSthOWxDbkZ0SUhvc1Vma3JpKzFNQVY3RGxOT2t4K1JBcjNlTXFI?=
 =?gb2312?B?dXNWMFhnYm1pcTBTaWNCZWU1RGM1SUpZTGJwaUZrcWdaNkVhdjhkRDhwU3I5?=
 =?gb2312?B?ZVVkeGJTRDROZ1dMTVRwOW5GdUJMYjZuZVJxQ1U0T0xoZVdocnYzSm82aHho?=
 =?gb2312?B?cEZCREtkNUcvY3FDeThXMjM5RXkzMllUYWpjM0loWk9tSlZiQkRMSkN3UFFl?=
 =?gb2312?B?M000NXFXSGdJZm9PellRMXZyTWVIdVkxbFA2S0dGNHNtZGkxSnM3TzU1OHRt?=
 =?gb2312?B?YnR5L0YybVlQTythRUU5UkdHeWloRGh5RXRiZTNxcHZ2THBneHNaSkIwQ0k4?=
 =?gb2312?B?cmR6akx6eG4wUDR1Si94VXZaeG56NjBBM0tPOWJQdG5WenVyREhnMkxrVUlk?=
 =?gb2312?B?TC9PTi9KNlNiZERxSkw3aHhGTkdJYzJrQm9UV1hzZmxtSDBWaHhEOGZkNG9k?=
 =?gb2312?B?RWRBRTZmWVJMcFR3ZGhQL3k5TlZOYnQxTlJhSmZPeG9oQkdsUWFKQzU4b1V1?=
 =?gb2312?B?WklnOS91Ny91WTZqeFBZN3dIS1Z6U1ZHSVJhT3NGaEZxM0NCaHB6dDgzOXV5?=
 =?gb2312?B?czJPYnNXcW83YWNEVld4WFdhbEhxZ28wZ3lxNXVJanFKYkdUeElhYmF4UXZX?=
 =?gb2312?B?RlplTC9ZclloVUlQUTZyWWlVL2RWdXd4bzVsQjZNZ3hSejhaYUl3VVI2aW0x?=
 =?gb2312?B?Z0d0aWtrcWRBcktMaGt2Mk96Y3FrM09LTnZjQ2pFbFpqVUUzNFpWOGcxNFVr?=
 =?gb2312?B?VVdDQ1h3NDdlV21MMXdMUXo5ajB1Q0MzeUlNY3hJZGJnaTM2Qms1aWRZcFk1?=
 =?gb2312?B?OXhSZy92NGpoMGQ4TEJFQnNrejZDR21WVllUZGp4SS94VGVtaVU4eDlGU0xi?=
 =?gb2312?B?S09aMVErNXkvOXAyQ2h2RzNsRTFabVIxb2NaWTc2TTVXTFZ0ZCtQS0txd2xS?=
 =?gb2312?B?SjFjeVFWbndwNmxBcTZqSnZ1RjBxZkhaVkNqSjY2R1A4M2lXSUJKeVFvL1pQ?=
 =?gb2312?B?UEplcUpMQ2dTaFllWHEwdHlYVjhhTXcyV0VESDVzZHVKTXBtaEJLOWxlQUg0?=
 =?gb2312?B?MlFJYkIrZkt5dVlCelRJaEpuVUh6cytJbU1IL1lBYUM2NnBya0xEL1c4cytD?=
 =?gb2312?B?bU1wQmFWNDBJTm92U3BzK2xyYXViNjFyNW5wUTNtTWF3cUQ0MXJHSzZoclFU?=
 =?gb2312?B?ZE5mRzJGM2loK014Qk5sbW90NGxTSXFOM1FLSWN6eFMzcjMremtuZDF3NG1w?=
 =?gb2312?B?ZmcvQXNTcUVzN3NKUTEyRTNocGFVanFCQm5XcWtpdFFnZGR5YXRkSTA0bm1P?=
 =?gb2312?B?Q1htanNxcS91NE40RmhGZjJTcVpxNDRzam9qUk9mTWxwdXBwVmlmb2p2aXhK?=
 =?gb2312?B?bDVlZ3kzaW9NZXFkNEZXdC8xaytsOEdsZ2xESEppZ2xQcFpDNVBlMi9DVUlM?=
 =?gb2312?B?NTdRdnBMSm9ieWlPTm94OGV2S3F6TXlJYWlXbzdxSnIrWWRJcitEMUhNbXE0?=
 =?gb2312?B?U0tOZWZNekdkdjBFK1ZQRVNxZWwzTE52VEpUN3Nja0xUTGh6WURSOVJacTFm?=
 =?gb2312?B?cy9DSW5mWlJLQndKNjZGMlVVaHFkbkM2MDl2QnVEU254UWhzUktBVDVsY29C?=
 =?gb2312?Q?3PxdqsAua56iSt1nFBQfrOQ=3D?=
Content-Type: text/plain; charset="gb2312"
Content-ID: <7D454D75F776D842B01988D4AAA4AAF1@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB6371.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aaac8a94-b1db-4619-20c5-08d9da592f35
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jan 2022 08:04:42.7497
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: I+OZRAYVpJyaPxNc9+mhgHjmOYK405BmYDhdmhdgOPZL8ob3kJpw50OvX8Z/mtL1KvxLJtmRZRVBcMVdm6p1eQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB7580
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

T24gMjAyMi8xLzE3IDIxOjE2LCBKYXNvbiBHdW50aG9ycGUgd3JvdGU6DQo+IE9uIFRodSwgSmFu
IDEzLCAyMDIyIGF0IDExOjAzOjUwQU0gKzA4MDAsIFhpYW8gWWFuZyB3cm90ZToNCj4+ICtzdGF0
aWMgZW51bSByZXNwX3N0YXRlcyBwcm9jZXNzX2F0b21pY193cml0ZShzdHJ1Y3QgcnhlX3FwICpx
cCwNCj4+ICsJCQkJCSAgICAgc3RydWN0IHJ4ZV9wa3RfaW5mbyAqcGt0KQ0KPj4gK3sNCj4+ICsJ
c3RydWN0IHJ4ZV9tciAqbXIgPSBxcC0+cmVzcC5tcjsNCj4+ICsNCj4+ICsJdTY0ICpzcmMgPSBw
YXlsb2FkX2FkZHIocGt0KTsNCj4+ICsNCj4+ICsJdTY0ICpkc3QgPSBpb3ZhX3RvX3ZhZGRyKG1y
LCBxcC0+cmVzcC52YSArIHFwLT5yZXNwLm9mZnNldCwgc2l6ZW9mKHU2NCkpOw0KPj4gKwlpZiAo
IWRzdCB8fCAodWludHB0cl90KWRzdCYgIDcpDQo+PiArCQlyZXR1cm4gUkVTUFNUX0VSUl9NSVNB
TElHTkVEX0FUT01JQzsNCj4gSXQgbG9va3MgdG8gbWUgbGlrZSBpb3ZhX3RvX3ZhZGRyIGlzIGNv
bXBsZXRlbHkgYnJva2VuLCB3aGVyZSBpcyB0aGUNCj4ga21hcCBvbiB0aGF0IGZsb3c/DQpIaSBK
YXNvbiwNCg0KSSB0aGluayByeGVfbXJfaW5pdF91c2VyKCkgbWFwcyB0aGUgdXNlciBhZGRyIHNw
YWNlIHRvIHRoZSBrZXJuZWwgYWRkciANCnNwYWNlIGR1cmluZyBtZW1vcnkgcmVnaW9uIHJlZ2lz
dHJhdGlvbiwgdGhlIG1hcHBpbmcgcmVjb3JkcyBhcmUgc2F2ZWQgDQppbnRvIG1yLT5jdXJfbWFw
X3NldC0+bWFwW3hdLg0KV2h5IGRvIHlvdSB0aGluayBpb3ZhX3RvX3ZhZGRyKCkgaXMgY29tcGxl
dGVseSBicm9rZW4/DQoNCkJlc3QgUmVnYXJkcywNClhpYW8gWWFuZw0KPiBKYXNvbg0K
