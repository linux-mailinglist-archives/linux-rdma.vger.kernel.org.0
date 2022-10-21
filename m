Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BB2F606DF9
	for <lists+linux-rdma@lfdr.de>; Fri, 21 Oct 2022 04:47:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229615AbiJUCrx (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 20 Oct 2022 22:47:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbiJUCrw (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 20 Oct 2022 22:47:52 -0400
X-Greylist: delayed 63 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 20 Oct 2022 19:47:50 PDT
Received: from esa15.fujitsucc.c3s2.iphmx.com (esa15.fujitsucc.c3s2.iphmx.com [68.232.156.107])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E12C41A208A
        for <linux-rdma@vger.kernel.org>; Thu, 20 Oct 2022 19:47:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1666320472; x=1697856472;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=LKFlTK1QUN4RrCAfQBa8e+4QR8q6PmfOAwfrdRpQDTQ=;
  b=vX+R7HbanijuTmJpii8ms5X6jdD9H8rwyNBc9y2ImKD2HjJlrVTkBm/z
   t1kHFyk48jYViSUk26YHgATdY3c3ek4XgKfmjnrmWn6sJngNqmwT7sRKY
   3QG4O3E9JWZg8kNlqJpY4/gqrBvfGf+PkUkOl2YAfgaYXZN6BJudpNoey
   FmmYIBmyl59i0FG2/AKnDg1t4Hk6mOnVw3JCnF6oUiQA+GfHED7OCddBV
   wahUW4r2rAAFV048x2rxg20aE9HcaS9EfMhG9gOoN98lxj1f6FoSvVX3z
   6ve+Y+rqdEF3eu/chka7PjUILOhpbTDmU40wIdpOclVSngz31F2iNP8KO
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10506"; a="68048696"
X-IronPort-AV: E=Sophos;i="5.95,200,1661785200"; 
   d="scan'208";a="68048696"
Received: from mail-os0jpn01lp2113.outbound.protection.outlook.com (HELO JPN01-OS0-obe.outbound.protection.outlook.com) ([104.47.23.113])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2022 11:46:44 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VZIo6qbj6P4ZYdwM6b+PunpP2lfGKeDD5p/xBYcA786JgSKzhng1roeRGiRjH9jDlOYDN2xLYr9PGFy6wNJUxhoyHAjvIYebqhSQfoM9DoraM0y7Zg5hjr6kEDiUU2zUKsuSbO3Ms30psH8QbwInhPqnfzvMX3/yrhphbHC3fhVMMQbTLnGrjNMi0dPFLffSGANbHj/rP470xjmy0VL7ucIlYwYpuAdsM2A4wrrPJ5sVJPmfREWpVfj7igDAf3Prcc6cjrV2p3CQvJblMamsUlEOFQVfB16Ac055FEXoM+ROpmxKwzz4LtsII3UpR4DMR160pXstuOHBxBmv1KtEYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LKFlTK1QUN4RrCAfQBa8e+4QR8q6PmfOAwfrdRpQDTQ=;
 b=TmfBhn3aSdI8Hfri42gLkteym/j4eLtrYOv3N4SBZPWk6uUfp01Cfi8onjiRPZ/HMakSU86sChnA+cv+xsalLZM0RaUNOSJv6zfCuoAlZ8LvD64/P9HwB0FI+T+sRuY5w9RIoZrEUjAXDJ575gv4TAICT0QmzNMkRaEK1sGS/HaGlxT4sx71QMhT7kHkw3kpwXpc2p6uumRV67xC+jsyiFywl2+MQfFseycxZkJRBw/v5G7hlIbBwFx3aWdxPMhpGp89H6CMZWcZ7QqUuYmlBTcKCod6fcQTOEeY/O5sG+smBxr471PzA22CraCJjFD1h6g+tHOCiH1OMNJmeNhhQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from OSZPR01MB8451.jpnprd01.prod.outlook.com (2603:1096:604:16e::9)
 by OSZPR01MB9502.jpnprd01.prod.outlook.com (2603:1096:604:1d2::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.29; Fri, 21 Oct
 2022 02:46:39 +0000
Received: from OSZPR01MB8451.jpnprd01.prod.outlook.com
 ([fe80::934:4f22:b37c:b7f5]) by OSZPR01MB8451.jpnprd01.prod.outlook.com
 ([fe80::934:4f22:b37c:b7f5%7]) with mapi id 15.20.5723.034; Fri, 21 Oct 2022
 02:46:39 +0000
From:   "matsuda-daisuke@fujitsu.com" <matsuda-daisuke@fujitsu.com>
To:     'haris iqbal' <haris.phnx@gmail.com>,
        Bob Pearson <rpearsonhpe@gmail.com>
CC:     "jgg@nvidia.com" <jgg@nvidia.com>,
        "zyjzyj2000@gmail.com" <zyjzyj2000@gmail.com>,
        "lizhijian@fujitsu.com" <lizhijian@fujitsu.com>,
        "leon@kernel.org" <leon@kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "jenny.hack@hpe.com" <jenny.hack@hpe.com>,
        "ian.ziemba@hpe.com" <ian.ziemba@hpe.com>
Subject: RE: [PATCH for-next 00/16] Implement work queues for rdma_rxe
Thread-Topic: [PATCH for-next 00/16] Implement work queues for rdma_rxe
Thread-Index: AQHY4qskWUjHTVQhskS2nBCxxKFeXq4XZJAAgAC2XYA=
Date:   Fri, 21 Oct 2022 02:46:39 +0000
Message-ID: <OSZPR01MB845136BC247B6D253E070457E52D9@OSZPR01MB8451.jpnprd01.prod.outlook.com>
References: <20221018043345.4033-1-rpearsonhpe@gmail.com>
 <CAE_WKMz8kTWY_-BCheuqj+szpS9rkSrE+NFGLa-0-WXcKr5Sug@mail.gmail.com>
In-Reply-To: <CAE_WKMz8kTWY_-BCheuqj+szpS9rkSrE+NFGLa-0-WXcKr5Sug@mail.gmail.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-securitypolicycheck: OK by SHieldMailChecker v2.5.2
x-shieldmailcheckerpolicyversion: FJ-ISEC-20170217
x-shieldmailcheckermailid: 1d64cb94583444ab8bc4c10af9b3da13
msip_labels: =?utf-8?B?TVNJUF9MYWJlbF9hNzI5NWNjMS1kMjc5LTQyYWMtYWI0ZC0zYjBmNGZlY2Uw?=
 =?utf-8?B?NTBfRW5hYmxlZD10cnVlOyBNU0lQX0xhYmVsX2E3Mjk1Y2MxLWQyNzktNDJh?=
 =?utf-8?B?Yy1hYjRkLTNiMGY0ZmVjZTA1MF9TZXREYXRlPTIwMjItMTAtMjFUMDI6NDY6?=
 =?utf-8?B?MzZaOyBNU0lQX0xhYmVsX2E3Mjk1Y2MxLWQyNzktNDJhYy1hYjRkLTNiMGY0?=
 =?utf-8?B?ZmVjZTA1MF9NZXRob2Q9U3RhbmRhcmQ7IE1TSVBfTGFiZWxfYTcyOTVjYzEt?=
 =?utf-8?B?ZDI3OS00MmFjLWFiNGQtM2IwZjRmZWNlMDUwX05hbWU9RlVKSVRTVS1SRVNU?=
 =?utf-8?B?UklDVEVE4oCLOyBNU0lQX0xhYmVsX2E3Mjk1Y2MxLWQyNzktNDJhYy1hYjRk?=
 =?utf-8?B?LTNiMGY0ZmVjZTA1MF9TaXRlSWQ9YTE5ZjEyMWQtODFlMS00ODU4LWE5ZDgt?=
 =?utf-8?B?NzM2ZTI2N2ZkNGM3OyBNU0lQX0xhYmVsX2E3Mjk1Y2MxLWQyNzktNDJhYy1h?=
 =?utf-8?B?YjRkLTNiMGY0ZmVjZTA1MF9BY3Rpb25JZD01NDExOTYzMy0zMWEzLTRhZWYt?=
 =?utf-8?B?OTRiNC01ZGVkOGUxZDQ4N2U7IE1TSVBfTGFiZWxfYTcyOTVjYzEtZDI3OS00?=
 =?utf-8?B?MmFjLWFiNGQtM2IwZjRmZWNlMDUwX0NvbnRlbnRCaXRzPTA=?=
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OSZPR01MB8451:EE_|OSZPR01MB9502:EE_
x-ms-office365-filtering-correlation-id: 85d46519-18c0-4186-3640-08dab30e7ab7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /ridUTXFElC0OEv2Aub96uCS8+eHzph77PZpTP0fYzobrcZZ6cYkmeCdUSwJnwU/QJMo/Q5zCpwSCD/uil4+lHM3tBarBL1RuvzoqVBk6VAWqE1a2D5nN2Q3cfD1cI2jMkCbWy+v3Y7BCKJA4kf13afk5s/uSAibonoqohfIzuzm6q7zdSnYzr4IOXndi+/dfOyyrbE+ZsBeE6NnaiCDqcGOEyTfjjr+wDcPbYH9BxWIb4eQZLgjC62T8jw8pXZU3U7+ECToU4r0iHlMRMOucCxWdrb+wHl2qkF3pMDUnKTA1r1l/vkw7qRRO/jbt4RZyxW7Mkq9vbShhw+9zzh1Pi02x3FlnYI/a5kM+9W+S9YgyIYpgbif5+ggXL931DGItsFDvu4gkFXGJSQfnVBFHskEswUGMYaEmN2mVt1XsRJOKqdpN96nGDjMcYyTSIvIY5jnHCLisM+F1fENTt1qwLQ7XuXhUpBwV9OaqgaTEvy+HWXIYxwtKK6FXFEYEXkAw5ofjauGUbonYZHFRkruXMCPfNLrYeywq5YZbclrOqAEho2WiBjm1b3OcHFt5jSX8oSx/WUoWhl6PuugfqyA8oQN7iZLDxIT8oG6gdFYEeMUm4DiTaT3vVqBXHvSJJ8XYwy+WXGyLa4DhfsQ3td6nq86t9hVwcxvWBEoaFnVFguvD+muYsezkt7Yw85976tzNy6UlcESSyvVvgCkfrwSSsimtCO21wwWLGCEqvcw4wEb/FligodfEqD0C3IuJ3to07KJslKoHrdw5ON+VM8TeK9OoSwX50SlOoYx5Ra12n4=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSZPR01MB8451.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(346002)(136003)(39860400002)(376002)(396003)(451199015)(1590799012)(76116006)(53546011)(6506007)(7696005)(85182001)(66946007)(66556008)(66476007)(66446008)(64756008)(8676002)(4326008)(71200400001)(110136005)(316002)(54906003)(55016003)(33656002)(2906002)(186003)(83380400001)(5660300002)(86362001)(9686003)(26005)(41300700001)(52536014)(8936002)(1580799009)(38070700005)(82960400001)(478600001)(38100700002)(122000001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?U1pWeExYeFY3S2lxR21OUFVEUXhuQlhMaHZmdUljNFdWekxJZllPRGh5K2tT?=
 =?utf-8?B?OGdCdjhrQXh3ckFBbHQ1dDlyZldyb2IzVDdjVC9JWkRXSFIvcHFDSGtTem5p?=
 =?utf-8?B?eTlROEM1OEJzVlpmZ0c5Sk5ZSmFSSC82eXpkelBxVjA1cE9FWmNlNGlqRVph?=
 =?utf-8?B?elA4QmhwdkVJNy9EWmk2anZ0d1p2bm11dTE2c2R2NlR4S25oam15cm5TYjQy?=
 =?utf-8?B?QzNHcWUyYlRNb2RNcVFHVDFVRis1L0o1SUg1MjZOWDZ2Vlo3ZHhSWnIvWnRa?=
 =?utf-8?B?Mk5ucXRsUDc1dnJsMjVwanRXZFgrZDVtMS9XUUZhRTJIS2RyS0wyNkltNTJ3?=
 =?utf-8?B?clVyaE1GcWlIVFQwMm5ZcXNaMDk4T0d1Y0FQZkZRVFJMd2JsRmFpcGZPc3pR?=
 =?utf-8?B?MjhJRUVJNHNWKy9vUnd4QU9MU1FZL0dENTBqVk1EMUtBU3RaOVphUlNNNXBB?=
 =?utf-8?B?cnlSbnJ6MDFYY0E4a1NQMmYxbnc0NU94cnZ1TVRBbUc4RzczT3UzRVdiQTRB?=
 =?utf-8?B?NEw5UVhING5HbS83MjdiL3Z4WSsxMkRZSlRXMUhrK2ZsUjdKNjhZZ2VWY25n?=
 =?utf-8?B?OXRleVhKQXE2S2ZjUHB4dW9vUlpubGVzY1dmNnBUdnZPWGpHY25IdlB6NitK?=
 =?utf-8?B?Nzl6L0ZtQkNxakhhdzhWdjkzWEU3TVFEWkd5MUlkWjNjcVZjWnU3emYwd2ZP?=
 =?utf-8?B?OWpLWlR2bmxSbm96cVRocFEzbzJabnZtOXZVUm14MFhNNGdLbVpuT0V5ZnNh?=
 =?utf-8?B?eXNEZnBTVVAvZXEvL2lFaVhwVGloaEFub3JPM0NBYlRwVWl0dTZPY1ZRdG9Y?=
 =?utf-8?B?elJoYlZIWDVEZGVUUHpkSlpOTXcxVkpmaXg3YkJOZmxXZEpjb3YrMzc2ZlIz?=
 =?utf-8?B?TmUrQ2tJZk1JSGU0cjYzNjVqTXJuNkc5M1Y3NzZuUXhzMVNWMmN3QlpoZisy?=
 =?utf-8?B?OTdsMWs5RUNKRHAzWUhCbC9TQzVZcmtZWlhkdXJhVC9rY2NsUUg3T1A3TDRP?=
 =?utf-8?B?d2d3MUF3V0N4WmFFWkdhNktPM3dyMXhMcVpuVXJqc3pBQzQ4UklHbXhzV3k3?=
 =?utf-8?B?U015QTdpNU5odm5xdmhTaWdJdDNBODkxSkIyazVaaFhJaklCV0RlZS9nZnN4?=
 =?utf-8?B?RG9kK3dPajJyRVBUOGxxVVI0cUd2LzBTdGh4L3ZwWmJZMXI0WGplbEVQMjll?=
 =?utf-8?B?Vm8vNGtKRVFIS2FmUFArMk1uVlAzSzE1ajdWYXdONTBCVld6UkRWNUZTWTlK?=
 =?utf-8?B?SUFzNmxCYyt4Tm92WTJnTEd5a002OUErQ1N4bUlsQzV1aE00SUo2L0psSHpB?=
 =?utf-8?B?T08vMGFuZVc0emE1VzdEdGhxeHJ1bVFwbW9CZ1AySW51Tm9Ec1ZOeEt0QWZV?=
 =?utf-8?B?TmJud09ncDRUVVpPWnRlTFV0WVBwejg5elNIRHBqK29aT3IwMnZGaEliSzBT?=
 =?utf-8?B?UER3aTZpeVhOYTU1bWg5UXpoYUhGbTFUaTBmUXFTQjRkZzRzM25PamJwdXRM?=
 =?utf-8?B?aUtRTW5mb2Q2WW9RUjdZc0dFaHRGcGFEaWgzOXliOThoSDR5VitUUUFvSEZX?=
 =?utf-8?B?Z1NMQ2NBcE5zTTVZSnMraU92dFVRdGw4ZUFqekxQeHBzL0xObkJhdTNTVUl4?=
 =?utf-8?B?TVZqZnlTQm1MQ1lDV1hzOC8xL2VMd3VSejlxcGZOZk1wRUc3c3k3YzlKVTEy?=
 =?utf-8?B?V3E4WWxMOHNIUzdvOU1QMXcrQmdFa3VNNW1SNGUxZkh2RDBiNWpZK3pCWlJa?=
 =?utf-8?B?NWdobHNSR2dhcCtndXNQenVpeEtnYkRnSVJoeG9HYXRTU0FDbHNsaUswZWxn?=
 =?utf-8?B?ZjJRWHdGT3MzM1pjMjl3M0pWS2pUM0V4bUZmaHNVWCtwYmJtZHlNbUQ5VDF4?=
 =?utf-8?B?Y3d1OVk2TGExU0k2YUxhb2dwalk1OWtiYWU4d2FWcVpuUzFFL0ZvWUVZZzdp?=
 =?utf-8?B?STBlRm82bEZpN2dydzJWZmRCWTJheXZ5d2VFMTdjZ09LS0YrS0h3V1lOajFO?=
 =?utf-8?B?VFN6YnlFTCtUOWo2NFk4VVlNMVVGVXBGNVJSeUtwU3Y1MFhlU2RTVGlVUWd2?=
 =?utf-8?B?eFJtNmNlRUwxQnJlakw4eVFlSHRqaEFNVWphRTVBemhidCtLcnBuL2lCdUVx?=
 =?utf-8?B?OW9RK0U0WStnS3BkdDZQU2x3NUc3cFJhdngwTVpTZ29DZjBoaFV5aTVHMWNp?=
 =?utf-8?B?TGc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSZPR01MB8451.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 85d46519-18c0-4186-3640-08dab30e7ab7
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Oct 2022 02:46:39.5463
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: eU5LHbNpY91tZy4BNCHCYKWH6MapA6KKtRZ8v5MR3boVvO9BsaIHQ1GLLjtwyIHSTEk6YYX/fht5waoKYu9j9VdUAqG0HXqQpF8uG/9LL6g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSZPR01MB9502
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

T24gRnJpLCBPY3QgMjEsIDIwMjIgMTI6MDIgQU0gaGFyaXMgSXFiYWwgd3JvdGU6DQo+IA0KPiBP
biBUdWUsIE9jdCAxOCwgMjAyMiBhdCA2OjM5IEFNIEJvYiBQZWFyc29uIDxycGVhcnNvbmhwZUBn
bWFpbC5jb20+IHdyb3RlOg0KPiA+DQo+ID4gVGhpcyBwYXRjaCBzZXJpZXMgaW1wbGVtZW50cyB3
b3JrIHF1ZXVlcyBhcyBhbiBhbHRlcm5hdGl2ZSBmb3INCj4gPiB0aGUgbWFpbiB0YXNrbGV0cyBp
biB0aGUgcmRtYV9yeGUgZHJpdmVyLiBUaGUgZmlyc3QgZmV3IHBhdGNoZXMNCj4gPiBwZXJmb3Jt
IHNvbWUgY2xlYW51cHMgb2YgdGhlIGN1cnJlbnQgdGFza2xldCBjb2RlIGZvbGxvd2VkIGJ5IGEN
Cj4gPiBwYXRjaCB0aGF0IG1ha2VzIHRoZSBpbnRlcm5hbCBBUEkgZm9yIHRhc2sgZXhlY3V0aW9u
IHBsdWdnYWJsZSBhbmQNCj4gPiBpbXBsZW1lbnRzIGFuIGlubGluZSBhbmQgYSB0YXNrbGV0IGJh
c2VkIHNldCBvZiBmdW5jdGlvbnMuDQo+ID4gVGhlIHJlbWFpbmluZyBwYXRjaGVzIGNsZWFudXAg
dGhlIHFwIHJlc2V0IGFuZCBlcnJvciBjb2RlIGluIHRoZQ0KPiA+IHRocmVlIHRhc2tsZXRzIGFu
ZCBtb2RpZnkgdGhlIGxvY2tpbmcgbG9naWMgdG8gcHJldmVudCBtYWtpbmcNCj4gPiBtdWx0aXBs
ZSBjYWxscyB0byB0aGUgdGFza2xldCBzY2hlZHVsaW5nIHJvdXRpbmUuIEZpbmFsbHkgYWZ0ZXIN
Cj4gPiB0aGlzIHByZXBhcmF0aW9uIHRoZSB3b3JrIHF1ZXVlIGVxdWl2YWxlbnQgc2V0IG9mIGZ1
bmN0aW9ucyBpcw0KPiA+IGFkZGVkIGFuZCBtb2R1bGUgcGFyYW1ldGVycyBhcmUgaW1wbGVtZW50
ZWQgdG8gYWxsb3cgdHVuaW5nIHRoZQ0KPiA+IHRhc2sgdHlwZXMuDQo+ID4NCj4gPiBUaGUgYWR2
YW50YWdlcyBvZiB0aGUgd29yayBxdWV1ZSB2ZXJzaW9uIG9mIGRlZmVycmVkIHRhc2sgZXhlY3V0
aW9uDQo+ID4gaXMgbWFpbmx5IHRoYXQgdGhlIHdvcmsgcXVldWUgdmFyaWFudCBoYXMgbXVjaCBi
ZXR0ZXIgc2NhbGFiaWxpdHkNCj4gPiBhbmQgb3ZlcmFsbCBwZXJmb3JtYW5jZSB0aGFuIHRoZSB0
YXNrbGV0IHZhcmlhbnQuIFRoZSB0YXNrbGV0DQo+ID4gcGVyZm9ybWFuY2Ugc2F0dXJhdGVzIHdp
dGggb25lIGNvbm5lY3RlZCBxdWV1ZSBwYWlyIGFuZCBzdGF5cyBjb25zdGFudC4NCj4gPiBUaGUg
d29yayBxdWV1ZSBwZXJmb3JtYW5jZSBpcyBzbGlnaHRseSBiZXR0ZXIgZm9yIG9uZSBxdWV1ZSBw
YWlyIGJ1dA0KPiA+IHNjYWxlcyB1cCB3aXRoIHRoZSBudW1iZXIgb2YgY29ubmVjdGVkIHF1ZXVl
IHBhaXJzLiBUaGUgcGVyZnRlc3QNCj4gPiBtaWNyb2JlbmNobWFya3MgaW4gbG9jYWwgbG9vcGJh
Y2sgbW9kZSAobm90IGEgdmVyeSByZWFsaXN0aWMgdGVzdA0KPiA+IGNhc2UpIGNhbiByZWFjaCBh
cHByb3hpbWF0ZWx5IDEwMEdiL3NlYyB3aXRoIHdvcmsgcXVldWVzIGNvbXBhcmVkIHRvDQo+ID4g
YWJvdXQgMTZHYi9zZWMgZm9yIHRhc2tsZXRzLg0KPiA+DQo+ID4gVGhpcyBwYXRjaCBzZXJpZXMg
aXMgZGVyaXZlZCBmcm9tIGFuIGVhcmxpZXIgcGF0Y2ggc2V0IGRldmVsb3BlZCBieQ0KPiA+IElh
biBaaWVtYmEgYXQgSFBFIHdoaWNoIGlzIHVzZWQgaW4gc29tZSBMdXN0cmUgc3RvcmFnZSBjbGll
bnRzIGF0dGFjaGVkDQo+ID4gdG8gTHVzdHJlIHNlcnZlcnMgd2l0aCBoYXJkIFJvQ0UgdjIgTklD
cy4NCj4gPg0KPiA+IEJvYiBQZWFyc29uICgxNik6DQo+ID4gICBSRE1BL3J4ZTogUmVtb3ZlIGlu
aXQgb2YgdGFzayBsb2NrcyBmcm9tIHJ4ZV9xcC5jDQo+ID4gICBSRE1BL3J4ZTogUmVtb3ZlZCB1
bnVzZWQgbmFtZSBmcm9tIHJ4ZV90YXNrIHN0cnVjdA0KPiA+ICAgUkRNQS9yeGU6IFNwbGl0IHJ4
ZV9ydW5fdGFzaygpIGludG8gdHdvIHN1YnJvdXRpbmVzDQo+ID4gICBSRE1BL3J4ZTogTWFrZSBy
eGVfZG9fdGFzayBzdGF0aWMNCj4gPiAgIFJETUEvcnhlOiBSZW5hbWUgdGFzay0+c3RhdGVfbG9j
ayB0byB0YXNrLT5sb2NrDQo+ID4gICBSRE1BL3J4ZTogTWFrZSB0YXNrIGludGVyZmFjZSBwbHVn
Z2FibGUNCj4gPiAgIFJETUEvcnhlOiBTaW1wbGlmeSByZXNldCBzdGF0ZSBoYW5kbGluZyBpbiBy
eGVfcmVzcC5jDQo+ID4gICBSRE1BL3J4ZTogU3BsaXQgcnhlX2RyYWluX3Jlc3BfcGt0cygpDQo+
ID4gICBSRE1BL3J4ZTogSGFuZGxlIHFwIGVycm9yIGluIHJ4ZV9yZXNwLmMNCj4gPiAgIFJETUEv
cnhlOiBDbGVhbnVwIGNvbXAgdGFza3MgaW4gcnhlX3FwLmMNCj4gPiAgIFJETUEvcnhlOiBSZW1v
dmUgX19yeGVfZG9fdGFzaygpDQo+ID4gICBSRE1BL3J4ZTogTWFrZSB0YXNrcyBzY2hlZHVsZSBl
YWNoIG90aGVyDQo+ID4gICBSRE1BL3J4ZTogSW1wbGVtZW50IGRpc2FibGUvZW5hYmxlX3Rhc2so
KQ0KPiA+ICAgUkRNQS9yeGU6IFJlcGxhY2UgVEFTS19TVEFURV9TVEFSVCBieSBUQVNLX1NUQVRF
X0lETEUNCj4gPiAgIFJETUEvcnhlOiBBZGQgd29ya3F1ZXVlIHN1cHBvcnQgZm9yIHRhc2tzDQo+
ID4gICBSRE1BL3J4ZTogQWRkIHBhcmFtZXRlcnMgdG8gY29udHJvbCB0YXNrIHR5cGUNCj4gPg0K
PiA+ICBkcml2ZXJzL2luZmluaWJhbmQvc3cvcnhlL3J4ZS5jICAgICAgIHwgICA5ICstDQo+ID4g
IGRyaXZlcnMvaW5maW5pYmFuZC9zdy9yeGUvcnhlX2NvbXAuYyAgfCAgMzUgKystDQo+ID4gIGRy
aXZlcnMvaW5maW5pYmFuZC9zdy9yeGUvcnhlX25ldC5jICAgfCAgIDQgKy0NCj4gPiAgZHJpdmVy
cy9pbmZpbmliYW5kL3N3L3J4ZS9yeGVfcXAuYyAgICB8ICA4NyArKystLS0tDQo+ID4gIGRyaXZl
cnMvaW5maW5pYmFuZC9zdy9yeGUvcnhlX3JlcS5jICAgfCAgMTAgKy0NCj4gPiAgZHJpdmVycy9p
bmZpbmliYW5kL3N3L3J4ZS9yeGVfcmVzcC5jICB8ICA3NSArKysrLS0NCj4gPiAgZHJpdmVycy9p
bmZpbmliYW5kL3N3L3J4ZS9yeGVfdGFzay5jICB8IDM1NCArKysrKysrKysrKysrKysrKysrKy0t
LS0tLQ0KPiA+ICBkcml2ZXJzL2luZmluaWJhbmQvc3cvcnhlL3J4ZV90YXNrLmggIHwgIDc2ICsr
Ky0tLQ0KPiA+ICBkcml2ZXJzL2luZmluaWJhbmQvc3cvcnhlL3J4ZV92ZXJicy5jIHwgICA4ICst
DQo+ID4gIDkgZmlsZXMgY2hhbmdlZCwgNDUxIGluc2VydGlvbnMoKyksIDIwNyBkZWxldGlvbnMo
LSkNCj4gPg0KPiA+DQo+ID4gYmFzZS1jb21taXQ6IDlhYmYyMzEzYWRjMWNhMWI2MTgwYzUwOGMy
NWYyMmY5Mzk1Y2M3ODANCj4gDQo+IFRoZSBwYXRjaCBzZXJpZXMgaXMgbm90IGFwcGx5aW5nIGNs
ZWFubHkgb3ZlciB0aGUgbWVudGlvbmVkIGNvbW1pdCBmb3INCj4gbWUuIFBhdGNoICdQQVRDSCBm
b3ItbmV4dCAwNS8xNl0gUkRNQS9yeGU6IFJlbmFtZSB0YXNrLT5zdGF0ZV9sb2NrIHRvDQo+IHRh
c2stPmxvY2suJyBmYWlscyBhdCAiZHJpdmVycy9pbmZpbmliYW5kL3N3L3J4ZS9yeGVfdGFzay5j
OjEwMyIuDQo+IEkgY29ycmVjdGVkIHRoYXQgbWFudWFsbHksIHRoZW4gaXQgZmFpbHMgaW4gdGhl
IG5leHQgY29tbWl0LiBEaWRuJ3QNCj4gY2hlY2sgYWZ0ZXIgdGhhdC4gSXMgaXQgdGhlIHNhbWUg
Zm9yIG90aGVycyBvciBpcyBpdCBqdXN0IG1lPw0KDQpUaGVyZSBpcyBhIHByb2JsZW0gd2l0aCB0
aGUgNHRoIHBhdGNoLiBJdHMgc3ViamVjdCBpcyBkaWZmZXJlbnQgZnJvbSBvdGhlciBwYXRjaGVz
LA0Kc28gcHJvYmFibHkgaXQgd2FzIG5vdCBnZW5lcmF0ZWQgYXQgdGhlIHNhbWUgdGltZSB3aXRo
IHRoZW0uIEkgY291bGQgYXBwbHkgdGhlIHJlc3QNCmFmdGVyIGFkZGluZyB0aGUgZm9sbG93aW5n
IGNoYW5nZSB0byB0aGUgNHRoOg0KPT09DQpkaWZmIC0tZ2l0IGEvZHJpdmVycy9pbmZpbmliYW5k
L3N3L3J4ZS9yeGVfdGFzay5jIGIvZHJpdmVycy9pbmZpbmliYW5kL3N3L3J4ZS9yeGVfdGFzay5j
DQppbmRleCAwOTdkZGIxNmMyMzAuLmE3MjAzYjkzZTVjYyAxMDA2NDQNCi0tLSBhL2RyaXZlcnMv
aW5maW5pYmFuZC9zdy9yeGUvcnhlX3Rhc2suYw0KKysrIGIvZHJpdmVycy9pbmZpbmliYW5kL3N3
L3J4ZS9yeGVfdGFzay5jDQpAQCAtMjgsNyArMjgsNyBAQCBpbnQgX19yeGVfZG9fdGFzayhzdHJ1
Y3QgcnhlX3Rhc2sgKnRhc2spDQogICogYSBzZWNvbmQgY2FsbGVyIGZpbmRzIHRoZSB0YXNrIGFs
cmVhZHkgcnVubmluZw0KICAqIGJ1dCBsb29rcyBqdXN0IGFmdGVyIHRoZSBsYXN0IGNhbGwgdG8g
ZnVuYw0KICAqLw0KLXN0YXRpYyB2b2lkIHJ4ZV9kb190YXNrKHN0cnVjdCB0YXNrbGV0X3N0cnVj
dCAqdCkNCitzdGF0aWMgdm9pZCBkb190YXNrKHN0cnVjdCB0YXNrbGV0X3N0cnVjdCAqdCkNCiB7
DQogICAgICAgIGludCBjb250Ow0KICAgICAgICBpbnQgcmV0Ow0KQEAgLTEwMCw3ICsxMDAsNyBA
QCBpbnQgcnhlX2luaXRfdGFzayhzdHJ1Y3QgcnhlX3Rhc2sgKnRhc2ssIHZvaWQgKmFyZywgaW50
ICgqZnVuYykodm9pZCAqKSkNCiAgICAgICAgdGFzay0+ZnVuYyAgICAgID0gZnVuYzsNCiAgICAg
ICAgdGFzay0+ZGVzdHJveWVkID0gZmFsc2U7DQoNCi0gICAgICAgdGFza2xldF9zZXR1cCgmdGFz
ay0+dGFza2xldCwgcnhlX2RvX3Rhc2spOw0KKyAgICAgICB0YXNrbGV0X3NldHVwKCZ0YXNrLT50
YXNrbGV0LCBkb190YXNrKTsNCg0KICAgICAgICB0YXNrLT5zdGF0ZSA9IFRBU0tfU1RBVEVfU1RB
UlQ7DQogICAgICAgIHNwaW5fbG9ja19pbml0KCZ0YXNrLT5zdGF0ZV9sb2NrKTsNCkBAIC0xMzIs
NyArMTMyLDcgQEAgdm9pZCByeGVfcnVuX3Rhc2soc3RydWN0IHJ4ZV90YXNrICp0YXNrKQ0KICAg
ICAgICBpZiAodGFzay0+ZGVzdHJveWVkKQ0KICAgICAgICAgICAgICAgIHJldHVybjsNCg0KLSAg
ICAgICByeGVfZG9fdGFzaygmdGFzay0+dGFza2xldCk7DQorICAgICAgIGRvX3Rhc2soJnRhc2st
PnRhc2tsZXQpOw0KIH0NCg0KIHZvaWQgcnhlX3NjaGVkX3Rhc2soc3RydWN0IHJ4ZV90YXNrICp0
YXNrKQ0KPT09DQoNCkRhaXN1a2UNCg0KPiANCj4gPiAtLQ0KPiA+IDIuMzQuMQ0KPiA+DQo=
