Return-Path: <linux-rdma+bounces-7028-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 78611A12A43
	for <lists+linux-rdma@lfdr.de>; Wed, 15 Jan 2025 18:55:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 94F62188B423
	for <lists+linux-rdma@lfdr.de>; Wed, 15 Jan 2025 17:55:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39BED1B6541;
	Wed, 15 Jan 2025 17:55:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cornelisnetworks.com header.i=@cornelisnetworks.com header.b="SmbXi5w2"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2128.outbound.protection.outlook.com [40.107.100.128])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C269B155C96;
	Wed, 15 Jan 2025 17:55:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.128
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736963713; cv=fail; b=KFgx+bSR78KLfZ7BGbJHXWYPvHsuvLsginv/+E5vWwZnwd0em2+9nNCWsGL4R7jKUCO/4mmbtcgQKIedeG0C7apiWm21bCZEzVWnLxCEm+sIim2kHf/A8KCT8Gt7P8PQ+Fxu+G1HvrGXXmdH5XoUBBRmeTC1fO5oZO6fgJCt4kE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736963713; c=relaxed/simple;
	bh=mJZUfYz9JxEVnH2GzU+7L4zy3sm+F60nw5VTjcdshH0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=U8HVg1dnBsLa3O8HK/Ka+0St+jr3sXW8smHuHzrda3wKsnxkykmy8KT8X+yzLw/m8NgNFMFI/bjsWKwjdLebnijGhBFvRYrV9iixkZfRmLtH7O/Y5oHKMgm6g3ievAi6pi2JByWlPFfpbpzN0XXsMKSZQj05QHpIX4ft4UR/a+U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cornelisnetworks.com; spf=pass smtp.mailfrom=cornelisnetworks.com; dkim=pass (2048-bit key) header.d=cornelisnetworks.com header.i=@cornelisnetworks.com header.b=SmbXi5w2; arc=fail smtp.client-ip=40.107.100.128
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cornelisnetworks.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cornelisnetworks.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MeY4XTMoirQWa6FNzx7c09f1hL5Hedbhyguxl6Lb2D2nMhx+3dJRLZgLMpovs/W268582eqTRxBTA4lqUdWXTxGVcQDy/gU48fepHDo73k8Meef/v6X1mcuIaTc8vtZ7qJvaVdYkHQh0HUYlidrAxqUd+8LOEgpPRmdvnDpOIPb6Y662gktolIOGlLhNPxIlm/DvDdrokIvNh77auYRXKv+rBHE/+4UINFdELRfopIV+0MCq8CpIK4eeCR1Qaxj/mUleMWS8YXrHHmF1KEwljM2FkDpd9An+o0PIC5uxRvPExXKlHZE0WxRbOS29RnJe+3IxA8esPKLK17ar7jF+MA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mX+J+n7iS4I9sOt9ciAxUPqFpu5BiARaMRUwObBg/Bg=;
 b=wgup67O02P7Bb2jbQufPr8NU+t4k7rbZ8zGjdSc9EvCZIkGa6MiGtuOmcQKlkdrAkoVvofCXioF4HsvL/WvfH+3lAnNXGF7Zv6nkZdWoQLFlkorEBuACkv5R2SdcUEaSodMACL6fCC96qJ8oRgkyGxBAx+ZYtEJYok8SEfZWzq54GhTSFtVrVcC41HZFPlkholHs+YZsfKOd5z43fZqxhwcoOl6lDUmldsckwVu+czoCvznjyiEJbvuW/AdpKPDaMFVJvyMR6IDU2EVsTBcAYYZSfY7Jq4opOxFX2oCa0vILGOZHJXFeS8GH6zodu3UPWGBh4uoCiJWUxFUyZj5d5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cornelisnetworks.com; dmarc=pass action=none
 header.from=cornelisnetworks.com; dkim=pass header.d=cornelisnetworks.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cornelisnetworks.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mX+J+n7iS4I9sOt9ciAxUPqFpu5BiARaMRUwObBg/Bg=;
 b=SmbXi5w26Dx3C1oOUeEfLtsFL2GByqHAzcE7nT3iYNbGOG/ZcerTuoSqgrBCmb2OriUkHSqtu7nTJZgAMYZQuP6QqGdTY6QyfDy9TQJzkOTmaJQfvIH36WM1EVLhXQQtcBzCNepPDPIIig6wVs4nQYcvhmP0n+l8ASEFbJaqzuxwVUiH49QtQD5ruEnwPP4jdMkjjekjRbwY/WTS/S/FBp23RK59/mow61kaz9x+Me+sliO9wZgJZeb2aUKoViejeb4xwqrPzju3jcqdszbqSJzfluB72wTDQokp32mf2lid4L2WI99eLfKmrUouzkJHWWqewyteOz64UihdC/0ZPw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cornelisnetworks.com;
Received: from SJ0PR01MB6158.prod.exchangelabs.com (2603:10b6:a03:2a0::15) by
 CO1PR01MB8892.prod.exchangelabs.com (2603:10b6:303:276::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8356.13; Wed, 15 Jan 2025 17:55:08 +0000
Received: from SJ0PR01MB6158.prod.exchangelabs.com
 ([fe80::d4a8:cb9c:7a0:eb5b]) by SJ0PR01MB6158.prod.exchangelabs.com
 ([fe80::d4a8:cb9c:7a0:eb5b%4]) with mapi id 15.20.8356.010; Wed, 15 Jan 2025
 17:55:08 +0000
Message-ID: <4e7675a0-0dc0-4da3-b8ae-2462a5b112d1@cornelisnetworks.com>
Date: Wed, 15 Jan 2025 12:55:04 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] IB/hfi1: fix buffer underflow in fault injection code
To: Vitaliy Shevtsov <v.shevtsov@maxima.ru>
Cc: Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>,
 Doug Ledford <dledford@redhat.com>, linux-rdma@vger.kernel.org,
 linux-kernel@vger.kernel.org, lvc-project@linuxtesting.org
References: <20241227230940.20894-1-v.shevtsov@maxima.ru>
Content-Language: en-US
From: Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
In-Reply-To: <20241227230940.20894-1-v.shevtsov@maxima.ru>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BL1PR13CA0138.namprd13.prod.outlook.com
 (2603:10b6:208:2bb::23) To SJ0PR01MB6158.prod.exchangelabs.com
 (2603:10b6:a03:2a0::15)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR01MB6158:EE_|CO1PR01MB8892:EE_
X-MS-Office365-Filtering-Correlation-Id: 9f6bcbcd-d174-4711-1e53-08dd358dbfa0
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?STRnZmZ1L0dnalZaaHRsK29yanBPS0lZZVdEUWdpdHJOYmorOVJlQ2pWSEJt?=
 =?utf-8?B?ZytEZ1pOeWRXR3M1cWZveU4rdHJMQmNHVGQyNGZla3dPK2VKajVYeUpkcEVO?=
 =?utf-8?B?SjZVbmVqR1lRYmNCZXVWMnBqWHhsN0xLVUhuaFQ3NmJIbTRaSG9pQkdmNzZD?=
 =?utf-8?B?OHB6MkdJZnFRNzJsN2Jwb3hqSEtQbWF1eUhwbjRPT0kxR2RGby9IaTVtM0V3?=
 =?utf-8?B?Z0FwSkZ5VE9xSHdKbS9NYkppdVBkTXZlVUFjbXdXTlRVKzFRMzJCcjNwcFNP?=
 =?utf-8?B?dzNmMFFtMmV6Tk1lTkFYVFVZbkVrWXpIL3pocWR4TVNvcGgvdjZTMExVRlIz?=
 =?utf-8?B?VVZtTCtkamdJaE1CNUtzSkkrNnUyOHN5RWJYUTZGNnNqRmFnOXllRUs3N1dZ?=
 =?utf-8?B?bVduV1dtOXZVaHFuYjJqeTFicEZDTFdWa3V3R0l1VVU4bDlKRC9HQm5HZjZB?=
 =?utf-8?B?N1FRdlFOVHdqYnhZYksvRmwyVEJJT3dpYVBFRWxPT2NQQWZuSmw5ODl1dUZi?=
 =?utf-8?B?WCtWSWRmbHl6anhBVkJYRHFGWUw5M1I5ZFJNYk5ORzN5SVV6aHlIK1ZsR0JK?=
 =?utf-8?B?WTNCZCs5eWZPYS8wWi9nM2d1SE9FQVF0aFBncW45Mmx6YjRJdWZNaGpvSnli?=
 =?utf-8?B?Wm5vZ0hPclFsZnlsTElUOS9hWnRlQU1sU2J6b2pWZCs1TDZzcGJTQ3BoNVdW?=
 =?utf-8?B?YVVadlh2TEdJM1BBTG0zSHl0RWFYaHZiN2EwdHJReTlicVJLc1FXamdlRDNK?=
 =?utf-8?B?bGJQaGdXNG9xbWREQWRmRkcvQjJHdDlLL2lTRURnMmxJdkNFTmxKVnc4SnF5?=
 =?utf-8?B?U2R6dXJaSnlxYndHZXdBN1FNaDUzWitZZzVKd2Rxa2pTZWFXZWhtaFBDSkFH?=
 =?utf-8?B?QlE0MGNVbFArMGRpZUpFM2gwMmhiRzB6Z1dVMEpXOVVNbVlpN2RyMEozNmFB?=
 =?utf-8?B?MWhVNWhaYmpHc2I3RmpnTzlOcDBIVVdYRG53SGFzdmM2VXZaNTdYSGNPaHFh?=
 =?utf-8?B?WWNhNXJPN2laUVRSYXhyMVdiYldrSzFlcmNzS29KeXpIRVNHM25WcmFwWXRr?=
 =?utf-8?B?YS92MUp3RzRQMFJtMkdwMW54ZklYUnNQaGxINXVDRGZKT0dEd2hwbk9YTEdR?=
 =?utf-8?B?TDhNaGh0SWRYN1JuUzVqemZ0bjhwa0ZIMWRpUHI5U0luZDZiS0RvcFA5UjA4?=
 =?utf-8?B?L21aMDNnWXRLYWE2cUIrR0M4bXpkeUdPL1hlYlpDWG5aRGtoUW8reDN5cU9n?=
 =?utf-8?B?Ylprdlo0U0VuY3dEUlBwSGttVWxtYXlEQUxEWEQxQWc4YjBoTjc0WlExVDBP?=
 =?utf-8?B?aGFncmMrdW9vV0NVOVo5WEk2cExNTGNOZENlQTVvN3I2OGRHYTVzbUdKQmpw?=
 =?utf-8?B?dE5nUTNTOVMzQTdFeUo1YjlNRGZycllMNUhTTHphVUdtSFV6YnI3T29INHd3?=
 =?utf-8?B?czFEREpOVHNTSSs4Q25PN05vSUVCRE0xRGFxb1dDUjlJbEJGMGFLNGFLQmpV?=
 =?utf-8?B?YjhUd0FkOUE5YU5NcXkxRE03MUliZXZ2NkhWTm1aNVg1RmJwUzZFZVFyKzJI?=
 =?utf-8?B?WVJYQjh2YVBCY2RSaFRjSXVDN1BtZVJqRk1CSU9TYnBtcHllY2QyU2ZRVU4x?=
 =?utf-8?B?YnRiWElEcDYyYmlpUFdxZWNYYnRYdHNub2RGQ1Q5RU1sRXRkWjZROWxrRFFP?=
 =?utf-8?B?enRwaEZPd3hQQ0IzVUNQQ0RHaU1lOG9ZNXR6Wmh1OUc2UFFtREVGOVpZOGRJ?=
 =?utf-8?B?aDdsSms1VWxXUWVlSkE0dEVLV1l5UDE1MXJ2Y2VEVmVNdWJ6R3pHUkUvcGZR?=
 =?utf-8?B?YWdaZHVsby9CdVpIR1M3Y2c5MVRReFR1TVhQMnVzb09mSWNrdW12bUx0bWFP?=
 =?utf-8?Q?bHM8QEdbupQv6?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR01MB6158.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZURDbjNmSnJWRTlIT013c0laRjZBY1hKMFRyck1ZZVFMbVppL0ljKzFjaSt0?=
 =?utf-8?B?NGNISld5dTBkdmxtUERreWQ4S2VkTGxPbzJwSzR0cEszNzFpV2dJdXRCZEUw?=
 =?utf-8?B?a3J6OU1ZcHJkampxaC9KUEJkQUl0NWkrZHdQNG9FSU1yREV4dGRyTmo3YllH?=
 =?utf-8?B?RXBmdjUzVVNhMEdBdGhEK3A2aEpmT1VESGJtakMxYlY2VWV2cE5WcUYwaXBT?=
 =?utf-8?B?Uk54YzBsa0tZYjQ1cFd1c05lT01aSHloeW5XNjdmOEtXZG9rdjRIL1o5UXVM?=
 =?utf-8?B?aWhldmpja01jenlBQVIzQ01BRm8wNW5HdGRQSGFLajhxUkxRZy9PV0o4Q0Zz?=
 =?utf-8?B?RWVFemNxdHpnaUgrQUtjaGszQ2JVZEdIOEdEdmxRVStuOGNkUWVOcUhVOCtJ?=
 =?utf-8?B?Y3NzL2VvQjJUSnNLandBbUF6b3BXVkFsUC9Obmx4UEJaOGtrUXdjckh5aTB6?=
 =?utf-8?B?ZmlvQy9tREQ3dGMvUTdqaWtlUjlxU01SZlluelNROEhVN01yZHBYazkyb25w?=
 =?utf-8?B?dXVJOURFcVdCNFlQT2pSWUVGMTQ0cWtaN2VHWmV2WE9hZTYvNmZHdlNzS2M0?=
 =?utf-8?B?YWNtRkNGMlE0eFpraWV1VTB6MFMranhPeTl2bktkeTFuT21CRHlpcGZJUmJn?=
 =?utf-8?B?Qk5RTXFQc2Q4WlZVUjZkN1hrZHFlMUJRQTdwWUlsV091RnJndDJlclovRk5k?=
 =?utf-8?B?Q2l1elg3YXRJWlVWQTlvZTVYSTVwZmJUZElpU2hpMnJsNjVrdjB1Uy9HelJS?=
 =?utf-8?B?dXpDWUlER2FMbHBqMG1XVnBMUStTUGJlZE1teHNycUVhQzBuMjF5KzZIQ0hm?=
 =?utf-8?B?VE1EL1pOZW1LQlRrR0VxUkx5NTFYYUI2UlJ0dS9qVTBDRmJ1cEI5UkJlcmlx?=
 =?utf-8?B?NjBPOHZRYVJwYnVrTWJwMTZKY01BZ1ZzbEUra09VU3hrK2lUSzVBa1hGUW54?=
 =?utf-8?B?bjVRZjg3QWVTMTZxdXZQOWsxVStNd3UxdUlMTFUvV3U1SXg2NkVwUGdJQnJH?=
 =?utf-8?B?UzFETnB1ZFJSMURxeXhjSHNKWWh2VVZkRjNWRFJOUExvalVaZG5rR3k4bW9a?=
 =?utf-8?B?K056MjB5aXBnTHlNL1JXRUhIZlU1NUtMKzZaOGVlOXg2bysyYXFDZjFSSkgx?=
 =?utf-8?B?VVFMVlFobWY0M2R6WVJQbjcvbmRMa1BUQ3BocXVmSlFOQ1pVZ3lRRkNJWUFU?=
 =?utf-8?B?VnVxbFlPRzFRWjV1VDNKYk9UMWdkbEs1RjNIb1BPakpLRU9wTDlsNEo2OTB2?=
 =?utf-8?B?Q0RnV3FqaVdYdUQwMEgrUW52eWt6WnNlNWd5aW1TSTI4VWNRYzVHODdQelI1?=
 =?utf-8?B?UWIrYk9xTkJ5S2hLUm1uV0tvR0hwSDBxalRXMUhVUUhqd3lJUmJlK3RER3Zz?=
 =?utf-8?B?V0dhNTN1M2hNK3EwczFkK1IrbE9qRFkydFVDalR4dmpSdTQ2czhMNXNzMkt6?=
 =?utf-8?B?Q1ltNy80Tm1RZWNlY3hEMEcxUncyM1hYWlNoeWF6MWZxeFoxTFhBTk4yVEFt?=
 =?utf-8?B?ejZaZU5JTjZ0cjJEMGZXajBYTG0zOVA2M1YreEd5WnVweGZSbGNlVTBlOWtK?=
 =?utf-8?B?Y25GSnA2OUo3azVHTjcyRHkzdVNidXBzdHBtQ0gxbVp4cVpzVDNacm0zb3hS?=
 =?utf-8?B?cVFpVkRNQi9FRjdJQ2NjOTl4L2FIbmtTMEF0d2NlZWwxOVBXRkczMDM2bGM3?=
 =?utf-8?B?TEVJMDh0dGs5cm51UUZuaEQya3BOb1RocHA2b2xzTGphb2R2UXQ1cjJNUTE4?=
 =?utf-8?B?UEhDVHNpMzJjTUpTbzhjcnptZjJiV2k0RXJocGoreUNFSG1Gd2ZQOEFGSEt0?=
 =?utf-8?B?cDliMm5WN3gzc0ZVODVtNnBGL2tLUWp3RnEyeFZFVkljMkhqZHYvcy9JbENR?=
 =?utf-8?B?bzdFVVlkU2lNU09xdkwzbFR2K1BPcnMxZWZJODlxSkxCdmR3ckJwcWd4THVq?=
 =?utf-8?B?dGgybTl3amVYWThxMlA1UWlRT1VVSTUvZkszVlJOdzg5L25NTUViWjd1UEtp?=
 =?utf-8?B?VlprakVzOWViVFpjQkszV3FhNzZKOHI4ckNaSlQyMjdCUC9iN2tJQ1VOY3U4?=
 =?utf-8?B?d2c5Y3FHNWR3WnY5NXRyMUVKdVY1cW9SdjF1ZmFVUHlQMkwvSVR6eXd1NUNP?=
 =?utf-8?B?TkRGUCtEa0hwZ0pPQU5pZElZQzY3RVJ6b3VHYWtFUHRPZkRhdFRqTE5iVmlI?=
 =?utf-8?Q?oY5lokh05WRNmfs8iKcW9pw=3D?=
X-OriginatorOrg: cornelisnetworks.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f6bcbcd-d174-4711-1e53-08dd358dbfa0
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR01MB6158.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jan 2025 17:55:08.0393
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4dbdb7da-74ee-4b45-8747-ef5ce5ebe68a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7EkvSnUoOFtypQiBpZcBMKHwquUINOUtfOrACXmAoG8lUlYhpbLS+p4CUkx8v1LSbQePVGgXXfeTPeNa6/g++4iQhOu7NO/HPPv6yjmqnzuGhcUV/Bw36ZNkV2S/va7V
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR01MB8892

On 12/27/24 6:09 PM, Vitaliy Shevtsov wrote:
> [Why]
> The fault injection code may have a buffer underflow, which may cause
> memory corruption by writing a newline character before the base address of
> the array. This can happen if the fault->opcodes bitmap is empty.
> 
> Since a file in debugfs is created with an empty bitmap, it is possible to
> read the file before any set bits are written to it.
> 
> [How]
> Fix this by checking that the size variable is greater than zero, otherwise
> return zero as the number of bytes read.
> 
> Found by Linux Verification Center (linuxtesting.org) with Svace.
> 
> Fixes: a74d5307caba ("IB/hfi1: Rework fault injection machinery")
> Signed-off-by: Vitaliy Shevtsov <v.shevtsov@maxima.ru>
> ---
>  drivers/infiniband/hw/hfi1/fault.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/infiniband/hw/hfi1/fault.c b/drivers/infiniband/hw/hfi1/fault.c
> index ec9ee59fcf0c..2d87f9c8b89d 100644
> --- a/drivers/infiniband/hw/hfi1/fault.c
> +++ b/drivers/infiniband/hw/hfi1/fault.c
> @@ -190,7 +190,8 @@ static ssize_t fault_opcodes_read(struct file *file, char __user *buf,
>  		bit = find_next_bit(fault->opcodes, bitsize, zero);
>  	}
>  	debugfs_file_put(file->f_path.dentry);
> -	data[size - 1] = '\n';
> +	if (size)
> +		data[size - 1] = '\n';
>  	data[size] = '\0';
>  	ret = simple_read_from_buffer(buf, len, pos, data, size);
>  free_data:

I don't think size can ever be 0. No reason to change this I don't think.

-Denny

