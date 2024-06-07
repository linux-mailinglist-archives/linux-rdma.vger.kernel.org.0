Return-Path: <linux-rdma+bounces-3003-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CF83900B46
	for <lists+linux-rdma@lfdr.de>; Fri,  7 Jun 2024 19:30:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AC7611F23DAE
	for <lists+linux-rdma@lfdr.de>; Fri,  7 Jun 2024 17:30:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7EFD19B5A8;
	Fri,  7 Jun 2024 17:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="OvQSsdSa"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2063.outbound.protection.outlook.com [40.107.94.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D20C19B59A;
	Fri,  7 Jun 2024 17:30:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717781413; cv=fail; b=EY/Vi1CFfS5u9kfPrSXyJSzpdludzzt0NuIx2SxzFyMgPLKOIkHoRSPyn105K6d9ofnsPtWJFW8zYHudUsk/9veqUuYI0y4u8/561qZ1xmMpJYTp8RcVsO0DvLG/kWdmU+T2JU4vymkmurHWrp9oXpNf3+5sU2aF+ncld0IwSLg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717781413; c=relaxed/simple;
	bh=VM1wuIth5tmM9rq9flvNYzJAZGj+31wZWcHVur1ePZo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=r932zSdDGjadMtuqzi9Vixsm0VspjlwIQB7KqPdbeHvkuL3sPjkKUekAi1Dv6ksYZwemQqSCoi8gEM6st8G5lh5uNiaFWya9fSMKSyquSGX5WjQwSxkQpA0fM5PrKnnhfi3rYI5vmPwb74vhJ4rZv2/EkuQDmt2qIIo0oK1BjTI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=OvQSsdSa; arc=fail smtp.client-ip=40.107.94.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H8FtmifH0VauEzVq3MKvLEnLJUNwAAj6t91kbC4kOC3cgjzE4Tic4UQeywfTt1pZVP03m7vzft/P8cAbj0xhZ1u+P4ePvo7q4h+oi5FOnltWt1K1O9MhtcBZlsaykaar1f5x5UWeGJPlUJedsDZzvQSy0hbnZMUKFtjjmcD1kysfMAKYsP6lT1kS9p18Sm/wAwHTsCRCmFzLGMve7D9owmEm6BUeSysfcHhEAeLZecFTPZwyNR81FuzYY9WlkCPfQMlaFmVs2Cb+Cy8R++3QSNLVazW3wODkFwjaQ4XYHWYNC5RhTlwyvTLNtTwFtwEBlul/MQm49F9q4aCJ9nZSPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iZm/HPK2JorY4UQ4bsoU2FQ6APwsUTbk/4w4AASBPXo=;
 b=Uw0tOO9SK5woBeP9p15X01nH2tzf/XYLoFPPmd99PSBah2fnPDA9F+w/IlZeowZG4Js393zW5peO3Di62wtXN9UGEbNdtRzWyD3zgwqxCIDP+zMgMyMM83Byn49S83FWtmoWwbNaSwS+ewYYsGgTPyy9f2phX8rqqz7Spb9R5Nab9ATrUuRuZXlnzAtzKLdHcIYxUrnznUmGu24XrTfSkbm/jBFo5k+JK4FjXDaXnhkXvjrCzTsjD7NdH5gtep7IGQQBOeCR1JV+BNjM0mIIvKc0gNWax79NKO/faeFtG7I4dvgwG10+ST869aHJw5W8nTKkgdxDNDqjlhseBRms7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iZm/HPK2JorY4UQ4bsoU2FQ6APwsUTbk/4w4AASBPXo=;
 b=OvQSsdSaL9/SKdGVY9pX4Eliu8qpXM/iEOps8ApSIki60e0TFc2zQaoJo1feyvbEFs2shNj1wtwbj3fYNQAXKc6nZO5iH4qTEQ3V7e/YljUM6OBWG8psSdFtThmDeGYjdF+DDXeC5PfVxCtC/rGt3vnrotG2OI+KPtoS8veO0yBJkH3A0uFExAXZ7+x1ZutWqOXXn9ctoCAkBXllfyZ9FJ9krfrRW4df5+OqQiPnSuKpMVr1vQekCoAVMe1jDzaXBrt6oxi/4T+bySS/ktn8CAZgQ4Yter26TiU4GSDjKdzJZc990u4No19kOOlo+eBrr+3xKI7wvaHcrHUoZd/5dg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3849.namprd12.prod.outlook.com (2603:10b6:5:1c7::26)
 by SN7PR12MB7911.namprd12.prod.outlook.com (2603:10b6:806:32a::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.22; Fri, 7 Jun
 2024 17:30:04 +0000
Received: from DM6PR12MB3849.namprd12.prod.outlook.com
 ([fe80::c296:774b:a5fc:965e]) by DM6PR12MB3849.namprd12.prod.outlook.com
 ([fe80::c296:774b:a5fc:965e%4]) with mapi id 15.20.7633.033; Fri, 7 Jun 2024
 17:30:04 +0000
Date: Fri, 7 Jun 2024 14:30:03 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Leon Romanovsky <leon@kernel.org>
Cc: Jianbo Liu <jianbol@nvidia.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, linux-rdma@vger.kernel.org,
	netdev@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Tariq Toukan <tariqt@nvidia.com>
Subject: Re: [PATCH rdma-next 2/3] IB/mlx5: Create UMR QP just before first
 reg_mr occurs
Message-ID: <20240607173003.GN19897@nvidia.com>
References: <cover.1717409369.git.leon@kernel.org>
 <55d3c4f8a542fd974d8a4c5816eccfb318a59b38.1717409369.git.leon@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <55d3c4f8a542fd974d8a4c5816eccfb318a59b38.1717409369.git.leon@kernel.org>
X-ClientProxiedBy: MN2PR10CA0036.namprd10.prod.outlook.com
 (2603:10b6:208:120::49) To DM6PR12MB3849.namprd12.prod.outlook.com
 (2603:10b6:5:1c7::26)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB3849:EE_|SN7PR12MB7911:EE_
X-MS-Office365-Filtering-Correlation-Id: 3d9ec9c5-02ed-4f4d-4398-08dc8717779a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|1800799015|376005;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?HogeLhlMj6p+czbLpBCgK474S3hRcD/GL3kQnFScb7a84jwu0rPv+vQyn5FW?=
 =?us-ascii?Q?ZvR9mk+4L5evtdXP/PlGsKbO4pAjVi57avmTSQUX0GrRw5FPUgdASB+T0WUL?=
 =?us-ascii?Q?8ybYnLPzrxGOPkksd1rDEvtY8MWGK3XoTQ8iudmvCXcrOy256/gmSY7ceDpm?=
 =?us-ascii?Q?ZVHh4QGldFc+eRctzRrlWxkCkM0br/10aTUh2cdLGV3wjFyad1nYBiIdl+qs?=
 =?us-ascii?Q?unA93FKAPzirbwMfJJdRJKVhSbt2/FavZBL6BguoxnuKiLue66f3db7rYQxD?=
 =?us-ascii?Q?sRYJ/dtadBikP0oWQDCOO4zQHFS5M94CYUQfioO7JMk6fm2UpVHCtJilxaSu?=
 =?us-ascii?Q?JCn6CWTb+N3THaQUtHxBj4uNZPb078xNP6bNs/ousb46ZA3Wfnb26usv5d3h?=
 =?us-ascii?Q?VHHyDilOx9xYXghYLcJBdDs67OoRl9EXE/ycikt/GItdYexNGruQA1YEPajN?=
 =?us-ascii?Q?cnSOKCHuiI96EOqOF1BnsKmstxfhmzcA/tCYAWP3cBs32Fibv/wcTmtAEg5+?=
 =?us-ascii?Q?NBSQBLfCuf7WLeUagIUZFQZimrSw85rVJuyH2bmLH9vfopN7gukMXUrYTqHR?=
 =?us-ascii?Q?5zYPb92Bw+gh53cXnpUbZsjorrFm0xagj5Fe0qnNtmAzFTttEmoPLuFEYQkE?=
 =?us-ascii?Q?oeM5NYnsg+5KWUzw5vnPpX9nM3aOWCyq7K7QzHMHtRy6CjEbRVcrsbUosBCo?=
 =?us-ascii?Q?YyuXMOR3l0pNTe9FSU/urpIwRpcOro64ML49XpJtQwmaPtsarKSGhcsbxHFO?=
 =?us-ascii?Q?//cCdo7kgipb3M4bqSg9PNtXSLaA/nVXwssre9fFCMpZdsCIPlESmTRW1xbz?=
 =?us-ascii?Q?U0d1BoUpThW8wZqdmQQKNB0B8Ljmb0tcIj7Z1q4dc3te6n3mynj6to8WiKKb?=
 =?us-ascii?Q?jbg5Vr8hO56IGfj/w6xrvAQJlQh1ruoHK3CwQYicBOb9LxgX0sQxX+p1lPpn?=
 =?us-ascii?Q?VAIJ0sadNmnoxgLra3qmlQdiNLRYMNrECpEGvdPK4IWx4FR2I++5vrI+O6NA?=
 =?us-ascii?Q?7PZJJgrCLxq8CiQsV449w6QLjivV7wz9fIOuDD7wPKJjxxS0ppKLWKZRDhDg?=
 =?us-ascii?Q?UWTdYd8ad7EXCx3/n1M+uMYe8a3hrvuBtmZJqB8+FhwjUjg/tZgkN4h29AJ0?=
 =?us-ascii?Q?Yy0c0/VmIPL7oMzGOVmgeW3a/vcVuuFBdsiKHpRLfQIjRxXqFLSa+3fZjDsj?=
 =?us-ascii?Q?uLM27GL8hRhHIPvrbv3zldXpnaDzwHhAqIZsjsx6T4M5MP42Fu7gICcmRZt1?=
 =?us-ascii?Q?j6pKv1piA0oA/9Rk0DhJIq46zg6jSucG66GjDPREX77qpEA6tuWimb7Si2G4?=
 =?us-ascii?Q?j6ydVP5Wakjd0+L6OtOmvfs9?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3849.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?JlL3fA5TIArX9aXsP4CjjZdEJK4htxOe8+IUaLdysivjN1oHzKcw9P12anwv?=
 =?us-ascii?Q?t0wglzhMzjE4Rbbxpq9aNeHIP4Tw2JZ+2WNRT2IVMVnE3P3bZDKrm1cCX0uC?=
 =?us-ascii?Q?qHWUgESSH1J1X02RapV675JEV5+sSjPQwnaaQcI9XnlkYMdew0uCBrpS379T?=
 =?us-ascii?Q?EmM0ZylKpG5/KAivqW7XnqxFAl4dZI2KLp3AXXU6/9+fNOcYRUzL0tvqQIpC?=
 =?us-ascii?Q?9l4AO7rdfn+pqOs9o+9a6EmwtIQqQvZ5M5Hi1hhSGmLR2NzhnHu0lefbLeXO?=
 =?us-ascii?Q?c3Wl/hydg0DxeQH2O/Tbh4sBUja4Qz8udnUL8TFhqGcmgdTe7VfX/PkbC0R+?=
 =?us-ascii?Q?WR6Ew1FxerZIGE95nPPFVUe+is+5zWfaMcZuIMBbgZlaomVYVp1LO/omZw2A?=
 =?us-ascii?Q?OCAP2vxtj4XDACJq97Y3HU+ocgRzZat1ByEfsh4l4zhHX27p+YScYJmCcAgX?=
 =?us-ascii?Q?52RhJT4a0A2X32TyBPy+7LO3GLyweRTGvwTS4fJ2z05QVZrcFqK12d5sPyPN?=
 =?us-ascii?Q?ct1u2eFoOIRGReuB/CuHL1b8N+v5usPVkVXkGedbIRCu0J5Enn1gL7qfLmTk?=
 =?us-ascii?Q?FIBavJxUBdeEpZdaRp/MT8+DEvFbNqfrEzTdsg0oM/I72vxfXdpFzCyMUHVn?=
 =?us-ascii?Q?qqbTlqVNCehI/qDRJIvoN/4dqhGPAlr4n/RufogAlUDIfygqGgiXzvia/kwp?=
 =?us-ascii?Q?xFgjy7M9xyIyAloZ1pg8YCW84Hdi1b6ja70aQqKJ7y8dxIIMJ9V8riYzgzG+?=
 =?us-ascii?Q?dfomarVCtgalfn3u6J9EeLpj5RnqvRwVJzXGpr0FFiBKCRmOcG0zoSss5BrA?=
 =?us-ascii?Q?Vm9bb+eSHSTyTmg5fd4EMMaEusFdnHmj1adNp2Q+RsDdVdx31USbzUwQXRIP?=
 =?us-ascii?Q?iwcoI39SucqhMlXq67Y1JCtxhrY+Jr6TN7Gv4jEEDmdxWCzhaJVtWIO6/50T?=
 =?us-ascii?Q?n8XkIaQBxwkliICxs+O+p2mGLW0jRinTX/TAz31G95C1OV8bL8+zd/VEq4hT?=
 =?us-ascii?Q?fgmZvOKXRWZ/aURoseN6JU9Pjpba0ULif1dwtGqfJomQrdTAShB/mQ2h+5XA?=
 =?us-ascii?Q?fuxfSf0Eo/nMVUaY4SJji5mJ5KGof65z700ssHWZT94jqDR4nJDQ7lDTYbPn?=
 =?us-ascii?Q?2CHLBhh+cuk5iv9sWTCebfdTXaeD55PWqHVDHKVOQ5co0OXTymNOZ4NaxOqd?=
 =?us-ascii?Q?FUbGIPygu+GqklzNZwOP2oJYp+wQkve4zGANVRCFAYiOCqkcpPm3pPYxbXO8?=
 =?us-ascii?Q?k6fpC1HoqqVfOws2INANbsm/sE3Jfdj/6moHBqG/9M1jawlttnfDl5nhRjOu?=
 =?us-ascii?Q?abrLK9vDGm+JnxkfE/1BKG/eqgEok3lIGbwJSpqRZ2XPKAINJhfm7x/Cog39?=
 =?us-ascii?Q?YCDBQXtQOSrA5eWAZPrjNcZbc9PTDtnjdgnIzNAtyenfgOUykmS/tP3sLFkV?=
 =?us-ascii?Q?+W2Jg6af/KbZjnxzOfVoXpTKqcz+bUNnkh0N66ohE4xjkn5eW1aIU/+qLswl?=
 =?us-ascii?Q?ZWy6wJbtOqCLiGOI5in1U0degZpath043/2JRIOvSgTJ7ZwPr1/ItKtpWy2P?=
 =?us-ascii?Q?Dib8vA/o2GC2/52MDLfP/+mi5qFAdywQ5qdHI2Sp?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d9ec9c5-02ed-4f4d-4398-08dc8717779a
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3849.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2024 17:30:04.1641
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FVZcebcnxHI7LzHKibqQ2Wn1W4bfeTYlOhSSE/ecJG6EdDWpxb7/RxzfYf6gLMhr
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7911

On Mon, Jun 03, 2024 at 01:26:38PM +0300, Leon Romanovsky wrote:
> From: Jianbo Liu <jianbol@nvidia.com>
> 
> UMR QP is not used in some cases, so move QP and its CQ creations from
> driver load flow to the time first reg_mr occurs, that is when MR
> interfaces are first called.

We use UMR for kernel MRs too, don't we?

Jason

