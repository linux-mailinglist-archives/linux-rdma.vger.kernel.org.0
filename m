Return-Path: <linux-rdma+bounces-8395-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B6834A54031
	for <lists+linux-rdma@lfdr.de>; Thu,  6 Mar 2025 02:57:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E1A8616DEBC
	for <lists+linux-rdma@lfdr.de>; Thu,  6 Mar 2025 01:57:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 506B018C903;
	Thu,  6 Mar 2025 01:57:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="e7LDaDDC"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2048.outbound.protection.outlook.com [40.107.101.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A35E179A3;
	Thu,  6 Mar 2025 01:57:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741226224; cv=fail; b=HY9MEc9TZpLI6bY1ajRKzI8J69oenDaSrqQgUe2In8OAEP9O1HA1uDN8YrQHtnZ50qZohMl2WajnM3bJFIDHB5F76HlBgCQq6wJuGRueQ5Yhq9FGKZ3gd1nPiMTIfe7TjCVYDnU/XIvXQcm5UZzactfqyGFg2Qif8xnZBDBu0eQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741226224; c=relaxed/simple;
	bh=yoj0YsT6weG6KKE5nbZAisF181v8x/kttvcXh3puRAc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=nEmaMwvxe4SW68Cp2D8Bmm79EawOuOIZGCoTZUmUKomHkj+pvzAwwfXgkpSRqxR+JbhYgmHNhIKn0TSQueCdQgeS4OIkGG/9K13mWUcGg3/vPklP8fWM3ttKptENkmi1NZ7taz5jyYRGTT2FVDijALzbKTtobY8vZjSiiu0IQBg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=e7LDaDDC; arc=fail smtp.client-ip=40.107.101.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KNRg8mD3YeC+SQkNfrHf5uqs7I8dmlxc+kVF3isbUf4ONrfXqe+eLodqMiAhtouaVvNbJ49rOim2c0qlugdUOnAOKl2KPHd0t0DfNL7M+r3c9gjy+EwyzsAdlCR/kCRRguQYHicS4TViy3BYCJyfVCrrU23zqulojotwyXUo/Dlz2VrVjqLODyZRhxVIUEfuW32YwJOAL4NkAlnFVpJVBjS6ZwGZ3Stf6Te7/vLZk8Mu0Kcccy8IlZ6037doaW/kpA6RLqiMVF2wv/aaF2icLCaI+ojA7L0hs70cpwLQsiGuzYHrSYDp7MBOZaLaVRbKmSci9DMIsQfHbMW7tJQBAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4U0mGZJl+C5fEg0lRIyVTzvp6eOOJffLmlluFsEmesM=;
 b=RMj+zYUqDnIUSsVevGk4B/B/2sTVW+RaDUcLT9RzbWgGwOiBeaFSajgcQ3zCjpfSoQEABDb+cNNK6o0rvG0n2rzfLI58MxnCvcpTdk4OcQdHJnm6ufawHs0/+oB1Q3zy9h5Sx9P8KmiUphJRBTV9QGY2mZYC5x+uFCGanVmv1zTlLSpsuRxSROxW90EsfbqTIhu6Q3b0ubMf33ix0XQ6FetUI7+2zFpt8W04focSsUbd2HDHci+r0GVhBH9O5CioxsS+ugEOoF9FRYJeWwEH8mL5Ew9EMpfcL2nhIJr+p87VNOCQMHIJhO0GvPh9FM6ZLaLkcgRuRFi4g+L5FNjncg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4U0mGZJl+C5fEg0lRIyVTzvp6eOOJffLmlluFsEmesM=;
 b=e7LDaDDCzB1mCEs+fCzf8Ht5mK772H5knamamUuvA3tHD3r34VH579bib06OsEgSPJpMIniyxjtTLa9mtjMTI3Ky06H/Uk3MF2PulRoW1/Q8hFrJL3A1zveBavtAflsli/4BaPXUibMRdMSPojYJIXI9RRhYloMLJHJpq7Nz7Mw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB6583.namprd12.prod.outlook.com (2603:10b6:8:d1::12) by
 SJ0PR12MB6783.namprd12.prod.outlook.com (2603:10b6:a03:44e::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.25; Thu, 6 Mar
 2025 01:57:00 +0000
Received: from DS0PR12MB6583.namprd12.prod.outlook.com
 ([fe80::c8a9:4b0d:e1c7:aecb]) by DS0PR12MB6583.namprd12.prod.outlook.com
 ([fe80::c8a9:4b0d:e1c7:aecb%5]) with mapi id 15.20.8511.015; Thu, 6 Mar 2025
 01:57:00 +0000
Message-ID: <513e5e75-e55b-4379-ad8c-59e630fb4b99@amd.com>
Date: Wed, 5 Mar 2025 17:56:58 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 6/6] pds_fwctl: add Documentation entries
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: jgg@nvidia.com, andrew.gospodarek@broadcom.com,
 aron.silverton@oracle.com, dan.j.williams@intel.com, daniel.vetter@ffwll.ch,
 dave.jiang@intel.com, dsahern@kernel.org, gregkh@linuxfoundation.org,
 hch@infradead.org, itayavr@nvidia.com, jiri@nvidia.com, kuba@kernel.org,
 lbloch@nvidia.com, leonro@nvidia.com, linux-cxl@vger.kernel.org,
 linux-rdma@vger.kernel.org, netdev@vger.kernel.org, saeedm@nvidia.com,
 brett.creeley@amd.com
References: <20250301013554.49511-1-shannon.nelson@amd.com>
 <20250301013554.49511-7-shannon.nelson@amd.com>
 <20250304171230.00007a5e@huawei.com>
Content-Language: en-US
From: "Nelson, Shannon" <shannon.nelson@amd.com>
In-Reply-To: <20250304171230.00007a5e@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0180.namprd13.prod.outlook.com
 (2603:10b6:a03:2c7::35) To DS0PR12MB6583.namprd12.prod.outlook.com
 (2603:10b6:8:d1::12)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6583:EE_|SJ0PR12MB6783:EE_
X-MS-Office365-Filtering-Correlation-Id: 508e5624-eebd-4e94-4228-08dd5c522eee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WG1tQ0UvVmtHUjRVVVhxRlN6L0RWUFRvYVJIR1hCQTVIaDFXamIySk9lRUQz?=
 =?utf-8?B?M2IrUkhhRjhidi9vSVFRM0F1U2c1MXJyb0tuazhiSE5KYWZhazIxVTF4Zmda?=
 =?utf-8?B?ZnJLU0xzMFQ2ekgxa3BxQlBpWDZXdjBseHh0QVgvSmtCajhVT2Q1TG50em12?=
 =?utf-8?B?YzBxTGFRWDFabzVjV3JtUWFqNlcwRjJvS1RNRVZiQ25MOXFjaE5Kd0svY3VB?=
 =?utf-8?B?eUtaNTlGRlFiNnpFSUdqQWp1UFcxaHZoazI3ZW0zUnJWd1Z2MldFc0wrZ0li?=
 =?utf-8?B?VUV2NWQ1SnNRTVBEdzJhVkhiclVYTExVQVN3ZTFnWVIydlpxRzVSVjk0TFNo?=
 =?utf-8?B?T0duL1Aza2ZFblJreDBaV1BJWUpyb2ZreVNOQXV6dkdNVlJPWXFSNUtRL0ha?=
 =?utf-8?B?WGlFWHpmYUhJckxNdTNmbVZEMW12WVAzbUFDMFh4Y2FEL2VMOHREYTAzTk1D?=
 =?utf-8?B?UHMrUURiRStxdysyTm5WbVM0cnZuQWlobW1remQ1dldDZDNIeWlRRHpEZkY3?=
 =?utf-8?B?bm03dEVXa1I5Uld5dDB0dzhYeGUxeHl4dk1sVnlGS2dVdzBwdlQ3YzhJVmFK?=
 =?utf-8?B?Vk5WalphU3l4N1VhUmdQN1NaVVBDMjhpem14U0hid0lOQWY1RkNYelJSQVAy?=
 =?utf-8?B?K3JHU25aVjVFb2lzbU9OM1o4UWtjYjdEV2lqRVM2WXc5WmVPdG1Fc1VVTnJG?=
 =?utf-8?B?QWtidFBOMGNzUEVhbVBiZ3YySmVyT01PNUVVVWdUQXF4WTNKZ1JTcFowVE11?=
 =?utf-8?B?ZFZNT1FneFNudE9aVTJsbEU1SzNwZUhLT3Y0dTFiTWJTZVEyR1ZnQkdRclRZ?=
 =?utf-8?B?YU9VNGtUUU9Obm10d0pCcGtTMUFiNHdaWWE3VndqS05aNVlhYjY1QXR3NTN2?=
 =?utf-8?B?eEV0Sm9rMEVDTjhxa3Q5cldKSWVKc1lrUVloYW10d3k3akt3VmFyQTMzelc5?=
 =?utf-8?B?QjVxWnVWcklLWXNUOEowZzlpNXR5NDBDRC9zN3VDVWs2M3h5aGozaDlhNU9j?=
 =?utf-8?B?YmN4Qkc5dDlOTGpWVFRXZy95cVV3V1RjTHA4dzlvSGdUZ0RLYVl2eDNQaWZZ?=
 =?utf-8?B?MC9YeFJBV0J1NW5mVStZYjFMUTBEQnBkTFRPQTlUR3dzSVlUM2xweHd6bHRH?=
 =?utf-8?B?VGx5QnlkS1BLcysxRHBUYW9BdkRkYmpDY3RJSEhzTTBGTzBtU3N2K0l3MVRE?=
 =?utf-8?B?V1dsZ3llYUViQ2V6MnlZVEhzMjhKVlk3NlVQWEdPU1ZJM2g5dXNMSy80My96?=
 =?utf-8?B?KzYwTDNTOS9Id1crSlNCMWViOHpEckVIODVxUEsya0kvOGx0SVlqeGFoRzZr?=
 =?utf-8?B?WFpBOEtqaVE5WmVzaWNHUGkxZy9nWWhjaUlvSkc1Mi9jWHhxb3l5dUh1ZUZs?=
 =?utf-8?B?WEI0YVNDb2xPWFBkUmRsbkhITnVOUU1xbWcyQ084OWt6Y3BiNUY5d2U3UW1i?=
 =?utf-8?B?WlBUOVZrdTNuV2wyRTRRb01XVEdRcVJ0R1dIdStxMWpFVGVVa29rZFVRWXJz?=
 =?utf-8?B?SStDZ3BVMGxvYlJTTmg0QldVbEdaTi9lRFJOUmQ5RHpSZVpwZEord0QrL2Ft?=
 =?utf-8?B?QjdTaFlLalRGWGlWNmtRUDlPc0lVdzV2OUQ3SzRJWXhPMEE2N3huaXdVazJx?=
 =?utf-8?B?aTlFTnE3blZUQzFJamZOVzZBUnpHTmJ6dTB0U0NVcXZiWGRSU0pXT0ExQkxX?=
 =?utf-8?B?SThoNGNLYng0cVAycVoxWGdXYk1rQVk2K1FHNHVhREZqQ0U2TDZGOWhmbEcz?=
 =?utf-8?B?clB3UHljN2kzWlRNVjZJbElBSzl3bUlwS3JNRFpnRHJtNWhMTEhlUVdBbFU3?=
 =?utf-8?B?YlcxSGF3SC9pZ1VXLy9QYXpTY05XNUJFb0EvYnR2dGNHTHZhMmVkWTY3S3E2?=
 =?utf-8?Q?aw87KoGwWuLXP?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6583.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?V2NrNGI4T0NSTGdHWUhxU3ZvUVdwSHVrMTZKWkIzODVKdTMwMmVQbTJKbTVj?=
 =?utf-8?B?eEFRcEZoL2M0R1V3ZE4rOHFLNWVzYWt3Z2JWa0l5LzNUNEVNWk1NMDVEWUhK?=
 =?utf-8?B?YWNMNndkSXpLWkJYREt2b0FtdGNhT09Od3A0RS9mU3Jsdm8xQnl1MFEybWFw?=
 =?utf-8?B?UFRDVWhETFFBWW5MOVN4cjI0UU01TkVXRU1NbGFua2tBaWtkcEVOQjBENGxQ?=
 =?utf-8?B?MTFVMG9NbWVZSllpczBQVGlheXNPVkxyMzliRmpaNkNnRVNaMXc0S2tLNmpB?=
 =?utf-8?B?TUs0MytEcnlUYk9tM2pVbmdibUNSQW1tMzdURG1HczUvVm01QllRZmVEYkZB?=
 =?utf-8?B?MVZlNXp2bXBYb1djWnAvZEdudExub1dxMTB2cHllVmJFUmJSY3NSS1JJa3By?=
 =?utf-8?B?Si9DcW9vWU5aOEs3VnpDaHhDdHV4dGdKVTFRWHNrSHZscTNiZHB5TnBxalI4?=
 =?utf-8?B?dWJEL1hoZzNFb2sxRmxqSkFqc2gwTlNCd3lRL3I3UjkvQ3dxd2xqMzE4MWln?=
 =?utf-8?B?dU9saDF3K3NpdlFDcUJGbGxGbTdpNTN0WGN0Vk9jTDJpdUJrTlJiY2trcmcv?=
 =?utf-8?B?eXZlWjJtTjhEUTU4djUzZEhPdlY5YVJyR1FhMEh3dk0wR25TRWszVHpTVitP?=
 =?utf-8?B?YmRPdXdyV1dhY2RPZTFBcTBod2ZyMDRqTXhyRUpXaEtGdzUyUnk1MWxnaUNz?=
 =?utf-8?B?eHVmZE5JT0JyemM4VytPUnpjM2gxa2krMWR5aDYvQWgxV1B0SCtreFV3c2dU?=
 =?utf-8?B?QWs3ekNSb1J6WTJRWCtsYkR4WS96Rjd3QkdYM3FjZkpTNW9PRGJOd0ZwOFJr?=
 =?utf-8?B?bUU4dHZxbXYrbzBCT3RDelF6R3VocDFheXhhN1JsMk54MUFLYU9DSzZ1cDNT?=
 =?utf-8?B?TUFld2Vjd0xDa3dxbVF6MFo0UUV2U0VaMElkcHJEVkpmc29EKzA3cFk0TWRQ?=
 =?utf-8?B?Zk5XRzVzM1plbkNWTzlqdHh4TVM5SGlQdnZoUHF2U204eHhHejFsc05HQzho?=
 =?utf-8?B?YW5MWVkzRktXZjgzckQ4YXAwUHJUcGxWMWlRRUtpNlJselFjUkNTTGJJUFNz?=
 =?utf-8?B?b0ltUlZMb3J4cldjLzhCMTRtUTc1K3grQkVvUTBzZDZQZ0wrQ25HWldUTWFW?=
 =?utf-8?B?SGJPSFYzejU4cmtNS2FvdHIzTGwwT3dMenZrTStxaTJPcHBpUmVuZENweGl0?=
 =?utf-8?B?M3AyemUvcFBGZzNDdlV3djJOaDNrS21oNThEb2QyVjZFY1RzbUhLbENOWDZS?=
 =?utf-8?B?cHk0UjRyNk9ZRmkxVHdTRE8xV1RsL09hTzhiR2hQdGtkK1diUy82TFczM0Qv?=
 =?utf-8?B?SnJETC9hY1JXS3NlYmtybU81MGoyTEJZZXovV0RhdW9NWjFjcUl5T1N4QllC?=
 =?utf-8?B?NWJ0aW94NUZmeVFscEZxaWQvTVdHeVdLQXkraU9tT1hwcDZ3ZW1mbFlMaGRp?=
 =?utf-8?B?ZHFnZldVN2dwczdINCtjd3NWTWk3MFp5NkdWL0FtSzhYcTNybVE1c1M4bkVV?=
 =?utf-8?B?c2tJbHFtSUFDWHlmc251ZUFrOTZReFk4WWZwUENoWVV5T05IcTRQSVZsSVNr?=
 =?utf-8?B?L1NlT1IybUVUSXlnSExhWFl6Y0c4NkNPVjZ2V0EwUW9JUGR0QS9MWGx3a0Rw?=
 =?utf-8?B?eTFUbU5mMW02bW9sTEh3bm1OeTQrYmZCVVRTSlY0NTBvKzhzWGJlMjBXV1Js?=
 =?utf-8?B?L3lheVI4b0U0RzFMLzdreHJkbWgwSjE3dUhjbWNic3JGS29QM3ZZUUZDSG1X?=
 =?utf-8?B?NmJBRzlKNUhFdWtqL2c2cDcxcjlVakkxVlNWT29HYlNVbSs5Sm9Ub2UwcHh0?=
 =?utf-8?B?ZWJ6RFFrbzUzNzN6YTdOc2JCV1VraE1CY2ViVUZoZkxpOEp3K0pDMC9iTWF5?=
 =?utf-8?B?RGJCM1BhZHVnYlAxOUNQMGh4bFVxc2tMclhReTc5a2hxVzdLSEx0UTFoQ2NX?=
 =?utf-8?B?QVlLU2JJYkc3b2wwYjFMbFU4bEljeUFJZm84TUdiZ2JHSlJ1MjJyZzh2YnNp?=
 =?utf-8?B?eXp0cDEyYldTeUZMNkNKZ3VCZ241aFZpNnFNR2xoUlJHZVZKUTRPOGNjSlht?=
 =?utf-8?B?M2lEOWpNOUc0ZGhBWlNleThIc2x3cndwUG12ejU0NWc4Y2JKeXFFbUo2eWc4?=
 =?utf-8?Q?wNhXqKkVnsy6Syahh8uEFX9K3?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 508e5624-eebd-4e94-4228-08dd5c522eee
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6583.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2025 01:57:00.2213
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HLZeMLYC+fI7fOuhfzNz8Qst60rhf2aFRYeUJP8wLzUUCaPB1Etgq5POxKjVlcTIkTFfaGIIcusoFkmpfNd5vw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6783

On 3/4/2025 1:12 AM, Jonathan Cameron wrote:
> On Fri, 28 Feb 2025 17:35:54 -0800
> Shannon Nelson <shannon.nelson@amd.com> wrote:
> 
>> Add pds_fwctl to the driver and fwctl documentation pages.
>>
>> Signed-off-by: Shannon Nelson <shannon.nelson@amd.com>
> Really minor stuff inline.
> 
> Thanks,
> 
> Jonathan
> 
>> ---
>>   Documentation/userspace-api/fwctl/fwctl.rst   |  1 +
>>   Documentation/userspace-api/fwctl/index.rst   |  1 +
>>   .../userspace-api/fwctl/pds_fwctl.rst         | 41 +++++++++++++++++++
>>   3 files changed, 43 insertions(+)
>>   create mode 100644 Documentation/userspace-api/fwctl/pds_fwctl.rst
>>
>> diff --git a/Documentation/userspace-api/fwctl/fwctl.rst b/Documentation/userspace-api/fwctl/fwctl.rst
>> index 428f6f5bb9b4..72853b0d3dc8 100644
>> --- a/Documentation/userspace-api/fwctl/fwctl.rst
>> +++ b/Documentation/userspace-api/fwctl/fwctl.rst
>> @@ -150,6 +150,7 @@ fwctl User API
>>
>>   .. kernel-doc:: include/uapi/fwctl/fwctl.h
>>   .. kernel-doc:: include/uapi/fwctl/mlx5.h
>> +.. kernel-doc:: include/uapi/fwctl/pds.h
>>
>>   sysfs Class
>>   -----------
>> diff --git a/Documentation/userspace-api/fwctl/index.rst b/Documentation/userspace-api/fwctl/index.rst
>> index 06959fbf1547..12a559fcf1b2 100644
>> --- a/Documentation/userspace-api/fwctl/index.rst
>> +++ b/Documentation/userspace-api/fwctl/index.rst
>> @@ -10,3 +10,4 @@ to securely construct and execute RPCs inside device firmware.
>>      :maxdepth: 1
>>
>>      fwctl
>> +   pds_fwctl
>> diff --git a/Documentation/userspace-api/fwctl/pds_fwctl.rst b/Documentation/userspace-api/fwctl/pds_fwctl.rst
>> new file mode 100644
>> index 000000000000..f34645dbf5ea
>> --- /dev/null
>> +++ b/Documentation/userspace-api/fwctl/pds_fwctl.rst
>> @@ -0,0 +1,40 @@
>> +.. SPDX-License-Identifier: GPL-2.0
>> +
>> +================
>> +fwctl pds driver
>> +================
>> +
>> +:Author: Shannon Nelson
>> +
>> +Overview
>> +========
>> +
>> +The PDS Core device makes an fwctl service available through an
>> +auxiliary_device named pds_core.fwctl.N.  The pds_fwctl driver binds
>> +to this device and registers itself with the fwctl bus.  The resulting
> 
> fwctl is a class not a bus though here I'd be tempted to say subsystem.

Subsystem works for me, unless Jason has any preference.

> 
>> +userspace interface is used by an application that is a part of the
>> +AMD/Pensando software package for the Distributed Service Card (DSC).
>> +
>> +The pds_fwctl driver has little knowledge of the firmware's internals,
>> +only knows how to send commands through pds_core's message queue to the
>> +firmware for fwctl requests.  The set of operations available through this
>> +interface depends on the firmware in the DSC, and the userspace application
>> +version must match the firmware so that they can talk to each other.
>> +
>> +This set of available operations is not known to the pds_fwctl driver.
>> +When a connection is created the pds_fwctl driver requests from the
>> +firmware list of endpoints and a list of operations for each endpoint.
> requests from the firmware both a list of endpoints and a list of operations for
> each endpoint.
> 
> As currently written the sentence suggest that we are asking for something
> unspecified from the "firmware list of endpoints..."

I'll clean this up.

Thanks,
sln

> 
>> +This list of operations includes a minimum scope level that the pds_fwctl
>> +driver can use for filtering privilege levels.
>> +
>> +pds_fwctl User API
>> +==================
>> +
>> +.. kernel-doc:: include/uapi/fwctl/pds.h
>> +
>> +Each RPC request includes the target endpoint and the operation id, and in
>> +and out buffer lengths and pointers.  The driver verifies the existence
>> +of the requested endpoint and operations, then checks the current scope
>> +against the required scope of the operation.  The request is then put
>> +together with the request data and sent through pds_core's message queue
>> +to the firmware, and the results are returned to the caller.
> 


