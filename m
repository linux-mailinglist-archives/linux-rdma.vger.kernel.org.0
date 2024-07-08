Return-Path: <linux-rdma+bounces-3751-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9130792A7B3
	for <lists+linux-rdma@lfdr.de>; Mon,  8 Jul 2024 18:57:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C1A0A1C20FF4
	for <lists+linux-rdma@lfdr.de>; Mon,  8 Jul 2024 16:57:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F014B148319;
	Mon,  8 Jul 2024 16:57:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=eideticcom.onmicrosoft.com header.i=@eideticcom.onmicrosoft.com header.b="ba9ew+05"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2111.outbound.protection.outlook.com [40.107.92.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B8191474BE;
	Mon,  8 Jul 2024 16:57:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.111
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720457867; cv=fail; b=OknAwAKZKMDc5LZB8R1BIL6/wG5LRomnjEPtv3/JBAdJBrqNgjtYfhLvc7RB9Ye4mSXBrehvG5T7hCLNTo2632HoszUT4AjXzu94HKt4mwx5bKZTOgBZkx43Dc82xqf3DvR1gEL8qcESq6FmHg0yMsc89YCpG4fvO3d/KDYJ4Ic=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720457867; c=relaxed/simple;
	bh=3uQI0rqYALZkwyAE6tVThIY7sHPMtEUB0iamPboTASA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=DNYiIwVJtilgVTbZQNQZ73XQ+kV2+Q+WvDOASY0UcsPQiPaznWanCzxvfc5fEbQx8JABkJiAWq6wngcVh0q4DUVvTPlh+W71mPRsEmQ31ewByf2dJexOTZ8NrdXNyJUp/EDt2bDErNWC3AUA5OxcUhMO7XYD2E3ypkm2N+Nu7ks=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=eideticom.com; spf=pass smtp.mailfrom=eideticom.com; dkim=pass (1024-bit key) header.d=eideticcom.onmicrosoft.com header.i=@eideticcom.onmicrosoft.com header.b=ba9ew+05; arc=fail smtp.client-ip=40.107.92.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=eideticom.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=eideticom.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MjtVhcClUyfJw/wQMbOMh68lYH0+822o4eSifTUdYOaWOeT5725kRTDhejlww0cPEvEpWxkRIbQkVSVXUe3gR9GFpUhvkc6ghLuHIrnoSIs0sq8W25TeJ6ArUpaOd8zGi4W7a8TaiKhOX1Wbo/ZJhGsoCt4fLeSM41w7nYLHxOd9uvj98/B72mNj+Dspsz0xxVy+mwH0SO8hQgx4VTqtyO9y0gzeDCtdnfLFqzbkBfcxOEGHetW1bvFwJsUTs2aLGGe+tv/X6nS5AJzjeXlmifTwYXuV78EfCelQ7QbUF+RaJqnF6NMmckXNIcjERan+8e/CXVmrcExF/lQdECEDHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lYp/stGLWTk2gTG0FcZxnAS3NZ14yVcWXZJlVtyXPTQ=;
 b=NaM71RJeF40dwkG2ezAS8fkWYMmqci1F2fZ/N/MWftzMaM3y878+a8FqEOwg5b3ldzzPGyr5cgvyan4FZlSq80ojc+nmZ2tt2nX+Top/VsVsbFaep+iJwpn8CBsno2fz/a7ZdLuFg4SdWvDxImvSl3KN8goPvkz2n+kZ21Jjg1/a4XhMssQxw3t1F2ZSMzV6C4PhBL3ANF7gLu1e+wx06XR1Sk+xbQwww98aUjZ8UgPNbax7gx3bmgIJvtZn0M5yP/eXYwzaOa/4rEadQaVtVtmOlvO4836k2KPAI60GyNcdaRCnVjaQXwB5SZyAxdhWYX6T+3pQDvkPNSyOjw28pw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=eideticom.com; dmarc=pass action=none
 header.from=eideticom.com; dkim=pass header.d=eideticom.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=eideticcom.onmicrosoft.com; s=selector2-eideticcom-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lYp/stGLWTk2gTG0FcZxnAS3NZ14yVcWXZJlVtyXPTQ=;
 b=ba9ew+050HVndYP3/8eDoY7TdBdglurTOcQ/uebhOyJsk9vkdH/G9Qir88aXjkW6kg2va4ZHyI+bdTMcUeyDB6xbAjNVBs86vEjNfhwU2gWWyea6KMrluMm1tMelDkUPttHBhacPFO3i2RCOZHtv2f8GmQoyL0Zw1d2LMFbwKxk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=eideticom.com;
Received: from DM6PR19MB4248.namprd19.prod.outlook.com (2603:10b6:5:2b0::11)
 by BY3PR19MB5028.namprd19.prod.outlook.com (2603:10b6:a03:361::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.35; Mon, 8 Jul
 2024 16:57:41 +0000
Received: from DM6PR19MB4248.namprd19.prod.outlook.com
 ([fe80::d508:c71a:eb4f:7cf4]) by DM6PR19MB4248.namprd19.prod.outlook.com
 ([fe80::d508:c71a:eb4f:7cf4%6]) with mapi id 15.20.7741.033; Mon, 8 Jul 2024
 16:57:41 +0000
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
Subject: [PATCH v4 1/3] kernfs: remove page_mkwrite() from vm_operations_struct
Date: Mon,  8 Jul 2024 10:57:12 -0600
Message-Id: <20240708165714.3401377-2-martin.oliveira@eideticom.com>
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
X-MS-Office365-Filtering-Correlation-Id: 8e92b340-5a31-4b03-27de-08dc9f6f144c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|52116014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?IcWMnKsPssgtg7sMcNbp3lUM31I62TRWhcLkxEV2wkZ7WLqIOgkMV8aLSxuZ?=
 =?us-ascii?Q?prlYA4hsmT+D2v1Rn125YdTVDUgZBRoZjEjbt1CmP3DSfZSpMPhZyZtxPv17?=
 =?us-ascii?Q?w68Tfdota9iy0YOaYvJtcYQ5KFyt6NFya+Mnzsd82xklTiZ/y0Mwp/Rqh7Tr?=
 =?us-ascii?Q?zfQks792HHzOGb3IdMa6ZWulBHJJcVugCVunH2rB7MNFu+cZ4sz2ZpZpnQmS?=
 =?us-ascii?Q?emG7yHbjTMFPDRAhxw8qeSUX/imuLqkNyN9p3BQ5l6rqnOuC1q3N5WmSTshY?=
 =?us-ascii?Q?0qs42HWqwgjhXGaETiuDV6tiwiyE+sbYyQTEGIyL/ozEJ2401PZ+FfRUt29+?=
 =?us-ascii?Q?eotFYbcPaADmDnWRWG4f0wYuZj3X7FnjoISJvAFPRaSFPpngS8q+fh7Gmar9?=
 =?us-ascii?Q?h4OAxvVyay7xvmCO/VMo5/xdE5ADCAwBQjv82WER/vbp7BwAjrA8eduHxLGR?=
 =?us-ascii?Q?7Pp7zVbBbKpAxo4wWQokUJQ3FUF4g1bQTwXeE761SEr+JGw4FQJt15kINGT1?=
 =?us-ascii?Q?NQdMsZdm2MRtSIOdNMS1Q/bf2u6ehwfJe8XQD9aUopGAm4lZb6fwcWqhtVEA?=
 =?us-ascii?Q?c6fsTzFM7+vTBGf/iSxIGisw4B+p9vTmv4QUDaOdqI8KmKhGufgao1hkIiPL?=
 =?us-ascii?Q?U6NsKWkbHrOvWl1C31CIfgT5GViOuUtFk6XUf6yRokWaAZpoahshaV2xR3++?=
 =?us-ascii?Q?k1vYxTGLOL3v+h5y1r+ZZouyYrv20CjYTRA2KUroBLyc625MiFgO0tjAAHAt?=
 =?us-ascii?Q?hSCzH9Cj7qHjM5+DYAhAgvHkBjv4k2S/tmgBy6UD3dEUYR07Rhh60t/f7/fp?=
 =?us-ascii?Q?aAjcQzkg0I6dFEW0pMa9kwqzbANqSs40ifNEacfR4R2T2txRfb9C79jJnOSX?=
 =?us-ascii?Q?w9WztJKg3IKv/TgA3f6u6o/abaHdeYr4fOP31kKkHBB1yhmNyLr6Bn/sYuhx?=
 =?us-ascii?Q?LGdsyyjMOb6N3E7S2n8wDDBKfsShU5IYIw+QILT/cq15mrKcEfXPrbgZLArd?=
 =?us-ascii?Q?M5DL/Q6/fVP8qV46qwQDGyRUIy5IvVvWJjqPNWhpDDxhA2GLIP/oOz+sUg7L?=
 =?us-ascii?Q?6LfJkRSEuTxyRyFPiNxy0yDLqhTenEuXQg8ua58e8AYMeKuhwjmnKk/iWaSl?=
 =?us-ascii?Q?aAbg5ocDQXIZjdceYQOg5h4JLrACtqmn9mxQQQEdkKTFZChRiWqRWl83WuP6?=
 =?us-ascii?Q?fgeJY1IVhY+mnsuXhTKV/5od/aGytMPqN3OYubkGCl5rEaVtWQwetMjhdARX?=
 =?us-ascii?Q?Otrc5s5hlN1FcTdVPJQzortWiIGbF/D1MYxMWiz6eV9kXovW4u8rkLWP6X4S?=
 =?us-ascii?Q?iL0rvXA2857i+HYdd5M99+OU533f0HTDxYfGAQ4XiFuJFt2E/PzsBPevUBpv?=
 =?us-ascii?Q?wV1ZM3SfjGS0h6BMHK5To4u0H6RchpBx6+FqJf8qreHo6OfseA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR19MB4248.namprd19.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(52116014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?aYEd0Lp4zSKqOMA76BPNObq+2MjX/D1q1wDF1CQm+pY8Q7eTBC8yUa6ELcBR?=
 =?us-ascii?Q?gJ82h2/RNQu2Huyg3iVjP/cW7srdmKJQ6GhOUyqiwz3KY8ySE+LlE79MMriZ?=
 =?us-ascii?Q?RZQGAP48t5LbVC2Pvzt8Ynll+1ewaHW4gfHZLNqFH7cDbcU2iQV2K0gd5SB8?=
 =?us-ascii?Q?uvs05VD5K4ZWcKpA2iSqTZYQJURiMUx9bC6d4/PrOsmbjXxn7QoUP8MoMJF1?=
 =?us-ascii?Q?jRvPX3tLX80RmqS0PksaSILlYLeX9Hw56Gq9fv5C6BZv8lPkZLRwvb3w7msE?=
 =?us-ascii?Q?+oAHatk7S/0yrbH1D1he3ShMOwwmwlXx74BOTrATAfZa8tPZeXr6zCK8Eo9Y?=
 =?us-ascii?Q?sMdFA2FcPvJ1r3wNbV8mV39x1DuQQHt7aVR9c8dxOFBVcVC2z5N6/LGZRtHb?=
 =?us-ascii?Q?DQhopFYiw0sUZgJT8AppHK8mUe4aQqJSNUWLb4y6oSHj4PZQ3fbzNZSUiv4A?=
 =?us-ascii?Q?IqkUkSvQ0cBZ/flCaVVh9E/2cKmKhQKw/hqppmHJfGexKB8VWLpIIKCksSGB?=
 =?us-ascii?Q?QqofhdsIpt6rNQoX2CQ74pBwcs3cUtMF0sg+xaIIabPVxI9PvW7HjWuSke+4?=
 =?us-ascii?Q?YcAvmulGNioo2MU/uEU/1Fo7rstz/ZqpdDDHdjQgUBZ1mcsCs+AWal75Dy38?=
 =?us-ascii?Q?OIbWMG7THUm5MDVyX+RbZGEaAPGXvdkG3ztee0Yh0lO51Jbhw6HMtyef3C/c?=
 =?us-ascii?Q?9MTKsh7r/VFVI+Y4HPtdoaDzokFpv8ga68V3n3bDelOg19KPQvwNRNmA8Kjc?=
 =?us-ascii?Q?bR/RidToHj7sW6u41pfodx3ENEW4+GzTljt/Oej+FTUr5nc3Ppy0I49/auuw?=
 =?us-ascii?Q?pBi5/fqLHzYmqCAYbj2iqpsO/yrxsulbZ4AyI32nkbjlPSLmMaGAKF0lGHHo?=
 =?us-ascii?Q?f6uOONCWSeQnE++BRZGfNu8M5WrYLkBti21yTZvdCoM8q7vHP7cTx/Zk27Oc?=
 =?us-ascii?Q?UT27QLcO6Bqu9dk0RfiYFJu+7/m9g6pDiOOX8+rtf6CilJSGNyzRcRumO9HF?=
 =?us-ascii?Q?gFfuUWZUgDgI8wnDtmc1Xed/kA7Pv9qFMqQJO73xq0qJbF+dRDoik6xZw+g6?=
 =?us-ascii?Q?eJDP6WmYgo0lzjNHG1jXuX2xXPyCEdhr67W7Vmj9xZYcN/zGf6Jwk0ng1IXm?=
 =?us-ascii?Q?S4kbn6o+i5nsEISbyBAptvDOjJzzfu7EqLtDtK/2mTHedp2FtiPBbnHKE6t7?=
 =?us-ascii?Q?IyEKlRR+2X5chyzlv0prA/dj4WCT8WXZwY5viv/adrj9svCekgTRvVSQbTBv?=
 =?us-ascii?Q?cLnQRFrWcqwzZaF7nIfuMPxW9cdXR1crzsIBikAzV+bPACtJ92VNl2QdE+Ey?=
 =?us-ascii?Q?4InsPHQsCoN6+wjn2BKpcaFD8TbkDr6PskCxWBoaCzRgniCxfKS6h7P+p49T?=
 =?us-ascii?Q?UNQ3SOGTeEvVnd1aDoHtNTWy5jmx64KW+XN8O0H2BJL47nzFlbC/aqqSuXUw?=
 =?us-ascii?Q?fdMKLEEtBN5NXMgRgkuohz6DoY5nz/qRtNu27i5B+FNziuCi6412tnd6ju0i?=
 =?us-ascii?Q?2Ss7jZ/TguTgLfVod4knp4tjAUgDtBOQ60cu+0z0pFQFZyHYzifDGxM3onCk?=
 =?us-ascii?Q?dMrbLTJjfAmiP0OcWhiaunnx6+qQCe+DO3vBlRGkG2FmEIQAQz8yvjyximoG?=
 =?us-ascii?Q?nA=3D=3D?=
X-OriginatorOrg: eideticom.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e92b340-5a31-4b03-27de-08dc9f6f144c
X-MS-Exchange-CrossTenant-AuthSource: DM6PR19MB4248.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2024 16:57:41.2017
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3490cd4b-0360-4377-abb1-15f8c5af8fc2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PGdH6cDoMyEtcKqfpoB1Ble3yPwJVLhSEpDROfa6n7Nd00BXZYTlOIjmvJpEW+Y3ABNxobxSPg7W4A+ap0NAFOeil2sPrroH057X9cI8q7I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY3PR19MB5028

The .page_mkwrite operator of kernfs just calls file_update_time().
This is the same behaviour that the fault code does if .page_mkwrite is
not set.

Furthermore, having the page_mkwrite() operator causes
writable_file_mapping_allowed() to fail due to
vma_needs_dirty_tracking() on the gup flow, which is a pre-requisite for
enabling P2PDMA over RDMA.

There are no users of .page_mkwrite and no known valid use cases, so
just remove the .page_mkwrite from kernfs_ops and WARN if an mmap()
implementation sets .page_mkwrite.

Co-developed-by: Logan Gunthorpe <logang@deltatee.com>
Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
Signed-off-by: Martin Oliveira <martin.oliveira@eideticom.com>
---
 fs/kernfs/file.c | 40 +++++++++++-----------------------------
 1 file changed, 11 insertions(+), 29 deletions(-)

diff --git a/fs/kernfs/file.c b/fs/kernfs/file.c
index 8502ef68459b..fb2b77bf0c04 100644
--- a/fs/kernfs/file.c
+++ b/fs/kernfs/file.c
@@ -386,28 +386,6 @@ static vm_fault_t kernfs_vma_fault(struct vm_fault *vmf)
 	return ret;
 }
 
-static vm_fault_t kernfs_vma_page_mkwrite(struct vm_fault *vmf)
-{
-	struct file *file = vmf->vma->vm_file;
-	struct kernfs_open_file *of = kernfs_of(file);
-	vm_fault_t ret;
-
-	if (!of->vm_ops)
-		return VM_FAULT_SIGBUS;
-
-	if (!kernfs_get_active(of->kn))
-		return VM_FAULT_SIGBUS;
-
-	ret = 0;
-	if (of->vm_ops->page_mkwrite)
-		ret = of->vm_ops->page_mkwrite(vmf);
-	else
-		file_update_time(file);
-
-	kernfs_put_active(of->kn);
-	return ret;
-}
-
 static int kernfs_vma_access(struct vm_area_struct *vma, unsigned long addr,
 			     void *buf, int len, int write)
 {
@@ -432,7 +410,6 @@ static int kernfs_vma_access(struct vm_area_struct *vma, unsigned long addr,
 static const struct vm_operations_struct kernfs_vm_ops = {
 	.open		= kernfs_vma_open,
 	.fault		= kernfs_vma_fault,
-	.page_mkwrite	= kernfs_vma_page_mkwrite,
 	.access		= kernfs_vma_access,
 };
 
@@ -475,12 +452,17 @@ static int kernfs_fop_mmap(struct file *file, struct vm_area_struct *vma)
 	if (of->mmapped && of->vm_ops != vma->vm_ops)
 		goto out_put;
 
-	/*
-	 * It is not possible to successfully wrap close.
-	 * So error if someone is trying to use close.
-	 */
-	if (vma->vm_ops && vma->vm_ops->close)
-		goto out_put;
+	if (vma->vm_ops) {
+		/*
+		 * It is not possible to successfully wrap close.
+		 * So error if someone is trying to use close.
+		 */
+		if (vma->vm_ops->close)
+			goto out_put;
+
+		if (WARN_ON_ONCE(vma->vm_ops->page_mkwrite))
+			goto out_put;
+	}
 
 	rc = 0;
 	if (!of->mmapped) {
-- 
2.34.1


