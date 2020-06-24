Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B1C95207C5C
	for <lists+linux-rdma@lfdr.de>; Wed, 24 Jun 2020 21:46:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391371AbgFXTqt (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 24 Jun 2020 15:46:49 -0400
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:16148 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391367AbgFXTqt (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 24 Jun 2020 15:46:49 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5ef3ad7a0000>; Wed, 24 Jun 2020 12:46:02 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Wed, 24 Jun 2020 12:46:48 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Wed, 24 Jun 2020 12:46:48 -0700
Received: from HQMAIL107.nvidia.com (172.20.187.13) by HQMAIL109.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 24 Jun
 2020 19:46:39 +0000
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.171)
 by HQMAIL107.nvidia.com (172.20.187.13) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Wed, 24 Jun 2020 19:46:39 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J1Zd/nYREDeShKZVaUlyRRSnDoW58H5QAHM/hWUPicdQWn3OrAilQXWC2XOtw8PrFDu1R+y1uZo07CEz8Rqv1GbTEWwoj52WlB4jU4kewevPKZcR/JgHqVd0UPGOYbHgK0uj6dOUFvHui+M8pzPO15QvOfgNuKWDZiJ3Ijjq+91KjoGSceozQHUYvS9Fh1F/Uum/PcVZPmEK3rZGdMFrS5ZVw+NENGSdG30ju6SnI6Zc0JnaBlqkRc3DXE7ov6cOq4Wd4A4/QaePJx+vEerY2Zct4tC3rbAI3oLRN20+ifqSYvBIh4j+Xsx4k4Jvb8iFBbPxeEHjDWJm+7ZdjQ2gog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7arM4dfJ8TrFyz9cmd7A+VyVCio+e92TBW3ot3qepRM=;
 b=GGWM2gYaVYwsjUHiwvLGgY0yE2wQDXevSjrfyDE0WVFNCV9vjRpzcOGQ03TvOUp6eKAlLro6isd2Y6bjSIR2l7tfnzM3k7PhAxVqK+7q4N6iGthzeQMcAeNn9CUKXevOV2bC9S73VeMZygfQMEWLRBJ40AkTcISpweAAYt/x1KK8s1WYQ4e12iDac86iu3xut9qTsQoScS4LHEZolMWGIxg/Ifl/WQKCnHvEz2b1/jkjVhvRWxxRPdPX+VmgvMJuukkWnOtN0l5TLRnaeaTaREpPJIlwSnzWY3BuaDmALWea6wCUFTb8LbARsEQriG2pzT+KcqHEnsXqKsJVQ+l5EA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB3116.namprd12.prod.outlook.com (2603:10b6:5:38::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3109.23; Wed, 24 Jun
 2020 19:46:38 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1d53:7cb4:c3d7:2b54]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1d53:7cb4:c3d7:2b54%6]) with mapi id 15.20.3109.027; Wed, 24 Jun 2020
 19:46:38 +0000
Date:   Wed, 24 Jun 2020 16:46:36 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Leon Romanovsky <leon@kernel.org>
CC:     Doug Ledford <dledford@redhat.com>,
        Leon Romanovsky <leonro@mellanox.com>,
        <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH rdma-next 4/5] RDMA/core: Delete not-used create RWQ
 table function
Message-ID: <20200624194636.GA3284090@mellanox.com>
References: <20200624105422.1452290-1-leon@kernel.org>
 <20200624105422.1452290-5-leon@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20200624105422.1452290-5-leon@kernel.org>
X-NVConfidentiality: public
X-ClientProxiedBy: YT1PR01CA0004.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01::17)
 To DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (206.223.160.26) by YT1PR01CA0004.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01::17) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3131.20 via Frontend Transport; Wed, 24 Jun 2020 19:46:38 +0000
Received: from jgg by mlx with local (Exim 4.93)        (envelope-from <jgg@nvidia.com>)        id 1joBLx-00DmLv-0K; Wed, 24 Jun 2020 16:46:37 -0300
X-NVConfidentiality: public
X-Originating-IP: [206.223.160.26]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 39222d96-0360-4a0a-3e9d-08d818774f36
X-MS-TrafficTypeDiagnostic: DM6PR12MB3116:
X-Microsoft-Antispam-PRVS: <DM6PR12MB311606CE47CE6AFD83F1EA80C2950@DM6PR12MB3116.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4941;
X-Forefront-PRVS: 0444EB1997
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6SdTW51ofb3rQv9YCmIIruvViMsGISHFTzh3woTumOyM9IzB9CJHiGJWRy5QU0tRf//Gs5jrKI/gGgbJkCNjECk+EVyYVFBE6owAhUSwQEu4Qcla2nAKRmUgmcsNNjdLgGynwI8XifWFDf6LFHyaARZEDmaFB0Bt/aJ9eRNgTfKK/0Y1OOoEiRwQY8S5p6E64ui0bBW6b315nW3zmPUGE/LUvqxt4VfaAgjj+cl9TgP57XwVrUXsKy9UMDBb70uIlXFgvVuxR2PX+NK3z4X0U5vc2jEQpHtAtopjB9EiyOjc6XPAxqrhZsRDqHk6a9KIj0aLWmnjWem4YEi0oN31NA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(376002)(39860400002)(346002)(136003)(366004)(396003)(33656002)(9686003)(4744005)(5660300002)(86362001)(66476007)(8676002)(9746002)(186003)(9786002)(8936002)(66556008)(26005)(66946007)(36756003)(1076003)(2906002)(4326008)(54906003)(83380400001)(316002)(6916009)(426003)(478600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: OQ+r7elCWSK48mdlhgIyqI+Vlz6YXPfb6Lho7eWeJE0If/kZijy0A3mSZPrk521iM+pOce+B7YSRCtE6GP3cEfXI7bCVg1xR8YCwlfHdCU9ph3Ku0NKISDPCQa+MR7s3BnGjN/njKQ+eJsk4qktg3agNsFCmoVJFyZBFUA+Sq3KPhzjijUrynD5ZWT1mOphqnb8ig/nsbTEzTYkq1twbKx6RjQjIR2XTU5wjzFif2MfnBLuFFAskGdakj+zR4uv/vFsc86lvADxLiyDVkUUj2ejNYtaTzNCCLNzwfrEYsrfLzuLwoyrFuVnzhAUHQDQj0Pc9ZFWtaY85Mj//E1sKm3Q/dB0RmdE4QBs86apVG/DohXYh6ZhYT7go4fUsopVZNaZww6MCmoJLIM40QIOimBDU7q10KEbQYCz9Xbr603FPo4YTnRCpkx2hYtVuGw+BCBO6wT0Uq5e3s9tirlHO/ifSbNvpS1IV7orBxpjOHWY=
X-MS-Exchange-CrossTenant-Network-Message-Id: 39222d96-0360-4a0a-3e9d-08d818774f36
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2020 19:46:38.5872
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ew1jRx2nThnBsF9HCobQzUMZkaZTYmr/daFL/L4jVmANP5UHo8eZGyZjBiDY9913
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3116
X-OriginatorOrg: Nvidia.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1593027962; bh=7arM4dfJ8TrFyz9cmd7A+VyVCio+e92TBW3ot3qepRM=;
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
        b=U/iHYZBksajtflXJd6IUfR+6aqBljUYWIzY5GPI8W1ruhPBZkZX1Z+V22tg4NLGMe
         5OXKbzuWeBQhTUtv+OIWtio8ZPO9HgX7CHOGFkBs5WQPHkfLGO/1cycN6dfEsC1fTX
         nlAEXtUB9OOcMSyPL+PuJuxTvEor/im4xzk8T58S+opWZ6hojKTrBhTLUQc6CchlPC
         98FkWRbA7GavodQgYnnquX3/A79uNdwNQhCkbTNcZCjslvC9V3npXOsVjQ5aa4C35Y
         dfzvJUAAHOfqvgCMEF90tHin3Sy4/oAoREb0gN8PFh27Eot5wUXthxwqsz2Fg4eXDT
         INkwLkm6mDbEw==
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Jun 24, 2020 at 01:54:21PM +0300, Leon Romanovsky wrote:
> From: Leon Romanovsky <leonro@mellanox.com>
> 
> The RWQ table is used for RSS uverbs and not in used for the kernel
> consumers, delete ib_create_rwq_ind_table() routine that is not
> called at all.
> 
> Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
> ---
>  drivers/infiniband/core/verbs.c | 39 ---------------------------------
>  include/rdma/ib_verbs.h         |  3 ---
>  2 files changed, 42 deletions(-)

Applied to for-next thanks

Jason
