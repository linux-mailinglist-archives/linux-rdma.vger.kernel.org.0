Return-Path: <linux-rdma+bounces-5391-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B9F099B025
	for <lists+linux-rdma@lfdr.de>; Sat, 12 Oct 2024 04:39:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4E2711C2194E
	for <lists+linux-rdma@lfdr.de>; Sat, 12 Oct 2024 02:39:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2DE5171AA;
	Sat, 12 Oct 2024 02:39:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="IHMNVQlA"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2128.outbound.protection.outlook.com [40.107.93.128])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0BD08C07;
	Sat, 12 Oct 2024 02:39:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.128
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728700782; cv=fail; b=rAT1y3DYCvEYbCq0r/j/kbGdSVvzatnDeUvJ2144zVgYo2RUbdFxm3pmtZx0fByPP9qM+5r4i8Q+4llKIqQ3vHPoL7kX7oBB2rAGCFvzsis+2iE4W4RSmlUaL9cbOpof+cMDZ/saE6E+QVLey5F2/RKYJM/HEZm1w7RQ3q+aVrw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728700782; c=relaxed/simple;
	bh=v7+192q3QHijRfNgxajKyCHYfP+hJjp3ErLaIpktOtE=;
	h=Message-ID:Date:Subject:To:References:Cc:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Wjep7MVITnHCZiwAN5mHwm+xBfs89+DUS+CDOUsuR5XuuOpbQSRSUnE/8V3odviATA6MdyOTqIwpwrr5/xze0CKSoGAQOhUT+hSgAcW00rJhgB4O71APpJCBHkOEn8nXf9Nu0UfmgPxNuP+G9MnkbN8mAul1IGh9ACg6v9kgsUc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=IHMNVQlA; arc=fail smtp.client-ip=40.107.93.128
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ddQfHrLMf1ATxuBi8iC6WbD7aw2NusrnTTWj1n7Jdkm6ddnhpQ12fErey7EbcQB2fICH/X7pTVgav52nNRdrpm2xSNnUEPrLirmyPFm1/jacxrIl/Q9LClrha/1rGorsQ7DqfxHwVqV0KeMC09hB6qQeY4ed8A1LHKiKc062OVlCz0ERlYhewWa/MShCgFrxP0/It/gA5VcTP36qDAz6EP6WN/1ZpLFjZrSWh0V2Hvfpe7EudguVHBJ9XCW8XJsoISk+TkjXfwcuFDu+bjje3e5W6QyP3Y18w+PVPoTuNw8XwaueBLyUUm+qH9O05rYrt8uqQ1aB/xhkXaSiKEPZaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yw4+x+Yb7gfk1pE0gnfBi4UFlYXqUWvpsOpFQmOl4Wk=;
 b=cpJgLNBF4UxhfW/JPjxmhLHXp1Bf/KtkLPMFuLfX7jCIjg0jB+kxyB+X//5zuZNBQfSc5MInBgqr8ELWbZLmhqy0ZgdhpsdZT08vf9y/6s0vBro6w+AVR9tsVCARk2dNZ1pV4odXfebOdaXA2GZ9otIEsQNghkW2MKKhAqMHRkCxBW68MdmTVY9vekUFgwdFgCKJJiGQfNF6J1G0aw2c4Vae4TyeIre9yqEmLBhs55xCliunCgRs0FS17Wz1K4iJVJ+uMucVGcwgbYSw8X28D4yez5mxw4nQ9hKqkeJZYgc5gOv1cqaR3hlActT4opZj+eCQRWbpUwxigHgpWIMe1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yw4+x+Yb7gfk1pE0gnfBi4UFlYXqUWvpsOpFQmOl4Wk=;
 b=IHMNVQlA8+XQni9g6WtgoHYsD5xWKrfXN/grO27ImF++DxLz4L7YYFS/a1u1gCro9YbA0uqiTZiCGeK5PzMecRjnIr1yRLlgU9KefZNzf90hF2MSp1nluiTTY8U1CKeqc2qzrFYgV/Sr25sNnrwM1FoLXYLgV3fURIrlLhSOYa8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from SJ0PR01MB6445.prod.exchangelabs.com (2603:10b6:a03:2a1::14) by
 DS0PR01MB8011.prod.exchangelabs.com (2603:10b6:8:150::12) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7982.34; Sat, 12 Oct 2024 02:39:38 +0000
Received: from SJ0PR01MB6445.prod.exchangelabs.com
 ([fe80::223:9849:bfff:b119]) by SJ0PR01MB6445.prod.exchangelabs.com
 ([fe80::223:9849:bfff:b119%5]) with mapi id 15.20.7982.033; Sat, 12 Oct 2024
 02:39:35 +0000
Message-ID: <9782df45-b0da-46fa-9e0d-1c8f8b0e05d0@os.amperecomputing.com>
Date: Sat, 12 Oct 2024 10:39:45 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net/mlx5: Node-aware allocation for mlx5_buf_list
To: Saeed Mahameed <saeed@kernel.org>
References: <20240906061115.522074-1-adamli@os.amperecomputing.com>
 <ZuCv8VyJqoChZLIx@x130>
Content-Language: en-US
Cc: leon@kernel.org, tariqt@nvidia.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-rdma@vger.kernel.org,
 linux-kernel@vger.kernel.org, patches@amperecomputing.com,
 "Lameter, Christopher" <cl@os.amperecomputing.com>,
 shijie@os.amperecomputing.com, cl@linux.com,
 Adam Li <adam.li@amperecomputing.com>
From: Adam Li <adamli@os.amperecomputing.com>
In-Reply-To: <ZuCv8VyJqoChZLIx@x130>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2PR01CA0053.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::7) To SJ0PR01MB6445.prod.exchangelabs.com
 (2603:10b6:a03:2a1::14)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR01MB6445:EE_|DS0PR01MB8011:EE_
X-MS-Office365-Filtering-Correlation-Id: 2db3252b-a6f0-4e74-a170-08dcea671bd9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?eUJmZnRqZ0xZU3YrZE04NCtWQ2pYMEZKMDZPQjNQRjBGZDFYU3dSZTA3SU8y?=
 =?utf-8?B?SGRwVEJZM3ZTSjNhT0crWXpicEZsbmdWMlBGVkZaTXJTUDRzWkc0R1hLeDhC?=
 =?utf-8?B?U2l6cTQrekRLYkcxaU9vemdnVWZwV0dlTnRTbnhJS2x2ZVFpdHgwR1lBUUFK?=
 =?utf-8?B?VzFCai83aVVGWnVjcm5XRGIwNWUyZ0NVVnVBMWtXMDg0dFc4K0RxYzJ3WHJl?=
 =?utf-8?B?Rm5OQjhzb2Z3OVpaZ0RFRERVVzc5WjlBSVVEWi93VzVCY3pmajNGbmt6aXVq?=
 =?utf-8?B?QmVPcDl4Ykt1WTlhaGpvdWNqOGJETHlNQTY3WWZEQmFGRklCVzQ5eUU0aUJY?=
 =?utf-8?B?bWQ1am9HdmRyczdTandZbXJPYlFmWnhZWHRicTRob1d3Q1o1bGF4bE5vdzFG?=
 =?utf-8?B?S1kzVkFZQVo4NTJ2bDQ3R25EQ1F3eldjekowVUR3cVhSUWNVc3N4NXpSL3dv?=
 =?utf-8?B?ZXVxaVRWZk5LYklXQ1FjODl0MmdlV1hxYjFxSzVyQ0xsblhjeUFGZ0tKaEJF?=
 =?utf-8?B?b0NPLzFoNlRnbTB4RVhjUlVJQVdkTjBQOHNNcGtLWU05Z2lwS3dqQTZBRGk2?=
 =?utf-8?B?TGFMUjZnUTd5cWFWWXVJYkhOZlhjOUpVeE5aQ1JVek9lWGl3NGtMOHFyaWxu?=
 =?utf-8?B?WmtwN3U2ZHdCUUdRcm8rS2dIbVVGZjFROHpNem5HN0xCZklUY3RrM0tGcnBK?=
 =?utf-8?B?ZWtkN1c3ODV0bytxeHhDRWNISTFacDlmTm1mNlpTSmY3bjZmbndmN3R4eTdM?=
 =?utf-8?B?SFBoeEcwZDI3bzBQSFpEQndYclFMQXVqRGd3STFjRWprMm5NSjEzQU1sR2dh?=
 =?utf-8?B?aVF3VE5HbFJ6Mm4ra3ZaTTB6bWJvMlhDV3REU1VmV29lZ3E1b3FBc0hvOXpC?=
 =?utf-8?B?U3pubGJha2xhWEliTnVSeDZPRDV2UWY2V1RtRVRzY3drV0ppWGI0TXlzbTNX?=
 =?utf-8?B?SkJGb3M1ZDBVbXZONkVlK0hha1VrR0NmZndIbkpjaHJMZlBMN3pzZGxKTFV2?=
 =?utf-8?B?Y1k3VituQzNVL3JYTktWRHc2RGZvT1c3Nk9Wc0hZQkRGZHBEdERrcnYxb1Zx?=
 =?utf-8?B?ek1YUVJaTnZDYmpRZXcxcGpoOEcrSDFnZUR6ajBlaGFYZDhhZHBjS205dkFx?=
 =?utf-8?B?TklhUW9HbFZBZEpCM1BYSitKWWtPVTZlUTNGMEQwaS9SNndhY0duRnZaQ3U0?=
 =?utf-8?B?Y2lnc21tWmRXQUJSb0JoUk1VUnNCdjUyYkZXWDkvZUdQcDJxK2xYYmhxd2ZH?=
 =?utf-8?B?RittMzRYVkFNVEVldytPL3NWRGtJUlFpNzlOT213RTdGc3l0UXpwemE1NzE2?=
 =?utf-8?B?YnZ5Wkc0VXpMZVlsNkd6N3Vwdy81ZDlOSWxBYjZ0SlZOUnQzeGVXbEJrNkc4?=
 =?utf-8?B?Yk9zZExjVWo4TG5Zbk44LzFTYWdDKzVQY2RjMHRIRENYUUZJcUZDenVQWGFp?=
 =?utf-8?B?K1VRaHhDbHJreHlydmRYSlZGU2o3YWcyR0NaZ2lJK01nZlNiUXNtQ01aeFdC?=
 =?utf-8?B?QWg5YW5mUlFaMWlka2hPc3FCYXJuN3dVVTcrb2JCcHBLUjhhdTRtaDdDbE50?=
 =?utf-8?B?cnRkV2ZaMHNkZmtxMk5va2xjeE43K3FzY216Nzh2dUFic0sraDVSdmlxbCtG?=
 =?utf-8?B?L3NDTElLSU14Sk12OEVRV0dNQVpwM3RaOVFhTkFWOUxqZHdPbnlEdFJvVVRT?=
 =?utf-8?B?d1MrUGFLc2Mza2xBbldsd1hNRjVGK0ttMjVsWHlTTDFrTVpETWpkRjVBPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR01MB6445.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(1800799024)(376014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RHdpWUF6UWtYcFBjMDE2dWVaRWtDRnNZRnFDeWMwb1UzZDhLcG9zcjJYRGZO?=
 =?utf-8?B?ZVB0MFRpOTlORlRhVzQwcGY5WWlHQmg3d2VjRjIxVDdjalNaTm5EVExmVGJx?=
 =?utf-8?B?UW5yWHJzWHJoS3RFb3NTWkh5cHRaSnBJdEIxWnZpNlBGSFRIOWY2cDV6T2tp?=
 =?utf-8?B?ckZnNERVS0dKc2pvVUNxK0Y2R1NIbFNJMENlSm9Bd29PS3k4MnNlbHQ3T0Ns?=
 =?utf-8?B?YWxJNWF0dndxVzg0a0hHRk9ySTNFaHZzMWg4d2hWRS9yMWppaUp2U25leEht?=
 =?utf-8?B?OE5YRUduN0pObFdFbDMvdTk3S281SUJFazhuWVF1clN5dFpOdjhEWFNtbWVI?=
 =?utf-8?B?RDZ1MHJwbDk0ZE8yaUVJMG9nT2JEV2FsNFRKRGNhRm83ODkwOEN2ZHlhc2JT?=
 =?utf-8?B?QkhQZWdOM1lRaFNGOTFXSm1UemJyQzJwK0ZmbStYY2J4Y3h6VWNTM1RWQUdW?=
 =?utf-8?B?cWYvQ29BSDBXSWZDTjZKWjYrWFRKei95NTJUU052QWEwZ1IzNTVxckkrNU1x?=
 =?utf-8?B?dW9La1VsbUhYcjVmRmw2NHdZck01MjFsUDJZenMrYzVQRDFsMElDQUo5MWEz?=
 =?utf-8?B?NDg3U01zamRQcmVQUm1KbVgwQkI2aEQ3WTNBMXFvMjZ4UnM5QXFQYTZ4RFZM?=
 =?utf-8?B?cVNOeW5INXBRTWN5RlpnM2tiUG53K1AxbG5lR0RpWGVIYmVJYVhva0JIOHlJ?=
 =?utf-8?B?ajcweWhvNklaSm1RMkYraVRiNHBzVGl0MGowQnNXSklEODVpQWJDcUg2OWRw?=
 =?utf-8?B?Q1I0SDJ4VktQaHpLYzdFeVY0SDZtYVMycDYvNTFhTkRMNW5hZFlRcWpWUm9t?=
 =?utf-8?B?RG9yTEY5SEhNaFpxc0F4OG1Fb210ZEQwTHJvS0d5dDJUTkRWZTZMb1c5WTV2?=
 =?utf-8?B?RHNiV0VaRjd2eEM0WUUzNnFHM002THErWmk1RXlIY3Y3YUd0emVKbmtpR0R1?=
 =?utf-8?B?REF4TjBDQW9tRG50VVpPVTZRU3hZdHZpZCswY2dWUEpTNDd3QjBoN29DWWk2?=
 =?utf-8?B?T1NXdzhBc3g2cXdkZndnTUJQNDVCd1JRa1RrbmkxZHRTRFArQjh1KzI0c243?=
 =?utf-8?B?bFF4WmsySkNndWtpZmhPTjBBd1VidldDNE1rMzRWZm0vbktwK0U1d1huTjFE?=
 =?utf-8?B?c1hRUm1KM3NMUGNWTW91c1daaFlEckFIUlZaYUgzSGExemJkTURVQk9xcE1V?=
 =?utf-8?B?ZCsyNGxDQWN5b2RWYlJFb2lWV2pyeVNQdlM5NlZaVncxKzAxY0I4RWNCbC82?=
 =?utf-8?B?ZndSb1ZKa1dNSmV2emFEUWp1MkFsTUp1MlNrdU81RWJHSncwMHA1S0l6UnUy?=
 =?utf-8?B?eE50WnIycE84N0VJTDl2WU5zVmZUNkFoeXdrU0JVZ0E1TFpIT0JhNWk0OElj?=
 =?utf-8?B?RC9BU3QzYnBUM1lZeUxDZVhIK3hvOTRGN0hXMElITUJNWTRXVyt2WlBiN0VL?=
 =?utf-8?B?UHhuWWVkWVdldm51N3lZQXZVTkJNbDFOMDVRQnpYOXBaK3RTU3I3VStEWjVD?=
 =?utf-8?B?bHo1R1ZKcTNSaEJEMk5kY1dpMjd1SU5SWWhrS2pxRnZzbGVHcThMSWNlckFT?=
 =?utf-8?B?Mmx6RXZ4bWYrTm9OdUVLRUtsbWo0LzFXQWtvQVlyQzdNRjJlRG1SZXNDSVpD?=
 =?utf-8?B?d0NNekxFTG5DdHplOWFzUlZydmhSKzUzY2NOZE02K0RWdC9veUtxMVp0T0lq?=
 =?utf-8?B?UDd1dkVCUXFLKzY2eExqVE5IMXpTSTdJSVZVemxCUmZBaDFtSjUrWXVLS2U4?=
 =?utf-8?B?ckwzNWs2NTBaUTV2YUVIRGJIU3ljUUNrczZyK3VMV1E0OGxidlBZUGRkT3lr?=
 =?utf-8?B?ZjZkZE5VRFhCR3JQMitoRWZOSEkzNzlsZ2Q1QlVUbEh6QllURFhGcklTTEph?=
 =?utf-8?B?eUkvUWVpNUVMQVJsTm96VmhOMGZLZU9RZVZqN0Q0R2I0VDArbzZQN1lyN2Nt?=
 =?utf-8?B?NndZVi82TnNpcW10eFE1MEFZOW1ickFDZTFKTFFRY1ZPb2w2VXRpU2NsSU9W?=
 =?utf-8?B?NkdOMHp0L3ZRMnZkYWJqRGZXd3VKcjlYclcySFoxZkxVcnE4RnpuUjlDNHlR?=
 =?utf-8?B?Vys4b29YSXNvUGdJSnVsUXlORmR0MVdYeFZqNDBMNllLUHo1di9oSlpZbk9D?=
 =?utf-8?B?U3lqNHBuZ3hFdWwwTmtOMW9Hd3hrYjFFNlJZTkJaSUxITlNSTXMxVXlQZDhn?=
 =?utf-8?Q?osp2pUb2njSCWbuj5cysCvI=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2db3252b-a6f0-4e74-a170-08dcea671bd9
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR01MB6445.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2024 02:39:35.2962
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HCv1coy8azckK+dbH7/I2lzNaM8ywlXYliUwOMwnSk91hEeujm0NZv8YSGuaZ/w10Vi2FcN5HnqMw7liurN36P8jeiK1a8zU6xiNio+apOe6G14AQ7BXaawlrbSP1WmS
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR01MB8011

Hi Saeed,

Very sorry for the slow reply.

On 9/11/2024 4:45 AM, Saeed Mahameed wrote:
> On 06 Sep 06:11, Adam Li wrote:
>> Allocation for mlx5_frag_buf.frags[i].buf is node-aware.
>> Make mlx5_frag_buf.frags allocation node-aware too.
>>
> 
> Why ? buf is accessed by the device but "frags" only accessed by CPU.
> 
Yes, this patch hopes to minimize CPU cross node memory access.
I observed 'frags' is accessed on RX path from mlx5e_alloc_rx_mpwqe().

>> Signed-off-by: Adam Li <adamli@os.amperecomputing.com>
>> Reviewed-by: Christoph Lameter (Ampere) <cl@linux.com>
>> ---
>> drivers/net/ethernet/mellanox/mlx5/core/alloc.c | 4 ++--
>> 1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/alloc.c b/drivers/net/ethernet/mellanox/mlx5/core/alloc.c
>> index 6aca004e88cd..fda17b41ff17 100644
>> --- a/drivers/net/ethernet/mellanox/mlx5/core/alloc.c
>> +++ b/drivers/net/ethernet/mellanox/mlx5/core/alloc.c
>> @@ -79,8 +79,8 @@ int mlx5_frag_buf_alloc_node(struct mlx5_core_dev *dev, int size,
>>     buf->size = size;
>>     buf->npages = DIV_ROUND_UP(size, PAGE_SIZE);
>>     buf->page_shift = PAGE_SHIFT;
>> -    buf->frags = kcalloc(buf->npages, sizeof(struct mlx5_buf_list),
>> -                 GFP_KERNEL);
>> +    buf->frags = kcalloc_node(buf->npages, sizeof(struct mlx5_buf_list),
>> +                  GFP_KERNEL, node);
>>     if (!buf->frags)
>>         goto err_out;
>>
>> -- 
>> 2.25.1
>>
>>

Thanks,
-adam


