Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F5A839491B
	for <lists+linux-rdma@lfdr.de>; Sat, 29 May 2021 01:23:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229549AbhE1XZH (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 28 May 2021 19:25:07 -0400
Received: from mail-dm6nam12on2089.outbound.protection.outlook.com ([40.107.243.89]:23745
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229500AbhE1XZH (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 28 May 2021 19:25:07 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E27UqkNMss8m6nOykuiV3sZj7jpD7mzvwKy6S3vyrCFElL2/xu4nHAGVqAca6RKo10KcNcPy89rchBczteyk8meK93Q0vuzuh02Py6Qat0N2RwMzoGLEJ+Crd6m2Xza+IexT0/tEgv/tTRN9JwATP/fBiTLAeH4CGWBjIiCgufu1wpfX//x6384YsdiSdGP0xnp7MjR0QlZ4Ut7qHp36zcHelj2ULrTldt7udQ4EeJaUgC0sipGU96D8ZPc8OVkqZw1exl5oF/Q/vTZcdXmwR0EyImIhKRJfj1k/hfRRhMEKczngkNzgg7eCvBnqHBXM0zgWYwY5WnoGkBjELg4o5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fTjuiT1yJagLMP5UDctlPh8RshAcgv7pnQeROioh2Bo=;
 b=WnabVkfL3TxQ3SHNvvk15sPs4gukRdF9GeU/tTV1dWU6/zbnWGzSBXElOSXad4jtIEWnENIxb0PlrmZUU4GqE7qUF7kHAWIc+OLX8wBhg7QuF3tzBFjiAvNZXcHgtb0c8Sjpd3TuVXWi+H7wrTNbqxdEFbDonY/nxOyTonIkCqrAGCI8ZcnQPSacEt8JkDeMKi8YWfewkMeFCjUTPuht7aNxrp2xXHkON6O7nGZRXaEXd0Uofss1znUrJddPOWS/RcXA2R+nUdwaLuVDj1Q6yjt3YST1wFz7W7DLd+IxF5EXGf0rrkIqpFI0XJWPuyMYDXuCDGyjbvo7fN0Mam6weA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fTjuiT1yJagLMP5UDctlPh8RshAcgv7pnQeROioh2Bo=;
 b=SEut+Anf1XDSJ7vWZHVaHIozhJwXZn430OLQfSc2rKN06f6QnRESerQTCk/LL0oQfFFMhnAGKowp+S45jiOJYfK1ylBtso9XYWBu/erLpvcQ19uSzyx/pR/7XErq8V/WkG30njNKAZ1VO6tLw+nDvMDEEJKPSaIwLCP97oIJb49ZkTArWySu+dWWv4IrA3V6HDZK/UAahN3GeBfKAzodTpSIBvE8bwkVk9vI+jHIvfP36mAUxqiz1KaLRQT6IikzuBLbrwyNflt0D4SuelTn4NhXn1yCtmADFnn8ApocxXdZFUdeJmFfRxfFUFTDY9+u+wV3kXcVdyoaOSiBRCWrFw==
Authentication-Results: acm.org; dkim=none (message not signed)
 header.d=none;acm.org; dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL0PR12MB5538.namprd12.prod.outlook.com (2603:10b6:208:1c9::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.20; Fri, 28 May
 2021 23:23:30 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::3d51:a3b9:8611:684e]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::3d51:a3b9:8611:684e%7]) with mapi id 15.20.4173.023; Fri, 28 May 2021
 23:23:30 +0000
Date:   Fri, 28 May 2021 20:23:29 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Leon Romanovsky <leonro@mellanox.com>,
        Doug Ledford <dledford@redhat.com>, linux-rdma@vger.kernel.org
Subject: Re: [PATCH v2 0/5] RDMA kernel patches for kernel v5.14
Message-ID: <20210528232329.GA3852821@nvidia.com>
References: <20210524041211.9480-1-bvanassche@acm.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210524041211.9480-1-bvanassche@acm.org>
X-Originating-IP: [47.55.113.94]
X-ClientProxiedBy: BL0PR1501CA0012.namprd15.prod.outlook.com
 (2603:10b6:207:17::25) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (47.55.113.94) by BL0PR1501CA0012.namprd15.prod.outlook.com (2603:10b6:207:17::25) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.20 via Frontend Transport; Fri, 28 May 2021 23:23:30 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1lmlpB-00GAIw-8G; Fri, 28 May 2021 20:23:29 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3e5751ca-89f8-4c9b-db67-08d9222f9a8f
X-MS-TrafficTypeDiagnostic: BL0PR12MB5538:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BL0PR12MB55389D191020117BEBB9CD5BC2229@BL0PR12MB5538.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dBfM7fVes1VgFFHw+YHw0RJd7bZNKP2jC+7mW8A7hEtQ8Vddc4LQhBUDLehG6Tjm8EvD3HZzGUjomBQWGNtkDk9I/byNYiK5iovPDtEytAx6b02JzG9NJz2xZjZHgNQQ1m83Qg1IZZJwmShEvUz+J02hQ7nyfRGGeR3hECdvNNmhRxn9cJJx7jbrDy81VG1Zx76Jk6rIXpyUMoL8f8s9JUm+CO3E3piqPaJZTpSchkRcM1mtTqmywNuHZqP0vKcEW0QOw4ir6jN4RS0L2iyg2Vqh1TNR2gzjnknMwhtp0Fr3upkHOiGf4YzGxfugsV2n+j13qgtL2Y2g9yHjSpmxc/9R1ap5oDv4ZdSceDMGf7BnVGXHLbg1808i/PG+QelqwRrb25glj5iUTiosEXhIRdEjiOt38vtxn1WoN1SX+HiW/1HCdNHlPjKN9DQTPQQm80rfxhEefK5lTuKykwfJaxYsMJBVaMrKXcN3cu+TqOhP1Th9eLCn+V37OtYYvyczK8aSkzrG6UwowA+A37G6QfGYtNW96OeYvjVgcFPzxDxBzlXcmOdACvByTDm1nDEg1CzoN6iwAfF0+nDEzK2bUtK5KABoCYOv6w4peV1f6Bs=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5506.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(39860400002)(346002)(376002)(136003)(396003)(316002)(426003)(186003)(8936002)(2616005)(9746002)(54906003)(8676002)(2906002)(1076003)(83380400001)(4326008)(9786002)(478600001)(6916009)(33656002)(26005)(38100700002)(66476007)(36756003)(4744005)(86362001)(66556008)(5660300002)(66946007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?bVZYfi8e+Qrt/Yr2M2nZNCy5484gd4Z1A5jtXxKAvbOFVh8v6Sf3Bm2pgA5c?=
 =?us-ascii?Q?2l/ujRv68gzfDmEQeKMqc09ZOe8hcJD2/GHsnYlfnASoIHdhsH4KvPiqajCJ?=
 =?us-ascii?Q?otVn/mpUo910VgmMUubBHbl9fF8r4GSnZcOGqum20VOjAYqK9cvMHy89qCfn?=
 =?us-ascii?Q?l637lXX0DBIQwzGYPXFNuLmFdBQwC8bwQqvGqjkg9ZQurlqUZJxYBCgXu6/m?=
 =?us-ascii?Q?n3ILnIkV8UGeYE6Nla7+KE8V8XLlbW7adYojr82o/+xhbyETw77ZCNRwE9dH?=
 =?us-ascii?Q?/xVG7PSVZHmNMb0unQmHkyA3C39FcbmtpQflmE8bgHyCarrkgabuAaTkpuqK?=
 =?us-ascii?Q?KkLttAw/ob9oNEDqeylbr/aC2NfTT1zfqZEI088ZyI6lb5wGE2B1bJzmKxZQ?=
 =?us-ascii?Q?AUzWqv+ljNVBd7pcKbr1rLA1mL3Y0u7MUI1SPspR/W6i8CS1nv+IVMXn+W1C?=
 =?us-ascii?Q?17sQsjaT0QNABDpz+gE1EZAoIc+XWPkGg6erETMvOWIe4kGYejRcCJjJ4S2j?=
 =?us-ascii?Q?XOy9so8Gx4sBYtXK792BiVH4imrra/hbXaW3RRx0l3+uSfZhdRoafYGDuWGe?=
 =?us-ascii?Q?szwR8hdIrvpAWeZk2SVhavZLjx6XuAKZ4wsz6dhcD04uxUsH/cdwDRv0IdPe?=
 =?us-ascii?Q?TUYvNSxBb5Juyw/6KLqjuw7YZLva33o/33pDhi4q9b9zpytcvi4U+DrnNhby?=
 =?us-ascii?Q?Q+k9MuP7KUjvaKHlWZj8uC3MKzbuIHOnkInSXELGFvnWaUOqwblcA1zB9rD3?=
 =?us-ascii?Q?MXH9YzTRX+e4r2iT8Fr6uy6235xZPiWWmDOmL81lwDB9SdVoatJQaXSLEygt?=
 =?us-ascii?Q?RSrnK6cyRTXLNstee5uTjRRDSJDwSOsJgnG17wWyuHtit/UMXvs04PZo1jIf?=
 =?us-ascii?Q?iU5eEFV02NCQ/3ZHG93xgYfTuqc/pTNAiSTb8IPItUFVC5q2PZiw2bOU9htb?=
 =?us-ascii?Q?ZzndqkXmQZXRzDAelBXsDBeZvudzFoXT4KHRB+n5Y16KvsJzZSz7W9+m5MXs?=
 =?us-ascii?Q?MZTybFJtCs0qrrlOcPEs3m+QH8AGKunNzEPx2PkEJsJgZeroE54f6UevqQ9J?=
 =?us-ascii?Q?pUkyx+BcFajlxbTG7QQRFg4I1eLmZQqFfdHB5ZYUHe25IZ17pDT3AUqJVw1l?=
 =?us-ascii?Q?EmKHwIg4XAU6mRK+5XsR0FcC+URYcBOKQlQ7wuK26Xrb+cfvvgmtNR6Z3WfH?=
 =?us-ascii?Q?3VuMxy3rrRkZFIArNeoNfi4o9GC5qM9GRgWdzwOBv8+Nz3CvOpyWVrrDyoYH?=
 =?us-ascii?Q?SUFU8k0vTvTnuK5fJm2IhfdHuJuyqL12yzJ3KQqnpLZLduT1UDEEn3uBfnL7?=
 =?us-ascii?Q?sOu6YRBizEc+7QyoKPqr5fQa?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e5751ca-89f8-4c9b-db67-08d9222f9a8f
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2021 23:23:30.3384
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yeo9LbK7uvEPV6a8Pnjqgx4L7LthlDcAYS3cHdhqU6tRTCfXdTUICSOcL56CUz81
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB5538
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sun, May 23, 2021 at 09:12:06PM -0700, Bart Van Assche wrote:
> Hi Jason,
> 
> Please consider the five patches in this series for kernel v5.14.
> 
> Thanks,
> 
> Bart.
> 
> Changes compared to v1:
> - Reworked patch 1/5 based on Leon's feedback.
> - Changed __packed into __packed __aligned(4) in patch 3/5.
> - Removed the mr_list variable in patch 4/5.
> - Removed one if-test from patch 5/5.
> 
> Bart Van Assche (5):
>   IB/hfi1: Move a function from a header file into a .c file
>   RDMA/srp: Add more structure size checks
>   RDMA/srp: Apply the __packed attribute to members instead of
>     structures
>   RDMA/srp: Fix a recently introduced memory leak
>   RDMA/srp: Make struct scsi_cmnd and struct srp_request adjacent

Applied to for-next, thanks

Jason
