Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 588AD3CF5F3
	for <lists+linux-rdma@lfdr.de>; Tue, 20 Jul 2021 10:18:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233097AbhGTHhD (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 20 Jul 2021 03:37:03 -0400
Received: from mail-dm6nam08on2077.outbound.protection.outlook.com ([40.107.102.77]:21281
        "EHLO NAM04-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S234146AbhGTHg7 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 20 Jul 2021 03:36:59 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ID3xNyGlng7SGrleW8iSb6Qyqf2DWyhX2k6BAdPMAgqI4cnUFoLD6Vd5NH2AI8K3/2gpYAaoQ6fNACbZUfbIaeqoneWKE8bDCEmMLQyFnd7AMnbXEIpiJfKfVvq55U55jOKF0tIHPxcV5TzdGHG+I7EDigwW7neuiyXGfdSJOHLMGjY0+Dl7jaJraQwo+iOaFn2QTxEirqExWderBU1W7qjGaXk82lZ7GjLygn8XcrRyYqcapGoR0jOy0QX1GckEpgyiqaHm8MMIFdCJ5uZV3Y4GqpIM/lyXW0oEcc2tzBFlbKV43uoPXvlVb8RVrvey4hBFWGnWUuyDuaK+dRD3tA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=torjwXvLlo0C0wTjN2BakYxmcPmVdy4OMzAQyCmXY3w=;
 b=iTUkZIaIUXkMikxc1CLzGk4UrgWp5RX/unGbXz/GqZfj6jWBgPM8tDByRKT9au4Ml0zS3f2CKeWw9d9UMFWVUHyOmY0KpyM2m074ZfbpoRIUfwTp9colLe3Ms+ogfXqITkfyDAzSUIBGXur+FgH4k5BgDOTLSupolnmaiNaJ79HPwM4nteygf2t5X2qi/YZr50lC3Jic8EPxtOV6JKi3+wm0+4Fkf2zhyKZj2Q8iOtppt7+15KJkJ7BIxx0HuVdObEC1Wji1JANvG68l+x2FTdo2F+mXdjSdeqD9lOq5W6AEVYlkfFmWGWqPfUADAUy/mB1hQvOFSKnumI42Qio1mw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.32) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=torjwXvLlo0C0wTjN2BakYxmcPmVdy4OMzAQyCmXY3w=;
 b=Pfgneke1/+y1OI+I/PRZ77GLUbWt24yfuI0XcvBD2cdpTof+CQKbgHGogggn8PppWM+GEs40VT8X+CAL4IHYqbHFUO7fc4DVzN6JapLHSDMdq0PE9En8fUd9R4zsvbfYqpJYbSWXIaWkEd7AdlhMP/qODPmHQLlsmdmcsUNeyIfok9u71qGJ/PIlhGsOFKB+9y/QasBxML1N3z9P2VSv7tGlBULcPVu3kC0IF5LQkm6qqOWPPa+btIL8aBanrGnUdb8JQFhRzPNgkJY0odBIl19HP58T3JBbi+F6RAUpoJ9Y8N420yL4dONuvnPVjO6pmqrxs9Q1DC/SA7tyHOW09w==
Received: from BN9PR03CA0744.namprd03.prod.outlook.com (2603:10b6:408:110::29)
 by BL1PR12MB5377.namprd12.prod.outlook.com (2603:10b6:208:31f::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.32; Tue, 20 Jul
 2021 08:17:36 +0000
Received: from BN8NAM11FT045.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:110:cafe::85) by BN9PR03CA0744.outlook.office365.com
 (2603:10b6:408:110::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.22 via Frontend
 Transport; Tue, 20 Jul 2021 08:17:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.32)
 smtp.mailfrom=nvidia.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.32 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.32; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.32) by
 BN8NAM11FT045.mail.protection.outlook.com (10.13.177.47) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4331.21 via Frontend Transport; Tue, 20 Jul 2021 08:17:36 +0000
Received: from HQMAIL109.nvidia.com (172.20.187.15) by HQMAIL109.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Tue, 20 Jul
 2021 01:17:36 -0700
Received: from vdi.nvidia.com (172.20.187.5) by mail.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 20 Jul 2021 01:17:34 -0700
From:   Yishai Hadas <yishaih@nvidia.com>
To:     <linux-rdma@vger.kernel.org>
CC:     <jgg@nvidia.com>, <yishaih@nvidia.com>, <maorg@nvidia.com>,
        <markzhang@nvidia.com>, <edwards@nvidia.com>
Subject: [PATCH rdma-core 04/27] util: Add interval_set support
Date:   Tue, 20 Jul 2021 11:16:24 +0300
Message-ID: <20210720081647.1980-5-yishaih@nvidia.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20210720081647.1980-1-yishaih@nvidia.com>
References: <20210720081647.1980-1-yishaih@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 43cd58a2-185d-4553-8d9b-08d94b56d532
X-MS-TrafficTypeDiagnostic: BL1PR12MB5377:
X-Microsoft-Antispam-PRVS: <BL1PR12MB5377ABA1853165C5BF007F66C3E29@BL1PR12MB5377.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2331;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sX3TS0zRHbWkrS13YY+d77qe15w70xnrLuT7E32flpHaMSd1G/0iWTOElfOfdZpDx3WZM7FHy4eTk7fZV+ivgoPE2He4wZXL/QMGZAHc72sE2PTcqiCkvmboaR3seNvNwQxrYtrUKLac2fPoXYK/x89sbX9IGP+uVrVZo43uy2OOUcA82IUaFtT/NcpqO0tbrIb0eHeW/s7M13lpcancGqTDX94kmRLArXj9etIWd2c3Mo0aAvFKAVuTm6tIQpaEgYUKjIJfwv6QEi7P8qEwHXHMzqmrC56HEySjgy3p21OHSDX18xL01VCH6U8V0NbX8R3WyVxDa/Feyv/fav9Dz3VGBQgGOBsyrqLnvFEvC+n4/Z9CdTVPJbmOYI1i6zVOPKKoaB1XamDJaAeUIp+oREsaz9wiyJU14bFdgawBVRKw7NZX5Sr/QTAOwDQ77k2N8I+GdG6KPybmMeVYlIex01z+WNV5hc9ypEjCJpVE4LmDTMA5Vof2iWReQyOieRLxF5eHINfKXYpkBy2yz/V6p3cBzySGx3x71GXTHo57qu+XDZgHh5ek51jSOQzziuvNKvKNPZ+ftOTiUQ2KsdwFvF228svC8GFzhwvOyKHmfpZRlgGHJ9wirhUpcxZC12TgPitqKjLoFnQ3qzx0Fkl5mWEDKEI4AbkPorW7dbcwvj11tXAbIZeoM6OVFSfyVRpivuOnb/t5T4O+yEakObX8VA==
X-Forefront-Antispam-Report: CIP:216.228.112.32;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid01.nvidia.com;CAT:NONE;SFS:(4636009)(346002)(376002)(39860400002)(396003)(136003)(46966006)(36840700001)(82740400003)(2616005)(5660300002)(7636003)(186003)(36756003)(70206006)(8676002)(54906003)(26005)(316002)(6916009)(83380400001)(1076003)(426003)(36860700001)(86362001)(356005)(70586007)(82310400003)(107886003)(336012)(478600001)(8936002)(2906002)(6666004)(47076005)(7696005)(4326008);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jul 2021 08:17:36.4147
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 43cd58a2-185d-4553-8d9b-08d94b56d532
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.32];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT045.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5377
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Mark Zhang <markzhang@nvidia.com>

Add interval_set functionality to support range management.

This functionality enables to insert/get valid ranges of values and
maintains the contiguity of them internally.

This will be used in down stream patches from this series to set/get
valid iova ranges from this data structure.

Signed-off-by: Mark Zhang <markzhang@nvidia.com>
Signed-off-by: Yishai Hadas <yishaih@nvidia.com>
---
 util/CMakeLists.txt |   2 +
 util/interval_set.c | 208 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 util/interval_set.h |  77 +++++++++++++++++++
 3 files changed, 287 insertions(+)
 create mode 100644 util/interval_set.c
 create mode 100644 util/interval_set.h

diff --git a/util/CMakeLists.txt b/util/CMakeLists.txt
index e8646bf..d8a66be 100644
--- a/util/CMakeLists.txt
+++ b/util/CMakeLists.txt
@@ -1,6 +1,7 @@
 publish_internal_headers(util
   cl_qmap.h
   compiler.h
+  interval_set.h
   node_name_map.h
   rdma_nl.h
   symver.h
@@ -9,6 +10,7 @@ publish_internal_headers(util
 
 set(C_FILES
   cl_map.c
+  interval_set.c
   node_name_map.c
   open_cdev.c
   rdma_nl.c
diff --git a/util/interval_set.c b/util/interval_set.c
new file mode 100644
index 0000000..9fb9bde
--- /dev/null
+++ b/util/interval_set.c
@@ -0,0 +1,208 @@
+/* GPLv2 or OpenIB.org BSD (MIT) See COPYING file */
+
+#include <errno.h>
+#include <pthread.h>
+#include <stdlib.h>
+
+#include <ccan/list.h>
+#include <util/interval_set.h>
+#include <util/util.h>
+
+struct iset {
+	struct list_head head;
+	pthread_mutex_t lock;
+};
+
+struct iset_range {
+	struct list_node entry;
+	uint64_t start;
+	uint64_t length;
+};
+
+struct iset *iset_create(void)
+{
+	struct iset *iset;
+
+	iset = calloc(1, sizeof(*iset));
+	if (!iset) {
+		errno = ENOMEM;
+		return NULL;
+	}
+
+	pthread_mutex_init(&iset->lock, NULL);
+	list_head_init(&iset->head);
+	return iset;
+}
+
+void iset_destroy(struct iset *iset)
+{
+	struct iset_range *range, *tmp;
+
+	list_for_each_safe(&iset->head, range, tmp, entry)
+		free(range);
+
+	free(iset);
+}
+
+static int
+range_overlap(uint64_t s1, uint64_t len1, uint64_t s2, uint64_t len2)
+{
+	if (((s1 < s2) && (s1 + len1 - 1 < s2)) ||
+	    ((s1 > s2) && (s1 > s2 + len2 - 1)))
+		return 0;
+
+	return 1;
+}
+
+static struct iset_range *create_range(uint64_t start, uint64_t length)
+{
+	struct iset_range *range;
+
+	range = calloc(1, sizeof(*range));
+	if (!range) {
+		errno = ENOMEM;
+		return NULL;
+	}
+
+	range->start = start;
+	range->length = length;
+	return range;
+}
+
+static void delete_range(struct iset_range *r)
+{
+	list_del(&r->entry);
+	free(r);
+}
+
+static bool check_do_combine(struct iset *iset,
+			     struct iset_range *p, struct iset_range *n,
+			     uint64_t start, uint64_t length)
+{
+	bool combined2prev = false, combined2next = false;
+
+	if (p && (p->start + p->length == start)) {
+		p->length += length;
+		combined2prev = true;
+	}
+
+	if (n && (start + length == n->start)) {
+		if (combined2prev) {
+			p->length += n->length;
+			delete_range(n);
+		} else {
+			n->start = start;
+			n->length += length;
+		}
+		combined2next = true;
+	}
+
+	return combined2prev || combined2next;
+}
+
+int iset_insert_range(struct iset *iset, uint64_t start, uint64_t length)
+{
+	struct iset_range *prev = NULL, *r, *rnew;
+	bool found = false, combined;
+	int ret = 0;
+
+	if (!length || (start + length - 1 < start)) {
+		errno = EINVAL;
+		return errno;
+	}
+
+	pthread_mutex_lock(&iset->lock);
+	list_for_each(&iset->head, r, entry) {
+		if (range_overlap(r->start, r->length, start, length)) {
+			errno = EINVAL;
+			ret = errno;
+			goto out;
+		}
+
+		if (r->start > start) {
+			found = true;
+			break;
+		}
+
+		prev = r;
+	}
+
+	combined = check_do_combine(iset, prev, found ? r : NULL,
+				    start, length);
+	if (!combined) {
+		rnew = create_range(start, length);
+		if (!rnew) {
+			ret = errno;
+			goto out;
+		}
+
+		if (!found)
+			list_add_tail(&iset->head, &rnew->entry);
+		else
+			list_add_before(&iset->head, &r->entry, &rnew->entry);
+	}
+
+out:
+	pthread_mutex_unlock(&iset->lock);
+	return ret;
+}
+
+static int power_of_two(uint64_t x)
+{
+	return ((x != 0) && !(x & (x - 1)));
+}
+
+int iset_alloc_range(struct iset *iset, uint64_t length, uint64_t *start)
+{
+	struct iset_range *r, *rnew;
+	uint64_t astart, rend;
+	bool found = false;
+	int ret = 0;
+
+	if (!power_of_two(length)) {
+		errno = EINVAL;
+		return errno;
+	}
+
+	pthread_mutex_lock(&iset->lock);
+	list_for_each(&iset->head, r, entry) {
+		astart = align(r->start, length);
+		/* Check for wrap around */
+		if ((astart + length - 1 >= astart) &&
+		    (astart + length - 1 <= r->start + r->length - 1)) {
+			found = true;
+			break;
+		}
+	}
+	if (!found) {
+		errno = ENOSPC;
+		ret = errno;
+		goto out;
+	}
+
+	if (r->start == astart) {
+		if (r->length == length) { /* Case #1 */
+			delete_range(r);
+		} else {	/* Case #2 */
+			r->start += length;
+			r->length -= length;
+		}
+	} else {
+		rend = r->start + r->length;
+		if (astart + length != rend) { /* Case #4 */
+			rnew = create_range(astart + length,
+					    rend - astart - length);
+			if (!rnew) {
+				ret = errno;
+				goto out;
+			}
+			list_add_after(&iset->head, &r->entry, &rnew->entry);
+		}
+		r->length = astart - r->start; /* Case #3 & #4 */
+	}
+
+	*start = astart;
+out:
+	pthread_mutex_unlock(&iset->lock);
+	return ret;
+}
diff --git a/util/interval_set.h b/util/interval_set.h
new file mode 100644
index 0000000..d5b1f56
--- /dev/null
+++ b/util/interval_set.h
@@ -0,0 +1,77 @@
+/* GPLv2 or OpenIB.org BSD (MIT) See COPYING file */
+
+#include <stdint.h>
+
+struct iset;
+
+/**
+ * iset_create - Create an interval set
+ *
+ * Return the created iset if succeeded, NULL otherwise, with errno set
+ */
+struct iset *iset_create(void);
+
+/**
+ * iset_destroy - Destroy an interval set
+ * @iset: The set to be destroyed
+ */
+void iset_destroy(struct iset *iset);
+
+/**
+ * iset_insert_range - Insert a range to the set
+ * @iset: The set to be operated
+ * @start: The start address of the range
+ * @length: The length of the range
+ *
+ * If this range is continuous to the adjacent ranges (before and/or after),
+ * then they will be combined to a larger one.
+ *
+ * Return 0 if succeeded, errno otherwise
+ */
+int iset_insert_range(struct iset *iset, uint64_t start, uint64_t length);
+
+/**
+ * iset_alloc_range - Allocate a range from the set
+ *
+ * @iset: The set to be operated
+ * @length: The length of the range, must be power of two
+ * @start: The start address of the allocated range, aligned with @length
+ *
+ * Return 0 if succeeded, errno otherwise
+ *
+ * Note: There are these cases:
+ *
+Case 1: Original range is fully taken
++------------------+
+|XXXXXXXXXXXXXXXXXX|
++------------------+
+=>  (NULL)
+
+Case 2: Original range shrunk
++------------------+
+|XXXXX             |
++------------------+
+=>
+      +------------+
+      |            |
+      +------------+
+
+Case 3: Original range shrunk
++------------------+
+|             XXXXX|
++------------------+
+=>
++------------+
+|            |
++------------+
+
+Case 4: Original range splited
++------------------+
+|      XXXXX       |
++------------------+
+=>
++-----+     +------+
+|     |     |      |
++-----+     +------+
+*/
+int iset_alloc_range(struct iset *iset, uint64_t length, uint64_t *start);
-- 
1.8.3.1

