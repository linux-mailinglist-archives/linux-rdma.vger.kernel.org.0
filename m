Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9DD71205840
	for <lists+linux-rdma@lfdr.de>; Tue, 23 Jun 2020 19:07:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732913AbgFWRHN (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 23 Jun 2020 13:07:13 -0400
Received: from nat-hk.nvidia.com ([203.18.50.4]:16291 "EHLO nat-hk.nvidia.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732868AbgFWRHN (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 23 Jun 2020 13:07:13 -0400
Received: from hkpgpgate101.nvidia.com (Not Verified[10.18.92.100]) by nat-hk.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5ef236be0000>; Wed, 24 Jun 2020 01:07:10 +0800
Received: from HKMAIL102.nvidia.com ([10.18.16.11])
  by hkpgpgate101.nvidia.com (PGP Universal service);
  Tue, 23 Jun 2020 10:07:10 -0700
X-PGP-Universal: processed;
        by hkpgpgate101.nvidia.com on Tue, 23 Jun 2020 10:07:10 -0700
Received: from HKMAIL102.nvidia.com (10.18.16.11) by HKMAIL102.nvidia.com
 (10.18.16.11) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 23 Jun
 2020 17:07:10 +0000
Received: from NAM02-BL2-obe.outbound.protection.outlook.com (104.47.38.52) by
 HKMAIL102.nvidia.com (10.18.16.11) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Tue, 23 Jun 2020 17:07:09 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I0NiGEvnFlTHsU87AImwG0F3HnvGqzhmXP3Rdo7t9lq9aSyflKmJOyvraxPO0WQi+bVC+tSr2wTlqA8UKXxWWb8SFAScpVquwiyRKdUpzCGbL4AODwaYqN+Mzq1+a3Zs8AXX/eH6brM1aPz2eZr/veZOW8FJuCkHP3GVfkBbhh1XJSAeXSGCS7cz1ywz0e3zO59YoNx0KpHOnBybd9K4OOWdLV+wXRsqT/c/qZu533i+VTLLJfWaxEMn2nA6Qp5m0psG/rzNEo5HxqHepI8HqaJ6YOsnlDJQiaX1Fg4BLP5Yq1EgFD4g19d7i+Mr4KAN4iIKgEj5nqS7hlsO3jWQFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yCSsRcvng8RuGQlBkRrzgtPg9MzS/O28ShZRoS+O9oc=;
 b=lC9+3l3KgFzbrstQPGxg1fJJmoWIJAGcej2DHx25oBRV6ZGMmn3qc9hgE/MAriGPVx4aY7xwwnQypTtcDdnzw5b3eYFPcq5YlgENs+pHeluZ9+hpoO0poZTlV/q+GgK55TIt25ICAFno6tvyxQdf0CzuXlDoc6Zse0ekMK2MusFSEUPy+LY1gMOypMazvWMpnr4iar8FdcZzirKRMlpt2xg+wtIjd72deAixTr7tVTvxkv8hY0T5YPcjYGl8lFGWTy9qkzk8b4bnC9txe5dzJ2kPlJ0znsrfwvbh+k3QkE7rx02whLlmkH8++j4NO3I7t18/q/WIny4Fu1lbHTMnkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB4268.namprd12.prod.outlook.com (2603:10b6:5:223::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3109.21; Tue, 23 Jun
 2020 17:07:07 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1d53:7cb4:c3d7:2b54]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1d53:7cb4:c3d7:2b54%6]) with mapi id 15.20.3109.027; Tue, 23 Jun 2020
 17:07:07 +0000
Date:   Tue, 23 Jun 2020 14:07:02 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Kamal Heib <kamalheib1@gmail.com>
CC:     <linux-rdma@vger.kernel.org>, Doug Ledford <dledford@redhat.com>
Subject: Re: [PATCH for-next] RDMA/ipoib: Return void from ipoib_ib_dev_stop()
Message-ID: <20200623170702.GA3088155@mellanox.com>
References: <20200623105236.18683-1-kamalheib1@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20200623105236.18683-1-kamalheib1@gmail.com>
X-NVConfidentiality: public
X-ClientProxiedBy: MN2PR16CA0029.namprd16.prod.outlook.com
 (2603:10b6:208:134::42) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (193.47.165.251) by MN2PR16CA0029.namprd16.prod.outlook.com (2603:10b6:208:134::42) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3109.22 via Frontend Transport; Tue, 23 Jun 2020 17:07:07 +0000
Received: from jgg by mlx with local (Exim 4.93)        (envelope-from <jgg@nvidia.com>)        id 1jnmNy-00CxNb-7F; Tue, 23 Jun 2020 14:07:02 -0300
X-NVConfidentiality: public
X-Originating-IP: [193.47.165.251]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: eb5432e2-393c-47ce-688c-08d81797dc10
X-MS-TrafficTypeDiagnostic: DM6PR12MB4268:
X-Microsoft-Antispam-PRVS: <DM6PR12MB4268CF0A4B42D23CE9C2DC80C2940@DM6PR12MB4268.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4714;
X-Forefront-PRVS: 04433051BF
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EJH4Qf5tQCPt0Bcl0zGL9iwnFygFnvSEtrq6ArxGaVFBQAySQ7emSahWMS6rCdvrnAAWNCunkF4gdDxG+pYFrFUqkHS27ohjWjq1ThuaziFhxyVc4bTSEKI+B+cOFMePM3rUSB/JXdLmw5YaqfWsEMgho+PAFVDtTErqMGKL7olO8NfC1kE4k3ShDv1tQ84HKDS4YHe7QrX+o5Jrjz7qcPm2Xhnh1bXmmaz3C9P63hfXp4awz3v8+DGmwn0kjf4ahcsHQrmw2YoRP8XLJ9YQslKb3BHfULc8jmMstepJukDgb2/zAaXOmQZq+YOGbkuo
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(396003)(376002)(136003)(39860400002)(346002)(366004)(66946007)(9686003)(4326008)(426003)(316002)(33656002)(83380400001)(2906002)(86362001)(9786002)(478600001)(6916009)(9746002)(1076003)(4744005)(66476007)(8676002)(66556008)(5660300002)(8936002)(36756003)(26005)(186003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: UnDILRJJhGdLhnuD1HE/ny8p2f1vIxsD6Mshg6KlNetkjBFWSHKd+PfXAF4iz7CqbB8Xt+EGf19oSOrkhr0CBHbsPsfBW9YdoR3cG5wy3fiP3T7gWLW5NkIgnBmIwrb9Irb1XudjogQkBdkqkCN1SGCGMGeqvENx3W+1VujX6l+CtEIJrp6XPcSnoMrHfVLni3AG33uHZFaHi1MiHqt+u311FYO7ZSOGg8OalxP1Sb1VIzSqfxIqD9FxXqz+We88qeBrYCpt0Vy7RjQlorNwX33fbKL+X20t/4TQX83YVMLB3clvszgqgFzFmKW7yAVBrZU0qIJqSFvOwmnj8FqUDDe/FHJC28SlSMRVQ/TLUpu0AWnShhT9og9FNeNx44fXIhmZJD7PWADKPIDqGldnpdpnGho+0KcHU6Fh8jRmZWrRZhxR8IZljql0vH+j89DyQmZYkjWW3cr/utOk2aqIhuqxdOECYx0AHA4k1/OPc2s=
X-MS-Exchange-CrossTenant-Network-Message-Id: eb5432e2-393c-47ce-688c-08d81797dc10
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2020 17:07:07.6866
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7qhJstU2svbeE+zjiXiV6nLTwAp4K7zUVaucRxoVX6sDgD0LiJ/VPcDJxuJTO1tC
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4268
X-OriginatorOrg: Nvidia.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1592932030; bh=yCSsRcvng8RuGQlBkRrzgtPg9MzS/O28ShZRoS+O9oc=;
        h=X-PGP-Universal:ARC-Seal:ARC-Message-Signature:
         ARC-Authentication-Results:Authentication-Results:Date:From:To:CC:
         Subject:Message-ID:References:Content-Type:Content-Disposition:
         In-Reply-To:X-NVConfidentiality:X-ClientProxiedBy:MIME-Version:
         X-MS-Exchange-MessageSentRepresentingType:X-NVConfidentiality:
         X-Originating-IP:X-MS-PublicTrafficType:
         X-MS-Office365-Filtering-Correlation-Id:X-MS-TrafficTypeDiagnostic:
         X-Microsoft-Antispam-PRVS:X-MS-Oob-TLC-OOBClassifiers:
         X-Forefront-PRVS:X-MS-Exchange-SenderADCheck:X-Microsoft-Antispam:
         X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
         X-MS-Exchange-AntiSpam-MessageData:
         X-MS-Exchange-CrossTenant-Network-Message-Id:
         X-MS-Exchange-CrossTenant-OriginalArrivalTime:
         X-MS-Exchange-CrossTenant-FromEntityHeader:
         X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
         X-MS-Exchange-CrossTenant-UserPrincipalName:
         X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg;
        b=H/dEe1Ix2wJJlM117lUxLKWWGWt55YIuUxvzniqbhHKkmmUz+ViDNpX6wMMCkOtGv
         WHibI6oEb70irbuWzmder9az0gXw4TyCCGcrkyQytSXtYCRLw4RM7lw6VtxmhKd7iW
         S+ATMDST4reik7/ERe7iMn/DcewtTgJIRr6Ei/NWTb0BcWlGbEdO7aid7zglMgS7FF
         Rb6ZmEIf6HveLOKAe+VmeqRsyYRCPqUzfPBKm/Ojj0EhQhKqZONd+tzUcQIbM8zAGP
         MNLqVaniKwwUuCTZ5CoG9BCauSZm25YfQZ3ufGIQ7z0oveJc2DgB8RjN19EhAZBsSJ
         g6TyE88+QTzQQ==
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Jun 23, 2020 at 01:52:36PM +0300, Kamal Heib wrote:
> The return value from ipoib_ib_dev_stop() is always 0 - change it
> to be void.
> 
> Signed-off-by: Kamal Heib <kamalheib1@gmail.com>
> ---
>  drivers/infiniband/ulp/ipoib/ipoib.h    | 2 +-
>  drivers/infiniband/ulp/ipoib/ipoib_ib.c | 4 +---
>  2 files changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/infiniband/ulp/ipoib/ipoib.h b/drivers/infiniband/ulp/ipoib/ipoib.h
> index 15f519ce7e0b..3440dc48d02c 100644
> --- a/drivers/infiniband/ulp/ipoib/ipoib.h
> +++ b/drivers/infiniband/ulp/ipoib/ipoib.h
> @@ -515,7 +515,7 @@ void ipoib_ib_dev_cleanup(struct net_device *dev);

Applied to for-next, thanks

Jason
