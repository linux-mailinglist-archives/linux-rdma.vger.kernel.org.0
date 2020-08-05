Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE9BC23D235
	for <lists+linux-rdma@lfdr.de>; Wed,  5 Aug 2020 22:10:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728968AbgHEUJy (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 5 Aug 2020 16:09:54 -0400
Received: from mail-eopbgr50055.outbound.protection.outlook.com ([40.107.5.55]:56960
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726733AbgHEQ3E (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 5 Aug 2020 12:29:04 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FiHERv8bwcOsdUdWhyBeJSQLZQqAC4xW9QP5M+6IcGYtOU1r4lWLI1IBXH3UKXhwJyQttpKxlT/LGOG7h3Hl6WsZoS6FAVq0o5GpUe1PQs+SQRt3SdK3ODAxIb9CC4G6tgHGthqy6RrpzINwPt4W/+kDCzUR1p/cdoiFzWV3e3dN+2xNi1meGkK3l0juygdl2Yd6+SAW/BSPhT7kLqm7LquixMXXMh55BDVFGLG2RP35NUj1WI2eKtFFhhEOiHLTjWeviu11RUlkjq/+idvL9ONG73rQq8pS5NzOEQfyBg9eiRMsep0qewItGMsGtP0eWFh3wt8KTVBMNLlSly7xtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TtmwBd8Fgvzyax8jV1CuQkGKqNHNd4qF4DpMW49YQQo=;
 b=f594IolYnLBZNpsZmTFFMEFXbymJPilEYFAqfhapchDsrU7UiMoKWkYXCuldT6sYWtlQ0/NI/rA7CYm4N4GF0rBb8wMxX/ubmM60/Gt+kCy5mmumtvaziYqwJwrM56wm+qZIv8fo3QOZ71x+BrYGfhV7k2QxJ3PO0OBcDTHFMNJJDPxcsk/BnWAOkh4vNiC9841pjkIs73sZHwOjzt5748smHMwa0nvQDRroeKY0uJPf8rpD9/ckuJ91PEUbbNF1h7rxBbELILBT9FrLvGmJVQifoXHGn6NSBLHzgq6Ajuhfg31Qh1J31+xyMCkze46qTVFRMpYSKd69oqBlukraBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mellanox.com; dmarc=pass action=none header.from=mellanox.com;
 dkim=pass header.d=mellanox.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TtmwBd8Fgvzyax8jV1CuQkGKqNHNd4qF4DpMW49YQQo=;
 b=EL9auDjGxha+KN0vn/CbwS9LTKn6ga36KjQ8tezQbL6CSf+2DHFV/dInvf+MgLcs0oqOdUEZBbczmTjZHAFw1wjxxdceDez67HhgIxnglNqZSx5Pt3yoBx3GndQPpWr4Q/9a+0BevilTqS1hnHxT3RoU/3ZzvDxoesGf0QWgePw=
Authentication-Results: mellanox.com; dkim=none (message not signed)
 header.d=none;mellanox.com; dmarc=none action=none header.from=mellanox.com;
Received: from AM0PR05MB5810.eurprd05.prod.outlook.com (2603:10a6:208:11f::18)
 by AM0PR05MB4675.eurprd05.prod.outlook.com (2603:10a6:208:af::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3239.21; Wed, 5 Aug
 2020 16:29:00 +0000
Received: from AM0PR05MB5810.eurprd05.prod.outlook.com
 ([fe80::95b6:b863:de2a:c8e0]) by AM0PR05MB5810.eurprd05.prod.outlook.com
 ([fe80::95b6:b863:de2a:c8e0%7]) with mapi id 15.20.3261.017; Wed, 5 Aug 2020
 16:29:00 +0000
Subject: Re: [PATCH 1/2] IB/isert: use unlikely macro in the fast path
To:     Leon Romanovsky <leonro@mellanox.com>
Cc:     sagi@grimberg.me, linux-rdma@vger.kernel.org, jgg@nvidia.com,
        jgg@mellanox.com, dledford@redhat.com, oren@mellanox.com
References: <20200805121231.166162-1-maxg@mellanox.com>
 <20200805131644.GJ4432@unreal>
 <3777c9d9-1d36-f8e0-624f-aa633fd517ab@mellanox.com>
 <20200805160601.GL4432@unreal>
From:   Max Gurtovoy <maxg@mellanox.com>
Message-ID: <6cd8d78e-3017-696b-508c-73c3c8b92802@mellanox.com>
Date:   Wed, 5 Aug 2020 19:28:50 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
In-Reply-To: <20200805160601.GL4432@unreal>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-ClientProxiedBy: AM3PR07CA0075.eurprd07.prod.outlook.com
 (2603:10a6:207:4::33) To AM0PR05MB5810.eurprd05.prod.outlook.com
 (2603:10a6:208:11f::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.0.0.3] (89.138.179.55) by AM3PR07CA0075.eurprd07.prod.outlook.com (2603:10a6:207:4::33) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3261.14 via Frontend Transport; Wed, 5 Aug 2020 16:28:59 +0000
X-Originating-IP: [89.138.179.55]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 05d71ec8-14ac-4fc7-41a4-08d8395ca8a9
X-MS-TrafficTypeDiagnostic: AM0PR05MB4675:
X-LD-Processed: a652971c-7d2e-4d9b-a6a4-d149256f461b,ExtAddr
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM0PR05MB4675E52715C53A9B8DDD0EF2B64B0@AM0PR05MB4675.eurprd05.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ven8r1EDqAVMDccPEoVNgabGQGbqEst4NAXxTADa31E3lXgtbqBqq0S3T6Pw01ikxONJ9sjT5JwrODAsk82HPc6GKrvHosIF9K6PzBeFtSyiSfTWnS3g9i476WKSn4Gon7dCq4BHshQNSoMGkV2kD0+cRS2AGjoS2hMIFpccTvYxudzKdGED3806e5cEu2KCElFTExd6dTkE+NRptDYdOiAUx9cpthvoHpsk4KWW3R5Q3nnAgrQM0O8S1O1UbKAN/0rjZy/FbgkdKTciwZzaHpXyQrL6rq+j7xwvKQoxzDsIJhGiFZ7HJYv7NUnhjiB63wF/Xu4Csz29w6H+PAF8gNOfhq2M157yQSYrGJSFXfEAlwRjQygacm/yYWqLBJq8
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR05MB5810.eurprd05.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(396003)(39860400002)(136003)(366004)(346002)(376002)(478600001)(37006003)(31686004)(31696002)(66946007)(6666004)(52116002)(956004)(2616005)(66476007)(53546011)(2906002)(86362001)(66556008)(16576012)(36756003)(107886003)(316002)(4326008)(16526019)(26005)(6486002)(5660300002)(8676002)(8936002)(6636002)(186003)(6862004)(83380400001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: yH41DTIEKUqwzICVgDHPVbd7Cg+mo5Gng6gfU+qlf1H6+XXZRJD9faeYMm3zPMrOPLQC2dlaTBAdCCr+D1EYFKCGxSHBFUmUrAXPh9ydGFtSHCuHb4ExTbyF5FklTgJSBlHxEhRRD6si+jQrKeWBlcQdx7BSf7HhHOGe7hBWCzcT/nCYBszcyTXSXAK3NhDpAj4IfAv6uOaLn/5llcS/+m0YgbUXHwmn35J+2EMdtj3mZjmP/YV1JYqG7lXhGQ60PyfT6OntbkBzUgRFCx2WxPAroPAMhS7zHCEzWwF8MMBCMhxWfBacnBwGZFOvd0rCU0FPWLcrLXdJOy9OYDo72qd/CyKd91/GT7UUgwyit1jh8efec4RJfYu9uwkXE6Z6X8Ws/MMjGDl0+0+0XdvKTSngLJN7VXBX6rDVYmYNRR3BBxjpDq6edgYezmhP//540pjByRloOBLkaQGvk6Qg4U+6lkYtkW0JFsIoJqLeTORCgBlKmLIYVGUPkWQsm+cTRypI4A7kSgRbhh0RRSNuWHLOgpib+MTzyDhTP7XMTCCs0u87rpPxoOtN8sDzjFPY6UjhnoiuAHBmxOunDDfB0SsHSsntZT1WW3Ai3E3w8G83NbyvfXMdVjvrk4RlZcHqd7WvQiRhK9OSWC00YKC/8Q==
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 05d71ec8-14ac-4fc7-41a4-08d8395ca8a9
X-MS-Exchange-CrossTenant-AuthSource: AM0PR05MB5810.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2020 16:29:00.4253
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: w5SzTPXdZmBIjfg+YwcZsifLnh2jYvPtxmuWHH+jBTxumwt9fEQdFTWAAF4O1vFTfoRsbBGMeK0MGNLIVn1obA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR05MB4675
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


On 8/5/2020 7:06 PM, Leon Romanovsky wrote:
> On Wed, Aug 05, 2020 at 06:14:16PM +0300, Max Gurtovoy wrote:
>> On 8/5/2020 4:16 PM, Leon Romanovsky wrote:
>>> On Wed, Aug 05, 2020 at 03:12:30PM +0300, Max Gurtovoy wrote:
>>>> Add performance optimization that might slightly improve small IO sizes
>>>> benchmarks.
>>>>
>>>> Signed-off-by: Max Gurtovoy <maxg@mellanox.com>
>>>> ---
>>>>    drivers/infiniband/ulp/isert/ib_isert.c | 4 ++--
>>>>    1 file changed, 2 insertions(+), 2 deletions(-)
>>> I find the expectation from "unlikely/likely" keywords to be overrated.
>>>
>>> When we introduced dissagregate post send verbs in rdma-core, we
>>> benchmarked likely/unlikely and didn't find any significant difference
>>> for code with and without such keywords.
>>>
>>> Thanks
>> Leon,
>>
>> We are using these small optimizations in all our ULPs and we saw benefit in
>> large scale and high loads (we did the same in NVMf/RDMA).
>>
>> These kind of optimizations might not be seen immediately but are
>> accumulated.
>>
>> I don't know why do you compare user-space benchmarks to storage drivers.
> Why not? It produces same asm code and both have same performance
> characteristic.
>
>> Can you please review the code ?
> There is nothing to review here, the patch is straightforward, I just
> don't believe in it.

Its ok.

Just ignore it if you don't want to review it.

The maintainers of iser target will review and decide if they believe in 
it or not.


>> Sagi,
>>
>> Can you send your comments as well ?
>>
>>
