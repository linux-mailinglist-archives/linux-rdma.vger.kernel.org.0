Return-Path: <linux-rdma+bounces-23280-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 9ZkGKYaIV2rCWQAAu9opvQ
	(envelope-from <linux-rdma+bounces-23280-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 15 Jul 2026 15:17:58 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 2049A75E925
	for <lists+linux-rdma@lfdr.de>; Wed, 15 Jul 2026 15:17:58 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=amd.com header.s=selector1 header.b=Cfoferqd;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-23280-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-rdma+bounces-23280-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=amd.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7F2FE30B5E1D
	for <lists+linux-rdma@lfdr.de>; Wed, 15 Jul 2026 13:08:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7474420494;
	Wed, 15 Jul 2026 13:08:27 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011004.outbound.protection.outlook.com [40.107.208.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42176420491;
	Wed, 15 Jul 2026 13:08:26 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784120907; cv=fail; b=Z5RYQ4I5nr/pxSQ/NFR9cjhiBJKZAfv0JMNk5P7p5T2CaKf4ygnqUnvFVJIcYdd7svT+n/Y5eHCNJC4vKRZ6Xt0j70Uhikq1FoKpfGqk0eXstEF+X7XwiwBdlY5NO7u9/SGlfKh0G+GPebn3mF2epGVDk9X9oCbvopDMjrN4e3I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784120907; c=relaxed/simple;
	bh=FxUDuLrXru0lxYJC+7z4CRZbbGYTOjg91cqcC+v9ZDc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=i4JEbeS1VVg7d4uwlXLJ3KFqNfnbuJEG7mo0jOlIq+1wtVE7M5MoXseDRZ2t7mSt2BOVAbjvU+B3oewj2SeMuMWcqr48EwwVdJV8wuUMukv7kdS0UFoWHb3AAHXKp0+F2gQ+24YBC1aGTWAC9N+SaaQK1GfdExA/LC2oG7RlzxY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Cfoferqd; arc=fail smtp.client-ip=40.107.208.4
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ONeY25viaxgQP4PcPxq45PCz4yEuUiNFLnw3Qi5HVnue2ShpM9ca0E0xa+SoL5a0cqqP+5+WUA8WzR0umcf0VVp8axmjptig+J9DYtoqmTyTqDvAkd3qIz57D4Y2ds8xVNR7JBf/p8b2qUiiMS9mXloCNtZ8HRace/fPW4eqWUtBpR32wvzyvBwbkA3lLhAJj/y4UqvSkD1RXOqygfOMFoP/sQ2F86hKz1u0f8/4D37fTeCiNrcC9Yhix0oclyxHTuiYv1hQ1R4hYKRfkjzrryoF0SaXhAyOQJdsipRy5ZfTq8uuPSh1Ym7rNTfrSDjfMAKQBD4WL2VXKAP7DF0o4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zOLJ4nnqqt+OA24Ml6MgAIAVE470jupE0aJPCKC2ZyY=;
 b=phe9VQz+j+PEnbcdhml90BWJb94sWXhHJntqgkmt1WIr5ESBH518gZgxi60GiTczHOJd/Zl5FK5lD8yBQwFEHQOknnFPQzfeKjYnR8RdbPptVRJKSSp2AQwBvWXEj3r59/e2itl+9ufLQyMb5gXEWlZLcAPR21fR2ah53D1gz999hCRX8ib5CkOoBwC0ikFcOsQt0FHiHL1wmq6ssAM3ZbfiHW9yftalZpckEoDi4EU5JgoiZZiLm7eiENoa1nWIhD2ZkpfBFwJ9jwRcESthmU/zpSQkBMXegKuNHGizUR8kzAWVQdyRfGOEETLDkgf0vVBZzJwBCOfxVv+FGX0q5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zOLJ4nnqqt+OA24Ml6MgAIAVE470jupE0aJPCKC2ZyY=;
 b=CfoferqdyPVP6YaP9HrioPtAd8vBbSeS3wGLxkCXn3WekmTTxZ9vLDf0mUmzVvEPBNevZHSp/7UL5HHV4liTZvYZtlNp2VcQ/BcpQqijScrZuzLa8Q120kMRuDs/1qW6r7puOnm9dwdIOYns+AiL3DTWTq7TttapGxgHQuzitK0=
Received: from DS0PR12MB7777.namprd12.prod.outlook.com (2603:10b6:8:153::22)
 by LV3PR12MB9331.namprd12.prod.outlook.com (2603:10b6:408:219::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.202.19; Wed, 15 Jul
 2026 13:08:16 +0000
Received: from DS0PR12MB7777.namprd12.prod.outlook.com
 ([fe80::826:25fa:4fd6:2d74]) by DS0PR12MB7777.namprd12.prod.outlook.com
 ([fe80::826:25fa:4fd6:2d74%4]) with mapi id 15.21.0223.008; Wed, 15 Jul 2026
 13:08:16 +0000
Message-ID: <7c9dea7d-a551-6f6a-3c3a-e0b55497c645@amd.com>
Date: Wed, 15 Jul 2026 18:38:06 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [for-next v4 0/5] ionic: RDMA completion timestamping support
Content-Language: en-US
To: jgg@ziepe.ca, kuba@kernel.org
Cc: leon@kernel.org, davem@davemloft.net, allen.hubbe@amd.com,
 andrew+netdev@lunn.ch, brett.creeley@amd.com, edumazet@google.com,
 pabeni@redhat.com, nikhil.agarwal@amd.com, linux-rdma@vger.kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, dwmw2@infradead.org
References: <20260610154216.712374-1-abhijit.gangurde@amd.com>
From: Abhijit Gangurde <abhijit.gangurde@amd.com>
In-Reply-To: <20260610154216.712374-1-abhijit.gangurde@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA0PR01CA0067.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:ad::13) To DS0PR12MB7777.namprd12.prod.outlook.com
 (2603:10b6:8:153::22)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7777:EE_|LV3PR12MB9331:EE_
X-MS-Office365-Filtering-Correlation-Id: 540cf019-0321-4907-e1f2-08dee27221f7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|23010399003|7416014|376014|1800799024|18002099003|22082099003|56012099006|6133799003|11063799006|10067099003;
X-Microsoft-Antispam-Message-Info:
	hF8VFOv9K5OdDVdxp/Oo8jSMHWZF325tASEJ9oNBy6ehOlX3G2FdgD9uGerhD4ud99ZyJ5dPLSi0QsKE+C9GX6Du2dsa8nla1IHriakGOyUsOO9oCq8Gs/saKMZLv0IMLHRvOGvWHhOPYQmij84ez4IKVhg+c5a89/P9OIA3Pofod6SYLqSPuRsJmJv/52WqnT6Mj131JfCm+e78iiKczeVL65LkC4R5nP/G8UvFuXBH/DaH9fFK9BEnKjdhjofVqR2YOOBuCauIxn9pN9ey7noGqpBCYJeC20E+mjGNDS/Q5u7SIPXQ1T/rUUUBRRlXplpq/4u12G5MlhxWetRHSoFTNLmFc736o2QZH9Zt4+dh39Na9lA3tx2ZhWuaMpF5ohZtEeortNtujXnLmQ3X+9sZVDaLC0vJow1UXKSmwvLk4M4iE8ETExt06dBdcQYPxMdkmsa77eibNApUdDC7Q1fkUplDl7UvTIsbYCZVIW2BlZHuJ1S9+vF0rk9s7PCfa4PsVrb/m98LQqvAdFT2BKVZA81piAEj8mHj41hffgsJ/OOxgZdQM4NeK2dHofkiJ5uNdneZS5WfzMqtz0rMbt6F0O8mspSo08DQKPjT7P+ZxdcOtwJWBSgALMn328/P7QfwusK5iqkArkCz5E6kbBWAhrqMuzE7fP2lDvUlfJM=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB7777.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(7416014)(376014)(1800799024)(18002099003)(22082099003)(56012099006)(6133799003)(11063799006)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MHM1OFBTckRNclVWcjNRNXZBS3dWYS9wa2VEb1BXbUxxUDdiUGc4UDRCbG8v?=
 =?utf-8?B?OURxa0g0VDhxWnA1MEoyZkFqclN6SWJxWkxpV0VpdW0xWGpQbU9sSGplWFVF?=
 =?utf-8?B?TW5QVHBPNDh2TkFqRE0xY3ZNMktUamZ4WHBVMFgxdEZ4VXU3UU9kRkhSeDZT?=
 =?utf-8?B?QmpUODB5Wm5wWDVydFlKdFlzdmVCT2hSSDhYVTJqUnNtam5TcHNiVCs4cHZL?=
 =?utf-8?B?VFgwYzU2dzJ2UUdpVVhOcVdYa0hmSmk2WEg4SnE5bXptR1ZwVjRoODNJRURp?=
 =?utf-8?B?eTFDLy8rc3FhTWE0aDBkaUhHd1k1Q1JaVWhkZ3dDU0ovZWlMQzB5bWUzRFNB?=
 =?utf-8?B?KzRlUHNKMWY3NHRNdWF0dk1TcUFxL2o4MG0yTml5NU9PT1F1SzBYcjhzTlNp?=
 =?utf-8?B?Nm1RTHVmRlVaUlBEc2ZRZ2lvdHhiS0M4UVVkWUI1T1FQenNwSW54bzNsZjhw?=
 =?utf-8?B?SFlpOWlXTTJKaUp2b0hzb0RqeHhDWTNTY0xBUk1VVU1MbVp5OWxDcDZESU43?=
 =?utf-8?B?QjFINUQxaVhjVGo0Ynpvc3RCRmhsZzhTNWZBb05SK0IvRDFHT21kQTgyQkdE?=
 =?utf-8?B?U2Raa1ZRamZ6cnZvd1V4KzFLMGVTKzBMa2FXMWxtV0VXQytoc1M3VUc5MWFD?=
 =?utf-8?B?WVlpSW84VW4xVWI1SXhucThUdmg0M3YrWmh1RUJyMCtEZVUxWFVOZGhrcS9v?=
 =?utf-8?B?ZURpN0orUjlxeUdrRkdqYVo5UUJndTdWZ1MwNnBKcEZTTFRtY2FMejU0ei9a?=
 =?utf-8?B?cDdCS2J5WTdKQ0YrYjA0Y0dhNWFXbGRDSnZraFZFcTRtYU9ZajIzRmVWYnNF?=
 =?utf-8?B?bklmN0FzTnpNL1llRnVBRXR0NHkxMXZTdGtQY0FoTVZ2RFNtSnFuelN5Y1Jv?=
 =?utf-8?B?c0pCTU5zV0c3N0lIK0lBQ09Bc2dCMGF5YW5hY2JXc0k4YytzSjJjN3c0Q1dy?=
 =?utf-8?B?cFRxU1JDOVlzZkNiUG1PenMwcmxqQVZiNWJ2Uzg3cEhPSkQxSWwvbE5Qb3JE?=
 =?utf-8?B?RXd2UDhCYTJqVE5vczBwaEZNdU42dFNZY2oySndxWG43aUJTRmg3OWxqM3JS?=
 =?utf-8?B?b3RoY3lzYWw5OHBZZlhUUisvaVhHMUl0SmtxYm1IVkQyK0YyYW9WZWNhd2Vs?=
 =?utf-8?B?T3hPOHVVTXIwRENRS1FyK096QkJ2V2ZBV3ByTGE5VmZ2aEdITWJIdjlIa3VI?=
 =?utf-8?B?bnFwR2lQUThxc1plRmpDWktuQjlLU1hnWjBEVzl6M1NEWUdKUEcvOFVhRGJ1?=
 =?utf-8?B?OU1hd1ZuQ2ZGUGFuR1RPZTJ3emFNODc0NjNNUU5jUC8rUTcxMzA3ZzEzVXRX?=
 =?utf-8?B?SDhxZnJ1N25GVmxwaGttYU04bURHY0ZJQ2pxZHdHUDhvYnhCQnlvL24xaDNs?=
 =?utf-8?B?WklhUzNpTVdpbEVWM1FDV3B0UnN5SitZQi9MOEJaUUt1dEZ0ZWpFZmJ0SkY1?=
 =?utf-8?B?ZzJqVXFWWnE5OTl6TDlkWVI2REI0Wkpnak5BdVZURjYwUGxyV21VWk5nZERm?=
 =?utf-8?B?SVRqYlJnd3pwOVBMdFFDRFFFTUZRVkl6dHZ5YlkwRnBBdFIyT2VpZXFNOHBV?=
 =?utf-8?B?N3FSdWtLZTZkUHd0TEd2ejR4Z1JwbVJvTzlIUkxlMlRUMjZCRUtzaFNUQU5I?=
 =?utf-8?B?aHV0djV5VzJlRDFFUjF6dFFiWnhOVmZTU2FId21FYnR2bEkwdE15dEREV29U?=
 =?utf-8?B?eFhaSnc0ZDZHVUw2TUFBdmRSZ3FPSGJlcHBZNEdnc1JxdnNhMnZGMWdXdU9K?=
 =?utf-8?B?KzRFRXlmSklWWlR1UE1kdit0VUp4RmpQcEdNOEdUa25PdW84cHpQWENOTUw3?=
 =?utf-8?B?VjlNdGdFRzJsR09wZkF1ek1XaFVEbG44YkdmT3RWSWFDdFhqWWF4T2RzTm5B?=
 =?utf-8?B?TjlKRkpEUmw0dndNS2l4T3poaDdoMDdvbGtaRjFSa3Y4eUNqLzk4ZTIyempx?=
 =?utf-8?B?WmNIWGc5YnV0SGRIeU00RUxta0drb2p3SVY4QWVMT1EvSm9uUjdZVzlrM0hN?=
 =?utf-8?B?ZzBScWpONk1CRS8yQWg3T25DRzZSQTdKSlA5MmdGZC82VW9iblhjMW91WVFO?=
 =?utf-8?B?N0FqODZnSWpXMmdvcEErd3phK0tsZUZSR0ovQUpJTEZueUJkRVEybWt5eW82?=
 =?utf-8?B?dkk3VENjWnF5ZXVYc3M0WG1CNW5iaHVFM3FmTk5zcWVpNEhPYjRpUE95MmFH?=
 =?utf-8?B?T3lWYXB1dC9Nc2NCN2ZoRDluR0pPT2xwWW9iY0ZvT09zUlU2K3ZwRTBCaTcr?=
 =?utf-8?B?bHF3ZG1waE5DUC9nODBVOGpxYXE2eEFlTXZMbGxNNEZmeUFvaHhQV0FGOGs3?=
 =?utf-8?B?VFVla1NFOGU1UkJtSDE1VkJVVDJJUjA1Q0JsSVF6WGV2OElJLzZqQT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 540cf019-0321-4907-e1f2-08dee27221f7
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7777.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2026 13:08:16.1049
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WZkxj+m/RLhEClh3V3NEqABI6W7iYFejOzlRkgkfxA31VvlC94sj2OCt8V6cosSDdUOKl3fYJ3kPLDMABam1kA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9331
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-23280-lists,linux-rdma=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[abhijit.gangurde@amd.com,linux-rdma@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:jgg@ziepe.ca,m:kuba@kernel.org,m:leon@kernel.org,m:davem@davemloft.net,m:allen.hubbe@amd.com,m:andrew+netdev@lunn.ch,m:brett.creeley@amd.com,m:edumazet@google.com,m:pabeni@redhat.com,m:nikhil.agarwal@amd.com,m:linux-rdma@vger.kernel.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:dwmw2@infradead.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[amd.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCPT_COUNT_TWELVE(0.00)[14];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[abhijit.gangurde@amd.com,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,amd.com:dkim,amd.com:mid,amd.com:from_mime,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 2049A75E925
X-Rspamd-Action: no action

Hi Jason, Jakub,

Gentle ping — if there are no further concerns, could this series be 
merged through the rdma tree?

Thanks,
Abhijit

On 6/10/26 21:12, Abhijit Gangurde wrote:
> Hi,
>
> This series adds RDMA completion timestamp support for ionic.
>
> It enables PHC registration for RDMA timestamp capability, exposes a PHC
> state page for safe user-space reads, maps that PHC state through RDMA
> ucontext mmap, and extends the RDMA CQE format to carry completion
> timestamps.
>
> With this, user space can read completion timestamps and convert them to
> wall time with low overhead.
>
> Provider's PR: https://github.com/linux-rdma/rdma-core/pull/1724
>
> v4:
>    - Added alias mapping of mlx5_ib_clock_info to ib_uverbs_clock_info
> v3:
>    - Renamed ib_uverbs_phc_state to ib_uverbs_clock_info
>    - Moved mlx5 to use the common clock info structure
>    - Addressed review feedback from Sashiko
>    - https://lore.kernel.org/linux-rdma/20260606050003.3648306-1-abhijit.gangurde@amd.com/
> v2:
>    - changed ionic_phc_state to ib_uverbs_phc_state and moved it under
>      ib_user_verbs.h
>    - https://lore.kernel.org/linux-rdma/20260512092623.1157199-1-abhijit.gangurde@amd.com/
> v1:
>    - https://lore.kernel.org/all/20260401102501.3395305-1-abhijit.gangurde@amd.com/
>
> Abhijit Gangurde (5):
>    net: ionic: register PHC for rdma timestamping
>    net: ionic: Add PHC state page for user space access
>    RDMA/ionic: map PHC state into user space
>    RDMA/ionic: add completion timestamp to CQE format
>    RDMA/mlx5: move mlx5 clock info to common struct ib_uverbs_clock_info
>
>   .../infiniband/hw/ionic/ionic_controlpath.c   | 34 ++++++++++
>   drivers/infiniband/hw/ionic/ionic_datapath.c  | 43 ++++++-------
>   drivers/infiniband/hw/ionic/ionic_fw.h        | 12 +++-
>   drivers/infiniband/hw/ionic/ionic_ibdev.h     |  2 +
>   drivers/infiniband/hw/ionic/ionic_lif_cfg.c   |  2 +
>   drivers/infiniband/hw/ionic/ionic_lif_cfg.h   |  1 +
>   .../ethernet/pensando/ionic/ionic_ethtool.c   | 12 ++--
>   .../net/ethernet/pensando/ionic/ionic_if.h    |  1 +
>   .../net/ethernet/pensando/ionic/ionic_lif.c   |  5 +-
>   .../net/ethernet/pensando/ionic/ionic_lif.h   |  3 +-
>   .../net/ethernet/pensando/ionic/ionic_phc.c   | 63 ++++++++++++++++---
>   include/uapi/rdma/ib_user_verbs.h             | 33 ++++++++++
>   include/uapi/rdma/ionic-abi.h                 |  1 +
>   include/uapi/rdma/mlx5-abi.h                  | 15 ++---
>   14 files changed, 179 insertions(+), 48 deletions(-)
>

