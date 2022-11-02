Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCA5F61572A
	for <lists+linux-rdma@lfdr.de>; Wed,  2 Nov 2022 02:56:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229935AbiKBB44 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 1 Nov 2022 21:56:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229650AbiKBB4z (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 1 Nov 2022 21:56:55 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2066.outbound.protection.outlook.com [40.107.92.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8661B101FC
        for <linux-rdma@vger.kernel.org>; Tue,  1 Nov 2022 18:56:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZzbwTQiCx9z1sUnlpmhPIOQ5AP4gNrIbdzuAT4e2PEvYHtjs0AkHsJ5VwwTp/23p8aqWLUztdeMoz933fnwyvA0PW2OhrDX5agMJ3CpkTdmDK9w4Bz3o0ZcEzxMnp5Iwlm3iNDPDiaWkczdz8mcsA3gi80G8ixn32ksVEgx3NOmr6ll2lzXqyF2ty20hQZastn9T+fuxa5igBBJH5LqfY2hoqXv9OjkeRe3zKA+6D5OMJUqZpCbhsoTB0HeCJBnOZfAOnNjnfXqqTpApg9lX7uoncHVSdHTEEGfLn3akLBtiedqaMpPnZJFY6OchRSo5yosxtT0J5N8vHrYrL7PKHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0UKE9Jk0YGI/X7sabBgGSkO+pyauLY/JBTIMjSa1C4Y=;
 b=ngnkuNDOP2MRuJNBPNxNN2OKQGS2dXB3imchGgFXEcptHtWoao0NqLSj7iXbkh67KSYs1mHRayaJrlptzXPWaqdTpM3uCNpvJvM07yITPoaLpr63idWjkdlfEs2bFiKVJ5WxkzGedaHKVrkpLNo/z1Ds9mdi2oEtC7GuhTeMBsCav+JYP8Kxieroo2QEFsb+Odk+C2NeKb7qotP9HF4WVROP5Vmn4PB2XelgLc4gB4s46KZkDygI4PbkLmLILoZEWXI+WrWprRBPJfhvYrOCvd+/1u8hdwc1HR4Yy7ElMCanT7ZkJDu556QEv4fEkrGOFipiEkdh6GXkVV4Za6lXFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0UKE9Jk0YGI/X7sabBgGSkO+pyauLY/JBTIMjSa1C4Y=;
 b=SgLHdTgivghaYS+GM7yCzVN+erp/z0/YyjrzW4Ao5lzLm27SpX2sMBfFBMGGXp/ERpC29IQqscReJrNI8fh13b2XLrhN5NXstxmv5MrjaWYsBISiVGHp88wDVOcpVcbHrpU5Pvj98nmudgGatDu1bR1aAdGxA+NLyElkXQE6EVtnsjl8yYDHqgwq92D9Mk8MkXes/rMGClXoQp+uugF/R9tYC1NSxLn8PrLSemfPNk2yOIZCrNpqupJf6LGuFI5maQoeQoAxBg5t9mV23jJbjoBgCrNsRCpeP6D+NTxgMews+g3b3ZJDSxLds72f1WotLZicMiXQCCa4Z9uKPKw9eQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY4PR12MB1366.namprd12.prod.outlook.com (2603:10b6:903:40::13)
 by CH2PR12MB4956.namprd12.prod.outlook.com (2603:10b6:610:69::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.21; Wed, 2 Nov
 2022 01:56:52 +0000
Received: from CY4PR12MB1366.namprd12.prod.outlook.com
 ([fe80::21b0:f057:a4f9:e1c9]) by CY4PR12MB1366.namprd12.prod.outlook.com
 ([fe80::21b0:f057:a4f9:e1c9%11]) with mapi id 15.20.5791.020; Wed, 2 Nov 2022
 01:56:52 +0000
Message-ID: <e3d3b592-565d-0cbf-b2c8-7a36947b38f0@nvidia.com>
Date:   Wed, 2 Nov 2022 09:56:42 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: [PATCH rdma-next 4/4] nvme-rdma: add more error details when a QP
 moves to an error state
Content-Language: en-US
From:   Mark Zhang <markzhang@nvidia.com>
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
 <681128a0-2e15-c8cb-0adc-1b5ebf57a759@nvidia.com>
In-Reply-To: <681128a0-2e15-c8cb-0adc-1b5ebf57a759@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SGAP274CA0011.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b6::23)
 To CY4PR12MB1366.namprd12.prod.outlook.com (2603:10b6:903:40::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PR12MB1366:EE_|CH2PR12MB4956:EE_
X-MS-Office365-Filtering-Correlation-Id: dd0a1f21-4b2e-4c8f-8db1-08dabc75831c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wCG/pkWAkLWB/ThHjRwE9ZcGOWdjGy7wJ1/OE96wx2vyrouGbnHZU8CBhl8Co4D1vKWmOi6rg/tN2yPZ0lGQDg/WiZVf2qB8drDPxdQ5n/55PMlPnPiQ20sNdXM/sS9c1JMeq9OVr3Qhz5VzFz+Sk4LrWXJP2MIJN/2Ou8nocidj8Xq81LJrlH6t1EE31Cn/eS3jk/RG//PPjcZEcOJozjXaYJgOU0WPtnQTurAg2ychqpoQ4xL9m0IHCRA6OM9ssDOd0XWJPysYJLDyr3FBXXvL4kuH6LIjTERyaxJ9bfpfgJ7CpxI+HK82ZG+BLfI7+BMk+4hgQnXoIDBXNG3jGUkHL9oyJvMveCv1wa/Gzec3tRmZRmZb/h/Jd1C1O5h1EdGE1at+2Bg/sN5negerhAav7W1bVSNsE0IbRcIfuVUGt22cjh9lwGJD76FG9rA2wMSgakuOb31SWFz48RirQ8WzxN558jsuGl7HYoYXafdXYOiPdqjga+N/MUKf44PnlAvG9Ufxrn4/R5k3psNlAAVQDafA8fVhgqEXmx76mVzyJID2R1LbSHFGf2Xk4/0J6uuM+Rm09vijDkhPkIP5gctHZoY3Gij3Qbb7Fi8r+FMxSAXJWq6iUJI28TneRFsYdXbV1fhSwlmGildnDDW+VvvihDWUF67Zb+zGBCu7Fv8WR0oqwLfwyl5QBZsqQv3RRY+ZTyT8Eqj21N02hu3V5Fr+c3iOOx/P9syDgp96H1IBs5luc2JKSJeNlhyT3CpTSFJ88NLl6VxRhmDK9NHX4sBC/g49Hro32l/1oOu/4C0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR12MB1366.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(346002)(136003)(396003)(39860400002)(366004)(451199015)(8676002)(4326008)(41300700001)(66946007)(66476007)(2906002)(66556008)(110136005)(54906003)(6486002)(478600001)(5660300002)(316002)(8936002)(83380400001)(86362001)(6506007)(31696002)(38100700002)(53546011)(6666004)(26005)(6512007)(186003)(2616005)(31686004)(36756003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cU5jSk9GTmdHaGpzUTBlWVA1U2xoV044aFdHYUlOQXJtRFhMR1NvZ1BMdGhw?=
 =?utf-8?B?K29EQWU3YmlSN3QzVWFRMEQycEx2cmZ5Y2J6SGdtTVVvN3NFeXhkZDdNbVpR?=
 =?utf-8?B?aS9EMHVRYk1xbEg3bnYwam8yT200aE1HeDkrK2lOYjdnTjlESHFyN09PV245?=
 =?utf-8?B?U0ZPbmZnZnMySm01NEtYWFcrTml2OUwxMEp2azdqZnloVVdTMm1DK3FqV1lY?=
 =?utf-8?B?bEY5SXluK0YyQUZKZHl2Y3hFZ0hnUk1WS3R1SzNaOGxIUzAxUzlIZXZDekV5?=
 =?utf-8?B?ZmtUbCtPYW8xTVhySEEvbVZOdmdQN0QwN01QVHM2a1ZyZWZoenlzY3F2N3E2?=
 =?utf-8?B?SGJhUkE5emF3WU1rdmRIZ2VPUkZMRHI3blNtNHhjYzBNcXU3ak9HYnNxQy9r?=
 =?utf-8?B?dittTmp3a3UxcnlHcTdHMzhkMTN5Z2twcXlYVjluYmxXS1lMZkpIeUVVSjVJ?=
 =?utf-8?B?ZUdkQ0NRd1lGS2RiTEN1bldUVVNWNWgrclJvVloyQWQybzgzN2lKREttZUZz?=
 =?utf-8?B?RVZzZ2JSbnVPUHkxcXgrMGJjOEppZmpXU24zNjN4VzhyWU8wRnZMU08vNTN0?=
 =?utf-8?B?ankzS2VXY2hMd1RWSktjcmRsRXpLeGhzU0VxVndLNXorQ3dUa1RsZ2ZhZDZa?=
 =?utf-8?B?Z2g5UDRIa1NCbFlxUHYxb3JvZzliRHZSZXJUbVcwWENWck1nNHBoeVpxN0hx?=
 =?utf-8?B?YkN6US93L3RpSTF4S2FvQWtTcE9Vc2FJaDMwdndZVWczSCtjemhWd3lUUTND?=
 =?utf-8?B?SDJLdUpWNHk4QVlPVW1oMXNlcmc0ZXlwOUgyWmI5SlVhWjVGYlI3a25Yc0s1?=
 =?utf-8?B?Z1ZRc2oxSktIU2JQYWRaajBjMm1UOHg3Tk9zQVJpcjJVd3ZYM2ZrUWhSL2M4?=
 =?utf-8?B?MnM5Q1VTOWJXZ2JBQjFPUm5xdjVRNnRvellDRVNqN1UwQjZLV3NVQWdINHNZ?=
 =?utf-8?B?a0RTTmZhZG9xOU1COVBJMHRtWWlrM204R2ZUbmxzSmFZSEI0UGdVK1RJVGZJ?=
 =?utf-8?B?cWNiRVEwREF3QXgzNUpjRURsTE1qN2poZ3VFZ3F0eTRnak9WN3FxSllDaTh2?=
 =?utf-8?B?RjZ3VEJsZ0NpYXRUa2R4SGtoVVVaQjBITUlnN1ZwdFBtZ3ErMU5yOEVxaCtK?=
 =?utf-8?B?NHF1cFVpWFUyV2xWS0xCUktSTENwSUpBVEJhVUI1WlU2UFhzbWV4bENvK2sr?=
 =?utf-8?B?cERveExNdU1ETFdoa2NSbWhqaCt3OC82VHRKNlJQSWdiclc3VmNKYytvR3Jk?=
 =?utf-8?B?em1CSCt4b1dwSjR4VmtRa0hmWFN1QTh1eW1BcmZ4dXloeVVpakM2OEFzZWc2?=
 =?utf-8?B?S2JiZ0hHUG5OMTk0d0hIQ0dqUDYzZWVpM010TGFodEh0cHJBOERaZkFzTXRw?=
 =?utf-8?B?QTNSamY2Z2N6QytvTVhhSDNpeTZJTUxtS1RadE9jZ1Z6MFkyQ1Q1bFl3dFBy?=
 =?utf-8?B?a0VWNTRwRzhnZXZYYnM5RWRUL1hyUTk3VHhBY1RhT0MxNC84VVNwbUZORzda?=
 =?utf-8?B?OVRJZEZMSUJhSTB1TUVtZ2FzMnZ1OVF6RklTN1NqWUhPYitYOEtmS045V1p2?=
 =?utf-8?B?T1RGV1NDVk1aa1pQRWllYTZpQ2pZUnRhbGFGRUg3RXZydTEvNzZ3dEpDSzRN?=
 =?utf-8?B?bWgzK2VLbGxQdWo5RkQ0U2V3WUVXeU9vL01jL3RUUng4bEE2ODZYSFkzSFVQ?=
 =?utf-8?B?QVRVMnFKTlJjY0xwYTAzeXF5MWxVSUlYandqWTZRd2JtZnRhZFp0WENva2xh?=
 =?utf-8?B?YnRPZ3hENXI3M3JLMUxFdE85QWYyQ2F6YUlvckZSQ1VMS0dlWmF5Z3d1MDEx?=
 =?utf-8?B?Z2xJZkpITUE2eXBqMk5rOVhDb0xOOUNENXhobFFTWGNSYWRQdnN5eXNjMFRI?=
 =?utf-8?B?SWkvSHpZeVZiamlDQjRSZnZtVW9SZUJkQVErMlNqVzlMUHZQbUFIeEhqd3RY?=
 =?utf-8?B?VEMvcEtxM3NmclI2dVkrL050UzRMOGM0eTFuNTFQQ3FyQ2l6OXhXaW5YWFpu?=
 =?utf-8?B?b2ExcmRreTZCWWhmMjhOT0pLY0JXNlA1QVRSN3dpYjN6QTNtMG1sTkN5WSt5?=
 =?utf-8?B?Y0lYL3IyWERoL0kwMEY0QWVSWjhMd2RUT2cwM1Q3U2hWcUprb2RRTDRrSnBO?=
 =?utf-8?B?QnJYNnl0aGw5dm5zZjFpVUpJM1EwY0VPeDJTYWtkbldUZFlWME1pakNUVFpJ?=
 =?utf-8?B?dXc9PQ==?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dd0a1f21-4b2e-4c8f-8db1-08dabc75831c
X-MS-Exchange-CrossTenant-AuthSource: CY4PR12MB1366.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Nov 2022 01:56:52.6353
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 24z/2Y8frBPgQ8efPt+FTuW0In5L68HSdzW4HNgf/zKhFLJyUTyMk8XgFYlsSL5qDZY6i8eDF/KgLsoe0HaCPA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4956
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 11/1/2022 5:12 PM, Mark Zhang wrote:
> External email: Use caution opening links or attachments
> 
> 
> On 9/8/2022 1:39 AM, Leon Romanovsky wrote:
>> External email: Use caution opening links or attachments
>>
>>
>> On Wed, Sep 07, 2022 at 05:18:18PM +0200, Christoph Hellwig wrote:
>>> On Wed, Sep 07, 2022 at 06:16:05PM +0300, Sagi Grimberg wrote:
>>>>>>
>>>>>> This entire code needs to move to the rdma core instead
>>>>>> of being leaked to ulps.
>>>>>
>>>>> We can move, but you will lose connection between queue number,
>>>>> caller and error itself.
>>>>
>>>> That still doesn't explain why nvme-rdma is special.
>>>>
>>>> In any event, the ulp can log the qpn so the context can be 
>>>> interrogated
>>>> if that is important.
>>>
>>> I also don't see why the QP event handler can't be called
>>> from user context to start with.  I see absolutely no reason to
>>> add boilerplate code to drivers for reporting slighly more verbose
>>> errors on one specific piece of hrdware.  I'd say clean up the mess
>>> that is the QP event handler first, and then once error reporting
>>> becomes trivial we can just do it.
>>
>> I don't know, Chuck documented it in 2018:
>> eb93c82ed8c7 ("RDMA/core: Document QP @event_handler function")
>>
>>    1164 struct ib_qp_init_attr {
>>    1165         /* Consumer's event_handler callback must not block */
>>    1166         void                  (*event_handler)(struct ib_event 
>> *, void *);
> 
> Looks like driver calls it in an atomic way, e.g.:
>    mlx5_ib_qp_event() -> ibqp->event_handler(&event, ibqp->qp_context);
> 
> Could driver also report it as an IB async event, as WQ_CATAS_ERROR is
> defined as an async event (IB spec C11-39), and QP_FATAL is also an
> event of enum ib_event_type? Is it a problem that one event is reported
> twice?
> 
> If it is acceptable then ulp could register this event handler with
> ib_register_event_handler(), which is non-atomic.

Or move qp event handler to non-atomic as Christoph suggested? This 
means to fix the mlx4/mlx5 driver, to call it in a work queue.
