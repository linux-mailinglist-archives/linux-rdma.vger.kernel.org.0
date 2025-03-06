Return-Path: <linux-rdma+bounces-8398-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 65221A54045
	for <lists+linux-rdma@lfdr.de>; Thu,  6 Mar 2025 03:07:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 899E71891738
	for <lists+linux-rdma@lfdr.de>; Thu,  6 Mar 2025 02:07:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29A1218DB07;
	Thu,  6 Mar 2025 02:07:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="jH+77+ER"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2041.outbound.protection.outlook.com [40.107.100.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50F0E41C69;
	Thu,  6 Mar 2025 02:07:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741226863; cv=fail; b=Xk6ytOzBw4H5n8rTxIpaNU+Gy84KDQieW/jKYPBvXmqd/j8jAYGai2J0RnEZUy4IYBmMNQEVM1bWfHI26XJrKFs4cVAEgmpukUKGzIpBPuG1Ctz6n0WggZXTqr94WS11f9IQd+2RTlFW0FWsD55soyQhbCYYQu+Mh27/jlDm7Mw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741226863; c=relaxed/simple;
	bh=qFreF/vK7Jn32pep1aOMEBS2hiKyXUyFaZJ2fohogv0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=OkD5qsJUbzVXoAtlEiE0Hl7P7TX6h3vSKXrH3PsVxWgEMzyoCNhPNGu1d/qiXyYbbhiU3wi8WEO4T5tl02xpiL7X0yx50N2rBV4K5DaTAXTlMrQDQvgh5U8cuXW5p7C6vFyufa/vqu1v3Vo9Bq5mdXymWqkPQQk5//WjK4TUuGQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=jH+77+ER; arc=fail smtp.client-ip=40.107.100.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vZBKZ/+yNVqODuWGyc9NymIpqYCReOjHFHrZzAS+cPdLfil5s2aqeKc86VNBO7Q5g/+iWZ9D/gNa0LFWK6g0qox/qRudqJKr1ThjqDiA6TMl9uk8PDotzK4X5JXf3lqAPLypxQ0aJChdHUeZt/CM8Q2CUJDnl2kgzXnG0RmtzNFCwq4qOg6vJx6yCkX6DD2+Im6ftDGQOTC6VMJiAwtkpRM/KfKhcn6Kd6ItEx3Ln/SLtOFcN+q2fJHGU8lSO9KEjBVAvwOfQXFZL5vXSV+XNz76Vxpn3aJDZSxg2300TXOF5qs41F7/p58LfHq9++1Zf0Jx4zrgg+2nhhVnWjWQUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7TLBFuUxgAjVDnR4DFvMo2gvYO4Cb12JfebDrLaJ/vA=;
 b=LLMFbKI5XbUV/v+yrquqXilL7j0WLlx9GoB6uCwGTbpb5N/zcjTkHvZmjCSXOOFu0DgQ++FFK7BP3zeANMN5uTXpgNsddWFR1/IHrag5ypq3U+BOJvtVnCvxv9leat85FeHgAdvZTKx0U+iypbo2GqUtGnaaULx6Fz3JdiI4b273/m5jwiZ4//mfkLSbrkIgue95OzyXLet1NffeH6PwhC7tTgPkftdHOfumHeljZww95yW/07rWMQ3qg4zG/ZgX8JyBJjcAcpKmUe0a43mLmnK6GUC4o8P8+HXkzW25cl8Put4jo8sYARVLDf72yToQaXdZQDPhMxO2Sp3cUFAz7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7TLBFuUxgAjVDnR4DFvMo2gvYO4Cb12JfebDrLaJ/vA=;
 b=jH+77+ERUae/5duC1ylOrUvUiKmFzkPA1H6eievwFpYzUsd3RWkZMuHWWT9HSrpXe7AUyFOGxWvOUWnLc0N32tXm4ApZ6a1UH606Oe8sPTBkyjtTWs1ag2AtzwbLaMb+cKM9TlvrDLkXjnQJHzotdAcKvHcokPJGNI+XoonV/O4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB6583.namprd12.prod.outlook.com (2603:10b6:8:d1::12) by
 DM4PR12MB7693.namprd12.prod.outlook.com (2603:10b6:8:103::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8511.17; Thu, 6 Mar 2025 02:07:40 +0000
Received: from DS0PR12MB6583.namprd12.prod.outlook.com
 ([fe80::c8a9:4b0d:e1c7:aecb]) by DS0PR12MB6583.namprd12.prod.outlook.com
 ([fe80::c8a9:4b0d:e1c7:aecb%5]) with mapi id 15.20.8511.015; Thu, 6 Mar 2025
 02:07:39 +0000
Message-ID: <1ea48dc6-6c26-43aa-bdfc-a754d8590853@amd.com>
Date: Wed, 5 Mar 2025 18:07:37 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/6] pds_fwctl: add rpc and query support
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: andrew.gospodarek@broadcom.com, aron.silverton@oracle.com,
 dan.j.williams@intel.com, daniel.vetter@ffwll.ch, dave.jiang@intel.com,
 dsahern@kernel.org, gregkh@linuxfoundation.org, hch@infradead.org,
 itayavr@nvidia.com, jiri@nvidia.com, Jonathan.Cameron@huawei.com,
 kuba@kernel.org, lbloch@nvidia.com, leonro@nvidia.com,
 linux-cxl@vger.kernel.org, linux-rdma@vger.kernel.org,
 netdev@vger.kernel.org, saeedm@nvidia.com, brett.creeley@amd.com
References: <20250301013554.49511-1-shannon.nelson@amd.com>
 <20250301013554.49511-6-shannon.nelson@amd.com>
 <20250304195233.GU133783@nvidia.com>
Content-Language: en-US
From: "Nelson, Shannon" <shannon.nelson@amd.com>
In-Reply-To: <20250304195233.GU133783@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY3PR05CA0020.namprd05.prod.outlook.com
 (2603:10b6:a03:254::25) To DS0PR12MB6583.namprd12.prod.outlook.com
 (2603:10b6:8:d1::12)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6583:EE_|DM4PR12MB7693:EE_
X-MS-Office365-Filtering-Correlation-Id: bf8b9a70-8fc9-4990-055a-08dd5c53ac22
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?OU90QlM3T3Z6OENlelgrWGdLd1lMblpTWk5ZS2NIK3pUOERITXY4YXl6SGk0?=
 =?utf-8?B?V0dOZlN2TFd1eC96MUthdnE1Vll2cGg5OGpQSnY2Q0ZoMmNzSnRvNnV5SjZW?=
 =?utf-8?B?VHFqRmNESCtwZ3lENE9MSDEwSmRPbXlPN0pXRGpISDVYSit1ZXJJY2ZoeGoz?=
 =?utf-8?B?OTc3cmw2T05DQmZ0RHV1NHV5VzFWWUZUYkpBSW5Fcm52WWxsVEo3a1J5Q2VP?=
 =?utf-8?B?Vm1ONVVxRzA4TUhRWTZZeitBajY3bzF2cG1qRVUrWmljMkErT0lha0lQQWhP?=
 =?utf-8?B?dnZTT2xrRXphbnBON3BqUi9xN3hadzI3YmJ0cGxuNXlUVmdQa3AxMDZjc2lG?=
 =?utf-8?B?MHU4YzNyOFlOZGxEM1E3Yi9LLzRIbTIxQmlRN0Mra2hXanRWZ0JhUG1LVDVu?=
 =?utf-8?B?NWNoT2VuRU00elUvai9vVGdXY0k3Q3A4SEZ6U1ZCcGtOb3hqNSt0YzIvZFd4?=
 =?utf-8?B?Z29xdi95ekEzSFZnelRuRGtrMFVuNDgyQVZxcHB1YXllMzJUWkR6UzlVWE9z?=
 =?utf-8?B?b0ZyOUFpWEo2dEpuU2d1RWRXd2EyajZGc2VtakhySTBGSThBN2VIMFFJMm05?=
 =?utf-8?B?OXUwSXlybUFHVkYwTDhPcjlvdTlkbEZ4TkVqbFZFdmFTNVl2R29vQ2doNjhZ?=
 =?utf-8?B?UWZyN0N2MU43Vmd3SjZzWDQ4QjBZOGUwTWZ5eUQrMEoxYzlmOWZTb2U5ZFdD?=
 =?utf-8?B?cmVOS1V6VDVaWDVac1lVQjB2SDJuSU1STWYyL1lHOG5OMkM3V2lRQVdtbVR3?=
 =?utf-8?B?ZllJNXAydnhhTTVyK0RZS1hNUWRYM1ZSa2ZtRk9nRjVTT0xkd2c4VTlxQzVn?=
 =?utf-8?B?NTZpQUF2TzNpNEF6MEIrNG14OWl1RjA1YVU5Sks2OHZWZmhOc3A3OHMrVUh5?=
 =?utf-8?B?TVptQTBZT1VFY1JxRWtGd3FzOU85cU5yTHIvTXppVnJsUVZwM0QyMHlpczJE?=
 =?utf-8?B?emxqY25uaUNkVXdVL3BET1FBNmZWS3dLdEtvam5hTUgvK0tTT0xXWXdTZVFW?=
 =?utf-8?B?YUd5TXBBYWdJRFlKT1Jyc0FsUjdnekZVUGxqejdIZG05TEt1YmIxV25Kckh1?=
 =?utf-8?B?c2FUV0RQcWp2VDVxUDFSSEFOZHFSSEV5NjhHUnBNV0JWbFkyazJHaE1ML0hw?=
 =?utf-8?B?UUgwa1JWcWtPRlV2Qml3QUdWditZamg1RXc1TlF4dkdjektyWEhWR3RmMHYv?=
 =?utf-8?B?MHNYdS9hVVh1RjNaanIvZHV0WmJXN2hhWG5NKzFXMnBKdk10dU9PaVJqWmVB?=
 =?utf-8?B?eDlnZk92MTZTZTZPNktEY3UyRHNWekFEb3BZRTRrVVdwSTRmMFdzVnRORklJ?=
 =?utf-8?B?UDdxS3ZUbENJNzVTb3ZKZnBWTXJRNzk2a0hmbUlMUWFLNXd5MVBhMkdXNE1U?=
 =?utf-8?B?cmp4TXJmQlpkUFloMjB5WDgvZmV6YndUN0M5blJ4Sk9DNU0zQ3NqaFFkekwr?=
 =?utf-8?B?cnUrQ3RBL0N3cVhJU3p2ZDFDdm04Q1ZBaGZFNi93R2RhUVRyUzI4ZCtJbjdB?=
 =?utf-8?B?QmtBQXc1Q0tENVFkK0dQSFVIdTNyZUlBTjN4dXVrMHowemZQYytObllhek1W?=
 =?utf-8?B?RzlKcjBrSXZxUm0wWjVpZzlsZXhmN2x1T29yU2U5UmdGWHJjK29DLzB4OEJH?=
 =?utf-8?B?SWc4bDFkR3J0UlBqYml3eHRQTkI4Tk55K1B0cXB6bzExa3NiL0xxVTNjWUpW?=
 =?utf-8?B?UlZ0SzZnRVZZQlUwN2Rybms3NWlUSWZPK1lIZVg0V3p5dHRYbmZkZkVqLzk0?=
 =?utf-8?B?SXB0S2lXN1FNVnVTT1FGZEM2eEsyTkVmd1MzcTd0QlRCaUtGQkM2bENzbXAv?=
 =?utf-8?B?aXJtblIwUFIzRWJFN1FSMnpQakJFT0RyZ1BVdStHUkYzMWswUVZyWXNzdEFk?=
 =?utf-8?Q?LP4uWN1uvou6w?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6583.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?LzVXSE9DRFRBSmtFRGEreXFyUXhNZjByRkNXZUpaZHV1aDk2N1lUeHNCdkZD?=
 =?utf-8?B?ZWNFN2dvMGhNb1JTQk4zUUdvOGk2cTduREtmRUlkYmRyM1RWd0JsdENoVEJG?=
 =?utf-8?B?MWVmU1p3VW1UTWg0OVpzZVhsS21PTW5GTXgwTVVZaWd0T1EyK3RZWXAxSzY4?=
 =?utf-8?B?M0pzVWpxaFduaWJFc2ZLeUpEL1p0TWVpQXhxaGVCd3Zjb1M4SUJqWWtpUWZI?=
 =?utf-8?B?ZURVd3RnT1dZdUJxUDd4TmRZaFJ5d3RYYTBoc3RYNmE1Q1htMFlRbE9BVWZk?=
 =?utf-8?B?M3Y2TWtOOG9wRkc5K3Fick9Nc0JSQzZ4Tkd0a1FWUlB2bExQR0hpTkY3NmxY?=
 =?utf-8?B?TThBRHQzVnM3MEhBRGx2V05ka3JHWW9vcTFHWjZaeUlVbEZmejdHUWFoUFUr?=
 =?utf-8?B?b29IWng2eHMyMEplZ2ZxckF3dlRxcHlibnc2Zm1xWUFxa3hqYkdyWHhsaEN1?=
 =?utf-8?B?SzdsZGN4VXhWZCtDeG5OZlp4ZmhHVGs3OHFmT0txTVpFR3NVdkpnMXdBVS8y?=
 =?utf-8?B?ZUdQLzR3WU5yekdNc3YrZTBOVUdsL3ZleWtTMlBCUGs3REdJVi9VVVVrTU9p?=
 =?utf-8?B?cVlzYjdLQVZxSnFXMjBpdjJPb3RGaTFxUUJsMnkxeE11ZTZZUmpiTjJnM3Nl?=
 =?utf-8?B?VFc0SmhFRU1uQUtKS3JUdG1rMDVyWTZLcUZlV2MveThYeFVpVjJzNG52Nkht?=
 =?utf-8?B?cHFIK1d4cURZT2E1OStGQUZJZmNLTmljbVpmbVd2dUhnQW5nK1F2eWZleThN?=
 =?utf-8?B?VnVWWERoZ2pVU1p0NTZodXBzcHBTN016SnB0UEtBbmlBQXNNS0FPNG5HL0Rn?=
 =?utf-8?B?WE5zNlBtSHlldmd0SWpmRDRGNTQ4V1hvbnNOMnBRMG1QcXhLalBSN29PajZP?=
 =?utf-8?B?OGVnbFRKemVMdEx3RmlyL0YvRWpSU1BGZG93VGwycWNtang4Z29LWVhncVNS?=
 =?utf-8?B?YTRpYUVORWRmai9NaG1EQWtjR1Y0NkFwVnFjbUhIb0ZkR3h3d2NDdHJjOG1O?=
 =?utf-8?B?R0IrTWQwTTNqQmIzR1hUQ25vZ1Bia3FRVXZ6cDFyeXpLK29uZVdxUHV5UmFw?=
 =?utf-8?B?ZFJ6bFJuWlJJZ1dqN2pHa2FjTk9WbGZENHF4ZHFwOVNSMUZGbUI3ZWJlVzAw?=
 =?utf-8?B?NlNRalI3K01KUWYwWm5kNEkweGpIMG9kSTdlSEhIbVpyOTlEVCs0YllzU3F4?=
 =?utf-8?B?WllrSDEzbjF3VUFmYzVvdGk0OWpGd3RRMXErdEZxR011VUU1Q1BIcU9PQWZy?=
 =?utf-8?B?blJZblE4ZldjNmR4QkV0cGRWV1N3anFiU1oyT2I0SkJRaHBSR1dWLzFIbDcw?=
 =?utf-8?B?akt4OUNHRHZLNS9WMCs2Ui9Mb1Z6Y0t6SU80cHNGaEtpbnp3WmJVaEZFeWNw?=
 =?utf-8?B?dll4UjZxVXEycy9pNVppeXF0QzNOS1ZDNmdOSXpWYnVYd1RUUFFiUUJSMENK?=
 =?utf-8?B?TEI0Q2dMTzR5MG5sOSszRm9DWFNyNCtpcnRYOWhHK1ZHQWdmRFdEbURJMWlZ?=
 =?utf-8?B?c3NiT0Z3OE9UaVRSOWhReG5xdXpVeTJmMGlROW5ZTzhrdU1jemxhVjNIOHNF?=
 =?utf-8?B?SytJUERObTlJL2MrZWNWOC8rM0UvWlBXV1pRajRERGtaem1WWEFjOXQxRHZI?=
 =?utf-8?B?R3FLS2lUV200Vjcwci9tOStCSHpBSVhDVWpFTFpTcWZPSnowMm9uelQ5alEy?=
 =?utf-8?B?VFFOcXBuVXRaT2E5RlBSUUVPVjgwdDZUVm5yZXZ5MnJET0U2dTRGWFF1Szkw?=
 =?utf-8?B?OHA0U3J2d2hoWlhwM25nSEVNcW43dUI3dXRMS29DQXRwZ2tHV1l4YXBHTmp4?=
 =?utf-8?B?dEt4S20rby9xU0s5STA1b3hSZHgvVU1DRDBCb2MyME5iMkNCMXJoWEh3WWs4?=
 =?utf-8?B?SUlPTGdHZ0w0NUM3YlE2R3V0ZXlxZUtGSWFnczFzaytjbVNqMVVBTmxHVHVL?=
 =?utf-8?B?cGljM1VqcnZYRUdVN3grSGxHMHlsK2tNWGdWZ3lzMzVVUzRJRHlpSnFOc3da?=
 =?utf-8?B?dHNqWDM0QVQrNEhqKzE1bnpWUE5PVmFnZTZMRXBnR0szaVhrdTFlSisrUUxI?=
 =?utf-8?B?eEF1VTVWQmkvNm1vZUFWMERLdjllaTFNUzFsZVlLWFpSY0JqT0Yyd3JWODYv?=
 =?utf-8?Q?NALL8i4dHcQLdjRyJ3YL9n8iv?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bf8b9a70-8fc9-4990-055a-08dd5c53ac22
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6583.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2025 02:07:39.8024
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rSJs+Zno1JDbP33fM5UYr4F0h15SKT+IapO34JzL1SeG7alJ8kgba1hCKQ4nviCj1G4TiiSIozn/GN3EjKOlLw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7693

On 3/4/2025 11:52 AM, Jason Gunthorpe wrote:
> On Fri, Feb 28, 2025 at 05:35:53PM -0800, Shannon Nelson wrote:
> 
>> +     /* reject unsupported and/or out of scope commands */
>> +     op_entry = (struct pds_fwctl_query_data_operation *)ep_info->operations->entries;
>> +     for (i = 0; i < ep_info->operations->num_entries; i++) {
>> +             if (PDS_FWCTL_RPC_OPCODE_CMP(rpc->in.op, op_entry[i].id)) {
>> +                     if (scope < op_entry[i].scope)
>> +                             return -EPERM;
>> +                     return 0;
> 
> Oh I see, you are doing the scope like CXL with a "command intent's
> report". That is a good idea.
> 
>> +     if (rpc->in.len > 0) {
>> +             in_payload = kzalloc(rpc->in.len, GFP_KERNEL);
>> +             if (!in_payload) {
>> +                     dev_err(dev, "Failed to allocate in_payload\n");
>> +                     out = ERR_PTR(-ENOMEM);
>> +                     goto done;
>> +             }
>> +
>> +             if (copy_from_user(in_payload, u64_to_user_ptr(rpc->in.payload),
>> +                                rpc->in.len)) {
>> +                     dev_err(dev, "Failed to copy in_payload from user\n");
>> +                     out = ERR_PTR(-EFAULT);
>> +                     goto done;
>> +             }
> 
> This wasn't really the intention to have a payload pointer inside the
> existing payload pointer, is it the same issue as CXL where you wanted
> a header?
> 
> I see your FW API also can't take a scatterlist, so it makes sense it
> needs to be linearized like this.
> 
> I don't think it makes a difference to have the indirection or not, it
> would be a bunch of stuff to keep the header seperate from the payload
> and then still also end up with memcpy in the driver, so leave it.
> 
>> +#define PDS_FWCTL_RPC_OPCODE_CMD_SHIFT       0
>> +#define PDS_FWCTL_RPC_OPCODE_CMD_MASK        GENMASK(15, PDS_FWCTL_RPC_OPCODE_CMD_SHIFT)
>> +#define PDS_FWCTL_RPC_OPCODE_VER_SHIFT       16
>> +#define PDS_FWCTL_RPC_OPCODE_VER_MASK        GENMASK(23, PDS_FWCTL_RPC_OPCODE_VER_SHIFT)
>> +
>> +#define PDS_FWCTL_RPC_OPCODE_GET_CMD(op)     \
>> +     (((op) & PDS_FWCTL_RPC_OPCODE_CMD_MASK) >> PDS_FWCTL_RPC_OPCODE_CMD_SHIFT)
> 
> Isn't that FIELD_GET?

Hmm... I think so.  I'll poke at that.

> 
>> +struct fwctl_rpc_pds {
>> +     struct {
>> +             __u32 op;
>> +             __u32 ep;
>> +             __u32 rsvd;
>> +             __u32 len;
>> +             __u64 payload;
>> +     } in;
>> +     struct {
>> +             __u32 retval;
>> +             __u32 rsvd[2];
>> +             __u32 len;
>> +             __u64 payload;
>> +     } out;
>> +};
> 
> Use __aligned_u64 in the uapi headers

Sure.

Thanks,
sln



> 
> Jason


