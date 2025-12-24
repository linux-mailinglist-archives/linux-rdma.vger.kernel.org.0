Return-Path: <linux-rdma+bounces-15211-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E1186CDC243
	for <lists+linux-rdma@lfdr.de>; Wed, 24 Dec 2025 12:37:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 867D63008D73
	for <lists+linux-rdma@lfdr.de>; Wed, 24 Dec 2025 11:37:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93DBB322B68;
	Wed, 24 Dec 2025 11:37:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="N8VkWOgD"
X-Original-To: linux-rdma@vger.kernel.org
Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013045.outbound.protection.outlook.com [40.107.201.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6E44314D2D;
	Wed, 24 Dec 2025 11:37:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766576224; cv=fail; b=pIaQ3zchO7JsTrBYQ0BBDY2uHnmLoHfWCnVu3/ZjnICm5FFcKIS9IKXW5WFVFoxaSFmEKX8Pn9j+9eVeT3WabVBSi2OtkOEFKVbfxR1cI0EQo4yLTuXVjqYqeYyB4BruvVnad4segHHpTz4hU1oihj9wTUmLvwOQUd9mS/EDL60=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766576224; c=relaxed/simple;
	bh=NhTeDRK/Y65n9merSUiAS/JCbsmtiENSs3EykhhRu0w=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=EVu9iXyC/S3KPouYaIuPx0ry4xOqIFfO+vpoecOoss32qIIaUMUp6DLW8IqmlKfuPBjVFAiQ+O09DNnomQNuyr/RQU74OOtpP9jf7FQ2mGhtvr2G0yozx5XhwAtofmqOPXrqnAGCoSqFSP2xBbiJdSa7XRzi+N1YvbRTjMFUZoc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=N8VkWOgD; arc=fail smtp.client-ip=40.107.201.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sB8qSzrMpqC+PCna3dzGlpBsAfLSqUlhgDKC3TtUMm48Z86XCWPmcH+scGObmQnt+oUOWyyXUesaMLMpDFtxRlNLgiG/ncatXIJ7IDZMhjUW3q8TQHmdEqiEQ9RO7pq3g43rOt+K8oe0qaAMufkQDyCG/aQ3hepCOxshyF7KW0OC2zCbLS0wD3G8ZEqzKgKuDZtvWCzD95N2CNNeqAbWt+FR8dEcKFtNptCv6kTOXOJncmXzM0PlYw8o4a1tEvrQw1vsxoQSNm7/7KV71uOiK1qg8XYBwr6cRS22O3Z4HIpG49tnQB/YM4MQEkSGDBrW17tblpY10NPMwYHvgi6KxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JZMtxE0i4txXSFOx/fctWL6jh1gVyzU2N1iS5COxVqQ=;
 b=yPLWjjukIoaj5IRSWPfeH46GYJ/O2wMBuWg5EFfb4JtHC8qLnjn/kEc+9H8m3JOOKG/UAc2JWDiG2tCzKc5P2CJ+ebaeossx1e57hTcFPtU1n3irhhEyORkyY2C+zAmwzlrTZPPeWO6vgvstaNZAuWz4LsewuimWiUboW7hcj3jS0I7wn90+x7r9CGCVwy2L5EbUB4HtjiZadoRk2T/G/01cssEtCNuhyjU9JJaGFiwvBRTHPgVZic1cyP7Z7rs5L/wGaRNBChdY4OD+HNjvpk9sXj960FJwKCqCH6ylgn9mvamEUSBMZVb5Eywoo4RHRj2e+d9hjByoQDdZKvuPJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JZMtxE0i4txXSFOx/fctWL6jh1gVyzU2N1iS5COxVqQ=;
 b=N8VkWOgDf0QShIpz2uSnJuLiay3Ke5kd4y8qos1zrSaL++gOyMHNcBxSAsc0/6zoX+M/0D/4KySI+z+dR/FaL/eH3KKxqn/+GtYrcv69WinPnU6CVx0eiweBh8zhaR4XmWCI2n8xxzvbN6MN8f1trvgV8Rqc5swgtw2jmStU1tL5YOLPuSzJPL1GgX9n4gwepYSFZ1zNn5YMcQX4HoHka7D2Fhb63DXrv7m2fV6R3J2MYitM1nFkJSlQ0M3VQWC4+PEWzGhEVIb08/1bFh+E7d1sTKekNlVyVOHdwfbx4XmSeMsqfIqQftiVgKNHMJbxvD8tuxyOhU3mE9KAdpJo3Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9715.namprd12.prod.outlook.com (2603:10b6:408:2a0::7)
 by SA1PR12MB7152.namprd12.prod.outlook.com (2603:10b6:806:2b2::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9456.11; Wed, 24 Dec
 2025 11:36:58 +0000
Received: from LV8PR12MB9715.namprd12.prod.outlook.com
 ([fe80::1643:57be:ba7:a15f]) by LV8PR12MB9715.namprd12.prod.outlook.com
 ([fe80::1643:57be:ba7:a15f%2]) with mapi id 15.20.9456.008; Wed, 24 Dec 2025
 11:36:58 +0000
Message-ID: <4b78fce8-5ead-468c-809d-72cb3479c69f@nvidia.com>
Date: Wed, 24 Dec 2025 13:36:54 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] RDMA/rtrs: client: Fix clt_path::max_pages_per_mr
 calculation
To: Honggang LI <honggangli@163.com>, haris.iqbal@ionos.com,
 jinpu.wang@ionos.com
Cc: jgg@ziepe.ca, leon@kernel.org, danil.kipnis@cloud.ionos.com,
 linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20251224095030.156465-1-honggangli@163.com>
Content-Language: en-US
From: Michael Gur <michaelgur@nvidia.com>
In-Reply-To: <20251224095030.156465-1-honggangli@163.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: TL2P290CA0026.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:3::13) To LV8PR12MB9715.namprd12.prod.outlook.com
 (2603:10b6:408:2a0::7)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9715:EE_|SA1PR12MB7152:EE_
X-MS-Office365-Filtering-Correlation-Id: d6090540-c425-4b06-3fc9-08de42e0bf61
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RmdFV3ZWMjE1dEhFdDFlOU5zZU0ya0I4VGErY0F2RDFQMlVwU2IzZUlnRE5h?=
 =?utf-8?B?YWphMmVQV3IrY1RPU1NqVFc5blhMSTlwNXFEd0hNSnlRdk9YRkdKY2FRaVJV?=
 =?utf-8?B?SVpmK29EbjhtcGN1MS9JdTQ2RzhaTXgrWVpiVmpjejR1aFVLakNjK1lSMndo?=
 =?utf-8?B?V3Z3NlpybHkyMXlVUUw1akdYL0V1STVRMU01bmNnM29RWGZMTUFibzNHQlVY?=
 =?utf-8?B?Wk9CVDQyR0FmeHdnUTM2blA1bmxrZ01vb1c5dDJjQVBaTFBGaGtxMW9jVWJH?=
 =?utf-8?B?SkhZdTBiUGVicjlNSUdua3NBWm96REFrOEwxNi9iTUpKWjBZR0Vnd3Y1VVcz?=
 =?utf-8?B?YWIwUVJWeWJOdURtL1VyaFBVUGRIRUxtWG8vcDAyQkRvSjVtZlJCay9QRHp6?=
 =?utf-8?B?YXprZlZoR3R2ZURwdDFCVXVxc3p6S09Ed0Z4eGZBdWhraGlDOHRORHYwQ29t?=
 =?utf-8?B?UVhTMnJPdlk4ZXgvdWZ4VDBpbXlqUk8wQm5NSlFwajcrcFlEaVIyRXJDeCtO?=
 =?utf-8?B?UWRua2l2Z2JQQm92QjdmM1c2R0xSQzdkZ050aTNDZnlEbnlVbXc5SGtDOVRL?=
 =?utf-8?B?N1VyVUZHeVd0R3NWay91UTU0cHIyQkx3L3gycHdTcHh4WnRhTi9kMXJQRTI0?=
 =?utf-8?B?YnYvclBlWnVHcmlFY2o5Wi9VRndibkpreWYxYkd0VlVLSUR2bTBmTUtnRDlt?=
 =?utf-8?B?ejhKVVptV0toSnpvY3ZVQVBNRlR6VGJwRS8wSFJHUzdSTHZpSUhUYk80VVBn?=
 =?utf-8?B?TDFHSWFRS09KSkE2c0dqUHMxeEFXMEVrMzVDSlJGZzNKZEZ0dlBkYmMwOVAr?=
 =?utf-8?B?TDllc1N3WXZMM3BtSnRFNGNmUUJqQXlVSzNZK0kyZWRqSEtDcGtRbWZwTU00?=
 =?utf-8?B?ODB0aEZaUHloajQzRnJzcUNESWVvNWlVbU5PZGdQbUFwdWFYZnJRM0E2UU80?=
 =?utf-8?B?QzgyT2cxS1hFZ1I2bkdrc0dPRitLenZobW5WTjU4YnIrMVZLb3M1VmpoUGQ4?=
 =?utf-8?B?ajlzRnpIdEJ0UEl5MUpzNHRMUFdnR1pTTTc4N0l1NnMwL2lTa3pYSDdJQnp6?=
 =?utf-8?B?OUhMZjA1M083dE1BY1NEYkZpV29YMENyOVBNclFzRHlhQkE4WUx3azFia0JO?=
 =?utf-8?B?cnBVSkV4b0dJQ1kyOUxRbFNHVS9OMUpjZnJTZDM0VThyNmowK0twSERudTk3?=
 =?utf-8?B?b09mS0Nad1dFSkpxM0ZDT0ppV0lHbzNkZDdxYldSK1BOQjRtK3o2YUxocmF3?=
 =?utf-8?B?N3lMYmhEYk41ZkREVy9CQ2tMZnhxdmlLb1p4d0YxS3JmZWNrM0pQTjhzaVpn?=
 =?utf-8?B?aUgzK1RzdjY5MGlRR2FnaXl2T2RqQngrVlBNMzRWZkcydDg5Q1pIbDI5SEsy?=
 =?utf-8?B?RFhscXhBUzVpVjhwTDFpZURiaHpVS0pIZlVWSG8zREZ0TGdKMExLOTk1a2dl?=
 =?utf-8?B?eFl5OE1aN2ZuM0NjSFZGbU1IOUhENjB5UGxaTkZMakpTSCt0WlNvVHBLVXBn?=
 =?utf-8?B?UmFhTWN3SmdBc2JzWXR5aWhEL3dPZ0F1UlJOTWZTb2loaHUySkxCcVZBcGgv?=
 =?utf-8?B?cyt0SEJ6cEhXQXZQeEdpSjdSZDdiZWZLMWtmUHBMY2RjeS9NQ1JZR043S3o2?=
 =?utf-8?B?ZURXdFVrVERHSWpOSmU1RjhMbnZZVnF6aUlGeTZtL0N6YjkvZ0J3M3dKV2I1?=
 =?utf-8?B?cDdiS3JwK3dMOXZwTVlzM3hhWlJ0NVdQNERDbk0zVUdnZWxIQ0lsYm5PYTdi?=
 =?utf-8?B?MnBjeEM2aHIycEdha3paWUhud3BHTVVZUjZ2aXlJS1JhTVBHRjBtdUZ1c2JH?=
 =?utf-8?B?dXVLbTZ0OEVxVVpBTWpVdjl4cjVtbU1DQTAwcDdSL0pnZmhsRUhPa2Jkd1pK?=
 =?utf-8?B?MW8yQ2RHbVJDelZvdG1ycXFlS3RNNEptYk1BMW1FMnkyMU10MW5TZ1JHbDMz?=
 =?utf-8?Q?cABggOrxkwu8yGVRNewg8jrNHwm0yfjY?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9715.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cG10cVRSeCtrTW40NG0zd203ZWpjSFg0bTNIQ3VHUjBhUGtEd0hpZjB0SDh0?=
 =?utf-8?B?RC9ZeWdkQmVBUVY3QllJMVV3SitwR1I2YU00dEpSdTNVZ2ZVdGd6anFRbHJo?=
 =?utf-8?B?Kzl2cDl5SEppOUY4QktUZlRYWDlDaTdidDZsK3lqWXZFNmg0eUtOSFdqV2VL?=
 =?utf-8?B?dThuYWRINWpQNU5TcXE4UW9NYTJDUkdPV2hQNGVTeEQ4RG0yb0lXcW5Ka0d6?=
 =?utf-8?B?TUNHUXJlUUU5alM3RGcvTjlNMzliUkFWRkJKLzU1UHJzTEJnUzFtYnR1M2JK?=
 =?utf-8?B?YjJMVk1VY3RsNnNuaVBOTWZ3RUQvcVd2bGQ0NmtqQnRrUzFET0dyYXRBSE9H?=
 =?utf-8?B?NExER1BxbzU5M3UzbXlrSVFISVQwZ1M0ZVhJS3VsZ0Y0WVVRRGFsN0lFMjRw?=
 =?utf-8?B?dWYxV0MyTGRUblpMTEgzQU5iamdTQjNHaFhXcVBtdDZlZHRqN2ZxQm0zMzdh?=
 =?utf-8?B?dFU2YWUzTmZmbitwTnhaYXJWSFp3VURwM0V3SHN5UFFpNVEwaU1BWWNtT3Vl?=
 =?utf-8?B?VERlQmJ4WXBVTDhaRU1veTJ1NUVKZ1FMS2RoRWxnMFM4ZnlJUVpFbmpuRis1?=
 =?utf-8?B?YkpGNWhrMVBmaVFSbkhjRGhiVTlZbWsxa2F5VTRMWGZUbEtEcGlURms0Z3lv?=
 =?utf-8?B?YVBKOFNqZDVrWmFpOXRmVjcyTDNzV3hDMytsWmdiODlMK1hNNzBSQTR2SWo4?=
 =?utf-8?B?Q2lJbTcyd3BxM3dKcTVubzRscFVibm9rRUQzR0F6YUZ5UEgrVXNXUlVFU282?=
 =?utf-8?B?MXZHbElWWUYrSlA4VWljakJ0d0V5c28zYzRDYVB1V1lxVWhXdWM4M0hqMWxn?=
 =?utf-8?B?VXJwYXBaNldyL2xXN2REVU1OUWRYUVhIR2ZGckZJNzdtVzZPWndSTC8xc2tz?=
 =?utf-8?B?WDg1TmwxeXdNOWE1TDVwZ291VTQ0NGhGaFcwdndPWVBkY3ZBOW5FRE51enpy?=
 =?utf-8?B?ZUN5N1BXWVFiems3NzVoM0gzRWlmTGQzcm53Zk5zbGREakZRczJ4dlk5WDhB?=
 =?utf-8?B?RmtRSEhNajJSMXUrcGlLTExKTVprNTZjek5JcW9SdE5IMStwMXRGVWxYUDBn?=
 =?utf-8?B?SlFyU3FQdTRMQW9ZbExmdlU0UWtrcmFzbVRlQW5Pa3kwaElyaHNrNTk1cVpS?=
 =?utf-8?B?c1A1bklqM0Y0OTlxU2tqUG9OL3BuZWRDNXl5Q3BMYnFmajFjTFlxU01xN0RT?=
 =?utf-8?B?djY5eDNXbzlYaGRSTFVVL1REZE9MYWNsRXFSRjIvOGVUTThKaFVTUFcycHJl?=
 =?utf-8?B?bGYzbHc5OXJ4ellMcnlSNTRtNjBBbGVMdVFIRVJEZW40OEtsSnhKKytLUFdZ?=
 =?utf-8?B?dEVtNjJjV0IrVTd2VmZYMUthbFo1Qk9JVzc1MjFQT0tYc2NwejdYY081TTZW?=
 =?utf-8?B?YnBKY1NzTjhTZGdxeTBEdEkvWi9WUGFmeDA3Mzc1VHd0Qk1SZEptYjQvWkxt?=
 =?utf-8?B?MXVXTzJVZTcyeHBtN1NLdDU1Vy9KNlBLbmNiaTIxYzFBWE0vN1JuNmhCS2Q2?=
 =?utf-8?B?SFdhSWRGdHBhSm5tMDB4RFRrRFNsY0ZBSC9FQ0kwREZ6MktKSk1yYzZDdjQv?=
 =?utf-8?B?VzZGdVVjTW50S05NemloU0l5WUk5cC91dkIwOTIxaWpwYTNUelBqVnVHVHR5?=
 =?utf-8?B?Q1Y3cjNKcElQbklLS0pLTFMvbXMxcGVBSEFpVFpRWlk2VlpsQlhyclFSRG9x?=
 =?utf-8?B?aUxjbVVsWXJ6dTI5Tmd4UTUrZnBPaWE0Z3YwUEF3a2NsVS9oNXd3NGFSRDFs?=
 =?utf-8?B?WTZ5dFRleklxVzMwSGdzYmE4MDdmR0FYSWNBeE14NDdjSkpscDIwdHVEZ1RS?=
 =?utf-8?B?VGh3eU9ZcVZpNTBTMkNYVzB4MjgrLzA4SG9UTGtyd3NMOUJSL2tWbnh2T2p0?=
 =?utf-8?B?U0NzbUpVZUlBc0lHTGVienhxbmI0cUtDQ0ZjWVpLbVpHdUJWbVVhK0Y5cXFH?=
 =?utf-8?B?ZFRHYmxWT2hLdEVWeFNGZ3owYi90OTVoZ1lGSUpzVHhVd09VSzFicktTMXhV?=
 =?utf-8?B?Z3B4aExtY0I3bEdCZ1pjV2tHYjg1Um9BR29rQ3YzQVdPc1J5SnhmUDJVSmU3?=
 =?utf-8?B?NVFaR3Y5REkwVTdsVjlzNEJtUmFQUm5ISElvWUwxaWNTWjduU0o2RlFwZ1Mx?=
 =?utf-8?B?enVrVGwxUCtpc3hhQUV1d3F6UFcvM2hoUWkxK08wckZtall4dGNKTW1NK0lx?=
 =?utf-8?B?SlRUanRjT3Z1N3BFcjAzWGUyck1ldU5QdEJYZk5LSjhsTUx0ZkRRcEFYWk53?=
 =?utf-8?B?RGk2YmRLYXZXbDg5YUpvK3BMNGxDdzZ5SlZMTTc5MDN1cG52WTdPVjJYL2Ji?=
 =?utf-8?B?UUpjR1dlRFQ1VXJmUzJ1Y1JGdDgrRU9jWW1TcFdYdlM4eWg3dUdqQT09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d6090540-c425-4b06-3fc9-08de42e0bf61
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9715.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Dec 2025 11:36:58.6048
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jKyW6NGUBXW9Z5u96VAipBjXR2YovZmgNmDhTp8vOBzAj7Dmyr6NFSg/g4mDeoK6KmTC7oLB4TaE4l3sPgOMDw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7152


On 12/24/2025 11:50 AM, Honggang LI wrote:
> If device max_mr_size bits in the range [mr_page_shift+31:mr_page_shift]
> are zero, the `min3` function will set clt_path::max_pages_per_mr to
> zero.
>
> `alloc_path_reqs` will pass zero, which is invalid, as the third parameter
> to `ib_alloc_mr`.
>
> v1 -> v2:
> Correct the commit message and set max_pages_per_mr to U32_MAX
> as Michael Gur suggested.
> Fixes: 6a98d71daea1 ("RDMA/rtrs: client: main functionality")
> Signed-off-by: Honggang LI <honggangli@163.com>
> ---
>   drivers/infiniband/ulp/rtrs/rtrs-clt.c | 2 ++
>   1 file changed, 2 insertions(+)
>
> diff --git a/drivers/infiniband/ulp/rtrs/rtrs-clt.c b/drivers/infiniband/ulp/rtrs/rtrs-clt.c
> index 71387811b281..e477d2c0ff35 100644
> --- a/drivers/infiniband/ulp/rtrs/rtrs-clt.c
> +++ b/drivers/infiniband/ulp/rtrs/rtrs-clt.c
> @@ -1464,6 +1464,8 @@ static void query_fast_reg_mode(struct rtrs_clt_path *clt_path)
>   	mr_page_shift      = max(12, ffs(ib_dev->attrs.page_size_cap) - 1);
>   	max_pages_per_mr   = ib_dev->attrs.max_mr_size;
>   	do_div(max_pages_per_mr, (1ull << mr_page_shift));
> +	if ((u32)max_pages_per_mr == 0)
> +		max_pages_per_mr = U32_MAX;
>   	clt_path->max_pages_per_mr =
>   		min3(clt_path->max_pages_per_mr, (u32)max_pages_per_mr,
>   		     ib_dev->attrs.max_fast_reg_page_list_len);

Checking after casting means you'll also assign U32_MAX when it's zero 
before the casting.
For that to happen in this case we'd need to have a device with 
max_mr_size smaller than it's lowest supported page_size.
I think it's safe to assume these are not valid device attributes, so 
we're safe here.

Reviewed-by: Michael Gur <michaelgur@nvidia.com>


