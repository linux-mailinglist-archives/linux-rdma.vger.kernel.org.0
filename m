Return-Path: <linux-rdma+bounces-21659-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id m3tdICt1H2qBmAAAu9opvQ
	(envelope-from <linux-rdma+bounces-21659-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 03 Jun 2026 02:28:27 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D35EE633333
	for <lists+linux-rdma@lfdr.de>; Wed, 03 Jun 2026 02:28:26 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=Nvidia.com header.s=selector2 header.b=ptLmMJ1q;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-21659-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-rdma+bounces-21659-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=nvidia.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7CC20300F528
	for <lists+linux-rdma@lfdr.de>; Wed,  3 Jun 2026 00:26:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B0E51D5160;
	Wed,  3 Jun 2026 00:26:23 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012053.outbound.protection.outlook.com [52.101.53.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B49B91C68F;
	Wed,  3 Jun 2026 00:26:21 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780446382; cv=fail; b=TFysKxxUS0yFleYKfir9kJV1q6CvX3AWqWAY3A1iFuz8RJ9vEVFs/cHX6gWuDykpkDCDKNVc2IAR68HGGWplBDwomvTjFFSlf1dRYXmMLMDP33n9Pg0SWIZ2r8DdOEjZXUiiUEo3hU+eG3y/33u1uc8pHiJDhWIZ1kRVwupUDjU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780446382; c=relaxed/simple;
	bh=2RFAFqBm49HQMH9xNyRBZpClgYFtJjVUs8jLZzI6KxQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=nxsUZr8Xf5+aYNl7ZgbI9robYJ8xd+biVoRH4HUSmuyKXNLTDOhDZlSYOdqNw3NkS6JFMVgYNh4anUkCAH5dyJ3qMcfA6PLtPaKPMIxBcMdLBDOTv+9v4un1EE/dno6NOg/yicFlU/6m2ti4HCTqEfWeaQ7dhzSgogwrH0lCIYU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ptLmMJ1q; arc=fail smtp.client-ip=52.101.53.53
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=G4qfocTNAUpQ6rDCpW4qh2/GOOq9jVSWfAPx8gfYryNI1AuWmTKkyR0Nplgx5C2rZ0bRpkyzHK494rG0BL7AdY/BmzQnqXZECR1xmFaK3RSCKJkfj+UzRx1kEF5ppHJPD7tg1hTZupXacMi0a0nUgAD2pHvOjJ9d0Nb6/mNJcBJfRnkQfh5miWXl641ZydIOz384nUifSM22XezGWAZStbz8hsKLUOPsbrarDG/qPb0XF2LjrOp/fsFhdQEsZbTxWwLSvznnpxM4y3V1vWge9hoeZy7/xLSYKxYlOGUM4pNspopeSrx9gtkN6WRC7UQ9eHSsKtVGoGKsGCRnz1Pqog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bupXWKBWsu0qDIG52GFWCmlSEXsSYp19hdBMiutfW2E=;
 b=UtGmbdDT6oT01SC7AlKK2DR7Rg5URr06F/nfdzT97ZxihnCvlcLdnkAzTmb2MUOFsvhETC7Um8k7agVNmkt2oDmxGw0NEMfFMcSaSYS/EbRDZ1RIBBGa3MSvBjz1lj1pUoVcOpX4UntYo5oFquBwHMqcNHmsOACjg+vV/Qg1H21kWTtl2AKR7mCS1y0jUdxjuywaoTgL7D2/qE4/DvYH7gcYQ3L0ydF3sp0mA8Tgyq/E8bcRk8rGr/f+ssJgU3qb/vA/m1/6hJ+2xSn3STViJe188rnL2Bad7SfsdjQZv30HVLkMGfeWND21LSVQG5ZgFDHU/Mn+NtTEOFfUUXEoTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bupXWKBWsu0qDIG52GFWCmlSEXsSYp19hdBMiutfW2E=;
 b=ptLmMJ1qUK04Snphs4ZsWmYaphUkSJzm4wVEHpWHNGGjD1U1XofTXDApth+obkB1MW4rWkyj6cV3q7PrEpV+JwLNQoZt3LLXZRUdPSNwgESCS7MvjXQQ/JXrJ3c6MsgFFIcuTz1KXlvHUALFCN+C/T5v5NYkUoFUOWJoWRswixDH5B4u2/LSjWv6VCNr2BPnPdyUTexs80+Yr79R2OADZu9BYdJ45ygsG/s0YsvH1jTHNB7G5zRAyVXevhAQC86hf2Zga4O3Z7HZSNJsuchqf5ELmVipx/flJjWjevz0UlRF5OyY7VHEJofKbfpBUuvxfJszOwiHrAw6uAc2w08dlA==
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by MN6PR12MB8544.namprd12.prod.outlook.com (2603:10b6:208:47f::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.16; Wed, 3 Jun 2026
 00:26:16 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%4]) with mapi id 15.21.0071.015; Wed, 3 Jun 2026
 00:26:15 +0000
Date: Tue, 2 Jun 2026 21:26:14 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Praveen Kumar Kannoju <praveen.kannoju@oracle.com>
Cc: yishaih@nvidia.com, leon@kernel.org, linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org, anand.a.khoje@oracle.com,
	manjunath.b.patil@oracle.com
Subject: Re: [PATCH] IB/mlx4: Fix stale CM id_map entries when RTU is never
 received
Message-ID: <20260603002614.GA1080033@nvidia.com>
References: <20260507154755.452008-1-praveen.kannoju@oracle.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260507154755.452008-1-praveen.kannoju@oracle.com>
X-ClientProxiedBy: MN2PR11CA0024.namprd11.prod.outlook.com
 (2603:10b6:208:23b::29) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|MN6PR12MB8544:EE_
X-MS-Office365-Filtering-Correlation-Id: 52976490-6202-4798-d8f4-08dec106b8f0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|1800799024|6133799003|22082099003|18002099003|11063799006|5023799004|56012099006;
X-Microsoft-Antispam-Message-Info:
	bGO57d3KmqBHbLafqM6GcTiA1bKGtoOOQAjcgu2wmWLlU0K7WLBvPyZZJMG+PShLS1ZsoSmDrm5qThc/AWDN3zMEz/P2Mpzgg57GDsqPSOaDh0aEQ3+tDLcz0Ap1BEjuAUw2YmGYaEWoAiFtMUhTTjUz5xIotLcXTlX9UFdCXu7tdZyF0NWJHUasLd1ej0N4Bqiv1jLn2wm3d5UggyAdBu81emXqb+M0HS7z6g0TaNOIYPn8aLKVHbYhelVcnldKeOmrBoZqWI2BIblrSj8XTBCg97n3RdTbD+G/mleXOeo1RSElsmxBnDXAM17HmZm+p3xPlFp/6FfzNzoSxy07reCE2+beWfZibef5x217hxW1aJToevtydxWm8VJ41HS5YWXrtBEYVAXbQ1Q6/EcZQlyHssNLwlLcB2LqDy5JdGbgBZJ4ekgrz5+nPPdobS8LbOlqaZwLYef/9e4rHBkT08wTqAZrVj1xXIeFdwrgheLoO/kK9WC/niU8cRg6mOJmLWfWSKPBTWKqrepduvpyd8P58byNp8ZVWbRzp7fuXGtE5/XseoR+MTzvDekaNTIdKhOyToAcqoLc8nKf7RS5hfj4+CaxDJ45tHdNfRHEp39lyWFn1kCTU/KJSf8vOe2qxBwVhVRjxVg5r9sDp4UnHb1WKkDAOuh9cIq7OejgQGs2/7b1TGAHu8JdyBJo0gay
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(6133799003)(22082099003)(18002099003)(11063799006)(5023799004)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ZSGKS9QJhvFY/cbbavJ6YvOk0DX37+hCrn8n/LAwNN8+ZALVPAqKJWeQ8nDe?=
 =?us-ascii?Q?uutK1ExrdYLLYUuhZPQ8QWhSD+EnM68PKXlhoDksFIzHqktIXFf+QT7Dg4dz?=
 =?us-ascii?Q?YhVisre2UOo/ac3w7s1eFwSjGv5DSJ2AtsCvCfU5ZXd4T/MUBNjUV4Irbkls?=
 =?us-ascii?Q?h55lrIKvnH6zjbf2nqUhmIfu4CL3Zl5qBap6mYXIIkVlLb8vTZOxs9s3+OfE?=
 =?us-ascii?Q?VM1eyLQdOSj2gJ4xJKdFZd4ItHE2TOylimsE59EgJpCBEf9bqiU6MnMvxre7?=
 =?us-ascii?Q?ICeZ7IJPS7dhVVQbFqs+1e1tjsEm+xgNHFaBqOzIzbzl+6R62Yx8A3ESTI4T?=
 =?us-ascii?Q?wEzfWZy9BMaLVLJMtJnNug0IZhUHLFPi6XZeeZc5T7ERXjb9HZHsbumMk6sD?=
 =?us-ascii?Q?kJTFJhNVq/eAeNzaqvx61Q1xj7Tuj9TNadvIpdWwlFUBuX6aLYLl/S7a7+po?=
 =?us-ascii?Q?iPRhJWiPgFSZeZLTgoOUprkMGymyaod9xLe1TWMc6Hnd5zFnxQPYmXI020iq?=
 =?us-ascii?Q?SUI9oORHi0uzaRYZCRpzgdi9610ba4ltySjoYZvsxEzIE+JB1/JEtw8xdxK7?=
 =?us-ascii?Q?0qb+gma6uCfxOrZ6fsGqc3z18e+MSv3x0ljEJIHz8hRtY1sTXW0EUTt1+u8k?=
 =?us-ascii?Q?yaiHamDyCbhKCFFVCG7VAgBVtUmFoGMSLDg7jl3lzH9KbKxbs6HWfW74PJKO?=
 =?us-ascii?Q?t1A9lozTLXeTNVYK1WDxGVsZO/yEnLDeE8YRsBH4c3x15nu5A2sDx6yexCa0?=
 =?us-ascii?Q?6H6t6XSgWEu0GOQMDSYzkNgcOFkEsl4GAzqcdgT2IMZv2tzAUhotvAuJk9sC?=
 =?us-ascii?Q?f30Ym5hbw2isShaE3Y7mpW4tzufl3D7Gqb8Hl9v9tCPnu/z4ZccU8v604pQ+?=
 =?us-ascii?Q?Ld5/LxeLR0VzMyaURvviyCxC9sQ/bCFAQ1Tg7QgsBoeKOMB0EeiPoECZ08o3?=
 =?us-ascii?Q?sR9c30o9COjjCZbgTQPL7VD2Zz5KEfISLOLOHx6jpMXqAJzeqIIlSXBtBSXC?=
 =?us-ascii?Q?tPkr+8jFhVAO9VYus/AlwwbVJggG3TfZ3idMwehIjNs4IMySW7K2y3wYOLPK?=
 =?us-ascii?Q?AG5zN6b6b0WoFZaPuzzc6Ka0dwDAAowj0A/gT1pUxYx9QOje8pywZhBCauUb?=
 =?us-ascii?Q?EfR7aQQ8JxAaczztDIvmn+u//cIyYBcFeUt3jayio1nO6zYfxYYX2/HkTs6O?=
 =?us-ascii?Q?LqmLADxkrRPzW/zJwiTrIWgZlY3jvbgrlMBZza34J8XhAmiZX9QYmu7iOsQS?=
 =?us-ascii?Q?p+FMq+zvGbtPYoMlRKl4FVXHjfZXp0k3MFSYcfHfwrxy/B91WA+MF2jSg7Kd?=
 =?us-ascii?Q?rwRuPH2I29uYGkhXlr8V3/T4ytJEC8zas8acUbL6eGr4gsNgD099GNsqySBS?=
 =?us-ascii?Q?QsbaGGkr4oVy2CJ7xDjodZ1ADcrIvZoE6PgPSeaDNsDyrBfIOq8oXvMTH88U?=
 =?us-ascii?Q?BHH78kkmOHO9uMY31X6Bwy8dh/ErzxOqODF/s4gTjejB3/x6wFK+3yms3Weh?=
 =?us-ascii?Q?wjCNQKFhkYpSLmBlDMax+xTzEzdwxx9/qow0peazytlO6k+1vATYCT62MlIL?=
 =?us-ascii?Q?iXGCElCLYh50UKp+CeiJyB04+Spre2Il3fpgYRaMDxMlqthwTNPOSQVJUwQh?=
 =?us-ascii?Q?LT7JWhRrOfyVv2PeUbOl2MD3rjaXjEa8ePwHRMCtQ/viM6GfD1h60Jxdb8wX?=
 =?us-ascii?Q?/V2Tfme5z0M48XrmSpGZXK0LNTOPUMkpziyKdhjOqHp/ru4L?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 52976490-6202-4798-d8f4-08dec106b8f0
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2026 00:26:15.8879
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6GgiaCeScsThyOqGMIRBzI7PDrhfZyi7JsZsf1zYKbadLm4JuJmDqUlk1w69TnB9
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR12MB8544
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21659-lists,linux-rdma=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:praveen.kannoju@oracle.com,m:yishaih@nvidia.com,m:leon@kernel.org,m:linux-rdma@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:anand.a.khoje@oracle.com,m:manjunath.b.patil@oracle.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[jgg@nvidia.com,linux-rdma@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jgg@nvidia.com,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-rdma];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sashiko.dev:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp,Nvidia.com:dkim,nvidia.com:from_mime,nvidia.com:mid,oracle.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: D35EE633333

On Thu, May 07, 2026 at 03:47:55PM +0000, Praveen Kumar Kannoju wrote:
> mlx4_ib_multiplex_cm_handler() allocates an id_map_entry for CM
> transactions, but the entry is only released on DREQ or REJ flows.
> 
> In the duplicate REP handling scenario, cm_dup_rep_handler() may get
> invoked when the remote side receives a REP for which no matching
> cm_id_priv exists. In such cases the CM handshake never reaches RTU,
> and the sender side may never receive either DREQ or REJ cleanup events.
> 
> As a result, the allocated id_map_entry remains indefinitely, resulting in
> a stale mapping leak.
> 
> Fix this by scheduling delayed cleanup immediately after allocating the
> id_map_entry. The delayed work is cancelled once CM_RTU_ATTR_ID is
> received, indicating that the CM handshake completed successfully.
> 
> This ensures abandoned mappings are eventually reclaimed even when RTU is
> never received.
> 
> Signed-off-by: Praveen Kumar Kannoju <praveen.kannoju@oracle.com>
> ---
>  drivers/infiniband/hw/mlx4/cm.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/drivers/infiniband/hw/mlx4/cm.c b/drivers/infiniband/hw/mlx4/cm.c
> index 63a868a3822f..700a840d491d 100644
> --- a/drivers/infiniband/hw/mlx4/cm.c
> +++ b/drivers/infiniband/hw/mlx4/cm.c
> @@ -299,6 +299,7 @@ static void schedule_delayed(struct ib_device *ibdev, struct id_map_entry *id)
>  }
>  
>  #define REJ_REASON(m) be16_to_cpu(((struct cm_generic_msg *)(m))->rej_reason)
> +#define RTU_RECEIVE_TIMEOUT  (60 * HZ)
>  int mlx4_ib_multiplex_cm_handler(struct ib_device *ibdev, int port, int slave_id,
>  		struct ib_mad *mad)
>  {
> @@ -321,6 +322,9 @@ int mlx4_ib_multiplex_cm_handler(struct ib_device *ibdev, int port, int slave_id
>  				__func__, slave_id, sl_cm_id);
>  			return PTR_ERR(id);
>  		}
> +
> +		schedule_delayed_work(&id->timeout, RTU_RECEIVE_TIMEOUT);

So this is a distinct problem from the other one? Can you put all
these mlx4 bugs into one series?

Why does this open code schedule_delayed() and remove all the locking?

Sashiko even points out this might create a UAF:

https://sashiko.dev/#/patchset/20260507154755.452008-1-praveen.kannoju%40oracle.com

Jason

