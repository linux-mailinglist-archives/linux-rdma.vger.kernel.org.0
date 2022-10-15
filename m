Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99C895FF8E4
	for <lists+linux-rdma@lfdr.de>; Sat, 15 Oct 2022 09:00:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229512AbiJOHAg (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sat, 15 Oct 2022 03:00:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229622AbiJOHAb (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sat, 15 Oct 2022 03:00:31 -0400
Received: from esa10.fujitsucc.c3s2.iphmx.com (esa10.fujitsucc.c3s2.iphmx.com [68.232.159.247])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFF04326ED
        for <linux-rdma@vger.kernel.org>; Sat, 15 Oct 2022 00:00:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1665817228; x=1697353228;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=TC3brXOBKbvVhqzY2+L4amp7pcHMvTxFZ7JqdwIrQJ8=;
  b=MdZ4cIB0HDSH9nvE0wv36mJ2leQLeYNaJKe+L+e5CURNz7sOzb9Zs2YD
   i0Ua64qr1xYmQ4tLf6VCcguVeQL8Rpc4pEKrcwdPyiEVs2iWuWTsgPHjA
   n1VpQ+7h35IresoQrT3NyAUVdN/7sObg8EsHuA00qgijO/+rCYzWOy3Hz
   sbIMeNqHJHFpWggiD2y03QgxBrTxZxnDjZ90BWewBMHOEfgsIqsPx1Yic
   GPwVnkdDSaas4cHT0KE7x7nYoh8uRbX9Si8quXB6zXHzHiUM1P41oyH7G
   CLtBcm0KwRpaQdhTYG/66pKFXBgE5zUkb5zy7DLv5Fqi2nbsJfw+zEnDB
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10500"; a="67689748"
X-IronPort-AV: E=Sophos;i="5.95,186,1661785200"; 
   d="scan'208";a="67689748"
Received: from mail-tycjpn01lp2170.outbound.protection.outlook.com (HELO JPN01-TYC-obe.outbound.protection.outlook.com) ([104.47.23.170])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2022 15:37:09 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l+Ld/rGfBnVJgyXwbAjtlt6Npmd446BlJ6EKet7x6KJxz8k/I77nLAALfiKGrIslub5udGnlvRZ7Q+Y4zgkL9v+PvU6sxmLPuDuhB4AEqSE/3lUyi1Tx2rh+91NUYZ6H5TNonCt9XJJDdOb7rbOStqUYxD01Y5bv8Hw/GhWVk8PLyYpodymJd8UEGs9pgyImtxA8taqSqI+qZ654W2lzzHpAskeP8Q/U7rKUSYSo256+vJQqh+gPa+SXiZxIHhqOtFU8MU49AUqTICSS3fUoowsa0BqCPYUGEE6j+KGAIUFswz70YSZDsmTJ3yOymeJaoXQVqe8P/4qR2lrpt5Sy+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TC3brXOBKbvVhqzY2+L4amp7pcHMvTxFZ7JqdwIrQJ8=;
 b=m3PWi492iMV+J2c18AxzMvFUmfJeDCoXodlK6lSRcml1vyiAmedgnolcNiK8947n3PKnOnsG2o0cLdg1VD4DwU0IC5ujPSXvOE6EoIu8qRFfjny/YB/qjrEHnFj2+91w6J1gAvpYwlYxAywmVz3GNKPTW3fC+I53N1JQ7yY780uxJaBvtBnXfAFhVvPJ+iSpAqmjG+bj/wEnaglVMUkBu2HUIu0FJTii7a1PZOYbzF6y6cWR+ELaEa3gHLwjPDoprVX1qudFxSJ1t6Z9jFY+H7Tg6qQHHM5XNk9rTZZUY75HgC4IeQcyXWpmHWSSg5Sk2nNIRGFiewaNPhsFuoj9Mw==
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
Subject: [PATCH v6 1/8] RDMA: Extend RDMA user ABI to support atomic write
Thread-Topic: [PATCH v6 1/8] RDMA: Extend RDMA user ABI to support atomic
 write
Thread-Index: AQHY4GCKxTsFRb7Tc06aZ2LJogXQMw==
Date:   Sat, 15 Oct 2022 06:37:04 +0000
Message-ID: <20221015063648.52285-2-yangx.jy@fujitsu.com>
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
x-ms-office365-filtering-correlation-id: d5d7f7a1-e8de-40df-16af-08daae77ace2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: fnP65/7i5BeRgHkcCxENv9kVVVKLacMa8/0k7KvUj8RfmhRHLJAo2rl+xo30Bv0jQ3V27U0oCE8t4XN92UD0Dnf7aLSkfxOBvKXdi8EyNH9axu/Wrjxk4eBtaspmq9Wqp21ILXLbOhkajwPsw3L4Xsw0k+5C3Y43sEUFVrev968xYF/R3xFhx4wff5mStsO0vwLYEQD9XU+CnET2V4SfpUcwHMr8SLr4mM7CvtggPqMySJ9ew2Bx67fCKlIWUuNCS8xvQ53Okwfakm0DY+5qs1jFetRT7L1m0k9DFr1Cls8CUZP3o8NUCbot1aYQiG01pVEM8+V/6iIie75WtRmm8UV9zYFEA7TRJDJ5lp9BA/fKs4yofD9fdqOgD3kKUZmPiEz61Hm4AQAUw5ikiI8bZK7FjbgbZxfVTbQAIx08j2PIPf8ydZixfa4cp8PdeqJp4sUN1+/sfqLMZBzAPkXDfMYNg8r212PRH1iVqRmZIESrJIlCGXJDbOPbYdsTMWA75oRK6fp08aQXCmnwvrUGn5YS/8V6oGvZG1Mmu74cPgKnc9DUbLDLjaVvO3l3NglC6SupgQkWhfb6xlG5U6xyoFDlAxuro8owqdoKm1rx5PYN+0fDydxh6B1EF9BwscQeHpGUq20pqOEiqlpQB5xB75SPX0OwBUZ6TqnP+gMJm7sGz6cYH3gOl7qxyDyQzGe0BJ6lIjre73DENK3hC6c6dx1K5mDuMVW1J0M8VppRUNY/rWEBKCBpNg3RX2tPNBw+9HRVTPHljO/JdV83IENHRlKKKLBHpnVjU4MNLWLA82c=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS3PR01MB9499.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(136003)(346002)(376002)(366004)(396003)(451199015)(1590799012)(6486002)(85182001)(316002)(86362001)(38100700002)(36756003)(5660300002)(110136005)(26005)(6512007)(54906003)(478600001)(122000001)(83380400001)(8936002)(82960400001)(91956017)(1580799009)(66946007)(76116006)(2616005)(107886003)(66556008)(66476007)(38070700005)(41300700001)(71200400001)(6506007)(66446008)(64756008)(8676002)(2906002)(4326008)(1076003)(186003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?eXdBVDVaa0o3NFJxRzh3ZGFSMjd1S2hkdHRLL2RnTklPZEVrLzgxVGI0bEhP?=
 =?gb2312?B?ZTdjK0ZhZUduVi9nNm9JblRMKzdQMU9HdGVjM2d3NjE2QlZCTUYxWGhlaUkv?=
 =?gb2312?B?SkVFb2JlN1ZwZzAvQmlYNVhnWVpQWjN2ZzVXdXdYVFdpV2d1aXkydzZ5c09E?=
 =?gb2312?B?alh2K0tMTHFWazdiaWFreTRNbTVWQS9BWGFQVlhWRG9yR0s1T0Q5cnB2VTdU?=
 =?gb2312?B?MTVNNkxzVERRbXdscjhSbmt6dXd6TmpBbklIcVFJRHBiNElzVE05a2FBRTho?=
 =?gb2312?B?Z0kyb0VVSGFKUmNkeW5mNEdpWmQrekh1cCtocDJzb0RacGd4KzNnTTZlTDdz?=
 =?gb2312?B?dkl2VVFwOU9FdFYweUJHWjlXTERCTkNVNGFYVmZ0MmZ3SXUzaUpyUUFUZ0VF?=
 =?gb2312?B?T2F5Z0NDcjVKNTZXSHl6OEpDUTBzQzA5TFRTR0hSTTRvUkswelQrL25wLzBs?=
 =?gb2312?B?bUFVcEIxeEZXdGlybUpDaXArL0xsTkt1MHJBamRuY2xMbkVCTWt0SHN4dDkv?=
 =?gb2312?B?K3hCNUpCOTlhY2VtVFl0Wm9zZk5RYW93NzVvWU5URHNBV3d1L0lpTVFoQWxz?=
 =?gb2312?B?dlNoSTZJakE2UXUyN0s0Sks2RDZJeWFITWhuek1nSXM2bkJiQmRrdEdDVktP?=
 =?gb2312?B?Qi9IblZlS0lmY1VpT1pZSlU4bEFuYUdIUi9tbEFMODZLbkdtaURVcThsd3N2?=
 =?gb2312?B?aXN6S0pWMHR2Ny83VjZHaE9KS1c3Z1pjR29hWHl2YVVLU3JvVUdSOWxlY2Fr?=
 =?gb2312?B?TXA4Mlk5WlJtYXlERGdldC9IaG5nTEthM3QxV01UNmNXaVpCMHp1U2RFMS9Z?=
 =?gb2312?B?OGZmWGhZR25iMTBBbFVUc213b2l5OHB0M3c1UnUyeEpoRVJENjgvV3pLazBt?=
 =?gb2312?B?ay9OcFJyMVRrSEIySklPSmd2bVhONC9ETXUwM0l3VlJmNEozOTdMVDBxU0RN?=
 =?gb2312?B?Z3RnQzA3VmdJU1VFTGJGT2RCbjV4RmNjSHAyMURzL0pXVldWRXkyRkxMMmJm?=
 =?gb2312?B?RGJlN25seDFMWlVTU2M3dUVkNmh3KytMSHM2emtWazF4M2RlaWl6TUE1TmE0?=
 =?gb2312?B?MGpDZHErcWl5TzA5S3l6b0NNY0NHYXhwM2NYRFByczVVTG5zcThDa0NQTkNi?=
 =?gb2312?B?SGZoUm9BRU5rUHJGUVByME1BOFg0OUZWdysxKzNRTU9Nc0lmbWlRQ2wyY203?=
 =?gb2312?B?TjNqVzdHRU52Qlo4clZEbWdjSks4M3BkMXBiU2labXN4Q29pQWYrN1lEaG5I?=
 =?gb2312?B?d0cyQXM0UlpySjZhQVpNblVWOFFtdDRCQ1JZa3dpV2U3bTJ1aXRVOS9ha3NK?=
 =?gb2312?B?YklJcmszL25MOHpPY3VlL1BtQkdIdkZuYTFpMzVNZ3MyTWp3ZlZDYW9lYkxv?=
 =?gb2312?B?ZTdPek93Wm9tcml2NlN1N05JZTF4ckJ2K3pWZnJqcGFjSytwUlliN3FYZVB2?=
 =?gb2312?B?NUx4YnBObHNCblBaQ0NBREFtcFYxNE43NUZ0bXF4TTJZRVU1M2Q4bHE2N1Ew?=
 =?gb2312?B?R2RKSUtyd0hsY1VyRmZ3bUlPWkJsb1RvL3V3bDFKQjRzUjZjR1dDanZhd3V3?=
 =?gb2312?B?cnVWSVVRQkl1QVFMQmpuWmNPUDkvQWNaY2ptcTQyWm1NeHRUQit3ZEVVQXN2?=
 =?gb2312?B?RVlMdStSS1VXOWtqQ0FEMG1ZaWV3K21XRmpqU2tJc3NiMmpHRGN0bk9hcUd4?=
 =?gb2312?B?NTNjT0dRMWNGVFB5RkNneUVZU281S2dDaUZVVGpUZW9PclBxNmRDMHVIMmFB?=
 =?gb2312?B?b3BuR09ZejVhRExFRWxmZ2FZYlphS3B0cU15MTZzQXEvUXcyR1NSU1pOSmZX?=
 =?gb2312?B?NUZUdUE4dUFoZVRFNjIyMEo5bk1IR1V2bXBHTXJpOUhSR2c1VjcvQ1ZPdm5K?=
 =?gb2312?B?VEJBYjhuS3BaTHE1dm05OEVRSi9sdlM3ZGZVOUxDem9Xb2FQZ1FhYU1KK3Fs?=
 =?gb2312?B?OW9iSE5vdE9nS1BiSlhDbWZZRUI5RUJBREdpOGg1SFNQTmFnRE45ait1cStT?=
 =?gb2312?B?ampWcmxHWjZPWFVjelpIb285T2dsQ2JIOGF3RmVMdXgzNnNqR0dBVmhxczQ5?=
 =?gb2312?B?V1lwV01UbHR4Z0xNeTBMUTlhY2FQMVYrUHptdDhwUk5KVWxld241VzhuRCsy?=
 =?gb2312?B?L0s4bEhXeVViVmtSTEZESWdCYjFqekZ5MlFLR3lENnd1LzBIZlhDWVo0cUVE?=
 =?gb2312?B?SXc9PQ==?=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS3PR01MB9499.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d5d7f7a1-e8de-40df-16af-08daae77ace2
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Oct 2022 06:37:04.5249
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xZigelg/3cMemEBzKhgCN84QBMtKNYLAnFfJ1IuuGorrRENo85xalXFtndwTKXNC/NoBFGLm3CaKUZ05i2rfsg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSZPR01MB8661
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

MSkgRGVmaW5lIG5ldyBhdG9taWMgd3JpdGUgcmVxdWVzdC9jb21wbGV0aW9uIGluIHVzZXJzcGFj
ZS4NCjIpIERlZmluZSBuZXcgYXRvbWljIHdyaXRlIGNhcGFiaWxpdHkgaW4gdXNlcnNwYWNlLg0K
DQpTaWduZWQtb2ZmLWJ5OiBYaWFvIFlhbmcgPHlhbmd4Lmp5QGZ1aml0c3UuY29tPg0KLS0tDQog
aW5jbHVkZS91YXBpL3JkbWEvaWJfdXNlcl92ZXJicy5oIHwgNCArKysrDQogMSBmaWxlIGNoYW5n
ZWQsIDQgaW5zZXJ0aW9ucygrKQ0KDQpkaWZmIC0tZ2l0IGEvaW5jbHVkZS91YXBpL3JkbWEvaWJf
dXNlcl92ZXJicy5oIGIvaW5jbHVkZS91YXBpL3JkbWEvaWJfdXNlcl92ZXJicy5oDQppbmRleCA0
MzY3MmNiMWZkNTcuLjIzNzgxNDgxNTU0NCAxMDA2NDQNCi0tLSBhL2luY2x1ZGUvdWFwaS9yZG1h
L2liX3VzZXJfdmVyYnMuaA0KKysrIGIvaW5jbHVkZS91YXBpL3JkbWEvaWJfdXNlcl92ZXJicy5o
DQpAQCAtNDY2LDYgKzQ2Niw3IEBAIGVudW0gaWJfdXZlcmJzX3djX29wY29kZSB7DQogCUlCX1VW
RVJCU19XQ19CSU5EX01XID0gNSwNCiAJSUJfVVZFUkJTX1dDX0xPQ0FMX0lOViA9IDYsDQogCUlC
X1VWRVJCU19XQ19UU08gPSA3LA0KKwlJQl9VVkVSQlNfV0NfQVRPTUlDX1dSSVRFID0gOSwNCiB9
Ow0KIA0KIHN0cnVjdCBpYl91dmVyYnNfd2Mgew0KQEAgLTc4NCw2ICs3ODUsNyBAQCBlbnVtIGli
X3V2ZXJic193cl9vcGNvZGUgew0KIAlJQl9VVkVSQlNfV1JfUkRNQV9SRUFEX1dJVEhfSU5WID0g
MTEsDQogCUlCX1VWRVJCU19XUl9NQVNLRURfQVRPTUlDX0NNUF9BTkRfU1dQID0gMTIsDQogCUlC
X1VWRVJCU19XUl9NQVNLRURfQVRPTUlDX0ZFVENIX0FORF9BREQgPSAxMywNCisJSUJfVVZFUkJT
X1dSX0FUT01JQ19XUklURSA9IDE1LA0KIAkvKiBSZXZpZXcgZW51bSBpYl93cl9vcGNvZGUgYmVm
b3JlIG1vZGlmeWluZyB0aGlzICovDQogfTsNCiANCkBAIC0xMzMxLDYgKzEzMzMsOCBAQCBlbnVt
IGliX3V2ZXJic19kZXZpY2VfY2FwX2ZsYWdzIHsNCiAJLyogRGVwcmVjYXRlZC4gUGxlYXNlIHVz
ZSBJQl9VVkVSQlNfUkFXX1BBQ0tFVF9DQVBfU0NBVFRFUl9GQ1MuICovDQogCUlCX1VWRVJCU19E
RVZJQ0VfUkFXX1NDQVRURVJfRkNTID0gMVVMTCA8PCAzNCwNCiAJSUJfVVZFUkJTX0RFVklDRV9Q
Q0lfV1JJVEVfRU5EX1BBRERJTkcgPSAxVUxMIDw8IDM2LA0KKwkvKiBBdG9taWMgd3JpdGUgYXR0
cmlidXRlcyAqLw0KKwlJQl9VVkVSQlNfREVWSUNFX0FUT01JQ19XUklURSA9IDFVTEwgPDwgNDAs
DQogfTsNCiANCiBlbnVtIGliX3V2ZXJic19yYXdfcGFja2V0X2NhcHMgew0KLS0gDQoyLjM0LjEN
Cg==
