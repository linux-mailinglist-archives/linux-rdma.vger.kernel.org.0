Return-Path: <linux-rdma+bounces-4527-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3937395D15D
	for <lists+linux-rdma@lfdr.de>; Fri, 23 Aug 2024 17:29:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C1265B2232E
	for <lists+linux-rdma@lfdr.de>; Fri, 23 Aug 2024 15:25:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62EB1188A32;
	Fri, 23 Aug 2024 15:25:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="tNhVr/cN"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2063.outbound.protection.outlook.com [40.107.243.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A95C5185E65;
	Fri, 23 Aug 2024 15:25:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724426709; cv=fail; b=k4dHYNy8XC1NskyS2cAlO51qBoOjEhgv1hi/ZqK11aHsYg77+40DG/nh96A+/Ql+U0oQ+FaMhvb1ibrb2OZ9Jc7VMKpPryhZVLLVrwhrqSwadlqtngKIgyKmpSUKs/ZuunLXBRDE+ztxOx2syJVA7UQIT1LEO5szXjgC2Yucj1Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724426709; c=relaxed/simple;
	bh=8s4ZR2Bt4jbghJdcXsT6UQiCbJkYkGynB8jPceoC4a4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=vAHtjef6DVxnqaoL10OD+5Va+FwXgDdwwGXDij46zTht/NZx3YIYVDMcrm3bU4/42xikUTvQQ6wxyN1izrUYK3xg4V8J0Sg6ptEIeCsHSshS/lEY3xIk3PF+F1iPtu2/TdWs4/6GMZcrVamqSZErnR0zE+s/QWzE52G5Jb13eG8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=tNhVr/cN; arc=fail smtp.client-ip=40.107.243.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ISe3qHvUkjFVtVrW5uXlSA1eek996rdZ+ZuUdCAyiszMSziARRfTZh4yHwc+QMM8yOSZGDirL3dvSrlBL5RLClG9sM1X5S3A2uFRwfOWGdKV2peNK8rMpMn2MCPlR/OLu0GcE9K2zZc7azVx7eKA+INWImOVcFNU5XA1iXmXZsmwrbpsc7wIiyzZbt7XK/1V8AS2PjT1Q/aUDFAQIO5D6b40ZN16ylXrdM5kAP7WuRfhjgmlNgY75rhGlnsFMSOr5svxLwuaBiYNASnfL4xrTeo8CarZXLHaesiKr3x/m+JXhCggFCC3hXupwNkQ/dilZZCVRq61Ud9YGtg4NBdW3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O+hqEY/T5xzEncM6ip5syM+M+HFGqyz1EFV36mQn/5w=;
 b=LVk692fOLFYdMjXl+42KsA53rKkc14ax897XKe4cnXC8CGjnqRxbuGZ4hXyT7G5bEXRlGwtEeGdvNIu7ZMXsoeMbypOghxwjyG7WfVeCaKRZyAT7yKG9WrAe0PGbjxyfRZ3nYixGZKNXBBuQEY+iIZtCi7EJ4qU2WaGMDC8Q47VJ/PPbZYX4rv2e6aH8+KJAbBLcQ384kBtv4M5B1ChnmMiR3spllCCS3nyYfEBhi/IBm4Xb8rhRnLOXrnW2RDyuu6cLCcvZ+511f+CF1LJ80FxwP7jFf1goJmJjpEKWG3b9SOthME4gKV1yG1eKQyjJ+9uO4kCX+q9e+PR3gtFFng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O+hqEY/T5xzEncM6ip5syM+M+HFGqyz1EFV36mQn/5w=;
 b=tNhVr/cN2htoo+j57QpHrsASkh6ch1EWa5DiOLsaW24TldQsaq8VP9XQZK6egbDBdNAjpvKyxegAWQ2lI+8dkQCMkfB73Kl5kn+sSuqf7eJM9FEJaGr4V0vu3NsRuBZHQtxspjcNz+jb0/8PnlcJkhfTFUJvAp5x+HUHs2B3C7JLv3WxRLGAINIbZgNRK8bbZTOJ7XZGG306yNIZ2iZOtyK0KKoEvKDo2gFWnBTHUqSf5HveUGtHpu+ZWyn3En2D3E0TeYKqcNhY3bv55o6Obdv3ihNFcZ2jFZxVZACp5jn+A4a0WGgRpeFFzJJzf3Fp19+rM+sERVIk0jlhh6YcNQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB7763.namprd12.prod.outlook.com (2603:10b6:610:145::10)
 by DS0PR12MB7608.namprd12.prod.outlook.com (2603:10b6:8:13b::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.19; Fri, 23 Aug
 2024 15:25:02 +0000
Received: from CH3PR12MB7763.namprd12.prod.outlook.com
 ([fe80::8b63:dd80:c182:4ce8]) by CH3PR12MB7763.namprd12.prod.outlook.com
 ([fe80::8b63:dd80:c182:4ce8%3]) with mapi id 15.20.7897.014; Fri, 23 Aug 2024
 15:25:02 +0000
Date: Fri, 23 Aug 2024 12:25:01 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Junxian Huang <huangjunxian6@hisilicon.com>
Cc: leon@kernel.org, linux-rdma@vger.kernel.org, linuxarm@huawei.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 for-next 1/3] RDMA/core: Provide
 rdma_user_mmap_disassociate() to disassociate mmap pages
Message-ID: <20240823152501.GB2342875@nvidia.com>
References: <20240812125640.1003948-1-huangjunxian6@hisilicon.com>
 <20240812125640.1003948-2-huangjunxian6@hisilicon.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240812125640.1003948-2-huangjunxian6@hisilicon.com>
X-ClientProxiedBy: BL1PR13CA0158.namprd13.prod.outlook.com
 (2603:10b6:208:2bd::13) To CH3PR12MB7763.namprd12.prod.outlook.com
 (2603:10b6:610:145::10)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB7763:EE_|DS0PR12MB7608:EE_
X-MS-Office365-Filtering-Correlation-Id: 6a4ba929-d8a0-42bf-0d1b-08dcc387c241
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?OIOT6agjeTqSJbIthmUQWERFJUmeucarzhauxv9pp6AhHUDYziO+C4G57/7N?=
 =?us-ascii?Q?Dv+n6zSvvcp8tzzyX2HfDKkcJZ+zFjwiJA4SQ5gc0zsHTSPTNn5hX9CScn12?=
 =?us-ascii?Q?MQ7r38J7T4RmLtBjCu5HYINsB3pqaGglAm/l/DNThl8hj/55eSPbOiTrRON2?=
 =?us-ascii?Q?ShHL5pdsvMaVjcG+tc6EjKFrVGso16oXQ2+UDMus1nZcTp4C2B/WjpiL76Cu?=
 =?us-ascii?Q?5wuQ2mWwt6mYwq4hw6PEZ1bVxQvfEWKJEe2FNhN7JoPi1zQIlLgK8S5Ie1kQ?=
 =?us-ascii?Q?LORVIjmkopWf2wwacZXe9QU//nWrKknGxX4SDmOipqabqUQ8WC/7Jslu2Axx?=
 =?us-ascii?Q?C7QCsdCAI88t7TIrT7o7goNgMn0vJpU5VK+fqRZsA/OPGuTcSD43uRetJBNu?=
 =?us-ascii?Q?786eENtsk6hWl0AlrX4F5ag0JPYIIBFnej8fxMRuWgh8Z7HKPVgWzyONazvz?=
 =?us-ascii?Q?W+VuYHKactIpMkRjgeSyd6ocHVrRbGHA2RiBAlD3J49Kcybt7rJBngzMcdGQ?=
 =?us-ascii?Q?R7BXVh9/hEKYWU5gFwL2YxwhV02SGFr9OE4JctZ8Y4mdumikz5qTnCvwdI7S?=
 =?us-ascii?Q?EZb0Y/VgUU87iZefxzoBiFpe+u31BtYcWK0/AOWGWahhNL1iyNhMHqQUO6Lk?=
 =?us-ascii?Q?27qE0ttEdQz3VDPHtUAF+xuojla4iDtFDJjeOgUATUEtoeeOxORwU+eb6hsr?=
 =?us-ascii?Q?R/XYF6uM8A5h24DMEyBKtZ5OIzCc98oPXLW9vVnYtEF/918OB5srL2wowPVz?=
 =?us-ascii?Q?+PAYYxt8QT5WTkvSzMN/ZlrFZ8H72vTzbyfqBurUanMjyLF4IHaxNvDw//LX?=
 =?us-ascii?Q?GYeJs7Tsg+7Fe1BmyaBxngffpdtQuIQPh/bEgTbmm96KK0t3obhRTKlqNfHO?=
 =?us-ascii?Q?ZRLHpR7WQTGeDljkj5HUD8lewAJxapwO6xGI3qP4CVLfVgG6CIFPnxmjs7jI?=
 =?us-ascii?Q?Ea6er7K1fSdtMUe0LjVbDK07Uj2xeVCTe3P3WskijqBhvwiq+PQn0Lglkhl5?=
 =?us-ascii?Q?coMC5iyyqXSuG6QZjbc1YUKT2RY37n7XTX76XiinvUJPsSkW8QLrlrD2NvxS?=
 =?us-ascii?Q?TRMJpAkUTNEinUJcxqOn1xMJ7nsfxKc4zhbRrtC81FklKJiGGsLx3oSHWcua?=
 =?us-ascii?Q?Kj0M3mArOJaKOot3FOnm2/Ap5xO6d+axjt+LvcSbiHsEgzWCMv0meYhAUhcg?=
 =?us-ascii?Q?IMZFabqM2RsOrx+UR9bk78jYvsqjJvBNaI7P6kkwS3vC191r5/+lb+jMR8xx?=
 =?us-ascii?Q?JH3mb1nl17RENz8jtrNk2KvEHVT1/yoFjg4l7awHrAb9tBxyTFI584a/Zklt?=
 =?us-ascii?Q?0uhUS0wLdDmshb8qYv5N0LznrW+Mg3NRi0SvZBmtNc+zew=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB7763.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?6R+En9ly3dXJcKcLWPMzunmv8BCU5YHhyCymqaNOZzs6A/uRNSJ65KKMOsgx?=
 =?us-ascii?Q?Dxvob0rw7Tfw5q+T70HgLSfcCoe9DSMy/+pNAmD7Z2lIR9+QDuHQvTGNHcFO?=
 =?us-ascii?Q?Hb9HnijelDd4b95RzYgLOjntPIwIMu7EmHd+Sm2d8miunnrgf4YsHE7dvIxe?=
 =?us-ascii?Q?VH1me2z0mVnGpl1l51o3injDWL60OUcHMDn8qp7wIkoBEDk4GRbVA7Gbjxhx?=
 =?us-ascii?Q?VcIXxlEGYnGwtxx7HntWOaa2DPjvwo3zXquz9zZDyb2UfW7gURkbgJuGdqYl?=
 =?us-ascii?Q?pqflFyjge263TYS9Fl5XjDaFjogEsTM84rCjleSB3baINS5687Kru2/JJ6K7?=
 =?us-ascii?Q?eOYQFqCvJloE1t1jSKrvWyC8RuIHC58AtTnICUSjzji4J3cDCis5hqBmzFjK?=
 =?us-ascii?Q?My8RFeDzxVM2/DbjZkYmPARKfbyYEQCmeSYWfX+vHH8+FZpbOqsDeHO7ecdv?=
 =?us-ascii?Q?36HPdut8sDfXENuLWV4njbUmM5hs1nW9J4nlXh2/sRVyrVeeFvUrFy74AqQJ?=
 =?us-ascii?Q?mV5AWAfR3LZ+HfmtZd69tjbO4wROsoZC9Gj/QdavJ/I94RRpBYudfWb7da1T?=
 =?us-ascii?Q?cRVBarnuDUTzxutlioMdcCo1lff3/9unvzpJgOYBhp84Fg9uub/HQ1PAef7W?=
 =?us-ascii?Q?gedTHW+r6aE0huLTvuOGdUkcZqROBN/izKACPWP+9S2RI0+dei6aqHEbxtNY?=
 =?us-ascii?Q?e6jl3zytnJ+07R7FIUBnmWxbjv0LhOX+B/QXvK5LiGcUO6IM8rOs+yHV1UXT?=
 =?us-ascii?Q?z7Px5MDw5nQvMkPSMg5tuCY9wI+IMT1a5bqyLVMGPKmngBxhyml6GIQIC9AW?=
 =?us-ascii?Q?K9hmkKIfmdhVHOgQ139IDlspsnc3Sgd5uZQmJ3blocq4RaetnVIFKW7kEwLa?=
 =?us-ascii?Q?2fQnPEdhRUtkmsPvbq9332M2sLwj3kc3F6VZDBlK5SfqVLSQndh+Mq9BoV4j?=
 =?us-ascii?Q?hO82UufPIkLzdCFbn3aMge2BBVuKooxW7hyaLBJYhbEmSoZlgETGeH2h3lQj?=
 =?us-ascii?Q?rfd54WjDHvknX/Ig5WQZcugO9HGfhoYuxpdEQ/qB+dGOj1x9if+zfOek83+X?=
 =?us-ascii?Q?DbK77ZfjSzE6DxxjVeGnqXi6A4LN3/19rbp/+EHAZgGzdR13Z6XQCKjhDtDS?=
 =?us-ascii?Q?vuqHMNvU0hNZ5B7VMH121L4VNiZlxoHejcMXqCbi/kK60yGOGEn66BoMySfI?=
 =?us-ascii?Q?OTgk5sMgj1UJ20aqbpIKHcYwrkG9PWjRknVFQrPTBszeYGUbAwW2IUwkhb6T?=
 =?us-ascii?Q?JFJviq1+il3EnojjsbktV49AYsebdgm5T7pQmL6R6LHk0zSnWWDWOr3G1gC9?=
 =?us-ascii?Q?KFZilYJCZT2A6qd0T4T0a9yb1zLzgYpraiPFuBQbPpQJPTew1h6oQQ9Z3M1K?=
 =?us-ascii?Q?nEjebynUwsc+40fasydYjvkrt/lPLgamwDIvwAJHk7kvUd4450B1Ediur1e6?=
 =?us-ascii?Q?/oO6oP5mybhlOi9fqTjmvsY48I1I81IFMH9/atUm1FfUFjAlTs0p/iz7zx3A?=
 =?us-ascii?Q?s6CXcrsH4BVjHeOeuZ6xqV6nwIugaTh7kYMMO4bPqMuQvgBS9icW4xy2Dsk+?=
 =?us-ascii?Q?41FLACaH78NWlym5eUqmjaipoL1bZhy7H1ryrnec?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a4ba929-d8a0-42bf-0d1b-08dcc387c241
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB7763.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2024 15:25:02.7962
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XjjRZQ2wcMqXE9iYJLvCG/eNTTZroB0wQTD2F9/JAkf2ijIvlXBF6+kCMF5zd1SD
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7608

On Mon, Aug 12, 2024 at 08:56:38PM +0800, Junxian Huang wrote:
> From: Chengchang Tang <tangchengchang@huawei.com>
> 
> Provide a new api rdma_user_mmap_disassociate() for drivers to
> disassociate mmap pages for ucontext.
> 
> Signed-off-by: Chengchang Tang <tangchengchang@huawei.com>
> Signed-off-by: Junxian Huang <huangjunxian6@hisilicon.com>
> ---
>  drivers/infiniband/core/uverbs_main.c | 21 +++++++++++++++++++++
>  include/rdma/ib_verbs.h               |  1 +
>  2 files changed, 22 insertions(+)
> 
> diff --git a/drivers/infiniband/core/uverbs_main.c b/drivers/infiniband/core/uverbs_main.c
> index bc099287de9a..00dab5bfb78c 100644
> --- a/drivers/infiniband/core/uverbs_main.c
> +++ b/drivers/infiniband/core/uverbs_main.c
> @@ -880,6 +880,27 @@ void uverbs_user_mmap_disassociate(struct ib_uverbs_file *ufile)
>  	}
>  }
>  
> +/**
> + * rdma_user_mmap_disassociate() - disassociate the mmap from the ucontext.
> + *
> + * @ucontext: associated user context.
> + *
> + * This function should be called by drivers that need to disable mmap for
> + * some ucontexts.
> + */
> +void rdma_user_mmap_disassociate(struct ib_ucontext *ucontext)
> +{
> +	struct ib_uverbs_file *ufile = ucontext->ufile;
> +
> +	/* Racing with uverbs_destroy_ufile_hw */
> +	if (!down_read_trylock(&ufile->hw_destroy_rwsem))
> +		return;

This is not quite right here, in the other cases lock failure is
aborting an operation that is about to start, in this case we are must
ensure the zap completed otherwise we break the contract of no mmaps
upon return.

So at least this needs to be a naked down_read()

But..

That lock lockdep assertion in uverbs_user_mmap_disassociate() I think
was supposed to say the write side is held, which we can't actually
get here.

This is because the nasty algorithm works by pulling things off the
list, if we don't have a lock then one thread could be working on an
item while another thread is unaware which will also break the
contract.

You may need to add a dedicated mutex inside
uverbs_user_mmap_disassociate() and not try to re-use
hw_destroy_rwsem.

Jason

