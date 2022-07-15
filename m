Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CFBE575EC9
	for <lists+linux-rdma@lfdr.de>; Fri, 15 Jul 2022 11:44:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231954AbiGOJoy (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 15 Jul 2022 05:44:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231347AbiGOJoy (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 15 Jul 2022 05:44:54 -0400
Received: from esa19.fujitsucc.c3s2.iphmx.com (esa19.fujitsucc.c3s2.iphmx.com [216.71.158.62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7D1D804B5
        for <linux-rdma@vger.kernel.org>; Fri, 15 Jul 2022 02:44:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1657878293; x=1689414293;
  h=from:to:cc:subject:date:message-id:
   content-transfer-encoding:mime-version;
  bh=R7dFcJ5JJKifmSEdP5j2CaC5iiJbqPEl67GcyKETJ+A=;
  b=p/CG7zqGpRk+cB3rMoWsP/XxsG37PUC3WqBLiAoqYgifsYlzKA3ZCOoL
   caUMchSlK5/yhraRz54JEYvWxtWV8bS397AfAh1/og4RovVlIrzDg48fJ
   ilXcKrytVwZ9ssMS6NN1Avvm8Z+EKBS04i8D5uS9FeHrRHtKYq+ehMPOP
   3hqeejff11LOg4VmGL27L2MkbNZCPV/7ciFspnUrQRiZH0nXY6MXOa/hj
   gjsoDJDjV4H4w+sRR59rplncKTCmtH5sr1YIc0EM8hSUCuqhL60s3Gj9M
   LvKynIm1IfpNu/pe4vL7slhB75LuMVneg4OSRjSdKMcpRD2ai+NJyTaTm
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10408"; a="60139903"
X-IronPort-AV: E=Sophos;i="5.92,273,1650898800"; 
   d="scan'208";a="60139903"
Received: from mail-os0jpn01lp2109.outbound.protection.outlook.com (HELO JPN01-OS0-obe.outbound.protection.outlook.com) ([104.47.23.109])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jul 2022 18:44:50 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WEEY1hZkkyci9E5h/XDDloQWSvXXebEhJ71BmGB5xFsPfoWZ0FvNEJBv4HieIgXyg4Fwb2vy1I/kepBy9OKYSHOoiF7CYTcwHXZGAQ6sxyJT/m9rm4LT/sIkvaNPKH7IEJMzq+pShPEZc2SPg6R8h75eHdM8TbEt2SbZ5JXMN8QigkkSdWhgIb/t0fb8lDbrtv6mvEhwRVPKfxaNbflZ9lZ0UQ+suoSF9ZmH8KIa3UlXoC1n4seJUwSn4vxF1q44fVTup8+RoKrobM1pDewBvzCnmHeNuTKta/V/hiPOp1pOy0OeywssnxbByYsRq6wp+muSFW6rFQGoBojQR0NBPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R7dFcJ5JJKifmSEdP5j2CaC5iiJbqPEl67GcyKETJ+A=;
 b=PDSY8lGfEY65PBPQpH2dKdl1fe9opNnYHGbiA8EjUD/gZoTsG/Q2RRNQYirthzR5NMr6SfhxsFtBKlJdemfKAcZ/8lffxWbgnz0tTqLPBQK6neMzSJTBrzm/iBpJzZkgpa925GOLt4JjGjNEbZCvLvBTAQYRUf6fnQwZeXLbMM6ufNs0Ke3a7fVoWL2bbvWB3MvC+J5C9YXH6xbgdsqKs/MuICf3ND25ElrC3d2ceEPyc9h1+nDee/G9Gm5aWPgKTWfxs70Rlm16vYkCVf+1JRq71+bh4utHeE95aXGxDOeQi85n3SO3/24DUlG9H83H+i8k6nguwP3PslSYB3xdgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R7dFcJ5JJKifmSEdP5j2CaC5iiJbqPEl67GcyKETJ+A=;
 b=VXmmeaanhyqHl/aivTqK+2eXTohmY5YG35oge2WA4jjubt7xkowUE2HYAHGQlZL0PtKm1AH+zIjb2ujzd41l8Uh0UAhbvL7We849700KjHTKTZiiP9nM3j+FWwa9KUERTy4u/i7bNC5JxS3I/lQRqBIWy7cykXXtoImRcHiDmJg=
Received: from TYCPR01MB9305.jpnprd01.prod.outlook.com (2603:1096:400:196::10)
 by TY3PR01MB10354.jpnprd01.prod.outlook.com (2603:1096:400:252::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.12; Fri, 15 Jul
 2022 09:44:47 +0000
Received: from TYCPR01MB9305.jpnprd01.prod.outlook.com
 ([fe80::8d7a:baa8:3b18:cd93]) by TYCPR01MB9305.jpnprd01.prod.outlook.com
 ([fe80::8d7a:baa8:3b18:cd93%7]) with mapi id 15.20.5438.014; Fri, 15 Jul 2022
 09:44:46 +0000
From:   "lizhijian@fujitsu.com" <lizhijian@fujitsu.com>
To:     "leon@kernel.org" <leon@kernel.org>,
        "jgg@mellanox.com" <jgg@mellanox.com>
CC:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "lizhijian@fujitsu.com" <lizhijian@fujitsu.com>
Subject: [PATCH rdma-core] tests/test_mr.py: make cases description unique
Thread-Topic: [PATCH rdma-core] tests/test_mr.py: make cases description
 unique
Thread-Index: AQHYmC+EC+JNR3zngkKZ6EX5K66rPQ==
Date:   Fri, 15 Jul 2022 09:44:46 +0000
Message-ID: <20220715095117.1902874-1-lizhijian@fujitsu.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.31.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3a2b910a-4a0f-48ca-e4d2-08da6646a775
x-ms-traffictypediagnostic: TY3PR01MB10354:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 9PXsuQlRxXo8I7EqxKGxcZ9PSG01fnaOicIruGMD3GKr08xgJayCrx3ppcc6KUIX45x1Z4T1dB5W3nyY8J4SKWR7zoARWGW/QwJUXhrwSmEljBTqcEm0KLWb0k8GFlf0k6UL4heopZs+p2F2fySdryFCbNcP5bCeMtrCIIkqRrhqrrLxg+ZcVtE+aOWY9+ip8AEbEn+2/bunoFoXbuXrQRd+4fPS+F3/kmX+gH17Ce7hEJ28BcXfn4C0MkxCwBDrXkgj7WYwxwe9TdwbuJhClgMvghxGn2E6r2pIUwX+dRmRNA6zJgrvEPkRfBp5Eef5yrYgPkx0QKw/5RUKlxtftj9jCfUF4YcA+VmfJKfVaY05Jsy72d3nkP92aFI+O5XrjNp4PZtkUmqk1PGwyUMjy/q1hCgScRd64lfezbcNBHVm9w5IlBClnKCJlxbKBEBjhKl53HMX4kNcIucsKp3cYskJP6KsVgv04cG1mv8AX1CcG07O41PWANN7/Fr9R7HC0lVi4zcsTiN077rmi9Rh3ILQMcDArlNDG8Tn2sspeUlX4V/EILA9ATOAmIcZ0acfRrNKdHSZbVHhP4vLaR9GbxKeGr1Nhws/wDYUExOpk9kjPS9RCtR0xrHzZYRn8iR9i6Ew5mat417lfC2cHZSttebLnxgrYl6F2Ppt4kyKPNVLghA9VAXKJm5x8NbkACBDInGj64KgJzKKGIzcUt+t7dmYERc/WLomrZCsvzN6hX75Z265Ln0W4OL5Tjav3OqD4ocMLiezLyUvtE4DA56NLcNjDX/EFG5vavBpvPq1Z8x7luI8SFIYOk0I8k3Koyq4
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB9305.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(346002)(366004)(376002)(396003)(39860400002)(136003)(110136005)(66556008)(186003)(54906003)(66946007)(76116006)(316002)(86362001)(8676002)(66446008)(4326008)(36756003)(2616005)(85182001)(66476007)(107886003)(6486002)(1076003)(64756008)(2906002)(478600001)(4744005)(8936002)(26005)(6506007)(122000001)(83380400001)(6512007)(5660300002)(41300700001)(71200400001)(38100700002)(38070700005)(91956017)(82960400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?ZkgwT3NuUE1YdHJlTkQvYklLNklEU2RyZGkvcWwvUjlxdEMzUlVHOUUzNlpF?=
 =?gb2312?B?U0wyenRnTGdhVzVRNDdBb3ZaU3BCZUR1bU9hSEorejVlK0QvYXBVelI0UG9q?=
 =?gb2312?B?dFp0enQwakFFOExhbjdGNXpXY3U0aDlidlNzRSs0ZGhvYjl3WnFXNTZJd3JE?=
 =?gb2312?B?Q1VIMGxMcElrOTlqZE55YVZIcFlxcG42RWxrcWorZTFLQlFPcEMxczkwZVV0?=
 =?gb2312?B?eEFPRE9rTjV5bzFoRURocGpWOWNLem9xOG1Iei9KMm16UXJuSXluT3EyYkN0?=
 =?gb2312?B?WHF4NFpDeUorU1o0UkxMa2JMejRwVm1GbnQvU2RQVGdGT0txZkVDb3dJaytG?=
 =?gb2312?B?eE9jWGJvL0NMeWlUUVVPaGFOUFZxek1YcjhRTU90T2x2RUhUUmlxc0xOWW81?=
 =?gb2312?B?WVhyUzFtMHlGQ3ZJdHVBdmw3UnNCK1VNcWZyMXVYc2lBWEE3VlRHZ0ZQcFVV?=
 =?gb2312?B?b3RnWTZlVSt0WDJzUmdKemtkMWlNUC9PbDFPODZjMldNTWN3L2orbkNIdXB4?=
 =?gb2312?B?SXkwSTMyaTJQUDF2N2VPWXhjUSs2ajlJQ3BNVzNVaXJ6TlI0KzBhcWJlT3M3?=
 =?gb2312?B?b1pRSW51ZmtIZkY0UUtOTDVGdmJzTUlqaWtFMjhtOE1wL3JiWFNOdnFib2xD?=
 =?gb2312?B?amlSSVdqUUhSWVo4eGVUS2pUdGFIOS9ERHZHWktGZkx3cHk1TzVLd016bnNp?=
 =?gb2312?B?T2ZiQk8xNjZvcTBESDhOWmROVlIzVEtDdXFOL1A2WVVQWUQ5RTlCdzVtcWFu?=
 =?gb2312?B?Vkc1ZmxNb2QwWkpYM0lhT1FINml5THB5U01QeWswQjdpdmhxcjBmektBdC92?=
 =?gb2312?B?dWRZNVFWOEFoWTdIZDhMRk1la240NTVDT1ErWFk0bkdWQ3RKQzF6YlYvbkVR?=
 =?gb2312?B?ZitPdUxvbnNWMEhEZGtMZlQxbldFbEFyVXhVRmcyQXRGRzhYb0VEdDFBMURY?=
 =?gb2312?B?Snh3TkRRaUFYaWV4MGVoZ3NtRDFFQXE3a1hYcXJUU0xSRnJQRXZsZ1FBT1ZS?=
 =?gb2312?B?UHRzTDVYVUFnT200U25Jc0sxYTRYTlI5T1pJeFpPRWRoaGowQXpHRnhpekFz?=
 =?gb2312?B?NTRHNitwc2JJQTZ0ZmNLb1hpNDRBM3FRY1U4VkJMdnJoekpwT3d3Y0pKbEpX?=
 =?gb2312?B?VTVPOTd2MEVFeTJ5S0tYbUhJckdiS2l5ZzdNZWJOU0JXUmk4cUtjS1pVWTZC?=
 =?gb2312?B?MC9ybGY1RlJyWlZBZ3hNTmhlSVFpeFg0b1FVazdHUUk0ajExczh4TzJReGo0?=
 =?gb2312?B?Q0traThSOEUxWDZpb0I2ZzArTmpLMXpSTjE1cGRSSzRYa1NnZkkwRlpjT0dq?=
 =?gb2312?B?S2VxYVFLb0tFRlhXTWtFbldrMithMFk4MEprSlJiVHU5bDd1Y0p2blQ1a3FK?=
 =?gb2312?B?L2w2TW5VWlZGRGd5Q1NjY0hrNmlRY0RoTVVqUmc0K2RGc2p5SnBRQ2d6RHli?=
 =?gb2312?B?SzRNVWtRT05ITWhTd1NLdHgyd3pZTzFLM1oxbG1ZMFNXOWtFTnpOOXYweDZE?=
 =?gb2312?B?RmJJK1U4L1c1d2QvbVlYWUJmbEZhTyt6SWpzOGs2RHdjR3JzZFZId0IvM2hK?=
 =?gb2312?B?ZWsrSFZEUWNmWW9kdDg5L3pXUmlBaGpBMzdtNUl4OUk1THdFK0NLeXF3TEhG?=
 =?gb2312?B?anBBc0dWWlhmbzgySm5NTTU4QlJaTFRIYUVBRVBaMUtNYmcwK1hvVU9NMko0?=
 =?gb2312?B?ZzdHaU15ODV1TVhDdDBFNEJTVXZsajVXWDJDZmRjNmdiUVRodjFkNEl3VmFP?=
 =?gb2312?B?R2V1R01CVWdBeGdueURTeDQrdFl6UFRvbjRselRaVDBWNzVLQUFQV2dTNzVI?=
 =?gb2312?B?QzYrTEpqRitubkF3anpzdUZjbGVZZmVLN3dqS2YxcDc0WXZUdTFManJNL1BY?=
 =?gb2312?B?UXB3VWFGRWRsVEtzNndpYXVndW0yZFp4b0NxZkJzKyt4S3ArNWNOMXJoUXdm?=
 =?gb2312?B?aHJTU2pLZ0paeFUyN3dwT0ExUWhHK2F0OFM4RmdOQWkrczAzdkVTTWFEQm80?=
 =?gb2312?B?dWVIN1FzbVA5UVRmbXM4aG1DMU1pR29VOGNlTkwrcFpPN0oyT0JOVFRwYTBh?=
 =?gb2312?B?VjMrWTllSHlvdHNmaTdWUUx1aEF5K1lZUDFRd0FnMVNYdzN6L2pTc1UwS0hP?=
 =?gb2312?B?TXNPdU9EQnM3bU5VNVRad1Nld0hSVVF6VmtLM1FHa05ROFNSL2RkSzlKVVht?=
 =?gb2312?B?eFE9PQ==?=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB9305.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a2b910a-4a0f-48ca-e4d2-08da6646a775
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jul 2022 09:44:46.9455
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kaRZdv2c9n0IW1OgMWKlkBiidZ+PacyZbzpQOcCC2/oc27yB1cIVHKpCHBsOLkaNMnGYySAGT0umyCwVV+T3yA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY3PR01MB10354
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

W3Jvb3RAcmRtYS1zZXJ2ZXIgcmRtYS1jb3JlXSMgZ2l0IGdyZXAgJ1ZlcmlmeSB0aGF0IGlsbGVn
YWwgZmxhZ3MgY29tYmluYXRpb24gZmFpbHMgYXMgZXhwZWN0ZWQnDQp0ZXN0cy90ZXN0X21yLnB5
OiAgICAgICAgVmVyaWZ5IHRoYXQgaWxsZWdhbCBmbGFncyBjb21iaW5hdGlvbiBmYWlscyBhcyBl
eHBlY3RlZA0KdGVzdHMvdGVzdF9tci5weTogICAgICAgIFZlcmlmeSB0aGF0IGlsbGVnYWwgZmxh
Z3MgY29tYmluYXRpb24gZmFpbHMgYXMgZXhwZWN0ZWQNCg0KVGhpcyBkZXNjcmlwdGlvbiB3aWxs
IGJlIHByaW50ZWQgaWYgdmVyYm9zZSBpcyBvbi4NCg0KSSdtIGdvaW5nIHRvIGFkZCBweXZlcmJz
IHRlc3RzIHRvIHRoZSBMS1AgQ0ksIHVuaXF1ZSBkZXNjcmlwdGlvbiBjYW4gaGVscA0KTEtQIHRv
IGRpc3Rpbmd1aXNoIHRoZSBjYXNlLg0KDQpTaWduZWQtb2ZmLWJ5OiBMaSBaaGlqaWFuIDxsaXpo
aWppYW5AZnVqaXRzdS5jb20+DQotLS0NCiB0ZXN0cy90ZXN0X21yLnB5IHwgMiArLQ0KIDEgZmls
ZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMSBkZWxldGlvbigtKQ0KDQpkaWZmIC0tZ2l0IGEv
dGVzdHMvdGVzdF9tci5weSBiL3Rlc3RzL3Rlc3RfbXIucHkNCmluZGV4IDNlYzFmYjNmMzJlOC4u
YjgxNTllNGNhNTA0IDEwMDY0NA0KLS0tIGEvdGVzdHMvdGVzdF9tci5weQ0KKysrIGIvdGVzdHMv
dGVzdF9tci5weQ0KQEAgLTUyOSw3ICs1MjksNyBAQCBjbGFzcyBEbWFCdWZNUlRlc3QoUHl2ZXJi
c0FQSVRlc3RDYXNlKToNCiANCiAgICAgZGVmIHRlc3RfZG1hYnVmX3JlZ19tcl9iYWRfZmxhZ3Mo
c2VsZik6DQogICAgICAgICAiIiINCi0gICAgICAgIFZlcmlmeSB0aGF0IGlsbGVnYWwgZmxhZ3Mg
Y29tYmluYXRpb24gZmFpbHMgYXMgZXhwZWN0ZWQNCisgICAgICAgIFZlcmlmeSB0aGF0IERtYUJ1
Zk1SIHdpdGggaWxsZWdhbCBmbGFncyBjb21iaW5hdGlvbiBmYWlscyBhcyBleHBlY3RlZA0KICAg
ICAgICAgIiIiDQogICAgICAgICBjaGVja19kbWFidWZfc3VwcG9ydChzZWxmLmdwdSkNCiAgICAg
ICAgIHdpdGggUEQoc2VsZi5jdHgpIGFzIHBkOg0KLS0gDQoyLjMxLjENCg==
