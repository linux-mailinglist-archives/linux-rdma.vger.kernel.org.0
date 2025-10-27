Return-Path: <linux-rdma+bounces-14070-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 54259C0E6BD
	for <lists+linux-rdma@lfdr.de>; Mon, 27 Oct 2025 15:30:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2910F1888495
	for <lists+linux-rdma@lfdr.de>; Mon, 27 Oct 2025 14:30:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F3533081C6;
	Mon, 27 Oct 2025 14:29:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ZZ07Dqh5";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="XIqiBF2q"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C262236435;
	Mon, 27 Oct 2025 14:29:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761575395; cv=fail; b=a78EyRjWPhpAoEiDRTZT3c2N9vm5ozO73Lt7T1IrcebTC4PopZYrjJgpO/ICpTiczl4JaFpZOvHuJKRGJb1GCEex3KE96rJfw+cvo6jYjri5s0W+3ohBFpIyoVJb1pA1X+79OGd/duqSsa0xLrsbBlz6Kb4ySS/H8wxuIg7rTrg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761575395; c=relaxed/simple;
	bh=5RIrG3th/SvRwiM43mSS/LGsJjZwWey0DWSOtQ/f3FE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=A7TGru+Ps5FV+QdgKZGm0sccRs0innGRjtnLP1ikkXeO7vB7I3IU0qmrGzkA6b03YSLbCg5v2Z32UMjHUihFvyXQi6JGd1jGm+R1c0SDFE0wQr3R/GQFaYuXde+D3dwxfAHhgJ8vuFTUkDyKa8pMr+NGsGX8GBtTHDkPkkRV6xs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=ZZ07Dqh5; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=XIqiBF2q; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59RDY99v005569;
	Mon, 27 Oct 2025 14:29:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=Hm0pGdGeqfJ2ITm8xT1MywNcvvEVZDQeHF1fXIwET9I=; b=
	ZZ07Dqh5ZuXnX0YokQx2tgu6tT/CJj5KUn0LK6wmLsD5GIAOUZxSL/H20iu40CWR
	wJs7dorHSxWu5f82t6sO7aumEJi4ws/0Fd0QN/sOwDFeNVIc+xe91XKkMnHBpDqw
	skRhWKGy1hdgOyL2h0lr7x6TF5eMZhkQAsgHDb7B/Uu3774QqlUx7wvM4mYijdvh
	t8jMLi+FGlQSz8MogTRmZVyVsu+Rgkxoug5z/gxdKTbXKxx2WzeqvtmnkK5sGK+i
	cTfPORQF7LG0o/JnKHdRy9IUdHDW25AJaQ64JjeDXAPP8I8aDhqtU14pzGpT3hOI
	c6b9UUX41XTpRwAvZKbRNA==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4a22uwh2qg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 27 Oct 2025 14:29:39 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 59RCbHlq034922;
	Mon, 27 Oct 2025 14:29:38 GMT
Received: from ph7pr06cu001.outbound.protection.outlook.com (mail-westus3azon11010069.outbound.protection.outlook.com [52.101.201.69])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4a19pe8sfr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 27 Oct 2025 14:29:38 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=exLm5EmTx3Me8GiT83FyjH87jOKV6qRMVkVEDYbRNTlNg4HQ+BRPYj5vlGD5SZtVXdUeCsuVOM5qOjLAUu0sihq0YDVbI9JcVglC1OOVxsirj0bt3Rr9/sSOlT6jN1JXqptM6MXQhVdp51aJZNLZziWJqeIf2T9I6Hk4PBIe6Cr2t0UdTXd6rHYXf+OmD+dk/JSQMQJj4L8bhzDfRDMgxfVdKUiUHx5cu6wzEqgy2oX2ISNfCU8jdJn/SHs1R8kAw3Wi1HdvfXoYtzsNGWpDDGNaeGrX+YyzM+QtPOrPRRWQgQbXb83dGiwXyZr6wX3ofxUlKhKfuTKckVD076Yliw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Hm0pGdGeqfJ2ITm8xT1MywNcvvEVZDQeHF1fXIwET9I=;
 b=JgHURztqWIroMRHILz5gDR60UWV7K5M89veLq5PzYg0VMl8t76grER3u5XNL1Cr3ZxdNZvQEIvohE+DgO2No+q+pja4ZfYOCwt712TDVYyijp1l9KTrjneSBplEmvFNCtSrO+2PB7aIQvI5RuVFF3LTcdLHD2yQs3y6BMucVu6xJ5U70yflnnbbxs1ESLuu5EqsHgTitdV6ZaGCk4pgl4hDdSNMDp375bOGJADWZ2ZYCXGloSabyRLLbjQNwj0xEsXMjzcifvaCPEFl9yIlN1E1KtH9/9O2jbZisRURvcyRcOrr2IFF0dmLE0yxdFaMF12iCsSivQ3RBCvcg3qW6qQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Hm0pGdGeqfJ2ITm8xT1MywNcvvEVZDQeHF1fXIwET9I=;
 b=XIqiBF2qSGPwqw7k68I5QmWB1waIgObL2GS2kiGLgTbaBU0WkVFImiO0k9oF8GxkKkqnI85CFF4b6ZHJtO3Vw5iE3UnjX9RSzcJ/MLMSRJ4P8eQj+YMswt0IOuC4Fr5VPVQe/3U5ws6Z9cDThBtVmrapbLYmsdMnAt3Ax6JM654=
Received: from CY5PR10MB6069.namprd10.prod.outlook.com (2603:10b6:930:3b::22)
 by DS4PPFFE8543B68.namprd10.prod.outlook.com (2603:10b6:f:fc00::d5b) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.18; Mon, 27 Oct
 2025 14:29:31 +0000
Received: from CY5PR10MB6069.namprd10.prod.outlook.com
 ([fe80::143d:f348:965c:d15c]) by CY5PR10MB6069.namprd10.prod.outlook.com
 ([fe80::143d:f348:965c:d15c%3]) with mapi id 15.20.9253.017; Mon, 27 Oct 2025
 14:29:31 +0000
Message-ID: <f4975aab-8fe5-4247-8fbc-919345a970d7@oracle.com>
Date: Mon, 27 Oct 2025 19:59:17 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2 1/1] net/mlx5: Clean up only new IRQ glue on
 request_irq() failure
To: shayd@nvidia.com
Cc: anand.a.khoje@oracle.com, andrew+netdev@lunn.ch, davem@davemloft.net,
        edumazet@google.com, elic@nvidia.com, jacob.e.keller@intel.com,
        kuba@kernel.org, leon@kernel.org, linux-kernel@vger.kernel.org,
        linux-rdma@vger.kernel.org, manjunath.b.patil@oracle.com,
        mbloch@nvidia.com, moshe@nvidia.com, netdev@vger.kernel.org,
        pabeni@redhat.com, qing.huang@oracle.com,
        rajesh.sivaramasubramaniom@oracle.com, rama.nichanamatlu@oracle.com,
        rohit.sajan.kumar@oracle.com, saeedm@nvidia.com, tariqt@nvidia.com
References: <d9bea817-279c-4024-9bff-c258371b3de7@nvidia.com>
 <20250923062823.89874-1-pradyumn.rahar@oracle.com>
Content-Language: en-US
From: Pradyumn Rahar <pradyumn.rahar@oracle.com>
In-Reply-To: <20250923062823.89874-1-pradyumn.rahar@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0081.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9a::8) To CY5PR10MB6069.namprd10.prod.outlook.com
 (2603:10b6:930:3b::22)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR10MB6069:EE_|DS4PPFFE8543B68:EE_
X-MS-Office365-Filtering-Correlation-Id: e20c90b4-27da-4136-e486-08de15653d40
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?eUtWLzFaQlIrRFNwd2NWRHBVcDBvY3grOXBMN0ZBVVNIelFCTzV2SFF3Njlj?=
 =?utf-8?B?RmRrakRIZC9aalNYeUwzRmpnL2xWQ2F5dFM3MWgyY3VoOU4zWis5WGIxdDBO?=
 =?utf-8?B?ZDlicTZXQVc4dWt3VVhkZy9MYTV5cGg3VlVDZlJUSkJXQ3NEOFRxd2d4QWdF?=
 =?utf-8?B?czZleDR2Q3NSQU1sRlhMdDA4NjJ6d0FFKzVldjVTN3lCSFVrZ0dVNFZUM2Mr?=
 =?utf-8?B?Rkp3YVBUbysraCtKalVvK3Z2ajMwbE41L0lWQnp3ZkFHdUtaSXk3WWMwU2pw?=
 =?utf-8?B?LzZSUmZiRmxjSXJYYkYvcTIrdlhpQmtNL3dUd1lNSXBIcVNCcUFKb2ZXSkhF?=
 =?utf-8?B?amRRL0tOa2kvcjZXQ09lb1NlWWkxTm5wdlBtellXMmpabWdia0FLZkZKbVRn?=
 =?utf-8?B?R3ZwNGxoM2dVSkFJM2FBbkxDejdqOHRYdEpZVkNJL01BMU14OEdKYTRsbEg3?=
 =?utf-8?B?VHE0a3lBRmV5T0FvNnlvK3QycGh1TkFPYVVraEMwT0Q5aW1JQUE1WFI5Wngw?=
 =?utf-8?B?NktvRFFJcS9MakVwVkdjdWt6dyszMGVBVEhjMGFNdDJnZDZOZkgzdW1hRHI4?=
 =?utf-8?B?MGthdHhHOWw4UEZGSU4wMUpzajBaQ3hCSGVsL2lJR2NadFdRZXFiQkVsTDNj?=
 =?utf-8?B?eFkwYWhSWWxCVVBYWm9vTDhmSTNGZjZGLy9LY3JlZ2NSTUgvLzJjc01wTWVU?=
 =?utf-8?B?cTUrcnZlTFBTdlhxVzAzVldyZTNjNjRGbU5zS1ZnUkV2Q1F3cnRBeVhZRnBn?=
 =?utf-8?B?Nk9GR04zdzAvL0RMeEdwZlBVNnNEbkE2LzV4RjNBVzJ3UGlFVFdwZ2FQTFFv?=
 =?utf-8?B?ajlZeHlBSTVBRzI5UFM1cVdtek1uSU9tTmJ1WjFKYkdnYTIySXZhLzcwV3cx?=
 =?utf-8?B?a3BISGJ4Vzk1bkF5Mm1yWndWVTA1dWlpRlV5Nno4Rkd3TENHR0FlTnI2YitO?=
 =?utf-8?B?Sll5ZVVnWUFHY2pscVNpUnBaZDU1RWJsVzZ0THRYRGFNUGQrWWJOajFHbGRx?=
 =?utf-8?B?MDduakJlWFlwdllmYmxMaXYxTFdWNEdRNll0VVBDamoybE40RENWV0VYdjll?=
 =?utf-8?B?VW1hMVpHMUt0YWMxSHdJd3Q3QW9JdG9ZbE0wa3ZMR2djM3V0U3hockpZQmdo?=
 =?utf-8?B?NHJmRlM5bitrbkpHSzZSYXppYzNiNWZyWGJnS1k3YzlCTVk3dnIxaEMyRFZB?=
 =?utf-8?B?ajZRN1I1MFBNd20vVTJLL3FvMmVWYnFtMHdBZHFSUmlzNGU4eVJ4WHBpV2Ur?=
 =?utf-8?B?blNCMnZNQjhHQ1BScjV0eVR0MG1PZzVhSWFxd1dkeDdNNFdpWUdGMTIwVmhu?=
 =?utf-8?B?L09uSzJILysyZ2JNaVZ5MXFJN2FBNEhNR2xTYTVDT2cwWU05Qk01RFNWbTF0?=
 =?utf-8?B?dCtUOHV2anY0UTB3YmRLUDcyVzQ1YlozdUgzNEpkc3JRbGpEeUxYNnhwcEgr?=
 =?utf-8?B?M1VVSXdvQTVjVVFOOFNyK1g5eEN4RDJCempvYlE1RHNDa3RIMVZPdnhoRTZr?=
 =?utf-8?B?YmN0R01pZWtaSHBEaHVyelF2K1ZGRElqbDZqRGVyeUgveGNMenQ4NXJSK01K?=
 =?utf-8?B?Y0RaMlBYYzFkYk4wK0JRUS9tNVVWaDM1TkNYQVVubTZCL09mZll2MGFVd3Nr?=
 =?utf-8?B?QlJtR3c1SjE4U3Z3S2JzQmhJMU9PNEw1VjdhOEZpcS9NMFE4UnBYTkE5QldF?=
 =?utf-8?B?RVNhYTF1WVo2cnVMNEE2bjh4SDdpSDJUa0hGTnJGdTB6MzgxRHFJb2MxZkc1?=
 =?utf-8?B?bmx6Q3paL3R2MWJxekxiSmJDb2pGMVI2Tk1UeDZSU3dQK2FqOGdaVmFNSUNj?=
 =?utf-8?B?Q3VUbTBXRGdjQmFxdyszN0lpdk1ER1BtcnNhRFRORStzMjFybkczeU9KMk9w?=
 =?utf-8?B?dVBRbVRyT2pOVFNoa2xXS2ViL283TDczbHZhQ1R4LzdkVlcyd1hBWHNzdjNJ?=
 =?utf-8?Q?NwZl6zF2nFidYJtUwzTUZCI2NodHESCa?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR10MB6069.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SHVlRnE2cWNNVmQzS1lVdTJJN3owZ2w2VXNQUllqbkZFVExncGF1aWwxSFNo?=
 =?utf-8?B?VkN5YTNGa1BSSmQ2LzFqSjRFY05WTjhrdzFZdVZRT3I2cjIvZnQ5QWJVZmpn?=
 =?utf-8?B?dXNUS2JJYm1hMk5UaVVUSDVoNUprLzNmVEpNNXJiQ3ZvNUJmYlM0dWNZZnJ1?=
 =?utf-8?B?eTAvQytmWGxWT0dVSVRvMzVYUW1CeWhTZERmMDM2VmJXRFpnRG90ck9ZVURh?=
 =?utf-8?B?Nnpqb0YvL0FSSlM5NDFnd3RGRHFwWW5Za0w4LzlVWksrTDZSQVZBejdGejBz?=
 =?utf-8?B?NTk1YUg3SGVCRmVTVGJoVG1uSnZwWnVieUFSWWpoWmd2MVRxN1UySERLRTdw?=
 =?utf-8?B?UEhNcTlsd3JzLzlaeDFJd05tQ1BUQ29xeGNaUUdQMnJ6b1JBYWZ6NUpyWXJo?=
 =?utf-8?B?K3dSOUxodTJINVVEaUd3ZzYzVHhpZTkrODBZZkVSWFZMekJTU2F6a3c3ZEVC?=
 =?utf-8?B?R3lJNkIvcnZQTEdBKzZnZHpFTkJoR0dvT3UzSFZjMDhaVHFvMHZHWW9lc1Bz?=
 =?utf-8?B?aTlTbU5BN1p6RXNQRWVtUzg3SzdpY0NReDFCRElLc1ZNN3Y2aXdBYXc0b1FM?=
 =?utf-8?B?bUM5NjJ6YzR1M1BnK0V5MnM1dUZLY1ltY1Bic2NJeVNQNjRrczlHdUpscXBO?=
 =?utf-8?B?YkswVEFKTitpT05sT0FsbitmSVI5a040RExsNU5QK3Q5bkUrUFBEM1ZybXpz?=
 =?utf-8?B?Z0doTndteEU0bzhrdWN6Y0ViQmhBanM4Rjl3enhhZHFja3lTc0tkeFE5am5S?=
 =?utf-8?B?bjltU1l1ZVE1UkxQTlA0MTJnV0JGK054aGpUOGtkdjlQTmZTQ282Mlc0ZzFn?=
 =?utf-8?B?eUZlTmdyVFhtWndzdjFCV1N1R1I0eGZLd015c0x4RVQrZjFsUzRERVZOYTkw?=
 =?utf-8?B?SmZaMVJYNVJFdjlRb3JoYUJnZWNEV0V1SEJIUCsrSDZVRnNGVERCWlhXeWJU?=
 =?utf-8?B?bm5ycjF4WHhWVHZNcnluUDludm16Z2pPZ1JTckM3Z01oazRxZDFaQzRLbTYx?=
 =?utf-8?B?bUswYnVCQUpZT1drMVp4L1NXZCtRbVBjKzkvWEdqazdXYlNhUkdDazlyOVNi?=
 =?utf-8?B?YzlKMzl1VHdjdE55VWVpZUFEZEN3V3ZRSk1qOUUyb0NhT1p3RHpSdnRCRWpZ?=
 =?utf-8?B?QW94bjR6R2pBamp2blJvUDZ0TGE1YW11MmMrV3ZwMlpxOUVoMkZRV2VWK1BS?=
 =?utf-8?B?T0ZaQTd3UGdHNERLaWdvc1Z3K2kxZW1DSmt1REoyaW9ManArSytNSWVKVWRv?=
 =?utf-8?B?ZXlxS25vVGszMC9tR0h4cHhQQ3hua3FDdXhmeWVQWnF2b0ZQalloaVFndjY0?=
 =?utf-8?B?R21rMExoTDdQcXZyZkZmV21qaHJTcFlPRmswS3pEYXpoWHJFMmUyNzVUUE44?=
 =?utf-8?B?Y0xBdFpVWXk0aFNTZ2tjbFVteTQ5UG9SMlNtTVdFOWpwL2g5YUE5WDZJcVEz?=
 =?utf-8?B?SndYd2VlclBIVXlIVStud1cxeVJ2V1JnVDJZb1Y3M1ZQOUxTSFpzVzRCenpm?=
 =?utf-8?B?N25iK2x2VEcvZm5YbU9Tem14bWROUUpaQ1lsMVRzanhHbHRLM3R1RG13S2E3?=
 =?utf-8?B?VDFTeFc0clRBZmt5YzFkMmtTdnF2bFpnaE1qRHpKUTZaeGNIYzNSL0Z2WWgx?=
 =?utf-8?B?c3c4NVdZOFlRYXZIc0ZIV0ZNdkNmK2ZCL0I0ZnNMZXJNaTJZdHRVOFhtQWZT?=
 =?utf-8?B?RENVL1lrQ3dPZ1RtbFozdCtuWE1KWlhMakxRVFE0azVYbHRnNXZlNmI1U3g2?=
 =?utf-8?B?ODdhYmpPdTQyMEhmNHJLVmh6VWhiRUlrdmVWTmN4RVEyS00rS0xrbFl0S0Fv?=
 =?utf-8?B?WnR1NmIyd2JJYXN1clY3b0swaXZiU3hnb05LVHJkMlFocGJYTXdydkVDb0tJ?=
 =?utf-8?B?RWRULzZobVZ1LzlmbkFDN01hSXpkZytUOE5XbDdXU0lCdXAwRmJBWkFtZUtF?=
 =?utf-8?B?aTN0bFBZOCtRMkdFOHpydmRJT3BybFVvUFIvd2czZ1F4Y0tiRFl2Wm5MMG1x?=
 =?utf-8?B?anhhUDRuSFA1SnVncXdEODBydHZqbkh5c3RPU1ZpcW4vL2pFUWgxUDFIUkw0?=
 =?utf-8?B?aDU0S1RGWU9WcVZqRmdYaXR0aGl5Y2lEWWdvRVRTQnY1ZlJVbENrdjB5V054?=
 =?utf-8?B?aG5pRU9HUytmSmoxaEhvMWI2ZG53dHRRQ0t3OGdta05TWEhlcDZWSFFPc2hC?=
 =?utf-8?B?cHc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	xxlh4A2pI0vOQSq6nonvupFhq4trIAti/z7v1jWq6bEmWcaaR6osO+zpv7NvqFyUwZSQkda76hecWhvi29o2svvA9UsLZW19yn+9y9UVoQi9YnedYrqiNxglewxSDwlbUWNFskyxZfJZa4CwOz2JsILEvWITnoLX2z4NN4f0Yo6sXowfZoxfyp2qLPMVq+t7G2/XAqti1ZHKsSUCpG8I1p+/5SCMyz3cZrkW2gLGZrP9WMNU6O8VmH1DzzrUGBhD7AIieDGk9uwvLT0R4ZugPYVND92x1uIyoK5e0AE2m7Omg3vL6Q6Ua+OyHu94fptugHTgAjgJrjsYXDhIMz28Mzl7pNuJIgwimADEm9bJqj5z8aiZRRY8K6muLeHvzrKiYt/eNRgcmLDqFhOsmJBb9oTL7WjzuqVJ4euOI3o3qOclG6Ee6eGcDwwVm9seee1fWVPNYIBO6LCAc7pl4TTdr3CGDpxwrvoSYWAGJp8Z9RjMUNraG14/R6UoNDExP2Pq8O3paDsEoCa5mHqvN5jSd5aEz8jzbvTrzNSz/WKG53pk6dQnJXUTzkxP3LtNMIrsaG7bloM9TLM49fp02HJk9FVK3b5LYrTHyfFT1g30p4k=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e20c90b4-27da-4136-e486-08de15653d40
X-MS-Exchange-CrossTenant-AuthSource: CY5PR10MB6069.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2025 14:29:30.4970
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gDB2hpHrBzRKjqCd1jbqJK/IDGCH2a5E3woESwrIKpkyAuieGxYht18u+0SVpx0jxnbfcrXBSEm7LuqRIq94YbAsu0WwTfI2UgoI37Awr7k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PPFFE8543B68
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-27_06,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxscore=0 bulkscore=0
 malwarescore=0 mlxlogscore=999 suspectscore=0 phishscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510020000
 definitions=main-2510270135
X-Proofpoint-GUID: Kn-mDw2Gqgy8TTbTEsAAiq-oIudAA0_e
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDI3MDA1MSBTYWx0ZWRfXzMHrYmUaxE7j
 TBvbKGZhsMjwFbHldh3RO4MIm4I/14QcENFzt4A+qAgGHfhcoOmpXlFgocxZb4xPENwDdJSaGa0
 jhkD7TQZIFPC9YylvRC0Ymnz+Mvb9fjzQfgGSmIxCoqfCmhhxvAYjpX3Ijt+hXSnB5Akt501eaV
 pNbVOebA2J5uOJ+u7Fn40eHNV7I3BPVF/GBEmxREg8R2qzJVLjkqf4aoD1YwXSzcPau/2PF/r05
 AR7hvw3wlTnuXiQhqnidfUdsVKo1We6U5+ISpKurBGM6hltuJT0b9Fs2KxC4WnrNHtERkrfg9v1
 CtNvqrzhMyAbhtYrXfd18nIDXlnLmkUJBRTx0e/D/fZvG7havHpa1pj+zE82zFOlnGupu0sGmIr
 TWET3v+6K/dlFNB5ioB3Hyhyf4AgHRRsXTh61glLNsJM1vK6QqM=
X-Proofpoint-ORIG-GUID: Kn-mDw2Gqgy8TTbTEsAAiq-oIudAA0_e
X-Authority-Analysis: v=2.4 cv=Ae683nXG c=1 sm=1 tr=0 ts=68ff81d3 b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=x6icFKpwvdMA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=yPCof4ZbAAAA:8 a=Ikd4Dj_1AAAA:8 a=sxOvPkmjtsOCJmk7VlUA:9 a=QEXdDO2ut3YA:10
 cc=ntf awl=host:12092


On 23-09-2025 11:58, Pradyumn Rahar wrote:
> The mlx5_irq_alloc() function can inadvertently free the entire rmap
> and end up in a crash[1] when the other threads tries to access this,
> when request_irq() fails due to exhausted IRQ vectors. This commit
> modifies the cleanup to remove only the specific IRQ mapping that was
> just added.
>
> This prevents removal of other valid mappings and ensures precise
> cleanup of the failed IRQ allocation's associated glue object.
>
> Note: This error is observed when both fwctl and rds configs are enabled.
>
> [1]
> mlx5_core 0000:05:00.0: Successfully registered panic handler for port 1
> mlx5_core 0000:05:00.0: mlx5_irq_alloc:293:(pid 66740): Failed to
> request irq. err = -28
> infiniband mlx5_0: mlx5_ib_test_wc:290:(pid 66740): Error -28 while
> trying to test write-combining support
> mlx5_core 0000:05:00.0: Successfully unregistered panic handler for port 1
> mlx5_core 0000:06:00.0: Successfully registered panic handler for port 1
> mlx5_core 0000:06:00.0: mlx5_irq_alloc:293:(pid 66740): Failed to
> request irq. err = -28
> infiniband mlx5_0: mlx5_ib_test_wc:290:(pid 66740): Error -28 while
> trying to test write-combining support
> mlx5_core 0000:06:00.0: Successfully unregistered panic handler for port 1
> mlx5_core 0000:03:00.0: mlx5_irq_alloc:293:(pid 28895): Failed to
> request irq. err = -28
> mlx5_core 0000:05:00.0: mlx5_irq_alloc:293:(pid 28895): Failed to
> request irq. err = -28
> general protection fault, probably for non-canonical address
> 0xe277a58fde16f291: 0000 [#1] SMP NOPTI
>
> RIP: 0010:free_irq_cpu_rmap+0x23/0x7d
> Call Trace:
>     <TASK>
>     ? show_trace_log_lvl+0x1d6/0x2f9
>     ? show_trace_log_lvl+0x1d6/0x2f9
>     ? mlx5_irq_alloc.cold+0x5d/0xf3 [mlx5_core]
>     ? __die_body.cold+0x8/0xa
>     ? die_addr+0x39/0x53
>     ? exc_general_protection+0x1c4/0x3e9
>     ? dev_vprintk_emit+0x5f/0x90
>     ? asm_exc_general_protection+0x22/0x27
>     ? free_irq_cpu_rmap+0x23/0x7d
>     mlx5_irq_alloc.cold+0x5d/0xf3 [mlx5_core]
>     irq_pool_request_vector+0x7d/0x90 [mlx5_core]
>     mlx5_irq_request+0x2e/0xe0 [mlx5_core]
>     mlx5_irq_request_vector+0xad/0xf7 [mlx5_core]
>     comp_irq_request_pci+0x64/0xf0 [mlx5_core]
>     create_comp_eq+0x71/0x385 [mlx5_core]
>     ? mlx5e_open_xdpsq+0x11c/0x230 [mlx5_core]
>     mlx5_comp_eqn_get+0x72/0x90 [mlx5_core]
>     ? xas_load+0x8/0x91
>     mlx5_comp_irqn_get+0x40/0x90 [mlx5_core]
>     mlx5e_open_channel+0x7d/0x3c7 [mlx5_core]
>     mlx5e_open_channels+0xad/0x250 [mlx5_core]
>     mlx5e_open_locked+0x3e/0x110 [mlx5_core]
>     mlx5e_open+0x23/0x70 [mlx5_core]
>     __dev_open+0xf1/0x1a5
>     __dev_change_flags+0x1e1/0x249
>     dev_change_flags+0x21/0x5c
>     do_setlink+0x28b/0xcc4
>     ? __nla_parse+0x22/0x3d
>     ? inet6_validate_link_af+0x6b/0x108
>     ? cpumask_next+0x1f/0x35
>     ? __snmp6_fill_stats64.constprop.0+0x66/0x107
>     ? __nla_validate_parse+0x48/0x1e6
>     __rtnl_newlink+0x5ff/0xa57
>     ? kmem_cache_alloc_trace+0x164/0x2ce
>     rtnl_newlink+0x44/0x6e
>     rtnetlink_rcv_msg+0x2bb/0x362
>     ? __netlink_sendskb+0x4c/0x6c
>     ? netlink_unicast+0x28f/0x2ce
>     ? rtnl_calcit.isra.0+0x150/0x146
>     netlink_rcv_skb+0x5f/0x112
>     netlink_unicast+0x213/0x2ce
>     netlink_sendmsg+0x24f/0x4d9
>     __sock_sendmsg+0x65/0x6a
>     ____sys_sendmsg+0x28f/0x2c9
>     ? import_iovec+0x17/0x2b
>     ___sys_sendmsg+0x97/0xe0
>     __sys_sendmsg+0x81/0xd8
>     do_syscall_64+0x35/0x87
>     entry_SYSCALL_64_after_hwframe+0x6e/0x0
> RIP: 0033:0x7fc328603727
> Code: c3 66 90 41 54 41 89 d4 55 48 89 f5 53 89 fb 48 83 ec 10 e8 0b ed
> ff ff 44 89 e2 48 89 ee 89 df 41 89 c0 b8 2e 00 00 00 0f 05 <48> 3d 00
> f0 ff ff 77 35 44 89 c7 48 89 44 24 08 e8 44 ed ff ff 48
> RSP: 002b:00007ffe8eb3f1a0 EFLAGS: 00000293 ORIG_RAX: 000000000000002e
> RAX: ffffffffffffffda RBX: 000000000000000d RCX: 00007fc328603727
> RDX: 0000000000000000 RSI: 00007ffe8eb3f1f0 RDI: 000000000000000d
> RBP: 00007ffe8eb3f1f0 R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000293 R12: 0000000000000000
> R13: 0000000000000000 R14: 00007ffe8eb3f3c8 R15: 00007ffe8eb3f3bc
>     </TASK>
> ---[ end trace f43ce73c3c2b13a2 ]---
> RIP: 0010:free_irq_cpu_rmap+0x23/0x7d
> Code: 0f 1f 80 00 00 00 00 48 85 ff 74 6b 55 48 89 fd 53 66 83 7f 06 00
> 74 24 31 db 48 8b 55 08 0f b7 c3 48 8b 04 c2 48 85 c0 74 09 <8b> 38 31
> f6 e8 c4 0a b8 ff 83 c3 01 66 3b 5d 06 72 de b8 ff ff ff
> RSP: 0018:ff384881640eaca0 EFLAGS: 00010282
> RAX: e277a58fde16f291 RBX: 0000000000000000 RCX: 0000000000000000
> RDX: ff2335e2e20b3600 RSI: 0000000000000000 RDI: ff2335e2e20b3400
> RBP: ff2335e2e20b3400 R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000000 R11: 00000000ffffffe4 R12: ff384881640ead88
> R13: ff2335c3760751e0 R14: ff2335e2e1672200 R15: ff2335c3760751f8
> FS:  00007fc32ac22480(0000) GS:ff2335e2d6e00000(0000)
> knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00007f651ab54000 CR3: 00000029f1206003 CR4: 0000000000771ef0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> PKRU: 55555554
> Kernel panic - not syncing: Fatal exception
> Kernel Offset: 0x1dc00000 from 0xffffffff81000000 (relocation range:
> 0xffffffff80000000-0xffffffffbfffffff)
> kvm-guest: disable async PF for cpu 0
>
> Fixes: 3354822cde5a ("net/mlx5: Use dynamic msix vectors allocation")
> Signed-off-by: Mohith Kumar Thummaluru<mohith.k.kumar.thummaluru@oracle.com>
> Tested-by: Mohith Kumar Thummaluru<mohith.k.kumar.thummaluru@oracle.com>
> Reviewed-by: Moshe Shemesh<moshe@nvidia.com>
> Signed-off-by: Pradyumn Rahar <pradyumn.rahar@oracle.com>
> ---
> v1->v2: removed unnecessary braces from if conditon.
> ---
>   drivers/net/ethernet/mellanox/mlx5/core/pci_irq.c | 6 ++----
>   1 file changed, 2 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/pci_irq.c b/drivers/net/ethernet/mellanox/mlx5/core/pci_irq.c
> index 692ef9c2f729..82ada674f8e2 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/pci_irq.c
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/pci_irq.c
> @@ -324,10 +324,8 @@ struct mlx5_irq *mlx5_irq_alloc(struct mlx5_irq_pool *pool, int i,
>   	free_irq(irq->map.virq, &irq->nh);
>   err_req_irq:
>   #ifdef CONFIG_RFS_ACCEL
> -	if (i && rmap && *rmap) {
> -		free_irq_cpu_rmap(*rmap);
> -		*rmap = NULL;
> -	}
> +	if (i && rmap && *rmap)
> +		irq_cpu_rmap_remove(*rmap, irq->map.virq);
>   err_irq_rmap:
>   #endif
>   	if (i && pci_msix_can_alloc_dyn(dev->pdev))

Hi, this patch has been reviewed but hasn't been applied yet. Could you 
please look into it?

Thanks.


