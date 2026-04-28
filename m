Return-Path: <linux-rdma+bounces-19656-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gEGnLXrL8GkKYwEAu9opvQ
	(envelope-from <linux-rdma+bounces-19656-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 28 Apr 2026 17:00:10 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 124C648777E
	for <lists+linux-rdma@lfdr.de>; Tue, 28 Apr 2026 17:00:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E96BF3054F5B
	for <lists+linux-rdma@lfdr.de>; Tue, 28 Apr 2026 14:56:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A814A449EC3;
	Tue, 28 Apr 2026 14:56:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="MePA5gvY"
X-Original-To: linux-rdma@vger.kernel.org
Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010045.outbound.protection.outlook.com [52.101.46.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57C69301471;
	Tue, 28 Apr 2026 14:56:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777388187; cv=fail; b=Cm1iEWVQ1xYvf9kX1nxVr01J27NDKxLgTAEAGQHSyrsfKQqQJFGvq6q9sVPQMDfcO2CxZSsM0yMGDU4UgPx6hurkmZCpjQRNt+PrfAHPXOhF3+ZxlrPqEBcFf7Z4dC0qxvAIQWdeP/R09FAjosGqq0cGj/TPX7Yql3Ucdm2IHlw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777388187; c=relaxed/simple;
	bh=PIATJs6qATZShU9uCnPi0eun49d6KssBCXJjiMG8y3I=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Rne5RzY841Vracpz4foDobjqwmyznvnavXCL9MkXeMcBND3wkj4M+1WUgzBG5rSKWs+Ylh9sKe8wkxzNKbPrUiLky/hPXyTWMnNR7r/UdnR0EOxk1eUTqsC1XPg0F5w/JuoehJkvccfqu522quflVRSLELBqqNQnlAdi2KaM07Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=MePA5gvY; arc=fail smtp.client-ip=52.101.46.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pna01O9/iiZy9q2m/qhVFoDC07q+e/cN2Z6GpEwpulpt8+dp5Od/1oZG5kDdlB995cqebbpLcJjP/s69qte7PdO4+PnZanibr574MjaB3PAlqZBSA3wxsBt5Uw+9a5v1iEciJL+4ajOFGKItldrlD1Oo37ZQesBkQTYSYdx3cvAtSD2g3VnjMXy20ykoq2mj8g7r5ggPZ1CN4IXMsGpRF1+QQgR8H17wMHCQHWK+sEJJvxjgSJiUFs3mqkXfjQcw/tSR9LP30jO7RbX97VSBD3jLBiI6Gc0CdzN7yDNyiciMBhQ92jp2EGqQ7wOOBif6bHGmg+Jz85odJ1jea41h5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gMEvGa/3F6iMk7b2iR68auO+Fx8LYkFy3cLR1BD9aOQ=;
 b=ppC9xxmE8zKilpvYY2WFO8+9IeKVzkaGL5kriPhnwM9SsLnYuLtvF8YaDltUL/qzKRQ4Hc+rVmHkAPaKXRUEMimVM7InzBPCL7CCugQGO5Byesm4cseTq3Tpeh71frBLdDeFoHokzGbU+rLrWe8L/tadMQsHPEo2DXQAlzAzE53+KpW3wcov6nGUng4g2C0a4DO3CasMQH4H4/E+qKM66gpDEQSNwSkWlCFCh7S4gOnXQfePYqC0C8uC9/rb2Dhf0tQLR0nDUcYb6X92HZFh5XRgtN61DYK11QhPGUdwayst4NS9UPika6xJ7OpQyiXP6DVTOCOVRj/6RQ7xF7Qx7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gMEvGa/3F6iMk7b2iR68auO+Fx8LYkFy3cLR1BD9aOQ=;
 b=MePA5gvYAhTm98XnOfSvn1Z62rsReZhqorNr6ewhba/KjFOytv6tYxDg9npF6qXaumxX17uU+hq2NgrE1726yRj6+prLdSkZFJF/SJgqUV0dg5ZxxDuLwr3PFd8Ael2GKnOWYgWAD87CcLPDiSzV+tIPDEP9XT2S5+2j8PUngd+l1jEN+1s4hfvDfB7gZRtCVKLg3i/O4Wn5/qEvaoAI2L+5BP0hJXXaNLkO3cl3BRcaxMUkN7N9QxN90gvu1j8XKZm9Kuen7LK/VvrQm+jW+C67KfgD3Rtunv3vyugdS06hLM9/QtgNS+BMf1N3iM26jtAuIL9TYIW2MVY1/1ippg==
Received: from CH5PR05CA0002.namprd05.prod.outlook.com (2603:10b6:610:1f0::8)
 by DS0PR12MB7852.namprd12.prod.outlook.com (2603:10b6:8:147::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.18; Tue, 28 Apr
 2026 14:56:02 +0000
Received: from CH1PEPF0000AD7C.namprd04.prod.outlook.com
 (2603:10b6:610:1f0:cafe::5f) by CH5PR05CA0002.outlook.office365.com
 (2603:10b6:610:1f0::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9846.28 via Frontend Transport; Tue,
 28 Apr 2026 14:56:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CH1PEPF0000AD7C.mail.protection.outlook.com (10.167.244.84) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9846.18 via Frontend Transport; Tue, 28 Apr 2026 14:56:02 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 28 Apr
 2026 07:55:34 -0700
Received: from [10.221.193.64] (10.126.231.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 28 Apr
 2026 07:55:31 -0700
Message-ID: <4cdbb076-59c8-4ed8-b182-2ec644fd97e8@nvidia.com>
Date: Tue, 28 Apr 2026 17:55:22 +0300
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH rdma v1] RDMA/mlx5: Fix devx subscribe-event unwind NULL
 dereference
To: Prathamesh Deshpande <prathameshdeshpande7@gmail.com>, <jgg@ziepe.ca>,
	<leon@kernel.org>
CC: <linux-rdma@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20260425010107.19586-1-prathameshdeshpande7@gmail.com>
 <bc0fcb45-c3f6-44ba-9448-ce4a09fad49f@nvidia.com>
Content-Language: en-US
From: Yishai Hadas <yishaih@nvidia.com>
In-Reply-To: <bc0fcb45-c3f6-44ba-9448-ce4a09fad49f@nvidia.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD7C:EE_|DS0PR12MB7852:EE_
X-MS-Office365-Filtering-Correlation-Id: de47308d-aed8-4b0e-6fc8-08dea5364439
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700016|376014|1800799024|18002099003|22082099003|56012099003|13003099007;
X-Microsoft-Antispam-Message-Info:
	5Q9a/vC5jgh8hh3Hpq7eB65jVb8mrKWRSEcpRkJCR8juAlPBXZo9/cFofnqeELb+ZYyvn6dFtcgeaEX6A/2KonkJlZmPVqiCkyShllk1VT9FBbqjVqX0F4dOwbp+GB5bB4QPJ5NpspwUVBAF/wdKMBvo80OmuZSMMzM1Q6ILrMzcdtEU9sTueDAVmXKtZhj0NDVwI03WQvGFhm5CgGaWzqHiWWPfM6ngXj5I/JMBlq6VPVSNKs3ObsP6YMpBApVf/ti+dkHh3/h1pLnLH3FaqmHwarmPWRiUnISDgcTHhiEBl+BN+IobiB3BByrXwtcHCHwZnfD5eNz7RNDQTgSg0Qa8mYQt6ZtZQaYyLXAhT4A3j0x3kzArrmmPqmApwC0zFedTNhHh9vL0EbhiPW/CeR0p+DvoDqortnxO85XWCn9jx40TGtv1Y2BoRBzbZFyH5J7U06OmJwIVmJiKpBqTW+lGum4Jnd+XL6eTy1uLkDqkPRTwnCpQUb00OHq7lLsazkAznCqbVsEE1a4Cmwf9hSZmG6t/SGgskZBlcM+8dG1ZN/StyQyi7Dz2ZZNteqan491DGRniBMWjdnhnguB9C2FtPRk3i7oGGCbnPTGsVk6Pe71U+C8W5sZT/KLbh0LaMgOT8ikeKL+Vi07pEtNugZ5eaH8O20l+YvHSafk4QjU6bvOvYLgPbnwJmbAmPympLwm0BhzEIWTKnyrR3pnLp5BwSEOC5F2IT6n+sJtoaZ5oEjpUIcNQ3Y0H8lE5mObDpAHgoO+crDfG00C6Nqsvjw==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(36860700016)(376014)(1800799024)(18002099003)(22082099003)(56012099003)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	JOf1+JeApWzuKlRWsmYoB1iaDTBQb8nB7PqomJFlCt07jyZuDvGS9HVYkl4o4zFGNRyiWFtWTGusKqriTUoy1/mOsOYuuQSQ5aWnSPn7DAntz0GMsYXxbE2r94XXLalgdb3FvA09iuCpmsvTGnHWaDzEXp7e1OwPNTuiZoyJzorA4o4WoYeIHKpCcChB3Ix+OZ9sm8Z3SjnT6Hint5+E8hXsxFc8CwKuu4iRT+iYNGTeATC8v2qCx+Y9ubw97YpO+ms7bYRmJ3kdXv2rkcIEciMGDxUwtquy4lRT5PQ0gnkYqBE6A+Lo8BlsTrm0wWQPVH49zJ367hVRRX3Q5rvY9E6MM80MSpe17wov4twsgX/fQqqguIKM6APRfqobVMzKxFCxLTik/LlWemzmZpdbn77ECZ5bCIO7+mY6YBxPpha0DVrIo0OBaSoj9+NkmDO5
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2026 14:56:02.3020
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: de47308d-aed8-4b0e-6fc8-08dea5364439
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000AD7C.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7852
X-Rspamd-Queue-Id: 124C648777E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-19656-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,ziepe.ca,kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nvidia.com:mid,nvidia.com:email,Nvidia.com:dkim,sashiko.dev:url];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yishaih@nvidia.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-rdma];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[8]

On 27/04/2026 15:16, Yishai Hadas wrote:
> On 25/04/2026 3:59, Prathamesh Deshpande wrote:
>> MLX5_IB_METHOD_DEVX_SUBSCRIBE_EVENT() links event_sub into sub_list
>> before initializing the fields used by the shared error path.
>>
>> If eventfd_ctx_fdget() then fails, the unwind path dereferences
>> event_sub->ev_file in uverbs_uobject_put() and calls
>> subscribe_event_xa_dealloc() with event_sub->xa_key_level1 still unset.
>>
>> Also, if kzalloc_obj() for event_sub fails after
>> subscribe_event_xa_alloc() succeeds, the current iteration is not yet
>> tracked in sub_list, so the shared unwind path cannot undo the XA
>> allocation.
>>
>> Initialize the shared-unwind fields before linking event_sub into
>> sub_list and explicitly unwind the XA allocation on event_sub allocation
>> failure.
>>
>> Fixes: 759738537142 ("IB/mlx5: Enable subscription for device events 
>> over DEVX")
>> Signed-off-by: Prathamesh Deshpande <prathameshdeshpande7@gmail.com>
> 
> LGDM
> Reviewed-by: Yishai Hadas <yishaih@nvidia.com>

Prathamesh,

Please see the below [1] review note from sashiko on your patch, it 
seems right to me.

Can you please come with V2 while addressing it ?

The below [2] chunks on top of your V1 with a proper/improved commit log 
can be considered as a proper solution.

I would add in the commit log something as of that.

"subscribe_event_xa_alloc() created the XA entry exactly once (on the 
first occurrence of KEY_A), so subscribe_event_xa_dealloc() must also be 
called exactly once for it.
Enforcing that by adding a helper function named devx_key_in_sub_list()
and call subscribe_event_xa_dealloc() only once the last occurrence
being cleaned up."

[1] 
https://sashiko.dev/#/patchset/20260425010107.19586-1-prathameshdeshpande7%40gmail.com

[2] diff --git a/drivers/infiniband/hw/mlx5/devx.c 
b/drivers/infiniband/hw/mlx5/devx.c
index 3d1528b1c816..c2ae5a140471 100644
--- a/drivers/infiniband/hw/mlx5/devx.c
+++ b/drivers/infiniband/hw/mlx5/devx.c
@@ -1913,6 +1913,17 @@ static int 
UVERBS_HANDLER(MLX5_IB_METHOD_DEVX_OBJ_ASYNC_QUERY)(
         return err;
  }

+static bool devx_key_in_sub_list(struct list_head *list, u32 key_level1)
+{
+       struct devx_event_subscription *s;
+
+       list_for_each_entry(s, list, event_list)
+               if (s->xa_key_level1 == key_level1)
+                       return true;
+
+       return false;
+}
+
  static void
  subscribe_event_xa_dealloc(struct mlx5_devx_event_table *devx_event_table,
                            u32 key_level1,
@@ -2160,10 +2171,11 @@ static int 
UVERBS_HANDLER(MLX5_IB_METHOD_DEVX_SUBSCRIBE_EVENT)(

                 event_sub = kzalloc_obj(*event_sub);
                 if (!event_sub) {
-                       subscribe_event_xa_dealloc(devx_event_table,
-                                                  key_level1,
-                                                  obj,
-                                                  obj_id);
+                       if (!devx_key_in_sub_list(&sub_list, key_level1))
+                               subscribe_event_xa_dealloc(devx_event_table,
+                                                          key_level1,
+                                                          obj,
+                                                          obj_id);
                         err = -ENOMEM;
                         goto err;
                 }
@@ -2228,10 +2240,11 @@ static int 
UVERBS_HANDLER(MLX5_IB_METHOD_DEVX_SUBSCRIBE_EVENT)(
         list_for_each_entry_safe(event_sub, tmp_sub, &sub_list, 
event_list) {
                 list_del(&event_sub->event_list);

-               subscribe_event_xa_dealloc(devx_event_table,
-                                          event_sub->xa_key_level1,
-                                          obj,
-                                          obj_id);
+               if (!devx_key_in_sub_list(&sub_list, 
event_sub->xa_key_level1))
+                       subscribe_event_xa_dealloc(devx_event_table,
+                                                  event_sub->xa_key_level1,
+                                                  obj,
+                                                  obj_id);

                 if (event_sub->eventfd)
                         eventfd_ctx_put(event_sub->eventfd);

Yishai

> 
>> ---
>>   drivers/infiniband/hw/mlx5/devx.c | 9 ++++++---
>>   1 file changed, 6 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/infiniband/hw/mlx5/devx.c b/drivers/infiniband/ 
>> hw/mlx5/devx.c
>> index 645ebcc0832d..3d1528b1c816 100644
>> --- a/drivers/infiniband/hw/mlx5/devx.c
>> +++ b/drivers/infiniband/hw/mlx5/devx.c
>> @@ -2160,10 +2160,16 @@ static int 
>> UVERBS_HANDLER(MLX5_IB_METHOD_DEVX_SUBSCRIBE_EVENT)(
>>           event_sub = kzalloc_obj(*event_sub);
>>           if (!event_sub) {
>> +            subscribe_event_xa_dealloc(devx_event_table,
>> +                           key_level1,
>> +                           obj,
>> +                           obj_id);
>>               err = -ENOMEM;
>>               goto err;
>>           }
>> +        event_sub->ev_file = ev_file;
>> +        event_sub->xa_key_level1 = key_level1;
>>           list_add_tail(&event_sub->event_list, &sub_list);
>>           uverbs_uobject_get(&ev_file->uobj);
>>           if (use_eventfd) {
>> @@ -2178,9 +2184,6 @@ static int 
>> UVERBS_HANDLER(MLX5_IB_METHOD_DEVX_SUBSCRIBE_EVENT)(
>>           }
>>           event_sub->cookie = cookie;
>> -        event_sub->ev_file = ev_file;
>> -        /* May be needed upon cleanup the devx object/subscription */
>> -        event_sub->xa_key_level1 = key_level1;
>>           event_sub->xa_key_level2 = obj_id;
>>           INIT_LIST_HEAD(&event_sub->obj_list);
>>       }
> 


