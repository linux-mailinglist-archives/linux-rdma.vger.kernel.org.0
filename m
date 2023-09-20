Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BB737A7045
	for <lists+linux-rdma@lfdr.de>; Wed, 20 Sep 2023 04:17:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229641AbjITCRk (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 19 Sep 2023 22:17:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229648AbjITCRj (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 19 Sep 2023 22:17:39 -0400
X-Greylist: delayed 63 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 19 Sep 2023 19:17:32 PDT
Received: from esa15.fujitsucc.c3s2.iphmx.com (esa15.fujitsucc.c3s2.iphmx.com [68.232.156.107])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7745AB
        for <linux-rdma@vger.kernel.org>; Tue, 19 Sep 2023 19:17:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1695176253; x=1726712253;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=OiEIymAfEa3MzBIncuEFatUt+mETtr2DQk6gnlg1utc=;
  b=XdH/eibcCcgaHTi0ijePJjvAiFh5R3GCQrhCkE/FsY4vXwhUKsE7Y8f0
   SmgNoYVO1sWL4/iyBBo4wMVQMg5tYabu8KB4nWvx34EkCIlIBZdUE6tB9
   jTQhfQ/MLjtwlp4hsqoa0JCrlYg9GID58EcnSDRU3dUbVRYJ33UtQxwTn
   8tWccBp7zaLkhsdSvAps+wxwc43o7/D05SmhoOnftGjmQ2pIyloFmxcYI
   sSx86j3OoH5vNegHZq/34f3vrf2Rr8ueEkhgOluUduchXx/nKbB8NwBPZ
   nUmeG6DK4OZ+NTJoEwFJgffEWyan5IPDl3tEjXxm8CB/lhSNX0Tcew7fb
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10838"; a="95936919"
X-IronPort-AV: E=Sophos;i="6.02,160,1688396400"; 
   d="scan'208";a="95936919"
Received: from mail-os0jpn01lp2108.outbound.protection.outlook.com (HELO JPN01-OS0-obe.outbound.protection.outlook.com) ([104.47.23.108])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Sep 2023 11:16:24 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cC2e1W4QW3e9LLEKJ/uenwJ4Mh2jLPD2rHPS6tirTkSEQmHX4mfOckd10qE+tF7XAftHCdS9AQS9XKwY9LfLtG7OhlMdq/y7ty8o+n51N2xAAZ32c2vsYQRIhO3WYeKK+G+wp42UQ3+j8pnrSy+d2Cbx//ISD98f/sSHEIqog4Rs5MK/XhgPbCcgHTc3JK6sPqtgrvLQH4iIFEdeN+hcFOnFRKp0AcOCqL3HjNOoZP3smzQQh8S5oyclewJkoo2woN9pJM94kv1sbRfd63c4RAtdvpgVNeIUBOzT7vkduLGYSP903a5ipSS3B6/AfVTDV5A4xyVXxaf6zwYEM08EQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OiEIymAfEa3MzBIncuEFatUt+mETtr2DQk6gnlg1utc=;
 b=QNNp7DdbskSEy4WS3vILmXScV3QgmrnaXOxNR0QU2Rr2wrCanptnXyG0SqnxXjpwMT1S4nFulRR3tcTHT+pJfvI2BJpbZfhk4k7Al/VmuCa4mIiLwAKuykWAOUcPPpBqdGLZICYxyuXM/gHbskLsNE+9u7XU3sUkFDReSLoTKA2rI83UjnJmgZepWX3q7C26IuY00SSU+qiyPlVPQ7AGV+3LAXDF/VQlkKUMXbnr+quX+wwUyYE/RYKOSHla8gymJq2Tiy0fmYeZDHo66gdbTOveqEEsSIkgUlk5Vu9uQiZUcL4R2WLosjVLg8uYW0jTLfm70Q/n+m2YbQYmr4gysg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from TYCPR01MB11656.jpnprd01.prod.outlook.com (2603:1096:400:37a::6)
 by OS7PR01MB11615.jpnprd01.prod.outlook.com (2603:1096:604:244::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.19; Wed, 20 Sep
 2023 02:16:20 +0000
Received: from TYCPR01MB11656.jpnprd01.prod.outlook.com
 ([fe80::e3ee:6027:e9a0:48b4]) by TYCPR01MB11656.jpnprd01.prod.outlook.com
 ([fe80::e3ee:6027:e9a0:48b4%6]) with mapi id 15.20.6792.026; Wed, 20 Sep 2023
 02:16:20 +0000
From:   "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>
To:     Leon Romanovsky <leon@kernel.org>,
        Zhu Yanjun <yanjun.zhu@linux.dev>
CC:     Zhu Yanjun <yanjun.zhu@intel.com>,
        "haris.iqbal@ionos.com" <haris.iqbal@ionos.com>,
        "jinpu.wang@ionos.com" <jinpu.wang@ionos.com>,
        "jgg@ziepe.ca" <jgg@ziepe.ca>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH 1/1] RDMA/rtrs: Fix the problem of variable not
 initialized fully
Thread-Topic: [PATCH 1/1] RDMA/rtrs: Fix the problem of variable not
 initialized fully
Thread-Index: AQHZ6p4yuSKpGtPF7EG2EA9al3eX6rAhziUAgAACtgCAABHCAIABGQiA
Date:   Wed, 20 Sep 2023 02:16:20 +0000
Message-ID: <d07d0b22-d932-dc01-1f33-c07932856fbc@fujitsu.com>
References: <20230919020806.534183-1-yanjun.zhu@intel.com>
 <20230919081712.GD4494@unreal>
 <01d9dd18-3d63-fabb-33d4-0de528f15a9a@linux.dev>
 <20230919093028.GG4494@unreal>
In-Reply-To: <20230919093028.GG4494@unreal>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYCPR01MB11656:EE_|OS7PR01MB11615:EE_
x-ms-office365-filtering-correlation-id: bd512a05-dc36-40d1-cb8b-08dbb97f948b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 41wpe+sqbe78zQGp711tYu90yfBrhqXlHUpcLyWKfRySNuaFnsiunuoXLLkoqneoIjZJZMXjEMuAk8/wtlX5fCMum2uqG2pM+34Q18IyqvNzf3mM/hCCYrFJZM746qmQYskUhm2Rr0D0cD8+kxUj+Yf3OKzUVcWxEOAE7NMeGSfoXshlwKDW1AOvsdkt3fpyMQuwTHagFRA3lBnJp6s/Q3+N9tdkwfC0PoergwynB84m3GuHngG6qfQ+3UksZqbz0oAzRSXAijssTiRS/7oBsz+l+dkMatVsisekNgY8EwEplLwmiPpxLfs52WDX7AZ8lKgu6ileWs6Hf8T0mODKWdlLuX2uz8zF9w7wTj569JOh6IXiAUkuVe/61iF4ZzDrV5vEFCAXtm5ury4A3GXkS1WAs2slrfVgNa3MeeEirsOXOJmeUvB+PdtB6/LGJqhtViMfY+qhpm7WT74EoigsTnZNuOmtrdSjjqPkBs2GTdySIn/5R72ICwyOhCYIKLJ4Uz4MbQcl4R0dIkDDcediA892hYkIbqRiPhrHDO6INVCyc3qXs5N7tiIHZqMhci0UjoLozp/81Khaijyu8EeVnjf93pX59YwYatP2vidLHNvkECjBsa1dgkAl5fyARCl7DLrjdcUH2bJdYgwlsc/W1qN9txvDD8sjkbLBhnBwvLUUmmnaAmxZqFDNiu3IZMXRjffm+RQhYBK13OZ/DI2M7A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB11656.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(346002)(366004)(396003)(376002)(39860400002)(186009)(1590799021)(1800799009)(451199024)(6512007)(1580799018)(53546011)(6486002)(6506007)(71200400001)(83380400001)(122000001)(86362001)(31696002)(38100700002)(38070700005)(82960400001)(85182001)(36756003)(2616005)(26005)(76116006)(110136005)(91956017)(66446008)(66476007)(316002)(66946007)(66556008)(54906003)(64756008)(41300700001)(2906002)(5660300002)(8676002)(4326008)(8936002)(31686004)(966005)(478600001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NHlucDBLWWpvc01FL0FlU0ErUVp0S0pMWHR1UHBPZmJtY1NlS0JDYVE5NVlq?=
 =?utf-8?B?ZWNLdE9lMlBGdWRWY0RCVThmZ09RK1VvOUpibFo0N01lREdsbzhzY0tVSElq?=
 =?utf-8?B?TUZocEFlUnJWRTJvVk5YRVFUNkVFZkI1dkVwb3BEWU4zMFhZNGdzNWs1Y3Vv?=
 =?utf-8?B?bG16cGljcFBnVVd2Q1hkS0RWUFNzWHV2VGJWZXBHUjhQNmFVeHArWk56ZWh4?=
 =?utf-8?B?SS9McDhaVzdkbWZvV0Q1MWRJSy83SUpQQnVwU1FaYWJ2TWpPeTFnSnRWdjdH?=
 =?utf-8?B?bitYSzhxRUxuNnVWeVFYaXg2TVVKaldvNm5wUTlGSTFpUnMrenVGMFVNWTZG?=
 =?utf-8?B?a0F3eFFtK0ROSmR5dlRxWThhVXhWQ0JxMEkxNWFPc0FMc012TjRzQXNJQ21k?=
 =?utf-8?B?UXJ1L1dpSU5QUVRQWU9vLzhzU0VqZHhjZ1RkVzhWWXQ2TUtTS1Zmanc4SVox?=
 =?utf-8?B?OEpvazJCUk9aVFBuVnFYblpPZDlvT0JkTGpudW0yejNrOTFBbjhIbVBzRThh?=
 =?utf-8?B?bXdWYUFmV3pOUCtOcWhIMGk2Z2srL2IzbDFxZm42UE1heWpDdzF4dnVRTFVK?=
 =?utf-8?B?OCtoeWhqVDBWZld0WGNaOTZUWUg1Z0FUVEhNUG1LczFaZEUvb2VqUitrc1lk?=
 =?utf-8?B?a2pLaENqcVlaa1JTckFNeUgyd3liNW5oWWJqclpoRkNuZ3U2NE53QzlBQWp0?=
 =?utf-8?B?MFROM0ZjWXVEZCtBcCtkdVVtampoellLV2N4amdPMUFRNjkyc1lwRkdlemU4?=
 =?utf-8?B?N2lwSnA3L0dqT2kxMngxMk1qNzVDZWNYdURzNjI0aWZkbEE3bjdUNzEyMnl2?=
 =?utf-8?B?M1FEM1d5ZmZqcGlaZHNscWxCNVI2MFkyUWliZVhaSHNvM1BHVS9uSWEyM2Ft?=
 =?utf-8?B?aE14eU92b21wVmJtcVkxYUE0cTJjZTMvZGNkQkdNZUZtcWJCbm9UNXNqdFdG?=
 =?utf-8?B?WDY5U2pKbnB6a2lpSWdwT2tRYno5YkpXbm5aeVlvU1F0MG5NbjNnTGpoY3JF?=
 =?utf-8?B?aU8yRUdLWEczekdrc0hsZzVoUFoyWUVPcmg5WmtRckxCVXcwaEVIWjNUZXMz?=
 =?utf-8?B?SFgzRkR6d0V4a2lFbVJmUFcxR2xjbktsKzU4M0EwYTd1SmUxU3F6RXV3N2ZZ?=
 =?utf-8?B?c05ucVdCOG9DRmF0SCtIOFFWU09tcWJtTkhoTmFWY1JzZit6R0E0SE9CNzNz?=
 =?utf-8?B?MmRUSy9peVgySE9ORXNBVzBPcXZseERWK3YrTDMzMVUvc2RTZUVZc3hWMlI2?=
 =?utf-8?B?Z0p6ZEhpMVJaYVYySXFZMFdIMHZMT2c0bTlmVHV3MXdaV3ZHQllnZGtWejhs?=
 =?utf-8?B?Z3I1NFlYSmhwRHlPa0ttOXRscWxTdmRZQXpDVFMxaWFDTU9HNG5ZbXZBWno1?=
 =?utf-8?B?VWllRTBZR2NTOVNBNTAzdlE3eFo3MFgrOW12dUo0VXlWMVZSZmZGdUhVVldu?=
 =?utf-8?B?ZVp2VTg3WFBXT2x4T2dweFpjZ3Z3NHozOXJCTjlzdk1nVk9FL05NcUZJZmpu?=
 =?utf-8?B?akhubnI5d0ZETE81UFB3ODFUVFI4cTlXMGNUcElBaktyVWRrYlpQbjQybW84?=
 =?utf-8?B?S2pNRDBpVmJsc0xMWCtZMWF4VkRaWlI0Q3JpNEtXcytHdEs0UW43cVZwaDYr?=
 =?utf-8?B?SHRQV3BtN25qWkttRnFZd3IwZUN4MHA2MDBKVVMzdWtSRnRnVXdkWFQrREJr?=
 =?utf-8?B?SWJicXdJM0tkRXI2T1ZDYTVoVkhOaFZrREFDOFYwaWpUUlVSSnp2b2xib0xl?=
 =?utf-8?B?RHlmS1MvM05hV01FY2ZucDd5OVNUOTlGUExod2c0UElTdmhQR3pHckhVV3ZD?=
 =?utf-8?B?T2RTVDF3OVNjcitqRHVqaThZbWdNNnN5bzlFWGtZVnFEYUVlVEdCb0owQXE5?=
 =?utf-8?B?T3k5WEp5aDcyT1RUdlJuNlJmT1RyVFB1ekhxa0I4YnBRZ0JWbEN1NXF0V2do?=
 =?utf-8?B?Ky9wTWtJN2JCL0JZZEk4OXhWQndQRTNZZUVFd1dvWGZhcU14QXV1RytLS3RC?=
 =?utf-8?B?TGllRnRmMG5nblV2b2N5Z254aldqQTg0UEZORTBMdlNuM2tnemFqTzBkZjZP?=
 =?utf-8?B?dEVTV3NZNnE1MUc0bVhMRjIxUERpSXVQTDNlaUhqb1Z6dFB0V2tBeEdGK1Jo?=
 =?utf-8?B?eGgwOFlSbFR4UFZSSVBBbEhGMmViT25wV1kwYnEvN3FzOTlNWWJKKzBmNmpr?=
 =?utf-8?B?QlE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C9354EF3664ED446801625BEE4F512DA@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 9oZ0DeA2omS8PUKYiMqcRhWMz2gdpKtbzDvq4pi264hR5i17+Yq5cDSBEGMX7/W8DlQqFH9pYoYfJM/6bZquC2E0lA/rV7V/O2W5+HpUh5qVyzr4KQWiJ6Fb/WVB6bvNxtdMf+rl7w5BgQGyC0ZzsZOLQgdWXuJG+vN8W4yQ23mzby31pW5SvBJk7DluxUzU3rA2B0E5IZ23Kat+CIEyp9BWWUmqWRNny67ho5jHRn++zFlvPw8fZ+msFft5ooNqpJ+rpjXfAfJZfc0QCE/gx+DYqe4vV2byi2ZobGs5811kdweHM4nZ67DzlMjCnDHOj7u/98u5sFzTVRu3PFHi3+4VvcbD5VHUFWZQXqf1ZTs/w23Xmo6yDJ/I9lbsrKSy9AEsY7S9En50Xe+Ce0uuRj5HV5LqLXlPte8rpw9ZJQDbnbOP0UAOZnukBSllgRrJWQHaDyrQ0F4l92OmKMP4bz/WE+Hv5oh1zSBWMAWtURB5WTRoLsBhbNYGlcXEJJ3GLsk4TMHkuTRfZtadkVPA9vjtSeWEjQM8LP7qyBBXbYKdxKubyoVBCp4QDiVyQNG5UrNo1b7YaCPEEAWsefJFkiUcnMS93/TkSZ+BShJ+7CXt5l2HD7ZTioYMljqYqssqXaQLEtjcd3Bz9SYF/T2+4Xhz4XEsNlCNmsFE9POclgYIeHMru68iId8q+o/VIzo/xhhzT+oN4biAznDEbUU62HkEXH1JReTj5WkLDVfQ1tX7yY3Q8kb9jgAmgtKJ65RWFbxvGJR3/fKVLEJW//kPykUi4PEmzKZFMPx43luZveO1MQtBarcAh4AvgL8bkd2OhrtsggnssxvBVP7CDUxBxsrcEhHU5rINGYhdTGREXRSHLhnLnYgbUurjhMexjuanKEfiZG/3B2iAA0Tgg1bnSQ==
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB11656.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bd512a05-dc36-40d1-cb8b-08dbb97f948b
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Sep 2023 02:16:20.7146
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /pWcCBVFqheT0zaNFkwdAPyG8PYLsbBOR1A4dhah3CGTrsmAskbuOfiss8TaFmPbfA7uisrGjMWW/a3ss3kTwQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS7PR01MB11615
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

DQoNCk9uIDE5LzA5LzIwMjMgMTc6MzAsIExlb24gUm9tYW5vdnNreSB3cm90ZToNCj4gT24gVHVl
LCBTZXAgMTksIDIwMjMgYXQgMDQ6MjY6NTRQTSArMDgwMCwgWmh1IFlhbmp1biB3cm90ZToNCj4+
DQo+PiDlnKggMjAyMy85LzE5IDE2OjE3LCBMZW9uIFJvbWFub3Zza3kg5YaZ6YGTOg0KPj4+IE9u
IFR1ZSwgU2VwIDE5LCAyMDIzIGF0IDEwOjA4OjA2QU0gKzA4MDAsIFpodSBZYW5qdW4gd3JvdGU6
DQo+Pj4+IEZyb206IFpodSBZYW5qdW4gPHlhbmp1bi56aHVAbGludXguZGV2Pg0KPj4+Pg0KPj4+
PiBObyBmdW5jdGlvbmFsaXR5IGNoYW5nZS4gVGhlIHZhcmlhYmxlIHdoaWNoIGlzIG5vdCBpbml0
aWFsaXplZCBmdWxseQ0KPj4+PiB3aWxsIGludHJvZHVjZSBwb3RlbnRpYWwgcmlza3MuDQo+Pj4g
QXJlIHlvdSBzdXJlIGFib3V0IG5vdCBiZWluZyBpbml0aWFsaXplZD8NCj4+DQo+PiBBYm91dCB0
aGlzIHByb2JsZW0sIEkgdGhpbmsgd2UgZGlzY3Vzc2VkIGl0IHByZXZpb3VzbHkgaW4gUkRNQSBt
YWlsbGlzdC4NCj4+DQo+PiBBbmQgYXQgdGhhdCB0aW1lLCBJSVJDLCB5b3Ugc2hhcmVkIGEgbGlu
ayB3aXRoIG1lLiBUaGUgbGluayBpcyBhcyBiZWxvdy4NCj4+DQo+PiBodHRwczovL3d3dy5leC1w
YXJyb3QuY29tL35jaHJpcy9yYW5kb20vaW5pdGlhbGlzZS5odG1sDQo+Pg0KPj4gIEZyb20gd2hh
dCB3ZSBkaXNjdXNzZWQgYW5kIHRoZSBhYm92ZSBsaW5rLCBJIHRoaW5rIGl0IGlzIG5vdCBpbml0
aWFsaXplZA0KPj4gZnVsbHkuDQo+IA0KPiBJIHJlbWVtYmVyIHRoYXQgZGlzY3Vzc2lvbiBhbmQg
aXQgd2FzIGFib3V0IHNsaWdodGx5IGRpZmZlcmVudCB0aGluZzoNCj4ge30gdnMgezB9IGluIExp
bnV4IGtlcm5lbC4NCg0KDQpXZWxsLCBpbiBteSBtaW5kLCBJIHRob3VnaHQgdGhleSBhcmUgdGhl
IHNhbWUuIHNlZTogaHR0cHM6Ly93d3cuZ251Lm9yZy9zb2Z0d2FyZS9nbnUtYy1tYW51YWwvZ251
LWMtbWFudWFsLmh0bWwjSW5pdGlhbGl6aW5nLVN0cnVjdHVyZS1NZW1iZXJzDQoNCkluIGN1cnJl
bnQga2VybmVsLCB7TlVMTC8wfSBpcyB1c2VkIGluIHNvIG1hbnkgb3RoZXIgcGxhY2VzLiBiZXNp
ZGUge05VTEx9LCBhbm90aGVyIHBhcnRpYWwgaW5pdGlhbGl6aW5nIGZvcm0NCnN0cnVjdCBjbGFz
cyB7DQoJaW50IGEsIGIsIGMsIGQsIGU7DQp9IGluc3RhbmNlID0gew0KICAgLmEgPSB4LA0KICAg
LmIgPSB5LA0KfTsNCg0KVGhleSBhcmUgYWxzbyB1c2VkIGV2ZXJ5d2hlcmUsIGl0J3MgZGVmaW5p
dGVseSBiYXNlZCBvbiB0aGUgdHJ1dGggaW5zdGFuY2Uue2MsZCxlfSB0byBiZSAiMCIuDQoNCg0K
VGhhbmtzDQoNCg0KDQo+IA0KPiBIb3dldmVyIEkgZG9uJ3QgdGhpbmsgdGhhdCBJIHNlbnQgeW91
IHRoYXQgbGluay4NCj4gQW55d2F5LCBsZXQncyB0YWtlIHRoaXMgcGF0Y2ggYXMgaXQgaXMgaGFy
bWxlc3MuDQo+IA0KPiBUaGFua3MNCj4gDQo+Pg0KPj4NCj4+IFpodSBZYW5qdW4NCj4+DQo+Pj4N
Cj4+PiBUaGFua3MNCj4+Pg0KPj4+PiBTaWduZWQtb2ZmLWJ5OiBaaHUgWWFuanVuIDx5YW5qdW4u
emh1QGxpbnV4LmRldj4NCj4+Pj4gLS0tDQo+Pj4+ICAgIGRyaXZlcnMvaW5maW5pYmFuZC91bHAv
cnRycy9ydHJzLmMgfCAyICstDQo+Pj4+ICAgIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigr
KSwgMSBkZWxldGlvbigtKQ0KPj4+Pg0KPj4+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9pbmZpbmli
YW5kL3VscC9ydHJzL3J0cnMuYyBiL2RyaXZlcnMvaW5maW5pYmFuZC91bHAvcnRycy9ydHJzLmMN
Cj4+Pj4gaW5kZXggMzY5NmYzNjdmZjUxLi5kODBlZGZmZmQyZTQgMTAwNjQ0DQo+Pj4+IC0tLSBh
L2RyaXZlcnMvaW5maW5pYmFuZC91bHAvcnRycy9ydHJzLmMNCj4+Pj4gKysrIGIvZHJpdmVycy9p
bmZpbmliYW5kL3VscC9ydHJzL3J0cnMuYw0KPj4+PiBAQCAtMjU1LDcgKzI1NSw3IEBAIHN0YXRp
YyBpbnQgY3JlYXRlX2NxKHN0cnVjdCBydHJzX2NvbiAqY29uLCBpbnQgY3FfdmVjdG9yLCBpbnQg
bnJfY3FlLA0KPj4+PiAgICBzdGF0aWMgaW50IGNyZWF0ZV9xcChzdHJ1Y3QgcnRyc19jb24gKmNv
biwgc3RydWN0IGliX3BkICpwZCwNCj4+Pj4gICAgCQkgICAgIHUzMiBtYXhfc2VuZF93ciwgdTMy
IG1heF9yZWN2X3dyLCB1MzIgbWF4X3NnZSkNCj4+Pj4gICAgew0KPj4+PiAtCXN0cnVjdCBpYl9x
cF9pbml0X2F0dHIgaW5pdF9hdHRyID0ge05VTEx9Ow0KPj4+PiArCXN0cnVjdCBpYl9xcF9pbml0
X2F0dHIgaW5pdF9hdHRyID0ge307DQo+Pj4+ICAgIAlzdHJ1Y3QgcmRtYV9jbV9pZCAqY21faWQg
PSBjb24tPmNtX2lkOw0KPj4+PiAgICAJaW50IHJldDsNCj4+Pj4gLS0gDQo+Pj4+IDIuNDAuMQ0K
Pj4+Pg==
