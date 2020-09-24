Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A96102779DB
	for <lists+linux-rdma@lfdr.de>; Thu, 24 Sep 2020 22:02:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726440AbgIXUCP (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 24 Sep 2020 16:02:15 -0400
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:4597 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726037AbgIXUCO (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 24 Sep 2020 16:02:14 -0400
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5f6cfae60000>; Thu, 24 Sep 2020 13:00:38 -0700
Received: from HQMAIL101.nvidia.com (172.20.187.10) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 24 Sep
 2020 20:02:13 +0000
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.174)
 by HQMAIL101.nvidia.com (172.20.187.10) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Thu, 24 Sep 2020 20:02:14 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hoQ3IT0ir8qwZaYDzn0SlWrqzu01IduLIPaKhwIQUfA7LoAr45+YhbAt9+/FfXC52ym3++b042fT4yocRmfRBh3iZmTyfwu4CKMslQIBMBNAg+UbcZVerlYc+o8yqJx+gpQ/h4iPIWGtLzy8Sm74fKLGqUcU/aDLKEPYddjsUPzPfwlocGQpUladBt6qElswRmUY5MGxQy9jZYBXqTm1ZGbov/VvZ3gPhUVqsKX6Qy3UJ/uEYZ+2sMUv6tRSCO1NXkU2nyJo9OhmLvQny2J+z98u5dGiz8qJiEVjPUSD7nUWCmlIWQyLHkFkAJC8nCENhuYD/G0XfbbZ9gujvKnypg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7ykDBG6KKeWX+7A5hgKSJugIubLzyjcczc8/C9kA+3g=;
 b=jkTK8bAXJ+erg25n/AdbHbK2gCwWfgJUgXGl4pM+5rkLxsE0nWOkDmqgvVF5l3ahFR61PQ6fmatesR+2+4ZucLreiCUzeOMDQavsA2wKTVXcbd0LoLJ//MaGn3l81YeTijgftGI45gARX1G3Zmnt1+WmrEgol4HZxzWfg8m1Woz66vBVppsOo/HX5y37Q87CbcSdeqqx1Tjih9LYA4SRKUDXPjzugFTpGt7vGgAsFMqtt4baZNZY3pvp5aHSSOmyUU68tBfwUavwC4qHHf4Knvg/vPaK9ZSZSmLOoId0e/GSonKw1oV3N68z4EbZHYaKl7ZO66J+63eSUaeaaH+BDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB4266.namprd12.prod.outlook.com (2603:10b6:5:21a::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3391.14; Thu, 24 Sep
 2020 20:02:12 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::cdbe:f274:ad65:9a78]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::cdbe:f274:ad65:9a78%7]) with mapi id 15.20.3412.020; Thu, 24 Sep 2020
 20:02:12 +0000
Date:   Thu, 24 Sep 2020 17:02:11 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Leon Romanovsky <leon@kernel.org>
CC:     Doug Ledford <dledford@redhat.com>,
        Leon Romanovsky <leonro@mellanox.com>,
        <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH rdma-next v2 13/14] RDMA/core: Track device memory MRs
Message-ID: <20200924200211.GA133077@nvidia.com>
References: <20200907122156.478360-1-leon@kernel.org>
 <20200907122156.478360-14-leon@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20200907122156.478360-14-leon@kernel.org>
X-Originating-IP: [156.34.48.30]
X-ClientProxiedBy: BL0PR02CA0093.namprd02.prod.outlook.com
 (2603:10b6:208:51::34) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (156.34.48.30) by BL0PR02CA0093.namprd02.prod.outlook.com (2603:10b6:208:51::34) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.20 via Frontend Transport; Thu, 24 Sep 2020 20:02:12 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1kLXRT-000Yd7-3x; Thu, 24 Sep 2020 17:02:11 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8228ac40-eec5-41b5-e3ff-08d860c4ba1f
X-MS-TrafficTypeDiagnostic: DM6PR12MB4266:
X-Microsoft-Antispam-PRVS: <DM6PR12MB42664D06FFF913DB1F0ED6BBC2390@DM6PR12MB4266.namprd12.prod.outlook.com>
X-MS-Exchange-Transport-Forked: True
X-MS-Oob-TLC-OOBClassifiers: OLM:283;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aF2lix3F8ip+UjceByrqBiTAOiNEW34BP3lZSoV7cHSjKz9qM+uTKuc75BBW27dkltTy1Gp68bqxFKuZ1TiVRGSZLSPqt5GQHgHscdsDUs1z5nGn4yS2xMAQsTaTVwIu3ywkHJDrVqMQo9tlonBNV+umARvgIVgGsYYt9aF+tEIxaZsqxbmajvrsVMNkZcEypeGIRJLts3aZxKkYBwkAGsBrOpt0aFAloQWW4TV2I7pt4tlM8Zzrbk2sQqSMTNDSMNNtaDbYnwok7fvOx/eB9sllyJEJDN0LNvMtCm7GalBAOrI0K6/u2kIwA+kplVxDgycSnI80kOWJ23HwiZahU44LYPBGVrADYcGMDpitFMpAbpubdJQgMbP0REmSFDV5ea43zAWwr4vyAy4b0MumjKvfTIE+ZTnMs9b0G/h2i74=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(366004)(346002)(396003)(136003)(39860400002)(9786002)(86362001)(9746002)(5660300002)(2906002)(54906003)(26005)(83380400001)(8676002)(1076003)(316002)(478600001)(6916009)(186003)(36756003)(4326008)(66946007)(66556008)(8936002)(2616005)(66476007)(4744005)(33656002)(426003)(27376004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: YNGvw22D/dVsZR7nwpL0MO23hst5nefFhVwLg+B80Uv3EpKVjUY1OLfkMKfJ8BbO5gUeiLB2W8yYru9NUMVVZ4gPp4oca8oU35DFjtbBN9yfAkAhZPo5ae3GT9BWPP6Ex9jbVcvKN2Tbkueth91WUNmI4Op6ahQKxDOICcTjjkKiUVpeXMsmvBesYkr8sJO9keoI8xNrV6+/suw9Ah3HOq4m2avzMBkX5S+/13bnbviXADRwPU0EvGKwElgEctjmo12aM8kNKXKEtq/SNNXR+Xknpr3/dYyMa6x/qy11NbI8NweR8vxIX68tKQq/KBTKNw8YoA6zU506Q2YaQnsNWuxvAA4HreIeWdjbj6Az5YMRChswk6dpj26lwB8M7WYp0CZKjzuKjJ2GuHdb3NFmas8QrZ1mxUSmpIVQ7FCF47S4Em8DBVSFTrGk3f31LgQzO4/XEv9ZEnVmSHdvmGrrboF22seh3q+pk1UfuZHgQtTB/nxo7SS2iJpI0juca0HU8SwHUbfcJ4hMwKlmX+rDhZAyn5dpdkL4IYDVdZhQUXo2TbdWrvlDLI94Fw8fy3ueIyFHMw2zO0H6uRIrKOQIfZai/zZ+TQ7luJCcVYhrJYgqJfTLPxTR1MRB/ACLX6QwK1adPRYHusTcmXpDUhGlRA==
X-MS-Exchange-CrossTenant-Network-Message-Id: 8228ac40-eec5-41b5-e3ff-08d860c4ba1f
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2020 20:02:12.7692
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 13HobiBi5Tv4di8q8OWI0cd9o46owj9m7665ivoLkiLf31vF1DhR0FWQd/ieUSA9
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4266
X-OriginatorOrg: Nvidia.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1600977638; bh=7ykDBG6KKeWX+7A5hgKSJugIubLzyjcczc8/C9kA+3g=;
        h=ARC-Seal:ARC-Message-Signature:ARC-Authentication-Results:
         Authentication-Results:Date:From:To:CC:Subject:Message-ID:
         References:Content-Type:Content-Disposition:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:MIME-Version:
         X-MS-Exchange-MessageSentRepresentingType:X-MS-PublicTrafficType:
         X-MS-Office365-Filtering-Correlation-Id:X-MS-TrafficTypeDiagnostic:
         X-Microsoft-Antispam-PRVS:X-MS-Exchange-Transport-Forked:
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
        b=DcZLoYOG/pG2d9Y4vE2hzUSM6jKOCRg/t/TLz67qohQhbc4IvmGhmKmwFuffMP521
         LWfpIIWjwTRc413+vxlvgEj07TOVG+llbsrMFD/JFPbpFXcO6v4Gp5xZHpTfmd4Ti8
         H4dS4RE4w9MbQskDQGy21FoIsbI3/yPWzKJpjN/Gs7ugrJn5/cHd0vnOelgylGKa3j
         95YLXOCdMvqxxCcfP5+0/KmQawLMqgKcOgNcgO7u512K0VzjpMI8/WiY3z3l1KjzDB
         UHST7I0uxKSGhkIhW/8r4g79KV3AaFcIIwoiiF6X7gEOeXwhhPT2aokjOsGpGE/WYw
         Wh6caceAs05qA==
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Sep 07, 2020 at 03:21:55PM +0300, Leon Romanovsky wrote:
> From: Leon Romanovsky <leonro@mellanox.com>
> 
> Device memory (DM) are registered to MR during initialization flow,
> these MRs were not tracked by resource tracker and had res->valid set
> as a false. Update the code to manage them too.
> 
> Before this change:
> [leonro@vm ~]$ ibv_rc_pingpong -j &
> [leonro@vm ~]$ rdma res show mr <-- shows nothing
> 
> After this change:
> [leonro@mtl-leonro-l-vm ~]$ ibv_rc_pingpong -j &
> [leonro@mtl-leonro-l-vm ~]$ rdma res show mr
> dev ibp0s9 mrn 0 mrlen 4096 pdn 3 pid 734 comm ibv_rc_pingpong
> 
> Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
> ---
>  drivers/infiniband/core/uverbs_std_types_mr.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)

Fixes: be934cca9e98 ("IB/uverbs: Add device memory registration ioctl support")

Jason
