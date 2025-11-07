Return-Path: <linux-rdma+bounces-14307-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 66818C4166D
	for <lists+linux-rdma@lfdr.de>; Fri, 07 Nov 2025 20:11:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3EBBA4E5E7C
	for <lists+linux-rdma@lfdr.de>; Fri,  7 Nov 2025 19:11:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1E9A2DFA48;
	Fri,  7 Nov 2025 19:11:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="QD2RESc3"
X-Original-To: linux-rdma@vger.kernel.org
Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013049.outbound.protection.outlook.com [40.93.196.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C1488F7D;
	Fri,  7 Nov 2025 19:11:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762542712; cv=fail; b=T7SBWWGC7UybyYbHa7c7OhcleBNmoGfZtkQP30J+jsgpoUu0BBNayoP7dW9RBKaeK54fZ0y8EeTMCPuvIK33vW/zqe/OIVrxBcePx4a91n0uPBIhbN4ucJnoPv33yT6fFD7sBMmMvDz3JPOpr6Le2jZXBp8KAEwGXxYJ6JqcKkQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762542712; c=relaxed/simple;
	bh=nM1EeVWyCPmilX3oAKfPrA9hfDMGnyCQRNaf1V4ByvI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=LNprxRW2icXZR1x+sUWB0njBm/2pX9RRP7mYU9UlN5YG1TghE8FGb2Wrk4v6CHLC8NolN7//H5OOXak6m2si3b4vwRvJrAejSN6M+UlrKztvjz4d3jZGw9tDj+RQBN81P/jFHUnWNjUHwHq7PI4vTMlsEuhdVQFjcPg0iXI+vGY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=QD2RESc3; arc=fail smtp.client-ip=40.93.196.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GQUpCQiWtm725HiKuXmboPGJRnfiLuxv/x3+6dRTs8yV2i+bXvv2kSdMpRD2ivsqgQeDX6XZnbkRy8NFHXcyX8Ve0XbNEoNRRXwKLY8X9JEvbK7+yQDJueGhpA/iTUquEcVudjztetc4V3gk3m4FPWG04TRuULwhk2We9JGjOwLWF3qirqG34lgDSKr8ApqtZMdfkwntlJDONAhVg2YBXeS0DMXmFOTchUMBuIopAPDRhmlz11geNOu7VWUgR3Ha/PAWCDOLiCl9rsgbMbHHdUlxmaIi5fuoj8b7qoEGZhdImH+H404q8UFvKDriAF6F19hT7YQjRtwkANWJhdDz6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=laBbhsj4DY1tOQ5/6yucMaNMfRcEeQtPqaRANT47H/E=;
 b=U3MDaRWvvxacdcxhvhMqLhI/78699nco6ZAYMPv5Ns7WSvshn93fTwfPT0w7MxSG5ziPioKZu/1c1L822m4rKDG3RimdCI3DCL8HZRoFblK30+3maP7jdfIXkovBvqs+qmT/2492NuSCY9wzfBa1jeIBjMkJyJtYwGg0fV9hyUqtvS6D29Vky+Pl6F1aG95C9SsHUx3ZVMO1+F9D5eat7gU0CR+ch9nrzhvzYy1nFKkS/m8xfZI2Q99fIdx1J3YicWN3PvdZlJZsrVEW4JuNT2RDGzMXhJuJ+zZviELe6Ihs3StmXeExPOn53zfRAIm7c+Gzpl24HoMu7a0CYKbEYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=laBbhsj4DY1tOQ5/6yucMaNMfRcEeQtPqaRANT47H/E=;
 b=QD2RESc3oRdCTit4zoRf52jPjZ7WXdEVje68MMDeLdXwj+3qDMBHvDrOhc7ddVBqEsGIHS8eR3MNuVEzv4gtsSlti2As3ClT1jskbKHziUmqsdmka8D4oyx6HTCqRLVFFNR4soZ/SpzTLikJCnjlXGZqcAU/13rFSZXtkzF6K8O1EpP5hnxNHuGSB1bn9iqpelYbZcnV1RF533dxvVMToR2+g5FdWahBAE+6rwMcI8sKlUwIEwasw0RkiaXgMgPNCZkpTk1mvc9zWnXBVQzqQde0OV2LfLTlXpGUtSIO1O2X81V1B4DDNznXLHTO7LvlpYIv8mFQyIWdtv1JW54CnQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL1PR12MB5205.namprd12.prod.outlook.com (2603:10b6:208:308::17)
 by DM4PR12MB5940.namprd12.prod.outlook.com (2603:10b6:8:6b::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.12; Fri, 7 Nov
 2025 19:11:45 +0000
Received: from BL1PR12MB5205.namprd12.prod.outlook.com
 ([fe80::604c:d57f:52e0:73fe]) by BL1PR12MB5205.namprd12.prod.outlook.com
 ([fe80::604c:d57f:52e0:73fe%4]) with mapi id 15.20.9298.010; Fri, 7 Nov 2025
 19:11:45 +0000
Message-ID: <c9c8b90f-4edb-47da-8ad0-94f9e58d71e0@nvidia.com>
Date: Fri, 7 Nov 2025 11:11:40 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] RDMA/core: Fix uninitialized gid in
 ib_nl_process_good_ip_rsep()
To: Jason Gunthorpe <jgg@ziepe.ca>,
 Kriish Sharma <kriish.sharma2006@gmail.com>
Cc: Leon Romanovsky <leon@kernel.org>, Parav Pandit <parav@nvidia.com>,
 Edward Srouji <edwards@nvidia.com>, linux-rdma@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 syzbot+938fcd548c303fe33c1a@syzkaller.appspotmail.com
References: <20251107041002.2091584-1-kriish.sharma2006@gmail.com>
 <20251107153733.GA1859178@ziepe.ca>
Content-Language: en-US
From: Vlad Dumitrescu <vdumitrescu@nvidia.com>
In-Reply-To: <20251107153733.GA1859178@ziepe.ca>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DS7PR05CA0061.namprd05.prod.outlook.com
 (2603:10b6:8:57::15) To BL1PR12MB5205.namprd12.prod.outlook.com
 (2603:10b6:208:308::17)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5205:EE_|DM4PR12MB5940:EE_
X-MS-Office365-Filtering-Correlation-Id: dede8751-9327-4ed3-7b7b-08de1e317dee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?QlR5V0VJY0pXNGxlZ01Wa0o0R2xQTlFWZTBFRkhKNmZzdHFiRDA4M2VqV0dp?=
 =?utf-8?B?UjlLbmRNWXM3eE5uUks0dmE1N3BzOWtpTFJKMDYwMi9MSGJOWVZoZlFjdEsy?=
 =?utf-8?B?VFlneklzVkpVRHZYRktWTW94N00wdGdVcnoxaDg3MFk3MktzaXluTVFUT3ZE?=
 =?utf-8?B?R1JYN0hXSzcyTGVGVHJsZDBZV0pacE9wVTRUVkF6aDc0QWU5V0dZQ25tTkhQ?=
 =?utf-8?B?bUZFTTdBQUpBU0ZKaUlrRnoyN0NQcGlGQWxZT1dPUU1YNDR3UGpMYXowVEpD?=
 =?utf-8?B?NHJKN3dBM3hvMTY5TGIyRWY2ZWdJL0tpRVJOZnU3eFdKVFVzYmNqSERqSHZK?=
 =?utf-8?B?MkRNa3I4cm4rUm1OVzV2N283SFBGZXlpQXBWMkdHN0NIcDRQNzN0dFdHVWNi?=
 =?utf-8?B?UGZTOVNSazZnZzBKUFZMZG0zZm5kRllxOTg2S1M0WExCaGJiK0hHZk8vUU45?=
 =?utf-8?B?V3lXY1ZFU0VpRzlHdWExVUNyVDJJQXFoQlhPREREOU8xaWkybHBQRUNDZmxT?=
 =?utf-8?B?cGJtMHdjMzc2dVRYNWZ2dlYzR0ZQeFNKSnNCM2N6MzJLVmkzbFAwc0hBdko2?=
 =?utf-8?B?QWZQbWFuT1RpRDNyMlVCUDNUZmxEVmFDb0ZEV2NaMjM0VTltSnQyMzVNWmNl?=
 =?utf-8?B?YjBKOWY0VkVITlZ1OGhnVGtsQ00zWWdLZjZHamp6Z0JnK2lsbGIyNnNKdEVV?=
 =?utf-8?B?ekNzcnRmcTBVWHpDYW1pNloyNFQyWll5ZjA1MXQ3SURHSHpDZEpWYlZJc01U?=
 =?utf-8?B?dllFZm15a3lWWUptRU5Eb2U5bGdrMXpncko1TmxxYUtuNjAzT1lrWURTYkRE?=
 =?utf-8?B?cDZtUjBkQ1J2eE9pMG1BK28yNjdrTVoyNkdmYTRBdTZUbFFCY3RqRDI2NGdt?=
 =?utf-8?B?UzdIQy9EbG5iUERGUE1nWllHeUhjOWVFN25mNGQ4YmlIYnNWQThJYVRnSGQ0?=
 =?utf-8?B?N2svZExYMFdsMXc2dE5MWm1xbTV6ZVVSajdYQTBETGYwYzlOSHBpUko2OUls?=
 =?utf-8?B?eUlrNkRSOWdJdFhGWEdzNlVQNStRbHRrMXJCVS92WmdJRzNzMnRjeURad1VG?=
 =?utf-8?B?clhXU21RbXUrVktOZmxmUkZ6ckcyV3RKQ1JKSkZLQ0F2ZUMrYytXOVBoQ1Ez?=
 =?utf-8?B?QWI5cDhVNEh1Z0RGSWNVRnFHOEV2KzZlaGVOQVBkc09qUDFLNXdzdzJNc1ZS?=
 =?utf-8?B?OU5mRld3b0o3dTAvMnRyT0pvZytEdHR5Snp1ZnBEbG1SZXlVMkU0OXZBZDRx?=
 =?utf-8?B?MWlGanhHUVlHRGhTQzJBVFFyYVJXVFFHZUJRTkVHWVVNc2V1YjQxWUVTc3E3?=
 =?utf-8?B?Q3BoS2d0aU1TNUtBQllaeDlRZ3JTY0NvWXB5bzlabU9kcjNtT09kUkpFenBG?=
 =?utf-8?B?bEZMbFc1K2VHSUtqQ0lGV2pmN0xxY2NtbXB6R2UyTHVuZ1lIcHUxRHRlYTBi?=
 =?utf-8?B?S0lZTktIUVlaNldZQU9FQ0xwRWFCVlFWRUtLcW04VlJ0c0lpbkNmdTdkVXJi?=
 =?utf-8?B?elJBOWhWNmdUWGhadStITlBWSjZScmJOa0NlR3NUaFh5STFoSDdNUUtQcjNh?=
 =?utf-8?B?VER2V0w3dmVHZFdRNXdPUzRsYkduWkk3N1I2amNSeks1bVlJc3JSQVd6bVZB?=
 =?utf-8?B?c3dqVktZNHRYcjRGOU9mQksraXdMNFk1TTVzM2U4cXBLQkhrSjcxcUdHRE53?=
 =?utf-8?B?bWNKWmdDZSthNi9lek0yQlNLbTV5WHphcnVyL1RYSWJzOHF4RUVFR0FMR0Yz?=
 =?utf-8?B?dzVKc1pWcUhOZEJNMGkzdkxPUldPZXdZWTBwdjBWUS92QTdQSkFsNzdpcTBD?=
 =?utf-8?B?a0RUMDVrUHF3YTFVUndPVEZNaHdaM3YyaXp1YUF4bUljenozVUVmQzhKeG1l?=
 =?utf-8?B?bHRyOUtlSW9GTGI5QjVuMEFyall5dHFKUVdkRUVhMHZUR0l1QmdlMXlHb2tL?=
 =?utf-8?Q?7kHD5eYtqGH9KQHO4voGsBsBB3W4rblw?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5205.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bCt1K0Zsb3k2M2hKS0tSRFc2WEJQZTYxQXNaN2lsWVp6WjhlN0x0Z1RQc2c3?=
 =?utf-8?B?UEJRQy9GNUd2MVZiRldvTUlRSDVOZ1VsZnN4UEZXWDVmaHA0cCtTeGYzMDl1?=
 =?utf-8?B?QkZpeEZHaXEzQmNudzMvdDZXWktxVWU3YmRBM2R4ZndyVlUxc3pTT252M2V0?=
 =?utf-8?B?S3drSWFXNHVpV0pWSGVzck5MaFdFY1hiMkVWMmFaSVpuTWVjczN5SXZWTHBi?=
 =?utf-8?B?OFBlSWRUOS9ZWG9BczZvR3pGUnE0R1FBR0NYVkJjWHNEQ3dmS1ZSdWdaL3NW?=
 =?utf-8?B?Mmpra1p2YXU5R0hmZmJnVVlyY1QzVVZlZkhHR3R0MDRWTmFOdWhvVzlTSm1H?=
 =?utf-8?B?aW4reC9zbEtVTm1aSmoxYVJ1WUZiNGFRMVEyKzM0UENHL2R5c1ZGeGxlaVM0?=
 =?utf-8?B?MmhuUUxsdElJOE1pM0FGaGM2R0hBL0FvR1dhUEVIcFJER2VGQWZ4WUVldldo?=
 =?utf-8?B?Z2FCSWJySklmOG80UzYwYkJUNFN5L2UyVnpJYytwY0xSZGc3SC9WaVZSVjBG?=
 =?utf-8?B?MFhSRC80aGlwbXlKalRKdEFIcTJuS3hUL2NURFZKRUdMT25FRkpSMXZ1Q0hy?=
 =?utf-8?B?NTVTTzk0YVZ0RjdHeE54OTJYb2libDJoak9jSE9ja0ZYSGZrYytYRXkrL0Ey?=
 =?utf-8?B?QzRWMnZZVCs0dmUycWNpN0hPM1RTdHNpL3k0Ykp4aEdteldVcnlWNUJMTkZM?=
 =?utf-8?B?bVRXb1hqTmRIMzVBYkZsZFNvanNxK1I4OFZQUnQrMzYyK0JFeDQvcDFwNE52?=
 =?utf-8?B?cXVYOFJSbTF1SU5LYWVnWTNqRXZqeWhwczNLZlAva1ZkRU9Qd3J3a0lGLzhM?=
 =?utf-8?B?dERucVA0cEdQeUdhclU3SUl6MjRkR2MvazlTRkQ1bnJyYldxdEdYUkNYTG4z?=
 =?utf-8?B?cEhKZXZsZUMxajg5K3FXMW96Z2M0bFhqaWNEbXJhNHdaK3NSbUdKS0NpcnU3?=
 =?utf-8?B?MjJxMWxXWEl0Q2RZVDdrMDI5TGFQbWVVYWJOMHZhNUlHbkRrQ1I0KzF3WktE?=
 =?utf-8?B?T29TOXBKakMrbXJOekNuY2lSREg5dCtjRVZvcmRwZ015T1BXVm1YOUFPNnFi?=
 =?utf-8?B?K0krT2l5ZVk3a21wUFRrc2VLQnNibGQxY3g4UHBycm5EdjlNN1gzZUlvakV1?=
 =?utf-8?B?NlRtNUNYWXFJbnhPTnd0U28xTmRxRDZNOHpCQ25EVnJmSmYvZElwL3JrTTBv?=
 =?utf-8?B?Qk9CVzloUWIvOXlLNFFFU2hCUk1QS0lWSk1jRXJBNnJlNEZSRkl1SVJpR3c5?=
 =?utf-8?B?Y3kvUXNDa0MwMVZOQW0zRTc1cXRmL2h4QkNGUmI1ZkU3MGU3RnhCWGhLVHp6?=
 =?utf-8?B?RStLa0VOTG5VcEVUaUNYbHRHVzI1Mkh1UkczVGlST3c1dGJWM0V5VE0zaUJY?=
 =?utf-8?B?bnRNdkhhbmp5S2R6dzFSMmVQeENaL1NGaU5pRE5xcjAwRnUzdW1OeUZvUFVC?=
 =?utf-8?B?MmdHWHNJc0s1Y0xHSCs0MFVqWGhiaXNneFM3TkRtMW0yekZDZGVVWUFaaW5T?=
 =?utf-8?B?bjRkREFHQ2ZUcDdhTWxoMytEZjIwQlJGQzdXZ0xidTNxZnNHOVhXWmJNd0Er?=
 =?utf-8?B?amlUT1g0STVNazZJSW9QbU9PaEc5WGVwZlZ4SDA4Qy9zVzlqK3hZRlBmMnVI?=
 =?utf-8?B?TFhsY3FwQnB6am1GZll2eFVjdmx1OVVkT1NHR1ZNRkdJZy80R0lod1dvUmZa?=
 =?utf-8?B?by84QmxFdGN5dmNxVW8zbTJvdnhBa25rRUNHaUthcU1MVXJ0azJDR0FCQjJS?=
 =?utf-8?B?aXE2aTduNy9XZERldm5CbG9TcTVENy9BZDZWQ0dmMEQyN2dFWDZ4aXdKU2tk?=
 =?utf-8?B?d1JVd1JHVEJ3dm9SVC8wREpVbjF2c1Jsc1ZJZi9MVjFIRVoxaXRkMG1LT2R5?=
 =?utf-8?B?SkJaZVY4czFBcmFtakptRVluRkkvYXV5K0hMbm1ybnI0eHdGYUtYK0x0bEdk?=
 =?utf-8?B?U2htODg4UGdYRlVoL3lEQjIwQmNOWTJTWjhFL0ZKYTd2SWwvQ3ZRRkpsaksr?=
 =?utf-8?B?WUl3N2owSjdXYXc3TzhzcFFJbG5nTFM5b3MrdEd6MXBKcnJYeUYyRGpXbTJj?=
 =?utf-8?B?UU9HOUY1SGhxMithOUpqN0JnWk93dzlIZXZDNDNZdFlPUjJoR1Jla3N4dXp5?=
 =?utf-8?B?RzN4WHFMbjk1ZVNtVUhSUU1EVUIwM3l5UkdzSXNpQjZJRm5TN0xodjBpclpU?=
 =?utf-8?B?R0E9PQ==?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dede8751-9327-4ed3-7b7b-08de1e317dee
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5205.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2025 19:11:45.0856
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: brvzDlRrtUivCADLpvEpOmPyD4dRQUxDp309SJlMcQaivlhRREKWtIbpCV23kjdSHMt280aOdxCVAcenDBpAcQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5940

On 11/7/25 07:37, Jason Gunthorpe wrote: 
> The fix to whatever this is should be in ib_nl_is_good_ip_resp().

nla_parse_deprecated returns success if attrs are missing?

Other callers also check for their expected attrs to be present in tb,
after checking nla_parse_deprecated()'s return code.

