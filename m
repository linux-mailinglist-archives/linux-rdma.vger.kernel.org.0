Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 197764D464E
	for <lists+linux-rdma@lfdr.de>; Thu, 10 Mar 2022 12:52:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238960AbiCJLx1 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 10 Mar 2022 06:53:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232126AbiCJLx0 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 10 Mar 2022 06:53:26 -0500
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2074.outbound.protection.outlook.com [40.107.243.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A1F1145AD8
        for <linux-rdma@vger.kernel.org>; Thu, 10 Mar 2022 03:52:25 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DdfdmRsnonWhHBuKPmtnfbJ/1H7cwftdCvDWdNVzGOh6+v666kpM3k+q7tDAdYU9wAVyl6wdhNTWSwP6XY5mV+DL1JDTBWfhLWV3VDPFNt0YitpseygEMo+Ta8N0J4MNNAF+l81gEGeVkJWbeyVMusDuvbWOyk4Ildkb3EmfZCXJe2Weqdht1penPOTTBS2lOS7WpElo89LU+4buwDifKUf1w70DdPhIevWCD5T1hgrsoeiqK+nM9OH0NxpbS16autE95auQEam3hqVwNOLU6RW/+Wn+kRGCMoc3hSUTTi1bSFV0sv9CPrVohTJX63moqBRSEKCBq/r+P0glq26kTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tj2sa6Wv0SA/5GquKDVUu0wArnUFsHDIZuWYCoIF1BA=;
 b=n65tH2iCwk5GfUWWCbDALzL6dd4nVMVirXwrBCklNsoyB6crh4suJyDvPKWOOXo9rb4xs+rqcfJeU5jvdrw3lKYVzrAOjqzlI5tg1ioYaHs0UqwH/nwq60ZPilTYuJWWnfw/cBsWdjQYJgFuEy+3sAfcSGuJ1k6rFai43zQwnbui+2AEtwkNZh/+dLLI/IhGD+OFALK2p8aR6JOP3YiE647rhdNaSBB19+b2UHU+GiY55FsxKNn5n8Y+2yaS91VjZPy9Bjc3yuSkSrviFKSJSYkQ0xKI83641REegtdEo8hJgc7qHGe7HAXIXtDHnGvIQ5Zjv4UrubOGRCQlLouaDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tj2sa6Wv0SA/5GquKDVUu0wArnUFsHDIZuWYCoIF1BA=;
 b=eeprnYz+7+Ofts6RJton80BCcJF4mKCyJ1nVGPV85KdIqCWUPfIPVU3LJR+BdKgFtmzBYAJkmv4DzAINHfil1/AaWl33jr0WdJRBcj+SfeT6sVD21ASXFdWzP7SnQYnWA+krBtfXQA+LuXNRyuMyPLU3Kb/jqWuy4l0hGRm2bvgEVwSGpeGOUyxqPN13Vn2O3ekhta0RD9p+D4RvH6azT8pp8dnPSgjMPjjC2BPbbsqGUScj3JV77V1+zTgWkdLNe5JztbmYtxmGoOpkenvQAfGQoarS4Wn7PwA23qw5APbrFkMA1G3GlZJadYu4bHVvL1Xwawcqz/G42tmQ4hrYrA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM4PR12MB5040.namprd12.prod.outlook.com (2603:10b6:5:38b::19)
 by SN6PR12MB2782.namprd12.prod.outlook.com (2603:10b6:805:73::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5061.21; Thu, 10 Mar
 2022 11:52:22 +0000
Received: from DM4PR12MB5040.namprd12.prod.outlook.com
 ([fe80::f037:e2a1:f108:125a]) by DM4PR12MB5040.namprd12.prod.outlook.com
 ([fe80::f037:e2a1:f108:125a%8]) with mapi id 15.20.5038.029; Thu, 10 Mar 2022
 11:52:22 +0000
Message-ID: <bbb103d5-7622-dc88-07b8-1edc684d2f82@nvidia.com>
Date:   Thu, 10 Mar 2022 13:52:15 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
Subject: Re: [bug report] NVMe/IB: kmemleak observed on 5.17.0-rc5 with
 nvme-rdma testing
Content-Language: en-US
To:     Yi Zhang <yi.zhang@redhat.com>
Cc:     RDMA mailing list <linux-rdma@vger.kernel.org>,
        Sagi Grimberg <sagi@grimberg.me>,
        "open list:NVM EXPRESS DRIVER" <linux-nvme@lists.infradead.org>,
        Nitzan Carmi <nitzanc@nvidia.com>,
        Israel Rukshin <israelr@nvidia.com>
References: <CAHj4cs8vnLXyddEJkV_1Dbmn7UaM4sLX=C1CN9tuA-5Mhczayw@mail.gmail.com>
 <9d9abd33-51f2-5a8e-9df9-8ffe72e3a30b@nvidia.com>
 <CAHj4cs_uViOtdMmFmJZ=htBXybjUP3uL3LnRR0C4PCnHWUM82A@mail.gmail.com>
From:   Max Gurtovoy <mgurtovoy@nvidia.com>
In-Reply-To: <CAHj4cs_uViOtdMmFmJZ=htBXybjUP3uL3LnRR0C4PCnHWUM82A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM6PR0502CA0055.eurprd05.prod.outlook.com
 (2603:10a6:20b:56::32) To DM4PR12MB5040.namprd12.prod.outlook.com
 (2603:10b6:5:38b::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 57b7285f-69aa-4b74-4b07-08da028c6fe4
X-MS-TrafficTypeDiagnostic: SN6PR12MB2782:EE_
X-Microsoft-Antispam-PRVS: <SN6PR12MB278223684917EC45B7BA3D97DE0B9@SN6PR12MB2782.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DO+dARJcrexEAyPF3ZqF4Xsl9IiDR/cLEG7umBUAIjvwCQDV6pNL5wCFCbFlWLHRwaPePZQ1tCJDm5e00Wu+gWwNW/0KcpJyWnx02Tj6+0gd9ecIq1Kv0sM+glTZ2YUmoppD06ZomINAuQWHzngdkoJnkruWd8+ODBQZ2uph89zlarj5IvPfVT9RsPXfKNJSxMkx1djYen9BXSqNffIBkK/6mqMe6CALd/00pan6PTLvFoRFds9tl3yNZvH8Qw0/3af1lTxTaKb0XKgls7wGbDwU6JtULBhsxeVGg2pqWpipSfQL7WkSTlZiUdtN/WQ19utThPanNE4kT6N9dSZiuCRR/wBqtzSqP1BLjx1EmeOlUp43VGvdnpDXaCKHoHed3tNsVgmvSUYpJur3DfiWcA77kzBdN7k+xUDkO3JubRmCmnh5oNOvnN7feJxqxfOUReF65cQnMWVQ2xe5ORNpkUzFjBPtwyN7MvCSC+DHkLt1vZlZ/jSYLesx73Sk3mA3ZWg0PXRQBMh7sXChZrVMtBl8AikXxM11VJZRL6UIqy6PXT4aZPyfSMS3RiloM2hOxAKnscSbFL2PJLUjXhLO9QzLG94ab6EAYVqTHfZ2g7K8mvYZMM3pEtAuhgzLNCKmryYR9uHl5Wfp59S91nirPzZCHZfq+gWvsnlbl2SdrcHll2J9jC/afk8okd6aSAyQ4ELFGTk3122MJVLgGvlInfT4vA9o4H6FvOki8E/vwDwVRpc92+fEE5iY7MOXQPYtwRWANdKWbFcXLVK/sDYYZYemKAiNglALUaBqG22jBeBJR0qrc72luT1DBp7y856FAxjPMBA3cArOja8etikp0Js3xIFGS6bo/gIYZTqGCSQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5040.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(2616005)(53546011)(6512007)(186003)(66556008)(6666004)(6486002)(2906002)(31686004)(6506007)(36756003)(107886003)(45080400002)(26005)(5660300002)(31696002)(8936002)(66946007)(54906003)(508600001)(316002)(86362001)(66476007)(6916009)(966005)(4326008)(38100700002)(8676002)(43740500002)(45980500001)(505234007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?V3lLcWtoRDc1RTJXaTlEcDNETVczRjZCUlNOWlFYMndZaEpKN0VZTXFjSjdx?=
 =?utf-8?B?WjdMOVVhMzdxcUJmdFMyOFc0dlpwNTFESHNWRFNIU0RXeloxQTUxMjVndGUy?=
 =?utf-8?B?bzJoMUJ2NXJiaEZLYzYzRmpwSmJIUk1tNW1Xb1gveXlqcTRFNnNMbFlta1FC?=
 =?utf-8?B?MGxvZWI5R3B0Wlk1ai83elYxdVV2MEU4UXo5S284d0IwZ2xTWW93MXJ1Y2I4?=
 =?utf-8?B?Yy9ncUFPQ2xOU3BiVmE3R0dWZ2RPWnhSZ0hML1FDL2tHK1ZwL2lnQTJzRndx?=
 =?utf-8?B?Wm9IcXhxUWx6NC9JejBBd3Z4V3FRMngyMWVSNzRPd2pxdkNpbDMrT1RHbU5Y?=
 =?utf-8?B?T0lIZVpSaXBEb3lVQVB4dVJ1azM3N0E2ZzVxUnpqa2wzd20zR25sRUlsaUR6?=
 =?utf-8?B?aXhrb2RPSFBiM2tHcXZjSVQrRUVlTS93dWtSMWNZcDRJT25RT0NaMGZ4eXFX?=
 =?utf-8?B?cFhiQ1ZBT2dSM1JPeE9ldXQ2WHFpckViVytXQzE0bUNmZlJwYjk2bkhiQUVJ?=
 =?utf-8?B?dm1pRkw0b2tESitja0VmS1dRSzhHTldMTDdmK2w3dWVNUVBxVzFYaUJ3ZE5Q?=
 =?utf-8?B?R0UrUVoyOEYrOVFVYlhWMmJPK0RVcnZMWEZJVWRZUmIyRDl6T1NGZ0N3b2ND?=
 =?utf-8?B?N2lyY3hkYkozai9najFzMlk1cXlxU0kyVjhIbC9HcmRFS01oLzJreVI5YWVY?=
 =?utf-8?B?aWRMcTNVenpnZXZCelBOWllMU05ZbGIzeHpFN3BlZ2tTeVA1eS9RcW9iY1pL?=
 =?utf-8?B?M1RBSEVKSWRPQzZXZTNldWVBcFdaWm1ES1VmYUlTOUZ1RjdmQXBYY2xSUDEv?=
 =?utf-8?B?WnhQTFNSNFlycVV5LzgzUkVNOHh1Q1A3N0xUVUdRK1l0WExLT1R1dHc0N1BC?=
 =?utf-8?B?bUgvVDdHRnNGd0FnUmdrNHZtbFg4TE01QzBKZURnK1owVW9pM1VESHVIbS90?=
 =?utf-8?B?VkFSVWRHT1RWTEhhYlFPSXg4NmVxQ21LRkIzOTVJd0RjT1dtcXEyUEhFOUpU?=
 =?utf-8?B?S3BOM3Nwckx6cXVydzVtaGc2djhJYkVoZGFqaUhEQ0EydndQZ09vMDB1eUY3?=
 =?utf-8?B?M0hrTXhtVkFXTTVMUDI4RG1zWTZRVUpXVkEvZHAxdGpTNkoxYUV4VlBtUDY4?=
 =?utf-8?B?UitPNHBSbHVLdnovR0VVZ1Z1d0dXR2R6SVhDOEhpeXAvRGd0Z1g3ZkR0bFZF?=
 =?utf-8?B?MDB3QU12cXBoMlZ3SHZONjdyVVpmRUliaE85WVhZeWV2cTdJTDF1U0xmSEE2?=
 =?utf-8?B?Rzl3dzV1cHJHNlZQQjhFNVNlMFJFSmIrRFVHS2tkSjN4V3ZUSnNJaGRnNnJi?=
 =?utf-8?B?ZExXSUhFUFYxOVNpaXlEQzhEQ0RRdGMwZkorV1poY2E1L0hwZ1N3dElGaWtm?=
 =?utf-8?B?SXVTdVhYRVNmSGRQQ05vMkxQV0sxeVY4SGZxQmNkZWY5VFdKa001MjkwOG5P?=
 =?utf-8?B?OHFVN2R2aTNhaUp0RllmVEx5cGl3Z0RmRXg5WERLejA3U3JFckFGdkVwY3Y3?=
 =?utf-8?B?Ulc1UURFekt5S0dmcVhEbzZHTkRNbzhzNmhDeElPUkZCYTgvY0VYbC8zdHZI?=
 =?utf-8?B?aWdVL3IvOHJOK241S0lBN2dFRXQ3SlZjdVowWWg2YjBGQUw3OTZlQVhhVlB4?=
 =?utf-8?B?ZjAwUzRFeFVWWUVqUTNJdC8zSnJpbTY5YXFxL0NvaG9VelpXU1d5eW41ZzJ0?=
 =?utf-8?B?S09zVWV6NDQ0Z1V2WXVaZ2lXeWswelM5bHUzeWp1Zk1FTmtyenBPbU5NY2lD?=
 =?utf-8?B?WDBpRE5uOFRBUWhyUUlvWU1XcG1rQ0tGRE5odkJydFNYZ3VPQ3FUYzA2b0I4?=
 =?utf-8?B?SGsra2lNTnMrMXVzLyt2RW56aXhnVURFZm0xQ0M2MzYwOHBRWjlodnNodHV6?=
 =?utf-8?B?RVlwTDdJV0tISXV4VEpnOFlYbG0wZUxkeHA2cTlETG5JN05jZVMwSWZJUE5K?=
 =?utf-8?B?UDRsV3ZGak5uZ1g3dFB0d1FTSTdGd1pYUlFGWVJUUmc2MUlHOFlGUGI3NHFZ?=
 =?utf-8?B?VEdFZ1JNdkJ3PT0=?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 57b7285f-69aa-4b74-4b07-08da028c6fe4
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5040.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2022 11:52:22.4755
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /je+3scOQTCS3Gtj4Y9wamJ4ZZ7D09HuB8xyybjO4VXa5bqBo1RJh72M/2aBV5xwMf2gWNIxBQoJQS3RYKKUtA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2782
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


On 3/9/2022 12:59 AM, Yi Zhang wrote:
> On Tue, Mar 8, 2022 at 11:51 PM Max Gurtovoy <mgurtovoy@nvidia.com> wrote:
>> Hi Yi Zhang,
>>
>> Please send the commands to repro.
>>
>> I run the following with no success to repro:
>>
>> for i in `seq 100`; do echo $i &&  cat /sys/kernel/debug/kmemleak &&
>> echo clear > /sys/kernel/debug/kmemleak && nvme reset /dev/nvme2 &&
>> sleep 5 && echo scan > /sys/kernel/debug/kmemleak ; done
> Hi Max
> Sorry, I should add more details when I report it.
> The kmemleak observed when I was reproducing the "nvme reset" timeout
> issue we discussed before[1], and the cmd I used are[2]
>
> [1]
> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flore.kernel.org%2Flinux-nvme%2FCAHj4cs_ir917u7Up5PBfwWpZtnVLey69pXXNjFNAjbqQ5vwU0w%40mail.gmail.com%2FT%2F%23m5e6dcc434fc1925b18047c348226cfbc48ffbd14&amp;data=04%7C01%7Cmgurtovoy%40nvidia.com%7C8cef8eb496e84d35f52308da01575419%7C43083d15727340c1b7db39efd9ccc17a%7C0%7C0%7C637823771831899724%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000&amp;sdata=kjMvRAWlBe1ym3FDQO1rdZ9%2FwtKQpscvXRG48aTt3L0%3D&amp;reserved=0
> [2]
> # nvme connect to target
> # nvme reset /dev/nvme0
> # nvme disconnect-all
> # sleep 10
> # echo scan > /sys/kernel/debug/kmemleak
> # sleep 60
> # cat /sys/kernel/debug/kmemleak
>
Thanks I was able to repro it with the above commands.

Still not clear where is the leak is, but I do see some non-symmetric 
code in the error flows that we need to fix. Plus the keep-alive timing 
movement.

It will take some time for me to debug this.

Can you repro it with tcp transport as well ?

maybe add some debug prints to catch the exact flow it happens ?

>> -Max.
>>
>> On 2/21/2022 1:37 PM, Yi Zhang wrote:
>>> Hello
>>>
>>> Below kmemleak triggered when I do nvme connect/reset/disconnect
>>> operations on latest 5.17.0-rc5, pls check it.
>>>
>>> # cat /sys/kernel/debug/kmemleak
>>> unreferenced object 0xffff8883e398bc00 (size 192):
>>>     comm "nvme", pid 2632, jiffies 4295317772 (age 2951.476s)
>>>     hex dump (first 32 bytes):
>>>       80 50 84 a3 ff ff ff ff 70 d4 12 67 81 88 ff ff  .P......p..g....
>>>       01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>>>     backtrace:
>>>       [<00000000ecf84f29>] kmem_cache_alloc_trace+0x10e/0x220
>>>       [<0000000099bbcbaa>] blk_iolatency_init+0x4e/0x380
>>>       [<00000000e7a59176>] blkcg_init_queue+0x12e/0x610
>>>       [<00000000aade682c>] blk_alloc_queue+0x400/0x840
>>>       [<000000007ed43824>] blk_mq_init_queue_data+0x6a/0x100
>>>       [<00000000cbff6d39>] nvme_rdma_setup_ctrl+0x4ca/0x15f0 [nvme_rdma]
>>>       [<00000000a309d26c>] nvme_rdma_create_ctrl+0x7e5/0xa9f [nvme_rdma]
>>>       [<000000007d8b5cca>] nvmf_dev_write+0x44e/0xa39 [nvme_fabrics]
>>>       [<0000000031d8624b>] vfs_write+0x17e/0x9a0
>>>       [<00000000471d7945>] ksys_write+0xf1/0x1c0
>>>       [<00000000a963bc79>] do_syscall_64+0x3a/0x80
>>>       [<0000000005154fc2>] entry_SYSCALL_64_after_hwframe+0x44/0xae
>>> unreferenced object 0xffff8883e398a700 (size 192):
>>>     comm "nvme", pid 2632, jiffies 4295317782 (age 2951.466s)
>>>     hex dump (first 32 bytes):
>>>       80 50 84 a3 ff ff ff ff 60 c8 12 67 81 88 ff ff  .P......`..g....
>>>       01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>>>     backtrace:
>>>       [<00000000ecf84f29>] kmem_cache_alloc_trace+0x10e/0x220
>>>       [<0000000099bbcbaa>] blk_iolatency_init+0x4e/0x380
>>>       [<00000000e7a59176>] blkcg_init_queue+0x12e/0x610
>>>       [<00000000aade682c>] blk_alloc_queue+0x400/0x840
>>>       [<000000007ed43824>] blk_mq_init_queue_data+0x6a/0x100
>>>       [<000000004f80b965>] nvme_rdma_setup_ctrl+0xf37/0x15f0 [nvme_rdma]
>>>       [<00000000a309d26c>] nvme_rdma_create_ctrl+0x7e5/0xa9f [nvme_rdma]
>>>       [<000000007d8b5cca>] nvmf_dev_write+0x44e/0xa39 [nvme_fabrics]
>>>       [<0000000031d8624b>] vfs_write+0x17e/0x9a0
>>>       [<00000000471d7945>] ksys_write+0xf1/0x1c0
>>>       [<00000000a963bc79>] do_syscall_64+0x3a/0x80
>>>       [<0000000005154fc2>] entry_SYSCALL_64_after_hwframe+0x44/0xae
>>> unreferenced object 0xffff8894253d9d00 (size 192):
>>>     comm "nvme", pid 2632, jiffies 4295331915 (age 2937.333s)
>>>     hex dump (first 32 bytes):
>>>       80 50 84 a3 ff ff ff ff 80 e0 12 67 81 88 ff ff  .P.........g....
>>>       01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>>>     backtrace:
>>>       [<00000000ecf84f29>] kmem_cache_alloc_trace+0x10e/0x220
>>>       [<0000000099bbcbaa>] blk_iolatency_init+0x4e/0x380
>>>       [<00000000e7a59176>] blkcg_init_queue+0x12e/0x610
>>>       [<00000000aade682c>] blk_alloc_queue+0x400/0x840
>>>       [<000000007ed43824>] blk_mq_init_queue_data+0x6a/0x100
>>>       [<000000009f9abba5>] nvme_rdma_setup_ctrl.cold.70+0x5ee/0xb01 [nvme_rdma]
>>>       [<00000000a309d26c>] nvme_rdma_create_ctrl+0x7e5/0xa9f [nvme_rdma]
>>>       [<000000007d8b5cca>] nvmf_dev_write+0x44e/0xa39 [nvme_fabrics]
>>>       [<0000000031d8624b>] vfs_write+0x17e/0x9a0
>>>       [<00000000471d7945>] ksys_write+0xf1/0x1c0
>>>       [<00000000a963bc79>] do_syscall_64+0x3a/0x80
>>>       [<0000000005154fc2>] entry_SYSCALL_64_after_hwframe+0x44/0xae
>>>
>>>
>>>
>
