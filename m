Return-Path: <linux-rdma+bounces-9205-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F24A4A7E98A
	for <lists+linux-rdma@lfdr.de>; Mon,  7 Apr 2025 20:13:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E115E17EBA1
	for <lists+linux-rdma@lfdr.de>; Mon,  7 Apr 2025 18:10:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0593621931E;
	Mon,  7 Apr 2025 18:09:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="HhFQKLyR"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2085.outbound.protection.outlook.com [40.107.94.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F2B522172D;
	Mon,  7 Apr 2025 18:09:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744049365; cv=fail; b=CS1H/d9gxKdRPmPkuFY7cwxU7dvBFX+C0w0dmZcvJqckuDik4xKdx0UK2AGzjuuuyWNAXr8IKxy3eHbmStAYkyFF1JrwxUUDeXMJkcvd34X0cAJl/p9Z0BIR8OdSgRGMNjIpOkp0qD5mYXC4cRQNe37G7yVbt/KI3rxtcTtr6Fw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744049365; c=relaxed/simple;
	bh=Oq/7sm2csyF4fg4GkAfAu3Zs39g8S0ucixi4jxk/4fo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=D6RNBROlVmo39esTBcGc2EQRwfgJJ9Bfv+dYfYNyyzzBktor6bVoM7XsrGhS3bY+bxVihUyE+T5hh60s/9Bz4spicKgAZJgr8ng2Kqd7xgWT8LeDKwDbXMPxIiTzJDvhgpl31Ji/xwNIG3RdeGoq42CHx+YugCTU9fnU1bWP/XY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=HhFQKLyR; arc=fail smtp.client-ip=40.107.94.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hmKGzldYXbESuD9mfNhKjUt+0mO8QTVNoBS3v3Mjiv4iK/Px0EL6DfLasw0plylyyn8C6ct9TX1rZkYD2M+JSlCN9b1FZ+pYott6PACq9OFfzDBSJAi/99bBZE4r0rzg+xdtb81myoE8wg8E3pKnkbOB7Utwd9Qd0AR7327lEKn69QIFDphQqNSNOpC/yFXWRDIYTc23ZMoyBrBwSH8flHWLAqyoZ8KdV5KCLHYkKocBcRLr/Cmj6/+gmmLmzWbwY/7jXGwEodIM0QXA2vNX3Tzz37RtBOQYvo3yHw5L2Bfeb8RazHgQ0wUi4hhz7zxICgZh2JsA4NxPjqDTMEgjvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BYMTh3c+/DFa7wkSK/oOqfOvOke+9q2YuxGEbwzmCAI=;
 b=Lo68a8wUsHV06ef83I2vPR3pZLkrxE8F94MzEHjfxH9OWWTD67nL+14nJ47lTo9w4/ICdrSDHcKuvxrrc/iLFCJ+ppCG300wpGQeBZKPX2OID5OGxlNnMKod+HeLLKrVu/RYdKIKSu0Z/zX1hwpwUAWF9rxTXdG/RA7aPRhs9NUYzPdWh2Ol9sbbIAAUxqYPwwiHjHGo8WudtiPls8Ne3gxK8WHvYjLEWMwHpSRTBBS/PrTpb9Be8ghRnh5xgaSKEohqcGcUyqzmbMxtKcRV9ahXTjUH8F4l9ukLlYHoPGAKf7eZvjvWpuUd3xBiQSLqzlcDtBvCT1ZVAvxReuUmTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BYMTh3c+/DFa7wkSK/oOqfOvOke+9q2YuxGEbwzmCAI=;
 b=HhFQKLyRSmlTVLxNx1EfOEkyShASovevHrjyC5UejUBNmfbzFnFJvjsJJ1qUEI3fXqmNV9or6Y0qV0u7LHdWq11UiY0ypXNibTLrkwVxWGJ4n0YXOwBlTJWXEu3lm6Jy1KV6AFcoBKkRVD1FCgxZxMj2H7TLCFWjtof6wFL7ZKbO8jeMOSZ6wD2PaYJWhybnZG06Q4XORY1zAOIQEHnh6MCeDbG6N2NR+ewSxE91uhBr6QiyGb4E/dTx3S4U6pjoo/6GZWttVECaSUQ+6B+YxJfcFfbpaxssIN0kUiRN++ww5clt2L9VfqVEx/PxSJ1zDMyA6VNOho5+x6WyCKfW+A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by DM4PR12MB6182.namprd12.prod.outlook.com (2603:10b6:8:a8::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.34; Mon, 7 Apr
 2025 18:09:18 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%4]) with mapi id 15.20.8606.028; Mon, 7 Apr 2025
 18:09:18 +0000
Date: Mon, 7 Apr 2025 15:09:17 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Yue Haibing <yuehaibing@huawei.com>
Cc: benve@cisco.com, neescoba@cisco.com, leon@kernel.org,
	liyuyu6@huawei.com, roland@purestorage.com, umalhi@cisco.com,
	linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
	yanjun.zhu@linux.dev
Subject: Re: [PATCH v2 -next] RDMA/usnic: Fix passing zero to PTR_ERR in
 usnic_ib_pci_probe()
Message-ID: <20250407180917.GA1761465@nvidia.com>
References: <20250324123132.2392077-1-yuehaibing@huawei.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250324123132.2392077-1-yuehaibing@huawei.com>
X-ClientProxiedBy: BN9PR03CA0603.namprd03.prod.outlook.com
 (2603:10b6:408:106::8) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|DM4PR12MB6182:EE_
X-MS-Office365-Filtering-Correlation-Id: 41b9a2e7-04ed-4027-7f11-08dd75ff5041
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?GMWumjDFYZWkpcN5RxKESKggUkQkV/GftAo9MZGCK3HdaWDeYWU0CURbJ+q4?=
 =?us-ascii?Q?yWK5l1RP5dci3EYC+ty2QzInoaOeON4QaGeJZkGQMCJmzxXGApVkj0/sY9pJ?=
 =?us-ascii?Q?3A+K+Qnof8oGFz+rFtRUJiDqFTYXdPyqTF9tbmnmKjO+QP/FXmGVChrU2NdM?=
 =?us-ascii?Q?IXJ0iBewK58SM874joR8KmA6XrmL3OhXcB9Oy1mt2Z1YDVm8Q1Z5r3jYGKfF?=
 =?us-ascii?Q?f9ABVQjdFAMGk2jQGH3NUu4laV6yu6h2Sets95+7KI2zjCYsDDwp0RXGMIlW?=
 =?us-ascii?Q?XFrgK3qLxxr2Va7tUQcIPHsMawxhiEzN0h6Z1BldlAcRRhvlqji0VFV0U9HJ?=
 =?us-ascii?Q?gy9NzRqEkrU7o/g+Z81gvSUerGRq6nHnAdL31Qrpi2/Lx/cdtJ0qT2aVEvqv?=
 =?us-ascii?Q?aQ53aiIfp8DWFX1aueiYOk78MuY7LjwIFEgNtNTkx3t8pO8RT0MySp08aq6g?=
 =?us-ascii?Q?Omaa+go7NmBwWOaXoBxjBgfjTns4GcxrXGAzsdKQi372hamSuzVWLvzM+0Kr?=
 =?us-ascii?Q?sjUKupyF3yO4GjaM02pPi9uQeWsuim8lSar3ZrfEuuf4kzNAX3KEglZr/TnH?=
 =?us-ascii?Q?6+VtvYScjPsFdOr4otmRV/DccX/802XHo6fSZV40nIAyKsPLdkdYhHOtdFPa?=
 =?us-ascii?Q?IQEfICHa5KCbM1ROl418GngiNeS0Cz+3+HgkRlcybtUisJWxz6MwYxLzqY4W?=
 =?us-ascii?Q?V01EQCHxfTzC7Kighak7up/77kZwFqDDPTNF4kk0gLtYX5vDKaK8qx+aSczm?=
 =?us-ascii?Q?ruHbNdqARFUWa92qJGd5PGuFq8/sJ4jexQr/Sg6UX8XWYb8fx2VCzQxDJruf?=
 =?us-ascii?Q?exhHkyVi8lh63fRI9QQcxs3ctzudFL6oR8vIKBoABK1iOyhjNDPQwSIiTIbv?=
 =?us-ascii?Q?15rDDPZk408NtwNMLo3er4s8HnS2IiH41TwjAGsmQXe/lWQ2jgsbpmWDZK+k?=
 =?us-ascii?Q?F8hz3Svan/xFk6bBkCQ50WbqteoWA2ApDkaIv/SiLVCiKz1MhUKTjgASE+S3?=
 =?us-ascii?Q?PBefjPjP3Khsb8r1Pr5+WZyNTThS/wYJ7WjVNFLedUAHtmSt3g/DhXA1CF8Z?=
 =?us-ascii?Q?TAO92DdEArjaInUPK1K6qDoQNZd3zVnt03BFK1zEImMEn+2Hyg5b7i1Nen6O?=
 =?us-ascii?Q?d8yPG/Zi3KdzLNnB4mEFxrT/wDbNn91NVpY8xxuWAtuRZ+bq+vSXXFKTBeFm?=
 =?us-ascii?Q?UmcY5iU0h6JnSSEl3zLNrf1TL6UdJCHi4S94yJyNgJ5JLvfsCLMSAf1wnx9q?=
 =?us-ascii?Q?Y3ewXCS0Kwvtn1A7Y6Rc5+aofvPX4P4CpcJeT2yINlXIyXPcnqv+WAKTHJFx?=
 =?us-ascii?Q?kD5Qyc7D+Sc5f/NFxqdpxw5z2E+wSr5iiaBvC+4+G40JhSgCNlpyIXJ36srI?=
 =?us-ascii?Q?t3ch/Vv2brcGm3Zldg9XTrwyLuP4?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?A6KZF6bFS9p8rml3P94VtyjQUlOGjXUhiwScmh4Yg5nmXeMY/oSMyk66AKUn?=
 =?us-ascii?Q?wjYFI07Ay92E7f5IJIQx5s6yN5NuW/aitUhTPkyQawe01qcW0fMjK7wqVmGW?=
 =?us-ascii?Q?RiLn99H+TXlWure7R/5PCHS8WY9vU+9kniAWK3DsfBjvjuNn+7wG40Jd37tz?=
 =?us-ascii?Q?Lz7vherw++wHV9UJ1yUU1x0BmcQBqMKeULmfnnBVkNIZ3VG2zhjCDXPgfDjQ?=
 =?us-ascii?Q?AvEvcLG0quLqUP7Irvp52/PQDXqIGGznUSG0ryqKH+I0AAeA//pnM/17EDsY?=
 =?us-ascii?Q?DmiqnBn6y3VQZNVmdmiiQ7ZNnGQfOe8N3nzrDhb6M2RX95zzPuJVv9ZNLMrf?=
 =?us-ascii?Q?yKPB1JaNPC9Pv8A2oLUfefkusFMyoJTRx+UcKntsnFpkhHjoB44m9IKO3vVw?=
 =?us-ascii?Q?+JolBjCgeiedMlf8yFADu5keCBPRLsesgcNARYFwzzeJ2nZpUTRaqSHGhfEr?=
 =?us-ascii?Q?TizWip4XZbAKdvnKQVIIDQzHmpvX2xYMDrAk8v+JOnpZHPMTPbr4rcCLDpCx?=
 =?us-ascii?Q?SwgqWkRZU4zeewzYSGd/6pkUdTkucUNXW9q6WxH1Hw5pZmj5cIaiH5PUxXBh?=
 =?us-ascii?Q?lYPIcQD2YAfYc0YhhIggM5BMJyEwxcgOj+aTLQ3IBdAWIdE6eaN1fVVp11hB?=
 =?us-ascii?Q?472DcVLpgWa746JRMilShTcX/ynWHxLTESCWvdHlfRGzDhgTszVfPE5IAkzV?=
 =?us-ascii?Q?B7pWMyMKqXv0LJssn1c9tiHuV2w8HNSSFlYB9SF5vHOFMgTuYcMjwtv2D5qg?=
 =?us-ascii?Q?Jjus9W+tpjhd4im6tOEOiMQ0SzUQqCelNv7K9Bfz6kKUfPS9WaW55mcGHhy1?=
 =?us-ascii?Q?RqDfx3sofp7g7dUVfSJQCfgCgmihgcah6IxMQL54CRaUGTY+0exc7VkjpTSX?=
 =?us-ascii?Q?Q9wuPs2yR0uLCoWprQYe2ORjd3Tz9hSUqCMbOkK1Ts4cGSZVAn9ZlWZEoOao?=
 =?us-ascii?Q?qoayPVo2m07dqnJTmnF27QXX7JX7TVIOXCZY07o1W2By3WI5lLtYnwxarWuN?=
 =?us-ascii?Q?bfB++Sls5i+GrwNK41lyCANRWCe6w39+h8SNl+2ge8/mP61pdEkWdV/o3mk5?=
 =?us-ascii?Q?k8vLhIdHLLx1FmUkYWC4eVgu3T8JhL4d+ZNuxMxIspB8c/TVOFmyBefqCcU9?=
 =?us-ascii?Q?RW6qLBkXdIcK7/4Y4cgAi8kspyuXiQO1bU1I2CRIlVhgPWMhQrGH+AeTd5AE?=
 =?us-ascii?Q?BR5zJcKeOAxOZvxP2CIHvL2uwH7lwUKHiWnBHBiZ3NDd/TA7fcnEtijQvZW9?=
 =?us-ascii?Q?zPas057NkGT62NYBFA/MAeWLRR6Z2SeriFb1ygKzZIMBHaeMQugvpD1N6/ej?=
 =?us-ascii?Q?HDdLgHMlNWBqnQY9ZPoL7Bfql6HFur22WtQYfFG8gvtW/YJ1xH9O0jSddyVS?=
 =?us-ascii?Q?Ua9NqM9rkBrFhAZ39iXJz0w0miEa4JixzkaU7dyoxDEkv8K37ecNuVZ/P0nW?=
 =?us-ascii?Q?mS0mxL0MUW9SeZIXgsQ/1zn8di3Ps+0YKrGD+C0SjsPtGFssnYcrLnxjoLSQ?=
 =?us-ascii?Q?7P4djeNL4xokdI+L4Au0LbY/pu9WOAvAAN8Jh13eL7PibvK7pibVZetoNn3C?=
 =?us-ascii?Q?Now3ik0Q31mBrCMC026h5cBxncukk+YOz/rFBZfT?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 41b9a2e7-04ed-4027-7f11-08dd75ff5041
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Apr 2025 18:09:18.2856
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: C7L5ZwoUrg3AlSIx6DPoYjYL/npUQLnCsm/LCQ/UdkcB6MJq9ps8q+bhEUwXgiPy
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6182

On Mon, Mar 24, 2025 at 08:31:32PM +0800, Yue Haibing wrote:
> drivers/infiniband/hw/usnic/usnic_ib_main.c:590
>  usnic_ib_pci_probe() warn: passing zero to 'PTR_ERR'
> 
> Make usnic_ib_device_add() return NULL on fail path, also remove
> useless NULL check for usnic_ib_discover_pf()
> 
> Fixes: e3cf00d0a87f ("IB/usnic: Add Cisco VIC low-level hardware driver")
> Signed-off-by: Yue Haibing <yuehaibing@huawei.com>
> Reviewed-by: Zhu Yanjun <yanjun.zhu@linux.dev>
> Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
> ---
> v2: remove useless null check for usnic_ib_discover_pf
> ---
>  drivers/infiniband/hw/usnic/usnic_ib_main.c | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)

Applied to for-rc, thanks

Jason

