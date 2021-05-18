Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1CF2E387060
	for <lists+linux-rdma@lfdr.de>; Tue, 18 May 2021 05:50:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238531AbhERDvZ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 17 May 2021 23:51:25 -0400
Received: from mail-bn8nam12on2081.outbound.protection.outlook.com ([40.107.237.81]:4480
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S237342AbhERDvZ (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 17 May 2021 23:51:25 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aqyYqAkoDsVj69J/AU60LFUYbHkvLjxpskR0NB2IyGSSp86+qhwqvvWaNlDY+Fy7BGVQfuGJeAzgjp7eHgZO4yvereywmwx44IS7EH2qBmEk1OmHt2PYetAb7nt4rRNS9Y6NfZRz9DJHlozKG9tGoa8Az5LA3ojle6YUiHh3iDX2/a1kfx+dy8ZX8VKJgP8TulsnM5eDCY7uJjpI7rpBntHqP+ZynjuOP1pZSu96BjUXCbEc04fjyV3/SHCfksCKJJQSyhQx4EnJMZQ7EHGtao34RxDhQ/lFZo/ek3275d9k5jqpEh15t7cGZE+Z6qsAwxVv31axR4N2PNKt+ftd9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UkNDHyV0q4e1oGgJxqF+W3wLOuj/iwFDBQOYOP6F7As=;
 b=c/jvYwZZ7zhFTh1XavCdWQ59f51lnCovvFqrwBtEwjuFK2pPRZMsm8eb9KkHC+fxG/PLdwwA16v2beEoRMB71+CYtRIDkF+Fr2Oq7wLkSyPqxidMDuNjKSNEFUKmFazWd9JoV3V1z9ukCJobYco6pFukONI14sgDtxQfQrCw4qCppj3RZgHmzP4Vx7RYlQvE6ySOsS1E3iAZXoFkoYuPewwC/nkohPrxrY0M1KsEcO8weugbmx2TpMqlm8VvNrAomDtagCKgbC5VTiILTJToHMosPd90aeeMCgntBMNVIxb1L9hUC7z5yh3JNLgRQmBlJ9aGsRfCgiNxbaQHWMBrkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.34) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UkNDHyV0q4e1oGgJxqF+W3wLOuj/iwFDBQOYOP6F7As=;
 b=sF9AFxhpA0TasKcQnVary6CNcJUcdF+Sy0CGzBbXlxohOw6GPsh3SfyD5Gay5B8VoJx3bSTCMdE7mrrYePcX83r0LVEw9czVcjYlFEMd9gl7nsKh5tCmnR992RIaEb4HDaYi/Tbvzda5rrNBJ+5Tu6Mn1gtintEvWT6y7pl9q7iUlywnNX6bZBhOVcbv/N8au8/Ll0skT21/bDqKpbh1p8WVxibd0Yo2zlg+tcOxyaUdtSAwFNulduxTzRwnWjybCef7nN6EWAFrNHFMgh5qaatKHpP30QSsYVQfslS5D3AlrHuXAK4jZUcEVdHbWKUjeSgaP1vc01dGxgzLxad+nQ==
Received: from MW3PR06CA0023.namprd06.prod.outlook.com (2603:10b6:303:2a::28)
 by BN9PR12MB5366.namprd12.prod.outlook.com (2603:10b6:408:103::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.25; Tue, 18 May
 2021 03:50:06 +0000
Received: from CO1NAM11FT004.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:2a:cafe::80) by MW3PR06CA0023.outlook.office365.com
 (2603:10b6:303:2a::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.26 via Frontend
 Transport; Tue, 18 May 2021 03:50:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.34)
 smtp.mailfrom=nvidia.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.34 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.34; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.34) by
 CO1NAM11FT004.mail.protection.outlook.com (10.13.175.89) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4129.25 via Frontend Transport; Tue, 18 May 2021 03:50:05 +0000
Received: from [172.27.8.102] (172.20.145.6) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Tue, 18 May
 2021 03:50:00 +0000
Subject: Re: [PATCH 01/13] RDMA: Split the alloc_hw_stats() ops to port and
 device variants
To:     Jason Gunthorpe <jgg@nvidia.com>,
        Potnuri Bharat Teja <bharat@chelsio.com>,
        Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>,
        Devesh Sharma <devesh.sharma@broadcom.com>,
        Doug Ledford <dledford@redhat.com>,
        "Faisal Latif" <faisal.latif@intel.com>,
        Gal Pressman <galpress@amazon.com>,
        "Leon Romanovsky" <leon@kernel.org>, <linux-rdma@vger.kernel.org>,
        Mike Marciniszyn <mike.marciniszyn@cornelisnetworks.com>,
        Naresh Kumar PBS <nareshkumar.pbs@broadcom.com>,
        Selvin Xavier <selvin.xavier@broadcom.com>,
        Shiraz Saleem <shiraz.saleem@intel.com>,
        Yossi Leybovich <sleybo@amazon.com>,
        Somnath Kotur <somnath.kotur@broadcom.com>,
        Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>,
        Yishai Hadas <yishaih@nvidia.com>,
        "Zhu Yanjun" <zyjzyj2000@gmail.com>
CC:     Greg KH <gregkh@linuxfoundation.org>,
        Kees Cook <keescook@chromium.org>,
        Nathan Chancellor <nathan@kernel.org>
References: <1-v1-34c90fa45f1c+3c7b0-port_sysfs_jgg@nvidia.com>
From:   Mark Zhang <markzhang@nvidia.com>
Message-ID: <b39b0550-6602-be80-7343-349a6f6f30a9@nvidia.com>
Date:   Tue, 18 May 2021 11:49:57 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <1-v1-34c90fa45f1c+3c7b0-port_sysfs_jgg@nvidia.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [172.20.145.6]
X-ClientProxiedBy: HQMAIL111.nvidia.com (172.20.187.18) To
 HQMAIL107.nvidia.com (172.20.187.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ca6ad825-f466-492a-5208-08d919b0065d
X-MS-TrafficTypeDiagnostic: BN9PR12MB5366:
X-Microsoft-Antispam-PRVS: <BN9PR12MB5366D876E7004211DD73F2C0C72C9@BN9PR12MB5366.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4941;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cT7+tUWixOFH0b2YbUjCEfw9erlZhYU2Y3+PQN0Xr0ERA1ipMimrfxp49obIp+2fk6BDaBibIHa1AN0PUMU91p+bfjeijuQsvglUqsKfqq7y12Z8NtmS7wa5gReNxm7lnfl3Txt1acxJqb3fWLhW51B1qolcJW9JMJefilUpGr+X/guVDlWbq1ffnReiaHnpUytwLU7Z2wZmyDfzzjPIP/DnUTNvBivFk7qBVQ1cBiq3pIozS0N6w3ZoFAtahkZM3E+r3smOP9IhrhSILwG9ylIwD8pSqt5EeF9UIvlFVPUjjtK86Q/FdptlVZJAm1ByQ7fEcLRFklHWDGqdRMtUzkNTB8Vd2zX1/bWjV8LPDyeanV97hVuVAXhp2dIKqFpTUBRhPYQQ233zUnPHjmMVG3rlSTnQuN14J4bL/nZlbipT819LJa9iTYYKxrfumNFGeW0+IAg4ALLnLzPEiMf9l5/oDGqbCMkjxNnyXZsAHaMjulOLuudf6sL9z639rUkS8eZeimSdndVRwkBgoDrj84y/3hX6wLg0GMMTCucuYgveNMzx9fUTaznqPgfrWu2UWB8STF0b9TF0wjHzjO0z5GHcRODta3/9CvXPLVdNpsPN+2NCEI2d0lEeK2Pz7KE/UmbBwIAa2pM8/ocRmSMM0a4VeHHoXapir0w+Sd6oxT9f5snFMLnBADZhX32BST2m9W9wffwyu3/naU8FxK47tgZ8Y9I4je8cdOWYGGoqC40fXvRBXdiFaaDzsFex2GVn
X-Forefront-Antispam-Report: CIP:216.228.112.34;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid03.nvidia.com;CAT:NONE;SFS:(4636009)(136003)(39860400002)(396003)(346002)(376002)(36840700001)(46966006)(83380400001)(16576012)(54906003)(110136005)(316002)(5660300002)(2906002)(8676002)(36906005)(8936002)(86362001)(70206006)(2616005)(7416002)(36756003)(478600001)(16526019)(53546011)(7636003)(82740400003)(4326008)(31686004)(36860700001)(336012)(26005)(6666004)(47076005)(426003)(921005)(31696002)(186003)(82310400003)(70586007)(356005)(43740500002)(83996005)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2021 03:50:05.9014
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ca6ad825-f466-492a-5208-08d919b0065d
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.34];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT004.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5366
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 5/18/2021 12:47 AM, Jason Gunthorpe wrote:
> External email: Use caution opening links or attachments
> 
> 
> This is being used to implement both the port and device global stats,
> which is causing some confusion in the drivers. For instance EFA and i40iw
> both seem to be misusing the device stats.
> 
> Split it into two ops so drivers that don't support one or the other can
> leave the op NULL'd, making the calling code a little simpler to
> understand.
> 
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
> ---
>   drivers/infiniband/core/counters.c          |  4 +-
>   drivers/infiniband/core/device.c            |  3 +-
>   drivers/infiniband/core/nldev.c             |  2 +-
>   drivers/infiniband/core/sysfs.c             | 15 +++-
>   drivers/infiniband/hw/bnxt_re/hw_counters.c |  7 +-
>   drivers/infiniband/hw/bnxt_re/hw_counters.h |  4 +-
>   drivers/infiniband/hw/bnxt_re/main.c        |  2 +-
>   drivers/infiniband/hw/cxgb4/provider.c      |  9 +--
>   drivers/infiniband/hw/efa/efa.h             |  3 +-
>   drivers/infiniband/hw/efa/efa_main.c        |  3 +-
>   drivers/infiniband/hw/efa/efa_verbs.c       | 11 ++-
>   drivers/infiniband/hw/hfi1/verbs.c          | 86 ++++++++++-----------
>   drivers/infiniband/hw/i40iw/i40iw_verbs.c   | 19 ++++-
>   drivers/infiniband/hw/mlx4/main.c           | 25 ++++--
>   drivers/infiniband/hw/mlx5/counters.c       | 42 +++++++---
>   drivers/infiniband/sw/rxe/rxe_hw_counters.c |  7 +-
>   drivers/infiniband/sw/rxe/rxe_hw_counters.h |  4 +-
>   drivers/infiniband/sw/rxe/rxe_verbs.c       |  2 +-
>   include/rdma/ib_verbs.h                     | 13 ++--
>   19 files changed, 158 insertions(+), 103 deletions(-)
> 

[...]

> diff --git a/drivers/infiniband/core/sysfs.c b/drivers/infiniband/core/sysfs.c
> index 05b702de00e89b..29082d8d45fc4f 100644
> --- a/drivers/infiniband/core/sysfs.c
> +++ b/drivers/infiniband/core/sysfs.c
> @@ -981,8 +981,15 @@ static void setup_hw_stats(struct ib_device *device, struct ib_port *port,
>          struct rdma_hw_stats *stats;
>          int i, ret;
> 
> -       stats = device->ops.alloc_hw_stats(device, port_num);
> -
> +       if (port_num) {
> +               if (!device->ops.alloc_hw_port_stats)
> +                       return;

Do we need this "if (!device->ops.alloc_hw_port_stats)" here?

> +               stats = device->ops.alloc_hw_port_stats(device, port_num);
> +       } else {
> +               if (!device->ops.alloc_hw_device_stats)
> +                       return;

And here?

> +               stats = device->ops.alloc_hw_device_stats(device);
> +       }
>          if (!stats)
>                  return;
> 
> @@ -1165,7 +1172,7 @@ static int add_port(struct ib_core_device *coredev, int port_num)
>           * port, so holder should be device. Therefore skip per port conunter
>           * initialization.
>           */
> -       if (device->ops.alloc_hw_stats && port_num && is_full_dev)
> +       if (device->ops.alloc_hw_port_stats && port_num && is_full_dev)
>                  setup_hw_stats(device, p, port_num);
> 
>          list_add_tail(&p->kobj.entry, &coredev->port_list);
> @@ -1409,7 +1416,7 @@ int ib_device_register_sysfs(struct ib_device *device)
>          if (ret)
>                  return ret;
> 
> -       if (device->ops.alloc_hw_stats)
> +       if (device->ops.alloc_hw_device_stats)
>                  setup_hw_stats(device, NULL, 0);
> 
>          return 0;

[...]

> diff --git a/drivers/infiniband/hw/cxgb4/provider.c b/drivers/infiniband/hw/cxgb4/provider.c
> index 3f1893e180ddf3..c0f01799f4a0b9 100644
> --- a/drivers/infiniband/hw/cxgb4/provider.c
> +++ b/drivers/infiniband/hw/cxgb4/provider.c
> @@ -377,14 +377,11 @@ static const char * const names[] = {
>          [IP6OUTRSTS] = "ip6OutRsts"
>   };
> 
> -static struct rdma_hw_stats *c4iw_alloc_stats(struct ib_device *ibdev,
> -                                             u32 port_num)
> +static struct rdma_hw_stats *c4iw_alloc_port_stats(struct ib_device *ibdev,
> +                                                  u32 port_num)
>   {
>          BUILD_BUG_ON(ARRAY_SIZE(names) != NR_COUNTERS);
> 
> -       if (port_num != 0)
> -               return NULL;
> -

I'm not familiar with this driver, but if port_num must be 0 here, does 
it mean this is per-device not per-port?

