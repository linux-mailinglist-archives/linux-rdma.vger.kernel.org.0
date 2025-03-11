Return-Path: <linux-rdma+bounces-8582-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 66417A5C3C7
	for <lists+linux-rdma@lfdr.de>; Tue, 11 Mar 2025 15:28:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1B0D916F907
	for <lists+linux-rdma@lfdr.de>; Tue, 11 Mar 2025 14:28:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39F4025BAAD;
	Tue, 11 Mar 2025 14:27:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="tTsBztEY"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2043.outbound.protection.outlook.com [40.107.92.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 404AB253F13;
	Tue, 11 Mar 2025 14:27:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741703257; cv=fail; b=IqqsXmirFITgWRh4lJvWrF+1oA0cmBceijzdezY20E/8UGS0atnR7Uv059b/ippClo4Yq9PMubQ8HwRNycjraf24c4/9Vbl3dMju3HmnbPNIUx7m51iyQv3ApQgzBeyeqrPMJFbwyEhTDHJrBWimcHCEbPz3VDk6Pvp6bHLu39I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741703257; c=relaxed/simple;
	bh=3QMxec5lMbwrOCTkiXjjzyNTnSf8tcKfKphqrnz3/Po=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=TBDzj0YX6hKd04mKuJ7ZcWmhlBpA1SwlJHdWRrnf87puEukkA1BYKWN4eaY++qfjOOA43aq9CEEsZ76BpZPPS2Pzn3mKjFLLcMLEljvriidnvlTBdj8NHkpQNg+GtggTdF9Ike6VivMkmraMM+wYYQVQwa2zJdBKUHU+dAFV+fU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=tTsBztEY; arc=fail smtp.client-ip=40.107.92.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SrXqef6fKjqfKa917t0AUBcyq1RpkcvVsYvluoP/6tBQWHhIrdfxGfqmDw3tdIiUa4JsG/BMUfLuVchszWCmMPtb3KGOyzdpHf8wZT9dhYk8XMyDtOCo5qb6wRib5rKFEP8A2O7ywremijj5cmi/8zLRlvALq3tk87CbH+ZA+rVmQgwPcV2/wVQ3kcUqTfiD8GQ/OP8hWrXBLd6QGSSmZGyuSwT2NzMg/uqtANio5f1cX24rbaG4YS29nAkeAU8yv2y/q4lxdWW6DukcybxHrxAzw9WaBhUF6HrVVDwXTXDCAn1KfXhT+IcKz3KY7uUeK0DcWsPxsJ2H50gjRdqGEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Aq27mIa6nm2k4yScuOAOVnYETKON7IukNmsKtxNAglE=;
 b=GCt8aNFcbJwc+UHlfW7WABn9mgZgBP2y2ZM0f/8OiUzMUyBAe7dVMVGfQbJr5cuiRKmtYuEwX/6N8ZZzdpokk5aXGWnVY5tzETY1jRGxK7gla8NZpTvmDCtEcp+FOQB9VkxlK/yPZF3O9fzqyR2yZ0joSoChQQFy2XDrSBWw98PNpVC7OsgSSRl8AUPd6P9yMFvUGbi65LxbB19jiQrjlC6QkLqIX8iS8bd0ssweAWrE12NPTl0gxqfXa2YkMCyp53foVDm/+zG+dhFagIOt5Y54xN8zQ/tVZtFb+JiUBtcL8tpCHgOmnIZFkJhwOsNIjjMXNiHqDL2dElsKSrCRUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Aq27mIa6nm2k4yScuOAOVnYETKON7IukNmsKtxNAglE=;
 b=tTsBztEYR6W0qw9wvg7PucrUS2YPFPLZodt+h8KTleQCCqKXUsBHrCx8XlsNXbvST9NaZG0vGgedgGa9QXhypZpMaZarZJ8JX6jClc0zvcjif3uvS5ma+Ea1hYfmhqC3/WTuZbDqGVRIr6xeUmCp5Ud17jnQyvc/TjwFHzdBnz8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB6583.namprd12.prod.outlook.com (2603:10b6:8:d1::12) by
 PH0PR12MB8097.namprd12.prod.outlook.com (2603:10b6:510:295::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Tue, 11 Mar
 2025 14:27:30 +0000
Received: from DS0PR12MB6583.namprd12.prod.outlook.com
 ([fe80::c8a9:4b0d:e1c7:aecb]) by DS0PR12MB6583.namprd12.prod.outlook.com
 ([fe80::c8a9:4b0d:e1c7:aecb%5]) with mapi id 15.20.8511.026; Tue, 11 Mar 2025
 14:27:30 +0000
Message-ID: <e02812b8-77b2-4a2b-9f57-0e66a4ae165d@amd.com>
Date: Tue, 11 Mar 2025 07:27:20 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 0/8] Introduce fwctl subystem
To: David Ahern <dsahern@kernel.org>, Jason Gunthorpe <jgg@nvidia.com>,
 Saeed Mahameed <saeed@kernel.org>
Cc: Leon Romanovsky <leon@kernel.org>, Jiri Pirko <jiri@resnulli.us>,
 Jakub Kicinski <kuba@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Andy Gospodarek <andrew.gospodarek@broadcom.com>,
 Aron Silverton <aron.silverton@oracle.com>,
 Dan Williams <dan.j.williams@intel.com>,
 Daniel Vetter <daniel.vetter@ffwll.ch>, Dave Jiang <dave.jiang@intel.com>,
 Christoph Hellwig <hch@infradead.org>, Itay Avraham <itayavr@nvidia.com>,
 Jiri Pirko <jiri@nvidia.com>, Jonathan Cameron
 <Jonathan.Cameron@huawei.com>, Leonid Bloch <lbloch@nvidia.com>,
 linux-cxl@vger.kernel.org, linux-rdma@vger.kernel.org,
 netdev@vger.kernel.org, Saeed Mahameed <saeedm@nvidia.com>
References: <0-v5-642aa0c94070+4447f-fwctl_jgg@nvidia.com>
 <20250303175358.4e9e0f78@kernel.org> <20250304140036.GK133783@nvidia.com>
 <20250304164203.38418211@kernel.org> <20250305133254.GV133783@nvidia.com>
 <mxw4ngjokr3vumdy5fp2wzxpocjkitputelmpaqo7ungxnhnxp@j4yn5tdz3ief>
 <bcafcf60-47a8-4faf-bea3-19cf0cbc4e08@kernel.org>
 <20250305182853.GO1955273@unreal> <Z8i2_9G86z14KbpB@x130>
 <20250305232154.GB354511@nvidia.com>
 <6af1429e-c36a-459c-9b35-6a9f55c3b2ac@kernel.org>
Content-Language: en-US
From: "Nelson, Shannon" <shannon.nelson@amd.com>
In-Reply-To: <6af1429e-c36a-459c-9b35-6a9f55c3b2ac@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0031.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:c7::15) To DS0PR12MB6583.namprd12.prod.outlook.com
 (2603:10b6:8:d1::12)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6583:EE_|PH0PR12MB8097:EE_
X-MS-Office365-Filtering-Correlation-Id: fa3a16e3-64d5-4424-03c4-08dd60a8dab9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UXNlUlhPQkMxS0RjZG53dmxleWxuUGhZakV0dTZnM00wQjlaaC9TeE1YVFJC?=
 =?utf-8?B?YzNFdUE4bHZwZU5HTmtMbFBKNnpHSVAxdkV3SUx4T1hieUp1VkFpcXlsdWtW?=
 =?utf-8?B?OENwSE5tMFd0eURyQWdjNVErSVAxMXk1d0VyY1VCQVFTT1R0UGhvNVNVeWR3?=
 =?utf-8?B?STBEMWdzNjZZY0ErMERDYndYcE5IbXVYQUFoZldQYjdkWEhMcTcyR1M3OGlU?=
 =?utf-8?B?MGNhdTRITjRSQXY1Y0NOTFEwc2dZVWdSeDNTMFVmQUQ3RFVxN2hBU0QxVXZT?=
 =?utf-8?B?bzl4NW5DRG5xeDJ1WnVqVXVQaWd3TE53SXZvNzdKckEzdEkzR3FaQUw4akV6?=
 =?utf-8?B?QnB2SUxyNmxjQzhVNTUyN1JBZkllSUhRaUI1R08zdzA5c2pZTGxxRW5SWndM?=
 =?utf-8?B?cHNyb0FXQk5lNEk1R2NUOHJvUG1MTUN4ek9LYUJIZXh4c3NKYWZNMFBFR1BH?=
 =?utf-8?B?eGdYbm5taitFNFBlNXdxeEhvSndTalI1QmY4aVViQ0ZTb1cyWTN5MUg1NVZX?=
 =?utf-8?B?TFZiUUUzcTdkdDdxZzNsOVlxQzFSV3dQWk1ZVnBTVnNzQk1xNGpQWElXWnVn?=
 =?utf-8?B?UmV6N0Y2b29ZWUd6SmhwUHJUbEh4SkFqSldZeWFRalF4amdzUHZ6eDl1cCtp?=
 =?utf-8?B?VC90UGZRbE5kTW5rd3c2Z21obzFOWFZUOWQxMVJSSHlrS01zbmVmRXFxME9q?=
 =?utf-8?B?V05ERVVKVysxTC9oYkZyVWZkYUE1QTYvU0Y0OS9QNXBZUUtkZGJuSFFWV2Ro?=
 =?utf-8?B?dlNLRmYvODc0d01lMnh6U21iTFBmZjNhNHhTbXdhR2F6SW0wNUhBUGdSbTRM?=
 =?utf-8?B?T3M3SFhtenRoSnIyU1FxVy96RXpuRk5iVjRBSmVSQnZrbGRiWnRGa0UvNFV1?=
 =?utf-8?B?NmhoV1BZamtua3BtalBDYTc0cjlrdzEzSG9OOFRSMTVMUW9JOWFFbXEyMm10?=
 =?utf-8?B?OGw5VUYyeU1OSnZYd3FHUHQrejFpWU5ERDU2dFZ5L3dtS0lFQWg2Nmtodkx3?=
 =?utf-8?B?K0YydlhNSjE3TnVwb3p2T1dhelN0dlJMVjhVODNERVFQdmUrQVZIVGVCWnBs?=
 =?utf-8?B?eTl2VnJJWmdxVXVoY3dESWxLUkZLL252QjArVktSYlhhL00vUnJ3YlNrRjdX?=
 =?utf-8?B?VUwvaG5VQ09uazQxOEFIT2oxcHBPeGZQUTYvODI1L1laWWtpc0VaQ1NFZ290?=
 =?utf-8?B?ajRlbnE1R2gxdCtrakFMT1FVTDBpVFRVV0JzR3dsclJYeUV6ZDRyblNoMnR3?=
 =?utf-8?B?bjh6bGt3Zlc0aTF0Zzg0R2VkSHZSWUcxZGhwZXQxKzJsbEI2K2g1a0lKWU9y?=
 =?utf-8?B?K0drK3JwaHhGRm1OMWZMVk90Z0RlVE1HbWtuOFZQd05tK0w3S0pDMEl0cVkz?=
 =?utf-8?B?eFFJell6bm9KSmt1WTZCZW85R3VVcUU4c1R1b0tFNWVjSlhGd1luUjdzUXpC?=
 =?utf-8?B?S3I3a0N4YldRYUFuSFI1L0tMKzBDMHFTMmZONzEzbitkZks3V2RSNjFzRldM?=
 =?utf-8?B?OXJOMWNCdXVGblhTdk1FZ29SV1RQQXdpanBMMlYzcWNLcTU4Kyt1SVJvcFBt?=
 =?utf-8?B?Y1R5TWRZdFpWeld2bDlHN2xQR0wrbEpBb3VsUGRDNWJrZE1LekMxY2JTVTBo?=
 =?utf-8?B?aTduOGdDY0tlM3JYK285b0ZXNWRhdXhUNjJGZk54OGwvLzVHc3gzaXQ0aEIw?=
 =?utf-8?B?Mm0yZkFjVUVWN2FpaVAwa1J4WmwwVEtrekpxT3loOTZRTkRFbk9NT09ha25n?=
 =?utf-8?B?UXhZVERSVUFHc09JUWhVUmRUMms2aHJGQVU3Z1YydUlXM0o3TmJvMXQwKzhv?=
 =?utf-8?B?Q2JNSVdNa3VxN2NCUWhIWG4zSjVRdjhhRXljSENCaU1TWnMvMEFqRmZMMzRE?=
 =?utf-8?Q?QbldW2C+Yn4IG?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6583.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SEJJWjJUekxpS3hhUEYxWklRamxMZThneTZ5R05QOFprZWFCQ0V3TEthRXg5?=
 =?utf-8?B?SmFGOEFBdjhkTm45VEhjN1IwQXhaZTJvaG8zRFkvOGxUcVE3UHhaNm1ta3Ri?=
 =?utf-8?B?ZjhZMGEvamJSTGVLMW1sbWtLcmlRb0h6cnhZZG4vYjBtSnJGYkwzTEk3dUJ0?=
 =?utf-8?B?Uk5XaWl2RGFPNWtaVFd0ai9jd3Y4NUNlS0psOFhuN1U1WlpOeTVvSWc1cXY4?=
 =?utf-8?B?U205cVFpRDkvdVliaFlKZU5lUzIzVkxrOTdlQnM1c2tJTGN1c3FpY2lheUIz?=
 =?utf-8?B?VVpENDQrTTJMTXgwYkRrZVB5OHl0a3luZ3kwOHd1b1FxWHM1eVdwQ0FUbmM2?=
 =?utf-8?B?WlJ5NmNhVzlBWFk1UW04QmJBQksxVXI1bkRQUlk2RDFIUlVCU1FoMzF3dG1G?=
 =?utf-8?B?WmtXaW9XUUNuTkEwaytHU0MrTnZKamlnNThRQnFhWjVQTDBGYmVlZmR2ek50?=
 =?utf-8?B?VWlKS3RVSjJvUXY4di96aERkaFRpNGVMV1hwOVMvaVFIei81bGZoZUJSbUZM?=
 =?utf-8?B?NUt1dlo3NXFWT0t5dG5tL3lkSVpMK21mZGVSYmZzV04yQ25oSHNzK05yUlFG?=
 =?utf-8?B?MlFQVGNxNXJxZ0E3VkdJUURSZE0wMWx1d29vUzJTRnN4VVpic2Jvb2NEai8r?=
 =?utf-8?B?NzFvQmVweHlkVFZFTWloeU85ai82WEllMy8zWHI2OHdYWFdORlViSVcrSkdJ?=
 =?utf-8?B?R2F1aEk3eE1kdkZaWXc2dWVNdXlZdUphR3AySFdUTmR6ZERRZVFxNDh0Ykoz?=
 =?utf-8?B?OHZvUGZ1dTdxeDNIUlJUR3BReUw1ZnZud0FVTlNhQVNmUnVybEtBYUN2dXFv?=
 =?utf-8?B?a3NmaXpLektLUGRyd0Nhd08wbU9qMUFwelE2aHA4N01iZ3JqQjBrUEIxdWNu?=
 =?utf-8?B?OS9IbVJXbDlFT0ZIcHEwNmV0M1RLWGlhRWtkeVZqMUNKV1lEeklNMmw0U1Fl?=
 =?utf-8?B?Mk90WDVaVUZvQldpc2xIS3hTMDNzeS9ub1FNaUE0RkxjR093ZUFzNVpVbkJv?=
 =?utf-8?B?NkRQU3Z5M3JrWnhrbm9HNXVoYmRGWTVVMStyL2MvclB0ZFd2NCs5VVBER0Nu?=
 =?utf-8?B?UldnRG1oSFlLK0JEQlVyUVJHOUYwVVVnRCszS3hKVE9US1RWU2d4bjhHeU1k?=
 =?utf-8?B?a2FudDBMQ2lPRWxrT1pYZlN4YUlicjFYL1c2RmxRb1VSRm84MFppdUo0djht?=
 =?utf-8?B?Zzg3b0ZiNll5ekZtUG9QNlp0Tlp6a1RXZWh3ZXlGVHAvUVl2TGJTdXR4Y09w?=
 =?utf-8?B?ak44c1V3MGdVQUYzMEY0bHFQckplUXliYkQrV0EzUzRNOU9hSHhIZ0dKYkVJ?=
 =?utf-8?B?clVtWVcyVWU0aTd0K0pYSktlTC83VDlhbU8yT2daN3NXdkFOZDgxR3hPQlB1?=
 =?utf-8?B?RlVNV0UyMDZMNDI3Ty85ZzQzYnBFOXB3YnRVZTVUMlprVWRodExveEMvUmx4?=
 =?utf-8?B?allSbSt2OWxtZktvU3VVeEx5YnBYREJjbERnQnZSTVA3cStCTldsVVJpYm9q?=
 =?utf-8?B?ZExkdHRDenBjelNwOUxJSWhFanBaOUpCS0x2SUZqeFV4eU1oU0psZTBxcmd6?=
 =?utf-8?B?a1NEd1o3Rm1rcGZhV2JMaWRHQUJSakhkaEoxTjEwN0dkNUI3dExUSTYyTkhE?=
 =?utf-8?B?bjRVK2ZjNW5GVExxd2hHWG9tSzMrTEIyaDBGcjM5UG1HMVlaYktrelRnL3FC?=
 =?utf-8?B?QmV0SzFYNFd5RXE3MzF4ekJMeU96REpDWDMwZm5ZRUtFUFlFNVRYZFc3TnN3?=
 =?utf-8?B?Q2NpbWdoS2lnbnI3K0t4SGN2a1JkZFRjZjc2OHcxRnRZZkZCeXNrUHgrYVVP?=
 =?utf-8?B?OTBsbnFxS2t0ZktjeExDV0Y3S0ZOUTluYTZ4VFJUWUlPek1NRzNQYW9keS9O?=
 =?utf-8?B?M3l0dndUYUtBMlgwYTRhSU0vQ05OS0RRK2h0VzFzYWVJOGUwTDhVK3k5K0lT?=
 =?utf-8?B?c0VrcjFkLzRFTlJCaElXSjRJcDgrVGJWTDA3dE5ROXZicTBvOERMb2lzd0lF?=
 =?utf-8?B?V3JwakR3dVRDZG5BZEtTVDc4Uk5xUnNRdGR0T3JBbXJFWGlpbUJiUzVxMEJF?=
 =?utf-8?B?bWJqb1UyWVdONElkTjY0T3ZveTh0ZFNJamVydmVVM0hmU2pTTk4wVHUxVmVo?=
 =?utf-8?Q?6kUoKeQs9NwuERQXHxzqvDRRg?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fa3a16e3-64d5-4424-03c4-08dd60a8dab9
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6583.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2025 14:27:29.9312
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: av+wBKRN5T/2ZPfEdkYviyBcdibE5+UcoeaYSeI71XMmDI9KoSadtLE07Spzu7I/Uxvqy3fV4WGfvdVpgrsvoA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8097

On 3/11/2025 4:23 AM, David Ahern wrote:
> On 3/6/25 12:21 AM, Jason Gunthorpe wrote:

>>
>>> It should be something that is tightly coupled with aux, currently
>>> aux is under drivers/base/auxiliary.c I think it should move to
>>> drivers/aux/auxiliary.c and device drivers should implement their
>>> own aux buses, WH access APIs and probing/init logic under that
>>> directory e.g: drivers/aux/mlx5/..
>>
>> That makes sense to me. I would expect everything in this collection
>> to be PCI drivers spawing aux devices.
>>
>> drivers/aux_core/ or something like that, perhaps?
>>
> 
> drivers/aux_core works for me; removes the 'pci' assumption and makes it
> clear the real attribute here is use of the aux bus with subsystem
> specific devices. I am still not clear on how such a branch will work -
> e.g. We will want multi-vendor review, not just merge the PR and go.
> 

At the risk of getting too far into the naming-choosing rat hole... note 
that even "aux_core" has the assumption that the thing is auxiliary_bus 
oriented, which I don't think is a hard truth.  As an example, yes 
pds_core supports pds_vdpa through an auxiliary_device, but it also 
supports pds_vfio_pci with no aux dev involved.

I could live with drivers/aux_core, but I'd prefer drivers/core.

sln


