Return-Path: <linux-rdma+bounces-22293-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id uLvALKjoMWpsrgUAu9opvQ
	(envelope-from <linux-rdma+bounces-22293-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 17 Jun 2026 02:22:00 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id A80DD695D76
	for <lists+linux-rdma@lfdr.de>; Wed, 17 Jun 2026 02:21:59 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=Nvidia.com header.s=selector2 header.b=PcCr+akS;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-22293-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="linux-rdma+bounces-22293-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=nvidia.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id B8C0C3002922
	for <lists+linux-rdma@lfdr.de>; Wed, 17 Jun 2026 00:21:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73B0672627;
	Wed, 17 Jun 2026 00:21:54 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013011.outbound.protection.outlook.com [40.93.196.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04F9EEEA8
	for <linux-rdma@vger.kernel.org>; Wed, 17 Jun 2026 00:21:52 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781655714; cv=fail; b=pBMQR5p7jP6S76NHycil7wnuZzWNVOSXHDyKQvhHU6W/8xELoEvWvpgPjnubcebe6OBSQH4qTVqUfHNkR1g2MoRwQl8p9WxiECixdC+4O367EXUywuEYCj1DMKI4oYada2AeNRHjIO+wBKueXLEBpCYPhwIZ9vBUEXm273B/kdw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781655714; c=relaxed/simple;
	bh=ZZnFBDO4ZfBSP8K/YcUKwGYOikGduK7r36M1tBsto0w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=sYLbsvL1nBIyfCypZ8bAqmX05lJfBIaBAM4kyBT8S8MNcbJ7P+AhGJwxHg75qVIn6tRVvTTM8LYxqX4twEwUSz5sIkGrq2u3ub4oo02ch3DuG+2fgDqgjcB1Hf8kWERvvMjIKRBVm6O5GDwarP4S0yf/SOM/H02ujLby12d8z4A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=PcCr+akS; arc=fail smtp.client-ip=40.93.196.11
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rUohFhO5RyLZJ1iA2fr/3sjF+MjkSeGG688xy2Q7dq9y9KN34QFufcFRgtt+5NMKpu14ziabKPswFaeMRvu3zDWeBaDXs7PO8Hdl8JlXKiyGBsE6v/XpmoBrMhfu+kzX7FIK8ddfP9jcDuaYZivTqVTUGDPKrgzdr0XzwL0rnY8tG8/XaCBQfPq468Gac1+p/UKoHhD4VDhs4OANQDGdW6tq+pcFc5R07yOJabXuBvzq07hs+Dr6B9xG4WoAkRdsAM7X6/82O8cjN+vQmqAiR3P24FihFLvosFVOh79c0SJxHKOFTFMX26tPsfR1Ga6ozzlf3y5qiT/UoU9Riq6EBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LPABaYQNJeG9kxxxlF/lDRVxWjmRH8nV90oBTIIaF8Q=;
 b=fwWvf9VoHvBH+GyPH+9ymiZIvLOBx7py/h0kGyQ7sKSCRYZl4C5V6nQYGB+QKqdqSKj5jK8hVMXWfRDLxUK/VM4OnDQcqMF7mPGFZYl/AeJRBZNbCeKDoa2cqMH0lyX/MqGkmAZdJgUBMOm3SDL5tvud3m9lY3H9rddvB0Xs7NaFqjsBdFLD3sw4u4TpxwJv4fBXxTL0hxgazUC0KeotCtT69jIxqJsKYNU1v6NPwXb5xgPjYpqBTb1uM8NjRPVHqmP3lObqoY6jJZYyJuT8t2vhRHg7uLFlP+e5ltikEQnVn/DJ8w4uclJFuznRnHo6x11lk98bPpxq+ni6EcOEGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LPABaYQNJeG9kxxxlF/lDRVxWjmRH8nV90oBTIIaF8Q=;
 b=PcCr+akSbkqAwFfeJVbGZX7QNbmerUxd0l+97gRFBdIBYn89QTw85ILNoV39w2qiT8sabINlPfo6EktYAtl9TH7pkac9EEE1Y7h6H4jgBBmJHXm45W1knfgy1dbBEFCraFVAs9Gkf94ax52T6BHQTNEwCgk+Vpo/Do4gJqySr1j58bc2/v5x2RgfA90MJSPwR9uMZlw5I0QhK/3rON2cjPfMArYJtEV0ucnsWfypgZZEr4/xYDB8g2L5+vNu2nEde/n1IuVR6lOnt8CZ4LB8MlbdKlMAycdEd/W0TX395H6oQRs5Mv5B5vzdaq9tjva+t2OUFnbygRejq9mMhcwLMA==
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by SA1PR12MB8094.namprd12.prod.outlook.com (2603:10b6:806:336::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.15; Wed, 17 Jun
 2026 00:21:48 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%4]) with mapi id 15.21.0113.015; Wed, 17 Jun 2026
 00:21:46 +0000
Date: Tue, 16 Jun 2026 21:21:45 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Yonatan Nachum <ynachum@amazon.com>
Cc: Leon Romanovsky <leon@kernel.org>, linux-rdma@vger.kernel.org,
	mrgolin@amazon.com, sleybo@amazon.com, matua@amazon.com,
	gal.pressman@linux.dev
Subject: Re: [PATCH for-next v4 0/2] RDMA/efa: Add AH cache for AH reuse
Message-ID: <20260617002145.GB3577711@nvidia.com>
References: <20260608071620.1909543-1-ynachum@amazon.com>
 <20260614071229.GA29713@dev-dsk-ynachum-1b-aa121316.eu-west-1.amazon.com>
 <20260616175033.GQ327369@unreal>
 <20260616193158.GA35672@dev-dsk-ynachum-1b-aa121316.eu-west-1.amazon.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260616193158.GA35672@dev-dsk-ynachum-1b-aa121316.eu-west-1.amazon.com>
X-ClientProxiedBy: BLAPR03CA0166.namprd03.prod.outlook.com
 (2603:10b6:208:32f::18) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|SA1PR12MB8094:EE_
X-MS-Office365-Filtering-Correlation-Id: 34ccf6d8-e679-4a86-3e50-08decc066ac0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|1800799024|366016|56012099006|11063799006|3023799007|4143699003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	Siz7BbpYMVQ6b1/cawCJTH3aMxAWMDS5HmLTro86PvcKyLVFCEUzroqrNCfREemJqdKw7pn4jKhyWsYTgUwxX0ky40Pgs5n25md1r5CG4RisflAoH14eXyi5bMfeugQXbTQnbBJ8R0057/Zy+BTkc9JcBjllTd7yWMc77SCbzbOhGYBjhFhL2rIk396dLSqxRJyaAGCfGZdX1W5qmIlvuuHlEuN/BEuzdARGoRXGWO0+TXMCLyrs1kqiAAYE6JfIZwiNSrkUm4fG1YgDqz8LNwVWi6NaHQR8mbeV3qFUFem6YqwM6bcCvBZiNbJgXdcN1g3PCjwqBDKv7lfEs8MRICc8Q/EgBw2Efz39Xp3sdzmUCs0C5E9mguVmcbaiihTOkG8ANH3W1km2lhLSINQlsut0qGTDcFF4sUdKDurRo+stCdomTH2VP4xflt79uoJ1WyXPIDQzDFdpWzBx+JmQM2XVGDdoKH5LF6w9PTpbn5fIalWhoNRuIY07wt0X5SA394MEdpLExqqzCcVUTTyjVwNPePqNi7slMUkyljuKKWzIzuaE/jTkJ7g+8esOcyi63LWaB/nBIupqh+NGZL0RXgryYhjvyT01rA28v6XoeCQ2mEF+Go5eeCpRCHcLx9cueQ/sQDEQFMC6YCxTK4bbeWhlMfptRiuT1b/M7tRNVEhH2zNiNDmLFjVoYd7206bk
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(56012099006)(11063799006)(3023799007)(4143699003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?FsOcJGjkejd1TNZoi3CPOy8J3BIpL6xgW/+uybHH3/blD0Vlb3Q7OiBQvkdT?=
 =?us-ascii?Q?D4GWtVKnUVmGX3Q+Qw4gtNs9MH/i5JZ95LjxQb7upU2ystGiwo0QSAbxiUHF?=
 =?us-ascii?Q?6lIZx7iTvOKTWDb/X0vXAUCxkic94liqtiTHglz4iXhbxqjUmEIGsWKp3VPj?=
 =?us-ascii?Q?YoJVSyaF4A2oZIrHFc5s532GvUdXIv4jtc6PHazykAQcW69q+R4QFveJ8pPW?=
 =?us-ascii?Q?hj5ue1fzhPbnMI6ms/8eJ4TLY6CVFh42+s9ZVw9UjxXgQeoy5ddNaHiUegE+?=
 =?us-ascii?Q?Xyvz79fm6BQkqIFm6nAedb/4YAraKx9ZE4uVLv8psfU8aOiautpNZToGpvSE?=
 =?us-ascii?Q?QN00aQ8awyNiNTTlaArFmushtGEVcWumC+vWPvmamqNXUN35E4hYYoje6tdE?=
 =?us-ascii?Q?CB/2K26e1mQjO0l/lFehj3kPFsOgs9YXlcm25DoDKeGcGcEn6+gaYc+0m1BN?=
 =?us-ascii?Q?01DGt8Qah6dDue1kFeMVPDm0aadPYLw5QsSxkyTO/BIATRlsoEN+Nv+ciPAR?=
 =?us-ascii?Q?WEp2daysgasuIuSsvidKt2A0RQd0Bb2KfLZzTJtlJxPyXs0UbtzBwtJMzaC2?=
 =?us-ascii?Q?1/Z11gtcziPeIQyKK65kbLkQQuquT9v6HbjO/iNUsb0lBpBJ2amsw7FSELVa?=
 =?us-ascii?Q?kddpoYhob7Iuq7rQkLY90lkcvhTFCDI7XS17vsqRXZ3Fv78KdUvZZUrXMOtj?=
 =?us-ascii?Q?CrGObZgQE8nuJt2CcD9WwInq2s62AwCkjrr1paRHzqyAmnqPtyjmmvKe8q8t?=
 =?us-ascii?Q?Qs3Px5lwhvG7e+j3I/2ePq0vEVkpAkxB/Kj9XBmsrxqYrXcKHMp3vBJHyrB/?=
 =?us-ascii?Q?X6IgJNtB8x9svAzf5woLPJxWBvtBHvxiwXBU9DtdndCB/a7LlILjkyEHnP7+?=
 =?us-ascii?Q?jLJQG66XBFSIRPsBsHJnZKCw0bzATfyq7JWgrGDtP0JrVL5i3qp1BwIODl0e?=
 =?us-ascii?Q?cIgFDsWeaDQqV+92QgkSDBn6J+vfRIQSDd1761LjVvUyS4hThEN0IKd2ZfN7?=
 =?us-ascii?Q?jvVfjX2e42SLl2igkRvgo5JmJoMuojTXwi1SZjE3w/HapkSoNKRf+sJGnPyy?=
 =?us-ascii?Q?DyEnoh6BqdEAWXuWLBPCSkeLCmYQoxpndcHOhmhCkeL9MADsgoq8SYLTV+qf?=
 =?us-ascii?Q?Jad1LuXBYvaBEkLBeBwEH3SyejMtK08s2JnkInGgQVfysZL39MHMih+P9OI0?=
 =?us-ascii?Q?ViejRXAqO5YXS6QlbKtZ74JCLIJh32YOi/xGoeF3DYA9c4z/GbPoQidtL6Rc?=
 =?us-ascii?Q?fvna7i44fUrWQ7+gMxNxu+cUle65ArVTIRVf+L5vPPmumWjJdPbSbXPs2uif?=
 =?us-ascii?Q?S/4XSQILobMVVe67V0h89JvxHUhOPhl9H4PY1WiTYoj87mISwXAsuwO7eF4N?=
 =?us-ascii?Q?UGULZqXfOP+fqLVIoc72SIqUJlOCAptM8Xu5Tt6v9Kj+s4llFS8u+b+jxlOX?=
 =?us-ascii?Q?RgRhdZTwbhnZgDTkzxRWqYfkyvcVPNVqg3aXMYTeJO//2qCLHaYBrvhGBwXz?=
 =?us-ascii?Q?UPjjA/53VlqC1/IEZ3pDlLbsoTEXKG5MyZL/WSI6wm979KIo0srBeDyU8Kha?=
 =?us-ascii?Q?EiU5ZxhXEBM+/mPD5Me6KSWnyCZ5CRxgllkAGiC2soUWTGAEOAgTnT6qUv5v?=
 =?us-ascii?Q?sE3d7Bu461zFrhIhzTw1w3gsLgqOJtcQditLLcv1qEabjb4tv4GNTQoWQpJ3?=
 =?us-ascii?Q?MaaUrsaJwWmOoWVp28kc9wyXTzxsudJ2jt7l4OP2oPWtlKvH?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 34ccf6d8-e679-4a86-3e50-08decc066ac0
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2026 00:21:46.7525
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: p25hXQsY+b18QTYxs7nJUCzDszMNQARCQyrfL5OImTZeLU5ZXQhPSAXJ6oJdATy4
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8094
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-7.16 / 15.00];
	WHITELIST_DMARC(-7.00)[nvidia.com:D:+];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-22293-lists,linux-rdma=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:ynachum@amazon.com,m:leon@kernel.org,m:linux-rdma@vger.kernel.org,m:mrgolin@amazon.com,m:sleybo@amazon.com,m:matua@amazon.com,m:gal.pressman@linux.dev,s:lists@lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-rdma];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,nvidia.com:mid,nvidia.com:from_mime,Nvidia.com:dkim]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A80DD695D76

On Tue, Jun 16, 2026 at 07:31:58PM +0000, Yonatan Nachum wrote:
> A global AH cache lock would serialize all AH commands for any PD-GID
> combination, including the ones that go to the device.
> The per-entry mutex allows different entries to issue device commands in
> parallel while only serializing operations on the same entry.
> 
> The initialized flag is needed because the entry must exist in the
> hashtable before the device command completes, so concurrent threads
> targeting the same PD-GID find it and wait on the per-entry mutex.

I think it looks so weird because it overloads the refcount in two
ways.

The scheme really has two different orthogonal ideas:
 - A kref which manages the lifetime of the entry and when the kref
   reaches 0 the entry leaves the hash. The entry is basically just the
   mutex and a user count. The hash holds a guarenteed singleton
   locking point to control the HW object creation order.

 - A user count which counts how many active AH's are using the HW
   object, and if it is non-zero then the HW object exists.

The combination of the refcount and initialized is overloading both of
these different behaviors, along with the funky refcount logic.

But given the initialized costs as much memory in the struct as
another refcount you may as well just replace it with a proper user
count.

Then it is alot simpler. 
 Global lock, do the search, get the kref, unlock and return.
 Local lock, check the usercount == 0 and allocate HW object, incr, unlock.

 Local lock, check the usercount == 1 and dealloc the HW obhect, decr,
 unlock. put kref.

Ideally the kref put would only grab the global lock when the refcount
is 0, but you have to be able to tolerate multiple 0 kref things in
the hashtable for that to work.

Jason



> 
> I am open to simplifying to a single globlal lock if you prefer, but it
> comes at the performance cost of serializing all AH commands.
> 

