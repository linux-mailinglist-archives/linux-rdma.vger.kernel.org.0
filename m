Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C8FFC35D058
	for <lists+linux-rdma@lfdr.de>; Mon, 12 Apr 2021 20:29:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244929AbhDLS3R (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 12 Apr 2021 14:29:17 -0400
Received: from mail-dm6nam12on2040.outbound.protection.outlook.com ([40.107.243.40]:29537
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S245007AbhDLS3K (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 12 Apr 2021 14:29:10 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CzU885w86bscxyBhaF+6UygduZl1n0BXb9S1uWVw6SZQKsW/A1AN/aQBEpHiPTGWjwTnJjAvXJavkjzdwc/q7yrhu0lC7l8WtU4Z8+94dIqrV4o3ZVOpS3UbZYwagutgkltmz2gpnQ55fCLwF6bSJgR/okPyBMrrGoUzEG5Nhici2PFSLTirQrUezSYrCO2YX9tWIRh4Ls3O0J2/BewJKG5s94SoBnB8m7RQsDbG/l1YTpvcLh6qnVeJRxTNO+1suIZYoo8h3DmIogN/oPSdvCtwZm1BNNpOsug8fiXUfq5etZuN5H4O4kQVL5oYdtzFvrzIp3qCI+n+RxdJQCuVEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VmH8/AjNF7InWZoG97xds5NGwk4jdampc8yEyjv9z3U=;
 b=h683KczohzNgzBsdgwy/jmJXZShYQ4SUwgcLD+TYKqNRytC741rq1QYhWXad+Waf2F4uJLn6q+p/K732iyrC300TSrwa7h4cqq8Cnl1Gn+f0VbcZ3Y7c5CUZgvi/YAuwqOTfBAifP7zvvCnk/9CupKYfPVFV56mnXMZxQ/kMpiDZA8du/wrUo+ifO8q+3kxorz2s5giy4Qxf9fEi0BMKOdpUUX0DtkcOoX46qdCYgFuPCwVpygpGCsWwL1PKL7LUMKdkdVBKrUAJSMn1IlqCQrke7iK7HlQv8rWEdNgtrlq8BhtBIUt17vnfUrFzij9A4swf4I8K3JiB4YX1ylb1Zg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VmH8/AjNF7InWZoG97xds5NGwk4jdampc8yEyjv9z3U=;
 b=FXiVbLeEQuFtZRXSseSvwpVnwJ5/ZEJUN/VPKBTF3Yb8tCG+s/jMCTZYIb2N38n1QrzsWzQXUJ1tLlaMFlGoCmyqqjpwpkuEujwd7di/AxSugsYHyr/pjnD9yT9Mt4YuV9ZnW9iFXiasGG36AajM9VGTjajOhcVgp3F5Gsx9Nt9CrAumWiUVyHiYhhGFrxpYQXKcajRAFIAmVEQqQbJLMQahztH0NxVmrPdxUMH9v/kjAkSe8hPZGeLAkXuspR1n4DT98RYvkxlIYrE2jmDoydkfkYHLEkaQ/kSWDYpRMNie709gsy2//PmvnOQ3h6rIXqG2iJcHIEWLNs2Z9zfY7g==
Authentication-Results: huawei.com; dkim=none (message not signed)
 header.d=none;huawei.com; dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM5PR12MB1881.namprd12.prod.outlook.com (2603:10b6:3:10f::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.21; Mon, 12 Apr
 2021 18:28:51 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1c62:7fa3:617b:ab87]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1c62:7fa3:617b:ab87%6]) with mapi id 15.20.4020.022; Mon, 12 Apr 2021
 18:28:51 +0000
Date:   Mon, 12 Apr 2021 15:28:49 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Wang Wensheng <wangwensheng4@huawei.com>
Cc:     mike.marciniszyn@cornelisnetworks.com,
        dennis.dalessandro@cornelisnetworks.com, dledford@redhat.com,
        brendan.cunningham@intel.com, ira.weiny@intel.com,
        sudeep.dutt@intel.com, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org, rui.xiang@huawei.com
Subject: Re: [PATCH -next] IB/hfi1: Fix error return code in
 parse_platform_config()
Message-ID: <20210412182849.GC1158895@nvidia.com>
References: <20210408113140.103032-1-wangwensheng4@huawei.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210408113140.103032-1-wangwensheng4@huawei.com>
X-Originating-IP: [142.162.115.133]
X-ClientProxiedBy: BL1PR13CA0033.namprd13.prod.outlook.com
 (2603:10b6:208:257::8) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (142.162.115.133) by BL1PR13CA0033.namprd13.prod.outlook.com (2603:10b6:208:257::8) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.6 via Frontend Transport; Mon, 12 Apr 2021 18:28:50 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1lW1In-004rV7-Mn; Mon, 12 Apr 2021 15:28:49 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9be7d7ff-efba-439f-0d76-08d8fde0d1d6
X-MS-TrafficTypeDiagnostic: DM5PR12MB1881:
X-Microsoft-Antispam-PRVS: <DM5PR12MB188198EDC01A08151729B4A9C2709@DM5PR12MB1881.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3631;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: U8RWpargceIaNnNr/LFtPSu+1+FmNyXbI4Gv00q/iZwGkSy4HN2q+ELAfHZBUcLstjtWGQLjF/ppmFHEeWUobA9vhmhSQj/3mq8NV2X51btLuQ4TZM6QltopaHHwmeMk+ig7ZLfKIYzbP6Rbzz3gtr539eSqql71mwhvAoToKKyjs86pMeXzXxKnM+ag67JlIsIPO9gCsKCJy0v9UmE+eo4EueiLmwDYInUnve5HZWpI3B8JVSYXDIaiyuIFKA4SsLvL+UTuRh2lU9yZvAeobjlCKO5WeGmyA90qDBq7osxj4B3m7VoJ0dPgazRDJycrPur4IdtnqKExOL9fj2ldz8Dx4nKEgi1t7j7TaBdVWNXWd5nA+fljrPijrjhStw9AndgnuD1+NklnuR9BxetNIUaXSFONMVLLYHOcoIMAAeFXLPWI9VGtVWKQv5kDefxu44fuTvHNYz3gJHuCqlDQ/lby3XIRNxuaoHv/wrvEXASbbtRE7i9cNB2FYGETeQRv67FBWAGX3A/Ulu6CZv5sbCPrtd/ctwHII4u3hKXGQs2Z1TgiUiRsBTXNy7jknr2ehyuaCuTOkOxG+Cg8+ljb4KHy5i9dJrXMqOVqkbBB/tQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(396003)(376002)(136003)(366004)(39860400002)(33656002)(478600001)(4744005)(9746002)(9786002)(2616005)(66476007)(2906002)(26005)(36756003)(8936002)(186003)(86362001)(4326008)(426003)(5660300002)(66556008)(38100700002)(6916009)(316002)(7416002)(8676002)(66946007)(1076003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?RbZZmzjOJUh4Mtx4Z1C2xcmbzZBChOPktKwKOzWmRj52Ape6firoD+Rk4sD/?=
 =?us-ascii?Q?JY2ie2wHU0lwNE4bySMQqge6aSvWq6JkzB3GtQZz3/zrd61eB0lIP8+hJVG3?=
 =?us-ascii?Q?PqAAFqcgPr2wU9dgSFst8PycE3mYQWVR8GYe044LrMSs+9/7g15J4ZaiJPcZ?=
 =?us-ascii?Q?4No3rfD4DtBafeaVazfdudEokvmXm/oMKU5CcjFGzUnESef4Q5kgjJ4mglGT?=
 =?us-ascii?Q?1RFhq2jQYqgT4upzZYHDWQokJ2zXeOY0N48eG3q70h+fFYe3bOY3DoXpVP2W?=
 =?us-ascii?Q?xRbp56fXYrgkatQ8dvW0n0zdCy+EkyFZjYTDHRgmJsm5fvmGkMDGAbTqBOlc?=
 =?us-ascii?Q?JK30YIXNEkaEqp5owigUbQR1rEXtwEBSABPhmQjxibT2QM5IDGGNF1ncvf32?=
 =?us-ascii?Q?ZCzxyAHa+bLT60H9D1zrD7Nqd5eIcVZLJrg3NwDrXMTAmlLML5lXsCzANxtC?=
 =?us-ascii?Q?trlbt+T6FbBH0m1r6V0wTqT1H0WpNdkpjUF64Qp2TRjujXtAh/n2xlYgMjOv?=
 =?us-ascii?Q?aqL7pdyvyuYlapS4Ox2eSqpfbf34kX4tkM4JJPjNINqktqJFRdw/SCbiWFKP?=
 =?us-ascii?Q?8WnbUdTWFL3igDrSJUF3ldWu8vRHqo6MPPOp7JhrfyUhXs3M+Jp4OBzeT06X?=
 =?us-ascii?Q?oPUUFvIJ34rXV3WqZ3HAhLEY1uxEa7ugNqeZDLbXRVSpo/HFlvff/t0bxwNy?=
 =?us-ascii?Q?HDUXMg4rOKLPKCeKh1qwRMQRzNRSaMvU8a6MgKZlYSR9do7vUHvZkTDzwEnD?=
 =?us-ascii?Q?CaIEnSQGCBGv+2dikx3um2mBhFqm2PMEIIpePaz71wD2S7Da2jICfZPf8XUv?=
 =?us-ascii?Q?v5VvWmmU23zKVFtNY1Ge94iZl9QyLfBnfo/06/9zrCLCnbHZTuBLz6yr8uBh?=
 =?us-ascii?Q?Lh8MkSGsD25Mz+38ARHJez9naAwmgBnlHgKsvkfA7/yyFn4x/jwv7e9iPm62?=
 =?us-ascii?Q?Rb+KQKRJkNfz88J2PY9bT3nS1r+V4pB/UAlZdPdfhqtCRnyDs0tWFHS+yehT?=
 =?us-ascii?Q?waXoOGIPvgjku0Yjx9sID9RamDHfuq0M6rgOLP94yxjnisteQOBq4Aq1xL9t?=
 =?us-ascii?Q?VpiJ9wJBVjisFGVAXXcFCPGBDkI79W9icQYrI4qZYUxrR8Mmelk8LgXETMfE?=
 =?us-ascii?Q?Nv7ivLhoiaLnP/rCf0wS2wOYTD80nq9mJnFHsNy1421J1g0FPayWwTpvpGXF?=
 =?us-ascii?Q?1lRptXIdBw8rb8FA0/GiKo2xg/DFbObY2SLtcuKlp8wSVchrDS6shy3LTUnz?=
 =?us-ascii?Q?MVbaaxnc02W3hoT1fAgp118DXVqTnS+yMDlVOv4te5JZebcalYrjHub+53KG?=
 =?us-ascii?Q?vURWebZSWFa5VtrKz7TwjAr/QWApzh35CZooMD0hetaunA=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9be7d7ff-efba-439f-0d76-08d8fde0d1d6
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Apr 2021 18:28:51.0011
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NSlEZvatgLeKJfaVwW0PHg8x1eOIGX8/tPoIT8qKkrbmL1Ioj853ss8LFs81r0MK
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1881
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Apr 08, 2021 at 11:31:40AM +0000, Wang Wensheng wrote:
> Fix to return a negative error code from the error handling
> case instead of 0, as done elsewhere in this function.
> 
> Fixes: 7724105686e7 ("IB/hfi1: add driver files")
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Wang Wensheng <wangwensheng4@huawei.com>
> ---
>  drivers/infiniband/hw/hfi1/firmware.c | 1 +
>  1 file changed, 1 insertion(+)

Applied to for-next, thanks

Jason
