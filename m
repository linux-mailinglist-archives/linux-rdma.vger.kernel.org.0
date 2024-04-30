Return-Path: <linux-rdma+bounces-2167-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 52CF78B78DE
	for <lists+linux-rdma@lfdr.de>; Tue, 30 Apr 2024 16:18:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 729D11C22755
	for <lists+linux-rdma@lfdr.de>; Tue, 30 Apr 2024 14:18:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CAD4173336;
	Tue, 30 Apr 2024 14:04:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cornelisnetworks.com header.i=@cornelisnetworks.com header.b="Ge0A9qgc"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2133.outbound.protection.outlook.com [40.107.223.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E685770FC;
	Tue, 30 Apr 2024 14:04:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.133
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714485848; cv=fail; b=JxKX5lkKpbStsCq2RID29Ek1ov+z8lXipsX4QpU5X0ZeBD8UN3Y5g8hTTptd7WF8o1rBd6pJT5Cm/w/C3wVw6hiEFgsv0CXDDGO4RKNozPoKLwDz1uCYnUpCH3Tqt+XzsTau5lNQWHDhj7xwecgjx3pIMJAZr2WW65/ii0Zl+4Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714485848; c=relaxed/simple;
	bh=fIcWZlRxibWRzxLzTaC86G6c/ahynQJa8ZoTsIl33aA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=SfniFF9JtvCHFdkDSTKa28E301pjW2J5xrKYWrVQAptwEy1EFfXkFOW9HBztI61Fdo34WKRM5PbkorOp5mZvBxcg7wrgVyZrrpttaMkpY/JhpkZ46I9zS9Hmbmp2jw6bzyRYOqrvRJ8+dIJxtZ2Ou1efqrKIw9HVl5e4OFc+NAQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cornelisnetworks.com; spf=pass smtp.mailfrom=cornelisnetworks.com; dkim=pass (2048-bit key) header.d=cornelisnetworks.com header.i=@cornelisnetworks.com header.b=Ge0A9qgc; arc=fail smtp.client-ip=40.107.223.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cornelisnetworks.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cornelisnetworks.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ghyoRLgjirGTKp3h5mqRjNXE7JpLqakEOAe11rPCXlWOKC1dzryeFrQ/hPgbPH1y0pf9S/Qgn7q+RydtsKxrPuh1xK09Tk5sERVaS9pjWmtllbDfPbU4HZSSXRbHqqOS2alk+qAwJXydYWMYHbMwTbaLi2RbgsnPlyV+H5pDVNrVyLKSjFnvJVuA8jW3ZKcVlGfrv8Nt+i1V3U/9yMavgL8yhcvWFilQUCUKjVROddanqW7TlF0XoLOjPYrKjMgIKUOja7Mu/egOYyU0CkZ6iB1HX1W7jE17M+t/2xmcuy9qBuLk6K5s2pX9n02hQIaf/lbgFuW+ORCJOhRG0+uz/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V/qY1o98m2EjVAwwfR2cE4KdpPQF+9/337uH2kCqggc=;
 b=maS0G8rq3EGrZfvz23KzueKpniAYZmjzN4Z6tU2BdDvBtxolJ4ixylP0b50L8y6eip/RAWZnrjcc8Kl4flpNoaCff/B0Hv7mk8EXS7nEXMh8ROJzIFf0hr1tu3O8hVOsK/gBzpL0a+ZDBUPq4QmtIkvrTywkyF5DAnaxTZTW6L+22YBo+R4FVhQP/NEgK33eDvnTUEw1bOVcYuaFCu/cDgvgGy9Bf+FeN24SQ+5dmqNIPtEcqrliSSmQWlnhzqdnJ9LBrQ7hbIYy5OdmTfJrreQet035bIVTW+i/wjqbHiMrnHF4B99wPGNi29j3BdcGrt/8HjsPa1ujmS5fVIjf3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cornelisnetworks.com; dmarc=pass action=none
 header.from=cornelisnetworks.com; dkim=pass header.d=cornelisnetworks.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cornelisnetworks.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V/qY1o98m2EjVAwwfR2cE4KdpPQF+9/337uH2kCqggc=;
 b=Ge0A9qgcQaW5WQB1lMlAN/vUsYusZGJD43Hwqp2PDdUvQ3hESEBHAo3FNPBrB6m+CsRCVXLIRmDCJVBenqq0Y9uDUDf2HKyx2a/KLALlYVcthqXvV+QUgvVBv6Le2Giwmd1VayfU7YWlfFN2+fogBwea5ew/St2ouLLRAYlM74OPue360ALh+1LFOhCtk5ocss0HDjyS1YZGwBBsY4Zso6BG6ZwcuCJ07riby0PSpGDYzO0aMtYY3B0tw19Lxpv32o7b4q/paNbinE3qonEGBm2ZBkzwBz7MR48rHVukGitUYL1uiiuPKhK7u8p08EYlD8DmaRqeWFzaP37bCxcLmw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cornelisnetworks.com;
Received: from SJ0PR01MB6158.prod.exchangelabs.com (2603:10b6:a03:2a0::15) by
 LV2PR01MB7815.prod.exchangelabs.com (2603:10b6:408:14f::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7519.36; Tue, 30 Apr 2024 14:03:52 +0000
Received: from SJ0PR01MB6158.prod.exchangelabs.com
 ([fe80::4946:4176:3c9b:fe38]) by SJ0PR01MB6158.prod.exchangelabs.com
 ([fe80::4946:4176:3c9b:fe38%4]) with mapi id 15.20.7519.031; Tue, 30 Apr 2024
 14:03:52 +0000
Message-ID: <49973089-1e5e-48a2-9616-09cf8b8d5a7f@cornelisnetworks.com>
Date: Tue, 30 Apr 2024 10:03:49 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] IB/hfi1: allocate dummy net_device dynamically
To: Leon Romanovsky <leon@kernel.org>, Breno Leitao <leitao@debian.org>,
 kuba@kernel.org
Cc: Jason Gunthorpe <jgg@ziepe.ca>,
 "open list:HFI1 DRIVER" <linux-rdma@vger.kernel.org>,
 open list <linux-kernel@vger.kernel.org>,
 linux-netdev <netdev@vger.kernel.org>
References: <20240426085606.1801741-1-leitao@debian.org>
 <20240430125047.GE100414@unreal>
Content-Language: en-US
From: Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
In-Reply-To: <20240430125047.GE100414@unreal>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BL1P221CA0006.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:208:2c5::22) To SJ0PR01MB6158.prod.exchangelabs.com
 (2603:10b6:a03:2a0::15)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR01MB6158:EE_|LV2PR01MB7815:EE_
X-MS-Office365-Filtering-Correlation-Id: c8242273-d4b3-410a-d1c5-08dc691e5da0
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|366007|52116005|376005|1800799015|38350700005;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WXkyWHZ4TGxScVR4aU1ibnZOR0VDODd0TTlJSlFuOW9mT3h6VkxrSHlyM3kr?=
 =?utf-8?B?RnNnbWVGVkgvbjcvTmRFSXFMNGI5cmNBMWxwR1ptaUxYeUYrM3ZxV1hCMGhL?=
 =?utf-8?B?Y3QzaHY5ejNjNXY1eUhOWkxFSXhwcFNQcnhlb2IyQ3FyZzZkU3NJdG4rRG03?=
 =?utf-8?B?ZmpNUndEeTU1UnVncmRrRUhWQkVOVFdBWjVlV2pNODZvMjdpSXFXeE40WjFZ?=
 =?utf-8?B?cXJ6QVZKVFBEUzdzUm9QQTc2aEEyRUlCVnNLSlZBWkVDNks3VFdpL21iaXVN?=
 =?utf-8?B?QmJwTEJXeU5oSFJnSzJlZkNZYVNTclBUcC80cmdNYU5EQ2lBU1NpV045ZHFs?=
 =?utf-8?B?aURRRGQ3Qkd3NzN3UFdWZ2U3QS9TR29rTFIrVFgvZFZRY2xrUXlJME1DNSs3?=
 =?utf-8?B?OUJFTGFEbjdaTUtDT3BGVTE4dlpUTTJ2TFZmNDlGcHlhdG83VWR4WkxFWWZj?=
 =?utf-8?B?RVBwc0ttdGZKUEI2WVhkdFpmbzhLUzE5T3ZDMkxpeE5HRWp4SGl6SFFpZUNJ?=
 =?utf-8?B?TVJkYzZIemhvNnFHY0NJcWxhLzBQdDltOStERjEzM1FMUmNOUERVUjMxUmtL?=
 =?utf-8?B?bWVpcURpMXVyR2x3NWxmNFNvODd1TlhHQkFNdHAvN2lQOHEzTUVMUFlLcmhQ?=
 =?utf-8?B?aEQ5U3dCUGVsUjl4bGtvTFpvNHI5WEZ5Y2h1Y0J2RFM3aHdkVVJxRmpleUtU?=
 =?utf-8?B?bldhVzNaN0dwdDRkOWlWVGd0U2plVUxPdkNUTnhwZjQyRWVFaURNampxVjMr?=
 =?utf-8?B?NDJ6WXBheE92aUZpN0JCR0pKZUozREJtRUExN2pESFdqZGtMS0FRN1JHRHBY?=
 =?utf-8?B?RDcyK01wRWtRUFBZVTNqRXdRbjRyN3dVTUo1Zjl6RUgzSlpvdFJDSjByMnFC?=
 =?utf-8?B?Z0hlZ0VJdkpINTJkWVpzUjVlWE5xZ3RFTFBYT3BycFJyL2I5V1k1RXFqZU1N?=
 =?utf-8?B?QVl0MWhpb1Y3anJTRVJ2Ly92Sk8ybkJ3RHlWNVFZeC9aTXhLZzIyNkd2OEo0?=
 =?utf-8?B?SGFSU0xjdG5ZOExvOG1zbHZ0L0Y0RTRBbTNmQU5WcmlzRmlVVmM1RGR0RlFW?=
 =?utf-8?B?QTlxbjVSOGFsMTRYeE9YcmtxZTMrcGVjbi92cXY5anlGRWxFUDBqMW9EQmh2?=
 =?utf-8?B?K0xGaVQ3SlJoWVgwbVdxckZ6VVRpT3BLTzZ0cDFOVVAvV2lXRUVSQkVORnJt?=
 =?utf-8?B?dTlYdGNNZGZVb1FRV3NmQ1NtSkJBd05udE01L1JkRC9KcTlzRjBmL2ZXNUla?=
 =?utf-8?B?WFo4eTNwdmE4MVBlcXlrVjhFOXdsb2l0VDJsWGNuNmlERVhXR3lZYUhZM2pt?=
 =?utf-8?B?NWdPOVFuY0sxLzBzdU9jMUNTdFJhd1FaVENaZ0Z3RnNOVG9kcVVPeVBVR2J5?=
 =?utf-8?B?dERINmU4eGlIa2I4NmhHNkFXSm1kYUQvWk5TcGNzTDJBaG9QWlRHYUlrUk13?=
 =?utf-8?B?citwRGJwZ0VmL2FnYlkwUnNVN3pCZUNBcWN5ZGlUb3pkQVVrellnOS9acnIx?=
 =?utf-8?B?RURxYVFoQ2JtRlkyYVpwUDk0QTh1L0lXVjcvWkxOVURYRWlEbGhNL0p2WGFn?=
 =?utf-8?B?VU1paDFsb0JkOU1ZYWQvMWV1TEFZTzdsN3BJV2dPemdsdUlxNm5YSTFYdzRh?=
 =?utf-8?B?UUhBMWExS0hTb0RLZUNFRnA4UjlUQXMxazN1bERWT3U2aUc0bVpxeDFqM25m?=
 =?utf-8?B?SngvRzFNcjk3SWpCWGdFSE9EL1NyeGhEMzNPTnFzZ2JkT1YrcGtoQnJRPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR01MB6158.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(52116005)(376005)(1800799015)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RFFVbXkwN3BaNTRXck9Pem5PajNoYkhOWjcxM1BWWHJmU1Mvc3ZFV09naGdC?=
 =?utf-8?B?TzloejlLbldXYkJBVFZGZTRIZXhWaEdidzRzbGIxY1pCUmhHSkdiblFROWF5?=
 =?utf-8?B?UXFrTVBuT1BDQkt3SXFvSGMxRXBMWlRrTjdxZVNUZFlLZWFpQkJJa2NoNVZn?=
 =?utf-8?B?a0dEbjJ2QTZJYjhINE9VMzY0dGFZcDJIZjJ4bEl6VDJiQ0laN3BvR0NOT2Vk?=
 =?utf-8?B?Y0JQL1lrMFA4T05kZFRKalhESGl6aTQrK05zbXN0ZG1nS1RLazd1QzR0L1BR?=
 =?utf-8?B?M0ZXMjFFMEVsT2pBdkVJMWR1dVprMnlVVjFjNHpaeDFGS2t2Uk1TZ2NISU5z?=
 =?utf-8?B?Rmlzd3B6TG5SRnVSSHI2OUsxM3FsYkI1VGVuMGxUbjRnODZnbFhpRWJjZG1q?=
 =?utf-8?B?bXZwV0R0ZERmZFA2bW53OXNvMEc2clpRUE85TmU4UkRpTThrZE5KNnBSaGxZ?=
 =?utf-8?B?Njg0RTRkWUxEV0hhbVZyaW1nOXVoekFTT1ZOb2dITzJ1MUwzWjBsMWtTQlN2?=
 =?utf-8?B?Y3ZUVEl1cEp4SmxtbEk2MjIwcEllVzZ5cFhTK3ZteXROLzFlUloyeDBTd2Vo?=
 =?utf-8?B?cGVid21PcXhtTjZES2pLeTBmbVVGQ2Z3U1FUVjJRZ0NremJJUTBWandjd1FX?=
 =?utf-8?B?ZGx4R2dNSkhvUmZyNHVsUkoyaFJtdGIwVzdLZE9RVG9raWdlR1I0d0dIaTdk?=
 =?utf-8?B?dlFWUzlxejhLSkhNT2EwdXBkbzRJZ1YwZzdNTnh0Qms5Z05DOHozYy9rb1lP?=
 =?utf-8?B?MHAwTnJTYXkxcEhhZE9DZnZLMWlOZ3BBN2pnQ3Vlb1RVc0JQUXFTUjNLb2JU?=
 =?utf-8?B?MFVjTGZteTJ2dnBVR2RqVHc5d3VleVNmYjJzb21CSEh4M0tkTWdmWWt2anR2?=
 =?utf-8?B?c0VZSHUzSVIyZ1RYU0U1NnhHNjUvcXNPLzdNL3R6OTJZTzBiazFtQnlNUVFF?=
 =?utf-8?B?WnZ4UzVrU3hmc3QyVUJ1MC93NHUxVUo3SHUwcVVzam5sK0JXNFFiRTF4OXBp?=
 =?utf-8?B?K1I2Y3FkZEZiUkw2WE04ZnptNTFTMFUrU3JqVU1DbU0raERXRzNEVk45UWFN?=
 =?utf-8?B?NE55bEJCRWtNSGt2aytvNFl2SDdkc1JBTGhSTTRFSGNiK01pYlpjWFBraC8v?=
 =?utf-8?B?R2N6V1VteW9KMitEU0k3VVV5T3A2QVFNVmtjMGF1eXF3L3Z2ejh1UTZqb3l2?=
 =?utf-8?B?YVgzTVhwSVZpTmI5RGFNOXhsc041TTNDZ25zRVNNdHJiRG1qQU9YZEdrWHli?=
 =?utf-8?B?ajBEalhpYUxyUnNheXhwOHlmR2txZTNYSVMrbXVVZWhadlJGMEZlTGR4ZUxz?=
 =?utf-8?B?REhnb0dYc1ZLWStrSGlqMVZwYWNqQmN2WFZlNXlZN05zUVhycFBiNXdIdDBI?=
 =?utf-8?B?cnJhM0E5V0txSU9kY0RXbFVzZGJPM2Q4RVZhRnJjUEszbkdMc0FzZ1NYSDM2?=
 =?utf-8?B?cHU2ZzN6UmV3WjQ5UWtEc1ZYTUVUdW41dmFSeU90RFlxODJnNGlPamJ1cHRv?=
 =?utf-8?B?L3VuYklhOFNNOXVYK21DNnd6MnJ3Z3dqbHNFVHBNMGJ3SUsrdkp2bVYyMWt5?=
 =?utf-8?B?NXFBZG5lNnZVbkZsOE56dlFoL2E1SDdXMnpQaG96cnAxTHA2RU5GdUlrSUpw?=
 =?utf-8?B?a3hVYlFFdWlYM1BnY3p4ZFplMzZ1Wm1oZU5aVXVlYXpuR01tSjhSTWdWeGVN?=
 =?utf-8?B?UEdWbzA3VGduUWZhWkNaNnNJN2ZDalpsL2dITTZ2U3V3S0Z5TVQzZm03Wjd6?=
 =?utf-8?B?QWFUejE0aFNFNUVaMStuQlA2cnN0QnZXTHhhTFJxYkVmVitQeUhaMytrYVRa?=
 =?utf-8?B?SS94cFU4TzhMNTRnY1pMVFNXRSswZEVtL1RvbUhaN0l5OUNVbVp4a29zem5a?=
 =?utf-8?B?eXZoTUU3YmtpeDRZdFpieEpaeHltT2dFSHVTTUppUHFTNk1PQW43ZTRZKy9X?=
 =?utf-8?B?UG9UTkJmRlhBOGwrYUxxQTRrTnFLbmU4dHRlTkdkcG5ZN0FMUVZqVHhhbmho?=
 =?utf-8?B?TnI4R0RXYWQvOWdGRCsybXJRSWV4QWFSdExBTzBPWEFJenpZREtnN0ljZ3F3?=
 =?utf-8?B?bXFsaC9tVnplVjJLK0NjYWxXVmxQTkwvSHB6UXArbXRNd3NnOVJ6M3dUUWts?=
 =?utf-8?B?Q1Z0OXRZbWdhMlBxK3M3QzI1K2NjcHVkSnM3S2ZYOGYvK012NUNoL0FXdnZ6?=
 =?utf-8?Q?BjPGQ3/3lsJnTIkuad+c5Zc=3D?=
X-OriginatorOrg: cornelisnetworks.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c8242273-d4b3-410a-d1c5-08dc691e5da0
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR01MB6158.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2024 14:03:52.2273
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4dbdb7da-74ee-4b45-8747-ef5ce5ebe68a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6p0LdBC8oq2vmoqGsnanD8z2vwAmHfj0ZSuPheVp+eLVpfC22M8zeQ2/AVt46zUAzonDQnpu7QB81zrGM6PdIKAGDetb69t6TEBDTJJr8IMHV1SFMFhQzGkoL7dckM9r
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR01MB7815

On 4/30/24 8:50 AM, Leon Romanovsky wrote:
> On Fri, Apr 26, 2024 at 01:56:05AM -0700, Breno Leitao wrote:
>> Embedding net_device into structures prohibits the usage of flexible
>> arrays in the net_device structure. For more details, see the discussion
>> at [1].
>>
>> Un-embed the net_device from struct hfi1_netdev_rx by converting it
>> into a pointer. Then use the leverage alloc_netdev() to allocate the
>> net_device object at hfi1_alloc_rx().
>>
>> [1] https://lore.kernel.org/all/20240229225910.79e224cf@kernel.org/
>>
>> Acked-by: Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
>> Signed-off-by: Breno Leitao <leitao@debian.org>
>> ---
>> Changelog
>>
>> v5:
>> 	* Basically replaced the old alloc_netdev() by the new helper
>> 	  alloc_netdev_dummy().
>> v4:
>> 	* Fix the changelog format
>> v3:
>> 	* Re-worded the comment, by removing the first paragraph.
>> v2:
>> 	* Free struct hfi1_netdev_rx allocation if alloc_netdev() fails
>> 	* Pass zero as the private size for alloc_netdev().
>> 	* Remove wrong reference for iwl in the comments
>> ---
>>
>>  drivers/infiniband/hw/hfi1/netdev.h    | 2 +-
>>  drivers/infiniband/hw/hfi1/netdev_rx.c | 9 +++++++--
>>  2 files changed, 8 insertions(+), 3 deletions(-)
> 
> Dennis,
> 
> Do you plan to send anything to rdma-next which can potentially create
> conflicts with netdev in this cycle?
> 
> If not, it will be safe to apply this patch directly to net-next.
> 
> Thanks

Nothing right now. Should be safe to sent to net-next.

FYI, since I talked about it publicly at the OFA Workshop recently. We will be
starting the upstream of support for our new HW, soon.

-Denny

