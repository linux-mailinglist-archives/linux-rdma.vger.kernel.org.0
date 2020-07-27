Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B195722F325
	for <lists+linux-rdma@lfdr.de>; Mon, 27 Jul 2020 16:57:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728581AbgG0O5h (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 27 Jul 2020 10:57:37 -0400
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:2454 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727032AbgG0O5g (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 27 Jul 2020 10:57:36 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5f1eeb330001>; Mon, 27 Jul 2020 07:56:51 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Mon, 27 Jul 2020 07:57:35 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Mon, 27 Jul 2020 07:57:35 -0700
Received: from HQMAIL109.nvidia.com (172.20.187.15) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 27 Jul
 2020 14:57:29 +0000
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.105)
 by HQMAIL109.nvidia.com (172.20.187.15) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Mon, 27 Jul 2020 14:57:29 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lyMaBtLcEAzT+cLER0RKZ6LkV0uASVmQXLZfHUF/QimCqYw4JSJb6kWx+1r5l8keH0O3wtKirks1xl4s6LO9R67ZpSA41CxKELP25H87cXZH7W1wGW9cv0jxIa3ZwQi/TaCEBCS6K0EKkdGrtMK4+w3UqJWliSPJnZUfEyFSPqtgh+5YVwA3DZ4EwnyoySUPCuDRTh25NGHa4HKnoFKfbGgwzUkcNnftIPHkqGqpwOhpgl5k3XDX5nS4MqcRWlHhUITCJSIPXCzssLoVqs7V7UXpTB3240evGr7rRV/D6jrwt3x6hym0k/aeL0lApVhzM0Ec1OKs0m4NA6XpdXC6PQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WDvIK+EbKsyWFwnS46gK1zEhY7G/Db17Qx2FnDEjOnY=;
 b=CpO8UyA9XqiHvp39kR3HEdH+pVn8KBjIPSbZADgBa4PusDRD19PJmr/VRt6mNXEWGiRhdy6xqpFrHSe087RAOBPEwe2WUre1DLyXJUm5A6LYEwIL6VVHQVM7XbREoEORkPVwBzVZdeRFHjxt1gDcx2E2ghahUKWFwiSk7vEsk/ZK+6kCVlNYttDo51wogWUM2e7Bc/1QP0yVorPPVRJQS6y1FVlTRlM5GlvyNpkpqOQNeQPNdsVhx36mF0wALv/CKNKeIU/gWs73ejUgjw6IIAaYIepgWgNItKwSxVttWzG+h6xzD90LJ+eGsG0Ot9VJq335CdpdU7q2lVwCx5+TMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB3595.namprd12.prod.outlook.com (2603:10b6:5:118::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.20; Mon, 27 Jul
 2020 14:57:27 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::2d79:7f96:6406:6c76]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::2d79:7f96:6406:6c76%3]) with mapi id 15.20.3216.033; Mon, 27 Jul 2020
 14:57:27 +0000
Date:   Mon, 27 Jul 2020 11:57:26 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Leon Romanovsky <leon@kernel.org>
CC:     Doug Ledford <dledford@redhat.com>,
        Artemy Kovalyov <artemyko@mellanox.com>,
        <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH rdma-rc] RDMA/mlx5: Fix prefetch memory leak if
 get_prefetchable_mr fails
Message-ID: <20200727145726.GB48880@nvidia.com>
References: <20200727095712.495652-1-leon@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20200727095712.495652-1-leon@kernel.org>
X-ClientProxiedBy: BL0PR02CA0049.namprd02.prod.outlook.com
 (2603:10b6:207:3d::26) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (156.34.48.30) by BL0PR02CA0049.namprd02.prod.outlook.com (2603:10b6:207:3d::26) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.23 via Frontend Transport; Mon, 27 Jul 2020 14:57:27 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1k04ZC-000CkQ-8z; Mon, 27 Jul 2020 11:57:26 -0300
X-Originating-IP: [156.34.48.30]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c0f5021c-53a2-45d1-d6a8-08d8323d611e
X-MS-TrafficTypeDiagnostic: DM6PR12MB3595:
X-Microsoft-Antispam-PRVS: <DM6PR12MB35959D8F028EB2E1A1838B53C2720@DM6PR12MB3595.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4303;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UUMNQNfuE1ICJ+6fCANxWwJ9CNRK1ShoXQe7PF6YZTwVHKlgoJr/OcJcPxCUARDKzFEdUqpzxAw8ARTU15LHgNQfM898GL63sY0JafckymNuOIagiTZx0YUL/MouMSMf5G/l7TvKzsuKHJBsR+JFHDjFHCqn7/r25+SpZStV/5oDXGhMjK+mf1wZBCy7GLP+l9tV8dosNOz94+eT8CCAzur/tk9AFrVFkfURw+PdVrI3Ad505UjglLCQdH78wKjO8bHjh6oiBMgmVxT+yH9U1eaZxfKq9tOnKRlLX1qQI0oNVhdtVfGMBbXAP2iPhBuIA7BuhXf6YjcBkK0D9WzIhw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(396003)(366004)(376002)(136003)(346002)(39860400002)(478600001)(6916009)(2906002)(186003)(9746002)(54906003)(316002)(1076003)(9786002)(426003)(2616005)(26005)(8676002)(8936002)(4326008)(86362001)(36756003)(66476007)(66556008)(83380400001)(33656002)(5660300002)(66946007)(4744005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: rBbofZYppYG/YHmBH0p12LXzTEkxHu0tHHjjY771XTGxp+KyYhyHwRztlTNhWWeXLmsrMwKacpAEhHbWWV9E7AZmkaQXbmKzy5+afDcg9cmM//AntNv+2fYq3QGE7nk3l73BKAWxqbWqFuNrT0kfY4wIxaWWT3n3iKMjOJW/1IXN/vqCA8xlBM59PccarL1PERmoJc2c8muGb6KUq/REXR3qQLgWZ8rtJ8tjGlCFKcmufwHYQhiOGc6V0Kdg+RhEr5DxZNd9ilA2g/OEaNgHABbUDfv6hlz84NxlxBDx6B1yWnBlq8GppIHkEQcjsCfVNkdhvHYJ0SwkkbinP+tGj+ngFpinvuatD5fulKJqXPr8+SX935kaXHN5KDqHa+U/znoyIZZbJNMF3N6UNTd+9s+6rR6hoq+K8o5hmvB6UkKZFf262Tit0StiJDzMVOEctK54el49w240Kwkw6z7CJ5MRCHuOVJPyrZtgs1/HOIE=
X-MS-Exchange-CrossTenant-Network-Message-Id: c0f5021c-53a2-45d1-d6a8-08d8323d611e
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jul 2020 14:57:27.8139
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: S34iGTA1T/Q/fxICmhKVj6u88IG0Argx83MSnjH4jYaXcDxRorVbbHnJjuOM6qSd
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3595
X-OriginatorOrg: Nvidia.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1595861811; bh=WDvIK+EbKsyWFwnS46gK1zEhY7G/Db17Qx2FnDEjOnY=;
        h=X-PGP-Universal:ARC-Seal:ARC-Message-Signature:
         ARC-Authentication-Results:Authentication-Results:Date:From:To:CC:
         Subject:Message-ID:References:Content-Type:Content-Disposition:
         In-Reply-To:X-ClientProxiedBy:MIME-Version:
         X-MS-Exchange-MessageSentRepresentingType:X-Originating-IP:
         X-MS-PublicTrafficType:X-MS-Office365-Filtering-Correlation-Id:
         X-MS-TrafficTypeDiagnostic:X-Microsoft-Antispam-PRVS:
         X-MS-Oob-TLC-OOBClassifiers:X-MS-Exchange-SenderADCheck:
         X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
         X-Forefront-Antispam-Report:X-MS-Exchange-AntiSpam-MessageData:
         X-MS-Exchange-CrossTenant-Network-Message-Id:
         X-MS-Exchange-CrossTenant-AuthSource:
         X-MS-Exchange-CrossTenant-AuthAs:
         X-MS-Exchange-CrossTenant-OriginalArrivalTime:
         X-MS-Exchange-CrossTenant-FromEntityHeader:
         X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
         X-MS-Exchange-CrossTenant-UserPrincipalName:
         X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg;
        b=ezNaoL2GPyck6NP5Z7FVNiOV+bEeDHr0nkYfwWNKkf44W2bWL3J5Mgb49K/1b9L5k
         YHzpkLlzq/YNicMI28QEJwlAxX0zbmlt/aIMq4qI39FcAsud1B3zm/a2zq0Oa25Iht
         L7Wn3oq3dObFJe4qFnF+nFyAxiXUq4zE3iyEMB0x0DwBNhafrLZjmMrI8hYfI2nsKo
         UcFttslrYsqnl4mR9HbALJdii08kIDWkBO0sHWTa7n8diFCAPrHHuGmyrdyDMDVbeW
         68avmOGIzTiHFvACfyzs+two6SjbirefHYUgbaZAyQOHdG7HxBOsqXi8x0LWeMpgLR
         gUd/uf4yuqRsA==
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Jul 27, 2020 at 12:57:12PM +0300, Leon Romanovsky wrote:
> From: Jason Gunthorpe <jgg@nvidia.com>
> 
> destroy_prefetch_work() must always be called if the work is not going
> to be queued. The num_sge also should have been set to i, not i-1
> which avoids the condition where it shouldn't have been called in the
> first place.
> 
> Cc: stable@vger.kernel.org
> Fixes: fb985e278a30 ("RDMA/mlx5: Use SRCU properly in ODP prefetch")
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
> Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
> ---
>  drivers/infiniband/hw/mlx5/odp.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)

Applied to for-rc

Jason
