Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 205ED261B20
	for <lists+linux-rdma@lfdr.de>; Tue,  8 Sep 2020 20:56:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725997AbgIHS4V (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 8 Sep 2020 14:56:21 -0400
Received: from nat-hk.nvidia.com ([203.18.50.4]:44052 "EHLO nat-hk.nvidia.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726699AbgIHS4P (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 8 Sep 2020 14:56:15 -0400
Received: from hkpgpgate101.nvidia.com (Not Verified[10.18.92.100]) by nat-hk.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5f57d3c90000>; Wed, 09 Sep 2020 02:56:09 +0800
Received: from HKMAIL101.nvidia.com ([10.18.16.10])
  by hkpgpgate101.nvidia.com (PGP Universal service);
  Tue, 08 Sep 2020 11:56:09 -0700
X-PGP-Universal: processed;
        by hkpgpgate101.nvidia.com on Tue, 08 Sep 2020 11:56:09 -0700
Received: from HKMAIL104.nvidia.com (10.18.16.13) by HKMAIL101.nvidia.com
 (10.18.16.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 8 Sep
 2020 18:55:49 +0000
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.48) by
 HKMAIL104.nvidia.com (10.18.16.13) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Tue, 8 Sep 2020 18:55:49 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P2l4zZoiJHR7un4YmbzKw89At5oH2IQT2kceJCg0UEsqXYrS0vQyn0yZWZ43TBLkUeFLj+0yDtXQdeBHY/7CvjVxtl88MiQRpDm4YSMpeV6A1Cmb6EK90EG+TmwoPRJiS+MYcpTpRg+sTv7sI7Jo6QSfT44R/fmWL+EWxcCedFA/oN+beGjgKHZizJvQTWZAb73oKCeOLcODbGNBtW8mlb+BN3sibCzLV8dypSM67PrLPURwG53XgpdK2y/FMYGJ6pKSlvDVpy/utpWd06r8WttYA0/Gj+HtRgh8FhnTG/tVguFaWIa+277Dra/XJQgrFc5fXqSL42O7ii2Adk1C6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RSlcCM6jv4z52zy2Ukltg2UZwhlkG545ZpyW+2Ayivg=;
 b=DEpkc05crW13Ca/NHZS+VFHXfxdla+1F3kD/5azGt/w0KBaHSybq96DGw9ea6hx0BxHhkXIx7Uprjci12E5KiSiwuVXVPuoFeuSEKLv1vvQ2SFhC5XRNY6gvUcN874Fb7Jp5DPFAM2liPla7sWOw2rqhe7lMzxg8cTroxou+jGjgXjKdJ+rL3dlOggwhL+6+0KeW8w22lfl02ZfIicaAgybG5DZKbCPohiFR1DyD0gv7ckX3WuVC40dcOSZNY3jld15Z4rn8zaLzV8BSQB4+znNAW6pAwYUrLgoilq0Mo5rWSLzTPFOcPdSu8ye3FDdGv3xk1nQmJSAWBhzYOE8qFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nvidia.com;
Received: from BY5PR12MB3827.namprd12.prod.outlook.com (2603:10b6:a03:1ab::16)
 by BYAPR12MB3159.namprd12.prod.outlook.com (2603:10b6:a03:134::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3370.16; Tue, 8 Sep
 2020 18:55:47 +0000
Received: from BY5PR12MB3827.namprd12.prod.outlook.com
 ([fe80::445b:111e:a091:66f9]) by BY5PR12MB3827.namprd12.prod.outlook.com
 ([fe80::445b:111e:a091:66f9%6]) with mapi id 15.20.3348.019; Tue, 8 Sep 2020
 18:55:47 +0000
Date:   Tue, 8 Sep 2020 15:55:44 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Leon Romanovsky <leon@kernel.org>
CC:     Doug Ledford <dledford@redhat.com>,
        Leon Romanovsky <leonro@mellanox.com>,
        Adit Ranadive <aditr@vmware.com>,
        Ariel Elior <aelior@marvell.com>,
        "Bernard Metzler" <bmt@zurich.ibm.com>,
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
        "Parvi Kaustubhi" <pkaustub@cisco.com>,
        Potnuri Bharat Teja <bharat@chelsio.com>,
        Selvin Xavier <selvin.xavier@broadcom.com>,
        Shiraz Saleem <shiraz.saleem@intel.com>,
        Somnath Kotur <somnath.kotur@broadcom.com>,
        Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>,
        VMware PV-Drivers <pv-drivers@vmware.com>,
        Weihang Li <liweihang@huawei.com>,
        "Wei Hu(Xavier)" <huwei87@hisilicon.com>,
        Yishai Hadas <yishaih@nvidia.com>,
        Zhu Yanjun <yanjunz@nvidia.com>
Subject: Re: [PATCH rdma-next v2 6/9] RDMA: Allow fail of destroy CQ
Message-ID: <20200908185544.GR9166@nvidia.com>
References: <20200907120921.476363-1-leon@kernel.org>
 <20200907120921.476363-7-leon@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20200907120921.476363-7-leon@kernel.org>
X-ClientProxiedBy: MN2PR03CA0012.namprd03.prod.outlook.com
 (2603:10b6:208:23a::17) To BY5PR12MB3827.namprd12.prod.outlook.com
 (2603:10b6:a03:1ab::16)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (156.34.48.30) by MN2PR03CA0012.namprd03.prod.outlook.com (2603:10b6:208:23a::17) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3370.16 via Frontend Transport; Tue, 8 Sep 2020 18:55:46 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1kFimO-003539-O5; Tue, 08 Sep 2020 15:55:44 -0300
X-Originating-IP: [156.34.48.30]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 58357255-5c35-48bd-ed72-08d85428cb66
X-MS-TrafficTypeDiagnostic: BYAPR12MB3159:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR12MB3159C0824D55D24B77AEC168C2290@BYAPR12MB3159.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1417;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2j5w/UcrSgqzySa6oRqSlPNTw5DEdcg2d1piyJm+KNeiTyhbxWTpYoKSSKFbhaWed5r4EKL6MEaItzzqE51aoIk2fO8tRoCJZ20fJnz3j7tpt4smzO2M0NZFaoHEaLvkJghs2AkHosxGrc8vfn4Ql2VV1UIGbfC0xCmw7xWve9nybFgDz79tsIvvAnEfjZ5xqJy9Pvh7e59gcaV90cNd9/hEFjOIfg8W+rOi06vBZKSRqSJ3o6FCMs8wb08S1HFIXAeIj/4wScS47ELb/xYW25dXrtRmJ2hpR8wXUriXpW9yhF0Wgdmk1PY52Uv/PF4fV04iDPxM1dCDCq/rbYCkuA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB3827.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(136003)(39860400002)(346002)(376002)(366004)(107886003)(316002)(26005)(4326008)(7416002)(9746002)(33656002)(9786002)(2906002)(36756003)(66946007)(8676002)(5660300002)(1076003)(66556008)(66476007)(4744005)(478600001)(186003)(6916009)(2616005)(54906003)(86362001)(426003)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: IpqVVHUhA8xJT+tbTWgk2BRIrX3UacsbTlvZsf7HJRX8rbgXLWnlwJreKUeCKrb1LHTEfVe75rn/cLRI8LZ1iJfCceFR3xcPjdkr4/3azimqhL4UdFPOGgF1oGNPpejY9Z021ioAFp8vfOBjOPuoQCIGphsj3u1Mr9HkUwq4r7yxKTj2xiZI6v5IBL0Lp70bgpD9GxKqPgg2qayWTpuC8jGeHqDE59mjrmRavmCT4W4NK4tv3Jw7mR1q0A1pDWti1YRgtpDHiXuKzRXkl5GkNqsCwSM+/xhHBCmwJl1O8dqU5yK+6JddA4r1CKj0GXo7gia6we08n6EkTRyWCE1L0iilBSEG2B+NqMLXQwq3Mk/jDn9aIC0RtXU4pw+Ym8iquJmcT8WNiipZqxb5QesCKx8N1yCj+suG4RNg+Ixie9QS3XR3iNbiCAOsMSe7YfI3D4A/H3l6+4aM3KwLiAapqCRds2XqCfAVCIZNJntl+wSWPcmMJ4boielVqJfrLwXp18TbAhztxrq2gGlXkWOzKrqh2f/vPb9J+wphPlOWqaf/FqcMxfLDj+SGhsX1LPJ0lC1+MNvddGwjA5NhF50zI1QGoeqog/fqdjjvBW2eknKYd2M5YUwXaRhKUyNnUG3WLAG/mvH4inF5Ku6UsSAKYg==
X-MS-Exchange-CrossTenant-Network-Message-Id: 58357255-5c35-48bd-ed72-08d85428cb66
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB3827.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2020 18:55:46.7306
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6k76dq8/RH9Bp260q2skLT3alD8jmWNAdUvmdMyGPELMllNoVFlOZFU3XTWDArcd
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3159
X-OriginatorOrg: Nvidia.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1599591369; bh=RSlcCM6jv4z52zy2Ukltg2UZwhlkG545ZpyW+2Ayivg=;
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
        b=BTuLF0MKym8xLsdYC03vmyA0OzZStIw1hKplgd3qcKCtfca+YKgxBJZ+3dxBGx1yC
         UI/Zh71bUUFo9wtpExbDkg5GB2ZxJFczHem0jh/wxubhncJnErcwY7mS8tcAYEc69A
         OC73+mSBXJGjSLKiP5qLGrztTvxeJ0FOnrBAAc/EB7I2Mfv12Zu+VcvgOiVuSv68Hc
         t3N0DOJANLegW+/FO0lLDYf8Dp/QfrK8qDS0keuWpkq2ecuMiXkFdgBVBdEu3y9TEk
         YK0ViBrcx1ZjvIwohkvuwVu5pFU8lu8frMeMnf9kobCpka/+aOPJeNxP7y1Do6buw3
         Z3ffBihHrrC1A==
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Sep 07, 2020 at 03:09:18PM +0300, Leon Romanovsky wrote:

> -void mlx5_ib_destroy_cq(struct ib_cq *cq, struct ib_udata *udata)
> +int mlx5_ib_destroy_cq(struct ib_cq *cq, struct ib_udata *udata)
>  {
>  	struct mlx5_ib_dev *dev = to_mdev(cq->device);
>  	struct mlx5_ib_cq *mcq = to_mcq(cq);
> +	int ret;
>  
> -	mlx5_core_destroy_cq(dev->mdev, &mcq->mcq);
> -	if (udata)
> +	ret = mlx5_core_destroy_cq(dev->mdev, &mcq->mcq);
> +	if (ret && udata)
> +		return ret;

No udata check here


Jason
