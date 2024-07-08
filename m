Return-Path: <linux-rdma+bounces-3753-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 05E9892A7B7
	for <lists+linux-rdma@lfdr.de>; Mon,  8 Jul 2024 18:58:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7C9A41F210DB
	for <lists+linux-rdma@lfdr.de>; Mon,  8 Jul 2024 16:58:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8ED31149C77;
	Mon,  8 Jul 2024 16:57:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=eideticcom.onmicrosoft.com header.i=@eideticcom.onmicrosoft.com header.b="KnRGtE5f"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2111.outbound.protection.outlook.com [40.107.92.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B281C148FED;
	Mon,  8 Jul 2024 16:57:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.111
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720457871; cv=fail; b=tw/sBjwp9EjW3IgRcmSidOh270QVOex5lSGoHf+SnFU4loyHubljKnuPrtHzWECDOyCo5/NLbN2F1R5VmHzRUbxWo+dgVs90lxBt7g0rzN4c2JHGgW5c50chA0dcUDM8SZ5qf7+jCjK01DINskTmkT+RMXJcoBpjbiiQbFSPirI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720457871; c=relaxed/simple;
	bh=szLQRnqhp3lsW0d8v40eokUGOw6zDrK50Xox6WfGvgY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=bfnJdvhntLr5woLZOiFojsZjssrmILmO5AERNJwMQfRMIYIgQNgueCE+i+pCwLcdJRO9ovMsiw1J22drgsLuA+Lxbnnb/1RONPItl3wNCdGHb+SfxK57zt+Q+Y0xVr68e2pzoVqOAo8qNPV0srnMx/HoG6PfhlSIs0pvPTUmyjU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=eideticom.com; spf=pass smtp.mailfrom=eideticom.com; dkim=pass (1024-bit key) header.d=eideticcom.onmicrosoft.com header.i=@eideticcom.onmicrosoft.com header.b=KnRGtE5f; arc=fail smtp.client-ip=40.107.92.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=eideticom.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=eideticom.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C8E0F60lBTk2yARSsHbC34QHx0AHYb3dCtVgIktM/4mtKN4e/mw0NCZVpzzasoLpKC13qb3QUskybxTapqbat8PYWsyg/RF3H0akW/P0o+MIJrNd3tgJdA/N1lilPWGxsTOoaO+TDYNqG8QFdi+OPprskp1Wyeyl7+mcr375b3QBYJa7xvjB5C+ETPVuxvq+QPML3bLgwseF+9iyKGYbtEZBrNf5sABSQatEotC3jPrwLHbvvMRiUrc1ofBq+wkkOUD0ba83JxTQxIv76gsMdtY6XJ3PjOlOqGNTGGBcwjLKLJJDQsgI28QJHXVgQ7g0k4jq9ltoL/xS+cjo25frjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YueMmbvCvTSA1MKV+udXlu2nutuaCG4yOb4CpEEFNc0=;
 b=at7DIGjQwysJf9VB8hv584gL5BcgR/4UQoI4j4drsw08rj4Cu4tzhXNsv4nEOXIQbDTU7KothsrpqnQP9OXJOS7xE8sNpay5O36a5gpVDKNyG4w6eyUV/0is7YDz0Eh4iSOQft6z/SDilwVP6tv0MNut4WgfKYdus8IKSbfMELzxovfsWRqawML6aVncogyiSBEc2tcHS+3NFLCOddJ+Sya8SPkPlBqkQbFkhfRC8aNEQW0gOkGiSDYjjRGyrIAc/HMR1PGi50wK5h9FFvZNSaa5nmbsCzHeWjToKxiD/ylXRjJUY4gZu15R/rIqYVf/oGdSt6RHXZyk3BPIqjcJyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=eideticom.com; dmarc=pass action=none
 header.from=eideticom.com; dkim=pass header.d=eideticom.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=eideticcom.onmicrosoft.com; s=selector2-eideticcom-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YueMmbvCvTSA1MKV+udXlu2nutuaCG4yOb4CpEEFNc0=;
 b=KnRGtE5ffnqfvuaoRRYC9bPMkS37lthLEyYLc/ZCo+lK1o/JiSQtq78r5xhc4ENVRHOyZmGc8VCUUD6PT4YqmwkzS3eg3jbRoLp7CwW1A71U3Pvubg3eBvgZOfnlMbTfRJxZLq0rtZcyWP8niXndyNHffCWrW9d8tsXbba6Fx3o=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=eideticom.com;
Received: from DM6PR19MB4248.namprd19.prod.outlook.com (2603:10b6:5:2b0::11)
 by BY3PR19MB5028.namprd19.prod.outlook.com (2603:10b6:a03:361::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.35; Mon, 8 Jul
 2024 16:57:44 +0000
Received: from DM6PR19MB4248.namprd19.prod.outlook.com
 ([fe80::d508:c71a:eb4f:7cf4]) by DM6PR19MB4248.namprd19.prod.outlook.com
 ([fe80::d508:c71a:eb4f:7cf4%6]) with mapi id 15.20.7741.033; Mon, 8 Jul 2024
 16:57:44 +0000
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
	David Sloan <david.sloan@eideticom.com>,
	Jason Gunthorpe <jgg@nvidia.com>
Subject: [PATCH v4 3/3] RDMA/umem: add support for P2P RDMA
Date: Mon,  8 Jul 2024 10:57:14 -0600
Message-Id: <20240708165714.3401377-4-martin.oliveira@eideticom.com>
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
X-MS-Office365-Filtering-Correlation-Id: ff788045-f79f-4488-3ea0-08dc9f6f1618
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|52116014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?tNsAzoWvN0zCxDPi5mKkCivR5HnFx2660fwqJoXqk2H7xF6xTyIDXUaRj7k3?=
 =?us-ascii?Q?FXHQtMTXeXkKSf1FvZc4enIdLsVZkVoGdTclROijyxnM+K6uKIBjQoWkpnEz?=
 =?us-ascii?Q?wx87ZG/+Mr9vuP/yesuw3hMxSnJsvmSdWvSAGh5ngkGwECmEes4PJQu++B1q?=
 =?us-ascii?Q?EhLqGP/VOQfefnGSsRffQzX3Zd/JmmWalURX7AmiV9FxJJ5uKk7CtOnMoH7p?=
 =?us-ascii?Q?XVzGaOeqk2mVfL852yinuic50r5gtHoiu6JOI24VUD3hfvJujs3Pezvrhnoz?=
 =?us-ascii?Q?f+TAasUPsFIpvgJ8YUNKA/enLf+JLMnsZAoJpy7TdazAHXnAPqo8KhNoIfrC?=
 =?us-ascii?Q?h+QVVTp9Dn+07n5AvCIK9kjcrGo1DXbyOdBZoJf02OJLtT0AyD1DdvCvCMe8?=
 =?us-ascii?Q?RUBZatXxFjXiFFQ7gZbH7tm2v1GFei3LvY8sWdyTllLrOA9k8RoC2b20IzIH?=
 =?us-ascii?Q?/v4SPWmUdrXq9R+Z+HaOVjZWqlTedH+z9vwgdnGQ3HYGCw25uw4EhQJJdlI9?=
 =?us-ascii?Q?zUrpQdgZglhU+X7soVrngbm76eqpCrFoonmGPTIblsgLw9+qd9zZgAZRof+u?=
 =?us-ascii?Q?DoBJ+4c4HqIdBgGBU8is9YR/KnJoeY5bQTlgFOY6St5lEpyLsDIERj6+0A0a?=
 =?us-ascii?Q?FF67VRn1at366wB5DNrQbu1i09twc8vzBNglYv2bhg7iKtrin1fxYpKdqe8a?=
 =?us-ascii?Q?lgaT74+1DPvbekvPPHW5SKTbQWpGVa21kKutFrLFEhNOB5Kp1rMr8jUZqzSF?=
 =?us-ascii?Q?zCme8weNbMpnw/Dd+aehMMjDGdkwen9tCcpFKAxv9pnuq8bb0TpgDF9ecreh?=
 =?us-ascii?Q?YlfbNw1dMJzgClSMeM7ENwN+BX4iUU+8MwIbXwj0Y89PUDKJnGtJnpftuqoZ?=
 =?us-ascii?Q?74hfrjw2UamhxhoxCuYPf3cebINSxih4A8fmXuNh0bDtbR5rqE/pJ/N3qNbD?=
 =?us-ascii?Q?CtLw2WX2/2IhWt/NQXElgT5/Zkao139QSRaLMJ/+Z8avYIw2Pjt6Vc6UxU2Z?=
 =?us-ascii?Q?ks9tew+dmzIj4YzjuLckez2i2/bG69jCC1vglmcGIAQJkkRZCSe9f4h718xL?=
 =?us-ascii?Q?8/4BqIlOeZQ0E/1zoaZDtvd2eErKOXVg7xpSoFkpfzODsS4PjnPd3GRWNFUN?=
 =?us-ascii?Q?rcCewx1BBVXoq7hn9RLqFLoHzyKp2JbYt1zn0YBP3YWbLWAyowzDJBVOzPbL?=
 =?us-ascii?Q?IKgDAzoLSPEdxYzeH/ZuL7wfejFhvU/tdySN6vKJucT/ZyMSTCkjYFWOMOEJ?=
 =?us-ascii?Q?maKGJgtayOQcA1WpCFrjSZbsKiokJwHMNWAZm5Tq3YlPPBTcLmgy338YgdjB?=
 =?us-ascii?Q?8rNDY3ZKxYzTrWJ8msKUP5657qX5C3qRgqdjCzrI03JnYS5tBWeBH++BXFcX?=
 =?us-ascii?Q?g3yLcOHccKOvvXCIkq/5GE0E92IqQb9hTYkFWRk5OigR9EwAsg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR19MB4248.namprd19.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(52116014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Uj3Tid2uN6Q6b5kuv+ZcA1gAvOvRU9NRTrm40/ehvC2ipNS/kQx9ZhvJSJ/R?=
 =?us-ascii?Q?jJMCbd3RWFmPYlunDVqwj1UtHDGkDsMjLEOwVLMGCYfdQD+rqpqPAOBBMgDk?=
 =?us-ascii?Q?kpzDCsynJHSCy6XRo592vS5+DEBL4Ufh+0vAHn35bOpoKT2ifH5LzupE3Qzw?=
 =?us-ascii?Q?ws1NZC0vwbezijPa2Ak20vxIg7L5axFVenHvn3LkBnlVtdEMCDI4O7hOL9Xh?=
 =?us-ascii?Q?FeLKOMRY5aAMe4ySllmO4irGFoy9bP9FcvBW3xBZdxgioRqu6GUW2lZWxE/M?=
 =?us-ascii?Q?vd98Pvqf6wZ94es6QLzLfhg9kXN4oc4g9ODcmoAi6AWFTAUMy5UMZwSuGLvg?=
 =?us-ascii?Q?okFNkc6K1LMzaBDWt8Fz+Of2tn81jIgd4izbXIUZHV0T+p2O8MfHtJV4+qnw?=
 =?us-ascii?Q?6aYl0kchWviPkQkW8PjPF06IH2B0SbSAAy0ay5kqx30TYozK+jJOMWOcZrWd?=
 =?us-ascii?Q?iQE+rAgHWt+Bh5huYTuJU1/YP1zrsQa738VtQegLA4rNxbfmEl9vjTZYhPqe?=
 =?us-ascii?Q?8DhI68mFaJcD2rSckQGh3yJ0Jn1U7714G598s50R1yHhIovwTFcZpEBIZdgh?=
 =?us-ascii?Q?MkeB0Ee9QhpuuNmBnMhmdgoXhIJJo7KHb7Wbw8SSLl7u+9KJzaunSpktIF9h?=
 =?us-ascii?Q?KmnpsQ7WQG17H/uiD8/dNahZyAJgwZz5aSjxFTdNDG21obIWqopVkJXwsPOH?=
 =?us-ascii?Q?tsfmYDCjcwMJeX6a1/g1rLgICIKB1d3mIh+eKkfveMEaSvWNR+iNnvAHLCBy?=
 =?us-ascii?Q?MFmglkuTbVIYQO1Ogr+EQSSDMLz3vOMj+WRfspJYOcqb76AJqlIwBK6Mb6t+?=
 =?us-ascii?Q?5cKmCTyt8jNFw9xyRSsvlOy3I1iZICuBXT6ADBFYRkucbkHNPd79s0wFesyM?=
 =?us-ascii?Q?emEojfwLCJ+ZUXr5A9Vukp0Q+P5yl44SIasSL5BMhYv/l6mUx/URaggyKElQ?=
 =?us-ascii?Q?eU6RqqyYvu0moEuPvD35zXZ6xxFXgVcpFBue/5HjYSS3FugFaaNLCWUw4zDO?=
 =?us-ascii?Q?c5o1nELBYB4M8sjshAhYzKcfXQwksEbRYGMX8P+ihl5d0LTgWOottf+zgjNf?=
 =?us-ascii?Q?ZnyUcyzV0eK33okvLY5NWgp6BQ58uOqU1FK3VSvTgXM5ubHpIJlX8rc6kQ3j?=
 =?us-ascii?Q?i93W86EbRGmLNSpjKV2lsVAx9tUXDxfqPinU1pI4/edf6SWB+ncfT9uxR/v0?=
 =?us-ascii?Q?LxkX7PZLE3AF2rKzFE+fX3s18cnfcGajSX8/SIHVBvpIZ4bdWYG2UnxmvN52?=
 =?us-ascii?Q?aeH8O9aV1oniErPFhNW4OFWOovoafLXyLYfgNHuJBhncPzM2UOfZD1KLP60G?=
 =?us-ascii?Q?9anFOt6BA/wNvlJIyOlsDsn4301CES5pDwptWA2wfKGdQdIu2mt+yyFgjjkd?=
 =?us-ascii?Q?XYqiSYb6ALU/HTxT0mZ7RPtQ66Qt845sQgak10lrJqAUyLl4AfdjeNceVnfe?=
 =?us-ascii?Q?HS3MtxKlMYo3YYDI6KVqp+wU6siitSlEBO73sV/CU7R9X88ReRw8SooELakB?=
 =?us-ascii?Q?u7VYYAo+11dkTZU3ekXs44OQWj9q0QBte5XkBxknjgIaMormn/wknGyvYK39?=
 =?us-ascii?Q?X+KX+xA+OalvCpK8g594Vec/G6zX0nS1nAdmA1dYjHzERF6C8AlXk0DKPuJH?=
 =?us-ascii?Q?Ng=3D=3D?=
X-OriginatorOrg: eideticom.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ff788045-f79f-4488-3ea0-08dc9f6f1618
X-MS-Exchange-CrossTenant-AuthSource: DM6PR19MB4248.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2024 16:57:44.2254
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3490cd4b-0360-4377-abb1-15f8c5af8fc2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WqKcl5Hbl2Jd5CKOBgnss6ZhRNBbS8+vCf8BL3Wd44pH09ogyc33Gt7DVYEpEGfpN64kt9pKF3FqAR96LnLgggPshelZNlpmrwgoDtns3Y8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY3PR19MB5028

If the device supports P2PDMA, add the FOLL_PCI_P2PDMA flag

This allows ibv_reg_mr() and friends to use P2PDMA memory that has been
mmaped into userspace for MRs in IB and RDMA transactions.

Co-developed-by: Logan Gunthorpe <logang@deltatee.com>
Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
Signed-off-by: Martin Oliveira <martin.oliveira@eideticom.com>
Acked-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/infiniband/core/umem.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/infiniband/core/umem.c b/drivers/infiniband/core/umem.c
index 07c571c7b699..b59bb6e1475e 100644
--- a/drivers/infiniband/core/umem.c
+++ b/drivers/infiniband/core/umem.c
@@ -208,6 +208,9 @@ struct ib_umem *ib_umem_get(struct ib_device *device, unsigned long addr,
 	if (umem->writable)
 		gup_flags |= FOLL_WRITE;
 
+	if (ib_dma_pci_p2p_dma_supported(device))
+		gup_flags |= FOLL_PCI_P2PDMA;
+
 	while (npages) {
 		cond_resched();
 		pinned = pin_user_pages_fast(cur_base,
-- 
2.34.1


