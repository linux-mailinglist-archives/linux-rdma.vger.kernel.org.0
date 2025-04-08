Return-Path: <linux-rdma+bounces-9280-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 10042A81780
	for <lists+linux-rdma@lfdr.de>; Tue,  8 Apr 2025 23:18:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B235F1B65F9F
	for <lists+linux-rdma@lfdr.de>; Tue,  8 Apr 2025 21:18:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF094253F1D;
	Tue,  8 Apr 2025 21:18:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="MciBmVqF"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2058.outbound.protection.outlook.com [40.107.100.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13E742185BC;
	Tue,  8 Apr 2025 21:18:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744147099; cv=fail; b=fSCmiESeKDvmE/P6bQ3CJTt6Be40jPNIkLSPit5cI822I1PwYIBou0tjuUuGcNDR2Hqq1N+DDec1YsnlHf0va9DfVdODWjkYR+vslSnWKv6geGo7w6+dSuTwbiB/xNf0g91D7LFM5oLRYuvLhJPHSunNR79YD62GroNK8svzUAk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744147099; c=relaxed/simple;
	bh=X9ofldsQ7eBsAk3bHDNrrMgwzEYhoY9dfMaETHOd1qs=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=SresezIax2F20yYVTCHhaQ1x7NDlakdGzLzDqphgluUDF2YS/tD00HfeJh12EMA7AgSeKvp89NYcW2G9NOK2gMm/8x27Z7GSZWVVySOowd0tjKIp9Exqen3KSrlIFSMiPuTxYHmZo3leiaxTzBrMOQjKMnpd0jmEF1gntc4jFqk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=MciBmVqF; arc=fail smtp.client-ip=40.107.100.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cGUmkdtz9/3K/tW4bjjjHvtMRpUUsmul4jcMGzhTMyEqVDd+CQ0JKaqdF/BM/ig3Phrc0ACRCS5FE64poVw5GHiA3xS6Q+eNUsWZi7RLXlbStGyu2sfz8YFBndBAYpkjaVTvwqK77go5pQzIcJS8bSuuyQC0XGVT6ez9F81cD599mJDrtjXav+4Lnh2bcX4O5S3qBin6TNCK+AoazXrOebubnaYm9xXtLH9lkSPKqNatYXx7f6vGHggs1qawhyMfKc4n5lXAF5DLM5gAoAT+huJhHl93NJoHvK3Zue8xhYLWXD1HuTmMhdg4TP6vD23/TaotSi0Biq3wjijtznKU3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qG5PELWYI8C/ecoQzg3aKpP2Y18n9xOy9NXmCJXElW4=;
 b=N8HPsu12289n22+RX184O5ulUkjqDgjDHFb7Fu8aZXI5DQyLNkfbt5rS61inWGAw6QMKgbSn00uL2ScHQhEbRqcmMIPmlEXIkuoBcS6mhywVorlSQYO1bNXFBbc/g3ermNLM/BOB0t/2PEzpVYkKSjjD3jyKKPtnxDD9rrxTLH+ApqgUDigmmVxGmxX50JtLNxAE5Khq8eHujU/KDf5jPSSHGa0QpN9HFRgojsGiGgI/fzKeX9VwzLl4jHwVZeY+oveRpwkPRTVj11fkhsMpdlVytBmxePwayvoeveRybn2p4pL871irVDXefjrlTi139mD9Gflmbkq4RMoCWRWK6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qG5PELWYI8C/ecoQzg3aKpP2Y18n9xOy9NXmCJXElW4=;
 b=MciBmVqFpur+qGt0OQ32Np4cnibsn17DUAgmravFKxYi1Rl+dhxXBbheB3RXlogqmCVmwkqMcIWhhqWMjSAhRAen3q5J1hRhYDHIU8k10bboNGOt0Dulng2wv/YKzFumuA1T+yR9Zs51aisgREltI7rTC07azxFBHMu1o38kQ+o=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB6583.namprd12.prod.outlook.com (2603:10b6:8:d1::12) by
 DS4PR12MB9683.namprd12.prod.outlook.com (2603:10b6:8:280::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8632.21; Tue, 8 Apr 2025 21:18:15 +0000
Received: from DS0PR12MB6583.namprd12.prod.outlook.com
 ([fe80::c8a9:4b0d:e1c7:aecb]) by DS0PR12MB6583.namprd12.prod.outlook.com
 ([fe80::c8a9:4b0d:e1c7:aecb%5]) with mapi id 15.20.8606.029; Tue, 8 Apr 2025
 21:18:15 +0000
Message-ID: <c7dbeaf7-ab93-4b4f-904c-99d42a83a83d@amd.com>
Date: Tue, 8 Apr 2025 14:18:12 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net: rds: replace strncpy with memcpy
To: Pranav Tyagi <pranav.tyagi03@gmail.com>, davem@davemloft.net,
 dsahern@kernel.org, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 horms@kernel.org, skhan@linuxfoundation.org, netdev@vger.kernel.org,
 linux-rdma@vger.kernel.org, rds-devel@oss.oracle.com,
 linux-kernel@vger.kernel.org, linux-kernel-mentees@lists.linux.dev
References: <20250408194153.6570-1-pranav.tyagi03@gmail.com>
Content-Language: en-US
From: "Nelson, Shannon" <shannon.nelson@amd.com>
In-Reply-To: <20250408194153.6570-1-pranav.tyagi03@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0345.namprd03.prod.outlook.com
 (2603:10b6:a03:39c::20) To DS0PR12MB6583.namprd12.prod.outlook.com
 (2603:10b6:8:d1::12)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6583:EE_|DS4PR12MB9683:EE_
X-MS-Office365-Filtering-Correlation-Id: b5cddc73-bb65-4110-4998-08dd76e2dffc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|7416014|921020|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ckxjNmpaWU5qY1oyTXJJQ2dTK29jUU45Rk4xSG90SGxzc1hkWXdJVUJCRXl6?=
 =?utf-8?B?a2RrdEFOY0Vqc2wrQ3hzZGpCMGNkVkhYRG42NkVwRkJVM1pqUzIvMmo5cEll?=
 =?utf-8?B?NUZNMnlEYy9jRTgrZDZpWG9jMkVNNzBxUngxWTJzRGVCR2pVWHJwcnRCRWcv?=
 =?utf-8?B?TlZyeGpwdHcwNnVVOE9hOW1maTh6NDdnUy82VTVPNFg5VmlhUTRwK2hDN0pZ?=
 =?utf-8?B?dWxMN0RYZE4zMkl2N2plQkRnVmYzTnZPTlNkdUkrSVBtNGxlOFJXOThCUysz?=
 =?utf-8?B?YUNJNk9nb3BDSTZNTklsazVLQmE1SERsM0FOR0UycE9seVR3VDk1anNyU2JE?=
 =?utf-8?B?MThWTHhCckhVUGJMU3poanR0bFNwU3BZdlNteHpIUWp2WEl3amtnRzdTSytw?=
 =?utf-8?B?WEdFQTg4QTExNGkzYzhaOG90RmUrUTBDOFd6TndiMnhtS2FCZjRXb1psNTdm?=
 =?utf-8?B?ME5LV3Y1UW8zd2dqRTd1QlJmcTVIU3g5S2VUSDFDTVlYdFdiYWtLWm1UVWRR?=
 =?utf-8?B?R0YySlphbmlEOW83SGI1Rm1za2REcjRJR29SVEtzZFNPRnh0SzhBV0p4bkNE?=
 =?utf-8?B?bXlGL2o4czEwZEM2OUFhcVRHRlRXTXVxM1YrWDVHOGJYMktlY3FRbmV6bVZw?=
 =?utf-8?B?S1lkaC9HT3lPL1p3eUtpUTVPZVR1R2FnRjFxT0MvUkFDMitlK2JpdWJ6RFpX?=
 =?utf-8?B?bFZKYzRSRDJKSE1LOUxncVRlMDR1eXg1NVZpd09lNmUvV0hsa08yenU1L1Iw?=
 =?utf-8?B?RGVMVXdpbWZLdUpkakgzUjdpY0dNZDdUaDUxd3NZU3BaVWJ1TG42Snc1QkFh?=
 =?utf-8?B?b1M5cmFTcDVaVHdLdWZVR1E1eVpleHUrb2E0TWhNcWtaVzhLMTF0MS9rNHZI?=
 =?utf-8?B?VzYxSXJ1WjFKVnBMSVdGTzE5NE5vU2FxZkkrR0dGdVUxWFhtR05ZTSs4eHQx?=
 =?utf-8?B?UTNLOThQYlFORVRENGZmWlBwNjJmajZJRlh6c2UrZlRtM1JVM3J3R0pYT0lU?=
 =?utf-8?B?cndRY2MrWEI2SzVOUzZ3ZzRhZWVlQ1J0d2pvNWJSVVUxcUNFc3Z4S1NFcjA1?=
 =?utf-8?B?S204aG9SNmRkenBqSUp5VXdYZXh0MlVzcGxpazkzeCtQaHhZS2l6cktVTWNH?=
 =?utf-8?B?ZHMydjBDK0p5VkVxdk0vc1V5SnRuVzVaMlZoSmdaRnhUQjFUZjY1NnNSNEdC?=
 =?utf-8?B?Nk1CZHZTMm5vVE9EU3duenl0b3ZuSFN2eC84ZzJMaVNqNk1iYkJTempMMnBy?=
 =?utf-8?B?R3ZudENiS1pZYVhWUy8zbFBoV2c0TVhGRXgwUzZMR2xYMjUxeWpkRk02WU9E?=
 =?utf-8?B?cXFYMkNUODBaa0FFWEE5ZHlBaG1zZXFPRUozYlFTelFBVmpLaHc1NDZLYU4x?=
 =?utf-8?B?aEFoQXZ4RG9GUVUvaWYzL3MvMFNuc1l0T3htMG4xcVpGaDBYSGMyQzNZQ0NL?=
 =?utf-8?B?ZDhkQ3g0TUc1Q3BmTnN2cGIxUU5sa2swbmJVdm1Tem9Rak82KzRzRkFMeDdO?=
 =?utf-8?B?eXBraW1ZNjVLTTk5elJhSUJ1ZUF3SSs5OXVPdlIyb1hlK2dWckhGQXNQcGVY?=
 =?utf-8?B?a3pFQm5YVnhWMlozL001K2JjWmdzaEhLVE45SVJyaEhmRUF3WWFOTVduWm9j?=
 =?utf-8?B?K3NGWlRhcWJUMDExN2JOOXhZdTZzaDRIT1NWZ3JzRHovSTI4NnBCZ3VpaXU5?=
 =?utf-8?B?cEFlZ283d0NncUZRMFpkTDJrTFVnUFRobGVxWE0zSkNYQ3lnQ1FqUjZrZjh3?=
 =?utf-8?B?blNWaUdFelpFWUxPSFZvRVZwaCtuWngwMlpDRkhWTEVDQ3hkK29FaE1Wblcx?=
 =?utf-8?B?VW4yYXkxTDdXU3FRQW82OWVoUlZsU1RPdVRwMUFNdURBWS9DNm4ySDlEd1pm?=
 =?utf-8?B?Y2lLdkZBcTRtWTAydmJtdS9yUGdJR2diaEVwNDd0bWhtRUN5aXhjMnFWYVhm?=
 =?utf-8?Q?TCS7PP2EFaElcD4pawAIe7fPLPwiWzr1?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6583.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(921020)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RmdOd2kzc1A4YU5QejMyVTFYVnV2bGROUlV2TUxsZytwZ1h2LzNNR1ZLZmRB?=
 =?utf-8?B?UFVlaVBNT244eWR0c1AzUUEzOTBNMnBHeTQ5eHRGcXpBSjlaaHpVbEtsTWJC?=
 =?utf-8?B?TkNkQTZaU3VNdFprcUlrQU9Ta0ZWbStqZWp1RnhETzZsd0hiN0xJQUhMcyt5?=
 =?utf-8?B?M2w1VHRrcFpDNGN3TTA3QVRkbFNrbXBhVUpvUVJIRlZ3TVM1aTZPRWpickc0?=
 =?utf-8?B?Qm90TTNsdVY3L2xiaHRCR1dVZGVxME5LVnNsRmV4S1NOMjhOZ2l1WnkveDdl?=
 =?utf-8?B?TndtWGFPNEJlZjQvYTh6Y0lFckhhWUtEMUQxeDhmbWF1Y3RSWmVZbWI4SE5q?=
 =?utf-8?B?RytLNG1vUzMveTByRUVEUUJPTFYwODR1N1FRbTNuenZiYmVrUTJZUEcvR2Y2?=
 =?utf-8?B?dTVObkY3QUQ0aWtucjg0YmMyWVo0ejU4RVdBQlFOenRLZmlQbzRwc20yZkVR?=
 =?utf-8?B?eVl1M24razNpUWlMcHZkcmk5YXQ5WEtlR3VDYlZhWnpnNmwxSC83NzR0UVpI?=
 =?utf-8?B?OHpPcnh3aWlsVTl6MnJibm55Wnh4Vk9BYTB1VnpDNWRnVlBnTGZXWWdCb05G?=
 =?utf-8?B?dXh6bDM2ZC94aDlLNURLcWNQQm56RFU2RjRrYXhQV0NqZE14aVdaQUtXbjVT?=
 =?utf-8?B?VXQrdmFFMkt6SlRYMCtDUHViUU9vVDFRcjR2bFFFcjRoUk5kV1UvY1B3aWhD?=
 =?utf-8?B?YlEyQ0ExVUVzNE9rOU83REw3OG5iSjlOWmI3cDBTR1NKSXpDUkU4QnZxMjc3?=
 =?utf-8?B?NC9OYnJhc0l3UTNoZ0dqeGdiUjFQblFlOGQvZXBiWWxXMDhIUnV4YUI5eTJN?=
 =?utf-8?B?RS8yOTlONkhyNURHbzJmcXNUQ05UNzA1bkFqaGJMcFZta21aRTdqWXoySnMy?=
 =?utf-8?B?azdWbjBlY1lRZzlmWVdERHM1ckQyR1Z6WVdNRXpIeDk0cWQ1VUVVbEtMSVF4?=
 =?utf-8?B?dXVvUVRvTW1TL1VVNnVKdWZ5Z1B0ZlRuSmVLdHB6MnJSTml4MUMzVTBSTy9S?=
 =?utf-8?B?ODFtaDJZVERKUVhhSDFReloxS2FXNUZXQmVNYVpjZmVUVjVHanV6TGJYdlJ3?=
 =?utf-8?B?YXRPU2pubUFGTDhKUWpaYmUxVzRKNXpabWNpR0JhQkxXaFUvV1VnWE1MUlhG?=
 =?utf-8?B?TlJRVjlCakVxNk9xN3dTb0Zwa3pNV1J4QUU3MGZPK0NaWlU2TWU1bmEzWmtm?=
 =?utf-8?B?ZVovSnkvbThCc01scFVFUnpnTUtSUjF2OTN0T1dpbmJLa3hKN2t5TzVmS0Vr?=
 =?utf-8?B?bS80RmdoRnpKeGhmS3BIaUNlRTZndDB1NlpVOFVhL2RlbmVpdS8rMEpVL3M3?=
 =?utf-8?B?N00vTDBBWmZPK0ZxV1BudEVVQ0xvMWhhTTgzTlh5VDhQbTE0a0YrZWFzL1N4?=
 =?utf-8?B?V0VmOHZqcFAyYU11Tkk1SVJLN2pETTlTRHNCM3BGL0hVY1psOVcrdFdVOUNt?=
 =?utf-8?B?WGdjNkhVQW5MclN1c3FZYU5kU0pLbmxTQmJMWlNKYTJVYm9TRW5qWXNrN01q?=
 =?utf-8?B?VVVqajlqOFJsWjBrQXQrOUJmeDdFcDZtcnlkRTB4SlVjK2I4ZTc5bnhiNkMv?=
 =?utf-8?B?TmhQT1dzcjZrWDA2YWg3czZMeFlvUGxxWHNGeFpYeEJVSXFqNmRDWEdXbjM2?=
 =?utf-8?B?RXdsZVllSG5razhWZkV4UXR4Y256Uy94WU85MmhoVVVqOFBDcnZVcGo5TkJU?=
 =?utf-8?B?d2pWbUNMZ1hjRlN6ZURzS2toUkVrOE9SajVBQlduSHg3elBtYWVkQjBPSU12?=
 =?utf-8?B?clB4dUg1eVZFSjhvczE4WXF1alNoQkZIYTQxZnJlbUZIclVUWmxiQ2g5QVF1?=
 =?utf-8?B?T2RJdzk2bzBldTJKRVpwS2RlbDFDZWlkNFd3UTlhUzlCc0ZaWC9ydVQxVVlS?=
 =?utf-8?B?VkxoSERkbDc0NGdzTU9CM09TZUxtMXJYZ2lVbUxMTDlRZFkrN1NQRkxROXB3?=
 =?utf-8?B?SGhoWjBOVG40WnhBQWZpS2hnY0h4WUg1eHZ5M0pocjFuRTU3ek9LcXlBcUZX?=
 =?utf-8?B?bldTc1E2UGVnaVd5Y3kwRDhaWlFkeXFvMHlmWXBMV3VLczRJUTNXdGZlSE4y?=
 =?utf-8?B?dVdta1RXeHZHR2xGYWNvb01yb0JoYldrWnZWaTRnN3B1NENxTkZCdjczRW5Y?=
 =?utf-8?Q?jeV3pFYzxTLF1scazP5rQJlL3?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b5cddc73-bb65-4110-4998-08dd76e2dffc
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6583.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2025 21:18:15.0930
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0tncJlu5BSZesszBimcyPRM24qmYOP7DZs5SpGiCdeKHQV1HWI134DoMQmXszGXXL5G48wCHq3AlMJlQKqzsrQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR12MB9683

On 4/8/2025 12:41 PM, Pranav Tyagi wrote:
> 
> Replace deprecated strncpy() function with memcpy()

I suspect that strtomem() is a better answer here than a raw memcpy() - 
it already has all the strnlen() and min() stuff baked into it, along 
with some other compile-time checking.

> as the destination buffer is length bounded
> and not required to be NUL-terminated

Are you sure that null-termination is not required?  I'm not familiar 
with this bit of code, but the definitions of both of the .transport[] 
fields do say /* null term ascii */

sln

> 
> Signed-off-by: Pranav Tyagi <pranav.tyagi03@gmail.com>
> ---
>   net/rds/connection.c | 6 ++----
>   1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/net/rds/connection.c b/net/rds/connection.c
> index c749c5525b40..3718c3edb32e 100644
> --- a/net/rds/connection.c
> +++ b/net/rds/connection.c
> @@ -749,8 +749,7 @@ static int rds_conn_info_visitor(struct rds_conn_path *cp, void *buffer)
>          cinfo->laddr = conn->c_laddr.s6_addr32[3];
>          cinfo->faddr = conn->c_faddr.s6_addr32[3];
>          cinfo->tos = conn->c_tos;
> -       strncpy(cinfo->transport, conn->c_trans->t_name,
> -               sizeof(cinfo->transport));
> +       memcpy(cinfo->transport, conn->c_trans->t_name, min(sizeof(cinfo->transport), strnlen(conn->c_trans->t_name, sizeof(cinfo->transport))));
>          cinfo->flags = 0;
> 
>          rds_conn_info_set(cinfo->flags, test_bit(RDS_IN_XMIT, &cp->cp_flags),
> @@ -775,8 +774,7 @@ static int rds6_conn_info_visitor(struct rds_conn_path *cp, void *buffer)
>          cinfo6->next_rx_seq = cp->cp_next_rx_seq;
>          cinfo6->laddr = conn->c_laddr;
>          cinfo6->faddr = conn->c_faddr;
> -       strncpy(cinfo6->transport, conn->c_trans->t_name,
> -               sizeof(cinfo6->transport));
> +       memcpy(cinfo6->transport, conn->c_trans->t_name, min(sizeof(cinfo6->transport), strnlen(conn->c_trans->t_name, sizeof(cinfo6->transport))));
>          cinfo6->flags = 0;
> 
>          rds_conn_info_set(cinfo6->flags, test_bit(RDS_IN_XMIT, &cp->cp_flags),
> --
> 2.49.0
> 
> 


