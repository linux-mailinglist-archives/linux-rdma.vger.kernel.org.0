Return-Path: <linux-rdma+bounces-14994-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E79BCBD3A2
	for <lists+linux-rdma@lfdr.de>; Mon, 15 Dec 2025 10:42:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7EF39300A36E
	for <lists+linux-rdma@lfdr.de>; Mon, 15 Dec 2025 09:42:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 761AA329E7C;
	Mon, 15 Dec 2025 09:42:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="jvUYAUwD"
X-Original-To: linux-rdma@vger.kernel.org
Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010035.outbound.protection.outlook.com [52.101.193.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F2EA328B4F;
	Mon, 15 Dec 2025 09:42:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.35
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765791753; cv=fail; b=k/cp3AQ5WvNFMmCtP565opRksvlgtahW89GGUMLDat/TtFonEEtVl9dG0hV9RvhRC+2sE4wBFl4PN8v0WRwpkKbcoH1Dz67FEgUR7N/CTBHU3jnic8e+/s/XNaIGFJLBGXvXE3LzxYV94j1I3PMu5ZrHUZIWIgIcx7vjHIj4PQ0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765791753; c=relaxed/simple;
	bh=iHL9X8wFf6939ZbhmDGG6wcxu47vf5nnn3jLFLWA7pM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=YuqjDaspbRie0KGVuCqKR+kFdoWh7gHJy+mNDDWtVEyVjVh4Vc7PHqa568wcDl6MgfYBbPMMt6vStiNLyf9MPiv+H386L/CWR5+wP0/+hCRgpr9EgtKlHFlV2a/7sB2NXaSLkv1/ohO4+2UPgjrjMzBLGDGZDhgueGImniMHcsg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=jvUYAUwD; arc=fail smtp.client-ip=52.101.193.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZmZZeixn0pBMr7xezo1KItYN91Oimsav+SJAPazRffr4xXwjJXijAwlR6DRSE4nHyQFNY7x0nvVesemTZDwFQeZ9OjPqw4OlWiRAKyXTwmQxFZHVUk3n9Uh7rHvreQ+ijwVM1xhL0+ZqEwtC93mMVFXQND++Mrba2m943OAowQ4XCDyx8N+FwzSOaOym4LHzzo/UIHQ7es65uy8GcTRL1d834RcwuC51t+3jSwpdYMv9PF13VstV7wLpwmKjLcnT8ctSQUXVnG71uK4oIW3ionJiiSUO1+CLP48p51cfQ/Y8w2VMNc9pEhxkJf1TlEMIXNcjmDIU1LneOyYv8TqiZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/8IOf8RtLyONLgP1lMT4aujw7cOogVRfNtgsZ9ajKtI=;
 b=S4YQnfHKvF8dNIZS/4qQ0WbnPsxV3Sftl1y0Me/t5H5k1gKfQZvWUjae2etyB5y3feWqq3Fv6XUACSBj0Zbg/ljvWAXD/7dZI5MUCwe2fKuFNzpMzNOKC2dmw82GOf1Uweb+UNLfLSuqp3VZCHk5gI7uCk/powe1Aayi0tzN8OdsKp9JxPfKxOCQKFiz3qNBoouT69+fOjV7G38tlRWHy94RKvLQQVrNbhQ2L8S3cV+rBU3TFOCi6SbzeHTEQKjgnl2CvhdX8Kmi0OQQGK8uxI6J/7zTjUGe4apM5rVrvt1wXtllKWIC800lSzG3Qp0saqu1pt+HC169qZwceRBFzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/8IOf8RtLyONLgP1lMT4aujw7cOogVRfNtgsZ9ajKtI=;
 b=jvUYAUwDfDYSzx48CqJLCNvwLDPB0LWxadT0ht/LrO3LgLVi2U5buysakMskUZGpzgYY0v9t89Pm42Ht/JyUWCdsRb/19RmiyiZhWQN89KpTISXsGv62mXTan/UUilbl5EW0/ioE7Y13u+jdDjvYIcvLt81/vUiohX79Dyy5b+9VIeCg9JROEKyUqfAr6nglpHbCNg+JRcXsbsEweFjXZGn5MxQTKEkgn4hIdbTbvMaBJvKGEbcnUeUaFcje25+y9rslyYSVvu2w/qD+DznfD7J5Z5+vDGbdGQPKkrsn53ARH9Cg+EwWu9sycwS48aUBctIZwP0WCOf/UefCOjIT9Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9715.namprd12.prod.outlook.com (2603:10b6:408:2a0::7)
 by PH8PR12MB7253.namprd12.prod.outlook.com (2603:10b6:510:226::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.13; Mon, 15 Dec
 2025 09:42:28 +0000
Received: from LV8PR12MB9715.namprd12.prod.outlook.com
 ([fe80::1643:57be:ba7:a15f]) by LV8PR12MB9715.namprd12.prod.outlook.com
 ([fe80::1643:57be:ba7:a15f%2]) with mapi id 15.20.9412.011; Mon, 15 Dec 2025
 09:42:28 +0000
Message-ID: <54b9911b-3d6a-4d8b-8818-f78ba3ae2a01@nvidia.com>
Date: Mon, 15 Dec 2025 11:42:25 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] IB/mlx5: Fix a possible null-pointer dereference in
 set_roce_addr()
To: Tuo Li <islituo@gmail.com>, leon@kernel.org, jgg@ziepe.ca
Cc: linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20251209072305.3955121-1-islituo@gmail.com>
Content-Language: en-US
From: Michael Gur <michaelgur@nvidia.com>
In-Reply-To: <20251209072305.3955121-1-islituo@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TL2P290CA0013.ISRP290.PROD.OUTLOOK.COM (2603:1096:950:2::7)
 To LV8PR12MB9715.namprd12.prod.outlook.com (2603:10b6:408:2a0::7)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9715:EE_|PH8PR12MB7253:EE_
X-MS-Office365-Filtering-Correlation-Id: b922e66e-9c1d-4680-b9d2-08de3bbe42fb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?clNXQnZ5MFBBdUFOZ2ZIK0tYdmtUVy9OVER1VkxJdWR1dTFNbElDRFF1MmZR?=
 =?utf-8?B?OFhreEtWSlMvZTdlUFFtM292NzFtVi90Y2UwK3p6RFFwME5QT09pN0tHd2xy?=
 =?utf-8?B?TGNrb0VtTmVqNVc5aGRDVmtCMm1DZkt6c2RSd29Rd1hpam83RjRRU1FFaFJr?=
 =?utf-8?B?YkpHMDZDV3phQi9iK2ZVVnpXK1RhblBZVzczc2xCd2JERmNERW50bW41SENW?=
 =?utf-8?B?ZG9KRUtJRVQ3U0FoR3FGQS9BaWtBbjN0amdMeHlORnNrUFEzY0l3c2p2RWFB?=
 =?utf-8?B?UkYwVVczangyQ0N4ZVBDZ1hJTy9GL1VSTU1wSGdwWWFPKzc1NS9Pei9ZbUdE?=
 =?utf-8?B?M29jeUdTTUR5OWNkN3B3dmFKQ2Mwc0I5YktTQUN6U0o5QjkzRzlpMm1JeHho?=
 =?utf-8?B?OGpieU05eExxaTNuOHpMc2dMSmw4eTdLWjh5R3BwcWcvMTlTQzBNTnc4UWdJ?=
 =?utf-8?B?NXlFMjVUbjZ2OWFoRVVza3ZoZ3NseFdKRk1xRXpyZ3c5anRRYWVWSThYRHFR?=
 =?utf-8?B?K0NNbkhiaXprWWJTSThYREh3M3NtMzlkQmFYMFZBekhUNVRnV1FWd3BIOWZQ?=
 =?utf-8?B?R0VVZWdzRXlUaERVV0xQNFUvUEpBUWVjVDRKWWJoNk53VHNxeHU4YWs0S0Z3?=
 =?utf-8?B?cnp2WTI2Nm1VbE9rRFAxdWtQMkNwOXRRRElJWnhoaW8vV2N3RXFRbnplU1No?=
 =?utf-8?B?OGtheDk3R25vZmp2dGd6d1JadG9kOHp2UWRSemIrYk1DMElWSktZRFpBWnln?=
 =?utf-8?B?SG1zMGlpWGRHVDVvczVXck92OUxZNW9qWGFJMU1GZGx6VlpKYmQxNVVxZWtV?=
 =?utf-8?B?anhad2NlOE9IdzFUa203UmNXU1ZaN2tvbm10QnBHVENEUFZjVDl4SUJVQzNp?=
 =?utf-8?B?Q0h4dHNxVmI3VmljNGM1KzBkSTRtS0xvTW9yM2d5ZSsybVNvTDl0bFJERUIz?=
 =?utf-8?B?ekx4bnlKaGZxOThvTkR5QzBuWkNqbE9Ka3NDQkxwUHgwTEdXdFdzejdZTHZL?=
 =?utf-8?B?THJsT045cjltNURDYmZwSDk3VVNhdUR3aE9HV2JIdDRySElKRDNXUVB2SzVa?=
 =?utf-8?B?NWpmdUFkU01oZjNPbjlsMGN2S2R1b3gyRW1Oam95ZmJ4T0lpeVQ2ZGROU2cz?=
 =?utf-8?B?d1E3OUNvcjl4SUJPMDVsRjBOd1V6V0JTOHNXZ0hrNDVZUDFSZis2WUVCb3Jv?=
 =?utf-8?B?ZFk5Vnh4VDgzUW5PK3RKeDZMSlJtekhMaDhLcUVsMHR5aGN6UnppSnA0b2VX?=
 =?utf-8?B?cU5zVnpjLzFxdHZ1ZGExSm5BcWhJbkRlcVBET2FRbS84YTMxdWhhbUQvalF4?=
 =?utf-8?B?TTZGTU1xQVNCZGR1eUZQNDl6Szd4VmNDM0t0bGNmQlg3RVQ1RE1SVjRwazBs?=
 =?utf-8?B?UmYvN2JXOTNGQVAxMW9uL2dCZVlFOGtDVWZ6Qi9iaE5UYlNqZFlxbk1NNjJO?=
 =?utf-8?B?dlNhalpVaGhLQmxqNE9pZWgrcDV6S2JwNFpyakhMZjIwZS9mRERESVB4d3VM?=
 =?utf-8?B?Qjlmc3MxMVN5OHN0NVplY29zK2w1NTFZV3o2bkZmcWZZTWI0QmVoTEljR0Yr?=
 =?utf-8?B?MXNlY1dFZmN4YmRWdW9lbjgxd3RXdjllSEJZQ1lrQ0E3Q3RlQXhNbXNSeXRj?=
 =?utf-8?B?SElNa3NoeTZua3ZVMVZ2ZkxlK2lrcldjVmcraHRpeFFDeDh0QjR6MzJPYzVD?=
 =?utf-8?B?a3RuQkhWNnd2UFZQQXl4Y3dXQmd6bGczc2hoemtaMTR6Uk5zM0tPUkxTL3V1?=
 =?utf-8?B?WXVXSmQ1aUJWNjkwNENJSTNBNUp3V2JkVUwrYTI1MGY2K3NtdTZ0V0JUeHBs?=
 =?utf-8?B?OWZOR1RUVDQ4ZXlGQkVsZWEwakV5VVF4R2ZFYnB5V3VSZ0h0NUJrQlhPMGc0?=
 =?utf-8?B?cG1MRjQ2NnZhMWZVMUpRM3ZpQTFETGFocUl0bGFiejNva251aGZ2OGx2bjk4?=
 =?utf-8?Q?8E7Ciw8uBzMFdy93rin9NoRLx8nA+ZXk?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9715.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dTdBVkk1NkxhMFh5NzBYNGNzN3VsbVliaGhnV1VMMk1naGlta1dXR2NGSWFP?=
 =?utf-8?B?RlVNbjFGS2d5bmRZVlgxQ0FJYTBRQklGelJIUk5aT1p5dVd6RzhROUZTczZI?=
 =?utf-8?B?NXdKVUhkaDFvZVhuK3BKTVdhd3RWUlBLMFU0Zi92cW5FYUg5VHIwVlo2eVFO?=
 =?utf-8?B?c1JqbWNxR0NpVlF4ZnVZUForazdsekIwNkZNNlpNVUdzdGs1SmdFR3hJTk1a?=
 =?utf-8?B?RUszd3JjN0pTeURja2taendySkVMaGRvbFJkQ0UrdVNVODNYRzY3Sm5SWHZH?=
 =?utf-8?B?YitKTHAxY2srK01OR1J6cFdEenZrWHMwWlU5dTMyQnRYU3pKdmNBVHN6NW9I?=
 =?utf-8?B?RVgzOGpzRktKVU9pcXVVc2hZYVF1L3NyS3NxOG9DaUhwbFVaQnI5eGhuS2N1?=
 =?utf-8?B?Myt2Q2R6SXg5SlI3N21PN3JSbVA4ckpNMUJ4dDNzajA0UkNIYTl2VC90TFYx?=
 =?utf-8?B?RFVBdmRCazJCSFhvZGpZZHp4RU5yU3dPd1lyTUFCSFRFenp0R25hNUNhN0hq?=
 =?utf-8?B?Y1FUQStzcmk4QklWRVNjMHFGVU50L1ZhMDJGL3BOQnMwY1hxVWtWeDVMRS9m?=
 =?utf-8?B?Tko4UDd3ZUIzSTVTY2dRc2lFbWQvY2JaTzFSVHlEbWMrNGlyVytZOU1BZkhp?=
 =?utf-8?B?czZmSEoyeFA5Qms0dXhtWDUzdTBDbXFPVXdRY252bDRsY2pTbGFURXBZY0Zz?=
 =?utf-8?B?K2tzNW1hSFM3VUxKZXNwTUdDN3c4dkljVGYwcTJZTTFPM2JQR3ZaNThwazFi?=
 =?utf-8?B?YU1JRnhjN2tndFlTMWFXR25CYjByc2ZjZm8vcVpTYStMNjlYS2MyMERkZFd1?=
 =?utf-8?B?aVJGTE12WDlSS3RpU3FWUFMyZjNxcGV4OG8xeUFmSFlVWnpBUTgyS1RwRHg5?=
 =?utf-8?B?RGU4MEVmREdOcHBvczEyd3YyT2cwRU9NeUJqODlHbGVwU0JOcTdQYnFxSWlQ?=
 =?utf-8?B?WGJIdWlBazhtRmVYT0lmZGdmNjR3aDE5Z0JqV2xmRTJlaGNpaVBHeEFJdTF6?=
 =?utf-8?B?Y1l2VHprb2RaaFRtU3ArZTBaaUlQVGlMM2RyUmZiUnBkRytQNFQ2ZU0vWFpz?=
 =?utf-8?B?ZjVlOTJxNXkyNVJYQzVJcEE0ZTF3QWJZZnFnNE9PY0dFb1JoTFEzVVlkVU94?=
 =?utf-8?B?Nm1UeE1yWjMyOGFOMzV6RVhacVhVaFd1RTg2UFZ1ZWROajdua0FtS3dBQkty?=
 =?utf-8?B?L0VpQ1oyRHFQWVdEcXNlek5DQURaWm5FdnN1RXZXSG1sYnlNMkNjNzk5RDUw?=
 =?utf-8?B?ZndpY2ZVV2ZhVGxxSEpVUTFNYjIvcU1OQ2JEamZwNURNRVBLcCtycjRabVJu?=
 =?utf-8?B?WDMvam0yRzEydXBoZ2JqZndvTG5aczN0LzRsYmJRUnZKdzBZNjNXZkZzazZM?=
 =?utf-8?B?cU01eTcxYVRweWh3MXVYc3ZUZ0h1eWdkTDdXMGJ1R2VSY1QveE1RWVo0UU1i?=
 =?utf-8?B?eURZRWxwbjlMTHB2ZEdVWlBVQ2hmRXM5RWpjeG5HV1VvSVZZNUo1eERNZ3N5?=
 =?utf-8?B?cnlNK0VIY3g4TTc1MVVKT1N6UW45dHFFczlML0R3UzkrOVd4dm00eUp4ZmVl?=
 =?utf-8?B?U3FqdDg4RXJ2U3JXTzRkbkN4dTFQL0Fib2kxcE1PQmRBS29JRUE1TEhQVFFB?=
 =?utf-8?B?REI0b2MvOElBT0hiSStXbVloeUtBWnVsSWZGNWZHdUlNSjdqNDB0VU5IRU9Z?=
 =?utf-8?B?ZWlseHB6d1FMZCttNjJyV3pCWkwwb05ONVZnV1Nhc3lkbE5STEJ0UGxkTzRT?=
 =?utf-8?B?VXczOTBIRHZBMm4vTXdzTUxaZ2E0L1ZQWlU1R0N4cVR3RnRTaGFxY2F1ZlFn?=
 =?utf-8?B?R1dUeG81VWJveHRGUmI2USs3TmZjejVsWGhqYnV0MThBb3BsdGxpbHdvMG1W?=
 =?utf-8?B?NENrd05saWZNK2RSRXk2ZmNRMVFnVXdJOFI5VlJrb3BKY3hnMTU1azc5TU5R?=
 =?utf-8?B?KzNmYU4wTGJvNGEzVWFNVEViOVpUSGFZenJjY2tKeHh2eFR4TUhFZFdNakkw?=
 =?utf-8?B?VFRKakNyenlFQlM0em5DclJHa0Rjb1FHdm9aZ2ZsSWhjOGdzR3ZTWnJRL1Z0?=
 =?utf-8?B?NzJaUFFyT2tZOHI0T3d0NS9qTDUvelJPbE8vcGNudTNDU05KMEpGYk9SUTJw?=
 =?utf-8?Q?MuNMq4SIH+an4V30KC1ad0qSu?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b922e66e-9c1d-4680-b9d2-08de3bbe42fb
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9715.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Dec 2025 09:42:28.8745
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7Z+6lztfyTfEQ6iR4WRqp3k2lHFiv06Pv5ZiBwLQUjm9h7kfAjZmRadmsw4tfseaV7cCHQAPwef87JQzLo/iBQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7253


On 12/9/2025 9:23 AM, Tuo Li wrote:
> The pointer gid is checked at the beginning of set_roce_addr(). However,
> if it is NULL, the function continues execution and may dereference gid
> when calling mlx5_core_roce_gid_set():
>
>    return mlx5_core_roce_gid_set(..., gid->raw, ...)
>
> This can lead to a null-pointer dereference. To prevent this, add an else
> branch that return -EINVAL when gid is NULL, and remove the redundant gid
> check in the IB_GID_TYPE_ROCE_UDP_ENCAP case.

Can you reproduce this?

Theoretically, gid->raw is translated to NULL+0 which is undefined 
behavior and static analyzers can complain, but it seems compilers just 
translate to NULL which leads us to the expected behavior.

> Signed-off-by: Tuo Li <islituo@gmail.com>
> ---
>   drivers/infiniband/hw/mlx5/main.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/infiniband/hw/mlx5/main.c b/drivers/infiniband/hw/mlx5/main.c
> index 40284bbb45d6..d68a58d249d4 100644
> --- a/drivers/infiniband/hw/mlx5/main.c
> +++ b/drivers/infiniband/hw/mlx5/main.c
> @@ -645,6 +645,8 @@ int set_roce_addr(struct mlx5_ib_dev *dev, u32 port_num,
>   		ret = rdma_read_gid_l2_fields(attr, &vlan_id, &mac[0]);
>   		if (ret)
>   			return ret;
> +	} else {
> +		return -EINVAL;
>   	}

This breaks the gid deletion, we should still call mlx5_core with NULL 
gid for it to update the table.

>   
>   	switch (gid_type) {
> @@ -653,7 +655,7 @@ int set_roce_addr(struct mlx5_ib_dev *dev, u32 port_num,
>   		break;
>   	case IB_GID_TYPE_ROCE_UDP_ENCAP:
>   		roce_version = MLX5_ROCE_VERSION_2;
> -		if (gid && ipv6_addr_v4mapped((void *)gid))
> +		if (ipv6_addr_v4mapped((void *)gid))
>   			roce_l3_type = MLX5_ROCE_L3_TYPE_IPV4;
>   		else
>   			roce_l3_type = MLX5_ROCE_L3_TYPE_IPV6;

