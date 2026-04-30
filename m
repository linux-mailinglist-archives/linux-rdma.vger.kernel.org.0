Return-Path: <linux-rdma+bounces-19787-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QEqtHUdU82mLzgEAu9opvQ
	(envelope-from <linux-rdma+bounces-19787-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 30 Apr 2026 15:08:23 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C14144A32C5
	for <lists+linux-rdma@lfdr.de>; Thu, 30 Apr 2026 15:08:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B25593058CFD
	for <lists+linux-rdma@lfdr.de>; Thu, 30 Apr 2026 13:04:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A20F540FD98;
	Thu, 30 Apr 2026 13:04:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="i2GxuxXr"
X-Original-To: linux-rdma@vger.kernel.org
Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013033.outbound.protection.outlook.com [40.93.196.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 789601E8342;
	Thu, 30 Apr 2026 13:04:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.33
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777554248; cv=fail; b=Wx6nx589UMIQaOD2av5X7esGtYA2BdvAoS08svCXXtkELMKbTMIhrAUd4wDQB1yze9JEEvraDw73I6MnzyfWkkVHJC9tqL4dVVyEHOHnhujNJ8QIg7RkYiAyg+u/d3LjNsiS4DVgk9P9FOgSAPZaAMJ5kkPZFdafUAA1GN46CJE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777554248; c=relaxed/simple;
	bh=oH3dei3axeEtcsWFeukD6SB1HUdcBz62qMbkNUAAcUk=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=PkTwPfp2B+JHnfCx565V+sXNl6n9Nc2KlGSsF0xWd+K827kNl2FdnjJv+ozW00l6ArJWa82D4A3vMytZlCIoQ6dsWLDAhULpGqeyzuS0T4Y28oJ4m/BB7jvEjG4hk2ckbA1I2xvsCClwN2tSuy1kECwZ1fN20Dz355KBHeVOeS8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=i2GxuxXr; arc=fail smtp.client-ip=40.93.196.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TNrRAllhbVnnSxzHc+EjfGczcOqQuHlziwPNK3KczVBsa8SbRe4Uox69676MGYJYJiKBynjnKhvTBFnrepIgRhN21eTp7Rm0a7lqtT+BJkr2J6vIbp6ln+t6rt5c/gUHET7oUCzOjuruqOhrvJEwcEZ3YN3qy7nP/H6xJhoAD5K/32OnFeHHaWMIGx5Ct7nACUA2yVypk+1zO++ytYVeKSo2t8vY8STs0DLlQ2uBCb3gIykjkKYfr+46g+mOY84F+11xtq2ygH2YpxWCigTorEVana/Mncllfphcn1wMTMmin2EQ15/OF8Kek7rUg/GgN2iqFeS93svHTjSHYbu7Jw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IgXTASe+gxo+s+EWVadPHTdEFOMVrOQqyqJ3tF37x3s=;
 b=feAHKyEYF60S29cz12kPzlcX6Lb8owlAl494RJmxkgSXHMuUfTlB6k2z+onc2HHeIJFDdX4OaVQ2llJoF/JO2aTxYqskN1XGDTkxXB3GT+Z1ErI4KBumKe3g4ZqVA/6+JsWhdXzRG7ZFOAcOp7EvcHH60LpUV7Z5XfCotr8ph7ql9fuxLRVE+I7N32uKh8OZTmoixx+lkitjRE+Kjz/+OgiuCV5XEjc3mw4Ke0LIRPBRJ8GNdVrPEA1RYSCHdNecmuuD2fhhjwI6CWQTseQsRhz/AZjIvtxlpep4H4gvADrxuG7bRGWdQoqIwiYklGb/SQinrg6IQDW+v9C3xhm/NA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IgXTASe+gxo+s+EWVadPHTdEFOMVrOQqyqJ3tF37x3s=;
 b=i2GxuxXrKnVkdiJQV108s9DBc5yrctMO5bnBAKNASFt946jd+S4euYaCm6luSfWUlOlkDM6okJEHgIK+62Ow8O4pQRmvmRmtW5vsh7Nq3qp2XJ/An59Kmdp32+og9VfVIiEzx845hjPWsPduIDMK3uThjdAENP3KGNo9GbB70kdhAp4gP9BsTvHWup5HT0xv2CYkGTj4nSi8r/KVxoglXfCiBrZiNJ3Nh8hxMV7Jsg0Z0V38GaKgssrvk7EPfy+ughLGeeEwK8pfkB/hpAa+x40VE+J7F3uve0M+KKuDVdpRnRLA2C0kwX5hqdrodRjh8wkM6tAHD9SHy7zfxPDcHQ==
Received: from PH7P220CA0020.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:326::8)
 by LV0PR12MB999068.namprd12.prod.outlook.com (2603:10b6:408:32d::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.21; Thu, 30 Apr
 2026 13:04:03 +0000
Received: from SJ1PEPF000023D9.namprd21.prod.outlook.com
 (2603:10b6:510:326:cafe::e1) by PH7P220CA0020.outlook.office365.com
 (2603:10b6:510:326::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9870.21 via Frontend Transport; Thu,
 30 Apr 2026 13:04:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SJ1PEPF000023D9.mail.protection.outlook.com (10.167.244.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9891.0 via Frontend Transport; Thu, 30 Apr 2026 13:04:02 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 30 Apr
 2026 06:03:37 -0700
Received: from [10.242.158.87] (10.126.230.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 30 Apr
 2026 06:03:31 -0700
Message-ID: <b05c8be5-e94f-4415-b50d-58ce1647658a@nvidia.com>
Date: Thu, 30 Apr 2026 16:03:29 +0300
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net V4 4/4] net/mlx5e: SD, Fix race condition in secondary
 device probe/remove
To: Jakub Kicinski <kuba@kernel.org>, <tariqt@nvidia.com>
CC: <edumazet@google.com>, <pabeni@redhat.com>, <andrew+netdev@lunn.ch>,
	<davem@davemloft.net>, <saeedm@nvidia.com>, <mbloch@nvidia.com>,
	<leon@kernel.org>, <horms@kernel.org>, <phaddad@nvidia.com>,
	<kees@kernel.org>, <parav@nvidia.com>, <gal@nvidia.com>,
	<netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <dtatulea@nvidia.com>
References: <20260428060111.221086-5-tariqt@nvidia.com>
 <20260430014211.2375751-1-kuba@kernel.org>
Content-Language: en-US
From: Shay Drori <shayd@nvidia.com>
In-Reply-To: <20260430014211.2375751-1-kuba@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023D9:EE_|LV0PR12MB999068:EE_
X-MS-Office365-Filtering-Correlation-Id: 226f6d98-8b68-4908-0d04-08dea6b8f36f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700016|376014|7416014|1800799024|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	kMOEUPHwaZ78QIaYksMwXboO2Vl2agy8lfo7hO/l3hsH4oM/eGqsI5Ov9J3hE+BMI86n2FW7cHjwq1yQcp+1ZTWaLqY6J9fIEpU+YVGfqhF67qZxTEVWGdM667b8KWmqokKFdJZVOg2nQurIru2ISC6j1mM0r2IpPS1VYEc3pAAHvFmMJpnuXDeRDZKHkz9vjSceX+b8GLcrFMciDy10/QPf3I/5SjYMzyGAb11Usi39AyJej6klwKgzBCfYopGI6bwFWfqtaWwmu02weQ2NwfyC4cVE4Mm4usggInGyG+DPJO9Z8T9963Fec90+byToWOHgfB0hxfHog7lkO4JlMXm22/QEE736QtpCeRVCIWLNT+SzKETTKoJ0cSSUnGl7khwu6C/S3yTSO2LFhzmjsXCwges7Q+vnuNMH688URbMAI4qmoqIKnkOnGRldzTyhrM9W9ZIDF+Bx2b+LKp7iRBycVWyxbzFtyoD3bx45avngIEb0odBiYSTuPYzBOGiKTVTT9qF//mZ9TUkUzTKhN+VULsLSNZx/XJmz7OB1IA1mQ0B+skEHk9MsXI7rgiqIqR9S+1o1gNyroHQiHqgrjme9puyz7QadSEzRoz9emeUXqhjnKI99PIBiiXmVrMDPScJjuxMQlrmaeygERXGfu1dTXWBhJ2qQNhmpWlwG2UdfsRuLcfqMXZkEQn/GlyQ/i67vKzRHKb/pK/dPGpIaCOW82msIg7B34JfAmwMvUlLSbgfF8mgrqkaQkyb1EHtAUGe9YEtL49PEPdtGo+s6ug==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(36860700016)(376014)(7416014)(1800799024)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	dRDAN7Ec2nE3aJkp67N9vyfetkeeYtZu/Sf8h8AqXa+I0D9yqc9yFw7pZz20f+vuxLKLBFDUEuzld5Hv1yns00ILWCOc7LqKU7B3fd7gYcCbQICF15hS4fhwHHIlz4bxm1q2n3QQB5JrpVqzDSFRuwLQX9+Gv2KfH7ViSPzGRKQ4B/k8fvL92trN//lA88eB1WrmPVcZV8sSQJvaW79f1Boh22JHMngDhW/mR9E19VJxUfBa7fWSt0RBqqPR+n2FiG4B/10B0fyhj/VjhLBIeYhTm3SU4am2LHoEcHjP9cskgV4tP/Zf236cWMgd/5Y+KnCl53jTz4oTBNiJvzDz60njQE6NVs561njowMPuAFllQopU7AziPQnTJILaEb9pySz3y5jtDw7Gz0cQDV+CSPlMivrPYxHSwdBRIfyLEOqh1aOZ9Om/aGXDL+IZ43N2
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2026 13:04:02.1234
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 226f6d98-8b68-4908-0d04-08dea6b8f36f
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000023D9.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV0PR12MB999068
X-Rspamd-Queue-Id: C14144A32C5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[18];
	TAGGED_FROM(0.00)[bounces-19787-lists,linux-rdma=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,Nvidia.com:dkim,nvidia.com:mid];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[shayd@nvidia.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[8]



On 30/04/2026 4:42, Jakub Kicinski wrote:
> External email: Use caution opening links or attachments
> 
> 
> This is an AI-generated review of your patch. The human sending this
> email has considered the AI review valid, or at least plausible.
> ---
> net/mlx5e: SD, Fix race condition in secondary device probe/remove
> 
> This commit updates secondary devices to acquire the device lock of the
> primary auxiliary device during probe, suspend, resume, and remove
> operations. It introduces mlx5_sd_get_adev() and mlx5_sd_put_adev() to
> manage this lock ordering and add a second devcom readiness check.
> 
>> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/lib/sd.c b/drivers/net/ethernet/mellanox/mlx5/core/lib/sd.c
>> index 7a1787f15320..a43ae482a679 100644
>> --- a/drivers/net/ethernet/mellanox/mlx5/core/lib/sd.c
>> +++ b/drivers/net/ethernet/mellanox/mlx5/core/lib/sd.c
> 
> [ ... ]
> 
>> @@ -563,5 +567,18 @@ struct auxiliary_device *mlx5_sd_get_adev(struct mlx5_core_dev *dev,
>>        if (dev == primary)
>>                return adev;
>>
>> +     device_lock(&primary->priv.adev[idx]->adev.dev);
> 
> If mlx5_devcom_comp_is_ready() returned true just before this, but the
> secondary thread is preempted before reaching device_lock(), could a
> concurrent removal of the primary device cause primary->priv.adev[idx]
> to become NULL or freed?
> 
> It looks like the removal path (such as mlx5_unregister_device) frees the
> mlx5_adev memory and explicitly sets primary->priv.adev[idx] to NULL. If
> the secondary thread then resumes, it might dereference a NULL or freed
> pointer when attempting to acquire the lock.
> 
> Since the second readiness check happens after the device_lock() call, does
> this leave a window where memory corruption or a panic can still occur?

This is also correct and will fix in next version.

> 
> Additionally, since the driver core already holds device_lock(&adev->dev)
> for the secondary device during callbacks like probe() and remove(), will
> acquiring the primary device's lock here trigger a lockdep warning for
> possible recursive locking?
> 
> Both the primary and secondary auxiliary devices use the same generic lock
> class assigned in device_initialize(). While the fixed secondary to primary
> ordering avoids an actual deadlock, lockdep might not distinguish between
> the two mutexes without explicit lockdep subclassing.
> 
>> +     /* In case primary finish removing its adev */
>> +     if (!mlx5_devcom_comp_is_ready(sd->devcom)) {
>> +             device_unlock(&primary->priv.adev[idx]->adev.dev);
>> +             return NULL;
>> +     }
>>        return &primary->priv.adev[idx]->adev;
>>   }

I test this code with KASAN and LOCKDEP enable, I didn't get any
splat...


