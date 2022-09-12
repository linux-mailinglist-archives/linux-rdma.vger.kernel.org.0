Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5519B5B5631
	for <lists+linux-rdma@lfdr.de>; Mon, 12 Sep 2022 10:29:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230281AbiILI35 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 12 Sep 2022 04:29:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230302AbiILI3i (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 12 Sep 2022 04:29:38 -0400
X-Greylist: delayed 63 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 12 Sep 2022 01:28:46 PDT
Received: from esa1.fujitsucc.c3s2.iphmx.com (esa1.fujitsucc.c3s2.iphmx.com [68.232.152.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC6BC2AD2
        for <linux-rdma@vger.kernel.org>; Mon, 12 Sep 2022 01:28:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1662971327; x=1694507327;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=NdjVrIJY+uL0aP0uZKnzfLPc3BZ6QqgNP2B9ZBCb3O8=;
  b=yNtswq38OiCeQc3y1mqN5IjfxZV52GwPQfAxMVtEcywtHV7RLiQZpDBr
   3FJTh2GFo6AMygJhfn0sivS4W9ioX7gta1l+kCgWpc5ZXYjjWkP9r2TjT
   e7ZjxMQ2XBUhoE6lQK9+214IYS1KLXMHewe049DPFIMcE+B7AYtXFcIZH
   ekyPOBla5Y5+8PTvrx9SHAVfZPC+1O5B4x1vI+UDvxsViB2/46VfHTR/X
   t1wWRorkSVIWer2qomixd+FtGhIbCtrnlBSOCRIhwvntA7X7lnJT4Y9WQ
   EUdcGjzvSyTN8zPCg5e5FVSGEwIml+KKAb9/0bCueNZ9/7bEzZqlvOYS9
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10467"; a="73093208"
X-IronPort-AV: E=Sophos;i="5.93,308,1654527600"; 
   d="scan'208";a="73093208"
Received: from mail-os0jpn01lp2110.outbound.protection.outlook.com (HELO JPN01-OS0-obe.outbound.protection.outlook.com) ([104.47.23.110])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2022 17:27:06 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ImYKA8d/kDqe2jmWpVWYWBUdYuvFyvGwWKnInmxLc+97ls55Tl/xzWvhdTqUfyEPROEFXSyib+mnQ+rX4pNxgq4NHcgi7kp2jEU3GHnryAReY7/9AbPdWKByf0d/27K88CiqCc1KteDMwbIrPFC2CVQmu9M0SkdppvFa93HUIi+0b4+7RWAytHqmsfrKkYsjQO5Zeu1lwcBOdNhVBey8J9JwvnrLFtQcgKtiD56pW74JqQNKeEFAlzqGHq74Z4wv5lmasOyPB9KLnJ7JUaNLDt6MenZ6BENqmuHmd7vamAZWMQV+nubtF/GBbUKNvHm+Ja3cdPd7/6G56waiUUQVeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NdjVrIJY+uL0aP0uZKnzfLPc3BZ6QqgNP2B9ZBCb3O8=;
 b=jgzkAEzY0dyDfF33cb1Ejn71N0QpR88VaADrKZUDDiCQJ6llG/k3cWtuoS9ha+jmC+wG9cGNtelm1Fx6W9N5FrsTkStyuyYAldTH1a40SY6pU942H0qKKF46mr+CO2jBhbdWz/+xXu/J9CkhkaP165GAMUKu5Jwv6acy0FH6wpdoe8obiyZ+YWtB/4ZqHLqRqWonUMOEDCNLkDuZgsVGXp8tWsWUNlnmX5n+dexUQlbUPcRatQArF/7kFoBkninrWi8GX79MGILw/LP2L/i7hpNzWTJFlP+kbLBbu8GlFlNwr4LiiYuhxSEdnVHQ5qP8YFYoUuzIrzoxCKSZQM5XyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from TYCPR01MB8455.jpnprd01.prod.outlook.com (2603:1096:400:15d::13)
 by TYCPR01MB10228.jpnprd01.prod.outlook.com (2603:1096:400:1ed::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.14; Mon, 12 Sep
 2022 08:27:03 +0000
Received: from TYCPR01MB8455.jpnprd01.prod.outlook.com
 ([fe80::d023:d89d:54f5:631a]) by TYCPR01MB8455.jpnprd01.prod.outlook.com
 ([fe80::d023:d89d:54f5:631a%6]) with mapi id 15.20.5612.022; Mon, 12 Sep 2022
 08:27:03 +0000
From:   "matsuda-daisuke@fujitsu.com" <matsuda-daisuke@fujitsu.com>
To:     'Bob Pearson' <rpearsonhpe@gmail.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "leonro@nvidia.com" <leonro@nvidia.com>,
        "jgg@nvidia.com" <jgg@nvidia.com>,
        "zyjzyj2000@gmail.com" <zyjzyj2000@gmail.com>,
        "Ziemba, Ian" <ian.ziemba@hpe.com>, Frank Zago <frank.zago@hpe.com>
CC:     "nvdimm@lists.linux.dev" <nvdimm@lists.linux.dev>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "yangx.jy@fujitsu.com" <yangx.jy@fujitsu.com>,
        "lizhijian@fujitsu.com" <lizhijian@fujitsu.com>,
        "y-goto@fujitsu.com" <y-goto@fujitsu.com>
Subject: RE: [RFC PATCH 2/7] RDMA/rxe: Convert the triple tasklets to
 workqueues
Thread-Topic: [RFC PATCH 2/7] RDMA/rxe: Convert the triple tasklets to
 workqueues
Thread-Index: AQHYwmPAjFT9wyoflEKiuh64EWqIi63XgvMAgAPcBRA=
Date:   Mon, 12 Sep 2022 08:27:02 +0000
Message-ID: <TYCPR01MB845576AC0D07947D560F77DCE5449@TYCPR01MB8455.jpnprd01.prod.outlook.com>
References: <cover.1662461897.git.matsuda-daisuke@fujitsu.com>
 <41e5476f4f14a0b77f4a8c3826e3ef943bf7c173.1662461897.git.matsuda-daisuke@fujitsu.com>
 <faf616cf-ea40-153e-bc42-a50b418e9ed9@gmail.com>
In-Reply-To: <faf616cf-ea40-153e-bc42-a50b418e9ed9@gmail.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-securitypolicycheck: OK by SHieldMailChecker v2.5.2
x-shieldmailcheckerpolicyversion: FJ-ISEC-20170217
x-shieldmailcheckermailid: 77e4e3f8342740d1b407a413600d04d9
msip_labels: =?utf-8?B?TVNJUF9MYWJlbF9hNzI5NWNjMS1kMjc5LTQyYWMtYWI0ZC0zYjBmNGZlY2Uw?=
 =?utf-8?B?NTBfRW5hYmxlZD10cnVlOyBNU0lQX0xhYmVsX2E3Mjk1Y2MxLWQyNzktNDJh?=
 =?utf-8?B?Yy1hYjRkLTNiMGY0ZmVjZTA1MF9TZXREYXRlPTIwMjItMDktMTJUMDc6MjA6?=
 =?utf-8?B?MTdaOyBNU0lQX0xhYmVsX2E3Mjk1Y2MxLWQyNzktNDJhYy1hYjRkLTNiMGY0?=
 =?utf-8?B?ZmVjZTA1MF9NZXRob2Q9U3RhbmRhcmQ7IE1TSVBfTGFiZWxfYTcyOTVjYzEt?=
 =?utf-8?B?ZDI3OS00MmFjLWFiNGQtM2IwZjRmZWNlMDUwX05hbWU9RlVKSVRTVS1SRVNU?=
 =?utf-8?B?UklDVEVE4oCLOyBNU0lQX0xhYmVsX2E3Mjk1Y2MxLWQyNzktNDJhYy1hYjRk?=
 =?utf-8?B?LTNiMGY0ZmVjZTA1MF9TaXRlSWQ9YTE5ZjEyMWQtODFlMS00ODU4LWE5ZDgt?=
 =?utf-8?B?NzM2ZTI2N2ZkNGM3OyBNU0lQX0xhYmVsX2E3Mjk1Y2MxLWQyNzktNDJhYy1h?=
 =?utf-8?B?YjRkLTNiMGY0ZmVjZTA1MF9BY3Rpb25JZD1lYzdlZjI5MS0zODgxLTQ3ZDEt?=
 =?utf-8?B?YTc4Zi00ZDJjODVjOTdhMDY7IE1TSVBfTGFiZWxfYTcyOTVjYzEtZDI3OS00?=
 =?utf-8?B?MmFjLWFiNGQtM2IwZjRmZWNlMDUwX0NvbnRlbnRCaXRzPTA=?=
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYCPR01MB8455:EE_|TYCPR01MB10228:EE_
x-ms-office365-filtering-correlation-id: c34ab07b-9797-482c-875b-08da949891ed
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ITGjW7gMEBLOYQeVED527ogXuJQE3JbAUY0aqtoK8G/aEWZHbxBkVwckBfihCClAViXB/0UxuEjtCtWEFvGjfNfvxqQLnL+S/q7HMvAAt01/cogjfBfcWOODcINSiaCaiMJ/dh9A9FwmZ1IlQpE5aJcax2HY9HfrpPdIKCY2g0rLB5Juz0+FM4zRGwVu4oz+QavLw3qoJY3MWq7TaGPTkDSoe+cd2G5P98GjgcRTmb+hrSCTq3BHQl3JZDxE84D011HyTBPzadRY4GC5clwLaI6vxcixU4M/n4RGROX0/n3IAZyI+x3OK+Iz1ynJJW462/e83B5RA5SX0mATYi+pBewuUpFYxIpeaIpqWcc2S6XNJGNjwfdgQgKbeULnjbFvaI//cM330G7TZdJKn1XeYsHN2W+2ErMu2dkIHyl8XPMBH8Fskl7qmSjRQLmYGPQXImFK2N2yDVnM+ESiSsnYIOAe10lcWeVM60hzbieEUh5P+e+2O6TJHEAZBEsqjh7RsMdA3UPBCEH2d6srFZLT3wihRXwtlP2+JzbfRxndj13Vm+gJgYYLGpxQNCfA73KYeFjpjwWxK9DzrcRpXzhNTluvL40dNn7/gGWoK7sKbUpoBMEbzCbloH3gTsi3YJ0tbO+Uj6DIbF/e9jM3c6UF6dJ1f/wC01V11m6+b0X3vqod5XZ9JuZeeWdJyKWwk6OgXpA2GjeXKXagOYhbi+bmld/JwKWJ6P6ARcXyTGZEoeBlUiy6a81mq7sEjF5sytEs8xx4C8+pEsgkFJzEELGZQFUcX6hWpuEZ/qPF/EuZX0/JQ4+n51k6orx+WPsYki9ir0RDkNsWCLSodmASaQNtEQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB8455.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(376002)(346002)(366004)(39860400002)(136003)(396003)(1590799006)(966005)(4326008)(76116006)(66556008)(66446008)(64756008)(66946007)(41300700001)(478600001)(71200400001)(66476007)(8676002)(38070700005)(5660300002)(86362001)(52536014)(8936002)(54906003)(85182001)(26005)(1580799003)(9686003)(316002)(38100700002)(186003)(82960400001)(122000001)(110136005)(45080400002)(7696005)(53546011)(6506007)(55016003)(2906002)(83380400001)(33656002)(107886003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RVRiVDNUNDByb3hObjRqNDhmZ01PalYwUEdBRXc3S2VxY0NPMkowVi9jQ3BX?=
 =?utf-8?B?bmNWalZqbUExZEFmellaakxqOXdoMjVxZVRiTVhDTDBBeHE4RDk5bkNzd1VH?=
 =?utf-8?B?ZmtYWmwvcmcvRWFTcnFqWCtsNVErdWJlVnFoQ1RNNldOdkRRRW1lUm0xWVA2?=
 =?utf-8?B?V3ltY2lJQVUrZWtkVTR2SkpCUEtMZ3g2VVVSN3E4OWhiTDFWRE5KK3FtTVRI?=
 =?utf-8?B?eXkxMnN3T1dOMDExZExra0RnVUdkQnhPT243Wmw0VEdTdXFiaU9zZlFuRWxh?=
 =?utf-8?B?N0h2d0IweDM5aEVUald0UC8wL1p1bXF5ck1RNjM1MWdIQzBKTUFHQlRiOHhw?=
 =?utf-8?B?SENVR2tCOTF1a1FBUEdxNjAxNVRtUjJrQXd0b25FVnlDeGpxdWk5MzRIS0Iy?=
 =?utf-8?B?cEgzdlg3ZW9kZGdEeTNzdjl5RyttQ0VKM2prMkZBdU92cVdZWDg3ejc5RjFG?=
 =?utf-8?B?THRSTCtKVFNKV0NWK3Zia2ZMUUVKcFV0VEhRVU96RW92K1Q5aDFSV2ZyYkMy?=
 =?utf-8?B?emNPYW1PTk5TaVlnNktYZlFZaVdBeHo3SDFhN25wSWthRkgrdzlSMnFYWDNT?=
 =?utf-8?B?b1krL3NLRklaTVZneGNJWmg2SElmWFdxcFA4bWF6SlRFeVN0TjdDSVVoRlNv?=
 =?utf-8?B?eEsvclYwYXBubjRRUUJ4Z01PQXNmRTlzdVNCMjlFNXVlTnliM0VnYWRVMjQy?=
 =?utf-8?B?dHRhMGxMMkhZbW1vV1Vzc0pwUDg3bFlLdGJwTVA5L3c1SGMvNXdLYVFCZHJ2?=
 =?utf-8?B?ZUsydHNzTzQ0b3BVcVJXcmpzMGQzbmE0STUyLzY3L1JraDNLK0RoODRmYUxN?=
 =?utf-8?B?Y0ZQVUhjUmFQWGNmUUhOV0JnWmpRMG4vdXRkZHlwSDRMbFpKUFNaT284SFRK?=
 =?utf-8?B?b2tCclM0UnJKTzA5dlJMMjRFVWtZckUzYlVFcmJ3RVA5b3BlSjhDNUliZlZu?=
 =?utf-8?B?eW4ycEROZ3djWkRGdUs4MHE4cTVYN1hxYkc2YmFHVVBialU5YUszNWhZRzY1?=
 =?utf-8?B?NDBzUk1ZTjU1NXI1bTE0QjRMZkxYQ1pYTENSNGJYenRGalQ0MTQvRjgvWTA4?=
 =?utf-8?B?TXlzVWhPZS9weTRoZ2QzM0Y1VkE2TGlQYTNYQWlFZkg2WWFjV2Z1Q1lIZ3lq?=
 =?utf-8?B?THNpbTVzZlpMUjBWRW5xRDhOc2JIQ3RlVEpNanlaZHdSVm9iaFZPSHlFSHpo?=
 =?utf-8?B?WE8zSG1jTlVwM1dpTVdVaEFPU0NJTktwek1vQUUvL1haTk1DRVExQ1VsLzRH?=
 =?utf-8?B?SVZpMkdhaGhTZHJPWHk5cGwxTjRSOGtocnZ2TU9LUGltYUJtdk9HTkg3dnE1?=
 =?utf-8?B?ekpkYU5JYURqQ1dGR0VEbEZwMXRVUnN1YlBNcDNIR3RDWmVHbDRpNmtrNVpt?=
 =?utf-8?B?bjVVNWlaVGNDelhZL3NGT2dBR1ZZSHh3NWJmelg3UGdYY0tvL3dCZVdVNHFk?=
 =?utf-8?B?a2ZjY0gvSXBoSUxkRThrZ3J0K3pqTEtUbGtqbUpZLzFtV2dyOGRZcEE4YW4w?=
 =?utf-8?B?OGE5TEUxeTlGSkpYK2lzekdrbVRNeEJoS2ZSYk9tTHhJT25DRElDazNheFFq?=
 =?utf-8?B?WHplY0lXRGJsdXNQYzgxOUEyV3JPRmxuNTZRTG5BMWZWOElOQ016aC9OMW96?=
 =?utf-8?B?T05Rc1IxZDhqRTloQ2JiQWE2QW9MS1JxUWFzWFdTZkRRWTkzUjhRNkVva1JK?=
 =?utf-8?B?dnJnMVQ3N0hIdVVDOEIvdW1NOWJsVU5qR0ZrWU1sQTZKb2FKWUh4NGE1bHp6?=
 =?utf-8?B?ZlJqcmYraEdwME5kb2dGMStxWWplOTNWOVlUNVpGa1diVFF3aGozaEJXZEpq?=
 =?utf-8?B?UVZXM3RuVnlFUzRKYjh2TW0vTStzTlFtSTY3eXVFMzF6NlF2ZzduK2V2TzRR?=
 =?utf-8?B?VTgzK015aVhvODRPYjgyMUJLZDgrOUpwbkVGSGh3eW80NFl5enUxSUJta25y?=
 =?utf-8?B?QUNCSXJaWnVWaktNNTNXWmRrZG1veDJ0MEs1RjZvODkrWFJjT01kdi8ydThr?=
 =?utf-8?B?RGpIdnl4ejlmQURHNVpUZlIrQW52WG1IUGpvTjBHajNVUGdLYVlWaTdDWVFM?=
 =?utf-8?B?VWJ0ek5VcGVyb2N5OEMyY3V0U2xxeDJFZ01WdWJRYUlwdmxFR2kva1Faa0w1?=
 =?utf-8?B?RVY5dG5rRHcwMlJkUnFZSUtESjRadUpZdnYvUk1GdDVLb2N4VTVNNWFGTytj?=
 =?utf-8?B?NEE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB8455.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c34ab07b-9797-482c-875b-08da949891ed
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Sep 2022 08:27:03.0236
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Wc0W3FYogDqAuI6ny5HVE9WNbgNgd6V7i+gCCQTqzVvHchlUxSyqnwauAjnTNPof39NiY6DmfNyEZdRwkddXh+qFTIC3wtQesquHViafQ6s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB10228
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

T24gU2F0LCBTZXAgMTAsIDIwMjIgNDozOSBBTSBCb2IgUGVhcnNvbiB3cm90ZToNCj4gT24gOS82
LzIyIDIxOjQzLCBEYWlzdWtlIE1hdHN1ZGEgd3JvdGU6DQo+ID4gSW4gb3JkZXIgdG8gaW1wbGVt
ZW50IE9uLURlbWFuZCBQYWdpbmcgb24gdGhlIHJ4ZSBkcml2ZXIsIHRyaXBsZSB0YXNrbGV0cw0K
PiA+IChyZXF1ZXN0ZXIsIHJlc3BvbmRlciwgYW5kIGNvbXBsZXRlcikgbXVzdCBiZSBhbGxvd2Vk
IHRvIHNsZWVwIHNvIHRoYXQgdGhleQ0KPiA+IGNhbiB0cmlnZ2VyIHBhZ2UgZmF1bHQgd2hlbiBw
YWdlcyBiZWluZyBhY2Nlc3NlZCBhcmUgbm90IHByZXNlbnQuDQo+ID4NCj4gPiBUaGlzIHBhdGNo
IHJlcGxhY2VzIHRoZSB0YXNrbGV0cyB3aXRoIHdvcmtxdWV1ZXMsIGJ1dCBzdGlsbCBhbGxvd3Mg
ZGlyZWN0LQ0KPiA+IGNhbGwgb2Ygd29ya3MgZnJvbSBzb2Z0aXJxIGNvbnRleHQgaWYgaXQgaXMg
b2J2aW91cyB0aGF0IE1ScyBhcmUgbm90IGdvaW5nDQo+ID4gdG8gYmUgYWNjZXNzZWQgYW5kIHRo
ZXJlIGlzIG5vIHdvcmsgYmVpbmcgcHJvY2Vzc2VkIGluIHRoZSB3b3JrcXVldWUuDQo+ID4NCj4g
PiBBcyBjb3VudGVycGFydHMgdG8gdGFza2xldF9kaXNhYmxlKCkgYW5kIHRhc2tsZXRfZW5hYmxl
KCkgYXJlIG1pc3NpbmcgZm9yDQo+ID4gd29ya3F1ZXVlcywgYW4gYXRvbWljIHZhbHVlIGlzIGlu
dHJvZHVjZWQgdG8gZ2V0IHdvcmtzIHN1c3BlbmRlZCB3aGlsZSBxcA0KPiA+IHJlc2V0IGlzIGlu
IHByb2dyZXNzLg0KPiA+DQo+ID4gQXMgYSByZWZlcmVuY2UsIHBlcmZvcm1hbmNlIGNoYW5nZSB3
YXMgbWVhc3VyZWQgdXNpbmcgaWJfc2VuZF9idyBhbmQNCj4gPiBpYl9zZW5kX2xhdCBjb21tYW5k
cyBvdmVyIFJDIGNvbm5lY3Rpb24uIEJvdGggdGhlIGNsaWVudCBhbmQgdGhlIHNlcnZlcg0KPiA+
IHdlcmUgcGxhY2VkIG9uIHRoZSBzYW1lIEtWTSBob3N0LiBBbiBvcHRpb24gIi1uIDEwMDAwMCIg
d2FzIGdpdmVuIHRvIHRoZQ0KPiA+IHJlc3BlY3RpdmUgY29tbWFuZHMgdG8gaXRlcmF0ZSBvdmVy
IDEwMDAwMCB0aW1lcy4NCj4gPg0KPiA+IEJlZm9yZSBhcHBseWluZyB0aGlzIHBhdGNoOg0KPiA+
IFtpYl9zZW5kX2J3XQ0KPiA+IC0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQ0KPiA+ICAj
Ynl0ZXMgICAgICNpdGVyYXRpb25zICAgIEJXIHBlYWtbTUIvc2VjXSAgICBCVyBhdmVyYWdlW01C
L3NlY10gICBNc2dSYXRlW01wcHNdDQo+ID4gIDY1NTM2ICAgICAgMTAwMDAwICAgICAgICAgICAw
LjAwICAgICAgICAgICAgICAgMjAzLjEzICAgICAgICAgICAgIDAuMDAzMjUwDQo+ID4gLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tDQo+ID4gW2liX3NlbmRfbGF0XQ0KPiA+IC0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLQ0KPiA+ICAjYnl0ZXMgI2l0ZXJhdGlvbnMgICAgdF9taW5b
dXNlY10gICAgdF9tYXhbdXNlY10gIHRfdHlwaWNhbFt1c2VjXSAgICB0X2F2Z1t1c2VjXSAgICB0
X3N0ZGV2W3VzZWNdICAgOTklDQo+IHBlcmNlbnRpbGVbdXNlY10gICA5OS45JSBwZXJjZW50aWxl
W3VzZWNdDQo+ID4gIDIgICAgICAgMTAwMDAwICAgICAgICAgIDMwLjkxICAgICAgICAgIDE1MTku
MDUgICAgICAzNC4yMyAgICAgICAgICAgICAzNi4wNiAgICAgICAgICAgIDUuMTUgICAgICAgICAg
ICA0OC40OQ0KPiA4Mi4zNw0KPiA+IC0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQ0KPiA+
DQo+ID4gQWZ0ZXIgYXBwbHlpbmcgdGhpcyBwYXRjaDoNCj4gPiBbaWJfc2VuZF9id10NCj4gPiAt
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0NCj4gPiAgI2J5dGVzICAgICAjaXRlcmF0aW9u
cyAgICBCVyBwZWFrW01CL3NlY10gICAgQlcgYXZlcmFnZVtNQi9zZWNdICAgTXNnUmF0ZVtNcHBz
XQ0KPiA+ICA2NTUzNiAgICAgIDEwMDAwMCAgICAgICAgICAgMC4wMCAgICAgICAgICAgICAgIDI0
MC44OCAgICAgICAgICAgICAwLjAwMzg1NA0KPiA+IC0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLQ0KPiA+IFtpYl9zZW5kX2xhdF0NCj4gPiAtLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0NCj4gPiAgI2J5dGVzICNpdGVyYXRpb25zICAgIHRfbWluW3VzZWNdICAgIHRfbWF4W3VzZWNd
ICB0X3R5cGljYWxbdXNlY10gICAgdF9hdmdbdXNlY10gICAgdF9zdGRldlt1c2VjXSAgIDk5JQ0K
PiBwZXJjZW50aWxlW3VzZWNdICAgOTkuOSUgcGVyY2VudGlsZVt1c2VjXQ0KPiA+ICAyICAgICAg
IDEwMDAwMCAgICAgICAgICA0MC44OCAgICAgICAgICAyOTk0LjgyICAgICAgNDcuODAgICAgICAg
ICAgICAgNTAuMjUgICAgICAgICAgICAxMy43MCAgICAgICAgICAgNzYuNDINCj4gMTg1LjA0DQo+
ID4gLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tDQo+ID4NCj4gPiBUaGUgdGVzdCB3YXMg
Y29uZHVjdGVkIDMgdGltZXMgZm9yIGVhY2gga2VybmVsLCBhbmQgdGhlIHJlc3VsdHMgd2l0aCBt
ZWRpYW4NCj4gPiAiQlcgYXZlcmFnZSIgYW5kICJ0X3R5cGljYWwiIGFyZSBzaG93biBhYm92ZS4g
SXQgc2hvd3MgdGhlIGNvbnZlcnNpb24NCj4gPiBpbXByb3ZlcyB0aGUgYmFuZHdpZHRoIHdoaWxl
IGNhdXNpbmcgaGlnaGVyIGxhdGVuY3kuDQo+ID4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBEYWlzdWtl
IE1hdHN1ZGEgPG1hdHN1ZGEtZGFpc3VrZUBmdWppdHN1LmNvbT4NCj4gPiAtLS0NCj4gPiAgZHJp
dmVycy9pbmZpbmliYW5kL3N3L3J4ZS9NYWtlZmlsZSAgICB8ICAgMiArLQ0KPiA+ICBkcml2ZXJz
L2luZmluaWJhbmQvc3cvcnhlL3J4ZV9jb21wLmMgIHwgIDQyICsrKystLS0NCj4gPiAgZHJpdmVy
cy9pbmZpbmliYW5kL3N3L3J4ZS9yeGVfbG9jLmggICB8ICAgMiArLQ0KPiA+ICBkcml2ZXJzL2lu
ZmluaWJhbmQvc3cvcnhlL3J4ZV9uZXQuYyAgIHwgICA0ICstDQo+ID4gIGRyaXZlcnMvaW5maW5p
YmFuZC9zdy9yeGUvcnhlX3BhcmFtLmggfCAgIDIgKy0NCj4gPiAgZHJpdmVycy9pbmZpbmliYW5k
L3N3L3J4ZS9yeGVfcXAuYyAgICB8ICA2OCArKysrKy0tLS0tLQ0KPiA+ICBkcml2ZXJzL2luZmlu
aWJhbmQvc3cvcnhlL3J4ZV9yZWN2LmMgIHwgICAyICstDQo+ID4gIGRyaXZlcnMvaW5maW5pYmFu
ZC9zdy9yeGUvcnhlX3JlcS5jICAgfCAgMTQgKy0tDQo+ID4gIGRyaXZlcnMvaW5maW5pYmFuZC9z
dy9yeGUvcnhlX3Jlc3AuYyAgfCAgMTYgKy0tDQo+ID4gIGRyaXZlcnMvaW5maW5pYmFuZC9zdy9y
eGUvcnhlX3Rhc2suYyAgfCAxNTIgLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tDQo+ID4gIGRyaXZl
cnMvaW5maW5pYmFuZC9zdy9yeGUvcnhlX3Rhc2suaCAgfCAgNjkgLS0tLS0tLS0tLS0NCj4gPiAg
ZHJpdmVycy9pbmZpbmliYW5kL3N3L3J4ZS9yeGVfdmVyYnMuYyB8ICAgOCArLQ0KPiA+ICBkcml2
ZXJzL2luZmluaWJhbmQvc3cvcnhlL3J4ZV92ZXJicy5oIHwgICA4ICstDQo+ID4gIGRyaXZlcnMv
aW5maW5pYmFuZC9zdy9yeGUvcnhlX3dxLmMgICAgfCAxNjEgKysrKysrKysrKysrKysrKysrKysr
KysrKysNCj4gPiAgZHJpdmVycy9pbmZpbmliYW5kL3N3L3J4ZS9yeGVfd3EuaCAgICB8ICA3MSAr
KysrKysrKysrKysNCj4gPiAgMTUgZmlsZXMgY2hhbmdlZCwgMzIyIGluc2VydGlvbnMoKyksIDI5
OSBkZWxldGlvbnMoLSkNCj4gPiAgZGVsZXRlIG1vZGUgMTAwNjQ0IGRyaXZlcnMvaW5maW5pYmFu
ZC9zdy9yeGUvcnhlX3Rhc2suYw0KPiA+ICBkZWxldGUgbW9kZSAxMDA2NDQgZHJpdmVycy9pbmZp
bmliYW5kL3N3L3J4ZS9yeGVfdGFzay5oDQo+ID4gIGNyZWF0ZSBtb2RlIDEwMDY0NCBkcml2ZXJz
L2luZmluaWJhbmQvc3cvcnhlL3J4ZV93cS5jDQo+ID4gIGNyZWF0ZSBtb2RlIDEwMDY0NCBkcml2
ZXJzL2luZmluaWJhbmQvc3cvcnhlL3J4ZV93cS5oDQoNCjwuLi4+DQoNCj4gDQo+IERhaXNrdWtl
LA0KPiANCj4gV2UgKGhwZSkgaGF2ZSBhbiBpbnRlcm5hbCBwYXRjaCBzZXQgdGhhdCBhbHNvIGFs
bG93cyB1c2luZyB3b3JrIHF1ZXVlcyBpbnN0ZWFkIG9mIHRhc2tsZXRzLg0KPiBUaGVyZSBpcyBh
IGNlcnRhaW4gYW1vdW50IG9mIHdvcmsgdG8gYWxsb3cgY29udHJvbCBvdmVyIGNwdSBhc3NpZ25t
ZW50IGZyb20gdWxwIG9yIGFwcGxpY2F0aW9uDQo+IGxldmVsLiBUaGlzIGlzIGNyaXRpY2FsIGZv
ciBoaWdoIHBlcmZvcm1hbmNlIGluIG11bHRpdGhyZWFkZWQgSU8gYXBwbGljYXRpb25zLiBJdCB3
b3VsZCBiZSBpbg0KPiBib3RoIG9mIG91ciBpbnRlcmVzdHMgaWYgd2UgY291bGQgZmluZCBhIGNv
bW1vbiBpbXBsZW1lbnRhdGlvbiB0aGF0IHdvcmtzIGZvciBldmVyeW9uZS4NCg0KSSBhZ3JlZSB3
aXRoIHlvdSwgYW5kIEkgYW0gaW50ZXJlc3RlZCBpbiB5b3VyIHdvcmsuDQoNCldvdWxkIHlvdSBw
b3N0IHRoZSBwYXRjaCBzZXQ/IEl0IG1heSBiZSBwb3NzaWJsZSB0byByZWJhc2UgbXkgd29yayBv
biB5b3VyIGltcGxlbWVudGF0aW9uLg0KSSBqdXN0IHNpbXBseSByZXBsYWNlZCB0YXNrbGV0cyBt
ZWNoYW5pY2FsbHkgYW5kIG1vZGlmaWVkIHRoZSBjb25kaXRpb25zIHdoZW4gZGlzcGF0Y2hpbmcg
d29ya3MNCnRvIHJlc3BvbmRlciBhbmQgY29tcGxldGVyIHdvcmtxdWV1ZXMuIFRoZSBjaGFuZ2Vz
IGFyZSBub3Qgc28gY29tcGxpY2F0ZWQuIEknbGwgYmUgYXdheSBiZXR3ZWVuDQo5LzE1LTkvMjAu
IEFmdGVyIHRoYXQsIEkgY2FuIHRha2UgdGhlIHRpbWUgdG8gbG9vayBpbnRvIGl0Lg0KDQpCeSB0
aGUgd2F5LCBJIHdvdWxkIGFsc28gbGlrZSB5b3UgdG8gam9pbiBpbiB0aGUgZGlzY3Vzc2lvbiBh
Ym91dCB3aGV0aGVyIHRvIHByZXNlcnZlIHRhc2tsZXRzIG9yIG5vdC4NCkNmLiBodHRwczovL2xv
cmUua2VybmVsLm9yZy9hbGwvVFlDUFIwMU1CODQ1NUQ3MzlGQzlGQjAzNEUzNDg1Qzg3RTU0NDlA
VFlDUFIwMU1CODQ1NS5qcG5wcmQwMS5wcm9kLm91dGxvb2suY29tLw0KDQo+IA0KPiBQZXJoYXBz
IHdlIGNvdWxkIGFycmFuZ2UgZm9yIGEgY2FsbCB0byBkaXNjdXNzPw0KDQpUaGlzIGlzIGFuIGlt
cG9ydGFudCBjaGFuZ2UgdGhhdCBtYXkgYWZmZWN0IGFsbCBvZiByeGUgdXNlcnMsDQpzbyBJIHRo
aW5rIHRoZSBkaXNjdXNzaW9uIHNob3VsZCBiZSBvcGVuIHRvIGFueWJvZHkgYXQgbGVhc3QgYXQg
dGhpcyBzdGFnZS4NCg0KVGhhbmtzLA0KRGFpc3VrZQ0KDQo=
