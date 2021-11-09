Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 94D6E44ACC8
	for <lists+linux-rdma@lfdr.de>; Tue,  9 Nov 2021 12:42:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343555AbhKILpF (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 9 Nov 2021 06:45:05 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:35730 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237819AbhKILpE (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 9 Nov 2021 06:45:04 -0500
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1A99t2Eo017394;
        Tue, 9 Nov 2021 11:42:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2021-07-09;
 bh=ECw0RfPMv8wOquE4IOz56MUiPAy5tnd6az8EIjY/mTo=;
 b=otYd6bDowAEDkGFPkloELZWPLOkCKcg09gC+kZpLxBXArFYF8OJc1gBNbpqH5unc4qmF
 0sSu7AgF+lBoe+oV+gg7kswwvJ8RZsVdHCNuizrxtg8Z6DvcPOXGWawdLl31BtlUR/Fp
 RLNHSv+KLDBD6MfmEM6lBvz/w3XzOOrg1v3zw51HtD/kFELrSl8tMY+jMyBVN8o2gNsE
 eEHAcww5tHt6CftfNAZUlw1wtIm46TJ9f2fI+i37OIFN3C2MGsOkdHZZHdNuU6+wOqwR
 2c9RVOngZMVwEWXyAiijvUs/GEeEmijXwb6O8dFXA2Zy/YRk0ozjDLCirsd4qB8i4cxk BQ== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3c6uh4jahj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 09 Nov 2021 11:42:15 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1A9BaFI7187596;
        Tue, 9 Nov 2021 11:42:14 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2043.outbound.protection.outlook.com [104.47.66.43])
        by aserp3030.oracle.com with ESMTP id 3c5frdtcb8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 09 Nov 2021 11:42:13 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DzcGe+F9R8jxZhVZpOCTPNq9oDQm/ZZcci06b4DvPTamKi/Revln8RXoV5nI/JRmBGlGqHXyOPE0gulCv/Wug4uJ0dAxUtXRIObRbF+bSYxCojadEjqmUDTg5EhBwBdCAxSiYnBDmqlFBswnDnVwt0yRbSDbJrbJloE34Nb7k0SULoZnuxtq3/wmm2rBy6+vGrJow517juDvw8a9/xZe6k3Gb5pijBQMSiKrZBmqyJ7zS52gDeBYtsdFxbmRoWObNvXzCwsVz04xzAqjFQBoPGHHOPu9ytsqnKDiKCFQ0y0t/UHNbFNawYlb/OXOYGmV6RuZe9/5weCUnxrNF4F6CA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ECw0RfPMv8wOquE4IOz56MUiPAy5tnd6az8EIjY/mTo=;
 b=jzmqms08h4fygEAv44638jUzdOMZPZBgNRRbJq/LqLN4rs96MCgLjkAJqxuQiaEXgBavctXTbd/epmulpcR9diXWmXXDnBDO7/xpqJMRlp4CdROAnHkBPoR6lX7GvHX57S6TfVSe3ADtJDHiJPzYmftvuwiGimU88LGtERPp9xl+I0A2x4FZ/TMNRmr/7tzJ2q5lDIhkdyIIhRpeSj3xCKf6m2wr0AH8gFnde2fXAWVO/xT7Zrt/EcQe4gxNmNCEfp0QcevbdSHuwzpSTe7ZO1UD7YaJhAlddSQAzzViw6ZajQPmEKp+rtlMpygtPRilKZ/me/qJdlQ5UtTRK9u8Sg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ECw0RfPMv8wOquE4IOz56MUiPAy5tnd6az8EIjY/mTo=;
 b=YXOvQ52csxB+ESyzDOJfyNJQZmQCopxQuIQpbuLuvcfMfTF53FikelVMbcpwU6JkEKQSvj+9aWDnzzkNeUozQui0I/+2aw4GzTbJHsxxWUQlxrEFlH2/YDsEO/74XwSceBN19pQVKcDvxG+PR1DH/YwMf1J8hxqw00FKA8f4PKo=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by MW4PR10MB5752.namprd10.prod.outlook.com
 (2603:10b6:303:18d::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4690.15; Tue, 9 Nov
 2021 11:42:12 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::d409:11b5:5eb2:6be9]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::d409:11b5:5eb2:6be9%5]) with mapi id 15.20.4690.015; Tue, 9 Nov 2021
 11:42:12 +0000
Date:   Tue, 9 Nov 2021 14:41:59 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Saeed Mahameed <saeedm@nvidia.com>,
        Ben Ben-Ishay <benishay@nvidia.com>
Cc:     Leon Romanovsky <leon@kernel.org>,
        Jakub Kicinski <kuba@kernel.org>,
        Tariq Toukan <tariqt@nvidia.com>, linux-rdma@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: [PATCH net-next] net/mlx5e: Fix signedness bugs in
 mlx5e_build_shampo_hd_umr()
Message-ID: <20211109114159.GA15855@kili>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: ZR0P278CA0120.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:20::17) To MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28)
MIME-Version: 1.0
Received: from kili (102.222.70.114) by ZR0P278CA0120.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:20::17) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.11 via Frontend Transport; Tue, 9 Nov 2021 11:42:08 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d39ff96a-460a-42f7-8207-08d9a375f822
X-MS-TrafficTypeDiagnostic: MW4PR10MB5752:
X-Microsoft-Antispam-PRVS: <MW4PR10MB5752AA36D504DC6C8C3C7F1B8E929@MW4PR10MB5752.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:530;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0eeth4VPLRLj1YlLDhwKTG4lyXieLLJo+bdKZW6lj6pfwPeg//BOfaDojYe0igb0f6oVX3XdKY4EeoguPdVqYaBQcO8xPYsj2pDWrhxw5R1HsDbUPkSJtxJON/SWu2M7DPrRRza3GcJ1EsjW/jZlL+0821PEYEzaj/S3zCZ2lt4BcPx+Z+fKroavXYmOBsNt214bshu+6WOjDaC3K4d+9KaP9kLgHoTVvJyjZKdbhSDF9D+BxOw3hoaz9EiQWtViq6w/PZ/r93SnzlO4QjR7NMPOtFvNIPkWHccVdpqaARxYLlUhCyPr25n7vei4IHsyl0l1kdlqn2Er6CfNOCEbJQGVNp59kQEaoo/4hFcznphF/ZP+wEdcYcH2z5y8s0VyYx0dURSggdDs0DJFQSyVHGYIHWXaj+/j2CcgSe49P6ILfKGzVVjQZJWgAVRShuCm+jXI2tP3zDHGRnw9j+DrVZ00mjObf8P7yV36i3FQ9SYfFDfegsg8jIhQu0wwhFhGHZmW7NoqZxr1C8jvX7fMJRqZAdogMPseeQ6Kv2Inv4VFOpxxv7mOxmV99U9hvLpd+xa0ypZYeBVt3PHTdi4t7ZxdGiJbEWzxgdIJWb7sNZAmhcpNfVt1rf2QBfk2w2IaOrTAhSPaJU3oU5uPsdihlHNqgpIumDPaWfAbMAWdCvfZK6tE/O3ygFrQxwrQKC0zWIC4unUaTfZGFP0vZICUww==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(9686003)(956004)(38350700002)(66556008)(4326008)(55016002)(33656002)(33716001)(38100700002)(44832011)(6666004)(83380400001)(26005)(86362001)(508600001)(66946007)(2906002)(9576002)(52116002)(5660300002)(6496006)(54906003)(110136005)(8676002)(8936002)(66476007)(316002)(1076003)(186003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?XP27rtyjgD3j1S31vMKKcFxpcNghiU6ltV479F2SOfw+7i3kEHGZ6DY3ItFf?=
 =?us-ascii?Q?8dT7LSo0GvJOnvDPbnxKZjHNW8Bhh7smYNpV/yw6oST4u+tR1uLl/oCMD1Au?=
 =?us-ascii?Q?uOfAhCf2kOF0mNxgNYtU8/+4CewGaMqnHKO+YNRlJGZIPUUmjQ/coKsVy3HK?=
 =?us-ascii?Q?85AF/dnL4VXsMyict45RyYSWQpda8CzXzUpUko05YQSXW/w+6sKrUXJEmbes?=
 =?us-ascii?Q?aY89+etOgNd8d30zjJ669pJllPBZm9/eS1XjX2X5l+5C+wJUEHhGolM5VWIQ?=
 =?us-ascii?Q?4jyj13PRHqoEMoMQozDnZDCzFABkDmkNuFypC8eljKg5prfVcZitR/4wpwO6?=
 =?us-ascii?Q?ZA9IVFyCXCvUAkkTf42zDq+RzBn7xIyu3XwkUL65C2B5kShzrvPuwPWqvGPQ?=
 =?us-ascii?Q?XwjIiJh+PxladM65GvVpLXMTtbBalV4ZSShqOLpR199vSyoPoqoGTzouzSQO?=
 =?us-ascii?Q?6xo6Zl+4TmC8R3iY9pyq8fZ1y/2PUBKGHDWXg88Ks5yJoUPpOlBFogOzhtnq?=
 =?us-ascii?Q?YXdBPywc65qO3CR98xH21W3nPuMS3SR4q1ot2HDqi3HAz5Gpy16MNBLbtBh7?=
 =?us-ascii?Q?i6AchBEpQHJaJ8Pz0Qsc/wTFOcx3qhK1XQiEX+zUFY7gw3O0JDlmBs2/1i7B?=
 =?us-ascii?Q?wUwQ6T7MsLJJvZ8iW1ofkbjaYjfNYD4l8MRnlSnjLDmjHQ5OJ1Yn+c5Nb634?=
 =?us-ascii?Q?hklswNnLDakDPUHkIXSNB0PeiSTSUdxOJkLTljX+xMWSdh7yrMY81nRPEegp?=
 =?us-ascii?Q?eoFk53PwtsFqzjXOhS0LzadUiorlrA/WDa3iiSp41HLqw7IpIg5QcKQXUrCp?=
 =?us-ascii?Q?m99iGWHSb9Y0oK5X3iKI4jrJs4hEEF+F4AnuTfVcYipqkt9oyFBpQU1YcvCy?=
 =?us-ascii?Q?+MK3E3UtzxmAWrsOs5/bMtPR5fVPy80Yo7KDnzic9vK6AiwE/gdB7Vp6Y/1l?=
 =?us-ascii?Q?29eJrlYpeOH1H+0HF/dtgb9sAh4BfTQJ9WtycuBT7QG5lM3roVmsziA7kVP2?=
 =?us-ascii?Q?l302MDbuNdul/2VteAv3KVXzFYrAIMGE6v1Po66LtbZUy4EbvCsMAbs4S8W4?=
 =?us-ascii?Q?pNh8fLU+orfdtY1zTcAWfy5rjC7GIFQhKot5N3tuy7QQ5IlR37YElzT20s71?=
 =?us-ascii?Q?YFb1GjZz3bNiBdZnWdIRnSSlhIwVtmErkuI46fosN5DgWkpor05UiZtq7vMK?=
 =?us-ascii?Q?sXm9XXRnceDFSwMlw86IkTgmhDP6TURSYiilnjZo2qFS3/yU3BZU4jrrC8Po?=
 =?us-ascii?Q?eHvnNrCC4FElVEStdn496slKPcK0pRCDFPxbXXGwVb7y2/t1PDwaSTPAkcbO?=
 =?us-ascii?Q?iDeuhoGaC8gOcft69ayW39VyPzmMMjVGevlBQ4x+9gLRwjr1dMacNPH5HUy+?=
 =?us-ascii?Q?4ydaKAChjIETLIzkjqBKkJrwhZiaYdN2OKXu2w1it+Q3ILbYq56+19B1GZHO?=
 =?us-ascii?Q?Gw6b+B3RhuNLgT20CKk3vuxkYoNdz8aWElCx/aCWbObfXHBcHIKg84BjDOfd?=
 =?us-ascii?Q?7sRETPWPv4T0sWP0bGb1PPAqvMsi1ad0csyNQM1SDAglEyRKTTCHa/nllo0b?=
 =?us-ascii?Q?JNgekFjPOENq8dGWc6KPBFzA5LlWlahvu4wEmdqBjO93wW0Ggq98gxGDegPm?=
 =?us-ascii?Q?Yt0RbjhTfI66b6etTs999nPup0WnOCW1v4w9fOVKCzjgXPn9gDljEUWdip4Z?=
 =?us-ascii?Q?tcZZOqoZVbMbJNiCf2WLpNAb5t4=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d39ff96a-460a-42f7-8207-08d9a375f822
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2021 11:42:12.1126
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9eotgdMuHI7QP7K8hO+RrWIrYPT2iUoP2aG78EdHvAS/8mbgPnIeH/OCtTpobaZRyOvK8TR2Id7BUPpj4jHorOlU/kiZZZqQ1JrPihGV3MM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB5752
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10162 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 mlxscore=0
 suspectscore=0 bulkscore=0 spamscore=0 phishscore=0 malwarescore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2111090070
X-Proofpoint-ORIG-GUID: dPs4slrJXWAeMXspecPkh5ykFsRzjepq
X-Proofpoint-GUID: dPs4slrJXWAeMXspecPkh5ykFsRzjepq
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

The error handling has a couple forever loops which will lead to a
crash.  Unsigned values are always greater or equal to zero.

Fixes: 64509b052525 ("net/mlx5e: Add data path for SHAMPO feature")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/en_rx.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c b/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
index 96967b0a2441..8cd120666b2d 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
@@ -543,13 +543,14 @@ static int mlx5e_build_shampo_hd_umr(struct mlx5e_rq *rq,
 				     u16 klm_entries, u16 index)
 {
 	struct mlx5e_shampo_hd *shampo = rq->mpwqe.shampo;
-	u16 entries, pi, i, header_offset, err, wqe_bbs, new_entries;
+	u16 entries, pi, header_offset, err, wqe_bbs, new_entries;
 	u32 lkey = rq->mdev->mlx5e_res.hw_objs.mkey;
 	struct page *page = shampo->last_page;
 	u64 addr = shampo->last_addr;
 	struct mlx5e_dma_info *dma_info;
 	struct mlx5e_umr_wqe *umr_wqe;
 	int headroom;
+	int i;
 
 	headroom = rq->buff.headroom;
 	new_entries = klm_entries - (shampo->pi & (MLX5_UMR_KLM_ALIGNMENT - 1));
@@ -601,8 +602,11 @@ static int mlx5e_build_shampo_hd_umr(struct mlx5e_rq *rq,
 
 err_unmap:
 	while (--i >= 0) {
-		if (--index < 0)
+		if (index == 0)
 			index = shampo->hd_per_wq - 1;
+		else
+			index--;
+
 		dma_info = &shampo->info[index];
 		if (!(i & (MLX5E_SHAMPO_WQ_HEADER_PER_PAGE - 1))) {
 			dma_info->addr = ALIGN_DOWN(dma_info->addr, PAGE_SIZE);
-- 
2.20.1

