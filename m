Return-Path: <linux-rdma+bounces-22972-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id zLsnLQ/lT2p9pwIAu9opvQ
	(envelope-from <linux-rdma+bounces-22972-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 09 Jul 2026 20:14:39 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 52A667342C0
	for <lists+linux-rdma@lfdr.de>; Thu, 09 Jul 2026 20:14:39 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=Nvidia.com header.s=selector2 header.b="uRiXVm7/";
	dmarc=pass (policy=reject) header.from=nvidia.com;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-22972-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-rdma+bounces-22972-lists+linux-rdma=lfdr.de@vger.kernel.org";
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8B900301FD65
	for <lists+linux-rdma@lfdr.de>; Thu,  9 Jul 2026 18:14:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA6E94DBD85;
	Thu,  9 Jul 2026 18:14:33 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11011001.outbound.protection.outlook.com [52.101.57.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 369FE3876B3;
	Thu,  9 Jul 2026 18:14:32 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783620873; cv=fail; b=ReZGjm2Nez0r6JkghdV9NhJ76GJls9L617EPW9fU0p9Cc4dPPxTpR7gsRkNzlhBnXu21L6OFyRAlav7Pr6yEpvH3PK9gENrTg+7f31+S/kwsyiqPcsox8whRf+aO9P7Li4NFfvUQp7kah7MHJeCILcEsTDN9Lqj2xklk5TiyHzQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783620873; c=relaxed/simple;
	bh=mV5EPJMhScx/C2RZ3FsjtLD/7JORi4cChRgTf6IYQwg=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=t9r3Ik7ihVFFj/FInrEL1OSDNssKXUL+hZfu1uaB7GPFlBaUXLZDdY5LESZQq69MViGblP5a8kJ9vdGVzbmtmXuxgJ+9Ui1zUpHKD2VkVeGMjt74jzvlRU0hElNCgKbXGBLCDOVbLdNyLUswr/OOXvCr8sCx2ZDASyx01wdp+xQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=uRiXVm7/; arc=fail smtp.client-ip=52.101.57.1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ksb1s09mysO/OQ/YXSKdGhNkTsr9Sj/UFg16WRLa3weHtnO9yGHCvlZed+eWYfWBHNBuiEZ1d0CnEWKXJUdue5S0cWHTRGux72F2QAKv+kghPBQ8rF89MlE5LTWHs3WjeTkGWMZ41fQQaM84ZTuro2cGrcTAkro1zpN2/Fp0b7TBLgApUEjtgAlQ03aYmb0nl9cyiFRamr50SDbJQadsTdQOG814gx6HGEwp2ob1EpTmqosipjZbALrWQpXiFgz8SYV9pcv4Z+F+Q7A2bCw+5f8dOcrnX2rQad8M0V2xSKcKKn3e2bP1Ap5l15xhq5AzNqoK5aD6TpJycOo8r0LcyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y8nwE3qAhNpBv8H77w9f+WelrqOhL+DOgsbSOLOpstI=;
 b=yKCpzCTjjWjlNCh9dp74M73wIYvSjVSCiS88JgGDMLNJAy4krJRkp5/BAbxFkoaRCGpaFUfFfNKJr9ljcWgLO705AAFnNmA61jlZfMSQ8S9qaKm3TWPXaiTO7VbrUE9W+ieYKDjRYDom5/+BqLe3iPzQnIBEjOKLLoWPL7l26bI+9j1qS3ZFS6eP4t5GPw2PPdCjv7EWUjYjECniiYYR6IZt4cGh/icqr4Zq+CUld0+uqsmQDj4Jm7UFudbIwmRPhoOV0d4LjHb9iaFdFfQKPHp1ap8Ym/lqmb71FSxGr+6GGPUqnGB8w/ynldi5ljfAO0eFeN/XrTlU24ZS/NuVfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y8nwE3qAhNpBv8H77w9f+WelrqOhL+DOgsbSOLOpstI=;
 b=uRiXVm7/VVMRzdWrwCez4sFEGjIlNoUsbxS//QNGOibmciI2K1iPIXa/sxsbheKtZIotNOr4izfgwOF+r2ENQtLgYfN+Tsa6Uwmtek2RMbOcPx6Qd8JYYktfippKRbGMbWHQkpyDHUhbETMLenRXarzd3Xx407WzMt02rKPcKYUrtJIuVkcZF1WtW5mL974yWL4d4P4UEnsx4mNhzVd7Qf0bhOpXe9BU7Lz8P0XDfWtIXsdLOcXNtcHdFHD9rAYxSa1ZDQmV3hKoXQ52Lv3r+MmtObnPLVkiYpwP0RWei2LCngazh6rzH8RTzjNBw0GoQSi+Xr41No0IU18P/gcX5g==
Received: from CH3PR12MB7548.namprd12.prod.outlook.com (2603:10b6:610:144::12)
 by PH7PR12MB5655.namprd12.prod.outlook.com (2603:10b6:510:138::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.8; Thu, 9 Jul 2026
 18:14:27 +0000
Received: from CH3PR12MB7548.namprd12.prod.outlook.com
 ([fe80::b710:d6a1:ab16:76de]) by CH3PR12MB7548.namprd12.prod.outlook.com
 ([fe80::b710:d6a1:ab16:76de%6]) with mapi id 15.21.0181.014; Thu, 9 Jul 2026
 18:14:26 +0000
Message-ID: <22e3a6cf-bb4b-4a0c-89f7-0206ea81ef8b@nvidia.com>
Date: Thu, 9 Jul 2026 21:14:22 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next V5 6/6] net/mlx5: Apply devlink eswitch mode boot
 default on probe
To: Jiri Pirko <jiri@resnulli.us>
Cc: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
 Tariq Toukan <tariqt@nvidia.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>,
 netdev@vger.kernel.org, linux-rdma@vger.kernel.org, linux-doc@vger.kernel.org
References: <20260707174527.425134-1-mbloch@nvidia.com>
 <20260707174527.425134-7-mbloch@nvidia.com> <ak4LVcyKofmtrWcU@FV6GYCPJ69>
 <7309e57a-89bc-4e4a-97e9-d843b02efa42@nvidia.com>
 <ak9un-lCDmhGI9tL@FV6GYCPJ69>
Content-Language: en-US
From: Mark Bloch <mbloch@nvidia.com>
In-Reply-To: <ak9un-lCDmhGI9tL@FV6GYCPJ69>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR5P281CA0053.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f0::12) To CH3PR12MB7548.namprd12.prod.outlook.com
 (2603:10b6:610:144::12)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB7548:EE_|PH7PR12MB5655:EE_
X-MS-Office365-Filtering-Correlation-Id: fe853c33-26cc-4415-0b6e-08dedde5e939
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|366016|23010399003|6133799003|11063799006|4143699003|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	8tjko4UGn8wDoeontELJVFrFA96s9mqKtocmST3wv+qD9d0Pb0Q5mCi4dfxfmgLEd1I+o44ahzk5jg7d/LihVvIvE+U9+yxL6QSK1xJCarF0nR0e8AACdqxKCGXSsBhzQkmwkjUSVp34vXztMpPhqGWwHiaFeRgnFzS+646JbiFt9KkbEil+ZBbIAcjHSMXQVTGRX2V7XcmOddYuhgh2PudK0/ah1dgUZSOm4WKZO1LN5Ki1mets0r+w4y1v3sJBwFrDFmEqM415snujxccAJ4pIIoWlRBriLOmeULsPyaDl86WGstyHPuBcxEnbKJOKIvtU/hqBbTcONwMH/xKLZ7ekBB+oWw5p9MMxVFJq4lpIX2SqrsjvB24XMd5RiL/YObcvRMRNjilzCjoeOtgCbM0rBHF9OEi397b663aS2GMcMJBvel1Qx5eY3tIYt9ijUrV/xDpZRL20QhfcljL9+sCt8L106W2Bjg/eLBxPsissXvV66eXClsCTEO126tv2SWq/cIIxnp6R62HG2hsxhn+VyeYjikzcuERgljaKtCFLd6X2QNlcBE46p2sukazdqbIFmN9bHsAyHFDzg70FCF+RrQXhR5zgkiAOmSELeSIl47dmvCYh4A7JT17Dls6WKEKWrb8idvqLqRZN1lduD7+zZd7Tg5t0Vh1ibrrA4aA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB7548.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(23010399003)(6133799003)(11063799006)(4143699003)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WGgwdm1mMjMvaU5HK1doRkQ2d3NzUEI0L2JXYlgrcVpOcWNMcjNvaU1ISG44?=
 =?utf-8?B?RHdNSWtZVWtvRzRBSFBtQW9WUWZvcmV3ZE5WdW9pdHlqMlpZZG9qMlJmMDhL?=
 =?utf-8?B?eUY3Z0NhNVFWV2dya2ViRWFSc0xWQ243OS9kOWVqM2VQYzZSRzk2QXkrVXEw?=
 =?utf-8?B?SEJQZlczTlJkYlZvUGVSam04S0lCT0QvZHFJQUxmZjE4M3duQlhQb3Y3dGFC?=
 =?utf-8?B?a2haK3U1bGNzMXpLdjVkcnlxa05IZHRoVklkYlBSTGxqVzhkRCtDZWVNbWhJ?=
 =?utf-8?B?NzA0MWVFSFIyWHV2UUlYZ3V5cHF1dG5aZjJuZ1JHWUVtVmRxSndQaytESFNv?=
 =?utf-8?B?RVF5WjdiK09KTFN3a2NuaGk1YW5Bb1JnaXdad1FGbUQ3MjBJZUhxV0lwbmNE?=
 =?utf-8?B?WDUzaGN4OE5MTUNYVnhhcnA0TG9HTVRKdzYxQUxzSGY1ckpUNDlyZFFmZ1dS?=
 =?utf-8?B?dDUrYUxyNGlua1V4MVZNN3J5RExKazMrVnBJcmlHeHlmVDJxRThDRFFFc216?=
 =?utf-8?B?K0FMK29TTW9FZHIzMHhvOGNubFo0M0YyZHBZb2ZYbUcxQWxmUTZTN2Y1SjF2?=
 =?utf-8?B?M1k5aG13MVhUTU1hTlMvelpSTzl4QXJjbjc3VWdCTXgvMmJKOUpCN0pLcVRV?=
 =?utf-8?B?cWt3SnRMbGJtMzNySjRiaHZBNWxMbkd1OHJzZERPMWFsOEE0Zlp0aXdRTUxt?=
 =?utf-8?B?Y2x4QmdSY1NSU2dyZlEwYnhOTThvdENoZjAzNENTRzNqTWFiZ25yTXhEaE9G?=
 =?utf-8?B?T09yUC9IZzlzaXk1cEFvTWFwaXJiSlNGZU82WFdKUnA3ZVYwSHh1dWUrZmox?=
 =?utf-8?B?L3RIbWJKb3BQTlZMODJIM1JQb051UGxwcnhvUGZIb0pLZ0NEdXU4TzVNY0Vn?=
 =?utf-8?B?ZWhPOHM2bTRHbVRRS2ozQ0pRSE4raWtJc1dxbEkrOVhSR0FjZVZIdnloMk9t?=
 =?utf-8?B?ZVlNMXZMYVEvdTdwSko5MG5ITzdVZjZFb1dlVElsbDNnWHMzWU56bHlTQk81?=
 =?utf-8?B?SjMrcHJuVldsRDN0eC9wWlJkVkZCSFR5aFBOWHlOVVNuaVBEdDRtQ0ZHMWFD?=
 =?utf-8?B?TU9ucEU5OUtEYUgyRnI2SWkzMUhpQlhCdWZ1QzgvWHZuVVoxbDZkSDBkNG1Q?=
 =?utf-8?B?bGdacUlKaDVoNlBPYlVIVHdNZWxRWXJWN2M0azFzR2dRWGlGUm8wQ2wxOGNx?=
 =?utf-8?B?ZWZEbzB4YitqdzZOTGtuZjk5ZUxRQmNxKzdvcGk1ZnljM1ZFQjB1SFFmWUZY?=
 =?utf-8?B?eGdSbCtacTVzOU9ISURlSWwySXVxajZ2WkJTbldRRE5sUk1KaXJpcDFac29q?=
 =?utf-8?B?SWVpYU5WNUhrQ0U2L3c2NXZ1VHl6VWhHNld1NDNRenJSdmRvMk94dlgxRXJv?=
 =?utf-8?B?YTFnaU1YUWZaSWNzNlgxUHhyRjJ5UW95RXhlQXl1dGNOM0RtOE93Z1p3OVZ6?=
 =?utf-8?B?NndqWWhyOUhqeGpqS0xJbEF2cWtWUlhXS1VmVTArTU5XOFQydUg4YnYrY3ha?=
 =?utf-8?B?SzllNnpNVHFRNnI5T1ZqVDVoOG1sZnk4RGw5L3JuWWdzU2tTZ1htbWhFeE81?=
 =?utf-8?B?RndEMUdxYlc0aFYyZnVpZlk3ZjVOMWkrc1U3YXhaWDljMndNVnJ3b2FVYlZV?=
 =?utf-8?B?QWRVaFhHM2c3V0pkWEpXSHh4ZnRZVFhEazlwSUhmR2c0ZGVEVlVLdVdHazd3?=
 =?utf-8?B?ZnRHbEtuVkRNdlJwK0dxQzdiSkU4c3k3djc1a29uWGloKzJ4NXRzdTgyM3lI?=
 =?utf-8?B?UVNFV1R4LzlLOTBQRVhNdGpZYmU4WS9ibVV1RVEzdG5oVUtUdHQwUElTSnYx?=
 =?utf-8?B?Q3NveDkzeWx6L1N0bXFESExEWEJic1hQZXM4ZUk1R0JEd2EyY3NHRHhyZUpM?=
 =?utf-8?B?eXFQbm8xeUF1ZEI4NXRRYndWc0VpQ2laRFQ0K1ZLRzlBSExkQUd4RzZMV1dz?=
 =?utf-8?B?Zm1UUk9DcWo3RFJvek10dkxON0laV25RTkRUazIzenFiclN2T0FCSGkzelVM?=
 =?utf-8?B?b1ZlN25EV3hGaXFqYlNVTURUNTBWMnpwRHU0ZE9JQWVoQlFRRHg0TjBNY2My?=
 =?utf-8?B?RmUxd0Y1azIzd2UrWVZ4NzFsNTRpSGxhZTVTcjlCQXFpQXU1R1N5K2ZZcDF3?=
 =?utf-8?B?U2Y0bWVPNW1Lc0Zqd2FvbUhEU3EzUzhJSzBwVml2TC9oMU5RcWdvbFdnUXB3?=
 =?utf-8?B?cWcxYlFGTjN4M2VyeHZieVlrZHV3QmxoN2NEU3hHTkpCUWk0Szg3ZGptTzVE?=
 =?utf-8?B?VVVmQUpSSmdpa2pSYmRDVHJKa0Z4eUFocVVhLytCZFp3WDcxYmpmU0x1T0RT?=
 =?utf-8?Q?iYWrbPJnF0Q3y68BWy?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fe853c33-26cc-4415-0b6e-08dedde5e939
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB7548.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2026 18:14:26.4614
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hJQeOwXiDdW/1SZGfC/8uLdmIBw04RQwEOryMh/2n8JioKISUO6rYRYsUZJ3T7JQiRpD0bMX43OoYa9iT89wpQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5655
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.66 / 15.00];
	WHITELIST_DMARC(-7.00)[nvidia.com:D:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-22972-lists,linux-rdma=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[mbloch@nvidia.com,linux-rdma@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:jiri@resnulli.us,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:saeedm@nvidia.com,m:leon@kernel.org,m:tariqt@nvidia.com,m:andrew+netdev@lunn.ch,m:corbet@lwn.net,m:skhan@linuxfoundation.org,m:netdev@vger.kernel.org,m:linux-rdma@vger.kernel.org,m:linux-doc@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mbloch@nvidia.com,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,nvidia.com:from_mime,nvidia.com:email,nvidia.com:mid,vger.kernel.org:from_smtp,Nvidia.com:dkim]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 52A667342C0



On 09/07/2026 12:52, Jiri Pirko wrote:
> Thu, Jul 09, 2026 at 08:00:19AM +0200, mbloch@nvidia.com wrote:
>>
>>
>> On 08/07/2026 11:34, Jiri Pirko wrote:
>>> Tue, Jul 07, 2026 at 07:45:27PM +0200, mbloch@nvidia.com wrote:
>>>> Apply devlink_eswitch_mode= boot defaults for mlx5 after the initial
>>>> probe finishes device initialization while holding the devlink instance
>>>> lock.
>>>>
>>>> At this point the devlink instance is registered and mlx5 can perform an
>>>> eswitch mode change. Calling devl_apply_default_esw_mode() also clears
>>>> any pending default apply work queued by devl_register(), so the queued
>>>> work will not apply the same default again.
>>>>
>>>> Keep this call in mlx5_init_one() rather than the lower-level
>>>> devl-locked init helper. That helper is also used by devlink reload, and
>>>> devlink core already applies the boot default after a successful
>>>> DRIVER_REINIT reload.
>>>>
>>>> Signed-off-by: Mark Bloch <mbloch@nvidia.com>
>>>> ---
>>>> drivers/net/ethernet/mellanox/mlx5/core/main.c | 13 +++++++++++++
>>>> 1 file changed, 13 insertions(+)
>>>>
>>>> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/main.c b/drivers/net/ethernet/mellanox/mlx5/core/main.c
>>>> index 643b4aac2033..0712efea74cc 100644
>>>> --- a/drivers/net/ethernet/mellanox/mlx5/core/main.c
>>>> +++ b/drivers/net/ethernet/mellanox/mlx5/core/main.c
>>>> @@ -1392,6 +1392,17 @@ static void mlx5_unload(struct mlx5_core_dev *dev)
>>>> 	mlx5_free_bfreg(dev, &dev->priv.bfreg);
>>>> }
>>>>
>>>> +static void mlx5_devl_apply_default_esw_mode(struct mlx5_core_dev *dev)
>>>> +{
>>>> +	struct devlink *devlink = priv_to_devlink(dev);
>>>> +
>>>> +	if (!MLX5_ESWITCH_MANAGER(dev))
>>>> +		return;
>>>> +
>>>> +	devl_assert_locked(devlink);
>>>> +	devl_apply_default_esw_mode(devlink);
>>>> +}
>>>> +
>>>> int mlx5_init_one_devl_locked(struct mlx5_core_dev *dev)
>>>> {
>>>> 	bool light_probe = mlx5_dev_is_lightweight(dev);
>>>> @@ -1471,6 +1482,8 @@ int mlx5_init_one(struct mlx5_core_dev *dev)
>>>> 	err = mlx5_init_one_devl_locked(dev);
>>>> 	if (err)
>>>> 		devl_unregister(devlink);
>>>> +	else
>>>> +		mlx5_devl_apply_default_esw_mode(dev);
>>>
>>> I don't understand why this patch is needed at all. Just leave the job
>>> to the devlink core, no? That was the point to not pollute drivers with
>>> code like this. Is it some kind of leftover?
>>
>> It was discussed with Jakub here:
>> https://lore.kernel.org/all/20260611085440.4fe36bf2@kernel.org/
>>
>> The main reason is timing. If the default is applied only by devlink
>> core, it has to wait until the driver drops the devlink lock.
> 
> I don't follow.
> 
> <quote>
> 	devl_lock(devlink);
> 	if (dev->shd) {
> 		err = devl_nested_devlink_set(dev->shd, devlink);
> 		if (err)
> 			goto unlock;
> 	}
> 	devl_register(devlink);
> 	err = mlx5_init_one_devl_locked(dev);
> 	if (err)
> 		devl_unregister(devlink);
> unlock:
> 	devl_unlock(devlink);
> </quote>
> 
> devlink lock is droped right after.

Earlier versions had the fw reset / recovery flows covered as well.
The regular probe/init in mlx5 need some changes in mlx5 so I can
move it earlier, left the API just to make sure we are aligned and
it could be used be a later patches.

Anyway, I guess I can drop this as well and continue with followup
patches just to keep forward progress.

> 
> 
> 
>> For mlx5, that usually happens very late in the init sequence. I
>> wanted drivers to be able to apply the default as soon as the driver
>> is ready for it, because on NICs with a DPU the host PF can remain
>> stuck until the ECPF moves to switchdev.
>>
>> This API is also useful beyond the initial devlink registration path.
>> Follow-up patches will use it for driver controlled paths that are
>> not covered by the devlink core, such as recovery and FW reset.
>>
>> There is also a race window where userspace may take the devlink lock
>> before the core gets a chance to apply the default. Letting the driver
>> explicitly apply the default at the right point avoids that scenario.
>>
>> Thinking about this again, maybe the simpler approach is to apply the
>> default from devl_unlock(). That would avoid the whole workqueue
>> infra.
>>
>> I avoided doing that earlier because applying a default mode as a
>> side effect of devl_unlock() feels a bit odd. But compared to adding
>> dedicated workqueue handling maybe it is the lesser evil here.
>>
>> What do you think?
> 
> I was under impression that you need the work to resolve nested locking.
> If not, drop it, sure.

I think that should be fine. Once the instance is registered and the
devlink lock is dropped, the driver should be ready for normal devlink
operations anyway, since a user could trigger the same path at that
point, so we just don't drop the lock and call the driver directly,
should work.

The only caveat I can think of is a driver holding some other lock
while dropping the devlink lock, and then trying to take that same
lock again from the mode-setting callback. But that sounds like a
driver bug rather than something devlink should work around.

I’ll drop the workqueue approach and rework this for v6 :)

Mark

> 
> 
>>
>> About the extra API, I still think it's useful and would like to keep
>> it if possible.
>>
>> Mark
>>
>>
>>>
>>>
>>>
>>>> unlock:
>>>> 	devl_unlock(devlink);
>>>> 	return err;
>>>> -- 
>>>> 2.43.0
>>>>
>>


