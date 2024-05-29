Return-Path: <linux-rdma+bounces-2669-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A0BF38D35E6
	for <lists+linux-rdma@lfdr.de>; Wed, 29 May 2024 14:01:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2BD211F25336
	for <lists+linux-rdma@lfdr.de>; Wed, 29 May 2024 12:01:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76EE6180A71;
	Wed, 29 May 2024 12:01:22 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8668E1802CB;
	Wed, 29 May 2024 12:01:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716984082; cv=fail; b=Dm22xPPuqhecx+dWSs6zHYgSzNznuNrrzZf6tF/NaMgCQKd6i/8TYpaR/1KTI0e+rkzNIatrbrNwdjCbn9GjVIuMEJJqd51fynNxn2M6NaUSP52I7EkPJF+JbcLqmI04tR8IucrHYJtnTOdGuGtOkvq7XVgetF17hXBYTFqkxrA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716984082; c=relaxed/simple;
	bh=Wvw/JClM3ohxsdv8pf6O5dyht8KR+WUZoBHemAWsBeo=;
	h=Message-ID:Date:From:Subject:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=CxhkCscFolhN7r5gOwh98lpaGnHyzfWWQWFMgtzK1WaAZ3KrbnAwHcmlG2jm9L0tHQ5rpJSjVwJ/8A40cHtgur/xbqXUkK8dw65T5BG/EoAgwiwFBB9IFsKOk5Fsc4VUNRb2H5aWxO/uItV0n+qW4l954ilN4a3IFcnvEDGAiCc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 44T6IGW2031545;
	Wed, 29 May 2024 12:01:17 GMT
DKIM-Signature: =?UTF-8?Q?v=3D1;_a=3Drsa-sha256;_c=3Drelaxed/relaxed;_d=3Doracle.com;_h?=
 =?UTF-8?Q?=3Dcc:content-transfer-encoding:content-type:date:from:in-reply?=
 =?UTF-8?Q?-to:message-id:mime-version:references:subject:to;_s=3Dcorp-202?=
 =?UTF-8?Q?3-11-20;_bh=3DJl76LIcWRdojsPalSWO3Bok1qtquK3myXWh+prZVLac=3D;_b?=
 =?UTF-8?Q?=3Di5toOvj0EGr5DgpMbIXCk7yPAT0kkrA2ZgSYQQ+yFPBehcVqAqpZ7Lx92KrQ?=
 =?UTF-8?Q?XLWVuIsF_Kg+U8lhd+XLAacIUe3yOAwQ4k84xHYOXUEPi1FrXSjI/lyjW9jOK6v?=
 =?UTF-8?Q?yYw3A7rDkhtaOG_XO0LMibwzY+5Cp5eC4M8s6wHNg7CbhyvNPoTy13CqXHhi+zh?=
 =?UTF-8?Q?7A+vEu1CqyOPJQpjS6AY_W0ofSGmgI9vwVQk4TZ1AOh9UilY/fJStvwX2TQtW2e?=
 =?UTF-8?Q?GBWtYlEnQNJiG7O3hS2BuSDBWV_VDwPkWDqFTOHy1RWZ1/Cl3HLVKe0SOJJCiHI?=
 =?UTF-8?Q?3hH/3K1aHoTzXADJw7oBRczN2HWvxrp7_uw=3D=3D_?=
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3yb8p7pdf0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 29 May 2024 12:01:17 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 44TBbhRG024012;
	Wed, 29 May 2024 12:01:15 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam02lp2041.outbound.protection.outlook.com [104.47.51.41])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3yc52cduyf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 29 May 2024 12:01:15 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Xa74zbkIUvuv4TDTRhKjFhDckcsSTP64cHLUuX1rtWeSIj0Rsz0tPlRyC2lGDYV18LhXQ4x065su3FusTzx/vxO4p67xYom8tk4SWpsvmXhnTuBNQB45K/tfQmjC794YrDk3/vZBZU8QKODvi2MsEP3BqBB3dWmeZ55fr6Fv/6YHUZPnZ3MCoyoL3+qTO9JqDuwMFn6NQ+Q0ZjBlPI2tStyWmynMcsVJhQr1HFfeQjlwgVPwIbMgEAfKJW3ulOPdqInfPeuZRCVL210wZ/tIgjIMtnI2uQbXB1UB9UGyS6lAiMc8gE7lNzRTNFBl4+oW+JXwP2KcydXkLRmuiMbJEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Jl76LIcWRdojsPalSWO3Bok1qtquK3myXWh+prZVLac=;
 b=aqJH/ycCOskZNPUSlpmmKa0sxLiS30057RlXQ1V8GLdG/WJLFOpHAVMJsgr9a8sO7F0FPLR+fbtHwu7/VWApcRAvwRL2OkdIRSzj6zGLRjVKd6D26Qx+o240jAKOMMKNB1eJZwY3nbfu2uXv34cJNu8Tw2bKnVEFb70a0NTfn7i0+/J1N4ssqzDmUmWzDWEkSAcHtGz9JbvfX033akp8srfb5BFzcIJDku6tNmQFcFO6MCzrqzwJ0afp4WO9rRm70stBh/YGgajY8uMDg8Z6e4fXsWNbe12RbLOR3oOC5S4iDUCxLPuUARBzJ1LqnyYNvvogOJ/x0CzNcVve/k3R1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Jl76LIcWRdojsPalSWO3Bok1qtquK3myXWh+prZVLac=;
 b=wg+YLTTbZumgA3tJHvwnL23MxMFSe/qRK9cf5AM6tGV+BfFSxTx+InmdfdJNdGSXkoLK0mLPxM2Afg7ay0tN6b5oqJDEI+Vn7Al1lvb28RbRBllBMHiKCRGuv11Qfl73S8BuyTU6ecned7GXmLbfNd87pgRe6SHwmanxVo3M1Ls=
Received: from DM4PR10MB6111.namprd10.prod.outlook.com (2603:10b6:8:bf::9) by
 MW4PR10MB6560.namprd10.prod.outlook.com (2603:10b6:303:226::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7611.30; Wed, 29 May 2024 12:01:13 +0000
Received: from DM4PR10MB6111.namprd10.prod.outlook.com
 ([fe80::d8b5:ffc:6b9a:b777]) by DM4PR10MB6111.namprd10.prod.outlook.com
 ([fe80::d8b5:ffc:6b9a:b777%4]) with mapi id 15.20.7633.017; Wed, 29 May 2024
 12:01:13 +0000
Message-ID: <04591dbf-57de-4d21-8009-5f462fb59c73@oracle.com>
Date: Wed, 29 May 2024 17:31:02 +0530
User-Agent: Mozilla Thunderbird
From: Anand Khoje <anand.a.khoje@oracle.com>
Subject: Re: [PATCH 1/1] RDMA/mlx5: Release CPU for other processes in
 mlx5_free_cmd_msg()
To: Shay Drori <shayd@nvidia.com>, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org, moshe@nvidia.com
Cc: rama.nichanamatlu@oracle.com, manjunath.b.patil@oracle.com,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>
References: <20240522033256.11960-1-anand.a.khoje@oracle.com>
 <20240522033256.11960-2-anand.a.khoje@oracle.com>
 <a26f1947-58fc-48c4-a8f3-4fe2a274afa6@nvidia.com>
Content-Language: en-US
In-Reply-To: <a26f1947-58fc-48c4-a8f3-4fe2a274afa6@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN3PR01CA0177.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:de::19) To DM4PR10MB6111.namprd10.prod.outlook.com
 (2603:10b6:8:bf::9)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB6111:EE_|MW4PR10MB6560:EE_
X-MS-Office365-Filtering-Correlation-Id: 2fcb316a-c4da-43af-3e92-08dc7fd7093d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|1800799015|376005;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?Sm5UblAyK3pVNUVjWWJac3JWVUczK2llbk9iY1hJWW5pVjMrL0xINnRFcGJR?=
 =?utf-8?B?dDlkY3daby9sQ3FjMWZSbUhsYlpaeFpoWmwzai9SK3FOcklqV1lKNTJrbjNv?=
 =?utf-8?B?RmxSK3J0amRSMExldmE0bGFzQk5qTXh4dERNZkpscHIrMmlHR1hxNlp5c25w?=
 =?utf-8?B?eEZxOGw1ckFVcndKTzRJdDg5WWhvSEFaaFFZL3NxWktHWldQbDVPd204ZWp0?=
 =?utf-8?B?QjdDdUVCSXBnbEZEZXEvdzQ1UzR5UzNwNWFKV3V0aGtVSHJ2MW5IVkNYdjBU?=
 =?utf-8?B?SDVGRlUvSDJSL05TTlRmNCtPVGFZMWZmNmxON3kxemFJVWhYU0M1bXdMNEg2?=
 =?utf-8?B?QmNDNktsMW1ZdHhMZWdVajl5cG5YaVlzZDVOVzdmUERMSTF2ckgxYjZiaVlk?=
 =?utf-8?B?RW95RkRpeklMeHk5bUJpRmVkNmloT0hBNys5YTRZb0pxYXNwY0RVMjBnOFRM?=
 =?utf-8?B?M2Y5SzdobHoxQW5LaE40czBOZ1V1SFVvdE95SlRFeFlhRVR6TDFUUlZUTlA4?=
 =?utf-8?B?em9DQXJoRVVwdnJmSUh6VFpIZkN4QkFUeDlqZlBTTEgyN0xyT2VzYlByWmVl?=
 =?utf-8?B?dzQ1UEM1c1lsQ0R3ZFBYUlBoSUlUT0FMazdtVHVFakczcUFpN1REWldJN0sw?=
 =?utf-8?B?U24wUmwxNGFuU0MxNUdkZFNGckVxaG8vT0xWUTd2QmpEUlRnUWtaKzk0ZTJl?=
 =?utf-8?B?aWtRaHcwWDZpcUkzU3E1eFFJYjhGb0hEVlFGcm5ZVXZmNGRMcm1hSUxHS0li?=
 =?utf-8?B?U0NHelBrbkxLQkl6VkFEbGdPUzRnOEs5TUx3L290czB4WUZua2VaTEk0NStq?=
 =?utf-8?B?VmNyckZ3MHpmRlROQnMvL0tudnhTQmtMY3RDL0tsQzY2SnVidXE2MmY3Mkxw?=
 =?utf-8?B?MjZJaUIrMFUxSTVKMnhqcytjdmgzUWw1RGpsbVo1R1JJUEZTcHBPVE9iVWxv?=
 =?utf-8?B?VE1NT3N5MFNmYnZYb2Q5aDY2OGNYZnRsZzVkVEV3WGdQT1UvcU9lMHlscW81?=
 =?utf-8?B?Q3ZJWk4yT3ZvTFNzRDREcy9XQnZQQm9EVmFxMjlTcWluMjdZenk4c0E1RzQw?=
 =?utf-8?B?cklNRXNZRTRTMXVQbXY0SjlWakFIeEVOMFVKcUJFVFJNMDZQZm5pMUFXUTJZ?=
 =?utf-8?B?eEZZUFFJNjdXT2NOOFBJVTRtaTI2NkJwZmM4eHBpWFZ0cWV1dVhrMHhaSWU2?=
 =?utf-8?B?UjM1c3RhL3VyU2lxbnpXcGIzOXk4dDNIa0dmZUo2S2NyNVRVTnZCcFJNUWo5?=
 =?utf-8?B?SG5YdFhEYkkrUnVWUzB2bDJsQ0FMbXpFY2ZiakYvY2ptWkZpQ0hmbjF6UVRZ?=
 =?utf-8?B?NnRISFFaSHdiU2lDMWpxTUdUcllteEIxL3NIcU9mUG5DZjVDQ0daZDYxeWRl?=
 =?utf-8?B?MlU4VjV6YzZNUElLSFFYdC9Bb0kwbCs1b0JnZGlFMDhxdWxRNkQ4SFR0b2Nm?=
 =?utf-8?B?Ly9HOGx5RXA2ZnNwblF0TkFDOTBTc0FDdDFSYzluc0VBeHlsbFhIVnFBcW02?=
 =?utf-8?B?ZGJYVzJqbWVIcStIUHJuTmVOdjNlNzhJMWdtQklvY3MwZElBYkFnOC9HQ0ZF?=
 =?utf-8?B?SXd0OXhQVmF5d2pVZ3QxRENhZFFJZVFmMUhjSEo0N1A4Y3Q2VEpKVkFlTjd2?=
 =?utf-8?B?d0twUmV5THIyTXI0OXdvS0U2MERxbFB3SG5mclBTQXJOK2F1WnNVR28wdTRx?=
 =?utf-8?B?NVhxcnQxTmFWci8yNzM4U1RhZDIyVjFoSlExeHdMMXVJaWYrSVQrR1lRPT0=?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB6111.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?SkpVQ0JHTVFpWFA3bjFTeEEzRVlFL1FiOE1BeklXM2lOekdXZGZXTUY1cHNO?=
 =?utf-8?B?U2VsazVOcEI2Qm9aSS9UUnM5cW9vdGNYY2U5Ump0enRrY2RQVEFReWN3U252?=
 =?utf-8?B?ckNQN05qNG95T1lLMW5aMWRXRXVaOUcwV0w2K1l1ejdPaUY3dUtzTTd4bmVN?=
 =?utf-8?B?M2FNMVVaVFozODlsaVk4RlhZNG9Gdm84endOaC8wRThCUzZSd2RhZVFJUVRh?=
 =?utf-8?B?aWYwQlRQU0FpMlZDNEoxM3hVaWE4ZUt1ZmppNVZ1c0FEUUZ3NFpNVkNmZER0?=
 =?utf-8?B?bkxqOVJ4REJ2MWMyYWVZaFR1WnRFaVR5d0dSbTVZQkdPcW9ZRUw5dDhQcWpT?=
 =?utf-8?B?UDViTm45cTV5S2FFTGFuK2dKM0xXYVNORWpnUVBUR1hqTlE0Z05NNENXVWh3?=
 =?utf-8?B?Q2dDQkpIa2MyNXdFd3d1cmhNZUhSa1pWQlJCeXFjbE4yRDB1Q0w4bmhzdDZW?=
 =?utf-8?B?Vk9CdXZxTFg0L0ZGQTZsb2w3c1pKTTlKL3Q2c1Fsck1JM3drQkZGUHJONWow?=
 =?utf-8?B?cXhrazlsMEo2cEZXdVMwOU5mTU4vTStpSXF2cVdROHE5QS9jRjJwajZvZ0Zq?=
 =?utf-8?B?a3dzQ0lCc1VPaHRhK0h4dnZ0S2d6RHdWckJld3dUY1VYZWIvbzNxeWMxeVBk?=
 =?utf-8?B?Mm5IYW1YQXFWaHFRM0pqVGhFUEd5YVphV3g1WGRYdFN1T3J6Q2cvSmlpVTVu?=
 =?utf-8?B?Um5tRmZRUDR6SWNUSThIdmY0WlBZbGhab1VGNkVNTjhobVZLaHEvZ1FBcTlB?=
 =?utf-8?B?TEt3ZjlGeVFYSlFzejArQjYwLzhCMkFldzZoMndsRXhKTjZnRFRvV1E1ZWwr?=
 =?utf-8?B?VVlyNVBYQ3FwMUZBYk5ZUmxJUEt1ZWZIdEdrN1RXMWw1L2tPM2VmMHhMSDhj?=
 =?utf-8?B?NEtIOFlmUnNUbHhQVDJUYm82VkFSaTFDWDRhZTRVUFQ2SUZFb01mdUhuNVJR?=
 =?utf-8?B?N3JCQkhrTTMzZGpsTUU5N3h5eFBhK2E1K25XNHkxMDlLRmZNMFduWEwwQ0N3?=
 =?utf-8?B?RTBOY1VNYUJVbkZVbGFKUG84ZW96VXZZaS9pUWJENFBjaEd3K0w2dkRLWHZX?=
 =?utf-8?B?RzluWVk3VzZBbnhidFdVckd3dFQ5NzdncVVhVkd6eFl4NHFJSGprWis2cGlC?=
 =?utf-8?B?RE9Sek8yQ2Y1djJXYjMxNmcvbjM4YUpGdVJKblBEYzZJY1ZLSUhaWjExWHZP?=
 =?utf-8?B?T2o4VFpmMUdubTZVUEpzZkRlcDduNkYyaHd4bjVHUlZLRlNFMjVmZEdKQW8v?=
 =?utf-8?B?VnF4QWRFRHBLVTZ4WlZLYVVNNlJCdVhzSlZLN25sVEdSVHFoR01BRlFCRkRt?=
 =?utf-8?B?eEZIZGdPbWNyQlJWZXZIaEh5a1BTeUIvVHI4dHBsLzZTamNwSlhUOUQ1VmJr?=
 =?utf-8?B?OU4xeU1KYXphOFluOGxUcDhsbFhLMWhqdzVKS1pSRS92UGJYYTBhQU15WjlY?=
 =?utf-8?B?Y3FiZjJKamM5YWZXQ0tKaGEzUlJJMURUT1JacFNPMG5UNTh6eDNHZkFYczB6?=
 =?utf-8?B?S2dWZ2NCRDM3UmpaZXNBcUEvUVd6UnorTThnOWVFQk5ZUXVTQldqbFU0YW45?=
 =?utf-8?B?czhzd1kxSm4wNGM1OTNuZ1AwZ0hoZW1RTkJ5anB0VHpjR0pJMUExTkpJcUp5?=
 =?utf-8?B?a0gxQTBLa2VMYXJUeldrWGdldE0wSG1pVjNwdTJOeVQ3b3NtYmt4MU1CZlN0?=
 =?utf-8?B?V21ldVlPK2RZRHlheEFNWTRYZkVQV2RvbXpHbTAybHlIYXE3S3pVcEdvUURk?=
 =?utf-8?B?ZU04TW1EeFZxSENpWGVWRTJPa3NHR3RvTDV0bTNZSERYaXhQYloySkg0dktn?=
 =?utf-8?B?YllYbkhhWUNGeUJ5MC92YmJSYjlJZHZPaGh3QzRlTzNvaWlMN29uWHdpRkZB?=
 =?utf-8?B?Yk1WejVXSW4wUlg2cUxSZElCRUFDUVlpTmpaSGYvWGZmRXh2enBkUm9mL3Qz?=
 =?utf-8?B?cVFlUk1jckVPYTM1WHkwMklpMlhSbldCdFBJa3JaeG84clNaVkRXUytoZkpO?=
 =?utf-8?B?U2orS1dpdDd4TkN5clFFcFc0c1ZzSnBxVWg2bDE1dDdCcGp0U0E5bTJVeE50?=
 =?utf-8?B?Wk8xK2xaVC8zRXBjb1ZrV2NSMFo1UlJoRE5ab1lSWk5QcC9Fb0dpdWpIcjUx?=
 =?utf-8?B?N1NPMFdmMVgxczQyVHY0d1VnTFRIclF3d3l2NGo5K1J2MUIwN0ZBMENsbTU5?=
 =?utf-8?B?cVh2bUVtbHcwSWNYRXZOSStiaFJuSWxYZVprNU52aHl4SUlVUHJYKzVNaGNI?=
 =?utf-8?B?WXZ5UzNReHJLdVVKcHRONXp2bm1RPT0=?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	fB9xzZxea4vmDf7mawiWKj+p4SP9IxO/UL2zWWmtu/E/ChNVJBXX+SzQIH+L7KyC5u29/1wnAK5WlW9EP63GHzOttlck6LYtTsRRgGgL2rXRl+sKtV818wM+4iEc//kyE/3P6BOsdmZloUnLHX9WJirpVY0zfh3m+y8nuwJRjwUtd0w0weRCL9vKd4n1rBrBCmt5pSzKwMi5g+ueyNCBT9caXtIxt5DKdbqfFTWeqA7cdyiN32Dnq23wRI+ud8fGvGgmkC8Ntu3Q93gVWYaLmP2fNGrMWYR0iCnNiHvYIn0sB9/UNIgy4LSGPAh0gXzlNdls0oG968ZqSyWPswkqgdDCLBQWIuHyy7BxygspAFnwW5UYlWDgl72MaJdXlWCrNQjytmh44f+407WajpSSEuJGcboS/bI2DQFSZg9wJop6ia56rRKXbH2sqzDh/PhDc5m5CLvktWfzQtvo+5YwnbRFZNPG1Hmya3PaZm6Vtin9mljIp6Vom5Dpj8IdVR9+KiIO+i46XYX+HQ1d2Ggu2rykp9zHZFj+kSX96UPfWqz+37c2WVwnI9/SiJ/OgsT5SyxTnlW3OMcrB2rcOGL43u1mlg+ezBOBtv74iTUV5O4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2fcb316a-c4da-43af-3e92-08dc7fd7093d
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB6111.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2024 12:01:13.2905
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MIKsURfK0bV2c4ojuOhFwcuT9+sOWFPq++KLQh9XhwcFh2Tej4i80sdskyQyFGhC+Hm+oPvW+f9qv2U4/++Go4bJWikj6uLT4yaEoUsoQjY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB6560
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-29_07,2024-05-28_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 malwarescore=0 mlxscore=0
 mlxlogscore=999 phishscore=0 spamscore=0 adultscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2405010000
 definitions=main-2405290082
X-Proofpoint-ORIG-GUID: I0KtqyjEKtlQgYhfpIP2TgKUDDfZG5pF
X-Proofpoint-GUID: I0KtqyjEKtlQgYhfpIP2TgKUDDfZG5pF


On 5/26/24 20:53, Shay Drori wrote:
> Hi Anand.
>
> First, the correct Mailing list for this patch is
> netdev@vger.kernel.org, please send there the next version.
>
> On 22/05/2024 6:32, Anand Khoje wrote:
>> In non FLR context, at times CX-5 requests release of ~8 million 
>> device pages.
>> This needs humongous number of cmd mailboxes, which to be released once
>> the pages are reclaimed. Release of humongous number of cmd mailboxes
>> consuming cpu time running into many secs, with non preemptable kernels
>> is leading to critical process starving on that cpu’s RQ. To alleviate
>> this, this patch relinquishes cpu periodically but conditionally.
>>
>> Orabug: 36275016
>
> this doesn't seem relevant
>
>>
>> Signed-off-by: Anand Khoje <anand.a.khoje@oracle.com>
>> ---
>>   drivers/net/ethernet/mellanox/mlx5/core/cmd.c | 7 +++++++
>>   1 file changed, 7 insertions(+)
>>
>> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/cmd.c 
>> b/drivers/net/ethernet/mellanox/mlx5/core/cmd.c
>> index 9c21bce..9fbf25d 100644
>> --- a/drivers/net/ethernet/mellanox/mlx5/core/cmd.c
>> +++ b/drivers/net/ethernet/mellanox/mlx5/core/cmd.c
>> @@ -1336,16 +1336,23 @@ static struct mlx5_cmd_msg 
>> *mlx5_alloc_cmd_msg(struct mlx5_core_dev *dev,
>>       return ERR_PTR(err);
>>   }
>>   +#define RESCHED_MSEC 2
>
>
> What if you add cond_resched() on every iteration of the loop ? Does it
> take much more time to finish 8 Million pages or same ?
> If it does matter, maybe 2 ms is too high freq ? 20 ms ? 200 ms ?
>
Shay,


There is no rule we could use, but can use only guidance/suggestions here.
Delay if too short/often relinquish leads to thrashing and high context 
switch costs,
while keeping it long/infrequent relinquish leads to RQ starvation.
This observation is based  on our applications / workload, using which a 
middle ground was chosen as 2 msecs.
But your suggestions are also very viable. Hence we are reconsidering it.

This was very helpful. thank you! I will resend a v2 after more testing.

Thanks,

Anand


> Thanks
>
>>   static void mlx5_free_cmd_msg(struct mlx5_core_dev *dev,
>>                     struct mlx5_cmd_msg *msg)
>>   {
>>       struct mlx5_cmd_mailbox *head = msg->next;
>>       struct mlx5_cmd_mailbox *next;
>> +    unsigned long start_time = jiffies;
>>         while (head) {
>>           next = head->next;
>>           free_cmd_box(dev, head);
>>           head = next;
>> +        if (time_after(jiffies, start_time + 
>> msecs_to_jiffies(RESCHED_MSEC))) {
>> +            mlx5_core_warn_rl(dev, "Spent more than %d msecs, 
>> yielding CPU\n", RESCHED_MSEC);
>> +            cond_resched();
>> +            start_time = jiffies;
>> +        }
>>       }
>>       kfree(msg);
>>   }

