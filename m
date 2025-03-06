Return-Path: <linux-rdma+bounces-8397-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EF77A5403F
	for <lists+linux-rdma@lfdr.de>; Thu,  6 Mar 2025 03:05:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 252C916E0D0
	for <lists+linux-rdma@lfdr.de>; Thu,  6 Mar 2025 02:05:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2553D18C930;
	Thu,  6 Mar 2025 02:05:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="X0bQDUHY"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2058.outbound.protection.outlook.com [40.107.243.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DBAAF9F8;
	Thu,  6 Mar 2025 02:05:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741226710; cv=fail; b=OsKe2AhSIkb6wFGhrCwY4Bw1jREC8YAxvTUVsXoFVKBJSpjGn/dja0fjqnzShUI1Fu2JXBwyRBma7Bs9LM3y1nWqW6RmM+AMxn0Gu8zbvPM4EvOgitaBaXWDWKGlD4Ad6cniWU1JOct8XXCQsAUfLAHIbJB7/T+TyePwdUC0vlw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741226710; c=relaxed/simple;
	bh=dncnW9CTAxClymEceg4+5Lo/fdmL4xCD44LtGk4cTbM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=KS+9jgeWeyqbVCyjcMb7jGOgloH0yN/eStPpOxsUS9DZVipmTD6Rv86Jgqbgo7oFA5i8f2fxBDhwrjmmjLhWawwH94Z8czVDarzJeW2xZg7wXDGxPEzZEM8eRIZOebEtbf4lgOTCfHzU23sAmCpMATq51L6SM0j7dq17O3VDGAQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=X0bQDUHY; arc=fail smtp.client-ip=40.107.243.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Q7/0JEE1RdgC1/YsHXi0qMpP0Xvi2Bs+kiDwDOhQ1LuWdGUdobLqRIRMoFKXDNo/PAAA68wFYF7xyfslbeZ0URPFLo1HYsTCL5n+Ox/DHgD9rZLWi2MblLdsNoiTeinfZgVx6cXD3Pz6nDh4DK3LDdRTiE0Hz8voq2CwRWgYnAECrZVmOULg98jTixpkJ6q5JTh1hTXkz2LDZxWmrKrWQwBa5ixJE+yS5IysYp5NicjyxUlh34y7NdtytZe2M48PU256O+e8hyZgYp771XWlvF8x9huc1PatU7MsxhsV3XiJg0no2ouDjPO/5NVvTnWNNA2xmMdcIWA1R9kys688mg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wIBlxMgCiEAvz0d1JJg5vr33fYIeosbTn5EBHwQzfCs=;
 b=B5xBOQg35HD7I2PeieO1icq3PNLl4sW41jS+5tNoeIvcyRoKu4rCfkN24Qt84PB9WEcKPpOlZNhyHcfuoiWEb01YJKiXg5OJG4kNf7e5vIGOTh4hlUzVUiPlj7RHSysYPT0hZYZrhvHeHtc3+yn8ckKNitmLvpVrBCM9BM6G18xW2Wc+orP5Ssd4aPxKLErxBy2bH/DNNTB9drjUbnm5hIavFkpFfrdTMay0JY2JEbI/ZSv4OVfPCQPNjpSeK4voDiUbWYmyi57q5n7sVNMLmcUr5d4mqQ4yTWW70PZ/NW4eQwCkMmelkSRtiOHN83yqA6IWVZ/AfeqoZcX6XY2k6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wIBlxMgCiEAvz0d1JJg5vr33fYIeosbTn5EBHwQzfCs=;
 b=X0bQDUHYUibgzom2lDDXXA2qZmlfxHlrMhxXefATTn4H2oOLjf5NDpW7Pv4ecKBsChXQ8uMcdFY5hyIQ74BpJfP3Esd7d9lsLwptg1+6VQ4VbXJ6NbzdytCfSPUNk0oU2AQh/YSApsfOlYHbN8ZXO7LbbZKS3OrfyQB7Yheabps=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB6583.namprd12.prod.outlook.com (2603:10b6:8:d1::12) by
 DM4PR12MB7693.namprd12.prod.outlook.com (2603:10b6:8:103::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8511.17; Thu, 6 Mar 2025 02:05:05 +0000
Received: from DS0PR12MB6583.namprd12.prod.outlook.com
 ([fe80::c8a9:4b0d:e1c7:aecb]) by DS0PR12MB6583.namprd12.prod.outlook.com
 ([fe80::c8a9:4b0d:e1c7:aecb%5]) with mapi id 15.20.8511.015; Thu, 6 Mar 2025
 02:05:05 +0000
Message-ID: <d67da285-14a2-46d4-97d1-29aad9a53e60@amd.com>
Date: Wed, 5 Mar 2025 18:05:02 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/6] pds_fwctl: initial driver framework
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: andrew.gospodarek@broadcom.com, aron.silverton@oracle.com,
 dan.j.williams@intel.com, daniel.vetter@ffwll.ch, dave.jiang@intel.com,
 dsahern@kernel.org, gregkh@linuxfoundation.org, hch@infradead.org,
 itayavr@nvidia.com, jiri@nvidia.com, Jonathan.Cameron@huawei.com,
 kuba@kernel.org, lbloch@nvidia.com, leonro@nvidia.com,
 linux-cxl@vger.kernel.org, linux-rdma@vger.kernel.org,
 netdev@vger.kernel.org, saeedm@nvidia.com, brett.creeley@amd.com
References: <20250301013554.49511-1-shannon.nelson@amd.com>
 <20250301013554.49511-5-shannon.nelson@amd.com>
 <20250304193954.GT133783@nvidia.com>
Content-Language: en-US
From: "Nelson, Shannon" <shannon.nelson@amd.com>
In-Reply-To: <20250304193954.GT133783@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PH7P220CA0142.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:510:327::12) To DS0PR12MB6583.namprd12.prod.outlook.com
 (2603:10b6:8:d1::12)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6583:EE_|DM4PR12MB7693:EE_
X-MS-Office365-Filtering-Correlation-Id: 42448e40-0af4-41a0-416a-08dd5c534ff8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?aDhQNjlUdmpscDlBSHAwSGJNQU91bTlPTm5MRzdBRFphKytJUHlwTEpGV3ZY?=
 =?utf-8?B?Rm1takZGK2hMVDJZK25LWGcvdFlYa0ZjK1Nmd2VJNE95MWljdUVMRnMwWXdq?=
 =?utf-8?B?M09JRi9JanNpUEhrOUdaUmROOFFLdXozRE5MUkJpWW5qMW9PanU4c1FQZ3dV?=
 =?utf-8?B?bE9sQlhGUDZhY2grN0FjQTNDeUtRNVNyTFJuMlRNSS9tZHZpbndIYUg1MEZB?=
 =?utf-8?B?aE91L1dXalhQYlF2VzZKeENTbVRsdllNdnBBeGZGMnZneUNvT01TdXl6Wlkv?=
 =?utf-8?B?cFJxQ2tvN1Y4UUZzWlBUaUl1ajRIakVjMlU1Q21TVG1qTnIrNUVzNCtFNTRm?=
 =?utf-8?B?SDZoV25SQ0NRSnVKN09yM283aUg2UUxoWHMwUm0rT0tVNWhRWG84L0R5R2RV?=
 =?utf-8?B?STZleS9KUUZFcXpUQTZwTk5uZzQ3Q21rUnBHYys2UU02VS95WW1Jc2xHZlpO?=
 =?utf-8?B?NnNJdzg3V2xYVEw0cndmL2ZSYmU0ZTNzdDhMb0tYaFVydkM1OWRGR0JNZm5x?=
 =?utf-8?B?cDh6bjJnQXNvS0tINXFLbEhuM0ZOdGV2NWhIR0pYZXhHK1h3bVpIVWtXanpG?=
 =?utf-8?B?VHJqck5ka01JZDAzak1JNFh5V0pNaFF5ZklPbzU1UkhvQ2xzS1pOcVl4TlJp?=
 =?utf-8?B?YUFKZUlMdFpaakFDTGtJbTJNMktJallzWjRsUFZVWmZ1ME4rYWFnb0VLZEph?=
 =?utf-8?B?cHE3R3BPYTMySE0vQTVJVWtWalVUUklkcVhiamVFUGlJc0JQVGpqTHBvaUZI?=
 =?utf-8?B?QUFhdi84QktLdjBzblJBVlRmNU9OZ3paRSs2YUV6L0pFUmFVdFlwV2pSeitO?=
 =?utf-8?B?SkJWMVl4Rk8yUmlaZ2dyc1p0cUxXYU1xTjNWL3hnamFVQVdIVm5oSit1eGgz?=
 =?utf-8?B?MVllRS92aWdMYXBlc2FROTR4K1RxbEpMQy8wODV5NURndy9LRFZvWEFjN21D?=
 =?utf-8?B?ekxUTTJLckxmYTdpbmorSVRBWlFKdnpKV256alhuak1YNy9VMC9IRll2ZDVu?=
 =?utf-8?B?YnUwbVBGQkYvdUc1aDZSWXVaM01EZmtaTUpMV2NLb1BIVVRDeDFTd3NWcUgw?=
 =?utf-8?B?S2Mzall5QXAwcVR3eFJmUzNOdXZxeHg3TXNqZDJ2Y0NzTXJjNGVVSDNWV3Y3?=
 =?utf-8?B?Uzk4YUVKNjZrTGxzVUJ5aWVmSVdQVEhGSE1mWXNtYXEwU3VZSGp2MEs1TVI5?=
 =?utf-8?B?SWkzN29FY3JaQitRL2xGTHpiK2JxS1hqNDB6ZlNSaEY0NjFYL28vcEFKSmJP?=
 =?utf-8?B?RmFETlUzbVJDb2l2Vk5jSERnY0lRbEtUblRuVnVLZ1JtVUphbW12eFVaOWha?=
 =?utf-8?B?S3RUblh2dlpOQ1N2WGtYcmJqSzZwdHM1c0hhMENOYWR2MlhhRFRjc0hqd1Bs?=
 =?utf-8?B?OXhRNlRGOWEzQzhIcmdhWEVCdjdWREdkNWk0c3AyUC9RaDYrV1ZEL0Q5VGlQ?=
 =?utf-8?B?bjg0M2pzWklhZEhLNlBXbXdPVUI3Y3l1eDUvWVlOakU1R3VGdUQ5ZFFoVkIw?=
 =?utf-8?B?NlVuS2REb2lMYW04NWVBc0JBUXBKbWVhVEN1Q3ZIYXdBY3VqaWgvZ1E1YS9r?=
 =?utf-8?B?LzFtT0xGNkdIcUpXQkYzOGxKWmJBRHRxS1RzeUdweVRXZk56em5QemtmNUZn?=
 =?utf-8?B?eXZyUmpjN1Q2d1preGpMNzBxajM2dzVQTGV4ME5KcUZBb21JOXFIUmhNYXRp?=
 =?utf-8?B?VUd5QTlLUmg1MUpqT3g5eDlEUytQQVB5TUs2ZE9mdjVTMmNmMGd4REhmOTRa?=
 =?utf-8?B?SlJHM0UxNTVLVnptQzNnb1JKZ0VZclNIWk50c210UzZCZmJWdkpManNwTktj?=
 =?utf-8?B?QXMvbW9wMHFoM1g0Q2N6U1IvSGZtL2FyMEN5QXdjcWxEMVdlZ2daTUR2bDUz?=
 =?utf-8?Q?v/VXQZSvNOY0X?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6583.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QjQ5Q3J0QTA5Vk5aUTBFRVdMNjVzOTN3TVE2aWgzMWV1cWFVTjI1M3JzaXY4?=
 =?utf-8?B?TkdZZTR5Ni9ia3lCT3FPNXhvTUdvaXNQbVJjcVAzSzROaEl4VldmdENxcVl3?=
 =?utf-8?B?YUVObTlPMW5SZXlUMDhNa09HeGRYaWdVdjFxUTVaSTlreGljMElQeW9JdSti?=
 =?utf-8?B?R0FCZWtIQWZJWUFQb09nMWEzZU85SVNFd0sxYXE4aDlXemovR1FueTczTFFE?=
 =?utf-8?B?aThJemRFWmoxZjZhN1UzZWxzWTQzRmhpSWgrblk0VnhCTkwyVmlBVldFSUpU?=
 =?utf-8?B?TlNWa2IzcmZ1WWFoby91QmxnRWw2VTBOdVJwVjlFZkFRSXgrbFJya0ZwRjZD?=
 =?utf-8?B?blg1b3ZmVG1FUXg4ZnB2WG1mUENqcXB6ODI0MGNqaVlZclBLQ1VCYXNYNXds?=
 =?utf-8?B?ZW0xNUY5c1lEeFI3N3NCU1RqNjVURXluSlhMdlEyYkVvaFAyV1BzekYySmtP?=
 =?utf-8?B?YkJjQ3I5SG0wNGhobFJCdlVDL3NJdXN5VDlvamNaOStqdzY2dWNRZzZQNTBT?=
 =?utf-8?B?ekhDM3Rxb2hmOEJrcGcrUE5rbm9KZmNyMkd1anRmRzRaZ0lIQXB5MmZBdnBq?=
 =?utf-8?B?a3UrK2c0dVhVdEdrRzZXcVhuSGE3dW5YbjVCWnVuOWxvTm9kQ3dmL0dlUUZw?=
 =?utf-8?B?emVHUmY5V2VPVHRXRE82MGNmVlFuR2FidjFQd1Vpelp2Z2l1Ty9wYkJMbzZs?=
 =?utf-8?B?dmYwOEI5OE5OS1RSbmtYU2NWd1ZIL0gvTFhPNEM0ZTh1MENGbnkxYnNiazNE?=
 =?utf-8?B?Sk1IdWo1Ymt6M09YaWgxSEJUMHlFV0FucFpoTU5pY2tkdFFBSXlGODFWbk5k?=
 =?utf-8?B?UHJCYTM2ZDhoa2NLRlBySGFySTZzT09SMVJYNW5lSEhkYWxab3VrRktKZFR6?=
 =?utf-8?B?Q1JpTmRQbHdFTzR6VWFXRWt2YTYyM05KWDJPV3BiZy9rT1hadGcvc3FJNWh1?=
 =?utf-8?B?c0xlOG9ocU54M3E4T3ZwSGZoRUxnNmtDbitwbWl3cDhmQmVRZTcyMFdXdnd2?=
 =?utf-8?B?YXhYMytEd3JUWms0OURPbndPcmNYY201ZkdaVitzcVYzSnY0OTN0UzRLQ3R5?=
 =?utf-8?B?cFZBOWxyQjBlVUJub01HYUZaNnl6YjZ2U2FDZEhXVlo2N3ZVVzBQa1I4blR1?=
 =?utf-8?B?MVJGZ1ZQTnZrdEo2Tk1aQ3A3NlV3TmFsSnJOTnBZZEhZdXJOVmh2UFFBTkdm?=
 =?utf-8?B?QnBQL1lRVWhKSnZvZC90SFg5OExpSkIzU0E1aEpXRDVHQ3J1aUNONDJqYmNm?=
 =?utf-8?B?TXV0eUFEN2Z1NHpMODJpR1lzUVJBdFBFY2h3bmhKOEcxNytFMEZBVE5uTEJ3?=
 =?utf-8?B?akNrY3lRaUVLdkFCT2RKUkpIajNQNmFySEw0MVhDUTl5VEh0Y01HV3NBTUJ5?=
 =?utf-8?B?eDJqTTU3djJ4VG9NK0NnVktoM2EzTU9BTUpFdm1GN1lPeGY3Y0VRQk56cFM2?=
 =?utf-8?B?bDNueCszaUFLaGZlTzArY05renNkUHY2WE9aZWhHOHR3bW16MSs5L08yMXBy?=
 =?utf-8?B?ZGljT2IxdldSYWV1THFzcmZEd1Y0ZVREUmR1QzlNMnR0M0phTGhqTUJlK0RP?=
 =?utf-8?B?aTFDYkpxdUdlRlhOa25ZTXl3ZTRINGdVWnFmVytiUnBVMHZQK1dMQ2l1QTBD?=
 =?utf-8?B?bFN0WUlCUDlTRHp3cVVOMVljV0pubUl3UzNTUTAwZnl1S2ZLSG5URlQ3djFo?=
 =?utf-8?B?YVZHVDJoVGdaVFRWQzBiM00zSy82ZHN6bmcxOWtJSWQrMkNOakpsVVNoMGsw?=
 =?utf-8?B?T3NOOVJFcW1oQ1dIbllrbXRaUm9Bei9vcTIxNHVkblByUUdmY3NEYzRtL0R1?=
 =?utf-8?B?czMxaGQrTTkxMURVSjVrSUdDemlLZG00L2E1ak1DVG0reW0wamVxRThFL1l1?=
 =?utf-8?B?enFtZnRGTUR3MloxbVA1dmJUVFhjSm9DT1NWNVJoclNlZFFRbkVQcmNWYmE5?=
 =?utf-8?B?QlRLRiswS3ZDN2IwZ0hZWVVrUE1HUmh5VTFnV3gxaFliTGF1dnVQbkw5cHhH?=
 =?utf-8?B?YVE3RktUK1QvdE9CK0owYXBNQjZEZjNGZUk5RGFUKzc5NXowWnRiWUQ2M1My?=
 =?utf-8?B?VDFaODhudWNDNUgwRTJya0VEYVVTbjJNWW5NeEl0S3A5QzY3QjA2ZEIzSThu?=
 =?utf-8?Q?pdFfMwNX0f60ANOR1rsC2Ixz4?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 42448e40-0af4-41a0-416a-08dd5c534ff8
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6583.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2025 02:05:05.1719
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 73V0FJR5NaPgq8PcO5M9PvIrSxotvFlKO6VGIbMpsi/ZsePNUjIa25Ii3+fRafYVuGQHtbz6+JejFM4JfB5tpg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7693

On 3/4/2025 11:39 AM, Jason Gunthorpe wrote:
> On Fri, Feb 28, 2025 at 05:35:52PM -0800, Shannon Nelson wrote:
>> +static int pdsfc_identify(struct pdsfc_dev *pdsfc)
>> +{
>> +     struct device *dev = &pdsfc->fwctl.dev;
>> +     union pds_core_adminq_comp comp = {0};
>> +     union pds_core_adminq_cmd cmd;
>> +     struct pds_fwctl_ident *ident;
>> +     dma_addr_t ident_pa;
>> +     int err = 0;
>> +
>> +     ident = dma_alloc_coherent(dev->parent, sizeof(*ident), &ident_pa, GFP_KERNEL);
>> +     err = dma_mapping_error(dev->parent, ident_pa);
>> +     if (err) {
>> +             dev_err(dev, "Failed to map ident buffer\n");
>> +             return err;
>> +     }
>> +
>> +     cmd = (union pds_core_adminq_cmd) {
>> +             .fwctl_ident = {
>> +                     .opcode = PDS_FWCTL_CMD_IDENT,
>> +                     .version = 0,
>> +                     .len = cpu_to_le32(sizeof(*ident)),
>> +                     .ident_pa = cpu_to_le64(ident_pa),
>> +             }
>> +     };
>> +
>> +     err = pds_client_adminq_cmd(pdsfc->padev, &cmd, sizeof(cmd), &comp, 0);
>> +     if (err)
>> +             dev_err(dev, "Failed to send adminq cmd opcode: %u err: %d\n",
>> +                     cmd.fwctl_ident.opcode, err);
>> +     else
>> +             pdsfc->ident = *ident;
>> +
>> +     dma_free_coherent(dev->parent, sizeof(*ident), ident, ident_pa);
>> +
>> +     return 0;
> 
> Is it intential to loose the pds_client_adminq_cmd err? Maybe needs a
> comment if so

Good catch - thanks, will fix.

> 
>> +/**
>> + * struct pds_fwctl_cmd - Firmware control command structure
>> + * @opcode: Opcode
>> + * @rsvd:   Word boundary padding
>> + * @ep:     Endpoint identifier.
>> + * @op:     Operation identifier.
>> + */
>> +struct pds_fwctl_cmd {
>> +     u8     opcode;
>> +     u8     rsvd[3];
>> +     __le32 ep;
>> +     __le32 op;
>> +} __packed;
> 
> What's your plan for the scope indication? Right now this would be
> restricted to the most restricted FWCTL_RPC_CONFIGURATION scope in FW.

As you noticed in the next patch, the scope restrictions will come from 
the FW when we request endpoint and operation information.

> 
>> +/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
>> +/* Copyright(c) Advanced Micro Devices, Inc */
>> +
>> +/*
>> + * fwctl interface info for pds_fwctl
>> + */
>> +
>> +#ifndef _UAPI_FWCTL_PDS_H_
>> +#define _UAPI_FWCTL_PDS_H_
>> +
>> +#include <linux/types.h>
>> +
>> +/*
>> + * struct fwctl_info_pds
>> + *
>> + * Return basic information about the FW interface available.
>> + */
>> +struct fwctl_info_pds {
>> +     __u32 uid;
> 
> I think Jonathon remarked, the uid should go since it isn't used.

yep

Thanks,
sln

> 
> Jason


