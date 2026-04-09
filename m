Return-Path: <linux-rdma+bounces-19171-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gFQUAxm212lURwgAu9opvQ
	(envelope-from <linux-rdma+bounces-19171-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 09 Apr 2026 16:22:17 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id C08803CBEEA
	for <lists+linux-rdma@lfdr.de>; Thu, 09 Apr 2026 16:22:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4DB8230471F0
	for <lists+linux-rdma@lfdr.de>; Thu,  9 Apr 2026 14:20:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F7793D9DD5;
	Thu,  9 Apr 2026 14:20:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="XHk4r5Hl"
X-Original-To: linux-rdma@vger.kernel.org
Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013034.outbound.protection.outlook.com [40.93.196.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04BDB3CB2E0;
	Thu,  9 Apr 2026 14:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.34
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775744434; cv=fail; b=QpGOzLLCCYGUViUE5aeIqa1n/i9lc+JrbbmbdVjtJs5WMIPfJt69Z+5kZ5dxAPjAgo2dj+bdavcchvvtvie0sS4M7EnXfVxiui7Cokihw/omgA++38UrigwcPcqLMQ4oU54uBXYUUBBtBxeA2UsWzqvgcPM75h6dG2qvBq8gniQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775744434; c=relaxed/simple;
	bh=McsjuWN2BJgX81ObbIKGHPCadWgrh5mFy3djezFyqBw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=BYS449NY6HCq0EQPNBJ9eW13P5HNgOXAdI43XK/5pSExkgEt02Niy8MlU0hVAaLhRfGvot8avuwZsK3UEqP5i1Q4rh2Y1gRWQbfy23LT+rz8jbJHnpDmesIFmTzeNQfLTC9fp16jK8UCeqAlwQSpGpjA9WKIie1HsY+RkrX7kUM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=XHk4r5Hl; arc=fail smtp.client-ip=40.93.196.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fItROdOP+R5h170I8Wpn0gvY+e/VrKBWiqk5V/+W1LjqZNdwjyd/Zk24ptz8jkqkCCmhlk3ASabPXUXkpxh0zZ8Mk0BtloVNsXr6rPLhLbM50jZU2SEaVb1QjDDc5Kt+Ay0pnAAfniW0TVQD+/p5mVxVjARV3UBScVcXWgL9g5lRYp227dXz3FMuLmzuNumoH6F6tcpcygL+dBeV0N8F/kAVKUFn7OWPIUPCQscPtfdAA/w9qrFVPvE3IYnNrtMGkuno5P4+HVHDljwqCMPZnj/lyyAQH/v5lWisv9a9eHVpDNBY8QCw5uQgo46s/keZJHp/efXoXNnPrk8xDY52bQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TJSKVl+gToiWei3MGSLCPvpIoyS0CJYGl4UUr7kMVtI=;
 b=GoQ39iuVBdCxuGOAaYSbtGV61tP2sVpR/5fBNzda8s1sIKLKwK8zrz1D+lw88+I1i1a+5v6TU20oGHodgLIl+y+J4tM10jOtU7p4rO18wz+BoD1uni0YdLAyOC/FNtsX9W5uJJsEQwQF0BQDTeSmbeTHgkgQ6YClTA/koL9N7gMVwQnTqgBjSGgc7R7aIBHis09ib7VYD/eYtKgxmvQhIRDqSU5rNTbtrIRkGFQv4DwnRxh3tQiUuNKMXL5PcHKaa1tgILBJlqLmkj7tA8+qDTCa3Jcrkkk/YK0bM2mRUwslPEJ3gkoE9/oYWJekj9dloCCGADrVjhXxowjYZzjUiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TJSKVl+gToiWei3MGSLCPvpIoyS0CJYGl4UUr7kMVtI=;
 b=XHk4r5HlZbfM9tA//CFilCux+rm0QsPK8J/dKrrqzmttrfkv0nkITrabfOS2McLqRar+cIlOCHn9x9Xw61ZE6PDHE6A4cmEH1ZQGYz0P8mQoRkS1CX4A6NepRkurnafOc8Q2QTDajc5DoofAoCv5//PzzkmK/WSIqWb/cOSvYXugB9RwQ1iY5s3RZ3c4sjn5ZPtJ00xaAN9qV37wg9qq/yYsn98vinCMZpqHeFPf6gDTlYTLLdrCLb5xACMRUZW/p0VVmVbDDQ04rZXVK9rn6YlCa3HmTaTDD/Gv8JpUhBKQbLv5FW6fcGHUsjTb6kr7STfsKYVl+GsDjT5jNLRsHw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by MW4PR12MB7336.namprd12.prod.outlook.com (2603:10b6:303:21a::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.20; Thu, 9 Apr
 2026 14:20:29 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.20.9769.017; Thu, 9 Apr 2026
 14:20:29 +0000
Date: Thu, 9 Apr 2026 11:20:27 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: hkbinbin <hkbinbinbin@gmail.com>
Cc: zyjzyj2000@gmail.com, leon@kernel.org, w@1wt.eu,
	linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] RDMA: rxe: validate pad and ICRC before payload_size()
 in rxe_rcv
Message-ID: <20260409142027.GA1902381@nvidia.com>
References: <20260401121907.1468366-1-hkbinbinbin@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260401121907.1468366-1-hkbinbinbin@gmail.com>
X-ClientProxiedBy: YT4PR01CA0199.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:ad::23) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|MW4PR12MB7336:EE_
X-MS-Office365-Filtering-Correlation-Id: a7bed5ea-00e3-47d0-8a25-08de9643267f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	VeMpWNwoyE+J5n7kCyVrgiOWt7366ZGUfAxgdfRUribBwFoGgrL3DigVzPhY/PNqdn2djbIjRWGk1gQYZi87mtjDNene2t7LagGmS0KiLcpjYzo5dEzR7ODcxow8nAzPzqvRTkNmprqvrf9IXrxCyIoY/D03DyhX1XyAprgEBsE3kE2GaOFHdpZIEctwOCNlF6Ud21ZEtfmhooNRgB/xw9zV/JUXejU+q/AosRMwycbq1y3K2szrVDXlUKBYaglFuKlvgSlW0MaQuewk2PBu7ishGb492MDaC3HR8wkTzlVGWM8aR1YCbTtWA11L7F1w565t40BM76bPp/dk7jobXdmqFCnSM1rDbKeXXtn0/zLdCNrp/KLgKqjNHYNKEsUUoAZ9+aQeQqmjZuMiWJq8CgXG2XPtMIwljbZV7m184m6Jfs1M5749GU79oeBExKtg8T+cc6kLY9KPFZZ4Nw+wRVZzjqESN8Qpc7bQZIh2EIbdN1ouKEltceDR4twu2AtEYLu2YF17oZNqikfWbkbaOKigWm+RG0P+sYDzbAC6GArs2ZMpHXmcZMmnZ6sLjg955ivApN/9UDsfLdizaudxONjckH5LgMq1JvQGzHgZNe7yEN6vgDhNyU0yzUHvvr369gt4SJHOzxcIy8CD4mlBVuhyeMQKeMkc4rKQwnN/kbnNztd4RjD+afYRLpu9yER7XrI5qkHfctBC9RVFqgO92NryFsWQFi0vAj3L7eca+T4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?3HwTykkPPkH4w9E9qZuDjf0bJle9QJb5r7iLw2oDrf63uktEBbrzOJsiAGZN?=
 =?us-ascii?Q?sDo8ZndOlKvHYK/72P4S7q8m0NApDSmsh2iU6ViDIj6bWhRfHIr/lvj7FSlY?=
 =?us-ascii?Q?Ay2Kq1i5dTVOUXz7AxJ0n+dEDbMI5Z0grdx7a82N2h6hWrRNT/KF8Z58+vSH?=
 =?us-ascii?Q?g4gxz5FOn06PNLovcnvJufM8oWJVXVU2bmI+BqTwbjGayGPi4jT9Q29Cl586?=
 =?us-ascii?Q?4tlr0baHynRuDMKXK6OtQVVmm8L5fMbWwtdNC9DSVvvO2YQaVLdgRmv/d81G?=
 =?us-ascii?Q?teMo/EkX1AwjNh6gEV6NCK+1TZlMz9Rtp/qxDjG58fsBIYXKgD42ftcqNnuM?=
 =?us-ascii?Q?wn+mnMGVh3M6Oxe3xe3DIExQiqQP4tCnSTDlwwjbEBSp8jg3LAaKKFkTIqXQ?=
 =?us-ascii?Q?/omCcfPAzTzYkybKtOmn/OLYPnDat/yN+12B7Pcrjkfjyrlaq8jqGOSW3XqZ?=
 =?us-ascii?Q?LUIfxnCFCRGnyE5UhTKY9GMT5FeJltCnkMgNshxkP0G7YF8mlBq4HYin4TX4?=
 =?us-ascii?Q?6EsL2M69DyXLtHwFauLhvRWH1FDAeJm56vn33Y3BjVnm5Jrbq3AoM1W+4/jB?=
 =?us-ascii?Q?FVMB+Sm1t9y/I51uYfND3Y6BEbX+sWJbiQ2cw9z+M3W2Ak9HVjHEdNO9ywy5?=
 =?us-ascii?Q?b8k3zjxtZma8bkaXScH7JkQmzbSTPDOX6qDjfs1oREaDTClUUyGlAXooPLws?=
 =?us-ascii?Q?KLM/k22Toqe85XC7xtnVI1mMu6N1gJp8tNr22/8FGt/atXE6JvQcsMWnRTjH?=
 =?us-ascii?Q?FRjX/ltFqScV8QEoZBXFubPqeCxaut+MOaFAVOiccb/bYO1OQbZKfaRhxlXF?=
 =?us-ascii?Q?Jvf2CAb54q+EtTDba9hhzktr1hhJ2hVjt+jxrQt72jV6mneNS3DehmHZEXPu?=
 =?us-ascii?Q?Ba/IqUfoKbL6UfpzJwrs19PT4DA0K45eVzGBQ9m9qS7q82I1UBlq7PH+YY7S?=
 =?us-ascii?Q?URTr9qouJigA1upbEjf/fLI45jfI9Gq/Hst1bMn4DEH/tMauoEY5GBGuKUyH?=
 =?us-ascii?Q?WwE62q0SfMheWHpRVpc7YI2FR2hzSlRL0F9PnBm7c05Pbh6f9Um7tImDfd28?=
 =?us-ascii?Q?lpmI+iXtL6cQmr3XfPKzpZ+1AI6obpn2BZDdl6+4oYMuHKNsnZmpej9XQmVo?=
 =?us-ascii?Q?HVZpRc7xtCrKeMuXB5zZkjK+aFS0Pezi96T3+jqObKTfWyrefogjUkqqphK5?=
 =?us-ascii?Q?fXUZfMNKSYUGRA9xp7jMIgEXCc1Hce7NccNjWLQaT+/1kyl/mituExIvGOon?=
 =?us-ascii?Q?130t0BQOYtyNybUoZObjZepkz6SqE0YnChFBfOulLl4dV90zTxtvJVC4IW66?=
 =?us-ascii?Q?8wRXt4kveKWJxd0hY9nJdhB9tCvF7hrzgIaQa0Uv++UfBXZYl8yKqDR3wbNU?=
 =?us-ascii?Q?Cvo1IQVhCiDTOy0YSsop8hmRo3azW8/f7c8Gtoc67T9OEu4iAtqVC2zkUv9y?=
 =?us-ascii?Q?DRmp03eVtupm4okPBQdcnAVYgkK3ldU94WHba859s+8HpfMqmrOzl1sL1Q31?=
 =?us-ascii?Q?2zb8b2xxcKE6NxMqjrNerbe0lsXF5ic/dEP49ty+AIj6fGKIlMlPJIWHNs1C?=
 =?us-ascii?Q?YMHyLKy/Gu5OBG4GFNvk9Lt+cLYm8w6dqNOqqBXzyo/jKtIMEiP8A1hFS4Dh?=
 =?us-ascii?Q?w284n3qpMyvl6Aqw786/gesELFS81/QvMbpE9oQVN09Nf/fgiaIZeVqwDzhZ?=
 =?us-ascii?Q?Du5MiRLYtYyArZYRjEuvUeLC8apeM5PMhcUGEQK5i0fOWP34?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a7bed5ea-00e3-47d0-8a25-08de9643267f
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2026 14:20:29.0526
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +mYz9TDtKosAapOVgHuh4V20bBcbkIaH6umGJIbPrasgSxM+GPbmRDLn0ReoajXA
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7336
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,kernel.org,1wt.eu,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-19171-lists,linux-rdma=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jgg@nvidia.com,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[linux-rdma];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linux.dev:email,nvidia.com:mid,Nvidia.com:dkim]
X-Rspamd-Queue-Id: C08803CBEEA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Apr 01, 2026 at 12:19:07PM +0000, hkbinbin wrote:
> rxe_rcv() currently checks only that the incoming packet is at least
> header_size(pkt) bytes long before payload_size() is used.
> 
> However, payload_size() subtracts both the attacker-controlled BTH pad
> field and RXE_ICRC_SIZE from pkt->paylen:
> 
>   payload_size = pkt->paylen - offset[RXE_PAYLOAD] - bth_pad(pkt)
>                  - RXE_ICRC_SIZE
> 
> This means a short packet can still make payload_size() underflow even
> if it includes enough bytes for the fixed headers. Simply requiring
> header_size(pkt) + RXE_ICRC_SIZE is not sufficient either, because a
> packet with a forged non-zero BTH pad can still leave payload_size()
> negative and pass an underflowed value to later receive-path users.
> 
> Fix this by validating pkt->paylen against the full minimum length
> required by payload_size(): header_size(pkt) + bth_pad(pkt) +
> RXE_ICRC_SIZE.
> 
> Fixes: 8700e3e7c485 ("Soft RoCE driver")
> Cc: stable@vger.kernel.org
> Signed-off-by: hkbinbin <hkbinbinbin@gmail.com>
> Reviewed-by: Zhu Yanjun <yanjun.zhu@linux.dev>
> ---
>  drivers/infiniband/sw/rxe/rxe_recv.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

Applied to for-next, thanks

Jason

