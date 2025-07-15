Return-Path: <linux-rdma+bounces-12182-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A2DFB054AC
	for <lists+linux-rdma@lfdr.de>; Tue, 15 Jul 2025 10:21:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D594A17CB19
	for <lists+linux-rdma@lfdr.de>; Tue, 15 Jul 2025 08:21:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 922D626C396;
	Tue, 15 Jul 2025 08:21:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="hHT7dmPy"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2068.outbound.protection.outlook.com [40.107.212.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C79BE274648
	for <linux-rdma@vger.kernel.org>; Tue, 15 Jul 2025 08:21:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752567704; cv=fail; b=FurzfToMnPVSokVXVWbjrtYJEEiLb66zkxnGZED6Qp8Dya1vdgkjjlTv/FSUpGQPdWZbNgBVV0y6E2l8r49xxrt/zue80A8dG8P+Bls8T9z57uHzNlbaO5mXQZKQkz+ly9W8Lk5GEVk+tvVTf2piOsHojmAArvYEVgCAisPXA4E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752567704; c=relaxed/simple;
	bh=VqSqIueOT+/Gkl2qDQxnRb4p23Kf1ZILgAju0ofav6Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=GEz/OyY8LCz7hao1PvkCsFXJFXK5WZFTMulvLaS/Q67n2yAIaKJsPI6MS6IWwSt/ABtRfrfZ6CIwhwVejdkTLb0larKoImCswXPGS8GhkuJTp175zWG3ueELq+fN+L4iY+23Ki2l1rZl48VsWNsk4z4yAVGQjXm4RDj+XfsOYms=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=hHT7dmPy; arc=fail smtp.client-ip=40.107.212.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jB0zt87vWygg5fzOTQLH5sUEDXMudpju24uG+DPJ44p+vPl8MLaHVnM8o2MvwQ/p3WTBlkSbLvetBgOqZRGUmD6VpctJSoDLsSHF6WHfoszyLMsr5zBg5dz5fHVTvJ48pP3nnKCp3RzacXujgmPyzZynKtrgm//ZRwXlD5Og1h26E9rmh0Sa+v/bTW9ee/ZqRg8ECNU7rC8KQsIdp8OFWjSINEe+QGQbeBTiCiglFT3eG1J+SnJPYF/vhupK0NrSa3QBoUdjwMSgGR9oX2LB1pSK8MpjyO7xiBX4x9YiTu4Pm7V9DueJH1jzOUjklFYUDf/+ZHc1/SMZ1tcy7zlbkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Wo7cwlM00o9LcFC3ewq0q9sFbj9TyOrzZETMlNKhoXA=;
 b=Hje68DFeUPoh+4jjYo9eQCzHA9CvRHeyM6G+sMJ+Fl7AmEiqaPJh+lAVq1DPIHWqnaG1bENUWh9VRTcWGkwAtgOKYSNEvM/76JRYRaggSThLMboCO+Z/pstMzlSHN0rJyuk0C2eE8p4qRtnF1bki9dltB1w+gVcgcg14ODoegWaRRcc4YMB9sEtg18YirQnv4NbxAngxU3g98E/np58gRanHOuYq7b58gBrck61H7BRNF0L6rCFsJaKUVgwQI/7PnDdR+csFWY0bUN9AIyLNO2cJHuPbOi1usu1txViGRguR3DdKKLezafYsBFlvlZiY94pUIA0J7hPscr1tAeenrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Wo7cwlM00o9LcFC3ewq0q9sFbj9TyOrzZETMlNKhoXA=;
 b=hHT7dmPywxqboYPRysIXD5rjwhNjEAmaH5kFIki4d6oFtcanxKYYubgUMz/4bY26RB7BV4UkALYdEM8mLMyg8nvKb292pEfOz2ztntyCTWGmsGVNPX47mlROz/nTlyN9TTwHMWRbxTHsL0HSQdFXnmdE4PmOyV7ZugyPDJYOp8K7sn+j/i0u2Od7DQPDCep1Yxtl8kqDFpYk7rc6hwEo0C2oKOSVoZq5rzjO65JoTTfl6TtjPkQtqI03VTXFJQT1ufiKRL1nNDAlALFV0Evs7bDuYcl8Vdx++QhQhFPoboYnH3mmFGu0gTsQ1yw5XAIdQUQyXt+vhZZ9O9xhAu/sjw==
Received: from BY5PR03CA0015.namprd03.prod.outlook.com (2603:10b6:a03:1e0::25)
 by BL3PR12MB6521.namprd12.prod.outlook.com (2603:10b6:208:3bd::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.23; Tue, 15 Jul
 2025 08:21:37 +0000
Received: from SN1PEPF0002529E.namprd05.prod.outlook.com
 (2603:10b6:a03:1e0:cafe::65) by BY5PR03CA0015.outlook.office365.com
 (2603:10b6:a03:1e0::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8922.33 via Frontend Transport; Tue,
 15 Jul 2025 08:21:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SN1PEPF0002529E.mail.protection.outlook.com (10.167.242.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8922.22 via Frontend Transport; Tue, 15 Jul 2025 08:21:36 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 15 Jul
 2025 01:21:18 -0700
Received: from [172.27.50.128] (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Tue, 15 Jul
 2025 01:21:16 -0700
Message-ID: <01b087d1-8710-4111-8ba0-b942f77a8b0e@nvidia.com>
Date: Tue, 15 Jul 2025 11:21:14 +0300
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH rdma-next v1 5/8] RDMA/core: Introduce a DMAH object and
 its alloc/free APIs
To: Jason Gunthorpe <jgg@nvidia.com>, Leon Romanovsky <leon@kernel.org>
CC: Edward Srouji <edwards@nvidia.com>, <linux-rdma@vger.kernel.org>
References: <cover.1752388126.git.leon@kernel.org>
 <b1ff9b142f785a52009b288567bf4e15dd34ecb8.1752388126.git.leon@kernel.org>
 <20250714163925.GF2067380@nvidia.com>
Content-Language: en-US
From: Yishai Hadas <yishaih@nvidia.com>
In-Reply-To: <20250714163925.GF2067380@nvidia.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002529E:EE_|BL3PR12MB6521:EE_
X-MS-Office365-Filtering-Correlation-Id: 6bd88f83-5882-4e53-b9c1-08ddc3789da6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?U25BTlNnR3VrenlDWXZxem1xaFllNEUrSEVjQW5zQXZEQXgzN3ZiandZb1pu?=
 =?utf-8?B?SmpKY2lCR1VmbEF4R0dqNUdNVnd3emQxcmRBenl0OStRUlF6bUFhUHJPRUI1?=
 =?utf-8?B?MUpGamhqVjVva3U4SW1iTE1ROU5GY1c4cTBldmJsWnJiY3VRVkZob0pxM0JO?=
 =?utf-8?B?ejFNZzNZTFlyOE0reVVaa2xxS3RSaVU0b29Wbi95L2lxR3BrVjZwaS9CQnFE?=
 =?utf-8?B?cVZ1QmV6cTZHdVNaUTVybWJaTTJRaXFsTW5ONUVYQXpqWjMrWUgvVkhtNEx5?=
 =?utf-8?B?alVVb2hJWnNCRVRhZ0lvUUZIRFI2Sm1yMk83ZGMxZHRVK2VRT2FtZzgzdHht?=
 =?utf-8?B?YTI5VVo5SnVwRjgzWU5LKzBpMGdpeTc2YjYzdzkvWTVoWDArRHNzOE9EYTVV?=
 =?utf-8?B?NE15bGs4VTlINUt0ZjlMQ3JwcTlyQkhKMXpJYmQ1Wk1FY0FVTjZhUVV1TGh2?=
 =?utf-8?B?ZktjVnNBemRPejM0UjVZaGNNSXcrME1TMjRDUGJpdW15ZnhYR2xPSE9ESTJ4?=
 =?utf-8?B?bWtiOW9JWUdaQ3Jja2w0UHRNbXNORzFLN2xTVjRkaWNqbkpCWDdtRW9HbTJW?=
 =?utf-8?B?NGRWY1U1WEMvbjFXNkVxVzR4aVVCU0c1RUFQNXR0eU1tYkdjeDVCcE50Mnh4?=
 =?utf-8?B?Tm5YZEhuZTlGMmM3cHVPWWpWbDROWndnb0hnZ0wzeDdXMzBhWUxqOFVTcnVY?=
 =?utf-8?B?bmxaY1ptMjRYUDRIODV5QTJWWktBMFBlNmZjMW1oclNud3RXNG1qRDN5OW4z?=
 =?utf-8?B?Zlk4RnZNSUlUcVZJM0NNQ1YydDk2N0FtVXF3bExCRUpHOEcvT3hYSC9YUUw2?=
 =?utf-8?B?MFUzeTV3WEVFMDN3cE1XckFJUmtFZHdnUi93clFONXk4U04wdlBJYVFpU3E4?=
 =?utf-8?B?WGFjaGs1VFJjdkUxMVdJTUFmMENiV05HMFFsbzZzWnJhRUNRdVIva3hNR1du?=
 =?utf-8?B?Z3pTRDJRdDRmMUQxRkJTVTY0b1liMEFsakVscTZWSm1UZXVVR1VRMlhTSnIw?=
 =?utf-8?B?SzhDVkZkQmx3VkM5NE0vTjdjczZKeVRzb0t4aHB6VHJaY3o5end0NVppQlBZ?=
 =?utf-8?B?S0lJMVVpWkorbHdKRHVmWXF5WFJUYlp1OGxZZkxZSy9HVzZuNjdvb0gvYTBD?=
 =?utf-8?B?WnRURExqenNieWlDelRNbHorL1ozSDdBSEptQjlTQmIwL25Ja05pWFcrOWRq?=
 =?utf-8?B?eGlTUHJVc0U2OXJOaE5JQW5JR1lwRUxidWhmYlNscjhSc0JpZFBTd0pRc3Bu?=
 =?utf-8?B?UFFrVDRxTXNxR3hRa2ZDOHpTeXB1VXNQR1ZFNkJYbGRzMFJ6SmJXZ3dFYklq?=
 =?utf-8?B?TTc0QnNTa3lwQngra1J5NFpadTFkMjlkbXZpY3JXdUZjUkJyeitHZFRBOS81?=
 =?utf-8?B?THJSdWxIYTRlbFZCdklYdkxmNXJ6eFk1MmZhV3NRN1dnSlA5U2VMdFRmSjhI?=
 =?utf-8?B?aFZzT1VqVXZGRjdxNk1HQjMxSGZXMUxSYTVLL0lxVzFCSTdtRng2VzU2SHN0?=
 =?utf-8?B?cnJscGp6STVTemEyZW5MUDhnMEdoWVdiTXhCZjFMbllaQm55SDYweWRpU1R3?=
 =?utf-8?B?WkZkRTJMMytaM1hHbVFiU2ZYRmVWMEY2NHBQTXZUa1AxMTRDS0tVcFQwSXpH?=
 =?utf-8?B?ZzQ5amROSlRhYnNMeGwyK3lTSUZzYVRCVVBtVTV6UHBpbm8vaTc5TG4wMjNn?=
 =?utf-8?B?QTJxSWttSEJoUjY1bEZkWFNzV1hPNUpQNjBKRWorbHdzRWhiSHc4bUdKeng1?=
 =?utf-8?B?ejZVM3BTQVRhU29naDJ2ZVQrRExNN0YwOW5OeTZzTHlXdHRmeUhrMmwxUm11?=
 =?utf-8?B?RHM1TDZhVUk3cDlxK25ZcUlQKzhORG1rTmgydFlnbjloOUJ6NWpHQmUrN3Vu?=
 =?utf-8?B?UTlCbWh0V09DSnRVRW5WYkJZR09RUnpQVzZDOExHaVoyZnBkZm5mUkZLQnN1?=
 =?utf-8?B?Q1ZlSUMxVzFKZUVGejhpWlU3Yng1Qys3TkJFcG5pdmUwSmV2d3Ayam1JbjhV?=
 =?utf-8?B?ZWVPOUZja1JFaDd0TWIrWDFUUlhNb2RtL1Q0bndJeGdoZGM1bXlSQms4V1Bq?=
 =?utf-8?Q?R2ibXU?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2025 08:21:36.3291
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6bd88f83-5882-4e53-b9c1-08ddc3789da6
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002529E.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6521

On 14/07/2025 19:39, Jason Gunthorpe wrote:
> On Sun, Jul 13, 2025 at 09:37:26AM +0300, Leon Romanovsky wrote:
>> +static int UVERBS_HANDLER(UVERBS_METHOD_DMAH_ALLOC)(
>> +	struct uverbs_attr_bundle *attrs)
>> +{
>> +	struct ib_uobject *uobj =
>> +		uverbs_attr_get(attrs, UVERBS_ATTR_ALLOC_DMAH_HANDLE)
>> +			->obj_attr.uobject;
>> +	struct ib_device *ib_dev = attrs->context->device;
>> +	struct ib_dmah *dmah;
>> +	int ret;
>> +
>> +	if (!ib_dev->ops.alloc_dmah || !ib_dev->ops.dealloc_dmah)
>> +		return -EOPNOTSUPP;
> 
> This shouldn't be needed, use UAPI_DEF_OBJ_NEEDS_FN() instead.

We already have UAPI_DEF_OBJ_NEEDS_FN(dealloc_dmah) below, so the check 
for !ib_dev->ops.dealloc_dmah can be dropped.

>> +DECLARE_UVERBS_NAMED_OBJECT(UVERBS_OBJECT_DMAH,
>> +			    UVERBS_TYPE_ALLOC_IDR(uverbs_free_dmah),
>> +			    &UVERBS_METHOD(UVERBS_METHOD_DMAH_ALLOC),
>> +			    &UVERBS_METHOD(UVERBS_METHOD_DMAH_FREE));
>> +
>> +const struct uapi_definition uverbs_def_obj_dmah[] = {
>> +	UAPI_DEF_CHAIN_OBJ_TREE_NAMED(UVERBS_OBJECT_DMAH,
>> +				      UAPI_DEF_OBJ_NEEDS_FN(dealloc_dmah)),
>> +	{}
> 
> I think it should be on the NAMED_OBJECT in this case, like AH:
> 
> 	DECLARE_UVERBS_OBJECT(
> 		UVERBS_OBJECT_AH,
> [..]
> 		UAPI_DEF_OBJ_NEEDS_FN(create_user_ah),
> 		UAPI_DEF_OBJ_NEEDS_FN(destroy_ah)),
> 

The NAMED_OBJECT doesn't support UAPI_DEF_OBJ_NEEDS_FN.

The UVERBS_OBJECT is a legacy one which was replaced for new objects by 
the NAMED_OBJECT.

Am I missing here something ?

Yishai

