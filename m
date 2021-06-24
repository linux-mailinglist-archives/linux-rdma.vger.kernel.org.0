Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D955C3B297E
	for <lists+linux-rdma@lfdr.de>; Thu, 24 Jun 2021 09:39:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231652AbhFXHls (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 24 Jun 2021 03:41:48 -0400
Received: from mail-bn7nam10on2053.outbound.protection.outlook.com ([40.107.92.53]:32085
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231558AbhFXHlp (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 24 Jun 2021 03:41:45 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JIL83XoBI5y5I9I5VruQgGW5LXBnImZpHQKIiy9u2+wsOmGxgXiFpNV5bDNu5z05ULujmoBdFCGmdHIQ4oMCQlUDsuMyLaxJElfNYuHYUiZnx2TauzxvRfefZi7DlKCaymkwhPSEOR9K2vZw/GRiVjgN+CruZH1GV69R9sso23doSDLnCslbBSEUHmTHvCPG4707xMUV9QgzG9AgjEU9ag/D2x0YN/Qi1f0bzP9UBIXQzQMN8iEt3OZL0kDcIo+YECVgZO8CNFKGHzL861QZ2Jt8gDtSviDcnjl7SKGwRikmvU/LQBD+oqs/Bv8MxC1nOod+OhJtXKyEhbljRqzlVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZK+7iixMM+uhFb1jP7zsZBE2wh6UsTKAuH8zknRogfI=;
 b=mbF69o/jnDNTXaS1IjDEvq1Bs+9k1eGD9Z0qOYm8640vUNzVevV1rc1qKVi75/eUgzMDGEgNuBnJfASSpiTPxNlY0yFJ5tq/33CWtrT6wRl8wZm8nGrh3s207Qyb0j2MUhdWXh28tgelBb9VCS1z+GZ6uksWpvhmmDvQi9I7zI2eHzjdWaJA7MJNNG3MSZSTC2ZGnphVs9aZf1l7fSpaR/mRd0krQ1XMXh8QMnpqbRrDAg9etTDUQcJV3ZUwvg5FuAEdVJFQG527vxKSN212t0FwbSXagcyYzOpFwGr1nz9z4fodlmRwwRqBVyokzlSYAlZJlbT/ZgmwR4Lht9ZyLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.34) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZK+7iixMM+uhFb1jP7zsZBE2wh6UsTKAuH8zknRogfI=;
 b=PKMsTxXEM7QdXtTKWsgXqaFVyxSMjRAP6s6Ph/LGtdROdAMU9d1tAcsLHZs6ZwQMasYJPGxIAee1QDpIXfsWY70cUrdVEeElkOh5vE9dgeAljqnndRJm0Ae2BMwB2Eh8AIMpAs2/kpDwFPXqCtIPIntpaPnL6XvF+RAtMSW0xYY1XEZiBKJv/bkECH0PevuBvoEoN4AwUemNrijeXReyfTuvEeEBmAe9dNHOpaJMZEJVFHY2bjsJ/CJZzO+q80zCLG5YPm84cWW14YqQqmvL7umwe1kQcVzrIWVrAT/3/uPssE29UvYioeB446o0SVqOibDVnFGNTmM9FJ4fBllbQw==
Received: from DM6PR13CA0019.namprd13.prod.outlook.com (2603:10b6:5:bc::32) by
 BYAPR12MB2806.namprd12.prod.outlook.com (2603:10b6:a03:70::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4242.19; Thu, 24 Jun 2021 07:39:24 +0000
Received: from DM6NAM11FT049.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:bc:cafe::53) by DM6PR13CA0019.outlook.office365.com
 (2603:10b6:5:bc::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4287.8 via Frontend
 Transport; Thu, 24 Jun 2021 07:39:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.34)
 smtp.mailfrom=nvidia.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.34 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.34; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.34) by
 DM6NAM11FT049.mail.protection.outlook.com (10.13.172.188) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4264.18 via Frontend Transport; Thu, 24 Jun 2021 07:39:24 +0000
Received: from [172.27.13.40] (172.20.187.6) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Thu, 24 Jun
 2021 07:39:19 +0000
Subject: Re: [PATCH v2 rdma-next] RDMA/mlx5: Enable Relaxed Ordering by
 default for kernel ULPs
To:     Leon Romanovsky <leon@kernel.org>
CC:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Avihai Horon <avihaih@nvidia.com>,
        <linux-kernel@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Bart Van Assche <bvanassche@acm.org>,
        Tom Talpey <tom@talpey.com>,
        Santosh Shilimkar <santosh.shilimkar@oracle.com>,
        Chuck Lever III <chuck.lever@oracle.com>,
        Keith Busch <kbusch@kernel.org>,
        David Laight <David.Laight@aculab.com>,
        Honggang LI <honli@redhat.com>
References: <b7e820aab7402b8efa63605f4ea465831b3b1e5e.1623236426.git.leonro@nvidia.com>
 <9c5b7ae5-8578-3008-5e78-02e77e121cda@nvidia.com> <YNQoY7MRdYMNAUPg@unreal>
From:   Max Gurtovoy <mgurtovoy@nvidia.com>
Message-ID: <1ef0ac51-4c7d-d79d-cb30-2e219f74c8c1@nvidia.com>
Date:   Thu, 24 Jun 2021 10:39:16 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <YNQoY7MRdYMNAUPg@unreal>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [172.20.187.6]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 HQMAIL107.nvidia.com (172.20.187.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 994f3af9-ce0a-45cb-bda0-08d936e3303e
X-MS-TrafficTypeDiagnostic: BYAPR12MB2806:
X-Microsoft-Antispam-PRVS: <BYAPR12MB28061AB99925EE2C0CC6FAC5DE079@BYAPR12MB2806.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WD1q+2BP6nLvHK5h4/wpxneNqwYM252pNTbudO4h+yTF4iOaqTJ8MjCBBsY3Pt9fwyWzYT8ZWEBrq63bBKaJQEX7V1jX+LV1Y4GkjCwSMSBTk4N7ScERGgrBYW8GsG27+bfkUVPBL42YxeaNQq5PgbqGUBrAzcgA5hs44BBp0HQzXDVpJpAuyv2GuOszUmURDNNOu/OewKajTPopFrvc/ebk9hxB8F6HhdzCLIuT4jDj4nxQeodzQ9lzpXSRvhjl2TuNGa8oCk3zaXC0+6bWjFNPUtBonl75jGLpujp4Bfo4V6uM3XECeoEyaxxB1T871UMv/1hIykUOr1rYC6ZmsSubyTk1liam3tcI+qukewtv2iSzag0eni4a/9kg6e3VTFY0XPFWatV1WzJOpDVahkP5bGIKx9Fm99h8ABa4pi18CETTa1Z1vARP/ocfCakeolwjRBCz8RCHm7cso/9ATtn6gUrCZaP+SV32KfA3oirf6UMgTCAwey3MoFCCbPqKAiYBQRFWvudcaIE4PyppdMcKUrRiI65QdAao3Ozpqje8V1EnzaNXzc+XvKbo0zDjEUb2briRiR6rnI3eXNXrGVCqqvoU+8IlWZeAQ0l6cilp5zxkylwa1TbVixUF97evMKIHGBCNXYjiuPJtVfxZBtOOKTf2ujuO9R62Ca4NSUBWcS3uxwhFDLf1UJVhzMGNL5KprFljVnrvukoC9NZ/Xgdl6We0HjyJLL2eIjy6Wf736mSMsc7H2RDA/qoTPjiOr87imFYOqAwxDDPBzJv+IOjfdlHTYsPpQvLUpbDzW6CEU4/D90IDM7Qq8CprobN0tPv8QMUfTCYB/+yqdiHoHfb8F27ASF/rPmRPtJIePGo=
X-Forefront-Antispam-Report: CIP:216.228.112.34;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid03.nvidia.com;CAT:NONE;SFS:(4636009)(136003)(396003)(376002)(346002)(39860400002)(36840700001)(46966006)(4326008)(2616005)(7416002)(70586007)(70206006)(426003)(966005)(16576012)(316002)(336012)(478600001)(8936002)(8676002)(36906005)(83380400001)(82740400003)(2906002)(356005)(7636003)(6666004)(36756003)(54906003)(31696002)(86362001)(16526019)(53546011)(82310400003)(47076005)(186003)(36860700001)(6916009)(31686004)(26005)(5660300002)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2021 07:39:24.3400
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 994f3af9-ce0a-45cb-bda0-08d936e3303e
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.34];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT049.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2806
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


On 6/24/2021 9:38 AM, Leon Romanovsky wrote:
> On Thu, Jun 24, 2021 at 02:06:46AM +0300, Max Gurtovoy wrote:
>> On 6/9/2021 2:05 PM, Leon Romanovsky wrote:
>>> From: Avihai Horon <avihaih@nvidia.com>
>>>
>>> Relaxed Ordering is a capability that can only benefit users that support
>>> it. All kernel ULPs should support Relaxed Ordering, as they are designed
>>> to read data only after observing the CQE and use the DMA API correctly.
>>>
>>> Hence, implicitly enable Relaxed Ordering by default for kernel ULPs.
>>>
>>> Signed-off-by: Avihai Horon <avihaih@nvidia.com>
>>> Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
>>> ---
>>> Changelog:
>>> v2:
>>>    * Dropped IB/core patch and set RO implicitly in mlx5 exactly like in
>>>      eth side of mlx5 driver.
>>> v1: https://lore.kernel.org/lkml/cover.1621505111.git.leonro@nvidia.com
>>>    * Enabled by default RO in IB/core instead of changing all users
>>> v0: https://lore.kernel.org/lkml/20210405052404.213889-1-leon@kernel.org
>>> ---
>>>    drivers/infiniband/hw/mlx5/mr.c | 10 ++++++----
>>>    drivers/infiniband/hw/mlx5/wr.c |  5 ++++-
>>>    2 files changed, 10 insertions(+), 5 deletions(-)
>>>
>>> diff --git a/drivers/infiniband/hw/mlx5/mr.c b/drivers/infiniband/hw/mlx5/mr.c
>>> index 3363cde85b14..2182e76ae734 100644
>>> --- a/drivers/infiniband/hw/mlx5/mr.c
>>> +++ b/drivers/infiniband/hw/mlx5/mr.c
>>> @@ -69,6 +69,7 @@ static void set_mkc_access_pd_addr_fields(void *mkc, int acc, u64 start_addr,
>>>    					  struct ib_pd *pd)
>>>    {
>>>    	struct mlx5_ib_dev *dev = to_mdev(pd->device);
>>> +	bool ro_pci_enabled = pcie_relaxed_ordering_enabled(dev->mdev->pdev);
>>>    	MLX5_SET(mkc, mkc, a, !!(acc & IB_ACCESS_REMOTE_ATOMIC));
>>>    	MLX5_SET(mkc, mkc, rw, !!(acc & IB_ACCESS_REMOTE_WRITE));
>>> @@ -78,10 +79,10 @@ static void set_mkc_access_pd_addr_fields(void *mkc, int acc, u64 start_addr,
>>>    	if (MLX5_CAP_GEN(dev->mdev, relaxed_ordering_write))
>>>    		MLX5_SET(mkc, mkc, relaxed_ordering_write,
>>> -			 !!(acc & IB_ACCESS_RELAXED_ORDERING));
>>> +			 acc & IB_ACCESS_RELAXED_ORDERING && ro_pci_enabled);
>>>    	if (MLX5_CAP_GEN(dev->mdev, relaxed_ordering_read))
>>>    		MLX5_SET(mkc, mkc, relaxed_ordering_read,
>>> -			 !!(acc & IB_ACCESS_RELAXED_ORDERING));
>>> +			 acc & IB_ACCESS_RELAXED_ORDERING && ro_pci_enabled);
>> Jason,
>>
>> If it's still possible to add small change, it will be nice to avoid
>> calculating "acc & IB_ACCESS_RELAXED_ORDERING && ro_pci_enabled" twice.
> The patch is part of for-next now, so feel free to send followup patch.
>
> Thanks
>
> diff --git a/drivers/infiniband/hw/mlx5/mr.c b/drivers/infiniband/hw/mlx5/mr.c
> index c1e70c99b70c..c4f246c90c4d 100644
> --- a/drivers/infiniband/hw/mlx5/mr.c
> +++ b/drivers/infiniband/hw/mlx5/mr.c
> @@ -69,7 +69,8 @@ static void set_mkc_access_pd_addr_fields(void *mkc, int acc, u64 start_addr,
>                                            struct ib_pd *pd)
>   {
>          struct mlx5_ib_dev *dev = to_mdev(pd->device);
> -       bool ro_pci_enabled = pcie_relaxed_ordering_enabled(dev->mdev->pdev);
> +       bool ro_pci_enabled = acc & IB_ACCESS_RELAXED_ORDERING &&
> +                             pcie_relaxed_ordering_enabled(dev->mdev->pdev);
>
>          MLX5_SET(mkc, mkc, a, !!(acc & IB_ACCESS_REMOTE_ATOMIC));
>          MLX5_SET(mkc, mkc, rw, !!(acc & IB_ACCESS_REMOTE_WRITE));
> @@ -78,11 +79,9 @@ static void set_mkc_access_pd_addr_fields(void *mkc, int acc, u64 start_addr,
>          MLX5_SET(mkc, mkc, lr, 1);
>
>          if (MLX5_CAP_GEN(dev->mdev, relaxed_ordering_write))
> -               MLX5_SET(mkc, mkc, relaxed_ordering_write,
> -                        (acc & IB_ACCESS_RELAXED_ORDERING) && ro_pci_enabled);
> +               MLX5_SET(mkc, mkc, relaxed_ordering_write, ro_pci_enabled);
>          if (MLX5_CAP_GEN(dev->mdev, relaxed_ordering_read))
> -               MLX5_SET(mkc, mkc, relaxed_ordering_read,
> -                        (acc & IB_ACCESS_RELAXED_ORDERING) && ro_pci_enabled);
> +               MLX5_SET(mkc, mkc, relaxed_ordering_read, ro_pci_enabled);
>
>          MLX5_SET(mkc, mkc, pd, to_mpd(pd)->pdn);
>          MLX5_SET(mkc, mkc, qpn, 0xffffff);
> (END)
>
Yes this looks good.

Can you/Avihai create a patch from this ? or I'll do it ?


>>
