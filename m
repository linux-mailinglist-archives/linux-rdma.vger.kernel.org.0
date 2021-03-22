Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE48934410B
	for <lists+linux-rdma@lfdr.de>; Mon, 22 Mar 2021 13:31:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230253AbhCVMa2 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 22 Mar 2021 08:30:28 -0400
Received: from mail-dm6nam12on2068.outbound.protection.outlook.com ([40.107.243.68]:24033
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231129AbhCVMaS (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 22 Mar 2021 08:30:18 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZvPgWh/yFULb2+L5QLY8bHZfYO6ovMjcDJlBaY5AMskq0fA4t8NjpHX7cGaMTLSpaUa9LLiJWCbGocuHUx8+yvxcbFXCXvieD3+tjdZtBxxCXnNu+Vi8EJ6eY2uYBrMHVvJty/XuCLJcH/koA0p5wIdt8tzrCfXY85jMDLmcgNHr7BvINgY/WJKrsKXwpg+hg3DKbiG2GWAtYAibDgcxksHkEZ1fftz3tDd80GbNasV5CSKWZZZcNNb3s/lW4j2ntVmqtfaonBofh/jZg1644i4MtviI1NtrTjxXxLgn0QZdrA72VW7R6GPrs7UxziuIC3uG5MGFAlx1RkhF2ZQx8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AelffIX9Lm25L5mF/ZVycG56DCgEKcyvZAcs8bWxVG8=;
 b=O0NBFsyKXirTdCen4wAwXCgwTalNk2tWt6MKi+vKwaOnW25xjjXPqElQ3kQDHEVRtlg6whQQ3zCN8MJMvZSxwOaIRN/vg4wL8rha7GCDj2NyXl8j1CdNGlrQAMzReaI88Ln3+p7U/Bf7OT/n9MLM6o4G0qRNP5dedWyB3ZdXTk8OyWl1K3Dvc6yYy/5diXUkeQNpms7h+jw6/qb86bpRX49+pD4rULw78pZ50ULNvrIaxI0f43CBFIcxWDv4XwdNnca9g5zl60MNqKvCSmj4cuXzlT45w8otqx9AW9H6/bneTHPx/v6R7bJR3s6HMzOwu71nn52n1NfXxMGKRpA/6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AelffIX9Lm25L5mF/ZVycG56DCgEKcyvZAcs8bWxVG8=;
 b=KxT5rDbo2B17KFg5pWSTW7VpgwbUd8Pp0lh31N6kqIhz8QYcXPOPu0f9ZNwiykojhRHOXATXhRc4ZSOMOinDQFuTX+AdbSre6ykMAlV/SxUc4wIP64skJtPfOxgWQnB3/FNLGUsfmIjbJUqmn+Rv5u4n66QESzQPmXEMvxVs7V+85htU3CfT5ah7fbd1P6QK6JurWTKcKxxteVofxxtSkZ5znlIJG9UxEvtR4sh5mnVFgysyAkRwoMPDURULzFvmKTi3K0Nmh6KNnLZ8KGTu620gEPSoxq42768DbssaegXCWdGL3L0Z+eXOEn4HXxLXG8dpGJaTX+i2VoJlfUkrJg==
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB4268.namprd12.prod.outlook.com (2603:10b6:5:223::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.18; Mon, 22 Mar
 2021 12:30:16 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1c62:7fa3:617b:ab87]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1c62:7fa3:617b:ab87%6]) with mapi id 15.20.3955.025; Mon, 22 Mar 2021
 12:30:16 +0000
Date:   Mon, 22 Mar 2021 09:30:14 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Doug Ledford <dledford@redhat.com>,
        Leon Romanovsky <leonro@nvidia.com>,
        kernel test robot <lkp@intel.com>, linux-rdma@vger.kernel.org
Subject: Re: [PATCH rdma-next] RDMA/mlx5: Add missing returned error check of
 mlx5_ib_dereg_mr
Message-ID: <20210322123014.GA231802@nvidia.com>
References: <20210314082250.10143-1-leon@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210314082250.10143-1-leon@kernel.org>
X-Originating-IP: [142.162.115.133]
X-ClientProxiedBy: BL1PR13CA0430.namprd13.prod.outlook.com
 (2603:10b6:208:2c3::15) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (142.162.115.133) by BL1PR13CA0430.namprd13.prod.outlook.com (2603:10b6:208:2c3::15) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.9 via Frontend Transport; Mon, 22 Mar 2021 12:30:16 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1lOJhG-000yJV-LN; Mon, 22 Mar 2021 09:30:14 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 78f7256a-b09a-4bbb-c1bf-08d8ed2e3f76
X-MS-TrafficTypeDiagnostic: DM6PR12MB4268:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB426812ABA5B5A0ACE4297E17C2659@DM6PR12MB4268.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:269;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3E1mtUkU+OSN2EPRIeVbHJjCcxdGNYUY2HKJF0FzBtgHdgMkIDxHHyeFQUsf6iAUk+CB9kXk2/XKxtU8lT7w1yC6PK5dH652cNJMFA8+2vXmFZ2ZWPoz0c+/SZKThil86Mqw75H2DAIlL1hhK9mgofe1nOU3vU/gTewIe8RC2jic9gsdFQWZsRJx1NGvpXUkS6x8VAuvqxd9Z0CtxbcMqGO/LfOJRQ9+x/NnDZcrLb4nD+k5/XIub8a9UOZ7Jm+o3UKNNUnBmscleVqPIRcYq8HjjN+cGoUQmSUB0LbWnKoQFibXK0/v3aHv6/fKZHok2vk/SmN3FELwSB/cn2p5t8CK4/YxGellf5yj2iMXaHj1+rLbnGUwCLHOyrktJL8FEBp58sNFJOE/2A5zmdH5Aed+jDI743HX0SrvIK7YTqdWWm4z9ca77GfYD5Dn0e2qrd6jhDsI3KZ0J3e62qbyZmxTbIMVnTYGfW3FLUmmSOnqZdYlQR64lbEULlqrGrz+irLsBeEf39i61RQiLDkPJBVH/EXFToQQE26awKJn2XKJuuz3Y+neTPv9kGFGpYMRYX6QdM+1Wsocg7ky3UGqvBJoUNEuZmVru+zMZAw/YtQj6uxm92I0V/OR3ZTsKysI5ANWKTqIlLNOhfNMLWG3gkq8akqCegssIImqx5VPE58AaM8gyT3NXTJO8yNaXyZc
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(136003)(376002)(366004)(396003)(39860400002)(8676002)(86362001)(316002)(38100700001)(478600001)(54906003)(9786002)(6916009)(4326008)(8936002)(9746002)(33656002)(5660300002)(36756003)(26005)(4744005)(66946007)(1076003)(66476007)(66556008)(2906002)(426003)(2616005)(83380400001)(186003)(27376004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?1W9iEf3M1FOqXsV9KA+RU3kislu+vHtGsc4A4gXzq/+aUVd3XbNt+3MIStMU?=
 =?us-ascii?Q?nFFp3bdxSZrcl2M4d+GxyeyDJrwUhxNUmA13duioTmFAu6NjuisylgsQH0lF?=
 =?us-ascii?Q?UlK49lT+8rjc2ZXUzKvMb/VmoAqZJT7QcO7CfzE6e4fW0KExq1IAuOMXnzSK?=
 =?us-ascii?Q?DDfNCkK48n6MAkH0Ufs387XhB9xhOU48wmWpYY+Co3We+4DisN24iyiUv/+M?=
 =?us-ascii?Q?32oJv5ouGItbtDTGZksTEgzWtp9YoTxtIghgKAlq5IbmDRzHSz9DMfBq+nvE?=
 =?us-ascii?Q?KT8AJHm6GOn/1cOYmTs1E5lpbbY8y4tGQm0rHKsHWUa35yfBfdq7YZ1QhXp/?=
 =?us-ascii?Q?NaAd/hRUrbq5SNOF1Tin6zriQINfgwPivN/+cTK00YmaG8Dhx3cdrB8nNqSC?=
 =?us-ascii?Q?nQ/7ficp8gqCWmpJdMzY7JQCAsdLc1rLG7lM774D8aUbxedvMJKtI8iZA4iy?=
 =?us-ascii?Q?q25l86C11PGqlOOZN3ktiMqtfiPZ9efF8PaxMTvnXoeeC09GljV8DoYh5s48?=
 =?us-ascii?Q?qCUBj717Qd4FU9vQhzRQdLQejppr8+vSdnpKKc1nhabTGVH2hL1+qJnqGVWu?=
 =?us-ascii?Q?yafrKChGB/9fmuOLWfp/wcSeZVprUjG99numC0FdA52xw7oJPZB5kuzkLe8I?=
 =?us-ascii?Q?5udBxXoDHanbdAbauHJrot3XfglwAJghXvDBP0ZXGEwJDaGoqFOSccCeL5FO?=
 =?us-ascii?Q?qy0gk4fQoEdwRRpZxZUTCx4Bk38CEl2HQakd9LN8Zh0b0qh7PTTk6mFSj0tQ?=
 =?us-ascii?Q?xnoqQOXW/BjKc226kxHHuJVl8ghNmlo6N+eZdB0VQqzy2hzgccPMRvDuvvH6?=
 =?us-ascii?Q?4OHYTQpt3cp4smCuDsXi6Qeg57sZOzptHrsq/Vsl7FeHZVLVFim6qo7zz5Q8?=
 =?us-ascii?Q?DS5FCSeVMeHgTbJwEq0DYeMC2oMCjOLhoIG+1qg5knWStJ47vhYoZZ3DS3QN?=
 =?us-ascii?Q?i2xFX8pIvsjP8FAmaanCQkKLqAMDkKx7b/06Vdik4SV8xcdzs2Zt+TsqK91/?=
 =?us-ascii?Q?4PBJNs2Gsqj9t1NG/S58JIJka9vjhVgKtf9AMDmkOAig11m875AkTQeV+Fcz?=
 =?us-ascii?Q?AIMveB69uDiy6W0vuL5RO7BnC2oK4+5pbN9567GXT/uTE6hCbfyhieCe8thf?=
 =?us-ascii?Q?mzc62ItnhQfZsDm6urTssTQQzhIcpEtO9cJNZRMK7fkVVQw55stzk+nPfsPs?=
 =?us-ascii?Q?zBGPVWqnAsSrDn6nR25DvMQAh7pagPd/KrCzhSsAZUs4CQCNl9IhK/MSCW03?=
 =?us-ascii?Q?DdoaoIu1ki2FPmlL0//0QFLInFA1AgNwhr+2cx7KohEHf6haAZQA+OAt7Rj/?=
 =?us-ascii?Q?iwFO5y4kQ1YLjyXH8GrPOcR4BAOMZup4JyRx0X+RF6P0Hw=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 78f7256a-b09a-4bbb-c1bf-08d8ed2e3f76
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Mar 2021 12:30:16.3710
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ++vwhwz4fHKTnXokBeuf+JC1Uv0XhtsK1VCvQncX7k5NPLUXskhMsOclfgzyhvnw
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4268
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sun, Mar 14, 2021 at 10:22:50AM +0200, Leon Romanovsky wrote:
> From: Leon Romanovsky <leonro@nvidia.com>
> 
> Fix the following smatch error:
> drivers/infiniband/hw/mlx5/mr.c:1950 mlx5_ib_dereg_mr() error: uninitialized symbol 'rc'.
> 
> Fixes: 715d68e63629 ("RDMA/mlx5: Consolidate MR destruction to mlx5_ib_dereg_mr()")
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
> ---
>  drivers/infiniband/hw/mlx5/mr.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied to for-next, thanks

Jason
