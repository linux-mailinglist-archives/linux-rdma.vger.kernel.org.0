Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D623F3903E7
	for <lists+linux-rdma@lfdr.de>; Tue, 25 May 2021 16:29:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233736AbhEYOap (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 25 May 2021 10:30:45 -0400
Received: from mail-bn8nam12on2124.outbound.protection.outlook.com ([40.107.237.124]:65152
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233635AbhEYOao (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 25 May 2021 10:30:44 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cgyy4y3jYHDZxuy+avVckmiC3r4F0RBldt3W4Ej1y45PqvbylQUvmZMGIyRJ1xYS4B9lCw+4f5XaVdL0B2pYo3G9pzlko8JBaA3nlldJhBhreNvJlSNZvG4BazeNIogRoTZGRCoGeKSIMEkskgQscXuV1Mz7/+3gGToIYIV+QV8xPly/46aFoXrqdWoflIa2/N6djJL76753cQlwgjBtF0NTddPNHn6o8frmFj0i/i3dUUWD66g7wmWyTvJuBXXP5d2l4GyG8ibhoIryLuow48TOcQSAV/fXYmRB6JcBbAckyQ5uTKDUUavX4gfTYXRnPUg8fvY4DppDaxyQVwidPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fnp79yGgN4TeoV+5FmmzTw3MzG4O8ixZ+X+WYRsgsTg=;
 b=WCenoOLtJSHrB+P0Hb0JIecCWlNuvWJLS3DJA9OmA/E5ToTZLxsfWy9ubuJYHPH0QIfkVyMhtEurBskMuzjUD1iPvfadIHsJE84ImXKXFbE4LhdxuDmKhovt043S5zntKwchu0yhC56W6zVGlYCkUIh3J5sAZUU0CZb0QOf/jWNO7pm+izdkMnhS2Ml6W6ZkzBrVJNx6PGelSZJIxVZCw+lu3ajLb1XcQu9E0spZh66doGlrk43X2ehxZpuGBlmTJVHtOR0JQjr+6WFDw1Avn0hcG1Po5nEUmZt2J9MWH576V8i41+CFtvWpC22227uPtf6BoNdZwBoE2EsIOJ6mqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cornelisnetworks.com; dmarc=pass action=none
 header.from=cornelisnetworks.com; dkim=pass header.d=cornelisnetworks.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cornelisnetworks.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fnp79yGgN4TeoV+5FmmzTw3MzG4O8ixZ+X+WYRsgsTg=;
 b=k+aOFj+0sB0bhLVcoJ9ofu6Gq0eET42X0/nvAev1T15+PuoatUiA/3BZFzfVq4Q9I8uxA8Jb2ZgnFvJXYD3oolw51wVmVPzucP1vI9cCE83Wfpc0/KkKU3jrpmK4GqQ8BzQt+fa8HIJHeGITvMRoazAPs7l/YuNce4/rOZdQSzSheLi305TKlUkhMBhfGCoSmWB4kduhGQ05OM4D/5gqn7O+Zm0oZ0OmKvXC9403qz6RqOkbRaILIJyF4QZkROSOpEQgvHe96slmrbNvrDhgQ5D13qHK7otqTE+E3q3EOqgxNJOyJUu1L+6VBCzTNHJNYVSWRkP278wQOEBKv1FzXg==
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=cornelisnetworks.com;
Received: from PH0PR01MB6439.prod.exchangelabs.com (2603:10b6:510:d::22) by
 PH0PR01MB6198.prod.exchangelabs.com (2603:10b6:510:16::24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4173.20; Tue, 25 May 2021 14:29:11 +0000
Received: from PH0PR01MB6439.prod.exchangelabs.com
 ([fe80::b43d:7749:62fa:2488]) by PH0PR01MB6439.prod.exchangelabs.com
 ([fe80::b43d:7749:62fa:2488%7]) with mapi id 15.20.4173.020; Tue, 25 May 2021
 14:29:11 +0000
Subject: Re: [PATCH rdma-next] RDMA/rdmavt: Decouple QP and SGE lists
 allocations
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Leon Romanovsky <leon@kernel.org>,
        "Marciniszyn, Mike" <mike.marciniszyn@cornelisnetworks.com>,
        Doug Ledford <dledford@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
References: <CH0PR01MB71533DE9DBEEAEC7C250F8F8F2509@CH0PR01MB7153.prod.exchangelabs.com>
 <20210514150237.GJ1002214@nvidia.com> <YKTDPm6j29jziSxT@unreal>
 <0b3cc247-b67b-6151-2a32-e4682ff9af22@cornelisnetworks.com>
 <20210519182941.GQ1002214@nvidia.com>
 <1ceb34ec-eafb-697e-672c-17f9febb2e82@cornelisnetworks.com>
 <20210519202623.GU1002214@nvidia.com>
 <983802a6-0fa2-e181-832e-13a2d5f0fa82@cornelisnetworks.com>
 <20210525131358.GU1002214@nvidia.com>
 <4e4df8bd-4e3a-fe35-041d-ed3ed95be1cb@cornelisnetworks.com>
 <20210525142048.GZ1002214@nvidia.com>
From:   Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
Message-ID: <d37c470d-8ff3-b1a4-58fa-e198de952b01@cornelisnetworks.com>
Date:   Tue, 25 May 2021 10:29:08 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.10.2
In-Reply-To: <20210525142048.GZ1002214@nvidia.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [24.154.216.5]
X-ClientProxiedBy: MN2PR12CA0008.namprd12.prod.outlook.com
 (2603:10b6:208:a8::21) To PH0PR01MB6439.prod.exchangelabs.com
 (2603:10b6:510:d::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from Denniss-MacBook-Pro.local (24.154.216.5) by MN2PR12CA0008.namprd12.prod.outlook.com (2603:10b6:208:a8::21) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4150.23 via Frontend Transport; Tue, 25 May 2021 14:29:10 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2d718019-347e-46c3-940f-08d91f897699
X-MS-TrafficTypeDiagnostic: PH0PR01MB6198:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <PH0PR01MB61986C067E621CDC41E4D14AF4259@PH0PR01MB6198.prod.exchangelabs.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iIq6moKEyD7LmJL9SV0fijef4mc+pfn6iKv3nNjZaaD1JpR8QbAp9w1qVH/0L9VxPQMYE//8AqvKsaV416MuRjN5KF4uqBHM9WXxMdo18sFhW6fmls8COAxwjZBS5CbeyvwDY57e0xYRWBn4/iLGfDTRREeQIzeHDP6vlzaXcpYojKdS2I/kdfIYySWtovGn+Zm/n6TEA6uD7+/0K1vNTosM8I9j3REqX30r0+8DeJeA6bFTjML6NQLcXNJ9IymGJrBnTwV5oaugQZE8dU1KzLn58hD2+xljtxOOu7JYFIalgADnRfkRayRzhmIy9rf/U1yHnTUhwePc3US8jBRMYn/3pYvuvGdyLy4Kp+Im06FJCvDshnna1NT13a6BBbjzeHkuHJn+XXuPcj1/pmBGoZMbarodvZXvFnSDsV+WTKXlTqui/CLeI9/4WsqeQsR5GC4aOS36LowItOwFP0UeJ5JSRXjUmIRrCHu/A6xGXsWQ4mJmB0kqTiiNqnZFB7s/az7TvAXJopXMEH1arU7rZ8EUYNeZj2jpQhuYpBHYZgHTp4nNgKysn5rJShw+X3TbytHzkkuQ276YHh7PFLrezFN08UjQ1Yvse7ZuI0kv9BbUROJ0XkyD1MjHJ5rKeSwe6a92sZp0T9hXP3asoDlVNt3VIJxUHkCWlmDmC0SRN5JtZNaV+A++55BhZ84koU2B2M0KDBuJMQNIAjnI+sHLcHbGkaMsD2tEwlCGS5cZETs=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR01MB6439.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(346002)(39830400003)(366004)(136003)(376002)(36756003)(26005)(38350700002)(66556008)(66476007)(2906002)(31696002)(66946007)(54906003)(316002)(8936002)(8676002)(2616005)(186003)(16526019)(4326008)(956004)(44832011)(6512007)(6486002)(38100700002)(4744005)(478600001)(6506007)(86362001)(31686004)(6916009)(52116002)(53546011)(5660300002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?M0YzNnBYa0RqZjdYT25CQ3JCYUlLUkphUHgwUjVHemZPSWpOcEZFUHNPVWFy?=
 =?utf-8?B?YmVrNHhURCtWL1RNWVZXcmM2Wk83R0V5YTVJWU5zK1FjYlpldCttcTJORGpn?=
 =?utf-8?B?dlBkYkluSU1KYk53bFUzSnByNGpNMjRpbDZBV3FXbGVtcmZ1UDByRDk5SHM0?=
 =?utf-8?B?VUtNRDF4WlpLL3BKeTVRVE5reE9rYnVzUnQ0Nmp2bzdCdjRpbW5mdEJSRHd3?=
 =?utf-8?B?emE4di9GdkNScm5Bb2tFRXlCdDJ6VytUeEN2MVU2RDBwUzIrTEpDbmVYT2g2?=
 =?utf-8?B?eWQ4VGRGRFhMSEFseGJXMjJqQlY1RzJYUDVOdmdmdkUzakEwNGVDY05STTFO?=
 =?utf-8?B?bUNQMndCNkVNeTcvWDlCV3JyVndpeWtCR1pOVTE0NkJhQVpFcjk0ZytuMzhx?=
 =?utf-8?B?ZFVyUHR5ZzdwZ2RXWXpRdXBLTkVZR2Y0OGluKzMwcVNxVW11Q2VmcDNaQ2xM?=
 =?utf-8?B?WVZtTWhrN2tiRndnR3FMS3BHQ2pJRWUrTnRYbzdSREEyTWJ1eFU4OHBOTzhK?=
 =?utf-8?B?UEp4Q0txRW5mL2RnRmZkMXg5RmEvSVdmMWtrdWNEaUZjVjBHdXYxbStpWUJi?=
 =?utf-8?B?M1JibGxKSFNWcUhHSVQyUnAxbXJERkIyU2hKN3NETk1IcnZJZFpCSGtZZysx?=
 =?utf-8?B?ak8rNDN1ZDdFbW5uclp4dDlSVjFmWmUyUElrZ0hGT1dFZjBRb2JlNUNsNG8y?=
 =?utf-8?B?Mi91eEQ2Wk9EMlNJMzRQdGxCYzZDbUZiRnFrZW04b2Ezd2R0SHBxOUtiVVhr?=
 =?utf-8?B?NDJBTUhXekNaN25MdDJEL3d0WWVienpHMkZQT1E5TVVXeDFsbnVwdG94YkRx?=
 =?utf-8?B?QlNBdkdLVmZjTFdhZ2RnV3g4R2tNa3lTUFI2aHJKbzhVZVg4cmVFWlRIZExU?=
 =?utf-8?B?ZnhtVllocVcwQWFHY1lzcjgrdVV4cWdubHE5NC9rd2ViNGpxZDQ2ajBPWGJF?=
 =?utf-8?B?NnNxaGhKVDdwMjZqakF5S01MdG1RcUFjUDZqZGZIVjJmSTVDRFNPNUcrR0pu?=
 =?utf-8?B?MHRuQ3dDK3RtcGczUHpmWm5NL2NYT0lVdmpVTmF6TFF0N3pETDBvQ2x3SXox?=
 =?utf-8?B?SnZtWmloVW1SUFh3Q0FrSjhSaVBlbWJFcDBMZllUcGhVMmhyTmFYdkd1OHc5?=
 =?utf-8?B?NDJOYTluc3FzMHc2bUdXcitvNGRtUzdveEZtb3pIUzViSzJaMGVhY2xBL2ZG?=
 =?utf-8?B?MkpncHkxdWl6T3diMDl0M05xNUdIemxyZDdvekc3UXd2NnRzS0dDT01EUlV2?=
 =?utf-8?B?NGJldmNDZGxZcVkwdEZhZ2J2MEl4eDUzK05kRlEzTXF6dGFENytZRE9DczEr?=
 =?utf-8?B?aURkbGdLak5JSzd1VExPT2VlcUZUMVNCSm9rMElGcklYRlZvWDROb0hjQWRN?=
 =?utf-8?B?SzZFUVRBb2IyYjF3VDdZUjhkTmJyQVpSOW9UVFFFNHRyQzJaT1FlTXJtZnRN?=
 =?utf-8?B?NnFscFZUcHEvcExDYmpMbnd0KzJYZ1VQWjVWQUExYjVHbFU0dldpUFZaMFRY?=
 =?utf-8?B?a3Z3WTFZMkxrdUViL3QxZ3pOaGxFRi83Ny9RSm0yLy8wSVZnUm50L1FqcWZy?=
 =?utf-8?B?VWJybnp5bThzT1ovY21rRmFnSEI3ZnhGbFhlWFFtSUVsUGFteVJnenJxMkNH?=
 =?utf-8?B?QTc1VTlya1FiNldwa21Dem94OTI3VGFhYy9YQ25jZldPSDJDODhmeHdQdnhr?=
 =?utf-8?B?OG1EMys4dk1ISzc5K0JkcExCZ2hxVU1kZzY4QVc0UnQvczRFME5yWGF5czk4?=
 =?utf-8?Q?+KRbkJnZsY/zOlNg7jWwwqb/rVKnfPfH/dqgcbn?=
X-OriginatorOrg: cornelisnetworks.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d718019-347e-46c3-940f-08d91f897699
X-MS-Exchange-CrossTenant-AuthSource: PH0PR01MB6439.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 May 2021 14:29:11.1866
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4dbdb7da-74ee-4b45-8747-ef5ce5ebe68a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lDzi5Wi6SD17qstn5U/35Or/w9eOa/maxJI3nxHJbYag7vfs/nXMIBlYKZlzb7PjkQjD/K8ZDWVHuixqxV5m+XQx5Zjw1QMa2YigobpFUbYtAid2AoPAV3wV69HYygDh
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR01MB6198
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 5/25/21 10:20 AM, Jason Gunthorpe wrote:
>> We are already mid 5.13 cycle. So the earliest this could be queued up to go
>> in is 5.14. Can this wait one more cycle? If we can't get it tested/proven
>> to make a difference mid 5.14, we will drop the objection and Leon's patch
>> can go ahead in for 5.15. Fair compromise?
> 
> Fine, but the main question is if you can use normal memory policy
> settings, not this.

Agreed.

-Denny

