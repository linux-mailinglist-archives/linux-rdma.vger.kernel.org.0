Return-Path: <linux-rdma+bounces-13873-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A83FBDEA0F
	for <lists+linux-rdma@lfdr.de>; Wed, 15 Oct 2025 15:05:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 43E7A48254C
	for <lists+linux-rdma@lfdr.de>; Wed, 15 Oct 2025 13:03:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DE80306B2D;
	Wed, 15 Oct 2025 13:03:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="s3Gnj/QV"
X-Original-To: linux-rdma@vger.kernel.org
Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azolkn19012056.outbound.protection.outlook.com [52.103.10.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4D132D29CF;
	Wed, 15 Oct 2025 13:03:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.10.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760533397; cv=fail; b=CnqnAO2beZzFTKIMfHjTh0MfI4A1EKAPchhB5DEnbb5bwrMmAdGJW2fbCZAcgPNy6kMxHnwvRHAeretHS2PusI2MQHcZ+w4UwFrtVPmBhC6XaOOVtf0CvTrISmDlPm0b7queGt4xLzm1iP9Mg7foxm0qAkE/jMo46WGWJqmE+Tw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760533397; c=relaxed/simple;
	bh=EuK8ogko3eCBys80P0ld2FmCLRYf1uHmcKG7jIGiNHk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=TH89vxw8Ne/6ymkcuWAflcF0PkY+1IgWpoug9ieMJNNScqTtyGcza1KKje3s1Y2cDY5Zag7pPzV7Tz2VaC3X1hcXAx3inWzfjcCHOe8qpNGBvJSwrUAx7XWzTkJqDEH+fR8vipzOCrws134PaOwz54TE/D1Gg1fnygDlyD/3uvU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=s3Gnj/QV; arc=fail smtp.client-ip=52.103.10.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gRBe2rHZkFzPf7z8xdU45DwqDJz9QriGn5vYMLy3U+K3Sj10U7eQbvxt6/nqreIRE+UhC46D1IQhJZwRcXUc6qMAbK2DID/jlq8bXmXYqLzUBHFVpo/qZrzYDC/qHd63URIlj+Vih8CV3bRZA3x+Ht6w+rlHAJjLQeXruefkXlID+fhtoiMwl3uhCTWhzyoNUo9DKkGeccB2mUVpyWYyoAxL0NJQQ/nt1LoRYL5WWnnJFy0eYlxSh7B2e5QU3HfL/Oq9Vs8Edpw2jRfUKhqFn8wc4E3mMwYRnGPnG7C4W4AYhRknk0+a2gHLoy84wvynORs24LsKzMK2nmroSexRtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZdTrjxeHDbe1Ity87pjvwvDfTBthO2TOIT9r394d2aY=;
 b=pzq9BHosizuu68emIqktpZqAlg583fceymdVMk+Hna+QhgxBevxtbrbAYLBTqGmSM11+vvcTxfnirFaUyLXQtH/BVWtf8hP7eF2lL7wiZyh9MndFHgMi/UdN14npt17ezVmyfKcZTLUCw2jA1bOyI6yMGJIC5zXmICN6ZDg1jthyJIcRkcHirPFE5d+acVE1ghiL1+iI+ieD/OnwjH8vy4HMuoOLHlchDq0w7f6iUFMyZq7+rIJwoMULBChoUM9XAKKyC1uQag5eep9TpUbV+yC/r43OvQIDXDx2JZn0/tQbmzwtJr5aO/2AJSXl0IDzS03SqI0sWLo1EefDQy4KTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZdTrjxeHDbe1Ity87pjvwvDfTBthO2TOIT9r394d2aY=;
 b=s3Gnj/QVaY6yIg3XvWcSHYMYiE4yCKq9Jksn0MdeCv9a3wgKFhT3FHSqLfsy6emWB1ENKRk1RDyFqRob8Jbel4nRxQcvJPtFpj/bP2ztoGdZzgfPCCU+3EnI6HZmHslQcwyTPEujwYbr/ZldJjJ+ncHJVeOzWjPhGm+kd9EARG2It8vaWctmrQyn2DtQjy3Zk+5ptaVp/9R3McirnVg/4QLF+0aFwazz3BRMt+FmciSycLQl1zvqd+6jmLCHxkx/aJmPbPS6FgSMbT0l+RmASQCLw38GDvPpdQ6abUXypJyOg/1c9MI3LfvO4K67FF9aj+syc13EjmwSHSIF7k2dgg==
Received: from MN6PR16MB5450.namprd16.prod.outlook.com (2603:10b6:208:476::18)
 by CH1PPF12F7FA700.namprd16.prod.outlook.com (2603:10b6:61f:fc00::a08) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.10; Wed, 15 Oct
 2025 13:03:11 +0000
Received: from MN6PR16MB5450.namprd16.prod.outlook.com
 ([fe80::3dfc:2c47:c615:2d68]) by MN6PR16MB5450.namprd16.prod.outlook.com
 ([fe80::3dfc:2c47:c615:2d68%4]) with mapi id 15.20.9203.009; Wed, 15 Oct 2025
 13:03:11 +0000
From: Mingrui Cui <mingruic@outlook.com>
To: dtatulea@nvidia.com
Cc: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	leon@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	mbloch@nvidia.com,
	mingruic@outlook.com,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	saeedm@nvidia.com,
	tariqt@nvidia.com
Subject: Re: [PATCH net v2] net/mlx5e: Make DEFAULT_FRAG_SIZE relative to page size
Date: Wed, 15 Oct 2025 21:02:16 +0800
Message-ID:
 <MN6PR16MB54501D6839EF07C7C33FD3EAB7E8A@MN6PR16MB5450.namprd16.prod.outlook.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cyashxbmwfkcbqscgyudij5yzkso2twpswqcf7ev2h7a64n67k@zvl3ht2pxc2b>
References: <cyashxbmwfkcbqscgyudij5yzkso2twpswqcf7ev2h7a64n67k@zvl3ht2pxc2b>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0025.apcprd01.prod.exchangelabs.com
 (2603:1096:4:192::10) To MN6PR16MB5450.namprd16.prod.outlook.com
 (2603:10b6:208:476::18)
X-Microsoft-Original-Message-ID: <20251015130216.19868-1-mingruic@outlook.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN6PR16MB5450:EE_|CH1PPF12F7FA700:EE_
X-MS-Office365-Filtering-Correlation-Id: 6aa5125e-6c42-48c5-cf29-08de0beb3183
X-MS-Exchange-SLBlob-MailProps:
	/UmSaZDmfYBk0OqXWkGcw9KFcS+e1k4iPBsjYbCtZF7WEizEuKaVbdboUJDyvlR1uqKCzByxMLHuc/65p568uG6Li6lvzvE7bSSQsSbR74/19qf4riv3z6yuL6y1+XLdx8O76/BgX/My7ygIMPZIrA+9N00mMDi3i/u1NcQMoApbuyLQBdfIY7GXlBTIOJzxa+GMhVOpcbgBCXbIDatcYbhI6PPEgbGEfDrh30eF7C1KPe8syyzQgddBtK09bd7UCQ3a1HBatHrNsgDkqPFLl0TisFnYm/Ng9WGpK66vuck4Z3vf8pL0Qfqq3pO/bEViBFMldYzeLf/PclVNUZhvUHx753b3FTSPiN/ok80G+TgHgclYDqRxGTKGBv5Mt3XIailRyqZ6mXAZSZVAh8NfDk+tcFxhILH7mcmAKvlD8YlIfZXnkKKiyOq7AFwMWi2KSvFayNWQHr9QyXwVPkMTaZkO6yYkgOyGoHJ+mGUD3DafnY4u347/U93Bno1e1RpF79HH8hOp+rw+I/15wVzy1GSkh/UuP8y9mwRBmdMUoOEF39JPK0Zp21QLI3JjnVW5TE3DeZd8n5A9rsA/UuouEZpy0Er5Sczwv8aImOend7HkQCweKYDB2WgAdblb0Y2m9pztUWqQJPE/CnyxGDi8spUJdX1ZAhCOlSTTcd2sd189+bgIqvXyMTPoRMtYvaEmhs0XORqtU6x2hH4y1kp/MQ3gGzWgFIukkc99hYmRbtj5YTeZlFP9e23FUBHKLKpji0WBeoIvt+zFbeddfHYZnuhkpuJNkZ/EIiqd0p+v3DXi8PQ2ipy7WpVaB3SRQLWwU8vNsfuVfSMoDAAv1eRT5A==
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|5072599009|15080799012|41001999006|23021999003|461199028|13031999003|19110799012|8060799015|1602099012|40105399003|440099028|3412199025|4302099013|10035399007|12091999003|1710799026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?sgppNpIj/an2CvS6p/lWsIIbHGpw7o0pmB//xOIDQ7SUb1uF2s/oKpJoAOQh?=
 =?us-ascii?Q?A5CCNZ7hCOmJaAGUhZH6DQeBxm/EVomyOg/QOS86UMMKKOW8pSnmKZGq00UR?=
 =?us-ascii?Q?np+i/vpNa2UGk9DM7WYjQP8p8uFnugqkkLY9Y4IqxNz1xeWJFqoCqjsQ15qr?=
 =?us-ascii?Q?vCqL7jGs/P24/vRKA+3HrubjPWDQk4TWpEb6OX4gk8oPKNHOLuqnytvbBWof?=
 =?us-ascii?Q?A2+id3lbOkuIcU29o/4KAahPjYhZUVQNMxu9+7ZFbZFwdXVheXTygKHOIHh4?=
 =?us-ascii?Q?F+UQOYPbHODiQ+lZEo2pfejV0Goz1bcpjn0ZGP8vB5kluEGj5opWOREE+Gih?=
 =?us-ascii?Q?gCjc/BTBQzrdeYL9e7vTYRwZiWBRkepFX6oNYypSLzqIK1IRRLWJGo2Dn1g8?=
 =?us-ascii?Q?1nTxdBF4yGJz5MG/FHAM2VFb14u/Z7pEHGDO/MVGzhEW8LhMFh3urbAMDaQb?=
 =?us-ascii?Q?PL/NubMOEWhA55sVEbzV43CSkYuqSxX2pbTdg3ULLQW4N+LeZHUcaFw8H5pT?=
 =?us-ascii?Q?ulnyGWyjhCHoaHxO+jzOCYKsZjS51eKP7EkJ0tmubM+K7U+nFp4nnO4K6ytU?=
 =?us-ascii?Q?RkYY/eDxUhxuECFqGynCLO9MfUXjuqLKyx+pCUzmX9qW2i2X2tgUjMyTXmIV?=
 =?us-ascii?Q?w4EflSTIyzJz/6t51kIBugwV/5QKywjl2bexAGNRhOo513Nnn2RJ1sZn4g//?=
 =?us-ascii?Q?auOqQUKl6GXoSxk3elAvdw+fSPQSTjJfHp5A1UiLG2LiSLBN5TGPFtvwUAPA?=
 =?us-ascii?Q?Ho6AwsalvcbIIu1Rtm6DcE2Z6UIQax9a2lUSpUsJZu4UbpwwE7wmjE7vfLpQ?=
 =?us-ascii?Q?jjnj/EP9w6Dd26LF8xG+UkRkVXoGTTRgZymdXZPRJBudjkACp4PX+yGrt0hY?=
 =?us-ascii?Q?UoHH3gLzB1Zwz+hcyUKHXN+iNjFNK0y6ZIpxqWHwPZ98R3gRB40deURALDTq?=
 =?us-ascii?Q?FJm8+1Q88P+eazHXLJRLPengJDcQn5/K2hnL1BJ7QjQYmHg+6DIAK1mn+xBc?=
 =?us-ascii?Q?JhOogX0cCQpIubRN1/U47FVbIJ3eQYFVD05x/gy4FW2VpqdWD64xgdsln8QH?=
 =?us-ascii?Q?MpauRU6QVD25LDayU4IXPArdFFldjmIkpqUdPUMDi/IqvMWDof1YxkqJkoep?=
 =?us-ascii?Q?PwjxE5E82yGiTC+4zSPeqdD+LdrsnCYF3e7nCoWgLH8OfHThcdwEAg/HXMmy?=
 =?us-ascii?Q?FhYQtiutTzGN+Q2Ygot+C9KSVoEYGX6xx0RnJNYf3LlBODXfs0Ps4xh6u3qY?=
 =?us-ascii?Q?tSnwpXUw+oMEZ7N5aI0NQ9gx7YwrUkvwQz7EAc6SDKyy86r4fiwxtm6CHWUG?=
 =?us-ascii?Q?Tha0xDACiCsjtKHZkmeVl+WluSbIolYBS9BvEGKXrgVIqdLZNrTo6m4IIUHQ?=
 =?us-ascii?Q?IJ8GN54=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ZCH04J3gav97fTxqicz+ONTYG6kI99GMYP6u7P9gmQfhZ0D0d7lBSI81CLAT?=
 =?us-ascii?Q?eTVbcWT/D5DNdTXthz7bANZ6lo8v0cBY8Zzmb0xbUMZwMe4WAsjYD5Cw/lvS?=
 =?us-ascii?Q?4y9ffLyiQmF8jHB3KOZ4P+H3M67UjK7DgU39mlE0PeMnuR5v6Is5O5wXqdql?=
 =?us-ascii?Q?cmRXogtP+K9H6CeviqsQbKZzVaPA4SIXQPhmwYhZ58cu9oinUkIq43BCfmOI?=
 =?us-ascii?Q?KHU2FdrhZnvgAgHB+EOQBThqYPLMdf19kSShtCaSLi9zkqMJxowKyWQ3fEtF?=
 =?us-ascii?Q?lRpLhia3e3VI+Ph9oF/I032rzBMUqDyQoQw77V+gm1MCMBXP29WSNUlZELDf?=
 =?us-ascii?Q?Z0nBDH3hHshNCLPKpPfiGHGuAEZmANdDlDoar3d8QcV9PxvBSu/P67pIo7Ho?=
 =?us-ascii?Q?fpgoe0EzEaG4ADtn1k7L0cP34oBOxM95Zr7/S+vb6MTxuIc2UAzDUE3P51me?=
 =?us-ascii?Q?UB5dinBb1uAAHLLy3NCVoPaxL/exezd0Mdhn5qRsErnlsoasGiaeFEmRdh+q?=
 =?us-ascii?Q?Y+3lPsTKwtNF5sSWdDXmGn36AXJOf4OiOuh3LTq5BpnDmxyytwCZeh1FKbiB?=
 =?us-ascii?Q?33eyR6aW7KoumzWL/0jhkemK7ivVaoITmJ5fz0QW8RqDM5U8c8qcYVnT1Pxl?=
 =?us-ascii?Q?GAx45SBRLZ/euhJSf/vkhc3Zf7F73V+6wDVQLCGxmE3mqnmcYBi3umWzAl4T?=
 =?us-ascii?Q?48nHGVsfdruePiy5lLH9fDdmXOwQuDXbr8Mj04oXHcd4WzK+8ek4UHRH3lp9?=
 =?us-ascii?Q?oKXmMXs7wIE9+gyEOWEJrsr403ywLOjwYWcIREVy8nH4GC7RPGbaVyRTjf2L?=
 =?us-ascii?Q?Wxes3gZ3sgKqmDvmIYqYhFgOug9U+UU99juRcKmjBvO08HrctEaxRUBVBLci?=
 =?us-ascii?Q?llxj/CfEC1d3F4Bd61QIdjNRVfWye7TMrcbk/oLjxjMK8PiZ9yA0FhD7MDwq?=
 =?us-ascii?Q?K6kPs8ROG5BTBHwkIj7jhwAIdbOJ/7CuqJgK1GjsrLGKOcA2M4mxBtUs4uqv?=
 =?us-ascii?Q?uif0nHPxLgsO+VUtjAASOiaNKsGnJrOpY09H4OQF+ajTx2scRZbPwDX8wZ54?=
 =?us-ascii?Q?5S1+JHxt4Sb5jcXzAlBFXApwrqv6qgWe2lIC1Tz8AjDj+NUK/Rt0Q+/AFag0?=
 =?us-ascii?Q?Z2iY0mosbFn6YI6YZKO2+ggEAsCu97u3nqMFIfJ9rQGNk1RhdlfoXx0V1kJw?=
 =?us-ascii?Q?K855P3iEgLP6z0Z55gpwWgYn2Kp8jIGtal5oQptMaYW3o/VJ839/w+E/9VOB?=
 =?us-ascii?Q?lMm0tX/FIB6LxXHqIwHEdvMK9ukaMUPIHIGrvcbZn2FWGPN3gnR3adtb4R+M?=
 =?us-ascii?Q?QliOm+/bz5A7eiZuiCsSEjwlzsq7Yc37Q9phPB/aqKkS5Q=3D=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6aa5125e-6c42-48c5-cf29-08de0beb3183
X-MS-Exchange-CrossTenant-AuthSource: MN6PR16MB5450.namprd16.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2025 13:03:11.4773
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PPF12F7FA700

Hi Dragos,
Thanks again for the feedback.

On Wed, 1 Oct 2025 13:02:02 +0000, Dragos Tatulea wrote:
> On Tue, Sep 30, 2025 at 07:33:11PM +0800, Mingrui Cui wrote:
> > When page size is 4K, DEFAULT_FRAG_SIZE of 2048 ensures that with 3
> > fragments per WQE, odd-indexed WQEs always share the same page with
> > their subsequent WQE, while WQEs consisting of 4 fragments does not.
> > However, this relationship does not hold for page sizes larger than 8K.
> > In this case, wqe_index_mask cannot guarantee that newly allocated WQEs
> > won't share the same page with old WQEs.
> > 
> > If the last WQE in a bulk processed by mlx5e_post_rx_wqes() shares a
> > page with its subsequent WQE, allocating a page for that WQE will
> > overwrite mlx5e_frag_page, preventing the original page from being
> > recycled. When the next WQE is processed, the newly allocated page will
> > be immediately recycled. In the next round, if these two WQEs are
> > handled in the same bulk, page_pool_defrag_page() will be called again
> > on the page, causing pp_frag_count to become negative[1].
> > 
> > Moreover, this can also lead to memory corruption, as the page may have
> > already been returned to the page pool and re-allocated to another WQE.
> > And since skb_shared_info is stored at the end of the first fragment,
> > its frags->bv_page pointer can be overwritten, leading to an invalid
> > memory access when processing the skb[2].
> > 
> > For example, on 8K page size systems (e.g. DEC Alpha) with a ConnectX-4
> > Lx MT27710 (MCX4121A-ACA_Ax) NIC setting MTU to 7657 or higher, heavy
> > network loads (e.g. iperf) will first trigger a series of WARNINGs[1]
> > and eventually crash[2].
> > 
> > Fix this by making DEFAULT_FRAG_SIZE always equal to half of the page
> > size.
> > 
> > [1]
> > WARNING: CPU: 9 PID: 0 at include/net/page_pool/helpers.h:130
> > mlx5e_page_release_fragmented.isra.0+0xdc/0xf0 [mlx5_core]
> > CPU: 9 PID: 0 Comm: swapper/9 Tainted: G        W          6.6.0
> >  walk_stackframe+0x0/0x190
> >  show_stack+0x70/0x94
> >  dump_stack_lvl+0x98/0xd8
> >  dump_stack+0x2c/0x48
> >  __warn+0x1c8/0x220
> >  warn_slowpath_fmt+0x20c/0x230
> >  mlx5e_page_release_fragmented.isra.0+0xdc/0xf0 [mlx5_core]
> >  mlx5e_free_rx_wqes+0xcc/0x120 [mlx5_core]
> >  mlx5e_post_rx_wqes+0x1f4/0x4e0 [mlx5_core]
> >  mlx5e_napi_poll+0x1c0/0x8d0 [mlx5_core]
> >  __napi_poll+0x58/0x2e0
> >  net_rx_action+0x1a8/0x340
> >  __do_softirq+0x2b8/0x480
> >  [...]
> > 
> > [2]
> > Unable to handle kernel paging request at virtual address 393837363534333a
> > Oops [#1]
> > CPU: 72 PID: 0 Comm: swapper/72 Tainted: G        W          6.6.0
> > Trace:
> >  walk_stackframe+0x0/0x190
> >  show_stack+0x70/0x94
> >  die+0x1d4/0x350
> >  do_page_fault+0x630/0x690
> >  entMM+0x120/0x130
> >  napi_pp_put_page+0x30/0x160
> >  skb_release_data+0x164/0x250
> >  kfree_skb_list_reason+0xd0/0x2f0
> >  skb_release_data+0x1f0/0x250
> >  napi_consume_skb+0xa0/0x220
> >  net_rx_action+0x158/0x340
> >  __do_softirq+0x2b8/0x480
> >  irq_exit+0xd4/0x120
> >  do_entInt+0x164/0x520
> >  entInt+0x114/0x120
> >  [...]
> > 
> > Fixes: 069d11465a80 ("net/mlx5e: RX, Enhance legacy Receive Queue memory scheme")
> > Signed-off-by: Mingrui Cui <mingruic@outlook.com>
> > ---
> > Changes in v2:
> >   - Add Fixes tag and more details to commit message.
> >   - Target 'net' branch.
> >   - Remove the obsolete WARN_ON() and update related comments.
> > Link to v1: https://lore.kernel.org/all/MN6PR16MB5450CAF432AE40B2AFA58F61B706A@MN6PR16MB5450.namprd16.prod.outlook.com/
> > 
> Thanks for your changes Mingrui.
> 
> >  .../net/ethernet/mellanox/mlx5/core/en/params.c   | 15 +++++----------
> >  1 file changed, 5 insertions(+), 10 deletions(-)
> > 
> > diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/params.c b/drivers/net/ethernet/mellanox/mlx5/core/en/params.c
> > index 3cca06a74cf9..00b44da23e00 100644
> > --- a/drivers/net/ethernet/mellanox/mlx5/core/en/params.c
> > +++ b/drivers/net/ethernet/mellanox/mlx5/core/en/params.c
> > @@ -666,7 +666,7 @@ static void mlx5e_rx_compute_wqe_bulk_params(struct mlx5e_params *params,
> >  	info->refill_unit = DIV_ROUND_UP(info->wqe_bulk, split_factor);
> >  }
> >  
> > -#define DEFAULT_FRAG_SIZE (2048)
> > +#define DEFAULT_FRAG_SIZE (PAGE_SIZE / 2)
> >
> Reasoning my way through this code as I can't test it on 8K page size:
> - 4K page size: nothing changes so looks good.
> - 8K page size:
>     - Smaller MTUs will be using linear SKB, so frags are not used.
>       Looks good.
>     - Larger MTUs will have a frag size of 4K. The number of frags is
>       still below MLX5E_MAX_RX_FRAGS. This is what this patch fixes and
>       it looks good.
> - 16K page size or larger: as max HW MTU is somewhere in the 10-12K range
>   all MTUs will result in linear SKBs. So looks good. But see below
>   comment about keeping the warning.
> 
> For non-linear XDP, frag_size_max will always be PAGE_SIZE. So this
> looks safe in all cases.
> 
> XSK with smaller chunk sizes is still an open question. For 16K page
> size you could still get in non-linear mode.
> 
> One thing to note is that mlx5e_max_nonlinear_mtu() will now depend on
> PAGE_SIZE as frag_size_max and first_frag_size_max are now MTU
> dependent. It wasn't the case previously. I think this is currently not
> an issue as this function is used only by mlx5e_build_rq_frags_info().
> 
> >  static int mlx5e_build_rq_frags_info(struct mlx5_core_dev *mdev,
> >  				     struct mlx5e_params *params,
> > @@ -756,18 +756,13 @@ static int mlx5e_build_rq_frags_info(struct mlx5_core_dev *mdev,
> >  		/* No WQE can start in the middle of a page. */
> >  		info->wqe_index_mask = 0;
> >  	} else {
> > -		/* PAGE_SIZEs starting from 8192 don't use 2K-sized fragments,
> > -		 * because there would be more than MLX5E_MAX_RX_FRAGS of them.
> > -		 */
> > -		WARN_ON(PAGE_SIZE != 2 * DEFAULT_FRAG_SIZE);
> > -
> I would still keep a warning when reaching this area with a page size
> above 8K just because it was not tested.

Understood. I will add WARN_ON(PAGE_SIZE > 8192) in next patch as you suggested.

> >  		/* Odd number of fragments allows to pack the last fragment of
> >  		 * the previous WQE and the first fragment of the next WQE into
> >  		 * the same page.
> > -		 * As long as DEFAULT_FRAG_SIZE is 2048, and MLX5E_MAX_RX_FRAGS
> > -		 * is 4, the last fragment can be bigger than the rest only if
> > -		 * it's the fourth one, so WQEs consisting of 3 fragments will
> > -		 * always share a page.
> > +		 * As long as DEFAULT_FRAG_SIZE is (PAGE_SIZE / 2), and
> > +		 * MLX5E_MAX_RX_FRAGS is 4, the last fragment can be bigger than
> > +		 * the rest only if it's the fourth one, so WQEs consisting of 3
> > +		 * fragments will always share a page.
> >  		 * When a page is shared, WQE bulk size is 2, otherwise just 1.
> >  		 */
> >  		info->wqe_index_mask = info->num_frags % 2;
> 
> Have you tried testing this with KASAN on? As your platform is not very
> common, we want to make sure that there are no other issues.

Unfortunately, the CPU architecture of my test platform does not support KASAN,
so I'm unable to perform KASAN test.

However, I ran a continuous iperf test on the patched kernel for one week.
During this long-duration test, no crashes, new warnings, or other instabilities
were observed. Do I need other tests to confirm further?

