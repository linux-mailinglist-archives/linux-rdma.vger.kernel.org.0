Return-Path: <linux-rdma+bounces-1759-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E8C10896D03
	for <lists+linux-rdma@lfdr.de>; Wed,  3 Apr 2024 12:45:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9BC9C28E442
	for <lists+linux-rdma@lfdr.de>; Wed,  3 Apr 2024 10:45:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5549C14535B;
	Wed,  3 Apr 2024 10:44:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Bpce7uy2"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2045.outbound.protection.outlook.com [40.107.223.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90796136674
	for <linux-rdma@vger.kernel.org>; Wed,  3 Apr 2024 10:44:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712141074; cv=fail; b=Mfr0Fq0gM3/DKj2Hu4TbNt00HOwjqjk46PX+YPMJGWHJNKxxNwRQ02KoUcs3PfknhiKh8BGFqUHT7PnB4JEOEW1rg4hO7SFvtexb6uZGKp1RSovWbq5qbtY8ds3J2r6j4yz2cXqBRLpqb0+vFZPJumyLeD6SJ7NFL+o7QAc4n3g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712141074; c=relaxed/simple;
	bh=DaUpoJ22GYrdvzf9LmesGLQMvA/cSJnaBxRbdFeSJYo=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VXpg1hTdtXxMUqMpf3gCM6h5oKwNRnaMSR0xy1LKvWoxwzZtyI4kWSjPbxNwKfCGxbh7cRSC1QN7OFcVvkNhFSFtxZUAYqkpEAqNmuvv32ma5OOFqZzK3t3jRBcCqZwG7u+zpTUxJxOnUV2RBwusLN8yeACTAuoGCEwugFuBLKI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Bpce7uy2; arc=fail smtp.client-ip=40.107.223.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y03B56F3WQCLD57tC2Dxk3rHoaekdR0oNXcbXPajGh5/ST3RoBR0y2/ZfeaZYbvWLk1BKAoEIOLrSC0ubOVofPhm7t0mj5I5a+JDWyfuqUxCRHlfL3aqd+4wTXiRqPnpTaRI2KvCdvrBfG8+QrrIZ0D2ZGDEY2++0utBhhaWZinOfp0BWCs8Ix7w2j9qFn8UZvTW5L9XVR9mNsKe+mj+yii+iHEA+f3Ew1U6n2Bk0r4RHBCHG58rcK6QiGmpXyW748C8hDsDyGQfbiCZI2ANRiOLAYyae+ZzkR3K2RXBArVThjHO6Ym/sC3us0L6v9jHSUhpfoVoYj4RoWdaC4+sXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DaUpoJ22GYrdvzf9LmesGLQMvA/cSJnaBxRbdFeSJYo=;
 b=KYo9tNH15nBcouCMRbwWKQ6ThB2V1bcLcjmDwKcFd4qeawJxspu06ad4ivxWiXUPWY0//qhrYGVY4d+tXfUyeN+o8mktBFOpXnsSQKvFCCMUGahgHRwOizDjsbl9aCpXxuN8PzuoyNEDrYxsStxXWIgS5qK8PtfxQq5L4X518inSHYvcC1vrPUHCmp1wp2SGIN9ySU95M6H9sDLZnGDwhm0hEtE69J9qfb4f/wpQB3zrD4JQ7TswPNHqSnfYowV2+ndK5XbpK203KGxu+8kInvnCmu3IdI3aZXB3pt898/efo0sQjSiPAZAZUsY/9EwdQOPvgGjoZgQ1hQhBtlAhkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DaUpoJ22GYrdvzf9LmesGLQMvA/cSJnaBxRbdFeSJYo=;
 b=Bpce7uy2eKQp32VKW7FzXikxytIXHXWAQebRMN9D+5q00ZaBulBC85GbBAJnV++G42dAeuPCa1q4z/lU3BfLp4ih1p/No5H6Gn88cTAV5xvfHsvbPK19sBQFq9Kg3aEfGCoJi3VoUfq4oakazlRWzSwI6iDq6ihHU5+Z0IEUFRNUnKLLgtAYxaLXTRZcTF5MGR4ysrc956BsbKB/n70btjvKwM4XVf47HMNbhDtZvS6/MP9umOU+QYx8Zr/2NnTdzJhLFL8mpABXK5YS+03E99GykL4FuXMht7WW4utOEh9ZB9KitJQhjPz3M1x4fFqHVbr/OdiIPuKtsd+zH90+EQ==
Received: from BN9P222CA0001.NAMP222.PROD.OUTLOOK.COM (2603:10b6:408:10c::6)
 by PH7PR12MB7020.namprd12.prod.outlook.com (2603:10b6:510:1ba::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Wed, 3 Apr
 2024 10:44:29 +0000
Received: from BN2PEPF0000449D.namprd02.prod.outlook.com
 (2603:10b6:408:10c:cafe::e7) by BN9P222CA0001.outlook.office365.com
 (2603:10b6:408:10c::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46 via Frontend
 Transport; Wed, 3 Apr 2024 10:44:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN2PEPF0000449D.mail.protection.outlook.com (10.167.243.148) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7452.22 via Frontend Transport; Wed, 3 Apr 2024 10:44:29 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Wed, 3 Apr 2024
 03:44:11 -0700
Received: from localhost (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.12; Wed, 3 Apr
 2024 03:44:10 -0700
Date: Wed, 3 Apr 2024 13:44:07 +0300
From: Leon Romanovsky <leonro@nvidia.com>
To: Jason Gunthorpe <jgg@nvidia.com>
CC: <linux-rdma@vger.kernel.org>, Michael Guralnik <michaelgur@nvidia.com>,
	"Or Har-Toov" <ohartoov@nvidia.com>
Subject: Re: [PATCH rdma-next v2 0/3] Rewrite mlx3 mkeys logic
Message-ID: <20240403104407.GU11187@unreal>
References: <cover.1712140377.git.leon@kernel.org>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <cover.1712140377.git.leon@kernel.org>
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF0000449D:EE_|PH7PR12MB7020:EE_
X-MS-Office365-Filtering-Correlation-Id: c8fbac45-b612-49ff-5ff8-08dc53cb0a4a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	g+oYiT7B3ickg5nJE9Mqkga6TXe6RKqSkznF+e1bCuXjAlp9a1/Qdw9F9WnfERm3QOu3zD1NgCP276wbQCj7cUjgodzpve+9BxMkornWM9NV0mAIN8mD9kdbhcqzdDF5iKo1LQQS/9DaZL7sLwJaeXp+/wlyJ0veOWY4YawzzG7br1DGSbHxuVa0HbWg8k9p6RaVUT+QZQ5O4SlrQGJ9Wr6yGMqpdw347BBK8mgKbHCgvlQCfkR/UJkigVrxUlUY9nisRvIVVp+/+xNoDoTSfB2wBk6TV2XkUcqfdClURJHu2SueUWDmc9L7hqu3z7BqqUYq1z27kbcyX6XV5K4U1ADHzr3piubrm2XOUy1FEmq8wojhwzBA9/fCpGom5SQR++pJngi2oHuXAb3BxilTe0+RZESjk/WZTPVlFv6R22l8QwP163TYbnbVqaVKVRi4hGopgxQZ0vMAIgSn4g5fupLQlh70Ah3wdJvMOgKnckpe2uJmvfJ2dBUY3Wkqx/7jkZLzDuJBGaYFpj54FZu+VsBrmFbVd9XKxHatkQanNuZHYZZews4JA8p23X2T02iNWqREkPj856yZcHj2mYiKe01FPeOrCvkl724EIwVR2T8QkU4vdCxxjOCudNrZ9nEmsDMEEse9yyBQSB4wh82hF/y6fFuE1sYL9T9J4NqdErndM5hRaCg5UQfuqiDdcoTyTB3iAgUCNbW+WXS6aSRpvc3cNxV/ct1wkm9nvbBc/XwUbUTUzNeMIdds1ewQGFgX
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(36860700004)(1800799015)(82310400014)(376005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Apr 2024 10:44:29.2443
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c8fbac45-b612-49ff-5ff8-08dc53cb0a4a
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF0000449D.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7020

There is a type in subject, it should be mlx5.

Thanks

