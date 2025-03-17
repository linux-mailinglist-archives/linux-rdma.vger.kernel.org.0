Return-Path: <linux-rdma+bounces-8760-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 25F22A661AA
	for <lists+linux-rdma@lfdr.de>; Mon, 17 Mar 2025 23:31:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3BF233A990D
	for <lists+linux-rdma@lfdr.de>; Mon, 17 Mar 2025 22:31:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84717205ABB;
	Mon, 17 Mar 2025 22:30:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="OBiZbwbH"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2065.outbound.protection.outlook.com [40.107.212.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EE6A1CEAB2;
	Mon, 17 Mar 2025 22:30:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742250654; cv=fail; b=E1oOV0U84ggfkkwH21S6ofZWn5jhIE66wOc0nTMTyJ5QyhlrQpc8ldtJExl2q6Neu9PVyfPPCZiXpPXZHmjEVIOQgIivgOWaggx7TnkGEfcFKh83MwXxsq4c49VJ3ajMWphhoaM1H+7fFJKHLGcHG0AP5KrejPpxHbsmQcSewRI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742250654; c=relaxed/simple;
	bh=u9kMa1C0L5Cl7fCoNqAJRxEjvGU1RfP2lpFhkqcUhi0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=p5049sHl/mf0eDjW5F2NA9qnX6mrsX7obZmpWup3eHnnFVGxBflvtaO4G/AZFwrANIq2RdMOIHhC44dN7DUgo6lVaWCK2MpIhh0KNoAki4sYRw1rxXEZORcnDvf6ojbgHa5zcxTLGKbWnHGKnzm6aY11kf15qQAGQX92Ho2TN4Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=OBiZbwbH; arc=fail smtp.client-ip=40.107.212.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uo9sTiIee5I8w0vGltOv8U1pzjXTWq/ISRiP7etoXHjYo4XjGGZ6HPE+vQ8gqrQgSYEX3Cxvt/clFnVZsRCr0TXGe16Y/9BeJqQ97xmH37qRBL5VqWdy5c8t+sboIwQ1SnOaedMXebyG9OYz/UxmFu6UQpu7Lw2fnjOn129Qu7Ue3ev2cBcAoD4Y7f/v3k/7lpFj9CUxl6Gl8y2lFwKP7ktUjlODQoOWmFFm1uBl+IX8rfjQjvMztkpHzTUA6m5OVbw4pmRUNoLS5cP26yMlOIkFVM/FjORMMWMF0eiqPyy4+XuIPWC1lxNbdlEfguTV07Q56TFFrAOwEnmbEN4ORQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w1EOVWKrre7p3b6SCwPI832E48TFEZesilW0X64S1r8=;
 b=ojAzoV8O8492WwfeipI34cVQQAX1XRpnPgENrdh/9qPRrMFhilYW5l+vYyF5irqG5ePukgAUxjH/Y3FxWBM4bmcy0U++iFx9Fp4pdWzGkl61IVNFDKgQwTDdEtsSMLJk/tlyAMDqt/3rpg5m/e9uYbstokH1l4GDA3VqXIM9NtRA0mjE5AtaSJXiEyx7dz+tQxtBCN77HSeNKcIEFl+rliW8uhpRFiu2r5F/vD0lX/3d+SYG/5Ty6Ql5CnciIkbNyMBhQtA0j61XHeyH3Syra4RcLpYf2+VgGVsRth00lJPGAX3aa2ZhjX1LJei6X72F/0Up4RlcrBwuY9P119m9YA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w1EOVWKrre7p3b6SCwPI832E48TFEZesilW0X64S1r8=;
 b=OBiZbwbHGt/D7ND0jox3b9e0rbmG033Qerwj2IfjEVt81bDPuKGcEf8mi6H0Ift8Agh2gExa2bvdj8lgrTelDM1Az8lIug9eMd9QxX9MiORhtit/op27dtMkHiS/yMN18sVuAc3xzrP/70XKJWJHRp3g5vXbjXN3LUNP0MNuovk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB6583.namprd12.prod.outlook.com (2603:10b6:8:d1::12) by
 BL1PR12MB5779.namprd12.prod.outlook.com (2603:10b6:208:392::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8534.33; Mon, 17 Mar 2025 22:30:46 +0000
Received: from DS0PR12MB6583.namprd12.prod.outlook.com
 ([fe80::c8a9:4b0d:e1c7:aecb]) by DS0PR12MB6583.namprd12.prod.outlook.com
 ([fe80::c8a9:4b0d:e1c7:aecb%5]) with mapi id 15.20.8534.031; Mon, 17 Mar 2025
 22:30:46 +0000
Message-ID: <6dc6a934-e896-45c3-b74d-6adf0ba1e258@amd.com>
Date: Mon, 17 Mar 2025 15:30:43 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/6] pds_core: specify auxiliary_device to be created
To: Dave Jiang <dave.jiang@intel.com>, jgg@nvidia.com,
 andrew.gospodarek@broadcom.com, aron.silverton@oracle.com,
 dan.j.williams@intel.com, daniel.vetter@ffwll.ch, dsahern@kernel.org,
 gregkh@linuxfoundation.org, hch@infradead.org, itayavr@nvidia.com,
 jiri@nvidia.com, Jonathan.Cameron@huawei.com, kuba@kernel.org,
 lbloch@nvidia.com, leonro@nvidia.com, linux-cxl@vger.kernel.org,
 linux-rdma@vger.kernel.org, netdev@vger.kernel.org, saeedm@nvidia.com
Cc: brett.creeley@amd.com
References: <20250307185329.35034-1-shannon.nelson@amd.com>
 <20250307185329.35034-3-shannon.nelson@amd.com>
 <68c66882-3a91-4843-b08e-2f9d5d2d0290@intel.com>
Content-Language: en-US
From: "Nelson, Shannon" <shannon.nelson@amd.com>
In-Reply-To: <68c66882-3a91-4843-b08e-2f9d5d2d0290@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY5PR16CA0030.namprd16.prod.outlook.com
 (2603:10b6:a03:1a0::43) To DS0PR12MB6583.namprd12.prod.outlook.com
 (2603:10b6:8:d1::12)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6583:EE_|BL1PR12MB5779:EE_
X-MS-Office365-Filtering-Correlation-Id: 8cf5cc07-e896-48a6-cfc0-08dd65a35c84
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|366016|1800799024|921020|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?azJnT1YxVnpkT0hnS2x4Y3N5MDNSTTlybHg0V2xyd2YwMGR4RTJuT2krclNv?=
 =?utf-8?B?aWhnWjl1QU56MzY4WTQwa2hubjB6N1pPNmxuMmQ4Y3JXa2dOZEZUUHdUamNt?=
 =?utf-8?B?VFFkUW1wbnUzY0REUXZXWVp1ODJsSFUxemNxZE5vNjlJT1dvR3Y2VS9ET0U2?=
 =?utf-8?B?TjMrcmkxQVVkblRSRHEwOENxc2lHSEdIczdvNEJYWmU0UGw4c0dFK0gvNUpI?=
 =?utf-8?B?UExtL1NFTVFYSFkxMjFpeGZMbzJtTTI5QXdZUTRRTmhtYm1ZNFpiL0tjWFNo?=
 =?utf-8?B?R0NLcWtmcXhkNGZoRExYZzlVcTV3WDlWN1JNVGJXRVQ5R3F4ZUN4RFlITDRZ?=
 =?utf-8?B?bFJubnRuYXJPdE5obkFsZUxsRExSUFNxVVlQOFA3eVEwUVM5Qy9hWUJweVk2?=
 =?utf-8?B?NDZQKzUyN0Jubis1bnZkZzU4R1ovYzdTRmFOYWpjcmErZXlHZlV6SEFIeFF6?=
 =?utf-8?B?dVZGRnFjKy9LL1F1Y1FCaGlFV0diY3d0NHg1RGtQWWVwd2R2eTRJU3NwVkhT?=
 =?utf-8?B?V25xRGFHZWY2YzBQWVlVQUcycHE0SjNaUU5jdmgvczREZ3NtZGtKTkxVRlVt?=
 =?utf-8?B?OUZ6djdURWZvK3V2ZFZkNlNJYTRqcUxMZml5dmZTcWpxS0RZekNpMDNITDZF?=
 =?utf-8?B?bHE3Z0xPNmJlbm9FWUd0SjJFM3VQdkpZUU9QeFlqWGFyVCsweWgvSXZvMk5G?=
 =?utf-8?B?N1Zab3J0QkdHWnNIR3lzQU1kQnJUQjQ2S0kwYXRvRlhvaDIvTU9tRUF2enIz?=
 =?utf-8?B?V1AvaTdoRlRuMkJQejBNczgxcXZpa2ltVlpRYXV6OXlSMkpRZU0zdXBaTG9L?=
 =?utf-8?B?VFBIbnRKYi9pVW5uYU5PM0RVZitYdWxhTTlibjlmZktFR1RIREtxWlBOQStF?=
 =?utf-8?B?aVhNb1hYOFQvWUszU0RteUxwNUJiS1ZjMlhHVWZ5SWtGTHIzRUp4UFFOQjZN?=
 =?utf-8?B?M1JLRGVqU1hFcEVHejZyWlVjZndkZUZKVnBlNDNrZWJtYnlOVndLdTZnSG1a?=
 =?utf-8?B?MmZIRWs4MWU0ZW9tSjNkZVQ3cFk0K0JMYW13bWJ0U2xJOG9wQU85S0hxMmhz?=
 =?utf-8?B?eTZpVldCSkpRMGlVNlZkdDJleEI1cXMzOVBqR2VnTzl5NmZHN3k2Q2k3MTl1?=
 =?utf-8?B?RTFkSWl4ekp0eEZwN24wK0Q5TW91ZllEYnNmd0ozSUlDZkpmSTh5YjNwTmRC?=
 =?utf-8?B?ZEZJanZMNFJCa241MkNMdkNmT1V6blBPa2RmWSs5THRsalcxemFCOUUxcVYx?=
 =?utf-8?B?dGhXaUxkMGsvSVVCZndDSm95SkhQWlVsVFJidFF1TTJwZE9NUjdYQ2JXaTJH?=
 =?utf-8?B?aXNEVndnelFYUmNZa0hPK0ZCTURYYzUwYllDcTdzSG9xWWpXS0Z6Rm9GQk4w?=
 =?utf-8?B?NkswUVBYZEtxWGlhVmo5aXVXMkhyOGdKME9MUGg4UTEvK0tRYm5vek5MVkZn?=
 =?utf-8?B?MFM2NEFVaTVrY2puNkpuTFV2OWlyZ2R1OWtNVndvQlU5dUFjV25jb0FZSlhI?=
 =?utf-8?B?R2dFYjFnLzF2SFFaMmdyTWZqcWgvK1VoblhUbzhGVkZ1dmNOQ0RhVW9OamNu?=
 =?utf-8?B?bW1pMEhBVncrQkRBcTh6OXV2OTRlMS9pTi82bzZGb2NnNEMwT1BnNThLcDIv?=
 =?utf-8?B?eVVpVnkxdXEweW1CUk5GTjU4UFBzMUFMWGpPcnArenczRERENGI0R3BJRzNo?=
 =?utf-8?B?YVZ4TWZCditBWlBGelR2SFpueUxHVXF6dkFlRkI2S3BQRmd2Qnc0TGxYQUIv?=
 =?utf-8?B?M0NoRkpHbmxuL1NERERxeHU2NDBlT2p6QzVhNkRDckoyck9Fb1A4S0lTMW8v?=
 =?utf-8?B?T1hmMkd2Nzh0dUFtM1B3WWtXbW85TzArZiszRXRBMTVFaUFiYWFsWks0Umxx?=
 =?utf-8?Q?w8DRSQuUlFpTe?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6583.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(921020)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VzNZL3IzVUx6SDZRaDRHdVlaeU9LWk9vc2U5dHFtNThhM0JvRVNRTUxDbExX?=
 =?utf-8?B?eC9vQStqeXk4M09na0dDdHJrWHRKaGNxd1MvSGJJMm1IMTJOMDZrZW1rbGRw?=
 =?utf-8?B?R2RyVVFRcHJ0T2hON3l6WUdUc29ub21TTldHbUlqalc3MzM3eG5JOVU5RjJH?=
 =?utf-8?B?cG0xUzhPSnJIQ2VNOCtzMzdMZGJ2eVRNWWVsZ1o2TFRDSDBHc0tMcG1aOU5U?=
 =?utf-8?B?Ti9xbnFGSGk3RXdoNStMVFhyYnI0S1lCVEV5RVBpdVVQendBTjlQeTVKTS9n?=
 =?utf-8?B?YWk2UVJWZ3RraDhsV1l1eWkxaTh0V1I1eU5sMytmYUp1NjNyU3ZWbVZzMTdD?=
 =?utf-8?B?WFVwM0pnWWVWVkJwelJpZWN0OXZFbXFMWk5MckJPSmdRbXh6YUNHbTJYNFUv?=
 =?utf-8?B?R1pTb3p3VU5PQ1NrWGZkMlQvb0Mrbkw4Q1hHSkoxcFFNeWcyR2l4b3c3Sisv?=
 =?utf-8?B?dHFJdDk4elNzV0NoT1RkUWVBQ1djRys2dG5WV09kOTBpN2Fzb3RjK3JxUnpi?=
 =?utf-8?B?dlRaV05ZdWJxL1pjaEdNUjFQOGtPamVsZ2FmTTFPVXM4cmsyYldXVHpLdkFl?=
 =?utf-8?B?dkRvbFpNME9kQ01BaUF2WElPQ0pGNUtwVEkrdDJ2c21XckFYZy93UFB1aXA3?=
 =?utf-8?B?K0tNcW5IaUE1OWRGNlR5clBKOWdEZzFuNldaaWVCdW52ZW5hNDAzZVE5VXZi?=
 =?utf-8?B?eGxxZ1B0U3Z3VkllWWZDcEdkRWdzTUtsbXQvY1owL0xZL2EvV05QWjdqbVoy?=
 =?utf-8?B?WmNGdFB0OFRqVTNsVzBiOEU5Y1NFUGZHckcwLzJ2dWl2Rk1RN2Y2ZUFpNkZn?=
 =?utf-8?B?bzN2Rm9TbnY5VVY2NUdSQUpKQTUrODBWRktsN0ZIUUdvTXBVbWh2OUVlZFM4?=
 =?utf-8?B?YkMwZzlnUUFMaXVaQlRMNmk4emhscTFHYllOb1hmRUFSVmQ4T0gzODgxbHpU?=
 =?utf-8?B?M0t4cFUxSExHM0U0dlB4SWhvT2drbHR0UndpUFJwQmxoaFR0cGVVekNaTGZa?=
 =?utf-8?B?NmhkMVc1QmpabUo2TlBRN0VJblZzK01BTy9BR1NzMmh6bTAzY2VIK3M4UTFy?=
 =?utf-8?B?c3orSDlTaDZYSHBQRENURFhkUHBwR1I3b2Q1YldxQ04wUDRTT0tpd1NabmVX?=
 =?utf-8?B?R01sWXNRVXVTMFJudUZDMUptenlzTUdiRmE3aWVKUEZLQi8vQUlTNUtpZ0NX?=
 =?utf-8?B?TDVXeGJmYTcwUnhNOVNuTnB5M0N2b25heXREVU8rYVdWNVl1RE1nTWtIS3ZK?=
 =?utf-8?B?Z1pkSGc0aU9PZnR0NlJKNVU4SzAvWEtCUThlZGhRQWYzMVZSYTg3MzlFc3Nj?=
 =?utf-8?B?QUpBSjM0dFJSWDZwekZqYUtBb1lBRE1SY3lHMjlVdDdKdGV6bEtSaCt5Wktr?=
 =?utf-8?B?R21ZUXRTZ0Fta1dhSWI4d0hZaGZ5ZnNLMDVCcDZWQmRxZm82d1RWTkxxa000?=
 =?utf-8?B?UStoaEQ5bmxkUmNBTjByNi9kbW1oeitNZGVxdGFNeXRuY3NMcUdzWU5rS3cy?=
 =?utf-8?B?RzZMTjk1dlgybkxWbEtsRXFNNTU0aXRqKzRzbU5Kb3ArUGhmejlVcTZjbXBG?=
 =?utf-8?B?YWpOOTRKSkFjSkxxT3dVemwwblp1SUlRSDdsa1lLTXk1Y3FqMnlTMzdmNlJZ?=
 =?utf-8?B?YTV6ekpvTHBYVmNDYm1xdmRPN3d2UDFLdG1DUkxYVHV4UCtHR1FqTmYwQzF4?=
 =?utf-8?B?cWt0N1pWR2JoNC8rOU15ZGZhaWw0Q2hocHd4ODRjY25EN200V0Y4RVZZejRQ?=
 =?utf-8?B?UGdJUURucFY5aVM4bDBHQkVHQlFWNnVlZ0NIaml5cW9NZmNHNDZtTGVEMm5E?=
 =?utf-8?B?T1RmMnRlUzB5QXVGTXZ6UXNnZ0FqWEtmT09yVGJhT3RkMDJ4N1hCcUZiZ0ZH?=
 =?utf-8?B?STlFcWwvNEFwZzN2UWVYUEhvNWNmbFp3ODYyQ0V4RzVDeWVhNWcwTG5QZnJ4?=
 =?utf-8?B?SlNCS25mejhzQnFMTnlyUnpNRm1iZDFZejFRQjVReklHdTJrS3FoZUVWcjlQ?=
 =?utf-8?B?bEhGcDVSZC9NZXZhZFV1Y3dYaHd3NnMzWExaTlNleitNcHBNeDFlQWJqMGRN?=
 =?utf-8?B?cW0ydHd1VDk2Qjd5S0RiYU9NNjlSaHJQVjFaRFZtVi9KRmlYdFJRbzNydGRz?=
 =?utf-8?Q?/QvqY1P7i+DY5p27wFwFW2JuV?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8cf5cc07-e896-48a6-cfc0-08dd65a35c84
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6583.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2025 22:30:46.4996
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GIUlBe8jEyYHZCDxQcNaS4HxpW1cNZkEfKM+/iduRNZqP38RbeCgSXN5LrbNWUgB/fn2NbgHofRO2PajDKVUMg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5779

On 3/10/2025 10:26 AM, Dave Jiang wrote:
> 
> On 3/7/25 11:53 AM, Shannon Nelson wrote:
>> In preparation for adding a new auxiliary_device for the
>> PF, make the vif type an argument to pdsc_auxbus_dev_add().
> 
>> We also now pass in the address to where we'll keep the new
>> padev pointer so that the caller can specify where to save it
>> but we can still change it under the mutex and keep the mutex
>> usage within the function.
> 
> Please consider changing the commit log to use imperative language and avoid using pronouns such as "we".
> 
> https://www.kernel.org/doc/html/v4.17/process/submitting-patches.html#describe-your-changes
> https://kernelnewbies.org/PatchPhilosophy#:~:text=Please%20read%20that%20whole%20section,it%20into%20the%20git%20history.
> 
> Maybe something like:
> Pass in the address of the padev pointer so the caller can specify where to save it. ...

Done - thanks,
sln

> 
>>
>> Reviewed-by: Leon Romanovsky <leonro@nvidia.com>
>> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>> Signed-off-by: Shannon Nelson <shannon.nelson@amd.com>
> 
> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> 
>> ---
>>   drivers/net/ethernet/amd/pds_core/auxbus.c  | 37 ++++++++++-----------
>>   drivers/net/ethernet/amd/pds_core/core.h    |  7 ++--
>>   drivers/net/ethernet/amd/pds_core/devlink.c |  5 +--
>>   drivers/net/ethernet/amd/pds_core/main.c    | 11 +++---
>>   4 files changed, 33 insertions(+), 27 deletions(-)
>>
>> diff --git a/drivers/net/ethernet/amd/pds_core/auxbus.c b/drivers/net/ethernet/amd/pds_core/auxbus.c
>> index 78fba368e797..563de9e7ce0a 100644
>> --- a/drivers/net/ethernet/amd/pds_core/auxbus.c
>> +++ b/drivers/net/ethernet/amd/pds_core/auxbus.c
>> @@ -175,29 +175,32 @@ static struct pds_auxiliary_dev *pdsc_auxbus_dev_register(struct pdsc *cf,
>>        return padev;
>>   }
>>
>> -void pdsc_auxbus_dev_del(struct pdsc *cf, struct pdsc *pf)
>> +void pdsc_auxbus_dev_del(struct pdsc *cf, struct pdsc *pf,
>> +                      struct pds_auxiliary_dev **pd_ptr)
>>   {
>>        struct pds_auxiliary_dev *padev;
>>
>> +     if (!*pd_ptr)
>> +             return;
>> +
>>        mutex_lock(&pf->config_lock);
>>
>> -     padev = pf->vfs[cf->vf_id].padev;
>> -     if (padev) {
>> -             pds_client_unregister(pf, padev->client_id);
>> -             auxiliary_device_delete(&padev->aux_dev);
>> -             auxiliary_device_uninit(&padev->aux_dev);
>> -             padev->client_id = 0;
>> -     }
>> -     pf->vfs[cf->vf_id].padev = NULL;
>> +     padev = *pd_ptr;
>> +     pds_client_unregister(pf, padev->client_id);
>> +     auxiliary_device_delete(&padev->aux_dev);
>> +     auxiliary_device_uninit(&padev->aux_dev);
>> +     padev->client_id = 0;
>> +     *pd_ptr = NULL;
>>
>>        mutex_unlock(&pf->config_lock);
>>   }
>>
>> -int pdsc_auxbus_dev_add(struct pdsc *cf, struct pdsc *pf)
>> +int pdsc_auxbus_dev_add(struct pdsc *cf, struct pdsc *pf,
>> +                     enum pds_core_vif_types vt,
>> +                     struct pds_auxiliary_dev **pd_ptr)
>>   {
>>        struct pds_auxiliary_dev *padev;
>>        char devname[PDS_DEVNAME_LEN];
>> -     enum pds_core_vif_types vt;
>>        unsigned long mask;
>>        u16 vt_support;
>>        int client_id;
>> @@ -206,6 +209,9 @@ int pdsc_auxbus_dev_add(struct pdsc *cf, struct pdsc *pf)
>>        if (!cf)
>>                return -ENODEV;
>>
>> +     if (vt >= PDS_DEV_TYPE_MAX)
>> +             return -EINVAL;
>> +
>>        mutex_lock(&pf->config_lock);
>>
>>        mask = BIT_ULL(PDSC_S_FW_DEAD) |
>> @@ -217,17 +223,10 @@ int pdsc_auxbus_dev_add(struct pdsc *cf, struct pdsc *pf)
>>                goto out_unlock;
>>        }
>>
>> -     /* We only support vDPA so far, so it is the only one to
>> -      * be verified that it is available in the Core device and
>> -      * enabled in the devlink param.  In the future this might
>> -      * become a loop for several VIF types.
>> -      */
>> -
>>        /* Verify that the type is supported and enabled.  It is not
>>         * an error if there is no auxbus device support for this
>>         * VF, it just means something else needs to happen with it.
>>         */
>> -     vt = PDS_DEV_TYPE_VDPA;
>>        vt_support = !!le16_to_cpu(pf->dev_ident.vif_types[vt]);
>>        if (!(vt_support &&
>>              pf->viftype_status[vt].supported &&
>> @@ -253,7 +252,7 @@ int pdsc_auxbus_dev_add(struct pdsc *cf, struct pdsc *pf)
>>                err = PTR_ERR(padev);
>>                goto out_unlock;
>>        }
>> -     pf->vfs[cf->vf_id].padev = padev;
>> +     *pd_ptr = padev;
>>
>>   out_unlock:
>>        mutex_unlock(&pf->config_lock);
>> diff --git a/drivers/net/ethernet/amd/pds_core/core.h b/drivers/net/ethernet/amd/pds_core/core.h
>> index 631a59cfdd7e..f075e68c64db 100644
>> --- a/drivers/net/ethernet/amd/pds_core/core.h
>> +++ b/drivers/net/ethernet/amd/pds_core/core.h
>> @@ -303,8 +303,11 @@ void pdsc_health_thread(struct work_struct *work);
>>   int pdsc_register_notify(struct notifier_block *nb);
>>   void pdsc_unregister_notify(struct notifier_block *nb);
>>   void pdsc_notify(unsigned long event, void *data);
>> -int pdsc_auxbus_dev_add(struct pdsc *cf, struct pdsc *pf);
>> -void pdsc_auxbus_dev_del(struct pdsc *cf, struct pdsc *pf);
>> +int pdsc_auxbus_dev_add(struct pdsc *cf, struct pdsc *pf,
>> +                     enum pds_core_vif_types vt,
>> +                     struct pds_auxiliary_dev **pd_ptr);
>> +void pdsc_auxbus_dev_del(struct pdsc *cf, struct pdsc *pf,
>> +                      struct pds_auxiliary_dev **pd_ptr);
>>
>>   void pdsc_process_adminq(struct pdsc_qcq *qcq);
>>   void pdsc_work_thread(struct work_struct *work);
>> diff --git a/drivers/net/ethernet/amd/pds_core/devlink.c b/drivers/net/ethernet/amd/pds_core/devlink.c
>> index 4e2b92ddef6f..c5c787df61a4 100644
>> --- a/drivers/net/ethernet/amd/pds_core/devlink.c
>> +++ b/drivers/net/ethernet/amd/pds_core/devlink.c
>> @@ -57,9 +57,10 @@ int pdsc_dl_enable_set(struct devlink *dl, u32 id,
>>                struct pdsc *vf = pdsc->vfs[vf_id].vf;
>>
>>                if (ctx->val.vbool)
>> -                     err = pdsc_auxbus_dev_add(vf, pdsc);
>> +                     err = pdsc_auxbus_dev_add(vf, pdsc, vt_entry->vif_id,
>> +                                               &pdsc->vfs[vf_id].padev);
>>                else
>> -                     pdsc_auxbus_dev_del(vf, pdsc);
>> +                     pdsc_auxbus_dev_del(vf, pdsc, &pdsc->vfs[vf_id].padev);
>>        }
>>
>>        return err;
>> diff --git a/drivers/net/ethernet/amd/pds_core/main.c b/drivers/net/ethernet/amd/pds_core/main.c
>> index 660268ff9562..a3a68889137b 100644
>> --- a/drivers/net/ethernet/amd/pds_core/main.c
>> +++ b/drivers/net/ethernet/amd/pds_core/main.c
>> @@ -190,7 +190,8 @@ static int pdsc_init_vf(struct pdsc *vf)
>>        devl_unlock(dl);
>>
>>        pf->vfs[vf->vf_id].vf = vf;
>> -     err = pdsc_auxbus_dev_add(vf, pf);
>> +     err = pdsc_auxbus_dev_add(vf, pf, PDS_DEV_TYPE_VDPA,
>> +                               &pf->vfs[vf->vf_id].padev);
>>        if (err) {
>>                devl_lock(dl);
>>                devl_unregister(dl);
>> @@ -417,7 +418,7 @@ static void pdsc_remove(struct pci_dev *pdev)
>>
>>                pf = pdsc_get_pf_struct(pdsc->pdev);
>>                if (!IS_ERR(pf)) {
>> -                     pdsc_auxbus_dev_del(pdsc, pf);
>> +                     pdsc_auxbus_dev_del(pdsc, pf, &pf->vfs[pdsc->vf_id].padev);
>>                        pf->vfs[pdsc->vf_id].vf = NULL;
>>                }
>>        } else {
>> @@ -482,7 +483,8 @@ static void pdsc_reset_prepare(struct pci_dev *pdev)
>>
>>                pf = pdsc_get_pf_struct(pdsc->pdev);
>>                if (!IS_ERR(pf))
>> -                     pdsc_auxbus_dev_del(pdsc, pf);
>> +                     pdsc_auxbus_dev_del(pdsc, pf,
>> +                                         &pf->vfs[pdsc->vf_id].padev);
>>        }
>>
>>        pdsc_unmap_bars(pdsc);
>> @@ -527,7 +529,8 @@ static void pdsc_reset_done(struct pci_dev *pdev)
>>
>>                pf = pdsc_get_pf_struct(pdsc->pdev);
>>                if (!IS_ERR(pf))
>> -                     pdsc_auxbus_dev_add(pdsc, pf);
>> +                     pdsc_auxbus_dev_add(pdsc, pf, PDS_DEV_TYPE_VDPA,
>> +                                         &pf->vfs[pdsc->vf_id].padev);
>>        }
>>   }
>>
> 


