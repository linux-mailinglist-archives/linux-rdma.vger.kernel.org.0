Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03C424C2D7F
	for <lists+linux-rdma@lfdr.de>; Thu, 24 Feb 2022 14:45:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233007AbiBXNpH (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 24 Feb 2022 08:45:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233481AbiBXNpG (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 24 Feb 2022 08:45:06 -0500
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2112.outbound.protection.outlook.com [40.107.244.112])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0CF627791B;
        Thu, 24 Feb 2022 05:44:35 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YzeHMR5qD1LQCr0kEgVF9OXzwg98FPLRvkuTqCP94sWSn/OVn+FgA5RgMHI1rWae/J9KUiaMGr9LPcstBBqLsDMqVVitP7gIhBZf5xCGMexUMTGM3XLIOQCSrrL7Yo8yKjeGVT6a6zjxS15uBBg+/niSy9v5UCUABhYigvj1DBmuUbuzE9S2PRkt/yKMG2KhH7pbqBkh9bXPa3V1EO6Otvdz/sEXPrJcLrwZsxC1Hi7DkNQHIjWk6W+aYQz/6zfxSwzLhsb6NPduaFflV1CPN6xgitRxnugj5fhnx8Q6eNht56GgGt3folpjMPXPcw8AXyhmmDTICzfj6RioNRnmcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GcKbL00p0CLUwnx3rdLklU4hn9UCwyt/50iBd1JbMCU=;
 b=XF45pVUKRrj9+vkoztcP2K1Pt0dQ7nbgWpNBIon5O39fk8XM/RPkgBxSv5HoQB5oKZZZ/uDbTy++xE6XkF6mJY1iYIdI4CO4glAAAVg4fxNOk3cbLXcAnmARm9VB9QhEl+l3q8jVmPDe/bAQ9nlftXRwu3Im7DXaHYk0PbSUp9m8BCe4NHLusYUgW3mSMeFhxMoC+Ek5N30d/qerkYJ/7Kjxq+MzuRwdLMen/Cwpf2ONXFbk1xUM2l4vtPAW9DzMHYCxjwyO14JRYcKqCxVuuyT2TdWSVFXuS+emDSonNIDsP2jJxQ2LHgB5GcvCnTFOBr5zJ87/DPjoAw1YT3UCqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cornelisnetworks.com; dmarc=pass action=none
 header.from=cornelisnetworks.com; dkim=pass header.d=cornelisnetworks.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cornelisnetworks.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GcKbL00p0CLUwnx3rdLklU4hn9UCwyt/50iBd1JbMCU=;
 b=Q+Dsu5XxtvYvx93xOlw6TzlCnQaJ/XuIh390AmFfk4xHe/IgCKrWvetXCnZHwvaQY29qiVntmxQ8ZyADVZBH/urXv+TtyxgO9YIZh2DhUH9JmLwipepxVnC8s/yEErSv57twQZMDwiPtHMfKnTFRphJ0CQ2ePAmlKo5iN8iQ6GdT8AYgoWGsQxmR9KrgbcwaNClpLVzUbnWeRO7taL36zXNmxxWXUOx9BVr1MK32EEJXVILL53cJ7xZJJ+sdjiECVb2hSfFhLND3lmqD0IoyGub23RC0YViA8IEEKEVENX1th58+AnV3lJVGkiM10oGtGIYnIjLOCQNkY3E0YSy+zQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cornelisnetworks.com;
Received: from PH0PR01MB6439.prod.exchangelabs.com (2603:10b6:510:d::22) by
 BN7PR01MB3843.prod.exchangelabs.com (2603:10b6:406:84::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5017.24; Thu, 24 Feb 2022 13:44:32 +0000
Received: from PH0PR01MB6439.prod.exchangelabs.com
 ([fe80::4ce8:dd24:bf67:47fa]) by PH0PR01MB6439.prod.exchangelabs.com
 ([fe80::4ce8:dd24:bf67:47fa%7]) with mapi id 15.20.5017.024; Thu, 24 Feb 2022
 13:44:32 +0000
Message-ID: <01f0c30b-08dd-e70c-ddfa-b47843e76366@cornelisnetworks.com>
Date:   Thu, 24 Feb 2022 08:44:29 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.6.0
Subject: Re: [PATCH v1 1/1] IB/hfi1: Don't cast parameter in bit operations
Content-Language: en-US
To:     'Andy Shevchenko' <andriy.shevchenko@linux.intel.com>,
        David Laight <David.Laight@aculab.com>
Cc:     Jason Gunthorpe <jgg@ziepe.ca>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Mike Marciniszyn <mike.marciniszyn@cornelisnetworks.com>
References: <20220223185353.51370-1-andriy.shevchenko@linux.intel.com>
 <e39730af26cc4a4d944fa3205fa17b3c@AcuMS.aculab.com>
 <Yha1bIYZpCWZIowl@smile.fi.intel.com>
From:   Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
In-Reply-To: <Yha1bIYZpCWZIowl@smile.fi.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BL1PR13CA0342.namprd13.prod.outlook.com
 (2603:10b6:208:2c6::17) To PH0PR01MB6439.prod.exchangelabs.com
 (2603:10b6:510:d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4eac0c54-01c1-41a9-5925-08d9f79bc97b
X-MS-TrafficTypeDiagnostic: BN7PR01MB3843:EE_
X-Microsoft-Antispam-PRVS: <BN7PR01MB3843B9508185DE05B96190A8F43D9@BN7PR01MB3843.prod.exchangelabs.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fpsk+2TwoXfcs4FugbO+iR35j9x1IJcekWN2mRO4eDH3RG6wi4GG7wooKT1e7mJ0GrJu1SNZ0n1AqcOOmX9oboah6N9k8fPC8IvktSFs1fYbKB/4pphKjHKUJAPCpfEFExNtx89/eXizWEnhKr2gXR1Am4WQbk2Z8UF9fZRa+dNNZVR+w7k99yshuqJ241kNXmCyQVgYuORxiBhvnGBexI2/jw5CdCXHe7CyuPCYGoD8PEqxDstTzzVveWeVBnzA+6vJUAV3UTjuaipSu6AYVCf7kmMa2EHobGbnuhivKDJO9UPbRhTrHt+k+SPRhKt+JhHkTew58lxbiRyzwFS/nzYbOpPc6Jhwpi5+5ykiGdvkcRv+vdN5VIN92+lqUpCzDLepRf3DauNqf8gqIVA0sEgZFz9ZvK5d/bqoZsQXsFJZNqyMF7CtV0VZEOz3T9lSQsBKs0jYn5FJnzVgoGbYMc4Gf8eY9zL8lhXwibt6Sfj3lXMwnt8y6fI8Q3f8o5RlNJ7qQrOD3Nq6iqfZ0S1rsQJlwzv3XdxpUhI/3gMXP2WGdUWf47QGKYeWVyrQeHY/e7mr6iiDSdSh3DbsKGfCCCEa/Xq5Q+aVCALobtv16KFIVfK4Qc1dFxJ7Nx+vtO3EtvvVY0Iendy7CF9chCkMc6yneF0HYa7Wz+WPuFUz/80DXk5E00wwXS00ThYRYUASqVB+R4KgzJRVV4O7RoiuzrQCOtZxtsIYjxUGaQjUPLY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR01MB6439.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(346002)(366004)(39840400004)(136003)(376002)(396003)(8936002)(6512007)(2906002)(52116002)(53546011)(66946007)(6506007)(66556008)(66476007)(4326008)(44832011)(8676002)(186003)(26005)(2616005)(6666004)(83380400001)(107886003)(5660300002)(38100700002)(38350700002)(54906003)(110136005)(86362001)(31696002)(6486002)(316002)(31686004)(36756003)(508600001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QWFRNXJIL2daaGJJekNRQkhUdHFONU1iOGhkMFFobjVIUVAxREJ0SDNNYTBQ?=
 =?utf-8?B?N2NvWEJuaThqZXAzY1ZOdThNVm8rYmphOUNMSnJCN3pMZ2tSZlVGbjNTeXNK?=
 =?utf-8?B?T0l2N1JWeXp4Z1BIK0ZZOXN0cFFsVW1TU2RQTk1HM1NjUS9EMUJLVDBGQklq?=
 =?utf-8?B?RmJsaEx0SkI5dWJiNU43cXZSZEt4REkxRTdoTnhUT1ljM2ZmVnRMcEQvNCti?=
 =?utf-8?B?a0c1M28vb2lYaFhCOHJLeU1VaWt4SVhqZmFzVUlkN3piVUJWdDZmbDF5b3dW?=
 =?utf-8?B?UFZMZ0wzWG5keGZCUU5YVzJoaEtNRWNhWjlrbDhXUnRTTmU1Tm9kODVtRlR4?=
 =?utf-8?B?Q1VBTTFNL3FVcU5aS3ZSUlV2TGIrenNYQ2l6VkRKS1cwbDRFbEx5aWlubzZs?=
 =?utf-8?B?eTNjSW91MlBvb3lkSkxibTN5Q1RtaEd3U1k4U3pIdUUxaWRIL1ZDdGQ2VGpt?=
 =?utf-8?B?c0lrZ2JaeDUzWnVqU1pDQU5Pc29KWnZiTjBWU2x0bEpxcllWQzk3b3Znb1Iv?=
 =?utf-8?B?c2FvQ3pXMElJSURaQ05rK09iUXNNTWtpMFdaK0MrOUgzcXhmZzZwYkdOYUlQ?=
 =?utf-8?B?UkZYZXJkd3U5ckJQajNRdUpLWE9CU2F3Tmhoa3JURjMvT0lYRDluL2FGbG1k?=
 =?utf-8?B?cjBFSGw2R2c2MzV4YXYrWkpwa1hlSmx0dlpkWEV2eGpXRnpXRThiQUJFclVa?=
 =?utf-8?B?dW1BTllYTGV6MW5mSE9CQ2F5L1BScTZjUTQwRmt2YWhHa1VJUjBnLy92emFX?=
 =?utf-8?B?MkV1aS9BeU9yK2xjRGRhMG9HU2NMYTFNUjU5cW94SE9KSUx0V0ZkU1plMmhy?=
 =?utf-8?B?Q1ZlWlhON0xOaVBPSWpZM09VK05NTzM3WW9rZE1WaE9kc2Z2S1lWcEJ4RzZL?=
 =?utf-8?B?MklmbTI1N3ZBbitsY1JwOFNFc2M5UVF0a05ZZ3ZuQlR6R1M2TUNGNUlvVnRX?=
 =?utf-8?B?cld2aWZtc0h6bk9nZHFwS3Y4NVJleFg3YkxVd3Q3UzA4K0NjN0JuUGRCL1R3?=
 =?utf-8?B?YlhoVHVOZmxveTArZlhwWGdUMWRDUFFqZXFjcFFaMHZZVzFrTXVyQkpDcFFn?=
 =?utf-8?B?NnVsb0luWC80WXF0UzFyN1VGN3BjdCtKV0hEUHluTERUeHlpZmFhVWFLRkNp?=
 =?utf-8?B?bTNFWERtUkdHVEtEUkcwbTdHZWRXWkdieGJIQ01uRkRzUm5QdGFDQXhEYzFZ?=
 =?utf-8?B?MkJaRHByUUtNRldoZVpsYVM2V21PZU9NR0Jlc3kvUFdkcTczUXNrMnlnSEtm?=
 =?utf-8?B?REw4ZXZlV25oTVVxRXdLdjkyODI4YkxNRkRYNFNyekdlN3gvREtQUzNXN0wx?=
 =?utf-8?B?MEdyb1Z5TlJ0QnRnY2o1WnBoR0o3VjdOMjJ0UmhlR1lxWFYxU2ZOcmRiVVhy?=
 =?utf-8?B?Vm5TbEtzMFpoN0cwdDd2RDZxZm9remdkWnlrMnBvSVJpTEFSSE1VVGNabUtG?=
 =?utf-8?B?VW83S2pqNWxtclVSME0rN2tSeSthTHZjNWhaRlJ5cVJBRlkzdXA4V21pbDhm?=
 =?utf-8?B?bld3a1VUMWpKNjk2bmlTZDh3OTRReUp2Z0ZQZ3pBMnlIZ3lwVVZ1ZHl2S01Y?=
 =?utf-8?B?am1qeHJ3a0dHRXFIaGtrWlRxd1BzQU5rTlJhdUo0aHcwY0tQdnJrY0Y4bGo2?=
 =?utf-8?B?QU10VU1nV25VVHV2a0FPaUo4a0NnVmQzcW4yNitUZ2F3ZHFmMm9NUEh3Nk82?=
 =?utf-8?B?TllJVjh2MUlsaDIyTjI3U2UrVkRXWi9OMk5jSXo2eVNreTNYTHBwYmNSTUtT?=
 =?utf-8?B?aWY4SUN1eElaQjgxRS9ySjF0SytnTkEvakswUWtHbER5ZHNnVHc5L0NNUXdL?=
 =?utf-8?B?cmpub0IzZ1h2bElVOVkxZ0U0bmEvRmw1RkRBaHJHbGFhNG4wQS9MaGFxTCtV?=
 =?utf-8?B?eUdYQ0EwbzNuZEh5dDFQeEZSOEZxQU9QK0NSNllIL2lmdFpFNG9zUXh2V1l5?=
 =?utf-8?B?czB6dHg3TEhsaEJDSmRMSWkyQnZ1d1d3QXFGOHBXWlowbmZEN243aTl2dzVY?=
 =?utf-8?B?SjNkakNRWWY1WlRaZ0pmRkpjYXgvZWdzTENkWFlaN3c5cVhsbHFrcFhNZU9Y?=
 =?utf-8?B?eW9vUEVPUXhVTVJ6c2pPL09wUzV6eDdZVU9ITk1qeWdXZFVkd1ZqUHpEWUNj?=
 =?utf-8?B?WFZENTEyQk5NQVVCOUxQZVY5b0ViUEpzTzN2am0rUUE0WE5BUVlGa2dPaGFE?=
 =?utf-8?B?SFM5R2xyYWNEL0Q2TTFiYnN0NmhXWlBtcWkwb1FFZE1vaS9Kb1R6cTY4Rkto?=
 =?utf-8?B?L3dlSDcweFRrV2lXTmN3UzduMXhqSC9Pb09RejBvdGo0TFdLNU8yOW1TUzRR?=
 =?utf-8?B?aUNQYUU0bmZVOXMyRG0rWTFNcHVFUmJiZlphUEQ5Y1ludzFoOGZIQT09?=
X-OriginatorOrg: cornelisnetworks.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4eac0c54-01c1-41a9-5925-08d9f79bc97b
X-MS-Exchange-CrossTenant-AuthSource: PH0PR01MB6439.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2022 13:44:32.3962
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4dbdb7da-74ee-4b45-8747-ef5ce5ebe68a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Z5c2hpd3kafHgC21O+pXDlkihudRs2GX2JymQCIVtan4pG/Zbzd19GFJAoTavEMic0+2+7/zPLxSoGciqahs7EgMZgfud6bQMxc0cvuVfOuaBwQ5g4+eISsr0QOVqaVF
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR01MB3843
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 2/23/22 5:30 PM, 'Andy Shevchenko' wrote:
> On Wed, Feb 23, 2022 at 09:44:32PM +0000, David Laight wrote:
>> From: Andy Shevchenko
>>> Sent: 23 February 2022 18:54
>>>
>>> While in this particular case it would not be a (critical) issue,
>>> the pattern itself is bad and error prone in case somebody blindly
>>> copies to their code.
>>
>> It is horribly wrong on BE systems.
> 
> You mean the pattern? Yes, it has three issues regarding to endianess and
> potential out of boundary access.
> 
> ...
> 
>>> -	return handled;
>>> +	return IRQ_RETVAL(!bitmap_empty(pending, CCE_NUM_INT_CSRS * 64));
> 
>> You really don't want to scan the bitmap again.
> 
> Either way it wastes cycles, the outcome depends on the actual distribution of
> the interrupts across the bitmap. If it gathered closer to the beginning of the
> bitmap, my code wins, otherwise the original ones.
> 
>> Actually, of the face of it, you could merge the two loops.
>> Provided you clear the status bit before calling the relevant
>> handler I expect it will all work.
> 
> True. I will consider that for v2.

Will wait for a v2 patch and I'll test it. We are very sensitive to performance
changes.

-Denny
