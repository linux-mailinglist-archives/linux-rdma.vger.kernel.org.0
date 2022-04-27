Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3803511F3F
	for <lists+linux-rdma@lfdr.de>; Wed, 27 Apr 2022 20:37:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242572AbiD0QRI (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 27 Apr 2022 12:17:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244064AbiD0QPs (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 27 Apr 2022 12:15:48 -0400
Received: from mx0a-002e3701.pphosted.com (mx0a-002e3701.pphosted.com [148.163.147.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44A752BB3F
        for <linux-rdma@vger.kernel.org>; Wed, 27 Apr 2022 09:12:10 -0700 (PDT)
Received: from pps.filterd (m0150241.ppops.net [127.0.0.1])
        by mx0a-002e3701.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 23REnox7009732;
        Wed, 27 Apr 2022 16:11:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pps0720;
 bh=ABIxCYTobZBsgVX0WBTMGP7n7zSbzXlmmjwtNmXjCKM=;
 b=I42uCYT0jLX5EvfM45v5ZRspoj5tybeomyDm4J40R0wAgyj8oe40EhNfy94C+2VaVXv+
 R8SlZn7XkygvPba3eZHxTqqC/t3AkKWAWGDZ7jUHa8H4/cX40ZWRumh/BW59JlqIbBp8
 UNWnM1mEAHoGlYssK+wINGlm3FS1rpz/gqQtilZ/LuJBGBN1dPtGhyWq+XHplFRJvU0j
 W+npHAINBpg9M0QwTOg0b5kjEJZldGOAav4wjlEARGyMkb8ggVZAghqjqjMYwN7iFQWf
 AXvsOcygSvOdeLeYo6PMr8sxGBAAMkPP4i3Zr1nw5w+A9w2pDsw+aZJ5Q5z9juy5Fl+Y hA== 
Received: from p1lg14880.it.hpe.com (p1lg14880.it.hpe.com [16.230.97.201])
        by mx0a-002e3701.pphosted.com (PPS) with ESMTPS id 3fq7x8gtmv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 27 Apr 2022 16:11:04 +0000
Received: from p1wg14923.americas.hpqcorp.net (unknown [10.119.18.111])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by p1lg14880.it.hpe.com (Postfix) with ESMTPS id 76A0B800360;
        Wed, 27 Apr 2022 16:11:03 +0000 (UTC)
Received: from p1wg14927.americas.hpqcorp.net (10.119.18.117) by
 p1wg14923.americas.hpqcorp.net (10.119.18.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Wed, 27 Apr 2022 04:10:26 -1200
Received: from p1wg14921.americas.hpqcorp.net (16.230.19.124) by
 p1wg14927.americas.hpqcorp.net (10.119.18.117) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.15
 via Frontend Transport; Wed, 27 Apr 2022 04:10:26 -1200
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (192.58.206.38)
 by edge.it.hpe.com (16.230.19.124) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Wed, 27 Apr 2022 04:10:25 -1200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fWOHwdYv6mrUkW+kWuy7IsSbCvLOxF9iPVINkmme8G1igvhlHkrZpPW27SSQZCO/bp4EZOBuppRlgQO9C21U3w3Cb9Op3hMEGIR+JsAj8xWcqvWoZCQAetb3sjpfhOGwM+hfXJhX4Jth0HhrBibOI5QRthhGmLk6XmAgYVjG1iDpOLW5vEFy++h+7l5NxDLFcNP5LxevZ9FUGtEeI/Afqu9VG3YYEoSux23OQZHLzN42KM6VgccsgZIbG7Hcxj9KCqdUQydrCm2Do4rbc+a3vKdoI+F2pnHyA7VqogXmYkxmTKvLOSaxgEKa2xeUPWnG555zJfPdxsBs9P9FzAs8DA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ABIxCYTobZBsgVX0WBTMGP7n7zSbzXlmmjwtNmXjCKM=;
 b=Pv8fLgvl0qR9rqJETvajnnLjyPU2+NOYn6Y7yllJlrMk5OWvp4jJj7F8fZ0nb0bIqzEeRVFSFyutu87yFfrcbRNzIuJH8k1f/ZKa4z27Wbk53FKS4rrfqPTuHjOY5HRzVERR/j4SbS3zg0Zf7sEgyJnQiYhJE9OsS030MEB/8cyuf8Rtga+p4Y+mrqyXbhpRkcXHuim8SumCzn4wyqpNQJR+v2N4jXPLdrbezlfMh8e4ljU64ZubrJNwhB7epPC7iP7HkJzxNnZzsSAe06gSMP9Ibor7c/Lr7Myfia5WfKzib7I+wucQNKMnJpR+QqKGw0cEcXu+QzfHZguAYNCkTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hpe.com; dmarc=pass action=none header.from=hpe.com; dkim=pass
 header.d=hpe.com; arc=none
Received: from MW4PR84MB2307.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:303:1b6::9)
 by DM4PR84MB1928.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:8:4f::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.21; Wed, 27 Apr
 2022 16:10:23 +0000
Received: from MW4PR84MB2307.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::1d3b:32cb:5dca:4e40]) by MW4PR84MB2307.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::1d3b:32cb:5dca:4e40%5]) with mapi id 15.20.5186.021; Wed, 27 Apr 2022
 16:10:23 +0000
From:   "Pearson, Robert B" <robert.pearson2@hpe.com>
To:     "yanjun.zhu@linux.dev" <yanjun.zhu@linux.dev>,
        "jgg@ziepe.ca" <jgg@ziepe.ca>, "leon@kernel.org" <leon@kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: RE: [PATCH 1/1] RDMA/rxe: Optimize the mr pool struct
Thread-Topic: [PATCH 1/1] RDMA/rxe: Optimize the mr pool struct
Thread-Index: AQHYWix7EohlFQfjcUWJb/I4w7Yye60D7inA
Date:   Wed, 27 Apr 2022 16:10:23 +0000
Message-ID: <MW4PR84MB23070C42DBCB8994DB08F204BCFA9@MW4PR84MB2307.NAMPRD84.PROD.OUTLOOK.COM>
References: <20220428041028.1363139-1-yanjun.zhu@linux.dev>
In-Reply-To: <20220428041028.1363139-1-yanjun.zhu@linux.dev>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: eac5d3df-8629-4046-699f-08da28686f77
x-ms-traffictypediagnostic: DM4PR84MB1928:EE_
x-microsoft-antispam-prvs: <DM4PR84MB1928B2D1DE7226C3FDDAE5E7BCFA9@DM4PR84MB1928.NAMPRD84.PROD.OUTLOOK.COM>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: udrLOjriq3Woxg/VlWIDaXnlidQCCfgCV3LS4uyrug2VP4mpYeiqx8Rgj8QSAbf/iB3UINQ3kh/2MYTCShGtNtAAIHxkihqlFbC5fQ1PPe/5erVQH3uBunFwarogBzCWWqzPJCUo+f+93einYmLac54mokWUALVX4cbe7Jp+ZByfJwjiTqh9sZL3ecqLdHSPfvjgJ4SlN/r2A0ZVyZGSDKedJ499p5xXNVi4xiD/MtTmhMpmvKGFnIwgm9kxMGJRKtiEsdsx8lKj6PFgOB5h56tNuvE9IAHCs6egPuixXczyzxg2hS3VVk1qRwsBIXQxXmxrho1gTvryUZcqG44WNVpnjMDey9Zkt2v/vRd8NJ477KuZQdlUYPnYGH261ha/NwEQ0dr0FuBEfdxqNP/DjoIAiKn5IvG0gE7q7GEqHw5cWR+WN2p8ahkvfc6oAOhokjBWFyw9PRCBVzFlcMZ3wi3dd2ZAsORqaYm73zfgPWEggrfXG6MXBBrQO0Yi4ypVOtezoH2FFgUzFiuhl6mMpFj+UEc6j/2ijgbXdrERsBzR2r4paokXxh3OSZ6qT3sHlse/Y+7vzdgCRtP88pp8be7Ixxh4Lbxii6egwXTqKBX/GSEPCXn6UHUdMGNJSLi9/RvEf3ETot+CkSYCAgcBuxae7vASS2P8VeTilJ0W/tkOzxPphtDpDRGvx7m8r6hiNil6N8xWBC+X2BPZ9nsh1A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR84MB2307.NAMPRD84.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230001)(366004)(122000001)(86362001)(71200400001)(26005)(186003)(9686003)(6506007)(55236004)(53546011)(66556008)(7696005)(2906002)(5660300002)(82960400001)(52536014)(33656002)(83380400001)(66446008)(38070700005)(64756008)(8676002)(8936002)(66476007)(66946007)(76116006)(508600001)(55016003)(38100700002)(316002)(110136005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?4cWiVZD7SZwgqhnYkR622ODNrIO28LNoUpZM9ZghYF8xSuLEMkbTf6zqBQPl?=
 =?us-ascii?Q?+EXHMi4cvWlBWo6LJbiWxHaX+IpQiI7nQ7spoiGiuDWaalMY5kacuu2OUcFa?=
 =?us-ascii?Q?F98ckzQzY6aiR7Vq/raTk2ZXwdPws2QYYRKFrwpm1d1+68A41Tui+cOmj4qb?=
 =?us-ascii?Q?nEkkkpTMqIC4FtEjz30YhrEkmMX7JQqsI/DM3G6LXcd3Th3ipDQgSuz+Y8KS?=
 =?us-ascii?Q?Zldp/96vGBH2uaf9tqywDhs+gRucU4dZILxVqCOnKfvZKhlIPslmh+4GIW+a?=
 =?us-ascii?Q?zCTmEt8lv1qNN72ySkpO/SoOBOAUgrPy7XT9L81Pcz6E/ECcokmxmDJNta0u?=
 =?us-ascii?Q?f9+kKKrLVEA9QJq00E7kjpbrzL9P9j621yJGKYbwOeDvPObUwNLE/nrilptX?=
 =?us-ascii?Q?XF+YuhYthVvc/vhbwn5vnUX5g7YdODzy9WvSSx6bJVag4tHOUGcitnhPW8Nt?=
 =?us-ascii?Q?m91zYJm+nKEHdU+JMg4zgBssnrtEYAbXoYBJuEy89SRQuOoGkEZtoeWSmNuK?=
 =?us-ascii?Q?+BsES/0bdrpxQj5XFhq5MvNYC245nnB35MERQGhV/wuEYMDCBdBvshsf5F10?=
 =?us-ascii?Q?gjea1n9Ca8dSx1kZCVwyLgKzAh8aTTvJgpU4oio4Bg7lA9G3oOuLzd5FBfew?=
 =?us-ascii?Q?/HKkkG7Fri8k+NfgP0kviR55f6a9XsBt/C8P+NsUXGJ4KhiEwmyNXWskwm3V?=
 =?us-ascii?Q?ybcKZCG3D1AJcHIRpvGJztQSv9WYelFsuz5W3Wqu6bSY3m+Xr/Q71gNP4S8B?=
 =?us-ascii?Q?hVIhvTC1JVxfKwnzWCjHL2PpsvTV7+7S5JdcIMLFsVPVjlVIM5jrYz4OwMu5?=
 =?us-ascii?Q?8qPuokl5MEV5TQeMDnATKSNgJOSOHju2xy36P2xcJrwWlrw534eFmzWAjLF8?=
 =?us-ascii?Q?X2Gb0ksv9gZpr9aGfX4q5KDJ0fxBLpaYi5SbUVErsOBOVu4FxnK0e/lKRGB1?=
 =?us-ascii?Q?wGThc28wyTKTw6DCB3HSvZ37wfgnSZ18+Hi6voez/6qD66PEEVVtNPuhQ5Nq?=
 =?us-ascii?Q?ZV+AW3MIOlXGutLcbeJvi5FTeOsTP96opfchHYKA8s/KBrXNAkaBv5bFSNSF?=
 =?us-ascii?Q?/MddHqHfdwpaq9yuL2rPk9m49mp6YODbBWLQBJf7cSBw9/VBKLCpvfom8a88?=
 =?us-ascii?Q?KfBVRA/6bU5G3BT4zpjIASh0UmO+pSFPWt2RLQ8wxSFvXaCdDw1bG64eO2oP?=
 =?us-ascii?Q?+NMoGQ9ATlDs+yPoExKf0mhmdPROTvUIFyqCiFsVV92be4zURscniwcZWymJ?=
 =?us-ascii?Q?DtmrYkA5MjdYQEtxPFHm8U2+OaZd1XMsKZJymTxoRw5AAMPQg97ykMA4tQM/?=
 =?us-ascii?Q?scEWxLtsKzVe6ZRt+PaCOBCtX+6zmYfcbcyZji/1mYO8of/fEUV0+z/8FfRS?=
 =?us-ascii?Q?GwGIF49GUSGAIoDZ4bmeduQbEPCilE8DXMsjgyiYShpcbXTKnC25dv50aOvK?=
 =?us-ascii?Q?SyAbvceG16ikhKgSZaj6aZjaCTLlcCmS9JZo/jT+e4y8Ql1vwq7afQWp0n+v?=
 =?us-ascii?Q?Yiq5MupT/K6VCabmXOOL11NVVH9HUkO8yvAEApS8s7WWdQfZDPpmiqjHPTES?=
 =?us-ascii?Q?CYtiH5wJmfIjShLj636EK6SFxjXgrbpQa+ZS/4gg5HHT4j0T6PFY3Vz0JYwD?=
 =?us-ascii?Q?+chmdik+Hknpw7tRAZ1DNnguSieAW45Fsdb7flNwUknSX3Vj5jI0vKdYTrvx?=
 =?us-ascii?Q?qNesuIdFR+DuwJ+MthbY4SUVAdYa0RysnPvl/lVAavxSypLSgQP4C/VSCsUV?=
 =?us-ascii?Q?4EtwqSP1ZA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW4PR84MB2307.NAMPRD84.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: eac5d3df-8629-4046-699f-08da28686f77
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Apr 2022 16:10:23.7528
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 105b2061-b669-4b31-92ac-24d304d195dc
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wjGsidBtDIA5zQ4Cm3QSvcmhLX+8ufURjTiz4HYMjshz+WSKb7ku0I7uQs6CFee+shENhaGUFcwEQw3c305y2Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR84MB1928
X-OriginatorOrg: hpe.com
X-Proofpoint-ORIG-GUID: oD4SVifs5xega2FowmowOfjHpG4h08EL
X-Proofpoint-GUID: oD4SVifs5xega2FowmowOfjHpG4h08EL
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-04-27_04,2022-04-27_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 suspectscore=0
 mlxlogscore=826 bulkscore=0 malwarescore=0 clxscore=1015 adultscore=0
 impostorscore=0 lowpriorityscore=0 phishscore=0 priorityscore=1501
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2204270101
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org



-----Original Message-----
From: yanjun.zhu@linux.dev <yanjun.zhu@linux.dev>=20
Sent: Wednesday, April 27, 2022 11:10 PM
To: jgg@ziepe.ca; leon@kernel.org; linux-rdma@vger.kernel.org; yanjun.zhu@l=
inux.dev
Subject: [PATCH 1/1] RDMA/rxe: Optimize the mr pool struct

From: Zhu Yanjun <yanjun.zhu@linux.dev>

Based on the commit c9f4c695835c ("RDMA/rxe: Reverse the sense of RXE_POOL_=
NO_ALLOC"), only the mr pool uses the RXE_POOL_ALLOC, As such, replace this=
 flags with pool type to save memory.

Signed-off-by: Zhu Yanjun <yanjun.zhu@linux.dev>
---
 drivers/infiniband/sw/rxe/rxe_pool.c | 9 +++------  drivers/infiniband/sw/=
rxe/rxe_pool.h | 5 -----
 2 files changed, 3 insertions(+), 11 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_pool.c b/drivers/infiniband/sw/r=
xe/rxe_pool.c
index 793df1569ff1..138763eb0e10 100644
--- a/drivers/infiniband/sw/rxe/rxe_pool.c
+++ b/drivers/infiniband/sw/rxe/rxe_pool.c
@@ -13,7 +13,6 @@ static const struct rxe_type_info {
 	size_t size;
 	size_t elem_offset;
 	void (*cleanup)(struct rxe_pool_elem *elem);
-	enum rxe_pool_flags flags;
 	u32 min_index;
 	u32 max_index;
 	u32 max_elem;
@@ -73,7 +72,6 @@ static const struct rxe_type_info {
 		.size		=3D sizeof(struct rxe_mr),
 		.elem_offset	=3D offsetof(struct rxe_mr, elem),
 		.cleanup	=3D rxe_mr_cleanup,
-		.flags		=3D RXE_POOL_ALLOC,
 		.min_index	=3D RXE_MIN_MR_INDEX,
 		.max_index	=3D RXE_MAX_MR_INDEX,
 		.max_elem	=3D RXE_MAX_MR_INDEX - RXE_MIN_MR_INDEX + 1,
@@ -101,7 +99,6 @@ void rxe_pool_init(struct rxe_dev *rxe, struct rxe_pool =
*pool,
 	pool->max_elem		=3D info->max_elem;
 	pool->elem_size		=3D ALIGN(info->size, RXE_POOL_ALIGN);
 	pool->elem_offset	=3D info->elem_offset;
-	pool->flags		=3D info->flags;
 	pool->cleanup		=3D info->cleanup;
=20
 	atomic_set(&pool->num_elem, 0);
@@ -122,7 +119,7 @@ void *rxe_alloc(struct rxe_pool *pool)
 	void *obj;
 	int err;
=20
-	if (WARN_ON(!(pool->flags & RXE_POOL_ALLOC)))
+	if (WARN_ON(!(pool->type =3D=3D RXE_TYPE_MR)))
 		return NULL;
=20
 	if (atomic_inc_return(&pool->num_elem) > pool->max_elem) @@ -156,7 +153,7=
 @@ int __rxe_add_to_pool(struct rxe_pool *pool, struct rxe_pool_elem *elem=
, gfp_t g  {
 	int err;
=20
-	if (WARN_ON(pool->flags & RXE_POOL_ALLOC))
+	if (WARN_ON(pool->type =3D=3D RXE_TYPE_MR))
 		return -EINVAL;
=20
 	if (atomic_inc_return(&pool->num_elem) > pool->max_elem) @@ -217,7 +214,7=
 @@ static void rxe_elem_release(struct kref *kref)
 	if (pool->cleanup)
 		pool->cleanup(elem);
=20
-	if (pool->flags & RXE_POOL_ALLOC)
+	if (pool->type =3D=3D RXE_TYPE_MR)
 		kfree(elem->obj);
=20
 	atomic_dec(&pool->num_elem);
diff --git a/drivers/infiniband/sw/rxe/rxe_pool.h b/drivers/infiniband/sw/r=
xe/rxe_pool.h
index 12986622088b..ff5b52fe96c1 100644
--- a/drivers/infiniband/sw/rxe/rxe_pool.h
+++ b/drivers/infiniband/sw/rxe/rxe_pool.h
@@ -7,10 +7,6 @@
 #ifndef RXE_POOL_H
 #define RXE_POOL_H
=20
-enum rxe_pool_flags {
-	RXE_POOL_ALLOC		=3D BIT(1),
-};
-
 enum rxe_elem_type {
 	RXE_TYPE_UC,
 	RXE_TYPE_PD,
@@ -35,7 +31,6 @@ struct rxe_pool {
 	struct rxe_dev		*rxe;
 	const char		*name;
 	void			(*cleanup)(struct rxe_pool_elem *elem);
-	enum rxe_pool_flags	flags;
 	enum rxe_elem_type	type;
=20
 	unsigned int		max_elem;
--
2.27.0


Looks OK.
