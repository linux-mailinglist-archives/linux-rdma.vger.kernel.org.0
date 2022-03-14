Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D6704D876C
	for <lists+linux-rdma@lfdr.de>; Mon, 14 Mar 2022 15:52:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232878AbiCNOxo (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 14 Mar 2022 10:53:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231700AbiCNOxn (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 14 Mar 2022 10:53:43 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2061.outbound.protection.outlook.com [40.107.236.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A88F41FBF;
        Mon, 14 Mar 2022 07:52:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Kznz8Dd6cK0nIqSCPiEcMJh4FgM6BY5nzNmwsQE45Onnvpu9QzFh79z8dFvGlXC+eFMg8qoQtO+w84ndofDjtJRNXrt3g0EM4ki/ZkfRetuQs1zu2f1Xsbf67T9IEJkqxuKTbuBQR4dqwa3GZPGseEEWKxn+u56ru/BL9vtJwrMuecXdM9tg6XriddxNlGOoquaavpsM/hT+FMTxD2ovIlljCtgH8a/TLDcYpnHf6xkG6YBYsJv5Gmzx4urGFpVY4rhA/+9Fo7OGTO4wnIe2UaYjr1X3kJYm+xFe6fGx0nJqLrU7Ba0Uq3dzJcOTb8zq2W+oUZvvPDSXaTtrT5/v1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VzdCSCi1PvZOdczIfJ1zlpfNicSuvLMIERiZ0JKM05A=;
 b=drMyz7fAETKlHZtmfEXMLc60iPvXlSxCAMd/68039GCI4ZK/NdUNVjWuj4aNwOn2XdVYJJztSErALjDguyAmepUtJQvJWGOlPxOJAVH/kiUGcza+zbDSl155tzvnvaAt3a6xX9o57+z7GCjpocixwaT7lASHMBQ0vOsAvjxm2N+oG+ReQT6fExQg0FoFdbofQl9DXAYArKpxEeRef8J695r9kLyLJgigU8QIiECoTzzdmcK9QxA/cjEaE12fwWSdLFtBU4uBT0wedoKcRoLa8om/s6bg4QUydvdaSPFj6pXH9bzTz1Lqujw0MCjLBBnAeU/GOLtKjkK3Qg4qkLXfXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VzdCSCi1PvZOdczIfJ1zlpfNicSuvLMIERiZ0JKM05A=;
 b=nQd3CxxZ7Ntt0xbz8DApGPTXL2znzA61SZg2ZuHIBko+DdXKcwt3ek33z/Xr9cRLCSp4puLuMzBez3AeanZecyjuVYx++8oheBMPBncOImcC42kCqTc8+O3PMKB7OFdrtkjm+mayZjsfeVDS4p8HV1Ff0fOASoESeHkUZPQpsJPrbtHaAm6GXgdtZC/wtwexA24aPDhPR4aUCjR5QLnqBFxbLziv96Iy73yt3LhjAm+wN74pYQ6qF2nagjFbcr8AoVmh39bj7yZExuKag33iF3k/SfYuVHmQa/eGyENHUK/9Y93NJLOjMx2QvQNT2EwUkRxowD7dqiJzgbpotPftRg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM4PR12MB5040.namprd12.prod.outlook.com (2603:10b6:5:38b::19)
 by DM6PR12MB2761.namprd12.prod.outlook.com (2603:10b6:5:41::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5061.26; Mon, 14 Mar
 2022 14:52:31 +0000
Received: from DM4PR12MB5040.namprd12.prod.outlook.com
 ([fe80::f037:e2a1:f108:125a]) by DM4PR12MB5040.namprd12.prod.outlook.com
 ([fe80::f037:e2a1:f108:125a%8]) with mapi id 15.20.5061.028; Mon, 14 Mar 2022
 14:52:31 +0000
Message-ID: <e39a032f-9e95-a038-c29c-30bb58e45fc0@nvidia.com>
Date:   Mon, 14 Mar 2022 16:52:24 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
Subject: Re: [Patch 0/2] iscsit/isert deadlock prevention under heavy I/O
Content-Language: en-US
To:     David Jeffery <djeffery@redhat.com>
Cc:     linux-rdma@vger.kernel.org, target-devel@vger.kernel.org,
        Sagi Grimberg <sagi@grimberg.me>,
        Laurence Oberman <loberman@redhat.com>
References: <20220311175713.2344960-1-djeffery@redhat.com>
 <b97dd278-eedd-1324-1334-78addee204f9@nvidia.com>
 <CA+-xHTFCPXe-vALE1ApWdhNOJOByGSgmn5=fF1A_P57zYQGNcQ@mail.gmail.com>
From:   Max Gurtovoy <mgurtovoy@nvidia.com>
In-Reply-To: <CA+-xHTFCPXe-vALE1ApWdhNOJOByGSgmn5=fF1A_P57zYQGNcQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM6P193CA0092.EURP193.PROD.OUTLOOK.COM
 (2603:10a6:209:88::33) To DM4PR12MB5040.namprd12.prod.outlook.com
 (2603:10b6:5:38b::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8638ecb7-4c70-4fa0-86a1-08da05ca4414
X-MS-TrafficTypeDiagnostic: DM6PR12MB2761:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB27614D479E03949E7216BD8CDE0F9@DM6PR12MB2761.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: c7hPt8xRWL/sRkcLOQRTmUClRCke0xTFnHBriyI/nCxxVWDVJQZpDtne07ZeB+4mUDvlum+McwGLsJSCjLYeMtfM9WrYJ2ahRffJieYWIy6Ws0jSUzJVPaRWuwM2OqvSvMXdASldsp/WZEwkYBLkj9ymhvBISLQNQ7c/o8gM9Mb/jdDm54NDHuYl7yTbtpgDkyfp4R8oQ/w0qFsrmbHGGxmuKGwT9uHXbgN3QslVKk3SRFqhAIKJBwzcu6wAIC+ZOWhdV9+8v/QjmpluNBDjgD1S+e9IHwPyI6nMq97b6LCrkChHRU9z+GFp3ntSJUvslqXKrFPxEirRd+NCBOsRhVv5mzYJG1FU83eYcgzJCRtExrrNovkUY+pP7bL5uBI8yi9ptW1gTJYtJdYVawTyK3NccHMi1k/GqTOPlQBgqvXGNDgrx7hn4DsfH2SeDmzppxdl4zTpOWn6jQBkKko1RLVLOjltv560WqzcOmewHk24IJWcDlHMGWIyBRUazBcK/6efVu2828L5hHWUbjGz0cbiA09r2qHYA+q90pUDdSsGW3uN9d8CcmhUEYoMtA7eQmuhBLY18fWWdc8R7dmUGeRmn9El7jPaycdb+7GHBYR+Qwyx9RVG/RXxXxWyqDP38OAREkXIz7OjE+4y4+HxwCEK0jp0TPFcHEGpjtboPZl4fJQzmfRmd/meUBRDe/MTdaFTHWzJ2qYnjwQFVWqf61xAjGSJ8pPpqZSssDbZuQA=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5040.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(316002)(4326008)(6666004)(6512007)(38100700002)(86362001)(31696002)(6506007)(53546011)(2906002)(8676002)(66476007)(54906003)(66556008)(36756003)(66946007)(6916009)(31686004)(6486002)(508600001)(8936002)(5660300002)(2616005)(186003)(26005)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZjFodUNrVk5pRStwTElhRDFLS2Jka2k0c2p6cDdtaDZUTnAvQVkybURSVUJE?=
 =?utf-8?B?NmdVanlCOGYxekE2STA4T0RsaGZFbE1OWlhEMFNma24wbkxsUDNJaFgxZFFq?=
 =?utf-8?B?L3MzMnFybkFZdkZxYzhxN0tJRGtFV21mQmdlTFdvWnNkYis4Y0VUWUR2bmFm?=
 =?utf-8?B?ekRFRWFrQ3pndzErZ0p2Q21ZMU9Wd0FNTXdPT1ExaVZIRnVjaGxmcENyZEZZ?=
 =?utf-8?B?REREc1dDTHFVSFBmTjlzdFBTcjB4UXV6UjBXd2RpZnVQRjVyWjl6NVppZlV5?=
 =?utf-8?B?Ty9SeHIyUm5ueHVFUmJRRmdqRmx5cUVrZlVhZjJXeHdudG1xYkJsVG5ZNjNK?=
 =?utf-8?B?cXREYkZrTmNxZVNYd1N3QTBlK0NsMlQ3akNJMHgxRDdxdHBETklpQXExTTIr?=
 =?utf-8?B?bjU3blI1NmNVejZRUnNGc0dJS2ZQdDh3ZFNjTHptdGVpS0tVZ04yRG8xUkht?=
 =?utf-8?B?VXozRUdaRUZFRXNRVG5NZUcyVExvRk44bFJkclM4UitpVmlpVlpWVUlyeWIy?=
 =?utf-8?B?M2ZXK0JxOGRPVTAvWTN3VHFwOTVTMmd2aS9sZmNtNndLVFNuZDlETmJ5Nmpa?=
 =?utf-8?B?ZXQyNzB4M3UvOTNqUG9SYkNqUkEvTE1BdE9UYU9Ib09TRlhLazB3QlhwQ010?=
 =?utf-8?B?RmdRbG9DMEZ3dDhNK3crM3Q0VEl4QWtpVzRCOHI0S0wyQWhlcUZyVVF0dk5K?=
 =?utf-8?B?ditacDNpbTN2U2pPVUxPUmZNSXZsSVR4VmJQaTRtTjVPYXdZdXI0UGhIY0ls?=
 =?utf-8?B?Nk9YUXc5bDI2ekhiWHcvWGJBbEFYYUVMejN4S3hWaGxrVm5RTnZ4VkRZNGVr?=
 =?utf-8?B?MHZ4V0hBUythQldvOHlBVVhvN1g2Rjk3SHdPSnJvWk5rMmQxalRycmtIVFlN?=
 =?utf-8?B?WUlkQTVuLzdVa3FJK3MvSG8zWEJNNGQyVzV3V1RZckJQSVRyd2pBTm91R2hK?=
 =?utf-8?B?MGR6cHUzWERlRE0yS0FMaWpFVlBoWGNJejdYUFBEWFlCZkNmSHFraXVNMmVN?=
 =?utf-8?B?WTd3d3B0dHAyQmRoRi9yVkFCVTZ1SzNEODYxOFU5bEpjT29xQTdwaEk5VTV6?=
 =?utf-8?B?YTd5VDVCcU9qdysxbVhUbmRBYUtZWXRyMFovSGdyTFlUc2Z1MjZIbmdJaVJu?=
 =?utf-8?B?YjVOSmwwL3Vnd1MxN1E2TU0rUmxLTGVPQ2k4SVpLZW50VCtCZDgwWUhzUWl0?=
 =?utf-8?B?YTFYUXJTVDlyeEgxNTRrS1M5ZUVmeU8vNXQvNjU4a2NoY0d4Zk05Rmo2K0pL?=
 =?utf-8?B?UkNOU3FnRGZSb2szWC9RUjBpYnUwUW15bkFyNnVvTTZsc0NxbXVXVWhnVnpG?=
 =?utf-8?B?MGVYS3paeU1QeXlzSEtiQk5jYWZUZjhacVYyUk02T0RwY3U0QURQSXFMYlVm?=
 =?utf-8?B?d1pja1lLMTB5Y2RmY0JFblh4Nmt1M00zNkdEbWZSY2J2YTF4bVJIK2h1VWtU?=
 =?utf-8?B?d3VXc2NMa3hiOWRrVlpoSVE0dFBMME0wNUpCQktsb2JWUkJ2WnIxUWhjQTFo?=
 =?utf-8?B?UlZ1N0R1aittbnBTbXJQc1hYaW10dWtNWERjSWVEa2x3d0MzUVhuOCt5aGt3?=
 =?utf-8?B?QlBYNmJYNVdVMUZmUXV5Wnk3djBOa1VjWGxUd1NpUHJOTmt2ZDR6R3U1V1kw?=
 =?utf-8?B?bWtpVFc1ODAyM2tnN05GaEx3VHJYemNDQUIwc2poRXdRYmF3Y285N0pmVnV5?=
 =?utf-8?B?eVZobWJBUURvN29iakFNYjZCdjFjVFpXU1I1aWVITVBKWjJpblVWSE1iMld6?=
 =?utf-8?B?YkVlMS96WmJKeXlrQVJhZ09zQ3Uva2xnNkF2MG1pbTBpbS83WUJDNk82Y0JV?=
 =?utf-8?B?SHpHN1UzZGtXY3UrUEk5ZmVpZkpUaWN3aXFNRmhsRUliWmdOK21OS0szejR5?=
 =?utf-8?B?cVNXVXBxRmttUWhEV1ZndTFwdWo4SGVKSlowS1pHSHpKeXE2a1o1TzJOQjYx?=
 =?utf-8?B?K1RvU1RuSjZGNWkvTjZmdENtVmlLWGIrVDFiVm5PNzRZejhSSVBLTlB6bHFD?=
 =?utf-8?B?NnF2QXRKK3VBPT0=?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8638ecb7-4c70-4fa0-86a1-08da05ca4414
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5040.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Mar 2022 14:52:31.4293
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: M2Wjfzg0bpjWTD6vY1GlF9FbN5YedMUuOiXkzMNSo3i2rV22ZyFR6uF1K3QmDw4Q9SappgQ90BkQGtWM9Pj93w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2761
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


On 3/14/2022 3:57 PM, David Jeffery wrote:
> On Sun, Mar 13, 2022 at 5:59 AM Max Gurtovoy <mgurtovoy@nvidia.com> wrote:
>> Hi David,
>>
>> thanks for the report.
>>
>> Please check how we fixed that in NVMf in Sagi's commit:
>>
>> nvmet-rdma: fix possible bogus dereference under heavy load (commit:
>> 8407879c4e0d77)
>>
>> Maybe this can be done in isert and will solve this problem in a simpler
>> way.
>>
>> is it necessary to change max_cmd_sn ?
>>
>>
> Hello,
>
> Sure, there are alternative methods which could fix this immediate
> issue. e.g. We could make the command structs for scsi commands get
> allocated from a mempool. Is there a particular reason you don't want
> to do anything to modify max_cmd_sn behavior?

according to the description the command was parsed successful and sent 
to the initiator.

Why do we need to change the window ? it's just a race of putting the 
context back to the pool.

And this race is rare.


>
> I didn't do something like this as it seems to me to go against the
> intent of the design. It makes the iscsi window mostly meaningless in
> some conditions and complicates any allocation path since it now must
> gracefully and sanely handle an iscsi_cmd/isert_cmd not existing. I
> assume special commands like task-management, logouts, and pings would
> need a separate allocation source to keep from being dropped under
> memory load.

it won't be dropped. It would be allocated dynamically and freed 
(instead of putting it back to the pool).


> David Jeffery
>
