Return-Path: <linux-rdma+bounces-15185-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D3604CD98D4
	for <lists+linux-rdma@lfdr.de>; Tue, 23 Dec 2025 15:08:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AF0E7300F302
	for <lists+linux-rdma@lfdr.de>; Tue, 23 Dec 2025 14:08:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A46782FC007;
	Tue, 23 Dec 2025 14:08:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="eX1gySjU"
X-Original-To: linux-rdma@vger.kernel.org
Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010009.outbound.protection.outlook.com [52.101.193.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA678266565;
	Tue, 23 Dec 2025 14:08:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766498911; cv=fail; b=aGEbkLPAamIVon4PmVD3LOea7bd6Jc14e/pJfS37RCR/8NUm403HY7CVJDUdO2+93ENGOv2+g+TOSPoegWnDQEMNSQsz0lYpBkBaIcNATe79CQstUgyptn6KHsIPrNilyl9hYKIznqGXUTt6lfSnNpRT0vYS+/g4Vcg6kcRfMS0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766498911; c=relaxed/simple;
	bh=xUi4He4QKBiaPHY1y03BVRDaJpoWrPwZNmcuculp+KM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=jSQmzlv49nL8zkPaHZ6mn7EufpeJhk1kX+306+veQVtjAMvMr1oX6ZQq/j5wcjEsqWDFP/6XYiVJcJdZ1JreaOQbGLqpDilB4l2I0irrYagjvsBeuK40vmKLJNqBzmOllA3tDtOSEWwy4r7V8CXdkGooxcSxJdmAHJMoyEZgRdE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=eX1gySjU; arc=fail smtp.client-ip=52.101.193.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rKjP9DhNOmyE7f5W3MfUwD89l+uPguhOY0p97JjjpqToKmEBfARWdlw0MsGEYnPeMX3reGSMWf6R+y4EwSfW3iMsnChBEiPdj8TjEQHv1kEL6HFqaa3JL8AMFvyBfihpXWohA1JnhMz/GJWnG8e2PwuVAF2ZOrMrUG104WvpQQf68IpvsTlHXA6cnhRWEX7ybBvvFyLUF2zQbCgh1saSXPag8KDpykZiA4Y0iQiDujCNWna3MKuYyEHlSdjfQo6ir37GmnJAiqsTAK1E/nXuFpFFfPQtWSzf6QFob0XtUuIwA4JWJETLc5YtG9G+G67Iiy+zFcuvCm0OuCe0uB1STg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x4GXR2Mll/PSSkkP+2MY46z1j82mJ4aivbtLRNr6kUk=;
 b=k9vJQJVHAqY/Q28yrKdYtRjmUxT8k2b6NkiZtK1PDZDxOu7Soosaqq4FYO2+1T0jJ6rfKH3YUine1qn6XPwDOQbN3vnemWykdCiXVc3aoQREJUFxpsS6YYyKwocHRNyHsd2mABlKrlndo1wM98G8yFuo1aA8EJ8bp/ITjoWkzEFN0PK2z9R1A3CA0GxOO6jKKaF+kQLt5YFB6VbOlIQufZaeDJ2DXdI5KZ+LwV++Ai5+N7/cwRFWgFe0qtn2ATqThkqWvHl0OQcfCC+rSaYpz+E8Bu/XqN7hn3zHmIxweQngLuGIX/XwCTt/10WRHhSAXMKZgNrJNb2YqIfde9ciLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x4GXR2Mll/PSSkkP+2MY46z1j82mJ4aivbtLRNr6kUk=;
 b=eX1gySjU2vTPtO0Z0OH8gCuFXDZiAlxtjdajcdheJV7JHs+lV9ZeFrGvg3/gyKiHcD2mZUSB+OXiXIpbflv6mig9BuI1r0C4YpAB5A3L6VbQ2bEhzDxowuoQ2xxhPkCvz87AgKHF/A6s1FTPvC/jjPN1n+hU2s+D8WOGFVZ5qCeS8pnM8oCkuYSK1NH22V9iHEnknwr1tOyHMpoOsprJBdireDethygAJJTzUoD8oR6V+L2b1zMRx8aHAHoRandZJUlmZUgEPOrSuw4Hd1ynwzoaLtsp/XPnTZDcey9PZ786kL/iQQcihCHA78p+nYpsVYm1qHuCeNl/lsC5FAlmXQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9715.namprd12.prod.outlook.com (2603:10b6:408:2a0::7)
 by BL3PR12MB6428.namprd12.prod.outlook.com (2603:10b6:208:3b7::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.11; Tue, 23 Dec
 2025 14:08:22 +0000
Received: from LV8PR12MB9715.namprd12.prod.outlook.com
 ([fe80::1643:57be:ba7:a15f]) by LV8PR12MB9715.namprd12.prod.outlook.com
 ([fe80::1643:57be:ba7:a15f%2]) with mapi id 15.20.9456.008; Tue, 23 Dec 2025
 14:08:22 +0000
Message-ID: <eb0d0439-c09b-4c10-be5d-a338ede83742@nvidia.com>
Date: Tue, 23 Dec 2025 16:08:19 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] RDMA/rtrs: client: Fix clt_path::max_pages_per_mr
 calculation
To: Honggang LI <honggangli@163.com>, jinpu.wang@ionos.com,
 danil.kipnis@cloud.ionos.com
Cc: jgg@ziepe.ca, leon@kernel.org, linux-rdma@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20251223034324.13706-1-honggangli@163.com>
Content-Language: en-US
From: Michael Gur <michaelgur@nvidia.com>
In-Reply-To: <20251223034324.13706-1-honggangli@163.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TLZP290CA0012.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:9::10) To LV8PR12MB9715.namprd12.prod.outlook.com
 (2603:10b6:408:2a0::7)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9715:EE_|BL3PR12MB6428:EE_
X-MS-Office365-Filtering-Correlation-Id: d41d827a-0f8c-4279-b88e-08de422cbb79
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TEl4MUE2bFVid3AyeXpGV1pMWEQ4UXBCS1VNVU1mZFNoc0JxTFRyaWVpUVlp?=
 =?utf-8?B?eVNuZWl0a2xiWXkycjJFdmMwVzJBeUJWQ2RwMktFTy9QL3VPZGRhQXhUbjBS?=
 =?utf-8?B?TElRMnlTbFFDRy85ejArSmp3Ykx0eVJyVXlrTFNST1JOdDEvMVc0VGg1bHh4?=
 =?utf-8?B?TjA0SHhDbnp2VVcyUGZRc1JWOU5PeVFhS1NpeVEwTkp0U2RwMGRCRlNuR1Rm?=
 =?utf-8?B?WXRCSDRhNHJMV1NaM2x5WHJER3dwTWdUZXhNd2NKVG5KUGhhRXRJSEJwRkRw?=
 =?utf-8?B?LysyK2xncWpnY1RFRThEaUV3T09QWHBxZ0hlazI2dlBoTjYvc1lPS2Y2RnZ5?=
 =?utf-8?B?M2FBWlpxT25pdGVLVUFZUlFpcWhsc1JlTjFFNDR6K1IrbEF1SENaZ25Oc0k3?=
 =?utf-8?B?YkhhdnArU3B4VkYwaDdwTUpQWWZvTDl5R1pkWFVBOXoyTnZyYTdXSms5K1dQ?=
 =?utf-8?B?anBCWG9Tb3FkUW9jV1g4ZVZkSWlTcVFZOUVScmorVTNMTUVIMVUxUHZMZUJ1?=
 =?utf-8?B?Tk5EaWs0SXlIeFk4eWN5QkJMTmQzYmFxVmJobDhDZjhKTEhmYjR4RFhQMzQ2?=
 =?utf-8?B?eGxLdXJZTWpCeFZSRXdpRUFCOUJ6SHhGMVhlQ3hiR2NHays2MlVwK3kvU0lQ?=
 =?utf-8?B?VWF3c2szOGZJM1ZTTU43a25PdGtGVWJVWDkwdUJKWHlNOGs2WDRUZVZYclpo?=
 =?utf-8?B?ckxnU3IxR2JTVXJSU2pMa0tqUll3ei8wL05nRFJ3dC82SitweWNxRVJMN0VP?=
 =?utf-8?B?QXVDdDBtdVhYV0VjR2FDQ0tQUk9nK1dua2tnM0szcmZMT29vV3FIUEswRWpz?=
 =?utf-8?B?cWJIRUNJYVN2WXA5bVRuK1htRVRENlljY0krb2M1MEdTdlR2aVZoaFRKUzJx?=
 =?utf-8?B?NnUyNnFFcXJHVEs4SXE4U25pRHV0OE9DOVpQalFKVWdqeUFyWUhhRnp6RVM5?=
 =?utf-8?B?bk1rcmdmNXZyWWI2UVZsTU0rMktOaG5zMFRUdFpQU1ZEYnE4enBkRndGQUtu?=
 =?utf-8?B?LzNwZlAwaGhQNGM1b0o0Sk54bUFFTkN2UHJ6SmFBNFRuT2Z3aE9pR0hUdVMv?=
 =?utf-8?B?emltT1hLNzdKckx2Q3hqR2ZXZHZ6b0huQUVxNHRUWkswV2xyUEI2eng5aWNP?=
 =?utf-8?B?RWVsbHlXTW1aaFY4OVFMMG1CVHJJNlc1b09RNmdXYnl2cFZnVzkzakJuQmFW?=
 =?utf-8?B?WS8xSVhlUytWVzBFSDhCUGVzN0JGSXY1UHlVSFEreDc3OXdSV0VQT3JTWjN6?=
 =?utf-8?B?MXFBNys1RnlIZUo3QVBySEZQaUZTTHNGV3Vzd0NrdGFWdTBINDFsd1RJcGpF?=
 =?utf-8?B?SGU0enQ2Kzd4eVpZWmluaHNWUGN5eTZTdXhjM1NKTGNzRjI0WVBQVTVhT09V?=
 =?utf-8?B?S2VLV0lpTEVITmlhbUV0V2RBdEx0QUYwMmtubmFsL0R5UHF3SWt2dVBmSjg3?=
 =?utf-8?B?TEFWMUdZWUZyRG1zMGs4Ly9wbmg1aFlvVEFpelViQjd1ODhjR1FlOWt4MzNk?=
 =?utf-8?B?MWhjQVJXekphS2hiRDFlZzhtNVhkMXdONDc4N0FXbE9KaFNvenJkZFZKNDlM?=
 =?utf-8?B?STlIcnZubkdjL2k3RXE4ekVlQThpOWVmdTFMRFVoeEpLdC81WnZzbGZZMFUv?=
 =?utf-8?B?ZE1GKzdUZFdpSDJOYkxkMnoxazJHeGt4dVVBRUFzZ1NwS0pmYTVicWZsZ2Ft?=
 =?utf-8?B?RGxBRjc4QUo1RThuSk9ZRTBNRUFXSFQvdEF3VjZ1QndSRy9ZUGVaMEFrUlJC?=
 =?utf-8?B?OHo0RHhnWWFUbVl6dzdBNTRFeWJza056SDVEN1BoZTFaQzdXMmEvRlMweVBj?=
 =?utf-8?B?VjZydzZjNzN2RStheWgzdVRTVFVCRlhabThVMXdwQVdEVlVKNEk2dzY5ZWRs?=
 =?utf-8?B?ZmxjTkVBcS9xcFVHQzZyVElzc0s2blhBVTYrRDk5UnlsNitiMXFNUGw4NktD?=
 =?utf-8?Q?42A34CTFzAQmf6WwzZfRLW4SO5Ed5Jbc?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9715.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SWlYQW5vQ1B1emliWE0xNkFZcERYVGZrQUViR3hUSUxjQXVhUXl5WE9aUllZ?=
 =?utf-8?B?b2hGZHQ2M05WN1JGTEpwUS9LdUVkdUFRSExwRWw4QjVJSVc1WWYvcmdaNkVJ?=
 =?utf-8?B?NmEyelMzL0Y5cTFRT3NCUFpqZGlFNHEwK2NpN28xUjVaWjNFWFV4Tjl2TnFN?=
 =?utf-8?B?Y0lpS3VQM1gzQ0lkNzladGVNUDhHUDVyR0JOUm9yZG9HUC96czR6b1NYb1pr?=
 =?utf-8?B?ZTIxdEQ5SFRaVWRBblFORUFCbGQrU0Q4WWFmOTVleFJXeVhnR0ROZ3U1WmNo?=
 =?utf-8?B?ZVBsbkNpdVFwZkJGUmhHQUEwVFRsM2xFUzhKYndkMzJjMk1peEF2V01NOEpu?=
 =?utf-8?B?d1lFbUh6ZkVuWGh0MWJJOGJ0MlRDdlk4djhERTZ3bmJQL3RTeFhNNWRWbmFI?=
 =?utf-8?B?QUVTM3FoenNQaENqTlFGRGxnaWtXaUFPUzhJNGVQL3N6SlNjQytwNlVtU1BT?=
 =?utf-8?B?M2pZamxNdmZ1WTR3c3M2VnY2VGs4S3phZVovRVlySGZZUmZaNFVEV0FBMUIx?=
 =?utf-8?B?ZXIxTk10VmZtYlF1WTF0cXNyMStQd2c5YUlYR1hSb0l2cGhzV0Z6Y3F4WjN6?=
 =?utf-8?B?Z0d0V2ZwR0x2VzRGWEFxR2FYNFpQRGlLblFUTGtTNGVFNFpoaWkrN0NONjd5?=
 =?utf-8?B?aXhaNURZWE5jK2prV3NjMEY1VlZFM0dBRHM3bU94Ti9CWmlKWkJJS3NJMUV0?=
 =?utf-8?B?MWZyR1BZZG5DMkVqa0QrQmVGbnFVYTdUMU05NVA5SVdqSGhiMnM3eXBVandQ?=
 =?utf-8?B?V0g0RUt5UkpZbWNmTE1mbjFPQTl5Z2xVY1BqRFhaMWZSYWM3K1NSWGl4STVP?=
 =?utf-8?B?bTlQRDRCdnV3YTdOSUtIc2JCMW5hTndyYTVxWVJJaitGOVRYS2hiOTNPWnVq?=
 =?utf-8?B?V1UyT1BrZ0lHVWFwSThIVzhaL0w2YThDa1V4c2dIYXcxOVN5SzQrTGEyVkZR?=
 =?utf-8?B?Y3VLQ3d4ckt3TDk3ZmIweTNsSzMrSEE5enM4QjZRaXE5LzIxTlZRYmJmRmdT?=
 =?utf-8?B?dkhhNlRReHA1UFMveldqanU5UU5saWdYV2VSRE55SnRGUkJwaHdsVTV4SUN6?=
 =?utf-8?B?ZEFwbnU2T055cjkvR0JtYUtha1ZNb05ESk5mYkQwQ2RtcFhBTkNNeFBHSE1H?=
 =?utf-8?B?SW01TlFERGJacXBtZDNRSnhneE5NWVZMRHV2bTY5T1ZjcEJPNURzYzlKYlU1?=
 =?utf-8?B?aHQ2UjE5dmxrUVMzcWxON0lwUXovYzAxa3dSekVuWW5DQ1ZUNmNnVmo1WFFt?=
 =?utf-8?B?SlNzRTNZaXdzVjVZU215clo5SFFQMXZ3eGZNemZsODk3eWNRM0pLanpqRXo5?=
 =?utf-8?B?Nys0VmFuZTJxOU5xYUcyWFg1QXdPbGZJbGVBSm5LMk16TFN3NlVtSnkyV1g1?=
 =?utf-8?B?b0VjWkYyZUJkWHZCdmRId0tvQ3hjTDlzV1E1MXVXZzZCblo4bEIzQU5TWEJT?=
 =?utf-8?B?TFNQRTJaRWFtMkoxMnc5NjYrWjJQK3lLM2tXU1JvS3dpaWRPc29seEJCTmJ0?=
 =?utf-8?B?TGlTYlg4Y0V0MU1zbk1pdmpHQUg2Ti9jdW9wdG14RmRCaUFaUWFTeWxVd1Vu?=
 =?utf-8?B?ODJSbUgrcTV4SWFWekNqbHVUdnEzT2tJbWxOcURJa29GdGQ1Yzl3azloQ0Zt?=
 =?utf-8?B?Q0hZTXVOSVFpOEtPamYybDNrRytlT3FTQUFGWERMeUVjdEsyZGRUNUxySGZ1?=
 =?utf-8?B?K2ZNY01SdTJiMjhPUWVOMUdwN1FpN2J2MFZvbllQYUVmNFJwYUl2RDlmb0Ja?=
 =?utf-8?B?bXBkZUlkbGR6b1FwSU5lRm9qM21FNzBXNEFhMGtUTEd1TFdXbzZBazNDaGJQ?=
 =?utf-8?B?YVVRRmFUUEt5azR2dmp6d3FFT0tEWDBlS3RhdmZqOVJwQ0ZSb1dsV3M5TUo3?=
 =?utf-8?B?ejFYUlhRbG1xODFZTGtYd2hpL2tYZ3d3NGh0RE0wUmhiSVhYMVlIeGxISVVF?=
 =?utf-8?B?dExmUlpLejdMUnZzT21ia0NjS0lucEJLd3lJbkMwNlhETUxWMUlFcnJGUzRQ?=
 =?utf-8?B?VTV5dnlsMU9xd2hZWnRuNno2NGhGc0dNOTl2N2RzTlRFMnhRZ0pkMGkrVzQr?=
 =?utf-8?B?ejUzSkU2cytNWkk3VlM4RW56eHVWOUt0MW1uUlprZkZSU3ZsT3Y4YmNPOGNx?=
 =?utf-8?B?V0xCbTJqTFd2RlZkRjFCMmswVFQzZWdUaUJVRll4b01hVXpyTGl1SWtZNGFa?=
 =?utf-8?B?MnA5c0lHSjhhd3UxU1UvWUx6Q1M4M2RXa0NUQStlM1o5MDE0c05OUDRyNVBX?=
 =?utf-8?B?VFh0VUVUdVYyNXJwZmczU2FEcGNnNDdKR2JYVXpDWlMwRktYTldRSmxOM3JD?=
 =?utf-8?B?Zmc5L3NQc00yNndhcFY5NUMyTHg5eERoMHl2QTgydjZsaUsvUmQwdz09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d41d827a-0f8c-4279-b88e-08de422cbb79
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9715.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Dec 2025 14:08:22.6743
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ePFEILp+M1HtBUOg3bnSxJVf0A39k2ko04wTZjCHgoYcgfcInJGWugJiQECveRckzQJRYQRQh0hXxjkc9y4Nww==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6428


On 12/23/2025 5:43 AM, Honggang LI wrote:
> If the low two bytes of ib_dev::attrs::max_mr_size are zeros, the `min3`
> function will set clt_path::max_pages_per_mr to zero.

Can't see how if the low two bytes of max_mr_size are zero it would 
cause the local variable max_pages_per_mr to zero.
The more probable cause is that max_mr_size bits in the range 
[mr_page_shift+31:mr_page_shift] are zero. Since that's what's left 
after division and cast to u32.
This means you are working on a device supporting more pages_per_mr than 
can fit in a u32.

> `alloc_path_reqs` will pass zero, which is invalid,  as the third parameter
> to `ib_alloc_mr`.
>
> Fixes: 6a98d71daea1 ("RDMA/rtrs: client: main functionality")
> Signed-off-by: Honggang LI <honggangli@163.com>
> ---
>   drivers/infiniband/ulp/rtrs/rtrs-clt.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/infiniband/ulp/rtrs/rtrs-clt.c b/drivers/infiniband/ulp/rtrs/rtrs-clt.c
> index 71387811b281..b9d66e4fab07 100644
> --- a/drivers/infiniband/ulp/rtrs/rtrs-clt.c
> +++ b/drivers/infiniband/ulp/rtrs/rtrs-clt.c
> @@ -1465,7 +1465,7 @@ static void query_fast_reg_mode(struct rtrs_clt_path *clt_path)
>   	max_pages_per_mr   = ib_dev->attrs.max_mr_size;
>   	do_div(max_pages_per_mr, (1ull << mr_page_shift));
>   	clt_path->max_pages_per_mr =
> -		min3(clt_path->max_pages_per_mr, (u32)max_pages_per_mr,
> +		min(min_not_zero(clt_path->max_pages_per_mr, (u32)max_pages_per_mr),

This still fixes the issue, but for readability, if max_pages_per_mr is 
larger than U32_MAX, I'd set it to be U32_MAX.

Michael

