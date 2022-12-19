Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4981465073A
	for <lists+linux-rdma@lfdr.de>; Mon, 19 Dec 2022 05:57:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231273AbiLSE5G (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 18 Dec 2022 23:57:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231310AbiLSE47 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 18 Dec 2022 23:56:59 -0500
Received: from esa16.fujitsucc.c3s2.iphmx.com (esa16.fujitsucc.c3s2.iphmx.com [216.71.158.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C2B8AE66
        for <linux-rdma@vger.kernel.org>; Sun, 18 Dec 2022 20:56:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1671425808; x=1702961808;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=go3EYKBH0uZ3nL50K4OtDbIpSacUXCpefqtp8Ouzf1o=;
  b=FblKbk+GVX0dL4lfxs8TAxNmolsfItdD/D59lH1Fn7cemv0Qasf44u/a
   NyVtwqjyQE8ehMtJkd4AtTmgT3XqC9O7ZfHx4/HElrbrxWDgrPLybvQhD
   taZ0k2OUT4j8bN8TPdr1vtP/wJy9rtd6Ut+1NmowPVx0SVbpHwwvaAhjb
   lvF6qhpYn2KayC5HuX4Mbb27eyNkfwGdAMAj8lNh0BETwPhLNXVfphhVS
   bG8TwYglU3nq6/ElBzI21Pe5yguiy2N+Jsuaz2/pE2ht1lGsmFARnQVHW
   ERvOGysGhCIJ4vEMGILN+ObybNioICLOc80aEkJfIIfHQSQmnaNBLTiIE
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10565"; a="72641514"
X-IronPort-AV: E=Sophos;i="5.96,254,1665414000"; 
   d="scan'208";a="72641514"
Received: from mail-os0jpn01lp2112.outbound.protection.outlook.com (HELO JPN01-OS0-obe.outbound.protection.outlook.com) ([104.47.23.112])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Dec 2022 13:56:45 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hdGgTs+FFMa/TQbwBc4lYNGasHmgspKx/ELUTxlEKad+WHF3UbPA+VHMgYG7WxaiChU1GRbqoV4SIp92fb08TAJapRXtgwuIRveRmNJtfU+H0hFNLXN8cRBKh3mPEgqJRhpJ5t0s2DvdihZYqc1ago51Y+AyIwPhd8DIHZUvwtMYaIjtCKbi1wgYNYPhhYTdDxRmfoG8vyrYuFcQ0AS8Dw4FPAvqZw1RMEd159zUuxQP+hwBPHchwls0DkRBpe479Xb9l3KLnu7WZJB8shqVmmHL/OkSDz48a9JtXZDALd4huZuVe4D2BbkdBo+JkOPNSnSzCe25+99gBJZR0Px34A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=go3EYKBH0uZ3nL50K4OtDbIpSacUXCpefqtp8Ouzf1o=;
 b=aWbCzEME/WuZCrnt/8CzWwGl5YeBKnq1G/8YQjih3KFGkI0bIXOLuMjOjFDEKU3Oh91Imbod81WE7rEg9QKkGVt5pjAe9rbsDVDQ6Ql2rBbNQtv+kzWqlXoF8OanmfGUNVES+FhUVveNtXG8RKDU+LuxfIh4R45fKmVCAPKPYuqnjb7b9fwEiMEfMvZIQAUdLtn3H8xQk/u/NQ2V+rEkeTDUKEHpPElTBR9bdLNcSREbKBvcvMgJQybEri9Dfan+R97QCTi2NxI88YebBO8KZUaxiuKq4qxBzfrCVxKDwYvC8/6lKpz5ZeuKk4nWgAHfOWBtWu2f/euCgElBRmvElw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from TYCPR01MB8455.jpnprd01.prod.outlook.com (2603:1096:400:15d::13)
 by TYWPR01MB9823.jpnprd01.prod.outlook.com (2603:1096:400:235::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5924.16; Mon, 19 Dec
 2022 04:56:41 +0000
Received: from TYCPR01MB8455.jpnprd01.prod.outlook.com
 ([fe80::9c4e:a570:cf39:f63]) by TYCPR01MB8455.jpnprd01.prod.outlook.com
 ([fe80::9c4e:a570:cf39:f63%2]) with mapi id 15.20.5924.016; Mon, 19 Dec 2022
 04:56:41 +0000
From:   "Daisuke Matsuda (Fujitsu)" <matsuda-daisuke@fujitsu.com>
To:     "lizhijian@fujitsu.com" <lizhijian@fujitsu.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "leonro@nvidia.com" <leonro@nvidia.com>,
        "jgg@nvidia.com" <jgg@nvidia.com>,
        "zyjzyj2000@gmail.com" <zyjzyj2000@gmail.com>
CC:     "rpearsonhpe@gmail.com" <rpearsonhpe@gmail.com>,
        "Rao.Shoaib@oracle.com" <Rao.Shoaib@oracle.com>
Subject: RE: [PATCH 2/2] RDMA/rxe: Prevent faulty rkey generation
Thread-Topic: [PATCH 2/2] RDMA/rxe: Prevent faulty rkey generation
Thread-Index: AQHZEG4cKK6e/mIV60ekS6XriaLORa5x3nqAgAKRaOA=
Date:   Mon, 19 Dec 2022 04:56:41 +0000
Message-ID: <TYCPR01MB8455D01548B6BA44CE8FCAB8E5E59@TYCPR01MB8455.jpnprd01.prod.outlook.com>
References: <20221215101439.3644683-1-matsuda-daisuke@fujitsu.com>
 <20221215101439.3644683-2-matsuda-daisuke@fujitsu.com>
 <5c3f1c2a-f923-3bdd-52cd-131883614d25@fujitsu.com>
In-Reply-To: <5c3f1c2a-f923-3bdd-52cd-131883614d25@fujitsu.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-securitypolicycheck: OK by SHieldMailChecker v2.5.2
x-shieldmailcheckerpolicyversion: FJ-ISEC-20170217
x-shieldmailcheckermailid: cbc46a714c634bd28e7181be3e0dfee7
msip_labels: =?utf-8?B?TVNJUF9MYWJlbF9hNzI5NWNjMS1kMjc5LTQyYWMtYWI0ZC0zYjBmNGZlY2Uw?=
 =?utf-8?B?NTBfRW5hYmxlZD10cnVlOyBNU0lQX0xhYmVsX2E3Mjk1Y2MxLWQyNzktNDJh?=
 =?utf-8?B?Yy1hYjRkLTNiMGY0ZmVjZTA1MF9TZXREYXRlPTIwMjItMTItMTlUMDI6Mjk6?=
 =?utf-8?B?MjFaOyBNU0lQX0xhYmVsX2E3Mjk1Y2MxLWQyNzktNDJhYy1hYjRkLTNiMGY0?=
 =?utf-8?B?ZmVjZTA1MF9NZXRob2Q9U3RhbmRhcmQ7IE1TSVBfTGFiZWxfYTcyOTVjYzEt?=
 =?utf-8?B?ZDI3OS00MmFjLWFiNGQtM2IwZjRmZWNlMDUwX05hbWU9RlVKSVRTVS1SRVNU?=
 =?utf-8?B?UklDVEVE4oCLOyBNU0lQX0xhYmVsX2E3Mjk1Y2MxLWQyNzktNDJhYy1hYjRk?=
 =?utf-8?B?LTNiMGY0ZmVjZTA1MF9TaXRlSWQ9YTE5ZjEyMWQtODFlMS00ODU4LWE5ZDgt?=
 =?utf-8?B?NzM2ZTI2N2ZkNGM3OyBNU0lQX0xhYmVsX2E3Mjk1Y2MxLWQyNzktNDJhYy1h?=
 =?utf-8?B?YjRkLTNiMGY0ZmVjZTA1MF9BY3Rpb25JZD05NzM5OWQ5ZC1lNGZjLTQwMmMt?=
 =?utf-8?B?OTcxZi03MjM5ZjllY2JlNzA7IE1TSVBfTGFiZWxfYTcyOTVjYzEtZDI3OS00?=
 =?utf-8?B?MmFjLWFiNGQtM2IwZjRmZWNlMDUwX0NvbnRlbnRCaXRzPTA=?=
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYCPR01MB8455:EE_|TYWPR01MB9823:EE_
x-ms-office365-filtering-correlation-id: aeddb87c-869d-433a-dacf-08dae17d6b85
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 0AGiViQzn4O39PKNSw+wGjiAjInzbScP4H8OaacGPMLrFmNhTDkVXOdOT9TSgzG5cg6QPuO2MO/ecY6ZNmwmSvFkyumdFPk0Iwbxb/u3Nh48AHEm0AjGMk6/60StYiD3vjnMMgRk0/+/vCr1nux2kPBcMhCiMH2GUnPR3mibFT7azb3/oil7U8UCRgBzgs7LdGPcMzgncEj9HaWAEXjwDnywF/ydIbPf/rU6x4F1g4azDvzu46eV1jmgMFuRnJ4LcLMVUaG/fTB/r/WWr1eHznjbEJj7I0w/RpbvxdsQkgeszegMs2EKHIdRGxakLyIcOjuNBwjmfLbnbz4td1CuVifIQyFfJdjo3VSWfK8O2RLioN/3mvgvE3sGvCMeH3/1CyS2bnaWhUl+yJw5vaJeLL6Gd84ZAwZRW0AqcgfdA3wIpF2xa5xv7h60d3rRfOH2D5LQCy2od4wsY9/1ZDHCa8T/rW4WYpNcf5U0hHPO6LJZ1EJGu6+tDyT/yf40Wyi4ov0B6veVqkgDHpIYg5n1hnx7XJZawogtxtp6B2WqCSJ9orC1JwwvNFHfz9ftfLfY0lHacyqSVbXT6No2CgYGyEU9mZfOwJtS+TIZSBG3vyvciQ9eoosiymoEWkuThLkJy3Hg/SXcXWW5Ugz0yhqtIB19W8U4Kr7jBog3R3CPVWXiMKq/FFcwcoHVC8/uYqp9jtsK22E6cQWxIwKLQk01GLMXaSFbG3b2pXby0e4L8AAgjfgyuUjmJlcYWde7w6Kod+tLt8wwlOCL8asJVtgluA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB8455.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(39860400002)(136003)(346002)(366004)(376002)(1590799012)(451199015)(86362001)(82960400001)(38100700002)(1580799009)(2906002)(71200400001)(186003)(9686003)(26005)(6506007)(7696005)(478600001)(966005)(85182001)(110136005)(33656002)(316002)(122000001)(52536014)(8936002)(55016003)(53546011)(54906003)(76116006)(66476007)(4326008)(66946007)(8676002)(66556008)(66446008)(64756008)(41300700001)(83380400001)(5660300002)(38070700005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?amN2NHlDQWxqbjZ0aHNma1VxeHl3Z0Vkajc0RGxpb3RmOHY3a1VuNFFKT2xG?=
 =?utf-8?B?MnpPbi9sQ1lPVEpXWDYrQjdOWVIwdGR4Y3dVbTlZaW1XREFBNDZObllMV0gw?=
 =?utf-8?B?MGF1enJpazl4bG4wRVlHUWZ5VHlLbVg2YVB0OE0zQXIrSmdhZlo4L2JqZDYy?=
 =?utf-8?B?c0Y1eXJncHMrV2JjeG1LTlVzcElEckttK1hYa1AzOUQyaWxodTU2WkZyUHhH?=
 =?utf-8?B?OEhldVQ5bE5GWHhndmd6enpMQmE4b1FVcVZiTm9BTHRFaWdKU1FZd2doNzAr?=
 =?utf-8?B?bFU1MTd1R0YwZ3RpS3RVeHp0UlpTTmtUdFdKK0NBQ2E2dzdyVWZNRkdwZGJw?=
 =?utf-8?B?Ujkwbmp5QXFSRnhoTnBsc2F5aTc3WUJhVVc0UzdDOGE1OThZVGNHZGkyTmdr?=
 =?utf-8?B?dU9JTVVWT2J5QVNocHJLaVgyMitqYXNWQzVLT24zekRiS3ZuZkdOZlNnd2ov?=
 =?utf-8?B?SWEwSFlFUFNXUVNyVDVRL2xKc1V0RnJzM1I1WHNEaVlJZFB6eWlaV3VyVUdX?=
 =?utf-8?B?SnhSZEJRaWtrQlhndlp0Z1BMZTJSYkNtODFhY2d3NlJNU0tkK0ZXZ0JrckZV?=
 =?utf-8?B?aThReGdHMURrM1JtdG5jZG1yNFRuNU8wa1VoLzhwQ3dSd0VOaE5lZDB3b21D?=
 =?utf-8?B?VFRNaFVTUFh1aEM3cm96RFovYzNBWHN0QkowTXExZS9rRmN2KzlVWWV0N0xK?=
 =?utf-8?B?N21FTjNCc3RDZmpNOUZLTVNGTUg2Nmh3UmhjNC8wOHBDQjR3TjYxMlJuVjh2?=
 =?utf-8?B?TWcwd1Q3Z1Mzb1FEWEc1TTI4OS9ENGY3ZHRNMGtHUlVnM1RzblZ0RDg2Zis0?=
 =?utf-8?B?bms4YlRJU3MrRXFidEtjMDVicmRZWWhPak9lenpqaGJjb3FheDVUdEhaLytH?=
 =?utf-8?B?WXVmKzJ3dGxEZkMxVSs0QXFYczdoTWs4SkhBbDhoamsrcEMzbERHZE1qTXEz?=
 =?utf-8?B?RHZGU1kvM3ZoWlVvOXVWUGo2Unc3OWhqdFM1bDVNTEFtNnIrU2JBTW5GeWFC?=
 =?utf-8?B?ZkFIMGtuQXlKK1poU3NzbGUrS0VxZjNKWkpJTS82eFdiejliWkI5VzVKZzVq?=
 =?utf-8?B?UlJuSlpqcjdyMk1BZjBQWlBDcTY5eHllcmpZdmw1VEFwWTE4aUJDNVFQOTg2?=
 =?utf-8?B?Qld3cHFkeHQ4SHYyTm9OL25MRjZXc2lIaCtDRGh6S0g3TU90V2xjTTAyeWZB?=
 =?utf-8?B?WHFteWFyTitjcXlWcXBINmtlMHAxWGRHWU53MTJhV09rS0FDa05XcUJ0NEFD?=
 =?utf-8?B?aVkwbklCb1FTWUVLbjZZZ0NYZnVtcjhNMWxrUHNOZkpXcGdjUndlSWw0b0ZB?=
 =?utf-8?B?cnNrQ3Y2d1o4Y1FxRitJT2M2V0xuanVoNVJXSlF6akNsYWtuZkZYMzhmWUlY?=
 =?utf-8?B?TGh6RHVzcGRJY0RsSk1Nanl4TEFJYmpJcG54R0xZcjlVbGFoakQzUzdGTCt1?=
 =?utf-8?B?V0RpTnZIY2FaUXJhNDZrcnUrRy83YTdJTURleko1VU53LzZjTmxUbm4wdW9w?=
 =?utf-8?B?cXRIeFk3bDhobXFvTmZVa2U3UnZFajVWUkRvWUtRVWlCNVp2Mnd1dm02bUlu?=
 =?utf-8?B?MUl6c25mL0VZdlFUMFFBbXdmSjNxZEZVRlk4a1RhYU9teUdENEJZc1NjUHpJ?=
 =?utf-8?B?MFRBTGpKbHZoQTRQRDNiaGQ0ak9ta1FEdi9pUUszbzRhTnBUTm8yNERtWVF3?=
 =?utf-8?B?L0g2dktVRFNSUGR6VUJYay9HOFk2VEYrVWNjWU9Vc2hoNHFZZ3lxdENoRnBz?=
 =?utf-8?B?RDhYbVdOV0JlUzhlRTkzSnVsRWd2QlZpMlluV3FTaFpWZko1dnVRdjhLYy8z?=
 =?utf-8?B?cFB5MCsyTkszSXFPM2xRUklRMHp6STV6elZKQWtRK0d0RXRXTVRxTkxQaHJJ?=
 =?utf-8?B?alpCSCtYS3FhN3hLTy9WZXJrcFF4VHErZkdSVk9LK0xpVzFwQVpUVFlMUUJk?=
 =?utf-8?B?ZFNGeXNvQ3NWd0lPUG10Q0pPQ2NFd1AzY2RTbEVhS1laYks3TmYzZkllekx5?=
 =?utf-8?B?SnlmbHdtdWg2MlRPUnk4cThHemR3ZlhWVUcyNWNpRUpjTDFCM3dWaTFsVVRY?=
 =?utf-8?B?N3kvL1F3S1BlS1RGZFZEMDhnWFJGZ0twMUY2dmIwcklaUWhqbHd2d0NjVmpG?=
 =?utf-8?B?VmF5TkFiOWVvRTdwTjhHTkhnQ3c2UnIzUjdmRXI0bXQ0RzFTRmtMUWFqQXRn?=
 =?utf-8?B?MHc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB8455.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aeddb87c-869d-433a-dacf-08dae17d6b85
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Dec 2022 04:56:41.6973
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MhUgE4WqkpCFLlSr2+tRIY+Ejc46DwNmRId/G2qdi4gdKk7H4ruhY++Ao1psNFctYS0rT2A2F5QHgsoJOHmzoKmqa3gI765cxfsI3hu+EwQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB9823
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,SPF_HELO_PASS,SPF_NONE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

T24gU2F0LCBEZWMgMTcsIDIwMjIgNzoxMCBQTSBMaSwgWmhpamlhbiB3cm90ZToNCj4gDQo+IA0K
PiANCj4gT24gMTUvMTIvMjAyMiAxODoxNCwgRGFpc3VrZSBNYXRzdWRhIHdyb3RlOg0KPiA+IElm
IHlvdSBjcmVhdGUgTVJzIG1vcmUgdGhhbiAweDEwMDAwIHRpbWVzIGFmdGVyIGxvYWRpbmcgdGhl
IG1vZHVsZSwNCj4gPiByZXNwb25kZXIgc3RhcnRzIHRvIHJlcGx5IE5BS3MgZm9yIFJETUEvQXRv
bWljIG9wZXJhdGlvbnMgYmVjYXVzZSBvZiBya2V5DQo+ID4gdmlvbGF0aW9uIGRldGVjdGVkIGlu
IGNoZWNrX3JrZXkoKS4gVGhlIHJvb3QgY2F1c2UgaXMgdGhhdCBya2V5cyBhcmUNCj4gPiBpbmNy
ZW1lbnRlZCBlYWNoIHRpbWUgYSBuZXcgTVIgaXMgY3JlYXRlZCBhbmQgdGhlIHZhbHVlIG92ZXJm
bG93cyBpbnRvIHRoZQ0KPiA+IHJhbmdlIHJlc2VydmVkIGZvciBNV3MuDQo+ID4NCj4gPiBGaXhl
czogMDk5NGExYmNkNWY3ICgiUkRNQS9yeGU6IEJ1bXAgdXAgZGVmYXVsdCBtYXhpbXVtIHZhbHVl
cyB1c2VkIHZpYSB1dmVyYnMiKQ0KPiA+IFNpZ25lZC1vZmYtYnk6IERhaXN1a2UgTWF0c3VkYSA8
bWF0c3VkYS1kYWlzdWtlQGZ1aml0c3UuY29tPg0KPiA+IC0tLQ0KPiA+ICAgZHJpdmVycy9pbmZp
bmliYW5kL3N3L3J4ZS9yeGVfcGFyYW0uaCB8IDggKysrKy0tLS0NCj4gPiAgIDEgZmlsZSBjaGFu
Z2VkLCA0IGluc2VydGlvbnMoKyksIDQgZGVsZXRpb25zKC0pDQo+ID4NCj4gPiBkaWZmIC0tZ2l0
IGEvZHJpdmVycy9pbmZpbmliYW5kL3N3L3J4ZS9yeGVfcGFyYW0uaCBiL2RyaXZlcnMvaW5maW5p
YmFuZC9zdy9yeGUvcnhlX3BhcmFtLmgNCj4gPiBpbmRleCBhNzU0ZmM5MDJlM2QuLmEzZDMxYmQ0
NTg5NSAxMDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJzL2luZmluaWJhbmQvc3cvcnhlL3J4ZV9wYXJh
bS5oDQo+ID4gKysrIGIvZHJpdmVycy9pbmZpbmliYW5kL3N3L3J4ZS9yeGVfcGFyYW0uaA0KPiA+
IEBAIC05OCwxMCArOTgsMTAgQEAgZW51bSByeGVfZGV2aWNlX3BhcmFtIHsNCj4gPiAgIAlSWEVf
TUFYX1NSUQkJCT0gREVGQVVMVF9NQVhfVkFMVUUgLSBSWEVfTUlOX1NSUV9JTkRFWCwNCj4gPg0K
PiA+ICAgCVJYRV9NSU5fTVJfSU5ERVgJCT0gMHgwMDAwMDAwMSwNCj4gPiAtCVJYRV9NQVhfTVJf
SU5ERVgJCT0gREVGQVVMVF9NQVhfVkFMVUUsDQo+ID4gLQlSWEVfTUFYX01SCQkJPSBERUZBVUxU
X01BWF9WQUxVRSAtIFJYRV9NSU5fTVJfSU5ERVgsDQo+ID4gLQlSWEVfTUlOX01XX0lOREVYCQk9
IDB4MDAwMTAwMDEsDQo+ID4gLQlSWEVfTUFYX01XX0lOREVYCQk9IDB4MDAwMjAwMDAsDQo+ID4g
KwlSWEVfTUFYX01SX0lOREVYCQk9IERFRkFVTFRfTUFYX1ZBTFVFID4+IDEsDQo+ID4gKwlSWEVf
TUFYX01SCQkJPSAweDAwMDAxMDAwLA0KPiANCj4gTWF5IGkga25vdyB3aHkgdGhlIFJYRV9NQVhf
TVIgaXNuJ3QgKFJYRV9NQVhfTVJfSU5ERVggLSBSWEVfTUlOX01SX0lOREVYKQ0KPiAweDAwMDAx
MDAwIGlzIG11Y2ggbGVzcyB0aGFuIHByZXZpb3VzIHZhbHVlDQoNCkkganVzdCB0aG91Z2h0IG5v
Ym9keSB3aWxsIHVzZSB0aGF0IG1hbnkgTVJzIGF0IHRoZSBzYW1lIHRpbWUsIHNvIEkgbWFkZSBp
dCANCnRha2UgYWZ0ZXIgUlhFX01BWF9NVywgYnV0IEkgc2VlIHRoZXJlIHdhcyBhIHJlYXNvbiB0
byBtYWtlIHRoaXMgbGFyZ2UuDQpDZi4gaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvYWxsLzIwMjEw
OTI3MTkxOTA3LkdBMTU4MjA5N0BudmlkaWEuY29tLw0KDQpJIHNoYWxsIGNoYW5nZSB0aGlzIGFu
ZCBzdWJtaXQgdjIuIFBlcmhhcHMsIEkgc2hvdWxkIGFsc28gY2hhbmdlIFJYRV9NQVhfTVcuDQoN
CkRhaXN1a2UNCg0KPiANCj4gDQo+IA0KPiANCj4gPiArCVJYRV9NSU5fTVdfSU5ERVgJCT0gKERF
RkFVTFRfTUFYX1ZBTFVFID4+IDEpICsgMSwNCj4gPiArCVJYRV9NQVhfTVdfSU5ERVgJCT0gREVG
QVVMVF9NQVhfVkFMVUUsDQo+ID4gICAJUlhFX01BWF9NVwkJCT0gMHgwMDAwMTAwMCwNCj4gPg0K
PiA+ICAgCVJYRV9NQVhfUEtUX1BFUl9BQ0sJCT0gNjQsDQo=
