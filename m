Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 66B822AFB3C
	for <lists+linux-rdma@lfdr.de>; Wed, 11 Nov 2020 23:20:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726157AbgKKWUL (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 11 Nov 2020 17:20:11 -0500
Received: from mail-bn7nam10on2078.outbound.protection.outlook.com ([40.107.92.78]:6497
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725933AbgKKWUK (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 11 Nov 2020 17:20:10 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j0qHlHLPe92BzchzyVm04h7BAmNt+uQ7z2OPxaks0vn5mMWEh8/qi3eaB+4mZF4Z0TYxnfK3BjT9HTuKHT8Ho3zfQhJbYu5TxhGaScIH5jlCldmZ/45qrdTFq5RyhxAAJXawdFq66V6bNh1jeQ9Q0koeeJ5UxZgC7rXSnAMWHTQcHhlpV+8YCedv8EPIJTJXCmGkqa1UL4iHeW33NPRQaZyZ+oE0JI0NXvRvJf1pmMrUlm5SgWlhLu+RjB2EiPagWCM/KvsQr4EvRm27dcbvYkZWiGa0rj65zIs9+s5Jph6lfPcGsr4BB9kiya8S0sSCqfjBalnAAai2RQlXlSkA+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KMvWEz/V0J97/xLlY7f6Kqx4EecJ09c7qjYmQYyDl38=;
 b=B2hYauxMDwd4Tb4+lk5b8R5T6afM7vC62wiiGigKjodSCvOal9y+vqQ3nvyM7h9Lk0tndURg9OYwHoLS8Z7zxGKxPps8p23L4x7DLRgWpvKQ1sHZN17OU7G452afqq5WT3qHB+wvIwfMPJ7HyGDRT3oy/blEwq8MYyRp2nxOb8GTpNXPiv0rKUJGr+O145e5uur8TbowmdUngzZIvJ5dzQYDangsXn9IFDltXuwYpfqrJ5YdJ5bUUKvkgeHVGp+pGDojpzmfn7Y1eKpQ8iaPKOSaSZfaJspEJUB5o5kw0BAI8UDCuwYp0LHHlv37r48w0K/oYv8a3awHP2e02hVBYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vmware.com; dmarc=pass action=none header.from=vmware.com;
 dkim=pass header.d=vmware.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KMvWEz/V0J97/xLlY7f6Kqx4EecJ09c7qjYmQYyDl38=;
 b=ufjPW26j/a33O7Ax7Bot9UcmrLTpiMx+/78eNwi+zjPEKFG7ccxohhjCJPJU6wUX0b5OWc8MJwULSaaWgukU9/mDu8IAmJ4jMcqSw10k2MFPVLRTAZvcviQH6X0jTB8dwSs55fbqdgEIIkukGhIOatCVzYyNy5/cz4uwsKx5JWU=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=vmware.com;
Received: from BYAPR05MB5511.namprd05.prod.outlook.com (2603:10b6:a03:1a::28)
 by BY5PR05MB6962.namprd05.prod.outlook.com (2603:10b6:a03:1bb::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3564.21; Wed, 11 Nov
 2020 22:20:07 +0000
Received: from BYAPR05MB5511.namprd05.prod.outlook.com
 ([fe80::958b:64f6:b2f9:97e0]) by BYAPR05MB5511.namprd05.prod.outlook.com
 ([fe80::958b:64f6:b2f9:97e0%7]) with mapi id 15.20.3541.011; Wed, 11 Nov 2020
 22:20:07 +0000
Subject: Re: [PATCH] RDMA/pvrdma: fix missing kfree in pvrdma_register_device
To:     Qinglang Miao <miaoqinglang@huawei.com>,
        VMware PV-Drivers <pv-drivers@vmware.com>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>
Cc:     linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20201111032202.17925-1-miaoqinglang@huawei.com>
From:   Adit Ranadive <aditr@vmware.com>
Message-ID: <91aff9c5-ece0-6c75-0803-de92e491a2d6@vmware.com>
Date:   Wed, 11 Nov 2020 14:20:05 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.4.2
In-Reply-To: <20201111032202.17925-1-miaoqinglang@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [107.3.164.70]
X-ClientProxiedBy: BY5PR16CA0028.namprd16.prod.outlook.com
 (2603:10b6:a03:1a0::41) To BYAPR05MB5511.namprd05.prod.outlook.com
 (2603:10b6:a03:1a::28)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from pony.intranet.hyperic.net (107.3.164.70) by BY5PR16CA0028.namprd16.prod.outlook.com (2603:10b6:a03:1a0::41) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3541.21 via Frontend Transport; Wed, 11 Nov 2020 22:20:06 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5f2a04fb-392f-4251-f67f-08d8868ff1bc
X-MS-TrafficTypeDiagnostic: BY5PR05MB6962:
X-LD-Processed: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0,ExtAddr
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BY5PR05MB69625EFD7F1A99BDE74C4079C5E80@BY5PR05MB6962.namprd05.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3513;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: se4iDXDi7F1EgtPBiGTAhISEDKJWtCUaBi4IFf+iMX1pKnFTlDtZRGXUVK5JBspPrzh3WMZ9QHXAv8ZXlcDpfnqVEjGxKb+Q09cLsWRiTyZRPGdk0FNCbIGF5yqyfw/7C3DipgyHzNkes05/tFTHg2pW2V/V9drn8GNoT3ggj7AamfiQbcftPKIsRKmd+72ObVzvWh6t/fBCfWLfJHlO//lYQbxtJNfKctohzKAaM4DL/q4plY+R/BUb7+byk89/4+aKwYUR18BFE89cR2MVUpjM1cNLkLE0aH9cWA5rCwfqUiYPQloaOFIA8nvpu3yIHCrERcrcGpe5s9Uu4ZPdwGWZtn0Kt3fGEcXxuTcngqNDz4P5VgCh1sMBW3Ya/Ta0
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR05MB5511.namprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(346002)(366004)(136003)(39860400002)(396003)(26005)(31686004)(186003)(66556008)(16526019)(8936002)(4326008)(6486002)(8676002)(66476007)(66946007)(5660300002)(31696002)(6512007)(2616005)(316002)(956004)(110136005)(36756003)(53546011)(478600001)(6506007)(86362001)(2906002)(83380400001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: C3xT30tJn5jCXdYC7onShO3mn2o1PK/PZlEGvVAOxKMl1sG/xHYO65UpaUnWvgR+4y5n/dQ9eyY1CG/VAKY8/Lgl4z+306RsqK/5Qn1GtiWAT02ywc9/cWcce/XD/r9X0lJCj6sygLK3Ad0a2vHrH2ZDdfHC/Upi5DWbGT9Itp0ajFKy6mur4EfDbAq6srJLSz9MQn4p2SrX8v7t0Pk0yu8VSO7zUhBnAzSfocfEBaVpH/H8XeWKDTOXi+7YoyXSxrPzZ002M/lDzZY4oiBtKBNgmmoXE7EBXS5gJrYs/qJlpEyCFIV4KzVuUeQWGST/mtoy7P+INtThADV9XyyzhCP7Gz3U6pwrkHP3sBB4C5e8NZLE95fT2JEV8IG/7xzVG1+aZQb03+XmnSFVyqNqVRhtqYZkcX8h5p4xqNIYSCt08VT803ioZPiGx8DWaSAwtoGJZg4J9hfVTqwTgoOL63AEUSQri0dVxzZ+f3ByFRevZ/f/8rVQq+QhIjLrxCr0smB3WioujZf+j+tW5XIldc2GiS06/Vxt53hBnnSxQaauApURXboRwS6CdbuA/ZKiqBRvPdyu/Y/wx7XG5nxztl6DxkOrYdIOdvhdda1LAKt7iIdiU12AuswKmT3TGffO9sZCAqmP69jzfYz9wy3XcQ==
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f2a04fb-392f-4251-f67f-08d8868ff1bc
X-MS-Exchange-CrossTenant-AuthSource: BYAPR05MB5511.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2020 22:20:07.4229
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: N2wU53Cb3MeqkD4eVx3DLwc3KTfWCIYyxtH6ZQm6RXNvPWzuL1SMeJVjeZ1VzptinF1zQl6fEGX9al11daI38Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR05MB6962
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 11/10/20 7:22 PM, Qinglang Miao wrote:
> Fix missing kfree in pvrdma_register_device() when fails
> to do ib_device_set_netdev.
> 
> Fixes: 4b38da75e089 ("RDMA/drivers: Convert easy drivers to use ib_device_set_netdev()")
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Qinglang Miao <miaoqinglang@huawei.com>
> ---
>  drivers/infiniband/hw/vmw_pvrdma/pvrdma_main.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/infiniband/hw/vmw_pvrdma/pvrdma_main.c b/drivers/infiniband/hw/vmw_pvrdma/pvrdma_main.c
> index fa2a3fa0c3e4..f71d99946bed 100644
> --- a/drivers/infiniband/hw/vmw_pvrdma/pvrdma_main.c
> +++ b/drivers/infiniband/hw/vmw_pvrdma/pvrdma_main.c
> @@ -266,7 +266,7 @@ static int pvrdma_register_device(struct pvrdma_dev *dev)
>  	}
>  	ret = ib_device_set_netdev(&dev->ib_dev, dev->netdev, 1);
>  	if (ret)
> -		return ret;
> +		goto err_qp_free;

Thanks. This should be 'goto err_srq_free'.

>  	spin_lock_init(&dev->srq_tbl_lock);
>  	rdma_set_device_sysfs_group(&dev->ib_dev, &pvrdma_attr_group);
>  
> 
