Return-Path: <linux-rdma+bounces-3316-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7ABF690E90F
	for <lists+linux-rdma@lfdr.de>; Wed, 19 Jun 2024 13:13:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7F3411C2298F
	for <lists+linux-rdma@lfdr.de>; Wed, 19 Jun 2024 11:13:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54D0C1369AA;
	Wed, 19 Jun 2024 11:13:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="TIEFANxD"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2075.outbound.protection.outlook.com [40.107.95.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FE6E132112
	for <linux-rdma@vger.kernel.org>; Wed, 19 Jun 2024 11:13:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718795587; cv=fail; b=jD6u74rEQBkjZXDAdSusMb1BnCXUQCpfPupg2XdmePo+gSxAFJWqy8NCcb1MExGlW43C/DvzCJ/L2w3I9sKv5i+4+aNJ3sUdj0qwNwx4+1Oha+cjWqglJmDzuteOAgoVZuD7mui4czJmZ4B9Er1OyQTsWCtCLL1QGcFj/3Vh+eQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718795587; c=relaxed/simple;
	bh=9eQO30D+/8U4C8Cxqx12OLbFzH3YQJz72m9gnZlvWsA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=jcS1/XFPeWCFTlhOjbgI7aVFDvcYoiOnfuUcp0J1Dh37r4nqO6+sIm846awN3WqBYG+OWAYYBtkR6LPKuPeMdBCLMr2MEJlQhEN2yUS3qMFlqi0zfek8m8mvpiXcB6vb5oGOl/9QqMIylKOvxXQmnC8S1EcjVyyoKOjp6GT7KPg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=TIEFANxD; arc=fail smtp.client-ip=40.107.95.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=meJeitPsEzDK2pjsd8lGR+2Fl/rwpuHeAMJ8/FNOkdjvURqu5jqtm+i8PrpzH3VTq2Sn1HNXMa3jmQ32Ui+CcSwTFEQ10ZCZXY15ANbUKLjrvm6wFmR4NxU+1l5XXghtPtvJe5cTCsrmNCfkXxX5DZerGiUGlim8DJzlzAIRvwzWsu51yLyI6e+zXiYlj5cGxST7A3RSnfwtXn+u8DHVspyTNZ7PaD36cM8h4dEMgLm7M6nF8ccnJLUpX84xF34Vn7XrhvYe8EJvfWS9n13Y7QzKuh1MUK5PQZbzxXtr4iPbUROlpYLKefC9oVqiG+EJP+rcTsiEjUvdgakf9XE+Tg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1HAIP6QCLigizIhii8WmMaYR2jhSHwVEUHKx/iGU8bQ=;
 b=dKXfMp5BoC6bZPOa8KnFcoKBTwep/zs/QVAI33/gX+OIW5lqL8gbtZrNxqUVeY8w3KCeUWJBK2A1gu2Ybg2yefPCFk9lkjSXKJhGw+Dq1IE5/y3DFw9PPmBU71exBQGq221+1vLhI3HhTF0ZCXUACHNQ0OcGKuRph158WlCQbVbNERZYRUcwCAGxFMf+RbQ+/afqIOJw3o7yFNCr0ctKf/qfduGtdho3l6f6U1uQn0PgduYFym0gCM16O1KqYy2moz1MXJSFGm6QIvlblc+QkjnCHsLiXev7ysQjytrJO6hTLSePJblZqjn9sX6TgweeeahJUfXpD8ZQ2P08nb8pHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1HAIP6QCLigizIhii8WmMaYR2jhSHwVEUHKx/iGU8bQ=;
 b=TIEFANxDHkv0VsAqX07O2EDW5a0t07E7Tip7vAc6uXTkWCU4djOAjBNhE2FrBEIiI6+QOEwboz77oSA+ydZL8pI/D5gGFcOLy1L4Ucg428F5UMDnQkvdobYP3g8A6BG/OH+J3/mD+c52TBVi3YalNIybo+92pnmsTqb//TNo2Zep4PcN5WY5hUsZbi9LmFVIWwlqGM0hZ1njE7iDkj8lkJN7kfKNICUyh7ZApwJeTe33cU6JaUJsRUNg+IEkGQ5hQDKRCPgn3d2b/dfvK61faijQ5YGCp10XHBJNCYbkK8vf0FYANwm/4v0X3PV3Gmjeebe6YpLM7wms+Kk11X3Iag==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM4PR12MB5040.namprd12.prod.outlook.com (2603:10b6:5:38b::19)
 by DS0PR12MB7947.namprd12.prod.outlook.com (2603:10b6:8:150::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.31; Wed, 19 Jun
 2024 11:13:02 +0000
Received: from DM4PR12MB5040.namprd12.prod.outlook.com
 ([fe80::a3dc:7ea1:9cc7:ce0f]) by DM4PR12MB5040.namprd12.prod.outlook.com
 ([fe80::a3dc:7ea1:9cc7:ce0f%4]) with mapi id 15.20.7698.019; Wed, 19 Jun 2024
 11:13:02 +0000
Message-ID: <8392ef0c-c364-4acc-be65-ff5fcaf6dba3@nvidia.com>
Date: Wed, 19 Jun 2024 14:12:51 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/6] IB/core: add support for draining Shared receive
 queues
To: Sagi Grimberg <sagi@grimberg.me>, Bart Van Assche <bvanassche@acm.org>,
 leonro@nvidia.com, jgg@nvidia.com, linux-nvme@lists.infradead.org,
 linux-rdma@vger.kernel.org, chuck.lever@oracle.com
Cc: oren@nvidia.com, israelr@nvidia.com, maorg@nvidia.com,
 yishaih@nvidia.com, hch@lst.de, shiraz.saleem@intel.com, edumazet@google.com
References: <20240618001034.22681-1-mgurtovoy@nvidia.com>
 <20240618001034.22681-2-mgurtovoy@nvidia.com>
 <244b708e-be75-435a-8b27-c48e976d4cdd@acm.org>
 <85c93883-8383-4ed0-b742-cf062bf2a271@grimberg.me>
Content-Language: en-US
From: Max Gurtovoy <mgurtovoy@nvidia.com>
In-Reply-To: <85c93883-8383-4ed0-b742-cf062bf2a271@grimberg.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO4P265CA0032.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2ae::18) To DM4PR12MB5040.namprd12.prod.outlook.com
 (2603:10b6:5:38b::19)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5040:EE_|DS0PR12MB7947:EE_
X-MS-Office365-Filtering-Correlation-Id: 53e78302-6e35-4321-6430-08dc9050c8f6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230037|376011|1800799021|366013;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VGI4Z1NyTEtXZGdzZHNWaFlybmoyZWorUkpENnpRRmNoUEg3cUExNEUvYU91?=
 =?utf-8?B?dVEzZGNoY3djcmVtZkFMaktaL3ZMQnJWeHRVczg3YW1QcExKY1FWcTVNK3hk?=
 =?utf-8?B?aVNtZmQweWQzc1dhM3krRnlaRnFUdzBmK2dZbnQ5YmhNdy9VdTJ3TG51Kzdh?=
 =?utf-8?B?SUlQcjR4OWc1b0dnYWw3UUQ2UG1HRUtpR2lhUVlUUlFsVnZ3T1N3QlhseUpP?=
 =?utf-8?B?b1V2TTJoN2pJUmhpbG5jaTI5NFY4NWgwR29kQlN0d3ZqVDhXbFlxSE56amI5?=
 =?utf-8?B?R3hXNHBuYjVtYUZOU0dmYkxwc0hrNklVMW9FNjhkL09DdlhmazYvRWNWZFZV?=
 =?utf-8?B?bGVZc0NxSG81b3k3UUppdWZrOHJrR3IxaXZPOXFtbG9BeHBnSUJ2WFpYQjZO?=
 =?utf-8?B?VVYrWjRPZVgzZFlFU3ZNUDI4SDF0TDJiUC9WdDV5bFp0L09TcmpIUlltSjVq?=
 =?utf-8?B?T25FbHhzd3RlOE42ckF2RU1KV0g0ZEo5cnU3UlFycUxkR3B4NjM3VmhxTTk3?=
 =?utf-8?B?eVJrQVptc3VWZzZ4RWtpakJUdE9DZk5tUEw0WEJFTmsycXNhcFBYNDB6YUUz?=
 =?utf-8?B?SW5tMkhaSVhUNCtlMnpMWW8yNkJGRGo2d0ZUMW1UNkxybk8wc3h6SmM2b1lh?=
 =?utf-8?B?ZnZBQXFxbEgzRTkwbkkxeHJrZ0sxNmRISnR0ZmlIZmdWcS9VUXE1ZEhWOFFN?=
 =?utf-8?B?bnVHOUF6a1pMQ0J6c29IT2dZMjVqU04rbW9kMGVadUNOSC9BMVlOdkpHNHFR?=
 =?utf-8?B?dURaNVgyRjRITWY4TTFCeWRwNFV6amFrc2VGTmpKdmVyNnFEeTZNUXlvYWty?=
 =?utf-8?B?TVRzS210U1U3L0RhRWR2eHVIczhLZzdGVTFPSDlvNHIzK1NKOXVaL3drNTZR?=
 =?utf-8?B?TitEait6NDVPMW5ac2pUYS90VzVBRGU0QkhiaytjSTNQZklqajZ2eGFlVDFh?=
 =?utf-8?B?NVpxa2dLaVhYa2JESnpEaXBXVWRncmtwOEg4Y2YyZ2lBOUFFUllsaGpsSEdr?=
 =?utf-8?B?bGkvOFNpZFhKd3NrYmladDh5NElkSDlPWDZodC9GOWtXSGJIb2E2REIwRExn?=
 =?utf-8?B?QWY5cXlqdnlvSm5RcU5PUzd6V29CY29MTWlBSW5FMkcxeWJOYjdYdEUwMUhw?=
 =?utf-8?B?MFFMWFJwWWM2TUY5ZFhqQU51ZU5sOEpEZW1jM21BbTQ3NnRrOFl1WWo4ZEtw?=
 =?utf-8?B?djNiS20yQVVNcXl3UlkyM3ZPcWdGOFkzTWg1S2hUZndzTDFnTVdPRm5KaW9k?=
 =?utf-8?B?Y1p3b2Z2VzhSSFVybkxRZ1RkMWhiZjY0ZzgvTDRFbFVjSFB4RDV1ZmQ0Wnpw?=
 =?utf-8?B?ZlZtRHNnYWtBazB4WU1QRGQzd0pTM2ErcGU2dVRVampFYVMwRjRsNGF3VnB6?=
 =?utf-8?B?RzJWOHUxallsdmVqVTYyUHBuclM1ZjZSSDBIQXlSVnp2ZlpIYTQ1bGs5TUlu?=
 =?utf-8?B?ZVdxTDVyOTVIM2ZEeFF3VW8wQTNnZVd4MjdMV1puYll2Y0VnSlNSOE9oU3NG?=
 =?utf-8?B?YUVYY2x2UCtPcWs5UEQvbGZTcGc0ckNHYXp2WHRVbEpUaU0vWWl4REp6cXRH?=
 =?utf-8?B?bUdPcStkMVgrVVFadVlQRzltcTJlUFpCK3NxSXR4STA1MzJzRTVBTEVhNUVN?=
 =?utf-8?B?YXd6ODhaYmpTWWFGTGJjdWFxdGVSMzRKT3o5OHo2b0c0dFJtdEppbFoxRFdD?=
 =?utf-8?B?dk91UG9lV0RJZ1NzdGQ0NFhPN1dmUXNKN3B1MHJRYXEvcnloWVlZTmhnMzY1?=
 =?utf-8?Q?DaJ9H6B0InRsarrtlshIIANOt7rzMwafAtB2VZM?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5040.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(376011)(1800799021)(366013);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?clloQVI5VndPVGJCTWZ3K2lUbHhhV28vaFpQRlIzcEt6Uk5QUmUvYzZnNWlC?=
 =?utf-8?B?MGg4VWpmdXBZSnNBejNaT3NmN1hMNDdVTWJkUFJXQnVwWWNmZEQ0UXVvQUl0?=
 =?utf-8?B?VU1YOFN6eUt2YXNFbkxjZWJZK3JPZC9XYzByOWt4SUlLbVd1UkhHd1JEZ3Y0?=
 =?utf-8?B?bjkyQ0lQcEpzMnZzaGkyMmNmbUozcHh0THU2RE5BbVYrSFd3MWh1VlJHRmdV?=
 =?utf-8?B?dm5tNXdrbG9qTDZpK1dCNC80T3diWFZCSlVjTEozR0x6bUNBc1RHTWxTeG1i?=
 =?utf-8?B?WElGRkMvbjRHRmlaZUZQU1JHNEpMR2J3MXJuQUZwSWhXSWk5OWtnWEV6Sjlu?=
 =?utf-8?B?WFBUUkVHVFVlUVk0eUFIYU0vWE1wazhYMnlJV0JoenkzZ0VPbGNOVnoyaG83?=
 =?utf-8?B?K1dyUHdCemF2Y3lvQUw5TnA0SGxlNE8ydVhBSU9vQWZ0NzJoME5YV0JBZ21N?=
 =?utf-8?B?SUJvanJLK01sc3MvSE8vRmU2NHR3TkVqUTNwclJvUGwwdE1tbWdtWC9MWHBU?=
 =?utf-8?B?S21LaSttMFFvQTE5T2cxd1ljSjdobHI5dlhEOU1MVHFxamhPVmZtb2RRaEky?=
 =?utf-8?B?SGMxenh2Vm5ad0VTWSt0bmxWdytQLzgyM2N1ZmtKOWF2NzJIRUJWRlIvMnhr?=
 =?utf-8?B?NEV3K1RLUHBIOFlzZTBCYy95cENtVElKazdxK2JFUHZ5VFAydFl3SE41YTk5?=
 =?utf-8?B?bFlKc0tlTXBaZGRkMTRCdTU4SmF0b2ZJWFRwLzAyK2JtSkFZVldVNk9SUDdQ?=
 =?utf-8?B?UVp1UnFiUy9wZEdLZExsbG93OWxsd3ZITTJsNUdMWUpJMk83Si9mRG1NN1Iy?=
 =?utf-8?B?RXMzWk9VRDI1dEdUMWlLTHd6WVppZHpSbW9TbzA4NHZzRzR2bGJrdU9mYy92?=
 =?utf-8?B?cTVzQUl6b1UrT2pIRWpWRHpseXhiaGtPKzlCSGNOK3dINmkzc2YrdzllUzFY?=
 =?utf-8?B?R3AzcXIvUldSSS9KYUFCVTJPQzlUaFhJVUdaUC9aTGlwaFpOZkRQUnYxZTlH?=
 =?utf-8?B?SFhzTCs2K1hmOTZNUkozMU1ZVU5hK3hhS0FleldQOTBobm9oa210RGVXaGJw?=
 =?utf-8?B?b255ZEJYeDhVcmhGWVNPY0dIczk4eWlxWG1vTHdBT1JaaUdZbFdtL055cUE5?=
 =?utf-8?B?akh1bGEvcHJOMGJRYkF2c0xaMkdSK1h0dWE4cy9XWEZNNnpxSkpkQzlBRHlh?=
 =?utf-8?B?Zyt5b2VuZUx5VUhZb1BwdEhaa01yaVpoNzlYZk1vdGhNRVdxbGo4aHVROEFY?=
 =?utf-8?B?NExEYytxRUN4MWZPdHFSdGZGd0hVQlB3bzJ1R3lYb3Z5bFdVem1zMzNsOUZs?=
 =?utf-8?B?RkplaEo3eSs5NmFIOWZZQzFIY202M0VPL3hMTGhZMGM3QXlDbEhZMXJGdHdE?=
 =?utf-8?B?aEFFdVI5dTg4Vlk5ZE9DTFZuck1kY3FLS1Y2VlMzNE9neStaK1hndnF2akJk?=
 =?utf-8?B?czNDMVRpUjJNUDZPa25DcXYxTWRnQTB3RlppOG9LZkFveE5UR1lkYzl2eVJP?=
 =?utf-8?B?TXN1dVZxMEdrLy9QZFZtOGpDZTlCb2JpZXVwbEdDZDJXUWkyMVoxRFdzR05l?=
 =?utf-8?B?Sy8yTXRpZVdKZ2hUUDh4Tlo4YUlqM1pQeTFRMGl2Y0pWVUk2UTNRRmdsVWY1?=
 =?utf-8?B?NUoydFlFdUlwK3hnbW5HMmhnWEdoUFVLZlllaTE3dzF1b0UvY25kT1pGdnJn?=
 =?utf-8?B?azh3c0hSRVVIRTJ0OFBQOHU5R0VYMUVyWWY3RndSR0JNaEh3MHU0OEdlc0Ny?=
 =?utf-8?B?Unp2NmxVbmhGcmRiQVJzRlV1RENCSEQxNkwyeENmT1Q3dGFYQTNPamVLc1lR?=
 =?utf-8?B?bmgrdlJTV0JtaFdDMmRuOTdrM1BoRUVSTFR0T1hQN1Q3Y3BtNFhiNng5Qlpj?=
 =?utf-8?B?NEN0S0lKQmYxMEZUUXFXOGFQMWxWVVdaZk9lUnJNb0E2NEw4eFVQZ3BHSUJr?=
 =?utf-8?B?T3VCUjZ5Z0tuWjFqcEUxSGRGMDVhOElyNWZzS1VhRnphWG82Z2pSa3hPS1VF?=
 =?utf-8?B?UnQ4M2JqLzFreUtGVzZBVXp1SzNXZUJJL0Vld0hDN0VJVnZSTG1lYWNnZUVn?=
 =?utf-8?B?aUl2QWFucFNtWlYwc0IzcW9kU3FadUlLdE0rNWsrMGs5a2ZTeFhZdVA1Z2h6?=
 =?utf-8?B?ckdzQzhyYXdaZVRIdUZnNXZqSDVVYUxuTXFPQlBmY0tuaVlJNHdNSkx3RXB1?=
 =?utf-8?B?bUE9PQ==?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 53e78302-6e35-4321-6430-08dc9050c8f6
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5040.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jun 2024 11:13:02.5600
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: n5LkBJOqgoQX3AL+rd+BHXzPcJS2MfF+UK/4CAaZbLZVrUvhB4viEdLYLfaUyHMQTf58MuXcB5HhvUXyOa+GeQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7947


On 19/06/2024 12:14, Sagi Grimberg wrote:
>
>
> On 18/06/2024 19:07, Bart Van Assche wrote:
>> On 6/17/24 5:10 PM, Max Gurtovoy wrote:
>>> +    if (wait_for_completion_timeout(&qp->srq_completion, 10 * HZ) > 
>>> 0) {
>
> I think this warrants a comment to why you stop after consuming 
> cq->cqe completions
> (i.e. shared completions).
>
There is a full explanation in the function documentation.


>>> +        while (polled != cq->cqe) {
>>> +            n = ib_process_cq_direct(cq, cq->cqe - polled);
>>> +            if (!n)
>>> +                return;
>>> +            polled += n;
>>> +        }
>>> +    }
>>
>> Why a hardcoded timeout (10 * HZ) instead of waiting forever?
>
> Agreed. Is there a scenario where the IB event is missed or something?

I can change it to (60 * HZ) instead.

I prefer not waiting forever and getting a stuck kernel if the 
underlying device is defected.


