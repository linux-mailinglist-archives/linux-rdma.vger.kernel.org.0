Return-Path: <linux-rdma+bounces-7150-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AD735A17DDC
	for <lists+linux-rdma@lfdr.de>; Tue, 21 Jan 2025 13:36:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5336318868B6
	for <lists+linux-rdma@lfdr.de>; Tue, 21 Jan 2025 12:36:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4696B1F1927;
	Tue, 21 Jan 2025 12:36:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="T67C3wj7"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2071.outbound.protection.outlook.com [40.107.220.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82D601F03F2;
	Tue, 21 Jan 2025 12:36:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737462998; cv=fail; b=tw3V7/CBVQnVI8agU0X5eUxQpncQ/9Bohnw2f9kIfCPtBc+JNBfWxcOURsFLu4e3t463RHUp8VKS4+Uo/ukDzsazyvG0HkAn1v3EjCTDDFmRjbVdSLQ9uTXR0Ic/MpJWDw3EkX4J9fwvceKqYLLACWg5wYgIIlAtpCtU51pUo6w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737462998; c=relaxed/simple;
	bh=2gaFYvU4WS/oQkV6kGtciOp5N9CRCpT16349hePnfsw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=RH3+sMXdN6Ryhwk1DobA/2nkDpOkCuWZkA2NFZRknbAVXTQC0RjQrkKkd5oQ1v6k9qe8g9m50Ej7wySMM3upRhKF6WHMb0XMxFwR5OsDYtfxTkf31ioRPn1r+8aMC6PHM1HlWTsr9OJ7hy/b6RP7C+DG006x5+1/kgFAb3UnDps=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=T67C3wj7; arc=fail smtp.client-ip=40.107.220.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mSrS7DPSRmSMxhqMf7XCa2EbEr+ZYEYpEfCPLi6SX4LqrTmUI8r290t1nP81pDoZxjz0zfLI48KzjlfG8me/6KKD8QUFCH+L1WDTediIaT8kd/9AcV7B466vT62f2867+jJtwYXAFVdNOfng60dSL3aTWMyjwY+T0UGL6k1xW5HDyHMA5g/aSXA2Az/7ljlkDJzbZ+JNn/VQaCPgKGLwe8ppr57//MMrcX7wrkVix7Dpo06EeWo+3HKvLRjOR7OXm7obKWWfjUrKi+65yGEXUrJRkKloAJtQc05bRGywtf17tCmQDDDuow53GzAk/GaNsEc0Af6qSyN0Gqy37nH3fg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BOIeD7ljDWnhGqcDTHAs9qRIt6bHfcvlMTO+Qmrhob8=;
 b=LBeWlZVuIasEuc3wNszRNNsw8majrmIai7WeRcQjGWOSVnVD0F4zhSbGbIE47gZTq1C1KdW8ZFP7MK7YYpkeX45/xRzJVxf7Eje+hbZE/eS36mwdPI+aSSeUvGsLVDo01wEhDeO696BBYoa8AvspIPJyqy7LuFaeTjp09QUJwfpj1RExJoEjVUfP5TG6cPIqjClLZt/Cneyt0eO176sEWKHGYq7MBh2q62/vCAdMRK21yuQkdRb5XVxviujFV+PtZ+igGvzZVweGS+a9LapjJgckD4Y3RoBWITWDtZZaSTJRVVwzfkOTEzcnveHeqYBVbCNEJk+kW1hciP4yP6ygWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BOIeD7ljDWnhGqcDTHAs9qRIt6bHfcvlMTO+Qmrhob8=;
 b=T67C3wj7eBz12zgBBvIv35lVCqQ59VB44rg0dv5zdDWn5Wff2ue+gV95b4zhB7AcRbRy3WpGNaV/azuHzdYyJ+wekxH/FQDrZRyfnLi2yBluU29ORPaB609BM3I5uGV+sQrkJT0fh5Bby3BFvurbb1+VtJkVqvd0pOLbnQyxRm2c1QGhxmWRDZx9x13x+l/FwOyhv6UjOCOwtitZpIM16QHbbrXTak08ABE7M9YbUnS87I+biCI0IBDA4oKF8qMqaZh4fJgDcUqElnY4B4mVmO1QT8XagHtF1NxXdSbNtWgaTM4Y3tQ7sUncJdcTNzCVxzczNtBCjxDplw1L5sagNw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MW4PR12MB7141.namprd12.prod.outlook.com (2603:10b6:303:213::20)
 by CH2PR12MB9519.namprd12.prod.outlook.com (2603:10b6:610:27c::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.21; Tue, 21 Jan
 2025 12:36:33 +0000
Received: from MW4PR12MB7141.namprd12.prod.outlook.com
 ([fe80::932c:7607:9eaa:b1f2]) by MW4PR12MB7141.namprd12.prod.outlook.com
 ([fe80::932c:7607:9eaa:b1f2%4]) with mapi id 15.20.8356.020; Tue, 21 Jan 2025
 12:36:33 +0000
Message-ID: <a76be788-a0ae-456a-9450-686e03209e84@nvidia.com>
Date: Tue, 21 Jan 2025 14:36:25 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next V5 07/11] devlink: Extend devlink rate API with
 traffic classes bandwidth management
To: Jakub Kicinski <kuba@kernel.org>
Cc: Tariq Toukan <ttoukan.linux@gmail.com>, Tariq Toukan <tariqt@nvidia.com>,
 "David S. Miller" <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>,
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
 <1e886aaf-e1eb-4f1a-b7ef-f63b350a3320@nvidia.com>
 <20250120101447.1711b641@kernel.org>
Content-Language: en-US
From: Carolina Jubran <cjubran@nvidia.com>
In-Reply-To: <20250120101447.1711b641@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0153.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ba::14) To MW4PR12MB7141.namprd12.prod.outlook.com
 (2603:10b6:303:213::20)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB7141:EE_|CH2PR12MB9519:EE_
X-MS-Office365-Filtering-Correlation-Id: bbc8590b-ef47-4506-6827-08dd3a183cd2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?emVOT1Q4Z3pjaUJqTGVuQTREUW9KMXBKSFp4MG1sUVRjb01DWWIraGFsckFD?=
 =?utf-8?B?anJFZ2dWZFBoTjdRN2JBZWJFMUVJdkVUVnNRK1YyWHhhbWpoMGErRmNnNUUr?=
 =?utf-8?B?L2F3QVRFNmJtTzVkcnBDeVlzUEZJNmsySk5UbWtQSkdYSlBzWmthb1J2TEk5?=
 =?utf-8?B?dUd0YXhDRjVxbktJY1BrMHRnWWhtZ29PaGRud3c0eC9rSHRaYWQ0dDRpdGcv?=
 =?utf-8?B?Z1JYUGdjWHYra1VQb2FlT2pHbmdKb1dsRjFHRlYxSkFEK01MOWtUWHBmbUY0?=
 =?utf-8?B?NDBSR05Bd0NidkdkTEY5UUVRaTJsOEhKWm1JMWRrRnlqYXpMNGpGS0lnSU92?=
 =?utf-8?B?NHE5SXZ3MkFyanBUd25CSndhY1FhTHowZ3VkeFV4MUhsNkJzS2ZQdHlHdnV5?=
 =?utf-8?B?bDBSVUl2L1hUZnFjanAxdUhYVk1ZMms3blkzWC9qdWFHeTd6elFHaXNoVHMy?=
 =?utf-8?B?Rml1cjJ1Rm4wd2N5NnNRV0NvRWN0eEZjemRtc3dlcHhIbC8xWmFjMFRhZExS?=
 =?utf-8?B?ZDVlMkRiaVRGU2E2OGloZERrVlJNdjIvQUF0a0pMUFp4RkVBTHRVUVBpeVJL?=
 =?utf-8?B?bEpCeTFqVS9JZGRMRGI1d25pTjdlVS81QlNTeWdQUUZlTk1TbytLWmpkOXNJ?=
 =?utf-8?B?ZGdsRXJTT1NjaDBwYmE1U1I4Y3N1S2UrUDBsZXpYMHNjU1hOUThsOW8yNWk5?=
 =?utf-8?B?UURRUjNKSSsyS3ZZdmNwMHJ3TytNSUJyOFIrR1NzdG0wQ0pQQ04ycDdWZlNp?=
 =?utf-8?B?c25uUjhCVktqa0N2TGFkVDRHZk1XY0pRYURJSHUvN1ZUTEdYektpcjBhZ2cr?=
 =?utf-8?B?aU5DbG9vNWxOQllDeGVnRGRaZWl3NGluUERZMll5eXpWMFgrbHM0eFNMZlhh?=
 =?utf-8?B?Nk81eldISGJSSXF3aHF0M0lrdm1BMmkxWHpZNjlhRHNLRzFxWUc4RFVRVitG?=
 =?utf-8?B?TVI0Y2lpcXcwUitHOHkzc1BudXBNRld4TFpHY3Zhc0FTa2FONTRCeU5TZjFG?=
 =?utf-8?B?cTdyUVJxOGVsNDQ4UU4wNXlETWtnYTdJTEZPWVJYYU53RTNlWk0zM0o0MnU2?=
 =?utf-8?B?a01PYjRwT2JERHYvUnZmK3M5QTZkcHNNbmJ4US84ZXhRMkNRdGxLL3R4WFp3?=
 =?utf-8?B?N2cvN2ZpVHpHdzZ3a2QraDhGS0ZiWWxDN3RCelZpc1d6ZFVibERaM1QvaTM1?=
 =?utf-8?B?V2x3anM4Zk1vUkZKV2ZvYVhrY1Npd0Z3ci95N0p3c0hKazF5OWpxUXZGWlF5?=
 =?utf-8?B?YlFPL0NqUWwyamk3SWdpcFV6NkRJMUpITnBqaC9qMk85NW03eXdRdVd1NDRY?=
 =?utf-8?B?dnBqZzVRcng3Z2o1WFk0bzBTdjdqMDFoaXBXTm5uUEE1YnhFV29EWjRhaU5I?=
 =?utf-8?B?N2hUZ2MrNjhQaVkzcXdISUJCSVYwM2JwRWZvRFNlZjRGVjBPMVo3OFkvWjhl?=
 =?utf-8?B?TTZVY2xSQjVnWVByTEJsc0VlT01tZHBRaEhVS0psYzZ4MTZVL2xCRTNyNE5p?=
 =?utf-8?B?Z0VjZ2xMR1RlUVNQQ00zb3RRbElvMk5FU1JKWkhKRzhiYWNJeGRnT2F6ZUxp?=
 =?utf-8?B?dkxaeDFDaVJPQktmQlJpeW5WaW5WaDZiWkM2R0wzT21GNGlYVGZrLzU3QUJ6?=
 =?utf-8?B?V1grZlRBbVcvNTRHMkZCY21QREx3aVlyKy95cjFmb244WjB2SS80NWNyNW9i?=
 =?utf-8?B?VHRQT2FKQlNTZ3dMMWJrcTZVaEN5TU90NXBuZy9tZUphd2pqbW9aa21tU1kr?=
 =?utf-8?B?SEdIaTJhdUZ1YkV1enEyZFl1RHNCL2hUd1JZSDdnOEpDSVB4cmthQlpFKzVK?=
 =?utf-8?B?TFFCMVZHZmdDVlFsZFV2S21vY1lNQVlXK1NHcXgzYkswUHZGNFhjUzZyM0lh?=
 =?utf-8?Q?JhSkO/IYH8ijb?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR12MB7141.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UGNxQWltVnhaTDBYYjFLVkZvdFA3bkZhbHhOa00wMzNXbWJsQWRrWndFVVNs?=
 =?utf-8?B?UzRFZFpqTlNjT0RWYXc0ZndUa2JSRmFlcklCaDB0VE5SVmsxTXByOHdWNmZs?=
 =?utf-8?B?QmFZMkNJVDVDcW1XSTJMOHVNYmFCRkR3NGNwQi9lWENEQlIvblIxbjE5SGtW?=
 =?utf-8?B?bzhxSFFMUEZucVhPR2g1V2Y0ZS9Da1RkMGlGakoxcG9CcGlzcTF5QTE5ZlM1?=
 =?utf-8?B?YmRlZ1o2ZzJaSEpXMXhJNWV3NDR6YWtncXdmSmw4Q3U1U3dTOHR4V1EwMisv?=
 =?utf-8?B?eXlpSXkyd1JMRHFsdy9Tek54QlRZcjFGWFJob051VWxOaFhCeWhodEpzekQz?=
 =?utf-8?B?QnV1NmpheG5rd0w0d1dPNjJxaU9BZmpmMlJ4UUp6NmFiSG1PRFdsTlc0Rk5y?=
 =?utf-8?B?MS9PNGZXV2hqMzJLRmQ1Tmp6OThBNHFacVNJU1U4bG5LNGczTWZaeGtrZlcx?=
 =?utf-8?B?aTRYYWcxUzdOK211SWM1aXJwRVBYQ3M3aGMxNVFlL282NkVLMnpKdG5VWjk4?=
 =?utf-8?B?dVBWSjBPNEJGVTQwUS9yY0xxSVB1L0lncDVBSWYyU3YzQmZtL1BRc0Q5b3d0?=
 =?utf-8?B?QWZjUWRvUW5rejVGbVBmRXUvdjZUU1V3WjNPbVhQci9SMWJRNjVlL1crYnNX?=
 =?utf-8?B?NGlUU0ZXQU1hNmtvZlVJQTZUS3FxeGlUZ2lqUFQvazJTM09wN05ESk9EYWtz?=
 =?utf-8?B?a2I1RndhbXY0NGZIaS9aK29qdWt4R1JGbzE1eDlmcFRvOHhzRlR2VXJ3dlBk?=
 =?utf-8?B?bEE3VEVGNm5ibDFDMjUyWGY0bXNYRHc0WFcxRWlXeUpsQWRSbGprNDVpWTVl?=
 =?utf-8?B?NVdIamM0MnZhVEZaRVE5aXhWMzRycmtubjg3L0hDdFRuUS9OcnJBb3N1T1p1?=
 =?utf-8?B?aTRETzVMUGNSRUg0NXdwSC82dk9EcVhZV0YxM1hkbnVRMEI2bjJkWlp4WkMx?=
 =?utf-8?B?Nk9mbm1DdmU5VDcydzRoZWM4ZVNFZk9mVEFOb3RjN1dpUEdSNityS1FwMGpV?=
 =?utf-8?B?R2RMZS9yQ01CVGpRUHlCMXdXNGJRVUdsS3lTNEVxZjUyaGhuODR2TGxhUVFR?=
 =?utf-8?B?eDhOb200WFhQV0Z5TlNlZEREZ3BrSEVJZzRvdENLNC9MdHdkVjN6UDVYT0lN?=
 =?utf-8?B?RVBRU2crQWQ0WmsrL281ZjhRWGo2ZnRvenRPbEZISWZtdzZtSWdCaWR1V1Jl?=
 =?utf-8?B?bGRCTnp2Z3U2UjE1anFBUnI3NE8vOGp2b1FZdXZIbUlZODNKeHVONkRBLysy?=
 =?utf-8?B?cUQrYUQ1UGtiYm0yQ3Z1QzYwM3JZdXptTTk1TnR4N0VObXJJR0pNaWJvYnpy?=
 =?utf-8?B?LzA2ZzhHYTJMVDN0OHN6akNQUlJxOUNRMXZIL2V1ZjNNV1h4SXgrcTFrUThl?=
 =?utf-8?B?MmpxWnZSMEIwTUFIVkZwcVJuTElnMDR0cFJ6aUlFUUJ3c0RUbHVFa2h1NS9M?=
 =?utf-8?B?RGlGVVpnVHNscERmMDhiRHdPQ2RvTTd0Y1dSMXB3Vi9MbER3SHFoVmlYNnQv?=
 =?utf-8?B?LzR2OXZUWW0wUFBQWDcxYW9nZHhBSjNvSzNYMXc3QklBVE5zZG1HbExjcHpZ?=
 =?utf-8?B?d1YyUWZmQjlqWERBUGpxS3dGSFBpeDRiVjM4RjRpU3NCRGF4TFBkREtIQkZm?=
 =?utf-8?B?bzE5cC9QTDNLUTBadXVwaW9LcWVLRGJOT2NqZVBVL0drU2xkQWNvUExvamtQ?=
 =?utf-8?B?NzY1Q2FNb3dIakh6MmRxRklRN2JmcXkrNWo1R2cwWkxXb21mZnIvcUc2eHhC?=
 =?utf-8?B?L01BZ0wzeVo0T2tVdHltNVNEYS9MVFNYNXJLeGtVamdHMDZWV2tkWndxeWxD?=
 =?utf-8?B?REo1MDRGUXBXRlpRQUJHSk5xMFFIZWlaNDRzZlRlTnFLNlhnVEpFdzcvSUVr?=
 =?utf-8?B?OHZBbzc0UWVDZU45T245a0ZWSWJsblRLT0JlUVROb0s5KzJJS0dQcHByc2E0?=
 =?utf-8?B?ZUwwQWpsRE9tbmVUOS9ZZ2tOcWMxTEZLYWttMUJvZTlOaFBEWkZKdHdZeGgx?=
 =?utf-8?B?bEpFc3QvU2dHdndyUGlnU1ZtaTBhaUo4WGUyMmsvUzRnOVVCUlFIUlplQm1n?=
 =?utf-8?B?eXEyNzdYT2Rsa0U1WkpOQW80MGJnNlRnc1FMYno1U3QzUVBuQ3BjUCtGSFg5?=
 =?utf-8?Q?2Vkq2ay7jaOpuxsalxPmjA3JE?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bbc8590b-ef47-4506-6827-08dd3a183cd2
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB7141.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jan 2025 12:36:33.3396
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4I33iNXJDCC1in2t6SWTodqHzQVW0D5QL4UH5dE1T8YGwmNDPPLD2OHOYtmyZzhjY3SKXWY7nuQR2+3qhcc19w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB9519



On 20/01/2025 20:14, Jakub Kicinski wrote:
> On Mon, 20 Jan 2025 13:55:58 +0200 Carolina Jubran wrote:
>> On 09/12/2024 23:27, Jakub Kicinski wrote:
>>> On Mon, 9 Dec 2024 23:03:04 +0200 Tariq Toukan wrote:
>>>> If we enforce by policy we need to use the constant 7, not the macro
>>>> IEEE_8021QAZ_MAX_TCS-1.
>>>> I'll keep it.
>>>
>>> The spec should support using "foreign constants"
>>> Off the top of my head - you can define the ieee-8021qaz-max-tcs contant
>>> as if you were defining a devlink constant, then add a header:
>>> attribute. This will tell C codegen to include that header instead of
>>> generating the definition.
>>>    
>>
>> Hi Jakub,
>>
>> I tried implementing this as you suggested, but it seems that the only
>> supported definition types are ['const', 'enum', 'flags', 'struct'],
>> while the max value in checks only accepts patterns matching
>> ^[su](8|16|32|64)-(min|max)$.
>>
>>   From what I see, it doesn’t currently support using a const value for
>> the max or min checks. Let me know if I’m missing something or if
>> there’s an alternative way to achieve this.
> 
> Ah, I thought we already implemented this, sorry.
> Can you try the two patches from the top of this branch?
> 
> https://github.com/kuba-moo/linux/tree/ynl-limits

Yes, it worked after applying the pattern changes to the
genetlink-legacy.yaml , as devlink uses it.

Thank you!

Carolina


