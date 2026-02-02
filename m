Return-Path: <linux-rdma+bounces-16353-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sNAIK4rMgGl3AgMAu9opvQ
	(envelope-from <linux-rdma+bounces-16353-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 02 Feb 2026 17:10:50 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5722ECEB7C
	for <lists+linux-rdma@lfdr.de>; Mon, 02 Feb 2026 17:10:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 178583015CA3
	for <lists+linux-rdma@lfdr.de>; Mon,  2 Feb 2026 16:02:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95A8C37F72E;
	Mon,  2 Feb 2026 16:01:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="F039l/e6"
X-Original-To: linux-rdma@vger.kernel.org
Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011017.outbound.protection.outlook.com [52.101.52.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E346A37BE8E;
	Mon,  2 Feb 2026 16:01:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770048081; cv=fail; b=WIAUVG/wVKhNSIzEiVZpRMTatHSSocHSIcdDJ3AVTcxPIoi6uvBBDZc8mBhQqxbpd4NkW0xihtiEjDjtZxnit+8Z9p4FV0zF7ptey7sx1QNeoB8aEB5zTgmpQilFL8IsVwyf5ybZIRR/zY/JK/Voj9zvX7X7DPGKWoNUXFiQiJI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770048081; c=relaxed/simple;
	bh=tiOYGUIi/Eln5Ar+0iWNOqg17WW7z6dtJjGdi4rTBIM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=Lg+sOKvqskT7SIE3dftBdTdAILJmRsy7uwjyHxz4RRaTSBdbxTSZ+IVtbphvkaiL7Umd1+lKW/uu9RrWGEjB1s0KCvc3R2jQYeeZUM9heYqshF9D4LvDBqwz+GlfncaurGoKLOmYzOwUSupg7cKHyLxwDeppbD/mqHuYZBPKd+o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=F039l/e6; arc=fail smtp.client-ip=52.101.52.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nsXNcXYAqd7ckyi6ynS83R8M+lSxzmuVj2OSmAaP9yp3sY/NHXUJY5iCtvYfRe9OeSMwW2WRnQJfTVoP4fWg/yMetMFRoAn8Hb2QdkaDVh/5DxG6y7sNDh90/6HskgxXJrBzr5dAr1UDn7rFcW/byybpO+qzwSpOnfjKVo0W3ZLNCWx77ERsARa6l9EfetUE1V3QTotbOp7YzZN1S6pj+QmjgM+GsJ0lz/a6ejyCd5uQK+tnOZlbvqUocjVgiprUzIoH+4/RrGb/I+HtpvUY5xTF2pk0q5x4xr1gryYjFbEDSb90GEuBQkSTn5fha/0EHe/4/qzoLrhMWzp431/xOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cDIWwBRywNSMsp2m6dF361uu3NyHv1nNOALAabzT2jA=;
 b=SneBkuzMJrg3f2JRGWVndtcgETv2RekTtcmknb2eBwomma/HiMzvxBEGUj5hU7jGYeaIuQB5o+zwgTBZ2TyonpbBgw9ewxJJ5imOmCLpZ9nl418+oqN8ryVdjs0O2nw4Ir3JRBjDO9CSuCDRtGjvCN4xnuVllqvG54DFVoqsx/R95cu3sXHZDmJOYylg3TKF8TauYAudG1gL4slmXnE5s6t5KbD7+AyFNco4m2AWcjVhrgRHMBXPxH2qGmFCN1QOtiHPiK4RhnLeqKu5RZEewgpwWCpPHoZ+d4FTBIfJKVU5qtyZgvvbjPocUoE5Uc4WQgyk22NQR9qKVKF/2fICew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=ziepe.ca smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cDIWwBRywNSMsp2m6dF361uu3NyHv1nNOALAabzT2jA=;
 b=F039l/e6gAHJFWWZqasfd+IZHvQPQ08zb9lWIKMEYISb3aiqYyXjBlJw3P4+X4At5nW/kXY1FkpmP1nZc6TMIP7kOcHkhPhIq96SGrltajVqveLsKHATBCPKAprExYaqRxtfn+T56Ai9urPgZCyIDMxaPwvxbPQ5VgO8qld7L5Xc8A5kFODVOLZjnPQF1CTpXF/ntVHyu5zo60QvINBzwdI0uAQgjLKwaBOltH0UFHYtfu8K0LmKsCQvFTnt2SXc02Ase+Br44QSDgHxwQBrF4F+mdUSdIABKt8Tc897fmQRsX9gDx39iR73v9oHsK0+twjT4v52VkKIrK0m7/HzmQ==
Received: from SN7PR04CA0036.namprd04.prod.outlook.com (2603:10b6:806:120::11)
 by SA3PR12MB8803.namprd12.prod.outlook.com (2603:10b6:806:317::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.16; Mon, 2 Feb
 2026 16:01:13 +0000
Received: from SA2PEPF00003F63.namprd04.prod.outlook.com
 (2603:10b6:806:120:cafe::14) by SN7PR04CA0036.outlook.office365.com
 (2603:10b6:806:120::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9564.16 via Frontend Transport; Mon,
 2 Feb 2026 16:01:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SA2PEPF00003F63.mail.protection.outlook.com (10.167.248.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9587.10 via Frontend Transport; Mon, 2 Feb 2026 16:01:12 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 2 Feb
 2026 08:00:45 -0800
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 2 Feb
 2026 08:00:45 -0800
Received: from c-237-169-180-182.mtl.labs.mlnx (10.127.8.13) by
 mail.nvidia.com (10.129.68.8) with Microsoft SMTP Server id 15.2.2562.20 via
 Frontend Transport; Mon, 2 Feb 2026 08:00:40 -0800
From: Edward Srouji <edwards@nvidia.com>
Date: Mon, 2 Feb 2026 17:59:59 +0200
Subject: [PATCH rdma-next v3 07/11] net/mlx5: Drop MR cache related code
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260202-frmr_pools-v3-7-b8405ed9deba@nvidia.com>
References: <20260202-frmr_pools-v3-0-b8405ed9deba@nvidia.com>
In-Reply-To: <20260202-frmr_pools-v3-0-b8405ed9deba@nvidia.com>
To: Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>, "Saeed
 Mahameed" <saeedm@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>, Mark Bloch
	<mbloch@nvidia.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
CC: <linux-kernel@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<netdev@vger.kernel.org>, Michael Guralnik <michaelgur@nvidia.com>, "Edward
 Srouji" <edwards@nvidia.com>, Yishai Hadas <yishaih@nvidia.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1770048005; l=2686;
 i=edwards@nvidia.com; s=20251029; h=from:subject:message-id;
 bh=ghHBasYnFm8RNZGuSQyBfGavor2ubrGxNttv649K/dg=;
 b=HDxSgCkMWnh9R7/S5TejxCKixPb4G3w6UjgM6fo8w0nyXSSAjqqXEd2aQsELKed5bwERyVjAW
 2w6aIOqo7rWDxktra2MTR82eoMgkZNp0Nusn63gp42T7lRh4niWvy20
X-Developer-Key: i=edwards@nvidia.com; a=ed25519;
 pk=VME+d2WbMZT5AY+AolKh2XIdrnXWUwwzz/XLQ3jXgDM=
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003F63:EE_|SA3PR12MB8803:EE_
X-MS-Office365-Filtering-Correlation-Id: 35772fe7-58c7-42ae-87bf-08de627449f7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|7416014|376014|36860700013|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?THhmQU9sN1Q2aENMSXVPMmplbXBwQkNDS0FrMi9pd2g0UFlWV0ZUMXRYbTdx?=
 =?utf-8?B?STZ6MnpodUdmT2kwZVIrOHU3SVZiUWxGa0c3TnpWSlZ3YlBoa08wNmk2OGtv?=
 =?utf-8?B?RkszeXh6M3lTVk9HTmpIdjRDdWR4Z0JnT0RCVE9CaGkrNTZZTFNXcmYyUEt2?=
 =?utf-8?B?ckhPWDltcU16bXFpL3BSRjdHc3ZmZEVlM0Jya0ZSUzZNWFBMVHlkUGZQZy8x?=
 =?utf-8?B?RXlUeUZKKy9ReGJ1NUpBcmhMdWVlQVZmdGNjN3VIV254UEtiU0NXUWJCb0lO?=
 =?utf-8?B?WU95bll2aFNxWGxaN0JtZGIzSG9SenFtUFVpWGFna1hzdUkxMkJKNGpGNk03?=
 =?utf-8?B?QURFQ3Zhd3I0ZHBsQW9DUmlyRHFEQ1lBYjhqQmJHcDB4L2VwbytEWksyN2Js?=
 =?utf-8?B?eFh3SCtoQjhMN1FTK2xaeEVoOXdoUkYzTEhWTU9DRm5nMVovY0tGVXNEL25O?=
 =?utf-8?B?VUJzYzI3cjdyOVpSWEFQUWhjK3pRYjhveDBvZFdxaXNUQnA1Y3htMjlITEdV?=
 =?utf-8?B?MndTMHVYVlJJSldib3dBTDhPc3FoTFZyLy9xOEpadEFQbk9SS1NaZmh6QW9W?=
 =?utf-8?B?ZzJ6aXBMOWZYb2FVQlBmNXZsOU5YajZyM3lpMjA0Vzc0TEpwa3Nwb05HM0l4?=
 =?utf-8?B?ZTBmV0p5S1pyQ2J0UGZXdHRKQk16ZEtHek9DRkJ3aVlMTXJwaTd6dkJhRkNj?=
 =?utf-8?B?cHQzenNDNlBVTXhQMjlLbkZ0TkxnSmxkUDVNemduMkdvZGNSSHV5QmZKTnBU?=
 =?utf-8?B?L0RMdndwOGhGZjk0SFlGRzlnZUkyV0NjYjdyT1NTZEJNMjVjeTdXMXdKUFor?=
 =?utf-8?B?OEJVa1cwRGo3eVJPQTNtSjlwSTVjNTVMaXZBS0xud05nN20zT21WSWJpb0dL?=
 =?utf-8?B?MURvRnhmSElvM292a0RoVjRDbTJ2N2N5QXpDdjlKQUQzQjdDQWpVMTNaWm1W?=
 =?utf-8?B?TG16S0xrMW5IK2h0eW1ZUzRVUEdJdlNhK2MvWFdDS1RKNG1HdzlHRUNwV01S?=
 =?utf-8?B?V2oyayt0byszQXcySVNZRHJEN3RSRk14SUd1T3RTMDVTZlBxcmVuSHpXcmNU?=
 =?utf-8?B?L0VEZk9rcmYyZXpzYVE5RU5TdkxnS2pBd3owZFdDVG9uTXVNNkgxOXJxaTVY?=
 =?utf-8?B?cE5WRnBRM3BRejh0SFVsN1BmVUtFVUk0QXJVQTE3SEZ4djRrTS9lMlZSWk9p?=
 =?utf-8?B?eHBWb2JTZ0lRSVk2bkJFakdQQ2wyeWo1UHgyRGFmOXExYTRDNVBlbXltT2pz?=
 =?utf-8?B?NDlzSDdhQkZ6Qm5zTGNmRlVyRThuZHRNSmRNeUFkdFVyTmJHdEgzODVxMkp6?=
 =?utf-8?B?TWJFLzZUcGQ2YXRYS3prYis1eXNlZDVXYkYxRU9KV0pBRlVtL2JXUW1EOXhm?=
 =?utf-8?B?dFFrbWk3S0s0dEVIc3Z1MzdsUnpCK0gwMkx6SVV3WkNKRXQrK3d2NE1PSUds?=
 =?utf-8?B?TFF0cWxqaldYR0hoNDllQWtkUmN4ZFFvYVkzeFNyMlZoTEQ1cjBKaW5COWtz?=
 =?utf-8?B?TmtRT1cvRmtFeGVRVzEzU2dqa29QZkgwQ3M4aFozODRBNjhlNnZHNXBJSC9K?=
 =?utf-8?B?TmltU09vUW1kNm5LdnZKVUlOVkZyRE8vaStzSm9zM1E3WUd3SzFNRlkvWWhJ?=
 =?utf-8?B?akx4eHlnT01qcEZObUw3U1Yxc2x3MU5tYXFZRjJjNk45dzNHSXR1QStveVZa?=
 =?utf-8?B?dXF2VjVHZXF0bi9ZYVArbUpTMGZXODlIK0dnREZUazZxNjF5N2hMWUpaakN6?=
 =?utf-8?B?NHh1OHc0a3JYL2FXZ2FGVzhkV3ZtamY0b1FJN1dqc1BKcy9DSVAzVzF2MzlG?=
 =?utf-8?B?cGFxdk9FOWFqQzNKR0tKcDFFRHkwTlk2amZXckwxaXFXOVgyaXdtLy9ySkhp?=
 =?utf-8?B?a3Z1Q0VRdmswOXBwQ0JDWGZYUk42Q1FBbnpadUdTVjJOUUpBODAyMDZYSUNP?=
 =?utf-8?B?ejFpcEtUZjdaS2orMktaZitXdmk1M2JjOHJFNlZjeEJqQWE4REEvRDZQMTZW?=
 =?utf-8?B?U2JoTTZTbGR0UWVzek5wT3FNVm9MTXRwZEh3azNtb0hlL1g1LytXSW52U0Q4?=
 =?utf-8?B?RERSaSswMHBjNGo3TFRDQ29mV3hmTEVTaTVFMVJ2Rm5mMHpZM081cmtGbDdX?=
 =?utf-8?B?TnRjRmtVR1A1WmNmczZBUkcxOE5rdmlqREsyQkczVFBOc0ZsOE5KUmdpRkdk?=
 =?utf-8?B?MjZnR2ZjeWhxOEpqb3RQYjBTMlhXZmdNSjhzVk13SFVhT3JQUFl1a0ZIaFI5?=
 =?utf-8?Q?YP5aAI9eZ9bJt7hngUbA7aXR9aNYYjrVMLL6W47Xss=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(7416014)(376014)(36860700013)(1800799024)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	8zlkeDIPKLTX9i5AN8LrAwNtLGZwPs8bjXqRj5LZqwn24+ZSum1UzvpHpGLLg3aZU7bp2V3LVWLdGAVzDFfJcExWPfh6ECiiCDiOl5gH5aQChFHj9pHL5Kh25neH3lo6ZEPqz1Ue4Vs6uu1HTB5dwy2ss7DNiRVSUsQl6lOG5v40+JTB25NYwccKuOcDiwvJTolYbOK2bORiRPJ1CFqUgo/0vSiWYIooqnGaa/Tb2VIhd4djcRFCziVrbnyH2VzTMvWvIU/EXIBjnN40iDx8eNl7n8O8RqsbDkGKUo5MJJfugoJpHfBQq8dHUOpAn9CXBbxUNyzA4a8X5AkKrF4S7j9bvOPtOYgs9Dz0iwGGhMBNOrrYoRsJcxHZ5NFbUzgud1lthefbEumnrGa/KtXetcFzCom2TUbOKk/4fKekotf6hESUvJXHeKMPD8BCyuvM
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Feb 2026 16:01:12.8369
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 35772fe7-58c7-42ae-87bf-08de627449f7
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00003F63.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB8803
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-16353-lists,linux-rdma=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[Nvidia.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nvidia.com:mid,nvidia.com:email];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edwards@nvidia.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	BLOCKLISTDE_FAIL(0.00)[216.228.117.160:query timed out];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 5722ECEB7C
X-Rspamd-Action: no action

From: Michael Guralnik <michaelgur@nvidia.com>

Following mlx5_ib move to using FRMR pools, drop all unused code of MR
cache.

Signed-off-by: Michael Guralnik <michaelgur@nvidia.com>
Reviewed-by: Yishai Hadas <yishaih@nvidia.com>
Signed-off-by: Edward Srouji <edwards@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/main.c | 67 +-------------------------
 include/linux/mlx5/driver.h                    | 11 -----
 2 files changed, 1 insertion(+), 77 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/main.c b/drivers/net/ethernet/mellanox/mlx5/core/main.c
index df93625c9dfa..cb2a58c789e9 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/main.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/main.c
@@ -110,74 +110,9 @@ static struct mlx5_profile profile[] = {
 
 	},
 	[2] = {
-		.mask		= MLX5_PROF_MASK_QP_SIZE |
-				  MLX5_PROF_MASK_MR_CACHE,
+		.mask		= MLX5_PROF_MASK_QP_SIZE,
 		.log_max_qp	= LOG_MAX_SUPPORTED_QPS,
 		.num_cmd_caches = MLX5_NUM_COMMAND_CACHES,
-		.mr_cache[0]	= {
-			.size	= 500,
-			.limit	= 250
-		},
-		.mr_cache[1]	= {
-			.size	= 500,
-			.limit	= 250
-		},
-		.mr_cache[2]	= {
-			.size	= 500,
-			.limit	= 250
-		},
-		.mr_cache[3]	= {
-			.size	= 500,
-			.limit	= 250
-		},
-		.mr_cache[4]	= {
-			.size	= 500,
-			.limit	= 250
-		},
-		.mr_cache[5]	= {
-			.size	= 500,
-			.limit	= 250
-		},
-		.mr_cache[6]	= {
-			.size	= 500,
-			.limit	= 250
-		},
-		.mr_cache[7]	= {
-			.size	= 500,
-			.limit	= 250
-		},
-		.mr_cache[8]	= {
-			.size	= 500,
-			.limit	= 250
-		},
-		.mr_cache[9]	= {
-			.size	= 500,
-			.limit	= 250
-		},
-		.mr_cache[10]	= {
-			.size	= 500,
-			.limit	= 250
-		},
-		.mr_cache[11]	= {
-			.size	= 500,
-			.limit	= 250
-		},
-		.mr_cache[12]	= {
-			.size	= 64,
-			.limit	= 32
-		},
-		.mr_cache[13]	= {
-			.size	= 32,
-			.limit	= 16
-		},
-		.mr_cache[14]	= {
-			.size	= 16,
-			.limit	= 8
-		},
-		.mr_cache[15]	= {
-			.size	= 8,
-			.limit	= 4
-		},
 	},
 	[3] = {
 		.mask		= MLX5_PROF_MASK_QP_SIZE,
diff --git a/include/linux/mlx5/driver.h b/include/linux/mlx5/driver.h
index 5405ca1038f9..975cd8705a58 100644
--- a/include/linux/mlx5/driver.h
+++ b/include/linux/mlx5/driver.h
@@ -699,23 +699,12 @@ struct mlx5_st;
 
 enum {
 	MLX5_PROF_MASK_QP_SIZE		= (u64)1 << 0,
-	MLX5_PROF_MASK_MR_CACHE		= (u64)1 << 1,
-};
-
-enum {
-	MKEY_CACHE_LAST_STD_ENTRY = 20,
-	MLX5_IMR_KSM_CACHE_ENTRY,
-	MAX_MKEY_CACHE_ENTRIES
 };
 
 struct mlx5_profile {
 	u64	mask;
 	u8	log_max_qp;
 	u8	num_cmd_caches;
-	struct {
-		int	size;
-		int	limit;
-	} mr_cache[MAX_MKEY_CACHE_ENTRIES];
 };
 
 struct mlx5_hca_cap {

-- 
2.47.1


