Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD4E24216E2
	for <lists+linux-rdma@lfdr.de>; Mon,  4 Oct 2021 20:58:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236440AbhJDS7t (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 4 Oct 2021 14:59:49 -0400
Received: from mail-mw2nam12on2071.outbound.protection.outlook.com ([40.107.244.71]:55265
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S236851AbhJDS7t (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 4 Oct 2021 14:59:49 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k0+E6M2Med6Zhb1ElXtiDVo4ZKCphiamhFpnWG9dh71+DCqXqrhHljnTIFYmaAUILHt/Yiq5wOv+jCDHkQkb6oox7iKKVgeG4WRxXTtuJeS6x5voYAzJVNoR8pHYEJKHsaDlVDhD0+UDFuebRR48YzIJljE1GAklH4kjZ0jzANid56e+Avd7F+pk+ZMDR+mkkuOOglqKnIyU0WJKlVuz5OnMiGtlfTI9lIw+Ql3ZV78o++66t6QBuRjm9GJ5N7/NkkPGwg8g5bvabub7kn9owBJYtYqOl0/WgPNI0vebHk8b2gTbUZnO61JdRJ1F1zTLY2viuLzN2oO8IJ4ArAw/oA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vcCrM9d3wL+zRkqwmPvjsU2XbK/GLvvr03sxSOG4x/U=;
 b=NwIl0gCaX6uxXno0hufF2oktczx9zA1VfcqC0+JQu/DFFGUQKpcUwGWKqi7OIeV8KgaDYdGTZwPclhWF7/AodOh/5GJTaEmYGvw07kZ2+6W19bEmMkilgTgcfMBffxKeh4x6gwQ4tWmeUdE5KRMibTS0gMYuTeIoeZrWvKefE9IkoQ3UaTFD1t5nRB8r6jgWIJ3jPziZgv4sF6stn8nwdWUd+1iattvI91L8fUnmN72rrLQQF1VXntYQYUKJ3rPa7lWj4u3UjApc3Uet775HiouYy6nZ0JUeSKcv2ZiH2CtiF1ytEYtlB0AJPdxXhJaaa/JqkfBY8MiStqHety1VWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vcCrM9d3wL+zRkqwmPvjsU2XbK/GLvvr03sxSOG4x/U=;
 b=PrGVJ+ywQeARQexjOvhS8CB2kLpVo3ZVe815rsBipfD4P6CQlKW8W/SFnNAk5bCo2r1dH1iXQAyeowSVOy+RJ7CckF6KWlPocvNlKT0svfC5jIocxib/v/q1j4loENY5g5N1wu8JmS3JkbHZgBD00sjrLeA75//18tEqWAiniq55mOYC/YTiVUCSBXTqCnMGXMR5DRPnAKq8Rmpk2+cSiLUu9ewi3XxNfag4Ljd11EF3QuEvqzfWhvTY8+GhsmPEVexgyeSGVETldXQ2I3XkD8m/Vca9ZbJA9IlHjjyjvmVCjdxdjfIol+ZnNgRnjdnQLVMxmEhTL+n79XYeKlCYZA==
Authentication-Results: oracle.com; dkim=none (message not signed)
 header.d=none;oracle.com; dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL0PR12MB5556.namprd12.prod.outlook.com (2603:10b6:208:1cf::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.14; Mon, 4 Oct
 2021 18:57:58 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::e8af:232:915e:2f95]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::e8af:232:915e:2f95%8]) with mapi id 15.20.4566.022; Mon, 4 Oct 2021
 18:57:58 +0000
Date:   Mon, 4 Oct 2021 15:57:56 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Rao Shoaib <Rao.Shoaib@oracle.com>
Cc:     linux-rdma@vger.kernel.org
Subject: Re: [PATCH v1] RDMA/rxe: Bump up default maximum values used via
 uverbs
Message-ID: <20211004185756.GA2534043@nvidia.com>
References: <20210915011220.307585-1-Rao.Shoaib@oracle.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210915011220.307585-1-Rao.Shoaib@oracle.com>
X-ClientProxiedBy: BL1PR13CA0417.namprd13.prod.outlook.com
 (2603:10b6:208:2c2::32) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
Received: from mlx.ziepe.ca (142.162.113.129) by BL1PR13CA0417.namprd13.prod.outlook.com (2603:10b6:208:2c2::32) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.11 via Frontend Transport; Mon, 4 Oct 2021 18:57:57 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1mXT9w-00AdEc-Nf; Mon, 04 Oct 2021 15:57:56 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9b8915c7-be2d-44d0-aabc-08d98768e151
X-MS-TrafficTypeDiagnostic: BL0PR12MB5556:
X-Microsoft-Antispam-PRVS: <BL0PR12MB555682132B60D8BAE05EB7DEC2AE9@BL0PR12MB5556.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VhETJsbqwjruWzlLzY0ywt19aeUSBp0SyHN6RIL+TmAN5fbcUH8js7JssUwkiRUgdB7moVZNClPd24UuZbez6Qinubltphe23YOg3QS2q7B0jRUdFB3DPXi2V+4gg5nRH9858yXm6UTKlfqfF/oVnVGKOJEaXf/jS/VYL/Pp3J1QcZmqL6jLHNg6iFPpb2I46HdAhes4NmobqJfpZ3t1J0ejMY88qQdVjb1xccUNjt6EmOLiaqrquL4SXq/lE191B/1EbxAbwHe2bRm/jpPp8WX1zAzz5dn7W8LHXOUESSjlKNeBGeCKx7qS7C1H7gb7g0L264xclLPCcOqXwgXmgzXIMf3OJtkSyof8P98WS/9F1831Rcoo7GJHtmjhmkqW0UYVE0R+vP0y3aYILaOPa1f707sMQTWfRX6qQiUoaT2sPAECrsiu8aID2CiOF4VIRgzOZ4PxZBDFm+FPtYNZNCL3MaAY4mtCeIPykNN3yT0r8B8lXdQZv9l+Eew79bWFS8hOSj7ZckNn6sO4sfz9KEkwreqn4XLYxH6chUnGY72DGYHBrQDaoy5P/go9w4OppfWERXQ11YMT6oWXY0FFl+S+aIG046UzZf0HJzTQqwRleHrUEKivCU4NG4MxPKGjOishmhFQ757LzkaWbwZZIw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5506.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(2616005)(316002)(8676002)(426003)(4744005)(508600001)(38100700002)(83380400001)(8936002)(9746002)(9786002)(2906002)(26005)(86362001)(33656002)(6916009)(66946007)(66556008)(4326008)(66476007)(1076003)(186003)(36756003)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?mBHHwNun8vik5ksv2Ajzu5jDyI9dGaDkHvrDmvLpyPfID9k1uLXzoUP9DJSb?=
 =?us-ascii?Q?YI/A6Ul+vmx6PVcvGwbvDxEG77WOTQvGE+5RnGj5y74DmgEI0tbwr76CQGO9?=
 =?us-ascii?Q?D/N83uFtLv/0iEV13HhbDarjqOoFEcK0yswLZkPtsyr8k6ct/NfxTeX5fNI0?=
 =?us-ascii?Q?LuCkSNWoMohX8IcmqTYa/I4jluCRCtDntmvlT3BZYZkklZmgpCty+n1bC3yx?=
 =?us-ascii?Q?jeA8Xx6nshQTxf2oPsqVWmE96Qm/r8O6PLgcjwnRScc8j/TD3noaTEFfyB//?=
 =?us-ascii?Q?hwVI5ky1VKKsT3ClbWwMa7wDC1uujw3vV2vUO7BnpFeQsPKLF+8XeS1OZJ4w?=
 =?us-ascii?Q?llpITE6FGtJfgeK/1TWWdln8BlMbkFaxJjptSVFV3JV26IgnzJcUzNludIyW?=
 =?us-ascii?Q?E8zOBW6If2Q1p/lRGbglj/cbZb11Fk3450mRRroo66iIuRUunFGHSAJ6pXnV?=
 =?us-ascii?Q?67HfawH6Urrwf5C01sJ7jTBoL5oIe3GhYMpKzEDvWV8TB20eqTdJJk6CHsdD?=
 =?us-ascii?Q?+h2ljoJ+nAu9zWD7jj2f02Vb5lK9Rfy8zILxJ1KqwqPnb6kIUT4W4OPMK9hc?=
 =?us-ascii?Q?/d8tuDf5UD0mgYd9zOAMc1joOEHBLy9ztVAQECXQEHaFUs0v7FODqaBxvg5Y?=
 =?us-ascii?Q?XJhq6l0Cb8QcCkO1jgU3qPH3gzFTXZWWSgGe8165fNE+ar9oKLZl3R8IUoGE?=
 =?us-ascii?Q?le7o0gIrUF1iV4MSq7CbrDn50b7tm6hMSYCrIe1q+uqq+V9eS5ERSWSGaGmM?=
 =?us-ascii?Q?ETSS2L4GDssma66AbRnnCFyiG7vZdppC1lJR8SVlspBYeJqLwdgSXPJMGWun?=
 =?us-ascii?Q?4SUeycXXzZ45qmhlvj30fm5MlUovqLNr0IT+U+gmdg85VY5ygvWcfg3B8tpb?=
 =?us-ascii?Q?zoSwtWMohchRm27JzZxargoRtbqiw8TZIZLoLD5GkOTh05tEC3+0SublACNp?=
 =?us-ascii?Q?l2v/1X+P330KF+KSGUnpTSyp7SDo1ioJuWEGVERHcmI3cRUIMPIXQboZxVP8?=
 =?us-ascii?Q?OGNSY3+/dEi6AHsidSrPgg5sSkhcATBgejIN4ygoUF2Amd0rjLE0EfZ4Y+q9?=
 =?us-ascii?Q?lQu56zsZBD6kDZt02C8HqJRuz0y8M8C3F549XgcpxN7nSDeiD0+hQJs5qglK?=
 =?us-ascii?Q?GvcnaA9Fh369NiostqBqTZtHdHefeFylaxxrCpBHVZtX7+/Tu7wN5m6m8IP9?=
 =?us-ascii?Q?hWKL3hTy/RbdoknNzeexlhwYGpBXR1mru48D6Fgq/t392G+67Xnkf76UYIbe?=
 =?us-ascii?Q?nt2YUFQQ97GABczLvp3F8m7xq/Tw4G48TGLyE2Amggkl4FPFVdLMnL9EeBTZ?=
 =?us-ascii?Q?tdv0bo/U9Ch6bS7U9s0OhrGZ?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b8915c7-be2d-44d0-aabc-08d98768e151
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2021 18:57:57.9605
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yaAmVxsSi3PLouvNPUirvpBp/OPzpKrlyZAUUlXnBr6NUuN011t9xcf4tG5q8jW5
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB5556
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Sep 14, 2021 at 06:12:20PM -0700, Rao Shoaib wrote:
> In our internal testing we have found that
> default maximum values are too small.
> Ideally there should be no limits, but since
> maximum values are reported via ibv_query_device,
> we have to return some value. So, the default
> maximums have been changed to large values.
> 
> Signed-off-by: Rao Shoaib <Rao.Shoaib@oracle.com>
> ---
> 
> Resubmitting the patch after applying Bob's latest patches and testing
> using via rping.

Since nobody points to something wrong with this and Bob says it fixes
a blktests problem..

Applied to for-next, thanks

Jason
