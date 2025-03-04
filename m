Return-Path: <linux-rdma+bounces-8294-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4109CA4D5BE
	for <lists+linux-rdma@lfdr.de>; Tue,  4 Mar 2025 09:06:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 43721188733B
	for <lists+linux-rdma@lfdr.de>; Tue,  4 Mar 2025 08:06:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 708961F91F4;
	Tue,  4 Mar 2025 08:06:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="snv0GAEj"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2072.outbound.protection.outlook.com [40.107.236.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A79618CBF2;
	Tue,  4 Mar 2025 08:06:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741075578; cv=fail; b=pCOdjYSHuU4+VqGLeZoLorrYZuff3TZLXgbHBz99WxT8LQ5RDfLwRZ7xP5xloq85Xbsc4T/Xp922WQ7iSqkaAIhPptUuh/1Bed2KMt4R5wi1Ap5bWz1psPURuMuJVWCQU+hi5AbKNHai9W42w4uLJU3FMXgau7eqfxdAinK6LjE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741075578; c=relaxed/simple;
	bh=gZdJyp6nJ0swHy3z9GKZPCVOHlZU/8dzO8DAdfnpXqU=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TtyQzltZjHidyTnbie8jOnbazkUEKrtr5s6/9pPI1dFHygw7J+SKlPt5Xs76I0yUYcYUQRKgAiirz7G5F8mw69olGxvwOdwg3PKNgNTESgy0jGOaPRPcdPQLI/vrvT4RZjUPAB1CQO/iaN3kpFSJ2wpEAeBd1ng3UyIgE/QqX48=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=snv0GAEj; arc=fail smtp.client-ip=40.107.236.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lMGsF/fUfJDyJWoK/92O74tVyYDvKzN4qj3CZ2EdZ5QSq1/5AqlN4SCo5OR894xl3JYDQSNPVyJlW83LDd0pvYdVAGs2eogklJjM0m6bLgYFFyNPwdMST8AQk9uxfyvIE7i5LQlR9HPZXZBJGfS4V5A46VZZTtQ9ksjhINfiNANZq/4WRGFZ5JANioMWn4skdFRzKva1hKoq0TIFaq0d/qaetL5QiKRTyvKRP/ia5DfcPISsEeJmLciUlugNm37onpUvH08kNZZ1Ttz4QnV0SIFoIYw3w5IrDj1yPaM3OAkNxOGMhZqK34xjTXmQfj5CvyAFHwmMkjsL3EOEqHjLwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fpLuiUHIJPVdyfRdy/vf7Ne9rMqUxOru/AKTsWrfRrQ=;
 b=wVq6LXSl1pvrs4MssuZczcZiqG/YtHffktinxNCY72ZMEKgxW4XdefmaNV5GrKSznFtDftKpjT69UzMkRgvTcrU8B3ljyf1NwoWr3WaVRYDOt/LmTEQAOapNZQ4uMxwvtaU7AHVGHCtbB8vUV5U8YCSO23V5vCM9jr2WXba50UDQvTF77f+vkeRk6wnxJcAbHEzD5wjDGv2EnZmOCYKgm4xKIn69kX+Ozy56EDaSi0t7j7gHdpILpgfhVmehOR8yxex+T/lqRzA0G9tpXDhMJuFiO0ko2fChxHvnLKf8pi21jRWOoiIL440y5rfgOspSNzPhOtyIG05vjaH3hvoYVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=linux.intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fpLuiUHIJPVdyfRdy/vf7Ne9rMqUxOru/AKTsWrfRrQ=;
 b=snv0GAEjpn9AXV8jgIhwdWTL6GRZDnUz+FucmI3iBlEVS7/1+r6s0J9qPXhymLYZaNPr3e8WIr9q9RTaVCh77+jEAXgdNGgTGhdtZwqphDGZI+H2/TpUiMHtgpZu3k9pGom96iQmvPnozA9rUp0jffx9BOQZj+rsgsL1S0dpfvFK7o7YUxa15D8yxrnj2LgJjIgW99psIVyU66mcbyMkb26rWj87SV87B/9A2YaBX+y+Rb9jLBPZJ7l6TPPVr27deBny381aqeerS0f2dTcniIu81rQi+O7ERJUjLobZq3La6RE3uH9JgORjK/JfCWMb+9mut0TrcZgU6SxgE0JFIw==
Received: from BLAPR05CA0020.namprd05.prod.outlook.com (2603:10b6:208:36e::23)
 by BY5PR12MB4129.namprd12.prod.outlook.com (2603:10b6:a03:213::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.16; Tue, 4 Mar
 2025 08:06:11 +0000
Received: from BL6PEPF0002256E.namprd02.prod.outlook.com
 (2603:10b6:208:36e:cafe::94) by BLAPR05CA0020.outlook.office365.com
 (2603:10b6:208:36e::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8511.14 via Frontend Transport; Tue,
 4 Mar 2025 08:06:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BL6PEPF0002256E.mail.protection.outlook.com (10.167.249.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8511.15 via Frontend Transport; Tue, 4 Mar 2025 08:06:10 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 4 Mar 2025
 00:05:49 -0800
Received: from localhost (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Tue, 4 Mar
 2025 00:05:48 -0800
Date: Tue, 4 Mar 2025 10:05:43 +0200
From: Leon Romanovsky <leonro@nvidia.com>
To: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
CC: Tariq Toukan <tariqt@nvidia.com>, "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, "Eric
 Dumazet" <edumazet@google.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "Saeed
 Mahameed" <saeedm@nvidia.com>, Gal Pressman <gal@nvidia.com>,
	<netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next 6/6] net/mlx5e: Properly match IPsec subnet
 addresses
Message-ID: <20250304080543.GD1955273@unreal>
References: <20250226114752.104838-1-tariqt@nvidia.com>
 <20250226114752.104838-7-tariqt@nvidia.com>
 <Z8aw1gn5iFNiSxd3@mev-dev.igk.intel.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <Z8aw1gn5iFNiSxd3@mev-dev.igk.intel.com>
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0002256E:EE_|BY5PR12MB4129:EE_
X-MS-Office365-Filtering-Correlation-Id: 4484d25c-ece2-46ac-5003-08dd5af36cb0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?3p8e2YjQ5zB+l4+SzxCPQy1qdWcWKu8kU+OrXQqcFsdeuoS0vbFTWqjbSwKx?=
 =?us-ascii?Q?LPPv7D+KtghY2tSSLMerpwrMb4oXA6ZMnt0ZRvLviip1rNaDn1ry523+V41y?=
 =?us-ascii?Q?DrXlQOxzIIhjl6J12Pa9i2Je1GeEKgS1y7Y63z8Cu7QhIzfk51aPbC6jTvYr?=
 =?us-ascii?Q?H1uY3gFt5CqsLzb1PJ++dqGeW5eUvMeATG2VnIPvM32Jd3TiX77tat4nsK+H?=
 =?us-ascii?Q?Vh3XPZKFhuXf9PApgazK1nwIDeq7GaFvj6kpWtDoZMAFD0nI+YT7bVfHmuVd?=
 =?us-ascii?Q?Mmwv4nva7q6/AIBj+PCU8pZ72cMjUZ/+mPmahixncicDF6yKQKxewWy5F+VC?=
 =?us-ascii?Q?bQ6obxaceYC+PkBW08r6bCC1zrtsgAW8U7vVZO9W54ptGg2jzqv863otlPKO?=
 =?us-ascii?Q?rUIDiBBPETI9IgLQaSKL7QklQo0d8jwKs04/VaDd/GxFNIjvGd3HFF/QnI6Y?=
 =?us-ascii?Q?gBI9/dO8NnnshWD1n3NbwzGgGmmYwXLAMy2ejbkSUIvTa58cvDKaqML+pUhJ?=
 =?us-ascii?Q?FGOizFsBXcGMA0pXeR80Igp8FOjUzVauNafPH6wL8dyX775bzt0O92MuKz8k?=
 =?us-ascii?Q?RQjJkQ9+AGfVoKpa8BKvLrH37DPTu9k9RHBOOSCSlitlUnE6k4YEvhlL6wDk?=
 =?us-ascii?Q?Av1PCukeJRjoX5nUdsW9rEbrTkqpOYkza4wwUXkTkmjuWZGNGFxXoAAcSllE?=
 =?us-ascii?Q?mfnor0yE4f2xRI5/jwcwNAkcla9jVXsIuJ/ZjnKSYfwJdsKBPr5tMcIh5C2m?=
 =?us-ascii?Q?vVTIOyw4NSJpdVI2Jk6NIIVmsiB6BPHiqi0BeP+a9eAp6EFSxo/Ai0n1T26w?=
 =?us-ascii?Q?Yxz480U6yOgh//ePOY7SEnv43gA81RKfV/uhmy3+Ux8dhqadrru5r0wxpKld?=
 =?us-ascii?Q?kiWzwsAG7wS8pKjgp/nnTrgUZ84l408S+aACSmUdaj6jNc6u/Mg6/KC0Jfi8?=
 =?us-ascii?Q?FaJOjvNVS2W0PDZ26VpUiJ6YMWKTlQpHBvBzbuh9pqig561q6Jk6lTCP5B5g?=
 =?us-ascii?Q?D3HZRg0Qhvbg3NpzCvbkAIXyPdKLpvrijOSYDXXNMxBhe4O4eGiqzkJgB+se?=
 =?us-ascii?Q?ydvdHE5I3jndok/P3MaWmjnq7fvqT7Q7Pdmi4hBw8AQ21OY8pt7WzGDdbyvn?=
 =?us-ascii?Q?1srAGjMO2cfN2eOszVCsZjxl8aa0azryNQJCqv7fsF/P3v9d6sjcZ+bf08rR?=
 =?us-ascii?Q?cqko7EFKx83mbMrj1jHSiPaY4QJmngyS24DB4kliqS4UMuxDjKGFnCsAMvjX?=
 =?us-ascii?Q?l4nHfMBa2nxeUnfOEYk5bSsAQSsinZoZCocGJuarHPsfGAmrE7dSPAF7ZN2y?=
 =?us-ascii?Q?FrCTzqw3kqRuihyuIfQ8KC+kOoHMfxFQaZpfZ4hUOXDdl6p8fFHvyCt4CY73?=
 =?us-ascii?Q?68l9yEfcf/x+JZtR6Vjd93O3kznyW3qlceKCD1mJ/7Q/oshs1wnWn5PrJnec?=
 =?us-ascii?Q?Hhssxu6ThiMCFiwWav0eq9D2a8PTJKK/idd4ATG095zHD5fcJ1F4TP4BSxlU?=
 =?us-ascii?Q?ujbuz9p5I0u5JPo=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2025 08:06:10.1962
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4484d25c-ece2-46ac-5003-08dd5af36cb0
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0002256E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4129

On Tue, Mar 04, 2025 at 08:50:46AM +0100, Michal Swiatkowski wrote:
> On Wed, Feb 26, 2025 at 01:47:52PM +0200, Tariq Toukan wrote:
> > From: Leon Romanovsky <leonro@nvidia.com>
> >=20
> > Existing match criteria didn't allow to match whole subnet and
> > only by specific addresses only. This caused to tunnel mode do not
> > forward such traffic through relevant SA.
> >=20
> > In tunnel mode, policies look like this:
> > src 192.169.0.0/16 dst 192.169.0.0/16
> >         dir out priority 383615 ptype main
> >         tmpl src 192.169.101.2 dst 192.169.101.1
> >                 proto esp spi 0xc5141c18 reqid 1 mode tunnel
> >         crypto offload parameters: dev eth2 mode packet
> >=20
> > In this case, the XFRM core code handled all subnet calculations and
> > forwarded network address to the drivers e.g. 192.169.0.0.
> >=20
> > For mlx5 devices, there is a need to set relevant prefix e.g. 0xFFFF00
> > to perform flow steering match operation.
> >=20
> > Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
> > Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
> > ---
> >  .../mellanox/mlx5/core/en_accel/ipsec.c       | 49 +++++++++++++++++++
> >  .../mellanox/mlx5/core/en_accel/ipsec.h       |  9 +++-
> >  .../mellanox/mlx5/core/en_accel/ipsec_fs.c    | 20 +++++---
> >  3 files changed, 69 insertions(+), 9 deletions(-)
> >=20
>=20
> [...]
>=20
> > =20
> > +static __be32 word_to_mask(int prefix)
> > +{
> > +	if (prefix < 0)
> > +		return 0;
> > +
> > +	if (!prefix || prefix > 31)
> > +		return cpu_to_be32(0xFFFFFFFF);
> > +
> > +	return cpu_to_be32(((1U << prefix) - 1) << (32 - prefix));
>=20
> Isn't it GENMASK(31, 32 - prefix)? I don't know if it is preferable to
> use this macro in such place.

GENMASK(a, b) expects "b" to be const type, see
#define GENMASK_INPUT_CHECK(h, l) BUILD_BUG_ON_ZERO(const_true((l) > (h)))

Thanks

