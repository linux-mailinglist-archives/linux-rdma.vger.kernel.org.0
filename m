Return-Path: <linux-rdma+bounces-21244-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sBVtDsd1FGokNgcAu9opvQ
	(envelope-from <linux-rdma+bounces-21244-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 25 May 2026 18:16:07 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id A30445CCAC5
	for <lists+linux-rdma@lfdr.de>; Mon, 25 May 2026 18:16:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 50AAC301FD42
	for <lists+linux-rdma@lfdr.de>; Mon, 25 May 2026 16:15:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2995F3ECBEE;
	Mon, 25 May 2026 16:15:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="CkaC5DzC"
X-Original-To: linux-rdma@vger.kernel.org
Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011038.outbound.protection.outlook.com [52.101.62.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4633212566;
	Mon, 25 May 2026 16:15:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.38
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779725734; cv=fail; b=OhOpISPJ7JLzyUAA/b4u0ThLhq52lNvKkA7rUltiwgeHV1yOYVwvbjfl33bsfF/h5JiqHTi+DqR9np+/6cYbdEjQkUOKxFL66xAFTEJApaBu2dssyTuMOXrB7BJHvGLNv7Xkqe8OhxE+DuRpPMvRsneUZjQ9QQE5mtEtMKTouAk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779725734; c=relaxed/simple;
	bh=LmfX4YCkcaexibGFW0tettHi6AB2Iz++zYmgyp8vF4o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=qbn8kltIo6KgZ/ac1ea0GJr+k2FerCpAdnW7a7zxMa7K0KUenqqrdr17wTh/KQPMLv5IG5OC4FVUjOUaG0CCOE+bl2qvwM88HGoQvRjT1tfCDf3Nq3bzU0hjEt2LCG3mi5Zat0pQSvlZffbljvVfaaS1bDK+kR2TNHBBDwli2qk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=CkaC5DzC; arc=fail smtp.client-ip=52.101.62.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Asmo12qfcgIvh7RjhFMfnd2wIgBUZ1s6YVXeaPf8HTzvoruVfa30t3reMZQk3MEBQuK4gbkP1geMaHOchpkYqObqKN5hhwWIIyNz/2J+11E6/H4WhS9wgANnQVF0Sshj6SjIc77F6ErVGIFGA+PGCY5hp+01samOdDqonYlbtKOanKD3hGqylvugMOvwPlIuyKplwLu7ZnIfPZKKOcfL+QT0AQ8j7oWPSNKRKVgB5dk1VoTMGqAT8SIrdzXn2d5WyufWaDvzg01PzXfkk2DEGr1sb9FohVGufPhMN9gOMg4Dloo0G7/YGfJ08sR1p4ls6Fc7YfZlpU1BLm8G5bWObA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GuicfUJpLKq5ebxTodnuyg90Q9245mx7p3rMCz3dBLY=;
 b=naFmyZy0L7ecMDYsmPa6qSMi4DhCG8A1NdX+Uk/UdLsVNUB1PSXGkZpF6Z/wyOmMAT+3TQUzMT1Y1xE2qLdGt++tCanUej/Ky5rs0ItIln9mUDy0Laf2Kt7SNN0SziuOYusoqi+X8S1tZZlH+ek46l33+eej4TF+NYeUvszb5wie/cpuseyoKXI/Lde2ClfMoip1fSm88TV9C2G+yZ+Bk12vZDr6jCtX9MEVJB6Blgf2jEJzTh3CJ9ueYgst8ym9VS9ksp2qhv4BULZU+STkQvD70JcxKxS6jmpGBxdGFoaW0JOqrmLR8HPMiHkLCYsGwe1Jx1MdThNkom2GAmqshA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GuicfUJpLKq5ebxTodnuyg90Q9245mx7p3rMCz3dBLY=;
 b=CkaC5DzCIW+rfZs/K8/LuCGZNfF1QT0Xps6t+pzh76DRd8jQE+jB+8GGm7PL51mjEaidJZaCTeuWE84nZWu82ZG69bWqjLdeGFHcB8siPnJ7WFFOU3cuhhejeP4mNoULzFrIdvMCID0dx3Uhb2Oukn/xamnZZF+DIsr3YNSWqmruCwUSl1gZ6CRlZ5UO4PEsYLEX05JRV3yiGuLsJrX7c2dZgCnSIZ7fGEsFLPdk5qCMnfWXQZFxb7XyolbMB2QK6Wg6d47aGSb/Mv9M+7iIgxRmCldHj3CubSYTqZT2zSeQYV0h1CLEBFuAzhIDWIMH9g/aIa+V/js3RmUjBe5tXQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by BL1PR12MB5778.namprd12.prod.outlook.com (2603:10b6:208:391::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.17; Mon, 25 May
 2026 16:15:29 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.21.0048.019; Mon, 25 May 2026
 16:15:29 +0000
Date: Mon, 25 May 2026 13:15:27 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Abhijit Gangurde <abhijit.gangurde@amd.com>
Cc: leon@kernel.org, brett.creeley@amd.com, andrew+netdev@lunn.ch,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, allen.hubbe@amd.com, nikhil.agarwal@amd.com,
	linux-rdma@vger.kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [for-next v2 2/4] net: ionic: Add PHC state page for user space
 access
Message-ID: <20260525161527.GA2492788@nvidia.com>
References: <20260512092623.1157199-1-abhijit.gangurde@amd.com>
 <20260512092623.1157199-3-abhijit.gangurde@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260512092623.1157199-3-abhijit.gangurde@amd.com>
X-ClientProxiedBy: MN0PR02CA0029.namprd02.prod.outlook.com
 (2603:10b6:208:530::32) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|BL1PR12MB5778:EE_
X-MS-Office365-Filtering-Correlation-Id: a9157f65-d81f-42db-a216-08deba78d69e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|7416014|18002099003|56012099003|11063799006|3023799007|22082099003|4143699003;
X-Microsoft-Antispam-Message-Info:
	fcBREGi2QbzwcddqXs8Znmt2+/kCqq7rW1IPNHv789WdUjsd7pL/Do+vgDLdXL3BpJLgXB8AQLr7w1JXkwenIA5/mvF4gOMrpW2hPjuegBram6ZVbRu65DpcG9QbHDXQyweu3skPZio0kuY71pES/WPStuGKLHeMmzUm9vlv8zYTnw9lHKl0FNkt5I3ka3kOE1Njv5yJE9qHzBNxVVQGaawKb4b5LLU5anwNmToRm7TCg1CVITocUiCkZZinBgX3bDwC6kbbnv20BooAj4np5QwUZUXUuPp7G84pZ2kGMk7gdxD++P7KfaTo8j49CRG07ieRrHmHR4WjMplMSKce4dlXiSEHfLRnYSWsX7npIFEzd4gPB+vfOe6M7Vk0PNsN1yQTEHLvY6qc9GR1lsLdLjkDKsVs0YU/4GicABcjM2C/IpKuWbhSlp1YWLChtROwtBKdyAs8C4AfEBXIcZLuM7xeVIAszLKXz8777HkhEiH0rCAyqnosJrB4QRjki7T1dde+6AfJuUGVAP/Of0mUtzpalUnzsol2Kdrr1/aAEQAexJR/orxR7zN/CtQ4VSObgKql9QFnAO1k0FN9g6xVnnkJp9bKJ8m11cxWn8YXn17ML0yVtnXcTuYuaKyyGDoZtVcr7lesQlbo+x/7K7NWElC5Qc+sGFJnrBYa7VSUuQfp3fvXr0uWgudazEH6udhJ
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(18002099003)(56012099003)(11063799006)(3023799007)(22082099003)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?/80etRrl22PO4o17xlZLOkyrUVezl34wAMSxT2lS3l9FK1Qx2yUpPDbxAgDt?=
 =?us-ascii?Q?ne7a+GIdK9y/gQYERh8U6fU9H5kAV7FJILOVlNQNsNTlUzjXp0ORIyGezedY?=
 =?us-ascii?Q?D/X49Fe4wpQf51muk0slJfvlIPIHYzFo/9fJ2rDQdkT3C9PaDcrtt1AQWDkc?=
 =?us-ascii?Q?2ptA5IXXdDBT2mjVmgcsqYG8++M3+yTgfbcWNq/0NTcVgijQnT6I/40Fldye?=
 =?us-ascii?Q?53dwMLFrxCIliVkZ5exZLxNo6dsco4ARC99aGmtqW+ISco1SDQU42AcprITo?=
 =?us-ascii?Q?Q7lk2ZA2/O8tlX/wF+7YpLdDa9TddZf45QXbrjCCJgdo/VWeFojlLdqP9jQZ?=
 =?us-ascii?Q?8HLKMpBfw6hNUM83B+Ux0XLQfA6N4503Hve/RQIInoJ3/REu55U+LmXL8NGV?=
 =?us-ascii?Q?ou18hIpZiC1kyO6MUClL+aHUJFV5Pt4AceoGk1+S6CrCjXIndZ77auck/uql?=
 =?us-ascii?Q?USFjX5F/DrKW50n/28oOLmdvgz1Diblu+gASa1Vhc+sVj7cNqZ8vqG6gkT9j?=
 =?us-ascii?Q?Xys9gyWZcL2MLGylounXev+YeXupZA54NrMnntdBYpq7iGKhP/wVUBZ59o/a?=
 =?us-ascii?Q?ldktC8ghgFuxZxXquDaYrD5GiiP8ZeDrVVguExT0aqapu47jrdGcADDssK7s?=
 =?us-ascii?Q?Y49nc+4LM5thdvFAep+2YtuKrogW68rkOwNvlt2eQDDJOw5fSCMyZMsjWt25?=
 =?us-ascii?Q?qjKvPjGMY0P/AcozHFmW5OKbXSzpZSaQY4lABhfTs0TEMrK7iIUsdO6DSBKT?=
 =?us-ascii?Q?84/SgXPa6SYX4dnfUEB9N9tzOqALCK+JNelzxOdA//9l8Sx8U7rq1WfDpGzR?=
 =?us-ascii?Q?o7MCV6NVMi3dw7TkYPzzIMy5zTWgpKKbRUv+CKh6ZTcmjB2AuQk1ZUipHHcN?=
 =?us-ascii?Q?QgQ8T0co/jbNYrTxWmqvh2r3Relnv/ZTX1uo+kjnCXk3ISRYnKx2bzm+Nlgy?=
 =?us-ascii?Q?iTxI6zQ0f2kWiQdjK7q24Ft07MMLPgX2lbQuzXI77cXGKJtRMMyGjano2K+I?=
 =?us-ascii?Q?aMaK/xAXW8BTX6RLN0TXEpmwrv6wIcnWuQAO/s1iCbN9ForteTcO6vWZoTLq?=
 =?us-ascii?Q?pjpf6EcN08qn0lLSSfqmG9gzPlp5kB8Q7Z0yp+pwf8X2fnNtVAwQ/CrtmVrv?=
 =?us-ascii?Q?+uVIOw8kKrLfXUoQOpsO3lOa7KNu3T1jkShrIosOWDUTrl98woV3fpeeTN2t?=
 =?us-ascii?Q?Ss6G5TnzQjyNiiOBY7oWJSA4CMOm2XBuZiKrFi5vdPCtyqcuvbexdH46lZ/Z?=
 =?us-ascii?Q?uN2f9fUestx1PyZdml6QmuWS68AAJCDwpLhTAsuxXKDz1Jgz/PphGC0YsDUA?=
 =?us-ascii?Q?MgQL3TlEbAtZfdM6rmkXCGKfkZTvfidx5VAeiJxB+TKCVAyLyvGNh3z9P0jV?=
 =?us-ascii?Q?ubtfIyM++UQV3l/aYKPe91xxFLQ6MBOuGLvIKsWEJBnJORQihgleTC0ywZgI?=
 =?us-ascii?Q?UQBmo/IO9G66jkJ/9+pQnVuqcQ3hzMtuqBNT7gsBArWc/S35Vvc8mWnqrGb5?=
 =?us-ascii?Q?DFdvhhyTtG2V+JDUJ1Cz6y//HioTFXDxvPQKi6TvhZHdQyhnT702Y7bCS1Jb?=
 =?us-ascii?Q?8k1fM7VjO6Ygj9y3/tjKbE3b9DWFJ4HHMcgCErf9YiecqIoMeM4y0z/UzNUU?=
 =?us-ascii?Q?jpi1mseBDFWeotJUEfsAgZorm1RvISgvkYduXBcftsx57EQfAMoWH7tKXame?=
 =?us-ascii?Q?UaF9HV2nOvhN7+fZgvgAX34orrwjosrRMPmcvVhO5WTs99pA?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a9157f65-d81f-42db-a216-08deba78d69e
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 May 2026 16:15:29.7220
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LNatoxXOu/u9k25s42v3YRinkDFBNMr8AGjEDGtoXAYoB5WGloOfE+u2DNp7mdku
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5778
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21244-lists,linux-rdma=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jgg@nvidia.com,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:mid,Nvidia.com:dkim]
X-Rspamd-Queue-Id: A30445CCAC5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, May 12, 2026 at 02:56:21PM +0530, Abhijit Gangurde wrote:
> +/*
> + * struct ib_uverbs_phc_state - timecounter state shared with userspace
> + *
> + * Drivers that use a software timecounter over a free-running hardware
> + * cycle counter can map this page read-only into userspace, allowing
> + * conversion of hardware timestamps to system time without a syscall.
> + *
> + * Synchronization uses a sequence counter (@seq): the kernel sets it
> + * to an odd value before updating, then to the next even value after.
> + * Userspace must retry the read if @seq is odd or changed during the read.
> + *
> + * @seq:             Sequence counter (even = stable, odd = update in progress)
> + * @rsvd:            Reserved
> + * @mask:            Cycle counter bitmask
> + * @cycles:          Cycle counter value at last update
> + * @nsec:            Nanoseconds at last update
> + * @frac:            Fractional nanoseconds at last update
> + * @mult:            Cycle-to-nanosecond multiplier
> + * @shift:           Cycle-to-nanosecond shift
> + * @overflow_period: Max interval (nsec) between reads before counter wraps
> + */
> +struct ib_uverbs_phc_state {
> +	__u32 seq;
> +	__u32 rsvd;
> +	__aligned_u64 mask;
> +	__aligned_u64 cycles;
> +	__aligned_u64 nsec;
> +	__aligned_u64 frac;
> +	__u32 mult;
> +	__u32 shift;
> +	__aligned_u64 overflow_period;
> +};

If we are going to do this then let's re-use the mlx5 struct and protocol

struct mlx5_ib_clock_info {
        __u32 sign;
        __u32 resv;
        __aligned_u64 nsec;
        __aligned_u64 cycles;
        __aligned_u64 frac;
        __u32 mult;
        __u32 shift;
        __aligned_u64 mask;
        __aligned_u64 overflow_period;
};

So at least two drivers can implement this new uAPI.

Jason

