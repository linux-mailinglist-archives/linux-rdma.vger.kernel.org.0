Return-Path: <linux-rdma+bounces-19167-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OOY3Mb+y12kORggAu9opvQ
	(envelope-from <linux-rdma+bounces-19167-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 09 Apr 2026 16:07:59 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 425223CBC44
	for <lists+linux-rdma@lfdr.de>; Thu, 09 Apr 2026 16:07:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id EDCCD30021EE
	for <lists+linux-rdma@lfdr.de>; Thu,  9 Apr 2026 14:07:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5F7E2BEC43;
	Thu,  9 Apr 2026 14:07:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="XBOcwyTB"
X-Original-To: linux-rdma@vger.kernel.org
Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011009.outbound.protection.outlook.com [52.101.52.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 788AE17BCA;
	Thu,  9 Apr 2026 14:07:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775743676; cv=fail; b=PMmyv42jjrOXzjeN5YwLh7HH4o4mU5awnxf/7efkqlgzjkACfHpoO7bK9cksvwzGFgNJHGD+vptpvl34pMwkdF0eAcoFuuol8bof7E57VF6XGlroMnCjz5qm9bvZEIBaIWiDunRO6JloBTBVE1XufXazkemp7jpk2QI+H3W0whk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775743676; c=relaxed/simple;
	bh=uxEUi7XluyyALWBIk3pzjuPKJJtF8c7sHaxxjivBT1A=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=jEYQKmwd/PhoVPLyWyGOwQqSohjaG+Um+YE7U8lAETjnseJChH1VjpnqzZN6KMJ1dDUrsg9WPqjIClvi/3U7yx1ckWrNMiF2vrpFVmC7RaoJPRCob7vldTLFAOcC+DgUyoqBQx4+CFmEksNg88S+hHHlyAvN6hXKKj+W1LH1RMY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=XBOcwyTB; arc=fail smtp.client-ip=52.101.52.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zQVf2IwSm3vm7o8eaigDyXGWs+eeaftN0DwmNF9lx5fXlUppEDKlKg8jpaPM6yKXPlkEAnmB3zgyZchukIJwd53EL5kVmf3B0iGL2+hBGS3+p7LreB0gNkrsDb2c2kETSqPoa8ZY13HPyVvSMYvOtlkeCT9V3Isp38M/AG7/aQjgCbV4qcAZ7fTlzKJi/eNIgaDhQ5xhkNTHm7lBW7FvlF1Q9xyl1X1fd/irnwZfrAiDa5i+5xa83xk+VsApgLKV3DtpbD5XhGcGAz5dk8AGTuROd/QFkBLhW7orG7BdEHrRh5sLGrgyCmMJFfkQyEJV2LhRPMmNizxnIKUYJPklyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Gkoolfz7Au4lGaczf7iSRmIuO1hNGejOCru8KAOq2rc=;
 b=LMCwMYDjU5bmBKJB+f5BIuDHChKsHjFWTaNRi4OLonoB+eH7fghIHoYUo2s3Zkfs4rtWmS4E8eFcNvDj9CDjNGOeWU5ADz2zAKlCxWxsiSSNlIQvR1x6XRw0lVnMZz2Q4XBBdiueDUZn+Uq+EeyIstdpZKtTtR7u80ANdsbb/Cx7LsBtn5Xhqgmp+lB/b27sWq6le4TYNTeBuhLq5KhAGk4Rq9j647YxzqIMgzVLFHKOBMzXtPlwVaylYQiOl8H04FLX35LqRmdPomgzddBl5JJeMBpwsM/CNzSTyQ6NEwVmHJbccN8G2gm/BxLTy+EYLEJmpH+AnS38WIncwAwuqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Gkoolfz7Au4lGaczf7iSRmIuO1hNGejOCru8KAOq2rc=;
 b=XBOcwyTBC4xZMRell85F5DMlyZVARplb2DmnTyVE19x9Bd+F8Ryd1nyKh7ReEETPlKrJUYLXX75kZ1TIIncgG7OWL0M5obk8YZgXPMY2M3qV2zeJuUL+6Rk6wzgbs+IYWRkxsXpVnelkhES0TO3tpSxVNI1JeB4ceulgxa5nM4/gtkXMibrY2UspKz2mIdHzxUG3QUCZbv4fRgzpd9vbVxDPPEIeTqmHSeMPCeSySSxKnfSowe9Gvr8hLJWArGwjTCRet2CJby6C+CjlYGQ28avSrPxEjTIzmf+O4tDH3517BT2NEFpDv6hSOo3wjtE0JJ1DrvaJNFbKZSbIUegC7w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM4PR12MB9734.namprd12.prod.outlook.com (2603:10b6:8:225::23)
 by MN2PR12MB4455.namprd12.prod.outlook.com (2603:10b6:208:265::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9791.32; Thu, 9 Apr
 2026 14:07:50 +0000
Received: from DM4PR12MB9734.namprd12.prod.outlook.com
 ([fe80::ba44:51c5:b641:2917]) by DM4PR12MB9734.namprd12.prod.outlook.com
 ([fe80::ba44:51c5:b641:2917%6]) with mapi id 15.20.9769.015; Thu, 9 Apr 2026
 14:07:50 +0000
Message-ID: <edf3fd0d-f60a-43dc-9b51-529f82f75335@nvidia.com>
Date: Thu, 9 Apr 2026 17:07:46 +0300
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
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TL0P290CA0015.ISRP290.PROD.OUTLOOK.COM (2603:1096:950:5::7)
 To DM4PR12MB9734.namprd12.prod.outlook.com (2603:10b6:8:225::23)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB9734:EE_|MN2PR12MB4455:EE_
X-MS-Office365-Filtering-Correlation-Id: 22eec20c-041d-475a-8acc-08de96416295
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|1800799024|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	K2lpsBfWbIMaf0r6mFriZPnsnyT4PeDXZwrwcVuzJvViua6XGWEByrUcnnneAoNHNBXrvVL7I4hvhpztGStIy4xU5quXM8HkI/EiSKOWOix4aZJYYT3GWC0RDaaGK6MYgaNEkXyh4rpUZkG7Kio+NTDqZiw62LUPyKLs3L3giS+C9zWQPUxyxXjj+KMEeU6VncDRyysllfqVgALqYlCo0vg4rxTZz2Ym9YIEU0d0edq2sC3BEVWakrhyD8ZtLyVe1yHEdqLuRIF7BLkYM8X8DQ1m17O+dpUDlS5GsCIpFGuekMtkWD/F4x6snBW5icPrFptXFNyFw6QH+DSkezOAi4x1eelYjdwSDDwJBJrpnfcofdCoGVNCjLvYu/Aop0scLJJfqr1N79cllogodJ/xpCLg67qTw5qvcPQvRipUnRKIoXXXTaKYsh0/+BC20DQvehhFGGojVtwlr8TY5dUNrJQI7xJ6H2yGcLw8rFY7vW7twFx9ydhTgVNMb1+yiHxHFjsLy0QdW8O/1vKfljHYfttNEu0w/zIt4ISl/i5NtcFGQev3htM38tQ9uieUwEFxWL6O6aQlJ60aL16qEK1rKjeGKtb4PHqAiAWC+HIiKvID/f9JwK5C6kykSQnTVQxNNCj8+2oKTtWgpIwLgj6f8UbEK/4Wn5CAFuFyjuBD0qIbHZWQEIMRWr4A8DCXl9I9MWsg2m/12PuUPsYhKL9SaS5ObonbolRIGE7abS6Jgkc=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB9734.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SGsyWktDT1hleHh2TXRQRmRieEk3SDFuYWM3cVcraDQzWUhyRHpvQ3NaaGN0?=
 =?utf-8?B?ZTFlcTY0T2RaR0lvUk9GVWJZZEtKajcvMFROcUJBKzdDN3V2ckVHOFZScHk0?=
 =?utf-8?B?UVhuV2I0ei9JcnJLV2V2Z0JXT2FsbnJjcTR5REZhejZXSmRwdVBQRGdhYnFi?=
 =?utf-8?B?VU8zZ3B4WXAyS2F5QWFXWE8xbDhhSEp1TUVIeVIrNzlSTXRNR3JhWjRlbnJR?=
 =?utf-8?B?NFBaK3A1NERsRFRvdUozK2hEMzdtbjBYekpYRzY3bkUxc1RVdUhBZ0crSnNK?=
 =?utf-8?B?SzJCakxEY25lVmo1dlV5ZnpEWFRxYlB3dG5lWFk0anJiSmwrallRQnBtdWNw?=
 =?utf-8?B?ZGxLNk9zUDU0STJqZnk2K25Rc3ZwSGh0MkdpSEh1ZWd6UDZNMjdKSExVc0ts?=
 =?utf-8?B?cEVxcEI1aGpwd1J6MXpVeVM3bTV4ZThlTkZVdUwrcTlDQ1BDZ0V5SnRJVHds?=
 =?utf-8?B?czZNaWVlZmlQTmI2ZDR2MHZxRzQ3cCtGWEtiY3plZGg3eXBIU0JBZ3NJTU1U?=
 =?utf-8?B?SGk4VHVUUnJLUXhUQ3lZQ2hVNVpiTzRjN09KdDdoR04xb2FIdTBUM0t1R3NW?=
 =?utf-8?B?dE1EcFkrREorY1IzWTBxUCttczM0RFBlVzk0NHpyRGhGa2VlWUtxWFdEM0dm?=
 =?utf-8?B?TUdvVUt2RFBrM09LK1liWVJmcEpkZmh5bmlBZzFrZnFubEU3Wnk0L0JNa28w?=
 =?utf-8?B?MklwRUdzbUh2cFNxc0JFVVRyakxGeXAzVklaZUEyV0M2SkxqU0xvNHNvaWtm?=
 =?utf-8?B?bUE5Slp4N0x6YlRjZVdXZzh1UGdhaUZ4cWMwTG5JQ29zQUo3Z3M3c3Vqek5h?=
 =?utf-8?B?dHNFcUU4dzAwVHVhNnBBeXNIb21hcitFc29JTG1LeFhhUUhwNnFhVEd4SVhE?=
 =?utf-8?B?NllramQwUHBVN1F6eFZFSG1pVFQwaWRiQkQyeW9BeXlNbGFnT1BZYmxwQit5?=
 =?utf-8?B?SmkwajhpLzhzMW8zSG9DSEtZOVl2SWdLRUlGc2MrNzA4TFpCdGF0aTZ3UFlL?=
 =?utf-8?B?ZGtmSDUvVzBKRGZaQXB4U2RQNmJSVDRPNjh5NlJEMTBFUmlJM1E5dk5VQWN3?=
 =?utf-8?B?RUo0dU4yV3hiMnFVVW52Qzl5Y0JTbVQ0UHV4bFYvbXZTTzhPN3d1VWlyc00y?=
 =?utf-8?B?a1Z2QVZJZVBoWm1Pb2JWcEhucHlZYTdUS1J5TnVoSXJWeVRSSWJaWUMxRjZx?=
 =?utf-8?B?Z0JGc3BZRnNRQ3hOTGVWaDdvTXVkWUR0SGdkTGVoOXhZdEFTV1VGaHVZM2FH?=
 =?utf-8?B?blhCVkd3WTFuaXZLMzBNYnRGZUs0ci9nY1ZoMitQcXZYaEhvcEVrWXR2V0s5?=
 =?utf-8?B?UXpkbzZubGpJcXV5VVgvQXY0bS9VRkFyRnB2ZXhhNnRNOExuNGVMdXVZSFJv?=
 =?utf-8?B?d1Q3Y2dmYVN0aTM3bTEzVFRHSXZGdGN0bHpUdmU3RkUxTDJzWldpeTVxTWti?=
 =?utf-8?B?ZnlnN2NHSEU1eFFUMkdNcVRIZXNqZ0VtZTdoQ2VqM3REZVJzaXMyeUhZeFB1?=
 =?utf-8?B?dXZVOWw1bHpjQ1o2ZWNRM05mbUo0Snh6bmYxc1V2bU9pNVgrZWxCQVZCZjVr?=
 =?utf-8?B?QkJLbm8xVHhFcmp1czlrZE5CTjJyWm9WRW5XQW0yRm0rQjcwYjJGSFV5VEVC?=
 =?utf-8?B?Nk1nbWl4dFFMZWZSNU5GazRkUEFaVEVrWXIyL3JqR21hYUl5THM2V2JSRmZu?=
 =?utf-8?B?YklOMVlvV2JtYWdUUG4zZkdVaVd2SWpJdFJVMUNrblNaSytEWHRkMlRnQ1FW?=
 =?utf-8?B?Wkh3UWRLYXpmSjNiRGtEQllqZFdYc0ZQbWJZZ3RsRktMb1lHdGNvVFhnR2VP?=
 =?utf-8?B?aWpPVzNiWnV5TUJsS0tjZE9ibUo3Z1A2bUJPRW9Fb2FuOEwyMm9HWFExUGJv?=
 =?utf-8?B?NnpmS0VMTUtaUG5lYjcrVTdGdEIrK0tvcmFJM3V3S0VnQ0NtbndLK21SdUZU?=
 =?utf-8?B?TjExdVprTk1NcC9qZ1U2QzFqd1FZMm9oMndjMm94SEo3TGxOV1B5T2I4LzY2?=
 =?utf-8?B?eXpLcGo3VmhXKzQwcE9Od1E2UDVTK3YxQTc2bHorZXZ4ODNTOEl2b0dEMmhM?=
 =?utf-8?B?RkVGVWtCUnVUaWxsYmVuZ21KVyt0VWVTRXJJeVR3eUdTMFlJeHZTVDRoNlZa?=
 =?utf-8?B?QlZ0YlRJUWE4eDZLSFEyeUhJbE1kQVdOVUtobS9yeXRwWEg2d090YjJtTkk2?=
 =?utf-8?B?QkxGVDhHbFpvQjNyUjJQVE5ET3ZxYTNmVlduUURpbGRCQ0duTEdQdTQ2RkZD?=
 =?utf-8?B?UFh6L3VtbXJ4Sy9RTW54OVNwTnFmMC84ekxMR1Z2YmNhOHVEOHBNVFlITEdi?=
 =?utf-8?B?MzlReW15UDk1QzVEdGNGZytyVkZRakh5UU9tYjNvR0F0VkFENkZ6UT09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 22eec20c-041d-475a-8acc-08de96416295
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB9734.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2026 14:07:50.5605
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0GF1SFaDAOU+VfUG/J5+FnDstMKnBvG7f7KFz/1BBE327bolKbzUhLaNihMpdjOYl4fBpX6Gwobitly6wxnaJg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4455
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,vger.kernel.org,nvidia.com,gmail.com];
	TAGGED_FROM(0.00)[bounces-19167-lists,linux-rdma=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cjubran@nvidia.com,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,nvidia.com:mid,Nvidia.com:dkim]
X-Rspamd-Queue-Id: 425223CBC44
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Prathamesh, thanks for the patch!
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
user must
first configure it via mlx5_ptp_enable, which already validates the index
(rq->extts.index >= clock->ptp_info.n_pins returns -EINVAL) and since 
the mtpps
register only defines capabilities for 8 pins, so n_pins cannot exceed 
MAX_PIN_NUM.

Maybe wrap it with WARN_ON_ONCE instead of silently returning, so if future
hardware adds support for more pins we would notice rather than silently 
dropping
events.


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

