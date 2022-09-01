Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0252A5A984C
	for <lists+linux-rdma@lfdr.de>; Thu,  1 Sep 2022 15:19:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229813AbiIANS7 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 1 Sep 2022 09:18:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233383AbiIANSP (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 1 Sep 2022 09:18:15 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2047.outbound.protection.outlook.com [40.107.220.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2102062A86
        for <linux-rdma@vger.kernel.org>; Thu,  1 Sep 2022 06:15:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IE1/uM7/lLyd+u5gjLEcE/oBBhHxHg4ImPZvW/KYMVAJb3VQmNGFF2f9xtbQ5ZGxebJoaDSd0XO5qBNBD/t1dgaFfKZTzvKPsH17asrD/t4jChmh3kya70IQGWzDj3y786/+9F/PfPsXQVcoM/jnkoOA5nZ21h3lykHz61SHpBoJprMjNTabmTM1BeLfV7qbQV/sFWA8CWQGLL+3np1XSkZ9UWaoxdJL3Z0I/GbPfuRmAF8r57bmTnLwUZ9PrPTgDL5W7cKeoDCw3PUw1MSJmj84HAHjFSr04cSMGXml6FY7lun++YoWFuLPh4n8lxi8Cp64+VCRD8Xj4nYDOTjBpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5stEUQnugzUD+VKkRa/cwhQ3OasqZkPLCT86/ajX1R0=;
 b=FIDVA+agTn6eAFfjNjVbEdnljqRKMv4hB/4gkdGJ4esvIXdR8IfZlfqxjIrriA8YXdITaCtyBS+hveUqiyBVBjwXtxtlB24jOePsytwlehbKgy7pdHbSTV9moMzzcPypfe8muw4gwDgzfA9jcXcG76ZZ+TIERxYejTibJClMR2IGk2Zh0Owlgg7ZxA5EWpHneueXZrXRTAIaVFfsRKC8mjsNkpnG8anKgSf5M/L0cjGluXB/hGNq6zlCiYDr1JtpRFFiZDofxT+b3Cgu29oR2W8i5juGSH8Rj97Sy+zQ52qP2O6FzhEd4srb0Guob1mbnW7BL8saPwkRvGvME5sEMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=talpey.com; dmarc=pass action=none header.from=talpey.com;
 dkim=pass header.d=talpey.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=talpey.com;
Received: from SN6PR01MB4445.prod.exchangelabs.com (2603:10b6:805:e2::33) by
 BL0PR0102MB3491.prod.exchangelabs.com (2603:10b6:207:38::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5566.19; Thu, 1 Sep 2022 13:14:40 +0000
Received: from SN6PR01MB4445.prod.exchangelabs.com
 ([fe80::701d:e406:dcfa:118b]) by SN6PR01MB4445.prod.exchangelabs.com
 ([fe80::701d:e406:dcfa:118b%4]) with mapi id 15.20.5566.021; Thu, 1 Sep 2022
 13:14:40 +0000
Message-ID: <218bfa70-6ab9-979d-c98a-88b7bae02a24@talpey.com>
Date:   Thu, 1 Sep 2022 09:14:38 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH] RDMA/siw: Add missing Kconfig selections
Content-Language: en-US
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Leon Romanovsky <leon@kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Bernard Metzler <bmt@zurich.ibm.com>
References: <d366bf02-3271-754f-fc68-1a84016d0e19@talpey.com>
 <YxCkwzWMtiTkNYZO@nvidia.com> <YxCmTuxZzCiCRUbW@unreal>
 <6dee3f9e-f896-c31d-557c-f7a76574b41c@talpey.com>
 <YxCqzJtLdX85Agg+@nvidia.com>
From:   Tom Talpey <tom@talpey.com>
In-Reply-To: <YxCqzJtLdX85Agg+@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BL1PR13CA0300.namprd13.prod.outlook.com
 (2603:10b6:208:2bc::35) To SN6PR01MB4445.prod.exchangelabs.com
 (2603:10b6:805:e2::33)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 37711dbd-65cb-4d55-a05e-08da8c1bed75
X-MS-TrafficTypeDiagnostic: BL0PR0102MB3491:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AC+YpdAlWLznWT0+WrAx1OuDwuHaPcZR++syB0nb4OHruNATmGOy22U7tW41h9z0PsISuWA3FxDp5ChnBkT6w0CPjF8GN4qrGwSup7s8U4UqZRa1sKae6/AnIvciT/60aRSGKmMt96932VDiBFUwT6dPy0Pf+dGzCrJReixGJQW9BCwIOMxnwk7BTOmTeDBAxjYn5MCQUHQLRqJhMbzZr76hexikrNCj+dFOOBv30jlT8nyHEaAv5Xj9LPcKqKt9vcYr4tcCH56bbkFywAzDs47xKCQrnmMbRj0pzioKkWubGhnOxjJqOHV4oNtit8bfwj2E7rIRRMsyVBPY49uD0Sqyj5vB7b6HjZsVDnoFOc53Hp3Zjy5Olwq6VpFEZU0X4i2wIHG597IggSt9SCKwl5rRk0e4Fqa48POpLEQSrDDHiXPobU8DlIYnno+ZQciHTafRkpOTNS7Lyh5pTNgbjcevXR2sqmNLHO8P6vO7tkduh799+sSNfB6AhYFBEcVg5Aw44IlkxgEnv6ll2hbBDx1tfz5ag8jFJ88+2AMl1b8n53mrX7T1zYHBuNJrJ13g0kf4R+mTYo11bspoElUR0xFkVfKgGLcCBb6mnVgcYjQg2T6KdLY2Tuirmwd+gDlYFL1qzmrleLjOo+2kILyUJjr/IVvPm2YDOw13rqgOFse9HB0zbdF8iw/ABOYEtvNv0WKvzQvwgDM2tOIvz8V62WPMCrkR+IWuIsnl1STtw7T69PzxmjSdsT9Z4Y0+pObrujRjlS6dxKPt/+c/y2ekkY6wsgGGclPP/V9L04S0hKc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR01MB4445.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230016)(346002)(39830400003)(396003)(376002)(366004)(136003)(6486002)(4326008)(66476007)(86362001)(31696002)(38350700002)(478600001)(66946007)(66556008)(41300700001)(38100700002)(8676002)(8936002)(5660300002)(54906003)(2906002)(316002)(6916009)(2616005)(186003)(26005)(52116002)(83380400001)(53546011)(36756003)(31686004)(6506007)(6512007)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QXA0dnVUU3RlWDVtR0h1d1hFaStTSEZsWEdJOEdoZ3FMYWtXUTJBTGxDbFFu?=
 =?utf-8?B?bEtjWHErRmxPa1hvM3B0YXhINkhOa05iWVJxcTFIWThCUjJDeFJ4SnE3NDhM?=
 =?utf-8?B?WTNVclE0VldXb0xnd1lGVDR6Z3Z5TTgvNHo2b2lTRUkybE81ankzOUgzLzhq?=
 =?utf-8?B?d1pUMFV2VWp4ZUwyV3Y4YzduOUdxV0hrYjVzY2tKVjBGeFRwVXFFcmgzZmxw?=
 =?utf-8?B?UzVYMlcvODdUVmZvaVZpazBOcmt3a3U1bk9VYzRid2o2cmJsbmJwL3EyN3ZT?=
 =?utf-8?B?dnhBbHRvMlErYWdjbWdzQlRjYUNyY1U1NnhoY0lEa1BIWFBvblkrRVdjd3lG?=
 =?utf-8?B?U04xbWl5Q0NCZGp5VkQ2U0ljNnAwMGtlQmJTOUZQOUpiT0tIazQ2bDVnUzQ0?=
 =?utf-8?B?YmxuZisrVEJudkxFUCs0WjJvWjVPYWtpRzVGVzVLZFJKWThLOWJtSUhSQVli?=
 =?utf-8?B?ZHppTnJXMmFxY05RWUlqdDBocThHeDJxOGo2ckNMZVFFRG1lSVcwdFFtR1JG?=
 =?utf-8?B?Q0NMaUtLVnh6b2VnTFZ3czArUmlqSXd1bzArbVJic01RRUx5V0xYTjlUY1E4?=
 =?utf-8?B?amUzWUszejQ5Q3FuUVg4dnpXbENxOVdla3RHQ2l0dG4rOGl6dzRyWlp4M3JN?=
 =?utf-8?B?VklpaXdDNlpZem0wb09BSVFJRjkvbXcvdGtQSWdtOUg4M2hKcm1aM1FpM3V3?=
 =?utf-8?B?a2Vyck9OMy9SaURkcGRLS1E3c2c2VGdIZVdna3R2dUNPWE1nVXg2ZVFZaVVL?=
 =?utf-8?B?b0RUZE50dVp1Q05rTjBTR1g4SE1jNVBRVEZidkR1TUlXVWlSU3JSMVlOOTBj?=
 =?utf-8?B?REJqUG1IRVhhaEtGSVUxbTFCNlMzVzczbnlkckZ5VGIwbFZ6WEFUYmE5eUZZ?=
 =?utf-8?B?TDNReDRVVi95TG80WjB6dk93NzJLWTg4eGJnQlY1Y2FScE1uZEptalcxdlcr?=
 =?utf-8?B?WStIVjR3SE1PYXNVM1NjQzV1ZXovZ1JDUUZSZm1GQTl4SDRjeFZRdnk5MTY2?=
 =?utf-8?B?bnQ3cGZ1bUQzRWVwWjQra3hVUXFNODVuQWdueTIxdmpUajIrc1hlSnVHRDNl?=
 =?utf-8?B?eTNqb2w1dzZobVdrSG5WRHVWemszdGVoS1U2bTlkZkw5aytSNXJWcFpjcFVX?=
 =?utf-8?B?STNqalh3U2VoenVJYSs2QWFVMkV1aTZhSk5rN1JXeE43dHkyRWJKNUlXYUZs?=
 =?utf-8?B?MWU1OFpvbkhVMGdNanR0UkpqS1NnMjJZdDJFS0tHbEV5WklHWGdlR0U4Rlh6?=
 =?utf-8?B?QitLMUFHTU12cU1sQWVlQjBUaHM0aS81aGMrQmtUUXFMSnNZbmpjb0ZDNnV4?=
 =?utf-8?B?N1d2SGJNNllsRDBWdmFnenNGRVROQjRCWGFqZFQ5TWRFNTJpVkpxMUhFS3Q3?=
 =?utf-8?B?RmRkT2NidWpmN01DVEdUNEtUbng1UmZ6bC8zeCtCNWlkVDM2MTN3Nk5sQ255?=
 =?utf-8?B?RHBjRnMxWVFraHYwSUdETGRYUkk1MzlyeXNaY3R3Q1krRHJ4VHRGMC9UQ3A5?=
 =?utf-8?B?WHRDOVR1WmVCV016T0hnNWJKd2dJcmVjOW1PYWNsWjBaSElGcWw0V2tUMlNm?=
 =?utf-8?B?S1BhK3ZtM3A3dG5xcVlCMjdkb3JGNTdseFFQMUhqTDc5RTkwRHZ5MWcxWGZI?=
 =?utf-8?B?SU9iT0padTJONFRRdnZRcjlNVU5RbisrU0hVeUVPalJhdzdacmxOa3JGa0RU?=
 =?utf-8?B?OXlnT21ka1RlZk1uaTREeElHNUhXb1d3WDZ5blFiZ3JyazEzdVNaUW8yaG1X?=
 =?utf-8?B?Nzl0dE80elB6dkR5czJCNUExWm5UbjN2dzJ3UWQ4NG9rV3A0RE5ZVHdmMXZo?=
 =?utf-8?B?SnRHb0hOdzVpOFpubUFFLzBHbVJkMTFLQXRSdFBLSE9wK2ZpUGM1TzVwSXBQ?=
 =?utf-8?B?cmk5amF4WkprcVVQajZBVmErK21ubXVGSlhWaG5MQzhpQThQWDF1ejEybjVh?=
 =?utf-8?B?RVhaUFhBb2tTd2Z3NFpxb29qb1N1a3hWS0ViWlo1MzhiUGZORHJGdlRIY0t4?=
 =?utf-8?B?cStzK1JJTU1CbGozc1FSbDVyVy9UTzU1YjhVSWZYejhvTGNjNjk1bFkvdDJo?=
 =?utf-8?B?a0xoRkk3dFdTY1p0eUhFeVM3czhpZ0Fud2g5NThMbTU0YkFsMGhXcVNnWDV2?=
 =?utf-8?Q?wELjr8TUU6KTWh2OWNxEBujMP?=
X-OriginatorOrg: talpey.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 37711dbd-65cb-4d55-a05e-08da8c1bed75
X-MS-Exchange-CrossTenant-AuthSource: SN6PR01MB4445.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2022 13:14:40.3354
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 2b2dcae7-2555-4add-bc80-48756da031d5
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VelA8XjkkwV9RnIdMtio0P39eFqyxoiTq6Dh3mFrm4n7rR6wKE0p3OtklgU/0zao
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR0102MB3491
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 9/1/2022 8:51 AM, Jason Gunthorpe wrote:
> On Thu, Sep 01, 2022 at 08:50:12AM -0400, Tom Talpey wrote:
>> On 9/1/2022 8:32 AM, Leon Romanovsky wrote:
>>> On Thu, Sep 01, 2022 at 09:25:39AM -0300, Jason Gunthorpe wrote:
>>>> On Wed, Aug 31, 2022 at 12:30:48PM -0400, Tom Talpey wrote:
>>>>> The SoftiWARP Kconfig is missing "select" for CRYPTO and CRYPTO_CRC32C.
>>>>>
>>>>> In addition, it improperly "depends on" LIBCRC32C, this should be a
>>>>> "select", similar to net/sctp and others. As a dependency, SIW fails
>>>>> to appear in generic configurations.
>>>>>
>>>>> Signed-off-by: Tom Talpey <tom@talpey.com>
>>>>> ---
>>>>>    drivers/infiniband/sw/siw/Kconfig | 5 ++++-
>>>>>    1 file changed, 4 insertions(+), 1 deletion(-)
>>>>>
>>>>> diff --git a/drivers/infiniband/sw/siw/Kconfig
>>>>> b/drivers/infiniband/sw/siw/Kconfig
>>>>> index 1b5105cbabae..81b70a3eeb87 100644
>>>>> --- a/drivers/infiniband/sw/siw/Kconfig
>>>>> +++ b/drivers/infiniband/sw/siw/Kconfig
>>>>> @@ -1,7 +1,10 @@
>>>>>    config RDMA_SIW
>>>>>           tristate "Software RDMA over TCP/IP (iWARP) driver"
>>>>> -       depends on INET && INFINIBAND && LIBCRC32C
>>>>> +       depends on INET && INFINIBAND
>>>>>           depends on INFINIBAND_VIRT_DMA
>>>>> +       select LIBCRC32C
>>>>> +       select CRYPTO
>>>>> +       select CRYPTO_CRC32C
>>>>
>>>> This is against the kconfig instructions Documentation/kbuild/kconfig-language.rst:
>>>>
>>>>     Note:
>>>>           select should be used with care. select will force
>>>>           a symbol to a value without visiting the dependencies.
>>>>           By abusing select you are able to select a symbol FOO even
>>>>           if FOO depends on BAR that is not set.
>>>>           In general use select only for non-visible symbols
>>>>           (no prompts anywhere) and for symbols with no dependencies.
>>>>           That will limit the usefulness but on the other hand avoid
>>>>           the illegal configurations all over.
>>>>
>>>> None of them meet that criteria even though other places do abuse
>>>> select like this as well.
>>>>
>>>> It looked fine to me the way it was, you are supposed to have to
>>>> select libcrc32c manually to make siw appear, and it already brings in
>>>> the other symbols.
>>>
>>> He took his snippet from RXE.
>>
>> RXE, net/sctp and many others, actually. It seems backwards for a
>> subsystem to depend on a library, shouldn't libraries be there for
>> selecting? If that's invalid, there are a LOT of subsystems to fix.
> 
> kconfig is a mess unfortunately, and the crypto stuff is kind of
> weirdly done to be both a library and a user selectable pluggable..

For both CRYPTO_CRC32C and  LIBCRC32C, in the unpatched tree, siw is
the outlier:

$ find . -name Kconfig -exec grep -H CRC32C '{}' \;
./crypto/Kconfig:config CRYPTO_CRC32C
./crypto/Kconfig:config CRYPTO_CRC32C_INTEL
./crypto/Kconfig:         support CRC32C implementation using hardware 
accelerated CRC32
./crypto/Kconfig:config CRYPTO_CRC32C_VPMSUM
./crypto/Kconfig:config CRYPTO_CRC32C_SPARC64
./crypto/Kconfig:       depends on CRYPTO_CRCT10DIF_VPMSUM && 
CRYPTO_CRC32C_VPMSUM
./drivers/block/drbd/Kconfig:   select LIBCRC32C
./drivers/block/Kconfig:        select LIBCRC32C
./drivers/infiniband/sw/siw/Kconfig:    depends on INET && INFINIBAND && 
LIBCRC32C
./drivers/md/Kconfig:   select LIBCRC32C
./drivers/md/persistent-data/Kconfig:       select LIBCRC32C
./drivers/net/ethernet/broadcom/Kconfig:        select LIBCRC32C
./drivers/net/ethernet/broadcom/Kconfig:        select LIBCRC32C
./drivers/net/ethernet/cavium/Kconfig:  select LIBCRC32C
./drivers/nvme/host/Kconfig:    select CRYPTO_CRC32C
./drivers/scsi/Kconfig: select CRYPTO_CRC32C
./drivers/target/iscsi/Kconfig: select CRYPTO_CRC32C
./drivers/target/iscsi/Kconfig: select CRYPTO_CRC32C_INTEL if X86
./fs/btrfs/Kconfig:     select CRYPTO_CRC32C
./fs/btrfs/Kconfig:     select LIBCRC32C
./fs/ceph/Kconfig:      select LIBCRC32C
./fs/erofs/Kconfig:     select LIBCRC32C
./fs/ext4/Kconfig:      select CRYPTO_CRC32C
./fs/gfs2/Kconfig:      select LIBCRC32C
./fs/jbd2/Kconfig:      select CRYPTO_CRC32C
./fs/xfs/Kconfig:       select LIBCRC32C
./lib/Kconfig:config LIBCRC32C
./lib/Kconfig:  select CRYPTO_CRC32C
./net/batman-adv/Kconfig:       select LIBCRC32C
./net/ceph/Kconfig:     select LIBCRC32C
./net/netfilter/ipvs/Kconfig:   select LIBCRC32C
./net/netfilter/Kconfig:        select LIBCRC32C
./net/netfilter/Kconfig:        select LIBCRC32C
./net/openvswitch/Kconfig:      select LIBCRC32C
./net/sched/Kconfig:    select LIBCRC32C
./net/sctp/Kconfig:     select LIBCRC32C
$
