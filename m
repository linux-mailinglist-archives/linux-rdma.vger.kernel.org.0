Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 577644EA632
	for <lists+linux-rdma@lfdr.de>; Tue, 29 Mar 2022 05:56:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231853AbiC2D6D (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 28 Mar 2022 23:58:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229765AbiC2D6C (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 28 Mar 2022 23:58:02 -0400
X-Greylist: delayed 65 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 28 Mar 2022 20:56:20 PDT
Received: from esa12.fujitsucc.c3s2.iphmx.com (esa12.fujitsucc.c3s2.iphmx.com [216.71.156.125])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18E2565B6
        for <linux-rdma@vger.kernel.org>; Mon, 28 Mar 2022 20:56:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1648526180; x=1680062180;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=8V5UvERXTCXW4l4ga8431t6RdItBuBwb9visJ/R8kzQ=;
  b=bapFSX9QmwkKHzN650bRXMqKDe6bpoeutsFM9VfUmSTVuIum2tjvI+Nd
   a/FEQLoSdtHN/lY2TdGPlzHtiT+sixu0szUTeEqmQ+AHWMedLIWxzN90z
   +cFwVtvfR77iGo1/o6wH0aZDyfo78trMPZJ5eBKVjlm2AiQqytxM8i8yd
   oTxSDFrKz/n4QwbF4bDD7uYK0TkYLpIPTjUlUTzBNCyRmUeUeHQuIP9Hl
   uJ2PBRMK9sgfNu8J/7TbwiTpLTI9xI6t5sso2W17iifMCRLNukGmmjx28
   LRQaTGVmoeGLzQdC2Z2b/fXPeDSEjkCY0HXZzGrcq5Bqn5QZvZsvR8fDt
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10300"; a="52892182"
X-IronPort-AV: E=Sophos;i="5.90,219,1643641200"; 
   d="scan'208";a="52892182"
Received: from mail-tycjpn01lp2168.outbound.protection.outlook.com (HELO JPN01-TYC-obe.outbound.protection.outlook.com) ([104.47.23.168])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Mar 2022 12:55:11 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bZzPJCmQFMdwR2EOsWSIlj/7X+64QRHQ7hFC7mJRHw3M4MXF8ivp8bLskhp2IoiWnp3HMzkzmkYRFGJ01jh8AX8ZYoa/e32RU6mb8Ncyu7TdJ8ig8SUG1FYJ3M6g8ybu2dMcbUrsSExJ4JbhaRqgTfqivcsLS3VJrZc1/7kW728PWWs/l2XatRozq/hpulBzXRo1FpZorbCQsvyC23mZl6W7jZN6hPIwuiPj/ff2IBiIDgRoA8lfpk6ZvQ6t3Im2CEAXuxFag0BOCaKAZRDQhr9sgxSLwUg2BX9VVZkjMO/r8gNaFxrKN6J/urBui8UyZXvb0PMgnA+OfSaTyFyQWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8V5UvERXTCXW4l4ga8431t6RdItBuBwb9visJ/R8kzQ=;
 b=UU79tNilGWV/h8l4yXVnl/YYXJjhXg+90hSCLa+9XsiNMfa6mmAsWy516CqgnoN4cuU5PuoVSVXXuRcPomLtn8gm7hRJE0/xgXN22KpGn8XvANI3wyD4jWv1ffoif8bNU56fadbwYeJAeqGoeVjnPbczR37kkz0RMl94RKySGKrarzLAmGt3MBSD+gRlsx82kr32uhrooej6II7FenAwHVE12HC99D9EaWNnxsFrshl5sPIAyJvFstUmB9tSPbni5o4wIhq3RGrDtYtlt/gPSxjHNPUcsG6LwUX41X6O2Bmc+iWkW3jrrmtlujSf0hYDLl4czguHNqj5V9p2d2iRyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8V5UvERXTCXW4l4ga8431t6RdItBuBwb9visJ/R8kzQ=;
 b=n+Tivf4L6gXT4Axb9rCkYz+jP3dtdrzbKH0hsw0rBj8HQbyhSwt1AhuppPbVjzzQ6a+/CzrFEC4AsfvTOv7yqhInvukxWXRryjrmnEJF97Q0af+Bx03J3KGJNjobTInNDMTuQIu7+/5wShn7sOJgTRt7B7iFd4y7tQB+/PnS7zk=
Received: from OS0PR01MB6371.jpnprd01.prod.outlook.com (2603:1096:604:104::9)
 by OSAPR01MB1746.jpnprd01.prod.outlook.com (2603:1096:603:2f::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.19; Tue, 29 Mar
 2022 03:55:08 +0000
Received: from OS0PR01MB6371.jpnprd01.prod.outlook.com
 ([fe80::535:f301:94fd:62da]) by OS0PR01MB6371.jpnprd01.prod.outlook.com
 ([fe80::535:f301:94fd:62da%8]) with mapi id 15.20.5102.023; Tue, 29 Mar 2022
 03:55:07 +0000
From:   "yangx.jy@fujitsu.com" <yangx.jy@fujitsu.com>
To:     Leon Romanovsky <leonro@nvidia.com>,
        "yanjun.zhu@linux.dev" <yanjun.zhu@linux.dev>,
        "rpearsonhpe@gmail.com" <rpearsonhpe@gmail.com>
CC:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "jgg@nvidia.com" <jgg@nvidia.com>
Subject: Re: [PATCH v2] RDMA/rxe: Generate a completion on error after getting
 a wqe
Thread-Topic: [PATCH v2] RDMA/rxe: Generate a completion on error after
 getting a wqe
Thread-Index: AQHYQrb/aNPk9Q3LRkGYexQuVozBMazVIwSAgACZGoA=
Date:   Tue, 29 Mar 2022 03:55:07 +0000
Message-ID: <ce13b0dc-6e1e-28a1-75f3-dafaa044c230@fujitsu.com>
References: <20220328151748.304551-1-yangx.jy@fujitsu.com>
 <YkICq+3JmsTSrELB@unreal>
In-Reply-To: <YkICq+3JmsTSrELB@unreal>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e6745866-351d-464f-1a7c-08da1137ea69
x-ms-traffictypediagnostic: OSAPR01MB1746:EE_
x-microsoft-antispam-prvs: <OSAPR01MB17462F0F7318E99A17A83AF8831E9@OSAPR01MB1746.jpnprd01.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ZQg1MMqY1gg+uckE7ZiUGQ3obk5oyQjWK083jw5xqyxK1foOU4UW6HikXxWN/j03p4vlx837Gu/mQO5N72aUca9PlfNoUq6Vm0vFP8N6q9vGlnNEVRp78oovcjEbpObzlbzIrZtj0IFxd4ksPaiO/fFSQ0L2xKkQmh7u9ipEefZZ2Pvrgqy0mLwUTDgTK6lIThu59niqVbVmAPZNEoxOAJmtzY2czbEcbkNP0A6VRIENeYxLFTYW2+F7NFGXbpsWlHQILckidGlulwXLTz0Ab405qCf417BnCDgn4Tb0/oU3aGer/P/oPnTNk1YiiZQGCZQZjBTLU6FWn6quNWlq8SuikJyPI4dGS+L3cyJSktP287e0nUocye45Tfus/wv47MpbzhR71UBAI1HrzwRG3/7qy7WoOC8/qhfCdsKVS/xbwMm61QXO7yFhQpZjn+HKcgI1l7AcitFVOgq90rqRtE8rvYufzxlWvvNNWuBQsj/KqkOGOOgUjAXAJuOivGKkCau/27j98xNZbqWZzcPXwAj9q8Y31uSeK6LQPVgcT5CwtX4v2xF+qFs0ho5ZQVEhjS3dZ89KFpiJ2bispTBkJ4oaV7dgdzyY8GvO4KCASpC5S/Xvw+nRgxf+mPJekREAyZ8CXB+5dL8hKAwIm4dQ47jhMjGXnrQo+J75TRROeeULaMipq6gHI0uAu1/bQVQ7I4oBLsr6zIczS/ozgFWOpJ4W31o2aSTUegI4eMU6B/0ND8mH761ppBEbZhPVB5MW
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB6371.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(66556008)(83380400001)(64756008)(8676002)(66446008)(36756003)(6486002)(53546011)(316002)(4326008)(66476007)(2906002)(85182001)(31696002)(31686004)(91956017)(66946007)(76116006)(86362001)(71200400001)(122000001)(6506007)(5660300002)(38100700002)(8936002)(38070700005)(508600001)(82960400001)(6512007)(110136005)(2616005)(26005)(186003)(54906003)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MjV6RTZkWEpmaTZ6eExNNHlFa2Z6cUUydXVRdGVyQUR2YlpUUGFBWG40ZXpN?=
 =?utf-8?B?OU1tVlQraExlYmRkWTIxOFVoZVBYYkpHcHpMWm1Ud05HanliR2NMejFMUHI5?=
 =?utf-8?B?dEN0TVFwWlRTc3dmYmFFMXJKSXRlQiszWFNvVWduTzFYdEhHZEJ0MHRYNDNB?=
 =?utf-8?B?a0d1OTlHUjZwZjI0ck1KVDdhWEhkUnozSGk2UW5DYkU1UWMzTTFxQVRTYkF0?=
 =?utf-8?B?MTR0SVBGckMrOW5TRGV3d2V4RGdFMVJJTWtyY2VnVDhnY3FZR3dBMkk2L1BW?=
 =?utf-8?B?WVBLZHo4dGJnbVJ5aVFTeW1oSUgrYTVJV0tqWWpiL0VEb2dUTHlTWkYxc0dJ?=
 =?utf-8?B?N3BKRWVOaitsMWVETFFINm9nRDRpVm5ROWFSc3hrc1ZQUW1LeGpoS0ZkYkVW?=
 =?utf-8?B?Y3lVUUYxb3Q5Y0xNL3J5M1R1SmcxU3dETGppZ1ZUMFhGWUhGTzRDdWZnOGVU?=
 =?utf-8?B?cVFucGgzbXhsU2pYT2pUcWx6TGhkZnNlbXJqMjBBbzdNc3liVFNBN3ltaTgx?=
 =?utf-8?B?YkVGVzI1K2l3RkYydmFyWlhPY1gwbGZXbHByYzF3SllJV2dhNDF1aFFKaFY4?=
 =?utf-8?B?OThJRWw5ajNmNnZSb3ZVQjhqcWttVmp1Nkh5K2RoWXRpRmZ6M2REejd1UzlK?=
 =?utf-8?B?SzNIYisyNVM2dnBsK3NwcGV6WWV6eERSRlJKRi95K29iV1p5c2wzUUJqZjZv?=
 =?utf-8?B?WWxpZ3EvM0NWSDZaRmpCTU8zVHJicVU4ZnlCWFZickFGR253SFc5bnBSclRv?=
 =?utf-8?B?ZUdWZzJJWjFYQk1qRk04N3p6c0F1cFY5MTFZSExkZ0tJUEpqbFJVZWx2MkVS?=
 =?utf-8?B?V3BNNlhqM2Ftc2tocktaWDJpa1JYNGRISU9DWldyY1NPYlp4M21EYWNPck4r?=
 =?utf-8?B?clBlNmtQMExJY3ZkRGQ3QWNVQjRGMjhwekV5dmtMRjJPOTFpOFNpNldmQnFS?=
 =?utf-8?B?eXNOVTRHT1pQQ2hRRkk0aHk5MVdQZFJUdlRPaU4rQi9hNUdiWXFrejhQNEFX?=
 =?utf-8?B?TGhvL3hXb3dYc0dyekhYL0lOdHl4cDhCc0hReVAwcGxKYk9Ga0tkNjRCR3pF?=
 =?utf-8?B?Rko4UnY1K0ZpdVVtQ3hsdWZEaDdaWnROeFZRQ2FKemdMdHJ3ZU15NVJZR2pD?=
 =?utf-8?B?dTNWdkRUdlR5Mjc4YUFucXhWQklieldrUDZHQ0R1WjJBcm10UUp3OHhYQTlv?=
 =?utf-8?B?R2VjbWwyTE95eVRuN0N6ZFI3UHRSaWxLbWhXTkxxZDRuOER0UUt1N1RtYUlG?=
 =?utf-8?B?dHdVTXFWL1VDYnNnQllhck5qcVQ4ZER5T29kTlFucjNuWlYzdCsrRExVcllV?=
 =?utf-8?B?Y01pMHVqbTlrQmYvTGFDemkzM0N3NkxLL1poK0s3c05WRXZGY1NSR1kwNzF4?=
 =?utf-8?B?QUlSYjNCTFRuMUFGRThZT0hRSGhvZU8zNTZnRnFZQ056a3VVK095UThES24v?=
 =?utf-8?B?a3RvdVZWRE1sZi9iSXJ1elJvOWZ5dDU5cERCQlk4akI4K1ExVkVGeWZURzN5?=
 =?utf-8?B?MmcrcVdSRlphdE1hbWxuSnNwTmliZXdqR3NPeUVndHBPWUhiaUNXRVVnMXFs?=
 =?utf-8?B?NFNKQ21OQWE3NUpjbWlVVDN4OHFWYXcyOWsxZVdQOWYybTRmME1mNWJDSXov?=
 =?utf-8?B?bVBhSHBkRXZOVURBalM4NjFWRUswN2pFcHp5UURSMHN1dHk0R3g4dkE3VEFh?=
 =?utf-8?B?cjZlWU9rK1lCcnJjbjlUWis3WGFBeVBYUVFZT3JxMGl1Mm1kYktlZjZoRDZH?=
 =?utf-8?B?QytFbHlBd3J3UEJIWTNwUjVsYXdBVHllc1RodUV2WkRQUFQ2M0FkNDh5SnlD?=
 =?utf-8?B?TVRwWjczQmdiRi9sbXR1czd2QU8vVnJIbzZaelZONDY5Q0NKa0p6RlY4VVlp?=
 =?utf-8?B?NTY5endhOHJuaUFiZm85VG5QU2JISkZZd013M1pBb2xzNW1yZWpURWpZbFNl?=
 =?utf-8?B?NnMwcjF5Uk1lSVNrU0FTNDlKR05oN1NRTU1maXZUR2JsUmRMTGFaVHFBZlBU?=
 =?utf-8?B?RWtRTkJ4NGR5dWpTL05HTStETktuTFdsNG9MVVFSMnZaVFBvZkxJYVZaTzlw?=
 =?utf-8?B?NldtQmNlUGIvaGxQYkMwYWFGT1Z5bDBiS2NVck9leHVqc0pJcS81cDJkQzh2?=
 =?utf-8?B?eWVybTIwTkRyLzJ6VzhOY1M4VG8zQ0QrWW95NGppUHpFNE5tVGV5Ym9mWUZW?=
 =?utf-8?B?MTdEckxUSmZMN3JKS2lYL2ErdE8vVTZ2cXFvTGZmSmFldVI3YUF4c0ZoOWZL?=
 =?utf-8?B?enpkSmt3Vk9ueldGMFN6a1dLaWJpSEtFYy9ka3hLZjVEN3FnNXYwdGZhSTM1?=
 =?utf-8?B?bWwzWTJJNThqeWEvb09pNTVaT3RzZGFjanhuclZNLzJoVFY2NnRWYkg3S2JB?=
 =?utf-8?Q?irSTT7kKlC3aA600=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <15689CBC5A3FF44DB15CD54891257931@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB6371.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e6745866-351d-464f-1a7c-08da1137ea69
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Mar 2022 03:55:07.8713
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dLuY2fatgmfCKn9UyR5/kGrs3iWXzisWnCgma1t5McLxd8szTMWCbvlm0pA+5eM66JAwuf+tNMfi6moEHTNYrg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSAPR01MB1746
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

T24gMjAyMi8zLzI5IDI6NDcsIExlb24gUm9tYW5vdnNreSB3cm90ZToNCj4gSSBzZWUgdGhhdCB5
b3UgcHV0IHNhbWUgd3FlLT5zdGF0dXMgZm9yIGFsbCBlcnJvciBwYXRocy4NCj4gSWYgd2UgYXNz
dW1lIHRoYXQgc2FtZSBzdGF0dXMgbmVlZHMgdG8gYmUgZm9yIGFsbCBlcnJvcnMsIHlvdSB3aWxs
IGJldHRlcg0KPiBwdXQgdGhpcyBsaW5lIHVuZGVyIGVyciBsYWJlbC4NCj4NCj4gZGlmZiAtLWdp
dCBhL2RyaXZlcnMvaW5maW5pYmFuZC9zdy9yeGUvcnhlX3JlcS5jIGIvZHJpdmVycy9pbmZpbmli
YW5kL3N3L3J4ZS9yeGVfcmVxLmMNCj4gaW5kZXggNWViODkwNTJkZDY2Li4wMDNhOWIxMDllZmYg
MTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvaW5maW5pYmFuZC9zdy9yeGUvcnhlX3JlcS5jDQo+ICsr
KyBiL2RyaXZlcnMvaW5maW5pYmFuZC9zdy9yeGUvcnhlX3JlcS5jDQo+IEBAIC03NTIsNiArNzUy
LDcgQEAgaW50IHJ4ZV9yZXF1ZXN0ZXIodm9pZCAqYXJnKQ0KPiAgICAgICAgICBnb3RvIG5leHRf
d3FlOw0KPg0KPiAgIGVycjoNCj4gKyAgICAgICB3cWUtPnN0YXR1cyA9IElCX1dDX0xPQ19RUF9P
UF9FUlI7DQo+ICAgICAgICAgIHdxZS0+c3RhdGUgPSB3cWVfc3RhdGVfZXJyb3I7DQo+ICAgICAg
ICAgIF9fcnhlX2RvX3Rhc2soJnFwLT5jb21wLnRhc2spOw0KPg0KPg0KPiBCVFcsIEkgZGlkbid0
IHJldmlldyBpZiBzYW1lIGVycm9yIHN0YXR1cyBpcyBhcHBsaWNhYmxlIGZvciBhbGwgcGF0aHMu
DQoNCkhpIExlb24sDQoNCkl0J3Mgbm90IHN1aXRhYmxlIHRvIHNldCB0aGUgc2FtZSBJQl9XQ19M
T0NfUVBfT1BfRVJSIGZvciBhbGwgcGF0aHMgDQpiZWNhdXNlIG90aGVyIGVycm9yIHN0YXR1cyBh
bHNvIHdpbGwgYmUgc2V0IGluIHNvbWUgcGxhY2VzLg0KDQpGb3IgZXhhbXBsZToNCg0KSUJfV0Nf
TE9DX1FQX09QX0VSUiBvciBJQl9XQ19NV19CSU5EX0VSUiB3aWxsIGJlIHNldCBpbiByeGVfZG9f
bG9jYWxfb3BzKCkNCg0KSUJfV0NfTE9DX1BST1RfRVJSIG9yIElCX1dDX0xPQ19RUF9PUF9FUlIg
d2lsbCBiZSBzZXQgYnkgY2hlY2tpbmcgdGhlIA0KcmV0dXJuIHZhbHVlIG9mIGZpbmlzaF9wYWNr
ZXQoKQ0KDQoNCkhpIExlb24sIEJvYiwgWWFuanVuDQoNCkhvdyBjYW4gSSBrbm93IGlmIElCX1dD
X0xPQ19RUF9PUF9FUlIgaXMgc3VpdGFibGUgZm9yIGFsbCBjaGFuZ2VzIG9uIG15IA0KcGF0Y2g/
DQoNCkluIG90aGVyIHdvcmRzLMKgIGhvdyBjYW4gSSBrbm93IHdoaWNoIGVycm9yIHN0YXR1cyBz
aG91bGQgYmUgdXNlZCBpbiANCndoaWNoIGNhc2U/DQoNCg0KQmVzdCBSZWdhcmRzLA0KDQpYaWFv
IFlhbmcNCg0KPg0KPiBUaGFua3M=
