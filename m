Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CAFD5A78B2
	for <lists+linux-rdma@lfdr.de>; Wed, 31 Aug 2022 10:16:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229710AbiHaIQj (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 31 Aug 2022 04:16:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229616AbiHaIQi (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 31 Aug 2022 04:16:38 -0400
Received: from esa12.fujitsucc.c3s2.iphmx.com (esa12.fujitsucc.c3s2.iphmx.com [216.71.156.125])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D4517CB53;
        Wed, 31 Aug 2022 01:16:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1661933797; x=1693469797;
  h=from:to:cc:subject:date:message-id:
   content-transfer-encoding:mime-version;
  bh=079trhfMbcr2i+jlp/rj5cMAvGuWeQpO5MzCFJWNpc8=;
  b=GdJY7ffBOLMy/YofFMTmkq2pnNSDvlvN7rhHOpZNVRzPECR025iJ+MFj
   diPu93wyfgMkJBMPs8yRZm/FfORJFgu0cte1uA1QFvydGfOc529/ZSgop
   OBND/DdxCE2R2hX+3+wYRqron4MY4xD2O76kiurr8xT5/oU3dUOJOfBat
   YmA1yiY0aSXsmmm9jZmB4Y52FxX1A+t/BYSl9SnMNueEEXF9tJihscs6m
   Ak7izYkRvIhtys1R7x6XH7F9RdT5uuR57dMxGu02Pk3ktPS5KjyiafAML
   QGSPpOrtNxE8snvLp/K7S9WkZbeGnYJ8cHbcE5QcI0KZOBNkDRtS2tuTK
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10455"; a="64140224"
X-IronPort-AV: E=Sophos;i="5.93,277,1654527600"; 
   d="scan'208";a="64140224"
Received: from mail-os0jpn01lp2108.outbound.protection.outlook.com (HELO JPN01-OS0-obe.outbound.protection.outlook.com) ([104.47.23.108])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2022 17:16:33 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kANDmP2M4//oPnk8S4S1gkjfstG+IGDCZAcbj6+mqR6Gjt9Q3FizOzXFYtWbEioGC/8qasQfjaYW880us6lqq+xknRND2D6rl5NOHMVNi4jogkD5p/sAu71uXH2GYMVHP73DFhPPUbAGS87SwYkeJW1jU4ZvAzqIvMFFPsJnDBWA93Hr5XQ6TpVlmMiDa9bK25uQ2GWVnvd3EjD6RI8fd58Hpz1RTKf6VG5GDlyT+gcD6oscGtDswqWwwOQ7YAiYscAzw94Kv+sUUSUInXHb0tn8gWDjmkZ3+1Rvw4DTBCeXGauZ2m3hRhuLZUM77SP3/01jUUJE7swFnuzB889FsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=079trhfMbcr2i+jlp/rj5cMAvGuWeQpO5MzCFJWNpc8=;
 b=YTxBhM3tmOhZdad//5an3QnDNv+kLhUPuMHrTmRs3SdvhhgmeKGxBZrgxs1U839YXUHbHjWde8jCrZrKV8LZ5j67+IEhHWYlArrJJQV8urQddUiIb7js5nZmwvvlnqvU0GerxJe5h1VsEyiTpDGBxkdsZrti8C4Y2Y2AvYJ3H7Uk3wZ1se+iUqzAFs48c7qvkd04CEYMgYth8tqakhO403A7ZRGlSyVuww8Sszq78u3pbLHFAVYLiWgnUbjg/IyjWw9qqvMc/+m2+VbEpqcWKyBHa6Nv60Sqpv0BWskKt9GqCRsguLiIP6FR7lXXqU1pc20UQ9yONR9kXvIGEv0bIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from OS3PR01MB9499.jpnprd01.prod.outlook.com (2603:1096:604:1c8::5)
 by TYCPR01MB9465.jpnprd01.prod.outlook.com (2603:1096:400:199::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.15; Wed, 31 Aug
 2022 08:16:30 +0000
Received: from OS3PR01MB9499.jpnprd01.prod.outlook.com
 ([fe80::9d81:6e2:6f1:e08e]) by OS3PR01MB9499.jpnprd01.prod.outlook.com
 ([fe80::9d81:6e2:6f1:e08e%8]) with mapi id 15.20.5588.010; Wed, 31 Aug 2022
 08:16:30 +0000
From:   "yangx.jy@fujitsu.com" <yangx.jy@fujitsu.com>
To:     "bvanassche@acm.org" <bvanassche@acm.org>,
        "jgg@nvidia.com" <jgg@nvidia.com>,
        "leon@kernel.org" <leon@kernel.org>
CC:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "lizhijian@fujitsu.com" <lizhijian@fujitsu.com>,
        "yangx.jy@fujitsu.com" <yangx.jy@fujitsu.com>
Subject: [PATCH v2] RDMA/srp: Set scmnd->result only when scmnd is not NULL
Thread-Topic: [PATCH v2] RDMA/srp: Set scmnd->result only when scmnd is not
 NULL
Thread-Index: AQHYvRH5uRIv+1zFNk2EIbUJMkAGyg==
Date:   Wed, 31 Aug 2022 08:16:29 +0000
Message-ID: <20220831081626.18712-1-yangx.jy@fujitsu.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.34.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f8e359ef-4234-4830-20af-08da8b291ba0
x-ms-traffictypediagnostic: TYCPR01MB9465:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: bgO69SX0MUVk94hTJ+CQ9Mj0Le/VBOwkeEf3HjnYI8wJNKZIqWab1YiEjyPAwq996HAR5CLMdmtnB3tekJ8fLFkEbw/NVYjVoGDGf/pLEHIm7Us4agtYWMW4EVJ3xcI3hMWvOzHvk2HG6AYqmwrVuGgQTBBybzIAnIqZiDUzAPkP5DRVed/sbyOEZIm2Hdr/g7i0yax+3fPViOzi/FWyzDKnKICfv4oxD7ZpXQ5EREDtzlrro/ERr7NYsYrDA5DPcUk1VPorLv1QXopXZMVlgwlWc2GsNCAMcrwHtDPxStulnPPN2QZK1b2Y32dsvBBKGMyH1Cqj4dl9190OMZwrHUtkeEyGkH+E3pUH9rm4U6vH+w/WskjuAXtTri7g6hDKRLrtc/Y5of79ailokm8NNOESBFJHiM0XtMmZxcERIaE6IqUUV79mUPa+UN+EwjBAygOVc10iNIPGR0P9XM1Pi7I0HUXJAXz9/fWwqmjpFNoPBS+OEnlmenQEP/Tpc7bg49ZkPHEwQz+Bc/vaK0JGBvmi+4B3q4uIl1nZIZgZ5d1Jh6ftsuxdRBzFgowifOtCygTU9sW3UBYggVhGU/OT6OKkV+YElWpdWjdchh9tbKeLjM+IUvPKEzEnuzdxvSt03eQVxeAN5M2eyJvMhMFmAuuw87kAEJtoOM7JxgioVArCV3Ljjcj0ZP2Pcdo14ZKfAtiZcinWAyqSViBvBE2gRpx7z5VDbM/A8PunqdX/A18FBlm2MWyymbfhnuL4b0eKvO2Vk68RXw8vh33jGb90ygbWkquxfOPF7m2NYLvVNyo=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS3PR01MB9499.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(376002)(396003)(346002)(39860400002)(366004)(136003)(1590799006)(2616005)(110136005)(64756008)(91956017)(66556008)(66946007)(2906002)(66446008)(107886003)(8676002)(6486002)(6506007)(54906003)(4326008)(66476007)(76116006)(36756003)(71200400001)(1580799003)(85182001)(186003)(83380400001)(1076003)(316002)(122000001)(82960400001)(38100700002)(26005)(478600001)(86362001)(38070700005)(8936002)(6512007)(41300700001)(5660300002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?VUZoeitaOGxCcWFlSXduKzBwVksrWnNyOHUzV3NlSzRjT2pPcmpIN1RrcHJj?=
 =?gb2312?B?Y1Mxc0grZm8yZXd0ZUZ2czNRL0RDYkxOTTI3eSs2d28xTVFBTStKK3JkcUdn?=
 =?gb2312?B?dzRMMzZaNGI4SHVzcWNSK2VRZHJCNnVOemVLNEhsUEpsdVliTVJUU1NjQkFk?=
 =?gb2312?B?VDhTdnR2VnptWGlSdVdrWGZ6SDZSRkhMQ0pjVS9DdHZnZ2xGbnU1Y0taVGph?=
 =?gb2312?B?VDc1YkllMEptU0ttT3BibUQ4aXljeXpDQmdTdnkzdkowYndVRUlCbzJNZWk5?=
 =?gb2312?B?S0Y5UmF0MmMzU3NTejdFeDdibnc0Umt3bThKWVQwSnlPRGVwditFWm1HSUZG?=
 =?gb2312?B?ZWNVOXVJdURZbzFPQUxZWm9VenhqMzR6V0Jucnkrd3BVTytEZXFHQ0ZWSG1m?=
 =?gb2312?B?R1FzNlA4TkZCRGhRZmk2OGVwN3pmSnNlb1dUbWhCV2NWVm16QXFZVmxsY3Jp?=
 =?gb2312?B?ai9UVHdIOG1QL05ocC91aVQrQk53TDVHbmpPd3BNMVM1TEhhSHlLT3JxM2RI?=
 =?gb2312?B?OEphWVhBQ3dtc3R6SE9ZTTV1OWxwQnBGNzFXamtnTjNESmVIWmRYQlhBMWZD?=
 =?gb2312?B?Y2l2eTF6enU5czlMcjZON3p0Rkl0ZDdUNmZxdjZ4QlZLTkpVcjAzQ0RKdmkz?=
 =?gb2312?B?MlNkU3BLVitGUXQzYWlnNXhJQ25ZakN0QTgxNUo4MVhZRnk5TDdEZE00cDhP?=
 =?gb2312?B?S3dNbS9rOE9DNnVqYXRPUFdJNUpTU1BGSlNOZ3pWdTBJU1VuUkppZXFnK1pB?=
 =?gb2312?B?TWZiZ0ZuUUZkZUlvQk9ZbTZwOHkyOFEvWEJoS20vZ2xIUWpuTnFYb0hBcWdD?=
 =?gb2312?B?NzZoSWZyKzFuNkZpUWJIdlVrMUZXcGpTV3dIOUxoRk93djlVLy9oZ2ErUFln?=
 =?gb2312?B?MFozRUYzR0NWSUszTmY3U2lHRys1b1U4aVJNYjBWMXhjYTh2L1R6cUxZK2xi?=
 =?gb2312?B?bDIraHM4aW9XbE5mN1VTRVdSNldCOGVUdmY4TzBFNHJPTkVNVWNVTmd6RU0x?=
 =?gb2312?B?K2tLb2N1ck0vRHRORGlFQXY4cTFEUDhVV01ZYWkyb2Z2RGUySUhRdU12Yzlt?=
 =?gb2312?B?ZW14eFJrVDMvL05tcVZjSytYMDVEaTk0eXRBNlozOGxIVVcrcWNiSi9rdUlZ?=
 =?gb2312?B?S0pFY0E1dG9BZ3pLbFl5Z1lqRW5zN0VRVHFxUDJqS3pNcjIyZ1hHd0FQalho?=
 =?gb2312?B?VDJrVVl1SFdrbThYVXprZWdCM0c5ZjZqOS9LNFQ1T2ZtTjJzdnZXRkUxQU5v?=
 =?gb2312?B?bW8xSjNNOEZEN0hoVEJ3RWM3MzRxV3VvMEJHczNoUnAxMjQrUlFVa25ZZWtJ?=
 =?gb2312?B?TzRtdFNWWWtZZHcrRFFYaHVia09sc3VhZThCNWF1U0JDNjEzYUlxWlZMKzU1?=
 =?gb2312?B?bkhvalRDYmRSbXh4R3ZjTDlMNUhEcGRnVFAwV1pVRVdZTFc5QjdDM0t4UXhV?=
 =?gb2312?B?OWVjbmRJejZLMk5MQkZ4R202V3dsVHd1YVFreGx3T25YN0tyMkZQWGliT0Zv?=
 =?gb2312?B?SnhWTlRBaDV5MWRvMFRRY20xb21pRklPNkE5OTNudzB4WUxGdlppZy9UV1FM?=
 =?gb2312?B?ZWREWW5hcDNldnUyUnRucWdsczl3S005dlNFYkErTUlrM3BKVFprMGYxU21Q?=
 =?gb2312?B?T2pBNjVKVjA0TnlkVVB1VEFTNE5OUTBKQnBiMXJtOVAreGppMHI5alZucmhy?=
 =?gb2312?B?bnVlWHhYS0JpMmlyVzJRUCtucUovL0t3c293VnphUnJJc0g1TlgxQktBcmlm?=
 =?gb2312?B?dXREQ2Y5LzVNNjA3c29tM05CeGlVQ3Q2N25yMmYya1ZLMERHQlp1bFlwZlps?=
 =?gb2312?B?aktSVWJLSlBBVTNTMDhaUFlWNEVjdk92dWtaWlgxZnNuWWxmL1pRY0VFeFZP?=
 =?gb2312?B?T3FTUytuUUNuUU5aeEMrck5TYnkrbWdEaWh5bUdwajBvdmZEQXZ0UTR2d0Z0?=
 =?gb2312?B?OWl5dnEyREhaWU0zMTJUSlpuRVdYbWJ4T0ZMS2Rpd0FUcGxjU0FwNXd6Njlj?=
 =?gb2312?B?UHd1VkRaR21hNVVydEMwVUZnSlV5ajRSU3Z3VW1oNlRoeU1UM3BMQVovU1Y0?=
 =?gb2312?B?L1g4czdBdW5odUhkRHpTZUplVGMvTmhoRGcyZ1lOUjBkbWkyYmdZTjhoVWRK?=
 =?gb2312?B?UlpFMmpaR1dFZ1hHMGNoMXNJVlc2S2dCRzBMZCtaK21GMmRDK1RvVURON2NH?=
 =?gb2312?B?OFE9PQ==?=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS3PR01MB9499.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f8e359ef-4234-4830-20af-08da8b291ba0
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Aug 2022 08:16:29.9433
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GtWNg9zaXS7GV88vc8VuPow9R8M/MqOxFza41s6CeXvG1V/WJbzaPguGWJP/4V8Ltg9qlnd8DpFcxmbstn6aaQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB9465
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

VGhpcyBjaGFuZ2UgZml4ZXMgdGhlIGZvbGxvd2luZyBrZXJuZWwgTlVMTCBwb2ludGVyIGRlcmVm
ZXJlbmNlDQp3aGljaCBpcyByZXByb2R1Y2VkIGJ5IGJsa3Rlc3RzIHNycC8wMDcgb2NjYXNpb25h
bGx5Lg0KDQpCVUc6IGtlcm5lbCBOVUxMIHBvaW50ZXIgZGVyZWZlcmVuY2UsIGFkZHJlc3M6IDAw
MDAwMDAwMDAwMDAxNzANCiNQRjogc3VwZXJ2aXNvciB3cml0ZSBhY2Nlc3MgaW4ga2VybmVsIG1v
ZGUNCiNQRjogZXJyb3JfY29kZSgweDAwMDIpIC0gbm90LXByZXNlbnQgcGFnZQ0KUEdEIDAgUDRE
IDANCk9vcHM6IDAwMDIgWyMxXSBQUkVFTVBUIFNNUCBOT1BUSQ0KQ1BVOiAwIFBJRDogOSBDb21t
OiBrd29ya2VyLzA6MUggS2R1bXA6IGxvYWRlZCBOb3QgdGFpbnRlZCA2LjAuMC1yYzErICMzNw0K
SGFyZHdhcmUgbmFtZTogUUVNVSBTdGFuZGFyZCBQQyAoUTM1ICsgSUNIOSwgMjAwOSksIEJJT1Mg
cmVsLTEuMTUuMC0yOS1nNmE2MmUwY2IwZGZlLXByZWJ1aWx0LnFlbXUub3JnIDA0LzAxLzIwMTQN
CldvcmtxdWV1ZTogIDB4MCAoa2Jsb2NrZCkNClJJUDogMDAxMDpzcnBfcmVjdl9kb25lKzB4MTc2
LzB4NTAwIFtpYl9zcnBdDQpDb2RlOiAwMCA0ZCA4NSBmZiAwZiA4NCA1MiAwMiAwMCAwMCA0OCBj
NyA4MiA4MCAwMiAwMCAwMCAwMCAwMCAwMCAwMCA0YyA4OSBkZiA0YyA4OSAxNCAyNCBlOCA1MyBk
MyA0YSBmNiA0YyA4YiAxNCAyNCA0MSAwZiBiNiA0MiAxMyA8NDE+IDg5IDg3IDcwIDAxIDAwIDAw
IDQxIDBmIGI2IDUyIDEyIGY2IGMyIDAyIDc0IDQ0IDQxIDhiIDQyIDFjIGI5DQpSU1A6IDAwMTg6
ZmZmZmFlZjdjMDAwM2UyOCBFRkxBR1M6IDAwMDAwMjgyDQpSQVg6IDAwMDAwMDAwMDAwMDAwMDAg
UkJYOiBmZmZmOWJjOTQ4NmRlYTYwIFJDWDogMDAwMDAwMDAwMDAwMDAwMA0KUkRYOiAwMDAwMDAw
MDAwMDAwMTAyIFJTSTogZmZmZmZmZmZiNzZiYmQwZSBSREk6IDAwMDAwMDAwZmZmZmZmZmYNClJC
UDogZmZmZjliYzk4MDA5OWEwMCBSMDg6IDAwMDAwMDAwMDAwMDAwMDEgUjA5OiAwMDAwMDAwMDAw
MDAwMDAxDQpSMTA6IGZmZmY5YmNhNTNlZjAwMDAgUjExOiBmZmZmOWJjOTgwMDk5YTEwIFIxMjog
ZmZmZjliYzk1NmUxNDAwMA0KUjEzOiBmZmZmOWJjOTgzNmI5Y2IwIFIxNDogZmZmZjliYzk1NTdi
NDQ4MCBSMTU6IDAwMDAwMDAwMDAwMDAwMDANCkZTOiAgMDAwMDAwMDAwMDAwMDAwMCgwMDAwKSBH
UzpmZmZmOWJjOTdlYzAwMDAwKDAwMDApIGtubEdTOjAwMDAwMDAwMDAwMDAwMDANCkNTOiAgMDAx
MCBEUzogMDAwMCBFUzogMDAwMCBDUjA6IDAwMDAwMDAwODAwNTAwMzMNCkNSMjogMDAwMDAwMDAw
MDAwMDE3MCBDUjM6IDAwMDAwMDAwMDdlMDQwMDAgQ1I0OiAwMDAwMDAwMDAwMDAwNmYwDQpDYWxs
IFRyYWNlOg0KIDxJUlE+DQogX19pYl9wcm9jZXNzX2NxKzB4YjcvMHgyODAgW2liX2NvcmVdDQog
aWJfcG9sbF9oYW5kbGVyKzB4MmIvMHgxMzAgW2liX2NvcmVdDQogaXJxX3BvbGxfc29mdGlycSsw
eDkzLzB4MTUwDQogX19kb19zb2Z0aXJxKzB4ZWUvMHg0YjgNCiBpcnFfZXhpdF9yY3UrMHhmNy8w
eDEzMA0KIHN5c3ZlY19hcGljX3RpbWVyX2ludGVycnVwdCsweDhlLzB4YzANCiA8L0lSUT4NCg0K
Rml4ZXM6IGFkMjE1YWFlYTRmOSAoIlJETUEvc3JwOiBNYWtlIHN0cnVjdCBzY3NpX2NtbmQgYW5k
IHN0cnVjdCBzcnBfcmVxdWVzdCBhZGphY2VudCIpDQpTaWduZWQtb2ZmLWJ5OiBYaWFvIFlhbmcg
PHlhbmd4Lmp5QGZ1aml0c3UuY29tPg0KLS0tDQogZHJpdmVycy9pbmZpbmliYW5kL3VscC9zcnAv
aWJfc3JwLmMgfCAzICsrLQ0KIDEgZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKyksIDEgZGVs
ZXRpb24oLSkNCg0KZGlmZiAtLWdpdCBhL2RyaXZlcnMvaW5maW5pYmFuZC91bHAvc3JwL2liX3Ny
cC5jIGIvZHJpdmVycy9pbmZpbmliYW5kL3VscC9zcnAvaWJfc3JwLmMNCmluZGV4IDc3MjBlYTI3
MGVkOC4uZDdmNjllNTkzYTYzIDEwMDY0NA0KLS0tIGEvZHJpdmVycy9pbmZpbmliYW5kL3VscC9z
cnAvaWJfc3JwLmMNCisrKyBiL2RyaXZlcnMvaW5maW5pYmFuZC91bHAvc3JwL2liX3NycC5jDQpA
QCAtMTk2MSw3ICsxOTYxLDggQEAgc3RhdGljIHZvaWQgc3JwX3Byb2Nlc3NfcnNwKHN0cnVjdCBz
cnBfcmRtYV9jaCAqY2gsIHN0cnVjdCBzcnBfcnNwICpyc3ApDQogCQlpZiAoc2NtbmQpIHsNCiAJ
CQlyZXEgPSBzY3NpX2NtZF9wcml2KHNjbW5kKTsNCiAJCQlzY21uZCA9IHNycF9jbGFpbV9yZXEo
Y2gsIHJlcSwgTlVMTCwgc2NtbmQpOw0KLQkJfSBlbHNlIHsNCisJCX0NCisJCWlmICghc2NtbmQp
IHsNCiAJCQlzaG9zdF9wcmludGsoS0VSTl9FUlIsIHRhcmdldC0+c2NzaV9ob3N0LA0KIAkJCQkg
ICAgICJOdWxsIHNjbW5kIGZvciBSU1Agdy90YWcgJSMwMTZsbHggcmVjZWl2ZWQgb24gY2ggJXRk
IC8gUVAgJSN4XG4iLA0KIAkJCQkgICAgIHJzcC0+dGFnLCBjaCAtIHRhcmdldC0+Y2gsIGNoLT5x
cC0+cXBfbnVtKTsNCi0tIA0KMi4zNC4xDQo=
