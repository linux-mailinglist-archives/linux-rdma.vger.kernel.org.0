Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDD017A791E
	for <lists+linux-rdma@lfdr.de>; Wed, 20 Sep 2023 12:24:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234362AbjITKYp (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 20 Sep 2023 06:24:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234349AbjITKYo (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 20 Sep 2023 06:24:44 -0400
Received: from esa16.fujitsucc.c3s2.iphmx.com (esa16.fujitsucc.c3s2.iphmx.com [216.71.158.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D114FAD;
        Wed, 20 Sep 2023 03:24:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1695205478; x=1726741478;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=62pqETM3oULLK7A4U1eq1t5QyFiR0K1gy71DKJFu8dA=;
  b=B1we480nUzASDN7esXmXpB2FJtUee1dPMInJWGMYYBMcLdoOzGorv3cj
   I5e296w7iEs/oJOEAgQtnOxqcmzVi8e4B0HL8NGjUTcKeCWfvnlM7VpZL
   p/pyvIc6TEQJm/5E75TdGqZsFjBL7UsSgitxuDNJjAnpfo9ZE8h4S+fJq
   /rBjkEwZEiJuzdeK8/xPOkoB8Z5zMvlOxbBNBoVl9Hri/hU19PJ6ImI/4
   xxliL25iaQsyUNTvyTYK95MwLxJUQUmadVPlA1UQkvcaZaeQjUBq6CkCE
   44AmtN+i/L99mBNpPfAVRo3nOr+roJwc1yxX87meAJeqPHD2JUd9lsbW4
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10838"; a="95840820"
X-IronPort-AV: E=Sophos;i="6.02,161,1688396400"; 
   d="scan'208";a="95840820"
Received: from mail-os0jpn01lp2113.outbound.protection.outlook.com (HELO JPN01-OS0-obe.outbound.protection.outlook.com) ([104.47.23.113])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Sep 2023 19:24:34 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=etis/Ux5Zg3K7od5KS/2dbbMAOxt9jYH/2LPAqkFKC+pA2/Ir4bYvsx/TX5VnCx5Xe7WXqDU1JA05j+vvoRXL7R/Nk0XHAM5ZvV1SY7kvLKSnGSUCprTK7ONY6eyHdiXGT2kGcEgLokyfaBqykQGqrdrduFIQBqAFBuYsXDDTFTKGZG67S3Do8Isx5ar5VCLvAXJSNfIp5pDoqbrNNaGUFMBIKABXYV6/sJKk/SVb1VDhCUvc3/4+mG1H9DHMF1WMQCYk8isYFr5bocs06OIbudMRTGdEgC7uYOgtTy/M9l7i6AGd7uRHYEGtZkiTQ9edliO9TP1PRHC140A+4GK9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=62pqETM3oULLK7A4U1eq1t5QyFiR0K1gy71DKJFu8dA=;
 b=Uplzhis9Z30eNdZ9q4ZNhVndjz/JrCnaF0oGVIJ+sPfdms4iEkYE26++Y8f8Xhxh7p/ig5SdaDxVwxkQ+DKv7JI6VSv+iX2Og/EWUeNXXUkfnN4EG6S4GCJkX8RJAg7t3hvhzECvGN9YTuznDIVAvkgYasb8XHy9Vqp5g7HPj1yjun8gZ/fLBTeCaLP5OavKDHd4H01h0YoCoz3pnhwn7fMD9FL5iAN2OdduNG3JIJRowJd7yBnSOWXFwyNhZNDzE8HdAo8s25rP9I9voEm8POcYiVfSnVzH4nm4XHqwFUoI2LGHaDr+6Igygna2onIcevZyftgsvIf+4ISG+vutVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from OS7PR01MB11664.jpnprd01.prod.outlook.com (2603:1096:604:247::6)
 by TYCPR01MB11387.jpnprd01.prod.outlook.com (2603:1096:400:37e::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.19; Wed, 20 Sep
 2023 10:24:29 +0000
Received: from OS7PR01MB11664.jpnprd01.prod.outlook.com
 ([fe80::1a61:2227:a0de:2c53]) by OS7PR01MB11664.jpnprd01.prod.outlook.com
 ([fe80::1a61:2227:a0de:2c53%4]) with mapi id 15.20.6813.018; Wed, 20 Sep 2023
 10:24:29 +0000
From:   "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>
To:     Leon Romanovsky <leon@kernel.org>,
        Bob Pearson <rpearsonhpe@gmail.com>
CC:     Zhu Yanjun <zyjzyj2000@gmail.com>,
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
Thread-Index: AQHZ6dSthw3TTp5QhU2XAaF5adK7jbAghgUAgADO64CAAAPngIAAJTyAgABSaoCAAbUeAA==
Date:   Wed, 20 Sep 2023 10:24:29 +0000
Message-ID: <c64c4230-fb52-7017-9278-3859e44ac985@fujitsu.com>
References: <20230918020543.473472-1-lizhijian@fujitsu.com>
 <20230918020543.473472-2-lizhijian@fujitsu.com>
 <20230918123710.GD103601@unreal>
 <4dce179f-f808-0a18-7e9e-9877964d67e4@fujitsu.com>
 <CAD=hENfcbgNQxb2N1qXJa0pYkF_AYB2aua0smadwkgHtYXfeAw@mail.gmail.com>
 <0cd9103b-4411-700e-f8d1-94e8735f57e4@fujitsu.com>
 <20230919081957.GE4494@unreal>
In-Reply-To: <20230919081957.GE4494@unreal>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS7PR01MB11664:EE_|TYCPR01MB11387:EE_
x-ms-office365-filtering-correlation-id: 43ad842d-5abf-48db-2d91-08dbb9c3c5ee
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Kon6CxI4vfNiUfDFwvZ/l1ouVfTo63zZiMwA8cssV/EE7RsGRTKOFp7Y/FzGVV+zDb8MVgqyTkWjQCMDjlEHV9gWT8EA9kdChYt17u/KKRelCSkkepEco3TBnX7vOAWsvwx9fAJacCHg8OomHRtWJ2RvwlVbct9FyTy8OOBh74UaI/NwZjv9eLeE+q1UH4Q12dAidrTX2ACljeZ+tuPDJh2VnmjobamnFGf5Q9JJEb9cjMeUXFWO7ClM+nhHpYiO9pxVj0xlHEm34RpSr0YoJKLSTOD0QdvQF1PI1kOfTjBd7f5A40Y9PDv1g3ixV8EkMtOVPNrw0UfspD19uFky/rioZBN9VEZwDwUp0ujLHZTHt00PYNvwBGWHHfTyCwKE99UOK2gebda1tVR8WLwGUhcQhzdUJi+Rz/ZAZOcesO78DsfcA7X1R70dg6h8WLW0+TcBYbAyXpQx/IVfksrTL97Vpw/nLb6VXB1w4NqtwTNfntazrxscd7x93qGr3TMOxXNpPz+8gV55C9Jq6wOuWmy0HS3EI5I7OCHYOku7amGvMClizYzEiij36dnX5QFtdsUZt5YGsuzQMqfyCYavzKSzUMfIFa67oBHh9mI/sCOlwVXfGlYU3MUYvWwNyS2zwG1RUDHicH11418o7tTXry37ap0BgWTAmmD7jZWoUf7PL8jUR77mcvP1asjfCLxnyu2cTK4F+D9NWpR441KKWQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS7PR01MB11664.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(396003)(39860400002)(346002)(376002)(366004)(451199024)(1590799021)(186009)(1800799009)(31686004)(1580799018)(71200400001)(6512007)(53546011)(85182001)(36756003)(86362001)(31696002)(38070700005)(38100700002)(82960400001)(122000001)(2616005)(2906002)(6486002)(6506007)(478600001)(4326008)(83380400001)(5660300002)(110136005)(316002)(41300700001)(66476007)(8676002)(66556008)(66946007)(8936002)(66446008)(64756008)(54906003)(26005)(91956017)(76116006)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?c2lTSjllNGRlVGh6dlJXKzFEUVlyMzBNRlpYNCtOK0RZQnlXazdSOGF2WDkx?=
 =?utf-8?B?OFpRUHFMSitYK2hJNmRJLzhrbm0vYlRhRzNzTXIxSGhycEYzejJ1ZWRGTXVv?=
 =?utf-8?B?R215ZFV1NXVLQnFHWG5DMVhEUG1kNXlsYkZibWJDUEVNRmtKZllTSkRmalNQ?=
 =?utf-8?B?enE0ZzRIckJpME13WndoQzlhZ0pOVFY0b2VZUkdvREtHakVCUmtCTDIzeThY?=
 =?utf-8?B?RWszdU5kVVFNWk5XOGp6cE1oc3NIS2JDc2x5ODlCQUpnMWJMZXJpeGk2ekRT?=
 =?utf-8?B?Q2ZRVzFVanpJZWVMRDI2N2daWk1uWkkrVmtsRzVjbE83ZCtVRkh5OVdsek00?=
 =?utf-8?B?NlJXU1RvZzZKSkQxbko4SWJxa3dQVVVBNllyOFRUVTdrQWpaRGU2VDQ0NERl?=
 =?utf-8?B?UlJOYjczdXZqRFJqbXBTQUtUNXE2d1FkUnNSa0ZkRldSM1Z4aWhWU0pVd1dC?=
 =?utf-8?B?aE5ESVNpQThtcmZUdHdrYjh1YVNqRy85bjlreVd4cGx5VDFJTFhtd3oyMlg5?=
 =?utf-8?B?aHdRYXZDRlRHY1EvdUpVSmxtVFVBUVlKYWVqOGEvZm1KNTdYbnBneGY4NDZC?=
 =?utf-8?B?WU1qYlI4SFhrMDQ5QWRnaHpjU0d2U0hrcGlPeE9kWlRjQXREYzlLVmVKVEZh?=
 =?utf-8?B?SnZZTmR4aVFTaWx2a3FRWGZSejVBUVY0UWVFT29Sb0NNMDRobXNMSkZqdXkx?=
 =?utf-8?B?Mm5jK0RQYmhIY05NQXRaMEdXWU1YRUNaRzZnd2FocjUwQ1pPSVVpTlRodHNM?=
 =?utf-8?B?SDZld20wVzdzbW0zZjlORkNLZUh3UW5KL3QzWG1EQ2V4RnM3VlluWWVWRTVX?=
 =?utf-8?B?a3FHSkZXWWI3eXlwSmFabTJUZ25SeGlHaWpBdkV5bzJkSjF5YzRYK25IcStS?=
 =?utf-8?B?UkVWeUJXSGo2cjhVQmVaTFJtZlY2amQ2dUVDczRBQXRoRTd5WDBFdkhmRTVT?=
 =?utf-8?B?Tldra3lVY0V1STRMcUJDdDFYOGZYbXZwMEdydUlWVGVPUmg4d3JQaHJVekpi?=
 =?utf-8?B?K0NyaURpQkNzdTJQYXQ0WStyRWcybVBlVnpITWwxZHVab0xQQnRJc0plTGtU?=
 =?utf-8?B?RjA0SkMrK2hiQ0hGZ2NSYzhSN0FINWNZb0p4T01sUm5SdXcvOS9aTkF0MVNv?=
 =?utf-8?B?Vzc2SkpkZnhGUWNYL1dOSHE3dFlvZTM3OEN2dkhxZG1ZeTBZeXkwUFhxZ0hm?=
 =?utf-8?B?WC9icHB4MWFxaG5XQnZ6VXphd0J1T1AxNEc2dnNTckNLcXhDYmg2K1NRNSs3?=
 =?utf-8?B?WTJGLzF3THdvMFhTc1o0UGhIc2l2NzNUOGZ3TkQrMWtUVHdJa2Q0dVo0cENE?=
 =?utf-8?B?ZTdIWnlXd1k4eWFuZE5sbmVCWEdMVmxuL1Bra2JFQzlUWjhDKzBRSHB5VmFJ?=
 =?utf-8?B?b3ZrdjkwckFjTVJwVFVWNWhrWVo2TFBCbWh4b3BwdDFtaWMrZ1V2aWJ0eWlj?=
 =?utf-8?B?ZmFnTlYwQUg0Ykd2d05zZ01PY29CUWFrVlhjU3BDWEMzSGgwQTNvQ3dpT3Y3?=
 =?utf-8?B?eGFubHdZbTRvVzl4elFsMEVNbmI2bWZTUkQ2eEU1WDcyaXRtWDFXem5HZkho?=
 =?utf-8?B?WXJrYml4ek1oWFRMQWVFaERGNDRTeWVuRDVDN1ZGczU5RXRYZzdqelBQM3o2?=
 =?utf-8?B?YmlKTzlocncxTEVhdGl3MloxQnRobkdsVmRrV0owSGRuM1JUeVFSdmpPMVU3?=
 =?utf-8?B?d2g4OUNUZ2kzamNjTUVnLzdvbzUzN2czYkQvRGdoeU9UM1hDU01lMHpNT0hO?=
 =?utf-8?B?VzRLOTZ3eW55OE1hamVZdG1JdzN4UFlLcWI0N01EV2c0bjEyT2w1dTF5S0p2?=
 =?utf-8?B?VUpYQlo1WVVlbmpKd20vRC9MMUlLcytPdmlMNDkzS1BMOGdDaXRVUGpTRFJj?=
 =?utf-8?B?alBQc05ua2J3Wnozck95bTNZYTBxYXdWdFBDL24wWmxzRFg5Y1U2QkY3b0ZT?=
 =?utf-8?B?MlZ4bTFaM1Faa29DLzYzcjlnVzluU1NXVWlIb3VTczBQNnFIbDFWYjF4RG1z?=
 =?utf-8?B?QVZ4dWV5cHpLeXlQRWp0dTl2dWE3cDM5Mm9KaW54ZW5LYjFRMUZCTUdvTGVi?=
 =?utf-8?B?d1Blam5uM3ljcWo5NTlOejQyZXhQaU5FT2M1d0J4VjQ2bjlwMXZJT2d5OE41?=
 =?utf-8?B?SkZ3OUlFQkpzLzNDMGxMcmZVL2Z5YXRPYTZiUmE3WDBLNFJ6Zkd2NlF4TGlu?=
 =?utf-8?B?VXc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <48E82B62541BE04BBA97D449DF80E0BF@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 3IKcSb7evuzqfXKFcUvPlUGIfd52Fjc6jKhK0sh7syL+SWTcZ83W44vVbU3pSH14YSXno6TsKWkzUo0wtgbq0/1K9ak9E7NoZnZTiCkPoVZ3nrediZAsHPwJZEx/PLNHpfvfgshRfI0J/QKVSIih12Z5WE3AkLxDutC0Y/ANOyJL4Pca5L4KGKMfIQNYsdjU9RGTZn/zPAV5vSODkkNN7V2rQqJ60kiVD7QiFUjNOxS67n/wmWp6ICTXg+TAgM4sGoXvp+WlKYUGafodc7aXuOq0Bjg310MvGqxY2ty5hEj8W7va2kFJTSe9x1DJSE3hYdepcqrM8sHDkkyZ+7O4iPk418mujfXptrFODCrCplUI8Mr0tcJyGhp4CQTl9RHvViWnx6GeBMtOyRHsx6Jv6I9GjlwKgBWdf/utLzW3Jxga+S9pdZZBhjzFUruFWUXHHdoYVaqWZWvgiCuNEQS0QknVlQCbQNjp6F+byduQe7C57S5UiWop4Yf8gAAZ22nX5Uk05sxBeqBnUQtItjmS5VKZCZj0Vml6bwP+kDRZx770rxMyMLNErBoHcPYdVYTFwkXxDInrva/cy6tH3Y4lzUHGNT0i8eoe4fwSnVqurFTmI06ZQ/xFXZABFVZ53pxXmjgkp+a7in36OgO/X8wOcYejFSMFvA/QnuY/YpndBCDVmps11cHmRZQYj2BpVDFM4uyaCbOq5zdtO4y1MgltAIWc1/8ajpJKlxwszvEpDNYR1P7TfRaJIe+Fh4t1LuUA5s19vDE9ZRlGZz/No7r/UrJ1QzhWs4JD6zeFuRgSj3a9SK4l21ej6L0ZwA2TsXmDeyzq5XZHlPyi4ZXvBc4zOcTCt/AyxKroo8BqC7ER5R2RlHqrzoPboFplHM+Y/iMh
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS7PR01MB11664.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 43ad842d-5abf-48db-2d91-08dbb9c3c5ee
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Sep 2023 10:24:29.3092
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /pyHBS6tVMLEbhTMBOkO5qMmAQQK3Goi+NQhxMcwnSKmXZcs0QGPTNpqZkaKD5oPwLeHebH9JMu60oRh9WK5iQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB11387
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

DQoNCk9uIDE5LzA5LzIwMjMgMTY6MTksIExlb24gUm9tYW5vdnNreSB3cm90ZToNCj4gT24gVHVl
LCBTZXAgMTksIDIwMjMgYXQgMDM6MjU6MDBBTSArMDAwMCwgWmhpamlhbiBMaSAoRnVqaXRzdSkg
d3JvdGU6DQo+Pg0KPj4NCj4+IE9uIDE5LzA5LzIwMjMgMDk6MTEsIFpodSBZYW5qdW4gd3JvdGU6
DQo+Pj4gT24gVHVlLCBTZXAgMTksIDIwMjMgYXQgODo1N+KAr0FNIFpoaWppYW4gTGkgKEZ1aml0
c3UpDQo+Pj4gPGxpemhpamlhbkBmdWppdHN1LmNvbT4gd3JvdGU6DQo+Pj4+DQo+Pj4+DQo+Pj4+
DQo+Pj4+IE9uIDE4LzA5LzIwMjMgMjA6MzcsIExlb24gUm9tYW5vdnNreSB3cm90ZToNCj4+Pj4+
IE9uIE1vbiwgU2VwIDE4LCAyMDIzIGF0IDEwOjA1OjQzQU0gKzA4MDAsIExpIFpoaWppYW4gd3Jv
dGU6DQo+Pj4+Pj4gcnhlX3NldF9tdHUoKSB3aWxsIGNhbGwgcnhlX2luZm9fZGV2KCkgdG8gcHJp
bnQgbWVzc2FnZSwgYW5kDQo+Pj4+Pj4gcnhlX2luZm9fZGV2KCkgZXhwZWN0cyBkZXZfbmFtZShy
eGUtPmliX2Rldi0+ZGV2KSBoYXMgYmVlbiBhc3NpZ25lZC4NCj4+Pj4+Pg0KPj4+Pj4+IFByZXZp
b3VzbHkgc2luY2UgZGV2X25hbWUoKSBpcyBub3Qgc2V0LCB3aGVuIGEgbmV3IHJ4ZSBsaW5rIGlz
IGJlaW5nDQo+Pj4+Pj4gYWRkZWQsICdudWxsJyB3aWxsIGJlIHVzZWQgYXMgdGhlIGRldl9uYW1l
IGxpa2U6DQo+Pj4+Pj4NCj4+Pj4+PiAiKG51bGwpOiByeGVfc2V0X210dTogU2V0IG10dSB0byAx
MDI0Ig0KPj4+Pj4+DQo+Pj4+Pj4gTW92ZSByeGVfcmVnaXN0ZXJfZGV2aWNlKCkgZWFybGllciB0
byBhc3NpZ24gdGhlIGNvcnJlY3QgZGV2X25hbWUNCj4+Pj4+PiBzbyB0aGF0IGl0IGNhbiBiZSBy
ZWFkIGJ5IHJ4ZV9zZXRfbXR1KCkgbGF0ZXIuDQo+Pj4+Pg0KPj4+Pj4gSSB3b3VsZCBleHBlY3Qg
cmVtb3ZhbCBvZiB0aGF0IHByaW50IGxpbmUgaW5zdGVhZCBvZiBtb3ZpbmcNCj4+Pj4+IHJ4ZV9y
ZWdpc3Rlcl9kZXZpY2UoKS4NCj4+Pj4NCj4+Pj4NCj4+Pj4gSSBhbHNvIHN0cnVnZ2xlZCB3aXRo
IHRoaXMgcG9pbnQuIFRoZSBsYXN0IG9wdGlvbiBpcyBrZWVwIGl0IGFzIGl0IGlzLg0KPj4+PiBP
bmNlIHJ4ZSBpcyByZWdpc3RlcmVkLCB0aGlzIHByaW50IHdpbGwgd29yayBmaW5lLg0KPj4+DQo+
Pj4gSSBkZWx2ZWQgaW50byB0aGUgc291cmNlIGNvZGUuIEFib3V0IG1vdmluZyByeGVfcmVnaXN0
ZXJfZGV2aWNlLCBJDQo+Pj4gY291bGQgbm90IGZpbmQgYW55IGhhcm0gdG8gdGhlIGRyaXZlci4N
Cj4+DQo+PiBUaGUgcG9pbnQgaSdtIHN0cnVnZ2xpbmcgd2FzIHRoYXQsIGl0J3Mgc3RyYW5nZS9v
cGFxdWUgdG8gbW92ZSByeGVfcmVnaXN0ZXJfZGV2aWNlKCkuDQo+PiBUaGVyZSBpcyBubyBkb3Vi
dCB0aGF0IHRoZSBvcmlnaW5hbCBvcmRlciB3YXMgbW9yZSBjbGVhci4NCj4+DQo+PiBJbiB0ZXJt
cyBvZiB0aGUgbWVzc2FnZSBjb250ZW50LCBpcyBpdCB2YWx1YWJsZSB0byBwcmludChwcl9pbmZv
KSB0aGlzIG1lc3NhZ2UNCj4gDQo+IEkgZG91YnQgaWYgdGhhdCBwcmludCBoYXMgYW55IHZhbHVl
IGluIGRheS10by1kYXkgdXNlIG9mIFJYRS4NCg0KDQpCb2IsDQoNCkFzIHlvdSBhcmUgb25lIG9m
IHRoZSBhY3RpdmUgUlhFIHVzZXJzLCBhbnkgY29tbWVudHMgYWJvdXQgdGhpcyBwcmludCBjb250
ZW50Lg0KDQoNClRoYW5rcw0KDQoNCj4gDQo+IFRoYW5rcw==
