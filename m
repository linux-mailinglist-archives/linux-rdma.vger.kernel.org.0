Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A092931134E
	for <lists+linux-rdma@lfdr.de>; Fri,  5 Feb 2021 22:18:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233108AbhBEVS0 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 5 Feb 2021 16:18:26 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:52196 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233075AbhBETAp (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 5 Feb 2021 14:00:45 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 115Kcu95017951;
        Fri, 5 Feb 2021 20:41:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : content-type :
 mime-version; s=corp-2020-01-29;
 bh=i2BRVXmP5hvWQVGCMk07jhgUIaktkfcSnPtSBprIfl8=;
 b=oeSBeoC4LtUb5PV6THpsowGltd61VA7/FtpPurRpQILQh0irCIsdqbh+jtflxjCR0JWR
 aD1kcTWqkzcyZB672ziusqc0jRtSbUizw4cij9t4V9gRxQNNqdMO9C7zpjLq0vS0UMs2
 LlSKIekPhpoOhiQCH185gTZG+gZlUgK9NTspy+f5U5aWcDPKS19xS5v7U3RJAV0HcG2S
 o9cayrPTY+AIpBSabb8JJmhIw0nxUmPW4o/aeru5IT206mH3A++6Z/PBBukC/cIMHRg1
 3LeFmhvywLxOBSWTPijO2Fg6fNgXmyy07nDoAGu7pFt13Df9neIORk7MEMQeFMKmqYqy PQ== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2130.oracle.com with ESMTP id 36cxvrdu4h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 05 Feb 2021 20:41:55 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 115KdfaE065160;
        Fri, 5 Feb 2021 20:41:54 GMT
Received: from nam04-sn1-obe.outbound.protection.outlook.com (mail-sn1nam04lp2057.outbound.protection.outlook.com [104.47.44.57])
        by aserp3030.oracle.com with ESMTP id 36dh1uej1c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 05 Feb 2021 20:41:54 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JYqkrxj1SOIg6EQoA+iOXAF4qBfo00yTTVuIXKuZ8ykv5+otTqXKtfIXyEKjEMZQuZfKDM93u+GotL+zvSPEiRvk7zG7iuOpePuOPGNaC9svLs/7byosVvtKf2GYL49+VqIexvOTu7lfz2G29FaUMvy8k36FuZm1g5H2XOZfTz/+ncMDTMlQNCH0ctDQGzfTngPrQEBYy3nnMtPFTExpEAikn/tdKMurkykyLBc95vWi1/UTZPsAoMMc5a1Ad5DM+dLeyU/az9HAe+CAWDnQa1vLx1YXuGfOYdkzhBeyFdYVYbgCHQu8J2RhSglMNVI+dTkXXZdrzHeWF9EBJqC7GA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i2BRVXmP5hvWQVGCMk07jhgUIaktkfcSnPtSBprIfl8=;
 b=iYZq86m22jVqPmBQHeZej8WBGlw1h5SmKWd9Nu2k3CDR9hvPK0hKlSFtEktJdz1BNXF7nNCqx7JghCz0ZhjuLu8+5bMOJCLNXNG3Oj5jKe7nfFcHrpjQbvsSoy+/XGut6wbKMdLlMx9yQWcshNPpydenn1eK7Evuq22/nU2pu9yduzB2KqHZH+GStYUw0Cp6ZmG/PCevN8Tf5X3p7FyIqZyWj3HRcje1wJ1R0MDFWV9RliQvUdWiPrr6YQ4SuxgN7BreE16NZSAYvb4lwYiXbK2/CMf8+cDyBHV25c1G3O5mSpucifY6rQjIaA+A+Q6POcFV53r9+rsTHJfkwF/x6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i2BRVXmP5hvWQVGCMk07jhgUIaktkfcSnPtSBprIfl8=;
 b=E7FwCRQlAs7mhdP382lSW9RMGaC7cc35KOuYYq809fUrgRECelIc9X+jJynPg0uVyQySNi8tq110dUNdL9ytFySnPr2uOeBudiFlWeItY4ko/JaeAjEQFv7bUc6A7qz6NxyvezcUWdRupjIjrXkD7tIXDNblicyRss0TEmPQdco=
Authentication-Results: kvack.org; dkim=none (message not signed)
 header.d=none;kvack.org; dmarc=none action=none header.from=oracle.com;
Received: from BYAPR10MB3077.namprd10.prod.outlook.com (2603:10b6:a03:8c::12)
 by SJ0PR10MB4432.namprd10.prod.outlook.com (2603:10b6:a03:2df::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3805.21; Fri, 5 Feb
 2021 20:41:52 +0000
Received: from BYAPR10MB3077.namprd10.prod.outlook.com
 ([fe80::74a8:8649:e20b:d571]) by BYAPR10MB3077.namprd10.prod.outlook.com
 ([fe80::74a8:8649:e20b:d571%7]) with mapi id 15.20.3805.024; Fri, 5 Feb 2021
 20:41:52 +0000
From:   Joao Martins <joao.m.martins@oracle.com>
To:     linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Doug Ledford <dledford@redhat.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Matthew Wilcox <willy@infradead.org>,
        Joao Martins <joao.m.martins@oracle.com>
Subject: [PATCH v3 1/4] mm/gup: add compound page list iterator
Date:   Fri,  5 Feb 2021 20:41:24 +0000
Message-Id: <20210205204127.29441-2-joao.m.martins@oracle.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20210205204127.29441-1-joao.m.martins@oracle.com>
References: <20210205204127.29441-1-joao.m.martins@oracle.com>
Content-Type: text/plain
X-Originating-IP: [94.61.1.144]
X-ClientProxiedBy: AM3PR03CA0058.eurprd03.prod.outlook.com
 (2603:10a6:207:5::16) To BYAPR10MB3077.namprd10.prod.outlook.com
 (2603:10b6:a03:8c::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from paddy.uk.oracle.com (94.61.1.144) by AM3PR03CA0058.eurprd03.prod.outlook.com (2603:10a6:207:5::16) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.3825.19 via Frontend Transport; Fri, 5 Feb 2021 20:41:50 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6ca7b1f1-435c-4a73-268a-08d8ca167834
X-MS-TrafficTypeDiagnostic: SJ0PR10MB4432:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SJ0PR10MB4432167EC3817821D3678F24BBB29@SJ0PR10MB4432.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:862;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Se1kf2DXDtlD3PyR8udZlmXuKa4bK6KpEmg7nvjJ8xzdZIdRlVc935MfJJtNS+hU7HxYzHTos+h6KkEyWZ/cm99jqMC79tUdaA7SxwYCCa3m3cb7oX6W4lSW9m7Z2LsfgBU3P26fH5jyatgg5huLHRjYVfuEyNJ18/xRfdBn1falVhH4vcadtSvjlsCQtWCauzMIVtRuVwZTGaSesBYMVX5UkXEZeukObPDHBcyAaO4qsmAHwTNm8yvBeIv25laQAP6V7q4nSaLrVyM+VX1RuZgvW/fEr+9d2MVrP18YVdgkQMbAm1Vui9eOC0QYWAMOZGyK41Cj402zOQkXBJyetRUz5+kJCX+DP8fzLkfmkG1KZuHWVwvFkEKtSYQ16+FzpyQnvvuY2DLbl3M2dJp59+aEZxpBasuxD0wDDGLHsUs0O16hfEFFsLivFAtopQtKtcbYNwVu/xm0gKl2YRyICUgKifSzXBNC5y7H3vuhZegLI2SkDEdPathb0XCoYqlx9fs/mSccmmxS9SDvyXgdPQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB3077.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(396003)(366004)(136003)(376002)(39860400002)(6916009)(1076003)(5660300002)(186003)(26005)(54906003)(52116002)(103116003)(4326008)(8676002)(83380400001)(66946007)(2906002)(36756003)(6486002)(478600001)(6666004)(66476007)(8936002)(107886003)(66556008)(16526019)(2616005)(7696005)(86362001)(316002)(956004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?TVRHqMSp5W5dr9m36VEprk3i/+vTAg7Hwju+OVqKXOR4ztX+rQ3WYBWU5nEB?=
 =?us-ascii?Q?unyIPqNg8R7aHuZ0OODiVFNcqW6JmgTKQtrPiQXyOi8Iw9LoF2QZr72028Z/?=
 =?us-ascii?Q?pDqLLUrez6NL22nLx99OZk5wyfTF/LRgAIY3nJIm+GhblU1Etb3LtqgEKIHp?=
 =?us-ascii?Q?LGnBS/cCi6MFqxStQ0g096/q19LaTdMnpuBsRu0C33z/zC6eL6QUIe3YZEdG?=
 =?us-ascii?Q?6FViZ2jax2NmYqQYzW9eEYHkSb+zUNNzKYT5GachfaU4CjOi0+LXNv1Q5nFY?=
 =?us-ascii?Q?zP3HK27la8gjibomMhCGG9X9xjtjeXZdT3U0J5eiUnJaGTohEmwOusyTBkW+?=
 =?us-ascii?Q?P90vKAdyYFSI/Dnvrgx92sztD/H+ov+v1XfTrzpj24/jP4eyz+ulbO9+HPYA?=
 =?us-ascii?Q?g1WS0Z+bodIdqcl009K8FUbmacjU0qINnSHlfVag8Gvh44ksYUQXCShH0hFq?=
 =?us-ascii?Q?s6mlc0M+uho7nOMoZl+avAgEzMWcD7wOih1ZSMbwyFgjpKlsEpX0FocMwrqF?=
 =?us-ascii?Q?YYpPpTashN6SWyA9aJxsClRb+iNHysEbZiHKF+NG1Ind6833Zm/iFsGz9LeO?=
 =?us-ascii?Q?DFgP9yVMdrgTi2eSLYT64VQ19JtJ4ILRblndzVJbJ0BJeQX6/yZMPh7eeP9/?=
 =?us-ascii?Q?NEKil6dO0pskiS+Ia/uuvdgwpbHPuoC0UNx9m49jXiZLlSU5HefqRx0OMit+?=
 =?us-ascii?Q?KyyESfpDEUfJS4TJgt+Z85knIHTCVj0Fb5UOD2mHd7vFdplRKMMamLDpyUil?=
 =?us-ascii?Q?r5i9LarSHcIRvt0jHMsUzRpYYOspEkneZF/mYmMGpJZeN8sT+K00v5QZwA/X?=
 =?us-ascii?Q?Uo7N1PsybZZIJKdo4QvJbviq6VvclHbb+Ybn4GI1mJqFKzvgHFdMuhjC6jH6?=
 =?us-ascii?Q?5FT+L+bSsAHXUGdvcJERRKTYXrNuF86cQLXY4IkU3oIupFSsmd75E7JGR1YH?=
 =?us-ascii?Q?chCXXaY+oFPRrru0W36cbP68uH4PQ9gl416wPMSgCLut8hs9YK7c5guwJCsp?=
 =?us-ascii?Q?3vUwj2E2yViLQBfDaJNVu44Ba4oJNc4immHG7LeqZum1ooG9fUX8fE6vedmZ?=
 =?us-ascii?Q?Mf00J7AhdnFmSdqQ19KwjBVHHynZ8kY3Yk3UtVx3urunkcabULLiqRydI6/H?=
 =?us-ascii?Q?og6lsKxb9nfptUVficWfYSzWRTAA7urmFt21UYHbz0oWCiDIbsObZ0INmde4?=
 =?us-ascii?Q?72KZKmRPByXTx4lw8fPXAiKwIfUbB7FygyG4NMgW2rNMK+vaI2khI2MAPMbh?=
 =?us-ascii?Q?4UOGGBxuLe0Rf5g5VoCxtclqt40CLaHhDKj4PiLuHDLUkd/If34fFtklLR/U?=
 =?us-ascii?Q?Mw/yCea8xbcG/1BU1UWaTMyB?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ca7b1f1-435c-4a73-268a-08d8ca167834
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3077.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2021 20:41:52.9009
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 20hFKJ/pOUcE85azmM7GDFczEU89xPU/HPM3xVy6/oj53GfUGVGZaOEGwWXj8M6ke1ESv9zQSDwx/M5tB+ZzifCFvBZk47ttYLD1LVIbgDA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4432
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9886 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 spamscore=0 phishscore=0
 suspectscore=0 mlxlogscore=999 bulkscore=0 mlxscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2102050129
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9886 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxlogscore=999
 mlxscore=0 priorityscore=1501 spamscore=0 impostorscore=0 clxscore=1015
 suspectscore=0 lowpriorityscore=0 phishscore=0 adultscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2102050129
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Add an helper that iterates over head pages in a list of pages. It
essentially counts the tails until the next page to process has a
different head that the current. This is going to be used by
unpin_user_pages() family of functions, to batch the head page refcount
updates once for all passed consecutive tail pages.

Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Joao Martins <joao.m.martins@oracle.com>
Reviewed-by: John Hubbard <jhubbard@nvidia.com>
---
 mm/gup.c | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/mm/gup.c b/mm/gup.c
index d68bcb482b11..8defe4f670d5 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -215,6 +215,32 @@ void unpin_user_page(struct page *page)
 }
 EXPORT_SYMBOL(unpin_user_page);
 
+static inline void compound_next(unsigned long i, unsigned long npages,
+				 struct page **list, struct page **head,
+				 unsigned int *ntails)
+{
+	struct page *page;
+	unsigned int nr;
+
+	if (i >= npages)
+		return;
+
+	page = compound_head(list[i]);
+	for (nr = i + 1; nr < npages; nr++) {
+		if (compound_head(list[nr]) != page)
+			break;
+	}
+
+	*head = page;
+	*ntails = nr - i;
+}
+
+#define for_each_compound_head(__i, __list, __npages, __head, __ntails) \
+	for (__i = 0, \
+	     compound_next(__i, __npages, __list, &(__head), &(__ntails)); \
+	     __i < __npages; __i += __ntails, \
+	     compound_next(__i, __npages, __list, &(__head), &(__ntails)))
+
 /**
  * unpin_user_pages_dirty_lock() - release and optionally dirty gup-pinned pages
  * @pages:  array of pages to be maybe marked dirty, and definitely released.
-- 
2.17.1

