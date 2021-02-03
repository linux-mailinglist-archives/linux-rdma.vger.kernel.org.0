Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F0C6730E583
	for <lists+linux-rdma@lfdr.de>; Wed,  3 Feb 2021 23:04:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232956AbhBCWCb (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 3 Feb 2021 17:02:31 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:58918 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232725AbhBCWCB (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 3 Feb 2021 17:02:01 -0500
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 113LxkTu136679;
        Wed, 3 Feb 2021 22:01:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : content-type :
 mime-version; s=corp-2020-01-29;
 bh=PoCciuS2kupNF4/nFmW0PvArn3uE1gW//0DfhSrI6Go=;
 b=jwmhOvn7kvdBZGUl1r0cKHDXE0V/Ot+z7YMHsNBKHtCwBCaw4W/BTiV+68TnONBNj42L
 G55QyvIdCilT/6YbQqDoudvgrfa2Rzd+hfRkdlFW+894e5+5wERcvHEOOF1Hasq392Gv
 pfsLCI53Pwyee9tmedz9F/t54ZY6GGwj9lbAzOYKl1pXesSol1zB+CGUI2DcpiXabm/K
 gn5OwaeMI0eqLDozrqDfd3PjDHfeBqZYouRXtqjwirdXxgIfEDiAe2hBn+Jp0nrsalHA
 zyEFTtP+/K0b2yxpMM+iRntMFMRkdNZtZInEdYr7ek55WakwIVY0gz/N3F3T3x5qupwt jw== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2130.oracle.com with ESMTP id 36cvyb2mfw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 03 Feb 2021 22:01:03 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 113LxaVH097865;
        Wed, 3 Feb 2021 22:01:03 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2107.outbound.protection.outlook.com [104.47.70.107])
        by aserp3030.oracle.com with ESMTP id 36dh1rjjp3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 03 Feb 2021 22:01:02 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Mea4cQ8//ObM/rzBMQe8G42ywOMZnCeq+IgnJ6LIP7HOrEg3i7/hKkbEBfZex6Gm9lveTZexVJIrJ7YgAAUQsO5DSXtwtFvLC0RATP27aMFL9M0YKxFlZ97RQk58kWZRs6buolVhVfCKaIskU3iIope1q7NNSW7h9wa8ZEcTF6a3xaOLozSUbI82qFdaczSVzDCDRoa/ilUtDl64rV8tBb2C5CHqXEs5Nym95IsD6b2ew8aUO0XsYOWM8/W4NE5W+IY6lVZzD1nkOrfZSqP/amnAWJk8FJtQF8a+M9JY2HYBjjLum8F63cO62U858ThY/13r4DVFA0ev5j4UHFj4Iw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PoCciuS2kupNF4/nFmW0PvArn3uE1gW//0DfhSrI6Go=;
 b=TQgdaP8ECOlusZtyhPdVQIylYt02ekXd+S68z/P3uaoDn/+25LOk74CeAP7QEZinzogg33l3tYoBRVmpqle6bC7bMzD0/OlJO+TgMDSaXWH4xldo7U4hj+Gdg+wS6xmzdwSPMFuboQBohXQdTuXfzrSanoDTYINvqWdoDbbZj7h5ra+1TTfxMkQSpsOdO8PUtugqbZ4iiLkJ9HLBPnYaSyDIQNXnoqJ9NnBHSszggNnWbHmHNXRgPWNKvOLv7syWn66M9xdhgP9uVi82evZ3MTXICNmEIVfLnCdOgt3o2QUp9uuN6yMs8NR21krIa+vyY5qy8QMGns9Bhpf/LH9kUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PoCciuS2kupNF4/nFmW0PvArn3uE1gW//0DfhSrI6Go=;
 b=w2U6CrPmdoOnqc42EIeinsHPx7RQWPROVAKnE7e1XUjuNr4ky2jw1rlCy7XPvZ7SRYFK9dbInanwCpdEUfqXGg1yIr0lK9/lPeiruyAztZ5AhisaZIMSnP8EF5sr4a1lESS6xWNpByH7kEN0fSOiZkgYvr788nxZuiScUuW9ATo=
Authentication-Results: kvack.org; dkim=none (message not signed)
 header.d=none;kvack.org; dmarc=none action=none header.from=oracle.com;
Received: from BYAPR10MB3077.namprd10.prod.outlook.com (2603:10b6:a03:8c::12)
 by BYAPR10MB3077.namprd10.prod.outlook.com (2603:10b6:a03:8c::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3805.19; Wed, 3 Feb
 2021 22:01:00 +0000
Received: from BYAPR10MB3077.namprd10.prod.outlook.com
 ([fe80::74a8:8649:e20b:d571]) by BYAPR10MB3077.namprd10.prod.outlook.com
 ([fe80::74a8:8649:e20b:d571%7]) with mapi id 15.20.3805.024; Wed, 3 Feb 2021
 22:01:00 +0000
From:   Joao Martins <joao.m.martins@oracle.com>
To:     linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Doug Ledford <dledford@redhat.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Matthew Wilcox <willy@infradead.org>,
        Joao Martins <joao.m.martins@oracle.com>
Subject: [PATCH 1/4] mm/gup: add compound page list iterator
Date:   Wed,  3 Feb 2021 22:00:22 +0000
Message-Id: <20210203220025.8568-2-joao.m.martins@oracle.com>
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
Received: from paddy.uk.oracle.com (94.61.1.144) by LO4P123CA0266.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:194::19) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.3825.17 via Frontend Transport; Wed, 3 Feb 2021 22:00:57 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e4bdbfab-c560-4844-1eb6-08d8c88f30f8
X-MS-TrafficTypeDiagnostic: BYAPR10MB3077:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR10MB30772E73D223BFE21053A09CBBB49@BYAPR10MB3077.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:862;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WJrZ7uKGQ10Zmba3t9DlCpddQ22guFqyaB6BX3YiN4vODdyNyKK3F7GKjb/KjQBQlABcsdMPfQEbkJhyV/xQRpK+pPxbqideIqd3grl01bLPv2k8P5UCrIUMIFkj88tuf1qCn+Mo019evX7IafDevF16CS5UTSKjXHpX2R4RIcCbnIz+OedjaYdMAv5EJ/xPacOogCoiB1McXScbv/CynAK6bzAm1HGMMTd1KGtsqLw3NQwIJfl49sXfPN6TL6fwFo1NEUOU/zTyjm3yMAtxNLRG69EY8A/LKzoj6jq6JaQNVI4L9zziA5cMlOj+B2Lg+AvWHisvp/e3SG+qBeogathSjyE0Z/Xfg+UoB1+DV7mxEtgGkOy7kdrA0JQ4kFwg1ItH7nEGA58NkA3UMg7iHA3s4XOBiPsOG5CANkXlQOEab80gukGr677Rp3iui6LpvMVa9DXOr9HbonrGRoAMjrj1DyLSB4Ao+Iw7fhij9J8I8VKPAvSz4J+7R5Xj2N9REQo5OZ/MK7UJp60Qi2OPKQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB3077.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(39860400002)(346002)(366004)(376002)(396003)(136003)(6486002)(83380400001)(86362001)(52116002)(5660300002)(1076003)(478600001)(8676002)(107886003)(4326008)(26005)(36756003)(2906002)(103116003)(16526019)(66946007)(316002)(54906003)(186003)(66476007)(8936002)(66556008)(6916009)(7696005)(956004)(6666004)(2616005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?5x4exipdbRoT8Lluf0N0SIDn8L63Burxf95n3RUmBC6bzD4/LKSKmT2Ao4Dr?=
 =?us-ascii?Q?8SQPp47+zvLHvyBhxa3PA1lrUpyLK0GDCaAvFf7BFXUGqvkg9gDGzSHFYOcq?=
 =?us-ascii?Q?xka72EC/Qxu0OM63M0Keb/QeMfobWRoYk7/rLNNGQ1okDTG7zqSDytupMtgO?=
 =?us-ascii?Q?u8lN7psdZKuPlqLYWdtgEOkfebMQ0I1tufpCrN0on2n9koULek/bwJQpco4F?=
 =?us-ascii?Q?7EpPY6BRv5SOssw69l3iMedGqSYThJCO6K5ub5fidw8WJZZguaVGMKxAmY+J?=
 =?us-ascii?Q?CLeNfYkSBHP/xSzApc9KkfOfNUI3JplAp9qm+16AR9eSxNZ1idD8WQpQDeyt?=
 =?us-ascii?Q?EEUUN1s7CuCQFkYSarUGJ7kC2PxlYuWGOLjHdyJpBEq7RNu3cxuBZ5t91bJU?=
 =?us-ascii?Q?5dVYwpS4+3oNJ4ih/njxz/t9kqR1NiMaJ6GPTLmphHEapOt+ve3JObgFarZc?=
 =?us-ascii?Q?B9zRElqOeo2gjbJ4MboOPLiQlHhccsr+YYkqv+IgNw/PDF6O1qmHDEQOFgym?=
 =?us-ascii?Q?U7ADNp4DIBOwp3K0lta7Ry7hdIzBpDDSxgmX5B9NcNjJiza3tMm0CMd/P+h3?=
 =?us-ascii?Q?cDktDeyGa7bNlPF68+BXJFUsv8ifSU6mMqfGGe34oZofkZOREE40kD3mFMNc?=
 =?us-ascii?Q?RI7pLiMhCI8IFQBqO0WMeCqw1QCbY2fREJE6Bg+3UgYQw9TQ9qe3AL0F9KCA?=
 =?us-ascii?Q?pHQTWPRqHirJXsJvHmO0k+eNoEtXyENKr3U05Vy7vTnDvW/D6lphssH+MGWH?=
 =?us-ascii?Q?Sa/iP6sA3S6C8lHrUwKhU8LyfQOfkuvCEz3X/cfTVg7UBc/RqLSynHh7m0pQ?=
 =?us-ascii?Q?Ju7bU0MRKeNoCQcsCBN3CwUtA6eajqcYcDGjtVpxOQgzqRCWcE1eeWNOiUj8?=
 =?us-ascii?Q?xx+1UaQ9ReNgnJz2HOe5tg0p8xo1DGiukI/fve1wBddZr0KLqITrhrAtaNDZ?=
 =?us-ascii?Q?FWVMzh9RKMmMzbZgATTkhqjuuWvwgt1oAeTRCsCuatOQvS+yecnxvSigVhFd?=
 =?us-ascii?Q?8L41R+2UOAv3+A/0nfV69uHsvStSfFcBEpKwYG0f0JPggnK/yXHCH+ND7OZb?=
 =?us-ascii?Q?g2HmMDjQ?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e4bdbfab-c560-4844-1eb6-08d8c88f30f8
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3077.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2021 22:01:00.4548
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Zfu2QDF7fcp27B1oouKiVkqoviOQP3pQBScleY06nn5+f3sPzb7Rvqdn9WA/YT7/i0H8WNg9kpQpEEhUqKsoTJ+yPnQplFmI9tlHe4/VTAQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB3077
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9884 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 spamscore=0 phishscore=0
 suspectscore=0 mlxlogscore=999 bulkscore=0 mlxscore=0 malwarescore=0
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

Add an helper that iterates over head pages in a list of pages. It
essentially counts the tails until the next page to process has a
different head that the current. This is going to be used by
unpin_user_pages() family of functions, to batch the head page refcount
updates once for all passed consecutive tail pages.

Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Joao Martins <joao.m.martins@oracle.com>
---
 mm/gup.c | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/mm/gup.c b/mm/gup.c
index d68bcb482b11..4f88dcef39f2 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -215,6 +215,35 @@ void unpin_user_page(struct page *page)
 }
 EXPORT_SYMBOL(unpin_user_page);
 
+static inline unsigned int count_ntails(struct page **pages, unsigned long npages)
+{
+	struct page *head = compound_head(pages[0]);
+	unsigned int ntails;
+
+	for (ntails = 1; ntails < npages; ntails++) {
+		if (compound_head(pages[ntails]) != head)
+			break;
+	}
+
+	return ntails;
+}
+
+static inline void compound_next(unsigned long i, unsigned long npages,
+				 struct page **list, struct page **head,
+				 unsigned int *ntails)
+{
+	if (i >= npages)
+		return;
+
+	*ntails = count_ntails(list + i, npages - i);
+	*head = compound_head(list[i]);
+}
+
+#define for_each_compound_head(i, list, npages, head, ntails) \
+	for (i = 0, compound_next(i, npages, list, &head, &ntails); \
+	     i < npages; i += ntails, \
+	     compound_next(i, npages, list, &head, &ntails))
+
 /**
  * unpin_user_pages_dirty_lock() - release and optionally dirty gup-pinned pages
  * @pages:  array of pages to be maybe marked dirty, and definitely released.
-- 
2.17.1

