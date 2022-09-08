Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFA5A5B19ED
	for <lists+linux-rdma@lfdr.de>; Thu,  8 Sep 2022 12:27:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229561AbiIHK1G (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 8 Sep 2022 06:27:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbiIHK1F (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 8 Sep 2022 06:27:05 -0400
X-Greylist: delayed 64 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 08 Sep 2022 03:27:04 PDT
Received: from esa9.fujitsucc.c3s2.iphmx.com (esa9.fujitsucc.c3s2.iphmx.com [68.232.159.90])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 392FE98583;
        Thu,  8 Sep 2022 03:27:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1662632824; x=1694168824;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=aMd9tLHJ3kpKKOj8pW39B6IBxgZjBQVV0Z8etTF+J1o=;
  b=hM1WtNDaImEeWIOrvW0PFncP1ZO6sjMf/4DIqx8pe4eW4cnPWLTOOVn7
   ndDU1Syj2IU6qMET1Ae8n2rggopuqXCmhjQUa+pqZFi1fPQVVf8ovnuOQ
   i+5wqBenl05DgiW4dZnoPQhDkeizrn9I555ieP88bO35f1501MoWCXLKp
   yme3MDNXvy9Sx37OadZvjvTiSfY8GnXnuVP88Eo6/N1Ac8NJLST9poXxY
   Q+LXsuqmBXZ4G0P308+vFhlRDiyefBHU5NIF50eWBXJ1kFrd3TTeIPr0H
   4kK+MKyWHQcU7m4V66tonWI/IS0q5qna7JHsXLw01koMlqZL/r48bhS8d
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10463"; a="64820402"
X-IronPort-AV: E=Sophos;i="5.93,299,1654527600"; 
   d="scan'208";a="64820402"
Received: from mail-os0jpn01lp2109.outbound.protection.outlook.com (HELO JPN01-OS0-obe.outbound.protection.outlook.com) ([104.47.23.109])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Sep 2022 19:25:56 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PIgr+9VqsE6Es4MRwkPB6dFvNcT7KIymyLWzLdof8CM5Yc+B1mgb2zDwS1PxEbIc+pIG3XNNAhYu48xkvlLc4NGVy0aPNrvuFru2z4JM38T87a90Yezb6SzBlWL8iLoogyT9AtGiapi49CoPxPGOMWroq5wSb/TP0MUVRnewTYGe32Ybef8xbol9pB49kCxIVJX7SkcBBZusQYPhRA2ou6G7KjJB2ANHyueApaZ21Yo6Pk3TZlluigf5MewBnKa62CmnXMFKN4aaCmMToTQU46+l3IiIY7kwmnBgl3jHe2od1PZh99+RqznEWoJ2m/59Vz2hRrFUwL2ogqpqL5e4QA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aMd9tLHJ3kpKKOj8pW39B6IBxgZjBQVV0Z8etTF+J1o=;
 b=nxy+uoK4E8/SkYfuRY/aE3Bx2q/DV/1D/rieriTeBPn1JxiU53lghXl2RMUldGTb+GSQogV0xqrcgcEVTcR4vGRdF8U4+eMy+lQ0vZyBmW5RYdtTnbEjAqMDIImSshnELazfh+EQ3Bxr0l67WhvrFH7Lglsb612CauklF2tIBLI2Siz1isMHfss4+ElJ55C8XFKpw8k4NT+z0KMV1AkhkLbyINJ6JMWcI2JuubU82tP+IWe4Yg84stGgrZcjXbUt4qQvG3ensC21dGtJjeJmpsrFlZuAz89IeSD1m8BLm1VTl+aG4faUXZUB7GBx5Yv4GJkCfaLmbYmKF9LzVKV02w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from TYCPR01MB8455.jpnprd01.prod.outlook.com (2603:1096:400:15d::13)
 by OSZPR01MB8290.jpnprd01.prod.outlook.com (2603:1096:604:184::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.15; Thu, 8 Sep
 2022 10:25:53 +0000
Received: from TYCPR01MB8455.jpnprd01.prod.outlook.com
 ([fe80::1931:760c:588e:9393]) by TYCPR01MB8455.jpnprd01.prod.outlook.com
 ([fe80::1931:760c:588e:9393%9]) with mapi id 15.20.5588.011; Thu, 8 Sep 2022
 10:25:53 +0000
From:   "matsuda-daisuke@fujitsu.com" <matsuda-daisuke@fujitsu.com>
To:     'Zhu Yanjun' <zyjzyj2000@gmail.com>
CC:     RDMA mailing list <linux-rdma@vger.kernel.org>,
        Leon Romanovsky <leonro@nvidia.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        "nvdimm@lists.linux.dev" <nvdimm@lists.linux.dev>,
        LKML <linux-kernel@vger.kernel.org>,
        Bob Pearson <rpearsonhpe@gmail.com>,
        "yangx.jy@fujitsu.com" <yangx.jy@fujitsu.com>,
        "lizhijian@fujitsu.com" <lizhijian@fujitsu.com>,
        "y-goto@fujitsu.com" <y-goto@fujitsu.com>
Subject: Re: [RFC PATCH 0/7] RDMA/rxe: On-Demand Paging on SoftRoCE
Thread-Topic: [RFC PATCH 0/7] RDMA/rxe: On-Demand Paging on SoftRoCE
Thread-Index: AQHYwmOzpZdRkdIQi0a3gnTpfBllbK3VOKOAgAAXLXA=
Date:   Thu, 8 Sep 2022 10:25:53 +0000
Message-ID: <TYCPR01MB8455E06C51A4C581C735FE4FE5409@TYCPR01MB8455.jpnprd01.prod.outlook.com>
References: <cover.1662461897.git.matsuda-daisuke@fujitsu.com>
 <CAD=hENew09_VowX_c=O+wMBkXNFK1LRV5+TZ+VVHKQA5-itHvg@mail.gmail.com>
In-Reply-To: <CAD=hENew09_VowX_c=O+wMBkXNFK1LRV5+TZ+VVHKQA5-itHvg@mail.gmail.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-securitypolicycheck: OK by SHieldMailChecker v2.5.2
x-shieldmailcheckerpolicyversion: FJ-ISEC-20170217
x-shieldmailcheckermailid: 610d3671719f4a7ab14689f7c6cd5321
msip_labels: =?utf-8?B?TVNJUF9MYWJlbF9hNzI5NWNjMS1kMjc5LTQyYWMtYWI0ZC0zYjBmNGZlY2Uw?=
 =?utf-8?B?NTBfRW5hYmxlZD10cnVlOyBNU0lQX0xhYmVsX2E3Mjk1Y2MxLWQyNzktNDJh?=
 =?utf-8?B?Yy1hYjRkLTNiMGY0ZmVjZTA1MF9TZXREYXRlPTIwMjItMDktMDhUMTA6MjU6?=
 =?utf-8?B?NTBaOyBNU0lQX0xhYmVsX2E3Mjk1Y2MxLWQyNzktNDJhYy1hYjRkLTNiMGY0?=
 =?utf-8?B?ZmVjZTA1MF9NZXRob2Q9U3RhbmRhcmQ7IE1TSVBfTGFiZWxfYTcyOTVjYzEt?=
 =?utf-8?B?ZDI3OS00MmFjLWFiNGQtM2IwZjRmZWNlMDUwX05hbWU9RlVKSVRTVS1SRVNU?=
 =?utf-8?B?UklDVEVE4oCLOyBNU0lQX0xhYmVsX2E3Mjk1Y2MxLWQyNzktNDJhYy1hYjRk?=
 =?utf-8?B?LTNiMGY0ZmVjZTA1MF9TaXRlSWQ9YTE5ZjEyMWQtODFlMS00ODU4LWE5ZDgt?=
 =?utf-8?B?NzM2ZTI2N2ZkNGM3OyBNU0lQX0xhYmVsX2E3Mjk1Y2MxLWQyNzktNDJhYy1h?=
 =?utf-8?B?YjRkLTNiMGY0ZmVjZTA1MF9BY3Rpb25JZD1kNDA1NDEwOS00YmY2LTRiMTgt?=
 =?utf-8?B?OTMzZS0wYjliOGQ1OWNlZDk7IE1TSVBfTGFiZWxfYTcyOTVjYzEtZDI3OS00?=
 =?utf-8?B?MmFjLWFiNGQtM2IwZjRmZWNlMDUwX0NvbnRlbnRCaXRzPTA=?=
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5cd931ac-da9d-4fb9-c3e2-08da91848239
x-ms-traffictypediagnostic: OSZPR01MB8290:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: kMECm5RLeHfC9/vn37OB7qjAoaQnHqcTpt0/MTRjb+8PwG62V9tllhuaRTGsid4vC5IeXfBivU/Ua9pZhG1Y9ERj+AZhbjRlPITXcjwdnBpS6Suwu/0NS01ZFNqVjAP07eQsKdjbpvATp+F/mef66QBPf3jOFWIhUaVoesdj1TEpDW1/txqcg66YZoFFNtSWBnC/uM4l35S1b4GhkFvOXcLvsHPSofYHGb7bKJWLkgfxJfZlAELOFxXbLj+PGdHsWn8oKpW/4gYg1x7dyJRmzzeFYfVi3y/uIXMvLxM0i2s54P6ZjP6YXkg+XAwl5IHNm/UaP8AlxSQzOudjBCA702VeEBhA7bm15ACjZbYkGsqlJzDgOXTXHiqjIfJ12uGfcv6VL63j3E2twQPohvLZMwHGBgWX/V5NQ63GaBgDKqE+ZlXyJCeitCj5VOAXhHJ4sMg9l8cO7fvbHeVTptLox4w9ajZpBXoxyqQOcXtyRtAoA1BxlMnQ1rADaLsHRbKNJxGOiVerBWIxfBXqJ7hcyufMk/vQanE7wgFWo/UA07OH0yfU0BIKMIqAftmax8fYMXeVVieVe7D+wuMRjbEAU2S+6/gIm6jG23uJMIKbqP9yCZHqV+nRG6/diLFszkI3Aw9PePXyudkOfEgDhVQ9nnmSKoue8/LbRRzdLIwEHdqbxAiQniPeRXNCgznF7vdhbJblhM0BPpP3cwTRX3zoI2DcjxooEtNX++MGcq+H3wr1InwkdCelzwNCqiZT0XGh6Jxo/JVdiwnyOTl5zmS0l8Y+U9eapQDa/n8r5sl46/Y=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB8455.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(6029001)(4636009)(136003)(396003)(39860400002)(366004)(346002)(376002)(1590799006)(8676002)(5660300002)(76116006)(66446008)(66946007)(66556008)(66476007)(52536014)(55016003)(64756008)(86362001)(4326008)(8936002)(1580799003)(6916009)(54906003)(316002)(71200400001)(4744005)(85182001)(33656002)(2906002)(7696005)(9686003)(41300700001)(26005)(478600001)(38070700005)(107886003)(6506007)(53546011)(38100700002)(122000001)(186003)(82960400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dSs1TmxUUWs5Q2FUamJOd0tZNmgyWk9FcWRXZ2ZTZDlPOVhudmFuaFlxWSsz?=
 =?utf-8?B?UzNhL1IrWjQ1V1ZWK0hQaXNWNFhWMFh5ajF4Z1hhck5FZE91RXRUR1BUY0wz?=
 =?utf-8?B?eGxaV3RLM0VIVzBmVkJlU1I1OEVKZzYyekMyaVdUa3M4ajhwdlJGM2c0V3Za?=
 =?utf-8?B?MlE1WDBCVldSREt0Y1U3N0lkSEJZQUFSeUkvVTNTV3VLVkdVTGxKcUFsdEVH?=
 =?utf-8?B?L3ZFNWFNcksrQTNQT3kxZk1qa3FEbHJXSGJqazlMZ21sdmZzQ213RUJqbkNU?=
 =?utf-8?B?Rzc1VzZsNUliTTBncnlSdDd4dFBRbVY0MWFhOFQ0dWZFUjNsZlorR0RUaytn?=
 =?utf-8?B?UndOcFVMalRxbW81U3IzSjJUcnczRGNoMEVvMWNpMUlRWWhyS20xZTRVY3RP?=
 =?utf-8?B?WHJya1hpbzczeFZhVmJYeTFxR3k4b3VZNWpCMlR3QXl2eDJ3dUh2RlFyYUZY?=
 =?utf-8?B?MzhGZ0VWbW11T29vUW8wS1UrNlROVE1YV0JPTDhuS1lheGE5T1JiOHNJWnFP?=
 =?utf-8?B?bSszbkZ3Um44Z25MOFhxMldzOGVMMThjUUw4dXRGWDJFd1k2U3BoMlFCVElH?=
 =?utf-8?B?aEJ3WGluNlhzY1BaZVNtM0ZkdW9pM1dNTmlvT3BINVRKWWdYUlFzRWpDU3lH?=
 =?utf-8?B?cDU1RDllRmdqeDc2bGRrbTVocG9SMEFST0c4YWNWZlJaTVI3bEEwNDQzRlZT?=
 =?utf-8?B?SFVhUnJtYWw1d0c2cjdZb1BGZlUzblNPakdsaWlvWjArWHRrSkMzRkIxUmNp?=
 =?utf-8?B?MEFmK0VWQUU4WGpKNUhpZEpVS0dHV2RtVkJuNEdrTjdpaU03MHRyTmZYK2Ur?=
 =?utf-8?B?RGgrVHFleUlseXBESXlWTTNVQkZvUXlidTN2WnVDR0Vaa1llcHg0Z3JlSER3?=
 =?utf-8?B?TE5WRHFDZnppOW5LdG81bVJqbmpNczlGdmY4VkY0NE5INEQwMDd4aS9Fb0Yw?=
 =?utf-8?B?Mm9KNUJGanQxd0RUZnZzMVY4d3hFeWM2U2REZk9zOElia25LekxFV1BtSXY2?=
 =?utf-8?B?L2JORnArajR3c0Z4QnFqRmVyUXVMUzJzcGJ6NzcvWEEyRzVSbk1zZ2lxZ2hK?=
 =?utf-8?B?VWgyaFRBTUR2UzdMUUdQaGJaY1hKMVYva1hWNlBCejVDODFJcXlPejAwMGVp?=
 =?utf-8?B?dU9mZEhCbWtUeThHcEttQUcxRHRiVHl5TmhRRTJSU1JmaTFEdXRRNXQrYnAy?=
 =?utf-8?B?N2JGelVOZVpOTTJsVmhPYVVBeFg5TGZVS0NHVHFkelRWVEZFTVpobzdnUlhR?=
 =?utf-8?B?S0tudmtmZ0EzN29IeEVrK1JoU2hsMUJmbG1iNTgzL0NKMDg4ZUgvcCt0RWc2?=
 =?utf-8?B?WUVsMjdNcHF6djg2cVBFcVZVV3dXUmJPNTVuUnVOTFNNdG1YSVJaUXZLR0hM?=
 =?utf-8?B?Q0piSkp2VjBCYzc3WW5JcG9YQ3VsUGhZSXdTSFdrMDQycEtaZ01KbFBxWExq?=
 =?utf-8?B?d0lrK0kvYWJDL3V3ZVIwK1drWUF4aGY5VnA4RXlUSFZUczcxY1h1TExTRjJP?=
 =?utf-8?B?ek4zenhSYW9tVUg2dFBONUs1bUNLNFhZeE1ZSGpHZVlTVEhMTHM4QzJhb3E3?=
 =?utf-8?B?UGdaSVNhS0NGTnR3RFlMbERBREdxZUVMYXBUSDkwajZSL1c4bzJ4ZDJkdG40?=
 =?utf-8?B?ZnBvaWZhT0JwNGFRQ0NpQkt5K0FBd3l1bFh5VjR5d2FCV0piT0t3TUpiSXBk?=
 =?utf-8?B?TFY5K1cyY3FUV2VwK0xBK0tuNm9pVnFqb1RmY1huNHZDTE9XYlNxaFo5TmNY?=
 =?utf-8?B?U1JET3lOeGhGbkpUbWt3REJ3MU5uRTdqR09wUFdlaVV3cTlZejF3YXVmMmRF?=
 =?utf-8?B?Rk5DdDN4bHZxVnlUcEJKOXhiOFQ3VXlqeVNja2dMUktMcDhYcWlFcng2azVr?=
 =?utf-8?B?N2V4RWhNOHRid2w4TG1pTEFHWWNOM1BDV09ZSU5Iblo1UjBMYlA3VXpXTWVO?=
 =?utf-8?B?NlFyb0RmN1hHenkzY2c5dzdPZllyTkprbWtkTklNWXdXOU9FT01FR05iYjFw?=
 =?utf-8?B?akRwY1RyTjdNQ3E2dnhIOVFDTnNHY1ZzbzJCK1VRNTJlNEZnNWhHTkJYR3dL?=
 =?utf-8?B?dkQrb1dONkxZSzluSjhHTGp1UFZjb010MlZ5R0pDQis3NG8yZHg5RlVNbjNt?=
 =?utf-8?B?SFZ0R2ZGZzNpeXMwZit0UzNuU2JIZnI4UE1YbjY0enZ2b0R2ZTNmQkRNb3hS?=
 =?utf-8?B?NWc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB8455.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5cd931ac-da9d-4fb9-c3e2-08da91848239
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Sep 2022 10:25:53.2255
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Rz/pzFmO9aPLaCVqaREuPgoTtGL+4GZbQL4DGtah9glOsm7klV2TEdmuBieFdIvdwsg49B/N5sI+h0IAR484rY2+pQGewPcbm/1GybBGhn0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSZPR01MB8290
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

T24gVGh1LCBTZXAgOCwgMjAyMiA1OjQxIFBNIFpodSBZYW5qdW4gd3JvdGU6DQo+ID4gW0hvdyB0
byB0ZXN0IE9EUD9dDQo+ID4gVGhlcmUgYXJlIG9ubHkgYSBmZXcgcmVzb3VyY2VzIGF2YWlsYWJs
ZSBmb3IgdGVzdGluZy4gcHl2ZXJicyB0ZXN0Y2FzZXMgaW4NCj4gPiByZG1hLWNvcmUgYW5kIHBl
cmZ0ZXN0WzddIGFyZSByZWNvbW1lbmRhYmxlIG9uZXMuIE5vdGUgdGhhdCB5b3UgbWF5IGhhdmUg
dG8NCj4gPiBidWlsZCBwZXJmdGVzdCBmcm9tIHVwc3RyZWFtIHNpbmNlIG9sZGVyIHZlcnNpb25z
IGRvIG5vdCBoYW5kbGUgT0RQDQo+ID4gY2FwYWJpbGl0aWVzIGNvcnJlY3RseS4NCj4gDQo+IGli
dl9yY19waW5ncG9uZyBjYW4gYWxzbyB0ZXN0IHRoZSBvZHAgZmVhdHVyZS4NCg0KVGhpcyBtYXkg
YmUgdGhlIGVhc2llc3Qgd2F5IHRvIHRyeSB0aGUgZmVhdHVyZS4NCg0KPiANCj4gUGxlYXNlIGFk
ZCByeGUgb2RwIHRlc3QgY2FzZXMgaW4gcmRtYS1jb3JlLg0KDQpUaGlzIFJGQyBpbXBsZW1lbnRh
dGlvbiBpcyBmdW5jdGlvbmFsbHkgYSBzdWJzZXQgb2YgbWx4NS4NClNvLCBiYXNpY2FsbHkgd2Ug
Y2FuIHVzZSB0aGUgZXhpc3Rpbmcgb25lKHRlc3RzL3Rlc3Rfb2RwLnB5KS4NCkknbGwgYWRkIG5l
dyBjYXNlcyB3aGVuIEkgbWFrZSB0aGVtIGZvciBhZGRpdGlvbmFsIHRlc3RpbmcuDQoNClRoYW5r
cywNCkRhaXN1a2UgTWF0c3VkYQ0KDQo+IA0KPiBUaGFua3MgYSBsb3QuDQo+IFpodSBZYW5qdW4N
Cg0KDQoNCg0K
