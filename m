Return-Path: <linux-rdma+bounces-11857-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 47216AF6B52
	for <lists+linux-rdma@lfdr.de>; Thu,  3 Jul 2025 09:19:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A14FB1C25677
	for <lists+linux-rdma@lfdr.de>; Thu,  3 Jul 2025 07:20:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 525C1298264;
	Thu,  3 Jul 2025 07:19:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="DncllQ5j"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2047.outbound.protection.outlook.com [40.107.102.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7A231CD1F;
	Thu,  3 Jul 2025 07:19:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751527186; cv=fail; b=fHLOwvOKLTbqCG24FDkrgAYhBtXhoiIWYG5DhLUpQDIrNOuF9+8J3MAqH2YuEhwIB4coxlFBN+SVZx1FGre2znHgYG1klDngAuCC6iD7M0UM7l4A2rDZGbbPDOmLnyraLIXTCSUj4c5ZlFcwNH2KS4l4/x3fyIciQw0DQ3xKAUk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751527186; c=relaxed/simple;
	bh=SSaRGcSJvupm0oIpD0q4jAk3S3urhzSPyG3tPifT5os=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ih6qVCMKLWVbNrdLStIIN6sKutkbutXnsJlRDm5ZlAvyOJzfQSCelf6mi2QQETnHb40eD8kazmp0DPB9Nefsc8QRRUPdgdfbQjv+TAjM7ZsPctVaplx4HBcDeaUbTviyYDOq9Hc2Zb5NSGdezRSoA2/DD6axSgZ1ttWRST3abmI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=DncllQ5j; arc=fail smtp.client-ip=40.107.102.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=icbcQlZTH3wE9/fX43vi0HvDRD5Qb2FpHoWlVekFzJoqir0LhwvbEQU+XgUYiDBGn85tjAR79Z4V73M2AC6ZI1vgYAnMKf+JWsYZDb/Ac7l/6I7mZ4HxezVkeKAmhvRwDs0rvJkzdeucrTJdUGmc6/NmnTTDPzMyitjU3mTRZFCJ3+Iy3Q85IIieXeV/pbStPGWyUk5ieHtYW7ZbAmeHAg5gcO0F/x1bfbm88JQyNslXd8r0TptYKiATR7xwn+ab6j/zd8r0mFzAeHhQ3c9SoWkHzSHsvyrvfahPVuyDuWM1pRV7PyU7TZbRFzPi0h98i5IvTJxx0JZHAre6ZQOxuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/SwEY5xsumy38qhuAjX9zqN9bHdXu8AUbLIhH+Ty/fE=;
 b=QEDcvf1XChHGPeYGK24kB4kCNMpZeAg8YlcBWow/in951mg+xsIS/wjdN2lHzWHyaYf6OC8XfUda4YvxiT6bDP+Wbl4ecsA5Dl1jNQBWWGkAlneWdx6+1e0Vlm4/QNDArpQ36E6WuUdZuOK8CFX4pZOyZ7Kdim9UQ+zzjnP6GmERpPabE9b0Cz/UGn+CO1UejDS58l7+wvGXFzfpBQR0FnTuPORjNbXqC8dZum8AN0lmGAwyqDoF3cy07iSBVYgjrFb2OH5xs9kC05q8pZJ8qjcEw7wzQaQM9dgDbtVtMvJ2PTuH6GlhQimgD9ooBjdhkv6WpzoghO2WbqKa+mzE1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/SwEY5xsumy38qhuAjX9zqN9bHdXu8AUbLIhH+Ty/fE=;
 b=DncllQ5jqyzrtGQWejyQNsQ8plrbyVk74moNFN1iG/vofgOUsiSTEfZpNHII77YiJA1wRpoVcdquM2RqwfP4PtyQSNQPC58aqC/S9KL9eAkIpNBptdBXAFPw1MvO8y0DYLrzoNhsJDAdv3Y9jkEwcY88uQXgyfbVHxOKboviuQc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from IA1PR12MB9064.namprd12.prod.outlook.com (2603:10b6:208:3a8::19)
 by CH1PR12MB9622.namprd12.prod.outlook.com (2603:10b6:610:2b2::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.34; Thu, 3 Jul
 2025 07:19:41 +0000
Received: from IA1PR12MB9064.namprd12.prod.outlook.com
 ([fe80::1f25:d062:c8f3:ade3]) by IA1PR12MB9064.namprd12.prod.outlook.com
 ([fe80::1f25:d062:c8f3:ade3%6]) with mapi id 15.20.8901.018; Thu, 3 Jul 2025
 07:19:41 +0000
Message-ID: <bb0ac425-2f01-b8c7-2fd7-4ecf9e9ef8b1@amd.com>
Date: Thu, 3 Jul 2025 12:49:30 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH v3 10/14] RDMA/ionic: Register device ops for control path
Content-Language: en-US
To: Leon Romanovsky <leon@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>
Cc: shannon.nelson@amd.com, brett.creeley@amd.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, corbet@lwn.net,
 andrew+netdev@lunn.ch, allen.hubbe@amd.com, nikhil.agarwal@amd.com,
 linux-rdma@vger.kernel.org, netdev@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 Andrew Boyer <andrew.boyer@amd.com>
References: <20250624121315.739049-1-abhijit.gangurde@amd.com>
 <20250624121315.739049-11-abhijit.gangurde@amd.com>
 <20250701103844.GB118736@unreal> <20250702131803.GB904431@ziepe.ca>
 <20250702180007.GK6278@unreal>
From: Abhijit Gangurde <abhijit.gangurde@amd.com>
In-Reply-To: <20250702180007.GK6278@unreal>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0202.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:e9::10) To IA1PR12MB9064.namprd12.prod.outlook.com
 (2603:10b6:208:3a8::19)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR12MB9064:EE_|CH1PR12MB9622:EE_
X-MS-Office365-Filtering-Correlation-Id: 1810be37-9dba-4678-35ed-08ddba01f9fc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Zno0RkNaSE4wMUFHeHlrVmhzUW1Kbi9hUTBWbGJwNi9GVDgxazFlZVZUTHdW?=
 =?utf-8?B?L3Z2RnpKSUUwc09PZXdjdjE5SFRzcDE1T1F4SVRGbjlCbXRlY2lsMDVnTmhC?=
 =?utf-8?B?Q0pGY05uSUhaclZBaTVYbm1PMWFFazZGODRJSHRMVjlJT2hTeWNObnAwS0cz?=
 =?utf-8?B?dEx0OEt5NG4waWVQSi95aHIyU1ViSnBpdCtiNHk5cVgvaHdYbjZDSWYrdHU3?=
 =?utf-8?B?dzJ1SHBCUWhVTFQ4OGxxSHgxd1RhU3c2NzVEZFRDTjVGZnBFM0RrczdpdkNo?=
 =?utf-8?B?eG5hSXhWVllCM1dvclpEOXp6SW9FRWM5NVJwSHJQMjFVWHE5VGtSYkJpOHJk?=
 =?utf-8?B?b2IrVDBlYTlYcmw4V3dxaVVwek85cDB2bEpmSDY4b3VSSTdmMFhRMEtSY01C?=
 =?utf-8?B?NDVPUXVJeCtWWHNjTjRyMys0UnRkc3ppdjNOMEVGNnY1R0FRWWl2L3Vac0pH?=
 =?utf-8?B?Qm1DNTkrOUpvTFl4bSt6OHpOK1QyVXNvREJ0YmRNZkZEbDg0UFBBWHo5S1NN?=
 =?utf-8?B?S0FqZy9mT2V4dzQ5Nk5YSWRJcFJPNlhXZDY1YnN1cjc2MUdVYUVrTGkrc2Zj?=
 =?utf-8?B?NHd0UEo5SU1uKytFTzNhZkhDSFZBODlRMVBXOGthdE1SOFBSWDZwSEUyNElV?=
 =?utf-8?B?RDVENGl1WHJaYlhLQVV2NWVkRW5CU1ZyMm54Zjgxc2FzaGJLL2tZdG9XSHJB?=
 =?utf-8?B?UUFkeGxnRFRQNW9DTGxpMDBCR29sWFgrU2J3ZURjT2JnRkFiQUNiTm5mZHU3?=
 =?utf-8?B?dXc0Y2hXQVE5ZjY1VXdDT2dSUXBsUFVQalJwQnpGdHA1UVZUSm5vaWNNZTR2?=
 =?utf-8?B?K0JqdThOR3RVS1BwQVMxSEFIMHhIczVUVUEvZmkxQTkrdTIwWXdMeXhUZW5I?=
 =?utf-8?B?ZnBBamtzSnJ0SHB4eGlxRzJOVUp2RU12UXpjMmppNVYyekl5Zm1EK0pZYVJ4?=
 =?utf-8?B?d1BQZmVybXBjTzZWb1pyZWM3UXZPUUpDa2JoNC8waWp4R3phWnVXMFZSMnQr?=
 =?utf-8?B?NTcwQW9ZNWRwODM3Z3JheTZ2UEdlN05EZTM4VnRjOTJ4N2RsKzU4Mkp0ekdk?=
 =?utf-8?B?dGo0WDhtai9IN1BjL2JUcGdiKzMvVTZIOWhoK2JyUi81eE5GbUZaUjlKcE0w?=
 =?utf-8?B?a2x1Vk8weW5Ob0pmWDRVNWdISUcxdWxJbXZoUWI1c295SXRxWmIyNDBnMTRi?=
 =?utf-8?B?RGtuOWF3OE9pdHJUQkZNamRzeWp6S1cycXpKTWQ0MlhiZkdSZVpDM1AzTGND?=
 =?utf-8?B?bWxLTGJpbjluMFg5b1hLb2d1KytOMzVCeituVVFZcG5pV1pFWkhTQkhmdEVS?=
 =?utf-8?B?RzNnS1BIRGw5Ym5FMDRadE5tQ3hBVWYwcVYyUHNpWjFydy9jNEtpazZlWjNI?=
 =?utf-8?B?RERsVFgwb3dzUUI1WUhyZlFsYUJhUkdzZUFTbGtQS3dHZmMvZlh3OHRtL0Fq?=
 =?utf-8?B?YndtMXl6ZEJSTmUrZHliMmFldS9lYU53RmZQRGNpWnJyVlkycDE1UGNpQlRm?=
 =?utf-8?B?NnA4S2Z5VnExcWZpTTVSaWx5OENBSHcwUHdyY2lDazlXeG01L1FqUE91QmRH?=
 =?utf-8?B?dHhEMUIrbGw3U0NhMzJWbm5kcTFuYVp2cnNuMThjMHFmZlpnY3owY1Bzdlg4?=
 =?utf-8?B?RThGclF5Wkt5RFkvZlB0eG05NUYyOVRVMzhaSGlCeFN5VFNST1BqdEZycSts?=
 =?utf-8?B?am5lb2VPRENNVGFHeXRPVkg0azVmZWdNUWdFSWFMTmtkUTYrdTZqYzZCY3FJ?=
 =?utf-8?B?SG1VcW9TY3MyemVpRHpDajY3NE5vUlJ2N2E3U2RXaWpOL3dXSUt2aHNzeHQ1?=
 =?utf-8?B?dHRQREhtNXFDZEJiVmk0TXRjZ0lPc2g4TmhnNE5pc1d3VVNZS084V1JnNW9t?=
 =?utf-8?B?MGdZSWV5bkRKZ1l4b1VkcVRybnorUHFWYlhkNmUrd01aZFRmR21mcVJkQVU0?=
 =?utf-8?Q?8lv3qbs0ItU=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR12MB9064.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WVo5MVhCNHVzWWdObFJOOVRkY005SXNwVEF0enNDWk9rTDA4MkFFNzZjN3pv?=
 =?utf-8?B?bkhXcEFjZXZEYnFYSlNGS25jTFZ1dlpRK0R2N0R3eHIzU0NuclQ0UEFXOGdh?=
 =?utf-8?B?aUNnZjlab3dZWlU2OW9TQTVxc1BNQkNwZDJSd2k4T3N2a3BlLzVtWVpFRWlk?=
 =?utf-8?B?RHR6RUp2UzZVbFc1OGJ3UkFaRmNXQmVVR3hsTjcxc1FXTVkxc3k1U2NoNTNt?=
 =?utf-8?B?ekQ4ZUxOSkdRWk5aMzcxdkpJT3V2K1JhaFg4S0FRQXl1dStIaHl0b05HVmJ0?=
 =?utf-8?B?SWR6M294RkVYV0paTlN5cElGSm55dGFWaUVHbEhjcDFOY1dOVlRqZnNULzUw?=
 =?utf-8?B?QXBpQTEyV3l4MGdPNE1UbEYyVjIzaFhWVzJoRnhCV29sNmdlbFpWWUt1eDI4?=
 =?utf-8?B?d2NKR0VodC9HQWo3dVZRZmYvQ3lEelNLK2g3T21xcjFRVXUydWtObDBRZkhW?=
 =?utf-8?B?NFZFdXlQSWs0c2YvNWExVndsWkVJWi9rL1FJN2ZKRTJBbnV2ZU1OV1p6ZzB5?=
 =?utf-8?B?UGdIZ0Rkak9hTEdtTG96TXZxS3U4aWp3L1ZNc0NWWnVtbkNuNGZyQ01MZVVB?=
 =?utf-8?B?S0c3ckhFQlE0a29ZcndDSlBuNlJYYW10KzdGTkFoSWJpcDJSdEhWTnpnRENI?=
 =?utf-8?B?R25tS090RkRKUFpCaE9mb2pVQ05uaW40eExTZDZlZTRacDhDQVAydjB6VjQ0?=
 =?utf-8?B?SURGRzdWa01XbHk3TlNubUdMRkg0N280MC9IYnRhanBheVdLQXdaUUU0SkRp?=
 =?utf-8?B?RUloRkdlWHErYW92aDZ1UWQxZitxNlh1NGM3YTZLR0FpSmo1MEhZSUhLUHox?=
 =?utf-8?B?RGZkcmdTb29Kek1wR2JJQzJVcmcxZVUzTkdZeFp1UEp2R3cwRmNQYzFLeU5N?=
 =?utf-8?B?OVltNVFVZld6NWVleHRnNUl2VkJQMXBtMWVPcVBKcEpmNE1VV2VOeDg0bno2?=
 =?utf-8?B?WTRPeGZBSkFCWmEvamZ5elNYbzdzd0pHdzBUVGtNdkd5bE8xcmIwdjBMNUZY?=
 =?utf-8?B?ZnJEZ0FzR1hONUhuRUNTS3ZUQXpEZ05MdDJsMDFXL3JmY2NaM3YzS3J4UExB?=
 =?utf-8?B?VlpXV0lrb202cjBlNE11RUVDM01UQzVxWU9iRUMxMmJCcXR4dFI0ZzRlc3JI?=
 =?utf-8?B?cmVNMTkzZ1pla1lPcGs5d25XaFNkOUhLcjcwZStzTVM3NGxBdTdrNmUvQWJ0?=
 =?utf-8?B?em5mUDFTZjBuZlNHdjBXOGdQYUFVcjkwcWJyR3BTcktKaW5xbzRVS2JBU2hk?=
 =?utf-8?B?dWx0UkZlVm9MZ0ZsZ0tJaXhFNVp3WE1OUEwxd2xjRy8wUGpSSis0Um9BT3ZY?=
 =?utf-8?B?WEJ2RjJlNWgzN1NMRDZVL1lQNXJmeHNiODJNdFNOamJnVVhqcGMraWJMSm5j?=
 =?utf-8?B?R2kySVZMRGd5R21ROUJoNFlIOGZaQ3pmcGdJMVFQS09yNXFieEYwMlo3QitB?=
 =?utf-8?B?bnRPK0NhTk5ROEhnV3A1RWlZRi9hQUd2UVdOa0VqQUJUVlp5VU1PbFUvWmhm?=
 =?utf-8?B?TGJGckNSdWRYMWg4RHY3WWsyTU4yT3g0RlJkNm85amdrdjVTS3cvUWN5ZEdU?=
 =?utf-8?B?ZERwYWJaUnB0eEZZQ0RvVE9za2plc1p0YTdzL01aK1NqQk1PK0VOS1ZOSnFO?=
 =?utf-8?B?S3hLTndsanB4bUp0UlBNTTBETFdHcHpkdlg0dFB0WTNQc1BCRVpvY081RmFC?=
 =?utf-8?B?YkZuQmpQRjgxTC9ZZXpQTktFOXRmbk50a0JuZHdPbnJCekpXNzYvY1dTUWM2?=
 =?utf-8?B?aWhhVVl4djVadWUxR2VqSjZhdi9VM2ZXQUEzdldhQUQyekV0ZTB0Qk8za3ow?=
 =?utf-8?B?dlRxaG9PeTFJQTBKWVR0OUFMTHVIODQ3S1ZqZjg0TzJTZ3NUWlhvSWlrWTVy?=
 =?utf-8?B?SlhKTVBDbHZPRXY3U1pQVEdINlBUMkp1QU9nVHMwa0YvR3NXYUdiRThpeVN3?=
 =?utf-8?B?b3l3d0E3RjVrejhncDVkVmFXcmpIQ3lhOGU4QTIvTm5yb0pXNzY2TnFIRk12?=
 =?utf-8?B?WXNUTU5PUnlucDN2a0pybEpzdmZOaTVxN2xpWnhDTVczWGlnbWRwL0Yrb3R2?=
 =?utf-8?B?MHV4V3pFb1NuV2Nsc0pxK3ZaTWNCQkFmOW91UzRXUW1tZ3pnZTI2MDBnTDVE?=
 =?utf-8?Q?OjaaPIgUbFYwudm54rZN1vw+Y?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1810be37-9dba-4678-35ed-08ddba01f9fc
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB9064.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2025 07:19:41.1318
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uuIainXYjy6jrGCqefbPP8VazbEn3HQsSD+LGT9inGiT5s8+ENbk6fA265K10MJpqOo14wJ7p0nNsGbsIzbdhw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PR12MB9622


On 7/2/25 23:30, Leon Romanovsky wrote:
> On Wed, Jul 02, 2025 at 10:18:03AM -0300, Jason Gunthorpe wrote:
>> On Tue, Jul 01, 2025 at 01:38:44PM +0300, Leon Romanovsky wrote:
>>>> +static void ionic_flush_qs(struct ionic_ibdev *dev)
>>>> +{
>>>> +	struct ionic_qp *qp, *qp_tmp;
>>>> +	struct ionic_cq *cq, *cq_tmp;
>>>> +	LIST_HEAD(flush_list);
>>>> +	unsigned long index;
>>>> +
>>>> +	/* Flush qp send and recv */
>>>> +	rcu_read_lock();
>>>> +	xa_for_each(&dev->qp_tbl, index, qp) {
>>>> +		kref_get(&qp->qp_kref);
>>>> +		list_add_tail(&qp->ibkill_flush_ent, &flush_list);
>>>> +	}
>>>> +	rcu_read_unlock();
>>> Same question as for CQ. What does RCU lock protect here?
>> It should protect the kref_get against free of qp. The qp memory must
>> be RCU freed.
> I'm not sure that this was intension here. Let's wait for an answer from the author.

As Jason mentioned, It was intended to protect the kref_get against free 
of cq and qp
in the destroy path.

>> But this pattern requires kref_get_unless_zero()
>>
>> Jason

I will change it for kref_get_unless_zero().

Thanks,
Abhijit


