Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FB107A5856
	for <lists+linux-rdma@lfdr.de>; Tue, 19 Sep 2023 06:14:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231182AbjISEOR (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 19 Sep 2023 00:14:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231165AbjISEOR (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 19 Sep 2023 00:14:17 -0400
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EC148F;
        Mon, 18 Sep 2023 21:14:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1695096851; x=1726632851;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=gcAmScZy/6YShNTjZa6BumYYxJ20ilvhjQrJIuRECuc=;
  b=J6FEvIA7Z+nP1dvwshpC0fjSv0Esx+OtXmbpvGtU5aal51N8WJ0a5pZr
   O+yC7uQSs/4ThKn8dv14VNojsAS6UKRXJj1fxX4PaWE+MpRaS2YMOf5UP
   fnOI0fPnE2ck9erRa0cDkORO0CRFen5d8lWzOJoWFxvMxYvyMwz0bTw88
   rPGVgD/0GoqHh4uQYWWX0njFbcxg+bfgkb5DFplY44L1sRP46ScuPL+v0
   ipeTjKdAr5KqAm2GtPdVcBxqo6lEwDXTS15VSi6TuK4mEc+c/Gs//x46r
   SBRDdhYkXXMhrgriKTe0LR+OzjAyuh12qUcm1eG6kMs2ihJ1dLnWAlVDZ
   w==;
X-CSE-ConnectionGUID: giOKEaXoR2666JfwatsUOA==
X-CSE-MsgGUID: VKkU1hYXTIKMmLRP0fNk5A==
X-IronPort-AV: E=Sophos;i="6.02,158,1688400000"; 
   d="scan'208";a="356378626"
Received: from mail-dm6nam12lp2174.outbound.protection.outlook.com (HELO NAM12-DM6-obe.outbound.protection.outlook.com) ([104.47.59.174])
  by ob1.hgst.iphmx.com with ESMTP; 19 Sep 2023 12:14:10 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LxWBbaJm1vM5fNszOSxQd/vWhUBc0wJd3Px0dIBdV78al54++vqsp6fjGevf8FaRK19zL2xZQv4NTTWOP4saBLV9tFGNMHqjBJnCNGqKr/ZlWiyHvqx7bsZDRxVOs8XzRQPTcJJXc80lvgkTavQaTt7GnpgIB618IKrnb3M7rwb5xWmkCubymOAEXBES1SnKd9iyvOoW+suY8pWUaNegwKbiGIJtlDaHzu5UxnIjqMSCUnml6qNTa1oBImK5b0ia+Mh3Vd7WHFnVZGe9k9DfeLIrSkIz83yQ5PIeeKGhuKTO+4Ci8juGF89u2yR9df1Vz+kb9grndCKtoV5v5XWKmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gcAmScZy/6YShNTjZa6BumYYxJ20ilvhjQrJIuRECuc=;
 b=l6DOh8oNumU9AsUcadwQ59OfgkCkWyFaH6NuW6qT+PM2QQJGhM+E86ff9CE5X0sz26dSmG6rYtuSwu6dx/0KMwcOV2iJlGGKTJZ23hi1919IDC+C8TlWQ4ss+/9d7BX7No9aRIywb1AEqAwDNo1ci6KV04AePUh97a9rtTbw8AsUMgUPRupdUV9QHFuKa0FIbLsQGiqvjykbDJwJGd93wEU1q91+yJORvQ3iyhoCtEtL75aNT/gDlgSryuK07hCwwJb4XNsD23GGVzcDFsRhUQqV3QqZ2C69XAcUXquM3LGqZoxWoG6MbndIdOFIHHzj42bWyUgfLVPxy1fY+kb6gQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gcAmScZy/6YShNTjZa6BumYYxJ20ilvhjQrJIuRECuc=;
 b=bpOoAYi5JFrb70392cVWbuEG2DhEkG0sOjqGqJOgkj/LolkvRrSCRoBk4x5UpjXOaXfPRk/o+RP14GfIgNn0o18K0JSZAsZRHCg6kmOCW4TxjDaL4sgB0LiVxiXoFf2ZmHNWiMyN+pzvQaAd/KGKH/v58HaHibwUVzqHJ4ewbpI=
Received: from BN0PR04MB8048.namprd04.prod.outlook.com (2603:10b6:408:15f::17)
 by BL0PR04MB6530.namprd04.prod.outlook.com (2603:10b6:208:1c3::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.16; Tue, 19 Sep
 2023 04:14:08 +0000
Received: from BN0PR04MB8048.namprd04.prod.outlook.com
 ([fe80::835d:7842:e325:7f14]) by BN0PR04MB8048.namprd04.prod.outlook.com
 ([fe80::835d:7842:e325:7f14%3]) with mapi id 15.20.6813.014; Tue, 19 Sep 2023
 04:14:08 +0000
From:   Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To:     Zhu Yanjun <yanjun.zhu@linux.dev>
CC:     Bob Pearson <rpearsonhpe@gmail.com>,
        Bart Van Assche <bvanassche@acm.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>
Subject: Re: [bug report] blktests srp/002 hang
Thread-Topic: [bug report] blktests srp/002 hang
Thread-Index: AQHZ0/swwnzlQmtfZ0imcm9Pm4sUp6/1jPEAgACO/oCAAFRogIADyeOAgADUmICAHhq8AIAAZTSAgAOPOACABJlyAA==
Date:   Tue, 19 Sep 2023 04:14:07 +0000
Message-ID: <nqdsj764d7e56kxevcwnq6qoi6ptuu3bi6ntfakb55vm3toda7@eo3ffzzqrot7>
References: <dsg6rd66tyiei32zaxs6ddv5ebefr5vtxjwz6d2ewqrcwisogl@ge7jzan7dg5u>
 <0c5c732c-283c-b29a-0ac2-c32211fc7e17@gmail.com>
 <yewvcfcketee5qduraajra2g37t2mpxdlmj7aqny3umf7mkavk@wsm5forumsou>
 <8be8f611-e413-9584-7c2e-2c1abf4147be@acm.org>
 <plrbpd5gg32uaferhjj6ibkt4wqybu3v3y32f4rlhvsruc7cu4@2pgrj2542da2>
 <18a3ae8c-145b-4c7f-a8f5-67840feeb98c@acm.org>
 <ab93655f-c187-fdab-6c67-3bfb2d9aa516@gmail.com>
 <9dd0aa0a-d696-a95b-095b-f54d6d31a6ab@linux.dev>
 <d3205633-0cd2-f87e-1c40-21b8172b6da3@linux.dev>
In-Reply-To: <d3205633-0cd2-f87e-1c40-21b8172b6da3@linux.dev>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR04MB8048:EE_|BL0PR04MB6530:EE_
x-ms-office365-filtering-correlation-id: 44b0896e-2d6f-40a7-e2de-08dbb8c6de67
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: wyIR03OMSRSyfqW1d4hyN2329ShASQSo1bGeXoS/r7klpWYgFqwHgVtojIUMF6kl4VwSAPJZrQ/nhXhi4v6VcQUDNEVtRkDCRfBbC+EX8nwdWjdWQo+s3EuEDD0PGD4MjX2cM1wWxqrzZkUBigdfLwXy8SNaQhkHhDrGd072SQhaFIlkNoXWP/Mx8YqdwLviIRuRQhUtRYPfGJ8Qk3SkVarMwdqqHIvLyNb7kmll6pLZSKPAWY5PhDVqR/VjEA5oqv2mi8JZQMjwlYIGxTCGcpOYCYC73mXZioL1jwfNaOrpax0R4x4jVJjyll4uE4JW7Mk+93P7PeiYJG6FQNnnk75iIKCNj7sHUu3EM1J2DFnAzvwMRGLSXEqelwjWmg7F/LRqGp7LpQVIh192a1IHJ/rpGJNqLoO9XyEsrXKayymGtAeKOgBLaHOEHHh9K7yc2IxM9yf/rpd9u9VWe+PIXfROlBf2PQeXuJPj4Ut/Rv9mgosYqqfQcRHtVETDGbsGiGqWpFfok/2FKuRTtOFMhN6MMCoKk48bXxORxvql9u52+2hMRMdU/YLYAzNEeLaZDjeUXqB5eRHjOYEPV2wSuXrtM2/wKbXzxEyb/DD6rGMZjX2bLzc9TeQcblgYUQAs
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR04MB8048.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(39860400002)(346002)(376002)(396003)(366004)(136003)(186009)(1800799009)(451199024)(83380400001)(6512007)(9686003)(26005)(316002)(6916009)(41300700001)(91956017)(76116006)(66446008)(54906003)(66476007)(66556008)(64756008)(66946007)(44832011)(5660300002)(4326008)(8676002)(8936002)(71200400001)(6486002)(6506007)(2906002)(478600001)(86362001)(82960400001)(122000001)(33716001)(38070700005)(38100700002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ZYlWclqg4+xAnyMIalGiYpqAozFuvhkTHc1DcBSoCb0wAA0FRlAy2VS9nxuw?=
 =?us-ascii?Q?0Az3tpGC7IB6Vc101j4gr78slCkftLf9IpKZ7+WbN5iWQx1yIVNgKLujdIQC?=
 =?us-ascii?Q?2KUlUVjl20PoKt6NOcVyPjuYc8+HK8iM8OJXVZkUh8fTbpciuIiFAOd/5cga?=
 =?us-ascii?Q?ekT1kYzwL12t2IEu8R31Jh1DSQRiqbPPMkXhBhUEfePjPbe8C3eRjsrHFdQE?=
 =?us-ascii?Q?11fG17sv8Nio8rR3a6y41UCl5huQ0JtCGjpc8iVLwRBytjgUFVNNxSc+CugG?=
 =?us-ascii?Q?RWe6l/wRmRHQss89fruELS4aOTF4SS6NtFrA2Q0wdnK8n49hhSXYnjjX2mcn?=
 =?us-ascii?Q?hEJYX6n4V1IhA506ci55kcPp06lZf/ejYA+WCMEKMZN2i8Y3c8P9ith6Oi4I?=
 =?us-ascii?Q?4cjUpp5xZsGVCCDjcBmbO2Y44zTrebM6zG8bLFoZ5UfqMSvhRav5u3HePGsx?=
 =?us-ascii?Q?R38kdCWxGc3HwGV0fO/NyU9y5GJdO6V1Ok+ZzJ9Gg0oEv9u24cW6PIOB+5IM?=
 =?us-ascii?Q?+qioLuDa9DNiucukLZezr4yidKcWCGkHm3J4w24ZJf76ADku/da4Du4kP/Sn?=
 =?us-ascii?Q?pgTLrueZpT9IWFMN1otyZYgR5Obaap3fCFHws/2vU+JB50/kB5UNirE8IzgU?=
 =?us-ascii?Q?wFCBlZceSO2mhLnlkwiYOaiZ9FUEsHZsk53Swbk3TP6Rxw0jcjQ1HnL1tbh+?=
 =?us-ascii?Q?SGysUxHhdqYE77I8JPmC9+2dOzEkQcVBp/HdzB9l5JL/UTql6rx9DiUyiq8b?=
 =?us-ascii?Q?Zn2UrcFIjrLNvK6H0RHmefF9X0xEaznpPWmgKxhrd8eJl/OT0HxUwy25eXze?=
 =?us-ascii?Q?K/VeMaRPPDaMJ/z4ixgZ3l6KfbUQ9gxARRyi1huMjmc8wRsTby9E+usJy/Lz?=
 =?us-ascii?Q?CUBIT0gFS0lnfxDKyg4iAOMX+jotXjRoXM5W4kIROrrD1DdL8fXUqlOBa/nQ?=
 =?us-ascii?Q?7KE6Dhn0RbAn1465xYH9kn6N4sWltOImRfJx79q5tBHnmCfcZPxny4LczEdD?=
 =?us-ascii?Q?1R70qO1Z85b56gwEhSi/FFGFP8yxtVLD4Adnb8QgdGgkcYAMmdVokXuhhHxK?=
 =?us-ascii?Q?EVvBDq2UDIVZAHPKdrRFPnhZ2ImHLEH5CqfeQWFxu1RNxm8HUJW3MwvokvLO?=
 =?us-ascii?Q?r+9PlSl6MZ/9GqX94zaZf+Td1/Eb7rJt3lqUN0PWFhGOkAYUkD0G1XPeJVc8?=
 =?us-ascii?Q?52Y9qgTpu+1e5HWy9nYoAWj4Z16cnLANawP+ZFDetxyi2KwfcvvtMLvHQoQF?=
 =?us-ascii?Q?FpSAttBfqv12E/O1JxdBbmZDoBb2oVZla5iwBCAgyKol+HlQcQw8CMte0LZV?=
 =?us-ascii?Q?DmnH4HOvSbCXI1Y5SQ9EkQ8lypJxwJbcB3qEL7KlWqDxULCII6CJvtIr2dku?=
 =?us-ascii?Q?fneHRkC+sZ48jAIWEUE0rlqbNLgK+Me1DpIpdGLqWXzVqSe2tRZzCqp6SQPZ?=
 =?us-ascii?Q?33i4OSch8Fg6keStohU6nB3WlyYGQ3PLQO4Yuf0gzk91OMdi2taoz3o8VMpN?=
 =?us-ascii?Q?53XxbgCVKRkdggPFjlh2XeMUE7Z46qd9Dsl4cguCyenyd/LKDrAhiMWVNyf6?=
 =?us-ascii?Q?B8zu4FLHnpd/Q94rkggBZvMRGZ8nw3wbHvKYECpepv06sU4U+H/oYdO9Ma23?=
 =?us-ascii?Q?nbxQiGdIv3uO3B7kPHHrA1M=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <A368D4B8B9FBAC4B9D5FDC50636D0C66@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: ApxiKB7ba2JExGFHGcjonH3zRNBsMhvkoapPIeczzMTDDCZt8ja1nq0PFB8i+bWIhCFPNUVw5WMiNPnE+B6GlQA0AOReofBLcVhXjLc9LEiFVon/gQor0DNAQ6ZsNQjz54GGZjzLNhhH/rLpxtF+S7omcCTLtNpxKrXJAlCXtyt6LPaH0wqhUGBVkPnkepof2Ch9enLKVddIqsCw+NKGgJnTPsvjf45uChKHPBRS+bp8xcJ5KceIFh1pR8yrcUcCfR+57AQg1XS24tkeUdRoZc+zTjlDPnzQoaBv1sIyfUxBUdt1bL3py1ijMTHPqUmfLclYUz/oMcfw7b5e4NwHz90aHEXrDcZbyIsQR79BVBBGfaO5tP6WNFBtYW5yiLxSdfMlMWLdc9Po6ljF7tfF9SJ1gIN2HKnGpUR79zhTrgrsgpRJrJK9pnRRZmhIO73PkK40yWcU00gWeZ/WFsf6VY/WBP9nS/NENYXOLGvk7+W5EUEzdF4fmF9LZ4lyNz5ue77XkX7TLkd60KCAtVEBm6W50z673XXet3CcLC8yKQiRYrGiLcOU/VwwZNG2U6V+BedLcIbvOHInnbVSbVgZmCdkIwCg/HvH7lTfgIZ1RQOr5QVSlqpKKoz2dDdniUXe/EQvxuTjU1WPVo9p0WdyRO9PmV2gA7LyHEL+Pmaz/CEz6IQaXCeG2V6ZlYCBgRKgJGySqeeHmAKXgzuQ4fiuj1ZbHOaNpsKI38TBpvdlvv8/U7fLQJj1kYV2Rjjkdr5BaMqgZGyAVmMt/rtHavsYewxGjzaJKr2cpjQKJdvJLZk6Cj1eh+EgbnV7T3bHncgBAtETVZdokdFlNU/XdOXPEMmhZpM9OTcByj6xqXMM9YI=
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR04MB8048.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 44b0896e-2d6f-40a7-e2de-08dbb8c6de67
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Sep 2023 04:14:07.6904
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OGkEs0S6YBtEtUOqJ6amD7vYRVfLAU5/Ds3FFHK+2Ag6r3V8B12NLd/v8DkAUdPSvrTTvCJdIEwVzEHq1o441EAQY1r6mu51gl5R0IAImpI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR04MB6530
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sep 16, 2023 / 13:59, Zhu Yanjun wrote:
[...]
> On Debian, with the latest multipathd or revert the commit 9b4b7c1f9f54
> ("RDMA/rxe: Add workqueue support for rxe tasks"), this problem will
> disappear.

Zhu, thank you for the actions.

> On Fedora 38, if the commit 9b4b7c1f9f54 ("RDMA/rxe: Add workqueue suppor=
t
> for rxe tasks") is reverted, will this problem still appear?
> I do not have such test environment. The commit is in the attachment,
> can anyone have a test? Please let us know the test result. Thanks.

I tried the latest kernel tag v6.6-rc2 with my Fedora 38 test systems. With=
 the
v6.6-rc2 kernel, I still see the hang. I repeated the blktests test case sr=
p/002
30 time or so, then the hang was recreated. Then I reverted the commit
9b4b7c1f9f54 from v6.6-rc2, and the hang disappeared. I repeated the blktes=
ts
test case 100 times, and did not see the hang.

I confirmed these results under two multipathd conditions: 1) with Fedora l=
atest
device-mapper-multipath package v0.9.4, and 2) the latest multipath-tools v=
0.9.6
that I built from source code.

So, when the commit gets reverted, the hang disappears as I reported for
v6.5-rcX kernels.=
