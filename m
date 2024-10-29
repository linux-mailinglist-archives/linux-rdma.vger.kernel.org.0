Return-Path: <linux-rdma+bounces-5592-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DF7559B417B
	for <lists+linux-rdma@lfdr.de>; Tue, 29 Oct 2024 05:08:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1515C1C21A63
	for <lists+linux-rdma@lfdr.de>; Tue, 29 Oct 2024 04:08:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 214701FF7B7;
	Tue, 29 Oct 2024 04:08:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="HR+QmzSl"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2080.outbound.protection.outlook.com [40.107.92.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F346FC0B;
	Tue, 29 Oct 2024 04:08:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730174907; cv=fail; b=osrLUlbiD6QM5Alcl8I7Cb+vU5xC5iTgevyqAE4p8//xyWhlk1PPhM3+cBcDyxAsQ5++kgwywUMulUtUKweaoseKw04CW7qJfB6L6+1B6vkOLUGtLH9h09l71xFnOiGbauflBtkU3NafjLCDO3AM3A80s8YhMycbAxbnqmSr7wI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730174907; c=relaxed/simple;
	bh=mLmz+FrOFH01RrLjeCubTmUAVO0rYTscsnMCmaB09IY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=oz+3tgLLJDLgHb4ucfYtp/RSdwIO5OI93D338KqGtxl4nFsPpfkLixW88jT43PnPtUeAwLXAR28MLFK4K+mOw4261Aq15CjUz0aJ8WPmDANIri8Y6LGHAeRNtZaCJ5wLgudYIPCzrDfxxXLzuq+88Y3ZFH9IwHy2ZxnnAkjFc0c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=HR+QmzSl; arc=fail smtp.client-ip=40.107.92.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=i/wdAVvdDP+mDX0AkEHEPNX3/yrnXaoKfKdH1phB3JZUFBq4kvS02v09bHiSTjLe+Xs2IojgS50OOgv+RabqtiMh7ji4TOBTSPGEfIrLjSYP4hh0eD2SW93X4QIDWXYkKuAgHpG68Bwitgv14GlKCeLXRgzfIY1HJbSDoKBkMWK0MpqYLXrgiMZKKd+3Kjk9kAJd83VkcxSQuGdYkIeNB2B2BlNiIGAOPKcLy97yyw8CeuJf+GplQx4KEYt3tu0lKh6lJejTCM6TJcAMFjwM60tCX63oCoQbyQyP4I4OZDHHUGsbwdB1snjo6sX3vWl9rr1zKwxwTM7Lfq1UDGmtyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C95OvaMRZEM2GhApS1tBpudHJno8D+FEgn3/Og7Yik0=;
 b=tOGbAMmXaR/LXGFBbKxdeYk5woBTlc24jPrfHfzpcFswnc8cBxVMyo/2eyPeBWW2HDPSrbykk1CO8YDEk65DVSN7oPTvM93CN0Z5DD8h7BO2hUC1aOOuQQGSP9IOdCYCS4QrqInt1rbLq67PLzx8lBO8feMqzJAeqrQR9JphYjO6c6N8R8YCYREG2lgyw6mpxRCMzGjyk8Nu5W0DuX7YfUfZ3Vj+g1OeTxiu0ohuo9EtRlCfXCgoiqfCJfDbSkXXAZBMyWOaSq9ZAzzDj5xpABN2v8pJr9ViTS3GKDdK9vVAZN08gyDha42i2nDlYWuL7vzNBTGovkt2peJTc3dX4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C95OvaMRZEM2GhApS1tBpudHJno8D+FEgn3/Og7Yik0=;
 b=HR+QmzSljVsM1/s+U3n6tHp1eYKClb95PXSsEqv0Wotr1yfpr10vdOqyId5RFK5peKk8hzdatDUhHcXSef3JPo7rN8m8GCVl1FWEIAEUFxjkQqXIaIT5ClHkDWQ3WlPT6mi+XC1UGLldvGNZguOyeKMjAbu78lEbWMJa8eiIG7ouiag0C3Cb+ieF0eLaUXHvsOCcFpEm+TTFOWCN3R/WmnihTuN8QAcGIhebdti48JAT8Hg4/oS7m9EWRVA0JRjG2SFnVl1LLnZgkl+GoaxqWm+NZyzE6ilhw+ovyUjjJusMxKRJO+hRVkVDzkmNICxVpLd5vnNfKgM9V8BGq11eHQ==
Received: from CY8PR12MB7195.namprd12.prod.outlook.com (2603:10b6:930:59::11)
 by DS0PR12MB8041.namprd12.prod.outlook.com (2603:10b6:8:147::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.27; Tue, 29 Oct
 2024 04:08:21 +0000
Received: from CY8PR12MB7195.namprd12.prod.outlook.com
 ([fe80::c06c:905a:63f8:9cd]) by CY8PR12MB7195.namprd12.prod.outlook.com
 ([fe80::c06c:905a:63f8:9cd%6]) with mapi id 15.20.8093.018; Tue, 29 Oct 2024
 04:08:21 +0000
From: Parav Pandit <parav@nvidia.com>
To: Caleb Sander Mateos <csander@purestorage.com>, Saeed Mahameed
	<saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>, Tariq Toukan
	<tariqt@nvidia.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] mlx5: only schedule EQ comp tasklet if necessary
Thread-Topic: [PATCH] mlx5: only schedule EQ comp tasklet if necessary
Thread-Index: AQHbKCW9Q9qkXU01m0m9h9+OsmzYbbKdGPPw
Date: Tue, 29 Oct 2024 04:08:21 +0000
Message-ID:
 <CY8PR12MB7195E405C3EC9F43619231CCDC4B2@CY8PR12MB7195.namprd12.prod.outlook.com>
References: <20241027040700.1616307-1-csander@purestorage.com>
In-Reply-To: <20241027040700.1616307-1-csander@purestorage.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR12MB7195:EE_|DS0PR12MB8041:EE_
x-ms-office365-filtering-correlation-id: 8d477cf5-4f52-4309-79ed-08dcf7cf538d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?SSpLuYF+S1J8matzOiPP7bpjHF1ew6HYtk0RtdnESjYEXKRWmTLV87JkfiE5?=
 =?us-ascii?Q?kI8CV0vUNhZw5YDuZJVmScxw5vx/iW3JVojtoyG/CWCaESwbzXKvuidQd4IN?=
 =?us-ascii?Q?5NaG+N8HRZjrWs3gciejU2ckZXQYhQ5wgzEfOLIp7AVbjNrBiGAe6tkaiMIS?=
 =?us-ascii?Q?8XUftYrIoJydQoftp01Bardp1NnC20+jBVFFUo8JJaz5CVEahQSW5KcxhlTh?=
 =?us-ascii?Q?r5lR39lcdPkT9H+sKyOwE/TTf2jsESJ4AhBhFtUO0jfi7oFpwR4oo+7tyr5D?=
 =?us-ascii?Q?R2P1OC+IhCsI5DN08pbRIUlLCQ1Wu+lexterAbWseIhcjBw4Fdlv9BmNUXDQ?=
 =?us-ascii?Q?hMxHeRieJbYBiodvRTEzOTmWqfg5ymQ0fENMai1fzWrThcO24Jc4wNklZ0ri?=
 =?us-ascii?Q?DIYaqsyBP3zCQgtqn0ETZnWzAyquexQJx22Q7EoNGM/fvAMhsEGPPnv3Sd+h?=
 =?us-ascii?Q?uhSMZI3DXMfppjXn2ZjNaGdo6v0UylDzhwGhcCqDiq3JJzX1tyLP2fdYhs6H?=
 =?us-ascii?Q?ya50Rbsj66sQBAzI6oTlHZshh1oW8JAEIPzV08Yd7ON1I6FKmmLvpZveT5zv?=
 =?us-ascii?Q?s8h2yJA4GySD+c+87epihzX0sKy5C/eRPVQzhDx1qfpLdA9V/aD5Vd/V3VYy?=
 =?us-ascii?Q?lkW4q+xbfq1cbi4uq5k2dpIS6w14AGrczYVdcaWxyhgnxBcqwNp828JXcfX3?=
 =?us-ascii?Q?MrhsrpUKAEoNNnoa34uvi6cx8E6pebD72yUvdRRSzRD7luSCcgTp145OwV2Q?=
 =?us-ascii?Q?SNePDo8g0Q22hEayt1bH1D2YCFh31bz/sUkq2CrIwgYFryhjb55l3lM+wt1A?=
 =?us-ascii?Q?jgi2BcKBsLZT+XGCx5jaXJ26LJDHUSFSjC6M95A9lXEb3K2HiFw6IRwuDHiA?=
 =?us-ascii?Q?kFCEqEqIJL1wxIsOBHRT7LMHuX8r39Stuahlls3+b+IYl6etU7++qhmi/cGO?=
 =?us-ascii?Q?PR5or6/Dgur8G33mrejFHHDbNTBSqqtmHKEdeP4hnorBR0VOtZB0n1qIi6On?=
 =?us-ascii?Q?JhtmydxH99u1axY30A2Te8cn7fZ+Bjc6kENQObxd4MHnQZAhXDuP0pMDaFNg?=
 =?us-ascii?Q?vX7OQ0J8AsvcMiJIJuBlfkLK2VWm8DfnvBfJfCW/lgT73STO2jDFdyQCaQNw?=
 =?us-ascii?Q?OLMjfn1FMmbU18cmJfe6cBufpOZWf9RJywNw/KfEGFcch6q0pu/5CyS85MiO?=
 =?us-ascii?Q?5Z4j+B4GKyMbIvuA3d2lSplcDTVoOuCkKPBN0bbdYkBKOuLZ+Q/KPuhqRFnL?=
 =?us-ascii?Q?Hdp+jMx1xfB3J94mz+Y1HuXyEhSG+0LYglKBwQKpAYcR3EIYeD6X9jnWL6wC?=
 =?us-ascii?Q?VnPdwytx2khEivG6GYy5qNsnsCqyPPvvIMpYImLyTdingPxeX92xLm6MLrLu?=
 =?us-ascii?Q?OCU7gDg5sHgNepvQqK6Icy+NNvT2?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR12MB7195.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?NKD1WhxFKnYcX+g6Xz5jutQjzSoffmWnHAcfil8VE/gSQNKDeI3mpMwAkvDc?=
 =?us-ascii?Q?gMqUL3gjOP7Yx86ZdKtwgwSxlkBatP4mEzCKCtIBMbuVtieuCTuxJmfj255l?=
 =?us-ascii?Q?c4YW+AGjNNaidDKjn9gBqtsN3bQnIeemRnftCX+1/VLxXhvQh1gj5ozl+/jV?=
 =?us-ascii?Q?avKOkA3KNaEL7GPbkgBbt/bLf0UZ53V/m+cHCyrCxxdAfOfq9gtt6ILx0hdI?=
 =?us-ascii?Q?TP0700UHuPns6OBTk6gJhDQrVnIy6W4bLp3cW+Qx4yK8z2Ybb68E3lUBKbb+?=
 =?us-ascii?Q?So8eAp2Z0Wmr/GaUrFJwZcsnYRcB4fN1t9HmkkgAvXQjHKaCJzVbZjQOGmEB?=
 =?us-ascii?Q?edepZ9XjIVCpuagF1vJUxcZEHRnA7NIvFPdBn98RmU7yyglNIZYvpTplPn0J?=
 =?us-ascii?Q?/MSCorjYpAN3lKneNEFNUpypCMxwZaaJcvbqwGStBvliwomhR7YZrkxq/XPU?=
 =?us-ascii?Q?APRY0+9oimSrnZnwJxBnUZPtoD8VlU7lC0nIZ6qKzpAmqAef3A8lKIKIEyZ+?=
 =?us-ascii?Q?7OR2Ku3JhvrXQ6RnMNJYXzqEIs/UZYNv/OM7V3gYkAQ5zsh01aeVSoSH6AoM?=
 =?us-ascii?Q?77Wp1j8dhoLUJlmc5eDdYMvZ3kC6RclOcsHDI6C8nfzenUW1/GfSDGU1JwfE?=
 =?us-ascii?Q?RtfRyzUkqlK7JIV9/9F0S09odDzrZrNjm/Q4en7QfOv3UoIG2gYLuES/B3vs?=
 =?us-ascii?Q?sei5xY7RjuFMyzDU2mVN/W32aEstv/N/+cbsaKecIVoNB6uQUIaowseUCQwk?=
 =?us-ascii?Q?T0gqdx+WHhXaZFnG+Gfij3AWB9/LdGQmJdVBIU1noWNp34Im6rhcRQxCPxVL?=
 =?us-ascii?Q?IDG02V/C8O3brXF5RyHDm90La68zARWRU53bZjPX3u8m3eFTCgvqMbRQtss4?=
 =?us-ascii?Q?JWhFWLt+AWn/9pyD1R88gwvqXMfMxF2YTLAv0S5p6+GrVd42HVWXdpx5O6Ew?=
 =?us-ascii?Q?Faa1acGTPHjwSUUqBNUq2zlI65CTMUe2/2cLbQzSrBgCrS+C5EN6QjZHI0Fk?=
 =?us-ascii?Q?b7UmJNkJuvLtoP68ML9kQ8Rf2L3lqKRN7pOEGerHC0gc/lO0zFPMX5YcJ714?=
 =?us-ascii?Q?r7sLiNqyv5AA3d62Tff2fcHTqcFvShUAk9UzyNopsbgYrMF3DEXaJnmr5pQD?=
 =?us-ascii?Q?Pt0nYP0EgWe9+WWgABqzddReui5oAWmHDmLsD13hPszEQAWLykwOqA6TsuMv?=
 =?us-ascii?Q?JGaqKxuCN1ZRJ/UvPl5LDGx91pV4CWMj66NJEektlj3L7MbZPqGxL8BQZv3N?=
 =?us-ascii?Q?p5JfRKPgbJJH4W+m7X1HiYODUQlmy/pR3Zzfp8kB1kpVSfFKdTa+9vYzTEBG?=
 =?us-ascii?Q?zQ+WOMWOKyGkROvYXHeHA20r0DqZLbaZ3R+R2rUGIELFeK0hYjvJ9SiLpdFE?=
 =?us-ascii?Q?UqFojZK4qvjW8aqk5F03PywIAquqhzTXx1PR3nXZ5pkSD4hLWD2BKs5cb5Il?=
 =?us-ascii?Q?qQsYcblzN8dft/vYCdu6gstKR++3yrK391qeIZ9jp6FlHAfDnzcqIYEyu6Pc?=
 =?us-ascii?Q?QiBtdI3vImW5VNFNBW2ZNBtekgVZiTzn2gWhtaVs2KHw5eE4HZhAHg67HIbz?=
 =?us-ascii?Q?11RIwM7IFctzGC/hmgM=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY8PR12MB7195.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d477cf5-4f52-4309-79ed-08dcf7cf538d
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Oct 2024 04:08:21.1727
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cPPufkXrTU6MnbGaoECCzqBMLVMr+RdG0sqjL9D2De9+k2y93tB3O3xXzhLMiGRBXvGBRFmXmU/EAXC6I6DyZQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8041

Hi=20

> From: Caleb Sander Mateos <csander@purestorage.com>
> Sent: Sunday, October 27, 2024 9:37 AM
>=20
> Currently, the mlx5_eq_comp_int() interrupt handler schedules a tasklet t=
o call
> mlx5_cq_tasklet_cb() if it processes any completions. For CQs whose
> completions don't need to be processed in tasklet context, this overhead =
is
> unnecessary. Atomic operations are needed to schedule, lock, and clear th=
e
> tasklet. And when mlx5_cq_tasklet_cb() runs, it acquires a spin lock to a=
ccess
> the list of CQs enqueued for processing.
>=20
> Schedule the tasklet in mlx5_add_cq_to_tasklet() instead to avoid this
> overhead. mlx5_add_cq_to_tasklet() is responsible for enqueuing the CQs t=
o
> be processed in tasklet context, so it can schedule the tasklet. CQs that=
 need
> tasklet processing have their interrupt comp handler set to
> mlx5_add_cq_to_tasklet(), so they will schedule the tasklet. CQs that don=
't
> need tasklet processing won't schedule the tasklet. To avoid scheduling t=
he
> tasklet multiple times during the same interrupt, only schedule the taskl=
et in
> mlx5_add_cq_to_tasklet() if the tasklet work queue was empty before the
> new CQ was pushed to it.
>=20
> Note that the mlx4 driver works the same way: it schedules the tasklet in
> mlx4_add_cq_to_tasklet() and only if the work queue was empty before.
>=20
> Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>
> ---
>  drivers/net/ethernet/mellanox/mlx5/core/cq.c | 5 +++++
> drivers/net/ethernet/mellanox/mlx5/core/eq.c | 5 +----
>  2 files changed, 6 insertions(+), 4 deletions(-)
>=20
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/cq.c
> b/drivers/net/ethernet/mellanox/mlx5/core/cq.c
> index 4caa1b6f40ba..25f3b26db729 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/cq.c
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/cq.c
> @@ -69,22 +69,27 @@ void mlx5_cq_tasklet_cb(struct tasklet_struct *t)
> static void mlx5_add_cq_to_tasklet(struct mlx5_core_cq *cq,
>  				   struct mlx5_eqe *eqe)
>  {
>  	unsigned long flags;
>  	struct mlx5_eq_tasklet *tasklet_ctx =3D cq->tasklet_ctx.priv;
> +	bool schedule_tasklet =3D false;
>=20
>  	spin_lock_irqsave(&tasklet_ctx->lock, flags);
>  	/* When migrating CQs between EQs will be implemented, please note
>  	 * that you need to sync this point. It is possible that
>  	 * while migrating a CQ, completions on the old EQs could
>  	 * still arrive.
>  	 */
>  	if (list_empty_careful(&cq->tasklet_ctx.list)) {
>  		mlx5_cq_hold(cq);
> +		schedule_tasklet =3D list_empty(&tasklet_ctx->list);
>  		list_add_tail(&cq->tasklet_ctx.list, &tasklet_ctx->list);
>  	}
>  	spin_unlock_irqrestore(&tasklet_ctx->lock, flags);
> +
> +	if (schedule_tasklet)
> +		tasklet_schedule(&tasklet_ctx->task);
>  }
>=20
>  /* Callers must verify outbox status in case of err */  int mlx5_create_=
cq(struct
> mlx5_core_dev *dev, struct mlx5_core_cq *cq,
>  		   u32 *in, int inlen, u32 *out, int outlen) diff --git
> a/drivers/net/ethernet/mellanox/mlx5/core/eq.c
> b/drivers/net/ethernet/mellanox/mlx5/core/eq.c
> index 68cb86b37e56..66fc17d9c949 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/eq.c
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/eq.c
> @@ -112,17 +112,17 @@ static int mlx5_eq_comp_int(struct notifier_block
> *nb,
>  	struct mlx5_eq_comp *eq_comp =3D
>  		container_of(nb, struct mlx5_eq_comp, irq_nb);
>  	struct mlx5_eq *eq =3D &eq_comp->core;
>  	struct mlx5_eqe *eqe;
>  	int num_eqes =3D 0;
> -	u32 cqn =3D -1;
>=20
>  	eqe =3D next_eqe_sw(eq);
>  	if (!eqe)
>  		goto out;
>=20
>  	do {
> +		u32 cqn;
>  		struct mlx5_core_cq *cq;
>=20
A small nit, cqn should be declared after cq to follow the netdev coding gu=
idelines of [1].

>  		/* Make sure we read EQ entry contents after we've
>  		 * checked the ownership bit.
>  		 */
> @@ -145,13 +145,10 @@ static int mlx5_eq_comp_int(struct notifier_block
> *nb,
>  	} while ((++num_eqes < MLX5_EQ_POLLING_BUDGET) && (eqe =3D
> next_eqe_sw(eq)));
>=20
>  out:
>  	eq_update_ci(eq, 1);
>=20
> -	if (cqn !=3D -1)
> -		tasklet_schedule(&eq_comp->tasklet_ctx.task);
> -
Current code processes many EQEs and performs the check for tasklet_schedul=
e only once in the cqn check.
While this change, on every EQE, the additional check will be done.
This will marginally make the interrupt handler slow.
Returning a bool from comp() wont be good either, and we cannot inline thin=
gs here due to function pointer.

The cost of scheduling null tasklet is higher than this if (schedule_taskle=
t) check.
In other series internally, I am working to reduce the cost of comp() itsel=
f unrelated to this change.
so it ok to have the additional check introduced here.

Apart from that,

Reviewed-by: Parav Pandit <parav@nvidia.com>

[1] https://elixir.bootlin.com/linux/v6.11.5/source/Documentation/process/m=
aintainer-netdev.rst#L358

>  	return 0;
>  }
>=20
>  /* Some architectures don't latch interrupts when they are disabled, so =
using
>   * mlx5_eq_poll_irq_disabled could end up losing interrupts while trying=
 to
> --
> 2.45.2
>=20


