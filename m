Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 64CA637FE22
	for <lists+linux-rdma@lfdr.de>; Thu, 13 May 2021 21:31:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229518AbhEMTdG (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 13 May 2021 15:33:06 -0400
Received: from mail-mw2nam12on2120.outbound.protection.outlook.com ([40.107.244.120]:29921
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229460AbhEMTdF (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 13 May 2021 15:33:05 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k5TTLlFJlxSxXjc5dFS/Pfv1T2gC+zrOU+VU6DMofEN6ne7izlYXySQBuyMWgw4lGIuR/0tNKekyXMNcj+EpE2X6gozXUciNAfEIbdNhTk9tZ5Kf6rRl52//Z45lp3c2lCQqq5qH6vhr5kk0cyvD2/QScqoc0hZY6mkvES6Z8oS6LQPmiYmxGxGfrCcR7DzV9FNIlYpFjvkHJo6Xw5vL/hMPy6b+CnvFR9LYdI24fyqhHLijOJ77Dixod4wDIaBrS1P2B8/HAgsEXhkmLer1v35imBjMXupz/kQ35YWJ8M/Zzi493tmnySyUtRNJ3H0IgqIyxYPsSCurUD3bVrgTOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FrxidwZrMtQZECVTa3mVTFG58Pkj9WVqx6R8NsXNDRc=;
 b=M70cUe+vSBHwI8AjFI1vF6muZTxGxbeWqfYjL/CKv4NpWnjxDjsihaL7mppQNDMaX1dYDDLVqCQHh0Z8HC7Xxc3or04G3XH8sIVpEAcIMD7w9+EPhnrhLGb/sIH/Xwm62yYm08M1yUDNuB713dKI+S1+DBDVl4BUeyDJoaVwhyxDLqMwOCOSzkqOqGOpkNSWZr/cK5Lvmi+8NcX1furLL98xxIsYzpuObiAUv0mvr1Yb6fXBrAxFF9SlexeAiJo8dtFmqJ9Wk4lvnKFNps0AUkMLP+Z8RBq17cWmxXjK0du5jtXA3+IHcxFpslUtVcetiY3+zjOnuF5N6NsCpLLZOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cornelisnetworks.com; dmarc=pass action=none
 header.from=cornelisnetworks.com; dkim=pass header.d=cornelisnetworks.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cornelisnetworks.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FrxidwZrMtQZECVTa3mVTFG58Pkj9WVqx6R8NsXNDRc=;
 b=Kjp7HD5AopWETu8M9Q5DfQM2ZxnGNAaAycti/c3oQf7UlS5hZhX4r/+VIazIuzyWvBicsyqfFuu3hbh5aqHKKvzt+Xj927wOs14VP71PbhAgo5VHk3RnnrLWhWQoVd0PMHWcEOWzhMDB0t/byXnfgUibNKSubp547xkrc42oujGzV60buNnUGG2JJLywOjNKNAAJ2Z1Kq2lidhkIGLcghMpep9bpA2Mj7OslMeF4aHRJ/NsVpFKQ0PJzvGw89zHGmCs3Ef5jUvdfMCcvcEhkvjTtnP9Qs875DPaRvSN11cRKL1VC9Czu63eolH4pKrS4wiAIKrgd1Xrt0eWPaur9nw==
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=cornelisnetworks.com;
Received: from PH0PR01MB6439.prod.exchangelabs.com (2603:10b6:510:d::22) by
 PH0PR01MB6214.prod.exchangelabs.com (2603:10b6:510:14::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4108.27; Thu, 13 May 2021 19:31:51 +0000
Received: from PH0PR01MB6439.prod.exchangelabs.com
 ([fe80::b43d:7749:62fa:2488]) by PH0PR01MB6439.prod.exchangelabs.com
 ([fe80::b43d:7749:62fa:2488%7]) with mapi id 15.20.4129.025; Thu, 13 May 2021
 19:31:51 +0000
Subject: Re: [PATCH rdma-next] RDMA/rdmavt: Decouple QP and SGE lists
 allocations
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Leon Romanovsky <leon@kernel.org>,
        "Marciniszyn, Mike" <mike.marciniszyn@cornelisnetworks.com>,
        Doug Ledford <dledford@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
References: <c34a864803f9bbd33d3f856a6ba2dd595ab708a7.1620729033.git.leonro@nvidia.com>
 <f72bb31b-ea93-f3c9-607f-a696eac27344@cornelisnetworks.com>
 <YJp589JwbqGvljew@unreal>
 <BYAPR01MB3816C9521A96A8BA773CF613F2529@BYAPR01MB3816.prod.exchangelabs.com>
 <YJvPDbV0VpFShidZ@unreal>
 <7e7c411b-572b-6080-e991-deb324e3d0e2@cornelisnetworks.com>
 <20210513191551.GT1002214@nvidia.com>
From:   Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
Message-ID: <4237ab8a-a851-ecdf-ec41-4e798a2da156@cornelisnetworks.com>
Date:   Thu, 13 May 2021 15:31:48 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.10.1
In-Reply-To: <20210513191551.GT1002214@nvidia.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [24.154.216.5]
X-ClientProxiedBy: BL1PR13CA0352.namprd13.prod.outlook.com
 (2603:10b6:208:2c6::27) To PH0PR01MB6439.prod.exchangelabs.com
 (2603:10b6:510:d::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from Denniss-MacBook-Pro.local (24.154.216.5) by BL1PR13CA0352.namprd13.prod.outlook.com (2603:10b6:208:2c6::27) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4150.11 via Frontend Transport; Thu, 13 May 2021 19:31:50 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 70ed98f4-54da-46ab-dd3c-08d91645c1fe
X-MS-TrafficTypeDiagnostic: PH0PR01MB6214:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <PH0PR01MB621489A37EB7DB6DC520BE76F4519@PH0PR01MB6214.prod.exchangelabs.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Dmm5rZ3AR+2VJXvzyUQh0BM++sngQg2Gqc+h5JbSDfeuwxPHiwXeIxTmPTrFR2kcb5wwuWPbBnPZbDuzYoDvc7c7PvESC9vBfEVWyk36d7OYLLzp9mZneritNl8evsxbYfnDAFXPm0Ucaxzddxkw+BwI8Bb2ED77Zacqc8fLmLpuKI0PoG3XXN44TQ+1Etl2/r9nwc0RqSPAORxM0ovbqLdrgN5Ohn6hbDrJKFjCp8EkMmNFgkrmsZxSlQ+rSn7Xd4imcNVahMPI82zDYJzZqOIdGW3gCh8WH+DX6VqJwJT4WW94VWDthbwE0rcnTm1YgJup+/PYvP2f+3Ab/Bgvb3LSqcwKD3nnCgk/RlV2Tfo2GGZV4zwcto6Jz2fby0M5Mm6Gt4NQlGvyoTL8hUwEVwhT3REiv3ozxoQd2cKkw9fYg+gAnimm80JmJGyfJ2ysyoDrEJyeba8zU8M8s8UbiY6ekTONokw3eZSe05kaPlcsNfD9/puRu7xj8dZ1zl4v6DGI6oUwA4P357WXubsI2LEyK5WGFT9yI0nZCOdOVOlWsVgo2VX6/z+gSqE+qcCHcsZgE8z7xZj9oxK2ijeJkAP+jiLRUSURmfuK6s1dDk2CGixt7C8h2aDl4fl5uV9KiMNieymgCSLRY5EX9P1oTgY6hwQ2Ke9xNu7SEClCrL2vM3Nume1LoNEnggMLqJlOrpSgIDjoNx6JxAKAM9OFptXWkgM6y44GgPv1II9dF0k=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR01MB6439.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(4636009)(39830400003)(136003)(346002)(396003)(366004)(376002)(2906002)(956004)(2616005)(31696002)(8676002)(86362001)(54906003)(36756003)(38100700002)(38350700002)(66946007)(31686004)(316002)(6916009)(53546011)(26005)(6506007)(5660300002)(4326008)(186003)(44832011)(6512007)(16526019)(478600001)(66476007)(66556008)(52116002)(8936002)(6486002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?UTFXNys1aUxmM3MyL0lxN2pENmhmQklVT3VkNUIwMzJxcXpjVzdsUERrUk5G?=
 =?utf-8?B?K3ZKaXBxWGRkbFJBdE9RaDFqYUxHM1hmWFhZYlR4aytSNXpoQnladU9qRUZC?=
 =?utf-8?B?TlJleWFsUy9RV3MzaWwwTTVSaHlJMStTdGlObUd0azh4cUp5cGtFRG5BS09l?=
 =?utf-8?B?c3QrdWN0dWR2SUF1cGtROHllaTh4Q1ZCRDMxZi9NSUQxdlUweHBWWThYc3gv?=
 =?utf-8?B?OGhoLzVaQUE2T0RrY0VleHZFTWZzRjRQa1gzZVpZUHN1SW9Cd3ZpM2psU2J3?=
 =?utf-8?B?Sy9SdUFKUGhQYkVlRG9oZFplMkppOUYrVXNOKzZMeHNTVjNkU2F6VU5oVnho?=
 =?utf-8?B?dmN3T203OGdsTDRDNkc1bTNpN2dJYVJnRlhLd2hLbUk1K3I1dnlLbm9MamZT?=
 =?utf-8?B?amMyYVY5aWU4MDN3anluTTBMaytMYU9GUEtxZGgyNE9YRExoQ3hVN0NtcjFn?=
 =?utf-8?B?WllLSE43TkpKMEp0Ly9FcGdOekpvVUJQcDFyb1ZsVU5ZVXJ3WDdqbjF2cXJU?=
 =?utf-8?B?MEtkY0JHMzIxT25oK2JnR2FFWHB5ZTRGMThNUkcvR0czcGV3OC9yWDRFZ1Z3?=
 =?utf-8?B?dlhQWjBldUtjck5QNEwwbDNwYTd3RUI4Yk5QTUxiaFAwS1lycVF0TC8zRlZ1?=
 =?utf-8?B?Zm5WbVN6dDh1Q01YUHk3Z3kxQ3hEVlVNdi95cmo1YTlPNW9qdnU4R0w5SkZn?=
 =?utf-8?B?MFh4VU80S3plK1R4dFFSdVR3ZGp6MlllNmJMbDZwT0wvdDNMYXZCRy9lSzNR?=
 =?utf-8?B?K2JJb21HV0NvS0lnelMvN1hsdkJBUThCNndjUlpPWkxvVDNpUk5BTHFQa1Z3?=
 =?utf-8?B?Z21NTGc1bFNCNWxqc1hkYmFBOFRINlExSmFNa0lhOHF0YjI2RnBZdWh6cEJH?=
 =?utf-8?B?eS9XYWZjQjZoOFJjY2x5Q21HVXY2WUg1bzBiWUJzOE1CM1Yzakd0NkplRHg5?=
 =?utf-8?B?UVVhUmlUZExCSC9qZ2lGYUNJaFpPSTJiRjh1UldKVkVvTlVFUUgvZDl4cU53?=
 =?utf-8?B?ZXRNT09PYVFXQmx3NzdyRzFHZ1Vrbmw4SDArRmliMjBMNjd3UitEQkE5UlNx?=
 =?utf-8?B?NUh4ODJIYmdZUTgvTFV0bDBHc1RzRktiMDVyTVdIYWJGNHlFakJ2RjZsQlFq?=
 =?utf-8?B?c01neitxVUw1amUxY2sxYlFZRkF0YlJQbCt3MWlQb1VNT0p0b2g1ek56Zmlo?=
 =?utf-8?B?SFRTSGw2QWluaE9JK01GUm8wbG95LzkvWnk0NWl4TlNEdmhxM3hibjBSTWI4?=
 =?utf-8?B?enIrM1FKUmJZN09KVmFwTGxCQ0pQZVhibDRjREZObDRrWGFmb0l0L2RFSFpa?=
 =?utf-8?B?TytiN1pWNWNJWGZIYk5JTE1oOGNkVmdoMVpuWDRYV1BNbWU4NEZvZGpwbDJU?=
 =?utf-8?B?dzFmbVhBVWVnaVJ1RkxJSHhXU1NCOFBVZ2lpZHV2ZEtjRW1lRCttK2tiSmpk?=
 =?utf-8?B?QkdhL1ZneTlhbFc4dy9yMEJjM3pBZ3R5aXJtcTRBczlMQm1kRThwajFZOXB0?=
 =?utf-8?B?MFkwVmJFM2x3ZGxmV2szK1VWWWNxTXZaV3dWMTZtZFkxM3NhekxYOW1XNU5E?=
 =?utf-8?B?WEZBcndNcXIweDhKYm01SHRaOUJXcGI4Skc2MWZyS0ZTQkFVcmUzN2QyeVdW?=
 =?utf-8?B?RVdjRXBpYS9idEgydHVmU0FCNzN3aldEd1VQMFpRQTNVTklKUWN4cWJFZTlP?=
 =?utf-8?B?aitRd3R6Rm9rWFZyRlFJN2JQQkJUNTlxVk4yMXdhclhPVUROd2gyaVhHREl3?=
 =?utf-8?Q?s4vnJcRdKpshw1+USD/tXEI2piYNbQ0XqR3JqZW?=
X-OriginatorOrg: cornelisnetworks.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 70ed98f4-54da-46ab-dd3c-08d91645c1fe
X-MS-Exchange-CrossTenant-AuthSource: PH0PR01MB6439.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2021 19:31:51.4090
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4dbdb7da-74ee-4b45-8747-ef5ce5ebe68a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CfotM599YQKGRQ9c0wI3ZOKMzy8bY/QhpYPv1iSz4urzOExGZpfBzdydKtHn187mEijwqtCye0sn8doIdEpjwJl7hIcNeaiZRS0BtA1qa4vwq/vV2qShxXqYsCj5WxXV
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR01MB6214
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 5/13/21 3:15 PM, Jason Gunthorpe wrote:
> On Thu, May 13, 2021 at 03:03:43PM -0400, Dennis Dalessandro wrote:
>> On 5/12/21 8:50 AM, Leon Romanovsky wrote:
>>> On Wed, May 12, 2021 at 12:25:15PM +0000, Marciniszyn, Mike wrote:
>>>>>> Thanks Leon, we'll get this put through our testing.
>>>>>
>>>>> Thanks a lot.
>>>>>
>>>>>>
>>>>
>>>> The patch as is passed all our functional testing.
>>>
>>> Thanks Mike,
>>>
>>> Can I ask you to perform a performance comparison between this patch and
>>> the following?
>>
>> We have years of performance data with the code the way it is. Please
>> maintain the original functionality of the code when moving things into the
>> core unless there is a compelling reason to change. That is not the case
>> here.
> 
> Well, making the core do node allocations for metadata on every driver
> is a pretty big thing to ask for with no data.

Can't you just make the call into the core take a flag for this? You are 
  looking to make a change to key behavior without any clear reason that 
I can see for why it needs to be that way. If there is a good reason, 
please explain so we can understand.

I would think the person authoring the patch should be responsible to 
prove their patch doesn't cause a regression. We are telling you it did 
make a difference when the code was first written, probably like 6 years 
ago. At the very least no one had an issue with this code 4 years ago 
the last time it was touched (by Leon btw). Nor issues with the other 
uses of the call.

We can have our performance experts look at it but it's going to take 
some time as it's nothing that has been on anyone's radar.

-Denny
