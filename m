Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 774CD56881A
	for <lists+linux-rdma@lfdr.de>; Wed,  6 Jul 2022 14:15:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232179AbiGFMPj (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 6 Jul 2022 08:15:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231906AbiGFMPi (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 6 Jul 2022 08:15:38 -0400
X-Greylist: delayed 64 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 06 Jul 2022 05:15:37 PDT
Received: from esa11.fujitsucc.c3s2.iphmx.com (esa11.fujitsucc.c3s2.iphmx.com [216.71.156.121])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8593CB8C
        for <linux-rdma@vger.kernel.org>; Wed,  6 Jul 2022 05:15:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1657109737; x=1688645737;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=kNSFdudHXRARnSIMRYw1TIRZXbXJv/ehlaltv/sCmTQ=;
  b=mmr7b84lKESKIlkk06KsDogNOsAPyZkYOyXbf4PDE1WVNqK63hQU2EkD
   KlHOJ+N32OgFZSAFswT69cOPbNPf7wqlIe5vIxgjdZ4i+g3kb8d/uDxYD
   IDdWsxfEiP0TAmBdjmdiJ3b02RWX+ESlhWe3A+4k/+uTvUmeGEioFJ0Fu
   s6iYCUFCSnQV/PKmP27lGGD7ZRkCxVz9gOnY5DpfJjVOgf5VENDtSmh8X
   uJHqGATVlfy4vs2ZqyomxEn3eF6+//l/4dUYnxPfj+Jgy8pIQIJFaKKAh
   SyIpIWR7tyV3X1MUFMT/Ma6nzH/dt+OVqtpJL+qOTzVsNbe2ifJVER9Oi
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10399"; a="60131251"
X-IronPort-AV: E=Sophos;i="5.92,249,1650898800"; 
   d="scan'208";a="60131251"
Received: from mail-os0jpn01lp2113.outbound.protection.outlook.com (HELO JPN01-OS0-obe.outbound.protection.outlook.com) ([104.47.23.113])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jul 2022 21:14:30 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ItPCoALP8To5teif/JcSySEh0L2YDlEfOxS9HXRO+FX2KJaMyGh7oG+FW4MBhPA21RJ6kk3wkZUlIPPeD8eNtgxOeoUA4hVyadHs4UHMyPu+lqqnpssTRdQez0+TQORW7pSq39+6pH3ZxdRVFCqOWz/UWLvQoZ5vWGtl4IVngJ9QN9wscbR8KTAqbZMqgB+DuSyocgSs8EGHx1/rqb2PP1sNQQKY2mWDtorg+RDh5ItIBJ40hDXhJAnaH1GYK+oI6eF+HNO4R+2oGKieemJXn79fUco5K702tZ5bPVcp0p+xJOBeyFeE2AE85VD+ovpwSK1DPk2eaTFFnZE/8AT0KA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kNSFdudHXRARnSIMRYw1TIRZXbXJv/ehlaltv/sCmTQ=;
 b=Xg9hPI9wdA3+JBtx9RbMWUqIDu+tr+vCUTF2lgKhPQcnHJz7JfyuTiLlL146fEvoX3TEPeubRygAMv0qe+B1Sth0WmOx65yrtGifdqmId3f7zSAgdzwskvWaZnCgBe6ZeoQB6RsI9Y8g7MaepYyLX8+HbOcwMxymBy6TLI1jAcjPYTia3L9P4jwlTBgImUcdtn+TOeOxVg9r3jfabTrs4NYGwZTSghy9KtcNif5HC/xFAPOUGGn1FmruJyNkTWHDbumj9qTATzJsNpwk7I5fdzWZhPCCvvsQOxcUO/UmPxO9MGDy4Y/m+CQPDTaDhruj7bOryjhLmOxPR1/D76elRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kNSFdudHXRARnSIMRYw1TIRZXbXJv/ehlaltv/sCmTQ=;
 b=kv020OXIlOeaqaC3WkBBFH4s39kXhN72wuiRKcuF0AhDgv7fX6ZySc+zKzXwHJuzr9gVSlEH8p804bZ8GifM1ejrh1YMMqIa3GdKT0xSTGjsWnJrpVlWgDdYbWi2nqg2h6qX4A89LcWKuOEF8873r1Bh7JB5F2zj52J1RAEuuVA=
Received: from OS3PR01MB9499.jpnprd01.prod.outlook.com (2603:1096:604:1c8::5)
 by OSAPR01MB3330.jpnprd01.prod.outlook.com (2603:1096:604:5d::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.14; Wed, 6 Jul
 2022 12:14:25 +0000
Received: from OS3PR01MB9499.jpnprd01.prod.outlook.com
 ([fe80::d8d2:d66f:2f3:846c]) by OS3PR01MB9499.jpnprd01.prod.outlook.com
 ([fe80::d8d2:d66f:2f3:846c%7]) with mapi id 15.20.5395.021; Wed, 6 Jul 2022
 12:14:25 +0000
From:   "yangx.jy@fujitsu.com" <yangx.jy@fujitsu.com>
To:     "Pearson, Robert B" <robert.pearson2@hpe.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
CC:     "leon@kernel.org" <leon@kernel.org>, "jgg@ziepe.ca" <jgg@ziepe.ca>,
        "rpearsonhpe@gmail.com" <rpearsonhpe@gmail.com>,
        "zyjzyj2000@gmail.com" <zyjzyj2000@gmail.com>
Subject: Re: [PATCH 2/2] RDMA/rxe: Rename rxe_atomic_reply to atomic_reply
Thread-Topic: [PATCH 2/2] RDMA/rxe: Rename rxe_atomic_reply to atomic_reply
Thread-Index: AQHYkGTUtXzpNGllcEOLci7mMaROqK1w9fSAgABNHgA=
Date:   Wed, 6 Jul 2022 12:14:25 +0000
Message-ID: <1e81e77d-f5d4-3f23-49fc-9e147dd68d46@fujitsu.com>
References: <20220705114603.6768-1-yangx.jy@fujitsu.com>
 <20220705114603.6768-2-yangx.jy@fujitsu.com>
 <MW4PR84MB23075C8A422D7C87C5F0C4B7BC809@MW4PR84MB2307.NAMPRD84.PROD.OUTLOOK.COM>
In-Reply-To: <MW4PR84MB23075C8A422D7C87C5F0C4B7BC809@MW4PR84MB2307.NAMPRD84.PROD.OUTLOOK.COM>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 12a18a85-6f2f-422c-f2cd-08da5f491153
x-ms-traffictypediagnostic: OSAPR01MB3330:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: JhMhpCJGYhIm9NatgiKRx4Fw+iWOn6mo/GhkkL8GHQw+OnDygvIjTEwn8de+32htnVkNUQFEtp5y+99Zrd/T5aA9QtHDXGbnpXs+EOT3jV+U8ClZHhyl8262q0Jzi6ewEcQbtMkva4xxGhJqgFUWMAlnMk+Ddo3imkNN1QlDkwjFzEx+kLSCPOunUZ2GXs/FflE/L/QqyFrDfLUZElCn7eukIcG9vCnh+RFby5wcbCsm0mL1g6lM45Ms834uqTpmY8abTMekdnSoLReK2uCWHaoA8aY9MH9ZTQR5fmCP2mUVT++XWxhu95lk2bfwpMvOfctJCCeQlQaG+t1O/op8rCcg2kN8oLbh9WYaDAwlcDxyqaaRXQaxkL3hVfPiXOlXu7DHfmgIpZ/r/EIUBpQkIDfabb6X/9iwtxohC9q9ynPEsqB9naHX9U/Tiv09JLkJ9/C4LPplQB6FAihxGvbOP4zPqVNHRAs1KQGYTi/4rYYjyZyv6/5p/mOjTqoULhKjYmapttAIXSv0RuwLP5di07ye7pygvqALpD9xx1je4C92Guodiahjy+gS8Kj2S6FxV8CUS7yMbx8LRi+NdM9ekJoRrkATKHx70fiQU8HvgJhy8wwbYO4BQMiTIK0y/KV3itwLNaQ/m+Sob8e60+0zpqYqnVifkbbD+i0RKCydh8V3gc7J1Fwry3i9llQ2isYduKbLnfl0fDg6IfYWpwUSA8R/bFmjR2lfpN4sQ0G2AIAQ1znRS2K2zzRcQGj4KpdWZIhtj5ZeHABSu9RDOkvbpN70Tey/YFeTKYO2r5xhc3dxLwhwunlrqDKMw5P0h1UzTPLaZFJKrl2uz9oYbX61Ziz/v6cHN3MPKrqLH0xqrZw=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS3PR01MB9499.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(346002)(376002)(366004)(396003)(39860400002)(136003)(38070700005)(64756008)(66446008)(4326008)(6512007)(8936002)(26005)(85182001)(6506007)(53546011)(31696002)(66556008)(31686004)(186003)(66946007)(8676002)(76116006)(478600001)(66476007)(122000001)(110136005)(2906002)(5660300002)(316002)(83380400001)(86362001)(82960400001)(2616005)(6486002)(41300700001)(91956017)(36756003)(38100700002)(54906003)(71200400001)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NkQ1dUdqSUJ2a2JyUjlESFVGVWZsdDRORmhxOHk5dW0rdGNuZVh2VytiWmc3?=
 =?utf-8?B?T3pyMjI5UnNydCtwV0tVUlJ3RHdlK01CZ2J2SXFRckJSMUxhQTlreWRWREd6?=
 =?utf-8?B?UkExajV2ZFdJb3ZpSjVjQU1iRlBSWkZkMzgyZVJ0aGlsMFlCQXFnTy9mdFJq?=
 =?utf-8?B?b2pqdjdOMVJnOExPb29Ga2N5cWVTNUowOCtHYmxuaGN1UWx0aFg1dnZwZ1Ex?=
 =?utf-8?B?aHQybk9nQkovVjJzN3k0SGxqK0Y4YVAwNVNEWnlRTFlqUWY5djRIYW5zS2dz?=
 =?utf-8?B?NmV0RmxaTSthaTNYN0NMbnZkZ1owVEtzM1gvUjdWcVF5dEoxVWNrRFBhWXkw?=
 =?utf-8?B?Ti9xa2dPMEM4WEkvWVVDK2l1YmF1Ly9XUklMTXlnTlJnTjlNWjYxRUZaMUFY?=
 =?utf-8?B?TzQ2UkNrVGpaUjhocDQ0VWVnQ3U3SmEwTjk2WjBZTGw4UFJsTllvU0RaK0hI?=
 =?utf-8?B?aDJkWlU2dGlkc0VJdFdIR3FxTlFyQWxEdkpqWFNyTC9LcW4yaEEzYVF2NGlG?=
 =?utf-8?B?dTBvQXNZNG9aM1VhcVZrK0hrbmFDdzNzUDVvQVJaelhnK05SeEdBaGlzd0to?=
 =?utf-8?B?MjJWclFVSVppZlNHNUFtbGh2b0wxSlArRWRaTTVBKzdEbmRhbG9DR3dyWHd5?=
 =?utf-8?B?NlJ3M1JXKzl3V3BuNStrbk5rTmc4T01IOHNNRDU4VmEyY2FvbW12YUpMOSta?=
 =?utf-8?B?NVdadGpBNnlyVFFjMXBoWlBVbnNuQkl5a0p6bFc1cFNWVVVzdkdySHlWbjlD?=
 =?utf-8?B?RDNwQ29FZEZEUG4zRlhZUm1saXlsMFduTWJPOHBmM2ZoV1pSaW1JMkl0UlBF?=
 =?utf-8?B?WVBTTDNiN2pUQW9MWmtuNXdyUkJkSEpxRjNja0VaN3pKWm9JYkg4elVFbVpL?=
 =?utf-8?B?STRHeStzbHpuUWJrd1dYQ1BnN3V3Y2VyRzNwdEpzV1NLMXZVOWEweWZacFpY?=
 =?utf-8?B?NmJndFh1bGRCSVg5dDhKczlyTlpaS0dMM1lDN1B1UHQ5eE5MdzNINHNIVHho?=
 =?utf-8?B?Ly9Ed0VsWloydEdBN3lyZzhKQmFtOVFZMTFMNDdpS2lUb3RWcnpvMzhDc2hL?=
 =?utf-8?B?aDMwMFA1Q0N3a2FzeFFteDRIN01LdjN3ODUzamhSSG05dUpWWkRrRU9xWHBa?=
 =?utf-8?B?RlEvQXNvcDROQW1xWitpOCtLRWxmRWdUdVZSdGJYa2crbkI0ZXV3ZWdPUlpE?=
 =?utf-8?B?MVlyZm5JUmlLUGtoQmFydjVNQkVuVENrTDNsMlRHTzQ2L0Z5T0tIeXYvZDBR?=
 =?utf-8?B?VkdoRXJVMllNUitSdW4yUXlSd2dPWEVKR2xGRWhoOHJ4cDd2RVRoU0V3V1kz?=
 =?utf-8?B?L0RtOGFlek1FdkxxMmZjZ3BrT2VSb1F5eTZacTJzUjd4aGpMaktHUklsZ04r?=
 =?utf-8?B?VjBuVUw5dUxlcCtjZWExOExYSWNMN0cwR29ra2dCQU9sWGhQTVVXYUo0RUFC?=
 =?utf-8?B?RVVocEVaeVZaVHZIdUsvM1BMamg4ZUx6OGZYNEQwSzVnM3NJUm9ERnc1b3NQ?=
 =?utf-8?B?Rm4wblIxcCtuNUpuKzdkUzQwYTJkdEE4MjNidDNneUNOVWxya0NsdVY0Y2px?=
 =?utf-8?B?N1YzQ0hOWnVGRmdId0F5NWg3Sm96RHVRdEF5U2trUk5JT3h5SXhZMXd3Ukxw?=
 =?utf-8?B?bnA0UVNMZmpZY2JVNFkwdW5TaWhQaGxLQ1RKQS9rS2I1bVZqMlNRd2J1bnJB?=
 =?utf-8?B?SGV6Nmxzc0tvZ21BM1gvSGhDczBIb1dGYmpxUWRvRFBOdk5lTzdIcDFuZlBV?=
 =?utf-8?B?OUJXMmpyaDF0cmswTjFnbHgvMEZud2t3NW8vTUdrYjdQamNyaXVkSTBaYmFZ?=
 =?utf-8?B?MU9yQjB1V0pxa2taODNUWGIvUWloMTYyVzNHSEJuSmJ6bS9zYm1lSTVLeG5n?=
 =?utf-8?B?bE5yZFR0MUVDQVBiMGJnZE9JWjRmeXhOVnAxTDAvS0JMbTI5RWsyakE4bUZX?=
 =?utf-8?B?NDVsMFBpaVZJcGRlVWJoYWFqVE1VbHBoVXhNMFpXRlBTajVucFNZSkhvVEVY?=
 =?utf-8?B?SHMxQjArbHR2SW0wOE5rYkdWVm5sdW9qSkk3ZFU0OHIxei9DajYrWS84VCts?=
 =?utf-8?B?QUtIcUN3V0JtTlB4TlVMRGtwUGF3dlVKdGs5YmZKb2ZIcEh6ZGRSNCt1UE9h?=
 =?utf-8?B?M0kwQ1U0WmtMbnE3Q0I4VFFaSEN5ZHRBUlJsaDdiZ01BWWZmd1dLY3dXN3NG?=
 =?utf-8?B?N0E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <5DE82AB59B134747B4C4758EE04D4E1B@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS3PR01MB9499.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 12a18a85-6f2f-422c-f2cd-08da5f491153
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jul 2022 12:14:25.3999
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: a28o67MewwjLiBR8pzaru2pq6ZZvb7vq3nkVhQ4g8ewswTb3ay+5jvvNW0cSLNPS+iAZw+AWNpQMEDYLdRf26g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSAPR01MB3330
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

T24gMjAyMi83LzYgMTU6MzgsIFBlYXJzb24sIFJvYmVydCBCIHdyb3RlOg0KPiBHZW5lcmFsbHkg
b3ZlciB0aW1lIEkgaGF2ZSBiZWVuIGFkZGluZyBhIHJ4ZV8gcHJlZml4IHRvIGFsbCBzZWFyY2hh
YmxlIG5hbWVzIHN0YXRpYyBvciBub24gc3RhdGljLg0KPiBUaGlzIGF2b2lkcyBjb2xsaXNpb25z
IHdpdGggc2ltaWxhciBuYW1lcyBpbiBvdGhlciBkcml2ZXJzIHdpdGggZS5nLiBjdGFncy4gSSBh
Z3JlZSBhIHVuaWZpZWQgbmFtaW5nDQo+IFNjaGVtZSBpcyBnb29kIGJ1dCB3b3VsZCBsaWtlIHRv
IHNlZSBvbmUgd2l0aCBhIGNvbW1vbiBwcmVmaXggZm9yIHN1YnJvdXRpbmUgbmFtZXMuDQpIaSBC
b2IsDQoNCkkgdGhpbmsgaXQncyBoYXJkIHRvIHVzZSB1bmlxdWUgbmFtZSBpbiBhbGwgZHJpdmVy
cy4gSSBzYXcgdGhhdCBhbGwgDQpmdW5jdGlvbnMgY2FsbGVkIGJ5IGRpZmZlcmVudCBxcCBzdGF0
ZXMgZG9uJ3QgdXNlIHRoZSByeGVfIHByZWZpeCBpbiANCnJ4ZV9yZXNwb25kZXJzIHNvIGp1c3Qg
cmVtb3ZlIHRoZSByeGVfIHByZWZpeC4gV2UgY2FuIGRyb3AgdGhlIHBhdGNoIGlmIA0KeW91IGRv
bid0IGFncmVlIHdpdGggdGhpcyBjaGFuZ2UuDQoNCkJlc3QgUmVnYXJkcywNClhpYW8gWWFuZw0K
PiANCj4gQm9iDQo+IA0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBYaWFv
IFlhbmcgPHlhbmd4Lmp5QGZ1aml0c3UuY29tPg0KPiBTZW50OiBUdWVzZGF5LCBKdWx5IDUsIDIw
MjIgNjo0NiBBTQ0KPiBUbzogbGludXgtcmRtYUB2Z2VyLmtlcm5lbC5vcmcNCj4gQ2M6IGxlb25A
a2VybmVsLm9yZzsgamdnQHppZXBlLmNhOyBycGVhcnNvbmhwZUBnbWFpbC5jb207IHp5anp5ajIw
MDBAZ21haWwuY29tOyBYaWFvIFlhbmcgPHlhbmd4Lmp5QGZ1aml0c3UuY29tPg0KPiBTdWJqZWN0
OiBbUEFUQ0ggMi8yXSBSRE1BL3J4ZTogUmVuYW1lIHJ4ZV9hdG9taWNfcmVwbHkgdG8gYXRvbWlj
X3JlcGx5DQo+IA0KPiBJdCdzIGJldHRlciB0byB1c2UgdGhlIHVuaWZpZWQgbmFtaW5nIGZvcm1h
dC4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IFhpYW8gWWFuZyA8eWFuZ3guanlAZnVqaXRzdS5jb20+
DQo+IC0tLQ0KPiAgIGRyaXZlcnMvaW5maW5pYmFuZC9zdy9yeGUvcnhlX3Jlc3AuYyB8IDQgKyst
LQ0KPiAgIDEgZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pDQo+
IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9pbmZpbmliYW5kL3N3L3J4ZS9yeGVfcmVzcC5jIGIv
ZHJpdmVycy9pbmZpbmliYW5kL3N3L3J4ZS9yeGVfcmVzcC5jDQo+IGluZGV4IDU1MzY1ODJiOGZl
NC4uMjY1ZTQ2ZmUwNTBmIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL2luZmluaWJhbmQvc3cvcnhl
L3J4ZV9yZXNwLmMNCj4gKysrIGIvZHJpdmVycy9pbmZpbmliYW5kL3N3L3J4ZS9yeGVfcmVzcC5j
DQo+IEBAIC01OTUsNyArNTk1LDcgQEAgc3RhdGljIHN0cnVjdCByZXNwX3JlcyAqcnhlX3ByZXBh
cmVfcmVzKHN0cnVjdCByeGVfcXAgKnFwLA0KPiAgIC8qIEd1YXJhbnRlZSBhdG9taWNpdHkgb2Yg
YXRvbWljIG9wZXJhdGlvbnMgYXQgdGhlIG1hY2hpbmUgbGV2ZWwuICovICBzdGF0aWMgREVGSU5F
X1NQSU5MT0NLKGF0b21pY19vcHNfbG9jayk7DQo+ICAgDQo+IC1zdGF0aWMgZW51bSByZXNwX3N0
YXRlcyByeGVfYXRvbWljX3JlcGx5KHN0cnVjdCByeGVfcXAgKnFwLA0KPiArc3RhdGljIGVudW0g
cmVzcF9zdGF0ZXMgYXRvbWljX3JlcGx5KHN0cnVjdCByeGVfcXAgKnFwLA0KPiAgIAkJCQkJIHN0
cnVjdCByeGVfcGt0X2luZm8gKnBrdCkNCj4gICB7DQo+ICAgCXU2NCAqdmFkZHI7DQo+IEBAIC0x
MzMzLDcgKzEzMzMsNyBAQCBpbnQgcnhlX3Jlc3BvbmRlcih2b2lkICphcmcpDQo+ICAgCQkJc3Rh
dGUgPSByZWFkX3JlcGx5KHFwLCBwa3QpOw0KPiAgIAkJCWJyZWFrOw0KPiAgIAkJY2FzZSBSRVNQ
U1RfQVRPTUlDX1JFUExZOg0KPiAtCQkJc3RhdGUgPSByeGVfYXRvbWljX3JlcGx5KHFwLCBwa3Qp
Ow0KPiArCQkJc3RhdGUgPSBhdG9taWNfcmVwbHkocXAsIHBrdCk7DQo+ICAgCQkJYnJlYWs7DQo+
ICAgCQljYXNlIFJFU1BTVF9BQ0tOT1dMRURHRToNCj4gICAJCQlzdGF0ZSA9IGFja25vd2xlZGdl
KHFwLCBwa3QpOw0KPiAtLQ0KPiAyLjM0LjENCj4gDQo+IA0KPiA=
