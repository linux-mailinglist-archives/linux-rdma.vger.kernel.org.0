Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD61C37AF6E
	for <lists+linux-rdma@lfdr.de>; Tue, 11 May 2021 21:37:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232058AbhEKTin (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 11 May 2021 15:38:43 -0400
Received: from mail-mw2nam10on2059.outbound.protection.outlook.com ([40.107.94.59]:62593
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232215AbhEKTij (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 11 May 2021 15:38:39 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hkXaL+2haK44/Axz+4vWAGlvUliDEWDiWRaBXq0De0cFDkeuSU5j6B29EjcNX0vSqhwf8RQ2NR5CmDyUNHkW4mdo3CFwDZG92V/zHtF5WnRG8aZAC7h7O9CpGtaDbvqrgiDbjXJu/Eq7y7JVQS52AS3aay3+fFGoPuoi3E27Q+tZGsOrUMINFASLkh176xrvngjYwvRNUh0ZKVm48TJdUZkl7H7h0p23IYPvd7wIUfA2mB852Jfwo4l+pJZ4ULYQ6yMg6QemMSx0fEa/vwx+IHGRGli3PHivKpXWkYTfbe0zunZOXOZXO4V4fmE81Nl0kqdFeGU12v/4laA0tlOHWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pSYTnI5VXjj9O5i2LWPulRcWKH+pF0BuHQzI+xVQ27s=;
 b=EkGEJ+MvWPOO+kdDE1EVi4ggNTkRjLNE8oSuDUKTWmvzNkztfX3Y1s/OwEmnfzT6ix7Z5njwI1l/XqKbIcO79CHE+Dm1mlZEglrpRzftxSeT7eJDwbgRmww7tWI2xrZhAftJ8wB1tESWXUpL77rHxiFd6iWa+OvwOGU1ZA2tnR8OEPHktTn4i6SwpNYNqz5ui+dAwwU7oss0VxOA40ltpv4oiUmkKnqXXignvZlpPFWaJsEyNI5+B0hf7+FO3RSB0YFBuAuQoY0KQISdSNmeuCroJrH7pIu7A5ja6HdadlsLDaczDyrNxdl5UcNyi2/PZgVjenQ6b6VUKwzW4735pQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pSYTnI5VXjj9O5i2LWPulRcWKH+pF0BuHQzI+xVQ27s=;
 b=BT2fEmWHu20FFRRB5kqLhgjzQ1UogBYobo+xOcrKeVHJFxvdMAnta6qf9QWL3V7H5f+SnclIUGQF1y1KBbcVr3Hc6PQhljWtakPaLveR62w/8xb3q8QkN+lJt6FKEQVNSEQPR4aBIzQAArUj2QBI0YutU3S9m2Gg9R7oIjGdSx71unnlna6QFrDv9CNVFlxijil+OiJ9kOpyIgptRHQSSCsEkV6Kv4OgQtQKhRi6adbVqr8NxW90pWVUazgeRPECMpntDxaTt4pDdUHxLI4V4D5qrVpH7E1CSU4rUjGk51ig7j5ZQ8zr9umNMZ3OwJsVVq/4F89AsMAQ8A/df0EEyg==
Authentication-Results: linux.alibaba.com; dkim=none (message not signed)
 header.d=none;linux.alibaba.com; dmarc=none action=none
 header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB3835.namprd12.prod.outlook.com (2603:10b6:5:1c7::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.24; Tue, 11 May
 2021 19:37:31 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::ddb4:2cbb:4589:f039]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::ddb4:2cbb:4589:f039%4]) with mapi id 15.20.4108.031; Tue, 11 May 2021
 19:37:31 +0000
Date:   Tue, 11 May 2021 16:37:29 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Yang Li <yang.lee@linux.alibaba.com>
Cc:     leon@kernel.org, dledford@redhat.com, nathan@kernel.org,
        ndesaulniers@google.com, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com
Subject: Re: [PATCH] RDMA/mlx5: Remove redundant assignment to ret
Message-ID: <20210511193729.GC1316147@nvidia.com>
References: <1620296001-120406-1-git-send-email-yang.lee@linux.alibaba.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1620296001-120406-1-git-send-email-yang.lee@linux.alibaba.com>
X-Originating-IP: [47.55.113.94]
X-ClientProxiedBy: MN2PR16CA0002.namprd16.prod.outlook.com
 (2603:10b6:208:134::15) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (47.55.113.94) by MN2PR16CA0002.namprd16.prod.outlook.com (2603:10b6:208:134::15) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.25 via Frontend Transport; Tue, 11 May 2021 19:37:30 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1lgYC9-005WPt-It; Tue, 11 May 2021 16:37:29 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1c3e0664-2a02-4e91-8b46-08d914b4377f
X-MS-TrafficTypeDiagnostic: DM6PR12MB3835:
X-Microsoft-Antispam-PRVS: <DM6PR12MB383589A28ECACB0B9E19A2F4C2539@DM6PR12MB3835.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PZ2pIurdfGUdwCpuXZE8b8lHDR+TryQIkaDUI5BFK2x8Vk41umhnU9oAYK7w/1VHi+WEHC8soPIAqbplPVcbyTN5Z2fkIFI7EfRWjvxWR7TOTxI5XY+br+AXKvQOesrz3roi/fYtF8SnzYkfMJlzzMBBUB+sBU9FWys6gywOtEqDujWXs9aXjH5LpU29EbQu1Q/7lbk9ytak6pQ+MNwWag7+OpRR/H/snKNy4OPLqJ7WYZGvG1ykJ7jCrFi9H7CudNgLiBFEZHhTbg8tpnDyQAYZC1eNQBIrIVvVj5AJgd4eldSaxj6ZWe/lktYmT60vgnYfkFzNifL2q71zXW7yoNWiF+Zkq15gAeMMwlnzZ27euNOjcbzvhXwgv+HMH+KdFa9rcD4p/vb/p/j5RJGmeRqP4zFTYqIf0+UCRdZBayiZWWpYwSPqaqXaJTKVviy/5nq+fDwio9Jm/pVn4GWClYnV7jxaU1TOub4zJiTRuv9+4jYkOYaqbTM5aIyuj2kk7H2vPCPrTFCdmeHAr9FhVYF/QJH2TWwJ0ZFZZ/alotdr4IFFzrQ2Z4wWT/kKjtai4gJxsg+MceGYXklJwsPybgVFBLxeXmH79n4oIN30q9g=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(346002)(376002)(39860400002)(366004)(136003)(9746002)(9786002)(4326008)(66476007)(5660300002)(4744005)(86362001)(66556008)(66946007)(33656002)(8936002)(83380400001)(316002)(426003)(1076003)(6916009)(2906002)(8676002)(38100700002)(36756003)(186003)(26005)(478600001)(2616005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?80A8bmkmoMs6VuTXCbKw5yRec4clVeRuDCWPBMR9/2hWM4Gr+upmysy1k2ck?=
 =?us-ascii?Q?cr9oQnGRD8+OgRnf+EjSIqBgNwPmzYaGsxd91b/kp3nPA9VgSkNZuni6JlIO?=
 =?us-ascii?Q?DJyAA1q3KucSrJQhP+HXBLaL4iq1rMztikaafbPWwjRL8buFKjk0viIX5AN6?=
 =?us-ascii?Q?FePbRNQ4In6a6w/TirL3FXjJgqUqO5piY5TN1MUy7GDuR2ytCkviGFzqnIv4?=
 =?us-ascii?Q?dLnudggCZvrGWy4fscppE66TWscSaidFUle3nXT/3P8Gw2qqWXeCOKJ+w5U0?=
 =?us-ascii?Q?gb55QPqiLJxpStcRpU4HrKYI1UzwaNRE5JFVUqxHN1ku9cvKHsn32s4bk6ey?=
 =?us-ascii?Q?j5airZQjKqARXlxQd77NN3YtobodMT5zz4W1pZxeVXxfeaHWY7ihCoborj04?=
 =?us-ascii?Q?aMfaY33KeyLisbk0Exw7bHRavhbt2CYc6KpxD2oHdfgvWc1taO6o4k1xikbo?=
 =?us-ascii?Q?AQ0yJwzZvriA6VoRgWrqMlb4UbXhvg56f8uyqkOWfW2TPg7OmWyft5NlJQ/6?=
 =?us-ascii?Q?HKdGuHStvOx3uB2u6lB7U5YPEqP0WlQMSHG3ZIreTFkns4wGXUWSW2+jMcAO?=
 =?us-ascii?Q?K9nRQOwAZpZ6jMfHmXU40vvE+Oy2kEfACu/dQSHGAxgQawZZj5yFPU05xEvt?=
 =?us-ascii?Q?I0PvpKpRIvxiY4pA9DJwwRMOsljssKAlsq3XL8pi/8nrx1kOLBcxwswSKHVJ?=
 =?us-ascii?Q?QVXhs9hsRkwKnkdiDPd4GcX9o5y8ilaPlyhWBPSJ0VkzZN+PQNW7BulHpMYo?=
 =?us-ascii?Q?BFefpVA1fYTh+D6R+G74h8LPSSrKy5OJwpqk1L/Gea/0iVY2FIxz4UfQGXay?=
 =?us-ascii?Q?EjEwHVCC59wUJ60JRyTAr9StS/4GpkUZxWcePG+yHJayYk+MZRx6RiYWNRb2?=
 =?us-ascii?Q?mRu7uED6YmRu4NfLfFSNn+m2nvmmn13tsCKopHrJSjFwUa/Rm/0g+9QN9Spy?=
 =?us-ascii?Q?rtvrEKLEfsQdmoyHy+M0IMmU6maum0PRvCYfb1h4yd/3PNhQYx4lrl9Ydc08?=
 =?us-ascii?Q?n0BwPfAimEk4ZDmbZazcaINAuMZx6ZZBrvP5Mv2xMCgWk03VBX81VJOdf2A1?=
 =?us-ascii?Q?uxtknG7tmSz9n9f3USgVo+lnyh96gzMHYFXLFQ88yq2KmQN5RXBHBIvccy6j?=
 =?us-ascii?Q?jS8fDOKGxETkGvog5qLIzyvRNAMoCZzOid/FJCapcU5ZOvOM1O0Q833A98PI?=
 =?us-ascii?Q?sR0V9XSn1Ri+8nsjAfr9fuc5E7MA9PAfroJ0N4X1SFB5UCPzhc4xfZxYaaIJ?=
 =?us-ascii?Q?KlgxHqyxxvrHsw+HmoOMLtE/48SxXbyaqlb8a6oqq9FKM12onwnIuZiv19Nl?=
 =?us-ascii?Q?UFZkSUPpN9Y4zaMCr5nhtqWS?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c3e0664-2a02-4e91-8b46-08d914b4377f
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 May 2021 19:37:30.9159
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: g7RJvd1KtQxPmThzDkgi6VXunZbZhkplRRQOXRlKH35BbrVkswYOULB/jdJsPJHg
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3835
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, May 06, 2021 at 06:13:21PM +0800, Yang Li wrote:
> Variable 'ret' is set to the rerurn value of function
> mlx5_mr_cache_alloc() but this value is never read as it is
> overwritten with a new value later on, hence it is a redundant
> assignment and can be removed
> 
> Clean up the following clang-analyzer warning:
> 
> drivers/infiniband/hw/mlx5/odp.c:421:2: warning: Value stored to 'ret'
> is never read [clang-analyzer-deadcode.DeadStores]
> 
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
> Reviewed-by: Leon Romanovsky <leonro@nvidia.com>
> ---
>  drivers/infiniband/hw/mlx5/odp.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied to for-next, thanks

Jason
