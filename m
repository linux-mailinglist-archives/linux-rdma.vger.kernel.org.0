Return-Path: <linux-rdma+bounces-21200-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id nBGCJ2inEmot2QYAu9opvQ
	(envelope-from <linux-rdma+bounces-21200-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Sun, 24 May 2026 09:23:20 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 00D6D5C1961
	for <lists+linux-rdma@lfdr.de>; Sun, 24 May 2026 09:23:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 14708300E3C7
	for <lists+linux-rdma@lfdr.de>; Sun, 24 May 2026 07:23:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 352362ECE86;
	Sun, 24 May 2026 07:23:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="CgvOddnT"
X-Original-To: linux-rdma@vger.kernel.org
Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011020.outbound.protection.outlook.com [52.101.62.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0CE4233941
	for <linux-rdma@vger.kernel.org>; Sun, 24 May 2026 07:23:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779607395; cv=fail; b=dNkdNJDQnjyC4Wg6HP4Ps6Sbm0Z9Z6BxQXRXCz00wrTYh8yOL2dxJM8AvZwBEHzbdkd/oNNq7hp0V0zSDnaWnh/VRBLl7e6Yudub0dD/YbcQNcC8L0lIIof+Zxz4v2SWZI0tg+JkgJZzj+0We0OEEwa52K2KjfXu28xyslF227A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779607395; c=relaxed/simple;
	bh=qKlL3BAyHzzJF2iyNK7wve1XIOlXZNYDBv6VrgIyKNc=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=tfGdda4tZfTx2gRRcwYYkRfPFlbauxHVuR+3nqeL2xehRE9ogoRu4UG2ASmEmHjloehYjCvDtGkq/7rUqX+VEMC0LGRdU6NVevC4VgNYJYnaCmMBCfGDWKVnd0YWl7VmKsXLltJmtbiNf0gz43gRfcxEIdP+IJBEb7WqaPSCXTM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=CgvOddnT; arc=fail smtp.client-ip=52.101.62.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mjRDQ+uGwXP4Bghz8OCQ86SqgoaKe9ZZMkTc766wqBn7Lj8wZm4XkJLUHPsYeqVmr9BXJkoPbiO9xyQVN1ND+GESV5e+2drvXbq5Ah/+A+CAr1R6g8iXPsvrckpHv9nGKqAI+HRyPhzR/n1iylRos8cHQi2TN4DUaXzHSg7Oonh5h7DuxGjfpuQEmzWtbhUsKBqGToC2WBDYg56UX/gS4hkdXSTmVjQD7XvLtbDp26jDh3c9c5deTOy64cyHjblwNS1uYoCyxo+t6eXtur1XgkPaCpt66jrQGfu4AtaSrBliXwpcToXECz7PM8iIrB/Bm0++kvTf8kxJUpcM5c8fMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IxAzNI8N3C5bWFILhC39lqgmuUci55X6cLDTcYNbDVk=;
 b=BdA4JSoQjYxbv7nkcl+Hsx6scVpaq5sMCmCU7rvG5MYlrRkW5bpdhfCyF/lAnjc1gJFrXDIw4H+E20oyDrVqJ+tpARq9bRlSO3TPM9oNTvY1kCQy/ns9um55bWM4ZcOSIRnwmxcfgGr5AnmstAEQ91W7Pb6Qxz9IcHTLAa0UUeY7oLF39WoFrd5V/KzMwLwIPECPwCdzkLO40n114ZiSmNgaYy1gVh9htqn2QaXKAj5IQMxxEwi1QdcZbrpw4lD5TVlqZhl7K8ACqkAjID0PPtxR+AHy2BwHEknigvnNZ45g/lZ5W3K21ogBZwqRrMxUZQ/6cdgt4/AbMyK5bITp4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IxAzNI8N3C5bWFILhC39lqgmuUci55X6cLDTcYNbDVk=;
 b=CgvOddnTA63jdXWUAXFoU5ao5tEWZ4lvFZi089/o8astOoCUuFNsUKxFp+ALYxayiZ5mofPiefEW/dcz/ncE6whRmkI9q1gBlEPQ4bgTv+cvjphyd9DgprdDGJII5tHItfiyzvjJu60SiMEyRk+lnGqMP+HJJy7Gfsy6Ajzgw9mdrh9ulwjlFURdiIwJYV05tc6wIN5KlCXEROyFIqB/IgUCDmOxmxq+e4MKNvuGHUEZkBpmrfxrvjKdiC5zF66UqFhdUd1uoZUcY/zPGiaxRaQH0As9bDhz+e/CB5JkgrsnmErmftf52aPe/DesztuFFD5b+KjVi71ImXqllxEpEw==
Received: from SJ0PR03CA0130.namprd03.prod.outlook.com (2603:10b6:a03:33c::15)
 by DS0PR12MB7747.namprd12.prod.outlook.com (2603:10b6:8:138::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.18; Sun, 24 May
 2026 07:23:07 +0000
Received: from SJ1PEPF00001CEB.namprd03.prod.outlook.com
 (2603:10b6:a03:33c:cafe::6) by SJ0PR03CA0130.outlook.office365.com
 (2603:10b6:a03:33c::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.48.18 via Frontend Transport; Sun, 24
 May 2026 07:23:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SJ1PEPF00001CEB.mail.protection.outlook.com (10.167.242.27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.71.7 via Frontend Transport; Sun, 24 May 2026 07:23:06 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sun, 24 May
 2026 00:22:58 -0700
Received: from [10.125.205.110] (10.126.231.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sun, 24 May
 2026 00:22:57 -0700
Message-ID: <e2a4adb3-4f09-4e23-bddd-e18e158342b9@nvidia.com>
Date: Sun, 24 May 2026 10:22:55 +0300
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [bug report] RDMA/core: Introduce a DMAH object and its
 alloc/free APIs
To: Dan Carpenter <error27@gmail.com>
CC: <linux-rdma@vger.kernel.org>
References: <ag68qoAW3P04J7pT@stanley.mountain>
Content-Language: en-US
From: Yishai Hadas <yishaih@nvidia.com>
In-Reply-To: <ag68qoAW3P04J7pT@stanley.mountain>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CEB:EE_|DS0PR12MB7747:EE_
X-MS-Office365-Filtering-Correlation-Id: 51e65ba7-2b22-4c8e-dba8-08deb9654cfd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|82310400026|36860700016|18002099003|22082099003|56012099003|6133799003|11063799006;
X-Microsoft-Antispam-Message-Info:
	Q+a0eW+8Q9rloBWrKlCtzNPIDcb642ucZv9SrPinNyFBJF5+81o8aOFo7yNib1HRU+HjmLP8G4FcZ05rDSB3bKFa2qHZgy0uFdaTlj/bYwp1yxKknf7jWUqV+3huHpy1OHGVgRX9I0by/nAuQRhlxwfCTN1SOGpR2YdQd15dpc+bmuIPvAu5mAwkU2hnxHMGm9e5HcXeggLJQLHn4cbzFIFBtyzStHr2ANGFwQ1zpHOnDemzZNj9j4UyIIU/8tJSccUazTJHejJjIoNzs1F27imLEKiUHdClKi56fEdyeOJpGOBxkSAoP57kLe0fQh3iuXpSrpXOpzjo5SIPiVeK60u1Yathow22V5AaXNYXqAKDZvy3fGgex17tXXHispBlf0FDNo+dY+Zg03+2jkT1G9vw+9dKayhLRDWxjO571UHk8quqxPAtUxuiybqMmtecZlZKqsvlhH5Aa8siMIyWt6R0T/rYPcGUMwxqrQ0vrKHraC2mJMi3dQMYBcURqV9UZtbVZPZVxATXRG6wkR/TNJcFmvqXFE39ICA05RiawSyiPT9/TZ6BQXjRCdxi/+zE7rpzTX6EI2AOAJEMVDMc4i+4NZZnjxTpM3oa32sg67KDNGxpUb/Vr7yIKjzcDM7R1bGvsC5AcIUapbpDMMKZo4y69iR3nEXwW9aHWp8ldqS85dKsYDvabGQDMkE5S9/bK+WZxMWBH7tZnLjFyABEkvkgNzwPMKRADX+qEYh7zz0=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(376014)(82310400026)(36860700016)(18002099003)(22082099003)(56012099003)(6133799003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	Q1TZkLeNot13zRFCgWTvKG0n3ysd79oJIjBT0l9D7IfNcBohTKw0mXLCTPpKDHqps29pdYc/QVyxClJ/PR6vq6woAotLsm4IrbIkRbvJ7Tx4Mdz3J2W92Wq7yogClM+J8t82BkguXYHFKm8MAMafAfyMWx1PhJwtPWJQoLMwbxD1XCnVJJtr+BEhomEYe3LyuvgTwxQQGgSWC2GZY5vLtgur0V1gUUU1Wdby2jSG7gvc6YVPtENdu2ot0esMdEm36M7ahBet0ZhPlwg8/95WiOE8yndXQcE3EqPCEqNW8S7a0lyU0ZKjY6dSaZ54HfmeP0vFYSRAjEqM1lIeh6CqgjOe89tHNsrK5QHl3zfRUr7w8s5B8kBqwY3FY42HjdeUsCcrru8KFIxYq07xJivjO8xJH69PKGJMnAmw7MatbGsrbab79hLyhQElwWVFQVci
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 May 2026 07:23:06.7403
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 51e65ba7-2b22-4c8e-dba8-08deb9654cfd
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00001CEB.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7747
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-21200-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yishaih@nvidia.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-rdma];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Queue-Id: 00D6D5C1961
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 21/05/2026 11:04, Dan Carpenter wrote:
> Hello Yishai Hadas,
> 
> Commit d83edab562a4 ("RDMA/core: Introduce a DMAH object and its
> alloc/free APIs") from Jul 17, 2025 (linux-next), leads to the
> following Smatch static checker warning:
> 
> 	drivers/infiniband/core/uverbs_std_types_dmah.c:50 ib_uverbs_handler_UVERBS_METHOD_DMAH_ALLOC()
> 	error: passing untrusted data 'dmah->cpu_id' to 'cpumask_test_cpu()'
> 
> drivers/infiniband/core/uverbs_std_types_dmah.c
>      40         dmah = rdma_zalloc_drv_obj(ib_dev, ib_dmah);
>      41         if (!dmah)
>      42                 return -ENOMEM;
>      43
>      44         if (uverbs_attr_is_valid(attrs, UVERBS_ATTR_ALLOC_DMAH_CPU_ID)) {
>      45                 ret = uverbs_copy_from(&dmah->cpu_id, attrs,
>                                                ^^^^^^^^^^^^^
> cpu_id is untrusted data.
> 
>      46                                        UVERBS_ATTR_ALLOC_DMAH_CPU_ID);
>      47                 if (ret)
>      48                         goto err;
>      49
> --> 50                 if (!cpumask_test_cpu(dmah->cpu_id, current->cpus_ptr)) {
>                                               ^^^^^^^^^^^^
> You can't pass untrusted data to cpumask_test_cpu() or it results in
> possibly a WARN_ON() (most people have reboot on WARN enabled) and
> and out of bounds access.

Thanks Dan for your report.

It seems that the below [1] chunk should solve the issue.

Would you like please to send a fixup patch having it ?

[1]
diff --git a/drivers/infiniband/core/uverbs_std_types_dmah.c 
b/drivers/infiniband/core/uverbs_std_types_dmah.c
index 453ce656c6f2..97101e093826 100644
--- a/drivers/infiniband/core/uverbs_std_types_dmah.c
+++ b/drivers/infiniband/core/uverbs_std_types_dmah.c
@@ -47,6 +47,11 @@ static int UVERBS_HANDLER(UVERBS_METHOD_DMAH_ALLOC)(
                 if (ret)
                         goto err;

+               if (dmah->cpu_id >= nr_cpu_ids) {
+                       ret = -EINVAL;
+                       goto err;
+               }
+
                 if (!cpumask_test_cpu(dmah->cpu_id, current->cpus_ptr)) {
                         ret = -EPERM;
                         goto err;

Yishai

> 
>      51                         ret = -EPERM;
>      52                         goto err;
>      53                 }
>      54
>      55                 dmah->valid_fields |= BIT(IB_DMAH_CPU_ID_EXISTS);
>      56         }
>      57
>      58         if (uverbs_attr_is_valid(attrs, UVERBS_ATTR_ALLOC_DMAH_TPH_MEM_TYPE)) {
>      59                 dmah->mem_type = uverbs_attr_get_enum_id(attrs,
>      60                                         UVERBS_ATTR_ALLOC_DMAH_TPH_MEM_TYPE);
> 
> This email is a free service from the Smatch-CI project [smatch.sf.net].
> 
> regards,
> dan carpenter


