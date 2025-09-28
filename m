Return-Path: <linux-rdma+bounces-13699-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BEE3ABA70C6
	for <lists+linux-rdma@lfdr.de>; Sun, 28 Sep 2025 15:18:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6F33D179748
	for <lists+linux-rdma@lfdr.de>; Sun, 28 Sep 2025 13:18:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CBDD2DEA64;
	Sun, 28 Sep 2025 13:18:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="VMNwt8S6"
X-Original-To: linux-rdma@vger.kernel.org
Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010014.outbound.protection.outlook.com [52.101.85.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91D2C280CD2;
	Sun, 28 Sep 2025 13:18:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759065486; cv=fail; b=TXD2CBQCI/nYECDZNMh5CDiNfH36EB2uBQPonXI+DfTeYiIOroRESer3FRFvYYOFb1L/FPT6UHfI6Exlmq+dUMmQdTpARwAcJLIP9BbsOgF5hpGuVqPSPXZStimoDtjeA63CeAX6KTIdjEHECZ5hIYXWKXX3pTURaGmARMc4/VQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759065486; c=relaxed/simple;
	bh=VUFS+DGIX1omqPEiHYtvQbxYqHtVogpZv7MdZNLfhqg=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=cAbJZSo3r2eeK+VkQUIlJOvXfvWJNr9ule0FeTC0VcTaDV1ECaEkDJkZqkSDUEGeaa9sQ8ybNf/rcd17SxIOnyW72IDaxgIBTnYyg093tyJodCtZSOxDab8xhcam22kq8C32xJhnhgp+FMiJLjo2cNfDg6yfsEkMgNIOKqyqgW8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=VMNwt8S6; arc=fail smtp.client-ip=52.101.85.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=arebLGmtJ0A7FWat7Y65t9AmnyUN5X/eU+/maEfIIAuMfcts6+8JGkgl86IfIIITpI1mcrH0K0t7xGRx/YcZG+ynQLGyQr4Xb5hrI9+897fVMqmhgmAvs0unnMshS1NoWYQ3c6ifqLvG+OY9WqYBdJRp3Nek3N+kP/vSWa0eaL1w+JFuvIvyLHd+iGIP7ZP79pXWPY/mfxcxudgF0Y3ez4GdE3dPowZKv+mBcUD23jU4xzOGE31l+FNwyCajK9SVqq0f1lvYCftUUozCRwM+TYbWQ2gKrOIEI0OYpsQVsKoW+/h/gaGWbn0j3JHWORA4mkWVxt43foyOxMw/3LxpVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X1gPDL7CSLnNAYvUobR3JSGrIqM7fsJWSB+SVv0kmOY=;
 b=KzOik+l5es2Iu1czgf6887yCfnERLcn4oFw8/rjObrjP/wMxGpLIxnDXs6xQjukNanMacl8QzlAZrY16B5krt7fE9d4epwmjY+PEENZOlPGm3Zu1aEGH8zEW0JSisI5+5JGkoGOvtH2mr3bgDbDagzZmQ411YJAjKcrhPZH3gyVQHEDm5UEY79bzNZ+fMvjZUqewVJ7Tcyqhbbos3rcE3hhUXRWXD1QJ91mGGpMf2y2/5pIoMOvFxDZCcSog8CcS+W3uOwtvk165QZuFG8bzjbA/Aizd01QTJDzdXZQld5jvjWUOjgayb2zhUwZJXtvCRb5QZ2GiN7CE3bExdAM3Fg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X1gPDL7CSLnNAYvUobR3JSGrIqM7fsJWSB+SVv0kmOY=;
 b=VMNwt8S63M2ucybqUIupEJ8sAPQinHlogGF3+QVcN1jfQ29h398tIZz+DjRxpCVG9nStCniFsuZMU6bTfuiwBk3dOovAqdIbJ93ZkMcDxE9FLVLF3qBdvGRxzDYGRDMqwiC3gq1abGYei/unBAePlZOpNopni4Q8ybZE+0W4oejX1F11Bcfl9pgdLdphR5utX3hwwXOJ7OBzF+0yBFOFmeWIRrx7LVMC/xKhvpZxUsT5jypHdutDNpLDLg1v3mUfiRwk/cHqSJhFUleJCWxlan5gkKz97cQlJ1ZIfk3vRqRqn+DODT83l2fIzihC6Rr+kLTz8E4ztWFo8a/xfdg/yA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB7500.namprd12.prod.outlook.com (2603:10b6:610:148::17)
 by LV3PR12MB9166.namprd12.prod.outlook.com (2603:10b6:408:19c::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.16; Sun, 28 Sep
 2025 13:18:00 +0000
Received: from CH3PR12MB7500.namprd12.prod.outlook.com
 ([fe80::7470:5626:d269:2bf2]) by CH3PR12MB7500.namprd12.prod.outlook.com
 ([fe80::7470:5626:d269:2bf2%4]) with mapi id 15.20.9160.015; Sun, 28 Sep 2025
 13:18:00 +0000
Message-ID: <6b2eb2c2-15e7-49b4-aaca-6fd58af9ec6c@nvidia.com>
Date: Sun, 28 Sep 2025 16:17:53 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [cocci] [PATCH net-next 1/2] scripts/coccinelle: Find PTR_ERR()
 to %pe candidates
To: Julia Lawall <julia.lawall@inria.fr>
Cc: Markus Elfring <Markus.Elfring@web.de>, Tariq Toukan <tariqt@nvidia.com>,
 cocci@inria.fr, Alexei Lazar <alazar@nvidia.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
 netdev@vger.kernel.org, linux-rdma@vger.kernel.org,
 Leon Romanovsky <leon@kernel.org>, Mark Bloch <mbloch@nvidia.com>,
 Nicolas Palix <nicolas.palix@imag.fr>,
 Richard Cochran <richardcochran@gmail.com>,
 Saeed Mahameed <saeedm@nvidia.com>
References: <1758192227-701925-1-git-send-email-tariqt@nvidia.com>
 <1758192227-701925-2-git-send-email-tariqt@nvidia.com>
 <48a8dbb8-adf1-475e-897d-7369e2c3f6eb@web.de>
 <48228618-083b-4cdb-b7df-aa9b7ff0ce92@nvidia.com>
 <7522bdc8-1379-d516-d1fd-f7835453f23@inria.fr>
From: Gal Pressman <gal@nvidia.com>
Content-Language: en-US
In-Reply-To: <7522bdc8-1379-d516-d1fd-f7835453f23@inria.fr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: TLZP290CA0007.ISRP290.PROD.OUTLOOK.COM (2603:1096:950:9::7)
 To CH3PR12MB7500.namprd12.prod.outlook.com (2603:10b6:610:148::17)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB7500:EE_|LV3PR12MB9166:EE_
X-MS-Office365-Filtering-Correlation-Id: a00536ac-428e-4a65-1163-08ddfe91723c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NW84WFBpKyt1KytCd2U0VDBKRHhVUXR3RUp3TmU0ZDI1OU42QTBRWUdHdVVB?=
 =?utf-8?B?UTJQM2ZDK3FaQVNIbTJCbWJIY3JTV1dxa2ZjR2JDR2VvOVlxcnBLMS9YZy9j?=
 =?utf-8?B?Sm1yQ3ZtOXFlU08yMWZDNTlMaTBqYzR0NGN1cDErWVBHMmtIWHkxeEo5NFJS?=
 =?utf-8?B?L3Y4ZDROdmRFblNoSzdzWm1Dc1VBTGNMdWZ0aklGSm5ValpzQ09Lc29LRXdC?=
 =?utf-8?B?MGN1OFpSM3R4bWFQK0NNYjVUcVdSdEcyRnlnV0ZWNDYxVkdXL2R4OFBPb2dn?=
 =?utf-8?B?dXFtTG55Y25sTC84eEk3NGdhR29tREova3dKRzNsNzlRYUxUa0FEL2Z6ZjQv?=
 =?utf-8?B?Q2F2Q0RZMlFQNjlKdC9QTnVXckNOQXYyRTJZZmc3Y0c3K0dlVHRtaXdRY1lZ?=
 =?utf-8?B?dURoZnZhT2FCY1A2dVpxZmxobkZ6anQ2dlFiczEzZWtrNTliUVNia1M2ZzJY?=
 =?utf-8?B?ekg4cHRudURudkRMRHJNM3EvUUtwU09BZ3hQWXIvVVJGSjI4am1QT1JIampD?=
 =?utf-8?B?WS9ObURQOVIxSHRuL3gzSUhKR3hhakRaNS85eGdSTG54blJnNnZvb2NJNnBy?=
 =?utf-8?B?bXIrUUZuREFMcTI5TVpleXdGMXdFYnp4S3drMGE5bjJuRHFNNzFkRFNLL1o4?=
 =?utf-8?B?L29oRkhCeUQ5ZjRYVkduNzFnRjRkL3VCaThZVUlmS00ra2pDaU5DVTdXTzFW?=
 =?utf-8?B?aUpsRTVpOVBoUjljcnVKZXl6a3R2UlZYSHBwQ3dJckJOdmtLa3BpVUcvV21V?=
 =?utf-8?B?Qm5pcjhFU05IMXBtRVlOSVVwWXUwaTVlek5vNHlaMEUrMVcweStkOEF0T2hs?=
 =?utf-8?B?d1VIM2RqbDY5YjVjMmczeGNXUGFQZWNwWjVvOTYvZit1TTlveU5aVUZSYnZW?=
 =?utf-8?B?S2J6Vm5YU1JzeWxadHR3Tkw4ak5qd3ZUM3o1RGVCYTB2bWRNRlVPL05rN2Ns?=
 =?utf-8?B?MEtETnpxVDVhcVZRUnBhZUtSNnU4NlZlR1RUZENGTUpGc3BHVTMrWlpZMmhG?=
 =?utf-8?B?OTVEcGJHcGM3QlU4UFZ5RGU2Y0FpL3Y0RDRsSjIwSlpjMjRvbG80dlpHQzVB?=
 =?utf-8?B?R1VMdXF5S3NGTE1tejVCclpsQlpNeU1rWTJOcGZYSWNHczlWUytCbzhnR29M?=
 =?utf-8?B?MDNHclhqMEZBWXdEaFBxQnN6dWUxOE5FQlM3Z3A2NG03aktvb3VTOEtjS1lX?=
 =?utf-8?B?RVMyR1g5b3N0L2UxWnB6RXhyTFdNRGZkWWZkVmNDcXNTdGM4NWVYVFhaMjMy?=
 =?utf-8?B?WThqbkgvMWt2allrS1Z6UlpLcG5LSXp0eWhIbkZvbVlUNUc5WG5zSE4ybFZ6?=
 =?utf-8?B?RnZ2MmJTdEwwVHhjR2VEUnNXaExaRE5BeXJMOFBrVWd2b1AzeEJGdURwNHMx?=
 =?utf-8?B?WU13aitzUEJqRUtmbmVmSzR2cjlFbnY4c3l4MFRQYlpwR3JYVzFCeTh5VVBG?=
 =?utf-8?B?OTRMd1ZQaHhUNTlUWUxXM1d2V2dreTdkMHdmdGljN2E5RUpoZzBoMUdXL0JX?=
 =?utf-8?B?UUN5V1Rib0VuN08yNHV3WFlNWWZQOFBuQVUwYkNPTFdjYzloZmRCcERGZ05m?=
 =?utf-8?B?d2VXZ2tyVCt6M01sTnE3blBFNGhySDR6WDNlclRRbFYyeXpyS0c5RzVsOFlE?=
 =?utf-8?B?YjJIN0d5TCtKZk9QVVZ2ZWl2U0N0QzlHSjJaekZURmNBaUlGYU4vR2dXbmZI?=
 =?utf-8?B?RWx4VmFoRGNiWEhqNCtnVXlMaGlCY2RxaE5tVEJXNTYrTFV5R3pDOWcxWWIv?=
 =?utf-8?B?bkNjUDBiRXhTRzdXN1hLRXk4S1ZFY00yT1NqMGRPL2t1OFhjQ2tRNk9lR0li?=
 =?utf-8?B?ajUxTlA3WUx1WmgxMDZDekhITkRtcVd2NFE2eDI4akVSZ245d2NKc0VDaEFM?=
 =?utf-8?B?QUhtWTRWU2NiWG0zUmluVmJ1YzdENTBuUlRXTmJGM0tHbjVUN0NoVjNkU3hI?=
 =?utf-8?Q?3DTpwAjjprO/w858eaxxMoC0jjL8Eev0?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB7500.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RkYwZ1VhRGxOTk9HL2E5WWZtaWx5Lyt3V0NjRk9uUlFvdWkvQ2lqM252SG5q?=
 =?utf-8?B?bCtMYUxVVEZ4aXZQeDRzY1pTRkFHaFl1RVFkOGJZZUIzWk1oNnAyQ05ZSFhz?=
 =?utf-8?B?TjJwMzF6QU1RcVM5OWtnZ25UNXJqUjE3M0xwWXFod3U0eUNyLzlINlRXYXBX?=
 =?utf-8?B?a21udTlrUjBhZjB3cnk2bkkxdC8reDJCMmlLbEQrYkdoblV0M2FmVmdlY3Er?=
 =?utf-8?B?S2tOUXZCdFJHbjBOYWNLbnE4VFlTVWVZeVRJY3VnY1BtSmtleS9tZUdsK0NB?=
 =?utf-8?B?aC91Y2ZkeDlVMnZ0eWpQMDN5VTdsZ2RCdHlFcE9pT3MxME05ZzN2eGV5MXhM?=
 =?utf-8?B?K21OdXMrd1VvNFdSbSs1WmMzaGdWT1ZoK0VJWk1kK3lBWk1uWUR3bVJvUjd2?=
 =?utf-8?B?azArMDBaSnVmS0FTcTZQR3ZmTW84aWVGTVZ2QWlDRk1oMHBmbXdzRWhLU0hL?=
 =?utf-8?B?LzhXWVBFSGx6UGZLK2NFYjR4T0Q3UVdwcnp1QzBMaC9QaUdERGFkbWh2Qmlz?=
 =?utf-8?B?K2U2bTRkN0RZMitMcjhQdWYxR2ViY1kveGI4RncvV2xUWm9sYldUV1FESnlM?=
 =?utf-8?B?bGZqdkxMUVI3ZStrZTZWdms0NkRyRE9UcDhZNEN3Rzc0NnVjSkFUTW5IZitK?=
 =?utf-8?B?NExDUURDK2VCeng1enR6WnIzN3pBRVplVmEyUkw0b1l2TGdFTWlqQzIvMlp6?=
 =?utf-8?B?dkFIQ3dzc1JzWm9QbnBIS3FLK205aEJucFhpNkRRZGNUazhtcUN0elRkSjd6?=
 =?utf-8?B?RVZYTVRFcFRxQk1PbkYzRXJQSENhc1lpayt4aGNHM0tlT1NTMHJpcEdSQm04?=
 =?utf-8?B?cm9zVUFsZ0tsUFBhRHlMR2V1akZNLzVGZGFSOC9HY202S3BYWHg0S296UUJO?=
 =?utf-8?B?ZllsSjh6RmN1aXVBNnphaldZdUJtZjdGZUsvd1F1cjRtdE1CR0tleWgrUk9F?=
 =?utf-8?B?MDNhSkFRZzdYSFRHY0dJdnBlenplM01pSDF2ZnpXMTRtdC9FakxnQUJMLzJW?=
 =?utf-8?B?VCtnc1dVeXZNOEp4UWtnc1EvakhSUE1xVU9VTEdDRmU2aXVzRlp2bnB4c2VF?=
 =?utf-8?B?SUtNMFh4cTgxaUEyRzhPMHlnWmtoYzZWWkd2Z3IrVy9wSVMxaHlUK2xUdmQv?=
 =?utf-8?B?WndvdHdTQ0Q2V3BqOEd2S1dybGFsNDZpaEorWGhLdk1iakVsK21sL0xrdVRz?=
 =?utf-8?B?RWtpcUNySlhoSmd3ODVDemZUaGx6Z3pLampXQWdtdXNmbmlXZ1ltTjl0YUl6?=
 =?utf-8?B?cVRsVGZ6eTJyTWlhN1ZBaGxSMHpsR3VsWFU2a01zWDA5UlBqcWtVdU1XY08y?=
 =?utf-8?B?WS84akl4cCtkYzgvVXFCKzdIS2xRTFNGaGJQRlBvTGdWaFVGVEl4SjNYYmJB?=
 =?utf-8?B?NU1QQ0ZzSk00cWEzVVVKNmk3dkZmS0o1U2YyVWFZOENRWit4QlNDZTN6NlUr?=
 =?utf-8?B?cGJydkJaT2FZU1Bja0pYZitIK0wvenJuYmM5d1ljTHFKM2RUMjk3RjFuMXl4?=
 =?utf-8?B?TzJwQnZXd2VQQ2tTUE9BaWpjRTQ3WG02L2F5dHZrYXVVVk1LZDRrVE12Tm93?=
 =?utf-8?B?Qk9ZaGducTRuajNKNThlOXVMVkZPdXFSellKekhGbFV3MHcvNTVHOGdRQXJk?=
 =?utf-8?B?cmhrVm1XK1VsTDJKQ1dPRGFRR0hkd0Jxckpsc0J1U2tUalpyRFpxdHlrU0xj?=
 =?utf-8?B?RXU2YkJDMnphazhzaS9jcTJ5VHhsc1ViT01PV3VBR0ZWeU1rOTlOSTBqSVJC?=
 =?utf-8?B?UWIvaFNnQ3lTYXcrcksyMGxUR3JXaFdyZ0Fxemt5eTRQOHVXb2tibEF1L1BF?=
 =?utf-8?B?aUlLNG9jS29tYXJYaTZSd0VSNUhGUEU4amlscWkrdWV2dzBWQkdIRTZCd1o2?=
 =?utf-8?B?a2tRUGNLT0Fqd2hCSEcxT3R3UlIrbHdBbXVVVUc3N09PaFVIcUN3Y043Q1FL?=
 =?utf-8?B?cDVQYlZVWDRLb0lROVhjUlpMVUpPQVpOZFM3VFlXNlZ5Mm50MXBVWEhtL1pa?=
 =?utf-8?B?OGJjU2E2d1EyZUlTSkcxYmlwemZMSVhjSTA4RnBQeFdvSnUrT3JveG10UGtq?=
 =?utf-8?B?QlNZVFRlNXd1Q3Q5bkYrRThSQzdsQzQydlVrWGtjczJPMFJwVkxMYk9hbmRJ?=
 =?utf-8?Q?iSGlQyeTGEFaTV01CzFmH8mP2?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a00536ac-428e-4a65-1163-08ddfe91723c
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB7500.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2025 13:17:59.9773
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5u8B7G/nJc7u9NGISNp2I/1ybAct3YcCZ60Ue+SRNEBR5bjWzN+yA1nQ7tp3XndT
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9166

Thanks for the review Julia!

On 28/09/2025 15:23, Julia Lawall wrote:
>>>> +@r@
>>>> +expression ptr;
>>>> +constant fmt;
>>>> +position p;
>>>> +identifier print_func;
>>>> +@@
>>>> +* print_func(..., fmt, ..., PTR_ERR@p(ptr), ...)
>>>
>>> How do you think about to use the metavariable type “format list”?
>>
>> I did find "format list" in the documentation, but spatch fails when I
>> try to use it.
> 
> I would suggest constant char[] fmt.

That works, thanks!

> 
> format is for the case where you want to specify something about the %d
> %s, etc in the string.
> 
>>> Would it matter to restrict expressions to pointer expressions?
>>
>> I tried changing 'expression ptr;' -> 'expression *ptr;', but then it
>> didn't find anything. Am I doing it wrong?
> 
> expression *ptr should be a valid metavariable declaration.  But
> Coccinelle needs to have enough information to know that something is a
> pointer.  If you have code like a->b and you don't have the definition of
> the structure type of a, then it won't know the type of a->b.  More
> information about types is available if you use options like
> --recursive-includes, but then treatment of every C file will entail
> parsing lots of header files, which could make things very slow.  So you
> have to consider whether the information that the thing is a pointer is
> really necessary to what you are trying to do.

Makes sense, indeed the pointer is embedded in another struct.

I'll keep it as is, if the code calls PTR_ERR() on something that is not
a pointer it has bigger problems than using %pe.

> 
>>>> +@script:python depends on r && org@
>>>
>>> I guess that such an SmPL dependency specification can be simplified a bit.
>>
>> You mean drop the depends on r?
>>
>>>
>>>
>>>> +p << r.p;
> 
> Since you have r.p, the rule will only be applied if r has succeeded and
> furthermore if p has a value.  So depends on r is not necessary.

Got it.

