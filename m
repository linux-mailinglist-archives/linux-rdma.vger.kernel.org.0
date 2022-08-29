Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B29BB5A470B
	for <lists+linux-rdma@lfdr.de>; Mon, 29 Aug 2022 12:22:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229741AbiH2KWo (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 29 Aug 2022 06:22:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229504AbiH2KWn (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 29 Aug 2022 06:22:43 -0400
X-Greylist: delayed 64 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 29 Aug 2022 03:22:41 PDT
Received: from esa12.fujitsucc.c3s2.iphmx.com (esa12.fujitsucc.c3s2.iphmx.com [216.71.156.125])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D7B445981
        for <linux-rdma@vger.kernel.org>; Mon, 29 Aug 2022 03:22:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1661768562; x=1693304562;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=uBA4AOIrjhWj30S4knA/zWx2FqtEjQUtg82CafiqpgU=;
  b=DNYe8UORI9zA2grE5tEV7B3Re6MNjVJtIKBEieBezvUcnQeo972NWKI4
   WD0mlBp7lFjg9o5nxK2Cu51RquvCawnMazbUEYucNJ5fQVhWFDmUzgctm
   auKFB6AgXrSjBR68JAxwm7Iq2lK3HLRaX5kaxeOqg6xgEZD45ahk34qxd
   a3GgM7XQrOEEP+t+0m9/cz/enryfUcPZ72yFVwNcpgtpeQHyp861UH3PH
   klI9l1thHPW6c4bhCoUpTUgH89JaptzQEEGEv6Iz5mEqR4clWG4ZviPBK
   ocrryjzm7WwUTb50oTnCsT1lVoXjL9SjfdTvG8LGIm3hdH2u0KBRxZrR9
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10453"; a="63957847"
X-IronPort-AV: E=Sophos;i="5.93,272,1654527600"; 
   d="scan'208";a="63957847"
Received: from mail-os0jpn01lp2107.outbound.protection.outlook.com (HELO JPN01-OS0-obe.outbound.protection.outlook.com) ([104.47.23.107])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Aug 2022 19:21:34 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i1q7/K3887fh5pj4268cZJhzO9oDTb6JDsv63V7YJAt7DpSRKG12PhDYnCZv6bJCUWxn64wqS+kAssLkIIBVL7DmayoE1+QUEtksUME6vbx6TSggb8IExS4GXscc8nCMHvCk5OtyGeR48RUf6EqFxIP5d7+9Vc50h3jd2oHjhk6FcVE+8B1YXZ3mIItrbE1kNiQdp8iR82ycE0b7DarxEuZARHqFQf1zxAJc4CJtusts0E8NOCSF3cSiEtNMpKNR9M5P4tMa8XGZx/lXD0kujpe8yyw67jCQAPoIAUVBNzF6Y9Q71QBJF8JU3m/QJSPn8CzKYjdlwag3Qn2QS/Na7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uBA4AOIrjhWj30S4knA/zWx2FqtEjQUtg82CafiqpgU=;
 b=MDoaomK5j1vQ47rky2npJ8DljuqqswxJCFYTdRkYzrSFuRCT/cgwh9zF7DT/A3eJzztTgEBdY7pfmBDQ6taQCDOf/ry+LtfE71jZG6SfehI+sLYiI9q16jsO/8USK5Niz+Rk0aS0yQogASRrftahjmEYvJh6tA0wJgdEAaaaYpMXFZtUs+g4d3/wInqh7GRDaV3qzqudSjCVaOeCHC63LjypT6TZWeUlsePCQqTyum/ac17oQ+WEL999C9H4r2RtyE/PWskVoV/DwWe1r6Sbw9k5dpSKwfr4/K8RDSaguYh4awXUS1263gp4v39Vw15i852sth0GKDyKwBW7jDCqhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from TYCPR01MB8455.jpnprd01.prod.outlook.com (2603:1096:400:15d::13)
 by OSAPR01MB3315.jpnprd01.prod.outlook.com (2603:1096:604:5c::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.15; Mon, 29 Aug
 2022 10:21:31 +0000
Received: from TYCPR01MB8455.jpnprd01.prod.outlook.com
 ([fe80::1931:760c:588e:9393]) by TYCPR01MB8455.jpnprd01.prod.outlook.com
 ([fe80::1931:760c:588e:9393%9]) with mapi id 15.20.5566.021; Mon, 29 Aug 2022
 10:21:31 +0000
From:   "matsuda-daisuke@fujitsu.com" <matsuda-daisuke@fujitsu.com>
To:     "lizhijian@fujitsu.com" <lizhijian@fujitsu.com>,
        "jgg@nvidia.com" <jgg@nvidia.com>
CC:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "zyjzyj2000@gmail.com" <zyjzyj2000@gmail.com>
Subject: RE: [PATCH] RDMA/rxe: Delete error messages triggered by incoming
 Read requests
Thread-Topic: [PATCH] RDMA/rxe: Delete error messages triggered by incoming
 Read requests
Thread-Index: AQHYu2p9xAJO8n4TJEyW0KS/Nb8Ruq3FfSuAgAArwoA=
Date:   Mon, 29 Aug 2022 10:21:31 +0000
Message-ID: <TYCPR01MB845514BAC6CDED312B2E8720E5769@TYCPR01MB8455.jpnprd01.prod.outlook.com>
References: <Ywi8ZebmZv+bctrC@nvidia.com>
 <20220829054413.1630495-1-matsuda-daisuke@fujitsu.com>
 <708e6623-7b63-6741-a3ed-fedd4d96d1cb@fujitsu.com>
In-Reply-To: <708e6623-7b63-6741-a3ed-fedd4d96d1cb@fujitsu.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-securitypolicycheck: OK by SHieldMailChecker v2.5.2
x-shieldmailcheckerpolicyversion: FJ-ISEC-20170217
x-shieldmailcheckermailid: e676968c26fc4a0c8010a0eabf552fc5
msip_labels: =?utf-8?B?TVNJUF9MYWJlbF9hNzI5NWNjMS1kMjc5LTQyYWMtYWI0ZC0zYjBmNGZlY2Uw?=
 =?utf-8?B?NTBfRW5hYmxlZD10cnVlOyBNU0lQX0xhYmVsX2E3Mjk1Y2MxLWQyNzktNDJh?=
 =?utf-8?B?Yy1hYjRkLTNiMGY0ZmVjZTA1MF9TZXREYXRlPTIwMjItMDgtMjlUMTA6MjE6?=
 =?utf-8?B?MjhaOyBNU0lQX0xhYmVsX2E3Mjk1Y2MxLWQyNzktNDJhYy1hYjRkLTNiMGY0?=
 =?utf-8?B?ZmVjZTA1MF9NZXRob2Q9U3RhbmRhcmQ7IE1TSVBfTGFiZWxfYTcyOTVjYzEt?=
 =?utf-8?B?ZDI3OS00MmFjLWFiNGQtM2IwZjRmZWNlMDUwX05hbWU9RlVKSVRTVS1SRVNU?=
 =?utf-8?B?UklDVEVE4oCLOyBNU0lQX0xhYmVsX2E3Mjk1Y2MxLWQyNzktNDJhYy1hYjRk?=
 =?utf-8?B?LTNiMGY0ZmVjZTA1MF9TaXRlSWQ9YTE5ZjEyMWQtODFlMS00ODU4LWE5ZDgt?=
 =?utf-8?B?NzM2ZTI2N2ZkNGM3OyBNU0lQX0xhYmVsX2E3Mjk1Y2MxLWQyNzktNDJhYy1h?=
 =?utf-8?B?YjRkLTNiMGY0ZmVjZTA1MF9BY3Rpb25JZD1kZGI5YTEwNS05Y2I1LTRjODkt?=
 =?utf-8?B?ODkwMi1jZDc1YzgzNDc0MWQ7IE1TSVBfTGFiZWxfYTcyOTVjYzEtZDI3OS00?=
 =?utf-8?B?MmFjLWFiNGQtM2IwZjRmZWNlMDUwX0NvbnRlbnRCaXRzPTA=?=
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 28434b6c-5bdf-44f9-2f92-08da89a83dea
x-ms-traffictypediagnostic: OSAPR01MB3315:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: JGBNmYFjzEgKX/4GtR5JpNrPORW+uQwMRSbaepltLUljG/BTrh9zvyMcHWJpQdj9xYX3BfaDgtM3rZabcRsYkF2+whtJ4kpYnHFBcSKy5cHrrbcNvlmxGS4b6+JIaxUQHPeMjzwqj0tl5bVrcHG95mXFiYOBFZhCbVDpbTRqHs3XYnnw+IP/1+fhl1ObDTZ3rTfJlXim8/bUu8me9KNx/UF38/knBqp1WBW/LgrHPr8nU3g6zDB5iHYha6oGG0fqzfRwK0Wne70TG0srzTvKV7Y5QULTAQXDin7BtLanvfbpM2jMyVms3LCozw2p4a/URzXrlZoGxSO2sEaP3yLlSMtGaeaJxcSPxt40/yKVGege0ursjYRsy6OJnP5E83H0hm6ouxzqBFYxIWBBjHaxoinJrFJmEcf3ia0hdr/e7S/vPTL6ar0jisKuK7XdlmypHxWwx+ln7meDF9zqtSiXP/vIWtQLjKjLPRSS9W6snNknIZH5X+CFjbBWobFTfr24M0IWKbG/ePFevCdBnj6/bsN+XSJk8jOSa5fwQjUMEbhEhDQugNpv//vHR6iTElCaYQKrtIsZv/343hPMenjNdS3Drwt86ghmvMn5erILcPpzqBpKfAekKRcM6eni34C7Npy2CfSmxqYtxzmQ2N3sUmk8wTJriljWhQSVWgc9bDy3at/U8v+VBmgoNse+DscZgwDLWO1qHJTQFLtzyfqb7gksWSjAA2cfor21PYX/dpiBaihnl6/8irebNgLDig1cQCEdUMXfPTJvS6VZc9w0ml5wMOmxOFY8dD5cBboewPg=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB8455.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(136003)(366004)(396003)(376002)(39860400002)(346002)(1590799006)(66476007)(8676002)(66946007)(76116006)(4326008)(66556008)(64756008)(6506007)(55016003)(53546011)(2906002)(83380400001)(66446008)(9686003)(26005)(8936002)(5660300002)(41300700001)(52536014)(33656002)(7696005)(478600001)(15650500001)(316002)(71200400001)(110136005)(38070700005)(86362001)(122000001)(1580799003)(54906003)(82960400001)(85182001)(186003)(38100700002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VGdueDVBZ1BjK2NidWl3djRwbmthYzJXVnV3SWNsNTdyd0xibVhhZmlwcGdK?=
 =?utf-8?B?R3FUdDNZSllVOWRGTTBSVkZGYkhNSWI2S2p1bk10M1QwT3RVY1hLYjZxcXdq?=
 =?utf-8?B?a0c2MFNSaFN3T3NFWXpaWUFZMFVua2czazZ5bzNCQlZOcWdud0VoMlkzYnVh?=
 =?utf-8?B?bldBQkRBVWp6MEN3MEZSOWhlQkhIL3hiZlRrbW5rb056QzUxMExlWDdoTmlH?=
 =?utf-8?B?YllnOE12QitqTHJQOHROaVFRMWxBQnhEdEhlaWgzTm9vQ2kzbXQxdGptd3V0?=
 =?utf-8?B?ZUxzZTlaYmdjQTNTL0R1bVVtWTNsSk12dTRCV2l5bFdZZyswSGZzLzkwczZW?=
 =?utf-8?B?Q0hUS20wZ3p1RW9PekRFL2J2ajd4a2J5OStBV2IvUi9Zbldwd3FBQzJEZnhI?=
 =?utf-8?B?cXBXeHQvOCtXYkdSVzNXTEQ0T2s1ekhuaGpKazBPMS9Vd0JWS1NoTGp4eEo0?=
 =?utf-8?B?TUtONVpuRjhTSUNzVFFYcFNlOS82eDRGTXErNTBXWU9TK003Y3l4bDhnM3BZ?=
 =?utf-8?B?NEc2U1hXemtvN0xIL0xvZHo4WktxRGw2YmxncFVFTXd6eHVHajA3MzZmYkRn?=
 =?utf-8?B?eVJ2eGhmSnFzZ0tHVGszS1JlcnNZVExQY3plV2k5SWErRVdXV0ZFN2pTT1ZT?=
 =?utf-8?B?czd5ZXo1VnppZncwbyt3TW5IdkFXZWdxNVVFS1FFUmc0TUdmdDJuZXhuMUlC?=
 =?utf-8?B?cjVIMVlKS1pzeUVVTjlVWWFLdTZveE1uU2k5akdIZWdFV3p3dXM1emZjeStt?=
 =?utf-8?B?L1RrcGptMTIybUpSN3lmL2luNm81K3lkeTBpRFZPalNOZDJnZHpCUm5PWGpG?=
 =?utf-8?B?T05PSGtucnAzQ00xQ2s2ai9kYWdYM3hNTDRCMGZtM1RRUjY0Szd6Zi9Ic3R2?=
 =?utf-8?B?Y1hqUnlPWk13U0tCSHdmZ0NCRDZReFcyMXRieER6VGd5d29xTTBLMDl5THE5?=
 =?utf-8?B?bXQrbnZuaGNjaGltOSt2SXkvM0NsVmpnMVdyY08rNFNCaVJ0SE1nMjRsOUdN?=
 =?utf-8?B?QXExYmVYS0hlUnFPSi9wRnR1TDkrRTZ2YkJHanZkZjJrODlHZHBKZkJmSEhE?=
 =?utf-8?B?TTN4N1Y0TWp2bkwvd2s4WmpaL1hvUk1XbXVoS1oyb1hBOTl3ZTgwbG1mQVRW?=
 =?utf-8?B?TU03am5TS0czOTlGeGgzaDFsU3ZxckpNUWEwb1BRaUV4ZmY2Z1NKdjlkbUVj?=
 =?utf-8?B?TWwyWTdZVWZiL1JuV1hjOW13WUNUWGVveFYvMUZXbHVOV2QwODBBN0pUV3li?=
 =?utf-8?B?M054Syszb1htL3RjT01HUEI2VllXdGg2VjhxSm1XNHByYi96dWFudkI4dnVT?=
 =?utf-8?B?elJ5WStsNmF0dWdnekhFcllhcC9La28yQjNGYk5EdytnaG40dFNsVzFvRVdB?=
 =?utf-8?B?b1lCMkhJZkJzY3RNUnRvU0hTSXY4L2JXSU5oOXd2T3lTRXRoaFhGNnRqMTIv?=
 =?utf-8?B?QlNBdUtMYkZiNzgzR1lVbU16L2JSOFdzc1k0OUJyNEU4bSttaGtqWG82MlpN?=
 =?utf-8?B?Ky9aZ05vY1hPQTNHYS95WWIyZDZGaUhMcDU0RFNHeGh2RUZPd0diS21IS3dU?=
 =?utf-8?B?QksrRWRwNTg5UGdMc1l5VXMyK01sN3ZnVWplM3MyamJPa0ppTk1QSm0rcTB1?=
 =?utf-8?B?YlRhYWs3bmgwOVFheVdTQzdsOHdVVEV5UVVhWW1EMmV0ZjZteXZUZUJxejZu?=
 =?utf-8?B?SHZyWWQ2N09YM0hRL0tWMkpEWWJQUk5nZHVKUURhQ1FCMlVRZDVYRUpFMmth?=
 =?utf-8?B?OHd6c3NDU2JkQTg3UXcvOEo3dU5XZzdQUUNnclV4TnB2WEhjMmxXWTJzRVZi?=
 =?utf-8?B?c2xhWjNQTDUybjFlTFlSQjJ0ZTdZODlBbTdQd0ZJUWZkYUhCMEhYTisxN2ky?=
 =?utf-8?B?WXFVRnpvN1p2MmV5Y0ViN0xLdWFZeEYvRUNLb2M0d1Y0SlROM05abGJsVFB5?=
 =?utf-8?B?TklrbVl6Y2FEbm11R2ZyUVM1T2RLSUJ1N1R0RjZJRnNhaFVTR2FlZ3BhY0Vk?=
 =?utf-8?B?NzJxbGRkTjFiMUtnRkUzTFcvSHc4MzhqMzVDWThrR3NOSmlaZGt6U3B3ZXFu?=
 =?utf-8?B?QnlmTnFta2NoK1ZMQzdlMVpKSGY2L3VSM3lvdFhMcVZpSVg0emswT081MlJQ?=
 =?utf-8?B?cCthS0pZRHg2SDQ1WCs2bnF4SkgzeXYyWS9UOE5Kd1I5YVpTM3pxYm5PM2J0?=
 =?utf-8?B?bHc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB8455.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 28434b6c-5bdf-44f9-2f92-08da89a83dea
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Aug 2022 10:21:31.2302
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9A6RAyysKxHTgJrwXD9ETaDzhACBOy5QczN5ztCBDWqOdoO8qoMCOv90mk/+GYSMrKgqDqt23NljfH4CPWRwcBpgy83CPukRKRUY+tuJZgg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSAPR01MB3315
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

T24gTW9uZGF5LCBBdWd1c3QgMjksIDIwMjIgNDozNiBQTSwgTGkgWmhpamlhbiB3cm90ZToNCj4g
T24gMjkvMDgvMjAyMiAxMzo0NCwgRGFpc3VrZSBNYXRzdWRhIHdyb3RlOg0KPiA+IEFuIGluY29t
aW5nIFJlYWQgcmVxdWVzdCBjYXVzZXMgbXVsdGlwbGUgUmVhZCByZXNwb25zZXMuIElmIGEgdXNl
ciBNUiB0bw0KPiA+IGNvcHkgZGF0YSBmcm9tIGlzIHVuYXZhaWxhYmxlIG9yIHJlc3BvbmRlciBj
YW5ub3Qgc2VuZCBhIHJlcGx5LCB0aGVuIHRoZQ0KPiA+IGVycm9yIG1lc3NhZ2VzIGNhbiBiZSBw
cmludGVkIGZvciBlYWNoIHJlc3BvbnNlIGF0dGVtcHQsIHJlc3VsdGluZyBpbg0KPiA+IG1lc3Nh
Z2Ugb3ZlcmZsb3cuDQo+ID4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBEYWlzdWtlIE1hdHN1ZGEgPG1h
dHN1ZGEtZGFpc3VrZUBmdWppdHN1LmNvbT4NCj4gPiAtLS0NCj4gPiAgIGRyaXZlcnMvaW5maW5p
YmFuZC9zdy9yeGUvcnhlX3Jlc3AuYyB8IDYgKy0tLS0tDQo+ID4gICAxIGZpbGUgY2hhbmdlZCwg
MSBpbnNlcnRpb24oKyksIDUgZGVsZXRpb25zKC0pDQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEvZHJp
dmVycy9pbmZpbmliYW5kL3N3L3J4ZS9yeGVfcmVzcC5jIGIvZHJpdmVycy9pbmZpbmliYW5kL3N3
L3J4ZS9yeGVfcmVzcC5jDQo+ID4gaW5kZXggYjM2ZWM1YzRkNWUwLi40YjNlOGFlYzJmYjggMTAw
NjQ0DQo+ID4gLS0tIGEvZHJpdmVycy9pbmZpbmliYW5kL3N3L3J4ZS9yeGVfcmVzcC5jDQo+ID4g
KysrIGIvZHJpdmVycy9pbmZpbmliYW5kL3N3L3J4ZS9yeGVfcmVzcC5jDQo+ID4gQEAgLTgxMSw4
ICs4MTEsNiBAQCBzdGF0aWMgZW51bSByZXNwX3N0YXRlcyByZWFkX3JlcGx5KHN0cnVjdCByeGVf
cXAgKnFwLA0KPiA+DQo+ID4gICAJZXJyID0gcnhlX21yX2NvcHkobXIsIHJlcy0+cmVhZC52YSwg
cGF5bG9hZF9hZGRyKCZhY2tfcGt0KSwNCj4gPiAgIAkJCSAgcGF5bG9hZCwgUlhFX0ZST01fTVJf
T0JKKTsNCj4gPiAtCWlmIChlcnIpDQo+ID4gLQkJcHJfZXJyKCJGYWlsZWQgY29weWluZyBtZW1v
cnlcbiIpOw0KPiBOb3QgcmVsYXRlIHRvIHRoaXMgcGF0Y2guDQo+IEknbSB3b25kZXJpbmcgd2h5
IHRoaXMgZXJyIGlzIGlnbm9yZWQsIHJ4ZV9tcl9jb3B5KCkgZG9lcyB0aGUgcmVhbCBleGVjdXRp
b24gb3IgcnhlX21yX2NvcHkoKSB3b3VsZCBuZXZlciBmYWlsID8NCj4gSU1PLCB3aGVuIGVyciBo
YXBwZW5zLCByZXNwb25kZXIgc2hhbGwgbm90aWZ5IHRoZSByZXF1ZXN0IGFueWhvdy4NCg0KUHJh
Y3RpY2FsbHksIEkgaGF2ZSBuZXZlciBzZWVuIHJ4ZV9tcl9jb3B5KCkgZmFpbGVkIGJlZm9yZSwN
CmJ1dCBJIGFncmVlIHRoZSBpbXBsZW1lbnRhdGlvbiBtYXkgYmUgaW5jb3JyZWN0IGFzIHlvdSBt
ZW50aW9uZWQuDQoNCkFzIGZhciBhcyBJIHRlc3RlZCwgcmVzcG9uZGVyIHJlcGxpZWQgd2l0aCB0
aGUgcmVxdWVzdGVkIGFtb3VudCBvZiBwYXlsb2Fkcw0KZXZlbiB3aGVuIHJ4ZV9tcl9jb3B5KCkg
aXMgbW9kaWZpZWQgdG8gZmFpbC4gSW4gdGhpcyBjYXNlLCANCnJlcXVlc3RlciBtYXkgbWlzdGFr
ZW5seSBiZWxpZXZlIHRoYXQgdGhleSBnZXQgZGF0YSBjb3JyZWN0bHkuDQoNCkZvciBtb3JlIGRl
dGFpbHMsIHNlZSBJQiBTcGVjaWZpY2F0aW9uIFZvbCAxLVJldmlzaW9uLTEuNSBDaC45LjcuNS4x
LjMgKHBhZ2UuMzM0KS4NCg0KRGFpc3VrZSBNYXRzdWRhDQoNCj4gDQo+IFRoYW5rcw0KPiBaaGlq
aWFuDQo+IA0KPiA+ICAgCWlmIChtcikNCj4gPiAgIAkJcnhlX3B1dChtcik7DQo+ID4NCj4gPiBA
QCAtODIzLDEwICs4MjEsOCBAQCBzdGF0aWMgZW51bSByZXNwX3N0YXRlcyByZWFkX3JlcGx5KHN0
cnVjdCByeGVfcXAgKnFwLA0KPiA+ICAgCX0NCj4gPg0KPiA+ICAgCWVyciA9IHJ4ZV94bWl0X3Bh
Y2tldChxcCwgJmFja19wa3QsIHNrYik7DQo+ID4gLQlpZiAoZXJyKSB7DQo+ID4gLQkJcHJfZXJy
KCJGYWlsZWQgc2VuZGluZyBSRE1BIHJlcGx5LlxuIik7DQo+ID4gKwlpZiAoZXJyKQ0KPiA+ICAg
CQlyZXR1cm4gUkVTUFNUX0VSUl9STlI7DQo+ID4gLQl9DQo+ID4NCj4gPiAgIAlyZXMtPnJlYWQu
dmEgKz0gcGF5bG9hZDsNCj4gPiAgIAlyZXMtPnJlYWQucmVzaWQgLT0gcGF5bG9hZDsNCg0K
