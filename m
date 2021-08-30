Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A12713FAF97
	for <lists+linux-rdma@lfdr.de>; Mon, 30 Aug 2021 03:42:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236148AbhH3Bmi (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 29 Aug 2021 21:42:38 -0400
Received: from esa8.fujitsucc.c3s2.iphmx.com ([68.232.159.88]:52249 "EHLO
        esa8.fujitsucc.c3s2.iphmx.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232077AbhH3Bmi (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Sun, 29 Aug 2021 21:42:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1630287706; x=1661823706;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=uVme5BmdFuSxQmqj9jmQO4NAOPxFHrcZBdOe9bol1Q0=;
  b=KT9Kno/F9fUz6VJDx7M0rWdPcgsv0E6S7oNxAQHVAKGcoTAhcygGb79v
   W0j6ibuPdIKlXGRByGuqF9PDWtdGi2MfoiwlwjC2YOJntAieUDcoiUT7h
   MlNgGkFf1Rb2Mt81+/R/rJQ357gij57nWX37eMeWoX3U/kLiFpduvzorB
   jpalbfWZCBiWXkIRzU81EYlsLdnIvY6XswCgc2IkX4OtpD1ZSmIVNiiRE
   E4k/QcijppByptyYBS90Tch9bsUYgyHMsRD2oFTpE6lc+qGR75ndaNtF0
   FbHnWdPP3VLDHS3iPiYDgwApam3H6ZYfBDrxXslIeOENTNv+t/ZvYfVMN
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10091"; a="37965155"
X-IronPort-AV: E=Sophos;i="5.84,362,1620658800"; 
   d="scan'208";a="37965155"
Received: from mail-ty1jpn01lp2052.outbound.protection.outlook.com (HELO JPN01-TY1-obe.outbound.protection.outlook.com) ([104.47.93.52])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Aug 2021 10:41:43 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N2OOaZwf/dQjJ1Zb5UA42/TVbLGGoCrDLUuHB5qNbvM7RKjCKBXOEN4qKHhf3yidekO29F3SUT7SeebSwVAg21AZ79SPt1ZiTL9ni/PevqybQ9EMYVPvJLm8iwKQccls+ytHEpsb7QXAuI6Sww+X+qRSxRvPYogKwQQ4EDuTZb6R0RiYixOUFdetlcfzDzzrLB9dHTvRj3nurRXtykojtxDb8ZGCQmUrWFCAi01IFGkdOKc5KBIBuwyHKELTjx6nWp3rbA1k4Aee4icdjSaAdno7Mw8FBYm1LLvKk7SElIzrSOW4Qk2F2rSDc2GqAzhwqTePHZtnS/B8YF+c8wvE6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uVme5BmdFuSxQmqj9jmQO4NAOPxFHrcZBdOe9bol1Q0=;
 b=GfRZ11vWZl/YjweFUhCgZVZ9NU+xmaMDIyhqFnmE2AjK8bz+XmgqXWiqAhzCVcGhPFzRxvd+TGtsErZ/Ylh6izv6sMha0xfjZrGdTufXNc95ZxNsWRhYunGYxbE1cUqHWaRLIO+EbW14+LXh+HXemYBxEfvCaitKT33f4gwkPHsdND9ZAXiN9t8PitDKmbWkyJE1eWZqn8j+evRCKbJFVv1wlofKZYbCJNMwLI1P4HsWKyq+yHZWRMdbtsTwFkfrl/zoAGeqkBB75X+577tyg+WF0yZ7Q1kVPur/ZIMmD50tIy+wmnYryIISTQBx6YGFix7iw7XrAN34MVWyhJMF4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uVme5BmdFuSxQmqj9jmQO4NAOPxFHrcZBdOe9bol1Q0=;
 b=HO5GxQ+bqa5NUqhE694ooDFjUNUCxfCLIM88pfIXJsjN5F4bx+FUL69ccfhLP85dn9Bj2BMuhqRp6WVFTGT0xFWUskrElai40R4Hqy/gSeKkrHSskyRBKIukJv6mbh48SFAjaOip34yQqX5XRVcaFMF98KE5JWSMQE+3KRPYRN0=
Received: from OS0PR01MB6371.jpnprd01.prod.outlook.com (2603:1096:604:104::9)
 by OSAPR01MB4500.jpnprd01.prod.outlook.com (2603:1096:604:69::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4457.19; Mon, 30 Aug
 2021 01:41:40 +0000
Received: from OS0PR01MB6371.jpnprd01.prod.outlook.com
 ([fe80::8070:55d2:d09b:14a2]) by OS0PR01MB6371.jpnprd01.prod.outlook.com
 ([fe80::8070:55d2:d09b:14a2%6]) with mapi id 15.20.4457.024; Mon, 30 Aug 2021
 01:41:39 +0000
From:   "yangx.jy@fujitsu.com" <yangx.jy@fujitsu.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
CC:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "rpearsonhpe@gmail.com" <rpearsonhpe@gmail.com>,
        "zyjzyj2000@gmail.com" <zyjzyj2000@gmail.com>,
        "leon@kernel.org" <leon@kernel.org>
Subject: Re: [PATCH 0/3] RDMA/rxe: Do some cleanup
Thread-Topic: [PATCH 0/3] RDMA/rxe: Do some cleanup
Thread-Index: AQHXl/wNmuOngg/VRkGQ6TrFRIfIo6uHbrqAgAPhpAA=
Date:   Mon, 30 Aug 2021 01:41:39 +0000
Message-ID: <612C3750.9040705@fujitsu.com>
References: <20210823092256.287154-1-yangx.jy@fujitsu.com>
 <20210827142513.GA1359754@nvidia.com>
In-Reply-To: <20210827142513.GA1359754@nvidia.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: nvidia.com; dkim=none (message not signed)
 header.d=none;nvidia.com; dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 935e9ab1-671f-457e-09b1-08d96b575016
x-ms-traffictypediagnostic: OSAPR01MB4500:
x-microsoft-antispam-prvs: <OSAPR01MB4500633C1C9EEB59575FD43B83CB9@OSAPR01MB4500.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: yTqvbSKQWUjhpUbItkXaGBD/YoyJpc8VYMtGpHTsoboeUGQdH8ptO1b7mXsWwV0nkVwBIxcS+bNvaJjCxhEKYCL4yJsaWBSdDY6pZ0JciJPjuJYZ4/UL7Dv33O4eQdFOi3AeToWIde+z8LCZ3G7OFrnuuGbxWGPplcqFjO8annE9b0mp3syfywh/nuJdvdIAU/81eYXEfpxPB6OEk/DK3H/Z7Kwjoy0ac5ep9B2e7+5wKLrANPqLnts5qtPY0tm5psKKYHwVprcoZTRMFiGlSqFVJ20KwwqD45re9OKjHtaT/+ggKNDre6Nc5jEgfg4PWQ+Gg4fyTX5Oe+v/5lAHNONuurMjOMYy8o9cYYYrsdkw6mVMcAGOQFi1KODskSSrM/H9WtdmecDp51Y2Edegv+qsrKuCZ3sqAmoJQS3okOTbiTZE0eWTNumAGBaPFVzzjr1aBaepFbar54itJJf0hlDofHjmKZBvTMsnbws9xCUEX+1MwY/+ZN85X21AjlRY5Dto+GEREW6rKJ9qQQsTINuvYnBFIdkKfZDbSFYuLLFywmJmuJcx5ujJ7U9s+NATxFgk0nwMM2vQpxcU0T9MQzsyeoJ+euQvTbwbyHZraaWOX4VjWAIZ6i2sInmUFMdjYMLaJiPYF+DXT3+7SX3hWCn9JLlaZaMNrs3vtnRyllmAahZXdS/PGA7OPdKjqKiNxvXZvFVB2JcqATZyboVHPQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB6371.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(366004)(376002)(346002)(396003)(136003)(87266011)(2906002)(83380400001)(6916009)(478600001)(2616005)(122000001)(38100700002)(5660300002)(6486002)(54906003)(66946007)(26005)(66446008)(33656002)(6512007)(85182001)(316002)(38070700005)(8936002)(86362001)(4744005)(64756008)(53546011)(6506007)(66476007)(186003)(76116006)(66556008)(4326008)(8676002)(71200400001)(36756003)(91956017);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?dFVBdTZKUElaWjZ6Um96NlVUMnhDdlptOGQ0UmZLdnpzU2wvRGZjbFRsb3h5?=
 =?gb2312?B?QUdTNDVRNS9maVVKR0t3U2F1MUxJZ3ZqNW5XclIyVFpaVHZxcElLS1J6R3BK?=
 =?gb2312?B?WStuMjlsVzhka3NYYWZsYjZoYnNDa2ZRZ0p3dzgzWDEweGRLOEpCVEN6WlNa?=
 =?gb2312?B?QjhCVjgvZzRKQUJIVERyc0RIMWhxN2dFb25ueDlSWFNKVnBEYk04djJMVVM2?=
 =?gb2312?B?SzV6eFA2d3RMNFQ1amp1VjdON0tjOGJPMitZZ0IzS1M2c2xmNGpaNm1GSnpC?=
 =?gb2312?B?MDlLdnRIVExnK1ZGK3l3T2tDdlhidTh6S1JFQ1JQSHUySTdxWjlkMTJ1bEFW?=
 =?gb2312?B?T0I4eUQ5MU5GSkhrMHNFL2J5a0NIM1lkKys3QzFKOG92dXNEWWt2U0thMHZv?=
 =?gb2312?B?REVYZHhWV0hGWjFYUG84UUdhMmxYTlFndWtSdWhTZksvWldRSlo1ejhvbFhT?=
 =?gb2312?B?NnpYanpoUVZZMUNwVDlrZUhkY3o0N2JXV0hWbG93UjIxcFJJWlhYd25Ed1ox?=
 =?gb2312?B?OEQ5VS9LNnJJM1dudnVEMHpJc1FXcUlQVWMrak16UFczREJNeGFHUnlKNFZo?=
 =?gb2312?B?TE1vQUxJMW1takhTVTNnRVNNWE1Yc05VVDczSTQ3dnpSbEZSZWVmQld6Wk1G?=
 =?gb2312?B?SDJSUCtXTjdGc2N4YzFMU3dPZUVib3NXWDJtYWhCNzNBWFZnbmRiTDNxY2dv?=
 =?gb2312?B?a0FhU3R0S2V2TDZXdEtDVUtUYnR5NjFMYkRNVWlpWDd6QkJ3b0x3WjI5bEpL?=
 =?gb2312?B?NW9mbnREUHkrTmJQVnluSjFjUjFobVNsNjVpR0xEbHA2aE15OE1LZjczYmRP?=
 =?gb2312?B?cUQzWUEvVUZwTWE0ZzdadFFaMHNmVUpseVBRL0tPZGcwY0NwUEZMVmc4b2tG?=
 =?gb2312?B?cHZGZ2RidHBDUTVJTEhtWjNhNi8rcU1aTGtsUGhiVlp0VEFrQjRHVWRpTDln?=
 =?gb2312?B?MHM3MTk4ZVV1WXgyRlhKdlpkMWIyc1ltL25pZng4QnZONlNKYnJWQnNzNVQ0?=
 =?gb2312?B?VGZPMElCdEc1TVJqWVhNWVNNN1BpU1VqRnV0NG9kR05Iai8yaGJNbmdwSDJ0?=
 =?gb2312?B?OVBNUzg4dWc0Sk5TN2RvSHhIVU0zWGx3dUQzNG4zUDVpSWhXMWZyYTVaRi9X?=
 =?gb2312?B?NThuMkJGTkI2NmlKQk5tZU5VMnFza1ZqYVpDTjgwb0MwbmIySjEyWlBLaE1I?=
 =?gb2312?B?Z0IyMytUNHhBVE41K0E3Q1FNK1M4ajdiVkNDWHBobWpnSStNWks5T0tzMm1Q?=
 =?gb2312?B?VDZrbTVXcVZQd1lOZEFISTBSSC9ZZkFEVTNVRmU2NjFVUFRRQVRPajZQWmxz?=
 =?gb2312?B?czVhY1IyRlRJcnd4V0EzUU1xZEowcmhUU0RVcHpwSi9vdnJGY012OThZK1Zr?=
 =?gb2312?B?bDFSM1lJU3BDd0YxQjltbzQxYVhzOWdJVWcwYm0wa3hKV0duYzJKQVdnTWxT?=
 =?gb2312?B?MVV4Z0dkQlpOMnIrangzNmJKOVVmVEc4ZjlxdmN4VkFMWk4xZmQ3M2xqMVNL?=
 =?gb2312?B?VTN5L3VPNmZhS0NyaWNteWozakFRNHkrK2RpRm9PSGxBYmJqM09qUjhjLzkx?=
 =?gb2312?B?NjBFV3B0QWN4SlpQbjh1Y1VNeWk4TWxiOFhNbU1tNHdhUUl4djFUd1dsNm42?=
 =?gb2312?B?SW42VHAxNkZnTWc5bmthL0hnVng4VE9LS2E1bkZBV0c2dndCUWFYT2tDaW51?=
 =?gb2312?B?cEZZbERnSlVNR2x6aUhNcXlZNENleWdoR2pUZHNzbmphSTlET3pjbTNtN25Q?=
 =?gb2312?Q?Qe3qByStmSvnRRzUBjQaQ1oodh6tEqxYcv5CMRi?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="gb2312"
Content-ID: <37D900BD18312D4DA538DDD9283ED7A1@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB6371.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 935e9ab1-671f-457e-09b1-08d96b575016
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Aug 2021 01:41:39.9026
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Xx3tOoptzYe/K29QKLfVN1EeCv0XGc4evUlmp85o8HvvUWrTtKO8dM7yI9urz63QlIqfhup9UsxkiHWjJLvCwg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSAPR01MB4500
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

T24gMjAyMS84LzI3IDIyOjI1LCBKYXNvbiBHdW50aG9ycGUgd3JvdGU6DQo+IE9uIE1vbiwgQXVn
IDIzLCAyMDIxIGF0IDA1OjIyOjUzUE0gKzA4MDAsIFhpYW8gWWFuZyB3cm90ZToNCj4+IFhpYW8g
WWFuZyAoMyk6DQo+PiAgICBSRE1BL3J4ZTogUmVtb3ZlIHVubmVjZXNzYXJ5IGNoZWNrIGZvciBx
cC0+aXNfdXNlci9jcS0+aXNfdXNlcg0KPj4gICAgUkRNQS9yeGU6IFJlbW92ZSB0aGUgY29tbW9u
IGlzX3VzZXIgbWVtYmVyIG9mIHN0cnVjdCByeGVfcXANCj4+ICAgIFJETUEvcnhlOiBDaGFuZ2Ug
dGhlIGlzX3VzZXIgbWVtYmVyIG9mIHN0cnVjdCByeGVfY3EgdG8gYm9vbA0KPj4NCj4+ICAgZHJp
dmVycy9pbmZpbmliYW5kL3N3L3J4ZS9yeGVfY29tcC5jICB8ICA2ICsrLS0NCj4+ICAgZHJpdmVy
cy9pbmZpbmliYW5kL3N3L3J4ZS9yeGVfY3EuYyAgICB8ICAzICstDQo+PiAgIGRyaXZlcnMvaW5m
aW5pYmFuZC9zdy9yeGUvcnhlX3FwLmMgICAgfCAgNSArKy0tDQo+PiAgIGRyaXZlcnMvaW5maW5p
YmFuZC9zdy9yeGUvcnhlX3JlcS5jICAgfCAgNCArLS0NCj4+ICAgZHJpdmVycy9pbmZpbmliYW5k
L3N3L3J4ZS9yeGVfcmVzcC5jICB8IDEwICsrKy0tLS0NCj4+ICAgZHJpdmVycy9pbmZpbmliYW5k
L3N3L3J4ZS9yeGVfdmVyYnMuYyB8IDQyICsrKysrKystLS0tLS0tLS0tLS0tLS0tLS0tLQ0KPj4g
ICBkcml2ZXJzL2luZmluaWJhbmQvc3cvcnhlL3J4ZV92ZXJicy5oIHwgIDMgKy0NCj4+ICAgNyBm
aWxlcyBjaGFuZ2VkLCAyNSBpbnNlcnRpb25zKCspLCA0OCBkZWxldGlvbnMoLSkNCj4gVGhpcyB3
aWxsIGhhdmUgdG8gd2FpdCB1bnRpbCB2NS4xNS1yYzENCj4NCj4gSmFzb24NCkhpIEphc29uLA0K
DQpJdCBpcyBmaW5lIHRvIG1lLiAgVGhhbmtzIGZvciB5b3VyIHJlbWluZC4NCg0KQmVzdCBSZWdh
cmRzLA0KWGlhbyBZYW5nDQo=
