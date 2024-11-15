Return-Path: <linux-rdma+bounces-5996-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 71D169CDA26
	for <lists+linux-rdma@lfdr.de>; Fri, 15 Nov 2024 09:02:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 94353B22D1E
	for <lists+linux-rdma@lfdr.de>; Fri, 15 Nov 2024 08:02:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3809D18BC3B;
	Fri, 15 Nov 2024 08:01:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="maMWIp6t"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2045.outbound.protection.outlook.com [40.107.93.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BCD42AF05;
	Fri, 15 Nov 2024 08:01:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731657718; cv=fail; b=GpvjO263834kGdvckuZEVRlgrbNzVc/IofJmBoEabT9a2REqeN55dftSGqAu631jjczmgHXsHkMvbTM3JySLuXygDeUbM8dmTueIeR/RFKh0crIunh10crxP+1YpvLoqOX6Z4b65+AheEX9fgJhRWnhpwuzTAHVzSOqf7Yx5hp0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731657718; c=relaxed/simple;
	bh=1c6Cc1GnrLe+aa6tBOuBT8dGMiyFvayPXe8fW0v4zPE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=OP8VkJdRZhTBecnczIJT4Jv5yHnX3SOFYOfQzKmeVLbND/01SBdMTWXUDcO8bDTUe8io9HVOpsmmM/NB2L328kjhwYGX84kSwjtlG7Z3IoRMgiXZuP+axmN+iK9Xtb7eBITDCnH760xmgTgXRaThYrTTsYK+kl07yjfaECLWH2s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=maMWIp6t; arc=fail smtp.client-ip=40.107.93.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ik1PocwbnHpB459t+6GgUq/wJ20qcayBMfzct9ybLt+vQGqefU/DCew4RWAnVmQ6RkKWHzlMuNIefjQr/XUrczik8ukgjBtLWoWMLcqjF0IEDoKn0MUJ4NYXcNSzOdMNkucPANdQxEUS0yn3wKCRzZyig9pIb0J9Aq50o31sZIJy2GTO3Ymbs0SyloEqZjzAaWYuUTtpizna6XVcQV0tD7k21JDEHZ5YeSVL5br0pd1HYeKVmVOWxdSqa03H2b4uqM8DgzSM6494IT6X0NfrWL1vcwIFj6gC1cKmlp86RnUm5bzszdYOBQhIgKx6YOv0GNUmtmoHqBlD+bexcV3piw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0A9+PBJri4yvNuauot4ImwrheDJWHssf89ns1zDu+0M=;
 b=CGVd1LlNCxBSIMvpxIF1LvghN8exhN2bYobTSnGoIiujChqVYVU6K73KCTpueWY9jM5vL0c3SsDe85vWC+WFST91YyUzhARQfbFRyt7bREVAyamu3w0uoEJM3AXvE7kH6yGk49xLKxZ7zQccjYqM9oh/F5M2uwNxqxfhbDUL+2IHvQm+vgek1H25WyEobtkoyq0RCqDy6Fg61asrPGmQNM78NaKOcVpBEQiRV76eoie4leott33RIX0i8Vv9NQqVYDqGz6rztfCSoaaHeRAVK/1bEbRC48PcKP+A5V2atZEJC4PLVrKpDvMYFAeVFQnKCx6cTD9HoMMIQztZf9e3pA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0A9+PBJri4yvNuauot4ImwrheDJWHssf89ns1zDu+0M=;
 b=maMWIp6tuCexXM72XHAqncRVCerBwRiyubq/n6TBfAs2UmS/GCd08sdwkPP2c5CF3zXToi5n0XGG+KSBVtHfgkv8JM4Q0v/YdZwG7yB5KyTF0T1yNpLY5RzVXSlC2LBKZDNNosaj+tMPV3bHzGTBTd35DW0f/2TphoI0Rk6NfDI7+mN2Hw8h32Qi0quy580HNcOHY9DpJwzoFcGFcZNiDI2oRQ31Z5cf2ujdc6TdrxUTWHJ1BahAXdQxC7eX8s4hunsc3siuKkdFIwt75s4rcKoGcF3uhwjrOKf8S1VEkcjcOovN33OBCUMMOo1hToqMGBZbkRgxefF2BV/wOHZHtg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from IA1PR12MB7663.namprd12.prod.outlook.com (2603:10b6:208:424::18)
 by CY8PR12MB7268.namprd12.prod.outlook.com (2603:10b6:930:54::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.19; Fri, 15 Nov
 2024 08:01:52 +0000
Received: from IA1PR12MB7663.namprd12.prod.outlook.com
 ([fe80::4846:6453:922c:be12]) by IA1PR12MB7663.namprd12.prod.outlook.com
 ([fe80::4846:6453:922c:be12%7]) with mapi id 15.20.8158.013; Fri, 15 Nov 2024
 08:01:52 +0000
Date: Fri, 15 Nov 2024 00:01:50 -0800
From: Saeed Mahameed <saeedm@nvidia.com>
To: Yafang Shao <laoar.shao@gmail.com>
Cc: Jakub Kicinski <kuba@kernel.org>, ttoukan.linux@gmail.com,
	gal@nvidia.com, tariqt@nvidia.com, leon@kernel.org,
	netdev@vger.kernel.org, linux-rdma@vger.kernel.org
Subject: Re: [PATCH v2 net-next] net/mlx5e: Report rx_discards_phy via
 rx_fifo_errors
Message-ID: <Zzb_7hXRPgYMACb9@x130>
References: <20241114021711.5691-1-laoar.shao@gmail.com>
 <20241114182750.0678f9ed@kernel.org>
 <CALOAHbCQeoPfQnXK-Zt6+Fc-UuNAn12UwgT_y11gzrmtnWWpUQ@mail.gmail.com>
 <20241114203256.3f0f2de2@kernel.org>
 <CALOAHbBJ2xWKZ5frzR5wKq1D7-mzS62QkWpxB5Q-A7dR-Djhnw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CALOAHbBJ2xWKZ5frzR5wKq1D7-mzS62QkWpxB5Q-A7dR-Djhnw@mail.gmail.com>
X-ClientProxiedBy: SJ0PR05CA0181.namprd05.prod.outlook.com
 (2603:10b6:a03:330::6) To IA1PR12MB7663.namprd12.prod.outlook.com
 (2603:10b6:208:424::18)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR12MB7663:EE_|CY8PR12MB7268:EE_
X-MS-Office365-Filtering-Correlation-Id: 9979f647-1361-4eb9-1583-08dd054bc3bc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?L2ErTFhDZExYaVg1T2JTUEM1bUhFY1J5R2JoTDQyK09UMlJkdlhOQWt6MlF0?=
 =?utf-8?B?Ukx1dzh6WUJSY3pVZzRRVE9EenZ3ejY0S20wdmd0N1VZTGk1Z2pXbmwxOEF1?=
 =?utf-8?B?UGhSYk42Y1VXRHBrc0oyK3ZYRXY3cmRERWYzU2pzQ3UvS2dQdXhpQVZtc0hn?=
 =?utf-8?B?Mk1ZdUpTMnF0V3hrNlBjaTE1RVllTzI3cmN0dzVRTm9kQ1dHT0tqTGhmenhl?=
 =?utf-8?B?enBOYi94dFNFRERQdjNwc1ArWWQwVEVLZjlVdXBBVDZkZlJUbmZRUHNyVWZk?=
 =?utf-8?B?VUR2NEFKZWhPaDdnMXV1cFFOUEVHVGRkNUtjUGRZMkV5bmFGWFUrM2M4V0hD?=
 =?utf-8?B?WkgwUk84elh1WmNwQk9CRy8vV2hEK1d5aXpHa0UwdXcvcGVTakJNYzFIZVFH?=
 =?utf-8?B?Wm93OXJuQnl1SVNzZU5lYWJsQnVUVmk5alo4YVVROE5RYy8vTDJ2dkViTHk0?=
 =?utf-8?B?N00vZ1dJWTB5TENFRkZ2R2ttOFg0ZVY5MUxNM2NOdU1QSVVyWUpLRStTNFlx?=
 =?utf-8?B?MVJKK1lNVHJxbEw1RWlsVlZGTFNZLzR1aUFRYWViU0lxWHdBWUxubnpaQ3lF?=
 =?utf-8?B?R2xtN05iaTRSOWFGTnFwS0FXalp5Qk12Y3p6NWFBVWdBRG1JbmR0bUkySENM?=
 =?utf-8?B?WU5XV1gxb2FTWlRDWHJ3UDd0M0liWENVcjVjM0tSSFNiRnp6ZGs1allZVTVl?=
 =?utf-8?B?WDFsZ1VQdjh2MlVCTDREdHNJbUdvL3BuMUxjK2NRVTRKbElmSzVjK09ZNE05?=
 =?utf-8?B?VWo2VDgxTnFYa2lkbHloWVpWVUlJZW1hRXZFSGhOYUhuS2hlWUEvTFpwMkxU?=
 =?utf-8?B?K1RlK3B5aFVPaGROck1mZHdQQ3hVbW05dWUrbG5Ua0JCN2NuT0g0VDlQQ1hZ?=
 =?utf-8?B?ZVAvUUpzKytYcmR1RkZhdjFvYzJoR3NtSi9Sd2laQ2NhZjhrN2IydnAycUx0?=
 =?utf-8?B?T1ZjZEw0QmwvZVczYjdSMUpSVFJGajdNODNjVTZkTjVPNWNod3JFVlIvVkJz?=
 =?utf-8?B?TktENFhkd0xEaWxveXhZUEUxQitQZTAxZ3dldktxUGxsd0huZHFTcEtTVmVW?=
 =?utf-8?B?KytRRnNKWHRTbEJSeVlNZzdoa2NLR0ZTQ09OYXpZK1JnU2d6ckV1Q0JaS2xE?=
 =?utf-8?B?QVdOUWxaalErTGRBZUdvNHRhZ0JldmhjMVFHT1Z1SUEvU0JqWWxXVFk1NkZZ?=
 =?utf-8?B?V1F3WHRBL3VCNnR0UWR5Ym9sWXFSdVg4RkhBOW1rc0hHYVBMZmNTcHByMzlN?=
 =?utf-8?B?QjhsUFZkQUpsWmZSTjZNb2d6RHp5WXp6Q2I2eWRHd3UyOWVrbDJPdjB6L2pt?=
 =?utf-8?B?WEc1ejRWL1pxSTQzN01UaitEQ2V3MUoyczlzZFViTzVKZDUwT01seE9LTGgy?=
 =?utf-8?B?eWdLT3hFaUpvSEtzUnhaNVBSL2pjT1h5bmIvMXMzUnA5anNFbklYN1p4MCtm?=
 =?utf-8?B?VFNoc0ptUC9kU080cTl5Z2RxY0pFWE5CWjV5b1RJQ3grb0tDd1Ywd2Y0TFAy?=
 =?utf-8?B?US94Z2pIL0ZETmk4SjZsR2FyRCtYVDAwSlk1NWU1OUhLT2dhVTZ0SitLTnZw?=
 =?utf-8?B?Q1BsR21VSU1iaE91cy9HL0pLNGN3L3VKSlFGYjU5QXRMaDJZd0NOSmVicEFp?=
 =?utf-8?B?V2R5WjZTY0pvV2VHa21tRWhqdjIvNjRRV0NKQ05OYlEraXA3L2ZSOUJmSlZK?=
 =?utf-8?B?Y0Roc2REU29RSVE0c0MzM0hCelZwRFU0SlZlSGZFdm1wVTVjTEtLeGdFc3V0?=
 =?utf-8?Q?1jLjHDZi3PDRqu7KfME3ED6LANrNKc6kDO4TjT+?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR12MB7663.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WDdJWXUxelNUeDgxb2lNUW5ZZU10Qm96NUd3M25lUmltNFZGZlFOOGhoNG90?=
 =?utf-8?B?NGY1TG5WV0FpUUVkdDlGRktDQXBZMnVSREJndGtDRzNYOFJFT0V0bStab3FV?=
 =?utf-8?B?eXB5TkJsbGFtZVpVMWh0OUdxT2Z4MXh6bkt2U042RzErU0tXZVcwNVcrTDdw?=
 =?utf-8?B?NnpHYU9acy8xdGN0YTRybG5PM3VRMFFsZXUwTnV4bmo3WDF4TThiY29KSkto?=
 =?utf-8?B?TnViQlRyb1VOVkVKMHpEa04vWTRUaW9yaStOQmFVbkNFZ25sanNsMnN1TVRy?=
 =?utf-8?B?OUYrc0tQSzlMQk5sOXpkV1JwQmM2S05WTUJicHlKall0QTRFYjlUa08rMkI3?=
 =?utf-8?B?OTcxSW5hTlJBZkxrbkJsdWpEb295K3h0TnJGeXU1aUFoSzJabXh2dVlUY2tJ?=
 =?utf-8?B?Q0FCeEIwK1dXT0N2WXRhNmhLTm11N3BpdHMxMlNFZC9ZV2luWVNXK204bDJo?=
 =?utf-8?B?QW1rN201YTBxdzROVXU5ZmtmL1BqK0d2Z2xmdkF5SnRzK05qc3Z5TndKdHdZ?=
 =?utf-8?B?ZHppanpPSUVaSG14STA0bTRBdkxXYzNEMU5lWjRxKzhSZEZESlAvYVZ6b01X?=
 =?utf-8?B?bTNJUUwvUDIxQkVkK1FqdnZLS3ZvbkRoTkxOMGhzL2JkVkN6Q05YSnBNa2xJ?=
 =?utf-8?B?amI2blNVakdiYk0xMTc3Y1JVTFVmc0xNNk03cCs5UWo2clI3ZjVZMVhPWTh6?=
 =?utf-8?B?YStVVldmb3FaK1JJRG9TWHhRbHlRODhlSG1LaFNCSjBRdlNZY2lRNmtVdnFJ?=
 =?utf-8?B?SXpSRzlIMS80cHhoTllPcloyYmV2bjZaZ0J4Y1JGa1JCdTlrbXpzRjk5VnRh?=
 =?utf-8?B?Zk1sczV0d3FtblFKUU9pVHBVTVBYS0M1aXZqU1hGL0ZUTENkUTR4ZEpOd3lQ?=
 =?utf-8?B?bFZ0cUptUWVDZElsN0pCaEM4RDBBNkhCQzRURTlBN3ZKUUtsalgxUEIyMWhW?=
 =?utf-8?B?b3JjTEVhQXF1ZWxWZkpSakI2Y0NiVktNVjdPekpGWkVDWXJrdTJWY2lIeGFm?=
 =?utf-8?B?WVVXTk9qNFJBVnhIYzhDM25XRiswQjRKZERFMlA0N1oyM29hYTlobDBlbUxi?=
 =?utf-8?B?eHhmTi9EL2tkTGJva0kwanV4dkViQ01NQ0FXR3RhRzh5d2pVWnlBQVNmYm14?=
 =?utf-8?B?OEFWRGdsM20vZWx3a0NIMFlQWFp0OXBJWXZvb2I1VkdHb1BWcHpjb3FPaHR5?=
 =?utf-8?B?Q0R1Z2gycDNqRER2cWZTNllKRWJCd1ErNzlQQTZZZVF1d1g3ZE9BeWhVRkxm?=
 =?utf-8?B?TG5IeXMzUDNsdXAzZmQvUDFtN1Z0K3dickhsTkViMlBuNjB0UEZWc0U5MlJM?=
 =?utf-8?B?eWpTcnVOeDNmS0VFR1RGeFZKZUNENGg5cXdUWlhnWjlTODJ5ZWtzWitHRy9m?=
 =?utf-8?B?cjI0dTd3dks2TzVGTTdNOU01LzN5VElHNWZsYWNnR0FtdWxyM0FvR0FmOUh5?=
 =?utf-8?B?OGpRVFowajJ3SFZidjRMVm9tQ0J0U2NEZk8vYUZiL1VqL3hjSER3bjJkY21Q?=
 =?utf-8?B?MHRLZzBZbFh0b2JDZWRBRGlGUnFRVXNNa2hEbFkxNTRLL0ZVNnRudjN0VUQ1?=
 =?utf-8?B?ck1YTjFiMk5uMGJNbU1QV0dYQnBXdEJHMHY3Z0FXN0tFbDJBK0ZBcVN1aWUv?=
 =?utf-8?B?QWhiNmVBK05abWJFalNrdVFSaUNVMHFta0tIV0VFdkcwUXNia1RyL2dOcExj?=
 =?utf-8?B?cEt1WG93UHRYYTZ5VUN2ekt3N1hyeUdIUnVIa3pJWVJ5V1hzNHJPY3dlYllL?=
 =?utf-8?B?T2pqV0YwbVpYaDZxK1NaR1hmNlByNDB1RThFVnJRMEd0eTBicHJNdU5SMHBs?=
 =?utf-8?B?VlYrMWFxWkpkemcycXZqUHl3S1ZIcS9oZUJkNjhiZ0lJa1pwTy9HeGZmRFQw?=
 =?utf-8?B?U2JwWHJjamMvdm45a1IzZitSZ25tTlVWblpwVUpDbjdBTmtoM3lEQUN4aklK?=
 =?utf-8?B?dUdycGJLd0luQlAzdm5ZdHJFWDE0OVdxU1d4TWxpaWtEZnZQQTNPWE9iaTJ0?=
 =?utf-8?B?NU5pSzJZNHU3NlJMM05oMGlRekZ0Yi9nRTc2Qi8xNThVK3o1WVYxTDlDNCtL?=
 =?utf-8?B?a0kvbDd3cUtlc2NQc1Nid2RObkJQSDNYekZXbnBIalcyWXU4dzV5dGF2TFFT?=
 =?utf-8?Q?uDfAphha93L5o09DMDoYwkgKc?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9979f647-1361-4eb9-1583-08dd054bc3bc
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB7663.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Nov 2024 08:01:52.2472
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3udjCJl8F8hpBrxwxS1AjRvO6zA3cSCQcCPrNmMMUe6kWmDoeMUR2i0OvFgj6JaFrWqobpTFZMRCI7pCJDpAPw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7268

On 15 Nov 13:50, Yafang Shao wrote:
>On Fri, Nov 15, 2024 at 12:32 PM Jakub Kicinski <kuba@kernel.org> wrote:
>>
>> On Fri, 15 Nov 2024 11:56:38 +0800 Yafang Shao wrote:
>> > > On Thu, 14 Nov 2024 10:17:11 +0800 Yafang Shao wrote:
>> > > > - *   Not recommended for use in drivers for high speed interfaces.
>> > >
>> > > I thought I suggested we provide clear guidance on this counter being
>> > > related to processing pipeline being to slow, vs host backpressure.
>> > > Just deleting the line that says "don't use" is not going to cut it :|
>> >
>> > Hello Jakub,
>> >
>> > After investigating other network drivers, I found that they all
>> > report this metric to rx_missed_errors:
>> >
>> > - i40e
>> >   The corresponding ethtool metric is port.rx_discards, which was
>> > mapped to rx_missed_errors in commit 5337d2949733 ("i40e: Add
>> > rx_missed_errors for buffer exhaustion").
>> >
>> > - broadcom
>> >   The equivalent metric is rx_total_discard_pkts, reported as
>> > rx_missed_errors in commit c0c050c58d84 ("bnxt_en: New Broadcom
>> > ethernet driver")
>> >
>> > Given this, it seems we should align with the standard practice and
>> > report this metric to rx_missed_errors.
>> >
>> > Tariq, what are your thoughts?
>>
>> mlx5 already reports rx_missed_errors and AFAIU rx_discards_phy are very
>> different kind of drops than the drops reported as 'missed'.
>> The distinction is useful in production in my experience working with
>> mlx5 devices.

Yes rx_missed_errors is lack of software descriptors, please don't mix it
with hardware pipeline FIFO discards.

FYI: mlx5 reports more discards related to pipeline see below, 
especially for per PF/VF buffers. When these are advancing, usually they 
indicate congestion control issues, for example pause frames is off.


rx_prio[p]_buf_discard	
The number of packets discarded by device due to lack of per host receive buffers.

rx_prio[p]_cong_discard	
The number of packets discarded by device due to per host congestion.

rx_prio[p]_discard (rx_discard_phy is the sum of all rx_prio[p]_discard)
The number of packets discarded by device due to lack of receive buffers.

That being said, these are not errors, so reporting them via rx_xyz_error
is very misleading, rx_missed_errors is a special case though, and let's
keep it that way.

>
>From the manual [0], it says :
>
>The number of received packets dropped due to lack of buffers on a
>physical port. If this counter is increasing, it implies that the
>adapter is congested and cannot absorb the traffic coming from the
>network.
>
>Would it be possible to add this description to if_link.h?
>
>Frankly, it doesn’t make much difference to end users like me whether
>this is reported to rx_missed_errors or rx_fifo_errors; the main goal
>is simply to monitor this metric to flag any issues...
>

not rx_missed_errors please, it is exclusive for software lack of buffers.

Please have a look at thtool_eth_XXX_stats IEEE ethnl_stats, if you need to
extend, this is the place. 

RFC2863[1] defines this type of discards as ifInDiscards. So let's add
it to ehttool std stats. mlx5 reports most of them already to driver custom
ethtool -S 

[1] https://datatracker.ietf.org/doc/html/rfc2863

- Saeed

>[0]. https://enterprise-support.nvidia.com/s/article/understanding-mlx5-ethtool-counters
>
>
>--
>Regards
>Yafang

