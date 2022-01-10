Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 90316489DDE
	for <lists+linux-rdma@lfdr.de>; Mon, 10 Jan 2022 17:49:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237756AbiAJQtt (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 10 Jan 2022 11:49:49 -0500
Received: from mail-mw2nam10on2088.outbound.protection.outlook.com ([40.107.94.88]:3649
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S237732AbiAJQto (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 10 Jan 2022 11:49:44 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nEHcIWTKkPCja/1JrNj45YITPkmUSNvsBP8SPGFzpnTrbfVkTcSG0ku6ul+F4JrV8ASlqjUBQT+sFrHmB+wJEFPWk1TvR2nK01okHcnKrCdy6X31hrASI3j2d8jFR816AtJs49xYh5LPQI1PtlAVnPrayplxhAXgTlOEHOsACTua9O9M0LK5mCU6XULyj8pQ2O3dowVmdvdAdEKmAhu5zonUCdoG2mdXAhBnH41TYz13D2++owijTvnQGqbnVkSuxkPuAiIeEYAWtoGeUw+Y5vDy2KL5KB/P8s0LVf/PYspK8ETwfauBWA9SLnd730CG61plnk59JNelinkneEyJjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bF6jhgeObkA+3IcJ+hDUHjMr/RXWJhE2saYZdpmkE9M=;
 b=m7J7RIj7FHzRPTPwfVZqRrLJF0CIxGilAYuJZI7zGQA+4mVW6OgVnybyarUYm+RJbGXq0zke2V6gelVkpA6jp8agQkdT7YwIJ1rEq0z6ygdLVvu/7HMsD8X6a9lh8QKMpfzdWM7OZGoP3NI8JmTbKhVQLWwZlteQMIQKgjyhB3ks9ga6BHc83Xw6mlDTVYC3ZxsOqlL6L55H1HQ+1p2gwMrt/P0E+ASqGUT1iKZVG5w/PPbA4XksASWbhUxYHXQVaP+g7vC2dF301i9R/cvI+znzU26RFuRdfaKO/aYSBgOwM1MSQ7kxm2RILZzAO3VVei9CUd3gJoeg1MY5eZpizw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bF6jhgeObkA+3IcJ+hDUHjMr/RXWJhE2saYZdpmkE9M=;
 b=oN+clnAgmaBMsq+viupWkzLfu1iZqzgLKCpERjAqE5UYyu9zlVi0vF51qH7p+lCQFhABfEWRy6lDjWCCPU1V6oswhQMrFcWuHXci4msy/o9XonpcmcPNpyJJb2AdgKy5Oo2bIn4XkEqbo4+3vwFFHlr97LnqzDdhNwKZd80HczElS66ua+9ALG/dSf7LIMPcMv3n/NtNdgM+yvn1ZApM1j5rrpfVCyxyshZlwKbqZxTOwEyCwOF8qFc7CyCcVx0UEftvPwgjTwHE9zy2cAi47ZaFJh1sgBO8Yu9CBXM/hI2nN6NyEo96St9dhxUYDl5TjEGwkpjo58z5ovcGHW3Nbw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL1PR12MB5350.namprd12.prod.outlook.com (2603:10b6:208:31d::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.11; Mon, 10 Jan
 2022 16:49:43 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::464:eb3d:1fde:e6af]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::464:eb3d:1fde:e6af%5]) with mapi id 15.20.4867.012; Mon, 10 Jan 2022
 16:49:43 +0000
Date:   Mon, 10 Jan 2022 12:49:41 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     yanjun.zhu@linux.dev
Cc:     mustafa.ismail@intel.com, shiraz.saleem@intel.com,
        linux-rdma@vger.kernel.org
Subject: Re: [PATCH 1/1] RDMA/irdma: Remove the redundant return
Message-ID: <20220110164941.GA3303175@nvidia.com>
References: <20220110073733.3221379-1-yanjun.zhu@linux.dev>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220110073733.3221379-1-yanjun.zhu@linux.dev>
X-ClientProxiedBy: BL0PR1501CA0035.namprd15.prod.outlook.com
 (2603:10b6:207:17::48) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a1244eff-4370-477c-4009-08d9d4593355
X-MS-TrafficTypeDiagnostic: BL1PR12MB5350:EE_
X-Microsoft-Antispam-PRVS: <BL1PR12MB5350403543E23588635E1157C2509@BL1PR12MB5350.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3383;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IFxxNyAPO3Nz+BD+n4tJgge1WYr3+ekEyjlAmz9vBBTJmPJTLWN8xORhlt+poiS2BHxGtNPatCyBvjpELB7nr1JLLJmU8j8tiJqoEoZzAgPeREwc+p80anDNTf3Evmt35TcE+KJTh5o+LHd1WG4Lnq8JzxdcvQXhaPppH14NFCDcPs0OBk495crrUWy+awVww+15jOXy9R82E5VobryTHESitEmaOaZBV1JkuQdkoYHdooclwp+iIEDGQxD4a+yQJFHr5vIcNl//88701wJZY20Fq/MpT9EpMiqdkw8wiDGs+8kBOnLcILrBEz9oCTKk/TIWraCKEKd/012Bf0Iud7MOFmQAH2bj/ZAqhRsxE7DAXgGKLsy3HfJlPpaOZjg7vQIw99b2NL065dMu2I2LeO0lRVIem6sAGMw2XQa/1lNJYvXfjhu1rcC9twevZR2HtHnWn+NBgA6jUGU/mpswKOXtxmFuGu3ygcV2H+9Cvh6ZWYv23kxLgD7p5TdnGZikUUKolfNeBO3bgPcbv5W9hHIULCYJna+UujqmTshr4Op2WWbRVPCPUti2vICnP0yYYgLa1qXpVfqbnxfWNZMdCJ0W/9ByNWqRNIMhowAQj5lMXZgP539q+rxBJMXghWU004/J0DXblltwkAc9KtbnNA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5506.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(38100700002)(2906002)(186003)(6512007)(6916009)(66556008)(508600001)(5660300002)(4326008)(33656002)(86362001)(1076003)(66946007)(83380400001)(4744005)(36756003)(316002)(2616005)(8936002)(66476007)(6506007)(26005)(6486002)(8676002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?mdJR6tSz/kM4G6Z5REUGEVePX7pBenVGDPUBn5SXzYs0FgnnGqcfAnYZZNA5?=
 =?us-ascii?Q?owy3/al5mYY15xujPlJkVWSKFms8DWIciIGxjx7y/Zd3TWvZvRV358JzRuAL?=
 =?us-ascii?Q?d88VCp9TnUMT894CvRYTu45YXZ9xEXBZgDHjwUvNza06EmUazizFqkajpKky?=
 =?us-ascii?Q?WEoWgw4fXM3pZPFTGq2gdpOdMM0igF3LRSaim+yN5n5cQ6c+TPTqgafaBIAc?=
 =?us-ascii?Q?ghdLypebhU9+qzKY/XnkXBdHKJo0U6iycpzEvfW30aM+br+VxnhL+9H1KtF4?=
 =?us-ascii?Q?4k6pTf0dLVCkVG3CmWK8pMzrk4F4mvrxcKrLW37/2cVvOrz+khmvRFe0+Fq2?=
 =?us-ascii?Q?qZtj+XFJA0om1NZpNrLRXjQlVo2cu/q45vdIq8nqBA/r602Ph9XDynI9iKff?=
 =?us-ascii?Q?9kkAb4xT+fh2RTbiAeellDNtu7D9IRmepXpfeshIWdsoNoGBAce2v54ZnAEv?=
 =?us-ascii?Q?fpBS43bX3eBRe9xYKTlp8Vjrywv6qqjLTwnlkT5LYB6k5mOVIxCHVsV4MENX?=
 =?us-ascii?Q?ofbPwbZUzUK0FP4ScdxjwmxlTIznoV5b8mgPvfhv2KOuxZzQc2DMPscm7DUI?=
 =?us-ascii?Q?W3RcAK/5PlMtwaqkKH60fDgHP2gwYodnnfkSSyKjmD8PpzuCON1lig5ff6nV?=
 =?us-ascii?Q?04C6dVtimyPjAaTp+zffilsT6zIwovW7x80W/+Zm8YMSMPUIf70GvQeuCneA?=
 =?us-ascii?Q?1UkcrJI6Pl7A49XwxTiX7gyebqNKmZocQgY7mn6KLkJfLnn5SSOLXvU7SsmN?=
 =?us-ascii?Q?lW5XVPW5MIJM3Vyyeat/yVSp4rTtqoDAMY4H67kY++7B+TLQ+eCcoA2qgH9Y?=
 =?us-ascii?Q?mJFqg8P10Dy+hYAOhQTxpVhvvg5EM48YqQ6mbkP8EUqq0KUi7kSJgetAqxcs?=
 =?us-ascii?Q?s6Nlmzc8K572b1UWkJzV2gJ61z+lkyElyWCJJzmNnnkXU3sArEPfXjhyHjAM?=
 =?us-ascii?Q?Ffn9k17YMV1M5pXLR4HOhIoD2VslIoTfABfr9mow0aYmCKpz4D0V4FTg3AWh?=
 =?us-ascii?Q?I+vPPlbB8ile1MAnBUn2CtFJNhH5h6ZuTSps4QToTS6Q/C/d33HZb045/o3n?=
 =?us-ascii?Q?qUjNxNvgorKPjCX0Qgn8M+8gWFUjeTZg276V+sZRKk43kYqOopxI1plk04tr?=
 =?us-ascii?Q?+wDO4hDXZepABgxuQZKFlm4KkMgMdLALXPbHjEzA3BUUjTUjBnghr1WFqguI?=
 =?us-ascii?Q?zT29t8zBBj5shF29B3ZrUSC5HoBmOgRppLCPjCA+nT+n4bGzKf/XeaV/I2ar?=
 =?us-ascii?Q?eDGUOkJY4qsLZ4NjM8bmhnbEP68PO/ols3FrRGFlaU+xA21pPKeW3aILz8jX?=
 =?us-ascii?Q?dChjrET8iC2ErWd1oJhSwg3n0wfE4h6/q2lrh1fwgXU99Z5E/LghEi3Jd1R3?=
 =?us-ascii?Q?aX684qRBR07qc39RIzClTqdzQuLRXUAPRjoyjvqhaU2lrrYopraS0YWxv7O7?=
 =?us-ascii?Q?ejPuS5+psz+NYDnOJE+RrZbRyymVjXGrmuyW+zqjmyyylUWx2feS/SHILxBY?=
 =?us-ascii?Q?GN4F7CrpL0QFkWQ+xYW/9sx1p442bBc1LXufZLB+ou3cPZsdEFeNERACYf/v?=
 =?us-ascii?Q?8SWDY6tUpkGnvIFAfYo=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a1244eff-4370-477c-4009-08d9d4593355
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2022 16:49:43.0538
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: t9HoH0/m3g2Fih0AI9Sfii1gdbqZGzXpn9ydq/xhSLGnlRMTXwkBXEcTdotpwED8
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5350
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Jan 10, 2022 at 02:37:33AM -0500, yanjun.zhu@linux.dev wrote:
> From: Zhu Yanjun <yanjun.zhu@linux.dev>
> 
> The type of the function i40iw_remove is void. So remove
> the unnecessary return.
> 
> Signed-off-by: Zhu Yanjun <yanjun.zhu@linux.dev>
> Reviewed-by: Leon Romanovsky <leonro@nvidia.com>
> Acked-by: Shiraz Saleem <shiraz.saleem@intel.com>
> ---
>  drivers/infiniband/hw/irdma/i40iw_if.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied to for-next, thanks

Jason
