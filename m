Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 89A0B231E7D
	for <lists+linux-rdma@lfdr.de>; Wed, 29 Jul 2020 14:23:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726509AbgG2MXW (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 29 Jul 2020 08:23:22 -0400
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:10926 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726480AbgG2MXV (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 29 Jul 2020 08:23:21 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5f2169dd0000>; Wed, 29 Jul 2020 05:21:49 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Wed, 29 Jul 2020 05:23:21 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Wed, 29 Jul 2020 05:23:21 -0700
Received: from HQMAIL109.nvidia.com (172.20.187.15) by HQMAIL109.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 29 Jul
 2020 12:23:20 +0000
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.107)
 by HQMAIL109.nvidia.com (172.20.187.15) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Wed, 29 Jul 2020 12:23:20 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZEr+83KdbaoHJt6J+icQcIfTIP6KrbbJULWf2XOCvAQRZCMfgdBiIxvQul5qoHqfSX2ooReC1u6DErnfljYgksnzHRX6toofF14l3nyiw/pSLDoQabZTe5EFuDfXFIn595BVTaRSXiVSnNbChK3Rl9NmUYZgv0MfiN+nEm1NUDtveWC0uBuf7gVxTfTOcwJnVV2Wi9k6pvz0Yi4EnKokZFWitTvGo/crRzhd8of8UifOz0bSckL2OL05FDmg6dCylqB1rlAbWfkeQdZOe9fEf/Y4P97wnsnBa/wCPZpznZZXaeftb3nUlqoqGFt6xfYmF12xjeJz8ZIafGoNAXrtGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b+/GQw8aFp3+00vn2OZI+7QzYTsohOlMGHWHjOcKeLk=;
 b=POBE3wfHM9oXCo9p9rd6eMGx2s2GYgsNEp5JdkwL1gzsml/dVPkHh1y07WIWkD4qC/Qoh2KzkB6soFeOl/DOQ0/L7xgJKEZV9MeuXwVlVim42v5rZSkhwbGwH3XFxQC9+2v/ZFDge6sz+AkRhbXOLmVFlCBmn7JMxJp4jr/2y6zaDJxGrolgPvmV82vN5+NZ23u9kkTRml5RSWjybKcQVNjRMxl/twV02m4Khu/fQ8EH7swDeRboUGATrqRElKnQSbjEAXXwW85aBvIbWqSNngy/4gQSZcnIWmUK217edwSI0qqxs+R9wKpCBVD62C3aKv0VOtPENAvr2JVqieIa4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Authentication-Results: mellanox.com; dkim=none (message not signed)
 header.d=none;mellanox.com; dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB3594.namprd12.prod.outlook.com (2603:10b6:5:11f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.20; Wed, 29 Jul
 2020 12:23:19 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::2d79:7f96:6406:6c76]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::2d79:7f96:6406:6c76%3]) with mapi id 15.20.3216.034; Wed, 29 Jul 2020
 12:23:19 +0000
Date:   Wed, 29 Jul 2020 09:23:17 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Max Gurtovoy <maxg@mellanox.com>
CC:     <sagi@grimberg.me>, <yaminf@mellanox.com>, <dledford@redhat.com>,
        <linux-rdma@vger.kernel.org>, <leon@kernel.org>,
        <bvanassche@acm.org>, <israelr@mellanox.com>, <oren@mellanox.com>,
        <idanb@mellanox.com>
Subject: Re: [PATCH 1/3] IB/iser: use new shared CQ mechanism
Message-ID: <20200729122317.GA219420@nvidia.com>
References: <20200722135629.49467-1-maxg@mellanox.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20200722135629.49467-1-maxg@mellanox.com>
X-ClientProxiedBy: BL0PR03CA0021.namprd03.prod.outlook.com
 (2603:10b6:208:2d::34) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (156.34.48.30) by BL0PR03CA0021.namprd03.prod.outlook.com (2603:10b6:208:2d::34) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.30 via Frontend Transport; Wed, 29 Jul 2020 12:23:19 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1k0l77-000v5d-V8; Wed, 29 Jul 2020 09:23:17 -0300
X-Originating-IP: [156.34.48.30]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ac73cbfe-6659-41aa-767c-08d833ba2d56
X-MS-TrafficTypeDiagnostic: DM6PR12MB3594:
X-LD-Processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
X-Microsoft-Antispam-PRVS: <DM6PR12MB3594D3EA941FF40A402054D9C2700@DM6PR12MB3594.namprd12.prod.outlook.com>
X-MS-Exchange-Transport-Forked: True
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: D1C+MEG0ZhkHoTIh7CoiSPvTW4Ad7XLnX1tB8aMFb4KeoBD8EJOu2kkmxrwhR8Ivs4nzZ/ZxzNXJMwGlj6aE+iHfaN4pttdx9v1zQwqMjZeBxIzmQm/mzlZdta99+NZPmiDqodLMHRykDGvzxQEWtW8OJ/xNqvJ9qBt0j6LXpO1qRGX2KlCWMbkj24Gk60eGVpoVAZuqlo4drzPkb2DaVGHo1567/zNeclBJMuK17DyaQjnxvFNVWY/Ui/PDwuj3gwd3I/4iqWzU66wB/jkjNLVyToDeEtwBRAax/B4SCsjmlyfJmPFXKLowqUCO90oZUsYj1Otnwc6pnaNRDZhCETbrde/MscjSJ/SfaWjZCEhUi11XIKQK5J/JUawHc0//
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(346002)(39860400002)(136003)(366004)(396003)(376002)(8936002)(9786002)(36756003)(4326008)(9746002)(66946007)(26005)(107886003)(186003)(66476007)(316002)(66556008)(86362001)(426003)(6862004)(8676002)(2616005)(33656002)(4744005)(1076003)(2906002)(5660300002)(478600001)(83380400001)(27376004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: 3UffiO0PI1/QoL6R7H/2CAOlEr1WULmycK/woplfox66qqaf6EXiKRTB3MX+wQonhob+hPWwRABl41LkTPZNhy9eZbY/Esr9iqEUjLHI+BrW3xqumKhSGJPLmSad9icA1cvWQ43OhCHBjPkjcblagM5heWiVTi8OuvSMn2ZjB+/Lokfr3gbZKYZhWReFQXOpznEjRpEkmxbraKPF9HRVQRkJdcvdNNiaZG7C+om7lpvWZcluMtfGoV3yNPxs5zThD7EZeUtXhN+bHIE6BylWuMlf9VmmkEaONIksoI+FWkX9u8EgzLByIVSV2gHo2RSr5GL+136tioQl9vMXqnwtLWWjJaICnnklmZlAsp+Y73v22H3Yr1nAp8sEtyyexazUrW2h7U7cZQ2g2ve3K28FVGx/o9/UWFJAImw+kURUx4uWupJtbQHQOPBHQonDcABTKKtjQqDETYgHDxTtydrEZBJpiwYJRH0oZuieNcp3+WA=
X-MS-Exchange-CrossTenant-Network-Message-Id: ac73cbfe-6659-41aa-767c-08d833ba2d56
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jul 2020 12:23:19.4297
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DBIhDDa8g38vzBLIb3FXNotfT2g9mVqVrgHHjog2RR/uaawHJX2PZtt/vV5mPMk5
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3594
X-OriginatorOrg: Nvidia.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1596025309; bh=b+/GQw8aFp3+00vn2OZI+7QzYTsohOlMGHWHjOcKeLk=;
        h=X-PGP-Universal:ARC-Seal:ARC-Message-Signature:
         ARC-Authentication-Results:Authentication-Results:Date:From:To:CC:
         Subject:Message-ID:References:Content-Type:Content-Disposition:
         In-Reply-To:X-ClientProxiedBy:MIME-Version:
         X-MS-Exchange-MessageSentRepresentingType:X-Originating-IP:
         X-MS-PublicTrafficType:X-MS-Office365-Filtering-Correlation-Id:
         X-MS-TrafficTypeDiagnostic:X-LD-Processed:
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
        b=F8pCqFF8ttPUEHC30+QABYP9banxTUQeJ/2MnEHxkWNfuMM0fLjMMsmC8h+xFfKew
         rpbWvnAvInaa3+rY2pIzOW3W2fx5RcD1I66fj19wM0OVGrnv6SlZDki1ckVrCpJF8j
         Rq/NvPKqsU+OtgnWpUB6RzNCIuoHSRUiGxF2PJX6L4w+bGvMA4gAHqmJEyq0JIe+FT
         6dXUgIvCHUYgfN9ffyTd/ZXcuo4Fqwx9tlurd6PK83HkNj/36X6FJbRQavEsl1JfS5
         Xfer//7vnH/hi36azCncwnekiDl0rPnvBqMGJHPeClLuF1LLZ73w3EAK3VBoaPPF4a
         T/TWicAQw2inA==
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Jul 22, 2020 at 04:56:27PM +0300, Max Gurtovoy wrote:
> From: Yamin Friedman <yaminf@mellanox.com>
> 
> Has the driver use shared CQs provided by the rdma core driver.
> Because this provides similar functionality to iser_comp it has been
> removed. Now there is no reason to allocate very large CQs when the driver
> is loaded while gaining the advantage of shared CQs.
> 
> Signed-off-by: Yamin Friedman <yaminf@mellanox.com>
> Acked-by: Max Gurtovoy <maxg@mellanox.com>
> Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
> ---
>  drivers/infiniband/ulp/iser/iscsi_iser.h |  23 ++-----
>  drivers/infiniband/ulp/iser/iser_verbs.c | 112 +++++++------------------------
>  2 files changed, 29 insertions(+), 106 deletions(-)

No cover letter?

Applied to for-next with Bart's typo fixes

Jason
