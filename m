Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F2B6A25C49E
	for <lists+linux-rdma@lfdr.de>; Thu,  3 Sep 2020 17:13:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728754AbgICPNK (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 3 Sep 2020 11:13:10 -0400
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:18985 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728735AbgICL4U (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 3 Sep 2020 07:56:20 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5f50d9cf0000>; Thu, 03 Sep 2020 04:55:59 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Thu, 03 Sep 2020 04:56:13 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Thu, 03 Sep 2020 04:56:13 -0700
Received: from HQMAIL107.nvidia.com (172.20.187.13) by HQMAIL109.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 3 Sep
 2020 11:55:54 +0000
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.109)
 by HQMAIL107.nvidia.com (172.20.187.13) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Thu, 3 Sep 2020 11:55:54 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AdlluSqlSBRc5Bj7YBH7b+jgHgVqZ6CBH5BFdH5I1zRmMPY/a6Mldug+E/K9h0KymOnjktzeJZTFe+nBKNJ5szU4tpdJcgt29NVfOFAPRtQJdBnt8WJkod+RSVIFo/5wopq03z++bzLUv3AS6binIkk5cAbXFFVfv01Z5SaLUhCQL6OrdEmCfOy8OyIbEVfAdRlmpsstGT2W5qroXAogqUp7adSG08X0PZQV5apyjr2EU/9PIx/hitTsMh6WkS+trWbTn881xgeTheVGyoOoS42cR2xGuM0LIV/t+Imk8dmc0vnhmiIFpnsjxgI2H2C3WeDoN1+qeHDLBHGn3nbjFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3SXZFU57ZxNs/KzQCWCteTFNVrUiLvlDuJcuOsp4T3c=;
 b=JQeVpYvV5x2lElcyuG/ZyhMICXvButhIu02j4btbtA0USaKeTSNA76SbWqd9ly4o6lL+hWAB/HNmXc5woIyn9eHmjK/GBiuj/3PG/0lmYYXFREa3ezi6wjDBhskF1VbnJwlfl13KdoJeDOcsUr/DcoMtptXHEBdcpdRjxGxgESzI4TZFunE9o/4GsRQW5/D9V1TNzXVC1EMjcH0/5936020Jk6F2ag3vO0H5fPk4qOtlv8SPVL4Nw+jqq50e+e+7w42jXQgWfwX4bDDFAiEM6fDdaAU+z21s0jhRu00TOqpE4b5JZkMSs6DLJNiJ74kdGOhPoyqHrARn6Olyy/9YRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB3115.namprd12.prod.outlook.com (2603:10b6:5:11c::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3348.16; Thu, 3 Sep
 2020 11:55:53 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::2d79:7f96:6406:6c76]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::2d79:7f96:6406:6c76%3]) with mapi id 15.20.3326.025; Thu, 3 Sep 2020
 11:55:53 +0000
Date:   Thu, 3 Sep 2020 08:55:51 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Leon Romanovsky <leon@kernel.org>
CC:     Doug Ledford <dledford@redhat.com>,
        Adit Ranadive <aditr@vmware.com>,
        Ariel Elior <aelior@marvell.com>,
        Bernard Metzler <bmt@zurich.ibm.com>,
        Dennis Dalessandro <dennis.dalessandro@intel.com>,
        Devesh Sharma <devesh.sharma@broadcom.com>,
        Lijun Ou <oulijun@huawei.com>, <linux-rdma@vger.kernel.org>,
        Michal Kalderon <mkalderon@marvell.com>,
        "Mike Marciniszyn" <mike.marciniszyn@intel.com>,
        Naresh Kumar PBS <nareshkumar.pbs@broadcom.com>,
        Potnuri Bharat Teja <bharat@chelsio.com>,
        Selvin Xavier <selvin.xavier@broadcom.com>,
        Somnath Kotur <somnath.kotur@broadcom.com>,
        Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>,
        VMware PV-Drivers <pv-drivers@vmware.com>,
        Weihang Li <liweihang@huawei.com>,
        "Wei Hu(Xavier)" <huwei87@hisilicon.com>,
        Yishai Hadas <yishaih@nvidia.com>,
        Zhu Yanjun <yanjunz@nvidia.com>
Subject: Re: [PATCH rdma-next v1 05/10] RDMA: Restore ability to fail on SRQ
 destroy
Message-ID: <20200903115551.GZ1152540@nvidia.com>
References: <20200830084010.102381-1-leon@kernel.org>
 <20200830084010.102381-6-leon@kernel.org>
 <20200903000850.GA1479562@nvidia.com> <20200903051112.GP59010@unreal>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20200903051112.GP59010@unreal>
X-ClientProxiedBy: BL0PR05CA0021.namprd05.prod.outlook.com
 (2603:10b6:208:91::31) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from 255.255.255.255 (255.255.255.255) by BL0PR05CA0021.namprd05.prod.outlook.com (2603:10b6:208:91::31) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3348.7 via Frontend Transport; Thu, 3 Sep 2020 11:55:53 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1kDnqJ-006RAL-B6; Thu, 03 Sep 2020 08:55:51 -0300
X-Originating-IP: [156.34.48.30]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d2118af7-61f0-4150-4e40-08d850004f1f
X-MS-TrafficTypeDiagnostic: DM6PR12MB3115:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB31153B57C802AEF8B4318E9DC22C0@DM6PR12MB3115.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2512;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4Xqu2dA6t2fZ2Vs4W/XDiWVuCZngSf9b58HKZjL9H5OiU/z1SMacbdzFHNIQzMV6hn8xCRrSukk95Y2o9bGhC3+VAKzmtd1QEUCg7dgDUfBJ7vUHdToqF0cvHMhQSCfTz1ZG93uII3TiMPCwKhgAlpbzLXOh6VHQMFtQoTwMxi2JYz8UA+kBOO+qWeaGQfgn2imS+6TeOQcPA+qsBauCJicMkkZvHoqsn373QwtYCEZzx307YTX3dc4KNRSnQ1G81CbszHkbxdotzvEuVoY3ye6QmKVtulydo49gQ7So254GN+ewxRLEE0Oo1uzxw65AYaOEBpXZ2QYbQ3i2o3naoQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(346002)(39860400002)(396003)(366004)(376002)(26005)(6916009)(5660300002)(36756003)(66476007)(186003)(54906003)(66946007)(2906002)(478600001)(66556008)(2616005)(33656002)(9746002)(9786002)(7416002)(8676002)(8936002)(86362001)(4326008)(316002)(107886003)(1076003)(426003)(4744005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: yKXFRHCt4zph3ekG9B1bLRzRPhuJVRgk/PxT1MkrzUDIXI8wl2Aq6EBsGgN04TrFKqpj+oWydMZ6GU+kZKRjstLDDYHCSKW9dX7wnpLnw410dpcrfMsGgvsYQyM/z4yn5gdQ+IMf2vX2ZwDAfEhkmsujstFBAwccGnc/1IgcQazVXm9u08Cj8dHlJ9XYvSN8ZBhc2/LM9N9QAMOTk6PuuscH1oV+QBzomHcePfXo3ltEqNeMrzveihlr0Enm5Bag83SWYGB3EPi/Td7MBByRRFWZUa62NMcdjC4s4uwmP1Yg9dUFRZ5E5VLzelHm0mRsvyVo2B5ZsElk/R2tYZBoIg9HVHkg5XVe9uDlYPviuqSciSrDbC+K4oW+i44BWAHexa6dU+y55ds5YBqj7euiC62YDpunyHA6WMpUj8DYIwillLFOVVxtuFvnR7+lkcCFuTrbJmR5GLf7YihmuppziUq0ILYLTGSaiMBy7pMe1MFKvyP9GGW3HiayPom+gAQbb2VItVD7ks+GPzkkRJoAFn+or7f2dtbMcZlE4YTvVXgvVOhgIYhIeUbUHSvblnIv0ggkiHV6IlqiAqvAc2biIM+yuq22YZ0fjF654rgsoybq6PIca0LJmzKiP/XmrjAuX8DwWtxT8fsOUT2mMwd1cg==
X-MS-Exchange-CrossTenant-Network-Message-Id: d2118af7-61f0-4150-4e40-08d850004f1f
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2020 11:55:53.2238
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4F+5fzsxwf0NGLkPuGC+7pvFqdE/Sh4MBls2yuk68rdjPl3MrfIg02XTFuTchXxh
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3115
X-OriginatorOrg: Nvidia.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1599134159; bh=3SXZFU57ZxNs/KzQCWCteTFNVrUiLvlDuJcuOsp4T3c=;
        h=X-PGP-Universal:ARC-Seal:ARC-Message-Signature:
         ARC-Authentication-Results:Authentication-Results:Date:From:To:CC:
         Subject:Message-ID:References:Content-Type:Content-Disposition:
         In-Reply-To:X-ClientProxiedBy:MIME-Version:
         X-MS-Exchange-MessageSentRepresentingType:X-Originating-IP:
         X-MS-PublicTrafficType:X-MS-Office365-Filtering-Correlation-Id:
         X-MS-TrafficTypeDiagnostic:X-MS-Exchange-Transport-Forked:
         X-Microsoft-Antispam-PRVS:X-MS-Oob-TLC-OOBClassifiers:
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
        b=My/62o+OfNWRkaewmNs4zZCb49kRiwxSxHG8MQqJP2sdF9C/zU3JLCeuO+jqJu9e8
         JH3Q+FcXUgfh8+amdsyNkyoHMFMQNUq75gxtBc1l4U4ZQRDiAOymSOriYDrAvBcDqI
         LHr8lIvKnAAILrneD1SK/Vv3FwBPK7S6Q4JyVfXdxkBMFTdcPrKxKOuQ4z+782qy2Y
         h5RdF4/Mn8enerUWEiyRuJHwDeKZ9KjvlnM7bJ5djwLSu/jzjQt0oNxZXZXr1xukWx
         d87Zb4XDmTI1pOdybz5zekjYYw7xkHoxYPlNGp/X+M0ytpEIgAylC8AKyDLzkisYe0
         z9EbbC5sMBnlQ==
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Sep 03, 2020 at 08:11:12AM +0300, Leon Romanovsky wrote:

> > It is not a big deal but I would like to remove udata as an argument
> > to the driver destroy functions, it is completely nonsensical and
> > never used.
> 
>   197 static void destroy_srq_user(struct ib_pd *pd, struct mlx5_ib_srq *srq,
>   198                              struct ib_udata *udata)
>   199 {
>   200         mlx5_ib_db_unmap_user(
>   201                 rdma_udata_to_drv_context(
>   202                         udata,
>                               ^^^^^^ in use
> 
>   203                         struct mlx5_ib_ucontext,
>   204                         ibucontext),
>   205                 &srq->db);

The ucontext should come from pd->uobject->context

Jason
