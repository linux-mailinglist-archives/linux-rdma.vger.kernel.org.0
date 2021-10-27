Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6666E43C942
	for <lists+linux-rdma@lfdr.de>; Wed, 27 Oct 2021 14:09:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241779AbhJ0MML (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 27 Oct 2021 08:12:11 -0400
Received: from mail-dm6nam12on2043.outbound.protection.outlook.com ([40.107.243.43]:6609
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S241774AbhJ0MMK (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 27 Oct 2021 08:12:10 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LQsbkZACIov0gLukHgwfJNH3PVhCYK7qk1ny9Ryk9pifOORPhweqZO4AK/1hO+Gzuw44FR8YhX9oLHwcbnj/gjC7JJ+yf6okH+pfc3VgM65rXDVKJFqMHQj+FFcAxfutNiQsnsKjxy5E7kMPo2Rd5Wu85hoC75PsZxo8FiZ3S1SjM2XNnTYDlWT7AznK4vSFrX+GUvqB3gzwC2udEZvc73UbUVWrLWR21IvjlSklxra8t5gDSgNSGc1jLkB+Aku5iRjqkEb4qUZgRxCNa4gwOe+wu6L1xCB+IKqVZFtxoRzOW7iHBJxJ8BDT7dapf1L5zt8Ew6pAZsYStN8fTUqPjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fV6gU+Q2WQzHfE5PgaIpGAR44cF4Bzu547fEazV+P4A=;
 b=dW48B9jY3Y4n/8sejSpzWyoIuY7u+X5otHmDWMdh4ng+Lxj0+V37JT9vsGbUqNgoE1nZEOgfvm6ldmjh0yrOinXs1SCOXaAmjSf1xKiUfQKrLeX3+iGz5vCqW0v0HdmxBsZP61cBoaFGyZOB7U4Adsm2p2J3ZwOC/dZ2obcmBwwabwtzD289Hqco9qfzwTXcUylCWGLwBj9FLUtDVu7cNRJYb3h9eYALc5GpKf118iQK5xQ14ydLpYng8eYnAE0/W7P6GCkPvK7qtOgDRwInP4wJyTlapoMTUZa0QrLm5QAFyzdtY/pPDKbyF0vO8YknpzJt2CoqN+JZWJO74S2y8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fV6gU+Q2WQzHfE5PgaIpGAR44cF4Bzu547fEazV+P4A=;
 b=Sb49cwE+VzEMNF8EmSmAefcjJ75qPuBaQo7tVOoEtXxvElzFUfz7JyuPzWb4xiR6hsQ1z0A6U+HmLXwArYVRCCznL/pFoWOuVY7HSsdIm1RihAtLadb6okPdu3bUx/ymMjOLIUB1CG51trcUfJDyNGlXcRZkMbTsk9lM+N88szp0ZteM3pkZlRHkP18dkGxSTlCdlLpt+DFneHm6umt8CFutaIyvTgSzgDlZ4QcGOYeBQchJZ417cSxJ66No32J+ow0t2vF1GTyl3nnAOKfnAQqSDk8YCJnk7qVCb0UlF4kmbul1DqEQSxwGRYd6PoWkNgNffsP9y9gviBDRY4dWxw==
Authentication-Results: huawei.com; dkim=none (message not signed)
 header.d=none;huawei.com; dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL0PR12MB5553.namprd12.prod.outlook.com (2603:10b6:208:1c9::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.14; Wed, 27 Oct
 2021 12:09:43 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::e8af:232:915e:2f95]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::e8af:232:915e:2f95%8]) with mapi id 15.20.4649.015; Wed, 27 Oct 2021
 12:09:43 +0000
Date:   Wed, 27 Oct 2021 09:09:41 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Wenpeng Liang <liangwenpeng@huawei.com>
Cc:     dledford@redhat.com, linux-rdma@vger.kernel.org,
        linuxarm@huawei.com
Subject: Re: [PATCH v3 for-next] RDMA/hns: Add a new mmap implementation
Message-ID: <20211027120941.GA583629@nvidia.com>
References: <20211027104129.36902-1-liangwenpeng@huawei.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211027104129.36902-1-liangwenpeng@huawei.com>
X-ClientProxiedBy: YT1PR01CA0076.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2d::15) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
Received: from mlx.ziepe.ca (206.223.160.26) by YT1PR01CA0076.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:2d::15) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.14 via Frontend Transport; Wed, 27 Oct 2021 12:09:43 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1mfhkT-002Up0-Ng; Wed, 27 Oct 2021 09:09:41 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b27cb1b0-c975-4868-832e-08d99942a942
X-MS-TrafficTypeDiagnostic: BL0PR12MB5553:
X-Microsoft-Antispam-PRVS: <BL0PR12MB555311AB96AD918E8D247F55C2859@BL0PR12MB5553.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4941;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZHI5oRKnsOnAW1OkEDpgLppjnF+0jv8a+z0YIfAUbnw4Xey6GyzM41DaBOqt0ID/CMmlINdW+IlpPbT5lfwk57k8Wv8VSVAB43dHJYXfaSJ/DbDMCL4oinL3rl1ekiBpr+SRWnhwu137TJi0rH7+zWzqC07gdKJ1vpVFOYwue95q6IjtH462Xj9h0je/nCkTQpORYRhcQQ3EtSnXikFpNjOOOvMZxsYjs0hKLDWHbMqtcMFFhgQ2HC0DnSuLEomhTK4FrwwbQ7T0fth3Hy5lp/gSzJ5tWCIoOdR8+UXm2sWSx6ZCK7jwwiPmmkwI7j0TXsoabJyzeI2F6vB4b8NoUVY/0AtbM55BNEqbSCgH2VNisKy+rpCbcZaIbYFYCoMguAeLHS1a+p0LnOyjjukF58JFLm89Bl2P6lRcxwJ27+XSZCT3zxTYHmW8SVjwN/OtOrCWCXjRYf0w/vhPHuhmSYxRyhBDZa5KfSMnOWMOweHw6sZp3Z27nWlq0WNmCa+2ZsS3VtIeoxFqBT/QKEVP70JoHV6bCdxxMObfhSC59vXC3Fn4DFFOwLN1GhenEOdPuZ+z5TTCVnM8A46+vqk3q58cz8gPRJeKipVxQccs90q+oDIpyGTVU4w3EZT+t4YILptlJhX6xdjdVAm3hmWlqJ2a9IfGc18uKjHq3l7A5c6r73M884+yuHHr+9WkdOprkxCDjDRtMXIgBuQ3L9PyoA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5506.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(86362001)(508600001)(316002)(2906002)(5660300002)(426003)(8676002)(4326008)(33656002)(186003)(66946007)(66556008)(66476007)(6916009)(1076003)(36756003)(9746002)(2616005)(8936002)(9786002)(38100700002)(26005)(27376004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?MfFmHd8xSKx705QchocZwMdMFc+jQZGWiIdqYR+QonsI/U/0Tcfc1DPTJuiy?=
 =?us-ascii?Q?L/Qy2XOCce4e5Azb6kyOpUUUTmzikb5qc7LE84v+88d5tmj4OU9oOjNrkd+7?=
 =?us-ascii?Q?MpnJ/Hpia1Qep6tbqko9cOS/0uCNpIco23MxQ2mu+rL/dOqgxtvm7Tf5Lyyq?=
 =?us-ascii?Q?zF+IYU5Y53hP6U6SmXtwjDivdxvkHw/FDXIYPF42DXFpZSLHSXua6gZcIlTJ?=
 =?us-ascii?Q?etduPmQzRxTUlTYrCCBvwA/ISfUPeTU6GLA4Nd4aDWp1AvTbNZFRwc3w7QGi?=
 =?us-ascii?Q?36KMRCpwYI3q3HofHlLDjuhIRXRRt5aEecFy0LWiPg8Rlb9uftmKP4jz491B?=
 =?us-ascii?Q?NrcMnYPG4DAMNTgdJphizeRXpGNpjJu2uuhgHVbuT+m+Pi85MI6h6mkYdqgv?=
 =?us-ascii?Q?Ne1RyRuuBPa5cN/9w0pziTPgAiiBgkeGFDJGhtES8zJ1OwmFSVWVHXelT57H?=
 =?us-ascii?Q?ZuMugQ4OnxVKrSBHo1gvDgpuDm2nxYvPtwXPkFS1vfLSFbGCLNQKi4eXt915?=
 =?us-ascii?Q?wLHEtcfor7uxIYELZQu6wX2ts7z0dQKwI/acx9OG+v0nqawX5swHOtThkhYi?=
 =?us-ascii?Q?iqRuXzPuPM9OcSk1ZKDwlP3DLQjYhZXqbeKchRdgV0tk0cBsWJDVKXyz/b8O?=
 =?us-ascii?Q?0NWuwZPrV3TalPhMkRATmgIxjn7+lIpRyBCgGa/S4stLoAp0K87rBpnnFTn7?=
 =?us-ascii?Q?VEybdLgt7ytn49Kw/sK4gf4zDZcehZXS/Tnb43PkHQ+UiHNz//IX7w+44/Jl?=
 =?us-ascii?Q?MZCWoyGERwpjNXLAqo5LF1mdrtVnL2yqdNIpUkQq2Qq1LnzKxm60R4RwGHD9?=
 =?us-ascii?Q?VHzwf5xZIV6uNV8GBHnpn9Q0gqoUxG+rcH0RQJOShvSfia1gSkVFSDVgEKRu?=
 =?us-ascii?Q?C1t3Wie/EbawTItYpzbfNyJpr3DWse/gWknxGDDWjpYCz7Y4ODRLLhRYKFL9?=
 =?us-ascii?Q?FElYC75esCHeis+ioKFH8wWF2PF81ZxoIrgVwsq/zT8T6O/BHZDh5CLvZHwB?=
 =?us-ascii?Q?v3SxqY1tTTQ+nVa8GHdWZ+SSudo6e7cgJUVtQcJmPzlUTm1gmcZ0bwLv77FX?=
 =?us-ascii?Q?FjZZQezCpVnYpka5i2Uh3V+CsrK76+iZ7dr3bzXZQZHFOH0IlOFgQ4HSm+Ih?=
 =?us-ascii?Q?2m4isOODoKihk/2XkoenP2QD+eMx27FZv6ULjxpE+5IavJRxCTlNScdYP9BY?=
 =?us-ascii?Q?lQxZ8pw1bOK+Ai8Wy96Dg5bvSSnnvHcn9VaypspTV6amB/9l8ar6j6v7UcnY?=
 =?us-ascii?Q?iNgKJIAfBuxPriB2pJsod8rFZ0gYHnhFnEd4auiSK/TXci3AFj3dpKHunfPI?=
 =?us-ascii?Q?50kncBJstLU8CmvHJ1PQXw0BqdomXaSTJ7KpgWYgMV4UqzMwjW+oBq/wky1j?=
 =?us-ascii?Q?5dD0LOUq4kgNsXup3NIVDPz2u7dvapgvfyeckNwUiRKpFhJLcfKrXW1Bwwgp?=
 =?us-ascii?Q?4cc3oNRCQl4+b/HJ7PY7LwGbc/faKWclRBCCQbeNVifg0yK1y6LSncjap8V+?=
 =?us-ascii?Q?/jmAQsuGszvfSX8UGdHgaRRp2Vgrvf4aMZFVTp6JHycziq3A7xz0YaiY2VYA?=
 =?us-ascii?Q?G36e68i3UZXnNJNOCzU=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b27cb1b0-c975-4868-832e-08d99942a942
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2021 12:09:43.8595
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7R6yhelMYDK3Yug9YFa89ItVX40ElAIrmQpshmIzRQXqwW1Mzqs34fv5Uri0ZJuq
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB5553
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Oct 27, 2021 at 06:41:29PM +0800, Wenpeng Liang wrote:
> +static int hns_roce_alloc_uar_entry(struct ib_ucontext *uctx)
> +{
> +	struct hns_roce_ucontext *context = to_hr_ucontext(uctx);
> +	struct hns_roce_dev *hr_dev = to_hr_dev(uctx->device);
> +	u64 address;
> +	int ret;
> +
> +	address = context->uar.pfn << PAGE_SHIFT;
> +	context->db_mmap_entry =
> +		hns_roce_user_mmap_entry_insert(uctx, address, PAGE_SIZE,
> +						HNS_ROCE_MMAP_TYPE_DB);
> +	if (!context->db_mmap_entry)
> +		return -ENOMEM;
> +
> +	if (!hr_dev->tptr_dma_addr || !hr_dev->tptr_size)
> +		return 0;

You can move the FIXME comment below to here

> +	context->tptr_mmap_entry =
> +		hns_roce_user_mmap_entry_insert(uctx, hr_dev->tptr_dma_addr,
> +						hr_dev->tptr_size,
> +						HNS_ROCE_MMAP_TYPE_TPTR);
> +	if (!context->tptr_mmap_entry) {
> +		ret = -ENOMEM;
> +		goto err;
> +	}
> +
> +	return 0;
> +
> +err:
> +	hns_roce_dealloc_uar_entry(context);
> +	return ret;
> +}

> +	rdma_entry = rdma_user_mmap_entry_get_pgoff(uctx, vma->vm_pgoff);
> +	if (!rdma_entry) {
> +		ibdev_err(ibdev, "Invalid entry vm_pgoff %lu.\n",
> +			  vma->vm_pgoff);

Do not print on user controlled paths

Jason
