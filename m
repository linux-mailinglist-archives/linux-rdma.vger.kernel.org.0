Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 919BC261DE4
	for <lists+linux-rdma@lfdr.de>; Tue,  8 Sep 2020 21:43:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731237AbgIHTnk (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 8 Sep 2020 15:43:40 -0400
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:17948 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730855AbgIHPvu (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 8 Sep 2020 11:51:50 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5f5792770002>; Tue, 08 Sep 2020 07:17:27 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Tue, 08 Sep 2020 07:19:41 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Tue, 08 Sep 2020 07:19:41 -0700
Received: from HQMAIL109.nvidia.com (172.20.187.15) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 8 Sep
 2020 14:19:27 +0000
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.170)
 by HQMAIL109.nvidia.com (172.20.187.15) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Tue, 8 Sep 2020 14:19:27 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Cz+z8ANk4xkXjGkSMDD3i6up8YjhqTwUTjloOlJHWais/gA0BKagf6MNzZ1jWZGeV1+EfvDCQwgEpyPdtLXS5AR8Z42gnyp1LeK8sMO7c/c9hMZVqydYc6sOxc+d97xQ80XhTfceEANn8v65FScuvWHsjK87LlIIkXmPFRq7juNdA9BK7/cPvFLDGO3GMEqrar5W+j8mD732bIhvjJsaR9bfkNQNRpGcs6E6LpsduiwwUc30FOJwlzQdcPKfrhcwiCbI5w+uQXtAQd2a5LoAsU8ibqPYv2Wh04KigDI92ftVd9quBtx0DGJIXQy8HSH6zTDk/VqqcLU5qb9cIXx8NA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gNjXI1dxsAtvF5nKkBwQG+fYP6RAFfgw8X2khN2hDAY=;
 b=Ia3DxhOXfWRsNbk0V0eKcazWMYF+0pOP828prQo5MHe79fjmhWcC62OaSBqOc/paB+NWiTA7eNJUA0KJ5rzBlsMkSASgA9E+N/9ftMcoAS4eoaSRXQ7tNoY5jwYT4MzovTHv+sduS1CeGP7ad+rFKXF4+Nl/IWMiucHyYme84VO3bqKYXosnHkRDicHSdgcPlxmbFl8YqBllsFxE/WFYMS6WAn4nTr3gOg+N67uUDxm+kG1CtvGX5k53c6gmiPwYPuM3CUvUujLNCVmdfUk25f7R2LDiNEWW2NEfYuaUbm32Yd9f25V7Z314/Qb2IFLNvRMGJdGe1kureK4BxxT2Dw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nvidia.com;
Received: from BY5PR12MB3827.namprd12.prod.outlook.com (2603:10b6:a03:1ab::16)
 by BY5PR12MB4018.namprd12.prod.outlook.com (2603:10b6:a03:1a7::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3348.16; Tue, 8 Sep
 2020 14:19:26 +0000
Received: from BY5PR12MB3827.namprd12.prod.outlook.com
 ([fe80::445b:111e:a091:66f9]) by BY5PR12MB3827.namprd12.prod.outlook.com
 ([fe80::445b:111e:a091:66f9%6]) with mapi id 15.20.3348.019; Tue, 8 Sep 2020
 14:19:26 +0000
Date:   Tue, 8 Sep 2020 11:19:24 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Leon Romanovsky <leon@kernel.org>
CC:     Doug Ledford <dledford@redhat.com>,
        Aharon Landau <aharonl@mellanox.com>,
        Adit Ranadive <aditr@vmware.com>,
        Ariel Elior <aelior@marvell.com>,
        "Dennis Dalessandro" <dennis.dalessandro@intel.com>,
        Devesh Sharma <devesh.sharma@broadcom.com>,
        <linux-rdma@vger.kernel.org>,
        Michael Guralnik <michaelgur@nvidia.com>,
        Michal Kalderon <mkalderon@marvell.com>,
        "Mike Marciniszyn" <mike.marciniszyn@intel.com>,
        Naresh Kumar PBS <nareshkumar.pbs@broadcom.com>,
        Selvin Xavier <selvin.xavier@broadcom.com>,
        Somnath Kotur <somnath.kotur@broadcom.com>,
        Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>,
        VMware PV-Drivers <pv-drivers@vmware.com>
Subject: Re: [PATCH rdma-next v1 3/3] RDMA: Fix link active_speed size
Message-ID: <20200908141924.GG9166@nvidia.com>
References: <20200902074503.743310-1-leon@kernel.org>
 <20200902074503.743310-4-leon@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20200902074503.743310-4-leon@kernel.org>
X-ClientProxiedBy: BL0PR01CA0024.prod.exchangelabs.com (2603:10b6:208:71::37)
 To BY5PR12MB3827.namprd12.prod.outlook.com (2603:10b6:a03:1ab::16)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (156.34.48.30) by BL0PR01CA0024.prod.exchangelabs.com (2603:10b6:208:71::37) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3348.15 via Frontend Transport; Tue, 8 Sep 2020 14:19:26 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1kFeSy-0030SM-C0; Tue, 08 Sep 2020 11:19:24 -0300
X-Originating-IP: [156.34.48.30]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 236bf88b-ecc1-4230-aa9c-08d8540230f8
X-MS-TrafficTypeDiagnostic: BY5PR12MB4018:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BY5PR12MB40188CFB25B91791588CE131C2290@BY5PR12MB4018.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5236;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kur/wn4nRIUSsZ+4GHNU4rY4rT7VEVE4KSOrvKxXg8JX6Tn9kEgp1Xl1AUGrG1R3GoIV7Tf+/Zr1P4UQ1SrQWRAku1Rm8rrGj+MTEz45DdE53yZ5Pzd9jGBa2B+OL6ukqObOkBdtT3Vh6WWmcRG5nQS8SmgwHgPIft1Omm8sx8xdmm63mC9pH6uFU3nvD77N3HwDnyIUAnyMS1qUemb4j2gXYCKdswwZHyKpO86EjCDHZw8beqlQoGsCc8i9mNZyuDW16xQTT1paIXw6A0mrnJWi80HAesTJ+jjWd2IfuJ/1ZDOuRrXQtFCpAKFLeILe
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB3827.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(376002)(366004)(136003)(39860400002)(346002)(8936002)(9746002)(2616005)(33656002)(66946007)(36756003)(54906003)(426003)(9786002)(4326008)(186003)(66476007)(1076003)(86362001)(6916009)(26005)(478600001)(66556008)(5660300002)(2906002)(7416002)(316002)(83380400001)(8676002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: NfiGOYy2dca25bUpzPxpFcwnO5qx115OPfnuaTh95UR409Obf8roETePINcd8mcFDy3ecSYE5zy7x5GzrA5OWg4bXqanjZd+iFB3YHtxqw1Z9GHWmB38A1mDH8kGa31axIj6Vw/GAn7If8e/SP06IXob4amtvBoClWVmKtSg+a7kipcWUTTyv5+zc3U+TnJoFaOKK+p05MyBtpm9XXWwXakjNG1KsT8FD5gn45ZhfQPUH/aNMNxGzNB0ScLcaS//QlFHoADAwPAUr6Ms24XVNL4Yo4T7gcdph41DBQfhw97bOHMyPqDoGBRXFT2Fg+gWzTxEII70WG/xa9hoDLqLrffcrGzwTTnoiVQlYq+iD81C3MyTKwxAZIh3zoGbc6ilId9eB86CJYPcz6RLOlhkF3kgl34iWIpnPo+afXObI0cvwILRkzLNgyJrD9U6jr1L2heFuM/caNBe1xSqMMOpWX3LIRun33Tsh2mAJ72Kg87GTqBgUyEBLEsTj/pfUX1/vfmHacdRRWzzTzoaGLrAMa+4CsA3bt03aHabRXng+HwTmV9lC+fpJOILi7sdSlYLioWcy11Z/6GeOTuoJ8tuW7REP/taU2DZERYOe/DfLORcSP6k3bA28hVeCGDfvoMStDjq5RAI1BOo4PrQ1X7zeA==
X-MS-Exchange-CrossTenant-Network-Message-Id: 236bf88b-ecc1-4230-aa9c-08d8540230f8
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB3827.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2020 14:19:26.4104
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: y5ycbOItOnyP3nINi1pz2IFsrf+PEDn/cBqF+nfcjuxe22Iwj/Z8SvRBlKI6IeOb
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4018
X-OriginatorOrg: Nvidia.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1599574647; bh=gNjXI1dxsAtvF5nKkBwQG+fYP6RAFfgw8X2khN2hDAY=;
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
        b=QeOUlnz58klMt0LLWfPPt+y94m9L5mzxzp0J8toU8vj2oBRxMyd9GDOi3q9/9jRPR
         Vpl03PPzfNkxB8QGk/grPcbhcux9vP+hMBtIEC7u6dmDQ5Fxr1xz5FaqCH6k0RSWI/
         zbT+gGKDlesqEfJDLYW2xPiN9K7lFIO8qYX4u7u+w+3+Cf62yK3OQgOWxjPHp5Z4/e
         D08fwP9gOzmFNwxz5I8Osxb49S0/pH1twKHH0SkWHUaAuiBpgkUeRQrmk+TmNASFOd
         A7W3L7zs2VF4lxLRHTlR9J+bYrcGORAJBBXRhk6mhcKauAKt8n4z6Wd+87KdLm8qYX
         PWX0n+69RuSbA==
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Sep 02, 2020 at 10:45:03AM +0300, Leon Romanovsky wrote:
> From: Aharon Landau <aharonl@mellanox.com>
> 
> According to the IB spec active_speed size should be u16 and not u8 as
> before. Changing it to allow further extensions in offered speeds.
> 
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Signed-off-by: Aharon Landau <aharonl@mellanox.com>
> Reviewed-by: Michael Guralnik <michaelgur@nvidia.com>
> Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
>  drivers/infiniband/core/uverbs_std_types_device.c | 3 ++-
>  drivers/infiniband/core/verbs.c                   | 2 +-
>  drivers/infiniband/hw/bnxt_re/bnxt_re.h           | 2 +-
>  drivers/infiniband/hw/hfi1/verbs.c                | 2 +-
>  drivers/infiniband/hw/mlx5/main.c                 | 8 ++------
>  drivers/infiniband/hw/ocrdma/ocrdma_verbs.c       | 2 +-
>  drivers/infiniband/hw/qedr/verbs.c                | 2 +-
>  drivers/infiniband/hw/qib/qib.h                   | 6 +++---
>  drivers/infiniband/hw/vmw_pvrdma/pvrdma_verbs.h   | 2 +-
>  include/rdma/ib_verbs.h                           | 4 ++--
>  10 files changed, 15 insertions(+), 18 deletions(-)
> 
> diff --git a/drivers/infiniband/core/uverbs_std_types_device.c b/drivers/infiniband/core/uverbs_std_types_device.c
> index 75df2094a010..7b03446b6936 100644
> +++ b/drivers/infiniband/core/uverbs_std_types_device.c
> @@ -165,7 +165,8 @@ void copy_port_attr_to_resp(struct ib_port_attr *attr,
>  	resp->subnet_timeout = attr->subnet_timeout;
>  	resp->init_type_reply = attr->init_type_reply;
>  	resp->active_width = attr->active_width;
> -	resp->active_speed = attr->active_speed;
> +	WARN_ON(attr->active_speed & ~0xFF);

?? This doesn't seem like a warn on situation..

> @@ -1307,7 +1303,7 @@ static int mlx5_query_hca_port(struct ib_device *ibdev, u8 port,
>  		props->port_cap_flags2 = rep->cap_mask2;
>  
>  	err = mlx5_query_ib_port_oper(mdev, &ib_link_width_oper,
> -				      (u16 *)&props->active_speed, port);
> +				      &props->active_speed, port);

This hunk should be in the earlier patch

Jason
