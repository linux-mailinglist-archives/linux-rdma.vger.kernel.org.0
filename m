Return-Path: <linux-rdma+bounces-2912-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 831548FD67D
	for <lists+linux-rdma@lfdr.de>; Wed,  5 Jun 2024 21:30:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E29F3284154
	for <lists+linux-rdma@lfdr.de>; Wed,  5 Jun 2024 19:30:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1F561527BC;
	Wed,  5 Jun 2024 19:30:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=eideticcom.onmicrosoft.com header.i=@eideticcom.onmicrosoft.com header.b="PoETp6y7"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2119.outbound.protection.outlook.com [40.107.93.119])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 148EE15252B;
	Wed,  5 Jun 2024 19:30:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.119
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717615819; cv=fail; b=DeV6EhOG6yB8O2vHAmCNh6ItWAIqHmmPhjmoUQJH0/AFdGjAitCbDI38CZGKjwzeweW86mcx+gqXKyawh31UG+9UT7uAjSpTLAwkIpkvj66yiIKSU23D20CTFnnANQSAAvnIzYiexuSs7lgLuw3ML7aYQ1JqG1MpBYDtyoWbqJs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717615819; c=relaxed/simple;
	bh=sM5X8/kb6my2Upwv3SLRjvo2VhakntM+cN119PFzm9w=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ZfGye/U/tDLn0DS3XFEjwmLzS9xNeh8f4cdC044ucrolojGVbsHh34KP60rwojAKwaja1kuwWnCMd9DT5SFoV8j5s5uORv5Odo+2iFs9BajvyAIpAiW4fA9a6t6KD+S0DnFkW/YSWyxZc6sZZ0ctx1B6orUVLknlnPVRdV9qaAE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=eideticom.com; spf=pass smtp.mailfrom=eideticom.com; dkim=pass (1024-bit key) header.d=eideticcom.onmicrosoft.com header.i=@eideticcom.onmicrosoft.com header.b=PoETp6y7; arc=fail smtp.client-ip=40.107.93.119
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=eideticom.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=eideticom.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NnhCaFMwFkup2VDq8pXN/lBV6JumlDZiTdFPbElDLQ2xXVV60Qbe5oPJBwps3Hj4mf0s0ODG/E4v+wXDuVF22UYyeiuEa+YrvQy4GlsBiQuM1YgF19Mpoqe9Vu/ZeTCdrAtdu6FL9w0LfeAJ36wr1g9wQkuCdDXdPZ8rf4dvfxdlpMdsV0sDc1XqBZ4SKJ/Inm7ttm2B0O+pmdi15DmBWHChdf1KyNJWARhrQTY1yiPtf4sUDUIggQMim3bjmwcQjDAnUMoQW6Wk/0K7CCpOuZniJNbwz54Zp3z5uTxxFGaear8z9AA1ANdrfRUqd0EWlyUjqLDFZbab16OPOPYt1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NXomzLN72KRZc63HTjgGadCKAKZ9c7ARjZWaUWmOvJI=;
 b=fbJhzYIEIy8JkTwUhOVbSJVaySHgbUiX06LTGtDOf1lkdd24u6ZvN/vJEwvs9fka9QAIM6OdO5e3R86Co08Pi1/g9gP7dVXEHXVQtRUBwec+DOIzDhEh70mRt0jqrVT81JYcTlBOlsMlfkd/40Pl5rR31yEbH9P/mrFUjq3/MTUgj0GQhGoL1ebrWeogGTTXLQThAVGv+SjS3i27Ag2njpooRYxu+hXta+4+eZp5XxDrfL5hclSzOgKFUXFbg/psZigDMInIvvBYwn5At908abJ2P+avXZGOsfPq6IvXNlwxhJkMoQgQGWnhxPLX1GybASuh7lShKF3sC4ABcl7dFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=eideticom.com; dmarc=pass action=none
 header.from=eideticom.com; dkim=pass header.d=eideticom.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=eideticcom.onmicrosoft.com; s=selector2-eideticcom-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NXomzLN72KRZc63HTjgGadCKAKZ9c7ARjZWaUWmOvJI=;
 b=PoETp6y7IMwtaXphE0R0yCZNsh7kfOcqpZy3SIvNj0hetJFvtWeMEvPCdlLbaCOlPthRrhAdZ67UBSznak2ZC1Onm+SkBESjRtkUz/GiTHjYEy0TAe9S68PgF8E8HAQFi5c5fN56fb73CLkXdvXOPURPZPT9DzI8DiIJSpAXHik=
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
Subject: [PATCH 4/6] mm/gup: handle ZONE_DEVICE pages in folio_fast_pin_allowed()
Date: Wed,  5 Jun 2024 13:29:32 -0600
Message-Id: <20240605192934.742369-5-martin.oliveira@eideticom.com>
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
X-MS-Office365-Filtering-Correlation-Id: c8f9cd98-a27c-4854-359d-08dc8595e8d2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|52116005|7416005|376005|1800799015|366007|38350700005;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?mKLUhvR2kaDeGHlqRRRwNzKKY1UhkljsDzu4jAGaW+NWPFw3RsafEAp59QNx?=
 =?us-ascii?Q?ZT8lzRQwIfkGJ4sdgNFW8Z1QV2fWJ9AAU/Gf9t1IWMouPcRQbB3D0E+URHX3?=
 =?us-ascii?Q?SPN8G7tAeCgZR/qgCGfHx+KaR50XkqL0PXVRS1O9Cyi3k166lmSQlneI9ydc?=
 =?us-ascii?Q?W8cpSjs0qZPgC0Hzifmc1gVAapsul98GaQSQvd+7drgGqipo67oP874q3mjK?=
 =?us-ascii?Q?g9nXXsnwHhEt2ttpdhcjAC6tlybpf5BdO7M6X3CLwlKrXp4vVomU3bawvGDn?=
 =?us-ascii?Q?RFyEHc7uz2lhLuxN/BnR17DoCfePlf/3RbiwKdTDcAJwxXVWXZtrFjhXbfLO?=
 =?us-ascii?Q?riCv251b12szHgcdbheT/nTNnblHgURrLKNkW+F+eW//Wn3zDEE9Iir7Iai6?=
 =?us-ascii?Q?2V2WN4krqG1LbVipapYc/YiZDnMGzFX0U4z+dWpl7Mp9eDg/lbUcrsZu4Y4d?=
 =?us-ascii?Q?qf7KS3Qckhk3DTUV+nP6OGexSzNvKcqUoR3/TElIFOMDLh3DKfFP2Yw4k0OC?=
 =?us-ascii?Q?1+Bjkz34407vo9QX+BctFKxJe8kh6jPK+oLAGnc71Wu23HTmsfGiqjFyQoLO?=
 =?us-ascii?Q?d3oojcfutZSHE017b88ZVMNVqKingEW4TNU341dfJ2+HM6zr/xoN8Uniw0AJ?=
 =?us-ascii?Q?FrBbD1omwsWSDQPXSfnTa35hUHbBLmOPGx1uwmueqKnuttjj/jtaKBog1+ys?=
 =?us-ascii?Q?B5lSD3ZtqbWGiUIGs4JswnSCJQ0Y/QSufoutUKJVJLsyUk9WY/9ivaW2hu/q?=
 =?us-ascii?Q?ndFXWxLPd3cWxyfrQ46myZ43gLHZE0IUzQoGbsn0HpbGd7rgg2ypCbw0c4e/?=
 =?us-ascii?Q?NMwBXvz5YfP4LGc0Ta2iT45ZMf9dxE7Fs4duta5nW7Yray8hMHp+mdGsFv7V?=
 =?us-ascii?Q?pky+7Mg8S8LThin54zmcFznt9IaBpoKCJwR+ObSe44BNQGrSJfcFLjibgkzh?=
 =?us-ascii?Q?BYy0bvoo67nEs7uGitTAl77MLNyK+iCPMhlRpeCoV9ukSzbJz9eYFnuU+QMN?=
 =?us-ascii?Q?kyaJmR0SlIzNeQLD2bU7wq6S+7KD3FcMiSLep3s4DGXHPT8OiE7U9VBr1dgh?=
 =?us-ascii?Q?azY2WCKYYHZftdGCEfWxjYn1kvLcD8SRJ19Fld3SLY41PdJgykQN6X3H81nK?=
 =?us-ascii?Q?gO/dDRVDz/XB7YsfqtMmse+6z9Hd84gv/GIormfH09RG4TLV/Kjsi/JANjrI?=
 =?us-ascii?Q?X5a4YbEkzcN2YEwIOAunOgtYGVdjooSIog3nYzKY2cXLSGcIgkpZ6Wc8pCCN?=
 =?us-ascii?Q?PkcJ2lG6usDOG+iF9a3RBoq0rydbW0CVtvDdqVhDSaoU/6QkJFAjb7sCb0pi?=
 =?us-ascii?Q?4MskiZmBvtqrkeKrMjoiaZduSM9aabQjDZyMdj9avDLmhwRh0tVo9YSkVoA7?=
 =?us-ascii?Q?XSPF/i4=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR19MB4250.namprd19.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(52116005)(7416005)(376005)(1800799015)(366007)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?4IBFn1lY282OsDf4NddzOKYkP/fowdqlq8KgJI23ox3+mexVZ2f7JzdratBB?=
 =?us-ascii?Q?W1MVnq4xM5MgkKXYN6RPn2T1jtDheXvs6oCW3ExKGdJlHP27pwZqeTGCZaiU?=
 =?us-ascii?Q?KZo6RdzjTlV+97T8fOkTJjc5f0Gwnz/lP/sB4ereOXBVX2ViGwBmTP/IScTL?=
 =?us-ascii?Q?osUGMKW++ks/sT09l6pyH2H5J1BMQ9YqLIKC1u3oAJQOC+4/TAx6jqfRRY6D?=
 =?us-ascii?Q?odX5AUnOuACr+gfA5J5bZ4Xwoqs3LNJLX5XugGH/GDstbZ6qZG36XRhdSnG1?=
 =?us-ascii?Q?LTcsWq66RPE+AtoEUVaP2+lN26bcgjUeXy3GoZFMVbNU48TL7xWz+CLtpAjV?=
 =?us-ascii?Q?9nLGGcxrZIze3Xdjsn+ddTGwztNoC5jSGfv5ihgBAHkGNucbxZgVmVBGILS1?=
 =?us-ascii?Q?YlQZXCMqCsYOtpLhPnCqYs93VXEAqj0dni6IM+rjBx6TU5MnQqZmkRvByAn/?=
 =?us-ascii?Q?MBEjL73tzbv/o8HaGijqacKZjIH1LU206Qa5Vut/yUMGz5OBpNiRb774DEpP?=
 =?us-ascii?Q?6FRwDCTfpyDlwSzu+i8ktqlkkhrvI1YQaBbhbhHbUcmnvnAgK9M5wjF/CYwK?=
 =?us-ascii?Q?U2d3qO769dbs7bYBN1mf/EutNuIUOVCE4f3h0y/FVOdSVHlHD0206yYfn5r7?=
 =?us-ascii?Q?Gpia9FB5aZtUHvedR5Cz+N8hjmA+iNU8hD/fcEbI+57FXGdjRSx++VkzeU4a?=
 =?us-ascii?Q?FZfhu1qeoIkkeAlRQ61J1xuAElXh3EJ/Up1ozDkvXj3SC+CJPt96MMjvvafA?=
 =?us-ascii?Q?AQH50SaDDg2Fd3MMRxfg5kGa18tm9WKYarhIqpTYGwEIqHl61LKD91IC5sf7?=
 =?us-ascii?Q?Q0kxy4SnaCXoGJLbBm0Zmt8YCfugGeENYlqOtfel0hACWhC0SfFO7UjjiUMh?=
 =?us-ascii?Q?AC0ilx6MBCBknIaQlfE/QzmugIuGvYXgNlIs0QrZZzawvTtwSB6jNfrnq62v?=
 =?us-ascii?Q?IGiWt3hV9ng+unKAv1cDz2lqvpmQK+Bae/+9L79dwUX8qMgt+GccbhsVXQMf?=
 =?us-ascii?Q?ZK6zrgSWOfHv+EimBArk3P9foTJ/c0OBOld1vSuZVZv7UnJzsZdoDqSIOfZ0?=
 =?us-ascii?Q?YG/HpsLvrSECQwZ6HRMexC+SvbhI8oT31xQjkm0nSb7oIQA54VuTXiPYSM4e?=
 =?us-ascii?Q?VAFWTzr5WPPen5cfW5Ng0HJ23NGaIUQn9SVm/rTHEHHnUWNYsaTrnO5p+FUe?=
 =?us-ascii?Q?mv9A9vG4GFvF3/tdRaDf4tmVmMzSSbcK/stZc70aVdJG1wWI1SP3QymiwN+o?=
 =?us-ascii?Q?FalpFUco+/vhqpN/9CTaAfDiScWoyk+FbbJB1URacGexnk0knwFj3QVObPeU?=
 =?us-ascii?Q?o9Usk6cnMR5S7QRuIbnx8N2yowGpBhfQE2xk22ykthGiRi2FZtdizOFDu0wB?=
 =?us-ascii?Q?0pebJ0i3AHv/Qy1V9hMT5uh2JNs6BTczxxCQsv3ZbrV6LmpfAAUxGCvETWLx?=
 =?us-ascii?Q?QhoXbZzlxzUEJZ2jheAKEBS73IcnTgNkEaI0VVh+77+d/EaR5sXfZarw+4Bn?=
 =?us-ascii?Q?bHqSGUxqRZ40y58I3NBx0NTf3Z6sgV08YXoOSWON3aHjUS2OeqTJN4v+mVZi?=
 =?us-ascii?Q?QCKbFikegZibsjeOi/e3YXZe/kKb2x9SBFXCXS+Elpb+LtQNlTNFMXcZ5XyK?=
 =?us-ascii?Q?Kg=3D=3D?=
X-OriginatorOrg: eideticom.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c8f9cd98-a27c-4854-359d-08dc8595e8d2
X-MS-Exchange-CrossTenant-AuthSource: MW3PR19MB4250.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2024 19:30:08.3573
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3490cd4b-0360-4377-abb1-15f8c5af8fc2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BI0UEcONtPBY/X4r+TTCEWAh7XN9ibi8UBXhRWi698FKrsBRJ8tep1KYqLgFquJmRpVjEXJK65NuXmPKwRj8MW4yycT6Au2Ncc10iuyvYFg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR19MB7093

folio_fast_pin_allowed() does not support ZONE_DEVICE pages because
currently it is impossible for that type of page to be used with
FOLL_LONGTERM. When this changes in a subsequent patch, this path will
attempt to read the mapping of a ZONE_DEVICE page which is not valid.

Instead, allow ZONE_DEVICE pages explicitly seeing they shouldn't pose
any problem with the fast path.

Co-developed-by: Logan Gunthorpe <logang@deltatee.com>
Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
Signed-off-by: Martin Oliveira <martin.oliveira@eideticom.com>
---
 mm/gup.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/mm/gup.c b/mm/gup.c
index ca0f5cedce9b..00d0a77112f4 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -2847,6 +2847,10 @@ static bool gup_fast_folio_allowed(struct folio *folio, unsigned int flags)
 	if (folio_test_hugetlb(folio))
 		return true;
 
+	/* It makes no sense to access the mapping of ZONE_DEVICE pages */
+	if (folio_is_zone_device(folio))
+		return true;
+
 	/*
 	 * GUP-fast disables IRQs. When IRQS are disabled, RCU grace periods
 	 * cannot proceed, which means no actions performed under RCU can
-- 
2.34.1


