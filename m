Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB8DB5FF8E5
	for <lists+linux-rdma@lfdr.de>; Sat, 15 Oct 2022 09:00:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229577AbiJOHAh (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sat, 15 Oct 2022 03:00:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229583AbiJOHAb (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sat, 15 Oct 2022 03:00:31 -0400
Received: from esa10.fujitsucc.c3s2.iphmx.com (esa10.fujitsucc.c3s2.iphmx.com [68.232.159.247])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37D4832B82
        for <linux-rdma@vger.kernel.org>; Sat, 15 Oct 2022 00:00:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1665817229; x=1697353229;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=nvZLWYauKX1IRWwLxOrcarGC3WnfU7D+NGxtIx/y0Wo=;
  b=dPrOLiHQDB7b/oKb/qPWVCHQp/MBT69HNQLOROHDAGude0IV0SVYykw+
   M/6UPFjC4/nfFOkb+4NgugAieE4xfUC3oBOGfDIdYM1f1pYHqLQnTGAa1
   t91kvcNxRCPRXis4nv3S3xYolCnZpXAGlb59mt8pFQUhmuOhYqi0x+rMh
   MTftkeKRvmICn68oBq7XIXGrrdAZf0VuTfsoIQ5v/gLn/iyKzD+w8Pvrb
   A3f8vsS+TmjvX5m1EZeai7lu1UGpu2gnok51iJBib6q3h+J9n+b0dB28p
   PADv7uySxEnr840Qtcja4X6nvw3cRqi421Qw5UDbqbv3WQob8gP3MGF4P
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10500"; a="67689750"
X-IronPort-AV: E=Sophos;i="5.95,186,1661785200"; 
   d="scan'208";a="67689750"
Received: from mail-tycjpn01lp2170.outbound.protection.outlook.com (HELO JPN01-TYC-obe.outbound.protection.outlook.com) ([104.47.23.170])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2022 15:37:11 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jm92INuT8A+16bArBZFCMASAAVQu3lBjimAHS8AmoKCuOW6WH1n2GY5Mu1ecJj/uo6GKgn5+j0V+pfvoYLHCnrcHs7G38ahfjBveM8b4EMyk3JeuTckmdjaYjdApjsrKHwaRGYF3v1q+hLKo8vnrpEzxAQMYDWzEKjo3BmDm0Q7vD7mVRYsl1tVw3FF20fcX6xx3bRPPKqg16HIHp0TQgdBxgnzaT81VEGhemNWnl0YvYSFuwcGCy991s6L/x7GttFiRgopGHwaIMllOh0s2nuyWIV1MY4iV3kMOcPx+XqfM8gdlUu5bx0DMpcTwNB13tPjcDjwqIWmPKvT++HfigQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nvZLWYauKX1IRWwLxOrcarGC3WnfU7D+NGxtIx/y0Wo=;
 b=UP5mHcgZrhO0y+O2dqXSvf+Vgiai/tqLPhOVytLy/qEqDWXjuNml866iCFbIib91N53QK1XaXSevnPn84m/NNpoqQ1/VyIwHMo7Eyqq9HyI8puXPVYJiOLU6mSXnu9i2ZyiaOsigJ2futsWLITNoge0TlmiZFU1CisA2TDmqkeyK1NH1slgPbdnK7MNpAK7AGKM++XOZ/Q7y6i9RRotOi9N1uipBpQh1+/+zEJHLWEFaUOecs+u5u0nnyWwpmsPMLe9ST5RS+bTz0glz8QdWqiMPsBDeB3Z0Ghh2qW4QzHEd6Og3X+ihtNlX2RGpRLlfPqTadnBdK4K60WBwQ+yLZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from OS3PR01MB9499.jpnprd01.prod.outlook.com (2603:1096:604:1c8::5)
 by OSZPR01MB8661.jpnprd01.prod.outlook.com (2603:1096:604:185::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.29; Sat, 15 Oct
 2022 06:37:05 +0000
Received: from OS3PR01MB9499.jpnprd01.prod.outlook.com
 ([fe80::5989:c90d:abf4:e100]) by OS3PR01MB9499.jpnprd01.prod.outlook.com
 ([fe80::5989:c90d:abf4:e100%6]) with mapi id 15.20.5723.029; Sat, 15 Oct 2022
 06:37:05 +0000
From:   "yangx.jy@fujitsu.com" <yangx.jy@fujitsu.com>
To:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "jgg@nvidia.com" <jgg@nvidia.com>,
        "rpearsonhpe@gmail.com" <rpearsonhpe@gmail.com>
CC:     "leon@kernel.org" <leon@kernel.org>,
        "lizhijian@fujitsu.com" <lizhijian@fujitsu.com>,
        "y-goto@fujitsu.com" <y-goto@fujitsu.com>,
        "zyjzyj2000@gmail.com" <zyjzyj2000@gmail.com>,
        "yangx.jy@fujitsu.com" <yangx.jy@fujitsu.com>
Subject: [PATCH v6 2/8] RDMA: Extend RDMA kernel ABI to support atomic write
Thread-Topic: [PATCH v6 2/8] RDMA: Extend RDMA kernel ABI to support atomic
 write
Thread-Index: AQHY4GCK8z/n8XKDxECJBUE9Y21x9g==
Date:   Sat, 15 Oct 2022 06:37:04 +0000
Message-ID: <20221015063648.52285-3-yangx.jy@fujitsu.com>
References: <20221015063648.52285-1-yangx.jy@fujitsu.com>
In-Reply-To: <20221015063648.52285-1-yangx.jy@fujitsu.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.34.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS3PR01MB9499:EE_|OSZPR01MB8661:EE_
x-ms-office365-filtering-correlation-id: e7bf29b2-5fb4-453e-21ab-08daae77ad52
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: CzS75lsotChH8azRCEJQCp4X5kZ0VoZ0oZer8DbeHcQxyH2opxv0QyDCfrmjiRknnvQR93ozMY/VEAygMX4nxoofotAcb6UNI0R2SgjcCQwcfMoYfS0947uJ9gzAsreqf+MS5TVrR4zt6RJl+PJgy7YnEmpSpPKjdqaYNVWQV55UhdYHfLEUmGcWaC2MgFjFKEb+iHZbSmZ+AwuCW9nK9FybCm0V15/egyWW5m6S4c8VIP9sdQKFvVTqUkevee44yRl6js9oN9PQ5Z1y1eyej+VkbsCrXoNMIxOSHHaHnjeql/wz/u3s9GdQ92Q+GZu2ZMdrmPHX8XuJ3QYhK2rWt4kX5ll4niJhstzzzBlj1Klr1Vhht9lV9z+gD40Qjt3icANebEfXmRL7/qp59op/P42gEppqyhIcaEjkCoYoue7r6oEWQI5e7Ng+n51YA9Yhd11uHqS9EhEvTsUQR8lomdyZbuf4gbxX8aW1s0kEVQlH0xuFCLMSrMrF67etVa+3LNOX4gEfVPTmvezIUwYvfMgegIJV0EvN7olkrxG/dVfRrHIx496LtzCzCBNRwIDHX/lPdSHDRyeloI4ItayH1F9s1KaTbxBfZTsSVVskfhcsp/PSC8bFRG2cpYTfl3WBxsAw8IYQ4/X2N5BxnpWOCebQ2hNz2s+WPqt1Z385GUliEdL3Z5fQ/CZqRFZLlwMhGteog3pLAARyId3zql/TM/Jhr6GKzsVTUDaqrjmVeRyzQ37MV+cSaT1K3+b4w0WVz6IDUVCM5xe3NV3xQ24cqfA+pDtGXSMSX4C3TrzuKBA=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS3PR01MB9499.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(136003)(346002)(376002)(366004)(396003)(451199015)(1590799012)(6486002)(85182001)(316002)(86362001)(38100700002)(36756003)(5660300002)(110136005)(26005)(6512007)(54906003)(478600001)(122000001)(83380400001)(8936002)(82960400001)(91956017)(1580799009)(66946007)(76116006)(2616005)(107886003)(66556008)(66476007)(38070700005)(41300700001)(71200400001)(6506007)(66446008)(64756008)(8676002)(2906002)(4326008)(1076003)(186003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?TmZNeEp5cVpWcUxKOTN6azI0U3pBNXZLRk90T0gxYWNneG9zWHRzZExpRXg2?=
 =?gb2312?B?Q1cyRjNzbEJidXhBRHZqTkxSa0lqOHlVaHNxUGd0L2libGVXVk5weUJxY2Yy?=
 =?gb2312?B?QUVGbFZKUDlGbHlIZ2ZLMit2QVFOUTN6cWRJanBmdHZEcjdhanpXTk5XS3Uv?=
 =?gb2312?B?RTJHOGVwZ2lBQXFPbXE2NDczWTVqaE5xUUh5Q0ZTc05DWFc3Ym14dWtab1kz?=
 =?gb2312?B?eTE4cnhWSnZMWmYxdTd2VzluaHgvREtiZ0dnT3MrZSsxQlVvWllDdzR6WEtv?=
 =?gb2312?B?UDhVL1BmalJxRVZMWERRak1WQW5LOFNoaXdpQzhHYjBOSDVlblVDME9Jc1Ro?=
 =?gb2312?B?UjVBekl5ZnA1dy9GU3ZCYWUyTitJc3M1eVl2Q29aY0gwNDRvVUVWTGQrczdP?=
 =?gb2312?B?NTNyNFpNNFNhMjBLajhBYk9TaXVjelZnMFUzR2l2MmFLekJmL0g4NWZ1R1Fr?=
 =?gb2312?B?dlJkZGhjdjBuR1pKVFpWYU9wcnlwMzUzWnBtOEdLalVQN1VLS241ZjBpVXRO?=
 =?gb2312?B?YmVTTzB4MzI3TDlOOXQrd1RvRmpnYlJ3ejQ0SUVJbXpJQ2hxNGU4OVk0Sldy?=
 =?gb2312?B?WU5lR2pXSVdtTmt3c2Y2R0gzeG5KVTM1UlRrTEpFR1lCSFFhMGdPNE1tTStH?=
 =?gb2312?B?andiaGlvb2FNQ3JpWGFnS0lMa0oyR0VOR1RYUkwrTjUyL25zcGRqV0l5ZnlE?=
 =?gb2312?B?bStBbzZWbXU1TDRFSUs2dm5aZzJpNUhWNU9GZXpEcHZTL0dJZDNJelZqb2g1?=
 =?gb2312?B?aWgxd1hLRzdXUE4vS3hrRHl5eEVSdGdoUjMwMEtGSWc1enlqaXRSSzJBTXN5?=
 =?gb2312?B?MGtnRHJycnF1RDZzQThFRm5kZWVZenZiZXI3V2ZFS05tZXE0ZTJpWTdFcFhE?=
 =?gb2312?B?bXV2OFpCYTF6VkVNZ0hQS3RYWGt1cHhoUitjcG1peHFRUk5nTVVhSUZZQ21a?=
 =?gb2312?B?MTBRMGJDekthYi9PTHEwR3NNUHdvZ1MrNms3UExlSnNpNHpUMmZXKzBTNHFT?=
 =?gb2312?B?c00vUGhTSGRwRmMrR050WUQrMEpEcDdnMWFieXk2WXNHK1dlZG5ISURXWno3?=
 =?gb2312?B?MjVTN1l2OXJrc3MxcHdPcFVZL1NlQyttbmYzTk9kcGlXZERIeThmMjdENGJP?=
 =?gb2312?B?dUVSaC9ocXBlcUlKREw3ZEJKcWE3NnNOb1BxdFRubHAyRXlpcDF2eTB2MTQ4?=
 =?gb2312?B?WGwwR0lXSGdWVWhRZm9Ha3RIZUZHdm9nMlNwbHhBQXMxSjBsTmJyaDg0SllI?=
 =?gb2312?B?bjJlT3Z3OHpSalRiLzBBZXVlSVhzNjZuVFpuZXlLWVg3QitSdDlNT3l2WXpK?=
 =?gb2312?B?NVlaVzZ0TFQzY2dhUnh3emVOalVEa09RUi8yS3cxMW9ta3RBejJsclhCSTRs?=
 =?gb2312?B?M0xEV1NER1JhMWs4VWVxbGpGNUZ6c2s3MVJIZXAwQUQzNjFkc1k2UHJpdVps?=
 =?gb2312?B?cEVaSk1PbUx3dlFqd013a0RFTGRtWHRyem81MDBqV3g3Vlo4WURkYlZ6cERQ?=
 =?gb2312?B?a3pXdS9pajFjNEFhamlxSVJPYXBDWDBVZC8xeFY4Nkp5WmVLVzRjaU5oRW41?=
 =?gb2312?B?ZmlYVGRma2tpNWRUNmo3dm1UbStDS0g0OW1JTk5DL0pZVzNZS05UQzBrZ1pa?=
 =?gb2312?B?Z2RSQmxRaEp3OUg0VHdDZXNRM2tZSEZMcE4vSlJzaUN4UXl6ZzdZN1pWcFda?=
 =?gb2312?B?MXhlQlViUlZuT0t3SHZGbHEwWDFsdXpRZkxaMVAwWVBVeVBOdXJJMWtFL2Rj?=
 =?gb2312?B?ZzZ0dmp6M0xlUVFsci9zQjUyMjdTczZTQkNJWVlGcmR2dXgrcTRrdjdTRFRa?=
 =?gb2312?B?MnNIV1FvMnlsMjBSQTJhRHRaNm9UYmhvSm15ZEg2MkhuVmpERDZBMnMwY3hl?=
 =?gb2312?B?blNPaDBDTXZyd2FCaWN5a0h1R1pkcGpWeHJjS0I2dkFxNVhvVDNTYmFBRUF6?=
 =?gb2312?B?WGFTWStpVE9wN1duQTI1QVZZdkNPaFB4bjZIdDZYNStPaFo2VkluUzlMSXVS?=
 =?gb2312?B?emtZZmRRK0ptMnFyK1BTcjMzREg4Y3AweWh4ajlSalB0RWpJZ2tsRWpYUDNx?=
 =?gb2312?B?dzA4SEdxRkhFR054ZGdMY0o4TlNlVE9HS2Z3djg5S2JEMnVtbDVzY3RtRUlJ?=
 =?gb2312?B?QkVMVHJCVmhIYnh1Sjk4ZUtUQm9KWkVSYXRyL055M0cvaFRMSkI0NmJQbEcx?=
 =?gb2312?B?a1E9PQ==?=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS3PR01MB9499.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e7bf29b2-5fb4-453e-21ab-08daae77ad52
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Oct 2022 06:37:04.9936
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: P4cPhW9oAarIAUn07ulQwW5Rar04LLlnLWCkS1CYGFqAjMWOdijzO/TCD9X7O1Ky/gwW9WzTAk6DE5N220t4JA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSZPR01MB8661
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

MSkgRGVmaW5lIG5ldyBhdG9taWMgd3JpdGUgcmVxdWVzdC9jb21wbGV0aW9uIGluIGtlcm5lbC4N
CjIpIERlZmluZSBuZXcgYXRvbWljIHdyaXRlIGNhcGFiaWxpdHkgaW4ga2VybmVsLg0KMykgRGVm
aW5lIG5ldyBhdG9taWMgd3JpdGUgb3Bjb2RlIGZvciBSQyBzZXJ2aWNlIGluIHBhY2tldC4NCg0K
U2lnbmVkLW9mZi1ieTogWGlhbyBZYW5nIDx5YW5neC5qeUBmdWppdHN1LmNvbT4NCi0tLQ0KIGlu
Y2x1ZGUvcmRtYS9pYl9wYWNrLmggIHwgMiArKw0KIGluY2x1ZGUvcmRtYS9pYl92ZXJicy5oIHwg
MyArKysNCiAyIGZpbGVzIGNoYW5nZWQsIDUgaW5zZXJ0aW9ucygrKQ0KDQpkaWZmIC0tZ2l0IGEv
aW5jbHVkZS9yZG1hL2liX3BhY2suaCBiL2luY2x1ZGUvcmRtYS9pYl9wYWNrLmgNCmluZGV4IGE5
MTYyZjI1YmVhZi4uZjkzMmQxNjRhZjYzIDEwMDY0NA0KLS0tIGEvaW5jbHVkZS9yZG1hL2liX3Bh
Y2suaA0KKysrIGIvaW5jbHVkZS9yZG1hL2liX3BhY2suaA0KQEAgLTg0LDYgKzg0LDcgQEAgZW51
bSB7DQogCS8qIG9wY29kZSAweDE1IGlzIHJlc2VydmVkICovDQogCUlCX09QQ09ERV9TRU5EX0xB
U1RfV0lUSF9JTlZBTElEQVRFICAgICAgICAgPSAweDE2LA0KIAlJQl9PUENPREVfU0VORF9PTkxZ
X1dJVEhfSU5WQUxJREFURSAgICAgICAgID0gMHgxNywNCisJSUJfT1BDT0RFX0FUT01JQ19XUklU
RSAgICAgICAgICAgICAgICAgICAgICA9IDB4MUQsDQogDQogCS8qIHJlYWwgY29uc3RhbnRzIGZv
bGxvdyAtLSBzZWUgY29tbWVudCBhYm91dCBhYm92ZSBJQl9PUENPREUoKQ0KIAkgICBtYWNybyBm
b3IgbW9yZSBkZXRhaWxzICovDQpAQCAtMTEyLDYgKzExMyw3IEBAIGVudW0gew0KIAlJQl9PUENP
REUoUkMsIEZFVENIX0FERCksDQogCUlCX09QQ09ERShSQywgU0VORF9MQVNUX1dJVEhfSU5WQUxJ
REFURSksDQogCUlCX09QQ09ERShSQywgU0VORF9PTkxZX1dJVEhfSU5WQUxJREFURSksDQorCUlC
X09QQ09ERShSQywgQVRPTUlDX1dSSVRFKSwNCiANCiAJLyogVUMgKi8NCiAJSUJfT1BDT0RFKFVD
LCBTRU5EX0ZJUlNUKSwNCmRpZmYgLS1naXQgYS9pbmNsdWRlL3JkbWEvaWJfdmVyYnMuaCBiL2lu
Y2x1ZGUvcmRtYS9pYl92ZXJicy5oDQppbmRleCA5NzVkNmU5ZWZiY2IuLjE5YmVkMWZiOGU1NSAx
MDA2NDQNCi0tLSBhL2luY2x1ZGUvcmRtYS9pYl92ZXJicy5oDQorKysgYi9pbmNsdWRlL3JkbWEv
aWJfdmVyYnMuaA0KQEAgLTI3MCw2ICsyNzAsNyBAQCBlbnVtIGliX2RldmljZV9jYXBfZmxhZ3Mg
ew0KIAkvKiBUaGUgZGV2aWNlIHN1cHBvcnRzIHBhZGRpbmcgaW5jb21pbmcgd3JpdGVzIHRvIGNh
Y2hlbGluZS4gKi8NCiAJSUJfREVWSUNFX1BDSV9XUklURV9FTkRfUEFERElORyA9DQogCQlJQl9V
VkVSQlNfREVWSUNFX1BDSV9XUklURV9FTkRfUEFERElORywNCisJSUJfREVWSUNFX0FUT01JQ19X
UklURSA9IElCX1VWRVJCU19ERVZJQ0VfQVRPTUlDX1dSSVRFLA0KIH07DQogDQogZW51bSBpYl9r
ZXJuZWxfY2FwX2ZsYWdzIHsNCkBAIC05ODUsNiArOTg2LDcgQEAgZW51bSBpYl93Y19vcGNvZGUg
ew0KIAlJQl9XQ19SRUdfTVIsDQogCUlCX1dDX01BU0tFRF9DT01QX1NXQVAsDQogCUlCX1dDX01B
U0tFRF9GRVRDSF9BREQsDQorCUlCX1dDX0FUT01JQ19XUklURSA9IElCX1VWRVJCU19XQ19BVE9N
SUNfV1JJVEUsDQogLyoNCiAgKiBTZXQgdmFsdWUgb2YgSUJfV0NfUkVDViBzbyBjb25zdW1lcnMg
Y2FuIHRlc3QgaWYgYSBjb21wbGV0aW9uIGlzIGENCiAgKiByZWNlaXZlIGJ5IHRlc3RpbmcgKG9w
Y29kZSAmIElCX1dDX1JFQ1YpLg0KQEAgLTEzMjUsNiArMTMyNyw3IEBAIGVudW0gaWJfd3Jfb3Bj
b2RlIHsNCiAJCUlCX1VWRVJCU19XUl9NQVNLRURfQVRPTUlDX0NNUF9BTkRfU1dQLA0KIAlJQl9X
Ul9NQVNLRURfQVRPTUlDX0ZFVENIX0FORF9BREQgPQ0KIAkJSUJfVVZFUkJTX1dSX01BU0tFRF9B
VE9NSUNfRkVUQ0hfQU5EX0FERCwNCisJSUJfV1JfQVRPTUlDX1dSSVRFID0gSUJfVVZFUkJTX1dS
X0FUT01JQ19XUklURSwNCiANCiAJLyogVGhlc2UgYXJlIGtlcm5lbCBvbmx5IGFuZCBjYW4gbm90
IGJlIGlzc3VlZCBieSB1c2Vyc3BhY2UgKi8NCiAJSUJfV1JfUkVHX01SID0gMHgyMCwNCi0tIA0K
Mi4zNC4xDQo=
