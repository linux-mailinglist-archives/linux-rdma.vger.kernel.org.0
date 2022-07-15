Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1142575A11
	for <lists+linux-rdma@lfdr.de>; Fri, 15 Jul 2022 05:46:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231608AbiGODqp (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 14 Jul 2022 23:46:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbiGODqo (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 14 Jul 2022 23:46:44 -0400
Received: from esa12.fujitsucc.c3s2.iphmx.com (esa12.fujitsucc.c3s2.iphmx.com [216.71.156.125])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6AAB774A8
        for <linux-rdma@vger.kernel.org>; Thu, 14 Jul 2022 20:46:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1657856802; x=1689392802;
  h=from:to:cc:subject:date:message-id:
   content-transfer-encoding:mime-version;
  bh=vKq4ckJSstSfkI/yXjDtzPZTup+Tn+fU0LBMRa4/wNs=;
  b=JKf6nPxMIdxhK+OMuAhFA72Nq0ekEg9k1gNcTXMDLrP3kweGPhYPYPNz
   unTrppDfVY9UAW+LWe0JurXeGdkX3pqqW9W2oYKNcfaNcTVS3lnDEk6VM
   n7e9gfvMDVBWsB9u0RlFkm+QOQ1TKyYxsmrsXOMcJPHP9sE3wilDrQxEs
   F6B6xLfdbDdtH7jpDF67pK5RFmunMCKpLh5o9Yc1vMvp0kDea2IYbWlsI
   efY8kmL+MDy34ZXRHmuXTPKVHOrn5dp11VCdLIWyiUCg82GVq+Y3qCLKG
   JsNCugbpdWvCYQ3MPnjHYXKiWS9dW+gYgqKxLbqZHILbEQfgwlnECDJ+7
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10408"; a="60594113"
X-IronPort-AV: E=Sophos;i="5.92,272,1650898800"; 
   d="scan'208";a="60594113"
Received: from mail-os0jpn01lp2104.outbound.protection.outlook.com (HELO JPN01-OS0-obe.outbound.protection.outlook.com) ([104.47.23.104])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jul 2022 12:46:39 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i2kuL2xK+1FQHoqKOIDzlmDP+cIxeZh60+jHCOxWWvtBdJCYV3Jf1v/tnF38Qf5LaBCHZYfPmZp0SfmgE2WmZjhUBiAdPO38zoXmlqPri20/HxsyvJIjE+6n/XSRNfrYU7euoE8o7KNJwWIgPQbMMl5uz+F+POwJtrJa8XOcY6o+zyH4hB8iUOB4OGtZ3qMlqIz0megFT4TEnc98IPYgBxQyLkHKJFCVLmxpD/DWCcproLTlqlO0VS1TfUjChOHuTGlmJnl0IsCGEr9G4QmmoNy9+PkYUZjgIUygxZ1JsAOvs5dZ9UflmfQzLYHVk+Ic00xXAmF/nIyn52BxJXzyAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vKq4ckJSstSfkI/yXjDtzPZTup+Tn+fU0LBMRa4/wNs=;
 b=f9ZBKS3RBg/hqhrsZ6+A4bWpFgndKghSREpROn4oAILmV+7+cTrDyqMeoIrOPu6SRuaWFZ0wJg+mpVFKaxx9ezQ7M+x+S1Kp4j0BhT8MiM4FV8WWGNOG/6ShhCX22B5KbOFHKboRI4az06PgoKRn/p0vBMk0CHstp+cH1OXEp7BRCmb6wD6WMSX4qAu413h+jgYQZJEIRCyjPPBCbZ8myNpj4Yuy3151n/shsVjUbsh+NeLdHX+tJdF+TkcGoix/gKfpcOazC4qnq0XUzC8y72axMCLaGyg00uFrKFARkSzOXHCBpap4d7kJiOdyD0jJApRiHrr/MFjoZ94VGrUTfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vKq4ckJSstSfkI/yXjDtzPZTup+Tn+fU0LBMRa4/wNs=;
 b=JwP0MJGH/L1GiVX77RvE5AuKjaJxr1nFYZqMbWY7JGGcRKE2lVJar4nc7ulIRHNDFkt+eklhksk2dcyi9rvJg64Voo+X9GYifqw52/2c7tk0GOKcEnMgLnhHchFf7Tp9CjB6ZdvQqPnqMJkKgJm7xHzwFEM2OBQtKc3D2IuCZHY=
Received: from TYCPR01MB9305.jpnprd01.prod.outlook.com (2603:1096:400:196::10)
 by TYWPR01MB9573.jpnprd01.prod.outlook.com (2603:1096:400:1a7::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.12; Fri, 15 Jul
 2022 03:46:36 +0000
Received: from TYCPR01MB9305.jpnprd01.prod.outlook.com
 ([fe80::8d7a:baa8:3b18:cd93]) by TYCPR01MB9305.jpnprd01.prod.outlook.com
 ([fe80::8d7a:baa8:3b18:cd93%7]) with mapi id 15.20.5438.014; Fri, 15 Jul 2022
 03:46:36 +0000
From:   "lizhijian@fujitsu.com" <lizhijian@fujitsu.com>
To:     Yanjun Zhu <yanjun.zhu@linux.dev>, Jason Gunthorpe <jgg@ziepe.ca>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
CC:     Bob Pearson <rpearsonhpe@gmail.com>,
        "lizhijian@fujitsu.com" <lizhijian@fujitsu.com>
Subject: [PATCH for-next v2] RDMA/rxe: Remove unused mask parameter
Thread-Topic: [PATCH for-next v2] RDMA/rxe: Remove unused mask parameter
Thread-Index: AQHYl/17r+sfayDH7kuDmDHnivSfgQ==
Date:   Fri, 15 Jul 2022 03:46:36 +0000
Message-ID: <20220715035340.1900168-1-lizhijian@fujitsu.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.31.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9b95d377-8ce0-4d82-fd90-08da66149e4d
x-ms-traffictypediagnostic: TYWPR01MB9573:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 8POp61L0BECFgAgU2Qae6un6dtbDCzcYfWrUSkdSaa0Mj0OtWAo1P/e6/3hFHNtxhasjziV/K7dWYxn+sW6ObduUwRLjVKgZrS/aE6jGQ+7YWolsuxw0KO4DxNTQu0lFDtCw62ZqxdmkYfGP4hB4pTc0qghdtMvbvohheyox79BCPsMb1BiKbSIJGGfpmTE8RRmEEWJ4VobnvDP/8m86ahf4xkfynX3zC1dwDUcluhj+rGaHiRPNz+uWLAE8XIZoDAfq/Ke+kdDTYxX2WiWrOQ1S9EMcv9GMfiDK2Ddy1UjsYwNZxgmejPbyu72/y7Pkz1L/4KWLVpA7WRhgEJZdEIbQimK+bFzOCmdS5UFDyFvL0DgxRBwvjo7hbnLxcbWgMVnDP577JvO3/bD7Mw49vz0KoxdRfm/Yvkbg1apNquHtlvExPvaoZnEUhQsgCpvFBZc5JHhFFOp+EOZZ/NUVdVCtYgIMAlIGuO7A4n+ZcTDviJm04Yob+HpuIzTpjt8ydgnUytRI1QLcesUkMVLmEWQidH+p0YjiF91L04IJIJD4D1aGkapNwnAeEk60SaYYSGyoG4OTYL46oSueTh37InXHIAkO0unhzQCLDJ7Uy5LtUupYnKXQm5YoorkAFdOtB0pmNlENUVC5NV2YwHne42oSsdYj2HgPf5a4axas0uxQU/+t+rTvG5qPuxdhBI//0UxlW9T+EyoTulKICWgvitbDyESAOIKgrtI80OCY6HK8WHPiygMzPAzORfW1EcbAsyVUhbieYzLlShCrQ96mG2yJ6x65gLg2e4aCM5LHfNSudia8s3yacdpqcMAFX9fD
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB9305.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(346002)(376002)(366004)(396003)(136003)(38070700005)(110136005)(122000001)(54906003)(2906002)(316002)(83380400001)(85182001)(6512007)(6506007)(66476007)(6486002)(71200400001)(76116006)(186003)(66946007)(66556008)(66446008)(64756008)(38100700002)(91956017)(26005)(8676002)(82960400001)(36756003)(4326008)(478600001)(1076003)(5660300002)(8936002)(2616005)(41300700001)(107886003)(86362001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?NHl5QnQxalQ1cjMyKzZuV0JjdVlZR1lwejZJUzFxbGtXc2xpN0tCbnBtdTF3?=
 =?gb2312?B?SjVRelp4MlVOR3ZYRzhZOHVKSWR0aXVPa0YvOFRocHFpN1l0V24xaUhGdldp?=
 =?gb2312?B?WlVPdnVtckFwZ3dONkxWaVVkZElCWnc4TVZwdTBJaXJmL3V0aGpod1R5L3NF?=
 =?gb2312?B?VENIdkx0WXhsOTg5cEszcDFUZG9tNytxRXVvYWRsZkdwQk5YZ3k5eERHdTVG?=
 =?gb2312?B?aW05Z2hSTzBES1I2N3V2cDQ3NDd3STIrMStORGlHQk9jN21XQnh3ZURNTzB4?=
 =?gb2312?B?UVZWVUVyQlNNbWdrRk5ZY3YyV0xPL3YwT0ljWGYyOU1wL0RtUVBiZDRmL2Rm?=
 =?gb2312?B?SFJTTVY0VTVmNjVtSlRVa0hKSC9IbG9ZbzFTMWV0V25tQ0Naam1UU1QrNmpn?=
 =?gb2312?B?eHFKK0t5RjJ0cnMwT3ZKajdUMmIydUlSSDJob3Q4OVl1Tm5ZQVdyYkJXOXpW?=
 =?gb2312?B?azA0NTB5QndlVzJCblgxa2ZJYjhYelh6MTRoUUxyb3dnMWNXQkphaWozYnZ5?=
 =?gb2312?B?RnNRQmhsQmJQcGtXY3FTWDJrMnE4Mk1WNkk5N2pEUkxzbjlhMms2RFAxd2pZ?=
 =?gb2312?B?azZaa2FFUVppMHh5VTZNNnBWbkpXMiswdERrb2E3cVBrWTNCcHJQVCtUZVJY?=
 =?gb2312?B?Q0RNSk5qVGhVbkhoYkJhUEFaS3NvcU1MOXFZbUVjQW0yRCtKMDk0eHBpc2R1?=
 =?gb2312?B?Sm9VYUwyZzd6aFBUSDQ5eElXT3pSNDROQkxKM1lRZGwrSFN3UkVIczFZYnJJ?=
 =?gb2312?B?KzFNN3lMR1VCTUtEWEZ1TXZoNXFsanhlcjU2VTlsaS8zMzFjSFhoTk5GQ2hu?=
 =?gb2312?B?Y0gxN1VlMXJxRUs3VXJ1amNJcmUwdTVNMG9ZSllpYXE0b2p5Nnd6TUhWNjdX?=
 =?gb2312?B?S2loc3JVTmkrSHVKYlQ4RHJhNk04MTJsVzllVlRBbUs3TkRoYnRDT2I3REdz?=
 =?gb2312?B?SlpVZHpPdUlGN1R3T2g1MWsxQ2J3bENHWEhqWnJyY0paa0hZR0cyZGlISmpN?=
 =?gb2312?B?bnExYmtyTk5KRUp6TDlicm1YTWxxSUgxNmI2aUNtOTJaUVBJeGZPYldQZUdI?=
 =?gb2312?B?Z0lhbWl3akgyQ3M0YlRhYXVIdWF2ZmZsbXh6VWlnNjhUaUgyM0VyZlR6d3Zq?=
 =?gb2312?B?TlZtSmVOaDlLVUxzMTdYYW85WmtaMXpwZEJrQjdIK0t2cm9mZGJCUzlrdnNE?=
 =?gb2312?B?MEhSNFBxRVdxRmx2bTU0clVwdi9VR0FqcVJrNUFqSVBGOE9icnN3U1lNSzU3?=
 =?gb2312?B?Z0N5MDlyZGNuaHZ1RFJFS0NpRE92WG5wV2VqT0pNZks3R2xBdnI2UEZMQkh1?=
 =?gb2312?B?QVdIV0Jadi9iN3dIWWxlZ00wK05KamdEaXRiZ09keklCcURVaWRUSm9vMnBV?=
 =?gb2312?B?UTBobld4WisyVzNHOENQYnVkemlvVDI4Q2RGVkQ1TlFEdXl0VjV0SmdrSkIx?=
 =?gb2312?B?QnoxRThNV0hGWERRY3dsbUtXSDZwdDMyeDZNbUdnRWxZU0l2ZFBqUmc3Y0Rn?=
 =?gb2312?B?eWhiTk1zMmNEemE3c1VqVDA4TUdIa0hVL29XUzNGS2VvTjVDRzVLektmOEhm?=
 =?gb2312?B?akpNWGZTZWpDMFVkVkJmS3NpVmIwbVpWWUNmZFhzZEFsZG5oTkZaTjZDN09r?=
 =?gb2312?B?MjFEeDc2MHlTQzZkb0NxbFMyNS8wdm0yYnZ0UTh3dDRBdXAxZ2xwekZoVEJl?=
 =?gb2312?B?aVRPbDg1UzlHWW5ZdDljRXNRbGlXMWlsT3c5MzlPWmxZODZHRmp1R3MybmVt?=
 =?gb2312?B?b1RsRWZBRUlqTDRmc1BFbmc2NnVCN2ZiUHpYeDFNYzlBejIxdFZHMTVFOEs3?=
 =?gb2312?B?aFhQYWt0bGZlNjZGSkpNUUE0NW1GeWFMNlY4V2FrazE2SWxWMDRJVnFRK2hE?=
 =?gb2312?B?KzlDMXl3NWVCQWZ0VFhBNlcyK0hhSHNSVlgxdUU1V1RiTVcza2J6ZGcvbW1h?=
 =?gb2312?B?OVhmRUhPeXpYeUIyNW14eTBiZDYyK0VTSnZkNk5Oc0paYU1RdW5oTHV2R092?=
 =?gb2312?B?VmpQSTZLN3I2akxSS09HVHBEajNqdHpoaTJYWmE4QzgwK1huT0t6QVk0aDcw?=
 =?gb2312?B?eWNSQW5ncVVHakRYWnlNekx2aHBDSXNVQkkzcWswamlNYkJqU0hRMmx5bVhG?=
 =?gb2312?B?ZUhld0ZPRDU4WHV2WlliVXFVV1B1elo0bWtBT09DVVRESnN6bFBYczBvT3FK?=
 =?gb2312?B?aGc9PQ==?=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB9305.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b95d377-8ce0-4d82-fd90-08da66149e4d
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jul 2022 03:46:36.7480
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nI3pYje78gmI4quDktMcKmNcBq9oC2pznN2WoJcxvlLPeMiVeTUVYo23aqNN8fuP1AlrsSHuKNPDpYIui0zf6Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB9573
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

VGhpcyBwYXJhbWV0ZXIgaGFkIGJlZWQgZGVwcmVjYXRlZCBzaW5jZSBiZWxvdyBjb21taXQ6DQox
YTcwODViMzQyOTEgKCJSRE1BL3J4ZTogU2tpcCBhZGp1c3RpbmcgcmVtb3RlIGFkZHIgZm9yIHdy
aXRlIGluIHJldHJ5IG9wZXJhdGlvbiIpDQoNClNpZ25lZC1vZmYtYnk6IExpIFpoaWppYW4gPGxp
emhpamlhbkBmdWppdHN1LmNvbT4NCi0tLQ0KRmVlbCBmcmVlIHRvIGFkZCBhYm92ZSBjb21taXQg
dG8gZml4ZXMgdGFnIGlmIG5lZWRlZC4NClYyOiBhZGQgY29tbWl0IGxvZy4NCi0tLQ0KIGRyaXZl
cnMvaW5maW5pYmFuZC9zdy9yeGUvcnhlX3JlcS5jIHwgNSArKy0tLQ0KIDEgZmlsZSBjaGFuZ2Vk
LCAyIGluc2VydGlvbnMoKyksIDMgZGVsZXRpb25zKC0pDQoNCmRpZmYgLS1naXQgYS9kcml2ZXJz
L2luZmluaWJhbmQvc3cvcnhlL3J4ZV9yZXEuYyBiL2RyaXZlcnMvaW5maW5pYmFuZC9zdy9yeGUv
cnhlX3JlcS5jDQppbmRleCA2OWZjMzU0ODVlNjAuLjM1YTI0OTcyNzQzNSAxMDA2NDQNCi0tLSBh
L2RyaXZlcnMvaW5maW5pYmFuZC9zdy9yeGUvcnhlX3JlcS5jDQorKysgYi9kcml2ZXJzL2luZmlu
aWJhbmQvc3cvcnhlL3J4ZV9yZXEuYw0KQEAgLTE1LDggKzE1LDcgQEAgc3RhdGljIGludCBuZXh0
X29wY29kZShzdHJ1Y3QgcnhlX3FwICpxcCwgc3RydWN0IHJ4ZV9zZW5kX3dxZSAqd3FlLA0KIAkJ
ICAgICAgIHUzMiBvcGNvZGUpOw0KIA0KIHN0YXRpYyBpbmxpbmUgdm9pZCByZXRyeV9maXJzdF93
cml0ZV9zZW5kKHN0cnVjdCByeGVfcXAgKnFwLA0KLQkJCQkJICBzdHJ1Y3QgcnhlX3NlbmRfd3Fl
ICp3cWUsDQotCQkJCQkgIHVuc2lnbmVkIGludCBtYXNrLCBpbnQgbnBzbikNCisJCQkJCSAgc3Ry
dWN0IHJ4ZV9zZW5kX3dxZSAqd3FlLCBpbnQgbnBzbikNCiB7DQogCWludCBpOw0KIA0KQEAgLTgz
LDcgKzgyLDcgQEAgc3RhdGljIHZvaWQgcmVxX3JldHJ5KHN0cnVjdCByeGVfcXAgKnFwKQ0KIAkJ
CWlmIChtYXNrICYgV1JfV1JJVEVfT1JfU0VORF9NQVNLKSB7DQogCQkJCW5wc24gPSAocXAtPmNv
bXAucHNuIC0gd3FlLT5maXJzdF9wc24pICYNCiAJCQkJCUJUSF9QU05fTUFTSzsNCi0JCQkJcmV0
cnlfZmlyc3Rfd3JpdGVfc2VuZChxcCwgd3FlLCBtYXNrLCBucHNuKTsNCisJCQkJcmV0cnlfZmly
c3Rfd3JpdGVfc2VuZChxcCwgd3FlLCBucHNuKTsNCiAJCQl9DQogDQogCQkJaWYgKG1hc2sgJiBX
Ul9SRUFEX01BU0spIHsNCi0tIA0KMi4zMS4xDQo=
