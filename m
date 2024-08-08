Return-Path: <linux-rdma+bounces-4253-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 89E3494C465
	for <lists+linux-rdma@lfdr.de>; Thu,  8 Aug 2024 20:34:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0624C288211
	for <lists+linux-rdma@lfdr.de>; Thu,  8 Aug 2024 18:34:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0EC8149C7B;
	Thu,  8 Aug 2024 18:33:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=eideticcom.onmicrosoft.com header.i=@eideticcom.onmicrosoft.com header.b="pCt6/GQM"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2130.outbound.protection.outlook.com [40.107.96.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E08814659C;
	Thu,  8 Aug 2024 18:33:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.130
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723142035; cv=fail; b=i6ee4hzJPkAFOBUT+REeirRP0ILnFvo528fgkGbt+Ifkui9CfHiQFqfkd2y/edSOta8bvWR2PKNBTI1ASanlfhokY88PMeYSpMQbrgcxnKybmB4ZYF8qFLinuhG3fLWnQNWNuJWXT2RDeZ59WEhuRGCUdnIPnHZ3nsKx/wbZLmA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723142035; c=relaxed/simple;
	bh=RjeCSzCGxnOSVEcFpY03afi0pc0ccHNEt0bQzkNpncc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=DIdirZzJsL+r1aZvBM5V23+qwa6pHWXefTbHFO/WZU+y3w2w+3LKgfWgYAtQIBL/i25qkkOUNB7u8jNrtiJ2J1imHeNM7OY6mVW6Yvd8OccFMEREjadPzW3X/ZGECtbw6vhyXrF2fCYjX9+MXk6aWystz4tSfwuzl+eAq4Vah4Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=eideticom.com; spf=pass smtp.mailfrom=eideticom.com; dkim=pass (1024-bit key) header.d=eideticcom.onmicrosoft.com header.i=@eideticcom.onmicrosoft.com header.b=pCt6/GQM; arc=fail smtp.client-ip=40.107.96.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=eideticom.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=eideticom.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ujKbGVM/axt7s2s03Kq0Dx2ivf1QCazH56D+jlb1s/edim5b0r+zROzuq4EvRz2JH4NnsL9tL4TQju5iWEZsMPC2F86AL25Ph8BenIyR8BWvyAoKiB1Wu/Dle6UiwkXihtWes9RWpQ1Fa0jLTKTucu5wVCYT4lA3DW2ju02nFf3d7vt4zwJtBE6WEFR0gurW9Rz+sliK1TGcK76lLlhBc4JoulsnGRFHhBBA1QKlU0g7/kwaStFrZMYTk63y8VErAjUBX9Qs6Cz7oL4oMEg0k7silWB2UZ3NLw4/iFzro/6wYo3Wq7xlqCaZF6RJjJaGzzjpbJ7VtC+aXYbDZpc5pw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EQhK3ka/BH1jfrlP7Pg1JtnFuCDr3tWdul7G2/wv3bQ=;
 b=RzQgEDzw2wzQsXciaxIfsLzqXrFbq/ptQSy0LvYOBAQ5jiFBupM85qoXqoT1MXAFFnn7/R8gjx0UHnlUmpEN+/drpA+vjiA38jNPa3ulqHJtdbMxLKE1uITz7qUQJIrZyW/Xh49C3Qxp9fEobWyDtFfxJT/I+nKeCVATDaYniwV7azmnG1x5DeqkftqiIVIL9nMyYTIIqrJJAwCTxBI23CaBvV6sgUo5Q70FmqpCorKHXuViN9xxtz+VcP36RVw+4zfxGM+OGH5YnxCljYRzfgiR+QxtgvNkGvR1YQxXeeLKvJWlVUZHNTRTZa9pncThfF0eaLoPFYdL0QcYauJ0FQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=eideticom.com; dmarc=pass action=none
 header.from=eideticom.com; dkim=pass header.d=eideticom.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=eideticcom.onmicrosoft.com; s=selector2-eideticcom-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EQhK3ka/BH1jfrlP7Pg1JtnFuCDr3tWdul7G2/wv3bQ=;
 b=pCt6/GQMCb9KY3IQvgT3Zjn3GZqxZa9WNtmMOz8ofyX+7K219UKQq9fWoOF+gihMoScigvn0LwnGWqbD8emKuu7PUlQL+zjwEteou+E622CcNRSQpLIxaI88HS65W9gimlimr19Qn2ECIinNXufzMj4N91hLwtTymj1DVzBNWo4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=eideticom.com;
Received: from PH7PR19MB6828.namprd19.prod.outlook.com (2603:10b6:510:1ba::20)
 by IA1PR19MB6348.namprd19.prod.outlook.com (2603:10b6:208:3e4::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.14; Thu, 8 Aug
 2024 18:33:51 +0000
Received: from PH7PR19MB6828.namprd19.prod.outlook.com
 ([fe80::69c8:bdb9:b882:b849]) by PH7PR19MB6828.namprd19.prod.outlook.com
 ([fe80::69c8:bdb9:b882:b849%3]) with mapi id 15.20.7828.023; Thu, 8 Aug 2024
 18:33:51 +0000
From: Martin Oliveira <martin.oliveira@eideticom.com>
To: linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Artemy Kovalyov <artemyko@nvidia.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Leon Romanovsky <leon@kernel.org>,
	Logan Gunthorpe <logang@deltatee.com>,
	Michael Guralnik <michaelgur@nvidia.com>,
	Mike Marciniszyn <mike.marciniszyn@intel.com>,
	Shiraz Saleem <shiraz.saleem@intel.com>,
	Tejun Heo <tj@kernel.org>,
	John Hubbard <jhubbard@nvidia.com>,
	Dan Williams <dan.j.williams@intel.com>,
	David Sloan <david.sloan@eideticom.com>,
	Martin Oliveira <martin.oliveira@eideticom.com>
Subject: [PATCH v5 1/4] kernfs: add a WARN_ON_ONCE if ->close is set
Date: Thu,  8 Aug 2024 12:33:37 -0600
Message-ID: <20240808183340.483468-2-martin.oliveira@eideticom.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240808183340.483468-1-martin.oliveira@eideticom.com>
References: <20240808183340.483468-1-martin.oliveira@eideticom.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW4PR04CA0072.namprd04.prod.outlook.com
 (2603:10b6:303:6b::17) To PH7PR19MB6828.namprd19.prod.outlook.com
 (2603:10b6:510:1ba::20)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR19MB6828:EE_|IA1PR19MB6348:EE_
X-MS-Office365-Filtering-Correlation-Id: bda6de14-1593-4c29-67bb-08dcb7d8a682
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|52116014|7416014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?CEhCZS9sMTJ1esH9bk0rVDVeNdGLF9TSe5mwNJL8zjXfcW5r9KSzbLUWM+yv?=
 =?us-ascii?Q?a0tPV4rSXrGvJK6xYv3SEqoBffMN3Z7swGR2JaZAvJ3p/deqKhvQOIlZ/2To?=
 =?us-ascii?Q?RK9EDV8aEqA7L6PNwd29R3IBahJmix90TnmlxhSZ+ZC44RC5er8V95gYRfaC?=
 =?us-ascii?Q?3cdv+H7t0eay2NRFPsYinbcJLBzdsiJ8Os3NTbq0X5XRrLhglWQ+GUdXG8YX?=
 =?us-ascii?Q?lGeT+6ANGvhBDGO7zFu7K4jo4jLk76WvadXbq85S0SfMmAjGVgLDggMrRPt+?=
 =?us-ascii?Q?n1pHwU9CewrmFu7AxX4BtMbBYjw0F40JEWM/BUpFanexI4fRRfEYOUsEgQvV?=
 =?us-ascii?Q?87884mTQA+zHr+NCbXGcon2sZtWeekwk6niKzihS30sBkvMr0r297TmcBK+X?=
 =?us-ascii?Q?gVommeJMMd7l8sdb6iUM9NetvAqgWihGwYZq7BjgoJoU+e1Zc8H56nEaS/K7?=
 =?us-ascii?Q?4UFrq6ZqYZnk2+toexRT6qSEV3//IyYIPuVfg68QZFmY1c0uaZytiTp/j8YA?=
 =?us-ascii?Q?hzCevSXLaaxsWd6tMcBUkD3SoKHYnXyxl18+/dMscKKdSdm6l56zzrkVyh6J?=
 =?us-ascii?Q?JBh0F1mAfPano0zsNr8Ikr8BhQby5q2X92/pcrxv8GESGB9aLkbDZC5laRSP?=
 =?us-ascii?Q?mrII0QpmKjXxvj3Rs53hTmclaGCP/gTVxf9ihXyFQHUK3KBh1GHLFmyXhMcK?=
 =?us-ascii?Q?4OJkeb7rSyCSsx5K1m5gQnwFysHA9hujuslXlmh1FT2Gkn5ouDfK5o275/1q?=
 =?us-ascii?Q?moQ0Bwcon74Kbjo6JQtTKhPscBYcLbVcQG4rH9b41wew/CsurNullwVl4JJA?=
 =?us-ascii?Q?92nkvd61rpurSfGhBOxGOjrWgvn0PT0UUX4slmrL5aJx920j4YoGRWwSMJCP?=
 =?us-ascii?Q?kxd/5QObEUNvamk1H8yGjAt7D1X/q5yQIPBO5qDcN+bPe2s/1cIkJdKvdoo1?=
 =?us-ascii?Q?8NICRewq14homDHKY2vjosXLFTvPW1bTLIhatmAAURnfs6+yThiSsQ/6knxI?=
 =?us-ascii?Q?/AZR2bSv86+hHQ3/pnaheU1J49pBCfSTkjDJPZ0oOLHO2db++A4DdX06OXDh?=
 =?us-ascii?Q?DYd5ipReuAvnmghxTOscZ+ZouWUkwkItW66qIJBVTiuzKvsP0Ea+hT2SKzhG?=
 =?us-ascii?Q?yIyLsiefxAEdZ7hkRp2GAHWKi8hXSxhV6rHTFodvIbUyWbM+HfJODSyVv1vr?=
 =?us-ascii?Q?lleHoAXBGnijJ3wrXf7ttIAK3WjS/at+Dl+TL/DsTE6YR988+iW/TU6Qwv+e?=
 =?us-ascii?Q?mJtEZoRIOPjbxVJnszq+uCfEAMSl+zpnF7zHI9TOliuBjif9cQuVMh8oepDn?=
 =?us-ascii?Q?chjd/DkbHtMLWsfHC2WjxTLQrmDaslnwecNYvyft5LJrso48es47RETd6RVY?=
 =?us-ascii?Q?oRjT0mK3Bk2saIpVCBLhnlOlHhvUUW+t5uXBrF8aGLbDovOU0A=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR19MB6828.namprd19.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(52116014)(7416014)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Fi/gFOVZMYxQh1NqESXyi2ZuokP7jcoRykqQh+XKoIUWxoxkQiSP8u44FfgV?=
 =?us-ascii?Q?Dr+LMFJcQ4vlqiHM4Ww34ITkmsgOHXpxremA3f/GB8e4ds5EwNxvlKpRdZRQ?=
 =?us-ascii?Q?PHYCx7Dv9rESbJZC45B8ArdgngvQDKcNBatLR9jwybzKOix6AZHGrdwi5+YJ?=
 =?us-ascii?Q?pr9iU4HkdBCjK7CMhEYfKvV2NCZWxyJ4nF8CWMzbaD5UBOt3F3zZC43qXlG5?=
 =?us-ascii?Q?YSZQmOyyxNs8v45L3Ma+01ubKnahmS0gQTSf7wbY9Jg2DGSVSS6qcISEnFzU?=
 =?us-ascii?Q?6YvXf+/8QUcpGsTk8ziUZ99AaO3CVuI9P97HTaHBq2zuGpNybAIyYC2LVIrI?=
 =?us-ascii?Q?nDDy+oSG1BZygGGVjTYnA6sHP0oR77+ZiilV33qxwKS7HECfS8UX3PAS1j0x?=
 =?us-ascii?Q?Tumi/X/fBtPk9PedNKygblo94wJaS+mpK98b/bIvX2zKJWT67wV88A8m1MVF?=
 =?us-ascii?Q?URBUfeVAS4+hkf9ZOaollpJH+3BqjDyW3fSQSOtMxesy5jPArDIQcZFON6lj?=
 =?us-ascii?Q?HMzIe6OCfe+qE5OGpQxiUK63Plc2hFSOXDaUMmetDLatsRJBE2AA7MP6Guii?=
 =?us-ascii?Q?ZWP1TPvvbncb3eesK3LII5CaOMAj2oRkrh+cnAeduiOJw86jgZ686ovtv+Ob?=
 =?us-ascii?Q?2pe22RZMSmq2uR50NQl2yX3B6LGvaT+Qvl07awfBFLZ8dn76F4mNCC62XZok?=
 =?us-ascii?Q?nx6XhDaojj+tOwU8/CxR1IVL6a4jIF7RJuYipQeBUWy44DdzQKWTlXSeyqp2?=
 =?us-ascii?Q?5+pREbMqsUwXsBPQZtXiyG9a4w1ivCQwx7Y7dj/DsRNao9/5Ihd9w8T7/hK7?=
 =?us-ascii?Q?7+OZ+3T30MW9mwTaD04JR9I/RHWVe79p/dIZNmrtxrxqI1j5JrjGn4dE/BF1?=
 =?us-ascii?Q?KCKGCt6Y7vw58JBsapOo0K09wTGfSGALbdRO3teOHiwJWodYBQ8/9Uo0+M+k?=
 =?us-ascii?Q?hEO9vtBqMwzIpo/YcYX4ybjX08Umi4gHqGQ6KJRVQLpW3wGtm6FUZx3su4Um?=
 =?us-ascii?Q?5GGH4rLm7zZrb87E1aBj9ftoeUduhFP22IvNUvmyly5UJk1G0pbnCWdkY7DJ?=
 =?us-ascii?Q?VB+J5vMA51gn+franN041upSCRotdwWO6jAcN+aQ6cOXwba4t0RGIe11gDPq?=
 =?us-ascii?Q?ZWFrZsEoIUvRTPoZKRwkcXpjN2YTSGU1UsnCe4niR4zLVxdQFn2uSBzBCaLh?=
 =?us-ascii?Q?zKbOOsw7mNxTxrzBj/lACfDTSQGpRNWxYBRl2voPXg0Qqhns3mSulS0Epi7F?=
 =?us-ascii?Q?4BeBb3CyvA7NOAnmZinL3FxwPkEll9v+D24yOkRqqHou7AGCgi+Hc7zDRn/N?=
 =?us-ascii?Q?AzwXZvV+NRrY96Dhqavd/RKq3jMk3dMayqVN4vQQ9HRYyNhsBkPArphAx2QX?=
 =?us-ascii?Q?rAoWbiaTDmA96cvnVSvrJ5p7g03SlmwVP93o1aKhumlf3NODBXUDBPpWF+fS?=
 =?us-ascii?Q?JWNJ6isxs93cRRlz90KcrCFdpu1vYlcKfpmqgWkGwzMmMBHGUFLlOovQGjqJ?=
 =?us-ascii?Q?z+2TSdM4DVH+6bNrdXqN9hiV7/AzB3rYpc/n+9v9GO6fimIBM6xaEvUcAR9J?=
 =?us-ascii?Q?6bWdhTyROWDNiJpVC8iCu01tYj5P9rwApLVT2vllkCa4l57uUgJqzp+C1SrH?=
 =?us-ascii?Q?jbKegtZkhcyRTuXL770qktM=3D?=
X-OriginatorOrg: eideticom.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bda6de14-1593-4c29-67bb-08dcb7d8a682
X-MS-Exchange-CrossTenant-AuthSource: PH7PR19MB6828.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2024 18:33:51.6167
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3490cd4b-0360-4377-abb1-15f8c5af8fc2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2XB5/nzF0dz+IwSzCdRb7Um9IuYaSHhy+VBs0E8fwLwC7IjC6enFdTxHKYEWlEyLxVxurt5xZ5DBz0Ro4TFqzqob/KF+zJYEtI0pmJf0HuU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR19MB6348

The next patch is going to remove .page_mkwrite from kernfs and will
WARN if an mmap implementation sets .page_mkwrite.

In preparation for that change, and to make it consistent, add a WARN to
the ->close check.

Co-developed-by: Logan Gunthorpe <logang@deltatee.com>
Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
Signed-off-by: Martin Oliveira <martin.oliveira@eideticom.com>
---
 fs/kernfs/file.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/kernfs/file.c b/fs/kernfs/file.c
index 8502ef68459b..72cc51dcf870 100644
--- a/fs/kernfs/file.c
+++ b/fs/kernfs/file.c
@@ -479,7 +479,7 @@ static int kernfs_fop_mmap(struct file *file, struct vm_area_struct *vma)
 	 * It is not possible to successfully wrap close.
 	 * So error if someone is trying to use close.
 	 */
-	if (vma->vm_ops && vma->vm_ops->close)
+	if (WARN_ON_ONCE(vma->vm_ops && vma->vm_ops->close))
 		goto out_put;
 
 	rc = 0;
-- 
2.43.0


