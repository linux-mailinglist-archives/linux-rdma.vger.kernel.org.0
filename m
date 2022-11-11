Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2024625367
	for <lists+linux-rdma@lfdr.de>; Fri, 11 Nov 2022 07:10:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232471AbiKKGKd (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 11 Nov 2022 01:10:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232483AbiKKGKc (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 11 Nov 2022 01:10:32 -0500
Received: from esa10.fujitsucc.c3s2.iphmx.com (esa10.fujitsucc.c3s2.iphmx.com [68.232.159.247])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92D5D5F84E
        for <linux-rdma@vger.kernel.org>; Thu, 10 Nov 2022 22:10:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1668147030; x=1699683030;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=2SGiScVMLlNnAj8eam1t37UzpU/IwtRsam3qX07AbTQ=;
  b=tlcOvFDlrcd5Imrq+QIpZ9gwEqSmQ/27QxLlhhES0E4h1jKN0lCFwxDF
   CTmatXj36oqvmU8/SfG+fOq4rf9Iqo3e6BroLlH+dN76P+VRja7WCAPeU
   wFidDcDm/dKE7djrZGJGyfEs6b+LhrE3mN8TNfoSMUI3bJQVh51hX+bTk
   LlOb7knfmVBPy5pNExmzG3sjWoWT4Bo+2uCbc/WurdhNcGF+rBFuO/cNR
   yJpxtIN+DP7b50ytL8VUlmfDnHfinwZt5P09zrjDt4l2ICyMB2Oz++z/d
   c2dfY7ME0CWkDtt+u73BOZojwWtR+wZFgKxesah6BEcYhFEGeUC1+rJnv
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10527"; a="69888797"
X-IronPort-AV: E=Sophos;i="5.96,156,1665414000"; 
   d="scan'208";a="69888797"
Received: from mail-os0jpn01lp2111.outbound.protection.outlook.com (HELO JPN01-OS0-obe.outbound.protection.outlook.com) ([104.47.23.111])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Nov 2022 15:10:25 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RFDgaC7b0yn6e81F0zgdvTaHwHBOYQ3NJzIl1u9N9veyxgrf7P7w4wxh4M7dYv5/pcYywprsoAC+6mqaxzRNYb0yaox1OtLIFO0tYKyKiCOUPSRs+fBZpxvUoFFL1htNuCMEUhvX2gc9NYb2hUiWfZC27VPOjz2MqTV5mm68tIdfGJmp9Rja8K7xUbKfv8266AU9QAPYjEiw4yeQe+vl1Y9iocOIaKaxQE43CNV32YJzCMUrLNUwKCm4IsERLTBNhGt902nxmVryUFocZAHKokQsBFESm6HAxMQhu3yavWV06l7Hg+PgbZ0tZx2lAK4C69pLtf5IWp5oWadzzVQFQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2SGiScVMLlNnAj8eam1t37UzpU/IwtRsam3qX07AbTQ=;
 b=Zm42w/FM5MSSR/my7QOIWL0SMEjRNIA+Nm3PvZSWYBM4Z9Z1pcBN+HmGUt65l2bdKqMXyLjKHmAvxK7p4PvOKtVYk7rLJFluHR9oBeUitE2FQQdbP6LzXWv3UNI/eRvyPX6le7xcGrmuUoPwwSeVe2JOouhtaeqnfn8Xwo2oqBEJ8BgCBsQ/1sFGNIr5IXyCCrNw3hhfhci/4e+NT/oDy4I0uEB9ZVbbVz4kA83sZVWQ727rAvzhFs81eyOxVkXjOE554wwv0OjfKqcjz4YBkqkaW0ZdWX+hy/1Y0V84wvf/miqfa2DBZqE+a0aV+SDBsO3xaG5w9rb/Wp3OqludAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from OS3PR01MB10390.jpnprd01.prod.outlook.com
 (2603:1096:604:1fb::14) by TYCPR01MB10311.jpnprd01.prod.outlook.com
 (2603:1096:400:1d7::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.13; Fri, 11 Nov
 2022 06:10:22 +0000
Received: from OS3PR01MB10390.jpnprd01.prod.outlook.com
 ([fe80::6c12:df68:ca6:7522]) by OS3PR01MB10390.jpnprd01.prod.outlook.com
 ([fe80::6c12:df68:ca6:7522%5]) with mapi id 15.20.5813.013; Fri, 11 Nov 2022
 06:10:22 +0000
From:   "lizhijian@fujitsu.com" <lizhijian@fujitsu.com>
To:     Yanjun Zhu <yanjun.zhu@linux.dev>, Jason Gunthorpe <jgg@nvidia.com>
CC:     Bob Pearson <rpearsonhpe@gmail.com>,
        Leon Romanovsky <leon@kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Zhu Yanjun <zyjzyj2000@gmail.com>,
        "yangx.jy@fujitsu.com" <yangx.jy@fujitsu.com>,
        "Yasunori Gotou (Fujitsu)" <y-goto@fujitsu.com>,
        "mbloch@nvidia.com" <mbloch@nvidia.com>,
        "liangwenpeng@huawei.com" <liangwenpeng@huawei.com>,
        "tom@talpey.com" <tom@talpey.com>,
        "tomasz.gromadzki@intel.com" <tomasz.gromadzki@intel.com>,
        "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [for-next PATCH v5 00/11] RDMA/rxe: Add RDMA FLUSH operation
Thread-Topic: [for-next PATCH v5 00/11] RDMA/rxe: Add RDMA FLUSH operation
Thread-Index: AQHY0jWKfhUFQlLLK0eS5npEn6TuzK4kSPYAgBUC+ACAACdjgIAAC9yAgAAE8wA=
Date:   Fri, 11 Nov 2022 06:10:22 +0000
Message-ID: <9fa30c8b-cb8d-efec-5896-b96177929d08@fujitsu.com>
References: <20220927055337.22630-1-lizhijian@fujitsu.com>
 <Y1wX8n9R7dkLo0KU@nvidia.com>
 <a37814f9-ed8a-d70a-3024-466700276864@linux.dev>
 <00a3797c-9759-d4ec-6d6f-8f157cd2a220@fujitsu.com>
 <b9f3550a-6fbc-b279-22a3-50285da82e5d@linux.dev>
In-Reply-To: <b9f3550a-6fbc-b279-22a3-50285da82e5d@linux.dev>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS3PR01MB10390:EE_|TYCPR01MB10311:EE_
x-ms-office365-filtering-correlation-id: 2c92f751-6da1-4f7c-d597-08dac3ab6a8a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 6Dg32p21r0TkkP6PVdwjqEde5hTIM71Q7R46bd1ycXgNwqnSTeIlBHcreoycK92XfOHJwDAPKWoC1iql4e6TaQmrRatx8jPMvdR/14lxt1xagAs6ULjO7CPrSr4BJnDnrmgcBIg4ftc2i5FBiSGvt4yLn0sRluk9FxMR2ZWMDpROD25X6FqVCA7ddGYGvcd7Q0eettFrDnthiS/2uLGFCpCHRJA908D9SNqalEpWEmqg47d06te8LnXaS9zOnNnwANQgE3qnGcu/RQlvpuE4W9vCF2hiJrhkyHfu0evDQTn0FAFn/z61Zu5pDbpxOZskWc+3PH5Q0c9bZRwd5aZ+xKkD8cptj5NT8fS6UxC2Trbjati+/XB7rCTIfDEtwE0REofnRMYP6VzhBnzZ4TtkclY75a596P2WnNlsaIEVyu0D0uQCU6QPMI8QPkD0lelFSOOYZMZwPUEYeeuYQGx8wSfxr9k1X7j0tlXriluSBwBFqVe2/wwbhQYoeEHu8+XdCcfLmhsWSWmQapcMrybCtcaqA8lvvgWFF+QzD126cB6nbqhgvynjs53fOZRf+wuUX9lj5yBis89MGfsVK9EiiiM0GjrgP6ts6yrVgsqBrEjt4hdOQvPRmLs22QRm/Qmc0bDN0v1WCq92LOxpj9tjdp9hT4S52LQFaVMz4hOZyOYQTGscLh4WuvBdIoEcZCIC0x4jHjOTYeRnKa2J/VWtsZWH4OeYQPF0HwWQNoWp9jrarZ8PFNcc6KkK3k6q2lBb15kdwgh60dlvOCNUPF0Ox6lULt95JW7WnOerKosvKQZ1s1KJVK0FD2ahl2DlOzQ3GB6oD2TAlPPWRp2QEn1yhe+IXF0tXWfj49tNlRw6IcMj6401Z8rPc4D365GgRyRYADhp5YSSPCiMeyQM2jW1FA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS3PR01MB10390.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(346002)(366004)(376002)(396003)(136003)(1590799012)(451199015)(186003)(5660300002)(66946007)(66556008)(76116006)(38070700005)(8936002)(31686004)(7416002)(41300700001)(38100700002)(82960400001)(4326008)(66446008)(66476007)(2906002)(8676002)(122000001)(64756008)(91956017)(6512007)(71200400001)(53546011)(26005)(86362001)(85182001)(54906003)(110136005)(36756003)(316002)(83380400001)(6506007)(31696002)(1580799009)(2616005)(478600001)(6486002)(966005)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?YnplSWV1eEFzY29yZ0xtWXVsRVBtMUltdENXN0NjRjhFR1RYT3hqUFQ1NlF4?=
 =?utf-8?B?RkwxcEo2T1FMN216Y1pCdjgwTXN3YWdxanlibW5WNFZkSUNXZng0RUVoR1po?=
 =?utf-8?B?YjZPOTZFcGVMQlpuQjBwUkpBSmhqeHZBTDQvNE1UU3BBM0JRTStFWTU3Mlpx?=
 =?utf-8?B?RnlHbmZYV05FbFczaGFsLys0MFh0a3dUbjh0aFJSUlRlUlg0TDM1ZUJWZUJ3?=
 =?utf-8?B?KzVudForay9nM1N0bHdqSHQ5RDYzMHhKcDMyU25QS1NLSHNqYThtNlNVQlhw?=
 =?utf-8?B?L2VxbkMycEdLLzl4U2lqZDZ1UWE5ak5EQWFhVXRqcVRTMFcxUTMvWkEzby81?=
 =?utf-8?B?Skd1RWxvVHpQcnoydXRDL2xFVXV3bVR1TU5McWZ5clF6ZlBuc1dPak00blU2?=
 =?utf-8?B?cmZMMzdXbG82aENHWWRqb1BkRzh3SlQzbGI2YW03MlBXNDVPOFFGUURCNHRP?=
 =?utf-8?B?ZUtIelNEVGlPakxvU1pHZHZqNm5BMkg2M1ZMYmdaVHhBczNsSHFUN2o4N3VH?=
 =?utf-8?B?RjgzNXNzR0lwUjNjOXBKdFpvTUpWclBhVm8wRy9qVy9UK3RnMXVvRERLVUF6?=
 =?utf-8?B?ZGhFVG5IQTdYMGg0UENQSE5MSjhNMEpBa3QwTGRMTE1KaHI4SE5pTTc3YXRv?=
 =?utf-8?B?VXRQOFF2MkNjKzk1bFIrSm0vUkJtVUptNlR0TWxKaElqbTR3ZmQ0eWV1bVBN?=
 =?utf-8?B?QVA5c0I0MmVlaER1cHNWSWpPRkU4cWxOTjRYQllFSmIyVDI3VTlPbzhLdkxC?=
 =?utf-8?B?dGFiczNWNjVVRWtpV05vbUVLOXJRRXV6L0FWZWN4bEdpYXJZS0NINWgyQ2ZD?=
 =?utf-8?B?bFpFMGtYZTcxeTVQV29VUEJycTdudzJURGhrWTMvaVNyd2FxSTRtcFBCdnFt?=
 =?utf-8?B?RkZCZ2dVSUZaUnM3QzlZRFZIMDJ5bXNKRmd0dFNtMkc5NDlKaTgxK3hzYkxn?=
 =?utf-8?B?ZDlUT0JhMENJY1pGRzloZDRoU1BRK01RVDkwV2x3VFBnclZUcmJhK1M1L0FS?=
 =?utf-8?B?OWxDeU42cklpdTkvenduVUwrTER4V1M2MGU3Z0xJY3YrVndrQ1pUTGR6N1Fz?=
 =?utf-8?B?c1BnZWpDTDBSenF6ZjlDWlRER1c0eHpsSWxnODh4bUR2SGQ5UXNHb1gwemc4?=
 =?utf-8?B?enl0bUxhNnlZdk9ud0Nyakl4SVRsUytLbk92c0JWWDFhRXZhcWxKb25lS1ow?=
 =?utf-8?B?Nm43aE1EbjVmOGFaZHc3bXRsYmIrVnVPSXdSYVlMYkhXRVpXckFmYnpBdXNu?=
 =?utf-8?B?NnM4SlMxSGNnc2w4dTgrQXhYT21PQnJoUzdVUWhCZVRkaEVLaVJhQXBVdVQy?=
 =?utf-8?B?cXNyUkxXU2pBVDVSNmhDMlIzbWM1aFFaM2JpWE1ieE56aEpsNTBGKzRSQndY?=
 =?utf-8?B?V3kvUkx4VjRVcUNhNHNsVTN0QStxN2hSTk1wRllXbVhiNm1DSDFMTFhTeFc2?=
 =?utf-8?B?L044RjhXQ1luWEtFQVZUTVdLakJGOFpsQ3pXZmNZUFFqU1N4QkZjM09TWEE0?=
 =?utf-8?B?V1BZUHdrY29GVVduemRLczQzeGphT2EySlJhS0ZBSHhheFFtV1BMWDZsdjk2?=
 =?utf-8?B?YU9TTXZ1RWlydlBEcUpsbVVXMHllbHg1ditTNGNvVFBsdnBKSGFwbGNINGF6?=
 =?utf-8?B?MWRTTVVBenl1c0lQTVNKZHNZUWlBRW1VTmIybjMwWFQ4eEtiSFdJMDVzZ01D?=
 =?utf-8?B?S2FBWjJacFpSNmNoRzBuUUFCOHhqTVY4TFNYYTJnSnI0K2k1RnBoelI5ZFpa?=
 =?utf-8?B?bStjRU5CL3NGVURuajNIZ1c3dnNVcFJHUUpmemFlNUZ3d3Mvb1dhN3NFUFlT?=
 =?utf-8?B?QURmTVQzOUQyYStSOVZqOVAySGJkZDFYQTRCdVNra2tuU0xXODc4U2plenNK?=
 =?utf-8?B?cFZCL2F3UnRVR2Myc2xOaHkrZVdublV3bE1EeXpjRmtraUdKdWZZNEkzcUtN?=
 =?utf-8?B?MnlYTGFrYzJNRlZRWTBmajZ1MWtjYm9rckJ0bThFWkJHS1VkVStJWW9IbHlG?=
 =?utf-8?B?djkvYStiaWgrbXRWUFFiSEQ4a1dENUJycVE3RkZGTHBlR2FpUUMySlYyOVZI?=
 =?utf-8?B?QWRHNEhUTUdJeVg3am5nMzhwekNZc291bGlJUnU3V0pORkhjcythNW54OWpG?=
 =?utf-8?B?Vm1xYUlIc2VGdWY0ZUlycDRTaE03TUxHS3VidFB3UmM5QjJIV2hOZnJ3NzZO?=
 =?utf-8?B?YlE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <77B9A94A48592C4093DACB912AFF4B84@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS3PR01MB10390.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c92f751-6da1-4f7c-d597-08dac3ab6a8a
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Nov 2022 06:10:22.0029
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yxKXC7SrjibSJ3Lr4E597lL/AL/X6ZClRsR3KHNEG724uYIukhd7sgztIoC8rpHzZYRQIUHCqv3bpXzqc1yr9Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB10311
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

DQoNCk9uIDExLzExLzIwMjIgMTM6NTIsIFlhbmp1biBaaHUgd3JvdGU6DQo+IOWcqCAyMDIyLzEx
LzExIDEzOjEwLCBsaXpoaWppYW5AZnVqaXRzdS5jb20g5YaZ6YGTOg0KPj4NCj4+DQo+PiBPbiAx
MS8xMS8yMDIyIDEwOjQ5LCBZYW5qdW4gWmh1IHdyb3RlOg0KPj4+IOWcqCAyMDIyLzEwLzI5IDE6
NTcsIEphc29uIEd1bnRob3JwZSDlhpnpgZM6DQo+Pj4+IE9uIFR1ZSwgU2VwIDI3LCAyMDIyIGF0
IDAxOjUzOjI2UE0gKzA4MDAsIExpIFpoaWppYW4gd3JvdGU6DQo+Pj4+PiBIZXkgZm9sa3MsDQo+
Pj4+Pg0KPj4+Pj4gRmlyc3RseSBpIHdhbnQgdG8gc2F5IHRoYW5rIHlvdSB0byBhbGwgeW91IGd1
eXMsIGVzcGVjaWFsbHkgQm9iLCB3aG8NCj4+Pj4+IGluIHRoZQ0KPj4+Pj4gcGFzdCAxKyBtb250
aCwgZ2F2ZSBtZSBhIGxvdHMgb2YgaWRlYSBhbmQgaW5zcGlyYXRpb24uDQo+Pj4+DQo+Pj4+IEkg
d291bGQgbGlrZSBpdCBpZiBzb21lb25lIGZhbWlsaWFyIHdpdGggcnhlIGNvdWxkIHJldmlld2Vk
LWJ5IHRoZQ0KPj4+PiBwcm90b2NvbCBwYXJ0cy4NCj4+Pg0KPj4+IEhpLCBKYXNvbg0KPj4+DQo+
Pj4gSSByZXZpZXdlZCB0aGVzZSBwYXRjaGVzLiBJIGFtIGZpbmUgd2l0aCB0aGVzZSBwYXRjaGVz
Lg0KPj4+DQo+Pj4gSGksIFpoaWppYW4NCj4+Pg0KPj4+IEkgbm90aWNlZCB0aGUgZm9sbG93aW5n
czoNCj4+PiAiDQo+Pj4gJCAuL3JkbWFfZmx1c2hfc2VydmVyIC1zIFtzZXJ2ZXJfYWRkcmVzc10g
LXAgW3BvcnRfbnVtYmVyXQ0KPj4+IGNsaWVudDoNCj4+PiAkIC4vcmRtYV9mbHVzaF9jbGllbnQg
LXMgW3NlcnZlcl9hZGRyZXNzXSAtcCBbcG9ydF9udW1iZXJdDQo+Pj4gIg0KPj4+IENhbiB5b3Ug
bWVyZ2UgdGhlIHNlcnZlciBhbmQgdGhlIGNsaWVudCB0byByZG1hLWNvcmU/DQo+Pg0KPj4gWWFu
anVuLA0KPj4NCj4+IFllcywgdGhlcmUgd2FzIGFscmVhZHkgYSBkcmFmdCBQUiBoZXJlDQo+PiBo
dHRwczovL2dpdGh1Yi5jb20vbGludXgtcmRtYS9yZG1hLWNvcmUvcHVsbC8xMTgxLCBidXQgaXQg
Y2Fubm90IGdvDQo+PiBhaGVhZCB1bnRpbCB0aGUga2VybmVsJ3MgcGF0Y2hlcyBhcmUgbWVyZ2Vk
Lg0KPj4NCj4+IGFuZCBpIHdpbGwgcG9zdCBhIG5ldyB2ZXJzaW9uIHRoZXNlIGRheXMsIHdvdWxk
IHlvdSBtaW5kIGlmIGkgYWRkIHlvdXINCj4+ICJSZXZpZXdlZC1ieSIgaW4gbmV4dCB2ZXJzaW9u
ID8NCj4gDQo+IFJldmlld2VkLWJ5OiBaaHUgWWFuanVuIDx5YW5qdW4uemh1QGxpbnV4LmRldj4N
Cj4gVGhhbmtzLg0KPiANCj4gQW5vdGhlciBwcm9ibGVtLCBub3JtYWxseSByeGUgc2hvdWxkIGNv
bm5lY3QgdG8gcGh5c2ljYWwgaWIgZGV2aWNlcywgDQo+IHN1Y2ggYXMgbWx4IGliIGRldmljZS4g
VGhhdCBpcywgb25lIGhvc3QgaXMgcnhlLCB0aGUgb3RoZXIgaG9zdCBpcyBtbHggDQo+IGliIGRl
dmljZS4gVGhlIHJkbWEgY29ubmVjdGlvbiBzaG91bGQgYmUgY3JlYXRlZCBiZXR3ZWVuIHRoZSAy
IGhvc3RzLg0KDQppdCdzIGZ1bGx5IGNvbXBhdGlibGUgd2l0aCBvbGQgb3BlcmF0aW9uLg0KDQoN
Cj4gDQo+IERvIHlvdSBjb25uZWN0IHRvIG1seCBpYiBkZXZpY2Ugd2l0aCB0aGlzIFJETUEgRkxV
U0ggb3BlcmF0aW9uPw0KPiBBbmQgd2hhdCBpcyB0aGUgdGVzdCByZXN1bHQ/DQoNClllcywgaSB0
ZXN0ZWQgaXQuDQoNCkFmdGVyIHRoZXNlIHBhdGNoZXMsIG9ubHkgUlhFIGRldmljZSBjYW4gcmVn
aXN0ZXIgKkZMVVNIQUJMRSogTVJzIA0Kc3VjY2Vzc2Z1bGx5LiBJZiBtbHggdHJ5IHRoYXQsIEVP
UE5PU1VQUCB3aWxsIGJlIHJldHVybmVkLg0KDQpTaW1pbGFybHksIFNpbmNlIG90aGVyIGhhcmR3
YXJlcyhNTFggZm9yIGV4YW1wbGUpIGhhdmUgbm90IHN1cHBvcnRlZCANCkZMVVNIIG9wZXJhdGlv
biwgRU9QTk9TVVBQIHdpbGwgYmUgcmV0dXJuZWQgaWYgdXNlcnMgdHJ5IHRvIHRvIHRoYXQuDQoN
CkluIHNob3J0LCBmb3IgUlhFIHJlcXVlc3RlciwgTUxYIHJlc3BvbmRlciB3aWxsIHJldHVybiBl
cnJvciBmb3IgdGhlIA0KcmVxdWVzdC4gTUxYIHJlcXVlc3RlciBpcyBub3QgYWJsZSB0byByZXF1
ZXN0IGEgRkxVU0ggb3BlcmF0aW9uLg0KDQpUaGFua3MNClpoaWppYW4NCg0KDQo+IA0KPiBUaGFu
a3MgYSBsb3QuDQo+IFpodSBZYW5qdW4NCj4gDQo+Pg0KPj4NCj4+DQo+Pj4NCj4+PiBUaGFua3Ms
DQo+Pj4gWmh1IFlhbmp1bg0KPj4+DQo+Pj4+DQo+Pj4+IEphc29uDQo+IA==
