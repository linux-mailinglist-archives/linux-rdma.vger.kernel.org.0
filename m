Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 691DD254550
	for <lists+linux-rdma@lfdr.de>; Thu, 27 Aug 2020 14:49:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729183AbgH0Mst (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 27 Aug 2020 08:48:49 -0400
Received: from nat-hk.nvidia.com ([203.18.50.4]:33102 "EHLO nat-hk.nvidia.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729161AbgH0Msk (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 27 Aug 2020 08:48:40 -0400
Received: from hkpgpgate102.nvidia.com (Not Verified[10.18.92.77]) by nat-hk.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5f47aba60000>; Thu, 27 Aug 2020 20:48:38 +0800
Received: from HKMAIL102.nvidia.com ([10.18.16.11])
  by hkpgpgate102.nvidia.com (PGP Universal service);
  Thu, 27 Aug 2020 05:48:38 -0700
X-PGP-Universal: processed;
        by hkpgpgate102.nvidia.com on Thu, 27 Aug 2020 05:48:38 -0700
Received: from HKMAIL104.nvidia.com (10.18.16.13) by HKMAIL102.nvidia.com
 (10.18.16.11) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 27 Aug
 2020 12:48:36 +0000
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.36.52) by
 HKMAIL104.nvidia.com (10.18.16.13) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Thu, 27 Aug 2020 12:48:36 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=devB0Xbrnd/N0Qtm3MygHSI+Rpb7GrapmikBHznLy4C6s8slyqbxsI8C17lneJwIAn1AzSaC1+qOydmggTpAXwX3tyAHIkEAZk9jdzDSlXrXqXIQdfyI45USy48QQRayBcr1KTaMKHBHiStjVB67/M9E6/ul6Z9KjL/Sbo2GOGwtJ3SOSBumqYCLpTGn9CGnU/hM/m0Iy7A0M7jXloZylw3BwT2N0hMw0uF1Y/bDRj1ffVGaxv6cLKCTX6pzXDKBfj9IgqZdeI1Zi+M2VTL5ybwsAGXbv2RUHyQs0mAPXBFrHJKPsM/CHLijEHr774hRVIzKFMUihJBfETVeNuhuCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=exPUDsAtdjSC5tZ4GTwl466TnoKKpZVdEhKrpcql0os=;
 b=b+YwEJQTfkPvyXKO4qnDRoqjCQjAA+eRIRVKAk4NAjJpu51um+0iHF/oFgmTvWe9rU2dHj3C04IctvQSYGbUTudS0NgBCiI6b7evuyOIUjITnHWykwKg/KC67VleObcM1ARJ88c9noMeDOq1C9dH746p4+cA9GV7aJAIDjVCu0jJrM5dzKaDAM4eX4228Poe296iqyOsHCD2c7xLyoq+Uec3LOsXqmiTXkk7hbLoKe7YSCQ9FVs7nSdliQAg6uGr1pmlPiu6uODlEEDlMbUw2csDSg50DfO94zE6Yuoyfeaeq2zOobSwmczebcaobYeG2or7CFn5elVjI/cFaZ7/cw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Authentication-Results: huawei.com; dkim=none (message not signed)
 header.d=none;huawei.com; dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB3306.namprd12.prod.outlook.com (2603:10b6:5:186::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3305.24; Thu, 27 Aug
 2020 12:48:33 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::2d79:7f96:6406:6c76]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::2d79:7f96:6406:6c76%3]) with mapi id 15.20.3305.032; Thu, 27 Aug 2020
 12:48:33 +0000
Date:   Thu, 27 Aug 2020 09:48:31 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Weihang Li <liweihang@huawei.com>
CC:     <dledford@redhat.com>, <leon@kernel.org>,
        <linux-rdma@vger.kernel.org>, <linuxarm@huawei.com>
Subject: Re: [PATCH v2 for-next] RDMA/hns: Add a check for current state
 before modifying QP
Message-ID: <20200827124831.GA4024608@nvidia.com>
References: <1598353674-24270-1-git-send-email-liweihang@huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <1598353674-24270-1-git-send-email-liweihang@huawei.com>
X-ClientProxiedBy: MN2PR05CA0047.namprd05.prod.outlook.com
 (2603:10b6:208:236::16) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from 255.255.255.255 (255.255.255.255) by MN2PR05CA0047.namprd05.prod.outlook.com (2603:10b6:208:236::16) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3348.5 via Frontend Transport; Thu, 27 Aug 2020 12:48:32 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1kBHKR-00Gszm-EO; Thu, 27 Aug 2020 09:48:31 -0300
X-Originating-IP: [156.34.48.30]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c2b42d1a-6a26-4337-7062-08d84a87818c
X-MS-TrafficTypeDiagnostic: DM6PR12MB3306:
X-Microsoft-Antispam-PRVS: <DM6PR12MB3306C0FAF0C16E669075F4E9C2550@DM6PR12MB3306.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 66xJKYvZ9gzHv52599c+mUNS52l/opwgageQGC/dW4RQxhkc6bnJRau1JBps7VBFBNq1gYaOCqeCyeoMuYIEQS03IYvrymcKK77nv5xHnhgFJsxfeFBNSCucc3C9KJ4AZgZqv7YbLppI/DX4KrWF68yfKdNK9GdKenOQRtUX62uYedCK37Ex8eiK33DeO2XXmBqE9En/9fG5OYTBCR9xI0dp+RPuqtGdravMm/nCexBHFisku17XRxN9eP8RYUfrR9yuLQ90PJla1S9eOx5KjZCIou56DmUJ/lJjx3yoDy/enAOrAS3eDNoG5CJj5aHsDsCuGysVm6vfPqsF4Bmebw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(346002)(39860400002)(366004)(376002)(136003)(6916009)(33656002)(186003)(66556008)(26005)(66946007)(66476007)(478600001)(1076003)(5660300002)(426003)(2616005)(36756003)(4326008)(83380400001)(316002)(86362001)(8676002)(9786002)(4744005)(2906002)(9746002)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: YD0TLL2ta2OSqXwteOACFDJhyFhpuz/HUdOGVFGxottKINSjHBnX5/F6siff/Bci6P/tGbCzpv5juhJHw3qdQlMXZ858euTz+/sLQahoTCPf3x1MDqbcq4F1UWWG4eJl2PfnhYT0bTsWhqa9wRra5t3wk7xySg6jqHzzOJurAFEwSIecpa2HRqOYeA0MycK+BBDFVvPwLgpaBnEWyZfcow4E1JvCoIjI6fTdi1QDDIt4022ytdQ09R2VBKQxXsU52Mp2GOX0iR5X7IJ/zqgVpocI5YAbR0anElgar8luUwC03Dwe3e5SxMg7knEChxMNqJmsLKc0v2XF+HTj81cgf4eTMSty/uFcr+RP25j+4wGULViKcKfotsFASBJiD0eSGFvcTiZPHEA1IUPU1jspY6URhulw91StMPRDzIdDDxn4ssF3mAcqJgqyUZuMaQMWtOJ2LrU4BxTDuk8JnVXSdIZwYRcSnYCV8JH/61pVBD1YppnkmGgl4aZUwouUSPE3cw3fydX3PnIOj31KzywP6haS3j5FKN6YdvCLNp1Gz0UoEn/CsKwhHe7LKMVTFG4tu/IYyR1ZjYtpBh5KlRPI+u6pPSaZhE3pyXKbvBjL9Yo+8wZXr0uaUcM+1fsSxPgr3KDoReDydBiij6LoAHaB9w==
X-MS-Exchange-CrossTenant-Network-Message-Id: c2b42d1a-6a26-4337-7062-08d84a87818c
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2020 12:48:33.4366
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rF0DK6hFdV9tgayLLCM0iokCgNQOQ47cS3hEgG6r6pZIOgqpSz5WjjRMacdeGaey
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3306
X-OriginatorOrg: Nvidia.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1598532518; bh=exPUDsAtdjSC5tZ4GTwl466TnoKKpZVdEhKrpcql0os=;
        h=X-PGP-Universal:ARC-Seal:ARC-Message-Signature:
         ARC-Authentication-Results:Authentication-Results:Date:From:To:CC:
         Subject:Message-ID:References:Content-Type:Content-Disposition:
         In-Reply-To:X-ClientProxiedBy:MIME-Version:
         X-MS-Exchange-MessageSentRepresentingType:X-Originating-IP:
         X-MS-PublicTrafficType:X-MS-Office365-Filtering-Correlation-Id:
         X-MS-TrafficTypeDiagnostic:X-Microsoft-Antispam-PRVS:
         X-MS-Oob-TLC-OOBClassifiers:X-MS-Exchange-SenderADCheck:
         X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
         X-Forefront-Antispam-Report:X-MS-Exchange-AntiSpam-MessageData:
         X-MS-Exchange-CrossTenant-Network-Message-Id:
         X-MS-Exchange-CrossTenant-AuthSource:
         X-MS-Exchange-CrossTenant-AuthAs:
         X-MS-Exchange-CrossTenant-OriginalArrivalTime:
         X-MS-Exchange-CrossTenant-FromEntityHeader:
         X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
         X-MS-Exchange-CrossTenant-UserPrincipalName:
         X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg;
        b=VOZEr+TUrx0669RuBWRyITaL49iOxZjfJwF8uuvPiEln1N2tW7cNGCk9gBT8HPfnm
         Ie6uFI5SL9rA4KETGH3i32EtN0qSEyVfem6gyT3zIXpci2ceY8JDicszgmSDca5F1D
         LtKJJNNzco6goA5VrZY4C2npkdqnsuBgITwGNXaNnWZzAj5Iblo854NQf1J3a66RfT
         K3494QwGntp25wpMIFmbyHm+zlo+R69GR2Gn3WemKhrKTvPIzuz1cxycviaexnlC6m
         xVVlDpMoDgqfk9tbR5hyKT8eINF7P47EQULjxe01zu6+Pm+FuGfRf4Uk1q+Kt6Bpr0
         QTvA/U06d7mKQ==
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Aug 25, 2020 at 07:07:54PM +0800, Weihang Li wrote:
> From: Lang Cheng <chenglang@huawei.com>
> 
> It should be considered as an illegal operation if the ULP attempts to
> modify a QP from another state to the current hardware state. Otherwise,
> the ULP can modify some fields of QPC at any time. For example, for a QP in
> state of RTS, modify it from RTR to RTS can change the PSN, which is always
> not as expected.
> 
> Fixes: 9a4435375cd1 ("IB/hns: Add driver files for hns RoCE driver")
> Signed-off-by: Lang Cheng <chenglang@huawei.com>
> Signed-off-by: Weihang Li <liweihang@huawei.com>
> ---
> Changes since v1:
> - Add a fixes line as Jason suggested.
> 
>  drivers/infiniband/hw/hns/hns_roce_qp.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)

Applied to for-next, thanks

Jason
