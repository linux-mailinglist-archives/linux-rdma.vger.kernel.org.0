Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21B274CD2C8
	for <lists+linux-rdma@lfdr.de>; Fri,  4 Mar 2022 11:53:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231582AbiCDKyb (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 4 Mar 2022 05:54:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231475AbiCDKya (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 4 Mar 2022 05:54:30 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE23910874A;
        Fri,  4 Mar 2022 02:53:42 -0800 (PST)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 224AYQPQ017342;
        Fri, 4 Mar 2022 10:53:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=cKOdzaaIYdbXf9rLAYrheyU/hjE6kyOKuijMftKOkLs=;
 b=tZDirLam05h7jhcMnDqIibmeaFWb1RQlPM74ojmWk40llQprTtv7WkbiQ1cyfikKWGXv
 siIb071/fLI/eyDUagmCJxu+CwOvJK6Q5DaxwStgq8FQcnXyhuD0dTbQvrqqF8kaWfD2
 GfrW7wcCptvLDbLUY6dk/d6ZF606EREDN+545qI3hcuH2X/+lZe57CQe50ikqsNW/cuO
 eVgWgV+TS/i1QRK5f34zycX0k8e0oohFWoprCfX8tOhrOrCs0hHGvrIokYQBjxYRhI7m
 YAR8yAyiD++I+inC80QE10Ks4BDAH0gxm8B5FgjWMK6jZepIp7Ui0XJMoLb0cMmvVy12 Sw== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3ek4hvhfyu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 04 Mar 2022 10:53:38 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 224Ao9kC117633;
        Fri, 4 Mar 2022 10:53:37 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2107.outbound.protection.outlook.com [104.47.70.107])
        by userp3030.oracle.com with ESMTP id 3ek4ju5fph-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 04 Mar 2022 10:53:37 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EFUQE7ujmOBFvWOvG+xvIxLVI3SvutL4W56Ln2cPN/R421EPpHfQI7KN1uD5c7XzxKFhInn1AmWvIdwzIF8os+mO71mA6yFQ/vSMbZjLbDjbS46XAYiei6pQ9dPBb53KcmLHA9+Qk9qxfPHK/oReBfXjslP5/cvRZUtRiGgyXOmUQJwsNmU1uHW1Cl4enTS/DGIMEz/aBOPi0hIdtC0S5XPpVfwuLkvDwMC/pkf5q4jaV1R1PYMYMgGCqH5H5S9Kukv5cLp30ru5t3rw7D4zt/R4hXHYxJfb3dvOIztGi989SOag98lT/Qs00qEJOMdkOMyxFH4ONay2yW3XTrUnGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cKOdzaaIYdbXf9rLAYrheyU/hjE6kyOKuijMftKOkLs=;
 b=A8QFAC1Ki2GBflUinxDcHCsHMDHVjHuH05Mx6ZwUb3ZhH0IOYZJkYdGVxLGpjkZcXSXlf6pjZlR+UggPf97VY9ZZ16oChlm6gIcitB7QlhuAyVK5nfg1gzoGTWba5tQjFEf5sZAICh7tbfLbWhYEbGLM5YMjW3OrXzkbCyRMPKFBzn2PkHtEnaBKYRhGSQlgyUvt3HqFZAQpswYgZFcaCofJs4gEqALE7j3wA2OK0JFGcekwWjak5HR83N/J66TRGrchwtrOM3W0l/kgxtZo1ubecMIfwsKTXnYaFx3625FSm9skJLCFZvGFUpyMEEqSA0x9tkfj1oZmY/iF+K9s0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cKOdzaaIYdbXf9rLAYrheyU/hjE6kyOKuijMftKOkLs=;
 b=pLs8P2R1KAjhlnlZjoCHqgNaDoZ0KR9Nm8725r0tjYA6DaK02h3qYrNNkW0h2KT5qRSjUXw8eAxYTbjXUKVH4eldQSdh2Dw1KFOYxiuxdQa7HpevSiXnHYGKngsQ8dyBlaBXpF6yszp0iPRtSui/aVyrE7+d9LkDog8EffKZz2o=
Received: from SN4PR10MB5590.namprd10.prod.outlook.com (2603:10b6:806:205::5)
 by MW4PR10MB5838.namprd10.prod.outlook.com (2603:10b6:303:18e::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.13; Fri, 4 Mar
 2022 10:53:34 +0000
Received: from SN4PR10MB5590.namprd10.prod.outlook.com
 ([fe80::2968:7984:753d:fad5]) by SN4PR10MB5590.namprd10.prod.outlook.com
 ([fe80::2968:7984:753d:fad5%3]) with mapi id 15.20.5017.026; Fri, 4 Mar 2022
 10:53:34 +0000
From:   Haakon Bugge <haakon.bugge@oracle.com>
To:     Leon Romanovsky <leon@kernel.org>
CC:     Jason Gunthorpe <jgg@ziepe.ca>,
        OFED mailing list <linux-rdma@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH for-next] Revert "IB/mlx5: Don't return errors from
 poll_cq"
Thread-Topic: [PATCH for-next] Revert "IB/mlx5: Don't return errors from
 poll_cq"
Thread-Index: AQHYLwWxIDYMU/9nHk6wDZNQiA+hIayuBkAAgAEH5AA=
Date:   Fri, 4 Mar 2022 10:53:34 +0000
Message-ID: <726B8D27-B7C7-4779-A56B-3AE9266BC208@oracle.com>
References: <1646315417-25549-1-git-send-email-haakon.bugge@oracle.com>
 <YiESUNnzBBN5fRCl@unreal>
In-Reply-To: <YiESUNnzBBN5fRCl@unreal>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3693.60.0.1.1)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: fcca37fb-e9a0-463f-c328-08d9fdcd3af3
x-ms-traffictypediagnostic: MW4PR10MB5838:EE_
x-microsoft-antispam-prvs: <MW4PR10MB5838C22AFABBE831957FC2C4FD059@MW4PR10MB5838.namprd10.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: kSuRron0VoUf40LJuN9QKVEPrqt7YN0gP9v5JI8NOT+dVUN42rZM+PnY+XUXz0nFVZtnIBlEu1YsHLYa/z+hgkVvD+/7wja/LiWF0WvjmrSp8SI1jZhVYjNtIHAQHVFSzcErAr2W5qDATh3skXjrsUIFUi5LJP2ItjvfaCH2cL+iAKgJMhEhUyV3MmwZilxEmB33UMrYJEEyabL1W9wo45NlowaG1BcgX0S3D2aFjieP611AgQzUkg0zjBzBOk/xZhr7INYJCxr4G+CEIh8Uv6JTGiY/6vN4FizXh5QqchfZwKM3gfhOqiVzLy0yUlJg1gGpXVIDCzI7VMnkAG3pNS6528q6JjeHCMtALj5oS3W6yW8pG1w/pNiTTQMlV4Rt4G5V5EQBGBcAaRRroE4C88p8JtNMddC/vwyu+jeBzGl+LRWosXi66g7UuI8r72RSe1dkoyHTG9sLxkwYfSGvEdU8G2/D9/Af0Hg+W5ork8+rHD36a72/gCM6BWcJq++tV3RrsMy18P0efh8Dc/uaiJ0Y0GxFvOswCwRkaAiCKCvv8VoeD4aMLIaGD3AXPl3C/p86ZmNQf97CJ9bJDLstzZUKL8ULF9O1JBDbyX18RnMk59I97IR9uFNycCRvOHf6yL+YQzoKewPT+nWSdh0zc6OClq1qRwoYYptI5u2PmaMenxYbMIkbTLASwXrnILN0gkos8pig+q2SFOJB2gE2RUJd8yUFOlliYyvRbwv163H9qNO8a5X3j9o7uVpgAP5/cMO6THw1Je2rXThVWb7FWg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR10MB5590.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(8676002)(4326008)(66946007)(66556008)(66476007)(66446008)(64756008)(91956017)(76116006)(6486002)(6506007)(6512007)(2616005)(508600001)(33656002)(53546011)(36756003)(316002)(4744005)(44832011)(86362001)(2906002)(38070700005)(186003)(26005)(66574015)(122000001)(71200400001)(54906003)(6916009)(83380400001)(5660300002)(8936002)(38100700002)(21314003)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZlBhS2VhbzV3a0FpZDV3YUpKeW51dnlMd0hKdXRVVWEyUFBqRUJ5SDdUZTlD?=
 =?utf-8?B?MU55S1pVNWtrS1Q5dkxHZkJaaHc1L0h2RG50bHQyY3hERFBqbFAyMUZ0N1NE?=
 =?utf-8?B?eUZUdGdZWkVWcXN0U092cW5WRm9UTHZRK3E0VW1VL3ZrRS9vVWFNSlhzb3dk?=
 =?utf-8?B?cmZxU015OGhmQUZyU1ptRXZTS29sSHVMaHNSRVI0M2VZd1B0QzNna2lyalU0?=
 =?utf-8?B?WTFrbHBZRitDY2VBSmVFQWxwR1h3cFBLZDdwSDIyaVJqaWIxYk9TS1ZJemhu?=
 =?utf-8?B?VG11T3FQd2hjTHJoOGFPb0pmVVpKcVNFTVo2VEZ3a3dIUEpoalIxaTkrc0RS?=
 =?utf-8?B?ejhYSm9PaG9pajVxek40eWZnYy9NZUQ3ZXhXdUR5eEJBVXFXMEZYMm5pQ2dD?=
 =?utf-8?B?a0JwbWp0N0hMK1hhWmRBa3VOMlhYZ21mRGpRWVliZytpWjRmazdnUmJwK1F4?=
 =?utf-8?B?TndzN3JVdnplMXRabTYxdndFalg4eWN6L2FlbGNNNmlUU3ExQ25XMnJSZm5v?=
 =?utf-8?B?UTZtTlNqSjZQTnFaRGs0NmpFWm90VDcxWElnVmlCWjJObnowbkhadWw2dk12?=
 =?utf-8?B?MUlCbjRjejFwRnJUYUM2ZEF3NjZHV1BGcVh6d0JnampjQzExZndETWtRQzdj?=
 =?utf-8?B?OWpWRWJaTVhGb28waU9LRHlmYWRHc2xzUE95ZlRJS1I2Um40V2c3OHNpbE9V?=
 =?utf-8?B?RXZvRElzNTV6WTY3bXh2RFlIR3RKNWhmdk12UHNCMXlBd0ZzcVF2WlNacUp0?=
 =?utf-8?B?dXpCWmZFbHVGTyt4Mmp0T2NJQmM1Vk5IY1NYbWt6QTdQdkRsZk9MMERSbWpB?=
 =?utf-8?B?MG41US9KYXlURVZZdFVrUzB1YXJ0N3NSMkVKTUpUSjVBdHNzL2J1dFlVVTg4?=
 =?utf-8?B?Wm9hdDV3NmVHOEthajlvNWZtT2hMV1FxT0xXSVJ5dUtHaTdLQ3FlbFJtR2lz?=
 =?utf-8?B?UkZheUo2d0g4M0Y0NmwzeUNyUzJUamhLZ3JPTzJBeHpuUHg5dm9kWlhoOWh3?=
 =?utf-8?B?Mmk5Wit4Wmx5dVJwZDhvYjJNWXg4bDJoU3Uzc3dRL3RmTmkyNmQySHFKUEU5?=
 =?utf-8?B?QVpQSndML0hwYllnNlhpejk2QjdqU1Q0a2VqWWF5WFVHNEkxejFNby8rcGhz?=
 =?utf-8?B?a3JkTVE3ci9CdC90bnhDbk1vODdwNHRHRWVMc1dZcndyMVhVRFhDbWVtTTJy?=
 =?utf-8?B?bFlGQlh0WkliVll4RXhoblhSL25hZXNzTEFnZHV2SVJqSzhRQmFGQ0NONzZa?=
 =?utf-8?B?RkpxbHFtWnhESVZTQ0k3TW4rYldLWVZHWXFKQ0loQVB1QUJ2bWlMV1Rmc3p4?=
 =?utf-8?B?TURUS3QzYUtQUCtlS0k0Z3NvbWZ3TlN3QS92a2F1eUVGbFlIOHV6UkVDb05N?=
 =?utf-8?B?bDRmVy93c2YzTk90YjZzOEVlSTFramRibkp2RXlqZGt3TWRtdXRHYkhiRVph?=
 =?utf-8?B?dXVHdkhYbVFDL0xUelNSM3JHWk4xaFRrU3VkZ0tnK25sTmJWM3FxNFNja09x?=
 =?utf-8?B?OUZKYlRNR2R4UVVpWGVWSFNSU0xmcS9TMFpLL0RNSlBWZGdyNWlOek5yRlVP?=
 =?utf-8?B?LzFpL01ZK1U1Y0NBbWI2VUNjbVBabFphU2FTT3F2MHRVV2x0NGxNYWFoUksz?=
 =?utf-8?B?WHgvZ0lQUERYYTFSVm9hY0FMT2ZZMytkdmMxWEducHQrZ1JMd3F1NUlOMFpD?=
 =?utf-8?B?blJ0RVlXbngvOXFzaEpVM2pZNWdJeWZQM2JUZDZ4Q3ZsOWcrMW1RRTFQUWZL?=
 =?utf-8?B?M0U1NHVRT0crSXRFc0luc2JvVm4rMGdOZGFUWTBOS3c4TkhuU1RTUFlsUi9w?=
 =?utf-8?B?NFhwU0ZVSWNFTEY3TWxTK2dsMm00WmlxaW1sbE5kUzR5YWJkelE4R0tEMlZJ?=
 =?utf-8?B?WTRpcnRxTHJPZWxOa2tkOWVsT0IyOHZLM3RsMEhjS2UzeXhucmxFa21ycVhF?=
 =?utf-8?B?cXBBWmVzOXJLdWZ4U2VMVm9DdzBTbjYvYUsxVlZ3MXRqbVRRUlBNc3owRlRl?=
 =?utf-8?B?cDBOVzh6WDd3VDV3dmNTL0Z2WEhZaXJmbEZ5cDlpNy9tOWxlcndrdTFWZGQ3?=
 =?utf-8?B?UEVFWi9QVGhTcGgrWDdFSG9jeERLajVWamhjZitES3Y4Y044ZzlPYUlHSzg3?=
 =?utf-8?B?RlZ6RjVwRVc3TXV6a3pNUzV4dUZtL0pmMkMreW9kWFQzUzd2NnptODN0Y1Fj?=
 =?utf-8?Q?sbZXeuZjcCcru7yv3UCVH/M=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <89CBB592386DA1459ADC685CAC792DFA@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN4PR10MB5590.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fcca37fb-e9a0-463f-c328-08d9fdcd3af3
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Mar 2022 10:53:34.8031
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FMz3IGeSJpZJGwYSbC/xW1TpYYCSbjRqNBcM4tR6KuY5mpL0GYjsHawO/KcYWZ8BGMPSZHtKwHDsAph8Eau+CQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB5838
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10275 signatures=686983
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 spamscore=0 adultscore=0
 suspectscore=0 mlxlogscore=999 malwarescore=0 phishscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2203040058
X-Proofpoint-ORIG-GUID: 6Meu9ZXTZ0Ft1Y0q6ZZIplSxCo7dazk-
X-Proofpoint-GUID: 6Meu9ZXTZ0Ft1Y0q6ZZIplSxCo7dazk-
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

DQoNCj4gT24gMyBNYXIgMjAyMiwgYXQgMjA6MDksIExlb24gUm9tYW5vdnNreSA8bGVvbkBrZXJu
ZWwub3JnPiB3cm90ZToNCj4gDQo+IE9uIFRodSwgTWFyIDAzLCAyMDIyIGF0IDAyOjUwOjE3UE0g
KzAxMDAsIEjDpWtvbiBCdWdnZSB3cm90ZToNCj4+IFRoaXMgcmV2ZXJ0cyBjb21taXQgZGJkZjdk
NGU3ZjkxMWY3OWNlYjA4MzY1YTc1NmJiZjZlZWNhYzgxYy4NCj4+IA0KPj4gQ29tbWl0IGRiZGY3
ZDRlN2Y5MSAoIklCL21seDU6IERvbid0IHJldHVybiBlcnJvcnMgZnJvbSBwb2xsX2NxIikgaXMN
Cj4+IG5lZWRlZCwgd2hlbiBkcml2ZXIvZncgY29tbXVuaWNhdGlvbiBnZXRzIHdlZGdlZC4NCj4+
IA0KPj4gV2l0aCBhIGxhcmdlIGZsZWV0IG9mIHN5c3RlbXMgZXF1aXBwZWQgd2l0aCBDWC01LCB3
ZSBoYXZlIG9ic2VydmVkIHRoZQ0KPj4gZm9sbG93aW5nIG1seDUgZXJyb3IgbWVzc2FnZToNCj4+
IA0KPj4gd2FpdF9mdW5jOjk0NToocGlkIHh4eCk6IEFDQ0VTU19SRUcoMHg4MDUpIHRpbWVvdXQu
IFdpbGwgY2F1c2UgYQ0KPj4gbGVhayBvZiBhIGNvbW1hbmQgcmVzb3VyY2UNCj4gDQo+IEl0IGlz
IGFyZ3VhYmx5IEZXIGlzc3VlLiBQbGVhc2UgY29udGFjdCB5b3VyIE52aWRpYSBzdXBwb3J0IHJl
cHJlc2VudGF0aXZlLg0KDQpUaGUgUkMgZm9yIHRoZSB3aGFja2VkIGRyaXZlci9mdyBjb21tdW5p
Y2F0aW9uIGhhcyBiZWVuIHJhaXNlZCB3aXRoIE52aWRpYSBzdXBwb3J0LiBUaGlzIGNvbW1pdCBp
cyB0byBhdm9pZCB0aGUga2VybmVsIHRvIGNyYXNoIHdoZW4gdGhpcyBzaXR1YXRpb24gYXJpc2Vz
LiBBbmQgaW5ldml0YWJsZSwgaXQgbWF5IGhhcHBlbi4NCg0KDQpUaHhzLCBIw6Vrb24=
