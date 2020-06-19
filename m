Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C799201BEC
	for <lists+linux-rdma@lfdr.de>; Fri, 19 Jun 2020 22:04:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388822AbgFSUDi (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 19 Jun 2020 16:03:38 -0400
Received: from mail-eopbgr760079.outbound.protection.outlook.com ([40.107.76.79]:48196
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2389332AbgFSUDh (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 19 Jun 2020 16:03:37 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JG0wmHbsWmqhq8i//9RVirkPbeepXJw/3CezNwkc3pCHdGJ7ZKBPK3O97W9KVihxQjiJRQtYcjrBJCfab+qyclFUkAaPRNiZ15HvRNzPZutDMyXAyucV3EWPhgun0SrPGK1vGxyzi9TFL4VOG4LBrYfiLrLUhAa2bcP6CcvsfVlaHHi2a9TIVyYB6OdowF9OSy14WTP92aHN586Tpp964drrzB2HWKFsdSMNsgQSyAVAowS6IMIUHatKjoHHeZ37tKixdP3UBaaPDesJ5/+jHGhdgPXpj4IL9C8KJyM2YAwivZt4ne0i/crndyvD5eOZjKB/ViVfxx8FKZUSRetnRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CSLqUErcw365gbQeTkLCzN7f8n341o9UbrWcBRLrfjQ=;
 b=lTD6eyHr8gS5LN9kKxNYg6Yiqy+fDp/epVqzI3ahBkegI6xflqkXOcGL0jZs4Ms/CDWlfNgRczgk3WNiM8ll6Ypc74fUW9/quEOsxg5eYZs7k6v66MPStBakzKZd62EZ84hlw/zpF98Au/kTHADrOTnzHb5tHxwn9swPA+zZX1HDTT5StoAGQTg6c4zg3K392lKsNAY9WZ5cCoEHzt8X47XehQ6LfSAiYvYOIraKRirJ7o8EkoV4jOwYaybZFF2yadyJgtE8Dh/GA8pCsyVyjOsHBem43y4xuwPkdQZwi5Yo2JnuIxT0Tr0mqt30wD6ZtJm6rfotRdM037knM2GDig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CSLqUErcw365gbQeTkLCzN7f8n341o9UbrWcBRLrfjQ=;
 b=fBej0NlVcaEAY0Hfo+XSsuwFQUt1DVlDIHSK6RBnqCCKmX1N/CXLBz6qdxWX+57WLTom0XTrzUmNoA7V8iHwhI3aQaJkox78XepfCnMsIYXZX8wXNDaZaTFnk45ZkU6flqQOD3k+jX1RurtNWSc3pov4rKLqu2IO1Ffv0pw00/E=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=amd.com;
Received: from SN1PR12MB2414.namprd12.prod.outlook.com (2603:10b6:802:2e::31)
 by SA0PR12MB4446.namprd12.prod.outlook.com (2603:10b6:806:71::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3109.22; Fri, 19 Jun
 2020 20:03:34 +0000
Received: from SN1PR12MB2414.namprd12.prod.outlook.com
 ([fe80::18d:97b:661f:9314]) by SN1PR12MB2414.namprd12.prod.outlook.com
 ([fe80::18d:97b:661f:9314%7]) with mapi id 15.20.3109.021; Fri, 19 Jun 2020
 20:03:34 +0000
Subject: Re: [Linaro-mm-sig] [PATCH 04/18] dma-fence: prime lockdep
 annotations
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Jerome Glisse <jglisse@redhat.com>,
        linux-rdma <linux-rdma@vger.kernel.org>,
        =?UTF-8?Q?Thomas_Hellstr=c3=b6m_=28Intel=29?= 
        <thomas_os@shipmail.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
        "moderated list:DMA BUFFER SHARING FRAMEWORK" 
        <linaro-mm-sig@lists.linaro.org>,
        Thomas Hellstrom <thomas.hellstrom@intel.com>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        Daniel Vetter <daniel.vetter@intel.com>,
        Mika Kuoppala <mika.kuoppala@intel.com>,
        Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
        "open list:DMA BUFFER SHARING FRAMEWORK" 
        <linux-media@vger.kernel.org>
References: <20200618172338.GM6578@ziepe.ca>
 <CAKMK7uEbqTu4q-amkLXyd1i8KNtLaoO2ZFoGqYiG6D0m0FKpOg@mail.gmail.com>
 <20200619113934.GN6578@ziepe.ca>
 <CAKMK7uE-kWA==Cko5uenMrcnopEjq42HxoDTDywzBAbHqsN13g@mail.gmail.com>
 <20200619151551.GP6578@ziepe.ca>
 <CAKMK7uEvkshAM6KUYZu8_OCpF4+1Y_SM7cQ9nJWpagfke8s8LA@mail.gmail.com>
 <20200619172308.GQ6578@ziepe.ca> <20200619180935.GA10009@redhat.com>
 <20200619181849.GR6578@ziepe.ca>
 <56008d64-772d-5757-6136-f20591ef71d2@amd.com>
 <20200619195538.GT6578@ziepe.ca>
From:   Felix Kuehling <felix.kuehling@amd.com>
Message-ID: <789aa42e-0ddc-14f2-96be-07c00603efea@amd.com>
Date:   Fri, 19 Jun 2020 16:03:31 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
In-Reply-To: <20200619195538.GT6578@ziepe.ca>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-ClientProxiedBy: YTOPR0101CA0008.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:15::21) To SN1PR12MB2414.namprd12.prod.outlook.com
 (2603:10b6:802:2e::31)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.2.100] (142.116.63.128) by YTOPR0101CA0008.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:15::21) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3109.21 via Frontend Transport; Fri, 19 Jun 2020 20:03:33 +0000
X-Originating-IP: [142.116.63.128]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 1cfc64bd-c014-4a4f-d855-08d8148bd8bc
X-MS-TrafficTypeDiagnostic: SA0PR12MB4446:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SA0PR12MB4446767A85FE9FC4C73E0E2292980@SA0PR12MB4446.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-Forefront-PRVS: 0439571D1D
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6bEP4Afs8TryzdJCPZ/qf9DxGNSXnRcJT0O4u+UQHr6G9Mkm9kO4Wm5WA9Hfi47yz+TOEVeWfw9V/8CVq3Pg8C9G43wUGBzaTIXzu0F10eKH+2B/xwB1P8bZSFlGRExJeZ+O0ZtCHiedC7pLF8VjSj17kVj90EbsKfJ+9cOwyZti4jjNMKiTIckN1HrOWgJxaA3Ba0OuuaKsgwEk5E8xl6/12S/ZUcoCwB+t2ZYHZQvzq8lPEyTrzl1jNMe2y/LJ5D6Pycyl3E+Xn+F6saYtONFiXNmBDSZ9bbexOlCBmF6NWMbMRy0zdfk4J5I5bOk2+PlHrumIuVWTDz1XuOpRP9y249seiupSdBXfWl3RC3bgaHoIAqrw57xRGpR4ulke
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN1PR12MB2414.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(376002)(39860400002)(396003)(136003)(366004)(346002)(66946007)(66476007)(66556008)(52116002)(26005)(186003)(16526019)(83380400001)(316002)(16576012)(54906003)(44832011)(956004)(2616005)(86362001)(31696002)(31686004)(478600001)(8936002)(7416002)(36756003)(6486002)(8676002)(2906002)(5660300002)(4326008)(6916009)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: Zo3Tf0t1VWiIXIkWjW7LU93PiNZvBn4o11OFBIf8WZrvL0ap8ev6rgTzu5wNys6FJ9NzVyMpq9kShPiZI9GMltnchmtsvteP6GkLziwTejEpNFvTF4rAvdGvslSXIoxWP35/iCj1bViqZxBOeRkcLYaL8hSD8guBCEB1KKiJEKfFKH+3LqG7jkI92g0xaMyNviryYnmGjKV5cA9wBaUv4CJgE6wa8J0cg5Pmw5ulbartrue4hdvYcsEBOznW+3HrX3jrw/Yp2bU+KbO8hXy6skywADcIThQoQwk/bvGn0wnmfwNm9Kd2aTZ+tYtP3pBN26+2i2+bs4oX/WR+ApB3RKOqbTy13dfl7cYiisz6DjsAu7WS7f4cjSC5pz0eGJDFR5ScIyo/vcUK2/t9ojVKp2q8xnM1pBIJFmnJH5v+Yz3iqqqgvk5V4XnK7O2c/f7PZUXdrCEUnZ1onwzDVqJKuqgqM3ZyyjlJY3CTbv4P6MoFwSn+KrEbyHHgEoBGXCPQ
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1cfc64bd-c014-4a4f-d855-08d8148bd8bc
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jun 2020 20:03:34.4488
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SbWO5zAONhMZfIimuvSuyttgMifJlQQgcid2omNW9KsnrGQTxsQRr8wsNKEF67CSGfL7sVwM0z1EvF9Dr1wxcg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4446
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


Am 2020-06-19 um 3:55 p.m. schrieb Jason Gunthorpe:
> On Fri, Jun 19, 2020 at 03:48:49PM -0400, Felix Kuehling wrote:
>> Am 2020-06-19 um 2:18 p.m. schrieb Jason Gunthorpe:
>>> On Fri, Jun 19, 2020 at 02:09:35PM -0400, Jerome Glisse wrote:
>>>> On Fri, Jun 19, 2020 at 02:23:08PM -0300, Jason Gunthorpe wrote:
>>>>> On Fri, Jun 19, 2020 at 06:19:41PM +0200, Daniel Vetter wrote:
>>>>>
>>>>>> The madness is only that device B's mmu notifier might need to wait
>>>>>> for fence_B so that the dma operation finishes. Which in turn has to
>>>>>> wait for device A to finish first.
>>>>> So, it sound, fundamentally you've got this graph of operations across
>>>>> an unknown set of drivers and the kernel cannot insert itself in
>>>>> dma_fence hand offs to re-validate any of the buffers involved?
>>>>> Buffers which by definition cannot be touched by the hardware yet.
>>>>>
>>>>> That really is a pretty horrible place to end up..
>>>>>
>>>>> Pinning really is right answer for this kind of work flow. I think
>>>>> converting pinning to notifers should not be done unless notifier
>>>>> invalidation is relatively bounded. 
>>>>>
>>>>> I know people like notifiers because they give a bit nicer performance
>>>>> in some happy cases, but this cripples all the bad cases..
>>>>>
>>>>> If pinning doesn't work for some reason maybe we should address that?
>>>> Note that the dma fence is only true for user ptr buffer which predate
>>>> any HMM work and thus were using mmu notifier already. You need the
>>>> mmu notifier there because of fork and other corner cases.
>>> I wonder if we should try to fix the fork case more directly - RDMA
>>> has this same problem and added MADV_DONTFORK a long time ago as a
>>> hacky way to deal with it.
>>>
>>> Some crazy page pin that resolved COW in a way that always kept the
>>> physical memory with the mm that initiated the pin?
>>>
>>> (isn't this broken for O_DIRECT as well anyhow?)
>>>
>>> How does mmu_notifiers help the fork case anyhow? Block fork from
>>> progressing?
>> How much the mmu_notifier blocks fork progress depends, on quickly we
>> can preempt GPU jobs accessing affected memory. If we don't have
>> fine-grained preemption capability (graphics), the best we can do is
>> wait for the GPU jobs to complete. We can also delay submission of new
>> GPU jobs to the same memory until the MMU notifier is done. Future jobs
>> would use the new page addresses.
>>
>> With fine-grained preemption (ROCm compute), we can preempt GPU work on
>> the affected adders space to minimize the delay seen by fork.
>>
>> With recoverable device page faults, we can invalidate GPU page table
>> entries, so device access to the affected pages stops immediately.
>>
>> In all cases, the end result is, that the device page table gets updated
>> with the address of the copied pages before the GPU accesses the COW
>> memory again.Without the MMU notifier, we'd end up with the GPU
>> corrupting memory of the other process.
> The model here in fork has been wrong for a long time, and I do wonder
> how O_DIRECT manages to not be broken too.. I guess the time windows
> there are too small to get unlucky.
>
> If you have a write pin on a page then it should not be COW'd into the
> fork'd process but copied with the originating page remaining with the
> original mm. 
>
> I wonder if there is some easy way to achive that - if that is the
> main reason to use notifiers then it would be a better solution.

Other than the application changing its own virtual address mappings
(mprotect, munmap, etc.), triggering MMU notifiers, we also get MMU
notifiers from THP worker threads, and NUMA balancing.

When we start doing migration to DEVICE_PRIVATE memory with HMM, we also
get MMU notifiers during those driver-initiated migrations.

Regards,
  Felix


>
> Jason
