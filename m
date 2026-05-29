Return-Path: <linux-rdma+bounces-21533-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mCuYMHohGmoa1wgAu9opvQ
	(envelope-from <linux-rdma+bounces-21533-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Sat, 30 May 2026 01:30:02 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 41461609BC9
	for <lists+linux-rdma@lfdr.de>; Sat, 30 May 2026 01:30:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4E0FF3050F3F
	for <lists+linux-rdma@lfdr.de>; Fri, 29 May 2026 23:29:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6DD93BC668;
	Fri, 29 May 2026 23:29:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="aoSODAq4"
X-Original-To: linux-rdma@vger.kernel.org
Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013010.outbound.protection.outlook.com [40.107.201.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69AD33AD526
	for <linux-rdma@vger.kernel.org>; Fri, 29 May 2026 23:29:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780097395; cv=fail; b=bH46llVSpf/wbIafMfW/d3h4OCdCnYWcaYZhuZRS8SQczEQnRbO/eRNOUMN6kK917GqJb5wBVXRO9O8QrhsURxIeJXjHgpqgBK75zr7ZrE2ct1MN3bQ92ozVPI+7Q3xPMWv1XwZ8yNN4rN1kfFQD58vL4KbgTWca6FoRFDzOlek=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780097395; c=relaxed/simple;
	bh=c22S+bJDzlMK8n7hgF0yYAfqUSNto9/oiwZo+WDPh2g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=r9bAx+BU/wUfJQiEaRyjMqoUrG17WN/XlI/uh3WRdGPEfOlfQlbelzae1T1IYchQezP2lNsBg+PqPsXEW+Z2FecyHICx8AOj6v1Gl5CuA3DbeIFDOAeqJWI9pW00BgicCW4xcGCFvLOatuf4fNZJ1BRfXQJP+s3iADO7D8fXXO8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=aoSODAq4; arc=fail smtp.client-ip=40.107.201.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hwOK+cLH2U90rB9gq/u0lAWpb3/WdYj1TXeCXmB3UKlI9+U5R8mIpq0cpKx8NKjU6x7PPrpeWADFmsSjLJQNrOv5GOaqj2fNWNjy2jHouENFk4CoFDXQzAd6FAmsjugD9rteCIpFL2tIo6XcSS1BSsGe/wSvwuFaZL+ieDgPsaoledB7X3CibhlVDLq3hMwHQ8WzJLDuehnvMvk8+iPl7Ns2QkVEYxFHURkH0ZIJJcFlfQv7xdGl0WNgtmEbJouL04wnyYULWOPNv1qD3gqg2QYwdIzENU2Z57lfhGlmquPxBhCaTNoS4002SYIqxKj/qb+HK7MWOweb26cmhCK2cQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k48FgoffkZU+gU/jPQEo6n6joEluxvi2O46AVuFD8WU=;
 b=AukhLGMQ6mG9TgfO6McN3EUbhvEznvBfMnUkEmMw2Q3D+LqMne5Yc1sbjmbvd66EZ+3S3KDZ+g+ih0q35irYwg4+IJpohywE0NPVH3OvFCM6eknUFVKKRzM/qudHaKa6wjsbOr8LyHoDq5OkTlTy8ivQSfi2Yq5F31Spw9TctryN6w9NW+NmZpxydOE8jE1H6FiLtld/IXs/JOVCnSjcHrZAoIUoTsUw6OuEmhdQ8EZAuTjDj7vG6Kfno3/0Gopl2C+M0PI6aMPfVoLbdWyj2ujaTV2e3lxQ8F7hCWbbZ6lYihSBXadWnxPeAXGyJx/Ee6KcU28MPYDZ8oxQURuA7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k48FgoffkZU+gU/jPQEo6n6joEluxvi2O46AVuFD8WU=;
 b=aoSODAq4Qiq1V9gJsusbQ88tqL6lpUxCAkrMZbTq+Z8jJN8pIl4JAi9FvGqLsMzVmpQO+xCr1bfjw3k3GXowA9u77pSkW51CrT7tCbEdT0F6kSnS5ltMhkdvl2YP4b5QMSicem6rbsOchW+8NYdDuXxaCDWGQCjZBH3HEkkrURGYcErrcRTqXeM6h8/HzHfEEtbNNsiRHPrBELKOMqLkDPaX4v/aZdboj4Wj6+OpctZBhhDdLt1bgrTyL6Yk1rHui8J+8HX87pVq4TaluiHnVnPDMhqin/cWv815PQDypYTQ9YRDbMSMyGZV/+uPxXzv+ioQ5RBFzpZXW7SjgSF4+Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by DS0PR12MB7993.namprd12.prod.outlook.com (2603:10b6:8:14b::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.12; Fri, 29 May
 2026 23:29:50 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%4]) with mapi id 15.21.0071.011; Fri, 29 May 2026
 23:29:50 +0000
Date: Fri, 29 May 2026 20:29:49 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Jiri Pirko <jiri@resnulli.us>
Cc: linux-rdma@vger.kernel.org, leon@kernel.org, edwards@nvidia.com,
	kees@kernel.org, parav@nvidia.com, mbloch@nvidia.com,
	yishaih@nvidia.com, lirongqing@baidu.com,
	huangjunxian6@hisilicon.com, liuy22@mails.tsinghua.edu.cn,
	jmoroni@google.com
Subject: Re: [PATCH rdma-next v3 0/2] RDMA: detect and handle CoCo DMA bounce
 buffering
Message-ID: <20260529232949.GA220595@nvidia.com>
References: <20260517141311.2409230-1-jiri@resnulli.us>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260517141311.2409230-1-jiri@resnulli.us>
X-ClientProxiedBy: YT4P288CA0081.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:b01:d0::14) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|DS0PR12MB7993:EE_
X-MS-Office365-Filtering-Correlation-Id: 8b57e92f-a0bd-45d6-3dc3-08debdda2dd5
X-LD-Processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|366016|11063799006|22082099003|6133799003|56012099006|18002099003;
X-Microsoft-Antispam-Message-Info:
	plfnch7snO5Vq46KM5rp3qek2IYVBxLnWqXV3ABO//1bikxEpKODudqG4fShtnw8t7XWI2/eEQy4KUXFWyBl4cO9Ale7nVvL8s96io1RT/gcF66p8uInvdumcMVYaZLWbfQoeo8YXAqaAoKPn56V7MdZri5iysqxPtDn4CkhM2HgFBYyTRTkXMgNIW/St/m9FbjUjkNuZn28IhaXkEXBU2qql5HcB5dq6Zt7q+Hhu53Rh7rS9Lymx9KwQthOsrYL+VllnZTPMb7ht8UHak5MUEWomDsCkB2DGMMSFCnr/fqbq2JatNIswJuKfkJ+BR63vQcXk9ki706rHCd1rJHsmy2BjGwP4B8VjyFIOJEjeoj/JCcLVJ/fLwkXp2R7Ra2nI3DSSOaCjwrX7dORhSlpaSwb9HEbpCxv+6sMpCM5lUlTIkUov31Xsw0mzgAovVhfB7JKOm9maQfEG4UNBAzzQc2WmqZvbaZ/bjE5WthbTGSJNrhvuHkiE4haqc2gRTMceNXIuyiW5s80QGQc/qbQPS8aRAufDTBRKjCY0OZru42VjROxZrHMTF5G4MYPM8RHK3o3USf1hjLGpDbUw+KBCiDhji//Wj1RpZyXw9kM+Eu/MlInigoe2ZtFvrf5HdQhTw+8uyVA24ohFfPVMgVijiT51M3GSzwDdkCCMGNNaiUC/NWpIMYT6SFCANHnZZiw
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(11063799006)(22082099003)(6133799003)(56012099006)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?EE253BZ5m7kBZLwCo2ObZS/4t3dJmVXNUvgbiYUQIMLhH/uvyiURHKcU0jLz?=
 =?us-ascii?Q?MuB9/FqSJOYK3P3FjZ13psUCm1k68jNn9+lcY0tzR1vsumGstRYB7dE0I0cm?=
 =?us-ascii?Q?DzsgStEhdNQq3C7AMMptPZ4+w+fiJTCeHqPoMtTrkKJI+pWvz8bBAxOaPWlc?=
 =?us-ascii?Q?felRq8TMnYhGO+baTTgCGDqAOOSP+1JkJZ8MZ7ai6tKUAq+d4iYlNWT6p4TW?=
 =?us-ascii?Q?fDWXhgp3z619zYe46rc+zLMPZ+PpMytsozLNnOlTqRMj9Lqi6viBJ7Gc2Wlm?=
 =?us-ascii?Q?YlxHoYwgNAvwFFOOGD9O6CtLwaSe11/GE5X0fLwlwUZfp6J3EbLFJTeRfnlU?=
 =?us-ascii?Q?4Tl7C4SnzW6Vjjy/+/xMREVzhwlTpOri4/jxRfzYCfV5KH57JBLlKQa0P26M?=
 =?us-ascii?Q?KzUCzghxbSaYskTm4Mn57bIkM97CwuG9+3ErwKCiUC34pr2s1p/fOQGwhWnx?=
 =?us-ascii?Q?hTxLw9ZlnKtxCoRjpk/IOCrgZpYwJBRnAd2mqaOv1b2Ra1ipI/nPna7rd5vi?=
 =?us-ascii?Q?aGA0h4LE3kk4B2vSp0ap9BzmusTmyMxoLvY1ydSEGs0HmPt2rQyfdrpqCHjM?=
 =?us-ascii?Q?e5X3mZC34GFEQitU1RltaIK+VtaYucriZsXbj7Z4ozf9tow0uukj7NSQM17J?=
 =?us-ascii?Q?tvgNekiVAtxlYQq4etNbMBNfCMmPzrW/8hx7GAeQFx3JBewbv7zE4+TknJz8?=
 =?us-ascii?Q?3sP8eA5FV7Di4jzjXQNqqwmqEcYin0UMHkLi8s6sLMKpnX1v2ugQDLOQz9YS?=
 =?us-ascii?Q?mBq78f8nElbx8ivjO2AJ3RtY7BX/aBuBLORrlAoc7J4qUq7cG/nb5+07nW6I?=
 =?us-ascii?Q?RW2FLeUdOAGQVo8R/8SQqe8s5dHbUf50U5htlI4SSKUEJ4RdywQPB4iL0Mi/?=
 =?us-ascii?Q?uRQhvsruuHs5H0cS3a75Rk4tX95w/X/D7dTDJt5LAPeAJBPEdqrqUqm6/ej2?=
 =?us-ascii?Q?D6DKqBw5M5IR9KhaxSHWGs4Wr4fs2w6cuf/uEJ7s3QjaCFxHMsy0ZOLXyExk?=
 =?us-ascii?Q?NFI4K4Fjs8pgRdHdce61qh8KnVcTkBWs/caPJ0vlWKw/J/p3Wyv/Je7WSvGz?=
 =?us-ascii?Q?fDRSuSJxk1Btr+3KjL+wRMiji/tRPRMGDOVd/J6RQoO14CGyhEWUJ2LYhls6?=
 =?us-ascii?Q?GWhOwHmySlWmPChSZ+Kb67EZmy3MxuBYcYeCc12zy0faqBkiEN5N5f2t7n81?=
 =?us-ascii?Q?znK8Yp33/3F0rUJf/NTSZYe7VNNQkSI3s3QsS7LYaC46TQSRmQ2Mfiq2ZvVj?=
 =?us-ascii?Q?Qos/bF6qVUG/FIOYo607EaN5Bs7PdS15B7mdud0pm/5eNkXsEP1ItdvWV9q3?=
 =?us-ascii?Q?1t51IGNOqTElymp/oW9L7f+PpfE5Ccm14LzWay18Tb/bsRyDJACKsh/Ome8a?=
 =?us-ascii?Q?rh31CrJlBC47Aw+TEx0Rx5xtjBJcZWtsVnuDVq0vlSElBo18ZCXetHorOi0q?=
 =?us-ascii?Q?wxjZwWqxAzaD/K1Lw2vOEEZL+C2YmiymOTjWkY0+R+XP1f+Lh8NcX1FcZGrg?=
 =?us-ascii?Q?150rVl4+TGeAFekXiC1Ifj9jOqaIi5+Sg/4aIgTx117as98Tvoq8T/kAeae4?=
 =?us-ascii?Q?dq02ld0PPG8M1EWvXacfIRG+5j+pga4lx6+Ez3yauLZXyu4t9Sz2DuYcKCKg?=
 =?us-ascii?Q?GmOV0VDyJ3mVgWdMJZ44OOZawxkpr2KEZOq4HC41jCWnQpwUo3c1ffO4E3Oo?=
 =?us-ascii?Q?Mc8rDisAPX7FjbQuWDsHKsJNAGj3wNHu8MOIKlWeZeZF0BB9?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b57e92f-a0bd-45d6-3dc3-08debdda2dd5
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2026 23:29:50.4732
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Kf4CnRbIjqVrJvelmj+uvM8JcVOo0U7PbbJ1luSEi0vE+V4lk/GZ5QK8DY6rmdlZ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7993
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21533-lists,linux-rdma=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCPT_COUNT_TWELVE(0.00)[12];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jgg@nvidia.com,linux-rdma@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-rdma];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 41461609BC9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sun, May 17, 2026 at 04:13:09PM +0200, Jiri Pirko wrote:
> Jiri Pirko (2):
>   RDMA/uverbs: expose CoCo DMA bounce requirement to userspace
>   RDMA/umem: block plain userspace memory registration under CoCo bounce

Applied to for-next

Thanks,
Jason

