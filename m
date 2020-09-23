Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6934E276006
	for <lists+linux-rdma@lfdr.de>; Wed, 23 Sep 2020 20:36:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726798AbgIWSg3 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 23 Sep 2020 14:36:29 -0400
Received: from nat-hk.nvidia.com ([203.18.50.4]:53087 "EHLO nat-hk.nvidia.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726785AbgIWSg1 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 23 Sep 2020 14:36:27 -0400
Received: from HKMAIL101.nvidia.com (Not Verified[10.18.92.100]) by nat-hk.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5f6b95a70001>; Thu, 24 Sep 2020 02:36:23 +0800
Received: from HKMAIL104.nvidia.com (10.18.16.13) by HKMAIL101.nvidia.com
 (10.18.16.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 23 Sep
 2020 18:36:01 +0000
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.175)
 by HKMAIL104.nvidia.com (10.18.16.13) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Wed, 23 Sep 2020 18:36:00 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Vxmok12+d7BDuqlT9e8kJRMP5jHLzgHpy2PsJmhkvpHy71poXVfuLxej1qrS1T4XjC27ge06Xlll/kfTlnbzkoF8U44a6unFpsQFt0UGbX6a7ny2npwAZ1rO4BCCJVCN+Hl3ct+hSP7eIiERfRqtu1wX23dN7HU/D4RVQtXt5w348w7jg+dyMj7XEo9ZtJiFkiXZtip13x1+r/YKYZ+Wlnw1mUJzDWsTadzq32APVae1d3eQbMUL2BHXBbN24CpaZLmSazsTDuGJp7eMrltioyIfpiLePCY7RSArcw/0RBNGnJveHyzehseYz5lKa3pWPnPrAfVCvlMshk6v1TzrTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IlLFLMyaR5hzltad7Ub5bs3zTgbd1rIbKvFg6PnZFXc=;
 b=m+4FS1nZ5BV0POiPpVvazpzWtS/bDPer/XHgAAErZTsgu5GICmV1F8nVnSIFTYL0XZ4r7jdeEIdEeZxYZEr7t96j+S/RmfVuos9EmHqFQr+fE8VvnT/2q/29UkUOHjTJegvUmHdBSVIkzIthZWisRbpmAvGWTEBWKl84IUowkxdA44wURe2dzmU6nhSInxtVjfOziUSP8mz8yOHZ9EvkjkmI9BvIQQ2DnWXhdV60y4hkCJ/6UEkD/Mjn0H8l9GkWLNS9DyiwTq9zH7GR0wuIdKYs/7It5upIU+j7iPNum4x19VSfNs8HJNUpQfyuS2nN0032sWnki+VAdAODhk+zbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Authentication-Results: infradead.org; dkim=none (message not signed)
 header.d=none;infradead.org; dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM5PR1201MB0201.namprd12.prod.outlook.com (2603:10b6:4:5b::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3391.14; Wed, 23 Sep
 2020 18:35:57 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::cdbe:f274:ad65:9a78]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::cdbe:f274:ad65:9a78%7]) with mapi id 15.20.3412.020; Wed, 23 Sep 2020
 18:35:57 +0000
Date:   Wed, 23 Sep 2020 15:35:56 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Christoph Hellwig <hch@infradead.org>
CC:     Bernard Metzler <BMT@zurich.ibm.com>,
        Leon Romanovsky <leon@kernel.org>,
        Doug Ledford <dledford@redhat.com>,
        Adit Ranadive <aditr@vmware.com>,
        "Ariel Elior" <aelior@marvell.com>,
        Christian Benvenuti <benve@cisco.com>,
        "Dennis Dalessandro" <dennis.dalessandro@intel.com>,
        Devesh Sharma <devesh.sharma@broadcom.com>,
        Faisal Latif <faisal.latif@intel.com>,
        "Gal Pressman" <galpress@amazon.com>,
        Lijun Ou <oulijun@huawei.com>, <linux-rdma@vger.kernel.org>,
        Michal Kalderon <mkalderon@marvell.com>,
        "Mike Marciniszyn" <mike.marciniszyn@intel.com>,
        Naresh Kumar PBS <nareshkumar.pbs@broadcom.com>,
        Nelson Escobar <neescoba@cisco.com>,
        "Parav Pandit" <parav@nvidia.com>,
        Parvi Kaustubhi <pkaustub@cisco.com>,
        "Potnuri Bharat Teja" <bharat@chelsio.com>,
        Selvin Xavier <selvin.xavier@broadcom.com>,
        Shiraz Saleem <shiraz.saleem@intel.com>,
        Somnath Kotur <somnath.kotur@broadcom.com>,
        Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>,
        VMware PV-Drivers <pv-drivers@vmware.com>,
        Weihang Li <liweihang@huawei.com>,
        "Wei Hu(Xavier)" <huwei87@hisilicon.com>,
        Yishai Hadas <yishaih@nvidia.com>,
        Zhu Yanjun <yanjunz@nvidia.com>
Subject: Re: [PATCH rdma-next] RDMA: Explicitly pass in the dma_device to
 ib_register_device
Message-ID: <20200923183556.GB9475@nvidia.com>
References: <20200922101429.GF1223944@unreal>
 <20200922082745.2149973-1-leon@kernel.org>
 <OFA7334E75.E0306A27-ON002585EB.003059A0-002585EB.0031440E@notes.na.collabserv.com>
 <OFE5279622.4F47648E-ON002585EB.004EEBC0-002585EB.004EEBDA@notes.na.collabserv.com>
 <20200922162206.GD3699@nvidia.com> <20200923053955.GB4809@infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20200923053955.GB4809@infradead.org>
X-Originating-IP: [156.34.48.30]
X-ClientProxiedBy: MN2PR19CA0063.namprd19.prod.outlook.com
 (2603:10b6:208:19b::40) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (156.34.48.30) by MN2PR19CA0063.namprd19.prod.outlook.com (2603:10b6:208:19b::40) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.20 via Frontend Transport; Wed, 23 Sep 2020 18:35:57 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1kL9cS-0007YS-0n; Wed, 23 Sep 2020 15:35:56 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 929daa92-335f-43da-4e71-08d85fef8301
X-MS-TrafficTypeDiagnostic: DM5PR1201MB0201:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR1201MB0201D2A2D623D7C19C0CAD1EC2380@DM5PR1201MB0201.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2803;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NxlcmUOm0GO0Hu0lRLRoK9p1fEdRMEAPo89734xNgb+bJVpILAfwhqWGdQUB35TYlNx4ZLXaOQVUUB+5FGR/0GhbiWXG21mRCPWl8MT8G+EJ94Zi4ejw0iBDrm8FJmCg8vaB4hJMF4mWTnWR5m/+rYJXW25JSGQcNqt5zrGBzX4X1KTI5mafRjbz7B8i7Rd7JW/7ydUtwUcpgqKSXlYicoovNW7dmcMyN2rQtbrasfq/Op3qkw1/KdoLnPOVDsBnba3etxTq9e0RB20JpLtpGII/KvRBDmuHORkgscgQ+7Y+fdpuVnCzsYHguO4r4XSElmKgEAD2DePzWOdF0D9Jzg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(346002)(396003)(366004)(136003)(376002)(7416002)(8936002)(8676002)(26005)(6916009)(186003)(1076003)(86362001)(316002)(2616005)(36756003)(54906003)(9786002)(4744005)(66476007)(478600001)(4326008)(66556008)(107886003)(2906002)(33656002)(5660300002)(426003)(9746002)(66946007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: 7vugF0r7mhp1BNwLEBSGumwuvpanRFZ98Qmx8sv6swG1jtKvI0jvH4tG65SAxol1kI+BYVfOhovMYPZJNGm73bIWEVh+2wcJZFilZ07/fpemEVbR9QQbhX55Z+gRPKH8pEBVIY8/3pHvDvljEttFuc/ApQpFrbNJ2aksZSo4R47dAJkm3zfyHZt2CAxN0Bu0FOIBeX060m9hnXRFIvHxy4twmzw2gI/X2lgytmJUao4N7+f1gL+VkA3zex1HMUQO/e+gUIdUb8ZOdwNc9tOj3p10mLuiW/bRxart7ITW0ULVxGgVGAqW7rS4arJwJFsoN43ahl0SQYSmppvhg9vyfoI0UcMUgliovZMkMscFYlFCG83d1ZjgQKoUAtDPqy/+4XJ6+Y53S36j6lmbznKlVCvCYGqaSQO5PS4nJGbmUc9RXD69AYbvf4GmH15xtDA4kLwiRHr7CkSHMcJKXA1hdD8KJpZb6DLgXgyUgupizFCne+uQU0HU9Ol77crrjQO4FilxELxca8GL89b60YlcEucoQm20iEXiM5T7VwZtOGO0WhLsL5bOed5DsyXTFm7x0020HienXODARAnw7ikHWq/GZ5EzDzzVNJn9xcKPWKM1PLs2dGDqnOKyqIvpuOXxdIxaUfojcYjcDpPayuObqA==
X-MS-Exchange-CrossTenant-Network-Message-Id: 929daa92-335f-43da-4e71-08d85fef8301
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2020 18:35:57.5656
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Np2s+r3YkFbMvz7AfBe4ZMtUf3ajiXjJIFcCUS5/mXHfRTTvA3uGz2kFlyWyrU9R
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB0201
X-OriginatorOrg: Nvidia.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1600886183; bh=IlLFLMyaR5hzltad7Ub5bs3zTgbd1rIbKvFg6PnZFXc=;
        h=ARC-Seal:ARC-Message-Signature:ARC-Authentication-Results:
         Authentication-Results:Date:From:To:CC:Subject:Message-ID:
         References:Content-Type:Content-Disposition:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:MIME-Version:
         X-MS-Exchange-MessageSentRepresentingType:X-MS-PublicTrafficType:
         X-MS-Office365-Filtering-Correlation-Id:X-MS-TrafficTypeDiagnostic:
         X-MS-Exchange-Transport-Forked:X-Microsoft-Antispam-PRVS:
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
        b=Jr9YryQsr3eoCvrUm0SqrI33B17aj7geahXGZHOtoOKIZriZKvbCIhz1wqzkQGV72
         nVW6oyNiq04+itXTQVUt0gdu+Hh+l68V52HKQzNiPa0GBLJsjsVGAAD/A7GmjI3GnA
         VEyupxkkyl1RybkBFIS5DsU5oYuqvqWvhBRvBtrv1HfP8ES+r+DP+0Clp7fTIEXrKN
         NibSpxo4NWbCsBTRGzLKIfJg+ERX316NnCdNkIEMJGxohaqqWMXItaBpBB1BoP+6aH
         h+6VhI59y1r/gWWRTPa6dzm6PUVKqQfLOby6X6Z1UPTog4BvT9YFmeG7QiK7HBoaS7
         U+6UgDHVNqmbA==
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Sep 23, 2020 at 06:39:55AM +0100, Christoph Hellwig wrote:
> > I wonder if dma_virt_ops ignores the masking.. Still seems best to set
> > it consistently when using dma_virt_ops.
> 
> dma_virt_ops doesn't look at the mask.  But in retrospective
> dma_virt_ops has been a really bad idea.  I'd much rather move the
> handling of non-physical devices back into the RDMA core in the long
> run.

Doesn't that mean we need to put all the ugly IB DMA ops wrappers back
though?

Why was dma_virt_ops such a bad idea?

Jason
