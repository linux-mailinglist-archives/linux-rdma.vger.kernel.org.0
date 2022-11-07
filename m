Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C55C61E88A
	for <lists+linux-rdma@lfdr.de>; Mon,  7 Nov 2022 03:14:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230306AbiKGCOV (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 6 Nov 2022 21:14:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230174AbiKGCOT (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 6 Nov 2022 21:14:19 -0500
X-Greylist: delayed 62 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 06 Nov 2022 18:14:18 PST
Received: from esa3.fujitsucc.c3s2.iphmx.com (esa3.fujitsucc.c3s2.iphmx.com [68.232.151.212])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26ECD657D
        for <linux-rdma@vger.kernel.org>; Sun,  6 Nov 2022 18:14:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1667787258; x=1699323258;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=M4TPXDH5ftZiqClxWxxeTCfWX0OwkoVCb/Afdc3b3do=;
  b=RWkQmZZyVQoONJxD9YWO86aHbWd67d8LIo+65pcatFwMEvo7Gr5cVxLH
   oV3aLHTiPycyk8j1Okgu+S6cdMzekpbMuVUfUh80r+f9LjOZCMLmq6lhJ
   70YkFZggXoLwbnzH1ebq+SSISw4A/Ce++RnAFUSl4RVsSJy/Df1Dd72IB
   qE0WxZiUrexSrdAUF/xyMFyT/Zv/nC15cYlmKi3lx7L1EaSNUn7CQz/eo
   6RVltk1Hyn5v3WMb9ODlO6Uk+FaL1d5LHGTTfoX+TLCt3Z7NzOicGKrjH
   uOAWHqrlA/PYJDcOVvri3sod1nPXjK3lQKnKUudjIX65qVTmv9GC7hbIu
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10523"; a="77398482"
X-IronPort-AV: E=Sophos;i="5.96,143,1665414000"; 
   d="scan'208";a="77398482"
Received: from mail-tycjpn01lp2176.outbound.protection.outlook.com (HELO JPN01-TYC-obe.outbound.protection.outlook.com) ([104.47.23.176])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Nov 2022 11:08:51 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eFtyjfGpSAEf69b9kbDL0AyUHGQ5yqlcmNfPn8iniq6gdXRgynMw7Nbj0ggbheyvDPeNwsbR/dMsHndqgvhLllI5NL/qSXpPvWrnZH8jsrmb+BBN17jx0q4aucgq13RznLVVNaruttV2fzpDTd7eiTAgaSCQsQLUJMleQFNOTs3LpsQpMWBQb4fVhpnQojGpUa/gImVxKqGSJ7qcw9TfkZd4l1W8E038Ax2pTRKIaWmtqhl39x7Q/G4L+OQ9NluijZyKTrxvynns8dDZK0Q+8gLwvbbjGE12giZpT2QJDvBH9QgDKy2rBihHjvZUg/wWw1c/9gM5LYFXc0mifhTfPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M4TPXDH5ftZiqClxWxxeTCfWX0OwkoVCb/Afdc3b3do=;
 b=WWZl6sSf9N0N4RZeHK0CsNv+Y3vigJfmaKcGUKhf3MQp35QiFll8QrSJ+4e4PQE2zaMF9BYDDaLSN4wWGMiSYa0Vz93VNu57bTkr4a+XUT95N188HB5YBoCmVnMAQ5lA/DmJwExWRDxkKJao30zjLL2IrP8oDiWaj1a+qMbQE3nBsTYpj/uMRSva/3O+4uQYGyTJJMDFu6HaC3kuRLjsaO3/xhfTsTI978kofiXvXr+GB8G9L8yKBVfDrkaL6ZWQ1PL6P/qC89tZ/0AATon7dL4y+VWzH3wjkDvMtICxqetlD/w2di1idWhK0scsGuUc6g+TFXQJer0qqabdDz9nzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from TYCPR01MB8455.jpnprd01.prod.outlook.com (2603:1096:400:15d::13)
 by TYWPR01MB9495.jpnprd01.prod.outlook.com (2603:1096:400:1a6::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.26; Mon, 7 Nov
 2022 02:08:48 +0000
Received: from TYCPR01MB8455.jpnprd01.prod.outlook.com
 ([fe80::8f33:6006:986f:f575]) by TYCPR01MB8455.jpnprd01.prod.outlook.com
 ([fe80::8f33:6006:986f:f575%5]) with mapi id 15.20.5791.025; Mon, 7 Nov 2022
 02:08:48 +0000
From:   "Daisuke Matsuda (Fujitsu)" <matsuda-daisuke@fujitsu.com>
To:     "lizhijian@fujitsu.com" <lizhijian@fujitsu.com>,
        "leonro@nvidia.com" <leonro@nvidia.com>,
        "jgg@nvidia.com" <jgg@nvidia.com>,
        "zyjzyj2000@gmail.com" <zyjzyj2000@gmail.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: RE: [PATCH] RDMA/rxe: Implement packet length validation on responder
Thread-Topic: [PATCH] RDMA/rxe: Implement packet length validation on
 responder
Thread-Index: AQHY6qxYcBkYBpNqyEets2WZqUo8E64wHwyAgAKdaeA=
Date:   Mon, 7 Nov 2022 02:08:48 +0000
Message-ID: <TYCPR01MB845521C64972204CDDABE5C8E53C9@TYCPR01MB8455.jpnprd01.prod.outlook.com>
References: <20221028090438.2685345-1-matsuda-daisuke@fujitsu.com>
 <09db5954-a1e2-e164-edf2-319cb51bb7cd@fujitsu.com>
In-Reply-To: <09db5954-a1e2-e164-edf2-319cb51bb7cd@fujitsu.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-securitypolicycheck: OK by SHieldMailChecker v2.5.2
x-shieldmailcheckerpolicyversion: FJ-ISEC-20170217
x-shieldmailcheckermailid: 98b9554a781b4950a2f228d0499487ef
msip_labels: =?utf-8?B?TVNJUF9MYWJlbF9hNzI5NWNjMS1kMjc5LTQyYWMtYWI0ZC0zYjBmNGZlY2Uw?=
 =?utf-8?B?NTBfRW5hYmxlZD10cnVlOyBNU0lQX0xhYmVsX2E3Mjk1Y2MxLWQyNzktNDJh?=
 =?utf-8?B?Yy1hYjRkLTNiMGY0ZmVjZTA1MF9TZXREYXRlPTIwMjItMTEtMDdUMDI6MDg6?=
 =?utf-8?B?NDZaOyBNU0lQX0xhYmVsX2E3Mjk1Y2MxLWQyNzktNDJhYy1hYjRkLTNiMGY0?=
 =?utf-8?B?ZmVjZTA1MF9NZXRob2Q9U3RhbmRhcmQ7IE1TSVBfTGFiZWxfYTcyOTVjYzEt?=
 =?utf-8?B?ZDI3OS00MmFjLWFiNGQtM2IwZjRmZWNlMDUwX05hbWU9RlVKSVRTVS1SRVNU?=
 =?utf-8?B?UklDVEVE4oCLOyBNU0lQX0xhYmVsX2E3Mjk1Y2MxLWQyNzktNDJhYy1hYjRk?=
 =?utf-8?B?LTNiMGY0ZmVjZTA1MF9TaXRlSWQ9YTE5ZjEyMWQtODFlMS00ODU4LWE5ZDgt?=
 =?utf-8?B?NzM2ZTI2N2ZkNGM3OyBNU0lQX0xhYmVsX2E3Mjk1Y2MxLWQyNzktNDJhYy1h?=
 =?utf-8?B?YjRkLTNiMGY0ZmVjZTA1MF9BY3Rpb25JZD0xYWRhNGE4MS05Yjk4LTQ4ZDIt?=
 =?utf-8?B?ODAxNC0zOWFmZWY4NTg5MDg7IE1TSVBfTGFiZWxfYTcyOTVjYzEtZDI3OS00?=
 =?utf-8?B?MmFjLWFiNGQtM2IwZjRmZWNlMDUwX0NvbnRlbnRCaXRzPTA=?=
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYCPR01MB8455:EE_|TYWPR01MB9495:EE_
x-ms-office365-filtering-correlation-id: 3c8f85f6-f105-4507-1702-08dac065022e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ZNe88ru65YVzkeT3xPrngoHKRGdy2QfT7DDdGld4JuQTus6fizezRxrTB/Y8q2dZ11WKsYSdFjekrAbA+mohnbBUWjk2/ga6jLlCnNRn8bAJwP6cpYi+le2brz/OTA9Gx82lsuSJT4IYup2ESO0B9OKBv/rvXzaZP3dsG2QWz3YZKmEeyBis4ab65RN8RxDRKzYHiOYggKxBnCXt/PJc4lEZtU5rxZd3k5Wm1dgrJf3tOFkk7BUYJQ/67qiMUUpPt4c5z7lxHHIWM3AZuOu6eeaH/4VRvCqHFL3Uy7T4mx/s4szHsCn2LmWPZyVhpuNllszl1OhJZMHwU9s2okToc33Imh1DhZrH+pcCtaQLcGMNLoGe4u8vT5E/Oe1bW2LSou1Tt6we03I5Wf7+l28MG07D5m23efCnArK9KES4+X0A9JD394Oa3I5nwDXsA1m0hYs1KBagnS94WGodIFczB5Fydmqv5wdE2eAOlHldAaPS+tNuxMck8q4hgbPQ+HwyRfKGsKv+mspV31g0x+4EtNpUEnUm4EUmF+kR+NpLnpuleMa1pkumhVNgiAKc1XNk39GwEqcLsoMCH5vInIFNHXi6lvIuzjivroskC9cGaTf8rCgO7tUTM5/LSHsAN6+xnOqP5b2s4W9zbtnu6XiJw1DB35uXt1IFTCk+rX1lmyy8dsHLDkqVCm6+e+tFirma0AfyB9nyje8UzlRIOmxKLvM0O/mjJtP2gvx6pt9BKVnvhfDWU9kADZuwtYBENav4xDLn/U9DEyeYVGRN9QtXIn0imLY1JZMCbnafjGuOVd0=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB8455.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(346002)(366004)(376002)(39860400002)(136003)(1590799012)(451199015)(53546011)(26005)(9686003)(186003)(6506007)(7696005)(122000001)(83380400001)(2906002)(55016003)(8676002)(110136005)(316002)(478600001)(71200400001)(38100700002)(41300700001)(5660300002)(52536014)(8936002)(76116006)(66446008)(66476007)(66556008)(64756008)(66946007)(85182001)(33656002)(38070700005)(82960400001)(86362001)(1580799009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TGdweWR5NWFIc0U5TExBWTNIcmRxbllqeVR4U2cyVFg2emEwK3d2NHJ4eXVP?=
 =?utf-8?B?T1lQcUNjMm9tRENwS0JNdllsVnFHM0M2T0lTdERLNHFNNVFYOXN1Y2dsUUQr?=
 =?utf-8?B?eEZieVRYTkJsWlQrVldsTUxFeTYrOEFyT0YvMUp1Q216dFo4NmlQZnVlZXJP?=
 =?utf-8?B?YURSbllmSTRHSysxdFVpZUJ1Y0ZWMzlidTc3a1d1d014MTVIOXhLU01qYUxz?=
 =?utf-8?B?UU54VHR3bFFjQUFITUViWHI2RjZUbmdmVm9ULzdtZ0dzVGFkcmdGQm9NYjVo?=
 =?utf-8?B?cHlpSTEwZ2IxZ05BM2QzV0NuNjFleWM4SGNKZFdBV0k5NFhnYjBqMzFHcFhx?=
 =?utf-8?B?Z2hmOThHTlBFcDdaTDVOUlJuM0xFeU5zWmdXYmVDVjBkc0toZ1pNV0UrQWcz?=
 =?utf-8?B?SUJQR0pmbDBGeFpYYXRxNk1RVGgxWHgwY09tMzR1ZDU4YmZDbndLME9mUUxO?=
 =?utf-8?B?Z2o4djN4cmRaNHUzbytrYkFKRVVVSmw1SDVqdm5UL1NRNUZCNlp2NkNHRE1N?=
 =?utf-8?B?WVJTSExqYW83R1c0VW44c0IvZWkyM2F3c3QwSzNiQlYvNUkxVzNtd2paOXVp?=
 =?utf-8?B?cUpKenYrZVVjTC9ZNzdhZFRVaXl1ZHljc2labi9uVTZOeW1lWFZCSTlicmxH?=
 =?utf-8?B?a1BSemoydFpBMVpYcGtlYStYTGc3TEZCdnBpK1hUclgxWC9jTUhKVVphTmRu?=
 =?utf-8?B?aWFIai9xZTZhcy9WOUJwZWlpd2M3cTBMcngwcllXVzFob0Z3Z1ByRUxRNUpl?=
 =?utf-8?B?Qm1lRCtPTWFRaVJ2TEEwNmhMNDV5V2g4cGFEMjBEWnM3WC9aYnprdDd6U29h?=
 =?utf-8?B?KzBHeWlRZloxSFRNaFNxbTE2dUcvOWM1TnE0Ly85WTBDOEJ2QjBWdU1pR0JN?=
 =?utf-8?B?QTNzZ3Nqc0t1ZW53QnRSYVNCNjA2allaWU1xSDVqTms3MlVsUzcwMVkvaG9Z?=
 =?utf-8?B?TTdrdTM4aWVSaTZleUhFcE94Y29ORzFnZ0Jhak5ETWdCYWZNTTlqTTZQMStF?=
 =?utf-8?B?ZGpyaHlvcFlwOEc4RUVWNDZ5T2JlczdMemppeUN5enVwcFdXbXRrWjlwYUFy?=
 =?utf-8?B?ZkhPVWZYNHFxY1VYNWJ2UmI3Mjg3SCsyM2g4ZWozUGUxejZGT2VJOHQwaytN?=
 =?utf-8?B?NlBJQWhNdUdxdmpOdzNMemNva0hqc0UyellwQ2dBNGJPRmFoa2M5SkI2MEo0?=
 =?utf-8?B?eUFiRUNZN0RvUXF2K0NYN3Z5dWNHU0xSMXBKclREQ2FxUDJnTnU5c2NoQUsv?=
 =?utf-8?B?RlZlYVpUYW8rbVBtQ1ZHb3Fhd3Z0eWM5Vkx1TVBRbnVSTkJGcEpGNmg3UGgy?=
 =?utf-8?B?bGM4NGE5VTJjZVZyU1lHSXphb3czcG1sYVNGUkwrS0t2WHZJQlhzYUdUZ0FC?=
 =?utf-8?B?SXR2RHhPSGlOanNEQlBlNzd4NzhLQUpjZW94c2FpN3NERG5NQjRqaCtQbUhH?=
 =?utf-8?B?OW1pQXcyazRkQ0dwdGh2Z1IxTlN3SEJCVEJBd2tDZGw1cE1zcURpaXluMEcv?=
 =?utf-8?B?dFlOdFgwQjRpelAzWU5XL2FjYUNHcDhDL01ZY0V4KzZmVlpQSWk0akh2UE5S?=
 =?utf-8?B?RW5zQ1UyR1dFWFdwTUdnZ1VJdW5ORlpNS2VqU0s1ZXBQT0JXczJWS2NaNmt3?=
 =?utf-8?B?UUlYS2EyS2UzZnNGc3I5eDZZb3J3cWRSQzZGaURKV2ozamVpM3hxKzlXb0Zi?=
 =?utf-8?B?M01XVW5iV3JYWFhCYU9hQW9VR0N6Y0RpVlo0ZUZzZkcwNXBEdDJhclJrWFIz?=
 =?utf-8?B?MFFpdEEwSmNCMU1OKy9IVW1IK0pkS2t0dTZkeFJUa3VBRnFJUTRuZXN6Yzk0?=
 =?utf-8?B?Q1M0Y3ZSU0lldE1kU2Y0ZHp1bytlZHpZZjlOSGV1RktBcWc1WWIyWHBsakoz?=
 =?utf-8?B?WXNhd1p3bEpWMk9KcW9WTFFEcWR3bGxib0JlQkZNd1JnQ05tTG5ZcEk5RnJQ?=
 =?utf-8?B?RmIzMGpCUFBtT1QyeVZqR0tocXFvME9nc2RSWk5FNG5jNHcrbERoUzdWZlh1?=
 =?utf-8?B?V3FYTTRyVjZYdDY1d3NoQWtrb3JrOFlGdU9US0ZJZ1BhVys2VURwZ1N6eUZC?=
 =?utf-8?B?d0lGS2Y0SDBPNDN1bGxvRFZkc2ZmcnN6QjZjZXVGc05SRTl1dVhDcENVS0ZW?=
 =?utf-8?B?ZXluV3VrQ1E2RnBXVkZwYW9pNHJ5S1FlY3E0K0Z5WU9NekZPZEdlVzVUZVpx?=
 =?utf-8?B?YWc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB8455.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c8f85f6-f105-4507-1702-08dac065022e
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Nov 2022 02:08:48.6995
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pNn6tjXFzEsNoh3cXAXNGk/1f+Sa9O+6XZFmBY9CLSJGx78+oBVfrYM/BNXoFQ3XBiOdbhusVbVIIRLhptUhWGeJ8diKykHZS4gOL7cey5U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB9495
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

T24gU2F0LCBOb3YgNSwgMjAyMiA2OjM3IFBNIExpLCBaaGlqaWFuIHdyb3RlOg0KPiBPbiAyOC8x
MC8yMDIyIDE3OjA0LCBEYWlzdWtlIE1hdHN1ZGEgd3JvdGU6DQo+ID4gVGhlIGZ1bmN0aW9uIGNo
ZWNrX2xlbmd0aCgpIGlzIHN1cHBvc2VkIHRvIGNoZWNrIHRoZSBsZW5ndGggb2YgaW5ib3VuZA0K
PiA+IHBhY2tldHMgb24gcmVzcG9uZGVyLCBidXQgaXQgYWN0dWFsbHkgaGFzIGJlZW4gYSBzdHVi
IHNpbmNlIHRoZSBkcml2ZXIgd2FzDQo+ID4gYm9ybi4gTGV0IGl0IGNoZWNrIHRoZSBwYXlsb2Fk
IGxlbmd0aCBhbmQgdGhlIERNQSBsZW5ndGguDQo+ID4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBEYWlz
dWtlIE1hdHN1ZGEgPG1hdHN1ZGEtZGFpc3VrZUBmdWppdHN1LmNvbT4NCj4gPiAtLS0NCj4gPiBG
T1IgUkVWSUVXRVJTDQo+ID4gICAgSSByZWZlcnJlZCB0byBJQiBTcGVjaWZpY2F0aW9uIFZvbCAx
LVJldmlzaW9uLTEuNSB0byBjcmVhdGUgdGhpcyBwYXRjaC4NCj4gPiAgICBQbGVhc2Ugc2VlIDku
Ny40LjEuNiAocGFnZS4zMzApLg0KPiA+DQo+ID4gICBkcml2ZXJzL2luZmluaWJhbmQvc3cvcnhl
L3J4ZV9yZXNwLmMgfCAzNiArKysrKysrKysrKysrKysrKysrKysrLS0tLS0tDQo+ID4gICAxIGZp
bGUgY2hhbmdlZCwgMjkgaW5zZXJ0aW9ucygrKSwgNyBkZWxldGlvbnMoLSkNCj4gPg0KPiA+IGRp
ZmYgLS1naXQgYS9kcml2ZXJzL2luZmluaWJhbmQvc3cvcnhlL3J4ZV9yZXNwLmMgYi9kcml2ZXJz
L2luZmluaWJhbmQvc3cvcnhlL3J4ZV9yZXNwLmMNCj4gPiBpbmRleCBlZDVhMDllODY0MTcuLjYy
ZTNhODE5NTA3MiAxMDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJzL2luZmluaWJhbmQvc3cvcnhlL3J4
ZV9yZXNwLmMNCj4gPiArKysgYi9kcml2ZXJzL2luZmluaWJhbmQvc3cvcnhlL3J4ZV9yZXNwLmMN
Cj4gPiBAQCAtMzkwLDE2ICszOTAsMzggQEAgc3RhdGljIGVudW0gcmVzcF9zdGF0ZXMgY2hlY2tf
cmVzb3VyY2Uoc3RydWN0IHJ4ZV9xcCAqcXAsDQo+ID4gICBzdGF0aWMgZW51bSByZXNwX3N0YXRl
cyBjaGVja19sZW5ndGgoc3RydWN0IHJ4ZV9xcCAqcXAsDQo+ID4gICAJCQkJICAgICBzdHJ1Y3Qg
cnhlX3BrdF9pbmZvICpwa3QpDQo+ID4gICB7DQo+ID4gLQlzd2l0Y2ggKHFwX3R5cGUocXApKSB7
DQo+ID4gLQljYXNlIElCX1FQVF9SQzoNCj4gPiAtCQlyZXR1cm4gUkVTUFNUX0NIS19SS0VZOw0K
PiA+ICsJaW50IG10dSA9IHFwLT5tdHU7DQo+ID4gKwl1MzIgcGF5bG9hZCA9IHBheWxvYWRfc2l6
ZShwa3QpOw0KPiA+ICsJdTMyIGRtYWxlbiA9IHJldGhfbGVuKHBrdCk7DQo+ID4NCj4gPiAtCWNh
c2UgSUJfUVBUX1VDOg0KPiA+IC0JCXJldHVybiBSRVNQU1RfQ0hLX1JLRVk7DQo+ID4gKwkvKiBS
b0NFdjIgcGFja2V0cyBkbyBub3QgaGF2ZSBMUkguDQo+ID4gKwkgKiBMZXQncyBza2lwIGNoZWNr
aW5nIGl0Lg0KPiA+ICsJICovDQo+ID4NCj4gPiAtCWRlZmF1bHQ6DQo+ID4gLQkJcmV0dXJuIFJF
U1BTVF9DSEtfUktFWTsNCj4gPiArCWlmICgocGt0LT5vcGNvZGUgJiBSWEVfU1RBUlRfTUFTSykg
JiYNCj4gPiArCSAgICAocGt0LT5vcGNvZGUgJiBSWEVfRU5EX01BU0spKSB7DQo+ID4gKwkJLyog
Im9ubHkiIHBhY2tldHMgKi8NCj4gPiArCQlpZiAocGF5bG9hZCA+IG10dSkNCj4gPiArCQkJcmV0
dXJuIFJFU1BTVF9FUlJfTEVOR1RIOw0KPiA+ICsNCj4gPiArCX0gZWxzZSBpZiAoKHBrdC0+b3Bj
b2RlICYgUlhFX1NUQVJUX01BU0spIHx8DQo+ID4gKwkJICAgKHBrdC0+b3Bjb2RlICYgUlhFX01J
RERMRV9NQVNLKSkgew0KPiA+ICsJCS8qICJmaXJzdCIgb3IgIm1pZGRsZSIgcGFja2V0cyAqLw0K
PiA+ICsJCWlmIChwYXlsb2FkICE9IG10dSkNCj4gPiArCQkJcmV0dXJuIFJFU1BTVF9FUlJfTEVO
R1RIOw0KPiA+ICsNCj4gPiArCX0gZWxzZSBpZiAocGt0LT5vcGNvZGUgJiBSWEVfRU5EX01BU0sp
IHsNCj4gPiArCQkvKiAibGFzdCIgcGFja2V0cyAqLw0KPiA+ICsJCWlmICgocGt0LT5wYXlsZW4g
PT0gMCkgfHwgKHBrdC0+cGF5bGVuID4gbXR1KSkNCj4gDQo+IEFzIHBlciBJQkEgc3BlYywgaSBk
aWRuJ3Qgc2VlIGFueSBkaWZmZXJlbmNlIGFib3V0IHRoZSAncGFja2V0IHBheWxvYWQNCj4gbGVu
Z3RoJyBmcm9tIG90aGVycywNCj4gDQo+IHNvIE1heSBJIGtub3cgd2h5IGhlcmUgeW91IGFyZSB1
c2luZyAncGt0LT5wYXlsZW4nIGluc3RlYWQgb2YgcGF5bG9hZCA/DQoNClRoYW5rIHlvdSBmb3Ig
dGFraW5nIGEgbG9vay4NCkl0IHNlZW1zIHRoaXMgaXMgbXkgbWlzdGFrZS4gSSBmb3Jnb3QgdG8g
cmVwbGFjZSB0aGVtIHdpdGggJ3BheWxvYWQnLg0KSSdsbCBwb3N0IHYyIGxhdGVyLg0KDQpBY3R1
YWxseSAncGt0LT5wYXlsZW4nIGlzIGxhcmdlciB0aGFuICdwYXlsb2FkJzoNCnBrdC0+cGF5bGVu
ID0gKElCIEJUSCkgKyAoSUIgcGF5bG9hZCkgKyAoSUNSQykNCg0KRGFpc3VrZQ0KDQo+IA0KPiAN
Cj4gVGhhbmtzDQo+IA0KPiBaaGlqaWFuDQo+IA0KPiANCj4gDQo+ID4gKwkJCXJldHVybiBSRVNQ
U1RfRVJSX0xFTkdUSDsNCj4gPiArCX0NCj4gPiArDQo+ID4gKwlpZiAocGt0LT5vcGNvZGUgJiAo
UlhFX1dSSVRFX01BU0sgfCBSWEVfUkVBRF9NQVNLKSkgew0KPiA+ICsJCWlmIChkbWFsZW4gPiAo
MSA8PCAzMSkpDQo+ID4gKwkJCXJldHVybiBSRVNQU1RfRVJSX0xFTkdUSDsNCj4gPiAgIAl9DQo+
ID4gKw0KPiA+ICsJcmV0dXJuIFJFU1BTVF9DSEtfUktFWTsNCj4gPiAgIH0NCj4gPg0KPiA+ICAg
c3RhdGljIGVudW0gcmVzcF9zdGF0ZXMgY2hlY2tfcmtleShzdHJ1Y3QgcnhlX3FwICpxcCwNCg==
