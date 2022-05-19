Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E617152CF37
	for <lists+linux-rdma@lfdr.de>; Thu, 19 May 2022 11:21:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230011AbiESJVJ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 19 May 2022 05:21:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235981AbiESJUs (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 19 May 2022 05:20:48 -0400
Received: from esa4.fujitsucc.c3s2.iphmx.com (esa4.fujitsucc.c3s2.iphmx.com [68.232.151.214])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2869A76DD
        for <linux-rdma@vger.kernel.org>; Thu, 19 May 2022 02:20:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1652952047; x=1684488047;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=75g59z9rVPK2FXwoVwZy6LgorZBk/ejOUXlDDkcHIB8=;
  b=iwms03qIZ9x+iVF3ZtSy43ivSrYf8SclHXEmAvVmMSUf/mBgK4BGAqDO
   KUPf9HReMtvkmwDDwqqPAT9rwvc12fwc0AN9Eqd1QB0X+xNnFDd9O/NUt
   9znkRkJBlXsgWkB5w46ILfRf1E4GALxhlH4HysEs969oOp3/ctJ/Yc35l
   iyhxDNLQQfx7OyqbJROpQtLUdVJGJVZUmpdlB5HvDcLM8GU9wvhFAsiCt
   LoE1IPTmOSAlRAb68fM9bC0LhT1d0EQuus1TEvKQr/0w2+jicZD5z+WCF
   EABZH1b3o9USXyxSpErnp/FCFp0xpRhjPFHgQO586Ex2LrGPpBb990JHP
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10351"; a="64051740"
X-IronPort-AV: E=Sophos;i="5.91,237,1647270000"; 
   d="scan'208";a="64051740"
Received: from mail-os0jpn01lp2105.outbound.protection.outlook.com (HELO JPN01-OS0-obe.outbound.protection.outlook.com) ([104.47.23.105])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2022 18:20:42 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=czcE1OTuTH/swZ/m4Vkli8Ja7AV4duK3mDq+ltDspnLf0CuS0r13qldnknn+KOKZm/A8SxvbIE98NlB/Fn98+vHWEtcmWO9KTud+6ynjcMwe5Ka2je7W7Rxr4qeKOXJeP1PNypBzk9sJHhghLOQKjZ+ei2UEgfyjnyGLHIrLGhc/592GtFVjpYlod+zwUjPJmZlu507uvNt7/ncBJRxOmk0sfuRs9nmjHm8e9EaIIQRlhWgQe4tAGBlACKsOB51CdPy8wVqD2Z9JFPtLn/2YF1QXY6jwg73Z7F/VZlTA/llrhFNch7LMiWTDl2cL0whrY0WXg2NaVSeb9nYZuA6lmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=75g59z9rVPK2FXwoVwZy6LgorZBk/ejOUXlDDkcHIB8=;
 b=L+imdN86QXbYOitXNrCpbaZKEDjimS90K1A7tu0BCWC47kw4A7+Gp8tRWiAyF9Kc2jNHkLomZhv9iCCFe380LnwVMBvrgbtiIaSDNdIqQ11KzK5q7mIK6hmVcH+JRHRmcrICusD9ZNZXISD7It2v/LaPxx/yXFgkAmCIZTEMG9XgVnHWu69V0Hh3rOqNYqk+fM+sjkCvJEcI62exUE2Himh3pTJY7QkxehVo0iyT8nCFzeUIXWKK2LJazboxKSu3nf4zta6Wq72gVuOzPhk227mYy6I4FfIFkBvDFBjbZGLpK9TRHsvelsD+KQq/dVd+7Z6YLtKvh4klKJ8eCG4r+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=75g59z9rVPK2FXwoVwZy6LgorZBk/ejOUXlDDkcHIB8=;
 b=HPH1OFl2kRrqo0ouvtjafPKEzVZtuNoGS6bEo+MAXtWNTWeuzYEXW2tZ5qfMvt6cR1V68XKbUv5eEvMQ/WgueIlLVjaA3m7Hhljhf+Q7gWFwOLAf4CUnoWIEtdW+wHCTnzaH3MUvbB1UMutwPQlVhasrqG0yYjLUB44msFGZOdY=
Received: from TYCPR01MB9305.jpnprd01.prod.outlook.com (2603:1096:400:196::10)
 by TY2PR01MB5035.jpnprd01.prod.outlook.com (2603:1096:404:111::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.16; Thu, 19 May
 2022 09:20:39 +0000
Received: from TYCPR01MB9305.jpnprd01.prod.outlook.com
 ([fe80::6012:5658:1673:1e91]) by TYCPR01MB9305.jpnprd01.prod.outlook.com
 ([fe80::6012:5658:1673:1e91%3]) with mapi id 15.20.5250.018; Thu, 19 May 2022
 09:20:39 +0000
From:   "lizhijian@fujitsu.com" <lizhijian@fujitsu.com>
To:     Chengguang Xu <cgxu519@mykernel.net>,
        "zyjzyj2000@gmail.com" <zyjzyj2000@gmail.com>,
        "jgg@ziepe.ca" <jgg@ziepe.ca>, "leon@kernel.org" <leon@kernel.org>
CC:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH] RDMA/rxe: goto error handling when detecting invalid
 opcode
Thread-Topic: [PATCH] RDMA/rxe: goto error handling when detecting invalid
 opcode
Thread-Index: AQHYa1tgGENCwdSENUWUlxgPPGGJjq0l7GIA
Date:   Thu, 19 May 2022 09:20:38 +0000
Message-ID: <4d3e809c-2bc0-6e8a-2f78-726bee10a937@fujitsu.com>
References: <20220519083049.2259564-1-cgxu519@mykernel.net>
In-Reply-To: <20220519083049.2259564-1-cgxu519@mykernel.net>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 00813e34-211f-4cf1-53f7-08da3978d6f0
x-ms-traffictypediagnostic: TY2PR01MB5035:EE_
x-microsoft-antispam-prvs: <TY2PR01MB50355C561811FD87105F8161A5D09@TY2PR01MB5035.jpnprd01.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: RTtZDtdK7ebUuHmCK6WROtMSMfRblHQgEJ26kV0KxuL1J91fVoyLdG70YMj5GZ4dsFSHQ6PR1lYp8wFCl/qfYLUKiUyNC0V2lQtxvLLdf/bPHxoxElLtmjaYr/ez5HePhfn6v3Xlt7gZBE0CNg8bE6LuNxeT+gzfaPnDmDGyjfOEyKgxyGUJ+97TKCOm7ETtjRQyRFpSs1lKxkLxRzsIWy8lDmE0w/GBImzAwiRg/6DD65lo2ljIi+ubzrplimLusbFXZ5haU/0fTfgH4LUdHxAIExNJ+FTTeIOOkREbXXYHCz/W5EEHllEhCOUMav67VA3Or8EBG4Mw9TZwrz5VQfGe5WwxFxoeNgcAdrrPpVzZ8IrEbv5XJFEDKcGK44XdKgRRRfjLQZ7jrbUvMDFQz4QY0Fn/ZdxI56k93ySYf93akPIO4Ee+4+3DzCe7ZUVgdBm7C7d0WdvleF2eON7Y7KeZ5JSPak8qg6rBckbcVNeqmmUr/0MrXvo9SUU6bLtL/4qbi3Z0mVUKYnRCAo+ZZlNdb0XG7ACmOSaG7vdAapXcOBnVSVqxxQnAqeq7mh+6+2K4f/RexdXj3Jlp2CUzP8hC9TeXb1MSgPMfwdDuwTdsH5f5yZoy1/fDFjXYQLRd7Y/GblYGehs0rZAaSjI3hmi5SFpSlwvYg/D8E13fEqzgzUi/euAG9YyBTHa8f2l770yGr7oJY3pqynBVA1lHstuGgc9dxcjMCrH1unvSN40QuHnVRlbOZf/uXKFFcRbtXj5aMgjEEHZQKsWFE30GHugkHqvF6LoP3Q0jv7LVbqS0WyXbaVROUOuGXyWlRFJw7R0nH26U7P2WxCx5x0TM9VmO/7pmGovotGoVBOMthSs=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB9305.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(316002)(4326008)(85182001)(31686004)(38100700002)(66476007)(122000001)(31696002)(38070700005)(36756003)(186003)(91956017)(66946007)(26005)(2906002)(66446008)(8936002)(4744005)(6512007)(6506007)(53546011)(64756008)(66556008)(110136005)(71200400001)(966005)(6486002)(5660300002)(508600001)(86362001)(83380400001)(2616005)(76116006)(82960400001)(8676002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?K1A1UDgwbkhXYy9Id2FtYWVtdnpGc0hYczVmNE4yb0grc2Z4Tkw3ZHV3M1Zi?=
 =?utf-8?B?Sldnb0psbk5UWHd5c3RKUTMyaFN4dWxLMEFCdmpnNXFSbnJLSzJEdkFheGN6?=
 =?utf-8?B?UEtua1dmSWVEbnZHMFJGSU9BTkVxWkd3cm1zcjRsVXMrS3NvSU5KdFQ4V1o2?=
 =?utf-8?B?VlQ2RmFHVnN6L2dqOWZaakFBeDA1c2RGTnJKZFNBbXpBZ0I0UU5lZWFxRXVt?=
 =?utf-8?B?VmM1NTcwd0Zvdks5ajZaOEp1VUpxWi83Zkp1TytyWldRWmR5U01yYW94RWdB?=
 =?utf-8?B?V0U5TVUrSEd5aTRLWmw0ZWlnK2dmZmFJMDYwWVdWTmxudGk4U0x5eFNGM29u?=
 =?utf-8?B?YzN2L1JsOGdVRDZVQ1NFUmZWZ3pCQ1BmdVZUOW0ycmczQkZ0NE1UbzdPanR2?=
 =?utf-8?B?VjJ1TmYyTTJyUjlXbjI4dnZ1b0Y3U2pib0RwRDU2b1NoQjcrNmgwYWZFSEcz?=
 =?utf-8?B?R0hIZVp4NlErYnMxUmdGVDFyalNWZW5OR3dqRWl0VzZwWlppUUtyaU5Vckly?=
 =?utf-8?B?bkFlS2p4WVZ5SEh2b3kvc3JjZG9LMzB3STRNQ0QyVHVCOTloanA5ZThQa05V?=
 =?utf-8?B?ckpCVWs2RHR4cDkxY3JzczFzZVhLcFFpVThybnpwUkxWdTI2VlVWNERJVkJV?=
 =?utf-8?B?ZUQ0Y3VlL3hWbkY2dUN6bjdWVVlkUDFrUVJCK0dkUmtjSk1yeTdkRXFrYlVw?=
 =?utf-8?B?TmxjaXVPUUw3SUNZNCsyRVdaQUh5YUpVemYrZmZNcUZwWktSNStOaWNtZmxv?=
 =?utf-8?B?QnhyU28rUHdkWHhpUVVtdU5pZTJHSWRCVGZPbW51bkNiWER4UXgwalowNjNh?=
 =?utf-8?B?ckxCcUpoSko4T1BqVDJlbU4vcHpGc2g4ZE5nZnBmRG5STm1iZmd5WkFGSG1n?=
 =?utf-8?B?ZVBqRldDblF3V3ZZYm1KNzVSVXVFcXMvMjg1L2tKdU43ajBNb2RnKys0Q3gw?=
 =?utf-8?B?MDE0RWJuRWV2M3ZEbTFDcnNXcm0xbURlY2xBRGErZ1BjdmlNenB6eERmUzUv?=
 =?utf-8?B?aVJ1MGZTeVl0R3FWQmI2UkE3dUxLemhEM0VSV1ZWS2JUWGkzZTFpYXFSQVV5?=
 =?utf-8?B?UkRKWmpHZWV4cWFPR1krR05wRld1akpWZjFlMXZ6Q2VINUphZkZGYVZCR21R?=
 =?utf-8?B?VkJaQnFqSVAxWURmMFpMWGRYUHhjQ3k1L05TU2JBMmg2TUUwcjk5N1pjd0Mw?=
 =?utf-8?B?YkhScHp0bHpybjIwQkZQYUYvbS93b3hGYmI0RDBibWs3ZXVWZ3NBRzdNVmJE?=
 =?utf-8?B?dGpzR1BWQSt6SWpoMURVSEtOeWZxMlZsK2s5bHlnaUhDS3ZYYmFxODExSVBO?=
 =?utf-8?B?aEZ0OFhMN0JZUTZaeGl2eDJ2bkVUMVNyMEVQYVo3MU5BekVsOHNXUEtreFpL?=
 =?utf-8?B?NStWSkJEMXlyQ0hDUTN1Z1VRa2tmRlBzSy9wRDh0anJ4amsyeDhNS2g2MWNH?=
 =?utf-8?B?T3NFVHdIdjhhSEhzMjhaeVJVRnJiR2VhZ0FVbnlIVTlab3ZsZ3h1U09GZE9k?=
 =?utf-8?B?bjg5WUN6ODNQcmJ4MjBGWlJGM2w2OEZCVFM2WjRMWEJtUGhTdWdWdS81ckRy?=
 =?utf-8?B?aVIrRFR4NDRoSlhnSWpVeTVJUnN1VjJTa2VTalEyUm9QRU9BRmpqTkIvcWhz?=
 =?utf-8?B?TjhjMnNBSUdxNUhBTUF0cmRSK2xpeGtqaWo4Z2o1VTA1TzhWTGdrZFA0UUJN?=
 =?utf-8?B?NmhlZzZyUTRuSThFNDBaK2lNaUlMWW45MG92MEpxbmc2V0YwQXZmQWNrallZ?=
 =?utf-8?B?WWFTOUJsYnZEOEg0bXNsWHBGZk9xZVBXekhEWXZlUjRkVWhXTzFaNEQwMEZk?=
 =?utf-8?B?d2NDY0t3N2tjZHpXMlZnMUJvYWk4MDExQit5aVZHSFB0WklKY3VJdlJQUk9x?=
 =?utf-8?B?YzA1RmRtS0VnVWF1aERoZUtmczlTRlFCV2FkRGRWbU13OXFmcWo0RkcyTlF2?=
 =?utf-8?B?NHlZYkphQmhQOCt2L3RWcWk4VGFwVmM2dytLeWZqM005S3BrUk4xN0ZZbzB4?=
 =?utf-8?B?MnNhK0FqSFQvd0tCNDlwejRUTmtoRHhRbm5pN21SVVFDMVJURWdKK0hjL21h?=
 =?utf-8?B?S2RjQm45anBhM0lSSTZRZTNPd2V4ck5oUUdaeVlLWS9WbXRHd0ZuSC9oTVpl?=
 =?utf-8?B?SkcrL2I2b3FKRnhBQ1VoclQ4d2Q1ekt5bkRwN3JHTDR5dHRLWDIyMER0bkFn?=
 =?utf-8?B?M096UEJ5Q0tGeDR4bVc0TnA2UXBFZGFyNGx4UVV4OGZXL2RCdFVmTVc0dHlC?=
 =?utf-8?B?SW42THA3QWNMZ3dKcERxUm5qOGxDTi9nV1M3dFVtak54NStPN3M0WlNtQlMr?=
 =?utf-8?B?emhYdVYxRVpGSUlhYTFRc2lSdy94WUtkRUNsRFppYzJlcEFUY3ljNEc0dmZ1?=
 =?utf-8?Q?54w0r2XCQMudsqGw=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <317E648639055C4F92C7CF052939E5BF@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB9305.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 00813e34-211f-4cf1-53f7-08da3978d6f0
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 May 2022 09:20:39.0810
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GeKEFo41+6lM9q7Ni7Ba5MEYWidnOPSoNUp0rR4sRJCbaChOQmW2VQP71M1sKmry1BtLIcAZxnV12HF3xymOmg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY2PR01MB5035
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

bG9va3MgaXQncyBkdXBsaWNhdGVkIHdpdGgNCg0KaHR0cHM6Ly9wYXRjaHdvcmsua2VybmVsLm9y
Zy9wcm9qZWN0L2xpbnV4LXJkbWEvcGF0Y2gvMjAyMjA0MTAxMTM1MTMuMjc1MzctMS15YW5neC5q
eUBmdWppdHN1LmNvbS8NCg0KYW5kIGl0IHdhcyBhbHJlYWR5IGFwcGxpZWQuDQoNCg0KT24gMTkv
MDUvMjAyMiAxNjozMCwgQ2hlbmdndWFuZyBYdSB3cm90ZToNCj4gQ3VycmVudGx5IGluIHJ4ZV9y
ZXF1ZXN0ZXIoKSB3ZSBqdXN0IHNraXAgZnVydGhlciBvcGVyYXRpb24NCj4gaW5zdGVhZCBvZiBn
b2luZyBlcnJvciBoYW5kbGluZyB3aGVuIGRldGVjdGluZyBpbnZhbGlkIG9wY29kZS4NCj4NCj4g
SU1PLCBpdCBzaG91bGQgZ290byBlcnJvciBoYW5kbGluZyBqdXN0IGxpa2Ugb3RoZXIgZXJyb3Jz
Lg0KPg0KPiBTaWduZWQtb2ZmLWJ5OiBDaGVuZ2d1YW5nIFh1IDxjZ3h1NTE5QG15a2VybmVsLm5l
dD4NCj4gLS0tDQo+ICAgZHJpdmVycy9pbmZpbmliYW5kL3N3L3J4ZS9yeGVfcmVxLmMgfCAyICst
DQo+ICAgMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0pDQo+DQo+
IGRpZmYgLS1naXQgYS9kcml2ZXJzL2luZmluaWJhbmQvc3cvcnhlL3J4ZV9yZXEuYyBiL2RyaXZl
cnMvaW5maW5pYmFuZC9zdy9yeGUvcnhlX3JlcS5jDQo+IGluZGV4IGFlNWZiYzc5ZGQ1Yy4uOGEx
Y2ZmODBhNjhlIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL2luZmluaWJhbmQvc3cvcnhlL3J4ZV9y
ZXEuYw0KPiArKysgYi9kcml2ZXJzL2luZmluaWJhbmQvc3cvcnhlL3J4ZV9yZXEuYw0KPiBAQCAt
NjYxLDcgKzY2MSw3IEBAIGludCByeGVfcmVxdWVzdGVyKHZvaWQgKmFyZykNCj4gICAJb3Bjb2Rl
ID0gbmV4dF9vcGNvZGUocXAsIHdxZSwgd3FlLT53ci5vcGNvZGUpOw0KPiAgIAlpZiAodW5saWtl
bHkob3Bjb2RlIDwgMCkpIHsNCj4gICAJCXdxZS0+c3RhdHVzID0gSUJfV0NfTE9DX1FQX09QX0VS
UjsNCj4gLQkJZ290byBleGl0Ow0KPiArCQlnb3RvIGVycjsNCj4gICAJfQ0KPiAgIA0KPiAgIAlt
YXNrID0gcnhlX29wY29kZVtvcGNvZGVdLm1hc2s7DQo=
