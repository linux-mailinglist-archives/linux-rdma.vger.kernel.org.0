Return-Path: <linux-rdma+bounces-18951-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OPSgLZXIzmmtqAYAu9opvQ
	(envelope-from <linux-rdma+bounces-18951-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 02 Apr 2026 21:50:45 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 7646B38DCA6
	for <lists+linux-rdma@lfdr.de>; Thu, 02 Apr 2026 21:50:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 5F98D300231B
	for <lists+linux-rdma@lfdr.de>; Thu,  2 Apr 2026 19:50:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D18E3F1650;
	Thu,  2 Apr 2026 19:50:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="rZEfRnHi"
X-Original-To: linux-rdma@vger.kernel.org
Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010044.outbound.protection.outlook.com [52.101.85.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEC6C3750DB;
	Thu,  2 Apr 2026 19:50:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775159442; cv=fail; b=jGqmrJXhuXWrmMQ4kzRH0Y58GTHAgvlz6sLQDAJ6OMVLvGzl2NS7saBWbrufaDDU/y5Aril5hCM5uG2XFFCR+1ikUvoG4NEoN1lXLt8MUC8fWXBtDjcHWeeri26NdrLBIETld0+ssMU/sJAgEIs75GCymFDsM74Zh9iJzAjwB6s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775159442; c=relaxed/simple;
	bh=pAWqt9zYaqyeKADdnHcn4aLuQGAhHq4UHG3Oq/mbEHA=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=HR6F5o1POFu4qkEbi9Q1jAEXQ8NpnHwwf7UEVp0O3059/z5KILah66TqVyrUN0NzQSbqxA6M/yKyNrO7K+hOgSR6Knmr+IJpGyVxc79+thHCQJ6CM/aWg2cd+54Okydq7wz3FwkibVmTJPUWeMUNWiRNu7QA6sGDIrQYLPaqmZs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=rZEfRnHi; arc=fail smtp.client-ip=52.101.85.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XUUcpcw1Xrh8qKDvqsJWks4/6LBtz9lBOYkKukPrT2qhGRUxxoVbAtmoQxPLNQUjRimow8WgdLGVc0xvWR9tNDpp36L8PmO+RhuiirD5TQy7eqQGZyi7eKFPuFMwHuERwxo2H/haiJ5SqDHKhMwHf2K34Fi/vXQE1sIBQal/aBlAERusqBX5IpS7hFmjMaNrNSzaGKRkW6DuE67Ykf2F7dXuBzHt4JTk+L1/SJaxbOqmo2RGdZfzn9Sfdmt9PGtSc6X0enhq6iTpJ5P0fmIW6jFCrJtrwCAuBUGHhzG2RWGdkukZh/iLJHgqoqCGZTW51EpzF3xBS4sPV3aVjIlWNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E3z8QF47JWKY/7nFY7bjHW5lXvt2cvFt9jibFDrnj04=;
 b=LuoZVpd4+zeH+AeeJSvPZ4u7M8I6l+6lEquRkrm67JVvN4kL6CjYGvcWrgK4lsiEJ6ho4+93bAuN3/elTQaFIFmWCWhPXv8Lv4GikkDXgYc9rVHtqu+60+IGlS/zDbFfWZyCQKvlsST4xTADFYZ57CZrPzPCOP6eFjmY9Dnj/2xtvrP8Gf/bwdL5Cc/XKXT51rLqLnqIEM+NV6bL6VkkCUmCvTvWmLceF7R/pRG5WuegtRmKf4R0aJXuaAGlPmJZ4e17B7o0JDTLhMAZwAvj/temnfKz0peKVv39VkrKOwcdIg7XPLyHTin0HyYWhDbmk8qiRC1MjOcZMh7IQk9MIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E3z8QF47JWKY/7nFY7bjHW5lXvt2cvFt9jibFDrnj04=;
 b=rZEfRnHi3McB8v867qo7tObqMROR2t9K0ZM4a1PbkIA01hISyQV63j13huLaj4OMxFiOPXWSNJ6wvj6LX10HmMdjYBDmTCKQGFHTQXAd9beCP3zpqB1fvE/0kAYhnERwPqPY98L6Bp5RcfFtL0/PRw0fbi0z8f+cgWlrItVjT/+Y0Ww7YSi4AJrG4bGBMli1neprhVnLOHWUIpgnPfdmN8dpqdrQaaFcpuoRRYaH0Yn7ABEVMTKWA4gyTZSRoc0Xnb3yibD3yACSJnhEcm4bCDOL5EtGb6KhSLunl0YtJESN5MzzDRBqrBWfFMWQYFuL08/6PUgxFiBapKvNwRiJeQ==
Received: from SJ0PR13CA0215.namprd13.prod.outlook.com (2603:10b6:a03:2c1::10)
 by SN7PR12MB6929.namprd12.prod.outlook.com (2603:10b6:806:263::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.20; Thu, 2 Apr
 2026 19:50:33 +0000
Received: from MWH0EPF000A672F.namprd04.prod.outlook.com
 (2603:10b6:a03:2c1:cafe::f1) by SJ0PR13CA0215.outlook.office365.com
 (2603:10b6:a03:2c1::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.17 via Frontend Transport; Thu,
 2 Apr 2026 19:50:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 MWH0EPF000A672F.mail.protection.outlook.com (10.167.249.21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17 via Frontend Transport; Thu, 2 Apr 2026 19:50:32 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 2 Apr
 2026 12:50:10 -0700
Received: from [10.221.201.51] (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 2 Apr
 2026 12:50:05 -0700
Message-ID: <fa2e9736-edf5-4cb3-9d7f-a41f8172a1b9@nvidia.com>
Date: Thu, 2 Apr 2026 22:50:02 +0300
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 2/3] net/mlx5: SD, Keep multi-pf debugfs entries on
 primary
To: Jakub Kicinski <kuba@kernel.org>, <tariqt@nvidia.com>
CC: <edumazet@google.com>, <pabeni@redhat.com>, <andrew+netdev@lunn.ch>,
	<davem@davemloft.net>, <saeedm@nvidia.com>, <mbloch@nvidia.com>,
	<leon@kernel.org>, <horms@kernel.org>, <kees@kernel.org>, <parav@nvidia.com>,
	<phaddad@nvidia.com>, <gal@nvidia.com>, <netdev@vger.kernel.org>,
	<linux-rdma@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20260330193412.53408-3-tariqt@nvidia.com>
 <20260402030911.878500-1-kuba@kernel.org>
Content-Language: en-US
From: Shay Drori <shayd@nvidia.com>
In-Reply-To: <20260402030911.878500-1-kuba@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000A672F:EE_|SN7PR12MB6929:EE_
X-MS-Office365-Filtering-Correlation-Id: 0f964520-ffbb-4963-df2a-08de90f11a06
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|1800799024|36860700016|7416014|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	BOUeYgQ97gm2CzNUCbgSMbGmx0KS08LeTCIL7v3GL3foryV/TaTU9cfqKMx8o1z5kmCplkPSUWz1JRi3d1E2aPBJmOrzYgMEHagyenrkDliEMKDdE2j/0TLeNRe9sO2rBkNxOt2ow/MycKNHfneh/3dfWJYZamjb4y7URSPgGKKkiazHExbojpCOCinjCiHY0fRo9b9jQ8x7S4GOcquhMSnDyfavIaEFILUYgoYdwaYYiMmeiZFJ/h8PiZmubhvrgj+0WpyzfqEGHTZdiXW+BF9KoqMJC9/yYCuZE59NAjCG2gxECpJZrma+lOjHCRL6rFt95dCllXozaTVaX13MogiX/53TKtBBWzlFLrhf4FkBj4pACPVtQ4Vb40pO7ESTKs6JQl9aolVXJDXKHvAHmeCz9ml8C3gIG4fNxQzQTbUVFWjo9ZVvNDSDSxU2ddklPjD9pTsh7FrGPMTgJmJf/Ez+GTg3M5mMOtx4zJb70F98rN7x3+LZQSnOeueZETW8VhQmePLM7oRiMezgrJNLqItPPAXiBwpD5tEUg6iuHjOApcZDUgzcX7rIp8cyuhmjX1j40LEJizwr5qDsLXwqJ0kPSlnAriK+GnlgswlL/VSmW+/6HJihAbvxw2138eSxTVvnaj4wQ/NppriY1pP/RIMZZ2ksH1oDIbg3/HpDsI1ijj6+/Hg8OA7ZCViIDEHEBo4OK0yCeKf01bKZi5cEcZCjyCFI8nF+hBvYP9FAg7FQArsBa809Rfdtbk6vsRi0I2hWh8AMDsII7/LZX2bnDg==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(82310400026)(1800799024)(36860700016)(7416014)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	YQDJh1O6VT4h35ONPXLyjnMM9tHVMhslvlDdw3NFJpibi6V3omRdVIIrjAXjnx31vCTZ8g9k2LZfu7e/cjCF7H6XBt+lPswPDZ0SGAhoaUEN5SKY4BDGtbJeWDD1m9c24JLWskv0yk4oZenwNkBfiguV9KnWNeHTWHsN6JyuyST+OxD13lou/S0iLGpqia8LOC23Z7u210/yk0+Ep7WbRkoZxTlRi0zYfAh5ZaQ6yVoIBT/W9BrNysq1Jt7WTEtkoXqlKuL+nev79jtsNsTOYHxTg6rMiWHDMPn8VhF5FO4MohB+JhiFg45/fUv6qTKSHC9FvFA6a19QZK9Ovaj9vKEkDSIEF1rQ06oSGTUpw2fFBmm8qIHAIhSqbJfiY6IFaP9JCS+aHifzGEJHctr7uO93BGt4wrVZ5chM8XNApNLWU4zSm8ix39cEZcizZA2v
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2026 19:50:32.9812
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f964520-ffbb-4963-df2a-08de90f11a06
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000A672F.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6929
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[17];
	TAGGED_FROM(0.00)[bounces-18951-lists,linux-rdma=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[Nvidia.com:dkim,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,nvidia.com:mid];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[shayd@nvidia.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Queue-Id: 7646B38DCA6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



On 02/04/2026 6:09, Jakub Kicinski wrote:
> External email: Use caution opening links or attachments
> 
> 
> This is an AI-generated review of your patch. The human sending this
> email has considered the AI review valid, or at least plausible.
> ---
> net/mlx5: SD, Keep multi-pf debugfs entries on primary
> 
> This commit fixes an issue where the "multi-pf" debugfs directory was stored
> in the calling device's sd struct but created under the primary device's root.
> It explicitly stores the debugfs dentry in the primary device's sd struct.
> 
>> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/lib/sd.c b/drivers/net/ethernet/mellanox/mlx5/core/lib/sd.c
>> index 060649645012..4c80b9d25283 100644
>> --- a/drivers/net/ethernet/mellanox/mlx5/core/lib/sd.c
>> +++ b/drivers/net/ethernet/mellanox/mlx5/core/lib/sd.c
> [ ... ]
>> @@ -491,6 +499,7 @@ void mlx5_sd_cleanup(struct mlx5_core_dev *dev)
>>   {
>>        struct mlx5_sd *sd = mlx5_get_sd(dev);
>>        struct mlx5_core_dev *primary, *pos;
>> +     struct mlx5_sd *primary_sd;
>>        int i;
>>
>>        if (!sd)
>> @@ -500,10 +509,12 @@ void mlx5_sd_cleanup(struct mlx5_core_dev *dev)
>>                goto out;
>>
>>        primary = mlx5_sd_get_primary(dev);
>> +     primary_sd = mlx5_get_sd(primary);
>>        mlx5_sd_for_each_secondary(i, primary, pos)
>>                sd_cmd_unset_secondary(pos);
>>        sd_cmd_unset_primary(primary);
>> -     debugfs_remove_recursive(sd->dfs);
>> +     debugfs_remove_recursive(primary_sd->dfs);
>> +     primary_sd->dfs = NULL;
> 
> Can concurrent unbind operations cause a use-after-free and double-free
> regression here?
> 
> In mlx5_sd_cleanup(), the check !mlx5_devcom_comp_is_ready(sd->devcom) is
> performed locklessly. If multiple physical functions in the Socket-Direct
> group are unbound concurrently, multiple threads can observe ready == true
> and enter this teardown block simultaneously.
> 
> Since the cleanup code now operates on the shared primary_sd pointer instead
> of the local device's sd, the thread for the primary physical function might
> complete its unbind and execute sd_cleanup(dev), freeing its sd object
> (which is primary_sd).
> 
> Concurrently, the thread for a secondary physical function will dereference
> the freed primary_sd to access primary_sd->dfs, causing a use-after-free.
> Both threads could also pass the same pointer to debugfs_remove_recursive(),
> resulting in a double-free.
> 
> Note: This was fixed later in the patch series by commit 92528cec4e0b91deb
> ("net/mlx5: SD: Serialize init/cleanup").

This is correct, will re-arrange the patches so that this patch will be
after "net/mlx5: SD: Serialize init/cleanup".

> --
> pw-bot: cr


