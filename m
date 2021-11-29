Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B5F28461F03
	for <lists+linux-rdma@lfdr.de>; Mon, 29 Nov 2021 19:40:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380069AbhK2Smk (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 29 Nov 2021 13:42:40 -0500
Received: from mail-dm6nam12on2054.outbound.protection.outlook.com ([40.107.243.54]:64097
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1380008AbhK2Ski (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 29 Nov 2021 13:40:38 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gai2RhfxtczKIhGfFDlY+StjgSdv7t9MGH9GJexHd+sfzQGe2lriwdZP4jhaqI4dvRuGdIwzPyu1kQD/t24oiq6smbJh5ZZm8VXSIRQndcEXhake3naQQ/ReYZdxx5a2+BSuJUY+QHmWjGiLuHBn56ebDGLZPkZ5WLWJi1V2xd/b5oLQiRb7GA0NbyKg/TBT/f4WRRv/S04+rPirTUJBHglCH61Cafqrvub5AfkC6NfN528hYI/vNsRx3EoEt0Avgu20Hgnme3dFvpuB9GFFIk2R/GQcxs3JOJWgsOVG4NfT9lKsPmyrY2GpshPHw+F1IU1ww/sKsaG9jeqB6df8XA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L+GEygL/f+GJXTK2KCcXYfBaUr2YQUPnxuDh1wWTJ1I=;
 b=khDZltndXhOM5vYYYnpB6AhTwuw4M7xav+DkMtdUfqyn5Zx81vIupyuP8kzw9sTDiFCw9rs7wsvJFm6iXi0wL6vxrVNKNCnjBx2BzlOKmRYNKBSknoXqR54XKb8BF/2pMYBsJJIfedzXpncCjdWkpfahh8F95kLUQrIwSw+XRD+O6Lu5FeF6Nt1vd8uV52j2hm6szxuiXTnfCqVOMWQwaTjDBBj6Susuid803z4OJD0nFn0CeQwIPy2DrydO+FYnIGL0QHkIMgKogNFEHLNI1NEmC4JV4t0Eved1Z6m4scNIY5Gn5h6wYPNu2hIaaTejTOc1tKwfy2bfM7Nyr8+obA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L+GEygL/f+GJXTK2KCcXYfBaUr2YQUPnxuDh1wWTJ1I=;
 b=lMu2X2H0C0KrM3QQgW4yyxzUyImh5WMO4FFgjTkA1GLa1WsI5LJzDjM5dCYhUgkqWV4eMj5I8nQ5pTVy6b7lefqeRVdvwRNR6UDWUMWpk8KaxQlIq6ghw7SFS+H6Tm494R7BGK0mAYGUF8dJdgfLoJp9vqGKpReQarN3yxLCMVxMFVKNd5xBqmaBl2kyV5/WbJISIf1reUAnkXss9U/e/5AQ1y+lLPkPDY91Fo5fsye5+qf6rTroF8J7AR+ZOi/+NOOM2Ha2wonTb7sVt128csVnYWgrQDkzQTqHdUuzBdXU8a/YTf+woUZB4A0WAiXQVoKRcUvzA7XN8e2lAr3l3A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL0PR12MB5508.namprd12.prod.outlook.com (2603:10b6:208:1c1::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.23; Mon, 29 Nov
 2021 18:37:15 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::5897:83b2:a704:7909]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::5897:83b2:a704:7909%8]) with mapi id 15.20.4734.024; Mon, 29 Nov 2021
 18:37:15 +0000
Date:   Mon, 29 Nov 2021 14:37:14 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     selvin.xavier@broadcom.com, dledford@redhat.com,
        linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] RDMA/bnxt_re: Use bitmap_zalloc() when applicable
Message-ID: <20211129183714.GE1065466@nvidia.com>
References: <5c029daf43b92fdc27926fe8a98084843437c498.1637872888.git.christophe.jaillet@wanadoo.fr>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5c029daf43b92fdc27926fe8a98084843437c498.1637872888.git.christophe.jaillet@wanadoo.fr>
X-ClientProxiedBy: BL1PR13CA0114.namprd13.prod.outlook.com
 (2603:10b6:208:2b9::29) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
Received: from mlx.ziepe.ca (142.162.113.129) by BL1PR13CA0114.namprd13.prod.outlook.com (2603:10b6:208:2b9::29) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.9 via Frontend Transport; Mon, 29 Nov 2021 18:37:14 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1mrlWc-004TDf-0w; Mon, 29 Nov 2021 14:37:14 -0400
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d215eb6c-50b1-4d44-266c-08d9b36743c4
X-MS-TrafficTypeDiagnostic: BL0PR12MB5508:
X-Microsoft-Antispam-PRVS: <BL0PR12MB55082B030686057E79A3316AC2669@BL0PR12MB5508.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rtrLQKYkXoxZtB04602aRmIoTYmDnCYoEVDCNKjZrHG+zLVig3jzw5tERCPacTo6d0kCE7ZDNIszBf6n32nutfjoRwN/2udJMdKwr9W1uUlnj0FLjsY3r+Wt/cP4HaAtYiNm7dKqokStWzK2QcfJrV+ydouck/+BQdgmLvRdGoH9KHXB9AHEyIhx2yTpEDuJd/KLD8v7DnXiPy2npcNGdu7evXcEyNTY7LtUkd3sMecHY3FcojVv3PFIDACnDuF0YSkOsKE1hXjbFrfYfArHU0B19CLPhf6YpGMqwx8bIF4xLm36r2w4O2W3S2ERxDJK0+N1odF8nPWAgq/EDfnTsOXPZi8r99QkPsLUdQwvEgZpzNuqmQIs5tYh0WkULKcDeTf6NoW+WVSP3d9FVomElkDHUUVB90Rsk/boPr53PLVJRYbdaay491H3nGdppuqox36+2k77wKnk7cbFL3kBoLW9ZwV3TJWXtpEOVhT3joloxlc7VKLdRoSKDDQSZBdIdJIy/6VDGSVW5RDvXxmmkBHqkA6TTod+vUVkJFa+0s4J/Qg/zDijWNk94lpmyn9KPaR47/lj0ZWYTFZhcAJR6ECFhGTAi/AEcZ+sghevCoILufWMDl3CEyiXGHMtg3lz7XgXpitrAnDyBHTb1p9DyA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5506.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(33656002)(2906002)(1076003)(4326008)(66556008)(6916009)(66476007)(66946007)(316002)(38100700002)(8936002)(8676002)(5660300002)(86362001)(26005)(36756003)(2616005)(186003)(508600001)(9746002)(9786002)(83380400001)(426003)(4744005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?R6KnxVqUbr+m5S3HiOwiRiepVKB2ToqLFxCpDMuz0JDvrbUPtFWVxyvlYzWc?=
 =?us-ascii?Q?BAuazxj80T9WKkJpBoo9tzqmseTjL5R2IGnw3+Z48ILv6MaRIxScj1QbXl7i?=
 =?us-ascii?Q?FyfYMLGJrRreXvHU6pRrVIyWkBGEitB5QL4puMJLZpelnHntt+dOcDQ2gB/c?=
 =?us-ascii?Q?G2zxiIg5TYtuBAb3Fgvifv1eB//gNltSfFr9X7Ae8mKn6V3sgcZTBNkRrXcX?=
 =?us-ascii?Q?OWgCMcwrjqtzFyw7RDWkh96XHgHcU0QCk+zweTcmQftXa7T4mG/dWDvZdwML?=
 =?us-ascii?Q?JR744HrNVydSnnf+3NabH2Dm6x2TTi6HrhVC7eqk9zkSUZQ9MqgZQgvUv6uP?=
 =?us-ascii?Q?68eQN2e1C/NltUaJx1ZjrB4Wng6gy2rzkd1e0lFkotK/gx1vUsvw2SxCVBd9?=
 =?us-ascii?Q?w/LFBCJ4hctsGnrdfedsNgT7xF+BLvBBeSx5jOuo55XdOK9thIq+nr/iPAXJ?=
 =?us-ascii?Q?MLASpScEmf7Y75dSTmwK9SG2HL3h+NILIAVnX4VH56e9mZGeOLdrryJzSLJa?=
 =?us-ascii?Q?xomQz22tNQC4M7DgL4tj0brIC3ThAT4qkEgZO+xVUTcPvTJz1XbEFhFN0kje?=
 =?us-ascii?Q?6ODeFOKrSSVsS4QxIlJs+P3V/A3WTZ5TN/97kWiKQs5BwbJPdl2wzd66yvRn?=
 =?us-ascii?Q?lbbrj6v6PYVolqFKTa56TLW6ceY3MU2NZaym4del24gmahFrqbvcMsVo9Cyt?=
 =?us-ascii?Q?Z6JUjtIQOy9TJJUMdo47m4vE7fXdukPcipa1STNzpOk69x6+qnDkem7oyMZ2?=
 =?us-ascii?Q?DOWL8iwtZeGO6/SRoAkuXrOb0efhxfJsu9WWla9KJRIyu4MvBBhJ/ZX6mTTk?=
 =?us-ascii?Q?YgiFSj8qdghWUWzynn6BldGi0p6HJlmpRFoEvfDrCpaoNICGmlhyNJHQWaR9?=
 =?us-ascii?Q?BCz0v6owLWU2ACm8wkrTDYeewpvUkwaQjvLfEdGOFbcDaNPGNQbXUnd6lx0v?=
 =?us-ascii?Q?L1EQWChQJtugHX0wqADY4n5ucc2vB2ewZVIIocKzWMaahyxiL8iU2iWij4h9?=
 =?us-ascii?Q?bpq+acl53UMHi/QkJ01I7uIHv7xy80Lv/MdyJw8MvW4KXOLQ6aEy3EpoK5Ha?=
 =?us-ascii?Q?TAGv4dksnZzqJvnlyudDMkYbjYueFSpey1hMID2eEbOmVtFDeTaZZP8uVmqW?=
 =?us-ascii?Q?Ng1tO2Y8cIO2sUvL5aohoJfAoOfVZjSIq/+sCcNyG/zGYjN/CVKBvvQpeLeh?=
 =?us-ascii?Q?cfvmZ72xEpxZCfuJCpKu6eR31GuCSDWwdfglzRBfh7+M7tGWWsmPTr7qhRFm?=
 =?us-ascii?Q?5o97WWqH92cSe/r/4j7nyNyofAEskQBC+3q3QTal98N7Aomc4gyNsD6STyzz?=
 =?us-ascii?Q?qPTBGA0rzBLkVKYell2LWka48HhLl6vPguXgWzJoyhQca3+72DcWLw6Bwjsl?=
 =?us-ascii?Q?8U0oJ7tknPfAxaFMQkT2nV0P9hDU4hcIh9NGNlktDhSnGO/+68EQH32cBMb2?=
 =?us-ascii?Q?CCCldUVDhK02gv3tbfdh2M9z0fFxZa0vtBljjSdEOpYkotfaVLZoQF/coxC2?=
 =?us-ascii?Q?wjf8Lh1UjDZa4OEEKSTLfGiN018FRDT3GcS41Um6p6QI+K6rcxYdLQKR6AU8?=
 =?us-ascii?Q?ogqwD23tgujf+yiQoIA=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d215eb6c-50b1-4d44-266c-08d9b36743c4
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Nov 2021 18:37:15.1897
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dk08JLtZrt3PJc5JnsSAzWiMtPOFi/pUDZ/9DkYwweYNZB6MwpKK00twHs7KNY+L
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB5508
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Nov 25, 2021 at 09:42:28PM +0100, Christophe JAILLET wrote:
> Use 'bitmap_zalloc()' to simplify code, improve the semantic and avoid some
> open-coded arithmetic in allocator arguments.
> 
> Also change the corresponding 'kfree()' into 'bitmap_free()' to keep
> consistency.
> 
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---
>  drivers/infiniband/hw/bnxt_re/qplib_rcfw.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)

Applied to for-next, thanks

Jason
