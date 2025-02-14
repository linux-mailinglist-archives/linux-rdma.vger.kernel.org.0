Return-Path: <linux-rdma+bounces-7773-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C8CAA361C7
	for <lists+linux-rdma@lfdr.de>; Fri, 14 Feb 2025 16:34:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5DFB1170113
	for <lists+linux-rdma@lfdr.de>; Fri, 14 Feb 2025 15:33:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F0A1266B64;
	Fri, 14 Feb 2025 15:33:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ADX0lQY8"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2071.outbound.protection.outlook.com [40.107.93.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47DD425A2AD
	for <linux-rdma@vger.kernel.org>; Fri, 14 Feb 2025 15:33:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739547229; cv=fail; b=c8rvWFNygOpft1TCGx2BHdcz8/7/y0JNUuEbW3pmnscDbFdBrjsVbPPC7dWDTX26LqgFawyopgT0FCTQD3aRPMfEv1Lvyu0jzp3CUioDTpjpHpczmLnk/vBsIjJimKyNgBd6sgh0nzc9oA22xB7Gq8VVlSKVcVCt6IkZHKLC4/M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739547229; c=relaxed/simple;
	bh=U8Mn8y93Ye0P2IntchvgcrWjp1V+4Ueh0ndFPEA2brA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=hMKh2JRORAZ8HdbhlwocUDYBnpyczvWkZbd5qS+HI2cN8LCnDvUqkHwyFdXbY6fKXkRMQZv9U7COvsnpygujMWdFgpw9PDA7jcTvgG3tiNsXnpZQ6CPWGIkRjbIXQLU8kptK8A9cbZHHvEYKgXyDQrT7KWBDGjZLBbOgAC+cpqk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ADX0lQY8; arc=fail smtp.client-ip=40.107.93.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=m5cIyJbnWU3AJPv9pqkR5CRMs70JsW+hvkz0k43G5n5DUBz/ALyd3t9aZ8LZ/O+DcsQWpOjt2DOOPw2ps6Kw056wkc2bpJIjCRhPLhnHRRG348IJ2SOZB8kJZcZiwdkmpBH1B9zS1WoKZqzSuVKI7I9HQitB+ZjtA5GfAm8BERouBhDXGWPMAONicgdzBTjAN7NJC85W6zs4RnHpxfVBSB2U6juXbGU9Zkw8bNAAUl6FvWFtt6tnc6e4mE5tcmlLKa4Ek/z9lBTda11MuvmkuOHBAbc43aDBqvMancwl6/FkkU7vEC1dmrJn7jmU4cKBN4Ku/4eXMoKtPri04N0TKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0MVEkZPQbP9GtePI5fWiEy53JsdX51vnRpmGbmzRGpQ=;
 b=Rk0eewP3Lm95zqDf0CcVj2AaPebgFtgcSdmPdra4oOnCU8SjP74w3O7DpDx+9cKMgV05aNLCfwa15oByMy7wNxh3RghwzW7x3R0k4lnlrZY7nciF6cy51bgwLhMf3aOJMtxiKqS0zKWN3RUOyurkM0MeGPb/3M3J9+qIu3xeAIt4eXjhV3LFAdNSVXy83bfRhFwASUHQWU2cnpV0fiSVEi99e/lm8lgnLr1+Tr3RITM1YSWtPzxJeIoEDTI6RwsvE0QSfOirObr7JQvRGAfHu9LrE7zIcGc+avQm8PD08QpXe2HFv1yCEPrzKkG3IWyj+/P8CZqVbaPr9MBkcf/KvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0MVEkZPQbP9GtePI5fWiEy53JsdX51vnRpmGbmzRGpQ=;
 b=ADX0lQY8SXhSruMloCv/dTQ0/gg8EXsaexdLWQyaKdwpitdDrauvm8f0Vpawll3jEJ4Oms1h1Q+dYssMfu5z2vhfNxUNGGJPXTu1uKbh4WzJnOTOZKGiXCA/afXQ2HdzVe45be/GgQAzKM87BY8idHlZpct0v/tiVsMANxzIIjSK9L6/abGEesZhyF5/qd3qdjbKuEs/Xhbt8TvRtg4StanXDyeVMdYPomqhytlruMlsob08V7YFQdKahNUPaHxPXY2GdUVAbVaU26Vwr5QrSf+OF913jRUdscchk/H7XxyqXiyhP6WtxjyZ0WfOI2CdeKNsHaKKA82agE6oNSU7nQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by IA1PR12MB6067.namprd12.prod.outlook.com (2603:10b6:208:3ed::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.14; Fri, 14 Feb
 2025 15:33:42 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%6]) with mapi id 15.20.8445.013; Fri, 14 Feb 2025
 15:33:41 +0000
Date: Fri, 14 Feb 2025 11:33:40 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Leon Romanovsky <leon@kernel.org>
Cc: "Margolin, Michael" <mrgolin@amazon.com>, linux-rdma@vger.kernel.org,
	sleybo@amazon.com, matua@amazon.com, gal.pressman@linux.dev,
	Firas Jahjah <firasj@amazon.com>,
	Yonatan Nachum <ynachum@amazon.com>
Subject: Re: [PATCH for-next] RDMA/core: Fix best page size finding when it
 can cross SG entries
Message-ID: <20250214153340.GG3886819@nvidia.com>
References: <20250209142608.21230-1-mrgolin@amazon.com>
 <20250213125126.GK17863@unreal>
 <20250213140421.GZ3754072@nvidia.com>
 <777e5518-3f0a-43e8-b80b-0a3ba4ecf5da@amazon.com>
 <20250213144219.GB3754072@nvidia.com>
 <20250213173510.GO17863@unreal>
 <20250213174043.GG3754072@nvidia.com>
 <20250213175517.GP17863@unreal>
 <20250213181242.GF3885104@nvidia.com>
 <20250214055511.GQ17863@unreal>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250214055511.GQ17863@unreal>
X-ClientProxiedBy: BN1PR14CA0030.namprd14.prod.outlook.com
 (2603:10b6:408:e3::35) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|IA1PR12MB6067:EE_
X-MS-Office365-Filtering-Correlation-Id: a3f4a84f-0d57-4711-d955-08dd4d0cf5ce
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?FTIZlcEb42I5kIRQ8dKzq+yrboEeIUDhk/9eEeaxkHeA+oPp90Imu4E+Ii4l?=
 =?us-ascii?Q?nc2wbg6ZWhGxL2qJ8StGyYjnGdPpTxdzR6uoqqLDqtfdnYlwnm6myV68BhQ2?=
 =?us-ascii?Q?M/PUni4Egfp8/DNzt9RKfw5t/Eb7KDMI03YFlrfHHDTEgWld9R2lSkYHYpEF?=
 =?us-ascii?Q?sp3dYef7v0WSXzCvrBkcgNniHZm/L8+l1lCHhLd+fOcUqWmNadPy26J8FEkO?=
 =?us-ascii?Q?e1X2n3Re1kqnXWV0lazJhYV3cWvrdnNsFUrEkFJV7ahPH84+PnrkchcMaEN4?=
 =?us-ascii?Q?dSyc3uYnuZHBaIDgVQol31PdEjOJOsyZcpCHXElZhL7K4b0Wkfkh2GR5IVEb?=
 =?us-ascii?Q?GCHFgj8+dI2D2ZtGGBsfJixZWs3P4USFSZtZfUYKRFenOSWbwVBWnyoLQvBB?=
 =?us-ascii?Q?fkLak9dhB0ut5UPrhGBZRw1SgZZ10MMdlVEDAlWYeIJ8G8gw/T7e9adtO2ng?=
 =?us-ascii?Q?cjz9BvzncqLihi9IgSmXhT9IK2e2qjdlUfYZ4HyaCA1wQQYXnMKCtdojJa0G?=
 =?us-ascii?Q?9lFhErAZkXx5fx8hydpGh0dBs2lg+J/VxlD80B0lpJJB/Kecj3CUyFVntn+h?=
 =?us-ascii?Q?Ajo1pBwtQZZI/wZS7C+iuBk+UMSNXjfSX6XRh4z1IjbNraV35d0uZkMCts7i?=
 =?us-ascii?Q?/rb4BsiPKimNcumzK2KQEL0AwBiQXU13KDWLXak9OixKmKk1ROXVqBJs4Ckg?=
 =?us-ascii?Q?D68RcVwJgvPoC/MlQr669b+JPEuPUL618KiE+d+Su79Cpfuya+0Cb+LGaUJe?=
 =?us-ascii?Q?5HVWTCc73z1snDGt+ovdqmmEnTLrBRsNTUx9yFo/vAjYyMCvfQMJDLogz1M0?=
 =?us-ascii?Q?DhU/dAiLN1hRDWYhSzwij0rZ8YvkQCFsenlzfyBrbVM9xS+J6d/NkatFb/vm?=
 =?us-ascii?Q?55LiAJTjel3EPYMdvjozMAHf1QIBjkxikHQl6VqNfbLuCtqBHkmtmBeYajFS?=
 =?us-ascii?Q?XmYzL718PrS1NjnU+0mCnjbn4D4mBb5+VfP5Jwkvr+39NPhLtF9u5E4XJxd2?=
 =?us-ascii?Q?tD2h5+HTz+7wL8mKMtQhQCA6Tkn0RvYHsnOPljCMlbdN9pKmU46BGL6wX71r?=
 =?us-ascii?Q?CfrzTHxV26cgCQ5Zz5aDRWysxuVyntYnjOkqPNt2gWs+8VTo0Y23WID2+Cw1?=
 =?us-ascii?Q?ezJRqsiQOclnE3B7amOFUvgCIuRguGN9URjQ7PXnPw+04ACd3apwfPUKiFLB?=
 =?us-ascii?Q?7UmCLRKlgsHDzQFuDQTCz9Exh5Tb9qvtSIRWWKHitoqCl8VuTGM0TYprF4vL?=
 =?us-ascii?Q?3VW8zkTGC2ydbTpIi7nbTaIGQDaN0WiMgdY3xX2ezXXnkCcwHoO3StM3SrL1?=
 =?us-ascii?Q?YKyF98W6JPwcLrTLJGOCu+ew26TDvRncEx5T40waM0P8X6Q8gk5rEe4m9tyG?=
 =?us-ascii?Q?X55TsdRdINm8v6Pz3EfOKstJ9xlk?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?G7NyYbfjZ7FLFjgCebLlRH1qBzISkSpuAxhSAWVgvc116VyoPso/FgJce/fM?=
 =?us-ascii?Q?q47WdKCgHXWIUOyf89Rduf2L+blafU5PBxCU8zpD1x0tHthPi1ECZIdvI5Br?=
 =?us-ascii?Q?pOcm25MsawXYiHdFONvtvcXlisMQ4eJhAmuNe2kA10l3EA+3/Vm1fYQDkvkN?=
 =?us-ascii?Q?Tj3gLmvq9B8Pkw6G1oYUk27WvtaVXp51FWMWOlRrrDwctkO+nTl5vFwCx5cV?=
 =?us-ascii?Q?BKzSxUghtMTfcfb7Wikc5YIZVXbumz41HdJ3exT7ahFzNdD0+1pbq4ioPFs3?=
 =?us-ascii?Q?HfNKv7nDxB/CYpVYLTRVyzDmZggcFOPOCoGXAKtSU3tqEyAEugJtWZWI/dTv?=
 =?us-ascii?Q?St7HtxGSvX+Wa/cVNXw5cLQHzsmm8GHhgHqazgA/x1g9Yn/x71EOLze2sR2V?=
 =?us-ascii?Q?a0AFXKTHRXnxYDnLmNS+9dBRI7fuEo6I0d3B1wg35cu/s9sGkQHkn3+CFSGi?=
 =?us-ascii?Q?u0qN3G7aLig9bJg6V2Pjl3WX4ztHTqiKTJYVLx+7sk7gM5nJPVzdUBf3BboJ?=
 =?us-ascii?Q?MUIgWdBjBhNnyVlTDj9aW3C4aqN6F+VodCHZFFw1AwBJctDaT718CTMyh3HJ?=
 =?us-ascii?Q?xTRGhOp4MGU8GunQv7iwLDLVIXLangSOoIeDRN9RSPJTsIgScwbsWAfpXCuo?=
 =?us-ascii?Q?ospxNUF7Fw3aEqOXJ2mojzw6pCAgqNS0uy6FGO5td4pz/AmjluBr62RTn/si?=
 =?us-ascii?Q?SFmP48MQNv8+rgjrMPAgTFOWJAXUYo3EUc7hbZXknDlS7HKLivtcYsTyzEbJ?=
 =?us-ascii?Q?4DOuEmieYaiK+r8uc0+N+re8sIq8JKfSNvsy3YukITXJiuK8mrxT91bkprCt?=
 =?us-ascii?Q?H8rfMrQzKbBsBu3sWrqQ6HXPzRrsoLr6YUl93CtYI7/JbfVPPZHzMZR3VRLe?=
 =?us-ascii?Q?bqVocVFbfJqNdd/4JmroAHS83yxbK74BGE4kqWEw1RTc09VDs78cPn8QDDNw?=
 =?us-ascii?Q?/DikJn+T0F3OKtmRJ6IsXf0EE8rUbyZNRmE99YqK625eDWCYskSa5NiXCH17?=
 =?us-ascii?Q?Gfr9CxWv3GIP3m+6R1V1AmJ7pX7YfpubBPPWMvXV1wx67xyvS1j+mAOerSqP?=
 =?us-ascii?Q?xGMAFb7MedcfULa+VHwZ2QPTgthMbZwAuAUIEo6UwUyxMlE2vlaz+NdDJVnJ?=
 =?us-ascii?Q?6R3d/ucrlhCBKQAKFaXMpzam2RRpqyhUjk7XSKjPObrxKwa/vnFCvLATFt/t?=
 =?us-ascii?Q?BBpcKGsZjGax6PUy0mIA/wdmSSi5OdOqKpttztUzyD0iVJFamPXF+rXD1KOH?=
 =?us-ascii?Q?IQ6iqiuUT4t4SzPOgCbk9zc2N/M/9I4dB3o6yn7bh6auHFBZ8hZl/9mBI536?=
 =?us-ascii?Q?//R4Sqf2/2IDQasxEBnmRGIDy+Un5HkBK91+I5ad5oWjeSh3uy2GAcqzCPeg?=
 =?us-ascii?Q?z6zfyscgsq2q3hgjQZMJdxsStwGiYd0F/xrjMMShVH39n21VrCmfsHSSc3Nd?=
 =?us-ascii?Q?NSPddYlTV3EzChN3bnGooOMnBmCwo+nOjDtw2bZXZDQ9PJGKuP44Q3Y5Sfnl?=
 =?us-ascii?Q?hwKakYsgLyhE/NDho5onf3QiwlDdY+5XAizi5RfsZ00Ng+zImL/p4ebZzCMj?=
 =?us-ascii?Q?FohJVoabtVjxqalTws2pTdU2QnPtuDF3nYUAdYPz?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a3f4a84f-0d57-4711-d955-08dd4d0cf5ce
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2025 15:33:41.7604
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QJjpJpoieIm0IkAny34cduNRrsUnGlfRv7ZlmK96fhDvRQh8FpczhJLGwYyraCgo
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6067

On Fri, Feb 14, 2025 at 07:55:11AM +0200, Leon Romanovsky wrote:

> > The point is to detect cases where they happen to be in order because
> > they were split up due to the 32 bit limit in the sgl.
> 
> There is no promise that this split will create consecutive SG entries
> and iterator will fetch them in that order too.

Yes, that is guarenteed, if the memory is contiguous and split then
the SG entries have to be consecutive and the sg iterator has to go in
order.

Otherwise the DMA transfer would be scrambled.

In normal cases we except the SGL to already be fully aggregated so
all SGL boundaries also have a dma_addr discontinuity. This special
case of exceeding the 32 bit limit is the only time we should have
consecutive sgls that are dma_addr contiguous.

Jason

