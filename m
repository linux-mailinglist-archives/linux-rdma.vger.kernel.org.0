Return-Path: <linux-rdma+bounces-17812-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8Ef7HEgxr2kYPgIAu9opvQ
	(envelope-from <linux-rdma+bounces-17812-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 09 Mar 2026 21:44:56 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id F28CA2410AB
	for <lists+linux-rdma@lfdr.de>; Mon, 09 Mar 2026 21:44:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 325203038ACB
	for <lists+linux-rdma@lfdr.de>; Mon,  9 Mar 2026 20:44:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5360036BCC5;
	Mon,  9 Mar 2026 20:44:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cornelisnetworks.com header.i=@cornelisnetworks.com header.b="RtA1QC0K"
X-Original-To: linux-rdma@vger.kernel.org
Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11022078.outbound.protection.outlook.com [40.93.195.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 852F536C0BC
	for <linux-rdma@vger.kernel.org>; Mon,  9 Mar 2026 20:44:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773089089; cv=fail; b=s579a5fmT4xGJYU03QItRT119AtYwDAyQKKoCBgzj/E08fcKMhr3Ha+tp0g+jjkSZUrbgQ0X25qLmihvTT7EB/VI5zH4b0ZbK/Be4ZnoI2bqYkAkCUfbR7wRE4TbIAClRT51L4oGE7qEMgLWAbPRJoITaZzFKRk46arZIxgQA8w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773089089; c=relaxed/simple;
	bh=24lnUQONt5IOf0MadcyJnch2Idby7FjibxccjL40xL4=;
	h=Subject:From:To:Cc:Date:Message-ID:MIME-Version:Content-Type; b=lltfaevDPAYCIttHi7jTlnjHWmpxsTDFA4mqC2GbXUOBzv46pTrCTe3JuhWUBWFpQQ+GmO0S+hfl1N6TyBVVH8W9Yb7Tr/KpjApi2EfRBRWu+fZSRmo6ENNyNegTGm54/iApTO6tdh077kLo9wL+X7VEecMCmCfzsyncmbFYxvU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cornelisnetworks.com; spf=pass smtp.mailfrom=cornelisnetworks.com; dkim=pass (2048-bit key) header.d=cornelisnetworks.com header.i=@cornelisnetworks.com header.b=RtA1QC0K; arc=fail smtp.client-ip=40.93.195.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cornelisnetworks.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cornelisnetworks.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wyCTHnUrqB8i96CK0a7v0bX0Ei1fYOHERKgbKN9HmwZFFLrJjc5xCSUPjw7RFcglXVkbIokL/TutnWvS8zVbP1ldINISyQTlpC4W8SPQE4BCRaf8rW144jGZLLkg0yiBK/wNacJHAq+7pxDhcHP/GcZ8p1n+tmnjHXedKXxwtdKgsAWslp7EhJPlqkBs+RvUo/rehMAF7xghdr2GC8YPClplybwBNMaKxBvoYikyFfYk8HtqSIH92JoyFY9LXUKsGstLeic74VH/vlzxI2aHRVNXvq37sfq9HVzm9gRMFjeRWDc5Dr6EwUaoUh3rx8E5eapjnbEafHW9euvqnW+ZKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qZLKxi9ffotTPQw8UlrgwTix5646yqqczB+nYjT+KZQ=;
 b=KF2YzUwspFOVx+xKhfHXq9INddxPlVzSo8y06/+DjI1kfa53UACbVQ3xoZIq6sfI+D6mLG2ld5eoOnKIk/Y632G9rheAu4zydAaRmJVSipDCQFSrWDio5VKhZMWce1iemw0rmp6ayAZAPiHEmPUFO3v8AJJ3aTNscKNz8DO7IpYBcE20xUqkvw2c9AuRmvaaI0tL8j7pdPlJRfbB6DGPL1uaZQTf9V4PkccWpTYDa3jm1Susl/UOpmz49fT2C+nsFtVl+zDDyxPxdbqW2/IaRe3/NXYxxVyYCsGGeU+9jgfSvfFEzJGXBOmcGYyTorboBMNSR73rM13geTy7E9j6Kg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 208.255.156.42) smtp.rcpttodomain=cornelisnetworks.com
 smtp.mailfrom=cornelisnetworks.com; dmarc=pass (p=none sp=none pct=100)
 action=none header.from=cornelisnetworks.com; dkim=none (message not signed);
 arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cornelisnetworks.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qZLKxi9ffotTPQw8UlrgwTix5646yqqczB+nYjT+KZQ=;
 b=RtA1QC0KeKNlnIqWBWa3IbGgi7JmdDKDWDn6sI7wjZ6KDvQ29PNEVz7XK1Ec0gB5SvJ4S1B4Eo50dhnxtaaxAvIA8P+XClgEr7hA3Jnofd4jTXZg+0wyg2I601TAe0EZugIBWlK9f0XCAvpXQAHBjiv3ZnkiOk2Fv+t7D9OTj79jYpeW1zXVsAWr4qY9TWqQCGVk1M5BaG3zgxK5YhwnIHk5WL8HHRCPcGPMbEvYNzYZ+AVPjp4iI8Rez2bHFdXf31RPqKTa/tfjSmvAgWhM4pBjhdw3G246ecLPnIvL55EblCXj92ymaySnRQ6iLoj3PoyUOhU3WywkxZ6OtYSyDQ==
Received: from CYXPR03CA0070.namprd03.prod.outlook.com (2603:10b6:930:d1::8)
 by BL1PR01MB7553.prod.exchangelabs.com (2603:10b6:208:384::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9678.24; Mon, 9 Mar 2026 20:44:42 +0000
Received: from CY4PEPF0000E9D3.namprd03.prod.outlook.com
 (2603:10b6:930:d1:cafe::61) by CYXPR03CA0070.outlook.office365.com
 (2603:10b6:930:d1::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9678.25 via Frontend Transport; Mon,
 9 Mar 2026 20:44:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 208.255.156.42)
 smtp.mailfrom=cornelisnetworks.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=cornelisnetworks.com;
Received-SPF: Pass (protection.outlook.com: domain of cornelisnetworks.com
 designates 208.255.156.42 as permitted sender)
 receiver=protection.outlook.com; client-ip=208.255.156.42;
 helo=cn-mailer-00.localdomain; pr=C
Received: from cn-mailer-00.localdomain (208.255.156.42) by
 CY4PEPF0000E9D3.mail.protection.outlook.com (10.167.241.138) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9678.18
 via Frontend Transport; Mon, 9 Mar 2026 20:44:40 +0000
Received: from awdrv-04.localdomain (awdrv-04.cornelisnetworks.com [10.228.212.218])
	by cn-mailer-00.localdomain (Postfix) with ESMTPS id 9EBC014D715;
	Mon,  9 Mar 2026 16:44:39 -0400 (EDT)
Received: from awdrv-04.cornelisnetworks.com (localhost [IPv6:::1])
	by awdrv-04.localdomain (Postfix) with ESMTP id 861BC1810D6D7;
	Mon,  9 Mar 2026 16:44:39 -0400 (EDT)
Subject: [PATCH for-next 0/4] Prepare for hfi2 submission 
From: Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
To: jgg@ziepe.ca, leon@kernel.org
Cc: Dean Luick <dean.luick@cornelisnetworks.com>, linux-rdma@vger.kernel.org
Date: Mon, 09 Mar 2026 16:44:39 -0400
Message-ID:
 <177308892140.1279894.3475429390519673020.stgit@awdrv-04.cornelisnetworks.com>
User-Agent: StGit/1.5
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D3:EE_|BL1PR01MB7553:EE_
X-MS-Office365-Filtering-Correlation-Id: 940aeb32-2f16-4881-5024-08de7e1cafa3
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700016|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	7f7dP683oqFwE0DcC5oHNFc4nV2PQq70Q/AvtKW+yRfgmLrlv30SOv4VPdPRVAnHuFaroQ+r7ez5ZipJ6MYfosJN6l5LrXApOh8dZrYUozpoTr1/aCQ5PLAuk+WF6Jo6AtUGDaECQeVGgsVFZdP6R7CVIziEf0kCYCmcFzWccbvBd8KaE1PT8PV+NqiecgCE2xx/x7fTl1EVRBQt59sk7jEq0fUHA4yFZUy97tD2TOQO3HEQq3u4e2ZABidv2SX64++g78DSRT+BaxfScZI7jhfLuA6zpoo5e0XKmuSFoIQhYBTbFaL90LyTZ/KHDcc3Z8eNUEKQOWeMHRkxpVkdbiRW46ZZ2oUJLag9awmFq8dzkU+kthI8dvKXwqs+EITwMmWBYIGBEdW/SJf4uzGMdbcOU/F8EDFdnZzlEZ6mumLQ+b5Ik826LpfRtUWufL+6u2Ka5JWy4LFI5+mLxBlOB5XarZmS6zkW98yrLI4wvYnSEx1Su859x4NNy3XqZhV6jA2KcjYHNTanQkA6QNaYuhV0HHn4gBFdSR6RBsRdgvHZ2iiN5VI9VT8DhflgQat0CyPpcBX7l6+TG078hD+GzNdyRYkn2B74Veq7AmHG5zRq9SLdK3K2BuuZAlGNQ+S+fmBq+6yveKz5ZD2W0RFJ5nUpBGRfx1FSzMhiESksdaQRboIvQgaijlQme3GfdReb/VkpB/Xr4Vdbh3gqzVz08JvWbXYfcIvOQ1qHu2c6PWUgkdaLrQkybDaQFmJ7lI+HOvVgAI7K/G6mbuZUkgOmXQ==
X-Forefront-Antispam-Report:
	CIP:208.255.156.42;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:cn-mailer-00.localdomain;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700016)(376014)(82310400026);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	2Y9abNnPHbUPdmYZ7Lket67yHI6tqCP/5uwyJKK4ekbuY0qGIvLpAd1U94YHuaJp64lLtCmM/c0sEx2UnftaZvRMRPu0C+BmZ4jk7UIjrAncgfCEqn/Mc8LHROoaY1Alzrm7vd7m6JROWUBUUHomjNBeUQ6WNaL3FfAD2IuVJQTDkEKxhV7CFJ6sqIFFlrXnggmCRAzBloF5njBehOA/cJOvvgRrRBnBGxZqP+zyiSvt/v+4NJNNv6YwhxJwFfV9Bbu8pHIpNm2QKEWdhFEmBgHkQ8u69F1I4m7LxuOyI1HnMPaddMRrKXKCHdzLocMxkYykjZxtozo9oTlgzmeW/M4AL/hCxdEmhAulpvafeHiP5Me5XE2CyHjESgSWKfB4AZ5LlD+ZMoebxNCTckKlSL50IB7Y29Cj4bvu/H2qPu+tlDmqXBdhnMy1iCzenn2Y
X-OriginatorOrg: cornelisnetworks.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Mar 2026 20:44:40.2730
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 940aeb32-2f16-4881-5024-08de7e1cafa3
X-MS-Exchange-CrossTenant-Id: 4dbdb7da-74ee-4b45-8747-ef5ce5ebe68a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=4dbdb7da-74ee-4b45-8747-ef5ce5ebe68a;Ip=[208.255.156.42];Helo=[cn-mailer-00.localdomain]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000E9D3.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR01MB7553
X-Rspamd-Queue-Id: F28CA2410AB
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[cornelisnetworks.com,none];
	SUBJECT_ENDS_SPACES(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[cornelisnetworks.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-17812-lists,linux-rdma=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[cornelisnetworks.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dennis.dalessandro@cornelisnetworks.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Action: no action

These 4 patches get rdmavt ready for hfi2 support. This is being split out
from the previous patch submission [1].

[1] https://lore.kernel.org/linux-rdma/175129726945.1859400.4492277779101226937.stgit@awdrv-04.cornelisnetworks.com/

---

Dean Luick (4):
      RDMA/OPA: Update OPA link speed list
      RDMA/rdmavt: Add ucontext alloc/dealloc passthrough
      RDMA/rdmavt: Correct multi-port QP iteration
      RDMA/rdmavt: Add driver mmap callback


 drivers/infiniband/sw/rdmavt/mmap.c | 22 +++++++++++++++++-----
 drivers/infiniband/sw/rdmavt/qp.c   |  2 +-
 drivers/infiniband/sw/rdmavt/vt.c   |  8 ++++++++
 include/rdma/opa_port_info.h        |  8 +++++---
 include/rdma/rdma_vt.h              | 10 ++++++++++
 5 files changed, 41 insertions(+), 9 deletions(-)

--
-Denny


