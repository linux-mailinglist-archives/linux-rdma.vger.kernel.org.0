Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F0C13B0CE5
	for <lists+linux-rdma@lfdr.de>; Tue, 22 Jun 2021 20:29:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232021AbhFVScA (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 22 Jun 2021 14:32:00 -0400
Received: from mail-bn7nam10on2040.outbound.protection.outlook.com ([40.107.92.40]:62627
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231297AbhFVScA (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 22 Jun 2021 14:32:00 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KGKfNile10ANenAM8/4wHfZpwvmqGDrCLyarTBhF/391T25wktEPy9U7zUJfubZL/FNkZ/GmfEEsYGp91DtPPGdGWcrbOqxjxQhPCe82z1uYyTYlY/alscGwyuIBmgkXFVpdYDxM388FTJxgggOtpDUyjC4ZntsES2NuySMAaZfMfOlW+FBo1SrXa5XX0Owib8VFrzrvmlfY4toZtHXdtaqK8c607Uk1n34HMdD0B2jz8yuF24OusPqn2+hdXUMEVOOPWgeuwbI7jvKsB2t5AvH+0hTXL0+/moc/dC6Ao99a3mAmHUSQZ+tYKYCsWDP2X8ntD3JK3AgI8eU7lTP3Rw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wRApMEl9ZmVUXfqFuytylU2UjQ0lWVzBT9upNG1UZcs=;
 b=O6ZNa5M9rVPqoUm7IhP0E8E11yzwiwtUpjLk47KqIIlkMSXEWdSv+wpE7b6JhGa8Pk9feIzcafzUamwflg+EAjdOs7+4ZGWRg70J7Eii0d7MrQkyGv4ARk+LOEpgYvkndVw6UrNbhUOsGQbfy4AubMBJBNa91DrOO3k7M8da4UE3uWLninaCUiOoc02ZnI2ZftWCDM3t7/b6Ph5tv7zfalCimqcG7+bxYcfKicriOUEruv/Kg8bhECewXRz+gGwUh9OXvP66w1/0MYMAOq0GsSLZrexWuKI8+ldAh+VjMqmTE+qxbTAFfb5UiekM0dnaCQp3GYWYgMEEh/ea5kHS5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wRApMEl9ZmVUXfqFuytylU2UjQ0lWVzBT9upNG1UZcs=;
 b=MSDCd41uP4KuwzUpBJYT/Ou0dL4pXs2Z9eN2W1QYbo8ID66Sn5lSXM4bWjzm2fXjH1Vv6Of/ThyfGvL5DxriMJlxey8nw4ETW+wGl2Wjy9K5RItWA4u9R6NB85kCtF533AcUnREgDeI/DpeHNIu9W6cA1GYzCpP42JTIFkoWXIVRgfHyydZjVASXzp6aATPKjA8PNT1jf4Mhv04tOlhxh7eUP3/Lp7zPeIdTlwxr/RHX3UdMDwAcQ/v8ATMUy6lHuGTmIid6KR6EN7CP9h7yUO0SscJX4+wjhQlh4Loe8MsZutaxQWMrMNhf9CX1HQI/HwjLe1I0M6gSd/Espaotgw==
Authentication-Results: huawei.com; dkim=none (message not signed)
 header.d=none;huawei.com; dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL1PR12MB5320.namprd12.prod.outlook.com (2603:10b6:208:314::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.16; Tue, 22 Jun
 2021 18:29:42 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::3d51:a3b9:8611:684e]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::3d51:a3b9:8611:684e%8]) with mapi id 15.20.4264.018; Tue, 22 Jun 2021
 18:29:42 +0000
Date:   Tue, 22 Jun 2021 15:29:40 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Weihang Li <liweihang@huawei.com>
Cc:     dledford@redhat.com, leon@kernel.org, linux-rdma@vger.kernel.org,
        linuxarm@huawei.com, Lang Cheng <chenglang@huawei.com>
Subject: Re: [PATCH for-next] RDMA/hns: Add vendor_err info to error WC
Message-ID: <20210622182940.GA2590380@nvidia.com>
References: <1624362836-11631-1-git-send-email-liweihang@huawei.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1624362836-11631-1-git-send-email-liweihang@huawei.com>
X-Originating-IP: [47.55.113.94]
X-ClientProxiedBy: MN2PR05CA0008.namprd05.prod.outlook.com
 (2603:10b6:208:c0::21) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (47.55.113.94) by MN2PR05CA0008.namprd05.prod.outlook.com (2603:10b6:208:c0::21) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4264.9 via Frontend Transport; Tue, 22 Jun 2021 18:29:41 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1lvl9Y-00ArtL-Po; Tue, 22 Jun 2021 15:29:40 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4fdb56aa-db95-40b5-1946-08d935abb392
X-MS-TrafficTypeDiagnostic: BL1PR12MB5320:
X-Microsoft-Antispam-PRVS: <BL1PR12MB532051C5197FDEF0E51891AEC2099@BL1PR12MB5320.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4303;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LOKpk4L5FPP+yL09l4zsxBirf4tf/GSXNPHb91vLTXZZLtgf4ODolsSnl7J/tyaaA72/zwV2MsQV/ZZERwMiHDeTyKtNN4RZFyeYEErDhHwUyOUgzUkWXloJ0SrDbqCtukB5Ral2apUFACOmTq/DtxrRVbke7u0l/FuCXXb+lbHt58hvQlGZPKJQQY0o8kpsAJBYu4F+xcBjPRUNJxJ5ZUoKWfv/vvTk9rQo57XNXRNFeKzYO1kMmRxsCaBU0QBzjfTWRAzUS5mNhLSx3dzeknrnadpe6L5Qfkq6sEZ69e2A+6Ze2Cuh1syeHybTKoF3T6vleM8fl++cUapLF9HqPgV04mMbxlSpSfbS+pMOqafmePQXmUYcWW0AGoOoZzNPiLyIdw6wbYDKXsTg7QvoJABohmVcWvNN7O931Ys5kmaJpiXPOOQVOi7+bSrtyOn+ekYverEL6OqHcdIU/5TN+m6vgKjdAzyeUZjSg8uuQpg9SwPlLNSUmfRmrE7sj9UEwR1PwW8s22kIQceuF8+PB8dGwj8y9eoS7EKG4t+/VglIbq+u6mtYoJws4yd7YWdLPs6iGtAvf8ofu4A/ee6K00dK/Aaxl0aMsOkN0u1FMs4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5506.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(136003)(396003)(376002)(366004)(39860400002)(86362001)(9746002)(66476007)(66556008)(186003)(1076003)(478600001)(316002)(426003)(2616005)(36756003)(9786002)(8936002)(6916009)(33656002)(38100700002)(8676002)(2906002)(4744005)(4326008)(66946007)(5660300002)(26005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?MqE4vXjaCQyv3nw7NxaSDIyklOyDBdGKGZOU5IrSnvGp4kShrMEF45l/QVOs?=
 =?us-ascii?Q?WPZbZoADeCqqS2UnkSVI49AhENK1wZEaqbRKZ6vPBUG8K2n+6v6ewri4LUzw?=
 =?us-ascii?Q?bq0370L5GnTLauOiJ7tG64R/q1/PGrOwAr1OCfRPfSs4U9BaLJpYw7CajG6E?=
 =?us-ascii?Q?6olLSjNa7mJMbXu8fxh6RY8kzB7s/vnSNUrfwF2o3+GprWQ/Tr0Cl/A62BBn?=
 =?us-ascii?Q?N82KAxr+cdNCQu9Irh0C8S+fr1R3ZOcp/99QN9SxW43NvbwbJMwNxMBSYPX2?=
 =?us-ascii?Q?mciiM6wtPAe7urRVVrO0GW5QHVk9WBe6uN1Zi8j6fSemM5Yo9kMn9AdnXy+f?=
 =?us-ascii?Q?KuKh1x6Nm6qh8uCoMY7Pph3ExtriUPSw/V1XHwYzMxkBHTt3fYlkAOmUSafu?=
 =?us-ascii?Q?9p4HV47j4uY6pUVVVy8rEr0MMKiitRzkYbuOQieZgxPUmuCkbhkemEqY6sGu?=
 =?us-ascii?Q?uemRPgHANyn11VJex8ZJnUY2pQT1fIMj3Iyj4mghMJIFf1hK5e1l2H0tAN81?=
 =?us-ascii?Q?nTCXhbZkv7z4Pt0ZLnj9VnBCJBBogTkgDVTUkiwCDDBx91XduiIAtcpPRMQy?=
 =?us-ascii?Q?tAkef4Rr7Y5X7QgvyFLyTmWrOTwsUFY4jO3rTIIMvFKtNZxPt+RyVUw188R1?=
 =?us-ascii?Q?CA2dwU6MiPAgxWRx0A3WultJPRd3yaplBGM1CrElLZ9LlOQqcWnih2jFOqGK?=
 =?us-ascii?Q?I6XtK8r73S8EGGK9JcBrAHfeapocE4ZYdFQyR4NR5QR2TdseLlt50h3AGoLd?=
 =?us-ascii?Q?L1p22ik+3sbIyR8Pp10Bje2ZPWqP9uUJfyUZ5Qw/Ihx+72MP3XiNT+pxePXF?=
 =?us-ascii?Q?KJp25NS3FCKTZ30zmqVHWREihSZTkafUIFukjagz6mqizgrjOMaimwvuI1GD?=
 =?us-ascii?Q?IG2HR3BMVKwisyOmvabbbncMBxxBK3YYtwT0iK52wH2KHTqRzF9b5UYbrX0f?=
 =?us-ascii?Q?fw+LdsBLCoxE34LSLSrixDhSbSNhGhwxc2II3AUoh1fz20cG1NZDpIlN0GXK?=
 =?us-ascii?Q?zM18dcLiPTNtsW36NM8wJ3lQvlKCOreT2kBe3BVmxEp/jyC7MqV4qpvHOPh5?=
 =?us-ascii?Q?r4JjCOEU5BU8qrWs1cixJVICQ7suKi6/dVZgpkMVJ1+QC0iB+AxU+hBKj9mT?=
 =?us-ascii?Q?pj/egJlpjN7L1jWlcuMQ2X3UVgvHh6W5rCZbFZyfRjU+8i3mJtoqgUPt5gMV?=
 =?us-ascii?Q?xG1pY4vs1hgKszqqGzXhGLgn2uGXWMrvIsj2xzZjrQe02sTeKovOW3y1E6BN?=
 =?us-ascii?Q?hrL2zBgibHEiFq9qlXW6KGSA6VrUOxbDxlB4D2pXqyCXHCwBgsgVi3CfS8pK?=
 =?us-ascii?Q?M1FXv7uHw+I/tTgPFijH/AS3?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4fdb56aa-db95-40b5-1946-08d935abb392
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2021 18:29:41.9216
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OvhVFFTV/SIG9DWO1dKuSPdQZfjQU+Dp+g5j1rqw97eGrgVkf5FjIJzhkqPOoAs0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5320
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Jun 22, 2021 at 07:53:56PM +0800, Weihang Li wrote:
> From: Lang Cheng <chenglang@huawei.com>
> 
> ULP can get more error information of CQ through verbs instead of prints.
> 
> Signed-off-by: Lang Cheng <chenglang@huawei.com>
> Signed-off-by: Weihang Li <liweihang@huawei.com>
> ---
>  drivers/infiniband/hw/hns/hns_roce_hw_v2.c | 1 +
>  1 file changed, 1 insertion(+)

Applied to for-next, thanks

Jason
