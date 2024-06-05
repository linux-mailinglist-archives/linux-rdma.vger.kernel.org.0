Return-Path: <linux-rdma+bounces-2914-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D4028FD684
	for <lists+linux-rdma@lfdr.de>; Wed,  5 Jun 2024 21:31:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 413911C23B90
	for <lists+linux-rdma@lfdr.de>; Wed,  5 Jun 2024 19:31:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 870F3153810;
	Wed,  5 Jun 2024 19:30:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=eideticcom.onmicrosoft.com header.i=@eideticcom.onmicrosoft.com header.b="XmY7N24H"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2108.outbound.protection.outlook.com [40.107.93.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8BCD152DE3;
	Wed,  5 Jun 2024 19:30:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.108
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717615821; cv=fail; b=uC04UcPhVkfzHJV2/2XUxNStmG95nF5pVVOqiidbM1dNDoZa+ye1/6mLe2fvO66zBrWbyiCAi8Eeon1irixzL8z3ZG89eRqMDThU1jvCn8DEoQUmgZPyPWZQU5rv9FkVwHAmaHq7nzivnG8Ni0SgP03yQnJDFLQZBvkzdCyVYcg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717615821; c=relaxed/simple;
	bh=VUOi/nym8uyAVQs+oU2FUZ4YJ90xHnL7HrdK72INAi0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=mTUhmK8tZ8ZUnpoBTbe3nfcn5spOSQzBK0f/+6aIbrghZTJ9pt16nAJNDSrCwEw67VsylY+vrl7BRA9M34lmrTfAREhVDLt5Gs6UYU8EebzWdE/BcnVQVNMAcqAe5Z1ziQgiZE66T/DWLUEPX3IC2YLmzFtg0KUudONPCE5cZSI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=eideticom.com; spf=pass smtp.mailfrom=eideticom.com; dkim=pass (1024-bit key) header.d=eideticcom.onmicrosoft.com header.i=@eideticcom.onmicrosoft.com header.b=XmY7N24H; arc=fail smtp.client-ip=40.107.93.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=eideticom.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=eideticom.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R5Wc5I8kWOnMSKLf6n25aiuDGSvJepxgclGwL1qop6btuSlG+Ez8kuQA8ZhxUGr2QPmgMUceWLtnNpkfrmVWe3kDcQZyO2tYab34Y0+R73oNQCKzmroEcrQqpwQ5ZeDDWlv5OKPwLEnSM4YdeaDsOgyLdDjnRyc5OQkYvFORSwb5zoICy08t8MADzMnmHeOItKVf0vt3qUA4tegPhnPxPzwahJ6aIyY/1wIMF4ijkrYT9/kQpnCyhnfXZ5TZdZb2RRP4FUL1R68mI3QP8AhFZC0KpBeN/wROxDyaUZxpdinRDYQXFyL9bv6ubmiVVHZO7whUKlu4TUBsTSe+XgcI9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j5B11FdDkWD/wobhQyNE+H9hqFfSjPlnvBrJ5gpnZ9s=;
 b=Z8FWRihpngsU7kU3U8m/MV2pAHAXCKbpyaUifqmgKMLz5eFmPAUOglac9n6eVTxqKjKGkS5tyeYvfDsy1fRHvS74HayNvXvQCHNA1IzChkEYhe9NoNqJWsXV3urjzlo5y0+hzFb+YtLJ98oiCsxL9u0ldt+/p8evpDFyZ24Npz4E2RBAVQDNrqs++4I4+K5F3++5wdk4Bf0jIVuStkw/U8iyX+2fa/KNqD9RvpiRk3o98zwQM6W+PdCHkZWGmV58nNKac8udE92k3A9rJM1AFH1SJqO43brpPO8OSX7f5EcwIbauVrQ2PZYGA69h+YFYarke5JE9BqhfOoFumSanwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=eideticom.com; dmarc=pass action=none
 header.from=eideticom.com; dkim=pass header.d=eideticom.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=eideticcom.onmicrosoft.com; s=selector2-eideticcom-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j5B11FdDkWD/wobhQyNE+H9hqFfSjPlnvBrJ5gpnZ9s=;
 b=XmY7N24HanHgev8gGgInDQx/xJUqALr2VboKKJ2NXL/CR1aibK1Ni0WngaKUCOhXBiVrYK0c7uVQNz+9e7vEsPSZwL/mos3yu0H5705zKrJqKXSUEqcWbDjvU8gzqvFH6DoEHv5Dtnt6+am4CoigNEKZmrRz7/oxqE1CXKBMx9Q=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=eideticom.com;
Received: from MW3PR19MB4250.namprd19.prod.outlook.com (2603:10b6:303:46::16)
 by PH8PR19MB7093.namprd19.prod.outlook.com (2603:10b6:510:223::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.21; Wed, 5 Jun
 2024 19:30:11 +0000
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
Subject: [PATCH 5/6] mm/gup: allow FOLL_LONGTERM & FOLL_PCI_P2PDMA
Date: Wed,  5 Jun 2024 13:29:33 -0600
Message-Id: <20240605192934.742369-6-martin.oliveira@eideticom.com>
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
X-MS-Office365-Filtering-Correlation-Id: 9c8d2dfc-0b27-48cc-d87c-08dc8595e969
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|52116005|7416005|376005|1800799015|366007|38350700005;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?R1ArN8sqOQXgN2EXY67vgawmb4bfvurXXX+x8Zz6D36bmthfyun4r1Omvw3J?=
 =?us-ascii?Q?y5l7o53n3RVcIeXOGBbUl7/WrixD58XQfEQXsWZSbGyfnI16rzu4Ap8EWwvU?=
 =?us-ascii?Q?EbfcFeJ4sz7pmtP7x5VQ4F9GuriYshYNFB3f2cJVVtxU4yOmESVaCiybu4OP?=
 =?us-ascii?Q?9S1mbpfldn2DI4VglcdoqUCg/MN1iNcFcXhdBcHOAzBLlrKPFYI377J1QzH0?=
 =?us-ascii?Q?nRennP+Mli2nswwFFN/Ry7jRB0qZQO3BbiYDj5VIgF7vTASAudSjcYJqnRcY?=
 =?us-ascii?Q?6WHAJrRGMBsZCGjO/Dr1rhKd68NY8Kdq71agKtLHC5bsSsysZjaSNR0YzLu8?=
 =?us-ascii?Q?D1Tnnhr20zNwYoSnHjX0SGJQSds+wE8bi2p0RPxs6D4k3ytZIJCuaQKNg5ca?=
 =?us-ascii?Q?v1e0SxSGRvoqPppfcKcq/PLVYlh9HgKpM1+o2Mol/hHKruOHRvvdYlxnnR8a?=
 =?us-ascii?Q?lmVpogLYJVeAr1RKmVXf7wzw1QwbcCarKwjjghfiI3+ykBqRe69bd9bUsOxh?=
 =?us-ascii?Q?CJ7rn8LNN3xHLL2RZYS5bEwcRCgitlaJ0YHKW7Kztravb/DowvURIUGjA5pW?=
 =?us-ascii?Q?2RaQ1Gx7hSZCyOkr6+YduC7QJc+ntx/gm7x0hEY6u+9Ihpy8s3tpWcr7jZ7z?=
 =?us-ascii?Q?u68vb1B1rD15ks9KE9Bp+yGXuUJq4UcdbjO6+cb4E4HDgCA0BVjTDb0p1mb+?=
 =?us-ascii?Q?vMiLotC869Xr9sH+663Es45U5idhoMWxPVQC28JnP4J0J29rGr6UOZjJfSk+?=
 =?us-ascii?Q?QTyaJqhEyrrWJbZty69bnwc9sArlIhJ+Rw4JYbQS91v/Pi6/YTDbD/T1+5n0?=
 =?us-ascii?Q?1R5Pr/im6hOxYdx7wiqJq1eMt5s08saUmk0hii9ovuRgqjJoVxQg4TgbhjMO?=
 =?us-ascii?Q?Q3oZmd9Xhhjb6qrb3w/qUmIPPCOZ7+88R4rWXlVSe94VJb6AVzjeIvPIDofy?=
 =?us-ascii?Q?c6gb/MXrXL/A9rcyPXxE3Z5cxl1OReE6exPlHQqBlXOicGVATc1bEL2OgmJs?=
 =?us-ascii?Q?4kkMhLlYZ+Fhh7BXuDkwWzHjN7JfN7TkIuhoZoz22uqO75N8IWrJagtHKQjy?=
 =?us-ascii?Q?d624A8FHc7cNSqHsnDqZ3tQkQn7eihbynMeOg10nmrkhfYm7icapsIqAQx/q?=
 =?us-ascii?Q?u4Dlq/deF8penEU2Ua8qZwc4uvI2R50I7WH8wbV1wf9pffnm8APDFLbeSYy7?=
 =?us-ascii?Q?QcGrxomahUWQ030cNiylrZdXOAMtYI+uwcssL9/ss7v7Yduvea5Wyaz50Yvr?=
 =?us-ascii?Q?YZWanrPCQKiV9ys1v47MK+jJlvEWgiNfoLYI7w6H/q9M4ptlkLYia7olnAUV?=
 =?us-ascii?Q?lKvuNMD7DcvcHNK81PHbIHqZ7++W+83cHx7dAnuNq3RVj8TkX6yyvRgfYvyB?=
 =?us-ascii?Q?JZD9Pm0=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR19MB4250.namprd19.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(52116005)(7416005)(376005)(1800799015)(366007)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Mf35F/cWIkuaaScaGDguCG8V/by0hLcB+4RKy3usMauvo2s3BNx5o+dEypva?=
 =?us-ascii?Q?KXYdOCBoi0Z4N815nkILKrkazHy2itH0wFd9Os6I85A6yoQ2G/0Se3AIrn+k?=
 =?us-ascii?Q?j1L1uIRes8nm19qsouD+VTide5OjfXkT4QDZor1OBTo6yy9eAKs2tEuP7KCX?=
 =?us-ascii?Q?jhGWG/wy45zFMjhjyqT2vFLoeDL2m5nY9jbnxLmOeH7Mfnz2Mu1dubZ3xnyv?=
 =?us-ascii?Q?WpzklZMBwxKkEW/md1Ka6yVG6aSX3O4ulX85Yisqg6lYMpiM9WNwZoyYESib?=
 =?us-ascii?Q?JJMKZCTKL7hE+GZPjtAd7nDF5MdsQA4vXYsp47nzeqgTBEfAAqTImN+3Owda?=
 =?us-ascii?Q?K+yVvjTyQZdmmUJCQ2WlMFcQ0nrlELTuPJGxErQe0OFzDas5iRzDG7SrZAdn?=
 =?us-ascii?Q?npOZFfOVFxbltNJ7A325XFJVw1K36tXHSlHWyZCA+7hBAKtedfWn2eduVhEP?=
 =?us-ascii?Q?pYYWCtrWJ/LmL8T0yC3K2il9164zOYTU4fgKUCfmY2A8+8GjiUIOylZPY/lv?=
 =?us-ascii?Q?ITpN649JCwsNJbTjzpa5P6CJTM1BIkJtT3T6gG60eThVGnr0mtHng4sBIgXz?=
 =?us-ascii?Q?1Ey08nf08rHXFQ0iyDp3TJuU6Nb/Q/i2ksYjs86Rn1+ay8m8WGqsYccWtE5q?=
 =?us-ascii?Q?Ddh71lHHi/cs3ecl5NZDhAHT9NOBnjYXkC+mws7FrxeUzQNGH79FWIfsNqbS?=
 =?us-ascii?Q?VvtcEBfG8H9gq3sX5yiiOfFsIDJLhkEhdrffy71+68K+ox7Z7UHScgR/8ckm?=
 =?us-ascii?Q?6UBR7jc4o03+b59rSgHPpBcsH/KqScvR6jEKU40tr1MoqbpvtCSmtJUxL0oU?=
 =?us-ascii?Q?KLLnAUrpshcpMblEHzj+NrhCw7k6O3O+s3yOelpW7agsfpcmf/aHBMqMAkih?=
 =?us-ascii?Q?VF8ppSEXUVnEBwzJ35fKyBzAaKytydWGq7ktZCSH4284CTauKJFRdE1BCKsn?=
 =?us-ascii?Q?dDQ93D+tKLfHrZo1sueayiClkJenKUtUjffdnSHZrjnDuNnMsU4NTa/hSpIZ?=
 =?us-ascii?Q?tFUCvsaepJi4NZ9qTMPD4jWXJ/jwZ5PUE+vgup3z58Bl/4xXtS0xbBVSHCUM?=
 =?us-ascii?Q?dJ31tAj1hr/xdXLRMhLMJA/6jj4cdTPrVennOUkZ6zFBUUvQyHVu2D98/YDN?=
 =?us-ascii?Q?QjPGofH/FWgLAaItaogn/V23po/+aFMs8CKn46JxpARKdlRVPbGJ6JRmhIoz?=
 =?us-ascii?Q?sejlmGqKnzB79oUhBdqmw2B8BNA91Nk8Z/4CyRE2RwBaZItc3JhAfy+8egHx?=
 =?us-ascii?Q?DTBIc4/DE77FAuV0VL0/bBkp03cVnUnNMsvncdYBob/+KGi0MecfEpDm+5db?=
 =?us-ascii?Q?91it9im5QljICdp/FI9W2HPooOPb1CbUyLSTPkkDRHi//Nvgs3+2wOFRfH1v?=
 =?us-ascii?Q?nBR/zIlFNyjhWNfCqN+oYVpxBPjx3S9q0McewiDL2U1LiD1k6f2GXWdWp0zB?=
 =?us-ascii?Q?wyXYs/gB5DFf8eE09mNPbGlOjZYIFPMRjdnWGqpWK4Jjkqcd94TVttm+PZk7?=
 =?us-ascii?Q?i5uRDTiJ9bqpx+n0LmwUk3z9KJSdtQ375VgpVwV+iCMnuIgdIB5wACZG7vCG?=
 =?us-ascii?Q?d+/tHj80buxcnL4k1j+uqjQXZN3nMs3XQV3hT9GP1z0Bh7dEpdl/3CqikLUk?=
 =?us-ascii?Q?Rw=3D=3D?=
X-OriginatorOrg: eideticom.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c8d2dfc-0b27-48cc-d87c-08dc8595e969
X-MS-Exchange-CrossTenant-AuthSource: MW3PR19MB4250.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2024 19:30:09.4140
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3490cd4b-0360-4377-abb1-15f8c5af8fc2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qmVv2frgPeMSslsX9CVbY/cjzo/CaJG47zFK50JgOqg5VP4qjZ5UtoRdf9cTbDMOrSx869XKKVBNvYSv+y7U8tz5YVpGOC6C4ZUF60ca9rE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR19MB7093

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
index 00d0a77112f4..28060e41788d 100644
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


