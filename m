Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 780046253E9
	for <lists+linux-rdma@lfdr.de>; Fri, 11 Nov 2022 07:39:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230075AbiKKGjD (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 11 Nov 2022 01:39:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232082AbiKKGjC (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 11 Nov 2022 01:39:02 -0500
Received: from esa5.fujitsucc.c3s2.iphmx.com (esa5.fujitsucc.c3s2.iphmx.com [68.232.159.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C719627DDF;
        Thu, 10 Nov 2022 22:39:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1668148741; x=1699684741;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=E7dYepFiaW12tDYpu8dSkskMWpmvsk1OBqMiHXn0E1w=;
  b=AyO7bTr/SofMRKNiPvhKn1HKP85oSdPv1OVMBV/kxlqSipKfbCUYCkYR
   6kz6lSZN1Wf/LAsfqnlHawehYAU8nOGdwCZufvky4uwDDIHEZ+dFaXIBE
   XvWgPtYV5R27xnMn81qhrSD/SkYYf+oMJYJXB4Ya7ezDRQtEb8whakLob
   Ruk9COhZ1zLhoEVB9gKtY7rC+R13hkLh1QoLOQZwfpGa4/etI/zUk/UXK
   IQs8jEfjEWkOvUZYhgYMqAaLInCPVK4sEKhLRtI8dD4wj9D15mUTyNoTv
   HcaT29E7LoTOvxRVNqb4Ox4QZVJ+F/U9wFXjZDT3Z6oVlFKaaMjRpfHlF
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10527"; a="69977009"
X-IronPort-AV: E=Sophos;i="5.96,156,1665414000"; 
   d="scan'208";a="69977009"
Received: from mail-os0jpn01lp2108.outbound.protection.outlook.com (HELO JPN01-OS0-obe.outbound.protection.outlook.com) ([104.47.23.108])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Nov 2022 15:38:55 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KASTXRkp4ONV0AQmU1SBh5H0adaA7ZygFmH2oGT9+85kOiUpkM2LVGJMue3epqwNzQKmELZ/1Ms5FrBhRAMPDKXRaWdIlpOY/lQVk6ZK9wB2EuiAlajLCQL1+fEYMoFAFGodVIas8AvEza5hXFtV1tkZWixRYShwP3A1V1EgiF0/s8oHLS3o9N359xj0E9UXk4L/11j/3c8KJEYwWAjOHCg7Snew0/wDY327poU3c0PN6nJhW0IiHGTnpZc4JScUKZ2BceBw4O9Q5s4SAGm+UUFgZfikEL7jOXDH0IqXJoGsKZ1SjQbd9L56btaffE3vqkHN0Q4MBXOIWw2/59Kxdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E7dYepFiaW12tDYpu8dSkskMWpmvsk1OBqMiHXn0E1w=;
 b=E0Tgk8x2pR2DfzJALvBWIgvlxgdXBDmGZJeheF0K4ZFt/qMaHEkyowp+JVGYbkmrLss3m0kMTIsL2hA+BUOUGt4DH1Z6scbvpEjPeeEZG1c7WPWoZBdZG7zu2rOKwt3GhR1DicRWpbsfNc7syF2ESoVGjV2IoVH2y3FBRJKMsWsHVBw1p/pQkeQnBH8iB68y1+nbpqGM4q0J32TUICYvoXASCBFpgrMnkYPT2VwQm1fXRxfw1jxcHcMq2FRKGnTO4v84hRc9qGb5rLJ2MnWeAmoPj2CVRyhvD6U6KrmoT8zO/fqrAxx9I6/2x1rX5TW6Bq/gA8S7Kp52aB8F9V7pJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from OS3PR01MB10390.jpnprd01.prod.outlook.com
 (2603:1096:604:1fb::14) by TYCPR01MB9909.jpnprd01.prod.outlook.com
 (2603:1096:400:20f::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.13; Fri, 11 Nov
 2022 06:38:51 +0000
Received: from OS3PR01MB10390.jpnprd01.prod.outlook.com
 ([fe80::6c12:df68:ca6:7522]) by OS3PR01MB10390.jpnprd01.prod.outlook.com
 ([fe80::6c12:df68:ca6:7522%5]) with mapi id 15.20.5813.013; Fri, 11 Nov 2022
 06:38:51 +0000
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
Thread-Index: AQHY0jWKfhUFQlLLK0eS5npEn6TuzK4kSPYAgBUC+ACAACdjgIAAC9yAgAAE8wCAAAW+gIAAAjsA
Date:   Fri, 11 Nov 2022 06:38:51 +0000
Message-ID: <84353223-4286-10d2-c358-599ada6550f1@fujitsu.com>
References: <20220927055337.22630-1-lizhijian@fujitsu.com>
 <Y1wX8n9R7dkLo0KU@nvidia.com>
 <a37814f9-ed8a-d70a-3024-466700276864@linux.dev>
 <00a3797c-9759-d4ec-6d6f-8f157cd2a220@fujitsu.com>
 <b9f3550a-6fbc-b279-22a3-50285da82e5d@linux.dev>
 <9fa30c8b-cb8d-efec-5896-b96177929d08@fujitsu.com>
 <7ee2c646-0be0-5a37-83bd-110d8a8717d7@linux.dev>
In-Reply-To: <7ee2c646-0be0-5a37-83bd-110d8a8717d7@linux.dev>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS3PR01MB10390:EE_|TYCPR01MB9909:EE_
x-ms-office365-filtering-correlation-id: 0201b553-1f04-4803-633f-08dac3af6558
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: rKobN1CDoKoQLuKkpjJIAnWLaaX1nnVcGxeeSlo1Kguv460KYjF26vB27B9QC2Ph8WxZU2XzmDSMTUSXY0euHq/BJOoknWF1Nimn2GO/sHl3oGzz2pogn2zkFEMozR2DqVgIrsWSF11694U3QTHPAfcYpbtrN65NOUC7LNQ61MBCZVhqURzSUNtjmLEb4n0hh1NSnNX6S3QTRJcM2TiuPCMvfhhCJIbIZ4RBEkZhs4RYnDr4/L1PL1A1dGVH/oxsh96AQAgN3RCX9cklQTsdTo1qrG3BHGT5TrVslK37jCqZYFS2atuZn4n+ysb9vmdPBiNv83lKqGbdhfvVV8E4wk/U4LpV3aQb2V9goxKsXqeSE7Gg/MifibuUEuZyl6uECaNzIsjE/w8pHDRFEPwa5h0E5v5Abw6i22X4tbFbQbfE2I+0G3T93v9tSUOcKSvO8kSo9WbXgJr9V6VvBzwuLWYrjMisZBM3tWNna2ONhAW54J2K/HNVyIc5zinu9kNUrqH8s38y/uaB/6oJv4U6pFJdqk3M7BBw+qQ4K3/80DDIwLcirpsGvAjByWs0U9yvZ2HQDlA6Knu2gW2nu5jBv6GGY9O9DIrz8BtabRtwDQ9XaNnFP3QXFIP9ypUZp4DfPud2WDH9LFqsDwIMwokunzoB0HT9mHZVuRv4mRSJd1OZkUrdptTeZqbvdW4bPV66qiweLAKaR/gyKN/VANgWdqzA4PlYyEPvBjsT9SsQ59NYjtZHz6L0JXFWH8eJ7HeJ7iGGNFqN5PWq6qB2vJuPO5/MJazXtBae0SPR1fCtNG4g0MA1D2DVEEB44DMKkdhANcLUPh2nzSLdAgrD20ypt94I4Rw18PWQWsK1rVIsB0c=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS3PR01MB10390.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(346002)(136003)(376002)(39860400002)(366004)(1590799012)(451199015)(6486002)(82960400001)(38100700002)(38070700005)(478600001)(122000001)(31686004)(110136005)(54906003)(8936002)(6506007)(1580799009)(316002)(36756003)(31696002)(26005)(53546011)(66556008)(71200400001)(86362001)(91956017)(64756008)(4744005)(66946007)(66476007)(4326008)(41300700001)(66446008)(85182001)(6512007)(8676002)(7416002)(83380400001)(2616005)(2906002)(186003)(76116006)(5660300002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Y1k3bzBEeHF6OUc4bU01bVB3U0hHSm5WTHVFYTZwUFgvZVVrZ0dodVhiekth?=
 =?utf-8?B?cCs0cmlzOGxYZGl4QklyM0g1RmxxeW5OM200ZzJYYlEvN0lOcnEyNjlTVmtu?=
 =?utf-8?B?Njl6N3VxQlFDSEtMdTNoMVpETC9QdkRCcnRtVEp6L2JVdFpqRGN6MTYrdDJr?=
 =?utf-8?B?OTdvLzRWU1ROSjE0TklKcjg1YmtlZjQvZlo2SE1RRFUrdlN1bHdBZ3NhU3hh?=
 =?utf-8?B?MThFRERrSmdzeURxcDYyOEVtNk82MUFWUXB0czUrdmtsMldTeTYxUTJiem4y?=
 =?utf-8?B?LzBYeXNhQ1pIb2Y1elVDMC9LQTVIQkJGUFFEU1NNVWhaMGUwZ0JsaTZtbW9O?=
 =?utf-8?B?Mk1rdjBHV2VCRDkzWjEyMERsTDd4dFFidUFnQnVod2hUYzNuRU55TU1JS0o1?=
 =?utf-8?B?OWpkNVIxRVBHVmptK3BTNzgzWjQ3V2YyL3B6NkJRNXh6dUtuVWJ2VkZTRWo3?=
 =?utf-8?B?Kys0RTdjeUFLUVIwMzcyd2NFeWZRS09xVi9abE93T1lLNURZQ0IwQk1BOTR0?=
 =?utf-8?B?ejRKNmFNT2cvbE1vQ2d0ZVFsT05EeDNjcy93M24rV1ZHaGRrSE9Va0taVmsv?=
 =?utf-8?B?alpRS3dkV3RIZ05Ha2VEakFRRkV2Z2xDdFVxUlhnZ0RzdDNqYmoyK3V1Q0lD?=
 =?utf-8?B?UHNEc2JPMWFwUWx1bDNwdjRIK21uNkdlZ1FxeVFiMGo1ZEt4RjVlaG4yMlFr?=
 =?utf-8?B?NGRGci9UTTI2UFRtWkpZRHpPMG9wTVVzT09MQXlDK2xlTEoxbzJDYm9IblR6?=
 =?utf-8?B?TTNzdnFRbVFMRTVxOEx1THFCaUxPYmZETjV1TUFZNFFjMWpydGd1R1lyWFBO?=
 =?utf-8?B?QWErTDhwRUhiRzlIODhNOXpMS2dDZkgyOWtBcmtXeGlMS3ZvZXI3VTR2NGxj?=
 =?utf-8?B?UERJcnFDV0FNS01LejhmaC9DcW1rM2drZmZ6SVZoQTBZMkpxQUZ4MVRQVVVE?=
 =?utf-8?B?QkZabEIrd3ZFSmNSbkR5SDVSVlQ0eXlQZHFINDMzbWJXN3o3Ym40SlpJUWpa?=
 =?utf-8?B?UmVnOG1uK3FhWlYvWlRtRU8wQWQ5bEdFbTh3QnJnNFp3VUwzRk1XSmlTQ3BF?=
 =?utf-8?B?amJ5Sk45bGlrYzd6SnQvWDlVYUtteFlUOE92QVlHd04yYStzN01OeEg2QlJG?=
 =?utf-8?B?V1QzejNJa2E5UHUyOERFM3U4ZmZ2WHFCcWtWbXMyU3hBWUhEOWRxZDlyK2VR?=
 =?utf-8?B?T2hOUG1JWWl2dlZZcVA3UmNYZWJNcGFsMWZ6TjAvLyttKzZpUVR1Qjh4bkVE?=
 =?utf-8?B?bG8rMFFlRHRVOGd2R2JjNEJFak9rdXRpUE5rVy9WLzRtRUZoeFFQNzhjWGlm?=
 =?utf-8?B?Sm8xOXpyZENPdzBVQXkzdnY0dnRQMFV0bVAwS0NqZmZqQUs3M1dtSGJGUXlq?=
 =?utf-8?B?eXpGMUNVZ1B5OGYyU2pHUzNDOUxaUHNSeFRyUEpaS2N1TXNrRjFuamcvN0hs?=
 =?utf-8?B?TEg5ekhMZGxidzVIRlJ0RFZPZXA1Y0RCbmZJU0tzS2E1V0Q5WHFMUE5WUFlC?=
 =?utf-8?B?alBiQ1Mxd2c3V3pEbkFTMlJodjN2UTNHcFlTNnlNa2s2bUtSeWRZa1RDczQ0?=
 =?utf-8?B?YUZONnNScHNvU3BjYUlCeFFXKzg1enBTcG00aHlKdjc3b0dacFRPUFhVQzc5?=
 =?utf-8?B?MzFrSEl1V2cybG1VRVBvcVV4U0hDR2JSdFdwVDNOUHNPSDV4emwxaHIwNmFZ?=
 =?utf-8?B?c2MwTWdGY3lZRnc5SjR0VmhMekZEUkNjai9iRDlqVkUvVWE0eUgyOVdYZHBt?=
 =?utf-8?B?VytCR2syenBYMXhVUWFIclJWdlNTSE90Nm5UQTFOZE9EUkhDZVdRMkVWU2ZF?=
 =?utf-8?B?aHVseVlvQkNYS3lZZS9sdm9hWmVCSHJxYzNvZzhlWnk2RkZlUEE1VWRNYkMw?=
 =?utf-8?B?WFhIWXFrTEVIYjRaL1N5dHo3NWtKYTRKTmgydTV3eXRjTXU3UmEvcEpOWUxV?=
 =?utf-8?B?RWREb1BkbjQ4U2ZIZlJzSkw1NzRaRXVyUHlqQWkzVWszRS9OakVtWkZOZm54?=
 =?utf-8?B?bEpVM3FIWFJycmVJcE9YNnAxWUpjanpMVS9JYUx4QzIyWmhXNTJVVDVMcWFu?=
 =?utf-8?B?dWlHemxMeVU0dDVneHRyK3UvQmJpMHMvbUVEeEw3Q21XeW5Jd1RiM2RFMlEz?=
 =?utf-8?B?MnBBQVllclBKd2tMNWFoMkVwRVZvOTdiTjdhWHhGL3JuVGhUYVZUaVFKTjJv?=
 =?utf-8?B?cnc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <CD64D7D6688B86478E6BF143D8ABA0C4@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS3PR01MB10390.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0201b553-1f04-4803-633f-08dac3af6558
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Nov 2022 06:38:51.3174
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: W4cKRh5oJYnsDMQU1yesCtBe7VHTysntRzdu6gKxkUrSa4rB0FSg5Y9IfglQYhUod2Z4EFijMDVpr2fMksLHtQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB9909
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

DQoNCk9uIDExLzExLzIwMjIgMTQ6MzAsIFlhbmp1biBaaHUgd3JvdGU6DQo+Pg0KPj4gQWZ0ZXIg
dGhlc2UgcGF0Y2hlcywgb25seSBSWEUgZGV2aWNlIGNhbiByZWdpc3RlciAqRkxVU0hBQkxFKiBN
UnMNCj4+IHN1Y2Nlc3NmdWxseS4gSWYgbWx4IHRyeSB0aGF0LCBFT1BOT1NVUFAgd2lsbCBiZSBy
ZXR1cm5lZC4NCj4+DQo+PiBTaW1pbGFybHksIFNpbmNlIG90aGVyIGhhcmR3YXJlcyhNTFggZm9y
IGV4YW1wbGUpIGhhdmUgbm90IHN1cHBvcnRlZA0KPj4gRkxVU0ggb3BlcmF0aW9uLCBFT1BOT1NV
UFAgd2lsbCBiZSByZXR1cm5lZCBpZiB1c2VycyB0cnkgdG8gdG8gdGhhdC4NCj4+DQo+PiBJbiBz
aG9ydCwgZm9yIFJYRSByZXF1ZXN0ZXIsIE1MWCByZXNwb25kZXIgd2lsbCByZXR1cm4gZXJyb3Ig
Zm9yIHRoZQ0KPj4gcmVxdWVzdC4gTUxYIHJlcXVlc3RlciBpcyBub3QgYWJsZSB0byByZXF1ZXN0
IGEgRkxVU0ggb3BlcmF0aW9uLg0KPiANCj4gVGhhbmtzLiBEbyB5b3UgbWVhbiB0aGF0IEZMVVNI
IG9wZXJhdGlvbiBpcyBvbmx5IHN1cHBvcnRlZCBpbiBSWEU/IF5fXg0KPiANCj4gQW5kIE1MWCBk
b2VzIG5vdCBzdXBwb3J0IEZMVVNIIG9wZXJhdGlvbiBjdXJyZW50bHk/DQoNCklNTywgRkxVU0gg
YW5kIEF0b21pYyBXcml0ZSBhcmUgbmV3bHkgaW50cm9kdWNlZCBieSBJQkEgc3BlYyAxLjUgDQpw
dWJsaXNoZWQgaW4gMjAyMS4gU28gaGFyZHdhcmUvZHJpdmVycyhNTFgpIHNob3VsZCBkbyBzb21l
dGhpbmcgdG8NCnN1cHBvcnQgaXQu
