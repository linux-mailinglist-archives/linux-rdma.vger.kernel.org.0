Return-Path: <linux-rdma+bounces-743-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AACE83BE66
	for <lists+linux-rdma@lfdr.de>; Thu, 25 Jan 2024 11:11:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2C642B2B7F3
	for <lists+linux-rdma@lfdr.de>; Thu, 25 Jan 2024 10:07:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE6561C6B8;
	Thu, 25 Jan 2024 10:07:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="V1p4YH7d"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2053.outbound.protection.outlook.com [40.107.100.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B58881C69E
	for <linux-rdma@vger.kernel.org>; Thu, 25 Jan 2024 10:07:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706177226; cv=fail; b=TQv6/g5f8YWc8irDRlCGbObpCZcTe216vrTj0LznHXv7OCKYs1O9O+qP3MbBqxmBMSZy6TlE8yqJpRV8aBV5y2uk2l1u+jZ84las4+8lG1ZMN6w5N/MVtQ9kBP/8oYsVgI0eT8LHE+8N3Ssn5Ic5WY81Px7jcQzDL1Uh5ouFWNA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706177226; c=relaxed/simple;
	bh=C+9ksLZMRJHLft2gSSxdJXesPBszeGhDKk2qImu9CTc=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UfNCWiCXjoIUEsPkbwDsm32Z862cWEtDCSjq21GJSd7zsTnlmFeL/ecpvWBxfwaj1WRB1ljBFNVThS0UJ3qbwYoG0ASeCm0knvP1xpTyScNtLTrIwYEmKGKR7QTtBO46w5VmBbfYO1FAHXbIjXR/u6rUaqclpQTX5u3L8RA4cHY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=V1p4YH7d; arc=fail smtp.client-ip=40.107.100.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GF6ap0IFumEO8EtYV98MEfnN5auE4kZySZWhuRHd1fepvETP2gGwuDF7YeSZByXi91zXs8cSHH3SkQIE90aoO93jGslRqEkTCP1hYQu+QGUSScV0uHoafAMmc7Dy5oVcujVpEQtj1RRQWzH1kUIEMd696GhnwF7h2m/Ry++9KPXw4dUw2QGNHV4ANF/jAWOAEoMnwVP8mJcUkRDbRVMY/b6ZIDY1ztN+GKgMW0MkOZDYLYvmfo/7Q76J8Pc8HnxW8UV+7/zXtGt1QJQ0bgTjx9NcnzA3h45LJsf6CX48b5aCOn0cK0QeNs4jgKB1y15MsCukWHPCxK7z6YTi6x/gOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qSETAfECheE5pE96cVFOW/1zz6iN2d48vio53lqozFg=;
 b=hUEJrTz/1F7YCj3779BC06vCCaLuLDnE7uwH2M8VmOg/7+g2MygI6inQqy6XRaw6xE5v0+FiCI5WNIptXlKH6RtP0h7oL94BeqD/ozyhX6bjlcwUs7mqZeJHVUiG3nc6yNjHZhEnuFbWOJyPBY5BvE0/ZYGIigG5QIaO214We6aX8dCa7ppsV6dAmhrV93ZUoT/fxxLO7UigjpYiMCw35LK7yYGROf8PjnJvNio/grCitHSgG1vy7pGt4cAs+QnqmqsRoydHmrIDQvG8kom8V+iUFO4HvhCG6OcN6k68sGvC+qJlCk/LFv6Oc33zDtoWMtb+18j5IecppoNIiNGovg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qSETAfECheE5pE96cVFOW/1zz6iN2d48vio53lqozFg=;
 b=V1p4YH7dXiAr6ivPsA6e8zzaQC0fosH8SOVD9frAHlmZoNlFvv1tpv76/WicKCSo2jr9FHXo8FMuoPzjdd7LkhvzFKHS9npchwEmFK3HLOKa9QnwhsJXmpbrgv4VPQK+xZyuqC0UzHQWZCFyZtxC17f+gXdBbWWRpf3r++FvvopkBXlNYfGsIY12st5Mci7xwpsEEHJt2nDKPKctvViZzvwxqwZX6IztepPABxcf7UdqchOllkwdGaUQhpvzOvXpHgO3K5diMzv2FJ0ULzIkCfEHUDzhntV1bLQo5SblgscJN0ikrjxXYJ5fNqzK2kcIZlyM/2mDIGVFE4vbJEJx/w==
Received: from CH2PR18CA0043.namprd18.prod.outlook.com (2603:10b6:610:55::23)
 by BL1PR12MB5380.namprd12.prod.outlook.com (2603:10b6:208:314::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.22; Thu, 25 Jan
 2024 10:07:01 +0000
Received: from DS3PEPF000099E2.namprd04.prod.outlook.com
 (2603:10b6:610:55:cafe::f9) by CH2PR18CA0043.outlook.office365.com
 (2603:10b6:610:55::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.37 via Frontend
 Transport; Thu, 25 Jan 2024 10:07:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DS3PEPF000099E2.mail.protection.outlook.com (10.167.17.201) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7202.16 via Frontend Transport; Thu, 25 Jan 2024 10:07:01 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Thu, 25 Jan
 2024 02:06:48 -0800
Received: from localhost (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Thu, 25 Jan
 2024 02:06:47 -0800
Date: Thu, 25 Jan 2024 12:06:44 +0200
From: Leon Romanovsky <leonro@nvidia.com>
To: Alexey Dobriyan <adobriyan@gmail.com>
CC: Potnuri Bharat Teja <bharat@chelsio.com>, <linux-rdma@vger.kernel.org>,
	Jason Gunthorpe <jgg@nvidia.com>
Subject: Re: [PATCH] cxgb4: delete unused prototype
Message-ID: <20240125100644.GB9841@unreal>
References: <a67881e7-469b-43d9-9973-ad7579eb2c4b@p183>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <a67881e7-469b-43d9-9973-ad7579eb2c4b@p183>
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099E2:EE_|BL1PR12MB5380:EE_
X-MS-Office365-Filtering-Correlation-Id: 493f60bc-595d-4266-4328-08dc1d8d5fe8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	FmO/Q2dQEh3l/Tck2mr5vFZvncwqY+cRuHXs8z5l17GNdgoomQBXFHJDyvuoM1fie8RZqQyWLEh2IQoXzCzZ8PdH2IGQlWYj+yZL4ZS/gfCuSuGf7X5OM6D5YrEEeLjp/vTlU804KRqHLV5mvsOJaI4mKGB/gNncYW0QZ9hJZcQ/jYccq6hx+1CLf0aMs/v06EKZMHm0fMOBCjHAKvdBP8+s4nXNjL3KF5BztUl7M1TGSjLrs5lM0vAl/1kPf+EgS4F7zIAkNILAe/aNfElaBQBBEmyWQxtt+UU4vWbylgB4v8MOfQt0Y72hH8y2Frdu9xDeCCh3wvgtJiH1DTWWCU7F5JGeaFJUotKA+B+g5MBAkdfJvLrraGBNh0uSmg0A1r5+45Gf+wMtKJqlmGb0bew1kbEX/2Frjei011JE/ZwkCxaHfpAcmFIOXkfSxZxCBrLbv+UEjAaKXq/lMh+u8d+MQc7OMK346uBhb1jXuZyqgCtBNblao1YscAujrLc2LCd0FQusd69fYkQgwJ37aKh/w5jiMcUW+jrGtIouAAgnE6nBXfiYsfcBMwi7oH+Jc9+PGMyEXAWNtJGeCB388M1duokc0/QM+eONgQQuT3NSM5q1yFBJL1nfhHQK2oyRJcDitcpD/hGMFpWH0TyvZTpOg4nqq+BvumQEefaBybAtJYMVBremYZStSCLwy6qHSSy+zbbNKEzLezipqaWeBUW8R0IfXn8yIwJCnCwr+9s=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(7916004)(376002)(136003)(396003)(39860400002)(346002)(230922051799003)(186009)(1800799012)(64100799003)(82310400011)(451199024)(36840700001)(46966006)(40470700004)(47076005)(82740400003)(33716001)(107886003)(6916009)(1076003)(70206006)(6666004)(316002)(70586007)(356005)(40480700001)(33656002)(5660300002)(40460700003)(41300700001)(54906003)(83380400001)(2906002)(4744005)(336012)(426003)(4326008)(8676002)(478600001)(36860700001)(7636003)(9686003)(16526019)(8936002)(26005)(86362001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jan 2024 10:07:01.4856
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 493f60bc-595d-4266-4328-08dc1d8d5fe8
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF000099E2.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5380

On Tue, Jan 23, 2024 at 01:32:59PM +0300, Alexey Dobriyan wrote:
> c4iw_ep_redirect() doesn't exist (and g++ doesn't like it because "new"
> is reserved keyword in C++).

Applied with fixed commit message, g++ and C++ are not relevant for the
kernel code.

Thanks

> 
> Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
> ---
> 
>  drivers/infiniband/hw/cxgb4/iw_cxgb4.h |    2 --
>  1 file changed, 2 deletions(-)
> 
> --- a/drivers/infiniband/hw/cxgb4/iw_cxgb4.h
> +++ b/drivers/infiniband/hw/cxgb4/iw_cxgb4.h
> @@ -930,8 +930,6 @@ void c4iw_id_table_free(struct c4iw_id_table *alloc);
>  
>  typedef int (*c4iw_handler_func)(struct c4iw_dev *dev, struct sk_buff *skb);
>  
> -int c4iw_ep_redirect(void *ctx, struct dst_entry *old, struct dst_entry *new,
> -		     struct l2t_entry *l2t);
>  void c4iw_put_qpid(struct c4iw_rdev *rdev, u32 qpid,
>  		   struct c4iw_dev_ucontext *uctx);
>  u32 c4iw_get_resource(struct c4iw_id_table *id_table);
> 

