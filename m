Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B71C2542F10
	for <lists+linux-rdma@lfdr.de>; Wed,  8 Jun 2022 13:23:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237500AbiFHLXS (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 8 Jun 2022 07:23:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237507AbiFHLXL (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 8 Jun 2022 07:23:11 -0400
Received: from esa3.fujitsucc.c3s2.iphmx.com (esa3.fujitsucc.c3s2.iphmx.com [68.232.151.212])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28E673BC3E0
        for <linux-rdma@vger.kernel.org>; Wed,  8 Jun 2022 04:23:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1654687390; x=1686223390;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=wojmQSSDeI2SJLNoX/4CbRn87gCerjqreJKGixIZh7c=;
  b=AIdTX6jqRbnrsYKfIefnJhzccapruWuFgZidKAaYusfpt95cTp69a6dO
   xgHQ9ED7t1Jz1fseEwjsX/9GhzoJ6Y8q3xRSgWALICtwU3Fd/47vAFh9G
   bxTD7sjUZLiGY0F8UYd2OzNtzNratHJLRUVc7LevpQfy5KtDogsIYViU2
   Eh6hR3rioQ8lSJA1ohJt7X2XXXMmAgKL0ZfFFMJdUsX57Oz0B1pocfNZL
   bc8R2RpChrzGJt69CT6Ku0kAYoKErs6/zfkSy4CBmp6H5I7/7UFQGuyrY
   pte8JNXocYBWXJN80Sa0CtASa8BlbKZYoTeQUFVrzkZl9+Zjkt8RNWQS+
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10371"; a="65695713"
X-IronPort-AV: E=Sophos;i="5.91,286,1647270000"; 
   d="scan'208";a="65695713"
Received: from mail-os0jpn01lp2106.outbound.protection.outlook.com (HELO JPN01-OS0-obe.outbound.protection.outlook.com) ([104.47.23.106])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jun 2022 20:23:05 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GuDZfQtoid0mETfduxmw2S0fzz6LPYhgjKpEuQHMcqjkuCLXPe/x/ys/sZsQLGyLyCj6xc4gAtHe265o89sawaRPfBCHaTV6QRXcWwcwLFWlTVm8DCTXVokGueWcRAIwkB0Qt2mEEf7LVi/hhof4xoovJa6oxX7Lr4bLF0yyqAbAjNutEY+HPgMH/+wN1Slbt4W8kfP6OpIAX+q1ytOcQKyrZ1AOCoGPFlbrmB5HAhMwZPeeaHwoyXvSvmmILxAQihguY3Hk5eERkwxF1e61zS7eQDaU1mQZZg1pp7tb1vtLDcTXiHinzZCW/PMWnqLEgiDbm0Rim6uFRne43eTrNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wojmQSSDeI2SJLNoX/4CbRn87gCerjqreJKGixIZh7c=;
 b=Rk04IqAtuX1QuqFGiTBr3jrcjsVdq37vGf24v0b/EN/F0PviolEjmzpcwmiw7hcHQhyrwMWnZvDvZyT7CEhLEvhYpRO3GYngzwS32dF3h6nUOPM9SjffaOmxWCPLbFaale7+LByLgngtcYjf1gWx8JEbr1cH+xoMnLTNvc42ZrV6WFNPsOJ72mDw4rVOF02wx2F1smQErXHNHdMV+xN2r8MSZhysiCpmkbAQHPjUJdMEgzoJcA819YMqxSywRa/g4E9an1PzLLYwo9ya34pDyEQLD7rzdxxJyJ7NBu2XpVQJPGzSqsD9y0ENzw/xhbr1pY0OdZtpDNmABVtUoYWwEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wojmQSSDeI2SJLNoX/4CbRn87gCerjqreJKGixIZh7c=;
 b=c70rob4G9vO+UKDin5hHTWPYRdC/1RRnzGKoYKb6Y8lyQY8308mM2dtlW1ueCMAPpecLkCIPFQKLOdt4abOurEDeApg5kb3PHeiGz0QKljmq/YGhwxMnqM8OGiYlvkc313LRiLYC5xbWpdzulIwvfKbak3dbRQER50EJJQonO/k=
Received: from TYCPR01MB9305.jpnprd01.prod.outlook.com (2603:1096:400:196::10)
 by TYAPR01MB5387.jpnprd01.prod.outlook.com (2603:1096:404:803a::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.13; Wed, 8 Jun
 2022 11:23:03 +0000
Received: from TYCPR01MB9305.jpnprd01.prod.outlook.com
 ([fe80::6012:5658:1673:1e91]) by TYCPR01MB9305.jpnprd01.prod.outlook.com
 ([fe80::6012:5658:1673:1e91%3]) with mapi id 15.20.5314.019; Wed, 8 Jun 2022
 11:23:03 +0000
From:   "lizhijian@fujitsu.com" <lizhijian@fujitsu.com>
To:     Bob Pearson <rpearsonhpe@gmail.com>
CC:     Zhu Yanjun <zyjzyj2000@gmail.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "Hack, Jenny (Ft. Collins)" <jhack@hpe.com>,
        Frank Zago <frank.zago@hpe.com>, Jason Gunthorpe <jgg@ziepe.ca>
Subject: Re: [RFC] Alternative design for fast register physical memory
Thread-Topic: [RFC] Alternative design for fast register physical memory
Thread-Index: AQHYb72XOVxLfknNHkidJpuDRmgnX60yrwUAgBLFugA=
Date:   Wed, 8 Jun 2022 11:23:03 +0000
Message-ID: <46f9f366-d31e-c600-4ac6-7ec440d6baff@fujitsu.com>
References: <78918262-6060-546b-134d-2d29bbefb349@gmail.com>
 <20220527124240.GB2960187@ziepe.ca>
In-Reply-To: <20220527124240.GB2960187@ziepe.ca>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ca6cfd85-33ff-4892-41e9-08da494140a9
x-ms-traffictypediagnostic: TYAPR01MB5387:EE_
x-microsoft-antispam-prvs: <TYAPR01MB5387D67C2C5F912F8295E92FA5A49@TYAPR01MB5387.jpnprd01.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: PAn34zx7LNjuDofStOxKb1Tm4o/i94lGxqiE6sKaD1blBEmYbqPIDC9j88yfhgx13I7kt4KPOD8IImny6wQKw9Kw5bxxiRkfiY9iw2ZivTCoBMy36eEjJiviSplNYEYdnyhID0tF+24Us72UPsms7QtMT8LNALAQ7k7cMv3is4onSIwJHKnG2GCCPdQ8PkAppVgf39mqoK8sXUdMIPO0MvFr4zo4Z2ZEs5kW2utSDwtkosmEmz8nXER2GvDtpjWq+IuHGv1Vxejo5FDmC1ZfRHUD0R1jhWuErqdlX9BpESSAUeYSg9tcD4ihaLse9rZgRvIFy4ISxklOPqTWoYO7Pvdgh+8wvlSXDa5QwVpUSnoG2hbOGYpDngF/wQ+E6h1W31yhSowPrVZtITV5/VjjcM5Kahl7hnZUiD7ggbpvwLusJjPXOClT2ERDHXzfNuZ+GTDDSknvuI2w1srZZ64Eh5B5MifqpnjMb5TkcedOC15IFY//S6wIXn96VoLO6ijGY2RCkKPuxJ9GWB+uo77YG/V6kRA7xYDZvb5P1ifi2Zy+mDgyfrmO7oiVHTS411GG3DplHzEWKkG6bc0k5Y//RHK+UreiPCre4gtfV/7Q2/T5D2awf22H1RkQqFerg4MnLiehBKjlKiHhHJzr1nFyo4nrVVG+3OAuQpK19C2HDotmXLAl7YqeGvQN1Q8N9lkBHsGERHggRwWjtDJlsOiO4cN7hhvk4Z89Rkvb/hVTYZLqZjOS9z1LQq2Laf0jhJig++VJ4LfRqk1ftZ/eoxTO7w==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB9305.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(6916009)(31686004)(2906002)(186003)(54906003)(6486002)(31696002)(6512007)(4326008)(26005)(38100700002)(83380400001)(64756008)(66446008)(66476007)(91956017)(76116006)(66946007)(66556008)(8676002)(316002)(71200400001)(85182001)(5660300002)(508600001)(53546011)(122000001)(2616005)(8936002)(38070700005)(86362001)(36756003)(6506007)(82960400001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MHlCVmlHSFhYdVpXNDRGNFJ3SHc1WHNoL0d6bTQxSnBRNzRxQUw4U1JBVUFH?=
 =?utf-8?B?citlNTYxRkdhWE1zazZZakN5Mm9uTHd0ZXJvME1JYVRGRDBNQzRGVEZUb21R?=
 =?utf-8?B?eHlQNDcxZHRUQk5UNWdLR3F6SFJGeExpNnhOR1hGVEh1c3lKNU5yeWtNajRh?=
 =?utf-8?B?SzI4OHMrK0RHZk5BQnpqZmFGbXFlMU5DSEZOTUNhaC9MSlExZlM4MmFDN09H?=
 =?utf-8?B?ZURSM1ZnWHdGNG9aZVRabHNDdHpSdnowK1dTL1RId3dJNU9wUWl4MlZmVjlk?=
 =?utf-8?B?MHlJTjloM2l3M3hENDJ5TjZlelZzV051S1liSmo1UUkrRmRnSnhsRGpUQlh6?=
 =?utf-8?B?OHYrQ25SdmNBVnpyc2NoUGpZakxNSzdHQWRJTHo2VGlrdFloNTFOclV5QmJN?=
 =?utf-8?B?MEE5NnUxTjFaMmpubnpRc2NVZ0NlUXFqOCtiY3VaM0l0aG4rTHUrNTRmbElD?=
 =?utf-8?B?QTFZNXZZUkp0YnJ1YUs3WHQ5VnQvWFNLWkFPQ2NVaWI2T2twRFNEbVVHd3BE?=
 =?utf-8?B?VmlyKzFnOHFRajZ1K2ZkdHo2MytMVWtZdmNnWDhpWmhhYnZWdCtUL0RRaC9W?=
 =?utf-8?B?cmRLRWU1ZUJSMzVMcytyVVdEbXVVc3JzU0xMZmpZSXdqcG9tc0kwaC9WUFQ5?=
 =?utf-8?B?QXpHQkp2YVZxeTdDSFdIQVBkVHhYZCtFN2ppRlJPc3JVWFcwUjNVQWVHNjI0?=
 =?utf-8?B?V0RZTndrTFpEMUkrZkpyVmNnelFlVnVvY1diYU9EMkhWMStMQ2E1UmZicXFw?=
 =?utf-8?B?VE90eGViYm5LYThvdFFZMUM1eGFCekRoOWllOUZNYUw3NGViZGliZStNaEFP?=
 =?utf-8?B?cXZQMU1oYzMvNXlEKytCVnl1MnJPT09pL1FpM2g4WVRqbHFyLzdhWFhLNkYz?=
 =?utf-8?B?djlKYzdyRDB6ZW16Y3dZZE5OYUp2QUwxazlyOTdDbEtseTBFeTVuamhYRW56?=
 =?utf-8?B?RnpFMGU5U3dmdUZYS0xHMjRodGhSYSt1WlNXWS9uTXJxRklzZHBkTGk0ckxB?=
 =?utf-8?B?bDZlWFdvNEJEVHN3V0JqTEphd2J0dGxXd1lCVHNFNlVsMy95Z0Jub0xLSmZC?=
 =?utf-8?B?WEV6UGpUZVIxelcxNStTMC9FRUFjNDg0M3pDaktrQUhlVkRpMDd1T1pJL1lj?=
 =?utf-8?B?OENESG4wZ2w0MVNTeEtUN2s0MlhpSVEwcnBGYmZaQjJ4OWljaE4vbkVITnI3?=
 =?utf-8?B?T1MzcC95eHdyd25OMFV2Y002RjhNZnlPMHV5Z3Z2ajgwMFBQK2ZFWXJqaWxL?=
 =?utf-8?B?dS9sTnVrOFJBZGdsbmNWYlcyWmV0QzdkZXJ3UFg1Z2pia1Byb3dobTBLTm5s?=
 =?utf-8?B?V3Q3R3BxNE1kNkUrakdjU0k1bUo3N2hnSUpEalM5b0tYaDJRQ0VPY2JvRDJz?=
 =?utf-8?B?QzYzeldQNTh6dVJ5ZHV0YVlHallrUWcwTkVSTEJzZUxUNUJ3VjNLUGJZaUZq?=
 =?utf-8?B?NVNsZ1gyUWlYWjJUUklJYmpTcE54MG8zelpLWUxlZG5jN2tSUEVRa2lWcys2?=
 =?utf-8?B?Z3dCTSszWEd2QWtnMTZlTTloelMrNjFrZDh3RGRBRnlyRnpVbjZsSWxLWSth?=
 =?utf-8?B?UnAweFNWVE5kL3JkVEk0c0c0dnRFUHQ5R3kvRzZPT0RseHFHYjRUZzFGVXJH?=
 =?utf-8?B?K05zUVZlR2hlUjlsUTlDdUQ2eEtmM0hhcThMRTdYVWNCZXNocWFTVDJ2UnVo?=
 =?utf-8?B?SCtOK1hqWEhQa3o0ZWl2b01HN2R3SjIyaG5MRGZGeEN4eWZqTUlLRGdEemRm?=
 =?utf-8?B?ZE04alR4L1NyV3ZacFNuZXRXUVlmV1l0ZkZBVjl3Mmp1TXp2cEZMY3VreVRm?=
 =?utf-8?B?c3J4MjVTTmV2SjBSSmNtQitmaGhTcWxoSmFYa3ZseE5Ed3cyMTN5L2dMN0JW?=
 =?utf-8?B?UHAwdGhyaXRpQ3U4WllNdUhCL0lkV1NhWFIrM1Z4bmJZdkMrMnhnQW44RDBL?=
 =?utf-8?B?aHIyYVpUVFE2aHM4VCtQM3ZDbGs5b3hmRGFBM3l2RFRLdTB6dW5NTHR1VW9h?=
 =?utf-8?B?RkNKL1g3bmNDZjlGa1BRN2t0TTdoSkczMFZFYXQyYVFvd0pkeVduWmlaNnhV?=
 =?utf-8?B?bXI2bG01TGo4S2I0c2ZidEwveUFVYXk5NXVaT3JHNlFFTGlPVXFkdDlXTnN0?=
 =?utf-8?B?Q0pjelNTbHZZWmhMZDdzakxKZjQ1eXE0UGhkU2dhZjRCL21GM0tTSldGN0Yz?=
 =?utf-8?B?TUxuTzhEQ3M3T3JTa090cHhhZE5FV1lrTnZEd2VjTzByQmxudTJoS3Rzd1h2?=
 =?utf-8?B?TWtLRzJXRnV5Qy9PbTVsajBQdmlSNXFPNWlvVzMrWTU1UVpUaXlEMDBwai9y?=
 =?utf-8?B?Qm5qTklCck15QmxEVGxVR3hvUUh5TEFUQXVnZ09VVklWbFMwZ3dQWFpmVm55?=
 =?utf-8?Q?9FgzoOCJCtyN3X1U=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <6E6D021A8FF24D4A8E73EFC2ADB0C20F@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB9305.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ca6cfd85-33ff-4892-41e9-08da494140a9
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jun 2022 11:23:03.2257
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4L1VQrOc9gzkCo686tHsOCxd2FTaJYwcAFEjKEFE98ouKYVAwdl6n5wMZjEFDSZBXOoiUNVscWYq3ts/SIlIiQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYAPR01MB5387
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

SGV5IEJvYg0KDQpTb3JyeSB0byBkaXN0dXJiIHlvdS4gQXJlIHlvdSBnb2luZyB0byByZXZlcnQg
aXQgdG8gc2luZ2xlIG1hcCBhcyB0aGUgc3VnZ2VzdGlvbiBmcm9tIEphc29uDQoNCg0KVGhhbmtz
DQpaaGlqaWFuDQoNCg0KT24gMjcvMDUvMjAyMiAyMDo0MiwgSmFzb24gR3VudGhvcnBlIHdyb3Rl
Og0KPiBPbiBUdWUsIE1heSAyNCwgMjAyMiBhdCAwNToyODowMFBNIC0wNTAwLCBCb2IgUGVhcnNv
biB3cm90ZToNCj4NCj4+IFdlIGhhdmUgYSB3b3JrIGFyb3VuZCBieSBmZW5jaW5nIGFsbCB0aGUg
bG9jYWwgb3BlcmF0aW9ucyB3aGljaCBtb3JlDQo+PiBvciBsZXNzIHdvcmtzIGJ1dCB3aWxsIGhh
dmUgYmFkIHBlcmZvcm1hbmNlLiAgVGhlIG1hcHMgdXNlZCBpbiBGTVJzDQo+PiBoYXZlIGZhaXJs
eSBzaG9ydCBsaWZldGltZXMgYnV0IGRlZmluaXRlbHkgbG9uZ2VyIHRoYW4gd2Ugd2UgY2FuDQo+
PiBzdXBwb3J0IHRvZGF5LiBJIGFtIHRyeWluZyB0byB3b3JrIG91dCB0aGUgc2VtYW50aWNzIG9m
IGV2ZXJ5dGhpbmcuDQo+IElCVEEgc3BlY2lmaWVzIHRoZSBmZW5jZSByZXF1aXJlbWVudHMsIEkg
dGhvdWdodCB3ZSBkZWNpZGVkIFJYRSBvcg0KPiBtYXliZSBldmVuIGx1c3RyZSB3YXNuJ3QgZm9s
bG93aW5nIHRoZSBzcGVjPw0KPg0KPj4gVG8gbWFrZSB0aGlzIGFsbCByZWNvdmVyYWJsZSBpbiB0
aGUgZmFjZSBvZiBlcnJvcnMgbGV0IHRoZXJlIGJlIG1vcmUNCj4+IHRoYW4gb25lIG1hcCBwcmVz
ZW50IGZvciBhbiBGTVIgaW5kZXhlZCBieSB0aGUga2V5IHBvcnRpb24gb2YgdGhlDQo+PiBsL3Jr
ZXlzLg0KPiBSZWFsIEhXIGRvZXNuJ3QgaGF2ZSBtb3JlIHRoYW4gb25lIG1hcCwgdGhpcyBzZWVt
cyBsaWtlIHRoZSB3cm9uZw0KPiBkaXJlY3Rpb24uDQo+DQo+IEFzIHdlIGRpc2N1c3NlZCwgdGhl
cmUgaXMgc29tZXRoaW5nIHdyb25nIHdpdGggaG93IHJ4ZSBpcyBwcm9jZXNzaW5nDQo+IGl0cyBx
dWV1ZXMsIGl0IGlzbid0IGZvbGxvd2luZyBJQlRBIGRlZmluZSBiZWhhdmlvcnMgaW4gdGhlDQo+
IGV4Y2VwdGlvbmFsIGNhc2VzLg0KPg0KPj4gQWx0ZXJuYXRpdmUgdmlldyBvZiBGTVJzOg0KPj4N
Cj4+IHZlcmI6IGliX2FsbG9jX21yKHBkLCBtYXhfbnVtX3NnKQkJCS0gY3JlYXRlIGFuIGVtcHR5
IE1SIG9iamVjdCB3aXRoIG5vIG1hcHMNCj4+IAkJCQkJCQkgIHdpdGggbC9ya2V5ID0gW2luZGV4
LCBrZXldIHdpdGggaW5kZXgNCj4+IAkJCQkJCQkgIGZpeGVkIGFuZCBrZXkgc29tZSBpbml0aWFs
IHZhbHVlLg0KPj4NCj4+IHZlcmI6IGliX3VwZGF0ZV9mYXN0X3JlZ19rZXkobXIsIG5ld2tleSkJ
CS0gdXBkYXRlIGtleSBwb3J0aW9uIG9mIGwvcmtleQ0KPj4NCj4+IHZlcmI6IGliX21hcF9tcl9z
Zyhtciwgc2csIHNnX25lbnRzLCBzZ19vZmZzZXQpCQktIGNyZWF0ZSBhIG5ldyBtYXAgZnJvbSBh
bGxvY2F0ZWQgbWVtb3J5DQo+PiAJCQkJCQkJICBvciBieSByZS11c2luZyBhbiBJTlZBTElEIG1h
cC4gTWFwcyBhcmUNCj4+IAkJCQkJCQkgIGFsbCB0aGUgc2FtZSBzaXplIChtYXhfbnVtX3NnKS4g
VGhlDQo+PiAJCQkJCQkJICBrZXkgKGluZGV4KSBvZiB0aGlzIG1hcCBpcyB0aGUgY3VycmVudA0K
Pj4gCQkJCQkJCSAga2V5IGZyb20gbC9ya2V5LiBUaGUgaW5pdGlhbCBzdGF0ZSBvZg0KPj4gCQkJ
CQkJCSAgdGhlIG1hcCBpcyBGUkVFLiAoYW5kIHRodXMgbm90IHVzYWJsZQ0KPj4gCQkJCQkJCSAg
dW50aWwgYSBSRUdfTVIgd29yayByZXF1ZXN0IGlzIHVzZWQuKQ0KPiBNb3JlIHRoYW4gb25lIG1h
cCBpcyBub25zZW5zZSwgcmVhbCBIVyBoYXMgYSBzaW5nbGUgbWFwLCBhIE1SIG9iamVjdCBpcyB0
aGF0DQo+IHNpbmdsZSBtYXAuDQo+DQo+PiBUaGlzIGlzIGFuIGltcHJvdmVtZW50IG92ZXIgdGhl
IGN1cnJlbnQgc3RhdGUuIEF0IHRoZSBtb21lbnQgd2UgaGF2ZQ0KPj4gb25seSB0d28gbWFwcyBv
bmUgZm9yIG1ha2luZyBuZXcgb25lcyBhbmQgb25lIGZvciBkb2luZyBJTy4gVGhlcmUgaXMNCj4+
IG5vIHJvb20gdG8gYmFjayB1cCBidXQgYXQgdGhlIG1vbWVudCB0aGUgcmV0cnkgbG9naWMgYXNz
dW1lcyB0aGF0DQo+PiB5b3UgY2FuIHdoaWNoIGlzIGZhbHNlLiBUaGlzIGNhbiBiZSBmaXhlZCBl
YXNpbHkgYnkgZm9yY2luZyBhbGwNCj4+IGxvY2FsIG9wZXJhdGlvbnMgdG8gYmUgZmVuY2VkIHdo
aWNoIGlzIHdoYXQgd2UgYXJlIGRvaW5nIGF0IHRoZQ0KPj4gbW9tZW50IGF0IEhQRS4gVGhpcyBj
YW4gaW5zZXJ0IGxvbmcgZGVsYXlzIGJldHdlZW4gZXZlcnkgbmV3IEZNUg0KPj4gaW5zdGFuY2Uu
ICBCeSBhbGxvd2luZyB0aHJlZSBtYXBzIGFuZCB0aGVuIGZlbmNpbmcgd2UgY2FuIGJhY2sgdXAN
Cj4+IG9uZSBicm9rZW4gSU8gb3BlcmF0aW9uIHdpdGhvdXQgdG9vIG11Y2ggb2YgYSBkZWxheS4N
Cj4gSU1ITyB5b3UgbmVlZCB0byBnbyBiYWNrIHRvIG9uZSBtYXAgYW5kIGZpeCB0aGUgcXVldWUg
cHJvY2Vzc2luZw0KPiBsb2dpYyB0byBiZSBzcGVjIGNvbXBsaWFudC4NCj4NCj4gSmFzb24NCg==
