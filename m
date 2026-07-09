Return-Path: <linux-rdma+bounces-22971-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 9NcnGM/jT2o3pwIAu9opvQ
	(envelope-from <linux-rdma+bounces-22971-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 09 Jul 2026 20:09:19 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id CFCDB73421B
	for <lists+linux-rdma@lfdr.de>; Thu, 09 Jul 2026 20:09:18 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=Nvidia.com header.s=selector2 header.b=E1G0sRln;
	dmarc=pass (policy=reject) header.from=nvidia.com;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-22971-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-rdma+bounces-22971-lists+linux-rdma=lfdr.de@vger.kernel.org";
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6A7B630A0FA8
	for <lists+linux-rdma@lfdr.de>; Thu,  9 Jul 2026 18:07:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C7D73806DD;
	Thu,  9 Jul 2026 18:07:09 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010031.outbound.protection.outlook.com [40.93.198.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4300D3E3C76;
	Thu,  9 Jul 2026 18:07:06 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783620428; cv=fail; b=rAxEvZY1AGzlikiwh6OojrjsFMgmc/PAYSefgF+f8+YTq1TOkLMcXKA9CUHtICRVR49ZuCTz2AX3tg5DYFcfmCnjRmpEaAEeJh9aBTPsamNP6onb1fBBRby47m210uo72TNlzfNPjzF87jQYQsoO2MNDUcgJLIQi+jKZ1h5ofjg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783620428; c=relaxed/simple;
	bh=gOCfAvPQZxiiCDaoxg7H5ssNaD5nJhuCUrD7Pean2m8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=MiZ/zV+jyWUdAs89Zc+2BwpTOCzmTpEQ6bKiHDiz7DYX0XziVBLasDLKmdXlNY3HIzUjAO+e2Unz38E6dJq7Z5GKH/3kzUtaIwYekjUK6cFiL1e7As2+UzsE6MaaQ/jrQJ6mQt5gV6zb/uQ2zC7iMVyOMdH1//ET1/jpvjmRgf0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=E1G0sRln; arc=fail smtp.client-ip=40.93.198.31
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dIAvaU5IzqrWfJX8TLULLaiY0JSQWBjY9RdUMXu46w9jsNQ60AdAp8xYh+yvpiuC3qzCUebO3xPF602anK93p/VhwdGN9wUUwKVBWw0RjNYhiltr4BluXiNQgyh9i5FGJn7eZb75T6FeznETUKNA6/yOnmTaS6nUZx+Kn4sqvQUzh7mpgqjRlPqcEU8bCJfZVNE3et7edChwNXVGsuiTx/9pPuDlxs1kIrmJ3Zo/meL3jyjb9GEOyjN8OTnOEjZb3gxl6lPDEWSLH71vC9rV5nYxbA81Mb9tKx78C4O3hGcLF+f+wp7OXGVKXqJPgNftLW17pi8uvpdinN0CMFfWYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sX6LA7F9QY5SYsaIJdsXgXNDW3DijMuF/od2XRnoj/g=;
 b=ocmkHPSbpuoahnBYhhobFqXa3bob9cxixNYRgQ2c5HzhEZm0nGOOnYWKalaZwjkG2X6iJF8ZtVhNEC4e/ncpflZe/cvX5YPdu+svHVrU8kToNsJU6alOMx5Jw3UApAxlTeZi7gaUDpvQBlnNsXOQFaJyOeZXm6GOVXY6EG0AkS55r6SqjMPeDhmsTRYxrcwxn0N+4hJvdExOMobrqeD7LlZAtDFZ/D14baV58lvQ+oqhusM+0kKiCNzFwJVbN7Pqj7jFGqz/pP1aKNMY+bKe5iNcQIGhjtFfF/SZbYHExqy/4sfqxLo+jV8aPPMDHna7qMlRf2PnFWr3CVQ7CAVDcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sX6LA7F9QY5SYsaIJdsXgXNDW3DijMuF/od2XRnoj/g=;
 b=E1G0sRlni7howpP0GcY4TUmnr0JXvxB/tR4u7NA9hQteoXGmU3S/x5/x5WLudKAjatiQYpm//yNQ/2mUQCa5o1bZZoDIWyL02V/+TWamoenewuPN3Y8oOqfvhPN+bD7zHH9oczYO07S0OV0xhMT+eoJrbI+HzVnInYm9Ak+CqToB/WKjiv1OkXmvboQNzf5wk3D2RVEzjen3qdvL2MoSXbcw8jNTM6anErgv0cJSWD155kkgQCgmS3KWJk4fk1FFOM0sMdRb92CfJBOhxfD8bmcZZ9ZMOPyoRiiATI4cgN6Xwdo0lGp4dTkEgDkH7yeo+jUeAEz/4HMUQEbVR6m1tg==
Received: from CH3PR12MB7548.namprd12.prod.outlook.com (2603:10b6:610:144::12)
 by BL3PR12MB6617.namprd12.prod.outlook.com (2603:10b6:208:38c::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.9; Thu, 9 Jul 2026
 18:06:53 +0000
Received: from CH3PR12MB7548.namprd12.prod.outlook.com
 ([fe80::b710:d6a1:ab16:76de]) by CH3PR12MB7548.namprd12.prod.outlook.com
 ([fe80::b710:d6a1:ab16:76de%6]) with mapi id 15.21.0181.014; Thu, 9 Jul 2026
 18:06:53 +0000
Message-ID: <8964bab5-563c-4976-87a6-488f6e814eb3@nvidia.com>
Date: Thu, 9 Jul 2026 21:06:49 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next V5 4/6] devlink: Apply eswitch mode boot defaults
To: Jiri Pirko <jiri@resnulli.us>
Cc: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
 Tariq Toukan <tariqt@nvidia.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>,
 netdev@vger.kernel.org, linux-rdma@vger.kernel.org, linux-doc@vger.kernel.org
References: <20260707174527.425134-1-mbloch@nvidia.com>
 <20260707174527.425134-5-mbloch@nvidia.com> <ak4Muihtk40r3lfV@FV6GYCPJ69>
 <e9445ff1-87b5-4111-8264-74016634d3bb@nvidia.com>
 <ak9thhKgtDBepkcD@FV6GYCPJ69>
Content-Language: en-US
From: Mark Bloch <mbloch@nvidia.com>
In-Reply-To: <ak9thhKgtDBepkcD@FV6GYCPJ69>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0157.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ba::12) To CH3PR12MB7548.namprd12.prod.outlook.com
 (2603:10b6:610:144::12)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB7548:EE_|BL3PR12MB6617:EE_
X-MS-Office365-Filtering-Correlation-Id: a9f43fce-20df-41d9-aa5a-08dedde4db1e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|23010399003|7416014|18002099003|22082099003|18092099006|11063799006|4143699003|5023799004|56012099006;
X-Microsoft-Antispam-Message-Info:
	SiRidvgMQyzJBbLZOyMOF6B3PbU622tv0dUmHvizFS26MP7znMEyEQeWxv5VSHzAohcMqyQ5hu9nnGH3eVQeRgt6bUUMvTQRQLDwtyTg2c4bnj9rGuNtHyVnHZdy4dLFYJQ7UlACsaUTGWlkZ5x/GuZGBlW0MhLOCU3esWiZMdIIc3x0I3j+XvS9JsSH9kWmS66yoWnasjHsMPkZPmIR7PpEbyvMJUn/xRNXcRXUv2H6+gQ3i7Z1UdoHTx9hkuoTg49e3oYZbi9KU3v9nbBNN6DOjjLXxDquVtScnXzkWrA+nhC8JtB+P5i9yYHsbtOMU9Yz1IuxANawLD4H+JOP0NhcvhXGyQtlztgLOIPe0Da1oGXzH0c0gVpNrbvggTX1WerTTjGnTk7J+FtH73IrrH73ZLleJV7EohPoU5PbOQN82wn1PlLzWo9EgP3Vxtaih0H1OySoUmhEFbbqvAtML3R0VIKvMuRKWExnocah1j8Tst4qHgg1wVTK/cJoV5Y5bDfaV49UpwutqCAS1TEA2NpF6OMCboFuR9qeH/26mrP3JzW9nwVAE8138+EogxJFeSjOIv9ji+fW/oSD5d+Gu1zntmaGtyDxL9gtUQutIoeuxMwNLvvZ7Rq9QgCrv6hLFfkc+6MIpQ+MnM05qb0bCsYPujP8iSlAldffSRVvaQ8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB7548.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(7416014)(18002099003)(22082099003)(18092099006)(11063799006)(4143699003)(5023799004)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SVlhb2dUTThEVG83Vy9rcmV5NC9ON0VCMDQraVgxRWZ0dXg4a2V0RkxNU1lS?=
 =?utf-8?B?M1FtWWdVVlQyNmxrN0xCc2FLY05hY1pIdjYxZ285c1djY0s0S0NZMDdHWWFN?=
 =?utf-8?B?dTNsQUt3TThGemdVRmxPVHg5NzgxYy9oVzcwNmNhUXB4NGhBN0pONzJNaXg1?=
 =?utf-8?B?M0tUUi9PWmdkVzFKS2RzUXJvcjBKSHNsQWUraEt2SlREZTF4bnRNTXlIdmV3?=
 =?utf-8?B?RTh1T29tb0s2MmdtZXVqdXpJanJnaDEySGJPOG9ka0drR2F5OGtFM0RGV2pa?=
 =?utf-8?B?cXVTTUd0RGxwMnpnTFZNelRCdjlQQjQzSHJWWmxGWEp3V2I5RTVFMmxuMFA5?=
 =?utf-8?B?MjJibDhETVBWVE9BR3RMNFFMcXBKWVdRK0U0cE9xT1hkcG5DaDcwdzhUVXh1?=
 =?utf-8?B?R1JhbzdlNDJ2UDdtR0RCcWsrTFBXZnh6ay92dzlKbFJyZnB0NG0vNlZyakFo?=
 =?utf-8?B?ZXBIZWw0MmkyMjMxRkxhYThQZGVrRUNKVjhoUEZabnZpNXUzNFpodjl1UW1t?=
 =?utf-8?B?VXAvd3Z6R2I3VWY2MGtuWEFCSURMY3lSOUsrejNxOFBEMVcwTk5iN2hyamJN?=
 =?utf-8?B?a3AvTEtjQS92ODdQQ2lOdzNHeWtPaitYZnZ1eFRzMUhEbjE2YUpiWExmMGRJ?=
 =?utf-8?B?QVc4biszSjVia2FGWmwxVnIwTDZZOE5SeERzUE83b0ZKRE1OcEswZkUzM1BQ?=
 =?utf-8?B?anprWDQxbnFVSEgrVEM0N3U1cGdGeHRnQ0h0U3hLNktrdEZaMXZOWXZaNHV5?=
 =?utf-8?B?dG9udmo5UGl2aFNXcHcxdGUxcWxlNlllbiszZjliUnFqOGVVckRzM045bGJw?=
 =?utf-8?B?R2xGZElFelV2Zy9wTERrZ2lXYUg0c0txV0dLckhEdVl2TTB3WHcxaE1XVE00?=
 =?utf-8?B?Ukx0ZDBkMW12THBjU1F5ODZUU1lMdWxXdkowTmJBdHE4VFU5clIxcnozU0Qw?=
 =?utf-8?B?RW4zZ0g1ME9pTU9WbVNVM1d0LzVjNTk1eGFscDllU1JWeER1RDJ3MHFoTmN6?=
 =?utf-8?B?WVN1bjlhK1p2ZFh5MzArTnFrWFQvU056aExxREVkeTRsbUZ3RmRSeU1ITmNp?=
 =?utf-8?B?dzk4K21wNTkxdFlZZmhiSjI0UE9tVW1ZUGFSSkc2N2VhbTEzdzJ2eWRzRGZF?=
 =?utf-8?B?SVF2N2wybEdIYkJpLy8zTGl2M0tEdlo5cHUyeG5ucExzZEhmWGhxbGRNTVpQ?=
 =?utf-8?B?TWJDYmlSYkVKMkIvcWJlZ3AzVitIUEJ3eXNncjZLOE9YTWZERzRYN2JCYnh5?=
 =?utf-8?B?S0NibjAveXpiTEhVUnVTdE1ZNjRKRWNEc1E5bHBrdWpTZG05QWhWMVNvM0dw?=
 =?utf-8?B?SERGL0J1eVBId29kR3ZSNm9KRDJ4SUNCaUZXd1YwOEoyRFFna2cySjFaaEUy?=
 =?utf-8?B?K3ZrT0h0Z1RCSzRZQVF3TFB2QTR5Q2k4OFVaUHdzdWNzZmxlM0xyQy9wanZa?=
 =?utf-8?B?dWtXWGJYWE1rQ3cvRldYdFNoZEFHcjgvSi9mSk1EN2VoWGhDVTNGd294a3Bs?=
 =?utf-8?B?T3NaWEVBek9YZjUvRTE2eHJLNXhCTmZhZ1ZxUlg1Mkl1WjNnUi9jOGdEcURw?=
 =?utf-8?B?Uk1FYXRSeXhNSTdGUWpBUFVranpkYkViVTAvUEZjdEpjL09wcU13VnB1amV5?=
 =?utf-8?B?NmcwZDNQd01PcW54MENzaFp6ZDk5NWxlbWFRRjFvY1M4Vml6YWk5ZExXM3hB?=
 =?utf-8?B?K2tMSFljSi8rK0QvNWdvd1pCbmtKbVZTQzdLaUg4Q1B4UUgyM2hEc3ByOUZU?=
 =?utf-8?B?NTF6SHJTUENiRnowWEtLa2NwQ3N2aVJMSHptNVpEVVQrcTZlRUNBUHArT2FL?=
 =?utf-8?B?TFl5eW1IeTJQZUQ5VEhmayszVTJmekRuZjVSL3lPSU9BalE5RnI4cThKK3Nx?=
 =?utf-8?B?MWF0TmRHUWQxbFBxMllGSXpYN2tDUG9qWXRtTWxTU25yNGhEMS9zY252QVdS?=
 =?utf-8?B?bWNBRkIrcVRpZFgvOHdQMVd6MWtOaitBajBWNzhlYWlKR1hraHVSRVRJN0hm?=
 =?utf-8?B?dXJCUHpGYUovOFRZNlFYVTZOZEdJampmSmQzME1IaXpEWE1ydjQvWXhobkZ4?=
 =?utf-8?B?eWcwSjlkZTNaNjV5NkRlcHppSEwzNVk0akxsdmxHb2EvRm9OYmswTG5sOUQ4?=
 =?utf-8?B?RTA1RFN4TnFqaGN1M0R2S09kMU81SU8xNjVPMnhyenVOV2FtSi80QzlKQ1Uy?=
 =?utf-8?B?Tk14T3FoMGZTeHZQZ3poMTQ5bE5ReWsrWVpEQnJpSGxHWUV3TmY0WHROWVQ1?=
 =?utf-8?B?T0lTOE1wdTNwS2IyWEh3Sk5RaEJISENNU3E4Q1dHVzZkZVVHNTBwV1p2QWhY?=
 =?utf-8?B?OTBGZUE5eFphSEdqTGZtd0Y3V0ZrZkEvYWFMWHcxdVJ3dmNGZzFoQT09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a9f43fce-20df-41d9-aa5a-08dedde4db1e
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB7548.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2026 18:06:53.3428
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +0LOicBlbhQbiOzGfR5zHERHql7ev9ngKZZDBcWlhsAs1Qf12amhmL8Z+jnc0JEjZy/l+tOu1475fIpYcvjsVg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6617
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
	TAGGED_FROM(0.00)[bounces-22971-lists,linux-rdma=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[Nvidia.com:dkim,vger.kernel.org:from_smtp,nvidia.com:from_mime,nvidia.com:email,nvidia.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: CFCDB73421B



On 09/07/2026 12:46, Jiri Pirko wrote:
> Thu, Jul 09, 2026 at 07:45:20AM +0200, mbloch@nvidia.com wrote:
>>
>>
>> On 08/07/2026 11:59, Jiri Pirko wrote:
>>> Tue, Jul 07, 2026 at 07:45:25PM +0200, mbloch@nvidia.com wrote:
>>>> Apply parsed devlink_eswitch_mode= defaults after devlink registration
>>>> and after successful reload.
>>>>
>>>> devl_register() may still be called before the device is ready for an
>>>> eswitch mode change. Keep the registration path passive and let the
>>>> regular devl_unlock() path queue the async apply work once the instance
>>>> is registered and the default is still pending.
>>>>
>>>> The queueing path runs while the devlink instance lock is held, so the
>>>> queued work gets its devlink reference before the caller drops the lock.
>>>> The worker then takes the devlink instance lock normally and applies the
>>>> default only if the instance is still registered and the default is still
>>>> pending.
>>>
>>> This is very code-descriptive. What's the benefit of that?
>>
>> The point is that there is still a window before the queued work
>> runs where the user can explicitly set the eswitch mode. If they 
>> do, the default will no longer be pending, so the worker will skip
>> applying it.
>>
>> I'll reword.
>>
>>>
>>>
>>>>
>>>> For successful reloads that performed DRIVER_REINIT, devlink_reload()
>>>> already holds the devlink instance lock and the driver has completed
>>>> reload_up(). Clear pending work and apply the default directly from the
>>>> reload path instead of queueing work.
>>>>
>>>> Preserve the user configured mode when it is set before devlink applies
>>>> the default.
>>>>
>>>
>>> [..]
>>>
>>>
>>>> +void devlink_default_esw_mode_apply_locked(struct devlink *devlink)
>>>> +{
>>>> +	const struct devlink_ops *ops = devlink->ops;
>>>> +	int err;
>>>> +
>>>> +	devl_assert_locked(devlink);
>>>> +
>>>> +	if (!devlink_default_esw_mode_match(devlink))
>>>> +		return;
>>>> +
>>>> +	if (!ops->eswitch_mode_set) {
>>>> +		if (!devlink_default_esw_mode_match_all)
>>>> +			devl_warn(devlink,
>>>> +				  "devlink_eswitch_mode= selected this device but eswitch mode setting is not supported\n");
>>>> +		return;
>>>> +	}
>>>> +
>>>> +	err = devlink_eswitch_mode_set(devlink, devlink_default_esw_mode, NULL);
>>>> +	if (err)
>>>> +		devl_warn(devlink,
>>>> +			  "Couldn't apply default eswitch mode, err %d\n",
>>>> +			  err);
>>>> +}
>>>> +
>>>> +void devlink_default_esw_mode_queue_apply_work(struct devlink *devlink)
>>>
>>> eswitch/esw - we call it "eswitch" consistently everywhere. Why "esw"
>>> here?
>>
>> Ack
>>
>>>
>>>
>>>
>>>> +{
>>>> +	devl_assert_locked(devlink);
>>>> +
>>>> +	if (!devlink_default_esw_mode_enabled || !devlink_default_esw_mode_wq)
>>>> +		return;
>>>> +	if (!devlink->default_esw_mode_apply_pending ||
>>>> +	    !__devl_is_registered(devlink))
>>>> +		return;
>>>> +	if (!devlink_try_get(devlink))
>>>> +		return;
>>>> +	if (!queue_work(devlink_default_esw_mode_wq,
>>>> +			&devlink->default_esw_mode_apply_work))
>>>> +		devlink_put(devlink);
>>>> +}
>>>> +
>>>> +static void devlink_default_esw_mode_apply_work(struct work_struct *work)
>>>> +{
>>>> +	struct devlink *devlink;
>>>> +
>>>> +	devlink = container_of(work, struct devlink,
>>>> +			       default_esw_mode_apply_work);
>>>> +
>>>
>>> What happens if userspace eswitch mode set happens now? Any userspace
>>> attempt should cancel the default apply. I don't see such mechanism in
>>> your patches, did I miss it?
>>
>> devlink_nl_eswitch_set_doit() calls
>> devlink_default_esw_mode_apply_pending_clear(), which clears the
>> pending bit.
>>
>> So if a user sets the eswitch mode before the queued default
>> work applies it, the worker will see that the default is no longer
>> pending and will do nothing
> 
> Okay.
> 
> 
>>
>>>
>>>
>>>
>>>> +	devl_lock(devlink);
>>>> +
>>>> +	if (devl_is_registered(devlink) &&
>>>> +	    devlink->default_esw_mode_apply_pending) {
>>>> +		devlink_default_esw_mode_apply_locked(devlink);
>>>> +		devlink->default_esw_mode_apply_pending = false;
>>>> +	}
>>>> +
>>>> +	devl_unlock(devlink);
>>>> +	devlink_put(devlink);
>>>> +}
>>>> +
>>>> +void devlink_default_esw_mode_instance_init(struct devlink *devlink)
>>>
>>> Why "_instance_"? Care to drop?
>>
>> Ack
>>
>>>
>>>
>>>> +{
>>>> +	INIT_WORK(&devlink->default_esw_mode_apply_work,
>>>> +		  devlink_default_esw_mode_apply_work);
>>>> +	devlink->default_esw_mode_apply_pending = true;
>>>> +}
>>>> +
>>>> +void devlink_default_esw_mode_apply_pending_clear(struct devlink *devlink)
>>>> +{
>>>> +	devl_assert_locked(devlink);
>>>> +
>>>> +	devlink->default_esw_mode_apply_pending = false;
>>>> +}
>>>> +
>>>> +void devlink_default_esw_mode_instance_cleanup(struct devlink *devlink)
>>>
>>> Why "_instance_"? Care to drop?
>>
>> Ack
>>
>>>
>>>
>>>> +{
>>>> +	if (cancel_work_sync(&devlink->default_esw_mode_apply_work))
>>>> +		devlink_put(devlink);
>>>> +}
>>>> +
>>>> static int __init devlink_default_esw_mode_setup(char *str)
>>>> {
>>>> 	devlink_default_esw_mode_param = str;
>>>> @@ -228,10 +325,21 @@ int __init devlink_default_esw_mode_init(void)
>>>> 		return err;
>>>> 	}
>>>>
>>>> +	devlink_default_esw_mode_wq = alloc_workqueue("devlink_default_esw_mode",
>>>> +						      WQ_UNBOUND | WQ_MEM_RECLAIM,
>>>> +						      0);
>>>> +	if (!devlink_default_esw_mode_wq) {
>>>> +		devlink_default_esw_mode_param = NULL;
>>>> +		devlink_default_esw_mode_nodes_clear();
>>>> +		pr_warn("devlink: devlink_eswitch_mode parameter ignored, failed to allocate workqueue\n");
>>>
>>> Why you don't "return"  here? I think that we don't need to allow the
>>> case wq is not allocated.
>>
>> The function returns right after this block. It is not treated
> 
> What I ment was "return error".
> 
> 
>> as a valid “workqueue unavailable” mode, the parsed defaults are
>> cleared, the parameter is ignored, and no default eswitch mode will
>> be applied.
>>
>> I kept it as a non critical failure so we do not abort the whole
>> devlink init just because the default-mode workqueue could not be
>> allocated.
> 
> Why to treat it like this? Is there any other example of such flow in
> devlink? I don't see the benefit, only potential confusion in very
> unlikely case the alloc_workqueue fails. Am I wrong? If not, just bail
> out here.

As I'm dropping the work queue it doesn't matter. I'll treat failed
parsing as error then.

Mark

> 
> 
> 
>>
>> That said, I can make this more explicit by returning 0 directly
>>from this error path.
>>
>> Mark
>>
>>>
>>>
>>>> +	}
>>>> +
>>>> 	return 0;
>>>> }
>>>>
>>>> void __init devlink_default_esw_mode_cleanup(void)
>>>> {
>>>> +	if (devlink_default_esw_mode_wq)
>>>> +		destroy_workqueue(devlink_default_esw_mode_wq);
>>>> 	devlink_default_esw_mode_nodes_clear();
>>>> }
>>>
>>> [..]
>>


