Return-Path: <linux-rdma+bounces-11720-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B4B3AAEB472
	for <lists+linux-rdma@lfdr.de>; Fri, 27 Jun 2025 12:24:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C69977BACEA
	for <lists+linux-rdma@lfdr.de>; Fri, 27 Jun 2025 10:18:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D56FA29898C;
	Fri, 27 Jun 2025 10:18:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="2epT9zVq"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2042.outbound.protection.outlook.com [40.107.94.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F90429DB8F;
	Fri, 27 Jun 2025 10:18:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751019514; cv=fail; b=pApuWzZFIsYWSbv+XpolLZneCUK8Lb71Dgg368iRo0iwzE9rpKxa/+VHhse40NiV0E4rp1buRIzVjQ13DTIQxcqIlO8KZHaYFEmuTb/Lcphga2bD3hj/My0MHWyJU89DsPCwwPBYLTzvdvG7U5h4mDudOlAZSMizXE35twOF3G0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751019514; c=relaxed/simple;
	bh=dW+s99R2Pu04Y8Cpm7EpFsRn9/pAgqeKuxmpY0t+Td4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Jx+j4V89bzCIsGVoaLf3L8y94gU5KPLhPIXxsSs+ubNjwtJCXALIVA1nSa2ychYVZgy1L0c7cy4jdblvI8xQIi6Y5Ul4LoxjJ9GbziDeW/gaD/6hT8+Kj+jbormoROKqRdcK9hbCsfz3FECl7GGyymJXadv333il3P8JdSsWEw0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=2epT9zVq; arc=fail smtp.client-ip=40.107.94.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kBYLPweJLslVjQ1vsUxAhgo6Njd2g5Y6gxYL/mF2oYP7lcdfGdzsewcwR+koyEayIyIwbPbVLn2yyryuYs/n0+OiomRmLk05XukfiowhmHZIAJNeU0dr7oqm1iiJguWfiC6rTBORO/Eq9S61gmBtFIcMJU89IPYKO5ZJhH2TILzf7mf2Z4CcgdouVPxvqiw3T0SX09wVdMwXx4xhJ/ILXC50s6TGeWaPgxjwKi/TlNRKFGHqOHJMN7X6h/5DGOelHTNGaqnC2x42lenXmbrCI+Xyz+StD3eunoLNPohnKqOYkggSNLsiRR3v50s/pd3u+ijt7+Oz0+C9L2mesiePFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8seV4XEqi80Yf5Gg3IMajAutQT1j1h1IGQEQ+RsRicE=;
 b=sn6skCDdMHEe275cOVI5EyUCGc4Dv6LT/yiF5xmsuSYnHPr61CO9e9QdzmVrzs4solJ8lolqd1Lb+pBd0drRQv0sIs16I79pFj+qvNs437UrBKn5mdkIzMQv4lmaa09R1BG03+s49r4mvnzOox7rw0+HQRHaVj3ryAp8ZJUopZOQAdHIKfJ+A4yL0qwGruLXU0Ro0iuyuFVbByrgvoUJT1pMCBhCa0mDRfpt5YIuC4Fie8uuQhSH7p2/pPWKym7/6rqeKUD/3nmy88GA6X3uOqh/SszIYrvgZWaZYq/1aLgI6ABsDL/1JkAGSulq5JlQTXkSyZiihgHcJ1KjIiMdPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8seV4XEqi80Yf5Gg3IMajAutQT1j1h1IGQEQ+RsRicE=;
 b=2epT9zVqGQKjNdKjtnAPoRBYRSIex8GxyYXH4qSkpsflVAYN4Pk7ghWOg95wfEHUIxvdefmcS52PXbhjXHn930W/L86xyA3xLTsPMJ2eiOpJMnXgNlY7dQ68rXhjMD1Sa/TkDS9lm/QxmyhH9aLbNVGU3XgZ+pnkQxSIlsq+Fvw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB9066.namprd12.prod.outlook.com (2603:10b6:510:1f6::5)
 by DM4PR12MB9733.namprd12.prod.outlook.com (2603:10b6:8:225::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.20; Fri, 27 Jun
 2025 10:18:29 +0000
Received: from PH7PR12MB9066.namprd12.prod.outlook.com
 ([fe80::954d:ca3a:4eac:213f]) by PH7PR12MB9066.namprd12.prod.outlook.com
 ([fe80::954d:ca3a:4eac:213f%7]) with mapi id 15.20.8880.015; Fri, 27 Jun 2025
 10:18:29 +0000
Message-ID: <f0050f1b-67f9-8a72-9365-2451a6f360ff@amd.com>
Date: Fri, 27 Jun 2025 15:48:18 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH v3 08/14] RDMA/ionic: Register auxiliary module for ionic
 ethernet adapter
Content-Language: en-US
To: Leon Romanovsky <leon@kernel.org>
Cc: shannon.nelson@amd.com, brett.creeley@amd.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, corbet@lwn.net,
 jgg@ziepe.ca, andrew+netdev@lunn.ch, allen.hubbe@amd.com,
 nikhil.agarwal@amd.com, linux-rdma@vger.kernel.org, netdev@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 Andrew Boyer <andrew.boyer@amd.com>
References: <20250624121315.739049-1-abhijit.gangurde@amd.com>
 <20250624121315.739049-9-abhijit.gangurde@amd.com>
 <20250626072653.GI17401@unreal>
From: Abhijit Gangurde <abhijit.gangurde@amd.com>
In-Reply-To: <20250626072653.GI17401@unreal>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN4P287CA0128.INDP287.PROD.OUTLOOK.COM
 (2603:1096:c01:2b1::6) To PH7PR12MB9066.namprd12.prod.outlook.com
 (2603:10b6:510:1f6::5)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB9066:EE_|DM4PR12MB9733:EE_
X-MS-Office365-Filtering-Correlation-Id: 8721eca9-4c92-4649-3f31-08ddb563f5d2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VHNxRTVZRlpDZk1TbnlrQ2lFOUd2aVk5cWljWThQcklsT1NTYmdaSm5kNGxl?=
 =?utf-8?B?eW8yT2szVDgrZS9yd09raG5jMUt5cG12bEhKK1o4K1ZaSmFDd0wwQnZnaG1t?=
 =?utf-8?B?THlBMDJYb0ZJT2pTR0NUTjBjTXFiWDQrZEJYOTBhL1laS1c2NUdhWlc1ZEdV?=
 =?utf-8?B?eWFXc0wvc3YrZHpISlhvU21GcndiaWdTZ2xBeEExOVhsd1VhRy9Icm0rZmpr?=
 =?utf-8?B?NDZDaEE5VDZ4ckVLcjR2eVI5MGhRYWNjbkhteFUvUmVkTVRjNkdFTWo0Zy9n?=
 =?utf-8?B?ckZtbUc2YnYyY3I1MW85QitVMEltSnJOYTNqRVlXQXpFRlNaZkUwcStrWDVI?=
 =?utf-8?B?TEdEVE5DMlBNQzVmd2hwVDBpdXNwdWllWVVNRVBpNmMyTEUxTUVPZ3ROZTdi?=
 =?utf-8?B?SHMwTUdVdmxKM05WZ2NIWXJ6Z1lJVGQ2cXRXYzNLS3ZFZHR6dkpBOWNNdTBp?=
 =?utf-8?B?eU00cXUwb3dkd1hUQUxnTVBKNU1aYnFXbVdtUlZ2blY1dnVCeXZzRHZFQXhW?=
 =?utf-8?B?NW8wM1lrSlhsR29hWnVESzVVbDhFRzVIVWZ3bzJFbHQ5RkRLeWJzbVVRY0ta?=
 =?utf-8?B?dkI2Z3BDTDFJVSt6emtHM0QrNUhYMVI3UHV4c21lbkFZK1l0YmlXNzdGa0ty?=
 =?utf-8?B?OXdhZWJnYWNWYlpTeDBJb1ZMZzlHVVE2S1hDMTRzNnlmWDc0OEVob1VDNmda?=
 =?utf-8?B?dEV4YWMwbE01eE5TMnN3UjdOUnh5WGpFT2JNS3lzVG5oM25GaXN0ZXhjVjBC?=
 =?utf-8?B?N3BnallJS1JRb0FKQUEra0t1dTVlT3U1b3l6TE9oaE1BbUI1SmhFemZLbmdq?=
 =?utf-8?B?dUxMbTJGMXphUlFLS0VFZmNZTmdyYTYxa0dhNll1U3lwNWROZDNPZXRlSmk5?=
 =?utf-8?B?WngrUUQwdktQb1NnbDd5VFRHeC9RUEVkVG4yRjNqSHdJeElQSmdVcmhIeWZR?=
 =?utf-8?B?OUZkczQyNVZ3dHpqWFBCcCt4OUJZcGh0WUNuRmdFeWVDS094YTFZVDd0c0o2?=
 =?utf-8?B?R0QyZEJ3ZEJCZ0NTZCt5RTVZTnlNMkZVREpPM2hDL0xHRnVzMFhjNnBVbEpt?=
 =?utf-8?B?aUpzMkVjU3pYY3BCVjZNSTBYL0Vwek8vWENyY1ZIZCtNdVJZNWw2bUJjSitW?=
 =?utf-8?B?SjJpaHU3VkhwRTU5QytxKzkzYzVTY2NERVF4OEt6V2I5SnZjbXJQbnQ3d2w4?=
 =?utf-8?B?eWVsVW84WnVxdCtNaEJ2cU1GYXBzVG92dThYZGZxOUxaeHBleG9WeFNJcmQ0?=
 =?utf-8?B?NmhFVExwSDVsb01xSUZzZnR3d01NQjUvZ2lZdkkyR1JTeTZteWJFWndsSXRN?=
 =?utf-8?B?dzcxa01NZEdFMW9YS3JDSTB2dzJmdWtxK2ZjZm1wUWEva25pWmozb0IwV05j?=
 =?utf-8?B?STMwSFN3N3pqUEt6NkZkZ1B2aGxXaGs5UVZDUGlxdmlacldhU2dqREhZWElK?=
 =?utf-8?B?WFNUeEd0Zng5UW9nenYwYTlteEZQUjZvOTZ1NFg0RGNnNitYRW9hQSsyNG5s?=
 =?utf-8?B?Z0tRRTBGdGExcGhXMmdsc0FJeDJwdUdvc2dsUHA2N01GQ0R3V3A4bGhsVVp6?=
 =?utf-8?B?VHIyTXNxYTlIdy84QzQrd1lhb2o2MHFnNlNJOGlrZ1ZCeno0SGFDUDQwd29h?=
 =?utf-8?B?N2xzRERKd0FDb3VHRFZlczhWSFNPTmtUMHRtSVFzSFA4a2E0WmdFRU9xQjhn?=
 =?utf-8?B?M05KVytYRlpLeDI5T3FTRHpRcUc5aEJJRnovck1FcUJCK0RVTjlDS21HN0I1?=
 =?utf-8?B?VTVlRU94R1RQOXRZRHhHMkltR3NVak5lSFdnaElXRmNkSjh1Wk41akc1VXFy?=
 =?utf-8?B?bWVoMkFsbHhCcGxmclp6eHdFVlF4OUthaXVjRkJCcWdNNENNSnVTckRhdzdo?=
 =?utf-8?B?K3Y0VHBQWjlnd0VJaWVkVTRGTjQ4cjNlaG42VXViOENSa3I2RC9oKzNHK3pB?=
 =?utf-8?Q?FcsxpQODVQ4=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB9066.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NmdJSEVjNk5QOVNtWjVGcEpZc1RQdzkvTDFoS1B3eHdNMjkzQW9JbWZIU01D?=
 =?utf-8?B?K0hJRzhrQjh5NTVBeTJDVVZCbis4SS9qSTZPaEd0aEVrUnFLMmRhYkdiRUc4?=
 =?utf-8?B?L0tLcFVLK3hVWU95cHNaVEZ2SXh1SFZEc3hzRnVDdFBoOG40Q3c0aUNiSmh2?=
 =?utf-8?B?cGhYZ25NSGJ5cXRUR0NTbHRRQlJzSm5ZbGFCTEJ6K3ZUTjc0cGpRS2lpR21v?=
 =?utf-8?B?eEk1NXlIY2tKV0p0N2tRSTU2UWp1aXpDT2lIdGJzSzlrTis5WFNQQ2xZT0to?=
 =?utf-8?B?U1BVeHZGZ1Q3dlgxS3RjakZ4TEdnR21ITjNsUFVKZDZLU2duU1hwaG9qYi9z?=
 =?utf-8?B?UHQxTVVUb2NBamN3Q3hyRWVoTThNZzAzYTNNbzhVWlgvTGIyRVRCeDhUTnk1?=
 =?utf-8?B?NWpIUjBSS29hOFBlRWRYODUwdGkzSTlVWURUZ1VEcjE4OC8wdWNwSkVZTDIz?=
 =?utf-8?B?RVNHTFM5azNML2lMMWhjbXdsMVhiekxXVk5UeSs4dWNEWTZHTjFBN0h4ekJT?=
 =?utf-8?B?Z1lxNXdiNlRURk4wU3AvemFVZStkbTkwa1dnVnc2Wm5kZURGeW1DNUVHWmpK?=
 =?utf-8?B?S2F4eHBzTHB4Uy9yRlEwV2IvRDF1a282TS9ueVNOeUF4UFh5RDRIdTVOT1RO?=
 =?utf-8?B?OHkvRHhDcVNzOFZlcTUzUXpXQkl1cHc3MGhLNWNBaE9HWis2VGFRVElTK2FE?=
 =?utf-8?B?SVV2K1Z1ZjlIQUF4WFZ5NW13VjViVTg1N1luRVhmL1kvdmpmZ3JSdi9pMjNU?=
 =?utf-8?B?MFpNbzZNa0YxQXJ2Qm1DZWk4SlhlZmxkRGlSUXZSbjNNZkE2V3E0YjFwK2ZI?=
 =?utf-8?B?aThPU2JpZVBsUTc3UWFwSDVyV1Y4MXhKcmpzSU5iM0lkR2tCOXpHY1ZDTXJY?=
 =?utf-8?B?QzlIK2NCWUlPVDg5cldPSTljbzlCay9zUlNMdys0UDN4aHp0OVlCVFo1ZUxk?=
 =?utf-8?B?Q3pyYUw5TTlSRW1TUjlHaW1pVElhQTZEVjkzVHN5NzlKU1pXVmR0Nm83a29K?=
 =?utf-8?B?TTVFZFBvU0ZHTFJyQkRtVWxHWTN2T29BbVNKNDJ1YStRTm8vUnRLY1dtWEZ2?=
 =?utf-8?B?a29LblRyRHBEMDdiWDBZdGJucjdaMmUxc1J2Q1BCTTVsYTlUSWZWTmh0blZ2?=
 =?utf-8?B?cnV1NFBUbXBPUTZpUFdWb1ZUaExEZkIxTDg4eDIwUW85SUE0M0FQUG9KTEVz?=
 =?utf-8?B?WDdZdSt1ZjlLRDVibEFDQktFZndRcHl4Z1o0MlNzYkluYXpHUXNPVXVpS0Zo?=
 =?utf-8?B?NlFZMW51UFFvWTVaekpGa1JqNVI4ZXlvdFFjQ0hkUXUrZHZOMmptMTVKb1NW?=
 =?utf-8?B?ekszZnVwQ3NDT1Mrc2dLVkZJbWVKM08ybnhEcHBzK3pkVE9tc0piRTc3dSsx?=
 =?utf-8?B?TkdiQ3FLU281ZUQ1Z3liNEtxRjFWbm1iUUtOMENvcEhWNlpSWGhESlhjODRM?=
 =?utf-8?B?bDNVSUdWMGR6TVNoelFjYmF0U1FxU3RSVHUwLzVVamhUcFBybiszdWN3R3do?=
 =?utf-8?B?ckVQQjhyem8wUS9hRm5mZHZ5d25jMGI5QkxMOTdRV05BQXFyRXJjZ3V3ejVL?=
 =?utf-8?B?bHQ1TUtQckN5aXBER2phSmVMTWlvZ3ZGTlVxdlFHczZtSVVNaHlUdy82UEho?=
 =?utf-8?B?TVBCL0MvMWpRdGp4c3FYcmtZZDdkR3JYdDIyMGZySHhtNFY4eWpqMDU5em5Y?=
 =?utf-8?B?bGY4eDEyUlZUQVRFWnYxSUtLbjIvb1B1WTgyUnYwaC9QbEFVMzFDQ3kyM25w?=
 =?utf-8?B?Wnh3VC93Q3l2SjhScTVub2FyZmpqbW9yekxZaThtY0dUWlJ2THZMa1VWMSsz?=
 =?utf-8?B?WWxNNmxDdDBkemJYL2x2VmEwWGM2WjJTY1N2T3pWMFFXTGRpcjA3SGJlZjlV?=
 =?utf-8?B?WFFpcEZJQ3RJZHZzTFdqVVZPV0ViQW9HUFBtcFJkZUdEcGhnc0NRV1BJNERJ?=
 =?utf-8?B?MUV5eXlYVW43M3ZzdFRoOW1OMS9pTUI5a0pOYlpRQXRTZ0REYm9PSWlsbUdy?=
 =?utf-8?B?YUJpb2FWOVpmRnMvN0lKbzJNeXArN3M2Y3BuclpGZzdwUm9DK0dIVVFLU1Zu?=
 =?utf-8?B?V3R0RUt0ZCtzUkdhbG9pWlNSbzFKVHl6RzgzckxHd2dHTS9jMFE1aWoxc2FD?=
 =?utf-8?Q?tXb21Lwx2yJirBAbLdxgyEaQt?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8721eca9-4c92-4649-3f31-08ddb563f5d2
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB9066.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2025 10:18:29.0187
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gXxY4ywlNzgwXJmwc5TaklLl27pQ0q19mBuaw83q3sUVMZefiy5b7XKDusT60VLyb15uHGLicWkgqj2wM47CPA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB9733

On 6/26/25 12:56, Leon Romanovsky wrote:
> On Tue, Jun 24, 2025 at 05:43:09PM +0530, Abhijit Gangurde wrote:
>> Register auxiliary module to create ibdevice for ionic
>> ethernet adapter.
>>
>> Co-developed-by: Andrew Boyer <andrew.boyer@amd.com>
>> Signed-off-by: Andrew Boyer <andrew.boyer@amd.com>
>> Co-developed-by: Allen Hubbe <allen.hubbe@amd.com>
>> Signed-off-by: Allen Hubbe <allen.hubbe@amd.com>
>> Signed-off-by: Abhijit Gangurde <abhijit.gangurde@amd.com>
>> ---
>> v1->v2
>>    - Removed netdev references from ionic RDMA driver
>>    - Moved to ionic_lif* instead of void* to convey information between
>>      aux devices and drivers.
>>
>>   drivers/infiniband/hw/ionic/ionic_ibdev.c   | 133 ++++++++++++++++++++
>>   drivers/infiniband/hw/ionic/ionic_ibdev.h   |  21 ++++
>>   drivers/infiniband/hw/ionic/ionic_lif_cfg.c | 118 +++++++++++++++++
>>   drivers/infiniband/hw/ionic/ionic_lif_cfg.h |  65 ++++++++++
>>   4 files changed, 337 insertions(+)
>>   create mode 100644 drivers/infiniband/hw/ionic/ionic_ibdev.c
>>   create mode 100644 drivers/infiniband/hw/ionic/ionic_ibdev.h
>>   create mode 100644 drivers/infiniband/hw/ionic/ionic_lif_cfg.c
>>   create mode 100644 drivers/infiniband/hw/ionic/ionic_lif_cfg.h
> <...>
>
>> +	rc = ionic_version_check(&ionic_adev->adev.dev, ionic_adev->lif);
>> +	if (rc)
>> +		return ERR_PTR(rc);
> <...>
>
>> +struct net_device *ionic_lif_netdev(struct ionic_lif *lif)
>> +{
>> +	return lif->netdev;
>> +}
> Why do you need to store netdev pointer?
> Why can't you use existing ib_device_get_netdev/ib_device_set_netdev?

We are not storing the netdev in RDMA driver. This function is accessing
the ethernet copy to set netdev and guid. I can add dev_hold() here
till netdev is registered with ib device.

>
>> +
>> +int ionic_version_check(const struct device *dev, struct ionic_lif *lif)
>> +{
>> +	union ionic_lif_identity *ident = &lif->ionic->ident.lif;
>> +
>> +	if (ident->rdma.version < IONIC_MIN_RDMA_VERSION ||
>> +	    ident->rdma.version > IONIC_MAX_RDMA_VERSION) {
>> +		dev_err_probe(dev, -EINVAL,
>> +			      "ionic_rdma: incompatible version, fw ver %u\n",
>> +			      ident->rdma.version);
>> +		dev_err_probe(dev, -EINVAL,
>> +			      "ionic_rdma: Driver Min Version %u\n",
>> +			      IONIC_MIN_RDMA_VERSION);
>> +		dev_err_probe(dev, -EINVAL,
>> +			      "ionic_rdma: Driver Max Version %u\n",
>> +			      IONIC_MAX_RDMA_VERSION);
>> +	}
>> +
>> +	return 0;
>> +}
> Upstream code has all subsystems in sync, and RDMA driver is always
> compatible with its netdev counterpart. Please remove this part.
>
> This is not full review yet, please wait till next week, so we will
> review more deeply.
>
> Thanks
I will remove this.

Thanks,
Abhijit

