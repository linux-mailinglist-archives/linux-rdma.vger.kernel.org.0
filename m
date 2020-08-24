Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0648E2506CB
	for <lists+linux-rdma@lfdr.de>; Mon, 24 Aug 2020 19:46:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726090AbgHXRqY (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 24 Aug 2020 13:46:24 -0400
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:3038 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725601AbgHXRqV (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 24 Aug 2020 13:46:21 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5f43fc750000>; Mon, 24 Aug 2020 10:44:21 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Mon, 24 Aug 2020 10:46:20 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Mon, 24 Aug 2020 10:46:20 -0700
Received: from HQMAIL111.nvidia.com (172.20.187.18) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 24 Aug
 2020 17:46:20 +0000
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.48) by
 HQMAIL111.nvidia.com (172.20.187.18) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Mon, 24 Aug 2020 17:46:20 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=POP2/5mWXhGczkv97y2yMpy4UvsbP6rZX69hh8H07NlgiJe0JJ5M6s3GmzifeOK4qGqXSDKH/oLWVPpd6HmAhmjC7EnHfQcFtWCir/iWYtWK8XCusO5bUtNk3lAHGCSDnU0K/t29gQX72aczDBoPZQrcnqDW/LwIghYqv8068WT6pSeIKYKm6VqO1t6ikOD6phVtCwiXVqh8YkPF/z4GxA2XwqxuF9reUa2wmXYN5f1qDka2geWeQQLKvdlRxsu8t+TA9ESPOtpZmw0w9YstddB74DXeSGt9BT4NrU1LRxreI7cKr+GjEfUfM+4DCHu/wREoesGBbp5T16/Hx9kcOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MYA6khl0xFMDgHg80iNar/sAnL1ODInYRUp/4bej6B4=;
 b=bz6Zfy+Q5WiZhzKCrgMEt9rv0RshREwJdRKinSVnP18lHpPPmqOcnXF7tr9O6NA3jRq/AUb/h2fEn0/iWN+hP2Zrt9p/rdVJxQwl8oHUT4iHjyT1Z+XWfKP+ZiRUKrTy8E7nQPjwrxfKf0f8gR9Bd/OSrD0A1XZlWDHSSEEkKbE9CDbVTEjgYqaIL7TzsretfbPjPXXRvWa66/qzYJUdZ5nV3rCXzJfOaPtokpGaJhxnTMhYxhcrfrJLzroB+TUe5M0RZ4heoeg9syzyzhHkpV0LBb2YIb5BGfnfBmTQj55L/j7OusOT9Fq1CVFl4sqII8q66P0xm842Y2TxWrT8yA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Authentication-Results: amazon.com; dkim=none (message not signed)
 header.d=none;amazon.com; dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM5PR12MB2487.namprd12.prod.outlook.com (2603:10b6:4:af::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3283.16; Mon, 24 Aug
 2020 17:46:19 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::2d79:7f96:6406:6c76]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::2d79:7f96:6406:6c76%3]) with mapi id 15.20.3305.026; Mon, 24 Aug 2020
 17:46:19 +0000
Date:   Mon, 24 Aug 2020 14:46:17 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Gal Pressman <galpress@amazon.com>
CC:     Doug Ledford <dledford@redhat.com>, <linux-rdma@vger.kernel.org>,
        Alexander Matushevsky <matua@amazon.com>,
        Firas JahJah <firasj@amazon.com>,
        Yossi Leybovich <sleybo@amazon.com>
Subject: Re: [PATCH for-next] RDMA/efa: Remove redundant udata check from
 alloc ucontext response
Message-ID: <20200824174617.GA3257363@nvidia.com>
References: <20200818110835.54299-1-galpress@amazon.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20200818110835.54299-1-galpress@amazon.com>
X-ClientProxiedBy: MN2PR19CA0014.namprd19.prod.outlook.com
 (2603:10b6:208:178::27) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from 255.255.255.255 (255.255.255.255) by MN2PR19CA0014.namprd19.prod.outlook.com (2603:10b6:208:178::27) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3305.24 via Frontend Transport; Mon, 24 Aug 2020 17:46:18 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1kAGXx-00DfOm-7u; Mon, 24 Aug 2020 14:46:17 -0300
X-Originating-IP: [156.34.48.30]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6e47a5e8-2b2d-440b-5a04-08d848559b25
X-MS-TrafficTypeDiagnostic: DM5PR12MB2487:
X-Microsoft-Antispam-PRVS: <DM5PR12MB2487E6831DA7D06D6E068263C2560@DM5PR12MB2487.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Gn7V7CizpKLQMqLoQhck3RskV07NKG5GtQfxZvpCyePt4Yx0nhsSBgu9gndmh3+RQ3DIX4DFiFuusw/Ko1r3roPAwoPuSpHt42Wb8K1yM+CKN81rSgzun+ygho8zmQ0TiUfRqAzzy7ja3VSDVkSE+BL5m9HzB6yu0ZxcsgdLSKiq1/FBXFIHFakmaZYmGMUNNV1+a17BYxMqSZLKuPPW86X0sEM98qDEVwyEnjr6EGZzWl5JX+uu+27d2xS9pD5xozzfBhWRBEQZ3eTivPAg0zVTBjiu1+0jhhYXp2/fko54ecIXWfPobNMIecE3rVDCQd8P4BkoYRM4kx4/4BisSQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(136003)(376002)(366004)(346002)(396003)(2616005)(8676002)(5660300002)(33656002)(186003)(316002)(54906003)(8936002)(426003)(83380400001)(1076003)(66946007)(9746002)(26005)(4326008)(2906002)(9786002)(4744005)(86362001)(66556008)(36756003)(6916009)(478600001)(66476007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: 5K+BFoftFkmnF/LuYaQP5V4kht3hbw1yHARltMtBYCaE71HTwX18rJxx4A1veZ62LPogTaVCstDxRlJJpvQJhj7NHR/OWP683KHsRoySnzOqg2iaFRvOKR7Q0hrDo4I30A3CWZP/GpaPmNQfDN10rffVFHX3ZRMFFNaLRV3gJbIZvsRDGd/X4evD9OSFK9z1wf6s/dwATc8i0HtSp6xSzEEDjYersmGNQoiqbw9Mj5h5168gsJMpSj9RCZhZo38FcoIdJuUOKY7Xz7mk9kvAlBC3lgZzVKoK+B4V7G5kQMH5jYfMjatB68mYUn8JLcn4ROHgE/ThB6ZBZQSJR85IFhlaJ7yXnfDSPfea9gYiBLT8PJlC7EkqRVzXdctyUnOT6tsqxxpHdJYynZVbbhlsjpezvhT289WHmZC7U20RORQZipfxKULE35+wdv6P99jImMa78y2t0rfswo3ORMxfZQQBKxWHYGBE1BU7AweuXDMJLM4wIP/0wGftx6YuIkrYbEaKRiI9hjBuzfKdF1S3iHpmj47IWFx6N+BiNNIJKSfjcf37qN2i+nf8Z5kkQA22rtvOkAuiRcTOaUsiz8N73HI4MYpqs1BnCoMA4Cu53Gc+sHQMZ7WtKFbbNk/Z2bpKvyBHeJQ9U3MCJtgn6Fb0Ug==
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e47a5e8-2b2d-440b-5a04-08d848559b25
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2020 17:46:19.1637
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EFgrpwuio1jEaw1dJ+rjZO+K4nOjsyQ//3QTR9eHplFoHlaZeIWZFcv60qanKQGk
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB2487
X-OriginatorOrg: Nvidia.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1598291061; bh=MYA6khl0xFMDgHg80iNar/sAnL1ODInYRUp/4bej6B4=;
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
        b=FJcrheaQPEw5iqIgderkIgDXCALsWqAXa3a0+V2WcXEtFfsFBLvUs4E9Am0fNzkZ0
         Z2HH+2dxPd8IkJLdzuxqvx7OjrvnqM0X99b4w89I9w10Sqb0Dmlh0gST/HFVH3pWqe
         ZrdbskrB3yS/6jv76n1In9cEw3BOmZEXffuWDLvkPEzILkGaAyJUcCLzZd4AQAHkBY
         6Bi6GQetuXBVVnMV46opkS0RjeKxB0ePPGqj6V0LxbmcShc5+D3ScKJkmlJs+VmS7W
         cD1ezbQ43znxQXBKVeWG4BV1yWjViRw/qVJl/BfllpSql074qM9pkkw8mT0t3kDpq3
         l5BoEyQp4OmSw==
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Aug 18, 2020 at 02:08:35PM +0300, Gal Pressman wrote:
> The alloc ucontext flow is always called with a valid udata, there's no
> need to test whether it's NULL.
> 
> While at it, the 'udata->outlen' check is removed as well as we copy the
> minimum between the size of the response and outlen, so in case of zero
> outlen, zero bytes will be copied.
> 
> Reviewed-by: Firas JahJah <firasj@amazon.com>
> Reviewed-by: Yossi Leybovich <sleybo@amazon.com>
> Signed-off-by: Gal Pressman <galpress@amazon.com>
> ---
>  drivers/infiniband/hw/efa/efa_verbs.c | 10 ++++------
>  1 file changed, 4 insertions(+), 6 deletions(-)

Applied to for-next, thanks

Jason
