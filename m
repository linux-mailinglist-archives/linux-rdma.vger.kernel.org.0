Return-Path: <linux-rdma+bounces-19875-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UGHfI3n+9mkabAIAu9opvQ
	(envelope-from <linux-rdma+bounces-19875-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Sun, 03 May 2026 09:51:21 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 0ABBC4B4D4E
	for <lists+linux-rdma@lfdr.de>; Sun, 03 May 2026 09:51:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E4F543007940
	for <lists+linux-rdma@lfdr.de>; Sun,  3 May 2026 07:51:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88D643AA1A6;
	Sun,  3 May 2026 07:51:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="NF2xEk9p"
X-Original-To: linux-rdma@vger.kernel.org
Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010034.outbound.protection.outlook.com [52.101.56.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1020A1F4174;
	Sun,  3 May 2026 07:51:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.34
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777794678; cv=fail; b=QfEpV2a/WbCg0TCgoYV8MmyRFARARzYHBWKC0MOGR0R0HZCegaQ1WRbAw5FWHVYD5GEWXqeDoUAIvA/3ZQw1zhk3rahOxyY5dTA0pwDG9KYB6W4T38MmNiWyAtYKcpYlsBOmNxMkPMqrfyHj/fl7/o0zyKJKBwKJVMdMRnS6L7A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777794678; c=relaxed/simple;
	bh=ZkvS8WGzicd+KI6pJMagA887NOgnzhaOvWJ1pNqAK/g=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=oiug01XAClCEjEiVOw5yoP3Ng6s6/Wq9YKGUeeDA1FfXauWilHuFclUdQB3U8gRwUVHd9P6OchducxL2WfHoPBKd/YhCaN55J9TMMu286pf5Q2P71bjIHh45SxGRNVmFtS5V97ejpx6xVF+dmN01QTgn0U6sec8bYUpW2Fu+Fn8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=NF2xEk9p; arc=fail smtp.client-ip=52.101.56.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nJQpS0aqbtoA777p52Y6K38Exp1ryBcdkY7jwkkr7GSkRH3yRHph0RSjdCIgcZigILvRNrsq59qj06XECmtiHe0VpmKYBeFXZH2zI6op9biBrQ3v00AfuHp5/2npUNwIFZVTCQKlCtTyV+ZS87ndOpVUnB6UaaP77GdzQn06G//wzeMFbYAr4UWzF0fiABhPpD2zTFvgInUF8HcX8F8aZJkJXB8wds7G/8VrgR1x74hCvaL5Fm3cd6jPyxqHske4K3cUmpaC+VShgdEL9ImSZW1J+83dSBTloifqZUPG4lU0PQ3NafNRrOsP1GMRr3M8L2IDL8Xmgmu1ANeF2/dCFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U67hlxXD52CtQ1gOOGEcb6xmha/+J7Z/d6dm/2ZFGkM=;
 b=Iv1pvQr4kXaMK1+m012bA3q4irdoRhrIKpjyU12UhbfTBb9VtTgFSA4Z2LtQhQ3MXSloR8yI5hJwMyVKpODT7dLUsPyRZ8szi2e5+/2vzJGKq6IVwup2nXNzMcoNPDACM3feJdd2n038QDnTCXw4DcKGrzhILizLJpT+ZWwURw3IWLk5TOngAxym4q27eGB7KJS9hVKMocYFPT8Dk0DcegMBJ6/04laQ0LNQAZKkTW3q9ymQs5ienSgZ2RQt1OgJUIGuJMJfpAptEPU/MFFkiGOkiQWh0uIDrLnXIvWiX/DDRKtxrm0nCn95CVc+WQvaLFIs/Ho7WgCq+LCnkWfLgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U67hlxXD52CtQ1gOOGEcb6xmha/+J7Z/d6dm/2ZFGkM=;
 b=NF2xEk9pN/mo9/7aw/ZtDVV5qy+88LzLK+qH9G5wIXOp2aVVw7sEOniOybey9p+OVFUJiQPmy6fXGiRCnh6NLN54novF0GesTcvbyxeYq7fV/Hyg9JkNWn2uo9ogo7sqHcWkKZMsZ4V8CfMf4yZs4YGw6ffsH2fPTWHW8HWgyD/jvbQpQ4j70Hxka+1RIJJGGE5JmMn6gQC4zotnEX0LWxA8cJe4Yd4K05AiEBc/R1IsiOU22imZ3dsjXmClux4KpWexvpnLmy7CNTG0HKWp3Alqbbta8Q/RvQ3QKxhFY74/3s7enf3pcHmtQ0CkRp3Br7ml0kuHLjfczZdZxG1Kxg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB7548.namprd12.prod.outlook.com (2603:10b6:610:144::12)
 by SJ0PR12MB6943.namprd12.prod.outlook.com (2603:10b6:a03:44b::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.23; Sun, 3 May
 2026 07:51:13 +0000
Received: from CH3PR12MB7548.namprd12.prod.outlook.com
 ([fe80::b710:d6a1:ab16:76de]) by CH3PR12MB7548.namprd12.prod.outlook.com
 ([fe80::b710:d6a1:ab16:76de%6]) with mapi id 15.20.9870.023; Sun, 3 May 2026
 07:51:12 +0000
Message-ID: <cc01cca2-0e5d-4db2-81e4-7ea9fe525320@nvidia.com>
Date: Sun, 3 May 2026 10:51:06 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next V2 7/7] net/mlx5: Add profile to auto-enable
 switchdev mode at device init
To: Jakub Kicinski <kuba@kernel.org>
Cc: Tariq Toukan <tariqt@nvidia.com>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Leon Romanovsky <leon@kernel.org>,
 Jason Gunthorpe <jgg@ziepe.ca>, Saeed Mahameed <saeedm@nvidia.com>,
 Shay Drory <shayd@nvidia.com>, Or Har-Toov <ohartoov@nvidia.com>,
 Edward Srouji <edwards@nvidia.com>, Maher Sanalla <msanalla@nvidia.com>,
 Simon Horman <horms@kernel.org>, Gerd Bayer <gbayer@linux.ibm.com>,
 Moshe Shemesh <moshe@nvidia.com>, Kees Cook <kees@kernel.org>,
 Patrisious Haddad <phaddad@nvidia.com>, Parav Pandit <parav@nvidia.com>,
 Carolina Jubran <cjubran@nvidia.com>, Cosmin Ratiu <cratiu@nvidia.com>,
 linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, Gal Pressman <gal@nvidia.com>,
 Dragos Tatulea <dtatulea@nvidia.com>
References: <20260501041633.231662-1-tariqt@nvidia.com>
 <20260501041633.231662-8-tariqt@nvidia.com>
 <421e8885-5849-4390-8956-9bc344fa0bf0@nvidia.com>
 <20260502184153.4fd8d06f@kernel.org>
Content-Language: en-US
From: Mark Bloch <mbloch@nvidia.com>
In-Reply-To: <20260502184153.4fd8d06f@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR2P281CA0164.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:99::14) To CH3PR12MB7548.namprd12.prod.outlook.com
 (2603:10b6:610:144::12)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB7548:EE_|SJ0PR12MB6943:EE_
X-MS-Office365-Filtering-Correlation-Id: 622eb244-7cbc-4055-f4c2-08dea8e8bf17
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|7416014|366016|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	VbgG4CjpC23E1/9sBQBmd1ige0IX0o6RAIYF8jhN3D1LlQxSdVafEseLnVWc5ygUDneFBLGB07X8Ef+qeKBeTI3P7eBX5t4GnrlPyBVPN0fRl1i98ptUXdJR1aqWgRPRYiTg2wH0LEfG0JWMOOH0UYpVVVPpe8dga4lLqd2jzp4QHmBCV45j2ewzDuVmrM5mCVLbDl+1DQe+yL2N9XhH/J5NZs47h9nwLKFrEY29rjkXzTni/oMdj3NhHdHOqp+za7gFcshW1ve/qepscXzXqeJSAVsQtsCmFTxGT9mysbwyYpall9o3ubhEKHZonrOfOH01xgYaUhOKvGYPAh0XtUrzOFpzxIQpTuPMLR3yaQjaPpF7dsgm5e6WvWwSEDdD9f9Ts979ySsk4Vnnu+H+6E8ovUyKtDdWqGLPuLH0G1cUSjnyN+Zer9DMBGXQ0OBpOHathXUVc1jbCJBOClYuX4oCsWXh8DR0+mAIumF9NmKXua6iQ1bCi6KX8HiOKt4EiXGBpUpgCsuu/m9BGZpk98L1pVcympURL0p+K+2wlKAhsWQGpnGKy/gtpGsUoY+n3EteEVA49fa1rLHUel2C1bBkuNXAZ3DWaED1dbAIIIE5ezEwKbMzXjyphmRDGmQl5mPwuR9NxNU8plOs7RTwjtPPwjMe/SMWxjDhRHjr0D/aAcUfR3AvnTcrKJpqXlxj
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB7548.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(366016)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bFdPd0trMU0wcFBtK1Voa3Nwc2tVVXNpUFJYYkpMODJobEhseUUzUStmT2RN?=
 =?utf-8?B?QnVPN3hjVitOa1Jmbm9sRHVWSkV6L2w5Tzk2TGYwaDd2Uy9wbHJ0UFM2NTNY?=
 =?utf-8?B?QjVyRmNqa1ltQ3h0c1RoNHNnVGE2UHVVZ3ZoYjZucHEzaDFxOXVXWnBvTE1Q?=
 =?utf-8?B?MWhnZzVCVWo3MDU5YjNURmdmWDNTcEtzT0ZYc29aOHFGZ2U5R3Y4NCtYMkVv?=
 =?utf-8?B?aEFtZUluQlVNZlBJUlM5bmYvSVVkSE55d1JCSlcrNlhTWDlKTzdzeFFkdzRT?=
 =?utf-8?B?Q1lwd01sOWJRWkpCcVRNQ2czNmpUeWFsZ3RXdzNsWWhyQVhhQkNQSEdYYTVi?=
 =?utf-8?B?NnRhR3dYN2htT1F1WWhoM0N1cFF0dDg1amQyQ2kvbUhVaUtlTVhQOXpESkhU?=
 =?utf-8?B?NVVLb1dxZlIxRUlpZjB1REN3UUpjRzdOTldEMU93R05NWFBrVDBBbGtmWWtn?=
 =?utf-8?B?OEovZk5wd21pbkhLUU55VEgyTk1lMTQyWVlXdXl1NDdYVWR2dFFKcmpIbjhp?=
 =?utf-8?B?aXo1c1dBbUVET0dDazFweWFLa01LSUlUK2dtejNGZVhwTy80UjhuM3lsRlBX?=
 =?utf-8?B?QXh0SEJtYlRoYzU2NVRERDBRMENGdjlQTWg5cmcwR25yQk1XWVNVVnNXUkhy?=
 =?utf-8?B?Z29zSFgvZmk3OTYyUG1UcnVJZjNBU3NNUDZhdVNCRGZkNHBSZ3hTdjdOblFV?=
 =?utf-8?B?WUFISkE0ZmZoVkZSR1I4TG9JSkQzQ3BWTHZsN09wdWR0RnRvQkhmdHZGeGFr?=
 =?utf-8?B?cm1hOTZickQwMlF2akRXRkpKVUxVcGxoQVNMOHlPdTA0cHFZZEdWV1ZmS0hW?=
 =?utf-8?B?c3JHaDN6NDN0VzgwN1ptVFRia2IzNzBxc0M3ZDBEU25EMzVZbU11S3IvSW9F?=
 =?utf-8?B?QUN0RzBiQ0V1dFhtYUdIMDljcjRMc0huVy9YcFlBVEluaVBMckpQaWoyaHVt?=
 =?utf-8?B?alU4R3dxb08xcWpLYXZJODl6S2JVTnhIMngwZXJMUURRK28wRHdLUU4zamdq?=
 =?utf-8?B?UXdEanNBKy8xT3pSZm1KVFBUNVV4MzNCd1RJN3B1emVrd0ZPUS9GQVBDdzNS?=
 =?utf-8?B?Zk1hYkY4NmFQUkU3ZlQzQUtqM214Q1FTY2FMTG9DdzM1WFVVTjZIMlROcFpB?=
 =?utf-8?B?MU5NV2ZSRFh0ZUQ0UFI0eURhU0toN241WGl1QXc0QVBjL2pGcTY4dWYvSUpq?=
 =?utf-8?B?ajhOaG05c0ZVOEF4cUVjblVINWtRdUxOY2JoOXRDcjFUUVhNc292UHZ6b0FQ?=
 =?utf-8?B?RVBwRHRDZ1l1UHZyQmx2L1ByQmZEczNQakFac21LMHR5SXZzbHBLM3Y2MzFo?=
 =?utf-8?B?eDQxYXlUdnRRZEN6b0JTd0RWRjBUbkVjMk95UjFKcTBrd1dIUkFWYVJIQlhH?=
 =?utf-8?B?MGxmeFh2V1Q1SjhWQ2Z2bU5ldElLOEsyRldqR21QTlg1Qkp5ZlYzbzNESGo3?=
 =?utf-8?B?VHcyd1lpZks2ODZGTnZ1d1o5YklJand2N0FXNDVnY2lnV2xrZUNrSldGTXc0?=
 =?utf-8?B?a1ZST2luNm9SNmdpQytLS25jdmJ3YkZpS01rVUZLTHNDcE02RHVrTDVyV1FD?=
 =?utf-8?B?cHNySkNRb25VbElXV1FzQ3VMQmdBaHl1cTJQWnlaTE9CczVqWXRCenkxWkNU?=
 =?utf-8?B?NGZzdUxPZTJwcE0rR0ErL29NQkdvMlZiR3FJZDF2YjB2Nk9tTjJ5NWpxQkFI?=
 =?utf-8?B?eG9jdllzV3lhdU12ai9GcWJDTURyVzdzY0t3aXF1bzNKbDBDbm1OVWpoVHk5?=
 =?utf-8?B?TlVNZ043VDlpdlY0OTVWbXIrK3FTUDVuUHBndzVGSnRDY041cUNpUU9reXpU?=
 =?utf-8?B?aDJxclJuZklONEoxZXJvWGJ5djBXWlZKKzRSa0lPKzBMT3RIMncxaEpjUzVM?=
 =?utf-8?B?aUFTVHYxeDhGUjg4UjlIOTlJbkt3QUVPYURDaTlkY0ViK3dzYUpWQ3RqeXFF?=
 =?utf-8?B?VlEya0xWbk9ia0I1NVA0TWxQVmI2d1NJMUtiajBUcUowYTM3R0VENjBEUUdi?=
 =?utf-8?B?dEZudkE2WEpNdEIxRlZPUHBqSk9yTEtnSmdLcHNFbnJoa2cyUHNNQWV6bDBO?=
 =?utf-8?B?dDgvYW5QRmpHMlZua0FvdGRYRnpIckZzd0ZLVVBNdno1cTlMMXJuYzNuc3Fa?=
 =?utf-8?B?VXZza1VIRHNzQ01nbUw3QzFyVzJyQkNWZXFEZDVUd1d4cEZQNlJsajR1STdI?=
 =?utf-8?B?bWNpNmFZNkJWWHFLc0Z2SDV3NmZVS25HOFo0YnZtK00yMkZQbEdVNW0ydWgw?=
 =?utf-8?B?ZFNnSnZIMWVsTjNRaHEvU0ZsaXdhckNXUGthcmhKODhZS3lLWnJjVFZsVVdv?=
 =?utf-8?B?TXpocDdtdkdGaTBOQWVBcENsK01CWFhTbklNZExFbXNZa2JjQzluZz09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 622eb244-7cbc-4055-f4c2-08dea8e8bf17
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB7548.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 May 2026 07:51:12.7628
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NxIfuVQ2KqzBqW2gTjbb/nfNVkzqCgqXfjPK7yLZZZ5P6tbFgthfh3BHQXi1ALDr7ape+t/VWxNMgkyvdVVuGw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6943
X-Rspamd-Queue-Id: 0ABBC4B4D4E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[26];
	TAGGED_FROM(0.00)[bounces-19875-lists,linux-rdma=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mbloch@nvidia.com,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,Nvidia.com:dkim]



On 03/05/2026 4:41, Jakub Kicinski wrote:
> On Sat, 2 May 2026 23:08:43 +0300 Mark Bloch wrote:
>> Before I respin for the unrelated MR_CACHE cleanup, I’d like to confirm
>> whether the opt-in profile approach is acceptable at all. Regardless
>> of this last patch, the first 6 patches fix real representor/LAG locking
>> issues and are needed independently, so I’d like to keep those moving toward
>> acceptance as soon as possible.
> 
> For probe-time config module param is probably our only option.
> I'd obviously prefer to have a devlink-level knob for this, instead 
> of a mlx5 specific one. Can we come up with some format that'd apply
> more broadly? devlink=[$bfd:]flag1 ? so devlink=[$bdf:]switchdev-mode ?

I’m not convinced this is really a generic devlink knob problem.

A device should probe in its selected/default configuration. For DPU
deployments switchdev is the expected operating mode. mlx5 just made the
wrong default choice historically, and this profile is a way to move away
from that without forcing it on everyone at once. I expect/hope to move
quickly from this flag to simply making switchdev the driver default for
all DPU configs.

A generic cmdline format also gets complicated quickly: vendor-specific
flags, ordering/dependencies between flags, hotplug timing, and whether a
BDF rule should apply when a device is passed into a VM after boot.
Userspace scripts are probably better for that kind of policy because
they can carry real site specific logic.

I’ll drop this last patch from the series for now so the representor/LAG
locking fixes can move independently and we can continue the default
switchdev discussion separately. I can always submit that as a standalone
patch later in the cycle if needed.

> 
> BTW looks like issues Sashiko/Claude finds are slightly different,
> let me send them out.

Right, we saw that as well. That is expected, since the
comments depend on the model being used, and can even differ between
runs of the same model.

I saw on patchwork that Sashiko/NIPA run had timed out, so I did not
have those comments when I replied. I’ll go over the additional
comments you've sent, thanks!

Mark


