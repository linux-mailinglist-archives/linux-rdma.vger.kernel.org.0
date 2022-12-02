Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B604640889
	for <lists+linux-rdma@lfdr.de>; Fri,  2 Dec 2022 15:35:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233041AbiLBOfN (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 2 Dec 2022 09:35:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232315AbiLBOfL (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 2 Dec 2022 09:35:11 -0500
Received: from esa8.fujitsucc.c3s2.iphmx.com (esa8.fujitsucc.c3s2.iphmx.com [68.232.159.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19E8F17433
        for <linux-rdma@vger.kernel.org>; Fri,  2 Dec 2022 06:35:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1669991710; x=1701527710;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=FzUVrh2OxysRb7+iSvMBvkcrdHgVwTJ9lx4eJrzZydA=;
  b=Eih6TvdY3utxgTaAV5YgUzO0OSUMzE52UswVCm7j6SZiY1IGp8Z8W5iC
   EZgUChYCSq4DS5mlkSrypuqgEO5EmsDNy1hTI0WWFfOcKlRVAAcuTwLhA
   /uoYlo9dMaN5IAxVylMflN/ETbCbK8V4xX8U6mGGwgLKk1b9CxM5ExOY5
   gF1eLDDQL5X0sLD52AKyv9PzeOL1I3PnDdc/QOtG3BG7mpAsQ+alprzlc
   znspwTbx2iDyNk70bbN17hL9S8ON19wk/Y/PwtcVf86GaZ+nkNTafSBXU
   wmV2YdgUnMGsuRSlt9c+utp2K+K65lXbJiyW66Q549ahUdMbGWGJfC+zK
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10548"; a="71491726"
X-IronPort-AV: E=Sophos;i="5.96,212,1665414000"; 
   d="scan'208";a="71491726"
Received: from mail-tycjpn01lp2171.outbound.protection.outlook.com (HELO JPN01-TYC-obe.outbound.protection.outlook.com) ([104.47.23.171])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2022 23:35:06 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LFaZAiNEwGtQnA8EFiJRQWUgDFmFYNmTOw8v00Kn4nJDdKpGKG+C2RUFtzy1PF4yxNDw8oBu+29EdcxdWi2Lx6TF+OtBFtnCFpgAv0DFeMZBhfqq67BxQ9svHgRPfoEAy5y4MbQywSLXkX3OILpbdacejgYlepinsc2E3b3R36w9L+ysDWHuydGZgPXH7iQ7UD7HlJw8BBYtmCE9vxgXCRjGlcaqw9q1UvOWa0ClIsP0uMKksOBntwiS5jMjIv8Ci1apJ3DPU90FNE3xXs6SbJHJFMQ1bLVsICKtBYbQf8aKEl4bvWT8gvSBn8QVTAHnsCfxG9WS1LR97WrgrpCOVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FzUVrh2OxysRb7+iSvMBvkcrdHgVwTJ9lx4eJrzZydA=;
 b=a4SiyeS41x8AK+E1QwtKuE96C3melUwXirrMPhWQb24lsgKLvEQ5ttc3exLg9ifQ3Gxo9hfdhjBZF5PiG6l2yDvIYu7VyyLx1jfrJnspEBrZWZo5Whhy0ElIuY4Ua6MirTZKwKYeu23NaBx/tpzgQfr4EksIMQngQEvnxMsOkUpLYB7VruDajk2UtuveYfl6dMw66x/CJjjO1vlo7Dh3Z61/wq7gNa7jQTgb6ywUIBj4FCl9vkBeu121ZkBcYJZwm8dy/+UYtv8EoLpGq74t6kBdMUjYiLolePH3up6yse8G9EamZEZ/mhM9L4NxI3fkw71CwWQc1Ip/iCErCNRsxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from OS3PR01MB10390.jpnprd01.prod.outlook.com
 (2603:1096:604:1fb::14) by OS3PR01MB9672.jpnprd01.prod.outlook.com
 (2603:1096:604:1f0::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.8; Fri, 2 Dec
 2022 14:35:02 +0000
Received: from OS3PR01MB10390.jpnprd01.prod.outlook.com
 ([fe80::b01a:186c:94a7:acc9]) by OS3PR01MB10390.jpnprd01.prod.outlook.com
 ([fe80::b01a:186c:94a7:acc9%8]) with mapi id 15.20.5857.023; Fri, 2 Dec 2022
 14:35:02 +0000
From:   "lizhijian@fujitsu.com" <lizhijian@fujitsu.com>
To:     Zhu Yanjun <zyjzyj2000@gmail.com>,
        "Daisuke Matsuda (Fujitsu)" <matsuda-daisuke@fujitsu.com>
CC:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "leonro@nvidia.com" <leonro@nvidia.com>,
        "jgg@nvidia.com" <jgg@nvidia.com>,
        "rpearsonhpe@gmail.com" <rpearsonhpe@gmail.com>
Subject: Re: [PATCH] Revert "RDMA/rxe: Remove unnecessary mr testing"
Thread-Topic: [PATCH] Revert "RDMA/rxe: Remove unnecessary mr testing"
Thread-Index: AQHZBj2SveIAUMKqK02PdRtF1x/hO65aesIAgAAvRYA=
Date:   Fri, 2 Dec 2022 14:35:01 +0000
Message-ID: <a1df668e-eba3-6b48-4ec4-d4aefee19db1@fujitsu.com>
References: <20221202110157.3221952-1-matsuda-daisuke@fujitsu.com>
 <CAD=hENcdfWQd5ZiN0_sc-Jy5tCj2SzdBpyGNYuTwsWBTqq9Xjg@mail.gmail.com>
In-Reply-To: <CAD=hENcdfWQd5ZiN0_sc-Jy5tCj2SzdBpyGNYuTwsWBTqq9Xjg@mail.gmail.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.1.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS3PR01MB10390:EE_|OS3PR01MB9672:EE_
x-ms-office365-filtering-correlation-id: cabad87e-e9ee-4335-6366-08dad472657f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: sOYlqqHP//GFy5GZ4hrX9HyW/WpxgJi5HWjq3Xilvyus/2S3Oe+c8ZDtuvl8LHpZTmTMyBcv+XBfCAMbntvwIMeaoqmqlC7kqi6JPq27eycoVqztYxncIEtoU3GygJZXG2dHLPSaQiAHNJAZgjhG+dMj1ctrl/BJKC45m7UT9rEYdWXSB8GiyN0EjR3YC6lfG0ZF6D0BcXTu+obMlvs97izN18G4js5K7KNV9eHKPtSGuT1J2u3L3SGykQvZppUJFM5ceUMLPWov/+LiBTAFjWQ5R3O9Kh8RDaGWb6EbDrPX94aODbQ2GNZIC/4suZ68Wu3/8aPCyJHsmJFWkjLozyXdzmzJzdYpaa7QS7aclDzBYl2iB5skAYvu+j8TvqAWVbeExzI5neamCNATYOPW5s+fwjPtRiPNDkbOeLSLZ3PimlOkkO7gq7XgEgsW1b3+kJnCEYrBRgOSl6WiXQjZSmnvzSOT+hqYmsoOQ3tHnt/KaOPmyxtlNxJjgGMztSOMsSpHDdH9M46C9290FQg7/POazd+1wacnqqWpky1tk8V+REOP+uiMTp4kF9JWMBixHQFswz6cMkV/xNO4MG8YZNhw9NJpkW6YyCM5OcP4ezYJigxGWc7Z6MtAbKBixD+Ch2BWh9M5+U1A2OKmS9qVPu+Yi7/YO5IlUM4WL6hOSRUKzNHzmvMRzCgLbd+YyH5Hbeou+SmoTo/bJirLeirhR6d8prAS1coqMdkStVhH0SMtz/ooBy0GM2Q9epsIFlhRayHSJ+WuZx1bHHpPYrFHBewrz/X0qpmAubsUOgdrvtuO2EzRfVYBMsI0QeucHE9E
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS3PR01MB10390.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(346002)(376002)(136003)(396003)(39860400002)(451199015)(1590799012)(38070700005)(85182001)(36756003)(31696002)(6486002)(86362001)(478600001)(6506007)(71200400001)(53546011)(110136005)(966005)(6512007)(8936002)(91956017)(5660300002)(64756008)(316002)(6636002)(66946007)(8676002)(76116006)(54906003)(66476007)(66556008)(66446008)(2906002)(83380400001)(38100700002)(186003)(82960400001)(41300700001)(2616005)(122000001)(26005)(4326008)(31686004)(1580799009)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UGhYQTJ3V2F5TUtqdVZTZGdoUDJ3dGVKcC9VeElVbXNPV2Vnb2x4czIzTjhW?=
 =?utf-8?B?MkxEMVdSd1VTTkhGbjdZcjM5WEppZzhVdHhkWXVkOHMrMzZWRHRCbmJRM05n?=
 =?utf-8?B?YUpqaDFITG5vTjNCanY3RnRMNUtkdTEwZnVRQTZ5L0R0TmxtUzZkU2NsNGUw?=
 =?utf-8?B?dDhCc3VvRkZpandCOXJCTlNZZnJWUWxtemhKMzZkSXVKVlVIUlhSQ3ZqcHpn?=
 =?utf-8?B?YVFrQ0ZBeHRoSEh0eU90QndRZmlCSitTUEFoajRxeGErS0pxaHIyZjRvTjY0?=
 =?utf-8?B?RjEzVGdJQnBLbE1TUGF3QnZnU0VlNk9tM3ptRVlDT3JKdWxNdDBSSkUraHUy?=
 =?utf-8?B?OGp1UTVlVU5veHZOWEtaN2djM0FvejBOdkwrM2wvY1VJTlNvemhLTTNrVmRK?=
 =?utf-8?B?dmtlOEp3SFNiOHpvSnpndTdndHJWcDhSUE5Ld0pleTBLRGlNWXN1Z1FvQTVy?=
 =?utf-8?B?M3RGSEs4RFBxZkdpK3BJcXBIME8zYmJBVDhEWFNFTEVUM0tFQWZOWktvUm0y?=
 =?utf-8?B?L2wxMnNoMnYzTVVQQkR2QmMyNDMzZVRvam4zeVRvOFJhTW5hWlhESmFiNXNq?=
 =?utf-8?B?YlFWZm1rOUtSQ1FyTEhaNytlM3ptaldFeGUyZGpMNHcxNGVPcnUxaC84N1E0?=
 =?utf-8?B?b3ltVWY5OUlUeFo4dUpPQ1AydzM4cE1rZEhac2MzaTBmWjI1V1hLUkZ0OEZJ?=
 =?utf-8?B?WTRjRkVJdGhKZENvR2xDRThwK3MvQXl6djVNYUNmTnBTakw2MW9zVjBXV0lx?=
 =?utf-8?B?NkwyZnI3Q2xFeHRISTFrQUtHUzBBZFdvemNDUTVLZ0MwN1BTZWlIYmFsRGFl?=
 =?utf-8?B?MUhCMmFmODJ1YTZ4V1VKc1JUS3AzTmt0dVZqQmtMSzFjL0t5MHNGSER2RVFN?=
 =?utf-8?B?QVorekJkQlpxL2hzRVJ4eklqTjBLaG05cGJEMXM5Rk1JOGcxTTBRRm4zN1Jp?=
 =?utf-8?B?RGc5K2REOG45Wis2Zm4yeWNsSnEvVEFTZ0Y3Wk5hNnNTdWhoQXBqMk5ITEdC?=
 =?utf-8?B?M29JaTg4YkNJVFN0TWhWejh4QWJ2ZW9kRkJNOXB4M2FjUXplQVBYdTE4WEk2?=
 =?utf-8?B?VzkwMnN2KzhFeUZPZHAyZFdWc0JCcFpOcTRLWDFpVVprMlJzb2hYK1dOeVlD?=
 =?utf-8?B?NzQ0UkI4TXQwTUZHVnZzYUlqT1Z3N2FEemNSYUxsSEVJeEFwejhUbHBOaXcv?=
 =?utf-8?B?bHRBN1JTYzZFT09LdCtuRGFGV0tuRWtJRG50bjBxT0I3SjNlc0gwY2NaaHh0?=
 =?utf-8?B?SlhyOVRNeHBBSUlDMEhsaFl4TTBiSXg5OHJFWkFuSTJtSTlBT3JOTDNYVUhD?=
 =?utf-8?B?b25VUHdqeVQ1S0ltaVI4R2IvTTdHS1JxaXJmZlJEZFE4NUl1TDJWckw1RU5v?=
 =?utf-8?B?K3V1b0NKVk1uQWNWcFRtcXpPOUxHSUR2ZFp6NjQyakcybDdPU3N2bkt5cUNv?=
 =?utf-8?B?eXNGRGszUHJiUll0aWJWM2JnaWFQK3RMbzBEQ1FJRzJxKzNtajlQSjkyWHJQ?=
 =?utf-8?B?YkszTlpKOGx0THdrdnlJSDd6bzVuSXNoVW5kSFpad21CSG92d3lBdmJ3dkhL?=
 =?utf-8?B?RFkzQUJRSnhYcG90cG96OGxNYjBjMTZhZmNaTGRSbStmci9GcFdVVFlYWlJr?=
 =?utf-8?B?TEhRSUozWEhsY04ySnMwNFB1TTkxdlJnK04ybllGSGdKZkZaajU0WGw0TSti?=
 =?utf-8?B?SUYrdEdKcmJVZUx6Vkxlems1STFDN2hERXhUdTZ1TnV0dU9hYmlLWHMwa01R?=
 =?utf-8?B?YjdtdDQwOG80K0xQMUxqdW5DcXZHeC9QMWZtcmlXNk0rVmRTVGF4a250bGc0?=
 =?utf-8?B?VW9CTU1WMjdaaTZJWFNmb1NXNlhDWDhnSlR6ZmNNSS96Nng5ckp5S09qQTIy?=
 =?utf-8?B?Q09xbnh0ZzdJU0NHOFJwb1lkOStpb2J0aHQ0VHZhNkVRSU1hcml2eWswNW5I?=
 =?utf-8?B?OUtBeWNScWcrbEMvb1BzYkw1Z1pJKzA5RFQ3OG90RHE4U1V6dzF3Y0xqZlZP?=
 =?utf-8?B?OUpZeW82bkViKzJFR29GeTZhOXAyTE51NFI3VURBZVJucjNGZnlzdVVBdlZI?=
 =?utf-8?B?YXROMDJRcFd6QTZPamlqT2o5MElVR0srQ2hYK0RXVXNOWEkwaFR4dzFKWEJu?=
 =?utf-8?B?TTlIby83VldWM0JvY0t5NkF6UEZXZWQ1cmRqVHFLZy85aGFUdXE0cEVZb3Ft?=
 =?utf-8?B?ZXc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D363EFE907468E4191A0CE020FB81D8C@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: C6pSA8pKOYB/uEPV+RQ/+eS+s071nckLPAxv53+aHEMh9ImfX0Pb6rsHXKxXFu8NC+InQ/ic8pPCp8Ryp+KELx7v96Xd4dEuHlf3mooBjvj3GSUorJBE3nxGZbhyg525U3iBuNVJ4zf3lEbK9fN7MPQlqA+SCH9O9o66L42f+cbZDMMR0BzgiEoxzWZ/fuRNoMV18GK1Sg3YLtCJReB8QU5O9oEOsL7vsX8GQm8M+FtR1IMfiDqJFOeaYt7ZoXwPHiAqwZFS2Cjnx8i/SbE2smPGxqV3NIupIOGe9GJ2cBvZ8D5QSeU1//m+ptd9k4ZI031ZBeGc7XtYKxWqPaJT8Yd4Eo4KJSU+btZ/Y1zZ7ksa7GqqLVUai5hNWgz5oCa+1XWSSb0rBWanEbGEZoc+d4kGaxB0LmpyJi1mtPoK+t+FwFH/ZotY+ZxlHy2rPI7PUFlO0cx0bRqCIHoKpCUJZVf8d6DeCfcWpSk1GPVXqIU7Y/Ym6SQXS22x7tkcI+MIhmXj2b8BAWVl9riR6mDfAVnaHg/o5to6vMcBj9OFhfvf0uHosBkizaeOsRIfgoIOE26fJM7nz+O6dqm7/11UJELHBkjkRIzhE8bC4vfx8dSC5+AQ45v5+fhE+8Dpg8HUvGfsMhgnNr3ngVDk7+PGqjiI1Ry6/hfsNxh90d1EEUPOvJ6EHY5d8HwHmXLxyUx79QERXKVa5RKHRtW90ZX1zTQLwyplwR2t5lK/CNEvNAlVVZ89rfK4x0X7YvELvOfoTllETN2ZHRjUKDQ3UYUV3SApsubv27OhsG4265UFvYhQRhiHdV6Q3drnjxum0ikahzWaSozUxTBD333F56ojDP+RrYXSEmvUKfqCOGiVZX+uvP6cTdycS9OAIjvjyraO
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS3PR01MB10390.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cabad87e-e9ee-4335-6366-08dad472657f
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Dec 2022 14:35:02.0009
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qV//WFPdliC7HQEf4PRzQ0kAkluiXZLLxRfW8z+0uHbIyzLFZc3WeXSq+g9KOn15iSZ2TtEFnkrTXUPQEe1DoA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB9672
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,NICE_REPLY_A,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

DQoNCm9uIDEyLzIvMjAyMiA3OjQ1IFBNLCBaaHUgWWFuanVuIHdyb3RlOg0KPiBPbiBGcmksIERl
YyAyLCAyMDIyIGF0IDc6MDIgUE0gRGFpc3VrZSBNYXRzdWRhDQo+IDxtYXRzdWRhLWRhaXN1a2VA
ZnVqaXRzdS5jb20+IHdyb3RlOg0KPj4NCj4+IFRoZSBjb21taXQgNjg2ZDM0ODQ3NmVlICgiUkRN
QS9yeGU6IFJlbW92ZSB1bm5lY2Vzc2FyeSBtciB0ZXN0aW5nIikgY2F1c2VzDQo+PiBhIGtlcm5l
bCBjcmFzaC4gSWYgcmVzcG9uZGVyIGdldCBhIHplcm8tYnl0ZSBSRE1BIFJlYWQgcmVxdWVzdCwg
cXAtPnJlc3AubXINCj4+IGlzIG5vdCBzZXQgaW4gY2hlY2tfcmtleSgpLiBUaGUgbXIgaXMgTlVM
TCBpbiB0aGlzIGNhc2UsIGFuZCBhIE5VTEwgcG9pbnRlcg0KPj4gZGVyZWZlcmVuY2Ugb2NjdXJz
IGFzIHNob3duIGJlbG93Lg0KPj4NCj4+IFsgIDEzOS42MDc1ODBdIEJVRzoga2VybmVsIE5VTEwg
cG9pbnRlciBkZXJlZmVyZW5jZSwgYWRkcmVzczogMDAwMDAwMDAwMDAwMDAxMA0KPj4gWyAgMTM5
LjYwOTE2OV0gI1BGOiBzdXBlcnZpc29yIHdyaXRlIGFjY2VzcyBpbiBrZXJuZWwgbW9kZQ0KPj4g
WyAgMTM5LjYxMDMxNF0gI1BGOiBlcnJvcl9jb2RlKDB4MDAwMikgLSBub3QtcHJlc2VudCBwYWdl
DQo+PiBbICAxMzkuNjExNDM0XSBQR0QgMCBQNEQgMA0KPj4gWyAgMTM5LjYxMjAzMV0gT29wczog
MDAwMiBbIzFdIFBSRUVNUFQgU01QIFBUSQ0KPj4gWyAgMTM5LjYxMjk3NV0gQ1BVOiAyIFBJRDog
MzYyMiBDb21tOiBweXRob24zIEtkdW1wOiBsb2FkZWQgTm90IHRhaW50ZWQgNi4xLjAtcmMzKyAj
MzQNCj4+IFsgIDEzOS42MTQ0NjVdIEhhcmR3YXJlIG5hbWU6IFFFTVUgU3RhbmRhcmQgUEMgKGk0
NDBGWCArIFBJSVgsIDE5OTYpLCBCSU9TIDEuMTMuMC0xdWJ1bnR1MS4xIDA0LzAxLzIwMTQNCj4+
IFsgIDEzOS42MTYxNDJdIFJJUDogMDAxMDpfX3J4ZV9wdXQrMHhjLzB4NjAgW3JkbWFfcnhlXQ0K
Pj4gWyAgMTM5LjYxNzA2NV0gQ29kZTogY2MgY2MgY2MgMzEgZjYgZTggNjQgMzYgMWIgZDMgNDEg
YjggMDEgMDAgMDAgMDAgNDQgODkgYzAgYzMgY2MgY2MgY2MgY2MgNDEgODkgYzAgZWIgYzEgOTAg
MGYgMWYgNDQgMDAgMDAgNDEgNTQgYjggZmYgZmYgZmYgZmYgPGYwPiAwZiBjMSA0NyAxMCA4MyBm
OCAwMSA3NCAxMSA0NSAzMSBlNCA4NSBjMCA3ZSAyMCA0NCA4OSBlMCA0MSA1Yw0KPj4gWyAgMTM5
LjYyMDQ1MV0gUlNQOiAwMDE4OmZmZmZiMjdiYzAxMmNlNzggRUZMQUdTOiAwMDAxMDI0Ng0KPj4g
WyAgMTM5LjYyMTQxM10gUkFYOiAwMDAwMDAwMGZmZmZmZmZmIFJCWDogZmZmZjk3OTA4NTdiMDU4
MCBSQ1g6IDAwMDAwMDAwMDAwMDAwMDANCj4+IFsgIDEzOS42MjI3MThdIFJEWDogZmZmZjk3OTA4
MGZlMTQ1YSBSU0k6IDAwMDA1NTU2MGUzZTAwMDAgUkRJOiAwMDAwMDAwMDAwMDAwMDAwDQo+PiBb
ICAxMzkuNjI0MDI1XSBSQlA6IGZmZmY5NzkwOWM3ZGQ4MDAgUjA4OiAwMDAwMDAwMDAwMDAwMDAx
IFIwOTogZTdjZTQzZDk3ZjdiZWQwZg0KPj4gWyAgMTM5LjYyNTMyOF0gUjEwOiBmZmZmOTc5MDhi
MjljMzAwIFIxMTogMDAwMDAwMDAwMDAwMDAwMCBSMTI6IDAwMDAwMDAwMDAwMDAwMDANCj4+IFsg
IDEzOS42MjY2MzJdIFIxMzogMDAwMDAwMDAwMDAwMDAwMCBSMTQ6IGZmZmY5NzkwOGIyOWMzMDAg
UjE1OiAwMDAwMDAwMDAwMDAwMDAwDQo+PiBbICAxMzkuNjI3OTQxXSBGUzogIDAwMDA3ZjI3NmY3
YmQ3NDAoMDAwMCkgR1M6ZmZmZjk3OTJiNWM4MDAwMCgwMDAwKSBrbmxHUzowMDAwMDAwMDAwMDAw
MDAwDQo+PiBbICAxMzkuNjI5NDE4XSBDUzogIDAwMTAgRFM6IDAwMDAgRVM6IDAwMDAgQ1IwOiAw
MDAwMDAwMDgwMDUwMDMzDQo+PiBbICAxMzkuNjMwNDgwXSBDUjI6IDAwMDAwMDAwMDAwMDAwMTAg
Q1IzOiAwMDAwMDAwMTE0MjMwMDAyIENSNDogMDAwMDAwMDAwMDA2MGVlMA0KPj4gWyAgMTM5LjYz
MTgwNV0gQ2FsbCBUcmFjZToNCj4+IFsgIDEzOS42MzIyODhdICA8SVJRPg0KPj4gWyAgMTM5LjYz
MjY4OF0gIHJlYWRfcmVwbHkrMHhkYS8weDMxMCBbcmRtYV9yeGVdDQo+PiBbICAxMzkuNjMzNTE1
XSAgcnhlX3Jlc3BvbmRlcisweDgyZC8weGU1MCBbcmRtYV9yeGVdDQo+PiBbICAxMzkuNjM0Mzk4
XSAgZG9fdGFzaysweDg0LzB4MTcwIFtyZG1hX3J4ZV0NCj4+IFsgIDEzOS42MzUxODddICB0YXNr
bGV0X2FjdGlvbl9jb21tb24uY29uc3Rwcm9wLjArMHhhNy8weDEyMA0KPj4gWyAgMTM5LjYzNjE4
OV0gIF9fZG9fc29mdGlycSsweGNiLzB4MmFjDQo+PiBbICAxMzkuNjM2ODc3XSAgZG9fc29mdGly
cSsweDYzLzB4OTANCj4+IFsgIDEzOS42Mzc1MDVdICA8L0lSUT4NCj4+DQo+PiBMaW5rOiBodHRw
czovL2xvcmUua2VybmVsLm9yZy9sa21sLzE2NjY1ODIzMTUtMi0xLWdpdC1zZW5kLWVtYWlsLWxp
emhpamlhbkBmdWppdHN1LmNvbS8NCj4+IFNpZ25lZC1vZmYtYnk6IERhaXN1a2UgTWF0c3VkYSA8
bWF0c3VkYS1kYWlzdWtlQGZ1aml0c3UuY29tPg0KDQpHb29kIGNhdGNoLCB3YW50IHRvIGtub3cg
d2hhdCB3b3JrbG9hZCB5b3UgYXJlIHJ1bm5pbmcuDQpJIGhhdmUgbmV2ZXIgZ290IGl0IGluIHB5
dmVyYnMgdGVzdHMuDQoNCkFkZCBhIFRPRE9zOiBhZGQgcHl2ZXJicyB0ZXN0IHRvIGNvdmVyIHRo
aXMgc2NlbmFyaW8uDQoNClJldmlld2VkLWJ5OiBMaSBaaGlqaWFuIDxsaXpoaWppYW5AZnVqaXRz
dS5jb20+DQoNCg0KDQo+PiAtLS0NCj4+IE5PVEU6DQo+PiAgIEkgdGhpbmsgdGhlIGNvbW1pdCA2
ODZkMzQ4NDc2ZWUgaXMgbm90IHlldCBtZXJnZWQgdG8gVG9ydmFsZHMnIHRyZWUuDQo+PiAgIFBl
cmhhcHMgd2UgbWF5IGp1c3QgcmVtb3ZlIHRoZSBwYXRjaCBmcm9tIHRoZSBmb3ItbmV4dCB0cmVl
Lg0KPj4gICBJIGxlYXZlIHRoYXQgdG8gdGhlIG1haW50YWluZXJzIGFzIEkgYW0gbm90IGZhbWls
aWFyIHdpdGggcGF0Y2ggcmV2ZXJzaW9uLg0KPiANCj4gU3VyZS4gSWYgdGhpcyBpcyBmb3IgZm9y
LW5leHQsIGl0IGhhZCBiZXR0ZXIgYWRkICJbZm9yLW5ldHggUEFUQ0hdDQo+IFJldmVydCAiUkRN
QS9yeGU6IFJlbW92ZSB1bm5lY2Vzc2FyeSBtciB0ZXN0aW5nIiINCj4gDQo+IFRoYW5rcy4NCj4g
Wmh1IFlhbmp1bg0KPiANCj4+DQo+PiAgIGRyaXZlcnMvaW5maW5pYmFuZC9zdy9yeGUvcnhlX3Jl
c3AuYyB8IDMgKystDQo+PiAgIDEgZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKyksIDEgZGVs
ZXRpb24oLSkNCj4+DQo+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9pbmZpbmliYW5kL3N3L3J4ZS9y
eGVfcmVzcC5jIGIvZHJpdmVycy9pbmZpbmliYW5kL3N3L3J4ZS9yeGVfcmVzcC5jDQo+PiBpbmRl
eCA2NzYxYmNkMWQ0ZDguLjVkM2E0YzZmODFhMyAxMDA2NDQNCj4+IC0tLSBhL2RyaXZlcnMvaW5m
aW5pYmFuZC9zdy9yeGUvcnhlX3Jlc3AuYw0KPj4gKysrIGIvZHJpdmVycy9pbmZpbmliYW5kL3N3
L3J4ZS9yeGVfcmVzcC5jDQo+PiBAQCAtODMyLDcgKzgzMiw4IEBAIHN0YXRpYyBlbnVtIHJlc3Bf
c3RhdGVzIHJlYWRfcmVwbHkoc3RydWN0IHJ4ZV9xcCAqcXAsDQo+Pg0KPj4gICAgICAgICAgZXJy
ID0gcnhlX21yX2NvcHkobXIsIHJlcy0+cmVhZC52YSwgcGF5bG9hZF9hZGRyKCZhY2tfcGt0KSwN
Cj4+ICAgICAgICAgICAgICAgICAgICAgICAgICAgIHBheWxvYWQsIFJYRV9GUk9NX01SX09CSik7
DQo+PiAtICAgICAgIHJ4ZV9wdXQobXIpOw0KPj4gKyAgICAgICBpZiAobXIpDQo+PiArICAgICAg
ICAgICAgICAgcnhlX3B1dChtcik7DQo+PiAgICAgICAgICBpZiAoZXJyKSB7DQo+PiAgICAgICAg
ICAgICAgICAgIGtmcmVlX3NrYihza2IpOw0KPj4gICAgICAgICAgICAgICAgICByZXR1cm4gUkVT
UFNUX0VSUl9SS0VZX1ZJT0xBVElPTjsNCj4+IC0tDQo+PiAyLjMxLjENCj4+
