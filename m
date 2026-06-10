Return-Path: <linux-rdma+bounces-22075-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 7TkgIJJWKWrwVAMAu9opvQ
	(envelope-from <linux-rdma+bounces-22075-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 10 Jun 2026 14:20:34 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D727669346
	for <lists+linux-rdma@lfdr.de>; Wed, 10 Jun 2026 14:20:33 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=Nvidia.com header.s=selector2 header.b=Y9o1g5Qj;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-22075-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="linux-rdma+bounces-22075-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=nvidia.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 9121E306D3D8
	for <lists+linux-rdma@lfdr.de>; Wed, 10 Jun 2026 12:06:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01294403AEE;
	Wed, 10 Jun 2026 12:06:29 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013036.outbound.protection.outlook.com [40.107.201.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62854403B0E;
	Wed, 10 Jun 2026 12:06:27 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781093188; cv=fail; b=TBRsF76EQZK7YdQhFDMtMTyrKZeYF7dwUzb9eIciEOL2KeT6UyFp7iSPPhak54piLMYR5psjnfX09izN/xMJ7xd/jJfZijYKMSwZeB5s9nIpUBbCX9BTSWztqGtRB1Ua+GQXB2eZvCjypCka/mCxIq/qYGVQyh1+lLxeebkgRWA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781093188; c=relaxed/simple;
	bh=ckjQqB0VTgF5zV2iVQHEy4SwTU3cAe53iVFsJYUgx9I=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=n2ZMkGpEqxLJzY9+1n/sBjL/qbE7TF78OCpwEuSvCt10/WpnNtHBP9FKWeA2fIYZwhhsueLTvjxXBBpqObBA4C55y5x2OkF88W4Hta9JF2lhsLao9gOgjNINvUtn7l3W/NfYbbTZWWUOAxt1uBZIGY2Q00Al6eIOkRUe54a+NJE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Y9o1g5Qj; arc=fail smtp.client-ip=40.107.201.36
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sTdyFUutRI8woeJbC5OlRFuuEkrUQj98rhmj3tVr4sYi+DEqNrrKrXsJpUDawS08FNEGzxC1G53mC4u/8dQGZLXGoKkfPPkTHRpu3h6Tc5rL5Z9lMtJdaamK4cfz4NAYQUwWH88fcztpxp24V9v9MF7bAaPeCRQS6jd1j2F6nEQNK4Q9Pb05+cja6CPW/J/MGTRl8UjNJKpBZgpYJoJYlCfm9wKlInDNKh1Ttdj/QSBnDKq3mkG7qCit/pQ0c15fF5mE/7Qkl/40sHW0MIBhw23/sQSvr8aiYFtUm771HEEUHBBw+dYvbXuHZhVisUqthx/3Zsnz/BeUZdoWCclBnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J/xw+qAK+C/doWNItpgQpTP6vqpIEqGC1vSOw7ef898=;
 b=daXPTAdkcXrLMu2Uu84xWXJd6Xhi1q4zZ+6aOlgkudXmEok68Sb4fKenxpFOy/5mAJq99i1GRVGm4Cuq5OMiLl8WIPQ3N5I8qHLTXd2xWT1Ddt0B3ww7HIozG40f+zfOvtpHqFBNv0wMlC3hA8Lz+TbdCeoT/EfUgB1q3N2EJbFodeL/Ri+e7ijxXfoobyBc2AHKC7VN2A5xIj3omXvTY0TpMg3XTWimVPnNYPpClU6nWbR8hR8hoZyhii1Jmnfj4u802s+I1gfFUn7XCSPupRWC/ojTp9BWVeFpCWFtGPX/Ss/wLLGmvEyMVBSvIT29GaELzkqIzxkREYtcKaHOXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J/xw+qAK+C/doWNItpgQpTP6vqpIEqGC1vSOw7ef898=;
 b=Y9o1g5QjDYK8Hj3966aWFolsZylHfPC5qE5MmpoVSDba6nGPG+KPhbIwr7bhSjJnfY8cPUoBC2vPubUEpfykjBqJo2YGejdvVKnxjwBxi4HEvTjdfHNkQKOg9iQb50/z9F90mLweVeWRYS6yns8BcnNO5zHd5KBQaRajrNtBU3F+sHAjV4en/UPSFX2OoagQuaKh2vEIxv4UufT9iQM6mZ25RE+M7B//j5Yak5qGPO2kRObceNsFSA8j4c2AfNBDV4MsmTFv4n1QGU8NG3/ukCnqK2SC/f5QqcKhMDOLm3Isd3NYq/EIBtKEKfWpi2wQHifqsmsgzbHlv1PvxTJEtg==
Received: from DS0PR12MB6583.namprd12.prod.outlook.com (2603:10b6:8:d1::12) by
 MW6PR12MB8705.namprd12.prod.outlook.com (2603:10b6:303:24c::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.13; Wed, 10 Jun
 2026 12:06:22 +0000
Received: from DS0PR12MB6583.namprd12.prod.outlook.com
 ([fe80::16e2:19ba:8915:90be]) by DS0PR12MB6583.namprd12.prod.outlook.com
 ([fe80::16e2:19ba:8915:90be%5]) with mapi id 15.21.0092.011; Wed, 10 Jun 2026
 12:06:20 +0000
Message-ID: <9845fd42-e84f-43d7-98d3-9b2d0d1f23d9@nvidia.com>
Date: Wed, 10 Jun 2026 15:06:16 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] net/mlx5e: Report link down on administrative
 close
To: Manjunath Patil <manjunath.b.patil@oracle.com>, netdev@vger.kernel.org
Cc: saeedm@nvidia.com, tariqt@nvidia.com, mbloch@nvidia.com, leon@kernel.org,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, linux-rdma@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260608234223.3731557-1-manjunath.b.patil@oracle.com>
Content-Language: en-US
From: Tariq Toukan <tariqt@nvidia.com>
In-Reply-To: <20260608234223.3731557-1-manjunath.b.patil@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0199.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e5::19) To DS0PR12MB6583.namprd12.prod.outlook.com
 (2603:10b6:8:d1::12)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6583:EE_|MW6PR12MB8705:EE_
X-MS-Office365-Filtering-Correlation-Id: 27e0e705-76de-41e0-285d-08dec6e8ae66
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|7416014|376014|366016|1800799024|11063799006|6133799003|18002099003|22082099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	M0Y/ZpI4UmAqbUQVvz+QZk6XWnRks3ftk+0FUyRZnbFEEv3iGpb3X+qQ4ce4K5CRxYLztildFLrZ464TqChoRktd6fKdZ420sleSXHI4MZpcxdbW9kQnjXoavwPbLUoOU9K3Owuq7QXzsitg7ZEQ2tRTcSPOiXJB9W8lvMBJ6ojK8Xn8lzV4f7llClIr9Vi9qiKW0vt6U3dSyG2+StN8rbmRQVoL132pd8BdQ7amCTtd3DVhFfegrXSN2eUFNB/WqSHJIyJEApF5aPHoAaVil4+XT8d2AIeyH7jkqxER/Z3kWNd+ny2/NyBLLvuc07bJQ/uITz1fx4PLmrG1U75LTJieZr3j7Dy/SsIeZEzY/8dsDBQ+g282GWIDmYoYYLNNtA0KDf7hzdjeLfYJ7t/yvBd9kpaw0xYstBk7/2luQXwnQsFzfzaU17atBlROI0kyDQWQ445p0oEPmunIRWL3rgN08GGwGKvzQyn/8GVQaV/2GrK+63srP6QZ3kouDTzbQdlAVDX5zD9s4yHyeuao8OK8bSR7Qw+W+SCSgNCXaRkyZ7+c4jvrGyLCve4YTyMlxG2p5sarKgl5rOdgeisILxA3QHDf10hdyv8paR6RKHkBHW9j4OKdIOCm6Sf+VXAHN9ilF5W+y5tlrqN7gyeoAAkHGPslX5y9pWkAycC48RULGAy5owahoSs8OQ4EcK+6
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6583.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(7416014)(376014)(366016)(1800799024)(11063799006)(6133799003)(18002099003)(22082099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ODFXMXpmWU9zV3gxOU9DSmlwRHJMSWErSm0welFUOElSVUUzd1dQTHluOGNm?=
 =?utf-8?B?Myt2V3lmQXFJVFVEM3drck05UG8vVEtYRXVqUXozenZsenNkeWxjOGZqaUlZ?=
 =?utf-8?B?bnFZN0dyNHlETDRQdWt5YWVMaURrU0tCd1RvZTVpUmNUSzlUVVRFa21VdTVO?=
 =?utf-8?B?S1BTb0VIWTc2WnoxTUs4VWZleVZ4alZOSUcxbTlHYTl1SnhkQ01OL205UThU?=
 =?utf-8?B?ZEg1NDZRdmZOQmZNQlNlT29OellnK21lWlMxMExGSUJoU0t2VkxBVVVqWlZ3?=
 =?utf-8?B?UmRkRDFUR2w3MDFjRDB6d2wrUDFreU9Wd0k0ZjA2MnVlMHZlaHU0YUdJc3Bs?=
 =?utf-8?B?UXVjN20yekloU3BNOWxxZE1VWC9rWTRCd3BBd3Arb3VyRzhYdWhDc3F3a1Np?=
 =?utf-8?B?NHVMZ3Z0YWRpNFVvdVVjMmJnM21KTTMvK2t4QXN6U2VDcVZab0xUT0FFWm5a?=
 =?utf-8?B?Q2ZMU296czRVZVV0ZGhwZkU1Rmt3YiswcnVKVGRQeUh4V0dybUpjVVNCOFI4?=
 =?utf-8?B?S0x3aStncU9LRkxFZGZUZktmYnBDNnR3Q0hzVkJSYzFLekpwajN4Q2V4RitG?=
 =?utf-8?B?d2MwRk9TUU5OVFhpMEpteTQySUFDUUhQbUlORmZHeHRGN2tjalA1YjhDTDZo?=
 =?utf-8?B?dEpFSnZyODRHaTFLeGRKejRWMFhEdnBkU1I2T0hYSUl1cEJzb3Z3NkkwM055?=
 =?utf-8?B?Qk04Z1RzcUNXMDlqYTRvVHhNQVk1Zk04ejFBVUJPMCtNWTdldXZqem1ZcEYr?=
 =?utf-8?B?SDVlT0Z4c1ZrWExPdUYrRXVPMlJ1SUY2MDVraENwTHlzSDlIQ014WVJ5Ukli?=
 =?utf-8?B?YmhRMEtRRm41Y2dCZTd5bGdhTnIwRGNEckZHVkg4eHU3NmFkOFNmZDJpMU5n?=
 =?utf-8?B?NG9IU0pxaGR2TnJyZTBEckRvTzJxanRhdEN0QjBmU3VSamY1UFZXZEd4dXdw?=
 =?utf-8?B?N1ZtMHBTYk5VWkZ2VHdyaUpFQXBxTC9ZeGZGVnlQem8yMXp4bkIrakJ0Rko2?=
 =?utf-8?B?UlRRMW0zcHFPN0NabTk4eE8wOFNxVDVRZ1pIR0JwblBjM2x3Z3BteXNTRldF?=
 =?utf-8?B?VlREZVlNbU9FVDU3bGFlOTJDbjhxMTVkZWJKUDNYT293WVR3OEdjWDNBWGR0?=
 =?utf-8?B?OXhjbEdXc0JMQ3o3NGczUDlQdExOMjJRZFNzVXdGZmhKeFlUaEcrVDB1V25w?=
 =?utf-8?B?NDJVUktiNXRSRjRwWGppZllRa2N1OUpFUmQzVkU2cnlEelVlZ1RhR0VrZWhZ?=
 =?utf-8?B?blkvL2tFOGlYRDB2STlLYUpmTisweCttanlWT2xPVUJ0clJoQzlKMWt3UEVv?=
 =?utf-8?B?SjhXbXh5KzIzTVRRMjQ2dmE3VEdpMG4ybTQ3ek5Pczc4QzlKUWV5a1k1TUNo?=
 =?utf-8?B?U0RuYzBGTE5vSG4xVC9CTXE2N1RMMUszZ2hXNjVkYVU5VEtVbHkxNVA2ZDZi?=
 =?utf-8?B?NnQvaExnazB4UmRJbmVtOTJkTXpHNjFxVWFFMFVpV3JJNEw1UHQxS2NQdFlR?=
 =?utf-8?B?NkoyNlQ1bVA4WSt2RkloRFZGQk85UFNXUFpYQW01QnhhS2duMnQzWkxva1Ix?=
 =?utf-8?B?NmxJUmRiUURVNVNybnZoQWhBWW5DVjVhcEdnSE15RFRTem9EeGdYTEc2NWds?=
 =?utf-8?B?Tk9ZNFZ3clIwd1Y1alVXN3FKTTFQMXJzc0N5MDhQcStTS0krcGtCWEU2QmpD?=
 =?utf-8?B?WGROQjZ1OVYveFE1Qk0wcEtDalNVaWo5dmlwQnRmWnZWNG9Sa0x2SVlweFVQ?=
 =?utf-8?B?S3NPSy96UVEwd0cxMU1qVnQ5NlNVa3lkQ21wVDFDNU9FVkdTa25tbFBLbWhZ?=
 =?utf-8?B?MzdBSXg2cGI1UkJBNHJlSHIrZ09VK1kzQk8zY0dPV2t3ZWlwY0I0RU40U1By?=
 =?utf-8?B?dzZwNjBxVzRGTXMxT3RjaVZSbHM5RkxMNmQ2d0wzVElHOVM0bkVtWXlmZDJY?=
 =?utf-8?B?Vi9hRVVBc05LWW5MTFdoUDdVRGtzWTJTaTRhZmFTM2dUY2ZPTlRDcUV2aEtX?=
 =?utf-8?B?ektFcGhWSnRsVEwwTHJyM1RaQkttNit2dy9ENFE2UjZrTVRvdEFlVC9UY250?=
 =?utf-8?B?VnVLK0x3WlVGUmlxQllyUThWQU1LMGg0aW1TZDA5SGdXNzUxNzBuVnd6WTdG?=
 =?utf-8?B?UUtKNmdjenJIK2s5VjdnTzkrdTk5SWNjcjBZdWJGSFg1OWtUNDQvY2I3cEs4?=
 =?utf-8?B?Q3ZPWDNlV3ArZElGZjFsWExjdHg5dkR3NmloQ1MyRmhRbDhFdis5eEJFOC9P?=
 =?utf-8?B?RXBaOFkxalpST1pLMElib090K0xGK0dFcW15N1haVFh6SDViUGhiVGdRcUMv?=
 =?utf-8?B?ek5nSSt2dmtxRFl0UUl0ME0velg4d2EyWVFVQ2hIUlpjOS9uSkpoQT09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 27e0e705-76de-41e0-285d-08dec6e8ae66
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6583.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2026 12:06:19.6509
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RNiBbvW7ACT1BqdYRP/KjsTgySPqpa/SnSueLZStdV70vjlVszDXbGrb9ws6S3K6BDaIRlfVLzBZGgADycN/bA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8705
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.66 / 15.00];
	WHITELIST_DMARC(-7.00)[nvidia.com:D:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-22075-lists,linux-rdma=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[tariqt@nvidia.com,linux-rdma@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:manjunath.b.patil@oracle.com,m:netdev@vger.kernel.org,m:saeedm@nvidia.com,m:tariqt@nvidia.com,m:mbloch@nvidia.com,m:leon@kernel.org,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:linux-rdma@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tariqt@nvidia.com,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,nvidia.com:mid,nvidia.com:from_mime,vger.kernel.org:from_smtp,oracle.com:email,Nvidia.com:dkim]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 7D727669346



On 09/06/2026 2:42, Manjunath Patil wrote:
> mlx5e_update_carrier() reports both link-up and link-down carrier
> changes, but an administrative down does not reach it in practice. The
> close path first changes the port admin state and then clears
> MLX5E_STATE_OPENED and drops carrier silently in mlx5e_close_locked().
> Any queued carrier worker will skip update_carrier() once the device is
> no longer opened.
> 
> This leaves "ip link set dev <dev> down" without a matching netdev
> "Link down" message, while reopening the device still reports "Link up".
> 
> Report the link-down transition in mlx5e_close() before the common close
> helper clears the opened state and drops carrier. Guard the message with
> the current opened and carrier state to avoid duplicates when the netdev
> is already closed or carrier is already down.
> 
> Assisted-by: Codex:gpt-5
> Signed-off-by: Manjunath Patil <manjunath.b.patil@oracle.com>
> ---
> Validation:
> - Built an OL8 mainline test kernel from this change.
> - Booted 7.1.0-rc6.bug123456.el8.v1.x86_64 on an mlx5-backed VM.
> - Confirmed `ip link set dev re0 down/up` and `re1 down/up` now emit
>    netdev `Link down` and `Link up` messages, alongside the existing RDMA
>    port state notifications.
> 
>   drivers/net/ethernet/mellanox/mlx5/core/en_main.c | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
> index 8f2b3abe0092..a04a89f0eddf 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
> @@ -3628,6 +3628,9 @@ int mlx5e_close(struct net_device *netdev)
>   
>   	mutex_lock(&priv->state_lock);
>   	mlx5e_modify_admin_state(priv->mdev, MLX5_PORT_DOWN);
> +	if (test_bit(MLX5E_STATE_OPENED, &priv->state) &&
> +	    netif_carrier_ok(netdev))
> +		netdev_info(netdev, "Link down\n");
>   	err = mlx5e_close_locked(netdev);
>   	mutex_unlock(&priv->state_lock);
>   
> 
> base-commit: e43ffb69e0438cddd72aaa30898b4dc446f664f8

Thanks for your patch.

I wouldn't print "Link down" as part of the "close" callback. I'd rather 
get it printed in the event handler. Currently there is a print there, 
but the callback is masked by the OPENED bit.

This made me revisit this area, and it surely needs some more 
interesting enhancements.
I'll probably come up with some changes soon.

