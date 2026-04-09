Return-Path: <linux-rdma+bounces-19165-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AIQLOayw12kORggAu9opvQ
	(envelope-from <linux-rdma+bounces-19165-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 09 Apr 2026 15:59:08 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 94E923CBAF1
	for <lists+linux-rdma@lfdr.de>; Thu, 09 Apr 2026 15:59:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 444D8302A348
	for <lists+linux-rdma@lfdr.de>; Thu,  9 Apr 2026 13:54:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A66D3B52EB;
	Thu,  9 Apr 2026 13:54:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="lOwJUKNz"
X-Original-To: linux-rdma@vger.kernel.org
Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010049.outbound.protection.outlook.com [52.101.56.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A52E37F756;
	Thu,  9 Apr 2026 13:54:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775742874; cv=fail; b=WzNIE2c4x2Oy85/TQOwnV+Z/7unGowrQNUTamaJHJZwHAEt7nyo1Vc4cnSbF1pdlWbwjdmY/RuOJk+VRmKu7iXyMujl8j2fpiswyWe1NNrIvLlkupbszL3UeRRZVbq1mWADf1w8DyXQPHPuL1+3hatAMqrj6LcHDBxG0KzQMByc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775742874; c=relaxed/simple;
	bh=Em1Oo/Owlso0wCmZX3w1ZCzwOjBw7Nz6KyQgbyCSyX8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=qGA4l1289BqncxgZ6Hje/O+Qw3SoccD07sIXbihkqErlK5O1AQ8GRfusuyUIzYSNLr/tXaqgtVIMAFcecMiK0ybVYlTjnLVmB2IjBaskzwVB4hEzSHAuUk0bu8W5BpJz8DHSLrLH0XUMcj5f0m23MPOqhvucxXpygfx99qNNPuU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=lOwJUKNz; arc=fail smtp.client-ip=52.101.56.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=n46oRvFBoiFkioTQb61GMKdphwiiS9IqFft9GAarFRR6VjQWIgnGlQKG/m9BrVGZL0EJbYFfOegFEpIqBRiYZJfOomsApB0bNUgKgLvd/93cMtjSrXKUqYGm/d5Ooi3N204g+7k56Ij67kxOKS2XWiFLlR/pPaX4+9WYHt4lRwClvZGLjjZzPz2kod5Vq/5ESVPQPLDZ9l2B+fZHQ7OcI2e9S9Y4hOOezEHRCvoShB1AhgvdbRyHnTd7a6i7Z422jUBMMa1QMoQLt8+22BppYHftHgmNX+5EAOoFB3CHsvbhtf7BHBQSO3QLrrsOQNuNiRhm3RHcU+ecc7Kir1lBiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k7+Eim6Lv043ZvrADg5yoKxqDFU0L57tsyS9MD5FSzE=;
 b=TvW7ErNKKUT+f8wYub/xn5j6pJ0Z9hJrrjB8aXKvpnZ4obH1MOsuD7lkuHmHHNfoS4axOz8UYdxXBmua5MJt+SRc93kp/4MQfA+FqWBtLRy+0HJrMkx1WbkWqCzlKr6IM2L+YnsZuUyHgybGJDYPJUmXmNUnoUcArKfbAKu7E75FrrXMVbjdJHDvRW0nMOvwNy/MzpXD30BUkhQjwhTOhw/STLgKG2ORSKZ51SI0QNCnjf5t8dZ2yDl8t/92AaWjYFpcnQMQMtQbsJ9vYyMq/FGpJUgSLHpzU+NBw1rSM/kyPdAU6t/WonECajkaL/mW+rxlJqoZEaN/79qI/m9GGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k7+Eim6Lv043ZvrADg5yoKxqDFU0L57tsyS9MD5FSzE=;
 b=lOwJUKNz6Qi1iYp7xfs6cv4xhDn3eQiHDplLop1t41IENdiNqlw6ur90STd5gv8fGgOnajB2P1KdZS4OvJIZQoaY52xCdJipgCfwA3yhfmfYchuE6mCmeMcoMACzLZR6DKmf4ahavFPPwlz6VHRohWTADREGqdG0pwow7w32hqRxbbpED1PO5ox8v9k08y8Z3ia7HHNZjKtiGrO97OPg2kcTqTT13y1eCIIqTTC7xHL1t7pCulIjy0ZmIO/TYsiMC3HOxDFT+6i3VIqXA33YsaImKEIEIX+2yfZpINmXlwg+eTrcmtckOv5iMSnAhqFOJrzHnN1e84a9rkh/HIt+vQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM4PR12MB9734.namprd12.prod.outlook.com (2603:10b6:8:225::23)
 by MW4PR12MB7467.namprd12.prod.outlook.com (2603:10b6:303:212::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9791.32; Thu, 9 Apr
 2026 13:54:28 +0000
Received: from DM4PR12MB9734.namprd12.prod.outlook.com
 ([fe80::ba44:51c5:b641:2917]) by DM4PR12MB9734.namprd12.prod.outlook.com
 ([fe80::ba44:51c5:b641:2917%6]) with mapi id 15.20.9769.015; Thu, 9 Apr 2026
 13:54:28 +0000
Message-ID: <896b0ca7-f2c4-4f21-b658-7be0c77393a7@nvidia.com>
Date: Thu, 9 Apr 2026 16:54:22 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] net/mlx5: Fix OOB access and stack information leak in
 PTP event handling
To: Prathamesh Deshpande <prathameshdeshpande7@gmail.com>
Cc: leon@kernel.org, linux-kernel@vger.kernel.org,
 linux-rdma@vger.kernel.org, mbloch@nvidia.com, netdev@vger.kernel.org,
 richardcochran@gmail.com, saeedm@nvidia.com, tariqt@nvidia.com
References: <20260331153152.16766-1-prathameshdeshpande7@gmail.com>
 <20260402003047.24684-1-prathameshdeshpande7@gmail.com>
Content-Language: en-US
From: Carolina Jubran <cjubran@nvidia.com>
In-Reply-To: <20260402003047.24684-1-prathameshdeshpande7@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: TL0P290CA0013.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:5::20) To DM4PR12MB9734.namprd12.prod.outlook.com
 (2603:10b6:8:225::23)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB9734:EE_|MW4PR12MB7467:EE_
X-MS-Office365-Filtering-Correlation-Id: 0414302e-0cce-451f-801e-08de963f8423
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	q32MYER6WyzYgm8UJ290IoOdqc4t8aRKv7l/lh4ZIiwlneYs/OBsf0M3rfTRXxwuptlm9tq/7g82dwFLMrvIZZx+mzrEMyYe3ak46gdg0GalFNS13FCPC93JbaY8J+CXNh4V/K/7G3lKKZTV7ewqNRD1eiLWEfPQOEU2hdIYjQQNrqS2b/NtsyZl8GxMT8Qj3DFvtj/jJksp1ZjruLgNuOlwM2N+dhc8cLHW5duygwc8Q9lG6sViJJFkYGwOE7GZqsJoy8wlwESTimqj3tV0dUyUGVuO0xRnf5bOabCFOGF0PJDtCF1/p7aPDQI9O478XFq+q34QO0ZK9UiJQoMh+ce3d/GGPCXdrbd3ZHRm6w0486Q5OalZMWtrnys3w4LXVbdA3sil5xhWWN2qIOZ7VYp58eNigiHIGqjyYBngFBbPBTPVO/U7iR4DlTer+pCRFB57N35Ru0rmBTOvrb3nz0sc572u6MAOukvPn0+4urtQF4NWL20OExGnSu/tvusapdd/C07pwhQ9JQ0eaQLQ6Etc4JUKdeptI5/bTX8suHo0u6lMkTsfR87g+uhaRupc5jdi7VNIaju+VKKFaqsCcjU5tdnBCMlLpdSO+SeqTwy/U7Vqv+IHmZuHc4TlqNDw5Fyr1cGF9m3NFvIj5tEQVvELWkAK1nypEi6DNUuiTYUJyv0ngciZb91ExB+6yQBjzpP4v7MLtUBuXGcNst6OyANB8LmGEu7lrtkedl+mnkU=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB9734.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RW9GSHpQRXA4ZDY0V0N5MkdzOFFyUDdYUzcxTnAvdzdRcng1RWpHWEJHTGhZ?=
 =?utf-8?B?b0huRmJVVzAzeThyZ1dnWkd3bStnYTdUNUttbXFOUjc1a0IveTRPQ000TE9K?=
 =?utf-8?B?ZGdjbGh1Rk5HTGRLblk3RUt2ZHNkcytpbkMrOEdnK2NnOGZYbXJOeXZFWEtY?=
 =?utf-8?B?WU5JczY3UjRoYmFwZ2JzZHROeXFXUW03Nkg3TkV1bFA2ZDlHdVY0WUt1S2Jz?=
 =?utf-8?B?ZG5VUlZHYksrVWsycll5RGhPazM2ai9OL1NoSjZER0piQTBOaEw0TTlXOUNL?=
 =?utf-8?B?QlB3eHdraUNFdUxNTk1oZHhEa2hFcDZVRkNVd1R5dUtTNmI5RnZ0SEFpZVNr?=
 =?utf-8?B?KzNIRjR0N2hMSkt5d2RvR0E0VGJteTQ0L3lwaHRQQm8rRTRESEZwL1NJSGEx?=
 =?utf-8?B?S25uWGhiWkNhZmhwNSttV3JnaTFwS2tJeGZhZVUybDU5NkVtdXE3SGhRS0Vu?=
 =?utf-8?B?T1d4YVR1cWZqVE9vMnRja1BINE5TU01iK0hyUUJwNWprMHhwZCtsQlZFTTBl?=
 =?utf-8?B?SkdmL1o3UTFob1dPc1lZMk9hOUJyZ0h2aEZLd1ZsVEQ2WjJ2dXh2dXNVdDBR?=
 =?utf-8?B?TjdNQXNUZkdEdEJ0aGE5ZnJaSHordlI4N3c4OUFpbVdwa1o0YUV5T1Exa0p3?=
 =?utf-8?B?M3hzQiszRFY1MlFVTHJUTjVmem9YUVU4OGpuTWlOZXU5R3NIOXo4UklkTG5D?=
 =?utf-8?B?amRYZFBnRzBwRVVvZ0liektwMG0zMDdLU2dLeTl5dW04N3o1SXloME02WWxp?=
 =?utf-8?B?a0dPazJyTHcvYjRzck85NmFLMFVDdk9KK3RqL1VOWnNPOGNod0tFem5SQVh4?=
 =?utf-8?B?VTg1UmMrcUg2WHVSbEwwNmVHejB0QkpTc05OeHloSjg3OGp6d2NyNWJqZnJw?=
 =?utf-8?B?T0pPUyt2Wk1wOFk5S0hTYU5SMEhMTWMzcGduUWxTRjlvMGdqRVdYYUNHMzAw?=
 =?utf-8?B?VVNnTVUyNWJiWk4ycjB3bmxFZXZkRHVNVnpWNmg0VjBVdXdxeU5aV3YyZERx?=
 =?utf-8?B?b2NJTUtNSmRBRXFIdFFmbzZ3dWxFK1BYeGgrNDVpZFRUTkYvenhwZHp5cDdt?=
 =?utf-8?B?OUNidno4c1lXSVpzSTV3bWttakdvSGRCUEViYXg1d3VhSlBPSlZWT2ovYjNt?=
 =?utf-8?B?aHErbERTdmo5cUVtc0hGUGs3a2hUSzFLUFpiemM3T2F3dGFpN0xJVkZPQUp4?=
 =?utf-8?B?ZVBOTldlUkZxNkZYb0FhMkpMb0ZLWkxnRGdtdXRZT1B4S2JZVGJBMnFPUHlH?=
 =?utf-8?B?aUQ4WkdSTk1ZWEVxWHRieHhUUDRWMFg3Tlo5R1QxWklzYzd4TUVDblpJTE9t?=
 =?utf-8?B?VVlaQjV1UWpQNURZczY4TUNpVno3cndzRU1NSUYwY1FUcy9EOVhIa25OWGNM?=
 =?utf-8?B?dGVxUW5wdEtHYTA1TUNKU0U1dDhtRWp0emZHY2dLSVdmTm9MY3JKYmFjQzVM?=
 =?utf-8?B?Tk9kdjlJRWtXZllGVVFpRWRsSTBHSG9LTThjMUk5U2xOc0ZLRHB6QUg5UTFY?=
 =?utf-8?B?bU51ZWpCUUVvckZvUHBFV2FBK2VrTWFwOEwxUlVBelRYdFlxL3hUcHVQRUlq?=
 =?utf-8?B?RTZVeUIxT2V0WlNHSUVlWUtVaWV1K01BQVJudDV5SG9DRnZ2aFFxVW1VdkQz?=
 =?utf-8?B?NG10VWdwN2VQK2FHQ2JPSnJvZWZBaXdnRFpHeXVxWjZQMWFBNCtQbmFwQnUv?=
 =?utf-8?B?bFJ1YzdMSXV0TVVBOTV4WTZWYWFmY3RJQmpGS1liYUxVSzRHelhGenJHN2RK?=
 =?utf-8?B?YkIrU3ZIYjFZVVBnVjVVYmdMOE5RbzVlODZOMlQzaTdvbG1UamZ0UXltZUtH?=
 =?utf-8?B?ZDYrbGZZRFIzaFcxQUVibytVV2d6akhoQ1o2NlpIYjI5Z2tVMWtqcUtXVlJC?=
 =?utf-8?B?VG12ekhOSzNUMTgrOHE1cDR3NnRJUnBDTUdJZzBSZDNHbDlrZ2wxSHlEcWRo?=
 =?utf-8?B?VTZUOGlPMjM3RzlDNDBtdkRmK0E5alNNUEV1UWNldGNDRFhHaGVkdEVxK1lV?=
 =?utf-8?B?dy9EMUxObVhGeUIyZjdsRmNGMHZpYXRVUk0zMCtyeVJxWWRJUzdIMnNKYUlJ?=
 =?utf-8?B?RnhqVldCL2dZTHp2czhpZ0RTL2xST3ZySTUzb0J3VHJicDZpenljelRrdTFR?=
 =?utf-8?B?bk9DK1pock01MWZIMkQybFpIYlppMkFjSlNTY2J2Wi80dkJWTTJBVStzdllF?=
 =?utf-8?B?dWt3VHVMZHJ6ZFNLb1d0VG01bEE3RkVJWFh2eWxsVElZdjc3Ukw3Zm0vcHg2?=
 =?utf-8?B?SzdTNHdETnFjM3NrZWhhNzJNZVVtclNSMWxNNnRlajlrdlMranpNNlBpZ3Ex?=
 =?utf-8?B?dGhQeHBBY0lCS3JyOXZtMTRqUmRhZ21kRERFYmJCUFVIWDh3bVJ4dz09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0414302e-0cce-451f-801e-08de963f8423
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB9734.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2026 13:54:27.8706
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IhRJ2meYwcZja0Mpqvj6ounTynhDq6s2YeWBi46+b4QSgJ35A4pidirM0x++FBU5yz5Mu+7V09TSmNoqm3/nhQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7467
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,vger.kernel.org,nvidia.com,gmail.com];
	TAGGED_FROM(0.00)[bounces-19165-lists,linux-rdma=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cjubran@nvidia.com,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,Nvidia.com:dkim]
X-Rspamd-Queue-Id: 94E923CBAF1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Prathamesh, thanks for the pacth!

On 02/04/2026 3:30, Prathamesh Deshpande wrote:
> In mlx5_pps_event(), several critical issues were identified during
> review by Sashiko:
>
> 1. The 'pin' index from the hardware event was used without bounds
>     checking to index 'pin_config' and 'pps_info->start', leading to
>     potential out-of-bounds memory access.
> 2. 'ptp_event' was not zero-initialized. Since it contains a union,
>     assigning a timestamp partially leaves the 'ts_raw' field with
>     uninitialized stack memory, which can leak kernel data or
>     corrupt time sync logic in hardpps().
> 3. A NULL 'pin_config' could be dereferenced if initialization failed.
> 4. 'clock->ptp' could be NULL if ptp_clock_register() failed.
>
> Fix these by zero-initializing the event struct, adding a bounds
> check against MAX_PIN_NUM, and adding appropriate NULL guards.
>
> Fixes: 7c39afb394c7 ("net/mlx5: PTP code migration to driver core section")
>
> Signed-off-by: Prathamesh Deshpande <prathameshdeshpande7@gmail.com>
> ---
> v2:
> - Zero-initialize ptp_event to prevent stack information leak [Sashiko].
> - Add bounds check for hardware pin index to prevent OOB access [Sashiko].
> - Add NULL guard for pin_config to handle initialization failures [Sashiko].
> - Add NULL check for clock->ptp as originally intended.
>
>   drivers/net/ethernet/mellanox/mlx5/core/lib/clock.c | 12 +++++++++---
>   1 file changed, 9 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/lib/clock.c b/drivers/net/ethernet/mellanox/mlx5/core/lib/clock.c
> index bd4e042077af..a4d8c5c39abc 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/lib/clock.c
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/lib/clock.c
> @@ -1164,12 +1164,18 @@ static int mlx5_pps_event(struct notifier_block *nb,
>   							       pps_nb);
>   	struct mlx5_core_dev *mdev = clock_state->mdev;
>   	struct mlx5_clock *clock = mdev->clock;
> -	struct ptp_clock_event ptp_event;
> +	struct ptp_clock_event ptp_event = {};
>   	struct mlx5_eqe *eqe = data;
>   	int pin = eqe->data.pps.pin;
>   	unsigned long flags;
>   	u64 ns;
>   
> +	if (!clock->ptp_info.pin_config)
> +		return NOTIFY_OK;
> +
> +	if (pin < 0 || pin >= MAX_PIN_NUM)
> +		return NOTIFY_OK;

pin is defined as u8 in struct mlx5_eqe_pps, so pin < 0 is dead code.

As for the upper bound: in order to receive a PPS event on a pin, the 
user must first configure it via mlx5_ptp_enable, which already 
validates the index (rq->extts.index >= clock->ptp_info.n_pins returns 
-EINVAL) and since the mtpps register only defines capabilities for 8 
pins, so n_pins cannot exceed MAX_PIN_NUM.

Maybe wrap it with WARN_ON_ONCE instead of silently returning, so if 
future hardware adds support for more pins we would notice rather than 
silently dropping events.


> +
>   	switch (clock->ptp_info.pin_config[pin].func) {
>   	case PTP_PF_EXTTS:
>   		ptp_event.index = pin;
> @@ -1185,8 +1191,8 @@ static int mlx5_pps_event(struct notifier_block *nb,
>   		} else {
>   			ptp_event.type = PTP_CLOCK_EXTTS;
>   		}
> -		/* TODOL clock->ptp can be NULL if ptp_clock_register fails */
> -		ptp_clock_event(clock->ptp, &ptp_event);
> +		if (clock->ptp)
> +			ptp_clock_event(clock->ptp, &ptp_event);
>   		break;
>   	case PTP_PF_PEROUT:
>   		if (clock->shared) {

