Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A092D3144B4
	for <lists+linux-rdma@lfdr.de>; Tue,  9 Feb 2021 01:14:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229621AbhBIAO2 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 8 Feb 2021 19:14:28 -0500
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:19267 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229959AbhBIAOZ (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 8 Feb 2021 19:14:25 -0500
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B6021d3b60000>; Mon, 08 Feb 2021 16:13:42 -0800
Received: from HQMAIL101.nvidia.com (172.20.187.10) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 9 Feb
 2021 00:13:39 +0000
Received: from NAM04-BN3-obe.outbound.protection.outlook.com (104.47.46.56) by
 HQMAIL101.nvidia.com (172.20.187.10) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Tue, 9 Feb 2021 00:13:40 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LytQjesy8Wj0HRSpG78I8dkhRvPkNvhL25f95Hs3W3edNaZJziEUaXDHgJE7OYQF7+5lYlTmm2tpq3s8DlISpB+QBuxZbXh0EC95+NH+R7fIwiIXNe0GCPZseM6jHKsyWBWktqlXiPlZQMJ5z1qBEB2mT0kdsmM5m5ez83lYLT1uaZgz1gcvKlKpc3ozlCgArLdZJ7gFWRZsVgXjaYISfzIpf6gPPqF7sxytAOQceQRM47kRxXHxGSlliwDiO7hkL8HkM8ofoOT8YX2w0r+4OZ0IeVQwMKP1fR44xToY0DQ8tPDOw7SBN2xOO6koB6ryz1+CreDygzU7aF886wskUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q6GvOVXdYHpzgZGjgrskMVtJuujTct3KJdG5TtPXYSs=;
 b=ntM3mOg6pQtWolH1u7hUXiH1PxnGxQFCy8sAlYuaNGwlFXBHpPIuWT3i6JuKybq+CQzbT2A3EFjmUTccgBOsqbCKJlRluWZsFTJ+1BB7En97BhFHMPSVErZXMgXO3IDaPQVAdhy2YnUNQvq5ZlRWoFD8lLni/WNWkMhkn1H56feyd6G5l3lHWn38CKYXaNxBnh6UfAx29yYCT6ypip7YQ66tlFPb6KqaXpdagX7ZzpqS3hRhOyrab2UGb79BnJ1rSo3C6rbvSR4XRRBwWPW3QYAhTCxF34mHMvAwYAr+pjd/UTkfZfzL8PJMRLg5ieKL4jYByPBItARMy8Y8ykYuRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB3020.namprd12.prod.outlook.com (2603:10b6:5:11f::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3825.23; Tue, 9 Feb
 2021 00:13:38 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::d6b:736:fa28:5e4]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::d6b:736:fa28:5e4%7]) with mapi id 15.20.3825.030; Tue, 9 Feb 2021
 00:13:38 +0000
Date:   Mon, 8 Feb 2021 20:13:36 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Weihang Li <liweihang@huawei.com>
CC:     <dledford@redhat.com>, <leon@kernel.org>,
        <linux-rdma@vger.kernel.org>, <linuxarm@openeuler.org>
Subject: Re: [PATCH v2 for-next] RDMA/hns: Add support of direct wqe
Message-ID: <20210209001336.GA1232306@nvidia.com>
References: <1611997513-27107-1-git-send-email-liweihang@huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <1611997513-27107-1-git-send-email-liweihang@huawei.com>
X-ClientProxiedBy: BL1PR13CA0006.namprd13.prod.outlook.com
 (2603:10b6:208:256::11) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (142.162.115.133) by BL1PR13CA0006.namprd13.prod.outlook.com (2603:10b6:208:256::11) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3846.11 via Frontend Transport; Tue, 9 Feb 2021 00:13:37 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1l9Geu-005AaT-Ir; Mon, 08 Feb 2021 20:13:36 -0400
X-Header: ProcessedBy-CMR-outbound
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1612829622; bh=q6GvOVXdYHpzgZGjgrskMVtJuujTct3KJdG5TtPXYSs=;
        h=ARC-Seal:ARC-Message-Signature:ARC-Authentication-Results:Date:
         From:To:CC:Subject:Message-ID:References:Content-Type:
         Content-Disposition:In-Reply-To:X-ClientProxiedBy:MIME-Version:
         X-MS-Exchange-MessageSentRepresentingType:X-Header;
        b=N5aOO3Yzeo8trTDM+NhWuN96QDMVWmdYiofftEGu8NDVyHvaf7JQlqx9KafKeTO6F
         VhiGYy3bBlWSL8sTCDf0xnKQT20E52mLEmfGJ8OY5wH77+pTOWvBmwEQ+MuH6dvF+F
         WfM6b7YHQns3fviHCrVlIWl4IrMwYCDiVP3mBa9evEebIQZGoXvMW62rJANv+QSrb4
         zYhsgEiEdf1cMEJYlJlp16OYWdAmECFlNbe3tkZDyJGXUFUYklqK9QCOC/UJQrx37q
         9cItLXHpYdUIn4sGFFtn87Jfj0jnj1BnoA1GW75JVU5EVD+XIE6WE+fcYK3HbcJp3m
         HtyQNUtFDQmIg==
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sat, Jan 30, 2021 at 05:05:13PM +0800, Weihang Li wrote:
> From: Yixing Liu <liuyixing1@huawei.com>
> 
> Direct wqe is a mechanism to fill wqe directly into the hardware. In the
> case of light load, the wqe will be filled into pcie bar space of the
> hardware, this will reduce one memory access operation and therefore reduce
> the latency.
> 
> Signed-off-by: Yixing Liu <liuyixing1@huawei.com>
> Signed-off-by: Lang Cheng <chenglang@huawei.com>
> Signed-off-by: Weihang Li <liweihang@huawei.com>
> ---
> Changes since v1:
> * Delete an extra blank line.
> * Link: https://patchwork.kernel.org/project/linux-rdma/patch/1611395717-11081-1-git-send-email-liweihang@huawei.com/
> 
>  drivers/infiniband/hw/hns/hns_roce_device.h |  6 ++++
>  drivers/infiniband/hw/hns/hns_roce_hw_v2.c  | 44 ++++++++++++++++++++++++++++-
>  drivers/infiniband/hw/hns/hns_roce_hw_v2.h  | 13 +++++++++
>  3 files changed, 62 insertions(+), 1 deletion(-)

Applied to for-next, thanks

Jason
