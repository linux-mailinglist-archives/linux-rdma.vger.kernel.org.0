Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 206FF46C28D
	for <lists+linux-rdma@lfdr.de>; Tue,  7 Dec 2021 19:18:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230257AbhLGSWZ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 7 Dec 2021 13:22:25 -0500
Received: from mail-sn1anam02on2082.outbound.protection.outlook.com ([40.107.96.82]:42688
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231712AbhLGSWZ (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 7 Dec 2021 13:22:25 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CkvoFeU0IJpflnqW2zLJJpmhXljHI3MYcasxd3jHYAI/R6u0OCpAf7iK9Dp6MxgFpcwlzB64Q/3KOqe529biuUZR7TY77z7udw8bJdFJrzmiVef9Qj+M6qcYjHqczgk1D0/oObRAdHxhjL8QUdssCtlUBJ+SOm8HRhprAIOkYSjOa6OA5zOQkzmHlJ5WXn2c7rRYQWU7nZZGlBsO31HldEPycGsHDgxIADPTOw9L7d78EQ15NLqkVuVq0SB9Oe5wdZUqsEMZ+WwZ5bN0sVmfKDL6a8I95zh/U9naIJVEZulSILuTDJvPR38TRYPuKwNrAf7wFD73APRw3f56Mw6dsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lqMsoYfigwQcptss2LgZjTHw6a6wLwAbiSZQj9MngFU=;
 b=bATW2rAwBCWmQ2+wBa4gvyfpcm5FKePFX78JCJS+59+UTcHR6sYjgDQQokzOg1O2e0QU8J7e4T6NMSZ+e4Mbhd018wCRUVkIiyIBPGsItfWMypOusnreu6Ar61sJlwfWAQNP+N/M+lOkJa3lDPwqMh7vVFihL/PVWOCAd0WPzRL18FJGWxmA27RN9U8/oz993/MxszrLmLr6DdJLgVTAh0AxBZp/RlBmeJCb6FsOV1yKVrYDlWGhyzrGyM0d7gfLd/biNRxs5ocSz21sceZ/VbSiEJD8oq2kQTbqaGzRcJY3bhhnxLOA0aWiEY+7lnb+FF9NuqsMD59tgjiNuEBm1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lqMsoYfigwQcptss2LgZjTHw6a6wLwAbiSZQj9MngFU=;
 b=gMf1nos9veVaWq/i53yp9+q+ATeNpH76UWxMmqwbBu5T5F1cBQ7PGERQVvaa7Io6kaNfKD15+taljOLYrIN9fyJHBWhmkwcBu5iIA5KCsORBc+hyxGcQfvB7VsfaL97auZZ8KU2Jv7kdprlrW7YOhaE5ck5HUi9yjG+QYK6AkbI/F7h2TtuWr6AJDrEkjnbPPkfoZB/qFDPemvkZsnq3eopP8bHSw0IL7MagghEuPlOl0L5N9pm9Vu5Dpu0gejO2pKQQ8+K0PRGt767ESGuJ4hm0/83q5Vd/WiARjKSFJQqFO44ySaX9NDQZrZBnT4ZREHpU3miVFX85XvANaHs+Ow==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL1PR12MB5157.namprd12.prod.outlook.com (2603:10b6:208:308::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.20; Tue, 7 Dec
 2021 18:18:52 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::d8be:e4e4:ce53:6d11]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::d8be:e4e4:ce53:6d11%5]) with mapi id 15.20.4755.022; Tue, 7 Dec 2021
 18:18:52 +0000
Date:   Tue, 7 Dec 2021 14:18:50 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     yanjun.zhu@linux.dev
Cc:     zyjzyj2000@gmail.com, dledford@redhat.com,
        linux-rdma@vger.kernel.org, leon@kernel.org
Subject: Re: [PATCH 1/1] RDMA/rxe: Remove the unnecessary variable
Message-ID: <20211207181850.GA108886@nvidia.com>
References: <20211207194057.713289-1-yanjun.zhu@linux.dev>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211207194057.713289-1-yanjun.zhu@linux.dev>
X-ClientProxiedBy: SJ0PR05CA0206.namprd05.prod.outlook.com
 (2603:10b6:a03:330::31) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
Received: from mlx.ziepe.ca (206.223.160.26) by SJ0PR05CA0206.namprd05.prod.outlook.com (2603:10b6:a03:330::31) with Microsoft SMTP Server (version=TLS1_2, cipher=) via Frontend Transport; Tue, 7 Dec 2021 18:18:52 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1muf3C-000SKv-0x; Tue, 07 Dec 2021 14:18:50 -0400
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6bebcee1-5cd1-4a87-919c-08d9b9ae05d2
X-MS-TrafficTypeDiagnostic: BL1PR12MB5157:EE_
X-Microsoft-Antispam-PRVS: <BL1PR12MB5157462FED9D82B77E2A3F5DC26E9@BL1PR12MB5157.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lQlLGKr6Zpng/o/kDWvi5bJnnuErl90BVYE56I3j0WfidOAL/rfv9oOTEXqw2G2PEu3DMy/tkC3nrXpDYaL2p9dsE4ZYDAargi7H5Uy7f3sLYUdcJEVg1F3Vg+XApQZJ1oi1YiIYrT0AMa3NLc4qGZgahOdfHODR9PVe4VCFXyT1TZ5+VfTYPfPLuRHDKrYEVMW4k6g8e6II0TXvomfndSGaMRSa+l3o3x/4R0dM/YFkBitcwTlvT8iKd1xNbHxC0Iru8ULsEjmfitG2oDxFILKaJLA47tCK251+Kcef8KFdp6ACIKnD38dn023l2lY2tSCWVnpCvZW23Bp/NfFuxQIl9oTGSFmp/ak2iruYRBXiv1Utja/itnXOpe0jH4aiI9ACrkgFaKEMuCjYUz3+nIwwQHH57expbY0INqXXurMBE31sI5ssf08UKbyTxmVzG1VFombsYfLAtEDD8uW2VHeLnBq4J+iL/9H9yV4o38DiD/8OAkKnEkeS+QLlI1Nw2Ph+dSRF/Dqw8kLzw9B0y0A1pKbH+/G5Yz9UHX+FulgXlK7yiKWS2F7qKGNn+nZmhMf41oroHcvWQ0uEjgsiR2Vz7IVBps23MTF4PKHU5AG0RI4HNI8Hv3chuBDPZ1KYaCWrmvHV64I/CiOKbs67wKm/AjXUi+XHoL09/3AjTZKuqlsmUfqEp1oC9NjMMCvXToqkL6nLg5l8EnpA/fx1nQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5506.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(6916009)(66556008)(8676002)(186003)(66476007)(2616005)(66946007)(4744005)(426003)(83380400001)(508600001)(1076003)(5660300002)(26005)(9786002)(2906002)(38100700002)(86362001)(4326008)(36756003)(33656002)(316002)(9746002)(8936002)(27376004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?nyrgIoi93sbid2S7xvTX5JpaBlojbeSiaxysx00tcakVmNbqEoEvLl0oDM2t?=
 =?us-ascii?Q?gcWAhaDKN9N+uLYgyD/d7oyxYieXcc2aky1XK1Izm1LcPkAaWMnhEbv3l1x5?=
 =?us-ascii?Q?eW1Yzn4V0kXq4Cju9yCaHrYjp6n2DOmOEw9GRa8Tw3vwhLClsSkL2oyxhy6n?=
 =?us-ascii?Q?5KDjXe+D2n1SHe+JnIg+XcnULnZ/R/EnvYsB+HhVYN9PHoksmQjO/FZsNsug?=
 =?us-ascii?Q?SuK5sXMVGymKnj6S1uefjtkGPR8Jvsc6aDyJAKVnTrYiYdtidWRHXzKUetyi?=
 =?us-ascii?Q?qSBepR6uuaGtCILG8Jm1QCtFTB5NMNpT3IJ1DGt0fumQ+3lHQnm5gb1IvwPM?=
 =?us-ascii?Q?eze0PlAioqJjO7pdA6h392pAI3JYghO3PmH0uiJ6+0Cl5kZ0VB9tSZ2K3aAV?=
 =?us-ascii?Q?lE38cqsQK5qHUCF3iuyorf2UUqz2nk5ZzUhA70BiXhgqYurEdU+rvL3DWM3N?=
 =?us-ascii?Q?KfJotw4gSuPMoWmd9ZJGoAKAdT5vDMWz10xLr8c3Sk0eZPClTxWQ91DBQ6wl?=
 =?us-ascii?Q?zqS/nvHSsnsve6nb1yJ4ueiNtkuF5n1V21/HRpuz39TaUEeARJJAgTYUDtCy?=
 =?us-ascii?Q?AYWAedAM8EVq8m1DD3kKmEBExnhaC1yKzG96sQWVd6/N4Mfe2E+QIcUEeZGW?=
 =?us-ascii?Q?ocQ9B/6pMvd7hdvux7yYD8hR67BVIu2wU31NhGPZORr49VhP66y7xb0K7By7?=
 =?us-ascii?Q?F4xURfDGhN7ynoBTIXbn6cmXvHV/8G6Vary3+gIB17R1PdCLFOz4Y065gOHe?=
 =?us-ascii?Q?IHy4uMm3oiRB4dasllc1gElVLtxOethRqCKk36nDrf1AVeMQJz6dft+QUm4l?=
 =?us-ascii?Q?ikUZBwlpOsq3ujTtkrb7RsyzvlpqKLyTZvtoL4usr6l8F+usIv0k7KENvn8x?=
 =?us-ascii?Q?c6PdESvoUu1IhlYdOVhWx5jrcVGpjO+wO1LSNhbGdO9t0usds5YkRA600a4v?=
 =?us-ascii?Q?WBhoMSwU5KpXzIPB+a2TQuWUJubgVygkpUImHQVR5GeGDiEBEx6lEny1Rl3l?=
 =?us-ascii?Q?nKOSW3HX2Zg915ycdraq/d7tB9zz1jGBPfkKR/VefkY/ibhpgVmBYh4rNxB3?=
 =?us-ascii?Q?svyrKAzgQRm1mpqiKyzL4/rDyPNGEcnb/v4wIFT3/1MXhaLzOX8AoyfHUqv5?=
 =?us-ascii?Q?ESeXAsQS1J6EqGYi5i48+9ux0aKPCT8hchZl4Fl5fxAvW/fY/lJoOSrQmDBz?=
 =?us-ascii?Q?YOuBq4VEPe20dMKnaExYzVDL1XhxCCMkSZAh7OgXxxfdO+yFTBO8mCYglNyv?=
 =?us-ascii?Q?hJbnfUX6HzUNqBLSjkxDhziV1pTwzDAdq1RPDdUOtYvHMhnqR9IHxY9tvCLS?=
 =?us-ascii?Q?ueVgnxAUwfaHuRuwveqFHcRaOMEJwYn3CZANda50Qdv98YW7UfLZqU3lsFAb?=
 =?us-ascii?Q?cuKaOBcjBgDa2y/eJ1Z9ZU4XQ3MbxRCnbFQcspPk/TLZaKQLDHTrEPidswQS?=
 =?us-ascii?Q?zOETilBX3sYB9K9KhZKYveQzcfy5ZIN2/nMnOLCIiq/ShmouUBRzuVHk/QjU?=
 =?us-ascii?Q?kxMBvo9p/933l/7oeCRZKXXbbzd4SyAmRiNFii/1UybSOyD0DYiHThT0uHkd?=
 =?us-ascii?Q?TNDYKFokgqlUNw4W3YY=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6bebcee1-5cd1-4a87-919c-08d9b9ae05d2
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Dec 2021 18:18:52.5113
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XGgX5MEHDBPDSigmqH/FXSySzN651FwEK7AJimMECbk8UBemxDTdwgijLK+aHSKF
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5157
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Dec 07, 2021 at 02:40:57PM -0500, yanjun.zhu@linux.dev wrote:
> From: Zhu Yanjun <yanjun.zhu@linux.dev>
> 
> The variable pkey is assigned to a macro. Then this variable is passed
> to a function bth_init directly. And pkey is not used again. So remove
> it and use the macro directly.
> 
> Fixes: 76251e15ea73 ("RDMA/rxe: Remove pkey table")
> Signed-off-by: Zhu Yanjun <yanjun.zhu@linux.dev>
> ---
>  drivers/infiniband/sw/rxe/rxe_req.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)

Applied to for-next, thanks

Jason
