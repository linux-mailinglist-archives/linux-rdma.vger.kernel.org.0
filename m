Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ACD6E4856F8
	for <lists+linux-rdma@lfdr.de>; Wed,  5 Jan 2022 18:00:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242108AbiAERAX (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 5 Jan 2022 12:00:23 -0500
Received: from mail-dm6nam08on2077.outbound.protection.outlook.com ([40.107.102.77]:22528
        "EHLO NAM04-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S242098AbiAERAQ (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 5 Jan 2022 12:00:16 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F2A3AvhPx/aE+jkLWPZG8NquHdgfbtzmvn8qmUs0ACA4aL+ZBhSVx+cRIjoDmJUOHQ/7UfUYDBQImObXzQIIpG1leaAbcFaMCtEwG3HTg2SrfUHlc6/oX3kEtdYGEBOlmTrdcoUm0lBbzhy/WJ2WG0p1sPqSgZs2YILXRILYD3qlDUd3nnwX6mi0980MA+u+O0MQRXX7GNFdazDDsGizkmJUs6INAdZdcPSm9sJx++rrGO4bxdsp1Oi0nNJQ9HM0nk/VRkHPDn7vih4im3Unkgx3Gj47SE53dQjdPpyjnP0Bzq6pebRRicwy2x7efYaSfQDz5WICuIppuPZ74DCHRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zMI7f6WYOVkRoDsFBAtFoTrkjHE7EHA1JJzEpqm6Ifc=;
 b=gp3jfGMoD6KwaFRiDsu/GxpykY2kukQHTFprhMNZnSlKALSvIVx5ixetWs1YdmSmiDz0cSgbzkiDFH7APHutMMs9IJUp2zoIomVpHxxn4OHneAa/O02x1Bk3dWdqZGuMKm0urk/7mIrOSSknSddULwOYFYrAYn+t0NAlHryRREgeFI7QU10tnpf1QI5qLfoEOwGn0k8Hvkb/vgsa39fGx/uKWbisLBqC0mHRj08N6IXJuZHPVoGHWYCUCgvA/JDsM5X7GAFcx6OOtxVH5FXFw+En4PTvr3Eg8c+Ulc1ReuxZbTjX/QFECxkKrSygbX/KHjBWWGhzo08dL7E7cbOL5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zMI7f6WYOVkRoDsFBAtFoTrkjHE7EHA1JJzEpqm6Ifc=;
 b=fYwwQ4oumEDj4o/ur6wKCWIUOW53tNnBOHqC05xQgMi/eROlX+q3ipP8enRYB+KzEj14s+A7IKU0jXBMXmOPMsI0kp8kmSFrS6qIAT/zCoDNr32SBARxUU5Hb7TrQcVHewoQEyGozcd5TZ6+Rc0z5zH2MeEKLxvN/pj5Tuok0cy638Uz6ariDKyYTkRtrq+bLKWVYJB1gT6Hm0tHGFvh4NNdSYnKkFtT/FAI1DsAfBAyZ0udk4mm/ULQKkwkrtVd4aGOCfw0A0EGqN+tgBbKMEBms450Jkl0tv73DPIdlBG7cCMxxCH6zVG30PQORV9hoAneAL6fmGULjm3ydKgZmA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL1PR12MB5240.namprd12.prod.outlook.com (2603:10b6:208:319::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.9; Wed, 5 Jan
 2022 17:00:15 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::464:eb3d:1fde:e6af]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::464:eb3d:1fde:e6af%5]) with mapi id 15.20.4867.009; Wed, 5 Jan 2022
 17:00:14 +0000
Date:   Wed, 5 Jan 2022 13:00:10 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Maor Gottlieb <maorg@nvidia.com>
Cc:     alaa@nvidia.com, chuck.lever@oracle.com,
        linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
        tonylu@linux.alibaba.com, leon@kernel.org
Subject: Re: [PATCH rdma-rc] Revert "RDMA/mlx5: Fix releasing unallocated
 memory in dereg MR flow"
Message-ID: <20220105170010.GA2809962@nvidia.com>
References: <20211222101312.1358616-1-maorg@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211222101312.1358616-1-maorg@nvidia.com>
X-ClientProxiedBy: SJ0PR03CA0331.namprd03.prod.outlook.com
 (2603:10b6:a03:39c::6) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ac110c1a-da3c-4d3d-f02d-08d9d06cd7d1
X-MS-TrafficTypeDiagnostic: BL1PR12MB5240:EE_
X-Microsoft-Antispam-PRVS: <BL1PR12MB5240A6D1A08C4DA4AC38ED6AC24B9@BL1PR12MB5240.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:126;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FA3fJFyauRENQhN1robhfviWEj7++vxhiPbQ4njOQUJ6RgtjacDN7yh4+eDWvsng7AEKJmT4H2fkDbId8spLeCvR5NKQUzlFH6OLUP+jLFHW8K2CuR/DEoqmWyS/qPEpAvUxLYhY0MLhUoF+JcV2HqCR9XUOdg3YMr09BJVUVN+RCb1cdwCKEHzsqEjkjLs5I+sU9F1nd5LXvxBCTAnweEsFxAokGfoPsRWjDpUFJQ6Cm3WvU70wSrt1/QnL+WiVk4XWL+WI1pm1RPzJnjv6xZ2FgtwZKeEhPHa5iiIcg8P9aujNfT9+bP0GcSgJoNf82dzrpcjKA9nWtQCUk1FHoM2OGfpX1tXog+Uyc/ziEfWxmJqwSjv4xsrXV7wZjzp+y/5SzHISQcFN6XrUzWipE+fkly3ETHQtZWPaeseA3GxYWnmEt0eTU3KsYFXgPWqgk0I7POhdq80hS5xtVZbCUQpQOZFBi3+tBmT2SDDvCltxQqksHZ70gA4NtjWfp2asm6Dxx6moMjDM/QbG9wk7MfTOQ3NB8oM5HF+UUtuEvCWt7Y5b0e2lopSapYOUp0P1WuY/YGjkSAb2c1f0NBbbOglOLgIWmyU6kgSHegBSyzoznH09LnvrH2RpcTZWPWLSBGx/tk/X6lgep9r4Roz6+Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5506.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(2616005)(66946007)(8676002)(37006003)(66476007)(6666004)(36756003)(508600001)(2906002)(5660300002)(1076003)(8936002)(66556008)(33656002)(26005)(4744005)(6512007)(186003)(4326008)(6862004)(6506007)(6636002)(83380400001)(316002)(38100700002)(86362001)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Vi0bVuNarF5ra4qXcs/Nbb7B/50X3Zv/PlE2Xs8i/oRshSFYM9W6p0uezpTz?=
 =?us-ascii?Q?3QBT3MFcs58x2Jx5xTYdHGJOBc/RUu5RLjQByGxHAkh6Wcc0uU0fuNCN5zkn?=
 =?us-ascii?Q?JRVdXqPBO/zMfNwogwCtLWIgEtxNiuSsMlSis3/rdrTW+qyYF1gKYPnhWXD0?=
 =?us-ascii?Q?EppnT/KFD+UC7aHezCAH6s3xY6e1xmynbtab+MJAp1T4jpwd8j7gvvlXNp6+?=
 =?us-ascii?Q?+2+ezhWH4ToMhL3dzhVy3LCCyXeOXcT1Xa4G6prScDbWwujVtdEGcQsv5zxi?=
 =?us-ascii?Q?4HOPJNPLxf0wqA0K5O6chPdSwfXF4YktWPIubI5HzYr3hntrhaOIPIk8fnzY?=
 =?us-ascii?Q?Q8G/0aajuU5KaRNImQ2V80G0Jqmn2gqXjhmYt2iBt1mSNLLlOgRVrneO3q+M?=
 =?us-ascii?Q?vRg67nJU68RjXBwtpvZzpYLBZKeCe7rirUzTMdoTNe7QkzneauLhHwEGX7Yr?=
 =?us-ascii?Q?BHLFQ3wyfr0MRV+4PsVMkw7DSJ91EP6Hrg7yaFifY6I2M5VZCJVSYFqtSMPl?=
 =?us-ascii?Q?+ZGVlgZeqAGbeDdzCHCaEW7HNvVfKiyMhaJC4LUDznsDnW+AeGkgNkWL65Y0?=
 =?us-ascii?Q?TjXAu9EjqyDbRq7L232oVnh1yD6vTSUbXUNkcKAaw1lB8miOOWc1HnepWGsw?=
 =?us-ascii?Q?iM7cT37chcLokmxapevP2pN5c7yJMWqimM+yvNFoLQrCo/kfpCHZEYl5SjIC?=
 =?us-ascii?Q?JWrcE0dJ+RZIAimIvw5LU10+Fva3hO/pgs211LM6ZrezDP+9GjtaME7oSnde?=
 =?us-ascii?Q?irl1DE6Gb6xtaftc9UQHCXchqdjyTVJaKz5ne/0sWXzhIGhgCT47EGnJNxyk?=
 =?us-ascii?Q?uijDHHEkXI00T8Y5fdZE1qHBHJf1pLtvKomz8GPIxcc2N2wJaomCljf3jBCk?=
 =?us-ascii?Q?jjVu4TaPMjJ6txSrFhQ2I853uUMGnX249ZaiI/bLGwBtt7Io2TaSPXE9gCFS?=
 =?us-ascii?Q?C4PI3+6zD8i+Cv5mfF72eX7I7x/SO9YkrVQzFlQq4QxyXGmzxxU9XZHaZIiw?=
 =?us-ascii?Q?SLOiaHpOxTCcT46I2iUK72UdY2uOEN6WvCkVlJ0R1lebeHxrL7TyQNcyL31x?=
 =?us-ascii?Q?xBVaBgB1Ksg42ttIWTmhvF67nEF0BAWcwsZCdhTTMyt7+mW1lUsLpGv11xg4?=
 =?us-ascii?Q?lL4GTHQkx5/o1O5paxzUv5XyK9Wo7SwQ6zoxQfXFAtYtHPVMhYhEgIr4jBTC?=
 =?us-ascii?Q?hOrwIrHyGdNZEUurudLpIKsk3pNRu/QqB86r6MTYhSQgbBs5CNJ+FABy3gmf?=
 =?us-ascii?Q?Xocg67k/KueLtVjcAWylqEAwydiyuPnSGD+cVyMRweDueM0MXWP7etnvNJ6U?=
 =?us-ascii?Q?JxeGD16HLQQHcd0+jRNRLzQU0x2hz4FVe/flI2i+OetpvrtjEpKixg+UU/jh?=
 =?us-ascii?Q?R8v3I2J58R4Ix9z1/gf6YnxeFaRlMGOLwzSQFJCeRxeznasSfF6FjQACKu6z?=
 =?us-ascii?Q?PJv/KbewrQG40h+O+OuWK5RC0QRadvfAb027qWSfPeDyWbg4TbcpmRJcqzHT?=
 =?us-ascii?Q?JpgpBldMqVI+ojQVd9N+r87Oj8FWrALr5+CEcD7MsoWx61wy+6AOdoSLhEb7?=
 =?us-ascii?Q?qoeALa7NL2PdaaoP5LQ=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ac110c1a-da3c-4d3d-f02d-08d9d06cd7d1
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jan 2022 17:00:14.8196
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oi+ZA/hOMxBo32mSVYd7yQ3ebimfmQHj2Og6vPE92W88kdqYNHFfqLSjJVoUpuPC
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5240
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Dec 22, 2021 at 12:13:12PM +0200, Maor Gottlieb wrote:
> This patch is not the full fix and still causes to call traces
> during mlx5_ib_dereg_mr().
> 
> This reverts commit f0ae4afe3d35e67db042c58a52909e06262b740f.
> 
> Fixes: f0ae4afe3d35 ("RDMA/mlx5: Fix releasing unallocated memory in dereg MR flow")
> Signed-off-by: Maor Gottlieb <maorg@nvidia.com>
> Acked-by: Leon Romanovsky <leonro@nvidia.com>
> ---
>  drivers/infiniband/hw/mlx5/mlx5_ib.h |  6 +++---
>  drivers/infiniband/hw/mlx5/mr.c      | 26 ++++++++++++++------------
>  2 files changed, 17 insertions(+), 15 deletions(-)

Applied to for-rc, lets get the correct fix for the next cycle.

Thanks
Jason
