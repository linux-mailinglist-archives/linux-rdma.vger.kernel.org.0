Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F11768E8BD
	for <lists+linux-rdma@lfdr.de>; Wed,  8 Feb 2023 08:14:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229515AbjBHHOD (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 8 Feb 2023 02:14:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjBHHOB (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 8 Feb 2023 02:14:01 -0500
X-Greylist: delayed 63 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 07 Feb 2023 23:13:59 PST
Received: from esa12.fujitsucc.c3s2.iphmx.com (esa12.fujitsucc.c3s2.iphmx.com [216.71.156.125])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9561227AB
        for <linux-rdma@vger.kernel.org>; Tue,  7 Feb 2023 23:13:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1675840440; x=1707376440;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=kIBAR3lF90b/BFVOwSuL+2RTtydJ7KBXKvwmsl6QN5g=;
  b=ezqq7wK3l/rUKlABfW8UOy0VF6GAQ1OwfZADrVMBUsBvFZpAX713azq/
   DqOuBN7HbSMbpJsMJ2nLOFk10ytzuKxFgjQXmAiX+jPc2GkO+4v0p0IJE
   pg/v4CUggIXTmdcU7roZqH1RPai4AC1O89NU4tR8c9X/6CwhQXJ5RpYYH
   tCtgZmMT9hnU74T7mb+mbL93v15UYEPBFxhqTLduA/QZ7JTINcO0Efx+W
   OjHwAHLL7hQ5a91fy6dCO2BCYrzzcwve4hZFkWr/CCd4ncE1RYXduS8mA
   WUT2uBfoDay6thy5LIz4qrd4Qj9navdiQzDMNozyhN0+QwvJ9YiqmJOz3
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10614"; a="76619925"
X-IronPort-AV: E=Sophos;i="5.97,280,1669042800"; 
   d="scan'208";a="76619925"
Received: from mail-sgaapc01lp2110.outbound.protection.outlook.com (HELO APC01-SG2-obe.outbound.protection.outlook.com) ([104.47.26.110])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2023 16:12:52 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JWGuxySo8e1HQqIwzXYU5cVEO8m+Ol5jXUlcTG+nLkmal189sqpdmswKgMUzlsVbaiWGibbZfaqxSYB8SGdKhDms03E/0mIuuk+HgX2oZs+M32AOqrOfbi1V2Xo7PQ+Wn9qA8M2IYhqhKq8ZLrBGZfie5ezjlDtNKf7F/ASTZ0SPSC45OYIgzRL8aDqTnVj/yj2Qjf/qIK6RP/od3WyIHPREpGm30qIY7n5gaZOL0h35U7zK1Jt3VOvo5Wzhf0LF+PjFkY29wU1irBywfcJgAqRFueYHD4DMaLjhaxXK0OZH7tSimwir8R6XxUBoNle5hQ8yE4ezMUmeGURDK9R3tw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kIBAR3lF90b/BFVOwSuL+2RTtydJ7KBXKvwmsl6QN5g=;
 b=U6ZBNVxZ21XGEy5rJextfZjVa6ooS4YXHsoDIOZO3KSC0w4si0unZRcu7Blw3ro0qhHXRdfMImoWF6YS594V3J0UakRy8PC/gM38N9/edQ1Rr3WsLoEgbvB6Qq20bVLDOoOCja30NIo3rCNlu0sLjfhwEi2dFOced9w7VuZAG/WYf1N5I6QolVmPkGPLUn5l698XmowI0SC52Vyeg1xyTIPMEQUiclSesBqwP8bwdjtSOoorHhGgEQ2iHn8WwLpwkLZQv0+h2647/R6gJvK9nfcdN+JNwfNgHijjOYNpz7bttQ8lLoGfqz0cToqh+f1VuhsTwXzn+8+35mJUhzEZJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from TYCPR01MB8455.jpnprd01.prod.outlook.com (2603:1096:400:15d::13)
 by TY3PR01MB9696.jpnprd01.prod.outlook.com (2603:1096:400:222::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.36; Wed, 8 Feb
 2023 07:12:49 +0000
Received: from TYCPR01MB8455.jpnprd01.prod.outlook.com
 ([fe80::4323:2aa5:fe7c:6a3]) by TYCPR01MB8455.jpnprd01.prod.outlook.com
 ([fe80::4323:2aa5:fe7c:6a3%4]) with mapi id 15.20.6086.017; Wed, 8 Feb 2023
 07:12:49 +0000
From:   "Daisuke Matsuda (Fujitsu)" <matsuda-daisuke@fujitsu.com>
To:     'Bob Pearson' <rpearsonhpe@gmail.com>,
        "jgg@nvidia.com" <jgg@nvidia.com>,
        "zyjzyj2000@gmail.com" <zyjzyj2000@gmail.com>,
        "leonro@nvidia.com" <leonro@nvidia.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "yangx.jy@fujitsu.com" <yangx.jy@fujitsu.com>,
        "lizhijian@fujitsu.com" <lizhijian@fujitsu.com>,
        "tom@talpey.com" <tom@talpey.com>
Subject: Re: [PATCH for-next v4] Subject: RDMA/rxe: Handle zero length rdma
Thread-Topic: [PATCH for-next v4] Subject: RDMA/rxe: Handle zero length rdma
Thread-Index: AQHZNsEksOa6eDMa4k2zkvGhx4F3Za688xXQgACfSYCABZuAgA==
Date:   Wed, 8 Feb 2023 07:12:48 +0000
Message-ID: <TYCPR01MB845509552E8407547478695BE5D89@TYCPR01MB8455.jpnprd01.prod.outlook.com>
References: <20230202044240.6304-1-rpearsonhpe@gmail.com>
 <TYCPR01MB84555DAEE984472F7B209B80E5D79@TYCPR01MB8455.jpnprd01.prod.outlook.com>
 <cd9fda7b-3613-c5a4-7dc9-95433cf4dee4@gmail.com>
In-Reply-To: <cd9fda7b-3613-c5a4-7dc9-95433cf4dee4@gmail.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-securitypolicycheck: OK by SHieldMailChecker v2.5.2
x-shieldmailcheckerpolicyversion: FJ-ISEC-20170217
x-shieldmailcheckermailid: db17bf3449df4aa69c584d910b59f82f
msip_labels: =?utf-8?B?TVNJUF9MYWJlbF9hNzI5NWNjMS1kMjc5LTQyYWMtYWI0ZC0zYjBmNGZlY2Uw?=
 =?utf-8?B?NTBfRW5hYmxlZD10cnVlOyBNU0lQX0xhYmVsX2E3Mjk1Y2MxLWQyNzktNDJh?=
 =?utf-8?B?Yy1hYjRkLTNiMGY0ZmVjZTA1MF9TZXREYXRlPTIwMjMtMDItMDhUMDc6MDk6?=
 =?utf-8?B?MzVaOyBNU0lQX0xhYmVsX2E3Mjk1Y2MxLWQyNzktNDJhYy1hYjRkLTNiMGY0?=
 =?utf-8?B?ZmVjZTA1MF9NZXRob2Q9U3RhbmRhcmQ7IE1TSVBfTGFiZWxfYTcyOTVjYzEt?=
 =?utf-8?B?ZDI3OS00MmFjLWFiNGQtM2IwZjRmZWNlMDUwX05hbWU9RlVKSVRTVS1SRVNU?=
 =?utf-8?B?UklDVEVE4oCLOyBNU0lQX0xhYmVsX2E3Mjk1Y2MxLWQyNzktNDJhYy1hYjRk?=
 =?utf-8?B?LTNiMGY0ZmVjZTA1MF9TaXRlSWQ9YTE5ZjEyMWQtODFlMS00ODU4LWE5ZDgt?=
 =?utf-8?B?NzM2ZTI2N2ZkNGM3OyBNU0lQX0xhYmVsX2E3Mjk1Y2MxLWQyNzktNDJhYy1h?=
 =?utf-8?B?YjRkLTNiMGY0ZmVjZTA1MF9BY3Rpb25JZD0yODA3OWRlNi0yZGNkLTRhODQt?=
 =?utf-8?B?OGIzMS0yZjZiMjA4MDRjNDU7IE1TSVBfTGFiZWxfYTcyOTVjYzEtZDI3OS00?=
 =?utf-8?B?MmFjLWFiNGQtM2IwZjRmZWNlMDUwX0NvbnRlbnRCaXRzPTA=?=
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYCPR01MB8455:EE_|TY3PR01MB9696:EE_
x-ms-office365-filtering-correlation-id: a7d45bc9-7626-4f47-bb06-08db09a3e2a6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ZRGnFHVs9P4Q1rYUUPmLQzYPfljcoe2AMBV7aRHalw9c1xwXVDiCJO6PYKHuITdNnoeqwrd0kt5D5pagJvyG1EcROz155JiUVf/A95UgvleCbLWM5TDXv5QyJtEc5EWLAU6G6nMvhmOn/AWmdtHQVqy4pkL2N3gfYFMkMPSYj6X6vuFYj8l2JCMjeWGrOQZqTRxhUcu7rdkHBSNZsPUwBDeewVVOxKqhG/tuMcNcbevNwKUdhyFl27YWbQeDlP5Wa706s43dXKrFCgS9CNDf0gPTY8YoOEh/14QFqjRHbM37lq5XVxU5LOuxi4CX4oZZmLRM6qlE+kILoY0BH2n/YkIzDWh+J2E38xL59yFiWfrqX/UYFBITCfGug716CXgifWtmjO2ZiWLpLQ/jszGVdOjKGZTT5ghJwQaNJEqYXT72RkoYy+2mdy9MmxlUrb6gJjrURqbvAoR9pWC7Ili5ryDfph/j3XiCgyBWrYXGCG6pQdmTs0GdwzlfPnRsV2o/38onR9kg5YqE4dhdXeEyEPSXCpMQGfNhupMTBXYmtRuoKUQzcT+xroAbci8vRQV7o8B1eU0p2jX/tOP0itNo1EKa+SnyZRdaKIcVpz6vU+IbM2VbR1OTzCOcQaUXs8PFzV7AP9g8kygXje8WBHh7WHa+vrpVmRZ0a/PNSRfsenH/pkAz0F2XoL8nPCdfl+kJIBv2mi1TYrNTzNmCTiLkwqVNo5Vtv3rLTFRn6+FDvZw=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB8455.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(396003)(346002)(136003)(39860400002)(366004)(376002)(451199018)(1590799015)(83380400001)(316002)(122000001)(53546011)(85182001)(82960400001)(86362001)(41300700001)(2906002)(110136005)(71200400001)(6506007)(186003)(26005)(9686003)(38070700005)(33656002)(1580799012)(5660300002)(8936002)(55016003)(7696005)(52536014)(38100700002)(8676002)(478600001)(76116006)(66556008)(66946007)(66446008)(64756008)(66476007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Ujh0U1ZNWktIOEc5a2RXZ1hEeDFFbVBqbHVDdCs1K2l1UnpmMlhnYVRRckZ4?=
 =?utf-8?B?bUd4cklBRGlUdzdEaTRicWxCVmJrdmVwRjE5UnhHRFdFa2FkME1RNXphejA4?=
 =?utf-8?B?NjVIeVZzTzV2cVEzTzRFWk4vck1hK0Frb1QrdC9tREpDMnlqQUZoeG96ZlJT?=
 =?utf-8?B?N1NsT210bzV3bFZZRXR4WXpMaTB6OWN2K1RXTGcvcWJhVk0yYkZ5UkliMndQ?=
 =?utf-8?B?WE5IN2t2TkpTeDZrelF2emQ4Z3ArZG42bCt3RndzM3hHRGtFaVkySVlDY1RS?=
 =?utf-8?B?RkpiUkFzODhzKzkvTktXLzFBcHZHTXBEMGp3aHVzMzRLSzE1bjBVTEpGRzZC?=
 =?utf-8?B?U1g0VjZWdkYxVE9tOHQ5Rm9kRGNYVC9XS280VHVOd1lad2tOU2lqZ1dLM0w4?=
 =?utf-8?B?ZnYvc0tVL3BBZnlvaXFUd1dZN0xyYjhWeDZrWEFxbVQvK0daZmNhMHVTSjk0?=
 =?utf-8?B?elBLUk1iOVZLaklXbGF3RmVmL25JeGtRR1c3TU9nNEJTaElON1UxVStHb2JV?=
 =?utf-8?B?S0J1TlBpVHRLQ2V2MTdIUCs3emU4Ymp1V1V0b3FXNGlTVjlXQy9tRlJ0Vnl3?=
 =?utf-8?B?UWc3Z29RN1RvbGZhVldDVXpoVEkyT3ZYVkVxaC9EUVVvTjFhVHNuRDdHS0hW?=
 =?utf-8?B?aEVnSGZHOTBkMDdkOVpLb2ZoYmVvNGpqZ1FBQ0JIVGFIbGZnc1VSL2NJNk8w?=
 =?utf-8?B?WUpub2ROUnA2WjFPQkMxNXNOeHpIOG93clh4eFM4SEU0Z2s3WDJXRVdoWXc4?=
 =?utf-8?B?YjB1eHBlcmtCMTN1UGdmM2RLMXg2bWlYYXpiZk42TEdOeVQ2cE9teWVFTml4?=
 =?utf-8?B?S2FMa3B0Y2N5UG1aaE9NSW0rdzNQWEJ6aWE4Q09pQ1NFc3M5YldzUDRkL1c3?=
 =?utf-8?B?S25hUk1CZGxXcnFERWdYajRUTGlGRXNiRVFndGdTK3pHNFBVRDRjTEUyODFH?=
 =?utf-8?B?QlQ5OFVJVlNkSVBBUFhBdGZIVlZ3eFl4R09COHRYUFdSbE90M1BqZ2dKRWg2?=
 =?utf-8?B?YzFKQ0U5SzE3aUxCWkkrdFcyKy9iUzNVK2NTT0lxbnp6cXlaM3MyN2VQQm9C?=
 =?utf-8?B?SDhsUmJHLys4UGtWSk1adEFodTVTcjVMVHV6MHJDM2EwMTVPYVRheHlxWnIr?=
 =?utf-8?B?UUZQelVxRTNDVStHV3k0eTVmaDJ0Qk5zQkxlSm9iYlNGVXJMeXlRcnM0TFVp?=
 =?utf-8?B?b3k1MnMwTjBIKzN2UmVGRHhzTEhuazgyMDc2YjdwRlNBVnM2YTZDaitrMnlD?=
 =?utf-8?B?K3F2cmZyb1NKMTFBM2RFaVpGQnU3anlLNlVCbUhFUmpQWTNINGhwbXZxS3lQ?=
 =?utf-8?B?M01tUXdUM1dTTm5NV1JUQWcyVDE0TUo4Wm9qaHk2b295RkNrNWFjeWV2Vys1?=
 =?utf-8?B?dHJVa2FsK3pKOEhaVFFHekxPaFZIZGd4R09CbVpDYWxPbHFHd1gyeTAra1BI?=
 =?utf-8?B?ZWxNZFdTRDNIR1g0R0t0cGllaThBRitBRzNFZWFBWjhmK09UZnA4MVhhZU1p?=
 =?utf-8?B?WlFqRzNQVXZFd2o1NDFKSTJERlRFMXFwaEp0YktOdHhNcll4NkJkSkhKdGFz?=
 =?utf-8?B?VGh0YTQvcTZGM0R2SzVDVEptUlFZSTNadnlQUC94WWJDRWdrUmRJZzdYQ0hl?=
 =?utf-8?B?Skc1VkZXaDdDYW4zWUpOaHV4bVZPUWRRVWJtTXdmd2IvNythNTcrWXc4MTVz?=
 =?utf-8?B?TmxOcWJUbStWdGJ1NG93OVlpNXlrTjR5SURmV0VON2JrRE9XOEFKR3o2dHBN?=
 =?utf-8?B?amtKZ25acHNTUDVGZFg2N0JKSEo5dlFxRFE2R0drQlJNUkJvMTRqUm4yc2RE?=
 =?utf-8?B?NVU4WnBhajI3RHRNN05uQ0djdjNub2ttWGg5Uzg1SVNmZE0xRENVWDNQTmdW?=
 =?utf-8?B?S2E2VG8vZis5ZGhtM3ltd043OUgyRWNzd2t2d0I0L1JkaHJoU1o0YU9uVXJq?=
 =?utf-8?B?cnhuL0pmd3h4ZTQ2MjZSc0JvOVFnQllVeSs5UWxYRElRNkhudkVzekxQeWZV?=
 =?utf-8?B?WjEza1ZxdVNHUHMvMDE3ZG1lbXN6VUgxdlMrZFJESTlUczYweG43TzQ2eDUz?=
 =?utf-8?B?UTlYcW4xY01PbFdUVW5kZGtBbVNaYnRqcFRWSFBEQXdwTzBzZyszLzlKbCtZ?=
 =?utf-8?B?b2JZeVZzSnA2UEJDZnVnOTAwN3M5NXI1WlpQZnV2MDNxQnNWM1gybDg5ZVZz?=
 =?utf-8?B?TXc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: zI2/Qf16aRaYMwEI+SWg6m7KA1cRr+EThfz8iUX1FTrWlexinuscI1PZ2R896XIWcIOzNhUk5MKVUSvRwwrYGWqLTXPFo7jVz3vAhsC4h5Hk7yZmHdYyp8eFgSXc59o59lhSVBvghUhmyJafgQk3Au4MiTeXfs7LwRr3NDDGCsyXyGQmbDGXaCC7x/Jh7+ftKe26Cf2BUF8PyWg2NvhpT98NSPsM5WbGll1+blxU+iKbieReGxtfQjIs9kNb+eqTF34ZXmA5fH6ZfDlKVZOBMr/DM4XCIkEhGJhT7NlFDxY5LBMZPXHwabZHGD5bquIaGC7CaucTxtxhPIdDL8+nb8pQjWjhM3g4ks7UXSX/eRqa69J6sBNCqztU3f28pgNToYk4uapwV1VHQi/nAwvHySSwe/dpfIoJ84gGkJjTf96TcRqZB71BLTF2H25DGqvhgPqbSVcT+irdHzF1Cnv4ayGtE56wpAofqV76YqSE/YYh2sNhaaYYEtL4+inWwSCgd7qg1FdO2vkEt0DEt0MGHl6S0rLHFXJHkZlh90ssCMn0Et6n+u/IL5okDpg4cIuW1LR1OcOz+Iky8FfcX5hoj2DcTfJVyddZ4HSc6OYoS62rEK0Nd9TuSOXcygp/lP+McxaJpG3ZsoDtFoF0YuMrsFJq01/qdmI57rFzYQFPY6VaPSwlqvLloidl0lWMy3YZfoi3cY1w73ArCQ2D9S95n6nBspJmXirY9BBgu0PxDaaHyIwctMOovjliJ4h8JV9AqhUtWZ/orEg27rwpXjhTnQEzL4C5AH2/yauhS0Uzj9MuMsEDBz3lLuO0fxZ7l3XpBd5CREv89D+dd15wtAlmTuTSrs6N0kJrHNJ+rs/VJrA=
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB8455.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a7d45bc9-7626-4f47-bb06-08db09a3e2a6
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Feb 2023 07:12:48.9641
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: c8mhI9acoFvx2WrryDR4iFn8y1oNvrayTd3HQH3AcoLZ4O7na5/woo9VG9w6SSpA+X1yarpNVvPYZ+1fTL2UbFIRudn8TYQRyOadjDdAI+c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY3PR01MB9696
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

T24gU2F0LCBGZWIgNCwgMjAyMyAzOjQ3IEFNIEJvYiBQZWFyc29uIHdyb3RlOg0KPiANCj4gT24g
Mi8zLzIzIDA0OjAwLCBEYWlzdWtlIE1hdHN1ZGEgKEZ1aml0c3UpIHdyb3RlOg0KPiA+IE9uIFRo
dSwgRmViIDIsIDIwMjMgMTo0MyBQTSBCb2IgUGVhcnNvbiB3cm90ZToNCj4gPj4NCj4gPj4gQ3Vy
cmVudGx5IHRoZSByeGUgZHJpdmVyIGRvZXMgbm90IGhhbmRsZSBhbGwgY2FzZXMgb2YgemVybyBs
ZW5ndGgNCj4gPj4gcmRtYSBvcGVyYXRpb25zIGNvcnJlY3RseS4gVGhlIGNsaWVudCBkb2VzIG5v
dCBoYXZlIHRvIHByb3ZpZGUgYW4NCj4gPj4gcmtleSBmb3IgemVybyBsZW5ndGggUkRNQSByZWFk
IG9yIHdyaXRlIG9wZXJhdGlvbnMgc28gdGhlIHJrZXkNCj4gPj4gcHJvdmlkZWQgbWF5IGJlIGlu
dmFsaWQgYW5kIHNob3VsZCBub3QgYmUgdXNlZCB0byBsb29rdXAgYW4gbXIuDQo+ID4+DQo+ID4+
IFRoaXMgcGF0Y2ggY29ycmVjdHMgdGhlIGRyaXZlciB0byBpZ25vcmUgdGhlIHByb3ZpZGVkIHJr
ZXkgaWYgdGhlDQo+ID4+IHJldGggbGVuZ3RoIGlzIHplcm8gZm9yIHJlYWQgb3Igd3JpdGUgb3Bl
cmF0aW9ucyBhbmQgbWFrZSBzdXJlIHRvDQo+ID4+IHNldCB0aGUgbXIgdG8gTlVMTC4gSW4gcmVh
ZF9yZXBseSgpIGlmIGxlbmd0aCBpcyB6ZXJvIHJ4ZV9yZWNoZWNrX21yKCkNCj4gPj4gaXMgbm90
IGNhbGxlZC4gV2FybmluZ3MgYXJlIGFkZGVkIGluIHRoZSByb3V0aW5lcyBpbiByeGVfbXIuYyB0
bw0KPiA+PiBjYXRjaCBOVUxMIE1ScyB3aGVuIHRoZSBsZW5ndGggaXMgbm9uLXplcm8uDQo+ID4+
DQoNClRoZSBjaGFuZ2UgbG9va3MgZ29vZC4gSSB3aWxsIGxlYXZlIGl0IHRvIHlvdSB3aGV0aGVy
IHRvIGZpeCB0aGUgY29tbWVudC4NClJldmlld2VkLWJ5OiBEYWlzdWtlIE1hdHN1ZGEgPG1hdHN1
ZGEtZGFpc3VrZUBmdWppdHN1LmNvbT4NCg0KVGhhbmtzLA0KRGFpc3VrZQ0KDQo+ID4NCj4gPiA8
Li4uPg0KPiA+DQo+ID4+IEBAIC00MzIsNiArNDM1LDEwIEBAIGludCByeGVfZmx1c2hfcG1lbV9p
b3ZhKHN0cnVjdCByeGVfbXIgKm1yLCB1NjQgaW92YSwgdW5zaWduZWQgaW50IGxlbmd0aCkNCj4g
Pj4gIAlpbnQgZXJyOw0KPiA+PiAgCXU4ICp2YTsNCj4gPj4NCj4gPj4gKwkvKiBtciBtdXN0IGJl
IHZhbGlkIGV2ZW4gaWYgbGVuZ3RoIGlzIHplcm8gKi8NCj4gPj4gKwlpZiAoV0FSTl9PTighbXIp
KQ0KPiA+PiArCQlyZXR1cm4gLUVJTlZBTDsNCj4gPg0KPiA+IElmICdtcicgaXMgTlVMTCwgTlVM
TCBwb2ludGVyIGRlcmVmZXJlbmNlIGNhbiBvY2N1ciBpbiBwcm9jZXNzX2ZsdXNoKCkNCj4gPiBi
ZWZvcmUgcmVhY2hpbmcgaGVyZS4gSXNuJ3QgaXQgYmV0dGVyIHRvIGRvIHRoZSBjaGVjayBpbiBw
cm9jZXNzX2ZsdXNoKCk/DQo+ID4NCj4gPj4gKw0KPiA+PiAgCWlmIChsZW5ndGggPT0gMCkNCj4g
Pj4gIAkJcmV0dXJuIDA7DQo+ID4+DQo+ID4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2luZmluaWJh
bmQvc3cvcnhlL3J4ZV9yZXNwLmMgYi9kcml2ZXJzL2luZmluaWJhbmQvc3cvcnhlL3J4ZV9yZXNw
LmMNCj4gPj4gaW5kZXggY2NjZjdjNmMyMWU5Li5jOGU3YjRjYTQ1NmIgMTAwNjQ0DQo+ID4+IC0t
LSBhL2RyaXZlcnMvaW5maW5pYmFuZC9zdy9yeGUvcnhlX3Jlc3AuYw0KPiA+PiArKysgYi9kcml2
ZXJzL2luZmluaWJhbmQvc3cvcnhlL3J4ZV9yZXNwLmMNCj4gPj4gQEAgLTQyMCwxMyArNDIwLDIz
IEBAIHN0YXRpYyBlbnVtIHJlc3Bfc3RhdGVzIHJ4ZV9yZXNwX2NoZWNrX2xlbmd0aChzdHJ1Y3Qg
cnhlX3FwICpxcCwNCj4gPj4gIAlyZXR1cm4gUkVTUFNUX0NIS19SS0VZOw0KPiA+PiAgfQ0KPiA+
Pg0KPiA+PiArLyogaWYgdGhlIHJldGggbGVuZ3RoIGZpZWxkIGlzIHplcm8gd2UgY2FuIGFzc3Vt
ZSBub3RoaW5nDQo+ID4+ICsgKiBhYm91dCB0aGUgcmtleSB2YWx1ZSBhbmQgc2hvdWxkIG5vdCB2
YWxpZGF0ZSBvciB1c2UgaXQuDQo+ID4+ICsgKiBJbnN0ZWFkIHNldCBxcC0+cmVzcC5ya2V5IHRv
IDAgd2hpY2ggaXMgYW4gaW52YWxpZCBya2V5DQo+ID4+ICsgKiB2YWx1ZSBzaW5jZSB0aGUgbWlu
aW11bSBpbmRleCBwYXJ0IGlzIDEuDQo+ID4+ICsgKi8NCj4gPj4gIHN0YXRpYyB2b2lkIHFwX3Jl
c3BfZnJvbV9yZXRoKHN0cnVjdCByeGVfcXAgKnFwLCBzdHJ1Y3QgcnhlX3BrdF9pbmZvICpwa3Qp
DQo+ID4+ICB7DQo+ID4+ICsJdW5zaWduZWQgaW50IGxlbmd0aCA9IHJldGhfbGVuKHBrdCk7DQo+
ID4+ICsNCj4gPj4gIAlxcC0+cmVzcC52YSA9IHJldGhfdmEocGt0KTsNCj4gPj4gIAlxcC0+cmVz
cC5vZmZzZXQgPSAwOw0KPiA+PiAtCXFwLT5yZXNwLnJrZXkgPSByZXRoX3JrZXkocGt0KTsNCj4g
Pj4gLQlxcC0+cmVzcC5yZXNpZCA9IHJldGhfbGVuKHBrdCk7DQo+ID4+IC0JcXAtPnJlc3AubGVu
Z3RoID0gcmV0aF9sZW4ocGt0KTsNCj4gPj4gKwlxcC0+cmVzcC5yZXNpZCA9IGxlbmd0aDsNCj4g
Pj4gKwlxcC0+cmVzcC5sZW5ndGggPSBsZW5ndGg7DQo+ID4NCj4gPiBBcyB5b3Uga25vdywgdGhl
IGNvbW1lbnQgYWJvdmUgdGhpcyBmdW5jdGlvbiBpcyBhcHBsaWNhYmxlIG9ubHkNCj4gPiB0byBS
RE1BIFJlYWQgYW5kIFdyaXRlLiBXaGF0IGRvIHlvdSBzYXkgdG8gbWVudGlvbmluZyBGTFVTSA0K
PiA+IGhlcmUgcmF0aGVyIHRoYW4gYXQgdGhlIG9uZSBpbiByeGVfZmx1c2hfcG1lbV9pb3ZhKCku
DQo+ID4NCj4gPiBUaGFua3MsDQo+ID4gRGFpc3VrZQ0KPiA+DQo+ID4+ICsJaWYgKHBrdC0+bWFz
ayAmIFJYRV9SRUFEX09SX1dSSVRFX01BU0sgJiYgbGVuZ3RoID09IDApDQo+ID4+ICsJCXFwLT5y
ZXNwLnJrZXkgPSAwOw0KPiA+PiArCWVsc2UNCj4gPj4gKwkJcXAtPnJlc3AucmtleSA9IHJldGhf
cmtleShwa3QpOw0KPiA+PiAgfQ0KPiA+Pg0KPiA+DQo+ID4gPC4uLj4NCj4gPg0KPiBEYWlzdWtl
LA0KPiANCj4gVGhlIHVwZGF0ZWQgcGF0Y2ggbm8gbG9uZ2VyIHNldHMgbXIgPSBOVUxMIGZvciBm
bHVzaC4gVGhpcyBjaGVjayBpcyBtYWlubHkgdG8gZGVmZW5kIGFnYWluc3Qgc29tZW9uZSBjaGFu
Z2luZw0KPiBpdCBhZ2FpbiBpbiB0aGUgZnV0dXJlIGFuZCBpcyBuZWFyIHdoZXJlIG1yIGlzIGRl
cmVmZXJlbmNlZC4gWW91IGFyZSBjb3JyZWN0IGFib3V0IHRoZSBjb21tZW50IEkgY2FuIGNoYW5n
ZSBpdC4NCj4gV2lsbCBnaXZlIGl0IGEgZGF5IG9yIHR3byB0byBzZWUgaWYgYW55dGhpbmcgZWxz
ZSBjb21lcyBpbi4NCj4gDQo+IFJlZ2FyZHMsDQo+IA0KPiBCb2IgUGVhcnNvbg0K
