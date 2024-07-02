Return-Path: <linux-rdma+bounces-3618-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D2EDF9246F5
	for <lists+linux-rdma@lfdr.de>; Tue,  2 Jul 2024 20:05:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 35ECFB2530C
	for <lists+linux-rdma@lfdr.de>; Tue,  2 Jul 2024 18:05:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5ADAE1C230C;
	Tue,  2 Jul 2024 18:04:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cornelisnetworks.com header.i=@cornelisnetworks.com header.b="T8Rbx1jm"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2125.outbound.protection.outlook.com [40.107.223.125])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 512F41B4C4B
	for <linux-rdma@vger.kernel.org>; Tue,  2 Jul 2024 18:04:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.125
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719943479; cv=fail; b=I3h/Iok7bN4kjhsmpybck1kl6JB/Phzm5N+L+c06wIPTYSQnZfN6HyuO93nfrhdRt6Z+vxgdeiwmPfHQMHSzu57sojv6whUDNo485CBGmtNE/rxBpCLigokYCpnkCjh0xw0I2SSZ8NjSYnx9hlo9Tnjrfd2yaSfw2Lgo6j6Lr/E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719943479; c=relaxed/simple;
	bh=CDhfyaMdO9W4Z7FuEYWqK8f+UAHSOf89ISwg1spfheg=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Vh0n6G9CMs+4sCjufurUK5HKgzQ8YjsoSgfJb13LPnNkEMPuYDZ3X2//5bOOzk9I7qQEAmRecYYiP9IaH/yrKDlM2kVX92yP/Q4pBFDkFHo8aTZgXuPrDZpSHf/TdkwjTbTN2GnXOrmEnAY9AKTWbjC+gMlD2qrDi5kjxMiLPbM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cornelisnetworks.com; spf=pass smtp.mailfrom=cornelisnetworks.com; dkim=pass (2048-bit key) header.d=cornelisnetworks.com header.i=@cornelisnetworks.com header.b=T8Rbx1jm; arc=fail smtp.client-ip=40.107.223.125
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cornelisnetworks.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cornelisnetworks.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iVz55bzPATMcda/6+gq7ADOKiCk9w8O9pdkugGsy9AorWjTrCiWrIKLrQTUV20/TNDsdgUSk6KjkRnMVmiKcqdeF/F7P6LRoViykMubvUqqtIc2Rz4qFxQPhN8yE3T6x9/JP3JJutG4prx3/KMnSXDKGDJ/SS8DLiBIBH7y+T4U+BGCH2QbkzeWSZHuV3YA5j3YO1flWcZLCHD66Uy8UiOBCof2G7SK0T/2jI2mRvAs4HLTwZQsMV2z6U5TWLt+735LN22lvd2IKswEJ1Z4GriEsjz7jeVRDf52tbD9W5mLhY9+tNEcj0gWF/zx1+BFUu++J9d8TCaIWeahFidWCFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JAeBD6erhmD7/TQfYWFYTB8qRmIU2cCOP4LAs8eTFu4=;
 b=bJ9TA5ds5iyyOBq2hRKeBVZqOz/QzvKW7uOamHLTIWUFbokXfUSFGXsJC5oKOAirUYdfLnyqLl1QLY0TTmgH2auS8aE+W3NqW3h4EeA1dI6G9kJv4BJL/gyUkBag5SILZ3MTaLXool0KxvzP9WhZrWiWN5XK0xH2/C8hxVU8lnI6p+kXWwu9HyKuxeIJl6xDw3Jt4W7VIt/Q5kWJuASwI0/3h8AbvmX8uYHFgswe5P1XOVsPY7UUtwJXVtZsFDQxCPFKiZpB7NPQ4wvlTHTBTpqBUte7g976lMynzaco8w1zlaoasAGFxTK89+Ttj8CYeAgga4f3RcPengaoT6gJPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cornelisnetworks.com; dmarc=pass action=none
 header.from=cornelisnetworks.com; dkim=pass header.d=cornelisnetworks.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cornelisnetworks.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JAeBD6erhmD7/TQfYWFYTB8qRmIU2cCOP4LAs8eTFu4=;
 b=T8Rbx1jmPiRHKkVeTnH1Vc8l2vNJiVsgvMPiH1I4tJETBwMxcaooBPcxXHXCtx3b1vZWKM2Yi1ibHKrp3rqjdYQYL62DzROAQ+urecfMzFCPweJqREGSgLH0tnnshQELkrlLRN7NkrjlEiaThCUKycbT46g/7dkL+pjpKC5ieiW4VeK7sEPZtBJn0RkToiS79eX8eD/P8VeL3eNvBzttEMTAWNWdZoUOwY4LX9sqo8K9q9DaaVn7F8MiA2MzlFEOBth+fFBXHjHPOR6878X3OZWQtZ4wzlS566Dby+DP5pcgN638XjC2K0D639wX1kJI4FqRIg59CXi2tCY4UdTFqw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cornelisnetworks.com;
Received: from SJ0PR01MB6158.prod.exchangelabs.com (2603:10b6:a03:2a0::15) by
 SA1PR01MB6525.prod.exchangelabs.com (2603:10b6:806:186::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7719.29; Tue, 2 Jul 2024 18:04:35 +0000
Received: from SJ0PR01MB6158.prod.exchangelabs.com
 ([fe80::d4a8:cb9c:7a0:eb5b]) by SJ0PR01MB6158.prod.exchangelabs.com
 ([fe80::d4a8:cb9c:7a0:eb5b%6]) with mapi id 15.20.7719.029; Tue, 2 Jul 2024
 18:04:35 +0000
Message-ID: <bcda578a-518d-4e41-a59c-ebd5cf972c6d@cornelisnetworks.com>
Date: Tue, 2 Jul 2024 14:04:31 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH rdma-next 1/2] RDMA/qib: Fix truncation compilation
 warnings in qib_init.c
To: Leon Romanovsky <leon@kernel.org>, Jason Gunthorpe <jgg@nvidia.com>
Cc: Leon Romanovsky <leonro@nvidia.com>, linux-rdma@vger.kernel.org
References: <ab5222c414a01e9d2c5129ef26836aace9ee2aa5.1719837715.git.leon@kernel.org>
Content-Language: en-US
From: Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
In-Reply-To: <ab5222c414a01e9d2c5129ef26836aace9ee2aa5.1719837715.git.leon@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MN2PR15CA0025.namprd15.prod.outlook.com
 (2603:10b6:208:1b4::38) To SJ0PR01MB6158.prod.exchangelabs.com
 (2603:10b6:a03:2a0::15)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR01MB6158:EE_|SA1PR01MB6525:EE_
X-MS-Office365-Filtering-Correlation-Id: e3bc6456-2a26-40f9-5c1f-08dc9ac16e62
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?amxyOXVKMUs3WWRKTTdURFNSZjN2djRrNDg0c0k4YTJ0dXZqVkVpVm94cjRD?=
 =?utf-8?B?b3lnRFNZYVVzNERJODFsWE1ZOW1pdFhaeFN5MG9YY0JLU1V6UW0vM1Y4cWIr?=
 =?utf-8?B?d24vZXZ0bk1uUzB0Q3BjTC9tODc5VnI0T3k2amdHOUkrRXc5UXJVYStiYkE5?=
 =?utf-8?B?Y1A4UW13Z2RmdnZPV2JWazFYYk90MFA2V2lkbGMwRlhVM2ZscmdBU2VTODFq?=
 =?utf-8?B?aHRwWWd2UWRJMnFUUC9JZWo2Z3hYOWdKNjllL05wVzJxRHNZK2hHZkRIUVF2?=
 =?utf-8?B?NUp2cDFHWUJ4S2ZldzB6K21mUVJsZGRRc0dvTEJCQWtib0hENmdvMVFqTyth?=
 =?utf-8?B?aThWQlpGeUxiN05HRGs3UkJRU2d4ejkvbnBYaEN6eVRHN1piZTV1aXNYSnVn?=
 =?utf-8?B?U3ZaZENpVStPMXBTcWdMUjM3bnE5OEFablRqY1ZZeDJnbklXYnZPSWZZbHBw?=
 =?utf-8?B?Z0VxL1ZodmtTMTJkOTNBeDJZbTdTOXVjL1FNS2VCVUVDTVVTVmFSNVlEYUZv?=
 =?utf-8?B?WDgvY2U4UjgzeXlpM0FHQXd6ZGxvajBEUjBJdTNRdjJES0xEMTBUek4ySDI4?=
 =?utf-8?B?blBSYlZyNEYxSitZZ1BlOHcrVncvVXg5K3RLVTc2STRCL1VJamM4bVFRK0Mv?=
 =?utf-8?B?ME1waXFqT2dCUmw2ZVpkNVI2ZHNwT1pFVXoreUdRQkJFcnM5SWl3eC8rdzJ4?=
 =?utf-8?B?S0VPQUwwNVZuOTdpV1FlWXRMZGRWVWsrSGg1SUNiUTFFN3hZeWlhVmhQS0pL?=
 =?utf-8?B?NjY1ZnBFNzFhR2NhZlVIRVhaaVEvazROTU1ZdDFqczBlUlZzN1MwbmlPT2xk?=
 =?utf-8?B?UTh0UlljaXkwdi9RalFkaUVFb3pKNWVTUllWckM3ekxTUVZwZXROQW1Rd3lY?=
 =?utf-8?B?Y2VqNGVpVEVETzN6cWNFZGR5UW4zYm1pbG42SzBWVHYzUDBpb3B1Q1IvM1Vm?=
 =?utf-8?B?UHBXUFpNQU5nVElkUXV6K01rMlorK1dKN2RCZUVHRWNRdk45WjRhMGtlZTVZ?=
 =?utf-8?B?RHR1OEcwR3dZYXN5dGwwZVhhQ1p4L1ZrbFNvMTJGV2VCUTdkZ21PZWp0NDlY?=
 =?utf-8?B?cWpIM05GRUhRUnNLR09taUdERmxtYVF0d3pOYzQ4RFU4T0ViMTdDRllWSytI?=
 =?utf-8?B?QnpxZC8zRkllQW9EUjJhcThkWmJlQ3RmQTVURFJqZ2lJSWxzNzR0YUczRk56?=
 =?utf-8?B?d1MwL3IxeExhNDNieDB1SWV4djRIbXpIMU9YYzRZMUZGQUFWeVNYS3ptNFQ1?=
 =?utf-8?B?R25zSVQ2SGxBRVpNT3M3ejZMSnhYUkNzb3pKZUt3WFBrWnk1VjRCckZ3ZVA3?=
 =?utf-8?B?ZWJQeDNNeXZWOFM2YWVUSUlaYzRka0FBY09qU3JJSEpIZlBVZC9HdGc5QmhU?=
 =?utf-8?B?YjNPazE1T3JpejVBNGRTN1VxWkJCWWtVc3FzRE1mMW5TenhTT2ZJSzF5dzdB?=
 =?utf-8?B?U0hUMDNzRSsyeVdjNjd0b1JnazFzWHJyS1VVYXZFcFprNWIrWXlTeUdPcm5M?=
 =?utf-8?B?OUlWeEZ2OCtTMEY2ZlBpb3dtd2VDZWZBdzdVak41SGxUV2JxalIvOCtET3VB?=
 =?utf-8?B?Sm1CQjlKNUtIM291MThYYVd5Z0d4UVFUUXJvTWpOS0tDblFnN25aaEFwVEF1?=
 =?utf-8?B?VzFiQVR3ZTNKby82NmtKUnB2ekE2RWQ0Nm1FNEJLY1pDRUN6VGQrVDdmM2Jy?=
 =?utf-8?B?SVR2NGRtVVNJL2Z6LzU2akdabmk5Q09mOHg4T3FtS1U4Vk05dWJUbGxIVVBu?=
 =?utf-8?B?QVd6dHQ0dmZwWGxKc2FjNUFKZld4RC9wcm9sdFhiMEo0cDdsY3FaUkhTSk5L?=
 =?utf-8?B?aG04Z0U3Y29vUWlwS3Jydz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR01MB6158.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aml3dTZHbmk4TS9TZXlqRGxoTmlzcXp5c3hlU09vQ2NwOG5SNTRSeFYrUml2?=
 =?utf-8?B?S05mMnVRbjBTOC9EeUlyNldBc0NYVFFmZzZvZVY0TmRoY0puWkFuV0tTWTlF?=
 =?utf-8?B?ckhiZmhUNDErR0JFeWtockZJWTh1aUNCRmcrWGtYWmxWTEtoSkZTWUlIa1BC?=
 =?utf-8?B?alUrWUtWTGt0MDRIQXVrSWM1OVorQWlXK1cyQ252cE1kMDZUR2E2aUI3akF6?=
 =?utf-8?B?OC9vajhHVDU4S1YwNHpKbHptUTE1TWJCcGJ2VUxYM0srRFFhZTBmenlSL0F4?=
 =?utf-8?B?bFNJbi9QdGtoSDIrSmt4NEkrMkdZeVJpREI3U0NQNHdEOXpTdS9GMmF1dGkr?=
 =?utf-8?B?UzFoRHArUitDWWVmL1lJb3FZdkVzRXBqRHMreVlVZlc0dkRtbktsdGMvc2Fj?=
 =?utf-8?B?WGlrY3hGd2xvVk51MDREdkNSUGl1OGRNa2xRN2N6alBhRU5oUVdTVFJUM3NV?=
 =?utf-8?B?a0tpUzNIQ2dRVzhYbTFwaC9BR3NnMWRKM01STmVXMHhSN3pHejYwNFJzZ3Ix?=
 =?utf-8?B?amM3MzZQZmgyWXVGdEVCOW92dXQ5cy8zdWtGVXEwRzlaaU9qdWJNQ2RmMVo3?=
 =?utf-8?B?STFIeHlBbW90dU9iNTEwM2tpTWRraWJweTVHVlR0U2c2OFdob0tuMHlTKzc5?=
 =?utf-8?B?Z2Zqcm9zLzhBNTlFZ1dLRksxOWxhS2ovOUlSR29STXVEOWZBTEZjSHd4QTla?=
 =?utf-8?B?Nkg3dUxLdEhlL2h3VE1vS01ITktUSndPalBRZGZwUmpRNkIyOVpaQlZTMGJL?=
 =?utf-8?B?UmJEeGt4RHFUeGVIL2I4Rnp6M1ZXNStJRGtVTDl4OFhVMGVJVnV1TndrOFFX?=
 =?utf-8?B?cm9NNlZVSkhJUmVvbWhHaW91eWs3T012SXRaeFg4R3ptWmNmQlliRFlaUkdp?=
 =?utf-8?B?L0gzVENZeDBubVllVUhYTzFxNzR0RklYTkZOelpDdWw2UUt2MDZ1ZHZoL2pK?=
 =?utf-8?B?OFZiVkdUK1ZaMml6VE9KcU45T0lHQ3Fkc01hd2JhMEJLeW1rWHpHWFlqVUZF?=
 =?utf-8?B?b2M5OUVGMHlZNy83TCtiRU1QSGlaVG9tTGFWWS8wOUNMRmQzbmQ1UFd6ZlRI?=
 =?utf-8?B?alNKS3IzaUlGQTd4M2xkNDc2UytmTjJFMjBYc0lPWkQ4ZmV5MHlUTmw1dDI4?=
 =?utf-8?B?dWUzRlpvcUxQWTYxUVA3cVlxTmhVUkdCb2tnY1FGa1NTNHptRmlMYndYYm55?=
 =?utf-8?B?SWhpem9hNFJFQUVJUmNBZzMyNHRYNUc0bjZlYTdXL29ONERRL0NkVnRWekg0?=
 =?utf-8?B?S3YvWEdyeXZtclI4QUxERWNnUDRwdzZZMFB3dnMzSjZuUDZoNDlwN1lDSGdN?=
 =?utf-8?B?anc4L1h5c05yUis1aVpaRDg1bTZONXRJYXI4RnJJYk10Z1RQR0FhaG8wVGxz?=
 =?utf-8?B?Y1UvRXZmSWVxMUw4ZEtSNkduVE9QeVFCaHNrNER5Ky9SaXdaSzIzV3pKZUJ1?=
 =?utf-8?B?RTVmd3l4VFk1bzE3V0MyaDNiLzk4UE9YRHJLRkhkZDRFUFBkZWw1OEdZNFY1?=
 =?utf-8?B?Vkc3UW1heWRwMGVMSlBGbG5QbjNETE9NSXNma3d0ZVpDWjd0K3JNNVppQWpp?=
 =?utf-8?B?RVdDYmhEdE5zeEJRaW53RCtBRmF1SWhRUkh6T1VtRCtFMkxXQWFURGw3Njht?=
 =?utf-8?B?Z2NVTFIrU2hGaWVSYUtoQzk3L3prMVRvM0JaenVGRC95SW5KVE9FR0w2M2Jj?=
 =?utf-8?B?ZUtUZHhBYUE2WXk5a3IrOU9VRGNQNnQwM0hMR1hkUFZ5cDR2M09uV1BjNDlB?=
 =?utf-8?B?cDFkVEx6TjB4TUJ4N1p0cUJSWnUrWWVQY3dCS2Fxd3JWaVd5d1NDVVNYQlUr?=
 =?utf-8?B?Nk0yRFJyOXFqOTFTMkNKb0phT1dvbnNYZ3RsOHc1bXo5V1g4UENpSVBkYmZl?=
 =?utf-8?B?bmpWSUZhdHlvQ2dFUGRLQzNoWlVRZVNxbzBISU1KOVZmRU82WlVyN3lmUEsr?=
 =?utf-8?B?a0tOYnptTWNvYSs5Q21NMHZ5U3ZybUJEMFE3b0hGRUJuVkVFcHkrY0xMNmVq?=
 =?utf-8?B?Sjc2UU1xd0NlVnMxQ1dSeFhLcTNJazFKYkw3bFRLSmFCWGpWMWhqU3ZKMmNy?=
 =?utf-8?B?S0E0cTVvN1hKOGdrdlpwL2FzVU9JbFNFanpQNTZ1bEJUWHBFc1NEVzF1cCtt?=
 =?utf-8?B?SGx1RFNzdEhVQnZiNEJIbU9jV1VOSk9ISzltVWF4L0loNERIR1psMmNzMFBI?=
 =?utf-8?Q?M2C1+suCmt1uTqdrwI2TNco=3D?=
X-OriginatorOrg: cornelisnetworks.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e3bc6456-2a26-40f9-5c1f-08dc9ac16e62
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR01MB6158.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2024 18:04:35.3092
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4dbdb7da-74ee-4b45-8747-ef5ce5ebe68a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5w1DA6tizd/KLc4T1dWHzhKKRX/hG4IYAHc+U3R1lPjMgT6Hy+sg6VNNVhRrmg0Ok/Qmd7uVjpU+IyufYSrpNDbX3/olHcFMh0jNGcgtc2cJZSPiw+y08QcDCs9LAcKu
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR01MB6525

On 7/1/24 8:42 AM, Leon Romanovsky wrote:
> From: Leon Romanovsky <leonro@nvidia.com>
> 
> drivers/infiniband/hw/qib/qib_init.c: In function ‘qib_init_one’:
> drivers/infiniband/hw/qib/qib_init.c:586:67: error: ‘%d’ directive output may be truncated writing between 1 and 11 bytes into a region of size between 0 and 3 [-Werror=format-truncation=]
>   586 |                         snprintf(wq_name, sizeof(wq_name), "qib%d_%d",
>       |                                                                   ^~
> In function ‘qib_create_workqueues’,
>     inlined from ‘qib_init_one’ at drivers/infiniband/hw/qib/qib_init.c:1438:8:
> drivers/infiniband/hw/qib/qib_init.c:586:60: note: directive argument in the range [-2147483643, 254]
>   586 |                         snprintf(wq_name, sizeof(wq_name), "qib%d_%d",
>       |                                                            ^~~~~~~~~~
> drivers/infiniband/hw/qib/qib_init.c:586:25: note: ‘snprintf’ output between 7 and 27 bytes into a destination of size 8
>   586 |                         snprintf(wq_name, sizeof(wq_name), "qib%d_%d",
>       |                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>   587 |                                 dd->unit, pidx);
>       |                                 ~~~~~~~~~~~~~~~
> cc1: all warnings being treated as errors
> 
> Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
> ---
>  drivers/infiniband/hw/qib/qib_init.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/infiniband/hw/qib/qib_init.c b/drivers/infiniband/hw/qib/qib_init.c
> index 33667becd52b..db3b25c8433a 100644
> --- a/drivers/infiniband/hw/qib/qib_init.c
> +++ b/drivers/infiniband/hw/qib/qib_init.c
> @@ -581,7 +581,7 @@ static int qib_create_workqueues(struct qib_devdata *dd)
>  	for (pidx = 0; pidx < dd->num_pports; ++pidx) {
>  		ppd = dd->pport + pidx;
>  		if (!ppd->qib_wq) {
> -			char wq_name[8]; /* 3 + 2 + 1 + 1 + 1 */
> +			char wq_name[23];
>  
>  			snprintf(wq_name, sizeof(wq_name), "qib%d_%d",
>  				dd->unit, pidx);

Acked-by: Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>

