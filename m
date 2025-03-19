Return-Path: <linux-rdma+bounces-8836-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C6DE4A69652
	for <lists+linux-rdma@lfdr.de>; Wed, 19 Mar 2025 18:24:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EFED217E567
	for <lists+linux-rdma@lfdr.de>; Wed, 19 Mar 2025 17:24:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A7611EB5F9;
	Wed, 19 Mar 2025 17:23:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="FLu5MPo0"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2063.outbound.protection.outlook.com [40.107.244.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 673641F4CB1
	for <linux-rdma@vger.kernel.org>; Wed, 19 Mar 2025 17:23:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742405034; cv=fail; b=YHLWcIMuUoi7D53ztm1kPwi5yvtq8AyDiOabxHGYLMfdDaiiV8Mbr83ajn+M2rmZF56b4VqyczKowj9PhEP4qHuRPmwl6gA25nz+CU3zJ2oER10C26MHlsb2sxnKjCLa77EkakYyaEXgZVyhj5CTnvfv7097uLHggOnSWUx6Db0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742405034; c=relaxed/simple;
	bh=Z5kfeJhvDt5gJ+s2hysLVG9vuvVFL9V6b3wIxdKMnlw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Qh5xutHuSB3aC9OveqbK8xBht3hVC9AvWyDEfx1K8+sgGesrjleANaueDai/dV6KtnyhgNIgusWGy3Y3+szju7+CQKRj6Z+tav6Z3CMkNz1Z1Ufi7JmqLmG6POJXb5NVqbax51A+p1juSv6C7rekZJI+OKuofUN9nqsp6nhbFHk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=FLu5MPo0; arc=fail smtp.client-ip=40.107.244.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fRwFTxcRTKZGzMc1Ef6Az45igGOhNXCQbLs2/aqSwqj24+sH5cnZRsZpdzHMtOksl95U6Mwy2eMiMWMvO0GbCryQNykxkoiWsRG7LGO9FWNV+dGjfRel7NAzSUBzRVCtIVc92aiqbrsRZz3hK8ssuHM5YlQuLnUvs6hV1W6hTHe6HsJ4OKzgpnBIMoyNPdAtB+N3nJy7yGStSt33Mgx+CazMJsSONCLLCf2P2mQ4vOBs3R4cpQo14iv4hPFKrRY/oaJfeUyurLHR0QJ2LZoiTxZTBmDpk8tNorSfZSbWnUGI844q9HcekTTu/mcxsXyqyzkzvHynxLABpgliSLEbiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Kp9xLlLZqtWlkqQrY+rbED1N1LCJiPY89YaMsWbohs4=;
 b=IEpx+cICXnbtJs2AEGCTD/HURE3tNRRk/UeIK1omdnt35OaZo4KdfOwl0veRDqT1s7I4prbMDEBbfFxk6kYNApwoW4i44zts2Y76K5eWxiZDveJXBPH6swHGFbvSXIV4iGyOD/BGG9gwkwKZAxaTmVEiLNVGhoGX+jmaxK13YPvfFJDbW2q5ZhZsHSGRdtYl75s7IQ5hnbiZI/a2jdiuDHiHrKiLxGnd9ja2ayVmunbLWsIckdRqQ1lNQ67P70g7JQmY5xWtqlS1mSbuAi/IkD3Gp4Sh835Rso++7kurOd0WZXyrlIQDOXxFIh8C/XX8iwtas4ZRTb6p8hNf9gKvFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Kp9xLlLZqtWlkqQrY+rbED1N1LCJiPY89YaMsWbohs4=;
 b=FLu5MPo0lCu7s4VlUnTXd7mdoO36LC25kji7jUQ0eTfFSg2WsbH0gMFKcp474I79cuHxeATMUxvZcBOEio2vgFVsYHENaJ6pdiMkjajqngSuWHGTUTNZfJ/vNDRYqgqkR4QaCKAF44nLMrf8wcwJA7ex/1mvHhgmZXWP4riRgAGAS4613204kBQThUCvNErThujMVqrWHEQKo3ejM+xOtoaqBPnSlegGFaYi5XvbVNftSBFjGPoDv5L9EdouQQ/yesoo6gJtni3jZqQ1d1jdFUyWZHtnf5K6aH3B8wXJbrQZqL5h7K1YjrQpE+TA3MqVObTBM3guv01v89RD+OAang==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by CY8PR12MB7612.namprd12.prod.outlook.com (2603:10b6:930:9c::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.33; Wed, 19 Mar
 2025 17:23:51 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%4]) with mapi id 15.20.8534.034; Wed, 19 Mar 2025
 17:23:50 +0000
Date: Wed, 19 Mar 2025 14:23:49 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Leon Romanovsky <leon@kernel.org>
Cc: Shay Drory <shayd@nvidia.com>, linux-rdma@vger.kernel.org
Subject: Re: [PATCH rdma-next] RDMA/core: Silence oversized kvmalloc() warning
Message-ID: <20250319172349.GM9311@nvidia.com>
References: <c6cb92379de668be94894f49c2cfa40e73f94d56.1742388096.git.leonro@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c6cb92379de668be94894f49c2cfa40e73f94d56.1742388096.git.leonro@nvidia.com>
X-ClientProxiedBy: MN0P223CA0013.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:208:52b::15) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|CY8PR12MB7612:EE_
X-MS-Office365-Filtering-Correlation-Id: e85c2d8a-80a8-4b98-e96e-08dd670ad0cf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?aCqJ3L1DZY5Kr2xKnQpQigOFOE+TIWOZV05zyj1MOWFMWHqho8xQJXr4HzQg?=
 =?us-ascii?Q?eiur1jcvblW6Pxd7EklIXgckujOyCfg+fPgGt1fybv4mdT9V8Yg/t2HXJ8Q5?=
 =?us-ascii?Q?pkf/PsK23S23pyXAGESMmOayynw+uzIIjeblT3laWGmUFdZMjqhNqkmrVDrW?=
 =?us-ascii?Q?N5ZNouX2iTnIzRvYFCR9qccO+xdelCBbPIUAxhLGdunXLDr6oTUn38hNxTfE?=
 =?us-ascii?Q?IMq9PvSvB8mXRHuOq3It3H8yHsrmXvN90Ti/KECgvUA4RF4Xb+fZKy5FbjEl?=
 =?us-ascii?Q?heLv3+hdlo0vRUQ+Cr3wWM4lVTRteflANkQ6tY0raEV0RaQ2U/b0E1BFTijl?=
 =?us-ascii?Q?XVSu4PCpiygFLN0JOd3C9TzkRp+qu/3qTobZE10/gkTvSLRcB87DSIK9XIFb?=
 =?us-ascii?Q?TIO2BM2lA4mpge4LYHDoqbp0t36QsX6PVTHTREaKYP3oE29hJVaMKA8kK24+?=
 =?us-ascii?Q?j0HmE+HEbsEnIP/bGmuo7KhLAxIHxm6yE83R0IeurzU4hL6Mxbrx87VPPg26?=
 =?us-ascii?Q?YaOCKK8TA7IXMndC2KRT22ZxXQjm441WQr0PhQvtccTcU4iU6o5mYXCmIq0X?=
 =?us-ascii?Q?cJaqCFc74JAbsCi+AeHAHez8xztj0R9c0BcMRA9cPyLU2CwAOGf3XOglXeOU?=
 =?us-ascii?Q?Cr9oKKEXqIMFdiv30rEahot48w8b9WqNrzLlUN0gG9eNh1HMm+qc+bfqbR08?=
 =?us-ascii?Q?sJ+kJAp5baUiMrqJFSRDHvrkJXDmi6RVDn9+GL4YOKukMdaDtNnOVcfK7qlN?=
 =?us-ascii?Q?c+wEswcJw1T2/uVvi7mZeInwKoayjPn+0RtyXBKVz438Jbv4KKPNjpvRi2pl?=
 =?us-ascii?Q?GYIYAmLIUMdlkw2bkP75SA6PiYe71sf7ydtcIEUh3o3+kEOjBTOYrxa6vlS4?=
 =?us-ascii?Q?xvklGseVYIhw7M0jLcgvCr6Zf6swhRzzh065oDWb3fdSqVUcjNaOyfGmpYX1?=
 =?us-ascii?Q?ZOLTSweCFzdLLuHBMcKeFptY903Zo3Bx72+SU+lFyY5sQrlMXtYsDupxuAR4?=
 =?us-ascii?Q?INWZLafosY+PcsB/dvF1aAOxceizKbZUdrCom4LNBk+UgZbM6A26EMZJaXXY?=
 =?us-ascii?Q?L/nzunpPAmN55mIebWOHD1zHky6hIGh9F+HaVCJW2IIG5gVYrRs4KU7xLP1w?=
 =?us-ascii?Q?Hz3/t9s0hOQdCBkbd3wctR+3WDbs4+XzbD7YGorRzNFcFwrtZ9QqjTvG99iX?=
 =?us-ascii?Q?UYhjIf4IEgK0ncahcwswJmu+ETWoZzMrRirwCuFRWU6w1Uub/NR7KblmajbM?=
 =?us-ascii?Q?Ho4cQPPZ9QwLG3ootVtMW3jQtYnViyO1MD/ebsTTJK6DUkneBYL0xi1E9ZkM?=
 =?us-ascii?Q?pLDcz3eQ7W6Ga14+4ouu69YMAwAj7A+mT3pIqOwJcbe8rf79MhFMpCc7AfFk?=
 =?us-ascii?Q?hU0ycHZ6xITyTSK3F1TVJLNNQmM1?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?jeWze0h+gNZJcVe3lIWzNp1pM8vII8YadpYcpz4YbiiKz2agoTrbb2hbGk9y?=
 =?us-ascii?Q?uOW3gUBcoxweKcf2I/Eia9ZUcTftXttz93e9crNwy3rWB4JmwlD7nZyywjUn?=
 =?us-ascii?Q?Z6XURjTuYPyi0984E/jNz6zL8z1z3B2jPISYvlCDonUbt1sLX73W7+/8jkFS?=
 =?us-ascii?Q?+rCFOon28IN/2Ghv2svmmvp0Cu88NztGySUktCY/bwDQpOlY7SbFxFGXyrV6?=
 =?us-ascii?Q?DTXDzZQAQQa/vkzQCJPox7fOpkVM96PsYH//qDSoebSV0ncUdEKZRClCrsb3?=
 =?us-ascii?Q?bfmS1dLgsLA751QcqIQSq9XhgzxiArvhl8N4Nw1MXJUldktO5niOjVKZ2bfw?=
 =?us-ascii?Q?/PkmiO5o5vfjbVZnv1cSlFsNSCDXSmbZS72RazOyyVp1ndOvvHmgNmkqF9Tc?=
 =?us-ascii?Q?rbueASJuLMIPSdzlVgZsatJAPsXzNCF71UuBWMlmEKe2a/uLLINzQQOubuc/?=
 =?us-ascii?Q?QxEeC+6Nq8bMTCiDkNsTnAzJmu0tX7ebIP291EhWD2xWQR1eSAAONn9EIrx7?=
 =?us-ascii?Q?9ihhZFNNqwZZgDmNsqVZ7h5sk3sL+eHKlBuhHONwreaRD6nfOetDjx7uLMOK?=
 =?us-ascii?Q?xwAA+w/Mn2H+1bmEjkAjn53I2d2kGEmKZCvechk5FIQ/0GhbTkhN6hy1yugy?=
 =?us-ascii?Q?rnv2jCf8/WM5KpG1y9HTmvlhgiN/f7FTmjFn5DsavovRJNgvHwcQ/o1AKk/g?=
 =?us-ascii?Q?RG2HvOxiBMlWt85D7VjBlcz4X456AXr38+kV4cXvW1Y1H0bF1EyKqbpY4AFY?=
 =?us-ascii?Q?G9gDlfdp0pSfBO5Ma5cRQp+Y9r0NffYpcqNUwdl2TKppWgTp4RStt4rCL/8h?=
 =?us-ascii?Q?af0xulCuQR3FTP2IWuTnPj50D/Cx6pxDKky35bAzY7i5toxvcOZz+7AfVaYZ?=
 =?us-ascii?Q?t7y4hm53QjVBM044UBi1yedp7r0MJoYPXs2/MOPNmJr87yxqp6flTY3bB/oa?=
 =?us-ascii?Q?cIkJKoqfFpFuWAg6JquUBN1t86QZBMJUZmHUavEtHGCeaUuUWkqIRjw1bjDA?=
 =?us-ascii?Q?q9+UUTBzjO/YlhbV7i5SJP4cTRzoF0UM5bMhmh/oWh9N5Q8ZcC+umO0J62f3?=
 =?us-ascii?Q?5E8mUov+SPEZ1x453U8mO7BFT+zSL07Mtxo9ft1SZEVRj5YarksaPasIJtmO?=
 =?us-ascii?Q?ymKrd7UFdZgcolmV8m0/Esp/4cuKvac+/+i8fuVF48HHC8nn6j2AijYy3l5h?=
 =?us-ascii?Q?kxS1el5XTf1OxRY6JAwezCcH/Ud42vlRK8bRPlMq+xCy1SLJmTMnfkYgwkfC?=
 =?us-ascii?Q?zNyvG8L3iDJVu0TVypGb0YaLoDwoO2apGKN8Ny+O123UWVO/5L62QfpKWoFF?=
 =?us-ascii?Q?yEsX7lwRnMuUcpHJgMgYtUvkAH74k3D6ByWzRtK2avucJLyzJYlHg2hjU8zX?=
 =?us-ascii?Q?QOTEnQN8hVgwvlFQEvs1gi96rxgmcKGcMPOoUplOoyG3xcN9Pctn3XUu7KlQ?=
 =?us-ascii?Q?UfW2OTjNlrIddNljOpVph/V2MMQQiMvS6kHsCiTKbYmm+iuTv+YdwYRcBcPQ?=
 =?us-ascii?Q?8bNtQnJJtqwsCOoCfPwGvz6uEeUrASHKxLVJWFph5ARASCIjluc8Z1nNcLF5?=
 =?us-ascii?Q?X9KpJ/6ZqZFJ/PCJjhQyapzPzgypl/mIoMeSB38s?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e85c2d8a-80a8-4b98-e96e-08dd670ad0cf
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2025 17:23:50.8962
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8m3pCMZ6VrZkRIOE+CZcaaFyQQsfTSHemr8XsOGjcVyvaWwnIoTEG8VZqxIe1/3F
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7612

On Wed, Mar 19, 2025 at 02:42:21PM +0200, Leon Romanovsky wrote:
> From: Shay Drory <shayd@nvidia.com>
> 
> syzkaller triggered an oversized kvmalloc() warning.
> Silence it by adding __GFP_NOWARN.

I don't think GFP_NOWARN is the right thing..

We've hit this before and I think we ended up adding a size limit
check prior to the kvmalloc to prevent the overflow triggered warning.

Jason

