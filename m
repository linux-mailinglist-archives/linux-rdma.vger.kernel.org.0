Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 18DB943566B
	for <lists+linux-rdma@lfdr.de>; Thu, 21 Oct 2021 01:20:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230103AbhJTXXJ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 20 Oct 2021 19:23:09 -0400
Received: from mail-mw2nam12on2066.outbound.protection.outlook.com ([40.107.244.66]:50016
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229702AbhJTXXI (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 20 Oct 2021 19:23:08 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NWP/vr4i9v7cfQCSQHHqIoJ+tfodtFR0+KDAuqUxYqArthHmDkMdBgHlHCX/Fy5MejAMoiQrgzNT0jGWxltkMWwUZ7n7GPolmen/zHFjSTxzhANXe+4u5EgHHilv0BKn8FfGCamKbO1Ju/l42Q5wPGlgf6JCbyZ9l0CrM3sWqDVnl8tPch1cLn/ZAhFFYWDBtDyClKIu4wTlPjvYdDnfef665XYju/j0shdDeg8qrYZKX1UC54755Ik3ziiyXtiyyIwKCw7JUZygw2PrZv7R0A+QWu7iP0aCmf5ivbc+SCx/UKhqcKyKN8NU5ZGicTCF12+GMt85os7ozscb40kpcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oSzmY1xHn4xa4t4rfb7YU+dOw1SG0vW66Z0Fa7sNb7w=;
 b=MsKhbN7/3rz38gAybZvzXEk9FODC4e/Kl6ai3TqKJCbkSiZmNOD/tNT4gKFVOCDImpfjLwCaRhIATIzw7kWWp4sv2kv3/xRCeajyJ/5t9z5zE6neWN91KhDoxo4DrQtyRq5aCOaiM5T+XEcPtwQcdS6ae/olA1vUTg0DdPIOxMTRigYglcw5OeBgRtXiQyX6EhuKsQoKQoK6CGM0RuQfSTxCW9+EEBy28x9CDfwPmV+gDTKV3AkM1dcMulh463KSIDEm0Djw8y7vq/tu2tArW88g+SEpDHLk8CD83ojS5LXifKAZgu52KKCzvXEmVHYjDqMjorzvXND9K8rlw8stuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oSzmY1xHn4xa4t4rfb7YU+dOw1SG0vW66Z0Fa7sNb7w=;
 b=W7g2K4FqjlztqK6ZsyROcvBWCyjCyHo2VxebyNYGUYEeN/ST+mmVvvZq+cTGnWAm1ChlPDqZwPBWdg6iwJK4muGhh09OZzWom77JJDVMyEDfNvlakloMImkojgBsP95BOG2bdb2jErIZ2AxH8lLrzZKjmICc11QYN5Em9YW7xJOsjA8xQ3LdhxV9NuRZj8U4N0pjeqjidGYEyf85qIzqHZtT8PCwkNX/rVWPQ4D+OBB01kdoXIhVatsUe00jTF9oe6DGxpJ4Q4kZJNFZBO/vflY/5iR1DWLnMiox0nN2dryfdEZeSj6bUkwSVyqNulPnjT0ZkRe9lxt6DygZwCOQ+g==
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL1PR12MB5110.namprd12.prod.outlook.com (2603:10b6:208:312::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.15; Wed, 20 Oct
 2021 23:20:52 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::e8af:232:915e:2f95]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::e8af:232:915e:2f95%8]) with mapi id 15.20.4628.016; Wed, 20 Oct 2021
 23:20:52 +0000
Date:   Wed, 20 Oct 2021 20:20:51 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Bob Pearson <rpearsonhpe@gmail.com>
Cc:     zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
Subject: Re: [PATCH for-next 3/6] RDMA/rxe: Save object pointer in pool
 element
Message-ID: <20211020232051.GA28606@nvidia.com>
References: <20211010235931.24042-1-rpearsonhpe@gmail.com>
 <20211010235931.24042-4-rpearsonhpe@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211010235931.24042-4-rpearsonhpe@gmail.com>
X-ClientProxiedBy: BLAPR03CA0053.namprd03.prod.outlook.com
 (2603:10b6:208:32d::28) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
Received: from mlx.ziepe.ca (142.162.113.129) by BLAPR03CA0053.namprd03.prod.outlook.com (2603:10b6:208:32d::28) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.16 via Frontend Transport; Wed, 20 Oct 2021 23:20:51 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1mdKt9-0007Tg-6E; Wed, 20 Oct 2021 20:20:51 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f6d2523d-8ebd-475e-0a23-08d99420421d
X-MS-TrafficTypeDiagnostic: BL1PR12MB5110:
X-Microsoft-Antispam-PRVS: <BL1PR12MB5110AF31AD24AB3D88388735C2BE9@BL1PR12MB5110.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7HyhfHXpIwp43JtV61PxKTx44YG8d7GpXYyMo175aG0ZaExKoK/XR56VyAFSSBfhVCBsJkATdu2dukBMkS64RkFqPrBQB27J6XDWN1rrt8bl349vMdTcnNdnGOcSQQAjXFl6IFn/C8zHhJJnZyN24gEPJccECcSRxReEwvxlvsiu+5JXxDLXE/uz3Ew6G7d9OuYNWyElXw1m551D+GudbrDuu3XR58sVGI+fBrM9wjVNdyoilD+cfSz8PmK1lgxr2Slq8GknFeam98BXT0+jxQo2qJOSqLu2k79S7RtyojgJ5lQUwf8ue9YoX+PYECe8VkW1YFNzb8RbRYENB6N6S+fIH2JC+DcxMJf0tCzt49qXdWlgwGPj2RhuC9gYrNr8dPA/HKaBiQ47BxJ7Vh7qvZq8Ayv/iRDok1O1FfYu1bsZ/XN5qnJhssoAtDxg4tdONtj1a5i4nNve2FITdN+jKQyemQsRyUdAgKJQl6vdybixyxW7BtGhfuTtJHGM+8jqZeIbPuJMqmn3vkfSBz+K2w2zIuplJZMrRNmadxcP5OOcoGhNgZMwnPKoYraNC7E0owJfUbVs4pkGxkzG3/M7OQ+ohvwVYIDDzHN6syOm5eGm87atkFOIUHr8S7uHeL2j2R7c10p3xfoevMAWoywkTQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5506.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(33656002)(26005)(186003)(4326008)(4744005)(2906002)(83380400001)(1076003)(426003)(66946007)(508600001)(66556008)(66476007)(86362001)(2616005)(36756003)(38100700002)(316002)(5660300002)(8936002)(8676002)(9746002)(6916009)(9786002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?LU0FeKslfK5xxaHfGCHMP1h1xoEwB0z9IlgnBNr7l7EaLI42DwaK8I5otRHX?=
 =?us-ascii?Q?tuNm8xI0ik9wPZlrfB74Mbg023RycB5KxCZOc2rukeQy7GT8q37i+7eGxdfp?=
 =?us-ascii?Q?Bfpz+jfqLdJNy4+yebpfY/AFNdMzzgEJ4cy01sHoBnkd8jeVfAgKLo44qVs6?=
 =?us-ascii?Q?7Vciry1wKMdGuF3+QAO4S/i+XK8lWAUNLznsv94Mp0udQWTNVqlwaET7KKZ3?=
 =?us-ascii?Q?9uzbjhIToocmcPs5x/WpcQHjbYS8tGrW46gqHOXLy0PR0+33vBN3MPvX1SLY?=
 =?us-ascii?Q?u0IUNHLuj86H/bhbdOlMZ8SFKXuOwinpuf2ovDqSHhn5HCE1LpjMNVuYYdTl?=
 =?us-ascii?Q?JjvRbAE8olhzNVW4lDkz+xkaiXe9oNH+P+rMxpKKWWvWgPpqx+dzYJ3pSATO?=
 =?us-ascii?Q?gqbzzP49VcY7gzOtk3N4mWwYimodkg8IuA0Z0imnBSpUVCO3V2RnxK8AEdsr?=
 =?us-ascii?Q?qUtKg0mRogO+6ARZZjPq4jV+Z4cwkR99dyWI8V+HgjfGI813uOQ5J2JCNP93?=
 =?us-ascii?Q?mCl+lF0TesfjEv5ccFY+51i5ehr4PQVP4X/tTQMTpDR6H4T3Aee/jmVI4Dks?=
 =?us-ascii?Q?mA++YtZUZDlBjVwwALs/InSucCbJHELdWuLFGZC+meZ8fUUedfrytNT5eg2d?=
 =?us-ascii?Q?g1O3NN6a0mUJOvQlYjOIMMC1r7UK9W3GmTAR8xbZAMR8oXMU0WfV4y8ap3+R?=
 =?us-ascii?Q?RlNFaoeaBi+hgPcSRAdD+E27eYpM7EIG8oed5RLNayJfDjsIHAN6uS/W6YVI?=
 =?us-ascii?Q?XHX52VpAzrUTlQrXV4f3YmtYzK8HvqHVm6PAkigWLUaDGGpj2G2ILwMHdCa4?=
 =?us-ascii?Q?YyU7zzV4o8GZsfMInvY0yoejMkBqNb3IHlBIAh6Py/inbb6ose+zXi3uI/Rv?=
 =?us-ascii?Q?GbH6dd8J7g1JCd4yvb3R5JoCxDImgtOYu6J2oJFhaeu3aacqYecsOMKXuCbQ?=
 =?us-ascii?Q?QSoPMZyzjHPBxTNBJ3xPQHqLBStY7HXcIbH1Ixt42uPx9Vl+CXuQSc9Dz1ao?=
 =?us-ascii?Q?osHQVcpeioEGe0CPK5Cb4xGinwcSJ1G3UNngfwOH0TdusjSo/L9W8RK/fL2O?=
 =?us-ascii?Q?4ovsUXnqnQz5BBfG0gKIE+JLrxXcWa05WVQAJNYuQ1JdoyY7//hjVuA68HA9?=
 =?us-ascii?Q?V3vHr/+hULk8Ve1p7SwdU7PcRGw6FeHE4rY4Z232l7O4ZWupeAAwxUA0NsR3?=
 =?us-ascii?Q?T6j9/RWcY36NyKUV63Uh2mYLzr0qwRbKA6vFV70wg4h6GkcqxQ7tYV7b9xcc?=
 =?us-ascii?Q?d9adhJMFtWuhlDlZ7QOa2cx37qwK1lrhRI6uDHZLTwNcHXN5xRA4slb881eo?=
 =?us-ascii?Q?GClBlW3oWpt0OdDNHS3TCObR1doYgabZD86TbO4UEloAz28SoQYJNVbGlboa?=
 =?us-ascii?Q?9ilM37jlbHUzV0F5GEmuki3Ea9J7kiBwyFgHm3G0X/0wMh1Ms/4vumAJv3YW?=
 =?us-ascii?Q?aO1Z1yXV12c=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f6d2523d-8ebd-475e-0a23-08d99420421d
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2021 23:20:51.9585
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jgg@nvidia.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5110
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sun, Oct 10, 2021 at 06:59:28PM -0500, Bob Pearson wrote:
> In rxe_pool.c currently there are many cases where it is necessary to
> compute the offset from a pool element struct to the object containing
> the pool element in a type independent way. By saving a pointer to the
> object when they are created extra work can be saved.
> 
> Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
> ---
>  drivers/infiniband/sw/rxe/rxe_pool.c | 16 +++++++++-------
>  drivers/infiniband/sw/rxe/rxe_pool.h |  1 +
>  2 files changed, 10 insertions(+), 7 deletions(-)

This would be better to just add a static_assert or build_bug_on that
the offsetof() the rxe_pool_entry == 0. There is no reason for these
to be sprinkled at every offset

Then you don't need to do anything at all

Jason
