Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 484F864F89F
	for <lists+linux-rdma@lfdr.de>; Sat, 17 Dec 2022 11:09:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229518AbiLQKJp (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sat, 17 Dec 2022 05:09:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229949AbiLQKJo (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sat, 17 Dec 2022 05:09:44 -0500
Received: from esa10.fujitsucc.c3s2.iphmx.com (esa10.fujitsucc.c3s2.iphmx.com [68.232.159.247])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5641DA451
        for <linux-rdma@vger.kernel.org>; Sat, 17 Dec 2022 02:09:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1671271783; x=1702807783;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=qbOMFteWdKbpic7A+TOL1KxAjvoNnMAYM797yHzq4TM=;
  b=RWGmHiH01EDkBzNeyf4qE5WGIYnOE3qFNycAsIIv94vmcwD4uvV7WjLL
   kT68BO2Qkp4uGhyZDWdiBwzIQq0/quBs5iXasyzX0RYcfoPATTO3warz8
   dB8FRJfL8CPdAirztEodzg3X1LNvxX7W80mc4QyFAuZFCTra/+cZ8nvKw
   8crI3+RtJzMu3uhUyTN990Zb++iW9NlFmyPgc0IWUAz7fDNNSKr6V1ef8
   tVVl/Gzkzs1PEAQtn6wnhSBE+oxgAlXYkx+49TC4JbjxcWBGmcmiD09it
   Q0L8V8yua+Ag2K30SCmT87qr40kg9ZuEMLzGbIhgLmQYu7UDKmkJq1RDo
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10563"; a="72781126"
X-IronPort-AV: E=Sophos;i="5.96,252,1665414000"; 
   d="scan'208";a="72781126"
Received: from mail-os0jpn01lp2109.outbound.protection.outlook.com (HELO JPN01-OS0-obe.outbound.protection.outlook.com) ([104.47.23.109])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Dec 2022 19:09:39 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Hl9WKVu90p+FxPY0xjFzkh9n+bxDCUOo7axmeBzktd7F5BbTwuSnk7gQ8cGLMKkTvj4hZsNKs4Y12pHNBY6IxFjLJMC4XIBJGT4G88J19THTpQTWiWyKR8qip1hcSXzxlBmzGdrGoUAD33jC4z7rS9gMy5zvhn8Vq43rFCG2DNBFlnQjyzIC48GyRPqvSjqMyJtprcYBTvXObjhCI8+Zphms8Jkvn4sgBv+b26wWz155Jc4YSyL2o+mWEWHDajATDM00zhJNPixrYlTI8bGkZU1ZokLrM8ateaIVmPxvBWO90RYkOY0OHe93D5luZwuc5IhLgknLwkfiTuJePdGO7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qbOMFteWdKbpic7A+TOL1KxAjvoNnMAYM797yHzq4TM=;
 b=geQlIPMXBHotmRp9n0jaaKFSbjkj5ccnlGE3XFyUEIGNoQqbomkxu38KoUPeuYr5tni8UlflEALG9ZCi7i7C7V7EPy93PHRMMHOaH8U3wce72hWmqi+fW1YnV0m1kNYBLvVsezPoMj4kjgKXZHJzHMwUW1TjFJdN9K1dLoSSWDBGCmWEvbrJ/LCUwB17JkFSLc+2koYyTb1yPrsRk5HxAsZSTSFaGjnGBl+b4GiiII+cAEgmO0tt9iD3u/4S/k/DUH548jwRGJu7JDpuSEMefI5S6LEdWZZMY8qTtwaGEzkwiRiXdU1LyAcz+OxgIV/BBIr52fLSr7jxCk9R0rj7ww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from OS3PR01MB10390.jpnprd01.prod.outlook.com
 (2603:1096:604:1fb::14) by TY1PR01MB10882.jpnprd01.prod.outlook.com
 (2603:1096:400:323::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5924.16; Sat, 17 Dec
 2022 10:09:37 +0000
Received: from OS3PR01MB10390.jpnprd01.prod.outlook.com
 ([fe80::b01a:186c:94a7:acc9]) by OS3PR01MB10390.jpnprd01.prod.outlook.com
 ([fe80::b01a:186c:94a7:acc9%8]) with mapi id 15.20.5924.015; Sat, 17 Dec 2022
 10:09:37 +0000
From:   "lizhijian@fujitsu.com" <lizhijian@fujitsu.com>
To:     "Daisuke Matsuda (Fujitsu)" <matsuda-daisuke@fujitsu.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "leonro@nvidia.com" <leonro@nvidia.com>,
        "jgg@nvidia.com" <jgg@nvidia.com>,
        "zyjzyj2000@gmail.com" <zyjzyj2000@gmail.com>
CC:     "rpearsonhpe@gmail.com" <rpearsonhpe@gmail.com>,
        "Rao.Shoaib@oracle.com" <Rao.Shoaib@oracle.com>
Subject: Re: [PATCH 2/2] RDMA/rxe: Prevent faulty rkey generation
Thread-Topic: [PATCH 2/2] RDMA/rxe: Prevent faulty rkey generation
Thread-Index: AQHZEG48O/dxc8w9O06wj9iLNkWGva5x3ngA
Date:   Sat, 17 Dec 2022 10:09:37 +0000
Message-ID: <5c3f1c2a-f923-3bdd-52cd-131883614d25@fujitsu.com>
References: <20221215101439.3644683-1-matsuda-daisuke@fujitsu.com>
 <20221215101439.3644683-2-matsuda-daisuke@fujitsu.com>
In-Reply-To: <20221215101439.3644683-2-matsuda-daisuke@fujitsu.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS3PR01MB10390:EE_|TY1PR01MB10882:EE_
x-ms-office365-filtering-correlation-id: 33dd47e4-7340-46dc-f7d5-08dae016cdad
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: aYsIZBF6DYvDZCJFmmdggFE96AjyAObB5CbX7OEDgxzAI3bOaxIsV6l2G65xpURUtm1o2Oyh9zbqtN5qgwLOOqVIECgoD1EFUVdKwnKxjEb5GyCERYswGNYesFf4gjxN8FuS9pczqlwLrZEMZv7A5MZPBA2swWFc8NDZNDNgHhXcTgIzMDgY6RRl0fKQRoOierrqOkHZMN4sw/rIx+aBwSGci9dywIhwdgRNlPPnaK/ldZpGwvfcpeDi4ZPeLf4z7+7ddNDPIWe7yfgbTDWaqO8mEzrpon6luhIaYgavwk1lEGquS5E9heAdO0xzCSR7dd/6GCDcYM7cKDTzuH2+1+UYvak3d3k6zppPv/pZMI9+xC8k5EJvbij6TNsDW4UDYb+NvFiJZTtAB9g4Bxs8SqnpjbwDzMhLfQTCFjgwhdpiXeLCeX8kQ04u2D8+36KoU5AMHXTusK0KzqIaRBYXv0AHYz/WSukAc7aNrNr7/3KM4AtrMsjCcEsGZsSGQNQnt/Blioe7Mvl/3ORqPPQfOgHsa5F0jSFSlRByJG8LgNSqR579eFnRB6y2bbRwr15DUFUZl2x6tLq4l1dMelGFLfY4uZCv+OSk/OuD132JdxV9lG/jBF4/0nmE++bjcAZKH5bcx2dldul278JnfhyPNX01/8leOTwZaupD3omhU5mpWd/yH/B0B0d+KEC1CnH1YZk7Pa/OQhhhybMRisjWjE00ohTqEq17iT/MHp2zmQ6lstJ3I1puTLlaTKcQAT9sebw9tvhVeZFcXYbYKzjV9lNBhNIUEU/P12m8NVDfNHE=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS3PR01MB10390.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(396003)(346002)(39860400002)(366004)(136003)(451199015)(1590799012)(1580799009)(31686004)(31696002)(38070700005)(86362001)(85182001)(36756003)(122000001)(83380400001)(38100700002)(4326008)(53546011)(26005)(6512007)(6506007)(478600001)(186003)(8676002)(71200400001)(54906003)(110136005)(6486002)(82960400001)(316002)(91956017)(66476007)(76116006)(66556008)(64756008)(66946007)(66446008)(2616005)(8936002)(41300700001)(2906002)(5660300002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Tm1BVEcxSGdlSm1UWmZBUm1CcjJUSTlSTmhlNlhFUC9UMk56WDhMTXNpa0ho?=
 =?utf-8?B?V2I0eGd1WWdHWFZ0NCtGcGlmTzVsQUNFdkExTHppNnFIbzNJSzlybnRYZXlt?=
 =?utf-8?B?T3prUk1jNmx6S2hwUzg3VTVSdVdkcjVuaHgvVjVMQTBBTFFCMnQ0a1hJZzRE?=
 =?utf-8?B?R1VIWUV4TXRxNWJnOTRxOHAvbVRFSVF5Nm00U2FCWjJyRCs5WEJCM0pudkhV?=
 =?utf-8?B?bk4rSW5TN1hBUEMyR21pdlhkRHJscDVpTjI3aXpwU0NvMmxaRTRFaGNUZVVt?=
 =?utf-8?B?UzhmWFdHS0R6dHczbGlHOFV0OE5wcWl5RmdwNG9mSGV4d2h6clE5MEl4V1Fw?=
 =?utf-8?B?eWs3KzZYVG50WkFobXJudDZQM1hhRGMzRlRVdTZvZGR6dWl6VlExVTB5OW5G?=
 =?utf-8?B?bzhrejhFVXQxOWtnNzBxZTVlQmVsYndGRVkyVWVqVCt4MXFSTzhUMjY1Q1Vx?=
 =?utf-8?B?T05ab3VrdkUzUVVsNCtKQnI0SWNORFhyNkZRQ0xEWmQwcGEvcGE0VjNHaGhD?=
 =?utf-8?B?NnRuRnNvaHdtY3lJYjFtQko1b0wrYWcwQU9FRW54Zmlodit6aXNlbXZjM0F0?=
 =?utf-8?B?SGVYdUpNdGhKWHdVTUpYM0JhYytiRVBiMTl0VGZnRjZJSlpuU2VPVFVZazBr?=
 =?utf-8?B?RVcrM1FRS2w3MWltRTd5dGFzeWhPTnlxRFg2SjFvWGJEYndxWnlXbUlFSEJH?=
 =?utf-8?B?VTAyL0hqSHZVMUtObHVrQjlEWDRsdGcvZUlWVTZhUTZ2cUtoNUh1bDg2WmxL?=
 =?utf-8?B?ODZSbnJhZGx4ZHd3UmtKaUxOblcvN09HK1g0UzMxU2M2SlZuSCt6eG1sa0ho?=
 =?utf-8?B?YjhocGtlSVVKNFYzMHNlNnlEUDdYamR1RDhCRUdoZHFQeDJVeitmdHVJV0I1?=
 =?utf-8?B?TW1NVGlaOXNzQ2pEcm5FbnYwd3I5dmZOV1hDSndwYjFHZGhqZ3VxTnZhbWhm?=
 =?utf-8?B?VWhPM2JBOHRaZk9DVkM2SkZaNVpGV0U0cFR1V0dHWlgxUkVFZmxyVEhUQ1pP?=
 =?utf-8?B?c2RlSER1Yk9haGd0eU1ZTzBwZ21zdHJzbUp6NlhuY1BPdTNWcyt5eUlmVlRh?=
 =?utf-8?B?S0lnL3I0NnpsdWhISHd3S0NLaEpNYzZ6ZVJrNU9RZ0JnYVdPbVdpWWJKM1Qr?=
 =?utf-8?B?RFNuWDVwbDdNcHV6L0JYSWxYdDNUWEFxYzhTdGlRa0dRd244ZW1RbmJWbVBy?=
 =?utf-8?B?RUFFdWVsK1dqSWtvOGhocXAvV3lMSGNvaU5JZEh1N2FmMjZZandNT2NiU3BP?=
 =?utf-8?B?ZHNMNVYyTlVVU2NvWTVZS2lEbytTN20wNzVSalpCRGRMbUMwY3ZwYkxjSzVm?=
 =?utf-8?B?cWZkWTA4QmxLWEJmM3pGNHJsS1prL21STm04dDczR2tCRENMUjhTdGpBNzh1?=
 =?utf-8?B?VHdUVDdYN3liZ0hYSnhDR3FlSkRITk1SMVFuQk5XQmg4eTUyTkFIL0hYRGpV?=
 =?utf-8?B?VjlGTjJQK1lYQTNaSGRtTGt0WmJOd1lYa1FTWUJEbWNJS1NXQnkwMUdjUzg2?=
 =?utf-8?B?Y3cyOTY3Qm1QRWsrOWlXZ0N4eEtDVHEyNG5QWU9qanN1d0k2aFEzUDdhVXIw?=
 =?utf-8?B?aWd4SEFyVHJ2dmdxMUtQUnJLZEVHM2pTelpTTmlGUG1TOCtFbUZOTysyRW96?=
 =?utf-8?B?aFMzNkFiTFRqa29wT1pnK3dXYzZpR0lhWi9hSXBRRm16WmQvaTc2dkRwS0ZC?=
 =?utf-8?B?bGlDZ3VyUm9FNlJONk50MWI3ZzJmai8rZjVuQlFlWWhYRUVmSW1pcmVnejlZ?=
 =?utf-8?B?OG1ramRhTTJVNlk0YXF5YThhVFlUN0tPRGQ2TWRHN2dTZTRXTjV5L1VGV2l2?=
 =?utf-8?B?c29DdmRtYld0ZFhqbGMvc1d0Y2FQRDBHRHg2MzQyN3V5ckVqQ3VpSDBvdVpz?=
 =?utf-8?B?MjlvVVF6QTFCTDd0THV2b28zN0tVU3ZRNHlKTXllM1hWWk1GRm9BQTNXZU9x?=
 =?utf-8?B?enJVaW9UY0JIVDkraWZmYnJSb3FJZXRKb3phbm5BYjVvVXpMN29vcUtIcTNk?=
 =?utf-8?B?Tndnblo4WERiOEVOMm12aEo5VkJLc2hrVDYxSG1CYTlOR3VzaHZTTE9ERnly?=
 =?utf-8?B?ZXJRcXNVYkJzYW5IVTBac3FuRlZVczY0aDNtYXpPZVVmNzN2RTAzWEFWN0RD?=
 =?utf-8?B?S0xncFJTa2F5WlZKVkJwRTdQM1g3ZkhOc3plT3BMdXk2RU1iaE1iNlZhQklJ?=
 =?utf-8?B?d2c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E3D9D8B2BB19B14F8D80D14C6BBD7B59@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS3PR01MB10390.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 33dd47e4-7340-46dc-f7d5-08dae016cdad
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Dec 2022 10:09:37.0667
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: b1YRzXHdUWjnempq0WjzfBHblmXUMdqIgiHKspsWWYZW8AZaf/B6jo9s3/mxC2WTOTBwzbCzzRFeyT9zQZt4fg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY1PR01MB10882
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

DQoNCk9uIDE1LzEyLzIwMjIgMTg6MTQsIERhaXN1a2UgTWF0c3VkYSB3cm90ZToNCj4gSWYgeW91
IGNyZWF0ZSBNUnMgbW9yZSB0aGFuIDB4MTAwMDAgdGltZXMgYWZ0ZXIgbG9hZGluZyB0aGUgbW9k
dWxlLA0KPiByZXNwb25kZXIgc3RhcnRzIHRvIHJlcGx5IE5BS3MgZm9yIFJETUEvQXRvbWljIG9w
ZXJhdGlvbnMgYmVjYXVzZSBvZiBya2V5DQo+IHZpb2xhdGlvbiBkZXRlY3RlZCBpbiBjaGVja19y
a2V5KCkuIFRoZSByb290IGNhdXNlIGlzIHRoYXQgcmtleXMgYXJlDQo+IGluY3JlbWVudGVkIGVh
Y2ggdGltZSBhIG5ldyBNUiBpcyBjcmVhdGVkIGFuZCB0aGUgdmFsdWUgb3ZlcmZsb3dzIGludG8g
dGhlDQo+IHJhbmdlIHJlc2VydmVkIGZvciBNV3MuDQo+IA0KPiBGaXhlczogMDk5NGExYmNkNWY3
ICgiUkRNQS9yeGU6IEJ1bXAgdXAgZGVmYXVsdCBtYXhpbXVtIHZhbHVlcyB1c2VkIHZpYSB1dmVy
YnMiKQ0KPiBTaWduZWQtb2ZmLWJ5OiBEYWlzdWtlIE1hdHN1ZGEgPG1hdHN1ZGEtZGFpc3VrZUBm
dWppdHN1LmNvbT4NCj4gLS0tDQo+ICAgZHJpdmVycy9pbmZpbmliYW5kL3N3L3J4ZS9yeGVfcGFy
YW0uaCB8IDggKysrKy0tLS0NCj4gICAxIGZpbGUgY2hhbmdlZCwgNCBpbnNlcnRpb25zKCspLCA0
IGRlbGV0aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvaW5maW5pYmFuZC9zdy9y
eGUvcnhlX3BhcmFtLmggYi9kcml2ZXJzL2luZmluaWJhbmQvc3cvcnhlL3J4ZV9wYXJhbS5oDQo+
IGluZGV4IGE3NTRmYzkwMmUzZC4uYTNkMzFiZDQ1ODk1IDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJz
L2luZmluaWJhbmQvc3cvcnhlL3J4ZV9wYXJhbS5oDQo+ICsrKyBiL2RyaXZlcnMvaW5maW5pYmFu
ZC9zdy9yeGUvcnhlX3BhcmFtLmgNCj4gQEAgLTk4LDEwICs5OCwxMCBAQCBlbnVtIHJ4ZV9kZXZp
Y2VfcGFyYW0gew0KPiAgIAlSWEVfTUFYX1NSUQkJCT0gREVGQVVMVF9NQVhfVkFMVUUgLSBSWEVf
TUlOX1NSUV9JTkRFWCwNCj4gICANCj4gICAJUlhFX01JTl9NUl9JTkRFWAkJPSAweDAwMDAwMDAx
LA0KPiAtCVJYRV9NQVhfTVJfSU5ERVgJCT0gREVGQVVMVF9NQVhfVkFMVUUsDQo+IC0JUlhFX01B
WF9NUgkJCT0gREVGQVVMVF9NQVhfVkFMVUUgLSBSWEVfTUlOX01SX0lOREVYLA0KPiAtCVJYRV9N
SU5fTVdfSU5ERVgJCT0gMHgwMDAxMDAwMSwNCj4gLQlSWEVfTUFYX01XX0lOREVYCQk9IDB4MDAw
MjAwMDAsDQo+ICsJUlhFX01BWF9NUl9JTkRFWAkJPSBERUZBVUxUX01BWF9WQUxVRSA+PiAxLA0K
PiArCVJYRV9NQVhfTVIJCQk9IDB4MDAwMDEwMDAsDQoNCk1heSBpIGtub3cgd2h5IHRoZSBSWEVf
TUFYX01SIGlzbid0IChSWEVfTUFYX01SX0lOREVYIC0gUlhFX01JTl9NUl9JTkRFWCkNCjB4MDAw
MDEwMDAgaXMgbXVjaCBsZXNzIHRoYW4gcHJldmlvdXMgdmFsdWUNCg0KDQoNCg0KPiArCVJYRV9N
SU5fTVdfSU5ERVgJCT0gKERFRkFVTFRfTUFYX1ZBTFVFID4+IDEpICsgMSwNCj4gKwlSWEVfTUFY
X01XX0lOREVYCQk9IERFRkFVTFRfTUFYX1ZBTFVFLA0KPiAgIAlSWEVfTUFYX01XCQkJPSAweDAw
MDAxMDAwLA0KPiAgIA0KPiAgIAlSWEVfTUFYX1BLVF9QRVJfQUNLCQk9IDY0LA==
