Return-Path: <linux-rdma+bounces-3068-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9787F904392
	for <lists+linux-rdma@lfdr.de>; Tue, 11 Jun 2024 20:29:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 42DF7286F03
	for <lists+linux-rdma@lfdr.de>; Tue, 11 Jun 2024 18:29:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3C8115278E;
	Tue, 11 Jun 2024 18:28:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=eideticcom.onmicrosoft.com header.i=@eideticcom.onmicrosoft.com header.b="UvvugJeH"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2103.outbound.protection.outlook.com [40.107.94.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37910152189;
	Tue, 11 Jun 2024 18:28:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.103
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718130489; cv=fail; b=j12z+ty1FwDEn0iiuhAT5KcgV9NBBfo78T5svmVuCsSHC3UW1RgHR+hN/QHf3kqQjR6ggPslyPMtGd1fWwfi5jcv9nz/Reoyk6ftnCC4+pqDGL3tLzIWIMM4y22CShrjGytV7e8D+OQBFhnesc81lMSYUg1hYOysvCcLPOSqAgI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718130489; c=relaxed/simple;
	bh=ZFVugkXFJ6vMuDHbM6Ljoc5XOaMzE1P5XxN3vTBByrY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=H9ygkWMjboVc2EAR8NMFs4qfx5jJ1yo67FapitpvDHzvAHb+CTVFRXAm3TD8spbaFrgvlaHjACzfOzVWmbB1ZLb8tMbA9PYTQhm7widQMfSuvK1nyVUpqbHwTgPStm3aSbrHgak8TTZvNCslCE5eO22yog8Ghdzj51/mNLWhbUE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=eideticom.com; spf=pass smtp.mailfrom=eideticom.com; dkim=pass (1024-bit key) header.d=eideticcom.onmicrosoft.com header.i=@eideticcom.onmicrosoft.com header.b=UvvugJeH; arc=fail smtp.client-ip=40.107.94.103
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=eideticom.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=eideticom.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aDPsNzeJ2WK8Hgzp6FUdQpyEFnEkm36h+P5mRktLWOukdOjnI+RBOBsPS24O8/rXvxQdv1botIquVf66dBCVJDQC7GfrjbZsEeuhtXxwe911jPh01Qf+gKRMVIe0b9E5Q6j7JVhgrlaHlGiCGQ0r7mJQ1Jp76c0ZZl6ogtx9hPEdYWqpE/acpPCCRdnM+S5T3bW01SGjHJe7yEltrKTaDM9hdwAnoqWydYnsDVocbZ8vjZNuG60DlYdeeKjPe+LZo88h1Ve/0KohIB5owEQmVqrKFXuUuApZ+b5p1Yhq/WQ7i0GU0wcUHEECpLyxezTREVatnny3OgHm9CxhSe22VA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zF/PKkFIEpEBi0OtXGW3K1kbUiVKvbhfvU9Blf9kNxE=;
 b=CG7O+Wa2N/dE61NiefZtTjXxJWmghTgutsbPIkT+OGLVsN2PuNagfBi529MYfv/uZ5TPzHovqBVYlPqrOwqkNImylG9vPyfLvFF9/DQ8XNXFX0guaXVkQ0r9DUHL2EBfIEAnWR0mpypxNZS0KVmygMIkRkp3pz6B+zGuFaKq5rvQIKv+qk1fUAR6aZdS+UeZDBrB1bGGtBfKiaBT5Mf7wPfURnsL/wFnKM/6lBHDdmd1cY2J/vQ2X0LCIU9SqkaNJmq6yWFvXq6jK2NxkS/uELYyxkX2SczCbobfVH0wj4nmHjvZ0A5/HlZgpZgWa9+jKdMQGwpRXBXN52YGcRJ9Nw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=eideticom.com; dmarc=pass action=none
 header.from=eideticom.com; dkim=pass header.d=eideticom.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=eideticcom.onmicrosoft.com; s=selector2-eideticcom-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zF/PKkFIEpEBi0OtXGW3K1kbUiVKvbhfvU9Blf9kNxE=;
 b=UvvugJeHYLU2LstTZQezAwC/fTVyLQ67WvHpZ4rhQpqZxDMsAqlUDVkgnXOplncOHYCW/zFTHWRtovvJ9IOANevGD6tHQ1F2gUlzG/V7qAD255sD5BgGAUwk9pPAIgDdQlRcraHAVasK9noWzG45SEH8ALRGh7MEpsXB+CwmgyI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=eideticom.com;
Received: from MW3PR19MB4250.namprd19.prod.outlook.com (2603:10b6:303:46::16)
 by BL1PR19MB6105.namprd19.prod.outlook.com (2603:10b6:208:39c::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.37; Tue, 11 Jun
 2024 18:28:00 +0000
Received: from MW3PR19MB4250.namprd19.prod.outlook.com
 ([fe80::3280:d8d:de43:6376]) by MW3PR19MB4250.namprd19.prod.outlook.com
 ([fe80::3280:d8d:de43:6376%6]) with mapi id 15.20.7633.037; Tue, 11 Jun 2024
 18:28:00 +0000
From: Martin Oliveira <martin.oliveira@eideticom.com>
To: linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Cc: Jason Gunthorpe <jgg@ziepe.ca>,
	Leon Romanovsky <leon@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Tejun Heo <tj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Logan Gunthorpe <logang@deltatee.com>,
	Martin Oliveira <martin.oliveira@eideticom.com>,
	Mike Marciniszyn <mike.marciniszyn@intel.com>,
	Shiraz Saleem <shiraz.saleem@intel.com>,
	Michael Guralnik <michaelgur@nvidia.com>,
	Artemy Kovalyov <artemyko@nvidia.com>
Subject: [PATCH v2 3/4] mm/gup: allow FOLL_LONGTERM & FOLL_PCI_P2PDMA
Date: Tue, 11 Jun 2024 12:27:31 -0600
Message-ID: <20240611182732.360317-4-martin.oliveira@eideticom.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240611182732.360317-1-martin.oliveira@eideticom.com>
References: <20240611182732.360317-1-martin.oliveira@eideticom.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW4PR04CA0113.namprd04.prod.outlook.com
 (2603:10b6:303:83::28) To MW3PR19MB4250.namprd19.prod.outlook.com
 (2603:10b6:303:46::16)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR19MB4250:EE_|BL1PR19MB6105:EE_
X-MS-Office365-Filtering-Correlation-Id: b11f0199-e03d-49db-795c-08dc8a443989
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230032|52116006|376006|7416006|366008|1800799016|38350700006;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Jm07reK7DZau3aajiTfA1ptGEq1+spLddj5HxUbys/JyDmNotM0uwQqqOgAt?=
 =?us-ascii?Q?yADVwi6p/BkFrmJcM5PHVp+qZBL1Qrivq3nFFF2Foegz7uX0+4u2OBJGHqd3?=
 =?us-ascii?Q?rWS1Jpkc8aJ6c9kX5B0UIYpOS7rXszASXHnWbKp1kAOgBLk9F6uKRRXFoNai?=
 =?us-ascii?Q?ANLsyIy/RikR8HH7HB7sp/nmxTtrnff5R5sdHXzvjRn9trnNdSRK8lxZFsqn?=
 =?us-ascii?Q?YY5i41cty9zNXgMqPmDvqhjxrs3HwHmYf1hNhwOCEadqXjYmlAzebRRkL/aj?=
 =?us-ascii?Q?Ovwifjau1SNaUj/Tywk9iazgBsC2/LJhzqilOpYfFXYfZ/xRVxkHatD0m5cb?=
 =?us-ascii?Q?wGC16QTaiuPKeLWF3syTNvliFkErObAkD/rjnAOTK0ZVZE1BXKGbQEEPGp8K?=
 =?us-ascii?Q?3vFjfDroeLJP3dfbd21PEQPUUB7uTjHRB2QE7pknoZfLHqPN9AztQ/zlUhJc?=
 =?us-ascii?Q?Y2p2LL52bhxrpDV468eihQdUhPNAhZOXfuGIMm1/1cgo861CvnGHAtUfYURQ?=
 =?us-ascii?Q?NgEZzIWJ6782+PgwKS0gaA9JIID2uvAJ9oD7MSt7jbBPE+Qnrp764XmgrfKN?=
 =?us-ascii?Q?gAmzSeO+Qlx9m/0fafW0Y3gC9RXr9tOmIRqzzdYaI0ETvnFyTVSrlhs/+5HZ?=
 =?us-ascii?Q?/VDZG2Pl3PQ9y0tbo+wye0KPEUfXnx+WK/v6usZn6v3hv9Ml0CT3UVn6VRsl?=
 =?us-ascii?Q?4q/db6VCO8YqctQFofN5Avh7ych2S2SPIrFUJSDM3NihZprxhRDCQh/e6SJ5?=
 =?us-ascii?Q?wnaA5vrc26bhwQDqaLgow14a8FKIkdEgsAeVrSy6F1sMKaID6ZVv812ly7AQ?=
 =?us-ascii?Q?gpw8kT+wrBJZ1iXGkVIT074IPLgylItmOtQ1NHOHZvr1mnDwV7ZChGx73pWw?=
 =?us-ascii?Q?hrom6+vbpz4snS5HFGOka9xzPQP0RsUsORm3HYGNlrOgGKHDRQJCC61kE6jw?=
 =?us-ascii?Q?FS9lbyl3HGdaFLsmDG1fzNIjCzzy5ZZWgYfmKuDmZP7BV9gJwJ9zckgvvvRJ?=
 =?us-ascii?Q?LOGlLY6uDp7vLaujw21yd6+qwDVAkKXMrOqgXLig1Zw4rGTtcCqbOuDOZshr?=
 =?us-ascii?Q?fJfPYIM1Gnwo6zY7PQjgPwr1iP+0/uvEpWIy5lcIDrQfSXQqjZNflaDi2yET?=
 =?us-ascii?Q?VWovcZcfMf+/yHj9zhSADKZe9e+pe5sE883NDICQ8AsOHxrjGZJXKolKGnBI?=
 =?us-ascii?Q?cVXjuy4pqtMxwQUzvL7fqXFHc+jSRp74b+Ca3fz4FHrQPkgKFsFzIUbqQM3r?=
 =?us-ascii?Q?qr7iilQluM3EpsB3WrQYZ/nYQWCwbthHQQnJUahXil2ertJbfaWLLSw+yVlv?=
 =?us-ascii?Q?YiJWKSUGtqBXzCZ3WzjbPNGx+XpgLj75BaHBvHywAdQPPoYCs6cL9nyTYLPI?=
 =?us-ascii?Q?nA9zghU=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR19MB4250.namprd19.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230032)(52116006)(376006)(7416006)(366008)(1800799016)(38350700006);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?e7pxCw0br0O09d/cMsORV34IFbPwK6UAPoCGnmdDD2mtZ2c8X0pAhRytykLY?=
 =?us-ascii?Q?XYDZModGkc5U+9gL/H6+E3eb9VVLJfFUd1lxCLi4PVu45vJAUb2mksRNu61T?=
 =?us-ascii?Q?atyW/77ImJWNiqEgCEbAElF14Vihyvc/Z7h0g5MEjx1zxzJvI9fb5n6ilTim?=
 =?us-ascii?Q?V6R+jLceaG/74SP5ShKE5p5VVc6KqMIdt75rKFdTn1zF9sWWgt5eyAFF19QO?=
 =?us-ascii?Q?vKPYKfwLvJuCkj5S0T7tXvbl7f+o2cmNThoDy3+LzZolMQpnfN40H7RKWqGx?=
 =?us-ascii?Q?W62+u6Qj8MG5HV8wM7+wd8VKtpknvilZKr3qGh6QZX/1kagIYudm74Tw8qct?=
 =?us-ascii?Q?L1DD+kql0cY3eIEYNi45pq4eF/NzDonGwchOTAwjgRR56GpN/Y8wgXP70G4U?=
 =?us-ascii?Q?CMQrCp2AMEssY4q2UTJ7tdZcvhfZrf+TASQkWVCZutOzv+knlaJYLCdN9VcB?=
 =?us-ascii?Q?7wk/L63CCVgYmNcBKJqCj3W73xu9DDn5aZ59IGfq/Rke7lDhRX0aDksiZyfl?=
 =?us-ascii?Q?Ar2LMjOquiblqBwZBsWLRCwoETrjZ9vA2zU5g0swcqp87zn+iFhP8MVT2Hd1?=
 =?us-ascii?Q?BhXrwGfZG5YvJ4B/2wFlZSqaimwP/NAq+sE6xECUoq8T2eeQCVo2P1Fa/HRU?=
 =?us-ascii?Q?Q79dW7JdeWDnefl1MWGjHViYMaG2JvJKjeO+t1bLZYuqwxLrtJ1P537Dya0/?=
 =?us-ascii?Q?PBsTaccEQBy/PDc3ek51dyhh4qr39vH2GUXO4qY9rDy1cr6vfgoYB2SQCOa8?=
 =?us-ascii?Q?ek04rK/BsGZ0AmtG7X1p5llE0SrPNp3/PesxVEDEzmhtVHvbuftdMvOZxBnA?=
 =?us-ascii?Q?A1uR5qCOwGKhT0iu5iifZOdQmWGIyD2Oob9szxhgC4pjt7lIeTS+1zENAs/9?=
 =?us-ascii?Q?FqqvQ+IKiLZuLWYNLW8VUD/5en7Bjb6CTTotG6QSAUHWujTlTZ/DuzWdgszz?=
 =?us-ascii?Q?hjyvYlQE7FkX41OEQQYqtW02BGYcLq5JBPCwFtUwPmQktzBp4HrUYuEP486a?=
 =?us-ascii?Q?yqtKIMhAZ65LCcAWPmLbGe9qmmrUuKHm4qFWfSdTYlFnxYiJGD8xYgdeWF0j?=
 =?us-ascii?Q?5u+3lTya3tECX3tOJYrDp8qlm5pSmAy3I5YWAYLeup6sWS8MPN5gW+z2nmSf?=
 =?us-ascii?Q?zZ8VOsLjkyhZF5O9tayvXL7ABDEbeT7lmIsdsvBgbon+hzSd3AmrfIaTygBG?=
 =?us-ascii?Q?VJMhabdIThczd2cQQV+PLTCIWZ22VmXmMd8T0mfk1Cu1UsC77lqDNfysUY/I?=
 =?us-ascii?Q?Pv8gRxxzYkXCyxBtaXyleNhuApizpedhVPae7hgNupLJ+XCRJ+U6RKKD46Bo?=
 =?us-ascii?Q?mayZXnbfxzwclHQeN4L+hPD80rCCDIY2r3ZbqjvwlPXQtIwdPp0sQy1yxAuw?=
 =?us-ascii?Q?sZkjvpPBwzt7biDGoWzY1+ZHmPI+1iL6y2C3jcBoRpOrDgnZdEwKfrs76lBC?=
 =?us-ascii?Q?guQRgRYY8rnGzmsnD5Q5VF0ASs3hJkhpJiyA+DVYD74QBALXiwT6SXrXufJQ?=
 =?us-ascii?Q?4EUL7TnEgq39d8poqYztVZw+ecKthodOr6ygUUqg/t74w9sb0J5IINCS+1BY?=
 =?us-ascii?Q?b56E2/w18NCtB8zh3OBu960t2kZHCdTcOgPljAiC33kJlDAfaIbe87MRnPRO?=
 =?us-ascii?Q?6Vcucf6CgnZQath6KxJY/7M=3D?=
X-OriginatorOrg: eideticom.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b11f0199-e03d-49db-795c-08dc8a443989
X-MS-Exchange-CrossTenant-AuthSource: MW3PR19MB4250.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2024 18:28:00.8665
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3490cd4b-0360-4377-abb1-15f8c5af8fc2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: v7F/UZ/nD4KIBmuJSzxA0TBQ4H8LNiL1N9KMB+uORylsg68kMyuG2DlTJPvBZwHJNtE5QOWaAWxuUa7eLvi4rUQBjqEWyvAp/93gKRYZZ7M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR19MB6105

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
index 00d0a77112f4f..28060e41788d0 100644
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
2.43.0


