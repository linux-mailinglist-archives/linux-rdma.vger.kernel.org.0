Return-Path: <linux-rdma+bounces-3833-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F0AE92EE00
	for <lists+linux-rdma@lfdr.de>; Thu, 11 Jul 2024 19:45:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 627CA1C21ABE
	for <lists+linux-rdma@lfdr.de>; Thu, 11 Jul 2024 17:45:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E74086EB7C;
	Thu, 11 Jul 2024 17:45:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="dtvVP2bh"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2063.outbound.protection.outlook.com [40.107.94.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C5C4288A4;
	Thu, 11 Jul 2024 17:45:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720719938; cv=fail; b=W1Sn3Q7n+PqpL209W2fajtQNFumjK48Z/0xnwrlLn0OUo+29FL6HG8gzIhnmFdNDuMbSs+kpoEOVYZEFzVzaZkPCH+xtAoX1dzz1EvSru4jt0D8AQ8fdR//dMQ/Xmn99lAbNcfC5snxsPXkDCcR5K8m+RJyrvfKZGcj8Z/Vo5GA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720719938; c=relaxed/simple;
	bh=CIriOjy+mioJvk+HagPR+B9vWfAnuCtPUqSo0T3GgcU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=sduGJ39UBpyTKKJJdzNraAoAUJr7exD9PuFLgN/syot/Q9Ea2Clz+n2L/f+rupurgHsZxnZwhi24H80XEUn3LuNuO0MBJP8cGAy7rsXdfk5fP4mRBuPJc9qXD9basx4a2/gYcjlQ7LzUQiRnFM1gRJdKJ0mtiqztZmsEhc3FEbE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=dtvVP2bh; arc=fail smtp.client-ip=40.107.94.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GnxepYu4dkNCa8bAn86uJSJr9wbU/gMTfU92Db90ReQlO+KvqtgoRNez3yCs8Cv4hKmjir3zIsdCMyaTS1eIet4TOnIMGuR3W9UN69OGS+hdMxlSgGRC4H/CiiE9YG0kEY6nmFZI5lEpXwguTGPDTUcksnek/R2dLsEqXc/8hxeBFydXpSxNmI6DR7dAN6/6im8JfthIRYwvzkGIB2xS4ZJeuqiB0AfRGF3ptM62/3a/T4Vz6RwcvZm2HNf+r6C9VWHu1kE7AFO2oSe2tq/xJVOdIMETw2Kk0WjBINeJa38jpczP67kEkeReaLQcaxQplrcmfF28y76zhJKSGXOrWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kUT6C9LSUV+AT/F1EbQBdFFU+ne/0DemPLULASrJwYQ=;
 b=fy08SW+5VFygabB5GYxCbAhqrj5jI5+LVBjSfztLb/A7jeqgtvu4uulRsyTQWzY46ZqkseH7/xgCHsc6HwgWiR5F/LJvZyF0Jg7qzpmpKCpVUGQG7xofEenTwu2gNdgBbAmCg+WDx5Jnnon8ICdK8PtuOZ8wWy6uWxl8YLJedvlNJOcQ1ERE1zO4d6IV6zuc64rQ3SwATdsBPcxdg0Yt7UxlgU2wkPD7FNjFuewckfB30c8qODNesbUdElcVv0kyoOED99fMvM6jgEUDpFlebLgB74vwutad8SAdPreOVFoYjvdzJHjJFPzxDYmUpoU+aDg8WdqJK+DcfRzDxdzPgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kUT6C9LSUV+AT/F1EbQBdFFU+ne/0DemPLULASrJwYQ=;
 b=dtvVP2bhN9dSPPlolSMxRGcOG64rHVpbRjnYm3kOzD6tvhC7Ozvj1CrLV0PJIjNrBJpxZzGuuHB58l054ScBgl7qnOzJ1dHZ2Qit2qchgLfWPPVJsNIwiYnayp0pHP+YDbaVvhqNGBTUnUuCpbmMEE6PiyJtq2PYCZK8Z4lTgzlqjMu/aG2VSwqAzxSlFir0tMIpRxOAK5LRT47f7wqMcE0oKbOIwzBuiIOoSX7e+vUN74son1qU4GrJPbuR9asy0NTIosdeZz4lUnzMxtvUKbxvZhGKx/UsJfoYv1wMEDhJ0pQMsseQA1NfSkFgIEcaELTlPRJwVemV64j+fzfe9w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3849.namprd12.prod.outlook.com (2603:10b6:5:1c7::26)
 by MN2PR12MB4437.namprd12.prod.outlook.com (2603:10b6:208:26f::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.23; Thu, 11 Jul
 2024 17:45:33 +0000
Received: from DM6PR12MB3849.namprd12.prod.outlook.com
 ([fe80::c296:774b:a5fc:965e]) by DM6PR12MB3849.namprd12.prod.outlook.com
 ([fe80::c296:774b:a5fc:965e%5]) with mapi id 15.20.7741.033; Thu, 11 Jul 2024
 17:45:33 +0000
Date: Thu, 11 Jul 2024 14:45:31 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Dan Williams <dan.j.williams@intel.com>,
	James Bottomley <James.Bottomley@hansenpartnership.com>,
	ksummit@lists.linux.dev, linux-cxl@vger.kernel.org,
	linux-rdma@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [MAINTAINERS SUMMIT] Device Passthrough Considered Harmful?
Message-ID: <20240711174531.GH1482543@nvidia.com>
References: <668c67a324609_ed99294c0@dwillia2-xfh.jf.intel.com.notmuch>
 <3b9631cf12f451fc08f410255ebbba23081ada7c.camel@HansenPartnership.com>
 <668db67196ca3_1bc8329416@dwillia2-xfh.jf.intel.com.notmuch>
 <20240710142238.00007295@Huawei.com>
 <20240711150559.GF1482543@nvidia.com>
 <20240711180100.00006b96@Huawei.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240711180100.00006b96@Huawei.com>
X-ClientProxiedBy: MN2PR15CA0037.namprd15.prod.outlook.com
 (2603:10b6:208:237::6) To DM6PR12MB3849.namprd12.prod.outlook.com
 (2603:10b6:5:1c7::26)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB3849:EE_|MN2PR12MB4437:EE_
X-MS-Office365-Filtering-Correlation-Id: 15abda18-6fca-4c9c-ad99-08dca1d14388
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?sUzXcaWssFvoXpyWDATSRD1HZYP+cs26JaCe57qQS1rlarFB5m70BZm5GFLR?=
 =?us-ascii?Q?jfFAsGJCQzevnnurOf5qwb0NlNBk057YxOEPuD6OQ1Gy0rusgQfKSoElefWt?=
 =?us-ascii?Q?XnHeQzsCECxs8C4nKGPI1RDS1Q2dAgYRSYMfAnzkqjDCdlBkebA6BJ3kZm2q?=
 =?us-ascii?Q?GRZvLkpmz5FoQh00aUT9roafzHQAIZ5wnBrVY4ckBS8VebYroHuIeDMNsjNe?=
 =?us-ascii?Q?hCkG+prclh1cw3amrFd9EJ57HaBVx6/qxnNxDDlX5Dr2rismPUI+kmLQ4t0P?=
 =?us-ascii?Q?IeHNBHJuQLgSW970O4gncwmH9ObfXzYtfvVvmiISmhos/Qrs9Wg8PGH5WUvh?=
 =?us-ascii?Q?vlBSV1tUkKH5Xg5qlJvLqbfB4F+rxq8PMPDAwxyRkJKtHrtdBXQZLHTbApgk?=
 =?us-ascii?Q?KjBIJU+jRk9szLe1m7tcImpccgXw07QEN4SZ5AmBqdzRpWfhYOEiWvTfT01s?=
 =?us-ascii?Q?t/I14oPOZx/gF5uhkl3OOTJQvL/SBoUiWv6hJYRXpwgJUxoyA4IzDkJq9NvX?=
 =?us-ascii?Q?fX1rJWZFx0P2Ivs7j9bELqTSWKLRHTibFZ8EMWbk9c1bEF4dAvPJMsby3yb1?=
 =?us-ascii?Q?tvcdyFlnEn8JzA+s0IEA6OnIFwV3J6o3hWzBktYuGfaXR+3SwwtCUXRlUu6g?=
 =?us-ascii?Q?o9ZEbtWOx1j0y5wjR20BSS2vcBMciaCXqhsvyWzrYqy3BzACkwFLCrpE+nhW?=
 =?us-ascii?Q?6e5Jnb95Z225xjMH+EgL+SS+fJg7GfWJs/OKMeBfEraQOP0BaDI7Lp0mjWNO?=
 =?us-ascii?Q?twH+V2WUCHDsgSCMLTtIxNho5olVQKcj2U80C6EAdbiunbHzH1CBDvJfC+r9?=
 =?us-ascii?Q?mvtv0MrPk2GgrNMMgisJua8be4zRDqw99JUo2RipYFv/9tX2ECKuXrbFy+Ul?=
 =?us-ascii?Q?0BlC+aLhAzSnSmHGW+CdoI8ycLD90NiuP8GLeleWZoVvNDAp1mmaVMjrR/zq?=
 =?us-ascii?Q?yoiotfZN2PngEUK3l6THO1gpRtAPugssx1zta5WRDoW9Mwdnr2LkP9PnYoc1?=
 =?us-ascii?Q?n2gE/SpDCjKOevqgVIQL3iiTQGjSLBdVcXRWqgj+mRth1LZwuaFmS3DxRqeS?=
 =?us-ascii?Q?yES+DPDCAX2ZSsqaEQXF3I7yQQpBvLR2uXESTs89dy7xSEkoz1TRhZsbuNgX?=
 =?us-ascii?Q?YvHMTDYE5pk4VE+bu95ovNxsvR4t/Ob7p0sjD8UJikUCt2tUucTHztoPMIPR?=
 =?us-ascii?Q?VlMqaogrlJly4asDBTnwtBpoz6LRBjt3HUvGIgpZNjNnZRhKS+b47zGAfl3k?=
 =?us-ascii?Q?tyDUsR+T/2Up08BzMu5Y5aI0PmF+bhNblbDCK1VDsDnVwYevGcMMoW9RzCIt?=
 =?us-ascii?Q?f0xe1KUq5FHkHnb0ak6qL1zj6mtX/8xx9PdLYeBQOqgu7Q=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3849.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?fxebsZ3W2X4amgpm+FJ7Q+0kq4RWHfrc/VyYn5wZACM53e3Yk9pgVCHsYuGH?=
 =?us-ascii?Q?f83jLe8U+j02ePlNbJ1eRJJoC1MXOLDN1THWPZZ6clwy7ItIGuAm5OQbdJWN?=
 =?us-ascii?Q?8jEEqPJjr39R6x9dlZnFjZHk6p5XWW17HDBr1qdcQQDDXEqqZmCk0tHI5VLp?=
 =?us-ascii?Q?2GwN4XBOw+4LIAraZjB4lD5REyev6lodmv/hKKiL91LyfJiQZ1qzNSBb9s6R?=
 =?us-ascii?Q?bv0QyRtTAsfW5zNcBbFgO97OBGjCFrQbehNtR1Ru0w+g30u4yxP+oCidh742?=
 =?us-ascii?Q?6OfL/v31o8j0aYTY9VBkn/SNNdZuyyeNg9uW9V+MTG5DKjgh/S4QTeziIJuj?=
 =?us-ascii?Q?SNi1Xb/n1CKVTxDxgbiDcNzr7+evUIYvnOKej2tRnmPHSVm1D2txBXp0Jjku?=
 =?us-ascii?Q?+WhH9qw5dtHgUqX+u+S/Lt8uozayxoG8D6/GLoOXIk3K3xeqmF+mrVnewsEX?=
 =?us-ascii?Q?strS4++WuG/W803t2wBczNmvodadT0SrawCNUpMAxET53GiYm+fF9QfSL8Bj?=
 =?us-ascii?Q?4FYokYWLzk5jkK+nk0f+Dfkryoa22uSE7jHuqzqzaqIzGtk7G6Ez6DIZ06m+?=
 =?us-ascii?Q?IdOcwaMhfQ/y2yaKis7OLa/x0HN3A0CcRH1QyRY/yw0zumjgKemWOkPtn5DI?=
 =?us-ascii?Q?I6Ed5h8wQMXqLzuxsE8VpCV0T1aGVusyTw/wGeMvQvPm4Bom0l9aQt6k6Loj?=
 =?us-ascii?Q?IAXSfnBMgscrNV88T9h+i4yVoIJuL6h1H7XFF4gqaMwGpBTMAxumERkjl/r2?=
 =?us-ascii?Q?UtYVWeC4YeMSTWxAuKydrQQbd0RchkUB1e1nVO4tMaRizvUhQughIIM3BVh4?=
 =?us-ascii?Q?cK24liq7JI6KfkTOKGDjnWlyt/yKg5hPFqhO6g1mbYr/ENlqpAh1e+rOSPQ4?=
 =?us-ascii?Q?ajexoaQt5hi+bPiFspOQ6VDjSH2szpCUnXoSICVHtiK+w7fnxpQg0ZLIbuaW?=
 =?us-ascii?Q?Vtsw0r/ZQ86NNMUicErgmY0p9eInyCjWMkhmFQNjMEU1XzIZoz4jLv0W3nHd?=
 =?us-ascii?Q?ExEgmVxIOof5wWl8scM2pI2DVYKJWU8VhmUwdBUPcIFYYSieoLgmBLZktiOS?=
 =?us-ascii?Q?KmXBB9n/i+xVAL6qOOAsczPUSVo6bnBrFHoThbcRB89TNxCziG35jVbFiiAx?=
 =?us-ascii?Q?psh4qa9qDgwMHQBeYRU92euDniZ72zD2jFxmSMPiHJN3PGmJouDX5oQopWWW?=
 =?us-ascii?Q?IuOZzZZUYJIH07vswmm7dYWOzw5IifXzw98sVvChrRE6J2i75MUtQJVBWFZq?=
 =?us-ascii?Q?U2U62XOn9+Vs9kxLwH917nTTOWWFr23aquRSiD9J0PCGJ7+336nE9M/kTfEr?=
 =?us-ascii?Q?XbIc2Xp2sBtmSrmsm/3q1Ip8rzozUSfQ6+UQwmUc9/g1ao8fMETawBBiSL4Y?=
 =?us-ascii?Q?3YO9cnmCyB8RBy7F4AVMMjVgBeQlfwzcCy+OF/CcXeJleVVcQfqMOCtUwBVQ?=
 =?us-ascii?Q?O2TE6gwvUE8Hh6XykQ5JTBk4wfn/zMr4/LloX9Z4S/BuXpRQCdRY4lVyajdd?=
 =?us-ascii?Q?P0GGRmHaSHGu/dfgo25h7ickM1LamYxehuN9X8VOWxGiMxGNZ4viFOrha8pu?=
 =?us-ascii?Q?Tyv2oJQX7T3zmABSUT8iBFljvBxK2c8eNtEMiMNc?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 15abda18-6fca-4c9c-ad99-08dca1d14388
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3849.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2024 17:45:33.4278
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NOxxr8tuKJlm/iNe+/+WBbS3ecPVriad7rqE4GcDMorjGARYwe/vdj7beT4KPqHo
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4437

On Thu, Jul 11, 2024 at 06:01:00PM +0100, Jonathan Cameron wrote:

> Control plane for the nasty stuff should all be in control
> of one entity in the system - termed a fabric manager.
> 
> > 
> > Sounds sketchy to me :)
> 
> Yes. The model is with the intent that this is only exposed by
> hardware to a BMC / Fabric Manager - so security is by wiring.

If you rely on physical seperation then I'd say that the Linux who
gets access to that physical HW should have rights to operate it, even
from userspace. You may say only root/user/label should have those
special rights, but it is kind of baked into the model that the
special physical connection lets you harm other nodes too.

It is important to think what things should be in fwctl, if I were to
take a similar situation for IB, the fabric manager plugs into
/dev/infiniband/umad* and that is the special interface for exchanging
packets between nodes to do fabric management.

But IB has a well defined container for fabric management and it is
easy to steer things into proper places.

Jason

