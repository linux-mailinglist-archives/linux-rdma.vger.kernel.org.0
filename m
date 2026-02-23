Return-Path: <linux-rdma+bounces-17060-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KGPXC0xynGmcGAQAu9opvQ
	(envelope-from <linux-rdma+bounces-17060-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 23 Feb 2026 16:29:16 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BF211178BAC
	for <lists+linux-rdma@lfdr.de>; Mon, 23 Feb 2026 16:29:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 00481303BA5C
	for <lists+linux-rdma@lfdr.de>; Mon, 23 Feb 2026 15:29:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A545E2BE7BB;
	Mon, 23 Feb 2026 15:28:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ClAon9H0"
X-Original-To: linux-rdma@vger.kernel.org
Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010018.outbound.protection.outlook.com [52.101.61.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBEDD29B799;
	Mon, 23 Feb 2026 15:28:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771860537; cv=fail; b=MCuhuqKDy0ANybKgeQHmkxQYWdZ7QVv9rFw8cGVy2IhwhKZLdms8Z+CRf36prQqIMDWLKiSkYDwvMcoC7dTTO444N4kHIb5QiUxKMO0Ig0zf+24FT7KF07OyhrPq53xgDa1Mkrpu2dDwi7ErG55KsAiuYHZ1SeLeY67YnbAzNco=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771860537; c=relaxed/simple;
	bh=Aoy7oRSSA6EPvyGWV/4L+uWohZBM0k3QLh7ilSRvNK4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=L3pfUxPO5jXJ9uZCYvMJ8Bf17ZIcyae3EmtxkcVMpDWtIb1cdVVJLuc0sFrejHlXub0AfRPF+nLD1Q6yOulFu6Lh2Emf6Jmk1uTHXxAjvNlmh3n++dN2dKioSomH+wmfoAoEEcZIsQLsp0e0DvXo2tqydu+haGyrQ+WkuNHIC9c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ClAon9H0; arc=fail smtp.client-ip=52.101.61.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XoapGF7kMU9mvSDrff1dMcsp2VvvzH+5H/EEUhimaTsg84LHNCMRfQjdAtyk05I2HFhvX91P2HmtYiplqO2wneW0sjc6s1KCtMKhWNM2uJiLVvbbCkl4Qi/jFOmUJSuXit+8FykjmcC53DMmCXT/ghceD/urPjxviCV2vo4jrIaSaYY37fjItgvzcyDJuO3THeWSuAg+QPaCN1Bwaw9GfxRB7O4/BBj9gt6AKzEnkoo8hv/7fzvnlQEGC8JZBgjxM9SfD1Ba8a3J3zuFB3sFc7RBfsIwSbFXkkIzIMols993LD1MTGpNw6xqdAAl/J/aUNCBKBvE8c/r2kY2PT/0kQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GZCCEPPJKiGBojHruLTGj+WvfsQRDRxM51DNmZ8VZEc=;
 b=Lh3r+FAwipW4dWRTPRLXzhYNN3xWa9OV2EtvXV27T1d/ny6NyVu87KgDd0b01w3Z1xP7hrhKKNKz6Kz0t4/kEBL2u//L84Tw1O85nWkF7bmUMScfqpaMqMnOSrCk5nNkOwo7uBep+Mdxjc3vcYG+OWoBWszRkhKbxrg/g8HLmDve/olXt7OyD5BUyEzWV41IyRgHZTFZDbZdieBOMmnyODo6OiawJ1BkIgaBG2bH9O2MTxagA2T6qJuju/S+bcYIu7dV+OKikDPLgU32MPCR4B8UlJePbbL2nPdos1DMbjQqnc1BNA30HvNjgsUhdxqySH6Ut2/KXZY36eyJZCax4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GZCCEPPJKiGBojHruLTGj+WvfsQRDRxM51DNmZ8VZEc=;
 b=ClAon9H05Mn5b4KEnADEwif6I1UAeyFdki3ZrEz6fcq02ah7QmMgXPxXkPAnOZ0kID04X1UnWBBZiDakrnYJ9ufQcXIBW+ZVBefOexAhGVJlRYxiYItbNVdg5+Yf1y0IopeBEDGM0Ll/5SYVAQodCtS6TrKw9xmdW63w96UFMRg2B6XeacECHJYA5AhSv3VuG4VS6/V6EteVGAn70j8JK4zDPgokiWYUxaXiyvTObNr+bF4ALlcgjUVraPZdckWURW9yDXLc1dOHKI47exRagsqyrdWdoBVuHK9OopAToNJVCTdk/ooOmD8h2PIRUd+8TPBJIGOR9QIZbDsZURC+9g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL3PR12MB6473.namprd12.prod.outlook.com (2603:10b6:208:3b9::16)
 by PH7PR12MB7163.namprd12.prod.outlook.com (2603:10b6:510:202::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.14; Mon, 23 Feb
 2026 15:28:49 +0000
Received: from BL3PR12MB6473.namprd12.prod.outlook.com
 ([fe80::778:72e1:e792:df81]) by BL3PR12MB6473.namprd12.prod.outlook.com
 ([fe80::778:72e1:e792:df81%3]) with mapi id 15.20.9632.017; Mon, 23 Feb 2026
 15:28:48 +0000
Message-ID: <b1da71d7-3daf-4850-9239-fd3e2a946d95@nvidia.com>
Date: Mon, 23 Feb 2026 17:28:43 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH rdma-next v3 2/3] RDMA/uverbs: Add DMABUF object type and
 operations
To: Guenter Roeck <linux@roeck-us.net>
Cc: Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>,
 Sumit Semwal <sumit.semwal@linaro.org>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
 linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linaro-mm-sig@lists.linaro.org, Yishai Hadas <yishaih@nvidia.com>
References: <20260201-dmabuf-export-v3-0-da238b614fe3@nvidia.com>
 <20260201-dmabuf-export-v3-2-da238b614fe3@nvidia.com>
 <716e8a8e-e4e0-468d-9314-10082c2bbb8d@roeck-us.net>
Content-Language: en-US
From: Edward Srouji <edwards@nvidia.com>
In-Reply-To: <716e8a8e-e4e0-468d-9314-10082c2bbb8d@roeck-us.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR0P281CA0153.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b3::12) To BL3PR12MB6473.namprd12.prod.outlook.com
 (2603:10b6:208:3b9::16)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL3PR12MB6473:EE_|PH7PR12MB7163:EE_
X-MS-Office365-Filtering-Correlation-Id: 3ddc88a0-be29-4302-eb8e-08de72f03d99
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UVZQUmdGeXVhbUFSODYrdWtZeWppdFpITENrWWIyckt0TldsRlV0N1JFNUNz?=
 =?utf-8?B?ODVQR0sxRlFoMGVkbnh3dFdvMERpZmhnWU1SaG44ZS85YzE5QVVVWktRUGVi?=
 =?utf-8?B?QlZJM09mRkYvNUUvek1SQk5CTkg2R1BCZzN6MHg2VUJmVWhhb1dPZDRka3JY?=
 =?utf-8?B?c2FLZC9aMlBEWXZyZEdxY3lJdngzTHNYejUybUI3ckV4UWRzNHJBZjJVc21V?=
 =?utf-8?B?UUprY2RmY0RUemlOazMrZGJVV2FiR3pUS1cyU2E5cXFxQU5tRjF5ZXp4WDBu?=
 =?utf-8?B?aFYzWWE3RktVY0xIVzNjV0tGWTA4QmZoRDdaSTJ3alpwWGVUd0I1bjNONElt?=
 =?utf-8?B?M1BvUXNwejIzU3Qra0ZMYjhYVkxEUE9pV2pNMHdWbFl5cW5qOUtBdjVrRzNS?=
 =?utf-8?B?aDE0cHoycWRla3JqZXN6bjA3VHU2NWNPTVI0aGRhOUFnSU1hUXNPSklBZVlV?=
 =?utf-8?B?Sk1YVEt4NGI2RkduSFNUVTl3ZUZoRXAxQWljTzJLNTFrUVhsSXFLM25VNGxx?=
 =?utf-8?B?MGZHUXJzVStKV0lMSUVJbkMxTkNQTUpiaEFOZERZMXZRR0dyVXVwTUlMV1pV?=
 =?utf-8?B?VkJNYVYwZGFFK0poelhkdEY2MzQ4WEp2eGthV2FMbjMrcE9SK1FhbjUxZW5s?=
 =?utf-8?B?SDN0ZjB6Q0plaThxcDdGcjZpVm1HMzF5SVQ4eXVoTlJGd3p4K2lqTTROWmJi?=
 =?utf-8?B?ejI0d2lLOWtaQ2pqTS8xSEJzMkVVazlJaHloeXR3Um84ZW5keUYxVzBwL1Ni?=
 =?utf-8?B?SytZaWpZZjRkN3ZFSWhLaEVxWWI1K1dwUFU3Q3YzU1pqaTM3WjVHYi9YWkV5?=
 =?utf-8?B?d3JyMGZXVGl0azVvVlZUSko0OG9kNmVYUjhUdFVNTHRPR2xpUDhFekVOaWhl?=
 =?utf-8?B?YWFLelk4T0c4Qk5IaTFUZ0hWaG1iUFlMTWtTbGZrMGdWQVJDWjR6SVZSbmxP?=
 =?utf-8?B?MGRSTEV3SWFPWkgvMEExbmR4Q2Q2S3JQWTk1WTRyeC9jVURrSmMvS2R2K0lI?=
 =?utf-8?B?ekluMVROMi90eDN2aUpnMUc3c1d1RWxaWHJOVFFDREIzK2QwODU2d0diNmcx?=
 =?utf-8?B?RHRMRUxSS3RNczdnMEtRSXU3U01HcGdLQlRzSjlMeDRpdVUvN2ZMRlU1NFR3?=
 =?utf-8?B?cXlPSDBja3YwWUlLTkdEdUZqUWhVbmtqWTFROURXK1EvYUQxdFJ5MnhoSWJJ?=
 =?utf-8?B?V3lac1NzYkNGSE1BYm94RXJzdUN5eTlxMGFpcjZCN1NNa1ZxSnJKOWNKV2VC?=
 =?utf-8?B?bkVnRlVIaFA5dGtHVUxPUit3WTE0cDZPdDJEa093QThlR3FaZmcrTnFlWENX?=
 =?utf-8?B?S3l3c2s2ejZxbFE4TmN1b2V1UE9JNmhqSU9XU2NIVFNxa0ZaTUFTQXBXRlQw?=
 =?utf-8?B?SEwxNXM3NmVFWHEwTUVBcnlsSHRETUd5SDFRZVlGYVlGMks5cXZNYlFDZVc3?=
 =?utf-8?B?d0gwM1BJM3ZsTnhFMEhSbnJCUFdtQTZZdUhyQVN3engwa1NyRHJEMnRZZnZk?=
 =?utf-8?B?TXNjdk5ESkNuenBrd3pGOFdVdWFFQ3gyNk9VRkRVU0F1aGZHdDEwVDB6L2Ix?=
 =?utf-8?B?ZWorZ283WEs4YmpzY3ZId25NK3kvQjVpWmVCMmd3SXZnSEdZeTR5QnRDRGZo?=
 =?utf-8?B?OWxzcW8xREhtemluMlRhczAvdHBHcUxrVUxVdE9QeHI1cFpEeU9CVmFNdS9l?=
 =?utf-8?B?a040eXZIdVhZYTFzc3hqYnY0dW9UQlVwZnBtV3FNbk9WR21JK2lIbWM5TlNv?=
 =?utf-8?B?MmxCMUhNV01nbzh2SGxSU2dwZTdDOUJnLzNnMjVHMkxmdnd4WHRLSTFSZzZW?=
 =?utf-8?B?aHp1Vm5XWWZDTlB0ZDVSY0hIU0ZtWnJMQTlWbUkvaDhyNW0rS1B0bW9DWnZQ?=
 =?utf-8?B?NExLZlh3Qm5yM2tXc0hTSEdSYmQwZHhWSzYyQkxPSFdxMjhQN0pWL1hERFZB?=
 =?utf-8?B?ZnNmTTFZQ1BIYXlvb014bU9DSVo5MHZuUGZmd0RSdFZsZUxvWmpIdGRLaU9P?=
 =?utf-8?B?S00ycXQzZ0RzMS9vT3VjT1dlQ1c4ano4L20wU0o5Qy9VVGlHdjFWT24rWjNG?=
 =?utf-8?B?eDZhMjY5SllFOCtBNy9YTEFIT09xalNleUl1RTRsdk1jMWJBRGRVMDV0NDdD?=
 =?utf-8?Q?9TOk=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL3PR12MB6473.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YUdybmtxZXhEWTdzZTVVWFE4SDJhazFIaklJOE5Icis1dkxKWGtOMjJVTXNU?=
 =?utf-8?B?YnpBdEtEL3RScTZsdkM5d1A3VFZsTVIxN3ozMnhSZlRUMUVJbWFUNkxDVVd2?=
 =?utf-8?B?MFNuQ1J0Z2ViVGtmalE4OVJMTU80NUdYQitneFYrSnM1MXFyeE9xM3dTOC9Q?=
 =?utf-8?B?ek5ydkN1MkVEQ2U0dkc0c0hEMzhDZTlYcm96NkQ1TkgwbS81K3loR3h2Zy80?=
 =?utf-8?B?R28vRFYzOG56eFhtc1dSeStLcTFsV21ndzhwL01NT3d2eXlnelo1akVJd1Mr?=
 =?utf-8?B?d2tqbnN4dzhuNVdXMWdiQTB6SG5uUTBNNEJnblpuRUlDNmpybUI5SDFxS09j?=
 =?utf-8?B?ZVVVd3REU0F1SUFjZHljaG9UZ0g3Q3dBdkIrYkQ2a1JaY0dXMi9jeEZ0ejBo?=
 =?utf-8?B?a2FjR29JQnBGQ3RER2RRUVhwSGNjdm5QQXRYMlVjc21IZFpWdXpoMEc3ZEhv?=
 =?utf-8?B?YmF2RnJIRzRwcHo1elVLaUN1UjdUa1pidHh4aWRrVFNQaGdqU0paUHFMdHhw?=
 =?utf-8?B?MzdPL2NLQ3hJS24xY0d5d1RaaFh5b24vM1ZZMDQwMTcxbFJQYVVoQmRJU3pm?=
 =?utf-8?B?RFc0MTFjU3VUZERXSXV3QzNjbFkwTkwxT0VEYkJtK1BLM0pRRW9OZHNoVlpH?=
 =?utf-8?B?eUdmSFNldHgybk5JMVljOHVXM2dWTVE3M3ZtWkN1MGVONHJMNDVrRnkrSDlW?=
 =?utf-8?B?ZDRkL1plbk1NQnk0VFhvVThjMTNaVUJQUG5SbkJGbFkvRVAzSXdCdmVlNmNn?=
 =?utf-8?B?K1l3U0lxL1JUNFFjZXVvZmNsWFgvcHVzK1UwcDZPLzBmSThGdzI0UGhybVJZ?=
 =?utf-8?B?S1NxcXExWXFSTnFEWUxNWUoxRHg1OXNTdncvd3RWUlFOMkNHQ0RKVW9MenVN?=
 =?utf-8?B?RnR3anVBRkxJdE5Ic1NCdnUrMXRvOWM2ZlVMWXNlZThldFczcTZmUCtrUTNm?=
 =?utf-8?B?MEFITlFkc2gwTWkva3dNM1RINnN5WnBjNThqS3YzQ0x1cDJDQk5VTnRtODhN?=
 =?utf-8?B?R2YyVnlRTGZjOCtBR2t3MmNVVml3b0JFZ0F4Ry9URC94cnE4ZHJNM0U3d0F6?=
 =?utf-8?B?NCtmSjkxNU5DSERyT2ZMVUZ2TVdTM1hRTzREVzVrN1A3UTMyWXRqdWpENVIv?=
 =?utf-8?B?M05hNmRvVjBJZ3NnWjJwRUFRSzF6S3daV3cvSEkzUmh1eS9SeDRpVjQyWlBC?=
 =?utf-8?B?L0dueEt2UVphcmVTUWF4Zzg1ZkJsdnEvbFkyN3IxL2lzMEhNVjcvenBoVjJ6?=
 =?utf-8?B?c3JwT3poN0xFY2hJa1RyTzQ3WmM0djgyUEk2cGJ5YmNGelA2eW45Z3pwVjAv?=
 =?utf-8?B?bnZTR05sdjBTTGxPM3RoZzArQTZxY2YxbXIxWEVuYlBEYzRMa0o0UitsaERL?=
 =?utf-8?B?aHNrOFJEbjRXSVNyRCsxZzA5RFBuQmFIcDQ2YUJxL3EzUzh0Ri9wUjdCd1U5?=
 =?utf-8?B?U0txZ213YWdhWkNKWDQ0R1BZM0psRG9tSWRQb1NmNUNtamxUa1pnb3ZEYkM1?=
 =?utf-8?B?L0Frc2hteXNZMzRqbDI4d3JwcEtXWlFZaWJPandPVHVmb2FxYng2SFVOalJG?=
 =?utf-8?B?QWtlcXh1RDV0M29JcHUwbldTVzRqMEs1cVdQMDhwWWp4WG1zS3dqb2hMWnRw?=
 =?utf-8?B?RzdBT1UvWHNxUFZxcDltN05DS1hKdkl6M2pDZCtpaDY0SDVNb2JnM3IyV3Zt?=
 =?utf-8?B?UHZHZG90OWZ1dDIzR2Nvb3pXWVNRdWdwMlBJR0VQR2JRK28yRzhsSzA5Z00y?=
 =?utf-8?B?ODdrZ04xbFV1N0UyUmZ1WTdqQVBHRFZyZnlqWkRBZ2lXRlk1RGtndDFydXM0?=
 =?utf-8?B?b0pOVDZLdmdPWEJsNU1vVDR5cDhtaEhLQzM2SWRKWlltS2drQS9BTG9lTXB5?=
 =?utf-8?B?emJEMmdFUStaRU9OcUc2NnpsVURiUGN3UUUrRHFIY2p2NE85NEt6WkVVZ3JC?=
 =?utf-8?B?ZmNNeGFYM2RZWVNDT3FKZkk0K016T1YranNOMGNMb1FuM0UzK3ltaGFrSGlD?=
 =?utf-8?B?L3kzbUlVZGVDUDEwVjcrZDBtcXRSdUZYNFpyblNsOG1YSVRJcXJHSDg0bmVz?=
 =?utf-8?B?dkREcXUrc2Zia1NMUmRhVnhKTnptREJqazRvZXZkbmUzZ2FTWk1iUnVpbTI2?=
 =?utf-8?B?TjFSVW54Y3JnL3A5Y21RUlVjVU5zTGF3WURnWG5MYWhHYk1ra0xEVUhoK0JL?=
 =?utf-8?B?S005N3JaaXNTTnlYaW5YWnB0QjgvMW9QbXphMDdrV01JSzRXUlRGUDBFbndM?=
 =?utf-8?B?WlFwV29OV1pzelJEbDJ6a1hCYnpqbE43ZkdEd0FoTzlxREo4cUJUdG1wcm81?=
 =?utf-8?Q?d5YFPO5XCxIiYOEIxG?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ddc88a0-be29-4302-eb8e-08de72f03d99
X-MS-Exchange-CrossTenant-AuthSource: BL3PR12MB6473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Feb 2026 15:28:48.7829
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GrYMbYLz3VAbQh2awNb1AkaGPfYwHCXYRhuV/J0Lis5SwIpq0HK0pv6qrY7urYlvFMRozK+3fiBZmq7wpKiEDw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7163
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-17060-lists,linux-rdma=lfdr.de];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edwards@nvidia.com,linux-rdma@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	NEURAL_HAM(-0.00)[-0.999];
	RCPT_COUNT_SEVEN(0.00)[11];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	DBL_BLOCKED_OPENRESOLVER(0.00)[Nvidia.com:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,nvidia.com:mid,nvidia.com:email]
X-Rspamd-Queue-Id: BF211178BAC
X-Rspamd-Action: no action



On 2/23/2026 6:59 AM, Guenter Roeck wrote:
> External email: Use caution opening links or attachments
> 
> 
> On Sun, Feb 01, 2026 at 04:34:05PM +0200, Edward Srouji wrote:
>> From: Yishai Hadas <yishaih@nvidia.com>
>>
>> Expose DMABUF functionality to userspace through the uverbs interface,
>> enabling InfiniBand/RDMA devices to export PCI based memory regions
>> (e.g. device memory) as DMABUF file descriptors. This allows
>> zero-copy sharing of RDMA memory with other subsystems that support the
>> dma-buf framework.
>>
>> A new UVERBS_OBJECT_DMABUF object type and allocation method were
>> introduced.
>>
>> During allocation, uverbs invokes the driver to supply the
>> rdma_user_mmap_entry associated with the given page offset (pgoff).
>>
>> Based on the returned rdma_user_mmap_entry, uverbs requests the driver
>> to provide the corresponding physical-memory details as well as the
>> driver’s PCI provider information.
>>
>> Using this information, dma_buf_export() is called; if it succeeds,
>> uobj->object is set to the underlying file pointer returned by the
>> dma-buf framework.
>>
>> The file descriptor number follows the standard uverbs allocation flow,
>> but the file pointer comes from the dma-buf subsystem, including its own
>> fops and private data.
>>
>> When an mmap entry is removed, uverbs iterates over its associated
>> DMABUFs, marks them as revoked, and calls dma_buf_move_notify() so that
>> their importers are notified.
>>
>> The same procedure applies during the disassociate flow; final cleanup
>> occurs when the application closes the file.
>>
>> Signed-off-by: Yishai Hadas <yishaih@nvidia.com>
>> Signed-off-by: Edward Srouji <edwards@nvidia.com>
> 
> When trying to build powerpc:ppc64e_defconfig:
> 
> ERROR: modpost: "dma_resv_wait_timeout" [drivers/infiniband/core/ib_core.ko] undefined!
> ERROR: modpost: "dma_buf_move_notify" [drivers/infiniband/core/ib_core.ko] undefined!
> ERROR: modpost: "dma_resv_reset_max_fences" [drivers/infiniband/core/ib_core.ko] undefined!
> 
> The code now requires CONFIG_DMA_SHARED_BUFFER which is not enabled for
> this platform.
> 
> Guenter

A fix was already sent, which I believe solves your issue:
https://lore.kernel.org/linux-rdma/20260216121213.2088910-1-arnd@kernel.org/
It adds 'select DMA_SHARED_BUFFER' to the infiniband Kconfig entry.



