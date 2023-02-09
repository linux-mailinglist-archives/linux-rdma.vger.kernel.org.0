Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B410690486
	for <lists+linux-rdma@lfdr.de>; Thu,  9 Feb 2023 11:21:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229655AbjBIKVt (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 9 Feb 2023 05:21:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229634AbjBIKVs (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 9 Feb 2023 05:21:48 -0500
X-Greylist: delayed 63 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 09 Feb 2023 02:21:45 PST
Received: from esa5.fujitsucc.c3s2.iphmx.com (esa5.fujitsucc.c3s2.iphmx.com [68.232.159.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1A6B1707
        for <linux-rdma@vger.kernel.org>; Thu,  9 Feb 2023 02:21:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1675938105; x=1707474105;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=M47NK25s0J8/hDEjOdyhJgF+EmPZP42upb6khsQqMx0=;
  b=wOyDU/QYj0F+N7PL5lnZXLDVA+TozQNyJq1FMEHYbfQBECaVZYNVSsgb
   6+9JVJZ5acHIxIWe6uRYjKK5yuQzD8KyJWjEBW8wswWcpW+bj4tW4WhCP
   TvmCy2HE+ISPhfGmuQbb4UOBYhTOXaCSfAql9mOtz4y2KaKJ5mPSnfj+0
   kced32j2ceJkD4AzKXuKfHVYRzNF5+vofZjRK5j/8Nnufu2B1B049GgQq
   ce0YJMeUO6oeJMaStndjxogG1xaF4Hx8t0UQdmMWldUjRxdJnkeW0MaYV
   i7LEHXjG48ggahp0VA3wArNnEG4cRIIXeuVvMf3pkj+xf7i+bitfmmyjr
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10615"; a="76813671"
X-IronPort-AV: E=Sophos;i="5.97,283,1669042800"; 
   d="scan'208";a="76813671"
Received: from mail-psaapc01lp2045.outbound.protection.outlook.com (HELO APC01-PSA-obe.outbound.protection.outlook.com) ([104.47.26.45])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2023 19:20:37 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QLFNoVHFXYkiLFG8QPHCEa8/qi75zISK4qSWTkbw2Ey8eZnnFHE1qyvBA7sEwUGReGH8Kiz3I+tX0Mr9ukwUiCFmvyBtm3QK1JvlaAUxcqLRTF6J3IMk+1uWJr6GiyWx1mvN5u492yvFi5G3UG3GsRfdIB5XXAqQepJQgZeJz9r/S6EUeSdH28+MAIVkmzC37VM4f/0dreCX3pzchsV58HqAqt8J0JhIvEMM1I3u0gadRN93lKUwIV3CLavuZbGmU0vqK1XbS+Lef4MdPb6k5su+gWM4MuKX9Am8OupJ8ln4DTogwu8w4AhZNjATYNJgBNH7HfKCFpyI8sOWRvm9hw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M47NK25s0J8/hDEjOdyhJgF+EmPZP42upb6khsQqMx0=;
 b=LvWw0k2BgS3VHTHJyzBD/eJs2SsJe9YXPtWh9egqmJGVHm8mc5UjXCVs4GRvokgoq0DnFys3PjqNX7O7iqKM2T8wWF6DCauPPgl+boCuK3n+X8bj/f21ePillJnWj25P3gSAcc8iHHWmiLoGJGRm3smvx3fvGSstsgmB/gS/9UnBL4Cn1q8PGDIVopSK7F8mBr4DQso6i4wubI/0DApYDatfKG4DYRFSzmGStOAbqtzQ6Xg1kYGySweOmzYeIL6G9Mk/imduUOgbgZrXm8Ae/eo+dWG8k/Wxp2uF7luJ9jgS8LtHztCshtXVgiyGcl2MkIXnc4vxInVivbRxe8afQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from OS3PR01MB10390.jpnprd01.prod.outlook.com
 (2603:1096:604:1fb::14) by TYCPR01MB11636.jpnprd01.prod.outlook.com
 (2603:1096:400:37a::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.18; Thu, 9 Feb
 2023 10:20:34 +0000
Received: from OS3PR01MB10390.jpnprd01.prod.outlook.com
 ([fe80::2381:b0a1:7818:ce58]) by OS3PR01MB10390.jpnprd01.prod.outlook.com
 ([fe80::2381:b0a1:7818:ce58%7]) with mapi id 15.20.6086.018; Thu, 9 Feb 2023
 10:20:34 +0000
From:   "lizhijian@fujitsu.com" <lizhijian@fujitsu.com>
To:     "Daisuke Matsuda (Fujitsu)" <matsuda-daisuke@fujitsu.com>,
        Bob Pearson <rpearsonhpe@gmail.com>,
        "jgg@nvidia.com" <jgg@nvidia.com>,
        "zyjzyj2000@gmail.com" <zyjzyj2000@gmail.com>,
        "leonro@nvidia.com" <leonro@nvidia.com>,
        "yangx.jy@fujitsu.com" <yangx.jy@fujitsu.com>,
        "tom@talpey.com" <tom@talpey.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH for-next v4] Subject: RDMA/rxe: Handle zero length rdma
Thread-Topic: [PATCH for-next v4] Subject: RDMA/rxe: Handle zero length rdma
Thread-Index: AQHZNsEkNdUH2jzsHkO/gJEYgdYGpK7ExKoAgAGK9wCAACMlgA==
Date:   Thu, 9 Feb 2023 10:20:34 +0000
Message-ID: <cc570a6b-0702-72b7-c09e-fea45351c34f@fujitsu.com>
References: <20230202044240.6304-1-rpearsonhpe@gmail.com>
 <dc4f034a-3cc8-fbaf-a5ba-2338c8fc8576@fujitsu.com>
 <TYCPR01MB8455CB23812E701AD1220CCDE5D99@TYCPR01MB8455.jpnprd01.prod.outlook.com>
In-Reply-To: <TYCPR01MB8455CB23812E701AD1220CCDE5D99@TYCPR01MB8455.jpnprd01.prod.outlook.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS3PR01MB10390:EE_|TYCPR01MB11636:EE_
x-ms-office365-filtering-correlation-id: a98d9453-6c9e-4a07-be2e-08db0a87480c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: dzgcgLnYDW40VPq9nejA31Crj0YJxvcisRvjukbOgdh6WF1tlWzmXok8UVugH5v9zmP8TbsFY/esH4B7VYJTLoztw1/d3sEbkkQdcq8fs0VbppSMeGktERoqJz3zxVwoPNPHcFVTKncD1vR9TiT7vLsCQvGqxHOHEDyaUQLHPFFwfeGYvytBd02FIm3EEFXfFF0dFLHOGMmng58pYvltXWSkaYrFyfM326ndSQu2N4CMxRRGmU5CSqU/FuQIKW7FUszhhP5jvW0q2vet1R+9/JumVM7TiTCy6QYxfE2VLz8AebvZlWkwDy0M/AVSqKhjGyvprnbBgYSqWqo2SQdHg6HWfus8/fayfPOGxoLszvo9DvQshlDC5TTsUrraQJI2ekwKsjntI2PO8RCKcjgztbCfFYZ4+U6Nb+U/0dToyZGfGIy7peivxZwk2oOLWdoyZVhorw2JkJ2aMAB6Xbf50UwWc4ZIFbYIQ8Rb7CZY5SJezIpJ1qPv4uLnhMnpc87ZldvWPsBUrWaLQ2ITZYZ3QOM0My91vbAIysTexLCgyrDdCNCeO5bR3VsDPh6Y5lBiF3Zk5auI9oa08umctzbhPT38wU63k1Z0jEGthiF9EAyTJAkMtje3s+WYvbKspWghwi8SSJQOLrgm3Ml3OIaDw1cE+cQlXL8ayR02HRIM5mp6k0lfm0FpBoz3lXQrbSnTM8b0B5mJnkj4X1/TAUqxanGqEEqp9RWldKTtL3i2S/HgxRJUJ+uTntSkmT5QgZHKyv9QbBkU1el7hKLkWPuxWXiGeVhQmwabjJ1tH3cXS7w=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS3PR01MB10390.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(366004)(376002)(396003)(136003)(346002)(39860400002)(1590799015)(451199018)(31696002)(36756003)(85182001)(2906002)(122000001)(38100700002)(82960400001)(1580799012)(86362001)(31686004)(478600001)(71200400001)(53546011)(6486002)(6512007)(26005)(186003)(38070700005)(91956017)(66556008)(8676002)(2616005)(66476007)(6506007)(66946007)(66446008)(64756008)(110136005)(316002)(41300700001)(76116006)(8936002)(5660300002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NE9BYmo5UE1yUVpieGx1cE0rNzB5MEVUdjlxdU4zQzc1SjVhNlB4dXBwME15?=
 =?utf-8?B?aVY2aC9yaVhFOHBWUlJMYUh0Z0VKQUhhVS9FZFJTV2xsZWRWOGV5eUdzZWZk?=
 =?utf-8?B?MGI1U0t0OGd5TkJPcE5TdFdwZWZzaXRMT2dPdlYwSTcyWVc1NWN2Y3FHK2pl?=
 =?utf-8?B?VnNWYkhqY1FIdkZsK0ZEaE1nSVVEYi9UVlhzMFQ0bmZEVndzcm1vVVRXRVFj?=
 =?utf-8?B?MTNQYTdQY1VyQjJOUnpCcVg5R0NhL0JCZzE3dWhJcHU1YzdiMkhYWkd5MnlZ?=
 =?utf-8?B?bzNycU5PVGp1ZnJRek9MbEtEUFRnNDROVm9mR2hUc2YvandtYjY1WVcvRmNN?=
 =?utf-8?B?dHRHalUzQjAvN2JKeTRuc2FPN0J0UHdHVzN3ckxRRWNHZDBhK0tNSEQvYXlO?=
 =?utf-8?B?RTRvN0hTY2hpSnMvL1h5cXJqQkhVYWZXZGVSTmYvUTZtZ2M5cUZkN2c3ZGJz?=
 =?utf-8?B?cGlFVWdGSlpnQzNuNHNNTm9VSTVGY2w3SHBVbXhmZWoySUl5NkVaRGF1UzhT?=
 =?utf-8?B?UjQ5Y3ZtR2w4WnB3WUgvM09KQnpmazltNE9yZGRZQjJ1bXNJdlZmcTA5SVdw?=
 =?utf-8?B?RkNRbG8yWC91Wk5IMWE3TGUvRTVPWVc1VUdJeDFGTldsOG9zV3c1VFJWYWNV?=
 =?utf-8?B?Y3FGN3Yya2JYNXo2OWNmNnpSTEVqWEIwKzZ0NVBYYmFhMVQ2c0VhVEY3SjBt?=
 =?utf-8?B?MzN6bzZsdlZseGU2RFNvSGNuWk5tdjREQ0Z3OE5iTDFYTlQ1S3NycFdHbjAy?=
 =?utf-8?B?TnlCa21HWTE5bTJjMk9PWjVod3ltaXhQUWV4NEVid3V0Wk53dWtZSXBUeTZD?=
 =?utf-8?B?SkdJQTFBWjJFa2NVd1hVdFRXMCthb1NqSy9nT2duaHo4TmF0a1JIdXBuN2Y1?=
 =?utf-8?B?cUF0V2FFTGJtMDZMR3NuMk1MSVdsS2taRk5ldUxkMGE0QnU3OTJVOEVvWTl3?=
 =?utf-8?B?ZFEwbU8zaFdOcHJKMkx3Y2VsU2dHZ2tHeDVKMExmV3FRNG44NUJqY0RvdE8x?=
 =?utf-8?B?aFdDT29aNEQvdFJ6M3RjUW1ZcGhDL01DeFhPZWtmdCt2cHEzUWtiTlBiREx4?=
 =?utf-8?B?M0tjM3R3U1IyT2UwS0NRRWFzQUVDVmgrU3d1ZjV3a0ZTNzFFTkRhY2RFa3lH?=
 =?utf-8?B?SWlIZ0JJaTEwV1V1QkdvNmV5cXJ3SEdNMVhzcFRkZUJIZmhHSGZ0NGp2RXhn?=
 =?utf-8?B?YjU1U0lsa0dGK1QvUVpMYWk4UlhPTU9icVViK3FkWnVTblM1bXVtaE4xT0Fz?=
 =?utf-8?B?SXIzcEVJOTErYTJ3VlVZWndLc1dEbTlvL3pEdzlRZFI2VkU3NU5DK3M1MnFr?=
 =?utf-8?B?Q3ppOWpjSjBlT0VTZWhkV1dJMFFuKzNBN1ZPUWxVRXdxWG91QUZSUkx2ZHM1?=
 =?utf-8?B?RHQ4bzFNaVNNSFk1b002QUw1WlUwUFhRZlZGaUV6ZnpNYWNxYVZTMGR0M21M?=
 =?utf-8?B?QWhoSFpuajNVeHFJRzh6bmM3NFgvUTVrTHA3UlQ3SDV3RlhKZDFGbmVRL0h0?=
 =?utf-8?B?SXk1RExiWlRra0tZRFJNWWVSM25VS0RpeE9tRHptcjluM01Fak5NVEhGdXhM?=
 =?utf-8?B?Ynp0d3kyZC9BMkFoZVAxNys1V0JZYWdSZDdHSk5JY3lwa203ejlpZ2MwZTVY?=
 =?utf-8?B?eXFhbVNIZkdweHFnN1VlSmN3UldtcGR2UUN1Ylp0WUJvWWNIeElQekttd3Rw?=
 =?utf-8?B?OE9QWWxPSjYyc0xneGliVUlrRTZYMHNvWkJPdHlFQXJSL2dwNXNEQ1B5b2tT?=
 =?utf-8?B?YXR6L1RZVS91blNpQitsVkpPYnM0V2p6c1d4bXQwWnhxM1RPZDYxTEJGYmJs?=
 =?utf-8?B?U3lsdGxjbG1oRDUvWG5vQ0hsdFl6azJLRGZ3QUZLV1IxT1VJM3Q2ajV2UHpM?=
 =?utf-8?B?YVlnQ1RGQkt0RDlWSUExS1hZS0tmVDh6c1hXNC83NzNKTGY3a0hmc080cnVn?=
 =?utf-8?B?WE9YWG1LNFZqbjl4SUkvR0pCRUNGQkFBL0p3bktxdTNkTFNRb2w3Wks1RDVn?=
 =?utf-8?B?dlFvNlo2NzYrMGlNNWZ0VTVnVjJFMFVocWJKbzVKdklyQ21YSDdQdEYrVHFw?=
 =?utf-8?B?L0JKVDhkbGE2eEoxOVcrRXkwOXVXbll1LzRubHF3ZjQyektTQklnRjBwQ0pl?=
 =?utf-8?B?NW1VWEJIK2swNXF3cVM2T2lJMzc0VmcwaGdGQUd3VEtMUVFmYktBbk1sRlBy?=
 =?utf-8?B?Nnc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C0DD738418EC644FAD8C89CC810784F4@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: Bex8lThQ8El/fb9/20KI08v5lhCAx5jiqLh6ZEczS+CYQ0m1H8GXzJX/3259fUlsWvU7Bz3/I1ivuIAYA9HagwSLdHeCyo+ylIbCjLOn6f6zsqpQx6s9pr11/+LVCMrxeIfc23Oy8CsAGcsXGn5fjcWKv8Vu6TvK3IUjhl9+pvO2e/wCao+3B3GdBeA2KZSPpVDsvdWQHIwy+kqsA8hVbmX8CEahdc4gjwa1lU4s2y73Zz6dzdUkqER0o4cFV/aBN5jpPP716pE3KtYTGg1iVPShLni7fs+R54OQlFW2mBSYwZ/CFOhCFxM/3/1q8165SZfYnKs+JCCq2J6ocwpRvDvJ44b7hXsgITmbLnElb81/nMPUdADNXFbLVgTTcUXt1xgLcBOsmDp9B4XV5pWbrjKDwzkF7zRVMs9d2LwD9b7MHv1oAQ4ubK0OxlaQhW6UtH/ISQf52xMi5SM043df4IoHo+cp8fFOKeWnk5tJ8R8lwqn3g6WesQfdk0n6NVFolhvfwrRWXWp4vuc5wAUfJR0NoacsMILDQ5va0gA7BxLkrkFJCW0/D8NW2tkeAf570f5RzGKOmu9HXMgrtKYqGYVRS01B0gRFhGnY3DIeiyOZMhR8Tj2mEKgm8LTgX7tylwu+lhyZ7p+iQXs7XB0CIDF4/j2IqS2j1jfGv1DELuk+JyoN3usyZfCHgJRdfSTkquBx4KxglZXhQ/dgutXz37LSjJFWgKklsn0MsTWFWyiWebSPhAmpjksstMXG1CyDUojUkKmWEkbLkHtFIgGoc9HMyzz8BbuambwMGMM8mk7dCYZj7bWbqVusnsmRJ106V2b8evgEJAnZfIHrZWDCubB9w90eF4F9rzDGmxPWXsg=
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS3PR01MB10390.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a98d9453-6c9e-4a07-be2e-08db0a87480c
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Feb 2023 10:20:34.8090
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6eFW1j12gvEirhv5ymwKmRizptRvCYiUMl5xF2aDGlBwuwGbqsnnOpDz2n0dXAb8tuUldtIx2s5dnlNpXvnycQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB11636
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,NICE_REPLY_A,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

DQoNCk9uIDA5LzAyLzIwMjMgMTY6MTQsIE1hdHN1ZGEsIERhaXN1a2Uv5p2+55SwIOWkp+i8lCB3
cm90ZToNCj4gT24gV2VkLCBGZWIgOCwgMjAyMyA1OjQxIFBNIExpLCBaaGlqaWFuL+adjiDmmbrl
nZogd3JvdGU6DQo+Pg0KPj4gT24gMDIvMDIvMjAyMyAxMjo0MiwgQm9iIFBlYXJzb24gd3JvdGU6
DQo+Pj4gKy8qIHJlc29sdmUgdGhlIHBhY2tldCBya2V5IHRvIHFwLT5yZXNwLm1yIG9yIHNldCBx
cC0+cmVzcC5tciB0byBOVUxMDQo+Pj4gKyAqIGlmIGFuIGludmFsaWQgcmtleSBpcyByZWNlaXZl
ZCBvciB0aGUgcmRtYSBsZW5ndGggaXMgemVyby4gRm9yIG1pZGRsZQ0KPj4+ICsgKiBvciBsYXN0
IHBhY2tldHMgdXNlIHRoZSBzdG9yZWQgdmFsdWUgb2YgbXIuDQo+Pj4gKyAqLw0KPj4+ICAgIHN0
YXRpYyBlbnVtIHJlc3Bfc3RhdGVzIGNoZWNrX3JrZXkoc3RydWN0IHJ4ZV9xcCAqcXAsDQo+Pj4g
ICAgCQkJCSAgIHN0cnVjdCByeGVfcGt0X2luZm8gKnBrdCkNCj4+PiAgICB7DQo+Pj4gQEAgLTQ3
MywxMCArNDg3LDEyIEBAIHN0YXRpYyBlbnVtIHJlc3Bfc3RhdGVzIGNoZWNrX3JrZXkoc3RydWN0
IHJ4ZV9xcCAqcXAsDQo+Pj4gICAgCQlyZXR1cm4gUkVTUFNUX0VYRUNVVEU7DQo+Pj4gICAgCX0N
Cj4+Pg0KPj4+IC0JLyogQSB6ZXJvLWJ5dGUgb3AgaXMgbm90IHJlcXVpcmVkIHRvIHNldCBhbiBh
ZGRyIG9yIHJrZXkuIFNlZSBDOS04OCAqLw0KPj4+ICsJLyogQSB6ZXJvLWJ5dGUgcmVhZCBvciB3
cml0ZSBvcCBpcyBub3QgcmVxdWlyZWQgdG8NCj4+PiArCSAqIHNldCBhbiBhZGRyIG9yIHJrZXku
IFNlZSBDOS04OA0KPj4+ICsJICovDQo+Pj4gICAgCWlmICgocGt0LT5tYXNrICYgUlhFX1JFQURf
T1JfV1JJVEVfTUFTSykgJiYNCj4+PiAtCSAgICAocGt0LT5tYXNrICYgUlhFX1JFVEhfTUFTSykg
JiYNCj4+PiAtCSAgICByZXRoX2xlbihwa3QpID09IDApIHsNCj4+PiArCSAgICAocGt0LT5tYXNr
ICYgUlhFX1JFVEhfTUFTSykgJiYgcmV0aF9sZW4ocGt0KSA9PSAwKSB7DQo+Pj4gKwkJcXAtPnJl
c3AubXIgPSBOVUxMOw0KPj4NCj4+IFlvdSBhcmUgbWFraW5nIHN1cmUgJ3FwLT5yZXNwLm1yID0g
TlVMTCcsIGJ1dCBJIGRvdWJ0IHRoZSBwcmV2aW91cyBxcC0+cmVzcC5tciB3aWxsIGxlYWsgYWZ0
ZXIgdGhpcyBhc3NpZ25tZW50IHdoZW4gaXRzDQo+PiB2YWx1ZSBpcyBub3QgTlVMTC4NCj4gDQo+
IEkgZG8gbm90IHNlZSB3aGF0IHlvdSBtZWFuIGJ5ICIgdGhlIHByZXZpb3VzIHFwLT5yZXNwLm1y
ICIuDQo+IEFzIGZhciBhcyBJIHVuZGVyc3RhbmQsICdxcC0+cmVzcC5tcicgaXMgc2V0IHRvIE5V
TEwgaW4gY2xlYW51cCgpDQo+IGJlZm9yZSByZXNwb25kZXIgY29tcGxldGVzIGl0cyB3b3JrLCBz
byBpdCBpcyBub3Qgc3VwcG9zZWQgdG8gYmUNCj4gcmV1c2VkIHVubGlrZSAncmVzLT5yZWFkLnJr
ZXknIGJlaW5nIHJldGFpbmVkIGZvciBtdWx0aS1wYWNrZXQgUmVhZA0KPiByZXNwb25zZXMuIENv
dWxkIHlvdSBlbGFib3JhdGUgb24geW91ciB2aWV3Pw0KDQpJTU8gZXZlcnkgJ3FwLT5yZXNwLm1y
JyBhc3NpZ25tZW50IHdpbGwgdGFrZSBhIG1yIHJlZmVyZW5jZSwgc28gd2Ugc2hvdWxkIGRyb3Ag
dGhlIHRoaXMgcmVmZXJlbmNlIGlmIHdlIHdhbnQgdG8gYXNzaWduIGl0IGEgbmV3IG1yIGFnYWlu
Lg0KDQoNClRoZW9yZXRpY2FsbHksIGl0IHNob3VsZCBiZSBjaGFuZ2VkIHRvIHNvbWV0aGluZyBs
aWtlDQppZiAocXAtPnJlc3AubXIpIHsNCglyeGVfcHV0KHFwLT5yZXNwLm1yKQ0KICAgICAgICAg
cXAtPnJlc3AubXIgPSBOVUxMOw0KfQ0KDQoNCg0KDQo+Pg0KPj4+ICAgIAkJcmV0dXJuIFJFU1BT
VF9FWEVDVVRFOw0KPj4+ICAgIAl9DQo+Pj4NCj4+PiBAQCAtNTU1LDYgKzU3MSw3IEBAIHN0YXRp
YyBlbnVtIHJlc3Bfc3RhdGVzIGNoZWNrX3JrZXkoc3RydWN0IHJ4ZV9xcCAqcXAsDQo+Pj4gICAg
CXJldHVybiBSRVNQU1RfRVhFQ1VURTsNCj4+Pg0KPj4+ICAgIGVycjoNCj4+PiArCXFwLT5yZXNw
Lm1yID0gTlVMTDsNCg0KZGl0dG8NCg0KVGhhbmtzDQpaaGlqaWFuDQoNCj4+PiAgICAJaWYgKG1y
KQ==
