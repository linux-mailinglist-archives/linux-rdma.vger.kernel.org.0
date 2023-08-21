Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0ACC77827F5
	for <lists+linux-rdma@lfdr.de>; Mon, 21 Aug 2023 13:30:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232648AbjHULax (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 21 Aug 2023 07:30:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232579AbjHULaw (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 21 Aug 2023 07:30:52 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2139.outbound.protection.outlook.com [40.107.94.139])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CD86F3
        for <linux-rdma@vger.kernel.org>; Mon, 21 Aug 2023 04:30:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J2rJxHl1y0m6V9EC14UKdtPgDZVx/jQCc8rlok/8C7D9QBjZebNnut5sqTmmSpP9nUjke8EmBVPqgYmXkFDgaf+mxwwXpXGQMvF17ZAmiu2U62YhLurM3Wx4sn55bY0xhtfoa9SDHlQqLmMGYtaQ65aQt+KfQl/qphR1iAWtrbbodOFHheawmTjvo468HiTnP7zSM9OUjUAYtSroqzW8xVLUApzci7AoS6XzWv/Cylc7iiVvT2iOJquuzeUG6CaBc2QlIJzMhVCOciK4XXPcYWH4vIBbKDD2NEMJGA1ehuUT/fcmRXxzncqeyjVk2DI6xNgG6P+TF30QOy26rp1NJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CsiQVsFyBojXb8l1hBFNBhLmQmYId8h4blG32S/DVR4=;
 b=YBuHCSFh/Puv/n3G7Fzi+n3dFff3dWXdkcB0cjpeplRl2Qri3V5Gky+mlxzXji+OrOc5tYO5Qm9rtZjwrgTYYcSZgJ+/SSAKuno/KTlG7gtE5ui3YYTjvAWQRB++qpvGKSYyWub0mSZ7Ig5Wz+bVbothKjLdYeRITjYy8q3ol1nGqcAItDOfKpGQj6E4jrXXL2xt+JGm1OZLbFYoguje7wWRxslOTcWaojrqxO3oWSf921BA4H0VrQ0T4qLBGwLCLYu0CEyOWFYcwgrpceSCUJS1yxGbBJsRZxHEFDjqje4eVczGq8Rt5HDEBW2dKY+qaRYlcuwOLyITX6yX7g13Fw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cornelisnetworks.com; dmarc=pass action=none
 header.from=cornelisnetworks.com; dkim=pass header.d=cornelisnetworks.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cornelisnetworks.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CsiQVsFyBojXb8l1hBFNBhLmQmYId8h4blG32S/DVR4=;
 b=jC06WCcul8Iq9yqsHAF9uwldOLrIys63tOuhvBx3IFNJlqgiKi/ntGtHEnN13IoWOEkre64pmEeVxFutdadDi/xdOsiUkFj6PP/arN0M65VT0Mx8LrKnBbs5Xs118WQo2EFtg54SuptokLdxnJXrB+c3r8sHBPTNNHaiFS3Qcg9ftg5Ypkw1TdwS9PkaxJwd2tzYVlN5gRIviNejXdzKPXp9C3/wLCCcEpX2OHihg2wghmlHUqfu2K6c3OBBCGURH2GwFM/LJDz9e1ybtMqeA88VYTInAEuk9wbUYdIYRvhtOHGAkH1cHncgIpF9LVT6E00RuRpoo8Hh2KMV0IciMg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cornelisnetworks.com;
Received: from BL0PR01MB4099.prod.exchangelabs.com (2603:10b6:208:42::12) by
 SA3PR01MB8524.prod.exchangelabs.com (2603:10b6:806:3a1::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6699.24; Mon, 21 Aug 2023 11:30:41 +0000
Received: from BL0PR01MB4099.prod.exchangelabs.com
 ([fe80::4342:ee1b:931a:6929]) by BL0PR01MB4099.prod.exchangelabs.com
 ([fe80::4342:ee1b:931a:6929%3]) with mapi id 15.20.6699.022; Mon, 21 Aug 2023
 11:30:41 +0000
Message-ID: <3436599b-8687-2504-42b9-898b8bcb84a0@cornelisnetworks.com>
Date:   Mon, 21 Aug 2023 07:30:38 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.13.0
Subject: Re: isert patch leaving resources behind
Content-Language: en-US
To:     Saravanan Vajravel <saravanan.vajravel@broadcom.com>,
        Leon Romanovsky <leon@kernel.org>,
        Sagi Grimberg <sagi@grimberg.me>
Cc:     OFED mailing list <linux-rdma@vger.kernel.org>,
        Ehab Ababneh <ehab.ababneh@cornelisnetworks.com>,
        Selvin Xavier <selvin.xavier@broadcom.com>
References: <921cd1d9-2879-f455-1f50-0053fe6a6655@cornelisnetworks.com>
 <20230813082931.GD7707@unreal> <20230820094622.GD1562474@unreal>
 <4a628865-d555-4b60-3fc7-4675bb40af62@grimberg.me>
 <20230820173358.GF1562474@unreal>
 <686497ef0664fdb219c2e3d75b687bff@mail.gmail.com>
From:   Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
In-Reply-To: <686497ef0664fdb219c2e3d75b687bff@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN2PR07CA0009.namprd07.prod.outlook.com
 (2603:10b6:208:1a0::19) To BL0PR01MB4099.prod.exchangelabs.com
 (2603:10b6:208:42::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR01MB4099:EE_|SA3PR01MB8524:EE_
X-MS-Office365-Filtering-Correlation-Id: c6361d41-717f-4e67-ba3f-08dba23a0cd1
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0NfuhRGZ4SJO2WA2ZxoF/h+fr9nb0pS9hc+FFxDGQX6KW6ScqmroruV9zZhatcm7aHcV0eIbWhGnXWIR6OJuO8nwJzawlhcIppPnKttdpRRbPJJSDpJCPtRthMLYEXkh6PTupRXaRPHD1YbfPlL2Vg+JYONGgdXJ3nxVpQQYMeXrAuJ2qvwAhjaxeIRkox6hCMLle8KgoKpkI/fwVlUH9ZHoKa0/MCIcrs03bcrUmghHqD+HQXWtLH6ZfjS569t/nv03VQfPYjDJcRwLdilCwzuuc6/2TPZsOtBzYI9HglZV8nH0qTk5BIF3yekXoZ6wU/ixO91qSJ/icssRZIWeBN/raBpYHH8E32MPfm429ijww5i23Id65MoWTIYpnWyicO+v0d0wg1oVYSOR02zHVx0OMehfOXLQxrAe+Xe0K4ECL6x+8sdO5wKemqb8IYV7Wqo8HzLs+AvErjSlMVvScHxjD2/BalD4hNwtgA6iRlySzpqNvEwbVfXzMYC3SZPQXx+ewXmJLuk+9EKsoqgEBj3md9XbBTJ9BLCt3QcyN1tjvrMVFddLnL7MRU27+vNdYewfZA6H5g0sGPGBtMKx9/UJFadBKRs1tCHhn9aKgpmvbGkHmHfFa1YyQWwLn1x9Tvc44LItfrcWEC/5xVoENA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR01MB4099.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(136003)(346002)(366004)(376002)(39830400003)(186009)(1800799009)(451199024)(54906003)(66476007)(66556008)(6512007)(316002)(66946007)(110136005)(8676002)(2616005)(8936002)(4326008)(36756003)(41300700001)(478600001)(6666004)(38100700002)(52116002)(38350700002)(53546011)(6486002)(6506007)(83380400001)(2906002)(86362001)(31686004)(31696002)(44832011)(5660300002)(26005)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?emQrVWhKZEpZZ3hUSnV2dXgvMmUzWWNLYXNoL1Bvb2pxN2VIVmV6MFhVODI0?=
 =?utf-8?B?NVM5UXNKZmwva3VVZHgvUHVDT1lUU21VeVkyR2NYRmxVQTAzazVIbUFzanNV?=
 =?utf-8?B?QjJMUElQVU1lbXErU3ZLVmV0TXJnNGFEUms2Q2FoWmxrcnZKTVdwcEt1cDVm?=
 =?utf-8?B?ZTJRdkxzV1ZDNDdzdVkybWlJOFcyeUVCTnRUSEFoaDNqRXR5cjZMNm5zWkdM?=
 =?utf-8?B?REx2OXYva2I0ZmFaV0tBcVZZQUpRZ3QxWW9zQzRlUkNTS2lvaFRjOVp6dFg0?=
 =?utf-8?B?ajhsRDJ3bGJqNWp2Q2ZVY0tQTXZ4amJHYXY5ZEZBd2F4WEpIa1RPU0cxcWtl?=
 =?utf-8?B?TU55S2J1M291OEg2QzhxY0pxTzg0Y21NMzlVWmg1VjhLNlJCZ1VlV0d3akRa?=
 =?utf-8?B?Q2YwYUZzdlFlYUVqazFpTEhNMGRySEo1VjNDWnZSMDkzSHZGcjdqY25JSUNy?=
 =?utf-8?B?UzhEalhFTEFPeE5CVmo1bW5aaCtFY1JjTGgwcE9rZVFFZkE3OUZqdGlrQW8x?=
 =?utf-8?B?ZjRUUHlRc0JSb0NuQ05NdktOU0xZWmlBNkdSRDdmUm9DNmxwOFcwTENDcU9n?=
 =?utf-8?B?NE5wdUhCUUNtbGJldXp0WWw2Skg0NkxJYm1JMlRSWmdPMXB6aFU5cVJES0RN?=
 =?utf-8?B?eWNicG41ZG9jZlNMWENZT1ZDN0RLSkVIeXRWTkV6RFhGclptZy9CQk5Sbkt6?=
 =?utf-8?B?RjJhRko5ei91YzNiNHJ3KzgxZnAzekt4blV5VE5tMGdnanJnQmk1aHJHSWh1?=
 =?utf-8?B?WEo4ckZIZTdwczVZNTZpOWFNa01BOU5sVVoyN25YM1hxMS9US3VCT2RQOFF1?=
 =?utf-8?B?ekY2cGxwQzMvLytjOE5rdlVlRHVzcUtJYjB5a1E1a0pXNGd1QlNKN09BUzNo?=
 =?utf-8?B?MzhESldGb09uS2E1MisvNDlXVlRhdmhnQkwyeUN0cHVtT2pzUUlrbitPcU96?=
 =?utf-8?B?cFh3UU5mZC9vanZwRk1xQ1RlVktJN2dMVTlmZDVrWXRjSXA1L1drVS9iTXBM?=
 =?utf-8?B?eWxBbDVEQ0ZpNzJSMEEwYmZrYTVXM093S0FuMXpPd3E3L1NWUUdnc1Z5cXZV?=
 =?utf-8?B?NWF6K2RlVmkzZU5zWVFSQVpJd1BKMEJNS2U1cG1ONUpBaDRCRTFQaU5lUWw5?=
 =?utf-8?B?dmo4UXhWcFQwRmlrckcyamlXaVJvb2dYd3pIZktWY2laM2toc2dSRlBTZlp4?=
 =?utf-8?B?V3ZvcnpHWit3VVpEbmZlTE9ZWFRCdDBQUlZRY1ljTmxRKzYzTUdLbndIeUdy?=
 =?utf-8?B?SVZxWHJVcnJaSlA1YkhxYitWUEpXRU1keE9xTGVZdXdRNnFrc3FuZlV1NkZj?=
 =?utf-8?B?bWJEaGNWQzEwZ0RHSDZxL1hTcEU2dVhvc3Mxbm5xSHdoRnE2UzR6VHFsdWc1?=
 =?utf-8?B?NFRtSzBmWlJCTVp0QjRQVDB2Nk9LRHpuZXI1NWpIVWxBbFZBbGNkRitlL25X?=
 =?utf-8?B?akk0ZWFZRU1sdjNjVTl5SW8zbnRodVlaZzJ0QXdNUmw1cFVBMXQ4bXhNRFdR?=
 =?utf-8?B?aVFaeGQxNGxoU2U1Rmtsc1BuaDBEWTFlNzdaU1QxQVBKRWJZNXZseThqYXBJ?=
 =?utf-8?B?OWlvOU1UVGtUQkdmV0lka3dpSjBNMVNFa2xJS3BMU0hxMVlDeEJOejZHeGFJ?=
 =?utf-8?B?emFVeVVmeEg5NCtYSTZnV25FWGxvQTBER2RiVEVGcEFmYXFTV3dFd2xobGNH?=
 =?utf-8?B?cUtRRzc1djluQ1RFMVIrQTdmbkJrMWw0dmliSmJDM3hXcmZPWWlQWFk3eFN6?=
 =?utf-8?B?NFdON2pWc3RKSEpCTmsxRUJiNFFRMFV2MlF5M1V0bnV3ZUZuN2tSTE9Pb3VP?=
 =?utf-8?B?akg0TkNhL1VGNEdVNytHdDVNdjJvNXZIenNEM3h4SktkZzZ1QnRFbWd4ejlC?=
 =?utf-8?B?bk05VzZKNDNxSjNCVjcreFF0ZVR4aHJrb2g3djdyUWNSejNZbjdoUHRhM1R6?=
 =?utf-8?B?dTFoSlIrYTVWV3hrNjhKQnFwamRBWlp3anBPR0hraFlLeGoyWmJNWWpYak5h?=
 =?utf-8?B?K1YwU25CQUxxaytmQUN4TlNrVDVOUlJ4MGxpZ1pMZFAwQWhlK2RZSGYvYkNY?=
 =?utf-8?B?clU0OG1GSEkrS0F2MkRYdlVqS3AwdUNzQzRqcHM0SVVBOUN5NTFCRnNjb0lT?=
 =?utf-8?B?eU1WNTV0WldlRFlyR1RONXp2TytJd3R2ZFp0cXZQaDhTdzljMXpNbE5PU3F5?=
 =?utf-8?Q?9iXnaIgEmTxaSlI5lVmz6V8=3D?=
X-OriginatorOrg: cornelisnetworks.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c6361d41-717f-4e67-ba3f-08dba23a0cd1
X-MS-Exchange-CrossTenant-AuthSource: BL0PR01MB4099.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2023 11:30:41.1456
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4dbdb7da-74ee-4b45-8747-ef5ce5ebe68a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: c0OU7LAYZLh01YaG6jlcgIxdQIC6uoSeYVe5+Pkz24YKk8dAEC2TGFLjkYmq7FOAt5jZTXFMWL3NeRzGmpJdr9lUJw8G02NtZTeCzBfCIRZhAUk0KUnpNMq84fiPx57D
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR01MB8524
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 8/21/23 6:47 AM, Saravanan Vajravel wrote:
> Ok. I will work on the resource leak issue on surprise removal and push
> the patch. Until then, we can revert Commit: 699826f4e30a. I will find
> some time this week to repro the resource leak issue.
> 
> Thanks & Regards,
> Saravanan Vajravel
> +91-80-46116256
> 
> 
> -----Original Message-----
> From: Leon Romanovsky <leon@kernel.org>
> Sent: Sunday, August 20, 2023 11:04 PM
> To: Sagi Grimberg <sagi@grimberg.me>
> Cc: Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>;
> saravanan.vajravel@broadcom.com; OFED mailing list
> <linux-rdma@vger.kernel.org>; Ehab Ababneh
> <ehab.ababneh@cornelisnetworks.com>; Selvin Xavier
> <selvin.xavier@broadcom.com>
> Subject: Re: isert patch leaving resources behind
> 
> On Sun, Aug 20, 2023 at 05:46:12PM +0300, Sagi Grimberg wrote:
>>
>>>>> Commit: 699826f4e30a ("IB/isert: Fix incorrect release of isert
>>>>> connection") is causing problems on OPA when we try to unload
>>>>> the driver after doing iSCI testing. Reverting this commit causes
> the problem to go away. Any ideas?
>>>>
>>>>
>>>> Saravanan, can you please post kernel logs as you wrote "When a
>>>> bunch of iSER target is cleared, this issue can lead to
>>>> use-after-free memory issue as isert conn is twice released" in the
> reverted commit?
>>>
>>> So what is the resolution here?
>>
>> We need saravanan to address the reported resource leak upon
>> DEVICE_REMOVAL. If this stalls, I suggest we revert the offending
>> commit and add it again without any leaks on surprise hca removals.
> 
> Thanks, I'll keep an eye on it, if we don't get patch by EOW, I will
> revert it

Thanks for the help on this folks!

-Denny
