Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87BAF564D7C
	for <lists+linux-rdma@lfdr.de>; Mon,  4 Jul 2022 08:01:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230440AbiGDGBM (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 4 Jul 2022 02:01:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229706AbiGDGBL (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 4 Jul 2022 02:01:11 -0400
Received: from esa20.fujitsucc.c3s2.iphmx.com (esa20.fujitsucc.c3s2.iphmx.com [216.71.158.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3624647A
        for <linux-rdma@vger.kernel.org>; Sun,  3 Jul 2022 23:01:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1656914471; x=1688450471;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=L836/VhK6ov44k0+ziJxkPeLrW8XxLif3cV6RZSZ4eU=;
  b=yxn8VZ6RRo3ZD1S1/Lp5RfAyxJewVtLqHjSja84I0BiwBdggWu+Tl22f
   n924ym6p8KdNchIWNQYORqz/JXJu6cV3PdLf7mvnzQ0Z46qJx+i6zGyOW
   892nMlBPh0Q43J7bj+W/RUzSs02z0JcdB5NlYmv5yRKRVLp2w4bCvg+c7
   ZLH3YU1OJiD2J4TB8iNzfIC3x2W7uixBKz1y6z7c652IZRoCBiHulfLFk
   GbCBObPozJdY6edJKB38hVV1KFWxgPbHxFk4iUJIal/SujXRKqnccun9r
   sLAU5GEFjbiIcYeZ9YEJ7rL1vmUSb12E/uNnsR+ft+SeISWTnP5YusaIs
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10397"; a="59469705"
X-IronPort-AV: E=Sophos;i="5.92,243,1650898800"; 
   d="scan'208";a="59469705"
Received: from mail-tycjpn01lp2171.outbound.protection.outlook.com (HELO JPN01-TYC-obe.outbound.protection.outlook.com) ([104.47.23.171])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jul 2022 15:01:07 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HkJxAob7XXORMW8CmHTA/4TJv/WZbQocmEJIxTnKoGvtQtQrx+/j+abnzf3VHoot9BRPX1dzXH5y3KDmH4Vd7zMJGcc/V9ZPDJXTn6AktZmWtovikGRAICTfAocHzUVpYb/rpjy3NlHxhoc7QicvI0nsqiIuYsMFH2GT0bo1CE7EgQkKiLTUvKB16+XZZuy5OuLlCO9dWpPX7VCECy42GE1UX5bkCfmtFKtJAGtPByxAirvVNdYQhxTb7zmmmVG99dJy/0+JlrPkOMSIfK6T/r0tc0XizkTRFJHR86Moap9f6HSOfIF3RaT6HtDcg+1g2gjpDZQ2sKP/JX4AHljX3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L836/VhK6ov44k0+ziJxkPeLrW8XxLif3cV6RZSZ4eU=;
 b=l1PtSR6fNd7C4ez4lTzZJo9EKWBgHQpKD8aDgiZ5/D31x3ln4WWf8dLxKJQrKCvocSiQRQnzI2jUp4s7vdYrY1XSYhRBsFvJF9j6wE9LxeKSHa4bSP2WGCMLUCp5SITDBJoMEdyMNL8X3s7Due6VWt+wMHG91QHxCEL+Rd4gUX5Egdn1y92KUqxLm7bSjWE6Ss3r9rBDhpEZyp9ke40LIIiAmy89Uy4xHPN2ulAQ5Q4JFpVwFcGjTV2VuqhZfUOK5DkXLxxCfH9ZrkljRHeHHim5dLpMY3WibdzPfp/csxugoDllycSufk1qHViMfQGbhQgWGBfSM81V4Mdw4Zt1+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L836/VhK6ov44k0+ziJxkPeLrW8XxLif3cV6RZSZ4eU=;
 b=bBPpyQwMSSXrckL5FxeGLP612SUm+6aPX/7+DSp8ETLmjln1wZlHZtP5w2NCdnh+2/OABpTGuT7513mqoZO9TwO/L7/q1dVyKSTD007SOOmhXNBKGT1SVCStWKmXKFOh/Y5VLst0LxAHHF71AYdlShpQA7e3tO1Kmh1UU6ZWXMk=
Received: from TYCPR01MB9305.jpnprd01.prod.outlook.com (2603:1096:400:196::10)
 by TY1PR01MB1753.jpnprd01.prod.outlook.com (2603:1096:403:1::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.18; Mon, 4 Jul
 2022 06:00:57 +0000
Received: from TYCPR01MB9305.jpnprd01.prod.outlook.com
 ([fe80::8d7a:baa8:3b18:cd93]) by TYCPR01MB9305.jpnprd01.prod.outlook.com
 ([fe80::8d7a:baa8:3b18:cd93%6]) with mapi id 15.20.5395.020; Mon, 4 Jul 2022
 06:00:57 +0000
From:   "lizhijian@fujitsu.com" <lizhijian@fujitsu.com>
To:     Yanjun Zhu <yanjun.zhu@linux.dev>, Jason Gunthorpe <jgg@ziepe.ca>,
        Haakon Bugge <haakon.bugge@oracle.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Bob Pearson <rpearsonhpe@gmail.com>
CC:     Cheng Xu <chengyou@linux.alibaba.com>,
        "lizhijian@fujitsu.com" <lizhijian@fujitsu.com>
Subject: [PATCH v5 4/4] RDMA/rxe: Fix typo in comment
Thread-Topic: [PATCH v5 4/4] RDMA/rxe: Fix typo in comment
Thread-Index: AQHYj2tt/y2KY7JXJ0C4MDbLNpV73g==
Date:   Mon, 4 Jul 2022 06:00:57 +0000
Message-ID: <20220704060806.1622849-5-lizhijian@fujitsu.com>
References: <20220704060806.1622849-1-lizhijian@fujitsu.com>
In-Reply-To: <20220704060806.1622849-1-lizhijian@fujitsu.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.31.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: da2cdc99-db0f-4f44-d4c5-08da5d829052
x-ms-traffictypediagnostic: TY1PR01MB1753:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: MMIwD4X3dyrvWH36NmHuGrE899+/6ZmhH6nKKSlsNQrvYIb8Kd3h/VK6Yw/Uelqwvm7K25F4w/KeedOga+LGaatYvwdrgJRaAcfqXn5LmCtF8u+n9/TDiG0kTCIv+uMSBCHFcFRC/NMZicr+yK6V5Vq0S6nEXK6G/ccOHsJbteoirIXbsf3w+o1d3cVrbMm7hRgF3Keip7S9dHrYiqEEPYZ3qB2uvRDfQtgAVHy4tST9w2/k6AOEGB6q5Lm+TsXD0G10bOrk+O4qhE4LYYZxoQQRwaKf2UZrP4HaU2wPMopRcXP5z//AEepvabYDx2rNiUjOuUfyX4gtqqD6K8CnWO41JwZXik5CfvhJJP/PROndmbbB7p63sBlOU5Bqu0K3BDT2TxmeXa5oGhesiOTH36FVsU1CJJXreV/KYBTEOX0Bq8VeEU8kzHBP2Oki2E+4dPq4Pn6YE6LH2fs+zdX3zjtx1D3VCsdUdUq7kBZDutxqZAUBFLM3i1LA9LiMsKCcTTz0u4+29n40MQ43Ny+ekkiqFh8TzLLqydiuI/puW3NCTLPWPvoDF19zIOdIsyCznh44MZ6cQg3PlJl3fstZcITZp51qYwIk81p3lQVE5CHmMiuECZhOSJsLYEPDaaopGeT2iHSAMDJu2OIiA/WUi4OKguXVcBS5sZPTYzLvwk7h7pt3P4gQiT+VOEq7ooVfyB+SPAK7NiMtQm2ayWo2xOfzjJhioas41uPpL48hFxvAQa76fqr/4ebnZ8H2WCsv/8aSULTIBi4aA/wj4TDM955oBvnx9lburLE4vb3dAnFGyEMG47F1LW4d3R06QyOl
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB9305.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(346002)(136003)(376002)(366004)(396003)(2616005)(107886003)(186003)(1076003)(38070700005)(38100700002)(64756008)(36756003)(71200400001)(8676002)(66446008)(316002)(66476007)(66946007)(76116006)(110136005)(66556008)(83380400001)(85182001)(91956017)(54906003)(4326008)(5660300002)(6512007)(6506007)(4744005)(478600001)(6486002)(8936002)(82960400001)(122000001)(86362001)(41300700001)(26005)(2906002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?ZXhNS3l1SjVYcWI5ek44aEY3SVkvcDJCV3hoZmZ4YmlkWXh0amNjS2VnNmk4?=
 =?gb2312?B?bDMvc0JnaHVyR0UyT3NYRzAvUHpBTk9Gd2FDUUVXNi9UcHNrclgybVEvL0N0?=
 =?gb2312?B?NjBZV21uaXZiK2VmOVhpT2NuWUVMM1lUMzg1RGVTQkJiKzMzS1VxdW9Wb3Nm?=
 =?gb2312?B?SVVXL2xKMWkxUW04NkQ0aU1OOW9NR3EyWjRHVUtSRTlKbm9lUXFLVSszVzQ3?=
 =?gb2312?B?bW1CVzRkd0RlWlFSb1Z2MW90VU5DeUdsM0F3UzZHMitCRU8rRlFHc0dzTFJD?=
 =?gb2312?B?VUVaRVVPdXJmTmtPR2R4V0x3UGVWTTY3ZDNoVkRHbk00OVJEb2NjNCtIMFpH?=
 =?gb2312?B?Q0I1cVkvSVNpeldSTGV6d1NMTVJRRno1K29wdDBRMGJMcERabEZkQmRlM0Zm?=
 =?gb2312?B?M2Z1M0JnaHdkL1RRSkNUMXNFcEtSQ0IrTVVEWko1bnNMMmVqbGJVOXRPdmRu?=
 =?gb2312?B?Y1RwN29IaVB5NmZ5TGhUeXcvYzVmYjZuQU91dU5HRU5iS3VJSnVJQ0J1VkdY?=
 =?gb2312?B?RVloQkZ3Zk0rcHhzK2c5a0loVWZMWmlMSVJnRU1VQlBNcCtGSytFcEhJV2x3?=
 =?gb2312?B?anVkenMrd094dGFFeGFKZjVUYXV3QWFrcFl6cXM0YTlwZmUzU0tVOGNGRk5x?=
 =?gb2312?B?enJ1bEZNdm9nOGRxRm05RThPdUVON0NLaFJjVHdWdWdyMEovVjErc0hrSmU0?=
 =?gb2312?B?TGFIMUttcGkxdjJnOUZTZ08rMzgzWWlSbnpHOVlLem1kZkc5RDVsNVNzVkov?=
 =?gb2312?B?OFprL2gvb2NrMHY1eFNUKzMyZUUwTXowcFZVMUVXZVZ6SG1uV3Z3QXZaZzF1?=
 =?gb2312?B?NVUxVzFOc2pZNVBKQ1NnS3R6bjdjaFA0eVYvSit1VEhEb0k2aCt6UGJSSC8r?=
 =?gb2312?B?OUsxdm9pSkNJeGFVQU5xUDYyd2VmbzA1L0ExamxXT0VSalJKMGhFNVJEL1VJ?=
 =?gb2312?B?K2VNR1Nkdk5EQ3FPbjhXdWY0VHJvTm1ORFFQclBKZk11UEZYY0FnNllFMTFL?=
 =?gb2312?B?bFM4cHBwY3VTK00xUG1USXBPYnJwVmpqczVSQkNZcnBmZGZxRWVOdlRMY0JK?=
 =?gb2312?B?QTUzb21HQjlsT0ZRZ2tJb0c4RnY4ckZ0Rnd0Vlc5UElDMHR3U01HQlJTMFVM?=
 =?gb2312?B?MThuQ0M0cThtOWlwTVNxdnJ4QUFLWDhvdW1kN2Z0NUFRUkNSQVlJcWdsd2kx?=
 =?gb2312?B?UmprMTlkK0orVDltM3VvY09HanpzRHgwOWQzWUowUFRzYVhHU3hLZG12SFBB?=
 =?gb2312?B?eGsra1hGSFJKemJYMUsvc2prektzMEdGenZ3Y0ZhNFFxSlBWS1hSbmlNcWZN?=
 =?gb2312?B?NnIySi9IU056aEVvTEdIdHo2ZVZ1bTNsa0dqWitMMVZaOGUwNndRN0c2aVVN?=
 =?gb2312?B?QmRramM4OVFRbDNjMERUZHY0SnRJbWtaeDR5emtwek5OS2dxNjJmbmh2a2FP?=
 =?gb2312?B?Y1pjSkg0OEhxc2xQaG8xTDZYaFpqdFdHcmx5RjQya0hVRVBNUFlDRG5DSWIr?=
 =?gb2312?B?OCs3STY1ck1kZ1VIa3JFaXQwcmxOWG9zWEMvOExMZ3pZa29hZjRJQmZIRFNR?=
 =?gb2312?B?SDUwWHUvUHFzK1lBV1lESFpUamJMWUE1bTVQRFA1UGJuWmFpOXE1SjFOTnJj?=
 =?gb2312?B?UDZZUnVvc1FuUldqOUFKYUs2NXdLcUkyR1ZWd2lWakRJUTNONElrRW5wQ2Nk?=
 =?gb2312?B?TURadGQ1QW8vWUxIQ0xPbHJGUGMzbThuOVdQWk9FYnRnVndpRE5KMGRNVXo5?=
 =?gb2312?B?K3NzZ25Cbnc2SE5OZTQ0bkc3RFJKeWpBTXJxY2k2U0NFNlhGNlVkWjVhZnk2?=
 =?gb2312?B?YTJiWGtCNmtoUXQrTFlBcXhvNzZnNWNXSXZzU2NKOGszajhlSFdGV0cvcWgw?=
 =?gb2312?B?ZUlwTjVndGpyanFEeERhSXZhVjhSM2plSXRYOThuSmlCeFZ5elB2b2Vsc3Ur?=
 =?gb2312?B?Z3ZlOHVHelJ1ZWlCS2JJeCs4TVVZSjlaeWJTa1orSG5RUVllMEJaRVExanVv?=
 =?gb2312?B?b1g0Vy9IK2xyQWFPUlo0R2tKSWhoRWpnWWw3UnpUaDdBM3ZGNlY3TzRWMVkw?=
 =?gb2312?B?VFArYWFCVVBxVWY4akltS2ZvOVEvUmlvYWlrSVJoaHRqc09nNFJYbWtlQ2Zy?=
 =?gb2312?B?MWVmalZPVWRQTnpUdFVHU2xQTzVaeUI2RUZtWnVZUnhQVWNiQVFsZGh1RnE2?=
 =?gb2312?B?WlE9PQ==?=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB9305.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: da2cdc99-db0f-4f44-d4c5-08da5d829052
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jul 2022 06:00:57.4357
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cnZiRltpYkAK8cqp/uJO+XcGdjWYZMnPaLvd2ocEP7f3IUcYVxuaBAZ1bV+kxxxYtcAkfvm+ll1RMrYd0O6Nxw==
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

Rml4IGEgc3BlbGxpbmcgbWlzdGFrZQ0KDQpTaWduZWQtb2ZmLWJ5OiBMaSBaaGlqaWFuIDxsaXpo
aWppYW5AZnVqaXRzdS5jb20+DQotLS0NCiBkcml2ZXJzL2luZmluaWJhbmQvc3cvcnhlL3J4ZV90
YXNrLmMgfCAyICstDQogMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9u
KC0pDQoNCmRpZmYgLS1naXQgYS9kcml2ZXJzL2luZmluaWJhbmQvc3cvcnhlL3J4ZV90YXNrLmMg
Yi9kcml2ZXJzL2luZmluaWJhbmQvc3cvcnhlL3J4ZV90YXNrLmMNCmluZGV4IDBjNGRiNWJiMTdk
Ny4uYzliODA0MTBjZDViIDEwMDY0NA0KLS0tIGEvZHJpdmVycy9pbmZpbmliYW5kL3N3L3J4ZS9y
eGVfdGFzay5jDQorKysgYi9kcml2ZXJzL2luZmluaWJhbmQvc3cvcnhlL3J4ZV90YXNrLmMNCkBA
IC02Nyw3ICs2Nyw3IEBAIHZvaWQgcnhlX2RvX3Rhc2soc3RydWN0IHRhc2tsZXRfc3RydWN0ICp0
KQ0KIAkJCQljb250ID0gMTsNCiAJCQlicmVhazsNCiANCi0JCS8qIHNvbmVvbmUgdHJpZWQgdG8g
cnVuIHRoZSB0YXNrIHNpbmNlIHRoZSBsYXN0IHRpbWUgd2UgY2FsbGVkDQorCQkvKiBzb21lb25l
IHRyaWVkIHRvIHJ1biB0aGUgdGFzayBzaW5jZSB0aGUgbGFzdCB0aW1lIHdlIGNhbGxlZA0KIAkJ
ICogZnVuYywgc28gd2Ugd2lsbCBjYWxsIG9uZSBtb3JlIHRpbWUgcmVnYXJkbGVzcyBvZiB0aGUN
CiAJCSAqIHJldHVybiB2YWx1ZQ0KIAkJICovDQotLSANCjIuMzEuMQ0K
