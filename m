Return-Path: <linux-rdma+bounces-4255-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8225E94C469
	for <lists+linux-rdma@lfdr.de>; Thu,  8 Aug 2024 20:34:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 38666285B7D
	for <lists+linux-rdma@lfdr.de>; Thu,  8 Aug 2024 18:34:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72E3615572F;
	Thu,  8 Aug 2024 18:33:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=eideticcom.onmicrosoft.com header.i=@eideticcom.onmicrosoft.com header.b="JozcmOKv"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2130.outbound.protection.outlook.com [40.107.96.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7B46153BF7;
	Thu,  8 Aug 2024 18:33:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.130
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723142039; cv=fail; b=qimJ8uT6v640cnQR1NfhE2daY/lqwSPqyDqqe96OK1WHQ0k5r1hg2wU2OoYVuvUf3wfm6IVWOsAyW9EWAu+vy5FDX8Ga1VWoQGarP7ar060IhgptGBoml+aLZgzRdjCOXzEyABP61qRUL16lw8Tn2UgsoWXYnZ5cYb8xdgKod7Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723142039; c=relaxed/simple;
	bh=IS5k97kV4aZ+mFLbmqY5RYA47xnvX9Etmoc0CQch/Tw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Dsz7+ZCko5hCWdO3fiaIG3cmqm8JTHh9w03kFn4Z7Sl/ft7lf4m3DFK9uPSTbeUjhlgEnNxcXpGeJceKRHNAFq4TCw9Hy8bO16qPkJkm26sxBcLsbcLf8XK83RTqKJTNxAWXBvU2WPdRt0bgbpOV0jDY5ESROrkc/6vz9xShFiE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=eideticom.com; spf=pass smtp.mailfrom=eideticom.com; dkim=pass (1024-bit key) header.d=eideticcom.onmicrosoft.com header.i=@eideticcom.onmicrosoft.com header.b=JozcmOKv; arc=fail smtp.client-ip=40.107.96.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=eideticom.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=eideticom.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=e7iHeB+gO8ENeHmXvNMmqHVBDMebuXMQGSm6FcXwYVeVh9dkz+YvrDi0cT6aI+U+iRM4cJ+J5ZvnHPZLh5WpLyftTVu+zAqHLYGTLY4BqL2GoUu5EcqCQysMQloRcQ0Yh9RkUyjMBNFks+9bNrTKcQlet0kLpeU6NUjKzKV9jRhqmGtiLL5Xpi/1D2SzN4rb4wyeCFjGVnv0i783W8zf7Mh/SYY49FHUPH7a3+p4wa48JHaXoKUneJDBGQqeoA4nI2hEym3D2lRHNsZfE/AGdfccGrehPQmyycy9AW7HdRBlLEeiwOO1zK3x+IcjGlCaevCraVngXSfd7qehpYOj7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wBSqvI5dXaPzoETqbPOnxc/+b8+MULNZC8MMNCT5Abs=;
 b=gm9nTQmS8dKR5w3diNeHpML0mfKV3qidbZ6JFtxGiN/iFt7g21ocnDIL3kdmPmnhDTZrsftO0srP2SnfdXsF94C79uXvYLr4D1ecuXMe26WJN8AMrJkNiaxQVJQ5nLgQ3Is7g+W1ZRZrB81JLmwjUpqig3ksqK8pbKihLRKpFT0qIq18IIbjgrNf7o01cjtOhgHimIEZ77r3N5GL0SuRH6NbovGWU80ukNYy157GEGyHt0XVQgZFlFSVuN4rdI/f0Ts0aVhEIOM1W7wUUfHQ1exc/O6J01QQ3bvGK/R6FxFSsB0EpyNf9wG2GRti3Q1daO4TB9nd2OaIQk4+phKBqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=eideticom.com; dmarc=pass action=none
 header.from=eideticom.com; dkim=pass header.d=eideticom.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=eideticcom.onmicrosoft.com; s=selector2-eideticcom-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wBSqvI5dXaPzoETqbPOnxc/+b8+MULNZC8MMNCT5Abs=;
 b=JozcmOKvyz76ll7oNloZENONSDfQsNcyGa37c8IyKEOVqTJOzmllOSvqxkzTKU8SBfShrt0QpbYU5Cse19cJjV7YvmT5+noIZs12d2oT1NFqkUj649glfXOMS3a3eFkeAPQf7L/JfMta+DAc+PuqgV0cw3eY1MUhFHWXr2cvax0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=eideticom.com;
Received: from PH7PR19MB6828.namprd19.prod.outlook.com (2603:10b6:510:1ba::20)
 by IA1PR19MB6348.namprd19.prod.outlook.com (2603:10b6:208:3e4::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.14; Thu, 8 Aug
 2024 18:33:54 +0000
Received: from PH7PR19MB6828.namprd19.prod.outlook.com
 ([fe80::69c8:bdb9:b882:b849]) by PH7PR19MB6828.namprd19.prod.outlook.com
 ([fe80::69c8:bdb9:b882:b849%3]) with mapi id 15.20.7828.023; Thu, 8 Aug 2024
 18:33:54 +0000
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
Subject: [PATCH v5 3/4] mm/gup: allow FOLL_LONGTERM & FOLL_PCI_P2PDMA
Date: Thu,  8 Aug 2024 12:33:39 -0600
Message-ID: <20240808183340.483468-4-martin.oliveira@eideticom.com>
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
X-MS-Office365-Filtering-Correlation-Id: 8f15b87d-7b51-4821-929e-08dcb7d8a83f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|52116014|7416014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ljTw4fek0YiKThM02yRvlu+OTVvwBSWQyPHsXATUsNjn1zHABDYKi/vI6GVe?=
 =?us-ascii?Q?3meNuOjNhiDC7t5mGYBTkJlWKQW5z1aGR01d1FISnXFfTAvoh6Tlpf4ItUHH?=
 =?us-ascii?Q?JkS6r+DM6O20zBDBCjLsY7wFgH8fAzgQn39CTmGBPGt+C2NR2Sg+bpvZMr9O?=
 =?us-ascii?Q?Cr2bv5BQ0TWit0FEbTIiS+tHbzXRYtSmaBoaBsU7CLA0V5jNQO2GB/iZ6HfM?=
 =?us-ascii?Q?EyMUGR55PRk0gl2aQMbAjs8vtj100zWPagqZwAPU4ZzeOPYKfTGnJqtttPwm?=
 =?us-ascii?Q?n6gOSmE9FOZ9MdU+VfaBvQiibYFko6/RtWiOGDHtqBgf3xVq9F4/vsqo3zJj?=
 =?us-ascii?Q?R95mzxoWh/HOhVDLGRgCHnPb3jbdw2jTlR+dzkrrPRuB9FdUTDfSw0BhT0TE?=
 =?us-ascii?Q?NmWh5D4ifMPRi+wwxIwfk9b1VWr6tZWZd9TEfilgCvlTq3/bcmTzMzzDZLOR?=
 =?us-ascii?Q?Vj50oP3ZRpyvAQE85NR5Gm9WGTguSMbgy/zJVMS7ywK/nT+q9StIifkaQcdX?=
 =?us-ascii?Q?55+aU0kUNN1N+sbtORgUUrMQKwIaqifNGd0+favZIxjSZH/fFiAQ0MwTxbRL?=
 =?us-ascii?Q?F96YX5JKlw+QDwRURMW6xyXEyrfmurPbJPRvfzVIMrnqNHjEgkeWpQ3OCBPM?=
 =?us-ascii?Q?snm3mZwNoHl3TDWFikdFCQLIDa5ieN13wVPiVzWwEsDUcGdQ4HAO9hVPtXmz?=
 =?us-ascii?Q?yeLABsQOejFfqml4RlbTdFUUdR8V9OKSqVRCpjFKidSOg84m8XTqtvy4vOxM?=
 =?us-ascii?Q?s3Ap61Qm8CqnQ5bPa8nANrWqL5O9xCryQStISybw48KpPHgRYHf1HM//XD8h?=
 =?us-ascii?Q?NIc6VxcFcWZN6RC+SUdmWuj1oFf8J/sB97Os2YCy0TfeSbg7eJbUwMnue4EC?=
 =?us-ascii?Q?e2D50ArT7I66WtmI04cUTB7Jbq9h8agY9KCgelxxPG5A5rT8a3Z8punJyCrM?=
 =?us-ascii?Q?Q24Qq8Ec3kUMwmzuD/zBnQxs+yAvQ+LQJwszQdcPGM7ZH+25hIwFLYRvNANo?=
 =?us-ascii?Q?6qb3Y/V4bwJAEQrOp2aqIMSQWl+CbyR5SNw0YOYsM0HW9KsLZrcCpWJXbT+y?=
 =?us-ascii?Q?LoSuRDXes2GwrLWln8c8XIsJtK8uXKxSIxYJ5bb5VjXfQeZLZ5iUtsJfxuL0?=
 =?us-ascii?Q?kgU0qgH+luCvOf9gDKDMNqgXqc4hdbtc1HSPoCHkQ6MYEf8gJKwR+MmWI5ZJ?=
 =?us-ascii?Q?4BRai+AXQ83p2QAIw7H2HXIXwdUKwmGe8sldhZ65gcLp2GBcbq8jaG0N7cf1?=
 =?us-ascii?Q?8vTeT1bpYpM17YSBNzGywDi5bHglaqKFYQRTc/385MaKkowYfiQzWRYTeTqB?=
 =?us-ascii?Q?pKfrL75lq3ZKPl5+R2RQmWHJt0LfcpTlkJuhfyWR2LWzVoFutOjTqGEszZZT?=
 =?us-ascii?Q?oxu08UI=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR19MB6828.namprd19.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(52116014)(7416014)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?IfrUkY+Y/+ZnKAXpgWCkpPSuEnaEUuiOD3MGAbZLeVp3jkFf4xfTSbDLPLoK?=
 =?us-ascii?Q?qFIET+2AU/A4QTjfOE7uJzk3mlhgbielDAnH56v7Afq0Kg3XBnLw0B5zlu/d?=
 =?us-ascii?Q?0PTZw7qGIN56NKqaQvLX3j/fCm+ZfHQWkfgfYNCXyNrEKZwmVU3pMK1WzoUs?=
 =?us-ascii?Q?o7ga0xtJrJMDkUXuOzmou1yxocJ6LeSXfV6Rkmukvl2LztpDrQvSx123Zjtp?=
 =?us-ascii?Q?lgVeixqUCVbAJa3EAlt3MhbJ6FkYVgR8ZnCEC1sR+RY/2sEJ0fQqNwMP/6op?=
 =?us-ascii?Q?oSPXJolqOwFJC46eAtyQ5HddIot7OO4Gj/J0S+u1j3rVgqcoZwb9Z3C5BCB1?=
 =?us-ascii?Q?9GrG+9Z5tNeE2FXAAl12+qNx8NWyE4kTv/YBdcra3ZsGDZap3+NrhLjMz1To?=
 =?us-ascii?Q?tAmBLaXLgn+kxQN9PTYTkv5eFdgDVvTRt1zBu26U5cdN1/2w+xKkbyEg4H7W?=
 =?us-ascii?Q?76qV5Q/fOnOU5HF2BPsa3Wf9LljJNgCZntmhLeJOqjTpsPyeJQSeD0ZMSFwm?=
 =?us-ascii?Q?7dgx0pprjmFs2ZxWYVAYbDwbDO/JTizZT7s8i0ufUziOn2U9+d3i1xkVyMUp?=
 =?us-ascii?Q?XkurkKEWFINBujpCQhq8FAQZ3wpnbRrxPnchEomuyM6HipRvtz5cAeXmt5+N?=
 =?us-ascii?Q?XByp3NXn4rl+aPSe38c7SnGGZ6tcjewDLHzFD+W7X5NU88yhQFz5RASD7M5P?=
 =?us-ascii?Q?G40fIqzfCjGevG3m4rmC0YHGiPwTJdh/TdGwpVZpqbv0TKZ2ZoADwkOY9jb0?=
 =?us-ascii?Q?zzlK0N39Q0yuaHkS/QEAzzv3Ih9r4BoKQrPkpKl/JIJZ6ywtGc6bdKWq2hfr?=
 =?us-ascii?Q?UgOE97G2p0SCmHUq35+Pfg1yBnpagYHq0gqsjThKBYGKWz7aJU16Ek4lvDQ9?=
 =?us-ascii?Q?ynq95DU7GfNGnB8ePhMmPjQclRCXl0mJbbh1jRiqh5x0DWyVY3X/3TkpbLjM?=
 =?us-ascii?Q?rA9GZ43Lxuaqsf7G2RSWLepIa9nJn5yZuKKnDNb+NK9TMetiubPAzNW3UMlN?=
 =?us-ascii?Q?bfYN2aIVzCmC+gLZ6LOddVfW0NGTDiqttWxIAPATAlHDZvu/hGtFuaFV0VXY?=
 =?us-ascii?Q?I+WUYHUWLQyFNChP0cIDIn87PLhRrfBNjCm88sz5KQ6HG/tCbg9KbM61mVh7?=
 =?us-ascii?Q?A01mTXdttybKjZi8XlxBr6/ty2nfdkjeBci2kInARs/4khF3PLvJ78hNAJVQ?=
 =?us-ascii?Q?JUxEeolPLea1PBmZ0OBMM6ZyltuECBYOcUN9dP73JL1VRFlzAFjuPEylX9Sm?=
 =?us-ascii?Q?ySnpfajHYRlOD7BZS/jJFMeKJ8ZDRRjyDFrHcop3WQgElyDXEFJmP0Joe2nB?=
 =?us-ascii?Q?QIAGCc0lfv5vcVjww01PHRDOJHzZjIASHIYgr1cjHWUQq7KHMsJlPYXxzmxm?=
 =?us-ascii?Q?aYUll8KhUizjtO/I4CTV4w62sboOyZtcpQENHg+1EEWCCUBT03o9aU5xGb5B?=
 =?us-ascii?Q?B1AXEtZmt1jw4KZyB1y/u38SKOI2ZfPSkp4fmGbnBXD8lV1drNXKF1WDLa2N?=
 =?us-ascii?Q?RUXJ9ldVnpgh94cltrgBwzKbtU2N9v08N2qBb7ucQ3shvk8hut7DAVzEElYD?=
 =?us-ascii?Q?XS0BZ9aXH4820rs5fLdWSKr3vg0qFVYMCqvB1TU3/J2drgfs5ptSX5suhL2t?=
 =?us-ascii?Q?j1vRwvH9u3e2rb5jWKJ4488=3D?=
X-OriginatorOrg: eideticom.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f15b87d-7b51-4821-929e-08dcb7d8a83f
X-MS-Exchange-CrossTenant-AuthSource: PH7PR19MB6828.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2024 18:33:54.4761
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3490cd4b-0360-4377-abb1-15f8c5af8fc2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 75Bc8jM1rxkkdoKhWtPCyhLbSgyZ4DaAz06MBYv8sb/txD4peWOctwkdjxgOJ3509TXhJXCFcnsA0UsZ391Z+7/qPcMMGEWcuxJ6XyIV1Y8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR19MB6348

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
index 54d0dc3831fb..df267b7890aa 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -2547,11 +2547,6 @@ static bool is_valid_gup_args(struct page **pages, int *locked,
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
2.43.0


