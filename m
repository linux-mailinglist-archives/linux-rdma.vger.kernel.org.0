Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 429983154C9
	for <lists+linux-rdma@lfdr.de>; Tue,  9 Feb 2021 18:18:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232748AbhBIRNf (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 9 Feb 2021 12:13:35 -0500
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:6132 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231845AbhBIRNe (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 9 Feb 2021 12:13:34 -0500
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B6022c2940002>; Tue, 09 Feb 2021 09:12:52 -0800
Received: from HQMAIL111.nvidia.com (172.20.187.18) by HQMAIL109.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 9 Feb
 2021 17:12:50 +0000
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.176)
 by HQMAIL111.nvidia.com (172.20.187.18) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Tue, 9 Feb 2021 17:12:50 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TCfTlT9udraKmL2t3Am6B+QVFQx9usa4U/o8uRh8W4D5QuCVH/CYpVZFBIzVGNcD8lcMFCQLMpTyOWl0txLJ3fIzVVwtLDHsRG+EyRx/n5H/RekXeKGzgq/PnnmzhWZgScAjf1LIyb5CqjSFsQgwD1xKZuYtEUkf9Pnk9G+3snwHRwsFy7ltgU3aCpA2rnGBCaGeNON7UxxrBxd78MmVHS9xi772YyeFPuI0lDJG6tKSOoF+xR8nvoo/bUBbEFvpW7FH/kDHO4GM+tbLQRgEjDpWmIyPrC+QD1GW7MqJEwCFQx8E2MASRT6CzV9wb3p/bACtB3gPBHV09uX09ESRww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yCPJxH5sNG5llzhVm/hj2aErzW6LbU5YQTLrYkjKdzo=;
 b=cGJqvVTUlAFBHWYRHiLraWhLp2DY21QbAo4D46TqaDMLOsvUHi8iOiin1gJDNX4cCK1goVlEYg1zJLwgMrP6vwqKc1Pj5uswr5hQPfMG06EhUzJbhddItJsVhfVHNgAgzMEfcUkzg4VM2cEouEg85c7NT3JfnNxPuW9fLkeofM+DpdVhb7RDP7HW2oI1hcI32DZ8W7QF4ZImX8HxbSxo/Ghb3q681XMl4U/4ffZ/UQjL5ToUJWCbGToFEcIOpRXwMCvHqQeIPYseWX1qmrDy96l1n6PlpO+4ItnscZFoz7zBm48xJVT0f/+HWh8NpjjdP6iYvRXsIYUIfXygzkNlvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB3018.namprd12.prod.outlook.com (2603:10b6:5:118::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3825.24; Tue, 9 Feb
 2021 17:12:48 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::d6b:736:fa28:5e4]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::d6b:736:fa28:5e4%7]) with mapi id 15.20.3825.030; Tue, 9 Feb 2021
 17:12:48 +0000
Date:   Tue, 9 Feb 2021 13:12:47 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Weihang Li <liweihang@huawei.com>
CC:     <dledford@redhat.com>, <leon@kernel.org>,
        <linux-rdma@vger.kernel.org>, <linuxarm@openeuler.org>
Subject: Re: [PATCH v2 for-next] RDMA/hns: Adjust definition of FRMR fields
Message-ID: <20210209171247.GP4247@nvidia.com>
References: <1612859923-44041-1-git-send-email-liweihang@huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <1612859923-44041-1-git-send-email-liweihang@huawei.com>
X-ClientProxiedBy: MN2PR20CA0064.namprd20.prod.outlook.com
 (2603:10b6:208:235::33) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (142.162.115.133) by MN2PR20CA0064.namprd20.prod.outlook.com (2603:10b6:208:235::33) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3846.25 via Frontend Transport; Tue, 9 Feb 2021 17:12:48 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1l9WZD-005VLK-9q; Tue, 09 Feb 2021 13:12:47 -0400
X-Header: ProcessedBy-CMR-outbound
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1612890772; bh=yCPJxH5sNG5llzhVm/hj2aErzW6LbU5YQTLrYkjKdzo=;
        h=ARC-Seal:ARC-Message-Signature:ARC-Authentication-Results:Date:
         From:To:CC:Subject:Message-ID:References:Content-Type:
         Content-Disposition:In-Reply-To:X-ClientProxiedBy:MIME-Version:
         X-MS-Exchange-MessageSentRepresentingType:X-Header;
        b=MBWj9ZrhXObxZS5MFNBWS3aVD400igHbsEk9oCAhrVCywKl94SdUibRTW3Llj51m+
         GoS1/doLCGwPsSgi2GiWXS4QTAY94z2BAip5DHEPPN+if6Y+ZPDWUJjypqCXaYb07m
         FlUWTw8phRbSfqxQYRo7MWoEVDfjxP5YnXk7RQxboI+8Vg6l2uaQyVyEOu09lvmvW+
         8MvjVlRnX68UM/onnP502UC/CXVMgbe2fhwQczslElvic9xwflT4c8vkj8ILifK9kw
         qJafzj636ixRKPOUvZS3Tva+LjTgFOEkbFTx/HmGSjzJJHauYD1v9xAh4+ZsX3fE7+
         qaqsMN2/itmVQ==
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Feb 09, 2021 at 04:38:43PM +0800, Weihang Li wrote:
> @@ -545,7 +545,10 @@ static int set_rc_opcode(struct hns_roce_v2_rc_send_wqe *rc_sq_wqe,
>  		rc_sq_wqe->va = cpu_to_le64(atomic_wr(wr)->remote_addr);
>  		break;
>  	case IB_WR_REG_MR:
> -		set_frmr_seg(rc_sq_wqe, reg_wr(wr));
> +		if (hr_dev->pci_dev->revision >= PCI_REVISION_ID_HIP09)
> +			set_frmr_seg(rc_sq_wqe, reg_wr(wr));
> +		else
> +			ret = -EOPNOTSUPP;

The driver must also clear IB_DEVICE_MEM_MGT_EXTENSIONS if it won't
support IB_WR_REG_MR

Jason
