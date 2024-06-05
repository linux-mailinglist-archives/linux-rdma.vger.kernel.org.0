Return-Path: <linux-rdma+bounces-2911-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CAC288FD67A
	for <lists+linux-rdma@lfdr.de>; Wed,  5 Jun 2024 21:30:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5C873283FF3
	for <lists+linux-rdma@lfdr.de>; Wed,  5 Jun 2024 19:30:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1038315251D;
	Wed,  5 Jun 2024 19:30:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=eideticcom.onmicrosoft.com header.i=@eideticcom.onmicrosoft.com header.b="eKIxsyEJ"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2108.outbound.protection.outlook.com [40.107.93.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E0BD1514E6;
	Wed,  5 Jun 2024 19:30:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.108
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717615817; cv=fail; b=KLVTx5KH2tdNF2oCVvg02CpBdnLwnfxYU9zcQ9Yoqn7VfADHjuFjjIA6UebQiRZVNWfd7NiOetQyZcKTtv/enRM6Ygb1Qc5pOs3Kf/fjvifmG6N7g/iQ3d0eOWaE01+zNOc8ozVlSrW+EwcqpzVpub4xXBn22SO0+xQOf4ofJmc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717615817; c=relaxed/simple;
	bh=lHcUZ3NvxnbtMqRhknZ0Iw5RAbVyYCkcnwGIeE2WsAw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=cBbr/c4c4lL15yVit1N/nmbbWCFgw/tmEqd+YwZNaUh36Mo670Yl17m9hslkSNFkOgujOQ1eKAORAU44QjOi0s6BS9c169ehuKTEYa2+HIK7EPlUJMVn6NwSaB7aspgsygTqKTglJPktO/JAOum9yMLUwi5CO4wgV8RWNXSHs5E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=eideticom.com; spf=pass smtp.mailfrom=eideticom.com; dkim=pass (1024-bit key) header.d=eideticcom.onmicrosoft.com header.i=@eideticcom.onmicrosoft.com header.b=eKIxsyEJ; arc=fail smtp.client-ip=40.107.93.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=eideticom.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=eideticom.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RCJUpJ2IutU8ePDFInzmoOLx7wg9qGOZ+jua48lJapdtFrMhlwllyFOAgNI5rc1WFfHTOyl1FfY9f3k3pHfm6ovBPVBIdVaD9+mfBLujrBG4qSCPo8asU9I7BqoQe8ialQauaIT5O52NkM2bqNB6b/JWM9OnKPoRqA37Q+NIUJ8geptKVSrZb3T3r+DY4XyH+lf25gJ7tLi7JnSOziSHT0mBVG4Q7C7UcLfkXH0z4Gf+A7snmFonqd6oIVKZVfeoL5DVPe0IMLDtOBtv6Q9bge1X5QTpyNyNTZlxp9hSWdjgcuvPKcplgxEt1OHlkCWmKe/zYjwI3MoQHn7/NjpCiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ScBkgt1wt5k1bldXcuOR8HMDzAQDH+qNdKr1J9JI+eE=;
 b=dkA9AVynqQ6aSKbcQ4QORLvDmr/GjCRjj5+5a6HvIj5waLjRq3f5UBnWWyJsHNmReSD4fmuSNpBJuPNOSK2bue2sq2u5Mxui8D6bZQgwyOHD16lbRB7w3gfwYHPqSa9YFoFSWWB2oT79pBygqGJe58v+vcSmjVzzvONCZPwGfyBF7OeBmRNCfP4L2GJJ7B2Rl1Mr/Za2xh5WH0X7HlY8U0+TrDv/nAxrUIL1TjV2uD/e6kNy8p+tRdT68hKThCHbzdt8rODhGATRkjCax4uwQ56T29IZ7ULMddPBPh10lxlXkjlmzMxam6AImcskj9/xj4wgu1J83Q77O27D8XuMZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=eideticom.com; dmarc=pass action=none
 header.from=eideticom.com; dkim=pass header.d=eideticom.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=eideticcom.onmicrosoft.com; s=selector2-eideticcom-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ScBkgt1wt5k1bldXcuOR8HMDzAQDH+qNdKr1J9JI+eE=;
 b=eKIxsyEJ4QgMM8cH7CiQwTH4tSOydLvKorYAUWnrurP0BjqbNbv8VPekix52P6BEYsIm3otcE4YZ9AA2rEkv086ISvb67Go+OdiEB7ZqOuHCaGYEnXhIdsWAM7IsAcEiLrMPvJQP5y1+G/5qzoztZFnvNCBKAWoqzwJCV39zT8A=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=eideticom.com;
Received: from MW3PR19MB4250.namprd19.prod.outlook.com (2603:10b6:303:46::16)
 by PH8PR19MB7093.namprd19.prod.outlook.com (2603:10b6:510:223::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.21; Wed, 5 Jun
 2024 19:30:10 +0000
Received: from MW3PR19MB4250.namprd19.prod.outlook.com
 ([fe80::3280:d8d:de43:6376]) by MW3PR19MB4250.namprd19.prod.outlook.com
 ([fe80::3280:d8d:de43:6376%6]) with mapi id 15.20.7633.033; Wed, 5 Jun 2024
 19:30:10 +0000
From: Martin Oliveira <martin.oliveira@eideticom.com>
To: linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-mm@kvack.org
Cc: Jason Gunthorpe <jgg@ziepe.ca>,
	Leon Romanovsky <leon@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Logan Gunthorpe <logang@deltatee.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Tejun Heo <tj@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Mike Marciniszyn <mike.marciniszyn@intel.com>,
	Michael Guralnik <michaelgur@nvidia.com>,
	Martin Oliveira <martin.oliveira@eideticom.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Ard Biesheuvel <ardb@kernel.org>,
	Valentine Sinitsyn <valesini@yandex-team.ru>,
	Lukas Wunner <lukas@wunner.de>
Subject: [PATCH 3/6] PCI/P2PDMA: create VMA without page_mkwrite() operator
Date: Wed,  5 Jun 2024 13:29:31 -0600
Message-Id: <20240605192934.742369-4-martin.oliveira@eideticom.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240605192934.742369-1-martin.oliveira@eideticom.com>
References: <20240605192934.742369-1-martin.oliveira@eideticom.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW4P222CA0007.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:303:114::12) To MW3PR19MB4250.namprd19.prod.outlook.com
 (2603:10b6:303:46::16)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR19MB4250:EE_|PH8PR19MB7093:EE_
X-MS-Office365-Filtering-Correlation-Id: 7aca9095-b192-4d61-0f68-08dc8595e840
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|52116005|7416005|376005|1800799015|366007|38350700005;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?KywcyXlpsHxAW3EOdHyjlbTeco2wZfPYHzE3hjky8MKLqxU+x3+fI5qZDt/6?=
 =?us-ascii?Q?ysClTYOSD1Mzjm1cZnTjI1kPUvcPa90Pamk1cZbUtFKUhAxxynPWh7e3n/oa?=
 =?us-ascii?Q?VOR1JDGulGRRExnmxdfhHIiEg1MgYD2HrjUwcbg5g/04j2tLmPXzwlh1iAIW?=
 =?us-ascii?Q?Ggkoa8QrtWs4LrETMy8thl7kZ8glOXpphHR1ygqrhxbqtl6bf3bhBxo5VscO?=
 =?us-ascii?Q?Zrtmns1kGcZGPpjKWU5RQKfmoUrMNPfMx3nZrEHupWAv04feHSZYxQnxqVcW?=
 =?us-ascii?Q?8kyghTq+mX+7Fg0OeHyKbC3HJYJ7DqAoD7yOPRLnCbJg9c0hL3wY/49FdgpB?=
 =?us-ascii?Q?oVTtY82IXsqPd/dAZsbjbseCsxXYGUNPvlo1fNjNzjxNzj0kzZZ3XRqADynk?=
 =?us-ascii?Q?hIN8vxIn/RVco37S+gmXsILlgPu20gSUZYumKZZ+PIvjSPd/BIei6+mzmtgi?=
 =?us-ascii?Q?1X7ca3AsKfJ/OXAMZDoqTYlL+dpB0GX4KZpep6BsUbHRei/naEU/uZ/CW0gg?=
 =?us-ascii?Q?3XOvp/G/HwVIENd471sqHxBqwT9K6d01h6TNVQlYKJ85fKe6+Vytgqu8CXRz?=
 =?us-ascii?Q?5V1fqkVhQnT8z+atPJsOSQXaxp869nA/uWUQNbiYPdhzaOltxKKqLJHcXdL5?=
 =?us-ascii?Q?cq+QO83mnJ/VRhkrW5IbWTa6Bt4X4qbqxUMNkq5XcHwGFyS6LL7S5Ji0ddDc?=
 =?us-ascii?Q?pY9e2076G7hiJZoASI+9Mq689jpD6DTHgKH6n4j89Q3b3qQoKfwhYjfjXzio?=
 =?us-ascii?Q?r1tVmf1xRU1Kn0f4Sg2aIOhiLlky4aiAZ15ZK+lUStgb+c1lmo6qUsOsddsp?=
 =?us-ascii?Q?cXiFFwbLGKQCbOv8ONVPIBam5QNwmOyhQwBxZfLd0hoiFK19cXlxsw8oCVrf?=
 =?us-ascii?Q?8imhca8DCJ5YcObUOwb0n66Yg8UyGPqVjPRUIdrdDJir8medKHV/rB2Pobng?=
 =?us-ascii?Q?xXMpjvddn6N1bOPmN671HeqEMno1/W4crCpJcEmvuRcrlyrGEaFqRUfYqlv6?=
 =?us-ascii?Q?tizUlC9TpYwYbGu04fExkvOBMOYWjVc0c8fRPCg/jE8WFw+FstFXyzQGlkal?=
 =?us-ascii?Q?2oOjNHUuGNVafGkRF1x8D02iay0DYhvjXi0ULnxTV0F+giFSbwRHOH4dh3TP?=
 =?us-ascii?Q?X+sv/VjIlkwjAoXIaptx5VjSmqRpuWGMD6cxllIPvlic5bl+hsVfl+6LVpoM?=
 =?us-ascii?Q?uUXGjFUY73CS0E/axL6KV0oR7d1jp7olLV4jHBmTvF6oJtxCz6BsIEwvSxdx?=
 =?us-ascii?Q?cNMWnpzR+rZo6Elfhti3KqBSBFW/CBxKF+nOOZFZM6sv/avrdd1E0VwP7gTc?=
 =?us-ascii?Q?ZKVKQLa6Bolw91A7PLFUh/OUlCSaJ5/qtgtwOZZc+YP58SjMMm0Uo+x2KYt3?=
 =?us-ascii?Q?v4I/XJc=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR19MB4250.namprd19.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(52116005)(7416005)(376005)(1800799015)(366007)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?2WHdetvNHqzPOiRgdKlU0TnI3fHLhedUykoJBmuhCRWT4lnVOc7+zphNmYk0?=
 =?us-ascii?Q?a7Pf+J/PfeIp6GzMvkedFAEQ9I2YWXccfkxmEWStJk1d0ghwS9wUE2PHVGG4?=
 =?us-ascii?Q?sCEK7MLWVr2SJH8sSndXlZMBdDo3SLbNeegmCRLdiPHRwLnoiImApp1K4MXq?=
 =?us-ascii?Q?WkLNt5WB59sUHE7SCUlEoethGFFOCyG37hcHghTd6v30v5q7n69LFLE8tTt9?=
 =?us-ascii?Q?wdfbS2tf3/v8hRgJ5Wh682hNlFoQzxONE81ygGpxpSKUKSK6NqaM5GR0M3Pm?=
 =?us-ascii?Q?fOIzE0DccthI/qShhXKg4VD1pPCVhIYlzNeUS5Q1kB122tJQa2toYwvSjAxI?=
 =?us-ascii?Q?v/K4H1EmkT53C9yiTOPxEaKNRD97VHJ/RQ6zQTfJJI4pU8ZsrDmfDALSba1/?=
 =?us-ascii?Q?HfyNfxD/dJej8lNEJDCdH8BBs3INAcPZwsoHqsmWvsBXKtfgiF21XMFeasTO?=
 =?us-ascii?Q?789K5zZOLR1+93E1zzh/oWOx6ireG95WS4EvD6Da1OBtkNIUy/Jv/iNUBdWV?=
 =?us-ascii?Q?VP0OdZXlY8WdK26LS+ntmz9bOD+dmrck+WQ8aliTc6plvx8bmbrYtLlCiPDY?=
 =?us-ascii?Q?2VLlbfm2Tb+Y9rHVMiB3sKEjNxtZDyt4J2NHnbmcOSo40E641/qAV+/siDPi?=
 =?us-ascii?Q?zE1M1HGFbZU+v98MynRc2+YQr+iIofn7sW8QFRP5xB/t+RDQ1P8S9ETVG3B/?=
 =?us-ascii?Q?cNsvndNjdHuQ3pQcz24O/mgAncx7W4zjqsPEglHKwhH7mZXjuFiN6lU0patT?=
 =?us-ascii?Q?PaPye5GjmhGZ4t9aHgDFkoihH+9njQR2WIHR3EAVbg9j8i0Gq7hlM1XnibDe?=
 =?us-ascii?Q?0ujLa9t84yVIbQx8CsEBvh4ywlSd8/ckDpSR2lLHUhIAGemxiYYXebpPjJ03?=
 =?us-ascii?Q?X10s468GRZV2L7EaXP6Kk1o9oT2/Hidf4t77h916sCJnXVc2uLn28JWULGVr?=
 =?us-ascii?Q?q5NwMgzkSWsdwcDwm0bnsP43V43hSyFI3MsWdH3cCxI0pcM3d8VG7nUdJ6/z?=
 =?us-ascii?Q?3y6+b4oMJToOQ4hvv6Tc4Zfr14HhEqwUJRDiN/KyDLeBODh5MSOdL0gk5d59?=
 =?us-ascii?Q?sSprnQKE/feVK+HKr+3nqtRD/FFtozCy7PWsFDFH17uB2eZMRtmj9/sf8nCf?=
 =?us-ascii?Q?7lkU/dqsGYWSeH1SNpuJwexk19WGBpJkBl+zrgZkxD7gJihfQEvU29VoLocK?=
 =?us-ascii?Q?rTjkkmGLdo75F9/A748HF5It+fddpwm13wNJgXS4mh/MTRwBKtGuSjukDmjq?=
 =?us-ascii?Q?meaLkdk9pBgUKjZVLh2KBgmEoagdgMaDPv30Lbm3/73i6YtZ0w1refGZWVdZ?=
 =?us-ascii?Q?Vi8ngm5ivibOavAY74sgATghDDHLlKqi1U71O1tiYbqzMO8AO4Fhxz1VT1f8?=
 =?us-ascii?Q?sOVICoGyvY9Mqnba2iCa4MHtPCj77cF5SYQfdHH6zNpIa3sa6XWdnFy6+kIK?=
 =?us-ascii?Q?u+NOUtzqw+4Z/lxCuh7mj/ytryNcd4LViiYGGfkjIML74/IVljckCqF3Aseg?=
 =?us-ascii?Q?zfAh6i+aaYAHywfpwdCTAGtpqpuD/LeS9oaJ+QS0CADv5oB7A+682tN/WA45?=
 =?us-ascii?Q?i9zYnJWsq9GWsP2gLEt2GCuejNe7TP0fBvDalvoG+m7zQdNf8SxCRp9TTAmE?=
 =?us-ascii?Q?ug=3D=3D?=
X-OriginatorOrg: eideticom.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7aca9095-b192-4d61-0f68-08dc8595e840
X-MS-Exchange-CrossTenant-AuthSource: MW3PR19MB4250.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2024 19:30:07.3996
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3490cd4b-0360-4377-abb1-15f8c5af8fc2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OzI08ObFfg51Y3IXXgHpZqt/XXVhthmYxvHT1F7jB2yJpfPynR1mwxgKejqnhAv6sTCZApUMR4BY/M4n/C2peOfYW2NObOJYyfcagRraxY0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR19MB7093

The P2PDMA code does not need (or want) a page_mkwrite() operator on its
VMA.

Furthermore, having the page_mkwrite() operator causes
writable_file_mapping_allowed() to fail due to
vma_needs_dirty_tracking() on the gup flow, which is a pre-requisite for
enabling P2PDMA with FOLL_LONGTERM use cases.

Co-developed-by: Logan Gunthorpe <logang@deltatee.com>
Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
Signed-off-by: Martin Oliveira <martin.oliveira@eideticom.com>
---
 drivers/pci/p2pdma.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pci/p2pdma.c b/drivers/pci/p2pdma.c
index 4f47a13cb500..ac07053abfea 100644
--- a/drivers/pci/p2pdma.c
+++ b/drivers/pci/p2pdma.c
@@ -171,6 +171,7 @@ static struct bin_attribute p2pmem_alloc_attr = {
 	 * to be very large.
 	 */
 	.size = SZ_1T,
+	.mmap_allocates = true,
 };
 
 static struct attribute *p2pmem_attrs[] = {
-- 
2.34.1


