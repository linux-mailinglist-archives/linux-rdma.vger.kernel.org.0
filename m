Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C6B366B6E7
	for <lists+linux-rdma@lfdr.de>; Mon, 16 Jan 2023 06:37:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231660AbjAPFhA (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 16 Jan 2023 00:37:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231724AbjAPFg7 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 16 Jan 2023 00:36:59 -0500
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2121.outbound.protection.outlook.com [40.107.243.121])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CB8A8A40
        for <linux-rdma@vger.kernel.org>; Sun, 15 Jan 2023 21:36:56 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O6lnvqOtaBpTUc0CicsVqBzdHwW6BVb6YSBKz1OEancbIKzv0ZZURDvERuIEOfMysgbS/5Rf8xlJFacx8MkoY3DlR/Ki3Y6F+iHZ1d9bYPpSy/hX5SK5BqzJNMNdWZJ9wkh9t/n6p9SW7SCO56znBR65gALbxy9N7A8vBGRVBiRTmEEPJJKXCauwhl2uamrLFJRNGwIUsd2Kiu8gld1Tdj0B9mca6rWJ1sGh12mUE2SNfcuVUYRu5+GFolwMGhXBiz+aQ9lv3MyGodG6h9XRGW9Bxhh7BzqYzZLaYDaQaI53Le1om/CnB/F2NnFOuITXoV8aDLBOe5V6N02dcWRz2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jvr+eEAnVCLvkBgqhCCYGsICG1Zy7thunELOSGFg00g=;
 b=a0v9kod4jCMe75PdA5pYtirDJM3QxJ2akkrOzk7vRRLQvCKmef5bQ1p9aRr5qiqGAi1ogt0xLfXk5acEqpBzYG0DEr8ausoYgCQoCqan+VqAFYOTMQtVpMcYAjyaXbgVOysc3JEam3x19h7Ziu4QTuv3YGNqP+Pn6ToM4gRCvqsr2f1y/QPG0TajnRlnYztfzZXH3zAKSMfT79Q4Pb9pHxCc3PUgQb83q8R+XYtOYP0mAht9JkIp8HTjm1bhmIihiFQtwnn0F8kYAiCFokrxcECcQUpCbWzvoL+oMP9sGqyFBx7m0+oLFIskRRX44FwEAZkWCrR6VSCxXF/KzBv3RQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cornelisnetworks.com; dmarc=pass action=none
 header.from=cornelisnetworks.com; dkim=pass header.d=cornelisnetworks.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cornelisnetworks.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jvr+eEAnVCLvkBgqhCCYGsICG1Zy7thunELOSGFg00g=;
 b=lTaxdj4Lj3+xIN4lO57Bw52rzIyeC6tRDqBqxGhsSEa/wM+cH13FQdSbYT33pCaaNgTrJB0NBap3vVMvLMiiiZCaLxFnKXgkQHEgy4o8xzeqTdm3JW+trkp7qUFZmbvzi30ZhhFP7afMEresgZVpT3moOwnlksyuq9P21nDE3vzlB4edpI+zgG8HZmbXjD8VzXf1ySZ9wTpMd+2Cj7bwAIBY35l/Q86U3mgrX81sThiJydMbwLXZ2JZFE5Fw1BN3EnIHZngadzeZ7sQ8oR/pAng/ZRA9EEa3q4gJhKPuo0iOzFTOpnPUdmOucI8rVPvr4yfyEbShn/SP6CWxKid+XA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cornelisnetworks.com;
Received: from BN6PR01MB2610.prod.exchangelabs.com (2603:10b6:404:d0::7) by
 DM5PR0101MB3065.prod.exchangelabs.com (2603:10b6:4:33::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5986.19; Mon, 16 Jan 2023 05:36:54 +0000
Received: from BN6PR01MB2610.prod.exchangelabs.com
 ([fe80::5844:6112:4eb1:a8f8]) by BN6PR01MB2610.prod.exchangelabs.com
 ([fe80::5844:6112:4eb1:a8f8%9]) with mapi id 15.20.6002.013; Mon, 16 Jan 2023
 05:36:54 +0000
Message-ID: <472565cb-e99d-95a6-4d20-6a34f77c8cf1@cornelisnetworks.com>
Date:   Mon, 16 Jan 2023 00:36:51 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.0
Subject: Re: [PATCH for-next 0/7] FIXME and other fixes
Content-Language: en-US
To:     Leon Romanovsky <leonro@nvidia.com>
Cc:     Jason Gunthorpe <jgg@nvidia.com>,
        Dean Luick <dean.luick@cornelisnetworks.com>,
        linux-rdma@vger.kernel.org
References: <167328561962.1472990.9463955313515395755.stgit@awfm-02.cornelisnetworks.com>
 <Y718/h2uSTYq5PTa@nvidia.com>
 <3cf880fa-3374-541f-1996-d30d635db594@cornelisnetworks.com>
 <bce1ab36-66e4-465c-e051-94e397d108ba@cornelisnetworks.com>
 <Y8Pnn8NokWNsKQO/@unreal>
From:   Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
In-Reply-To: <Y8Pnn8NokWNsKQO/@unreal>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BL1PR13CA0099.namprd13.prod.outlook.com
 (2603:10b6:208:2b9::14) To BN6PR01MB2610.prod.exchangelabs.com
 (2603:10b6:404:d0::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN6PR01MB2610:EE_|DM5PR0101MB3065:EE_
X-MS-Office365-Filtering-Correlation-Id: b2292dc1-75a3-4d9c-d3b6-08daf783ad1e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1n68itFfBg86ywgol50lfxcmaNrHTqrbanUWsHH9UfzcCAnO8tKWX0NbatfQmK1qk/XI6kZk8QURal2Fe/yUYk/gBestc6vqgv47YdAmolPqYdB5eJ4s+0Xfgyl0LKsFI5cl/QIBu8HyzCVFH7Wsd0gSckXbxB6TUGU4aSkm3KRvh6Ds1KFEhKs9u4Cix7G4hsRmwBhmkZwaonfAht0iGGx+8Oj/T0hmJuqD7hcW6Iv/5GCpT29lIGENIj/9l6ec9RVk+puFAjoEEptUXtUg0siuiXH2eQKz8WW1zjapdnbwfmMLRohitccRfNLeWzJpFXy2GRISObGOSIoH+/0y0LjqUCXVuomQt3Mvlprvvsjk0/upouoa1Ko04BpvCQ4mdmklx3aXhkbT6tViyIqoxMcV2us4bIkLBgKLo8OJCL1GXsGoEEQ2i08ASmNaTqZFux+D4Bbf5TdrABk6fydSJwHPoQI5H9rORUkQ3w/WgmRCaRDcuoiVZH4MFRQvbgnOZFZQB1GTr8Mx5/2n0G/Fzs3oP2BOZfzzvehAykhBffqPBF9FEyvO1WFT9SMNgUtEItADYqTKuPo6pofw6pl9WYM2BvSow3vBVRqyWlDNYMm2sSQSzAbhCQsLNEh23GxKby3ny7tc/PcSceznpDgweKi0pba4MwR+2/6BcEFLbYn+PTnR9Vov8PRJ41IaGMIJ9llAorUqw9Jkvv2gpSGxVV1ZidaEgwPfb09uxotV2da2pivv6jpBhJX/DyrX8pid
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN6PR01MB2610.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(39830400003)(346002)(366004)(396003)(136003)(451199015)(44832011)(38350700002)(38100700002)(8936002)(4744005)(31686004)(5660300002)(478600001)(6486002)(86362001)(966005)(41300700001)(4326008)(66476007)(6916009)(316002)(36756003)(66556008)(66946007)(8676002)(54906003)(2906002)(2616005)(53546011)(6666004)(6506007)(26005)(6512007)(186003)(52116002)(31696002)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MFlUTitLUmcvMEIxT250RGtWQlBVT0VhbU5LMHF1eWt2WUthTmRPeUVUMmFM?=
 =?utf-8?B?SzBYQkR6Njc5NXZ2NUs1N0hac2dzTE53Rm9IdGxTOG9YRUJTVU1mZTRrM2lM?=
 =?utf-8?B?K2RDT3JNQ3pudm5DUFJibUw1TmxjZ2FBWXBEUENXM3hnTFgrcHA1VXdmVGsx?=
 =?utf-8?B?b0cxUTk1N0pxOERPUkgyUHZRQUJuaTZOTUVyVGVzWjJlaHJreGR6ZnlHWGlU?=
 =?utf-8?B?L3FlOGRhZ3pUVndsWXVkRkxib3QrS3hVVms1bWc3RmdwUXpzYnk0MklSMS9S?=
 =?utf-8?B?TUFuallGazF0MEx2SUxpNVFhcTRDQlloaldhUGdjcEtvUWRJMW9XUU1wWERI?=
 =?utf-8?B?cEU3bkxXdjA1WHR1Q1BIbFJ6TmJoWHdKOWNlQmRYWmwrVGEzN2NFL2xwT0FN?=
 =?utf-8?B?cWh3MFE5RDdRbWwrTzA2QzJJblIrNXFlM2UxV0I4ZVJxeWU4dG55a3ZPa2NM?=
 =?utf-8?B?TWkramc0WjFLREgzM2lRaUlSbm1naGlhMUFJOUNlRWxBRDNQYVFSQ0wwSEpn?=
 =?utf-8?B?TWVSSTBuazRPcnF6UDJjcDA5U2hEYk9URis4ZGpwK0R6OUZxUlkreXRsSnp2?=
 =?utf-8?B?K3plQXVSdGxkUDQ0emp6WjZ1VTcrN0VWbldvVkduS0Y0R1pLWkRlVExYaDNx?=
 =?utf-8?B?WTl0dXZ1M0h0emVvZUY4RVNBQ1dxUzIwMGJYODVIWGdkc29qU0VnTG9NQ0tX?=
 =?utf-8?B?Z3pmWGE2S3QrQjluV3drSGxPbUlid2liOVlybEtZZUgwM2twMGR2T1VSV0Vk?=
 =?utf-8?B?V0xadkhPVG1wRlFXRGJvZytwYTYzQ1Y2c29XdzE2MEdaOFlqUi83a3FKVmxL?=
 =?utf-8?B?RVhtTk9qamNvaHZlWVRQdjQzVmk4KzltNVRQSDJRM2J1aG14UnR4SXB4N1Ju?=
 =?utf-8?B?dHR2MXljRmJxSkYvM0d3elBmaDZoTDNWY2FhUW92UWx1NjJVZ0lqNStkZjNI?=
 =?utf-8?B?aWJ0TVh5OUtLbENBMmxoRHJRcVBqUUF5d2twMlgyOUhvMjdqRUdQc2hGU2xm?=
 =?utf-8?B?RW9jY0lCWFVYN2VlTEFyOXNYMUV2TkUwRnVIYU5VcnUycUFtd014Nm1sT0p5?=
 =?utf-8?B?SW0rUFVDdE12azBSdERINVIyZFlqelVGVG5ReTVRZk5yZWhZZkhEWkp6V1R2?=
 =?utf-8?B?SnNXSnlPY0hBL1R5b3VMdGtxRlJsUEtoUFdKc2VoVTBBLzhOWnlnS2Znb0RG?=
 =?utf-8?B?emlPUkdsNFRYNHBrSGtiMjU4R25YVTV6Z3ZsQmFMODZGRXVPKzNHWWI2Y2Rm?=
 =?utf-8?B?U2ZPQkcrUVFvazFBRlA5YVRBeXdCZnlIdTFPODZ1SkI3RStiSUE4UFpwVkNK?=
 =?utf-8?B?eXlMcU8xdVMxWU9Qb1hKNHFuRlZrbUt6L3lFcVZVQklWUHphSmM2VS81TjNn?=
 =?utf-8?B?eGtueTNMS0Fub0s2OFZrZWVVQ294TTVUaVU4UGJtc01TT3NNRkNnS1k1Q3FT?=
 =?utf-8?B?eXJtLytobjYrdFJuejZKNGNGWW1ySk1ZaDZ6d1Q4dVBZNDYxbm9DNWlpY0cw?=
 =?utf-8?B?NThFeDdIcWREaDdNSzV1a3krNTBiRUpHeVNBRzFXMkNhc2VQT3dJRDRkOEd3?=
 =?utf-8?B?clJHcVk5T25qTTFmUXNqS3VuSisyS3QwWnFDVEVtY3ZDRlFSTENobGV2dmR4?=
 =?utf-8?B?YjFobVVVNTUvNXh5MEFwRzZ1WE1JMW9MUU1ESlRucXZGMjZHYzkveSsvTlJV?=
 =?utf-8?B?WWQ3OURpd1Y5eWRON3hzeVV3anpXS0paZzNmUUNYYzE4bFVRNVM1NXMrYlJz?=
 =?utf-8?B?YW5qcmdKSngyZDNFb0srbEN1bkx4QVJMVzdENjlzZ3BsbC9DMTQ4dDFRRGh0?=
 =?utf-8?B?cElCSkk1NzhSeGxsdFBkbFhhVzUyNktud21tYXVWUzFnNy9ZajhDTkdEekhv?=
 =?utf-8?B?Q24yeEtKTzZZakN2MHJyV2FTbEMyN1NUWEg1WnlreUZzNkhmbk1wZnU5dGpT?=
 =?utf-8?B?WWVOMXVKR05xSUp3MUNGYWdRZ2Y3Z2xpRGJTcHF5RGhhdTF4ZUNtR2hLLytV?=
 =?utf-8?B?d3lTdmh2elVuSGQrWmt2Rzk4d0pEL1gxZDA0cko2WGZNWVpvaWxzVVVMRnpw?=
 =?utf-8?B?WjdmNDNIdDRpdnp1Rkk2QmR5VzRkdDdacjJKWGRRZ29RRDh5aXYxSjh0eTR4?=
 =?utf-8?B?MHpvZzRLTTlOVVovNmo5WHZxVnAzVENtaVNFZldZZTI3dExmUGJLRUhycU9P?=
 =?utf-8?Q?ey+REIXF+QIrG72nerL/Zzs=3D?=
X-OriginatorOrg: cornelisnetworks.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b2292dc1-75a3-4d9c-d3b6-08daf783ad1e
X-MS-Exchange-CrossTenant-AuthSource: BN6PR01MB2610.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jan 2023 05:36:54.5007
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4dbdb7da-74ee-4b45-8747-ef5ce5ebe68a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FCxglBYqmI68EAVM3AkBjOnr/tfxJVx0zl2xtDdIcJ2dqj2Uoj+yyH2LiuNns93j2B1xqI6bNvcc1ywu0pM5W/naYDk0sLTUCPv24k3aZw/NvLkr0oA9vNNzAKpTccTS
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR0101MB3065
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 1/15/23 6:46 AM, Leon Romanovsky wrote:
> On Fri, Jan 13, 2023 at 12:21:50PM -0500, Dennis Dalessandro wrote:
>> On 1/10/23 4:03 PM, Dennis Dalessandro wrote:
>>> On 1/10/23 9:58 AM, Jason Gunthorpe wrote:
>>>> On Mon, Jan 09, 2023 at 02:03:58PM -0500, Dennis Dalessandro wrote:
>>>>> Dean fixes the FIXME that was left by Jason in the code to use the interval
>>>>> notifier.
>>>>
>>>> ? Which patch did that?
>>>
>>> My fault. The last patch in the previous series [1] was meant to go first here.
>>> I got off by 1 when I was splitting the patches out for submit.
>>>
>>> [1]
>>> https://lore.kernel.org/linux-rdma/167328549178.1472310.9867497376936699488.stgit@awfm-02.cornelisnetworks.com/T/#u
>>
>> As a side effect of this, can we pull patch 2/7 from this series into the RC?
> 
> No, everything is in for-rc/for-next now.

Without that patch there will be a regression in 6.2. Is there a reason it can't
merge into -rc?

-Denny
