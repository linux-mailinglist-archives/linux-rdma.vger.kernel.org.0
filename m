Return-Path: <linux-rdma+bounces-20137-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wHCfIFt2/Gm3QQAAu9opvQ
	(envelope-from <linux-rdma+bounces-20137-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 07 May 2026 13:24:11 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id C6DD34E769E
	for <lists+linux-rdma@lfdr.de>; Thu, 07 May 2026 13:24:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 0CFCD300AD98
	for <lists+linux-rdma@lfdr.de>; Thu,  7 May 2026 11:24:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DB753C345D;
	Thu,  7 May 2026 11:24:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="rvln4/3G"
X-Original-To: linux-rdma@vger.kernel.org
Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011051.outbound.protection.outlook.com [52.101.62.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B46EC3806D4;
	Thu,  7 May 2026 11:23:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778153039; cv=fail; b=c9NG+r62gPToVfHQox8eWnUlKtEL1q0Q0YLCYDmIiE5fq+XA+c4y9KAZR846xZE/E1u9rpWmEf5/ZWW+yfxxiTkwzyeznrjlJeHRGM9A9un1r1IadljWgiHhXHz9dIg+OSY9MdLn/YpRQBFrf//Q02p6kemwc/2zyrLIr57vdvU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778153039; c=relaxed/simple;
	bh=7S3VGqpDmpmvDLe5tOjS/hGY5x6Sj64/VFl1AvteZIc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=c2I4mcsvv6l+ND/2OOHAUpO8uM0gIMRl5cAEzqoPBT4leqvi8jjidHj4lTIqsZU1f/BsnQb8QHm2bAtVFbmkzEme82NcORZEAL3h83kFR6N0csAXtZQlQnPYczZQ8s8aJake98z42xrCQFPjeTOkmOvekt0FgZHV52sQYnPbfBk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=rvln4/3G; arc=fail smtp.client-ip=52.101.62.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EqEijEgevR/ZFDddeAo930ErE4TnAD6TufAorHcBQ5NzZTZR4qM3aCvBjf5f8pWOVhfUR4tnu32ovbpQ4NgYniCZ09rSuPFLHJcc2fBIc3ebD2X5mJlrWezjT2kkeD2AFBCr07r59csXEM0D+GLXKKTlWA8YxHsCCs/coz42xvzxPhkITigtoaoPzU92UuOb+xcZvmVHSmQN4Jo4vuG6WJ31xwvzFIa3acQVNwEpXIVnm/BorWOpIVLOPu0vMRMo18ioVcxbn8tu/VN/DhDuQ5KBbu9l9VRggczDn4uEXIFxVGsuVwW7s9G7M2/54kcl7pfwu4EMx6u2Ck4mFoaATQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WN2heC9LButifjAdnSiGqXD0Df13TDwWC5wHGJOQZzU=;
 b=B853HNCwF420KKnY5x1XsjoXnfFEuZBbURAMH1duxjIDhjfC6JNuTRh49zs7NW9pbCPwn6dQEKvZ+8ARZUEfM/5kO4fWnF3gpnhEmWHcTkfVbFYxvDt1bgVIq2J37LvprH5tfldJ38SSIfIdzXV5Vq20wWr244QWGdhJqEnRDV6wP+lI6GhoUtjopLHq57nWMkhr2w89KPXrJz6KZlMdtiQzIA6eUC8iu9B1p0JoolkjX+8YBDwGuJ5dEDod6iVsuovxMoaQfpmjwRr+GRJb1kpSbT8CLdVGT8J+ULy+qyWHzfXUdEvW4MjTjyyM4r5Q/uQn1NbkAYwp4f36WG2J+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WN2heC9LButifjAdnSiGqXD0Df13TDwWC5wHGJOQZzU=;
 b=rvln4/3GbyxTvMKEx0Ete8id7+g6d5aF7TrEPDQ+7V21NP7me/mn+iGB9gjw7ndjIFpXcRqGhjIN8igWX6t3GROtnkdE/GksSyRwUOzw4tlrp1b8z7JBmYl26eKFK3Z8GVAEml+28yX+uZfQuOM4rFdXQGcnpdsdDTqxV4KckqGLQ+k6i5bUfa30LDPJtyMbdpfoUk77z82zZZVYb6jDBlWv8HQCH5woa4xU9zzhOa21Ag7aQ+tA+VnbXO+Z+jHQCEFyfWaEPlskf4U12M1+wGRF3zGiXaE37THoxQmTLhHYW9cewc37mVBR2iW3L481aDMslSKVs5t1XC95FP5Qrg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB6583.namprd12.prod.outlook.com (2603:10b6:8:d1::12) by
 DM4PR12MB6157.namprd12.prod.outlook.com (2603:10b6:8:ac::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9891.17; Thu, 7 May 2026 11:23:53 +0000
Received: from DS0PR12MB6583.namprd12.prod.outlook.com
 ([fe80::16e2:19ba:8915:90be]) by DS0PR12MB6583.namprd12.prod.outlook.com
 ([fe80::16e2:19ba:8915:90be%5]) with mapi id 15.20.9891.008; Thu, 7 May 2026
 11:23:53 +0000
Message-ID: <79514417-614b-42e3-8a44-f154a66ae434@nvidia.com>
Date: Thu, 7 May 2026 14:23:44 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v1] net/mlx5e: CT: Fix NAT miss rule cleanup on init
 failure
To: Prathamesh Deshpande <prathameshdeshpande7@gmail.com>,
 Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>
Cc: Tariq Toukan <tariqt@nvidia.com>, Chris Mi <cmi@nvidia.com>,
 netdev@vger.kernel.org, linux-rdma@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260505235029.51045-1-prathameshdeshpande7@gmail.com>
Content-Language: en-US
From: Tariq Toukan <tariqt@nvidia.com>
In-Reply-To: <20260505235029.51045-1-prathameshdeshpande7@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0215.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e4::16) To DS0PR12MB6583.namprd12.prod.outlook.com
 (2603:10b6:8:d1::12)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6583:EE_|DM4PR12MB6157:EE_
X-MS-Office365-Filtering-Correlation-Id: c5c85342-bddc-4e62-5f08-08deac2b1eee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	GlEr8VqqgiqtNHNivqJjRKxliINmmBUHLUlz3A/N2rSvpUoEkrZx6S7v381LgUTa2pdiBnuLtHcybCuYqiY5k//EsSy+p4MDA2rXVjDAx7JzSPxo09qbBDbAIc85JjTMRaAKsRG4sgLiZW6liA0fUnWR9j/Ha+9CREyBEGrN+OD5kTB98OF1u2Bnw/kRcFd4zg8vP4qvRU+eCszVdc91thqjTQ2C2YKD8QzlAiL5FU3fFjepy1p/CCJTMT2Wer1Jn19D90N65hMlPswE2Odsqd5Bd23+huh+t+D40JtK1MlfDVpJHj533MZ1Gy7Px66oglIXHe5QOB+UKfZf0WavQtuN+ieukLNs2vuYo82yQxS7WgYWfu1uHiuHQiA36sClXDMIPrav/BIdMEduRhmxCqMMHDixyRDw3h/RrFlcthC1z/rHAGvWdM/NJEpcYExs7adTmEUvJ8BA96tP86aHyD+yN58c6u3RtbaTneGnLZb7IbqB8HlwEQr0jmtgLTaW87tXx4I0xSy2NCfKuduHn33zilIyhBGo+DqKlSJHaX7pNAsyiXhMaaPVqxlGmF5iYzkBjgqRcpNnswN+wZqN6nXTGFz4sT4j6cSo6UVZl65fmW6nuw/FXLq720It4+SwnMvYOmPWpOhwHyM2qXaPnE93z7PjP7Y8d4+XiQcqG3A4RaQUpHAU58AXSaAof562
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6583.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YUN4QjBMRUllVk4vZmVJSGxONDI2eTk4Q25YVXhlS1ZSc3Q5c3RHLy9LUUZh?=
 =?utf-8?B?b0pYZkgvUGpreThoem9EQUNXODJnUVJPTUsvQ2pVRXUyeDdzT0gwMFhUdTNj?=
 =?utf-8?B?bEsxSityVHJTd0s4cy82bGROMFBmUGZNUHJVK2NyL0ZIMlZKVmc3RG9GTXk2?=
 =?utf-8?B?U0g3dDRpWVdYL2hpYzM2dUZHR0M0QytkdUdHTlVabmhNTU01U3poclNGZUtZ?=
 =?utf-8?B?RG0yNXhKNzRiUE9iN294QTdBMElkWE1qaEVtWUtSbWkvVkV1NHFkTFQvWWpR?=
 =?utf-8?B?WDZ1dWtCK3lGdEpGd1dOdEtyZmx4UUp3d3J2NTBzOUowV3Jra3M3Qnd6eXJm?=
 =?utf-8?B?VWlUc1l6enM4RFN3b0c0VnlwUUR4ZlNUMHZrVUdOMTQyYjBiVGpiOXQ5dEdr?=
 =?utf-8?B?SlhiWXFPaklCcjF3NjQyb0RSK2JKblZZWHRpMkhJVStrWlRBR09OL2VCVk1V?=
 =?utf-8?B?OUVTQ0hhbFVQRHRkWERrb2ZqQ20wMnFIV0pmYm02U2wvcmdDRUhUdWZ0dmt2?=
 =?utf-8?B?TFRJMlFQMWdCYzJWWWRpVGU4TEhGTEJ4SlFiL2hKcGpneWdlV2dnZnEyMHk4?=
 =?utf-8?B?Z2UyMEdEc21ueVl0cFUrZW1uNGlPOVhraUZJWHQxeDZNeUYzSjRSWUNmdXh2?=
 =?utf-8?B?VXR3dDNhWXRSdkNEek9yYlBwMThLN2I5dzlpRC9UenI5ZFZJbm4xMUlrWjY0?=
 =?utf-8?B?RXNZaGlORVpFL1pTTWF6cE0xMysxblYrWW9yVDBySkJMK3cyUExFYnM2ZXVQ?=
 =?utf-8?B?NDNURmswR2FrUW9qTkEvOHpLY0w2QU4xZVlmV1liRW5uZ1lmbGpJZUpGTEdy?=
 =?utf-8?B?M1NQWjcvN0NsQWNiVVhvR0lLYkFlU2VyOXNMS2hVbWlNOTU0RlllczVSaWUw?=
 =?utf-8?B?NmN1NFZIZEQ4RnN4b0dVVTRlUHpqckV3eUhQQlJuQThZTng4YWQxckxXZTY1?=
 =?utf-8?B?R1dOSWVjdFZJMGtYUjNVejQwcWN0dS9mN05TVldJa0xsbUkrcldTSGxzRlVV?=
 =?utf-8?B?dFB6UVUxdHFMd2daRTUwdHRUbitSMFZMaUZDbHR4cnNTOUl3TG5hMFFVek00?=
 =?utf-8?B?Q3ZlTE5XblpMUWgvNHFjRnI5WUJQUmVhdUtlaXYzVUw1K3dzSXNjZkZYYURx?=
 =?utf-8?B?d1VNbEhXQitYbjZqbWFROExqRW1rMGRwODU0ZFZyZmZxMXRYSUd0MUhRWGg2?=
 =?utf-8?B?S2ZxcGNBZjhYZldwVEFYdmtGZFJXdmQ2eXA4djVYMWpJeC9aRWlyU1pzNTc1?=
 =?utf-8?B?L3BrUXhVWHNmWHBvREdBaXJWQ2lLcGI1ekpHTndRcmQ0YnEySW01RXYzcTc1?=
 =?utf-8?B?eXYzVUQxK0pzcThncFRSKzBrZFM2TkhxYnFQSUhYMGVpTzBmVXFoQ1lFdUh6?=
 =?utf-8?B?RzZzL1NhR2ExdkhVWUNmSVdRZHFTWXlFcEd3RlZPV2FkcmJUdzB2Mm11NWlE?=
 =?utf-8?B?bldFYnIxZElmbGZGR2RsRkVqVEdpOFVHUGxOSnNpNy96KzV5b0xkendUWmU2?=
 =?utf-8?B?OWpFR0gydFY1dFp1WlFEYS9oRFRHdlB1bjhsVWwvbGx3SWYzaktQMkcyM0Rv?=
 =?utf-8?B?ZlF1Vi8wSk1hNFpUc3dEbmwySlhaRU9teWI4TG9CRkRnVERTdndtNjdmVFk0?=
 =?utf-8?B?QjZlbTNZYUxRRjdyd3dVUmJNcTJzUUN6NENhTFhmRXEzR2h4VlNTMWFEV0lr?=
 =?utf-8?B?YzBMQUhVRjdOb1hQekkxaURZd0EyVzhkbWtmS25XcDl5WEdScmJtTHF4aGc2?=
 =?utf-8?B?TTlDWFNOeW0rM0V2d2syTktVRXhsYmg5dlExTDFqUFJtaHN5WmZ3RW1qMDF4?=
 =?utf-8?B?N1YrUEhHaVJuVzVrMTJiRStkQ3JiU3ViYUVSZWpxVTkrdXlldm10MEx0bUMr?=
 =?utf-8?B?SUxkOTRvUDlkNTVTdHJhSzJYeEV6Skk4am5NWjRsUTRkRTI0WnBxUlBJNEhr?=
 =?utf-8?B?K0ZkaHBaeGYxLzJzMWtjVWJBVDFpOVRFVVNXN0VlUnh1SnViTW9HVFZMNGRr?=
 =?utf-8?B?QWYrTjdtbW50Y0pHbDFIYUxVZ0RNNHNJaVllUllya3IyWE5zYUpmQjNhNGJW?=
 =?utf-8?B?WlRKQmFFOGR3Nkhqc2RVNTh2TGtYTmxZYVNtKzlJZ3pXbTZ5VWIzMGRKdjdp?=
 =?utf-8?B?L1RKZ0dmbkQ4NFRJQ1hlbngzWWF1VWo0WC80YlpGM243Tm0za0ptNVZUREo4?=
 =?utf-8?B?NlppNkxqUFhTWmpJUnRrOENnbW5VQWs4djh1U0ZHNi9vMHlmZUd5MEljMXZP?=
 =?utf-8?B?M1pJYi9NYmZtaVZuMDRQVlhyTCthUUtWZUoyQVR4aGI5TldjRFRTb3FkNG9U?=
 =?utf-8?B?OFNRNlo3RDJrelJVM3Y3VlFXei9XSmlTakdLcWV3Wm9vTlNTS3VXZz09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c5c85342-bddc-4e62-5f08-08deac2b1eee
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6583.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2026 11:23:53.8090
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: y+gyc3lbMFM1RLMG+8vI79snPiTltO2pYer11kKWOnnbHWlPEHCsQepkDg/mSdAO1a7wlHIk1PnBbn+EGZtb/w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6157
X-Rspamd-Queue-Id: C6DD34E769E
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-20137-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,nvidia.com,kernel.org];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tariqt@nvidia.com,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,Nvidia.com:dkim,nvidia.com:email,nvidia.com:mid]
X-Rspamd-Action: no action



On 06/05/2026 2:48, Prathamesh Deshpande wrote:
> mlx5_tc_ct_init() creates the CT-NAT miss rule before initializing the
> conntrack hash tables, workqueue and flow-steering state.
> 
> If one of those later initialization steps fails, the error path destroys
> the CT-NAT table but does not delete the miss rule and flow group created
> in that table.
> 
> Add a dedicated unwind step to delete the CT-NAT miss rule before
> destroying the CT-NAT table.
> 
> Fixes: 49d37d05f216 ("net/mlx5: CT: Separate CT and CT-NAT tuple entries")
> Signed-off-by: Prathamesh Deshpande <prathameshdeshpande7@gmail.com>
> ---
>   drivers/net/ethernet/mellanox/mlx5/core/en/tc_ct.c | 5 ++++-
>   1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/tc_ct.c b/drivers/net/ethernet/mellanox/mlx5/core/en/tc_ct.c
> index 6c87a1c7db09..15e406d29004 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/en/tc_ct.c
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/en/tc_ct.c
> @@ -2349,7 +2349,7 @@ mlx5_tc_ct_init(struct mlx5e_priv *priv, struct mlx5_fs_chains *chains,
>   					   &ct_priv->ct_nat_miss_group,
>   					   &ct_priv->ct_nat_miss_rule);
>   	if (err)
> -		goto err_ct_zone_ht;
> +		goto err_ct_nat_miss_rule;
>   
>   	ct_priv->post_act = post_act;
>   	mutex_init(&ct_priv->control_lock);
> @@ -2382,6 +2382,9 @@ mlx5_tc_ct_init(struct mlx5e_priv *priv, struct mlx5_fs_chains *chains,
>   err_ct_tuples_ht:
>   	rhashtable_destroy(&ct_priv->zone_ht);
>   err_ct_zone_ht:
> +	tc_ct_del_ct_table_miss_rule(ct_priv->ct_nat_miss_group,
> +				     ct_priv->ct_nat_miss_rule);
> +err_ct_nat_miss_rule:
>   	mlx5_chains_destroy_global_table(chains, ct_priv->ct_nat);
>   err_ct_nat_tbl:
>   	mlx5_chains_destroy_global_table(chains, ct_priv->ct);

Reviewed-by: Tariq Toukan <tariqt@nvidia.com>

Thanks.

