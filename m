Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF3DC5A4227
	for <lists+linux-rdma@lfdr.de>; Mon, 29 Aug 2022 07:16:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229456AbiH2FQe (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 29 Aug 2022 01:16:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbiH2FQc (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 29 Aug 2022 01:16:32 -0400
Received: from esa2.fujitsucc.c3s2.iphmx.com (esa2.fujitsucc.c3s2.iphmx.com [68.232.152.246])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECFAA18B2B
        for <linux-rdma@vger.kernel.org>; Sun, 28 Aug 2022 22:16:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1661750191; x=1693286191;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=w2JNjm7jMRp69FFngojDGDgHtuQ7Yas71qMRA3m3Wm0=;
  b=YD806zAyeyyJOF+OB4Y1DZSeZFhjulBrGgDgmzi7dzb11LG+m9DkCZwv
   iBbf6wR/5kHM0VhzVEhZhfd3kcUgTR/IcLEvqXBJ/8jAMej1U61o1n8O1
   qgSXv8r7TAxKIclxPVqvXkKdKjk/chwaQyH/saLWZRb5eyWQbBuDMQqo1
   boZSklmOFaTYxIs3Nx3tLtm7eAYunlZ2GzI/22dEhHI1fKBYNAMsQOyRi
   B1MZ+zyIh/1gfL/carbt5tgH6XTWe1rVLjDLqw/b+VPQZJ9imkTqs9BnL
   1V4HenW4xSNFe0G1TgknNDjjtNdgZP/cWE63CvAaA+KeExKwA/4ZlqrJM
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10453"; a="72038843"
X-IronPort-AV: E=Sophos;i="5.93,272,1654527600"; 
   d="scan'208";a="72038843"
Received: from mail-os0jpn01lp2110.outbound.protection.outlook.com (HELO JPN01-OS0-obe.outbound.protection.outlook.com) ([104.47.23.110])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Aug 2022 14:16:28 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A6hR2oEakh0FP95dlnB3otYrW8EJbJQ3mTp2c1N59yv9W/9GlSiE68tsAZ7QlV0+wKIVRD8gADUc710lT1PtxtjObfLRH/RMhkLFd82xrKudu+7wN6Q+l0YBmNqqvqbhwMN7wCWMI7H11oY/cLtB5VBbtsIaynSh896PJ/wCYQGRJtuaQ4OMLMBkpH1d3ZzJvionYih9QbihcwlZp1IWGeUGPnqdAeMAKLQUyU2OrDLglfHeaL5kykF80Ymy536ygUrtDmQZXVjf9cun1bmWCINszKDRCPJqhGG5dFH4a5j32OEqK3SRjrj3IWiENA+SPKkDo+Bb/HOrccof7UiMDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IeLzl7znSCZmZ2VqoJxETlO5g5k8LJvTqjceT9mVYVc=;
 b=AGpSb5DtMzJ8LjR9X1U8RCCEmEXtsW9XbgiHgLMWND0EOPjC+s87SnbBm3ru3klicvLSOwEArdjQwGdk1cauQKSMMXVBS26OcFHOe4VqIgw+Awt/fXgEKZSg0/OeVugyAOF514uAq3BGrmrU/+fijNpK0tWaQf1DykI/Ec6qdzGXO/qYD2j0xggvkVlpS2XsU1YorozRamLzMHU0m0+0dsrRHbmae/uikHkVbOnl8SuKbKEauV80/OaXiKYfljf9yX4dm5DGMonm+wa4HaQV7UkmLCc+UXDtMR24EZ0YRuIyiOF0rbJCphzYExgvQVm03Kw8RShQEmi313YwvwVV5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from TYCPR01MB8455.jpnprd01.prod.outlook.com (2603:1096:400:15d::13)
 by TYAPR01MB6027.jpnprd01.prod.outlook.com (2603:1096:402:31::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.15; Mon, 29 Aug
 2022 05:16:24 +0000
Received: from TYCPR01MB8455.jpnprd01.prod.outlook.com
 ([fe80::1931:760c:588e:9393]) by TYCPR01MB8455.jpnprd01.prod.outlook.com
 ([fe80::1931:760c:588e:9393%9]) with mapi id 15.20.5566.021; Mon, 29 Aug 2022
 05:16:24 +0000
From:   "matsuda-daisuke@fujitsu.com" <matsuda-daisuke@fujitsu.com>
To:     'Jason Gunthorpe' <jgg@nvidia.com>
CC:     "zyjzyj2000@gmail.com" <zyjzyj2000@gmail.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH] RDMA/rxe: Ratelimit error messages of read_reply()
Thread-Topic: [PATCH] RDMA/rxe: Ratelimit error messages of read_reply()
Thread-Index: AQHYuHJTUxRnm0WWWEiwKrp/i8gWE63BHcOAgAP93GA=
Date:   Mon, 29 Aug 2022 05:16:24 +0000
Message-ID: <TYCPR01MB84553B491F193E90F5343216E5769@TYCPR01MB8455.jpnprd01.prod.outlook.com>
References: <20220825110255.658706-1-matsuda-daisuke@fujitsu.com>
 <Ywi8ZebmZv+bctrC@nvidia.com>
In-Reply-To: <Ywi8ZebmZv+bctrC@nvidia.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-securitypolicycheck: OK by SHieldMailChecker v2.5.2
x-shieldmailcheckerpolicyversion: FJ-ISEC-20170217
x-shieldmailcheckermailid: 318c674ee7b240b082d7edf2342c8546
msip_labels: MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_Enabled=true;
 MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_SetDate=2022-08-29T01:56:54Z;
 MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_Method=Standard;
 MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_Name=FUJITSU-RESTRICTED?;
 MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_SiteId=a19f121d-81e1-4858-a9d8-736e267fd4c7;
 MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_ActionId=6fe52e66-ec51-4275-8105-18478565d456;
 MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_ContentBits=0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 868c5f4d-ee33-40e4-818a-08da897d9e2b
x-ms-traffictypediagnostic: TYAPR01MB6027:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 3jVR5wIM0K37dmeW/1ZvqIqGvyZLTBW2t2FDKdUY5TYbtLBuQW3xNIEYu9jJT78cWNGajZEstZDGHzvyIg6orR5sO+aUfmLkc1v9yFbwUbUcQg+SSxtuUVoNtzGlYyo6BPQKHVxR7BsCv1qS0d1hMCVUkadJMSkMuvsfH4SP0UXJgZR4iq9otdSFFWANES0gTc12bn1vriop0rKO/+BgqUkkJQxp34p6QqEAZHtaF1lPOAWix7rAurrE6k/Vbfjl10jPtXxX2eySn42Y9zeQDAv6E9+MrJBl7luDyNJLvSOVCkaddOD4jSRz2+igchftdG+jQ0GcGANxNDqqE8FynV6cJxCf4AC619+4dosPMMSpjS/047S4LMt8vLqRsxcskRNy3/7go+eP8P9DuafULwVs4Y74A528GYVQ1+SGZK6TNUDbhaHc4+ltaZS8siF+sU2Vc1mcKtjaqTl1qizMbdNY+NQmUlQUwalcQiJGovuGMxLSYCsmSFPLyPvr+T/Z6CL6Q66tbtkjTEuhdFbNypn9rS9MguWMUF0mu64krjYpyBKpc9weh3SCwrZ0frXBHvqb+SeCnZ8EulVN7kHNm+YqMkWMoTNuzgFUXHken6xlZ3G7AjYkEhLKu9QfQ+yB0GN94k847/AFO1OIkMSxg/juI4tfoJr7MVkiXHZeHouWzT3mOYoT/yPfmZAVZ77zeV9+1rRrH+H9uSJwdff8/cq+LI0sVsO5YVaCFeR+83ZvVrRFR9WLf9zjmoWmbqje5S6fF1kAZLPIr6sB/xv7U5Eb3L8cSBLiNuKfnU+SCqI=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB8455.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(376002)(39860400002)(346002)(396003)(136003)(366004)(1590799006)(122000001)(38100700002)(6506007)(15650500001)(7696005)(53546011)(1580799003)(2906002)(55016003)(83380400001)(186003)(33656002)(9686003)(26005)(86362001)(8676002)(4326008)(64756008)(66476007)(66556008)(66446008)(66946007)(76116006)(71200400001)(316002)(6916009)(54906003)(82960400001)(52536014)(5660300002)(41300700001)(8936002)(38070700005)(478600001)(85182001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-2022-jp?B?V0hMbUhaa05kbkNBMTE2cDV1ZUlUay81L3M4Vy8rVjR2bUUrSHIxUWJv?=
 =?iso-2022-jp?B?NmtlU0t0aUVEZlVKMERZRlVpQmtwMGhKSlZreWxNUmdjeUNWRU5Fc0xn?=
 =?iso-2022-jp?B?WmJBM1NsOFdpT3Z6bW9mUjNZelFZeWRRK0ZOelIxY0xodnFZaW1OM0hM?=
 =?iso-2022-jp?B?amtmM0ZaL2ZKUklKK040WTNab1BmejJobkxTS0xrY2lWMTJMYVcrT1o5?=
 =?iso-2022-jp?B?ZUxaWUI1aTFkOE02MnRMcjdWUk9qUFhqR2FyTGYxYWxSU0FmU252cTNP?=
 =?iso-2022-jp?B?VWEzWXZiUkZxVmtrSnFIL2x0MUYrZU5uekEzMjNuaHZGOXZ2SDJxNk9t?=
 =?iso-2022-jp?B?Q0VSQVVNZnJKVS9QY0ZEdXNpamhESXNaL0xTcTdueElYOTR5VDM2Q3lM?=
 =?iso-2022-jp?B?WTZQbGQzL2FyRmhRM21BRVJyajRMeTFKTy93TG1ka1FXVm5velZWQWd2?=
 =?iso-2022-jp?B?VUR1QThONlJvWkxoSjZ2TE9Sd2lFQzRXeC9XVUVZcVM5dlRvY01oNVJ2?=
 =?iso-2022-jp?B?OEU5ZE1vM3pRNzUyRTVoMzNiQlNIZkZGQTFNMmNGWU9lbWl6c0VwclhL?=
 =?iso-2022-jp?B?U09zd1ZQTWZ5OGFmRE05V3ZROXdpbVN1cTBKNmFVUjlBQ1RnOFNHRzBS?=
 =?iso-2022-jp?B?N0lYblpxR042RzJZU2hCWTYwbFovanhvWU1IL3R5aGY3eU1udHRFd2tn?=
 =?iso-2022-jp?B?VmwzNGxLM0pqME0zWXhMOUdnZkhGNmx0cWVjQmFzRm1ZUGRKQkFMUXZk?=
 =?iso-2022-jp?B?Z2VmSzhuUVdKUFFzV1c2eGZ6YitnVURlYUZSNUxtNi96WU9HdnNFaTZi?=
 =?iso-2022-jp?B?VWlKM1NQMjI5WHZUZEZ5c2YwVVo4UWVSRno3Nlo5SGpFVENtc3ZPZXR2?=
 =?iso-2022-jp?B?SndjazczVmNiTzFmZk5tN2FXdnhpMUo5YlpLbmNicktjZFgzaDdEY1Rt?=
 =?iso-2022-jp?B?NDlxYkdKWTMrbEVmc0V1RGVWN2Ria2o5a1N0aHZQVm5lUW0wc0huS1Rn?=
 =?iso-2022-jp?B?WmlzbDZna0V2RFU2aXZEU1R0aTJ6MFI3L2szQ0l3M1dLRjBOcTRzYlRp?=
 =?iso-2022-jp?B?dFltRTh3bWJXNDNGN2I5SU16d3d0WXZIejJUQ2hTSmFxU3dpTVU0YmxC?=
 =?iso-2022-jp?B?M2svZVdXZzN3S3FzZkxDOHBRdzBCQmt5QTFIRndSWVgrOFVOblFOY29m?=
 =?iso-2022-jp?B?citZeGI0VitYOW8wamYzM29vMmYvdVpmaW56dzRRK0V0K3k5T1MyNlBK?=
 =?iso-2022-jp?B?OXNCUnFKdVFzUzVaSjdJOVNnTTRLSDRKU3RmeVQyVUdQM2ZLUHZ2MG9o?=
 =?iso-2022-jp?B?SWVxaG0yQThRdTJJMW82SWoybW82SlZCZDJtL3UwamUzVE5raEFJN2la?=
 =?iso-2022-jp?B?Q2FUZ2JtWi90WmFRWlMxZDFkcUhrV294RHYzVFh2d3dDRTJWbXBaVUs3?=
 =?iso-2022-jp?B?bVF4M0V2b0NLVVpTMy8xQ2RhYTRZNUd2ejZiU2VDWFFLOTl6N0pkaFE5?=
 =?iso-2022-jp?B?TmdpazhPNVpNcXVhYXBWTGlxNkxYM0VzaHBvZ3UxNW15QmlSZ2FxeHZx?=
 =?iso-2022-jp?B?bXdGMzVJUFpWYlRGdldVWVpYS1QwT1hKSHJkM1prb2p3cE56d21yeC9Q?=
 =?iso-2022-jp?B?ZE0wWFRSUEJCUGd3OHJZMGRobWpBRHY3WEVKRlZpTFpGak5DT1dMZmgx?=
 =?iso-2022-jp?B?ekFnZXkrZERXTUtpeWE2TVFTWEVnVnRLZGdRQW1USmNsdVY3TGNnN3ZB?=
 =?iso-2022-jp?B?d2x4NmdKaGNTRFlBTnRkbjFnQmtMb2V0UG5ZRS95ZjliaWZPd2lYWHZa?=
 =?iso-2022-jp?B?TmZXdEJTcTBsVlN4R3FFYlFuRHdocFQ2SUhENWJ5YzJjanIycDc2T3hq?=
 =?iso-2022-jp?B?VFdrMUU3dnAzUVl2Zk84RkE2OWFpckZaV0QvZ2hncVdqdTNXQ0ZNcFlI?=
 =?iso-2022-jp?B?STBTSEh1cFU1dmVxeDJPcDZDa1JlU3Z4YkNpbHZXUEtZVUY1YURXd3dK?=
 =?iso-2022-jp?B?UVZOMFdLL25vR3hhUXFpa25oN3U5NnVUbGF4dmE3Nk81OXhtVTd3bXRB?=
 =?iso-2022-jp?B?NDdqTHR3QldpTWd0a3FVbTVKWWZtVm5QQVVEWU9tZ1g1dFFlZGtDVUhR?=
 =?iso-2022-jp?B?VHNKK0hub2lZVTRyN2ZqTi9vTDlHYVpqbldPdmhYNzRJMXV6azdJdWlx?=
 =?iso-2022-jp?B?OFFDUmlIOWhaNXVvMDRSNzlWOE9EU3pFZkkra3R2TnFVaTJTbWNhbHhW?=
 =?iso-2022-jp?B?YXhNVWFYS2RHeEhORy8zMjhVR01qZUlQZ1dQaDJscSs5dEcyNHJ5ZVpU?=
 =?iso-2022-jp?B?TW1mMEVaUVdjWmo5anhiajhScnJ3K3lMVUE9PQ==?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB8455.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 868c5f4d-ee33-40e4-818a-08da897d9e2b
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Aug 2022 05:16:24.3758
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FbfhtSqbyh9f8cMj+a/9oVXqoCw5srAFXq/S8jyKypFrN21mlcy5f3JzD7FTFhG6GziNih8AunhDmcFEkg246FYnxUV5y6Zxw8azDuNpqbE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYAPR01MB6027
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Friday, August 26, 2022 9:28 PM, Jason Gunthorpe wrote:
> On Thu, Aug 25, 2022 at 08:02:55PM +0900, Daisuke Matsuda wrote:
> > When responder cannot copy data from a user MR, error messages overflow=
.
> > This is because an incoming RDMA Read request can results in multiple
> Read
> > responses. If the target MR is somehow unavailable, then the error mess=
age
> > is generated for every Read response.
> >
> > For the same reason, the error message for packet transmission should a=
lso
> > be ratelimited.
> >
> > Signed-off-by: Daisuke Matsuda <matsuda-daisuke@fujitsu.com>
> > ---
> >  drivers/infiniband/sw/rxe/rxe_resp.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> These lines should be deleted, network packts should never trigger
> printing.
>=20
> Jason

Okay. I will post another patch to do that.

I wonder if we should also delete some messages in rxe_rcv() and its callee=
s.
It seems some of them can be triggered by packets from an arbitrary client
even when there is no established connection between the requesting and
responding nodes.
As far as I know, the message below can cause a message overflow.
=3D=3D=3D=3D=3D
static int hdr_check(struct rxe_pkt_info *pkt)
{
~~~~~
        if (qpn !=3D IB_MULTICAST_QPN) {
                index =3D (qpn =3D=3D 1) ? port->qp_gsi_index : qpn;

                qp =3D rxe_pool_get_index(&rxe->qp_pool, index);
                if (unlikely(!qp)) {
                        pr_warn_ratelimited("no qp matches qpn 0x%x\n", qpn=
);
                        goto err1;
                }
=3D=3D=3D=3D=3D

Daisuke Matsuda
