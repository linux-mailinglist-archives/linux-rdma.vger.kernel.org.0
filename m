Return-Path: <linux-rdma+bounces-8901-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F158FA6C6B9
	for <lists+linux-rdma@lfdr.de>; Sat, 22 Mar 2025 01:37:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6B0143B91AC
	for <lists+linux-rdma@lfdr.de>; Sat, 22 Mar 2025 00:37:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34375522A;
	Sat, 22 Mar 2025 00:37:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="CiX0cWxE"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2045.outbound.protection.outlook.com [40.107.223.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36E6D10E3;
	Sat, 22 Mar 2025 00:37:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742603837; cv=fail; b=hIpOZavPgnixyQ8JixPzxDQJtrdJCoC7wbFuaQ9rqm//93fj1Gfn7gsjOLoNA0ZENO5b4uo7Sc4lNYjhLRoj3TeiHaU7w/cxESPQLZOSrDRKsK4F8uZflbcEHAruKFH+c0KzuXm9e64gBNWhdJJ0lZ7o6tJnwl7yS0a1SzUPVXo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742603837; c=relaxed/simple;
	bh=+WDK7wSQFNyr/ojiaeAIa+bZC6ju6Cj8gYO8itB8haM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=etOApKinjtXVZBSYbv1V5UrFq15xregzs3E1RLa1XUqR8+c9jdgDD0RiKQylRWoGO8/G5zi23G+8nJoTlvjvk4MuFD9OhuwFUzbAteLXMdP/oKiuUcLGN8na1T/l4A2HwX3rc7subw2B6XWydAcHosM8fBIozbWTdYP/S/zYLbQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=CiX0cWxE; arc=fail smtp.client-ip=40.107.223.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=d43R32Qxtw9ffZy6g+eCzRM5T1/BruAU37OdyhXLntjAC/Me9lv6G5DfH3SNR8pYfYr0CPLmVg/kkBAB0+QXW0OVCoMgdVHPqfGyWfeFm6WtwFGB7zrVVhDez1V+R62krWlnn5zfa+rpEWvotA1jvV0KwW7edOxf/nfp3N5RSaKWi3Y1cXpXFd5ko/N6pU8T9Th1Zg21UtRLFJPDvdhfscPXFrP64Q/hYv7E6lf5PxuWjEkp1GR3PJ2JUDUdsLuz/1AHvm6vkWMghX1SnqKYOxPyPxOY67Cs2EWGrxiSOFOeAL2akvGySudukbKr0oZrLcy8qIewUlOMzRYWdmmK6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pYZ8v4RTZytCcYa0uf9iL9ZckomHioY+rC1hQ+KG1+I=;
 b=N4bIbkQspAmeLlMzIbkxS9S3wvLNUpE1QzRjFy1lCqNObJpe/awQD8PAVFC0GCPoB/pApg4lZW6gidn7GBr1TFuOMuL9NTrIm5IMhabtumKvjPadsLm0KYrvUceBcIK8dEXNg2wC1OwWSC/Sc82/m0idBR4OwvJkcnkfR+LAR1UCY6VIj0PizWOdBmTlxwi1x2OPi7QAODUeYmDcgl2JDiKUFqEULujP20lK1tuIO1ZvWLWAKhZv8UwQFRP0cyEtV45GJpqFOHkJY8vPSawMCrqfsU1CjCel0xzZ1zQvN5GrEc50IDLKNHAyXupN0u37fXMMmZR7/Eieze9PJUZIzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pYZ8v4RTZytCcYa0uf9iL9ZckomHioY+rC1hQ+KG1+I=;
 b=CiX0cWxESSMKqmEJWkmwO/ks+AQCUzS/TR2hik3EzzIHYSRzfuZb7EFF074mZYgAoTCUIlSKjyiO+0NreiZhMGS2OchlmCtzm+SATnmB2RhG1BtSHqNoOSFN4azziKdTmNC1knHC1Lq6VSKxgz2E4YRTDYvu0+urcTaj4u+6Hfo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB6583.namprd12.prod.outlook.com (2603:10b6:8:d1::12) by
 SJ2PR12MB9210.namprd12.prod.outlook.com (2603:10b6:a03:561::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.33; Sat, 22 Mar
 2025 00:37:11 +0000
Received: from DS0PR12MB6583.namprd12.prod.outlook.com
 ([fe80::c8a9:4b0d:e1c7:aecb]) by DS0PR12MB6583.namprd12.prod.outlook.com
 ([fe80::c8a9:4b0d:e1c7:aecb%5]) with mapi id 15.20.8534.036; Sat, 22 Mar 2025
 00:37:10 +0000
Message-ID: <35b5e5ad-ffec-46fb-a864-89313a4f5120@amd.com>
Date: Fri, 21 Mar 2025 17:37:08 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 5/6] pds_fwctl: add rpc and query support
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Dan Carpenter <dan.carpenter@linaro.org>, andrew.gospodarek@broadcom.com,
 aron.silverton@oracle.com, dan.j.williams@intel.com, daniel.vetter@ffwll.ch,
 dave.jiang@intel.com, dsahern@kernel.org, gregkh@linuxfoundation.org,
 hch@infradead.org, itayavr@nvidia.com, jiri@nvidia.com,
 Jonathan.Cameron@huawei.com, kuba@kernel.org, lbloch@nvidia.com,
 leonro@nvidia.com, linux-cxl@vger.kernel.org, linux-rdma@vger.kernel.org,
 netdev@vger.kernel.org, saeedm@nvidia.com, brett.creeley@amd.com
References: <20250319213237.63463-1-shannon.nelson@amd.com>
 <20250319213237.63463-6-shannon.nelson@amd.com>
 <ac2b001d-68eb-46c4-ac38-5207161ff104@stanley.mountain>
 <8225f492-721c-42d1-ac74-cf1a20f19b8d@amd.com>
 <20250321235026.GD206770@nvidia.com>
Content-Language: en-US
From: "Nelson, Shannon" <shannon.nelson@amd.com>
In-Reply-To: <20250321235026.GD206770@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DM6PR01CA0024.prod.exchangelabs.com (2603:10b6:5:296::29)
 To DS0PR12MB6583.namprd12.prod.outlook.com (2603:10b6:8:d1::12)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6583:EE_|SJ2PR12MB9210:EE_
X-MS-Office365-Filtering-Correlation-Id: 93200ded-cf6e-4278-f6e0-08dd68d9aec0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WnpYMUExaGwyek5lNkt0UVNJdXBiR1JsQllhb1VZa1lTU2JFUUZxaFJrZGFH?=
 =?utf-8?B?dUlUdlVoNkdTUXBYa0JGSU0yMFhOeVpMdWtkUE5vUEt4VjdFcEZ0bG54T1lB?=
 =?utf-8?B?THhMTERJYkJIRlBMK1FtN1FpTFNibzc4aWlPQStrTjd2VlBUWFFhcXZndTlz?=
 =?utf-8?B?b0IxZlV2YTd0anBLck1OU0gzVGkzeWEzVUdPNWlIQlQzWE1TZ3k4V0FtcWZQ?=
 =?utf-8?B?Nk1wQkNJMk8wL2k2NHlpSXR6djQvSVE5N3U2ZTA1RlJENFN1THRNeE82WFI3?=
 =?utf-8?B?QWRFWE9veTRSVDN0cG9EeTBvOHdFaUN5UmhPRHJoSzh6SStlYno5THo3a0NS?=
 =?utf-8?B?RGlYOU54L0dKME9qcVR0anY2akVicXRoTFNXTnBVVEVyWHBmd2VKaDZqdDZt?=
 =?utf-8?B?Y0lxRXBJcDJPdjNsNFpOVzIrWHlVcGpMTDEway84djRuWjZtcHdOUWxlWjJn?=
 =?utf-8?B?NjRCWnpjWmZDN3VBa0FaYjdEWUc2dVlTQzRsSTBzUGtaSHNEaTE3eGJlRGw0?=
 =?utf-8?B?bjJmNWxpTWtoZ1c0SjVBZzhvcEYwbHMrTGJINU90YXc1MklUbnBBQmo2NHhB?=
 =?utf-8?B?ZWd4ZVE5NUFpc3E5L2Y1SnV4NUtUZzNPb0FOM29Rc3lvUHNtYVY5L0NGcE9P?=
 =?utf-8?B?d1lKLzlodlR5QnVtbUZrbFBVZ1k2VTNsT0s4Vis3UHZMWVljay9raEpLa0JO?=
 =?utf-8?B?OVhTMHV1d0V1dDJScmFRN3hsZDdiWmRiTldxS0RURzZlU0gvcGhPK0lRZ1A3?=
 =?utf-8?B?K0p3TkJlOGFtVnRwbFhTamx2eTdLRmpHMnRkUlBBbXdraUxxRkNDQTR6R2hR?=
 =?utf-8?B?NitNMDhDN1M3Q0FoSS9nRlhBemV0S3k1U3Jxd0o5d2JCaDVFaldKVGRaeHBt?=
 =?utf-8?B?QmJycFpSY1ZRRXcxd0g3N3BubmxaOFFjQU5uVFNpR0FkWWExai9mVEVBYWZi?=
 =?utf-8?B?bitCNTJJMEhSUDFObFQ2RFFzWk9sU1JLTVRKOE9yTVNNUTE2cEVnd2JmSk9I?=
 =?utf-8?B?azJTQy82RDBidHM5TWxTamFpRlVDVnRDSXJZYkk1RXJXd0ovb2ZpczhrcUZm?=
 =?utf-8?B?dnJYc3EvU3Rib0JwVWlDSU9EaHV4SWpRYXpwZEJMN2QyekJDOVdhQXhtZDFP?=
 =?utf-8?B?cjVJUHprRTdQcFNKZFhXbmZIZGF6aU5PVVFGa29UdzgxcFd2UGFrYUM0ZlB0?=
 =?utf-8?B?L1JwYUtUUVhtWTRrbURnMjEvNmZpUWcxRHpFd3EzU01HVVI1Uit4eTNPQ1gz?=
 =?utf-8?B?dDkrVUpZUkxRWjl5dkJMYnpkS2xYYlkzRlA4ZTVIb3kyZmJzQUw0YXRzUnNR?=
 =?utf-8?B?YmtiKytXN3ArdENvMURVYVdrMEJvOXkzWXlzOFFmWTczT3Z1WXB4M3JYcXlJ?=
 =?utf-8?B?U0VlVjlQUmNFWjVnUW5EOVRGaXR5OS9HMGJMVUxjVDRRTjNiQnhBZUcwbklW?=
 =?utf-8?B?VlBhZUJjTlg4ZzNyaDFjRUdlY0JHbSs4eGN6Ny9UT1picDdqbTU2TWk3YTdp?=
 =?utf-8?B?WUxCRHpJKzBRbTdGQlF5ZHoxUG1jUW11R0xVY08rOUViM2pOQ2VZOEVWWVJz?=
 =?utf-8?B?YzRKaDNpclJKWitzSXRpdkIzWFZmaklmWU1jL1pYN1VmcXFPTjR6c05zWDFE?=
 =?utf-8?B?Vmd0aExPcXc4VTYrT0owZ1BodHN6QURJQ21iNHBQL3ZoT2FVM1pWMGVzVmI4?=
 =?utf-8?B?RFY3YnJ0YTRmQ2xjSytLYnF6NmxWTGpJTmRqdEV4US9qMUtDZE5LNVMrQXBD?=
 =?utf-8?B?bFpzRDg4QmIvRmgrM0M2VG9oOUNzQ2tmcENZZllXYy9qVlR3Zk1YK0VhTVYv?=
 =?utf-8?B?NEkwYUtzQXpESGpwYk5KWSthSkxGMHp0QVg0NzQrdkthdmlNWVpOVkRlSGQr?=
 =?utf-8?Q?Ut1fcg1/IAJpe?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6583.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eDJ2bjZHbm1RUXNWT29mNll0YkVXUXJRUVRMeTMxaWRodGZNK3Eyd1prMWRO?=
 =?utf-8?B?SHVhRlJsb3l3WGs0Yk03enNDRUMzN3BQbEJmK1FUSXV1MzBic25SVE5meits?=
 =?utf-8?B?bkN0SkcrS1drSE1XQWE5dkJ3R0dYSDUxbDJ5aUpDMSs1WUlVNW52bUsyL0xG?=
 =?utf-8?B?b0xidXdQWGk5UDd1QlFNRGI0djBOS0FCWXlZdDg2blRHc0ZFbTdheG81SnI0?=
 =?utf-8?B?SlNkeEIyaSsrMWxuTURuV0g4QS9aVXllcytNS3oyUEVsbE5CVFg2RlBocG5K?=
 =?utf-8?B?dm5abFA5Q05QT2tOYUhpM3BSU08vQVRVSTFYYjlMUFJpeitDQXR5WC85blVv?=
 =?utf-8?B?UHNmOUpjbHV5bVF6NVBjMW1iaWQwdlM3YkxFUUlsdnRmQndOdkdqV2NkeC9U?=
 =?utf-8?B?aldEMEliMjg4MmMxNVlRYTZnNW9NSHdycWdhMlYyVDlBTlZnekEzcUozWkJ2?=
 =?utf-8?B?dGlaM1hvL3cyUkd2UjViV0U4cldGVE9wT3ppYUFGTXpmV1NiZ3RDNWZlRk5l?=
 =?utf-8?B?bHdMd1JhaDRobitVdVlmL2pwOGppQnJneWpzNDY4NmlDMFU0WjEwbUNCUFRk?=
 =?utf-8?B?MWVNdCt6aEpYRDRwZjZNWjFGQ1JaeXdBdHFjTFNLaTdhVFlJdGRFUnBZbkx3?=
 =?utf-8?B?YUhpZmRGSGNpci9PakVhTDRYcC9jbWw1UTRWM3lta2pldUVBejU0TXJMYWZw?=
 =?utf-8?B?cXFrc2Vja1ZZbjJkME9YVGNGYzdiQUcrWXk3RmMybC9JelJrbVMrNmJ3TzRt?=
 =?utf-8?B?TUVHQ1dUMEFGVTlyZnlmL0lBdjhlaDlZNGNmcXZkQk9POWR5TWdaS0FmNlFn?=
 =?utf-8?B?NlcyZEJ5MTNPeVBWSlBTUitVLzdkNkEwZkNOL1R2RThmeHY1aVlMNG50NU4w?=
 =?utf-8?B?ckhjb1dDMEppbTFQS1phUHRrUmFwVlh2YmM0azhrdlBTVktGLzcreVZzV1pF?=
 =?utf-8?B?eUdTbncybGYyZkFSRUd3aGgwUDJ5eUN6c3J0b1B3T0lObmIya2VHWVlrYk1N?=
 =?utf-8?B?VnpoTjIvY0FSY0RlVVRIdDZ6NmVxNUY3OS9NZ084OWxhdmJ6ckw3N3NITmtI?=
 =?utf-8?B?OSs1R0JpTE8xUnJpMDZlMU1ZMDFTMmFXUGRtTVBDa01qcUdneHI0UXlzRVdq?=
 =?utf-8?B?a0NENXhYOFpLWXZ6c0pIUXR2YnRtcnNLSUNRTXovc0pFUVRsTGFPOTBMdmtj?=
 =?utf-8?B?TXVJN3BtL1I2VTVjeGZDait6T0xXUDV5RVBWYVE0bXVnajc3a2d4a3pld0VX?=
 =?utf-8?B?SUZnQ29zQytYTW1tZ2szVW54SHdtZTZWeENnczNqUFpmaXBBbmRTMUpIbnA4?=
 =?utf-8?B?bFFtemNHbkRCdFdxYUFZc3lYNkYwdzduYTRlNVZGTGVoVFIvTVBJR1JuOTdU?=
 =?utf-8?B?U2xqRkFvbE9mV0VBaGdPb2s1TE16akZvQjh6d2NyR3ZMQ0pnTDBWZUVRY3JO?=
 =?utf-8?B?VVl3WXpsQVgvZXJKMGRWaEU3TVpWWDlNRWJ0UWh2Zzk5ODNXVVVqT2hzM3A3?=
 =?utf-8?B?RndYS1Z6UXViZU1CVWtkWUY0T2lPMDIrZmk4N1ZyVFZKeW8yMXdEVk93NjdU?=
 =?utf-8?B?TGRSOFRQSFJaZ0szVlpwR3VKVkM5ZzVkcCsxeTlHVm1tNnVUWndaZ3hZUFc1?=
 =?utf-8?B?cnB3Z0JpSWVrME9kK1NrN2hzQUVpdVhuN0QxK3F6Qm9oRVF5TTZUZ3hlVXRU?=
 =?utf-8?B?RFpKemZjUHluZk00bS9hazVibmViazd1Wk84NE1MVTFKaWVnODA2eVREZFlp?=
 =?utf-8?B?MEs1TytJNlFVNjNqK21tcG9jY0F5ekJvSjZITDErT1JlNE1uNnlIU1RsdGN0?=
 =?utf-8?B?VkZ4dGszd1k1YkI0OHNTa1Vwak5RUnFqVmZtMExzeC9adlFFajNKa2Z3UGQv?=
 =?utf-8?B?MHllNy9WV3NTS1FLMGFvVHE2Z2lWcU82MnRJUytNdld2QjNzUjZzUXZnNFk0?=
 =?utf-8?B?cHdaK2tXVlJGcE5GUnZmQ0ZSVlVDMDVjdGxwNXg0SFRBeUwxeU5wNnNzaEFa?=
 =?utf-8?B?cWVPQnlZODY3cmJCREpjdGkrcW5hb21HREpnZ0VFNU9wTU5QVVJlWU5CWkIv?=
 =?utf-8?B?bzBGMGUyb2ZTMEc0RE5ab0RIdG9Fa2U5TzBUSHFhKzlTcHVjak1rN3ZvQndX?=
 =?utf-8?Q?6TdyhrAiQUsvnnG6syKaI2nF6?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 93200ded-cf6e-4278-f6e0-08dd68d9aec0
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6583.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Mar 2025 00:37:10.7223
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8ErfEEAXmrcT9EmMzoLMc+hGjGtMmatS4YKRHvyA55kV8BNQJoGAza35HB1hFg4l5KARAgtXJuhm+b/erCpp7g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9210

On 3/21/2025 4:50 PM, Jason Gunthorpe wrote:
> On Fri, Mar 21, 2025 at 09:59:32AM -0700, Nelson, Shannon wrote:
>> diff --git a/drivers/fwctl/pds/main.c b/drivers/fwctl/pds/main.c
>> index 6fedde2a962e..e50e1bbdff9a 100644
>> --- a/drivers/fwctl/pds/main.c
>> +++ b/drivers/fwctl/pds/main.c
>> @@ -76,8 +76,7 @@ static int pdsfc_identify(struct pdsfc_dev *pdsfc)
>>          int err;
>>
>>          ident = dma_alloc_coherent(dev->parent, sizeof(*ident), &ident_pa, GFP_KERNEL);
>> -       err = dma_mapping_error(dev->parent, ident_pa);
>> -       if (err) {
>> +       if (!ident) {
>>                  dev_err(dev, "Failed to map ident buffer\n");
>>                  return err;
> x
> err is uninitialized, it should just be -ENOMEM I think.
> 
> Anyhow I fixed it up, please let me know

I see them - works for me.

Thanks,
sln


