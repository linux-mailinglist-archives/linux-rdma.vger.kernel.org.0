Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4CAB7261B02
	for <lists+linux-rdma@lfdr.de>; Tue,  8 Sep 2020 20:52:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731496AbgIHSvp (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 8 Sep 2020 14:51:45 -0400
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:18157 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728390AbgIHSub (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 8 Sep 2020 14:50:31 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5f57d2440000>; Tue, 08 Sep 2020 11:49:40 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Tue, 08 Sep 2020 11:50:30 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Tue, 08 Sep 2020 11:50:30 -0700
Received: from HQMAIL101.nvidia.com (172.20.187.10) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 8 Sep
 2020 18:50:30 +0000
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.168)
 by HQMAIL101.nvidia.com (172.20.187.10) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Tue, 8 Sep 2020 18:50:30 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mh8Vn61VYS3fFXGypPWojj1nHmsK/STIqM56oTLkkt3kjseXZLYRjiHRzmWRAOyNzaOq+Tpu70jvjDyROUMUeinkcwzdmMzLoy8bpByU/LJmQXwFdRgwddqD0kk7UwCMzV7hiA/VzpAjJg4VVjCSR420a2E1OAQ/UKPkkT9TMmGP4B5C7K/Sqj77of3sDwHW7mJxnWc+G3IjgdXl8h3JElb38rJwopUUzqZzmDpLOUPUCCYW0rwXptle+Vfuw3t/3drzgGXJd8ICFEfaGzPm0djJWD9KQW7CbQi6QgOxuTgeVVEaMNQAtXEPBiw+9EQWZRubauz1VlbNz9KzgJluCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kYHu9WKDMAXpcl8TLAXUzwYk1FZ/PBaclBJG8xqxXG8=;
 b=DlQT8i0k8644DuK4/pBnpBBRhN6BF3rMoJsHFEDjfFow+yGQL049U8uO7zGGqBqAadNTZM+sOiTzy0HfpW/0T9OXvueARMKrvuf6nFBgjRLcdCsIX00CdHTjchd1w00zQtmFuiwwef4YO6k8oOC21lQI/12muxLFqbjT8IZ9ujDA8euxE3dIVFNKePPdJnJBpoKXnuIMUr51rjIYr614KODT3pqSH00yFXWgMixTP6/fsk/7tgqw0OLXXhwPzt8s0WdOPQJ11tW8ne1PosolxJkFZuurVoqLxQ/B3M5NKV8cKA2ea6xHAEijkqkJEt1U3rkAM3oeX2BLs3aSdxQUfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nvidia.com;
Received: from BY5PR12MB3827.namprd12.prod.outlook.com (2603:10b6:a03:1ab::16)
 by BYAPR12MB2712.namprd12.prod.outlook.com (2603:10b6:a03:65::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3348.15; Tue, 8 Sep
 2020 18:50:28 +0000
Received: from BY5PR12MB3827.namprd12.prod.outlook.com
 ([fe80::445b:111e:a091:66f9]) by BY5PR12MB3827.namprd12.prod.outlook.com
 ([fe80::445b:111e:a091:66f9%6]) with mapi id 15.20.3348.019; Tue, 8 Sep 2020
 18:50:28 +0000
Date:   Tue, 8 Sep 2020 15:50:26 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Leon Romanovsky <leon@kernel.org>
CC:     Doug Ledford <dledford@redhat.com>,
        Leon Romanovsky <leonro@mellanox.com>,
        <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH rdma-next v2 3/9] RDMA/mlx5: Issue FW command to destroy
 SRQ on reentry
Message-ID: <20200908185026.GQ9166@nvidia.com>
References: <20200907120921.476363-1-leon@kernel.org>
 <20200907120921.476363-4-leon@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20200907120921.476363-4-leon@kernel.org>
X-ClientProxiedBy: MN2PR01CA0038.prod.exchangelabs.com (2603:10b6:208:23f::7)
 To BY5PR12MB3827.namprd12.prod.outlook.com (2603:10b6:a03:1ab::16)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (156.34.48.30) by MN2PR01CA0038.prod.exchangelabs.com (2603:10b6:208:23f::7) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3370.16 via Frontend Transport; Tue, 8 Sep 2020 18:50:28 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1kFihG-0034wH-SY; Tue, 08 Sep 2020 15:50:26 -0300
X-Originating-IP: [156.34.48.30]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e25beba8-8801-4f13-6b77-08d854280df9
X-MS-TrafficTypeDiagnostic: BYAPR12MB2712:
X-Microsoft-Antispam-PRVS: <BYAPR12MB27121FBBB7DE2E511041990DC2290@BYAPR12MB2712.namprd12.prod.outlook.com>
X-MS-Exchange-Transport-Forked: True
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NYueVbNAx7UO4KcxuECk6ES10QG52DkJxKU1DkrRAKUYfOD97/H0jwFuURvhghgOR3CIYqqtPEhmtIzNRa24CNKF54ZmrKPIg7kxFaHLJDG4E+oy1px52I8T5ILFmJMg+RaYBqQKO/46zJ6IFb7FJBHlqH56tVFwuVwBtLCCKsPbcKdwdDoDM2V1MStkm/r0FmaXj3Xrdi49QZOpSWtLtCbmo4+eg/fugB/lZzZGGBni9jFXyqT+6H6exC+nndk6z4Qi4xpsekTQjFy+zW2JfhjA68n0EUDympNFI5qW2FClzxyEELNBU0m8eoLFw3MXzmw1esr7MfJ+ArfStTGrCg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB3827.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(366004)(136003)(346002)(39860400002)(376002)(2616005)(478600001)(83380400001)(26005)(426003)(33656002)(316002)(1076003)(36756003)(86362001)(66946007)(9746002)(66476007)(66556008)(2906002)(9786002)(5660300002)(8676002)(8936002)(4326008)(186003)(54906003)(6916009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: cxpde5w6H3XwbGFMizR/Fb6GiVc+jZWOp3t4j/PegJbmCt919+LWRgDjFF3qINtVHNaOdxz8Eou9Sc5w+cYBjNiggafpTnQGPRXhcbhaEoJnsNrDJSYQCpLDKcNIFP4xA4ZY8BK+5DXBolJqcf3m3eeSVheKHS0avmRl3uo5wd8A9Da7mqcErpDKC4R1Xk0/ojbYKiDll77/4OLgz1d6LwS4k+SlKeGJO3X71J03b22wa2s8VmRRKhevilzMEb4pIuE2PbMSmtsCNSDKv+4hW33AsUjLeBgx2hAYd1OvBDcum+hroVg70n3ixoIEEcMBA0LgRgAOTEeW+sn7jQQYHysfoHQu7YsaKMeejP0eQTKnQjArhv8TEsphIk7niZm/96LR/ehh5S/OEvsRdabCKyhfNQPhoTwNzBxohnt+R1YccUFPzRqz5Tjs7oHLseGMlUac898k+FY0wuxaaqczJT6XrHb5yRQMVG7oVm8rsW4yI6FSOwOcpTmA9nV/SMw2Wp1U741b5xWzBAbp9NBZl4BCRjCsnc6pDmxHEu08zVhfOYosYvwVzWool3TZJ4snGUPdM/yOexD5pcqSeRYI1bdQB5FWlWyX9OMu8xpWkQDcbjNr8wc51t3L8GCaTDFYBXUSET/gH6wzXrZNIwxS6g==
X-MS-Exchange-CrossTenant-Network-Message-Id: e25beba8-8801-4f13-6b77-08d854280df9
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB3827.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2020 18:50:28.6947
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gNLJvTfkDMwMsaHVVQQoJ7nEvDAiWar8P/yF4e1nBThyuD/gVTHkdx/HV6A9D4Qv
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2712
X-OriginatorOrg: Nvidia.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1599590980; bh=kYHu9WKDMAXpcl8TLAXUzwYk1FZ/PBaclBJG8xqxXG8=;
        h=X-PGP-Universal:ARC-Seal:ARC-Message-Signature:
         ARC-Authentication-Results:Authentication-Results:Date:From:To:CC:
         Subject:Message-ID:References:Content-Type:Content-Disposition:
         In-Reply-To:X-ClientProxiedBy:MIME-Version:
         X-MS-Exchange-MessageSentRepresentingType:X-Originating-IP:
         X-MS-PublicTrafficType:X-MS-Office365-Filtering-Correlation-Id:
         X-MS-TrafficTypeDiagnostic:X-Microsoft-Antispam-PRVS:
         X-MS-Exchange-Transport-Forked:X-MS-Oob-TLC-OOBClassifiers:
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
        b=Uvq9aQQ39QhRg78aX/lHtOY9cqIWMIH4GVzaQd67Dv3/njMNeRloM/AhQmj2KtY9z
         DTmJJTKUKwT6AW1j+mhxsecLIYQRXFEVQl+UKqv5NXIDw6GOKdRBhmE6fDiET+oRoC
         uFRbNwXMgi+WTgpcMqBEwLpdtgAeB2tVmBCMaJVm6QQAToKLC23pICPxbZWfelfcth
         bZ8YJsd4x2iH7z8Eg6A1VqX/9PBG/pKzH4a9DZxZ4f6DRCep7Pz+PJs3cLQkMQF6zL
         erfIJFs5ocXxe+5ytgb+ag55g+O+zNNeBFQ8wVPNlmC2a+82b24GYlAUC9SMwjscfI
         +3N9RFRiW53YQ==
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Sep 07, 2020 at 03:09:15PM +0300, Leon Romanovsky wrote:
> From: Leon Romanovsky <leonro@mellanox.com>
> 
> The HW release can fail and leave the system in limbo state,
> where SRQ is removed from the table, but can't be destroyed later.
> In every reentry, the initial xa_erase_irq() check will fail.
> 
> Rewrite the erase logic to keep index, but don't store the entry
> itself. By doing it, we can safely reinsert entry back in the case
> of destroy failure.
> 
> Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
>  drivers/infiniband/hw/mlx5/srq_cmd.c | 15 ++++++++++++---
>  1 file changed, 12 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/infiniband/hw/mlx5/srq_cmd.c b/drivers/infiniband/hw/mlx5/srq_cmd.c
> index 37aaacebd3f2..c6b32b15c3f2 100644
> +++ b/drivers/infiniband/hw/mlx5/srq_cmd.c
> @@ -596,13 +596,22 @@ void mlx5_cmd_destroy_srq(struct mlx5_ib_dev *dev, struct mlx5_core_srq *srq)
>  	struct mlx5_core_srq *tmp;
>  	int err;
> 
> -	tmp = xa_erase_irq(&table->array, srq->srqn);
> -	if (!tmp || tmp != srq)
> +	/* Delete entry, but leave index occupied */
> +	tmp = xa_cmpxchg_irq(&table->array, srq->srqn, srq, XA_ZERO_ENTRY, 0);
> +	if (WARN_ON(!tmp || tmp != srq) || xa_err(tmp))

This is just WARN_ON(xa_err(tmp))

xa_cmpxchg will fail if tmp != srq and srq != NULL or we already
crashed

Jason
