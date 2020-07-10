Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 31B2121BE0D
	for <lists+linux-rdma@lfdr.de>; Fri, 10 Jul 2020 21:48:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726867AbgGJTrC (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 10 Jul 2020 15:47:02 -0400
Received: from nat-hk.nvidia.com ([203.18.50.4]:42126 "EHLO nat-hk.nvidia.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728374AbgGJTrB (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 10 Jul 2020 15:47:01 -0400
Received: from hkpgpgate102.nvidia.com (Not Verified[10.18.92.100]) by nat-hk.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5f08c5b20000>; Sat, 11 Jul 2020 03:46:58 +0800
Received: from HKMAIL104.nvidia.com ([10.18.16.13])
  by hkpgpgate102.nvidia.com (PGP Universal service);
  Fri, 10 Jul 2020 12:46:58 -0700
X-PGP-Universal: processed;
        by hkpgpgate102.nvidia.com on Fri, 10 Jul 2020 12:46:58 -0700
Received: from HKMAIL101.nvidia.com (10.18.16.10) by HKMAIL104.nvidia.com
 (10.18.16.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 10 Jul
 2020 19:46:48 +0000
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.107)
 by HKMAIL101.nvidia.com (10.18.16.10) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Fri, 10 Jul 2020 19:46:48 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NmkJIUdF+UY4/E5qv+S2uhfjed0AnUQ2DvKyWluBEfwrc6O2hMASL9sJWoqQlOC/LC3A0WKWxSDH6MUh6QThZG7PlltKut2n4UghdMaryo4/6yOTwsbo5XE4XPEMevJVBB6sUeBxwo9nIRY4kGx86blZBYpb/HnUq/kHzFW7mptv1tNbuQ5aCrRgeHTdKtdNiuOlOy9pQcZTyqiaV/+p03DqGnxpxE+zhWDYBAZotOto9CSUCWZI58mvPlDGNVbX22Drr9kRGneGEhqRm+M2yh/syuudWKeGF3svhGEdvjcbgP1OswRXmhI+r0og9Moul5IkjUK2EBov3ow80MZi7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iwgeKFJrhoMv+QL4nwMS2tx8FdfXHzVlj/okkczYJOE=;
 b=KxKCTctMoS1Fln/LD79lSZsUm/ZXxAgRPng2Sr/7HtFlKJ8Cd2sgXdKrPo8HAVk/7FY9xXCuXkDFj7jJM1G0/JMzKCpkFdLeLp4d420sBN8gwH3x9x36fmC7tHiQGauBfmARkDQKEOoFnI5iMPfh/Tc/4iZdAmZZSLwUtOzHhLzXCnZ0bS8n3GkTb965NrtPcvTIdX2HM7cqvwJ72HLvlg4aGEZdTBQ3I5/dJzxAnJxBSs5SYkjyfgIaayiFowlTiw7FQaQaqkY7YhH/btQV1idNY8/MuBip3aVQvIw2LUfZraEKBGXtk4LkFtqNuE4+C9xkRK5qmhJJUkH1aubxvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB3513.namprd12.prod.outlook.com (2603:10b6:5:18a::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3153.28; Fri, 10 Jul
 2020 19:46:45 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1d53:7cb4:c3d7:2b54]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1d53:7cb4:c3d7:2b54%6]) with mapi id 15.20.3174.023; Fri, 10 Jul 2020
 19:46:45 +0000
Date:   Fri, 10 Jul 2020 16:46:44 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Leon Romanovsky <leon@kernel.org>
CC:     Doug Ledford <dledford@redhat.com>,
        Daria Velikovsky <daria@mellanox.com>,
        <linux-rdma@vger.kernel.org>, Maor Gottlieb <maorg@mellanox.com>
Subject: Re: [PATCH rdma-next] RDMA/mlx5: Init dest_type when create flow
Message-ID: <20200710194644.GA2130282@nvidia.com>
References: <20200707110259.882276-1-leon@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20200707110259.882276-1-leon@kernel.org>
X-ClientProxiedBy: MN2PR01CA0050.prod.exchangelabs.com (2603:10b6:208:23f::19)
 To DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (156.34.48.30) by MN2PR01CA0050.prod.exchangelabs.com (2603:10b6:208:23f::19) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3174.21 via Frontend Transport; Fri, 10 Jul 2020 19:46:45 +0000
Received: from jgg by mlx with local (Exim 4.93)        (envelope-from <jgg@nvidia.com>)        id 1jtyyq-008wCN-41; Fri, 10 Jul 2020 16:46:44 -0300
X-Originating-IP: [156.34.48.30]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2bcd4d14-bde0-4d72-efba-08d82509f9eb
X-MS-TrafficTypeDiagnostic: DM6PR12MB3513:
X-Microsoft-Antispam-PRVS: <DM6PR12MB351370945DE070751A694865C2650@DM6PR12MB3513.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4125;
X-Forefront-PRVS: 046060344D
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IsTuFNMUwzomp+8MglypttLGcbMIkzVRtBqkJRq8Jgm3ZyLiLMtIfwzgFKZ3dxucFa33jiuRugLFs6+bWyA+HXD7ERZf+I2qOrcuC/AwKrQWFwJxC6AGNiLMBLyFpPMAND+EU2flUL4RzmAYAejGjug8tqTm9PstyX8ki7RZPHzOLZSDfP4upJBt9OHpBz0NlvnZWgZVJnieqK3Lu614S3CHMp8tDEy29pvGCHRHyGfRKQ5t2gr45ZFDXAYdSf7ISPN9rBglSfm8lPaPCRewOwIXb5HEaHKjrPcaPzSMteaqJycfSvvliPW7Xr8plVjbBmFRRfDxTezpbJbL8tEF3ObyIett6iNBI4DNX9FueYqu/YNJG2rbqsH0736Cl1Z5RWQHBZsBaoFrHvNAR5TTPQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(376002)(39860400002)(396003)(346002)(136003)(366004)(83380400001)(2906002)(4326008)(1076003)(33656002)(316002)(66556008)(66476007)(54906003)(66946007)(5660300002)(186003)(966005)(6916009)(26005)(9786002)(9746002)(478600001)(8936002)(8676002)(36756003)(2616005)(426003)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: DZVMGSag85Sw/Yb4+6HQMU1OBY0cvFarh6wGz37JuMtzt3Ro9uyl6WVVRngNaRMSDTvtQJj+5SaMjitMmarCUkVVVbID5QKj2y0mSuH9Gb0pgAZIsdBmtzEPo+2xIs+YXRmPVfJcPnvrTGg2vxj/Ajm25arRfwOchWFrPBlQxUq9O9SzX0yxBP2yLix2aJjg7VWnL+xAhD6liFyQKa7AqVXndy+KTKdgcQcotxP6it0Ba5hp6pLzSVfh9nrtlFv41Awdby/3GUUGeGxhlChHn2Zl38K1CAT01nFmsvdlShM2W1PNupjq+21ZB4OOFtCsAae/qWOHAZZ7ZpVmK6BL45TL+5Qnktv9fTgTYgFd1TwqHcsY360++0e2nvjsrY/UcKqNMqFpSHkr4OIgk+VrIJO/Ead/ZKzz9rbZhaMuFXTsAGn9LEj4YHeb6fonUiMuK79GNzt3jkb2ZuNc+5kBe/nLbB3M8t9uyklXDm7MPKY=
X-MS-Exchange-CrossTenant-Network-Message-Id: 2bcd4d14-bde0-4d72-efba-08d82509f9eb
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2020 19:46:45.2816
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CJc0gZQHmnymCTH6OOadLBvf+S0ODI+gRo6zuNHCtTMF5p1sZ5UtPxKwpI1yJgBv
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3513
X-OriginatorOrg: Nvidia.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1594410418; bh=iwgeKFJrhoMv+QL4nwMS2tx8FdfXHzVlj/okkczYJOE=;
        h=X-PGP-Universal:ARC-Seal:ARC-Message-Signature:
         ARC-Authentication-Results:Authentication-Results:Date:From:To:CC:
         Subject:Message-ID:References:Content-Type:Content-Disposition:
         In-Reply-To:X-ClientProxiedBy:MIME-Version:
         X-MS-Exchange-MessageSentRepresentingType:X-Originating-IP:
         X-MS-PublicTrafficType:X-MS-Office365-Filtering-Correlation-Id:
         X-MS-TrafficTypeDiagnostic:X-Microsoft-Antispam-PRVS:
         X-MS-Oob-TLC-OOBClassifiers:X-Forefront-PRVS:
         X-MS-Exchange-SenderADCheck:X-Microsoft-Antispam:
         X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
         X-MS-Exchange-AntiSpam-MessageData:
         X-MS-Exchange-CrossTenant-Network-Message-Id:
         X-MS-Exchange-CrossTenant-AuthSource:
         X-MS-Exchange-CrossTenant-AuthAs:
         X-MS-Exchange-CrossTenant-OriginalArrivalTime:
         X-MS-Exchange-CrossTenant-FromEntityHeader:
         X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
         X-MS-Exchange-CrossTenant-UserPrincipalName:
         X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg;
        b=TtgWSR2psid8/wEwLhzcrv8AS8+Bdar5OdEThLKFAvIii9LBFc5aLxmlrPyaudlhW
         +bHTOQJfZECQ9BpDiolgtOZRyHzThLTeWnKZX/a6g6Sj+fK4Ztq9rbRjwS19RizCvl
         +ok+36N2GOCkpg5Yu3nNZi+zYzDw0gLl/UFcXCkHwjSHw0Ld5S4aUCKr6cA6vn1Lim
         7xym90WfPDbyzVdDIkpB4bPHjz+WG+5HP1C6/eLDe92YpM+jwTiK/bvV+9bI/lxnFf
         Nh+6mXLqthbr2VE3fmSVvfXzGNw5BZkBPAVcSeBhfEfV3bmaCc4Zdi9/O67Bxz0Jmu
         nm+S23Z6xqgDg==
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Jul 07, 2020 at 02:02:59PM +0300, Leon Romanovsky wrote:
> From: Daria Velikovsky <daria@mellanox.com>
> 
> When using action drop dest_type was never assigned to any value.
> Add initialization of dest_type to -1 since 0 is valid.
> 
> Fixes: f29de9eee782 ("RDMA/mlx5: Add support for drop action in DV steering")
> Signed-off-by: Daria Velikovsky <daria@mellanox.com>
> Reviewed-by: Maor Gottlieb <maorg@mellanox.com>
> Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
>  Based on
> https://lore.kernel.org/lkml/20200702081809.423482-1-leon@kernel.org
>  drivers/infiniband/hw/mlx5/fs.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/infiniband/hw/mlx5/fs.c b/drivers/infiniband/hw/mlx5/fs.c
> index 0d8abb7c3cdf..1a7e6226f11a 100644
> +++ b/drivers/infiniband/hw/mlx5/fs.c
> @@ -1903,7 +1903,7 @@ static int UVERBS_HANDLER(MLX5_IB_METHOD_CREATE_FLOW)(
>  	struct mlx5_flow_context flow_context = {.flow_tag =
>  		MLX5_FS_DEFAULT_FLOW_TAG};
>  	u32 *offset_attr, offset = 0, counter_id = 0;
> -	int dest_id, dest_type, inlen, len, ret, i;
> +	int dest_id, dest_type = -1, inlen, len, ret, i;

I think this should be done inside get_dests() - it is pretty ugly to
have an function with an output pointer that is only filled sometimes
on success.

Jason
