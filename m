Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 210763DF314
	for <lists+linux-rdma@lfdr.de>; Tue,  3 Aug 2021 18:43:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231416AbhHCQnr (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 3 Aug 2021 12:43:47 -0400
Received: from mail-bn8nam12on2059.outbound.protection.outlook.com ([40.107.237.59]:5857
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S234238AbhHCQnq (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 3 Aug 2021 12:43:46 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ekPGpe/r6IILkppbN+Aru0IcSxEeigPrUjq7HKOD06LQr8Jbpwguad9veUPUsP2K+smEYfK6yfe2KbQeYUxKBEIEdLkrrXAKJuotxvNrmljudB9oMsQEy7JIlJnT4D+ie5TI5GtiDsyxShEkPSiw6fXNnqTsG6mLAMnCXXo/29/wqTMJ4wJxC2NSEawBSe+mahN/6zbpVJF4QMA22EV/1zp3w9hzj0aPo772AR2YX1A1g0+axbL1Bz981B2TV8KwfGB7mrxtBgDtVjSKEka7zBBvCQoj3an8nYdZI2ULZXzeaojjpfow5zcue0TwvG6hqkYVdabxW0NnmtPwHJd0yg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ls/DL93wpWkl4DWQ/j7gyEf2gSmAKLj5ryeQBJofBGE=;
 b=V2dmgVoAQ2AGNNu9TynUVG3tvg2w3W5UUlq+dmU3SujHvt3PHMZGwHg8RoXhqVs+kYBoH+MsE+7NzM9s0+zmBd1C+7ZtnNLrTmuqMULTL8FLZAzn+buDEhfHPbrp4UPosxU20v7M44ukFFwc0vdKcvFGX9ZU/ND3DW5rc2ndRL1ln0JKUHq6/B4UYAGImUvwvSIH7VnYjDKz4uRNx/vmrgWrK2LDVsuxR0I+yA+AyDj9hCuotus11x9Yw72VagK8fKAHKUQvJ6LcMe0X4OuUzb6JZrxfmvR8ZwRij2Gb4HL3dDtgOoNCkChpbiDCrMn8r5ENAwtdIaQuz4d8skVhZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ls/DL93wpWkl4DWQ/j7gyEf2gSmAKLj5ryeQBJofBGE=;
 b=jjsLhVpg8HraZM1JigaRXl7quNdgSe+PJsIibHi63fxxj5RpMThSj7zVn3IZ+cjs+AugGa4fxwml+Kph3NqdsGEIMnMxJ/BSfdsuafyJQch+2WLGU6qNFfZBJ4t1JayakR20J9HP6cfJl02u96nTOmnggCyjxfjp2t3+rh/JBCsPHribeBLP6PVKO5Bz9LpN0vtUZ/7NtbZMdUcMJZcjiqZWojOfuOhKPccIqxNpSXAl7UGWe4Ep/KEDlIySofh0kMKxR26wEecOfbfBNEYgO7eKuhBhzh/2dJjN/O4GpACqSm7GyVS80vv/YGZE+9CaXU+gB2VScaPU0hgNM4Gb0A==
Authentication-Results: huawei.com; dkim=none (message not signed)
 header.d=none;huawei.com; dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL1PR12MB5269.namprd12.prod.outlook.com (2603:10b6:208:30b::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4373.21; Tue, 3 Aug
 2021 16:43:34 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::d017:af2f:7049:5482]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::d017:af2f:7049:5482%5]) with mapi id 15.20.4373.026; Tue, 3 Aug 2021
 16:43:34 +0000
Date:   Tue, 3 Aug 2021 13:43:33 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Wenpeng Liang <liangwenpeng@huawei.com>
Cc:     dledford@redhat.com, linux-rdma@vger.kernel.org,
        linuxarm@huawei.com, Yangyang Li <liyangyang20@huawei.com>
Subject: Re: [PATCH for-rc] RDMA/hns: Fix the double unlock problem of
 poll_sem
Message-ID: <20210803164333.GA2895122@nvidia.com>
References: <1627887374-20019-1-git-send-email-liangwenpeng@huawei.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1627887374-20019-1-git-send-email-liangwenpeng@huawei.com>
X-ClientProxiedBy: BL1P223CA0007.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:208:2c4::12) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (142.162.113.129) by BL1P223CA0007.NAMP223.PROD.OUTLOOK.COM (2603:10b6:208:2c4::12) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4394.15 via Frontend Transport; Tue, 3 Aug 2021 16:43:34 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1mAxVt-00C9AG-6C; Tue, 03 Aug 2021 13:43:33 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 33dc0e10-30c1-4e7a-0fdc-08d9569dd577
X-MS-TrafficTypeDiagnostic: BL1PR12MB5269:
X-Microsoft-Antispam-PRVS: <BL1PR12MB5269B08EFCABC43A730D83ADC2F09@BL1PR12MB5269.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hmj5Rlcgc0P9LStovTRfgEn+f7jlklhLVVJwtxU+zN5Twcn1S/ePxW8fuYBNAG5STnDWWY+aoVTt0f3e6g39VcyzSqGEI9U1hFHSKpW6BTPsBPxSg+aiaD/EAB/7aA2UACQG+P6CWtVIkaliirEOZvbj31oYPiku/IdmY3HKENqN5Hd6jgrcuaBWWvcPplPHAjoxd2yJHmwllG2Cmvjo9OuP/Ln8McHQB78wdJ3A5p/R4O+MlVsmOLMmDu//H76kAZkqpib2NQdADCCzE2y9RBCRCi92VR/QGbhZ6ygCKSiQRWAhk4z0ULv8J+59UodnSVn5Hd2L2kRYadoGi/GevQt03LqQsVhXA+1dBEgaXxKcAeCZISdpusuLGt9bQyvP3/SC72wzB6gsIp2KGCrDrxNv9JgBPPAj1nx+wdCXJjzYJuHqdtXITatmGrNHi2qGU1JmVW4+wcpFumk9mc9OxlrghBPc99EfENtKhGqJUlNvnD1Eh/sebHTq8lnmBVYlNtwxkPBC4EQwVZo4nNZMBm9i4VJrCYoyASCw0gp5U1HVbXFAdkYwzew1CWRrML/aSxAoWaBZubpiVfEJq84uec+06cLyHaEkif0wcv3IQnPNa0sNpz4Y/yuNnuQ40qASXJ1HWoHZWu5cOl2GXxNkSQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5506.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(366004)(39860400002)(136003)(376002)(396003)(186003)(26005)(8676002)(2616005)(36756003)(66476007)(66556008)(4326008)(316002)(5660300002)(66946007)(8936002)(86362001)(9746002)(9786002)(6916009)(2906002)(33656002)(83380400001)(1076003)(38100700002)(478600001)(426003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?dj0iRi4XPGwlTzJSvMrjFHHzmHShCkj4kPN0L812RcPtrz7T4Z2Gf5ufzn/d?=
 =?us-ascii?Q?1CIiMeGkSZCsAMZLiftYSDoF2/JHPN/9jyRMOjUyOl5ilVoAuzQ3EN0DOMQF?=
 =?us-ascii?Q?EcYFv25o1chdgBfRnzM7KmrEDXeqOEP5be3b71OGu3ZsKl1thXsym0erNzH2?=
 =?us-ascii?Q?g8rau35tuEu1BtOYWHnTpRKWAPTZGRqvF9S9M0aHRTbv5Ymf8Ml0B15Hd166?=
 =?us-ascii?Q?mmo+I9+RxHnXdvw1eryMywKykRpJ4oEeUPiusMLM0PXBjqNYBs3I+s0JvLd1?=
 =?us-ascii?Q?3utcnqyWsr+c+rJVL8EoAkkrvUCDLdzShR6fWaoGqcsVHE4E4p//ihNJ3twG?=
 =?us-ascii?Q?S1y1EH6LFnrL/0WJ1KNzVsVuwFlJF9geYY5L+PaVFxPSrKhAq2BUwDZr9P9L?=
 =?us-ascii?Q?uNdCKXFong9y8mhOL+WDbmjjSaz1Z459hr2jCHwHvdLrej7C00Mr2FO0IajE?=
 =?us-ascii?Q?WiOcBEfx/2uUpMy47SPzsoliCTVd7YfRJhaj5nvjVlp5pl6zvbViups3neAL?=
 =?us-ascii?Q?nlDq1h/N3n/O7ZHy/wo/qYlUQ0UjiLxRvFcJ4RbbDSRObvfz+MExmSwRfuRU?=
 =?us-ascii?Q?j+PEcdi6+zYjhrtrUaIX/dGID9I53biyXPfquR6LOfsanCluLHr5VG/1nKtw?=
 =?us-ascii?Q?y+06GwhjXpYU3dt2ee/hQtVkSYKbs+o0NPbH5u1g1RsGQdZ4Qg0uyWc9601t?=
 =?us-ascii?Q?TV3HcKPO1OBlLCh79/VO1EmKduzJvBqSs5oc42EK+sLyHbskVWfgfzveluUq?=
 =?us-ascii?Q?fZSVZ3fy14yTHt0L7NayzkxITJSipBKTtGQUJTkC/sh1oZ70cMoBAJXWF8Pj?=
 =?us-ascii?Q?5RP1t6A1H+QkID9IbeVLTAh41NO/AmmpjQwZfm6fMu4BispymwPOVL8m0Jk/?=
 =?us-ascii?Q?FBMJhgeqGz0cAFTyxRS6fFdv2Er8FNNj69Jv9RCwCz970+E7fsSQFGVMarW+?=
 =?us-ascii?Q?wtEXG3IdFLGVqdIAL4EQw3s9Xuw1v+BC6IUe9tVOTsCLJpEPuVd2A8AxyUGj?=
 =?us-ascii?Q?qZpoJ5T+h94vdOryJmCP2gQ3v3teSVC8WJTeQ5BLnz5Obb4NiF05Dj+4BMyz?=
 =?us-ascii?Q?xnHIYaND63Ln9EsZctOmFpnx/rOLSbhA/Na8/ksbsvBl6w/Wap7LmZlACAbT?=
 =?us-ascii?Q?1BkL6cLokBH/RzIQth+sX4LCEVfDEF8zh7SvTpwJeMaNiZkMVuxlCCrLC78U?=
 =?us-ascii?Q?oPlS/AE+8O1WWhc4l4p7gsaWa+AAUtj0VcHXX6f5Dl+f4fHXqwTS2wwq9Ycs?=
 =?us-ascii?Q?6/cdLnDrABYaZfXGAmNgAyyzGaoQOvUUPDDd+SascRSqukvo0YQCyPoM84bM?=
 =?us-ascii?Q?j6SKbwILD2/G2qBrMP4TSeY4?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 33dc0e10-30c1-4e7a-0fdc-08d9569dd577
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Aug 2021 16:43:34.2144
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8/CyKQpI+gjKNQ0iOluyn3O33ET2sIXW9VzgCadDgxIyVHOILVL9v3mITskV25U+
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5269
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Aug 02, 2021 at 02:56:14PM +0800, Wenpeng Liang wrote:
> From: Yangyang Li <liyangyang20@huawei.com>
> 
> If hns_roce_cmd_use_events() fails then it means that the poll_sem is not
> obtained, but the poll_sem is released in hns_roce_cmd_use_polling(), this
> will cause an unlock problem.
> 
> This is the static checker warning:
> 	drivers/infiniband/hw/hns/hns_roce_main.c:926 hns_roce_init()
> 	error: double unlocked '&hr_dev->cmd.poll_sem' (orig line 879)
> 
> Event mode and polling mode are mutually exclusive and resources are
> separated, so there is no need to process polling mode resources in
> event mode.
> 
> The initial mode of cmd is polling mode, so even if cmd fails to switch to
> event mode, it is not necessary to switch to polling mode.
> 
> Fixes: a389d016c030 ("RDMA/hns: Enable all CMDQ context")
> Fixes: 3d50503b3b33 ("RDMA/hns: Optimize cmd init and mode selection for hip08")
> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> Signed-off-by: Yangyang Li <liyangyang20@huawei.com>
> Signed-off-by: Wenpeng Liang <liangwenpeng@huawei.com>
> Reviewed-by: Leon Romanovsky <leonro@nvidia.com>
> ---
>  drivers/infiniband/hw/hns/hns_roce_cmd.c  | 7 +++----
>  drivers/infiniband/hw/hns/hns_roce_main.c | 4 +---
>  2 files changed, 4 insertions(+), 7 deletions(-)

Applied to for-rc, thanks

Jason
