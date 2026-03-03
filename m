Return-Path: <linux-rdma+bounces-17443-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kFd/B/lYp2lsgwAAu9opvQ
	(envelope-from <linux-rdma+bounces-17443-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 03 Mar 2026 22:56:09 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id AED361F7D00
	for <lists+linux-rdma@lfdr.de>; Tue, 03 Mar 2026 22:56:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 0C5FC3043752
	for <lists+linux-rdma@lfdr.de>; Tue,  3 Mar 2026 21:56:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1455533689F;
	Tue,  3 Mar 2026 21:56:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="D9Dh0Tq8";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="ec2tNsba"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95A79336894;
	Tue,  3 Mar 2026 21:55:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772574959; cv=fail; b=cSEopaoiQBkaXIb/aUp5twVOsr5V7BSYJw3QjJctOa4CqVExoyPikxF1rYEtD+ojFk/Z0kzIIKI7xYDp0izBh57fAW2XFC7Esrybj7Uls/y0VtKkiTBEuOB3h90q0Ur51iVg8TICvFi9YYsREBGTtWyJ3YzDyvXMb3DwAvw71KU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772574959; c=relaxed/simple;
	bh=LSte86RYGWAEMAn8PDqjlFMZwUTywItVTGVwEZXkL2g=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Xm2te1zq3ygRWIDyDDjoTjTILUuXorXqz3pQ409BicY6EZluNbQRUFQHTksKBgsrXzHaUIvIXMoWn218Yo+vYEa0wGou4SD7kSuQishTCGNaIpuL7dTpGQxkugJg6djgI/6j4qr9RtcS0TrX+J+eojmetkHxOdrtWjaCBdENsJI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=D9Dh0Tq8; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=ec2tNsba; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 623LbcgQ789434;
	Tue, 3 Mar 2026 21:55:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=3O4TJezjjRAe3Bv6DHl69Dg7cpjSViWLYjGpXbomHGQ=; b=
	D9Dh0Tq8yZL18vta7Ov9C0OKKoJge7syo8Wvy6RI59dYfAfFvkmlP9R6iYzeqqCc
	3qkPwVMb8pDPKusxrBwg8GxAyDL47AEazPNhmP09cLhRF8/iE9hpmBwbMqRyWdJn
	rvGjMrXUahISjbZmHEJ/wL/LZ16n53ahCkbv/a74ddo3ZGT51to4n4hu3qcZD9Dg
	gAd3NNmvIQdFNlDJtnpc3YQgGaPZtzgD7sNvKNREdMo1kjX8AljTJQwYP86BN/I5
	lJevGNNCUW7FentAWSQ4AZaU+alBcH4tBoH8xIZUuJzSb/9MkI9xqJtjO89Ma07f
	G2aZxdGITei7IaFBnSXCHw==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4cp7qq00p2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 03 Mar 2026 21:55:23 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 623LHE15037800;
	Tue, 3 Mar 2026 21:55:22 GMT
Received: from sj2pr03cu001.outbound.protection.outlook.com (mail-westusazon11012036.outbound.protection.outlook.com [52.101.43.36])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4ckptf7e2y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 03 Mar 2026 21:55:21 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OTLEp3otKBhqs/2merWSUTCxBDnpknVsdplaxdLfN287K6C4pBOeKhR7ES7VubVPWIZb5ei76M4G1B39fjdnilnzG5Hs7EnDIop85S6VkIjcxVyCI6eQhm6/bERrPar/9k+/xOZRcRdI66s/Zz3fLlBo/Z4cWkqOy4h8boxVItb9O+nptyVW3kaz12bTK94sFxYGtLPGtFmzktbAiE7+hKxssZwu3dduDbvhk9MPgzgx+l1INGUsG5CyWDwmvp40iXPei2ThON1w99o/mP1f+UOV74XPRuV14hcuWdkDZ6cAZ+FMRTs+Gh7E/xjviTnTLNc/m4uDfoIrlXeYb/4uWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3O4TJezjjRAe3Bv6DHl69Dg7cpjSViWLYjGpXbomHGQ=;
 b=jYznFhONgYcya0SHmTuoNH+aQwSI+jXUXgP6kxOXyCCTJAxMsR5KAR4b7B6jjpjdXre8C7mcZVtu9RCe430oJDXf11PJMOuv3O63fhjTzgquY08tcl5de46v2D1q0BPqx6GxJieUWLyq3YlroO9b10DzGgx4rNEyvNNN5XMVZF8F4iCY8gdVcFguyklbripz+FZzKo2Z68mmvHzPtBQ4PvFc8bleMP6SaOekTTaSIRJppp1MCHb9N2nVzr9xltbR8KpDILRmRqowwm9NXw3QEvuoj0w/uNFX1w1jNS6zqR691kr8N54Q2NVIfYvAoUcCUTp882BWjjD9aaXAZydkqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3O4TJezjjRAe3Bv6DHl69Dg7cpjSViWLYjGpXbomHGQ=;
 b=ec2tNsba202RWv6GF4O0/SO7nERN2Q4ET4sCJLfQziURy6ULaAXUyJGMus8ynOh/PeYcQ1YxvXSkfFYzokCD+zDr/r95mnux88ndWMHQzqRWKDdkajYqc0UvX6M72Tje+ixIzTjKbUCI47I2ELsQ/NI5QXlhlI0Enp6KKcUh2XA=
Received: from DS4PPFEAFA21C69.namprd10.prod.outlook.com
 (2603:10b6:f:fc00::d54) by SN7PR10MB7002.namprd10.prod.outlook.com
 (2603:10b6:806:344::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.22; Tue, 3 Mar
 2026 21:55:19 +0000
Received: from DS4PPFEAFA21C69.namprd10.prod.outlook.com
 ([fe80::5266:1601:5598:3f0a]) by DS4PPFEAFA21C69.namprd10.prod.outlook.com
 ([fe80::5266:1601:5598:3f0a%4]) with mapi id 15.20.9632.017; Tue, 3 Mar 2026
 21:55:18 +0000
Message-ID: <46567e4a-9e0c-4020-a976-238b6a95240b@oracle.com>
Date: Tue, 3 Mar 2026 21:55:16 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: blktests failures with v7.0-rc1 kernel
To: Chaitanya Kulkarni <chaitanyak@nvidia.com>,
        Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "nbd@other.debian.org" <nbd@other.debian.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
References: <aZ_-cH8euZLySxdD@shinmob>
 <15ee757e-6140-4151-a1dd-cccb781c89a1@oracle.com>
 <73ada395-a06d-4ac7-ae0e-dbbc1ebfb36e@nvidia.com>
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <73ada395-a06d-4ac7-ae0e-dbbc1ebfb36e@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: DUZPR01CA0016.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:46b::9) To DS4PPFEAFA21C69.namprd10.prod.outlook.com
 (2603:10b6:f:fc00::d54)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PPFEAFA21C69:EE_|SN7PR10MB7002:EE_
X-MS-Office365-Filtering-Correlation-Id: 170a0663-0066-490b-9af9-08de796f8f5e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	lawf5hplOD9ou65pZQiqi1kcgCVtDwVquHEiNhNBVukQnYasyGpRQyv8ImxKI0n+0s7yKZd6txvOGTZ//xcY0ML5B+02zSZHr6VyZKSG1VWnAefWpuaCptDLR6YSM4jAHSSPlf5hmlJ/Ao1jP3A+FIffbZRvLbsdfHQ0/uxsblxnufCNOplcki3lu3VX3LOPU1P5CNJO7X3Xp69VmDhg0/Ul9cckg0PMBtwh0h/OsAg2J6oozwUxhT7o8WPwXMXJH/WKxDm18i0j7wDvFM1/q9uCufGoCd2JJNFT9fbrnPLzh+JYlz8LjwIaPhmXBKi/PlrBNebovLB4BdogPyoZNGjIvbOO/4fZcpxArZTcXSoMxpNiwqUVMacgzhDs1RukbIJGAjsY7RCI0qc8QJKk749lkgtPaAxjTjqy+znoj+oDaYysmao9h2i/PKPFngJcpeO4L5JTx0S0WQtpqUtiE9NDUNEeIyv53/Q0LLEPNOX4giNbIrJ544j05J2rZINLpmzWa0ZSJIXRw/ysjDHud80X46TgJI1rgSn1wu3eV2A+urMK2xaURuB3pcz8dOIRSbI8dhebkTIydWTLHn65D6UITmjCbIZQeMttt3Qj096IPM0RZL/5qP/gaOsunhXJm3KP2/ANxB3lrNUVFIW2T+WAiEJlZvMD+7xvsgB/lz+soV9rUqr96A/oF9b5/kF1IPU/15U7Wpw8VtzazbIWbh0nE2dzLOwbYNHJZkSbZVs=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPFEAFA21C69.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VW8zNkJDYlIrTnRhT2o4cWkvNmNMb3M0WHNtQlZaZzVuZUVUZWNjK211WmFB?=
 =?utf-8?B?T2ZROWFrVmJHMHo3SStVTWxSTyt4WVAzMEtMZjVXRUloeEZWYXUvZkMwb0Nw?=
 =?utf-8?B?NHpHcXExZXF2MkcxMklkMW8wMHM0NWV6TitIeVJFUXdCOHlIYjk5bWhRUjFY?=
 =?utf-8?B?ajV6bmdFSjBVaEZsZCtrNW9aV0F3eGhTMmlEV1BlS1FtakR4L0VaNnhZRkNh?=
 =?utf-8?B?c2JEM081elZ0UnNkOGxHRFVZKy90UWd3NmIvUWRkVCt3WW80c3Y3aDJUS0lH?=
 =?utf-8?B?ZmpCNWdGU2MrbktKZEtiZy9Vb3BpNDVtRHJDSmdiRXcwV24xRi9KOXNhdWFB?=
 =?utf-8?B?bmxXNjBqMFdjeUczM3FWUmpGZDVQV2hRbWVqamZjbnQ0bnA1Q3BDdkVrWWxh?=
 =?utf-8?B?K0VkS1VUL0IvRjZhVXdYUEtacHJrSVdqOVgyTSsvY1NqRElMRTY0WG43QnI5?=
 =?utf-8?B?QXB5YjRXNlpiR3o1ZzFoeng2anZJa0kwc1ByMmN1eks4R3Y2dUZJUytiUjNO?=
 =?utf-8?B?SVFJcTQ1amcyYVdnTndyWUZyZ0RoQ0dLSmlWUXcxdEgveHptMjQwUmZ5SitW?=
 =?utf-8?B?MzliNTFBWnhtRVVSY3h5TUxDOVRiTFVjZU1Ec21zejMrNDRYOTBBVnMybGsr?=
 =?utf-8?B?cDdVV01XZ3RLVmNGdWhlVUhwcnNIS1BUZGc5UFBsTU5vcHJNcGpDRWdjT2dU?=
 =?utf-8?B?Rm1QQnFUKzQzV1d2L2JJVmV0SWlKNnp4VnRtK1hUN1l4bkZ3Vjg5bHdzOTg4?=
 =?utf-8?B?c2FjdGxRaVRiSXVFYVdEQmVOYk5wSFN5Y1UzQVgyNVZUZExreExmUkd6cjdT?=
 =?utf-8?B?dnVyNkNxdmtoaHZFTDZZVmZBQlY2Y1dwd2tmZ2NjdTlXaEo1RGR1RHIranVN?=
 =?utf-8?B?L2tzSVR4SUVaUjJ4cWs3Z1FQQ3kzYlpJUjNhVEw0bU9ueEFiallzQndsQU1k?=
 =?utf-8?B?L3lzLzJyaHpjaUZoWnpvRndRS3ZuT0JVNzlETk55TERRSkVwQUhhM0t1REYx?=
 =?utf-8?B?blo1NUlnUHJOdkQydVFQb1RmYXYzakFObzNLVHRtck0rMmx3YUp0d1llWXBX?=
 =?utf-8?B?TG5vZ0tOWDdmZEo3ai9FcTRlbXVCOUFvZWQvWlJWeG95QXJkR0lTbHRaQVpE?=
 =?utf-8?B?WHZqSDI4ZHdWZ1NlZmp0UFVYamtkc0pURTNUVmc4YndMNVI1MlZPQmJETWpR?=
 =?utf-8?B?bHdhYUliNDVseDF1WjA1S0dvbmdRY1VPVGxyamdITUdRdnUvZ3F0SFVOZmQ4?=
 =?utf-8?B?aE5MbTJlZ3F0Uzg5clV2eTVVd2tZZkNINm1GQmFCdTRTdGR6V0NlRHFpNWNL?=
 =?utf-8?B?QUo0NkcyZ1hHb3EvbmFZQ0lNa2lFeWRMRjZmZmwxMGdtR3FhMHJqYUlSUklk?=
 =?utf-8?B?NUlrUGFCcGR2MlBkRENlbVZVT2YyVVp3VjBKclp5Tm5VZGVoWWxuaE9La1h6?=
 =?utf-8?B?cWMyZGFlNXdVTzFvelliQ1AveGdKcU9TcVQrTEN5ZG9YQkVBYkx4VjlqSEFT?=
 =?utf-8?B?LzJ5V2x6WUEzQVdieDZPdXMwMm5NN3ZMMmZvd014TjFYNzFGc3F3TmFwRVdS?=
 =?utf-8?B?NEF4aFhZcUVSZnlXdHVDZzBVaGtIOTY3Zk9hZENVY3JFNVBtcXY2U3ZIdGM5?=
 =?utf-8?B?TG1USjBvdVhWOUJhUngwMllmd08wejFzL3lZMnZhZWJEUnJ6Q3FBdzV4NGNE?=
 =?utf-8?B?ZXZpMU1adEtrSVlOWFhsbEwrWjc3R0lWOVk3QlVvNVR3c1Vjb2V3VVhITHJ5?=
 =?utf-8?B?YjExQUxTL3BqM2kwNGFuQWVsYW83LzQyUkVCNFovdU5LQWFXa0ZjWktGQVNT?=
 =?utf-8?B?cU5zTXBEM0tqNEx5QWhudmNsMFJDWGJwUVg5Zzc5RWJZTDc5Z3MrSERwQmV1?=
 =?utf-8?B?MytEbXo0Q3pXVG1QWXNIZkpPaEg0UUFHdU9CRFV2Q3BFcStlSGw4c1BFZmdo?=
 =?utf-8?B?Wmx5YVRrMHdQcFBUMWFlYzNpblZoVEVJQlZWSVdEckx1dTIwclVlWnZqZ2Fa?=
 =?utf-8?B?S3AyUEpzUHR3MnRITTZHUHF5YStFaW9EaVRJR3lnbk1CRjZnVFZ4YmRheno1?=
 =?utf-8?B?eHF4NFp1Z29MUzZUT09HWTcvcVgyQXpEcDRJeDVXazNKditMZC9DcmZaRS9L?=
 =?utf-8?B?VGJwUWhCVkNKNU1pMUdmNWVMU2p4c0Y0NjNBTUdLMS92bVU0dXBmV1MzUG9P?=
 =?utf-8?B?czVOOWYyN00zSnFPQTFNem5PTitlanVHMEdrNFdTb2NQSjBmOVMzY216cHRI?=
 =?utf-8?B?US9zNW5URTdxeGRkNkZKankxZE5mV1hxZHplOUZsZHZ4KzF2bWtJUUlUSzdX?=
 =?utf-8?B?STA5aEV5OEc1aHQrZzNOd1FYaFFOSFVpS3ZEVE94cktzR2Zod1oxQT09?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	sW3xkZY/5fTddnzw+/d1KnEs37s8yA4YZt85Ta0uqAOmo6/gEZrI7Bx9u4UJZzQCBkgSqBloqFA8GzQKz3i7ogNG+8j1N5J76+v0XOlYV5SdnBWbudtXiS5clQILsJlqKYXVa/TTYwKudk3CUsfRTYSxQhOBapvBPn9J2UmmY7bk/TYiZKF0cXm/NvqD46u5jApzYffxSOeUKF+TDX9XHtHUKeY5U+m6qZ1EJ7adj0ysbMgoNMdXTEcuDvwI77j7XNvERmYMPLgziMi4XvtQCUWzWlVA30vsc2q5m2q80zJKBtAnf3XA3Evf1kW5XqtMVfK/F3fK4Bki4k7VrlyA2SaWZ/0Ef2JC7T1GKGnVw+Y66I/Pj0bZfsdVlc189n6L8RY/3s2WR82IgBy0rGf3hYsO3aAfFbmVrNN8t67fwM3z6P6Op04mDhxuPfmFVFOyk8mmvgb/ETBPoH3go7XPBqsF0zy8j324YncHKzAI0W5hCdTU+r+UVVh2igh0t8ainhDED3GvPfUzgS2B0ucmix9HshDqmN6Dow+1fWyBLU5GjGn6S7eOPTOofoPmhKfztGWF20OnGd+Td8+DyCx/x7T6luBYrDYL6x/OS+LQ2C4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 170a0663-0066-490b-9af9-08de796f8f5e
X-MS-Exchange-CrossTenant-AuthSource: DS4PPFEAFA21C69.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2026 21:55:18.8786
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BuQViSbaqyoBtuqYL/T/Ga4sMD+YK3yKdjANFGuWMf3INDcnPgEj5ZUjBk3l9Ip4yjqqg+gZ6KanfMvRFPDgQQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR10MB7002
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-03_03,2026-03-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 malwarescore=0 phishscore=0
 spamscore=0 mlxscore=0 mlxlogscore=999 suspectscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2602130000
 definitions=main-2603030180
X-Authority-Analysis: v=2.4 cv=TK5Iilla c=1 sm=1 tr=0 ts=69a758cb b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Yq5XynenixoA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=jiCTI4zE5U7BLdzWsZGv:22 a=x0eKOSpe3m1H3M0S9YoZ:22 a=W_wgObZiZZpR-WtE39MA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 cc=ntf awl=host:13812
X-Proofpoint-GUID: qt9gZsG0W7iMQ8tcimexrkwXJq4r6rZ1
X-Proofpoint-ORIG-GUID: qt9gZsG0W7iMQ8tcimexrkwXJq4r6rZ1
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzAzMDE4MCBTYWx0ZWRfX96IeolHagMKT
 cwMEJwOWnrbTVchbFZA+lymyiuQVVhPvNHrxFStM/r0bZksuxFjhkUi8D1gRBf1ZtFu1JCtpR00
 1uilkYSPfn0RDtN4B6rCcR6bKA6eUxVHlk6MqwkE6366lTbCkSMZKFVo6KVYdw/UdKAaTm+9gbw
 tpw34a2DbnOwFcik+BBRwib31krvIaXAQ9TN4WUz912fG07iXQdj45xt7YB/6jRe/hmj3/yKHfK
 C14rbeXBtmdoximyQgEHQ2+TEmezzp56/v0mZnRSptyunQVFskpqCnf+NqcU5vB/np0KxxLW+m6
 epV434EVlBVy3B2h7YBNfUVr5Hj1nBUcOc4gBTlEHc3NpigqlWaesYzWlghIjUtDYu9OZBi/9wV
 H4WWh6E5GzHvsirToHt3KG2o+sYlCI0eZD7U4GovblZ0Omcz1nE79yJNwNsJzsSmkH43oy+RRQn
 U9AFjOsOPDzG6XBRR0kW3ctLTAqkepy9rlWknn1A=
X-Rspamd-Queue-Id: AED361F7D00
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[oracle.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[oracle.com:s=corp-2025-04-25,oracle.onmicrosoft.com:s=selector2-oracle-onmicrosoft-com];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	HAS_ORG_HEADER(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[oracle.com:+,oracle.onmicrosoft.com:+];
	TAGGED_FROM(0.00)[bounces-17443-lists,linux-rdma=lfdr.de];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,oracle.onmicrosoft.com:dkim,oracle.com:dkim,oracle.com:mid];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[john.g.garry@oracle.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FORGED_SENDER_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Action: no action

On 03/03/2026 19:48, Chaitanya Kulkarni wrote:
> On 2/26/26 01:18, John Garry wrote:
>> JFYI, I saw this splat for nvme/033 on nvme-7.0 branch *:
>>
>> [   15.525025] systemd-journald[347]:
>> /var/log/journal/89df182291654cc0b051327dd5a58135/user-1000.journal:
>> Journal file uses a different sequence number ID, rotating.
>> [   21.339287] run blktests nvme/033 at 2026-02-26 08:45:20
>> [   21.522168] nvmet: Created nvm controller 1 for subsystem
>> blktests-subsystem-1 for NQN
>> nqn.2014-08.org.nvmexpress:uuid:0f01fb42-9f7f-4856-b0b3-51e60b8de349.
>> [   21.527332]
>> ==================================================================
>> [   21.527408] BUG: KASAN: slab-out-of-bounds in
>> nvmet_passthru_execute_cmd_work+0xf94/0x1a80 [nvmet]
>> [   21.527494] Read of size 256 at addr ffff888100be2bc0 by task
>> kworker/u17:2/50
>>
>> [   21.527580] CPU: 0 UID: 0 PID: 50 Comm: kworker/u17:2 Not tainted
>> 6.19.0-rc3-00080-g6c7172c14e92 #37 PREEMPT(voluntary)
>> [   21.527589] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009),
>> BIOS 1.16.3-debian-1.16.3-2 04/01/2014
>> [   21.527594] Workqueue: nvmet-wq nvmet_passthru_execute_cmd_work
>> [nvmet]
>> [   21.527636] Call Trace:
>> [   21.527639]  <TASK>
>> [   21.527643]  dump_stack_lvl+0x91/0xf0
>> [   21.527695]  print_report+0xd1/0x660
>> [   21.527710]  ? __virt_addr_valid+0x23a/0x440
>> [   21.527721]  ? kasan_complete_mode_report_info+0x26/0x200
>> [   21.527733]  kasan_report+0xf3/0x130
>> [   21.527739]  ? nvmet_passthru_execute_cmd_work+0xf94/0x1a80 [nvmet]
>> [   21.527776]  ? nvmet_passthru_execute_cmd_work+0xf94/0x1a80 [nvmet]
>> [   21.527816]  kasan_check_range+0x11c/0x200
>> [   21.527824]  __asan_memcpy+0x23/0x80
>> [   21.527834]  nvmet_passthru_execute_cmd_work+0xf94/0x1a80 [nvmet]
> 
> I've not seen this, can you try following, from quick look it
> from copying subsnqn admin-cmd.c uses strscpy() and passhru-cmd.c uses
> memcpy :-
> 
> diff --git a/drivers/nvme/target/passthru.c b/drivers/nvme/target/passthru.c
> index 96648ec2fadb..67c423a8b052 100644
> --- a/drivers/nvme/target/passthru.c
> +++ b/drivers/nvme/target/passthru.c
> @@ -150,7 +150,7 @@ static u16 nvmet_passthru_override_id_ctrl(struct nvmet_req *req)
>    	 * code path with duplicate ctrl subsysnqn. In order to prevent that we
>    	 * mask the passthru-ctrl subsysnqn with the target ctrl subsysnqn.
>    	 */
> -	memcpy(id->subnqn, ctrl->subsys->subsysnqn, sizeof(id->subnqn));
> +	strscpy(id->subnqn, ctrl->subsys->subsysnqn, sizeof(id->subnqn));


Yeah, AFAICS, this same change is in mainline as an nvme fix, but it was 
not in the nvme 7.0 branch.

Thanks for checking

