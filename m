Return-Path: <linux-rdma+bounces-822-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AF14C843AE7
	for <lists+linux-rdma@lfdr.de>; Wed, 31 Jan 2024 10:19:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 271F61F2AFCC
	for <lists+linux-rdma@lfdr.de>; Wed, 31 Jan 2024 09:19:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5014964CD0;
	Wed, 31 Jan 2024 09:18:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Me9gL8f4"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2048.outbound.protection.outlook.com [40.107.93.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 962AD612CA
	for <linux-rdma@vger.kernel.org>; Wed, 31 Jan 2024 09:18:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706692732; cv=fail; b=C7GU/m0F1lu3oRZLrT2JbedbTJSJFdpuWLr3I3IP/alcYIjAoKATclcBnEQaw/aB7NXByurMj72q1RDfW+hrzoaxYSfxEd/k7Xsfn7RdtPb7shZMqPbC7JGvNux6RfhQx/TuUHRQNVP6m7f2kKRdm5OW00Z0WOpSsxeAjkJYZ7I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706692732; c=relaxed/simple;
	bh=rzXrHngBgCD1MpWmaek2KkXhVxZyF9slXjEnpaEnOY0=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c3uBvyAumO/YIU48s+198GyBO8fsKui4/A5CcGFkst+jc3yksNZVBsArhA4DLjZZQZ/POAdd8Mw78SPAnninyuW8ZpIzpoNh7Zm/sjYNlShzzKFCb8AI+DG4wsvBNMVgDISUSasJ+BUl1rYoIAdxKU/aQ6bzVllOk6AH7E7z2pM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Me9gL8f4; arc=fail smtp.client-ip=40.107.93.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ftG5UAGYe0TqMp+1LIbCZ47eB2K8Gp7MXMZ2+6atZdx37wFuxbHUsFYD6X7LaLRn3cielhgbNqnhrUJTmRxSqwXGQRoLIRIHrZJqvOZMgNr/rqpDhE/0jm60xtsdRnvsmwSiJbwXLVIIEel1WzDpK4qZAV3+iu9AFhfl3utcHhx4YoEqhH6Nm16M96KNo4mu98DMcVvWcml8mst/7bVHMzx+7/6yoU/tCOSMPAh80/btXMBjiTWwWWDKAlQK47tQ5jlfkFO8vZvy/1S3rQxR6TFBjHa/oynh9b+t049tH+yJhf8yzVJlxHYEm3MaZmDdcgEAiuFgzSuc73Qe4zMpXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y/pOqxZzqZoYmgogphTJU+Gv9O2jkULJ5DmhZ5qrXGE=;
 b=d8dSK+Cfr3gGgZiWwKGLv6tXxoxcEfNCCefEGSnViExeO+XMUebGmgDBjN+a3C9+aPqCYysVhvXRo9VFJnZnzdsGBGDRsxw9y0NJNSpVQmexAJ/ENpRKhTHEgh8RB48Z1Ln0WHeQd/fyK3x+vJ73bpcQg9eOEJ3W0Gj33byMVXKN9zAe1+rC5elhyXcb3PZSsyM0Q9r9GXB8K9BgVYoJrj7g7E6gLtLjjM9+HH4EW2V1UvtxDzdwERjgEYWU4sObqc4KITAkAH5Nd/TQm1o0g4acv6DCLLnqmNCVC6kswfW9o8Wf/+sr6isKrAVub8ukdzdBYT/GxygpTSVLNvqPjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y/pOqxZzqZoYmgogphTJU+Gv9O2jkULJ5DmhZ5qrXGE=;
 b=Me9gL8f4BS2tuai6VgqhJTLW38QoOcwN1HDnmLlz/e/g5EchyOEpA6exBfKpOAaFwDcZgtf9w+2m8m3LjYDud0W6TnmM4h7y7PO67DQVRQaNO0Rf3ewchp3llU62qnSo/5sZFmxD0oxFfO9NGkOZ1M/yF0OInSGR0fI0mI8frY1YmutxjF1M5bJLDY+maVw6g3Fcs2+5QkI0tu1WLN/mmUXgmSeYuRcXWYNPZ+klYjy7bT+RduZmiydUrWuMi8CuC9XrfRSXzyB6QK6accYMuLCBMWGl2Zq2j7d+4aRw9XvvU2sYGbq+94W7YMA0CwxPaLy4gAHn/VyKo6XNpAMgNg==
Received: from SN7PR04CA0201.namprd04.prod.outlook.com (2603:10b6:806:126::26)
 by SJ1PR12MB6289.namprd12.prod.outlook.com (2603:10b6:a03:458::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.32; Wed, 31 Jan
 2024 09:18:46 +0000
Received: from SA2PEPF0000150B.namprd04.prod.outlook.com
 (2603:10b6:806:126:cafe::97) by SN7PR04CA0201.outlook.office365.com
 (2603:10b6:806:126::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.24 via Frontend
 Transport; Wed, 31 Jan 2024 09:18:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SA2PEPF0000150B.mail.protection.outlook.com (10.167.242.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7249.19 via Frontend Transport; Wed, 31 Jan 2024 09:18:45 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Wed, 31 Jan
 2024 01:18:34 -0800
Received: from localhost (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Wed, 31 Jan
 2024 01:18:33 -0800
Date: Wed, 31 Jan 2024 11:18:30 +0200
From: Leon Romanovsky <leonro@nvidia.com>
To: Jason Gunthorpe <jgg@nvidia.com>
CC: Edward Srouji <edwards@nvidia.com>, <linux-rdma@vger.kernel.org>, "Maor
 Gottlieb" <maorg@nvidia.com>, Mark Zhang <markzhang@nvidia.com>, "Michael
 Guralnik" <michaelgur@nvidia.com>, Or Har-Toov <ohartoov@nvidia.com>, "Tamar
 Mashiah" <tmashiah@nvidia.com>, Yishai Hadas <yishaih@nvidia.com>
Subject: Re: [PATCH rdma-next v1 0/6] Collection of mlx5_ib fixes
Message-ID: <20240131091830.GD71813@unreal>
References: <cover.1706433934.git.leon@kernel.org>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <cover.1706433934.git.leon@kernel.org>
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF0000150B:EE_|SJ1PR12MB6289:EE_
X-MS-Office365-Filtering-Correlation-Id: fd8d974b-ef81-4c77-c04b-08dc223da073
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	lTA6FhIybAiKHkRgASg/rOtEmEDiz8DJOi7djlDXdgrVRoEYMWISsP9r8JysYtIuMf9cjEnHkhwswL0a1q2XrsivJeRhWT1Yq+OWwYtXnTZW/dyJv63AcUmtQx/ou7HdBxUFl2qA99uph3GqRv/zjlDfwenaZbVeun9eagDasE/Ppg1zp1DY6brnpXyPOWxDDsCCnOwOPDf7/hRO72QQ8aIuZHVji78OP3UE4Y4wUnEkC0KW81KDzMhjWqUvDkXJWz3e37zBFHdTSjoI5hK9LBwtvA+k6/gQ4nssFRtF7lgZ0E4R07GjEGpUc93FrxJHoiWOqgallhGiIt4XrUUMe0NsD0wl2AHyEtDF5Q+IrVqILJzNio8C4zQr6bhaoL89Uo4KV+/jzbqhe8Py3NXMTZIrWwSO23hBuuP745kI5s9pDGpz+a/4R5VCGitiNA+ku9W3pXxnEfWUNdURJirCu7bW4Zs0V5XuE1JH7HFkxToMFj+twTxiSghWZ5mcDWP90Vtjmw2yd0pLRfUk9YN2wYOEckGR/HrWFDAwFAwch8CSZ/KHg9m6omK/0ABwN8JZ1J9dqD1cTvPpOW4HqV0npXVXEzYTREWiklDickKg8/xquCrfWQcbAgL+UiSGAUS9YtE2VshCOIx13CnXTnEB/BfPiVRGgnJ6RJFzVG515mUw3bckvwJaawCEISz8HMJvEWqGw5inpFzse2CPkuzZukiSpwwWhCynDE8XxrNLX//r8cG+sIlOAkLfaeSS0V9fIzFxyFEMnq6vHdY5Qfi0HwJyHDlyp1ZKwdsR1TJ7xWk=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(7916004)(4636009)(346002)(396003)(376002)(39860400002)(136003)(230922051799003)(230173577357003)(230273577357003)(64100799003)(1800799012)(451199024)(186009)(82310400011)(36840700001)(46966006)(40470700004)(54906003)(70586007)(70206006)(47076005)(9686003)(316002)(6636002)(478600001)(6862004)(4326008)(8936002)(8676002)(83380400001)(107886003)(1076003)(336012)(426003)(2906002)(4744005)(82740400003)(5660300002)(16526019)(26005)(36860700001)(86362001)(7636003)(356005)(41300700001)(33656002)(33716001)(40480700001)(40460700003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jan 2024 09:18:45.8651
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fd8d974b-ef81-4c77-c04b-08dc223da073
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF0000150B.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6289

On Sun, Jan 28, 2024 at 11:29:10AM +0200, Leon Romanovsky wrote:
> From: Leon Romanovsky <leonro@nvidia.com>

<...>

> Leon Romanovsky (1):
>   RDMA/mlx5: Fix fortify source warning while accessing Eth segment
> 
> Mark Zhang (1):
>   IB/mlx5: Don't expose debugfs entries for RRoCE general parameters if
>     not supported
>
> Yishai Hadas (1):
>   RDMA/mlx5: Relax DEVX access upon modify commands

Applied these patches to -rc.

>
> Or Har-Toov (3):
>   RDMA/mlx5: Uncacheable mkey has neither rb_key or cache_ent
>   RDMA/mlx5: Change check for cacheable user mkeys
>   RDMA/mlx5: Adding remote atomic access flag to updatable flags

These patches under discussion and will be needed to resend anyway.

Thanks

