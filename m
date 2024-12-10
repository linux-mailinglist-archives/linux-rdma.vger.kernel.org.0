Return-Path: <linux-rdma+bounces-6398-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D363B9EBAAB
	for <lists+linux-rdma@lfdr.de>; Tue, 10 Dec 2024 21:12:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 05D7816683B
	for <lists+linux-rdma@lfdr.de>; Tue, 10 Dec 2024 20:12:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3774E22687D;
	Tue, 10 Dec 2024 20:12:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="UGggbv8M"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2068.outbound.protection.outlook.com [40.107.223.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BE7821420E
	for <linux-rdma@vger.kernel.org>; Tue, 10 Dec 2024 20:12:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733861554; cv=fail; b=kymwU2/1r5wyt7F7b0GlgS7/CfiIeVsxLiEcQudAzjmBMIW7pekp/7AUi1ZvZ3MCHY2f1WskHLJfM3qnzHCKtmUlvySHax6cGfKI3FBSdDA0yCYycsUGyrdiQXw1KM2HOMCG/jcAFBGzbHTGNtxMP0zXaPHcoH6+w5SewPmmKc4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733861554; c=relaxed/simple;
	bh=wJWdqCX8OIlZKeagNzm4hLpEVGiVhibiA9WKpZHNd2A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=TIpfErGC/upZ2Ev7QB8rr1YKPpzHihVdUIKGg0O8tZmt7nuDZckDgyiuddcA1rEH31DY7Aux0EwuaCDOasMLulHafEm/cqGxDkaTbUN4C4BQV2UgMOQPD2BLVE89b7ba/UUBdRUm6tjFjQsxfjgdeGkJp7TQC6Xt187BQHNpt38=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=UGggbv8M; arc=fail smtp.client-ip=40.107.223.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JJebO8NJ6sM8MsxxjgNbDwmjAzwxEA4a9eEkiounqTRMloVZYDomF8bmgEQ02HKzKwV7EVlqGUABnFteguOEKEvZ/+3JAyjjuViSv/4SCSHrQ3wUi3FWArTU67w7nRhSl15c7Jqk3bIEo1BarPBzgP4Ugzboo8qpMXN6IQPh7+udn29M62z6Nu0MO0d6Xf7bUKxn+75H+/vi2Bov/RErCWxwsI4r83ZpCIV8A8eQUuHXSCdzkLsxcXCfpVjtTSzapd+dJR4leGnOWQ9OFlCOPhXeE7Ermu7TcAVD88V/GhoYu1UoeXin9dFUNHhV5UFvzJWhrf61SzyU7M430RWfGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=69WCodV9iY06OHkAnUv0pdXwaisGP7yW7xc6XHdOAIY=;
 b=NbgSqhUhpyLayKNcBAnT8/TlRpEmzEhtAFhuxJp9HDQbglqrKF7jN22y63U6rQZo/RTCMtp9acEJsnBlZccqPu1E2Hbmihpn27ND0GDUHvkoLlU5kUKJeDm/raMAP7cErDrFWndgr0dotOqfSJOywv/aMupUJLiHMzYydtljn/F6yYfoMNhwS/ZzTXWQaHRvFAEwWz58HVD5+vqOaDcmjjdO5XFLDfclL0ZSVxmwvxCAr9brV3pQkD/VFcbED3X1VphaxrPEQJzC9101FGgli8ECdzn+pFWDbpBaT2GD7zXYCWkK1e8/DdBwkegf3l/blet0H32HbEFHMCoJX6i8ug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=69WCodV9iY06OHkAnUv0pdXwaisGP7yW7xc6XHdOAIY=;
 b=UGggbv8MG3iPaGxLcZUhr3WOnXaanxQJbk/Yg+KzKOJ6J0dXW7hqCuvfVtvb7s5RxPfXQNnR+HoZu5DQC9Gu50j0vsqa3b1iEOBTUBBGOMaCZzKfng7WIVkDrTXOfRXPegFDMLsipuyfbzfa12Q0tP7zFS41umHwROTIJ0blwDIThP/04ZrCe5udnCCaChcy5hFWeiwp3mICfyjcqErgYX5rimA93ef/QLE7EeXKcugGVC8b+3TvNiqS58yndahQ3/tpX571EcuvQtCm0E6fXuXIfSW7pTodnjKBNlJDOYX4gTh3InYbM+EJ7W7tljoyKysq+y851r72VNGzMDeCQQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by DM4PR12MB5820.namprd12.prod.outlook.com (2603:10b6:8:64::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8230.18; Tue, 10 Dec 2024 20:12:30 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%5]) with mapi id 15.20.8230.010; Tue, 10 Dec 2024
 20:12:30 +0000
Date: Tue, 10 Dec 2024 16:12:29 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Leon Romanovsky <leon@kernel.org>
Cc: Or Har-Toov <ohartoov@nvidia.com>, linux-rdma@vger.kernel.org,
	Maher Sanalla <msanalla@nvidia.com>
Subject: Re: [PATCH rdma-next 3/3] IB/mad: Add flow control for solicited MADs
Message-ID: <20241210201229.GL2347147@nvidia.com>
References: <cover.1733233636.git.leonro@nvidia.com>
 <edea14a9da803479b986ba3a27058390891de21e.1733233636.git.leonro@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <edea14a9da803479b986ba3a27058390891de21e.1733233636.git.leonro@nvidia.com>
X-ClientProxiedBy: BN9PR03CA0990.namprd03.prod.outlook.com
 (2603:10b6:408:109::35) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|DM4PR12MB5820:EE_
X-MS-Office365-Filtering-Correlation-Id: a4a45bd7-b907-4718-3e64-08dd1956f958
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?sVkuhxxVzW6wVnzzezSMpcu4UvVZoELvfdyi7GKTp/OF40jDv/YZDQL8KkQg?=
 =?us-ascii?Q?ILyoisERL3F85SIo39sDsQtRJtO20vNVvz2UkzC3sTiNt3U/cxWbn7vEptXA?=
 =?us-ascii?Q?MeLBIhCZ4StfJ/MFQe88oyKTVo3p0C/3o3R3kLX83X1KeowRYyOVrk7d0XIt?=
 =?us-ascii?Q?rA+GlYkGD5eWEiCLc8xId23VE58DmokBiT3ZzaTLbuQEC51Cn68cKoFOh+Tx?=
 =?us-ascii?Q?w4o5d/A7ISAsG6ZiJFcd67kdzPOL4QTg6v1IT1vNp7seTvX+Cmlvjw2GWSYx?=
 =?us-ascii?Q?qNjoVYoLfj6GQOmcnWuIjBACHG/Gxnr7vbCuklhkv4nV8rQEvdEuN/RAUIGU?=
 =?us-ascii?Q?Ox0InCC01E1kynQkm+lLLjl1ABaNPllOQuqg2Q0DId4OiLrgvKFDL3J+Hz9A?=
 =?us-ascii?Q?VwrF/hoBFA0TQEs3eCWi0Ja2QwywAYYMvLlCtKA/Y8GxSFH8uZlLa0BCemBm?=
 =?us-ascii?Q?aoTxECB2mp3Z9pFF8e/fjiCPlv4RUCMZ+DByb9B2p4dp85VAMue6uEghjeWM?=
 =?us-ascii?Q?yGIS7V8e78Ys0saMGiEXydfUPrDLOe32lH4K4NT8Ix+NWXMttS31Aidp3pY+?=
 =?us-ascii?Q?57WZ2db4nBkMW7taxSTKatcf6HgUitkozKJl8uGt3B9xCHX1EmGexhWcGzgM?=
 =?us-ascii?Q?Xmq0n8tFdVR8pm566+eciepyQyEtcvmvWeTy/A9AmhC5MfmqfWsHlOPDzo1v?=
 =?us-ascii?Q?8a40gtIxv9myv36OswVtplpULMBxQyNzBncz7uvyRRUjSJZfMSDyfs3v/Qpe?=
 =?us-ascii?Q?6rCwsxogQATyjGtW33wIX7js9gLkyJWl02i19PeQ/XnY24UY82VrwMbDmjvY?=
 =?us-ascii?Q?8TPojgeT1JpTDCNVRkA/uSh9AgOeid3Qh+TolgdQT1fM5NOPZXnLNbLau4Pr?=
 =?us-ascii?Q?2Vp0UeX+KBqi8MHlzApBYqYg14E9c4wMXgsFiDP7UV6T2GBuxrpbR3/2wQkD?=
 =?us-ascii?Q?JaiCB4YUhoYuUIGvQ2ZYOJp2kceFOhO53q3wGzdhRKLUmik3N2fHuiDxgagn?=
 =?us-ascii?Q?f7yMpSnUV95GbQZNEGXMRTv4kXaVPeBeJkTdXNrQcArX3SJddrEfvvUA964U?=
 =?us-ascii?Q?a1P2lXydbCaCeHlM3FjrYzxPcaCyPUJljB6JsphvDAqNxbcDAyWcTLJEl9Cw?=
 =?us-ascii?Q?+HwEMN2btPniWAyc3tKSvap1DpeKmM+e0AmoJt/ooUhC9qtwDIoi2D694eY9?=
 =?us-ascii?Q?phpcJ7l8qfFY1mM398fotBrH5CDZi7PyZHnMnBB7y1fCG2ASb3xLAR8+wLTN?=
 =?us-ascii?Q?+5O5sqoZaBctw1xBu1peKniOmM3e4ZwZNpCioD2ZGfs8sOzgU1HEpTY8xpWH?=
 =?us-ascii?Q?DKSVF0AiDMXnSN0HyUooWlPcvTsljiXHe/6gNvdUGGnrog=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?tiihyxmWF6MQzq0AS0Y6QM9NvfXovSGxywgeza7V1BPgdedZTpTKn3Sd7TCe?=
 =?us-ascii?Q?mPvPxwjrqk0eR6ZYq3SmZ3H3NLeNCdwMZ8+tcbi4yaFJuHYQJyytrZMKDnE+?=
 =?us-ascii?Q?qvl4sZ5VFa4Mwq3pvKzIyY+C+854apBqLPID4ETKJ6tdjZYmPJHg97l9NzzY?=
 =?us-ascii?Q?yv9cLRpnT98AZ/FE5vDYzG+bk69aMNNEs8U2q1T1twD4yLpOFYZeOUL+Zg7w?=
 =?us-ascii?Q?gQCn4oarq4pToBbxgJ6QS3YSfCl7E/x3yq3qpxnkC5yab1OGT2GCUVrgmEua?=
 =?us-ascii?Q?ig7UjjfbaGmMtlJp01Nqvw5z4i/32/IRa5+b1VUKHMGhUt0Wh7pBcpplKR1B?=
 =?us-ascii?Q?RAt819TeetAWia6sRcSZ4oslpGCZ+dOwHW0iNgq5BYowCx7U1co8GcvelAEq?=
 =?us-ascii?Q?PEsrZ6DOaH04B2e5gf+/jb6drAs40SynQx5FDsAU3Dc8Sh9LWzKf+zvoRiW2?=
 =?us-ascii?Q?JSZuEJiaGbaq1lfwWyEasbIe/akL2HnxUqLxFnW/tQi+4OD9v5TMatOEIjs4?=
 =?us-ascii?Q?DNt79GISw1GcNXCNwqjMf+DL+dzCOcHH6x71MqjgLI+YwOinnL7HFzIgLhLN?=
 =?us-ascii?Q?rWJms6bd6VhhEzBbDkOPHBQ/sM4txMATmoaDgQbeAqtDzMcWdzBX3UT6PSha?=
 =?us-ascii?Q?Om4+MNf1o/rBvjzXKVGZEU+PK4qxlZipON3TB7EL49v8itG0AdG1Qi34RUij?=
 =?us-ascii?Q?fZ9Bmlu5+L7aTpCOGwKcl7LeM5UaP1zFp4VZoqffafPukWiP/ZdobBg0PBWd?=
 =?us-ascii?Q?sW53Pp+q4wg1PwFqcsoRD4EU6Cc6gIkdKv/KxiK7hoj3hf+TKdZZc6Txzlb8?=
 =?us-ascii?Q?uZL54cfIBm2qkoIUGQ0Dbv7bl/zq6dLnGVoueBCsCvXdODWy/4pfZ87qPUzu?=
 =?us-ascii?Q?43QKNYm4E08uxn7o+VFWImCtBJhAGqti9Trm4t7hkFIBgoRkuec+acJsKOqu?=
 =?us-ascii?Q?S20R8L3mmPOl60TQR7PUOe7G6WtmQbtBRUbYiY/ObHkUUIMFXHonfB4fLkFq?=
 =?us-ascii?Q?/MnFDyxfOORDER8+qAWaSaCygMCl8GaqnNyB9HnmqX5k5TrVdWuCzu1UGCrA?=
 =?us-ascii?Q?fU1Rsdp+axrdl3oJ6bveQYkfNDXCeB6rzrFJ4GuNTesLTywdL7qD80MM3WKa?=
 =?us-ascii?Q?9rqlDruuZeCV5myh7r8e2V1tUywX2Jzq23OTONqagTGZDRVO1XJsS55KG3X2?=
 =?us-ascii?Q?2uZQ538ccDabo/zirqYevZBA3R12IdoKvxAIIY/InvvizUZ7RNmJ5T0m+NPx?=
 =?us-ascii?Q?lOMjcaYarT9uBrlqKTlCXkgKE6sXFp3jalXBMty0kaFZDyLxou5y2wcNIPTR?=
 =?us-ascii?Q?umv5VB3D7ePd2i73KGFRVpwJDSbie/dx4fRYKq1+gJqdvLzwBVzG6H55RM5Y?=
 =?us-ascii?Q?cymMv9dUCen6x+sxadfH2cWCbGy4rpR6h1nV91Q5GNFwRtFDLBuoaaYpIcB4?=
 =?us-ascii?Q?bzxoLOWvpJQjDci67any8ScFUL2OJzJP4lnouC8HnsKpG6n1EGe0t7Xz7sNb?=
 =?us-ascii?Q?bmlrYzwPt7dmHhVdR3uBJWGGpMz51hK1jjYRuKU3uS3/fEaO+sAbo/6cPJQN?=
 =?us-ascii?Q?eysgyjciQM0xHUV2U54=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a4a45bd7-b907-4718-3e64-08dd1956f958
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Dec 2024 20:12:30.0155
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4oplZ8iFEZ7rsY37f0/Xe9nFToIfgabtL91K6NOo1ZgfmDUvoQugIEaItmvspfuE
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5820

On Tue, Dec 03, 2024 at 03:52:23PM +0200, Leon Romanovsky wrote:
> From: Or Har-Toov <ohartoov@nvidia.com>
> 
> Currently, MADs sent via an agent are being forwarded directly to the
> corresponding MAD QP layer.
> MADs with a timeout value set and requiring a response (solicited MADs)
> will be resent if the timeout expires without receiving a response.
> In a congested subnet, flooding MAD QP layer with more solicited send
> requests from the agent will only worsen the situation by triggering
> more timeouts and therefore more retries.

This explanation does not really capture what this patch is supposed
to be doing. The point of solicited MADs is that they require a reply,
and the purpose of this patch is to try and conserve a reply slot in
the receive queue for the reply to land. Sending more requests than
the kernel has reply buffers is probably going to overflow the
HCA's receive queue.

Jason

