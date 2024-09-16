Return-Path: <linux-rdma+bounces-4968-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D9CAA97A2B1
	for <lists+linux-rdma@lfdr.de>; Mon, 16 Sep 2024 15:03:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 97BA02864AC
	for <lists+linux-rdma@lfdr.de>; Mon, 16 Sep 2024 13:03:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7CFE155725;
	Mon, 16 Sep 2024 13:03:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="BQNqBrDd"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2044.outbound.protection.outlook.com [40.107.244.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2749CA95E
	for <linux-rdma@vger.kernel.org>; Mon, 16 Sep 2024 13:03:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726491825; cv=fail; b=BAzlj3a0/x+Oag4ZBDZ5dJQMA+ffPR11Egcy0qsSTo0M5eBrB26UJsGcBb+oTVpdUqOkl3Kno8bQfHu1afaPGI6HW/VFN17fxfVn1/xFweBlGfXH5KGw5X7HMiNw19ekgOFWyiLrfdlG4ltYy2WVFAI/ATn0HVkJaMXl/0LpDOM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726491825; c=relaxed/simple;
	bh=KWBFEGaJVfI9eCR7THKwRbjRS5/fuQpghm2jO3RQJBA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=HA1XFgyLFCw3TuQo27OG/7dUpZsZVnsFFH12gLfk7va3dRNy+Z7vAs4K57GpLUH3zwJ8r4McEq+/oaimk0S6umKOY45Ko64atjbbU16yPgfCFLtncZfWu4T9vd1eExhWHcSe9yCMLmQTYVs8VW0CVnSUGGYrwPcuSuVkPATbyVE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=BQNqBrDd; arc=fail smtp.client-ip=40.107.244.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PesliTPvRA0UC89uLaSWpWuZA0BUETcgfKX/rf+DyZegamwk3p3SrL77pz6TXKaSppIfs+3AJAxha1xxJH1D6WsVZl0W/ALxAfsW/rHqnnhrssL5E7rtXxNYLDfC3JqIkHVzB6GkxXJXGZ/eyK4FMURpxOvagenrLFeF5dV4sZwhJtGT918PSQZ1qzXC487tNxsDsjA38pZ3Kr5KF8zI/aiXniP5D1KghzFBiTiihKx3QMx7tBOYWk/5r2Yret7Epy07wqdRNDOemZzq23Tmf+ARQc8J6tjYYttdwq8afI/afNsh7tCuHcGJZrHQO9OOQg9Jygip6QZ5gZCepUFzkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4biENzqWujDHuQF+vI4HN4eCL3s5OaFpdDSeA06kJJk=;
 b=m+LhSmIkYMMuS58T21fbxvAxefueuSp3CHvMjtVD7rzgL8haoOaxgCFK5QJfPoC/8+3JNNxh7SXanmUV/okyh11DAbox5uvRi5a/bbGze0hUlRQ1QeCXnVbnlnnz824oQ9ef50KMN+ZiYHvzhsNHrZ+DTv583eYeu1nxkbPEnMfSw8/tKRgE6UiUl8SZY/SWWCAwEVJTN/EdTCnaFQTzffAjDoVMjxfVDyWfeMHuFoSTIDgwu0lI7lVUmTO7VABjrvxi++9oHNi6X1o7uv/f47PSGbBDPXr4+lHymB/3NkAIhlVKMZFWZ52c072RBQxOmI4z0o06NrKkNK1QB81P5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4biENzqWujDHuQF+vI4HN4eCL3s5OaFpdDSeA06kJJk=;
 b=BQNqBrDdxiLp/MBtlV0FQjJ84tvLSczk7+MuSEmSwmkcCaVWC6nJkW0P/66y/aWHyESTTe8X0SUYR6tnt3qpmBe99gWt7MME5unBS8FtYWqrDj+koEkEDG4I3jxyJVhdt0aEXCbTfJGWFNOmpuaFSTww9amdyTzGGw2NUPq38MRGFsile9DWPv8ot/ncfPdEYoHlfOiQxakyzHnqRLG6yOO/O9H3kZ9ouCh/Ef8Lktn8geUFm61LfoehQjQn6dfiSFAnGeIemHbxAXv5iePVxG1UKGJqDXum/pzbZwejXtyMwW+sN86KI5wn9OVnnR0gxnlI5C0r7h/U313zQ7UqRA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH7PR12MB5903.namprd12.prod.outlook.com (2603:10b6:510:1d7::14)
 by DM4PR12MB5795.namprd12.prod.outlook.com (2603:10b6:8:62::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7962.24; Mon, 16 Sep 2024 13:03:40 +0000
Received: from PH7PR12MB5903.namprd12.prod.outlook.com
 ([fe80::2abe:232c:fb73:f2fe]) by PH7PR12MB5903.namprd12.prod.outlook.com
 ([fe80::2abe:232c:fb73:f2fe%4]) with mapi id 15.20.7962.022; Mon, 16 Sep 2024
 13:03:39 +0000
Message-ID: <25cd9c86-3075-4947-a332-48b1b34e88b0@nvidia.com>
Date: Mon, 16 Sep 2024 16:03:33 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [bug report] net/mlx5: HWS, added matchers functionality
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: linux-rdma@vger.kernel.org
References: <f8c77688-7d83-4937-baba-ac844dfe2e0b@stanley.mountain>
Content-Language: en-US
From: Yevgeny Kliteynik <kliteyn@nvidia.com>
In-Reply-To: <f8c77688-7d83-4937-baba-ac844dfe2e0b@stanley.mountain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0119.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a3::19) To PH7PR12MB5903.namprd12.prod.outlook.com
 (2603:10b6:510:1d7::14)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5903:EE_|DM4PR12MB5795:EE_
X-MS-Office365-Filtering-Correlation-Id: 768b52aa-5284-4655-c1a3-08dcd64ffb99
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Y2hRK3hJMjlhbkJOdmhTRDZFeDVaRTc0a0trQ2g4VDNLVnFTVXRMc2VyTC8r?=
 =?utf-8?B?TEk3YjdGMWQ2d01QSnZFOTlybm82SjYwUnI0UWltUzRXMnFISGdTVVNwVWJv?=
 =?utf-8?B?dm5wMDBOeHRvMW1UQ2xqMzJQRGkxUkVyWVdSVnF0STNCcTRBazlrcDlINUpF?=
 =?utf-8?B?NHh3SWFROWJia080RzR4dTVSY0dnendBTExkaEpoT2YrVFhFNlFUS09vNk1E?=
 =?utf-8?B?bUs3ZVJYeWh2aUdHL1FDSGFzU2FVMzA0cGhGelJQSUVMZ0VjTE1qNVBnU3E5?=
 =?utf-8?B?WERNbHk2dm4wOU5RQmJ0MVBkR2xObVBhOW95Z1pJR2x3cmdHcW9QYlJxaERL?=
 =?utf-8?B?NlErRi92bTVFVFFuelAyUDVCSXovZ2VSbHQxbzg3dFFRR1ZLbzZIdWpHbk90?=
 =?utf-8?B?aHRxanpEeU5INmdpelZkd1FNUzZFUzlrTU90VFRFMlV0NHMrTjQrMVpLOWZs?=
 =?utf-8?B?RkdTdGFTRkhyQWFWTklkZ0xoT1k3ZFFVY095dXZORU1EOTJHVm16UVNSY3hw?=
 =?utf-8?B?NEE1WFFOL0lEN2JWSDRuVjUwSlE4RzZpRE14bFIyL09rNTFPU1JJRlRyRGp6?=
 =?utf-8?B?MXZ2d3FrdzVuODl1UDF4aXBTTnNLUzdSYWEvTEdMdmVldlZrS001Q3ZlRzRO?=
 =?utf-8?B?RFd1ejVoNkE5SHB3RTYyN0J5MmkvazNOOFd6ekdQK1ZiaC9yVDF3a0I0aDVJ?=
 =?utf-8?B?d3h6OWVhbTN0bFR0YjZBU1ZTUm9zYk8xdkw0NG1DZkV4cFdDZnlrUEVYYWwr?=
 =?utf-8?B?ZlBoSGYwVFhZa25nT0wvV0xBVzZHbnZBTlU2bERRa3ZkZDZEanJRd2E4R1Fk?=
 =?utf-8?B?cFB4OUYyLy8wcFZjeGhpcUk4T1ZPUE9OUU01WHlVWWUvcVlRMnhORTlBMDMz?=
 =?utf-8?B?Nmw1UjNvcithQktUejU0bnI0T2R5aGJlN2wzY0E3akhxTTZzUUl6cHBSRGh1?=
 =?utf-8?B?MktqK2NLT2orR0ZlYlRUaXpJNE96c0ZsS250MmZnM1NHejNGNlRueUxhWk4x?=
 =?utf-8?B?cU9BOXE1RmpETm5yckRXUUU0RlA0bmh2aVZ6UnpNZ3BCMXlKdmRzUjhxdXNF?=
 =?utf-8?B?TEpzNlBiVkpySXQxLzJSaUdBTi9sa2JRTWo2LzdCS1JrK3F1VVgzL2NHRG8x?=
 =?utf-8?B?bEt2djZUZTJQRmxrUjFVT1BNejd3NFlHWjVqWGxsZFdZblZTLytoMDNsTWVq?=
 =?utf-8?B?azl6SHNzOHlJOG1qTmhtVEJ3S1cvcm4rTUZnelNDeis0QlJqRFNwQm1Kc3E0?=
 =?utf-8?B?SUJBQTJmRk4rMjJuTE9SVURETXhlbnR2WmpVMnJ3dFNBQ2tuQzZRaGxoMTIr?=
 =?utf-8?B?TVNyK21ESG5neU82RWlpbjdRU3pBTmFPV1Z4eUlJRU5zRUdSeFFvYnhML0FG?=
 =?utf-8?B?ajQ2Z2l4dk1IcHlCclV3R25PWUp1T1FGL1lpelgxeUJPUlFFZ2JzL08zMVRl?=
 =?utf-8?B?TzgyWUw2bUwvOHp4WlhUM2hNTk53b0FlMlhIcDVwckFsNjczRjhIWVIrZXBk?=
 =?utf-8?B?TzQvY0pHWGRYZ0I0SnZDMnNmRzNPcUhacDNZQTJISU5DelJlSklkQndyNWgz?=
 =?utf-8?B?VndIeVJOczY2dW9aUUplYmRBYUR6Qm04VlBXeXkzODV6YUV6VjhDcEFsa2wy?=
 =?utf-8?B?d3g0bUtBNHJ3VEVWVm9JVEdIblAvNVZpVGlNMHgxckE1UmU0Q3NDN2t3aHVh?=
 =?utf-8?B?a29jVllzbjROQmpRT3Jmajc0c1l4VE9DMUMvbUJ2OWlnajI4MEVOQ0l2dUZM?=
 =?utf-8?B?QjN5NklJQWxxTXBtK3BsQnI5R1RORFVkTC9SZ0dEUGxpbWg4QXhOdXFDU20r?=
 =?utf-8?B?TXZJRkRNa0tKbFJwSlp5QT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5903.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?R0N3cU8xMlJGQ3czNlZRbU9mR1k5dHVsUnNFTmh2QjhSL2xIOUhMVUJDNnBj?=
 =?utf-8?B?YWFvL2txZUtYUXR4dTgvU0JISTU1VXFzcW9wY25qLzFqVGVMRFcrTzJrb3lN?=
 =?utf-8?B?azJPaFVOYkJGZ0UrVTgvOHR2N0l5Y3VXSUZrMzB6dTlWemhDaEZWUkRFU2NN?=
 =?utf-8?B?Y2hQVndVN3EwN0wrV00zbUdTMzlSeHlLTEFEVTVua0pIYWNjTmx3RzBkcklm?=
 =?utf-8?B?SWdQcGxROStVRkZEVGMyTzNjVHdxT3p4WVZ1N013VDZld1dOVmRWWE5XOURw?=
 =?utf-8?B?YmpIakg0dnJXYkVYQnl1WUViZlQyaHA0NzVGeEZwU3dQWHR6a0JPZmFYL25o?=
 =?utf-8?B?WEN5NW5sV1owQk9NdWptZWxDcU55SCtSeWV2UFlOUS9kN3FtRkExRE5nbGN2?=
 =?utf-8?B?dmNFcmV0WVRtTitqRHdrTkNJQ3hMZEdoOWh1MTdQQkN1RUZwN0JXWFZkMW1x?=
 =?utf-8?B?TzdKRVhCSDZ3Wmlta2JOK3Z3WWxnZ0E5UUY5WEpPV0d5a3Z2M1BXdXhTWCtK?=
 =?utf-8?B?cGhBVTMwY1Z0VXhZSEhIVGhsK29MT2FGRkFhdG51bkdKM1BOMlpNVi93d2M4?=
 =?utf-8?B?NWRqZkI0OEhJNTRneHJsTUc0KzBTc1hJNVhWVEJGTnBRK2FGbXhIV2huY21z?=
 =?utf-8?B?SFZmemFqczNGdTM5WkoxSkY1MUtzQks2Y284R3FYaUZtdG5wMEtDSDBrcGpS?=
 =?utf-8?B?MHVVSmkrRmF4bWt6ODBmdDIyMHNBYnlIT0RoMGhUMXZ3RFFtcFlscEtYdUhh?=
 =?utf-8?B?ZXd2SjJiNjFWeDhHYkFveGxWVlRRZXJUU0g2T05hK250cnhVRkxxMDhQdlVq?=
 =?utf-8?B?dGluYklqelRFbTdOWmMvQ1pVclNKOFZCQTBsdm5LdjNIWTJkS3d3a2syT1Vp?=
 =?utf-8?B?akMyQkU3Q1RDemkzZ1E2WGdJMmdWa0Y3SzNOazEvVDE5UWd2YnNDRlVualA0?=
 =?utf-8?B?TE0yRklUNk5aNHpnbzV4Q1lQUjhzNlRYVGl4cHYycmdhUVVIUiszb3dBODFs?=
 =?utf-8?B?SFJsMDFVTFZ1L0tCVnRKeDlpZ3BGckJkdFY0OGJrcjRrZlIvZWlXSkY4QnZX?=
 =?utf-8?B?dzVWcGFVTU1oWTZyNGlDRVR3T0h6U2RXQVI3OGZEL0pDc0hUaWpHcDk2Y3l1?=
 =?utf-8?B?WW82cHFxT3UwQVpjSkdNaklqZ2lmQStpZTFrVGlPUndTM3NZbCtwd3ppNGhJ?=
 =?utf-8?B?My9nbVU2MzZFWHBNajlPdDZ6WlBZdGR0MTZjcERxZVpzT29TdGcrNEt2d1pQ?=
 =?utf-8?B?YUJRY1laZzMwOUgzYVZmTDQ0UHcvYWVTcjdjSFlqNU9Vd09YcHdjTFFyd0pu?=
 =?utf-8?B?YU9TaFlkQUg2NWRWVTYyaHV2TmYzR1BuWVdLV2FNSlQ4c1R1bGFVemJqbElB?=
 =?utf-8?B?a3VOcFBmQnFiL0VBeEZEcGMrK0N4STBnN094QUdEdTJvbDI5ajlCSnF0Vm5v?=
 =?utf-8?B?SmhwcEZRdXdnR08xTWNCdG9qZUhibEd3MGhKSFJvc3E3RlA5R05GeUh4VHh0?=
 =?utf-8?B?b3lqVko2UWhjQlEwRUxNWFpwZmQvTlJLVnc3cis3RjlPK3VxVVJWV3NmeDNa?=
 =?utf-8?B?MW85ZlJNTEVpUzhVUllOMmJCMFlFazJ6U1F0WEVhVVhHeTVCV1FRNTJtT25I?=
 =?utf-8?B?K1JNcnhUaGl2ZllGaFNyeFZlek5XaGxOOVN2bC9OOXlWWCtzdldETmliUGJ6?=
 =?utf-8?B?SHJnTnJxMWsvNEdIdm9zNXl1VEdzT3NLWE0ydDlHTzFLR3QvQWJ1UW1XUWtU?=
 =?utf-8?B?SitGaUtVZTdmSmJCcnJ2VXBteXJzcmpQQnFyZlFsOUZnbGZ4cUZRK2lWUkhZ?=
 =?utf-8?B?UWVpaHYrekQ5dDQrSXNWYWd0NEVOUzNVcFNXeW1PMXJzRkRKRUpuOFlhOXlw?=
 =?utf-8?B?NVdSV2c0MWhNTjZXTnhIcW9JMmFSOHlQRnV4WHd4Z0VFRnk2LzNPVTIzY05p?=
 =?utf-8?B?ZVVxMFdmcW5KSWNaQUVLRWwyY2N3SjNWNkRnbGs5UU5KUUxIVkhPcUVnKzg1?=
 =?utf-8?B?VllzdGhhUitxejVONWcwN1IvczJsdVNvSFlma1hQSFUvT25ucnlEYURjN1dP?=
 =?utf-8?B?OW1rbjdpbDFhUFRWak51Vk5PaytyeFJrR0l6ckcyaDkwVHRNWTR1K244bm9h?=
 =?utf-8?Q?n+TMWef07j5gKcbdkpuC/vO6D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 768b52aa-5284-4655-c1a3-08dcd64ffb99
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5903.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2024 13:03:39.4489
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CEUDzdjtN+9+JHRQHvfXKJo9+R1SMGhi5+hvqLH6M0E+NSek9SZXqgK88xuAjjqUw/oZtf/YK7NTtjCnnHsgQA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5795

On 13-Sep-24 11:08, Dan Carpenter wrote:
> 
> Hello Yevgeny Kliteynik,
> 
> Commit 472dd792348f ("net/mlx5: HWS, added matchers functionality")
> from Jun 20, 2024 (linux-next), leads to the following Smatch static
> checker warnings:
> 
> drivers/net/ethernet/mellanox/mlx5/core/steering/hws/mlx5hws_matcher.c:970 mlx5hws_matcher_attach_at() warn: should this return really be negated?
> drivers/net/ethernet/mellanox/mlx5/core/steering/hws/mlx5hws_table.c:492 mlx5hws_table_set_default_miss() warn: should this return really be negated?
> drivers/net/ethernet/mellanox/mlx5/core/steering/hws/mlx5hws_rule.c:754 mlx5hws_rule_destroy() warn: should this return really be negated?
> drivers/net/ethernet/mellanox/mlx5/core/steering/hws/mlx5hws_rule.c:758 mlx5hws_rule_destroy() warn: should this return really be negated?
> drivers/net/ethernet/mellanox/mlx5/core/steering/hws/mlx5hws_rule.c:770 mlx5hws_rule_action_update() warn: should this return really be negated?
> drivers/net/ethernet/mellanox/mlx5/core/steering/hws/mlx5hws_rule.c:779 mlx5hws_rule_action_update() warn: should this return really be negated?

All of the above was fixed by the later patch that has already been accepted:

3f4c38df5b0f net/mlx5: HWS, fixed error flow return values of some functions

> drivers/net/ethernet/mellanox/mlx5/core/steering/hws/mlx5hws_bwc_complex.c:36 mlx5hws_bwc_match_params_is_complex() warn: was negative '-E2BIG' intended?
> drivers/net/ethernet/mellanox/mlx5/core/steering/hws/mlx5hws_definer.c:1848 hws_definer_find_best_match_fit() warn: was negative '-E2BIG' intended?
> drivers/net/ethernet/mellanox/mlx5/core/steering/hws/mlx5hws_definer.c:1934 mlx5hws_definer_calc_layout() warn: was negative '-E2BIG' intended?
> drivers/net/ethernet/mellanox/mlx5/core/steering/hws/mlx5hws_matcher.c:678 hws_matcher_bind_mt() warn: was negative '-E2BIG' intended?

The "E2BIG" was intentional.
However, I do agree with you that mixing positive and negative error codes is a bad idea.

> 
> In terms of future proofing the code, I think mixing positive and negative error
> codes is risky.  Eventually someone will write an error check like if (ret < 0)
> and it will be treated as success or someone will pass the positive value to
> ERR_PTR() and it will cause an error pointer dereference.

Agree, will send a fix later to make all the return codes negative.

Thanks!

-- YK

> 
>      971
>      972         required_stes = at->num_of_action_stes - (!is_jumbo || at->only_term);
>      973         if (matcher->action_ste[MLX5HWS_ACTION_STE_IDX_ANY].max_stes < required_stes) {
>      974                 mlx5hws_dbg(ctx, "Required STEs [%d] exceeds initial action template STE [%d]\n",
>      975                             required_stes,
>      976                             matcher->action_ste[MLX5HWS_ACTION_STE_IDX_ANY].max_stes);
>      977                 return -ENOMEM;
>      978         }
>      979
>      980         matcher->at[matcher->num_of_at] = *at;
>      981         matcher->num_of_at += 1;
>      982         matcher->attr.max_num_of_at_attach -= 1;
>      983
>      984         if (matcher->col_matcher)
>      985                 matcher->col_matcher->num_of_at = matcher->num_of_at;
>      986
>      987         return 0;
>      988 }
> 
> regards,
> dan carpenter


