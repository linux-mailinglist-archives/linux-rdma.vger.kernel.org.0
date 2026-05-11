Return-Path: <linux-rdma+bounces-20378-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wP9aKy2dAWoHggEAu9opvQ
	(envelope-from <linux-rdma+bounces-20378-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 11 May 2026 11:11:09 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 44BD850AA73
	for <lists+linux-rdma@lfdr.de>; Mon, 11 May 2026 11:11:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9ED323027D99
	for <lists+linux-rdma@lfdr.de>; Mon, 11 May 2026 09:05:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C2C03CE485;
	Mon, 11 May 2026 09:02:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="owqjnxIi"
X-Original-To: linux-rdma@vger.kernel.org
Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010025.outbound.protection.outlook.com [40.93.198.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FE2D3C871E;
	Mon, 11 May 2026 09:02:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.25
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778490176; cv=fail; b=RG2zn5pXO0gmVg4Lum6akSVKtBUFpe0IFbF3/Q88PzrJ/ctuVpv0LdQHp5ZCLK2UlFjAxw0ZIzPS3z1TsdbdovkpEBnFnRU+SMbNYVyexOJZ/k+So4Okkv3bu58GTbm2vmix1Ut9nnzrPbSVM04/AF58tyqYkbfs6bSxNTdwjH0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778490176; c=relaxed/simple;
	bh=CE0oOKDmx6cJ6ApuyzbrBoqEfucOPDr/DA9DbZUQYdg=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=AuqQvFUzK0X+vDJ1867X30zu/nf7RnhiKKsJ2WXNXWZlUKNmluBMSzBa+Obt2lLVKO1F6FpSQKNb11tOHN5WBimvtj8FuLRODs/tD5iyZReVLHXrQjo1t2g85djKoKKTeYUfKZBjtebRBZxwvLFYr4s6P2+T9K8Fx4eiHkZ7cqA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=owqjnxIi; arc=fail smtp.client-ip=40.93.198.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YsmssT5/VbSW62zGdpt2C8oi/NjjgovSIACSp07ECQnP49/eVbOY6MjSVA1bseHuLlfc2Ev4wVChoU0UixAQJhlG1ACM5ezaN5FB6AiwlKCFL87n9tf4YNuz2JCwM0/K9BIrxFfso5D4O48ne9azI1kQq5PBJscSZKE4Al2DAvnQ/joSz2DtlNqNlesYXcKM1/6Vu7ntj7euSYMbJFH3eOxoEugfjKYTCT+tof3f7ny3+OibbqcwcjTRXQhqv1cEU7aSEolHcX7bPh1w12wtcOEPWMzfPTtnAimTr5GZDmoUCjsc3JDuayXa/r3iCTgiVHEuONDGL/0hI2O8pTClbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=akIhezj70BxhhYOBOofKnBBTNgKxMMXnf74bci1wnBI=;
 b=RX8H6DJ5xzl/2LE4g/CCkdM+sh4Apw9YB9yxQ9BDmU9XiYbO1qLbEiFPIo0xKOVq8dZtkpDj8fcKtyuDfL1RK4Z+1B99UMe3IlWbfPCq+ngPWMiEW10GxBvRlodsIJRNOzIQOJeeavsu4y6m1kQT59LLEc9Pt3CzuOyHn/+JQ9tLFAYXCnIfMEDRbIqwTLrzVmCoej67pPf801K9HeD985LNzC4v21UjbBMBRXdUuTrttHOL+vJ4EVs/0IzD2Q96EnynQOY/PYPMmfw2m01tOnwolwluWQnv3EftavQIZFUT9E4bVpnNXstCJJu66Z4IRRwzH/wrJxdQsmlfRC9mxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=akIhezj70BxhhYOBOofKnBBTNgKxMMXnf74bci1wnBI=;
 b=owqjnxIijk7ULZdLAUPXKFXa/US6bUFzBC3lO1p2iIhEXpEKeDK1g3FsnL15YIT1PiYHjSOu7LbUuvq0dq5dchMdDIr3KKorAQbAav9rStAxL1CtMg0Ix9bLI/Temyd3RUvXO4qL4atyI/A4lDfYmA63rCGjyJR5iIYwlBVMlkK8dMxRMBn5668G/afMvaz57E5I43d/C0//8xN7DjiNDDFvo7DtQhHWHT8/r+GAMqbBIflrCG5S9XONm3xSZFNO6Sqat59UEW5CxsCbyR3sbs9qIdQQBj4h4s24CDx2KYbVEeNQ3vhg4/tvyX7OW9ZrhTjIAcQn/VH/etA9Ac1tag==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8728.namprd12.prod.outlook.com (2603:10b6:610:171::12)
 by DM4PR12MB7574.namprd12.prod.outlook.com (2603:10b6:8:10e::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.23; Mon, 11 May
 2026 09:02:49 +0000
Received: from CH3PR12MB8728.namprd12.prod.outlook.com
 ([fe80::2641:1046:bdf3:93d7]) by CH3PR12MB8728.namprd12.prod.outlook.com
 ([fe80::2641:1046:bdf3:93d7%7]) with mapi id 15.20.9891.021; Mon, 11 May 2026
 09:02:49 +0000
Message-ID: <ab304ee8-4eeb-48d8-a70d-9eebf3fb82fa@nvidia.com>
Date: Mon, 11 May 2026 11:02:41 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v13 net-next 2/9] net/mlx5e: Reduce stack use reading PCIe
 congestion thresholds
To: Ratheesh Kannoth <rkannoth@marvell.com>, linux-kernel@vger.kernel.org,
 linux-rdma@vger.kernel.org, netdev@vger.kernel.org, oss-drivers@corigine.com
Cc: akiyano@amazon.com, andrew+netdev@lunn.ch, anthony.l.nguyen@intel.com,
 arkadiusz.kubalewski@intel.com, brett.creeley@amd.com, darinzon@amazon.com,
 davem@davemloft.net, donald.hunter@gmail.com, edumazet@google.com,
 horms@kernel.org, idosch@nvidia.com, ivecera@redhat.com, jiri@resnulli.us,
 kuba@kernel.org, leon@kernel.org, mbloch@nvidia.com,
 michael.chan@broadcom.com, pabeni@redhat.com, pavan.chebbi@broadcom.com,
 petrm@nvidia.com, Prathosh.Satish@microchip.com,
 przemyslaw.kitszel@intel.com, saeedm@nvidia.com, sgoutham@marvell.com,
 tariqt@nvidia.com, vadim.fedorenko@linux.dev
References: <20260511033923.1301976-1-rkannoth@marvell.com>
 <20260511033923.1301976-3-rkannoth@marvell.com>
Content-Language: en-US
From: Dragos Tatulea <dtatulea@nvidia.com>
In-Reply-To: <20260511033923.1301976-3-rkannoth@marvell.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0119.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a8::17) To CH3PR12MB8728.namprd12.prod.outlook.com
 (2603:10b6:610:171::12)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8728:EE_|DM4PR12MB7574:EE_
X-MS-Office365-Filtering-Correlation-Id: 631ce749-debf-48d3-e9fb-08deaf3c1345
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|366016|3023799003|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	FlbSrkbrn2abXbpGX38Bsip35bkI6vAO8Hu6lFKD0eynZIUL8ipW69F/tThkcyya/Jv1ZgzJrhtY8kDFxHDl3rTzB8h19L4R0Pi9pT5/2WftdDky0M3vjo/pQSkiC9R+d6Xq4qUhjFV+6iAtt9ExYdx5wC7dcG5Vxmn4fVxpQbGXNEXFDv+wzd17I/XkGjdMp47Erv5A9/fJ8de5yyqxpUc6+h8HTXhxgXeFiuQ7SaVHkpvD4GBqs4iJPKtAI8KuPjxebtd2aDO0EQoEFg9M2iG4/rbBf464ftnwD7SPzOx3549Kj3Jo+kzls2YyRzTRf/OFmExguzxcLADuFW6/sTP+eFyNb96jukucZgzGqS58/WOSUgt4gih700sMmyWyE2rLcXrbsxIPbOvLKTPrISjes/zKhrBUDEeasuDIn6n99EsBA4jtuG4Ftqui9C/a3bBbOWnsjaamqKkfsymEh/kyZV37/p4Xc3RpD+OLpgJ2Lv7uxXS3aA6DDCz/jHLf672yYjlsMZZYGwyQTZJMfdTRaFA9mzOsSY557K63bcYSwmprTQIpcEMK9WAcKP0f06l+n2uZW3Mm3OFO6j+hJ3IgEveBSBBG5yhI3FqlAO5j1VQKo2iROgNn+170/Newb8HT0to4mbHxXx6/vZF1+Dtqm6DrCD6NDVUbCqewSSLrZtmgqACWvcWMNgRYwjOx
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8728.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(3023799003)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZSsvS2FNL213OEZqbldVOWQwbktpUWIwNDZvd2o0L2kyQlZtclhiM09kUjZF?=
 =?utf-8?B?bExlR3YwbXJjL1FiQmh2WjhMTWNNa3lxR3RBUHRINnhud0JUdDBHM0llSThJ?=
 =?utf-8?B?MkduT2V0ckw0MDI5ajZJSXl4RVFRait1cTNhWXlYRnNBbzhtUm05Zi9PK0l2?=
 =?utf-8?B?Z0paYnJGN2thNXVWRUN0QmVaQVpMVWhtd0RCU0hZV3hjcGV0QW56RmZvUmMx?=
 =?utf-8?B?b2NvWWYxRHl6NWZmd1NKUE83VktPeVBBdHE5U1BaWktHNDlvZGVJQVB0M1kx?=
 =?utf-8?B?RjgyL3JqbCt0dWZyZS9Qbzg5R2JuKzdJK1JuVmVVZDV1UTlSTVVoZFRHb3BE?=
 =?utf-8?B?K3ljQmxzbG54ZW1Ub0l5SVVKaWJlK0FQeVozM2V3b3ZWZTREUjkrQnRxckx2?=
 =?utf-8?B?TUplMGpqemdYY0JoaDhnNkxtWXM0YUFIOUNjd0YwYVl5bzRhdUJjQkJGNXIr?=
 =?utf-8?B?SUhqOXpHWk1leDBBcUpuL0pSTVBvUkN2WllFejNLUTZBUXUvbFhwNmtFSllN?=
 =?utf-8?B?YXZtekQxS0VrbDBpUmhLOWpaM0t3bWFMTlZxMXdXWmZ5dEZFaW9uUHd1MTQr?=
 =?utf-8?B?bSsxR3VqTFhEbVZuMFhlTFBUMlQzYVVYbXBXZWZGbTVHTkNQL1IrS05ITHlx?=
 =?utf-8?B?cXNzbDhQSzhOU21VTlViOGlyRnNYZWIxeXJHc0c2enRmbVJGQkRlSklsZUhq?=
 =?utf-8?B?a0I3NVJsV2pqdkpwTmNhKzRTNHk3bmlSZEs3WGhSQnZMTU1URGh3dzI2QllV?=
 =?utf-8?B?YTJUOEVTQUw5VGQyOWJzckNMSUFHdzV6aWhMZGNmMnp4WmU2azh2QXk2Z3I2?=
 =?utf-8?B?a2VRQTkxYmt4NDBvSW9BWCtVcnk5SkJXNHBwMlFhTUxESWh4aWVpUy84RXlv?=
 =?utf-8?B?cUQ3UmhVQmtpMHRLcEFzV0RzNHcreGhaMlBMRlRTZVlFTXBGWTFuTXN0RXpC?=
 =?utf-8?B?dzZlMWtyTWk3ZHVuS3hEajVXKzhIK200bjJBRnF5aWJpWFlYcDhkdXkyR3Jk?=
 =?utf-8?B?QTdMK0t3SURQY3RKN3U4MEtUTlRmNHplbVdoM3ZvcHJrOTRPWGRncWpMWTZT?=
 =?utf-8?B?NWtvTlZzMVVPbks1TTZjVlVOWlBjUGdYWTlWanU2OVFOWkZxaXE2ODlBbHVX?=
 =?utf-8?B?UzlyRlhPTkd6b2x5RDJqMWZyRzIxMFY4dE1OYlY2MVhhNllZd09EMHkvUm95?=
 =?utf-8?B?eXMvdHRRaWlZQjJPblZVM0hkVW9DcTBjNzFHZ1VmQ1VhUWVoWW5HQ25teFN5?=
 =?utf-8?B?WnB5RGNEdUd5Nzc5SXNIemF3bkk3SW5VWldwOGdKMCtoOWpocjRBcG5jTzBV?=
 =?utf-8?B?cFkrYWhkekt4QVY4eHZxc3Y3V0VaNm96dHg2Zk5wcXRudDdaTDlZNGM1bjBh?=
 =?utf-8?B?K3pkaHlTWWJLR2JpQVNwYW9aNE4xVUtGaXo0QngzSEZidVFqVGEyMHBKWkdo?=
 =?utf-8?B?TDZ2aVk2a2Fid0dQUW9vaHFPaGcwRksrRjJHNmR5SktwTmVkRjF1RkQzQno5?=
 =?utf-8?B?eWFLVGNoUHZ1eW1JR1RzbkNpMWlJOXJla3pvTzVzOWYwVk1wdXB0SWpIOXYy?=
 =?utf-8?B?dXo0T2xBallHTzZlMWZxNjhrcVhhelpLb2JzMVEzMFNNUjBKZHNpTHpDN3J3?=
 =?utf-8?B?bHM5eUxyTkhIZy91dmRHdVFScTA4RVVKaVZiWEozNGE5M09Zc1NHTlhWelQ2?=
 =?utf-8?B?MHN3Q1pIMkZNUnpORWVsYWZBVDFpNURKTDhQckwxZjJDNGxuVlRRZFZVVDgy?=
 =?utf-8?B?MzlzUEdxSCsrcm9jMlBKRXplYlUrSnJGd3EyRndlc28xUExOdE5WdWM5N00y?=
 =?utf-8?B?cnRmSnUwdmQzZjd3VHRuNWg3SW9zK29XRWk2bytxSCt2ZXlyWTVzcmJwRm12?=
 =?utf-8?B?MlBOR05KRjU3dWEzRG5hZnovVmNyUHZEUG5Hditlak5OK0FRZjVDc2xId2ZF?=
 =?utf-8?B?UnRZQW1RdVppL3pkWDBLNHZabnFUUnBVbFg4SmRuNXd3WWxUblRhVnhWbkdC?=
 =?utf-8?B?YTBsYkN1RzIwTjNIUVdDMDhmNjFTc1VDSkczSWxkTFZpT0xzMHlCSjFXbzRD?=
 =?utf-8?B?YWFGdzJQOFNUelN1WExBRzdOWVhRN2JEYUlRWXUyM2RSdnRrQTVmTXdxR1dT?=
 =?utf-8?B?T1c5ZEdVN1E5TXNMQXRlcDd0MmFMY0diOGRJYk5pQ2g4T2RJMlF3eHd5QUtH?=
 =?utf-8?B?eXlweHV5Mi8rZDJxdlFSZnlIOHpOWnY0VHQ0cGwwMG0vKytsWkxFaDBNR1dt?=
 =?utf-8?B?UlJab0U4dmNoSjFzbzdBcFE5b0RLYUw2MXdrMFlXbk52WGNOb20yY2RyMG51?=
 =?utf-8?B?UUZxTEZ0UVNzYzVYaGszdk5lR09FLzZ3eFpNWm1IVnczUDAxR25FUT09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 631ce749-debf-48d3-e9fb-08deaf3c1345
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8728.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 May 2026 09:02:49.1746
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: T53heOMG+3MR54itvbyZNAPZCoPjX1v+PKTVPq64V6iZKW3xS1sG285cOrriBh2j0cTJWT785bcORbyGzwKDsw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7574
X-Rspamd-Queue-Id: 44BD850AA73
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[31];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20378-lists,linux-rdma=lfdr.de];
	FREEMAIL_CC(0.00)[amazon.com,lunn.ch,intel.com,amd.com,davemloft.net,gmail.com,google.com,kernel.org,nvidia.com,redhat.com,resnulli.us,broadcom.com,microchip.com,marvell.com,linux.dev];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dtatulea@nvidia.com,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:email,nvidia.com:mid,Nvidia.com:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,marvell.com:email]
X-Rspamd-Action: no action



On 11.05.26 05:39, Ratheesh Kannoth wrote:
> union devlink_param_value grew when U64 array parameters were added.
> Keeping union devlink_param_value val[4] in
> mlx5e_pcie_cong_get_thresh_config() exceeded the compiler's
> -Wframe-larger-than limit.
> 
> Reuse one union: call devl_param_driverinit_value_get() once per
> MLX5 PCIe congestion threshold and assign each vu16 to the
> corresponding mlx5e_pcie_cong_thresh member.
> 
> Signed-off-by: Ratheesh Kannoth <rkannoth@marvell.com>
> ---

Reviewed-by: Dragos Tatulea <dtatulea@nvidia.com>

Thanks for your patch!
Dragos


