Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 111056CFD02
	for <lists+linux-rdma@lfdr.de>; Thu, 30 Mar 2023 09:40:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230324AbjC3HkP (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 30 Mar 2023 03:40:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230401AbjC3HkJ (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 30 Mar 2023 03:40:09 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2059.outbound.protection.outlook.com [40.107.94.59])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0DF349D8
        for <linux-rdma@vger.kernel.org>; Thu, 30 Mar 2023 00:40:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jzGRQ9TyI/TvdgmwXUOVn2dfdvaB3mYinUZyYOoBbx6P8wpZSC+tPic3rEocGFLuOAEyK0mlsiqS4rITEIg/yzrjDVbZX9QSIr/UBGBMCCVA5s3wyLKJTMJH1IicVkUbHGRnSlG9fbGeRN9uRHtJlatpt8Z+XNMzWffMhvY18JVFaupywIEDlyCmCFL0Qr8NJHBbHM7AP1aKNQUyXtDPiqYjHiXRWZJi4kh9Nfnggh3AnLSaaVSWycZIvpfpCtVaPCrHFAdQ8WhIj5PvjK1CMsYOoP7RjfZgOQJPXoWeBDTgW96YcVPomznZXhOCSG9CSjzk1nzj2BeMiiW0F5kFug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=45ZEiDadGOEGcJjYtXW6FejI2L0smR2mQUo5ijq547E=;
 b=dhWXSUQrV4I1EM7w4hOb5QXqi35MUYOdxCV66Hmx3V7MQ4nFIjFTxmnvqoqCRuKAz/vcA3a2nudW3PnYeAwwAWDnuHa6Z3cZWjawz9v5LclA7DbwNQN3gbFk7XVXOSp3UkbRUVMhRdA6sJ+V21wQgjWFEk2iSogrfLxIZkHaa31C6jOQm+M0O/FVyg2t2tXa6hpiYC+FyJwX8SNAuPxu5T3bTXkjB6WiWeJ6noALE5oArTZ0oEwTW5RL5BP5ixy3vgphhKz6/hNQiFx2W72FLG3JHFcenfy9Oj/QUaOd1gZXFfhcD20HkxSIX4nUK6G9uYzAr8jMFtaA6r1eBP7X1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=45ZEiDadGOEGcJjYtXW6FejI2L0smR2mQUo5ijq547E=;
 b=hrHVb9C6anvIq75DS4SjXe65atSnQx18wU2naOLJgRiEqax3D7Tg163Wo2wBDuPuu4t+4qknhbcox6Zl7d1mQ39mW61N6FPs3E9uG6EJs0t/qZxDFVKVuzDmWcs/kaWzDFYdpqLfqwQ6/h9eA2izVx3eK/Yx7Eh4RakMtE09rB1b0hcAKwTrU5vJHRJJ+8ajW10J3jrBJ3oJpdLfOeOlBWl0vGtEz9wQ71hGuYThOBtsBN+o7tdmRGMDEN2ylOlLBxZjJZYxs47nnLi/82qSL14pJJsT2/RUwdATfgydOAzMvFf30F8xYoYQIQ3miQqlxqYhq+E35J8eYJSut18AKg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY4PR12MB1366.namprd12.prod.outlook.com (2603:10b6:903:40::13)
 by IA1PR12MB6578.namprd12.prod.outlook.com (2603:10b6:208:3a2::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6222.30; Thu, 30 Mar
 2023 07:40:05 +0000
Received: from CY4PR12MB1366.namprd12.prod.outlook.com
 ([fe80::e4f4:cc5f:89a3:3e44]) by CY4PR12MB1366.namprd12.prod.outlook.com
 ([fe80::e4f4:cc5f:89a3:3e44%4]) with mapi id 15.20.6222.035; Thu, 30 Mar 2023
 07:40:05 +0000
Message-ID: <f4a661b8-359e-3c2b-3077-c767ce042948@nvidia.com>
Date:   Thu, 30 Mar 2023 15:39:56 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH RESEND rdma-next] RDMA/cm: Trace icm_send_rej event before
 the cm state is reset
To:     Leon Romanovsky <leonro@nvidia.com>
Cc:     jgg@nvidia.com, chuck.lever@oracle.com, linux-rdma@vger.kernel.org
References: <20230330072351.481200-1-markzhang@nvidia.com>
 <20230330073725.GU831478@unreal>
Content-Language: en-US
From:   Mark Zhang <markzhang@nvidia.com>
In-Reply-To: <20230330073725.GU831478@unreal>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR02CA0133.apcprd02.prod.outlook.com
 (2603:1096:4:188::18) To CY4PR12MB1366.namprd12.prod.outlook.com
 (2603:10b6:903:40::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PR12MB1366:EE_|IA1PR12MB6578:EE_
X-MS-Office365-Filtering-Correlation-Id: 5671f40d-cd19-4c1d-6ea7-08db30f1fa74
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IEis5x6bQ5EikkbVMHr3SpH0UbCBYMWpd+wsYgoxqdrDhFEY0uLZ2eyQBjfOXAiq7sIoPxe+gxcLsX6q/kp2ko4I8FuV8BnzAZzJZyKLW/Xr/i29ANyfZbKp473Yr+P/45CEUul4PXjmiXjH3IBxPok53lpXdymFmGHD3lxnXtbg+EkFsg89HeaJ/fj7y81bOoGOb+PF3EdUJOxcsn6cEUJ2FWADWSFBoKQluytfzZeL8IWwCFgtIt/w0zV5Lig1PmM+jh5DdtzC9XI/dueMS683VGhZdFBw7UKbB1pWTFiQomFz2MTmya4YsCgFKKfyQqrM78w6oUrY8q2Wvp22JdCuhf2etgJhBWs5DDPri9MsduFZkWyq/mfZmMke6nlt5c2Fhmu9stQ8cF/NzxQSZZT0CbsdUX9WtIt0j0L0dIxLae14fxgzR1WlB6FTsmflR4MKhagMlFwYum3HzJojBD0WbVpTNz+CsynlaD0BKf/t+EgFQcaX0z61FV376jexH2DFzetdlmbf7ZdlRIXZguNcZCVfJeO1KQpATNiIt6w0DIKVymZqr2Gy13YWzbek0S6os/jVMMfxfUkV5v1WWg7Scd5V+L7n6snpQXkUFc1YdfxW+TWYjjMN6BdWREVcyDUQNsP1mT9aPIxIkkHT3w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR12MB1366.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(136003)(366004)(39860400002)(376002)(346002)(451199021)(53546011)(6512007)(26005)(41300700001)(6506007)(6666004)(186003)(6486002)(83380400001)(2616005)(31686004)(478600001)(37006003)(6636002)(316002)(38100700002)(66476007)(4326008)(66556008)(66946007)(2906002)(8676002)(86362001)(36756003)(31696002)(5660300002)(6862004)(8936002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?R3dyUXQ5TkFyNGF6Z2JTdE0rYmRiN1pWdmFUN2taYUthcU5xd2V5VFlUbmg2?=
 =?utf-8?B?bE10dEp5SUVEeExLYkxUdi9uTFVKOS85WjJZRmNEcEovMitTSDRwMnc2Mm9O?=
 =?utf-8?B?V01EcWhab2VIUmQzcjc2RGlFb1BUODhDSnl5VHB6Vy83N1c0OSs4TkRWYUpz?=
 =?utf-8?B?M1FlSWFRN1o4dmtWcVJTT3RLVmFRRlY5UkJVTi9TRndXWWtMb3FqMS92SDE1?=
 =?utf-8?B?WVhzNjV4RGIwSlQ2b3BoVTEreTEvYzE2V1ZLRGVyZTU1M2RQc3J6K1orblNQ?=
 =?utf-8?B?MVcvdWNDL3drVGE5Tlh1djcvQlA2eDJmZzdhNXByRGdNT0RsZHQ5MlhVdGts?=
 =?utf-8?B?bndMTmc4NllYWTNJNlBzeFo4K1hxeFFPUWdWMkoybk01MnNMZjN5UE1uaGlS?=
 =?utf-8?B?STZLQlNFNkREb25ZakdGSncwT0JoTlRRc1N6RG0rRXJneW1YNnlQTEpUMUI5?=
 =?utf-8?B?V3BjLzBOWHI0dnZSamhkbC9sMWdveVRiTnRKU3dqYnRGZ21PRHRFekdOcTEv?=
 =?utf-8?B?MmNzSHZkZVhPUXVjSjlJVEhOeitZWDJNK1hGNkd2QUM5MFBrS1dvemYxbTB5?=
 =?utf-8?B?aDIwdktBWWJHTGlzakRFeUFmL0puVFFOSjhmUXU5SC83Sk56cHFWUXdGNDI2?=
 =?utf-8?B?dForT3BzTmN6ejB3RkZPMHZ2WnFud0ZqOWg3WUJodVAxbDVHNFZQOFZ0RWdE?=
 =?utf-8?B?SHRwUVJMd3I0OXJaclRIdHVEYjk5eWZxcnZBcS9Qd2dCRmtUVXRBNkNPcUpC?=
 =?utf-8?B?UThHcDJuNXcrK3hNQ0IzSURYUVRtNEdYMFJkM21KL0tZRGJVbjk0WjUrR1pl?=
 =?utf-8?B?NXJ3NGJkcjkybGZ1Z3F3cHFCa3IrNTAyUEYrcWgyVHNkOFh3cEF3R1A0WW1Y?=
 =?utf-8?B?WjBNNDNZRis3bVZzVE4xd2NHRHpGZnZVK3htbm9vY1k1akhqWVZrRVhoekhZ?=
 =?utf-8?B?ZDRlSDRJb242RkRFdVNyT0czelYrSlRUaUtyUXBGMktuUHBlS0pnNHZia3hj?=
 =?utf-8?B?Rm5Mdk9Db2VsajFBcUlSdFdHWkVIb1FvWmRZekJCVERjUWJQOHZiUFFkaFg1?=
 =?utf-8?B?MXlSS3BodzNrZEo5UG1vK0VNSzJpRGl5THhQOVJQc0hoWU9YVmh6T1dWRkV3?=
 =?utf-8?B?dHVZOEszQW5WM2dhOC9KK0NRNnNYZzI5aldSdVJXTzJ4SFpQdDNsczVoRWJU?=
 =?utf-8?B?V2pzZ2JWdVNSYURZd2UyZGxVZXVUL0xLc2dEeUdnNThwcDRVRXpGaE0vb2ox?=
 =?utf-8?B?R0wwUVJuWTF6MGhuL0sxSHVQRGw4Nk5Galp2OGlLb1VPQU93SzNFQi9oQzFk?=
 =?utf-8?B?aFkzNnRiaWpyS2U2bmRjVkE0Y3FsZkVrSVlxVnIyYkwwVGhtNFNnUDdIL0tz?=
 =?utf-8?B?NTZEdEFOWUxzcURiUmtQMzliMGVBdVkyYkxWaCs1U05EbVkvdG9ZZDV4aVRL?=
 =?utf-8?B?WmRVV1VVaXFBbWx3YnBnakRaNTVtQldVQ3NMODlTUllsM3R6QXBXUG5pbVFr?=
 =?utf-8?B?ZnpVYTBaclpMR2ZMZ2lPb3Q1dGdIdmIyREpJZjRQbzFSTGZuMkhuMU5ZNnhH?=
 =?utf-8?B?UVRCUDV6QmdNK2RibU1uRW9QeElySVlyNW5EK1RoZDdwWDM5bjM4Zjg0bXVD?=
 =?utf-8?B?OFg5K2lxL2dOSGxNV2EraklseE4yVUpKcXFBLzZwbkZHeEl2MlQvbXB2elJY?=
 =?utf-8?B?YUduUDYzZnF3ZmdHVk9oNmNQZDgrdVI5T2FGOXloY0xJWmRnRzlFa1RlRFA1?=
 =?utf-8?B?TFg4OXBQR3Z3UDRJbVFVbXpHNUZBZ0hOS1c4aFRuSk1GMjBFTVFPc2JTa2hG?=
 =?utf-8?B?K2RnTDhtblVKSGJreHJGMkRJQUNpMVdraktCR2NyZ1k0bWMwT3NMWUdiNVVQ?=
 =?utf-8?B?NU5ySmtTTFNwNThCNHA5c3QwdXhJTDFNK3hKTGRBSkdnaE8wQWxVaE9qZWZ2?=
 =?utf-8?B?S3hQTTlTQlEvYlFONlNWWmppNzJoWDcxK3djZmNGUDB3a2Zwc2N2RDJLQUlS?=
 =?utf-8?B?cVJ0ejBDTEkyam16UnJZZWxFODNMRmY4L05yd2UrWE05NEVscFV5YU5BQjRy?=
 =?utf-8?B?VWFMaE52Uk5BNTFKYWtqWTRISmhNWVFMbVluNVdOVk9HRmFKN2owTTJQV1hQ?=
 =?utf-8?Q?5T1yR61yx+zHr2uSmX7FiORSL?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5671f40d-cd19-4c1d-6ea7-08db30f1fa74
X-MS-Exchange-CrossTenant-AuthSource: CY4PR12MB1366.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2023 07:40:05.3311
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: z1UC6FP192YiTWHEcckOp8qoU89X4YbLPvC3zKujp90S+cgMfC2L0dnPidywtMNAUOkONgyI8l8zlZ0JAaCqrQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6578
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 3/30/2023 3:37 PM, Leon Romanovsky wrote:
> On Thu, Mar 30, 2023 at 10:23:51AM +0300, Mark Zhang wrote:
>> Trace icm_send_rej event before the cm state is reset to idle, so that
>> correct cm state will be logged. For example when an incoming request is
>> rejected, the old trace log was:
>>      icm_send_rej: local_id=961102742 remote_id=3829151631 state=IDLE reason=REJ_CONSUMER_DEFINED
>> With this patch:
>>      icm_send_rej: local_id=312971016 remote_id=3778819983 state=MRA_REQ_SENT reason=REJ_CONSUMER_DEFINED
>>
>> Signed-off-by: Mark Zhang <markzhang@nvidia.com>
>> Fixes: 8dc105befe16 ("RDMA/cm: Add tracepoints to track MAD send operations")
>> ---
>>   drivers/infiniband/core/cm.c | 3 ++-
>>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> For future reference:
> 1. You sent new version, so your patch should have vXXX in subject and not RESEND.
> 2. Changelog is missing.
> 3. Signed-off-by should be last.
> 
> There is no need to resend this patch, we will fix when we will apply it.
> 

Thank you Leon and sorry for the trouble:)

