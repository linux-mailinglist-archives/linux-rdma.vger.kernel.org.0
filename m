Return-Path: <linux-rdma+bounces-8207-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 31C03A49F2A
	for <lists+linux-rdma@lfdr.de>; Fri, 28 Feb 2025 17:43:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A3547164384
	for <lists+linux-rdma@lfdr.de>; Fri, 28 Feb 2025 16:43:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F24C274274;
	Fri, 28 Feb 2025 16:42:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="SV/NyrWz"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2040.outbound.protection.outlook.com [40.107.212.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F61127426B
	for <linux-rdma@vger.kernel.org>; Fri, 28 Feb 2025 16:42:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740760970; cv=fail; b=Dw9nH/lS4CV/VDe0lkBOwlQynfDe9uZP4R+fhfcqktIVZedDlW2i1Rsib4nt8bXCzZmeAffyqwMRXzKHgxUYb+0vx1/YDPCaMWmhUFgOQYC0hVHFdVGfSN7WTwAba02PAsK8pKJHuhd+yj8v8UQrRbVjWk96Y5/OoC87hcGZv7Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740760970; c=relaxed/simple;
	bh=oXS42QLNyxh0h0aH7dAPqMHbCJdaVUiHyRcuFKj8Lmk=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=YfN6Jyo0faKDc/yPNR6Ad1/bnJ+AwAoVY61055Jgd20UI75EbHpIAmkmPUC/6fisgEIz3ajBv+hgUypXjKK4f9FKloxd6u7QWJDnJRZTETMy5O5T5kv+Uf9RWTibhWZRLZxzvQngwsvzb2oue6KyGjc1EDiPCC9agyEFNrnZeIE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=SV/NyrWz; arc=fail smtp.client-ip=40.107.212.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lz3b52ec2/JxgZ2zl+j2i02Vrj7HDy5pu7KHSiL3tLjjoSw6tR7H6Pjj4Hru0vy8ZK3mS5vYNs0AcUQLKCuEfn5Hi5TChnyaivxLNJx6aLm52Qx3ZiGQfaJwaRmveBYFn+3KHDvbYZPE1JlMGANMNkQiEjfQk73eTcBBUPj/xFgTDSLgu5Bk+BMeY2EvRg1c5mlTtWE+euXuQ98NNldt03/cfc5pBPpI8W7iGpZbB+7kzPN0FxLt2JutLq4xVLC7YC0q/CNLgxhegFC8H6Y/cmAFbZ70L1B/mPSEK4BUBiaWJSx8fm1t8+w0fe3G8b4xcmzOab4yTdov5NuB++/uUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pvQl9CmwYmg1NFWJvaNc0q86NZoEy8ELsjrQDm6BbvU=;
 b=ci8fOwCUTbqkx/B6aIHUcIlhHnAmsw5G0OJgXylOYZ3CkmNL7XNyACitNIQm/6lvqUJjZGO2spBTSqsZa6ohOBla40u0PK4OuKuutPJHXOawBGI//c4lfhCWmahA1d4Nk0SQuyE7CES45Q81xfkmGAC8BpgSAfD24jimZYPFSi3/YRQyN7fMpo2SytfYPwDouA9xVcxBUcLDnbCzn7u10nVwbo+gOc/mw8sMZiXWbVRYq3tkJeL+m/ibINA5yksP0cwrFwcMWQ1i2PzdhWqzSEfssfPAMPoBxKObWjSvrBDyuB8WcKEL+WK/mDdCcw5/TspyCV27+bYXBMH4OtcoaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pvQl9CmwYmg1NFWJvaNc0q86NZoEy8ELsjrQDm6BbvU=;
 b=SV/NyrWzoM7MGCuiZGKeR9wxaZ89dC5uUabpjhGc5Uxh/odI982PF9JhzCUGnMi7pGVv4XF/BtFybGAqlmPkz3ho9QuL8+1g2AU1yaVJZgrc19htCF2cIVojQzeTGjLYlBbKLOunigKV7dUdcTkiDEsFShqsMrWLxy0r2qBV4xBPov3J7sVwGcZqiK9FI/5TqJayx6E6e6xqbLLrAVQ4ntjjx9jAul65LhQDo8chOiTv3Gvx/sB1silxkYF1iVcQZTDEAg6R7253n0ktUmiK2q+CYeVDIxt3Nh/Jty/RVrO5s9dT5YZFNMB8wS9+FXs03WdAfh2GCPWvU/1gqbRRVQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM3PR12MB9414.namprd12.prod.outlook.com (2603:10b6:0:47::21) by
 IA0PR12MB8253.namprd12.prod.outlook.com (2603:10b6:208:402::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8489.22; Fri, 28 Feb 2025 16:42:45 +0000
Received: from DM3PR12MB9414.namprd12.prod.outlook.com
 ([fe80::ee7a:8e5e:b401:5fa9]) by DM3PR12MB9414.namprd12.prod.outlook.com
 ([fe80::ee7a:8e5e:b401:5fa9%5]) with mapi id 15.20.8489.021; Fri, 28 Feb 2025
 16:42:45 +0000
Message-ID: <fc82feb9-3c96-4ead-9f35-59d228b1942b@nvidia.com>
Date: Fri, 28 Feb 2025 18:42:40 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH rdma-next v1] RDMA/uverbs: Propagate errors from
 rdma_lookup_get_uobject()
To: Jason Gunthorpe <jgg@nvidia.com>, Leon Romanovsky <leon@kernel.org>
Cc: linux-rdma@vger.kernel.org
References: <64f9d3711b183984e939962c2f83383904f97dfb.1740577869.git.leon@kernel.org>
 <20250227205743.GO39591@nvidia.com>
Content-Language: en-US
From: Maher Sanalla <msanalla@nvidia.com>
In-Reply-To: <20250227205743.GO39591@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0091.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:191::6) To DM3PR12MB9414.namprd12.prod.outlook.com
 (2603:10b6:0:47::21)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM3PR12MB9414:EE_|IA0PR12MB8253:EE_
X-MS-Office365-Filtering-Correlation-Id: eecf577a-f910-49b9-7e0e-08dd5816ed18
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VnJ5ZURLRXFUcXgyTVk2QnNxamQzNjlJS3BIVnlnOERJV2FSeFRoOWJlQ0NU?=
 =?utf-8?B?R2JXNzlqR2lFcDNPdXhrWHNEMCtKQ0dHdldtV3FCTWtkSTFBUzJSOW1EbUVk?=
 =?utf-8?B?NTc1TmhQVFJsUW4rRjFNWHE0d3JOZmRaZDVqQ0FGSVcyOGJqT0pKSERJc0xt?=
 =?utf-8?B?SzcwNUJpMlNmZC9mYW5WSjdrUlFIS3NxTUx6cWNkeXdTNDhaWEd4eHE3NmVW?=
 =?utf-8?B?blhJeWdjWWMxbW9acnF5M3ZpSCtsRXA3NzFweXBRNGNvYUlPMUJ6MXV5SGNH?=
 =?utf-8?B?WmlnbUdkRnBaQ2FUU3J3VzZSVDBIa0FFN0RHemJubVRrMnFmN0t4QXpVTE5W?=
 =?utf-8?B?RHpjM0NMYkc4eWdiSm1hQlUzZmJqRTFxYlJCNjhTbXgwOGw4Skd3T0RkQisx?=
 =?utf-8?B?UHdKNXc5V1dPRE52VkJTQWEzTk1WcXc5eUk5R09ERVN1QXo2NEc0SUJPMnlt?=
 =?utf-8?B?WlpIRkRmelp3MWtPbGJEdEZDNHZ5OGJSSFNwSzNzWlRpVWFERXc1YkZSek5R?=
 =?utf-8?B?RWNWYWZ4TVo0UVdjN2V6TUpUOFJEcFpEWW5yTjlwNUFiMVNZNGsxYnJ0QWRJ?=
 =?utf-8?B?Ukl2bVBOV3VmQ1phVzN2TVFiZnludlJad0FDZ1M3THFmS0EwSjVGeURTRzkx?=
 =?utf-8?B?Q0IwWGxodkx1THlWOU81ek8rYjhHNUIyNDc2bWdxcVlwT09NNUdncEtmZXNE?=
 =?utf-8?B?Yk1KSmdEc2IrRUhxNmlPUlhLWUJOeC9HcFJIdG1rQXkwMzBOQ3UvaHdyZmZj?=
 =?utf-8?B?WjgzUVNzVFpDR0UyNC9NY0lzTS95ckhxcTJLZ21oWmdQZ0lJdUovK2NlcFBY?=
 =?utf-8?B?RnQ5cDhNSWZNR3o1ZXhzVEdJNUQwMGliaHhDTnQ1a3NVbTh0L1lqelN2SnBo?=
 =?utf-8?B?NTRJYmVOV0NRSlF3RjdUejVvRG9lRjMzeFJ6R1g1WFJxWEZUNnNHM3o2VzZ6?=
 =?utf-8?B?dHNsRVNDQzZXOVUxMDlNVk1sSStPcEp6QTRBNUNtWlF4MnoxdUlxaTB3UzRB?=
 =?utf-8?B?SVNKWmJDUS9LemIwKzFueUFoSUtBSkU3T3oxNEVsRVY0am5yWk8reFNtL0N2?=
 =?utf-8?B?M2tRY1pvbjNNdGNncXBrNldXWkJyRHlhVGpUTFBtd2YyZWxPdGduNmhXWXU2?=
 =?utf-8?B?dmdseko0ZnkyeXBoaDlLSUtvRVp3K0dpWldUUjdCdm1lQUpNdkZIWEp1dkZS?=
 =?utf-8?B?TXJUL1dUZ0xJMTdWMU9ZUVZTMmpsZTJmK1B3Nkh0TVFtWHVCK2Rvb1pKWGVv?=
 =?utf-8?B?WkdVcDNRemkrOEdkTUk5YW5TdVQ4WGtuQU9QV3BKOHc3ak14VmZRUTFEMzdk?=
 =?utf-8?B?c080NmlQNU1vbFhScitaWVRwT3UxSS9BV2xsN090cTRBcVVDK1BtOU9lSFR6?=
 =?utf-8?B?WTJCM1pFeCtkTlhSN0g0VFRrdDd5UmdTZlplbVZPM0dTMjlRSUNMSkhqWHpL?=
 =?utf-8?B?bCtwOU02SXZnY2NFb0JRNGpDc0lSWk5kMkRoa2xyd3JNY1RCakxOcjJxMmFH?=
 =?utf-8?B?K1d2S0pyRlhVMWV6UGFGQkxLamZNSDJjUmxhYjFmdWdkV1hsMUptbmREcjhF?=
 =?utf-8?B?clJVWVFrMndXSFpRR2JTSkhvZ1NGRm1CdGhmUDgrdU5jK0RvVlRsblR1bDdn?=
 =?utf-8?B?YTZnSDFCWUpqWVVrUW5RRXBsK3ZMUURGVGhRR1piYU02d2lMZzBNM29mTm5u?=
 =?utf-8?B?MWNPbmh6UjBsQXBybEV3dHFQci9KOXRIMHQ0UkQvQnVTOGt4RkRTVkdhZ3lY?=
 =?utf-8?B?VXpzL1hvQ1FQTDRId0t3WnhTOWZRejU4T3RSV0RLMVVyYmkzVnNRaEEzNjRQ?=
 =?utf-8?B?bHBpS2tSMmRWcTdwQWlyV2NkaU9BV1BodUc1WWJ0aEVjdUlBTk9WclFuSE9l?=
 =?utf-8?Q?/38p8xaWXh0+c?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM3PR12MB9414.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OWVCTzhSb0RxUnNRbzN0T001WExCS1dVOGQ0RkxYaHhGcXpLN0NIbmhrSWpI?=
 =?utf-8?B?eDFJN2dEbTlQVUQ1ajZUdWZ0ZzBpTjkwUVZpRnJ6RVhYbW9Fb2JjRFhHSEln?=
 =?utf-8?B?eGdVOGZEb0N2cXFGVUVIV0JReXovbFgycWZpM3d1YUE4c2prMFNuU21GNmlF?=
 =?utf-8?B?YXdiS21GME1oUlFZdTV5enJlWHRqcG13SnFJdnFOTXF3R1g3cy80Ti9wdHpN?=
 =?utf-8?B?WlhpM2E5MjF0R2ZHbThsbXZLWGcrQzJiVXF2T1ZCamdvMFRjV2tYTEIzamll?=
 =?utf-8?B?L0V3Mmt2TDRINU9lUllPekpvMzFaUnliUG9OQVN3Yi91Z1p4UFBrVG0yd2oz?=
 =?utf-8?B?UG4zSjgzOXMvOE94MjRvb0VSS2JKUUdkWmJTbkM0V29tQmtBWVg1RU8ybE9r?=
 =?utf-8?B?K28vUEVGakYzVWhsaWRPZUZmU0I5ZFU0TWl1ZW80RE05dGlaNHZNcDJKd3pi?=
 =?utf-8?B?U2wyaTZtdXBaVUFscm9La2MxdlVJenRtd3o2bmJERVB2V2VtbGdRdFdKTkla?=
 =?utf-8?B?cy9RN085eFEzempjcnNPL2N1R3JFWVdNdVB4eGY2cDE1aWFPaFoyYzZ3eDcw?=
 =?utf-8?B?Q0N4WDVxN1F0SEduLzFGdlpDY25oSGw5aXN2aktlSitSYXRWVkk5K1JHRTNk?=
 =?utf-8?B?cnRGeTgreVhXb2lBM0w1N0lER1U4ZTY3dThDMlZMeEprL2l2L0JnclNkcWZV?=
 =?utf-8?B?MHZZR0N1Um02SFl2RTgzTEJQTU02WmZ2Y0szYzJjQXRZYmhNbEkrNTVQUm1T?=
 =?utf-8?B?R3B2TVZsTGF0ZFltcEswY1FibG95MEdCRjJZcjF6ZlpvbURFR1lmZ0dqMXZ4?=
 =?utf-8?B?V1U0anlIcEJCMkpkcVRweDNMdi9Udk9GTHFyOFJtR0x5RWFRSSs4YjliRVZV?=
 =?utf-8?B?WDZXeFlqc0cxZ3ZzS2Y3Z2hVMWZvQytPdkp6eDkxekthdUlvZUUxRCtnNncy?=
 =?utf-8?B?ZWtZYzBIcjRNLzQrNzNMUG9ka2RnT09TZnd2M2JoNEJidFNYUFd4Um5tTDJY?=
 =?utf-8?B?OVZlNGpWQjFTSG9ISjBlMS8vNDNHUmZ2VTdMUmt6RzlTdDBVbFg0eHlmdnZC?=
 =?utf-8?B?R0gvOXBvNHFra1ZtTGdiMDRNUVl5M29XSmNaaDJGcktSVi92UG5TMWI0dkd0?=
 =?utf-8?B?M0czcHdpMUJDMExpZlFQL1hjSkZqbkY2T04xekxSWG1LYnpJTnRNT0Mza2Ro?=
 =?utf-8?B?ejY1SWt5VmNYNXYwelpTOUN2S3JqanpjbWl6MjZ6bUFMVE5OSmFEbjJDYVA1?=
 =?utf-8?B?SWNlMDJPR2l1SmxSRFhIYUl3dC92ZU1QaW51YUNZN1hXdk9KbUgwK01manNT?=
 =?utf-8?B?bTBlNmN0NFAxUVdvUmI1NW1uc3RMKzdwWmd6MGFUck9hT2tBM2lpTzFNME5V?=
 =?utf-8?B?eGtzb284VTFWY2VFcnVDa0dxcGlXVDJmRjE1Sk56Ym00bVNzcmxtVGFzbnpa?=
 =?utf-8?B?Skpxc2hYUmo3SHJuQW4xWlIvNnlaT1Y0N2JvNk5EK1FiZXp0WHI3SEU3NVBO?=
 =?utf-8?B?cFQ4RmxPUGFFRnZCUFQ3Nkl0TXJFNGpkWFNkYTMyN2ZYZDFKeUVEcm95Zm1y?=
 =?utf-8?B?VDB2Q0VEeDlUTFhYN3hIaGFTcG1CSDhBZ3dkNVFCNlRTQ0pQRjczeVlyalBo?=
 =?utf-8?B?YkJoM2Rra0h0ZjhNTk0vdEJrVmRJZ0E0Njh1VWcxaWs0NEZzN21uVmRTQ21F?=
 =?utf-8?B?c3QxSTdwOFdyZ0pvdFl0SElwREpTK3ptSDFWK0xjRXpuTWtPaWpWZzhYRmxX?=
 =?utf-8?B?UERiQ0hwaVljVUF5dFRpSnN1MVVRZXgvRmNJYWY4QTJweTZoYmoyV0pFaE94?=
 =?utf-8?B?em1kQVZzWG1CLzlvdHI1dWVnSmErWXZENmlHa0tjN0Q4Zk1yZjVadDRwQmdh?=
 =?utf-8?B?RWxVK1QvUmNUMkJ0ZWsrT3VIN3BsSGF2bWhOMGMzTGp0bmU1TVN5UnVzQ3py?=
 =?utf-8?B?UlBtVjk5ZGVLRjIwNkkzWllBVngzSExWb2FsdFc0VjZSQWM3akZ2K1llSG8v?=
 =?utf-8?B?ZFVKdVY3WjR2SGhodnhYM3lzQVR6LzRGNS9zckthMUdzMUR0NXhEcGl3ZTFq?=
 =?utf-8?B?akdoaDgwbE9Bdy9FcEU2OHpONFBGRkc5RzcwTVRveUM0VWZVSXdSZG9raFlO?=
 =?utf-8?Q?GeeIk7XSofmH6LjWuVQPzlwPD?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eecf577a-f910-49b9-7e0e-08dd5816ed18
X-MS-Exchange-CrossTenant-AuthSource: DM3PR12MB9414.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2025 16:42:44.9742
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CiZybckwjyGSniqXP2nof7Ne67eejkkiHJMfcqEDX8oZ6A9vzBF/95ZdjncOV+b8779sq/OxjVN0uEhFdmYnQA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8253



On 27/02/2025 22:57, Jason Gunthorpe wrote:
> On Wed, Feb 26, 2025 at 03:54:13PM +0200, Leon Romanovsky wrote:
>> From: Maher Sanalla <msanalla@nvidia.com>
>>
>> Currently, the IB uverbs API calls uobj_get_uobj_read(), which in turn
>> uses the rdma_lookup_get_uobject() helper to retrieve user objects.
>> In case of failure, uobj_get_uobj_read() returns NULL, overriding the
>> error code from rdma_lookup_get_uobject(). The IB uverbs API then
>> translates this NULL to -EINVAL, masking the actual error and
>> complicating debugging. For example, applications calling ibv_modify_qp
>> that fails with EBUSY when retrieving the QP uobject will see the
>> overridden error code EINVAL instead, masking the actual error.
> 
> I still didn't see an answer to the question of why userspace would
> hit an EBUSY down that path in a way we need to care about? That is
> doing dumb racing thread stuff that nothing should be doing..
> 
The issue isn't about whether userspace should hit EBUSY, but about 
ensuring proper error reporting when it does. While hitting EBUSY might 
result from racing threads or misuse, masking the actual error as EINVAL 
makes debugging more difficult theoretically.
Maybe this example should be removed from commit-msg?
>> Furthermore, based on rdma-core commit:
>> "2a22f1ced5f3 ("Merge pull request #1568 from jakemoroni/master")"
>> Kernel's IB uverbs return values are either ignored and passed on as is
>> to application or overridden with other errnos in a few cases.
> 
> I don't understand this sentence
> 
> Is this the defence of why it is safe to do this? But if the rdma-core
> overrides them what is the point of forwarding?
> 
> Jason
Yes. Most cases error is passed as is, only in a few cases the kernel 
error is overridden (such as alloc_dm_steering_sw_icm()).


