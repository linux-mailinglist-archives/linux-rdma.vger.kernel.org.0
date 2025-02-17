Return-Path: <linux-rdma+bounces-7799-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E08CEA38F1D
	for <lists+linux-rdma@lfdr.de>; Mon, 17 Feb 2025 23:35:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A6E1716AA18
	for <lists+linux-rdma@lfdr.de>; Mon, 17 Feb 2025 22:35:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A95861A8407;
	Mon, 17 Feb 2025 22:35:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="eAD622Hz"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2063.outbound.protection.outlook.com [40.107.96.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E181F46BF;
	Mon, 17 Feb 2025 22:35:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739831714; cv=fail; b=r+gcxVm1Sku5siLss1BpWdy/uNv93CQxQmGcYSXj1TdkUBey+ZUTQcPbekMXBQnx94e/Jwa2XxPH4jLYjn4boo2gJDMEMx/XNYunp0Jkp1wxNsXQieQYqYo1Xeh1GQmRSt3vgIprI+fOwZ59Qef/ET2QtmPdRvItWbwXc4lQg/o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739831714; c=relaxed/simple;
	bh=KB3d1uoSycLlWg8Rr3iFFP/sXEmP6BLfsFmMWvuhLr8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Lv0NMaUUkIDVKbf4KNrhFu4nWAabYNVKpLP2cetmWotrG4U+Citqj8MszYTp+NnBushRugKlW3vIe4zWbEJhELvy6+JYtP6IHovjEE/ZYo+IGj88lDJ+Rw+xJ1CPUTOTrFDP4sZqgt/MmFDBRE5mlC6TYsLZPhnAj8Vt/UgIvIY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=eAD622Hz; arc=fail smtp.client-ip=40.107.96.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=utXhDuyc9YL2HrLEuehCjsRUO2fPY3HOpYf5f51bLqSSrhN9o3tb5V5BOFbbbOxQ2MET9iySWNZR5ycTVbFi2nmD2X8YiiI8K5M80fb+HRUBiF/yR28L2nimfGHtp6OanNxPygKWn1OmOFSGOe6gIbLcHqpxuxbAaSI5+lgvdTParu6gLmgbyEaWAN/KltfcX/RCviTt49D6ht4AW6TZDG6PgiENxwV//q88CFYNoDsc2Vf0nmTKNH4XVjG8bS0R61S/DoBock5IE/rc6xPJ5RtUm/k9XU4eUZZaPrHr6b8RjEJsQRTH45gCp8LazXWtj5QHlmJIkt4IZKR0+c292g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sI2rZ/eHz4V1KA+EjVqQl/5ey4UEZde5HxeTbcdpHb0=;
 b=K5r7Q5mAlfTlrcErBuukVjjTiYm33xB0dIVbyLfGvEOzYwKBzoXfc8EoS3THsQ/OhbsFOoT/j/ejnhyZ2oQ/0r/oQoZ7hyqdNkYLFtNkQCRob6AqXcouwszuYFU3OBggMBdhUatuVb+OQ6GBfFJ0zYia/qpapykEZtVx6r33TQKPqI9mvhtbJnadWghMx3jYHFjl0iKJvA+hDl3dmq89Mot0Z1UIQco4OaBxqXAwsil5MjoqfP0pmp0YdPk2/1Zy28c0+vhro+Xp/Ul3Qnv5UI/wUB8It/0beV/eEbvltU7zLgjB6sF3s7XZEY6zomSoOpU8HnIXVc+BoYT8gf3q4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sI2rZ/eHz4V1KA+EjVqQl/5ey4UEZde5HxeTbcdpHb0=;
 b=eAD622Hz6DaP7KaAd7pd4DkBoucSVIj/BGhQfUXQ2y9EKVbbbXDmss/rqXdXwMQLmLl6e84b1gumwI8l1WS6Flb4CXbh31ClYTNQzfcrqE93qF/HyA7X4uapKnZJ5dV5Lxh9a9X5CsBR1hWE2ah36RnZL7tPE4wFQSuNE/Wd77Kac3uCBJVrs7Lv99Nu259FVA9uqZkewkyt98eJGLYk+gYeCLejXT6B9o385Of9/JqyeSfxHBIH74rntEvz/va0+BIRnrghivMigi63UHzvP5i8aS8XOf+W5zc7PPvHGHWUSaPvZVfoybCUeNCiNoyx0QDXbKa8u//Q9B936eGZ4A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY5PR12MB6369.namprd12.prod.outlook.com (2603:10b6:930:21::10)
 by DS0PR12MB6534.namprd12.prod.outlook.com (2603:10b6:8:c1::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.19; Mon, 17 Feb
 2025 22:35:10 +0000
Received: from CY5PR12MB6369.namprd12.prod.outlook.com
 ([fe80::d4c1:1fcc:3bff:eea6]) by CY5PR12MB6369.namprd12.prod.outlook.com
 ([fe80::d4c1:1fcc:3bff:eea6%6]) with mapi id 15.20.8445.013; Mon, 17 Feb 2025
 22:35:10 +0000
Message-ID: <705c32eb-3747-410d-aca2-66b29dc19c8a@nvidia.com>
Date: Tue, 18 Feb 2025 00:35:04 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 v2] IB/iser: fix typos in iscsi_iser.c comments
To: Imanol <imvalient@protonmail.com>, shuah@kernel.org, sagi@grimberg.me,
 jgg@ziepe.ca, leon@kernel.org
Cc: linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250217183048.9394-1-imvalient@protonmail.com>
Content-Language: en-US
From: Max Gurtovoy <mgurtovoy@nvidia.com>
In-Reply-To: <20250217183048.9394-1-imvalient@protonmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0424.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:d1::17) To CY5PR12MB6369.namprd12.prod.outlook.com
 (2603:10b6:930:21::10)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR12MB6369:EE_|DS0PR12MB6534:EE_
X-MS-Office365-Filtering-Correlation-Id: 21b7ac87-3d2c-446d-3fe2-08dd4fa355e8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WkFBcEFQMHA1QTBBaTFGTVVOTGJmdUhuYlRDNXpxQUd6eTRkZjFkcUQwWW83?=
 =?utf-8?B?RCtvOGJhT1g1T21BUm1ZTGpzVlduR1hjcm10RVVkaXd3Y1p2OEVJb2lJRUds?=
 =?utf-8?B?ODRnczJCZWhRd0hOSmdsbHhlVm5ZeHRDN0FIV2VaYzhyZkZrazFDMndocmtq?=
 =?utf-8?B?ckFBMGZZdnpSZzdWU2VtZDd3dTV5SWhaSEFxOGVOTzY2K3NnN2N0UXpDZjlh?=
 =?utf-8?B?dTA2azZVMEh5a3dhdHlKSXh2UDQweW1VVm9KM3FnN20vdHRrL0FBZGtYMDd0?=
 =?utf-8?B?RGlUU0NyREY4akNDRXluY1EvcHI3SnYyYk1vbk0yWVdtRjB6U215UjhPTlRX?=
 =?utf-8?B?SFVkZEJwUFZuTVdxSEpyRDd0UTNtbTk3cXRsR2hoYnVUdHUrOUdabVJkTVRL?=
 =?utf-8?B?MVF2bElTR3V2bVRVOStOQ05Xek13ZC9RTzExNzFIYzJYZ1Z0SWkyQys1eGRo?=
 =?utf-8?B?S1NxRWhxR1BpNlpLZ0ZKaFFTeUF5SGFvSStVUFV1cFczN0JIRjBkTm45dEVJ?=
 =?utf-8?B?Qm5Mc2hTOWtnTjV1TDJoTU42cnNSS2RkbTNYYVdhNlpLR3NiNDJFKzEwdnJE?=
 =?utf-8?B?Z3N0MENzUWZkY0hLWEo4U3R5aEZSRmp4NDN1dGdDNnptb0IxNlNiNG1pY05O?=
 =?utf-8?B?OVZpeEVMSlBTQ0E4YmJiRkxyaEhna21WbDVTSUpPbm5VeCtRRDRWYlg1TllD?=
 =?utf-8?B?N1ZSanU1Ym1KOU5SVlFXNDl5K1NTR1d4b0VmVHU5a3hZbXRsOEVra3lVbi81?=
 =?utf-8?B?OFlPVGFhc3RwWFpFcTBqMjQ2eDdkRzVlVDZEaGZmdmFPUFROYmt3WGxhS0Ex?=
 =?utf-8?B?NmQyWS92V2ZLWnhsaHVRNkgzRHd6UzhXZkhCMXpqTUpHUE4zYVdjcEtYTm5Q?=
 =?utf-8?B?bnUzV1BmQnBjSTQ0VjNNWkF0eWs0bkNtMlFLUmVITFRkM05mZE1oYnBSRmkw?=
 =?utf-8?B?VHdXWGxkSmh2OTBXRVowclRrUWZLTWRHMUtMRVVKMU5oOS9nUUFqejVUSUNW?=
 =?utf-8?B?WmZlSjBwUktnWU4xUmk1bFFSZmVjQ2NicjViTkUvaUJHQjdvV28rblA2VjJO?=
 =?utf-8?B?NWF3RFVOWTNvWCtjVmVqOTN4cTRkTHllVkhBOEdmMlZkakZiSTI1NkFUVEdj?=
 =?utf-8?B?a2RSb1BnY25aMmZkeGVKVEVVVEhYU2FuWG9DU0x5djZHWk91TnovMkN2Z1VQ?=
 =?utf-8?B?T0wzZ3B0bW9SUkpHVUV3OHdoN2orSDhmZm1kMDJFT2d2bkU5bHNTcVpyU3kv?=
 =?utf-8?B?USt5ZUZlMTVTS2VaNnJ0Mm1oZlVPWWhSemVoeTVIOFN4R1NCL1pjbWYvc09j?=
 =?utf-8?B?Y2kwNnRZOUNmbFU4SHc5Nks5YjAvK3Rhbm5sYVc4VUw5MGVpSFpHeVpXN0I1?=
 =?utf-8?B?SjlCY1R3citwVXhrSHJ5R1g3S0c5SDlCTEcvQ0JBVFF0U0FzbXNBU0wvNVly?=
 =?utf-8?B?Rkw1cUJXais0Rjg1ODlnaUVYdldsaEp5a1hTTUlPS3Z1eVNMQVMvMDVzM054?=
 =?utf-8?B?VmpES2RZMjQxL3NzNzlWUEFzY1FmdzNXeEx3bnA5VHExdlhrTmVkbVZOaTZR?=
 =?utf-8?B?MVBTRmtPaFNSd2x1ZnEyOGVTcTZaZ2FDcmpaY1hiSFB6dC9tZlRvTnhWZUxt?=
 =?utf-8?B?VEYwY1U3V3lCMnJrQ0hhZDR0bEZOR3c2MHBzZEhobmkvRHJ6ajFJbHY3NldU?=
 =?utf-8?B?VVV5OFFFc01OaGQrVjZrLzI1WVFwZkMyTWMrZVNDb2wxS3I5OGU5ZGJtSWth?=
 =?utf-8?B?VW1PK0xMd0E2dzEwTUx2WStCdXJISHB4MFlFZzZKSERVNE9DYTNSalNuZzNU?=
 =?utf-8?B?WnVsUVJ0ZU05dU80bDlERWRkZFFRN0R5MytoY2tiSkd1N3RObk5Pc3dxeDRp?=
 =?utf-8?Q?XWqE2I6g5waZO?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR12MB6369.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YjNDWkFGbTFUQ1UzeGhiTndzT2xqTGdoWS9KM08zOFhNeUV4eU5mbnNIYnlE?=
 =?utf-8?B?K0NLTFpuNkNvSUN0bnZYZTFpUTgvb2hwT052RUwxbEJTVS9tS3ErbjVVdXRG?=
 =?utf-8?B?aklLeFlYZVV0RG1CQlJKa0xKRHpaRE01aldDbTV6SWUxaFNWN1crT2ZTL0VT?=
 =?utf-8?B?MXp2WGVsOTkvYW1waVhWd3BnUVBDRXRhYzZ3SWZTZW13OTRsVmY3Q0txNzBF?=
 =?utf-8?B?SU0yUjRqVmhCc21RVlZCMXRiQmNnZ0dFNTl2eFVrMEVGcGF3SGVNZkh1eVht?=
 =?utf-8?B?cTltMmNwYmFicFhrZlJnZy9yZm1lL2FwakkwSUhBalpuamZYVWNXcFJoZGJP?=
 =?utf-8?B?dFoxTE15TGwxb0NjKys4cVRSL1Rpcjd4aGxJRVN2TlQ0K2RIUU50dUtXaVpm?=
 =?utf-8?B?UUxwZE5QWlhRMS9wMGVSTVhEOG00VTZsais5c0dWMXVzOEs1MHBaNitwMUZJ?=
 =?utf-8?B?cGE4TXEyZk5rVThBZk8wYTRud1JnM0JPa2dvUGVsZDdYNm9XYWtYT3I2ZWFL?=
 =?utf-8?B?SWx5SlB2elVjbXZ4cUZKdG02WmxrRGlKWndUR3Evci9BUHdMT1lQMFJSMGVj?=
 =?utf-8?B?WFBBaEFlRC9Ic0JRd0lRZStSTHBrM0pxdC9pQzA5bUNGMTl3eUg4UjhqVlhK?=
 =?utf-8?B?SG53U3JxekFkQlNCVXkrVWVwdjI3VDEyOEhVYzFobklDWnp3cmpqOE13MG55?=
 =?utf-8?B?bFhhZDRGblBIaUd6T3ExMHhkZFNQUlBIMmFpeWVMWkhXVWc1R3NtaWNGaThz?=
 =?utf-8?B?TElSVkdzWXcrcjJHWSt6UGR3YUNjbVU1WXV0TnZqRVo2WDFNanZwRkM5Q0Jq?=
 =?utf-8?B?blFwZWxtTmFZdkZuZHNaL29MU0NPZnZic1hVL3d2VzZvOGJCQURaajlFR2JG?=
 =?utf-8?B?MnFPRzZzMmI0cE9CbEFQWmM0Umo5TVhJM094bkxEcGhuY3NuakJ4MG8vMmFH?=
 =?utf-8?B?bnNZQ01tTkpUWmVHU2VLb2NtM0lIeGJGNm82bCt3RmVqS1BMVlFkOUlHaWZT?=
 =?utf-8?B?NTlZWmxQRUhVT1BtSG5aS01DWVV3ZmNwUTVEWURSc0YxSVlHbGhlZ3UzR2py?=
 =?utf-8?B?eGhuRXZ1WnlxRnRzZjZ3UkdxNXhvdVRHRFFWeWp2V2VmaEpCV2RlNDQzOURr?=
 =?utf-8?B?U21qL1B3eGk1b2hTanNWMDJMUy9KSUY5eWEvTHhicyt0Z1RmVTRkMnNmT2U5?=
 =?utf-8?B?bzdMSWxRTy9ObjR3QnMwSlZzNWJDTU5hUkVsTjRJbDdyMEs0R0JSRktNTzFz?=
 =?utf-8?B?cXl2YnczWlJUcFROMzc4QVlwek93dkwvMDNnMFc1dkEybVc4UWVkTW9pTmpE?=
 =?utf-8?B?eHMzMytUcWJSKytpRC8vOUJtb09Nb1lBVThNZGVLZFJPNDZQNi9icWk1RFoz?=
 =?utf-8?B?czY0YUttRHZNR2xmRG1hTC9DU3I2WVg3d1k2VFBPbmsxRHB1cmJGQmp4Z0px?=
 =?utf-8?B?OURaUXh1R0pocGFYWEdmbGkxNVFzUzNERk1ZQlFBVGJudkVNdENvRHVFUytq?=
 =?utf-8?B?azNLZVdXOUc3L1c3eDFFL0RZSlJ1YnpWNjMydFRxUGdRaGo2Q2M3a25MMk9H?=
 =?utf-8?B?WHhqWFZkM1lZTXNBWE05NVR3aDZEclpvdXk1MlhWTFVuWms0M0tGbU00eUJB?=
 =?utf-8?B?Nk5vL0JwZnBNNFpBYVlCKzdJL016U0tLMlNOTXFYeFY0bkJHWlF6VzJjUDVm?=
 =?utf-8?B?NWpZRGRhQVRHaFd0NFhaemZOOEZFc1FVLzluQU9VMGhWRXBnbEsrcmlndzQv?=
 =?utf-8?B?SVRaSUFRTE9uSTdmcVN0aS8vcno0MW9ncFFIcU5mdnZBOTZtWVh4a0wyTnM2?=
 =?utf-8?B?RmtGeHR5aDBVcU90WGFBZnBITHZhYmVPUUpBUmVmZEZ3Z1BMcmVydXBtd0Q0?=
 =?utf-8?B?OHpDcGp1N3JRTEVSaEdJZy9qZ1dyc0NIczZYNUgvb0RjTXQwbnpPKzhoYW5H?=
 =?utf-8?B?VEJWcVNLamV1VlNSRDRNNlVibmtHd3A4UE96VjJpVVFjcnh1Z2NLcXAwODIz?=
 =?utf-8?B?YnpneFpnT04za0pOYkNKWG1WcTJFSmVSZWovMTFicTJxTE1zUHYrY2VrMUVH?=
 =?utf-8?B?emE4UDEvck1BUmhLRC9tSFlNbkI1UllhanlKWC95a1VaZFlHalBDendZcVYz?=
 =?utf-8?B?OHU0MTJHck0xbHJJZnNhYlMxbXhnVFFodXBnMEIxTGs0UFU3RjM4V1F6R2xM?=
 =?utf-8?B?eFE9PQ==?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 21b7ac87-3d2c-446d-3fe2-08dd4fa355e8
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6369.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Feb 2025 22:35:09.9863
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: P/44e3hPlj/loqDd11TBd7L86CVLTw/exLUCSuCJ68jNl7uC3B0NsHrSpQ+2S/p3mLW5cbbvhBidSFLw5gpbGQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6534


On 17/02/2025 20:30, Imanol wrote:
> Fixes multiple occurrences of the misspelled word "occured" in the comments
> of `iscsi_iser.c`, replacing them with the correct spelling "occurred".
>
> This improves readability without affecting functionality.
>
> Signed-off-by: Imanol <imvalient@protonmail.com>
> ---
>   drivers/infiniband/ulp/iser/iscsi_iser.c | 8 ++++----
>   1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/infiniband/ulp/iser/iscsi_iser.c b/drivers/infiniband/ulp/iser/iscsi_iser.c
> index bb9aaff92ca3..a5be6f1ba12b 100644
> --- a/drivers/infiniband/ulp/iser/iscsi_iser.c
> +++ b/drivers/infiniband/ulp/iser/iscsi_iser.c
> @@ -393,10 +393,10 @@ static void iscsi_iser_cleanup_task(struct iscsi_task *task)
>    * @task:     iscsi task
>    * @sector:   error sector if exsists (output)
>    *
> - * Return: zero if no data-integrity errors have occured
> - *         0x1: data-integrity error occured in the guard-block
> - *         0x2: data-integrity error occured in the reference tag
> - *         0x3: data-integrity error occured in the application tag
> + * Return: zero if no data-integrity errors have occurred
> + *         0x1: data-integrity error occurred in the guard-block
> + *         0x2: data-integrity error occurred in the reference tag
> + *         0x3: data-integrity error occurred in the application tag
>    *
>    *         In addition the error sector is marked.
>    */

looks good,

Acked-by: Max Gurtovoy <mgurtovoy@nvidia.com>



