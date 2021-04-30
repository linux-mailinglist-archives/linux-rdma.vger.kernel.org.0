Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4508C36FC60
	for <lists+linux-rdma@lfdr.de>; Fri, 30 Apr 2021 16:28:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232622AbhD3O3i (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 30 Apr 2021 10:29:38 -0400
Received: from mail-bn8nam12on2057.outbound.protection.outlook.com ([40.107.237.57]:52788
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232619AbhD3O3h (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 30 Apr 2021 10:29:37 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lUOcwpUBJArkO8en5TK8uegAsam6zYPHhN+3JzU9bAzwxXAkP99cqZleFn4ju1Kl67tJii6imH0OKbfp7YGL0attqYM3QNY+OPpf22Dm0qwo4iCllHNwuYP6N5nZx/AlTqTnoXT8cBHaebzcg0aj24PAIYp9hpvBmkmnd6+YQqE5Vm9K7hfnaWMcnpRS7xlKMeCjsAN8EjudCx05sNRCEiBWd80q437BPcQJVVw8lDLHYa1KtHaJQZ88eEyGdrOWKVrUhXEfR9UvirlmySQLIcdsOerq77UIllamv0SGrpz1GjPPixYjqItvqeagZ/dISEWa0N6z74pvfLX41gqq7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qguFZneb1fOavwhVt1T+MV0mTTScFXAZTXKk0ky7hgg=;
 b=IPBw0WCYbaUIexHNS3mtJfPA7ntHHn2FbaVyxRmX2t6Hm8Ia08jIwBfR2PrGbPWlNjuZVogTAEjxjxFeMMXkDPI+PuiNiPeLqLRhimP90ByPn1+wT9l9GX35N3lCzkSe38wNhXBsJ44FSfxiKftisQzTByLzcws7nP/eX2qK9Z9vGZb+s4dTejkxyi6WrP258b5BwqEzZCjtT06P/b3ANekiXvZNEPtckG7j4rHTJcu1uUk0NuVqDz3mUvWMiCTWF3iAMHFejNrSwDiX7lkRC7zKpNX9KE4eFR/Yi0zDNXjecYCoxpquNGmtNjGDS5g8+GOhTl8Y9Wzb3Si2ugQSsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qguFZneb1fOavwhVt1T+MV0mTTScFXAZTXKk0ky7hgg=;
 b=dC2nl8HjvQMHSsGdNpFIVI5Gn24ChaEZ5i4LNw4iV0g/yrYDfH5G5zCOgTfK76xoSux/nc9K8tcs6PqB8dTuke2MZTzzOzHMlDJY7UwAczVSuR8IPsADir+7Yc8WrqtTr62uPpDQjl1O+Y5d2QdZKqI6ld4ZpjH1R87oNBUZimuAIKzebMslSJxX+WM28K9mqnnb2fUcmBw9DB4h1ApdkMKIvjUf26obsp6tc76CAfAN792XWW7e8+kYy9kqemoAnpRwA7CkBJZ33ky4E7JVd/bz/2OfDVI/AgzAONSGk8Dn/VZDTjHoyRktcE/OxeunGSUlQlAebUlVAXPj1vAsqg==
Authentication-Results: linux.alibaba.com; dkim=none (message not signed)
 header.d=none;linux.alibaba.com; dmarc=none action=none
 header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB4499.namprd12.prod.outlook.com (2603:10b6:5:2ab::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.25; Fri, 30 Apr
 2021 14:28:47 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1c62:7fa3:617b:ab87]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1c62:7fa3:617b:ab87%6]) with mapi id 15.20.4065.027; Fri, 30 Apr 2021
 14:28:47 +0000
Date:   Fri, 30 Apr 2021 11:28:46 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Yang Li <yang.lee@linux.alibaba.com>
Cc:     dennis.dalessandro@cornelisnetworks.com,
        mike.marciniszyn@cornelisnetworks.com, dledford@redhat.com,
        nathan@kernel.org, ndesaulniers@google.com,
        linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com
Subject: Re: [PATCH] IB/qib: Remove redundant assignment to ret
Message-ID: <20210430142846.GA3518700@nvidia.com>
References: <1619692940-104771-1-git-send-email-yang.lee@linux.alibaba.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1619692940-104771-1-git-send-email-yang.lee@linux.alibaba.com>
X-Originating-IP: [206.223.160.26]
X-ClientProxiedBy: CH2PR19CA0016.namprd19.prod.outlook.com
 (2603:10b6:610:4d::26) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (206.223.160.26) by CH2PR19CA0016.namprd19.prod.outlook.com (2603:10b6:610:4d::26) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4087.28 via Frontend Transport; Fri, 30 Apr 2021 14:28:47 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1lcU8M-00ElQ4-2f; Fri, 30 Apr 2021 11:28:46 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 94df1694-0f0e-4151-8e56-08d90be44427
X-MS-TrafficTypeDiagnostic: DM6PR12MB4499:
X-Microsoft-Antispam-PRVS: <DM6PR12MB4499BCC3BBA4EBEA127BE5C3C25E9@DM6PR12MB4499.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FYeC+Amo+CmBNPTaOWIDs8xwRsX+WFW7tfCSpI/jRZsq/XE4JXhmRKhVbBM0RDH9jNZ0OWoWQpdJdc6Eo6XJdG/oMi8SNNJc+JFunAJMwF/M+n2ks/7JgllRM42RWaQFETztcLS0A+p9q4PIBIHj5lV7ylfYtkYr8gibB7Uh+BxwRjEHCqDFATrt/kO2Nfgo1ekSGChbldFXmY8qS5p0ba8HY7cxMmKLs+3MPjFXhhdMo9ys7Opx39fyP6Y+B68yZQHXVkhpXwyq1jgmbM7a+GeJbB4V315FR2T2CSkeAMAknED1sWU3d54/VVo4RZWMyNUNM4b7ohpvDS7jMD1vLOd+58a40RARPuoacwSJBfWC+9nGzjVt4f63HsE4V8OsKRRuuOCDLP1iAYIydz8xbSuMiQvfWEeRFSyE28B5KnRi43OLmzbncyRHHrIJ8ZcOucUrmmYE6P3Ql8+FW68Uwa/yGyHvDTDtgno9HI+BlogCKPZ96d0SlekscVY9WDaNVkqV9VM89dbfmyif/icac2yFsKbi+8kp9XOXEl3Fo09uKfyQKXN2yDIEkpzmBwcEGEyCuJpWBlJPXXY7qHwZtTVL1UO+8dri9O0L4KYiyH8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(39850400004)(396003)(366004)(346002)(376002)(38100700002)(9786002)(8676002)(66476007)(316002)(36756003)(33656002)(83380400001)(66556008)(8936002)(6916009)(2906002)(2616005)(1076003)(426003)(66946007)(4326008)(9746002)(86362001)(186003)(478600001)(5660300002)(26005)(4744005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?d2cILjGZ5DWp2rFavDU6tCt9kdgCnQb8sPiOJgdB0YTGU8nk82yhajTtlz1G?=
 =?us-ascii?Q?G7xzvSFAqbWWdSZe2HQr/etxVE8PMx/gvQ3aN9XX4OLTlSCA8C/qQGIgQ3Sr?=
 =?us-ascii?Q?beDlTpRN8SU8xAtR2Ku5M13TIgw+MTdQaHyybsSHCWXYHyCyAJ5lnOD0ARV/?=
 =?us-ascii?Q?USM67Up+E3vUhmP0LPxtYxI1JAV4XHq6yTfh07NYrdFXeS2mND4M1EKfHzQ/?=
 =?us-ascii?Q?tuwb4r6M/Weni9zCwzqe9w4d6phlzNFQqbjkVlv0nhXXe5O2eTtJB5Roh7I9?=
 =?us-ascii?Q?zb5Bw2uYXJOwvwGXKukdWYf9evJDMgen/GcehCTxBQ+ZB0qkGnkdKwmj4l2b?=
 =?us-ascii?Q?elmiHMAGIJ7xxpWKPl6Gc+GS5ZIbWAHXnTE5eFC9+aFjhBcSd26bbt5F4um5?=
 =?us-ascii?Q?pDSRhF1wgmq9zIZb5PE+8oifiSdImwthqY1GfmKcBor5Cs2BFXqqg0bSRiof?=
 =?us-ascii?Q?reBjRCYqKvHb5yiRT2NPSc0vck9+ZHkURKRBrB8agY1BpZ2d4knu8EmoJ1sY?=
 =?us-ascii?Q?1sGPsS2w0m9oZKbdcjKnDkDNZJdlbev02Mc9F33isgfgUM8GlA8q8LW7Mupk?=
 =?us-ascii?Q?qstp7tStapyLHuIDSqrbX6hkwSTINsjIdBB7/BfJ4RkGzFcYfmyhmiON+0Lg?=
 =?us-ascii?Q?D73trNn+UCqNFEdCHYSO9cvnak+JJyVoiB8IveAGudtkG1s5wuStfDM4Ugzo?=
 =?us-ascii?Q?3AVm3rGr/mAfkMQc323Tdi1rRXR66q6sxK/hAa2ob2r/GAyMLUtvgsIHG7Mp?=
 =?us-ascii?Q?OuOLCcP6vCHiCfZ9GtEPDZ9lYWJ1lL2L7xowSh3oyJwFdvQQC9K+Ewyl2UYf?=
 =?us-ascii?Q?mSbDnL6TD0MeTfotXiugxxoRJ4PmLW8ja0UtrWMJNV0IrffWqruGpUlAZuTV?=
 =?us-ascii?Q?o2Xn8nkINADo7BoUl0X3N97kH5o3ESiBlK1SuxE8SuAknRKuC9U0rXiKi/xL?=
 =?us-ascii?Q?fySdmg60z5h9rl2Z+Yvn88pw8o4kh1PARO5yrPjOVpLhPpHBFEOMfPkEgc+S?=
 =?us-ascii?Q?f8piW2MJrWihEXjWHqkXXxVrxJhhUYz4z3Oz9t2nv49l/Ms022V7jkXQjhOJ?=
 =?us-ascii?Q?gSrRjzEXQYshLoSDghb4ksmO6PvaBzqMiPvM2KbbxpZBaYr1Nudmz8Xcqx8K?=
 =?us-ascii?Q?papyTQsfHghwuITVAzKupdQoQ5vqCxgNzAxPHKR0LKjUNFWhux99lkjuEmxu?=
 =?us-ascii?Q?Xf5ESsTS2R5eyaTJHPlfnRrxKf2hkjrRJvYiYzWBpSvP5vCg7NvNB4P2j8QE?=
 =?us-ascii?Q?HY/QB9UD5BSv0zgjxp4pZ+vVJHfqmAjNdXlg3kGr/xpRprMbTU0D5pBZoS+a?=
 =?us-ascii?Q?ATjnbQtCr3thUL+rbXkJ9BiF?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 94df1694-0f0e-4151-8e56-08d90be44427
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2021 14:28:47.6096
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rXNsjGrOCe7Zm+EJysDhFhTptNNLell6noDIWgx3KsEQgVfLX14BndnQYpiI3WdL
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4499
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Apr 29, 2021 at 06:42:20PM +0800, Yang Li wrote:
> Variable 'ret' is set to zero but this value is never read as it is
> overwritten with a new value later on, hence it is a redundant
> assignment and can be removed
> 
> Clean up the following clang-analyzer warning:
> 
> drivers/infiniband/hw/qib/qib_sd7220.c:690:2: warning: Value stored to
> 'ret' is never read [clang-analyzer-deadcode.DeadStores]
> 
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
> ---
>  drivers/infiniband/hw/qib/qib_sd7220.c | 1 -
>  1 file changed, 1 deletion(-)

Applied to for-next, thanks

Jason
