Return-Path: <linux-rdma+bounces-7754-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D331A3519A
	for <lists+linux-rdma@lfdr.de>; Thu, 13 Feb 2025 23:51:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ACAA43ACF43
	for <lists+linux-rdma@lfdr.de>; Thu, 13 Feb 2025 22:50:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C329824BC1A;
	Thu, 13 Feb 2025 22:48:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="N1D7eyE/"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2061.outbound.protection.outlook.com [40.107.96.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA99027541F;
	Thu, 13 Feb 2025 22:48:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739486911; cv=fail; b=RL7a7b5P2FpRLqQfVssu4JZ9kZrIjS/e3YYuZy1hs92vg/f79dMOSCcHH6VRjCkv8lVpXySFegLBjWHMnfBkzdkpsN8/teLE4WgwyD+IRBCWRT8nci/+uWVr4Jenb9k0w5Jb9lHjqhC5jetl73N53z2ChpmlT0rVnCL4ZOGTP70=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739486911; c=relaxed/simple;
	bh=wVE6/Go4tTDDvsRlXccjM12HQ1C+tORkqdtaTEL0c9I=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=iyP6VKuP/j3WFmTey1O1SNKM/t9zDliXIhVazCkR41Y2QkkWgO/n4mgi6DZAKg7V2vLOe1vFmoAUA2gIxsB7y//qo6LtWYvurWLXNi7kjgjyD95ycBgqWq6rtIMOQcmDYlPg5whxi5OfSNzgO6gAm5RTzbOH62PrEpiUjAk+I4E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=N1D7eyE/; arc=fail smtp.client-ip=40.107.96.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IieGHb1J9nO7rnqOq/nLaWyFzzja74+A4hmOgC8Xzql9hm1+4rFfDP/eZftf2Udl0UgH+94qC0jX7bZN24Axgd4BlKiDAwgH1fkEqwQrzan/25Au1C73XwGDYHgr3MsoCPbsb1GRPidMReWXnzDvz+K/nPD4Y4YzQTB4IL3fDkMhRH6y8gNGtPhj3vfz4je195PjIYFxbqTUUiXvS5J3Fea+Is0goZyGLDhC2bg9HExb4qeqsS1tF3RP17NO2tDPQS31kRo8iBKVeUvG7vXdi1adloMB7skMlZYDVW1e9PitxfOVRv+ok+9vZ1zUHPCL9tnhNgkVvR1ylb3mwljlqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gUsuIEkCnCbWyRoQaRVgJtXff1hLZKMXgIj8T0HolBg=;
 b=XTUUza315bl0ypbsYbV66g4bmXLM70OvDs4OcR3T9s0hg2oOBE9QH9d7wOsfJXdk7Yv2U7QArFu9GY8O1wemAhUAhuBCK4hyEHOPZz29xSnfaGaLROmyjw7WvlUhVFHBR4rVbV8k82ieBIKIgj/ICMHICSE8qC10GfyZF2b4CJTi3J7loz4mHj3dw5i0qTuj1j9u1JbzMF7bYBp0b+f91Q6Sq3fumrtil841siFD/g+cQszllPa1e2CPJ+5cU55V/TmG0IORUHKPxez0K1SCnnTxri3OzbIWEP/XBHJZCD5u2vA8xgAf+z6lmyITnXmBSiQqtkMM8CnUYMzf/vBIEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gUsuIEkCnCbWyRoQaRVgJtXff1hLZKMXgIj8T0HolBg=;
 b=N1D7eyE/CdRJfKsg9MG73RRJSnQjOCPGCz5P+iZgB0PdoyrpM19No2fF2O7bT/nj8b9c5jsTQP4LPyi3o3PXC4iUDrZN9ByFIpi3UvjNv+OJg6OHQbxl2uhXR2pewU9KBRnN9e5wL6ZcbIlSoSy9vRvbIREm/jHFI1WscAxQySY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB6583.namprd12.prod.outlook.com (2603:10b6:8:d1::12) by
 PH7PR12MB9201.namprd12.prod.outlook.com (2603:10b6:510:2e8::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8445.11; Thu, 13 Feb 2025 22:48:27 +0000
Received: from DS0PR12MB6583.namprd12.prod.outlook.com
 ([fe80::c8a9:4b0d:e1c7:aecb]) by DS0PR12MB6583.namprd12.prod.outlook.com
 ([fe80::c8a9:4b0d:e1c7:aecb%5]) with mapi id 15.20.8445.008; Thu, 13 Feb 2025
 22:48:27 +0000
Message-ID: <16653a95-7f87-42d5-afa2-fd7e8877553e@amd.com>
Date: Thu, 13 Feb 2025 14:48:24 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH fwctl 2/5] pds_core: add new fwctl auxilary_device
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: jgg@nvidia.com, andrew.gospodarek@broadcom.com,
 aron.silverton@oracle.com, dan.j.williams@intel.com, daniel.vetter@ffwll.ch,
 dave.jiang@intel.com, dsahern@kernel.org, gospo@broadcom.com,
 hch@infradead.org, itayavr@nvidia.com, jiri@nvidia.com, kuba@kernel.org,
 lbloch@nvidia.com, leonro@nvidia.com, saeedm@nvidia.com,
 linux-cxl@vger.kernel.org, linux-rdma@vger.kernel.org,
 netdev@vger.kernel.org, brett.creeley@amd.com
References: <20250211234854.52277-1-shannon.nelson@amd.com>
 <20250211234854.52277-3-shannon.nelson@amd.com>
 <20250212120239.00001f0a@huawei.com>
Content-Language: en-US
From: "Nelson, Shannon" <shannon.nelson@amd.com>
In-Reply-To: <20250212120239.00001f0a@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR07CA0036.namprd07.prod.outlook.com
 (2603:10b6:a02:bc::49) To DS0PR12MB6583.namprd12.prod.outlook.com
 (2603:10b6:8:d1::12)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6583:EE_|PH7PR12MB9201:EE_
X-MS-Office365-Filtering-Correlation-Id: 38835208-2156-4c04-67bb-08dd4c80879f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RUhybXFWbUtOTFJZRlZwVVJiNmg2T2xlNE9IQUk5dW1rU0xNMC8yV3laL3dz?=
 =?utf-8?B?ZHdHbC93Rzd0eHdWOS9WeDVXcHorc012MW1zSjRDcndvQ0dUelgydVJ2WW9a?=
 =?utf-8?B?OUZjKy9DcTBMKzQ4bFdOdjF5T3pwWkU5T25oRmdWaUNlSU1oZWtnVnlZalJE?=
 =?utf-8?B?K1dNdm0zdUNyWDBRSU1sL3phZ3V2bkkzTU1SUnBJOUxnMDlVQm4rT3gwUUdU?=
 =?utf-8?B?TEVvT0piNTllZVZ1UmYySUFnbk9QZHpnd2ZsRWtydGRpT0x0bXA4eURXbDZY?=
 =?utf-8?B?WkpqdVY0TmJEbGY5eWFpSEJQN3NWTkJKSE1zckZiT0xiMlFmRy9CK21kMEZB?=
 =?utf-8?B?bWtaMnBPR1l0ZmZsSDQ0MU9iYm9ZenNyVGFJUkZacWNySFFOZFZDdTByWWNQ?=
 =?utf-8?B?SFkwbDEyQlNCb3ZJMWRERUJiamRXNEhQdEJYKzA0N1RhOCtFL28wRDlib0t4?=
 =?utf-8?B?NXRZMGMzVEdzeFpkTjd1RURJRWdGekdLUDhPUjQ2TjNKUnZWdVcxNzBMeVVK?=
 =?utf-8?B?VWpHR2doM2VVVlQrVmlzUnRjYjREMlVFZGRVcHp1M0tWNnZJYUNpQ0NNTmw5?=
 =?utf-8?B?NTBXblBUcURncEFsWmgzSXp3dVZhZnFFVVBQYjRiTFE4RHkwNHJUQUtUS3dL?=
 =?utf-8?B?Rk1yRm56Ykx6amEzbkptN0g2T240OG9qcmNsQ1RCOEJTMDE5bk44SFNTTXd5?=
 =?utf-8?B?Vjd2NEZrbHllRjlUNGVWUnR3Nlc2MU8rMEErZTVhNDBGejdFR1VSTWRpL3hO?=
 =?utf-8?B?Zjh4YVlwWVVidVlJR3Q4bFgweWJ4OHQveWl1M2lYbmZodmxoVE16Yk5UQmZm?=
 =?utf-8?B?ckVDWnhzSjdCRlB2emZvcmVvY0RyL0JEZUVUOW92SUNWK09lOUt4V0dtbWV4?=
 =?utf-8?B?T2V2TU1wTHhHNUhJQVRWSUtuUDBIb2F4Q3NzaVFjL1ZDT05OQ1l6UTdZZEdK?=
 =?utf-8?B?VkgwUXhXdEpPQ3dyK3JqWUVTRnFQdXg0dUJQQzdWV0VYYm9hZkZLdEo1Qmtk?=
 =?utf-8?B?V0k2MU91bTByWGVlK0ZReGxyMjZCMkxIUDAxdlVDSkkwL0FoN1ZHOVYySDBx?=
 =?utf-8?B?UjJ6ZGhGQy9RLytQcUhxcjRGSXAxQ1RFNW0xVytFYkw1VnUyeGp2enRjSitj?=
 =?utf-8?B?UzlUVWJWaGZ2M2Q4cG1BZGREVmVYVG1WbzNJN09WcTJ0V2RlY2NQdFhWNU05?=
 =?utf-8?B?U0ZDSWdZdnIrWUR3TWFXWnFWcEk2cjhhcExVM25tNXlCaW8wKzJiUktRT293?=
 =?utf-8?B?UzRIMGRlaUZhRm9qM284Z0tWZ3ExWWhkNmx3YjhjVTdnd0lzR01vT1hCQ2tC?=
 =?utf-8?B?cVFLVFVhejQzMlBhaVlld3I5aG5iTWVBaWVNeUJkUzVmbmVQYmpDSDZBQU5F?=
 =?utf-8?B?M3cvQXJsdkVmUmllejAvYnJwalEyWEVuNmdtTGlONlRBSHZDU010OXBFRll6?=
 =?utf-8?B?Vm1nZC9CSkJhWkwxWURjSStYRHV4cmFqcURMUUJOTjVVVklVc3Y2UUJTaFNz?=
 =?utf-8?B?RnY3dFVFQTFUU0kwVDhXN0plcG5kRkwzWllXMVhUYzlUeDRyY1JFRmVBZVgz?=
 =?utf-8?B?Y1BmVVo2NTVSblZzenkyZUEwNk1jZVA1R1hNWW9VTmZYYThab3dIa2VVc1Ru?=
 =?utf-8?B?MitMTkxJWmdCTmlhN1RCTVZLVDMyeXZORHdYbTRFVTZVSWFhUmw2OTJleFgy?=
 =?utf-8?B?bUxuRDQ3eVdCa2Nsa1dJT2paLzdyWnJMQXVqdzVCUE5ZeDZuanF4OUViZVo3?=
 =?utf-8?B?R0lTVTA5L3U2cDF5NkpOaEZFdTVCcWdlc0Y1bnJxMGY2aUI4NUFzVGJSK3NM?=
 =?utf-8?B?WFBHT2h4a1I1cWZNYUNyb2xFREp1ckVOTWtLeGNSN0dwTE56ZE90RCt4Zk5B?=
 =?utf-8?Q?wwYoZbSSQFDFS?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6583.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SXVnVlRUNG01VjlNdmpzMEdHRjJ5c3I3Qko3SkZ0MkwyRTJPTDExbFFNamZH?=
 =?utf-8?B?Y09LdkN6MUl1WHcwYWVaNURkcWxrNzZvK1VlWXlGT3ozaHROSmtkWWYvRDhX?=
 =?utf-8?B?Y2xWMTBLbTkrc1lPeU9OSVRJMzM1VzlGbDlOaHpqcFJKQXlIYTdUVml5a2tu?=
 =?utf-8?B?K1Q0MWJrRDJGWi9XVS9La3h3TEl1L2tqRVB3K2tiUFR2ZExEWDNobDdaakZE?=
 =?utf-8?B?akhBa0VObUpJYjliMERPZTd4QURSbjlQQXVKc0t6WjNiQjFUbTdGTmRlak9Z?=
 =?utf-8?B?aEg1Zm9nUllaaVZ0VFY2K1ljTXNKODN1VGp4OTEwOHJ1cTg2TnlWeVpSYkRj?=
 =?utf-8?B?SS9OK1NVQ3Q0WHNNVGFscHVEMG5HbUJyYWlBSDQ2YTg0dUtTZURzWXVvQ01Q?=
 =?utf-8?B?cXF4MlNjN3dVZnI1Q0pVSnd4ck9DZHdvbGR6aEQvaFFtc1pSUnFzb01YOTJE?=
 =?utf-8?B?T0dJSnp0ZTFqa08ydVhPK2dsT3lzMENFa29OUklLbjdZUTFEVXNXV0hXd2x6?=
 =?utf-8?B?K3AxYkdqNENCR1RQWjdMVFBaWnRCUHZCSk82VFhkaFg0aVlmN3hkUjlyVW1M?=
 =?utf-8?B?R1V3YjJCanN1Q3hSOHlDR2FIT0hYQ29KMEUzbGtRNHB0Q1RSMCt4dG5HM3Rw?=
 =?utf-8?B?b01rUEdsRHEwYWN0N001WFVFNy96L256NnplSS9INEoxYytEVmw1blNXNlpY?=
 =?utf-8?B?enhZUU8xQ2JiVXpBRmxZTGMyakNKNDlsL0Q0NlJmZmtYdWxrUjFIaXMzZzQv?=
 =?utf-8?B?ZTdIQ3BPU1FCcDZmOXVSZHBhMkdoZHIyTndVc0IzaHJYc1JlbGljOHJkQTU1?=
 =?utf-8?B?bEQ4K0g2TVJJUkE3b0VDcVZaQkIvQTFOSnB1Uk81WVpKTmlFS05sS1doMmd5?=
 =?utf-8?B?djJmYlVuVXlJdTdjTVUwejhJMGlMdlU1VDJudFpNenJCTk9hVXkxcWZOR1Ex?=
 =?utf-8?B?WmUxZ2VLK3Fhckh2YnZCbDFTbmVjTGYyNmlCZ2hRY09ua2VuTHVhWGQwTTU4?=
 =?utf-8?B?RnYvQ1d1TDR1SGZGckdPN1ZUeDd4dXpPS0t3TVF6M1dnTEhhNnA1TW5SU0tN?=
 =?utf-8?B?N2xGaDZQK2loZzUxNjJNN1NYbjFOMU4ydE41V24yVWRzMmlwc0FyZWpQMWZn?=
 =?utf-8?B?TUhEOUxyajFGYXpNU0pnR09QTS9adUJYWnNaTytDZmN2b3U4RHFHUXc0UWps?=
 =?utf-8?B?S1NIMm5KZVl3SVVNeFRDQ0xyWXc0ZkRPZWxRYkErTkRpeHJ6TUhncktmUkkr?=
 =?utf-8?B?RTNLQWJka3pVajUwL3V5RSsxRjNJTnpDTmRyY0FobE9hK1BxUnBtMmxtYWRC?=
 =?utf-8?B?S2NqdDFYMGJWMnJodHJ2Vmx1dTM1YWdiZWdhWTNPS1FZbHNlcGpJZGZVUVVh?=
 =?utf-8?B?SEY5RzkrZFlJZGQ5aHR5WkpzZTFXdnFpbFhuMnhpYkhrOHRXOHhrVExreDdj?=
 =?utf-8?B?czZvaHFSRDBWRm0yWFh6ZVJTWTVFUTdNcTJIVkprVVBOeUJ3eWxuSU16ZXpE?=
 =?utf-8?B?bUkxUXFCdlhZWGtPRWxTR0pyZ1pzM242WG9DbTNqUjMwZG5yZ0ZQOU5UNHZo?=
 =?utf-8?B?c3B1UHB3UmpQYXJpUFhFTmZ6cHN1Z0w1eHhyNS9kSDBCNVkrS01xMjM4SzNp?=
 =?utf-8?B?TnNJaGpRekpHU2FjQ05JTVd0eHFSd3huSzlPTVFTTExTRGttV0EyVElYMndQ?=
 =?utf-8?B?eFVXNjNxV3BINmhJS1ZtZVZaQi83YisxWlg4TjhHemR6Y2VYMklPRlQvQm1p?=
 =?utf-8?B?MzY3Vm9pVkZFem02UnRNRzllUTMxNEdiRzM1ajQxZnN6cmU3OXdScE5SSjNu?=
 =?utf-8?B?MTNDQXNjTlVvZFhIRVZNblhOSzNMa0ZodzhUOEpLQjFjK2xJR0haekNZWWtP?=
 =?utf-8?B?NlA3MmN2TnE0SWhPTHFFS0tqM1ZsSmFXYzh2ZDRTVE8rTUxjbExzWERRUERP?=
 =?utf-8?B?VzY3dUp1QUd6czNJWWhhRC9ramFoMW1PTVpDMUswbVk1dEpaWnJkQWUyWUdz?=
 =?utf-8?B?RUtXNmRsYTFaUjdHdnpnSURsY2JHTlMxMUhXM2ozYk9qTjc1UU0yekhUSkRx?=
 =?utf-8?B?bFJXbldleVgvNTJZdERQYi9YWmEwUHFpYUkvMzZKSXQrbitWa2g2QWlrc204?=
 =?utf-8?Q?+Z3Up/M4J+pg4heBUpoKAmxCa?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 38835208-2156-4c04-67bb-08dd4c80879f
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6583.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2025 22:48:27.3186
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JPi1pImtD43cZSAreG3NJyIO5/ujkcds1+QzEzwVaj600GOGabxBQ/+p4CY7lQ0dkgAdJe4vJA6y3fXKgBN0Lw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB9201

On 2/12/2025 4:02 AM, Jonathan Cameron wrote:
> On Tue, 11 Feb 2025 15:48:51 -0800
> Shannon Nelson <shannon.nelson@amd.com> wrote:
> 
>> Add support for a new fwctl-based auxiliary_device for creating a
>> channel for fwctl support into the AMD/Pensando DSC.
>>
>> Signed-off-by: Shannon Nelson <shannon.nelson@amd.com>
> 
> Hi Shannon,
> 
>> diff --git a/drivers/net/ethernet/amd/pds_core/main.c b/drivers/net/ethernet/amd/pds_core/main.c
>> index a3a68889137b..7f20c3f5f349 100644
>> --- a/drivers/net/ethernet/amd/pds_core/main.c
>> +++ b/drivers/net/ethernet/amd/pds_core/main.c
>> @@ -265,6 +265,10 @@ static int pdsc_init_pf(struct pdsc *pdsc)
>>
>>        mutex_unlock(&pdsc->config_lock);
>>
>> +     err = pdsc_auxbus_dev_add(pdsc, pdsc, PDS_DEV_TYPE_FWCTL, &pdsc->padev);
>> +     if (err)
>> +             goto err_out_teardown;
>> +
> 
> If you fail after this point, do you not want to remove this device?
> Also superficially shouldn't this be goto err_out_stop? I think
> the call is just after pdsc_start(pdsc) though maybe I'm looking at
> an old tree.

Thanks, I'll fix this.
sln

> 
> 
>>        dl = priv_to_devlink(pdsc);
>>        devl_lock(dl);
>>        err = devl_params_register(dl, pdsc_dl_params,
> 


