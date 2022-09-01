Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33A185A9760
	for <lists+linux-rdma@lfdr.de>; Thu,  1 Sep 2022 14:50:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233448AbiIAMua (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 1 Sep 2022 08:50:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232082AbiIAMu2 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 1 Sep 2022 08:50:28 -0400
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2064.outbound.protection.outlook.com [40.107.100.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C32C474CA
        for <linux-rdma@vger.kernel.org>; Thu,  1 Sep 2022 05:50:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L0fyGI68J1iNiEvptqz70/qFUXGogJ5mkvN+Kxqd8LBlOJHSO8P82DYZsF8qJ2iEy08cDOwCQAoSqXGIZ4oPKIjfbNHQ7rtLmrldDd+o5K2IVyKWm07qM9whbOsYUKcabonl/D2B0vuVAt3/tQTQj5eHwhm3/fxGT9PnVX3JLWFODkCtRK+zak+elAh81m5eWO4tO5eMVvt8RQsJWbvzaTvS9Keqh1mMWnxgwxJ6BvbIs2QB55gTx5uU9Wy33bm5ijHv5TpogUqht9PQCoCXz4GorwVT8Qd8T64oCEY8DHcdVmH5vGQUOQTyEN6v7+xUGAqaijUCyT/SvxWZTtzp4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KEyftqn056dEyJ99zdJbEK6sb1nt+icLBrZY9wftJZ4=;
 b=bRtOvFJq6kUjCEpPOtA1i6RjC6i9hZQJatCvajg2gXkdgT81PLB32MscGrkVGoGY/0gXFCF9X1dxvzq38RLRj0YkVkhY67aqrbE0XfQ5q+3bXACPK5GS10jFm5zmaT4PCp+mFlXGnrvgIzFCyN2pQeVQv4b8jpLx10cTU4ktOdemIFnMKbPv58ACA+DxzcKwtpxZZEhwsMWNRAWCfXH1URqagXOjmLYbYT7LjGoGwVWn3e1S471Jd2OiO2i5Q6LDZbGSHDRK7SGWzZ3Sju9w0Q5dp4fLamafcU+oN2aqLYTz5sER68QOhfLicZkfdLsCT9FGJ7bYiW+SlPtRv5XO4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=talpey.com; dmarc=pass action=none header.from=talpey.com;
 dkim=pass header.d=talpey.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=talpey.com;
Received: from SN6PR01MB4445.prod.exchangelabs.com (2603:10b6:805:e2::33) by
 BYAPR01MB3863.prod.exchangelabs.com (2603:10b6:a02:84::32) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5588.11; Thu, 1 Sep 2022 12:50:15 +0000
Received: from SN6PR01MB4445.prod.exchangelabs.com
 ([fe80::701d:e406:dcfa:118b]) by SN6PR01MB4445.prod.exchangelabs.com
 ([fe80::701d:e406:dcfa:118b%4]) with mapi id 15.20.5566.021; Thu, 1 Sep 2022
 12:50:15 +0000
Message-ID: <6dee3f9e-f896-c31d-557c-f7a76574b41c@talpey.com>
Date:   Thu, 1 Sep 2022 08:50:12 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH] RDMA/siw: Add missing Kconfig selections
To:     Leon Romanovsky <leon@kernel.org>, Jason Gunthorpe <jgg@nvidia.com>
Cc:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Bernard Metzler <bmt@zurich.ibm.com>
References: <d366bf02-3271-754f-fc68-1a84016d0e19@talpey.com>
 <YxCkwzWMtiTkNYZO@nvidia.com> <YxCmTuxZzCiCRUbW@unreal>
Content-Language: en-US
From:   Tom Talpey <tom@talpey.com>
In-Reply-To: <YxCmTuxZzCiCRUbW@unreal>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN2PR12CA0014.namprd12.prod.outlook.com
 (2603:10b6:208:a8::27) To SN6PR01MB4445.prod.exchangelabs.com
 (2603:10b6:805:e2::33)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d1747ff8-518c-41ba-3b9f-08da8c188442
X-MS-TrafficTypeDiagnostic: BYAPR01MB3863:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jsPNY+wfpFKnhHz+lrdV5xzizoHrX0GjFc3DQQ0I4Fal2AcJI7GWTlJccOcal8CHz01x5neL1Mj1SGx3ifDPVq48U/QkvIEWexwOsYycCo//0kZdozruuAoPe/zuEXlxDBRWeoLzw0GcKlkMDsG3PnVmjAO2cOlnEzJZpP7mZ3rDo0RdrVaaoTxvVTeLGVwNpP89zKowaXHokpWjVnaX3IwC6i8ZUv2o/+HLl5DiKcH9mfvXWmCRW78f/wUNXAlP1xJj8ougCJfYUN7MvBbP3bkFT+4WIHj+H5Gq9uign5VrVD45sTtnvQekGI0dqyxQhZ8mn+6dvIbzIoI5GSEeWSESaqcub0Nu+OvOuxYVtJzAlXg9DWdiaQZPbp5fL1C3pwh1zp7kFmLZd6ImIDXY/cZFaHZc5ijpsmM8vd4d9fV7lOe0DiEdssnNt1040dE/xgLlLv8VdJLd3dzreeBBgpf0zGznewb62egc4xm0UERUcUMLauUk0nY/zAGVBX5xyAHXlKBBtO+po7BHb2ZTUYugPCbydqLkXg8ReVH2ls665jv2D2TEjrGwJZGeuyZWY1nSyNJ04CwmiwUN/a1DMtOd5vsfqwa7VZbq5pKkRptW9Gn6Xbf6pdrB4ObUhLIwVyccuWDBUjIdytLZnEXvIUJY1RcF4gez1I2BHHoZ8HYjkCFQuIP2HLIGtUI289vLt2oDVPd0pzfbLkH93CvcM0pN4iWnRNUR18j4fBIVcYp1+JW6WeCbqtZIUwR4Txn3DoTjOd8itmpjqFixJBFgouMgqTzCUcioPufzyi6O3ZA=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR01MB4445.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230016)(39830400003)(376002)(136003)(396003)(346002)(366004)(38100700002)(2906002)(31696002)(36756003)(38350700002)(86362001)(6666004)(53546011)(6512007)(52116002)(478600001)(41300700001)(6506007)(26005)(83380400001)(186003)(2616005)(4326008)(8676002)(8936002)(66476007)(66556008)(66946007)(5660300002)(6486002)(316002)(54906003)(110136005)(31686004)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Q0FVNll6QkJEWEoxR05RZTh6MlJjZmNTNUNBRGtZUEd4Ui9kcXFHYUhYc3F3?=
 =?utf-8?B?STdVYlQySUt3TlYveEZXOGkwa01TUy9YZWd5Mzk5Tm1VSDhJYStDYlV5am1h?=
 =?utf-8?B?cXFVdGxaUzlpRS9tTDZqeXlDdzdVZFpPS2syeDVxRDBRQ3ZsbkppTXpHd1p0?=
 =?utf-8?B?NHFIVThCcHJwdmhLKzh4SnZ2V2YwdUJoRTZTSlNiMXRUdFVGM1AzeUpnNnAw?=
 =?utf-8?B?Nmhac09GVWNISzlzaEE3ZjdIeE1tRElZRkZrbmNaand6OFY3aHdqc0hsTXdO?=
 =?utf-8?B?aWVtaXFwQURXd2JQZWluaGxvT0N1dGNTb2FjankrU2tvQi9BYWRCRUZOaHNp?=
 =?utf-8?B?aHZOMS9aVjRDUEtYcEFua3AvdFFwT01lRG1ialNyb2xjbVBBcGhtNTZzSWdq?=
 =?utf-8?B?Sm1GK3paczJiUktnWnRja1pBRXBHelVTWVo2d2dDS1FVRTMyL2N2eDZPV0Zi?=
 =?utf-8?B?L3o5Rnk5Q0tQeGRPTGdzUmVUd3JyeElQTlRpMWVoVnFjWTVRWjJLdXRicW54?=
 =?utf-8?B?N082Y1ZyS3BFbGNmS1pDT2o5ZHFiaWlLRE9ZdEhNZ2xBR0F2VFd3YUxaSWpM?=
 =?utf-8?B?a0k1bUhJV2YycDhNRUlodlExaXk3SHJ2cEJubFV6NUE2OS9wdDV4N0xUZlBU?=
 =?utf-8?B?U1dIbkx5anlEcGgwWWJ6ZGNFVXJkY0ZqZUtOYW8zb25Jbi9NTkUxRjI5Kzl2?=
 =?utf-8?B?QXVsTG10VllOS01rL00zN3RaY2FQVU9sRmZQcFFEc2I5QlY1bWVFSlg4enY4?=
 =?utf-8?B?Umo2M3h1eWIrMlhnbXE0N2gxaDF2cDhHNmJ5SmJQY1JZWER3a1dnMzNZTE9V?=
 =?utf-8?B?QkJWN0w0WkdQcThuMjdMN0xra3NOZkdVMG02TW9OaU93UWRQNFpIMjRzWGpQ?=
 =?utf-8?B?WnM4OG8yRmFjdHIwRmpsUUgwcGdLUlJibEt6VlFqRHlsVlpBdER2dlZRYUZm?=
 =?utf-8?B?ODcvTWZ5Ylp5eGVXcXkwN1IwVFBQcFVNK0daMHlSL0VtV0hJb3kzOUlJRzJr?=
 =?utf-8?B?RXFLR2Y4clN4OVdEeGw4SG51NWlzTU5ndlBLbG1Lb3RhZ21hUmUxUmpsMldX?=
 =?utf-8?B?eERuWTNsUTRpN3RWVlp0WDZDQXdYd0dRNXIwMnBEclRwTG8vcy9kaWFjdlhZ?=
 =?utf-8?B?ZXVrWE1CVjVTSnY0NlhSNHJLRWdkbzVVUDRwQUVTejJGaDdFbEM3MHpMWHgv?=
 =?utf-8?B?T3J2Qk9XVU5WSzM3Qy9IN1F3OWJLamRzZ2RXcTM0UTh4SVZZQWJ3Y2IrTE1W?=
 =?utf-8?B?MTZOYlhGYzZERm9WSHNCeHFGSGQwNXQyWGpQbE5LTFlGYzdnQXBqUDBTb2FB?=
 =?utf-8?B?cnRTVkNDMFB5Vm1lWTFUdXVydU5xVkhQN2xrYlV4MnVqQVoxVXhoOVdyaUxC?=
 =?utf-8?B?SFFzdGRDZlYyNGF4emJrLzZ5YUxPVXAwZVdUVXhrZmNHOVJxeHA3WGQ5YzA5?=
 =?utf-8?B?T0pScWtRYTk2dFZwZ05TaXRGSW1QUDMxcTlGRG5LdnltdzFlemVSelBHZThJ?=
 =?utf-8?B?YXNsWUlibHJKR0lMNHNrenFNc3R3aUg2TUcyaXRoZGxQQzNIckhINmVQM0hx?=
 =?utf-8?B?eHpVa29ReXgxOEVsbXc4dzIyclc5WUlqVTQzc0Q1UnVPK21BTTYvWDBCNHQ5?=
 =?utf-8?B?amRkZ2h4NzN4YnM1T2pndEpxY3ZaWnpCdFNrR1BHV2g5Y3dMcjVkV2M5aTIw?=
 =?utf-8?B?YUp4MjY0TUVPTUdwaVNKQkQ0NE9CaURnQkVRU3IzbWdVUEhJNWVyQ3d4TkxT?=
 =?utf-8?B?YTd6N285dFBpSjdrNU9ia0ExeklPdGltVjBGYmhWZ2srMjY4RGhHZDJvU1oy?=
 =?utf-8?B?ZHYrSEdRSHRORU16VXBKS2VObHhESEQvWi9nd1JJRmJvQVFGQ2tySUFWclA1?=
 =?utf-8?B?eDdsditsL0ZrZVRLQVlhL2kxSS9udmwrT2wzcjhZOXI0alo1SUt6Ums5ZXNK?=
 =?utf-8?B?dDhlTmpmOXAySm5PZUxHS29ieDdPaVovUlFhL2JlYm9remVEclZsOXRSSXV5?=
 =?utf-8?B?dlUwZGgxZFpMdGdPc3hiWVJGck1pb0RsK0I3MFRaY29JOC9Qa29COEUzUE1D?=
 =?utf-8?B?T2dQeXMwRW5VL3Y1d2lSWnN5OUFZTks4TzdaWTJ5VWpGK1A3RE41V3NUVkNL?=
 =?utf-8?Q?cY4fO4VChfzYvolS2lLqH4KDc?=
X-OriginatorOrg: talpey.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d1747ff8-518c-41ba-3b9f-08da8c188442
X-MS-Exchange-CrossTenant-AuthSource: SN6PR01MB4445.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2022 12:50:15.3789
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 2b2dcae7-2555-4add-bc80-48756da031d5
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1R5dKumwP97igeQRwKAeiuIcWCJxtqK9fNl3cTANhMsHZB7FKv2oivhLLekMNgDO
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR01MB3863
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 9/1/2022 8:32 AM, Leon Romanovsky wrote:
> On Thu, Sep 01, 2022 at 09:25:39AM -0300, Jason Gunthorpe wrote:
>> On Wed, Aug 31, 2022 at 12:30:48PM -0400, Tom Talpey wrote:
>>> The SoftiWARP Kconfig is missing "select" for CRYPTO and CRYPTO_CRC32C.
>>>
>>> In addition, it improperly "depends on" LIBCRC32C, this should be a
>>> "select", similar to net/sctp and others. As a dependency, SIW fails
>>> to appear in generic configurations.
>>>
>>> Signed-off-by: Tom Talpey <tom@talpey.com>
>>> ---
>>>   drivers/infiniband/sw/siw/Kconfig | 5 ++++-
>>>   1 file changed, 4 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/infiniband/sw/siw/Kconfig
>>> b/drivers/infiniband/sw/siw/Kconfig
>>> index 1b5105cbabae..81b70a3eeb87 100644
>>> --- a/drivers/infiniband/sw/siw/Kconfig
>>> +++ b/drivers/infiniband/sw/siw/Kconfig
>>> @@ -1,7 +1,10 @@
>>>   config RDMA_SIW
>>>          tristate "Software RDMA over TCP/IP (iWARP) driver"
>>> -       depends on INET && INFINIBAND && LIBCRC32C
>>> +       depends on INET && INFINIBAND
>>>          depends on INFINIBAND_VIRT_DMA
>>> +       select LIBCRC32C
>>> +       select CRYPTO
>>> +       select CRYPTO_CRC32C
>>
>> This is against the kconfig instructions Documentation/kbuild/kconfig-language.rst:
>>
>>    Note:
>>          select should be used with care. select will force
>>          a symbol to a value without visiting the dependencies.
>>          By abusing select you are able to select a symbol FOO even
>>          if FOO depends on BAR that is not set.
>>          In general use select only for non-visible symbols
>>          (no prompts anywhere) and for symbols with no dependencies.
>>          That will limit the usefulness but on the other hand avoid
>>          the illegal configurations all over.
>>
>> None of them meet that criteria even though other places do abuse
>> select like this as well.
>>
>> It looked fine to me the way it was, you are supposed to have to
>> select libcrc32c manually to make siw appear, and it already brings in
>> the other symbols.
> 
> He took his snippet from RXE.

RXE, net/sctp and many others, actually. It seems backwards for a
subsystem to depend on a library, shouldn't libraries be there for
selecting? If that's invalid, there are a LOT of subsystems to fix.

Leon, thanks for fixing up the patch. As you observed, I couldn't
git-send-email and had to shuffle it to another machine, and not
surprisingly I messed it up. Appreciate your help.

Tom.
