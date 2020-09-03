Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D577A25B78B
	for <lists+linux-rdma@lfdr.de>; Thu,  3 Sep 2020 02:09:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726947AbgICAJT (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 2 Sep 2020 20:09:19 -0400
Received: from nat-hk.nvidia.com ([203.18.50.4]:65148 "EHLO nat-hk.nvidia.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726377AbgICAJT (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 2 Sep 2020 20:09:19 -0400
Received: from hkpgpgate101.nvidia.com (Not Verified[10.18.92.9]) by nat-hk.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5f50342b0001>; Thu, 03 Sep 2020 08:09:15 +0800
Received: from HKMAIL101.nvidia.com ([10.18.16.10])
  by hkpgpgate101.nvidia.com (PGP Universal service);
  Wed, 02 Sep 2020 17:09:15 -0700
X-PGP-Universal: processed;
        by hkpgpgate101.nvidia.com on Wed, 02 Sep 2020 17:09:15 -0700
Received: from HKMAIL104.nvidia.com (10.18.16.13) by HKMAIL101.nvidia.com
 (10.18.16.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 3 Sep
 2020 00:08:55 +0000
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.105)
 by HKMAIL104.nvidia.com (10.18.16.13) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Thu, 3 Sep 2020 00:08:55 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JdGLNv3nitWTiwOukZ0x4M3wd0FYIeRH/OV3bEWiDMcc76b1FkXVCpyTNjEgukvFiLCDtzsTk0FI5NfvxGGzGFl7kw2SpUBLR/9bPk8JSOdwVPWEfk4O0r/d76MOazrLk2DKQwUBSwD//nEYH8OGGFZg4l84VdCxY/XO4Sp5ZHyHKos2uJz4AyjxoyBknscxULOCRJw7zRAqPcblchKLILmgGqVhO7pCfktCAK1J27+abgq58fnNWNGiv6my1V4j8Q5gg6OB1KSxd39S8LkI6Xt3Be3YR3rhLKlQfcUJwCB6ITKwoBqSEfTOFzqTUo+3du884R2Xesve7e8pLBf5qg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hndUuY6FR8yAlsCuJCjNvCEqS3tWfk+M91i1O9dRoNU=;
 b=T1DN7eyecwSvEKQq2iNxVfoeOYyKrBo69ZCB7HRzwMctmIw+dKe89iD3e3s8x2zdvwYwGX3aniOTd+Hwbcje8XW/UUtDMoYUbssD7xtNBT+fJS+0uICgyaSv80OdDr5d29JC9lM3u1Z/cdbo/3DYV5sjSPqaZZSN63IwlG8TWO3JTWAEzcw1YOMvi+Tn2EYlQrzIxuPLQD8qhrWdPBHsj7Uak+46H17NwEGA96aKqi066SDDsoXsvavxKT247D9z2D7eSSfQeYzQZfCnushFi26+NS/0muZj26nJnUK8IABb8n7OTiqMcFu229Yy1a0wiTh6rJ+2JgMX2NCiyxFG9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB3835.namprd12.prod.outlook.com (2603:10b6:5:1c7::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3348.15; Thu, 3 Sep
 2020 00:08:52 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::2d79:7f96:6406:6c76]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::2d79:7f96:6406:6c76%3]) with mapi id 15.20.3326.025; Thu, 3 Sep 2020
 00:08:52 +0000
Date:   Wed, 2 Sep 2020 21:08:50 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Leon Romanovsky <leon@kernel.org>
CC:     Doug Ledford <dledford@redhat.com>,
        Leon Romanovsky <leonro@mellanox.com>,
        Adit Ranadive <aditr@vmware.com>,
        Ariel Elior <aelior@marvell.com>,
        "Bernard Metzler" <bmt@zurich.ibm.com>,
        Dennis Dalessandro <dennis.dalessandro@intel.com>,
        Devesh Sharma <devesh.sharma@broadcom.com>,
        Lijun Ou <oulijun@huawei.com>, <linux-rdma@vger.kernel.org>,
        Michal Kalderon <mkalderon@marvell.com>,
        Mike Marciniszyn <mike.marciniszyn@intel.com>,
        Naresh Kumar PBS <nareshkumar.pbs@broadcom.com>,
        Potnuri Bharat Teja <bharat@chelsio.com>,
        Selvin Xavier <selvin.xavier@broadcom.com>,
        "Somnath Kotur" <somnath.kotur@broadcom.com>,
        Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>,
        VMware PV-Drivers <pv-drivers@vmware.com>,
        Weihang Li <liweihang@huawei.com>,
        "Wei Hu(Xavier)" <huwei87@hisilicon.com>,
        Yishai Hadas <yishaih@nvidia.com>,
        Zhu Yanjun <yanjunz@nvidia.com>
Subject: Re: [PATCH rdma-next v1 05/10] RDMA: Restore ability to fail on SRQ
 destroy
Message-ID: <20200903000850.GA1479562@nvidia.com>
References: <20200830084010.102381-1-leon@kernel.org>
 <20200830084010.102381-6-leon@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20200830084010.102381-6-leon@kernel.org>
X-ClientProxiedBy: MN2PR03CA0021.namprd03.prod.outlook.com
 (2603:10b6:208:23a::26) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from 255.255.255.255 (255.255.255.255) by MN2PR03CA0021.namprd03.prod.outlook.com (2603:10b6:208:23a::26) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3348.15 via Frontend Transport; Thu, 3 Sep 2020 00:08:51 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1kDco6-006Cv3-NE; Wed, 02 Sep 2020 21:08:50 -0300
X-Originating-IP: [156.34.48.30]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c47eeb92-c2a2-4e78-606e-08d84f9d8a21
X-MS-TrafficTypeDiagnostic: DM6PR12MB3835:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB3835499B32299F271369E94BC22C0@DM6PR12MB3835.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2201;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Q21n4G26AMM3hG63SSfi62GASrWehPkiLj7MqEK4nek2sPlIbfxynjO2Yj2Dy/o51hJOS/y9pFh/mPxrTtv4yuWObEZQkUM5DjfPpjIckzCgoaKXW/rVt+XfaaJnYrhVguSOunYf+OZzvFWJQB5ygrndHAJgZ1lJgBiTReXlbPo3pLVxt9m8dmZN9voYg5nO2ibNYW2jROupLUSeExE9hie+8mc/2artFjxyY4ACVqIj1qHGfX7ZXePk7gnjK8zfm4PEIQDzictgloDNoxAxIAgv0mCKxTOCNCvnn0RfOCQ+w5D4zF5dxCn6yEbXi7igIbTtGgk5kPNKB/qnN85FFQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(366004)(136003)(346002)(39860400002)(376002)(36756003)(2616005)(66946007)(6916009)(66476007)(107886003)(426003)(4326008)(186003)(26005)(8676002)(66556008)(1076003)(54906003)(4744005)(478600001)(7416002)(8936002)(86362001)(5660300002)(9786002)(33656002)(9746002)(316002)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: 2GW9mxBPcDKXagLlPJlzHuOe5vz0viqgfra/39IDzpQrdTtOPE4UZSeEKBeY333H6AxPSPrIjOg5XBFXi/QuvcgD73MB2ei/aS0VStjjr6wypoR6NCdj5VNTDdtI8Ar3O0Qf39nFV5p+Lsc+M9kYbXc950F3g05HlAScX5wad9ghrFPxxJ5iT3mje7z+aV2dC05YosZsjoBtMvzoBmuGy7AxWoCCjMjFh+rehRVAZQYTrcNHxdOQICJB0vGkHffJ93llq55tafKUuekyJSOaFRO/uSuOVixnwvRN8jKBIfTRNxAfss9knOUwMF1jzwWMOcPp41qTBd/Mr5sfN2j8FdLjOmyIRewfn9FB9855kRQ49VO53b0hczxJCmeGdHy1zP3hh+KJZ/1lR7UmeRHuzyCVWk7a73qq8c93qe2DhgXanQpRwYBvuYKSLg20Vo8307xLVj1rWxrS5L1LRAr/zxEwFmEQENKG9080r0ygjPhMx4S9iwRL2frxqFokh8KrSGzDQWPSFTb5hSyNIrYZHEuFn1ma0atuSAckfkyatYYMPNhNr8KSKsIxy0wub7ta/I8RiOPwZ5awKe7qYDZ9yr37hgYzI+hA9sj/rDOnNJcy95Wa2KwNMK08xXeUjbGx1tiybr5eP8grnaO8IC4t5w==
X-MS-Exchange-CrossTenant-Network-Message-Id: c47eeb92-c2a2-4e78-606e-08d84f9d8a21
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2020 00:08:52.6154
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2N1NpYXEvzyQ9dD41KcmOgrR48GzhGIsKo19wdBFEysVBx0lGdxvopWzBKQr6c4g
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3835
X-OriginatorOrg: Nvidia.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1599091755; bh=hndUuY6FR8yAlsCuJCjNvCEqS3tWfk+M91i1O9dRoNU=;
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
        b=W7uflK3ydgq7e0cFiFJ3w0Am+KEljsBzmShQzoyv+VUA8UAOlzy0HuIhau+EI4IlI
         u9uovrf4QQ2tUn+VHhVOho/IQLHm/pvPnquNP7BXvnnzRvmO5UOTdvVandd/2uD00L
         w9VcO13QNv5s6bOrQeLZaRAs7jsWkYW63Kj7HPlmYHtT5sOo1OmIef+6qZBf0I/yao
         MOSpaFvOtd62+sV07zfctlHj6o3mn1WLlOVVGAlAEoynT0L1O/wsDJZcO6NwzGIYW1
         MrU1+kNgpa09AEfg3UFE10TI7vM8aGY7qjJ1bvl9XG0Emk1trOyme95MX1Kera9Qic
         GP68XnPTyIwHw==
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sun, Aug 30, 2020 at 11:40:05AM +0300, Leon Romanovsky wrote:
> -void mlx5_ib_destroy_srq(struct ib_srq *srq, struct ib_udata *udata)
> +int mlx5_ib_destroy_srq(struct ib_srq *srq, struct ib_udata *udata)
>  {
>  	struct mlx5_ib_dev *dev = to_mdev(srq->device);
>  	struct mlx5_ib_srq *msrq = to_msrq(srq);
> +	int ret;
> +
> +	ret = mlx5_cmd_destroy_srq(dev, &msrq->msrq);
> +	if (ret && udata)
> +		return ret;
>  
> -	mlx5_cmd_destroy_srq(dev, &msrq->msrq);
> -
> -	if (srq->uobject) {
> -		mlx5_ib_db_unmap_user(
> -			rdma_udata_to_drv_context(
> -				udata,
> -				struct mlx5_ib_ucontext,
> -				ibucontext),
> -			&msrq->db);
> -		ib_umem_release(msrq->umem);
> -	} else {
> -		destroy_srq_kernel(dev, msrq);
> +	if (udata) {
> +		destroy_srq_user(srq->pd, msrq, udata);
> +		return 0;
>  	}

It is not a big deal but I would like to remove udata as an argument
to the driver destroy functions, it is completely nonsensical and
never used.

Jason
