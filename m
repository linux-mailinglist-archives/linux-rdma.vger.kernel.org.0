Return-Path: <linux-rdma+bounces-11941-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 97666AFB9B5
	for <lists+linux-rdma@lfdr.de>; Mon,  7 Jul 2025 19:16:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 34DB01AA3C81
	for <lists+linux-rdma@lfdr.de>; Mon,  7 Jul 2025 17:17:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4709C288CB7;
	Mon,  7 Jul 2025 17:16:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="n5/J8HNZ"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2086.outbound.protection.outlook.com [40.107.93.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9783C2264A0
	for <linux-rdma@vger.kernel.org>; Mon,  7 Jul 2025 17:16:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751908599; cv=fail; b=aIF1Uja+OT97J7OVBvGfqsd4l2cUkQuzLByAQDSfcSgXSBVp0Wg92njoI21orNeyYXjibaz7WIp3CLQn4qpyB7Giq1fAK0mWMmVa5Hbc6NOW4rKYaEPaQ1Xi4oKIU6cP8utIPpfoCo7cMv+oIicw3Vb7LJ4I0fMuCX1n2b3c/7U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751908599; c=relaxed/simple;
	bh=+4su68TaGIMIxBzW2Z1GBWzr7ZWyNMstDwxbpcO/xCc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=p9ULP/JzryoTSV4+6BeuWkwEf2skBBbKvfCEDgPbaPuQ8+MqwTSeeRsVXT2u4GNFher7ZkVhwARUV/7lPuWfGDFuvZ6TjoZ2EcoQZJ1i3oaxy1jEKoYH6yHgkI/1zJGBHHebDjnW5M+TYNhN9mSpi8x/I7RKtx7oIcfVKX+hcAQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=n5/J8HNZ; arc=fail smtp.client-ip=40.107.93.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SpnC+U6fy23BnbE8OdxcC0n+1o4XEVtzneED3yDarUxod+lW7N563hK+Wh5+FSOo2SiPIb1Xh1Yasj7/QR62PPfSAenZkI5DPkECc0eqtqGhu1W+YyesZbxY2E8nLBT6WFR+l4HyAVHSb/oJfZYznR4bkO9Anu/y5uRkd5fHKZDyu6tjpD8Jukk43C4EslZKr02Lw9PC7b2JLkxZz+msFHpwsj68yPDg76bNq0o1m7A4BiBgF+B0EHRVOFoPXOoBky84AI/U89a/+qZnVEn8zvHn11jkIJpZzvZ5rIjdNVEK3DiKp0bkGUjiG0+a2sTPKqLWBbtWzHY99SsT5/abmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FDGwgBuKmeQUGnpbpxVn21bn3lMjfJMT0oFwRg9RHeU=;
 b=MguVIUtOp+ErYH0/21zJ3SUKM2L1E3wlQMvNmBdosw+UfDNFzvBFGOw+uIXz5URXbu+IAMmIervyFMU/DzNwX3N14GOY62dX/j/suywjy1AyMFm1zyUY5KEkk7n4KmaS8jAqlYhv8EaJDLhgzujhZME16+ntYXBstTSDBY+03K+tiTk0QMdaUFFM+xfT3IaqMrbDeXZ8nNhGEWX2FJzp0XZp6BMcEM+j+RnJ4NgpUjFGUxoJ90Ue39Gz57C3qh0GpsR0YE2CYOSkDM3uXfK5XQENKy9LkYJ8XJ98Zwsd+N5tdSLcoqfcJ3vJ70ojJh6Y/Ml5GMnYpc/T0j0w/sqzUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FDGwgBuKmeQUGnpbpxVn21bn3lMjfJMT0oFwRg9RHeU=;
 b=n5/J8HNZrG0pgoHevfj3KVYFUeeT2IcO9rnObkkYKwcG+nAgoYRgjjKtGnZDyhQCLZm/ay1wvI8uhTKpjUZjFOVJs5c284oANZTWKlhJcOMLxIPZtYVahH2Zwp05sIAchb68zcfeUWolRcVX1Ci4MxmHfwI8nFn9zsNhwUPxI1jGCXrV4PIZEnZ67a/y30WaXsPNN8dqF/Qn6YGNYpsCJdpyar+wst9a0CwxGVGj1QNOGpG5BEZnLL0MgzJo1SgMiu6XFc6XXrz31YVJYq8l+splvrYCL+CWV3bV6bRLYpWcNLorxxtfjr1CF73p6nWh046UGlAD4O0sap3Zw9qsvw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by SJ2PR12MB9212.namprd12.prod.outlook.com (2603:10b6:a03:563::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.24; Mon, 7 Jul
 2025 17:16:32 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%7]) with mapi id 15.20.8901.024; Mon, 7 Jul 2025
 17:16:30 +0000
Date: Mon, 7 Jul 2025 14:16:29 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: "Margolin, Michael" <mrgolin@amazon.com>
Cc: leon@kernel.org, linux-rdma@vger.kernel.org, sleybo@amazon.com,
	matua@amazon.com, gal.pressman@linux.dev,
	Daniel Kranzdorf <dkkranzd@amazon.com>,
	Yonatan Nachum <ynachum@amazon.com>
Subject: Re: [PATCH for-next 2/2] RDMA/efa: Add CQ with external memory
 support
Message-ID: <20250707171629.GU1410929@nvidia.com>
References: <20250701231545.14282-1-mrgolin@amazon.com>
 <20250701231545.14282-3-mrgolin@amazon.com>
 <20250704182804.GR1410929@nvidia.com>
 <40ae393c-f95b-41e2-81c1-d0d1e42e1eaf@amazon.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <40ae393c-f95b-41e2-81c1-d0d1e42e1eaf@amazon.com>
X-ClientProxiedBy: MN0P220CA0017.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:208:52e::10) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|SJ2PR12MB9212:EE_
X-MS-Office365-Filtering-Correlation-Id: 9210e8d7-95f8-4443-543b-08ddbd7a03f4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Y3lXM1RUdkJydUcycENWeUpVNmUxRzRwUEU3b0p6YVVGNzFmV1pzTmVEbzNH?=
 =?utf-8?B?anJ5NTN2aHEwZ3JtNG9ZdXUxVExPeWxSaHgxUDRzZDliTTVtRk9hMHBQQXUx?=
 =?utf-8?B?am1XLzQwSDE1bGtLWjlGS2hsWlRqSDl2K3V5ZmgzMU9LM1dudHdjYkNONUdQ?=
 =?utf-8?B?R0RhVUw4YmJ5Ky81UnhaeWFtVkxYOCtZdkhOTTNZYXpiZCtaMTdodEtaM2tl?=
 =?utf-8?B?VWlyMi9ZVER4aXkxNzF2a09EcW1BNWV5RFJ3SXNJbWdoSklXUHNYZ2V3WkhQ?=
 =?utf-8?B?OEZYTnJjTy9CYXM1Tm5POFJ6SlVMcHdZaWlreDN2Y1gzd2k4L1N1RThpVnVw?=
 =?utf-8?B?K3BPS05YbmtzMG05OHRNampQMFlIdjZCdzZMM1laU0ViYW1pYWg1ZVowNEYy?=
 =?utf-8?B?VHBxRTN4NlpTTnB1VVM3V3kwbDd4dTBYQmZxNCtEY1hxcXpUclZ6azFZZUl3?=
 =?utf-8?B?eFZRUXlVa2lITWhodDJLSVV3Qnd1bEVMdXFaK2FmeFFxVGZwNWh1UnpSUzlu?=
 =?utf-8?B?UEJXditjS3RRWitSdndkTzVSdm5TZldNZnpsWFR6aExHTnJ4Nm5QRHNESFM4?=
 =?utf-8?B?bnd5QlpyZER6R2ROVHd3bVhibndVRXZwdTZybnRMWmJ6aXVLcFdQcGpLekZP?=
 =?utf-8?B?dlFqOTV3eThPRDljUy9wZGpUOW4va1p3M1BrRThvc3N5QmlqSWNtOW1RVW94?=
 =?utf-8?B?Wm5rRlE1cGpTSXJHNjhNeThLU2pWa2x2NWpqSkVHLzVLRk11dVlndzJ5MXdp?=
 =?utf-8?B?c0thZ0h2TnNCYW84WFpQZG50TVdxTW5qeEtqUmFGUklZek5sVS9MM0p1Z2hB?=
 =?utf-8?B?TEZGblAwdGt2UU5pclFnSEFGQjduci9abGIzZzZpL2FieDhodjd1ejdpZVZW?=
 =?utf-8?B?SjhteFZwcnpwcENidUswZDNpY3F3UnBhejhDU1VlTllSdlpxa0xRSkN0TE0x?=
 =?utf-8?B?czNhKzlnbDRVWm5Eb2R5OFhMUmN2L3ZIdUQ4UE41QW5JZmtvNFFxRmFGSmdt?=
 =?utf-8?B?c0ZOVWF5VGRpc2J3aDRDK3lheWJ4cVE5ZjcvRkxZMWNLQitKbHJUR2VLcXJW?=
 =?utf-8?B?UWhsYUtseVFLRUJlbGJWelhhZm9pL2NiK2hBWkpwWkZFYndqK015UnF4SkZu?=
 =?utf-8?B?RWs0aFdidHJaUks3NEZUNmgzcitSd1JFN0k5a0UwSUdPQWYrV0xjUkZvaUJP?=
 =?utf-8?B?QUc5VEJjR2RFQTZNV2tYUXg3OHM2d0tPbjZSaWkwN2dZeXdPbGhBSWMyOEpV?=
 =?utf-8?B?VVRNQzl1N2VSTnBOK0xYNlNEaHp4Sm8wWmhLdXBQeUJpOEhBdE9mMDNVQjBP?=
 =?utf-8?B?UVZ5Yll5OXRsM3dzSXlBYTJaYzc0UlMxVXZ4RzNxNEg2UFVVVm5XNlVpQkIy?=
 =?utf-8?B?MnhSZ0ZRb0ZmYVNjcmVuTGNHOURkeVhyRTNwWXI5aktSU0psUURpeGFvZmZz?=
 =?utf-8?B?REdvTmw2SXFueXk2ZmVsZUVLUmZabFh0V29nVm9qRTRSUnEvMFhJbUV0Sm5H?=
 =?utf-8?B?cVp5RElPN2VHS2luL0V5QjFZUzFBVnVsS2U1OENXT3NSQlRTNFgvc1Zaa0hX?=
 =?utf-8?B?L1BxaGZsVENyR0l3SjN1SnFmQlBYdkJFRUpiRW5KMXZBYXd0ZWVKUU5GNkxn?=
 =?utf-8?B?ZVB0a2dpMFBVQWcwL2VhK1FBTWJJaFB2M0RMRHdhV1ZCVkJSMkErQTd1bWRh?=
 =?utf-8?B?Y2U3OEdJOXRnNkRzYWhJSnpqRkN4SDNseEFEN2FOMjZ2QnRib2R5RkJYUWxP?=
 =?utf-8?B?eUQ4RlhiMGRVYmt4WEI4dUdQUWo0VGt2YVJhcWFTbzhRSm1lNVBRVklZY2pm?=
 =?utf-8?B?N3M0QTkzMkJKdFlhaVJCU3Fya3c5a3ExTXFDYlR6cnBybXZ2VmJUQVhiZDNC?=
 =?utf-8?B?TXlmSmZNSGxiSW1mVHVLcEtsR2xiQ244SHJ1dkxuckkvaVkrZ2dPdmplMDNS?=
 =?utf-8?Q?EKjR+NWmpWA=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?R2M0ZWdzQ3pOVEV0OGpGdFppeXJZMm10WU1zTUR2MlRrSkJlaks5WDc3aHhp?=
 =?utf-8?B?bjVzZHJNNzhFM0txNXM4TExYL2hZbUlkc0JpK0JHUi9ZSFY1b0ErS2hRR1RF?=
 =?utf-8?B?alhIRnowZUQ4NmlsdForNXBpemdrVVR2MWpibU5hc0k2dnU0azN5Z09IY0lo?=
 =?utf-8?B?REpMUkczeko5Ukk2RnJLTjZUcG1VeC93dWt2SnRSbDdqeGk5RktScytnb0NO?=
 =?utf-8?B?OEdoRUVPUjJpREFCc01ZdVFSNklYdUNsZGloUFRmaWpzRnNZRFZqUkx4NFp4?=
 =?utf-8?B?NlAwZnhMNEMxbklEd2pFK0RZdDMzZXB3VHhOd2g4R3VKUWFBUVhmc09KOERX?=
 =?utf-8?B?N2g1Q1kxZk5aRTZSNndBRE5yTmVzRVNaVFVNU01VQURIc3FtSmtzM3BNNVI2?=
 =?utf-8?B?WkpGQzNKTTFHU0dmOWdjQ283cFRocWl6RDA5RnFEWnUxejZxRXF4WlhSR1lq?=
 =?utf-8?B?czZSMFBuMkhjSjh2Y3VRdFEza0ZRMUJjMExPdFZVQWhPOXZnbElGaWVZQVNl?=
 =?utf-8?B?R3Via3pBOGFLb1Biajl1TWtmUzVPZjJDekViTWxmZzVTN0dhYnAxTk5scXAx?=
 =?utf-8?B?NFJUajJnbkd4YUo1Si92Z0R3eTFybmNKcS94ZTNSbm94K1gzTFlCV2ZRNmhK?=
 =?utf-8?B?R2cvRXZNRzR5TUhGYmN3WUNoRVlTdEhRSkR3dllVeGRHRU9WR3dDQUEyYW0x?=
 =?utf-8?B?WjZoaFNTclVyU2ZTa280OTBKSGJYMVA0UDF0S0Z6NzBXNytBcE01U1A4bFpL?=
 =?utf-8?B?eWV3UjBFVU5NcDZSVVFxT3BpRUVKQkIwSDlGZ2Z4MzlGMWR0NCszSlNJTkZJ?=
 =?utf-8?B?N1draklvWFZqOVY3enJUWjhwcTR4WDNiYmRVZm9UUnVWVk1IZ1d1TTEyd0lZ?=
 =?utf-8?B?Ti83Ri9IdjFoWG1DTjBsRndERG10T1p4VTArRkJaaFJTU0ZEQS9CUUxUSHhL?=
 =?utf-8?B?akxqc3pkQ1JwWllYMFJaa2hmSTBhSVRCMUovN3IraU5Qb2JsN1FreGNhNlNH?=
 =?utf-8?B?UExNQVkvZWZvd2FYMDB3N3I1OUR1MEMyQnFhaHhHOXFNYm9zb2NiT2U4cUdD?=
 =?utf-8?B?Vk1YR1IyMVJObGNXR1BwSWpHQk5STk9iY1N3MDJNNHl2RC85dmlTT0lYRXRv?=
 =?utf-8?B?bzUrWnlWSUxlcjU5aUpNTExDY0ZJVG9wRHZyd2gvdnNQdGtyQ3lTTFBoTElI?=
 =?utf-8?B?c0RDM0Y3ZTVYQ0R6djFMeFhST1c2WjV6NmVLOGd4dVVTTHJzek5lU3ZWUXVB?=
 =?utf-8?B?RTQydzByNWlJQUw4LzVacU8yMGlxdldRYS9UaVNVNUJvVEk5R2V0eHRKRkUx?=
 =?utf-8?B?QjRBdUtBY3Y0UHZsMU9yd0lhR1hUbkxiRVRRTTE3MVNNZUZZS1hPaEJTeHND?=
 =?utf-8?B?VmxaRDhOYW5oU053Y3hQTHpybXN4bEdoOER5NzdVZ2kxU0xsMnMxVW5XeHI5?=
 =?utf-8?B?N01JdjhnNkxJQndjbVlyZ00wM0kyVi8vR2VzRUxxaHFqOVd0Y3lUQ1Q4NEhB?=
 =?utf-8?B?SVI0OFJsNkpsa2NrdytBblFGL1EzbHFYZWdJaWsvTVloRjRldFVIUW5vSThv?=
 =?utf-8?B?OGVzaVc5Ti9RTiswdFBDTEQ4b0tTNXRCa05lSEdSM0pOMXRQeVVvdmVJeXMr?=
 =?utf-8?B?SFBwTm1YckF3NHVadkRXWVBhU3N4Ynlac21rLytyV3dsQTF5a2pUUEErQ0J1?=
 =?utf-8?B?QzJNb0JHNHJTVzhtSmZONkYxcm9Ba1FqMWliNE84VmpNRjV6am9GUWgxQ2ls?=
 =?utf-8?B?Q3hKOXBCNGFReDZOams1RDkzbmtHNUM1SU5OMzVCNXJvRWQ0TDFaSktkaEg4?=
 =?utf-8?B?WWRDV1NQdmVLTEtkRE5aYVB5d1Q5S2ZUdVVSMlV4RDhuVDNwUW80dUUwSmNy?=
 =?utf-8?B?bGFrc3hhK1hmZjNJVzhveGNQK040dHVidHhzNko5a0dQRjJ2SCtLUDZJRE9S?=
 =?utf-8?B?bVA1R3JvVm5oWktFY25VZkhmS05yUzFlSlp6bHd6Uk9oUFg4dGZkVi9WWDEw?=
 =?utf-8?B?MlRLWTVibmxOQTRQMlBOQ0hzN0hGREdXbmVObUFTZjhWU2dpWEtFeW5HMFdq?=
 =?utf-8?B?aWkyY3ZWRGM3WlQ5QzVPa3doUmt3Z0l0ajh1aGRJeUZuQ01wQm9nR3djVHFD?=
 =?utf-8?Q?fjtY=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9210e8d7-95f8-4443-543b-08ddbd7a03f4
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2025 17:16:30.8613
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uxuo1UWGyueULyYYCjFtCfAoYIrGITddlukbHj/03hH5j0N4F6Hm40k1bh0heVGY
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9212

On Mon, Jul 07, 2025 at 08:07:43PM +0300, Margolin, Michael wrote:
> 
> On 7/4/2025 9:28 PM, Jason Gunthorpe wrote:
> > CAUTION: This email originated from outside of the organization. Do not click links or open attachments unless you can confirm the sender and know the content is safe.
> > 
> > 
> > 
> > On Tue, Jul 01, 2025 at 11:15:45PM +0000, Michael Margolin wrote:
> > > +     if (umem) {
> > > +             umem_sgl = ibcq->umem->sgt_append.sgt.sgl;
> > > +             if (sg_dma_len(umem_sgl) < ib_umem_offset(umem) + cq->size) {
> > > +                     ibdev_dbg(&dev->ibdev, "Non contiguous CQ unsupported\n");
> > > +                     err = -EINVAL;
> > > +                     goto err_free_mem;
> > > +             }
> > I'd rather see this call ib_umem_find_best_pgsz()
> > 
> > Maybe like:
> >    len = ib_umem_offset(umem) + cq->size
> >    pgsz = roundup_pow_of_two(len);
> >    ib_umem_find_best_pgoff(umem, pgsz, U64_MAX);
> >    rdma_umem_for_each_dma_block(umem, biter, pgsz) {
> >         dma = rdma_block_iter_dma_address(&biter) +  ib_umem_dma_offset(umem, pgsz);
> >         break;
> >    }
> > 
> > It turns out the scatterlists can be irregular in some cases so this
> > will handle that properly while the little test above cannot.
> > 
> > And maybe the above thing could be a little helper:
> > 
> > bool ib_umem_get_contiguous_dma(umem, &dma_addr)
> > 
> > Also I am trying hard to keep scatterlist APIS out of the drivers.
> > 
> > Jason
> 
> Some disadvantage of this approach is that if the provided memory
> is contiguous in its first "roundup_pow_of_two(len)" bytes but consists of
> additional smaller or unaligned sgl entries, we will refuse to use
> it.

I intended "len" to be large enough that there was no additional
portion that is not covered.

Jason

