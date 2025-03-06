Return-Path: <linux-rdma+bounces-8396-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D76AA54037
	for <lists+linux-rdma@lfdr.de>; Thu,  6 Mar 2025 03:02:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 51E7218911C5
	for <lists+linux-rdma@lfdr.de>; Thu,  6 Mar 2025 02:02:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59EA5768FD;
	Thu,  6 Mar 2025 02:02:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="vmhBAIBL"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2056.outbound.protection.outlook.com [40.107.101.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93CF0EEC5;
	Thu,  6 Mar 2025 02:02:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741226549; cv=fail; b=PoLMRMnv88VM88exxwdiDpoU1jFZBBjmAwf3vEGYhf38l/TvOb8USH0ZO7HVKrRM/+MKKlSjxfYaPnkc6hpxM7Qe5G9L+b9Jhxb2bm2pT7kWiNJm2bJK1nx0cyrA1p8XHWJ+ybzussW7xnDPQh/duIUp4ymPT9dhLOTaNrhnnqE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741226549; c=relaxed/simple;
	bh=3CEAAQVmGZrvx+XgTBRMnQ9hHZFOWJO1XDehGLvRrQE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=tE7msjsDbkUtHbJEcmo6m3WGuXI6Y/e9pWsljL2rcA/e5BjWGEbdOYC4xrFG4vAH83Q2b7f7SdYdHBbqRpE85Qc3vsDpMr4VgjCrhzD6zLDq3mhWetwTdhpbQUT4FGApGGfR7HskfVSPkGFUHYMKXAWJIyJVWk0keAactJAqZ9M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=vmhBAIBL; arc=fail smtp.client-ip=40.107.101.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cYDNQVZWIMyTlNYbe7qs7dzVYB4ZL/tZSZn+kmrpGNh/yG+2NyG4CRy1SoFEc2bmBU3mfd8+0AJqezRBw6FfzcOt6IWLFY0MUCNBGctEb95z0Teo6AJ3Th6c4bLHGpTtPz+lHDRtVPvgB1tqdU8vuZTMQVsD9i/yFmOfdB3NE6NjPbB2OiXI3qTUnHGBLGV5jeFJ3bFM+nilmCFu23MDOKmqvyzkfyVmmebnlI8iucSLkfF/JcGCkjX4o51W0Qq8VXi+TwBdvVyijudMSZBAXtEzVldjvxx41CO3/AXkbB6zy5WnBGUEFkbZW+Xpdj7uYBj44oWUNFLmbymmwrFd3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PCX57wbcuz2TlvqCNv0/zSrliSubNeC7loq6sg+/L8M=;
 b=t4T1M9MVMFmNjduugzqzsuAFjWcYfem3wjQn6RVCSWByEetEmDgID0AOnnIjM6VL4ArK/zmzNKT8yU+NgrSl+D2Eb1YZ2xkDumYK8TxnXEveBdDhfgBKI+JZSomtBGXqA15HvjfEq5TRin0teXEXkPcXfEiBYXdbTT/w/yyOUToWcvMTzice5V2NL7pLHSLt/+5i8D201te9D02GHpuG0G8q3DKkNv8eXrZRMgW4qtRoYcv5heUm/iNmO8CqRTKvqMbkrOG517KbwrdG1obFWJGie9QbOO1cfUZ+0Eof651PHCmNTr5yY+8/cbQNpST3qZN7fTzkg8lj5qKndzl9ug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PCX57wbcuz2TlvqCNv0/zSrliSubNeC7loq6sg+/L8M=;
 b=vmhBAIBLERtIlMFskV7RVAP15DyYdHoS+N+85k8xLPSF6aAgWHqOaMQZy0HxzrQ60dH1FDWqoQDvrmZ8cWt5+5I7Lu6h7K6fsPVSkSPnr9iqG6Ds5IMreSnalQqRSNrU81Ui86ka/ig8+sgyjlEmrNKas+P2ptkvn413fFlet4s=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB6583.namprd12.prod.outlook.com (2603:10b6:8:d1::12) by
 SJ0PR12MB6783.namprd12.prod.outlook.com (2603:10b6:a03:44e::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.25; Thu, 6 Mar
 2025 02:02:25 +0000
Received: from DS0PR12MB6583.namprd12.prod.outlook.com
 ([fe80::c8a9:4b0d:e1c7:aecb]) by DS0PR12MB6583.namprd12.prod.outlook.com
 ([fe80::c8a9:4b0d:e1c7:aecb%5]) with mapi id 15.20.8511.015; Thu, 6 Mar 2025
 02:02:25 +0000
Message-ID: <5b3a256b-7dd1-48bd-ba11-4766180ba0e3@amd.com>
Date: Wed, 5 Mar 2025 18:02:22 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/6] pds_fwctl: add rpc and query support
To: Jason Gunthorpe <jgg@nvidia.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: andrew.gospodarek@broadcom.com, aron.silverton@oracle.com,
 dan.j.williams@intel.com, daniel.vetter@ffwll.ch, dave.jiang@intel.com,
 dsahern@kernel.org, gregkh@linuxfoundation.org, hch@infradead.org,
 itayavr@nvidia.com, jiri@nvidia.com, kuba@kernel.org, lbloch@nvidia.com,
 leonro@nvidia.com, linux-cxl@vger.kernel.org, linux-rdma@vger.kernel.org,
 netdev@vger.kernel.org, saeedm@nvidia.com, brett.creeley@amd.com
References: <20250301013554.49511-1-shannon.nelson@amd.com>
 <20250301013554.49511-6-shannon.nelson@amd.com>
 <20250304170808.0000451d@huawei.com> <20250304172412.GO133783@nvidia.com>
Content-Language: en-US
From: "Nelson, Shannon" <shannon.nelson@amd.com>
In-Reply-To: <20250304172412.GO133783@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PH7PR13CA0002.namprd13.prod.outlook.com
 (2603:10b6:510:174::6) To DS0PR12MB6583.namprd12.prod.outlook.com
 (2603:10b6:8:d1::12)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6583:EE_|SJ0PR12MB6783:EE_
X-MS-Office365-Filtering-Correlation-Id: 9b177850-4ca8-4e3f-0ac7-08dd5c52f0aa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bkpEeU0vTVlWVXNDeVRrUi9KRjNzTEhzZ0lxM3R4YVFZMisxVkM4dlJ6UkNU?=
 =?utf-8?B?TmVEeVU5QUc5Sng4d0xkSnNXR29FcVFPY2RLTGt0dU5GMDJDNXQ0bGl1OTAx?=
 =?utf-8?B?WWpmUUs0V0VkSGNBeVpMNVVOcEUyMFNxdXJieTIvOEo2RjFONWljelF2VzJX?=
 =?utf-8?B?VXBzRThwY2w1a0Vua01IZjFYYlhZMEVrMnF4NVpWQlluUEJ0eS9KSlVzdTZi?=
 =?utf-8?B?S3ErdWQ1SFRCVy9PQlhuQjBWS1F2bnVxQ2dJTHJOZDI5clRBa29NS000S0kx?=
 =?utf-8?B?S2dCV0drT1Rqd1lUaWVQSlREZlNhVlRob2JWR0tzcUd4S2lrdm51THZaZk9R?=
 =?utf-8?B?ZzQ2OEdxNEpWZUZVb3Q4SWZCOVIxazdVM3VsRzFvcitieEtYeGhZWDIwSCtI?=
 =?utf-8?B?a2MyajM4WWFEODZEcFJkOEtiK1o3a2N5OUVCcFh6V0U3WFc4cTMvcHJBeWtM?=
 =?utf-8?B?R3ZqU2J1SHhpakdvNmQ5REducThaV3Z4amZqY0ZRbTB6N2xIcml5bGxFamcv?=
 =?utf-8?B?M3FqRVpMT3pVYmwxMVBBeXk3VDB4TWpIZHVSNDNvcE5nOTd6cnBQQms1NXpH?=
 =?utf-8?B?VUlWTFBkUGZWY2lVd2lEYWc3RUVDbzNKUTUrUEF5bnc1OWhWQTh4azUzYkd6?=
 =?utf-8?B?NXVsd052ZkZua0h5ckZSY2w3MktVZXhIaW0zNjV1WVQzaUtwWkI4WXhhRSsx?=
 =?utf-8?B?L1FVZUJUb0JUSDlpQ1NrMExCWHRVbzNFTGczc1hnUjZxMHRlb2NFeUJOM1Zk?=
 =?utf-8?B?ZXdFR3hnNXA2eFdtVTVQRDZWNHU5Q1QxOC95TGdKNklyUnl6U3RoUFFTWS85?=
 =?utf-8?B?VFI4MHR4RWMvYjFZb2p6OG1VVklXdC9Db2JRRVZhTkFYTXhZUm0ybWNxM1dk?=
 =?utf-8?B?anlxS1dsd3hXR2R5b0JmalBtbk1EcHBScVVHY1F6ZVE0RmxsZ3o4My9SYzdK?=
 =?utf-8?B?ZCtDUFJGZzRkeUp6L2RPQlZDWlpQOEdFSk9TdTZmOGhUVm5lSHMxeFUzWFli?=
 =?utf-8?B?UkJxRy8vejVmTm45ZzE1RG0vNWc2c0ZBVTM1Q1QzM0Z2OWtlUk03SndkWGFD?=
 =?utf-8?B?WVNITG9KclIxYk5pdEg5NWRDQ3ZrUG5ZNjVPUjIySWp0WGZ3Y0xJRmpWSmhE?=
 =?utf-8?B?YkZ2V1NHNzlGT21aWHdSR2xYeElMRXk3THA2VjFFZFJYUGhlbG10dFBiWVZ1?=
 =?utf-8?B?SHFRd1hhajFFckNVcnZIZlRuVDhlNkp1N0liZ0JZdUpKaFdhdUxPSFgrZEYv?=
 =?utf-8?B?UUd2bkNyRlJFaVFhUTZxYzI3NXVHalcvK2c0dzFsUFFqVlNBQ1d4MnFmRGd4?=
 =?utf-8?B?UDlZZDZNcytMamJFMzhDNTg0VjdiTmJBcnBvbXJpakJsVHgzVTFxVUh6WjNx?=
 =?utf-8?B?M3dyZ0tvT0pORmRqQzE1QWJ4NHkxaXR2cU5MZVBXRkZ1R1NWSzk0bEhYRWtn?=
 =?utf-8?B?TEpvTHJFbFRMQi9yUE5zYWc3WFpzSUhkSmZlMVdnakxjeElrZWpyd0VxMU5K?=
 =?utf-8?B?V3hQRmhWaFJ5QkJCVXZYNHhPeFZRK1oyK0hJelUvbE1FMFB0ZVAyMjhqQ3BG?=
 =?utf-8?B?Qk5RZXhISjFZWXBIUzhITTh5ZXY5b1RIbmRPYTJubUZXZzRIei8vSGU3bzVa?=
 =?utf-8?B?TVV1VXhzSk40Nlp4ZDZtMGV4aWRtTkpIUUhXdC95VzlnR3d6bVN4T1FmUDZW?=
 =?utf-8?B?c1dtelpQZEJxTUJQTzhtck5kWUNYMlZtSk16aWY3NG5QNmlvcTZtTUUxNzMv?=
 =?utf-8?B?c1pWVXlSQ0x2Z0xMUnE5MzAyRTdkUmtkUk9INzR4V3V1ZTdPT0JlL2NSZ1lu?=
 =?utf-8?B?ZjgwQUdIcU1aWWpJZW0wWHNyY2NFZVJ0OHB4aTdQVW5zNG9Gd1JvUndQOE9K?=
 =?utf-8?Q?WKMRJFLgkioK+?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6583.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RDZrSFF0N1Z0dWxrNmRzZmFBQmdYbUZFRkp3TW5PY005V0hLTXROK0JhNmNU?=
 =?utf-8?B?TUtRbnZEb3NZOW5NZHMyZ1ZzM0xQVVlNMUNTZElVUm01SERJdE5vWjE2NXVi?=
 =?utf-8?B?VTNMYWZuVDZHU0VLakdxV0crR3V4WXhKU1p1REIvM2hXMFpzZVhvZXE4V3Zt?=
 =?utf-8?B?dWl5MmNjNWhIMlpiRWFtZjJXTGgraWJGVVNrbnNBbXJkRHZibStyNkkrRFYw?=
 =?utf-8?B?dXlCQWd2Y0p3ZlpRK2Z3Q1FGM3JmV21vb3ZFRjR3L1pla2JFdWhzRFIzOTJk?=
 =?utf-8?B?N05MREdsS2U1dU9BTlQyajMyMXh0RzEzTTg2ekVVenNCZDRYZ1J3azhFdlEy?=
 =?utf-8?B?VGxrMUY5NHpEWkxXL1BxZ2dneENjNnRRdzB1UUwzcW1aRUdxUG40MER6S3Y4?=
 =?utf-8?B?aENqUnkzb21yc1NnR3cyckd5L043T0xkcjd1dVZ0TlFWVysrNjdxcnlRZUpV?=
 =?utf-8?B?QUZzQUtQSlArMU9aTXBSK0I2S0NCMjVJRHhXTFhwdlBUU1NGc3N1OHd2RDM4?=
 =?utf-8?B?a1plZXpRMG1WalIxcmZJbUY1M3FXa2doOU82UkljeGFIQzVYYjR2c1hjakRU?=
 =?utf-8?B?azVRbzZvcFBpVm9jaktqcTFhdnB5S1Y1WExYZm9uUGQwa3psZk95YTMzeDJ3?=
 =?utf-8?B?UXkwdnYvZEN5bXNBR0JMUDdmZC9uSkJ3N1BRRlRTU3pPQnFRYlgyOTJ3bUoy?=
 =?utf-8?B?VDk0d1UvVzBpek9rYVMvU3RlSVJxL3d0dytJS1haaG5uOGVXK2dTWUluQTMy?=
 =?utf-8?B?ZVB1WEpoMGNISUFRei9RckdWbDdURGpwYklyYVRLaTY3Rk43SU1UTDc2cDlw?=
 =?utf-8?B?NVhENmlsejdhb3V0V05mOGtIQ0x1QWNNY25xWUZDeHV0bnAwOHNESFpoWXc1?=
 =?utf-8?B?TXdVYUMyM2d6WkMzWGhIWW9HL2hzU2FOelFPR1BQWWVlQlJqQjMzM1pFZEN6?=
 =?utf-8?B?MnB4SCtMcmFkU2JwdWJsbzVFdE5mR1V4em5qRkNSaTQxNmg0OFZscWNvQTk2?=
 =?utf-8?B?am4xZ0llRzFRdnJPZWR3ZnJkRmw3dm9Sc0ZXSHNYQWJYKy9kV2NaQTc1MG9K?=
 =?utf-8?B?UDVxbDhmSkZic2dLMTlBS2w1cG1PcVlqbzg3eGJZVXZSKzlwdFF0OXVDcGZU?=
 =?utf-8?B?K2QySmxHZ3N5cExMN0lScGtYSWQrZjN3TlpSSVFoNlptQzN1TzRjN3RaT3VO?=
 =?utf-8?B?cy81WU5LR0taeHkveEY2cW14SEN0VFp6ZUx0NE1GNE43Qm1wVnlqYXEyMmlj?=
 =?utf-8?B?NkVxbUcxZGsra00vVWVtbFI4ZUdJcDBqQzh6S2pTTUI1dkNtVk9PTXdmQXRF?=
 =?utf-8?B?K2JLWmYxbkVwWVBKbEdkMXB1b2pFWWVQL2loTWtJTlpSMW9QNktvN3kzUDRz?=
 =?utf-8?B?V295eWxydzIyVldpVW1qdnZzZHpIRE5JcFlYU0JDa241YUJobUZsYlFxa2lP?=
 =?utf-8?B?Mzdlb2tpcnpoTTFOVjhxdWNZNXV6STc3ckFGa2RmYWpBa001bTFVbjFnelRP?=
 =?utf-8?B?ZmRaRzdOQXFob3NBaHdxa2JNMG1yZmliN3liTGhFKzJSaFIzQ1FkV1Fmdms5?=
 =?utf-8?B?dFFNWnRHYnd4RW1sblpZZ2pWTFpLWEZsYU5BTWZjbnNrTzFxRDJpM2xLQ05S?=
 =?utf-8?B?ckQ1eUpxMmUza1ltNGNaRGJmMmI2K3hCZGZKVjE5bnhtSzV2SlFlTVB0QmZG?=
 =?utf-8?B?SnNPZWdsTmJoZU9nWGtqeUJjQjZIVHFML2FxcmVUckl3bm5zUW53RU1ja3hl?=
 =?utf-8?B?SVR3QTVia3ByUUZSejh1Qm9GMVYzUmYwdTR3dnI2c2lnNmZTRU9RaHQyMjdH?=
 =?utf-8?B?OVlLU1lLQlVPT29WTVYvN05VcGpNaldtZ0RvV3MzSTN0SzYyTFcyRXZTVG5V?=
 =?utf-8?B?a0xFVjY2RkJ1a3drdkVTUy9mbW9CYlA3bldsWVVHazNCVkx0SUttME9aTTZT?=
 =?utf-8?B?bHdMUm9kYUYvYkdEMk4wcFJmQjV5Z2JJZ3JmdFU3K2c3Wi9ZTkYvekFhMGNL?=
 =?utf-8?B?MklRaURzTkFxR2phSlNIdmg1RjZ2dEUyQ1hid21WdTIzNk0ySFJoQUMrcnY3?=
 =?utf-8?B?YzhmL05vTmFIbHpXTGFKVnVVdFBieVEzZklsRjVWSlBLUFhtczlWdXlnUEYz?=
 =?utf-8?Q?sOXc2GHhHBDj15UpZHoXQ0f5u?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b177850-4ca8-4e3f-0ac7-08dd5c52f0aa
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6583.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2025 02:02:25.2545
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RSrE7OoeXCcA0nPAmboOW/aGZt8ig8bS3gLKkXDmHS/2yGyhRwHiDe05m1rFDiXILDBBwd/Bk/ENVfPx7TBrWA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6783

On 3/4/2025 9:24 AM, Jason Gunthorpe wrote:
> On Tue, Mar 04, 2025 at 05:08:08PM +0800, Jonathan Cameron wrote:
>>> +   dev_err(dev, "Invalid operation %d for endpoint %d\n", rpc->in.op, rpc->in.ep);
>>
>> Perhaps a little noisy as I think userspace can trigger this easily.  dev_dbg()
>> might be better.  -EINVAL should be all userspace needs under most circumstances.
> 
> Yes, please remove or degrade to dbg all the prints that userspace
> could trigger.

Sure

> 
>>> +   if (rpc->in.len > 0) {
>>> +           in_payload = kzalloc(rpc->in.len, GFP_KERNEL);
>>> +           if (!in_payload) {
>>> +                   dev_err(dev, "Failed to allocate in_payload\n");
> 
> kzalloc is already super noisy if it fails

I know ... I get dinged on this all the time, but I still add these 
because there are multiple allocs in this one function and it isn't 
immediately obvious in the trace which alloc failed.  I could push each 
alloc off to separate functions to get that info in the trace, but it 
seems to me that's extra unnecessary code to get the same one more line.


> 
>>> +                   out = ERR_PTR(-ENOMEM);
>>> +                   goto done;
>>> +           }
>>> +
>>> +           if (copy_from_user(in_payload, u64_to_user_ptr(rpc->in.payload),
>>> +                              rpc->in.len)) {
>>> +                   dev_err(dev, "Failed to copy in_payload from user\n");
>>> +                   out = ERR_PTR(-EFAULT);
>>> +                   goto done;
>>> +           }
>>> +
>>> +           in_payload_dma_addr = dma_map_single(dev->parent, in_payload,
>>> +                                                rpc->in.len, DMA_TO_DEVICE);
>>> +           err = dma_mapping_error(dev->parent, in_payload_dma_addr);
>>> +           if (err) {
>>> +                   dev_err(dev, "Failed to map in_payload\n");
>>> +                   in_payload_dma_addr = 0;
> 
> etc
> 
>>> +   err = pds_client_adminq_cmd(pdsfc->padev, &cmd, sizeof(cmd), &comp, 0);
>>> +   if (err) {
>>> +           dev_err(dev, "%s: ep %d op %x req_pa %llx req_sz %d req_sg %d resp_pa %llx resp_sz %d resp_sg %d err %d\n",
>>> +                   __func__, rpc->in.ep, rpc->in.op,
>>> +                   cmd.fwctl_rpc.req_pa, cmd.fwctl_rpc.req_sz, cmd.fwctl_rpc.req_sg_elems,
>>> +                   cmd.fwctl_rpc.resp_pa, cmd.fwctl_rpc.resp_sz, cmd.fwctl_rpc.resp_sg_elems,
>>> +                   err);
> 
> Triggerable by a malformed RPC?

That or misbehaving firmware.

> 
>>> +           out = ERR_PTR(err);
>>> +           goto done;
>>> +   }
>>> +
>>> +   dynamic_hex_dump("out ", DUMP_PREFIX_OFFSET, 16, 1, out_payload, rpc->out.len, true);
>>> +
>>> +   if (copy_to_user(u64_to_user_ptr(rpc->out.payload), out_payload, rpc->out.len)) {
>>> +           dev_err(dev, "Failed to copy out_payload to user\n");
> 
> Triggerable by a malformed user provided pointer

yes

> 
> Jason

Thanks,
sln


