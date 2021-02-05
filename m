Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D6C023112C1
	for <lists+linux-rdma@lfdr.de>; Fri,  5 Feb 2021 21:46:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229693AbhBETC3 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 5 Feb 2021 14:02:29 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:38278 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233150AbhBETAo (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 5 Feb 2021 14:00:44 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 115KdQZR195498;
        Fri, 5 Feb 2021 20:42:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : content-type :
 mime-version; s=corp-2020-01-29;
 bh=0LTNyLhfcQU8WurGe4uk1JQtTl/ZkrEkTZA6jP+zRYs=;
 b=k+w+qDHd8qSYcAXon/ucFHWY4VaerhKw/R4O5HqYGoG5c0xhw9HPTLeALNXtOeGMSDCf
 /yo65lmCFDfeNTCE/txbWKkkaBnTBr76bcJWz7IRwjkOQMQx3oywIlF2MxbVpiqqS8ZR
 WTn1LfWGVMiDVg+ooeey6e6UAboepZu1le7O+7qQK5KlSNtDSPxDNQVdcyWIWJgAjbcs
 ZCtyShVRY3DTdzQ15wPhdCJIZRMmZvBeJfYIxiVYOonWsgIWJiizpL/sv8zbRT3JLhuS
 XsSuZklT30W5tCOB/1CcNLgxXO0A/7vEIxKVtaDUf+PFraRcVgUzOQfcyNKVzIfv0bqf Ng== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2120.oracle.com with ESMTP id 36cydmb22e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 05 Feb 2021 20:42:03 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 115KfBmB034035;
        Fri, 5 Feb 2021 20:42:03 GMT
Received: from nam04-sn1-obe.outbound.protection.outlook.com (mail-sn1nam04lp2053.outbound.protection.outlook.com [104.47.44.53])
        by aserp3020.oracle.com with ESMTP id 36dhc4p4pd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 05 Feb 2021 20:42:03 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZAZkrkEf+z6BSGmYS2mfQ+6y+yDr6sG9UOeUY5TAVIRTP4D+9tWL9I0bsk227jBUOa2vm/oyPsSSOnZDgKS8ArGQd5siPLs1aB2bF4GXevAN+QrzZbe655al29o8eoTbvmoLNj5GYFYZO2AsVePvfNAgpEIEjfMUg4TXsC9N2ur3hF6UYjx9zUYK8/wSZM3iC8RHlM6Nhe5MHYBKtJd+vYeJ50E6HSCum/ZkIVVq4cAtteKmMecuFOXQkh562CLBKnwlvLpzWBHYm0J1julD+LfVqu6m+vMwIGq9R6NNx8Hoiv3OosT7eGyxGKXbywRjnPqBNaPvpSJl19gRhXEYNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0LTNyLhfcQU8WurGe4uk1JQtTl/ZkrEkTZA6jP+zRYs=;
 b=nXAEj/afdFeYAKz2De3O8VwPJ33nBOnWI4eJcoZU4GdwEVbpiF6+inyoBjSdTt/5r6a4rxhxeWsC5Co97kwUX6iLnvaDOpvHCKglIRliRl/e6wJVy4OoXwKAqK7YBn56an9eLHyaefniZgS2ZNKY6oLNZQgDlA+143/MW5bTZN7T5NdPATjkPIHRwrYbFGMqEvS22lDoTMwAuTdWT2JvsKvGJJLiCHIhR7Qz92lfYlCMPMspxCD8lzURKoTjmIHE2Vfu/Ne8uBo2VRqD+sJphqJ3EGTSqmFU2W6ns95nXBTcHDxi5bY9HhTCkK0EF+0Z38+1nS+F4IFxZ8PdlI9z9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0LTNyLhfcQU8WurGe4uk1JQtTl/ZkrEkTZA6jP+zRYs=;
 b=EOiYzQAV6LpDQNLRS6uUPoxIl54flngKnUpUu/LrbnueQh6/MNANQvspBNLleSUQmoLV8uLI8tm9fnGLmDjLQDcU07R7H4hcY64039RcsQT5pQD8IKMcJOn3CGZtdNNKwmOL1DVq3t8k82niBrKuojXYkylcQAGn2BWQSHYQONc=
Authentication-Results: kvack.org; dkim=none (message not signed)
 header.d=none;kvack.org; dmarc=none action=none header.from=oracle.com;
Received: from BYAPR10MB3077.namprd10.prod.outlook.com (2603:10b6:a03:8c::12)
 by SJ0PR10MB4432.namprd10.prod.outlook.com (2603:10b6:a03:2df::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3805.21; Fri, 5 Feb
 2021 20:42:01 +0000
Received: from BYAPR10MB3077.namprd10.prod.outlook.com
 ([fe80::74a8:8649:e20b:d571]) by BYAPR10MB3077.namprd10.prod.outlook.com
 ([fe80::74a8:8649:e20b:d571%7]) with mapi id 15.20.3805.024; Fri, 5 Feb 2021
 20:42:01 +0000
From:   Joao Martins <joao.m.martins@oracle.com>
To:     linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Doug Ledford <dledford@redhat.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Matthew Wilcox <willy@infradead.org>,
        Joao Martins <joao.m.martins@oracle.com>
Subject: [PATCH v3 4/4] RDMA/umem: batch page unpin in __ib_umem_release()
Date:   Fri,  5 Feb 2021 20:41:27 +0000
Message-Id: <20210205204127.29441-5-joao.m.martins@oracle.com>
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
Received: from paddy.uk.oracle.com (94.61.1.144) by AM3PR03CA0058.eurprd03.prod.outlook.com (2603:10a6:207:5::16) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.3825.19 via Frontend Transport; Fri, 5 Feb 2021 20:41:59 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: dc7463f9-eaa7-490d-877d-08d8ca167d58
X-MS-TrafficTypeDiagnostic: SJ0PR10MB4432:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SJ0PR10MB44324016FD663BAC2541410ABBB29@SJ0PR10MB4432.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:370;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NVhnKcxoi+1YeQUlTXA/AghpDMvhCmuUaWzwKcebGrkbaVZl5nd7ZIMyEYlZaj3hgp8sI3BX4mQ2mV1rsLeCcldrZnCRnegOdQJjnmoV18UGYn9pJyxLBLU7ZfG+k0D9I4ztHJN4V2L3DzCPBews1dt3FkU9zqe4qU8YZc8XFV0hpe8CYVkhPHZnw+z/r0U0CGPChnuP+9lJ8Q5SDDPv1ZXFDCtLY65WjFzuhonRU7oAhOMzfyp2+pxDnBU8u16gBQPpNNxUkS3IzpzffM3SdL0EXwGGZEmjYwNBfKygLU5jzKrEJGckERy6oH8OCd1m+MSTgf/Tsv3txkPOsq1Y7bnRM2oOubhkBm/6B9JoRHkT6+pmUbMayeAmTmeg2b6ybWuRqETz0r2d9ghY+EGXlfPr9QV47NxUFQ/QZH9Ee3kThbirmHB9fZGt807QleAm5uuUNA0dsD8f13R2qXtFi9FRMqfpD/k+B+zqJMfhCTFdgqek5FkLuEDv/yS2snxjlBofc/0ND4t17YXbPMnFag==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB3077.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(396003)(366004)(136003)(376002)(39860400002)(6916009)(1076003)(5660300002)(186003)(26005)(54906003)(52116002)(103116003)(4326008)(8676002)(83380400001)(66946007)(2906002)(36756003)(6486002)(478600001)(6666004)(66476007)(8936002)(107886003)(66556008)(16526019)(2616005)(7696005)(86362001)(316002)(956004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?JRDoVXDvElOlBQAF/3+e+BtRTf7ya9ry3liTSNoCHQyfmJ/ZL1eRIxFSEjw0?=
 =?us-ascii?Q?4X6JADjKLmqPhVHLfDbggidYPbWJ3TMU2V1zUGVUUp2rocfo+m0OGqFw0tPf?=
 =?us-ascii?Q?gjmQJV6qVF6o7lOR61ZGfhYUPSRcxSxqVeGzphGJBV/SWjl1SF4VHzorsTlo?=
 =?us-ascii?Q?KnfZHPa8i2rDaA/4RNiC6GhbaM0k5/DkyOn5aIigIRPgljyHzu+mUzwantmE?=
 =?us-ascii?Q?m1vqvcn2J6e9lyuUf6RMZ5+MEYIOq+BPXTDHb33OjED1oCbSy40gF57BiOLJ?=
 =?us-ascii?Q?p0UitbFdzPwCbs5aPHHjqZF3sgeywlqfpzCpgzhm1ZuXuuGLTXQ1KhiZJGxf?=
 =?us-ascii?Q?RIL5eBscNMG/cYgwUxfu41+jfZoFbXQEuXQZ2esg1UdeEoSMKyns+3fzknn1?=
 =?us-ascii?Q?5X29xSEvFP4el0G8mkG1c64dW4epwxce+xDaN+56I20Odsa2H7uvWJ7vHQFB?=
 =?us-ascii?Q?S5yio6Cyuk/CqF4f0rSdF9WmZvqe4gTLDF9PAIR4kCgTtwtJeDcg0I94CsYF?=
 =?us-ascii?Q?kV8JeJ9GfvLuMp0QMxS423qgZ5W8OUPlHZEjVGOfVZW7uk7jX/Awclpxij9F?=
 =?us-ascii?Q?w50YVw3ufxFB6VUaGOel+r3vSNWDCIy6F5I6avlDxGT4ub+IBLyCK+xPGMWT?=
 =?us-ascii?Q?VOVrlFm663vjjib3OfUO2+3U9gP5plMa92lhXtHKyYKmm7eIp88L5t65vKp6?=
 =?us-ascii?Q?n+B+H2RVm9FZDPOn6mdjzwMZxhrjP3CiRnZrMOaS1AXs6Teehs+1eVgqt4HH?=
 =?us-ascii?Q?nBiIXhRHX4AXJ1I/u64Jjig2J1wgKbgO/bgSIDH9+SYJXd8nnQKvXv1Bin+8?=
 =?us-ascii?Q?1kKTS1SQjmnSzloTdfrVZZaDUInfW2DcEsJ2xC5Dqn5GvOnXBbstuxOLiJsL?=
 =?us-ascii?Q?zOHcCW4SxosHi+8+FkrhTOHnQw9Mkbjn+PhI8KMetecOmgQr2aUNBtHzWJIR?=
 =?us-ascii?Q?iyXqbaCoj1BzzQ0cQ0+2t3C44FBDpPaDbRWVGTfZ0W/U2VEIpBnRlKPCN8nJ?=
 =?us-ascii?Q?wikCc/KD/6V0ibp1OB63QFqCS+4Xmp3dGZdmdH5TlPXKCDOx732mfkAwh/sR?=
 =?us-ascii?Q?/8hU9w4GZwmkFjeJ71r/Z1D6Y+ojObVJhhgGnMdwzbFGoisKnZ+GC8xwxVD1?=
 =?us-ascii?Q?pKMSX90bYqVzsfmyo/jKvBJ+CeiU9oV3ol96bhde+i5Wj8KsZ6ICxQBtINzl?=
 =?us-ascii?Q?EfkLw15DiznArIN60n1PO3A2gptyz3dlwrLIUd/l2x6OpyhOlPkRcYphi28N?=
 =?us-ascii?Q?5fbVjax6rtmyFnQzc/XykCs/KlfrvYY7cC1UwHqNk37IWM3S8D+zAIM08Ooo?=
 =?us-ascii?Q?wAD3moo4Y1EjjVEBIKcct1Cm?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dc7463f9-eaa7-490d-877d-08d8ca167d58
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3077.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2021 20:42:01.5819
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sWfPLzAY2chy3d8qstbtM/v0vQ+9ps1JlaVay5eudAKev0rvZx/z3P3MnuUQq8TZImI8wj6cSPT+DpHul2tXMWcyzjJ7CzD0fph+GUmB9S0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4432
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9886 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 adultscore=0 suspectscore=0
 spamscore=0 mlxscore=0 malwarescore=0 mlxlogscore=999 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2102050129
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9886 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 adultscore=0
 priorityscore=1501 impostorscore=0 malwarescore=0 clxscore=1015
 spamscore=0 lowpriorityscore=0 phishscore=0 mlxlogscore=999 mlxscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102050129
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
2688 rounds in 5.002 sec: 1860.786 usec / round
32517 rounds in 60.001 sec: 1845.225 usec / round

Signed-off-by: Joao Martins <joao.m.martins@oracle.com>
---
 drivers/infiniband/core/umem.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/infiniband/core/umem.c b/drivers/infiniband/core/umem.c
index 2dde99a9ba07..9b607013e2a2 100644
--- a/drivers/infiniband/core/umem.c
+++ b/drivers/infiniband/core/umem.c
@@ -47,17 +47,17 @@
 
 static void __ib_umem_release(struct ib_device *dev, struct ib_umem *umem, int dirty)
 {
-	struct sg_page_iter sg_iter;
-	struct page *page;
+	bool make_dirty = umem->writable && dirty;
+	struct scatterlist *sg;
+	unsigned int i;
 
 	if (umem->nmap > 0)
 		ib_dma_unmap_sg(dev, umem->sg_head.sgl, umem->sg_nents,
 				DMA_BIDIRECTIONAL);
 
-	for_each_sg_page(umem->sg_head.sgl, &sg_iter, umem->sg_nents, 0) {
-		page = sg_page_iter_page(&sg_iter);
-		unpin_user_pages_dirty_lock(&page, 1, umem->writable && dirty);
-	}
+	for_each_sg(umem->sg_head.sgl, sg, umem->sg_nents, i)
+		unpin_user_page_range_dirty_lock(sg_page(sg),
+			DIV_ROUND_UP(sg->length, PAGE_SIZE), make_dirty);
 
 	sg_free_table(&umem->sg_head);
 }
-- 
2.17.1

