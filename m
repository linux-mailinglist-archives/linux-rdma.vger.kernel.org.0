Return-Path: <linux-rdma+bounces-21017-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KBaeKDFCDWoAvQUAu9opvQ
	(envelope-from <linux-rdma+bounces-21017-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 20 May 2026 07:10:09 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id CCEFB587B56
	for <lists+linux-rdma@lfdr.de>; Wed, 20 May 2026 07:10:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id A18A93029CF6
	for <lists+linux-rdma@lfdr.de>; Wed, 20 May 2026 05:09:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D39E366060;
	Wed, 20 May 2026 05:09:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="R86aGwY7"
X-Original-To: linux-rdma@vger.kernel.org
Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013006.outbound.protection.outlook.com [40.93.196.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B57582749CF;
	Wed, 20 May 2026 05:09:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.6
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779253794; cv=fail; b=piiCc7iyCEpP7DbaVxHyu2jsWdmN8l+kMZ9Hx8j47cIubCjQmXhBNSoaIu1T5ZuXcQneozml93ZxWcnB7C5al5ayyYVrCHhmA18ybOd9elLMvZ2VWewrJfMEsrJ9ermlUFhPp4ovDAg2H0dsH5hpSwjh6A9f5qRjQhIDgOunZVo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779253794; c=relaxed/simple;
	bh=41FsAIXfMcc42tv/hoE3uPpCcmTOp6JGerGZzuzs8hM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=QdgQV91jfb3GC4QhRjYw3c4aOxVqZU3k+Js43BtLioLerqv0uBgBKbdASBaBPF6QBbIEMzNcPTMhogmvno1MtMsd3blz5HfoMRjSLJ16sRZfTxSCzDGfNvxWXRciOUPjd/E13AuZHcP2rcgoQ/3x0lU0qgsCrTDIZFhIpA//4oo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=R86aGwY7; arc=fail smtp.client-ip=40.93.196.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hTXEbLl2bWW3kLoPOGFk6jWf1vHnHvxnDB9+HT4w9BUFy7Xj9qtzR3uRic6doYM4MVWDYWGiW77/YF8c8O9/xE0fk9wy+bWjdLO3rPqfxLlGcxNhvVtsS0upshbVmLluPpqud0tSl/lx1S70d6LZv1z/U9Ljr96nCYGgonCwB+MsClenl4PyoVjPt9RTmc7ZjUY9BknTEns3E8uHu3sc9kU98FzZbEaXrCQPlNUtB4T/S/pTpBL8srH/9JK93WAuq/1n1WdcHXLlVm/nquis38OiQ67Lt7QoRg6u0cmxlS64XQ4n0B72D64Vq92WIxF/2AdLmmd+sp+Yzb8V2hJOtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KjJcjD7YMAAwNOGw9RWBlKMu7JDxEQt6Gdn1wwPqTyU=;
 b=Tthsq10sn1LZ7ohv0WiwFkpeVlfw+HwRkZjlSpzyeY1JH40j2hFYoFCoNpp2S2DM6Tya0Y1GmO4SsUyCm1IaQb32iDi/QpfxyDgWAM3Mt8ep7qCjAAnA/0+wpNysBSzouL+8A+DaC/xoEKiWLBJ+Qz1JmSC5gcNVssdOuOjPYy5SHZiWdS/gD5O2RnQZu9IfNYg9frnHF4ZGfaIA0As8sM+QnSntirfiHV+WI6gkeXHpQaP0XMChf6XnkMPNP3iWwQpTka8OcMlQ+tQiB4L6Uw/Mcm6I1P9G0t3G5X2mzcSGyN+KQnhnfISnXUplrj6VX2MmBLalqJum+5ocS06t0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KjJcjD7YMAAwNOGw9RWBlKMu7JDxEQt6Gdn1wwPqTyU=;
 b=R86aGwY7MMlHMIez2v98PLVA8fgRhMPqp5ky7qvOWOiJdDkzOCvdaG3p5Il+7CI1/U9Veq9hTfKswuthSssUrxJY7smf4pWS8G5YuOinKPFdzD++Ns10DYPEeA6ghnf0lMMrszEu6tSycbF2H9C/iIRCTRpOJCNN5HTXSlr3TlFC+z/kCIIWR6S3fhor+uPeDEToMAieQlDvTE4a6BUC6l7Kh/7YvbKvTMnjlIDTRU7kS4vRW7BzAyMPNmega9xbj6QO02MpbPst8oR3TZBILoivfTxmDR5RFJtBHk1R4stKZidzyzBj/cEWrdhefjro7GWcSDiP7uSUa7KHPTlo5A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB6583.namprd12.prod.outlook.com (2603:10b6:8:d1::12) by
 CY5PR12MB6477.namprd12.prod.outlook.com (2603:10b6:930:36::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.48.14; Wed, 20 May 2026 05:09:45 +0000
Received: from DS0PR12MB6583.namprd12.prod.outlook.com
 ([fe80::16e2:19ba:8915:90be]) by DS0PR12MB6583.namprd12.prod.outlook.com
 ([fe80::16e2:19ba:8915:90be%5]) with mapi id 15.21.0025.022; Wed, 20 May 2026
 05:09:45 +0000
Message-ID: <b6f30b9f-f3ee-4bad-b983-73b7415aad78@nvidia.com>
Date: Wed, 20 May 2026 08:09:38 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v1] net/mlx5e: Fix eswitch mode block underflow on
 IPsec acquire SA
To: Prathamesh Deshpande <prathameshdeshpande7@gmail.com>,
 Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
 Tariq Toukan <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>
Cc: Carolina Jubran <cjubran@nvidia.com>, Boris Pismenny <borisp@nvidia.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, netdev@vger.kernel.org,
 linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260510225903.13184-1-prathameshdeshpande7@gmail.com>
Content-Language: en-US
From: Tariq Toukan <tariqt@nvidia.com>
In-Reply-To: <20260510225903.13184-1-prathameshdeshpande7@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FRYP281CA0011.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10::21)
 To DS0PR12MB6583.namprd12.prod.outlook.com (2603:10b6:8:d1::12)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6583:EE_|CY5PR12MB6477:EE_
X-MS-Office365-Filtering-Correlation-Id: 00860de8-fe09-4b46-9f32-08deb62e016c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|1800799024|22082099003|18002099003|56012099003|11063799006;
X-Microsoft-Antispam-Message-Info:
	SeNkrW0t/xDPodu9WuxZlQtyIV7sPNHHg9ys87WwXCnmYbGCybcmonfOu1depFvGcCGzHcHHmKM4rPWAJBHxWENlAu+r9dg5av9F8UBN7oBMd7nNMQIRfxLFRj53PDsGdvpbo5JIEY8y7hgB4RcTxnpsp4q1+mUeL5a5RX/xyHyF8q77H+5WeC6BVDbhgHko8UdYxj0xK2s632RZ3HhjTBIx1HMSEySULjsjREEHgvcJ0EYNQTWN0QzylgOyMRUpdV4sdrycfI3yqtuQkgsW610f63+ohW73rGqsvpr91Jb0eGFjj7PjNP6sNHlSUrxZvWC+9QsRobi4PkathFnP2BrLIhwV5HS4EVoVcYjUeYcPKCeZbGdqPMrHDWzLq2BHbuUFBEISBkG7c4E3aRub0hZa20+JVrjrMIu2PGc9qC5X1g3ae+bVsjTrSOdYCe6/lFivwEUfBVBYiQvZGbjuHKtAbU4+SZRWSs8pm24aazjWgzP65PHFho0KVpbJ3obUW0s2aNhEkQXqkpjGfgZxo7+FlGB1H9nML3ZgYdM+ySVaitwPSSuBL43/SqromDrnhzzFyUHDI3L+NPz49Gc+3Uri+PICZ8o3z29V9o8wb3RJlSx6h+FDXL93d9Sm5Axourwaf+KZ9KAoxXoKnVSUMmmgXXbA6Fc0UVPYqB6SJ3QgbErueix/R4aA3+gOvMrj
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6583.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(22082099003)(18002099003)(56012099003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?L20vdUUvOGFuNDExTzBCRGM4Z0NLMlNTd1FpaHZjTUFIa1dIcmQwcUJEOGNw?=
 =?utf-8?B?VkpLRWdmd0VOazIzOUJwQ3d1ZTFmZDBOZmNQWGwzajNzN3cxc3N3MG9udlFz?=
 =?utf-8?B?c0VZM25BUXVMREJmUHNyQ01va0dpakJZZFdrMy8vNExnZ1p4U2ExVHNQN29L?=
 =?utf-8?B?MzhxSk85MHJaVlJzRkFhWFlKWmVYU1ZPNEhiTVArVTNiRHkzSWdKT2tWYjd3?=
 =?utf-8?B?T2YzNS85YU9Qekd0VGZtQ1F3R092bzQ1d2NUaVphRlpHWFN3R2R3S2VsUi9o?=
 =?utf-8?B?TThBNzNyWnpTQTNEczBid2MyV3VTVGZSdGtFTjlWMUcwVTNLNkU1V2lsRGZq?=
 =?utf-8?B?ZmlHMlhIT1MwVWxwYkg5M0tGV3NDbXNVdmJHS0pteERDaEo5Tk9ZdjBGcjRV?=
 =?utf-8?B?OUhEYlNHalNCUFQyNWZ1TW1Ea0JpV0xBMWtOQXU4ZmIrWVgwUnhLOFpEUDVw?=
 =?utf-8?B?eVR3S012M3N1dk1KTjhUVkNwdngxWVYvbHVmK3MxT2JQbE4wNjVnM3R6NWU3?=
 =?utf-8?B?c3JJL1hjbUErVFNWMGRHYnhyNU1kQWlxc244U2tSSFN3ZXd4dTFnNzV5ZFFa?=
 =?utf-8?B?V3piZlptSFV3ZUZ4V2tMMU1sV3dJa1hrWVpCNFI0ZkpmWXptcElqbnJRZzho?=
 =?utf-8?B?N0I2MUxrb002RSsvaTQ5WUIyKzM3K1V1VHd4WTJmWk9ReGdiWUFWWkJzK3lM?=
 =?utf-8?B?cmE4K1BvL0lhWDdxN3VHd0lyc20waE9NQ0FQUUhXUzdZb2Y1aVRvb1VrZzFN?=
 =?utf-8?B?LzlHT3JxNzlOWkh5VVlBSHRGSVhGYmtJNWJUWnVSQXNLcXdVajAxZXU3aE1Q?=
 =?utf-8?B?UDFtaW9DbU41d0JRS1pQak1DeHZuRFh1bXdqSXNIUUtuZDBpT1RmN3ZFaElq?=
 =?utf-8?B?alNtWjJ3Q0NtS2VoNk1vUlJHcnQrOURDNGlpKytLeW1ZTUNKV3JhR3FDWFFF?=
 =?utf-8?B?WlFTRTVVeHhER0QxcXJXWitEY1pINXp2elpiYXZvWUZDTWhRZWVla2lPcTJY?=
 =?utf-8?B?N0o5eWpFVVlHbGd6b0V5M2thSWcxblcza3dMRGRFUHRoWTMwcitBZlFJK1Fh?=
 =?utf-8?B?dXpzQndHbHUzam1paDhESGhpdnVKY1JQLzliVWwxZG9vSlp4R3VydDJIRFJ2?=
 =?utf-8?B?TzQ4eEdHMjN3ZlVwOTVFaWFwSTEzb3NjcjlQOUNST1BBL2dGRnVyTitJbEo0?=
 =?utf-8?B?eE1mK1Z2dDdRdU9FZVVhSGRqNDFHcENGem9pNDFzUWZKcFA4TWFJWVhIV1JT?=
 =?utf-8?B?VGgzNldBWHIyMEdnT1owZXlZemRqR0kzSGExNlBmU3FDNTlHWlZJNENUQ3hu?=
 =?utf-8?B?ZWxoTFJYQUhQNzBFTnlUMHNGU2N3dWhER09vNmNIeVgzdUl0eC9qOUdJK0kw?=
 =?utf-8?B?YlB2RktwaG8rZzJHWmlxT0lMM1JWbURlQllubDB6clVWV3JhUExxRjI5eFlL?=
 =?utf-8?B?TGxkRXJ6KzlVemxZRHI5c1R2M3hLbnIvcVgya0pjTExGbGZocm5LYnd0bFVw?=
 =?utf-8?B?UEJYYnVRam1RNWtHY2FpN2F3ODEreHNCSmRxS1h3VTlacHlqVlp2VUZVTHlS?=
 =?utf-8?B?YU84cEdxWmkrOXlkVEtKOTBDU3RmaTNDZmJkZVVBSVI2cXhOVVBpeEdTckxm?=
 =?utf-8?B?b2Z0UTJ2K29pYjREUUJVZ21nL1pyWGhwbjNzT2VqMnhrZkd1am1UZXJKSmlr?=
 =?utf-8?B?N0xyY21rNWJQTHdnTTJoWmlMaE9GTUFhakdTQyt0R0dsSE9xc0g4b2Rjd242?=
 =?utf-8?B?L0xkSmtOdlF3WTJPVllrSW1Zem5SVHlrOERiWVdWWmU5aThUZkpKM3NhcGpT?=
 =?utf-8?B?T2tISUJGS2Z6SnU3UWZTbmsyc2tvUnNaNVlLVEJuR1hPVHhFN0RXdXE1SnN2?=
 =?utf-8?B?MS9udlhrNmNITFgzRHhNcnpvMEp1aExzdWRRNEF4VEsyN04wcEpTOUVBdEV0?=
 =?utf-8?B?MW42NkhGWnJJUFNLVWZSKzlhMVpxZXNkRDYvYWZEM3I1eldlTTA0V0pUUUt5?=
 =?utf-8?B?ZitiTllFeHFhWFg1dWpqRDJaRE5Gbzd3ZENDVmwwVHFiM0s5QTR1VzIwMk9X?=
 =?utf-8?B?VVE2TGFtanlrZzhUVVYxZFFUdTRYTXl0VWZ3Z1VOL2UwZlc4blRtOW45ZlRD?=
 =?utf-8?B?QUlaWmVSOE9YUnN1TjRrUlJxY1hubjFaa3NmNFMvbVc4L1pZNTFVMGdCNVpj?=
 =?utf-8?B?U00vUXdoaGlhWmRGN1R2RDQvSm5RcFIyNzZyY0RpY2RaQlU2b0tmR3JHdGJD?=
 =?utf-8?B?WWJxbm0xaXJPZFhmL05lbXNKTER0aDlIeGw3RjVaTG1ZTjdES1pDMXhoNzhJ?=
 =?utf-8?Q?jcrMvKb1wpv6TMemaT?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 00860de8-fe09-4b46-9f32-08deb62e016c
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6583.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2026 05:09:44.8872
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yos9EN4LplZLU/3UAU2SBT8/cHk7DPw57gaCVjd3kYpEUqYcE3PszbeEd0Q7hhTcRxkizW94G7ipJL5tgIfgrQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6477
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21017-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,nvidia.com,kernel.org,davemloft.net,google.com,redhat.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tariqt@nvidia.com,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,nvidia.com:mid,nvidia.com:email,Nvidia.com:dkim]
X-Rspamd-Queue-Id: CCEFB587B56
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



On 11/05/2026 1:59, Prathamesh Deshpande wrote:
> mlx5e_xfrm_add_state() handles acquire-flow temporary SAs by allocating
> software state and skipping hardware offload setup.
> 
> That path jumps to the common success label before taking the eswitch mode
> block. After tunnel-mode validation was moved earlier, the common success
> label unconditionally calls mlx5_eswitch_unblock_mode(). For acquire SAs,
> this decrements esw->offloads.num_block_mode without a matching increment.
> 
> Return directly after installing the acquire SA offload handle, so only the
> paths that successfully called mlx5_eswitch_block_mode() call the matching
> unblock.
> 
> Fixes: 22239eb258bc ("net/mlx5e: Prevent tunnel reformat when tunnel mode not allowed")
> Signed-off-by: Prathamesh Deshpande <prathameshdeshpande7@gmail.com>
> ---
>   drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec.c | 7 ++++---
>   1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec.c b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec.c
> index a52e12c3c95a..db260e3d1412 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec.c
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec.c
> @@ -792,8 +792,10 @@ static int mlx5e_xfrm_add_state(struct net_device *dev,
>   	sa_entry->dev = dev;
>   	sa_entry->ipsec = ipsec;
>   	/* Check if this SA is originated from acquire flow temporary SA */
> -	if (x->xso.flags & XFRM_DEV_OFFLOAD_FLAG_ACQ)
> -		goto out;
> +	if (x->xso.flags & XFRM_DEV_OFFLOAD_FLAG_ACQ) {
> +		x->xso.offload_handle = (unsigned long)sa_entry;
> +		return 0;
> +	}
>   
>   	err = mlx5e_xfrm_validate_state(priv->mdev, x, extack);
>   	if (err)
> @@ -870,7 +872,6 @@ static int mlx5e_xfrm_add_state(struct net_device *dev,
>   		xa_unlock_bh(&ipsec->sadb);
>   	}
>   
> -out:
>   	x->xso.offload_handle = (unsigned long)sa_entry;
>   	if (allow_tunnel_mode)
>   		mlx5_eswitch_unblock_encap(priv->mdev);

Reviewed-by: Tariq Toukan <tariqt@nvidia.com>


