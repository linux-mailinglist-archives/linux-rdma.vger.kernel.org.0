Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 64805319F8E
	for <lists+linux-rdma@lfdr.de>; Fri, 12 Feb 2021 14:12:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232132AbhBLNLI (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 12 Feb 2021 08:11:08 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:33736 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232053AbhBLNKK (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 12 Feb 2021 08:10:10 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 11CD8h39019057;
        Fri, 12 Feb 2021 13:09:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : content-type :
 mime-version; s=corp-2020-01-29;
 bh=pblMTxugz0sthwIAXE3b5+P7tukiVSJBSWzcnB9s24o=;
 b=NqKENkFVYalGUvP0sPkhFHX8EzjHBquWqOj/eiVDHCasJqItmsv2ZIZkqZcrLToY8vJg
 d4Ye3K/WnSPtklDaZKUZor/o/RQOKBCj3RiMup8sDcWzsDCYGEOVKv9khg+kWgHMoWAt
 AaxeIS+A3itIXq1JL6rBxOxU7oBSnjkYG3V4pUC9kUQM4ZE3NF+Hdf1HnM3R3xEG7O/+
 ftyzOFGeyH388IPZSH5v/4zR7oEedGCHbuNra9nKX1MoifgOyMd2jfe4kcD2+VStVc4C
 6WMyJ6GT8FbOXbTl6dLEmB1WSei/vgPB0Mrn3yP029aihCqVwEI5/PuhjJhdB8CNdNcb iw== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2130.oracle.com with ESMTP id 36mv9dwadn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 12 Feb 2021 13:09:17 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 11CCopAr195735;
        Fri, 12 Feb 2021 13:09:17 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2175.outbound.protection.outlook.com [104.47.58.175])
        by userp3020.oracle.com with ESMTP id 36j4vvq2mh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 12 Feb 2021 13:09:16 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MO96dI9+qtmsq6PWfO5qY3G3VQH7RFqRGvdBLfmVUlHACixhl6/y5SvbMTr/Zsxw8P8GgTpenrEwC+WwReaQZ7wIgdUNyZS3n8Kh/SpxcuZ3cgnzbfph2wpN86pM80lFKlm6dLnReGFtDDF9iLSec/hoTmFz5ZrlkaBZ8vn4tBpR9Hs2nUDXR8W7wFmMJgxGympiQOpP2oBDUBb2sjELzLRetdgMtjcmf0XNJP9KDCJHoREx0hZimjOmsfH5gVFE+xv8IZI5V/4fIIBaKPuTUBK+YIkNxKAVZZrOk4TICSNgatG/oNESsu9YHURBj6cIazh1C0ajogMY+XqIPw+Law==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pblMTxugz0sthwIAXE3b5+P7tukiVSJBSWzcnB9s24o=;
 b=UJxUHHoCIdhsaDGK9aPdijGwPJckskF7uhsivwjhQ04NpMEAz0hl1SRLXrKrzdF7mirvXwmXiWRQ3e227Q15Bmw6fU3MnQO0xzSCAGxKYDxX0pcuS4TbfGVPJd3eslSemASeeu1gPW0N+aoZ8663BPnBtxjQ1aK7IcfuZ5qbB5DO/gl9RBPMiBxcdfePsbMuyeV6YQ6YTefAl6qyTNo6os/b7OGH+9Gm01O0NO4oeum3QX5z98AeMGqYaQo+IlMltliOd6Z/C85NwwqCtU78KYHBKUvwV+6sK0LvvkciucLdqetPpTSckL2xJ1XP740PyRYOb2dPPhlCDH4+PwseyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pblMTxugz0sthwIAXE3b5+P7tukiVSJBSWzcnB9s24o=;
 b=SJaS5q4Dpwd5n0d4H5xhtwBT2P3wlPfqr7ZFCtZlF/sXqbhog5eqzUgpQcXucI0qRNIv3WhgNi/tgVhvYx25wVJ66SGRneqQT/ZS0lGf0z1781tnMG0vEMRJLvDOJA5zDUEFXokcI4TAR6EWSf+HzKnp0FuyXOpROWTVZ+9jka0=
Authentication-Results: kvack.org; dkim=none (message not signed)
 header.d=none;kvack.org; dmarc=none action=none header.from=oracle.com;
Received: from BYAPR10MB3077.namprd10.prod.outlook.com (2603:10b6:a03:8c::12)
 by SJ0PR10MB4509.namprd10.prod.outlook.com (2603:10b6:a03:2d9::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3825.17; Fri, 12 Feb
 2021 13:09:09 +0000
Received: from BYAPR10MB3077.namprd10.prod.outlook.com
 ([fe80::74a8:8649:e20b:d571]) by BYAPR10MB3077.namprd10.prod.outlook.com
 ([fe80::74a8:8649:e20b:d571%7]) with mapi id 15.20.3846.034; Fri, 12 Feb 2021
 13:09:09 +0000
From:   Joao Martins <joao.m.martins@oracle.com>
To:     linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Doug Ledford <dledford@redhat.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Matthew Wilcox <willy@infradead.org>,
        Joao Martins <joao.m.martins@oracle.com>
Subject: [PATCH v4 3/4] mm/gup: add a range variant of unpin_user_pages_dirty_lock()
Date:   Fri, 12 Feb 2021 13:08:42 +0000
Message-Id: <20210212130843.13865-4-joao.m.martins@oracle.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20210212130843.13865-1-joao.m.martins@oracle.com>
References: <20210212130843.13865-1-joao.m.martins@oracle.com>
Content-Type: text/plain
X-Originating-IP: [94.61.1.144]
X-ClientProxiedBy: LO4P123CA0347.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:18d::10) To BYAPR10MB3077.namprd10.prod.outlook.com
 (2603:10b6:a03:8c::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from paddy.uk.oracle.com (94.61.1.144) by LO4P123CA0347.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:18d::10) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.3825.17 via Frontend Transport; Fri, 12 Feb 2021 13:09:07 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: dc65f803-6005-4089-b9e9-08d8cf57627f
X-MS-TrafficTypeDiagnostic: SJ0PR10MB4509:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SJ0PR10MB4509A310B003E8708ACE6C1FBB8B9@SJ0PR10MB4509.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UjQn49ElAuyGDSrCEx7UYykwI3xZDRXTmJQ+Ttl7heqUA+vQmbRL7r34cLIkzMyI5DqO5ZdoHWktEzPlaOuOFM7w14aT7AWr83WIETILiNkT10fIZN0+e7Ft7H4YvSfrf5r5Magot8oJsGJ5z5AAIiZzRP31ed8uDADeF7LX+iFvYFYDTKa0MBy55g6gOiGuC4ztSpxy46fbquPtT+pZpGyiweRxbR/nccg2U2RWdubXIQRdTPnApwToRLuFQ8JkSBubl+24aHaKzOftdpYRk/1LORE2uZM+5OF+2j6iuxPfKzqDVEYPOjAIz4D71LXTksoG0wEY+vbul2oSA+7Q/KdXwBIPixuB759EKe8baMhZdwGPp/lHDujktzvY0wxjkG0xKRpiEaRXWvysyXM4KiDa2lZmxQYrEdN4HzIL5e4iw3M+B+NqvW1ap2eEN3PrUtDs7qrTOYDT+9T6g/IDokRYoxgkk7+0w1Yf+Juz5eklYabHPd1ef0CUBQkTaKc9k5bnfssvXpY1579Jw+gk2mlKfV66UwbUnfXEA4/aiOZ7ZJDHDkcFugOzaYyAWzUv
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB3077.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(396003)(346002)(136003)(39860400002)(366004)(6486002)(2906002)(8676002)(4326008)(52116002)(186003)(26005)(2616005)(1076003)(316002)(8936002)(107886003)(6666004)(478600001)(6916009)(36756003)(66476007)(5660300002)(86362001)(66946007)(103116003)(66556008)(54906003)(956004)(83380400001)(16526019)(7696005)(14143004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?dtPWbyBZAgP6Iy1+EyF8kDi3dYBQPfi/8fw+ABexMWurzoZAeW71NOdIXnFM?=
 =?us-ascii?Q?Z0JrBlq+J30UMb/SCySSqRQVyW9j83dvqYccLWI7JwoltbUVLiwdXVH4Z873?=
 =?us-ascii?Q?P+to963w4mCiYOBILudeG1doRElw8bew/WHb+0NJgAFVQErrxSHkYiQTJbJu?=
 =?us-ascii?Q?YXftcrL06FO3KQyCEgJB+nfP7ePQZ8W50jf+9SW+Bae2p0my1lmFi1wrMWAI?=
 =?us-ascii?Q?520FRhE3BH0ms3Qc2kYxaa0qN5K7bdVBxqmEcuw3iTTWfVCNZfd2dB4KPpoR?=
 =?us-ascii?Q?Ky/4kJbtnMHmDdgB00nt8W9ujkM+D2z6TeRbQLoSR1sWW+ab3JG+2ZyE6lfd?=
 =?us-ascii?Q?x46uMxsn7Okf+0SNmBGqIdzEV0uwN8dnepSYZqVJ5hMtlXhIr1byD9VtSv4g?=
 =?us-ascii?Q?I7DJnujqK2XVsZIz/UzGjVe6QiCg4NCj/7trlOIbflW/xnj4xarbYRpceaQY?=
 =?us-ascii?Q?iMMrRvW7fQysjgrwzSs6De6LcMMvy3jDspXQ8gLynx0P4wyreMKoUoSByKEK?=
 =?us-ascii?Q?5YSXVq2tHthi0Pvh0aB8c3XildoDAi97SSVtlaFRv8k3oUkQoXecURlWhksu?=
 =?us-ascii?Q?CAHV0NGIh7rejt4Dy1oMqJsN7euqwf34jnNq/Jt49luCxORkYPiw2LCRG/Ll?=
 =?us-ascii?Q?5wFAbTQiuuXeETQcEE+b82WQYyBpyDniqp23DPA2FEZCJe0ebtE8yfJrVMx5?=
 =?us-ascii?Q?mDbRG/MX7zJrOCJXnZYLpOPFK726BXOmf79R5AbMc7LXB7qtnvRmb10DAp1K?=
 =?us-ascii?Q?CQNXnJVYUWGinKTd3TWmqAHZs7+SLzz8wCje+E12rIVym09V8hzdRWB5a+hS?=
 =?us-ascii?Q?3IgC50qFhj9xmUtoK/P7etT3LQYGTZgYodMhHtoBHmsvc/+dvppeYcMCHOgE?=
 =?us-ascii?Q?fn6QY55uO7e4o1SOcm5VAeSR40nzaIPsdpV44LvQtEb+gKeUD1QAC3Tkes9S?=
 =?us-ascii?Q?85WXHkbnmGYDGQ5n9N8vU9dt5pQS6fEkyL6bgN1VyAR87n1iwG06KCotZFog?=
 =?us-ascii?Q?hmk8mzoAR+jf/LAXUCxn81MlEY9WK0oI7s1tfIDKwFOmnTu580V18TYILTaM?=
 =?us-ascii?Q?gZ6k9cPIjplNeXlAx+W12J3ltStHr+eGfvQtsDT2/0W5sz7Nxrd2HEvE+1t3?=
 =?us-ascii?Q?YOX4e8HFgwpCfi3xJW5UMzTW6gwygJmajygat+gauapHuUWDsltstRbw6bBg?=
 =?us-ascii?Q?IjYDtz9afrnzdRlFPch276cGtFgrMcp6fEzhSMEw4mEzvnc6nci/drsi0i+K?=
 =?us-ascii?Q?zMVGyQUE8wk7drw02CwIkd/3VkK5wFgxUmkADGrPZFjk39XpQesw875NEGga?=
 =?us-ascii?Q?PhbIqyk0XS4JcICrNaSmTK84?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dc65f803-6005-4089-b9e9-08d8cf57627f
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3077.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Feb 2021 13:09:09.6286
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PgJIwIhovVEDg1Ilr5xH9mFBDpMY673ljAs9svP57U3ziCtWNAX5Lq+tlosqMPM9Re5NGsav3NNSfEhjK5wwjCT2qBhUD703A2he+Idv5Zo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4509
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9892 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 adultscore=0
 mlxlogscore=999 mlxscore=0 suspectscore=0 malwarescore=0 phishscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102120101
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9892 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 mlxlogscore=999
 bulkscore=0 suspectscore=0 phishscore=0 adultscore=0 impostorscore=0
 mlxscore=0 clxscore=1015 lowpriorityscore=0 malwarescore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2102120102
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Add a unpin_user_page_range_dirty_lock() API which takes a starting page
and how many consecutive pages we want to unpin and optionally dirty.

To that end, define another iterator for_each_compound_range()
that operates in page ranges as opposed to page array.

For users (like RDMA mr_dereg) where each sg represents a
contiguous set of pages, we're able to more efficiently unpin
pages without having to supply an array of pages much of what
happens today with unpin_user_pages().

Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Joao Martins <joao.m.martins@oracle.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Reviewed-by: John Hubbard <jhubbard@nvidia.com>
---
 include/linux/mm.h |  2 ++
 mm/gup.c           | 62 ++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 64 insertions(+)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 89fca443e6f1..43f59e4eb760 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -1255,6 +1255,8 @@ static inline void put_page(struct page *page)
 void unpin_user_page(struct page *page);
 void unpin_user_pages_dirty_lock(struct page **pages, unsigned long npages,
 				 bool make_dirty);
+void unpin_user_page_range_dirty_lock(struct page *page, unsigned long npages,
+				      bool make_dirty);
 void unpin_user_pages(struct page **pages, unsigned long npages);
 
 /**
diff --git a/mm/gup.c b/mm/gup.c
index 384571be2c66..6b6d861727cf 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -213,6 +213,32 @@ void unpin_user_page(struct page *page)
 }
 EXPORT_SYMBOL(unpin_user_page);
 
+static inline void compound_range_next(unsigned long i, unsigned long npages,
+				       struct page **list, struct page **head,
+				       unsigned int *ntails)
+{
+	struct page *next, *page;
+	unsigned int nr = 1;
+
+	if (i >= npages)
+		return;
+
+	next = *list + i;
+	page = compound_head(next);
+	if (PageCompound(page) && compound_order(page) >= 1)
+		nr = min_t(unsigned int,
+			   page + compound_nr(page) - next, npages - i);
+
+	*head = page;
+	*ntails = nr;
+}
+
+#define for_each_compound_range(__i, __list, __npages, __head, __ntails) \
+	for (__i = 0, \
+	     compound_range_next(__i, __npages, __list, &(__head), &(__ntails)); \
+	     __i < __npages; __i += __ntails, \
+	     compound_range_next(__i, __npages, __list, &(__head), &(__ntails)))
+
 static inline void compound_next(unsigned long i, unsigned long npages,
 				 struct page **list, struct page **head,
 				 unsigned int *ntails)
@@ -301,6 +327,42 @@ void unpin_user_pages_dirty_lock(struct page **pages, unsigned long npages,
 }
 EXPORT_SYMBOL(unpin_user_pages_dirty_lock);
 
+/**
+ * unpin_user_page_range_dirty_lock() - release and optionally dirty
+ * gup-pinned page range
+ *
+ * @page:  the starting page of a range maybe marked dirty, and definitely released.
+ * @npages: number of consecutive pages to release.
+ * @make_dirty: whether to mark the pages dirty
+ *
+ * "gup-pinned page range" refers to a range of pages that has had one of the
+ * pin_user_pages() variants called on that page.
+ *
+ * For the page ranges defined by [page .. page+npages], make that range (or
+ * its head pages, if a compound page) dirty, if @make_dirty is true, and if the
+ * page range was previously listed as clean.
+ *
+ * set_page_dirty_lock() is used internally. If instead, set_page_dirty() is
+ * required, then the caller should a) verify that this is really correct,
+ * because _lock() is usually required, and b) hand code it:
+ * set_page_dirty_lock(), unpin_user_page().
+ *
+ */
+void unpin_user_page_range_dirty_lock(struct page *page, unsigned long npages,
+				      bool make_dirty)
+{
+	unsigned long index;
+	struct page *head;
+	unsigned int ntails;
+
+	for_each_compound_range(index, &page, npages, head, ntails) {
+		if (make_dirty && !PageDirty(head))
+			set_page_dirty_lock(head);
+		put_compound_head(head, ntails, FOLL_PIN);
+	}
+}
+EXPORT_SYMBOL(unpin_user_page_range_dirty_lock);
+
 /**
  * unpin_user_pages() - release an array of gup-pinned pages.
  * @pages:  array of pages to be marked dirty and released.
-- 
2.17.1

