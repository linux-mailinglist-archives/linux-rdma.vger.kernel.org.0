Return-Path: <linux-rdma+bounces-18190-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6JAmFb88uGmpagEAu9opvQ
	(envelope-from <linux-rdma+bounces-18190-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 16 Mar 2026 18:24:15 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E906429E1A2
	for <lists+linux-rdma@lfdr.de>; Mon, 16 Mar 2026 18:24:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 65392306E851
	for <lists+linux-rdma@lfdr.de>; Mon, 16 Mar 2026 17:18:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35F763B5821;
	Mon, 16 Mar 2026 17:18:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="m3jAOBjn"
X-Original-To: linux-rdma@vger.kernel.org
Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010016.outbound.protection.outlook.com [52.101.46.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD8C21632C8;
	Mon, 16 Mar 2026 17:18:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773681492; cv=fail; b=VA7/v9p6t01g+Zk2qNPutFDzbI7llYGl5yEpRwUXRVa4gw+66rVpvvwqonMiHt7fiYWUYBFwXmDeNRDV/vm7tIinVoK4zVsnZWoWaT4SJ+2hn1UtziSVlL1s4LnXExOgm4BtdecJeDKr0O0U6cKqEVMcQ86BLHWZ31bd1IvYdHg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773681492; c=relaxed/simple;
	bh=4oEMjBMjP6/+9w1GuYOQjGVU84gwPKyHcMTfa8VBKi4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=TI4LavAh0KBC6PIVCWBWISZ3K7ZpqJtTPKACbHJHDRZ8pZGkZMQ2FwtGWDNPKKnrBBSBnt95Y99TVqNjUWB0WpMU+asExH2xo6v+xapZXYlVyDnhKwnTkmdMkLOzi1VYDCsR6PCSKtzy6Blvy4s9Qk2XDnsEjDVFkr1xKsQSFkk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=m3jAOBjn; arc=fail smtp.client-ip=52.101.46.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pw5kTHJrKZ5SHWg2u6W2tr7lvzMupepWDAUaPaCDa3o63qhBPr4hvLTrE1Z5U9itPyJyVR5ZGhQdNVoE/OoSOB9A2GAW6A1JHVcNly3jNHlIdjBSbcLZEHs6s/j66swwOFGDuvXkRwinuPnx5i3ZUflQYuNDsVAs3noQ70EFb5LXEZqL9gVKpeBhTNzgw0vvI9xo+T2SFQ7Wpa3Wp5Af9Joa037TRk/4Kke37dXPHnKvvHRvOhSWfvl0uquxWmL46FwOdqRBt8fwXQfwpStfRvncdvoUeor9EMBM4QwpxqPba2dcObFKffBi9SkfxbBCm0vsizo9UL6m4rwGO9Dcow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1OP3KFsuk9Z1vXYzbdBEXSZ3Jhn7GrhTel479fechTs=;
 b=ewnX0kjIi5e+xLGhvNc9O11mH8ugt7bL6IWbKG46e18FoKrlR0LAzyQ3/lrVRFjA8tTTjzSiuMAtbdUcw7+TzBscgv5K/UNR70gacOdnw1Of2YLDsuvzS+RFmVKwfFnQqDXtlWEtwlBhj3fZdJJhT5zpJux5X/1tz7fsxhbpkUmsNa8IqbG/A4TjLqhdwEq3hCnDw+/aCbx3LsRocRjKFP5PfMgKDw0nuvh4hgn9kuZwz5aVonM6lolJwwEyBVms/w3BE/MUxKNxnKVQYLT/0dO/n4qYovvDtRnglUONeqODFkSU9yaYns+fX3tdas19ExpyZOnNvqBTbtoHG5XLlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1OP3KFsuk9Z1vXYzbdBEXSZ3Jhn7GrhTel479fechTs=;
 b=m3jAOBjnsOQ1o9050v7ByrSUJc8FVB8c50ou7i2egYMmC0aYOUHqPttpmnDu6evNxTWlCRr/uqGTqYQxSh4f85Ifa2DM38bNfdf8K8jKxo/kmvw/6OAtPReGWaMi2rZ/oIdarscp8lTSRdwKIN/nRC9POsC67ZCkWkS8oHJwM3uop4STBgv8I3tf4gRRb3EyPmCS0S9OLDhKpY3GoSnP9qesENgeNtEcTx3SXwIhXBBN0HLmdnvwpjlOPrhljr3Ysw6YQXz2mkN79k5z6Uxl7axtJCQG1BH6N9A2I9A58oTTNOfna+mAGKQm5FjJ6Qgd1u41EEjmDY34zHGl5xRhNA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9715.namprd12.prod.outlook.com (2603:10b6:408:2a0::7)
 by SN7PR12MB8172.namprd12.prod.outlook.com (2603:10b6:806:352::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.16; Mon, 16 Mar
 2026 17:18:03 +0000
Received: from LV8PR12MB9715.namprd12.prod.outlook.com
 ([fe80::e74f:2cf8:cf2c:142]) by LV8PR12MB9715.namprd12.prod.outlook.com
 ([fe80::e74f:2cf8:cf2c:142%5]) with mapi id 15.20.9723.014; Mon, 16 Mar 2026
 17:18:02 +0000
Message-ID: <459677a5-db84-4c62-9c44-41e59f1871ef@nvidia.com>
Date: Mon, 16 Mar 2026 19:17:59 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH iproute2-next 2/4] rdma: Add resource FRMR pools show
 command
To: David Ahern <dsahern@gmail.com>, Chiara Meiohas <cmeiohas@nvidia.com>,
 leon@kernel.org, stephen@networkplumber.org
Cc: jgg@nvidia.com, linux-rdma@vger.kernel.org, netdev@vger.kernel.org,
 Patrisious Haddad <phaddad@nvidia.com>
References: <20260302155200.2611098-1-cmeiohas@nvidia.com>
 <20260302155200.2611098-3-cmeiohas@nvidia.com>
 <d8e79d96-3dfd-4008-85a3-f2cb1da2845c@gmail.com>
Content-Language: en-US
From: Michael Gur <michaelgur@nvidia.com>
In-Reply-To: <d8e79d96-3dfd-4008-85a3-f2cb1da2845c@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TL2P290CA0002.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:2::12) To LV8PR12MB9715.namprd12.prod.outlook.com
 (2603:10b6:408:2a0::7)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9715:EE_|SN7PR12MB8172:EE_
X-MS-Office365-Filtering-Correlation-Id: 5d2bed39-ac0a-4aae-ad74-08de837ffad3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	KUSbka5KOu8NaY/jcq/xHkv/nWPNcZIma+jM9XQhuhhTAmc+0OIn2YR1O494sAvA2XEVue8vh2CiILfOKjLbBfURpAsmt392gtm8+KAWJhDTgmUk/wsQOvnaqwhdpaXhjt0zTTV5NWQyd22R8V7frMwen8JB+X3C4zqdt9Iucv5n5519qb0Zz5ascZC+uUY4NH4q0rLQvrgu3Mn/pjiCvFBtYL7GNJjWYzXc/Kq4rsOMhnv9OjxarqkmF788IK4TQf5+qG7x6l7B2PRfx4aA3BKsds6OLjCZKzIMUKU6BUqIQd7IdtOb8acA5AorqUFUvCQhtI+bPcba86ICY+tdY4vpLFrWFiweBP2REP4ZP2i0NL5pPoIoW6An25UH1xpc0WOp14oC6YSWmvsCrlHm9zk0hosPUKQXsMVTEV7cgEMPcoiphJKJzVL7x8VmvC5yFgtXAWmXwKqEHHpfBUTSA768rwqABVpqsbOycVyPFuUS0op1tP6PUBFku9AFD90unYrhqpzbMZ0w3olfy5acUyB0/U0y69nmDz7Kci37ea+WD+wJcz8+WkaM1yeSt9LUftriSqoLB3f/5Gct6s1FCYzwc+PMUIyuinBFIyQAzjMs+mmxCQlAaq9iiMuAEuA5ErXfTfjXc4f++CsW+yrhNTmdT3KtOgdA0y6F9J+v7PN0Z2P/ONi7Nr/wjhHCy7lB4w/E0KTYOx2BvGvZmeX+guDLKCal4IT7juLgbcwmqGo=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9715.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RU1YUDdabnVoVVJiVEFVVVpIeW1jZ2x1dVo0eGZvQS9PaXA2dEtQbnVSK2dH?=
 =?utf-8?B?bHhDRWU0d3gwM0ZOY1dtWTU2eERjazdERXpJRTY0YlNiUHF0NXRHY2VLNFUr?=
 =?utf-8?B?N1BKRHF5N0owSVE2TlB4Nkt3ZWZEMTlSdjdadHdrZ3RxZ3NRTzVrbWxmNGh0?=
 =?utf-8?B?ZHV5dk1JM3pVZDAwcHVXWlhrMmpjUTRXbFhPdXFKc0lDWGlMbE5mNStCWFdG?=
 =?utf-8?B?czVoM3UzcTBrVFZwYWkvdHN6RjVKWHhieW0rREl3YWthNURtdzNDRWVqaVJq?=
 =?utf-8?B?Y1VKdEJBZ056K0k4SmRwdXJIUGpQdk85NEcvT2xma0EwL1k3MXJpbnpsNVR0?=
 =?utf-8?B?MUFKNVFNYkI1ZkE1djRSRHU3Z0dudko0aXNOeDVwejBNaWZwRW5CdGZ1NG1D?=
 =?utf-8?B?UEtobC9pWXA3bmE5Snk4bG1WRXdRTmg4RUdheGlteFEwalNUMG80TXB6TjA1?=
 =?utf-8?B?eWpoZHN2ZFpieHdtaTFqcUxzSUhjTDlSVU1tWVpTVkJaZGdNdVBndmNsS3la?=
 =?utf-8?B?bTBYOW1OdzJ2Y3N6TkdQMVk5ZTlRYU95cFJRZSt4ZVB1cUl0RFA4VERid1Bl?=
 =?utf-8?B?OHpwZExxc3lwazhpMldXYXZDNVl1THJmT0ZaTFhISmloYWJnN3Vub3JEUkR0?=
 =?utf-8?B?UGg0Sjd1RUZZT0s5WGhlSnpwWURXU3JwaENCUHVWTk9MNWFlSnFhcDFsM1V3?=
 =?utf-8?B?T1QrTEczV3JTNUo2a2ZNSlhNNGNUdGIzblNBSlBJL050MUlwR3gydEorSTRa?=
 =?utf-8?B?aytNTzFYR2NMZGJ2U051UGFyYXViU2VOTG1jMG4xOHBWRjZuYU5pRGhuWjJi?=
 =?utf-8?B?TFVtT2ZVZDlyb3d1UjlKcGFYUFZtdW9LeW9IcFRyODh1cnByM1IrUzFQY2ZU?=
 =?utf-8?B?MUdib2RidG1YSFhDYTE5RTlWQ0dva1YxQmo3WUlaM0Zhd1Q3ZkFPb0cvbk1J?=
 =?utf-8?B?Sml3VVkweEZ4UXVITERnNU8zVWN3YWhESUxuWTB5TUhwWGtDSXlLWEVOdnNa?=
 =?utf-8?B?V0JkbDcvTnNmSElpVHRnODFURk9tTlQ0d21zbGNjYnlIOURYOFNVeDErSmxP?=
 =?utf-8?B?VEVESUNyeTFkN2FyaG5JR0IwUFJ3aWJNVm5lVlFBTEh6WUdPTE4weE9uc3Zu?=
 =?utf-8?B?SXpHWWVGUnJOdEJlS2JtaFZjamJJcVUxaEdIU1U3dlczcmFFcnFKd1dxeER6?=
 =?utf-8?B?eWhNdUhzMWtjYm95eG9sZ29PWW81VVlSR1h2UkJ6RE1MMmI0YU5ueExTN1Yr?=
 =?utf-8?B?M3hBTVJzNHdqRzhOdWJmNUw5TWxWUStxTkd1VzR0cWVldmkzb1dqeXRrV1Fw?=
 =?utf-8?B?VEZPTEpXRUFXVEZ4aHQ5eitNMExjdHVXNTVjMVFtQ0Mya3ZRN28yNEI2cmk4?=
 =?utf-8?B?WHQ2Szcxa3JRS0NPQ01PU0JqT0tneUhGSk9yTm9Jdy9ZeEVRQTk3OG1RQncz?=
 =?utf-8?B?Z1gxMHhLNkZlRS9sN1NsZERLam96Qk40OHpDVDlCUWdFSEdMV2hpREhIcFlP?=
 =?utf-8?B?ZG9xVGFTRGI1dzZGUkt1RnFtRzBlbGtWcWltNWdNTFVyTW9FYm12RHQxdVJF?=
 =?utf-8?B?c04vWWJiYTNhQnRUWCtLTGRVSTZablB6bFlOQ2h0SGY1Qzc3TGdPbVc4T21U?=
 =?utf-8?B?T3NrdGp5RWsxeGc5YnJGYVJWUkJPRjdVNlp6MDFIWmNqKzRtSGZTcU5EZmVX?=
 =?utf-8?B?WDdMbUljT1lNd0FuOXkxZUYxZnVualJ0ZUt3c3hwTFZxVkh2KzVPMnYvSXN4?=
 =?utf-8?B?Q3lxdWdPUElyRkRRWitaemhmREk3UXZmVnFoTVpKbys3di9uWklFeG5jalJS?=
 =?utf-8?B?b21xV0M2dGF0REtOVmg3OU8ySXZWUGpaY1RJUG93bWFUTXpiOGxzSG9wOGpF?=
 =?utf-8?B?Z0JYdTN4VlhPdDV5elplZVlvNG1uWjdaUXlUSEQ0VGltRGZlS3ZhaWl1R0Vl?=
 =?utf-8?B?M0N6Y3FycnMxQUl4TUhwOUx3REM3R2VnV3FNUnRTZis5R3lmLzV2SFFrYzdX?=
 =?utf-8?B?L3hkQ2k0VDliRzNwNHBpNFd1TnFudUpVemF6RG9QV21hWVpnbHB3am1YMEN5?=
 =?utf-8?B?c1oreVl6a3ovTXJ2dEdUcXFJSGlkVkxxZm5xTFdGMnZvc1RUUks3K0dpR2cz?=
 =?utf-8?B?SjExYTd6R2kvczJsVTduRXFNNHpvSVBZdjQvdEhGcmxSZDg1VVpCQ050dHAr?=
 =?utf-8?B?dHR2V3dERHBtb09Dd0hOZHJkeXRMTWdiWWZaV0pVS0psOGsvam9hL3ZnRWF1?=
 =?utf-8?B?Q1N6dWEzM3ZlOExxNnVydlBXOG1nRWc3Q2JiOTNFTUlnNnF4M1F3aDYxWXZB?=
 =?utf-8?B?akMzenp2N2ZwNURWVm15N0t2dWFGVElUVU16akhNR25tNHpWZW9DQT09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d2bed39-ac0a-4aae-ad74-08de837ffad3
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9715.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Mar 2026 17:18:02.8052
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: w+SL89xG8tDeH21o6dUtXVTLwnI0DP7ppp10hZ9vf5KcuNt+GLc402Vww45ufBfrTVgUlqRQWSXK7xBB9yhngg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8172
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-18190-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,nvidia.com,kernel.org,networkplumber.org];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[michaelgur@nvidia.com,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:email,nvidia.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,Nvidia.com:dkim]
X-Rspamd-Queue-Id: E906429E1A2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


On 3/7/2026 3:45 AM, David Ahern wrote:
> External email: Use caution opening links or attachments
>
>
> On 3/2/26 8:51 AM, Chiara Meiohas wrote:
>> diff --git a/rdma/res-frmr-pools.c b/rdma/res-frmr-pools.c
>> new file mode 100644
>> index 00000000..97d59705
>> --- /dev/null
>> +++ b/rdma/res-frmr-pools.c
>> @@ -0,0 +1,190 @@
>> +// SPDX-License-Identifier: GPL-2.0 OR Linux-OpenIB
>> +/*
>> + * res-frmr-pools.c  RDMA tool
>> + * Authors:    Michael Guralnik <michaelgur@nvidia.com>
>> + */
>> +
>> +#include "res.h"
>> +#include <inttypes.h>
>> +
>> +#define FRMR_POOL_KEY_SIZE 21
>> +#define FRMR_POOL_KEY_HEX_SIZE (FRMR_POOL_KEY_SIZE * 2)
>> +union frmr_pool_key {
>> +     struct {
>> +             uint8_t ats;
>> +             uint32_t access_flags;
>> +             uint64_t vendor_key;
>> +             uint64_t num_dma_blocks;
>> +     } __attribute__((packed)) fields;
> why is packed needed on this struct? why can't the fields be re-arranged
> to not require it and just let the extra 3B be at the end unused?

The reasoning was to keep fields that are more likely to be zeroes at 
MSB to allow shortening the pool hex key in input and output.

Giving this another thought, I now think we're better dropping the logic 
of variable length in the pool key encoding/decoding and keep the hex 
pool key at fixed length.
I'll rearrange fields to drop the packed attribute and have the last 3B 
reserved.

>> +     uint8_t raw[FRMR_POOL_KEY_SIZE];
>> +};
>> +

