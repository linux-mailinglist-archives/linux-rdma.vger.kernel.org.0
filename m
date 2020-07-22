Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F0FB5229A32
	for <lists+linux-rdma@lfdr.de>; Wed, 22 Jul 2020 16:35:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729126AbgGVOf5 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 22 Jul 2020 10:35:57 -0400
Received: from mail-bn8nam11on2082.outbound.protection.outlook.com ([40.107.236.82]:24417
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728837AbgGVOf5 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 22 Jul 2020 10:35:57 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Pg1vV1CqXP2yNw9ydQFeKkkM0sDtRaahPom6OdMuoSwcpFir/cL+etVfEkFztIwRY+pdd3q1s6OZygk2movIWm9zI6/r+ah4bkp72q09W67WbaLEhNNfY6vPqqxCgfhi+Fi7Nl8F3a6DjiVVDlgLgn6gMym78NlEXer0SeBWn1/CU2iRrG8wHHw3QP+vXCRt6iLLGK1Rh7D/GvlCsOaE4Xp8VJQELeQrdOJ8tnp+3IMwdtwWycIJPSrFAtkDIFsn62d73Qjv1xE4vjejNAIJ7dg3uZXSTx/6o7+mq/q4cwmPqtZOySn4TXRgY/Su+zThfbx3XT79O8lRdT5VP4U4oQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z5ki77Mr37d5Njfng6N04EA0iYbJN4PLETxakjBX3sE=;
 b=MZh4Oku+wd4TQJrgBIDifrjqRUrV0XyaErVapEX5Ci3nzqVUjV4PssLy1yeAc3SZDL/1ZSVxefn6ewZRSEkZzP3a0D2ztrZvvuTacPT1ZHLL25aD8IdkA9lCB93ocQQ4siToF8JlPJGcaF47GGCk4XdkKMW2WWdkp1CRFwWPeg6C461PyebIBcUyjKOwZfAABPHwDm2K+JQhtv51B71jWWsEAW2Cd+HXjEUwVUjWkLVzuFNj+DBuL3pMmBUjCrsBeKI5WDRw71CkWIaIivY5toCCTz4c/EzMQ32vU7GeJbyk4PQ5XPMzPjwNjLRvgrg6TrmK12OzKrpmTjk3BrFeqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z5ki77Mr37d5Njfng6N04EA0iYbJN4PLETxakjBX3sE=;
 b=otkvzPDg2zASvrIK3yni+Fdu937SHlPBxskdv837bSEO4hr+G3hMKvWE+HDEEIZijtwIMRPBTtSJSxmpq6Uzu4uvgPkMEg82tIz6Wre1mUO2IujcPyg5OZY80StV82Kcc6jTT6CYmVaYIK5OOUl7asPW2yahcVVs81vkztJBj7E=
Authentication-Results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB3775.namprd12.prod.outlook.com (2603:10b6:208:159::19)
 by MN2PR12MB3904.namprd12.prod.outlook.com (2603:10b6:208:165::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.22; Wed, 22 Jul
 2020 14:35:52 +0000
Received: from MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::a16e:8812:b4c0:918d]) by MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::a16e:8812:b4c0:918d%6]) with mapi id 15.20.3216.021; Wed, 22 Jul 2020
 14:35:52 +0000
Subject: Re: [Linaro-mm-sig] [PATCH 1/2] dma-buf.rst: Document why indefinite
 fences are a bad idea
To:     =?UTF-8?Q?Thomas_Hellstr=c3=b6m_=28Intel=29?= 
        <thomas_os@shipmail.org>, Daniel Vetter <daniel.vetter@ffwll.ch>
Cc:     Felix Kuehling <Felix.Kuehling@amd.com>,
        Daniel Stone <daniels@collabora.com>,
        linux-rdma <linux-rdma@vger.kernel.org>,
        Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        "moderated list:DMA BUFFER SHARING FRAMEWORK" 
        <linaro-mm-sig@lists.linaro.org>,
        Steve Pronovost <spronovo@microsoft.com>,
        amd-gfx mailing list <amd-gfx@lists.freedesktop.org>,
        Jason Ekstrand <jason@jlekstrand.net>,
        Jesse Natalie <jenatali@microsoft.com>,
        Daniel Vetter <daniel.vetter@intel.com>,
        Thomas Hellstrom <thomas.hellstrom@intel.com>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        Dave Airlie <airlied@gmail.com>,
        Mika Kuoppala <mika.kuoppala@intel.com>
References: <20200707201229.472834-4-daniel.vetter@ffwll.ch>
 <20200721074157.GB3278063@phenom.ffwll.local>
 <3603bb71-318b-eb53-0532-9daab62dce86@amd.com>
 <57a5eb9d-b74f-8ce4-7199-94e911d9b68b@shipmail.org>
 <CAPM=9twUWeenf-26GEvkuKo3wHgS3BCyrva=sNaWo6+=A5qdoQ@mail.gmail.com>
 <805c49b7-f0b3-45dc-5fe3-b352f0971527@shipmail.org>
 <CAKMK7uHhhxBC2MvnNnU9FjxJaWkEcP3m5m7AN3yzfw=wxFsckA@mail.gmail.com>
 <92393d26-d863-aac6-6d27-53cad6854e13@shipmail.org>
 <CAKMK7uF8jpyuCF8uUbEeJUedErxqRGa8JY+RuURg7H1XXWXzkw@mail.gmail.com>
 <8fd999f2-cbf6-813c-6ad4-131948fb5cc5@shipmail.org>
 <CAKMK7uH0rcyepP2hDpNB-yuvNyjee1tPmxWUyefS5j7i-N6Pfw@mail.gmail.com>
 <df5414f5-ac5c-d212-500c-b05c7c78ce84@shipmail.org>
 <CAKMK7uF27SifuvMatuP2kJPTf+LVmVbG098cE2cqorYYo7UHkw@mail.gmail.com>
 <697d1b5e-5d1c-1655-23f8-7a3f652606f3@shipmail.org>
 <CAKMK7uGSkgdJyyvGe8SF_vWfgyaCWn5p0GvZZdLvkxmrS6tYbQ@mail.gmail.com>
 <c742c557-f48f-1591-1d1d-a5181b408a67@gmail.com>
 <a046ea93-b303-17d4-add4-efd0a709cfd2@shipmail.org>
From:   =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <e3112430-9533-ef75-cbd8-31814893210c@amd.com>
Date:   Wed, 22 Jul 2020 16:35:44 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
In-Reply-To: <a046ea93-b303-17d4-add4-efd0a709cfd2@shipmail.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-ClientProxiedBy: AM4PR0501CA0066.eurprd05.prod.outlook.com
 (2603:10a6:200:68::34) To MN2PR12MB3775.namprd12.prod.outlook.com
 (2603:10b6:208:159::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7] (2a02:908:1252:fb60:be8a:bd56:1f94:86e7) by AM4PR0501CA0066.eurprd05.prod.outlook.com (2603:10a6:200:68::34) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.20 via Frontend Transport; Wed, 22 Jul 2020 14:35:49 +0000
X-Originating-IP: [2a02:908:1252:fb60:be8a:bd56:1f94:86e7]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: a062cc6d-8ed7-403c-ffa6-08d82e4c887a
X-MS-TrafficTypeDiagnostic: MN2PR12MB3904:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB39040017DDFC959A6241494183790@MN2PR12MB3904.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ++X2WpuwNZ2gd0fzED4LamcA8kL59xXw0xKyQVV7urgVc0o7VKvHK12OpyXNvCzNjR35AJwl7Ws3utT5+TaDmzmHeNgdTFQzTKMeeutmTHnAJZhb0qtkeV/aKphnYY/SjOv4h0c6aydGt0s+lzu4lDysNop5MGWbu6FBUMEYk4udo0ReErYlnoZUqoN3P4jmVMfwdws2LK/WU/ChX9wV5X8uvbsnAZXyS9KwkR3eB05i0/L/+1EBzihCYOe9KKcKZNrKimBOFbYxCGw5F0fTU87euo2J9cZeSTy7psXsj7x1mEcN+B269XW2MByEhbh72B/qsVvZ+lx8KhnfKOd2EUZ10eLa/ijZdJNfsc3ekVbHUHChDPlEVa9KcnZz/LoWakKeOkSb89WvSolNraPytoKfRw0J/Gkse8FkmAvw9R+bOOHzlRevX5N3Hrfqcf9dxNYCbzokqzNCYb/Z9shwxg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB3775.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(376002)(136003)(366004)(346002)(396003)(39860400002)(66556008)(66946007)(66476007)(52116002)(31686004)(8936002)(110136005)(8676002)(6486002)(2906002)(6666004)(186003)(54906003)(86362001)(31696002)(16526019)(316002)(53546011)(478600001)(45080400002)(5660300002)(7416002)(4326008)(36756003)(66574015)(83080400001)(2616005)(83380400001)(966005)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: tW/EPpdNbYGU2v1302xgJRqwhlLJ9oDWezWais9esNAEqrfmOwXwyJ1WvlBRmulm9VR7TzozHNq9ERRuo88XPLz8OcRVgFaYGff6ULVfXDGhcPUj0rjrhdmHrA7XUnTWEwkvpBUigGWzm9do7+bL+4EizzKHUdLMIQYuDBaphSpYxSgg8xqCGpVh6un11pLSu/g5bpEQUb+UgXBdzSj/dTYrO1V/D7fyBPpcb5OnjqAf5fnEQaKgjE/3WG2qL1OSDU4j9shFSaAxwxpghrk5FMdEbZtMhfE2/lB0DG3X40j6qFoTOAzTTSCQqV5cacLAAC3F33BS+x8VkZ2ujBmQOLob35N1+UvOULKg3CrEMiRDQ0glUY+AMP/E3467AHWrjN/HHKRbfH5sfqahK61YbwQSPSsaHgKVEW911PCKGclrxKOmczm6qi7nSiOgsbcstxGLD1FnDE7ZuvwBrtwc7kCq0kpAlFHDelSE0k+vMDkGmi7QFrKvqwcss4VlQWe5a6X83XAucGUDOciUrVZBhSJd/Qw6/9GwPs/O1wA/WM0T4BpjvKyKz2IbwMgnVaX6
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a062cc6d-8ed7-403c-ffa6-08d82e4c887a
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3775.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2020 14:35:52.3764
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: h3BYahg24isfh8V7XFHl1HgHr2ifES9hi2UGvcvxwWc7wBVfnHYe0E3xu+fSznLy
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3904
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Am 22.07.20 um 16:30 schrieb Thomas Hellström (Intel):
>
> On 2020-07-22 16:23, Christian König wrote:
>> Am 22.07.20 um 16:07 schrieb Daniel Vetter:
>>> On Wed, Jul 22, 2020 at 3:12 PM Thomas Hellström (Intel)
>>> <thomas_os@shipmail.org> wrote:
>>>> On 2020-07-22 14:41, Daniel Vetter wrote:
>>>>> I'm pretty sure there's more bugs, I just haven't heard from them 
>>>>> yet.
>>>>> Also due to the opt-in nature of dma-fence we can limit the scope of
>>>>> what we fix fairly naturally, just don't put them where no one cares
>>>>> :-) Of course that also hides general locking issues in dma_fence
>>>>> signalling code, but well *shrug*.
>>>> Hmm, yes. Another potential big problem would be drivers that want to
>>>> use gpu page faults in the dma-fence critical sections with the
>>>> batch-based programming model.
>>> Yeah that's a massive can of worms. But luckily there's no such driver
>>> merged in upstream, so hopefully we can think about all the
>>> constraints and how to best annotate&enforce this before we land any
>>> code and have big regrets.
>>
>> Do you want a bad news? I once made a prototype for that when Vega10 
>> came out.
>>
>> But we abandoned this approach for the the batch based approach 
>> because of the horrible performance.
>
> In context of the previous discussion I'd consider the fact that it's 
> not performant in the batch-based model good news :)

Well the Vega10 had such a horrible page fault performance because it 
was the first generation which enabled it.

Later hardware versions are much better, but we just didn't push for 
this feature on them any more.

But yeah, now you mentioned it we did discuss this locking problem on 
tons of team calls as well.

Our solution at that time was to just not allow waiting if we do any 
allocation in the page fault handler. But this is of course not 
practical for a production environment.

Christian.

>
> Thomas
>
>
>>
>> KFD is going to see that, but this is only with user queues and no 
>> dma_fence involved whatsoever.
>>
>> Christian.
>>
>>> -Daniel
>>>
>>>
>>>
>>> -- 
>>> Daniel Vetter
>>> Software Engineer, Intel Corporation
>>> https://nam11.safelinks.protection.outlook.com/?url=http%3A%2F%2Fblog.ffwll.ch%2F&amp;data=02%7C01%7Cchristian.koenig%40amd.com%7C65836d463c6a43425a0b08d82e4bc09e%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637310250203344946&amp;sdata=F8LZEnsMOJLeC3Sr%2BPn2HjGHlttdkVUiOzW7mYeijys%3D&amp;reserved=0 
>>>
>>> _______________________________________________
>>> amd-gfx mailing list
>>> amd-gfx@lists.freedesktop.org
>>> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=02%7C01%7Cchristian.koenig%40amd.com%7C65836d463c6a43425a0b08d82e4bc09e%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637310250203344946&amp;sdata=V3FsfahK6344%2FXujtLA%2BazWV0XjKWDXFWObRWc1JUKs%3D&amp;reserved=0 
>>>

