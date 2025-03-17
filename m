Return-Path: <linux-rdma+bounces-8761-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 47905A661C5
	for <lists+linux-rdma@lfdr.de>; Mon, 17 Mar 2025 23:38:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EB4881899196
	for <lists+linux-rdma@lfdr.de>; Mon, 17 Mar 2025 22:38:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DC71202F60;
	Mon, 17 Mar 2025 22:38:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="h8zQ8NPM"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2078.outbound.protection.outlook.com [40.107.94.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 885671DDC16;
	Mon, 17 Mar 2025 22:38:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742251089; cv=fail; b=jGHOjtWw0eQxA3An2S0852yC5C8oo3AJsfegclpoh5hky6TlzkSgzRrj/XrlDsApewKMZPuUeRI8nxlC43VHDvKm1S1+Rf5CY+4j62xds+rTufjS76EqJfamt7LAb+A3e78j5x6KT0Sq+tErpSLjXZPzmbFt/pzsOMFB1Dzat94=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742251089; c=relaxed/simple;
	bh=V1CO9yZYpdJsrvPsF30w860ND8BiLYW/Lp2PX2UrUJY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=LxAACq0hjvevzmfPHecycEjSIKVsNf8gjg8R5kuZe5FIICX2n+DjwN227smNTbRMTtkw0JGSK4ba+CF/xaOUwl/YQr6Vjrd6azBASJFXqX8QsGf3W/YONFu8lhdTJFw8Yt4YTL4VKa/lWmItcR1ak2mxWnj1f7MQaWsEb+Uw3hI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=h8zQ8NPM; arc=fail smtp.client-ip=40.107.94.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pNxlvyXOnItZc0rmbBv8kP024UPrgGivMk5gnPngXzK9W/UdAXAm7gC55iVOCo9i60Yfeso7iDT1y1kKsEskByV+4US8GdGVRlQlXuHWpwWvufT2cLWdQYWvbybhqTx9qyrXyNicKAoOjPT88aqib44ZtUBxlyGfK7+rnW+f1dZl4i5iKnh6EgpNzqrsc2dQcqdsMElB4tCpTD72kC1p877nFZnxpLJE2YnRPkz03WGRmlWLYSFI/b8kyBVAllLWfbCTxveWp95oeI45ffTD5s6x6/MxALkwnA/jG2ammT1JuAjmahbDU0I7fTTQ7g6vu9Ag0BvJPte2Qkl9+DXJUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/adQLZBSfS7BcGlmbT5oC6jaZUaOc5dUxNFxEQgqrIQ=;
 b=i6MjT7WQak+ToMZNbbSEZ2JKXDjEW3pqHubu3ybo5eBrpGyWASH5fTaYV6pZJWkxGwmFt28nTFzZslxmDefNIXrThpfqW9S9uQZRFTQzvv/2k+qSQ/THfZOhW1sUk+MLZtkXR74nYlg5kpJhYb1ySPJK6PWx1CnHkO19jS2jPJH5+ZCpi1164wpIjP4BJj5rysYp3cQKSaht9CBXDGITvt/9Cu7RGh/yIZc4g5Ye9UbWQu6COIAk6LAYQM0Xp5TsKhaNli8fmPhheuj7djFQV0qA0R7TTItamUvSWX1XJsdzLmKCDKoC/OApIlPJYrpSMz4PtLlAiT6Qof3dn7Ijew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/adQLZBSfS7BcGlmbT5oC6jaZUaOc5dUxNFxEQgqrIQ=;
 b=h8zQ8NPMabMlEwYdNnoXbwEvfd6nHJtKZaqlpElDMNF6Iabl6wzUKPF739Ojd44gTYCOghuTtiFcBEtHrYfY9L0MYK1h8N0phreDL5ezr3/p3vYXGmHaONWxL6ezPw2vrR8VasEmqAgR0fn9Q7r8gZ7kpwvWGa17TYFg7S2mUR4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB6583.namprd12.prod.outlook.com (2603:10b6:8:d1::12) by
 DM4PR12MB7551.namprd12.prod.outlook.com (2603:10b6:8:10d::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8534.33; Mon, 17 Mar 2025 22:38:01 +0000
Received: from DS0PR12MB6583.namprd12.prod.outlook.com
 ([fe80::c8a9:4b0d:e1c7:aecb]) by DS0PR12MB6583.namprd12.prod.outlook.com
 ([fe80::c8a9:4b0d:e1c7:aecb%5]) with mapi id 15.20.8534.031; Mon, 17 Mar 2025
 22:38:01 +0000
Message-ID: <70e61c29-cad4-4463-9d13-2cc2ca97862f@amd.com>
Date: Mon, 17 Mar 2025 15:37:39 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/6] pds_core: add new fwctl auxiliary_device
To: Dave Jiang <dave.jiang@intel.com>, jgg@nvidia.com,
 andrew.gospodarek@broadcom.com, aron.silverton@oracle.com,
 dan.j.williams@intel.com, daniel.vetter@ffwll.ch, dsahern@kernel.org,
 gregkh@linuxfoundation.org, hch@infradead.org, itayavr@nvidia.com,
 jiri@nvidia.com, Jonathan.Cameron@huawei.com, kuba@kernel.org,
 lbloch@nvidia.com, leonro@nvidia.com, linux-cxl@vger.kernel.org,
 linux-rdma@vger.kernel.org, netdev@vger.kernel.org, saeedm@nvidia.com
Cc: brett.creeley@amd.com
References: <20250307185329.35034-1-shannon.nelson@amd.com>
 <20250307185329.35034-4-shannon.nelson@amd.com>
 <d63a0509-404a-4abd-90b9-d5ebb408ce98@intel.com>
Content-Language: en-US
From: "Nelson, Shannon" <shannon.nelson@amd.com>
In-Reply-To: <d63a0509-404a-4abd-90b9-d5ebb408ce98@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR07CA0106.namprd07.prod.outlook.com
 (2603:10b6:a03:12b::47) To DS0PR12MB6583.namprd12.prod.outlook.com
 (2603:10b6:8:d1::12)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6583:EE_|DM4PR12MB7551:EE_
X-MS-Office365-Filtering-Correlation-Id: 4c393fe0-ad70-44b3-7113-08dd65a4546e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|7416014|921020|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?QmJ0Z3psa2lJSnptVzFiMlp3bFRMTXd1MVNsUTI5U2tFRHpyem5DSWNqN2lQ?=
 =?utf-8?B?Rll5VkdBQTk2TkcxamNZb2Nibk1HSXdxYWFmc1NzRjh3ck9YYzZqVGdBSDFr?=
 =?utf-8?B?OU9kZDJuUUZoT294K1cxMWJhQXJuMHJucmVVS1dQZnNrUTF5NzlGNWw4OGJu?=
 =?utf-8?B?bXZmQTNMZ2UyMUJjZ1dtYU5Xek4wM1dSaFRoY1hoQXJuUFpZNGhUQkUzTDBW?=
 =?utf-8?B?ZjJGSkcxRC90d1l4dzlNdXVUWUcxckdQa1Y0c0tVZEtYWktiVitnN1BoYWE1?=
 =?utf-8?B?TU9hbkVTZEtBRUNMeEZyN1o1M2wrek85S1RhcWpXOWRjVnRRczNLZUZPT2t1?=
 =?utf-8?B?QzhsOUt6YUp6Y3ZyeDFRQ0xCaTlFbGZxT2o0N0g1VnB5VklQZnlRekg4c0dl?=
 =?utf-8?B?K0JHYS9BY3lKNXFGM09tL3kzMWY0ZURadStoM2xSUklSUGt0YlNSWWhqQVhj?=
 =?utf-8?B?OW50TWlhU016QW92MDUzK1dxSzBGN09YWGUyK3JDbEVzWDJqemR2ZEY3NEw2?=
 =?utf-8?B?OHI0dnpLL2tXcXRRWllNdytxSFoxOWFteXh6bDliUlZ5VUt1QnZ3OTFQa3hk?=
 =?utf-8?B?L3lPSHEzd3laS3pqT2J5Z1JmQ0RFMDV3cjJZM1AvYStZOFFlcVNHZURzSGVC?=
 =?utf-8?B?ZW1qdUhnKzM4d2htRnU1c0hPNUwwWkxoWUJ1ak5MdktpeEZMUmdRQnp3YXFH?=
 =?utf-8?B?NjVjcjl6b0V4UW8xelNIQVlqVE9NUzVMZ1RJRXlNSG1LZ3pJQ2JOOE9ISjZy?=
 =?utf-8?B?MWx3UDhjcnd1N003NFZRcTdwc3ZiVXVVV0kyY1liS3Ftb3dxMytpdlN2V2xn?=
 =?utf-8?B?LzJ1ZXBmWk1HUS9IVDRINkpFTDFFK3h1aDRGVERUejgxVE9MbGxwa3V6aFNq?=
 =?utf-8?B?cGJ4YzA5NEZSWVp1RU51bklKOGhOUmFieU9laHl5OFlKYk5jY0ovMk1RREM5?=
 =?utf-8?B?aHRlczFQQm1DdFZhMzA5SWFqOExWblFhbEFDUW5oUWdwODZpODh2VHg3NGRl?=
 =?utf-8?B?YmwrcFhEbkhsTm9qNFNiQXBQNHhISGxOMnFrKzVhNGUrTzgxdzV4Z2w4Tmhh?=
 =?utf-8?B?QVdrUjV2Y3dmYStNbTdXWEoxZ3A0aUgzaDhEVDlIWVNVaVRKQ0hXQm1ieUk3?=
 =?utf-8?B?RFlONHRVYk5mTSsya0VnRW94d3Y1R3o4akNXdzhiUDRVbTlYVXh3dStUZ2kx?=
 =?utf-8?B?QVN6bnhPL2MxakNHbTNCSTdGU3VFUWNBT2RQVU5Na1plNk5ZZmxibk9uRm0r?=
 =?utf-8?B?UHRsL3lRQTVBL0U2eXdjdmZEc0w5WnFNZkhNTlR1Sy91N0laT2VKN2Q0RjFp?=
 =?utf-8?B?cFdIc1MybWRxWlBWYXkxTUNvcnJ0aFh1YWhIRWNKdmdLODA2aXZ2RGEwaWZI?=
 =?utf-8?B?WTVyenMrRms2aUFVYXhiUWdTREl6b2EzMjdiQTJRVWkvZHcrUWdkbDlRem1J?=
 =?utf-8?B?SVYxN0VRM1AzUVJGMm5VRnVGY1FVUitkMnFPSkR4M1VubWVOZTZUSkZPbDdt?=
 =?utf-8?B?ZS8yYjB1QzVDTkhFY3pUOGRDWmtvTWdDMUVlMGNrUHNoOHF6U3Z2VWVhVUhq?=
 =?utf-8?B?VkxUdW56ZVBvRmFGOTVZUVk3bUhSc2JvUTAxRVZRSjFCbTBCR2U3TzNiSk1B?=
 =?utf-8?B?UmJCKzBObDlWWlM0K0ZGcE43bXFubm1MQ052TEtwZUNmODQySHoxM3FzYmJB?=
 =?utf-8?B?S1JHaDk2V0V4SjE5dmkvbUFqNWpZaTNNOHYvUWRtNHN2Sm0xc2djdVJ4aVI0?=
 =?utf-8?B?UkFNcVNELytJbmtDMllhUGtBQVRwYzNQaTM0d3hkMkxYOGFsUlNXM3BrTVR3?=
 =?utf-8?B?NUdoTUlKbnRZcVB5bU9LT1R0S0tFU3lQbXNIVUdodFV1ZFd4UWZ5SkhhL0w5?=
 =?utf-8?B?c3RxaHdLcEtJN2VVMkZMaUFlMlVIS0hpb2szL1hWV1MzVVhiaHp0OFBlcEJ0?=
 =?utf-8?Q?66shkGCWvDs=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6583.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(921020)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VGJ0eGJxZytIcTR5RWZWU2VoTW1TVm9GcXFmR0s0MWFDQmxlWHdHSkl3dFN1?=
 =?utf-8?B?Tzc1b3piN2dtT2M5dHQ2RkdVdkc3eEphZnR3VU5QT0FkOVBjbHF0TklmSFBG?=
 =?utf-8?B?bHRpakgyV1A4eFBEdnBqdVQxR25ia2VJclZTeTlXcFp5bFBtby9MbVpjd3du?=
 =?utf-8?B?TnFDaVpybnNkT1FzVG9GUmlhUWNmR0Jwd0M0SkY4bE9XTVZZbnVXTFVObWpF?=
 =?utf-8?B?TnNXS0pNM05tRmlWRzZFb1M2NFlPaCtueUcrSmh4OWx6eTAwclVXTk1sOFli?=
 =?utf-8?B?cXI4MDRFbjFNU3F2OGhCU3FJLzVMbmYwc0d0bjZnRzI1UDl2SVB5OHZCMkZw?=
 =?utf-8?B?Q1pkT0lJREFkYUNXeWE5RlQyVHZiTGsxMmlZTk15TFJwS21obWVsL09LeWZu?=
 =?utf-8?B?ZUlBODh4SkFFSDVwSy9wbHhQeTErTFVIUmxDbHFKejVjUStudDZBd2lUYkE0?=
 =?utf-8?B?b3lFQndvUVNWd3JRa1h3QlVIbVp4RVI1b0t4dVNXOTNaREtvVEVLalJRUDZC?=
 =?utf-8?B?S3NPTHFDd3FIdUJDUHpPN1FNbGJjRFl0QlBEVmthUmVtZjJWdEhBWk14RTlx?=
 =?utf-8?B?Y0VYUVdZSlMvYXZlUWYwR3N1RCt0WHhCYkMwQ1hmbmJrV0JONUx0RFNNd0ZS?=
 =?utf-8?B?aVZHS2pqL280Y2t4MzNOaXg2cnlDZVEzUkR0eldoU1RTMDNsMkQ0aDVyQmh4?=
 =?utf-8?B?SDVrOW1KLzh5TE1ZajRtQzZSRTdmQUlrUmZqcVdaTXFhZUM5Y1FoTlcwN2pM?=
 =?utf-8?B?Yjd5S1pBQkdMRWUyV1FPTDU1NURDcTlpTFVBcCtqaHBmdDlXQnBMOVI5Smdx?=
 =?utf-8?B?STFUdkhaWHVhK29RWUNTK1F4RUJGQWI2eUd3N3lia1hWRHB0MWZPK29mWWFN?=
 =?utf-8?B?SXlwYVlXRmoyOTBZZWZMd0tOU3JLaFVJNHFScDMwMVJMOXMxNFEwaWcrbTVJ?=
 =?utf-8?B?SXUvbCszczF5QWpWNFVwbkZTU2VlSjU3cHBGelVjcHBBMUNtdnQySEYxVEdU?=
 =?utf-8?B?cloxOU1PS3ZLZGppTUFJWEw2eHpCTHdWRjhWemVZODNoRzNXVms3MTVqYjIy?=
 =?utf-8?B?OEtvN2dSVGdEN1c4SXIxVTV0bzZ6NWF6dlRxK09RZ0pLdHNBN0Q1bDJoQVVW?=
 =?utf-8?B?VHdwNE9ETktDNW1oSWxOcmp4QWFCK3VGSlUyYTVSaFVrWkQybHJsblpwOFBH?=
 =?utf-8?B?bXA4SUQ4SmMyazUzTGpRR3NoMGVjSktMbEVWOHA3VFRJQmhiWGxKbmFMUEVo?=
 =?utf-8?B?S0htNlZScGN4Vk1zZXk0Nk5mY21iRlNGbmk0ZnpWLzZuVStkMlRnZUpWRENp?=
 =?utf-8?B?UWZhanRZY1Zud2c1ZUZ5bERGYlB2TmkyWnVJaFFpMkx6cEpaR2xiSE5kZDRU?=
 =?utf-8?B?eTVRY0p0dnF5R1Q3T3k0b01od2psVlNvWmR6cVRTa20zbjcrd0xSd1l4Mm1w?=
 =?utf-8?B?VnVjaGlaako4dUxiZi9iSHFjZER4NTQrQ2lVSHBoWGZqcUNhajA0ZFpPVlZj?=
 =?utf-8?B?eU8ra2VtY25WbFZ6MFpPNjMyNHJvdkNZV0x1MjJNcnFxeEFVdUdtajVaN0Fv?=
 =?utf-8?B?bld4bDFPUGRiTzh5YmJQSndjWmRqbjQwamp6V0dtSE1pcG9LNk96UXA4SkZx?=
 =?utf-8?B?emQ2M0pUc3llNURaM3hhSW1VNWdWWkN2cnMxdGNQK3RnOUNSRktaelUrc1Nk?=
 =?utf-8?B?RVVvMURod3A4SEFySFBBYlRBMjhhS3pFTFRFUGpMVlozVEhETWRScVMzdVBZ?=
 =?utf-8?B?OUIyU3dLS1JyVkxRalRzK0JUa1JldHNSa1BySWR1V2RXRFlRQlZrV0tPU1JD?=
 =?utf-8?B?M0hpUkc5TjMyMFF3dkQyUGNOZ2Q3bVpuSjIvbVNsZWgyajlKU25QWDNVRTVN?=
 =?utf-8?B?ejkxWkJORUFNWjQ3RitVSUZiQjl0Y2R1OXdjRG1NZUF6S0N2THNKK2JRajQ3?=
 =?utf-8?B?QXZkWmtPdEFnUVVTMWlZUWEvTUR4UXN2UlhadGc1cDc2TEwvQS9NN0JZQjcv?=
 =?utf-8?B?azBMc2RNNU1qNXZvR2hINU1UNTNnN3BQUkpmVlRVMGtoMGdKYlBPUStpV3JI?=
 =?utf-8?B?dU9mNDNlYWRiUE9KcmN5M25NaHlzTC9UbHVCdVZFUTVhZXNZa2kxZDhORVhO?=
 =?utf-8?Q?zqLcWrMeERc74hdQ41vAfWPWw?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c393fe0-ad70-44b3-7113-08dd65a4546e
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6583.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2025 22:37:42.3561
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dg/htAIBqZmZVSjAaeidlTm0uA4er2E8LTPOq4Xd9YyWTJbo21+C35XvPH3C7CPz22SVQVmXK5L+SZ/0H5QDSQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7551

On 3/10/2025 10:33 AM, Dave Jiang wrote:
> 
> On 3/7/25 11:53 AM, Shannon Nelson wrote:
>> Add support for a new fwctl-based auxiliary_device for creating a
>> channel for fwctl support into the AMD/Pensando DSC.
>>
>> Reviewed-by: Leon Romanovsky <leonro@nvidia.com>
>> Signed-off-by: Shannon Nelson <shannon.nelson@amd.com>
> 
> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> 
> minor comment below
> 
>> ---
>>   drivers/net/ethernet/amd/pds_core/auxbus.c |  4 ++--
>>   drivers/net/ethernet/amd/pds_core/core.c   |  7 +++++++
>>   drivers/net/ethernet/amd/pds_core/core.h   |  1 +
>>   drivers/net/ethernet/amd/pds_core/main.c   | 14 +++++++++++++-
>>   include/linux/pds/pds_common.h             |  2 ++
>>   5 files changed, 25 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/net/ethernet/amd/pds_core/auxbus.c b/drivers/net/ethernet/amd/pds_core/auxbus.c
>> index 563de9e7ce0a..c9aeb56e8174 100644
>> --- a/drivers/net/ethernet/amd/pds_core/auxbus.c
>> +++ b/drivers/net/ethernet/amd/pds_core/auxbus.c
>> @@ -224,8 +224,8 @@ int pdsc_auxbus_dev_add(struct pdsc *cf, struct pdsc *pf,
>>        }
>>
>>        /* Verify that the type is supported and enabled.  It is not
>> -      * an error if there is no auxbus device support for this
>> -      * VF, it just means something else needs to happen with it.
>> +      * an error if the firmware doesn't support the feature, we
>> +      * just won't set up an auxiliary_device for it.
> 
> s/, we just/; the driver/

Got it, thanks,
sln

> 
> DJ
> 
> 
> 
>>         */
>>        vt_support = !!le16_to_cpu(pf->dev_ident.vif_types[vt]);
>>        if (!(vt_support &&
>> diff --git a/drivers/net/ethernet/amd/pds_core/core.c b/drivers/net/ethernet/amd/pds_core/core.c
>> index 536635e57727..1eb0d92786f7 100644
>> --- a/drivers/net/ethernet/amd/pds_core/core.c
>> +++ b/drivers/net/ethernet/amd/pds_core/core.c
>> @@ -402,6 +402,9 @@ static int pdsc_core_init(struct pdsc *pdsc)
>>   }
>>
>>   static struct pdsc_viftype pdsc_viftype_defaults[] = {
>> +     [PDS_DEV_TYPE_FWCTL] = { .name = PDS_DEV_TYPE_FWCTL_STR,
>> +                              .vif_id = PDS_DEV_TYPE_FWCTL,
>> +                              .dl_id = -1 },
>>        [PDS_DEV_TYPE_VDPA] = { .name = PDS_DEV_TYPE_VDPA_STR,
>>                                .vif_id = PDS_DEV_TYPE_VDPA,
>>                                .dl_id = DEVLINK_PARAM_GENERIC_ID_ENABLE_VNET },
>> @@ -428,6 +431,10 @@ static int pdsc_viftypes_init(struct pdsc *pdsc)
>>
>>                /* See what the Core device has for support */
>>                vt_support = !!le16_to_cpu(pdsc->dev_ident.vif_types[vt]);
>> +
>> +             if (vt == PDS_DEV_TYPE_FWCTL)
>> +                     pdsc->viftype_status[vt].enabled = true;
>> +
>>                dev_dbg(pdsc->dev, "VIF %s is %ssupported\n",
>>                        pdsc->viftype_status[vt].name,
>>                        vt_support ? "" : "not ");
>> diff --git a/drivers/net/ethernet/amd/pds_core/core.h b/drivers/net/ethernet/amd/pds_core/core.h
>> index f075e68c64db..0bf320c43083 100644
>> --- a/drivers/net/ethernet/amd/pds_core/core.h
>> +++ b/drivers/net/ethernet/amd/pds_core/core.h
>> @@ -156,6 +156,7 @@ struct pdsc {
>>        struct dentry *dentry;
>>        struct device *dev;
>>        struct pdsc_dev_bar bars[PDS_CORE_BARS_MAX];
>> +     struct pds_auxiliary_dev *padev;
>>        struct pdsc_vf *vfs;
>>        int num_vfs;
>>        int vf_id;
>> diff --git a/drivers/net/ethernet/amd/pds_core/main.c b/drivers/net/ethernet/amd/pds_core/main.c
>> index a3a68889137b..4843f9249a31 100644
>> --- a/drivers/net/ethernet/amd/pds_core/main.c
>> +++ b/drivers/net/ethernet/amd/pds_core/main.c
>> @@ -265,6 +265,10 @@ static int pdsc_init_pf(struct pdsc *pdsc)
>>
>>        mutex_unlock(&pdsc->config_lock);
>>
>> +     err = pdsc_auxbus_dev_add(pdsc, pdsc, PDS_DEV_TYPE_FWCTL, &pdsc->padev);
>> +     if (err)
>> +             goto err_out_stop;
>> +
>>        dl = priv_to_devlink(pdsc);
>>        devl_lock(dl);
>>        err = devl_params_register(dl, pdsc_dl_params,
>> @@ -273,7 +277,7 @@ static int pdsc_init_pf(struct pdsc *pdsc)
>>                devl_unlock(dl);
>>                dev_warn(pdsc->dev, "Failed to register devlink params: %pe\n",
>>                         ERR_PTR(err));
>> -             goto err_out_stop;
>> +             goto err_out_del_dev;
>>        }
>>
>>        hr = devl_health_reporter_create(dl, &pdsc_fw_reporter_ops, 0, pdsc);
>> @@ -296,6 +300,8 @@ static int pdsc_init_pf(struct pdsc *pdsc)
>>   err_out_unreg_params:
>>        devlink_params_unregister(dl, pdsc_dl_params,
>>                                  ARRAY_SIZE(pdsc_dl_params));
>> +err_out_del_dev:
>> +     pdsc_auxbus_dev_del(pdsc, pdsc, &pdsc->padev);
>>   err_out_stop:
>>        pdsc_stop(pdsc);
>>   err_out_teardown:
>> @@ -427,6 +433,7 @@ static void pdsc_remove(struct pci_dev *pdev)
>>                 * shut themselves down.
>>                 */
>>                pdsc_sriov_configure(pdev, 0);
>> +             pdsc_auxbus_dev_del(pdsc, pdsc, &pdsc->padev);
>>
>>                timer_shutdown_sync(&pdsc->wdtimer);
>>                if (pdsc->wq)
>> @@ -485,6 +492,8 @@ static void pdsc_reset_prepare(struct pci_dev *pdev)
>>                if (!IS_ERR(pf))
>>                        pdsc_auxbus_dev_del(pdsc, pf,
>>                                            &pf->vfs[pdsc->vf_id].padev);
>> +     } else {
>> +             pdsc_auxbus_dev_del(pdsc, pdsc, &pdsc->padev);
>>        }
>>
>>        pdsc_unmap_bars(pdsc);
>> @@ -531,6 +540,9 @@ static void pdsc_reset_done(struct pci_dev *pdev)
>>                if (!IS_ERR(pf))
>>                        pdsc_auxbus_dev_add(pdsc, pf, PDS_DEV_TYPE_VDPA,
>>                                            &pf->vfs[pdsc->vf_id].padev);
>> +     } else {
>> +             pdsc_auxbus_dev_add(pdsc, pdsc, PDS_DEV_TYPE_FWCTL,
>> +                                 &pdsc->padev);
>>        }
>>   }
>>
>> diff --git a/include/linux/pds/pds_common.h b/include/linux/pds/pds_common.h
>> index 5802e1deef24..b193adbe7cc3 100644
>> --- a/include/linux/pds/pds_common.h
>> +++ b/include/linux/pds/pds_common.h
>> @@ -29,6 +29,7 @@ enum pds_core_vif_types {
>>        PDS_DEV_TYPE_ETH        = 3,
>>        PDS_DEV_TYPE_RDMA       = 4,
>>        PDS_DEV_TYPE_LM         = 5,
>> +     PDS_DEV_TYPE_FWCTL      = 6,
>>
>>        /* new ones added before this line */
>>        PDS_DEV_TYPE_MAX        = 16   /* don't change - used in struct size */
>> @@ -40,6 +41,7 @@ enum pds_core_vif_types {
>>   #define PDS_DEV_TYPE_ETH_STR "Eth"
>>   #define PDS_DEV_TYPE_RDMA_STR        "RDMA"
>>   #define PDS_DEV_TYPE_LM_STR  "LM"
>> +#define PDS_DEV_TYPE_FWCTL_STR       "fwctl"
>>
>>   #define PDS_VDPA_DEV_NAME    PDS_CORE_DRV_NAME "." PDS_DEV_TYPE_VDPA_STR
>>   #define PDS_VFIO_LM_DEV_NAME PDS_CORE_DRV_NAME "." PDS_DEV_TYPE_LM_STR "." PDS_DEV_TYPE_VFIO_STR
> 


