Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5138B222B2D
	for <lists+linux-rdma@lfdr.de>; Thu, 16 Jul 2020 20:44:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728182AbgGPSoo (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 16 Jul 2020 14:44:44 -0400
Received: from nat-hk.nvidia.com ([203.18.50.4]:24705 "EHLO nat-hk.nvidia.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726986AbgGPSon (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 16 Jul 2020 14:44:43 -0400
Received: from hkpgpgate102.nvidia.com (Not Verified[10.18.92.100]) by nat-hk.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5f10a0180000>; Fri, 17 Jul 2020 02:44:40 +0800
Received: from HKMAIL101.nvidia.com ([10.18.16.10])
  by hkpgpgate102.nvidia.com (PGP Universal service);
  Thu, 16 Jul 2020 11:44:40 -0700
X-PGP-Universal: processed;
        by hkpgpgate102.nvidia.com on Thu, 16 Jul 2020 11:44:40 -0700
Received: from HKMAIL101.nvidia.com (10.18.16.10) by HKMAIL101.nvidia.com
 (10.18.16.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 16 Jul
 2020 18:44:38 +0000
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.168)
 by HKMAIL101.nvidia.com (10.18.16.10) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Thu, 16 Jul 2020 18:44:38 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FWdmpA/bjrG0Qbpjgw3+HEr/M2n1zEphG9lBVNnIUM7Q65Q89x+ZRnaxL0aMOQT5XP6OoevNVK/jWJdyliwIt5Q6vp32zWG2aBUJrIUplMXTL60aU9uYf1+1RW8fqNkRx7olSXuIGi50t3GlQGkkLlioCuDu1pc+U/iAkeGwrveWuqVtbTQsghMya02Xq7gcNo8l/lJdAwIinRYjOvYgSIhOJIrg1X2uBxA9zOSMQwYKvcPJd0tI7JlQDToSng0xz/fyzFLRNJOr5C/uh+8wpVu/qqsg0kk3otgVk2n+mMGGUycgtOFwCyorOzID7odftjGfW/gBTJWeIi/3EPpP4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yKtSQPw9VXl5Jpo31+YX7qMHWzRnOTNgN5DFtGG8vXg=;
 b=V9rN6GGfp3C4fSYkS6YlazMzfNdGGJTAKIM20ZG7HAt7qyfjsCTzHbJuqgwE/VKZr43uPPHzsyeC1z2oTQC1/MZHZfpUHpCvjVgTD04hlofOdZtpGcJOxk+DQzDW+g3tyNjbGpPhmDyIFGMWR+ZC6T0/KSST5fRitmvK6lFQ5sa9MOzIlite5AZjxCK1GtVxYorSJnWEzH4KqTH6jwa/aqGUxrRe0TtEf+WhANnP48lrs9bSwwyl8sQZH7Wf7xXbXkNNfIiJJLH2HDPCp7c5hybJ5QM9Yb45Ysv9cWOlhFsIxfd0HAPEQtUkTAezzSNFy6iFyOEXQf/kj4qCSGHW4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Authentication-Results: wanadoo.fr; dkim=none (message not signed)
 header.d=none;wanadoo.fr; dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB4498.namprd12.prod.outlook.com (2603:10b6:5:2a2::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3174.20; Thu, 16 Jul
 2020 18:44:36 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1d53:7cb4:c3d7:2b54]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1d53:7cb4:c3d7:2b54%6]) with mapi id 15.20.3174.026; Thu, 16 Jul 2020
 18:44:36 +0000
Date:   Thu, 16 Jul 2020 15:44:35 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
CC:     <benve@cisco.com>, <neescoba@cisco.com>, <pkaustub@cisco.com>,
        <dledford@redhat.com>, <hch@infradead.org>,
        <linux-rdma@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <kernel-janitors@vger.kernel.org>
Subject: Re: [PATCH] RDMA/usnic: switch from 'pci_' to 'dma_' API
Message-ID: <20200716184435.GA2670424@nvidia.com>
References: <20200711073120.249146-1-christophe.jaillet@wanadoo.fr>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20200711073120.249146-1-christophe.jaillet@wanadoo.fr>
X-ClientProxiedBy: MN2PR15CA0024.namprd15.prod.outlook.com
 (2603:10b6:208:1b4::37) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (156.34.48.30) by MN2PR15CA0024.namprd15.prod.outlook.com (2603:10b6:208:1b4::37) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3195.18 via Frontend Transport; Thu, 16 Jul 2020 18:44:36 +0000
Received: from jgg by mlx with local (Exim 4.93)        (envelope-from <jgg@nvidia.com>)        id 1jw8rz-00BCj5-96; Thu, 16 Jul 2020 15:44:35 -0300
X-Originating-IP: [156.34.48.30]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b48ec139-58d4-4fe9-076d-08d829b84a01
X-MS-TrafficTypeDiagnostic: DM6PR12MB4498:
X-Microsoft-Antispam-PRVS: <DM6PR12MB44987B630E96C9F607A6FF75C27F0@DM6PR12MB4498.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4502;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZL/kf+6AKWMnJIsMwgMOO3QYmI7n4P1lJDQYN1O3viDPDUp8JAbnLpsUbPrrDZ6VYYmSxRh1+WtniyLhphr0m4NVwcTi1beyL9EB8ONzlXDSpSIGFFEg7v/MGKhkyM6Xpe+bpLnDhpQLkWNA4Tq5oVI9b6H4e2/1xirk+3tcsEHtgJJ5xzitr6kbKiLzC1dQcFay/srCdfg916UQ7qwaIsi/YDbHAwIvBgAMEoEcWK8cmujzAINCWDfLX4JeXDDRQd4ZCEtvubR6NU4oy398ghw+byIq5aZzc7RAD4reYha5pwGsPSoJZ/DcZlYV4Y4P9fdhKHvKYzWrmdVgpKYjfOUUnw5WfejZkfwLIvg3MsQcp+YhuEacJA8moGvk7w9UvNLw+MeHn5EY8Q5cbEyaGQ3wUzCCo2ml9SIf6eY/7PA0KaZ6RsPYvqdMfm7uW5z+2kArVcuou7V3csRL1PlGhQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(39860400002)(136003)(376002)(396003)(346002)(366004)(966005)(36756003)(4326008)(5660300002)(478600001)(1076003)(316002)(66476007)(33656002)(186003)(83380400001)(9786002)(26005)(4744005)(6916009)(426003)(66556008)(8936002)(9746002)(86362001)(2906002)(66946007)(2616005)(8676002)(6606295002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: Mkvp9NrBjeuMUZpVKwq3U3FAIZjbw/3ptEsC5BizwISvbHhxu3Q7XzttiBh/TXXpol8SDWUnlXI9xWuLj1nHVPa1pGepHz1G/V4y23d03ffRzVV3tiEHkjwseegKo2NHGXdBCobBx6ZBdmckHjdBFSkzXyzimA311++X/jgNjYE01m9d7IH2d4YJCFupv0rcBP5PINUWidDeYd0mbT1Ud99WPv7Y8JeYHXea8HroLI66nYvwcYGiSFKACXTKkzf3KAN9GpdI7RMY4guZResJGeQZP418tA0v8/PCUReeU/LH62LvOv8Tt3nEieEqdDsbU2g33tRveN5QQ5ZBUX+AXMTgfSD9mS2ZQR6ENEcQ4APyJiF4XlnzEefxf3+RffXC9+iCxpsGmS4QrFiIShXxLLfxysJxVtvZgurIrCqOvsm6GWX2thNVE8OZnr2kZ66BruqLYMDrsct98b2kkh5MGGjMMDxcUP1ehimMfRIOg/g=
X-MS-Exchange-CrossTenant-Network-Message-Id: b48ec139-58d4-4fe9-076d-08d829b84a01
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2020 18:44:36.7966
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jEqrVCBP3piwSvhKwpgqUnAH8jT3cD/JyjFQRWclj+n8i8zOQ9X7BptK5py+ARL0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4498
X-OriginatorOrg: Nvidia.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1594925080; bh=yKtSQPw9VXl5Jpo31+YX7qMHWzRnOTNgN5DFtGG8vXg=;
        h=X-PGP-Universal:ARC-Seal:ARC-Message-Signature:
         ARC-Authentication-Results:Authentication-Results:Date:From:To:CC:
         Subject:Message-ID:References:Content-Type:Content-Disposition:
         In-Reply-To:X-ClientProxiedBy:MIME-Version:
         X-MS-Exchange-MessageSentRepresentingType:X-Originating-IP:
         X-MS-PublicTrafficType:X-MS-Office365-Filtering-Correlation-Id:
         X-MS-TrafficTypeDiagnostic:X-Microsoft-Antispam-PRVS:
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
        b=SZtc40uWSmaUff58lqjNahZd9u9nydxXkmkwwBzXRcSfCCzwjg0ynLBDNhTzmTpRV
         DK3+V2AkO/m+gO8FYfrBjSe0ht+rv17H6Xey6PNaxngJH64sQnn3P9FaCLfsBbCT5G
         0jaaRcm5tUxcQMlJQjZ5xTIahUYD6gUU9lQzYrTUn6neMqSw+8Y/5hJ9pUA+etZIo0
         L7xGN9/PM77SeAEqaqJIiwTlYthKygeOI/SWmtS7baaKjIPTcch1/WZrnNdmeSpcrk
         j+mydAGNJ1wCKbVwlv98O1NvtTZIP0ep+xgs++fiuIa00JvnIGCAv+yd8THu1EbBFF
         jW3ZnKy9fGIBg==
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sat, Jul 11, 2020 at 09:31:20AM +0200, Christophe JAILLET wrote:
> The wrappers in include/linux/pci-dma-compat.h should go away.
> 
> The patch has been generated with the coccinelle script bellow.
> It has been compile tested.
> 
> When memory is allocated, GFP_ATOMIC should be used to be consistent with
> the surrounding code.
> 
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> If needed, see post from Christoph Hellwig on the kernel-janitors ML:
>    https://marc.info/?l=kernel-janitors&m=158745678307186&w=4
> ---
>  drivers/infiniband/hw/usnic/usnic_fwd.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

I checked the GFP and it looks OK to me, thanks.

Applied to for-next

Jason
