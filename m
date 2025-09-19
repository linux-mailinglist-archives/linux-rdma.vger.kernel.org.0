Return-Path: <linux-rdma+bounces-13516-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 41D45B89CBE
	for <lists+linux-rdma@lfdr.de>; Fri, 19 Sep 2025 16:07:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EB77E62079B
	for <lists+linux-rdma@lfdr.de>; Fri, 19 Sep 2025 14:07:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB5CA30DD0D;
	Fri, 19 Sep 2025 14:07:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cornelisnetworks.com header.i=@cornelisnetworks.com header.b="CMg9/dRz"
X-Original-To: linux-rdma@vger.kernel.org
Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11023121.outbound.protection.outlook.com [40.107.201.121])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56CF925A2DE;
	Fri, 19 Sep 2025 14:07:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.121
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758290848; cv=fail; b=Pt2LTo1CFa3QCeJR64+VUmDAyIUdOhdH2ePcciQqoE5ZQhNrHKOXVqn2P6GR6SOH0Fbavet/H5BeDNvnBY4BMSSt9RlTB/3hv1CFRWysLCLiaJiGzpvy+88gpuWuwaMqMaytWxUNT0tTjRptgAYUwZ7PHyvLRc7xYpyl8kJ+7W0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758290848; c=relaxed/simple;
	bh=OASCWihj1qQmOmJzX/K4tdD0PnOS2sU2nqSYGIP9POA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=KtZ1eyYla11tTfCw/dCXTC0dG+PNbLaPq7YGhYFrQa8iF9IWuVAGqNcX0mVb5yx8tQ9tDSBX2MfzgCvuDiz0Jk9GQSbLF00PBAOnWpVj1d2PK4wC1Rs4zVVkmyraO/KzSsTxR7OpHuCvCz0THjiy5Hr3Opi9yAL2kkdF4ECCfBw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cornelisnetworks.com; spf=pass smtp.mailfrom=cornelisnetworks.com; dkim=pass (2048-bit key) header.d=cornelisnetworks.com header.i=@cornelisnetworks.com header.b=CMg9/dRz; arc=fail smtp.client-ip=40.107.201.121
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cornelisnetworks.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cornelisnetworks.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vPIjEBWoNIPRKBethtIIwBP2NGaWc6FcLY51yVri3ibNGV0ue8aFACZxM0RpaDN07AIh9BLXi62nKyH1n/dAEib3oCpecq3LuMNM7w8vIR/G3dbYkb189PBf9aO9lic3rGFP+SrYgjWXFtbhVqH/x+WM8xXHZPUai88I8s4L6mJkOYfw/O+cRqjL60cuwAiFri6pfvpgAYj7vXCktQSdJnYMzvFiqqvopMh6MIp2zIx30QzMioRWbP2fOY41tBzUH9qqWUtEwDfuT9tny9CgWJbsBLj+DAjJ9DmVyByVw0nJw/Z1D1qRmYlMFKskcfIm4TaczOnnaPKn7wZu3Cgv8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TN4DW7hvSEPc7cB2FfkfafW042lW3tYRQJ/vGY6VYJk=;
 b=FhaEBlvMK9v79F/MAuxCWn+RiotJs/vXWJvG8LSPZonzQ7Kyf01xGWI/OydKeleuV7h/PXzniqVmg9CnKHuUF7ut5mNHJk9d4kHQVnKrooGo25cjaWUoOKaBGqB7IF34BmGfNAdkI4bX3ZKlWbPqVIbBGFS1P/YRkCIgI/lG2Ecv8rDL+BB6nddQwmFi0fHDetnIgEh7871SIbvW6Yrv1sJv73ZRGCJVaaU/gIPt4dANCkP4aOIsK5Dy01I+IosxZ/Go7xgPUT1SKmpVMbI49G7NQWAIBRG0CDO6ebQ7QuVyvqjq00teu6quNLHCqYdM7IEgfa4JMrndZ86gJB5z4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cornelisnetworks.com; dmarc=pass action=none
 header.from=cornelisnetworks.com; dkim=pass header.d=cornelisnetworks.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cornelisnetworks.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TN4DW7hvSEPc7cB2FfkfafW042lW3tYRQJ/vGY6VYJk=;
 b=CMg9/dRzHzInAn1INyqAjvGQDSL9UKxJsTgXddxmhGzlZt58adltmICSwRuiH86emNJx/XdxKUj5Theg0k8o/BE+Lf+DS36ECDVRvecSaroWp10Qg2v1FHyMdEy+ECpCcbd+jMwGbswRfWwV14TDeVlA/g2/HBU1qfbTQsphQjPr8rjE175IfQQ94hWq5+V8KF+HhDHapg99tmnOoWVNoRMULut+TEtddd6CBp42waWewprM0QJJLDpWRbde6sgTponHBE/09uyjr1A0nADW3Ka8oofZMInz4S6W8kR+bsAn0HWp1uJPQxk4CIYlysHBLcTGtk4eZnCVLGrNXYudhw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cornelisnetworks.com;
Received: from SJ0PR01MB6158.prod.exchangelabs.com (2603:10b6:a03:2a0::15) by
 BN0PR01MB6864.prod.exchangelabs.com (2603:10b6:408:165::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9137.16; Fri, 19 Sep 2025 14:07:21 +0000
Received: from SJ0PR01MB6158.prod.exchangelabs.com
 ([fe80::d4a8:cb9c:7a0:eb5b]) by SJ0PR01MB6158.prod.exchangelabs.com
 ([fe80::d4a8:cb9c:7a0:eb5b%5]) with mapi id 15.20.9137.016; Fri, 19 Sep 2025
 14:07:21 +0000
Message-ID: <dedb46d0-b42a-4c9c-a020-38ece72ba4d2@cornelisnetworks.com>
Date: Fri, 19 Sep 2025 10:06:49 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH rdma-next] RDMA: Use %pe format specifier for error
 pointers
To: Leon Romanovsky <leon@kernel.org>, Jason Gunthorpe <jgg@nvidia.com>
Cc: Leon Romanovsky <leonro@nvidia.com>,
 Abhijit Gangurde <abhijit.gangurde@amd.com>,
 Allen Hubbe <allen.hubbe@amd.com>, Bart Van Assche <bvanassche@acm.org>,
 Chengchang Tang <tangchengchang@huawei.com>,
 Junxian Huang <huangjunxian6@hisilicon.com>,
 Kalesh AP <kalesh-anakkur.purayil@broadcom.com>,
 Konstantin Taranov <kotaranov@microsoft.com>, linux-rdma@vger.kernel.org,
 Long Li <longli@microsoft.com>, Michael Margolin <mrgolin@amazon.com>,
 Mustafa Ismail <mustafa.ismail@intel.com>,
 Potnuri Bharat Teja <bharat@chelsio.com>,
 Selvin Xavier <selvin.xavier@broadcom.com>, target-devel@vger.kernel.org,
 Tatyana Nikolova <tatyana.e.nikolova@intel.com>,
 Yishai Hadas <yishaih@nvidia.com>
References: <e81ec02df1e474be20417fb62e779776e3f47a50.1758217936.git.leon@kernel.org>
Content-Language: en-US
From: Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
In-Reply-To: <e81ec02df1e474be20417fb62e779776e3f47a50.1758217936.git.leon@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0P223CA0014.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:610:116::18) To SJ0PR01MB6158.prod.exchangelabs.com
 (2603:10b6:a03:2a0::15)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR01MB6158:EE_|BN0PR01MB6864:EE_
X-MS-Office365-Filtering-Correlation-Id: 3f383a1c-6b20-4381-2dfc-08ddf785d9f0
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?S2pvVVJKM1hkYmltNGdndyt0NlRPWjRhakVub0tyTDVoSkNMQm13Q083M0lB?=
 =?utf-8?B?RFB5ME1RN1JzT3pHc0daK0RYTHRDS1poaEQ5dWFOczlWYUYyRkJ5S3dQc3c3?=
 =?utf-8?B?Smp0S0dxM2t2YlZXY000bEtiZW1DRUczNE1kdVV6TW4zc3lvdEExV1p4M3FG?=
 =?utf-8?B?Y1Q3KzFQNXNpM3dYcEJ1d25xeHVKNjJLMTliT3AzRmxoSnFPQUZhV2F1UC9C?=
 =?utf-8?B?ekV5bzczZDBlNDIxNFJ5WDF4ZEVVbVpSbUhjcURSaVBZMDZTUlBub3dTL3Rp?=
 =?utf-8?B?TTZCc3QvbUpZVnJtMVAvcnJNYUZvSExDc1ZMWnVEcDk4M3E5eHU4endsd0FO?=
 =?utf-8?B?T0YxeURZd2hzdXFkSjlPM2pVWWlEWXFiM3o4TGI5cEE4cEF4RVQwcDNKRVho?=
 =?utf-8?B?ekUvVktibkhRZnc4VmVQekJHY2dmTnVpNnVNSWJ3L1lqa0RBb3BHb3FVOW5q?=
 =?utf-8?B?dGhIUUJiTTNSODJSWFlUN2dqS3M4MFN5VFRaZW1MWjRzQjNIZkt3dGxaekdh?=
 =?utf-8?B?bVZsZGZ4UDZZZW1wdVM0UmNma3VzWDJuQ2dOc1lETklTNVVSbUc2M1dUOU0v?=
 =?utf-8?B?dHhKTGZuNE1pRk1KVDBEZFBKSDBkSm1kcklNSnhpQzNtTi9TQlZxVE5iRnUx?=
 =?utf-8?B?WU9sdmdoWnF0TkdpWFZQQmhSVUhBWlpUUEpuZkp5TU9uaHlMOEpLV1E3Q3Rv?=
 =?utf-8?B?L3ZqU3RPVm1GVHVrUVZVVVdYQnpGeFpheWhuM2lFclpWOE9zZEpoK2d4YjBk?=
 =?utf-8?B?V1I2dVFxRVBXM2VjbmxvZUtTWmJrclcxdWxiZ2ZNdmRlQmd2M0pTYjJsajNx?=
 =?utf-8?B?Rjc2UFZwTEJuNERpVkIya3hjSE1DYTVyZDNTQU9hNjBLMTR1bGxxS2ljOEFV?=
 =?utf-8?B?WStic2l1OVljM0d1Wk5SeWlRV013OFMrWTRsdWlKSXEvQ1Vwb1NudjZtSVpk?=
 =?utf-8?B?eHUzSGNYU3lpelJZbEJ1Y3pzY3ZSUGZkMEdoMW9lR052cnA2eWlKaVhxNnRs?=
 =?utf-8?B?RUErRVh3ZGxwRWU3czI2MXNIa2p0K0dPQnN4UXBGL3FiWjNkSS9qb1NrRm5z?=
 =?utf-8?B?cnlTa0FaVERaZDQwOE1zOWFOanEzYVV4UEV0ZTJjNHhUUHBQUnRGVzE2ektJ?=
 =?utf-8?B?a245K3l4dTJPby9pSDhpL20xSHZ2TWwrUjR1dXNZWEhxemdBWEdEaEh2Yncr?=
 =?utf-8?B?K29sYkx5OGR4RW12WEVjKzBaUDlhbzA3cXR2dzZ3ZTNsWnhtbjBLemxIUlFQ?=
 =?utf-8?B?bmRBcW1VUjc3MS9QQlh6T0dGUGZIRjJTWHNvUDdwSHkxZDd5eld0dTNVOWhk?=
 =?utf-8?B?cE5qZDBrOUZMaWprdHpPWndWQklXQWJoaU9xaGpnVW9NUWgzVUtVd09yQVJW?=
 =?utf-8?B?REh0b1pYQ2liQjI5Tm5DNUM5ZDBLR2ZiUTBjc2ZXVGRpeXNyVnRKZzRZMnRj?=
 =?utf-8?B?SFVGN3NMZ2xqUk5pTnAyK1FwaU1jaDZhOUZaMlBUZkJrSjZubFZTUWNYUU5H?=
 =?utf-8?B?dFhVdkRyam1kaERMZUw3N2ZzT04yaThZeHYwN3A1Wjg0T2NxNnQ3MVVHL3I3?=
 =?utf-8?B?Uy9pOFI0T1VRWkdXaC96RzZXYVhBd1Y2RkpieEZRUWtEYTRCVndiektwaWpm?=
 =?utf-8?B?bGRFaXJuZTVNRlBZTUtBdWNEcU1zaC9rNHY0ZnpySVhEWGk2Q2Z5TWNJdFc2?=
 =?utf-8?B?U2dtWFRzNTVRUnNUMHhkcnlQaytQS2hDSVlSWGlzVlBMRmh0a05vK242aDU0?=
 =?utf-8?B?T2Qyc0ZObnY0RWRhb3VhdlljRzlXLzM0NjI0dGYxU2RqWGdUZkVFSnFhWmJv?=
 =?utf-8?B?bnEzcU9IZFk0NDJteXgrN1RreEI0NzVva09yd3JDS25oM01BaFdHak94M3Rm?=
 =?utf-8?B?d2M4L0NOelIyQXc5OXF1eGtLNzJTSnF3TUxmZnE2SEZXaWJBRTMxQlRQYUlh?=
 =?utf-8?Q?zTiowm0q/KM=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR01MB6158.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZEhHTGprQ2RiTUkreXIyVHN0eW94aHhldTlZN3B0bVlXM0tGTkEvZHd5OWtI?=
 =?utf-8?B?akZvbyszUmR4K1Z4T1FZcUtDVjIrQjVraHUzcXg3RzlWNEx3Z28yYmRpZExs?=
 =?utf-8?B?VXkyYzJyTElLcHpicHFVRDc5UFRyeVZyQ2dTZUJRT0dVWVAvVjVkRVViVEF5?=
 =?utf-8?B?L0hYWHltbXMvaFZ0NlBPVWZOTDZueVlsaFdpM3d2eEVmWUtSTDVpMkN5ME5D?=
 =?utf-8?B?UjZiSXV5Sjc0Q1FOVjZyTlRwN2RKM2tXVkt5aDhoUTMvemlFVzFaMTRIbjRo?=
 =?utf-8?B?MFlqMnppWXB5YXdhODNWOGFPaURTS29TUTBlU0RSYlR3aVFjbjBYdmFLb3VQ?=
 =?utf-8?B?akxZVm5uY2d2RGhVV3lVN0VlL0NQWjIvUENZZDN5U2JsRDVNQmViQklPNEs5?=
 =?utf-8?B?TStKU1ZRR3pmOEx0bWxpL2MxbjNqcTAwMi9XVUpCSTNFSUVZaXYwb3RIQUJh?=
 =?utf-8?B?cm5lejZPdVpTY1Z1LzZXMGR5cFFVNnYwTkRpK0R2ODJLRUk1eG5vSVFwSVVR?=
 =?utf-8?B?OUtnZ3JIZWFCa0ZiQ3Y1UlpETC9lc2Zqczg1YUpJZnlTQlZMeGJjbEttdEVM?=
 =?utf-8?B?ZWxCeTU0VDZwSTlScXdlcUgrMFE2anczTVREWUVlYmh5QnNZMFA0ZmlheHVI?=
 =?utf-8?B?VVdzVU85THExOHRWZ3BSTlFxdHdwMkFhdXUzb281RVp3YjAwL0FVSjY1Wm1q?=
 =?utf-8?B?MXB1Tm1xalExVzE5NVdOdis0RVlnYjFUODRKbWplYTVCaFVVci94WUxQSFdS?=
 =?utf-8?B?enQzSE1tWk5vUGltWlhqVkhRR29jeXpWMzErdGE5TktjOVBIMUd3Z3JubE9j?=
 =?utf-8?B?ZmhDQlcyZndCVUlYb1dKY2NsNkthcVJFemtMSks0dE43MVArL3hFOWRCYy9V?=
 =?utf-8?B?WTN1QkJWL29oZEY2WGNJRDQrRWdwYnloVjN0ViszRWx3Sm5waDQzbDM0aDc1?=
 =?utf-8?B?YTFmS0o0ZExnQ3R1cTdSdjcrNWg1MHo2OGV2NmM3YjBZSXV6MjU5R3g0eDdl?=
 =?utf-8?B?bVRxU1hqTy9JQmVNbldXMHhCZ2x2SGo3aUJCSmZCR3lmV3Irc1VzZnRjbEt1?=
 =?utf-8?B?emQxbEM0MlBxMWpIeXE3SWJrRkVFWDVrRGxvelRNaVNicTR6NlgrbUJIYmNt?=
 =?utf-8?B?ZGlKdC9LYm1nYkV1UEM5eHRub0JleW1IeHhzV2pFUVQ2L0YxSWlUUHBuNDFq?=
 =?utf-8?B?dHJUcVNqVGZiblIvY2FQZlE4aUt6L1pTVVVSTkwvNklzajU0UXZIRitoWmlN?=
 =?utf-8?B?ajZQR3RGdWNSU3JqdC9rNE5DSnpSdXBHdlFrZitFTEszaW1WRXp1RVl4cHl2?=
 =?utf-8?B?cDVNajFJeXNyWTNWWURVeHRBdFowVWIvZ01BejkyYlFRRVBxTEloMFgvdU95?=
 =?utf-8?B?UGlHQ1JxVXc1VnZSQXVkcTBDZENHQUsyczVPbUtXY2N0eTZtd1JETEVPRHJt?=
 =?utf-8?B?d2tuM0RVZU1pbFgxc2drTzBaWFEwSHVSY2RDSDhtWUNNem5Tc3NIeHpSQml1?=
 =?utf-8?B?SFRoWnM4SXgyOG5iSHNKUnVqektoeUNJMEN4TFYxb2NhcjFBcWd3ajVCeU5m?=
 =?utf-8?B?S1RneVdSdjVUK1FlME85cFJhdlR6LzhVL3JXaVl5S0hHcys2STRHQlVMZHk0?=
 =?utf-8?B?ODZNdjJpTEtGenlLQzdsRzVRTGVpN1kvaDFDMEJUVkYzUXhObDB4MlFwektW?=
 =?utf-8?B?TkVWQTYrZGZNUEJWQTZLQ1lZNWt1dG9HbWpwZ2l0Y2k0cGlRRDdkYmtWSzBM?=
 =?utf-8?B?eFVmcXJzY0xsbUw0dWg0eTcySzFIc2IyeHhTbi9tY0tNT1N6UjFKUFZqUTA5?=
 =?utf-8?B?UFkwTlhpUTYwNlJoMTJMclpRYVNjZHBjcWdFdG5oamFmbmVUTjAyQ1hXZVNE?=
 =?utf-8?B?RUg2bm5TVUYwSmsrUGYxRDF5eENuajlZanZ0Yy91Mk4yR25HbEJaZyszc3pr?=
 =?utf-8?B?WVJUQ2NtdHBIYlhOT25oR25ta2hmVm9FNm5wd1FMZ1oyWWJhNlhrM0M1cTBB?=
 =?utf-8?B?NUlEajBtek9oMnFSa2dTaFB2NjRTYnA4dUZiU0IyTWhHTHRMVHVXZzJ5KzhO?=
 =?utf-8?B?ZU51Tmg4WWc0SkhmdHpYT1V1MkFKVE8wUHBIQ2VjYk96dU9jT1lmMUdwWXNl?=
 =?utf-8?B?Yld0cVF0NnErZDAvS2xHVzk3WXdaRE0xSnE0RTFWMmVXNVR0UlpLVHJjdXJR?=
 =?utf-8?Q?UxykROAgetdHhvpc6W82l2c=3D?=
X-OriginatorOrg: cornelisnetworks.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f383a1c-6b20-4381-2dfc-08ddf785d9f0
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR01MB6158.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2025 14:07:21.7926
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4dbdb7da-74ee-4b45-8747-ef5ce5ebe68a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /n6ET9coD2ErHChAivrZcJDgZl7wyyLAh8Jmya71NWNb74Qa6+G+8SeJtujqia4qYlurVy/cpYTTr2s111bLRPtsGkBdjMQGQYcfrhT7ZWCqMBFtoOM6EAQGo39Csp0R
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR01MB6864

On 9/18/25 1:53 PM, Leon Romanovsky wrote:
> From: Leon Romanovsky <leonro@nvidia.com>
> 
> Convert error logging throughout the RDMA subsystem to use
> the %pe format specifier instead of PTR_ERR() with integer
> format specifiers.
> 
> Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
> ---
>   drivers/infiniband/core/agent.c           |  3 +--
>   drivers/infiniband/hw/bnxt_re/ib_verbs.c  |  4 ++--
>   drivers/infiniband/hw/bnxt_re/main.c      |  3 +--
>   drivers/infiniband/hw/cxgb4/device.c      |  5 ++---
>   drivers/infiniband/hw/efa/efa_com.c       |  4 ++--
>   drivers/infiniband/hw/efa/efa_verbs.c     |  6 ++++--
>   drivers/infiniband/hw/hfi1/device.c       |  4 ++--
>   drivers/infiniband/hw/hfi1/user_sdma.c    |  4 ++--
>   drivers/infiniband/hw/hns/hns_roce_mr.c   |  8 ++++----
>   drivers/infiniband/hw/ionic/ionic_admin.c | 18 +++++++++---------
>   drivers/infiniband/hw/irdma/verbs.c       |  6 +++---
>   drivers/infiniband/hw/mana/main.c         |  5 ++---
>   drivers/infiniband/hw/mana/mr.c           |  6 ++++--
>   drivers/infiniband/hw/mlx4/mad.c          |  8 ++++----
>   drivers/infiniband/hw/mlx4/qp.c           |  3 ++-
>   drivers/infiniband/hw/mlx5/data_direct.c  |  2 +-
>   drivers/infiniband/hw/mlx5/gsi.c          | 15 +++++++++------
>   drivers/infiniband/hw/mlx5/main.c         | 14 ++++++++++----
>   drivers/infiniband/hw/mlx5/mr.c           |  3 +--
>   drivers/infiniband/ulp/srpt/ib_srpt.c     | 16 +++++++---------
>   20 files changed, 72 insertions(+), 65 deletions(-)

Looks fine to me.

Reviewed-by: Dennis Dalessandro dennis.dalessandro@cornelisnetworks.com>



