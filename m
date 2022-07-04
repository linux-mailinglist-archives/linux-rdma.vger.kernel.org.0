Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BEF30564D79
	for <lists+linux-rdma@lfdr.de>; Mon,  4 Jul 2022 08:01:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229545AbiGDGBF (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 4 Jul 2022 02:01:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229532AbiGDGBE (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 4 Jul 2022 02:01:04 -0400
Received: from esa18.fujitsucc.c3s2.iphmx.com (esa18.fujitsucc.c3s2.iphmx.com [216.71.158.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E181662F1
        for <linux-rdma@vger.kernel.org>; Sun,  3 Jul 2022 23:01:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1656914463; x=1688450463;
  h=from:to:cc:subject:date:message-id:
   content-transfer-encoding:mime-version;
  bh=ATR+F+Xywgyhac5gAy2Q2mNV2LwvAQP6rGOwnlhjDGc=;
  b=uElSMF0ENaSh5jV99j+shoIDhpon6ebb6EqevYjFymwsnbKgAZOB+9e3
   yCCii97VgIiFME0MhilRpsaglRUx7zXkC2h1cxbNXpYpVwxOeVQVzIoGb
   fG/AytrIpdLLCFY8Oa5v+ZAyUlni4myfSqOFE4UEJPrZDp5NCXl2xtj6S
   280b5yFz8WX/O4GkAahELiFCtXjxiscTmhXd91O712MjeP4TmFJ+OukxN
   Pw9lTGAiilE99fiqcPrVJhlKopUA5H4SzrA7mfyFMPCd0fC3uQp0gGge3
   FCx6B3hOcGtXoNCPcOHaqGPDwrysf1cYnVnseEjlU3IXXTeBx54PyjF7T
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10397"; a="60952356"
X-IronPort-AV: E=Sophos;i="5.92,243,1650898800"; 
   d="scan'208";a="60952356"
Received: from mail-tycjpn01lp2169.outbound.protection.outlook.com (HELO JPN01-TYC-obe.outbound.protection.outlook.com) ([104.47.23.169])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jul 2022 15:00:59 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SnYQWaAkOiKSkRU/1/Zf5hblJfSWgH9YszV3HzyrV4PxeBRRMi79hvtsUIFdB7AiyPdK8aSnairhF7Pi0P/XLu/QfQGe5VG/uWFN1oUDOQ7TNtGuHpHHZY5Gh+BhZZHgLGiw1MPYxbcB6+xnZVMVYRYrgIoUOSin13Gp4+79D/lBMvHPAlGcftSaJeySPgUxG3wKfbyhbTPENrwTCQYEe6rGl8zfBAc+qm7we1B2HhwXR0WNu5Djs1B5hbdJWOs3MygYX7Ves7jPRTMts9EDvfWLxbel72iLdg7PWZCymOaV+/ld8c80GSWpMhpVkBbOAGE4EcWM1mScPlkjrnJdFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ATR+F+Xywgyhac5gAy2Q2mNV2LwvAQP6rGOwnlhjDGc=;
 b=BTRqw8nt5BG79uktPiKqe04RhM8YQnFPoo5yZPXHnnbPgGTF0QaoyVsOB2L+mW4F5QnY1azHeMBY5FUwbFNG97I6N1rb8+omMBdYdUoaiztpybuPrpfwBvBC1JOyOJoUXFOm5lHzAQw6hygvdxBnumr5+JSzUlxcEMHbP+ytb98dppv1eagbZ6dITJIPSUX92a+gmUnZBwPvpggN1NxKSXIqd4S//zpaZMwbvWj9pkIrSeWKoYBJRvwZoG78zsFuAU73Z+ORdY+wUi9q25HRt/G5TZ6CFuBWagw4JN0vCtHyohUoPBTW19VynPPMYP7ihOLvXi2i58zbb8Gawj+7YA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ATR+F+Xywgyhac5gAy2Q2mNV2LwvAQP6rGOwnlhjDGc=;
 b=GhAA+O7CT1zgUJefP2n9DHjP6k5QTeqalMgLpyMyMUtTEysB0vaZBDuNP7rFmanTfJDrNtE38R0adBcNvlZJjTTjmvUbtSEwkycVn9JneQgFGcF19dRgygbbLe6b9twB5MlpHreQ+wMsPZeXPOxAMWocYQutwWykhuz4ey54y6Y=
Received: from TYCPR01MB9305.jpnprd01.prod.outlook.com (2603:1096:400:196::10)
 by TY1PR01MB1753.jpnprd01.prod.outlook.com (2603:1096:403:1::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.18; Mon, 4 Jul
 2022 06:00:54 +0000
Received: from TYCPR01MB9305.jpnprd01.prod.outlook.com
 ([fe80::8d7a:baa8:3b18:cd93]) by TYCPR01MB9305.jpnprd01.prod.outlook.com
 ([fe80::8d7a:baa8:3b18:cd93%6]) with mapi id 15.20.5395.020; Mon, 4 Jul 2022
 06:00:54 +0000
From:   "lizhijian@fujitsu.com" <lizhijian@fujitsu.com>
To:     Yanjun Zhu <yanjun.zhu@linux.dev>, Jason Gunthorpe <jgg@ziepe.ca>,
        Haakon Bugge <haakon.bugge@oracle.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Bob Pearson <rpearsonhpe@gmail.com>
CC:     Cheng Xu <chengyou@linux.alibaba.com>,
        "lizhijian@fujitsu.com" <lizhijian@fujitsu.com>
Subject: [PATCH v5 0/4] RDMA/rxe: Fix no completion event issue
Thread-Topic: [PATCH v5 0/4] RDMA/rxe: Fix no completion event issue
Thread-Index: AQHYj2tsVqLq8qnUGEa0XJOwJo3ZVw==
Date:   Mon, 4 Jul 2022 06:00:54 +0000
Message-ID: <20220704060806.1622849-1-lizhijian@fujitsu.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.31.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b8699d87-59e8-4fe4-7a59-08da5d828eb1
x-ms-traffictypediagnostic: TY1PR01MB1753:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: V3hc/GdgSKkJa+W4g92Fs/U3l8LIQTK2CHyRdO+LQlOob4tnO5/mi7TiT6r2H+grMCZirimOTbyTZjRRjfKFVWPHWBi1wiLl/7DjvlvUP9aFT+8kL16jYx9G99g//JpGNU+RlIRKtnhojLtnNd6JGv1gQww7veClmoCB5KH8YAb6vrElxmLrR32R4pHD/nvaBC7CZAmqPtRCPHZU36qJNhHOjpi1y45Ad9I8iWo6jvqNcpAj/Rf5dF8J2TuexQle05F+gz5e+buNeVrBQaDV+U3GMPI6AwCeEg9dhPNyMuvjDUxXP54ASl2gEwegDBx+fdqhntWmFktcRN6rDdnBIAaxfUwzNpPaISoUkfRNMIDPf6stTuo5v6QPeOHpKpENYBzbQ7BYr/yayHlROc61Xo8UuwZr4LlfJf0KV30JLpjrxKCrxYZ6m57xTwtBDhfbacz4Q+IZ+dED4BTuyqetEJGc5v9n4KWDcUcBfrs3a0Q5KUu2BgNp7f/gqN7H4xG54xAPhMCgXawAh1KcTxS6oXmxUYLLKOfBptdMz7Pzt/ba7/QyZhxGeIJiQI4gyfNa2qlotpwkkvyoAyTQwcgpSTZWgRHd5JVRTGG/K7wSn9WRuAWn6OOp2byUuC04Ce9Gkn63WUB2nj8ZJp3grP3In9SR+31jXpzTIau2wd9FLQch5sQnHxki8nVmWBv8BiM3D8zJEAcK5JYky9OM0Hl+MMZ4H42VT+3c1drzB8UFg8oYBZO9XBrv1TKXNtUg4RsXd8MaGocIEKVYhd4NlZ/iZJM1ZsqxGrbUf74v4zXYvsRLMQEMvVEkYwR0BB3QtBr1
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB9305.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(346002)(136003)(376002)(366004)(396003)(2616005)(107886003)(186003)(1076003)(38070700005)(38100700002)(64756008)(36756003)(71200400001)(8676002)(66446008)(316002)(66476007)(66946007)(76116006)(110136005)(66556008)(83380400001)(85182001)(91956017)(54906003)(4326008)(5660300002)(6512007)(6506007)(478600001)(6486002)(8936002)(82960400001)(122000001)(86362001)(41300700001)(26005)(2906002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?dUJldjRsNU1NVklQbnF5WVRqOWpBdkc4VDlVLzV2VDRuSkpMQ0NQTGhtRThI?=
 =?gb2312?B?RWs2cE1MVEtJUk44d0ZvVitpWm9iMTBUam44SUNHUklKVndmMlRoVnhEL1c5?=
 =?gb2312?B?ZXBaWmpXV3hZdWxsaHNEaHRhTER1UVR0eGQwbDVRV2JqbDVZbFhDcFAraFhZ?=
 =?gb2312?B?MEY0OVF5a2V0REdFMkIxVU1uWXBLL3FqN1BDbVRLY1kwK3JyVjNxZUpWeGZC?=
 =?gb2312?B?elZWZVNLODhQVitFUlg3MTZ5aUNOVDdqNEtidmFyZHBIeWNKcWFjMUpuVGtZ?=
 =?gb2312?B?T0Z5SGZHOG1tQk05N2N4NHVUdTJsUE9wVXBIbDNuWGRCOTcrb1VOYTAzc2hF?=
 =?gb2312?B?SjZSejlHamcxQS9VRnN4N0VpYmpMcnpkaThvQzFpVkxTOGs1NnRkcFdWc0lv?=
 =?gb2312?B?RklMZDdVTXlJeG9YTkNQSjhxdlNnUXhUMElKS3RQa2V2bFpmRjNGK21UOS96?=
 =?gb2312?B?ZHRJVXp4bmM0VndUYkRDR09YMjQ2QUpkaXpMWG56VmVGTjZJTG9zWlNmQWJL?=
 =?gb2312?B?eXFGNWE3WEZoYjNaV0JFdDJvNVNSZ0lDbTAxblNtN2hkUVlLaUdGYXVzdXRi?=
 =?gb2312?B?UTd2bGVnWVE4SzhycUp1QnVaakw2clBhTkRrREdHMzRuVUZrcHliSDlwNlRx?=
 =?gb2312?B?ZE53QTN5VjdKZ3Vpc2RPMEZKNGpibWhDN2VJQTc5ZGRidTVDWmIyWk1vYlJw?=
 =?gb2312?B?bmxBRjlVTEtmcUFCOHlTYVFqZHdwTGViMXFoT3FMRzlkUzdUbitZbSt5Z1VJ?=
 =?gb2312?B?L1l3NjdBbzloZzhjSXBDVHJsMHlpOHJ6cHVCTGRDaTBVNk9xVXFHenZ2b1Ir?=
 =?gb2312?B?aEg4Z2pYV1FwMjhRYUZmd2JpMndGODZRUThFSG9pSGM0Wjl1UExiODhRNXZt?=
 =?gb2312?B?emVQT09Zb0puekl6OTRTSUUvY2ljRlpqVjNGS0RKU0tpaS9EWk8vN1hsUkhE?=
 =?gb2312?B?djBkcXFqcU5kbk1ySUE0UkpvUUtkMjNUcythNGdwNzVwQm9BQVMwWjUweHpW?=
 =?gb2312?B?SzV5VzEzSFBwVStTRVZIYkZZc1VhaGptVUtrdUgyV2R6UTB6c1UrOXRFK0d0?=
 =?gb2312?B?R3puVVVXNWRWNk1sQ0NaeVVSRGFEOWhsaVJGQmwxb1pLdExkcURUUW91SlJX?=
 =?gb2312?B?aFJsSkpvL0hBZGI3VXkwWWFqN3MzS1B3d3QyV0gyRkpTd0JsbmpqZHYzNXps?=
 =?gb2312?B?bElMRkN3ekVGMWMvR3NMMm1IY1dwZUFwL01wNnpodmVraWpPcUN2VitkTUgr?=
 =?gb2312?B?azN4MWpId2YvNXVwSVFSTFd2aXRCZVJNWFFPdFE2dElhb3ZpYlowQVQ5NHpM?=
 =?gb2312?B?aVAzcG53NDdxdThMTDd5QU9xZ0NyeEZlWk9vTGRuaElyUmhuY1dpM3U3T3g0?=
 =?gb2312?B?UUtsK0daa2tCRXhHVDJXeW1HcytuTWlhMEhwdlJxZnovQlNTVTFRaEFwaXBt?=
 =?gb2312?B?OTlDUENUWjR3SlNrcENjSXRXSzFtYUJTNmdLRFBGZCs1SG5Ia1hHQUx5Rm5h?=
 =?gb2312?B?U1F6VXE4NGlYU1hxaXdpTkJXODVqamdXWFRnMU5aZHhaY1JpU2ZMUWpFaEli?=
 =?gb2312?B?eGVKQkFWajUyUE9JVyt3alc3MUdGbkRTbmNNVDFMMVVsTkRldmpLRjhxV1ow?=
 =?gb2312?B?V0QwODBBWFkrWDRBZkdqSnVocnpPQmNqa3JPMXRQbEEvT2tSQU11NGUxL2pS?=
 =?gb2312?B?aFgxeCtBQVdYa2h2cTZJeXJCV1Bodk5WWkVaTTNvYkYzQU9IczVmQ2NSdkhX?=
 =?gb2312?B?cEU0WmY3N3VML0hjSk1HRjlnUGl0Q2IxS3JJQUt1NWZzS29TZUJ3cmM4Sk1u?=
 =?gb2312?B?TmZzQWVYSU52bk9YZGtDdDFESnlIY0hVaGhqeDlhZ21Ca1FaQ0JmeWRtVnB4?=
 =?gb2312?B?anpJSUZlVHM1Q3JWdG9haFNhZGFJdkt0bGF0SFpySlNWUDhrTWo2aVJzb2ty?=
 =?gb2312?B?VUlOUlQ3WUpmMGRocnhxVUF6TTBVaC9IeEVYOVRFa3V5aUo4SU04eVZ0bmhL?=
 =?gb2312?B?RklWNjgwTktsd2ZsVUpYd21ickdsOG9TNWZkWnl1WlZ3M0NYZWplN3YxOUNv?=
 =?gb2312?B?dWdiRTFpWjkzQWlLWW9HbW82aXRHWVo5aVdiY1RQZUlyWFJuYlV4S0dTVzJs?=
 =?gb2312?B?OXMrYWtkenM2UEhKSnpzZ2J5Q0YvSS9UK1dsS21xYzB4Uzl4Si82aFMwU1Ja?=
 =?gb2312?B?YXc9PQ==?=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB9305.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b8699d87-59e8-4fe4-7a59-08da5d828eb1
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jul 2022 06:00:54.6849
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nvp7w5qudbjCrUWg5ZdbD+kXUiIXQrR9GpDzpWotwKbLqFmSPdtBdKnrZ/6oHNVI88E+CznRa/PcXtaGrDdd+g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY1PR01MB1753
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

SXQncyBvYnNlcnZlZCB0aGF0IG5vIG1vcmUgY29tcGxldGlvbiBvY2N1cnMgYWZ0ZXIgYSBmZXcg
aW5jb3JyZWN0IHBvc3RzLg0KQWN0dWFsbHksIGl0IHdpbGwgYmxvY2sgdGhlIHBvbGxpbmcuIHdl
IGNhbiBlYXNpbHkgcmVwcm9kdWNlIGl0IGJ5IHRoZSBiZWxvdw0KcGF0dGVybi4NCg0KYS4gcG9z
dCBjb3JyZWN0IFJETUFfV1JJVEUNCmIuIHBvbGwgY29tcGxldGlvbiBldmVudA0Kd2hpbGUgdHJ1
ZSB7DQogIGMuIHBvc3QgaW5jb3JyZWN0IFJETUFfV1JJVEUod3JvbmcgcmtleSBmb3IgZXhhbXBs
ZSkNCiAgZC4gcG9sbCBjb21wbGV0aW9uIGV2ZW50IDw8PDwgYmxvY2sgYWZ0ZXIgMiBpbmNvcnJl
Y3QgUkRNQV9XUklURSBwb3N0cw0KfQ0KDQpWNCBhZGQgbmV3IHBhdGNoIGZyb20gQm9iIHdoZXJl
IGl0IG1ha2UgcmVxdWVzdGVyIHN0b3AgZXhlY3V0aW5nIHFwDQpvcGVyYXRpb24gYXMgc29vbiBh
cyBwb3NzaWJsZS4NCg0KQm90aCBibGt0ZXN0cyBhbmQgcHl2ZXJicyB0ZXN0cyBhcmUgcGFzc2Vk
IGZpbmUuDQoNCkJvYiBQZWFyc29uICgxKToNCiAgUkRNQS9yeGU6IFNwbGl0IHFwIHN0YXRlIGZv
ciByZXF1ZXN0ZXIgYW5kIGNvbXBsZXRlcg0KDQpMaSBaaGlqaWFuICgzKToNCiAgUkRNQS9yeGU6
IFVwZGF0ZSB3cWVfaW5kZXggZm9yIGVhY2ggd3FlIGVycm9yIGNvbXBsZXRpb24NCiAgUkRNQS9y
eGU6IEdlbmVyYXRlIGVycm9yIGNvbXBsZXRpb24gZm9yIGVycm9yIHJlcXVlc3RlciBRUCBzdGF0
ZQ0KICBSRE1BL3J4ZTogRml4IHR5cG8gaW4gY29tbWVudA0KDQogZHJpdmVycy9pbmZpbmliYW5k
L3N3L3J4ZS9yeGVfY29tcC5jICB8ICA2ICsrKy0tLQ0KIGRyaXZlcnMvaW5maW5pYmFuZC9zdy9y
eGUvcnhlX3FwLmMgICAgfCAgNSArKysrKw0KIGRyaXZlcnMvaW5maW5pYmFuZC9zdy9yeGUvcnhl
X3JlcS5jICAgfCAxNiArKysrKysrKysrKysrKystDQogZHJpdmVycy9pbmZpbmliYW5kL3N3L3J4
ZS9yeGVfdGFzay5jICB8ICAyICstDQogZHJpdmVycy9pbmZpbmliYW5kL3N3L3J4ZS9yeGVfdmVy
YnMuaCB8ICAxICsNCiA1IGZpbGVzIGNoYW5nZWQsIDI1IGluc2VydGlvbnMoKyksIDUgZGVsZXRp
b25zKC0pDQoNCi0tIA0KMi4zMS4xDQo=
