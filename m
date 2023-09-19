Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BF7E7A57DB
	for <lists+linux-rdma@lfdr.de>; Tue, 19 Sep 2023 05:25:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231278AbjISDZP (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 18 Sep 2023 23:25:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231253AbjISDZO (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 18 Sep 2023 23:25:14 -0400
Received: from esa19.fujitsucc.c3s2.iphmx.com (esa19.fujitsucc.c3s2.iphmx.com [216.71.158.62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3657795;
        Mon, 18 Sep 2023 20:25:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1695093908; x=1726629908;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=+cKB+fvLENX7SrWlaDoSDpzmZWzqWJlDHFioZ4sM+yg=;
  b=S3APasDxUDrBC428ctVrMZR5ZAMC+lXmXr21Qxb2xwNmmHVD8oEtb2hF
   KSQWEhFDpBV2cve3wmCyFT07tq0ETLjmuP2QrZgXvM2bzJ48adUxFcs0D
   apP+qKJIfTBKB9ElKgDoPql8E4Dnl0cQJ+xgTqA2VnO1UGRE31jJvSa9n
   Hxh1upoQSzv9YswqIoz7/QQo0YQLf19SD7hpwE6Yt0ljFREQXcEhdWNNo
   naTLBO8QTbzF1k2i6TuFfVK2JSxyb3d2bgzOlO0X4gLjZXyZVx9rqYJXG
   acfSW0haWODSVGeRDPnpdT3YARR2S4tERR26NdZFeCdT9poKJhYTk+tKl
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10837"; a="95199018"
X-IronPort-AV: E=Sophos;i="6.02,158,1688396400"; 
   d="scan'208";a="95199018"
Received: from mail-os0jpn01lp2108.outbound.protection.outlook.com (HELO JPN01-OS0-obe.outbound.protection.outlook.com) ([104.47.23.108])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Sep 2023 12:25:04 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fVjmbx/WAucW0gPla+jdjskn7gUa+U3UI5FDqbzqZ00yWPpi7QP/A0y1O8A2y4Mn85NZrFOhY7vTrkkkb9J3weuO9/aMMGVdsE0//HKOnJuHiMDXXJ49xvjOE3qbqhQXPezxIui8H7qgCxJR85RngYCr5SUOrXw3UyaBVV/Q2fMXsKX1yFSlus0XkZWY8wvQrzE4BP5N75rjP9DZogICbsCIL83IQwEtgXKmofwCsAQtG+fim2Wv3w36uXDkq6J4l65/yyLK8Y4p9tK69NSlBdcmXM6zlTIQHSQAeL7XkmUdZBNwtRhvqro/F/Q9D9+ZOuNz7CN7m//f36ama3YVsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+cKB+fvLENX7SrWlaDoSDpzmZWzqWJlDHFioZ4sM+yg=;
 b=ZB11TxgvxzDQh1D0GFy+cmPIcAdl81gkLmhUzIa1X0WybIQe1lK3EBWucAy6woj6NQdNT2KSKeZdJKZH+tk+jb/y3VZ3Aw7lCar2W1PCVY5ktYrm+CnuQvEgPgvqzVIVzXG4W4jldzSzWXNCjzG8onNRq+/d04nVl2VyV9vaAEg8fcUFd+POOCfy8Xnj88gsg6DZwP/M/m81oWR+jbgHwEsVWRT901E9KFOzgZvp5JHsFwE4B7RwjIiOF+2TFthssfkwikgqcZptn98M4gQ4niwnfhh+qWgLeDJsYphVaS6/KgWjcT5S05SgWotzyBWSo2jzWORLzlknqSraOKknaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from OS7PR01MB11664.jpnprd01.prod.outlook.com (2603:1096:604:247::6)
 by TY1PR01MB10882.jpnprd01.prod.outlook.com (2603:1096:400:323::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.27; Tue, 19 Sep
 2023 03:25:01 +0000
Received: from OS7PR01MB11664.jpnprd01.prod.outlook.com
 ([fe80::1a61:2227:a0de:2c53]) by OS7PR01MB11664.jpnprd01.prod.outlook.com
 ([fe80::1a61:2227:a0de:2c53%4]) with mapi id 15.20.6792.026; Tue, 19 Sep 2023
 03:25:00 +0000
From:   "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>
To:     Zhu Yanjun <zyjzyj2000@gmail.com>
CC:     Leon Romanovsky <leon@kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "jgg@ziepe.ca" <jgg@ziepe.ca>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "rpearsonhpe@gmail.com" <rpearsonhpe@gmail.com>,
        "Daisuke Matsuda (Fujitsu)" <matsuda-daisuke@fujitsu.com>,
        Zhu Yanjun <yanjun.zhu@linux.dev>
Subject: Re: [PATCH for-next v3 2/2] RDMA/rxe: Call rxe_set_mtu after
 rxe_register_device
Thread-Topic: [PATCH for-next v3 2/2] RDMA/rxe: Call rxe_set_mtu after
 rxe_register_device
Thread-Index: AQHZ6dSthw3TTp5QhU2XAaF5adK7jbAghgUAgADO64CAAAPngIAAJTyA
Date:   Tue, 19 Sep 2023 03:25:00 +0000
Message-ID: <0cd9103b-4411-700e-f8d1-94e8735f57e4@fujitsu.com>
References: <20230918020543.473472-1-lizhijian@fujitsu.com>
 <20230918020543.473472-2-lizhijian@fujitsu.com>
 <20230918123710.GD103601@unreal>
 <4dce179f-f808-0a18-7e9e-9877964d67e4@fujitsu.com>
 <CAD=hENfcbgNQxb2N1qXJa0pYkF_AYB2aua0smadwkgHtYXfeAw@mail.gmail.com>
In-Reply-To: <CAD=hENfcbgNQxb2N1qXJa0pYkF_AYB2aua0smadwkgHtYXfeAw@mail.gmail.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS7PR01MB11664:EE_|TY1PR01MB10882:EE_
x-ms-office365-filtering-correlation-id: 63fa87c5-7fc5-4d8a-2dcd-08dbb8c001eb
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: XtlAEtRX7Q8Mqg7m2rjf+ZMhmZBr4poL2gggtA5+9xHNOAjYEdKaPDIq/u8KtQQCEhvhzPFfexQwqmTZ+wvIvBQM1oCw33YZFISM9tRyLoYpkS4QLGYq2qD5tRQAtxNL470VLMK08uZgltj4vzMaBh0q+8BKi5m6SbfrPL1Pm6fLbRiyIYcgPjkveWq8zPQmWJUKHsfIRhf5cjlpdyoQEf5nF29C4SA9wE8diU4IHuJh2dh54bwGokO5RGcWK7PUtZipHMABj5Kg7Du9lBu91sW2IFNsnKeRE2qVsg6Sb5kAgKE4OXtIQ0IkYd3ndejVcQm9q1EjQlZqniWrrsjbBpuoNjvRPDu259UtcSBmnjjNU0/lkPzeOBv7NmSnHfinqEpu2Ejzia3BqYStlNhW8s4N2MxVoW1KOTz6lHonR6v8+DEHYwGAvs+FwWb/IYZgnxTI8wLPeJtDlAzOXMIh5lliPIL1bb1gCwIjuFyJ5yGtBNHrvKepRYW5k+wIYnQTfKdyrFMG0lktr6s56UHPHUP5PRpQqgENpECp1P2rSQ3GAQryBr3Yo9QvLEAzEInBZeRvfLXV422y61C9cHyuCb6XeSbg6wKYgRdQ7q82tCbHcADVoMzBWNt6nAiEz3B9Izp7QxOCPvEZ4J7rV8ULPvy7YJKggIe+W1HCZOx00pHeRR4TA7JL02DX2h0mvixY9jP9e/50g1uyPXyk91DV6g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS7PR01MB11664.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(376002)(346002)(136003)(39860400002)(366004)(1590799021)(451199024)(186009)(1800799009)(6486002)(85182001)(36756003)(6506007)(478600001)(31686004)(71200400001)(31696002)(26005)(86362001)(316002)(83380400001)(2906002)(5660300002)(122000001)(2616005)(82960400001)(1580799018)(91956017)(66946007)(66446008)(54906003)(41300700001)(76116006)(6512007)(53546011)(64756008)(66556008)(66476007)(6916009)(8676002)(4326008)(38070700005)(38100700002)(8936002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZkxkWHE2YmI4Kzd6T0FKaUMrZmVGN1U0cksxZE1ZTzRLYy84NVlRUnFPREJ0?=
 =?utf-8?B?N0tyYS9OQnMrUmlHR04vNW9yQkNBM1cya2x1d1lkOVFEUXozT3h6NEpJZ3Jj?=
 =?utf-8?B?UXpFR3AwbTUralZDd252bHdIeGhwaTcvbytRd3kwbmFKeEJvN29qcSt4RUhB?=
 =?utf-8?B?c3pybU1ZazZtSDBBbDQ1QlpreVFRdEtsdGdEUkZVeWxWTTMrUkY4R0hiSCsy?=
 =?utf-8?B?S1J3bkpGMmk3YjIvd3lBYlY0ck4yMm12cmFUYTZyVFYvU2NiNUVoTHRpNENh?=
 =?utf-8?B?K3JvS3V6dXpQUm9ONnh1Q2g4ZlJLYkRjTjdBajVMR0tMVXFZbUl2TE4vMnUy?=
 =?utf-8?B?cjRhdjZvMDVNT1VIQU5iMEhhaUN2TkcvR1BkbjVtdUwxd0ZQZ2k2MkFWdEJy?=
 =?utf-8?B?VXJrWmFUeVZFblcyallGVllIZVU4Nit3WUJJbzZpY0VsMWZkOVd4V01hVklR?=
 =?utf-8?B?YTVCbWhaSnZyZ2FvV2dRVkJkU0J1RE9xa3JuMUhPN1BkVUZLc3VaNWxSOFR0?=
 =?utf-8?B?ZFNJeWVmVFlQcjByZFJzaGNkaFowa00zMlJyQm03Q0hhUnBPRDVER293aDJ5?=
 =?utf-8?B?SHFVQ1I0TERkQnRQT3U1OHpmdUNxNURvN3c3TWNlWStyMmNiOUVaVEpScCt1?=
 =?utf-8?B?UVZnOFRBZ29kSlh4RVJNS2pvQnFBUm1WVjBiNjFvUGgvTXFpRmRKbTRIdndH?=
 =?utf-8?B?SlhiTCtEbytHdzVKcnl2a3JZK1V0VmlHV0Q3MW5xV0xDMFkxTHFlNVNqRmZO?=
 =?utf-8?B?Qk1pcXQ5azl0aEZjc3BvM2kyT2JRS1N6YTRXTVc2NHQwdy9qRU94YmVHZjlT?=
 =?utf-8?B?YTJDYmdSQUhid2dkYTJVMHZ6c0ZRd3ZTcGdMSzNIMGRia3lYOUpZUk8vVGw1?=
 =?utf-8?B?WW5IS01hUytmUGtlME9haE5SVXMxcmRGVGU5Wk9qdjRRZm5mOHY3dmtDVlZL?=
 =?utf-8?B?S254TjZZeVNualpvaXU2Tk0rMWRKcTZXSnFIVkNuWEQxb2plQ0l2K2M5YUpN?=
 =?utf-8?B?cDh4ZkNXcmJjVGlHUk95aGl2ZHVha0FGUzdxZ0pVa0djV29HUDkzejI2b0Ro?=
 =?utf-8?B?YTFpcjEvQ3BFVU0vN0p5Q3VBNHV3QUlMRlZTOTdSSUV2WUVIVkJXRk5oNi9V?=
 =?utf-8?B?eFljN1h1UGloQ0pud1hJYSt1R0JhTjJ2RktlSllUTnVzT0lFa3Awa3VwQ0My?=
 =?utf-8?B?NWhPQm9xU0xDdjg4ZmUwbW81Z29vMW84L09BWk5aRTAxN3pTaHlzc3d6RU1n?=
 =?utf-8?B?Qi9RWjZrL0RhaFFMdmN6U3RFTDZBd0wzK2VzNnhnOVptNlpuV3NRZmhXbFgz?=
 =?utf-8?B?c2VkVFh3RFdwdG9EaXZPcTRVcnhycW8rS01zNVR6SDh1bzNRTlpXMjcxbUs3?=
 =?utf-8?B?REkxVG5UbzhkTFhKa3ltOTAxRlF2RzlxQnJTZzRaOHhnbTFTOHI4RCsyczlL?=
 =?utf-8?B?OHc4VnFRMTFyekF1U0JDS3JnaTRyK1RKZnJkTnlkWGtOYW1YSXJnYm5jdExG?=
 =?utf-8?B?WGtoSWF4OW9sbE5YYVVyWFVCVllZdG9VQkJLWWRxbWpSb21qVUV5Nk9ZeDhV?=
 =?utf-8?B?QldxQmxlUHFBVDE0ZG9LNWs3RXFxSUVxaGhzMDd1MEpTWmYxQkc2VjNWSjR5?=
 =?utf-8?B?eWtlallvWTRpbzJac3hRTjFnWkYvR0VSejNTVS9UbkVwY2xaK2Nodkx6U0Zk?=
 =?utf-8?B?aWhnaEE5clkrRWRYQ0xqWVhmSHBxMmxpSnB0dU8vZzBFK3o1QjdkamFrdEgr?=
 =?utf-8?B?N1QxRFYvL1A1WmtiQWkzL29uT2xZbVYvN2hxd2I4VXkrazgwVWhzMUhBS0Z3?=
 =?utf-8?B?Wm5qZlFmSXNUNFl4UWdYbk9XcHQzOFI2cGlEcklJSjh6encybit0cFZ6dDZI?=
 =?utf-8?B?Y3YwZldrdmk3MG80aDIvYjdPTTBLWlRDTnlPYUZsckQrblZYR3V6ZFJLNmZu?=
 =?utf-8?B?cDV0Q2RsalNzaENIbVZ6QTZ2czhRYVFFdG5EOHNEUTUxeW0zcExQWXNqUTk0?=
 =?utf-8?B?L3poemxDbVNxQ0dnM1A1SXJxK04vUzBGSXE5Y1pPTjRkSEhIMDV1WXBDd3Rz?=
 =?utf-8?B?aGRpeVBCbUFUMDNYWTBvNHdEU1VPTng0aisyRjF6YVFQcXpxQ2RZQlVnVE44?=
 =?utf-8?B?Q3NCbDAvaXZhUE5LajFCYWNUV2pQR1J6VDdZQ0dpVGJnTnlIV0hLYmNRalI1?=
 =?utf-8?B?SVE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D505854D3B62204DA1739BCE92DD5D9E@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: GQfnvKHZM+KC/UQoZxhnKvBJXTyEfJx4YM+trqPCXGZwoPyF9cutw1/df/xnFDAiVHUH/OcR1oMefEZYtkWBHr5mTNcKXlsmP5OVpFlhLXUPA3dVJ3kXdOAUv1fb6Wcx6xg66xnLD1+c4iFOuQ4vjxcREDZqyzoHM/JQmmm+F45xP/nYS1UYQrfSHSYyxdt08XUDfK/n+v3IJrLTLdG2qUxFGslRo1mRCQtn+kcFFJLSWTZz7CReOcsxp9SG8ayXfmWLpmtSelMTMGCWb/BEqBWE+CsmHtZsmE+ggLtWsD+9fRiPKCbCrhdaVmo7X945T5T9kfuRbhZxt9ikqAp6bnHvzdgUeS+f8f/2icrTDzAsxqAsbFt/CWiBWBi6Wma8gx0aTAdFMLpW4W2Z6PHKs4C+Tc5jkDzxUl41ZSFMYCbihZrHigwxbSlf9VLllQPGCovsMPiy15MiFio2KnpHdxzBXt3Jl2b9IzZ/pGRu2Joe1IoUmNpl7CDWYXsSkL9tzdvKPsi15ExaoSwtXrZZ1m7tInqvx/VR28mHwhBRCGhFEE3mpy9M/21yaF5ChfOgyTlVVwUtOY16m/1EOQP5wU1XR3p2QhIlmixJbdJ2dt2amJ9jNH6pCnV844LItL3t7Au3M77D3tacIhf8jS2VRKxDMjwjVY1mcsZuheTT8pqttgvH190pRQlrigya6WZKddVjemLCCjFdyqrpHCqDyZI5/7wmYY9TrxYe4k/vr1iTWiNSfRFdxBaArZAhjujdvUSeElMURPva3YIDtHFBfTtUJsLqN6sFJKWdg00x4/lWzUqxVpz/INQsPJK0t7nNc9dPEGCLfn5C9r1c+Q4PnpWq07P8ksQ9/Quve53sMHmGUcuzHyhnW76XrXRuDHwx
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS7PR01MB11664.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 63fa87c5-7fc5-4d8a-2dcd-08dbb8c001eb
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Sep 2023 03:25:00.8457
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CSYOWFDUrf9QC9VIZ8qZPzcAyJxwHhUsRAFnRCbxhXmpVGH1JjswrngGcr3oZGfKBWL55tVVUn4/ein+ssBpnQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY1PR01MB10882
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,
        RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

DQoNCk9uIDE5LzA5LzIwMjMgMDk6MTEsIFpodSBZYW5qdW4gd3JvdGU6DQo+IE9uIFR1ZSwgU2Vw
IDE5LCAyMDIzIGF0IDg6NTfigK9BTSBaaGlqaWFuIExpIChGdWppdHN1KQ0KPiA8bGl6aGlqaWFu
QGZ1aml0c3UuY29tPiB3cm90ZToNCj4+DQo+Pg0KPj4NCj4+IE9uIDE4LzA5LzIwMjMgMjA6Mzcs
IExlb24gUm9tYW5vdnNreSB3cm90ZToNCj4+PiBPbiBNb24sIFNlcCAxOCwgMjAyMyBhdCAxMDow
NTo0M0FNICswODAwLCBMaSBaaGlqaWFuIHdyb3RlOg0KPj4+PiByeGVfc2V0X210dSgpIHdpbGwg
Y2FsbCByeGVfaW5mb19kZXYoKSB0byBwcmludCBtZXNzYWdlLCBhbmQNCj4+Pj4gcnhlX2luZm9f
ZGV2KCkgZXhwZWN0cyBkZXZfbmFtZShyeGUtPmliX2Rldi0+ZGV2KSBoYXMgYmVlbiBhc3NpZ25l
ZC4NCj4+Pj4NCj4+Pj4gUHJldmlvdXNseSBzaW5jZSBkZXZfbmFtZSgpIGlzIG5vdCBzZXQsIHdo
ZW4gYSBuZXcgcnhlIGxpbmsgaXMgYmVpbmcNCj4+Pj4gYWRkZWQsICdudWxsJyB3aWxsIGJlIHVz
ZWQgYXMgdGhlIGRldl9uYW1lIGxpa2U6DQo+Pj4+DQo+Pj4+ICIobnVsbCk6IHJ4ZV9zZXRfbXR1
OiBTZXQgbXR1IHRvIDEwMjQiDQo+Pj4+DQo+Pj4+IE1vdmUgcnhlX3JlZ2lzdGVyX2RldmljZSgp
IGVhcmxpZXIgdG8gYXNzaWduIHRoZSBjb3JyZWN0IGRldl9uYW1lDQo+Pj4+IHNvIHRoYXQgaXQg
Y2FuIGJlIHJlYWQgYnkgcnhlX3NldF9tdHUoKSBsYXRlci4NCj4+Pg0KPj4+IEkgd291bGQgZXhw
ZWN0IHJlbW92YWwgb2YgdGhhdCBwcmludCBsaW5lIGluc3RlYWQgb2YgbW92aW5nDQo+Pj4gcnhl
X3JlZ2lzdGVyX2RldmljZSgpLg0KPj4NCj4+DQo+PiBJIGFsc28gc3RydWdnbGVkIHdpdGggdGhp
cyBwb2ludC4gVGhlIGxhc3Qgb3B0aW9uIGlzIGtlZXAgaXQgYXMgaXQgaXMuDQo+PiBPbmNlIHJ4
ZSBpcyByZWdpc3RlcmVkLCB0aGlzIHByaW50IHdpbGwgd29yayBmaW5lLg0KPiANCj4gSSBkZWx2
ZWQgaW50byB0aGUgc291cmNlIGNvZGUuIEFib3V0IG1vdmluZyByeGVfcmVnaXN0ZXJfZGV2aWNl
LCBJDQo+IGNvdWxkIG5vdCBmaW5kIGFueSBoYXJtIHRvIHRoZSBkcml2ZXIuDQoNClRoZSBwb2lu
dCBpJ20gc3RydWdnbGluZyB3YXMgdGhhdCwgaXQncyBzdHJhbmdlL29wYXF1ZSB0byBtb3ZlIHJ4
ZV9yZWdpc3Rlcl9kZXZpY2UoKS4NClRoZXJlIGlzIG5vIGRvdWJ0IHRoYXQgdGhlIG9yaWdpbmFs
IG9yZGVyIHdhcyBtb3JlIGNsZWFyLg0KDQpJbiB0ZXJtcyBvZiB0aGUgbWVzc2FnZSBjb250ZW50
LCBpcyBpdCB2YWx1YWJsZSB0byBwcmludChwcl9pbmZvKSB0aGlzIG1lc3NhZ2UsIGkgbm90aWNl
ZA0KdGhhdCB0aGVyZSBpcyBhIGR1cGxpY2F0ZSBwcl9kYmcoKSBpbiByeGVfbm90aWZ5KCkuDQoN
CnJ4ZSdzIG10dSBpcyBhbHdheXMgc2FtZSB3aXRoIHRoZSBOSUMsIGlzbid0IGl0ID8NCg0KVGhh
bmtzDQpaaGlqaWFuDQoNCg0KDQo+IFNvIEkgdGhpbmsgdGhpcyBpcyBhbHNvIGEgc29sdXRpb24g
dG8gdGhpcyBwcm9ibGVtLg0KPiANCj4gWmh1IFlhbmp1bg0KPiANCj4+DQo+PiBUaGFua3MNCj4+
IFpoaWppYW4NCj4+DQo+Pg0KPj4+DQo+Pj4gVGhhbmtzDQo+Pj4NCj4+Pj4NCj4+Pj4gQW5kIGl0
J3Mgc2FmZSB0byBkbyBzdWNoIGNoYW5nZSBzaW5jZSBtdHUgd2lsbCBub3QgYmUgdXNlZCBkdXJp
bmcgdGhlDQo+Pj4+IHJ4ZV9yZWdpc3Rlcl9kZXZpY2UoKQ0KPj4+Pg0KPj4+PiBBZnRlciB0aGlz
IGNoYW5nZSwgdGhlIG1lc3NhZ2UgYmVjb21lczoNCj4+Pj4gInJ4ZV9ldGgwOiByeGVfc2V0X210
dTogU2V0IG10dSB0byA0MDk2Ig0KPj4+Pg0KPj4+PiBGaXhlczogOWFjMDFmNDM0YTFlICgiUkRN
QS9yeGU6IEV4dGVuZCBkYmcgbG9nIG1lc3NhZ2VzIHRvIGVyciBhbmQgaW5mbyIpDQo+Pj4+IFJl
dmlld2VkLWJ5OiBEYWlzdWtlIE1hdHN1ZGEgPG1hdHN1ZGEtZGFpc3VrZUBmdWppdHN1LmNvbT4N
Cj4+Pj4gUmV2aWV3ZWQtYnk6IFpodSBZYW5qdW4gPHlhbmp1bi56aHVAbGludXguZGV2Pg0KPj4+
PiBTaWduZWQtb2ZmLWJ5OiBMaSBaaGlqaWFuIDxsaXpoaWppYW5AZnVqaXRzdS5jb20+DQo+Pj4+
IC0tLQ0KPj4+PiAgICBkcml2ZXJzL2luZmluaWJhbmQvc3cvcnhlL3J4ZS5jIHwgNSArKysrLQ0K
Pj4+PiAgICAxIGZpbGUgY2hhbmdlZCwgNCBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pDQo+
Pj4+DQo+Pj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2luZmluaWJhbmQvc3cvcnhlL3J4ZS5jIGIv
ZHJpdmVycy9pbmZpbmliYW5kL3N3L3J4ZS9yeGUuYw0KPj4+PiBpbmRleCBhMDg2ZDU4OGUxNTku
LjhhNDNjMGM0ZjhkOCAxMDA2NDQNCj4+Pj4gLS0tIGEvZHJpdmVycy9pbmZpbmliYW5kL3N3L3J4
ZS9yeGUuYw0KPj4+PiArKysgYi9kcml2ZXJzL2luZmluaWJhbmQvc3cvcnhlL3J4ZS5jDQo+Pj4+
IEBAIC0xNjksMTAgKzE2OSwxMyBAQCB2b2lkIHJ4ZV9zZXRfbXR1KHN0cnVjdCByeGVfZGV2ICpy
eGUsIHVuc2lnbmVkIGludCBuZGV2X210dSkNCj4+Pj4gICAgICovDQo+Pj4+ICAgIGludCByeGVf
YWRkKHN0cnVjdCByeGVfZGV2ICpyeGUsIHVuc2lnbmVkIGludCBtdHUsIGNvbnN0IGNoYXIgKmli
ZGV2X25hbWUpDQo+Pj4+ICAgIHsNCj4+Pj4gKyAgICBpbnQgcmV0Ow0KPj4+PiArDQo+Pj4+ICAg
ICAgIHJ4ZV9pbml0KHJ4ZSk7DQo+Pj4+ICsgICAgcmV0ID0gcnhlX3JlZ2lzdGVyX2RldmljZShy
eGUsIGliZGV2X25hbWUpOw0KPj4+PiAgICAgICByeGVfc2V0X210dShyeGUsIG10dSk7DQo+Pj4+
DQo+Pj4+IC0gICAgcmV0dXJuIHJ4ZV9yZWdpc3Rlcl9kZXZpY2UocnhlLCBpYmRldl9uYW1lKTsN
Cj4+Pj4gKyAgICByZXR1cm4gcmV0Ow0KPj4+PiAgICB9DQo+Pj4+DQo+Pj4+ICAgIHN0YXRpYyBp
bnQgcnhlX25ld2xpbmsoY29uc3QgY2hhciAqaWJkZXZfbmFtZSwgc3RydWN0IG5ldF9kZXZpY2Ug
Km5kZXYpDQo+Pj4+IC0tDQo+Pj4+IDIuMjkuMg0KPj4+Pg==
