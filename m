Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EAADB3B2DFB
	for <lists+linux-rdma@lfdr.de>; Thu, 24 Jun 2021 13:36:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229448AbhFXLia (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 24 Jun 2021 07:38:30 -0400
Received: from mail-bn8nam11on2063.outbound.protection.outlook.com ([40.107.236.63]:46624
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229813AbhFXLi3 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 24 Jun 2021 07:38:29 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PKlW6mCYfLjkM/0ZeuR8PQsqXBxafJrRXLTN/49kTNCdPEXgFLJGEYz/DjlCTcARsq+ivhlhG58+FRcpoM2aX8TuOEJSFF5TPvAlBZ5APTaIERk/GmeWTp19X2uNV8ZdDstK4YBDIFSX2IaARwnltBbqgBpHhPDgxeVA6ZxnklJ2Vs2vqemFi7mVVMZ5w9MzhtqYOLBc3LF+6Q+F6IcRL1HcIi3KyIPDbI5LA2Yce+d4n1GClnIAKRM56dOTBYhMSsTVzZo08OTctsiVXuMT3UsA40GCm2mORwvRmMcudk2cNfuxjJWLN7Ap3XSe6ovDZBqCjxIOas6Y4yCDZ2U5HQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gYAKZuyekt1lEEr6kETKPzHGPs7QGQIs8f9VyxLZkJc=;
 b=j0U4LiiFcFFPhPDo7MBmEQgo6NafW9wfowoVDC3u8jU6orRvZQoYanlFyA/iPBLQc3BNrzPXh+hTWjAp81XOtxXG9KHgx9TBZOvuhf7zlrnJKDQIMOZPujlBY3+UU2XrBDxmAqRAwkkokRRYLdFqGb70DsM7O/+u42nNdcnCaEerHNJUL0anHbe85sPUSG6aurmaDcHMoOD4gnXzBV4U1dPJGSky31zLf/ztpauTOOXygVZ6hA1nhlly2GNRORGmxl2BxbzeCdfi9/M5KUFPc4u6dSsk8VDHuIrRNDdmFtz92pVSDkiB+4hlQ8Oa0MYK6D585cFo2WatzmiXG6X8ow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gYAKZuyekt1lEEr6kETKPzHGPs7QGQIs8f9VyxLZkJc=;
 b=UcJvQomDcx/uaZSNZUVLms20++hm0Iy/JhIXD3P4IlvgCB6AJ9UyqxJMLa3mpb5SiwMnKWp0glVrx+MENv+RvPuNmWyF7l73E1wgG0OyRyOPcbuY5PSNdWZGWrdIF0Yrrs58Qj2TLF+v91NJBUbWwqP1nvEGkYZR8ib+/pwEmSFlfnFtmFoV/CrCa2nOGk7/AlvBFkFr6VOOW3La43UsV0iIxmEyPnknpvZ0HUP9hnvteL7ZOjVfvGEHPIa826ZDVDdgoyIt9z9vQujhxEYTkkXn5NA0eq3OQwmZDg59BiXCoJ7IMetQvAScT6cmynqlhUK3k+zZwTLC0J85UCMUNg==
Authentication-Results: nvidia.com; dkim=none (message not signed)
 header.d=none;nvidia.com; dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL1PR12MB5301.namprd12.prod.outlook.com (2603:10b6:208:31f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4264.20; Thu, 24 Jun
 2021 11:36:08 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::3d51:a3b9:8611:684e]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::3d51:a3b9:8611:684e%8]) with mapi id 15.20.4264.020; Thu, 24 Jun 2021
 11:36:08 +0000
Date:   Thu, 24 Jun 2021 08:36:07 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Max Gurtovoy <mgurtovoy@nvidia.com>
Cc:     Leon Romanovsky <leon@kernel.org>,
        Doug Ledford <dledford@redhat.com>,
        Avihai Horon <avihaih@nvidia.com>,
        linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>,
        Bart Van Assche <bvanassche@acm.org>,
        Tom Talpey <tom@talpey.com>,
        Santosh Shilimkar <santosh.shilimkar@oracle.com>,
        Chuck Lever III <chuck.lever@oracle.com>,
        Keith Busch <kbusch@kernel.org>,
        David Laight <David.Laight@aculab.com>,
        Honggang LI <honli@redhat.com>
Subject: Re: [PATCH v2 rdma-next] RDMA/mlx5: Enable Relaxed Ordering by
 default for kernel ULPs
Message-ID: <20210624113607.GN2371267@nvidia.com>
References: <b7e820aab7402b8efa63605f4ea465831b3b1e5e.1623236426.git.leonro@nvidia.com>
 <9c5b7ae5-8578-3008-5e78-02e77e121cda@nvidia.com>
 <YNQoY7MRdYMNAUPg@unreal>
 <1ef0ac51-4c7d-d79d-cb30-2e219f74c8c1@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1ef0ac51-4c7d-d79d-cb30-2e219f74c8c1@nvidia.com>
X-Originating-IP: [47.55.113.94]
X-ClientProxiedBy: MN2PR18CA0022.namprd18.prod.outlook.com
 (2603:10b6:208:23c::27) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (47.55.113.94) by MN2PR18CA0022.namprd18.prod.outlook.com (2603:10b6:208:23c::27) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4264.19 via Frontend Transport; Thu, 24 Jun 2021 11:36:08 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1lwNeR-00C1Ji-EM; Thu, 24 Jun 2021 08:36:07 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 16d055a8-c331-4625-7edc-08d93704428b
X-MS-TrafficTypeDiagnostic: BL1PR12MB5301:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BL1PR12MB53014794189E0917F0896E1BC2079@BL1PR12MB5301.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JyspseoY6fW3zDLhQoUeEpQ9VFBqiG2V7ww4XH2M8742klSGZ8QYaSlRkPu/nM3U/LYfuy4bqyc0pSz9frYGoKc5R/thEfwCh+Tn927ed1dYjd+XtvvSVLg/fgK229ocTFArcS3XdB+H1ET3j5r5k9AJCawiCKcj86sHe0NJQiBjI3BYQSHfQVt217Yf7Ww824BWnBRXt76Jff9tWaBNonc43bdfZ0XdEQDQ7Pe17rIpLyugFGEZ3l1mDq0nQNgVxngOrXq8xwdCPBzTW25MrrhKxUtxSMcQWAXs4wNWeah9ojBh4+TCm/mpLP/dwDjR4a5usOidZbHdTnLkoAeHKpgf2Cm3wDkXXFjQkS1YIa/jR8xY1IMPLH0Vtq33K17NjH9dPxONyOpOip+KmCEunhMWMtVTtpTK0KksITYHk/lfxPbAirelB/YP+pNHYGxJ3YsAIgijWAzyHP93QEmDgfUZHwIkAQnPY03OyD0qOYRk0hvwP49RabKGOjjeGC00BRgQ19s/NwcoU+fQqtyR5GSi5OsLmnHvOZM6iyHXxZ4Zib4AitzF1LboD8CS3jGp7UZWeFQ1iJfn4IvXsLThrQTHJHyG7K4W1kw3tiif0liM26Z1hLkLL3TXveygj7gmNoyl6Boq9wBCrmmQzJV9VCZ1zJYHT7Nxm5wYv0t8BCl1xe5SZ+7FLgV2C15pUZsYANgdelUMRkMjKBj2+eMZi1OKtRk4AWtean4miQYKJUTOqX/Q0UWgKSzVqcWxBWfT+/r7wju38VQfUkFpyOYC8sMI2Hcxtvhaq3Iq6uUEtghRXziHqzRc/2vZNIL7aUeD
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5506.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(366004)(39860400002)(136003)(346002)(396003)(66946007)(6636002)(186003)(4326008)(1076003)(33656002)(26005)(38100700002)(36756003)(66556008)(66476007)(37006003)(8676002)(316002)(6862004)(86362001)(2616005)(426003)(8936002)(9746002)(54906003)(2906002)(83380400001)(5660300002)(7416002)(53546011)(966005)(478600001)(9786002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?hPlumrmELZgHDoUALpXO9m4vO8lIn3Ownon2zXFBOpS71P61JyAwJowQSkua?=
 =?us-ascii?Q?o7uC3GG09lSq0k63iN0CaK0H4FlMd4kUX2xUgNq9lLtLU7/oqraGIkLomSeb?=
 =?us-ascii?Q?Y7mi7USsDQqKa2m/1+M5h2erT//LsQitFzDcbmBmrNmfNOg5hmfMq26su45b?=
 =?us-ascii?Q?RGA9GKU2046ZAa4wOYiLFHn8nS19QMSkhUF9lvuT4Z7x2ObV3HGmfxY0YIPJ?=
 =?us-ascii?Q?BLtF1OlPMzQ5nIZ3Gnh0ugBiAYhdcinFqgMrDT+e9RhnARvZFtJYHapti1Bq?=
 =?us-ascii?Q?EoBrXlujtwNaLSSDEgo30pvnyV8QihypARkSiogzMu6EN2ChzoPCvDO5nhzB?=
 =?us-ascii?Q?G4gIZkA6pND2tMGarkgBv2fNr1OSkEdxt/JrrRYZ1XWyuWtOmAJMpyjcX/Vr?=
 =?us-ascii?Q?8oQzbTlD8tMM9vQQ+TG9rmxoNYuKnI11wpfQp88fUnHHF83NoCj0FaBqEKFI?=
 =?us-ascii?Q?vqzbHOr5oWmOMEYQ1WsRwWhCkVSSLZpWBMsPOf+0wV5uNL0z+L9oUKhX4mUG?=
 =?us-ascii?Q?WYeIDJQKuZw/bDnwpci66ScHxeuYvqLl0cw00xePtdTEltAtXIGx4HTOBCPp?=
 =?us-ascii?Q?YYKUR3/qYN6+iBSX3GVUso2E6xSeVQpuvPgA8coQYtx0R+8FF5QA/Q6tbm4E?=
 =?us-ascii?Q?2dX1WZHweJ2hr4tsn2JFtGzsAx6Wgf+O/cw3PNGKfwf5eOHSjn1FJudfPkTc?=
 =?us-ascii?Q?ZaWCBROdzdzxIF6h2TfmYyOF1141hmRxKeSgvwtXv0RI7owOAXQcxZw/UE+p?=
 =?us-ascii?Q?QT+zkpdymYeI1oOO7IxIlxK1JYSPPQA+oLEQzkT8Z4TzN+VHcyuySKVFefuh?=
 =?us-ascii?Q?9xz+1ThBmvA9KN/Cl5jNKEL1LsSiijo/G3gW7KZiJ+qiLKXj+fZOAdViwxiN?=
 =?us-ascii?Q?8V5n01UPxC1kuerkEeFBIOmsfWZMxVSIVl7cVs6bLylrcrW0tk2V3Rra1vx7?=
 =?us-ascii?Q?/piBO1krMBx0/tP6OisvSTLmr7Rrhy2yiKMua+WnjboNVx3wbr8PId439z8y?=
 =?us-ascii?Q?r+PS7zO3Xbga29zRENbOZHZtCK0HtW6psg9AolzWXdu3NmC+Fo/U2xm+47gp?=
 =?us-ascii?Q?36NdgOmizuzIHjK+iNOgaaQ7Tm6S2ruwUVSM5hWoTRvcSePieLADPfg3hpQb?=
 =?us-ascii?Q?q5OocgVxm6Hc8ljmJ8Ng+lRQejjsmjmIyFn6APOTj9u5uv2QbIPqgOwZAABb?=
 =?us-ascii?Q?pzMjziQGMLeq7nmyOHizD93ouHIKoMZkV5hz2+k0aP+6X3zlsrcOtKXsLmT7?=
 =?us-ascii?Q?HLYmq73zpOi9Jk5yMCrXDTIX/l1TzZBGVre3eY/eAikyv7Mb7AlxvMo5WFUA?=
 =?us-ascii?Q?SHk80V3KydP6nIRypZ5pxzgA?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 16d055a8-c331-4625-7edc-08d93704428b
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2021 11:36:08.7571
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mMLehWOAweMtuIM58sHlI5gkFZ0eEOK4h3owUzAvOtoabmYYKa/cnCrITxNp/5ja
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5301
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Jun 24, 2021 at 10:39:16AM +0300, Max Gurtovoy wrote:
> 
> On 6/24/2021 9:38 AM, Leon Romanovsky wrote:
> > On Thu, Jun 24, 2021 at 02:06:46AM +0300, Max Gurtovoy wrote:
> > > On 6/9/2021 2:05 PM, Leon Romanovsky wrote:
> > > > From: Avihai Horon <avihaih@nvidia.com>
> > > > 
> > > > Relaxed Ordering is a capability that can only benefit users that support
> > > > it. All kernel ULPs should support Relaxed Ordering, as they are designed
> > > > to read data only after observing the CQE and use the DMA API correctly.
> > > > 
> > > > Hence, implicitly enable Relaxed Ordering by default for kernel ULPs.
> > > > 
> > > > Signed-off-by: Avihai Horon <avihaih@nvidia.com>
> > > > Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
> > > > Changelog:
> > > > v2:
> > > >    * Dropped IB/core patch and set RO implicitly in mlx5 exactly like in
> > > >      eth side of mlx5 driver.
> > > > v1: https://lore.kernel.org/lkml/cover.1621505111.git.leonro@nvidia.com
> > > >    * Enabled by default RO in IB/core instead of changing all users
> > > > v0: https://lore.kernel.org/lkml/20210405052404.213889-1-leon@kernel.org
> > > >    drivers/infiniband/hw/mlx5/mr.c | 10 ++++++----
> > > >    drivers/infiniband/hw/mlx5/wr.c |  5 ++++-
> > > >    2 files changed, 10 insertions(+), 5 deletions(-)
> > > > 
> > > > diff --git a/drivers/infiniband/hw/mlx5/mr.c b/drivers/infiniband/hw/mlx5/mr.c
> > > > index 3363cde85b14..2182e76ae734 100644
> > > > +++ b/drivers/infiniband/hw/mlx5/mr.c
> > > > @@ -69,6 +69,7 @@ static void set_mkc_access_pd_addr_fields(void *mkc, int acc, u64 start_addr,
> > > >    					  struct ib_pd *pd)
> > > >    {
> > > >    	struct mlx5_ib_dev *dev = to_mdev(pd->device);
> > > > +	bool ro_pci_enabled = pcie_relaxed_ordering_enabled(dev->mdev->pdev);
> > > >    	MLX5_SET(mkc, mkc, a, !!(acc & IB_ACCESS_REMOTE_ATOMIC));
> > > >    	MLX5_SET(mkc, mkc, rw, !!(acc & IB_ACCESS_REMOTE_WRITE));
> > > > @@ -78,10 +79,10 @@ static void set_mkc_access_pd_addr_fields(void *mkc, int acc, u64 start_addr,
> > > >    	if (MLX5_CAP_GEN(dev->mdev, relaxed_ordering_write))
> > > >    		MLX5_SET(mkc, mkc, relaxed_ordering_write,
> > > > -			 !!(acc & IB_ACCESS_RELAXED_ORDERING));
> > > > +			 acc & IB_ACCESS_RELAXED_ORDERING && ro_pci_enabled);
> > > >    	if (MLX5_CAP_GEN(dev->mdev, relaxed_ordering_read))
> > > >    		MLX5_SET(mkc, mkc, relaxed_ordering_read,
> > > > -			 !!(acc & IB_ACCESS_RELAXED_ORDERING));
> > > > +			 acc & IB_ACCESS_RELAXED_ORDERING && ro_pci_enabled);
> > > Jason,
> > > 
> > > If it's still possible to add small change, it will be nice to avoid
> > > calculating "acc & IB_ACCESS_RELAXED_ORDERING && ro_pci_enabled" twice.
> > The patch is part of for-next now, so feel free to send followup patch.
> > 
> > Thanks
> > 
> > diff --git a/drivers/infiniband/hw/mlx5/mr.c b/drivers/infiniband/hw/mlx5/mr.c
> > index c1e70c99b70c..c4f246c90c4d 100644
> > +++ b/drivers/infiniband/hw/mlx5/mr.c
> > @@ -69,7 +69,8 @@ static void set_mkc_access_pd_addr_fields(void *mkc, int acc, u64 start_addr,
> >                                            struct ib_pd *pd)
> >   {
> >          struct mlx5_ib_dev *dev = to_mdev(pd->device);
> > -       bool ro_pci_enabled = pcie_relaxed_ordering_enabled(dev->mdev->pdev);
> > +       bool ro_pci_enabled = acc & IB_ACCESS_RELAXED_ORDERING &&
> > +                             pcie_relaxed_ordering_enabled(dev->mdev->pdev);
> > 
> >          MLX5_SET(mkc, mkc, a, !!(acc & IB_ACCESS_REMOTE_ATOMIC));
> >          MLX5_SET(mkc, mkc, rw, !!(acc & IB_ACCESS_REMOTE_WRITE));
> > @@ -78,11 +79,9 @@ static void set_mkc_access_pd_addr_fields(void *mkc, int acc, u64 start_addr,
> >          MLX5_SET(mkc, mkc, lr, 1);
> > 
> >          if (MLX5_CAP_GEN(dev->mdev, relaxed_ordering_write))
> > -               MLX5_SET(mkc, mkc, relaxed_ordering_write,
> > -                        (acc & IB_ACCESS_RELAXED_ORDERING) && ro_pci_enabled);
> > +               MLX5_SET(mkc, mkc, relaxed_ordering_write, ro_pci_enabled);
> >          if (MLX5_CAP_GEN(dev->mdev, relaxed_ordering_read))
> > -               MLX5_SET(mkc, mkc, relaxed_ordering_read,
> > -                        (acc & IB_ACCESS_RELAXED_ORDERING) && ro_pci_enabled);
> > +               MLX5_SET(mkc, mkc, relaxed_ordering_read, ro_pci_enabled);
> > 
> >          MLX5_SET(mkc, mkc, pd, to_mpd(pd)->pdn);
> >          MLX5_SET(mkc, mkc, qpn, 0xffffff);
> > (END)
> > 
> Yes this looks good.
> 
> Can you/Avihai create a patch from this ? or I'll do it ?

I'd be surpised if it matters.. CSE and all

Jason
