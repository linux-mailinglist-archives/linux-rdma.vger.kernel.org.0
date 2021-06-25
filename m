Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F05823B4640
	for <lists+linux-rdma@lfdr.de>; Fri, 25 Jun 2021 17:03:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231680AbhFYPFg (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 25 Jun 2021 11:05:36 -0400
Received: from mail-dm6nam10on2051.outbound.protection.outlook.com ([40.107.93.51]:16418
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229940AbhFYPFg (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 25 Jun 2021 11:05:36 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j2+3vn5ghfs2m2ExFNU42rb/9QtEZIy9akWTBiRRHkiGP4rD2a6LZ0KigGeWJgD1J2Cp0KEFk+rs7Ei0JFJF8yT3Impv9y+DzXbnZ7WtSMH+OmGNEIqrQjzk9u6N7UshxMiEZCccVhfmGQV+Y5mCJqj60SXQbAvD5XvGkFj4V+qb7DV+X6zjOazaL4YXtCArgUWjhYZe/dpr029lx9yk2ic2K6yuu+hLDG1P5dcNjfO2pLpp08ToxU3k3MeuDEKySNrEX6jssAJa2nD7/YawlurolWHAnB9X5JRPkWzx3TWUgVHurX0apg7FVH41+39bZgStpbNE7i15dNlg4PA+kw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QPlZx/w2BWs7HT5UDvtTlfbGdpewnFSMG9h7OE9zsFY=;
 b=O6jmu0JHrBo3TAdK9AThj44ZL+gbx50a3ph4OzDFB96NDtEsTk/lPcR8tIzFvNRn0cvWRM27c8cVArf8Eymth41BrtPRh5xAGaYtqAQG7DHJytRDzN25azuC6bisYvPNJJh9LcsVdgAH7/4PxCGfVuQy1Wsw0OE2CWDPSphIhj4z9Rxq6PxcgEZZkxq3CmWkPljUArvlkqb9Ywv8RbeyAi+aoxI3NyrD8V9RfiPUCaP2EmpIijBBRdkT3OAocJ+IqWoVb/1nmE3db8Ruod8BcQmMCuY2+uLQK9WPHGeze83aJeKDZwNeC+TcgQZp3ljwxYndm7o2fw/ENsGwQ0B9YQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QPlZx/w2BWs7HT5UDvtTlfbGdpewnFSMG9h7OE9zsFY=;
 b=GUbOlfqAgVl331ndbSiquDX8UGRCKoOlLKGiCGQ6nvK/BK0ul9rLHe/Xl1Y9H2nRWZqrIRo4Uq1VnJwVRu7AxvmDDNQ5QGiYHxS6nuc2QBvAJbv8yTxHGd5IAoUKpbg0tsXeeVB7Vd0gyM1TJwptZfp2KcetxWCfy+gGPMNClfHgTvD5MR43FO4cm66g0ILhnFZEwNMDbSln+Kq8cn6sbZNDbjlqpLpuV3IJ02K53m6GdxGeqxSvEl9NRvCHv8y+OyN9Ql/2ajH0eFrU5N9M0L56/saTfzspLLPGknmDo6VThqVPqeQ6Y1WsGNviUdwOl6Kw1769GD/ZyRA89CK+uA==
Authentication-Results: oracle.com; dkim=none (message not signed)
 header.d=none;oracle.com; dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL1PR12MB5304.namprd12.prod.outlook.com (2603:10b6:208:314::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4264.20; Fri, 25 Jun
 2021 15:03:13 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::3d51:a3b9:8611:684e]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::3d51:a3b9:8611:684e%8]) with mapi id 15.20.4264.023; Fri, 25 Jun 2021
 15:03:13 +0000
Date:   Fri, 25 Jun 2021 12:03:11 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Gerd Rausch <gerd.rausch@oracle.com>
Cc:     linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
        Doug Ledford <dledford@redhat.com>
Subject: Re: [PATCH 1/1] RDMA/cma: Fix rdma_resolve_route memory leak
Message-ID: <20210625150311.GA3006866@nvidia.com>
References: <f6662b7b-bdb7-2706-1e12-47c61d3474b6@oracle.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f6662b7b-bdb7-2706-1e12-47c61d3474b6@oracle.com>
X-Originating-IP: [47.55.113.94]
X-ClientProxiedBy: BL0PR0102CA0065.prod.exchangelabs.com
 (2603:10b6:208:25::42) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (47.55.113.94) by BL0PR0102CA0065.prod.exchangelabs.com (2603:10b6:208:25::42) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4264.20 via Frontend Transport; Fri, 25 Jun 2021 15:03:12 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1lwnMN-00CcFM-LP; Fri, 25 Jun 2021 12:03:11 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0a140246-023b-4cc9-cd2f-08d937ea5a39
X-MS-TrafficTypeDiagnostic: BL1PR12MB5304:
X-Microsoft-Antispam-PRVS: <BL1PR12MB5304423232F8B6932A7DD5E5C2069@BL1PR12MB5304.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uZwKL6XTfqfAr4zYO4/UtY39OPKj8u00mkG4xnno479eJ7EvVkx/XfGX4GgmYw0jCJB7D7MuejG90krCAvO2dTfBTjXwpaasgxl5qHXBliEyJJRUc2WaV42atHa9CIoA2MCll6Bqt/xT34yjKPsXRQLyl2dcfe+f0Hor8JA7jSZrO8/bDd6PsJptYtQIBYdSO2SR7B/4JjELKyGvQpqzi8pEgzcTLNtsbHe8Lf4wQsRXySZtz6UxINo9r9NTmj4WAn1r78TZSXo4clZ17vLgiNMXIRqjdSt+sxtnto9cU6XlC2+siDagNsaUjz6he8/CrFvDp/jjvxHU4zjCunEkyTgEk5AZkl+2IBGWBc76EGZh1QBAGy7Q61579d2WAw8Benx+jvbs5zCG1KPYSuvzxapuM4JsPyanV8pBBRBu2Bav4dCPurfR8APHRfJ7iVaWEJWAqkGesI/GL4gPmS3HWuOj/ysPxvbZ3IBJhVdjgdvs8zKe8G1SAY06jR+DGgQALu+owwza8P2+heOX0dHHeLFjRz/GS0HMUubypvEcJH2+E5rIOP8dtzCi60tmQWt9JrSM/hrb+qLk1CqklQZ9KU7jytsxEQHNIpU6YnFeAF8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5506.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(396003)(39860400002)(376002)(346002)(136003)(4744005)(9746002)(6916009)(478600001)(38100700002)(1076003)(86362001)(66556008)(36756003)(8936002)(8676002)(186003)(5660300002)(66946007)(9786002)(66476007)(26005)(83380400001)(316002)(426003)(2906002)(2616005)(4326008)(33656002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?sxlIg6Rd9yI9c0RDOjPggIclbeBWy2mcL8epzoCSJwBPQT0jE46eZK85DC9l?=
 =?us-ascii?Q?FI5UrklWtQyAqcumJnunJzKH/Poj8F1afU389JJPZjSh4i/7s/PjXELnLAhm?=
 =?us-ascii?Q?rzmaEkz1+QcKpLs2zWPJL2oTX4U6EZHIiU5/GuB4GQAOwwI/xf2/+1QBKWK9?=
 =?us-ascii?Q?z6uB/ZzHMfP/GntB4Ef3ywU0I8DwKWPFbvgh+QHNrAw9GUhr/TKex0TrG/uC?=
 =?us-ascii?Q?CoKIvWGMw4EDZ6h0GIa0FSjhdzCyGDB0NL9wY+sEUI/ZKvbNTz7U1mG7P/zy?=
 =?us-ascii?Q?1YwbZSD+XdPJ2cS3SI1l+KoBREc9pS5mAgYx+P0iRPxjSvXHuiqNmZdqMQc6?=
 =?us-ascii?Q?8VtDythCG305WYKsf4a4EgFIiMV73io4yMz/fpte6CvjR9YmtP8fnb4a1Mu1?=
 =?us-ascii?Q?yIcav9aVyvI6r/rY+DiHHk/O2/Otx0CIfeZpcZlkaHU8bnvEwUtJ0mEmPQfd?=
 =?us-ascii?Q?zRk3QybwtRf5bbBrntRH+BBYbiRIsw1XREnhfNp+lcmZmGCM4KWLVmTxlLeR?=
 =?us-ascii?Q?4X8KcoFjn0wQb3nwLzXV4p59vxVL2V0FU8nCTG7KKNCqnFdOzBKmlJQoE9Ir?=
 =?us-ascii?Q?HFL/vYtfGgnW/nM9dKXdYFc/1sszx3hf1LsBpBKCobuyX+gIccda2LDOSPu4?=
 =?us-ascii?Q?ca8iS905T3M3E3UCz6BR6Dn3b3UAIn9T6rCYl2TjoqwRAF9lRvp7+bu0NeAW?=
 =?us-ascii?Q?7VayMNwNTRu267DFrEkjnhE6uSo+OuQUlJQ1ljDAR+yBg4XZyTyw95aVJtio?=
 =?us-ascii?Q?VjMykgch4NDGaFSvOPd04BiXm1mH2RQeOc+ufgx/rLlLYAwgWJxpxzzxzH57?=
 =?us-ascii?Q?Rx7XJnmMEnNemXycKh6eOxgtnI+kNWKuhlMBhJ83lvm5KZKfH6T2oBBArd4o?=
 =?us-ascii?Q?sOl7Wu+XxXScnZqDnk3JNCa+sfbyawgrggZp7cPd8jKlhhT+5UvnRPZcAe33?=
 =?us-ascii?Q?Rr1hYilkq1JzRQ0DXww03LfAYE95yRoW1PDVTnxT888pUVK+QEeZ04mEQhbS?=
 =?us-ascii?Q?rSdfYp1694GY9GQc2cnMWVqBvX9qmETzv54akKyC+9gGuanuEBCfM88lV6FV?=
 =?us-ascii?Q?ZCUwHsERAQEER8MjthZnbjGojMwJXxO7qzitPMA2ri0u3Rwko8ar5ADyBEwv?=
 =?us-ascii?Q?0ZwLrVwbh1HRMlqJXcHcwbyi3t81/2u4E2+a+b5HwPL9Q3sd/UMxd4tSMvyB?=
 =?us-ascii?Q?LcNPA6/+J8nRjOdN1GcSw2xleewxcaSjUSGXsrPIc+SCyV+ChPHRzpCuyyzS?=
 =?us-ascii?Q?soIp1hEVehMvP6NBDhOAwwV3rXJkA0IHY+qT/No/H4LNZ8//ptgRx1+No7VI?=
 =?us-ascii?Q?NBNYPBoqFDvypy3s+lRM0e6O?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a140246-023b-4cc9-cd2f-08d937ea5a39
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2021 15:03:13.1869
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MhG6m7erQXM+Na26SN6BmfvcK7TNFN+gSoYYYqm7TPcfiSzJfdhDKrYqs6KpYEYa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5304
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Jun 24, 2021 at 11:55:31AM -0700, Gerd Rausch wrote:
> Fix a memory leak when "rmda_resolve_route" is called
> more than once on the same "rdma_cm_id".
> 
> Signed-off-by: Gerd Rausch <gerd.rausch@oracle.com>
> ---
>  drivers/infiniband/core/cma.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

I wondered for a while if it would be better to clear this in
cma_query_handler(), but it seems this is OK

Applied to for-next

Thanks,
Jason
