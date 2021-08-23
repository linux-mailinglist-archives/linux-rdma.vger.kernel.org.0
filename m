Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B896F3F4F86
	for <lists+linux-rdma@lfdr.de>; Mon, 23 Aug 2021 19:32:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231381AbhHWRcw (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 23 Aug 2021 13:32:52 -0400
Received: from mail-mw2nam12on2064.outbound.protection.outlook.com ([40.107.244.64]:4961
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229471AbhHWRcw (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 23 Aug 2021 13:32:52 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AzrosxeTQJNv4e3eDGk3jhJU5NNYMaic+m/jRyc0I9ClWIiPHLyVNCqHAVxO9+07MWDdGbTJGX979XHZwO+R1nqLuizDecfcnxiZsVpjRmsJAPmG1ZAr5xcR4mlwfS1MfP7u4RWqASF2yHeqJL1Neil+j97dDM25RzEh6GNFFuuPiwEiTcNXBBgJPM6SXpm+ZYJdtwSfBkRaTpkOrJG3qjykgcLF8rLEBAiNqYyaYinbp2CmvMDZgKAwmOfSyQBnX406sHsUiQbAFrEgejw5sNY54Chja/l156jb6kybiUJUQ+qP/wEL8VAgSnuZJZJtExGtkHQm4+MMNeOxPWJAvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oT/kJ/PWCq5mFscsGMyFawY4JpSCygkLqb09uRpuBlg=;
 b=isGyf02SEO2DlpUFOKXb7DC3yv+uyZxFYV3d0gQWQpgc1GypX5he2HB9xXPgNgWg7jvVLapcvj8HPZg7wr2wq3kT+9Mv4Pz9qD/ooKACgQjCEMOLmgvlJP42Bns0dFyF2B7d8652jbs/KiATznCepKVnbOp4Ofyg0ZbFTH9SQZlPIKRk3DRYOsBxsUj16GjA/Fvk85S/oOmRTncrB+2iaRFblec2MC5dUhCqcNvHX/6jQBSPVUmDJrKqmL5jcjvY+nO33zBXAC8tB+PpV/FQHtsEXdUYLx6VAyj283yVsdJOuKBfmAxeN7y/MEu22VrChljzc9ECVYXR2zZECTu2LQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oT/kJ/PWCq5mFscsGMyFawY4JpSCygkLqb09uRpuBlg=;
 b=O4mytbH6DoN4SayiAMBRKsp0mTL1yyc/9mBzAnbqZHKlbc68UKV1sf3x/M6eFVvlCwKXAyYiRxY+xqBCF6GY5LUpCGtGsbHdSY/DUcgAFSfMPXB3Pq+vShxtkjGG9xuSI4npyXTnI24a6u5wSCU//ZXeqHvOf58TU2KcCIlBcx5MK3kCv6gstDlYXsaKtV2MS+ulxAQzWvMqx/9BWohvuuZDSETPLPDmqVaiXRwc+eq0Q4bdQ8/Mx/rIAT3mW9+UuA/TzK5ymSFtGvDGcxIE4wYwEWeYzyaGJ+6zAK4vN26gt4x2oEoHm+loDY8aeY+A7v+TR7Uh/Vzr92GKNLWdqg==
Authentication-Results: acm.org; dkim=none (message not signed)
 header.d=none;acm.org; dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL1PR12MB5288.namprd12.prod.outlook.com (2603:10b6:208:314::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.19; Mon, 23 Aug
 2021 17:32:08 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::1de1:52a9:cf66:f336]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::1de1:52a9:cf66:f336%8]) with mapi id 15.20.4436.024; Mon, 23 Aug 2021
 17:32:08 +0000
Date:   Mon, 23 Aug 2021 14:32:06 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Bart Van Assche <bvanassche@acm.org>,
        Leon Romanovsky <leonro@nvidia.com>
Cc:     Christoph Hellwig <hch@lst.de>, linux-rdma@vger.kernel.org
Subject: Re: v5.14-rc5: KASAN complains about use-after-free in
 __ib_process_cq()
Message-ID: <20210823173206.GQ1721383@nvidia.com>
References: <eac61295-05d2-98f2-eb32-280ffec8269f@acm.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <eac61295-05d2-98f2-eb32-280ffec8269f@acm.org>
X-ClientProxiedBy: MN2PR19CA0069.namprd19.prod.outlook.com
 (2603:10b6:208:19b::46) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (142.162.113.129) by MN2PR19CA0069.namprd19.prod.outlook.com (2603:10b6:208:19b::46) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.19 via Frontend Transport; Mon, 23 Aug 2021 17:32:08 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1mIDnq-0049wV-Rw; Mon, 23 Aug 2021 14:32:06 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b2f5bc2d-bc61-4e2f-4953-08d9665bee8f
X-MS-TrafficTypeDiagnostic: BL1PR12MB5288:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BL1PR12MB528846EACD4D2CD6C6719359C2C49@BL1PR12MB5288.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2512;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yY3QYX1fgxrM9a+g/MxXI+TFCU7eJMpoTqDUxwnsJolaDccY5MYdBnG40zg5vjoCEW9kMkE6i4RHQlEhuBJ/EtwYaNcfjGw2lxMypMyqrZw+m9luY2AIprLlawwpYh7CRgoGGcvaBUy/YS8pEc/XnuX8mjANDnbEK/wTxkhacnxZAUcV0EpPRcQzGDZXeWj4d3IkcsXJthsER6YgIueM2xzH66Jea8WbEW14QsHHKRzULQv5cnc4qHNG0r7xgWBm3XJT6va4nJqIOLNeUzE9ZSpRbx/0v4LJ6XM/PWr2A4UmtELPFfo1OChrer2XduAJ2bQEGXypENwQKruOVbrjhJJUwMxcwIoZwFq2cshQEvfXIWTCCUf2bJAaPtIkshhm5v76+sw8qtuCs+CYU+GmXi6E4gzi+NQKKcK/8kjfJl3JlN4VlmSJT9ya+F68uyp1UbX6S1T4rC25ZpN6+51JtkrdqG6/iHgeZppHiXCIQ7kXkFA9jeTDx7H/xwvrz2R3sJ2wLJ590Moo5MntRM0/JeyG0DzPiVTCeULp+9ifbx3HEDSJ0oUHgta57sKNNGFA+Q5HTmh9Kv7hMvvWWZdTf5o3g7VLh1I5AugbpIAOOeU/vlzRo9q4A0mS5ba4Bh3KZSE3rHyWm2tfdBeKC9c5Kw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5506.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(366004)(39860400002)(376002)(346002)(136003)(83380400001)(6636002)(66476007)(66556008)(66946007)(4326008)(38100700002)(1076003)(478600001)(33656002)(36756003)(8936002)(9786002)(86362001)(2906002)(9746002)(8676002)(26005)(426003)(110136005)(2616005)(186003)(316002)(4744005)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?GcCwOmeIhcOOF7ZtGXgO666he+5Olu9Rv7mIN03sQYZ1gxX3/atGPCi2aThF?=
 =?us-ascii?Q?qX/M2BZEKaerXgRO0ixKq8Ih2KFbXJjFSZMjvyfumbazh4xndwfIyc6se5Bi?=
 =?us-ascii?Q?ZI6BZXUeIjjjjCAaDhxj3iabSx3cEguMt+apzrhVv5rSmmTRBpfB0iOnx6j/?=
 =?us-ascii?Q?pfe2k3YdJ+3hdp1N/3mIpnSaw4WIEu5vT2jhHKjQa7DPcFv6wx+u2eVzmRyt?=
 =?us-ascii?Q?WtmhSlbxUvuVLD1TvH3ch41KwBEyct6GrezKJJd7PaUDWiEaB8/Tgbxt74DE?=
 =?us-ascii?Q?LLXO2m6vLS1B8zsnJPcbJNwJhdDo/QkjvFNVC3G2cjBqSnTOsThnAJGBsTCI?=
 =?us-ascii?Q?R0S+z/u11iuIwdEfeWwbaVLd39g+5rULpuXVyoSseVGjkHEw0FGYAchudp+3?=
 =?us-ascii?Q?P9izPXwpFyJTHzavwTC01uVzpI5AMsje4Ah4v2aIgDPV7CAzlHoRtw7FT0bh?=
 =?us-ascii?Q?EaUn2suAsRVg9UljEfQr8CjFKKwphhdAg3PqqTE/W4gibhWntY6U2wljX5FP?=
 =?us-ascii?Q?yahsAsmtoUhXrOIRs8vML+/5XGDm2Vtx84nfGVh+3ax91u+6NwOqUSga38w2?=
 =?us-ascii?Q?FOAyB0EFbkJ9UFXZMFei3p3khZjR7KCn7mb7SwG7cgbfUFz85sW709AZyUQl?=
 =?us-ascii?Q?SL8r2wzZsXxn9h/hiltcuYTI8nUolPNU8oyoWeJ+8SnjqEbKresRQ82XM81c?=
 =?us-ascii?Q?RjaZSywp+WUWw9zE82C7Ga/yR2Qkjxq3cCQMCKD+4Gg4xIyr8js+iccy5ppF?=
 =?us-ascii?Q?hbrhBGS0kn3zHWrfIhE1h7s95fHQeFiRfA/dxBQBZ3IrS4YIrgWu1ECAKGTQ?=
 =?us-ascii?Q?0CX9Bn6VktK/O8dVwsHkxOZZRm7uGfhLrxEOfM1yqGg86KFh63ZfvbuAzCzo?=
 =?us-ascii?Q?9mLPdtwsyZocVrMDHkasmB06Y/U2894ofv5zvYM1U57uxCqtVpag8iU60ic3?=
 =?us-ascii?Q?Ab+FEkjbCoRsOiyV+f5UOZAD/hC5C2lvcdYGbnQVoSVeGUnOM/BRS7wPOF76?=
 =?us-ascii?Q?Vp//xvA7D2itGp/HXD4mVoDrGEQpxVpRef0RcnMI65kTU+aWzQl8odfc4EkY?=
 =?us-ascii?Q?H4HCFBu5jkUl9Gyb+j+htNMeZFx1WYIyxFNCxgtGFAxFlR++9mlBlxZ1+qc5?=
 =?us-ascii?Q?kWJfl9B+MLs5twFR04A8N+B1qKavKXq9xMG6Sv+DNGXw2KHBWDZxjz3SGDfj?=
 =?us-ascii?Q?I910XJ56FsUT3qed8GJO9Sc0Ut+gfnk9pMG6xPmJna9dE4qvfdpuyaFys2Pg?=
 =?us-ascii?Q?hjXwM8yA52fgzBJlJLjEvo0P6iYMQFw3PkCXn5r9NrTq0eNqYgi912MMiqKB?=
 =?us-ascii?Q?9aFI6s62eV3neKpLhyIv3hGV?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b2f5bc2d-bc61-4e2f-4953-08d9665bee8f
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2021 17:32:08.1603
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: K2e/vSmtY9T0FLLigQAJdcfUz0pBWDyYHpoT/45IfRZwDjN0+ZA4+EYZWag48J5r
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5288
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Aug 23, 2021 at 10:30:39AM -0700, Bart Van Assche wrote:
> Hi,
> 
> If I run blktests against Jens' for-next branch (5026771bd46e ("Merge branch
> 'for-5.15/io_uring-late' into for-next")) then most SRP tests time out.
> Additionally, a KASAN use-after-free complaint is sometimes reported for
> __ib_process_cq(). With commit 4b5f4d3fb408 ("RDMA: Split the alloc_hw_stats()
> ops to port and device variants") however all SRP tests pass and no KASAN
> complaints are reported. There are no changes in the SRP drivers between these
> two commits. This makes me wonder whether a regression has been introduced in
> the RDMA core? I have not yet run a full bisect - this is something I am
> working on. Please note that I may be hitting multiple unrelated issues -
> there is no evidence so far that the SRP test timeouts are related to changes
> in the RDMA code. These could also be caused by changes in the block layer.

Maybe Leon's QP rework?

Jason
