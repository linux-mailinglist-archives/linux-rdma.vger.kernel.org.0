Return-Path: <linux-rdma+bounces-2352-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DBC48C0184
	for <lists+linux-rdma@lfdr.de>; Wed,  8 May 2024 17:56:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8F8DC1F27CEE
	for <lists+linux-rdma@lfdr.de>; Wed,  8 May 2024 15:56:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D93D6127E34;
	Wed,  8 May 2024 15:56:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="tuNl7ZoG"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2050.outbound.protection.outlook.com [40.107.93.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 369881A2C05
	for <linux-rdma@vger.kernel.org>; Wed,  8 May 2024 15:56:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715183803; cv=fail; b=QaLiSAhjT8gLkbjw8Jq3zvpo0sZ/wc3aoFYEhW2UALnbv+4Yd3B93SJILezFiGJmBFTOFmRNzvSYV4BtW5kE+NYIVtW+Ssl3Lou5BPl8U3S1oO6pzJNCoeYjDQqUkE+7cGxFHnwMZgw5FutiVN7gjvqW0OsiLhKQP82VLYCWmF8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715183803; c=relaxed/simple;
	bh=bYuM6WHrGwA9ySB1D9iE/cRavCHIwKAXr0mz5BiM2LA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=gKy6HAKPvGwsMEAdWGTplrwlRB+WE4mkxRj677pKW4rlneSrBRwGfVmLwZ78qgVvIhrSOFqHIH7tF50861TUwP/ByB+jwtF4bD7/C2/cuqvY8kxGEeN818M3YCU10cjESPDH6gKxZ5ruRDwXhf02jCm5ZuATEjUhqNJsdb5JlRw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=tuNl7ZoG; arc=fail smtp.client-ip=40.107.93.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W3vhivKl0ZiMcIPikD5/AmruWHCB6yunGymILgzzw8yfvq9H4c6RwUuiGXGJ8q69tlFTXCbDKK3wvQ8Dn+F9Y/N9p9UmjfuEzbjB5Tokyf1OZ6AQ2QKHcDdvrarSTQ89c6ujj6wwgtLqOJ7MBp09Wyk83z4c/N20ito4GHMPiLiRcptjzu4loTWNrR4t5J8fwL59FarH+17pfaZkQVsnpEsou7JjtcHQfwwr8SUlWyqd6lX8qi/RQOCrGiJcpuEHnB0Fd0bJXk3seQlkECBKikioQKd68+SSl//ojFIvta7hWXZsGrASD3DVSGU/FjB6K16/M+kWXrAdeDq9iN1gZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=exo7tsXZH8QAGmNIkzEJIPdxG3Tf0OkEUF9X4/q7Ez4=;
 b=mvpQC0SbRMCiSQ8/kYz3aMdyenB2CUjFQznRbKXB+ePP6mNUGl81RIDloUjAuuH1F7/Y/lE0erZ/4WAmOOvKWE5F37QQ6rrQnWsT3cRZ86RLQ9qQwra+PXw9RJr/wU+zG7e5LtUZzb830ci4tFu/jaRhaKfg2IuQNdHYVOLUjr0ugEm8TjXvaJsSAp0f2r79W3japKQaEW5toE4feE/+AwHaVPXnE5/eO12Uz5hgx5jUoOT70oHv/af/pRUu5GCRykoelDNkTaTBeUolhnS86VsdJRUvNn8KDFS9kGJCZO11lT22DBssM7h3ZmGAc3vPHl1SenhruuyET7+G1Qa3/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=exo7tsXZH8QAGmNIkzEJIPdxG3Tf0OkEUF9X4/q7Ez4=;
 b=tuNl7ZoGxQDiNJ0CWHx8cIzhyES3KP0ldW/G/ULOtJfrVBs2X15B9WXSNkrHjE971ajS7tz/cT73s6aJrFu7Qr8KeiXfHui5t22Z+mwo205cqFV3ywsqP7kZuMW46bEkIyXjLyA8IOaXNVZ4Hv9gBVNDKPgAkLCxTfVP3oZQSUrY8w7a1Aq6rRxuItlycQ+S3a+NiKGjKwRbJyjtwfqADWdeAkg+WFeZVPrfix9BACx7aWmU8aqYiLlLYlvb5FFO7VKQKtEQdvIFwEI52JdKQhF5Y6YIT4rT1hVux/xzwscpKIhh25vAe8w+NlzyKoJctwtf6csJyXKqpYHpHB3tiw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3849.namprd12.prod.outlook.com (2603:10b6:5:1c7::26)
 by SJ0PR12MB5663.namprd12.prod.outlook.com (2603:10b6:a03:42a::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.46; Wed, 8 May
 2024 15:56:38 +0000
Received: from DM6PR12MB3849.namprd12.prod.outlook.com
 ([fe80::c296:774b:a5fc:965e]) by DM6PR12MB3849.namprd12.prod.outlook.com
 ([fe80::c296:774b:a5fc:965e%3]) with mapi id 15.20.7544.045; Wed, 8 May 2024
 15:56:38 +0000
Date: Wed, 8 May 2024 12:56:37 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Zhu Yanjun <yanjun.zhu@linux.dev>, Chuck Lever <chuck.lever@oracle.com>
Cc: Yi Zhang <yi.zhang@redhat.com>, Guoqing Jiang <guoqing.jiang@linux.dev>,
	RDMA mailing list <linux-rdma@vger.kernel.org>,
	Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
	leonro@nvidia.com, chuck.lever@oracle.com
Subject: Re: [bug report][bisected] kmemleak in rdma_core observed during
 blktests nvme/rdma use siw
Message-ID: <20240508155637.GL4650@nvidia.com>
References: <CAHj4cs9uQduBHjcsmOGHa8RaNGNMw8k8bBhZdGgdeEKPFeB8qQ@mail.gmail.com>
 <7de9793f-6805-1412-3fae-a5508910124b@linux.dev>
 <CAHj4cs-RiZXAdz131ihQ=wsW8nsViphJeHAD_i6qi7_DtW7NwQ@mail.gmail.com>
 <CAHj4cs-HWjMq__89RR1WwLcOa5H46H8+d2t=jj=qFJ_m5kRwFQ@mail.gmail.com>
 <c9e68631-0e60-578d-e88d-23e1f9d8eb2f@linux.dev>
 <CAHj4cs99vDgjfA8So4dd7UW04+rie65Uy=jVTWheU0JY=H4R8g@mail.gmail.com>
 <54eea59a-efcd-c281-e998-033c6df81a28@linux.dev>
 <CAHj4cs9xwzrhRPoZ2t69b6F2JL8X9mZNVmwBfW2y5g7ZdbR8vg@mail.gmail.com>
 <CAHj4cs-mz5Dh6WrqB3PzoV89YaMTHrt9PbJv_4ofQD2r0BktTw@mail.gmail.com>
 <9eb4ed5e-0872-40fd-ab96-e210463d82ee@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9eb4ed5e-0872-40fd-ab96-e210463d82ee@linux.dev>
X-ClientProxiedBy: BLAPR03CA0026.namprd03.prod.outlook.com
 (2603:10b6:208:32b::31) To DM6PR12MB3849.namprd12.prod.outlook.com
 (2603:10b6:5:1c7::26)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB3849:EE_|SJ0PR12MB5663:EE_
X-MS-Office365-Filtering-Correlation-Id: 18199bf1-445e-4b90-1fde-08dc6f77722c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|1800799015|376005;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?d1Q5L2R1RWNnYk5KOGFUNHNJY242TGZsQjBVSXU2bkRSM1NlNXdGZ0lsU2c5?=
 =?utf-8?B?cTJUSXIvcDNaODc1a1N3UE9ZMEhGNVB4RlZ1NWZCY1JXdTBabUw4U0FpeTRw?=
 =?utf-8?B?NCtQMkM3aDE4R1hXYXZUUjRyblhIQzhQMEhTN0N5UE10WlY4MWlHeG0rNjAz?=
 =?utf-8?B?elJaTzYwOGlKU3hYd2NSdWRZQ0hobG0xeFRNbnN3bzR5YTNEOTJucGRBdHpY?=
 =?utf-8?B?Y241ZjZwVGxDbzRPanRSbkNadkk1Sk5rajg0aE5vS1BGc25YdlNsNW5mSEMv?=
 =?utf-8?B?eEYvQlFZZGNQeFc0TjB2UFFqeExqR3BHQWhjR0ZQbEhGbEx6RUZMRUxPbHY3?=
 =?utf-8?B?QTZrVkxFekF5VXZ5dUo1R3dOTXBGcWZ6RzBzZkI4aUpQVVVTNlY4bUZVRDBZ?=
 =?utf-8?B?WFhlNE8rZEtvKzd6ZktWczRjSmFnOXRzL096aXdBT2drTkJSbW1zZkRaT1RW?=
 =?utf-8?B?aGtGYmdBcU41SWNEK2gvYmN0VGJKSVJSc1dieDVNR3VWTWIxZEtKcG01bVhR?=
 =?utf-8?B?SUxUK3NlRzdyRnF3RkRkdnlQOVduS1VDRmJlK05qU0FIRHJrdVk5S1p6MCsy?=
 =?utf-8?B?bUN2UXVhRFNqOXdmWTlXS0ZDcGtZb3VEY1VhdjdYT29ETG01eFgyKzVkQ2dl?=
 =?utf-8?B?UWlIV2ZSUWdKa0tjUHNldDhKcW8rUUt0cU5YQ2dMSzZjSVRsai81d3NjVjZV?=
 =?utf-8?B?enF4VDJ3RWRpQk12N1pKTXM0YlJZS1JuazhFNTdEVFRybk9ORzQ4MVZGOTRi?=
 =?utf-8?B?YjBUS1plaFUreUpiYVgyWWtBMjE3OGFWT3VHZ21Bb1NYaUZiM25OTWR3bi9i?=
 =?utf-8?B?dUJlaXZVWkUvUEEvQW5RZUJ0bmxYejhsWVowTEwySGovUy9lYnQ3WUsrZkc1?=
 =?utf-8?B?OTdTSVRVRnlOK2p3SGp0SUd3ekVtaFZpbUxXZVpQemM4Z05EOFFFbjMzVURD?=
 =?utf-8?B?RnVnaThNZXpNYmlOTjQ0cVVhckM2UXdkRU1TZWJTTGU0dERBZVFNNjZPcHFM?=
 =?utf-8?B?d3Z6Rnd2QTFUVFpFYUhDeUVZU3VZTFNKWWlFNEx1R2h3cjdUNWZnTkl4eXFG?=
 =?utf-8?B?R2M2QlgwWEVSbXZDbXdQK0VQVW1tdDlJSGg5ZUdYNytjakM3STQzNTc5NHFQ?=
 =?utf-8?B?bG5kckdtUHVUUEg1K1c1S0QydWFCMkNNdWpPbHBZWjU2djJMaDRUZm5sSVJ1?=
 =?utf-8?B?NUtPV1J3eTZtN3BNdGFHWTNuV0ZDcm9Tai9ZcFA4c2dHR2VleUg3dzUxVUZs?=
 =?utf-8?B?WFoxaXV4NUdFZTZLM0FaaG9LTmVFUnNTUDBVd3FLS05SWmdLOWVTOHdDNjIw?=
 =?utf-8?B?VVVsSGl6RlZPWG9oTUdnbUtwRTA0cEtYNEpIWEZIVnhLWVArdiszSTFRQ0dS?=
 =?utf-8?B?UTBiamZhVzNQcUYxc0FPT0MrY3hmYnQySGZjSnpHK3F3d0V4ckkwK1RlUTM5?=
 =?utf-8?B?dVg0UUx1T1IrbzdLYTZNbzdIV055ZWEwWXNBRTFFQW55WTNEK2JwTW1Pb0VV?=
 =?utf-8?B?QnFab1E2QlFyV1dmdXRxa2gvSGJESUVlbU5EOU5pMjBvemlPWDkrOEhKTHoy?=
 =?utf-8?B?cHVRcndwSndkbkFIdG5KRHdEWk4xdStxOGJ5YnBVeVQ5S0tvTnB3RHdmSU1j?=
 =?utf-8?B?QVh6SkxGWVE5L0hINGh1bmM0a0dpQlF2QVJGc0JaN3MyblBVRjg2Y3cwMEhx?=
 =?utf-8?B?U0FkVUYvOEhXbWwwcjlaUVAxTFhKYTl3WGNHbC9WaHI2TDQxVVQ1YnF3PT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3849.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RktnQ3NFRDNQUkF5dXN2S3ZpVmdZY0VqZUptbU1JdDl6b1R1M1FrRlRFZGJ5?=
 =?utf-8?B?RmsrTXNSYmhyN3ZYNjdybHhhUXoyWmIwSFdWaDZFeDAxZkxFelFGMmhTa2R1?=
 =?utf-8?B?VGlmRWgrZ2I5NzI0bXplOEM0M3dyVjZtSWd0YkZkVE1mbXFXTDZBcnhZMlY2?=
 =?utf-8?B?WllZdjA4R2xTN0hTWUg3d0IvWGMvR05TV01lbTdmOCtMczR6YldEYnE4Mkl3?=
 =?utf-8?B?WXBHWjJ2MDZ3dGl1SkJ6VU9DTlAybTk4TXZ2aStSTkVvSUtXOTVjZzVQay9U?=
 =?utf-8?B?NFhUOEQzNHF5NjhEa2k4a1YwQjZrdWExM05SNVVqbXJaNnlTNG1Xc21MMCsy?=
 =?utf-8?B?SWZzUm1tNGx1WWk1V0R3OEJGbkZ1eFo1NzN3RUZPdnhTRzRMSkprdzVic2JJ?=
 =?utf-8?B?RlU1eW56N0J5L1V5cXJmaTR6WmpPSXozTWwzdVp6OFpxckQxUzMrd0Y0Vmk1?=
 =?utf-8?B?UWRMSlIyZ0p0dDNrVTFIWEVBeXBLYjczVEFIR3p5NzVydnBWY1U0TEhkck8w?=
 =?utf-8?B?aldpME5jVUxrS0VvTjB2aTM0Mmo2TEgwYlkrWWRkeHY5WERiNmNSc3MwUmJN?=
 =?utf-8?B?R2VpVEliVFV5dHJCZ1YwQ0tzZGxrMXozZEhOaDFNQy83MWVISkFRNGJGMDN6?=
 =?utf-8?B?dzRkb3pQUFNnbVFCOFhaUkticG9VRVN2bGYvZ1c1b3VBU1o0Y2dhY0NscDNs?=
 =?utf-8?B?d3o4ZnZZL0tpNHMwKzdWb0hmK1dLck1MTVFoU3pESnFFdkhsUkg0ZDZJM04x?=
 =?utf-8?B?S2djemt3VHBvaE5FMklhcEcyMmFwdFZXZDdhZ2Nsa0swdDFEcC8zUmFsdFAv?=
 =?utf-8?B?ZUptbnZXQ01hY3p0dlVmc2dCei9MRzkvQVlqNHJEWlRYMURjd2FMZjA3YWY4?=
 =?utf-8?B?Sm5kS3hsejJIeXJvT0xTa0JWdHdUaThWaHBrQWsxRWgvVlNFeWQvcmdQZDVi?=
 =?utf-8?B?WG94T2xYTXlnNnFjUFdiR3hjSGZId0dyQ0dNNUJvQkxYVzlUQ3BNSTQ3a2d1?=
 =?utf-8?B?NUtJdEdXeTFtMlp5U1h4Uko0Z21FbUg5R04zNXNhN043dk9DOGpNQXdvdUpS?=
 =?utf-8?B?L3lzWGpYWUlGWXZBWGlOSWkrVlRQMzVFYkh3YUV4SE1JajVHSWsrbXlKeDl3?=
 =?utf-8?B?bENjUU54UlJFZ1Q2MTVDd3NTY0d2OG9SbWZ5eUZoeG5CSFFEa001U0JrRmxC?=
 =?utf-8?B?azVKeEVjQW9PcXVVSjdXNC9hd0FPS2x4YU9nQWdLOXFxVUs1TXRyaWZzaDlQ?=
 =?utf-8?B?aEw4ODlYSzl4RzlGbkk3cXB1YUpHTmhGQm5GRllWdVJxM0VNY0FlVnptTllj?=
 =?utf-8?B?STNjaTV3ckMrT0dRVHRqNFJXT2N4dFUzd1hicDU1Q3RJN0oydlhsOCtnaXNo?=
 =?utf-8?B?Vmo0dXg5UFp6STd4YkpKUGJFb0tmdkVWbHdyODJjQXVnSWRBT1NYWXF3c3pD?=
 =?utf-8?B?d1NmYTlPNzdqY2ZTMjdqazIzZUd2alptc0VXRENCczF3UW9YY21UOC9qemFa?=
 =?utf-8?B?cCtLWWV0QU53ZWh5ZmY1cUJDamhXOVNUMkZyeVNlQkZFL0pBdkRMSTJjVnI5?=
 =?utf-8?B?cjkyU2o5MzRaMFpka0dQMmM3Q1ZJLzFaOGtQZUIzNHl1a2pGdVhJZFRnaTFX?=
 =?utf-8?B?NGlVMXBVUmJJdDJDSGR5cHdwTjZ5dHREOFFuQmhIRk5vQWozRWtRclRKNldW?=
 =?utf-8?B?am1CRTA3c2pwNE1VbkNqMW9pTHZzdnlWa3NlQW4wcmRyeVduV1J3c3JMY21y?=
 =?utf-8?B?NVRWOUtsVUFVRHJXYURjR0xxakhRaXlwVFJlK3NUS2s4a29tYUhrUnFvL3dU?=
 =?utf-8?B?eVlMVjhNZmtVdnhDekdxc01ZNTBHUkNScS9EdVc0T1VmKzN1K3Rtc0crN3dQ?=
 =?utf-8?B?VkZ2cXhtVFZ0c3Rlb29HMHkwRXBscDYreWdxNGo2REErSjJGa1FEOFhabURz?=
 =?utf-8?B?UVI2dUszeW5BWTZDbWpMWEpkem1NWXpJbDJTeDNTYlQxSEN2elpMdVlFQ3ZW?=
 =?utf-8?B?dnJKWFowcHN0UFVvclZyTk1HSml4ZmpCNGo4dHN4ai8zcVcxQkZNVTc5NHFV?=
 =?utf-8?B?TjdZVTdlRTFydERaQnpodjVXMzlmZXdvSXUvOXh4b0k0TXhiVkZZQnZkMHBF?=
 =?utf-8?Q?XdquIGejLU9cElmcl/MICW+Ho?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 18199bf1-445e-4b90-1fde-08dc6f77722c
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3849.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2024 15:56:38.8201
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ElRddDuQWyBXrpfvQ4jg03VH709edGuX/IbtKbI9qmwtO9D0RL9r/EME89EDvfix
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB5663

On Wed, May 08, 2024 at 05:31:00PM +0200, Zhu Yanjun wrote:
> 在 2024/5/8 15:08, Yi Zhang 写道:
> > So bisect shows it was introduced with below commit, please help check
> > and fix it, thanks.
> > 
> > commit f8ef1be816bf9a0c406c696368c2264a9597a994
> > Author: Chuck Lever <chuck.lever@oracle.com>
> > Date:   Mon Jul 17 11:12:32 2023 -0400
> > 
> >      RDMA/cma: Avoid GID lookups on iWARP devices
> 
> Not sure if the following can fix this problem or not.
> Please let me know the test result.
> Thanks a lot.
> 
> diff --git a/drivers/infiniband/core/cma.c b/drivers/infiniband/core/cma.c
> index 1e2cd7c8716e..901e6c40d560 100644
> --- a/drivers/infiniband/core/cma.c
> +++ b/drivers/infiniband/core/cma.c
> @@ -715,9 +715,13 @@ cma_validate_port(struct ib_device *device, u32 port,
>                 rcu_read_lock();
>                 ndev = rcu_dereference(sgid_attr->ndev);
>                 if (!net_eq(dev_net(ndev), dev_addr->net) ||
> -                   ndev->ifindex != bound_if_index)
> +                   ndev->ifindex != bound_if_index) {
> +                       rdma_put_gid_attr(sgid_attr);
>                         sgid_attr = ERR_PTR(-ENODEV);
> +               }
>                 rcu_read_unlock();
> +               if (!IS_ERR(sgid_attr))
> +                       rdma_put_gid_attr(sgid_attr);
>                 goto out;
>         }

That does look needed regardless!

Chuck?

Jason

