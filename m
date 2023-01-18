Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8878C671E0D
	for <lists+linux-rdma@lfdr.de>; Wed, 18 Jan 2023 14:36:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230387AbjARNgY (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 18 Jan 2023 08:36:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229930AbjARNfw (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 18 Jan 2023 08:35:52 -0500
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2098.outbound.protection.outlook.com [40.107.101.98])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9ADD34DCE5
        for <linux-rdma@vger.kernel.org>; Wed, 18 Jan 2023 05:04:58 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XJoLMoCAw6vpzzrK3FP/uV51je7rRpvanaTsdpRlif38hXz3W0olGjWajiHFn2T5kx+SixRUui4zOTWo8ghg/rf4tkBXG8XdBdFi0fkINDAGA+3ZELYCI/4XMxIhAJd2rGmmlUzJ6XvmQD0Uuj9CIuPS0wEt7MesPhUyTMfDN6JeNx6BX6pFEnLiyCVpZl83e9FL85b5wN7b/JjKv2lQmJLI5DROXwoPo6gBWr2/vCnOIz7yZWUcm5h9z9XT3v1WHexSaC1z8Bg8fB+Z8YWNdB3GCoB9pLcdkfkSt+etl9+rXRhFkdlXtjFbfthNS0kABEYbVqyWm3qKn5r55nnbNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PFj30Q9rHoYd3o9cnAcqUtfgEIR5q9IiSa1m0tBxvzg=;
 b=DvacccMwAO/I4kVBgNjmZmCd99lY+Q0ZSwkPIE2Rm6jnT1pob/6UJ4icb2JPoKcs1jv9ZRr8qnWtEVA7H/MEwmMFJjBZ6Z53TxtM4W1+GEC8JVIq4Mx8U72WjLCA6l7UwBn7awHVQG8/UG/QWhnURcrNyrIUlhtgwxlFmgiL2iOzEpVOrCiftI9kSgDUC57/Cq7/YGnCpptOxGD/trddgwxY85l65fZtBsTbEVnYmpMzsP+nb2CUxIqwsdi+kbzuXZs5YYpnOrG1yKe2PYXFzYj3Y6uvujfPu/kBsV4Gk74yG12ABKfiQxRbmpzUdz2g4DCdtYEiE1SwPR4CBFxLJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cornelisnetworks.com; dmarc=pass action=none
 header.from=cornelisnetworks.com; dkim=pass header.d=cornelisnetworks.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cornelisnetworks.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PFj30Q9rHoYd3o9cnAcqUtfgEIR5q9IiSa1m0tBxvzg=;
 b=e1/SEio2qu/C01cbBROyMDunseMcK0N48aj/ta08vTmFVccUXJUc4j66PG7bkG+GyMl893rH7kdmD4Wx52DgwQlr6NAF6TidH9tU77o8NRxvHGpu98jzKYJmJvPmgHcoY5IGwNXvkf9EPYRtBaUOda88aCuFTzQt2GWT2PsHi4ldNY3Zjv+idaBlRzirMLDWVOgT+ee6Gcmr7xtliS101IFxOPwQuEgKMKjSVmx7gzTWbUNpimOtie+jFIqxMfFe43t97kc1fSUN8k42xKe4caq+TUrDhoW+U+hZzhysspIqgIZRy6UMvIL8D3E6aBIRroIX17+ERfMfYGh48lN+wQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cornelisnetworks.com;
Received: from BN6PR01MB2610.prod.exchangelabs.com (2603:10b6:404:d0::7) by
 DM5PR0102MB3383.prod.exchangelabs.com (2603:10b6:4:a9::24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5986.23; Wed, 18 Jan 2023 13:04:56 +0000
Received: from BN6PR01MB2610.prod.exchangelabs.com
 ([fe80::5844:6112:4eb1:a8f8]) by BN6PR01MB2610.prod.exchangelabs.com
 ([fe80::5844:6112:4eb1:a8f8%9]) with mapi id 15.20.6002.013; Wed, 18 Jan 2023
 13:04:56 +0000
Message-ID: <a1efafe0-1c8e-60ae-cc77-b3592ea5b989@cornelisnetworks.com>
Date:   Wed, 18 Jan 2023 08:04:52 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.0
Subject: Re: [PATCH for-next 0/7] FIXME and other fixes
Content-Language: en-US
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Jason Gunthorpe <jgg@nvidia.com>,
        Dean Luick <dean.luick@cornelisnetworks.com>,
        linux-rdma@vger.kernel.org
References: <167328561962.1472990.9463955313515395755.stgit@awfm-02.cornelisnetworks.com>
 <Y718/h2uSTYq5PTa@nvidia.com>
 <3cf880fa-3374-541f-1996-d30d635db594@cornelisnetworks.com>
 <bce1ab36-66e4-465c-e051-94e397d108ba@cornelisnetworks.com>
 <Y8Pnn8NokWNsKQO/@unreal>
 <472565cb-e99d-95a6-4d20-6a34f77c8cf1@cornelisnetworks.com>
 <Y8T5602bNhscGixb@unreal>
From:   Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
In-Reply-To: <Y8T5602bNhscGixb@unreal>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BL1PR13CA0265.namprd13.prod.outlook.com
 (2603:10b6:208:2ba::30) To BN6PR01MB2610.prod.exchangelabs.com
 (2603:10b6:404:d0::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN6PR01MB2610:EE_|DM5PR0102MB3383:EE_
X-MS-Office365-Filtering-Correlation-Id: a98fb719-b81a-427b-e980-08daf954987d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: S6Cp4WgnW3TSLM9Ryn06vBEzUhKy25e8wX8cRdTjeZmWMfKtgJWCgWnI+x1N2jBkF9btjhO8t3hwZroeNvn1pcUY9z9JFhPRhkfTaOXxucbrKtGtEiO0z+CyVVECNU+QEInh+qxnvDFqD8q5Bvc5wnDaiuTQfdPsHw9FCXfKddGYPW73c35Y8vFUoDjhHyzTDs610mrN5hDjT4IZONi+nYBAON4wwj84GLoW1t8piSpFCe34VSW675gB1MbAQU6TCaVwqGZHyQFbsXHmg1Y4wlTMvFnaXjSyjbHHFoH7K7NZnBtr0ln8OqmXI2DYg+W4gMrbbtAOZxM2icpPeNuz0COO5L30QARYh7ZeUTyy6QbZ9JLNbEGVzWpALMaRjgqtdn2JVI05sHkwmhWee4slc88/JwkOr01FQse+dx+0B1War5N70u/qRNh0lrzlUvaKDqB1WIoQddYcA4FUNTQTgDiBN2mrtFm8RFNWTBzue7BJsbacrEfn12UJHAyA0prO6y19SgVaYq2F+kdf4He5hRA3yVCH+jKsldGXQkSeb6r2j82W+EW+LZ1TpZ7oV07KMBUP8WOTY+e4uZJ6SFBh3oGYG58S/dFcmrQUlWm1VMirjjjOTDY+pFQxZTOBxVmjufW7beIt+j81QDAgByUZBvtvOEQNgCViUm/W2DsQQj1stDPw91FqG9Tiy/+ebSi0uc4yk/3VqsN+dONWNeOtJQUUPCUue/Npbm66jrQGD3+tygdITnEfx/4qONlIQB9u
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN6PR01MB2610.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(396003)(39840400004)(366004)(136003)(376002)(451199015)(38350700002)(38100700002)(36756003)(966005)(6486002)(86362001)(31696002)(186003)(6512007)(66476007)(26005)(6916009)(66556008)(4326008)(66946007)(478600001)(31686004)(54906003)(52116002)(2616005)(53546011)(316002)(6506007)(66899015)(8936002)(8676002)(44832011)(6666004)(5660300002)(2906002)(41300700001)(83380400001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TEJvaVNJWFZCTFc2K1JScTM5QWFOUDEzSTFUdnNtUTFuYWMwVTVqb3FtTG13?=
 =?utf-8?B?VDFXcmI2d0R3Y0FZVzRlam9EdTdVM1pZbVRINTVqU2pHYkZVaWhhQmFrYlZm?=
 =?utf-8?B?VXErTzJCRmpPd2t3WVlubVZFSkNNaW5BalpDeVNrV2xzZnZVT0R0bGhFdEFq?=
 =?utf-8?B?bGs5R040Rm9xc0ZmcUlNOVpDS0JFZ3hQeFdESjczZ3RNbjVzamkvTTJsMHV0?=
 =?utf-8?B?ZnFacyswRTk4MmQrM2JLUmFQbkk4Smw0RzF3WEMreGpSSWVMYkxJQUxyR1c5?=
 =?utf-8?B?ZzdVVzd2a2NYSFhPSGt5ZEVEKzF2SmxSSitSb2krOTRjQnhFZXJtVlNmWnZF?=
 =?utf-8?B?bzVUVkJySmhaVE1ISkx5ZEM4ZURYbFNCYlROQTRXQVF3OUl6dG5XUGV4S1Ur?=
 =?utf-8?B?UnRMeEo4amtHYk1CZHNIK3VkK1lob0txS1N4OG5TY0RBejlQdXRISlNWZzNR?=
 =?utf-8?B?TFJnNTlSMCtJbFBuUTNEK0ViZGZtdDNscTNHSC9obEFkWkNHRHZ3MUNzT0xs?=
 =?utf-8?B?WG1zeXhINVM0UHBhQzB2dDVuMUhYMWVlL0JwWi9tZ2JkM0t4WVU4aWJRRWRq?=
 =?utf-8?B?bjVEUDVWeHNLbFE2MmRMc0h3NjlVZnJ3cFphMTY1bUs5N2pNTVNNbytySjJ3?=
 =?utf-8?B?RUVrQklqTjE4RzFLbFVjcDV0T3Z4bnZBKzdSd1dod3ZKclVyVU9kT2IyRlds?=
 =?utf-8?B?SEdYZm9Ic2dobzFhOWNzTEdyVCtQelBMUXFNQnJzdG9HS0pFa1JFOTQ0Yzcw?=
 =?utf-8?B?MXNtWjNvUWROYXowZkJtNnRrdm9YcWg3QjJNZFl4UXlRbjdIdUxQU3lvWldK?=
 =?utf-8?B?VDNWRGhYQnMrTGxpREdZa1NOazZLWnU0TEdXMllmR1N5QmN6dklkYnFlTVRW?=
 =?utf-8?B?MlJOdDFkTm5RL3lFaWRmY0tjaUgzZ1lsNFJFM1hvQkdHOWZ1dENxQWV6M2Nm?=
 =?utf-8?B?bXJlU2Z2WXJmVHU5TFo3YkF0YUNudlFCNmtOWmRXWHZ4aHQrYStYZmFtb24v?=
 =?utf-8?B?Z1dHVjExZFZWRk0xbWptMnMrYXJMbzB1MlV6cWVWVldMUVR3RFBPVUwzUDVD?=
 =?utf-8?B?dXhuZmlldVlLUUd5eG1KNzYvSHNrcy94aDIzTFhBMjZjdUwybURJZWNZMEhp?=
 =?utf-8?B?eDlNVkNsVmNyY2JiQ2FwYmtOc3E3YzJabXlpUlVIOEhxTjY5eUFWZy9vZEw2?=
 =?utf-8?B?d2FweC9iZzZvMGxDR25scUw5UE5FQ0pnUFViVkVrUjdoeXlrcGpsZXgyWCtt?=
 =?utf-8?B?TDdzRzlCTDc4QkZ2QUloYTE0Q1E5Vk5CaTlsVmp1MEZmOCtkZlZubUZuUnQ3?=
 =?utf-8?B?TjVWR1BlNmovVEVHOVJVTUNweVloclVBQ1FxZCsxdjZsajE4aVNsQlVYVWNQ?=
 =?utf-8?B?WmhSb0JQRlN0bHhJcDdBeGRET3huOTVSMlFpYk51TW9ucHZXQjBpMngvb014?=
 =?utf-8?B?RmdZM0M3dFdaa1Iyc3VBWGlTYVRmK1JwT3A5NmN3Rm1IeEZURnhyRUJMRVYw?=
 =?utf-8?B?Zm1TYUJBRkVyck9KUWdCU011VnN5Z3pVcjBrMlVIMkgrV1dtVEhtOWYrbmpt?=
 =?utf-8?B?M0IrSDRXT0tESWRzODRaanFoYldOeUI1SHV2K09FZGZOdGlzbW1HTmtHeTVq?=
 =?utf-8?B?anFxZFhBK280LzdTSUR0d1RXYm9ieENTdWh6Vyt4ZlQ3SWFaWEo1NHlVQ3ZG?=
 =?utf-8?B?ZWlxUzFhRUx2YXdLZGNnRWdRWVBGcERNZzJ5NEx2ZTJHOENNUXRHU3c0VjNq?=
 =?utf-8?B?eW5NOTZXRkZqd0phYjY0K0tGbHdEaWx2Q3UvQWg5clE3TFl5V3YzOXE5Qjk3?=
 =?utf-8?B?L1I5S3JHTGROZ0kzbU4zVDFoQ0J5Rm5JQkh5eE1kOXZ5c0N1elF2UXRsSitw?=
 =?utf-8?B?U2pRTEZlWGFlL1FRemtweTQ3V05xQ09KMnY2RnNyMFFRUm00dkw2V1c1SHlt?=
 =?utf-8?B?cXArTHhjYTB4STZobWxhcit1eW9wSDA2bU4rYUE0bmQ3dU5QK0hVVUROQVhH?=
 =?utf-8?B?WEUwMUhncDZSdEo4YUIzSXk0UHRVcmpCa1lwUkx1WW5KY2dBQXBTM3I0NzR2?=
 =?utf-8?B?b1hrQ3BTUS9SejN6Nkpkd05TMmQ1SCt4c0Z3R3dOZHFkdWRhQWdMdjNCTEc5?=
 =?utf-8?B?Y3hYK3daSksrM0NuSGlLaWVzc0JZVjduMEQyTjR0VytvYjk2RVhwUUNWSmpl?=
 =?utf-8?Q?oakZd732vbPlYjLFKgADbc8=3D?=
X-OriginatorOrg: cornelisnetworks.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a98fb719-b81a-427b-e980-08daf954987d
X-MS-Exchange-CrossTenant-AuthSource: BN6PR01MB2610.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jan 2023 13:04:55.8397
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4dbdb7da-74ee-4b45-8747-ef5ce5ebe68a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OHKY9f/d1z/DdQsrMEvypbhGe0v5JLbxDM38vjrIZPeuvo0yg+AAyZLFA4zin1KdcQo+NMf/75NMgaW/glgyDl7BXjJUm3ANv32P5MVYKaTSpOjLIcMPPugNVT9IHDKB
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR0102MB3383
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 1/16/23 2:16 AM, Leon Romanovsky wrote:
> On Mon, Jan 16, 2023 at 12:36:51AM -0500, Dennis Dalessandro wrote:
>> On 1/15/23 6:46 AM, Leon Romanovsky wrote:
>>> On Fri, Jan 13, 2023 at 12:21:50PM -0500, Dennis Dalessandro wrote:
>>>> On 1/10/23 4:03 PM, Dennis Dalessandro wrote:
>>>>> On 1/10/23 9:58 AM, Jason Gunthorpe wrote:
>>>>>> On Mon, Jan 09, 2023 at 02:03:58PM -0500, Dennis Dalessandro wrote:
>>>>>>> Dean fixes the FIXME that was left by Jason in the code to use the interval
>>>>>>> notifier.
>>>>>>
>>>>>> ? Which patch did that?
>>>>>
>>>>> My fault. The last patch in the previous series [1] was meant to go first here.
>>>>> I got off by 1 when I was splitting the patches out for submit.
>>>>>
>>>>> [1]
>>>>> https://lore.kernel.org/linux-rdma/167328549178.1472310.9867497376936699488.stgit@awfm-02.cornelisnetworks.com/T/#u
>>>>
>>>> As a side effect of this, can we pull patch 2/7 from this series into the RC?
>>>
>>> No, everything is in for-rc/for-next now.
>>
>> Without that patch there will be a regression in 6.2. 
> 
> I'm lost here. You are saying above that you wanted patch from -rc to be
> in -next series. However, you wrote about regression in 6.2, which is -rc.

Originally I did not mean to send:
[PATCH for-rc 6/6] IB/hfi1: Remove user expected buffer invalidate race
for -rc.

I didn't realize, it has a functional dependency on:
[PATCH for-next 2/7] IB/hfi1: Assign npages earlier

Ideally either they both go to -rc or they both go to -next.

>> Is there a reason it can't merge into -rc?
> 
> Here you are asking to bring -next patches to -rc.

One patch.

> So please help me, what do you want to do with these branches?
> 1. -rc
> 2. -next
> 
> Options are:
> 1. keep as is
> 2. revert

Let me do some build testing. If we revert the -rc patch and then reapply to
-next we may encounter conflicts and/or build issues and just make things worse.

> 3. anything else?Will get back to you if I come up with something else.

> What we won't do:
> 1. backmerge -next to -rc

So why is this not an option? Well ok so I don't mean we should merge. I guess
I'm more looking to cherry-pick.

> 2. merge -rc into -next without strong justification, as it is not
> needed in general because such merge happens during merge window.

Agree, not needed.

-Denny




