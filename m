Return-Path: <linux-rdma+bounces-697-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E2FF83734E
	for <lists+linux-rdma@lfdr.de>; Mon, 22 Jan 2024 20:55:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E306B2944DD
	for <lists+linux-rdma@lfdr.de>; Mon, 22 Jan 2024 19:55:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03C393FE50;
	Mon, 22 Jan 2024 19:55:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="hKHAzZl4"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2041.outbound.protection.outlook.com [40.107.223.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41FF83D981;
	Mon, 22 Jan 2024 19:55:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705953335; cv=fail; b=ipYPkqxrzol37H+dh/MEJTEZP5UOiEwQj0o3dawzleVLHRUX7SaYx5zdlpSlsn3+xLMKDMkfjYYH0nUnBW3zaxMnrdYMhfm1PMuvwljfF2ImyCxoJgXd8u16E5rM/Qm3kCxl2t8RTPUYTjgSmhGt64tlwrUNIOkeYd9e55sASF4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705953335; c=relaxed/simple;
	bh=ld9bqwJk/N04APp7zj8w8G40MY2R49maaQYTXHve+Fc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Q5+hoM/3/SaZnuCtwRPLy9uIfM1Z5zld4XZBQujfb1G62r0L8pYMf+YiBsykg8YSJ0djaxK4Z98JSOrAp3VkxJId8kG9+ZYX7RMf/UJyS+5MGNUBRwMJ0w8r+dMNHORbbdpJ9n4e32iO4s5+kw1dyreP1+1H03mlhByWPF3TEIM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=hKHAzZl4; arc=fail smtp.client-ip=40.107.223.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ESOabslct4petnJJIg/RLB0PDpb/0STxyl0uO4dZoEEyCSF2e63wJKMmOB/UIf2Q1oqKoFJJEpqPmaWwqWm2clzA8d/NmxOOolI5mfBeAhGeFpUU5SSxqF/5JFhDF78KW43YxyMEQQJgFmtAw8aAqZIBwntCQWfexHaz0na4LEn/LIxIRmLvfOs7nIA9GbhaBe5Z7IRlyOASbfIsk5ua6sy4MWTEjDm5IsCVppxrprrIruDeyLChE7dyz+zTNiRDoMq9QR/jBXhVX3jRv2ZEuCWwFSYNhTDOAud/e49DkyCY/4XekB2wggDfdHx3yU8XKHF/tGayN/Vwu/WJsgOm3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=21NGy35j+OPZC/y9Ha/+ZqWVQC1dAoXJObkYnbpuQTQ=;
 b=TjE4G0XXQRrdPt7hZ+g0ZN8Vb6kVLblhAYVDiUCvoP3F6Izaclk5FjE+VYaeOQC3G/DkCYwbF5Eg9S9dMISw7aq5KkWhrj6BMvdzsUDUIT+IxEIwIMES5eLpg0aORm55okc+VRtm8CW7cKNdZc/DhBVp9ibUo+95NN4NwfjGvkcgI12uumn4HV+uJmZ5UOoSwHfOg6OUb1NCToqRJQwYOWpsusgxAvFnz5TS5awVzRDcWhunwhDzP69WBdNKXsOtRUGE+9JJXPWSRhz+TcglgOtSNVwywpiTt81EjkHB0/HvVVuJ84ug4zFIqmFu+DtS2ubocOrRyWXUXneKV62L7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=21NGy35j+OPZC/y9Ha/+ZqWVQC1dAoXJObkYnbpuQTQ=;
 b=hKHAzZl49McvOlF22lwIUdNCSa+dSHuHIZvBq95tzzSeYZeWgVwZ9UJGuEdQCI+SH4qHshHxpVh196tbMyxBmbvZsZKgN8HtrnoOkQ7in58v85ANBzfhhotZltkcHN+KkOB8mqFBAc1G8gTjht2buu9n+CvLQ3ZzulUEdZx+GvjfoYyJ+FAXI72nxGwfyX6colPo0sJqzepTiQtlW8frGoeOtHLwmKF3IkFgC+q+BxMayRI/ii7zMLkpBZUrBA/5mJSqYofvZol2LLEWarNrXBYL828iuPsf0fbz6TdR5A1pS6GKDG6jyaXqSfV93e1qeQ35s7GgpSYSG3vyQuvx+Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9134.namprd12.prod.outlook.com (2603:10b6:408:180::21)
 by SJ1PR12MB6244.namprd12.prod.outlook.com (2603:10b6:a03:455::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.32; Mon, 22 Jan
 2024 19:55:31 +0000
Received: from LV8PR12MB9134.namprd12.prod.outlook.com
 ([fe80::21a9:5188:e977:2bc6]) by LV8PR12MB9134.namprd12.prod.outlook.com
 ([fe80::21a9:5188:e977:2bc6%7]) with mapi id 15.20.7202.031; Mon, 22 Jan 2024
 19:55:31 +0000
Date: Mon, 22 Jan 2024 11:55:29 -0800
From: Saeed Mahameed <saeedm@nvidia.com>
To: Niklas Schnelle <schnelle@linux.ibm.com>
Cc: Leon Romanovsky <leon@kernel.org>,
	Linux regressions mailing list <regressions@lists.linux.dev>,
	netdev@vger.kernel.org, linux-kernel <linux-kernel@vger.kernel.org>,
	linux-rdma <linux-rdma@vger.kernel.org>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Alexandra Winter <wintera@linux.ibm.com>
Subject: Re: mlx5: Regression VFs fail to probe on v6.8-rc1
Message-ID: <Za7IMcstTALcSnPG@x130>
References: <dd98c1417b0c5027da8e712154eea99807fc4286.camel@linux.ibm.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <dd98c1417b0c5027da8e712154eea99807fc4286.camel@linux.ibm.com>
X-ClientProxiedBy: SJ0PR03CA0081.namprd03.prod.outlook.com
 (2603:10b6:a03:331::26) To LV8PR12MB9134.namprd12.prod.outlook.com
 (2603:10b6:408:180::21)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9134:EE_|SJ1PR12MB6244:EE_
X-MS-Office365-Filtering-Correlation-Id: 838e1235-a4e7-429d-0bb3-08dc1b8416c3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	4MmmLbgDlZlv4X16fGOonuzpC6V8KXVEOEStkhXmOSnJff5soPtJz84s/7GNVqKm29CAqi8Rhepe9F26816mRa5jQUKLmSotZx1Nd1QKUYwXkzS/6ItlriqrWaC58pc1FCWZRcOFMVK/PwCgdM+fNWYgWsieqLoYTxaNsk2K1qWJXqDCuqtKyL1+e3lm3GwJ3pUdPMVaB3YEw5cEaBnp9q0Ct4jdRBWAjbyXERoYtzUnYgd+dSc2Jevvji2XOkVr/NhE+IXQSOL08K/vWWglYVjdMTWFuQWDxHEapk326JVshEesVdeBF3YpTBdtIQ3Ey3aoBTIIO/4pC1a+xjt3couZFJENvlcwcCglJQLouIgpvKl1rj2uK/yMbZ65acbu991zqwp7pP1xQVT3qhe3Yzjo+TxXykBkEj9nG5cVAHrHM+wuEhlcGmq1nm/K3J3Plr1GUszhTtXbJRS8t3YNvfZNi4evQ1xFDN/tHvuyVdmeoPyllPIk/m30tfWxwNHc/jqa6xMCm3ouCHJ5LW/Q7XpLopfBjGKDV/2Q1fl1Ef1bGa9QaAq7jh10DEbw/cWoOo6/K9LTcvJljcDNFj9Km+ZjBf4WSso8DSEx05noxjeIUTWKZ3Jd5U47GAJSyTDmfFnyE9j/wgGIe4s2hqsvyw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9134.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(136003)(39860400002)(346002)(366004)(376002)(396003)(230922051799003)(451199024)(64100799003)(186009)(1800799012)(41300700001)(33716001)(38100700002)(86362001)(83380400001)(316002)(6916009)(6486002)(966005)(54906003)(66476007)(66556008)(66946007)(5660300002)(2906002)(4326008)(8936002)(8676002)(26005)(6512007)(6506007)(9686003)(478600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?JwczVa3C6o/nsEkWqZ3mVz1osExkiYHRuHt93e3tBoFxnf9jDWWqwsZxDV00?=
 =?us-ascii?Q?2rX+zYNI3jwj40361iRtBc2XoFqh8vtDZwccKBtUd6zWG/JsreXI6C76DpOD?=
 =?us-ascii?Q?+sXJZLfkn5U4JvOp95BWkuYNH63Z32xHc+glIMHM+sLn8JLANG5gCk2hAHTx?=
 =?us-ascii?Q?oYzHHpWuYYHhoKnunhg0oo2lUT8LCglG5W4K0lw1G3krEW0yD7ZaYDmkBS5o?=
 =?us-ascii?Q?s0xOactstWkRi6rfRi8G0a952f4kqZS/NX5vMy5NL19J7xzhK+PjohDSat5W?=
 =?us-ascii?Q?ckY5h/ymhrKkck87e/E3dYIYndXuEWOOqEPC93ZmPY76cA7+PBN4X94hIu1g?=
 =?us-ascii?Q?DlGQSd0tAtUeKI/tksG4FcgH9N1xnLZ3NKpxC1VYpMR6bb36tUmNpz/1+nyQ?=
 =?us-ascii?Q?ZtnlG4CGHnmWqZaUyWdZ/QFe0OqQx3oGJ10kuPyhPYReptltw1zbXGK8CuMO?=
 =?us-ascii?Q?9CV1h9UkXUHTkuh1/YNOILmYbmMvaTDCBPgHcAsSvCyVArkMQtdT4NKHFLNm?=
 =?us-ascii?Q?PsoXvugomuWqm0UkQfRIq05X6i4muwru7k90WEidhQue5f4rYwtaTOieHBcS?=
 =?us-ascii?Q?dc2v0b01SGVLwhHg1WZtewUfi8B/BhoSGMGNQAOaaVwYJH/WhxjRORsWJvC0?=
 =?us-ascii?Q?SVUL1peHvNy1oVNfK3ZyZ3Wa1S0+rDJxmpbDiQc11qd9MrujlWtWpGZATe3t?=
 =?us-ascii?Q?diF1gZrM6+VwDjnQ7ZoU3Bkq7VRbXGoH6BHvZFsbLBCDCytXF7QBEnblCd23?=
 =?us-ascii?Q?rnk4n6eVVV2CkiHdIpLl+NVs38YyqYW1+KB76AY8E6EHOTUgq/bNAL55+PJc?=
 =?us-ascii?Q?qGzxQRNCYUhrcZrTmKCb0cii+ofJHBSm8y1oLZx1kYGITAoJtSLBZJZ79O2U?=
 =?us-ascii?Q?7+gHrbJqRAfrDdtE71z1kEA01bPySv6ajYQRuWsOVqRRexGeDrtuHmJK49Os?=
 =?us-ascii?Q?p+2+oBJn7cWp8FwpTyaUly5ESQOIrZqzQm8Pt/qIWxsouTQKZcjAEMg0HOJR?=
 =?us-ascii?Q?jjI8QZb7xQEqfuIIpeuaxsVvYDeIfIaXFaNqLSLx9dud+wBcBi6/jy4Il/aY?=
 =?us-ascii?Q?tQsI4EVxajIkbOJtnCOqY5/mIexdSJh4sYPHN9kf4J3eQgxCqYUFDYgb/reo?=
 =?us-ascii?Q?+0Lt9ODWqG6kN5R443xg9IMbdCl5SuyM69itGYdaAbyCuzf9WVtv4XkLloul?=
 =?us-ascii?Q?SUXv2Ms/m9wVKSMu7/inqVEnuNYzPaY8QPXOnVqcL8Yy1UILcWgJCBokfJoL?=
 =?us-ascii?Q?Q58nBGZmlGs/Ll3dGNfemi9O4/XqCejlKW1wfPVA0Vn4fj8piA84eebl3p0f?=
 =?us-ascii?Q?QNeSLzuvclFtLQI0Si6dDJ4o3pC1UDy39vh3paU5uIsHtQV2XiGUUCEChVFw?=
 =?us-ascii?Q?9woJoG1awx2rRWwKnUDlmj8ZDsR1IacrhhpWBfWQHNskS5DInwp7ywPOslpW?=
 =?us-ascii?Q?6zHlPa51f/opujuFOB5Ch4/ceOzUt+TXQmKgbz5z12jcpAk4j5GAELlTvwG6?=
 =?us-ascii?Q?AR1b86x7AGpAKkYC1aRMmAdZ0scmD4nuPitYRKtVj9cPGscYit5V0795iwaD?=
 =?us-ascii?Q?ndIC6zD2OxW2MpGxAQybaly9vudyDW0VoVbzA3pa?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 838e1235-a4e7-429d-0bb3-08dc1b8416c3
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9134.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jan 2024 19:55:31.1950
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6d3uV2GHOJWB8Ve1DxdPJj0SX53BbAx0+QViMWFf5NcvcpEa/HyotBTkbLTZxTF1xK0zQ0HUgTxmfJsj0DCeFw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6244

On 22 Jan 12:10, Niklas Schnelle wrote:
>Hi Saeed, Hi Leon,
>
>On current v6.8-rc1 on both s390x and on an Intel x86_64 test system
>with a ConnectX-6 DX the mlx5 driver fails to probe for VFs (On x86
>"echo 1 > /sys/bus/pci/devices/<dev>/sriov_numvfs" after a fresh boot
>is enough and is 100% reproducible).
>
>In dmesg I see the following messages (from the Intel server but it's
>basically the same on s390x):
>
>[  110.443950] mlx5_core 0000:6f:00.1: E-Switch: Enable: mode(LEGACY), nvfs(1), necvfs(0), active vports(2)
>[  110.546248] pci 0000:6f:08.2: [15b3:101e] type 00 class 0x020000 PCIe Endpoint
>[  110.546340] pci 0000:6f:08.2: enabling Extended Tags
>[  110.547626] pci 0000:6f:08.2: Adding to iommu group 115
>[  110.553328] mlx5_core 0000:6f:08.2: enabling device (0000 -> 0002)
>[  110.553478] mlx5_core 0000:6f:08.2: firmware version: 22.36.1010
>[  110.718748] mlx5_core 0000:6f:08.2: Rate limit: 127 rates are supported, range: 0Mbps to 97656Mbps
>[  110.730136] mlx5_core 0000:6f:08.2: Assigned random MAC address ce:a6:ec:9e:70:49
>[  110.734351] mlx5_core 0000:6f:08.2: mlx5_cmd_out_err:808:(pid 650): CREATE_TIS(0x912) op_mod(0x0) failed, status bad parameter(0x3), syndrome (0x595b5d), err(-22)
>[  110.735776] mlx5_core 0000:6f:08.2: mlx5e_create_mdev_resources:174:(pid 650): alloc tises failed, -22
>[  110.736819] mlx5_core 0000:6f:08.2: _mlx5e_probe:6076:(pid 650): mlx5e_resume failed, -22
>[  110.749146] mlx5_core.eth: probe of mlx5_core.eth.2 failed with error -22



Hi Niklas,

The following two commits got reverted from net-next, so they are missing
in the current kernel release.

I will resend them as fixes to net branch, hopefully they will make
it to RC2 soon 

https://lore.kernel.org/netdev/20231221005721.186607-2-saeed@kernel.org/
https://lore.kernel.org/netdev/20231221005721.186607-3-saeed@kernel.org/


