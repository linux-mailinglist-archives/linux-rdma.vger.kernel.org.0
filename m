Return-Path: <linux-rdma+bounces-7492-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 79DE4A2B701
	for <lists+linux-rdma@lfdr.de>; Fri,  7 Feb 2025 01:14:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 03AFE16752A
	for <lists+linux-rdma@lfdr.de>; Fri,  7 Feb 2025 00:14:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84E07EC2;
	Fri,  7 Feb 2025 00:13:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="P8MsGUAB"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2045.outbound.protection.outlook.com [40.107.244.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B06F5672;
	Fri,  7 Feb 2025 00:13:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738887228; cv=fail; b=A8tQY5rP2R/yklxOUB6woPT/m65XbuWPKiqnfz2kCm9m7vUFZpIBTkyQ9Up2kniulC/7v7IsJS5EolM6JkVucFtT6u7e9wNhSqSFFNRWE53cT5jNSsytOGaHwWJMoQNv9WJcRoimsdCwu4AbqkZmjZfZIgIRXQmESW4/o/A2aFI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738887228; c=relaxed/simple;
	bh=UPKMtK57L+zknvxI/OwqAjvV5rrPVmNPUoGIrrc3vLU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=acOiXNvoIa3Clf5EotUpZQgCdyW1FlBZCmwQOsji+DPl5ARye2Og2wVkRQ94v574H+3uzz4r99bBtIJL21LgAgnNH5cdy3irTSiM1QhXMPgZarZolp/mpzIIZaairV8eovcl+7XqFrEpNEReY+9iJLyZI/pwUvzIfPq0JPT75ic=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=P8MsGUAB; arc=fail smtp.client-ip=40.107.244.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XYo4xmvNGrphqzFJEJjHcWwhWB4fRKUhRdaTJryZQBR0p1S03pRZ8mOtHnDmd7jEWX3RmCtr7X7wH8P7dPsgQ9WCkJmrDqx7wLXP3tchucHNmOez8ZDP35rrWNNQ+39DQ9WSvJYQU7Qed2SQ/XcPWqq+bbp6U1QXNxzIw8ZBUUz19MsGI+PSmjiW1vjXLjBrxZbBRItOiIbDIR62+K+Yn7ZeIs0gBBx5zpKxJ+R3XqQ4QtCNLUhajcegCK/Vjx8fibdOqPPKoFQ6BC1dVtqScqZhKudVVneSsUtFYksbZBFRmDZlgsbDGtFD7VFOKaOsxKXkJRq/Mu8oYlhE5rucZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e7Shz75grRCwY8Z1HfydNCAIJMp6pG0Z3WfjZMmLwyk=;
 b=aCu2wfJTCjhMP9T8r7HcN11gOLkJp1+W5G3DoHiCQWutb7DEVNMZ1D7V3IY90O1gi3QbJxcxWZkX7Mfq7HBTd2pmDkkqy2Tw/H/6tG5heerB4RXsx1oSuR2RG4Rk38I7rUf33TeKPvkoh0LxRRpNSgyojNWftXHPIzvXSFuefYf1dgkUONoTkBpwRsaUT/57e3hohftBZKIqhV9ZqBXla4soUMNMUcUkh94I3eE9Gb9Ws7cG3D+Yh9cmqIbTms5HHEPPCQedlAK9jbwVbhz/F0BElaRDPimkgS+NJjZaYgHe7e+kT4Mu7zyOLCAEnIz+EApDhVG/96m2z4SVFnyVzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e7Shz75grRCwY8Z1HfydNCAIJMp6pG0Z3WfjZMmLwyk=;
 b=P8MsGUAByPoJkz+21Tge7kEJAJH8a2eRF6znceE2wVU5qPpzBn6xxV7KSVD7Sc5NxDqPHjqYiX2+AFBjAturfa2/oQbo3NnjSHNZSWv4sK9cDqx8TqeOSXKZ8+AL7pPVo1/foKLosEzdC6QRFhOuGIItfdkUNmAKq1E0QdSeDKqXYyidMhovHmFHe92HYym4AccbMuyZD3XUrODjuF9U2yqf0L5OpQQVpZWs7+51GVBZ9wpVxnyJWgfxTGiNCxrEWyiEmVmb8tKL3cUfVIm8LUbqUGHdLTTnnUtrT6s4rR6F2RrgmEo88fA/xJr3S/PDM27+KPTWh/V+2lwvGy1sew==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by SN7PR12MB6885.namprd12.prod.outlook.com (2603:10b6:806:263::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.24; Fri, 7 Feb
 2025 00:13:36 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%6]) with mapi id 15.20.8398.025; Fri, 7 Feb 2025
 00:13:35 +0000
From: Jason Gunthorpe <jgg@nvidia.com>
To:
Cc: Andy Gospodarek <andrew.gospodarek@broadcom.com>,
	Aron Silverton <aron.silverton@oracle.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Daniel Vetter <daniel.vetter@ffwll.ch>,
	Dave Jiang <dave.jiang@intel.com>,
	David Ahern <dsahern@kernel.org>,
	Andy Gospodarek <gospo@broadcom.com>,
	Christoph Hellwig <hch@infradead.org>,
	Itay Avraham <itayavr@nvidia.com>,
	Jiri Pirko <jiri@nvidia.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Leonid Bloch <lbloch@nvidia.com>,
	Leon Romanovsky <leonro@nvidia.com>,
	linux-cxl@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	netdev@vger.kernel.org,
	Saeed Mahameed <saeedm@nvidia.com>,
	"Nelson, Shannon" <shannon.nelson@amd.com>
Subject: [PATCH v4 06/10] fwctl: Add documentation
Date: Thu,  6 Feb 2025 20:13:28 -0400
Message-ID: <6-v4-0cf4ec3b8143+4995-fwctl_jgg@nvidia.com>
In-Reply-To: <0-v4-0cf4ec3b8143+4995-fwctl_jgg@nvidia.com>
References:
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BL1PR13CA0318.namprd13.prod.outlook.com
 (2603:10b6:208:2c1::23) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|SN7PR12MB6885:EE_
X-MS-Office365-Filtering-Correlation-Id: 2474fa82-a92b-4c3d-d921-08dd470c42c8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?M3A2aWVUam5rTW5YM3FXYjZwb29SRHAvdTBYaUJDMllSR1d4dk5acU1xSnc2?=
 =?utf-8?B?ZWZNdXpqWWw1VWM0bUtQZnFlN2VYemU5V3N0S2FSTW50bmFxL2ZGK0Z5U0FV?=
 =?utf-8?B?M0d3Nk5DdEhCc3Y3UjBXeFZoUk9QckJtL2xycVdKWFY3K2JoTmoyR1A5SFJw?=
 =?utf-8?B?VTRwWkVMdDFzRjRzT2QzTDl2UytUUVk0cGFkamlQQTA1REx2OWMzSEdxOXpS?=
 =?utf-8?B?MzVreHkxem0zVll5K0ZtTStiOEJTcEhSYVRwR3djMmFCOTM0cmI3U1F1VW1p?=
 =?utf-8?B?VEh2U2FVQ2pEaVFrQ3hsMStvcXB4UVE5aHBtd2xQVzk5K0ZvaFh5bS9HN3M1?=
 =?utf-8?B?UWU3cFAybGlFOWVlOXJZOTZnNENOaGxrRUYrSmhlV2tFd3FSMVJtRy9IVHRl?=
 =?utf-8?B?T0VsWS9yVGxyZmtYbDJxOU5zY2ZickpWWUp0SmUxNG42Z2hjTmZUbm44aFBZ?=
 =?utf-8?B?aDdyb2hoc0VzTldjNTZVN2svM1VQTE1TUy8zeVoxTWhDTWQyd0p3Mkl2WnRp?=
 =?utf-8?B?djVYVGRhRExjVWlGeGxBTEU5NWdxbkkrY3E3TkUvekZuWVNzNXU3dW91ZGhD?=
 =?utf-8?B?WXJsOWRyaHc4bEViUDg3K01nRmt6QnhiVW9ldzBtRnZUeHZxdlFwdElybERH?=
 =?utf-8?B?V3RaVngvTnd2THJqUmxtS0tJQWFMWlNlL0ZKRFUwZGpSUXBzQVNZWjF0QURv?=
 =?utf-8?B?ell3RmJSY0lqNGt4WmtOMExGdFRsSzM3VWc0L1gwaTFJYzBuaUJoRWxLeFZ0?=
 =?utf-8?B?RWMvR3M5cEFoQXI5dGU1VG90ZzQreGp3S2VTdFB1REpvL2FFVDdSbDZ5QkFz?=
 =?utf-8?B?Q0VHcEZ4MDA3MkZnRUlsRXQxQWo0d0g5VVlOWGliN2pTQ0ZDNkxkWEhDQnB0?=
 =?utf-8?B?WUhQZjBXY3dUU0Q5UGlsWE1qb0lBSzZCdHZQSy9GaXpEWjRwZ2FQSE94ckRZ?=
 =?utf-8?B?U0N1OUROVFhoQy8waWplMEZRS2dKY2xxcTV2TEFXU2NhaXZreGU2N1hjNkZz?=
 =?utf-8?B?ZHY0NGlrcGMyWVFBbnR4SG5KT3dXeWhHMW9md1drSnN5MnRKdjJNcURqWEQ1?=
 =?utf-8?B?enNSczJQRkdDUkVRMVNOeFBJYlRDdkZJTG5GM1IvQTlHMEMrY016dEJMWHMw?=
 =?utf-8?B?NWRVWGFuQzRRR0FPNzlTMEJSREVBTGk4UlBab1gyejVPeCtxb2NoTTJ3OVpH?=
 =?utf-8?B?dm52UGhybnloQ2d0T0hZT2c0blZ4RFh4WDBvNmFXOTZhSHAyeXcwaXh5VDI1?=
 =?utf-8?B?TmhIMTFhL1pCY0hleTViMXc2Yk9HdHBUbkNPbnFoVlpaS1R1a01EOURpNXVY?=
 =?utf-8?B?U0JidUdpR05pOXU3NE41dUdjYUowR1RDVnRHVlB2VkRMc3pUMENUaEJmZDM0?=
 =?utf-8?B?aSs3RDY2TUg4Nmtjb2VTV3RmakI4dmVNRW9YcGhWZVlveGl2bytSUjd4TEx0?=
 =?utf-8?B?MmFlU3dWekF0QXEzbXRhNFdLTVNVWk1jZHlyL0VyNjljSEJjbDVTazVIZEw3?=
 =?utf-8?B?bzhHTzZTZW9FcEhONXl6Rys1TmtFZklCUWFoaUxWTE5wOUs5UEJpaXRxdXpB?=
 =?utf-8?B?UUd0bWc3RkI0OGFqVWw2Qnl6RmN1aXR2S0JFQnpRL0w2bWRZYUpUZW9hTjYr?=
 =?utf-8?B?TmJBWnpuSFJyZVRPaEZYbnVLcWlSTFd4MU43TTFMVUxDeHdncy9yN3VZMEo0?=
 =?utf-8?B?WGVYUUdQQ1RNbkZYMHV1Z0FCWlVzTFZydFZSMjdmVlZmSkM4Ti9xTDNXRTBo?=
 =?utf-8?B?bEZJcEd5bk1KV0NHRm45alZxcUVyTVpUNFA2UUpMNGdWOCtlMFRVK3BuVFBS?=
 =?utf-8?B?MjNYVlZLR2lGcDJTWUlITHRJYVo2Q21CanZqMVRJU2F0aUR1cVp5ZUJ0M1Jj?=
 =?utf-8?Q?6xMXBG1Mw1rg3?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RW5xamJFTDJzQWJoWnliM1AxODBSYkU2Mi9CdjRBWkpVSVFqUTEwUHdIMHdz?=
 =?utf-8?B?M0ViYVRrVkVWTFBjUis0Sm5RUlhGbDEwclE3NEJvVHoxTnU0bys0eVlnSU9S?=
 =?utf-8?B?ck9TY01NVHpRL3ZtNW9EaHVZRVFXMkZKUmFPdTRkRkU0d0duUUwyUDRvdDFG?=
 =?utf-8?B?SlYzZzZ3N1VqL2NCbldDSVJWckJDeWJvVk9jV0NPRE1FNkkvZTNLdjN3RndI?=
 =?utf-8?B?a2NIeTJTZWFxNk5va0Y1aFFHNk45Qm1Sd1JrV0w1SjhhUVBXQ0lNMWdISkhu?=
 =?utf-8?B?VWVNTjFyOFd5aEdpQW9uTW1OcEp5TlJGbUFWdGpYSzIxMmhsY1BhYThTQmlu?=
 =?utf-8?B?UUFOTjZacCtuT2F0Q0hrT2RGTlZjeFdJRG1IOHAyMHIrcmNPbk1xOFFGd0I0?=
 =?utf-8?B?SzcyZ2MyemNYZUwvaUd3bWVMVkZxVm9qdHVZSHZxU2tPR0VQb1lJYjhQVHho?=
 =?utf-8?B?ZStIcDlWYlQxSUxkTUREdzdRVmYzWjRPVWxwT29QcmlkNFN2RXhwYVp3YUpi?=
 =?utf-8?B?ZXoyV2h1cU9HTFZEd2R2dUlMV0xuVFM4U2s5THpJL1g5NWY0akhTaWZrb3ZC?=
 =?utf-8?B?ZjdkV1poQ3I1SlVPazhlRm45KzBaaUd0M05ZVTRqNzlBaElIS2ZUUTNpVE5l?=
 =?utf-8?B?Wlh6aXRpVFRZN2pGOG5OTTFwTXE5YVhSdzRFckJqUzBjeDlrZlN0dkJQMDlK?=
 =?utf-8?B?VzJ4ZkJiRGNQMVZVVU9UeEZZQUZQekloMWtQNWpkbFI0bUxxNnZxVG4rekNC?=
 =?utf-8?B?U0MxcU9GWk12WHdOd3Y1ZDVDSWNCTFMzWWNIeFZGMUFteUo3UUN3SkZvd213?=
 =?utf-8?B?WUx5bVo2UmkzMWJCcnpoOWQ0RkFyV2pPckpvamlBMlJKOC9YQm1LV2x1OGI0?=
 =?utf-8?B?NjlGbzc3MHdwOHFrU1BDK3dwZEYrbGZIQ3VOTll0bG9iQVdmSlJic2xxS2FZ?=
 =?utf-8?B?NHhSbXNxMTVEaHdTMXpMVFdTTU5zWFI4NGRCRHdlYTNvV2NJQ1pXc1dxZUcr?=
 =?utf-8?B?elNRYUJUUkpiVmxjcHRJREZTbS9KR0dRN2p2UG52cjdJM3dldXJ3R09iVUd6?=
 =?utf-8?B?MUVFblV2bjFuU3FPQ3RScnJBQndOQnErYVNTY0F0MVU4YTRINTh0WHdxNGxk?=
 =?utf-8?B?Q2hOOFZ3ZTdtMGV6TFpNc1RVVnNvc2RJWHRPRlQrWm1obytWQmU5NzdvSHp3?=
 =?utf-8?B?ZWpmTlpZaXUwZ1J3QjFEL3EvYVE1MFNHcUl6NjlBemlFUGlXVXJXWWt5VzE0?=
 =?utf-8?B?S0xnd3JCTDYreXdIQTJzTHZZOTVTQys5QTc3SDRhQ1E1S2FyUEhTNFlWVWYv?=
 =?utf-8?B?K1laNkE4UlZBQUwyVVR5OU9qUG9wRnU4bmdmZGpUcVorb2xCV2RPM3JhSXRi?=
 =?utf-8?B?YXFUQ3dSaHBxeElmV3B1cUxhd1k5QTdEd1VCYnYxS1pPYjk5NWpRc2drZnEx?=
 =?utf-8?B?NkFvMlhNaGJYS0Vuck45eUo3U21Rd0hmbzI0VWlFRnV1M0FmbDdaUm9nSlda?=
 =?utf-8?B?TXlQV0wrSDNZNHc1ZktEOU5vNFVUTTIvTnQ0UmZzcWxtWm5QMG5va0Q1NGc1?=
 =?utf-8?B?eVNYVWhXTG1ZMVdhOXd1MVlWNDRhUlljQkFEZ0kzSHJucVJvNXo2S2ZJRzMy?=
 =?utf-8?B?S00yOTVJYlFoenU5YlhGNWRuaENDR2dTN0dQMVlyZmVJL1R6R1BUVGd3Q1J1?=
 =?utf-8?B?NEt4a0pkRFNMZXhEYk9TNXFpWjJKb1A5SytxR3hEZFVQZUYwbUE1azhPV0E3?=
 =?utf-8?B?T3kyc3R3Mlo5NzVzL0FtTEtDR0dJWlpIQ2pzZHkvUjFyaHVXUmZhbklhaHlL?=
 =?utf-8?B?S2FkQi9PQjUyL0JWOXluRC9rMXE0MEVZTkpuditNSFJlYmpHYkk0dEdiNzYr?=
 =?utf-8?B?VjZTR0kxV3FjTHNtWVJuMDRJTUIzeGVWTHFBYW5SRS9UbXkzajl2MlZiZmpq?=
 =?utf-8?B?cTg1Wk0vazY5TGRtVndWZnNPeHhCNDBXTHc3R2hLWjdYSlp6SmE2a1Rsak5O?=
 =?utf-8?B?Y3R1SnVzZDZ6ZCtGNUo0cERkMnpwcmF1ZmQzSkRmM2czSGhVWm9pc0UzRDlK?=
 =?utf-8?B?dWlaMkVWblZvU0pCZVRURFJJd2xMUG9TT242aTBQa09tZUZjSnhoNVM4LzBE?=
 =?utf-8?Q?LajsKZ+7hXr+Bd7JGxNx2OOoK?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2474fa82-a92b-4c3d-d921-08dd470c42c8
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Feb 2025 00:13:34.4976
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nVxPpLj+86D1M1aLYc/NkiS8gma1gXXZ04XAHuxjhHupbFjqWY9qcBuL6OEGlXwW
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6885

Document the purpose and rules for the fwctl subsystem.

Link in kdocs to the doc tree.

Nacked-by: Jakub Kicinski <kuba@kernel.org>
Link: https://lore.kernel.org/r/20240603114250.5325279c@kernel.org
Acked-by: Daniel Vetter <daniel.vetter@ffwll.ch>
https://lore.kernel.org/r/ZrHY2Bds7oF7KRGz@phenom.ffwll.local
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 Documentation/userspace-api/fwctl/fwctl.rst | 285 ++++++++++++++++++++
 Documentation/userspace-api/fwctl/index.rst |  12 +
 Documentation/userspace-api/index.rst       |   1 +
 MAINTAINERS                                 |   2 +-
 4 files changed, 299 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/userspace-api/fwctl/fwctl.rst
 create mode 100644 Documentation/userspace-api/fwctl/index.rst

diff --git a/Documentation/userspace-api/fwctl/fwctl.rst b/Documentation/userspace-api/fwctl/fwctl.rst
new file mode 100644
index 00000000000000..428f6f5bb9b4f9
--- /dev/null
+++ b/Documentation/userspace-api/fwctl/fwctl.rst
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
+The FW layer in devices has grown to incredible size and devices frequently
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
diff --git a/Documentation/userspace-api/fwctl/index.rst b/Documentation/userspace-api/fwctl/index.rst
new file mode 100644
index 00000000000000..06959fbf154743
--- /dev/null
+++ b/Documentation/userspace-api/fwctl/index.rst
@@ -0,0 +1,12 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+Firmware Control (FWCTL) Userspace API
+======================================
+
+A framework that define a common set of limited rules that allows user space
+to securely construct and execute RPCs inside device firmware.
+
+.. toctree::
+   :maxdepth: 1
+
+   fwctl
diff --git a/Documentation/userspace-api/index.rst b/Documentation/userspace-api/index.rst
index b1395d94b3fd0a..e8e861f767fd5c 100644
--- a/Documentation/userspace-api/index.rst
+++ b/Documentation/userspace-api/index.rst
@@ -45,6 +45,7 @@ Devices and I/O
 
    accelerators/ocxl
    dma-buf-alloc-exchange
+   fwctl/index
    gpio/index
    iommufd
    media/index
diff --git a/MAINTAINERS b/MAINTAINERS
index 5f30adbe6c8521..319169f7cb7e1c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9561,7 +9561,7 @@ FWCTL SUBSYSTEM
 M:	Jason Gunthorpe <jgg@nvidia.com>
 M:	Saeed Mahameed <saeedm@nvidia.com>
 S:	Maintained
-F:	Documentation/userspace-api/fwctl.rst
+F:	Documentation/userspace-api/fwctl/
 F:	drivers/fwctl/
 F:	include/linux/fwctl.h
 F:	include/uapi/fwctl/
-- 
2.43.0


