Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E87E3794F4
	for <lists+linux-rdma@lfdr.de>; Mon, 10 May 2021 19:05:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232496AbhEJRF6 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 10 May 2021 13:05:58 -0400
Received: from mail-mw2nam10on2044.outbound.protection.outlook.com ([40.107.94.44]:44064
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232394AbhEJRFk (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 10 May 2021 13:05:40 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EGCMfWQ7/Ey8t4UttBRcgMpVnexAIDgN0P/axpvNiL1Jsdf5haK6dC+meAllwhqh4BNZpLZ348s2N9xvdW2MExcp9EEZNeadlShWotC8mU69SV337Sc/g2Y8yidmd8X6ZyQfF0UMlFiOgYQqZbCKfm4MmuQsF3dwN6s0/uXr5KLYcaERoOLDl+ZBObOcSehQCwhdcHU+07w0UnBEbxQMW9d5BPvaT6F+Euk7LZ3ZU0dtPz8oAgLY6eqqDJZDDzOhyxz9I7k1yCxqQan6PSV/5nx5JsgzbIA9PcvG73Hi6lCkhB8WwoYFpQtKQQ7hIPhmgEYe00mamsztec+Fgf4Qfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pIMx+nuNFJylPYOBI3cKXVsWU6zga+zPVBUpGEIpwK4=;
 b=jjEjT/fPXK2Du+N5acPAq2Ry7izx14nzECiDWpU4onHlvllgmoQ5tQayBmZtN66Hy8l7HR7Lad1cowKaR7wjOFJkl12ktiBkGac/soJzXBo3+s/OcSB0HBfCeRNRZsQ4BmslwLzcTzm6wAHUZF6s7MEhNxzEgijnLCi+Z8XFYZXpweSF9bXGg9BpFOL7eJF+0sF7k0PUmCApuNa6rYIs2E0eagKdW9/b27Mmq+WRByutdelYAHKD2YZpMqMuN21sgxl7h3a5DSOIBETEhf6taFp8rRQIwWT8my/Ck8xD6LcH2o+adO5PhWRONf8LffMWDgUn2LZ25XODiP4OuzqqcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pIMx+nuNFJylPYOBI3cKXVsWU6zga+zPVBUpGEIpwK4=;
 b=f6VI/5zy6nmE5PX5HtcIKVnXQy3pyWyuA9ObLI64EKcW8FC0KRcTlKIA6LzmAvTEuqjc4Dg/DQr23vOL+kRxuminadbF1qS6MVhnAnX4HEM+5y8YdpopQcbYq25j+rHfarXQugB0rJi2jmRm8/QNUl4JJGvwFusbiDxsGaRQIY5EY3U99xS1NJ8KxAW0ghGLaj7s/N0xzAXouIYn7pGigviWgPzwRegO8Kp6AS9wJ6Zg8hXpI4t3zt0loThOM6x3f6fMt6xqKUQ9Tj2yqUF9CKpNX4rI0T93eVg0jKHRDO88JdlA5rIr1XrPcRdWxN4ro1JeOawWkf02H5cPbksdEQ==
Authentication-Results: oracle.com; dkim=none (message not signed)
 header.d=none;oracle.com; dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB4620.namprd12.prod.outlook.com (2603:10b6:5:76::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.27; Mon, 10 May
 2021 17:04:34 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::ddb4:2cbb:4589:f039]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::ddb4:2cbb:4589:f039%4]) with mapi id 15.20.4108.031; Mon, 10 May 2021
 17:04:34 +0000
Date:   Mon, 10 May 2021 14:04:33 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     =?utf-8?B?SMOla29u?= Bugge <haakon.bugge@oracle.com>
Cc:     Doug Ledford <dledford@redhat.com>, linux-rdma@vger.kernel.org
Subject: Re: [PATCH for-rc] IB/cma: Fix false P_Key mismatch messages
Message-ID: <20210510170433.GA1104569@nvidia.com>
References: <1620219241-24979-1-git-send-email-haakon.bugge@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1620219241-24979-1-git-send-email-haakon.bugge@oracle.com>
X-Originating-IP: [47.55.113.94]
X-ClientProxiedBy: MN2PR22CA0011.namprd22.prod.outlook.com
 (2603:10b6:208:238::16) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (47.55.113.94) by MN2PR22CA0011.namprd22.prod.outlook.com (2603:10b6:208:238::16) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.25 via Frontend Transport; Mon, 10 May 2021 17:04:34 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1lg9Kb-004dNC-Mb; Mon, 10 May 2021 14:04:33 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 985f34da-c55c-4793-82fe-08d913d5afae
X-MS-TrafficTypeDiagnostic: DM6PR12MB4620:
X-Microsoft-Antispam-PRVS: <DM6PR12MB4620AB15A18526EC9495281DC2549@DM6PR12MB4620.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AmeVgGOor4rUYeHHcHGU7TyT8echCEtn8W9t3kMQqMkufVrZbF5u08y9eeMgYCfKcrR1iyT4z7oh0AboR54JWhdJVmt0vvayHl0vA7cAQ8UuwidDgA/dNijA0qEuhJgR4T9a6DIUzfd8VgHuNWdnPq9ciYKF68nX1FbKa5vBFTorE12tl4kgy/gekBFQKVkWVUC4SP+8fzRTPJMdXCf7uhv0q1+/ylTM38c4Hs/24oVm7gvckfP4qbKyTkkdxga1WNzMUhezlcE7MCOxW5LvgjSI13zHvpLBJUw3mXIHXIFednxBKda4CRJLb/l09uIrbAlAvnLI8Bzqn0Is/4DbkEKPJMU5mz5BzEvPe7/QfGWkMdyXQ3xzzDlMUrCH1HeLhdUpsUlDZa7CNAfK2G/YJnuGbO+0aK/2WqQS57V7UCSj2slsHmwjiLIYeQfM7AJsJoeA+VPyowvLNMcCTKeGWpeiN5sapXmPBVDo+fLyf4De080obo1T3J1/2c4mNYGMiZNM+g0eod/HdA654SgjZfYhqAf9fmm0LD6CK5XDkk3w+ecqjWmtiQMVVzZ6oCW8ou2GCf6QyWNV/qTpwCUDfAJKhix1MSOHFTYQsx8xZBk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(136003)(396003)(39860400002)(376002)(366004)(9786002)(478600001)(9746002)(86362001)(2616005)(8676002)(6916009)(26005)(15650500001)(33656002)(36756003)(83380400001)(66574015)(1076003)(2906002)(66946007)(8936002)(316002)(186003)(4326008)(5660300002)(426003)(66476007)(38100700002)(66556008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?UzhnUXZsdkYvY3hTR00rc1V4SzVta3d1QW04RFRpNkRWcFZlRHF0cFRGR3Zx?=
 =?utf-8?B?RHQ0VHplRHhWeEF2eFZNczd3Tlo4a3Z2SjBiSmRuNGQ0OVRhbmJva2VFYlJq?=
 =?utf-8?B?WkEzVElzeUJubmFra3JtcTlFVVczY0pWUk9DY1N0dzZKaWJsMCtYZTZUZVdQ?=
 =?utf-8?B?cmduaENzaFhnNVBIbG1NZDVDM0tqeFB2OXpqS3BFNzk0cjFiTmJjRkN6Z28z?=
 =?utf-8?B?RlhKK0tqT0dJZlJtT2E3ZDNkay9NSzBtTlFqOTlxaUwvUkNCbUxCeFFsRnAx?=
 =?utf-8?B?U1Y2TDlwWEVoVUVWNm0rcjFPUjZ2M2N0UmpWeWc1TGE2aXhBU1V1eTZKU3pH?=
 =?utf-8?B?Tk5oUzdhMFN1MXd5eUpIdFB6Wk95dkttdWY0T0FOWWl4WmZCOWpPV3RwdjZX?=
 =?utf-8?B?ejNXTWg0WVB5K2JwSE1qZ1AycFd4U3JpMHg1cjNZNGNSOC96RjdmSzE5ZnFk?=
 =?utf-8?B?a3cxMGp5SzFqdXdNampHSm9lbS9HcE5oSEltUHJtT2pPeWFybVdVSklNSk9I?=
 =?utf-8?B?d2JGeTJ3NGpXZW1tNXVhU3EveHRRdzMxTEpOcTJJMzNQVFo2U1E1YnJWVGhn?=
 =?utf-8?B?UElSakxSM1dHT3ExaVVsREFRQVNka3YreFdrbFdJQjdKZUYrc2NaVEVpUHI0?=
 =?utf-8?B?ZU1GSTZ0dEsxcGRkZ0E0UGRGRVB4L2kyVzJicHBRNkZSdEVJQ0YxdHZHVWpJ?=
 =?utf-8?B?WDNrT1gwTW5uMk9Ha3F2V3NOK1k5aGZhTGM3a0J3WDNGdkIxNHVrL3ZnbDBj?=
 =?utf-8?B?Ym5CcW9jUWh6R1FJdWNTQk0zNnFQM3ZBNjlLWk9TUTdNcjlsWVd5NHp5MHR0?=
 =?utf-8?B?WVV3ajRab1R5VnlDSUZZT05KaHRpazBVYW1UbDhGRjUxdE1YVmxYWFlJNFE2?=
 =?utf-8?B?ZDZDdkZESlN3RCtMWkc2N3BZdXJVVDJ4ZVhicXVLOWxZd21BWVJRZklJdm1G?=
 =?utf-8?B?TXpkdVp0UTk2S28wcG1CMUF0VlFuNFArOVFmZnVkRUJiNGpFZmVyZlJiemoy?=
 =?utf-8?B?KzJNQlJHUjhmTlJqM3k5M3BJYjdPVjk5MWpOSjVHRTdjRWpoTGcxUUlSRUhw?=
 =?utf-8?B?L1psWmdiSHpyR1NWalRSNGRBbHptZ1BDVlBVaDZYK2JsK0JMcHVwZnFWNFZp?=
 =?utf-8?B?Q3V0RURZckdUMFYwbnZpMjRuMUp0MHdXejBXbWgrMllFRmduMGtSN0NwUncv?=
 =?utf-8?B?NFN3QU9tTmE4ZjN4OHB5bnI1czA2aFFJWUpKYlN6VDF1SmdwWmRDV3lDcUx2?=
 =?utf-8?B?eG96aDFwVC82WDBoWFNjZFJoTXYyc2UxZ1Q0Z0cwK25iam5tU1dIQW9ad1Rz?=
 =?utf-8?B?bmR5d3Q3cXdkcS9OY2g4MlFQbFBRajNHaWZJdFQ1ZVZmbVdUT25NSHhTOGpx?=
 =?utf-8?B?TFpGS0djeFVqR2ViSTdQL2NnYzZPbFA1UFdYWUpEa0Z4RzBvY0JVR2tuK3Js?=
 =?utf-8?B?NmMyWlBQQlZqYjhId21UNmNtL25GUVlGMmRZRFdMZGI5V2lYM3d4cWFsSCtm?=
 =?utf-8?B?SVpzUG1icGdhb3FPUWIyempPbEd0aTI3WGhFK0JpM3hsUFR1Q2l1MndjVkw1?=
 =?utf-8?B?NlNLaGhvaFMvd2cxdVQwckJldGtrNTcxQ3RyUFJBTlVJbFZzQTBHc1hvck9Y?=
 =?utf-8?B?MFpibTBYcjV3QW13ZVhkVnN2Q2w0N21wUlZpMzZWcnJqcnJqajlDQWM3Tm1v?=
 =?utf-8?B?V3JsOHJ6ejlBYXR0VkVicmZkV3daYW9pdjJiMW1RM0tpalV5M05EWFQ3QS9h?=
 =?utf-8?Q?3KvTI0/lr0rwk5wdEi/4I58TjKAcffRDkLlLJA6?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 985f34da-c55c-4793-82fe-08d913d5afae
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 May 2021 17:04:34.8156
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gR2IPnJErRGP78jq16rI/6JbKtGtW6akZMUioJN70yPUHhcgkmbNTvWRZ1wEK6uY
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4620
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, May 05, 2021 at 02:54:01PM +0200, Håkon Bugge wrote:
> There are three conditions that must be fulfilled in order to consider
> a partition match. Those are:
> 
>       1. Both P_Keys must valid
>       2. At least one must be a full member
>       3. The partitions (lower 15 bits) must match
> 
> In system employing both limited and full membership ports, we see
> these false warning messages:
> 
> RDMA CMA: got different BTH P_Key (0x2a00) and primary path P_Key (0xaa00)
> RDMA CMA: in the future this may cause the request to be dropped
> 
> even though the partition is the same.
> 
> See IBTA 10.9.1.2 Special P_Keys and 10.9.3 Partition Key Matching for
> a reference.
> 
> Fixes: 84424a7fc793 ("IB/cma: Print warning on different inner and header P_Keys")
> Signed-off-by: Håkon Bugge <haakon.bugge@oracle.com>
> ---
>  drivers/infiniband/core/cma.c | 22 ++++++++++++++++++++--
>  1 file changed, 20 insertions(+), 2 deletions(-)

What is this trying to fix?

IMHO it is a bug on the sender side to send GMPs to use a pkey that
doesn't exactly match the data path pkey.

Jason
