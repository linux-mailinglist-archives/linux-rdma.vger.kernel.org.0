Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61C5154538B
	for <lists+linux-rdma@lfdr.de>; Thu,  9 Jun 2022 19:55:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243520AbiFIRzs (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 9 Jun 2022 13:55:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237431AbiFIRzr (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 9 Jun 2022 13:55:47 -0400
Received: from mx0a-002e3701.pphosted.com (mx0a-002e3701.pphosted.com [148.163.147.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BC0BB04;
        Thu,  9 Jun 2022 10:55:46 -0700 (PDT)
Received: from pps.filterd (m0134422.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 259HO1rn011670;
        Thu, 9 Jun 2022 17:55:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pps0720;
 bh=i9stPyAh03NlG/ekS8x+bEn3lOTThKN/EIr+B80QEuQ=;
 b=B+O2nxDBQc/iqGIpPuhTYH1K4is48usgvS+o4/pICrgE4wzbjG3luZfusi4KMDGv8CQ6
 IExafR2uYZAHZ91fx1z5Mi4ckp6FSSXlozfZMQvI7RKLtb8jvv03D/t0EhXPxOuyR3Np
 7szZG8ju6mZJhU8kQhbA4hTQ0lMJuQkpzP7mUkdFhtANLRlZJvN54LoCGu37PaAdFavv
 bRzTqOpIF5cHXqYET08zN3CcjdSsCiLiD0zWNBx4CBlONaiZaZqF0hMxcDGnhhsyenoe
 eF/Ti4qhmphuu+iLFANmAT7/ylqYa52mwDTHKhqmfIzvAE49jWdeVcTZNqmP4yU7GNU7 6A== 
Received: from p1lg14879.it.hpe.com (p1lg14879.it.hpe.com [16.230.97.200])
        by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 3gkn7n89y9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 09 Jun 2022 17:55:34 +0000
Received: from p1wg14926.americas.hpqcorp.net (unknown [10.119.18.115])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by p1lg14879.it.hpe.com (Postfix) with ESMTPS id 8E18812E99;
        Thu,  9 Jun 2022 17:55:33 +0000 (UTC)
Received: from p1wg14928.americas.hpqcorp.net (10.119.18.116) by
 p1wg14926.americas.hpqcorp.net (10.119.18.115) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Thu, 9 Jun 2022 05:55:25 -1200
Received: from p1wg14927.americas.hpqcorp.net (10.119.18.117) by
 p1wg14928.americas.hpqcorp.net (10.119.18.116) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Thu, 9 Jun 2022 05:55:24 -1200
Received: from p1wg14919.americas.hpqcorp.net (16.230.19.122) by
 p1wg14927.americas.hpqcorp.net (10.119.18.117) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.15
 via Frontend Transport; Thu, 9 Jun 2022 05:55:24 -1200
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (192.58.206.38)
 by edge.it.hpe.com (16.230.19.122) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Thu, 9 Jun 2022 05:55:24 -1200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JiBcTKm+88fdMH38P958kf4Fs0KLQNq/MNwZL/RxWO0VZWQvFc/n42x8LqxDgzqxbqhEKTVViWeTsyqEMzBIc+OOJAosgv9Y2XF+q6pX5frYPsb09r3Jc4BopSWzqkTzuFW1to8JVJwlhf8sv0KI42Xj+kwATxHmJ4U/pCrTFDKgHaIyeEdsoU7xTj9ImTk8X6AU6CQIFLiZu01jWnHGfTrM6rGyLsHcsu6ja3y/6yjp/OT2x8K8DS7SssfnxRvnLAJossnvaforXI9rOrBodbHTCQq5ZxLAUWgDBUCkEhe9WodH+02+r0ZdktHdJFmT8IPsFdZIFr6idDcnZRq2hw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i9stPyAh03NlG/ekS8x+bEn3lOTThKN/EIr+B80QEuQ=;
 b=hyRCzKWwCtYnn2zevo4+FIND8PYuqZcxordMf5+gEJZIXpVfu6DgBhHaX0IY2XGJ5MQQ9W+MB7l9guolKCwONu8jv0LJS9cYZTMrN6ck9rIK7NiZLR0R7fwIOWGWfjno/qehq1PI9xSVzOCdq5lV9DovzL6hWtFhMSltZmR+hvD4nYiqsdu2UeEWddffGPvTJvR/dpRLP3aM0/6SqJ0H6Jgu6IbZuko3XbYQNUqvKQwYDpJaGG3AbhZaD97mfbrkfqonZv9VK4SuGscZQipFNmhv2Q5dO47RWMgAi171wftHmQfxAQxHfOMZuv4O5TvE81suAgrpR6eq78Dn4KfWwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hpe.com; dmarc=pass action=none header.from=hpe.com; dkim=pass
 header.d=hpe.com; arc=none
Received: from MW4PR84MB2307.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:303:1b6::9)
 by DM4PR84MB1373.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:8:48::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5332.12; Thu, 9 Jun 2022 17:55:23 +0000
Received: from MW4PR84MB2307.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::f43e:903d:5607:3455]) by MW4PR84MB2307.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::f43e:903d:5607:3455%3]) with mapi id 15.20.5314.019; Thu, 9 Jun 2022
 17:55:22 +0000
From:   "Pearson, Robert B" <robert.pearson2@hpe.com>
To:     Dongliang Mu <dzm91@hust.edu.cn>,
        Zhu Yanjun <zyjzyj2000@gmail.com>,
        "Jason Gunthorpe" <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>
CC:     Dongliang Mu <mudongliangabcd@gmail.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] rxe: fix xa_alloc_cycle() error return value check
Thread-Topic: [PATCH] rxe: fix xa_alloc_cycle() error return value check
Thread-Index: AQHYe8w+2yZay72k50eVgVKIyyjJRq1HXHBg
Date:   Thu, 9 Jun 2022 17:55:22 +0000
Message-ID: <MW4PR84MB2307D50DF516055A90805B21BCA79@MW4PR84MB2307.NAMPRD84.PROD.OUTLOOK.COM>
References: <20220609064242.1444485-1-dzm91@hust.edu.cn>
In-Reply-To: <20220609064242.1444485-1-dzm91@hust.edu.cn>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1d4c919a-03b4-4783-4b1c-08da4a4139a8
x-ms-traffictypediagnostic: DM4PR84MB1373:EE_
x-microsoft-antispam-prvs: <DM4PR84MB1373BECDA6C153D6020EA032BCA79@DM4PR84MB1373.NAMPRD84.PROD.OUTLOOK.COM>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: r6It/lajawIcT9Oa5uCQg0gjL1t23rmQkDbMdyS9n2BnAt/dqk9T8FVl1d3ZJOs8Ywf8/YA96Pp1EtFdo/5vZP3yliZBJ3fTi6z06salscR9E88m8xx2aF118wXOrSHfMC5mCO/V3DP4xspVGjAsasXJU9OLkDHb43D0R/iT133sCDRmpbCgqlTXHC5jLs3mFgVpkiqgvRjqX/q8nUh0wrwAKb8C1xKa4pJ4QiLhQx3LeBXo3v8x0gAOEUvfc5q8nqgi+zXe97PzC7WSOKPAdbvUjjryMuu8vEOyg9q+1D0H9NMpWGSGZYed0UitPYT25ckAzehK8grgh4VkHTlxWwO8Qr7PkPMJcuvXBDGvIX5D9dmUnRNvniO+qVgDwZ9hnUV/428A89RvJDUjB7QIEKAq5fXgBvFf/RGw0a6RwFqGFmtX2G/O9/CodAcMu4V3bijqqROUmN82qNkMH+RjgL6gLfXLI3cERp4ZoMPYMlG6VZXVWfy5RGXMsM1P9Gd9AIljDkcxCm4PJuXp5ewiNeGOUHZMCLJZVWl/pZSj88rhBl0nWZh7U5vZOiG5ETuPGulG/sKPAnZnUDBcuql+8f6qkks4SqHHMSV1unuVV2jVm6TH378mv18jO/WZruum+RlaQI13onCTz4xSAPEB7xzecviuI9E0BVOeXUtolD6b27B8wU8Cwy6vbVG2ZP7Bw4qQTpzl6+GpqJzy71BGWA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR84MB2307.NAMPRD84.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230001)(366004)(71200400001)(26005)(9686003)(7696005)(2906002)(6506007)(52536014)(33656002)(508600001)(186003)(86362001)(53546011)(8936002)(83380400001)(5660300002)(38100700002)(122000001)(38070700005)(316002)(110136005)(54906003)(4326008)(66946007)(55016003)(66556008)(66476007)(76116006)(64756008)(8676002)(66446008)(82960400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?2FP4vyrP/BmJt/R6koT+JDxg+GGguiTHEfli4YtzVPjTeMJHlryfjmHSK7If?=
 =?us-ascii?Q?FHce63hENC4PTx96l6JcU4Jd51+l2FCsW7E8oSlVoS1K/l3dnahMnRwOB3Ys?=
 =?us-ascii?Q?EJVY863/16aVdMl82YFU8XtFWU/TgLcT/9pjVlYgxgcQRvOBQ0CMwEZ8SnBV?=
 =?us-ascii?Q?pLfLhgtWeja6XpWJt+OzV+iDw4JpSYCiMypK5ceRrGAw7qzxW4GctlRFKr9t?=
 =?us-ascii?Q?aFxdGreXWgqhrKXSYvTfCir8KKiJ9XkBmyul7npVBGQTUyln3exkfKEmodce?=
 =?us-ascii?Q?fiHli8NgrnOYsurLRqrMfLkTEu5GIsRpbIm2dIK4TapPmr3DtS8krCBqQEP8?=
 =?us-ascii?Q?TMl7YqjgHLT9inABc7f18DLX8i8mlSVA4Dd8FHXwsz81/q0QKWIo6tfUd+Gn?=
 =?us-ascii?Q?fdvA/fjuAi3Ao7gSgcl8M5zIhLfTppNv4OoBNDX0wqmPE1qi2oPw1mZSjSDJ?=
 =?us-ascii?Q?3alti2lCeVnlYS+Ha4+FPr224knhzNgZhrewLFwd50YlAt8hAPIq5hZz35+O?=
 =?us-ascii?Q?cweHJbNuw1XzxidiPMDGTLpeXsdaZtp2IrTiVA9JaEH1mWHlDFtoBsm32bWV?=
 =?us-ascii?Q?5qzMZO1M8XUEEyf4nGlYkODyt86EUFk6cSbFXRObPr2FWRSO42+6Fqp8n2cu?=
 =?us-ascii?Q?kYH/YFdiCkKZYJtZveVYsc2bpv41EDnmYhK1BWwdM2b0pndPJjjTxZKO6bfq?=
 =?us-ascii?Q?a9eFBgAXXuqpc1FAIiEddHI+6XJ2CfG/TyEttLM/iM6Bf3wt1weczMrMdAfe?=
 =?us-ascii?Q?dE+r6Vm8n6cG9iMTcNUfiHzskQzl/0NV8THQVTvDWW65XwFsWjnfzULc0ZaY?=
 =?us-ascii?Q?kIESPWls/jj9a9DVtZt7gmbx+Mek38S/FjvddgzEh9bkN9OORHw+bov3HE+R?=
 =?us-ascii?Q?udmTKPVCCj4XdQDtCSMiVwFWOiVqzxsbcoYAiiJbN6WaC9Z3037zx7qm48bb?=
 =?us-ascii?Q?uK0q3FT+X0B76mojT7oLr3VmTHY0IIXLiepY4a0wDM3vXj9ap972m6hyJ0Dq?=
 =?us-ascii?Q?8ckRZQIMFxu2dOP57oYq2J9jEs/lSppxiDo+X1V0a/P9UDIJrCrsMgOP5DZ6?=
 =?us-ascii?Q?ub0+j7tt5qSKVy1+VmAwt3dwETHZNS8Y/FYe4X+ZkWacpNMHa5KjJnSRw/pl?=
 =?us-ascii?Q?M89aZVMqSaEgLK/lQIxfx7DPJ+mEYxeHzkUQD3OCm/jFpLxy4KpSmc4vO5F1?=
 =?us-ascii?Q?CCON7d+Y3oNyACEJobpDMlfgRtq3LybokphNItMShfmZoOEGslC1zZjIXqZv?=
 =?us-ascii?Q?mw0AIq5EVO/t0VXvLUAzW40TfFUyUyfJfMkvjb2APKp4yjv1j6NTBQ2wH0SS?=
 =?us-ascii?Q?myhh7kEJ6Y0WJVEQgj+VOo6f279PZtt3JNyiPBnJCM6VPjij4bLkmh1G3CYb?=
 =?us-ascii?Q?hWwpTFXxbc+i+R/rWP/VZAymHkYVQiAFZgeUhSNNVoQ/plzYvMBZ3PbBMlaJ?=
 =?us-ascii?Q?6aC0CamoMgzT7WMFq4pZGBZBfLcyF0p+umHeOFoBgCnO2BdX7gVBYsKHPZEY?=
 =?us-ascii?Q?Oh9UXZpLPrHGesK9/eaSpHwz2rssfFEDQTuxQ8fvqpmC33051mAT/lXvHwAb?=
 =?us-ascii?Q?Z8J+Ktfhl/3QeWe8omQEIwQ/jsPj8x4TOwx5EDF5V575Oa9OfKKW73qeV6+5?=
 =?us-ascii?Q?jv0jNLt1sppUEOt/9hS9nAfkqAadNpoTSKanOhm8l7wRBySuqspMd22vG3mr?=
 =?us-ascii?Q?gqiI+LgAnPKAD73jDZQpfDLbgzAMPN35WJxzZq9ALfjhOCBUIN/xR2MbwVaE?=
 =?us-ascii?Q?EXZpH9MtNw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW4PR84MB2307.NAMPRD84.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d4c919a-03b4-4783-4b1c-08da4a4139a8
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jun 2022 17:55:22.6694
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 105b2061-b669-4b31-92ac-24d304d195dc
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FoXnamkicf5jIowyFyS9eZECXVtjr1UF/90+7J/WFtiIegPafpqxdXteN9LF/ARUBzyhpYBopTF5PalKFA4kUg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR84MB1373
X-OriginatorOrg: hpe.com
X-Proofpoint-ORIG-GUID: p5sjzzbT_Sf-pqj6_mvoewRoN0CZzcGh
X-Proofpoint-GUID: p5sjzzbT_Sf-pqj6_mvoewRoN0CZzcGh
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.874,Hydra:6.0.517,FMLib:17.11.64.514
 definitions=2022-06-09_12,2022-06-09_02,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 clxscore=1011
 impostorscore=0 mlxlogscore=999 phishscore=0 lowpriorityscore=0 mlxscore=0
 bulkscore=0 malwarescore=0 suspectscore=0 priorityscore=1501 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2204290000
 definitions=main-2206090065
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Reviewed-by: Bob Pearson <rpearsonhpe@gmail.com>

Thanks Mu.

-----Original Message-----
From: Dongliang Mu <dzm91@hust.edu.cn>=20
Sent: Thursday, June 9, 2022 1:43 AM
To: Zhu Yanjun <zyjzyj2000@gmail.com>; Jason Gunthorpe <jgg@ziepe.ca>; Leon=
 Romanovsky <leon@kernel.org>
Cc: Dongliang Mu <mudongliangabcd@gmail.com>; linux-rdma@vger.kernel.org; l=
inux-kernel@vger.kernel.org
Subject: [PATCH] rxe: fix xa_alloc_cycle() error return value check

From: Dongliang Mu <mudongliangabcd@gmail.com>

Currently rxe_alloc checks ret to indicate error, but 1 is also a valid ret=
urn and just indicates that the allocation succeeded with a wrap.

Fix this by modifying the check to be < 0.

Signed-off-by: Dongliang Mu <mudongliangabcd@gmail.com>
---
 drivers/infiniband/sw/rxe/rxe_pool.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_pool.c b/drivers/infiniband/sw/r=
xe/rxe_pool.c
index 19b14826385b..1cc8e847ccff 100644
--- a/drivers/infiniband/sw/rxe/rxe_pool.c
+++ b/drivers/infiniband/sw/rxe/rxe_pool.c
@@ -139,7 +139,7 @@ void *rxe_alloc(struct rxe_pool *pool)
=20
 	err =3D xa_alloc_cyclic(&pool->xa, &elem->index, elem, pool->limit,
 			      &pool->next, GFP_KERNEL);
-	if (err)
+	if (err < 0)
 		goto err_free;
=20
 	return obj;
--
2.25.1

