Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B286E5790C2
	for <lists+linux-rdma@lfdr.de>; Tue, 19 Jul 2022 04:22:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235234AbiGSCWo (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 18 Jul 2022 22:22:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233620AbiGSCWn (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 18 Jul 2022 22:22:43 -0400
Received: from esa16.fujitsucc.c3s2.iphmx.com (esa16.fujitsucc.c3s2.iphmx.com [216.71.158.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0D2F33E19
        for <linux-rdma@vger.kernel.org>; Mon, 18 Jul 2022 19:22:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1658197362; x=1689733362;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=f2p4j0u8NIv0kyafXkZ/owlZxowI1plVrgrRk+h6PjE=;
  b=dErcMOV7vHjob+aqc0J2b6vLQ52orMP3+bsXJkUGm8gNP1dK32HXidKs
   HLu8T1GJl/qsJhr2FNl0YLoTYQRlFUSkliJma0/R3NkUrYBF95ATjSAzE
   1PUN2obq0yMmuWkqLna7427Vhk41LUqSEhkR2prSW9psKE2ke/ph6N4hW
   nXTaMKw1Z7C8QuVH/xFKmjRxLWiw+OpuwAqGAMEns8mHLceIMSjVIOZjY
   xWZdKch/SRjMR6WvhrKt1XCjt5MfoHHsLAf/gcZO6hvMIXv3hd79wjqKw
   IF2M8JiprCM/aGUdDiZCal5J5oiip3A2/gir5Xx0aUNW5y1h6ZMHQHO5q
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10412"; a="60557400"
X-IronPort-AV: E=Sophos;i="5.92,282,1650898800"; 
   d="scan'208";a="60557400"
Received: from mail-tycjpn01lp2175.outbound.protection.outlook.com (HELO JPN01-TYC-obe.outbound.protection.outlook.com) ([104.47.23.175])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jul 2022 11:22:38 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EVFfGIv2rHe2AXW6XldCbdPHO+pq9NF81TZWfVd1YpqEjpiCx6nSGhjzuqukz9Zm6txgJw0CUE0PKAmk8XhBh91PuFcsIOguyho0P6V90Czub+RcktAdQziPToxlbP6w+HW7zkhSDg8qLbvyNZOgXvBN5VNWfdG+SqWsCbPBLaBjTYDdbp3ld8yRKq2bvmV6XoDWSxhhgEetRKRYn60ODT139wjl7czQ3JZj9WlG5S7JzibAipWJn3ljNSeC31a+KC7vu4DIhvDP0UQY4TlEHxigUtApnc0V1kqWq0+EVQ9nnBhKQPJU6k6gYyEvqiEhBWCgipaBkVLNFzkjynyI5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f2p4j0u8NIv0kyafXkZ/owlZxowI1plVrgrRk+h6PjE=;
 b=ArLlNEbqqc4Qm7OAoE/Iqam/MsnbjGw8X6jFh4g5Xd7hhYahXjGONnyJIp/Lwpr6bxAiBF73jocncdAbUQngah/T2zqvZYVSZ29tgQ4mS+0j6i9MFgmJgf6hFEI3st997YaZk1vIBeU1i1TFN+ZqFJhsnY07ULSE2FWA3Ox/wjoFASIFvfHNIdwhBerkizKK3Z+Tco4PqRdMAR/uFzl0GWd16a/1YyqYHBTtWkMTFbVd23oXCHxoC/b3h/AhfvO5TmuBup61nVCfaulW/dMepfFI2nDM9fsvrB43KqmzLbienIlCtlcF3mDGPDUBzfWO8S+O509vHLTHJMNFersFXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f2p4j0u8NIv0kyafXkZ/owlZxowI1plVrgrRk+h6PjE=;
 b=mBqSuQeXBjrBbxyOmRQn2MzSS3EWxGNy53xbU64zajPxnBxfySzS6bvcIYOutxknQNuA3TEhjhoN3+PnL2GUFkgB04+53G4UlWdKABK8Pm5DgIrKn1gyhuCMQuZL4ysaGzcInZYHdK4+/uHIEZNPuLy72T/w+y8oR/mx3TenT3s=
Received: from OS3PR01MB9499.jpnprd01.prod.outlook.com (2603:1096:604:1c8::5)
 by TYAPR01MB3087.jpnprd01.prod.outlook.com (2603:1096:404:89::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.12; Tue, 19 Jul
 2022 02:22:35 +0000
Received: from OS3PR01MB9499.jpnprd01.prod.outlook.com
 ([fe80::6839:1c9:b26b:1419]) by OS3PR01MB9499.jpnprd01.prod.outlook.com
 ([fe80::6839:1c9:b26b:1419%3]) with mapi id 15.20.5438.023; Tue, 19 Jul 2022
 02:22:35 +0000
From:   "yangx.jy@fujitsu.com" <yangx.jy@fujitsu.com>
To:     Leon Romanovsky <leon@kernel.org>
CC:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "jgg@ziepe.ca" <jgg@ziepe.ca>,
        "rpearsonhpe@gmail.com" <rpearsonhpe@gmail.com>,
        "zyjzyj2000@gmail.com" <zyjzyj2000@gmail.com>,
        "lizhijian@fujitsu.com" <lizhijian@fujitsu.com>
Subject: Re: [RESEND PATCH] RDMA/rxe: Remove unused qp parameter
Thread-Topic: [RESEND PATCH] RDMA/rxe: Remove unused qp parameter
Thread-Index: AQHYkn6c+nf9xkj1KUiqbqr8TyUl7K2D2ywAgAAI8ACAADdCAIAA7HOA
Date:   Tue, 19 Jul 2022 02:22:35 +0000
Message-ID: <3085f614-a64b-84d7-6d1d-9bbc0c4b71f1@fujitsu.com>
References: <20220708035547.6592-1-yangx.jy@fujitsu.com>
 <YtUZNruUx4jjrNhW@unreal> <4bca5022-2db6-b788-9a88-0615d6ea9e97@fujitsu.com>
 <YtVPEFHs5VaLe+mY@unreal>
In-Reply-To: <YtVPEFHs5VaLe+mY@unreal>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4ac731cd-bccd-4097-04f2-08da692d8b58
x-ms-traffictypediagnostic: TYAPR01MB3087:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 5As4UgsF1DaDAiMmXVJs1uPTiqdEoNj3cbR3mgh1tQU5q38XOxU7I8+c4VFQ3puIzWvnHJq2VQjJVqNeqEgVZx58TnfIdHPzcsO/pDIE8++p2Osd+qVTqGyVt5RBlY05LB7Ml7MzfnmMjqgTHQ8GNHZL4p6ZsS3tvZSoOV3EJeqty+MBGn3W2pWUiwZsTniPa2VHVC8wYGY1UznmccyLpD8a+CKgaL2FbGvxmDRJmEd5R+buNwLdfDN7dSMPiVmLa7VPxlbSCjW6y3yGxT8KCR6fSgo0DCFWaRCszGCZ4EaFDvxN9ECt/c7CGzY28wKFvpq+ik/4ecsGCjfWzgUs3X+uT5oASAr0NZf5/Qb5S9zarJEboiPAPh+pzYb/t0VIgDbit9uBuHiAUhSaikeHfJJkLVOAXE7x5vd9Clqk4XWD2uaYDdWcUYKExuELPRhTZqrTI8zh9CleM3VBLDXZCYTX5S/Aq1sboHQGSfSQ9TReg95m2+VMaS8TnBRNW95joacD0h1PI6yViIcpPVxDZfMmwsmge7wbUMftGjvvMdaDIPsrr8n3OB2TextfWjnNP7Oaa+pb2zigNlzQ04dPILdGsIO0dtvzw8hrmVonE/i7JYnC0Fvhojo9z6SPQSdTKCJ//A6XUPocwDLZx5RKugVKE68yBYrs/9+N1Sd+vyczkiYMGz0HtFRsyb2kw1Celj+z0AynV7cG5GBGCjBYTLIEfIyRpveJDHmidlRW+VzErUSY2X/D0t1bZwpSGje86UO+ysbXUbsrJ6r9ufIisLxC60cJcYDvi7N5ISmE9sbj339nLhKZsDabr4EVcwlRHnQiAZOg7Yh4CMQxDG+pmYQFWnHxNHQND+8Gh4YRIAQ2jav/F0sxChKK04ZdRmcb6eATmjEoxwk03HTkHdJyAb6pnDwLNgb59NAcqoD82l8=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS3PR01MB9499.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(136003)(39860400002)(396003)(346002)(376002)(366004)(2616005)(6512007)(86362001)(6486002)(31696002)(6506007)(8936002)(122000001)(5660300002)(41300700001)(53546011)(2906002)(26005)(71200400001)(107886003)(38100700002)(82960400001)(4744005)(38070700005)(478600001)(64756008)(186003)(966005)(66446008)(36756003)(76116006)(66946007)(31686004)(8676002)(66556008)(6916009)(85182001)(54906003)(91956017)(4326008)(316002)(66476007)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?V1BnaFd1S3E4M2pvdkJmRmNaZ2xOalVQd3Rpa0lVNVdUck1RNUpldjZuUE5R?=
 =?utf-8?B?RVlTTjAydVZFTVpsbHlCUlYxNGNySXpSUjlaZUkrK1BzMXlkeEdFU2JQR2NQ?=
 =?utf-8?B?VVdlOGNxWXhPYmcxbTl0MWNKaVQwR2k4dDBLa1NqU3dLR2NIZlkrckx2NmVF?=
 =?utf-8?B?cHVPR1QxN21XeHp1N0lNTks3NW5CM3hkcXpPc1dlZ1huUDBNTnJWdjZzWnRn?=
 =?utf-8?B?WUFRc1AxcTVnekhPaTVCaFFDRmtyNEVxeDBFZnFOZ3hSMUlvQzE0VXIzRURn?=
 =?utf-8?B?QXMxRkFyMVg1OVFraUI1dk1HV0dtWnBZOGdROFltQyt2VVhjdGtNN2NKc1Vh?=
 =?utf-8?B?a1B6Tk5Va054UG5Ib21pblZNUU9lcy9BT05WN3VkNUxWL1BYTFRoMzh4aWxy?=
 =?utf-8?B?dGRaT01zRXkvbHU4N3AwQjJERVc5cEZhbkl2TUJNTHF6RnI5dFVQZjNlZER0?=
 =?utf-8?B?TWxXa1hsVVNTMFc1UjdhZlZBRUhPTUtqbnRBZjk4bDUrTFBTeDVpYjRrYXRY?=
 =?utf-8?B?Sm0yWm5BOUxqL2tteklXTnZ0aHJUZGpTK0MxM0NWbnluMXdBMnVCeEZGdW5T?=
 =?utf-8?B?VzNMZnZLcjNPTkJFSjQyakttalVtZk9hK01uOFFyTGFxSm5yZ1lnK1UveGlN?=
 =?utf-8?B?TkUzWW5HMitoU00zYnc4ZUxLVnQxeS9KMVdwMWkwd1pZUHV3cmlBVEh2cFQz?=
 =?utf-8?B?RzhEZkYxNldRUDJKd0FOQjB5eU5FRmNrWStpcUhiT3REaU5uZmsyZjFXUlk5?=
 =?utf-8?B?UFBrRDBxR3p3b0ZsbjZMdVhxVzY1Ky8rZm5qbmN2S3R4T3hRamYrTmM3QWlV?=
 =?utf-8?B?dGRjb1I3dEV5U2QvM0Q0M2FQaXZvYlVBUENKQSt5K29RV09rcmlLRVp3Vzgy?=
 =?utf-8?B?Q1lTREp5VUhVTFNQazBqNmJBaXZkZ2NwOHVkQVRzZFJuY1VaM0IxOU8wUDI3?=
 =?utf-8?B?eXVFMEpFbXI0cWRndVY3RUM2UGZRNm1NdlIvWUdOVHZtOWpEa00zc1QxLzlu?=
 =?utf-8?B?WW9pam84NG9qNjJwb3paY2JIeXpjRlpEbzV2NHVUS2FVTmxvUDdFS2JNS25l?=
 =?utf-8?B?UXhDYlNOd2UwM0NuYXB1Y2JpQkN2WTl0OGNlWGdvT0xlei9Ua2Z6K2JoUGhR?=
 =?utf-8?B?QUU3d2JNNDJESWNTR2xmMEVxbmxPd0lXdk4vNDBQN3BIZkZWWDJLMWQrVnFo?=
 =?utf-8?B?bGJoaWFDRklRMGNkRWJrbVJtNlVsSEVsSVBEWDRqNkJCOVhRcmJybWdLV2lr?=
 =?utf-8?B?Y0xYUWIySkNmbXNoeG9kOWhUSTRGRUZ4MWdsQnc2SlNiSUhlYlBtSFVWYjdu?=
 =?utf-8?B?OWFwZ2ZyMTEvWU5YZ3FyNmFwT2o2djdqbVRLMEQ5Qmh1UDZqK1QydkNZQTQz?=
 =?utf-8?B?K1V0NEkyeG5hRStEOUxiQ3czUFVtRlY1cVhmVHJ2SjBtZ2lMNUZMcVBOR2k5?=
 =?utf-8?B?c3QrbGx2amwyV3ZkUXh0bW04SFFmUEdqeS9tVnRaM1ZUWG8vSEZZYitFNFJq?=
 =?utf-8?B?UURPVVlZNlB0SHp5Y21ZSjV2Y1k1NzF2cTI0Qlg4NEZWamZTQ3h0UEdGekdM?=
 =?utf-8?B?c1U2RUZoWXdHVEpkT3FEK2NTUXhqaWhBa0dSREdJYmdIMm9odWhNRDFEVTRz?=
 =?utf-8?B?NitWZlFaSHFzU2RXZ1NKYUZiL3pWNXBWa2hSelJuOC9SazlZL0d4U1hOc0Zv?=
 =?utf-8?B?eHlmUEdtdVpjSVI4Q2NmUURWRFBQODA1eGNpbW9qS1hQWnlIdzNidVlzSVRU?=
 =?utf-8?B?eWtzajZxR0dmREFEbTZaaDZIZElVb2NMdnVUZVE5T1ZSRkd6ZkdQbmFSVjM5?=
 =?utf-8?B?Qy9hQ2dmN0x1bnNKdGEwY0FIYzB2YXNCb0ZFMUlrTDcvaWpobzB3KzNpcklO?=
 =?utf-8?B?S3A1dnlYR2pKMEN4TmJHamsvMzY2V1kwa2pNM3BrREFDYllGYzkyZVQzWVdq?=
 =?utf-8?B?YnY2VzJ3T2VUbzV0OTM5RXFMTVByV1RHUE5YdmJpTGI5SStKeXludTJ0QWp4?=
 =?utf-8?B?Z2pxdDBqdlo3VEljUmRSczlqVzlxSVc0SEJZME90bGpRRkdjNk1IT3R4S3Fj?=
 =?utf-8?B?Y2d0Tnd5NGltT0l1bzF0cHJKRVh5ZXBaeGdsVEdKTlZkTjB4K2lGK3JIalZv?=
 =?utf-8?B?UWlqWFVoM1IwdEljTWdienVqWktsOE9SY05uVk9XbzVLbGdyVG1zbDZORlBa?=
 =?utf-8?B?QWc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <4BB7FFED52155B419F4210535F3C3A10@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS3PR01MB9499.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ac731cd-bccd-4097-04f2-08da692d8b58
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jul 2022 02:22:35.8124
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: k53WVIAaStzTE4IyOzcXu7+UzMIy88Vh/6ZX//Ry+0I1JqDGYWHvzQP6BiSkdnloRevhJc5v157lj2W3MqHysg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYAPR01MB3087
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

T24gMjAyMi83LzE4IDIwOjE2LCBMZW9uIFJvbWFub3Zza3kgd3JvdGU6DQo+IFBsZWFzZSwgdHJ5
IHRvIGFwcGx5IHRoZSBwYXRjaCB0byB3aXAvbGVvbi1mb3ItbmV4dCBicmFuY2guDQo+IA0KPiBU
aGFua3MNCg0KSGkgTGVvbiwNCg0KSXQncyBPSyB0byBhcHBseSBpdCB0byB3aXAvbGVvbi1mb3It
bmV4dCBicmFuY2ggb24gbXkgZW52aXJvbm1lbnQuICBEaWQgDQpJIG1pc3Mgc29tZXRoaW5nPw0K
DQojIGdpdCBwdWxsIHJkbWEgd2lwL2xlb24tZm9yLW5leHQNCiBGcm9tIGh0dHBzOi8vZ2l0Lmtl
cm5lbC5vcmcvcHViL3NjbS9saW51eC9rZXJuZWwvZ2l0L3JkbWEvcmRtYQ0KICAqIGJyYW5jaCAg
ICAgICAgICAgICAgICAgICAgICB3aXAvbGVvbi1mb3ItbmV4dCAtPiBGRVRDSF9IRUFEDQpBbHJl
YWR5IHVwIHRvIGRhdGUuDQojIGdpdCBhbSAwMDAxLVJETUEtcnhlLVJlbW92ZS11bnVzZWQtcXAt
cGFyYW1ldGVyLnBhdGNoDQpBcHBseWluZzogUkRNQS9yeGU6IFJlbW92ZSB1bnVzZWQgcXAgcGFy
YW1ldGVyDQoNCkJlc3QgUmVnYXJkcywNClhpYW8gWWFuZw==
