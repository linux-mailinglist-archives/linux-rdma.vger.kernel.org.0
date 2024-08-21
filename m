Return-Path: <linux-rdma+bounces-4464-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EF77295A47B
	for <lists+linux-rdma@lfdr.de>; Wed, 21 Aug 2024 20:11:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1F0DF1C21243
	for <lists+linux-rdma@lfdr.de>; Wed, 21 Aug 2024 18:11:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A4DF1B3B1C;
	Wed, 21 Aug 2024 18:11:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="XbRyQMn9"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2064.outbound.protection.outlook.com [40.107.102.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D16221B3B11;
	Wed, 21 Aug 2024 18:11:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724263872; cv=fail; b=fi+oskbSVKJW6zOBufAqSVhXxxJKMbfrHco04SX2RqzsYBrHEP17nG6g4hX3q4XsW0ZB4b05fQOCNAMcv7s5wdmi4kVS14I/C3QdIzqigJDKYMX8CyoiAA+A7C1xceRZS7CY8+i/YX7gLMupMdlz6WJMZcExEioQQzhLgO3Qz4g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724263872; c=relaxed/simple;
	bh=lOfGvwJieDYzOfBNqDRpCtbY8K3x1tWuP5a/8EmMkSw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=uaaV7RQC2jFLRwh60jMWfKMHOSn0zyQ8m1MQwK87Gyaoro0hWG49iODgShJ3ZA0xEmdOCM9ydRIMfglj56S9tJFl+mUA548JuEVz7aePAlm+5KH6Mv6vAzJ/+F09pkrE1BZIXuww/IKeSp7ha082mW+jxTGfPxHnlGPtN1DdeDw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=XbRyQMn9; arc=fail smtp.client-ip=40.107.102.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OdN9X9bUgQhd68q/0al1eZ2N+wlsoipV0VSd8aElawYth4cLPQ6+Yt+zyqYvZ9pfS6udWUTevxrG08vzJZUUNZbFvRHEll97L/0R9LKx93jWC8unAeg/eb/Y/Iu/k8ReefTASEyn4IjWRBNiHakSF/kvuz/D+104ucJVk8WXcZk/2aCPtV+r9dFwzzJcxHL3qpZBBsRZcyXgnYr4fAuW5fGpfNQGkQP6PKPEZkRW33g7QpHAD7JOysJLKSusU6AU3uC16o+Xp6EDsvc/qwsvhDTmWJ8IFSsLQSDh4rgGGltydzXJekY2gRm1gYVRBe1k0FDPYHCf5i2ODi/y6lKS2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rP1MMt0T5gmXxQryyzSTQCqvQLhx2j7YI+S6ZoiQpKM=;
 b=x69y4bbZJkVdH3BXmlTTY5cJSYJpMJOqdi+oi5ugGdmTmkcosuWhqpaYqZGCDZGuTSsacnsZJRRAsDem28i/lkj2xpfTDygxodGvn+2aYm8UZDBsw4c7/zL6txF7+6GnEWBHBLijreAGL2eL4rOvKY+hcBKpnwYyQA5v8NFobVsaX15XE2bbj9yhItMedSYjle9smGYUMXvrUowl2vzz+TAmd+Pr8F0GIWs1aS1Z1s7U4iNAX/l8J3qPZkvskCkk/gHkoKTictviUjzZQdi481Yw3D8wV0d63iSLEso/JCTO1DMdlaLxofUNI5TObFrmsBwgKRNd7yJ+aEHtuiLi3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rP1MMt0T5gmXxQryyzSTQCqvQLhx2j7YI+S6ZoiQpKM=;
 b=XbRyQMn9W4oucXzz3HTXPBV/9Jmf1AdYGwXr0rwKbdpqRGx76x/xL/M4CNvIEMvpKPR6GSJzDw6ggCaS1aqHhn32IvUUMxm9nYf4jiJoZ4qJkSPj/GqVKog2gn/xDLN+w7jIXvl3nnDXEWgpSJOQGSJw9hG9hlandsWIgwsYCjLheXyCQDqkCACCElE3QrLvuOdo8qBii6utSQt1A10F5jFaqVDiu8A4EUgjeMn7fk+ucWHh1y5MgBn4Esn2sCt1saMu56z/jfKBoQHN2ZDKZNJm418+vuvtDgcCYz4C8s9VhEECLWoOamZbcx6ExOPnofkdnG/dYyV6sRzftaNHfw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB7763.namprd12.prod.outlook.com (2603:10b6:610:145::10)
 by SA1PR12MB7199.namprd12.prod.outlook.com (2603:10b6:806:2bc::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.17; Wed, 21 Aug
 2024 18:11:04 +0000
Received: from CH3PR12MB7763.namprd12.prod.outlook.com
 ([fe80::8b63:dd80:c182:4ce8]) by CH3PR12MB7763.namprd12.prod.outlook.com
 ([fe80::8b63:dd80:c182:4ce8%3]) with mapi id 15.20.7875.023; Wed, 21 Aug 2024
 18:11:03 +0000
From: Jason Gunthorpe <jgg@nvidia.com>
To:
Cc: Andy Gospodarek <andrew.gospodarek@broadcom.com>,
	Aron Silverton <aron.silverton@oracle.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Daniel Vetter <daniel.vetter@ffwll.ch>,
	Dave Jiang <dave.jiang@intel.com>,
	David Ahern <dsahern@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Christoph Hellwig <hch@infradead.org>,
	Itay Avraham <itayavr@nvidia.com>,
	Jiri Pirko <jiri@nvidia.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Leonid Bloch <lbloch@nvidia.com>,
	Leon Romanovsky <leonro@nvidia.com>,
	linux-cxl@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	Saeed Mahameed <saeedm@nvidia.com>
Subject: [PATCH v3 06/10] fwctl: Add documentation
Date: Wed, 21 Aug 2024 15:10:58 -0300
Message-ID: <6-v3-960f17f90f17+516-fwctl_jgg@nvidia.com>
In-Reply-To: <0-v3-960f17f90f17+516-fwctl_jgg@nvidia.com>
References:
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BN9PR03CA0684.namprd03.prod.outlook.com
 (2603:10b6:408:10e::29) To CH3PR12MB7763.namprd12.prod.outlook.com
 (2603:10b6:610:145::10)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB7763:EE_|SA1PR12MB7199:EE_
X-MS-Office365-Filtering-Correlation-Id: fd39f5b6-b0ce-4d04-ae76-08dcc20c9e31
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cmxCY1hyV0RqWnJveEJXcmNGb1VuSHBXb3RZZy82Y2pyTWcwcFExbkoySEhP?=
 =?utf-8?B?RXZ1UGErSGZqWllGd2dmUVVQYWlMV3hwL2dJUDl3UUxYZXJxYTFlODUzZG5u?=
 =?utf-8?B?cWhFTURYdDQ3VEIxeGdXT0RJV25lSUJncG5hVng5WUlYY21XQ3ZKa3pxd0w2?=
 =?utf-8?B?bEh3V0t1ZTl2aXVBeTJScXlaZzhvNVhIOUc3Ulg4RU83UGRwcEpXdXJwL25k?=
 =?utf-8?B?cHFtTDByWDluOG1nSFdDNlkxTzlzT0xNOWxxS2xwcnpkVkNWK1Rra05VNFN5?=
 =?utf-8?B?dTlNTDhZOEFnc0VPQ2pyQU9aZXVhbytTMXVBYUFwanI3YnRuMnBzajN6TktT?=
 =?utf-8?B?VTdRTVVlMUtySklJZjRZeVhyT3B6Qi9IRE8rbjB0NHpCSVVtY1ErVDdUelhD?=
 =?utf-8?B?cTV5VEJaaUJ5VVVONEU3WlF0UjUzNDNxRUU4c2xsTCs3Zm5ZK3lPMk9vcnZq?=
 =?utf-8?B?Sk1tUG9FSU9jdW1GKzhWTWtGcW1QM0J4d1Z4N05hSkFVL3dybjhJck5qblph?=
 =?utf-8?B?eEkwak1jRVRoRlFnUzEreFJ6amJHMjRxdVowNVJVcUFkNGloZTBxdWJpSERO?=
 =?utf-8?B?b2U1SDZwZWYzbmp5T0RQaUJuRmp6bFhSeVJ2MFJtMG1GZzFVOERDQmRjdDgy?=
 =?utf-8?B?SEIrZjN2N1U5Z1pNUEduQlN5L3k4ejFrNXJjclhEU0luOUtGbmxHUXY0ZWN4?=
 =?utf-8?B?TGhsMnV6LzJJQW9UdTl0cnc2eXZzVmlJU1RCV0tSTFBmQ00xb0p4QmJmNlFy?=
 =?utf-8?B?SXZqcld2WE80ZGxHTy9NcTMyUWR0eXFhcTluREZLbHZzV0lTREVISU15bkdK?=
 =?utf-8?B?YXNhU3pxVHVRQU1WQW1QcWpBQXMrVElwdUhTQTRDaTJqTTFGYUtPR3dWMHBZ?=
 =?utf-8?B?cE03a29RSlJNb1lpRld4S0dLamxpK1M1RjczWGt0ZEk4YkJmWlRKYmxPQnBn?=
 =?utf-8?B?S2VCOXJzRUhhWVExOGdCeWFheEVxemdDSXBoeE1DcTV6OEtJd1BPS1RaYXVv?=
 =?utf-8?B?Nm1RNHVHa3hENWliYmt0UnlXbzVXMkc3MmU3cmNzaFp6NndnOGZGNGl1Y3h6?=
 =?utf-8?B?VDVxRWJkTlUyeUlNWHlIVm1HZFRjeURtejFJZ3h2Y2hWRWVuVjhxcE56Yis5?=
 =?utf-8?B?WWdNZ1pHYWJQb2szSEVzNUF4MkRIZnlKSFk3MGQ4aGMvZVdxVzNVWXlmbnMx?=
 =?utf-8?B?cXduaElBNXd3U3JqaUt4Tnd0ZTJTMUhPa0o2d1JzQ3p2OG9JMXJhVlVFZWgr?=
 =?utf-8?B?c0EvZDU0emNaanlxTTY5VGZGeUc2WVZtR3ExUzVYUTc3eCs4VmVsSUtjT1hD?=
 =?utf-8?B?bzdLSU1xYklueW9pNEZnSFdMRmVMSlRKSmZydTJNeWU5ZjZYOUlick8zRnpt?=
 =?utf-8?B?OHo0VmQ2V0w5NFhFSTdYUmFnVWhSUHdsc1dYMlRxQ0VWTWJ2Y2Y2d1ovdi9i?=
 =?utf-8?B?c0ZuSm5UaW9iVFFoN0lIa2dWQk54N2lnZDVYNXdqMGNNWmk5d2o1V3N5bklN?=
 =?utf-8?B?QXE5UENQLzBtaEJSOE5VOUJiTmtYNGhMaGRTcHFTSGE1SmNvZFRCdWs1NVZG?=
 =?utf-8?B?NXo3NTRWVGg2Q3pTMGlRQkxIeGFUMVlwQ0hzVUJSRXRQamRZQTJ1bjJiYmJa?=
 =?utf-8?B?bk5zL2tjZUVQNDlhZ1p4YVlXMGFsOXlrczUwbmFHOWJYSkY5NkxiT1FXTEh4?=
 =?utf-8?B?bW13MFNER1lXb051b2w1RXZuVmZ2aGNaeFFRb3VpWG9uVTQ1a1pNV3czNlNF?=
 =?utf-8?B?cktpSTVDdWw0MXNYZkp5NEFFVFBlK3hDc0tIQllPNEtsbWNmMkt2WXVPTXA5?=
 =?utf-8?Q?LoHv1B42sx5d9iGoEEp5LrWw+QoAlXTrA5wk4=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB7763.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MXFBSHZtU2V0NFlNUnBmZHhkSWlPNkdNUElTQ2V3c0tTOHYrZ1B3bGVoTExY?=
 =?utf-8?B?Q1k3MnRQMmRCamJJczZKcDZNOVliOWlGWmhBakhkdEUrcmxxb1ZMdnFvTFU1?=
 =?utf-8?B?dG5IbFZ3dDQxMnNPakx2WERYVWptSzc4dldqZDM3ZmhocVZqL3I0SE9aUml1?=
 =?utf-8?B?WmUzRkRteEhKM2hzNGVYR21JZ09wbDVpdnM2UTZtYkEzV0ovRUxQRHRGM01S?=
 =?utf-8?B?d1M2TWJuOWlqNVZTM2FOaTdxTGo1bkhXNm1Ldld1VDdtTG12WUlGb0M0QTN6?=
 =?utf-8?B?NFg4V09ZSnpkcXQzeHltZjR3M1g4TFJhemdKdnpXZ1dSaG9wQ0ZYU0tpOEhT?=
 =?utf-8?B?NHJ5TkRPeUd1UmlNbWgwWitTVHdHUE01aTcyMDdGQlExR09GOGNiN0dGMTJh?=
 =?utf-8?B?Q1lDVGZjWTVDYjBvN1NzL2tPK0RNUmhkWml4T2t5TFcrQXd6OTRYNDdqK2Vp?=
 =?utf-8?B?MGNXMTJGMHdDOTg3RW5XR1FjaVhncnFQS08xc1p2MkY4Vm5kMXMrVFRTZmRH?=
 =?utf-8?B?bkgrSUgxSUxqa2I1THh1M3hBZWxHcGxmUFVTYUxpQVZIV1dNSnNvODRTc1Ri?=
 =?utf-8?B?V0pCclNhUFFsclB3Z29WODU5ZEU0TnhSNXVNMldVdXI1azViY1UxZXNkaSts?=
 =?utf-8?B?OFJ1NzZwZW1sRFd5UXdIUWxKQVRKZnFEdlFHc0U3ZGV5Q2NNNWRhQm1lSTR5?=
 =?utf-8?B?TmJvYTFoU2FVZkZnTklzcVlEdk90eVdCZHRtM1Q5dTQ5bVgwV3MzREU1ZUkv?=
 =?utf-8?B?NEtuV1IxVTBEV3hmZ1J1eDkvbG9MMURIazA2d1Juc0d5QkdjMmlaWE9FeWF6?=
 =?utf-8?B?Qy9DQXY4dzUvWTJYT0FHUEM1Ym1xblllYjJxL0RNWVlOUkhHcnlKb2kxcGNu?=
 =?utf-8?B?UXhOYWN3b3AzMFhtQXJqUXFtUm9LNEs5VzNFdVFPRWt1N2VHV2gxeEdoU2tF?=
 =?utf-8?B?RGxLdTd5ZjlpOU00K1ovbUlIUnZmZ2hQOGdwTElTZmwyUXJnYnBSREo5NXNR?=
 =?utf-8?B?TzRZRDlWaEdRSStQQ0VLeGczaHAwcGlCSW93Q2V0WDIxNTNwLzJCeDVRS3o5?=
 =?utf-8?B?aWtEWjdVT1lWcWthWTBFTlZZQWZESnFxeTNDVXZVeUtOSFM1cFNseWhyZGs5?=
 =?utf-8?B?YlcvMWdmemwzaCtvYWZDQjZnbi90eFdhOEw5NEQxbHQ2OVVEdUNvbHREdGU5?=
 =?utf-8?B?UVdIMHVPK1Z5OFVGdXhlaU5hV2lMWnVubkdJczRUNysvNm0zd1VIczg1b2hy?=
 =?utf-8?B?WmNmZ1BBSGpuaWV0NFBUUTV1K3lIdm1mOFdBbTkzajJseDhoTHk3SUFHU0hR?=
 =?utf-8?B?ZTQxYVdWUWVNRXdOaFdHbHJkZUVJWUdKK1o4SE53T3JtUWdwT0VlREpmaktr?=
 =?utf-8?B?RXV1Vkp0R2JBSUtzTm55RTdrRkpYZXNLVCtQQ0JNbXQyalN5c3dBbDRWUDJ5?=
 =?utf-8?B?bUhiK3phMzdPOWJHU09VNUtiTWp5UGdoT1RZbmdScXlUVEM4dzcrZStxTTN5?=
 =?utf-8?B?cldtTFJIdFdPdkFOQ3dPeE9LYWtzSWVlT0tBaHlyNVJ1U0Voa2xRN29LMVZZ?=
 =?utf-8?B?TDcwM0NsSWhnL0IxWTZNOXdQODNBOU40bWxNaDAzSmtJWG4wczZHRUdvNnhC?=
 =?utf-8?B?UytzOSthcU9xcFNjWFJ5N0pIenFuUlJPcm5GdW0vYkEwN2VGZzAybThITGlh?=
 =?utf-8?B?c01Fc1A2L3J5dFJKeGp3ZnFHdUhrRTRQWGN0Y082blhnNVdVNGEvZ01pcVhD?=
 =?utf-8?B?SFlEZmdtTG10WHpSVzNudFZUVHFjRmdCbDlyWGxyZU83ZmZ3SUFuMnlNS2Ux?=
 =?utf-8?B?SHd6dldYdFlnTm5qSzdqcDI0K0pTc3BTWTI1azkwNWovOHFDU3NWektLY016?=
 =?utf-8?B?RnJDb25kRTNwVUFVUU1CdGUzZ1hFT2E0UmFkOEZEWjBZV0hmSm80cUtMelFo?=
 =?utf-8?B?N1RMb2ZWVkxpTTkrWkc1RkczVVNoajJjWi9OK3VjMVIwM09JQXY4M1EvMXlO?=
 =?utf-8?B?U1VpMThrMnlReEVkTkFDOXJyVll0UnR0MGlvNWx6dU9PSVluV0xHK0tsM3VL?=
 =?utf-8?B?TUpYU2pEUExnRlNOSWVRaXh0Tnk5RTM1Q0pYaUNlbUgwU0tYZTQraWsvWTZG?=
 =?utf-8?Q?+iycgMeNEv6LaevJPsO7CrYvP?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fd39f5b6-b0ce-4d04-ae76-08dcc20c9e31
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB7763.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2024 18:11:03.1222
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: naKeTi1rLtPpbRWABlWxshgchyuYX+CI1+kLFco5jqhEDJ/32s48IjoRl/tEmGRT
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7199

Document the purpose and rules for the fwctl subsystem.

Link in kdocs to the doc tree.

Nacked-by: Jakub Kicinski <kuba@kernel.org>
Link: https://lore.kernel.org/r/20240603114250.5325279c@kernel.org
Acked-by: Daniel Vetter <daniel.vetter@ffwll.ch>
https://lore.kernel.org/r/ZrHY2Bds7oF7KRGz@phenom.ffwll.local
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 Documentation/userspace-api/fwctl.rst | 285 ++++++++++++++++++++++++++
 Documentation/userspace-api/index.rst |   1 +
 2 files changed, 286 insertions(+)
 create mode 100644 Documentation/userspace-api/fwctl.rst

diff --git a/Documentation/userspace-api/fwctl.rst b/Documentation/userspace-api/fwctl.rst
new file mode 100644
index 00000000000000..8f3da30ee7c91b
--- /dev/null
+++ b/Documentation/userspace-api/fwctl.rst
@@ -0,0 +1,285 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+===============
+fwctl subsystem
+===============
+
+:Author: Jason Gunthorpe
+
+Overview
+========
+
+Modern devices contain extensive amounts of FW, and in many cases, are largely
+software-defined pieces of hardware. The evolution of this approach is largely a
+reaction to Moore's Law where a chip tape out is now highly expensive, and the
+chip design is extremely large. Replacing fixed HW logic with a flexible and
+tightly coupled FW/HW combination is an effective risk mitigation against chip
+respin. Problems in the HW design can be counteracted in device FW. This is
+especially true for devices which present a stable and backwards compatible
+interface to the operating system driver (such as NVMe).
+
+The FW layer in devices has grown to incredible sizes and devices frequently
+integrate clusters of fast processors to run it. For example, mlx5 devices have
+over 30MB of FW code, and big configurations operate with over 1GB of FW managed
+runtime state.
+
+The availability of such a flexible layer has created quite a variety in the
+industry where single pieces of silicon are now configurable software-defined
+devices and can operate in substantially different ways depending on the need.
+Further, we often see cases where specific sites wish to operate devices in ways
+that are highly specialized and require applications that have been tailored to
+their unique configuration.
+
+Further, devices have become multi-functional and integrated to the point they
+no longer fit neatly into the kernel's division of subsystems. Modern
+multi-functional devices have drivers, such as bnxt/ice/mlx5/pds, that span many
+subsystems while sharing the underlying hardware using the auxiliary device
+system.
+
+All together this creates a challenge for the operating system, where devices
+have an expansive FW environment that needs robust device-specific debugging
+support, and FW-driven functionality that is not well suited to “generic”
+interfaces. fwctl seeks to allow access to the full device functionality from
+user space in the areas of debuggability, management, and first-boot/nth-boot
+provisioning.
+
+fwctl is aimed at the common device design pattern where the OS and FW
+communicate via an RPC message layer constructed with a queue or mailbox scheme.
+In this case the driver will typically have some layer to deliver RPC messages
+and collect RPC responses from device FW. The in-kernel subsystem drivers that
+operate the device for its primary purposes will use these RPCs to build their
+drivers, but devices also usually have a set of ancillary RPCs that don't really
+fit into any specific subsystem. For example, a HW RAID controller is primarily
+operated by the block layer but also comes with a set of RPCs to administer the
+construction of drives within the HW RAID.
+
+In the past when devices were more single function, individual subsystems would
+grow different approaches to solving some of these common problems. For instance
+monitoring device health, manipulating its FLASH, debugging the FW,
+provisioning, all have various unique interfaces across the kernel.
+
+fwctl's purpose is to define a common set of limited rules, described below,
+that allow user space to securely construct and execute RPCs inside device FW.
+The rules serve as an agreement between the operating system and FW on how to
+correctly design the RPC interface. As a uAPI the subsystem provides a thin
+layer of discovery and a generic uAPI to deliver the RPCs and collect the
+response. It supports a system of user space libraries and tools which will
+use this interface to control the device using the device native protocols.
+
+Scope of Action
+---------------
+
+fwctl drivers are strictly restricted to being a way to operate the device FW.
+It is not an avenue to access random kernel internals, or other operating system
+SW states.
+
+fwctl instances must operate on a well-defined device function, and the device
+should have a well-defined security model for what scope within the physical
+device the function is permitted to access. For instance, the most complex PCIe
+device today may broadly have several function-level scopes:
+
+ 1. A privileged function with full access to the on-device global state and
+    configuration
+
+ 2. Multiple hypervisor functions with control over itself and child functions
+    used with VMs
+
+ 3. Multiple VM functions tightly scoped within the VM
+
+The device may create a logical parent/child relationship between these scopes.
+For instance a child VM's FW may be within the scope of the hypervisor FW. It is
+quite common in the VFIO world that the hypervisor environment has a complex
+provisioning/profiling/configuration responsibility for the function VFIO
+assigns to the VM.
+
+Further, within the function, devices often have RPC commands that fall within
+some general scopes of action (see enum fwctl_rpc_scope):
+
+ 1. Access to function & child configuration, FLASH, etc. that becomes live at a
+    function reset. Access to function & child runtime configuration that is
+    transparent or non-disruptive to any driver or VM.
+
+ 2. Read-only access to function debug information that may report on FW objects
+    in the function & child, including FW objects owned by other kernel
+    subsystems.
+
+ 3. Write access to function & child debug information strictly compatible with
+    the principles of kernel lockdown and kernel integrity protection. Triggers
+    a kernel Taint.
+
+ 4. Full debug device access. Triggers a kernel Taint, requires CAP_SYS_RAWIO.
+
+User space will provide a scope label on each RPC and the kernel must enforce the
+above CAPs and taints based on that scope. A combination of kernel and FW can
+enforce that RPCs are placed in the correct scope by user space.
+
+Denied behavior
+---------------
+
+There are many things this interface must not allow user space to do (without a
+Taint or CAP), broadly derived from the principles of kernel lockdown. Some
+examples:
+
+ 1. DMA to/from arbitrary memory, hang the system, compromise FW integrity with
+    untrusted code, or otherwise compromise device or system security and
+    integrity.
+
+ 2. Provide an abnormal “back door” to kernel drivers. No manipulation of kernel
+    objects owned by kernel drivers.
+
+ 3. Directly configure or otherwise control kernel drivers. A subsystem kernel
+    driver can react to the device configuration at function reset/driver load
+    time, but otherwise must not be coupled to fwctl.
+
+ 4. Operate the HW in a way that overlaps with the core purpose of another
+    primary kernel subsystem, such as read/write to LBAs, send/receive of
+    network packets, or operate an accelerator's data plane.
+
+fwctl is not a replacement for device direct access subsystems like uacce or
+VFIO.
+
+Operations exposed through fwctl's non-taining interfaces should be fully
+sharable with other users of the device. For instance exposing a RPC through
+fwctl should never prevent a kernel subsystem from also concurrently using that
+same RPC or hardware unit down the road. In such cases fwctl will be less
+important than proper kernel subsystems that eventually emerge. Mistakes in this
+area resulting in clashes will be resolved in favour of a kernel implementation.
+
+fwctl User API
+==============
+
+.. kernel-doc:: include/uapi/fwctl/fwctl.h
+.. kernel-doc:: include/uapi/fwctl/mlx5.h
+
+sysfs Class
+-----------
+
+fwctl has a sysfs class (/sys/class/fwctl/fwctlNN/) and character devices
+(/dev/fwctl/fwctlNN) with a simple numbered scheme. The character device
+operates the iotcl uAPI described above.
+
+fwctl devices can be related to driver components in other subsystems through
+sysfs::
+
+    $ ls /sys/class/fwctl/fwctl0/device/infiniband/
+    ibp0s10f0
+
+    $ ls /sys/class/infiniband/ibp0s10f0/device/fwctl/
+    fwctl0/
+
+    $ ls /sys/devices/pci0000:00/0000:00:0a.0/fwctl/fwctl0
+    dev  device  power  subsystem  uevent
+
+User space Community
+--------------------
+
+Drawing inspiration from nvme-cli, participating in the kernel side must come
+with a user space in a common TBD git tree, at a minimum to usefully operate the
+kernel driver. Providing such an implementation is a pre-condition to merging a
+kernel driver.
+
+The goal is to build user space community around some of the shared problems
+we all have, and ideally develop some common user space programs with some
+starting themes of:
+
+ - Device in-field debugging
+
+ - HW provisioning
+
+ - VFIO child device profiling before VM boot
+
+ - Confidential Compute topics (attestation, secure provisioning)
+
+that stretch across all subsystems in the kernel. fwupd is a great example of
+how an excellent user space experience can emerge out of kernel-side diversity.
+
+fwctl Kernel API
+================
+
+.. kernel-doc:: drivers/fwctl/main.c
+   :export:
+.. kernel-doc:: include/linux/fwctl.h
+
+fwctl Driver design
+-------------------
+
+In many cases a fwctl driver is going to be part of a larger cross-subsystem
+device possibly using the auxiliary_device mechanism. In that case several
+subsystems are going to be sharing the same device and FW interface layer so the
+device design must already provide for isolation and cooperation between kernel
+subsystems. fwctl should fit into that same model.
+
+Part of the driver should include a description of how its scope restrictions
+and security model work. The driver and FW together must ensure that RPCs
+provided by user space are mapped to the appropriate scope. If the validation is
+done in the driver then the validation can read a 'command effects' report from
+the device, or hardwire the enforcement. If the validation is done in the FW,
+then the driver should pass the fwctl_rpc_scope to the FW along with the command.
+
+The driver and FW must cooperate to ensure that either fwctl cannot allocate
+any FW resources, or any resources it does allocate are freed on FD closure.  A
+driver primarily constructed around FW RPCs may find that its core PCI function
+and RPC layer belongs under fwctl with auxiliary devices connecting to other
+subsystems.
+
+Each device type must be mindful of Linux's philosophy for stable ABI. The FW
+RPC interface does not have to meet a strictly stable ABI, but it does need to
+meet an expectation that userspace tools that are deployed and in significant
+use don't needlessly break. FW upgrade and kernel upgrade should keep widely
+deployed tooling working.
+
+Development and debugging focused RPCs under more permissive scopes can have
+less stablitiy if the tools using them are only run under exceptional
+circumstances and not for every day use of the device. Debugging tools may even
+require exact version matching as they may require something similar to DWARF
+debug information from the FW binary.
+
+Security Response
+=================
+
+The kernel remains the gatekeeper for this interface. If violations of the
+scopes, security or isolation principles are found, we have options to let
+devices fix them with a FW update, push a kernel patch to parse and block RPC
+commands or push a kernel patch to block entire firmware versions/devices.
+
+While the kernel can always directly parse and restrict RPCs, it is expected
+that the existing kernel pattern of allowing drivers to delegate validation to
+FW to be a useful design.
+
+Existing Similar Examples
+=========================
+
+The approach described in this document is not a new idea. Direct, or near
+direct device access has been offered by the kernel in different areas for
+decades. With more devices wanting to follow this design pattern it is becoming
+clear that it is not entirely well understood and, more importantly, the
+security considerations are not well defined or agreed upon.
+
+Some examples:
+
+ - HW RAID controllers. This includes RPCs to do things like compose drives into
+   a RAID volume, configure RAID parameters, monitor the HW and more.
+
+ - Baseboard managers. RPCs for configuring settings in the device and more
+
+ - NVMe vendor command capsules. nvme-cli provides access to some monitoring
+   functions that different products have defined, but more exist.
+
+ - CXL also has a NVMe-like vendor command system.
+
+ - DRM allows user space drivers to send commands to the device via kernel
+   mediation
+
+ - RDMA allows user space drivers to directly push commands to the device
+   without kernel involvement
+
+ - Various “raw” APIs, raw HID (SDL2), raw USB, NVMe Generic Interface, etc.
+
+The first 4 are examples of areas that fwctl intends to cover. The latter three
+are examples of denied behavior as they fully overlap with the primary purpose
+of a kernel subsystem.
+
+Some key lessons learned from these past efforts are the importance of having a
+common user space project to use as a pre-condition for obtaining a kernel
+driver. Developing good community around useful software in user space is key to
+getting companies to fund participation to enable their products.
diff --git a/Documentation/userspace-api/index.rst b/Documentation/userspace-api/index.rst
index 274cc7546efc2a..2bc43a65807486 100644
--- a/Documentation/userspace-api/index.rst
+++ b/Documentation/userspace-api/index.rst
@@ -44,6 +44,7 @@ Devices and I/O
 
    accelerators/ocxl
    dma-buf-alloc-exchange
+   fwctl
    gpio/index
    iommufd
    media/index
-- 
2.46.0


