Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3ACBD4D1C54
	for <lists+linux-rdma@lfdr.de>; Tue,  8 Mar 2022 16:51:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348010AbiCHPwa (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 8 Mar 2022 10:52:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347961AbiCHPw3 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 8 Mar 2022 10:52:29 -0500
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2052.outbound.protection.outlook.com [40.107.223.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EE8D4F45E
        for <linux-rdma@vger.kernel.org>; Tue,  8 Mar 2022 07:51:32 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UGgcqsxVXvYxaFyN5R2N2c83sPWr6B48eJl2zqEouVWO5A3/ZmJJmiRm9F3vMhAbV5Aa3ZKBSFWxamMcLKCGEAdcz0Sv+o1DSNpOh3PWHFUa4oIG7JbPtb1RwmOaTMx30uueq51nHmad+N1e9ZpnvtQFbFYrNV2sHLUNKJ4Vp/ikQ+BXY4CzpjPeJAPcmLalk5qSObuke3h1V8O7mCfC97I9ZfhWJRLwuCSuB8wfg1T1F+zn9xDK0tkUh3cG+vhVkdhodUmg3yoNDc32YbcfO6tGyXi/q5HdBW2xDCoRH4GtexzySCvdtPi15kdYPCLBXosrxrS4UhGhO7sl4tl4+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=65Z6Raw0Y8rJ9/p7UWqhyimkJH4O5Gu0w94VFAmO1AA=;
 b=k00y9p0kOyHII8twxiCXHgjBzlFDA8OTzDZIvUFCSMuX6noEEkA6O1IHpeCxfjT9OCC/7C4isytNw1XajN0R5Vxd8SfMqcmTkw5/JiP82QBLTDo/p3aCSB4W3J8+A1b3JStoTI7fTxMxb2xdQwneIcVhHdYETTK1dGxTGwZ1U+zxSduCNu+dqak17fmDeNZyw2RWgqG8OyhldSmB1SlznglXCKgNWiGSA4Z/ASWbp3sJu+U2/rhRMI1jbPbeErJrZvDDrsBtpHZIXI9pvUGmLQR870DOaW5i4p62h24MpeOzevAq4pWNNSYM9uMT1YB2p9HsFv3GED1MfNqwCt8yrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=65Z6Raw0Y8rJ9/p7UWqhyimkJH4O5Gu0w94VFAmO1AA=;
 b=ckxzUIMzgU5ew1MQxPwdTqXkuO8prGYpfX9xhMgX/BNhp4GrmG2/htsaJe9Y5qiafqD+ltaK2Mty6veow4bcf/cPxZltOfiY8mvdIkdlar+STByPh3YrEbtMj1GNBaH6MEBOT4KcORV4yJ0lNweBGIu9CyCRJm6kGa2umvAZ1HyG2VN1K61ykztr3stFgRnUjXtzVQeMdRushZtsrB+X1l2046ujmWXXnSfR2FOZXYs6DuGGusBPTa5nORkoS+1OX3OYVTlWZJc07FFnSvwt/3wXVCBX2NZO5AJY+KMu4/DjbC8wfoaorkcpoHKFrt5VW0mruDtqi0AsZn34GRX/mQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM4PR12MB5040.namprd12.prod.outlook.com (2603:10b6:5:38b::19)
 by MWHPR12MB1662.namprd12.prod.outlook.com (2603:10b6:301:11::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.14; Tue, 8 Mar
 2022 15:51:30 +0000
Received: from DM4PR12MB5040.namprd12.prod.outlook.com
 ([fe80::f037:e2a1:f108:125a]) by DM4PR12MB5040.namprd12.prod.outlook.com
 ([fe80::f037:e2a1:f108:125a%8]) with mapi id 15.20.5038.027; Tue, 8 Mar 2022
 15:51:30 +0000
Message-ID: <9d9abd33-51f2-5a8e-9df9-8ffe72e3a30b@nvidia.com>
Date:   Tue, 8 Mar 2022 17:51:23 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [bug report] NVMe/IB: kmemleak observed on 5.17.0-rc5 with
 nvme-rdma testing
Content-Language: en-US
To:     Yi Zhang <yi.zhang@redhat.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>
Cc:     Sagi Grimberg <sagi@grimberg.me>
References: <CAHj4cs8vnLXyddEJkV_1Dbmn7UaM4sLX=C1CN9tuA-5Mhczayw@mail.gmail.com>
From:   Max Gurtovoy <mgurtovoy@nvidia.com>
In-Reply-To: <CAHj4cs8vnLXyddEJkV_1Dbmn7UaM4sLX=C1CN9tuA-5Mhczayw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AS8PR04CA0086.eurprd04.prod.outlook.com
 (2603:10a6:20b:313::31) To DM4PR12MB5040.namprd12.prod.outlook.com
 (2603:10b6:5:38b::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d474e6cf-ef42-4992-464e-08da011b830a
X-MS-TrafficTypeDiagnostic: MWHPR12MB1662:EE_
X-Microsoft-Antispam-PRVS: <MWHPR12MB1662C688660A179C350E94A2DE099@MWHPR12MB1662.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +32f9oeUgRZSFHtw3x0O+Fj3CXXU4m4QOT2FO5AI+MbDBJUgtvn+7Ge5jCrz5drJzlD9G+71RRNwdhSvH3J4iT1feQDRm7WUi8rvBG9qYKUSMdY26rhEj3njp2pMDAtx1pEXcBkZYy1VJve7A3GY18imwj+UHQkuAIVVNBMzakIbJz4p2xhg09JFQk5aOpm7OVYBXkErvO6Ri4Ka2+zGfsAzYOguL5tDF3Swfy6mGjgav2t0N/WOn74Dta0Pf1QmCmpEe7nVVdeB/RLdq0LA5FnuP2PPfTD+NeA3r4drEjiAaUAbdiqWxN7n5A9yeI7nu1nvj8FG01ks8FypnUpChU0MegnW3/GwBTIhAU+uYxE2jc0jHhq1WaEBeYvYaLbQILa7Wh1XgLN/GyKvgASA26KS7RiztpMiL7QYYkVdTd8vaPaVkSVGcL9e5VAhNMRzUDtyM5GVH/vAooCQJ2F5jN/J3XkwJfyhlJD1uhWWTMnx6XH1f8xemF0HOtwX8U9krcy8DBFzwqQRZs8TJz9qUiR/GxwEvMLiDqp/Zs/2qAQt032Wv0k4H5I6x6G1ONoMGyPoX8CrCmG4YdnC65nx9jXwJHYbK7bNJ3rqJJt6xgSTkL2mFjIw6iBzqeTQ0bIy4MY5oghQRqF6Ye71KpIGllDidej3GH2CXHfx9igzZZG9Hl4tdhdcq2UWllaOqotQaHhf/qDaL/rT33IP8tUhD30ZkKBBqSKwaqqekHBnd19ULCqTHiyZh+6TKI8JZmjksMgPboihp/y9uGjaCm9x5w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5040.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(110136005)(66556008)(38100700002)(66946007)(36756003)(316002)(31686004)(2616005)(6666004)(508600001)(5660300002)(6506007)(8936002)(86362001)(53546011)(6512007)(186003)(26005)(2906002)(31696002)(66476007)(4326008)(8676002)(6486002)(43740500002)(45980500001)(505234007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cEp6WHc3azBUNHY1VkhRWWRHRkwwSzRtV0RTN0hCQTNRSmdOelpqYkR6SHVU?=
 =?utf-8?B?QUlNODFOR2NkaEVlQXZEWC9LWFozeFBVakU0TEo1bkFGVmpjNUgyTUNlTzcx?=
 =?utf-8?B?bHJWSE1jVVQ5MzJnTVlwRUFJU0JnVFAzZkRQSytOZi9GZ0hwdmRHNXg1ZG5J?=
 =?utf-8?B?ZVFWQkVWN0NCT2dlclFsQktYQ2FyV3JaNndEbExVYndqcUU3RjV2UmZhZHc4?=
 =?utf-8?B?bW1pU3EwRE5KZjNXNHRsR1puVE4zOTZXUFI4Z1E1ak82dDkrNXpRVDdoOFFT?=
 =?utf-8?B?bjFIcGdHYm0zSXREU2liSk4wR2hmaE1qeDR2RXl2WmlnR1l0YTQrZEIyMnZv?=
 =?utf-8?B?SFRoNXJPRW1SemVWN3dacnJXeEROdW1pa0l6QWpiMmN0NmlacHo4OStYcmo4?=
 =?utf-8?B?Y3BJUzNLY1ROdnlRTERxNEQ4R0oyeXQvUUpwcWZSOWNjMnB5d1R2anFmY0t5?=
 =?utf-8?B?ay82enJ0dVVtOWtHSTFoYnF2ZXIwMGgrdXBXQldDejZrWXVXWUJ2eTZWUUVx?=
 =?utf-8?B?ZVRCYkRoMEl5ZzMwWmVVVHdneE1NbkhnV2tWUHFFbHA1RUtjVnMzQXZ6QWhQ?=
 =?utf-8?B?eSszU3JXZGl2K2RBc0xEb01vMzBjeEs0YlRCSm9BVHUvWFZtQXBGYXpUV1Va?=
 =?utf-8?B?WVJ6T1VOK3hXVlFTRlRXSTBnN01yY0ZhV0lyRVNBN3RTM3cyODAwQk9BbGtj?=
 =?utf-8?B?M2taeXZZaEp1TElISFl6dTBBeTRTWmZNSktlMzI1cXk5Q3hjdThkYXVtMGo2?=
 =?utf-8?B?bFdkaGJmRWxNck9xTyt6cGwxOFlwTTRyTFhObm9RYlp5dU9rNlluZ0xiOGoy?=
 =?utf-8?B?ZmcrdHNJSTJGMjNhRTJweTFtUTBta3J2VG5JYzRUWHVEVE5ha0RhUG5xeTBG?=
 =?utf-8?B?VU8zZjNuMEprRVp5Z3BQRE5oVVNReUsyeUxaWXFWQzZLNC9PQmU5bWl4T1M5?=
 =?utf-8?B?dWdIdFo1elVFY1hNcG9EMk05am5RaVZpVTVsdXBDVnVuNHVKbDliSzkxVFpu?=
 =?utf-8?B?RFA0MGFKZ3Nub2hzMEU1ckVROEY1NjdUSDFjQjNVNnREMFZzbjg0a1h6WEx5?=
 =?utf-8?B?RFU5Rzh2V2MxeHNleUFESWNaK2JQckZJb25yZE9VYk1QT3B6M2xOZG1UTlJq?=
 =?utf-8?B?cFUyWndDSHlwMVlGbFozWURQYWlCR2s5UFRPYUR5QmJjNVQrM05FTDVtZVBr?=
 =?utf-8?B?Ymw5N3BJY2lqK3lqT3p4U3dEZm8vT0pveXoxVlZlVzREa1BIQzRKeVI0Zmw3?=
 =?utf-8?B?WkFOd2VqMFB2dXVZNFBqK0hmSER2dkQ3ZGI2Z0dUY3lJVEZvdiswOVp4Z1ZR?=
 =?utf-8?B?eUdTTE51L2F5Tnlqb3htQmpjeGdHSVJrZHJSd3BnQ1Jyc1pLQnVGaUFLMG5J?=
 =?utf-8?B?akRPaTI3VVZGR2hsWXA1M2JUNVhPdlJjc1Roc3FXdDNsUjdsRG9XUXRCcHZr?=
 =?utf-8?B?bFVyUXFNVk5PZGdobFN6ZW5kdnBXcFdKVlZNM3B4Rm50OS9QeXJyU2JqK3Vw?=
 =?utf-8?B?OGtMRzhlbU1vaWZESnpkcHVtRHhhNi9VSjhTYVdJK2hMQUxIVlh2bGdlb2NZ?=
 =?utf-8?B?bEY2R3ZuS1JHUUp2OW9SbFNkR0FQWSs0R1c0VDB2QkJIZHZQaFZZczE3Wjli?=
 =?utf-8?B?dzYzRHZhSzJORUdaeXVDSHVkT1RTTVE4M28yUzFQcmpxMXpJZzFKdFVzVnBF?=
 =?utf-8?B?Z2RTdlhXWTJIN2t4WUtzeWFVR0RwSnpsN0oybFY2UFF6UGljVjZCSHdxZ3p3?=
 =?utf-8?B?OXJ3a1lvNkVqYVlJRXpmQXhsMkF0cjBQK1dIeENGbGxheTIvb2VwT0taYkwy?=
 =?utf-8?B?VCtaK20zbGdDbGNjY2NTM0Vndm1SQk1PTnJmNG5GZGMvaHVHRklyVDBHUUhL?=
 =?utf-8?B?eVJBUk5aSnQxVUZOS3RJaG9QTWJhWTc4ZDcya3oya2FyeDVvYzlrS0xjN1BT?=
 =?utf-8?B?dTJWSXE2bGlmNjlCSmFzWVZUaVNINU84Zi84UFBjTlhhN0o1MndldWFwVGpK?=
 =?utf-8?B?N3YzVHlCK2J3QWhOaFhCMXNTWkdqTUJFSzBpMnhSQnpuWlhFYm9nMEdEL0Nv?=
 =?utf-8?B?UDBZSUsvdEVyTXFNTGVTTy81a0J4U3ZGNEgwaXFwdVZMd0JqWU5SNDhzSXJD?=
 =?utf-8?B?bFN2K0xBcUM0bCtFbHpyNTJDUVZDQ3J0dk5YeEhkZGVaVi82TWJBemcxUlIr?=
 =?utf-8?Q?CDe2nLUJnJ+0cXTTN5DxjzI=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d474e6cf-ef42-4992-464e-08da011b830a
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5040.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Mar 2022 15:51:30.2766
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: R/5Fs8OToAxHhtfr3KcgXcvG5lelL4nDASN/u0Z9Zn4abVE/MwinSWgfPtVO7A3nFRi2TgqmqjfAyQgaZ8lrKw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1662
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Hi Yi Zhang,

Please send the commands to repro.

I run the following with no success to repro:

for i in `seq 100`; do echo $i &&  cat /sys/kernel/debug/kmemleak && 
echo clear > /sys/kernel/debug/kmemleak && nvme reset /dev/nvme2 && 
sleep 5 && echo scan > /sys/kernel/debug/kmemleak ; done

-Max.

On 2/21/2022 1:37 PM, Yi Zhang wrote:
> Hello
>
> Below kmemleak triggered when I do nvme connect/reset/disconnect
> operations on latest 5.17.0-rc5, pls check it.
>
> # cat /sys/kernel/debug/kmemleak
> unreferenced object 0xffff8883e398bc00 (size 192):
>    comm "nvme", pid 2632, jiffies 4295317772 (age 2951.476s)
>    hex dump (first 32 bytes):
>      80 50 84 a3 ff ff ff ff 70 d4 12 67 81 88 ff ff  .P......p..g....
>      01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>    backtrace:
>      [<00000000ecf84f29>] kmem_cache_alloc_trace+0x10e/0x220
>      [<0000000099bbcbaa>] blk_iolatency_init+0x4e/0x380
>      [<00000000e7a59176>] blkcg_init_queue+0x12e/0x610
>      [<00000000aade682c>] blk_alloc_queue+0x400/0x840
>      [<000000007ed43824>] blk_mq_init_queue_data+0x6a/0x100
>      [<00000000cbff6d39>] nvme_rdma_setup_ctrl+0x4ca/0x15f0 [nvme_rdma]
>      [<00000000a309d26c>] nvme_rdma_create_ctrl+0x7e5/0xa9f [nvme_rdma]
>      [<000000007d8b5cca>] nvmf_dev_write+0x44e/0xa39 [nvme_fabrics]
>      [<0000000031d8624b>] vfs_write+0x17e/0x9a0
>      [<00000000471d7945>] ksys_write+0xf1/0x1c0
>      [<00000000a963bc79>] do_syscall_64+0x3a/0x80
>      [<0000000005154fc2>] entry_SYSCALL_64_after_hwframe+0x44/0xae
> unreferenced object 0xffff8883e398a700 (size 192):
>    comm "nvme", pid 2632, jiffies 4295317782 (age 2951.466s)
>    hex dump (first 32 bytes):
>      80 50 84 a3 ff ff ff ff 60 c8 12 67 81 88 ff ff  .P......`..g....
>      01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>    backtrace:
>      [<00000000ecf84f29>] kmem_cache_alloc_trace+0x10e/0x220
>      [<0000000099bbcbaa>] blk_iolatency_init+0x4e/0x380
>      [<00000000e7a59176>] blkcg_init_queue+0x12e/0x610
>      [<00000000aade682c>] blk_alloc_queue+0x400/0x840
>      [<000000007ed43824>] blk_mq_init_queue_data+0x6a/0x100
>      [<000000004f80b965>] nvme_rdma_setup_ctrl+0xf37/0x15f0 [nvme_rdma]
>      [<00000000a309d26c>] nvme_rdma_create_ctrl+0x7e5/0xa9f [nvme_rdma]
>      [<000000007d8b5cca>] nvmf_dev_write+0x44e/0xa39 [nvme_fabrics]
>      [<0000000031d8624b>] vfs_write+0x17e/0x9a0
>      [<00000000471d7945>] ksys_write+0xf1/0x1c0
>      [<00000000a963bc79>] do_syscall_64+0x3a/0x80
>      [<0000000005154fc2>] entry_SYSCALL_64_after_hwframe+0x44/0xae
> unreferenced object 0xffff8894253d9d00 (size 192):
>    comm "nvme", pid 2632, jiffies 4295331915 (age 2937.333s)
>    hex dump (first 32 bytes):
>      80 50 84 a3 ff ff ff ff 80 e0 12 67 81 88 ff ff  .P.........g....
>      01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>    backtrace:
>      [<00000000ecf84f29>] kmem_cache_alloc_trace+0x10e/0x220
>      [<0000000099bbcbaa>] blk_iolatency_init+0x4e/0x380
>      [<00000000e7a59176>] blkcg_init_queue+0x12e/0x610
>      [<00000000aade682c>] blk_alloc_queue+0x400/0x840
>      [<000000007ed43824>] blk_mq_init_queue_data+0x6a/0x100
>      [<000000009f9abba5>] nvme_rdma_setup_ctrl.cold.70+0x5ee/0xb01 [nvme_rdma]
>      [<00000000a309d26c>] nvme_rdma_create_ctrl+0x7e5/0xa9f [nvme_rdma]
>      [<000000007d8b5cca>] nvmf_dev_write+0x44e/0xa39 [nvme_fabrics]
>      [<0000000031d8624b>] vfs_write+0x17e/0x9a0
>      [<00000000471d7945>] ksys_write+0xf1/0x1c0
>      [<00000000a963bc79>] do_syscall_64+0x3a/0x80
>      [<0000000005154fc2>] entry_SYSCALL_64_after_hwframe+0x44/0xae
>
>
>
