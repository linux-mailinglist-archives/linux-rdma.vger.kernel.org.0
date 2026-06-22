Return-Path: <linux-rdma+bounces-22402-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id ZwWNEinbOGqDjAcAu9opvQ
	(envelope-from <linux-rdma+bounces-22402-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 22 Jun 2026 08:50:17 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 102E56AD04D
	for <lists+linux-rdma@lfdr.de>; Mon, 22 Jun 2026 08:50:15 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=Nvidia.com header.s=selector2 header.b=KDEfEDv8;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-22402-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-rdma+bounces-22402-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=nvidia.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 62AF930330B5
	for <lists+linux-rdma@lfdr.de>; Mon, 22 Jun 2026 06:49:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3E4D3603C0;
	Mon, 22 Jun 2026 06:49:28 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010027.outbound.protection.outlook.com [52.101.61.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88AEB19E97B;
	Mon, 22 Jun 2026 06:49:27 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782110968; cv=fail; b=XRbsGT9zRWVEi7nzIG+uEUTLPcSNYc/XivlGbeKJmd5qdQE4PTVQZao4JQG5JUmwtY8LQdMzn2yEORLESrxZML/g9XwMg9QnstPf++3YC2OsktI9V7MNXbXhA7LG8SWiEmfVZB5QCOC11lVpZKpFka3MHzku8ugog4P6za+GCAk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782110968; c=relaxed/simple;
	bh=82pnHaeRbbC3PkPgHwB6RI6MaHa/Nyu9ts/9KJ4I4Vw=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=hBPitGEpHc7UEoVokX0od4aIZqCtf4+0/OxzXoZ0npzUL7PZlv+GtBCV1Vlpm/B6Sg/0NCIww1VvUMUfo1BhwY15fQReLSguriZc0Of5lUmvEPrIpCb6Y+4m5nNZMXbriIeOxQ5Ft/Url85zaHC+i1WsHE1aM0ntJItO1HR1v6I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=KDEfEDv8; arc=fail smtp.client-ip=52.101.61.27
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GBBcrPdBJb+2s9XHUjA1jUJAqNRGQsw4KPl71ARMeK0YRnrfrn6m8jBAV9FBEGIHTJZXjb6t7zGJ4Z0H9yXRuAA4CRD6QzqWpNAjHUpvwNxhVx+HL2rcRYX4c1FBFU1J6MRvN8ruL2useqTtfSxWg3xNYQe8I1pbGM1EkSnDO+2EBZ6L6nLpYjFhQw4VdndUBPuJNzs19Ig49VH5l0P1gdUMoMKpqv5MxPAm9LunBSHQjhw7sI71i95vsIoAaBO8cgsKcAENaQtxDLd1XOQHmlqpSODWleN6mN8ilJ/nRapInyXlEphuIjnhZOBYqDov/+s0cwVEDjEOMhNTdyQDwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HaNkRMB+HZUhxhHMBHgr/WPRQWGnfMqnofEtJdZIpDM=;
 b=smT0DkHJQ7YjDJF59CQdB72euJ/l8A16vUQGoTjTdnPeo/3ADDzTUBeq6Mozv2R0d7bFseKz0XbERNJIW1I3S9bz7PnEQZT7iBTCAJtaRwAc7fY18+sfpbHRPlvs2gRbrIjVMBH5T+DrP6/w024AokICJEymbHaCa6L/I/gMdgeE4tvrOpj5Hag8aIC4+9MLcteDPbuf3IpFzXPGrB6ZX2i+8j8iFgMpVJXvxszl87TaGGG2nw13/9Kiu11trYcIA3+2/K9hqSMWVYSrjgy4cpLEnDyW9Bi+1TZIVj/R52SHhG0hjGERMzskkZtrRsArrB60eO8II0riUlqTBzsg4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HaNkRMB+HZUhxhHMBHgr/WPRQWGnfMqnofEtJdZIpDM=;
 b=KDEfEDv8dHLgXFqCQapdKrhhNXjqdLkoB8w2SU173XLzk1UtWt62OEQmgo155ScJoshiJ/AzrqEUoRDb9nxsBnl7ExZICKrLBTt9pGybh4tDrcOPD7btaftYPRIfeYP7TqZZPZ+SeRKm2XNKRTB94081OGbIBqUAlfzdLrqHa7gYZYFnOncw/rNuC6ZmJIdyiyazPS3bqXxfwZXkqgDkryJrclIVEc6vXtKFtpZT9vABW0uwKAaMQuWhqIO30d2HmrikD+P3Ncy1VgOWUQ+zfM5FST72cY3ua0mJbB4mVcfmsAcWX0I7ydMbCfK0RSc8TkQMB5ciCl+APAqzNCKVAQ==
Received: from MW6PR12MB7086.namprd12.prod.outlook.com (2603:10b6:303:238::20)
 by CH8PR12MB9815.namprd12.prod.outlook.com (2603:10b6:610:277::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.20; Mon, 22 Jun
 2026 06:49:24 +0000
Received: from MW6PR12MB7086.namprd12.prod.outlook.com
 ([fe80::4eb8:7fcb:fe8d:e95e]) by MW6PR12MB7086.namprd12.prod.outlook.com
 ([fe80::4eb8:7fcb:fe8d:e95e%3]) with mapi id 15.21.0139.011; Mon, 22 Jun 2026
 06:49:24 +0000
Message-ID: <cd725cc0-9be1-4d12-bc9f-95ecf789613b@nvidia.com>
Date: Mon, 22 Jun 2026 09:49:17 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net/mlx5: Fix L3 tunnel entropy refcount leak
To: lirongqing <lirongqing@baidu.com>, Saeed Mahameed <saeedm@nvidia.com>,
 Leon Romanovsky <leon@kernel.org>, Tariq Toukan <tariqt@nvidia.com>,
 Mark Bloch <mbloch@nvidia.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
 linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260613153631.1752-1-lirongqing@baidu.com>
Content-Language: en-US
From: Tariq Toukan <tariqt@nvidia.com>
In-Reply-To: <20260613153631.1752-1-lirongqing@baidu.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0255.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f5::18) To MW6PR12MB7086.namprd12.prod.outlook.com
 (2603:10b6:303:238::20)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW6PR12MB7086:EE_|CH8PR12MB9815:EE_
X-MS-Office365-Filtering-Correlation-Id: 2936bc92-9f62-46e7-88bd-08ded02a652f
X-LD-Processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|23010399003|7416014|376014|1800799024|56012099006|921020|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	e+e3wBq+PpdShCdlczLTOt+KOONxOK4UmKONhrJTxtEs5315dbf0vQ3natNA3+IpAlyitj68NQSji3s1Hs2LuimVR6Zywf56j60UkBLalLMt9uEd24Nm3OwUikSHA9AMs3EVuFA8xCY4A/KxOGhsn+tlDbzjvkyjXO833kBtXXZgeInu49DEftdNpfrgHJLQK4R6FdWa4alRYVbVDR4xvLiw/3trT/mElDtbTowjF7zgnfFmNkpPpeoma2v418CGISUfw4sb92yLrEbotu/PElr3wiafx6qw3UdxY6WJL0b4r6/cec5XoQVChvvAokELs0O3PvyBrz0UeekyQaB76o+eGttrvjAlffJ9Nw4bIxY6W/frEm+iP4jFPD57aQFfjI/WrngmWwNP2WNUWsdEpTFq1r7OCXz7BJyCF8pQJ+KfOEnYeErXK8Qm1ebafXoBpIK2etpXGl7X4lMt4B05MTGomixfRhSVrKtvoCy36Xt+qu2gJ+M5msEhE4pJNlmKjK/NR1Zlyoe7dZ86RFBwBUxcNpswZF4+kjN0Z5H5H0OuxzZvzxgLeUTstivdf9ycXnseoWWSCGM9G864PTn5bcE0uEtR8oUAWxV7ItvPsM1R+tdJCfENM/72EX4ropxIhG5SZUMZ1hdvi9pdDLd3nR5isOG+9nBUm5CKPF3atbkHnqEVTzSLJHEsA6Ii6Z6e6W7SB78QtGao5xrbrYRIqg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW6PR12MB7086.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(7416014)(376014)(1800799024)(56012099006)(921020)(11063799006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OUdjdXBNWkRIVDBxTE9JSWRrYTBuWVBRVkxmRFF1WWpqQkIwZFpyNjlma3FF?=
 =?utf-8?B?QmJ0Wk1JMGZ2OTBBUnpucG83bUFicENNMmlOTHRITnUwMFliKzU0SnZadkd3?=
 =?utf-8?B?MHJ3Z1QyK2ZMdlhONVZ5L1JiTnBBT1NBcXFzV253MDdhTEhCOG9aOGpPaE9w?=
 =?utf-8?B?OVhqOUlid0cyTGRPSEc2UzF1K3dmd3crRDYyZWMwTzRvZjE3dHJaTDZkVXcz?=
 =?utf-8?B?TGFRMTZLZTNocjh3dCtPeDNLRVdiaWlGb1FCKzFjRUxHeVNMcnQ1Sy9oZ29U?=
 =?utf-8?B?T3ZIMzN6OFM4MzFQYlhsb3BINzB3RFkyajExNzdyM29NYjU1WmlwckVPeWZ4?=
 =?utf-8?B?VWhmWE9FejErZVFxbTF2amRuYnNMTnhKODBQRURCaVMveC91WW9CSHhteVp2?=
 =?utf-8?B?TG5YOTN2d29PckNJTUw3WEdRa2F5NitZeHBvMUFMaUpPbnBUcUVvZUVqRHRQ?=
 =?utf-8?B?SGIydXpNREl0U1FLcEhzSWpBR0dGaEUrMjBhZlRzMGswZm8rdGR3K3lyNDVm?=
 =?utf-8?B?SkkyeXFucDNNMXkxei91OVkwMnF3azZoc2d1MTFpZUFNZ2JTZVdmdXFvbVJB?=
 =?utf-8?B?RmZZSWF6bFRMd3cxMWdINEhrUnhjNmdJVzhycTdtSHhqOUlSYjIxTW85aDdB?=
 =?utf-8?B?VGlLTzVDZ3I1azVhTjJlQXdMZWh2RWpVbCtmUjRMcEFyWCszM2JBZ2JxTW50?=
 =?utf-8?B?M0lVSW84TENwUW1BemVMd1ZGK2JlZWlOeWZXZ3ZRZnV6MUtYcUJaZURKQ3l2?=
 =?utf-8?B?aWRLdVVYUC9HOEt4OHJLSnRkdXVZUnNlaU8ydDE3VXpxU0libnZPV0NSRGdP?=
 =?utf-8?B?aXhBVWU4bjhoNXhYUTYxUnEzNjdjOW9PWjRMcDBjRTVVL1FpeUxqTkNHeVcw?=
 =?utf-8?B?NEdYNTVEd1ZGTkpPa3NJVU4yalp1RHlNbHpHYlpkS2ZiSzFiVGJpM0VJbFNz?=
 =?utf-8?B?aVlRUnZFcGV5b0RFMFlDS3VQRGZFZWl2LzFqUGl2dGRwWlpjNGJxZEI3YmEv?=
 =?utf-8?B?UkpHS2ExbE5iU3FsNlZLcDZOY3JZSStnS2JpZjV2cVAvQytkU3lXaEQ2Rk1p?=
 =?utf-8?B?RkdyeUMwdHJkY0t4ZXpmU0x6NEdWanUvTlN4K2Q3QlZaUjN6NFdhdmR5WmRm?=
 =?utf-8?B?SXpjZUhoUFZyYzRETHJ3U2grdWVtOUtpUGRPUUkrdnphMFF6aVEzQ1JXK2lX?=
 =?utf-8?B?eC9TdFFhVk5lT3JxVVJKdnBwdk4wYUlqaWx4OTFYUExETGpEak1nQmdiWXdm?=
 =?utf-8?B?akxlczNjWGtuYUxVK2t2NXFsdzR5d2NYSzB3TW42OVlWTU5TMWhwYytzaWdU?=
 =?utf-8?B?SEdNVHFFSWpIQjBCdVU3WGxDS3laTTMrb25VeGFOQUp4dGhvajJNYUQxM3lv?=
 =?utf-8?B?OXhhZE1uQ2xiY0FQaEhmWGxmMk5lS25MS1QxaTA3M1dGRUwwQ3lCVkhSQ2JO?=
 =?utf-8?B?UU83eFI0WjlkWlUrYVBqdWw1OUJxY1pQdDIwcmsxQnMydWxpalN3WGYzUUx3?=
 =?utf-8?B?SzBNY2p6TkIvUG1uL0syc2lIYllraEpBcVZGVHc5MysrZ2htZnFKRFlpRWx2?=
 =?utf-8?B?eWR6R1FpVGpjNDRSS0hOUHAwVC9FQ0h3eFJuaU0rZlhaZFozRkhJdVRpMUhk?=
 =?utf-8?B?N2pSWTl4TUIyWk94bHJOalZURFJKZlpBL1MydDlVZklYazUvVDdWb1lyT1ha?=
 =?utf-8?B?RHk5OGprMVlUb0ttMytlU09wRXkwQmhaUURFQVNVbUd0bk10SmcyRzl4OWwy?=
 =?utf-8?B?VlBQQ2JaTkFVWEZoS3dNWGh3RjE5MEhFZEhDbStHbmQ3d2luQ1FhVEVOUE95?=
 =?utf-8?B?c09kcmJWOEQrN2RHNGNVWTVmWkZYK0dicFdicTl0T1A2RkoreFpMN0VDK1Ri?=
 =?utf-8?B?YUFiZWhaNFJHS1BIb1ErY2tneGNWcDd3YWMwUlBwcW5LUDZNcUhtVmVnbldY?=
 =?utf-8?B?ck5BblozY2hubUdMdXNhZmVKMlBDR2dhTCtRYktiNVBCb21aZzRUb0R6L2l0?=
 =?utf-8?B?ajFFSzQxUUROZkdZZi9FUE5QaVFqWGdJTXZxckRqTTFtNUlqYU5ldjJUZEcv?=
 =?utf-8?B?WlcwbGRGVVAzOHp0MWdiWFQ1c0pCcHprZjVSaXhCajBST1R5KzREdUFuL0cw?=
 =?utf-8?B?bGl3Z2xuY0pXMm1BdjVETllLd2xhcHBRMFNuam9xWk5kbWJ6Y01Kc1JxSGJC?=
 =?utf-8?B?alBVc3ZSdjZZWnc5VGpCUUlDNHU0a3dkT0xEb053eUNkcDVwTXpnNUNpNGtK?=
 =?utf-8?B?SUN5VDR4KzRhblg1U1RwYWk2bVVUVFM4U2xBNCtWMmxFRm4vb1doaVVyR2Vp?=
 =?utf-8?B?Q3ZqQ0s5RWs4WitTRTJ3MjZ2MkY5c1E2ajVBT1JrbWt0TWVkWWpKUT09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2936bc92-9f62-46e7-88bd-08ded02a652f
X-MS-Exchange-CrossTenant-AuthSource: MW6PR12MB7086.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2026 06:49:24.0640
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eaVPrnBnBFfIoH+4RF+wyomM5Y0PWiG3E1DOClijE+e18BfOzsOgrZhZfOXgFQNYOyYW3JDWX1XtUPH5zmtkgg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH8PR12MB9815
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.66 / 15.00];
	WHITELIST_DMARC(-7.00)[nvidia.com:D:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-22402-lists,linux-rdma=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[tariqt@nvidia.com,linux-rdma@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:lirongqing@baidu.com,m:saeedm@nvidia.com,m:leon@kernel.org,m:tariqt@nvidia.com,m:mbloch@nvidia.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:netdev@vger.kernel.org,m:linux-rdma@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,nvidia.com:email,nvidia.com:mid,nvidia.com:from_mime,vger.kernel.org:from_smtp,Nvidia.com:dkim]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 102E56AD04D



On 13/06/2026 18:36, lirongqing wrote:
> From: Li RongQing <lirongqing@baidu.com>
> 
> mlx5_tun_entropy_refcount_inc() counts both VXLAN and L2-to-L3
> tunnel reformat entries as entropy-enabling users. The matching
> decrement path only handled VXLAN, leaving L2-to-L3 tunnel entries
> counted after release.
> 
> Handle MLX5_REFORMAT_TYPE_L2_TO_L3_TUNNEL in
> mlx5_tun_entropy_refcount_dec() as well so the enabling entry
> refcount remains balanced.
> 
> Fixes: f828ca6a2fb6 ("net/mlx5e: Add support for hw encapsulation of MPLS over UDP")
> Signed-off-by: Li RongQing <lirongqing@baidu.com>
> ---
>   drivers/net/ethernet/mellanox/mlx5/core/lib/port_tun.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/lib/port_tun.c b/drivers/net/ethernet/mellanox/mlx5/core/lib/port_tun.c
> index 4571c56..97f6097 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/lib/port_tun.c
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/lib/port_tun.c
> @@ -176,7 +176,8 @@ void mlx5_tun_entropy_refcount_dec(struct mlx5_tun_entropy *tun_entropy,
>   				   int reformat_type)
>   {
>   	mutex_lock(&tun_entropy->lock);
> -	if (reformat_type == MLX5_REFORMAT_TYPE_L2_TO_VXLAN)
> +	if (reformat_type == MLX5_REFORMAT_TYPE_L2_TO_VXLAN ||
> +	    reformat_type == MLX5_REFORMAT_TYPE_L2_TO_L3_TUNNEL)
>   		tun_entropy->num_enabling_entries--;
>   	else if (reformat_type == MLX5_REFORMAT_TYPE_L2_TO_NVGRE &&
>   		 --tun_entropy->num_disabling_entries == 0)

Reviewed-by: Tariq Toukan <tariqt@nvidia.com>


