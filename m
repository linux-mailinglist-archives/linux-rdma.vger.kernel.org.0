Return-Path: <linux-rdma+bounces-14327-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 74AE1C42BC6
	for <lists+linux-rdma@lfdr.de>; Sat, 08 Nov 2025 12:21:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 03A624E1855
	for <lists+linux-rdma@lfdr.de>; Sat,  8 Nov 2025 11:21:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D03A1FA272;
	Sat,  8 Nov 2025 11:20:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="U4lPGmuv"
X-Original-To: linux-rdma@vger.kernel.org
Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010036.outbound.protection.outlook.com [52.101.193.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DC0825228D;
	Sat,  8 Nov 2025 11:20:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.36
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762600857; cv=fail; b=HEna7tP067TpbfzSIq8sTWiCD1Yf2ImBLlYSuU1adj7mgyX3MylS93+dGLYokmZXGFOF54rmPsedy2VdK2MWcTpQyltfJP7Nw+hs406RNX3t6G0BkChwAEfljX5feOSutB+RvlnGq/G2kTh5wiqpUrVDTMQ1knVEkNEOo7Zeix0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762600857; c=relaxed/simple;
	bh=1r5puUJgGwzDPhs/N2wzM0JMecjM2C8PM3H8Lqkjdi0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=fJO2Osu3aiYWHspaaHvlNRRhDXXXEeC8wj1UaAZ/FAAb6AlTVSeg5lkElUlLBMBO3KUsan3an4JzuWCNe1vSIckj298QZ0NaCkxxCHSKa0sVrxZT5vi7JUlxWPUziECO919EuMz4udKCwC5x25gUAVB1RHAAGkXHA2gb8TiIRLU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=U4lPGmuv; arc=fail smtp.client-ip=52.101.193.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jmewwbr2pvCutCKksA6EZWlLytImToeSNtdsaPzzCaK7OJJwASIK0YQLmVAodkzXaNBJ8WIH0zteS2RUHIoU5J9bZfjD90c9IWaXMqXo8jAH0Nt0V4fe0fllNBrV75UIFjBtnGJiRG6Qei52jLNSW+tg9MaycSMBbSlVC1gH9Jwatsh1J9XRIb6HtbYH/822Gw+pYPjfPFx6F+C/yrIiMyD0WyIC0Y1fUs+kJ/k1tgEpfojtpsQ/Gh0xIAW5mmwjlp1+1lkVCEeqp+Rtg87TgI6xdXfbO+noQOkgI+idKZ5UauALWf4nTEOyiL3W7fPdnHByzenVYK0wDI2z+hYVlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nIGB7fHTPoHtZMgHxkNPlEXd5efha/emKNlNcmgbwr8=;
 b=faJUO+hvNJRKN17qwa7NMK+9vUBPoQtug6z+2ncJ39WPl4uloP1YOFu0eZ3P+IV0tlqZUhuTBFR0jIYjRmEFU5sTRB2fTDmKN9NPqwWmQvet0r7wbAO1WNdbBurIkdrFyJ+f9wx5WndbNgtxVPWUSRgvZnMzHYYQBqPKaItYkeHiqg+6RpH7nv32cOmvcOZhjEkcI9krbjHFCQsXxrs8x0Zhe7BjTy6+2n3W4cCCOvNmaXpr4ujHoMqwtCWXtOt5+lmeOyI1rwLy/sG8UJoqNHMgeDVYc2/KRkaWlkEMifvlBUldcjWLFtOOvG+rbxYNGgdZo+vVkIm+Odv3ZKos3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nIGB7fHTPoHtZMgHxkNPlEXd5efha/emKNlNcmgbwr8=;
 b=U4lPGmuvAqjuh9Fdxz4W4ThiqgDeM5123K67C+c0RsSPPUQg/YBxWZ/aOtBEdmG3HJn3rzc3xkYqX+W5FoAziIpLChdMGHlumNzzDAv08wFptFFNdOth8PKt1Wm4Dhm4yZJ9pOXtZakQFYWQLIV7xkImHWZ2N4czEcoxsjNTsMo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB6048.namprd12.prod.outlook.com (2603:10b6:8:9f::5) by
 DM4PR12MB9733.namprd12.prod.outlook.com (2603:10b6:8:225::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9275.14; Sat, 8 Nov 2025 11:20:52 +0000
Received: from DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::6318:26e5:357a:74a5]) by DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::6318:26e5:357a:74a5%7]) with mapi id 15.20.9298.012; Sat, 8 Nov 2025
 11:20:52 +0000
Message-ID: <70252b95-6980-423b-a7cb-005f5064fe45@amd.com>
Date: Sat, 8 Nov 2025 16:50:41 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] iommu: Allow drivers to say if they use
 report_iommu_fault()
To: Jason Gunthorpe <jgg@nvidia.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Christian Benvenuti <benve@cisco.com>, Heiko Stuebner <heiko@sntech.de>,
 iommu@lists.linux.dev, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Joerg Roedel <joro@8bytes.org>, Leon Romanovsky <leon@kernel.org>,
 linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org,
 linux-mediatek@lists.infradead.org, linux-rdma@vger.kernel.org,
 linux-rockchip@lists.infradead.org, linux-sunxi@lists.linux.dev,
 Matthias Brugger <matthias.bgg@gmail.com>,
 Nelson Escobar <neescoba@cisco.com>, Rob Clark
 <robin.clark@oss.qualcomm.com>, Robin Murphy <robin.murphy@arm.com>,
 Samuel Holland <samuel@sholland.org>,
 Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
 Chen-Yu Tsai <wens@csie.org>, Will Deacon <will@kernel.org>,
 Yong Wu <yong.wu@mediatek.com>
Cc: Lu Baolu <baolu.lu@linux.intel.com>, patches@lists.linux.dev
References: <3-v2-25fc75484cab+ab-iommu_set_fault_jgg@nvidia.com>
Content-Language: en-US
From: Vasant Hegde <vasant.hegde@amd.com>
In-Reply-To: <3-v2-25fc75484cab+ab-iommu_set_fault_jgg@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA5P287CA0221.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:1b4::9) To DS7PR12MB6048.namprd12.prod.outlook.com
 (2603:10b6:8:9f::5)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6048:EE_|DM4PR12MB9733:EE_
X-MS-Office365-Filtering-Correlation-Id: 0ce58c11-ccc2-44b8-6397-08de1eb8e069
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|366016|376014|7053199007|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MDVvR2YrS0l2VS9Qd1dQMU5QQy9UdmZGY0Z0QUorQ29COWJlVmVPSUFCOXRE?=
 =?utf-8?B?c2I1aFB3cHBvbHd5dVdLUGY0ZVkvWkJ2bXpzbXgwM2FINU41czlMVkRJdXdW?=
 =?utf-8?B?ZnRmaERrc1ViWEZIMGtnZzR1dHR2VzhWWWZoVkJXazhnOFlEUThNbEhQNXd5?=
 =?utf-8?B?dzdEM3hOYi9jUVZiWnpHNTJ2aUxRaTlnSzdzWFQ0QjRLdTkyQmhlNnNZWm01?=
 =?utf-8?B?dVJGVkJMRGx1RzFzNlF3UkFwaFg1WlpaZkw2K0Erc0NGckh4SHNMVDVTa00z?=
 =?utf-8?B?aUV2Z016WElpVm8ra0RtRDQwRHl3ZVdZUjJvazJ0ZWlpa1JzeVNJOEVzaVVq?=
 =?utf-8?B?TWlqYkRJbVJ2T201VnlGRDZ3YlQ2UFRLbTIra3VCYXNzOWQybmlSVlVqcktV?=
 =?utf-8?B?YnJUSEhNR3JNdXBIWWU5MnVLdms5N0JyRkJSTE9wNUFETW5OeVdaeEs4SGJT?=
 =?utf-8?B?amNxZEl0d2RhWlhISVdSaHdIS3RSb3BuYzNhOE1lTkZvZlUwQXNQU01VdkdR?=
 =?utf-8?B?TUY4aEdNNWdPdVFpQU1HaFA2Ym1ZcU4rOGNRNTExeW1xUDNsTHh1VVNHbG5z?=
 =?utf-8?B?VTFuKzE1czA0UnJpaHIvZm53SXloYnVvbEgzUDd5ejBaU0pUd3VYRGRXOGk0?=
 =?utf-8?B?SHgrV3JDV28xUHFUYzVlOXZQRzE5ekJQdVYvdUhxenpWNWJlbWMrTVRlRjM1?=
 =?utf-8?B?K3diTGVZVlFCTkZHQ1BBY2MxL1JHaEtwTGs0SnZhUGVsSjFMMXQ5SWFxREM3?=
 =?utf-8?B?Z3RqUzIyc01ZL2NyYlEwZjRJU2tZL3VoUnNaSTZ6Qjh4M3lLY3VrMWt5SDAy?=
 =?utf-8?B?dlBFOGlWQkljRE5yUzkzeWV1NHhyYU5LQmszWHl0MWh6ZHBUVURwS0RKaHIx?=
 =?utf-8?B?M1JxL2lFRzlxQmlOVzluMEFlTjZFQ0FLK0VCNDJjU2d1K2JMbTRHUUFUeWd1?=
 =?utf-8?B?UzNWRjcyUUo4dFFoQjgyUWRHQVcxRnVYaXR3Z0J5M0RjWHplWXpFV2VjcS9i?=
 =?utf-8?B?d2QvRlZ3VDJ3QjJWeFdodVZkM01oUDRPcktuVDlNYXBGQisrSSsrYmxrZ2lw?=
 =?utf-8?B?aHJkR242OVFSQlkvY0dCRUIwYnVaY3MyVStDaTNxR1hWdGg3RysyeER6cWdv?=
 =?utf-8?B?ZFRoeldHTlJDNWh0d0kwbGdGcWJUNGxRQTBaMDJ6OXJubzFDak9rTVpXK291?=
 =?utf-8?B?bWY5UDM1NCtXMXRZMzF4bTNGQWZSV0s0cFdBa3dZZTRWRzBEcDRaN1JlSzRR?=
 =?utf-8?B?c09ZNXU3aG5BZjhSOXZDV1d2V2R4ZHZ2V3FFWkxzWXUxUDNYQVJOSFk5Y3Mv?=
 =?utf-8?B?Q3JMSTJVampNZm9YVjdaNjBpWWFrMzhJNFFiMlZ2NUtuNjJYK3c3S1k0bFkx?=
 =?utf-8?B?eVkycTdtUmhZVDM5WkE2d2hmQWE4Z1FJVnBDUEszTURlbXg5VjFER2tSK3pE?=
 =?utf-8?B?alh2cDhXQUFkTkYzalRKeERuU2lNYjl3dzZYTkNLYmpaU2NHWUdoV0ZTS2dm?=
 =?utf-8?B?c0hXMi94SCtnbGpxNGM4eGJlUXRaZWFRaTJWRG1QNU1zbWliYUZOMmJXTzNt?=
 =?utf-8?B?Q3FtQ09HdE5MTEcyWlh5aXE0R1pNQWkyUDNNSWpBRDJYSW9qSXVNU3BNNHZN?=
 =?utf-8?B?WTF3YjBVQUcyQ1FRSzgwazV1NzliR1B4Wm9mQ0E2Mjl1dFJkYmNRY21yTG43?=
 =?utf-8?B?NjJFSzhnZjlXSXVNUVZCMk1RdEw3ZjN1Z3hIWXRIcFVsU1dBUUVtSG5vd2Fk?=
 =?utf-8?B?UXhuVTduRkk3YWxTdTZIajE3cWJWLzlkbWRWd3cvcHBlbXFuVjdlTkc1cG1o?=
 =?utf-8?B?eFp2ZERTZnFWQlFMVGFqSXZpN1dkQWJXR3dLT01HS0krSHNVdllKS2Rvd2xk?=
 =?utf-8?B?L3pmb1pBNGdKR3N6SS9XOUVjSUlvTWk3UG9DelZGTTMwSEhMTHYwQ1lJQlFQ?=
 =?utf-8?B?cGxFaTVzZmV0aVpQRnVreUhHTkZSeEx1OFVIdjd4bzBENXpsdW10K3g4WSt3?=
 =?utf-8?B?QXNST3JNTE9IcFlrWGpmZWIvQVRodWxyNisxQjVmaWlMMk1sL3JTZHNnTmhW?=
 =?utf-8?Q?cxsyfU?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6048.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(366016)(376014)(7053199007)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VE0vM2J2aEtMY1lmMWhVWllXNlFsdUVZNHIxRlcvOE15SUtjMFhINnZWTmlR?=
 =?utf-8?B?YlZmMEJ0K00veThTbExpSFlpUDhmSy8wQ1dybStNOENvV2k4Wnk2MERqcXZ4?=
 =?utf-8?B?WU1jYkdQSysrSkx5ZW5oaGRGY05sV0lMbGJ2UjFDTTNFcnBKaFVDdW5UeVRh?=
 =?utf-8?B?WVdGQkE0L1JNUUYzeFd1bUo5T05OdXY4MEFJdXhKRGUyb1ZueWVKSktTVkJo?=
 =?utf-8?B?RGIzTi9id1BmY21WS0NrWXdRVG8wVll2UjEzeVl5bDVhWnFDQXZ5NkNjeWNH?=
 =?utf-8?B?WWYxaW1TYWxKMFB2TU5sbVJscDBuamlJT0F0UTVoR1pxZ1BTWW1pRU1xU2I4?=
 =?utf-8?B?YnN0Y0E2Q3JSTlFpQVE1NEthUkJaUDlZQTZGOTJjZTJsRzZ6cnNGYjNqUTlV?=
 =?utf-8?B?NUdkdEk1WTlhNjI2MFdrMkhHN2pkb2FSZlQ3aEhPYjVvMUVxcXVQMml4bnRU?=
 =?utf-8?B?U2FlMTdYbjZZQTNHbkZvMjlheHRKbEZReEM5bWRRbnd3ai9qczY0RG40UEVr?=
 =?utf-8?B?b0FBRUJaNHNwT2VJUVg3dTF6Vk9FdVlSSUpBdGswQklMajhKTFRsNDR2QzVY?=
 =?utf-8?B?TE0wWnpJOTRGUVFxSVpGalpYUDg3UXFJMXVEalY1YjhDdmJqTDdQRXJINE5B?=
 =?utf-8?B?MVFWTWVlVEVvQmdUakZLcENKTDZaSjZoQlRpd3Q4cklCSHA5aVhtS0lQTDJw?=
 =?utf-8?B?eHhCTnpQTmNGaUF3Q2pCUkNHNEZOWUtFRHgvTTV5MUlhRTVPc1EzdWcySFN2?=
 =?utf-8?B?SUZuNHV3UEQxZnlzK3JlMnBENFo1bWkyU0VKMUhzNnp5Z0Z5dEs1U3M0eG5D?=
 =?utf-8?B?V3g0bHJIczVNd2hpT2ErZ0RLUzliL3M2UUV5ZXVVZ2RRdTBad0MwSitTSmxC?=
 =?utf-8?B?ci9vcm8zRTZvUERkYTlsQ0RNdTMwR3JnMnJxcVE2Sm53ckxCUHR2bzlheWJv?=
 =?utf-8?B?SG9pV0J2R1JNSFNiVTdzRkQwR0RRU0NjQlpJU04vaC9Td2dBckt1eTd5cW9v?=
 =?utf-8?B?eGE4akRsYWUvUElZK0VTeEVGL3JtU01lNWZYbmV1VDBGdkN6SnprT3ZOS29H?=
 =?utf-8?B?bHRwS2RuYllWc2ZQallzcE03QjRwN2NZdWtuVWE2SEl6TDViVXNVV1FZQ3Ix?=
 =?utf-8?B?engxRTdBUzEvbDl1UDNsalFtNWtWc0ZiYVBUKytjMlplZ1R3SG1ZTzdraTJE?=
 =?utf-8?B?MHNkUUV4TE9nOXRvNEgwYkF6dFZPaXdHTUgxcENVTzVFNjFZbGtPM1pjdllo?=
 =?utf-8?B?Mi9IRlFKbnhRNEptSXVrRU11WnVLQzdDTjZWZ0U2bFZLK1k2MW15THl3dWVO?=
 =?utf-8?B?WDdjdmRsZUFKZU1QTFhLQkVtUjBWYWxtbGZCTWZRcEJuZTVFQS9YZGV4TWZS?=
 =?utf-8?B?d09lSWdSeGtXcXB1ZUJEeFZmN1dOMGRMek5jOXhoRUVpcmhMOWhDYzZPWmV2?=
 =?utf-8?B?YjFabXBWWmVYOU5QU2xVNWp6NklicUNqNkdZQ2YyUlJMMkJDcDlJeENKSE9M?=
 =?utf-8?B?UmM5RTVob0hibWJkTFpOSFo2eXc2VnJBQWhtWlNxVHMvREs0YVRoekZOaFVV?=
 =?utf-8?B?UTN3RStZY1VDMWxjVTBzVW1vcmI0K3BPWmdtWGJMbCtqaFdicm1nK1h4Rzln?=
 =?utf-8?B?SUNDSDM4MlhuaTVleDdMQWZTRVZlQS9QQXgxaVlsSGhtVXg2VmJGcFhoRlcx?=
 =?utf-8?B?Z0RlTGErcHpDYU1MaXJHYmNHQlMzWGZWRFZYS2FMNFlHV2J0ZDRHUHB1SWhT?=
 =?utf-8?B?ZkJtall6Qllrd05UMGR1V05RR0YrckVzOE1yOFNUYytRWE1OS3ZtSHY4WW9u?=
 =?utf-8?B?TE9RY2xiYit3bVg1QmRWUlEwTW43VXVMeGE2bXpOZ29OZjkyaGJDRHVRZnNj?=
 =?utf-8?B?eXF0YmpOc1VXanI4SExvdi9uRFZiZU5xUkhKOFNrV1JoL0d5WWQ5U3dpZjl3?=
 =?utf-8?B?RVkyK1ZqVVhWVXlxNWVsQWpHaUw1RkhDcE1qQ2h2YWZuVWhkVVVDT1llWmhY?=
 =?utf-8?B?VEpyMVJHako3YjJOU1RRT2pPbVV2VGhsY2NwUXZ0VlUxaUNucHhiRTZ1d2R4?=
 =?utf-8?B?TVdtYWY1MW5WTk1oeTJqR2NRdE9BbU54Y1p4WnBrcE5VZ045RWZ5cUh6VjFI?=
 =?utf-8?Q?2pQSQR7Fy11e281LXDEzjw5Zt?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ce58c11-ccc2-44b8-6397-08de1eb8e069
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6048.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2025 11:20:52.4574
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 36mnl9oIQQ101XIKiwyLq+yKrKVvEN5e7J3Du5EY8H5BcuALCJ8g+SA/yxXvNdhTr/SgPbO4P8CIhskTHNINCw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB9733

On 11/7/2025 2:04 AM, Jason Gunthorpe wrote:
> report_iommu_fault() is an older API that has been superseded by
> iommu_report_device_fault() which is capable to support PRI.
> 
> Only two external drivers consume this, drivers/remoteproc and
> drivers/gpu/drm/msm. Ideally they would move over to the new APIs, but for
> now protect against accidentally mix and matching the wrong components.
> 
> The iommu drivers support either the old iommu_set_fault_handler() via the
> driver calling report_iommu_fault(), or they are newer server focused
> drivers that call iommu_report_device_fault().
> 
> Include a flag in the iommu_ops if the driver calls report_iommu_fault()
> and block iommu_set_fault_handler() for domain's of iommu drivers that
> can't support it.
> 
> Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>

Reviewed-by: Vasant Hegde <vasant.hegde@amd.com>

-Vasant



