Return-Path: <linux-rdma+bounces-11803-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C59F8AEFB79
	for <lists+linux-rdma@lfdr.de>; Tue,  1 Jul 2025 16:03:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 91D87165203
	for <lists+linux-rdma@lfdr.de>; Tue,  1 Jul 2025 14:03:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 173BB275B15;
	Tue,  1 Jul 2025 13:57:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cornelisnetworks.com header.i=@cornelisnetworks.com header.b="PMfLLiQv"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2133.outbound.protection.outlook.com [40.107.212.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3384726FA52
	for <linux-rdma@vger.kernel.org>; Tue,  1 Jul 2025 13:57:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.133
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751378251; cv=fail; b=oW0yBvaS5ZgMkFSvQ15MLCkIkLNRLG8OBg+U22+NeooC2bA1m0Qo3RJOGfezncPDDqC14zClDvLjAQVK+bhXwnE7bmUJwMobvZsp6E2ffI/GzYvGEbEYEQC/7TTf8uK3OQwj7ML6yKE4YkbiCGSOK42z3tchjsRxJTx1y0z4DcM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751378251; c=relaxed/simple;
	bh=gUZzf9wLswGxmDpz4JKG4GHVQ51W//qiU/o2a6Niz20=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=n1IBPHzYzbWmRuW0gps3xM/g9eI8S8cTQXqHfBfC9jOUsCc/hbbiY5J39NijptItMMVx8wzMz94b9L3tG/aMpkN7UQhrVTmyMj/PSGyt8HaHuBWdoDvYJo88/1XQ+CDUFk315Sd+1ldMpY3RGc7Gp18ZmHTujW4Eb8GV5zcVY1s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cornelisnetworks.com; spf=pass smtp.mailfrom=cornelisnetworks.com; dkim=pass (2048-bit key) header.d=cornelisnetworks.com header.i=@cornelisnetworks.com header.b=PMfLLiQv; arc=fail smtp.client-ip=40.107.212.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cornelisnetworks.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cornelisnetworks.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=S27R+szz1DcEno9iimDXkhpRur93aLtSG4YJeV7GkUhwoaFwWcR4QYlVOMCy67pXIk2ERBq0meWIdATDHe92nSboGfzKmXVchla5ZUfnp6fgMuEL3HVzTa7xYZebz2rVEWllCwDOMFRutViC/Mc6XBfBR5cov2IW+OVSnLJRhVDo6B2ml6vfcxZPpBnvB3RNUBmLrCZ1MqMrowhjoKqtTW1ZKZkwvpp+jh8T2lInV8CFq7qTkP0ffMHavF4G9CGNWRGZHjqa/1ZN/OfbkZ2voMKmOSzVAwu2+f1R2LTF7FY25MgnmoKVzoaD8b+n+T5UH4EzIxcIL/3JTka8gasS9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WFvnuHOFlQeKYKwXGwi9Y1sq5WXy99HduooQ4C6efNU=;
 b=NxGzicSDW8lX6baz7OOqoswhWRCG3SqGPp+/bS9ZwQHR1AKwyaB6ira3V3ujJohAAvZILlD4rlykQGZbwiDhnU5IlRAUacdLdzvbXgLb1sdx/c/HZoatXmK144ZlGfvo+GExTbBWm0exMEbiM5+hWSeTJtrXsOmJ3JVZHRqlmhBiK3mIpg5n3W/xchUMdY1/mdMzYnyV4aEfWMzivm8knBnT6I5K8XNtI4qAmaGtgBfH+uCjxBcFz4nu8xYhQuXUKMmq7meZB8qA0Xx+ZIOIO+eQHC2X23hxReBdL9VblWFIa1xeEYWrqi1QoSqwZn0sfk/TBtAoxCNrJR+q0oY/IQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cornelisnetworks.com; dmarc=pass action=none
 header.from=cornelisnetworks.com; dkim=pass header.d=cornelisnetworks.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cornelisnetworks.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WFvnuHOFlQeKYKwXGwi9Y1sq5WXy99HduooQ4C6efNU=;
 b=PMfLLiQv1cK/R5izba1rFZSsyCaRdei7OMlE1+2SSJY/53Qky+9Plda5W8LmUQ247LxYXBEhQ0I8Bd7NTVGy0kr5SrnZRh2kFldJJQi6dwx95RLjeB0mavxI19X7bNp1lhh3Zm1HqwdJQGV0M44FDgR8z2vZLBRkeL49VWvcis5cChNFKxNHn/GZAI975NlmY5pUffBGKV+dC4zBi42ZGbCxAW/oLpN5TuScg6BXlGgdKB6VuKRCZXHqZ4vmgsQva7oHQr1yjVzyrxZQg6WLd7P1o9E2eir950abTg8pDx8/yp3vpgrG2Q23FKa0/77KtMvJzYrB9yOV9PZ5exwLQQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cornelisnetworks.com;
Received: from SJ0PR01MB6158.prod.exchangelabs.com (2603:10b6:a03:2a0::15) by
 PH0PR01MB7366.prod.exchangelabs.com (2603:10b6:510:dc::5) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8880.31; Tue, 1 Jul 2025 13:57:26 +0000
Received: from SJ0PR01MB6158.prod.exchangelabs.com
 ([fe80::d4a8:cb9c:7a0:eb5b]) by SJ0PR01MB6158.prod.exchangelabs.com
 ([fe80::d4a8:cb9c:7a0:eb5b%4]) with mapi id 15.20.8901.018; Tue, 1 Jul 2025
 13:57:26 +0000
Message-ID: <32fb1fe6-b21a-4105-ac2c-cbdcd277a59d@cornelisnetworks.com>
Date: Tue, 1 Jul 2025 09:57:23 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for-next 05/23] RDMA/core: Add writev to uverbs file
 descriptor
To: Leon Romanovsky <leon@kernel.org>
Cc: jgg@ziepe.ca, Dean Luick <dean.luick@cornelisnetworks.com>,
 linux-rdma@vger.kernel.org
References: <175129726945.1859400.4492277779101226937.stgit@awdrv-04.cornelisnetworks.com>
 <175129741281.1859400.9193550583285999392.stgit@awdrv-04.cornelisnetworks.com>
 <20250701123254.GC6278@unreal>
Content-Language: en-US
From: Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
In-Reply-To: <20250701123254.GC6278@unreal>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BL1PR13CA0435.namprd13.prod.outlook.com
 (2603:10b6:208:2c3::20) To SJ0PR01MB6158.prod.exchangelabs.com
 (2603:10b6:a03:2a0::15)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR01MB6158:EE_|PH0PR01MB7366:EE_
X-MS-Office365-Filtering-Correlation-Id: 18cae003-3bbe-4448-bd97-08ddb8a7360c
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?V1dUR2VJM2lmSUdseWtvYlBzYmZxT0VLYlhLdWpsaGhDL1lxSVVGL3Y5ME50?=
 =?utf-8?B?Q3JmVEZubC9rNzJnTVBLMkxMVG0xRjhGSnpabE9lM1FSN3RpMWdDNzFQamJn?=
 =?utf-8?B?Tk00WnJBalJnblkwMHR2MGl5MDhUa1dFNGtQTE55a2h2YVMvdUxUdGFJUVZD?=
 =?utf-8?B?SUFNbmNCK3c0TXVqZDRVdUZMTG1XVWsvNCs4N0VZeGhrUDNKT0tzTUNJZTc4?=
 =?utf-8?B?UVhIcU1ZcWRwdWFDK3IvTWxoaStNeFBlOWRHa1JjektLVEJ6ZVljOVNDSW1x?=
 =?utf-8?B?VTFwcDdpY040N202TDg2b0RRaWhOS0hGSkNVSG9TUGRmK0V4ZU5RK0FTUHpG?=
 =?utf-8?B?U1JwTHVXV3pNQ0JyY1hMek5Bd0hkK2hRclpZOU9OKzB3TzN5c24vL3VNZVNv?=
 =?utf-8?B?SFJGOXBYUE1XZ2w3c3dCY0hPYktpdzRqQzJQZGFwblZiNjd2TXNQRU9SZC9N?=
 =?utf-8?B?MUYxc3FLRDRmemtvTHRxNDdIUTV1MGJsZ1g2d3l4RldsMDlSSTQ3YVQrVkYr?=
 =?utf-8?B?ODU0b0tNWWdrUnlmZWNuMU5LR2RvMUFuNW5jZXJPWmN5djZRNmE3TUd2T2U1?=
 =?utf-8?B?QTI0djBOdW1VL0VvRTBMMkVaSm5RNG8xTFVHSlpTMVhtUmk3OUZzUUFxak5Y?=
 =?utf-8?B?VnBGcXpJOEhxaXhFTXREUURtZkYzL0x2UmtjTWdPYTRtRGdHSjFTRWpiZHY5?=
 =?utf-8?B?NWc3cWl1TmJTbm1CbFFhSFhSb2FFWWpvVUs2UnBZQkVrMVhmNlpxd0cxbDZZ?=
 =?utf-8?B?ZXl5WTlIRzhTK3c3dEFIK0dJbFBTUnRMRGR1WERZSmJ6NklNZUVaRFljTXg4?=
 =?utf-8?B?V2F3Wm1BVjlZRnp0VzRETFdNZk5VUzlGNEg0aXB3eDVGMjRzRXNkcGpBWlYx?=
 =?utf-8?B?NnhPNytHU282MWFzMVBUNzc5STVmWkt0a2lieUZuc2RpcHRNYTV0WDlxZmxU?=
 =?utf-8?B?V2w5cW5WQklvQ3RqZ1RCek5BSCtBNjdGYjh6R0xkRktJT240ODQxcFU4dnYz?=
 =?utf-8?B?SWNvcWFnTEN2eXpqRVJxQk80NjVyWGJQUXdxbkdLUDhpM2hMTnU3V3pXTjNV?=
 =?utf-8?B?TEFCYkZRQTVkUXVGcnlQblIrUWQvUkZTcldrS2VOMU1ldWI4K25SN2NMZVNV?=
 =?utf-8?B?SldkWExIYjNOejJKZjFsay9iTk1ETnZXaTZTaDZzRmljaWdTbHVTZ2xLcXBI?=
 =?utf-8?B?alRGZHVjTUZmcVRGdWVwYnB1VVZTQlhDYU00QUFiVFczL2tJdlpZK0doQXhh?=
 =?utf-8?B?cDFjejZ6NW5yZ0JNSVo2U2hDVmNad0p0NXppbnlqQ0wvbWtSMGExL3RPZUJ6?=
 =?utf-8?B?dGhoYWZXWkdaelRuOWZIQVJtbFJKeWxySlREUG5KYmhoMG5jUVNTZkpYNklS?=
 =?utf-8?B?TlNBV1pQUGsySURDTFJVQUZiKzdLbXR4TjY5T2ZnN2htdFU4TEJUZ3pVNFFm?=
 =?utf-8?B?djVpRittV3BRU1RnbGtwU21nYnVBK05XZVpDUE5TakNpcHpGWTI5S3hJRmdP?=
 =?utf-8?B?MlJPak5VV2RJRXJrdXJJSjB0SVdKSDdyM1RUVmthWENhNXFYM0FMT1Mwb0d3?=
 =?utf-8?B?azRXakduVWNpNmlhaEtVaUpBa1VySTJVWk4xOUVCekZmdVZkWmxrZDhGa2FL?=
 =?utf-8?B?eHZwc2ZkT3lRQkk1QS9Xdy9OcGZPaUlmM2t4dHdBSXMzUDYrYkszQ3Z6RFVO?=
 =?utf-8?B?NFViSzMrL2ZPS0lxai82dVN4bEVrSXNINWxGOUhpdEtVV3RvczVRd0Y0TmFu?=
 =?utf-8?B?U3BNUytSYjZLamR5OTVrV25UNGhnblc3TUFvYjVUbzh5cGRsTzBXaUN2ZzE1?=
 =?utf-8?B?akwzbjBvSTRZamhjVWhZUmZjUUh0VzhUUFFMWXNTZzIzWHQ0V1RhTHF1ekhT?=
 =?utf-8?B?b1ZRR1laR1RITkpnSC9ubWpySlBoYnYrRFBqMWl2b0EveitwOTZrc0xjaVhL?=
 =?utf-8?Q?mbFaQpTM4EM=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR01MB6158.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cEFyQk0yNGtxMlRlcXpGSlFSazhTVnFJNkt1OS94REpnb05yRzRsZnBObFJn?=
 =?utf-8?B?aDZxSmlHeDJ3aHNyVFpWVmlKbmh3dXNZMytMRlNReHVYSnI3V050bllSREd5?=
 =?utf-8?B?WEpDVVJhY2N5M3ZVMk9zbEJkZWpZZ0RmTG1yaXJTbWtGWTJCS3FmdWJLNkY1?=
 =?utf-8?B?RmtFVllUeElnSU1HamJtbTB0VHlRMDF2Sk4rcWx5ZHg2WGN2c3pRMlZBRlRM?=
 =?utf-8?B?bDFVSEdOeE5uMEpFa0hXSExUbHB1aVVpV0tXQlROSEtseTA4dlNPUUdtLzRS?=
 =?utf-8?B?VTJjSjg1MllJZzBodlVDSndDeEExTFl0TGh4aEhDb2xXU0xIWUVXSmpFYU9H?=
 =?utf-8?B?T1dIdXF3dVV4TmRMMU1MWUh0bkZ4MDlDK2xoNERMRUkyU082ejRnay8rMHlu?=
 =?utf-8?B?UDNXaDEzY0R4VkVPMUFiU0V0ZkI3bUlOUitjNXFOditEZFVCUDJJUEZuRVRr?=
 =?utf-8?B?NXNUVSswaSt3aEdpWTJ4ODRCVkdGeE5qb2RkYUtYVlpqcFNMUUVSMHNFVFYv?=
 =?utf-8?B?dUtoTlhCK0dJMnpCZWpsbEJ0djZxV3pNazd5eTRzeElvUmt6cm1zL0djTlQv?=
 =?utf-8?B?OUl5ZDd1TzFPUEdpTjZsSWFCRkNLUXhuV25vQUQ3VnpQVklic3ZQSXpwM1dY?=
 =?utf-8?B?SGZmOUJ5NTRmNEJEM0hDUW9oRmZxaVUvbzUvYUMrMUljbkRKcFZlclliL0d0?=
 =?utf-8?B?Y3ZndzFuTzUzeVFnMnNVWHJVVitZUS9hMVRzQ3lSbTYyQ2VKNGZGWkdlb3pZ?=
 =?utf-8?B?NlBZYmxZNmxsWGhyL2U4R01YdEI5d0JQN0RwMEJPR1p2TG82MTViZ2JLSkNv?=
 =?utf-8?B?N3VtQXd2VFFVUTdzbmNGck43U0F0NUY1eW5KOEpnb3hVVHZITmhSa1FNUy9z?=
 =?utf-8?B?VVgwcFFEMk9pZVcvKzhkc1huc3ZnclJhUHVnZ0lOSWx5R2Y5S2RYdEYwRVpT?=
 =?utf-8?B?RmhTbHZsZEVpUklrREJ3UC9nNEM3Yng0ZldqVWUzRWFFeitMM3dpajJabTN4?=
 =?utf-8?B?dW13WlB6aW1aeEhnZFdyNk5Gb1dqaTZrMTIxemFmb01QSzV2bERaeUM1YmRu?=
 =?utf-8?B?OGtKT0ZWcjF4bDlFSWlNSDhUQ1NmRFpyUG5kUStZd0NLL3lqazl6VmNlVHRQ?=
 =?utf-8?B?TlgweXMyQ2V6ZndVUFNVVWNCRFdRenZiLzZzM0UwaFNUUTRXSWJLUmdWK1dP?=
 =?utf-8?B?ZXI5L1pxRXlGbjFnRHI0SytQVHZqVVpRM20vYkwyOWQrL241WlcwZ1g3aXU5?=
 =?utf-8?B?cEo1RUthSXJ6bVoxdXBwcDR2WGdCb05KMm1nY1VlNm1oVzBWeWxlR1p1OFNB?=
 =?utf-8?B?ejNvR05pY0xzR3o2TWZEZlBrKzA0cTBNRENHVytMOW14MVVrT1IvN0h6RWZa?=
 =?utf-8?B?ZCt6d2FUakxPSGwyTk5LeUc3K3Y4UUEvRmc1U3dVSHN6NzVtYW1zOVN0WlpQ?=
 =?utf-8?B?NU1pdjMzdS9NS0g1YVFsMHRZQi84Q2M2TSs4R3l5MEIyZXg3WUprTGpFQXpQ?=
 =?utf-8?B?SnJsNFdEaWtyMUliOHVMK1VOM1dmU2s1VnlLYXYvWlpNUG4rd1pBamNBbExX?=
 =?utf-8?B?K1h1cVIwMlNuSzdqVDFWMFFaMmZSRUwyTmRDNlF6TzByQ3piZjc3WSt3aDd4?=
 =?utf-8?B?cDhCazdxN3E0NGFhRU5xNWlmT2hxdlNSTVAvNi9LaW9SdTF2OGJON3NZTGJ2?=
 =?utf-8?B?RGdWVTJrbkI3cGZvd3dpRGpRS2F6WEg2L3QvZW1SNjZsUGkvVFEwaVJMcmRN?=
 =?utf-8?B?V0xxc0x4YXE5UnBRWHMvb2VzZnc2R0xVc2dUSWJnb01Xd0lKNldYSUlQZS84?=
 =?utf-8?B?UjJHRkJ1Y0dXbkVpNFBOUWRia0M2L1NwSzdva1dCemYycHlnKzZJcnVwTGM4?=
 =?utf-8?B?bEx3KzJYSkRXWFpwVkFsZDZKSFphZGZLYlhQaGY3ZTFDciszaUo1MnB4N3NS?=
 =?utf-8?B?RmMxZnc4VTRaeG1uTkd5SWwyYlkra0E5SW9KYlJLREkvSnNDRWF3VC9tdU9u?=
 =?utf-8?B?VDhHL1Y5WnpvV1hJV1FvWU82YmZ1blJVT0VwMlYzL1BTT1V2NG9nTGlaOW1M?=
 =?utf-8?B?aDlBOEFSdVlYSVNtSnU0aHZYWnBEb1JiOHV5Rjd6TnlLSjI0dGtHaXYvWnhV?=
 =?utf-8?B?dTZBN01CcXMzMHUwV1NMZUN2bFJUc1dqWmFXYmY3cGxEK1ZndWw5VTUwdk5a?=
 =?utf-8?Q?1WaqZ/Bwo/eupbzqwS855+w=3D?=
X-OriginatorOrg: cornelisnetworks.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 18cae003-3bbe-4448-bd97-08ddb8a7360c
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR01MB6158.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2025 13:57:26.4431
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4dbdb7da-74ee-4b45-8747-ef5ce5ebe68a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VBG0cDLeXxXGTE/GHJuj7Psdzn32TMBK2A4w/zlQvXLBjfnpp2NmDgCTDaCaMzeQ4alF5RxomZXcMSOhGAIVljyVYKt+RQov8jB8Os+twPj4OUC0zVttbTHSQWgn9cMT
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR01MB7366

On 7/1/25 8:32 AM, Leon Romanovsky wrote:
> On Mon, Jun 30, 2025 at 11:30:12AM -0400, Dennis Dalessandro wrote:
>> From: Dean Luick <dean.luick@cornelisnetworks.com>
>>
>> Add a writev pass-through between the uverbs file descriptor and
>> infiniband devices.  Interested devices may subscribe to this
>> functionality.
> 
> Aren't we use IOCTL and not write interface now?
> Why do we need this?

We wanted to keep all the semantics of the user interface the same so it's an
easy migration to the uverbs cdev from the private cdev. The idea is that all
the command and control is still ioctl, but the "data path" is still using the
writev() to pass in the iovecs.

By the way I'll get the rdma_core (user space) changes posted soon so you can
see both sides.

-Denny

