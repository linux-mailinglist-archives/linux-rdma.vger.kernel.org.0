Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B8333F1F5C
	for <lists+linux-rdma@lfdr.de>; Thu, 19 Aug 2021 19:47:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233416AbhHSRsD (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 19 Aug 2021 13:48:03 -0400
Received: from mail-bn7nam10on2044.outbound.protection.outlook.com ([40.107.92.44]:65120
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232456AbhHSRsC (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 19 Aug 2021 13:48:02 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fsvKFB4T4EuRHC0MChcVJWSoqyFruN+WGmUFFUl6gzSiw5AJqeL/D/ka7xM1VjaxOFikPBru91af0uNsqiREuPf53hmcJEM3eu8JtEesrYfRFMpmW23qPlJPuO5jboPJqs/TOWHjdWqTxwLGvMar2pxO2KKgicVzvbldCKjUwMJ4BkgbdK1RyGlRRICOwkAbFJF6BwnuJ28i/iJGHPgmGe5SrG/gjPipFziSol2ZdU2mvGcltTTa2UAb0I+Mq/UOwU1Vir3K+Krr5N+zqpJORTQ/fnZdnF9N4tKP0MYoY4ndvejOWZYXznGMiykvHwbOKwb6rS+SppRFglCyoQVtiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sIKC3moMk0iUOj74gnbmwSpRw7BfSf/+vXVaA2cXH4k=;
 b=URd0wEjbnEURtYtpUtt8dMoMQE6BME7eRYTKd7K3t/86kwpO1tLW5Ex2gMj+9uSwzyeJuf6E9hjksEGvVb2PED8WyJjl9H+swVeuBGeNzImb5nkLTEr4zWBRyOaf7HZn2QQrDV1xdP1B79veuKHi4aKtJso6BeNdpjdAA5VaqzrRg6Dsg7zRCnn/bjy5Tr8es86B7H4qO7B94djyPJmaOSaU0Xofwwo/grfCWgHllOrJ8FnIvVmh94fcBf2LOJFJeuFmGo29rkt6d5Z5qub3J3O52Fh/5ctVmGhxnL617isJ9C3Il3c+rq9or7C1b6imPerPtqikTJPhWpqS5yEHyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sIKC3moMk0iUOj74gnbmwSpRw7BfSf/+vXVaA2cXH4k=;
 b=pAKPlVMJHAzGxWohL7Dbcm9cKX09hbqdjgZXPVQHp85L0KQSxeWgZ5Pb1rvpqj21vpmyIqACecUFR6Qm1V8jQQXTtY8FGlCgy8IDJSOFlj2vIMEdLWs4E1MOeBAmDD6YqFuwK2WlxzGoJgdHTO0RSOZUF2d6OoUl3EwJGh700BPehG3a9nRYFXaZwo5gDxCCPJ5td4ZDqRFzS43hQsYZ9owuU32cm5zeCnuajVc3+zxIdjUMLodExByWodWkMar/ZEVYNqX2VifuQDu7Iyu/zZxpcflHIGm4W/DX/vU/iSY9Oc/jBa/lgGQ+StBLS/o6ss44qQTnzqi1rb3i/djIKg==
Authentication-Results: oracle.com; dkim=none (message not signed)
 header.d=none;oracle.com; dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL1PR12MB5191.namprd12.prod.outlook.com (2603:10b6:208:318::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.19; Thu, 19 Aug
 2021 17:47:25 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::1de1:52a9:cf66:f336]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::1de1:52a9:cf66:f336%8]) with mapi id 15.20.4436.019; Thu, 19 Aug 2021
 17:47:25 +0000
Date:   Thu, 19 Aug 2021 14:47:21 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     =?utf-8?B?SMOla29u?= Bugge <haakon.bugge@oracle.com>
Cc:     Doug Ledford <dledford@redhat.com>,
        Leon Romanovsky <leon@kernel.org>, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH for-next v2] RDMA/core/sa_query: Remove unused function
Message-ID: <20210819174721.GA361793@nvidia.com>
References: <1628702736-12651-1-git-send-email-haakon.bugge@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1628702736-12651-1-git-send-email-haakon.bugge@oracle.com>
X-ClientProxiedBy: YT2PR01CA0013.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:38::18) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (206.223.160.26) by YT2PR01CA0013.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:38::18) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.19 via Frontend Transport; Thu, 19 Aug 2021 17:47:24 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1mGm8P-001W84-U9; Thu, 19 Aug 2021 14:47:21 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 337ca5b0-b0f2-4953-1055-08d96339671b
X-MS-TrafficTypeDiagnostic: BL1PR12MB5191:
X-Microsoft-Antispam-PRVS: <BL1PR12MB5191772EA929CFCB6670AC7AC2C09@BL1PR12MB5191.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:826;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9UfMnXosWYosyXrICydlCmzh2fD4+Ia4AtpbqM2TATE6vQ0GfBp7e7VhFki4LJTJLxZAx5UDnH0rDtTXiIV6utPcg0RK/yNeb+FOjTAsR9duS8iIGeCyif0bcWgGAdvLpsjikqUp0rnUE18dIdKPbEEH9wRXJPx/754t0IL+Mh9I7RqMCLYRjkIg4wchRLo+fKOckPF+OmwkJ2w1n+mu/8U1HSQ+KcgXO1a3mHCujbGKTihBJW6STqiyBamQensfoBHCRwMfANXY/+mixm+61V6+N8U0mNusl/Txzym0+kpxa6WlnnJw8ijDHrkz90XYkfX5aJ3vdgrIou+POF29mow6nPM8oAaMWqIicWRVfumcI6VdBGfYocjtDiCmdsUdl2OsCtt1axWH34EWWisIwBmayXRMALhSx87gX+bXmAccjJNC32aB6WT55fS/hJbDGwSkp3pHbBNgvFMq+aCKJQVE/wbqvDC7mBF++k0N9y6WUUGHs6jXH5dHIgKdBvbaNvQvG5vcIrbPCUCbsCZjaAbMtfSve7cPg2Y/I5Wwfcxu+BKtb0jsS9n4gm3pyXrDxHcpq8/RjZH8hmGxPXlzF+VEQwfjw14FzOzJr6O6q3PluOT/P1ePej43oO2gRFVW6+LKb2L+HSWT8VHu6OB5INLSvpBw4a7O+rVfieSU6XqKMmnB6pdMtU1klRFPNP9S4TmRgmoDSEuYh0/duNH6iQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5506.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(396003)(366004)(376002)(136003)(39860400002)(36756003)(66946007)(9746002)(9786002)(33656002)(83380400001)(1076003)(86362001)(38100700002)(54906003)(6916009)(2906002)(5660300002)(4744005)(316002)(2616005)(478600001)(8936002)(4326008)(186003)(66556008)(66476007)(426003)(26005)(8676002)(27376004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RGE4UEhEOXVVSmFIbkxQL01PMW45K0pvQ2lhdld1aUJFM2lmSEc3SWllS3No?=
 =?utf-8?B?azNSc3dpR1pBQjdTQXk2cGxzUmthUklPUUpvM1NlOTI1MUZuYS9sSnZSQURZ?=
 =?utf-8?B?RmRnTThXdUNwSlVBakhkYVRRenNBY3RnTjdOQ0xkTC9UTyt3M0VGTDQrYVdW?=
 =?utf-8?B?TVVFcHpORmFRQTZSbGdTbWpTWXU2d0JudEZKZVE0SHhETy9Jc1BMMG84dWxE?=
 =?utf-8?B?ckZ1aCs2MXhyNzB5R2pSTWlWTHg3U3RkVmwvOVNQVWluQnBBZkRWNlhVaXBn?=
 =?utf-8?B?eXIycG1NUFZyZjMxTUphTmVlRlVaOXJUT3JWdnd5MSttVTNEbkVIZkRKck0y?=
 =?utf-8?B?VUpYU1lHc2pIc0w2Z2NKNzlTckRxNmlBSXVZcjVFbDJWVWhwTks5dWoyT0N4?=
 =?utf-8?B?VlN1aTVNbXdzL1NGL3JHYTBad3ZmeCtZMFNJSHpwYTZKekxmL2tRMGEvZVd3?=
 =?utf-8?B?YmdVOGdORGJFTmdzUGcyQy9Yb0d2UTBpeGFkekJYNEJURWk0UW91ZXpsNzQ0?=
 =?utf-8?B?VHVScVRPQjVGSkhCTTRBd3d5b0k4SXgyRUYrakJRTHFYem56a3FzOWhxVE8x?=
 =?utf-8?B?WmZGbnRpWWVrZWdlcW5ZbE1HSXFoMEx4ZUs2am56c1lFQ2ljWGlrMnBoVUVp?=
 =?utf-8?B?STdzVk0ybkY5Y2xUMFF5UmJ6T2FESDcxVGJFMGZQdysxOG50QURENXBadUdU?=
 =?utf-8?B?eGdnSFlabGhMbjF1NjJQK1JLOTFPZEQvVHRuTnNROU9KQjY0SVMxZEJIbzAz?=
 =?utf-8?B?UkdlRER5WnVIQWZWVVJPMC9IbWUzNGRWYjRwL2RGZEg5SWo1V3d2b2FVU0k4?=
 =?utf-8?B?K1JwcFFrZWI0YnJ1bzhKS1Z6eVIrK3JEVHV6MzFkMlFBL1kxcnFjQlM5U05V?=
 =?utf-8?B?dWZxbXJjcnNTS0NZZlMvenZsMjAra291R0czQVJ0QUJ3T0pDZnQyUHd2NTM3?=
 =?utf-8?B?NTJLMDRldWQvc2M1Vy80L29ISE1xMm9KbXA5MDhCS2dVSzVlTXQxdHJyS1R0?=
 =?utf-8?B?THp4dVFvcStFUjBMMkIveE84WTJQWEh3VVJOenRIRWNxcFJHTW9iK2lkc1Fy?=
 =?utf-8?B?bFhLOG85d1pGRVkrREU1bEp3N2w3dWpzVWh4SVpCVnRXWEFsMTUxc3h6N1Ji?=
 =?utf-8?B?Z3oybk0vQjdEK1pka0FHT0tuWFp3RCtjNnBnaUZ2SDN1SVllTi91dFdUUU9I?=
 =?utf-8?B?UzdNT2dWRThiV1BDRXpIQlJNUGdQQXBwYkJPcnkyZCt4SzVCYkdIRWxnWG0x?=
 =?utf-8?B?dEk0RmE2b1cySGxrRDU1NG44QWxJWmIybUFub0ZORDlndVR5N3VXQjg0MlVq?=
 =?utf-8?B?OUNsZ21Ya0dhaEIyb09OelIwOUNBbHV5akdseW9veVhaRVBscE5EaTR5Zlc5?=
 =?utf-8?B?Mk4ra3NWZDNxMzZENXFialZZOUxWMzVTOFpoQU83S004V2lvK3pMWUJFalBH?=
 =?utf-8?B?VUFsekFEVUU1TnZlR2RjUGpwakdvVXNkeHcyMzlIMWEvUHoyWWNWQnJSMzFS?=
 =?utf-8?B?MVRHVHRybHlEd0h6T01oOXhwK080SHFzSXk2Q3dIemJxQ3IvOVF3Mi9Zc24x?=
 =?utf-8?B?Y3k3TXg2ZDNoVTZXUFV1eEF3ZUtKeG1mbWZFLzhBTktWUlpzWkFtTHNTWi9L?=
 =?utf-8?B?MVlzS0l4czhlZS9PMTlpTU9OVHhUWjRGK2F2SmFveHUyekdiN2R0Q3k2TkZq?=
 =?utf-8?B?RkVXWS85MzlOckFOeC8vOHR0dHdMcExjZHhOeWpDRjBJL0I2eGF3OTZsRzZJ?=
 =?utf-8?Q?B3IwSPbH0bUsKBSSLvLcH4spFyDN1mJzfO3X6KA?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 337ca5b0-b0f2-4953-1055-08d96339671b
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2021 17:47:24.9473
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: umQtoCexXpwBw9nBXhohdGMREmrEfnlthCxeR1P+wI92NcHwt5ovuSD8hvgmUMvz
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5191
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Aug 11, 2021 at 07:25:36PM +0200, Håkon Bugge wrote:
> ib_sa_service_rec_query() was introduced in kernel v2.6.13 by commit
> cbae32c56314 ("[PATCH] IB: Add Service Record support to SA client")
> in 2005. It was not used then and have never been used since.
> 
> Removing it and related functions/structs.
> 
> Signed-off-by: Håkon Bugge <haakon.bugge@oracle.com>
> Reviewed-by: Leon Romanovsky <leonro@nvidia.com>
> ---
>  drivers/infiniband/core/sa_query.c | 177 -------------------------------------
>  include/rdma/ib_sa.h               |  24 -----
>  2 files changed, 201 deletions(-)

Applied to for-next, thanks

Jason
