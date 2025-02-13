Return-Path: <linux-rdma+bounces-7695-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A4F57A33584
	for <lists+linux-rdma@lfdr.de>; Thu, 13 Feb 2025 03:30:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6A6C57A2542
	for <lists+linux-rdma@lfdr.de>; Thu, 13 Feb 2025 02:29:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 974BA20371C;
	Thu, 13 Feb 2025 02:30:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Tgm+Hml1"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2048.outbound.protection.outlook.com [40.107.223.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B92A35949;
	Thu, 13 Feb 2025 02:30:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739413849; cv=fail; b=L0G80zEGgFqD58WIT527EykF5KMq47vzTnHDvEowsP7NtV6F8UvW7/z0D9Sy9ctojO7LTmoDZryTKGKA9AHnh2dLBI2g2Nz8eeCpJOV/l96MC+2MnhPWfm2DP7glsAXgB8Y7GC4kByMfhJiCCvreG3qj0UstzoPwFeVh+vmTiUE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739413849; c=relaxed/simple;
	bh=Tjd9I/GWPYNzj2kdlD3OmwNtmOFC7HLm44TabC5Y+04=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=uRVgq2ahhNB3E9+kiv7YhY3JZi/T4Rk4EnC5FrVxeAIZCuVjXHxpUROCFzRDndK4HUV+HMwLbpeTzFPcBOUaGIHZrPjcATQIpKjsyH58WCIGFYYxfEd0t2yn69WvPIVuwmG3ZaW+/6bwA99GNRCg+7vJ1ugN6vfxOWcokHWr0Tw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Tgm+Hml1; arc=fail smtp.client-ip=40.107.223.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VtMB7Jf7DDT3lNuJM/KTEC+jUeeLNTdphhSo2tr3usjcwg3BFRehS3mrc67/tw5BmChZPQt/2uCLqwv+zFDfhgPHeNOGwbkCghi314G48hDIh/EEKkxtEiwJ1/xLgpFbUH5kEGxdFudypH5WCGBi9mFUMVBkhg0tRadnlqiKbUcN579kjU2LxILg9ns+IeiewYn19aD+J5/HCUail3VGo4HlYjStfCdMvvB3BY21h6vvgLBB1WTESEqghqjgCn0TeG7kwPvLBq05NexkpiNBi/wTQVccaNOI3GURI1mpjAtpjDOkAoLcAr4FrXyPx57SytXV7ECDA6sXnxTtQKfuJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lbLWuxLPK155vpduSfyevOEUPs1kpXzrme4WSs7wD6I=;
 b=KTKCMUwwEJibcGPma/xNzjNaBL+M93piBwaGevqveuDyGfnw8CgAGNxYXF0OBazBF9RfEGfS50dev2aQYgRCcGGDv2SYw/YNl9qPVRFL0gbA1z4HJnDChn0mOsMEH44ooS7pCQpSHl+efmq0cr03QilB2Y34PNCXeTRuJGJAJSl1CPuIUzLJhAh8F8d1fWGubmpH+7sPLQUS1Ur47wLwwJAiklcZDmpPgx1KNJCHSQi8j4dTtHTU3F35vWxlaOet27Vlo3jFvmg1trs/6csn/dF6sss8ll5pmzw2nbU6M3hhZaRLU2eqhzhq69aA0ra9Wv2eWt5hiEtjWOYAPQ++gQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lbLWuxLPK155vpduSfyevOEUPs1kpXzrme4WSs7wD6I=;
 b=Tgm+Hml16x+gfh1+LEDfmSCtOXc0d/S0HqY1H+mvRg6V8dzy55rX22pYgz8yn9B/y3uEtP8g8y9NjUvQW0BIh3vommo4kZ2RMQSjDaVwB++OxzZ0beHTpgJnbcL+m8hoCOlCIrmYx17hJIBX0O9HpE9DR9VhAe+T9QG1pwSnQ0M=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB6583.namprd12.prod.outlook.com (2603:10b6:8:d1::12) by
 SJ2PR12MB9086.namprd12.prod.outlook.com (2603:10b6:a03:55f::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8445.13; Thu, 13 Feb 2025 02:30:40 +0000
Received: from DS0PR12MB6583.namprd12.prod.outlook.com
 ([fe80::c8a9:4b0d:e1c7:aecb]) by DS0PR12MB6583.namprd12.prod.outlook.com
 ([fe80::c8a9:4b0d:e1c7:aecb%5]) with mapi id 15.20.8445.008; Thu, 13 Feb 2025
 02:30:40 +0000
Message-ID: <346ad61e-9cba-4915-8748-0b8119358d7a@amd.com>
Date: Wed, 12 Feb 2025 18:30:38 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 00/10] Introduce fwctl subystem
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Andy Gospodarek <andrew.gospodarek@broadcom.com>,
 Aron Silverton <aron.silverton@oracle.com>,
 Dan Williams <dan.j.williams@intel.com>,
 Daniel Vetter <daniel.vetter@ffwll.ch>, Dave Jiang <dave.jiang@intel.com>,
 David Ahern <dsahern@kernel.org>, Andy Gospodarek <gospo@broadcom.com>,
 Christoph Hellwig <hch@infradead.org>, Itay Avraham <itayavr@nvidia.com>,
 Jiri Pirko <jiri@nvidia.com>, Jonathan Cameron
 <Jonathan.Cameron@huawei.com>, Jakub Kicinski <kuba@kernel.org>,
 Leonid Bloch <lbloch@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>,
 linux-cxl@vger.kernel.org, linux-rdma@vger.kernel.org,
 netdev@vger.kernel.org, Saeed Mahameed <saeedm@nvidia.com>
References: <0-v4-0cf4ec3b8143+4995-fwctl_jgg@nvidia.com>
Content-Language: en-US
From: "Nelson, Shannon" <shannon.nelson@amd.com>
In-Reply-To: <0-v4-0cf4ec3b8143+4995-fwctl_jgg@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR03CA0002.namprd03.prod.outlook.com
 (2603:10b6:a02:a8::15) To DS0PR12MB6583.namprd12.prod.outlook.com
 (2603:10b6:8:d1::12)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6583:EE_|SJ2PR12MB9086:EE_
X-MS-Office365-Filtering-Correlation-Id: b72272a0-6383-4e55-5185-08dd4bd66884
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?QmhaSDRjQlpER3gzWXZUcm5nZ240NXpIbDNHWm9VSUg3ZjcyL29wM1dqVnZ6?=
 =?utf-8?B?SkhvTFR1M2tEWjlkYVkwL1hHWk04MG54aWZoRDB4d2paVUU5blJGVHZBSEpL?=
 =?utf-8?B?MklteWtzNWFTWUdFUGRZOGplY21CcERDUkpUWmtWUDNpejdUaW54TDVCZC9R?=
 =?utf-8?B?S0VtUFNTeCtQbVRtZjlBZ3NXWXFUdktBWlBFbGpkaU9paENlYzUzTUlaQXZP?=
 =?utf-8?B?SWJ0ZEp2YmJRMlpUS0p2T0R1L2NoQzFHYzFDYkliWGJGVWEvcVhwRncwaUh5?=
 =?utf-8?B?VzVoQlR1a3pOVFlwS1NDRXV0UTJFczNmdEd0Z1ZHSUdJaU9YRnRyU1k2ZGpa?=
 =?utf-8?B?ZDBnK1U0Q1dBdGJaSUdrK0N5VWE4TGp3VElQaUpBRmJWbVR6UlBXMnlySFpI?=
 =?utf-8?B?VnZnM1Q5V3lNMUFqT1VHc2ZMbUVDcmF2QkJGbDRvUmVDd0NBczRxVzh2UGVk?=
 =?utf-8?B?eVZlTGR0NU8wQjBscFhaT0dhZ1JUTmJCazdwS2dpWWU0Vzhsbk93YmQ3Y21o?=
 =?utf-8?B?QmJiRmo0TzhYNnlrRUhFN1gwVzlwNGNkSFoyaGNkQ1g2SElYZVd3WGxGYUcy?=
 =?utf-8?B?enFMb1plQTRSSXZmeWpwcldiTlEwZ1lMcm9INnNTdE1mUHJZMnFqQVFtR3hm?=
 =?utf-8?B?RWFqckp1V0NjNzFRUEdseW5lS3hHSkpCK3RYWThLdFo0MHkxK2YyWGh6TDlB?=
 =?utf-8?B?dnZ1S2pLNDlJTGgxVk5kYVFNZHgwVjFTWVU2MG9neTdqa0N0SWhQUVdOV3E5?=
 =?utf-8?B?VnlZZm9saURGaEd5TVJSSUUwanB5QTJMS1hLSUhDcitWbUVWcEJJL0huY21p?=
 =?utf-8?B?bHcxYUdrRjhXSExSZUZTbDNwQkJFam1ycW5MdW1abXMxbWlVdktaSUFla1R5?=
 =?utf-8?B?QTN1Uzg1YW81SjRSa3lzcjBRNmF3QTVudk01cjdBNmxvM0FXQkZjYnl5TUU3?=
 =?utf-8?B?QzZ6RkdhN3lhMHFCdjZ3Zm5qdXRuSFlCOHVLdmNzdUlqMjVrOGtKalhNWnM3?=
 =?utf-8?B?UWtjRWQwVVAzL0JXL3JkWVJzK2NiR1phdlcvNVJsdE92TVlseWVxaGorclk3?=
 =?utf-8?B?c1lVV0NneDNvb1RrV2xQUUVpWU1hOXRHSlMvclkyZEZmWTJEYVl3Z2lRajNx?=
 =?utf-8?B?N09vVTloRzdzWTN1SHFBcWxyTmtNdG1xQlc5cXh4UlJ1WXpLemU3c3NzM3Vz?=
 =?utf-8?B?ZHRwK1RnZTlTTWdHa3FJcjU2R3dhVythendUc0V0bjFSWHZTYjRTV1hLeTli?=
 =?utf-8?B?citBT0VOT0NrQjlWdG1kbXB2NDNyTlcwbnpGUXo2ZjRodFlKT0ZSbnB5SHhp?=
 =?utf-8?B?UnRXNlQ0b0hLbzREYzF5Q1k3dEJUaDV3Nkg5UWNvTmdjUFVTem4zN1VScTk0?=
 =?utf-8?B?QTVrdURtcjNycjdPd1hWK0phWitseThDUks4S05QRko2dlBOMkc0bW1xZklE?=
 =?utf-8?B?L1B1N0FWWmZTTURpckM2bmI0enhaekgvUWtxY1lSOVJDRUV4a3NlWEFraTNH?=
 =?utf-8?B?ekNMV3lqNEhFNXloRzdXeWNPYkNPTFlsQVkzSFZnQm1Lcit6bHJjKzJxdmF1?=
 =?utf-8?B?MGFGMmQ1RytWeWdaVVVETUQ0bzJLaXlrRFhPKzNLdXFmNGJQcXMvSDVnZ1Jm?=
 =?utf-8?B?VjVNSGVpcWE3Sng1U1FCcXpjOXRFNWRnbTNhdW1WZ2dHeWxCR3Y1TVpoakpN?=
 =?utf-8?B?dWo3OFR5NjJoMzBaREQ1R1FaOVdSSlFVb1c5OGt6d3B3RUJjZUR0WnRSOHE2?=
 =?utf-8?B?SEFDaUw4RzFQSmV5QVlJR0o5MGI5TXFNN2JBMVVLSUhDWTRUQlpqeG45Tzdx?=
 =?utf-8?B?cmpidTQ5ZVRvMEtKRGJRUT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6583.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dVFMN1VnRXhPV0lEc2J6QkcycTRGTVFCbmVRSTd5L05TZFhCSC9QWnNtY2xQ?=
 =?utf-8?B?QWRTSXJja2tkWFVsZS9zSXgyWjhZMzlDY1hoL3VES2lTaXI2aFhqd214U1pp?=
 =?utf-8?B?WThFZDdDSjBobk9WYVFVbmlFeTNZK29UYUdMNmJmeVlnQXhNUzN2UmJYK2dF?=
 =?utf-8?B?TWNsRUMyTjRacG5QR2l3OVN4VGl0ckRqaUNLVlJHdzZNUUFGS2RpNkJrQTY2?=
 =?utf-8?B?M21yc3Uyb0FUSVlBRjlMbUJISnU4YkIwL2NOcDRTRlJ6a09Bd0dYb0JPUWk4?=
 =?utf-8?B?aE95d2lNVC9zMy9VdVpMWDRMR3hVdUkzV2FwWWdOTzU4MWlEUXRxSkU4b1RC?=
 =?utf-8?B?VEFJTzdOVm9HcjR3aldkMWtBbThwTTYrc01yNi9QcTZPUWVsR1VqS2ZtV0h5?=
 =?utf-8?B?ak5vOVlUeDRFWUR5dzE2VjlRNWN4cDNUcTU3TG9yVW12eWpDcHNFSjZ2U202?=
 =?utf-8?B?SXVlQWxBVndaN25uS3N5c1F6UEdNQWtwT205VWlKUnZOaUJOdXU2R3FiV0tx?=
 =?utf-8?B?WGhKYUhDVHFDWHQ2clBmSTJyWGZydVBybCtzdk9BZVJ5bDdwSkR4NXRyajFq?=
 =?utf-8?B?UjNpeE9BSm5JS0hueXZQeFhScEhZZ3ZIVjc4YVZzVzVuN2xPVVA5WUZuQzBM?=
 =?utf-8?B?Y2JvZ2hWZDRFQnNHdG1YSFBGTU15aDBvU1krQ0JCMWNFZzlxTnQ5QndwRFpl?=
 =?utf-8?B?ZzVKb21ka1FpYkdMWXV3dVIvYnpnRkVYWlZieWdzb0pLY0llUHBHNFkwckF1?=
 =?utf-8?B?NVdLY2RMMG1RWXVCWWZPaTBsY1R3K0haUnFLeFBlRnM4RHZOakVCK0h4bkdC?=
 =?utf-8?B?aVVDWnZJbGY2cS9FSzZzZGxITjJ4R2lIMW10NU1uNGJtZG5NM1BWVjNmZjhK?=
 =?utf-8?B?WmdaR3lxNThVZkI2ZXJxaElYL04zWUE4djBXbmRybGtLNERkV0dPNHhzc0Qy?=
 =?utf-8?B?RzV1TkJldU1KeWhwSXBzV2U0OVpFbkptUUVGOTZvZDlLUDByd2Y4NnByTFVP?=
 =?utf-8?B?ZTJNSVZ3Sy9DZW1ZTzBVWHI4aXZyUkVldGw1ZkVITkUvcWRJRkRLeldoR0g5?=
 =?utf-8?B?MTMrb1NJRkhoZ3lCdllSalhUTDBPc2FlQUpIK04xYlB0SVRDcE9LREp2cyt1?=
 =?utf-8?B?ZXhlWFV5MXdFam9rUS9OUGpTdFQyYnZOblNqU3kwMmpqTTV4RWcrMkphTEhW?=
 =?utf-8?B?ak9sang3dDhIU3ByTzdkcnNSK2JkRVRld0twVjBNQU1SNlZUVzFibis5a0tH?=
 =?utf-8?B?WDhHaHZqTkZxUkovRXRyemhJMk4ybU81QVFWR0dYQVVpVVltSU5OM3FlN2M4?=
 =?utf-8?B?QlF2eWx3RjJka0hqUHgwTHJTUGZIWTRnQVRTZXlEalEvV1FwaG9hUHRFYWNT?=
 =?utf-8?B?aE5oSjRXNlZyWjFWK3NQYzBRaE9ncmk4SzZxdVgwMmtQVGpneURjbWVadVpr?=
 =?utf-8?B?R0tSS3JURGczTkVyWGdMMnpaVTNLNzQzUTdrK1M3aEVReGx4LzNZNmkwMUEr?=
 =?utf-8?B?RnRlMDk0dTg0WG5TaTlEQ3BnM0YvZmFaZUt2disvVzRobkZKdFNadk91WS9l?=
 =?utf-8?B?QUpER1MzUWVOTTZqZGZCQmhVMHJaVUNOSHpidGdtN2MvVlJZeU52cS9xZVU3?=
 =?utf-8?B?NHpOQ1BuSWVPZDJtS3o1YmNmVVNEcENpSDRsNjlzOGppb3RXRk53RE51Uk9p?=
 =?utf-8?B?U0piMXYzYm4zeS95ajJjVWRPN3NpRWJOMURMVTlqNU45SnM1d2hrYzl5TWRR?=
 =?utf-8?B?SG1nTG16S0V2RVFBMG82cnpUVXUzT1pqQytlS0xCeGNZeGt4NGhkcmk0MjFL?=
 =?utf-8?B?RzVaRUJoMTE4RlYxK0FqTmhrUm1VRThiK2VGakhBZlQyUmlSUlZiL3VlZEZ6?=
 =?utf-8?B?TVljWklYZHVzdUJvQXNJdHJkUzJ3c2JKRGJBNVVOeXZaZ2FKSUtqajBsSWM0?=
 =?utf-8?B?S3dEbUFtY2JIRWxRNlZ5aXVQMjdrL1IvVXN5TzVMSjlHVlY1eCtpOVZjK2NR?=
 =?utf-8?B?OHcyRmdTQjdwMG1XMHA4WUo5UzRFeFZWcDZGdThzZ2hFblFkWmNteTVpS3o2?=
 =?utf-8?B?NmgzU2lHNzFiM1hGdXdaWHlsdHhBRUFjdVdHbUszcXhuN2tNRy8va0xaUy90?=
 =?utf-8?Q?LLYsl35tIOLcfBlx4KXmGaUwM?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b72272a0-6383-4e55-5185-08dd4bd66884
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6583.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2025 02:30:40.7257
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NAkEbug8bdYsAvpUHYlf76SCvsZMAUyvXgPlVoONt3UAdM5rnrqzaopchdSi/MoO4zHhpGBzkf4a815sprn+yg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9086

On 2/6/2025 4:13 PM, Jason Gunthorpe wrote:
> 
> [
> Many people were away around the holiday period, but work is back in full
> swing now with Dave already at v3 on his CXL work over the past couple
> weeks. We are looking at a good chance of reaching this merge window. I
> will work out some shared branches with CXL and get it into linux-next
> once all three drivers can be assembled and reviews seem to be concluding.
> 
> There are couple open notes
>   - Greg was interested in a new name, but nobody offered any bikesheds
>   - I would like a co-maintainer
> ]
> 
> fwctl is a new subsystem intended to bring some common rules and order to
> the growing pattern of exposing a secure FW interface directly to
> userspace. Unlike existing places like RDMA/DRM/VFIO/uacce that are
> exposing a device for datapath operations fwctl is focused on debugging,
> configuration and provisioning of the device. It will not have the
> necessary features like interrupt delivery to support a datapath.
> 
> This concept is similar to the long standing practice in the "HW" RAID
> space of having a device specific misc device to manage the RAID
> controller FW. fwctl generalizes this notion of a companion debug and
> management interface that goes along with a dataplane implemented in an
> appropriate subsystem.
> 
> The need for this has reached a critical point as many users are moving to
> run lockdown enabled kernels. Several existing devices have had long
> standing tooling for management that relied on /sys/../resource0 or PCI
> config space access which is not permitted in lockdown. A major point of
> fwctl is to define and document the rules that a device must follow to
> expose a lockdown compatible RPC.
> 
> Based on some discussion fwctl splits the RPCs into four categories
> 
>          FWCTL_RPC_CONFIGURATION
>          FWCTL_RPC_DEBUG_READ_ONLY
>          FWCTL_RPC_DEBUG_WRITE
>          FWCTL_RPC_DEBUG_WRITE_FULL
> 
> Where the latter two trigger a new TAINT_FWCTL, and the final one requires
> CAP_SYS_RAWIO - excluding it from lockdown. The device driver and its FW
> would be responsible to restrict RPCs to the requested security scope,
> while the core code handles the tainting and CAP checks.
> 
> For details see the final patch which introduces the documentation.
> 
> The CXL FWCTL driver is now in it own series on v3:
>   https://lore.kernel.org/r/20250204220430.4146187-1-dave.jiang@intel.com
> 
> I'm expecting a 3rd driver (from Shannon @ Pensando) to be posted right
> away, the github version I saw looked good. I've got soft commitments for
> about 6 drivers in total now.

Hi Jason,

I've looked through the core code and didn't see anything that other 
haven't already commented on.  I didn't go through the mlx5 or bnxt code 
very carefully, but you can put my Reviewed-by on your first 6 patches.

We've been running successfully with an earlier version of the code, but 
haven't set up our full test environment with this version yet.  Since 
there doesn't seem to be much change here, you are welcome to my 
Tested-by as well.

For the first 6 patches:
Reviewed-by: Shannon Nelson <shannon.nelson@amd.com>
Tested-by: Shannon Nelson <shannon.nelson@amd.com>

Cheers,
sln

> 
> There have been three LWN articles written discussing various aspects of
> this proposal:
> 
>   https://lwn.net/Articles/955001/
>   https://lwn.net/Articles/969383/
>   https://lwn.net/Articles/990802/
> 
> A really giant ksummit thread preceding a discussion at the Maintainer
> Summit:
> 
>   https://lore.kernel.org/ksummit/668c67a324609_ed99294c0@dwillia2-xfh.jf.intel.com.notmuch/
> 
> Several have expressed general support for this concept:
> 
>   AMD/Pensando - https://lore.kernel.org/linux-rdma/20241205222818.44439-1-shannon.nelson@amd.com
>   Broadcom Networking - https://lore.kernel.org/r/Zf2n02q0GevGdS-Z@C02YVCJELVCG
>   Christoph Hellwig - https://lore.kernel.org/r/Zcx53N8lQjkpEu94@infradead.org
>   Daniel Vetter - https://lore.kernel.org/r/ZrHY2Bds7oF7KRGz@phenom.ffwll.local
>   Enfabrica - https://lore.kernel.org/r/9cc7127f-8674-43bc-b4d7-b1c4c2d96fed@kernel.org
>   NVIDIA Networking
>   Oded Gabbay/Habana - https://lore.kernel.org/r/ZrMl1bkPP-3G9B4N@T14sgabbay.
>   Oracle Linux - https://lore.kernel.org/r/6lakj6lxlxhdgrewodvj3xh6sxn3d36t5dab6najzyti2navx3@wrge7cyfk6nq
>   SuSE/Hannes - https://lore.kernel.org/r/2fd48f87-2521-4c34-8589-dbb7e91bb1c8@suse.com
> 
> Work is ongoing for userspace, currently the mellanox tool suite has been
> ported over:
>    https://github.com/Mellanox/mstflint
> 
> And a more simplified example how to use it:
>    https://github.com/jgunthorpe/mlx5ctl.git
> 
> This is on github: https://github.com/jgunthorpe/linux/commits/fwctl
> 
> v4:
>   - Rebase to v6.14-rc1
>   - Fine tune comments and rst documentatin
>   - Adjust cleanup.h usage - remove places that add more ofuscation than
>     value
>   - CXL is back to its own independent series
>   - Increase FWCTL_MAX_DEVICES to 4096, someone hit the limit
>   - Fix mlx5ctl_validate_rpc() logic around scope checking
>   - Disable mlx5ctl on SFs
> v3: https://patch.msgid.link/r/0-v3-960f17f90f17+516-fwctl_jgg@nvidia.com
>   - Rebase to v6.11-rc4
>   - Add a squashed version of David's CXL series as the 2nd driver
>   - Add missing includes
>   - Improve comments based on feedback
>   - Use the kdoc format that puts the member docs inside the struct
>   - Rewrite fwctl_alloc_device() to be clearer
>   - Incorporate all remarks for the documentation
> v2: https://lore.kernel.org/r/0-v2-940e479ceba9+3821-fwctl_jgg@nvidia.com
>   - Rebase to v6.10-rc5
>   - Minor style changes
>   - Follow the style consensus for the guard stuff
>   - Documentation grammer/spelling
>   - Add missed length output for mlx5 get_info
>   - Add two more missed MLX5 CMD's
>   - Collect tags
> v1: https://lore.kernel.org/r/0-v1-9912f1a11620+2a-fwctl_jgg@nvidia.com
> 
> Andy Gospodarek (2):
>    fwctl/bnxt: Support communicating with bnxt fw
>    bnxt: Create an auxiliary device for fwctl_bnxt
> 
> Jason Gunthorpe (6):
>    fwctl: Add basic structure for a class subsystem with a cdev
>    fwctl: Basic ioctl dispatch for the character device
>    fwctl: FWCTL_INFO to return basic information about the device
>    taint: Add TAINT_FWCTL
>    fwctl: FWCTL_RPC to execute a Remote Procedure Call to device firmware
>    fwctl: Add documentation
> 
> Saeed Mahameed (2):
>    fwctl/mlx5: Support for communicating with mlx5 fw
>    mlx5: Create an auxiliary device for fwctl_mlx5
> 
>   Documentation/admin-guide/tainted-kernels.rst |   5 +
>   Documentation/userspace-api/fwctl/fwctl.rst   | 285 ++++++++++++
>   Documentation/userspace-api/fwctl/index.rst   |  12 +
>   Documentation/userspace-api/index.rst         |   1 +
>   .../userspace-api/ioctl/ioctl-number.rst      |   1 +
>   MAINTAINERS                                   |  16 +
>   drivers/Kconfig                               |   2 +
>   drivers/Makefile                              |   1 +
>   drivers/fwctl/Kconfig                         |  32 ++
>   drivers/fwctl/Makefile                        |   6 +
>   drivers/fwctl/bnxt/Makefile                   |   4 +
>   drivers/fwctl/bnxt/bnxt.c                     | 167 +++++++
>   drivers/fwctl/main.c                          | 416 ++++++++++++++++++
>   drivers/fwctl/mlx5/Makefile                   |   4 +
>   drivers/fwctl/mlx5/main.c                     | 340 ++++++++++++++
>   drivers/net/ethernet/broadcom/bnxt/bnxt.c     |   3 +
>   drivers/net/ethernet/broadcom/bnxt/bnxt.h     |   3 +
>   drivers/net/ethernet/broadcom/bnxt/bnxt_ulp.c | 126 +++++-
>   drivers/net/ethernet/broadcom/bnxt/bnxt_ulp.h |   4 +
>   drivers/net/ethernet/mellanox/mlx5/core/dev.c |   9 +
>   include/linux/fwctl.h                         | 135 ++++++
>   include/linux/panic.h                         |   3 +-
>   include/uapi/fwctl/bnxt.h                     |  27 ++
>   include/uapi/fwctl/fwctl.h                    | 140 ++++++
>   include/uapi/fwctl/mlx5.h                     |  36 ++
>   kernel/panic.c                                |   1 +
>   tools/debugging/kernel-chktaint               |   8 +
>   27 files changed, 1782 insertions(+), 5 deletions(-)
>   create mode 100644 Documentation/userspace-api/fwctl/fwctl.rst
>   create mode 100644 Documentation/userspace-api/fwctl/index.rst
>   create mode 100644 drivers/fwctl/Kconfig
>   create mode 100644 drivers/fwctl/Makefile
>   create mode 100644 drivers/fwctl/bnxt/Makefile
>   create mode 100644 drivers/fwctl/bnxt/bnxt.c
>   create mode 100644 drivers/fwctl/main.c
>   create mode 100644 drivers/fwctl/mlx5/Makefile
>   create mode 100644 drivers/fwctl/mlx5/main.c
>   create mode 100644 include/linux/fwctl.h
>   create mode 100644 include/uapi/fwctl/bnxt.h
>   create mode 100644 include/uapi/fwctl/fwctl.h
>   create mode 100644 include/uapi/fwctl/mlx5.h
> 
> 
> base-commit: 2014c95afecee3e76ca4a56956a936e23283f05b
> --
> 2.43.0
> 


