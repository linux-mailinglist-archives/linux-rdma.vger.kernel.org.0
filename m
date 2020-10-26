Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C62E32999CA
	for <lists+linux-rdma@lfdr.de>; Mon, 26 Oct 2020 23:40:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394616AbgJZWkT (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 26 Oct 2020 18:40:19 -0400
Received: from nat-hk.nvidia.com ([203.18.50.4]:24980 "EHLO nat-hk.nvidia.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2394615AbgJZWkT (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 26 Oct 2020 18:40:19 -0400
Received: from HKMAIL103.nvidia.com (Not Verified[10.18.92.77]) by nat-hk.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5f9750520000>; Tue, 27 Oct 2020 06:40:18 +0800
Received: from HKMAIL102.nvidia.com (10.18.16.11) by HKMAIL103.nvidia.com
 (10.18.16.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 26 Oct
 2020 22:39:47 +0000
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.104)
 by HKMAIL102.nvidia.com (10.18.16.11) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Mon, 26 Oct 2020 22:39:47 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KGstVnNO8mf7BopJNRKM83uA/60v8DLdYlyZlwWT6unLa/QhWUAL7h+FYQIc2sKS9ps4LBxJxnGye8PPlbdAjsd9RNXYN/XGVdI9e2782OtwOYFw82JKNamWcYa07TrILveXGO1iCq+YDGdplePwBPM+Z1AaUP2p6jxoPX/QmE9zd+r64V98D9oVetqTrKr3MKDOkLHaSExhuPiDCCHf+8rXy7/55GKzWA2N/+cM6BN6qHf4KYyZiGBF/jO+7Wg1TlUqbQJ8IAQad/AQoYYvD2pF1J7srlgf1UZvL2QAJ+h4dbGGQjpadjXrEf5cyi7W0MJef8Xk5kf1rb5sWrjr9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=70G3NDwZh8ih5clp7ZgKgWNkw/bH4hLTjo/Zt74B/nQ=;
 b=m5DzGcpilxKHo2T5NpYCm1ORknYZgY6NZeWaHIdeDQnLNvMl4gOyZyroQfUbkzeo51VVBJc9//wSIqsP3+Gs8py8emg1387Cc+bn6q53VBzta6VHO14kjEq3F/oOV11DpJ6VkLk9sYff+iNT4GxDp4B0QW3RGKsUNJNqeO85b7q2QNAMlojOMeRqMvxq5hYS3803vlu0vN/pcQXh3PksRrcI/SnG4j8/104oIUWqJx5sSwONSlY/LSha5bH9yABaI8a8oil1DSdL/95nLKpGvCF8CT6W3166jne9YUj6KCuZ8Sk/eKHIa1G2le7emM2qSGZjrqD+RKXBILMxoEPprw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB3116.namprd12.prod.outlook.com (2603:10b6:5:38::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.18; Mon, 26 Oct
 2020 22:39:44 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::cdbe:f274:ad65:9a78]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::cdbe:f274:ad65:9a78%7]) with mapi id 15.20.3477.028; Mon, 26 Oct 2020
 22:39:44 +0000
Date:   Mon, 26 Oct 2020 19:39:43 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Adit Ranadive <aditr@vmware.com>, Ariel Elior <aelior@marvell.com>,
        Christian Benvenuti <benve@cisco.com>,
        Potnuri Bharat Teja <bharat@chelsio.com>,
        Bernard Metzler <bmt@zurich.ibm.com>,
        "Dennis Dalessandro" <dennis.dalessandro@intel.com>,
        Devesh Sharma <devesh.sharma@broadcom.com>,
        Doug Ledford <dledford@redhat.com>,
        "Faisal Latif" <faisal.latif@intel.com>,
        Gal Pressman <galpress@amazon.com>,
        "Wei Hu(Xavier)" <huwei87@hisilicon.com>,
        Leon Romanovsky <leon@kernel.org>,
        <linux-rdma@vger.kernel.org>, Weihang Li <liweihang@huawei.com>,
        "Mike Marciniszyn" <mike.marciniszyn@intel.com>,
        Michal Kalderon <mkalderon@marvell.com>,
        Naresh Kumar PBS <nareshkumar.pbs@broadcom.com>,
        Nelson Escobar <neescoba@cisco.com>,
        Lijun Ou <oulijun@huawei.com>,
        "Parvi Kaustubhi" <pkaustub@cisco.com>,
        VMware PV-Drivers <pv-drivers@vmware.com>,
        Bob Pearson <rpearsonhpe@gmail.com>,
        Selvin Xavier <selvin.xavier@broadcom.com>,
        Shiraz Saleem <shiraz.saleem@intel.com>,
        "Yossi Leybovich" <sleybo@amazon.com>,
        Somnath Kotur <somnath.kotur@broadcom.com>,
        Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>,
        Zhu Yanjun <yanjunz@nvidia.com>,
        Yishai Hadas <yishaih@nvidia.com>
Subject: Re: [PATCH 00/11] Reduce uverbs_cmd_mask and remove
 uverbs_ex_cmd_mask
Message-ID: <20201026223943.GA2145098@nvidia.com>
References: <0-v1-caa70ba3d1ab+1436e-ucmd_mask_jgg@nvidia.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <0-v1-caa70ba3d1ab+1436e-ucmd_mask_jgg@nvidia.com>
X-ClientProxiedBy: BL1PR13CA0018.namprd13.prod.outlook.com
 (2603:10b6:208:256::23) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (156.34.48.30) by BL1PR13CA0018.namprd13.prod.outlook.com (2603:10b6:208:256::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.10 via Frontend Transport; Mon, 26 Oct 2020 22:39:44 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1kXB9T-009045-EL; Mon, 26 Oct 2020 19:39:43 -0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1603752018; bh=70G3NDwZh8ih5clp7ZgKgWNkw/bH4hLTjo/Zt74B/nQ=;
        h=ARC-Seal:ARC-Message-Signature:ARC-Authentication-Results:Date:
         From:To:Subject:Message-ID:References:Content-Type:
         Content-Disposition:In-Reply-To:X-ClientProxiedBy:MIME-Version:
         X-MS-Exchange-MessageSentRepresentingType;
        b=haFNu6LJqkiproNAUBwAHHpkZqZfKBJqYoqzeGyUAkJAiCCXB/PJnydEoxL4kTeHy
         MijbxzZjUiRy0FoWpmWnTcdNpNNn40AT1Oo+mUMjVjLFqGi0W6kIP/rCV73LEohr6u
         alSY2utZ0bIDqndufQX5H10y1ENdvJmFoM1o+Acd0PZWMs4rGBfOq+apQpGXyvkdq0
         QiEzdHPC31wQNAdevnRXL5mZL+M0MqOV8z2LAP+TMhOiwFhCzwPoQwCmDrguG5ihce
         0VStyEGpVXbg+fDPvRwlXO+NM/ktw6YE+bkmP2vJ5ycmWYnlK7WZeNDH7klReRT5Ff
         UbGcYnLH3xbrg==
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sat, Oct 03, 2020 at 08:20:00PM -0300, Jason Gunthorpe wrote:
> These have become increasingly redundant as the uverbs core layer has got
> better at not invoking drivers in situations they are not supporting.
> 
> The remaining uses are only in rxe and rvt for kernel datapath commands
> these drivers expose to userspace.
> 
> There are many, many weird and wrong things in the drivers related to
> these masks. This closes a number of troublesome cases.
> 
> Jason Gunthorpe (11):
>   RDMA/cxgb4: Remove MW support
>   RDMA: Remove uverbs_ex_cmd_mask values that are linked to functions
>   RDMA: Remove elements in uverbs_cmd_mask that all drivers set
>   RDMA: Move more uverbs_cmd_mask settings to the core
>   RDMA: Check srq_type during create_srq
>   RDMA: Check attr_mask during modify_qp
>   RDMA: Check flags during create_cq
>   RDMA: Check create_flags during create_qp
>   RDMA/core Remove uverbs_ex_cmd_mask
>   RDMA: Remove uverbs cmds from drivers that don't use them
>   RDMA: Remove AH from uverbs_cmd_mask

Applied to for-next

Jason
