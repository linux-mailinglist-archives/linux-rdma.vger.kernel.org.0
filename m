Return-Path: <linux-rdma+bounces-815-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B089842C84
	for <lists+linux-rdma@lfdr.de>; Tue, 30 Jan 2024 20:22:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DD7E32893C0
	for <lists+linux-rdma@lfdr.de>; Tue, 30 Jan 2024 19:22:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A21B57AE6C;
	Tue, 30 Jan 2024 19:21:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="cAKKK6i3"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2040.outbound.protection.outlook.com [40.107.244.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E980A7AE5B
	for <linux-rdma@vger.kernel.org>; Tue, 30 Jan 2024 19:21:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706642519; cv=fail; b=jLWPUmmwSk5hlJoA7717nLzZIMBOgA3BELW3M1+Bo7/eMRgHH+3gI8EoIZGksuYResm6HGAVeqM6jcUCAg7ZgUQvMrqZ3lnZGSUFfqIcBMWbG9lIQchgf5+fCk8shtENmEpQMg8xqCsbL8RqI4bwu3S5b15lFkGAIjsWR5mR220=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706642519; c=relaxed/simple;
	bh=HW3jGaj3LBStC01CXBkGN08jtKDBdAITDIjK7ADkDko=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nZPWNQHZvK0TlMF6M5XAcTtOPtTnx+dUMfRzauS0iJnJu8UCL3D2v9lTWw55s2yAH6afiux0S8mehnmb9SMhv5C0N9qwh9EZuUqmTBtYPC/qS+y/rY0cdBKoMXZfc82bPjtA5IhMQCvZyogN2o6JZkislF7bjp/5NNvvYdJZ10w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=cAKKK6i3; arc=fail smtp.client-ip=40.107.244.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NIOiyW1ONqFo0PLHg6bE6KJQOA0krP5Wnac8+4pXN1pYsuaYlOpekrMyKL6o8qIKHYqLQaM0Px/L3u0b8zJBQV2n+aM0U9r5gKI9Tv5h5dfWotZOyJ0XznC90JOpld80anuexH+qWUBl1MR/Tw+sHkxTSuNLPZLNAVBlbeZIwItT6biXu8c6OPvNJCxB51bh9T0hRJwY6+4HvFzQMFamMHeeWNthVeUpKm8lmZiIyTRZ3UoLb6MZwzdeUj8z+6ScWM2M3BwQr4KYlCDTFECHJ4y9cL8ElFohiohaqUI8nwxjtzwVCb8SYbt8CUOPeJZgPVyk/rJ4y51dYUTQfNkflQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EU1Q2t6PGyzcUwz/RPguvC9jMFOaV8hCrFuyJPUuZd8=;
 b=Og/xjYGq37+x7KPXHN0zeTmNuLyLjAY8/qtlNCCv5Wm0sU37WO8cGLEC5R5dQuwPurNgsrF0EjYkjCuHoYS3HLvkLo2+fDIPflKHQDmzfMMqgmF/gOkRCisbLjp5beL8ql4h3oh/czUffTCEmyUOlnxF9BUaNF8zEEQ1rr9CAVPjvdaAwPxnpFlXaG5PRapGVh30jPta/cGzGBMGMljZR1DBX82/qzRuXKXs+Ql+9G98oXxEa+BY7upJto8W2JqpHRTdfZhmipqWcKnGfBNy+QD49rA+zN6CpMpH45zJx9BhvYxJp6y//JwgQASiCXRW9uwoHMvROYba/pXeJgMLmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=umich.edu smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EU1Q2t6PGyzcUwz/RPguvC9jMFOaV8hCrFuyJPUuZd8=;
 b=cAKKK6i3lDty7wvh5O7XJ7G1YYTay7qf7Q9/Mggd4hFcGPynAvIpNNgWpnQLoVjcnWqfVz33Dyl8B9ZCa97/nIIGOlFfVKX40agXBuxMwmhlKwaVMmQUg7SRjVMpxWuqnPeujVygLB2p/7Pvy0I/Zn01m4uvjeiWpRo5F9j3bJ2OTDcuIc/gqh6CeuU58bVGEY6kW++Mu+hgUSs2gIoUqh1eBNwr8nxpC30zIBHogtk9kn9Fc/uRt/Q4Vdgmw4NvamfWfVGjpTdD8AMpzkSF5l+4lY4d/64d5AysnjAMJqOOUAwfJWH7SUxf4CtCDf+y3kZn4N6qEp5cPd5wcF8f5g==
Received: from CH0PR13CA0018.namprd13.prod.outlook.com (2603:10b6:610:b1::23)
 by DS7PR12MB5864.namprd12.prod.outlook.com (2603:10b6:8:7b::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.34; Tue, 30 Jan
 2024 19:21:55 +0000
Received: from DS1PEPF00017090.namprd03.prod.outlook.com
 (2603:10b6:610:b1:cafe::f0) by CH0PR13CA0018.outlook.office365.com
 (2603:10b6:610:b1::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.22 via Frontend
 Transport; Tue, 30 Jan 2024 19:21:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 DS1PEPF00017090.mail.protection.outlook.com (10.167.17.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7249.19 via Frontend Transport; Tue, 30 Jan 2024 19:21:54 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Tue, 30 Jan
 2024 11:21:40 -0800
Received: from localhost (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Tue, 30 Jan
 2024 11:21:39 -0800
Date: Tue, 30 Jan 2024 21:21:36 +0200
From: Leon Romanovsky <leonro@nvidia.com>
To: Olga Kornievskaia <aglo@umich.edu>
CC: linux-rdma <linux-rdma@vger.kernel.org>
Subject: Re: question about PSN sequence error cause (mlx5)
Message-ID: <20240130192136.GB71813@unreal>
References: <CAN-5tyHSyLU-6CKrkAxsEgyA9ZUXeTGrUVSd25zJ00vgUQ5Mgg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CAN-5tyHSyLU-6CKrkAxsEgyA9ZUXeTGrUVSd25zJ00vgUQ5Mgg@mail.gmail.com>
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF00017090:EE_|DS7PR12MB5864:EE_
X-MS-Office365-Filtering-Correlation-Id: 9f7f9545-d567-402c-ea5d-08dc21c8b86e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	7mQBMJu6QgKqFk5/nN4vxEqfAWCj/6qxmM5t/p+fCqAdXP6Ph0Zvq25clTOvxn417oomsMlVsdRydvz/C+mZqe5ViMIxueZ2v6znAlvOCaYxydPJi/bJSPiBrx+aFTo0Qvb40uClVVWw5ztTx+4zRmpfOyko922se/HOB/5tJcO/saq5r7ZjDvRKAoMZZYiwQkWQp4raQ9vo8XAw8j9BD7477lTDZy8NDw1JQJ8OvX692i+aL5iJ+OwD/CzEeur15QgRD/yde9uC8iyH+KirOETCiG8DYKiphssZE/n8DKmv/razIM8hBFHru6KMrfsKIDfnQsxHzQyqVran4oysYRriZz9xyfwQFrNFhkeHjuH/ospOBjuOlyWYY2Z/TEeLbt1whs8U7VCkCr442ALLM20g2g9JgQJ7ep3WEPaqeqSKcTHFOSyFcsvFiVuNH7rflSFFupSBFSZJFn51xrRQlAGKB3SsVxQI96ly85l0udlKJSecWbBpjfRFeJCVsSyjIrptG7Sk5+/MVYQCP729HRCyr4c4o62X74e8V/1FORC+t2xld8TIKilUkyGpj7je61bRx2+9KYwi1m54+YP37Gj5oNPgSLCwCM+5qzAveKol5XKDVO1qelb2Ro6Aj5+TG/LQ6I4buJ1ijV0ral/T9jTms3dbgpPms1irlf79yCMCab4PUTbxWPTUsfPaqNdRN8f1GqHWNXj+mEuj3N9qkk2bJJ2u9NM4WXYR/8Sj+OUI7KhjM5+lbiS4qzwS+fs4
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(7916004)(4636009)(346002)(39860400002)(376002)(136003)(396003)(230922051799003)(1800799012)(186009)(82310400011)(64100799003)(451199024)(40470700004)(36840700001)(46966006)(40460700003)(40480700001)(2906002)(336012)(16526019)(4744005)(6666004)(5660300002)(9686003)(4326008)(70206006)(70586007)(6916009)(316002)(26005)(1076003)(426003)(8676002)(83380400001)(8936002)(47076005)(36860700001)(478600001)(7636003)(356005)(86362001)(33716001)(41300700001)(33656002)(82740400003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jan 2024 19:21:54.9814
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f7f9545-d567-402c-ea5d-08dc21c8b86e
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS1PEPF00017090.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5864

On Tue, Jan 30, 2024 at 10:03:29AM -0500, Olga Kornievskaia wrote:
> Hi Leon,
> 
> I have a question about the PSN sequence error emitted by the RDMA
> Roce (using Cx-6 card). Could you confirm/provide info about the
> possible cause other than the packet being dropped by the switch?
> Earlier it was confirmed that the PSN checking is done in firmware but the
> setting/getting of the PSN is done in the kernel. I wanted to confirm
> the driver can't drop packets due to resource constraints of sorts.

Driver is responsible for control-path only. All data-path is done by HW.

> 
> Thank you.

