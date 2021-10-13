Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 96E7E42C88B
	for <lists+linux-rdma@lfdr.de>; Wed, 13 Oct 2021 20:19:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236782AbhJMSVs (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 13 Oct 2021 14:21:48 -0400
Received: from mail-dm6nam11on2088.outbound.protection.outlook.com ([40.107.223.88]:23146
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230301AbhJMSVr (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 13 Oct 2021 14:21:47 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RxGRhMiTHZLgbefOoF5rCvqsPjYTxrtkr9dmGKyFAAcA/2Q0+oEtzoBK7edqjx4ytzGgt7R89/2zgMhgLlKHSli0K2svQe1NF9nvi9I54PA7KkZzw5OSYmUPfePV9LCc704BVNEzLxUfqqk8C5PGejm09iVEZbHdXwM6At7EZiWbwFzPWhQGXs9uNdJ8UT6vAE4dFw5+g6qdTq3vjbkZ5RbBN+oG10pbRFcWo/0QGn6w8JahZCQlzLq0FIFQp4iFDEz2+XAksLQZ6R7uT7gtkeAfFO2QapEURi4aQYkRv1jaek1r9jATTblsLPv0wscbhq5wHbXyiwXQsYDnqJVOEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1i1pilBziBizJEJQTpVee05njRKFblU7btzTUAAlfJk=;
 b=GpzA+ipBQEjd32PiEB+hI2twc7J5Apc5r+10AQt2GnppveWzMC/7lWuEEnbJyVfJTeu+/k7fZyr1XApTLbsRGCHXKI0Kas9vMFq8Kudm6Oc9ZhsLX2GyB+0fwNJrt9QX5d74IzsdsbPT2dY12gU11byGdO6WJmP6q0q81xx4zjYLqtnwgbMClAAn5hhjwEGYPQNR3ftgCb/dnukVIKsQ7DKtux5F304L9oEYQXjRnrygL4rQW5cfqkrc5tAFzc7IP7VdAEpSuP/YJmS6nluLbwnvDRHBLoAiLWbSKDSr/MClODld/doKQqMz5izW2QC7N3ZGqeGfE4TbmAzDPSIHIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1i1pilBziBizJEJQTpVee05njRKFblU7btzTUAAlfJk=;
 b=Pf3d6Zo10EzXvzDJDLiylc6niISyf8OAOCErBC2W8c1JOwiucncgSDIT3Kikk/jqmGUnbDQhldj5qLCx2VZINacUfbILq4sfwhffXwTmegGtrvt/+YduCOgLMV1GI77RiV96YKFjex/6giuQ+eA2JjoJAhL0ntEf3nRNf/qDMf8G2kpHczWb+IG7b+J4vIWxgByKllnfugT9BTpedpPgB74roEYig0tZqt++FGkEPn8JYW3yiNBJcqjdNniCACvADqCY2L565P+VgenbNLd1X1DDcbsiydko7y7dQfF/uC/Sg7No3whbfdR9iFvUy0OjPe2iDXWa4QQTHLcHS5q16Q==
Authentication-Results: oracle.com; dkim=none (message not signed)
 header.d=none;oracle.com; dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL1PR12MB5286.namprd12.prod.outlook.com (2603:10b6:208:31d::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.16; Wed, 13 Oct
 2021 18:19:43 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::e8af:232:915e:2f95]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::e8af:232:915e:2f95%6]) with mapi id 15.20.4608.016; Wed, 13 Oct 2021
 18:19:43 +0000
Date:   Wed, 13 Oct 2021 15:19:41 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>,
        Leon Romanovsky <leon@kernel.org>,
        Mike Marciniszyn <mike.marciniszyn@cornelisnetworks.com>,
        Doug Ledford <dledford@redhat.com>,
        Gal Pressman <galpress@amazon.com>, linux-rdma@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] RDMA/rdmavt: fix error code in rvt_create_qp()
Message-ID: <20211013181941.GA3488902@nvidia.com>
References: <20211013080645.GD6010@kili>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211013080645.GD6010@kili>
X-ClientProxiedBy: BL0PR02CA0120.namprd02.prod.outlook.com
 (2603:10b6:208:35::25) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
Received: from mlx.ziepe.ca (142.162.113.129) by BL0PR02CA0120.namprd02.prod.outlook.com (2603:10b6:208:35::25) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.15 via Frontend Transport; Wed, 13 Oct 2021 18:19:42 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1maiqr-00Ede3-Na; Wed, 13 Oct 2021 15:19:41 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 597f099a-d23d-41ca-3b6c-08d98e76071f
X-MS-TrafficTypeDiagnostic: BL1PR12MB5286:
X-Microsoft-Antispam-PRVS: <BL1PR12MB528696516E2BE6D4CD669582C2B79@BL1PR12MB5286.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2043;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: x3QFZJQthf9dAg1QDto6utFGhASiz7PDimJoZdH5uw5cz7cnkoKJ8AYEXHaC7Kz1UktL50QK2/ghawK5AkcBz/hj0hDksaJYpDaITCR5vEHPkkEZ/ynR/eKsOKlWqc46OSnezVJ6wKfNYoOt4bHFgAtEIGIDJEV7FxYmzxQcFpeCYqNL1i0Z82a6ysUUr0PUgGn+Nu71eKM23oOt/n7g+cVIej65N8hhoywu0CqlLwAOGo3txNvvrSyLCY/8IO8lt38vyAtFVkuM+hkln/929nOsxAdx+3o2Vd6Dnb1pVqQGSck0XpBCYvEHBTDLl9S1gbAqiDuCELUrfKGxRGGlUvZGTCwOVbmfT4SnMevYEGNhgoOkMhev1dH2kxzpEcBa/z84GLyy6lzqsHEyOq7/LvrQ7PCfpQtLQurZpib+i0m2ZVdauMiWOuYKD9RlnEtknUFWGeL3FuJ8nlXKNeaTr7u5f74YmJNXt8cGViT46jOpr1R/SuQoBvC7HkjcRqNDt+Cl23SnpwKa6MyU9ttbT5A9Rkj6oU/uxnqhfPRQAksmoOmjFj+0FK3qRcWkzNeqGIGze4ofGL4NDBbRxLpdQcoFZExUoioH9hDN1Siq818XwhxXPKdngYU2C6pF1dmxCEqFhpSwCoW0SWiXwNzYnw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5506.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(8676002)(36756003)(6916009)(66946007)(508600001)(38100700002)(83380400001)(86362001)(2616005)(66476007)(4744005)(66556008)(33656002)(426003)(8936002)(2906002)(5660300002)(186003)(1076003)(316002)(9746002)(4326008)(9786002)(26005)(54906003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?RhokBgGiSz+TqI7lFZUPXX+zoRSgYK2ZHV2J1TEWKWPY1K7GNNpT+gHe6KB/?=
 =?us-ascii?Q?+q6uZyf6K1HC0nJLiDzWBUwlAMotg5Iwbe+w65gB8dB65/wCRcwQpEtvXU03?=
 =?us-ascii?Q?IB2bP0MoVw9tXJMGhLwYAZo5+HOKmmK0uvPRAfrK7SUzR8tcywuPVhBibVQq?=
 =?us-ascii?Q?2Ac6fQ6arY2JKDcrMBQj6n255HkFt6Kge0fKrDfJKAImNaV4FgAYXPIaccfK?=
 =?us-ascii?Q?g2eh3g7rWhIY9p+xKo0JfZFq8rGDdrxKNGv52aLjQxsumU8u9i3WioAr+HCp?=
 =?us-ascii?Q?+AdnXpmSDtqI8B5AzIe7QjkFNZPA5V1+UdttD4kMtPcsnxOoTVOLLscjVAGU?=
 =?us-ascii?Q?y1Yt/u6BvIw4rh0cCVM+B5VHKMpN8m63AjWBxPC5UFsEsH4bWvD/p9ZK6h67?=
 =?us-ascii?Q?EaVjPnSXShzt55PFRkptUMZ00/bhIdzIXkelAjDBX6sG9EV+guSClO1Bxfu6?=
 =?us-ascii?Q?lgXQ9imOcueJ1fc5SPfh8gaalOGB8v5nwUSsMbcdp15oR48FbpGxj/hAzMdS?=
 =?us-ascii?Q?LgTAQzrC4Xp/+Hp9g2pbvagrRmn11/K7LKZMXpoNQwsfKZF5qzBNLGxyhALl?=
 =?us-ascii?Q?oiNGJZLfkYRRybSaVQUboDqs45qz8ks9phHK353/XRFFZL8xiIy64HOcRZ6i?=
 =?us-ascii?Q?RIRhaBp4ITDK0yr6NIyDGsfb6XfGJH9ibC7oLKvRHBEZ2oCZfj0YWGvHyCm5?=
 =?us-ascii?Q?WdoubGqW9jLRKwgaEq5p4SyqDcQhwUFes7v+oVlGZP4piHL9Cfo8vvbVr6w9?=
 =?us-ascii?Q?jpOGoJ/2Rj0HmqcHBvFhkT4XyIGqAsgOz3MqxJqQJx2LEvnhYktmvgOUSsuk?=
 =?us-ascii?Q?220I20u7RBv4J8N1HcJLCCctjpjgQoN4ydj8SP8cXA480lLKkQNtakH0H1RY?=
 =?us-ascii?Q?PmlYZk4YT1d4PDgMKenjOFlayCEsFrzcUzA4I3dF2UGMgK3SDSgrdzGffVY1?=
 =?us-ascii?Q?nsc9WQmXTnK+YdjUmfYy5RLPw4d7sIrazU9FreRD6sqToznaFHI6H0BIvuyz?=
 =?us-ascii?Q?/h3m0P6aO/hAxjNkdVaMnhhLFQx2ptC5eBZvM861Jj81B6acvjETADmxYar0?=
 =?us-ascii?Q?m1lKPYjaPeLXn6/3dZ4UtzNyNFNl1xWwNgS/nlOgdT22fq3VTyKb/aH7+8rD?=
 =?us-ascii?Q?jhJRK1o4hAanv9vi5u2M+mxPFjcSgnUJTbVZxEAKtBg40kMWWB/hNC8ohtjm?=
 =?us-ascii?Q?hcvsYdeFTtN6XmT85Tg0VeiOteEqoxZoF/Uxzm441f4En2bmEpTVoybR/VAx?=
 =?us-ascii?Q?UnjYLbXB8zfAz8qMtHgfn+hUGo7luFtSwExOVhIUbG1vmtkfKnVvhtjQNYQD?=
 =?us-ascii?Q?c+p7Vh+AkVi9cqDrx0/2y64o+YYiMvb1ug3+Mn4/oQMrPg=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 597f099a-d23d-41ca-3b6c-08d98e76071f
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2021 18:19:42.9853
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: P1PZm/UvnA8dzyJWJJTa2pCDfobybSPSMgXIg8ml54tIxhOAOQh2m2ZbJy5FlkKK
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5286
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Oct 13, 2021 at 11:06:45AM +0300, Dan Carpenter wrote:
> Return negative -ENOMEM instead of positive ENOMEM.  Returning a postive
> value will cause an Oops because it becomes an ERR_PTR() in the
> create_qp() function.
> 
> Fixes: 514aee660df4 ("RDMA: Globally allocate and release QP memory")
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> Acked-by: Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
> ---
>  drivers/infiniband/sw/rdmavt/qp.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied to for-rc, thanks

Jason
