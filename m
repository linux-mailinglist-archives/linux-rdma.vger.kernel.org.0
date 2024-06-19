Return-Path: <linux-rdma+bounces-3330-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CA97F90F210
	for <lists+linux-rdma@lfdr.de>; Wed, 19 Jun 2024 17:25:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D0F8B1C21342
	for <lists+linux-rdma@lfdr.de>; Wed, 19 Jun 2024 15:25:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1378214EC56;
	Wed, 19 Jun 2024 15:25:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="afnaGOO9"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2067.outbound.protection.outlook.com [40.107.93.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE72D14A615
	for <linux-rdma@vger.kernel.org>; Wed, 19 Jun 2024 15:25:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718810733; cv=fail; b=Wi1qfSmRQi1+8xhx0EkLE/+0i7ZlFxHlWSavyj+2aMc0kWEe3EdPFwvTpa9MZrLn2k2cAdWMuAkc4jRrBLDkcWfv6CEJ9Zdaraveqh+UnJ77tFDojwPi5RB6QFWYcQH207QEgBTukF8LYYMLYX9DXg24+RtU1jnj/XOrZo9fIfA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718810733; c=relaxed/simple;
	bh=6Zld7zuZ+k0R2C9iudS5wNuIrMqFP4nuNp/sG4ljwAk=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Qbmbc3YhFU4PcRFb63jxVUmGZzRlWg9V1BUfGEnKAzHA7CMNqnSFkTr77ou7p1TNmyY4mE9IqmNAaWE3AB1ruKKPS+fXVuWHxW93saMwLkCyXE/7hTxwlETPRlc5Jm1UTG756axwXDeKc17yDJX6n1PZFDyTJmd71/C9QL4ztjI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=afnaGOO9; arc=fail smtp.client-ip=40.107.93.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WxIXxR1BHoEl+3PVFR5ghFkM41a5KLv5xGtU9mycpiEFgW8kTPRFBY7JC8eD+PWvamXA2cnguwyw53YfB2rGTUoemPCZN/k7lb4iO+C7e6qxAIMXUqFmNE/EwhtvJu6OsVg2Gsi34kDuZwwiHfcfKx3hcVCQ8YeTfnQR5n7Rrs2FhvHpOmASpk+OLTjVu0ytBpYBTyL+DE0oyb8U+VDQYl9JU+ykECRXAK452ks7i1ZtdhteubQpJzyomjYrzfm8+Jeyb0YJUbNuDeegaucWgxgJ55KGaH2U0RU/rFT21G6VeWY6cZKnVFdXXqvUXmj1+Q0TYnWSnnpCoqp/lAo+Mw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Rh5PCn3VPguwtfrwiupKbGti0iGQeWSCXvrMoIMqPcI=;
 b=UhRhUG3HNS/by5LE3BCii8ULoug/eJCuvykUa0jeVYkiADePyWto1dgJr5rA3BlbXGVoYFJq9cWsOtJnb7iWJCfJ1K4jr7gTmuTifVnShbVclYSmWg/v5xfE1xBqKqX4ZNWHgeydDbgPqT7vetERFGCEkppUBojWpWxDvkF2zHG0MrAzNWKcuNDhvwuinlkgwf3PhWgs3btWfovB05Ew4KU2WwL+ztIqCWUdxmAJm9vCzomzORyUe0isYkJ6ZviCn/qcsTyNIjPKVomaEu2YptTIRd7SoPT5MFwg9Vbu5c7ca3QtZ4fh89nd1z5uKG4vZXQgCCwxJRBTkGSYBqJ+Ow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Rh5PCn3VPguwtfrwiupKbGti0iGQeWSCXvrMoIMqPcI=;
 b=afnaGOO9hkbViIoD6e0g6w33ferfHD1b5zGL+ug57vI6HGJnbH0SQTu7NOKY86xz3dzZMxO61bfPxs71tMEaJ0mOXUBbVW5ch1zFly+HDyVvANASD3UCcx/O8R56PHY3yUBaymeN38jxvM4VQIDTLt3mkbRHPoEUcdkJS+jm/4GveRf1U9xodT1z6bnjdmDGnoEF9+xz51P8IA3BVJETKDKQxk1D+4y+gZrgqYdfeTmOI/RlfP87bZiIvNedmifVPKmqk2JDzmAmAwW6QTs8UbvQMQ+X0aiuM5F2zNxPr44ZFwrEM49KmWJmt/9d6b0jTzMXU+mfrlP9ukqFfb+zPQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM4PR12MB5040.namprd12.prod.outlook.com (2603:10b6:5:38b::19)
 by SN7PR12MB6789.namprd12.prod.outlook.com (2603:10b6:806:26b::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.19; Wed, 19 Jun
 2024 15:25:26 +0000
Received: from DM4PR12MB5040.namprd12.prod.outlook.com
 ([fe80::a3dc:7ea1:9cc7:ce0f]) by DM4PR12MB5040.namprd12.prod.outlook.com
 ([fe80::a3dc:7ea1:9cc7:ce0f%4]) with mapi id 15.20.7698.019; Wed, 19 Jun 2024
 15:25:26 +0000
Message-ID: <e86ac51d-a6ba-436b-93d1-bffdfc65cb46@nvidia.com>
Date: Wed, 19 Jun 2024 18:25:17 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/6] IB/isert: remove the handling of last WQE reached
 event
To: Sagi Grimberg <sagi@grimberg.me>, leonro@nvidia.com, jgg@nvidia.com,
 linux-nvme@lists.infradead.org, linux-rdma@vger.kernel.org,
 chuck.lever@oracle.com
Cc: oren@nvidia.com, israelr@nvidia.com, maorg@nvidia.com,
 yishaih@nvidia.com, hch@lst.de, bvanassche@acm.org, shiraz.saleem@intel.com,
 edumazet@google.com
References: <20240618001034.22681-1-mgurtovoy@nvidia.com>
 <20240618001034.22681-3-mgurtovoy@nvidia.com>
 <f12e1a75-2fd1-46ef-aee9-520cced08f11@grimberg.me>
Content-Language: en-US
From: Max Gurtovoy <mgurtovoy@nvidia.com>
In-Reply-To: <f12e1a75-2fd1-46ef-aee9-520cced08f11@grimberg.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO4P123CA0675.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:351::19) To DM4PR12MB5040.namprd12.prod.outlook.com
 (2603:10b6:5:38b::19)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5040:EE_|SN7PR12MB6789:EE_
X-MS-Office365-Filtering-Correlation-Id: fdafc35d-db34-4b84-919d-08dc90740b6f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230037|376011|1800799021|366013;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZXp2NElVS1ZsRzU0UFRjU3QwcTJraitabG5wOVdKNlpoU29kTC9pR0dxL1hu?=
 =?utf-8?B?TEE1N0IyaTVaWnJMdGhLOUtNNTVNeFJJcHJVVE8rYUo1MUlFeDVIN0h4dVV6?=
 =?utf-8?B?ZEV3bUg1ZVRNQnlxMW9hUWMvVEF0ZmwrcWNqdVJuL3hFSXhhMzBFbnhFVzRy?=
 =?utf-8?B?dk5md29HK1hIRCt5ZFdpZk1pdC9zWE90ck0vWjFoWVJHZXJxMkdQd1Bvc3I3?=
 =?utf-8?B?VTdxMVlzbmVhYjRTRm5zbGQzdWl3aFRnUFI2VzVWa2h5RTkwOXNwcUdwV25a?=
 =?utf-8?B?TUd1c2JJdVhiUFNIdjRmdkRrSDBTNEk0cnRHMldRNm9mT3ZDUGxPYVJOVDBu?=
 =?utf-8?B?ZEcwZm91VzY4WW10NjdtVW9MWkRRb1FZZm1hNmR1SzN2WmtpbGZmZXlMVGcw?=
 =?utf-8?B?ZFUrcXQxWXlodFBDZ2ZUbEtJY1ZDQ0lMdnR1VlFHd1FvOXdTcjdSSTlBM056?=
 =?utf-8?B?aVliWTJlVzlZWUJxWlpFR1RhRjVyWmJacTB6Wm1mK2pla2gydmRuaDJ4ZXo4?=
 =?utf-8?B?WGRoeTUzcktzVlk0YnVmcWp4ak9GYlJKV3JLVzBmcy9ZeEUvWE5aVm9pVGYr?=
 =?utf-8?B?b3lYdi9XZSsrb0o5RjdEaGN4ZGQ0eCtmVmlkdjVhMzliU3Y1YVBkZitxZjZy?=
 =?utf-8?B?TUxBdEZmNTVOa3paeVkyK3lyY3Jhb2luRVNwaVl0SzBDMWN0UHN0eWRCeG5U?=
 =?utf-8?B?b2xMVTYyTloxaWR0ZjltR0JqdjF1RDY1V0tyanNQaDRENlFSdWlVWFl5Y0dp?=
 =?utf-8?B?RmhRZ29JaGk2RjlLamVwYVZnZUlwMWxBbW1YeE1PbTVWYnYyMmY3dUdtS09C?=
 =?utf-8?B?M0RCdSs1M1h0YnZKY0pndEw0K0hxN1JkTS91RXNicTBoMTBTaFBDNTRkT3l6?=
 =?utf-8?B?WkVIRGJ4UWhNK0tKeEcvM0I3NERQSFJ1b1ZPWFJveWV3V2Y3MVZaUTNsTExs?=
 =?utf-8?B?dS9icThPWnpOMlNkWElzMEJlUjUyY042NEtZcG9WNEpidm1VZktRSGpIaFho?=
 =?utf-8?B?VzJFajFEWW5rdVBSenYvYnhRNHptWGQzMFlidXhLYTZvTFBqZjV5TGI3VW9Y?=
 =?utf-8?B?RWpQbDIrczVQOTJmVE1ZYXhUZ1RLeTF6L2RCVnZzRmFwMU91ekJKZGErODhQ?=
 =?utf-8?B?cWdFNWFDenVOOVFYbFdwbTlKL2haUDNYcHhMYVRDQ0NVdm1ZY1hPUThMQnZj?=
 =?utf-8?B?YmczT2ZhMTkvaXdGZGlXTmJUMW80QkUwbmtVTmczM3JOemZqS1VMM1A3RUgz?=
 =?utf-8?B?QU53dmxkYXcvS2U2eVNweEhKWUQ3b2dxWFY1VmhUZUpNK0J1M2dBcFZWTjJx?=
 =?utf-8?B?eEluVTk2OGZwYUZZVXlzRzZrelovRVdmQ1V4cUs0TmdFOVdXMmJuK2g5b1dI?=
 =?utf-8?B?cVlsUFgvOExIMmFWd2praFd2T2Q4MWN2VDhId3NIKzhXcHZwdzdvTVNXUHFR?=
 =?utf-8?B?RXVtdmtab1BDZGk2Y0RzcDBKSjlBU3Q3MHF2aVZNdTk2dUR1T1lUWUU2djhv?=
 =?utf-8?B?eDdGT2dtV3FnSkxPWHVDaU5yZGJzdTZNYXZaYmVRNzZDcWRrcDVPbW1LUmdQ?=
 =?utf-8?B?VHlUZlFUNHhyTWRGV3dvelBETGJXbjNSZXMwSytFT0IxMU96cFk0Si9sdkEz?=
 =?utf-8?B?REpocDhta2N1QmZMUFA5NjRxM1h5WHJsTkJwL0k0WUJ2R3Rkc216QWVqN0F1?=
 =?utf-8?B?WXMybXFpcTNPSytONWkxQU9SVFRMZlM1TVRSdWMvRTJzVUVvOEpmbExOMmpH?=
 =?utf-8?Q?kuQ7liJ0QLJWxpiqM9R+cyxUBsBYVzxJ1tuqgPG?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5040.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(376011)(1800799021)(366013);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?L2tnN2V0bE1SaTdrNTZqWDh3RGtPcjh4ajFRT3Ezc21IcG5vcnZ2Mlh3UGtG?=
 =?utf-8?B?dVZ4TVdCemdnOFo4ZTBWOTJhOGlOU041NEZuWnBvT3NlYnRqYjFxM2pXaDdB?=
 =?utf-8?B?ajJKTUI2VHduZUFQdjNxZnJ6cStoRkxtdk1Rd0h0VkExcGZRdlRKVWhGbWZh?=
 =?utf-8?B?aWU0YWljMXpHc0VvbzdvakRnYWlmb0twa1JjQzdkeVByTk1GYjJIOGZ1T2F4?=
 =?utf-8?B?VUNETmtvaUkrdjRoaERtYVFMb3h3L0xsUFhJbUNPUDUvemdHbkJ1ZTIwbWRn?=
 =?utf-8?B?RkMvTnliaXJlanJ3T1FRTnE2TFIycmxoNHJUellTQithUVlLU241NllFNmhu?=
 =?utf-8?B?K2tjMWVuZ2dDUmgzazJMNmVaMHVMNEJLR2Y4bVRZelFZZEdUMFVDRW9uSWR3?=
 =?utf-8?B?RHBlZUZsYnhHWjFhU0NIbHF4dlJid1Zwd29JOVg2K2JiemZFVE0vK2VrNlU0?=
 =?utf-8?B?VHBiaVFhbkh0dXZpK29lTmNxTmJTZG50cTIzbnp6V2lqaThMMVlKUmpiRWlt?=
 =?utf-8?B?QzBQTzdJNnZoZG9SZ1RncDU5ZjlDUEJlc3liUEJpSGRnck1rdEZtbkJFVHVm?=
 =?utf-8?B?YXdCNFZVSjR5ZjBkWmlLTkt3OVE5UVpmbVBEZWFtaHlrRjVPRUlTOE1TZ0Yr?=
 =?utf-8?B?ZUY2YVZhYUh3dU9BcnJrS3JSMThob0NlZGxYMG1BTllZQ3MvWVRadERNaTBx?=
 =?utf-8?B?Vm41RTdsSDVNMjYzNmoxMndmWnQ0Mk9KZCtCbkI5MDhlNlNzbnp6YmMzRUFP?=
 =?utf-8?B?RXBuNlZlS3pQZVZFZGttTkVzZ0VwdlR3a2JlQ25KUnlQTkx5WEhtS091VE04?=
 =?utf-8?B?YTZWK3V5MGprdm1sUzRZUi9QMFRzMGcydDhLbFpDN052dHA0ak5TUkJ3a0h3?=
 =?utf-8?B?WVN4YmRseDhrVWNmQ2ZYb01LY2l0bFdGdVU2TVkxL1dVT1VwYlBDNnVkdWdx?=
 =?utf-8?B?cHZPM0xBdlpJVGo4VkhJSjBMd0drSndNbjZHZlhCMXJBTlFrODVtTFNyUzhL?=
 =?utf-8?B?SHFWY0M5enNrNHZ0S0s4MWxwZlQ2c1VVTHFkdjYzWlZLN292Q3p3NzdIVHVm?=
 =?utf-8?B?Yk9Yd0R3aEgvWDk3T3hyQldOcnZCUUtybG5ENG5ORThiNUtLamVPVHU2OVJE?=
 =?utf-8?B?OW0zNXBIdkN1N3ZyLzV4MHdCOGhwMVRjTjNibStIemdmM2w0b2NRSFo4ZVRS?=
 =?utf-8?B?QkQzRDBSVmphSGZETllXVWZOTWMvVEt2bjl2dDR5a1FIRzNSdnFBZkFxV05z?=
 =?utf-8?B?c3pLeWlsODZoYjduTXNCODZ0SHpXUFNsWS9MRGZCRURmc3BWUnFTZkNwYXk4?=
 =?utf-8?B?WjFYQzgvOUNFcWtxRTE3cHZXU3BKM3NJUWZSd05FbzFLL1NUakJ5b1VrcWRv?=
 =?utf-8?B?QUdrdWtKZTd4NUdhVVo5dXF6VFgydmhKaWZzNlNnZ1Vjb2hGazVBbTg2TU1G?=
 =?utf-8?B?WS84VHVJTXdFRkFnN3pKazZIVXNlTFpMTlZieHdGaGNKVjh0cHRVR1lqNmtS?=
 =?utf-8?B?T2tzempGRlByTFZwMGRIeDhCZDh1Znlxc3A4WExKbmEwNGpmaXVPMEFQaENN?=
 =?utf-8?B?aGRQUUI1MlAwT1VFYjNuc0g1QUZJYzJ5SzNEQ09sOHZIQzhPcmdmREo1cDlC?=
 =?utf-8?B?TnVPMG1QTlJ6anR4Q3JDdFBZK0xqSVFOSnIzRmJuY1hyRWxOMzZmZURHTkZB?=
 =?utf-8?B?d0VraVdScXgxeXpHelp6dUdyYllRUTg4VFpmaWFoQ1AvbmxiT3RTZ1NmMVFR?=
 =?utf-8?B?SHN6TzQvV0NYekFaZ3BRSFpVK2tNayt5NXlNWDhRZ0VTbDF4RG43K1VLcmhk?=
 =?utf-8?B?bVZJUE9RcDJVV25wOFR2RjBjREFuWCtQLzkxTDVPWktLdCtxUUswRXk1K2lH?=
 =?utf-8?B?ek53L0QzSEhiT1pwL0I5Y2k3WXVyc1dyU0oxREdMZ216cjdiT2Z5NDF4Ty9W?=
 =?utf-8?B?UDJDdkJyMkQ5S3pvcFdsMFR0T3Jubk5NYWkveDlWTDExMjdsR3AzVzdDMzJv?=
 =?utf-8?B?NnlzY2FkNE10bmhyemNLTXoydFlIWXFTYTBtODV5enBPNzQwZE1MSldiQVlT?=
 =?utf-8?B?endxUTlUQ2FwNXRvMmphSjNpOWNHSUpESkFxL29xN2dhb2I2UkU0cEJMRlFI?=
 =?utf-8?B?eHlUemlnQ2VGeGJIMFZRcWFoWXBXbUJVVU00aER0V1VLUTBWU0kxTHd0bVdI?=
 =?utf-8?B?a1E9PQ==?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fdafc35d-db34-4b84-919d-08dc90740b6f
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5040.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jun 2024 15:25:26.3826
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sjVQL6HPjpT9jOGSolg5WM1xd8uSFs8K5f9hi1MrBDMPWLkkGYnDwsEgzg1wZ3OceyTBTHX6GPO9NTRYVVrQ1w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6789


On 19/06/2024 12:16, Sagi Grimberg wrote:
>
>
> On 18/06/2024 3:10, Max Gurtovoy wrote:
>> This event is handled by the RDMA core layer.
>>
>> Signed-off-by: Max Gurtovoy <mgurtovoy@nvidia.com>
>> ---
>>   drivers/infiniband/ulp/isert/ib_isert.c | 3 ---
>>   1 file changed, 3 deletions(-)
>>
>> diff --git a/drivers/infiniband/ulp/isert/ib_isert.c 
>> b/drivers/infiniband/ulp/isert/ib_isert.c
>> index 00a7303c8cc6..42977a5326ee 100644
>> --- a/drivers/infiniband/ulp/isert/ib_isert.c
>> +++ b/drivers/infiniband/ulp/isert/ib_isert.c
>> @@ -91,9 +91,6 @@ isert_qp_event_callback(struct ib_event *e, void 
>> *context)
>>       case IB_EVENT_COMM_EST:
>>           rdma_notify(isert_conn->cm_id, IB_EVENT_COMM_EST);
>>           break;
>> -    case IB_EVENT_QP_LAST_WQE_REACHED:
>> -        isert_warn("Reached TX IB_EVENT_QP_LAST_WQE_REACHED\n");
>> -        break;
>
> Don't think you need to touch the ulps, they want to log these events, 
> so be it.
> Although, a warn is not appropriate at all here.

Ok. I'll remove the ULP patches, besides iSER target that is not even 
implement SRQ.

This is a dead code.



