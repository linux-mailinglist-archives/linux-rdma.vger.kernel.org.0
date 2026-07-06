Return-Path: <linux-rdma+bounces-22800-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id F2YwJSm1S2q2YwEAu9opvQ
	(envelope-from <linux-rdma+bounces-22800-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 06 Jul 2026 16:01:13 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D072711A3A
	for <lists+linux-rdma@lfdr.de>; Mon, 06 Jul 2026 16:01:08 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=Nvidia.com header.s=selector2 header.b=li7VZXSb;
	dmarc=pass (policy=reject) header.from=nvidia.com;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-22800-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-rdma+bounces-22800-lists+linux-rdma=lfdr.de@vger.kernel.org";
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E358A328507A
	for <lists+linux-rdma@lfdr.de>; Mon,  6 Jul 2026 12:23:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 885E442465C;
	Mon,  6 Jul 2026 12:23:21 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011068.outbound.protection.outlook.com [52.101.62.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23C8C1DDC33
	for <linux-rdma@vger.kernel.org>; Mon,  6 Jul 2026 12:23:19 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783340601; cv=fail; b=cCf8ivfYjfCi+V1YPkzUUpBwSoFbMEJTCXG4ssH39cHaix+IpBuy5mJJFFMdHrTD9JxEi2sVWD8MJIoYkPlpYGf+qV6BLq66Y4l8xE3ZSQhKJBVRwD9vIe64it7oVBSz6EE8cn3kfSSymkkFX96rcHuDnNyC1m6px9lkgJUeSL4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783340601; c=relaxed/simple;
	bh=mtY70HlrDqe9Pqh1zeXMSP9SHWR61EGyfsN36LlM4R8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Jbjwmi+rRVy1DKbRy/Wa3UQ7qTSrtPJe3wqXc6lyUQWa9yKBr+E+uRCV4RyAUBbzYxxAfxj+mlV/ADVCbN6dhXw32YU71Lg3+iFhX0nH2wNRZz38GM/wfl//CTIkY9M7w1ZbkETKEqx0DDmtLS8MTc8jLe4QWRGUlkfrmO/9Hoc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=li7VZXSb; arc=fail smtp.client-ip=52.101.62.68
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vNRbLjSCWC9f9MCSMwROy1HJLihfVJeQxzkCc7X+h4czJ9APUthqa50VDNiUePS9ZkDwF0zeJAC4vrnU5vJY2aEoHdUI8tctDShu0/SRykqB4gEg+OFAcfRuSd+aMnJcx5XI7RmfM6LzHSuI9/h4/5OMVBBHxMoqaUh9SAboJXIkRgnt3gRegHYrWWN01UBIUnISknU4iLEG9cBxTVz3BcNk3NhPO45MwGJkdJO3wUGyrQ99KL05zBhRNVrOk/nNZEtkiTn+JXjtd0APBElkRGEt5JyzlvYqgh/V2MehPvtY3aghmYR7+a4L0J8KAwEPXJUBrdxSnIcfMNxYY4454Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xxd2wC5d414j4aOww3rnWRTYvpzZHMDRjrlMnLvqynU=;
 b=l26fXJX/WhtnCtTA3MyUWtW4FvoaSX7i5iUfkrdMaJUnUe1Q8oWi9ari5mIG9SkgtlmYjS8gXrv5Z2SiFprCWdoAEakOBybZxVRh36T7M0x/0RER3hQy3d04/9N9yGTUsKtSckDlLsz4TZJBhZlB07umCLAVpAexmF2bVq7DjBX9qUKsa4w8OK/B+wvkwLIjZA9CFyLzF6iJp73bMFrHvWzsm1ZfmiLq8JsitUfMyvsXThY20xxb3PAvZmVbvBI07e8EGE/Yds3XrhU6MLDUDHHBon07OA1DyRoBSpQnbD0GalF69zdCP/DAYocgau6q4o7iHSnJOirwo40yYqSijA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xxd2wC5d414j4aOww3rnWRTYvpzZHMDRjrlMnLvqynU=;
 b=li7VZXSb3rswhoHVJ24ORZjrWqVxWDIrbqx0DPQpszwiRC8YiRbzvifbu4zAIhtAIg0wFs4nyt2mrzpF1NRsN8bJyZpiXTIPe1Ee0gNDRgcCbAXoX684e95w1lg3VZttHlNaFBtEwZ//ZrTVYSskzjzj7CST5WtQOoEViFaJ/duI/NstXlua/kQjOqlQ52sNTS1h1H1sr5nMAoZ1M8drymVSXoEaYwNi+EPKWiARNQkGAhDjafRkwgN96mEfhxPhc3ykGrdTUkImrj/WkESObu5fhO3OwQvfltenNW688pEfShe+gEdx7Vo1djSav86NqN0P5UpjtxMAxbDSwE43SQ==
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by SJ2PR12MB7961.namprd12.prod.outlook.com (2603:10b6:a03:4c0::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.10; Mon, 6 Jul
 2026 12:23:16 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%4]) with mapi id 15.21.0181.008; Mon, 6 Jul 2026
 12:23:16 +0000
Date: Mon, 6 Jul 2026 09:23:14 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Leon Romanovsky <leon@kernel.org>
Cc: Yonatan Nachum <ynachum@amazon.com>, linux-rdma@vger.kernel.org,
	mrgolin@amazon.com, sleybo@amazon.com, matua@amazon.com,
	gal.pressman@linux.dev, Firas Jahjah <firasj@amazon.com>
Subject: Re: [PATCH for-next v5 2/2] RDMA/efa: Add AH cache handling on
 create and destroy AH
Message-ID: <20260706122314.GB71454@nvidia.com>
References: <20260628133422.523230-1-ynachum@amazon.com>
 <20260628133422.523230-3-ynachum@amazon.com>
 <20260705133506.GF15188@unreal>
 <20260705140852.GA25788@dev-dsk-ynachum-1b-aa121316.eu-west-1.amazon.com>
 <20260706122007.GL15188@unreal>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260706122007.GL15188@unreal>
X-ClientProxiedBy: MN2PR08CA0021.namprd08.prod.outlook.com
 (2603:10b6:208:239::26) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|SJ2PR12MB7961:EE_
X-MS-Office365-Filtering-Correlation-Id: bf02d1e9-403d-46f6-659e-08dedb595b38
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|23010399003|1800799024|366016|4143699003|6133799003|56012099006|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	y+gA9BxxO4YoU7+07ScPmB/UMpzc2aCwUMzugoeKdrSRB3GFMbVa4aiQ/ZgozDoK4Y5vK26cK+h4dqkfZelRfZmUdoJyCKgIXBLqMj4sxP5mWH/x6+U2vaA3nj5uUZeG5XCldax1YuIHyRE4Oip44OfCmy678ZvJmtEDLTXK5l9rU2/z6vqmXAbe9f8fUeWnayRmEuOSYneiqBjsxHkyFMuznUHshpsSd/f7VjwQENyFGqy1tD38ZMjn8rIN5MkB6oySO7EqXh/+l9Yy8aYkDSJyyQRSNE3OMRwDACl62jYZhC6XGe1Dp6b5Xm3ySsE6l4Nr4UwfaMWJbNI4ASoXCOZ85d448Zoy/lHnwwROdb5v6Fc7QsMZAbJF75ZKPOHK8Cc8wLyfX6w9gn/3e3j+zjdoxnOiyOlXnNc9wCOepfTkahbBCEJAYziz42qNkeZYidU5iBDPMv6oSeK9a28iPwSOj58Zy6mo1Md1WgAxZTnTe86asBsih0xbUFPVz7oEYZsRlBzKutidByL92YKqRrtYZaitzMMgApM8vXN3LwU2E+84+CZXT/nIDuB1VQqoQ4A9LcwZlDNFrVfdI9hSz0K+ihvhwhAPsu4thAvS0b2gKz0Pot0jqV50OtO1I6yvmsuW7SH8qQqZ8xZcDymXHBFesxkV6S3dnbA07zNs2zE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(1800799024)(366016)(4143699003)(6133799003)(56012099006)(11063799006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?DSj7fvRQ6a1k3a3V3ENPSNPZ1dzyS7PCKQjKdFBEEnuhtzOcInPcbfbVMXpa?=
 =?us-ascii?Q?rrn76CTeJY8ASOK8tltwQ6sIoJKoU35+seU+GGbWHyotIyca+r5toyJho+6G?=
 =?us-ascii?Q?NNjexDpywgz4kBjA3Q5ruoKbDWXcZraDGHalvvLLRNnK6Qonp2S4y62aQrB1?=
 =?us-ascii?Q?BwpKdi6EBMgTCj8jVX4XJubiKiovpvCsYCM2fSXgKn4DtfyDJ006xXKjkOzt?=
 =?us-ascii?Q?omMo7SEOX2Gpt4lKSwoiqFUu5IICYQpdKKlxoJFMzRmPLEja4aQO34kn0C5G?=
 =?us-ascii?Q?bPD/OiX7ma5plI/lEQk70y8L1ARln2RaGrkGlNRl+12qcDYs+zsjHNUBpaaX?=
 =?us-ascii?Q?PcMGLBIIPcoC+3/aK8Slvc9z4un1/ck0ArRj6+W0urV2y3xD0fpLqE4/x8Sd?=
 =?us-ascii?Q?OIuF8G+Lmg1amd3KuDsOKz6Yam/OkV1M1C0JJ/IWk9dU687QwgRQelTBELWw?=
 =?us-ascii?Q?IZ/ACZ8RKj01N04KqsWXi/jxzYlTDYd7Wur9xncljYaDpu1OihC0ZbH2O9cV?=
 =?us-ascii?Q?hGtYR/maJxqJiW6EaHhCh8HDjx+iB7KZ5tV0WNRAkTMqd6IO0rDr/dbvG2PZ?=
 =?us-ascii?Q?ejni0gCjd0LneasxCKyloYnj588Om10bUkpsCTXiRl+U3OETMQOOj6pc369S?=
 =?us-ascii?Q?W9k0NyxAwPRAofkWwGJBi9HbLv2HjHHSDJxhHTC2Ddl+foXeVRjSik280etV?=
 =?us-ascii?Q?MnmrW2T3GpMAgyjaA8KyLO/NTp0lyI9Y2WLWdI3r6rET93InmmPTWvva89LZ?=
 =?us-ascii?Q?56ylxogPZ6EgdCWJrijzL79apX/ggNM2XGIsba98V5AlIg6AvwGDLwsVLjLc?=
 =?us-ascii?Q?BH+yYXbUR07ptv8yBNSeJ3hTCLZ6TtbRLdKKM6G0K833lIb6Jab+Mygv+Ixp?=
 =?us-ascii?Q?bCAtHqyVYqN+4P5ZKKKik2glVUprxEbBxPy6ATd/O6LEBgicQzqLjahcRsOH?=
 =?us-ascii?Q?RljA0I93Q5b5pQuzokHu++zYHm3YT2ud/M6KDMdRz/9m79xrg8xY4Ye24zfq?=
 =?us-ascii?Q?VleWQIJqLz6UXea7UiXyattzxx+k7m0ZMNzHHBts3/EHLzkYBlSJuh5EMpJj?=
 =?us-ascii?Q?NNn4yDbNXqol++G6sRyNbFQ2BMDK9WICAdQKaB+eNQaq8LL1lWVVNAykGEW9?=
 =?us-ascii?Q?/iOCq9ohC0A1z9HLto02+KmOIUaL5+vRXhYBSmggheeQENZvAiQNitZeDHlz?=
 =?us-ascii?Q?jwL21AY8fhXjlE0qPCNUO5LyfTrvRiq/cH/XH4ql5MVlNlgJRKOFXEpoWgSe?=
 =?us-ascii?Q?rczdWexvuaeL8NUVCnRVb1K8/5Gijbt5DJ8YmUX0GJ+mBnGG2p+aCwkNCNBn?=
 =?us-ascii?Q?l+nf5QOirabcgv1Tbh/1EiHKeHsiW3J4THK1y8+CtMMBC1syzrnUUTda2tue?=
 =?us-ascii?Q?H/bnCkXBvPl1ZI8q3v7YQ9wGiCeavr8YrfSJxH4o1fhepe4lCITQYmq6oCE/?=
 =?us-ascii?Q?Il9RbU62AKTpRf/CFQbM5XnUIFk2UNKgtV/4BbJVDYHX5Et6hDzO7yQnzm0x?=
 =?us-ascii?Q?U0sI0KPAcHMP98XQ999OZB07U2RSYBkfCjAUGcE7sxfF3i9zpPW8nlSNpHD0?=
 =?us-ascii?Q?9sbDkCreEf2LYYYRhQ3GVhGbDH69wKFoXEzQMdcKQoSyUd8nZgqdohaxnE8T?=
 =?us-ascii?Q?W6yHSY8Llu0o/YgiEK56YwhoG76eTd5fSrfmk4Wf0Kh2nfAdOPDtRK5HxZCc?=
 =?us-ascii?Q?7VozUYD6Pwwsu2mt+XRT0+tVubFtG8TE9b2fg/h8f/fc8+qX?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bf02d1e9-403d-46f6-659e-08dedb595b38
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2026 12:23:16.3805
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /j5Zxw1PC/pY08TrfUktmbk6Ds8MXQoGUol4YzrkXBn0VsckTLoXPPMxfAyZfol6
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7961
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-7.16 / 15.00];
	WHITELIST_DMARC(-7.00)[nvidia.com:D:+];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-22800-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:leon@kernel.org,m:ynachum@amazon.com,m:linux-rdma@vger.kernel.org,m:mrgolin@amazon.com,m:sleybo@amazon.com,m:matua@amazon.com,m:gal.pressman@linux.dev,m:firasj@amazon.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[jgg@nvidia.com,linux-rdma@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	MISSING_XM_UA(0.00)[];
	RSPAMD_EMAILBL_FAIL(0.00)[linux-rdma@vger.kernel.org:query timed out,jgg@nvidia.com:query timed out];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jgg@nvidia.com,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-rdma];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sashiko.dev:url,vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 3D072711A3A

On Mon, Jul 06, 2026 at 03:20:07PM +0300, Leon Romanovsky wrote:
> On Sun, Jul 05, 2026 at 02:08:52PM +0000, Yonatan Nachum wrote:
> > On Sun, Jul 05, 2026 at 04:35:06PM +0300, Leon Romanovsky wrote:
> > > > +/**
> > > > + * efa_ah_cache_put - Put a refcount of an AH cache entry
> > > > + * @ah_cache: AH cache
> > > > + * @entry: AH cache entry
> > > > + *
> > > > + * Drop the refcount. If it reaches zero, remove the entry from the hashtable
> > > > + * and free it.
> > > > + */
> > > > +void efa_ah_cache_put(struct efa_ah_cache *ah_cache, struct efa_ah_cache_entry *entry)
> > > > +{
> > > > +	if (!refcount_dec_and_mutex_lock(&entry->refcount, &ah_cache->lock))
> > > > +		return;
> > > > +
> > > > +	/* AH cache lock is held here */
> > > > +	rhashtable_remove_fast(&ah_cache->hashtable, &entry->linkage, ah_cache_params);
> > > > +	mutex_unlock(&ah_cache->lock);
> > > > +
> > > > +	mutex_destroy(&entry->lock);
> > > > +	kfree_rcu(entry, rcu_head);
> > > 
> > > Where do you use RCU locking in this series? Why do you call
> > > kfree_rcu() instead of kfree()?
> > > 
> > > Thanks
> > 
> > Originally I used kfree directly, but changed to kfree_rcu in v3
> > following this Sashiko review and Jason's comment:
> > https://sashiko.dev/#/patchset/20260512061121.2177521-1-ynachum%40amazon.com
> > 
> > If you think its not needed I can delete it.
> 
> I'm not sure you're using the right data structure for this task.
> 
> An RCU grace period is required to ensure that rhash has been unlinked
> from ah_cache->hashtable, since a concurrent lookup may still succeed in
> finding the deleted entry. 

It doesn't look like this uses RCU for lookup

> The problem is that the refcount has already been decremented to 0,
> and any attempt to increment it will trigger a dmesg splat.

Sashiko claimed this was for some worker thread internal to rhashtable

Jason

