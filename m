Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 164B65FF8D9
	for <lists+linux-rdma@lfdr.de>; Sat, 15 Oct 2022 08:38:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229470AbiJOGiX (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sat, 15 Oct 2022 02:38:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbiJOGiW (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sat, 15 Oct 2022 02:38:22 -0400
X-Greylist: delayed 70 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 14 Oct 2022 23:38:20 PDT
Received: from esa5.fujitsucc.c3s2.iphmx.com (esa5.fujitsucc.c3s2.iphmx.com [68.232.159.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF6D763857
        for <linux-rdma@vger.kernel.org>; Fri, 14 Oct 2022 23:38:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1665815900; x=1697351900;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=KeXePYeIaul2A5wGX9HpugWWfq3Xbbo6VKhMq4yVs7s=;
  b=idLWQ8Ov1DDC0AnwVStJK12hSpBDGwDxlmabDLLY3J5w/ZjYaT2Ep0Kj
   Chs79BEW6On6pERbPdZeGbfjo/AYc9qDwlxg4Q+W1ut5cSZHwdzmlpj0j
   5REtd7HE6K4QCVxHyjNcECrKgAqaFlQkyrJdUqxOYI478Fc6e1RR7knnS
   vjBqn2pKePDqcm4YAWXRiW+5rLjP+DnOlWTyg5frcsxWH36TtFvrOWrMS
   DSOBhTOfRwcJqZuhHf3O5L6fKZTXJ9WaPSdabaSNsPPExQEVe7tpuio4n
   OxWhOBLe7u1eQoTEiNFr7JGrPzbUbNShrfVhYshA+3+y+kq3RlpQS2Eht
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10500"; a="67758725"
X-IronPort-AV: E=Sophos;i="5.95,186,1661785200"; 
   d="scan'208";a="67758725"
Received: from mail-tycjpn01lp2172.outbound.protection.outlook.com (HELO JPN01-TYC-obe.outbound.protection.outlook.com) ([104.47.23.172])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2022 15:37:13 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KIdchzXorGNqencFxsrmWpCD2dQpsYK3BzlVbsiuL2t/S/4BnN/bjrUd8omtVPYUTe267hEPM2WKc5PrdfHiBsTD1nrdFeL6BFlUaxl0uLISJXyncHElkLsGykntUDbmYeraHPAzdw3AhxW90uveLwA/pHK/ALG+X+YFLTC4Pz65f2Ec4quxpfmM0JemNbgKI8uOAwzxREnDSks4PKAKqHRzw0QRAMwKy0uR2sISCVaeRmxuuqL/EoPgugTZXSOwdkmAT3ZTl1cZttxNn3Fai6yUHLGwdz92LyeljHoER5wrvsxUJeLu6ToiUuL3RM+cKArSAfFBo3NWJWHssFEnOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KeXePYeIaul2A5wGX9HpugWWfq3Xbbo6VKhMq4yVs7s=;
 b=cXUXR3qenFdyuwCaMe+G70m2IeBsrLuSBThzO6aQ4FjYt2mnKVrjaajN0mqi7ZMIOUTy5GnMyl3hOsWpNAkL//8RWy6yKPr7EYikk7x+SdY1P8Jx9CL+W+QA/jNTNld7bspliTL+DioJXLfO12QAUYOYNF6z68t4sVaD3YYB1UyxdNgl2Twh2CxoIFnq9CUK1YUOsSA7BfR/QwZEp9hA+ZPgTLRDSmiSwoSUw0u+wzkeK67M8J2NG6oq+9r5W2gEsjgOP/tO/vgJCWIZ4UOPd1siHWrtzIBgSdafMaOhMeiZVNA6oqu/JHlkXhBjSKy7uE3dWCoQS59tIQyrYFdZzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from OS3PR01MB9499.jpnprd01.prod.outlook.com (2603:1096:604:1c8::5)
 by OSZPR01MB8661.jpnprd01.prod.outlook.com (2603:1096:604:185::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.29; Sat, 15 Oct
 2022 06:37:06 +0000
Received: from OS3PR01MB9499.jpnprd01.prod.outlook.com
 ([fe80::5989:c90d:abf4:e100]) by OS3PR01MB9499.jpnprd01.prod.outlook.com
 ([fe80::5989:c90d:abf4:e100%6]) with mapi id 15.20.5723.029; Sat, 15 Oct 2022
 06:37:06 +0000
From:   "yangx.jy@fujitsu.com" <yangx.jy@fujitsu.com>
To:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "jgg@nvidia.com" <jgg@nvidia.com>,
        "rpearsonhpe@gmail.com" <rpearsonhpe@gmail.com>
CC:     "leon@kernel.org" <leon@kernel.org>,
        "lizhijian@fujitsu.com" <lizhijian@fujitsu.com>,
        "y-goto@fujitsu.com" <y-goto@fujitsu.com>,
        "zyjzyj2000@gmail.com" <zyjzyj2000@gmail.com>,
        "yangx.jy@fujitsu.com" <yangx.jy@fujitsu.com>
Subject: [PATCH v6 3/8] RDMA/rxe: Extend rxe user ABI to support atomic write
Thread-Topic: [PATCH v6 3/8] RDMA/rxe: Extend rxe user ABI to support atomic
 write
Thread-Index: AQHY4GCKq0h7+6p+dkuko51BHClBmw==
Date:   Sat, 15 Oct 2022 06:37:05 +0000
Message-ID: <20221015063648.52285-4-yangx.jy@fujitsu.com>
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
x-ms-office365-filtering-correlation-id: b478c291-0667-4323-4579-08daae77ad78
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ebF6QMm5uKjIXubPDv7CdtqJA1UFHr+sI+NbekrwQLL7Yy+BYSG0iZonjNUplxBX/73qhKJRVnaPGmmsxPwNh3WofZbkRhDAAzDh2Ah9+s3uUIVGjQ2XAOE4a0HpXvRN7kLRgDcwo+T1c/J9OpBDycJRGtf5LVQpeE5IeLoAY2uZ9nZjA92T8Bc8obi/ZY2zlSJpXY3wqUJFghiGt8UUdvNrrWIwX6QiDCT/JBSoEGltEHt5oiyYmXJ+eSjV3+qHRqPPqS+mWZmtLMnAFtmwTIQtna5oLLIKdhMA8G2oXfiJf0d7oSO+LVTOwxNbj4oUPx3xa6ro+9Sn7U9AfjyV4F6VGhu3xCR1FpvabXMdWaOXNmgFz+P9dNn2UDTrN97HCZpYa/Nzfks7Db10S5c72A9L2WkIi94+Q0VOTyG62eqJgwiC7WlCfa7nTWtLS65P2hbZkqIBuyKLAuzXQIi6mtXvuUDjanHnk4IId/9VqzLIG+Y9Inl7YS81saW1VmuvMRCaZee/oGp874/q60K9/nmPLiu2p3UOsHg2SoT58Dl4Lq/5XODDTAdGD/0tiBTx034Qzhi3rzsjvqhag7YZaVzlmZy7iSHcFG1bBIbu2nVqKZjuY8VWszKDQnw+Re9vnSNqqX74/nkNp8WmtxKWmGTzZ5lN7cyu+K82B5VS/ChrkC6HkGi0rcfYd+TWcYHU5eVeCRT0Ksm6wFGdc1JacOvwhZ+CpnoN7puTvIFHElaDhJXw2x8b/E2M8MUTgzcXZCCVZpoJlt9+KvNksA5Q0yAAhPu0eNQ4J9xjIysZd2E=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS3PR01MB9499.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(136003)(346002)(376002)(366004)(396003)(451199015)(1590799012)(6486002)(85182001)(316002)(86362001)(38100700002)(36756003)(5660300002)(110136005)(26005)(6512007)(54906003)(478600001)(122000001)(8936002)(4744005)(82960400001)(91956017)(1580799009)(66946007)(76116006)(2616005)(107886003)(66556008)(66476007)(38070700005)(41300700001)(71200400001)(6506007)(66446008)(64756008)(8676002)(2906002)(4326008)(1076003)(186003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?dUFwRTcyNW9kam1ybitTTHJZbzJZMzlGVVJMMlVLL2U1RTRsd2NGeXEvd3pJ?=
 =?gb2312?B?YVRKdlFIb251djNmamlGZ0NDUGNkWmhoRVRXTW5UendMRkM1SjBWajk2NW4z?=
 =?gb2312?B?ZmxYOTRBdmFKN0xSTEZyNWdCQm1pSTQvYy9rVlVXVFM4cFZaNXF5T0txVkJV?=
 =?gb2312?B?QlBrKzgzQzlGYWtHK2E5aGFHK28rZkdxR2dJcDdCQjNtbmE0bURzeWkveW5G?=
 =?gb2312?B?ZzdWcDdSU01DeWZHUFpvcDh3dlJPazVHTDRDVldITU1QVXYyZE9hS281QS92?=
 =?gb2312?B?UEl6c2UwZWR0TWFmTENOd2pQM3BScVZVU3NwckY0MUR5K1BPWVhRdnpJbVg3?=
 =?gb2312?B?Z2RPRU5lL1l2THJ3NG53MmZ3T21RNlIybktVUC9UbUZ5eGlOMi9PeG4wSU16?=
 =?gb2312?B?aE1EWXBxZGZ0Rmh1S0Z5RGRBQVNZelAwZXV4OTNibVdZNTVscjFRckxsc3pr?=
 =?gb2312?B?TEdRME0wYkZCMUxUeGIreUVUOFRyeXJWK284dEEwYkZjV2ZBYVRBekFQMStH?=
 =?gb2312?B?OHBwcWNKbjRLZDVieVRhaW9LU0xCeWF0UmVlbHZHSldQWjFXSWNUWUJoYWpP?=
 =?gb2312?B?aG5KQk5VL0JSMkZXMTBoSTBLTjlXNGFRV1VYVE5QSCtsd3pyamE2UDMyYjV6?=
 =?gb2312?B?cmN4dDBLTVU4RllxRmUxYjN1bXVGRXlkbVd3di90dEZxMTV0KzNDdXkvY05s?=
 =?gb2312?B?eno5aFJDWjE0OUIwRzRCV3J2K2dFSENvc1ZMTGMrelhjVW9DR2Z0V3NLMUE0?=
 =?gb2312?B?Q2ZKUkFYQ0oydzQrcUZuOTB5WGtoTEFaT0VPV2VUUi9meWJFekI4bVNaRTI0?=
 =?gb2312?B?Unl0NUxhdmQ2MUxFdW1WaTYrR3NSTGpZcEhyRHJ3b3hpeTRqWjhFOHFRSXJu?=
 =?gb2312?B?ektMTmpPVkhTVzdWMnZ0cjNKUUlwR1BINWJqazZ2T0wrZ1FSbHJRNFRSMEU0?=
 =?gb2312?B?QW1vekYyZkRsTVVzRE5IZll1cjNscU1sU2JBUGhEVlN1cW1PbVpmZzhjVm8z?=
 =?gb2312?B?VEhOUGJrOHNDQUpqTkRlRXRPcFphUXhyRUVIbFZPZzFmc1BCZUJ1R3ZCTkMx?=
 =?gb2312?B?Z3VGZUtWTDVIMXlZcFdFS2tvS3c2azdFUlVFUTJ0U0FrRWlVcmRCRkhKSG1E?=
 =?gb2312?B?VE56TVo5a1FSZFY2cmNvOXVDamZKamk2dlRJdjFVditJdk1oZlVsRmdOT0dS?=
 =?gb2312?B?TnBDTFdLMS9HRmxobWZLaTJSWlgxNTR5UUVuZE9Jd3AwL3BDMmUwWUFyZGZV?=
 =?gb2312?B?UWRQaXdUWXFKNzFQMHo2b2pSdHNWNkdtMzJIWkxvK2dKNXF0NnhyS3JZVG5H?=
 =?gb2312?B?VDBkZS9rTWlvRW9zaDZIaEFub3FXNFNrMHhUeEMvUGlWL2FjZEU1bkNyYmdZ?=
 =?gb2312?B?U3pMdFVRMGVlUEh2eWhWQlZqUEJVVlJLVGUrQ3FwaTkrNWpTVk5zWGFrR0hD?=
 =?gb2312?B?d3I1NHFCR2ZjYUpLL1NTSmZaV09VdlpyZVd6cG5RdUNZdmRyM3RFdG5DNXVN?=
 =?gb2312?B?T0FGVUxtN1VUeHZMN1M4YjJFMXYzMERjT1lURDBDeWg1NjQxSnJUblhGSFh4?=
 =?gb2312?B?cHZOYkFEZWFmc1RQbWJKbVMxQWdHQlcxYysrb25WY3dsM2xGY0RPeTFqdGhr?=
 =?gb2312?B?RzRaclptNm9WcWxZTGV4YzhIVkdWb3dCYWxmWEd3SmhQQnRmUktQYnAvNnpN?=
 =?gb2312?B?TFpiQ2taZGc1MERMTGQwejJUcytWSm1mMklQcjVXaGcwbS9wcmNxSjRldVNB?=
 =?gb2312?B?SHE1QTMzR0d6NTZsT29Vai9pSHE0YmVoY2xORnZiN2o2NVd5bXBhbHFjNmZa?=
 =?gb2312?B?c1NYRnRHSHdBZVhJMEdJY2dEeC81a0w5bmJwSGZHTGxNSGFscmJxbVh4Kyti?=
 =?gb2312?B?ZnZRVis2RjFDL1BsMDFFR3d5dFAvKzIzUjh2TnE0N0NvSkVNRmkrSXFjUFZM?=
 =?gb2312?B?eEtHK3JTcm9EY25rV1lJOU1FZ1NUcWdwUEs0NVdnNUZaTEdJRVh5OHFIMmMr?=
 =?gb2312?B?OWZ5VG5WZjl3OWhqYm5hS3dyYlVUYjRlVE5ja0d3c2MxbGkySTgvd1VreFYy?=
 =?gb2312?B?QkNiZmFXbkpzMXBWN29FMnFsWU1Xb2srS1BTbWtSZ1ZVMW9YS25pRU1oTE5w?=
 =?gb2312?B?T2lvVmgvTWZKaWY3cmNJZ0s1TWJKMmIxNFgreFRnZDhiaFZkMi9sYS9Sd1ho?=
 =?gb2312?B?NXc9PQ==?=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS3PR01MB9499.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b478c291-0667-4323-4579-08daae77ad78
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Oct 2022 06:37:05.8216
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WocYyh7qcVVRSsWSJ3IQM1Z092dLuzlcurilQuNpHgjfeDZ7zBTqDDG1H9W2ePDybc3WHPlIsVI1mY9M89JeTg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSZPR01MB8661
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

RGVmaW5lIGFuIGF0b21pY193ciBhcnJheSB0byBzdG9yZSA4LWJ5dGUgdmFsdWUuDQoNClNpZ25l
ZC1vZmYtYnk6IFhpYW8gWWFuZyA8eWFuZ3guanlAZnVqaXRzdS5jb20+DQotLS0NCiBpbmNsdWRl
L3VhcGkvcmRtYS9yZG1hX3VzZXJfcnhlLmggfCAxICsNCiAxIGZpbGUgY2hhbmdlZCwgMSBpbnNl
cnRpb24oKykNCg0KZGlmZiAtLWdpdCBhL2luY2x1ZGUvdWFwaS9yZG1hL3JkbWFfdXNlcl9yeGUu
aCBiL2luY2x1ZGUvdWFwaS9yZG1hL3JkbWFfdXNlcl9yeGUuaA0KaW5kZXggNzNmNjc5ZGZkMmRm
Li5kMjBkMWVjZjA0NmYgMTAwNjQ0DQotLS0gYS9pbmNsdWRlL3VhcGkvcmRtYS9yZG1hX3VzZXJf
cnhlLmgNCisrKyBiL2luY2x1ZGUvdWFwaS9yZG1hL3JkbWFfdXNlcl9yeGUuaA0KQEAgLTE0Niw2
ICsxNDYsNyBAQCBzdHJ1Y3QgcnhlX2RtYV9pbmZvIHsNCiAJX191MzIJCQlyZXNlcnZlZDsNCiAJ
dW5pb24gew0KIAkJX19ERUNMQVJFX0ZMRVhfQVJSQVkoX191OCwgaW5saW5lX2RhdGEpOw0KKwkJ
X19ERUNMQVJFX0ZMRVhfQVJSQVkoX191OCwgYXRvbWljX3dyKTsNCiAJCV9fREVDTEFSRV9GTEVY
X0FSUkFZKHN0cnVjdCByeGVfc2dlLCBzZ2UpOw0KIAl9Ow0KIH07DQotLSANCjIuMzQuMQ0K
