Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B64A48A583
	for <lists+linux-rdma@lfdr.de>; Tue, 11 Jan 2022 03:23:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244124AbiAKCXD (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 10 Jan 2022 21:23:03 -0500
Received: from esa18.fujitsucc.c3s2.iphmx.com ([216.71.158.38]:33204 "EHLO
        esa18.fujitsucc.c3s2.iphmx.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239445AbiAKCXD (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 10 Jan 2022 21:23:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1641867783; x=1673403783;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=SWSanC9MU70YFO0GQqnGyK23v5XzayI9JxLzl/rQ6gE=;
  b=BxJJzrUzjTgpFSc7+vLXGPSvT/N5drYWL3W3O0pxLrPW6BXtuSxbe4Sd
   yre77UMsqip5h/09TjT9lAHIcrMmiKjG2SAysvVEtFohQMlqClnbZqiPh
   N4BffQgfoxubNHGF6eCI3tFEPOVhdwVeHST+aTCZU4HQqNDq/fLCLf4os
   +hvXUpR/oJHL62iE4e8OUAOPEN/Qv6oF9rV6pGY9SLquUBQxe96Lxan5T
   tL3+8/LOrmMMoPEJ+BU+2TIFOmHHO45W2vbWMeOTE858CeAcFF0Nmq54h
   QWvG3ObTEryq3cX9A5fMS9muxm5Kg17wvWeD1CGOBpBaH/3CyNgNBtUpV
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10223"; a="48287768"
X-IronPort-AV: E=Sophos;i="5.88,278,1635174000"; 
   d="scan'208";a="48287768"
Received: from mail-tycjpn01lp2170.outbound.protection.outlook.com (HELO JPN01-TYC-obe.outbound.protection.outlook.com) ([104.47.23.170])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jan 2022 11:23:01 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eeyeQbCn4DaGOCsWt6fzf/smt+wbY0iba+1aKzFNQ8wsVUel16pJ/n+Tc4wVQotelwuU1VgUGQwXCPKIqNT+eTchr6Q9snpfG3VdZ2FK53BZyN7sjWh0dJlXsPGTFAcG3ynXwEqhRNE8R9VscGf26goa0pJVW2Y4h1enPYvFjJrtfj4Vv6RQM+sLe3fsCkUyEmo5I4LqZ1e94wdqyueWf6KgqBVCcQQ3gvqcszbe0bBfgGXZPohPPzgyLtYYXZRmverN03cMakK0/EnA5ApoNYoxP//xyEPL+UqvTNyjPnGlZpiPKl+fj4kEqoXBmfMoncY2ifX/wMBXIqYVu17Q1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SWSanC9MU70YFO0GQqnGyK23v5XzayI9JxLzl/rQ6gE=;
 b=A6F0CRw4c3lr50Ud1dTVl4Pg48/smzy8Bk/+2cFPiPBjAvqRRKUlFkoDQikTY0X27toQm+u0/xbAxnsmas4CEf435H6IlhiQ5ohPWZiGYyJn/+JXLwb0meW+fx0+k6l5mNgShp0k5bY1olXuxuTa6vXmTvH5bkAtIsFSKairg34SlnUkvgvEgqOSPszywHceqjtZ9rKYb3qOu8l2oLTI6PiR70pqOStSBzcj/OR/T1ZyaKq2f7J5FllaphfYRMOur1DCFhiVhP8JAqS/Ve0w6zbb5el5KumgOB8oDzUITl61UBmZzgLfBSTLSuZTXiOrRngP46ijrrq3nJTCNJTANg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SWSanC9MU70YFO0GQqnGyK23v5XzayI9JxLzl/rQ6gE=;
 b=nETyTrluVgZaFnRXPaTQ6FqjM0FWTkATHXQhAats8b1TnGtdR6G0P0LzDtNpmC0tqMc/zwKtdRkZbLViQkMKp+RFQJsp19pxLi/qyFsTJTfss1/j5FitctXlzMxJlS7S4V4CpIS/KY+wbTz2fWTDUz7lrXmgZiQroiZietaBO7E=
Received: from OS0PR01MB6371.jpnprd01.prod.outlook.com (2603:1096:604:104::9)
 by OS0PR01MB5940.jpnprd01.prod.outlook.com (2603:1096:604:b9::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.7; Tue, 11 Jan
 2022 02:22:58 +0000
Received: from OS0PR01MB6371.jpnprd01.prod.outlook.com
 ([fe80::99c6:1a48:180d:dfd1]) by OS0PR01MB6371.jpnprd01.prod.outlook.com
 ([fe80::99c6:1a48:180d:dfd1%4]) with mapi id 15.20.4867.012; Tue, 11 Jan 2022
 02:22:58 +0000
From:   "yangx.jy@fujitsu.com" <yangx.jy@fujitsu.com>
To:     "yangx.jy@fujitsu.com" <yangx.jy@fujitsu.com>
CC:     "rpearsonhpe@gmail.com" <rpearsonhpe@gmail.com>,
        "leon@kernel.org" <leon@kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: Re: [rdma-core PATCH] providers/rxe: Replace '%' with '&' in
 check_qp_queue_full()
Thread-Topic: [rdma-core PATCH] providers/rxe: Replace '%' with '&' in
 check_qp_queue_full()
Thread-Index: AQHYBoyJUFvjlQk8IUKkKbse6i9NXqxdFzAA
Date:   Tue, 11 Jan 2022 02:22:58 +0000
Message-ID: <61DCEA00.1030002@fujitsu.com>
References: <20220111014145.2374669-1-yangx.jy@fujitsu.com>
In-Reply-To: <20220111014145.2374669-1-yangx.jy@fujitsu.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c1878136-7ea9-4b53-c79f-08d9d4a9488b
x-ms-traffictypediagnostic: OS0PR01MB5940:EE_
x-microsoft-antispam-prvs: <OS0PR01MB594030CE199773479C5F218C83519@OS0PR01MB5940.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:159;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 9+dCCSHxlCymGf0CcFdY1kMcFQsHg91/QDIbhJDwvKlfSzbecF5JvqMyJzFCRfGmXp6k9xJLt0f4VevNjZkE7lGSuszoC5mxx7fZ+HNSU9iojyJ1gQZGYjhKmja5AR6uMaj2kHKmZ4XSe4Oyltj9DqC2dzLZ4Lh4AcEwbc1iuoClL60Kxi4LdqgELVKomh2QmoTAu5n82KdoNwK1KsB2snGw6JkR9v6tKOHo+uhnIEmtK5b+YZs0HFS85hWynDezpTw2aeu0I21S+bcIetu/KhqG1qnvAcrPvz6ol1JvbUiQr8I86M9z/pkVeBMAxk0VBp5wy2oTOCBQEXV/ldEyzZoRSkUbr1RylVjNbBS5mN5jDHZsrmfYCHd6QPo6hXZBTBouCEHnIZL7VuhpiypuvSqs5OT1+oNZUEow6X3O5IdJSj9L0rlibLz3fjobLEBes2XjEGj2QECQfqyXoitatve2LW9E9Al8KFmZySXgM3l+UaEMMriX2jkTGqCC6VCORAjT/A6BE7ofzFFWmKia3t2B7O8QoylghlN5J8WS8oT/ox7wyp7XF/wNWggfxGywxfad1L2CrqISZ9zPam5LoQ348ci7BTCO+RPjXEQomCCIUv7LOUVGaW0utzhQzOOppIVsQj+6A7amYsRhmE6AAQ6dDZHDIEheBJpvag1m1n8x3xFxOdnJAwFj4bu+IeoGynU22HB7x3rcIPgxE/jjnu62FMaTanv5tRDAL2pLJYNSzuekPzlVodsvZytqDWwp
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB6371.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(87266011)(82960400001)(2906002)(37006003)(83380400001)(38070700005)(85182001)(6486002)(6200100001)(71200400001)(86362001)(54906003)(8936002)(4326008)(33656002)(186003)(53546011)(508600001)(26005)(122000001)(91956017)(76116006)(6506007)(6512007)(38100700002)(5660300002)(36756003)(8676002)(66946007)(66476007)(66556008)(64756008)(66446008)(316002)(2616005)(6862004);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?RU5nZGlScTNlMksyaktGQVh4VmpHdVdaVkJHaTN2YVlCcXpiMVI5ZlM4U21r?=
 =?gb2312?B?OG9pc1F6SU1ES0RkREhDOFJubkFuS296MEdIUWNNSGRDWlB6SDNlaHlnR1ZE?=
 =?gb2312?B?V0UyZFJERWVaelJTNDlZK0R2QUR3cnFLSldQaHZYOWQvSlRWTURLeThMMllh?=
 =?gb2312?B?S1FBbURhK3BtMjQrRE9pMitmeTNmR2hSNG1yTUdaUStZRjQ0bU0wS2Rvcnpz?=
 =?gb2312?B?aWozc1ZENGF0U0hyMzZkRmowdXdaQ1BKQ3BKbWEyWDQ4YjJEOE5HZnQ5OGt4?=
 =?gb2312?B?bytBenBCQ1hKczJpbFZYYTdkc2l5MERiV3U1QTltRS8rMmRwZTNLNVQ0RU80?=
 =?gb2312?B?UEk5ZUdsbEJEalIrVlE1YjExNy9ibXg3d3RuM0lVZWlpRFV5R0RrREszVjNQ?=
 =?gb2312?B?WDFMTml4dFFMQXRTZVB0dW8vUUZtZVhzdktHb2JrNlplQzViSlJjR3Y5L3o4?=
 =?gb2312?B?Wjh3V3Q3c1VtSFNyVDFVRmZ1ayswamhYZ3hhVlB1eE9pd1pzS2RPSVJmRnZ2?=
 =?gb2312?B?NFVsLzNQalRUaXNybmxDUlNDeDRQK0hoTzUwMC93OFhySlNna0ZoK0I5QjNB?=
 =?gb2312?B?RmNUYzB6cmJGSEZwazBTS2Y4ZmpNSnFyeEtGM2ZNRFJOc3lGNVQyRk5pR0lh?=
 =?gb2312?B?RmNOOTFyejZJK2tvSEVJVzVHL09RQldyczk5VWQyM2pIcTliYzR2MmFDWXo0?=
 =?gb2312?B?R2QrRXpJUm5kZ3NXM015WWNOSjZUekhZOVVkd3RjSmMxaG9OZGRoRGxUZ1kw?=
 =?gb2312?B?TTVKcVV2aEk0cHdjdzhwbXVJcTRoZlRwQmw5aWtsUTA1TGxra0lpZks3Mlg2?=
 =?gb2312?B?SG56eS9FYVdTZWhSaUUzU1FJYWdEODg5YjFMRmY0YkhtTUE5TVo0OHZsaEs1?=
 =?gb2312?B?bHJEdVlnWFdENDVNUHpZYjBLQWxMZE54dU5mK0pBa2EzV2kzREQyKzF4YUMz?=
 =?gb2312?B?WUJBdUlWV1JuUU0zb1R0S1BhNmNlTDgxdWo1OVhWc3gwQmNXMnEzeXFVdVlz?=
 =?gb2312?B?dzVCUDNPbDg5cFB2bmJJai8zWThOZ1R4Skg5cDNwQ0hMeGQyNU1tOFpGcFVi?=
 =?gb2312?B?ZG4yc3FYOW1KZEdMaERPM0g1OXF4a2JqWkdzcXdmM0t2Mmh0UExRbDZNMFJ5?=
 =?gb2312?B?RzJYTnlvVjkxTDJSVng4Q1VvdDZUcGY0VlNtYVkxRTB2TGZOVG5tM0ZIL2sx?=
 =?gb2312?B?akgxTEFpOXhDTzkyTHJxQ3RDbHg4NWJKbjNQcit5ZnEwbDFMS3JGck9xYlo2?=
 =?gb2312?B?bEh5MkMvYzNqam11S1VOZGxwNlFuTEN2YjI1OWRLRTV2YWtKaS84cEk2eVVC?=
 =?gb2312?B?MWNiMGJ5MW5idFg2dzdaQndHMUhWYmFTUVBKUmRpQjFrSml3TFJRS1RuVjNv?=
 =?gb2312?B?UGdUakZYU0ZwSjQzRWUrb09ka1U0aGwzNElUMmE2YklxaldQaEY5THVuVnd0?=
 =?gb2312?B?aFl1eFY4dFJETFNWS0kvYnluWnp5bE1hU2lWVUt0QmkxMmNLaWVJd3lEck5s?=
 =?gb2312?B?dlJHL3NBaVhuaTRoZ2NIZXFZT3I2Q3NnRVZ4dXFBOCtCSGlPZU5TaGVCaHpH?=
 =?gb2312?B?WE9sS2E4Z1pydzFGQ2JEQkZJcW0yY2luM25tVldDQVBWZkZzRjVpMFFRZkdR?=
 =?gb2312?B?bmtSakFhcUdtRUxxODVhalF1eW9iODJwblJSa0d1VFJqb256dm4vTnd0UkZC?=
 =?gb2312?B?NHBwSnNzUXdGRUpJUHA2dDBuZExPemJwM0k5TFhQRlVnVmEzV0JuMlJ2TlZG?=
 =?gb2312?B?M2ZTTXF3M1JCY0prS0RacmlpWndqUmlndWdJMThwUWFyR2Y2UHhybFZZMzlS?=
 =?gb2312?B?dytSR2ZIYisxM3MrU2ZtVVlLak9NU2pPMEpUMVJKMjRPUDl2cTB0YjRoOVp1?=
 =?gb2312?B?UTM1YW1vOHltTXR6ZzNTRStoSlpVQ21zRHJtWTh2ckpobzVjRnhoVTJWOGlU?=
 =?gb2312?B?Q1R5LzRqOWdSMzlrbStGTjdPU3BWclVJTmRrbDFpR2dKRnpUMENFSEtMb1d5?=
 =?gb2312?B?eGJCQkNUbTlFQXVQdC8zcXRPcXVES1ROSmZCWTZyMWhodEFEWEYvQXhORW9Q?=
 =?gb2312?B?bW5ER3JLelh2aHlhRnRKV2JjMnVSM2NJeTdTU294c2FnUTUrajV5NVhTd0FW?=
 =?gb2312?B?NkdBVCtJb3A4TExHMU13eEZjd1ZEWUtWTUdtbkREN3BRYVVSN3pyK3hJaCtJ?=
 =?gb2312?Q?l3J1iJv8R3CCRMY3qJuLzBk=3D?=
Content-Type: text/plain; charset="gb2312"
Content-ID: <6C5AB46A3D09B0479A6C76769330A861@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB6371.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c1878136-7ea9-4b53-c79f-08d9d4a9488b
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jan 2022 02:22:58.0848
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8bdnB0jIRYoXIPGaaQE4bNdv1JEBL9qXeoiMN2E4DtC11S5eGJCHkQv5bVYn8zUAFYcVS4iuu/qAT+kJ9kC+zw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS0PR01MB5940
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

T24gMjAyMi8xLzExIDk6NDEsIFhpYW8gWWFuZyB3cm90ZToNCj4gVGhlIGV4cHJlc3Npb24gImNv
bnMgPT0gKChxcC0+Y3VyX2luZGV4ICsgMSkgJSBxLT5pbmRleF9tYXNrKSIgbWlzdGFrZW5seQ0K
PiBhc3N1bWVzIHRoZSBxdWV1ZSBpcyBmdWxsIHdoZW4gcXAtPmN1cl9pbmRleCBpcyBlcXVhbCB0
byAibWF4aW11bSAtIDEiDQo+IChtYXhpbXVtIGlzIGNvcnJlY3QpLg0KSGkgQWxsLA0KDQpUaGUg
Y29tbWl0IG1lc3NhZ2Ugc2VlbXMgaW5hcHByb3ByaWF0ZSBzbyBJIHdpbGwgcmVzZW5kIHRoaXMg
cGF0Y2guDQoNCkJlc3QgUmVnYXJkcywNClhpYW8gWWFuZw0KPiBGb3IgZXhhbXBsZToNCj4gSWYg
Y29ucyBhbmQgcXAtPmN1cl9pbmRleCBhcmUgMCBhbmQgcS0+aW5kZXhfbWFzayBpcyAxLCBjaGVj
a19xcF9xdWV1ZV9mdWxsKCkNCj4gcmVwb3J0cyBFTk9TUEMuDQo+DQo+IEZpeGVzOiAxYTg5NGNh
MTAxMDUgKCJQcm92aWRlcnMvcnhlOiBJbXBsZW1lbnQgaWJ2X2NyZWF0ZV9xcF9leCB2ZXJiIikN
Cj4gU2lnbmVkLW9mZi1ieTogWGlhbyBZYW5nIDx5YW5neC5qeUBmdWppdHN1LmNvbT4NCj4gLS0t
DQo+ICBwcm92aWRlcnMvcnhlL3J4ZV9xdWV1ZS5oIHwgMiArLQ0KPiAgMSBmaWxlIGNoYW5nZWQs
IDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0pDQo+DQo+IGRpZmYgLS1naXQgYS9wcm92aWRl
cnMvcnhlL3J4ZV9xdWV1ZS5oIGIvcHJvdmlkZXJzL3J4ZS9yeGVfcXVldWUuaA0KPiBpbmRleCA2
ZGU4MTQwYy4uNzA4ZTc2YWMgMTAwNjQ0DQo+IC0tLSBhL3Byb3ZpZGVycy9yeGUvcnhlX3F1ZXVl
LmgNCj4gKysrIGIvcHJvdmlkZXJzL3J4ZS9yeGVfcXVldWUuaA0KPiBAQCAtMjA1LDcgKzIwNSw3
IEBAIHN0YXRpYyBpbmxpbmUgaW50IGNoZWNrX3FwX3F1ZXVlX2Z1bGwoc3RydWN0IHJ4ZV9xcCAq
cXApDQo+ICAJaWYgKHFwLT5lcnIpDQo+ICAJCWdvdG8gZXJyOw0KPiAgDQo+IC0JaWYgKGNvbnMg
PT0gKChxcC0+Y3VyX2luZGV4ICsgMSkgJSBxLT5pbmRleF9tYXNrKSkNCj4gKwlpZiAoY29ucyA9
PSAoKHFwLT5jdXJfaW5kZXggKyAxKSAmIHEtPmluZGV4X21hc2spKQ0KPiAgCQlxcC0+ZXJyID0g
RU5PU1BDOw0KPiAgZXJyOg0KPiAgCXJldHVybiBxcC0+ZXJyOw0K
