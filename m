Return-Path: <linux-rdma+bounces-15029-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 00157CC3651
	for <lists+linux-rdma@lfdr.de>; Tue, 16 Dec 2025 15:02:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 1B976301634B
	for <lists+linux-rdma@lfdr.de>; Tue, 16 Dec 2025 14:01:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 532BA33D4FE;
	Tue, 16 Dec 2025 13:59:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="DByCmK/+"
X-Original-To: linux-rdma@vger.kernel.org
Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012048.outbound.protection.outlook.com [40.107.200.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C9FF330641;
	Tue, 16 Dec 2025 13:59:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765893581; cv=fail; b=iuTYV9fzV7M9PgNKscqbo9sH5cLU01kfnQXu23ibkvktCAxOfti1zY9316MbGvlkMMNjanTGdgyj+pMIK4bMQVhQJRpZ5OVjqFFA4UbBBlD211KuaTqmgr7LTYeq404Dhos3e/ftN0HMif8vi5S1qvUIQ91KEWXnsEEGQug+GfA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765893581; c=relaxed/simple;
	bh=HqwXdLJjucOxBOEh0lvuun3VW9qyt66v+2I6H+V61xw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=IZkYt5Gayx9QG4Dmnu2equvFRCl3jzjn8ciusoZaVEjjR13d5K9WCk9wj2CSXC/ZWiHrga4vG5e66ON+VcB7EOT+/oDQ5PaXCZst5FIuQBrMuvrM/6sGiILrdoszUqX1DMy5FQAdElXwaoyQFR42LLvwvUNU9bPRMwuBhxDP/K0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=DByCmK/+; arc=fail smtp.client-ip=40.107.200.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RBwFTYKbG7j/CwA75eSibHR/VO2ORbNWm3NHkULiRNTZ6acVE4AKL8UoYS+EeV465XGRa3NrmaQt0KzPMQJnEhBp3+VN++55lsQ7Tzvtm/xmYa3Y7lNlixq5p0Ud0A/tssbCnHgPW5sD9ZdFusOrn0b5b0C/SkF/K9QWTHEAGj5nDs3A8Ald54tgzrfEeEDuT/JK1pPzkH9Vw+7LMHqmpjcmGWYrDwQ1h48p9XVGK/AWlKa4EkuRTK/XWP9nYuFZV4MI6zms40paTl6r0SGKlGRaqn6wOSG3kAaubzaAfvKQosGT1qkSPuaDsDDEnjOLVxwDPJIr7Yv/uaWTBFbdig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dDOOAzK2mQMtI8fggsrxJ9ReCMMuZaLd6P+HjMfq5WM=;
 b=OFvkS/3q4klf3C9s7OQeuhHMHQ3rPkgecJyHeBJKk0163GuLcaXXG55kjbKJGaoIdXYwtQTCLUllfi1AE/N9Mk/R311cxUFf36bWYiHQZHlesuvC6MqQMGU9Ll/XNhdWXMeag8aqQbUc0MCbrwMZORvagyvdhgOWDtzTBcw8dh7Eu5keH5wdgbsj9JuAcLdAgHPIgbtQvdk4BVTp81pVh8cKMMrG8bGlqdeqrqrpZOqIg1B0S+F9PgjAehMSgsj8r3l+DThwyqHHvuKV1Tl7fJdzo9rfjxfO4/U8z6dgeyRonPlk8HxxGn1ql+0RjF0PuagiJRvx/hbu0I7ffsr73w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dDOOAzK2mQMtI8fggsrxJ9ReCMMuZaLd6P+HjMfq5WM=;
 b=DByCmK/+ec+lBDp/E0Zq4xLrcbAUrqwNRyL7sKbcsicfNdw0OHklj1GmbdsIo1EQIA4lNzjsiLngq6VzI7mFAXB7tlVA3vQbHeeMLU7Ewl5ZE6q6a4NhJ+8UNWiADVmLFX8oMlcppX/uV+jnEf/ES9xFSJlwrZV+jT3Jwl3AeAn6upulRHjJsgcAezcSfyx6424vZyo+kXYv/fketHI2RoOiv/U3Fe54HTGbdtC0YaO89ZXjYiIxBKKSH9gnLosS7PURe1lM0xI/wzjkqawnl0d1J++LStqWHO/PVpNzUVxYldwlnFJvmJX1BXv4Qa1FgSoengq+ZhAsqSEtkvf0lw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9715.namprd12.prod.outlook.com (2603:10b6:408:2a0::7)
 by IA4PR12MB9835.namprd12.prod.outlook.com (2603:10b6:208:54f::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.13; Tue, 16 Dec
 2025 13:59:35 +0000
Received: from LV8PR12MB9715.namprd12.prod.outlook.com
 ([fe80::1643:57be:ba7:a15f]) by LV8PR12MB9715.namprd12.prod.outlook.com
 ([fe80::1643:57be:ba7:a15f%2]) with mapi id 15.20.9412.011; Tue, 16 Dec 2025
 13:59:35 +0000
Message-ID: <a51bcd2d-d1c6-4516-90c1-f6c50ce01f9f@nvidia.com>
Date: Tue, 16 Dec 2025 15:59:32 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] IB/core: Fix ABBA deadlock in rdma_dev_exit_net
To: wujing <realwujing@qq.com>, jgg@ziepe.ca
Cc: leon@kernel.org, linux-kernel@vger.kernel.org,
 linux-rdma@vger.kernel.org, yuanql9@chinatelecom.cn
References: <20251216005705.GB31492@ziepe.ca>
 <tencent_713807A8D67394A5D8339F8AD33FCCBFCE07@qq.com>
Content-Language: en-US
From: Michael Gur <michaelgur@nvidia.com>
In-Reply-To: <tencent_713807A8D67394A5D8339F8AD33FCCBFCE07@qq.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TL0P290CA0002.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:5::10) To LV8PR12MB9715.namprd12.prod.outlook.com
 (2603:10b6:408:2a0::7)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9715:EE_|IA4PR12MB9835:EE_
X-MS-Office365-Filtering-Correlation-Id: 76505500-d05a-4c93-d0ca-08de3cab582f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?akJaNHlzVWI3UmE4dU9HRzlzV0VJTDlDT21CNUdJdWl3WHJTZDRKbkN3b3Jr?=
 =?utf-8?B?L1IwcFZ4VEx5enhsd0pEUjEzSkVyRVd3WTRCc0Zha3I1S0xVYjlHWlNVOWx1?=
 =?utf-8?B?UkU0SDVPOHBDODhvRkdGZUluU0Q5YTI4cHVCRFRJUTFaSGw5MGd5R3ZvWHk5?=
 =?utf-8?B?eVVGSmNkMlNpQUZISC93RkxsSC9iOVV4R0RYNkwvcTlhSjlYNWN3ZnVqNm8r?=
 =?utf-8?B?bzlZeE9uVXRxemltc3F5bTJYSUFXYmRMQlFuN2VWTmxnT014ckczRmNZMUxB?=
 =?utf-8?B?TnlIZXQ0NnlVRTJSVm56ZmV6MFBpK3JCWkRqUDlGbU5UbENMbXNSc09QZUdK?=
 =?utf-8?B?b0xDS1pjK0dkQmFEcG4xMFNGM25KK1dsZ3ZTaXBweVpZYTVzekhvMkhHTnFv?=
 =?utf-8?B?dVp3MzQ0VVJMMVc0RkRVYm81TzhjT3VXSzQ2Y3lEUkJhb0w5ZlFPdEMvanlq?=
 =?utf-8?B?MWl3RHQ5V1lBT2QvS3ZLUjdiQnROWmZOK3hiUElneDJEaXBVU09FZjNJRHkr?=
 =?utf-8?B?MFh6TDRyLzRZckZiV1JJRHhFT2l1azFZOFU1TW5sU3d0cmNJcVV6TzNaUUpC?=
 =?utf-8?B?UUZtUEowS0gyckJEd0lMeGozVkNQUnFtc3RJSmRqSkkxMlltdDNWa0VRVm5r?=
 =?utf-8?B?VUpvdVpKeFR1dGZHblZRU3BQd3lrUWJFL2hJUm5oTUNNMmI0THpNamo1c3N5?=
 =?utf-8?B?N1NzQTN5QlZNeUQrRTJEOVVubmtqVTBibE1hQzFDcFkrakhnY09qdFhlQUVZ?=
 =?utf-8?B?cVZTclc4Q0VaZXBvdEFjN0RXeUdvSy9pY0pZOUw0Q0VhZDI0YUR0NzZ4eDhC?=
 =?utf-8?B?dUQxbVc1MnZVb21KTkVEYUNabU0xTUg4VjZoSlZraUZEc1RLN0FFVksvK05t?=
 =?utf-8?B?ZUdjVmVZMjBYZFptUUROMGQ4MlBUcTNKc0lPRFIvUmVEbG9QVE91Q1U3cC8x?=
 =?utf-8?B?d3YyR0RXQ1ZFTGlSbzhKb3dBYVlMeUZZMjhjSlVPWVI0WFN1SmllUjJPVUNF?=
 =?utf-8?B?ZFlsQ3kxcXorc1hGcmZjMlFwenpCMzU0Q0tSUHJPL0crSTl1WTFSSmllSTFB?=
 =?utf-8?B?eFdIaW95MXMvNTJkRUd6c0ZndG93alhod2ZiUjJrNVhTMWZDeDlLR0VXVjkx?=
 =?utf-8?B?aUJqU09JUXVLOUJGdDMveFJPYVVPeVVxNFZ3SGpHRlZtZmNLMVVoWXdrbHhM?=
 =?utf-8?B?MlJLTTZMOHp2RlU3SXpUTEg2ei9jZkxWQ2lrczlWY2lpSkwwbkNCMWZIaXZM?=
 =?utf-8?B?aUhnN1ZoVWJ6ajd0aTc3d29lS0ZtUzdrdmxvbU1UcVZKRElPY093K21KaEUz?=
 =?utf-8?B?cHA0anhNc1k3SG0wNnRLZjVMRktabG1mQWNJNXFIVHFZQU9iNEs2QVp4UU5C?=
 =?utf-8?B?RkxVYWwwNURDbEQwOEZBdXdqVnhnenBxWGpDQm1jclFQcEp4aWpRWUZLem1F?=
 =?utf-8?B?SWo4UFRCM3R1Zk03MVQxQ3M3cGZVQXg0aDFkWlJmWTFFUmcwclVqMFhFdlov?=
 =?utf-8?B?WjR2eGxiL3BETzlGZys2Q3F0YjY5SkFlVlNOVEh1QUtjTHdJeEcxNzlreUVa?=
 =?utf-8?B?RVVrNjVuVzFkeGFoM00ycEt1M3lUL2cxVnRrb3Voc1JTYmxPWk9MQ2EzVkV0?=
 =?utf-8?B?NnpPSVhEYWFNQTB2aDVLeXdFRkFjZTVESlN5WXFVWGNoVnpyeDBFczhMRFhz?=
 =?utf-8?B?R0lYeG43QkFkNEh3R3lkK1NGV01Wd1RNT0NlOWFJaXVrdzhJRk9vQXZKcHZR?=
 =?utf-8?B?dXkxU3FkM21hVWs0cTRIZ3lpU2FXL1BFcTdzUE5Dc2tLSzlCYTNzdG1IQkdH?=
 =?utf-8?B?ejQ0U1cxNUFvYWJReThkMllWWlRWNVBoREQwRGZmY0E5ZjlwVmgySmZEUE5Y?=
 =?utf-8?B?M3NZQjJPNlZMbW1Bd2wwamdGaHZFb2pnZDV2Nm5UZjg0SFlCejZwK21LTjdN?=
 =?utf-8?Q?PZs2EiAh3WgzAX4J2wULz2THax1OtJnU?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9715.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?R2lzdytPa1lueFNhWVRSME13cy9CMlFzV2c5M1pRWlZHbTlGcWUwMSt3Zldn?=
 =?utf-8?B?cDdDSkE4UlRVNXozMTA4SysrbGFOMUN5WnNiWktYQXY2VGtYeHZ3TzNkNUpl?=
 =?utf-8?B?SmpGU1o3M3JjZHpCMDlnYU1VWFYyd1B2akFjaDdZd1F4VGt2aXFkU3ExR1JU?=
 =?utf-8?B?V0ZELzRnaXV4VThyRVZrQlFKM1FHUnV0a00yaU1Vc1lPKzBPWlFIWVA5WkVq?=
 =?utf-8?B?elV2RC9XdWdNYTBnaTRkbERBWlc3ZnZUNm91U0o3WHd1ZXN1eFVCY1hpbDZm?=
 =?utf-8?B?c2l6V2FCbEVBWkJKaWNIVWdiSGFoV0oyN3lyMUpUUXVJWjF3ZEsyZTFHZ0dQ?=
 =?utf-8?B?OGs1dkVZNE1HQlcwbWlYUitRZVJmNXluK1lmY0NHdWxteXNTeFFRVHJHTy9H?=
 =?utf-8?B?b3ZmeUpZUG9zM3d0NWhLdFZoZXhwc0xuQmJzUWJ6V0Y1eXJRVXhQdXNuV1Rq?=
 =?utf-8?B?a3kxK1BmNUIrdVBKajVYb2VNa08weGFVQndmcUl4ZmdlRnZZOWQ3WmMxYmQw?=
 =?utf-8?B?ZWx3Y1I1ZjV3c2RFanlRZ1Q1ZWd0WlM3MWtFMUVHZmNpclB6UTNPeG1Jd3Uy?=
 =?utf-8?B?RXYvZWZxZ1NlaGFva08rYXhHSUczQjJmSkRqSllrbVlvbFZMbHRSTDRtd1RU?=
 =?utf-8?B?RmJMNHR6bjJKR0NyTGc4L1lKK1VTajNMb2VDdGFqN2w4K3orWkM5eFRzbEVT?=
 =?utf-8?B?bDF3ZDB4NDVtaXYxWWNWSjNiellyK1BvN2FuZnpvTGFQckVyRXpFNDRTNE41?=
 =?utf-8?B?dzRLQzkxZFFhbUFEd09CUk1NZisyOENaWmM0T2ZxQmFzUTZBZWhiT1dNbXZ0?=
 =?utf-8?B?MFJ4QWsyU2tZSGZLQ3JLd29nbUNxMDI1NjdSazI2QVlhOVRVdGM4MWRPSmxs?=
 =?utf-8?B?dTJ4UFNkQVpOUWZtVEJUNWdjTHVZWklhUXpoSmZyeGV0Nm50TG1VcWVHRHRw?=
 =?utf-8?B?NXJobnM3bzlpZ0R2eGFjUE5vNjFKWGtpRXp3ckxtd3EwYkczT2xMVVFmcnpu?=
 =?utf-8?B?d0dMaWhFaHFsSE9ldXNHRHRSck1aT2hIek1tTm1YU2QvdWdKeVgvOHVLTmhJ?=
 =?utf-8?B?S1VyZ3dmY2FMVTViUHZERm5nYkNzYzFxSm9jYzhOdEt1Z240M1h6azE1a3Ri?=
 =?utf-8?B?YlhiUEhrSVEveHNrWU9Nd29jS0t3eXVQWUZyK1FUSGx4WTRqVzFhTXdvMXlJ?=
 =?utf-8?B?K25JNVZ1TFpiai9Ba05KWFprYzhRRDFQTkUrc1NMT1JJSk9UbHhXV0F6N2RU?=
 =?utf-8?B?Y0EzcGdCcW5QYzRMeXFyU3c0SE1PTk5mS1h5cEZiWFdDVXkzNTFFZ0pSSTlR?=
 =?utf-8?B?N3djNkE5aEh1Z1ptZ1h5dzcvbnNtUWFNc1pUbk94VFh4aVY0NFFkMkFnbndj?=
 =?utf-8?B?YmEveCtRdm11TGQ3bGFCOGtnSlBjQmpRc0JTYmN4NS9MVldIaGpLSFZwbkFu?=
 =?utf-8?B?WEZWVnJES01mbmhTS2dNMEJBR2tVM2djODE0NS94VndCalpTbThPcitISWt0?=
 =?utf-8?B?YlJueFkxK20zSUduNU5kTkdRazhQUWpwV3JzcnBDUUFna1FYN3NsTU5jK0RN?=
 =?utf-8?B?cHErMnVZakxtcUppZmlXelZGdjJKanlMNXpUMXZTWjRFd1dkNWNDV21NMS9Y?=
 =?utf-8?B?TmlUMXJsSTMzZGpGOG5kRG9aM2RuMW9TRGhSbDI2WXhHSGI4T3M0TWhVNHR1?=
 =?utf-8?B?bmwyVTN6eVAzMmZ3Ulc1ZVArVEMzWFZMRHNUakNlbjNtNUlWYnpQSlMxZXNz?=
 =?utf-8?B?RDhjdmRyNmdSYndnYXFBN04wNm55SVpRYVVvK0lHKzllb1hsWkNuZVE3M1d6?=
 =?utf-8?B?bi8xMkR3ZldrMGNvSGl3eDhTZnFHbUt4Zi9DUVJmWDZ3Q0xkSzBSTFAzNUEv?=
 =?utf-8?B?ejRZNURBS0N3bDV4RWplcGVlUkNiQlJnZ2pubFpxVzkyd3p5VGpiSkd6OXVo?=
 =?utf-8?B?QTRHZmR1aG0ycDdsWFhsNVMvd043MEFYbi9NczMrVmQwUXBNUE14UnE1V2x0?=
 =?utf-8?B?WW9tVkQ0aER6cFlxQWxJWXdQRTczZGRqRGYxbkhJd29nTW8zMHg5a3M3Nk1n?=
 =?utf-8?B?MVNVSVJLbHdiNFBRYjhBNEJMUUR3dURuZmRwalV1ZUsxWWtNWXdKbFkxNVJy?=
 =?utf-8?Q?6d/wNIbLAJjGS54j/NPCFSP9O?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 76505500-d05a-4c93-d0ca-08de3cab582f
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9715.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Dec 2025 13:59:35.2682
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KQyiGXWnad2YGKmPQyT7SGsU9sfpxXnfY43iuBxo8A4BHO1ynUxlmrw5N5dSlogNlj5W6kZpCCLunonEyFh+1w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA4PR12MB9835


On 12/16/2025 11:59 AM, wujing wrote:
> Hi Jason,
>
> You're right that the locks aren't nested in rdma_dev_exit_net() - it does release
> rdma_nets_rwsem before acquiring devices_rwsem. However, this is still an ABBA deadlock,
> just not the trivial nested kind. The issue is caused by **rwsem writer priority**
> and lock ordering inconsistency.
>
> Here's the actual deadlock scenario:
>
> **Thread A (rdma_dev_exit_net - cleanup_net workqueue):**
> ```
> down_write(&rdma_nets_rwsem);    // Acquired
> xa_store(&rdma_nets, ...);
> up_write(&rdma_nets_rwsem);      // Released
> down_read(&devices_rwsem);       // Waiting here <-- BLOCKED
> ```
>
> **Thread B (rdma_dev_init_net - stress-ng-clone):**
> ```
> down_read(&devices_rwsem);       // Acquired
> down_read(&rdma_nets_rwsem);     // Waiting here <-- BLOCKED
> ```
>
> The deadlock happens because:
>
> 1. Thread A releases rdma_nets_rwsem as a **writer**
> 2. Thread B (and many others) are waiting to acquire rdma_nets_rwsem as **readers**
> 3. Thread A then tries to acquire devices_rwsem as a reader
> 4. BUT: rwsem gives priority to pending writers over new readers
> 5. Since Thread A was a pending writer on rdma_nets_rwsem, Thread B's read request is blocked
> 6. Thread B holds devices_rwsem, which Thread A needs
> 7. Thread A holds the "writer priority slot" on rdma_nets_rwsem, which Thread B needs
>
Why would Thread A still hold any writer priority after calling up_write()?

The kernel log is also not consistent with this analysis, the thread 
running rdma_dev_exit_net() is stuck on the down_write(), not on the 
down_read().

Maybe what we have is a thread running some net namespace operation 
while holding rdma_nets_rwsem and starving all other threads.
I'm not sure how many devices and namespaces we need to have so that we 
get it to block for this long, but I'd assume it's possible when running 
stress testing.


