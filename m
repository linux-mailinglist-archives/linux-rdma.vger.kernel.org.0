Return-Path: <linux-rdma+bounces-12138-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 97410B040D0
	for <lists+linux-rdma@lfdr.de>; Mon, 14 Jul 2025 16:01:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 14CE4161625
	for <lists+linux-rdma@lfdr.de>; Mon, 14 Jul 2025 13:59:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B73A1253956;
	Mon, 14 Jul 2025 13:59:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="DSqk3SQe"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2059.outbound.protection.outlook.com [40.107.212.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D664A1EEE0;
	Mon, 14 Jul 2025 13:59:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752501565; cv=fail; b=RXE63y8UGNqaXrIM0hP310zdLrreBV4h5yvR1RGjPtum9HZeqtn+ejwHCqdZc00QD0sqeK9sCZf995eKPFzuHGgpTynF2UZEzdkJ1ME0TZDozy+g2j1X5YkODenFQVigNRy8uVVHeDyg0GnyURBpBXWeNB56qOlr4KNdqC1ui5Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752501565; c=relaxed/simple;
	bh=lMW/e0hemC6kJpDhUwaHHcqCJjaeyWOXBOT+8UFA9sk=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=IQH0DI//0DC1ppdTXTd58mQrVOiH0xmgyqNyU7Q/c0Ja8ckCeUqYSzKScWYWfwAIlYl+EkK/ke5R34s8aPtPfYZAgSByZBeMLcqikVuaTfTXIiuTlgmPx0ccSHAClcYv8QODwM50tbIU9VW7zIh1MsoRWhRpVNONHLe05A8DbPU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=DSqk3SQe; arc=fail smtp.client-ip=40.107.212.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Dr9KTHdmgWBEE5dPf2vyPJOuMsteN45s8gTn0v1zhzFLI5x3Fsx0jyAiemZ29NQZ0MMZXmgOTOSir7VdonfQC0Xal2rILq+tNSQ8txKzeeWoGUNC9wrRfGnsocz/aqRBZraKkcmoEq0H/WQWqkZcOLrerwpPel4F5t9KRcvKgIhp1Q4qsL1WE3WqcBQBGhHx/TxWemfpP4ZjAgVGcqvEyoqTdybHqsW7n6p1J6ahP3AUhB53jI85cAps2wDjaFAhZ58BdcGfv289yblDvTF5OBFIt5G5fxqvT4lojOfe+UcjWSbY9W9OX2YQN/9nsZAYgiEK0PeE0ox3ATQUd6BIjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ri9RFYe7JW0OrsrfeNmik9tX22s6vfwXU89H5iuuVH4=;
 b=JgusirsdxJflIuRnPNKx9wSx9ruKhZWlqKUAh5sXvouJf6RLINSuWg2rSkmz/JU327p2B6VBJRxri3WviwNN8VLf5qkHtmFb9wbdmEsWLsSDNthusWXMRMoN1ahzxGNMfVYs5LrntjkDvHTbl/pnq005YUxLD2BkdyJ3fVv7WtAlQIvUR8PsnDa4j4vLdrADsfIOOqIXUiIH5oHf/H3d0WXBF3n5Hn3ApODX8eLTa1UF4oDqGxp+L9UT8xfOndv/04FulFF/tUDTiVoje3z0yEfqAML/RoQ13RAhpb9GfiYSKeiDoGzObQFBAI5x82r+CQNCbvNXwQllnbfLKU4Q/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ri9RFYe7JW0OrsrfeNmik9tX22s6vfwXU89H5iuuVH4=;
 b=DSqk3SQeVZAg73eVRwRwth7p5DR/ku+rI6pt3wLgtRE21qN6BoBsycMoeLGHy1mbhb3craSqXefMFZ1doYFMVPSdVKT1u7wDhUynuEtwAkqN7xR99lajbx+LQarhS2iaqj/CK8wErI8Dy01nGMvpcf2fSkq/t5XTzBPV1cSvnFWFATHrAg1yKCVfGJX+xBBJ6X26g8iRxP6HNniKU6DcTQdN+t1SW04OxTCo1lUzyqGAsXsjJWaiOgHxgb4QbZ75r589V0frL4urM0W/5xEabRs3vAghchN3BCrenudOmCn32BMCTyd6p2t+irJepgxsn26Ak/5JjtkIuJq63bCYvg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB7500.namprd12.prod.outlook.com (2603:10b6:610:148::17)
 by LV9PR12MB9830.namprd12.prod.outlook.com (2603:10b6:408:2ec::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.25; Mon, 14 Jul
 2025 13:59:20 +0000
Received: from CH3PR12MB7500.namprd12.prod.outlook.com
 ([fe80::7470:5626:d269:2bf2]) by CH3PR12MB7500.namprd12.prod.outlook.com
 ([fe80::7470:5626:d269:2bf2%4]) with mapi id 15.20.8922.023; Mon, 14 Jul 2025
 13:59:20 +0000
Message-ID: <aad6feb4-f0b2-46b8-bf40-35d54807572d@nvidia.com>
Date: Mon, 14 Jul 2025 16:59:14 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 2/2] net/mlx5: Avoid copying payload to the skb's
 linear part
To: cpaasch@openai.com, Saeed Mahameed <saeedm@nvidia.com>,
 Leon Romanovsky <leon@kernel.org>, Tariq Toukan <tariqt@nvidia.com>,
 Mark Bloch <mbloch@nvidia.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: linux-rdma@vger.kernel.org, netdev@vger.kernel.org
References: <20250713-cpaasch-pf-927-netmlx5-avoid-copying-the-payload-to-the-malloced-area-v1-0-ecaed8c2844e@openai.com>
 <20250713-cpaasch-pf-927-netmlx5-avoid-copying-the-payload-to-the-malloced-area-v1-2-ecaed8c2844e@openai.com>
Content-Language: en-US
From: Gal Pressman <gal@nvidia.com>
In-Reply-To: <20250713-cpaasch-pf-927-netmlx5-avoid-copying-the-payload-to-the-malloced-area-v1-2-ecaed8c2844e@openai.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TLZP290CA0011.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:9::19) To CH3PR12MB7500.namprd12.prod.outlook.com
 (2603:10b6:610:148::17)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB7500:EE_|LV9PR12MB9830:EE_
X-MS-Office365-Filtering-Correlation-Id: 8709e917-7f3a-46ad-44ac-08ddc2dea12c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|1800799024|7053199007|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SEJ4Rlc5cU9QY1BROTFyamxaSUhOZFFxa2FkSkNyeWp5UjNkMVBTRTRXR1ZU?=
 =?utf-8?B?b1p2ZGZpTlVZZG52Nzlxei90WEo2SzBTTk85SjM3eFhLK1J2VzRZSVY4d1E5?=
 =?utf-8?B?b1ZhWEhyRlJHWHlCZHpScE9zK21oVkl6K0oycnE2RTYyK2dwV0ExYTVwWU8r?=
 =?utf-8?B?anE3dGNnZGZHMlhaR0wxeHVCK2p6MlZPVkY0TWh3QUNYdmNBVXpvTVVqckY3?=
 =?utf-8?B?clBQeGREaVkxQzBjeVJkYTZ5OU9mN09VZ1dMSE1FM1RTOXRvdkdYYURpSi9R?=
 =?utf-8?B?QnhrWkZTeVE0TmVseGZIK3VDMXJOTHpTWTE2WUxBRU8xTVZCcTlVQ3BxcnNN?=
 =?utf-8?B?WTJHeDRZQ0hSNm56U25hM1NQcjNDbVZJOVV6TEcwNFNVNFVteUZUNzZwaVND?=
 =?utf-8?B?ejE2TWlING56UWNjaUhZNi80RDR2a2tPQzlMeGpaYU4vdWRxUU5ub3RldFlX?=
 =?utf-8?B?UU1pc1lnc3h3UGc3eEdNVFF2REFoZk9KTTlRWGFtOU5MZHY0U0FoaCt2SWln?=
 =?utf-8?B?YkxEU0IzdDZ1V2RydjZVUFE1d2ZSaHJ4dDJvemNKZFNEN3lGNkxrSFNxRzJj?=
 =?utf-8?B?dEVUTHBmVndDbHp3WTZPdFBLcjVuSkNVUmcxRnVKdTdiQW1MT0NWUE5udkhI?=
 =?utf-8?B?QUJQRXlCTm9oazA1VGcwTWtvUWlBOEdLSlFEMXRuSmNnSkdnc0RTb1AycldQ?=
 =?utf-8?B?RmF3aGFmS21QcGdLZXhKdzZmVThqM3drdkJOb2VXbVVlU21RZ0IrZ3dWbHps?=
 =?utf-8?B?VEt5N2RyNGVuMjN6cEY2MTU4MXpOSEdKQmdGWTd5VXEzcndhTW5jenV4ZlNa?=
 =?utf-8?B?RjZvVVFkOVVSOGpZazBFeU9KckJ1dEtFdjRzSUtZU2VTeVVHMDZKc3VuRDNU?=
 =?utf-8?B?ZkVOL0ZVMWpPRHB6ZVgwSmNsZVJiSXpLY1FzbUdvK012bzdydVJyVS9PTC8y?=
 =?utf-8?B?UG9JSVhoZzIyY3ZWVmNwY0RKeWlKVW1PU1ZjdCt2T1dTZkNrQlpmaTZLSTI4?=
 =?utf-8?B?bzlsZFQ5ckhiN1FNcm1xRll4cG1iVW95M1JkbjROWUpGNVd0YnU1UVdWMVFa?=
 =?utf-8?B?S0xOTEhzbkw4U0lHWDVwS05LWm5JZ01zWXBvNUQ3KytON3VzUVRVVjhwM1cr?=
 =?utf-8?B?OXN0YUVjZWdWaEV3M2N5WVdTZHFpbEducGJxVjRLdHZyUUxXRTEzdHAzN1NX?=
 =?utf-8?B?d1lqMnFySHluOG5mcSs2RHJzLzQ3Nys4NzhCMjBhWFBKdExURlhicUtLN1pu?=
 =?utf-8?B?d1IzbHpUcTFDL2c2bEwxTXV0WTRneXZLckl2Z2ZNYW42ZTVNUEl5Y2dNRERC?=
 =?utf-8?B?Y1JSdEFzbTZRbWI4a29ZSFhFcFJ0VkpKTW5qdjhybnlHZVlrbmNCN1FoalJL?=
 =?utf-8?B?WkNpNDQrT2g2NXJ5UnpRZVNEZlNmR1ZERU9XZXZqM2tIWUt6MnIzWDJuYmx4?=
 =?utf-8?B?a1Z1RmdxWjd3RHB2UmE4c3ZQYlhJMDBzUnB5a0xiakhRVWVjdEwxdzAvUE96?=
 =?utf-8?B?NmlPOUlZZUtibTVibGFTeHJUd3FrZlQrTGVjZnpHOWFzM1dscEFHRmVYVG4y?=
 =?utf-8?B?MFgwdVhZNy9CWFRublBXeHJGbUtCaDZsRTFwVmNyb0xNWGk4WVFGbzdmZngy?=
 =?utf-8?B?M3NGRW1jYXNiNkZqSGxDQjMxcFR4R3Z6UUlGakExZEV5U3BRMk14Ui90Y2k1?=
 =?utf-8?B?Tm96elhBaEJ3RzM4U08wZHNDdXVkV2xob1lSZ01qZEFmRnZ3QWZLandURHQr?=
 =?utf-8?B?U0x2ZmxEMnd4eTZEaXBZRzE3bDBCbHNjTjJrVDIwL3l4ZUdtZVJOc0NuQkVB?=
 =?utf-8?B?QWpUczlvTXJrTEk1aVc4WFk4aUxKUU51WGcrcnpSVHBycDJDeUZxd3BqNElP?=
 =?utf-8?B?ellETk9lMnQ2Z1RUTlVpVVhPZkZ0UHdRbnVHcDdnazQ4ZU12bXI2VUl4NmJG?=
 =?utf-8?B?bk1VN1I1dWtOOHBpcnlWNE83bDAvSVF5aVNCazluVnpjTkZhL1ZnWWMreG5a?=
 =?utf-8?B?cTlkM0xzWEVRPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB7500.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7053199007)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bzRtWm1rOFJKZjh5dllmVHYzZmdveHJYcUdtSG16czhHT2NYVTJaV1g3K2Jk?=
 =?utf-8?B?eGdPTUNSNzRnUzJKR0FteWg2NjQvTEpvSHdjcUhpQnNMUHhxMFRkZm44N1Rx?=
 =?utf-8?B?WnFvL0xOVGtZVXBFdkZ2NU9lUUV0cllWSDlkVlliWFg1QzVmQUJVakJ0cXRF?=
 =?utf-8?B?bkZLWC9adEZrNkpKdGxEMmttby9jVE15Wk5wei9qdVJ5TFQ4RVpBQnNCNzVk?=
 =?utf-8?B?Z1dMSmJ4OXUyM0s3U2RDMWJ0TGVyQ2JNVFhKdzd4a0hKVVdCbGVDNTJTbUg3?=
 =?utf-8?B?U2R2NTB0eHhQLzF2dmhPaHlyd01FZjVKQ1RNQkxFSHRnS1B6aFVORkRxbFkv?=
 =?utf-8?B?RnRPTG9iQzgrUWlkNmExQTIvWlVzZXh2YklwLzBLV1FYQVlZKysrbDVkQms5?=
 =?utf-8?B?SHNBL2FvV1hvUTNpNlF4OEJOampEMDRZSlpiOUkya2FxK1V6NVU5SkNMUEJB?=
 =?utf-8?B?N2pkb0R1QldwM2wyeCtheitSWTQ5Rk0xMmRUZENnMDhaalNrWUl1SzJvSDB5?=
 =?utf-8?B?RXM0RnQ3aGJmcmx0SFJUSms0L2JJcUJ2bTVuVGw4OVE4N1lsWDYzUjI0a2h4?=
 =?utf-8?B?Nld4SEZyaVJqVm9rT1ZFWDczWUdncWg0VG1UY2FhT1JTTXpPWDY2VXB2aWxV?=
 =?utf-8?B?cmJ4WWVHUDJ3aWdiSWRiRm15eGY4R2JBSzQxQWZ3Q3hUem9UV0R6NlFyT3lp?=
 =?utf-8?B?OG4zM0Zpc3VmeTV1clZHUk83ZExZejI3cGo0amxCWCt2dEhOVlZoQklBbGhS?=
 =?utf-8?B?dndhN3RoUVRRK2RhTUo0WEdkb2l2blJYL01XZ29zTUVRWXkvb2tEUlhidHNL?=
 =?utf-8?B?UksycXVrNmY2SjlQakRobktBMDZGbXFJL0Vjc0ZkVkRJRlNzdXE1YURjRzFy?=
 =?utf-8?B?NWEzaURlYWRjZlVTT1RTYmRnNG92eTk0TThsZ0ZESTVRVW52ejFoU0RFbmlI?=
 =?utf-8?B?SmVKaW1UZnNJeFRrQmw3ekV5b0tnRmhHUjRRTitUV1lIaS9BbnhPcmxLSmdy?=
 =?utf-8?B?ME0wTmhNT3pLR1JNNys4NXQzNkNkZlVrODdmTkxNaDVqbTJGY0FuOS9sdTV6?=
 =?utf-8?B?dC9sM2tWV0RtTG1nQTJDTWVRaXZObUtuTkg1ZVh1MmRrZ0pIOGJuMlFYOFk0?=
 =?utf-8?B?Qi9KbGl3NmFKYkExRytVbTdQMlRra3hqRytrYnJSSlF3ZnBOK1prMStUZUFS?=
 =?utf-8?B?Q3QyRjdYa2hqdU82RDdxbEJsRjk4TE9yRHd5NmVwUXNlV09Dd016Yit1Kyt0?=
 =?utf-8?B?S0ExN2YxOXN3aWZTbmpidFIzNHoxNjdienoyY1o0TWNJZmZveTVNY0I1R3RS?=
 =?utf-8?B?MGo4RVh0VXJTb1RyQlJwTlRTZ3JHSXBtZU12VmhCR2o5djkwdXJMd1QwUVB2?=
 =?utf-8?B?QjhUa204Q3Nkd0FHR0NGWDROMWs2SHAwS2FTa25xNmxSWS91Ni9qY1pmUVBN?=
 =?utf-8?B?dy9mWWpzUENsRGZTVEFvczFFaG9hbGJ6Qys1b1AxeElYeVEza3U4MjNhWCt0?=
 =?utf-8?B?NGExRVpQRk5IMHlGRmlrWHhURWQrNGVra01BMEVuQmhpSWxOejFGb0VlSVE2?=
 =?utf-8?B?Y3A2Tk5kT0p5YStpZFpoZ3NqN0ExYmtJVEdLc3BXTjg1NjJBeHBtVDEvK2Nh?=
 =?utf-8?B?ODNTOE04TDFpWWVJYUtIMmJOUzlrZHNYNGZqV2R1WlV4TlByZ0RZdkMvK0Ez?=
 =?utf-8?B?ZGJkdWlZL3NpNzhKWDh4ZjBnY0NVUnYxRmxrWE0yKythbW9kejZ3SjJHWTh3?=
 =?utf-8?B?ZEJPeWR3cndOQ0kzM1paL3BBQWpSeWJxMDNsSGo3a3ZJVEl0QTUwSit6NHdE?=
 =?utf-8?B?ZHFwMU1ZM28wbDBUTzJDbkRnNDhaZEFDUlNmeVJrZXFiUXp2bnNmZ0gvU3I0?=
 =?utf-8?B?WHY0N2N2eHQzZTl4RTU0ZFNOS3E5aCtialN3VjA0c0k4cDZWTkFLT3Y3SEZa?=
 =?utf-8?B?UkVlZlJKUGtaVERsdVlJOFczYlA1aTcrNHg5WlhsUDNGK3YrS1JnSkIyU2t2?=
 =?utf-8?B?b2x3RGxleTFIQXU4SGdBSnpCNFJpbzYwUmkyRkUxTmE2Z3FmdnB0MWd0Qzh4?=
 =?utf-8?B?b0dVaHFPSXJZcnFUWVRvbVduakZLM1RYUkxpeURHK0I1UUVpWEluZDJoTmVk?=
 =?utf-8?Q?Ch5UiDid0m9XiFmeaVMwKniia?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8709e917-7f3a-46ad-44ac-08ddc2dea12c
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB7500.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2025 13:59:20.2543
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +a4LiCnMIEoBeNrQoVAaLwd0bVaape/O202JfXonlAalt/0fAW87cK2lvPL4wAgn
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV9PR12MB9830

On 14/07/2025 2:33, Christoph Paasch via B4 Relay wrote:
> From: Christoph Paasch <cpaasch@openai.com>
> 
> mlx5e_skb_from_cqe_mpwrq_nonlinear() copies MLX5E_RX_MAX_HEAD (256)
> bytes from the page-pool to the skb's linear part. Those 256 bytes
> include part of the payload.
> 
> When attempting to do GRO in skb_gro_receive, if headlen > data_offset
> (and skb->head_frag is not set), we end up aggregating packets in the
> frag_list.
> 
> This is of course not good when we are CPU-limited. Also causes a worse
> skb->len/truesize ratio,...
> 
> So, let's avoid copying parts of the payload to the linear part. The
> goal here is to err on the side of caution and prefer to copy too little
> instead of copying too much (because once it has been copied over, we
> trigger the above described behavior in skb_gro_receive).
> 
> So, we can do a rough estimate of the header-space by looking at
> cqe_l3/l4_hdr_type and kind of do a lower-bound estimate. This is now
> done in mlx5e_cqe_get_min_hdr_len(). We always assume that TCP timestamps
> are present, as that's the most common use-case.
> 
> That header-len is then used in mlx5e_skb_from_cqe_mpwrq_nonlinear for
> the headlen (which defines what is being copied over). We still
> allocate MLX5E_RX_MAX_HEAD for the skb so that if the networking stack
> needs to call pskb_may_pull() later on, we don't need to reallocate
> memory.
> 
> This gives a nice throughput increase (ARM Neoverse-V2 with CX-7 NIC and
> LRO enabled):
> 
> BEFORE:
> =======
> (netserver pinned to core receiving interrupts)
> $ netperf -H 10.221.81.118 -T 80,9 -P 0 -l 60 -- -m 256K -M 256K
>  87380  16384 262144    60.01    32547.82
> 
> (netserver pinned to adjacent core receiving interrupts)
> $ netperf -H 10.221.81.118 -T 80,10 -P 0 -l 60 -- -m 256K -M 256K
>  87380  16384 262144    60.00    52531.67
> 
> AFTER:
> ======
> (netserver pinned to core receiving interrupts)
> $ netperf -H 10.221.81.118 -T 80,9 -P 0 -l 60 -- -m 256K -M 256K
>  87380  16384 262144    60.00    52896.06
> 
> (netserver pinned to adjacent core receiving interrupts)
>  $ netperf -H 10.221.81.118 -T 80,10 -P 0 -l 60 -- -m 256K -M 256K
>  87380  16384 262144    60.00    85094.90
> 
> Signed-off-by: Christoph Paasch <cpaasch@openai.com>

Cool change, thanks!

This patch doesn't take encapsulated packets into account, where the
l3/l4 indications apply for the inner packet, while you assume outer.

Also, for encapsulated packets we will *always* have to pull data into
the linear part, which might overshadow the improvement you're trying to
achieve?

