Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4CCF13F1B79
	for <lists+linux-rdma@lfdr.de>; Thu, 19 Aug 2021 16:18:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238571AbhHSOTR (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 19 Aug 2021 10:19:17 -0400
Received: from mail-dm6nam11on2049.outbound.protection.outlook.com ([40.107.223.49]:12640
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S238521AbhHSOTR (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 19 Aug 2021 10:19:17 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JgMrkspivjn2RO4NkLejG9fmL3dkhB4Ic2DRZe/MZfm/7/WXuEsJ8sqs6UeJRd5Lb/fJskeHj1Llg38/Ooa7lJj45Qnx15b+XbeF+C7K4ztqolAFfEp+41PS5nfvcpPJYbgCeoZZtrmCai/hMnw5CBNetAtyCEprkN6hYcBRVfmEXU7mI+pVuUlCM9ExiYiYdSHYNw1cPVns4IAoO6+jn5rOzmPfpgwZms6nv/E9r9e7tGcgrirF203LyfqhkbPCMXfTIRtfa/Czd3t4T6CjuRFURDvhcdUz6ez7LmhWY4+ReKARYs9e2462iuR4veY5n5k1SoLTjo3i8zHmBK7M8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=diu/8a13OlS4eOmBOtovKh5Rex2ZvkmeTh0tVS+YHIw=;
 b=jc6whGvGJRT6Nr3QTtoKehaqKG3ge+ZNvIB8rhZjQ+NaS7byEKHPGqAMhmDHs0t+cbUgoK/mYtcm2Hpgw3NDyZyxmsZPgXgwD9+WVkYRiyLCw3tlt4RvslC3OZyICkSbkwhK326kzIbu6H62tPtensYj8ejOv7deIJn35zIuSe1Z6SUE8729TuqbPqTkqyoOkIYA9ufWOJEhTxDET4DUiE9vC42MS5JCWbX4TRLzvvE88zACAn/S8CCi+duMOIgHbvDujgwzzviOjY9CsJuzuwopeEYz6rFxs8uSf9DdEqi8aNArT9MR52rjGYGl57k/3o9eDklcz2KjcQNRVAoU9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=diu/8a13OlS4eOmBOtovKh5Rex2ZvkmeTh0tVS+YHIw=;
 b=ORoJna9zDNdL9nzqXuuw8sjN9k7mgM2omUYjslfAzcNw6HAZDEMazBoUD9/0hq96wmXiLl3fseTSRiaJ4Xvic67kqdkJVXiRtZ0wfisRnffRZWKSWctjTglL/uE8B9Kswttyp/4E/YtPIwWnOoR6qvAVAQBTocUVoB3ohVvrPGbJYAfpfJbsll/bTPkd8HJN8TKSjszSzVOWfRuU5g07ICI0JAFMKyC9qvMdD5G1epCtQvJBTcUxcVjoLQoJ2OlZAARxXCv8KQdJR44PIv3YcnrPM85VazXSvKULQfvzLs2kKQLDhD1AW6+UIIZFNiuk2+g5/6EhqHTCpSevYiy/fQ==
Authentication-Results: huawei.com; dkim=none (message not signed)
 header.d=none;huawei.com; dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL1PR12MB5272.namprd12.prod.outlook.com (2603:10b6:208:319::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.16; Thu, 19 Aug
 2021 14:18:39 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::1de1:52a9:cf66:f336]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::1de1:52a9:cf66:f336%8]) with mapi id 15.20.4436.019; Thu, 19 Aug 2021
 14:18:39 +0000
Date:   Thu, 19 Aug 2021 11:18:37 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     YueHaibing <yuehaibing@huawei.com>
Cc:     liangwenpeng@huawei.com, liweihang@huawei.com, dledford@redhat.com,
        chenglang@huawei.com, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] RDMA/hns: Fix return in hns_roce_rereg_user_mr()
Message-ID: <20210819141837.GA296289@nvidia.com>
References: <20210804125939.20516-1-yuehaibing@huawei.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210804125939.20516-1-yuehaibing@huawei.com>
X-ClientProxiedBy: YT1PR01CA0026.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01::39)
 To BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (206.223.160.26) by YT1PR01CA0026.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01::39) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.19 via Frontend Transport; Thu, 19 Aug 2021 14:18:39 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1mGisP-001F5m-KF; Thu, 19 Aug 2021 11:18:37 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c302a8b7-2002-48a4-b9a6-08d9631c3db2
X-MS-TrafficTypeDiagnostic: BL1PR12MB5272:
X-Microsoft-Antispam-PRVS: <BL1PR12MB52729FED7FED355806AF7A4CC2C09@BL1PR12MB5272.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1468;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: l788WAnKzsHozoFd5GyjDdzHCdgoe9g0P/5yfDyUfcHMXNtPEdsPX+fb+42UZXcJdgk51b1qGd0WaMzeIFt+zRp7EweeuBDnwXvNwJjwQF2Ul2XOZkx744gSjgawZ7uu1F7IIyQyCR/LJbSsx6KSxTE9mq/70KuNI/3r8IzT0/ZEjJhBlmxbPv+MCt9xt5CduP//NNJtdOzmbk1VNpz/9XEiO6DZ9B8/WmeMoY/A4Hy0c53Xeqkh/OE2e6OhFNj/HPBYBBvCKIPV+0aElXveBlQx2S1IdPIj5O3sq26bpexjQdLcP68vWk20PazPrJ5NE42PwnDse9Jw6UvPjIwiHZLjIh5uEbd0SG9BN1TIvVZ6yu4Nan86+aOlpWEKUFT86LJmlzEzXzsVk4UufiuL87NCEAc6Ezpln2otMPY6dXG3LXdpxQbegSbCJV3ggj2aEdAjf1Nt4/oRRYtunf3Ho5HWPJP/wasOsvu1C1phgUpB+EFi5H1mQCtNiKRNhIUoEtQ1SeV9tJLW7CK/j8q3Q2hYl/fjGKIkxg9Hh3d0FbNh/ZEOHkad6np/P0n54gYDukPzv+/3Umb29uRnLJ/0puAcO4oGZdatox3NhYx2SHGeuzp4mzdPyj54dgQhoufHQ34UFUd//Jr/1D1lcZjAbPuN/PD31mg1TH22H/Bx7Ll/mGIOOpsaF+zbhPVb5Ud/
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5506.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(4744005)(4326008)(9786002)(83380400001)(86362001)(8676002)(6916009)(66556008)(186003)(66946007)(1076003)(426003)(66476007)(9746002)(26005)(508600001)(8936002)(5660300002)(2616005)(36756003)(38100700002)(2906002)(316002)(33656002)(27376004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?trWzvxr5hRKJsl3/LJCqDjajLldOIDOMY1j+Arvzu1ckk+sAd5K7NcJc+rFF?=
 =?us-ascii?Q?Ie7cd/TOBD9QHZ9J7KDNl8kgDvCGhsPiJma2U1T5GVhUTRhTJqBx2u7E3/9n?=
 =?us-ascii?Q?KK4zFkBFcWvfj9fTNIYSWfvEH0BFFOXKmvmqrz5osKRq5hlRbjnNDMZeFVxd?=
 =?us-ascii?Q?lU52Owe4SWAo1lI7ibLDJz1kRM/FXglTTEHnWTNwPzCSfYsrb5stCyvjksU+?=
 =?us-ascii?Q?nh3JdjSvIy0An0YddgoKdWbuQFRrMUJXx4d6m9a9eTstCZ2ZggAZckx8/eon?=
 =?us-ascii?Q?Kb47/Tx/zTc1U9+wtcnsxXqsIXNDnzv6+nATH/e/a3N9qXmK28/vW/D1Bq1j?=
 =?us-ascii?Q?kmpAIe8n0vnnlvs8ahSTA3XvrPPbc687vmg72SIav6LVC/++GYeA6kaWAZdU?=
 =?us-ascii?Q?gOUOTqbuQEmLBt7/t+zK1snv1p4GV+vioz37ZZOQ2VOMb/csG0EN/hjeKIq7?=
 =?us-ascii?Q?lWf9a1A3tCDYj6e0tNxjyxkEofejpIOj94JpeHURwc3HQlmSxVxo7KFMwPog?=
 =?us-ascii?Q?nDSMXN3pDSBgfA2rjzhMUxetrqv3RtG+OhWPOSbmgG1pr2yPBzYZTEUb3Bw/?=
 =?us-ascii?Q?wpfh55BT7yl1eKfzHiPMm5d8ujj2HlVrc41fvk5QKmSASV/wxtwHimu1pa0m?=
 =?us-ascii?Q?HLy/rSWuNNr6GdaZnTI7T+cMGa8uc+l11DxOqLmb3wnyLq/Bndc1vzZrmQR4?=
 =?us-ascii?Q?p24/kb2r2Ba91K6fPEg5sNKUE0sHfjT+xKzabBcnpoJh/vTQoNVKJZb88b8c?=
 =?us-ascii?Q?67mFI3EZho0AOVOYkf/23fF+ZVrFvGW1iB+J1fxwglsuHDf6u7sGcupGPZmO?=
 =?us-ascii?Q?UT91at5LEJMURpNzVRmCaPNAo54WcNw4M+yUZ5M5BDVvJsY2OBnaoNeiQW4r?=
 =?us-ascii?Q?zx0A9xPnYOAtCF8+pbdgvSmYZDuwroAQuMo+7rvjUB1pH2Dv+0aj44f+nFPt?=
 =?us-ascii?Q?qzcyVSAkm2Gw0UM6ZyyEalSBdwI+nfNle6DcOUVSWoePCpgqoObxcfVqw59c?=
 =?us-ascii?Q?WzZ++qGpEnm1P7umZBn1zj5omKNy/30fORLrDtxP9HE+kbkdguZmMsyvryGM?=
 =?us-ascii?Q?972bzFb3Ra1UbK3wLuVWtVfUde03borsovbarXAeMcEpPwKMsLKFmqG3t7+R?=
 =?us-ascii?Q?S5VykxnOfJQ7TwIKRLNiUsFviZ03/nyeAwIVK/hrG42hoC4vE8QLXMvugd4P?=
 =?us-ascii?Q?haBOmiypyaidwsuAE4JwUs+7HTiQtP0J39tJ+MtSSz61XiSNM/V4/FwqHqS5?=
 =?us-ascii?Q?87tjj4ouU4EG6OC0i99cuc30Z0yq88FnrHOmq+5xfrNNsD4ZtZWFkPP73aFr?=
 =?us-ascii?Q?yRqxW/ccx6N107+UyzOqqn6e?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c302a8b7-2002-48a4-b9a6-08d9631c3db2
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2021 14:18:39.6735
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DHImBnlI3cTrjo84THvfk5D64HkjwEsh2g6TKWiZCcajM4Wt465uzs4SqADDovID
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5272
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Aug 04, 2021 at 08:59:39PM +0800, YueHaibing wrote:
> If re-registering an MR in hns_roce_rereg_user_mr(), we should
> return NULL instead of pass 0 to ERR_PTR.
> 
> Fixes: 4e9fc1dae2a9 ("RDMA/hns: Optimize the MR registration process")
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
>  drivers/infiniband/hw/hns/hns_roce_mr.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)

Applied to for-next, though hns should be checked to ensure MRs are
not left in some broken state after rereg failure.

Thanks,
Jason
