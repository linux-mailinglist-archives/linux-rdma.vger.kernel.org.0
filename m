Return-Path: <linux-rdma+bounces-21499-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0BdcDBaYGWrVxggAu9opvQ
	(envelope-from <linux-rdma+bounces-21499-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Fri, 29 May 2026 15:43:50 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 846A2603032
	for <lists+linux-rdma@lfdr.de>; Fri, 29 May 2026 15:43:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0303B303012E
	for <lists+linux-rdma@lfdr.de>; Fri, 29 May 2026 13:40:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5543F33AD8A;
	Fri, 29 May 2026 13:40:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="uGXNRZLh"
X-Original-To: linux-rdma@vger.kernel.org
Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010062.outbound.protection.outlook.com [52.101.201.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06DA032861F;
	Fri, 29 May 2026 13:39:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780062000; cv=fail; b=EtK9jGn18Qrd4tIF0Rg/LMCxFP/I2xzydI+cFwb40+oKrUdKfj+FCJvX7IjMvsB7llrjiRpqbzg58TT7AjkuyEiwIRGwv37H2iWicAiuCeCvEYbbafHCYN8dkPAk0fUpSpq5uRpyQ2JfPJoG5OrENHuznK0/uncb7InN8LJKTCY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780062000; c=relaxed/simple;
	bh=R52WJT+0RI1w1MP83NVrnpp/xZ1xbDVHLIcY3uu4uz8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=SrkID+Lyfs7+x2ZtUFu8rNcd0f7dz9GaM2c2GYDDLTmcU/mlQeAIFlX/twOkT63d/meDyd5udo8mc2JYuEAWpNfzno/XHJw/jUjlw39vSxm7/9PFygSsGZVdUAZs/4BZ0BoHGsf+FFzUY95fVXe7krf4GgV1dQIzrFKkIADQ/So=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=uGXNRZLh; arc=fail smtp.client-ip=52.101.201.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=i19VgmWykQZFutLWj+Jg+EBnBXdn6qQgN1NwUVjd2GrtHgA7crZMaocboikXwvyfEw0jSOliwcTzVCtFEaaE8/+Upt4iytucFPzeuz12VmpSinLuoWAcRQtrHDDHr0wqaC4sW5QKCjFq4tFm3LUTdUUwU+24qLB8CE5qIMpL/HH0VI+y0PBjyhQUTy9cFLq89+WbSJok+XEqV648m7JvwRYyuOHxF3pDdM70Gns5DzOgOkx0xSiuo2y1r7CM3/P9bBPbFF61LfgZnzy+J20UxqTf8JEc5+X0mfyXz9peReqbgGXxc6iLn0ZnNrMpPo6SoQctR5FGh7pbLxDdkJhkTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xxtPB9QiwMz/oCaEWUQKCnP2Iqs01Na5XeGMROpYjiY=;
 b=U4KWCZPX9hh5G6t7rr8CQSpy1gqT9ZHTafJFju7e2iPEKXdjWEvKVv8Iz0b+yrgyRfuoQNIoPut4VQG151p2Vu7c66ZM70QJ2W5oCxn5KsLma9PpQnIi1eccq0us7KhOYjztQ8ezI85sktUWcUJOOIXh92vYKMezxTpKhxizrhFMM+CKapb0ssAuTWQ9su1Gkp2u2ne/VCw3+HJiJEuzNapm7KhEeTZw5IEeT2jNDxcPo7bcs8NJ4Mg6kEwYGMoxCb/g+MN1svBAG8p6L06wirCD4y41PbJ5VukYsUsaimzdKlx4wHmdC60bVUtrQpaoz8vB+Eb7rlYNRDLdduQWhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xxtPB9QiwMz/oCaEWUQKCnP2Iqs01Na5XeGMROpYjiY=;
 b=uGXNRZLhD7T1CZizdkno9w+JKcmZoEN0EZoGW9QTiuvH5XndCXYF9rhNLvOtPF0fNeR8xoWddesVeSuXYzOb6vivB11Rkq0TCzCsz9sV/uJu7TVvSWbWN+wEPF0J7EkwgV6DIHFWODif54uoZtB2RM3n6Ie8TRIDjCgujB/U9Fn59FDopqpGkbfd5wmVDsuEBJH1yDoxSYciIAExhRAl5hIRAlRE3yTbk6AWVKkZb+wxe1E1HZTC8KVExPscOczqOmlna1TNpjkVEe7nWls9jjiDYW/+1eUgQOloDydppJIu32E2JQ2jhtiG1/5+DVN+uB45knIbxTNZCl20CPlFXA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by PH7PR12MB7914.namprd12.prod.outlook.com (2603:10b6:510:27d::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.15; Fri, 29 May
 2026 13:39:53 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%4]) with mapi id 15.21.0071.011; Fri, 29 May 2026
 13:39:53 +0000
Date: Fri, 29 May 2026 10:39:52 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Purushothaman Ramalingam <purush.ramalingam@gmail.com>
Cc: Zhu Yanjun <zyjzyj2000@gmail.com>, Leon Romanovsky <leon@kernel.org>,
	"open list:SOFT-ROCE DRIVER (rxe)" <linux-rdma@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] RDMA/rxe: fix typos in comments
Message-ID: <20260529133952.GB153998@nvidia.com>
References: <20260527104527.3222-1-purush.ramalingam@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260527104527.3222-1-purush.ramalingam@gmail.com>
X-ClientProxiedBy: BN9PR03CA0680.namprd03.prod.outlook.com
 (2603:10b6:408:10e::25) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|PH7PR12MB7914:EE_
X-MS-Office365-Filtering-Correlation-Id: 98757c30-b4f1-4b86-d92f-08debd87c367
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|1800799024|18002099003|22082099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	5uQAqeyZ0XV43qXfCAja/GWlc9Kcla/MWPPxE79pzZ8C80l5vRLKzsjbaM8LU/2pz+bMJ4HMnZEb9p0Q6ZtGPvdFHs1rziOcbi5RHArCWf3EdHKgybBZZvrLTMMja8tag3kJygpZbGN/Z+tUrLn0w2iPqTUqdRfTLTrok08OjNMVypDVObdgLXN5x7hqeuqAGVUn+hZVcB7RLEIiyuGw4IPLQHkqZyPRfxtj7S1x6lesSww4ub4w+yZXD8XHR9McB8JEIr/U/7ivR9zEbwygJI7W2zFh5i53ZNG9XrWAGAy/9XaFduJjGOJzZN61Qy7byXmtCVmRa8sBsbjDsq1+ejvj76gg6oamJ7Fk47vUdmcihfKVf2gOXIUwyASedY7tUJeMtb3XaPEyGsX8hW6aZpuPgAjfWWYDhvmkbAy9kCGnUiSBrEdshdT7KgItsX5cJrZopXh9cPduhTHZb3JWS7GsbhR63R2fYJs0tavZ8BlIWaFMqcAiXdCH7TlCDv6xFmjZAJ39H6JDRFEW37NT5O9/2gRekQvMQeq1EGfJ4jprSHY4jzasTf539WqdTwjrlMYIGCwZVuXrRpFjp+qmy3X6wL8PQGpr5+OOmnNcoaUjwzVxXBkzWpVw8tO5HV9ZuhO4Ax/NqqkUNF9QlPuI4NdhvzWtsvpO0QXwySA3b2qJJ7io/saD1ZQQV2Ps40Ni
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(18002099003)(22082099003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?AgyP6uXyBdrxnvmXn71t6QJAX4jAh795ZMFWI5rnHJh5q0mvXVjz/LmkZkmj?=
 =?us-ascii?Q?3VmqYn2NzAuXtSfr8mn7uxlbOPy7gOrOT7G6AtrGJsmDegraXRHH0JNgNj+U?=
 =?us-ascii?Q?ItUDvjsrY2WZ2i+q52DwlJAPKko7QFrfpbw0zUlrDA9Tw3koiNU5vOXWMlb2?=
 =?us-ascii?Q?riyT65X34Fyi5uFdfu3lqPCEQgZPazWrNoKNcEYBt0QoNlH6f8AQwPPIP+WC?=
 =?us-ascii?Q?RflYwgpBMJc4wDJzU9dlxTjdUDkz2V49uS1asdUZcDvqeEn/Lp8jQBOUzh51?=
 =?us-ascii?Q?htkYuYS/Xbdi2ZZu9HGWarx7zh1T5NJ8SrNeb35dn8lkKBYJd6YMr5Hp5+j8?=
 =?us-ascii?Q?fz4o0TGt1cT3G+EoYXIM9Mb7rTFxh2kK/8KXTWYFFZYR4UDBQHQckc5CA0Bs?=
 =?us-ascii?Q?ofBl5AtlcLa1Dnw/bGmPHUkZk6s68MszazIbnZJxvE2UD3yNfrKH9RsBmnA1?=
 =?us-ascii?Q?oyxXSnbbqMQPwprldAJQ66cgBDWGQ6qcM5vcoNBpVf+gnNKJQMbe9GHxNOfi?=
 =?us-ascii?Q?VoPZmebsEfhAhiXlbag1qNGEz1h3SHYYDxnDANmE3Ns4XzjfNeytzYua6E5j?=
 =?us-ascii?Q?wSVnVRfy8ZUUYooKJqtaQ743yuMZ5+HRlCUUmBw5JDAz6aC4N+lejDGtLwvz?=
 =?us-ascii?Q?mRs+x88oA5c8H925qwz0GPnJrHtznnoB0iuIDEVTth4iZmSBi7K5IYjDLozD?=
 =?us-ascii?Q?pNoyXJLIF4zcedtR6nSDh/eLMSPv55lG4jwSKjzpn7ku1iFdtY9ZfGHnhxL0?=
 =?us-ascii?Q?j+vjmr2QMfxujPkdoXp0cXjh10NEJi6LwomDCoRAgPC7CXB/9VZn5uBGi3Io?=
 =?us-ascii?Q?X89WYSfQjaRLqAA6spYpTkifs13qGxB4CMvBZVTRmEdzZEHmTo6s8tQa06/s?=
 =?us-ascii?Q?NcMV+NilaLWsOLhPnAP4Hrkb9FSFtgJXkKGcNW6hKYbwkOvI4u4zt5WrBMmp?=
 =?us-ascii?Q?7QnbrxB0Ig8sQ8OpOOGvLFlSqLopd4/iwH5Aq99xINghqF74uCzfKyu6KPRU?=
 =?us-ascii?Q?004w06XFKnCu19OtPjmc9Y8xwn+KTBjxd+PiMaLj9PmNhERkZEJQ+ET1JxtR?=
 =?us-ascii?Q?4z+HM1lDp1nKjutt1wQM84gWHB8Yu+HI4d6C9Srf1tclK4KR8HZMn2FBW9oN?=
 =?us-ascii?Q?ZxzsCl5QNmYgcPbT161800bgVKf7LWcTkNaP8fa5VBR51eZZ8Pk+CnmZzcRs?=
 =?us-ascii?Q?eGADISjdXazStzB1R8V/n80SwXU71Yb6e3HiDw5YzgQ5aIx2wyrSKyR5uwZO?=
 =?us-ascii?Q?yRlzpPeYtVnhVS9jXmTDWGEAoZwaRHGHHJ6pm525pU2BO7JYT68d96VK1zUI?=
 =?us-ascii?Q?EwCuttb+vSXI1250dr9mT2CRrsr08OWlFEDUJDopuPOjaJbJQSAoLsyZSPTt?=
 =?us-ascii?Q?UMjKrdfXrJgIrg62+dPe6f+q1AOK+eFYNVUExJv7cAp4/hJX7Nq0kGr1O1j+?=
 =?us-ascii?Q?SUoEfjAEsw0Jb7ONDuz9HL6g4IR3BVp6CLTlox3v/4lw3gUkUPxQCSCEDCUv?=
 =?us-ascii?Q?NJVWjQZk5azrzWf2ZAwRlte6kYe+fFXRZoQjsPYZZoM4GGiUTlh/l2byIS9C?=
 =?us-ascii?Q?y/MDdAlPlxtH5KAvd4DPYushGxUR9fzVerFmuCXccy3z8Rx2u83p+yhFD4gg?=
 =?us-ascii?Q?dj7ZUItQ3WKcFO3R097Yoylx/IpYlBXUM0ui4SRH3x+hb1eRIntXQxddli0P?=
 =?us-ascii?Q?SYFhl5pqOiBtBTB5nvyig7UPMpqwFfLuUTsss5GtqfRjJ2cJ?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 98757c30-b4f1-4b86-d92f-08debd87c367
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2026 13:39:53.1424
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: G5ZK9szDucWuYSldhHR0KyQag3Tl99DtqOp/Ua8zsur28VE2ruGPqzKZyLf8ioJy
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7914
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-21499-lists,linux-rdma=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_ALL(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[gmail.com,kernel.org,vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jgg@nvidia.com,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-rdma];
	MID_RHS_MATCH_FROM(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:email,nvidia.com:mid,Nvidia.com:dkim,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 846A2603032
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, May 27, 2026 at 10:45:26AM +0000, Purushothaman Ramalingam wrote:
> Fix typos found by codespell in driver comments:
> 
>   rxe.c:       s/mangagement/management/
>   rxe_param.h: s/interations/iterations/
>   rxe_resp.c:  s/recive/receive/
> 
> No functional change.
> 
> Signed-off-by: Purushothaman Ramalingam <purush.ramalingam@gmail.com>
> Reviewed-by: Zhu Yanjun <yanjun.zhu@linux.dev>
> ---
>  drivers/infiniband/sw/rxe/rxe.c       | 2 +-
>  drivers/infiniband/sw/rxe/rxe_param.h | 2 +-
>  drivers/infiniband/sw/rxe/rxe_resp.c  | 2 +-
>  3 files changed, 3 insertions(+), 3 deletions(-)

Applied thanks

Jason

