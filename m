Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A34261466B
	for <lists+linux-rdma@lfdr.de>; Tue,  1 Nov 2022 10:12:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229970AbiKAJMf (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 1 Nov 2022 05:12:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229866AbiKAJMe (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 1 Nov 2022 05:12:34 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2087.outbound.protection.outlook.com [40.107.92.87])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 903176465
        for <linux-rdma@vger.kernel.org>; Tue,  1 Nov 2022 02:12:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ax2pi7vNc8yaQV9OXrYJNhhT2zB8VCJ96oHUeNNkh/nc4FzkgNaVNcKEyHKiVxzpi/rU8tcRRD4f2J8fOCgRZ9O2B4LxAFd4LnV95MlzXoLbBRY0DysbwccQN+e3qn5hFF/YMXrY0eLL6ge1DgFBslR15NDo+o/HgO+2fqMcYj0lEiJiITAi4o/HATHhjROZpiV6wgioD/RDvxflyeuX46c2MrCLdVALnHuSmXrCixO8xFbmkHdpbKDFm4dVBgDSSxsvdnEqZrs7kmRYDZX9rFghD2QdAq/BwH+jsd/ipwav5vsYWGC1RbMcPUbszeqeCTYOat9CvSlZfig35bj5Fg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1X1LNmStmn4z0hxrW2ub4N2zoB/HRS3tWIfXixWM0sM=;
 b=QQ1wHp9rh3DQBI5QNayzzM0q9P8e7DFq5XZBo2amQvD1jZCYZgaSkLyPQ/SMSOn4nvuZ1fv98wVFUAlrTzD37Hx7mvcgLupeTWRDoErysRs5aGl+3SFs5M6fsyzSpegegee//jZJex/5JfqdZ5fBc7okUsBeq9Z4CGlokLfoxzZ2rXHCV1YTsPTT9Z52hR0ysl4x/3X5Q9YEgOP6ZRDSrQrbgkLT3mH6BvnMqa08dLWBGR7udzX3JXVFhuSjOwWJVgTRbzkx/XH69GmSLdn6Xbgjoncr3D81kHwvMVmSYxVicK+UKlXH323U6y7YPxEuqxSn+MS03MVNmnvqx49hIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1X1LNmStmn4z0hxrW2ub4N2zoB/HRS3tWIfXixWM0sM=;
 b=Rw98vi/Wzgcok2Qpn5HT97mUEDrVTR0DM1x3zOWsPhr/BkAEidvFepTf22syJiz94Bnhqq0Gc2NG6JdU23PB/aPteI8Txs/xs6pokodTzCnqyqPh/dGkuVATHX4rESRH6J/13YZ/9hrw6laFdhUkPjPI/X5lU5vymt74a1ZlXV2sayXm5ynKbO/e/7OTxummU96PQRlX2SGv2xlRR3NXPCBsaQ1+AvNMH4NgkbMnjD4lns7FrKIGgBf8hKEj5vdTxB8GWzvdCWCOJbhAOFvM/uY2VGVt7+L1L9SLgJ3elT4XqI7alMk9UlnQlyrZ8+4T9Cd2+xeET2XBWZm/BuI/+Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY4PR12MB1366.namprd12.prod.outlook.com (2603:10b6:903:40::13)
 by SA1PR12MB6947.namprd12.prod.outlook.com (2603:10b6:806:24e::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.19; Tue, 1 Nov
 2022 09:12:31 +0000
Received: from CY4PR12MB1366.namprd12.prod.outlook.com
 ([fe80::21b0:f057:a4f9:e1c9]) by CY4PR12MB1366.namprd12.prod.outlook.com
 ([fe80::21b0:f057:a4f9:e1c9%11]) with mapi id 15.20.5769.019; Tue, 1 Nov 2022
 09:12:30 +0000
Message-ID: <681128a0-2e15-c8cb-0adc-1b5ebf57a759@nvidia.com>
Date:   Tue, 1 Nov 2022 17:12:17 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: [PATCH rdma-next 4/4] nvme-rdma: add more error details when a QP
 moves to an error state
To:     Leon Romanovsky <leon@kernel.org>, Christoph Hellwig <hch@lst.de>
Cc:     Sagi Grimberg <sagi@grimberg.me>,
        Patrisious Haddad <phaddad@nvidia.com>,
        Israel Rukshin <israelr@nvidia.com>,
        Linux-nvme <linux-nvme@lists.infradead.org>,
        linux-rdma@vger.kernel.org,
        Michael Guralnik <michaelgur@nvidia.com>,
        Maor Gottlieb <maorg@nvidia.com>,
        Max Gurtovoy <mgurtovoy@nvidia.com>,
        Chuck Lever <chuck.lever@oracle.com>
References: <20220907113800.22182-1-phaddad@nvidia.com>
 <20220907113800.22182-5-phaddad@nvidia.com>
 <facc31c4-955e-c82e-191b-150313e73f6a@grimberg.me> <YxiTxJvDWPaB9iMf@unreal>
 <ac268c86-c013-5cc5-5e1c-71ee90111d8f@grimberg.me>
 <20220907151818.GA26822@lst.de> <YxjXTZY6aihDV2FO@unreal>
Content-Language: en-US
From:   Mark Zhang <markzhang@nvidia.com>
In-Reply-To: <YxjXTZY6aihDV2FO@unreal>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: KL1PR01CA0004.apcprd01.prod.exchangelabs.com
 (2603:1096:820::16) To CY4PR12MB1366.namprd12.prod.outlook.com
 (2603:10b6:903:40::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PR12MB1366:EE_|SA1PR12MB6947:EE_
X-MS-Office365-Filtering-Correlation-Id: 38f3c67d-4086-4dc5-9887-08dabbe93435
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: r1ND3XKJhuKbi4xgW06a6Syie6VjxJgd2YGTllGOTk53i1rLbJO91hj/QkM0rlktIwM1raN7yGVW7NwWfjpn4gaczFeuMsz6Jj4jDM6Z8TWWA/RpAw5Ms8m9J7SHuRUjEQ5l8Ov7nVTW4FBGcHAQFvCuqSS0N8kQTAMGYkQxVx4dhFtaxgNmVPtUUcotM99ANv6pj3COxDY+bFH8/n7ybPdly2tAnJYRNMUe1RnV4kzlVyEx8CdrpiRrC/zOSohZJ4lY4AUdK/yFBEsFz357JvsuYsyIjqiXJSacMNajNlePqNenzuQGV2CPGfHrePzXLq/+yvBQWs4RYFEcCupOK5mSsMExACH2v4avc6eNm0iowwmCdyaoGoRt4eUNgh9lP1xcIaYpOHO2d/SC3/ltZywaUGzP9LEsKXNeKaAggONvpUpCK8Sw3JzRcz8LcJh02rC2SHM6zuh/hsxyWAZBVf9S1nBke3cLSKHI0g0HPA2uty7tAs1Q1NjndniDFJYhrBxICQPjH4rTMM80uxbAEncUn3ZsQO7halmcZIdDKG9i3fFQEI7FFYhYpV3Ux9xz+BBSX2BlTP9DWGSmCOFr+URtXEEfFbIMlKj09kyIh7ze3RcaaEAndVSL2UVUz5FcyhuAm0lb0RtCEIsY2PAFF7QJiPoK+EL7kKweNwKsyf0oeKqg0w2Liat1JxHkQo6ESa+2UHRQgP/4aBp7Phq39A1BekJDNQv69jNUivCP9unwaMBtCs+v6CVZEb64JkPK3BKJ9c6eKTG6EY/7a5LrQcdG/ThVP3Z/lX8HDBQqmmI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR12MB1366.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(396003)(366004)(346002)(39860400002)(136003)(451199015)(8936002)(2906002)(186003)(41300700001)(38100700002)(36756003)(4326008)(5660300002)(2616005)(83380400001)(6506007)(6512007)(53546011)(6666004)(26005)(6486002)(66946007)(66476007)(66556008)(316002)(54906003)(110136005)(8676002)(86362001)(31696002)(478600001)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?M2Z6WnRhTjNvZTFLcXdvL2p2ak4xUGt4eWluUjhaaTg2SU1WQ2dZck1Caitm?=
 =?utf-8?B?NWxROEpOcmVERnZTUVpickViZFlSQjZodmRldmpTOERXL2JIQUJnd0JWaHBu?=
 =?utf-8?B?QlVPbEtRVUpDbXdNZGszYWpYZUNnTHEraTRjbkVqRmdMemlnVDAyMHVjL0ZF?=
 =?utf-8?B?UXpuVXl5eml3eEFnRmJrd2NsMi8ybERPY21iN3VYNTZwUWlIQ1NycUcxdkIz?=
 =?utf-8?B?aUx2SXJWbEFqc2RQVFRuRmNqQXdKdkVCYUUrODNXbnJDSjAzVTByQTN5aEs4?=
 =?utf-8?B?V0dyZDA3NTFEUVFVaGF5U3ZHVmxvRURCa2VXMUNudW42bWxpZUNuVlhpQnNx?=
 =?utf-8?B?WEs5NWpWTU4xMjNsVVNVSk9Bd21kRnRuY1UwTXpuNDIyTExiSmJaamxoR05w?=
 =?utf-8?B?OG9TMHJLdDFic2lRWURQaTJtRzN1Mm9MelV6UVlDWmEwcExCSjQ4VVRIc2Jr?=
 =?utf-8?B?OHpMYlZNVkdQdTZEZ0NPYWpYb2ZtNFVpRTlpQ1JYcnVBa1NBZkV1b3FuRUo2?=
 =?utf-8?B?N0xleEJMM2loa2Y0UEsrMy93bEFodVFhdUE4QWtMQkJwVkhVMmY4THJJUDJQ?=
 =?utf-8?B?MUhFd0FvdmFUSHpyL3kvUEZlc3lHMVJobjFXRW5IbmZFYlVrUVgxOFI0aHBi?=
 =?utf-8?B?YTFQeWwzNUxVQXA2WU9rVjhBcHoydVQrYTdKQnQxUFE3RWw5TGFrOGJTNUtt?=
 =?utf-8?B?Y0trQXJSYzkzQUdnZTNXN0xXZldIam1hcWxSdEcxWlljSFZ5QXRldkh0VnlY?=
 =?utf-8?B?UWVQSGlBakN0WmxsMFVWVUdPZnBGMWVnYk1mMWYzOEJrS1FqSW9kaWR0QkJO?=
 =?utf-8?B?R2d6ZWJKQXdrYWprd25PSlhoUnlGNEtrUkJFbFlELy84U1JhUVNrRlovUFZG?=
 =?utf-8?B?NTRFM3NNeVIvTUNFbDhHcjZTcFk5Z3RSRjFTd0gydHI0akJDV3Z3Rm5IOUJt?=
 =?utf-8?B?bWxNMnBKdVl6WXBwQ05zY2RnWWRFOVk2V2ZZZFZRMXYwU1htQUVRclF2L09y?=
 =?utf-8?B?MmxHcUFHbkVBZi9FWWl3SzI5WTBqa2xBVXZNVU5TYlpiYlFYckZoNmswSmxs?=
 =?utf-8?B?a3I1N2U0Nzdvclg1M3UrcDBzNjNtR3JhM0EvQzNEU2R1TlZ0K3lqOTd3d0tL?=
 =?utf-8?B?S0kwd3ZDY0xEMFphWVpYSU9MV1pOOGtnclM1ZE8zZEE5dGxCSldQRzlzQWtD?=
 =?utf-8?B?SG1oY2x1QlpOOS85c25rVVFFMU51TVBCZXd5MnNXOE9ha2JaSG5vanZieEtV?=
 =?utf-8?B?NUVQMDVJaVU0RCtjRVZDRSt5dXppcDVKdGhaZHlVc01salVMcHUrTndyYkZ4?=
 =?utf-8?B?MVJIVHFva3NHRFhrL2JsT093b0V0ZjdCaHpJeC9ic2RVUnpKdzVhWk9lZnZy?=
 =?utf-8?B?UWNqdU1HTE5HRStkOTNFT3VwLzhSVG55WE9kZGw2bk5EU3UwNjJuUE9icWNR?=
 =?utf-8?B?czA2dFJIRGZzYTRPdGtDRmlYUEgyN2NsVkpzUThxMmZWaE1vejRYemVDS2RK?=
 =?utf-8?B?SjZyaTRJRy93bUhuaC9MWkhhVzVVTmdpOE5Jc3pyZTZYalRGQzMrdjZrclBN?=
 =?utf-8?B?NWdHT0QxMEdUREhHeFl4K05JWXFjRG5CWGJCdHdnL05yRzMrekNZYmtQaE92?=
 =?utf-8?B?SWQ5UXlCYlNScStSbktCU0tFRjNrUXM4K3ZoOXZwYVJZOUFIeit1TzVvVVU3?=
 =?utf-8?B?NEdjWDJLWXFGaHdVdkhjRlAzUzN2ZStoc29Edzl5QXBsSkZKMUd2eklYbW5W?=
 =?utf-8?B?MVNMSjZXejdka3lKbmZERWFlU0ZjYXZRWVNHcEIrWXRZbUhERE0vdERDT09N?=
 =?utf-8?B?OC9kSERJSUNTL0tTbllTcVJKM1NxcnhTdnkzcVRnbjhWby9EZHdPMy9jRDVT?=
 =?utf-8?B?MXkzK241V24zTWZoOWZBVHlmdGVEZ1VsRi9hWFVsdkV2MjRwdTcyUElWUlZV?=
 =?utf-8?B?bjQ0czF2d1hjOVZTTGdUYjhZR0owdk1sZkpwT28yOHBZYXZMdzNFTzMzeVVp?=
 =?utf-8?B?TGZZYXFYZlE2SUhrQ1A0TmI0Nm5mckI1SVpoZURJMnF3NitxenVZWHNIa0di?=
 =?utf-8?B?U0NqckVlTUdUekpLSFdBYld0N0M0cmRmYkhML3JESFF5dXBHTUlsRFNWQThI?=
 =?utf-8?B?bFc4UUh0NVN3a3UxeHdBMEJsR2t4eHBHOW5GcW9nMzdsTmJEUktYT3JGTTM0?=
 =?utf-8?B?a3c9PQ==?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 38f3c67d-4086-4dc5-9887-08dabbe93435
X-MS-Exchange-CrossTenant-AuthSource: CY4PR12MB1366.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Nov 2022 09:12:30.7485
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oLxebQPRzCRoYZDyRU0ARA7vV1vBW27SapNsrN97espuTSJxHBDy+Rv7Id0F/A69u64qBej/zNYeZkwpEoM2rQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6947
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 9/8/2022 1:39 AM, Leon Romanovsky wrote:
> External email: Use caution opening links or attachments
> 
> 
> On Wed, Sep 07, 2022 at 05:18:18PM +0200, Christoph Hellwig wrote:
>> On Wed, Sep 07, 2022 at 06:16:05PM +0300, Sagi Grimberg wrote:
>>>>>
>>>>> This entire code needs to move to the rdma core instead
>>>>> of being leaked to ulps.
>>>>
>>>> We can move, but you will lose connection between queue number,
>>>> caller and error itself.
>>>
>>> That still doesn't explain why nvme-rdma is special.
>>>
>>> In any event, the ulp can log the qpn so the context can be interrogated
>>> if that is important.
>>
>> I also don't see why the QP event handler can't be called
>> from user context to start with.  I see absolutely no reason to
>> add boilerplate code to drivers for reporting slighly more verbose
>> errors on one specific piece of hrdware.  I'd say clean up the mess
>> that is the QP event handler first, and then once error reporting
>> becomes trivial we can just do it.
> 
> I don't know, Chuck documented it in 2018:
> eb93c82ed8c7 ("RDMA/core: Document QP @event_handler function")
> 
>    1164 struct ib_qp_init_attr {
>    1165         /* Consumer's event_handler callback must not block */
>    1166         void                  (*event_handler)(struct ib_event *, void *);

Looks like driver calls it in an atomic way, e.g.:
   mlx5_ib_qp_event() -> ibqp->event_handler(&event, ibqp->qp_context);

Could driver also report it as an IB async event, as WQ_CATAS_ERROR is 
defined as an async event (IB spec C11-39), and QP_FATAL is also an 
event of enum ib_event_type? Is it a problem that one event is reported 
twice?

If it is acceptable then ulp could register this event handler with 
ib_register_event_handler(), which is non-atomic.
