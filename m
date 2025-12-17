Return-Path: <linux-rdma+bounces-15044-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CF05CC5B91
	for <lists+linux-rdma@lfdr.de>; Wed, 17 Dec 2025 02:46:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 839E3301CD06
	for <lists+linux-rdma@lfdr.de>; Wed, 17 Dec 2025 01:46:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEF6F22A80D;
	Wed, 17 Dec 2025 01:46:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="cDQxxyNW"
X-Original-To: linux-rdma@vger.kernel.org
Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013002.outbound.protection.outlook.com [40.93.196.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E29D222A4F1;
	Wed, 17 Dec 2025 01:46:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.2
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765936001; cv=fail; b=ZON+qd7ojaFiCHlJpNRvSh+TZ/Ypq8s7ozGn1k/45L1e1rl62OtsXDYyKwtIed9aSOUkr9sziQey1bmLlNPL7sd8QLqoSSvN6Ga5VU6kA0McREL/ETnAXK3meHFsdPTcN7CGBzGhiuyhavE0IRY17LR3HnptRUfXRUvvONhVV3I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765936001; c=relaxed/simple;
	bh=i4T/yoBpRKYvdFiP38UMbZ+Yg3sfERtCxymf5rBd07g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=GFdqmk7wKBEsVq3gSTlmoRAfZV+HPg1ds9R+PSMEImELoejTGqWx6BC4Lmxdb52t1Ukqxvd2wGoWuR+i9eTb4MisJXARjz+OnFIpheIo0VWn73ZGGc4MCt0gEYXxOOAAK4NvwHXg3j43n6+ePmAtCo62sNzWEqPs88EFBFbLK/o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=cDQxxyNW; arc=fail smtp.client-ip=40.93.196.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Q5Md1/idwWxS9/hcNtMCk2nTLLKaChWWlyRkk9B9o5xF7Q5FXYk3h7yKjs73qkemh90KayoyUjGslOW2Yb30gw59xhVGbpXFOIgRHDMUoQJZpWV2XJ+6PHWSOP02pc9npOGce2etmD/yJLpj9dXfJn/dmYyNFeExail1q4x4W1FhSyCgnUUxoiTN+ycmVSuVpnq9sOQmTNZxO64u9/j0tq3efbuF0CF21FJUwkLvD82T1IcG5oWTUvGVD1CJ11zvBoMW7tPXtW+uBN6b6mXvWdBGRCVUWSfk67EdvKX3BSkN6tIuZzHG7HpUPA46Nn1ejY5NCKuzT9ga+pYXhWsU/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hxJuRf1wK1+n96DIoXUZyXKru14xCGw5WIx6o7DLK8g=;
 b=aq/WUbnwdyErrdjTrxbxWGik54FXN7DOXzmmg6KlIsGFIk4PWD3fn9cP2bu200ftGZvh+g+nRNi/khiLT0LO66PeWKqtNi0+7/38dJCtKxfRLcpKAhW+L4JqEwQPqbKoipNWxegvmVFUczxp8Q6ZcqivNk9jE4qLWfuICEQSOCHUIB6y2a048gWRKa+oWNs1DJ9UK7mhlxmniwCP0KXxqKAlyfC0Y6RJI5hsNieYeBJxh1H8ILnpxKuMKO6hbAkhulMs6fxgKbHIpL6yJuzj3PhjWdosTO+eAn9TAj60TsJ03G5RduE0A31qXPAiW1i7V0gQUAwOHiwV6AsUZNX84A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hxJuRf1wK1+n96DIoXUZyXKru14xCGw5WIx6o7DLK8g=;
 b=cDQxxyNWz0GH4xf+UjqPxnLnruk7pdLYgvc9Y8r2sVx1Q+HnsDMBA+lt8PbgkULfp78xLzQ/d8cPOU3mtsi+baAPax2N8xlPyMgydJfucGRUlXT7KFJB13SiFKRzgvjRRceK21AylK1oXrVWAFv5iyjOb3PHDBx/70hpT0hO58jSKsCRr3es8qwnYKAkQxpn3Bn7C6VUX4SCuyqpkVWEaF7sRsMfhRszCcVdvpAeYt9jg175eFzbm/fMN7ETHVzSWtI5aPC/+M7y1lPGzErh45hQujJbrIKKg6fRNFd5QEiWZRuWrF5nSclrrvAWkTYFMJWmp1g0rKXPWDt0IthPEg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by IA1PR12MB7710.namprd12.prod.outlook.com (2603:10b6:208:422::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.13; Wed, 17 Dec
 2025 01:46:36 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c%3]) with mapi id 15.20.9434.001; Wed, 17 Dec 2025
 01:46:36 +0000
Date: Tue, 16 Dec 2025 21:46:35 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Arnd Bergmann <arnd@kernel.org>
Cc: Krzysztof Czurylo <krzysztof.czurylo@intel.com>,
	Tatyana Nikolova <tatyana.e.nikolova@intel.com>,
	Leon Romanovsky <leon@kernel.org>,
	Faisal Latif <faisal.latif@intel.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Mustafa Ismail <mustafa.ismail@intel.com>,
	linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] RDMA/irdma: fix irdma_alloc_ucontext_resp padding
Message-ID: <20251217014635.GD148079@nvidia.com>
References: <20251208133849.315451-1-arnd@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251208133849.315451-1-arnd@kernel.org>
X-ClientProxiedBy: BL0PR05CA0018.namprd05.prod.outlook.com
 (2603:10b6:208:91::28) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|IA1PR12MB7710:EE_
X-MS-Office365-Filtering-Correlation-Id: 37bb874f-4b8a-43d8-a12d-08de3d0e1cf8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?m6ebNGC/zoE7ZP9v/PpizP4Azxgealha7LGoO7vLHAMxDh/tRmk2tCNGWTPL?=
 =?us-ascii?Q?DXnQZE4S/0TalJixRDoSBG3sY+SIDbnusFIW2PtQUnW4vDPgyKJ1TBWj5Nvx?=
 =?us-ascii?Q?xEhsLJwiJpxVOQH8n/6fe1yNy1g4b0i8D2tPmILymoHZFy+HeC8oivIr3cK4?=
 =?us-ascii?Q?Gdk8rJDmd3Z6cvF4XmAS8bTHrj6EmGF7vSgSQTZ3aj8zfe2VpV80e1EhmQTK?=
 =?us-ascii?Q?kujN2yD38JNW4KSWp6zdMAAOQEbV2eXR5tIHp0du08RMFOo0umVlaz5moY0G?=
 =?us-ascii?Q?ggLSjT3TokkRy1uHq0oJ6CTO4cb3hed7qd8lc7v4xAJ7U95MEVe/PxO3vQh2?=
 =?us-ascii?Q?FzmsMzpQnr+miD048XJVLhf/qk5y+11sPXjPHpBXanlx30uhTeNqESJk6wnX?=
 =?us-ascii?Q?QAkp6P3Lb39hSUBTwHcqIT8Dyk4iEBsKYTtHTnfcNm9AFRLZrc90T9+7NcGb?=
 =?us-ascii?Q?au8U3gi6WCKwodshZRBLlQlnptEi8rAXdvfJQwUypjjGR7ji0V9sfh1AJUyZ?=
 =?us-ascii?Q?RVkIL8BSTiEk/xoD1L1deNoZv+xHQpSztfMHvkIgP4+xcBEoICBiVNii4SKY?=
 =?us-ascii?Q?jRlLz/VGeb7mDxmUGdsGe52dCRS7+mWYcHUybXUENJKW1FALYRkE9X08PM9Z?=
 =?us-ascii?Q?kthTz1aARdCn2xir1xxhJXkpLW9L1kbAKR7kymAXv5Vi+HRCqberaZowK/2J?=
 =?us-ascii?Q?CBlL29KhsMCGsWzfLp1KA+MawLzVIA1bgewV5sx1cSiCdTrwoKt922OcIYgk?=
 =?us-ascii?Q?LqZET4MMkv6Dd+R40eLXEtT5X7kxusvrbybMHSGzvA1GUPiOh4rHAwtkV1LG?=
 =?us-ascii?Q?961FdCZp31wae1iu6L5yH2lj3NbJR57fBazoWB3h7H/0PIvK6QRwqJYTs8VL?=
 =?us-ascii?Q?fHvoes4TMXgyCdN9kjOYKonEz7hFJz0r3b482DJ7iqVZhg6YExeOo69aTUSw?=
 =?us-ascii?Q?6t33za3LwZXHbI6KL3dtaukz6W4DDhNQ4Y4tW6OA4RGr8JqjGMo0NyxQHBrC?=
 =?us-ascii?Q?Rl4Qi6r25dobcu1yZb1B/stvE56y3bsx58jWAj9V7p7ILpoYdhTKGbVERdcM?=
 =?us-ascii?Q?u1VNaXSEa/12E5+8xmRAFnvE5cL5wI5fnklSwz2QMqXuCpMeQ0WgKam5ge5c?=
 =?us-ascii?Q?Nxa51KnSJxnebHPLbAu7eKLbEdQA+PIYJi4fllhWywCIyM44CbGEid94nxuc?=
 =?us-ascii?Q?2SwwDgjLshDHKy/JCTcMC9EddfkvXU5BRoNAV/p527/Szwee87dqoqjsc9ee?=
 =?us-ascii?Q?6oBHdNfd76WHa/VqvCDhbtpX5P+HkkCqsK5M3wtgzmBcGMcceQ7Uj7oUdJq3?=
 =?us-ascii?Q?ECn8/FQv4arYXNOgvb6aI8G03y83bnK1nKvc7drZN6uXt8idsZyAEhVICY5E?=
 =?us-ascii?Q?riT/2G/dUK5us9qaGXdbA/7z7UTV0VQhtbb0hq5bM49BREEMUPzwuf1KWMFe?=
 =?us-ascii?Q?Ms4SGvjYi0r8Xm72MEAvkig19v+SRMj4?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?OoFv3Ipm+oR9uWQUHdHfWKcU/xjQalFGI6lXvOC5tuYwT9xRIhIrOZHCLhQl?=
 =?us-ascii?Q?t+MAntbcUQdgaMQIAmam7TocRl4DL9v+w8ZPDT5i4yKx5r+CTFhpJpw1RZk6?=
 =?us-ascii?Q?INzEdSYS1bqMMpBXS5/kblquTHuwRhFkrTrhjzN3AKPeuIX2SU25dFbI42CY?=
 =?us-ascii?Q?//7sjnsyf9jn/vWvh3oAbYZqpoODadVDci2l2hod0krcTpc2pLSBcZ8MDm+2?=
 =?us-ascii?Q?d15D3bL2JO/moZxL1HHzoAO8+Y87DR3kXtRmHLSqHDvg6F9hQ+BJO+PmY8p+?=
 =?us-ascii?Q?VHrmQhWARyz+AgfuYi96f2X/LQX1G7Uq6XbJ7UKfyZ/gC4+TjzuUIpWBe2EE?=
 =?us-ascii?Q?u8WRf/GUo8JcFSv0g/PS5PC5AkdBmIcHgefu9ZIwnxEQ7t1l2OCoZAZoVM0c?=
 =?us-ascii?Q?NSnwhez3z5uCCHOmCJbZQnLfoE1vkLqkKluAj01aoK5QHWNB2wo64uSe+OsW?=
 =?us-ascii?Q?oxdwZFdynA1418rx+5pf5vJ+UCiB9Bm8j3eDD2NE0A0OFmWFvQBK57Uz3S8C?=
 =?us-ascii?Q?Z4nIswl6nwVM2hKKn5RNEt6XSpf6ipDks8Wv+BwSaqSL/q/VzDNkAMd4D/KY?=
 =?us-ascii?Q?xYXs2Ykvqy4bKdDO1U8Cx4Rbp/c13uRIuuGG2sij+J07y7qlLiQBb5dO/9Z5?=
 =?us-ascii?Q?ZAGoCy1ue/z33gProdn3/6S0ag/8pNi3okT4low7lIekhgmm5S0H3bc2Vagt?=
 =?us-ascii?Q?qFs/+CUfrW6j50XAxKt2aokM5QaR+ScwU1NdLsGjFuEsDnfulsAkowYzm4wy?=
 =?us-ascii?Q?Vv8HgW/g+d/nRuBT/bepNQjoD+R+T06zzTe8R4jGKJXK4gzEBiH4hRSluk5Y?=
 =?us-ascii?Q?oXqb0PJNPQbLhCYcN2ZO38s/BlI0Dc81MEOMGylSq7X27I0d6nR36aGwPIgY?=
 =?us-ascii?Q?eZF+EpI/7gZJaUh8aQAfAPs0jK4AvPYeMPWPQPLqTKHpZCMRsUHw4FBfVx+O?=
 =?us-ascii?Q?Qoivn4N//FZrNdTLO+xLCaj0k5ldKNzgtPKZrwbOP8UnemTpE3/xURd4Ko/z?=
 =?us-ascii?Q?XTKnrkJzYa10U2DBdkmBaZEFnM+ncpxm/K+atLZTBq2zgKRmgjo4CXGlwXgj?=
 =?us-ascii?Q?MyVREpVkw+tfChA0Dtddumlxc9h8pUVbliMl2KW52y2WxqccWpb7CB8kSVgP?=
 =?us-ascii?Q?DCFeVM+wW0C6vm4ELbO+n+JhqIj6/U+/uK4c3XaNjGG+w9ROJLkiG+wNh+M0?=
 =?us-ascii?Q?OzJQjmVpkszURAZ5sxG4vaoW6eNxL+LoKkz4W25komhFLr1k75jwk3uycyL3?=
 =?us-ascii?Q?irxpVk2vXI370H2jEvk3RFToJ3BVB2dGZysQUf0RlFnozsNv5wF4Lo2N1iHa?=
 =?us-ascii?Q?nXQj923zhv7OKLrUsZD/Jhxz8tYwB4FyFmk30f3oz0lnLKsPF9tCZ2JPTk1E?=
 =?us-ascii?Q?CUhjNz/7DzW/PDvPDxMfUjXrxCXLWucOqHotn8i9BhOdzMJ9q976m4n88giT?=
 =?us-ascii?Q?FaKF4MpCHumr5ELEGEAL8Bs9RUbKlyzZOS1z3QW1eLJbw5VYHlEIEqMBOGl9?=
 =?us-ascii?Q?S5GXOwHnxKAthOtX2qzFdY+hbZk4nIlxgZhsEdtsFa3mWq6/HrDqbzWHKbgu?=
 =?us-ascii?Q?IulZhQ7XT730iHgqvbc=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 37bb874f-4b8a-43d8-a12d-08de3d0e1cf8
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Dec 2025 01:46:36.0119
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ol7HQbzgwAKuSYE1DR2odtmu3ljyONUTc+5O/5/YkPMUf8hkGyQwAPiGWWBXwSi2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7710

On Mon, Dec 08, 2025 at 02:38:44PM +0100, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> A recent modified struct irdma_alloc_ucontext_resp by adding a member
> with implicit padding in front of it, changing the ABI in an
> incompatibible way on all architectures other than m68k, as
> reported by scripts/check-uapi.sh:

The growth of the structure should be tolerated, that is how the ABI
is expected to work, though this is wrong and should be fixed while we
still can.

Applied to for-rc

Thanks,
Jason

