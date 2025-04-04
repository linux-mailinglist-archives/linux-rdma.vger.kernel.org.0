Return-Path: <linux-rdma+bounces-9162-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E942A7C1D8
	for <lists+linux-rdma@lfdr.de>; Fri,  4 Apr 2025 18:54:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 09FF217D61F
	for <lists+linux-rdma@lfdr.de>; Fri,  4 Apr 2025 16:54:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCE10214A76;
	Fri,  4 Apr 2025 16:53:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hpe.com header.i=@hpe.com header.b="guydS8fA"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx0b-002e3701.pphosted.com (mx0b-002e3701.pphosted.com [148.163.143.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FD9D20E704;
	Fri,  4 Apr 2025 16:53:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.143.35
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743785599; cv=fail; b=qjR2QOaC0dyhwLcB8RKUn0lhOFM+zIWV2zJQZCA62qkS0E4tG+GFJFeblnt9V7AnsXm3RxLxUdtPPvEs+EAFW2cQDa6zHymT1ls18QGghR8uM4nJ4koL1LwgEmalD9rdleO+IAmt6/Cb2WdjcCvwq4cv9SlSkCm3g5+QVIJfn74=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743785599; c=relaxed/simple;
	bh=b3D3DsOZPemH2zpWnYC49HY8P1tevwyy6Y2/HOBwYjc=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=aP59QGabxXMZ/Lcre2xH0xr3oY/ISQR2UHKavFuhG/PUNIVapTXINzxUL6+Ca1bhgMZHBsRFlmgJ5oQFm2qkvc+Wl3roNNvePaqirbvxI8CXCVaYj/Woc4njYmwt2CLx3otjhOuwd8+OHTUpUBc2FCBepiefGrNmxIM6upTzGXM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hpe.com; spf=pass smtp.mailfrom=hpe.com; dkim=pass (2048-bit key) header.d=hpe.com header.i=@hpe.com header.b=guydS8fA; arc=fail smtp.client-ip=148.163.143.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hpe.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hpe.com
Received: from pps.filterd (m0150245.ppops.net [127.0.0.1])
	by mx0b-002e3701.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 534G2T6i015413;
	Fri, 4 Apr 2025 16:04:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pps0720; bh=wo
	YsYtTB4IY75TMTAUcRtlZjOR3d/8kWXHsSxnzm/sA=; b=guydS8fAmI9y2J9ltM
	OZ7W7arFZWX0Vs7gaMElP4TlGmnFUnMfybrWcq1m2Gxd1GV68Y0dxgqb9TZuE7pD
	bWfd6jasv2DcY3hk7V/UbgEgfDrtg2gn68L2kfDDz1ljzCFW0PdwIkAbCP82EI0Y
	DxweF0s8C8gp/sav/Bn+tqkfeLlK+kvx/KNek2c/bMLIoyBnrVbsDuA5RKxsyWTZ
	f9OPfigXe9bbnDJRtqaHxzwf1KS7BCu9Y3a0QxvX0GALmi4nMjJUUR1OYEt1gYWT
	aTJbvkuXSdBLZR7Pbo1X5gBg2NlPKHL5asyYRQppeTAK378Uj3NfKYuYDr6kB6qY
	wNgQ==
Received: from p1lg14879.it.hpe.com ([16.230.97.200])
	by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 45t2c7r0r6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 04 Apr 2025 16:04:00 +0000 (GMT)
Received: from p1wg14923.americas.hpqcorp.net (unknown [10.119.18.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by p1lg14879.it.hpe.com (Postfix) with ESMTPS id 3A0E7130B4;
	Fri,  4 Apr 2025 16:03:59 +0000 (UTC)
Received: from p1wg14927.americas.hpqcorp.net (10.119.18.117) by
 p1wg14923.americas.hpqcorp.net (10.119.18.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 4 Apr 2025 04:03:48 -1200
Received: from p1wg14920.americas.hpqcorp.net (16.230.19.123) by
 p1wg14927.americas.hpqcorp.net (10.119.18.117) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11 via Frontend Transport; Fri, 4 Apr 2025 04:03:48 -1200
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (192.58.206.35)
 by edge.it.hpe.com (16.230.19.123) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 4 Apr 2025 04:03:48 -1200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yXQSUd63lpyqY+pNRi8vEoAC8D/g2sZGv0RVZaXcbYIMnx73UcQNyLio8yK3jvtfL0UWzupOgwAj4H4LeUuhRn1pwdDQr/A+QHPkanPPvexGR2U5Nwhv3AZ+hcB2mB3doEGM7g+ez5p7eltyWZM8Y1/jpoxsuMACK9Si0zYIczFugD3ZiRrulI4h4arz2MVwBPDqGbPCfMMecJgaPfAk7NXQGuA3hoCFN+rLg1Q6u0yxpPLYgk/hUnWBql5GxEMz88+8WYyC1FQpT0qOyNfEh/N9tY+U2RxU5BecLpeZoLSBAycBHLDCyV5h8CyboYIpJEUpJtLWAGW2uGLv0qWFEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=woYsYtTB4IY75TMTAUcRtlZjOR3d/8kWXHsSxnzm/sA=;
 b=zDvEGayIgoiWIaLOkarmNTrRvlHIv4hauD3D3KoyldcOKuzOCNI4ZJVdTk7GdBREtzEXJNLQYbEyDrEMboPiNZT5i62SPJryQYaMYWJsAsaIF5CeL3YcM3J9is346Tq4tLWKZKmAzgi+LvtWKYw1IeIdKHo5gQ4sju+2Hj+HUDg6g5P5yZO8q0i9UCceTYtdR/jyY6+lsUG3w9aLSqQv0qCxIXoV5p1fsFH83XHmN6+8zf2Z3NZBwV62CuOy/U3yPu9nFULH9MTBnkeK1TETKywEizNh2M6Yk+/ijE+33ykDkiIwCjcbLacJyiggFA4zojObTYCEcxwn+bjbjVKgFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hpe.com; dmarc=pass action=none header.from=hpe.com; dkim=pass
 header.d=hpe.com; arc=none
Received: from DM4PR84MB1447.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:8:4a::16) by
 DM4PR84MB1421.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:8:48::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8606.27; Fri, 4 Apr 2025 16:03:46 +0000
Received: from DM4PR84MB1447.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::6781:5ecc:8646:f06b]) by DM4PR84MB1447.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::6781:5ecc:8646:f06b%3]) with mapi id 15.20.8583.041; Fri, 4 Apr 2025
 16:03:46 +0000
Message-ID: <56088224-14ce-4289-bd98-1c47d09c0f76@hpe.com>
Date: Fri, 4 Apr 2025 11:03:43 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 00/13] Ultra Ethernet driver introduction
To: Jason Gunthorpe <jgg@nvidia.com>, Sean Hefty <shefty@nvidia.com>
CC: Bernard Metzler <BMT@zurich.ibm.com>,
        Roland Dreier
	<roland@enfabrica.net>,
        Nikolay Aleksandrov <nikolay@enfabrica.net>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "shrijeet@enfabrica.net"
	<shrijeet@enfabrica.net>,
        "alex.badea@keysight.com"
	<alex.badea@keysight.com>,
        "eric.davis@broadcom.com"
	<eric.davis@broadcom.com>,
        "rip.sohan@amd.com" <rip.sohan@amd.com>,
        "dsahern@kernel.org" <dsahern@kernel.org>,
        "winston.liu@keysight.com"
	<winston.liu@keysight.com>,
        "dan.mihailescu@keysight.com"
	<dan.mihailescu@keysight.com>,
        Kamal Heib <kheib@redhat.com>,
        "parth.v.parikh@keysight.com" <parth.v.parikh@keysight.com>,
        Dave Miller
	<davem@redhat.com>,
        "andrew.tauferner@cornelisnetworks.com"
	<andrew.tauferner@cornelisnetworks.com>,
        "welch@hpe.com" <welch@hpe.com>,
        "rakhahari.bhunia@keysight.com" <rakhahari.bhunia@keysight.com>,
        "kingshuk.mandal@keysight.com" <kingshuk.mandal@keysight.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "kuba@kernel.org"
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
References: <BN8PR15MB25131FB51A63577B5795614399A72@BN8PR15MB2513.namprd15.prod.outlook.com>
 <DM6PR12MB431329322A0C0CCB7D5F85E6BDA72@DM6PR12MB4313.namprd12.prod.outlook.com>
 <Z+QTD7ihtQSYI0bl@nvidia.com>
 <DM6PR12MB43137AE666F19784D2832030BDA62@DM6PR12MB4313.namprd12.prod.outlook.com>
 <Z+Qi+XxYizfhr06P@nvidia.com>
 <DM6PR12MB431345D07D958CF0B784AE0EBDA62@DM6PR12MB4313.namprd12.prod.outlook.com>
 <Z+VSFRFG1gIbGsLQ@nvidia.com>
 <DM6PR12MB431332A6407547B225849F88BDAD2@DM6PR12MB4313.namprd12.prod.outlook.com>
 <20250401130413.GB291154@nvidia.com>
 <DM6PR12MB43130D3131B760AF2A0C569ABDAC2@DM6PR12MB4313.namprd12.prod.outlook.com>
 <20250401193920.GD325917@nvidia.com>
Content-Language: en-US
From: "Ziemba, Ian" <ian.ziemba@hpe.com>
In-Reply-To: <20250401193920.GD325917@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN7P220CA0020.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:806:123::25) To DM4PR84MB1447.NAMPRD84.PROD.OUTLOOK.COM
 (2603:10b6:8:4a::16)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR84MB1447:EE_|DM4PR84MB1421:EE_
X-MS-Office365-Filtering-Correlation-Id: d9b5a58a-6530-4b3a-cafe-08dd739247d4
X-LD-Processed: 105b2061-b669-4b31-92ac-24d304d195dc,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?a3R2b3FndC9BNzdLV0ViTjg3ZU9OVmtkd2ZGUHJlVkNwd01lR3RPKzZ2Z2Nz?=
 =?utf-8?B?c09ic3BmYjBVa1pMYlVYdThobXo0WmRvK0V2RWJ3L25Hb2JKS1p4dkZnL3ph?=
 =?utf-8?B?aW1YNFdVakFQaEV1SFdTaVlpaTA5L3RlaGVibUFQWit0Q2doSW00ZVptSkFV?=
 =?utf-8?B?cnNKZmJqQ3ZFSGE4RjlNc2luL0lUUlIrVjkrenVaZEI5UkpuRG93TkQ3cmJn?=
 =?utf-8?B?VWd1MWxYQ3FOQTlYZ0dDMW1sV0xERTU0dmFLalJxRnFzUndaQ0V0dzE0Y0pr?=
 =?utf-8?B?STB1dmd6SVVjTGJ3Tk1GTm40SGdwdUU1cDdtRlRrb0FqenlEaFhuZnBrT1Bm?=
 =?utf-8?B?QUE2L29KVGw4ZW96R2JCQ2FBOVhwZUxRNFdQMGNlWmVtMGdaaVF3T0ZZRkh2?=
 =?utf-8?B?OXE3OTFybXRDRUxBYTh1UCs5UytqbnpSZU0vR3lqYkNUaDQ4eWhFd2Q3VXVj?=
 =?utf-8?B?bUNMUzFqby9oUnNBVUhMTmdsajE0c3N4VnVEeEd4VHg0NFNsaEhMRnpnVTlp?=
 =?utf-8?B?VDNhTmlqL1J2Y0J4M2RwRWo0K0J5TSsralMyNjBqNVNmRGNQY0U0ajVrNlhG?=
 =?utf-8?B?SjZJOHZ5MWlVL3V0U3RFcEZCY0dZQ2V5UUJWMGpSRW9BQVVCYlQ3MTJsRmRl?=
 =?utf-8?B?Rk02OHZFQVQ1YXVzdEd3aGJ1T2ZXLzFxY0lxNDhFMzljdGtaQmtYWnhYajhK?=
 =?utf-8?B?QWxZMzAyNEV4dTFGUzNobGFwYXdGWkx2M1NURndWb0g1U2xGWVJJSityby92?=
 =?utf-8?B?R0hlWE9NazJqRWxtSnRMdk9pcUpTek9TS01tRVJJWmFaSFVIT2VxUUJKeTlq?=
 =?utf-8?B?dG5xUWJRZjJWZVl2bUs3MzRDaHg4WWI1TWhTVldVK0IwVktiMVMwa1ZNRmdU?=
 =?utf-8?B?aHNqcmZVdFBFVjcyU09qUDBhaGk3cHM1ZTdac1hLNml6Sk5jL3NEcTVhTlll?=
 =?utf-8?B?eGFlV2hLcFZJbmFReVZHNldKQThOT04vbHRlbllnaElZMW1BTXRUVnBFbEN5?=
 =?utf-8?B?UjNYZ2lOam1STjdHakVLcFM1dG1FZnJHTDhVSjlpY0ttQkNTOUNOczN4Nm9T?=
 =?utf-8?B?T1FMMEdrNlRxWURsVHRQYmF5eFEySlJHWm9KYzZTYmN1WHFJczh5S0ZCZUQ3?=
 =?utf-8?B?TUlCNG5xRWIwQ3NLTU9KWVF5elFMNndtTnZ1SlZoclkyNVh5NUZsN1BwR1Bz?=
 =?utf-8?B?Q2gxMXMzcUt3Y3dHYUJrVkc1V1F2TmIrbjZZOVhMWno4dEtWd01xUEhSU1Ey?=
 =?utf-8?B?K280L3pFTjJGcDlVVnExUSt3WW9xVk1LY3JoQXpCOFJNdkFCbW1OVFdBK3Yr?=
 =?utf-8?B?WlJ1ZXl5YnhpbG1PZVozbUYvTC9PT3JwbTJWSWJUckZLWCtobW1FSnVDYnFW?=
 =?utf-8?B?WHZzOU4vMGw1K3dLYjhKcWxVOG9VWVVnVEhPekZyeUxrMXV2b1pPYlVxcTVO?=
 =?utf-8?B?T3M2Nmo3YW9SMUd2ZDIwNmRJUjZVL3o2MzAxWHRTM2MrNktkVXZHbVl5blQ2?=
 =?utf-8?B?SW5BcmN1N0JWM1MwV283ZEk5T1l6VmxPM1p0YnI3MFdUb1AxVVQrWFVCYkY1?=
 =?utf-8?B?K0NRUDZBamhyLzBmcTBVaEIrenF5ZW1odkMyUEZxdnh0dFBMTzAwQkVMRjJ4?=
 =?utf-8?B?Z2tWOUhjZUx0THpnaVpCcTROT0VrTnJHbEl1OU1INkpxSGdvdmZpSmplV3Bw?=
 =?utf-8?B?MG5iZWNGVFg2VS80MVd3OXA2dk1uMjQ2bTVSTm1SUUU2ZnFGV2srZ253N1Vl?=
 =?utf-8?B?Wjc2SkZBb1ZoWFhnNFAxTEljd2ZwazNJMFJiYWZwdGhYdEM1L0VaOEJKNjQv?=
 =?utf-8?B?cGF4NlczY3BUem8vOEJIbUZlZXVkaVZhNnlNMjRPKzlCYXdYdk1aNFk3YU5v?=
 =?utf-8?Q?Pm7+MGE6xPz2K?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR84MB1447.NAMPRD84.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NFEyeDVCUzU4TU13M1RxWnpzbTAydnBQRTJHOXZLVWNIMk0zN043RWY1NGNt?=
 =?utf-8?B?NXJ0Y3lXV3NvUGFVTjl3WDdjWHdabnpZQXhEVmFYSmJkZ1NpdWFNY0NpNVI2?=
 =?utf-8?B?dm9ObnlrbkpNZVlxQi9wejhzVW5JekE0dEFvb2hyN2twMFdvVmEvcFVVcnVh?=
 =?utf-8?B?MUJGandOMjNMbm12c0oyM2lLL0FEbEExZUE5WjJBSmtBTXdXVlp2aDJmbzVv?=
 =?utf-8?B?bEo4cHlHamtnMHh3dmZ1NzduN2VBQitaVC9tN3dRQ3lpRjhSWmNqNXp0eFRQ?=
 =?utf-8?B?Rzg3SG82QXlFMlFvYkQrRHRRU1FNNFl1VzVEclA1d3VmblpTWUM0bWkrL0dY?=
 =?utf-8?B?bjY0Z0Vsb1FybU5ibTdRUkFYSG1DRzBxbXFxSVBONXhwai85QjlPb0FUQ2FB?=
 =?utf-8?B?WTNBOWNWYjVaa0NYeW8zQlROV1cxa2ZmR2Q4M1dlRm55WmRKRWNNSmZ1clZm?=
 =?utf-8?B?QW45N1I3V2tjZ2djY3BRbWlLQjIrbzhpYU5RaDVuNVlRK2VxV1VJSThWaWVI?=
 =?utf-8?B?UitOcVZCZWdzZGdmdmpnNmw3L0F5SDJEVDAwTXJxZUpuaWdBRXF3QjhzMk9H?=
 =?utf-8?B?eC9TcmdKQm9iaWlYdCtZOUgzeHVRNUVMWjdlenlHZnVWblhyVGNaSzhJbmN0?=
 =?utf-8?B?aTZUOE9DZmFrQUZTSHV5YUNkTjdmakE1MkZmdjZQdFNCY1EyTVdLTmErM2Rm?=
 =?utf-8?B?cmk3RUg3K1J3eWtqTkZ0ejA3VW9FdVNLRGtSQmFwbzdVLzRDOGlBUTVkOE9G?=
 =?utf-8?B?OFpiZW9KcWVRNmFuS09PeXNKZ2tQNStrdmQvQWIxOG9CK0ZaemcrWEpCZlNO?=
 =?utf-8?B?WG80Z3UwdVpoOC9jOHdxTmhFSngxdndSU083ejc3RTNBWkppMWlNaFoycHBS?=
 =?utf-8?B?a2IvWlhTOGR5UllFMHRob0UyNThMQnRJUitBN1JzV25rQ2N6emhjWkZVOW5M?=
 =?utf-8?B?OUhucXYvTlkzeExOOUMxR2pBVjB2VWtJZjF6Sms1RFpqWU9vdFBuOHlGY3lr?=
 =?utf-8?B?YmhiMm9OUnJFZVZPMVYxbzFkV25YakVwS1hsSm1BeVA2bXZWSmYxdWs3OVYy?=
 =?utf-8?B?bkp0V0tWOThKWGMrTWRSMEFkUDU5M1YrL0MyNDdGS1VMMFU1UXJsVk80UFlz?=
 =?utf-8?B?YlZIYUlEcE4vLzJtSjlNWGVxVXkySjlDMVkvbmp4aWZYYVFQakpOS1ZlTEEx?=
 =?utf-8?B?aWVvOGZhQnptQ2JVWm4xQXVMMG13MGY2V09wd29JV0pNNGhPS3lJS2FjRHo4?=
 =?utf-8?B?QWZBZ2RMb3lCQVlKZjVhWDdmREtVOTBUcVdiYW1MN1NJWW5GdUR6ZHI5aDVB?=
 =?utf-8?B?eW5uakdDcGVkSGpBK00zUDFOdkVyM0ZXem5vOGVQZTNwcnZRbjRUN3NVY00w?=
 =?utf-8?B?eElaTCtrTWNuSUY0V3pWWjZMdXlwNmlQSnNleVFFNHNsQ3ZFd25hbUdrZFhP?=
 =?utf-8?B?T3Ezc2ZnMmlONGhkUWhIdkJ0NjhDOCtZZ0x5VFlLUUV0WHRaZHFKSUpyQlJH?=
 =?utf-8?B?STRvYkxTOSs1V09NTEVYOTV2K0FmbktHckRVa3NPUzkyOEF5RURwb21wY3Qr?=
 =?utf-8?B?YmY4Skc2RzB2ZVVCY29qTTl4WnQ5Rm9mbVErdkxDYzR3VWlDRDRwZ0VFQUkw?=
 =?utf-8?B?YVV6SC93WWtIVkNMOHlDWXNOcEQ2T3g4ajBuR3FOTi9VVk82ZHhmeVdsTlQx?=
 =?utf-8?B?Qi9JMHduUkpoVERFVlJPcXB6RTRNU3BZV2k2TU5Dc1dacUJIN2hnNkltdm5v?=
 =?utf-8?B?L2VRVi9TMWcvVDFOSllLZkdlZStpVnVlaEhBT0xMQ3FXaHo5YTFmKzZ3YWM5?=
 =?utf-8?B?bE5NdWp6aGdndSttV1Nsa0lTZzhqQjMzUDJLSmd2MjhnMHozdW5TVkU3N0E1?=
 =?utf-8?B?WHZDejNLelBvUHlEYVMxb2cxY0hScTRjSlBQNnBtZVMzWk9zOWE1Tk11YlVN?=
 =?utf-8?B?bFpSc1NFanBZL3h3Ujl3YnBoNVgvNTdVRXdHVmpvYUh5Z0hJSU1YWnNnTU1l?=
 =?utf-8?B?amFUSzBSM1RjdlBWSlptdEtpNkpnTW9mdCtWMDFScDY2Vm5Za3F1SkZ2U1ph?=
 =?utf-8?B?WDgxaFNyMnBreHlzTGs5Wm9BUEh0OS8zUFpwNmxPMVNLNTd3TTZDTFhoRDlt?=
 =?utf-8?Q?tVrdv9CzPqJBCDt6WWdRzJtpH?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d9b5a58a-6530-4b3a-cafe-08dd739247d4
X-MS-Exchange-CrossTenant-AuthSource: DM4PR84MB1447.NAMPRD84.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Apr 2025 16:03:46.5547
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 105b2061-b669-4b31-92ac-24d304d195dc
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: T0XQyRQ5j8TyQeATnfoTQ0qR/Lpqg02s1Lnq5emnp9tKy5eyku+Px7Ow4xjZw/z0ubVYX4pXcpSUTz7GcZiU5g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR84MB1421
X-OriginatorOrg: hpe.com
X-Proofpoint-GUID: AQccwFw-wUNysfavDIiYnboMUuNNEZWu
X-Proofpoint-ORIG-GUID: AQccwFw-wUNysfavDIiYnboMUuNNEZWu
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-04_07,2025-04-03_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 phishscore=0 spamscore=0 bulkscore=0 adultscore=0 impostorscore=0
 clxscore=1011 mlxscore=0 priorityscore=1501 malwarescore=0 suspectscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502280000 definitions=main-2504040110

On 4/1/2025 2:39 PM, Jason Gunthorpe wrote:
>> I don't know that I can talk about the UEC spec, 
> 
> Right, it is too early to talk about UEC and Linux until people can
> freely talk about what it actually needs.

While the UE specs are not yet out, concepts can be discussed. I
recognize this may be annoying without specs.

The following is my understanding of the UE job model.

A job ID identifies "who am I." There are two different operational
modes:

1. Relative Addressing

   The endpoint address is only valid within the scope of the job ID.
   Endpoints can only transmit and receive on the associated job ID.
   Parallel applications will use this to restrict communication to
   only processes within the job.
   
   Processes must be granted access to the job ID. In addition,
   multiple processes may share a job ID. Some mechanism is required to
   restrict what job IDs an endpoint can be configured against. Having
   a device-level RDMA job object and a path to associate the job
   object with an endpoint seems reasonable.

2. Absolute Addressing

   The target endpoint address is outside the scope of the job ID. This
   behavior allows an endpoint to receive on all job IDs and transmit
   on only authorized job IDs. This mode enables server endpoints to
   support multiple clients with different job IDs.

   Since this mode impacts the job IDs transmitted in packets,
   processes must be granted access. A device-level RDMA job object
   seems reasonable for this as well.

   An optional mechanism to restrict a receive buffer and MR to a
   specific job ID is needed. This enables a server endpoint to have
   per client job ID resources. Job ID verification is unnecessary
   since the job ID associated with a receive buffer or MR does not
   impact the packet job ID.

UE is going to need some object to restrict registered user-space
memory. Having the PD as the object supporting local memory
registration isolation seems ok. The UE object relationship could look
like job  <- 1 --- 0..* ->  endpoint  <- 0..* --- 1 ->  PD.

Thanks,

Ian

