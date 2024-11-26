Return-Path: <linux-rdma+bounces-6109-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 718F29D936F
	for <lists+linux-rdma@lfdr.de>; Tue, 26 Nov 2024 09:39:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 308682837A7
	for <lists+linux-rdma@lfdr.de>; Tue, 26 Nov 2024 08:39:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD175195FEF;
	Tue, 26 Nov 2024 08:39:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Oa3/B8SZ"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2086.outbound.protection.outlook.com [40.107.96.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7412014A85;
	Tue, 26 Nov 2024 08:39:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732610366; cv=fail; b=tJ7KL7nfP2YupJ+jCs16MMlfIW08CBI6OK4FGYlTbTpz8wAdPX1Uhw9Y9GZoSaff5MHMgn2j5X7pyfpiZc6JVmj9SeHkwdBtT42YSHIcorPrDX8f4uEu93jZH4oMVoYvdDNKGM9eowW4g0VmPJfchCvlwS5e4jmU6PSqDGEArTI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732610366; c=relaxed/simple;
	bh=KKp4c+3QN0sp4O6sUUf3oR6odXDhq/F3o5aDywocyF8=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GL93/qI6tqBts2N2Yi8onVJ27Dv7Zh9oWRkk7SSUsSYfWQdrJps2FbQYY7qPEjGqjT2efJxbFDZeBmsOPWz9wodvHddQAI2+8rD5R6y2uE+gH1Jw5kCPdtFFX2GTnJ9++OklxThqSfgfXPZjWSnw9jb9I32Tu4srH978R2cZTJE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Oa3/B8SZ; arc=fail smtp.client-ip=40.107.96.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PWaSQU0P7NKjoj6MqYtzr9lpFksVcax3ogu8yLsTCH8s+O8mzqM2PzPk0FKAYf+Ihka2IEe0Zvs5f1hYQ4vsQsi0gnYvOzahavbLM/+JIwTceBQ9AxrSfp/OfS+htr17j+FTNMlHWBuo1zivYGLESBDwgj4op41kitRP+tBKGibWZfBJYt2vmABVIVPCIdtkJptdTuYyMEwG4mHZWvveh+Yw78vX4z+AQiIyanwk6K2i0DCizGhCU37AcnZ1kYfzaazKDJlOibl+YKH1ZsTGw0xRZqPMF3BYYM/Zkh9eyERVaOEN4iFxLzjhwNW4lHRLG8LGsoGKhrwYOvnESX5jCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3e6s//vRT8yNBN+HZ1Ue8g5+w2C8AvpYkQFT0cSe26Q=;
 b=u3U+92YEWmXUoY3MoDwPvAZmKE9KI3AmJ0XwUhIr93lxSMojmCuSmBW31mNLda4kzs/0ZcPiMvtJdnAhXujrgTKG5I9sKbzH/SM4aaZv4x88f9qJIwtLpV/FHCWHg9ja/G8NUUE0fAo1d82POlnyUCrONtzMRh33bAFd+xIWy6MV5bioYrkE70BWXlhoY97AH6IaC6nDsDir0x+VgoweLzxd4ang43abEalwUfg9g6O9kCZ0K6ZvbD8oj4NNMq2wVytB2hIwFNohmNKvpTIJcMZKhiDZ9kZE+jrVUEEvYIUDMbuCYxi+7pItVAtmz0vjzRK6H695mKWuC35AyP0rOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=paranoici.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3e6s//vRT8yNBN+HZ1Ue8g5+w2C8AvpYkQFT0cSe26Q=;
 b=Oa3/B8SZ08kvt//dkTT1E1o2ZjHhiWrzExxY/DnHxR900ae2qIQsjehm9m8RpoFGoMm3aJ8OpuSIysIbC9hCMasyQJt3pWHx2OZRB9bDp9LD/cqxXX6P5Iv3jgPS4Z3db8fg/zHXsyt4zrWF0tafhSFAiENJo+eayx/30ILm6Hwe1os0NdPmsjj/XxDpgCpAw0lnLgYLglhcILEmJjNIJjEA8htHKVXkmcpqbet2eitwkiDZd8vi6RNiRJ8rbuVWik1UGWCjLC6KgzincWXFvUxrA4e0XO/CRVEiOgPWSlKBPKnVirJ1i0mPVz9eqpRR0KtBntzagPWhm7RFBw+8BA==
Received: from BN0PR04CA0164.namprd04.prod.outlook.com (2603:10b6:408:eb::19)
 by DM3PR12MB9352.namprd12.prod.outlook.com (2603:10b6:0:4a::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.27; Tue, 26 Nov
 2024 08:39:19 +0000
Received: from BN3PEPF0000B372.namprd21.prod.outlook.com
 (2603:10b6:408:eb:cafe::b4) by BN0PR04CA0164.outlook.office365.com
 (2603:10b6:408:eb::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8182.20 via Frontend Transport; Tue,
 26 Nov 2024 08:39:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN3PEPF0000B372.mail.protection.outlook.com (10.167.243.169) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8230.0 via Frontend Transport; Tue, 26 Nov 2024 08:39:18 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 26 Nov
 2024 00:39:04 -0800
Received: from localhost (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 26 Nov
 2024 00:39:03 -0800
Date: Tue, 26 Nov 2024 10:38:59 +0200
From: Leon Romanovsky <leonro@nvidia.com>
To: Francesco Poli <invernomuto@paranoici.org>
CC: Mark Zhang <markzhang@nvidia.com>, Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
	<ukleinek@debian.org>, <1086520@bugs.debian.org>,
	<linux-rdma@vger.kernel.org>, <netdev@vger.kernel.org>
Subject: Re: Bug#1086520: linux-image-6.11.2-amd64: makes opensm fail to start
Message-ID: <20241126083859.GM160612@unreal>
References: <173040083268.16618.7451145398661885923.reportbug@crunch>
 <20241113231503.54d12ed5b5d0c8fa9b7d9806@paranoici.org>
 <3wfi2j7jn2f7rajabfcengubgtyt3wkuin6hqepdoe5dlvfhvn@2clhco3z6fuw>
 <173040083268.16618.7451145398661885923.reportbug@crunch>
 <20241118200616.865cb4c869e693b19529df36@paranoici.org>
 <nvs4i2v7o6vn6zhmtq4sgazy2hu5kiulukxcntdelggmznnl7h@so3oul6uwgbl>
 <20241125195443.0ddf0d0176d7c34bd29942c7@paranoici.org>
 <20241125193837.GH160612@unreal>
 <cd4ea02f-bcb8-4494-a26e-81cdf6c684bf@nvidia.com>
 <20241126081824.afd7197d3a54c5242c4bb4b5@paranoici.org>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20241126081824.afd7197d3a54c5242c4bb4b5@paranoici.org>
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B372:EE_|DM3PR12MB9352:EE_
X-MS-Office365-Filtering-Correlation-Id: f40d0d9c-7b02-41d7-2ef1-08dd0df5d11f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?cvhnJ0QbEbr9ABMpdWbhuRjeCoiTOhkJPy7UpaigluJJOh3oU/YFM/DB37tU?=
 =?us-ascii?Q?Orfomqb/oQCFr68agKDycOuJ1CEunlcgJsHvu90U5hwBqHBsA0GheSfaUCpo?=
 =?us-ascii?Q?b8j4ZjKsax2T7mHPSfqVFn4Lkj+FpY0GAfIbzI/yAU/QLrwhfLqfe1d6YA2L?=
 =?us-ascii?Q?tqvpCHPtbfYQke5srzkg1wgB6+QLIQzJR+/PEhXCWKGuBYbJp6B0IcUglOZh?=
 =?us-ascii?Q?qGiCNmzY7GDIhxGqICqBWBeLmlf9kt54zcG5lb8CVtBthO5ER0yA/WqBnNz0?=
 =?us-ascii?Q?Rl0a9MPtLP2bo8SzXQpUbcWknMLMs+JZrpOnoYeRWHMWzyX/8nXG7lrEZ5YC?=
 =?us-ascii?Q?mX1W20vvgxVaT89+dUsjXyYxluNNkjo2EksoD2jMfpvP90AZ7n+xrV6ofVEa?=
 =?us-ascii?Q?jKSUCzwu+92C2tJI2deXJYThaZwb4QzOA7beD9bqfihyOak8mh39pp3GbIMz?=
 =?us-ascii?Q?LVwZXLf0cMf+wUsFPMTr50eEua4CWKnuwveNxABNSk7CEVuqIZCZE10omXRw?=
 =?us-ascii?Q?kEIn8C7mBJVjp9ogBtxwsrCJY8dtOscMTVhuwp20HVaD6en2kX9oF/kH9gg2?=
 =?us-ascii?Q?oiZOzsf0lyGdA9NfkrCiix55W8mvssMBmoS7WQDYOPUIYK6Hhr0Z2jHgUvAf?=
 =?us-ascii?Q?WqyAmrM+d5G2LoUTsmG8uGWVo7swzT3eY6vLH29z0SBUrqFriCXSi9iSh/YD?=
 =?us-ascii?Q?F7Ic/F2w7w9RqTXZKnM2Ps2TFZGEnXGwUGb7KpR2ufrnRWuV7ei3c46NQckA?=
 =?us-ascii?Q?Pmb8xnj++KmPIJmfezuXgl0FPA6nlTDFzKF76ILAJOnNJgODVWm98BK6ajoM?=
 =?us-ascii?Q?gh9Vy2q2vvJcPvmcMcWbV37FtPh35YKF+G9Sg63CB21MNcsdgP3ZRGC6bT85?=
 =?us-ascii?Q?CieYdt1OW4tDe2Z0UjdRqnCjyheqE48GQQJHbnj5Tky4FKCgv4IPr1ZJcWG5?=
 =?us-ascii?Q?ZiuwmCvt9pND2FL/QKOnwXRonbw1n0SmTMY5fKl2fHa5g66E3GSBfaZyp/rs?=
 =?us-ascii?Q?NoJBvVyTj/JEmy7PJH7ThLHcOXsnczH2Ak8GWmrn7ahwcDlO/fi9S5UGehyN?=
 =?us-ascii?Q?0qzaqXEPZkGDIjmqhJa2v/b2FSApuK8atiQnrwiHq84It20feeIY0OofAQN8?=
 =?us-ascii?Q?TzOTH/ySMQxrPfnLJeTy9Zn1rrtg9mrOS8H/WDjyr/QvXzwPtLLPFu9i02RY?=
 =?us-ascii?Q?BVKLQNAbiugnwIWFE5K/e5eEEabUQhzJiA6+TNugYh5z9bnlbphG/Jh4Ns1m?=
 =?us-ascii?Q?i2Ikq4tSBX8OB/lpBlt7XRNollccMklmEi72PertNyyxwsx6QY3TP6Tf54Iz?=
 =?us-ascii?Q?p4JzyZV4JdzDXPyzEODwU8Hz7yT2p0ckcuWfsoktYxMhQhtt393LHKEfgMef?=
 =?us-ascii?Q?JTBFMF1XuAl6uweeUTWx2XPtsy5MvQqiuSEy5ROsMtZ0sJilao/wAEkIaYSS?=
 =?us-ascii?Q?Qa/ZohUSZdAJZMQg0JRjywnRhZQp+Reg?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2024 08:39:18.0921
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f40d0d9c-7b02-41d7-2ef1-08dd0df5d11f
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B372.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR12MB9352

On Tue, Nov 26, 2024 at 08:18:24AM +0100, Francesco Poli wrote:
> On Tue, 26 Nov 2024 09:21:37 +0800 Mark Zhang wrote:
> 
> [...]
> > Yes looks like FW reports vport.num_plane > 0. What is your hw type and 
> > FW version ("ethtool -i <netdev_of_the_ibdev>")? I don't think it 
> > supports multiplane.
> 
>   $ /sbin/ethtool -i ibp129s0f0
>   driver: mlx5_core[ib_ipoib]
>   version: 6.10.11-amd64
>   firmware-version: 20.40.1000 (MT_0000000224)
>   expansion-rom-version: 
>   bus-info: 0000:81:00.0
>   supports-statistics: yes
>   supports-test: yes
>   supports-eeprom-access: no
>   supports-register-dump: no
>   supports-priv-flags: yes
> 
> Please note that I determined <netdev_of_the_ibdev> by looking at
> the output of 'ibv_devices': I hope this is a correct way to answer
> your question.

We forwarded this information to FW team and will update you on the
findings.

Thanks

> 
> 
> 
> 
> -- 
>  http://www.inventati.org/frx/
>  There's not a second to spare! To the laboratory!
> ..................................................... Francesco Poli .
>  GnuPG key fpr == CA01 1147 9CD2 EFDF FB82  3925 3E1C 27E1 1F69 BFFE



