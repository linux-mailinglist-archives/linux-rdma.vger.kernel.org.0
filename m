Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 65806403AC2
	for <lists+linux-rdma@lfdr.de>; Wed,  8 Sep 2021 15:33:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243317AbhIHNe2 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 8 Sep 2021 09:34:28 -0400
Received: from mail-dm6nam11on2048.outbound.protection.outlook.com ([40.107.223.48]:64125
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232097AbhIHNe2 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 8 Sep 2021 09:34:28 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Sr2zx63dFYh+QdrUGvx/pI5SMaliZuKmF0EkOlA8v7eA0ussM5msdaC6ZxCqKoXnAh/Ck2wEjztPuoA64PgUP07PCQSsTP3kBsha8e9iY9aFHd13JcgazunbW3YlfscpzNQqSc0ZqcyQsHuBvvB0GOHFvPe42OQFPrbvElIRzJea0IKR/PeRs0tWJywhts26EiLUKIqRX1U5KtwvaRp4yCvZpvuxnxbaZevzZF89RRwsRjB0bEQ61h0OZnGysJzSzvbCbRqEenJz0B6xg0SZYhPFxKodxmlUYBhD+NxqftUZo7LNsEYRY8HPjPnSlCnnLJiPClHHsOtSthOIQ/pICQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=SYf0138Lwn1biLy2QZVPCeoTaezWEjG5eiD1lSbF6C0=;
 b=ShflxvLmyYI+Fp2FWDIHMcu8XwTffYc4fGjW1utT+5WOAOhtUW6cydcjB8zYAdLbTaeA8YelnY5XqF5UkKDCtECHdiylO+fvz2I6XgnZb5XbwE2BQNL1Gi1dk9lVCeK52RSklq27UTKYE5oBXPpgB/iZqadWsydMOwHiMBPVYmGmvjDg6/kYP7tTFrMv74uAkAjDkjjeyvbKUXTM8h9046N7ihjClJIk8N/1A02egIcirxsMioQ4S8e+uXd6aKrEyDJJteLnBhNwMbT5IyvF8POC7CUwMozmPHZs2GTsvwcZ1lHYREhokvYtrg+Of6tPRFKPkyN6RPsY4A9WC+/XlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SYf0138Lwn1biLy2QZVPCeoTaezWEjG5eiD1lSbF6C0=;
 b=fW4krBvk0oitevQcnxVBmUGc6ag0CBNckqTbJDtHkXIS6+hVQ/sSREicuywMmpabLYU2zpU3edFiZvb7UBhWHk7oP344Hni3zQ6yqgrLNfDwTbH15W3lYHuuw3WIpj0BGQM9RaMogkQca8Emx6YxWDTDSbCuJuPJVsErC+TWXC8=
Authentication-Results: igel.co.jp; dkim=none (message not signed)
 header.d=none;igel.co.jp; dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB3775.namprd12.prod.outlook.com (2603:10b6:208:159::19)
 by MN2PR12MB4208.namprd12.prod.outlook.com (2603:10b6:208:1d0::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.15; Wed, 8 Sep
 2021 13:33:18 +0000
Received: from MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::dce2:96e5:aba2:66fe]) by MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::dce2:96e5:aba2:66fe%6]) with mapi id 15.20.4500.015; Wed, 8 Sep 2021
 13:33:18 +0000
Subject: Re: [RFC PATCH 1/3] RDMA/umem: Change for rdma devices has not dma
 device
To:     Jason Gunthorpe <jgg@ziepe.ca>, Shunsuke Mie <mie@igel.co.jp>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Zhu Yanjun <zyjzyj2000@gmail.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Doug Ledford <dledford@redhat.com>,
        Jianxin Xiong <jianxin.xiong@intel.com>,
        Leon Romanovsky <leon@kernel.org>,
        linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
        Damian Hobson-Garcia <dhobsong@igel.co.jp>,
        Takanari Hayama <taki@igel.co.jp>,
        Tomohito Esaki <etom@igel.co.jp>
References: <20210908061611.69823-1-mie@igel.co.jp>
 <20210908061611.69823-2-mie@igel.co.jp> <YThXe4WxHErNiwgE@infradead.org>
 <CANXvt5ojNPpyPVnE0D5o9873hGz6ijF7QfTd9z08Ds-ex3Ye-Q@mail.gmail.com>
 <YThj70ByPvZNQjgU@infradead.org>
 <CANXvt5rCCBku7LpAG5TV7LxkQ1bZnB6ACybKxJnTrRA1LE8e6Q@mail.gmail.com>
 <20210908111804.GX1200268@ziepe.ca>
From:   =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <1c0356f5-19cf-e883-3d96-82a87d0cffcb@amd.com>
Date:   Wed, 8 Sep 2021 15:33:12 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
In-Reply-To: <20210908111804.GX1200268@ziepe.ca>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-ClientProxiedBy: PR3P195CA0021.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:102:b6::26) To MN2PR12MB3775.namprd12.prod.outlook.com
 (2603:10b6:208:159::19)
MIME-Version: 1.0
Received: from [IPv6:2a02:908:1252:fb60:e9d0:54fe:9083:60ce] (2a02:908:1252:fb60:e9d0:54fe:9083:60ce) by PR3P195CA0021.EURP195.PROD.OUTLOOK.COM (2603:10a6:102:b6::26) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.14 via Frontend Transport; Wed, 8 Sep 2021 13:33:16 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 640e8a91-f7b3-481c-7b43-08d972cd37f7
X-MS-TrafficTypeDiagnostic: MN2PR12MB4208:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB42083ABC6E59A70F0F65555783D49@MN2PR12MB4208.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Qlip7sdPjmWl6YphKu1zlD5PRkwnQAIbpWL2u0I7TRGV19hmCBHvSfMwArb9Z+FBzfJfXgHtur7bLlo0cjp0/1u7s4Vhw4OrBU4mbt7Hpsk8hftdskB7ZKo7bxGQZ/o7a+hoCp9x+VOXTDqeQVB2otitmB4ogabZNszBQicSJaOMISTE0AFrqDvnvdlBasVk8pNpUelsqerfrtx9mFB469F6af18lGizFafg/m7azVCcSESrGHkyw1udJ095kq0rHMl9xrrkvJNizEA5dg1P3w5ASPsMkKd13D5YYC4XNBXLAWcdM5Vdx+UqqbSRXZ7nynmNEnw9YMHHqIXxrsXoJOmHEZUvFw7Gnrx71XSRBANLV9J+MhVbYbdZPXuZNY+5oe8TkBUkSbC0htZpRSow/YeMSsSvUr7MTN3B/4vO3HGvLDBcHywoomc3G6qY+I8++jXIye8DwLHAEUaVQNwZPVja/XT4tM04ZYwdSI/YS/w9Sxu+qaDXwC9024LKpn08Qmhj56wOjznOV3TbhK2Ocb0+d6G6R+KFTUmfF8Kv+6/m2F3Rt0edlh8nsMaP8qBlDuf69/B88yq0pUuRkFP3eM4m+h5XDJosYrm58QGFri+HyY7dOhHdtOsu8NgMyil7brIGgJ+uOURblLl7DWTigE4JT/JQK4oS8X41THbZUUpwPZLLMlBdIPyIK9t5yTmvPEJ7bGSUmFAC3Az8CE95Ob0GPzGv2M9IpTD+gUu0W/LBNKonBkXMwG6XZBjmI19l1aLe1PdiL8+dMXCVSWDbzeqyxgS77W58lVPqQCj5fy2YqnzGyHK0dHUaJdvAQDA0
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB3775.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(8676002)(966005)(6486002)(83380400001)(8936002)(86362001)(4326008)(31696002)(508600001)(6666004)(45080400002)(5660300002)(2616005)(36756003)(38100700002)(2906002)(7416002)(110136005)(54906003)(31686004)(316002)(66476007)(66946007)(66556008)(186003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Qzd5YVpmMHFBWkdoWlpGbjBmK0NvK2g0S1dUTThPaGc2MEJQRWZJRlhla05D?=
 =?utf-8?B?RmdnTXhGdFR3QXlWelU1S2hVRHpTRHJOT3BCRCsrZnBqQjZyVTFkQ3JtV3RD?=
 =?utf-8?B?NG10ejJEY01wQ3JEdHdSQ3Y4SHQyVzBOMzhCZWN6cm1BcWJieTVHMWsrQ1kw?=
 =?utf-8?B?TTFPMThiQTFLN2tHRmM2bEdiWHlRSGdxdTNnenZheXczMGpjWldYNDlRUDRC?=
 =?utf-8?B?UllaZmZvU1VDVnJ2Nkoxd0NvbThoNklVWVVEWG5SNEtEZ1ZBRncyMWUvNnBo?=
 =?utf-8?B?RXlsYVM0bnl0SXVkdFBPaHNSR21XV0lhbDE1THcwdG9zTGZWRjFSQjB0azNx?=
 =?utf-8?B?NWhQMDdrMGhkc2VhMlljcFM4bkY2TnR5QzhRRldjT3BJTHZ3V2hQOFE0VElK?=
 =?utf-8?B?ZGhPaWpiSHk1Q2xvYitRQmJ1WnZVVWhxd2VMRi9BRkJUdGJYQmRVdTg1QjB2?=
 =?utf-8?B?K2hVb2J3bytUWTVJOHRPT00zYUgzZ1pEMXBJN3VDblZ3eGtlU01SN1pHL0or?=
 =?utf-8?B?SDdUdWFDaU5HT2tPYy92dHczamxGMlp2NTBzZlJvajJpTWhLRFFQbTcvSi9x?=
 =?utf-8?B?cjhWNk4yMWJmQkRGd2JIVlc5VWRVMlQzQlFiNGJGTzJEdkc0WlJJeXRzazl3?=
 =?utf-8?B?RG8yTFhhZ2t6MVJlYlNNNFl4V044TE5VWkVxMCtqNEgrSE54V1dSSkkvRCtC?=
 =?utf-8?B?NFQwV2JpaWd5NXN6aWcySmtrMWV2TW9iSjkyYlBBdHFJbnhVRnNZUUpDcGcx?=
 =?utf-8?B?Y2lKQ1lvSGNUbkxiQ3FDNGRZelZ5YUpUTXZRSHg5a1lsZGNXQWNxRll2VGl3?=
 =?utf-8?B?ODlhSVVMZE55ZFFieTZKQ3hWQmYyRk8rK3ZHQTBEU3hJNHQ0OE5GVTlqV2Vi?=
 =?utf-8?B?T0ttZDQwdjQrUzZYSXVGblNtQUIvNURQQ2VsM0Z4UkxRdnJ1eStmYWxMbTht?=
 =?utf-8?B?ekVqallKL0hobVp4cksyOU9NNVZBUlltV2xKRGxuWUhPUDN4ZjVRS0hCSFFQ?=
 =?utf-8?B?ckdiamZnVit3ZHFVS0pGekFJcm1zQmxGWDlKOStBUjRkNnkwK005M0orTnpT?=
 =?utf-8?B?eDBEQXg4UDhsZ0k0K1MwUE5jaHdnTUpLbHhVWjQyRlNpb3oyNWw4WjMwbkd1?=
 =?utf-8?B?NlJHRFVMcmw3dXJSTWFETGtXL1Zla01zZTRhRVVhZS9BWUo5YTVwVm5wNGpY?=
 =?utf-8?B?Y1JLbjBkMTFTZktzRDNMZkQ0aVFhc2p1Y3pFOGFyYjlMWXdIenBSNUNwb2ZW?=
 =?utf-8?B?YjBuQUZtSVB2TVFneS9pTXVjVnZTRWZsWUpMSkt4TndqaGRxcDQxdktwNXlL?=
 =?utf-8?B?QTZ0dkNCblFteWNOMWRhQ1gvckJncVhFeFNxSGcvSHJxekk0VlJiVHFkZzJD?=
 =?utf-8?B?NEltdElSZzhUODBISTQ5citPTzM3RFI1c1VIQzU5ZWlYMFYxendiQnlacXlR?=
 =?utf-8?B?b0tHcXZVTUp4RnlNM1VLVWdBd0xFeDNxSDdiMURONEN6NE5DcnJ0WW9VTTN4?=
 =?utf-8?B?ZmJtTzBFTnJqUU8wK0FieUJZcG1rdHpwQUFzbFhHekdiR2ZhOTBWMjhNZjF5?=
 =?utf-8?B?eG0zSG5IWTQ1WXo4RlEyY1RYODZNcEdMdExHVy9BZllFQmJITDdjM3VKejhp?=
 =?utf-8?B?U1VySVhVWkVXYmFKSmF4NVRDZnpQQmloZHNxZ3VNTHU3RmtjSElVd0MzQ2hC?=
 =?utf-8?B?b1NjaXNENStIMDdTMk1KQS9iMElYNGhGQUtjbGxxYjF6VzZjdlpPcW1oK1lU?=
 =?utf-8?B?TE5SaENZSEpLbHgxY2Z6YVJkTUc3dnFWWnBNZHFNNXYrUUpyNXE3ZGVEdm10?=
 =?utf-8?B?RkNTdFFXbEdLeTdWbEJJdWJ5bmlPZEt5T3ZtdnV6MC9FZEpRS3VHYmFGdnlM?=
 =?utf-8?Q?AvLkcQuqk64JR?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 640e8a91-f7b3-481c-7b43-08d972cd37f7
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3775.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2021 13:33:18.4242
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7yrA7eSQLVU62sE0Wp3ij8X7sFHb06/j9BQeaZaLKSJH1NJUlmkFUnbuNDIM4+Tp
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4208
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Am 08.09.21 um 13:18 schrieb Jason Gunthorpe:
> On Wed, Sep 08, 2021 at 05:41:39PM +0900, Shunsuke Mie wrote:
>> 2021年9月8日(水) 16:20 Christoph Hellwig <hch@infradead.org>:
>>> On Wed, Sep 08, 2021 at 04:01:14PM +0900, Shunsuke Mie wrote:
>>>> Thank you for your comment.
>>>>> On Wed, Sep 08, 2021 at 03:16:09PM +0900, Shunsuke Mie wrote:
>>>>>> To share memory space using dma-buf, a API of the dma-buf requires dma
>>>>>> device, but devices such as rxe do not have a dma device. For those case,
>>>>>> change to specify a device of struct ib instead of the dma device.
>>>>> So if dma-buf doesn't actually need a device to dma map why do we ever
>>>>> pass the dma_device here?  Something does not add up.
>>>> As described in the dma-buf api guide [1], the dma_device is used by dma-buf
>>>> exporter to know the device buffer constraints of importer.
>>>> [1] https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flwn.net%2FArticles%2F489703%2F&amp;data=04%7C01%7Cchristian.koenig%40amd.com%7C4d18470a94df4ed24c8108d972ba5591%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637666967356417448%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C2000&amp;sdata=ARwQyo%2BCjMohaNbyREofToHIj2bndL5L0HaU9cOrYq4%3D&amp;reserved=0
>>> Which means for rxe you'd also have to pass the one for the underlying
>>> net device.
>> I thought of that way too. In that case, the memory region is constrained by the
>> net device, but rxe driver copies data using CPU. To avoid the constraints, I
>> decided to use the ib device.
> Well, that is the whole problem.
>
> We can't mix the dmabuf stuff people are doing that doesn't fill in
> the CPU pages in the SGL with RXE - it is simply impossible as things
> currently are for RXE to acess this non-struct page memory.

Yeah, agree that doesn't make much sense.

When you want to access the data with the CPU then why do you want to 
use DMA-buf in the first place?

Please keep in mind that there is work ongoing to replace the sg table 
with an DMA address array and so make the underlying struct page 
inaccessible for importers.

Regards,
Christian.

>
> Jason

