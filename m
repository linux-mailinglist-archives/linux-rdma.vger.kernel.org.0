Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E29B46AEB3
	for <lists+linux-rdma@lfdr.de>; Tue,  7 Dec 2021 00:55:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377866AbhLFX7Z (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 6 Dec 2021 18:59:25 -0500
Received: from mail-dm6nam11on2044.outbound.protection.outlook.com ([40.107.223.44]:12512
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1377826AbhLFX7Y (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 6 Dec 2021 18:59:24 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n3h5NH71l4leCgPgDt8xqhuDDv5rKCozvMIGpsf4yVIO/PLOhmKszUFPqIK9wXWIYDyxFvuwZXzmFEFsUXfUoHDmgPosiIAx1ZVcpQs0UEqIUtQJZ8eLRhuNIbgQbMATD2T+je0Ln+9tpLoORmuzeAF6C/EcvuFgGZnvfSrXoev4XTGPJMxBcfTVbV9PWizhB5+QHlDCBZrS02vmC9umER2SlUR9/o5/QTNOj0LjTh7p/njlLXGGl6KdIu6rtLZxgy2BnXysOjXjUOYN7VIN96wYFKIFX6qCq6EC7pTPkpMkB8zzJ0btSeaPkk4DtoK9rpxgsLOPYt0sUm/SrLBu3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9dzbRGVRPoshlIq97/ojCLyxRrKURhFwAZwAAYFA9es=;
 b=cW8auJQVBMqanoJNRszjtZ4n/ialrvdgiOSrb1GxNzK8w2cwaIMA96jhLKoe8QYTZt+9Sz6ILXYWGHMxsNC1gXjOLqVNSlAe7cSgpBgB6Bw/K0qeB65Mmk6Swa9ORsY0gl+7nuwYQNFLTalZBupuJLv6fG9zOKXOfN2f+O5szeMRrRzWQZ3IaLOQRrt7mIQIhsqNVmQKPqOWwndmkzz0pLRm3Mgha+8fqBB44yIdlemVs736Ia2kzGc2N97L2MW/csZydVIJW8znD8hqcYTwrB6XWp9OGwTqNaWMjYeF9/h4OzqQHLKxTi8v92yiAWgL+HflWO73EnHVBT5XWjxgdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9dzbRGVRPoshlIq97/ojCLyxRrKURhFwAZwAAYFA9es=;
 b=qQu8Km/AT4nThNg8dKz6uvw+Gb/XoAZaQmjYNeJUOs7BjY/yarvzVnadPnLzkRd/GdFctAtp4yKAIpiss6pHfE5xwfiDbRomFIQllPCNTjJkiQIRT2hbXp9C6scs7/TwdXkF5Za/1Fe+Kshq9tcvCcXG7kt3Gaj7ZsHdYjCHwjsSQsAxblO3k3DZYDZ6Eu5FBHACcw2AMLorbRt9FLN6RMfTU6XjhrLg5EOZrp5CEpCsaeVODVYhC+cccks9faWH0gjb4yo6x1RSu/TAvDKjPkDt+iMfgYs+JuQIjhKwly7INMPJ5YM8TU5avCeL+HZ8Iw0rBVwn/V2i9wox+r364w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL0PR12MB5538.namprd12.prod.outlook.com (2603:10b6:208:1c9::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.21; Mon, 6 Dec
 2021 23:55:54 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::d8be:e4e4:ce53:6d11]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::d8be:e4e4:ce53:6d11%5]) with mapi id 15.20.4755.022; Mon, 6 Dec 2021
 23:55:54 +0000
Date:   Mon, 6 Dec 2021 19:55:52 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     mustafa.ismail@intel.com, shiraz.saleem@intel.com,
        linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] RDMA/irdma: Fix the type used to declare a bitmap
Message-ID: <20211206235552.GA2174882@nvidia.com>
References: <574b773fe7ced0cc87f1e1832350b38374815bd4.1638647428.git.christophe.jaillet@wanadoo.fr>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <574b773fe7ced0cc87f1e1832350b38374815bd4.1638647428.git.christophe.jaillet@wanadoo.fr>
X-ClientProxiedBy: BL0PR02CA0010.namprd02.prod.outlook.com
 (2603:10b6:207:3c::23) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
Received: from mlx.ziepe.ca (142.162.113.129) by BL0PR02CA0010.namprd02.prod.outlook.com (2603:10b6:207:3c::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.23 via Frontend Transport; Mon, 6 Dec 2021 23:55:53 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1muNpo-0097nQ-O5; Mon, 06 Dec 2021 19:55:52 -0400
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6fc72b64-699f-43b0-9f29-08d9b913f037
X-MS-TrafficTypeDiagnostic: BL0PR12MB5538:EE_
X-Microsoft-Antispam-PRVS: <BL0PR12MB55380DFFB9A8C5ACA7F0DE40C26D9@BL0PR12MB5538.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tlWB+nSiLpInaK/I3yOMsmCoqYrzSe0Eiv9jF6C2Lx+wtTUu0Vjz2bxIhIaDZRFGYWJ8AFnz6EM8vgIdSbvfPDhpkYWFDRoK4naEjhJgm44lNjLgr2IybxI/r42gQOEW0XGH71pwNK6H+WZ6VNqb0FS4BaIzvqi/8qk+S1TDIYy2gv1hEKpKRvlO6C+35DkmPKY2aH8It6w1QenKrm+XMZPnOPPZe0ozkqU1ZMqx45vXX1y2JEd7iOykhMrdiyIbaACpSgR1JFf9VGSpr5mvJJBa/ulY4dS/0mAsbK6Ziuz6kBpmb5rYVNQWHBRvNtLJgTYwaEMS0ZV7qllyP38N1eyuBUN2pPnIWXEi8ghTN10PnGlvVPOKp4Osr/igfGl660KhKblVMzP6jw/I0FqvxfVASycDY+PAGeZlHZNT1unNp66/3M8PdGYL/y8QaGH9kdNMdVevrTFGFIgk2MSgwLlhWa64F/jd7ICJDetqY6I/U4CbUyjmJBmSCco/qDTyH14VvjlWidz+HnJlcH+g/DggTbO7H7AOxgoeFKWr7exoRRjcguN27xPfaI9hPbzGl4do+UDZGcEwP4gfAz6A1yEn5HoVZEcB4qvVF8rOuXQtQRMkFT/uNbR+R2txlOnfd6utP64hJQUIAAt/PpY6uw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5506.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(426003)(38100700002)(186003)(5660300002)(6916009)(83380400001)(2616005)(33656002)(4326008)(8676002)(26005)(36756003)(86362001)(316002)(66556008)(66476007)(66946007)(9746002)(508600001)(4744005)(9786002)(2906002)(1076003)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?dG3t2KiJbgKD3mJEHSeHSGgdq5ktOsttpy/i5B79PQpS+VB/pro1hyNua36u?=
 =?us-ascii?Q?m8bwh5BydafW9W3ifbcxzE+naj2f1T5Jwsp9QJrtPvcPqwKKEnsu/d23fgrx?=
 =?us-ascii?Q?QVae7sWpcY9UD9yysQ2mzDGjdr//hZYJSLOk61E6V3pMXOczUchbzsSJSt6m?=
 =?us-ascii?Q?aDhNdXgo48M9W3+u010S9MnLqDrHxgj33ZeSA/Re9gvzVtKHThLjy5Ug/9BJ?=
 =?us-ascii?Q?iR3JftpXcurYPJ4Fnr/sp8R6krQYq9ezpCGJ4ke/Eya5XJxcOU4sdy5jk+JL?=
 =?us-ascii?Q?ej6RRkVYIIeU8sIPUDnEMfwYRaY904FOzPRzr3Fv7zlJL8dC9CMgTRfKWAe9?=
 =?us-ascii?Q?3Gnmhcb2H+lTepZiKLJT7XwwZx//u+ckDSIHqgGv8j1kYQIJLn4p6GWhdNg/?=
 =?us-ascii?Q?BYdJA8RfSmzkYUvxL5fs83TDeBo2chVCsiqhBj7z2pmcFpjdc0lErJEX5oX2?=
 =?us-ascii?Q?uMVhPWfkzjYGsQeClAqGrhhxJ4kfjxHZkUostVd8gpC5lk2T2rYh7gEuzuJ+?=
 =?us-ascii?Q?F61UNvgfl0m1ZipkZFg+uK8vPZkQBHCaxQySiQb2wF8Hl+dRL7XkGHmsvm6h?=
 =?us-ascii?Q?05ApD9kMEln3GhqKV8kLx8TbRIa5PeDJjg0FZk5mlNQuHWSQSbOdvwLvLbW3?=
 =?us-ascii?Q?clT/M4lPgaxjMPGxmQA1lCxNRabPDrrr9AUeDbdUiu296yO3mWm+CIm5FWdK?=
 =?us-ascii?Q?ZqYMC+2sesh0gGzI7pjiHP5PgdRtX3NSqSxm+C0reMHbYPqjcoCTuQMeB/I0?=
 =?us-ascii?Q?ygX3u/5XxAErSVSYCgx+DK11nfG5IXmnGb9Cwv7ip77/0CRbDcUrQermc3mH?=
 =?us-ascii?Q?zec2VVqEN4EbjfUjFE+xcr3czISEMAVGzsXkSqdIQFYFZhRNMqU7UB9MoiPT?=
 =?us-ascii?Q?SUXojMDyEnjzlnF9onZysrkTUHtUv7Q9G4Fdk+E03N8qU4OvomC9UMfz5uqn?=
 =?us-ascii?Q?tPHKDm5MpkHqPwgc5VDSnL4hZZckoYbQT14UPLGL8gTb0QVQtEOMi5oGVhBS?=
 =?us-ascii?Q?JHIhel2DO7cKk3szJG/UGAGO5hoWqdeR/qBnZEsBfv7uPilrvJl19fjziXa9?=
 =?us-ascii?Q?KnihOQsYwRrDqcdGvLwjeC1tCTxnOHmRSxIWOvmRopTy7jnH0V1McWzRhZrm?=
 =?us-ascii?Q?vxQ3K9aOfFkH6cjz29LhcHPYLlgPQDrZvlaisRlxdmmsN4DrnXecHROQcWs+?=
 =?us-ascii?Q?wYbg8tJGoBxFbtWu+6gKxthgbg0bfiY7DXIGZLas/7hhl5JlcyPn+1duI8Jh?=
 =?us-ascii?Q?GQWqlexHdoki0csy58R8bianETKmYBhL85nxlpwQRDK3fGxXiszfiG05Ibqs?=
 =?us-ascii?Q?RGvEVA8LBxHDBSPV0yHlx49QSqhg8BHBQifRb5RLqsX6FPaqDst/A3Qn6t/u?=
 =?us-ascii?Q?rzQSAN3DREGopon6S6fsvJYvnnFhWIKPkRKgjbiWEoQFBU4H7ixTbULgFFuF?=
 =?us-ascii?Q?2vtQvbXZAF5gtTKzerV9Ri8bt/HFib5QDHEjaZGDE2Et7FE+neEn7ss5BFBs?=
 =?us-ascii?Q?5+24yuTp34HErHVq0z9UFaUiuqS7BVLrm0D8NccRLvnHUFqhKb86DxA2OULQ?=
 =?us-ascii?Q?V+H+43VCfnEVfopsNI8=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6fc72b64-699f-43b0-9f29-08d9b913f037
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Dec 2021 23:55:53.9860
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mzQNAqnUZsKvq+BZY3wk+AdpvFUkSKZnhbqOLIXp7AMfvqfZyF022fAEKSp9t3CN
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB5538
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sat, Dec 04, 2021 at 08:51:34PM +0100, Christophe JAILLET wrote:
> 'bitmapbuf' is really used as a bitmap, so it should be defined as a
> 'unsigned long *' to be more consistent with the bitmap API.
> 
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---
>  drivers/infiniband/hw/irdma/pble.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied to for-next, thanks

Jason
