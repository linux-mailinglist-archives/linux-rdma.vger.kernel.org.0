Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C27862DC81
	for <lists+linux-rdma@lfdr.de>; Thu, 17 Nov 2022 14:20:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239480AbiKQNU5 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 17 Nov 2022 08:20:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234904AbiKQNU4 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 17 Nov 2022 08:20:56 -0500
Received: from esa14.fujitsucc.c3s2.iphmx.com (esa14.fujitsucc.c3s2.iphmx.com [68.232.156.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7ADD3558D;
        Thu, 17 Nov 2022 05:20:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1668691254; x=1700227254;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=+TDokIVwf7OX8ymSr1Ls1rsy5ZXeGeAZqBp2kEtAERY=;
  b=G6bBnEoQxvW/K7F3iUQOS9DO1AsS+Fn/pFBEkt4SxXbVA/irjhHdcGN9
   LU53vC65v0OM5rwStLk+fDbKaZkARkPiGXSd1xh/C+Z/gqmuhRyr/hm7b
   IV/NnbjUWRzv+2GxDQn53WEASihLDTSOKX0OjZi2CeweuczgTboQ+nPk7
   xsAVGP1lEciMSGyWRil0bQ+jqrOrRgoi5X3enFzIvPRaY4B7NT8esRqmp
   lNmIy8moBdOk2PdJbV5a4D5leBxOfbaDlwFJi27NcdkbAps6bYWaraPdX
   +HxuKtgU3vtf5Ibwt71PcbIMo3VEaDyIOK5M3mpsYbFLUTpBf08UWbk+Z
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10533"; a="70021765"
X-IronPort-AV: E=Sophos;i="5.96,171,1665414000"; 
   d="scan'208";a="70021765"
Received: from mail-os0jpn01lp2111.outbound.protection.outlook.com (HELO JPN01-OS0-obe.outbound.protection.outlook.com) ([104.47.23.111])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2022 22:20:48 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=awep4sulMZX5RUIMekOQ361cuj4zwa6h+tFqWk95W2ig8eqOBthC3KIc56oH/uMyICXvb6OV1eRInlKLublyVYAIDaBwaF8zDZMyPMXR1m0v6Yqa6XcY+BhADMhJ7CrbOV3lFtYRgwyx3fhF9IAJFFRn2Sm4UHtK0op8+/huQVA51/z66TLDewo4RoVVwhhqxf9XMWAzpne7caQD+rLkRO/l36fvTb6fJptsvw0Bjz0Ux+4oYQ6V8s+VkbpLcLIFSKS5JksuruL3rqyzOkIfrVCejhTNAgYL0SY8a5dSAJWznz09Vb2HsHMq/tDJ6pP+kBb+PnxkbIjrZSGai0rFxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+TDokIVwf7OX8ymSr1Ls1rsy5ZXeGeAZqBp2kEtAERY=;
 b=l5ZTp36VgOMCQP4q6A3UU3QO2vjTiU2X/DVodexiUIdzo13eaToBbT7enKwA6E9QyI6TTOUFtPGZR8t7SLbUKUr5jJoh5huEOqPu8yu8TpJ7JOL1p9C5sT5v85Gfi8NuCoRmIP8/Gaua/1XPyqug2KqX56TaEDVJQyRoe04iV1zctsSeXXPTh+PzmzfSnJcE4xx55//iPs4fVGWk8RBG+KYrjUS9mXjlTZxvUSTs0AXkZWwRtCKCw3IYPE3EZy+zDjP65jUT0PnfV45pqDSbC6pnsFUkQpRAh7+xhxJua89rke6TTEcmXaBmmziPWjxxuJaI7JD0UaY4BXC9T5mjDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from OS3PR01MB10390.jpnprd01.prod.outlook.com
 (2603:1096:604:1fb::14) by TY3PR01MB10126.jpnprd01.prod.outlook.com
 (2603:1096:400:1d9::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.19; Thu, 17 Nov
 2022 13:20:46 +0000
Received: from OS3PR01MB10390.jpnprd01.prod.outlook.com
 ([fe80::b01a:186c:94a7:acc9]) by OS3PR01MB10390.jpnprd01.prod.outlook.com
 ([fe80::b01a:186c:94a7:acc9%7]) with mapi id 15.20.5813.019; Thu, 17 Nov 2022
 13:20:46 +0000
From:   "lizhijian@fujitsu.com" <lizhijian@fujitsu.com>
To:     "Daisuke Matsuda (Fujitsu)" <matsuda-daisuke@fujitsu.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "leonro@nvidia.com" <leonro@nvidia.com>,
        "jgg@nvidia.com" <jgg@nvidia.com>,
        "zyjzyj2000@gmail.com" <zyjzyj2000@gmail.com>
CC:     "nvdimm@lists.linux.dev" <nvdimm@lists.linux.dev>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "rpearsonhpe@gmail.com" <rpearsonhpe@gmail.com>,
        "yangx.jy@fujitsu.com" <yangx.jy@fujitsu.com>,
        "Yasunori Gotou (Fujitsu)" <y-goto@fujitsu.com>
Subject: Re: [RFC PATCH v2 1/7] IB/mlx5: Change
 ib_umem_odp_map_dma_single_page() to retain umem_mutex
Thread-Topic: [RFC PATCH v2 1/7] IB/mlx5: Change
 ib_umem_odp_map_dma_single_page() to retain umem_mutex
Thread-Index: AQHY9a9QbfPi1PPK7EmV5nQrvAtbfK5DI2uA
Date:   Thu, 17 Nov 2022 13:20:45 +0000
Message-ID: <47a000b6-8a5f-541f-809d-ad367f81669c@fujitsu.com>
References: <cover.1668157436.git.matsuda-daisuke@fujitsu.com>
 <b9974985069900c80b8ff9e6b0b0b346c1592910.1668157436.git.matsuda-daisuke@fujitsu.com>
In-Reply-To: <b9974985069900c80b8ff9e6b0b0b346c1592910.1668157436.git.matsuda-daisuke@fujitsu.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS3PR01MB10390:EE_|TY3PR01MB10126:EE_
x-ms-office365-filtering-correlation-id: 2b6c74cb-aba8-4178-eeb4-08dac89e8942
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 3tRRp4JD6YevfH8w/GufcP7cPsdgkHnc8+JrVJYnyvMlApFE0H010tNqMaWon7GJsTyP5ueNpq3ROyXnT3rCnIRwI+vVEBotFhRIELr1KSocEeNSc2GVAamTFIBWMksK9UUYUrW0edWQRAljRGD+zju2rwjMpaDb4xOUPZOlUqMYIP8V4ngIWRG2fwriKnvzDBVXpYccJ4mgLlQTWxWlQCpW+YhQHEcxXyLAwD2sSXcjRI9E1Yr7ldvldLX2MMrhoq8RWLs1HRHeK/AH0M6h3yNLd8kQZoxckmlTY7F4u7IdDkfDHehlTRakrYskshfCU6Gsgmxy22lypt3bWfkGOhtLsUr2osWWFHwGtUQDuQlwQ/NDWw775B18DUSeREvUYW/Fq1b1VESgr/M88ckqOJJUJWVm1FehYQE1UatY3bLHOtHgeIMZ52tCqtlaXUHDL9dkCjVWIVnKIsbXwTZggHKKHusLuQQQtdpm4w/2P+anQuGWA7WmZB1F34kxmE6gI+340KrRxVqks72qixrEHRjvEQCNLIhleNyWzbSdZ097jYhdjZQscVl3xcKTiYldiW8wAQcXLErn+UwzWp3wyKHp0Cy+VhPdulaH6WH1/KrgCP+H4e7VvBm9bxFFbUb64rfJQHIfsMl44k/v4QhidwV7pI5bZSNCnzelhXjwPaZH5zemx7AJYYsQa2wCBlGkfD3aOBCBUme/4IlKC9dOJb2BqUa/i17xCtb8I+l+Pda2UDYLdEsKClk3aAQt3+U2T/iiQ9c9KsQpokTbMQGEm3IwpjI9ZAZ7eDD8eCNRjBs=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS3PR01MB10390.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(136003)(366004)(346002)(39860400002)(396003)(1590799012)(451199015)(36756003)(85182001)(31686004)(1580799009)(38070700005)(31696002)(86362001)(38100700002)(83380400001)(5660300002)(2906002)(2616005)(186003)(6506007)(53546011)(6512007)(26005)(122000001)(82960400001)(91956017)(6486002)(107886003)(71200400001)(66476007)(41300700001)(66556008)(76116006)(316002)(66946007)(66446008)(64756008)(4326008)(54906003)(478600001)(8676002)(8936002)(110136005)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TllFWk5INWpFNC92Q01mMTl0dVo4TDhDUjk5TFc2ZEFtYXNQWDQ5cU1GNGVu?=
 =?utf-8?B?M1hvaGRKeStJL1VWS2xsUmI5RFFyM01rR1Q4Q2Y1c1g3QWtMK01iTCt2dUpT?=
 =?utf-8?B?bGxVU3JoU1poUDZyQWd4M203bjRtY24wMFNZajB0RHRud2RWNlcyckJMRDZ3?=
 =?utf-8?B?RUp2a3lrYzlqMWYyVUQ1VWsvQ25jeDFHdURBNzZ6RjdmZHYzWXJ4N0VxdEZL?=
 =?utf-8?B?RWdabzA3REErSEVoRlJjeEViMTFWRWxIVVY5SWlqeFpHS283bnUvZDNFNGpZ?=
 =?utf-8?B?NFdvcXBrcy9xelhDWlVLK1FUTVB4V0dMd01nNVIyNGNkaFV1bUhBc1BzbDZB?=
 =?utf-8?B?cUVCRHpOMmV2eUE5NFQwOCtwckc0eCthWnh3cXBUZjFqMXZkNXNtZGU2L3pT?=
 =?utf-8?B?OTFodjNBQXFRZ1ZVcUZYRzJlU09XNWtCZU9TNlZnb2JCSnNsazdmZUFMVkdF?=
 =?utf-8?B?eFcyZ25DUHBPVm44UTdTc3lqQ3VNaUg5NHNqNlRKcms1UmliK1dSUEJ1UFlq?=
 =?utf-8?B?N1RVRFU5Ly9ncXZRb1k2S0dsZEYzc1d3THdBd2RQUVJFRGFIZy9pNUFKL1M4?=
 =?utf-8?B?M2RVOVJFQ01zTDJia2NQWmJ5V1MxME14b2JXSWF4R2pneE5QTlJlWmFSbXdh?=
 =?utf-8?B?elFuQTlNUFdNNDVzN3hvVTRISE1jaTZWOHBGSlV0UVk5b1dpVXV2NFJlVUF2?=
 =?utf-8?B?RTZOb2RhTkpuUmlQYjI0NzBsRmxMZy9YZGNyUkxWWEZrc3ZjaFNyUjdKM091?=
 =?utf-8?B?Umg5cTJIb2JYSHI2NzhzKzcreTZSVG93OStHeWFaYnFGQ253VWhNQnY2dUdS?=
 =?utf-8?B?RjNNWTNPdWd4RjlrdjZuejFqMlhLYTZtUDJLb09lcXd1aUxqQ0lpcTRsaHpj?=
 =?utf-8?B?M1pGSzAxQ1hQTGV2eUxyenZWcFZFUjN6UVV4RmFJUE1JeEFUSHdmRk1xOWtU?=
 =?utf-8?B?aGk4YU4wLzVoaElTZEpFR0UvYmlXUEU0U2JnQmM5czNmQ3kxK0twQ0tsV2py?=
 =?utf-8?B?MHJWNlp2bm5adHBCTWpva1ZJTTg1bjhGazFySDlDYXdaUWNIZlVDRm8vRWpW?=
 =?utf-8?B?dmkxVDJtcFVXWS9CNmdwdGllRHVnM2VRQ3pyKzdTQUxpaG1QVTMyTEZVU05i?=
 =?utf-8?B?OFZQQjFLbTN2Z1F0QzZXWGJoek16TTdZWU5YZUlYWXNPVU5STDQ1RWlaMzgr?=
 =?utf-8?B?cDA0cXR1c1JmZEdvOTFlZXgxVW9qdmF3YTh6M2VDMEw1WXhiRnFhbUNRL1dY?=
 =?utf-8?B?SGtRMlNkdVZId3Rnd3A5eTJLek1Fd0NudjJWYjV4WlozV3lCTmJFYmI5RTdV?=
 =?utf-8?B?VHdDQzA3WlQ4WDdRMGJvVFFaUTVLMzA0T1grcjBYUHFoTU9HMGpYUi9xMVdz?=
 =?utf-8?B?eG9hQnRRNEVCNXFPTEUycEFCNXM5UE01VGQ2SFA1ZFVrUFljSXBLditNaXpD?=
 =?utf-8?B?ZzFrb25oaDIvTTcxY3NSN2lFTTdGUDNuR2RxR1QxWjZoazlsOWMyMk1QMGtu?=
 =?utf-8?B?eXRZQXNRMk5saW5Xa0dsTDJHRWY0U2FJZDFyYXVRbzRhcEFqMUNpcDlSL1dS?=
 =?utf-8?B?ampFOUc1bDM2NllqdDllZTJPUU4zN1g4YWxBOUI2YjNtWHovL1JoSnhtb3d2?=
 =?utf-8?B?MU9WUXVMZXJ2L2hsb3B3SXcrTnVqSkdJdHAwczNHcEc0Qlp3Si95R2Y5QU1i?=
 =?utf-8?B?bndyUnpvaTJETEZSajhyV0VUTUtiRnBybU1xMzlvWnBlU3k2RDA3SDFPRnpm?=
 =?utf-8?B?SGRud1VZcHVyc2Y4MjRELzVVRWtRNy94Z1A5Vm9GSXNLTlFvWUFiYkluYlRO?=
 =?utf-8?B?R0xsaTJoeDhQMzkveFVRcDFFcStCQUtaZlYxSjF6Mkx0T1B3WTgrMGNjTm5P?=
 =?utf-8?B?YTA1UytsZUxOMittd2pIR2xSTG5Qc0NQelNMcVFOTTc4TXBNc1lHTUkvbFJI?=
 =?utf-8?B?SDVMMzkvRlhDK1BJTlYyZ25PZC9VU24xTEN4MWM0V2FKdGJTTmU0TlhzaTZr?=
 =?utf-8?B?amFUTFBpUlBhTUttQVNzSFpLR0pzUnFYcEJKblNiK1ZaZDRKNC9kVzlGVkti?=
 =?utf-8?B?ckRrd2NHUFF2a1Rvdm9kQnRMNk1YeFhjeWRUYXoyY2ZleC9nQmsxNkN3RU1y?=
 =?utf-8?B?YmhIdlFTMFVsNFpIcjlHK2RCVnZpaFQ5SllLSXdpRmZ0MGZZdVpySHVqV3RN?=
 =?utf-8?B?UWc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <6EBC88160FC52E488B2EB05AAF67800F@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?d2tybzgvSC9aQVlkdGtTTHgyR25jWkdpYmJUUFhneGRLUmo2RjNXL3FlN2NW?=
 =?utf-8?B?Q2xwaWsvcVpyWW94MXhhZzl4ZHhkOS9MNStvUnBIVVh0VVE4TVRyQjZSaXhR?=
 =?utf-8?B?WDNYQzhZV0lpdkxCbUlRTDBTTGNqaXF0dG1wTis3a3NBb0kwbDdZUVhTbHdO?=
 =?utf-8?B?QXJqMzNuRzRpN0lydmVkNGw4cXc1aHNnTThyQ1M1bkg5UVJ5Smd1YzBLenVs?=
 =?utf-8?B?MEVlNitNTWFLeXBoZG9vd1V5bHlwQUpFcnpXbXRPbGF0aTdWMTBMV21IcXBw?=
 =?utf-8?B?K1dzekcvbUZrRGhHcGxCTzRZazhFeTY0dS83OXh4YzlPWGRlRExwOHFrQ0o4?=
 =?utf-8?B?cEhZV3I2NW1RRnBnQ0FFaEdtNUs5SjZKdEJVZGQxZloxNVhZOE1qT2JqckFB?=
 =?utf-8?B?MmZFZVJlKytsNEJ4TFhXMFBLTEV2UTdFckl6ai9mWHVKSW0yekxLRFhzMEU2?=
 =?utf-8?B?M2hqMnM3a1FMOHZBbE5sdlhodVE1VzlmTGZlOXJlUzJpc0ZzY3NLVUljYWd6?=
 =?utf-8?B?aHRPYWhoMllVeGJXMjlRVVRNUUhmUndLVmRPaEtlZzFVRGg4bUsvWlluN3Va?=
 =?utf-8?B?WlI2S1h2ZkFtemF6bXhMYjFOdUd2RXBna3RaRjVmYUhzaW01TW5wd3oxREZ4?=
 =?utf-8?B?WkxCMzlySllRdTkxR3AvQklWTkdCMHVwL1hURDFYT2E3YW9JdUVYZ1haRjNZ?=
 =?utf-8?B?ako1Ym50VkxjZERlU29CUUV1c3lQNzFrZVVFOWMzcGFjajNXeXMvazdmcVFQ?=
 =?utf-8?B?WFROQStKMUZlZVdJOS9sZE9xbmRmekdxdm9CMWRvVGx0NDJZTjY3RE8xQXFy?=
 =?utf-8?B?MEZFaUZxU1JJTEZnQ3ZPR2crcE1WZHBObTIraVFzSG52RHB2SmNpL0k0Tmxm?=
 =?utf-8?B?Q0NrZnhDTkhPeGUrWHc2bThOQThEL3B4NEVJZk5ZQkxrRnEvb0xEK3FiK1Mx?=
 =?utf-8?B?TUtlYU5GNUZYSkNDUGNGTi9HVzFMY202K2pmSll1QXA3U0dkbFNwNWpiVTFl?=
 =?utf-8?B?NG1qK3J6ckN3L2M1OXUrcUxtSTRBT1NPZVU1QmFtQXA2QXJjWFZqblcrYjBO?=
 =?utf-8?B?dkhOeHQ0S3VZdXluUGZBSmo3aGY0cFh0QmpXUGFORTFweTk5V3VPWDlwWWJB?=
 =?utf-8?B?SjNyUU1mUWJOZjgrS2J5enZVRnE0YU5vNlN6cG1yV0ZnUGxoODlSeE5YTEVN?=
 =?utf-8?B?elpUQlB0bldkWmRyTmNCTUEvcHZSM2drMWhqNERPR1R0MHhzQ0ZJTEduajRZ?=
 =?utf-8?B?dWdFaXFWYyswUVp1L0gvcEpZM1pxSzViQ1Nqd210WTlFWXhBQT09?=
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS3PR01MB10390.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b6c74cb-aba8-4178-eeb4-08dac89e8942
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Nov 2022 13:20:45.9287
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QfYN2QyqzjMg67scgMeN7JDaDm92hk0DKCvmiQQ8nVj/68iTMMG6woC/5jg5ue5AbH9R5SnLRxo3dNU9Kgl0Cw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY3PR01MB10126
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,NICE_REPLY_A,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

DQoNCk9uIDExLzExLzIwMjIgMTc6MjIsIERhaXN1a2UgTWF0c3VkYSB3cm90ZToNCj4gaWJfdW1l
bV9vZHBfbWFwX2RtYV9zaW5nbGVfcGFnZSgpLCB3aGljaCBoYXMgYmVlbiB1c2VkIG9ubHkgYnkg
dGhlIG1seDUNCj4gZHJpdmVyLCBob2xkcyB1bWVtX211dGV4IG9uIHN1Y2Nlc3MgYW5kIHJlbGVh
c2VzIG9uIGZhaWx1cmUuIFRoaXMNCj4gYmVoYXZpb3IgaXMgbm90IGNvbnZlbmllbnQgZm9yIG90
aGVyIGRyaXZlcnMgdG8gdXNlIGl0LCBzbyBjaGFuZ2UgaXQgdG8NCj4gYWx3YXlzIHJldGFpbiBt
dXRleCBvbiByZXR1cm4uDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBEYWlzdWtlIE1hdHN1ZGEgPG1h
dHN1ZGEtZGFpc3VrZUBmdWppdHN1LmNvbT4NCj4gLS0tDQo+ICAgZHJpdmVycy9pbmZpbmliYW5k
L2NvcmUvdW1lbV9vZHAuYyB8IDggKysrLS0tLS0NCj4gICBkcml2ZXJzL2luZmluaWJhbmQvaHcv
bWx4NS9vZHAuYyAgIHwgNCArKystDQo+ICAgMiBmaWxlcyBjaGFuZ2VkLCA2IGluc2VydGlvbnMo
KyksIDYgZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9pbmZpbmliYW5k
L2NvcmUvdW1lbV9vZHAuYyBiL2RyaXZlcnMvaW5maW5pYmFuZC9jb3JlL3VtZW1fb2RwLmMNCj4g
aW5kZXggZTlmYTIyZDMxYzIzLi40OWRhNjczNWY3YzggMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMv
aW5maW5pYmFuZC9jb3JlL3VtZW1fb2RwLmMNCj4gKysrIGIvZHJpdmVycy9pbmZpbmliYW5kL2Nv
cmUvdW1lbV9vZHAuYw0KPiBAQCAtMzI4LDggKzMyOCw4IEBAIHN0YXRpYyBpbnQgaWJfdW1lbV9v
ZHBfbWFwX2RtYV9zaW5nbGVfcGFnZSgNCj4gICAgKg0KPiAgICAqIE1hcHMgdGhlIHJhbmdlIHBh
c3NlZCBpbiB0aGUgYXJndW1lbnQgdG8gRE1BIGFkZHJlc3Nlcy4NCj4gICAgKiBUaGUgRE1BIGFk
ZHJlc3NlcyBvZiB0aGUgbWFwcGVkIHBhZ2VzIGlzIHVwZGF0ZWQgaW4gdW1lbV9vZHAtPmRtYV9s
aXN0Lg0KPiAtICogVXBvbiBzdWNjZXNzIHRoZSBPRFAgTVIgd2lsbCBiZSBsb2NrZWQgdG8gbGV0
IGNhbGxlciBjb21wbGV0ZSBpdHMgZGV2aWNlDQo+IC0gKiBwYWdlIHRhYmxlIHVwZGF0ZS4NCj4g
KyAqIFRoZSB1bWVtIG11dGV4IGlzIGxvY2tlZCBpbiB0aGlzIGZ1bmN0aW9uLiBDYWxsZXJzIGFy
ZSByZXNwb25zaWJsZSBmb3INCj4gKyAqIHJlbGVhc2luZyB0aGUgbG9jay4NCj4gICAgKg0KDQoN
Cj4gICAgKiBSZXR1cm5zIHRoZSBudW1iZXIgb2YgcGFnZXMgbWFwcGVkIGluIHN1Y2Nlc3MsIG5l
Z2F0aXZlIGVycm9yIGNvZGUNCj4gICAgKiBmb3IgZmFpbHVyZS4NCj4gQEAgLTQ1MywxMSArNDUz
LDkgQEAgaW50IGliX3VtZW1fb2RwX21hcF9kbWFfYW5kX2xvY2soc3RydWN0IGliX3VtZW1fb2Rw
ICp1bWVtX29kcCwgdTY0IHVzZXJfdmlydCwNCj4gICAJCQlicmVhazsNCj4gICAJCX0NCj4gICAJ
fQ0KPiAtCS8qIHVwb24gc3VjY2VzcyBsb2NrIHNob3VsZCBzdGF5IG9uIGhvbGQgZm9yIHRoZSBj
YWxsZWUgKi8NCj4gKw0KPiAgIAlpZiAoIXJldCkNCj4gICAJCXJldCA9IGRtYV9pbmRleCAtIHN0
YXJ0X2lkeDsNCj4gLQllbHNlDQo+IC0JCW11dGV4X3VubG9jaygmdW1lbV9vZHAtPnVtZW1fbXV0
ZXgpOw0KPiAgIA0KPiAgIG91dF9wdXRfbW06DQo+ICAgCW1tcHV0X2FzeW5jKG93bmluZ19tbSk7
DQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2luZmluaWJhbmQvaHcvbWx4NS9vZHAuYyBiL2RyaXZl
cnMvaW5maW5pYmFuZC9ody9tbHg1L29kcC5jDQo+IGluZGV4IGJjOTc5NTg4MThiYi4uYTBkZTI3
NjUxNTg2IDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL2luZmluaWJhbmQvaHcvbWx4NS9vZHAuYw0K
PiArKysgYi9kcml2ZXJzL2luZmluaWJhbmQvaHcvbWx4NS9vZHAuYw0KPiBAQCAtNTcyLDggKzU3
MiwxMCBAQCBzdGF0aWMgaW50IHBhZ2VmYXVsdF9yZWFsX21yKHN0cnVjdCBtbHg1X2liX21yICpt
ciwgc3RydWN0IGliX3VtZW1fb2RwICpvZHAsDQo+ICAgCQlhY2Nlc3NfbWFzayB8PSBPRFBfV1JJ
VEVfQUxMT1dFRF9CSVQ7DQo+ICAgDQo+ICAgCW5wID0gaWJfdW1lbV9vZHBfbWFwX2RtYV9hbmRf
bG9jayhvZHAsIHVzZXJfdmEsIGJjbnQsIGFjY2Vzc19tYXNrLCBmYXVsdCk7DQo+IC0JaWYgKG5w
IDwgMCkNCj4gKwlpZiAobnAgPCAwKSB7DQo+ICsJCW11dGV4X3VubG9jaygmb2RwLT51bWVtX211
dGV4KTsNCj4gICAJCXJldHVybiBucDsNCj4gKwl9DQoNCnJlZmVyIHRvIHRoZSBjb21tZW50cyBv
ZiBpYl91bWVtX29kcF9tYXBfZG1hX2FuZF9sb2NrOg0KMzM0ICAqIFJldHVybnMgdGhlIG51bWJl
ciBvZiBwYWdlcyBtYXBwZWQgaW4gc3VjY2VzcywgbmVnYXRpdmUgZXJyb3IgDQpjb2RlDQozMzUg
ICogZm9yIGZhaWx1cmUuDQoNCkkgZG9uJ3QgdGhpbmsgaXQncyBjb3JyZWN0IHRvIHJlbGVhc2Ug
dGhlIGxvY2sgaW4gYWxsIGZhaWx1cmUgY2FzZSwgZm9yIA0KZXhhbXBsZSB3aGVuIGl0IHJlYWNo
ZXMgYmVsb3cgZXJyb3IgcGF0aC4NCg0KMzQ2IGludCBpYl91bWVtX29kcF9tYXBfZG1hX2FuZF9s
b2NrKHN0cnVjdCBpYl91bWVtX29kcCAqdW1lbV9vZHAsIHU2NCANCnVzZXJfdmlydCwNCjM0NyAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB1NjQgYmNudCwgdTY0IGFjY2Vzc19tYXNr
LCBib29sIA0KZmF1bHQpDQozNDggICAgICAgICAgICAgICAgICAgICAgICAgX19hY3F1aXJlcygm
dW1lbV9vZHAtPnVtZW1fbXV0ZXgpIA0KDQozNDkgeyANCg0KMzUwICAgICAgICAgc3RydWN0IHRh
c2tfc3RydWN0ICpvd25pbmdfcHJvY2VzcyAgPSBOVUxMOyANCg0KMzUxICAgICAgICAgc3RydWN0
IG1tX3N0cnVjdCAqb3duaW5nX21tID0gdW1lbV9vZHAtPnVtZW0ub3duaW5nX21tOyANCg0KMzUy
ICAgICAgICAgaW50IHBmbl9pbmRleCwgZG1hX2luZGV4LCByZXQgPSAwLCBzdGFydF9pZHg7IA0K
DQozNTMgICAgICAgICB1bnNpZ25lZCBpbnQgcGFnZV9zaGlmdCwgaG1tX29yZGVyLCBwZm5fc3Rh
cnRfaWR4OyANCg0KMzU0ICAgICAgICAgdW5zaWduZWQgbG9uZyBudW1fcGZucywgY3VycmVudF9z
ZXE7IA0KDQozNTUgICAgICAgICBzdHJ1Y3QgaG1tX3JhbmdlIHJhbmdlID0ge307IA0KDQozNTYg
ICAgICAgICB1bnNpZ25lZCBsb25nIHRpbWVvdXQ7IA0KDQozNTcgDQoNCjM1OCAgICAgICAgIGlm
IChhY2Nlc3NfbWFzayA9PSAwKSANCg0KMzU5ICAgICAgICAgICAgICAgICByZXR1cm4gLUVJTlZB
TDsgICA8PDw8PCAgIG5vIGxvY2sgaXMgaG9sZCB5ZXQgDQoNCjM2MCANCg0KMzYxICAgICAgICAg
aWYgKHVzZXJfdmlydCA8IGliX3VtZW1fc3RhcnQodW1lbV9vZHApIHx8IA0KDQozNjIgICAgICAg
ICAgICAgdXNlcl92aXJ0ICsgYmNudCA+IGliX3VtZW1fZW5kKHVtZW1fb2RwKSkgDQoNCjM2MyAg
ICAgICAgICAgICAgICAgcmV0dXJuIC1FRkFVTFQ7ICAgPDw8PDwgICBubyBsb2NrIGlzIGhvbGQg
eWV0DQoNCg0KRnVydGhlciBtb3JlLCB5b3UgY2hhbmdlZCBwdWJsaWMgQVBJJ3MgdGhlIGJlaGF2
aW9yLCBkbyBpdCBtYXR0ZXIgZm9yIA0Kb3RoZXIgb3V0LW9mLXRyZWUgZHJpdmVycyB3aGljaCBp
cyB1c2luZyBpdCwgaSdtIG5vdCBmYW1pbGlhciB3aXRoIHRoaXMsIA0KbWF5YmUga2VybmVsIGhh
cyBubyByZXN0cmljdGlvbiBvbiBpdCA/DQoNCg0KPiAgIA0KPiAgIAkvKg0KPiAgIAkgKiBObyBu
ZWVkIHRvIGNoZWNrIHdoZXRoZXIgdGhlIE1UVHMgcmVhbGx5IGJlbG9uZyB0byB0aGlzIE1SLCBz
aW5jZQ==
