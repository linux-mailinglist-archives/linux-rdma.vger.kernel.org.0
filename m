Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D67634ACF6
	for <lists+linux-rdma@lfdr.de>; Fri, 26 Mar 2021 17:58:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229986AbhCZQ6K (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 26 Mar 2021 12:58:10 -0400
Received: from mail-bn7nam10on2081.outbound.protection.outlook.com ([40.107.92.81]:3630
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230070AbhCZQ5i (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 26 Mar 2021 12:57:38 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dCUgOJDVv0hXPetgX/jRZDavEal5/zUFKLKOCajzPOKZgKECHYM+Aa5YpGclx8dfqL7lZ+G3JxNfGlEiz2CWhqLdD/KBQCBJEJMCiLCDcxb9FDc8L4hgAi+2RFO6NaAL2lKmBLBKOB04CmfAZv8HnCx3FcvOhIAJ6U5aYxzVzyGX5l2A4NWbwQTNGMESmd8Y0FscbpRyw9VI5BXFPmLUrRVg8DUy6uq8qzzPSn21sMQEbLg8/hdrktBodoBzOBr/BcnTXd76tqcV6xqIbo7+iWFl/3H4ipTxyt7Lun0/CY3gDHQxyP7lCYvOcqMAW35kSUr1+V+sGt+ie9AfTipxnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JIFxNChYzL0VIYjpdxsF4xPvngtUpM3FGqbX61d0i+c=;
 b=A2UeFmMyrIxLFsxCE1xdL6r6s63U2MCMFsYSIhCl/Wtzg2tuBNbP1I9l08mwrWAPYLvCRDMlgwSpILfOOtcSMTvhILolmxRa8d+q/3GTdTNSPNM5tCkU5CgFa2o2AREEryv4aabv431MOJFt9D9CyeykFNRmBIhhDZOMbmAISrX5AilAd+Yh5wyiiisGCMq9Q9got/3sHCp6e+17OSFjEdRnq26DVat+WA9qTus5L++P3ZE4ywOS6BtTUrOI3arKQnlzyowa6YIPwjHPK47eZQcInxIArFNyl7bnnpdedh2XuyhSPwoNzZxb6SZSNHUUJKWO4EHn0NpO51UdD3dZXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JIFxNChYzL0VIYjpdxsF4xPvngtUpM3FGqbX61d0i+c=;
 b=i/lIm7RHUOJ0e57Nhua15w0WuVqScg9qSDKHDENrM21zlONkc3oHogiLLqb0oYKMR7e0NmQrSxxM2msRisSfjwHFscNFElUgwfcGzD3fmasu6OvxLbiy4YJAOrE38sC9Ov+YdO6LcS9mxrUBnjM/4kjpMwJn7JgQwuBPDqE6WKcUXl3WSDJzr9/nIJZuXPOcD5repdhEhPEtoxI4HKz3xURn2TbvW8Miy9cPZg5rKC7TN9xvWXC4f2jFXufC2sqgL/kxYhRLzbZztcGuj7A/B1XvsvevjuGgl4CJpeAot9YVj5zy+UgqxRrtP9uSXeYsTz2qbEXJ+FSm8SbbGhMOKA==
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB4943.namprd12.prod.outlook.com (2603:10b6:5:1bc::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.25; Fri, 26 Mar
 2021 16:57:36 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1c62:7fa3:617b:ab87]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1c62:7fa3:617b:ab87%6]) with mapi id 15.20.3977.029; Fri, 26 Mar 2021
 16:57:36 +0000
Date:   Fri, 26 Mar 2021 13:57:34 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Bhaskar Chowdhury <unixbhaskar@gmail.com>
Cc:     mike.marciniszyn@cornelisnetworks.com,
        dennis.dalessandro@cornelisnetworks.com, dledford@redhat.com,
        linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
        rdunlap@infradead.org
Subject: Re: [PATCH] IB/hfi1: Fix a typo
Message-ID: <20210326165734.GA859519@nvidia.com>
References: <20210322062923.3306167-1-unixbhaskar@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210322062923.3306167-1-unixbhaskar@gmail.com>
X-Originating-IP: [142.162.115.133]
X-ClientProxiedBy: BL0PR02CA0102.namprd02.prod.outlook.com
 (2603:10b6:208:51::43) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (142.162.115.133) by BL0PR02CA0102.namprd02.prod.outlook.com (2603:10b6:208:51::43) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.24 via Frontend Transport; Fri, 26 Mar 2021 16:57:35 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1lPpmA-003bc3-A5; Fri, 26 Mar 2021 13:57:34 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: edea2ccb-8b34-4f73-0967-08d8f0784146
X-MS-TrafficTypeDiagnostic: DM6PR12MB4943:
X-Microsoft-Antispam-PRVS: <DM6PR12MB4943E61966C06ADE69E58351C2619@DM6PR12MB4943.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1468;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OXFf26Zd00+GM+Lxn9wZep5ifytK+cajUrM1sM/tquhg3yOy2aPiny/mlVDicQh1v03UFFK+GRlXG+4qlsHcvCg5BoDtak3OkQtoIBspNabcM87cDVnKGqDtMvgw42AfFALWMrrmm2dp5PLMvYQQf/kTFVlgJfpS/0DdHDoaORreG2Di5023cr3cr3FH+9U75WgE+xaawbfr8HaMn0TNRsgpSAyBk5BkUOeLLAWvVz81aDlYD/2XTy9VkU2uHKr+BaAdEPNLMWLcaM5yqcA5gaQ73oNT/+2DVsGVJDFhTdqOb7k+nLQ3w/oUpnumKufWSKJvj4vUj8BrbJxkg8ODkFkwQJAj45DpGJHAInBW4S1FWDu4+Bgapfva9V7OhfAKyFMypFzhv7NOra4bzHhZCF+FNkvsj2KA/chMUrfhKWN70pf6U7WXcCAl9uiv3TZPfor2h6Sh0fdOAmT05hKZbi65u1/eP1ziDTHAQQadi9syorxKZHGtq5CjNOD6Rg5c7VLdNufjCxJRiwJgmi9CGa/0YL5iQyKssM9UpfriwKQPOHudgDyZmUooqi83tuiiwoEIqU7sgdkBcLJ47VyrNvEXRLzCw51+V413Z5tvVG8YVaGPQ9WphuYihWFOxRlsD9TCn/khgXJBmq9nBAmLvSz8BsK6znc/FaE+kBRAsm+q9ozdFpiLBesqTSgtyQ11
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(396003)(136003)(346002)(39860400002)(366004)(6916009)(478600001)(1076003)(8936002)(4326008)(66556008)(86362001)(9786002)(36756003)(26005)(5660300002)(4744005)(2906002)(9746002)(66476007)(38100700001)(186003)(83380400001)(66946007)(33656002)(426003)(2616005)(316002)(8676002)(27376004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?ioeJ1tIXNTJEWlUTzQiCw5/pk6WpT7WN9X8Lqw/za2MNPRPNdqW6YXNroVvz?=
 =?us-ascii?Q?XLyWG7PCi7zXiPJ4VtxQvjghzXeecSSLaEvBnm5sfyzAjur/xnhVTQyLobHD?=
 =?us-ascii?Q?6fnTIkgu2JZCNJIgihTtN/tn3/Z4QjnSyNBynVqtAu1V6bvF3h3474+ybzhD?=
 =?us-ascii?Q?WzoTHwDKFfGZPz2GTu5wJSZnCvpO+QezDouvktWjAbW63IsTA8FTMeWL8QkY?=
 =?us-ascii?Q?Rb0lARDBSGAXuxFNVngWhHuhcrFcFV58F5XkWZ41cQsSt9nue5ypwsvPE43T?=
 =?us-ascii?Q?bwFx0Oj8q39JRtYLeBIdZN5vz9jsPfWKZQKU6/Pxa0r+YF6dcUT4P67V9fUc?=
 =?us-ascii?Q?Fu6cKAkguupHMQ2UJQUhJBDvD2xnR3Vqzlx3/i4X4NJMITDfnUOlri3aGaie?=
 =?us-ascii?Q?yyL4n++riQ9aAIGYS23pD51LxByGem8qisYyyC8C9T4UZpsKlPyRRF4/KSUY?=
 =?us-ascii?Q?yPuAlRab2h+t4jJRF7KCLYtF3h0y+f+ClNjOf4lJXo3Dqgvmc8sfpaE8bPvD?=
 =?us-ascii?Q?SLe3y3D/dRB65v4mbX8xhrhKlMQIPiJEHCGYJqzriUI/uq3+RRWQudSwOQN1?=
 =?us-ascii?Q?1zwMbPtvMYsGCmAZDQb9ozaUsv+iGnh0Xxhw7oXIPNZJY2uuaoiEtObQL5l0?=
 =?us-ascii?Q?GPith+KaaiUWe66yl52zjQHrYbk5nWuQecIY143NCsb17BOt9YXlIaAIcqTp?=
 =?us-ascii?Q?0X+qh0vQ6FYtfTf1DVDFCnn5ShWN0uykf+UZICbiLi+KoVdGWSsQAlKRW9hD?=
 =?us-ascii?Q?vRYJFSX7nfWrLXcX60IzzWJeg7wmEGHWA+AvtrslIHJ5txGJgFNEkWQ3vwuq?=
 =?us-ascii?Q?dh/mHrJaQZDePuYRnpCIw6zUM2Ndi9IxpHOOF9dy0bWVgAEyF5gDLrvJb3ye?=
 =?us-ascii?Q?qRb6DCAb4LDcsuvPtzJZVsCpn/bMgUGiPZmlwYdH0wBuwfUK/I+oG2x5qvri?=
 =?us-ascii?Q?tnJRSDGoK3tHc6KKTTl+jMahQT2azxqp5xSw92mYNJgLdRrWxH3nnlzXV8Qw?=
 =?us-ascii?Q?Xazoz2ZY6ES3sLI8qgp4At/yX5/7dv6pSt7p5kjrqaoZefP/Jhx0KzbzBx+E?=
 =?us-ascii?Q?CxNYgCm/SpwFIaaBTWcD79axNjI0bgYST2w/WT1jPrB6CuvcqFYPc6YXYngR?=
 =?us-ascii?Q?3Nd5WJDhFdLdUJ0IS0/2OV5KQ6ZVOiybvuj/V8Pb3Dk8LtpubQD0RTnkGv9b?=
 =?us-ascii?Q?8eQ6PDT0mkT7+LhQn0j79wrdFl/IeCbTgLM/LjFqB8YXNEJxjN0oSb3UjDty?=
 =?us-ascii?Q?H4MHF6E20AE6YoMMRJvASABThuRkCc5Kwm0fxMvglf7Coit3ck+nQbdM8QMe?=
 =?us-ascii?Q?vZyEfwMGXV4DfxvlfVCXl2sycARNOrw6H1k0RRnDSg/3PA=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: edea2ccb-8b34-4f73-0967-08d8f0784146
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2021 16:57:36.6409
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +zOaBNfd9S8eiYiWCuDEoH+lpFMUIW9Jf2B8y6fcA0c1Jxw95oSqIrl4asiwqfch
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4943
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Mar 22, 2021 at 11:59:23AM +0530, Bhaskar Chowdhury wrote:
> s/struture/structure/
> 
> Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>
> ---
>  drivers/infiniband/hw/hfi1/iowait.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied to for-next with Randy's note

Thanks,
Jason
