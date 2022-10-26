Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABE8B60DBD8
	for <lists+linux-rdma@lfdr.de>; Wed, 26 Oct 2022 09:07:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231597AbiJZHHS (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 26 Oct 2022 03:07:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229904AbiJZHHR (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 26 Oct 2022 03:07:17 -0400
Received: from esa15.fujitsucc.c3s2.iphmx.com (esa15.fujitsucc.c3s2.iphmx.com [68.232.156.107])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AF8192588
        for <linux-rdma@vger.kernel.org>; Wed, 26 Oct 2022 00:07:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1666768036; x=1698304036;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=BveAaBNKUQ0QS1yC1Wut4nJ+EH9Ja8GEUHqNsa05JRA=;
  b=B7epghbrEwxuO8nO6q8/1Jz2ln1rD0c2ykd97IiKdppHYCKYSlxJKD6M
   a6iU8F+v9SvogVZDUSvEVHnNMpKeyQivVNyVvPiDoTeiyPyhjqwRksYhQ
   hvMH2o3ldrwEdW5AxHREybmM3jm31E5gn+0+yybjrvIIV04VJ9qIK6lmv
   c88c4l5ehcz7EHSRFEzNqTDzFd+fkuKdRnsHHCEs4AHjvRriyLenPuCgb
   vZaaBNTZd9p7GpVJtsmJdGxvlfh8UOsCzwnqYyqfFEoK5IO3/Me2Q8ufv
   nRU8TyqNNJ2qR/BFcYDL+kZIoGagu74L2NXeIKKYz0GLXqKU3jYdX1cv4
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10511"; a="68427239"
X-IronPort-AV: E=Sophos;i="5.95,213,1661785200"; 
   d="scan'208";a="68427239"
Received: from mail-os0jpn01lp2112.outbound.protection.outlook.com (HELO JPN01-OS0-obe.outbound.protection.outlook.com) ([104.47.23.112])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2022 16:07:12 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NZBm2N8f/4ca6TjlEhCt6KFnIvWYLNHB/2IrtOIFB/4JX+Qxu5xOb5OIGBe95wwgIpUSR9CiluRspHBWRTUalPMLomB2mInV5Nx2YMpS33VmR/X+Dxb5q/oj5A7R1v2WSwGMefV7g88Yfj+aZWScaNCCQBElUzMnJ2NGouLACSkTU2Z0TPvvsJyn+iJ8VsRXJgFP1NfyiZUL3YdCM9L7OLYaSHVTiChZ/0hZFEb209LIGfVamohgS3eTpE67qEeRXmkw589/I4J3Gd/IOz9onusU6OJq0+69lRC5nDv6kWzIDWSFiUPd7EQuhOwwRNd+oSXsimRhpHwL69kJaQdb8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BveAaBNKUQ0QS1yC1Wut4nJ+EH9Ja8GEUHqNsa05JRA=;
 b=l7NymcKBRSNkFoNG1D1+gL7GL+U6aRzzahVIYcpCX0e82xJioJSIowuxtYU9Lx/YSVp5NA1mJGK1UlXL6jMYOGGRUDy1cq4n+mU/0eUlWAH9p3fkMVVgQeU2kRd2fuH7lo3dhA6E4JKybbyy3sZUYuy3NrrzNy4vE9sn9f+eYaWZ0xBFOIYU5iErw8Ml3x2t/iXgq1tfhXJ2f0JyDfg/FAgC9qE33lMGhFlwYmV+FnoBp66idqg4xheMD6LMh9fCWOurXOuBhHOnpTftb45Yli5pCsXVX9QQUdHGL4JPnQeWuzBJGvSSxznjZXt06UjiBFHmtO3b2Mk8AI+qdL2+eg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from TYCPR01MB8455.jpnprd01.prod.outlook.com (2603:1096:400:15d::13)
 by OSZPR01MB8403.jpnprd01.prod.outlook.com (2603:1096:604:188::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.23; Wed, 26 Oct
 2022 07:07:09 +0000
Received: from TYCPR01MB8455.jpnprd01.prod.outlook.com
 ([fe80::8f33:6006:986f:f575]) by TYCPR01MB8455.jpnprd01.prod.outlook.com
 ([fe80::8f33:6006:986f:f575%4]) with mapi id 15.20.5746.028; Wed, 26 Oct 2022
 07:07:09 +0000
From:   "Daisuke Matsuda (Fujitsu)" <matsuda-daisuke@fujitsu.com>
To:     'Bob Pearson' <rpearsonhpe@gmail.com>,
        "jgg@nvidia.com" <jgg@nvidia.com>,
        "zyjzyj2000@gmail.com" <zyjzyj2000@gmail.com>,
        "leon@kernel.org" <leon@kernel.org>,
        "jhack@hpe.com" <jhack@hpe.com>,
        "ian.ziemba@hpe.com" <ian.ziemba@hpe.com>,
        "lizhijian@fujitsu.com" <lizhijian@fujitsu.com>,
        "haris.phnx@gmail.com" <haris.phnx@gmail.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: RE: [PATCH for-next v2 18/18] RDMA/rxe: Add parameters to control
 task type
Thread-Topic: [PATCH for-next v2 18/18] RDMA/rxe: Add parameters to control
 task type
Thread-Index: AQHY5YgNqNdLkzYLLEWeMcJdmiJURK4e0tUAgABkKICAAOddkA==
Date:   Wed, 26 Oct 2022 07:07:08 +0000
Message-ID: <TYCPR01MB8455EC852AD26271D0CF130FE5309@TYCPR01MB8455.jpnprd01.prod.outlook.com>
References: <20221021200118.2163-1-rpearsonhpe@gmail.com>
 <20221021200118.2163-19-rpearsonhpe@gmail.com>
 <TYCPR01MB845563BB1E56CFB317D4409BE5319@TYCPR01MB8455.jpnprd01.prod.outlook.com>
 <33654e21-1693-cbee-6dd1-bca690547c33@gmail.com>
In-Reply-To: <33654e21-1693-cbee-6dd1-bca690547c33@gmail.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-securitypolicycheck: OK by SHieldMailChecker v2.5.2
x-shieldmailcheckerpolicyversion: FJ-ISEC-20170217
x-shieldmailcheckermailid: 4ed581535dee4c0ca74a590545cbeb24
msip_labels: =?utf-8?B?TVNJUF9MYWJlbF9hNzI5NWNjMS1kMjc5LTQyYWMtYWI0ZC0zYjBmNGZlY2Uw?=
 =?utf-8?B?NTBfRW5hYmxlZD10cnVlOyBNU0lQX0xhYmVsX2E3Mjk1Y2MxLWQyNzktNDJh?=
 =?utf-8?B?Yy1hYjRkLTNiMGY0ZmVjZTA1MF9TZXREYXRlPTIwMjItMTAtMjZUMDc6MDc6?=
 =?utf-8?B?MDdaOyBNU0lQX0xhYmVsX2E3Mjk1Y2MxLWQyNzktNDJhYy1hYjRkLTNiMGY0?=
 =?utf-8?B?ZmVjZTA1MF9NZXRob2Q9U3RhbmRhcmQ7IE1TSVBfTGFiZWxfYTcyOTVjYzEt?=
 =?utf-8?B?ZDI3OS00MmFjLWFiNGQtM2IwZjRmZWNlMDUwX05hbWU9RlVKSVRTVS1SRVNU?=
 =?utf-8?B?UklDVEVE4oCLOyBNU0lQX0xhYmVsX2E3Mjk1Y2MxLWQyNzktNDJhYy1hYjRk?=
 =?utf-8?B?LTNiMGY0ZmVjZTA1MF9TaXRlSWQ9YTE5ZjEyMWQtODFlMS00ODU4LWE5ZDgt?=
 =?utf-8?B?NzM2ZTI2N2ZkNGM3OyBNU0lQX0xhYmVsX2E3Mjk1Y2MxLWQyNzktNDJhYy1h?=
 =?utf-8?B?YjRkLTNiMGY0ZmVjZTA1MF9BY3Rpb25JZD04YWUxZDA1My04NDdhLTQ4OWUt?=
 =?utf-8?B?ODQ5NC03ODUxYzVhZjY5YzM7IE1TSVBfTGFiZWxfYTcyOTVjYzEtZDI3OS00?=
 =?utf-8?B?MmFjLWFiNGQtM2IwZjRmZWNlMDUwX0NvbnRlbnRCaXRzPTA=?=
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYCPR01MB8455:EE_|OSZPR01MB8403:EE_
x-ms-office365-filtering-correlation-id: 3740ae7c-769b-4536-a469-08dab720b29d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: //6KcGxqfNYzuG8NyxzeJpjCrco+Y0y5M41L2HZO0KqbepOdHeq52kNCZ/kXSwjfo55r8IgZU9EzTIitegR/XLw5pxJ1xxv6YNEicDEkzRNOShwKS8bMBKwBgwnt/V+d6IGmnNfoCp474e8D1sDbBuYZ1OiDvvZ8I+KjBpuCw4NajgxPKMheRT3QZ4Zl9a6oNRe8aR/dHIFVY8kyEVbe2ReXMjD78bgnTH1dcTgpR++MukC54akCSac6bohqqiPrgqagJ6VUgQ8VJHjVPturxPpvnc80JGfX0Gu4bot9McXdQbQtBvzn1DJB9UT08k7YLE7gEXQpMzmEVmqxKYzI8yXHFKxTN4zAUczSUNyd6DN6DwkfLh5SmwGSI13VJJl6Noms97uIyihwDkaT77GPEBZKtuyZr1NIA3wjT9oOrwJxC6LmuRMB9Kqh9f8o4X0IIDUURh8QcNeVtlKyPBX1cxZyB4AgoeStqzDtTG92UV+Pvffn404Wx2iSJnxefSzjbACyqvNXov66EID5Hnh6e0gRY55PTjg0bWLRT+NCzOvSckccz6xNAtY7yxsj9EJGOmn9iJIet5hs14YCdcYcx2fAY8pt6PodWhTy04ryf2GYpEHqoCja9fyYymKDYPHgCq737rxPk5dyktJWyt6JjBM6tBHpTjjqCyJCypJYpJ7SkcF9cEYHi/HaVi0Ei4WMFYq2xXU+Mffzy5HYdsGlmMKphgVtz2o6pqD5arA9s2atm+/L8FjM2dWofzXCg5LIik9hFbc1V2PRCPPflA1qvhgzpMo1c6cuS6HggLOfOF5rbcDDEEpeVoLcclO5KMzh
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB8455.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(39860400002)(346002)(366004)(136003)(376002)(1590799012)(451199015)(71200400001)(86362001)(83380400001)(1580799009)(478600001)(110136005)(64756008)(53546011)(66446008)(66556008)(8676002)(66476007)(85182001)(7696005)(66946007)(6506007)(9686003)(52536014)(41300700001)(26005)(76116006)(8936002)(5660300002)(33656002)(38100700002)(122000001)(2906002)(55016003)(186003)(921005)(38070700005)(82960400001)(316002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TzJHK2YwazFxSnh2Y2tsbkFCNjI3WUVPWjNGbllRZmdxdnI1Vy8zL05JUXFF?=
 =?utf-8?B?QzJzdmhFV0xhZ3BCRmtIMUVWaGVwbDFKakJzN3RDNkVDNzMwWEFWWEt1U3Rw?=
 =?utf-8?B?Vm1vYnRqMzNMampnclFxaWoxMlJxZ015Qkg1T0Ira1FjVHQ5VktzeHF2NHhS?=
 =?utf-8?B?ZFhBbVZzdVdRZlFjMEV0MUlINWt5UVlCZFZHTVE4SDJxVDFNN1VlalorY1lY?=
 =?utf-8?B?anZWUjNUdTkrSk4vMjRnc0Yyc2NpdEJ5R1FhREdjMFRVd3RRQXIvbTROK25V?=
 =?utf-8?B?Umc4NFlqOTZ6c0FCMS9OYXdhQUxSVDVLNk16OE4xajJMZE05OXZMVEh4emlh?=
 =?utf-8?B?SU5iOThRMTQzenREejBhcGlVdU4rTllET05xSXNIZEd2aHhLeEdDYWZ4S1I5?=
 =?utf-8?B?cUwwVDhnZFp6VkVaaTlGWlNpd08vNExKblZPcEV6Mnp4N1lnc2hxcklqSmRv?=
 =?utf-8?B?b2I1cjZsYlU1cnFoZkVLWWtxMzlZNGgrWjd4WTJCWHBPWXAxaml2ckJPNUJJ?=
 =?utf-8?B?b1NKbHdOOFFSQWhJcjdPS2syUkVRTE42U3JpTkVFQy8rcEJ0RkFkUHBNS2Fo?=
 =?utf-8?B?TTlnM1ZraHF4UGR6RW1hR1R6ZGlBeWZuQ2NFbzhFTmRXMG04MmJwMzZnSlZj?=
 =?utf-8?B?dU1MVDRQV1IxelZVQi9lSVdmUjJEY011TXJYMmRnY1paaThKQWVUOExDUXFs?=
 =?utf-8?B?TUhyS2IyS2UrTDI2UmY4bVVIYUJrMFU1V1Nia2d4dklxVGhaQ09ySHdYalkx?=
 =?utf-8?B?S3dYRisyb2wxV0NaRmVUS2xrNzdwSVduMHUxUDdHQy80ZzIwNGR1UGpzQmlP?=
 =?utf-8?B?QjFsTWN5QllUeGd2OGtHa0xoL1JKWENCR2VaczVlcndPU2ZGREJMV2hrU1Y5?=
 =?utf-8?B?NUZ0UDNjRTIyRVMxQ2U0Wjh6blBhOFFzTFZyUGdiSC9icE5mczlmMVlBS3Vp?=
 =?utf-8?B?dEIwSUFrYUdyWUZDOE5rSnJEVVl0TTVOajVWcTE1QXNwRHNQdG9XaGRmTzQ3?=
 =?utf-8?B?NStlSkdMbmJiYmxKd0cvM3NiSldmRUJqRGNsVGVPNUdqSjRrWjFNaVErb1pP?=
 =?utf-8?B?WHJ6eDA0R25xVWgxNnhNKzcrWWRzSGhWTW1ScFduZ3FUMS9JZ1VwU0NSUmVs?=
 =?utf-8?B?MzRBbm01SVVSemFkcjVId0xZeTlBaFhxUFJpTTQvRTJQbnBzTGc2WkNCMGYy?=
 =?utf-8?B?bHBBanVnUkh1MTViRmFjUjhjT3E0T2VSakY0Q0dodGUrek9lSHhIYjRMMXIy?=
 =?utf-8?B?a1lOZjE4LzhjWFJSbTVCTmJUTnJNRGdwcmpVSXFhcFh6WFBJYk1Fdmk3c1Yw?=
 =?utf-8?B?SGZZeDdTeElFU1gzQ2VQZzgvQ2xRcXVUU1lnN0ZFU0oyemZMMzlwQTZPRzVQ?=
 =?utf-8?B?RURWYjNZTVA5TmpvZTNMRUE5V0dPZ0JodXQvc2Z1YUZBVks2MWlKOG1WOGph?=
 =?utf-8?B?VHc5QWkwV1Nmb1B1M0NBSDI2V1dBbjE4ZENEQVU3c1VlN2tyUmdwRjVPcnNX?=
 =?utf-8?B?dmh6N2x0R2d0dWpRNUFYODAwUkxod2tQZjc2ak9LMHJjT3ZuOFpRMDl1aEhL?=
 =?utf-8?B?K0xabXJ2cERVQWliMFdyVUxsTDlIU1JLTmZid0UwSXQvY00rKzFxRFQ5UTcw?=
 =?utf-8?B?WnVxNFhUL0hwaE1GZG9oMkEyR3lqbW5xU1lGK3N1UG95S3dpOTg0M3FpSUJq?=
 =?utf-8?B?aGhNQUhzTEZYVzg3STJJMWovWnNmZjFvUk94SjFrc2tEblIzWWlpTU81cDdD?=
 =?utf-8?B?Ly82dDFFOTVnbnIzODREb0NENU1VeXJrMjM3ZUF6YWpmQzNudVdrM3BTK0wv?=
 =?utf-8?B?RHNDUmtiUHlnTEFheC9kQ0tJcWNhdzhJTGxWQi9mUm5HRkRRZVpqRnRwSmRO?=
 =?utf-8?B?WE9MYy9EWFFieGJZaWdSd09KVmJKL3RWSlVLK2NoU3ZOMTRuSnhkTWtSbzNq?=
 =?utf-8?B?bFFIVmRlYlJGRzgvQUJyRzNlV1MvcldGYWM3b2toTkVhYlVOR1FLdTgvbjlz?=
 =?utf-8?B?NnFhb3N6SUFmV3ZWV2xRTVlOemlJVEpwR0wzdys5SjA0bjh0TU5IWmZQVVU1?=
 =?utf-8?B?QVhCSzgvTThlVmp3ZWRJOHZlRTFGZnVlS2Z0elFJaXRJaUZsdGZJcFB1VU1Y?=
 =?utf-8?B?dTVFWW5MeDRCcCtnSStWTUJralY0bDZwT2FwK3lzc2lMbEtDUmlCMHZwaXly?=
 =?utf-8?B?ZkE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB8455.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3740ae7c-769b-4536-a469-08dab720b29d
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Oct 2022 07:07:08.9233
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: S6JfJu5lvEZEm8yeh5m7FxptCxnLiCCEnZlQCmPLpxAnPSdyUmwK5z40bYxy+rGNYptR2f0MUvoi+2F+pDU8QfxTMhLztrj/iis4wKKrpcc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSZPR01MB8403
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

T24gVHVlLCBPY3QgMjUsIDIwMjIgMTE6NTAgUE0gQm9iIFBlYXJzb24gd3JvdGU6DQo+IE9uIDEw
LzI1LzIyIDA0OjM1LCBEYWlzdWtlIE1hdHN1ZGEgKEZ1aml0c3UpIHdyb3RlOg0KPiA+IE9uIFNh
dCwgT2N0IDIyLCAyMDIyIDU6MDEgQU0gQm9iIFBlYXJzb246DQo+ID4+DQoNCjwuLi4+DQoNCj4g
Pj4gKw0KPiA+PiArbW9kdWxlX3BhcmFtX25hbWVkKHJlcV90YXNrX3R5cGUsIHJ4ZV9yZXFfdGFz
a190eXBlLCBpbnQsIDA2NjQpOw0KPiA+PiArbW9kdWxlX3BhcmFtX25hbWVkKGNvbXBfdGFza190
eXBlLCByeGVfY29tcF90YXNrX3R5cGUsIGludCwgMDY2NCk7DQo+ID4+ICttb2R1bGVfcGFyYW1f
bmFtZWQocmVzcF90YXNrX3R5cGUsIHJ4ZV9yZXNwX3Rhc2tfdHlwZSwgaW50LCAwNjY0KTsNCj4g
Pg0KPiA+IEFzIEkgaGF2ZSBjb21tZW50ZWQgdG8gdGhlIDd0aCBwYXRjaCwgdXNlcnMgd291bGQg
bm90IGJlbmVmaXQgZnJvbQ0KPiA+IHNwZWNpZnlpbmcgdGhlICdpbmxpbmUnIHR5cGUgZGlyZWN0
bHkuIEl0IGlzIE9LIHRvIGhhdmUgdGhlIG1vZGUgaW50ZXJuYWxseQ0KPiA+IHRvIGtlZXAgdGhl
IHNvdXJjZSBjb2RlIHNpbXBsZSwgYnV0IFJYRV9UQVNLX1RZUEVfSU5MSU5FIHNob3VsZA0KPiA+
IG5vdCBiZSBleHBvc2VkIHRvIHVzZXJzLg0KPiA+DQo+ID4gSSBzdWdnZXN0IHRoYXQgdGhlc2Ug
bW9kdWxlIHBhcmFtZXRlcnMgYmUgYm9vbCB0eXBlIGFuZCB0YXNrIHR5cGVzDQo+ID4gYmUgbGlr
ZSB0aGlzOg0KPiA+ID09PSByeGVfdGFzay5oPT09DQo+ID4gZW51bSByeGVfdGFza190eXBlIHsN
Cj4gPiAgICAgICAgIFJYRV9UQVNLX1RZUEVfV09SS1FVRVVFID0gMCwNCj4gPiAgICAgICAgIFJY
RV9UQVNLX1RZUEVfVEFTS0xFVCAgID0gMSwNCj4gPiAgICAgICAgIFJYRV9UQVNLX1RZUEVfSU5M
SU5FICAgID0gMiwNCj4gPiB9Ow0KPiA+ID09PT09PT09PT09PT0NCj4gPiBJbiB0aGlzIGNhc2Us
IHdoaWxlIHdlIGNhbiBwcmVzZXJ2ZSB0aGUgJ2lubGluZScgdHlwZSBpbnRlcm5hbGx5LA0KPiA+
IHdlIGNhbiBwcm9oaWJpdCB1c2VycyBmcm9tIHNwZWNpZnlpbmcgYW55IHZhbHVlIG90aGVyIHRo
YW4NCj4gPiAnd29ya3F1ZXVlJyBvciAndGFza2xldCc7IG1vZHByb2JlIGZhaWxzIGlmIG5vbi1i
b29sZWFuIHZhbHVlcw0KPiA+IGFyZSBwYXNzZWQuDQo+IA0KPiBJIGRvbid0IGtub3cgaWYgeW91
IGhhdmUgbm90aWNlZCB0aGlzIGJ1dCB0aGUgdGFza3MgdGhhdCBoYW5kbGUgaW5jb21pbmcgcGFj
a2V0cw0KPiBhbHJlYWR5IHByb2Nlc3MgdGhlbSBpbmxpbmUgaWYgdGhlIHF1ZXVlcyBhcmUgZW1w
dHkgd2hpY2ggaXMgbW9zdCBvZiB0aGUgdGltZS4NCj4gVGhlIGRpZmZlcmVuY2UgYmV0d2VlbiB0
aGlzIGFuZCBpbmxpbmUgYWx3YXlzIGlzIG5vdCBtYWpvci4gVGhlIE5BUEkgdGhyZWFkIGlzDQo+
IGFscmVhZHkgZGVmZXJyZWQgb25jZSBzbyB3ZSdyZSBub3QgcnVubmluZyBhdCBodyBpbnRlcnJ1
cHQgbGV2ZWwuDQoNCkkga25vdyByeGVfcmVzcF9xdWV1ZV9wa3QoKSBhbmQgcnhlX2NvbXBfcXVl
dWVfcGt0KCkgdXN1YWxseSBjYWxsIHRoZSBwcm9jZWR1cmVzDQpkaXJlY3RseS4gVGhhdCBtYWRl
IG1lIHdvbmRlciB3aHkgd2UgbmVlZCB0aGUgYWRkaXRpb25hbCB0eXBlIGZvciB1c2VycyB3aGVu
DQp0aGVyZSBhcmUgdmlydHVhbGx5IG5vIGRpZmZlcmVuY2UgYWZ0ZXIgYWxsLiBJIG5vdyB1bmRl
cnN0YW5kIGhvdyB5b3UgdXNlIHRoaXMgbW9kZSBmb3INCkhQQywgYnV0IEkgYW0gbm90IHN1cmUg
d2Ugc2hvdWxkIGFkZCB0aGlzIG5ldyB0eXBlIGZvciB0aGUgdmVyeSBzcGVjaWZpYyBwdXJwb3Nl
Lg0KDQo+IA0KPiBXaGF0IHlvdSBzYXkgbWFrZXMgc2Vuc2UgaW4gYSBtdWx0aS11c2VyIGVudmly
b25tZW50IGJ1dCB0aGF0IGlzIG5vdCBhbHdheXMgdGhlIGNhc2UuDQo+IEhQQyBqb2JzIHR5cGlj
YWxseSBoYXZlIHRoZSBub2RlIGRlZGljYXRlZCB0byBhIHNpbmdsZSB1c2VyIGFuZCBpdCBzZWVt
cyBiZXN0IHRvIGxldA0KPiB0aGVtIGZpZ3VyZSBvdXQgd2hhdCB3b3JrcyBiZXN0LiBJbiBhbnkg
Y2FzZSBpdCB0YWtlcyByb290IHRvIG1ha2UgdGhpcyBjaGFuZ2UuDQoNClRoaXMgc291bmRzIGNv
cnJlY3QsIGJ1dCBpdCBzZWVtcyB3ZSBjYW5ub3QgZGVsdmUgaW50byB0aGlzIGlzc3VlIGZ1cnRo
ZXIgdW50aWwgdGhlDQpkaXNjdXNzaW9uIG9mIHdoZXRoZXIgdG8gZWxpbWluYXRlIHRoZSB0YXNr
bGV0cyBvciBub3Qgc2V0dGxlcy4gSWYgdGhlIHRhc2tsZXRzIHdpbGwgYmUNCnJlbW92ZWQsIHRo
ZW4gSSB0aGluayB3ZSBzaG91bGQgZ2l2ZSB1cCB0aGUgaW5saW5lIHR5cGUgYWxvbmcgd2l0aCB0
aGUgbW9kdWxlDQpwYXJhbWV0ZXJzIGluIG9yZGVyIHRvIGtlZXAgdGhlIHRoaW5ncyBzaW1wbGUs
IHdoaWNoIGlzIG11Y2ggbW9yZSBmcmllbmRseSB0bw0Kb3JkaW5hcnkgZW5kLXVzZXJzLg0KDQpU
aGFua3MsDQpEYWlzdWtlDQoNCj4gDQo+IEJvYg0KPiA+DQo+ID4gSWYgeW91IHN0aWxsIHdhbnQg
dG8ga2VlcCB0aGUgcGFyYW1ldGVycyBpbnQgdHlwZSwgdGhlbiB5b3UgbmVlZA0KPiA+IHRvIGFk
ZCBzb21lIGNvZGUgdG8gcGVyZm9ybSB2YWx1ZSBjaGVjay4gV2UgY2FuIHNwZWNpZnkgYW4NCj4g
PiBhcmJpdHJhcnkgaW50IHZhbHVlIHdpdGggdGhlIGN1cnJlbnQgaW1wbGVtZW50YXRpb24uDQo+
ID4NCj4gPiBUaGFua3MsDQo+ID4gRGFpc3VrZQ0KPiA+DQo+ID4+ICsNCj4gPj4gIHN0YXRpYyBz
dHJ1Y3Qgd29ya3F1ZXVlX3N0cnVjdCAqcnhlX3dxOw0KPiA+Pg0KPiA+PiAgaW50IHJ4ZV9hbGxv
Y193cSh2b2lkKQ0KPiA+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9pbmZpbmliYW5kL3N3L3J4ZS9y
eGVfdGFzay5oIGIvZHJpdmVycy9pbmZpbmliYW5kL3N3L3J4ZS9yeGVfdGFzay5oDQo+ID4+IGlu
ZGV4IGQxMTU2YjkzNTYzNS4uNWEyYWM3YWRhMDViIDEwMDY0NA0KPiA+PiAtLS0gYS9kcml2ZXJz
L2luZmluaWJhbmQvc3cvcnhlL3J4ZV90YXNrLmgNCj4gPj4gKysrIGIvZHJpdmVycy9pbmZpbmli
YW5kL3N3L3J4ZS9yeGVfdGFzay5oDQo+ID4+IEBAIC03LDYgKzcsMTAgQEANCj4gPj4gICNpZm5k
ZWYgUlhFX1RBU0tfSA0KPiA+PiAgI2RlZmluZSBSWEVfVEFTS19IDQo+ID4+DQo+ID4+ICtleHRl
cm4gaW50IHJ4ZV9yZXFfdGFza190eXBlOw0KPiA+PiArZXh0ZXJuIGludCByeGVfY29tcF90YXNr
X3R5cGU7DQo+ID4+ICtleHRlcm4gaW50IHJ4ZV9yZXNwX3Rhc2tfdHlwZTsNCj4gPj4gKw0KPiA+
PiAgc3RydWN0IHJ4ZV90YXNrOw0KPiA+Pg0KPiA+PiAgc3RydWN0IHJ4ZV90YXNrX29wcyB7DQo+
ID4+IC0tDQo+ID4+IDIuMzQuMQ0KPiA+DQoNCg==
