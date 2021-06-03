Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B93E39AA91
	for <lists+linux-rdma@lfdr.de>; Thu,  3 Jun 2021 20:58:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229661AbhFCS7w (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 3 Jun 2021 14:59:52 -0400
Received: from mail-mw2nam12on2075.outbound.protection.outlook.com ([40.107.244.75]:56064
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229620AbhFCS7v (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 3 Jun 2021 14:59:51 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Wm/ErlIC92mhvUTOKyu3p6rWC8ktNds2xkmsomekHGdglznt5pArpdENXrkQPnYbuAtePiO696txO8neDoli2A/QVhJOmmKd7JrBU4a32N6vS3VbMIQOf/bJkfthapvPXLBoLwUrkgxChlLwKJbV1nkFMgfYvTsxLpBALL1/vG5Psic8wqUilOxOCLQQG/0ZiO1qlOogIjtsKuu5U6sUX+BvTppaKlonEgcXBDnER2z3gHe+9ZGXF1sLVx9XLmhhsJR2Mbmn7adpAb7zEin4FQymrtZmpwMj1XuXmfpNK0nVfhfeEruzMOB4tNH5KXqS04PC6famLXjVidPeSAOu9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OiYyOk0R8csI85Sy469W81sZR5qcvc+p8K3zW8+PNU4=;
 b=HK/HOis1TPf+QlwEVRHrWP/W1KVE47WdvlGWkd20hA9RVm3eXCzePYbEYQD1I42g9/Zvgmqk93Czz/9xILoFvQiZQvFIIEtNqzxtZHiHgzMQYtLLZ/bHovGNCUQgfdrgN+jmYWj6BH4n8tnKscQ5bV8Hr+kzHvuxO+cXSTzFEHSGZO2ATjjO3DxVsuPrOQwDrHA2VVlZ2HR5DWLbVFy88ML+S8VsP8eymfd53kc1F1ZBaLrxSgk9Q+x+T4E0AInIZFx8++buQFqHcoDI4l+V2uYeFps6LFurzqeYJsMwxAwAH5Q+rs+WYpQg7iBC87/C9wANSdG8zaenHzkhknltBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OiYyOk0R8csI85Sy469W81sZR5qcvc+p8K3zW8+PNU4=;
 b=SNXaFkHgpccwodAZqqdyFAf/chv6eoKgnm/nW4L0wRtgLLpzWySR+oqK6UNrIshXh6KKQc/oaqFxIl4V6GEG8UlzHQeAhEukQAb5vKyz2vfY6n4aPHkUxEvynwo52juOiQDpwHLNy1O9tS0rroQtav/h0OFdIbwV+gZQaE6lQlTbt4dXVpvVRK/AUSpYu4Pa4l6KXsWrfIglvk0YJKMfOcccmtTSsNRMebOenW8Ly/K9+i1YLXOt8PPsZ/t4Ez4kZ77cSSdRiUlR/Jin9uo/jjxg6PPbunJYgEZ8YMzj/FwC1FKmuQw/n6LpDvli0i32D9sCkqsBv6jcLB/j2O39Mg==
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL1PR12MB5319.namprd12.prod.outlook.com (2603:10b6:208:317::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.20; Thu, 3 Jun
 2021 18:58:05 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::3d51:a3b9:8611:684e]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::3d51:a3b9:8611:684e%6]) with mapi id 15.20.4195.024; Thu, 3 Jun 2021
 18:58:05 +0000
Date:   Thu, 3 Jun 2021 15:58:04 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Bob Pearson <rpearsonhpe@gmail.com>
Cc:     zyj2000@gmail.com, linux-rdma@vger.kernel.org
Subject: Re: [PATCH for-next v8 00/10] RDMA/rxe: Implement memory windows
Message-ID: <20210603185804.GA317620@nvidia.com>
References: <20210525213751.629017-1-rpearsonhpe@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210525213751.629017-1-rpearsonhpe@gmail.com>
X-Originating-IP: [47.55.113.94]
X-ClientProxiedBy: MN2PR17CA0003.namprd17.prod.outlook.com
 (2603:10b6:208:15e::16) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (47.55.113.94) by MN2PR17CA0003.namprd17.prod.outlook.com (2603:10b6:208:15e::16) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.22 via Frontend Transport; Thu, 3 Jun 2021 18:58:05 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1losXc-001Kdm-23; Thu, 03 Jun 2021 15:58:04 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 193b85d5-d434-4c60-feff-08d926c18505
X-MS-TrafficTypeDiagnostic: BL1PR12MB5319:
X-Microsoft-Antispam-PRVS: <BL1PR12MB5319945B42A5B47AC5C68F99C23C9@BL1PR12MB5319.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2582;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4TxCIvYioocunAsByqodDzoRat5WnBx8s9alm8SSq4aMCxg9navsoE9hNwzAejqPsGIoiKGNtBlQr5GbG1txaVb02faaAYIOCnHhlGiculSOn8HNi44oWVa8GSunmkxKIg3Drhmx5IFl1zJSs5+H81LdNssHVNO1MAGWV3anUEkoDfZbTMYn/O/l9liE+HbrO5cepmPqJWECB4WuAnPSYCbJN4Btfam4289fmHExttXm+RoDmQwg8vUY5F62AS9cOYzvJqWcYqRBNf9QphTCzzZ0WWy8dQJXeSJ5orGQo0iWJEbrD+S0VWLZ8YqbLfr8AJ56rQbYF6OHkI+ntL06NWqg63PO+axw494vGQEZ8Qy2918AU26u70+wefU3zxJUrPnALstzw7NErDY9kNsNppy/Lu2c6EaX/n1lWehpAnU0Tj7Fbj06q7tjU6pLGuT3qtXFQpwS9VC/gMde83T3iWFlaakAqW/RO0fhQwlfvqzT8jU8UuXxVDdh3ayfwEyrV+r7KUQAKjNriRrJur/QrkiRTIUJyEusSYb4giUJXIMP79dCwa9fq/DMEqSWX0k//6+FAwd36hJy/cl3awNZCSLnUPJpq3qfSkSZL+GH3O9v3hkJfjLy1Gi3dTIrquNM1vLIKKCapCkVCkU+o6WkIhNPXw6ackkNxwNKgO0gx/A=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5506.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(396003)(136003)(39860400002)(366004)(346002)(1076003)(2616005)(6916009)(8676002)(38100700002)(426003)(478600001)(4326008)(33656002)(86362001)(316002)(186003)(26005)(5660300002)(2906002)(9786002)(8936002)(9746002)(83380400001)(66476007)(36756003)(66946007)(66556008)(27376004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?IvOZssWi1ccPYnGTgaDR7rMUPPL0g9GEgJgGjR4b388H1CYQp+RjRp8YVFIx?=
 =?us-ascii?Q?DrxwWKTCIfrUV3+5lGC7pZjQDMyVRE6FfzF+jydzfbWUtrXiXwD3/ERcIKbh?=
 =?us-ascii?Q?ATlW2SuimeKHbL6K4rt/hm3UqTpbZoIvQ9R97jw7bXuKA/4Pl30wXQYhD1rj?=
 =?us-ascii?Q?TsyJdmFTCiwZ45ZoFqmUCqc4OR0+Ja7EJpqDcpNV3+bqVkx7/E62w889wH/S?=
 =?us-ascii?Q?5FvNFLc6Kz8Wb4VNvsd2ApNv5eJSjvRSEOM2oxpj+Ig2Q1uGYTlVl4iuj4AL?=
 =?us-ascii?Q?u1Sp8vNgXQS6HkfuEVthswuNB4k1Oe5kXFjdwDPsNiyJfbOVrxvZ74Zjw3sZ?=
 =?us-ascii?Q?XBBtYswMFhmplwwF3FkBcnULZ1IYG/NTZcud66IjvvtDWg8X7gKAM89bMXPr?=
 =?us-ascii?Q?nVWCSnT4dBVkK5kDtt7jTlZ1cU7LkdnZR18iD9AvxnZkyI9J/GDuMelIQ9MS?=
 =?us-ascii?Q?I4pR8ygv0sOaUZC9uyxL+NQDoIJ6OUiQc7javLnayKkGqdQudRg9m6V/6vxT?=
 =?us-ascii?Q?kStEXGHQs3SuIgcWxuxR81YamctmiU8YAhgbdu7eZ1dy72tv0hac9sM4QF3a?=
 =?us-ascii?Q?CxMdIsDkzKDtj0H9F/2X6OoYSXtgpfSL5TRYqminK8FY9GNDt2jUviLZD+9f?=
 =?us-ascii?Q?xraui0WS4YIutptBnNtsfu+20zyui2dOfDmqzCIrLd/CwDdbodlyqEWjni4d?=
 =?us-ascii?Q?K8Xt/cIg+R05sqZFC67CogL6NjmH2gXGBYyY6b09MNIZjLoDmAg/F3LopVMD?=
 =?us-ascii?Q?YlM6pG9bMkc1UORQPadIQQ9c64e/cwXECRF2ADKyk0GQkTa4UVYh/QM/X8w1?=
 =?us-ascii?Q?zSBcPsd6aTzFbAFbhYeSm65ylKAyxT97XC8GtQ6lLDGPXMTiz9zc7TSf8zfQ?=
 =?us-ascii?Q?m0se2VTJKvoON+mnPEN+91ghNURvcT3GOR3axJKAY17xE0ECwbKde4ivSg+Y?=
 =?us-ascii?Q?5NmbirwtWwWkvar48pJ1doQ4Jjsoh57w9Xi2Vf6IB8wniBVQOoZu9Hb2vTOX?=
 =?us-ascii?Q?1grnu+stdIdHb0HA+iCPMjBjkQgYIPPtnB1SQCCwjBQIcksaJ5TXe6tY9Trv?=
 =?us-ascii?Q?c0vK3x8NNiLUN5SffQCQb3KLgGmA4NUKB0pj+s8HvMcYFBccL0IXoujVrpkX?=
 =?us-ascii?Q?PWMlEAluUFVaotVcrBnuwmB+dI5e5c8js/wsytganAxIwz8kf5P7LiVnpYsO?=
 =?us-ascii?Q?2kQ4vqrOVlKT/9YuloO64IISB0b6mb3ZcbYOu/kMpQvdzQ7+gd2tct4wh6fR?=
 =?us-ascii?Q?BDeXyyxDQq6/ee3ERjoi/hXLIyQ2amx+fXvPNX1H6Kep2FXvCyWfUxgHTTCH?=
 =?us-ascii?Q?5YwvhuOhXeiZnCSODeVdv5pz?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 193b85d5-d434-4c60-feff-08d926c18505
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2021 18:58:05.3107
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EMxX8LKF5z7BL+10FPBWwHedMMUuyIQ5osLYl8joRfIufLsG8Nwn1dbYnHs16R6q
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5319
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, May 25, 2021 at 04:37:42PM -0500, Bob Pearson wrote:
> This series of patches implement memory windows for the rdma_rxe
> driver. This is a shorter reimplementation of an earlier patch set.
> They apply to and depend on the current for-next linux rdma tree.
> 
> Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
> ---
> v8:
>   Dropped wr.mw.flags in the rxe_send_wr struct in rdma_user_rxe.h.
> v7:
>   Fixed a duplicate INIT_RDMA_OBJ_SIZE(ib_mw, ...) in rxe_verbs.c.
> v6:
>   Added rxe_ prefix to subroutine names in lines that changed
>   from Zhu's review of v5.
> v5:
>   Fixed a typo in 10th patch.
> v4:
>   Added a 10th patch to check when MRs have bound MWs
>   and disallow dereg and invalidate operations.
> v3:
>   cleaned up void return and lower case enums from
>   Zhu's review.
> v2:
>   cleaned up an issue in rdma_user_rxe.h
>   cleaned up a collision in rxe_resp.c
> 
> Bob Pearson (10):
>   RDMA/rxe: Add bind MW fields to rxe_send_wr
>   RDMA/rxe: Return errors for add index and key
>   RDMA/rxe: Enable MW object pool
>   RDMA/rxe: Add ib_alloc_mw and ib_dealloc_mw verbs
>   RDMA/rxe: Replace WR_REG_MASK by WR_LOCAL_OP_MASK
>   RDMA/rxe: Move local ops to subroutine
>   RDMA/rxe: Add support for bind MW work requests
>   RDMA/rxe: Implement invalidate MW operations
>   RDMA/rxe: Implement memory access through MWs
>   RDMA/rxe: Disallow MR dereg and invalidate when bound

This is all ready now, right?

Can you put the userspace part on the github please?

Jason
