Return-Path: <linux-rdma+bounces-7102-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0083CA16BD8
	for <lists+linux-rdma@lfdr.de>; Mon, 20 Jan 2025 12:56:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7A2281885FE6
	for <lists+linux-rdma@lfdr.de>; Mon, 20 Jan 2025 11:56:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA1E21DF74C;
	Mon, 20 Jan 2025 11:56:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="nZSiICT4"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2059.outbound.protection.outlook.com [40.107.237.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82FCA1B6CFD;
	Mon, 20 Jan 2025 11:56:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737374171; cv=fail; b=AkRUT3I9/ea+2FSf8KNtQLav03QxWQStrHWIRgiyMFoqgWEPuyVwUzFCY0E9tnNxk6cW2d1udySizZDslbZ/EMAwcc2syX+jNjXsZ7wkHTNcRb9eQFcN2ctggPSFYlNBpDDKAElqLFHshGCvN89u7buNM/seFXvs2Zm8eMvkvKs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737374171; c=relaxed/simple;
	bh=8vMAFN49zS4Ydd3om5tUembvRmwE4otKdIlaRxQVX2M=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=t+DmxtrMU/LkfMw5io4lirHDLp2ELOTrJFZQI/4NBJtzEMD9MrQJqSBdYPFVj7j7iw3W0FJ5PAqwLO2TmRHPdgrjhlhqbKjA78V3SMUYCOZ+JY2NNG0DT9qYdqwK6L5LyQQIgYgqk7kwEA9yEkYrk+pv4LSL4x1WPX6xeuA8It4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=nZSiICT4; arc=fail smtp.client-ip=40.107.237.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hvOiqpTrgKg6YYB/c0DVZFfEyvTHl4Q9fG5iIfbXgdD/+8JhE/3gFYhSgl1Qkf5CIqutJJmStm4IYdI3T4TLlE3+GKdXYliAS9/qnU+Xww/CdHEzv3aeexYRPYZ4BP4HaXCD5fJyghNjYTCYVuzhu9vslgX528Y2ghBH8tv3uljXenrHcD1DfbtZh7dctBxfqcJ5Qye608k46bAZv0ID9Y8YxFRxLZgXCjUt6PZIk62s5nNuAHwLmUdgR20l3OcISnKfkJ6xt4XJS/Yn8QcB2rynzYCq6N2vY/3Qh3/ApQFyK8xY70nUFoe4d2nyNZ58YPZXnXbcLO2h0efilx9Opg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CtXVIDk23jdD7Zaco8U0GTQnWpHWs4mwkbcAn3oQeF4=;
 b=Lu4oDZKcsGRRaGeLCp+eEh49o18IMlgSSu1Mr7ZDDT+qsvNG25mk0MHJodisseGQjJ7wB+VHG7Z7VETCZIAWmoRwWtg5YNFqn+LHPENHXyxWtSfPcQFRcb1Lz8OQk3/XtTsB9d3z1ZJ1townHsWoXsDR79JfBDNUXSDmXBJOj58h7Bghc7Q+vWVdS+eTUToc1Dd9hEf1YUk825+T9VX+/aXQpd+5LnU9BYTQuIUxr1yOC3PWAp57E4XV1KPXUzJA2+/99JUk9u9N6V5q8tk4OOnlw3jdJPpcBOPwonRx3++ooOFo09SZ7n+4gU/B9RIEH9iXoQes3pmEj7nxuDvCtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CtXVIDk23jdD7Zaco8U0GTQnWpHWs4mwkbcAn3oQeF4=;
 b=nZSiICT4WYNYBTdAStKXFZUcBNiwIC+dKKnGjULLd6LufwCsn8Ojd6uDIiWu9RyFdtsF/UG8R1P0ig3WbHn7SxMWYFjeJ9Al0hjouVi9mM/h8lD9PpH/2A17ZdxJtmHmhrwzIo0TGHWlnVUoL96Cd2LAISp+l8BEiNyavZDdq2592pOGmQWJdiemnrJuL42O4dNMKP4xkwQWBYTz1SnMr8g28UnSMmxxslb1HHBkaepmedNYdgc1TuyucmwYQ7aiNM32dYMW33TvsRAnNlByZsPgufOa6ZVkmwa7c8R4GYVEV3TLbmebNHZqhrXBuuzkY3qqirxCFPJEFANXIMdXYA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MW4PR12MB7141.namprd12.prod.outlook.com (2603:10b6:303:213::20)
 by MN0PR12MB6272.namprd12.prod.outlook.com (2603:10b6:208:3c0::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.20; Mon, 20 Jan
 2025 11:56:05 +0000
Received: from MW4PR12MB7141.namprd12.prod.outlook.com
 ([fe80::932c:7607:9eaa:b1f2]) by MW4PR12MB7141.namprd12.prod.outlook.com
 ([fe80::932c:7607:9eaa:b1f2%4]) with mapi id 15.20.8356.020; Mon, 20 Jan 2025
 11:56:05 +0000
Message-ID: <1e886aaf-e1eb-4f1a-b7ef-f63b350a3320@nvidia.com>
Date: Mon, 20 Jan 2025 13:55:58 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next V5 07/11] devlink: Extend devlink rate API with
 traffic classes bandwidth management
To: Jakub Kicinski <kuba@kernel.org>, Tariq Toukan <ttoukan.linux@gmail.com>
Cc: Tariq Toukan <tariqt@nvidia.com>, "David S. Miller"
 <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>,
 Eric Dumazet <edumazet@google.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 Leon Romanovsky <leonro@nvidia.com>, netdev@vger.kernel.org,
 Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman <gal@nvidia.com>,
 linux-rdma@vger.kernel.org, Cosmin Ratiu <cratiu@nvidia.com>,
 Jiri Pirko <jiri@nvidia.com>
References: <20241204220931.254964-1-tariqt@nvidia.com>
 <20241204220931.254964-8-tariqt@nvidia.com>
 <20241206181056.3d323c0e@kernel.org>
 <89652b98-65a8-4a97-a2e2-6c36acf7c663@gmail.com>
 <20241209132734.2039dead@kernel.org>
Content-Language: en-US
From: Carolina Jubran <cjubran@nvidia.com>
In-Reply-To: <20241209132734.2039dead@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO2P123CA0075.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:138::8) To MW4PR12MB7141.namprd12.prod.outlook.com
 (2603:10b6:303:213::20)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB7141:EE_|MN0PR12MB6272:EE_
X-MS-Office365-Filtering-Correlation-Id: 1d274a02-64ed-467a-6475-08dd39496b3d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NTlVZmxpSFpUTmJXZ2ttd3dCRnUvcG9WTnF4aWlaTEo1bUNRaDhkd1cvYmcx?=
 =?utf-8?B?WVVidVJJcEZQMFRXc1JnT3YxNTQ4QmttU0wxQXJVa2ttYzRScWZ1bFFteVhx?=
 =?utf-8?B?VGN1RzNJZDcxSU0rdnZGa1Vic3F3V1FuajU4L2hRY2tSbHhEVnczVHk4N2Iv?=
 =?utf-8?B?OTVJb0U2S05xYjBtQy80MUVFdXZ2MnowNTNMbUFpK3ROMXBDVXFwVloycWhZ?=
 =?utf-8?B?Y3pMUlduRTNJV0I2RjFWQzdYOUsyeXBTSUIxaUpqODd3ZVlQNzVmVGdUZTV0?=
 =?utf-8?B?aFFUK1MzUGJkeU00TVNVT1ZrVndXOVM4VzVmTEZOdkpaZW9aUlU3aWIzSTIr?=
 =?utf-8?B?S1RXUFkwRnpRbXhHQ0RkL3lQQjlMM2pQN2xveXF3WVVpT01taWI1RUtVdjVV?=
 =?utf-8?B?aGRtL3VtOEtJYlZVYkV0YTd3Wkxtb2laVCt0MGlVVkNTWGNkN3pWdFhVcU9w?=
 =?utf-8?B?NDlEZmtDTFlOeTBEMkZzTGVGaGdGenJhU0drUjFSeWo0RGF2aTNONjhscG0x?=
 =?utf-8?B?SWxLN0hJeDlZTE1RMDA0elVCTEVUYmJkUi9xeGp0RjJEN1ExMHJ1dTgyNzdZ?=
 =?utf-8?B?U1dmR041NFhKbExSaHF6OGEyZ3FuYnBwV25VT1grLzlLb3gvVHpkcm1OekFX?=
 =?utf-8?B?bVM3a0xzY2V5TjY4MlRpRjkrNURHUHlSbzBwN1I2cVBuVGdPQnJ2U0Qwa0Y1?=
 =?utf-8?B?dHl6c0dZUTJKbndBU1VzRUdpTWVUd1kreFhMeE14VnVhT1NvVG1xNmNlVDVo?=
 =?utf-8?B?OEt1THJFT1BMTWQ4OFRBM3A3VnNzVXV2TkVWdWxRTzlxeXJzVE5kZkVvaTVO?=
 =?utf-8?B?ZjVKVit2cDlGek5UNzJwNStsYy83NnplMlFGakhxdHBldDZvUmlvWjM3WGRZ?=
 =?utf-8?B?eTc0T0l5TzFLOW1aMS9ieklyNHI1WTFncGpyRE9HQ2x3NURaUUJoczhoa3Rw?=
 =?utf-8?B?Y2lRWnFUR3hLOVhuSmtCeVJ1aWZkYzBPRU1XQzRleUpVNlBET0Z5N0tIQ3BD?=
 =?utf-8?B?Nm55UXVScE5EZXh1cGNmdTR0VjYxT1kwT3JjaWsxY3BNMCtQZzhVb1pyVmFJ?=
 =?utf-8?B?RDRGMFp2NVI3bVpmQ0VZS3c1dmswR2Q4SjlQVzY0dkhtMFVyZlEwWVhxa3Rt?=
 =?utf-8?B?bktBckg0MDQvOVkrUjBCZzNIenpjT3daWkVMbGN1M3ptMUM2U1F0ek9FWkI0?=
 =?utf-8?B?aGYrZ3c3Vm8yQnIzQ2hZVmQxV2Y4WUVMenZuaWs1VW1NWWVjWUUwcXk0emxN?=
 =?utf-8?B?Z1pKUHgxdmRGWjN2eU5JNHFlYmxWTG9TT2UwdG5vemRrbUgvVmpnay8wQ3ND?=
 =?utf-8?B?Y3BYaWFiM3ZXKzA4Z0NMYXg0L0dBQVQ1NXZ3cm8xTTYybDJBdGlRcm8yaXJT?=
 =?utf-8?B?M0dEeWNBNEpXRmU1ZDkvU3orcVNBSHRSZDlMZkxwUGtqNStrVC9PYUk2U2hh?=
 =?utf-8?B?ZkRLZGFjMmxxdFBUOWNHVWordm1IV3liTHNNZVFNQ09DZytPUE11Q2Nyd29F?=
 =?utf-8?B?dTFIbC91ZkRBbGRFOVoxUHhOYTFWK0xoUExCY3NDcHRmaUNNV3hnZzY1UmNi?=
 =?utf-8?B?Uklsa1ZiYkI5b1BEdDRtb09YNWNUYkZmK1VqQisreWh0U2hid0ZyWjV4Tmcr?=
 =?utf-8?B?bXZ1TW9maGJNL0Y5TVRoRnpwZkQ5K01QNEpWS2VsaVYyR2ZSTDV0a1BLTWtW?=
 =?utf-8?B?MGJhL0cyMDNXY1hSTHdMcVFoWFdWS0l5bmh1ZkVmUzdOMm8zUm5qK0JvMlQx?=
 =?utf-8?B?R2hRVU5XbEhOdHpRWHRPTUtQRnFiRUQzK01PNENaTlpMOTlFaFI2a2dqSEY2?=
 =?utf-8?B?MmpGOVV1aFNRVjdiWnoxN0xPUGRRUDdUUURCSjlEZUxBUTVwbGY1NDM1VkVi?=
 =?utf-8?Q?Y5PZZ2ChxUq2b?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR12MB7141.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Zjl0aXZOcXJad01DWjNoWVMwMy8vclhJQnVYendtSDl1VVRqRXhIWUlyZERG?=
 =?utf-8?B?SW9pOWIzaVJKVGV2ellHamlpdHE3d0tVS0FzMzNiVjFPc2N6TTdQYzRvcUM1?=
 =?utf-8?B?OXQvT2cyWVdWeXRQMVErVWNDQ1BYWWlPcDRXazNXNFVreTVOVVRZTW5yOXh4?=
 =?utf-8?B?NmUxR1FnU3p2eUxGYVpDWU8wRm1Qa0VmbUZrMzlCR2kxWWdNaUh1T0FXb2h2?=
 =?utf-8?B?ZXF4VS96R1RrQWNNSU1hL1YvSVF6SlNFY1NRbE5uemdWVG02VHhPTVdlaCtV?=
 =?utf-8?B?cEpCeXQ4ZkFiSjNvK2l0M3ViRll3enV5a2VTNUNUejFmVmpndnAxRkZhNkRo?=
 =?utf-8?B?M2dKbGwrRzVEVG9FUm5NbWdvQUpuM3c3L3d5b2xDTjQ1NVh1RGliMFF2VklG?=
 =?utf-8?B?N3piNDZnN3JwbTBLbWpqTlRSeU9oWXhtNGRvZksrOXdvaVhSMUh0YkhIQ3ZV?=
 =?utf-8?B?YkwvM0xhWTNzZEM3czdnYkt0U0tCNVF3amNTQ3lkeXlmUmlhWlJLa2NRejFI?=
 =?utf-8?B?TlVDdTNESlI3dzhjU2V2UWgzQVk5VmlLWk1wQ2x1RzBLT08xREZRQ09XV1Zy?=
 =?utf-8?B?a3JHdWxSWm5aTVlxekxzQWV1TksxdWxaSnlSWHZLMmdHa21JL1BUc0d2Q3pD?=
 =?utf-8?B?bmdTOFdHdys1bmNqRGNtM2ZLVmg4em5HakswbmpTRE10Q3RMeG1UMllKM3FD?=
 =?utf-8?B?NC8xelRURnhJWklmRitlU0lUdHNLSks2L1Zvendpc0VYcVE2cUwwUWFrTU5C?=
 =?utf-8?B?d2ZJeHY5aXo5QzFLYXcrUEViZThLOWwxK25ZaWd5YXZkQzFMVmEzRWExeGZv?=
 =?utf-8?B?akNBNU9mWVJBM2tPbERnRWthODdGbVU0SmlWbWZTNFlTOERSeEZYV1lNMlhQ?=
 =?utf-8?B?VXFMalBHN0tBNjlEMUx3QzVremtPckhuWkZ1Y2pMY1YwRGY5c0IwcTdVTUpr?=
 =?utf-8?B?Tlh4WU8vK3BRbC9venNLYTQ5bUtubzZudTZIMnhuUlFoNS9UZ1daMzVpVlFO?=
 =?utf-8?B?a0NjMldwOXNrWWdzWGh2RlR0NEdQK3RwSFoyK2Yvb0dPTy9lMzFIc3RCUkh4?=
 =?utf-8?B?MVpIc21ITHFlWUtEY3d0MDh3enptVW5vNkY5WVRtdno1WUszZ1pSd1MzbjEr?=
 =?utf-8?B?bVVLbXJZL1VaV3BpcWQ1dXZYQ3MyK3RyZ1FEak5mbXk4L3NmL3FjU3pFSFBM?=
 =?utf-8?B?SlZrZWM4bStZaW9HS3g2WFRZZXBWVGpSSzF3ZFlGRk10QWJQMDdoOVFiOVJn?=
 =?utf-8?B?Vlk1dUpxMUVlbEVqdTBuUXVRS2wvcnVQSE93N2o4YWRIWkNNbFRoMzdVbnBa?=
 =?utf-8?B?N3N0RzNTU3VJZlVuUm84SHI1RkY2YjY3NXlxeEZIOEEyNWJMajRXbFFoSDdB?=
 =?utf-8?B?MkVtTzNVVURBTjlFbmRzK205UkVHcFBEZ1U5WHM0QzNoM1VOa3g2VjdoQlB0?=
 =?utf-8?B?VFB2c0NxN1UxOHpZUnZqekdRM1JiOEVnTTlxcGJIUmJadDRSeWFEc1FSMlEx?=
 =?utf-8?B?WEN6NkRBSlZQemgyR096WFZVam5QWi9tajBJWHlYVEJ5VUJ1NnpBRk5IN0xk?=
 =?utf-8?B?U3FHMGN6SWFETnBOTDQ2Yk1tbExuQWVGaFZEaVBObjFaM2t0aTdId0d4emZt?=
 =?utf-8?B?amRDajgvSERFSWc5UDkzRUhIYk8wakhTRU5DN0hCdFB4Rmw3cUd4QlZHeTYx?=
 =?utf-8?B?MnYvWlBZTVJlZU9Zb0hFMExVaUh4aDBHZFdXeEdPQVZYUm51VEV5VWxUQlJ6?=
 =?utf-8?B?eTVGTmsvRVBwb0N4WDBJcGlZZGxYdWthL0s1NEEwa1VCd2hmcXcweUg0QUhu?=
 =?utf-8?B?ZEx2MnRvTGF0WElQTWVpdXdHZStycHlSSTRWbDBkYzVMOUduNGxyWmd5ODVD?=
 =?utf-8?B?NVEwUlBnMmh1cVN0Z2xZTEo3NTI4cytqMVFjRnFDSmd4UkpXTlBic0FENFly?=
 =?utf-8?B?NHp6TktHRVBZMFFNSzJHUFJGMFFXRk90M2xoYTJCTE1xWEdqdmdONE1jZHcz?=
 =?utf-8?B?cC9uR0JZUm9CTTgyblZsczU1dGVkaWJTV2pORWhWMlplY0lic2x6RGpKRXRC?=
 =?utf-8?B?c0swdnJaaGxCYjJMUFNJMWxLeGxvUnFsVVZoQ21taG5peHQxNHJCeWx6cHpp?=
 =?utf-8?Q?osBzko+MzSGEAi5c6jUj2aec/?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d274a02-64ed-467a-6475-08dd39496b3d
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB7141.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jan 2025 11:56:05.4001
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rMpVeAvzyn3R57OR7YWys7AMd5Jllj878h3iIoNhrNLnwHMilVcXV1JzQCHphtoUEtpZlvDZAHpz7f1CtUOPuw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6272

On 09/12/2024 23:27, Jakub Kicinski wrote:
> On Mon, 9 Dec 2024 23:03:04 +0200 Tariq Toukan wrote:
>>>> +	tc_index = nla_get_u8(tb[DEVLINK_ATTR_RATE_TC_INDEX]);
>>>> +
>>>> +	if (tc_index >= IEEE_8021QAZ_MAX_TCS) {
>>>
>>> This can't be enforced by the policy?
>>>    
>>
>> If we enforce by policy we need to use the constant 7, not the macro
>> IEEE_8021QAZ_MAX_TCS-1.
>> I'll keep it.
> 
> The spec should support using "foreign constants"
> Off the top of my head - you can define the ieee-8021qaz-max-tcs contant
> as if you were defining a devlink constant, then add a header:
> attribute. This will tell C codegen to include that header instead of
> generating the definition.
> 

Hi Jakub,

I tried implementing this as you suggested, but it seems that the only 
supported definition types are ['const', 'enum', 'flags', 'struct'], 
while the max value in checks only accepts patterns matching 
^[su](8|16|32|64)-(min|max)$.

 From what I see, it doesn’t currently support using a const value for 
the max or min checks. Let me know if I’m missing something or if 
there’s an alternative way to achieve this.

Thanks,
Carolina

