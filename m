Return-Path: <linux-rdma+bounces-17721-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0Nn4OdadrWlW5AEAu9opvQ
	(envelope-from <linux-rdma+bounces-17721-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Sun, 08 Mar 2026 17:03:34 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8985A23101B
	for <lists+linux-rdma@lfdr.de>; Sun, 08 Mar 2026 17:03:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7E7E8301C15D
	for <lists+linux-rdma@lfdr.de>; Sun,  8 Mar 2026 16:03:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 811D931326C;
	Sun,  8 Mar 2026 16:03:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="I1UDWMLP"
X-Original-To: linux-rdma@vger.kernel.org
Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012028.outbound.protection.outlook.com [40.107.200.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1591315B971;
	Sun,  8 Mar 2026 16:03:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.28
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772985806; cv=fail; b=G3025cdnY+S3Wi08zevvLh15ylm7koTgmlu2dkXVXTxECzZEsPbi2DHVJ5yMLuQqnn84Wm/Tu2am93sQAG5uJ8qclkdDRzF5wqtRzoCVA9+1spuwHkZ43NE2KkUwCOtfemVyM2d+5qmoKhAlMET4HqvCwB2N4oHZ/aCGcXzIaCM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772985806; c=relaxed/simple;
	bh=fzQ54SxI40Q34EFCOF6sUAmGa2qzwkRy4/LGw+h2lhY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=sW/erIdw8i2C+j0LtIkrIt7na/K88zzCXyGBqzkCW5Vk7jTuB2GkFs3+T0cDBZ7Xlx+8vh7/j2nWlbujFJ7yCdNKdSXLd1jJix/JtZBpN/xnuJ7WTDTZXNn/a2eAOrFczxytxQ8fGaPR9NHJ+V+mXnF4qZEnP1pT8SR+7wEvdn0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=I1UDWMLP; arc=fail smtp.client-ip=40.107.200.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Q8+cAu4FYE+weXptm0WeAUrjOt3wcjf3PHAJH/AfIy51go5u8pyzJeGvAMfIJAuKjlJtGK6fBswj5V11nSk/3g1wawE5PQV9AsZWT7wrgXYCtsij9fuoPoL2J0VmlPsKxSAnYBwd9EpyLEcGD4+BC6lJbuyEKs7D+PpUsWwNhfD5GS8dJdVRmf3U26fTzitQEUEqUHkOH3TvSpnzg+JnfYezzeQgQttAQlrjuH998WfSSwsgrslTUwkzv8KJWzJicsq3dBNgPXP0u6Rt4rq2d8irCiZrXIBzKEXhA5spyhHXaMgA/HPtGIQCMwXN8bt6J0pVoeIMyPSDHQR/2NG2uA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6esBwd3eOY4JuflynZMCQdTyAB+HbV3AGWbrM2Uqf7Q=;
 b=VRihVuWHuK0aPHji3mTPiGMHlHPKqB9m3xQ/kXtEU7BPyr5D7egIw5oxf9jxMcspfE2Qp2j4V3ZY2qjJNODNkjjCr6qPDm7taIv0WtNxO8lcdSL3wFewLpwEvS/cocvOn83mkcMozqojL91lH/NiiNzQtK7S1m+/59YgrzcfaxoFwl83k5w7kE0p7H0RQZ9XQw76BFhGBvJ2iWzJwyT8A9Fftszzi3ICEhzs9xYO5E/2Cc3Usmj2Txp160VBUzMKBYnSWcm7XghrzOvqmupCM3xpB79SKBtAqP3JyHvtbwzlh12ggtgi2JMkcc8c+kXjOwkt4zAa5I2f4aCW7H55lw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6esBwd3eOY4JuflynZMCQdTyAB+HbV3AGWbrM2Uqf7Q=;
 b=I1UDWMLPeS/FHauKW+Nh055vW83Tq36TYE0tnDm7GfVmQQF/BUZZJugMqtA7xGBUge/gKPS2uYmDrzpN4nQ6/SgUbCXb7bS81kc4GucKE9XInoW3jGRCPN1D44lKP1NwE1OnOOFs7R/63Tp/ThJWBSkJAfZ/A+BmV1szQ+OFdI/s03mzE6yAwJ7nIaiU6NziZW0LBdEtpHgiuj13zRjddu5Tg47m4ht8QPWGtxEih5jN+NNI6PlszxebdUEU3mOANuMrqYF6+JgLX0a1ZgWivVTlXugY35GdRULhzx2WdHA1y4+/Er7jQ4RDnt1+zKG6G14dSKDCXOgSIraQrZN9GQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY1PR12MB9558.namprd12.prod.outlook.com (2603:10b6:930:fe::13)
 by MW4PR12MB6951.namprd12.prod.outlook.com (2603:10b6:303:209::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.9; Sun, 8 Mar
 2026 16:03:19 +0000
Received: from CY1PR12MB9558.namprd12.prod.outlook.com
 ([fe80::920f:8246:c48b:7ce9]) by CY1PR12MB9558.namprd12.prod.outlook.com
 ([fe80::920f:8246:c48b:7ce9%4]) with mapi id 15.20.9654.022; Sun, 8 Mar 2026
 16:03:19 +0000
Message-ID: <74dcd7c5-8a2b-49a7-a23c-174d17a61955@nvidia.com>
Date: Sun, 8 Mar 2026 18:03:11 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next V3 00/10] devlink: add per-port resource support
To: Jakub Kicinski <kuba@kernel.org>, Jiri Pirko <jiri@resnulli.us>
Cc: Tariq Toukan <tariqt@nvidia.com>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>,
 Donald Hunter <donald.hunter@gmail.com>, Jonathan Corbet <corbet@lwn.net>,
 Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
 Mark Bloch <mbloch@nvidia.com>, Shuah Khan <shuah@kernel.org>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-rdma@vger.kernel.org,
 linux-kselftest@vger.kernel.org, Gal Pressman <gal@nvidia.com>,
 Dragos Tatulea <dtatulea@nvidia.com>, Shay Drory <shayd@nvidia.com>,
 Jiri Pirko <jiri@nvidia.com>, Moshe Shemesh <moshe@nvidia.com>
References: <20260226221916.1800227-1-tariqt@nvidia.com>
 <20260302192640.49af074f@kernel.org>
 <pmxkihhtsskkwsvdia4z2ss4wxpfc4a4kqxkjv5wk3mwdmpzii@6go7pizk2nst>
 <jssifysprwuafkinc3dguspngxmplrngqxvotp76vhvu4e5lp6@e7mdrjqc5rme>
 <20260304101522.09da1f58@kernel.org>
 <np44uzfn6jea56uht4yq4te5clapgj7pk6ygyvkl22wxumwnvt@nrpvzjqzxenq>
 <20260305063729.7e40775d@kernel.org>
 <ni23r4jiwgc6zjjsubtl4ujjgxzwpxrylumofdwxgozfnieynm@zirlbneaz6p2>
 <20260306120301.0ebe1ab2@kernel.org>
Content-Language: en-US
From: Or Har-Toov <ohartoov@nvidia.com>
In-Reply-To: <20260306120301.0ebe1ab2@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0178.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b7::6) To CY1PR12MB9558.namprd12.prod.outlook.com
 (2603:10b6:930:fe::13)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY1PR12MB9558:EE_|MW4PR12MB6951:EE_
X-MS-Office365-Filtering-Correlation-Id: dc59a5b0-56db-49aa-722f-08de7d2c3740
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	og5IuiNma3/hdGXLbQuOvyY+5ryjB37zZM+aiT5t1qXFIAF4GL+ZxkOTOoevWOwA3wQ1UqQuu9/abw3x+BQQataLG7y++CD8LES10hxAVHMS0pji9f7skXb99+GDiGTBGOHeT+kfL6Azmm3ItJ/r7fBDHv1m38nMBvqJuk2THBEJ5wryROmmYCuNXAd/e5IRN1d9MCVdkNcKf1Runh44mtqdZUPPNam00A37c9cHhppMZ020AD2MRZlfaJSCHGkaKf0i3R8IGKivVyWn+JCowFESiL0viGa2NfHESLgnMbYHuds+hcXAkXtp8/Gw0WbRgozKHaAgFAF1HwoqnLLD1qUVkItmJXI9daA0wXZpTH/ABhV5edAXQ5chB+txOZ0zoBTS8aDfCdHU1BkWgvbEiyQZJ16FiJ1pzEPEdnCIJAVVaw+n81DiJ9ICbvSkq/5tUW9+KaStN6wj/LlytdAi11FpVHpKDZNSip7mkUMzQjUQ+gtlFOSggXoXADpFLZaieVtvZi7r3lsv6y0m6+5Y1K9+fE4wC9Aa8VW9EAtZ3K6BjbfnEJVfea2TqsaxDKPQkuu84pDw42LIGevbXI63h51W6B5RBweqneglAUeBJ5oNSejWiw2xwvMXuL+b2Bel6XgYDxIFtAaqaDcjqI8A8+m6paydm70Fm79GT6R4EKSz916IOOurouPwzqdi3F+7Ax7naUnmJ0LQbi+HiidnqF+PT1XpBKsh2yz5oX9Mj0o=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY1PR12MB9558.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MFlFQzg5R1ZDTUxhRVJxdVZTV256TnFVWlFhUDJ1NzJFNW1lWFpUZDVkd3Rz?=
 =?utf-8?B?OE9rNGIxWTNDU2g5N2hHVGhlTFl4RnhLQkhDM0p5MkdjYTNTSzZaeGxUUHVv?=
 =?utf-8?B?Zkt3dEt6eG1seE0raG42L0I5cHFJWWp3MWlBUTdzcG9vdXFqMGNyL1U5clla?=
 =?utf-8?B?aXNtNFFUWXp3Q1BDL2F3eUk4RFRBT1FWTzFPT0ZubE1kcVhpVGV6clVHSitH?=
 =?utf-8?B?M1MvNGpTZ01UajVXVXlXbDA5YTVOamtNWHdUWUttTzZGRjcwSGt5b0RHc01n?=
 =?utf-8?B?QWlrT1VxN0lzQlpyTzFNV1pwNk9TTlZzR1FFeFg3Snc2d1hhZjFib0ZiNE56?=
 =?utf-8?B?aUpSc01Xa1lhL0VJT1dOTUZWWnp5dlNxcmduTVBESGpOSnhEbkNNUGNsb3dk?=
 =?utf-8?B?bjRaRTN4RkxTRlB6dTZTWHFLYTFuN0s3MlI3QVJiazZ1bzVYSitCTW9Mb3Ry?=
 =?utf-8?B?VzV2YllOK2llRVU1SzR3MWRCVDZ2cUZhcWtISThaVFAyV1dCMXpEckxVSGFu?=
 =?utf-8?B?MTAyZVo5UnA5Z2hEMkwwR3VaZ0gwMHk5NWw4T0JtcW5TUXArM3RLQ3RYOHZC?=
 =?utf-8?B?NldSLzF0N1hkaSt6SFcveTU5UWtZbVNmNUc4RFRTTjdqanVrdm4valRGVHZF?=
 =?utf-8?B?QXYxaU1NdXZXQ0k4cUJDd2JMdlk5TkEvSnpYVkI2UzlhV3UvTExwUEFCZi9Q?=
 =?utf-8?B?b25XRlU2YmladzZ4VlJ5b3dPS25Id01nYXFiKzNPRXkwYzFVZHVxcUl5NDhB?=
 =?utf-8?B?enVkb3ZQTkNJWW1EenJDUE1SNFg3akJmZ2NXWlhwd0hjaTVkWXhwZEM0N0sx?=
 =?utf-8?B?U0NnelRQZU9oV0E2bjdTbTE3eWxJOEhvM1F3UnA4d2hjaVBzQ3IrNGl5OUpv?=
 =?utf-8?B?Uk5FYWx2a2VDSFFacG51c0cxbU1lSEJoa2tqZ0ErMmJmYTJPY3B6eUNvbXhQ?=
 =?utf-8?B?NEJqc3duSEllNnIvYVJOZnhJUzAyWVduMlppc1l5dlJEcUY0RFpyaXlLRDli?=
 =?utf-8?B?V0xYTjFBaHc0U0xnRDQ5RUNVYy9aVHUwbktHUzRXOUhMUm44UVh3VVlwL3Ry?=
 =?utf-8?B?d3VMcTl5cFVLVzk0a05HcWxyUllFOVdlWmltVk9VVjlucjN4dDRvc0dLeFR5?=
 =?utf-8?B?NWw2aS95OWtCN2h4dEd6aFdFRGdSREJ2K2ZvYXJvd2hUTHpUTWNtYnpZdGNG?=
 =?utf-8?B?YnA5RlE1NFlpNHJiUWhTclF3OG5wR1o3TmVYTUoxV2hadVZkdGNETkF2clYy?=
 =?utf-8?B?ckZFNEIyVEVaN1BLUnl2ZTFyMjZoNkZkcWwwVm5FalJBbjUzcVp2M2Q0Wnho?=
 =?utf-8?B?L05tVFJHRVZyWVR3S0pHSXcwT2draWNJdXdQcnZINGlrTjZyYzkxTVZmTCtG?=
 =?utf-8?B?TVl5K1lwTkllNVBJRG5Md2llMjBCbFdjaS9YSGNCVnZlSWtieDVQbnNITTVT?=
 =?utf-8?B?bHZrN3c1Mk15TFQ4YzRndlN2eXlCTFlxY0E5emlyMk4xdDhwamppNjFXMUZQ?=
 =?utf-8?B?NjR6eXEwUGRXNkJGb1d1SlBLZnZTVHVBMzRIdEFTWGh6SXdOZCs4UlpzTDdJ?=
 =?utf-8?B?UkNKOWRDMS83ak9SY2JIeUpWRmV5L3dWbFI2WHFLelNkaTZUaWVLaldicXE5?=
 =?utf-8?B?NUs5YWwxN0U1VE9LcGcxSTZwM08vT2hZb05RdjJ2aEtoR3BBU1gyQWQ5bUo4?=
 =?utf-8?B?YXZLTEVFQWNJZytLZ1k3UXdzWkhkUjJsdnBnTW4vTHBjY1JVVlEvY2Qwem9J?=
 =?utf-8?B?cWNQYkZVQll1TFk0TmNVSGJBcUJIU3h1QTRpVVl1dlJSeWNGRENMN1BtNVEw?=
 =?utf-8?B?d2JGbE9WajZWeDFTLzRtLzBzTkUvWkRRMEtsaEhJSUwyWDlaQ1VWSGwzNXhO?=
 =?utf-8?B?N2IyeFNoVEQvTUhRL0hFVU5hUFd6ZnlNd1RPTy85bFdmbUJIR0VHRW51MklV?=
 =?utf-8?B?b2FZNGN1bXhNdjZWdGgwd25QeEp4dlBUZldzNkxuNTRGZCtGQ3R1bVhGaFE4?=
 =?utf-8?B?Rzlla1ZyT1lpQmNGWmx4QmpBVk82VmRveEptSVRjMmVRTHNVMDB4YUdpK1g3?=
 =?utf-8?B?UzBHbVJnb2tFQVhxS2ZoNjlPVTlxZGNsWk5PVDZ1UncwalBDOWhSU1pXME94?=
 =?utf-8?B?c25lZnZGWXFiWHh0TkVqaE1pcVZwK2ZqM3dwQzFkaFZ6QWYwREgyR2pHV3VI?=
 =?utf-8?B?eU1mNEpkMWJINUd0NDMwelM4VDRYS1d4anRmUjFvSVB6a2JDck03MEl3elBK?=
 =?utf-8?B?UGE5MnJ6WnBZczhCc3RTdWRpbzFndUZna1FpNzlUNHdsQ3JQYXBzKzZRTWFW?=
 =?utf-8?B?Tkl5ZVR1bHhQcEg4MmVvSmhTKzEvMTRMeXM1TEFaU2hSVnJmZmZPdz09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dc59a5b0-56db-49aa-722f-08de7d2c3740
X-MS-Exchange-CrossTenant-AuthSource: CY1PR12MB9558.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Mar 2026 16:03:19.4213
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: f2pAu1umzzHd7yoVzK22jOq+QrKDAnC6kWmuSj/SnwRZoLcAIHOyhBv/p3BivtELmEN2cmJzs+LkijWkb5iLPA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6951
X-Rspamd-Queue-Id: 8985A23101B
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[nvidia.com,google.com,redhat.com,lunn.ch,davemloft.net,gmail.com,lwn.net,kernel.org,vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-17721-lists,linux-rdma=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[23];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ohartoov@nvidia.com,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	NEURAL_HAM(-0.00)[-0.993];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[]
X-Rspamd-Action: no action



On 06/03/2026 22:03, Jakub Kicinski wrote:
> External email: Use caution opening links or attachments
> 
> 
> On Fri, 6 Mar 2026 13:13:26 +0100 Jiri Pirko wrote:
>> Thu, Mar 05, 2026 at 03:37:29PM +0100, kuba@kernel.org wrote:
>>> On Thu, 5 Mar 2026 08:56:42 +0100 Jiri Pirko wrote:
>>>> Or, alternatively, we can have per-object dumps as we have for all
>>>> objects and command right now and leave things simple and
>>>> straightforward? I mean, I don't really see a benefit of a single dump
>>>> for more objects :/
>>>
>>> What do you mean by straightforward, exactly?
>>>
>>> User will most likely want to see all resources of a device in a single
>>> dump / command.
>>
>> Hmm. We actually already have this for region and health reporter dumps.
>> Only for params we have that separate.
>> So let's do it for resource too.
> 
> That's not a good argument, as I said in my first response to the
> thread:
> 
>    I worry we are mechanically following the design of other commands.
> 
> https://lore.kernel.org/all/20260302192640.49af074f@kernel.org/
> 

Hi,

Do you mean that we will register resources per port, but not show with 
new devlink port resource show.
Instead, the current devlink resource show dev command will also display 
the ports of that device?

For example:

$ devlink resource show pci/0000:03:00.0
   pci/0000:03:00.0:
     name local_max_SFs size 40 unit entry
   pci/0000:03:00.0/196608:
      name max_SFs size 20 unit entry
   pci/0000:03:00.0/196609:
      name max_SFs size 20 unit entry

Or should we keep the current behavior where devlink resource show dev 
displays only device-level resources, and only the full dump shows both 
devices and their ports?

For example:

$ devlink resource show
   pci/0000:03:00.0:
     name local_max_SFs size 40 unit entry
   pci/0000:03:00.0/196608:
      name max_SFs size 20 unit entry
   pci/0000:03:00.0/196609:
      name max_SFs size 20 unit entry
   pci/0000:03:00.1:
     name local_max_SFs size 40 unit entry
   pci/0000:03:00.1/196608:
      name max_SFs size 20 unit entry
   pci/0000:03:00.1/196609:
      name max_SFs size 20 unit entry

Want to confirm which behavior you meant.

Thanks.

