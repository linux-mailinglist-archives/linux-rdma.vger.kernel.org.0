Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2D46319F8B
	for <lists+linux-rdma@lfdr.de>; Fri, 12 Feb 2021 14:12:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232083AbhBLNK4 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 12 Feb 2021 08:10:56 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:33664 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232035AbhBLNKI (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 12 Feb 2021 08:10:08 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 11CD8hLb019060;
        Fri, 12 Feb 2021 13:09:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : content-type :
 mime-version; s=corp-2020-01-29;
 bh=gTiBt+CrqGfggJA3OH1RM7VHsAGGwncGhuIFXhwKGF4=;
 b=g40/U6e2jmUa+GprFcxuqQlqvJfkgCMpkLpsEUmqAUCMk1JqQoS70+yvVgAHFJxQ5jZ6
 9rLG5znv7kqQNRuFSB7Btiyyi3OymkqV0XrjFEHWiC1Gs0jf9g/szUjKaiMA7g1247c9
 7g3/9YB6Cd6As4huzdfPdKevZJXRjVjRxC7RHKv2p/y/MIDvgBIxaytdZboLDDmD4/Fc
 AlbV1w16NaYzf57RiQ9++tg7tRtAlwnjdEUhygVzQiXlQ4I//cqL4fyvUtdtax8C1rkR
 8zmcOhUN2KgZOkRlnpqQudpD79lDHBUvSTxIo59jRv/N1bI8Kw93Uly2vJec2Wm6gKPs Ig== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2130.oracle.com with ESMTP id 36mv9dwad9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 12 Feb 2021 13:09:06 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 11CCo7BY055546;
        Fri, 12 Feb 2021 13:09:06 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2104.outbound.protection.outlook.com [104.47.55.104])
        by aserp3030.oracle.com with ESMTP id 36j4psyf4u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 12 Feb 2021 13:09:06 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MFBz7I/AAbdsIRRo1VmWjiyBYQbu2kF099Lj32qlaZvTq3VuveJY4Y+bduojbuSn9evXn9KSVaR3WaDMR4X8IZkra27FCTXkar/gjgShM3SCw32URjY0tIGrWckYpXDQhrrDP8j0NXDS15C9lOlQDpQmUbqyqmgDvbzS7s7DOQmkN4qEK7S6r3K4Sc5Je3yIzuXA2REPy4Ck0uB9q2z0BjokfKmHWJY18aXc6+rrP6d6UxKaMA8vh2e+Mmwdl+j/nvlMi28bPz3tDJilPjIKfL8rxyJcLqoQO9g8V4DrCCKZcIMuCeGzWzl+uTuqnHcDca/oJzijA7A38YfxWIp5Hw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gTiBt+CrqGfggJA3OH1RM7VHsAGGwncGhuIFXhwKGF4=;
 b=FJyeiuIGMiOC0TmdWIhR4QVvjXDiYgDeO20lGJ1Hdulyi70hrKf/3RU+sduQzkYRkxM4n+uU6vZ1bIRTm9/CTgdlhpr7uzDUKTQF1oztdk/YZiGdaO1rCpBF53g8pceD7CDPqate+EabkQ7OYehr5ubA6dCbzucbonPgSDgL+1UVScbBmTClUJS4eUJdw0Da+HjC8nAhNsLz+k0pzPMBCEfQk6xhZUYBSSPLvTB7owz66gIS59TscbVMuzzrv4cMIJntJW7PsrZjjKiOWjxrqWeuErLTVMlPiUg7BzVmR2jyBBj+oSmfye1y+p3jYi+Eg5oq1KhnTc3BWzMmPpNavQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gTiBt+CrqGfggJA3OH1RM7VHsAGGwncGhuIFXhwKGF4=;
 b=HYNP4zAyggo+XFNiK/sVVX2x7OMoggKSRBDaAYS43WpnueTOtI7hYyyXaGZz00oqHxTs7F/zdUw6j3k4JSlzVYC1Qu0GLPodFXUC2t28fGMZUWLNvuzu9NcQ+3bvjPzsbeHdtmGYW2Vj9ADH+N6Kaz3mhEdP+D8yQX4uA6sAuiM=
Authentication-Results: kvack.org; dkim=none (message not signed)
 header.d=none;kvack.org; dmarc=none action=none header.from=oracle.com;
Received: from BYAPR10MB3077.namprd10.prod.outlook.com (2603:10b6:a03:8c::12)
 by SJ0PR10MB4509.namprd10.prod.outlook.com (2603:10b6:a03:2d9::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3825.17; Fri, 12 Feb
 2021 13:09:04 +0000
Received: from BYAPR10MB3077.namprd10.prod.outlook.com
 ([fe80::74a8:8649:e20b:d571]) by BYAPR10MB3077.namprd10.prod.outlook.com
 ([fe80::74a8:8649:e20b:d571%7]) with mapi id 15.20.3846.034; Fri, 12 Feb 2021
 13:09:04 +0000
From:   Joao Martins <joao.m.martins@oracle.com>
To:     linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Doug Ledford <dledford@redhat.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Matthew Wilcox <willy@infradead.org>,
        Joao Martins <joao.m.martins@oracle.com>
Subject: [PATCH v4 1/4] mm/gup: add compound page list iterator
Date:   Fri, 12 Feb 2021 13:08:40 +0000
Message-Id: <20210212130843.13865-2-joao.m.martins@oracle.com>
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
Received: from paddy.uk.oracle.com (94.61.1.144) by LO4P123CA0347.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:18d::10) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.3825.17 via Frontend Transport; Fri, 12 Feb 2021 13:09:01 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d4bd07fa-8d66-4e3e-9f1e-08d8cf575f35
X-MS-TrafficTypeDiagnostic: SJ0PR10MB4509:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SJ0PR10MB450985727BBD7E608CB21D79BB8B9@SJ0PR10MB4509.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:862;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UziUhbKscjivGO8FdEIYMSH6Wf2Y07vLXIWZJg1nX9bLf+6gLPlrJ/SgCUTN2W1v8HCF+AhVkELZ0NAczmZ0xBP3lIaSCzAP9YM097+F+2zdQFOeIcQ66hdqpB9qw7MJgauU5HLW5V1SySvJGRnQDPW8Jaa+x2xxrkJOqadg2CADCWZhk7nhSlw+QWtj+31iKr8weXnlZJupCjxQ6FT1ft/hP1ZfdVWPlEkdfyYe41BGSlduMCcHa1vwTjuZbEtTj5JDy++jE1i9b77NYO5UegS+q8zwjIol1PxWct8HfH4LquIb/jxcgmFaue2tbczMW+nAMwf+yzJyrDN3pVS+wRSSH8dx1xnGurHMFIp927XSsUvyMwle5vd7XVO2+vMQEXfa8226qsgsYfzEvKc0bqRcsmsy/3CGL98hkP2DfpZLe3c4Lonjpem+NOcup9B0cK0AicYQQpkOkzRPPMQg78DXPEADGhBmLOJ4qTYrfRVAw/ssWWKa61UbSmfVpG3EMPrPrrChZmXdAn2TdHF71w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB3077.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(396003)(346002)(136003)(39860400002)(366004)(6486002)(2906002)(8676002)(4326008)(52116002)(186003)(26005)(2616005)(1076003)(316002)(8936002)(107886003)(6666004)(478600001)(6916009)(36756003)(66476007)(5660300002)(86362001)(66946007)(103116003)(66556008)(54906003)(956004)(83380400001)(16526019)(7696005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?D6jZcaCvbNWY/m5qCOfqBRGkkkANeVXIbE8Um3vC9e0eD0keYa3vg/DDTpCU?=
 =?us-ascii?Q?dkT7dSqIFHNhkelP1UEYWi3ljTgdQXIkJeyWC2d1NsywrYyysa7kJ/AOrT5m?=
 =?us-ascii?Q?zjjCsxgkdef3m4EX85gmsFDnm6mqi/n8PF/oNsSTjmljp4DAikk/H726jTXY?=
 =?us-ascii?Q?pW8zawgcrCsAehkGvDFjUcl5wQsAYBAv5CTj3rDUXqLaWfPu3BqW3fFVCFuw?=
 =?us-ascii?Q?np9kqenOsIy+QUGzC21yhznGfEhdrebHl8Vn6sBCb/X8VTyAtv46hE8t2GXx?=
 =?us-ascii?Q?HkqW74IlNdxQT9hoMmg/7fHOXrFso/LrNgIxdj4D379DEg2AzONOhMVA6SNV?=
 =?us-ascii?Q?MG/fLZ7JM8JUoe9iq+GSy8x9+fBDEutjeXmpVZfrO3yrEb3m7c8yrOdku9r9?=
 =?us-ascii?Q?UpqcV5HieBKcjxwtXhJkDmD6pGWCg4haSYhGdgxfOfC1JAyLa18Zc2aZwSkG?=
 =?us-ascii?Q?+wxd+6pi3ZyIVb6r4q/oHUKZb3SF+svxKIssHt3deo7ErP7l69uv4rzwlWJ6?=
 =?us-ascii?Q?29pizbJ4YPs7S+aBxuRqbyC0Mogl9ugXd/bMs+QS6S8vc2ls+enGXt9lwucw?=
 =?us-ascii?Q?8ayoH15iVfg2XrplmnaVc4UyfHkBpG/izIoG7+M6S3kCgFJolGPGByKK9vYK?=
 =?us-ascii?Q?wlKwMxjg2KXMC4Vdf01Nu+j/G5PNRmm3bjJu2mpaVhAE/LHKaf/DZAQvFWZT?=
 =?us-ascii?Q?kYpHKGDfUehPO0lWK87gdVT9dExlx121zUv7bfA66ltLFJ/zP8YtRSyOmLoQ?=
 =?us-ascii?Q?5xLQMh20AkDgy5NExU89eyCeTVhPkbwvhbzvib8OlAjkWIMCoQ1yi54x66Qy?=
 =?us-ascii?Q?BuUI5ykuExGXnNwBe6TUP0B6K7z/LBKqKuc6b9ypp1DlPfDLF45yCvnaQFuV?=
 =?us-ascii?Q?P1vuVyH7CKC5dbkmdtG4KeviC+Hx35oPZmfW5PG/TdvLiT2VSE7lwBuX+hKF?=
 =?us-ascii?Q?0uBVE1OOSyVldhn/QucD93WM7FIwX0zbZFdgG2fZ/bFKO2I9skKs7DAYusz2?=
 =?us-ascii?Q?vz5pAHSFpjec69xCB+Xe+yCuzhD90DbL52UfLaJL43pUH8OdUqBaoJXul9BX?=
 =?us-ascii?Q?lRTRNHDwUIxuxvX1NhWbZHAHaDs0VZFNzmUATdsFDWcvogRIy+DcYAReyvjp?=
 =?us-ascii?Q?DQkHkS36AVZFm1lOX3Ny0gBu3LcviJ4jvzA75J+NoEbS42tY4147shtcO5GQ?=
 =?us-ascii?Q?2SDmIvtfZHdxtFmjjUkfe7/FyfGFnSOyR4jI0yXDurRCCPuCkCdvq4EzMJPt?=
 =?us-ascii?Q?5sQ4x6OuxzkHK+c+icrZMoCTqdNV7nsWrUpjC7GzV0m4wTp8F1a5b0YxV0JP?=
 =?us-ascii?Q?sZ26bDmtnqNfTxyNn2sc7sq6?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d4bd07fa-8d66-4e3e-9f1e-08d8cf575f35
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3077.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Feb 2021 13:09:04.1178
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SoNvr0ifO+Ur3VNItcVXh7DpnXREZiR52ryveHesmj379jKLoCal8oxpD2c4X3kYxracGzd8vjXWCoBqN68XDDSMdkJLf9pn0pzxfMuucPg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4509
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9892 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 adultscore=0
 mlxlogscore=999 malwarescore=0 bulkscore=0 phishscore=0 spamscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
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

Add an helper that iterates over head pages in a list of pages. It
essentially counts the tails until the next page to process has a
different head that the current. This is going to be used by
unpin_user_pages() family of functions, to batch the head page refcount
updates once for all passed consecutive tail pages.

Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Joao Martins <joao.m.martins@oracle.com>
Reviewed-by: John Hubbard <jhubbard@nvidia.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
---
 mm/gup.c | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/mm/gup.c b/mm/gup.c
index e40579624f10..1a709eae2bfd 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -213,6 +213,32 @@ void unpin_user_page(struct page *page)
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

