Return-Path: <linux-rdma+bounces-539-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 28BB482443B
	for <lists+linux-rdma@lfdr.de>; Thu,  4 Jan 2024 15:56:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 73509283087
	for <lists+linux-rdma@lfdr.de>; Thu,  4 Jan 2024 14:56:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F35452375B;
	Thu,  4 Jan 2024 14:56:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Bn70NW6v"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5193D23749;
	Thu,  4 Jan 2024 14:56:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XHtfXKG82ZQCCKYnsTR9pH/W4l4IgOKPUz33sb72wp13JbVx4/SlWV+fX6ztSLaxG6BzNWhBMmEpVhVNiXZ3mzKpnqgwwNsCee+saamjjvbpWyBSIOjfkPGTMUOmWbxeY5gHetq6k+HvAQsCmYqI1lFqbLxVwTjzV3ycrG9wu0mcHhDK3AmaE6Y8rufgVU4y4cVnyyc/1EKu4mnC0cxLi47NTmlqv+Oxnq/WF/G+BeDHHRbhYlxTicOncivc1+coicYz5tV4SjRKvBWpOo6j8Zhh7zsARoYd9oNzCtBXg6cuk/mP5MWJOeTwj3mjx+SpbHgCul2hktlSCiY6o1wqrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/WFQGvj2uiVB+F5CDeyWRu7JK9SMXSW0gShVmXe6OB4=;
 b=Ksk+Zmmb6Yl8cmQt3TuQ70JejD8m9JLTotmw/1Qwj0KCnRtTTsXxTlH1FvwGbIF1vAp4oONmebewNQ9JAh6Xen88dsftq41wPgvBdmrGIYNvvseQjaDEyC3174YG0MTjDU+ytfYL9h3YgfH8POys/0f6ED3bu2847XqihpHfFNuVj2nAgg/1QmatFDyc9t2kdG83dUWg6KBvUSQWBwDzxvxjuA55LgFn14HaNhEj6AZUfH7DVA/soPXupOpE3GOchnXZV9oE/HYZNWsiuAdv44vLsBqebpOWAvnhrGDA9XfLjNsxfDqWiya/WNhL4ipDdM9BIA3A5Iglc3kvsXa1Cw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/WFQGvj2uiVB+F5CDeyWRu7JK9SMXSW0gShVmXe6OB4=;
 b=Bn70NW6vPWsJoFvyJFrdphh9ZbwfotTqXpHhaw+PzD7Axp5on45SKHoHLYToM57ep5+Fu4TXFcmuPybZgGg5A8zKJogqQy5eGJ2Rg+/VXF6YS2tDMpXY2//+DK4y2byIuA9ducGFqUHMmLykgMq4LRwXuAkQHcgKJmUbnZ/ZunjWTmnMYgKuaMk/ak4fchNnIujCH2SaWZSDO3IU5Sv90yj2NQQdKQqCHIim0+/+1eUoZGumwI8y1qMG2UfEuDKAW9ExX1lqdMe/3eq5jTEpvRH7TdLo/oB+n5knHhw36g8apW6Q4u8Rp62vlITJz6EkRJFAPlrh8zMg5NZudHGCww==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by SA0PR12MB4445.namprd12.prod.outlook.com (2603:10b6:806:95::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.15; Thu, 4 Jan
 2024 14:56:30 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::60d4:c1e3:e1aa:8f93]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::60d4:c1e3:e1aa:8f93%4]) with mapi id 15.20.7159.015; Thu, 4 Jan 2024
 14:56:30 +0000
Date: Thu, 4 Jan 2024 10:56:29 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: "Daisuke Matsuda (Fujitsu)" <matsuda-daisuke@fujitsu.com>,
	"rpearsonhpe@gmail.com" <rpearsonhpe@gmail.com>
Cc: 'Zhu Yanjun' <yanjun.zhu@linux.dev>,
	"linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
	"leon@kernel.org" <leon@kernel.org>,
	"zyjzyj2000@gmail.com" <zyjzyj2000@gmail.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"Xiao Yang (Fujitsu)" <yangx.jy@fujitsu.com>,
	"Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>,
	"Yasunori Gotou (Fujitsu)" <y-goto@fujitsu.com>
Subject: Re: [PATCH for-next v7 0/7] On-Demand Paging on SoftRoCE
Message-ID: <20240104145629.GY50406@nvidia.com>
References: <cover.1699503619.git.matsuda-daisuke@fujitsu.com>
 <20231205001139.GA2772824@nvidia.com>
 <d639b4e3-e12a-47e8-9b03-2398b076fdbf@linux.dev>
 <OS3PR01MB98659C7691D5DFB98D98D2BDE58BA@OS3PR01MB9865.jpnprd01.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <OS3PR01MB98659C7691D5DFB98D98D2BDE58BA@OS3PR01MB9865.jpnprd01.prod.outlook.com>
X-ClientProxiedBy: BLAPR05CA0040.namprd05.prod.outlook.com
 (2603:10b6:208:335::21) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|SA0PR12MB4445:EE_
X-MS-Office365-Filtering-Correlation-Id: adc1c133-be3f-46c4-4b9e-08dc0d3555be
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	w6tVMqF1amG8sGQ0LfvbpOq7xKcI7+g4Uc1rwdQeqnQPWFk5LQmQYq6nZdJACpLGmwg8Dck6QMADsDKtlTzqrbDkvGehySJXq8MFvEgj9Qnov/ytfTd8prMCsHZ8F2tiRAbP0dVEmWfm0q4Y43AA+0L6aSNy/kJMfbDcv6AiCSUqU84oGitWUsqIrl76z3r7ej5OHmtSRV/cNrZ8CISpcSbT/y/7C+2cTcvcW/4b9LJ1TJbWv+GTs+0zwsEvJO8ogocG29QuOr1TmJyqiF8AKkPzzF8qyuO3etmcF8T+LMfhHvHCNPlHsUK/SmwyLCdM3bxtuwv28vELTDRZ3x6MiYb1J1EaRLHgAsp/L0SxiE9QeH7CYzcy0fVa/kH5JcG9j4bqGhrnipL66sxapx70QEHOJXEfO25tIuahtj2uq+7TReTrgDaBNSZxYV+XrbvwSRf+xrUs1Fp+gnNg9bVYmM0GBpbVlYu/4YtO44IArt+xUTBFcUboWzWv9jXPvM2nBt6EACCNMYuaGQPLGrZiS36CVSVqIg4mcT+FuLqcyKX97jvuG+zIZWEfx1VhJbPDQU6JX6DJGwd3e/vyE5Xa57x5Kw9CewEo54YH9DLV5uo=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(6029001)(136003)(396003)(346002)(366004)(39860400002)(376002)(230922051799003)(64100799003)(186009)(451199024)(1800799012)(6506007)(6512007)(83380400001)(38100700002)(86362001)(2906002)(26005)(2616005)(1076003)(36756003)(53546011)(966005)(4326008)(316002)(110136005)(8936002)(66946007)(66556008)(8676002)(66476007)(478600001)(33656002)(54906003)(5660300002)(7416002)(6486002)(41300700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?U2R4ZVcyM0xpRko2Q0dLTTFWSkg1aVhXVllXRmVhdUxocHhnQWdVc3BNbXpL?=
 =?utf-8?B?S011bWJubGlKMGhNSE4rTVV3NnZGM21PQ2w4KzZEbEt2SUx4L01xSUxMM3B1?=
 =?utf-8?B?UllSQStTMFJ5K295aG0vb3ZQeVZ4WUhGTDU3RlVXMWRRYmZiOEZMejl2cENJ?=
 =?utf-8?B?QVIwOG00SUd5MTZlZk1mR29NZC9uTXZZd0RnRjBJdmJDd3VOODVTSDl0UzBU?=
 =?utf-8?B?QUplcFBQL3JoOHdFaC8yV3UrUFJ6cFQ2TjZORlEzanBYZGF6ZERKZEZJSlRD?=
 =?utf-8?B?V3RYZ1NYdGpUWnFPL1ZKVjlhNlBPOFhaMXBLRWZGcjN1STRJbUV3Y2EzbllC?=
 =?utf-8?B?eGpMejJvSG1OWFpST250Y1BFaWVFY3JmMFFBa0tDYkpXMUNmdXYyTXpBS2I1?=
 =?utf-8?B?YWpYWndUMnhEakVJSnhJcHdDTmZVZy9PUVhUUmdid1Z1d0R0ckt1R2IydTh4?=
 =?utf-8?B?cW4xSU9JZEhuYTRUTFlLVkZoWE84alJnVGpiQnE3K3hOcm9UeVllK1dXUnMw?=
 =?utf-8?B?dVgrRUhBQm93eXVuRDNVdVhGWE9vOURWRXBLbVRUV3YvdTM1OWNWTlI4LzRF?=
 =?utf-8?B?aDBuWWhOanhKUm1LR1Q0Rkd6WUxGOEZsUTBOS2NUMy9xT0x5TDRJSmV3cDhh?=
 =?utf-8?B?TExnSHlJRHlQU2ZmSDI1Q1ZzbUszeEFNQVo4bUkvSm9MR2dyS3g3TlRKU3hL?=
 =?utf-8?B?NDdQVFkwc0lRMTlXN0M4bmR3NENDdWtwNjc1MmFEU2tncTRqcHVMSVh3cXNm?=
 =?utf-8?B?TEJwc1JqYTdWa1lhOFFqS205cWt3bEphb0gwYlNqekw2c0ZIanA4bldZWldx?=
 =?utf-8?B?SHNRaFNRTkZMYm9nYUNlUFNIeDNQWUJtWU1wcFptUGM4SnI3SmdUSDRac2w4?=
 =?utf-8?B?eVdDajZnUFM4ZzhUb2t6dklzZ3U2eHN4NXhYcVR4dS9KYkFHRXBiTXhlOVdh?=
 =?utf-8?B?WDFhK0dRMzFlRm5aMkdjRWZuZ1pLVERvQjhCSWxGMFBQMnRiMkN6b0Y1RHBM?=
 =?utf-8?B?RkhtQzZHenI4Y2JFZEhqSVV6dDVURjNpTDFSMjA2WU45Q2xYNXpyTk16cWxZ?=
 =?utf-8?B?b3FFT2Faay9KUDN4eWlsZGtmb0t5d1VoU2dKNEhRVlZKWkRlR3I3MmxrV0p6?=
 =?utf-8?B?L1VHR3pvdmtwaDc3Q0hBaUUxeENZbm9DVER6L2E1MzB0eDlTSk1hcWszTjQ1?=
 =?utf-8?B?bUxBUzlpOWFuOFFUUkhiaFJsaUNxMWZKclRMczBFRit1Y3JvcG5RY3l6bitk?=
 =?utf-8?B?RGhDdmloUU92UEdBamNzOUZnMzZUVXZKeWxlZm4zNytwbTBCbUdkMGtWcitL?=
 =?utf-8?B?eDI2a0o0NC9SU0Uvc1hKbU5oRU5mNERjNm1UTnJucU1hNExNdTBwYWgrVEJ1?=
 =?utf-8?B?SFJyYjhaWnVLUTJ6a1lpZFhDSWh1ODUrRGZLYmlnQjdpQUlVL2R2Y1lDdm03?=
 =?utf-8?B?eTJ3dW1WWWVlQmhHT0tVSHZZT21qekVjLzRpN3RGUmxQOENESm54ZU1YM1h5?=
 =?utf-8?B?Tk1HSVUzejJzUGJtbkhONWFaOVkvMHFqTG15bWNjUS8wWDZmSG9mdE40cVpX?=
 =?utf-8?B?RG5haDJVcjZjK21GazZmSUdvRGZwR2ovYTV4a0c0THVGMmtjSEhUVWs4d05Z?=
 =?utf-8?B?RXhOY1dSaTJFdytFMUt2ckx4UU9yZjI1Mm1XeCtBRW5YbGN2Z2NFb3dQTS8r?=
 =?utf-8?B?OWVnbHQ0UkczZUpCN2xyYmF2VDJZR25mWEtJTkQ5Z0JMeHVSdmxVMWJFS2Qw?=
 =?utf-8?B?UGkwOUFhSFl3NlFzSHNLeHhMM0ZHU1o4YVUraG50UW1OYTVEM3puQmVkWUl6?=
 =?utf-8?B?RzJRQWwwZjlXeGRYTURoSW41dS9XdTNkSER5MVk4YW1zUTY4Ykg5SUdtUXIv?=
 =?utf-8?B?OE53a0NrQ2RGTGp4OFZnc2p6UEI2cnJjZDAzQy9zYjRiQVZRdmkxRWt2Yzk4?=
 =?utf-8?B?RTZKUXhEeTAvcHQwRWl5SnkrU2pBMjN0NVpxSWEvTEhjR01BUzlQVnd1c2wx?=
 =?utf-8?B?R2EvVlZZeis5amlWdElDYXRXdUwvbldBSEZaMWVmVDkrV3RqU2c5RXJXZk1H?=
 =?utf-8?B?a0wwS09rdzROS29OclNlNFpURkxaUGhCYzFzZHlMc1JiZjlhT3I5QUkxUnpm?=
 =?utf-8?Q?aQtfuLxJMi6MCeHJu9nvyBs7Z?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: adc1c133-be3f-46c4-4b9e-08dc0d3555be
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jan 2024 14:56:30.4327
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /DLrFukQ1CjdadAqevXRFlGbt2ueLyO7+kcyhJMtbDT0rAVf0NrHMi+16nlUcBkw
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4445

On Thu, Dec 07, 2023 at 06:37:13AM +0000, Daisuke Matsuda (Fujitsu) wrote:
> On Tue, Dec 5, 2023 10:51 AM Zhu Yanjun wrote:
> > 
> > 在 2023/12/5 8:11, Jason Gunthorpe 写道:
> > > On Thu, Nov 09, 2023 at 02:44:45PM +0900, Daisuke Matsuda wrote:
> > >>
> > >> Daisuke Matsuda (7):
> > >>    RDMA/rxe: Always defer tasks on responder and completer to workqueue
> > >>    RDMA/rxe: Make MR functions accessible from other rxe source code
> > >>    RDMA/rxe: Move resp_states definition to rxe_verbs.h
> > >>    RDMA/rxe: Add page invalidation support
> > >>    RDMA/rxe: Allow registering MRs for On-Demand Paging
> > >>    RDMA/rxe: Add support for Send/Recv/Write/Read with ODP
> > >>    RDMA/rxe: Add support for the traditional Atomic operations with ODP
> > >
> > > What is the current situation with rxe? I don't recall seeing the bugs
> > > that were reported get fixed?
> 
> Well, I suppose Jason is mentioning "blktests srp/002 hang".
> cf. https://lore.kernel.org/linux-rdma/dsg6rd66tyiei32zaxs6ddv5ebefr5vtxjwz6d2ewqrcwisogl@ge7jzan7dg5u/T/
> 
> It is likely to be a timing issue. Bob reported that "siw hangs with the debug kernel",
> so the hang looks not specific to rxe.
> cf. https://lore.kernel.org/all/53ede78a-f73d-44cd-a555-f8ff36bd9c55@acm.org/T/
> I think we need to decide whether to continue to block patches to rxe since nobody has successfully fixed the issue.

Bob? Is that what we think?

> There is another issue that causes kernel panic.
> [bug report][bisected] rdma_rxe: blktests srp lead kernel panic with 64k page size
> cf. https://lore.kernel.org/all/CAHj4cs9XRqE25jyVw9rj9YugffLn5+f=1znaBEnu1usLOciD+g@mail.gmail.com/T/

This is more understandable, and the fix of matching the MTT size to
the PAGE_SIZE seems reasonable to me.

Jason

