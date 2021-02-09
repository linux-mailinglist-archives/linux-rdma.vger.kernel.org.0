Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B27B3144EA
	for <lists+linux-rdma@lfdr.de>; Tue,  9 Feb 2021 01:29:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229621AbhBIA3L (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 8 Feb 2021 19:29:11 -0500
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:1761 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229541AbhBIA3K (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 8 Feb 2021 19:29:10 -0500
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B6021d72d0000>; Mon, 08 Feb 2021 16:28:29 -0800
Received: from HKMAIL103.nvidia.com (10.18.16.12) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 9 Feb
 2021 00:28:28 +0000
Received: from HKMAIL102.nvidia.com (10.18.16.11) by HKMAIL103.nvidia.com
 (10.18.16.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 9 Feb
 2021 00:28:22 +0000
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.172)
 by HKMAIL102.nvidia.com (10.18.16.11) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Tue, 9 Feb 2021 00:28:22 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LLMUIdhCFoGqswA2tTwHCOnzkE7unFXwzxF4O3WMiYXlV9whjm//wRISDaTUUaz/rVRR+zoKHrxYOY+Sn2RuFlGNA3zIU5nBoVDLKmRhyL6yZ8pWvd+fe5P9NUTT502JWXQZZl4XfPvcRFc3YdeDlKmbQDrVVlVk8NXeiCk7Nfrgq1g7g3KiMsaKpqNoColjq8N3u1m8ur4Xw30zwK4eFxAEgVgrje8+K/4mWSxPeHZtbMycH3KlHDSBqB09utxmtaPObiOYvh81zRhjPmcKT4aaDba+KB4mrYT8H5GRNc5ExZ0lgvoezQ+al8gQJeJWLG9ZLo/jAzzaqZO2MY5igA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xn7OkceUrQ3oM8JrvBm65X+gy+v2bIulKi9YTWkskVI=;
 b=GXF08Dl5bFuIqu/8m078ROozG/97P0cHcQ6oo7VWEsC3+nnZ9G5tSPAnO696Gnvcp5pXmP9rT3vZW/Bea+5WH/5kecHJMYhyJm6Z9QwMBOTUgaLuoOcM+ji4JYrroQyZ7LnX1wzWIKD3Yvmt4EutQMBHmvDdpXJg6Z2r/UkO80bLZXlvHXr9Datnf3ymGsLZab2l6B5AJ/jP5EGDRYgX0zaaeo68hFkMeuYq24ngyxY2nniHdPIlh6ikiFVumnmBwIGBY+3oveEZ33A9i1mr1lUbyQD9BrJH/KO4uWBLskUo3U6fbNzEbP9QsSq6QKblqhCZpIE7Ymd+7C7UgcZ0jA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB4499.namprd12.prod.outlook.com (2603:10b6:5:2ab::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3805.22; Tue, 9 Feb
 2021 00:28:21 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::d6b:736:fa28:5e4]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::d6b:736:fa28:5e4%7]) with mapi id 15.20.3825.030; Tue, 9 Feb 2021
 00:28:21 +0000
Date:   Mon, 8 Feb 2021 20:28:19 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Weihang Li <liweihang@huawei.com>
CC:     <dledford@redhat.com>, <leon@kernel.org>,
        <linux-rdma@vger.kernel.org>, <linuxarm@openeuler.org>
Subject: Re: [PATCH for-next 00/12] RDMA/hns: Updates for 5.12
Message-ID: <20210209002819.GA1237846@nvidia.com>
References: <1612517974-31867-1-git-send-email-liweihang@huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <1612517974-31867-1-git-send-email-liweihang@huawei.com>
X-ClientProxiedBy: BL1PR13CA0275.namprd13.prod.outlook.com
 (2603:10b6:208:2bc::10) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (142.162.115.133) by BL1PR13CA0275.namprd13.prod.outlook.com (2603:10b6:208:2bc::10) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3846.11 via Frontend Transport; Tue, 9 Feb 2021 00:28:20 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1l9Gt9-005C2Y-8X; Mon, 08 Feb 2021 20:28:19 -0400
X-Header: ProcessedBy-CMR-outbound
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1612830509; bh=Xn7OkceUrQ3oM8JrvBm65X+gy+v2bIulKi9YTWkskVI=;
        h=ARC-Seal:ARC-Message-Signature:ARC-Authentication-Results:Date:
         From:To:CC:Subject:Message-ID:References:Content-Type:
         Content-Disposition:In-Reply-To:X-ClientProxiedBy:MIME-Version:
         X-MS-Exchange-MessageSentRepresentingType:X-Header;
        b=f2FeB4QaJBI0CYQBOhs4tw0kshCEJUUAVyD1VWhPBeum/9kU7FNyVmCqyqg5Dfl5B
         Gp9PkxM3aLXyWl7wuUahzGZnwIk/MSiH6R1XR8eVs7g2At5Vl2zxXIlPIKfD24w2jT
         Zy/I5NvLQpWqZbHqQaqixSnzgF7TrkM5Gx95GSjViVysUl2g36VmWujqS6IdiJCCKF
         OaueXnhEwNDM8ab2C6+h0wizVEse5B/jlWRAmq7iWugqYimr2Oa0vFLKspnrkH/8H7
         1Zso5yMR+6h8HWw1RKS+Fm8Esmu+HXoA1aPofGKxJu7zUvszZVWO0p0gqXx1HVXJR0
         MkXAgfuFQRK3w==
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Feb 05, 2021 at 05:39:22PM +0800, Weihang Li wrote:
> As usual, this series collects some miscellaneous fixes and cleanups at the
> end of 5.12 for the hns driver:
> * #1 ~ #3 fix some non-urgent issues.
> * #4 ~ #6 make some changes on existing features.
> * #7 ~ #12 are cleanups, just do some refactor and delete dead code.
> 
> This series is made based on the series named  "RDMA/hns: Several fixes and
> cleanups of RQ/SRQ" which is still being reviewed: 
> https://patchwork.kernel.org/project/linux-rdma/cover/1611997090-48820-1-git-send-email-liweihang@huawei.com/
> 
> I'm worried that it will be too late for 5.12 if any patch of this series
> needs changes, so I send it before the previous one is merged. If there is
> any comment or merge conflict on it, I will fix them as soon as possible,
> thanks.
> 
> Lang Cheng (3):
>   RDMA/hns: Replace wmb&__raw_writeq with writeq

This one is quite a good idea

>   RDMA/hns: Move HIP06 related definitions into hns_roce_hw_v1.h
>   RDMA/hns: Avoid unnecessary memset on WQEs in post_send
> 
> Lijun Ou (1):
>   RDMA/hns: Disable RQ inline by default
> 
> Weihang Li (2):
>   RDMA/hns: Avoid filling sgid index when modifying QP to RTR
>   RDMA/hns: Fix type of sq_signal_bits
> 
> Xi Wang (1):
>   RDMA/hns: Add mapped page count checking for MTR
> 
> Xinhao Liu (2):
>   RDMA/hns: Remove some magic numbers
>   RDMA/hns: Delete redundant judgment when preparing descriptors
> 
> Yixian Liu (1):
>   RDMA/hns: Remove unnecessary wrap around for EQ's consumer index
> 
> Yixing Liu (2):
>   RDMA/hns: Skip qp_flow_control_init() for HIP09


>   RDMA/hns: Adjust definition of FRMR fields

I didn't apply this one because of my question, but did take the
rest to for-next, thanks

Jason
