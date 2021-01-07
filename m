Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 368AF2ED6B8
	for <lists+linux-rdma@lfdr.de>; Thu,  7 Jan 2021 19:31:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726319AbhAGSbE (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 7 Jan 2021 13:31:04 -0500
Received: from nat-hk.nvidia.com ([203.18.50.4]:58615 "EHLO nat-hk.nvidia.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725944AbhAGSbD (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 7 Jan 2021 13:31:03 -0500
Received: from HKMAIL102.nvidia.com (Not Verified[10.18.92.100]) by nat-hk.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5ff7533e0000>; Fri, 08 Jan 2021 02:30:22 +0800
Received: from HKMAIL101.nvidia.com (10.18.16.10) by HKMAIL102.nvidia.com
 (10.18.16.11) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 7 Jan
 2021 18:30:17 +0000
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.174)
 by HKMAIL101.nvidia.com (10.18.16.10) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Thu, 7 Jan 2021 18:30:16 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iwGL7e9r01PQZakEtqWXhKCn/eFp3vZrRpjcxdlUTNau9X+AMIgNVbFjFd4rhaJ4Jr4siXQNXzMScviyBg+f3/uokH1sSG6DJ3alw629xrbDKqPFpsP9qbHzKrSf4LmkWitzu9ILu8JgPBVO1Gzmzh3ZkRlCkKS61ufUpoilAf0Dvah5krV2pQ3kk2v0lutpxez269PGSCSXseSQlNvR1HH0/lyik98QVYB1D53q8pOwq3gj9mRRzC6/8Zhri3QX61nWkyPWx9xCfiylp4OWRfO66Pj8m/PONHhzvk/RusS3lBSuUs2hWTTwgCvUjJLChgAt596XqUPbekyxv8JqFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HAaDnhkvOe76eBCLwC/MjYh6XHCFR9qlyVv6GiV5FWc=;
 b=D+AFEdsS+TqNDElMKzdnqNCAq8p/HkCbpo+8B/kwuYn9tuaBA1o4oBjw7nVNugmRgizi5tl4GK2i8qTM5jnBD8Mi9WMIUS72si9/pi82QZ5SxhpPX9RKiTK3pB7yKZOgk7wWXOKHgrLkQ9eOPiP6yMXAP5ZpCAo0os71vHYCKQ40Rk2lDmGJCghhdlsns2mQhLj60gjFZJ5G0OW8UKbjGlWT9UC2tmEbAtcuiHnTrQTkd9NvjLoOMH+hp/mNRL5snR1WvExMqGxbHIiasNA8FbTCT0dup/S3U3kEb9qhhy2nfzAQFuqy4SVxsWrmWEJOfV2RHMDw7Z77zoy+ZzDWgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM5PR12MB1754.namprd12.prod.outlook.com (2603:10b6:3:10f::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3742.6; Thu, 7 Jan
 2021 18:30:14 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::546d:512c:72fa:4727]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::546d:512c:72fa:4727%7]) with mapi id 15.20.3742.008; Thu, 7 Jan 2021
 18:30:14 +0000
Date:   Thu, 7 Jan 2021 14:30:12 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Zheng Yongjun <zhengyongjun3@huawei.com>
CC:     <leon@kernel.org>, <linux-rdma@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <dledford@redhat.com>
Subject: Re: [PATCH v2 -next] infiniband: core: Delete useless kfree code
Message-ID: <20210107183012.GA909687@nvidia.com>
References: <20201216080219.18184-1-zhengyongjun3@huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20201216080219.18184-1-zhengyongjun3@huawei.com>
X-ClientProxiedBy: MN2PR22CA0007.namprd22.prod.outlook.com
 (2603:10b6:208:238::12) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (142.162.115.133) by MN2PR22CA0007.namprd22.prod.outlook.com (2603:10b6:208:238::12) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3742.6 via Frontend Transport; Thu, 7 Jan 2021 18:30:13 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1kxa32-003ofu-GH; Thu, 07 Jan 2021 14:30:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1610044222; bh=HAaDnhkvOe76eBCLwC/MjYh6XHCFR9qlyVv6GiV5FWc=;
        h=ARC-Seal:ARC-Message-Signature:ARC-Authentication-Results:Date:
         From:To:CC:Subject:Message-ID:References:Content-Type:
         Content-Disposition:In-Reply-To:X-ClientProxiedBy:MIME-Version:
         X-MS-Exchange-MessageSentRepresentingType;
        b=HdwDjnwgjNk6VKlSjlUCy/XPUWiGOrXmJhfe2vCoTXCb4itZ6WZT5lWj7ivmMTOY7
         IpP4BWZB9FMY6s/su1ootVMp5pG2SMxLp23G5/SGnNch0qKuFyW3lu1O/tA3Fvm56Y
         l1Vnsdiu54OXQUTOVsX9T/IBdSkexwTGVhOfVGckhJfPgiWmmNU7KpQlEFSYxfTkUE
         JJfBoTUre83fAcO2jzjSyZsL+VfxeVx1FCC4I7X3KyDndBNCbCJoIKy5wyLTq1vKe5
         O1qPEgCVplVS35hP7P27W5q91FIIMAphUaq/pRpiGqS7ICMkXhxfqGzUcSRp2UYU+7
         KdabSULmtk/GA==
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Dec 16, 2020 at 04:02:19PM +0800, Zheng Yongjun wrote:
> The parameter of kfree function is NULL, so kfree code is useless, delete it.
> Therefore, goto expression is no longer needed, so simplify it.
> 
> Signed-off-by: Zheng Yongjun <zhengyongjun3@huawei.com>
>  drivers/infiniband/core/cma_configfs.c | 9 ++-------
>  1 file changed, 2 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/infiniband/core/cma_configfs.c b/drivers/infiniband/core/cma_configfs.c
> index 7ec4af2ed87a..51f59ed6916b 100644
> +++ b/drivers/infiniband/core/cma_configfs.c
> @@ -202,7 +202,6 @@ static int make_cma_ports(struct cma_dev_group *cma_dev_group,
>  	unsigned int i;
>  	unsigned int ports_num;
>  	struct cma_dev_port_group *ports;
> -	int err;
>  
>  	ibdev = cma_get_ib_dev(cma_dev);
>  
> @@ -214,8 +213,8 @@ static int make_cma_ports(struct cma_dev_group *cma_dev_group,
>  			GFP_KERNEL);
>  
>  	if (!ports) {
> -		err = -ENOMEM;
> -		goto free;
> +		cma_dev_group->ports = NULL;

This set is also useless, the only caller allocated cma_dev_group with
kzalloc so it is already NULL here, I fixed it and applied to
for-next, thanks

Jason
