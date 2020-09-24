Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0658827797C
	for <lists+linux-rdma@lfdr.de>; Thu, 24 Sep 2020 21:38:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725208AbgIXTi0 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 24 Sep 2020 15:38:26 -0400
Received: from nat-hk.nvidia.com ([203.18.50.4]:34233 "EHLO nat-hk.nvidia.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725272AbgIXTiZ (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 24 Sep 2020 15:38:25 -0400
Received: from HKMAIL103.nvidia.com (Not Verified[10.18.92.100]) by nat-hk.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5f6cf5af0000>; Fri, 25 Sep 2020 03:38:23 +0800
Received: from HKMAIL103.nvidia.com (10.18.16.12) by HKMAIL103.nvidia.com
 (10.18.16.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 24 Sep
 2020 19:38:20 +0000
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.174)
 by HKMAIL103.nvidia.com (10.18.16.12) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Thu, 24 Sep 2020 19:38:20 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=klMcMCgZHFhrjdfXg+siDYyFRFGjhDnJwIMtpLpkWWmArsS8si2QIIkP0/aLH2YjY0DOd/BQQkSUiTBQt7d8+3CZcPo4iGmVT6zyGBSvnOZhQSBy3znfi5XaanDy5WVWHqEl94QM6tmdLn4AcQh2qpNpE4he2PtOJ09O92GGyKUlF+jA19j66W/1v/uIVoM3WgCYDCZX55SP7jXQ0Py8+HYodKlF9Hv8ciHJASGDVN8vEUeX3q51Tu0H6qfeOC9Z+K6GwAnl1OxmTfy3aDGWADZxP6tJ+TYjUzmG9PjaZBBR0CelWFqEfixBIVGnUgAfz54xkpqr1PDPG0wKgUrNHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OjD+7d4egLkT4siuq1LeptIJFYq+k3IP8D5sS4Cy8HE=;
 b=djlZ+6sh1bRLCepUEZGE2XE/RzWb+NKwXPm8UyKu+mTRhzmWkYyBpNdqp/LhGHlmXRzB5zPJF+Ad5+z2OuYwlqzwVV1WlJa738Gf/ojRroRMy2Arhdo8ZKDlzrr2fswjNrPCezZ/1ooZcW+6PiYC2+/btP8br9bAWOo+B9eC/coFiFvJLzMdtrTscRKV00RkdXAZMMh2D60AOkSDbMZkl4ywmU/mjhMFQUn1n7vjZYtr8GLQIfZojDUmbxJXFY2kmJ9Hrq/yAhY4Atctqpi6cMXarQnYAGXOjjCwdNV4/E6O9Fur10672YBp7SmJF6SxKzz8lpZoz5LdT7zE9d6yPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Authentication-Results: huawei.com; dkim=none (message not signed)
 header.d=none;huawei.com; dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB4267.namprd12.prod.outlook.com (2603:10b6:5:21e::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.23; Thu, 24 Sep
 2020 19:38:18 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::cdbe:f274:ad65:9a78]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::cdbe:f274:ad65:9a78%7]) with mapi id 15.20.3412.020; Thu, 24 Sep 2020
 19:38:18 +0000
Date:   Thu, 24 Sep 2020 16:38:16 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Weihang Li <liweihang@huawei.com>
CC:     <dledford@redhat.com>, <leon@kernel.org>,
        <linux-rdma@vger.kernel.org>, <linuxarm@huawei.com>
Subject: Re: [PATCH for-next] RDMA/hns: Support inline data in extented sge
 space for RC
Message-ID: <20200924193816.GA127765@nvidia.com>
References: <1599744069-9968-1-git-send-email-liweihang@huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <1599744069-9968-1-git-send-email-liweihang@huawei.com>
X-Originating-IP: [156.34.48.30]
X-ClientProxiedBy: BL0PR02CA0034.namprd02.prod.outlook.com
 (2603:10b6:207:3c::47) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (156.34.48.30) by BL0PR02CA0034.namprd02.prod.outlook.com (2603:10b6:207:3c::47) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.21 via Frontend Transport; Thu, 24 Sep 2020 19:38:17 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1kLX4K-000XFK-GX; Thu, 24 Sep 2020 16:38:16 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 29e81aff-64c7-4c14-e28e-08d860c162f6
X-MS-TrafficTypeDiagnostic: DM6PR12MB4267:
X-Microsoft-Antispam-PRVS: <DM6PR12MB4267D58CA48B3B39C95C4BAAC2390@DM6PR12MB4267.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WfTSNN7HpPGf5Wy6QeJu6AcpPH60KXEoz2IlJFtMH/bbGPNz++sh5/iOX5UHkJX4ucWPr5yxd5X0gUn5TmOUM2MM9nkWEwXXUPXSK5JufqfZPnhpO4P0CotDPFQwb4l5De3IP0Wv52U6QJ7dsHwMEBa/yYryWeSlgA27RQpYrJRmN9lWGw2HErOWCv3ewaRyBPnGfwPE8j553WHET6HrT9X5/emcwNqO5CyEL2YKHEFTTfmgFpqz690yhKcQXAhZZMBtm39pu1gw3/WnZANlh4HFGHm/Czza7QwO2wYUZ+Aub2vfEaD3ZlbtHyhUAExHy+JaqQOYAqDUc4mMPjPp2Iu4C6nqFiEnHvqc1JSOoyBNoXu5qiS1S7B5JmEr4MbzAQSHHgVjJpkVihAkM/Y2ZpXoOleS2YPU5Lmskb4mRYM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(376002)(346002)(136003)(396003)(39860400002)(2906002)(5660300002)(33656002)(66946007)(426003)(186003)(6916009)(26005)(1076003)(8936002)(2616005)(4744005)(83380400001)(9786002)(4326008)(8676002)(86362001)(66476007)(66556008)(316002)(478600001)(36756003)(9746002)(27376004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: Pc1MGnvlwDo+liJNXXFhNFte9UcABwsoGA3Vxe+/eNebRVLqzDRhQY2JFoUn4tdkLfGzlS63ntwNpeiTRc53q1k/3/HfrRgBkIs+dc7tkWCwByueuz3LWT0OvTxOZsa3FmOq85jC/HiTTE/QAzs/Hel8upY0+ryyJFMI21P1tVMhAAB6HpHZEeE45lr+yQwmNs4eRZiUxCQz4V1cEscG8akiKhi/VQp88aX4GnGetleHmhTem3vigJigXbvxZOmBzerRFw2x46UxMGuUKAeIImXZRJG8Y1Qbun/zl9ZlnlyKWZTSQg7OVVxuEQpJQBju79KM7us0i7C8crWtjDRMpY/D2O45NhgI0QRahcNxoot16CRgpF+uV1BTXfHVfQreFYmFerp3/peOpCQpuAnHWEoNDSz4Wzsv8h6NhuUPwMXBagFxlFdRzzgcKO4iQ1/Gh2CquNQ7HCMiZQ4i+xA2DxYT2Js9OYoP0bluHI124cDzcmRKZGDUhVfMnDpVeeSeaprA6vTysCELwunDk+lq+QUYwOcJYFMYLA9IiSIyKgWcJ8n27DvfUICWpLmxkJOSzP9MK55jn9+Bgq24NnQAq7BHa/QbMKa1HYdKaeXxm9r6CATq0tAufk2AvM7jFfnqGw+FjSfnavjhUW9idrMriw==
X-MS-Exchange-CrossTenant-Network-Message-Id: 29e81aff-64c7-4c14-e28e-08d860c162f6
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2020 19:38:18.4353
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4xC4+++SNV5hU/bg6xt1H0AekRME36YI0YK0z6TNQytyy0fhU7/Vkyp5KTSBJdsd
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4267
X-OriginatorOrg: Nvidia.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1600976303; bh=OjD+7d4egLkT4siuq1LeptIJFYq+k3IP8D5sS4Cy8HE=;
        h=ARC-Seal:ARC-Message-Signature:ARC-Authentication-Results:
         Authentication-Results:Date:From:To:CC:Subject:Message-ID:
         References:Content-Type:Content-Disposition:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:MIME-Version:
         X-MS-Exchange-MessageSentRepresentingType:X-MS-PublicTrafficType:
         X-MS-Office365-Filtering-Correlation-Id:X-MS-TrafficTypeDiagnostic:
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
        b=MpQDAxIbVVt8ZE7cx559pWqyeAegJ97FiabggEVr1g1Tl60xc/ZJ28HAY5AQgigoy
         9H9LbxXf0HB3LuZdp+tY71bDDJwKAFenVxFKL5T44xhqMhjZWNLM63UvqsH33M/l/Q
         mAjZ0RrKdihGB5b671y05tB/rFvt/9hlE6QYSFolr51/3yEDcJH0gX/Y1RGtrda0dT
         4pH3suEXNL1rN7rTHKWL4FlSyZedcZ4dbQu82zZr0t/3nu70Mfc0Hrt/vVsN26ocpq
         jzNc600/DZiLMPVPc1+bF3ffRosP6lrNQ74OGtPSddXFUPtaFKzTUadoS//D2F14/Y
         0PdhcgvWn36Dw==
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Sep 10, 2020 at 09:21:09PM +0800, Weihang Li wrote:
> HIP08 supports RC inline up to size of 32 Bytes, and all data should be
> put into SQWQE. For HIP09, this capability is extended to 1024 Bytes, if
> length of data is longer than 32 Bytes, they will be filled into extended
> sge space.
> 
> Signed-off-by: Weihang Li <liweihang@huawei.com>
> ---
>  drivers/infiniband/hw/hns/hns_roce_device.h |   2 +
>  drivers/infiniband/hw/hns/hns_roce_hw_v2.c  | 196 +++++++++++++++++++++-------
>  drivers/infiniband/hw/hns/hns_roce_hw_v2.h  |   3 +
>  drivers/infiniband/hw/hns/hns_roce_qp.c     |  13 +-
>  4 files changed, 162 insertions(+), 52 deletions(-)

Applied to for-next

Thanks,
Jason
