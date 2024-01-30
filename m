Return-Path: <linux-rdma+bounces-808-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AE44841C67
	for <lists+linux-rdma@lfdr.de>; Tue, 30 Jan 2024 08:15:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4051C288CEC
	for <lists+linux-rdma@lfdr.de>; Tue, 30 Jan 2024 07:15:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AF0D5381A;
	Tue, 30 Jan 2024 07:15:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="qDudxtQo"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77CC951C28;
	Tue, 30 Jan 2024 07:15:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706598905; cv=fail; b=YZ0Mz8Wv7ys/qMA2rPnmM2/bhjd3FO3JKSAIZL8KSUvWSW9C5hxzy9glaERwNWK3nGAI5YMyOFILUPfSobxcoJf/pUterLEVBielvQL/DqfhT8eBSzm09EXOUpEdim9w6FTEl5awVRn7bswEPWvRAn6TFpiK+kPVJwN+8NFyF0w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706598905; c=relaxed/simple;
	bh=Y2NjI8qP2P+SVttuBkMwJnFNSnhPJtBLv3h3u5rbGsg=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iqV2B9QBGyZ+YH1dIb57fehbGR82wgJQE/0e8SPLYHLmYuQpZL39KvdWek8LTqXDARFaHqG9lNHOqgM0l9m7ZkSjiSYXWdDcEIIJPy6lYvng/lEahHCF8LYwJB6a2Y0j82cwM7rus+eX/A838iX7jBYGAhoEmmnbDvpvuzCRvbM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=qDudxtQo; arc=fail smtp.client-ip=40.107.236.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OxbfFzuN7jh3UrPXHvah/+7GAfAZK+vl/hHgQNUWeTISUvRGw0+j1CYGT0Sc5Xzqx62/aKshODg0WgmE9Q7Rn2eGxCRbfdS7wz4vWo741hLnyNSGATb6c74kcQCu9wy+n3v9P2vMsELVw6myTU+IR34Jo8kAaPAL2UHryMMGzOY+voauLstDg/edUthGIBb4n0cJD7IZ4lA4ZuGU4Gh5OCgfPSTnOG7lQEWOeYVipPWvKlx3IWKB0RtbsnmOaB+dHTQj5RTJHpABSdgKreqTw2sA0DNaSw9utRjGzkn6lqLtqWPkopPnSx8x1L6WGlunEJg0n7w7JevuNV3QBrN3Vg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=49qeI3J3knAMme+lLarWsu8PUb6f78S7Pi26JMxG5mU=;
 b=nxMxeh8foVQoh4kFMCfFjynF3pKUhsoHkPBIbVXUQT+NJY/trwNPt36dRsZ1ANOkYjzFm8V+d3P5O3I4qS2I6TkSaLz1ksB0pIHrpa9/ak36/K5DpzhY2qd45+szjCk9bWqIWCfhomExww2eS8qMezVpylY8FM9xRYWFvftfrozlC5scWLLrklNnsKuPZFLQp2kmSQdBKz7QBvGD7Ds9HJxHxGuCA3dBhdFd4NKxWG2mUhfQQNwMkX1QqwsdUBNhnr9kh/p16Ji2HmTUThhKMb08ol7jN9xKYSA2u/uzBgWUSi/bpgh6ziQGa4EzkT03M0qcMdV1RDhz2esJwNI+Ow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=49qeI3J3knAMme+lLarWsu8PUb6f78S7Pi26JMxG5mU=;
 b=qDudxtQol8dJQkcne28VjpvRF4n8fRZHjF1sZ+jQKeX2vojdrd2/9h0CPe3qAehxM6KF1xDMhRBNtIkssiEe1vVYnT9HNTwp6aZAWC6VaXm58WE0iia/Uajgjb/KeJpl157E7m24y/zirHDrrbyzpyGKGGgiAceBcV2czpHnfH1hx1uzdeN3nP39kosKBloEiiVvU+StF8YfFM865rSXgg+mbPnYFT1ril5zGdN0o42wKEzkPhrdUnbZIsOrTZKwD8BOoAiZInhQgqkQxZdj+MVP0XdHpcMbeaIIk6uQ22Th9jT1jueeP/hugssMHspLEGQCHOYiS0TSkrCK7SBZvQ==
Received: from SA1PR05CA0018.namprd05.prod.outlook.com (2603:10b6:806:2d2::18)
 by SJ1PR12MB6026.namprd12.prod.outlook.com (2603:10b6:a03:48b::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.33; Tue, 30 Jan
 2024 07:14:58 +0000
Received: from SN1PEPF0002636C.namprd02.prod.outlook.com
 (2603:10b6:806:2d2:cafe::d6) by SA1PR05CA0018.outlook.office365.com
 (2603:10b6:806:2d2::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.22 via Frontend
 Transport; Tue, 30 Jan 2024 07:14:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SN1PEPF0002636C.mail.protection.outlook.com (10.167.241.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7249.19 via Frontend Transport; Tue, 30 Jan 2024 07:14:57 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Mon, 29 Jan
 2024 23:14:38 -0800
Received: from localhost (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Mon, 29 Jan
 2024 23:14:37 -0800
Date: Tue, 30 Jan 2024 09:14:34 +0200
From: Leon Romanovsky <leonro@nvidia.com>
To: Florian Fainelli <f.fainelli@gmail.com>
CC: Naresh Kamboju <naresh.kamboju@linaro.org>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>, linux-stable <stable@vger.kernel.org>, Netdev
	<netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<lkft-triage@lists.linaro.org>, Sasha Levin <sashal@kernel.org>, "Saeed
 Mahameed" <saeedm@nvidia.com>, "David S. Miller" <davem@davemloft.net>, "Dan
 Carpenter" <dan.carpenter@linaro.org>, Arnd Bergmann <arnd@arndb.de>
Subject: Re: stable-rc: 6.1: mlx5: params.c:994:53: error:
 'MLX5_IPSEC_CAP_CRYPTO' undeclared (first use in this function)
Message-ID: <20240130071434.GA7169@unreal>
References: <CA+G9fYvYQRnBbZhHknSKbwYiCr_3vPwC5zPz2NsV9_1F7=paQQ@mail.gmail.com>
 <2024012915-enlighten-dreadlock-54e9@gregkh>
 <CA+G9fYs3_M9E3w+uWky5X1hEgoJU4e92ECqSywerqSkF8KVGvA@mail.gmail.com>
 <8c178bd1-e0c9-4e29-9b63-dd298298bc7b@gmail.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <8c178bd1-e0c9-4e29-9b63-dd298298bc7b@gmail.com>
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002636C:EE_|SJ1PR12MB6026:EE_
X-MS-Office365-Filtering-Correlation-Id: 28c84bc4-bfca-4ee2-e193-08dc21632a6d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	l8x5KSPDjHSlaJ7la4J1TwXUoNkUJqPLGv7MTcn1doHQaWTzyXdbwnA4kD5DcZEEzLlnvZFyWTuTgBcjUn/f/Zj9PcCSRpWyIJJlFBokqjCGWClDzvL1ve7A0uzZKpg9J9gMO5FGDN+kLuySDGtfnBIfFqX/I23B4LN8B2mYO/J8SAnJjPCscWBTkUFvWzgH6TIO66sK4XvuNVtDOQ3x63DgMM3Pjqc4I8YnGNzEDUg19hfKMl1EFUEdKyw75gf7DVNBuYEcSmRBHPh/CO4PLJfB38x/qPKtEwZf5PamqH68xj0lG8MIfGnL5UHHoN7JCWS4SJQLLxaj2Ca3HV5tzqXuoplJrAFq/gFD9Hucs/RdQQRxUeHeOTUMssIxfmptcTPyPQN4h3fLCAC/XTaogt03d5P8Iwdtc6lHuKFiZfayvgjlou5oUr2TZsmDyDEuUkTCuEslapOQs+Q6CyFXHbBplfQW0iwy7g+lnMU6pS+ARUp4YNJyRBG8bnv3Aw+L4IJNVhP4Tw9MK+CHaNTKb9WG+6xBRxRNs3QA/BvQJ1bSfLCeqI2x6K7+rposrWKyVPbZWHQ5yCvXKCb9U3JSkjGL3GQ2CVXhzKPoDGFpGKUZeiSTu1U2Db4MWrXgFI3I9s/ytPBN1HXS0leQpuTHe3cptv4F7p5EbO447ug+VmoFjAEU+Yn616pZFcY0XluScjtuIWAeTgrCzeah1thR79BjqDej0xWzknKVSUzhvJm7ds1q3QfhLuKH60GLz1GL
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(7916004)(4636009)(396003)(39860400002)(136003)(346002)(376002)(230922051799003)(64100799003)(186009)(1800799012)(451199024)(82310400011)(36840700001)(40470700004)(46966006)(41300700001)(33716001)(478600001)(6666004)(5660300002)(53546011)(9686003)(86362001)(26005)(2906002)(7416002)(8936002)(70206006)(70586007)(8676002)(54906003)(6916009)(4326008)(316002)(36860700001)(1076003)(33656002)(83380400001)(16526019)(47076005)(336012)(7636003)(426003)(40480700001)(82740400003)(40460700003)(356005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jan 2024 07:14:57.5684
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 28c84bc4-bfca-4ee2-e193-08dc21632a6d
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002636C.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6026

On Mon, Jan 29, 2024 at 08:25:42PM -0800, Florian Fainelli wrote:
> 
> 
> On 1/29/2024 6:52 PM, Naresh Kamboju wrote:
> > On Mon, 29 Jan 2024 at 21:58, Greg Kroah-Hartman
> > <gregkh@linuxfoundation.org> wrote:
> > > 
> > > On Mon, Jan 29, 2024 at 09:17:31PM +0530, Naresh Kamboju wrote:
> > > > Following build errors noticed on stable-rc linux-6.1.y for arm64.
> > > > 
> > > > arm64:
> > > > --------
> > > >    * build/gcc-13-lkftconfig
> > > >    * build/gcc-13-lkftconfig-kunit
> > > >    * build/clang-nightly-lkftconfig
> > > >    * build/clang-17-lkftconfig-no-kselftest-frag
> > > >    * build/gcc-13-lkftconfig-devicetree
> > > >    * build/clang-lkftconfig
> > > >    * build/gcc-13-lkftconfig-perf
> > > > 
> > > > Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
> > > > 
> > > > Build errors:
> > > > ------
> > > > drivers/net/ethernet/mellanox/mlx5/core/en/params.c: In function
> > > > 'mlx5e_build_sq_param':
> > > > drivers/net/ethernet/mellanox/mlx5/core/en/params.c:994:53: error:
> > > > 'MLX5_IPSEC_CAP_CRYPTO' undeclared (first use in this function)
> > > >    994 |                     (mlx5_ipsec_device_caps(mdev) &
> > > > MLX5_IPSEC_CAP_CRYPTO);
> > > >        |
> > > > ^~~~~~~~~~~~~~~~~~~~~
> > > > 
> > > > Suspecting commit:
> > > >    net/mlx5e: Allow software parsing when IPsec crypto is enabled
> > > >    [ Upstream commit 20f5468a7988dedd94a57ba8acd65ebda6a59723 ]
> > > 
> > > Something looks very odd here, as the proper .h file is being included,
> > > AND this isn't a build failure on x86, so why is this only arm64 having
> > > problems?  What's causing this not to show up?
> > 
> > As per the Daniel report on stable-rc review on 6.1, these build failures also
> > reported on System/390.
> 
> The build failure is legitimate here since
> drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec.h guards all of the
> definitions and enumerations under a CONFIG_MLX5_EN_IPSEC which is not
> enabled in the build configuration that failed.
> 
> This is implicitly fixed upstream with
> 8c582ddfbb473c1d799c40b5140aed81278e2837 ("net/mlx5e: Handle hardware IPsec
> limits events") which relocates the #ifdef CONFIG_MLX5_EN_IPSEC below and
> allows the MLX5_IPSEC_CAP_CRYPTO enum value, amongst others to be visible to
> code that is not guarded with CONFIG_MLX5_EN_IPSEC. This specific commit
> does not apply cleanly to the stable-6.1 branch, so maybe the best we can
> come up with is this targeted change that does the same thing against 6.1:

Thanks for taking look into it. This fix looks as a best solution for me.

> 
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec.h
> b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec.h
> index 16bcceec16c4..785f188148d8 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec.h
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec.h
> @@ -34,7 +34,6 @@
>  #ifndef __MLX5E_IPSEC_H__
>  #define __MLX5E_IPSEC_H__
> 
> -#ifdef CONFIG_MLX5_EN_IPSEC
> 
>  #include <linux/mlx5/device.h>
>  #include <net/xfrm.h>
> @@ -146,6 +145,7 @@ struct mlx5e_ipsec_sa_entry {
>         struct mlx5e_ipsec_modify_state_work modify_work;
>  };
> 
> +#ifdef CONFIG_MLX5_EN_IPSEC
>  int mlx5e_ipsec_init(struct mlx5e_priv *priv);
>  void mlx5e_ipsec_cleanup(struct mlx5e_priv *priv);
>  void mlx5e_ipsec_build_netdev(struct mlx5e_priv *priv);
> -- 
> Florian

