Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA4EF5660CD
	for <lists+linux-rdma@lfdr.de>; Tue,  5 Jul 2022 03:54:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231287AbiGEBvp (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 4 Jul 2022 21:51:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230179AbiGEBvo (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 4 Jul 2022 21:51:44 -0400
X-Greylist: delayed 65 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 04 Jul 2022 18:51:43 PDT
Received: from esa16.fujitsucc.c3s2.iphmx.com (esa16.fujitsucc.c3s2.iphmx.com [216.71.158.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09E2FDF4B
        for <linux-rdma@vger.kernel.org>; Mon,  4 Jul 2022 18:51:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1656985903; x=1688521903;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=YmbmI23iXfCQKRd03OIst/tGiupgthnmUKL++bZaIuk=;
  b=EwC4NDOQnZQq+tQu2ldLU/J2Q/A0iKic+sPNvh55E7xnyj3cvyVNgQ4E
   y/pKkmahS3r2fahyQ4RR32+aldPL1cGelnljfkuLI0IMMPo3huZcAAFJR
   7gAorAD3rmtiB8UA/hVJgk6+uzkULlw2s7X4cPmeX1+BCgD+sHnDKGeaJ
   cff6NNZgvV28osbFdaSEdajGSYsgwZzBQvaq3gGu4n3OpgI0/ctB9pT1Q
   ivwm/RNEdvHAF5e0HgAixODOfXlE7P4LXOdwGtRZS3aiMVWCLOaKGE+Q/
   qpNrrnOuDs64LR9i3Gr02B++sthvrEmrUfejeiN9N2puc/1mU4xB8JcJ0
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10398"; a="59525971"
X-IronPort-AV: E=Sophos;i="5.92,245,1650898800"; 
   d="scan'208";a="59525971"
Received: from mail-tycjpn01lp2174.outbound.protection.outlook.com (HELO JPN01-TYC-obe.outbound.protection.outlook.com) ([104.47.23.174])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jul 2022 10:50:35 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WxNNC6s/yt+8Py5BijizyMof1Vw/HVGNyambXZpO4sFFCJ3ndsIKTYAG7nA4Qi5dT9aAky/fPmK8a2WMW1LkILshAZ7MIAsBpmk7XaZajAmYzuZB+NA3VSVd+8t9qTSZWS6tD4qo0m7qIy/ZCQ23ok0f2D//CVTIong04bIRbD2Onjb8LLznzhtBk6ekwUjyQXFP/06dz6KrjXx89GIbebxQc5TAoCRSNfnsmqWR2WaqlQRY1xHIY8x7FRxbixwPtSVHDuLwrjGt1AVJC9bkkr975E4qftXG+BL1BlmRnWaC4vhAHAbVpmilgUiLP5/YRbSzvy/mvSORoLgkwJJ53g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YmbmI23iXfCQKRd03OIst/tGiupgthnmUKL++bZaIuk=;
 b=nYomP1HNqc3IYNEiAeqyafSsp8OIgdPnysCvRqnlbTdsitHeaDW/49rvUxaV5xGoioj6gnWexYO/3HmhEgRNW20juSE/x9Z0HdEUjbL6EF0SDf4X8mZfqY17x8PyelBLLvWYH4jKRfg2OUb6nLGAj1bzntxGAYrhZxo4L7VWxOKhcK585NCrLxA0xqv0MNaLdASW1ALvnsBMSmwhA86yJ6ZXFQBcjjZ4sSaLsc+Ll3YBysF9+2WLgNMgqS0CXkvPuhUCPggFIPPS8XAK1QDhPTeW8E0oiHcAW4MuBlK1PXAoYSfUR7Ed0HKMb8FM7N0VK+gC1PeP9LeNUmNoHCfg/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YmbmI23iXfCQKRd03OIst/tGiupgthnmUKL++bZaIuk=;
 b=VcQrF4e4RP1e4STJN1JurZVZptjffRhgz+llYLuI6eRUXKSDfinAJ0V2tAVRuIfVKkFX99/F3zjS3Usw5q6fP3yHY5b1VuYL+/7psfgqr/M0zJMg7pAeD+aAIzkBqZE9WBMZ347Mz1D8/sm+IzPaBp6HY/3rTPtXGwjl0gpcPeY=
Received: from OS3PR01MB9499.jpnprd01.prod.outlook.com (2603:1096:604:1c8::5)
 by TY2PR01MB4556.jpnprd01.prod.outlook.com (2603:1096:404:110::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.17; Tue, 5 Jul
 2022 01:50:32 +0000
Received: from OS3PR01MB9499.jpnprd01.prod.outlook.com
 ([fe80::d8d2:d66f:2f3:846c]) by OS3PR01MB9499.jpnprd01.prod.outlook.com
 ([fe80::d8d2:d66f:2f3:846c%7]) with mapi id 15.20.5395.021; Tue, 5 Jul 2022
 01:50:32 +0000
From:   "yangx.jy@fujitsu.com" <yangx.jy@fujitsu.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
CC:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "yanjun.zhu@linux.dev" <yanjun.zhu@linux.dev>,
        "rpearsonhpe@gmail.com" <rpearsonhpe@gmail.com>,
        "y-goto@fujitsu.com" <y-goto@fujitsu.com>,
        "lizhijian@fujitsu.com" <lizhijian@fujitsu.com>,
        "tomasz.gromadzki@intel.com" <tomasz.gromadzki@intel.com>,
        "ira.weiny@intel.com" <ira.weiny@intel.com>
Subject: Re: [PATCH v4 0/3] RDMA/rxe: Add RDMA Atomic Write operation
Thread-Topic: [PATCH v4 0/3] RDMA/rxe: Add RDMA Atomic Write operation
Thread-Index: AQHYUutUn9XU4R6Jekm3O/NqdHUgQq1ussKAgADKnQA=
Date:   Tue, 5 Jul 2022 01:50:32 +0000
Message-ID: <7f5d0a68-4efb-cbc4-6293-f363e5f49f30@fujitsu.com>
References: <20220418061244.89025-1-yangx.jy@fujitsu.com>
 <20220704134519.GA1422582@nvidia.com>
In-Reply-To: <20220704134519.GA1422582@nvidia.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0d3a7fc9-207e-4736-b3a7-08da5e28bf03
x-ms-traffictypediagnostic: TY2PR01MB4556:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: EJIxLEQKcAmuzPI77lHUpm68HgM1J+lsYpYvv50eUuSDcpdBhOqMuICzNtSqozInimoj9DYOUoKWaDvSNhuBVLF3qZRfEZiz+FacfJstJTzK2O2I6g5YJ3xJz/qWjIIbmsEH745a/3fESrIihFWTiqnl0LBIIgXBQvUvtUUsi/LRiM79eZaeE/AvZQ5UWqcoeOmFj+qMW2HPqa3ACQfwcjWM5bPOzL00xkaUugqUyzWvkk3l2tcCEQltou8llvdBWUTICkj0+pZZIbMXHVWkqpeVfkv93Vuj+bza3SiBbI0aE30hwtYKLpxGUZ2IHsNCdYBhNdBCS19l2x08l/CjTPK2PROfAOaIyJX9CzVi9xGsKtoJeZXv01LgL+tbXuVJdy4yY2hJGP2KdZ4N0KOmKuaXG8zW40QowOeZTsmKz6FH/vY2va9euI1cWf449jIz8VnBwqb/KA2I8qCljD15ztLvZscJc9j1jvz0APxRFPzq7MjKgrPouXRFpc1ATLPxYsumAe/gyZW0b4len79X1EXcYPrcUalnmQ8oYCW3eJ/cBSBkof9TNMqdXLixdHW1x5qe1vJZP/3+4kLn+xO+xWCn5eI1h8uB42m/sJncEzZW4b+PrxbBlSdsXtUbbKu312CRJ79QRpn55FavGyFJGeMD9f5oxtHwCuBNRAsdIP7kTjeL/Gj8LS7iYJlFFIPJGsNhtKYMDLCRhlZwuonJ0H0Cjb01XHYsoqc8Kjvi7WnTBZS1LggEAIJaESG2/tkDoSfSuWL86TGAeJxNvWepqnTU2ljzMhw/CXOhzgQsyqKq82KuK36+FdAoEaBKvwLyPJWSBcKbORG30u9zcsaC4m0PSJYc7kzhs8qV5rfBiD7IBj2Et0B1mZlOsiv/HfuD
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS3PR01MB9499.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(346002)(396003)(376002)(366004)(39860400002)(136003)(76116006)(66946007)(8676002)(4326008)(66556008)(64756008)(66446008)(38100700002)(91956017)(54906003)(4744005)(38070700005)(5660300002)(66476007)(31696002)(86362001)(2906002)(82960400001)(122000001)(41300700001)(26005)(2616005)(53546011)(8936002)(6512007)(186003)(6506007)(316002)(6916009)(6486002)(966005)(478600001)(71200400001)(31686004)(85182001)(36756003)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RWVpcklLMHRrNHFGeDBDQTdwQkNnOEhsZGsycEVpbXowYkVjeVBNdjlKaFow?=
 =?utf-8?B?cWpQclhhRXM0Rys5ZzFhdVVtRURWK0l0WW83YXgwNDc5eHVzUTQydWtoWnBy?=
 =?utf-8?B?TW5BRnVVWUxqYU9MK3BoS0ZYWEJEYll4Q2RNSGZpTnM3YjBFaDRLUXZubVBy?=
 =?utf-8?B?a3Azb3VCZEF3NWVOQ1dIQjVPZXF0SnU5Q1JJdnMrWUFsOERxbDZuYTl1ditI?=
 =?utf-8?B?T08zOGpybGhvVTVHRnhxN0tSSjlISUI4OGJja0FSYUdKeC9LbmNycnBka3or?=
 =?utf-8?B?Z0RNaVJreTlOTUZUMmdFMEN4a3F3NENPeFJoWTBXeWpZQTJTRUsvcElteWdT?=
 =?utf-8?B?dDBrME5KK2l4aHVGWjdEZmswVEdZNXZhRkNyT29OQXdTb0pjUEZNeWJJOUxV?=
 =?utf-8?B?ZXZTMDVEa0lEL25Tc2ZtSlBtOHFJY20zeVlKSllPZzNSNk00T204WU16ZjN6?=
 =?utf-8?B?RE9rNlRydnl6QThHL09RbEFZVlpyUnNBWUpRaXpYN0FTcUZLa0s2NG5wZ3RR?=
 =?utf-8?B?dTR0Smh4TjZkK1N4QlFxeU9DM1JrUFgyNHlyeDZVQ2xHajJQc0NsS2ZwYUhr?=
 =?utf-8?B?YnpRSFVaU3lEZlhQNnB4WXFaVUs3T2wrWmFXamNQOTExTjdBa215VGc5am5X?=
 =?utf-8?B?K04rMWJzYU54S215eWh2Q3dlckZiK3h5QjQ5VnJpaU1WNWRETVN2WHJBTGJL?=
 =?utf-8?B?YWcrVzh0VGQ3QVYrYVY2QUpUVmpoNVI2TGwwSEphNnpyT1hqd1RlaGpHOUx1?=
 =?utf-8?B?aVR5cHhORFFpM01FRDRUSkVPSzl5VDBiNGI2eE5HeDVNVGRzUUFpODhXWTJl?=
 =?utf-8?B?Mk9kbUY3dlVBQUV2Z0szMldBR2dPanZqMVVyU0JldG1Rams4ZUx1bUhoeC9i?=
 =?utf-8?B?bTRhL3RXTUs1NTlQbS9aaTdhUVZabzNpN05hMno1cGFicllveUZGdWVuTVFa?=
 =?utf-8?B?czRwcmdiZmpSSHhvMXRaQ3BnTUU5UkJzYkNsbk4vQndMVXNQc2tOb1JSZXZO?=
 =?utf-8?B?R2tSRUE1M0tUT2p0RnR4VGdRUmxOOU9SQzQ1NnpWKzJRczFoaWtrM0ZGejJw?=
 =?utf-8?B?K25oblNWaUJYdXdURWl6bVdFNkY1VWNYWGJEN1p2ZGlKY1dqOUd1eUdNQ0hX?=
 =?utf-8?B?SmRLNTFvcGE0YjFhVnZPUThpYkNqL2h0V0szc3FsZ1kzVW8zaFVFY0plRkRC?=
 =?utf-8?B?TnR1RkQ2dG55SWRnd1ZoQzIra1lwcFdXMjlvWXpPL3YrU2NrSGgzZmJTS2hD?=
 =?utf-8?B?OWtFZDVyQXFDVTRJM0hSWUp1TmxLK2cyWUNmODZaN0M4eXNtWVpXZ3hxVFlI?=
 =?utf-8?B?Wjl4bHptY1hLbTJlU2xYQWZnUjJybUcvVXFRV1N2OTJza1JMdXpncURWQ1hU?=
 =?utf-8?B?RGpXcjBselJSMnlPVVdISjRITHM2YkljZFRrZG03TEtCUTE5YTJtVW9xcXJY?=
 =?utf-8?B?Y3hSbXVKL21MeWMyZzNwVVBWNGE5NXBKUkkyMnNXcDNGbHBQSWxOT3VuZ28x?=
 =?utf-8?B?ZUJOcGIrbmUxbXRHMk1vckIvM2Yza3pyVnUrYndqY1hyUzVSZi9xM0xKV1VF?=
 =?utf-8?B?T3p0T2JzenkrUko0NktGRXNRSlFQVm9aMXozb1phVDdES3A4cTNIdGd4TkN6?=
 =?utf-8?B?R21kMmlBQzByQ3lDbDgvTndKQWpvdzVwQXFVaFYwYUlwblJWTFlyZ09pT2Jp?=
 =?utf-8?B?Q05YcjVySys0dXlpcDdGbzhBSDU1NzE3d2VNdTl0bERhM3lWY0dsQk9nNS9D?=
 =?utf-8?B?a3VUaW9oNFdrOTE1S2p1eXRSSUxEd0k1MVVOUjJEZ1hjTDU1L3NwNEdVaUY5?=
 =?utf-8?B?aERVVlE4MHlUblhIWmRCZyt4dEExaHVzVU1Iai9IUTQrNzRoSy9xWStidU5J?=
 =?utf-8?B?WHVCcHlMSXhNSlFJVS82QjJJQjVVY1dabml6bE94T0NwN0pqZW92Y2pzdm9S?=
 =?utf-8?B?UHBmNXZqbklTZlpTVU9XOXpFT0lLazJMcXFRK3ZMTDh1cUhlL1kzM2VSNXdF?=
 =?utf-8?B?UjZsREovb01jOGlmd050cU1FUVN0clM1d0xPSU8yM1dOVmhEUGVLSEIyaTVp?=
 =?utf-8?B?TEdqWmZwaFIvZTlnYk5wN0ljTnFSTWh2TkNZV3I0TlQ5Sk1NQmxsNGhsSHNE?=
 =?utf-8?B?ano5TzloZVk5TlhRL05VR3pLWkVBcE5zNTA0cldNS2RTNjRjY2h0bTFqRTVC?=
 =?utf-8?B?eEE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F3C8577F95ED4246957B3558581FF1F0@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS3PR01MB9499.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d3a7fc9-207e-4736-b3a7-08da5e28bf03
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jul 2022 01:50:32.2583
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sjyN2vGXfTNsFNfhRlSipQZmroeyjI4jlLADn9MxYXxgDyRPBQae9t7Bi4B10/WNWOS5GjB96WX4kulAe+HcKg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY2PR01MB4556
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

T24gMjAyMi83LzQgMjE6NDUsIEphc29uIEd1bnRob3JwZSB3cm90ZToNCj4gT24gTW9uLCBBcHIg
MTgsIDIwMjIgYXQgMDI6MTI6NDFQTSArMDgwMCwgWGlhbyBZYW5nIHdyb3RlOg0KPj4gVGhlIElC
IFNQRUMgdjEuNVsxXSBkZWZpbmVkIG5ldyBSRE1BIEF0b21pYyBXcml0ZSBvcGVyYXRpb24uIFRo
aXMNCj4+IHBhdGNoc2V0IG1ha2VzIFNvZnRSb0NFIHN1cHBvcnQgbmV3IFJETUEgQXRvbWljIFdy
aXRlIG9uIFJDIHNlcnZpY2UuDQo+IA0KPiBUaGlzIHNlcmllcyBkb2Vzbid0IGFwcGx5IGNsZWFu
bHksIHBsZWFzZSByZWJhc2UgaXQgYW5kIHJlLXRldCBpdC4NCg0KSGkgSmFzb24sDQoNClN1cmUs
IEkgd2lsbCByZWJhc2UgYW5kIHJldGVzdCBpdCBzb29uLg0KDQo+IA0KPiBEaWQgeW91IG1ha2Ug
cHl2ZXJicyBjb3ZlcmFnZSBmb3IgdGhpcz8NCg0KWWVzLCBJIGhhdmUgYWRkZWQgYSBweXZlcmJz
IEFQSSBhbmQgdGVzdCBmb3IgUkRNQSBBdG9taWMgV3JpdGUuDQpTZWUgdGhlIGZvbGxvd2luZyBQ
UjoNCmh0dHBzOi8vZ2l0aHViLmNvbS9saW51eC1yZG1hL3JkbWEtY29yZS9wdWxsLzExNzkNCkJU
VywgSSB3aWxsIGNoZWNrIGlmIHRoaXMgUFIgbmVlZHMgdG8gYmUgcmViYXNlZCBhcyB3ZWxsLg0K
DQpCZXN0IFJlZ2FyZHMsDQpYaWFvIFlhbmcNCj4gDQo+IEphc29u
