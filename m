Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE3042C57C0
	for <lists+linux-rdma@lfdr.de>; Thu, 26 Nov 2020 16:04:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391293AbgKZPCH (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 26 Nov 2020 10:02:07 -0500
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:14942 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391290AbgKZPCH (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 26 Nov 2020 10:02:07 -0500
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5fbfc3710003>; Thu, 26 Nov 2020 07:02:09 -0800
Received: from HQMAIL111.nvidia.com (172.20.187.18) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 26 Nov
 2020 15:02:05 +0000
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.170)
 by HQMAIL111.nvidia.com (172.20.187.18) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Thu, 26 Nov 2020 15:02:05 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TNMKQoRrxWOXVs0ptonofC/IEb6i/Cov4PMNhnlbgGjDYONAgbesQmz3+yWrpODBddNFmtuCCkduHigwzvHXMhMOpsG57PHNCdfqT6H3ZOnlU2ryemfwFEcBYxoStjEeD4xYv4JJdSfqihX5moLKQ2UsB5t5pyprkVvoFY0C5qSwnSzDVzifqPnQ0C3gnzyBw/xegSwa0xrz71US0iWZD3brHezn1hQjjobX3Tf7PN0WbXEsWLo33JedV7Tgsj8ESTUUn8N3UQT//23Aj8ZMe7phdzOrTi5q9JUNEdHhd2KDg+uhvBVH4rJe7yUEp63Z6JCuupzNsBtuDCkogAs8mQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YM2gR7HHtPUSkoVR3Je+6LpBkJdEBk8X34rnK9u7xo8=;
 b=Hi1jG8xtX5/pCUYViEEsWKq3Ubb7YxjgB4Yq4mnFrSkPDZrOV5iBbnqLCXzjoRzb8bs8l+kFa7b6PrXgIjNSpRAN0ObJzZc2TPrgY9pfXHMR4kHOre+nNgDvFuA2yEFft0vAge9uuZeoACP3v9UAqea8H5fjAq76qdtbQ91fCkfYvA14ut9tyBrtpzT1VXekbzLyxOxI0Uf5cFpQvUSXBnX3mbVM6g2F/bhOkt3IwwrLCvA018BivZyk0UH81D5oS8OPUcoG6T91jaMNBH7WXYVd9F2ha4dZlC2Z8e+//hgrOECVmTDeCVQBZo+OmkS5S3paSEO6UulOzZJlqyuDAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB3019.namprd12.prod.outlook.com (2603:10b6:5:3d::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3589.22; Thu, 26 Nov
 2020 15:02:05 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1ce9:3434:90fe:3433]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1ce9:3434:90fe:3433%3]) with mapi id 15.20.3611.024; Thu, 26 Nov 2020
 15:02:04 +0000
Date:   Thu, 26 Nov 2020 11:02:03 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Weihang Li <liweihang@huawei.com>
CC:     <dledford@redhat.com>, <leon@kernel.org>,
        <linux-rdma@vger.kernel.org>, <linuxarm@huawei.com>
Subject: Re: [PATCH for-rc] RDMA/hns: Fix retry_cnt and rnr_cnt when querying
 QP
Message-ID: <20201126150203.GB520564@nvidia.com>
References: <1606382977-21431-1-git-send-email-liweihang@huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <1606382977-21431-1-git-send-email-liweihang@huawei.com>
X-ClientProxiedBy: MN2PR19CA0023.namprd19.prod.outlook.com
 (2603:10b6:208:178::36) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (156.34.48.30) by MN2PR19CA0023.namprd19.prod.outlook.com (2603:10b6:208:178::36) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3611.22 via Frontend Transport; Thu, 26 Nov 2020 15:02:04 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1kiImZ-002BTa-Ek; Thu, 26 Nov 2020 11:02:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1606402929; bh=YM2gR7HHtPUSkoVR3Je+6LpBkJdEBk8X34rnK9u7xo8=;
        h=ARC-Seal:ARC-Message-Signature:ARC-Authentication-Results:Date:
         From:To:CC:Subject:Message-ID:References:Content-Type:
         Content-Disposition:In-Reply-To:X-ClientProxiedBy:MIME-Version:
         X-MS-Exchange-MessageSentRepresentingType;
        b=H5jNcwAsXJA29qa+hGrV5hB8YIXUGLGpgzEIOUf+fwy3dFUa0EHH4CH1fAbsuxMI5
         4njhBnI+r2PY8zX987ZUYMXhueZxo+KxUEcSQeWgOyB3qpj0GZH+8kQn14GPeo0ej0
         Q1Lmk9oFWd2magPwY+vK7p95w5iIFRamQrVv1pIp1ftKtv+4bVwnaLsDQyrx8RPmso
         eNki3whD7/r0JWLIwuUQ5qib9MLWSVV3weL+DhWU8TzIGWYwus/ibvpUC6Q3Wo8oIK
         LphDn3RoM+kbpbriU6c8htAc5W5yli4RzqfvrrHYQNRCy5RtbHVgNb5JqH/pK1+otS
         QN6U8+99sRLSA==
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Nov 26, 2020 at 05:29:37PM +0800, Weihang Li wrote:
> From: Wenpeng Liang <liangwenpeng@huawei.com>
> 
> The maximum number of retransmission should be returned when querying QP,
> not the value of retransmission counter.
> 
> Fixes: 99fcf82521d9 ("RDMA/hns: Fix the wrong value of rnr_retry when querying qp")
> Fixes: 926a01dc000d ("RDMA/hns: Add QP operations support for hip08 SoC")
> Signed-off-by: Wenpeng Liang <liangwenpeng@huawei.com>
> Signed-off-by: Weihang Li <liweihang@huawei.com>
> ---
>  drivers/infiniband/hw/hns/hns_roce_hw_v2.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)

Applied to for-rc, thanks

Jason
