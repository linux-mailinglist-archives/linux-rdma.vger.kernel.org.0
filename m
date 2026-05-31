Return-Path: <linux-rdma+bounces-21543-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uJNyBaEYHGo+JwkAu9opvQ
	(envelope-from <linux-rdma+bounces-21543-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Sun, 31 May 2026 13:16:49 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E441615BFE
	for <lists+linux-rdma@lfdr.de>; Sun, 31 May 2026 13:16:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 47A52300D971
	for <lists+linux-rdma@lfdr.de>; Sun, 31 May 2026 11:16:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B45D38399E;
	Sun, 31 May 2026 11:16:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="rcq5pC3g"
X-Original-To: linux-rdma@vger.kernel.org
Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010063.outbound.protection.outlook.com [52.101.46.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A72C37755C;
	Sun, 31 May 2026 11:16:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780226188; cv=fail; b=HpCN7l8i0YE21vqN+jcYnLKP1lEXeGHa4tXjh3slJ5fQPZ1GRsqgvNGw81E4yI6Iot28zQhiAQl1wBvsylK2b48oX5/SsfMffA5WcyQA7u+AWB7tSJ/b7ad06/GGZUAMDY1qHYxsUNJ7Sev0ACcMFDDgmMSoXjfa5gUl6fD4vJE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780226188; c=relaxed/simple;
	bh=i9rpZMtufd1OrG1WexVDcx9BzHJbh7zt/+ZBMZmi9zI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=g0fZUHnlmjTNuE/Lm7XhZ31a64QfOCgGwnohHkZLQD76m3bxdDBhE2CwFwRWivaRia4CwyJjkPu32cM7pUrwAbXawx8zRUKCdvQW1ZtRNBXohXYFo+rrMkRIGs9o3VWOvOUF1qYVSWbIOvSos0iEoh1wn7ooiiFOSKL6DBJzhRM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=rcq5pC3g; arc=fail smtp.client-ip=52.101.46.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=W91w5O4AJOEH2Ozooqh0WOkgHB8QbrqsAj9JodLyE8+4dfWtGu2Du4wX5vQfzPxQNBvzo1lff6ph9dGuhJM6kkfDJ80TCIqsErIrR60xZ4wz1nULmBcZR/pAElsF7gyL8ClXvvC17l2yG9On559wrSe0sZgnIEUpdF8iZk6rAodmBQeO28dmp0GHgUaY1HgpNLQQzGrpwagqAAKq92RIZSzvczsqI+gRKHl27+SLgZ4341iC3IMTZhtetSSgUUv/lD/s8weaHq8zJ1a0+XwOBCGn8oVLmlbX/xBSGyIg39eg3XGPgmlYP3UtK5FDX+PohZk+DE9czDzVaCl59hsyCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZuCFo+NBJGGilBGLx4yh8dsrvF90PaTDFrB6hhgA+bE=;
 b=seXpE3ULhrp+J3gYQMJnn6e9dSyBUTrLUdHIBlTJkYeWVxfxXoNbGMFkasCwh4syVVxhoQywsBEkazaUJoTanQMAf9RHcgnAL+h9CFGMxssIr2azeZPc69KIwNd2p0KtSVU1A3F7AU/VRr5YK6CHhZSRQ71fk4QoFGYrj/2hF4qH0fQ0L2bUfmq55oNjnFc6GJ+dyE+JG74UKjpgRWXYL8FTE53wW7IdGAuWADPQZOcp6Ba/30vd5seG3rHTBo27yFd335WH6afOTAS7G/chj2NQN6Epfx2CHu87n9Pl23xMFZZNqs3/1m1kAJGgDu2SE/j8otuAdBE5qirgvwV+rw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZuCFo+NBJGGilBGLx4yh8dsrvF90PaTDFrB6hhgA+bE=;
 b=rcq5pC3gOc99mKQz92NCi4m+Wxe0KaCbW9A+KFkMAHDNJzkts8dZQ8XdQiVtdtMOGHrm0EaCu35UGn5PWlb7NVQLlJGLots+SwKfyuIKY+EjuX7yVLot07HLnYx17gs/u8PAAafGi8dAUMNdEw5sQVjZEU2kmKKPkBZZLDF0KqEly7bw7SYD+XAs/DILvEJ1xFB3ETOxCNYKDMZUqbbxzvuRT8YrXWTToLzcLBap3fifY6VggbLmkfjadYZVAanOtQ5U8uV/J4cqEzfHY6gLDSRI21koPrKymEFrrzFF0o6i46tCEJ3brbvfGRATaYothXGV1rMcff1XUb4m1sV+qQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB6583.namprd12.prod.outlook.com (2603:10b6:8:d1::12) by
 IA0PR12MB8713.namprd12.prod.outlook.com (2603:10b6:208:48e::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.71.15; Sun, 31 May 2026 11:16:22 +0000
Received: from DS0PR12MB6583.namprd12.prod.outlook.com
 ([fe80::16e2:19ba:8915:90be]) by DS0PR12MB6583.namprd12.prod.outlook.com
 ([fe80::16e2:19ba:8915:90be%5]) with mapi id 15.21.0071.014; Sun, 31 May 2026
 11:16:21 +0000
Message-ID: <e88c5ca2-1752-46aa-a931-b23e25977280@nvidia.com>
Date: Sun, 31 May 2026 14:16:16 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net/mlx5: Reorder completion before putting command entry
 in cmd_work_handler
To: Moshe Shemesh <moshe@nvidia.com>, Nikolay Kuratov <kniv@yandex-team.ru>,
 linux-kernel@vger.kernel.org
Cc: netdev@vger.kernel.org, linux-rdma@vger.kernel.org,
 Saeed Mahameed <saeedm@nvidia.com>, Akiva Goldberger
 <agoldberger@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>,
 stable@vger.kernel.org
References: <20260526162932.501584-1-kniv@yandex-team.ru>
 <fe5a2ed1-2fdd-45f8-ae1d-656e5e89a354@nvidia.com>
Content-Language: en-US
From: Tariq Toukan <tariqt@nvidia.com>
In-Reply-To: <fe5a2ed1-2fdd-45f8-ae1d-656e5e89a354@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR0P281CA0266.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b5::11) To DS0PR12MB6583.namprd12.prod.outlook.com
 (2603:10b6:8:d1::12)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6583:EE_|IA0PR12MB8713:EE_
X-MS-Office365-Filtering-Correlation-Id: 887032bb-4866-4748-0875-08debf060b74
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|1800799024|22082099003|18002099003|6133799003|11063799006|56012099006|4143699003|5023799004;
X-Microsoft-Antispam-Message-Info:
	hQWSPFgrgDoxrAzC50crxJHbVAQOCLOyq00rbjbrU2yLfwwk4YtBSQJ605u/H+epWZUfINDbeMxX+bfJPWMIZJX2D4pUSa+7zpzq0wCzrec4dgHKAnCTNDLNYDPL5aDHC4LyJSlMHWZ+1KnOE0khlhWHie2tGRQ9yRte852ezx2YegcU0e/aSs+78y68IXwHz3NiqaQJWIs+PjF9/9WhYcCRVxiICj4JTTAaCsCjPgjo6sc0BpP92J1hLFx/gg+f9tX5T2nyFEFkeuT2lQF/aLok76TdpIN0g2jYE9IG6QxTe8HwjN3Eih4QWXPtyOGAkpm6xS5nvhtbY1/ngYN7HnkyoRnaJjF9LN2S9q95zTVbtAwEM7/0kTD4LVDpJa7tFpPenS+lX/He8WGKzn+SBUWJLRLpTM85PazLqMr6fPhLsqiVVEiTK/XYn4Ca4t7u8GjUicqGpC9S+W0aPE4GcZReBS+wD5lM/LW6QlCCp2UW9tFFJTHrfA/WlATfYC6cliPNTpohfUdHFp2C4T0rC093tWPSID3VEZmZwb7f9FXsBanqtCz0ciCXkYX7G4npVk5yBcfokG/Kw6tMosKqLRfCOAxXNwvKrYO/udJSIDabDhat0mNTM4Gwuf+kzpvXi31FIvC5ho3lrxzoRGg1bvHiq0BON/x7wVCo9jxiGWtNagxUGRyDrUP1A7WESjytepcQRg3Fy/uFECh7ozItrw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6583.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(22082099003)(18002099003)(6133799003)(11063799006)(56012099006)(4143699003)(5023799004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aHhiTDkwY0ZRMEw1MFV3QW1FVXpyYUxiUEhNcEVpb1Z4ZHVHbWE2TUxwSENy?=
 =?utf-8?B?d0dwTUVEVm9QdEZTMkpnbXZoQ05MaVBmVzRpdWRsQXl6NVUrbHZIYnhjSGtV?=
 =?utf-8?B?SlV3eWs2dzJzYTdXa0hlbHlsZnEydjdKRnVNZ0hOd1p1dUVYSjZhNWVJVzh0?=
 =?utf-8?B?OWp5a1ZoN3IxUE9KbVBzR3VIMlorbnlQamJacTg4RFV6Q2ZZLzN4RnFGaktv?=
 =?utf-8?B?WkFvWFZBcW5HV1pJekNCaVRpMFY4OUloeXpjaUJ6MzRMOGt2VVFLb0ppOUtH?=
 =?utf-8?B?c2Zwd29Vb3hpdm1uVEE4U2xSWjBvQ0hFRVk5K0d0UXk4cnphNlRYUGFTWThq?=
 =?utf-8?B?cFR3VlNLbHBYUU5sVVo5Y09PbjNMemd1MU9SSHg0MDlvWFdPSFdKMHZ1ZkZP?=
 =?utf-8?B?NnJCajFUb1I3eTdjdC90STdORTB5aXpWTEtvWWdCbzNVSGZBRHVPTmtSbnhS?=
 =?utf-8?B?WGpGM2hwbjZ3TThON3FnNDFqK0wvd05UUHVsdjVZSWc5WnRTQUt4bVdtT3NZ?=
 =?utf-8?B?VEpSY3BPNThnVnYwQlZFT3JZdk1Ka21QRlNtZ1RHMENOZlkweTZHOVNLbjRC?=
 =?utf-8?B?Q0pOMmhUSVVIQ3ZpaUozUFU2bTJDN1JzeG5rVEZaQXY4R3pCbHhGK29VdzNU?=
 =?utf-8?B?bE1CYXQ1N2NiWnBGSGZTR09LOEpvdE9QWEtQdWRDT3FNZ0kwa2l0a09zdW1L?=
 =?utf-8?B?MDJ6TmlNZjNwYnhZZzdhUGVCeTlIUXNYZEN3UHRoWHV3SmIxVk8vSURLdEoy?=
 =?utf-8?B?TzJOWkhHeWdZZTBWdEZHMGYyZmtNTkpkMUFEV2xYSTRzMDVneEd0cGhkREdu?=
 =?utf-8?B?TUZMdy9TLzdVT1JVY2VvVzNvNTI0ZFZzWjEzbXF2ajFrNEZsV3Z4NmlFcGV2?=
 =?utf-8?B?YmVwcm9GR1ZnTy9nYWoyWXkxWm1KQ3g4VDc0TTJCWFVldGlvZXh2NGVEVGh5?=
 =?utf-8?B?Q3NQZTJBUFlDT2JTVmlhMVNLTVRpR0ozUGFuNFk4RFlZSW9UZ2VObmt5WWNX?=
 =?utf-8?B?NU5tTmhqNkl2S1BFYXFaSEJhTGprOXd3UUlUWk4xMEpkVHhPNGN1UW9zZzJU?=
 =?utf-8?B?by9nNmJlclB4ZlJFOHUwRTVnTVZaU2lCeHVEM0t6SzVtR1NIQmN2MUc0eDcw?=
 =?utf-8?B?azlqWUxPM0RjUURUNytnSTJjSk1VS3ZXaFNvWVlCM1dLNlMxV09HNVFyMTdM?=
 =?utf-8?B?WnNFVzRYMjc5MkpKaFlHaWgybnBvU0hBMVhnaGloVFR0blZzekVVZTB3ajFa?=
 =?utf-8?B?cXBiVHBoL0NYbkpvNUFTOFBNZ2piM3lhSW1XYlNtQjRRVGxiVTJzYmpIN00x?=
 =?utf-8?B?UVNicmtObS9PQloyODBNL2lUUFVPaHJxT0lXZ3ZTNTFVZEJPMG9BZ2dLYVdR?=
 =?utf-8?B?N0hGTm1IMlgzSVJZZXk3YmV2ckJxSjdDYm00d1N3SHdYUEVBZU9iN3pGRjFX?=
 =?utf-8?B?MEw4ek1jU0poR01ObDZyMW5oR0pKTSs0eFdDT0sydE95cDJYSXE1Wms5Tkdv?=
 =?utf-8?B?dWNQcW5IQzUzYnR2UHNVUDkwcm9IZ29sdy9yTnZzV1hvMFF1czNCRmcwRTc4?=
 =?utf-8?B?ZDcrcW5lSnZ2aWczYi9qcVV2dWVEZTNDM3BpVlo4aGwxMW9ZVVR1V3cwbXgz?=
 =?utf-8?B?SzVuTHoxekFpWVZQY01zNjJ3ZDNLT1ErL1IwUHdJT0VsNGl6OWVQMW10RlZw?=
 =?utf-8?B?dWlKZmFpd3hHalI2a3NYQnJNdUJTOENZajI5NWprdVhPZWJtRktMS1gwR1VT?=
 =?utf-8?B?VEVkejdzdzk2TE5XekdNR1ViMU1HM0owQWx0ajl1M2QrRnpqL0VoMk9tdUJT?=
 =?utf-8?B?bklNOTJYc09LRG5mY1Fzc0FyOWxWZzcyV3lxcmVnN3BBTDRrblB2STdWTmEz?=
 =?utf-8?B?bExFUlhjOU40NTVVeCtnYzBOald6MG1CV21mS0FOYTRIcGRsclJ4WGlmblJs?=
 =?utf-8?B?QkpWRjRCWXJhTTVHRVhFUVNUbURyWkQxdUJIT3FVR3kwbUtNeHlmWVZjSGFX?=
 =?utf-8?B?dnpBZGFGL2lwVTVrRll2YjVYOFZtQVZYMW9oUk1JR0cxWlR5MTJnOCt4MEZJ?=
 =?utf-8?B?UEFoMm9RTk8yeGlqdXY1ckVLOUxUQzROSjJnNklzU2RmZUVZaUYyc3Y1UjBI?=
 =?utf-8?B?Rm1xYURwenZKL1FhclVpMnFPTURBd2dFc0hyQ0ZSVVJ2SXpvL083NXFDU3E2?=
 =?utf-8?B?MWQvbW9uK2FIV2o0bDRxZHNFVk5NVFZlMU1pZVZGZDF5RUpFUk8xQjlvSHlF?=
 =?utf-8?B?aFp2cTdHaUtMYXhSTWFRbG1ScW5xQklXem5LRFdVdWxrVXlncG9YQ1lNam5V?=
 =?utf-8?B?ZGZjbmZOWG5CUVg3RG9QTW8xdXN6dnE1US9SeHNZWmNnWkZ4ZFlqQT09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 887032bb-4866-4748-0875-08debf060b74
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6583.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 May 2026 11:16:21.8720
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TAfpoEiqNSKz/VoWVLyIowPflf3SeGsl9KngzRPO+RMvjUZ0q9Q+qGrw4vcqJOgxh8FAIZfITd43DL4+MaBcVw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8713
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-21543-lists,linux-rdma=lfdr.de];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tariqt@nvidia.com,linux-rdma@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,yandex-team.ru:email,nvidia.com:mid,nvidia.com:email,Nvidia.com:dkim]
X-Rspamd-Queue-Id: 7E441615BFE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



On 27/05/2026 17:19, Moshe Shemesh wrote:
> 
> 
> On 5/26/2026 7:29 PM, Nikolay Kuratov wrote:
>> Assuming callback != NULL && !page_queue, cmd_work_handler takes
>> command entry with refcnt == 1 from mlx5_cmd_invoke.
>> If either semaphore timeout or index allocation error happens,
>> it does final cmd_ent_put(ent). To avoid access to freed memory,
>> notify slotted completion before cmd_ent_put.
>>
>> This is theoretical issue found by Svace static analyser.
>>
>> Cc:stable@vger.kernel.org
>> Fixes: 485d65e135712 ("net/mlx5: Add a timeout to acquire the command 
>> queue semaphore")
>> Fixes: 0e2909c6bec90 ("net/mlx5: Fix variable not being completed when 
>> function returns")
>> Signed-off-by: Nikolay Kuratov<kniv@yandex-team.ru>
>> ---
>>   drivers/net/ethernet/mellanox/mlx5/core/cmd.c | 6 ++++--
>>   1 file changed, 4 insertions(+), 2 deletions(-)
> 
> Reviewed-by: Moshe Shemesh <moshe@nvidia.com>
> 
> Thanks.
> 

Acked-by: Tariq Toukan <tariqt@nvidia.com>


