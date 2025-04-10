Return-Path: <linux-rdma+bounces-9343-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E1E98A84C61
	for <lists+linux-rdma@lfdr.de>; Thu, 10 Apr 2025 20:46:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7B4D6189B87E
	for <lists+linux-rdma@lfdr.de>; Thu, 10 Apr 2025 18:46:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E463F202960;
	Thu, 10 Apr 2025 18:46:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="sBc9M3HM"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2085.outbound.protection.outlook.com [40.107.220.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11A6D1E0E15;
	Thu, 10 Apr 2025 18:46:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744310772; cv=fail; b=XBAYiPuo9tV2Z3wpFAGVNtzT+ofUn2mjZomwXRuYwR1z6BWcbZb9k2iAHU3zpkBZEwJx7I2q4FbhxhyEeNh1gEYvGD5miE5ZUhQiNqVDG5WjnlJYNIGfYCzJMb8Vd0EuIzNaF1F8XOERQXcYeb6uLZql4S2LmZRcLqDGFMTjnT0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744310772; c=relaxed/simple;
	bh=JZYJ0d/ZQ5E1KBDCAV3BK3r0wCgZ4AgY0YAh+6MRFGo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=jKDH3NieThN45+V67HKvV9u9hm7EgD48Gwp5bQbtoTY6njUzNi8S6u6lcZVxzzlkbe1oZ+SRJkdhRO24bOgOxX6B447lf1p8gAqIPkqLuCqzQ69IlwxbcvnEzWO+qBdH+FhL7yoC3Pa/i93jEtQrBq9BeNdszX5gXdJ5T0YO94s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=sBc9M3HM; arc=fail smtp.client-ip=40.107.220.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZZtu04RbpPDX+twug+KWw/DL11WEtynezIGE1FNM9qyIAMKnhQNSlzcWTPOWNLcPWD6J9v30/fTfUWmfx96SC6IoY1eSc7Ah8Ik8s6w5lPGAWFg7KxWBbvmVZ7jXyc1VVzuP6WKM/iw6FLNq40C2qaLNbeoeT3sbn7cC2cqOsroYUfwJGhQnnwo+mEqtICuCP/kMKg+a7XzpeSzvyM8GyyfHVCqNyq9U0VBrIHG3beYlGf2k6989CHNtLgAS0nD/3ddSschYgvn94zNa3eVQeSdKEGeOhz5whd2qzT4mnE/5nPPGlpCLoColuq3E5CAOrvcM9tgmPB+3OgH1NWvw/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f0jsu2jq3n+ss80jVM1leHOAFrjBasdKKc0VDY1lgdA=;
 b=e8TbC7eaPcSvq6CHjDWiBJA+H1cy4NKae/PqY3O3niTYwuV2eCgcd1A0/RXhsInNMt+3UBqQ2GIXG301iR2ncUVqpH7SLnvsicVLUmSuAiVfRvzZSd6HVlexq0uJ1/bUb61higzYRZf9MBEjZXnWYvoeYwf6R375L+ODpeLKknq+o0QsFCq4BJFUeuOkCZrAggOtvmZbfFZbEceu05G4B9HALMYXQl/7Ix8HEVSOB7IdR5hNc5TaWDKisGAitlMe6/wwFkWMZ/YhHp1ZR37Mw0VJpzRrLVydC647aV0ZmTgVC++tvP+HIH3K9CG2F/hGapsNFn/7a6cERykD3eklaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f0jsu2jq3n+ss80jVM1leHOAFrjBasdKKc0VDY1lgdA=;
 b=sBc9M3HM/Zrv2L4jF00dvsCHYxAQ5Ayq4Hs1JtGzENbiZQXEqJJeAijdfGMKVPPA4fRFWOPDi54jXGUVaoUS94FPp8M8FZ8KQw+65WjBoj3WGSRuyE9oO5M6Lv3TBIof04CJaOhE+dHfs0qBwIO9o8F4368G90bAjvkHOi9dMIjVMnR04YGeKRMi8riEJdt8Z9WMr36Ur10mkM8QOKVn86jD066D/T41riy+0MacYTDLSi9SszT40nmhIONzA/8MkdLOnwNAJgWPWgB954lsVx0rkwfcGa+6MkhEZGCcxMIUBZSSEmNziYX3m85IduskYlkrqyOLRjtIEEnPzPNiHA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BY5PR12MB3953.namprd12.prod.outlook.com (2603:10b6:a03:194::22)
 by SA1PR12MB6799.namprd12.prod.outlook.com (2603:10b6:806:25b::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.21; Thu, 10 Apr
 2025 18:46:07 +0000
Received: from BY5PR12MB3953.namprd12.prod.outlook.com
 ([fe80::308:2250:764d:ed8f]) by BY5PR12MB3953.namprd12.prod.outlook.com
 ([fe80::308:2250:764d:ed8f%7]) with mapi id 15.20.8632.021; Thu, 10 Apr 2025
 18:46:06 +0000
Date: Thu, 10 Apr 2025 20:45:57 +0200
From: Vlad Dogaru <vdogaru@nvidia.com>
To: Michal Kubiak <michal.kubiak@intel.com>
Cc: Tariq Toukan <tariqt@nvidia.com>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>, Gal Pressman <gal@nvidia.com>,
	Leon Romanovsky <leonro@nvidia.com>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Leon Romanovsky <leon@kernel.org>, netdev@vger.kernel.org,
	linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
	Moshe Shemesh <moshe@nvidia.com>, Mark Bloch <mbloch@nvidia.com>,
	Yevgeny Kliteynik <kliteyn@nvidia.com>
Subject: Re: [PATCH net-next 10/12] net/mlx5: HWS, Cleanup matcher action STE
 table
Message-ID: <Z_gR5YbASnM1JPGm@nvidia.com>
References: <1744120856-341328-1-git-send-email-tariqt@nvidia.com>
 <1744120856-341328-11-git-send-email-tariqt@nvidia.com>
 <Z/f5hqMDh9eGd0Xc@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z/f5hqMDh9eGd0Xc@localhost.localdomain>
X-ClientProxiedBy: FR4P281CA0223.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e4::6) To BY5PR12MB3953.namprd12.prod.outlook.com
 (2603:10b6:a03:194::22)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR12MB3953:EE_|SA1PR12MB6799:EE_
X-MS-Office365-Filtering-Correlation-Id: a795debd-e067-421a-9a96-08dd785ff383
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|10070799003|7416014|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?EVss/yWaGXdBrctz2l+8CfECY1Z4bb0WPG7XiwmwEz+6/FGvXxLmn0SsJXwS?=
 =?us-ascii?Q?04WlYj7jbKLNCARZ4u8ldOYLA/zzt19Yv+3Exk2kE0W9M0WfwyHwrbRKnJhG?=
 =?us-ascii?Q?hXTOVDX8W1T4IYkX0TLbxtxLInVCb1sOWMgUmGshHoA7uB3dmT/h2mlgZVBv?=
 =?us-ascii?Q?zzWEwan4ZXuLhLVlr0f7DN/mdr81AEVfsxugRyGZEj8TbEF2p5f7udOK5wY2?=
 =?us-ascii?Q?l19+36aRnQPkUouGPslR0ESFM2bkwbs6XtIfgoTMlFMWJenRakEn8PAitSAe?=
 =?us-ascii?Q?5YLWEZaRVhI783F9Rd8Ups42a57RhCyY9mlCneL25D455DtLjT38mbVSS/DP?=
 =?us-ascii?Q?VQff3HUmM84EHRBp7GJqAyNQFSWm1+35Hs9nBSNvYeChcTKMZLYS+odMFVIy?=
 =?us-ascii?Q?m4FjN2Qe/hFAe/I5hlijWEE7hd2QZ+rXs00Hk4iZsV1QgpC+DEeNAeOaaIL0?=
 =?us-ascii?Q?HuJk9Bk8v1oL4roJtx3+n0OKvDvzWpHYLZgyVxfvZvY2kpXFVIQ4SvqCXYM3?=
 =?us-ascii?Q?ODjldhxb/cgNb7l4ppmZYRxXGzPunzWwGQnwdWIWfWHpqePZeWW/vlCgvYXf?=
 =?us-ascii?Q?Q6VuWxlstWQDBd8XjtHOXhfY23e2xmxPbkX1z3unNB6fQq8lQOj1B6CrXbz0?=
 =?us-ascii?Q?sjs1g1ZstYU/JOjze+KWdG9wUrtvkSGgQp9CM4iDTQwaYvwzF7LuDlCoURui?=
 =?us-ascii?Q?ChaYD95Uq9xSMuc0Z+SiEMrPOyjGJoGRMovB+I6BpryvBZdUI9GZ/1M/idz4?=
 =?us-ascii?Q?9oqK5D0BFZ2F/MqZGAAvMqltbuUUbS5s+uSUUXgUZyoYrk4TaF0VvjN0t+lg?=
 =?us-ascii?Q?E2gkcUV9cxiVHv/8clkJdxp6q9IZgmYWZQLd5+s6zHgPsxrplNTohRbnQpuu?=
 =?us-ascii?Q?Jg68U5lur89U+Or0Z/0CKf/DHVEcF/+fm+F4kyG7sSfxAO3xNke8tRfHU//P?=
 =?us-ascii?Q?5N5wbZ1jRtJELOU5WCL/OtZl4ILRoqdIiAewYh62GHoJp/GtiUVvnUrXRoue?=
 =?us-ascii?Q?cleHTrfWqxH92PrAJ/jqjmqiTV+j8DeRyx7c2iDXXOvgEzJt7UPbZSpNgtB9?=
 =?us-ascii?Q?Jlgxr0vzmD+S9Xj8OqlmLKfisEKY0i5qJcN76xDX5Fs/ihUdNJppUlbScy1S?=
 =?us-ascii?Q?eeyyZsEV9FOhNl7fRDS7a8qohSzAEUKIr2KfCRvAwPuACSxrfkKXTSLGvnfc?=
 =?us-ascii?Q?UA1TLg9/VlV8ZWFx615GP8T0DiA2dYjJhecgme9ZuD9Uizzj5/p/el40e3hl?=
 =?us-ascii?Q?w9lY4Y7JGvFUfoPHmZAgFFICSdlcGcyHU8mcYj6VubBRajnDAnea582S7Ovt?=
 =?us-ascii?Q?gOz6JMD4XNZZ7cVQhAVW6PdMpN3Yd+tR1nGey6Olaz/LybbrwtvM8GhG/UOB?=
 =?us-ascii?Q?BbeKk50ewvW9HUjPbfRJ+jGO0nuE4Dd6NI4rejRchjopEJfE8g=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB3953.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(10070799003)(7416014)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?zVlmH6Rke8XyuZLGVu04FJSGhWa9tmixL7rgm/yqbQ2EVJTCsh2jH1yC4A7G?=
 =?us-ascii?Q?xkTNAJy80QDuxLviqmUuO6zDNBF20G7Lm20kuxAehvfPEQO/XgXYTcjsOaku?=
 =?us-ascii?Q?SGCH1a7/XauSupe/0x97S774rNYKMBR/CFKvg6/4ZOK6kIcoutMwaoB10ECA?=
 =?us-ascii?Q?/lUjU9FGkqQGnrKjBluONFUqqQKUHCDKg6AaxM2OEry4QxnSSk2NVjQGV7Vm?=
 =?us-ascii?Q?wUSnnLojI5Ig+fb9VF1kNeDXYDxT15xIyB1sCMtbMeYAtS8tWIJY/0iQigbw?=
 =?us-ascii?Q?4JzHcADrC2/zifTgfK7OW8X453NSzGe+5qqgjA57U8MDT7pvsOzWAbNw2YHR?=
 =?us-ascii?Q?zzbq30WshFyGzSKxUtv6oRftDBWQqXnBcffF9gjVy0KeRZC6a1vMW/RYSyDY?=
 =?us-ascii?Q?lLW/7tLdHC2vI8V99pDTNeU2/uAfjEbzb9XLHpI5Gs325LMUsEwK3Ey8a3z6?=
 =?us-ascii?Q?uDSG+tC6ja4iJowe/oXga/yzOSKU2DmwAcRl1NaK7X5Wr3ofl5ot5pAPbcUY?=
 =?us-ascii?Q?FEp3mVXu225rPVxLeMlrnzaVzNTsQ6s1r6E99PtIoYH6b3U5UI3D86tvYNE+?=
 =?us-ascii?Q?F/SFEOMdzVn7/nkbNC+Quw3EVdYaM3yX/jnIwu4EFnZNz+VEPzXAfuCtGS+m?=
 =?us-ascii?Q?TSh8tffYymI16L6nn0MISBYR0rLHKqK0kkypmcMStmRuJ57zxLjZAg9fiKjO?=
 =?us-ascii?Q?L/uouDEkqO4FTmf16uAyR0WRm0VRlDd/GEicj8hGQSoSjZKeWqqun7MzGcZW?=
 =?us-ascii?Q?yQ36/6VAU6j9DRBrzgLKYGbqcFDgoNdst22Sa0f+n1QBm3gV2dG7ZJfTaw3Q?=
 =?us-ascii?Q?hLOcg1kmrMuXfJQhlJjNHLC7RmseUeONRrM5wZlQE09a4nEDu+XU6VhObBAC?=
 =?us-ascii?Q?4qTDJ8kHa0527alDsYasBHjqlo9LNF9cmLQzifuXEVN5mdJ3dKieGcF4q80b?=
 =?us-ascii?Q?QDEO09jcucIgZzPQwliA+68bMXdr5bKUzoUF3a/z6ZMBpG4OVgFUiGI/9Krg?=
 =?us-ascii?Q?RKP403Z1A9Wz4nWfYtLW5h21W33RVRMugE9P1WGSiqqLevVvttcC57Pbjq5U?=
 =?us-ascii?Q?l8r/1G1etpFvm6S6lsaDLnEhDBWtDTByvacKmo+OQuPQJk3gAorJrgiJGGo/?=
 =?us-ascii?Q?mIk3EsYjf7BArlGqnnEC9mkyDFvjDc4h/gtnSAi9AWld/av16Je8r5xriUXo?=
 =?us-ascii?Q?+qbr2aCCvVi1wQG+j1r8N2C5heX9yqN2giX2ESn5bHJKSJQPirhz/dcR0jcw?=
 =?us-ascii?Q?u5kc/7uUgyjdxXuxrDfz+b/Fz4SwqwPI9kf1ijXbywAVOOwKBVqRkshOUfg8?=
 =?us-ascii?Q?7F5vXqt/RSJjB+g0miQOykpvMJhXhWepMEeu+vq9G6e3aUtLL9ESxE7bgTEd?=
 =?us-ascii?Q?kroU/E0wKc30cl2a9ZF3K5Ram6OPiYZAPiMDLFWpwHYDce3GM9rfO9WrBkUf?=
 =?us-ascii?Q?7KU03itD7e3PiCVl3Xg4F+wXXKCN34t1+Afkpqevo4zDl2sabveOJIXw8tZN?=
 =?us-ascii?Q?CFcZTDlxgsIHzf0SY2NFueMbQoVRv0u6FqTCnMgaAy1W59TvyyjcdJMYO5BM?=
 =?us-ascii?Q?zuzNnOf0S62333k2If3+lJJXDGwq7FjcXfz1WI47zQeTPVHPDQDuxLPGLEZr?=
 =?us-ascii?Q?uHyBtVBSqyum1kWbiD76FUrYXTsCXrOu7Kewez5/HGXn?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a795debd-e067-421a-9a96-08dd785ff383
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB3953.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2025 18:46:06.2014
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RM3+BR77Lg+GfjmXlDzIbybU6LH2IEK3f2rkbUdPxWKJlhks1CpJ0ZxPwug/gzCMxGoobO1hVQzNK6rLP4Wvuw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6799

On Thu, Apr 10, 2025 at 07:01:58PM +0200, Michal Kubiak wrote:
> On Tue, Apr 08, 2025 at 05:00:54PM +0300, Tariq Toukan wrote:
> > From: Vlad Dogaru <vdogaru@nvidia.com>
> > 
> > Remove the matcher action STE implementation now that the code uses
> > per-queue action STE pools. This also allows simplifying matcher code
> > because it is now only handling a single type of RTC/STE.
> > 
> > The matcher resize data is also going away. Matchers were saving old
> > action STE data because the rules still used it, but now that data lives
> > in the action STE pool and is no longer coupled to a matcher.
> > 
> > Furthermore, matchers no longer need to rehash a due to action template
> > addition.  If a new action template needs more action STEs, we simply
> > update the matcher's num_of_action_stes and future rules will allocate
> > the correct number. Existing rules are unaffected by such an operation
> > and can continue to use their existing action STEs.
> > 
> > The range action was using the matcher action STE implementation, but
> > there was no reason to do this other than the container fitting the
> > purpose. Extract that information to a separate structure.
> > 
> > Finally, stop dumping per-matcher information about action RTCs,
> > because they no longer exist. A later patch in this series will add
> > support for dumping action STE pools.
> > 
> > Signed-off-by: Vlad Dogaru <vdogaru@nvidia.com>
> > Reviewed-by: Yevgeny Kliteynik <kliteyn@nvidia.com>
> > Reviewed-by: Mark Bloch <mbloch@nvidia.com>
> > Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
> > ---
> >  .../mellanox/mlx5/core/steering/hws/action.c  |  23 +-
> >  .../mellanox/mlx5/core/steering/hws/action.h  |   8 +-
> >  .../mellanox/mlx5/core/steering/hws/bwc.c     |  77 +---
> >  .../mellanox/mlx5/core/steering/hws/debug.c   |  17 +-
> >  .../mellanox/mlx5/core/steering/hws/matcher.c | 336 ++++--------------
> >  .../mellanox/mlx5/core/steering/hws/matcher.h |  20 +-
> >  .../mellanox/mlx5/core/steering/hws/mlx5hws.h |   5 +-
> >  .../mellanox/mlx5/core/steering/hws/rule.c    |   2 +-
> >  8 files changed, 87 insertions(+), 401 deletions(-)
> > 
> 
> 
> [...]
> 
> > @@ -803,7 +778,6 @@ int mlx5hws_bwc_rule_create_simple(struct mlx5hws_bwc_rule *bwc_rule,
> >  	struct mlx5hws_rule_attr rule_attr;
> >  	struct mutex *queue_lock; /* Protect the queue */
> >  	u32 num_of_rules;
> > -	bool need_rehash;
> 
> This flag (and the function parameter below) were added in the Patch #1 as part
> of the fix for unnecessary rehashing. Now it is removed again.
> Is this fix really necessary for this series to somehow make it consistent?
> Maybe Patch #1 should go separately as an independent fix in the "net"
> tree? What do you think?

Although patch 1 is indeed a bugfix, we've never seen it triggered in
our regressions. Since all of the code is relatively new and it's
unlikely we will see this in the wild, let's keep the series as is, I
hope that's ok.

Cheers,
Vlad

