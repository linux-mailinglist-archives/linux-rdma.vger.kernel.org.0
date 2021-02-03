Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 80C4030E582
	for <lists+linux-rdma@lfdr.de>; Wed,  3 Feb 2021 23:04:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232372AbhBCWC3 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 3 Feb 2021 17:02:29 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:58988 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232875AbhBCWCC (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 3 Feb 2021 17:02:02 -0500
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 113LxaZh136605;
        Wed, 3 Feb 2021 22:01:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : content-type :
 mime-version; s=corp-2020-01-29;
 bh=HnBuEyXtPyPJCNeig1nrZDABBup9AWpTwYMW7sV8nAg=;
 b=EE46T2tgF64r2ehJvLmdhXrGHo+Kp5b8bRfbVckqy84el+Cvd5Ux2uhsNW+dNcvO9WVS
 WfYJcGolTvtvZYUnj7unUX1IVPsBh8rUuREghpF9bXjss4J0NbHytLDrV3vaqOZT32xq
 8TE36oqQe6pI0ogSXhy5XgOSgw4FTlCleO1TUc4fe1HsJWdYAEtpGEc/XEDp+fTPVcYP
 fDDIMG0t7PUhnGRgYqS+OVYJUWXijeRIC+9nCylXnafe7e6YugPXrnpls2vrTL8vaueC
 lrzdbOxGoVSbFiH1rrdf7vN+pZ3jD/Vpeo0ZWPm/t+0GkeT0uwptb9rckGghnbTVMjsW aw== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2130.oracle.com with ESMTP id 36cvyb2mhm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 03 Feb 2021 22:01:13 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 113M157i042797;
        Wed, 3 Feb 2021 22:01:13 GMT
Received: from nam02-bl2-obe.outbound.protection.outlook.com (mail-bl2nam02lp2058.outbound.protection.outlook.com [104.47.38.58])
        by aserp3020.oracle.com with ESMTP id 36dhc1t3e9-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 03 Feb 2021 22:01:12 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DqpxcQpVH5+mKrs68nx3odt7KO8N7nKqGUaUkNOmhUzOWE91ZizwLhdPjXV57guQofCPgVtF+CAdsNiNw8rlsFv3gLN23huG7v9MYP2iiY/8uYwOc/+2HZtgjd/v2MIgfPEUi244cVXED7nVWU9aTu7d1tq7/lrkgc7qyK4f39TEFrc5NsfqGBWSYrF6SpFFm+DZxeb0CrAD96sa9q/N1CoOwJSxBqEj1LKWvQiW3E3Fg2h6hqRCZMa6EHoNjr1hQHKdWcRiPm95XZIVkFHDF9hfSbT3ckZDzr3Y9s7Cod1xlLDW80CRcJE5pPcwY4AMQq4NJtQrsciIddG8KpjQgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HnBuEyXtPyPJCNeig1nrZDABBup9AWpTwYMW7sV8nAg=;
 b=BYSxqA0kQDwu6JXGqOn6wzyhAGpF6suHXm/y64kc0KUpAyKTejBOn07kYeMRVyZP3CeAsF4MzPSl5qgdjXja/C1RUWHif/g20Ynaze1GDhaIAmCxGWnQkHkIHI/y/BMeaN7x2hcYxbEGrbSD60FQ9IGfffOCv6hDhJ9Tq0STFPMMgtITgPqxlqOhga1NSptw+dsuvDxmoBNa5sMwNU8iFetbSiDjw7ya40GIlmN6MdeALKBEeQxk7KB6Bl2xaevHZ+Rq5jMKNat1BRfdr+7CMgyTbDgVKo5gDHPWwHeuhPLkWegw0WLl3Hz2NASKiLZzbsdX9gFpycRwdN41RfeNqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HnBuEyXtPyPJCNeig1nrZDABBup9AWpTwYMW7sV8nAg=;
 b=wPIFWPpKdBt9oDpHiuOJ9XxQKkVFSbWLm3jDtBL2/aUyPuTNe3GxOJk0+avjcAGc9GnywVWEzF8EwUhi4Ia5ZFTFRPM/+espsrqeo+pHvP3pOBoCdt5SpU3JQK4QuXDaZeMCKUMmWn8dhF7tG4WVWqsSEu30x1VYbbMKriASUHU=
Authentication-Results: kvack.org; dkim=none (message not signed)
 header.d=none;kvack.org; dmarc=none action=none header.from=oracle.com;
Received: from BYAPR10MB3077.namprd10.prod.outlook.com (2603:10b6:a03:8c::12)
 by BYAPR10MB3735.namprd10.prod.outlook.com (2603:10b6:a03:11e::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3805.23; Wed, 3 Feb
 2021 22:01:09 +0000
Received: from BYAPR10MB3077.namprd10.prod.outlook.com
 ([fe80::74a8:8649:e20b:d571]) by BYAPR10MB3077.namprd10.prod.outlook.com
 ([fe80::74a8:8649:e20b:d571%7]) with mapi id 15.20.3805.024; Wed, 3 Feb 2021
 22:01:09 +0000
From:   Joao Martins <joao.m.martins@oracle.com>
To:     linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Doug Ledford <dledford@redhat.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Matthew Wilcox <willy@infradead.org>,
        Joao Martins <joao.m.martins@oracle.com>
Subject: [PATCH 4/4] RDMA/umem: batch page unpin in __ib_mem_release()
Date:   Wed,  3 Feb 2021 22:00:25 +0000
Message-Id: <20210203220025.8568-5-joao.m.martins@oracle.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20210203220025.8568-1-joao.m.martins@oracle.com>
References: <20210203220025.8568-1-joao.m.martins@oracle.com>
Content-Type: text/plain
X-Originating-IP: [94.61.1.144]
X-ClientProxiedBy: LO4P123CA0266.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:194::19) To BYAPR10MB3077.namprd10.prod.outlook.com
 (2603:10b6:a03:8c::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from paddy.uk.oracle.com (94.61.1.144) by LO4P123CA0266.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:194::19) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.3825.17 via Frontend Transport; Wed, 3 Feb 2021 22:01:06 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 596c279f-0dae-41a9-2772-08d8c88f3629
X-MS-TrafficTypeDiagnostic: BYAPR10MB3735:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR10MB3735A011899793E76BE72E40BBB49@BYAPR10MB3735.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:370;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Oxhnprz0Iz8p7+RZxD+qjuYQJ5ID34jZAGxd8edMFYhYDrP+frtnGbwEQDvfCtOfyTNesp5grxBHKtcttF5jJZ3drpoeHmIQPOfqagf9MKijQs9WpNME5Fvb38TIZiXeH5qT+w+/vnuPM5HZUwwTf5JcBNXbxJir/lLc3Pm/l0H32MBwgGQahaUPof27RPPpyFOFyPP5tlw+Ib3ULizm/Afr8YtHX08CXs8zw+prM46x9pGmfm5Q7xQJXe8nXwHQfzFmdIl9Lse54MawO5nS8MZRNfq0uApQNecRGQwNOwPorrIBfrdCH14SBqS4gvaVP4S8XkS0OSRDahckZwjd2Lvg1cCVFkHXkiqQLHNrsjB9D+wkjgRi75erqxAOAoldBZNIbRkY6d8MB0S0avTJRyBkB4cB4YEoNCspz1sLyBn4utnhM+zso2FRTJHNhcI6ZtouOULp8N+k3T8pkTzm7dNIIPtlNWh5el5m4f1QSoV+YOBUfYMpal0QOR83wy5y0X8+tAiUs2h2BgoZ5l0QuQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB3077.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(39860400002)(366004)(136003)(346002)(396003)(66556008)(54906003)(6486002)(316002)(186003)(2616005)(956004)(16526019)(107886003)(4326008)(26005)(66476007)(66946007)(1076003)(103116003)(52116002)(7696005)(6666004)(86362001)(83380400001)(36756003)(8676002)(2906002)(478600001)(8936002)(5660300002)(6916009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?sYrS0bvt9OyLa1HA/i7fV3WqIWdD348Pgf9FmXm4WsfR2atpQtcJy+/iT8NL?=
 =?us-ascii?Q?GSUr7aDboI4IxGnGGHbqtRIEut1FnWvdr4hEeYu+cahrBofknzabrxpayONR?=
 =?us-ascii?Q?DUycvg731MSwW8BJenvwxdw7aW3r0x/8Ocu1N6DShAwEjF90M1fWrOP0b3SD?=
 =?us-ascii?Q?mM9Vo6uCAORL27+fC8o9AxkWO3Zz4FxhfdlZxSFRVSnO1jgJOg0sh/Wh3j2w?=
 =?us-ascii?Q?tICU9uc6idNem7kH+fs3rPAxLhuel0UjIFF1HI2evjzDHFN3+efDT+tmGgke?=
 =?us-ascii?Q?p48/TMYlALhEj0ZXStk5nMoOty6GjEsuB7bqLeJjtV9NtHvjayFo1gKJNwFS?=
 =?us-ascii?Q?BdmktPBlgCjMG2eSyOfQjeJPJBpSLNDrClY0LVmaY7UQbB9J43f60QjGTUxY?=
 =?us-ascii?Q?cRhNNqorJc7LfdjJGONYmthsJ0dDYm/WPSE0U+ZXM6uNSrC93yruj/kCDFtl?=
 =?us-ascii?Q?Q07G7eBFlImCPbvBrdqXcJZ7K6WpnqLTqAuR4zBuhRaxC4//jSl3VgXqXD1k?=
 =?us-ascii?Q?9e5ar6QRrZkEYKgK6QvBtUHl3QxtEQJoIIBGI1rDcevyNTTX1gv98UZrDYf4?=
 =?us-ascii?Q?o3erIKx1jODSDZ2DHkUWTKeHiD9qEnm9AUr7LPFOBejPyR4ekebeHxVInyay?=
 =?us-ascii?Q?asRSzRWyE9AR54k+MWmTekj2A146sqy/rCVw0gbVfoDthiTwIp4voyoluJHq?=
 =?us-ascii?Q?XqYxs3QRI/DiLfxoRLF37p3gewBzdMPE7tk/g+wqpIWdUG6dLXrXdqBcFcP6?=
 =?us-ascii?Q?ho8P4ul7AY1fCOws0HgPmd/6iK+k9eVjEb5fjH6duHdhoUfz4Jgr7rLCe72F?=
 =?us-ascii?Q?OoyvCR3JV0vGENB0xRMJcdrHhuvOP2kKFEt7pQGiYuSVR+NdvJfLgGsfoj7w?=
 =?us-ascii?Q?5gd3DY2ZBt2OziyQjIO1OTjB/r/54WzZZJS/B4VyA66WvbfTTriQmqPVZwj6?=
 =?us-ascii?Q?3332ZpKf0dHac/WTU8tkUwfD5LDEI89ili+zjzBfHqE3aqblrWuibkydYk1a?=
 =?us-ascii?Q?3UvAHfSSHmYtbVi1qsdP2IOAPBT2BmwWXc9mljREcVBkXcVBQ7TTqiymFu4i?=
 =?us-ascii?Q?ZWpWeq93?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 596c279f-0dae-41a9-2772-08d8c88f3629
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3077.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2021 22:01:08.9309
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: M95JymCUkBn6cyeU0MajZr3FKVV9dy81Xqm9OlbGsBHihiTPDgr/dgkaSJGgypJmD3Qkd8odngZzzMBGbT5zsErDcsm4ENwYEDlOGoS4kmw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB3735
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9884 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 adultscore=0 suspectscore=0
 spamscore=0 mlxscore=0 malwarescore=0 mlxlogscore=999 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2102030133
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9884 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1015 impostorscore=0
 mlxscore=0 spamscore=0 bulkscore=0 priorityscore=1501 adultscore=0
 lowpriorityscore=0 malwarescore=0 phishscore=0 mlxlogscore=999
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102030133
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Use the newly added unpin_user_page_range_dirty_lock()
for more quickly unpinning a consecutive range of pages
represented as compound pages. This will also calculate
number of pages to unpin (for the tail pages which matching
head page) and thus batch the refcount update.

Running a test program which calls mr reg/unreg on a 1G in size
and measures cost of both operations together (in a guest using rxe)
with THP and hugetlbfs:

Before:
590 rounds in 5.003 sec: 8480.335 usec / round
6898 rounds in 60.001 sec: 8698.367 usec / round

After:
2631 rounds in 5.001 sec: 1900.618 usec / round
31625 rounds in 60.001 sec: 1897.267 usec / round

Signed-off-by: Joao Martins <joao.m.martins@oracle.com>
---
 drivers/infiniband/core/umem.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/infiniband/core/umem.c b/drivers/infiniband/core/umem.c
index 2dde99a9ba07..ea4ebb3261d9 100644
--- a/drivers/infiniband/core/umem.c
+++ b/drivers/infiniband/core/umem.c
@@ -47,17 +47,17 @@
 
 static void __ib_umem_release(struct ib_device *dev, struct ib_umem *umem, int dirty)
 {
-	struct sg_page_iter sg_iter;
-	struct page *page;
+	bool make_dirty = umem->writable && dirty;
+	struct scatterlist *sg;
+	int i;
 
 	if (umem->nmap > 0)
 		ib_dma_unmap_sg(dev, umem->sg_head.sgl, umem->sg_nents,
 				DMA_BIDIRECTIONAL);
 
-	for_each_sg_page(umem->sg_head.sgl, &sg_iter, umem->sg_nents, 0) {
-		page = sg_page_iter_page(&sg_iter);
-		unpin_user_pages_dirty_lock(&page, 1, umem->writable && dirty);
-	}
+	for_each_sg(umem->sg_head.sgl, sg, umem->nmap, i)
+		unpin_user_page_range_dirty_lock(sg_page(sg),
+			DIV_ROUND_UP(sg->length, PAGE_SIZE), make_dirty);
 
 	sg_free_table(&umem->sg_head);
 }
-- 
2.17.1

