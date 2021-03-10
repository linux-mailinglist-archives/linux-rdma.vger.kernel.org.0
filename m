Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CCF1C334850
	for <lists+linux-rdma@lfdr.de>; Wed, 10 Mar 2021 20:50:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231396AbhCJTuD (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 10 Mar 2021 14:50:03 -0500
Received: from mail-bn8nam11on2067.outbound.protection.outlook.com ([40.107.236.67]:27489
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232859AbhCJTtd (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 10 Mar 2021 14:49:33 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LeStCsJLRGa2LEzIUOqxqYB9xDr2BCvNvl3qOvm8WE8ooRrqJKorrn6g7s+yEAZslJlZtIwywMhTjmsOdLbGwTGy20AakmjOHK0y+qVSailFBaSUceii+9BdswI3Hb01ZVzLKksTWwRYTRJR3b5rz4xTVz0GwaOOUUfRl77bJ1cXKs9Dq2kc+5J2/4nffB1DvWQG64hPV1fBBN0Cu/OEOaigG1Yi5Sq3ACvBIOJgqtSu7EGmqubuHRj5/LQxI/x/EjJCVdjxp8pXQtxH2GGx1BXgyzt0BDjDfvzoUZdfh/W26D6wLbGmWgytXx0Y5oVQoMzOyNPVuuPqR1wOM3K+gA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e2/FSes9huyNJKcmFtx43vIJK9sGEdEFRNjkzqxGrXY=;
 b=LvvtTdniHwKGDzeQNUu4lLWox6bzdptZYJ8mti8c4uDPhWNqWy5SXBMpFHDNlXsh/f+KubGLcf2yo2q6VB0+BNyumGi+waUqSvbr3n9+J08NeUsbAKDlR8En2wFkdGDuIAA0hQwqRUadVhN1oRkHgoURWzLVjlmJqCcS3/J95edcRFOSG1FAoaSPGFP5siaO6JyjOj+NSyXmEZyi1YWmfVbQj0dEI7bK9x+RArHz3w5xzzwpxKsGxpkbw5tA1DfW5cYoQS7IgLBNw7LULB6t2pbnz7+KwCTZgDFWua25qNdiQfkN5R9814cAxB9511SHGfHzZSSKaPQ9IqgTHS77bQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e2/FSes9huyNJKcmFtx43vIJK9sGEdEFRNjkzqxGrXY=;
 b=fqpi6j8Nyr0vrxZGvfTpAdkjed5VVBuF+MOKCWIOHTNZpNKqFO9f1Ry+4Jbh1xWPzVVZANQdYrhJSHK2AzdO3e6yjXE1D+alRt5WD0q1oBqFStVsAqmYtfnWFCMF1Omrsutn3mKnAWMSbtXR6kQbYU47rpjXchW9ECMaQ1SXT5ycLyYrEz0uTYkYss/yEEbVJ5X29oSDLTzdp9zWDicW668WWULZKvMMqKaa3NfU1M3zXwJP1dGswILVbhsRsAWqbkHwsj+EyEGfrHrMN9ZIDddNqLrfUk+ZSUdoRydfr5wlzTx718voaAg3364vkP1iARJQFcY8HMJfKQYwexxzdg==
Authentication-Results: zurich.ibm.com; dkim=none (message not signed)
 header.d=none;zurich.ibm.com; dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB3835.namprd12.prod.outlook.com (2603:10b6:5:1c7::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.17; Wed, 10 Mar
 2021 19:49:32 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1c62:7fa3:617b:ab87]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1c62:7fa3:617b:ab87%6]) with mapi id 15.20.3912.027; Wed, 10 Mar 2021
 19:49:32 +0000
Date:   Wed, 10 Mar 2021 15:49:30 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Bernard Metzler <bmt@zurich.ibm.com>
Cc:     linux-rdma@vger.kernel.org, Chuck Lever <chuck.lever@oracle.com>,
        Benjamin Coddington <bcodding@redhat.com>
Subject: Re: [PATCH] RDMA/iwcm: Allow AFONLY binding for IPv6 addresses.
Message-ID: <20210310194930.GA2602371@nvidia.com>
References: <20210219143441.1068-1-bmt@zurich.ibm.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210219143441.1068-1-bmt@zurich.ibm.com>
X-Originating-IP: [142.162.115.133]
X-ClientProxiedBy: BL1PR13CA0052.namprd13.prod.outlook.com
 (2603:10b6:208:257::27) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (142.162.115.133) by BL1PR13CA0052.namprd13.prod.outlook.com (2603:10b6:208:257::27) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3933.23 via Frontend Transport; Wed, 10 Mar 2021 19:49:31 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1lK4pm-00Av0c-Cw; Wed, 10 Mar 2021 15:49:30 -0400
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9b8138ee-7ad0-45f9-3018-08d8e3fd9fae
X-MS-TrafficTypeDiagnostic: DM6PR12MB3835:
X-Microsoft-Antispam-PRVS: <DM6PR12MB38352751E86AE7609E690540C2919@DM6PR12MB3835.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jLG1OeVyrxX9M5vddXySF0X0gNw1VkMNcDHfF2gWhGlISiUBDUjOInWhReGW4k6Xstt65mNADnF2x4hcDOmLZHVr5EDTyMg+pGqiXXOWc+GHlpLibvyfXYCTkyl0ZzFteAS4IAT1MzeyRBpAz0swQ9Q9rEib+geGtlKSDYLr/Da4Kijy5yWNpoZFk9kiCWy/7QhCnLdY5OLe+SewSzMCsMzjeNzGvnxWljI1DeXrIat/z9PQCKsgdgWjQYP2tSyMiLQCxJi4dzaJ/ayqE78trgWfLZvQBiWcSIgFaO9Euc+tw8qVl7oeTzekosmT/JUAzElSy4gOJOH84uVVyhIlYlw7WYU8BPjl/Jk8jrOwKr33SWkyCG6zatm6DIMAshOmsJ8CWo+E9b1zEGDysb+Qs6UhIxB/kjB5e2jtQgwICDDz7bv6XZf0Al7jgUtOGsYWSfNhOURDgPfTPKESX/Mn7Ilzzgf9lBEOrgxivuV6OBsbS6nuHXsUy2N/TDzw2pN3NIdBRrHIZv+tlItfmrXfHg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(346002)(39860400002)(136003)(396003)(366004)(66946007)(4326008)(66476007)(1076003)(54906003)(6916009)(26005)(66556008)(4744005)(186003)(478600001)(426003)(83380400001)(8936002)(9786002)(9746002)(316002)(8676002)(33656002)(86362001)(36756003)(2906002)(2616005)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?cu3B5hWlNZ+0VCkKVZFMQj85KuXTFV8ErE4yBx3Yt3f9e389rUVa0HY0Bt7x?=
 =?us-ascii?Q?Q0mGbCsbGD1R3/BUJ2bEoV5dKuTDq4Y2FG72LFfEH9Wgny6emUNa2s+4UpLb?=
 =?us-ascii?Q?sWlkjdAJiKJwSBXoLUW15of0aZ00R7N33K6/I/t2NppVsVpG0HP68HYi4sjL?=
 =?us-ascii?Q?wTmKBNyGwpErVqnAx+PE93uCCOF+u/XXD1MZMFU2o/yrxYpNCYUF1ZNRz6NH?=
 =?us-ascii?Q?xXTWS3JCj1JIJ26faMPIroCn5c/byi7JNn6fKa5qrs6sQUxqKCQWgrgg/rH2?=
 =?us-ascii?Q?kqaFXThZsrxUEBnS2xG0BO5nZzONcF3W6Fh+pJTscYpkNSkdAaB8KKZz/pv+?=
 =?us-ascii?Q?kZz1aYOv42yJIo7VAu7V+R/Vnevh9L2Q91rCUx8jC93R/WFXTsMRai00PgAA?=
 =?us-ascii?Q?3D8Tqbmo9RLohgo2K2UL4zNYvJCPPMauG1b5uyHq20/PEtmMc9EvTt8tsWr0?=
 =?us-ascii?Q?L21HV1AZq3VqKqMftpAkfrdKRAk3P3HWcZGe7o7buccvm1zk5gDc1Nr1cABX?=
 =?us-ascii?Q?kXh79/1mELTAwyjrcosG3xa1Cz6niRb5jYAk08LmbXAHukyHXheXEaQZQKfK?=
 =?us-ascii?Q?xC0gREhdfqiidcQOhMu3BlZtOsz1tmeqii0da2LBnxiMdpwZeLx+X1GQ6KNB?=
 =?us-ascii?Q?zLLTZu1aTP3lwRqWaaUse2ElONc4ZLatZtYAWSkgZi3+0/rUttZxuzzvQRmQ?=
 =?us-ascii?Q?TpKcOEnqiAG4SxxsDX/DuPspvS0SmXfSvlV9mWexmQ48rwGHvLs1XoJEOdd+?=
 =?us-ascii?Q?OqFbmYW8pSif3mdgT1i17uRRPFPX8p4ZMs5x3yXDw8DnJnqRh2VE4/1vGc65?=
 =?us-ascii?Q?80BwWV4jDdYXRSWXk+B1H8hj1dJsN+auJWNIkSOcBjFdRAmM5bl1SjJKFKRP?=
 =?us-ascii?Q?nmp9b+qk5TVopgQB9FsH2igTQJQp2DMAjW1VD9cOOG6QfOF5jtUTw5RiVXrn?=
 =?us-ascii?Q?LNOhbjErLadRMCzbQfX5gfc3pAuJOf0EnGDbg5CNsTC8FeKQHPeD9o1Wejk/?=
 =?us-ascii?Q?nhX+XiGQ7oBwTBpAzCODbIGhiWm4evcNz92Zlq4cmYarPetymiMYudTZnuny?=
 =?us-ascii?Q?YXYhfTIinj0vfdEJfFyMkvX+jFCgN5CtyUOlcPMvSnd1ffJ6JHfWVnASQOu1?=
 =?us-ascii?Q?OuCU4Xr/XgfZJOpnPzvtHAyDsf39PTt9Xiu/a5J/mKecYI2VRG+0mbsrjADo?=
 =?us-ascii?Q?NA9/I6aiRpUaDEH7IERiN+SorJw7M0rjJtk7In6setYiwAfw9kqp0xsIfBZC?=
 =?us-ascii?Q?PeFCk6TLkxe1Fd5su5fz6sb9zvyPYRjBEyiP55Lgb7LiRw926cpW/m8hNEeY?=
 =?us-ascii?Q?Uxh9UXulG8huTHbMaEf1jTJGsQsjDcLFQQLxnRxIJRmgFw=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b8138ee-7ad0-45f9-3018-08d8e3fd9fae
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2021 19:49:32.2076
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MsT0AixhVuR8LtADRQlO9G9oyvNH5y7nVxDEd81YYBqsooNP0uY4n1ocwkLS2ibK
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3835
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Feb 19, 2021 at 03:34:41PM +0100, Bernard Metzler wrote:
> Binding IPv6 address/port to AF_INET6 domain only is provided
> via rdma_set_afonly(), but was not signalled to the provider.
> Applications like NFS/RDMA bind the same port to both IPv4
> and IPv6 addresses simultaneously and thus rely on it working
> correctly.
> 
> Tested-by: Chuck Lever <chuck.lever@oracle.com>
> Tested-by: Benjamin Coddington <bcodding@redhat.com>
> Signed-off-by: Bernard Metzler <bmt@zurich.ibm.com>
> ---
>  drivers/infiniband/core/cma.c      |  1 +
>  drivers/infiniband/sw/siw/siw_cm.c | 19 +++++++++++++++++--
>  include/rdma/iw_cm.h               |  1 +
>  3 files changed, 19 insertions(+), 2 deletions(-)

Applied to for-next, thanks

Jason
