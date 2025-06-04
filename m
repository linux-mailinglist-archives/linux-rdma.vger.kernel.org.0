Return-Path: <linux-rdma+bounces-10979-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DD102ACDC44
	for <lists+linux-rdma@lfdr.de>; Wed,  4 Jun 2025 13:03:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 95A35174399
	for <lists+linux-rdma@lfdr.de>; Wed,  4 Jun 2025 11:03:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BE9328D8E6;
	Wed,  4 Jun 2025 11:03:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="V4hNrgg2"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2086.outbound.protection.outlook.com [40.107.93.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C115C169397
	for <linux-rdma@vger.kernel.org>; Wed,  4 Jun 2025 11:03:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749035025; cv=fail; b=drLogpO0CtwnBUP4jcQpj9sUMQuEcua3aCmZb4BjS6k1ZkaF/11w6Asqo/jdmjN8ljomO8QKu5luXZyHl8S+bWme5iyKrFspEPtl/VjTTjvFKePOUtS7tkyHRSAZelURNK6NG2/5g1DDRvrQHfD43/FROdohvJSlZQS3B7Pe6QE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749035025; c=relaxed/simple;
	bh=+isvdmbNexvXTqgw1404oSs6IGZBgCeVMCwYwhYAcBU=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=sKg77feiXVvvIn3I/gcfTJVZRf+f3UJ1TpShZglm8g1ViSF8zj/5eAAtSPa80DGW/baZlK6oAQEYdgD7guVBen/ImNc6biuhaFoPmEVGRi0LIYoWsLCpnUHOe4YLl8/bVKmsLxlZXXL7urkbNO2eMW2IYVWRUsxQASq/pCz6EEE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=V4hNrgg2; arc=fail smtp.client-ip=40.107.93.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZNdAQXBrIu/Acrai3pwcJvDXMFFqgewi96VGiFMXLp7jzBzPMfDMw+RAL8/QOXjrOZ9cqFmi91fSajutYDqhoIwzzijw6+Yl0F9xwsWQVa9qE4xt7Ysmy7vUR4RY7rJ26yE2lQH8Ac1V/vTEa6ANxXG4/DkNO7z4vvq0GeGl5RrMoj9zlXX9zfhwqDj/2yXBDAzGTVFlOaHkOY+9+WCMb8vyS3+U2jkz8tp1WHt+4f3ffaelcMEAXoNzZMh0noLfCUA/cuuJ09zQLLmVz1n3qQ3Qr4ioppb2p7C2/yNUUaSh2sgBzNTaMzfAsdxNhGhGZNgYUPUOi5KGG5VzCCAcXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k9mlNVoIao9HthGTOs35VFGFogbhoNEBO1CJPiy/KZg=;
 b=NxZf+jVsIhWrjsai+LNwzjZSd4221SzPYD32gUW3BmMqy6bqcetA0YFVgSsqoGLsuocJem4wy0FiUV+MqIFsWApvPh/T84Km3GzTtAvYxuqgJc3MX3MEFRtPJFdetqjhOUJS36XE66B1tWMIkGAqepMiaQjevfBOW3bH9Rw7p1FiCZG2P1UDNM4YdsE2sqrS8R07TvEAKNlsYPTB//X++cG1CqcAuBC4LIMfTJS66kEDtpSne6C0MWKdpgVjAptKlVfJJsga6AfmlFpsGao7oUZsEu6wJVr1sU5nMaeHFLz7jFf+PGFlkbnv5RgXDO5suPWJxjFd9Q687V+sl8om8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k9mlNVoIao9HthGTOs35VFGFogbhoNEBO1CJPiy/KZg=;
 b=V4hNrgg2qq6MQfDgsFUzfJC8vEvlYxoQhMrVsCvB2D6KAV+kpPy4jUQXpaOVWJyFbmobZzbgbo9fPloETHx+FK79Uus2HFVgadedJCQxwlves4ITBwaWywOOiUHuuWxXK3PX6XL5OGehBnNlxYgCv6wTzM06C+3qiTajTHcVbPgMBuyhJyj8oJQPDOnLZxfbaUB0h57Jbcy/xoVLGo1AmFMWANj6RCJUgZE98CEotjdH64WXx5PKQYuSjFO7nowW380FACuVxE+1UmhcSODH+PDhrCCtZnKYskJ2CDOJBLl6zD8m3HNcv20MNmCC6NyAPckJv1ciowmyYNGVTuAq7g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY5PR12MB6369.namprd12.prod.outlook.com (2603:10b6:930:21::10)
 by SJ0PR12MB6832.namprd12.prod.outlook.com (2603:10b6:a03:47e::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8792.34; Wed, 4 Jun
 2025 11:03:40 +0000
Received: from CY5PR12MB6369.namprd12.prod.outlook.com
 ([fe80::d4c1:1fcc:3bff:eea6]) by CY5PR12MB6369.namprd12.prod.outlook.com
 ([fe80::d4c1:1fcc:3bff:eea6%4]) with mapi id 15.20.8792.034; Wed, 4 Jun 2025
 11:03:40 +0000
Message-ID: <dd0a9711-23fb-47b4-9398-e54933ed2925@nvidia.com>
Date: Wed, 4 Jun 2025 14:03:34 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] IB/iser: remove unnecessary local variable
To: Li Jun <lijun01@kylinos.cn>, sagi@grimberg.me, jgg@ziepe.ca,
 leon@kernel.org, linux-rdma@vger.kernel.org
References: <20250604102049.130039-1-lijun01@kylinos.cn>
Content-Language: en-US
From: Max Gurtovoy <mgurtovoy@nvidia.com>
In-Reply-To: <20250604102049.130039-1-lijun01@kylinos.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TLZP290CA0013.ISRP290.PROD.OUTLOOK.COM (2603:1096:950:9::6)
 To CY5PR12MB6369.namprd12.prod.outlook.com (2603:10b6:930:21::10)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR12MB6369:EE_|SJ0PR12MB6832:EE_
X-MS-Office365-Filtering-Correlation-Id: d37a5f5e-9e6e-44f7-3220-08dda3577671
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?L1NMNkJWWHRyOUpiakt1N1paVXRnc2VEV1lkY04vZDFMQkJQUXNQeUNBQVJ6?=
 =?utf-8?B?YWZpTVhGaFA0K285TzVycHZBUlp5S0ZuRFBSVU1wbnhoS1BEL1h2eWJGQWxj?=
 =?utf-8?B?MzIwOHliUXYxQWxNMjYxazE5QXRzUWxyb1JwbnZGZmU0cy9zUjZpVUNMVTEz?=
 =?utf-8?B?L0t0eXFMSUY4ZmcxTDFXSk9QNXQ1T09QZmZHTFU2cXBzTHQydlJRTXVEdE9G?=
 =?utf-8?B?ZEJkcmFSZzByZFpxMWJZZWhUYVpJcFFyV0cxRkZBcnFjdXMyYXEvbE9ScXl5?=
 =?utf-8?B?RWEyeWV4SDRGUlVUa0JMaEx6d3IyMWYyeHVDU1BUV1FMM0NGSDVRWjBUNVRm?=
 =?utf-8?B?WUhwTHkwVWtYZ0lBTWdzNzRIZGlGcjUrbStsbXR2Y251MzdYRzM1SGRZb2Yx?=
 =?utf-8?B?eXA2S3RjTXNuR05mNGJMSlRPM2V3TENkSVFJR1FMbzdxRU1PMnNPeXB5UXZ2?=
 =?utf-8?B?RjNhYTVodnZnQjdoMTY2NCtOaVFxTFkxbzJhQmYyZmNOVEFtN2JzSW84YTRU?=
 =?utf-8?B?b2tVeWRiOVpJNk84b1RCWEJEcTRkZXB3eEpuVDNxM3RkZ25PekxFZlhzallj?=
 =?utf-8?B?S1VqU1BkamFTbFdlNkZmTHljSWo5NHE4VWRIaG5Wb2lkMU5yS2lBbHJRNmli?=
 =?utf-8?B?czd1Sm01bDI1Zk9ldEhUa2xSSnZOVURMc3Rwcy9tKytaT2cwRm1EZWlpNW1Q?=
 =?utf-8?B?OE9leDdEUDFNeEc4S3IrOWtwTkR3OWFveTA1Mkd0S2doOUV3UCs5YnFFZTlx?=
 =?utf-8?B?My9pcncxbTBCYlVSdFFQVi90TmJZdlQ1RTlUa0JyOEtzK3QyNWRYZUpHckZv?=
 =?utf-8?B?d2lsWG43SmdSVjQ1a3luT0Q2Nm5aQll1YnUwbGt3NFdxNlVleDM0RWxUbGox?=
 =?utf-8?B?YWNlQlZQWDNNK0JUNW1paGhWUUhLYkUweko4WDd3aWlmNTV4RWJoMDkrK0Ex?=
 =?utf-8?B?NmtpQkhqeDQzbitCYjloNVdhcFE2aEh6NjVCVFJqN1Vpb1NPYXFNZzdQNVE1?=
 =?utf-8?B?aHlLTWRsSU1RbklhVGM2djVFQ05CTFM4OWVSdTdYaFJ3Y21GeUR0d2ZDMjUz?=
 =?utf-8?B?T0JVazhtNURVN1IxZXNIbGhTVzJqNnFKTFVlWXNURzlxeXltQ2V6MzlTTUpP?=
 =?utf-8?B?a3I5cEVyclArT0xqYTFIOXkrWm9pTVY3NG5JTUZTbGRmSGNLWGJ4Wjh2SHVz?=
 =?utf-8?B?SWVzNDRJQ0JsbkRnd0lJWUN4dElsNWU5T0NwZHB4TjlqTzd1SWtiQTRCbGlt?=
 =?utf-8?B?K3Y1U2xRcHJobG41c1M5ZCtIWFdvWGxpL0JWZUlJTDJjaElRNEFzMXFha2h0?=
 =?utf-8?B?Wi9CbytqTVVzM1NLNVJIbHkrTkI1YkVnKzhYMGRXY1pWdE1YQ05ldFdOR0Mr?=
 =?utf-8?B?UGVzWGswT1VGQ3FTNmRMWXI0b2VLOUtIZkwyU1F6UnNJR2Eva0ZHRnZSV1BO?=
 =?utf-8?B?THhDcVo2WDhGZmpEbzZKUjhYamU2NkdCNHpOaUtETW9nT3ZEUTdvanpzdDBF?=
 =?utf-8?B?REY0OTc3TmV0UExzM3cwdDJDd2gwUVFTdEZRYWROSkZlOEhHZElmTm1CeVJs?=
 =?utf-8?B?Y2dPMVoyVHpQUEd2V0oveFdTQzRKbUJidTMraHZqaUtJNXZzZWZja2ZPYk1I?=
 =?utf-8?B?NnprM3JvOXU3RituZ2NsWm0zclo0TTNSWWxVM1lSaEkzeVRYcXF0cVlrblBL?=
 =?utf-8?B?dTlQWUVuNWVxaHVpM3M1VWswVjl1YUlINHhLMVlZbDAvdVJxQXdGVTZPNXlP?=
 =?utf-8?B?Z0FqUHlqUDRmWlRXRzFRaTlmVmtWUDJuRjMzdFJBMmxVMUo3c21Ebks4cTdt?=
 =?utf-8?B?bjhhNnFvRDdOcVFKaUFYUHZ0QnNLQ1VaTWUzTFY0QkMyeHB3SzM3TVZKcEw2?=
 =?utf-8?B?cEN0SFE4VFRUbDR0WTdBZmM0NmJlOVVGZTJ4R09vdHZxa0dXZFEzRitPeEJL?=
 =?utf-8?Q?iy8ajEiIkxw=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR12MB6369.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MXJ4K3ZJbmNGdmMzTVNUdUwvdldLZDJzOCsrdUM0eFVQODZLYUI4NEFJakdj?=
 =?utf-8?B?b2wvc2VuZWpsbkhLTThMTlhocE9kSzdjaFhyR0owWlVjTlFJYUtva3EyY2l1?=
 =?utf-8?B?blozcEVyVmlMUGlyc1dTRVdMYkF3cVk0VWR0NzViaW90UnNreEZDdjVKUDJp?=
 =?utf-8?B?QWdmdWtlNDZLU0YvbHpacVZ4ZldXZWhRUVN1K0FQZFlkaXRja3BpamlUbkZr?=
 =?utf-8?B?UEZFTGlJSkM4WnhGN2dOdU5wZnRXME93QUhieFRwUnhGV09vVjRGOGRGTU1r?=
 =?utf-8?B?SnJXWGpwRTk0OFdvYmVLcWJER1pWT2F0RisyT1dEeVExMS9BSHpJcmxyVHB3?=
 =?utf-8?B?Nk96bCs2YzVVcGZseldTMmt2ZFhpUmk5NE50YWpMb3RwNXRaOVl3R3JzNUVt?=
 =?utf-8?B?SCtkSDJudjF0dWk0N1JXc2ZmdEJCQzdta3NCQUl1eEMrS3RjakpwekpKZStE?=
 =?utf-8?B?Tjk4TDJLZFRFeDl2OE1PMU1uelE5cENrZ05ycTIyV3NJVDJwOXcwRWFhVzlG?=
 =?utf-8?B?Zy9lTkc4dldiTlhYdUxDd3hBRXo4Ylo1UktxSkdIVkhDYVg0WTh3ckpJemZL?=
 =?utf-8?B?M2hEU3pPOWl4QkR4RTRvRXNQVjVCUi9QeUlzVWhmTVJQS1JBYi8yTXhZVHBW?=
 =?utf-8?B?TENvTmRkdUtFeVYwem9NMVZKak1PTlY0THNUcklJU211eEhnYXdKcjNiUHpn?=
 =?utf-8?B?M09JUjJROTNob2I5OFZ6aGlXeVV2cGpZSmErTCs5MVpvK2haWnBPRzNOdGlN?=
 =?utf-8?B?dHUwcE5TdldJMk1ldEY5ckk1b29lOVZ0cE5WblQ3M3J0MkdicWhBcjVCUkVa?=
 =?utf-8?B?L3RqSmRyOHVqaWtDS1JhYlhVQ0NabTFFLy9UeHdHWElwSVg5SlAyLzMxTkFG?=
 =?utf-8?B?ekJqWUt3UnRoS3dLWE9hT2U2b1pXMWRnY2FPQnZKSm9pWXV6Q0dlTmNLbEdP?=
 =?utf-8?B?NTY5Rk9MK3JHZUVhVlNsSlpjcExhUG15Uk9pVlFJWDM4TTQ5K1Z3QVN0RU1l?=
 =?utf-8?B?S0p2Vy9HT2dCYmtPSndtWGk1VXJQb0pDbGRnMCtCQ2gxRDM4aFpzSkRjRDZ3?=
 =?utf-8?B?aGJLckRTb1BPdTViNzUvak1tOUkyUTAzYWJTMk8rN3BpTmZDclVDNHFrYlM2?=
 =?utf-8?B?ZkRwT1d5NWRCV1U2QXNaVGVEeG9ZUGNzdkRtU0sycWR1dW55eEx0UWZnQkcw?=
 =?utf-8?B?OXY5d0p2REFzK0ltK0Q1aXNMd3AxZ0lqYlBOSklKbWxydnhDYVMvMVZrTjBq?=
 =?utf-8?B?U3dQTGNhbVhwSFR5cCsxb3cxMG1MdU00dEQyb0tGNCs3Snh4anl6S0NFOEVl?=
 =?utf-8?B?RW1UNUV1MjhSNU9ZSStTWjBpanV0a2tKZzJkY3poN09IVjlIM0wyUnNTd1F6?=
 =?utf-8?B?NVZLQmZiZFpaK1BEZ3I3MEhTWEduVFhsV094OUZuLzlNUVE2MG1KYWJLNmdx?=
 =?utf-8?B?Q3lDZU1qWTBDanBuY2VFZUtTZkVreitJeVg4d0NRYkE3QzZkWjl3U09uckFs?=
 =?utf-8?B?dFlkVXdaZWlReVd4czZpdFpXZUlXWVRpZHdQVm9PWWVkaXZRYXdMVXg5WGRJ?=
 =?utf-8?B?S3RmMWFyN1dVdEJZN05uSzFad05MZzZqaTI0NVZNdmwwTFJ0NGh1dUpyUHdQ?=
 =?utf-8?B?T0czZ2hFZlh3eCtxOVZyYmZIakoyS3ZVV1hWa0w1ZGZSQnVwRitvTllvNFdu?=
 =?utf-8?B?eTVhMWNuMlBOWjQ0QjJpUEFYKzhTOUVQNzJkTkYxYkh1dUwvd2M4aWk1Zngx?=
 =?utf-8?B?K0JGS0ptNmJiNXBBSENxdkZlTzBmM3dJMjN1Y1p1M2g2SllWYVVYaUdHSlN0?=
 =?utf-8?B?ZUo1SFBxRCtCa2VkSnRqem9TWWttVWJlWkZUSmVTVng2VVhvcXRmMURTZFdQ?=
 =?utf-8?B?Y21INVVPME9GeTkrc2FGOG5hTk1kdERFMDZQUENQNTEveWtSSnZmOXNiUit6?=
 =?utf-8?B?eTEzR3ZUOG1rcms1RW13eWdGOEpVSUdHY1NRVVJ0cmp1VjlhUEdwYm9ZMk44?=
 =?utf-8?B?WmlMK0pvZHJjeXFvRGgrTlBwNmppNzB0RzAvb3FkWXFjSFFpM01JS3JWdG1a?=
 =?utf-8?B?dTJrR05HUDF6T0QwV0VPd003d2JVM1RtSi9OYXJyWWVjNzJxTEpwWEZDbFRy?=
 =?utf-8?Q?VWGbJ0luPB1MJfiKy/B4a8ycX?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d37a5f5e-9e6e-44f7-3220-08dda3577671
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6369.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2025 11:03:40.4500
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: B/KWPyeg8zLpuIpc30EJYnNdVKbEZMa0+MmYTsVlnt011/zr3xVIlI6ds3wgCw9aH8qzKrrJaKJYN0OkD7ZdOA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6832


On 04/06/2025 13:20, Li Jun wrote:
> The 'error' variable is no longer needed,as iscsi_iser_mtask_xmit can
> return the result of iser_send_control(conn,task) directly.
>
> Signed-off-by: Li Jun <lijun01@kylinos.cn>
> ---
>   drivers/infiniband/ulp/iser/iscsi_iser.c | 6 +-----
>   1 file changed, 1 insertion(+), 5 deletions(-)
>
> diff --git a/drivers/infiniband/ulp/iser/iscsi_iser.c b/drivers/infiniband/ulp/iser/iscsi_iser.c
> index a5be6f1ba12b..2e3c0516ce8f 100644
> --- a/drivers/infiniband/ulp/iser/iscsi_iser.c
> +++ b/drivers/infiniband/ulp/iser/iscsi_iser.c
> @@ -267,19 +267,15 @@ static int iscsi_iser_task_init(struct iscsi_task *task)
>   static int iscsi_iser_mtask_xmit(struct iscsi_conn *conn,
>   				 struct iscsi_task *task)
>   {
> -	int error = 0;
> -
>   	iser_dbg("mtask xmit [cid %d itt 0x%x]\n", conn->id, task->itt);
>   
> -	error = iser_send_control(conn, task);
> -
>   	/* since iser xmits control with zero copy, tasks can not be recycled
>   	 * right after sending them.
>   	 * The recycling scheme is based on whether a response is expected
>   	 * - if yes, the task is recycled at iscsi_complete_pdu
>   	 * - if no,  the task is recycled at iser_snd_completion
>   	 */
> -	return error;
> +	return iser_send_control(conn, task);
>   }
>   
>   static int iscsi_iser_task_xmit_unsol_data(struct iscsi_conn *conn,

Looks good,

Acked-by: Max Gurtovoy <mgurtovoy@nvidia.com>



