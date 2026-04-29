Return-Path: <linux-rdma+bounces-19721-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MPEIFzfD8WkbkQEAu9opvQ
	(envelope-from <linux-rdma+bounces-19721-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 29 Apr 2026 10:37:11 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C0FE2491415
	for <lists+linux-rdma@lfdr.de>; Wed, 29 Apr 2026 10:37:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 81F423034293
	for <lists+linux-rdma@lfdr.de>; Wed, 29 Apr 2026 08:36:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DACC3AA187;
	Wed, 29 Apr 2026 08:36:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="QfQkpcab"
X-Original-To: linux-rdma@vger.kernel.org
Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010067.outbound.protection.outlook.com [40.93.198.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF0FA2989BC;
	Wed, 29 Apr 2026 08:36:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777451771; cv=fail; b=IrfGk7wc85auk0V0Iz940AumQUWP4wfP/iU9JDlvCephNeslQZNUXePv2H77py+yqPdNtcka8NZ7Vi1CwYijqeGeDRcyLRhAoiv22+of5CLAYeHnUDnXKUozjsu7liWkJ4ITRwTlLDV7uhRmy6pQFFDpDMnzS4ZbV44Awn12AXU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777451771; c=relaxed/simple;
	bh=OYqpGPjNoPh+GyjAE/2OeMMryyl3+gmcqKCDaKb6ACQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=FIDBwtwGXJoZXcMWs3+LwhZBujZNDK2Hx47S46YByVQT52WlLq4QEVrlszxR2wug9+lxqPlgHhNiUG09mEdXzR7ILTfXzzueSspngt9xyqjrNDNMBkuxYXk0EBTPzQ9XfhER84BM3sGcH62BErIflD35nd54JsNNM70wefJ7lxE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=QfQkpcab; arc=fail smtp.client-ip=40.93.198.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KKRLwmTAxOsz2lgyKy+ESHkiz47JtpWHDX9WezaYlz8F1o2GbBN7wWmXUmmNKRl+bWDYIxchN6B4vgYCtlKi/3MS4jyj15CsPeM4CLOcEdtmjmXANg3Z/jYr6BVEs6cwFgypqgCTzM2k1M5NxnAEyVYMEk2fTnH7vThovU8I1BmmjjzGKMrXZ0doxG81zQKmsUKgWoxSoX7nh700b4gS5WE0DDMBmoQBJ4DGihqudKcmiY3fO9fijtyRyULeUkDHdRYSj71j3HDLhx2wmgJc+mU7Tvs4l36ATmjELdnP064752nDFHukl+fm7cCvxdBMrCLfBwYDh2iY6PhCp9LRdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j2MsIFrySNvwJfAaxccy1+iHuVrDYKzp5APGD55LtGI=;
 b=kzWV5hxFoTHfAPzpmsB6foEikP612MQMPwBHU0xoNmNWbyc/2ErBgCIeV/ssoAv8dbH2gyF6ZqSWGQ3fDJi3uueoq1sWChPN0bljf5dajpzt0yIo/XdHuqGhdnm+u/pcrGBDYPH4FxN/+/z5vc2xrjazcRclRnSnHg7K7mB8UWXSbVvNY5af834P1JIzAjiAffXbgpwdsYpCKTgF+WdQ849uZVe2c6T94UAXmunXQl3Y9bXE9V1QE2yz7cguhFxWztRFGUvKlcYuGReSliOXLLAanuQRjTW6IX+q3bNmAm+F+8kCQXo8etzkDkCV4FLUv2WkwVt5iYuc298uS6JGeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j2MsIFrySNvwJfAaxccy1+iHuVrDYKzp5APGD55LtGI=;
 b=QfQkpcab1a5mIbVWtBPAYYuaUDPdMlvzq7EiUOFer561dFu1Xy+l22gr/52irfNUjqf9sEy6zN2KW7yUBmzqxyrSwwCTQZ2R/zrDOWerhV3fkBbRIVhwb6/8Tt+G2v0XNlrjvcpNhah0yJBaaiZYEXwhhmt81hL01WAfvv23YtOTVYfp6frAINf9HiZptTQMz6ym0T9Ab5149Z2U4GLnP+D6ZKJ5aSNeVOxODSqKdsDZEeuqQPfX3Hzi/F8tABoivvfWRyGgkt19cGjoGTmmE2+/tRQappSJYrmfzFIbW/VU9KMVtQOCWZTb+dv7n7PVskd4pnvYqknHGgFqmikJHw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB6583.namprd12.prod.outlook.com (2603:10b6:8:d1::12) by
 PH7PR12MB9224.namprd12.prod.outlook.com (2603:10b6:510:2e7::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9870.20; Wed, 29 Apr 2026 08:36:07 +0000
Received: from DS0PR12MB6583.namprd12.prod.outlook.com
 ([fe80::16e2:19ba:8915:90be]) by DS0PR12MB6583.namprd12.prod.outlook.com
 ([fe80::16e2:19ba:8915:90be%5]) with mapi id 15.20.9870.016; Wed, 29 Apr 2026
 08:36:06 +0000
Message-ID: <345650f0-6da6-447c-9b27-0bbefca0558f@nvidia.com>
Date: Wed, 29 Apr 2026 11:36:04 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [bug report] Potential refcounting
To: Ginger <ginger.jzllee@gmail.com>
Cc: netdev@vger.kernel.org, linux-rdma@vger.kernel.org,
 linux-kernel@vger.kernel.org, ttoukan.linux@gmail.com
References: <CAGp+u1bdbe_5Xk6icnDcs70Krbr_6M4yXjhs0HVo8T4953wNSQ@mail.gmail.com>
Content-Language: en-US
From: Tariq Toukan <tariqt@nvidia.com>
In-Reply-To: <CAGp+u1bdbe_5Xk6icnDcs70Krbr_6M4yXjhs0HVo8T4953wNSQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TL0P290CA0012.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:5::12) To DS0PR12MB6583.namprd12.prod.outlook.com
 (2603:10b6:8:d1::12)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6583:EE_|PH7PR12MB9224:EE_
X-MS-Office365-Filtering-Correlation-Id: 386edcd3-e546-45c6-fa5c-08dea5ca5b32
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	CDLet56aCxAEVQQ+0bCBfpuxEKle4qyaE6EH7kfOwc0+HOQT+LJpiZSSzIrk2Z7np6wuu9sAi1a2yXPI5vhXIBBkQf9rN8VB1CJ4wCpkJXXwIpgSQV171faWPiEU819gp69EMG6iqAKbC/JpUWxYYHz1NlMGX9sg7Gf29VaYKlQWzTzCswyoCd1fkqFGW7yXyWO91d0cJvks2/zDgJYO684OfrkFdldKfaZu/mVPU9nwcAyUWJdxAHRPGdemxhOYrHaJTmOXf1XlhxI0Akzu5yu93EaabX/k+GQ55ZR2aYmkhyHmZqwfKuqjW5LdhcN7pJ2C6vT+hTsexLW2/ufqXMtuqpoGkve4Q62/N278XJsUN1nAESb93bHKNhxaBeRvt3IpaNmBQJ8nsRrjY4huenetZVsxGnPVv0XpClt+q1UonrSa6R+/P6G6aC85QNHhZJ4o7S4m6uqEiSrQ2+8owqsAJIe85S2HI1KiKkXZbuTvefdOxSx9l5wkOOHUmAHnKc3tn7mfRDAJVt9Zj1P/JfVOSE5R15Fs247OQOt18jmTdolLe3ZyWmSX7olSsA++xm9bEjKdEzcqItVQCcA7+YMi5lRWgfavLyJgtF0U6o6yUX8iafQpZMIq7NICRck04J/WjgYfwhVtc5mU1+WrvJfmbXfl3yJoHaG4815qtmB9xKCL+J6goimIQtwSox2MEetXsHTDTgEwJQYgZp5hTJ5A0wLK1luo+SxSFTz6wPI=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6583.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Vmc2R3BkWGYwMkJRdHozMUl4S2xobFRaaHlwUngrZGpjYXpKYjdlOGJLTys2?=
 =?utf-8?B?WVE1cnZwZUFMeWlCeUl5TXdxOHJ4SmFvd3I1dHl1WG5ZVTdqbHA1eFhCYm5V?=
 =?utf-8?B?a3gvWUNENi91THVRdUNxNUU1Ukw3dmgzQzB2cXFYcUpsMDQvRnF1di9DaWx1?=
 =?utf-8?B?YkU0WkJQeVFGNFVxYTA3MnFpeDJEc2o0ZzI2V0NjbnQvRHpNSDFHZTBGYUs1?=
 =?utf-8?B?NjhiYWZOWUEwNWFEcjJ6SFNZMjM3UG5OM0RRNmppM1Vjakd0NzBvZ0IyOEJW?=
 =?utf-8?B?dmJHaGVnMVRqWHZnelA2OGNtV1BZMWFtZG55UmM2bUluckcwZkE4Ynp3SDVu?=
 =?utf-8?B?KytoeWN1RGI3cTVzcGFTYlhObEdqdy9Ga0szM01OLzI2NjJJa2xGcThyVnlV?=
 =?utf-8?B?RDNENTBXQWhaZEpidng0WW9MdHc1ck1tZlVKaGlHejcvcS94dUFyMXB6c2NN?=
 =?utf-8?B?YWwxbW52Wjl1U0lxV2J3L215Ujd5aFVQM1Zwa3JEVjVkejBiVzMxQ3Bobjl4?=
 =?utf-8?B?Tm9ic1VPR2RXYllTWXBiclVCU2syZVRLcXQ0ai9Xb3E1ZnR4U1hMREdBVWIw?=
 =?utf-8?B?QTZWa2l5T3pFSzhhQzQ4ZG8wdSt5YTZjaUxueUZUZU9KcWdlWW9McTlYM2dY?=
 =?utf-8?B?SVlMdjZRTTZ0eG5VOVc3Q3FrRE1SZzVmM3dLWVBZcWtQNzYwT1VSQzdGUHJq?=
 =?utf-8?B?cjR1d3VwY01Cb2VhQmJub3VCRFYzMS9DdDNzOG1tSnRvOGFIMnhsZUNlSlgr?=
 =?utf-8?B?bUNiY3I0Y0NXUXgyOVFvblRONkRXMG1JT1pKa0piYml1cEM0RmltTWhYak5K?=
 =?utf-8?B?WUJDb1QyZ1pybWdXR29KVWhsMnEyZEZQSzRzRjlTaWlSaDF4cUdZNVUxbVBz?=
 =?utf-8?B?V0twTTB5V2thTmQ0YXVxdUQxNEl6MHNxWDFEbG1FNkJ2SzYrUzdKRHcxRHJ3?=
 =?utf-8?B?ZTF5UHl6cy9qOGxUSzB0ZHZrYS9hRERSa05Gd1V1cGQrV2dpeFhlOXRxYmFs?=
 =?utf-8?B?YWpjR0VyMWtJOElYcGI2MFNSeHNDM0x6Z0dXZ2FsRVhlTXJvS296aXhhelQ3?=
 =?utf-8?B?eGRzVytnR1o1VDZQVisxdmpocGNOQ01QTUMwdjR6azRaSStpSWVMZ0JZY0lK?=
 =?utf-8?B?NWpkSGtJSXBkUmVWVi94cW4waWRTM3M1ZjVaS3hleUZUdUQ4WTZOMVBBanFo?=
 =?utf-8?B?ZFVBdWlpVUt2Y1I5b3hmOXFnRGpHalE0b09NWjAySDFqVkR5Ukg0WjQ1OWlr?=
 =?utf-8?B?SEZ5ay8weVk3K0k2dmFoU2dUU01HSEpWd2pQTTZDay95Y1FRWnIvTmgwK213?=
 =?utf-8?B?T3UxbjdocmJYOXRFeDMxODdCRjEwYU5ORFRORXFxRkJDTkFRaFVzRFBuRXFF?=
 =?utf-8?B?UzJHcmhyZ09XcEVXUmFreEhQaC9OMVA3dSt4REUzS0lJa2JyY1BqaUhUbFNP?=
 =?utf-8?B?aGxVU3RXSXVBSWJoR0RkN1QrR0tKcWVpTzcrTmhMRmMraWlzUEFIQ2FmTWNX?=
 =?utf-8?B?enE5NGJJV3cydExQSDFIUWYrcGJzUWhlSHFGbUdSOEZFcTRxL0ozVEtaUVVO?=
 =?utf-8?B?WXMvaWI4ZnQvcnR1Z3JSUzIvTnFMLy9yWWJQbVIrblZXYVMxcHBLdEF6UU5F?=
 =?utf-8?B?ZjlYSGpTRXllbnQydHNDYlNBdDQrM0pCOGxMMlYxNFpLNC9jVEhnaEczN05Q?=
 =?utf-8?B?cnJGVHBSUTZqSUorc1dGMjlpb3pWNzl5Q1VYS3RtVHlwck1HVEJBTG1tL2NF?=
 =?utf-8?B?NG5LTHBtazEwc21zeE1rUTB6SjhEZEJLRk1idkgxS0s3MW9PbzVWNkVuWXYx?=
 =?utf-8?B?aHVkMWdyOGVhZlJVMXp0UEZsa0JqbTBEcVVnRTJvYnNnQTlydXlhb3d6Tllz?=
 =?utf-8?B?RTJHQk5Rd2hyZ2xjZW9FT0Y0NW9TRVRQN1dOT0VHQ2d0b0JIbUlWb1NvQno4?=
 =?utf-8?B?SDRZT2dzRlcwSkIweVVXN1VsZ1UvNTB3NnJoVjVjL3NPRDJWcE9uMGV0S0I5?=
 =?utf-8?B?UzVPVmtDbzRVVWM2NVpIUHl6SlU2WWE0Nk94SHhDTGhtMDEyN1NjRWlGYytL?=
 =?utf-8?B?SUYrSjhsL29sTXFBeXBIV0IyU2tDaWduZ09qTTdZY3NPRnBreWY3SWxrcElz?=
 =?utf-8?B?Z3IyT3F2SDQ3bTNnTjRhYW5rbUFDT21vL1dDRkpRdHhqWVM2Q3NIeUpzVVdw?=
 =?utf-8?B?YmsveCthMHBNSHRQTzFtODNDS2R6THZybFVLYzJBajVlVG1KNkNCZExYSDhy?=
 =?utf-8?B?a09tUUh5UHU0S0U5Rkk5ejlmOVEwa0JoT0J5TTdDYTRWU3pFQ3VNT3ZYam0z?=
 =?utf-8?B?S0dsRW9BNzVwUUhsSzY5OUkvV0lMUDhJd2E1YXZrTWFkUUhLNmVJZz09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 386edcd3-e546-45c6-fa5c-08dea5ca5b32
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6583.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2026 08:36:06.8055
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OShjkEQZhF6SMWuvtgVB0mi/2sRsNtsgSCZb6R4Q9H0ULOCWApKvgMElA9Pj7GoLd6YfjB1iN1H6/IS/gy+0zg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB9224
X-Rspamd-Queue-Id: C0FE2491415
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-19721-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tariqt@nvidia.com,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-rdma];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[Nvidia.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nvidia.com:mid]



On 27/04/2026 5:07, Ginger wrote:
> Dear Linux kernel maintainers,
> 
> My research-based static analyzer found a potential
> refcounting/atomicity bug within the
> 'drivers/net/ethernet/mellanox/mlx4' subsystem, more specifically, in
> 'drivers/net/ethernet/mellanox/mlx4/cq.c'.
> 
> Kernel version: long-term kernel v6.18.9
> 
> Potential concurrent triggering executions:
> T0:
> mlx4_cq_tasklet_cb
>       --> if (refcount_dec_and_test(&mcq->refcount))
>       --> complete(&mcq->free)
> 
> T1:
> mlx4_cq_completion
>      --> cq->comp(cq);
>          --> mlx4_add_cq_to_tasklet(struct mlx4_cq *cq)
>              --> spin_lock_irqsave(&tasklet_ctx->lock, flags);
>              --> refcount_inc(&cq->refcount);
>              --> spin_unlock_irqrestore(&tasklet_ctx->lock, flags);
> 
> In T1, the refcounting increment on 'cq->refcount)', although within
> the protection range of the 'tasklet_ctx->locl', is not synchronized
> against T0 because 'refcount_inc()' does not check whether the
> refcount has reached zero in T0. This case is potentially problematic
> because T0 decrements he 'mcq->refcount' and can enable the
> 'mlx4_cq_free()' to proceed.
> 
> Thank you for your time and consideration.
> 
> Best regards,
> Ginger
> 

Hi,

Thanks for your report.

IMO the described race is impossible.

CQs that work with mlx4_add_cq_to_tasklet as their comp() callback (i.e. 
T1) are added to the relevant list only after refcount is incremented.

Hence, if a CQ exists in the list in T0, it necessarily means that 
refcount is already elevated, and calling refcount_dec_and_test is safe.

Regards,
Tariq

