Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 41D7442C70D
	for <lists+linux-rdma@lfdr.de>; Wed, 13 Oct 2021 18:59:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232145AbhJMRAQ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 13 Oct 2021 13:00:16 -0400
Received: from mail-dm6nam11on2079.outbound.protection.outlook.com ([40.107.223.79]:5441
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S238139AbhJMRAP (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 13 Oct 2021 13:00:15 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f5uI6M+fFbbbJRP0tRWo5b4a0cXD5eGdSfsdxQAft5iXUvA8k8x9y8EaKa+tzj81vM8orfSf4iGQN0I6G7kR2dG04Yj/oUHyeqOTZ7m2hEnzgTkZA7XQgA6x9QnOq5pAxDo0MtXXYYc8OnXU4uARSeRqGpA+RjCit9GylG8IBRzuKyXI1Wn0F+ep2WjxeSgqPSVGGDth6DhismkSSToLHOrrtpMRcIaQOGQ+WkJOl6sNNMGtXycdGfVegstoGxQwCmTb6XlWxp/Tp8RmqLeqOItPvxeNw1Jc2KvE7rmebJ88kywF0i0umahy/5nwnC/gumUp9WGVfHmDn25CQ2jAzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=shprRYY5InN3wupLr93WCGKFKjL4d0EmCVJ//I8Z+cE=;
 b=FqZDS1ab0lv7J0SCc66uJJil/L9iI1d4KnaX09DP+Z9D4SSqE+DEf44pmiSMIae9jPbZ2BUF4rBrYWlU6I0pobaDMOfnEM65tExpE4CzpguToMVIcw8q6ynjjpffVnHJ1tlQSt78//DIkml9LDHhy1fQyAVtdG8hjfwnhPBTdAjmLTjkIdqtHw11Q2xhGVvczHHLAwZZu6orinElV5IYBwu9FtV8rd8chdD0U7Le3MVMBgBm3V9k7nvxtbZMoDZhKGWrbCq1ZYPbwgtRbbx+T8Di5A/YstI1evwJWmtW+2go1a3SIaC5ZM0nnxCFqWzNwv5eWl0h+NwMxgbz/Mdn3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=shprRYY5InN3wupLr93WCGKFKjL4d0EmCVJ//I8Z+cE=;
 b=CFg7/htOJQgtx9+PNlMNWBtlgYufHyZ8WHyF7vSnwjzCRhlYKOBHBGlauqrpQCLu7q2Tg03e92XKLHtFBgmsyD6QFTDdKFsGuccnsA2/QZK84LGnPkLCY9yeVduEYhC6yE7iF/Fn1FgNnLCXEfToESBKFmA+jJQEost5UO5P4hguH+GCmvIs7zL0s+wXVw+fT7461fPVbSNJSuM0PoEiL4OhPCL046UbRtSEDV91BjOVd9/Harcft5UIytFWiH7u3ZuElykRJmIGIBHcTYWhk+1y6yFKia0s3gaRFRLkE2GxobPhW5pp6b0PnBEUSAiaukhGfHtQffllpJYwZ3eBrQ==
Authentication-Results: cornelisnetworks.com; dkim=none (message not signed)
 header.d=none;cornelisnetworks.com; dmarc=none action=none
 header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL0PR12MB5556.namprd12.prod.outlook.com (2603:10b6:208:1cf::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.16; Wed, 13 Oct
 2021 16:58:11 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::e8af:232:915e:2f95]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::e8af:232:915e:2f95%6]) with mapi id 15.20.4608.016; Wed, 13 Oct 2021
 16:58:10 +0000
Date:   Wed, 13 Oct 2021 13:58:09 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
Cc:     dledford@redhat.com, linux-rdma@vger.kernel.org,
        Mike Marciniszyn <mike.marciniszyn@cornelisnetworks.com>,
        Ilja Van Sprundel <ivansprundel@ioactive.com>
Subject: Re: [PATCH for-rc v3] IB/qib: Protect from buffer overflow in struct
 qib_user_sdma_pkt fields
Message-ID: <20211013165809.GA3477175@nvidia.com>
References: <20211012175519.7298.77738.stgit@awfm-01.cornelisnetworks.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211012175519.7298.77738.stgit@awfm-01.cornelisnetworks.com>
X-ClientProxiedBy: BLAPR03CA0129.namprd03.prod.outlook.com
 (2603:10b6:208:32e::14) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
Received: from mlx.ziepe.ca (142.162.113.129) by BLAPR03CA0129.namprd03.prod.outlook.com (2603:10b6:208:32e::14) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.25 via Frontend Transport; Wed, 13 Oct 2021 16:58:10 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1mahZx-00EaaF-HS; Wed, 13 Oct 2021 13:58:09 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bae5594d-2df8-4573-59cb-08d98e6aa344
X-MS-TrafficTypeDiagnostic: BL0PR12MB5556:
X-Microsoft-Antispam-PRVS: <BL0PR12MB55567DFA32D3AE063A35103AC2B79@BL0PR12MB5556.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:923;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6PdiFLNJlGbnvfUBxgFccwc/0rWNo8cC9JuagVJF0OBFQYxyLfOGupKD3sdkDbzuiXGWOuS2yVv/oezfP8GEVDQAL/jaI3Rs8kqEEp3jg0ITBlsVGkiwjyBnkyRspExAxSNYiqwI9ClYX2Tj8FPvhjXbOA7mkH/slWFTQxdX7LZ/Pnst2sSSG6vqxlzb+nxpe5BaWz4sMOlokDzvpYXQB6xTXXNiSMZSsX7XFRZC+3CRnWnQMEMqqyesGe3fZoMWc57YPZlX8p1LX5rngzeW99ykJypFFOtKAsNvsJFwXP+F8hKqYorLEyKzUSKxffa3LbY7e06EM8QNLzMjyJEkqd1UGfV24ElN9kroY5asE/96dAvVGxdVqwPvzo72tXcznKjqfM2x80tBBtRG1faoH4I0gXJM+iEalljxydAsGSc55u9Z9lrAEFCodjhZf4f82b1P6899U0N2u28vYOhf+r1TNE5llAeoLiOhTD0ambGnJa0nNROSYuYjWuaJqINaHdIUXUPz/zIo4gCoBS8sC9fADsmKWHKq/q3Xl/veTyU0JOqOpREZFPXa9G3dRJcCKxsQ31R0imD7MHhT+5acMGVtp/h3bRcrdcdivTBx7dvBKmKuaJmqWyveN/QtvtPBLRKayZfIsbcg0TRD9OkoCQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5506.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(186003)(426003)(26005)(83380400001)(36756003)(33656002)(38100700002)(9786002)(9746002)(5660300002)(2616005)(66946007)(66476007)(66556008)(1076003)(8936002)(8676002)(6916009)(2906002)(54906003)(508600001)(4326008)(86362001)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?9YaCWQm5JqlcOR++/i+YJF4ezddwFybwbAJ3b0bhaxx+u4vIRHQcqBtVFL9l?=
 =?us-ascii?Q?Z9y7JMRB0zpy1Rh5M+ukj5w3Gno1ke77Ufj2ErUN+X+h4wE3YpCs7xrwsbJr?=
 =?us-ascii?Q?hVR4lGmo0hkmzZp7/EQqQIoiIVFry4aC1kQLIT+01/aHvF8Vs0V1L6lveIXp?=
 =?us-ascii?Q?I0R/9sLCZixC5qea0SqhlHqjGJucuttnFniGWUipK9HQ+5wmFfDkazTfHuHd?=
 =?us-ascii?Q?CKo2FqLg2TsEgcemE/WUUlYCjRRRPrd4YvO964LM4E4iAsrNMQiOumB45uoM?=
 =?us-ascii?Q?ONWkDl/8cxylwkq3tqZ9Vj4zWc5lSD2R8Lfa4NGtz9x3FyrNeT7tBpCEotQr?=
 =?us-ascii?Q?W8THIlaQzQT/rsE1jbSouKdg+XnVSoMqv2KdI0XjImNRvhtU19/Sbc3BGr0W?=
 =?us-ascii?Q?MZ6JFmio3JWB7UwHzFgyxoBimF/OcVJhQsGpO720P/OhcZ9M33KfsmmLGCmf?=
 =?us-ascii?Q?rXkaeCHvNjYE9Gz4qkm3R+CUg9eFkl+cUZdyl8co256BjOY+InBouaZ211Kb?=
 =?us-ascii?Q?HXl95EE+bo+A+WIFZRbgcmZJb2l4PgSCJZ+e8wKuvbAUu2WJ3jmqmzAAY3Y+?=
 =?us-ascii?Q?C5cWu0Z53ooi01BPAoNPRiBQM/h5weRvBbwXo+SqivXdaGBp7TTsD4m87ahF?=
 =?us-ascii?Q?qmnf5sGHfO+pvEySd2xtTyr1pGkXlcfm75xVv0nTNrOfsgbUzhVWf7CHk6tH?=
 =?us-ascii?Q?dHFQRLr4uG2Zz0brbfUKBY2c8iU0riOv7BmM7WJdoWQOH+/dD2vM13hm64QR?=
 =?us-ascii?Q?qgTMLZLk/cu0LyRnH7PbNEExfEI2uCGhamLSlJTTb4SpnFm75cEOlOvPOHx5?=
 =?us-ascii?Q?H7SjV6zL2UdSW4zgJjvn9vv9Wb/T2GOYrXIeXUapxhOfUoUJ3Zsh1G9ufHTs?=
 =?us-ascii?Q?NGWJegYFsDnXrs5C+ejQfIgl9WwiRSlBodh+uMhd4b7+L9u8onToMq92nfpH?=
 =?us-ascii?Q?+rOUYRhuqGSMDjMMMoHN15w2kHKJkVjmBc3nG7EfVP+UQFhgVuWYUVSmSi63?=
 =?us-ascii?Q?id3uf1gRwQLk1eJCMtN38uaxfx/Pwq7QmEHAdbWLB6RKcE9/rNUOpeHbM5WJ?=
 =?us-ascii?Q?/6eUu8kfnxK9PA0J2rP2zprhtfzCJ+JfnKHDlYMk7zArLMujM25gUxVQO7XI?=
 =?us-ascii?Q?ISr9SAV17Bs2lRIIougFaL7Y4EvDi7EhGPFlcxizpGozSNk8umuoB4Oge3Nn?=
 =?us-ascii?Q?wdbnmY+J1gwFoGyEzMFYPGBLxntW5uywKaMX4jq9mnWuWfUkss2ltk0kAkFp?=
 =?us-ascii?Q?eWEd34LwxhAag0aJZkNeVZ6wpjzt0kP09P+SImQUkahxVNoHfL91ypqUN06H?=
 =?us-ascii?Q?u9qrwKxbi1ZMOQDCehvxrVr0KE1pDLgcMMsCkneXtYdg5Q=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bae5594d-2df8-4573-59cb-08d98e6aa344
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2021 16:58:10.8798
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 02tfiDt+Rsa1gKPo/78zdOI5G9JEuMJNZbPr+p8Pb8b20LGfi1hC9Gpv6CoIJ0af
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB5556
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Oct 12, 2021 at 01:55:19PM -0400, Dennis Dalessandro wrote:
> From: Mike Marciniszyn <mike.marciniszyn@cornelisnetworks.com>
> 
> Overflowing either addrlimit or bytes_togo can allow userspace to trigger
> a buffer overflow of kernel memory. Check for overflows in all the places
> doing math on user controlled buffers.
> 
> Fixes: f931551bafe1 ("IB/qib: Add new qib driver for QLogic PCIe InfiniBand adapters")
> Reported-by: Ilja Van Sprundel <ivansprundel@ioactive.com>
> Reviewed-by: Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
> Signed-off-by: Mike Marciniszyn <mike.marciniszyn@cornelisnetworks.com>
> Signed-off-by: Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
> ---
> Changes from v1:
> 
> Incorporate Jason's suggestions and update commit message. Also added on the
> fixes line. Mike identified a different commit that is more directly
> responsible.
> 
> Changes from v2:
> 
> Remove unnecessary hunk.
> ---
>  drivers/infiniband/hw/qib/qib_user_sdma.c |   33 ++++++++++++++++++++---------
>  1 file changed, 23 insertions(+), 10 deletions(-)

Applied to for-rc, thanks

Jason
