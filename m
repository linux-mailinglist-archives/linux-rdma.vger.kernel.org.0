Return-Path: <linux-rdma+bounces-3752-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E897F92A7B5
	for <lists+linux-rdma@lfdr.de>; Mon,  8 Jul 2024 18:58:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6B4AF1F214F0
	for <lists+linux-rdma@lfdr.de>; Mon,  8 Jul 2024 16:58:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB147148FEC;
	Mon,  8 Jul 2024 16:57:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=eideticcom.onmicrosoft.com header.i=@eideticcom.onmicrosoft.com header.b="AisU/B4m"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2111.outbound.protection.outlook.com [40.107.92.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04CF714831C;
	Mon,  8 Jul 2024 16:57:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.111
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720457869; cv=fail; b=G1lK5UAyrkKvH5QnzpynueVZB+zwieCmXvyXMQ9E9cKM7tpd56V5XdF1nP9st+e9Y/wqDtsArPzDlAsXeMFFukBlCW8Py9h556ximGKml4clC493x3CMsjd9YTiV7nt2RU8BvdKtzpPKB5QCyfZGvJbz8clwSPkC7XKpfv9nwV0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720457869; c=relaxed/simple;
	bh=kDA9NQkwJqypp5SvEFRbIhfkySmnnatjHvbHY9f7zfs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=oUUjb23WEjYmwOfRHZtTzlf6/bRxB5ewTGrGAQtkT3jG9b5RPJrDJeYGollakTbGKC+hQ7QogB8vNCZzf/WUZXYThphqSl5zs5ESqCYES9twcmt7aaSO+Io8lA21x9Rl+phi09sthb8386E/pOdqcaGhCIU6fNGc4mBkr2xZbgc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=eideticom.com; spf=pass smtp.mailfrom=eideticom.com; dkim=pass (1024-bit key) header.d=eideticcom.onmicrosoft.com header.i=@eideticcom.onmicrosoft.com header.b=AisU/B4m; arc=fail smtp.client-ip=40.107.92.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=eideticom.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=eideticom.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HcV9p0yKaipeMnYXL0COcO9YejgXMxzXeQ9v1XxuXRgbN/DVZbGVwOR0lyb4Hr/QkJV4dbZAmgmUcbqRGseRvXRm5bcoa6qoke9l9+oMF2UzHfeerZDi0wO/ZEp4WdXpXXOIWCvp70tzXTmvrvqnmp9CB4h0e28rm+8EWVbOBDJ/i6/ygIiy74VGu0ylyzwbpDiS1QGqHeLDfLHc/32nzWplG1NSeJaCXq9qpUq06R1RnsQwfs8hUTuzZDctVb6B7KFIwdGZrT9vk9FJlPzlmgDz/Rz3MaZKdEmnTt+Ip2NY1Uenl2NBUFgkWwSQKBH/JL8dt0UDsuuC1UP0jMZUfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QGCtZ5R+9+ggT5pXZCULkbLLO7rsRu7vy0kuObEqwzc=;
 b=Mff2QxXv0KtYsFlPLlbLf78RHGnmg8mypeXSoOpRTj+fJXut08X+HwSy+ELJ2Lo+tBzv+8IjH+ACFjxC46W4tYyFvR9WWNrgcjO0uRxxcahJjoQbPVLfhrwtK3r73VxKhxV0JvmtP1empVPprbONsTldwThjT9apP0r66UGVbNv7CFG5wM3xTiDVwGOQK83QCp7Frb0v7Xa8ajyb33CYAUu3eEwg4EBQ6pHqFSg19iQZgTI8wHpyO0m/rGrCTM48EgP/nQA8lFTN46uGP8f3rXFnu3UBDMfMAVDrjWILmJ6PIpbQ3JQUL+qvDdKZUGlt0xTKgBkTm7miUmtzr9mjAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=eideticom.com; dmarc=pass action=none
 header.from=eideticom.com; dkim=pass header.d=eideticom.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=eideticcom.onmicrosoft.com; s=selector2-eideticcom-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QGCtZ5R+9+ggT5pXZCULkbLLO7rsRu7vy0kuObEqwzc=;
 b=AisU/B4mBvAE4ToJqcGvsQSfGuRX9tFJ312tXXdIG5j59iNqDHPDD2Tqbfp2TrGaypoQA08ekiPOlEHvrNeIy6uR7sa6pEoj/0thiN3eERaMr/WAKla4BmR7xZB3PvqAPpDTF5esvD6D5DYgqy6VP4TDt1UN+L4qiY07hx1Id3I=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=eideticom.com;
Received: from DM6PR19MB4248.namprd19.prod.outlook.com (2603:10b6:5:2b0::11)
 by BY3PR19MB5028.namprd19.prod.outlook.com (2603:10b6:a03:361::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.35; Mon, 8 Jul
 2024 16:57:42 +0000
Received: from DM6PR19MB4248.namprd19.prod.outlook.com
 ([fe80::d508:c71a:eb4f:7cf4]) by DM6PR19MB4248.namprd19.prod.outlook.com
 ([fe80::d508:c71a:eb4f:7cf4%6]) with mapi id 15.20.7741.033; Mon, 8 Jul 2024
 16:57:42 +0000
From: Martin Oliveira <martin.oliveira@eideticom.com>
To: linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-rdma@vger.kernel.org
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Artemy Kovalyov <artemyko@nvidia.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Leon Romanovsky <leon@kernel.org>,
	Logan Gunthorpe <logang@deltatee.com>,
	Martin Oliveira <martin.oliveira@eideticom.com>,
	Michael Guralnik <michaelgur@nvidia.com>,
	Mike Marciniszyn <mike.marciniszyn@intel.com>,
	Shiraz Saleem <shiraz.saleem@intel.com>,
	Tejun Heo <tj@kernel.org>,
	John Hubbard <jhubbard@nvidia.com>,
	Dan Williams <dan.j.williams@intel.com>,
	David Sloan <david.sloan@eideticom.com>
Subject: [PATCH v4 2/3] mm/gup: allow FOLL_LONGTERM & FOLL_PCI_P2PDMA
Date: Mon,  8 Jul 2024 10:57:13 -0600
Message-Id: <20240708165714.3401377-3-martin.oliveira@eideticom.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240708165714.3401377-1-martin.oliveira@eideticom.com>
References: <20240708165714.3401377-1-martin.oliveira@eideticom.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW4PR03CA0252.namprd03.prod.outlook.com
 (2603:10b6:303:b4::17) To DM6PR19MB4248.namprd19.prod.outlook.com
 (2603:10b6:5:2b0::11)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR19MB4248:EE_|BY3PR19MB5028:EE_
X-MS-Office365-Filtering-Correlation-Id: a565de53-4a60-41e5-1795-08dc9f6f1535
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|52116014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?GcuMzkadVzg1uRgFFK79GIqPLg+m9kcO3Kdxx5j/OeMQ0ScGiT42fScXLm6m?=
 =?us-ascii?Q?vaZPg1qc4jkO9G0m0kS4NSBuNUDRipBr21BEZsaFYxNaK80X7vjHaSGQx0Vz?=
 =?us-ascii?Q?H2Mj2CHMIscNMdh+eJc/XvrJnF5TtoFahj4xkeRfq47NbSk5c7Bc/bv2u/Vs?=
 =?us-ascii?Q?Y2IH664uc5oMd4rPwhfxy7cfc53k9Z+iSgTiBMzqTh9ANjGJ/a1AKkG2nkA1?=
 =?us-ascii?Q?a55FLj4rZLbCHs9yRx72OO6LyuW3VaWgwjFEAEc+Bs2hWQfnaShfqwttPTKb?=
 =?us-ascii?Q?CTBpGEE2j/sK0yOZfgwlvGoiktOYzz49B6NMr2cCv+UjLnGeAWf4t+piU46K?=
 =?us-ascii?Q?PjqusNxs3KtM8cCkNBJcEsG7kd4QnonL2yzw/LmqLoE3opn49HUSORn9zTSV?=
 =?us-ascii?Q?Tk29DmPrXEob4woTOfPzN81UReGdatpbsgzwZq+yaqLDEYwsAL1Ta54gz94D?=
 =?us-ascii?Q?0Pz1S1MWfE8Vil7tQ3PeHbGPITFAwq322l+sqmaRTfbh1+0niU/yOzGpINGK?=
 =?us-ascii?Q?uCFf5nyCISrv2WcPHZaqhAEwBKPORa3zfI6vDUu3zhPY0no+vUh66d3tnV2l?=
 =?us-ascii?Q?UR/2SxXMBbmer6kF7EuuaDd6+55+25JA5BA2mRTsPCjT1fqqI/1q/L2fCRE/?=
 =?us-ascii?Q?d+FtsFaNV2zcb86unZZHUYKdX9bjCTnxENu26h2gKXQb5LQ3houNokw/+Lg2?=
 =?us-ascii?Q?fT1TUdP9G6TR60oiMtdt76L3G2905grh00fp1u8xGoVLiIH4CGBoKID2dW6b?=
 =?us-ascii?Q?REWbzrfyHakX50JjSlZYotGUBTao+8tXaIoGxwIx9Rx89qA9+AQnINVa9Kx9?=
 =?us-ascii?Q?AMUFLEwmYprYktz2bXFZdaJW+QY66Anyps0S0Gxfn5adYRqGnYKtfDxRv5mh?=
 =?us-ascii?Q?u6SJB+9VbrGFpgKHzRKigq/6RWA/TLUV6lTq5FeboMDQd5VeMqfxAhgzDOOA?=
 =?us-ascii?Q?Ch62UfDoaG2icfwmRDEr0AuwlzhuCA5Mdqt2hL0oecO8G8jmxjbIUnsUsr4p?=
 =?us-ascii?Q?Wm4KtI+hTmWTaWADIvMN28JEOfiH8CYRu7w4LplGhdCEg43/k8iv0EG5WW33?=
 =?us-ascii?Q?jox1NI9HefbeIZGYVIyvtiO37T+s3U6LifWgDtQv4IdrUU9s+lhG85/mTeDg?=
 =?us-ascii?Q?HkGxqOHaMiW0CylHy98sSI4bDPgY5PaW0TAvY/NEJvbWX2z/E179iZJqyiIZ?=
 =?us-ascii?Q?+nwINjQPPzrb8UBfNIYCwFvU574wQ+6TYVUaT4grawKlcbeFh4bfuti7ATv7?=
 =?us-ascii?Q?+7fTwbd3vUUAaIlWxMHPNwaHSGXkUJHC5fmHOjz9bEzGunXOmpygj7IwRtI5?=
 =?us-ascii?Q?6X9oH5X5iiMWxQ3qx768F2apkQ9zcj651KzTH3wGT+CvY1urdlRgwD9pTnLB?=
 =?us-ascii?Q?d6d/GF4=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR19MB4248.namprd19.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(52116014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?cFFfOj8uKA/93kkqnQRtaAUVwOG/smG10ZfVsuknHW4T2wksASUkUJr5ZmxP?=
 =?us-ascii?Q?Kr0ePK00ndD+k0Fl2MappZ5WLFVE7kTq8QSE1DHVRcz5g57czfvYQLI2daOV?=
 =?us-ascii?Q?CJ9ZwBee1IkUxWSc9d1hV82kOF/hgSimo/3Ck80YFsxAE0qSx8S7IHp3ZVaX?=
 =?us-ascii?Q?fgcQzqIsjStCoZ/8gkk7Sk46eVpUoaAfJTg9DkPmf13lifbkUa5nf+BcI4vS?=
 =?us-ascii?Q?x6PzusQpU3CNUuMJRO7vDpv5PKY+lzPMjtMTX1hkonwK4FRaHP70RRqB7rjo?=
 =?us-ascii?Q?QlIYmKcR5twl7RXWmo0Z9wMi78u2LYjXk0E6cQGYTooupiP++HtSpMINHFwh?=
 =?us-ascii?Q?eN79E+i7P8DJzbwJ8wsDEg8xGOIzpNsM+9dUiWt6BTLYB46ocjjSBu2Yp9i/?=
 =?us-ascii?Q?1UTuURbc9/ln4jW6WfEkl8rgj5qbhNYkJMpI9Mxb+euz4Xv4Odk+6WBjpukg?=
 =?us-ascii?Q?AhYeY8fYq1abkmoVSyjifSjTfYs54eh/cKGOc08wO11ftsgDH1COABEDPcew?=
 =?us-ascii?Q?nete0F+0EIOGYAOe1IkHOl/Clof7JBylhtCS4gbTq7C92dkJ/e1d1kEDh7/G?=
 =?us-ascii?Q?+6s4qRy3cdLnAPDjKerbBhJN3qXpQb9A5Bbd6tXR8Sw3gGcmpqE6tYhnjBgW?=
 =?us-ascii?Q?W7/V5weGPtY6+vDsIZvfiopNHj0F3GkldKBH0AHeNsoUCek333KKIAH++K7b?=
 =?us-ascii?Q?bxlqHSC/qTZ5qPdCzEUcP8pCprCE8JGquDPGeR2e/ZSNBNfcyI3MRqKJD8Hn?=
 =?us-ascii?Q?HV6nXO74plx5JEmlcTpBpxb3lgMflRuAmaIaJ2pMqRGzRtLKmgzaHQI1L/ll?=
 =?us-ascii?Q?2mvwJWQDoSDiibZmD2rLExQmNrWueDm3oxB868T4iwn2vTiWe4IAUtuoA1vN?=
 =?us-ascii?Q?QnyUdKwjsYS88UP1Z0Wk7q0n1MutwazxeEMPtwESNjQ0E/UAoyk0/bhApZ9t?=
 =?us-ascii?Q?ekUDlEs7WfOyCrsSxNESr44qbUGazquPCbMdHYmxGrtcBWrowHVQAv1plxEA?=
 =?us-ascii?Q?m0RS8Z/UeyxzO84Pb+watDM+IH0ufOWWPwb32VopdAwqMVq+Be/d6wQ0Y/gd?=
 =?us-ascii?Q?86nd2HvHYktpF6+8IHkWgzflJoiYuZ20fx6ZHcugffFRINyYO5wumGTFUGmk?=
 =?us-ascii?Q?ekACsELjaWGWm0hi+GNSOTwsYYq4INXMWokvZvF7FgJJLDJguh6bmldfbB3g?=
 =?us-ascii?Q?d1amIFfnU1uJS7K2Wz4Lk9R6aifKnz29UkY/tsW2XtELWDaJ2q93F2B1G+TR?=
 =?us-ascii?Q?GSGSk3D9rtQszoWZnCLkFKy+2mijEgfHZ2aD0z1C7XMosb1BVFGLQpMMorUM?=
 =?us-ascii?Q?p8H1UDr4AwneB4oUVFCweslVddLBthscVvQjeHqagf4cu9tS1s8j/ZcpdT89?=
 =?us-ascii?Q?/SExgY59ww94R6XOuQgoL3nps7NtC3hdO1ZijQXfw98uPde2jsTXXu5GgnqP?=
 =?us-ascii?Q?oDoKjs9ICrC0kskha/d/pO00ux6hWFSgvbcDsHVV2dD2uOdaxzKmAw7VJxoA?=
 =?us-ascii?Q?WVWM3mHIsaRgbheYsBmDFG469eOR2NyV29XMiBcinMeunrJivFoOKM/RrqRa?=
 =?us-ascii?Q?JedglM7/qgf3sUGMmCEtWnG/eBoB0TuQILVjgY1wORQZart1YKnJx9qutXOU?=
 =?us-ascii?Q?ag=3D=3D?=
X-OriginatorOrg: eideticom.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a565de53-4a60-41e5-1795-08dc9f6f1535
X-MS-Exchange-CrossTenant-AuthSource: DM6PR19MB4248.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2024 16:57:42.6777
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3490cd4b-0360-4377-abb1-15f8c5af8fc2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VlP3bq3F83T3k9tXtjmOfcc7f9e2XX4jl57TxugKdT0o40PQnHxuzBuL2LG/zUxSZIzvaO4PnZinMvcWo3mBwSNmEmnfRsmOK5IaxAj9NoE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY3PR19MB5028

This check existed originally due to concerns that P2PDMA needed to copy
fsdax until pgmap refcounts were fixed (see [1]).

The P2PDMA infrastructure will only call unmap_mapping_range() when the
underlying device is unbound, and immediately after unmapping it waits
for the reference of all ZONE_DEVICE pages to be released before
continuing. This does not allow for a page to be reused and no user
access fault is therefore possible. It does not have the same problem as
fsdax.

The one minor concern with FOLL_LONGTERM pins is they will block device
unbind until userspace releases them all.

Co-developed-by: Logan Gunthorpe <logang@deltatee.com>
Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
Signed-off-by: Martin Oliveira <martin.oliveira@eideticom.com>

[1]: https://lkml.kernel.org/r/Yy4Ot5MoOhsgYLTQ@ziepe.ca
---
 mm/gup.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/mm/gup.c b/mm/gup.c
index ca0f5cedce9b..6922e1c38d75 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -2614,11 +2614,6 @@ static bool is_valid_gup_args(struct page **pages, int *locked,
 	if (WARN_ON_ONCE((gup_flags & (FOLL_GET | FOLL_PIN)) && !pages))
 		return false;
 
-	/* We want to allow the pgmap to be hot-unplugged at all times */
-	if (WARN_ON_ONCE((gup_flags & FOLL_LONGTERM) &&
-			 (gup_flags & FOLL_PCI_P2PDMA)))
-		return false;
-
 	*gup_flags_p = gup_flags;
 	return true;
 }
-- 
2.34.1


