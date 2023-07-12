Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23BC57509AD
	for <lists+linux-rdma@lfdr.de>; Wed, 12 Jul 2023 15:35:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231721AbjGLNfi (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 12 Jul 2023 09:35:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230360AbjGLNfg (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 12 Jul 2023 09:35:36 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2079.outbound.protection.outlook.com [40.107.223.79])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4D1D1BF5;
        Wed, 12 Jul 2023 06:35:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=asjlWLXSYPWEoV5E8qO6+wDxQPb6SWpk13yzbb3aarXgg8ewHZC7u/MCJP5Wfiq9F6cfZHp/ZjGZ+j5PEMguuj3gdP4AM+FRhfDESHt/wLrCoi+FV78vcvHZVVmyUimCW6vb653jFR1M8GXCbKIMr6CxHlUGHuSKR5X4iLbrojuUhm60mpKIMmVmghPmBZnKiAOOCJnB58SU+EvLtHDwLnJY53R7CtrHe9YY8AfdNS3xCpxnkxbs05+XeqMftwdEPmUPna74l6QPFwTNYUBB03RX8fzEp0A+J1JnQcp6/dart1LU4fUk9Qn7Mtpxc6sPap5m5XcCJZ2MFhj7dfkqkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r/7f15Miumv6lsb1knN02cXFbY1NtpyZ3gG9Oh6qYjs=;
 b=mYWppkxWfvxwvJSYzsWUSboVPEkNwuKCJNg6BnnkXw1ffHerLWbIAfILCRPj0TTL5rzz1UhvDLvPmXWKaBFC6udwDgivKqHTB5Nhd5FuniRclEbdTMZWxTi/2D3jkLhMvPv/mgs5QHEvcYD+t36uuJ0vttRgRaeGBLWrsFqYL2tv4e+yrr5+c8//gB3uPOfeJyKXtHA6MaqNBG9r/8qTzHwsCHOr0/lNyzjX3cZ2Fp3WYMnp/WVE9IxE9wvefFm9oEQp7BktCZWoJH6lM9DgcZ4eLcR44j+M3ux7AojJgnGMV08B4eajHp3h6aSncQk0OIe4R71slYrmXim+HrPN9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r/7f15Miumv6lsb1knN02cXFbY1NtpyZ3gG9Oh6qYjs=;
 b=KVKYm34ydUIx36IB5lDutrI0KLF07gOI8P2FRjEpqZFQmQqxt3mFIiS0mvOqZLKqQKYfRvCSEe/+YYb2PDDytsuxgvzTpvyAqRsFpTXYbHKtiSg58eICirLza4WRGQI5IMccoQhDNXNnbtaSbz4hZwfXY+5SL5p+pqLpff3eNZk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3587.namprd12.prod.outlook.com (2603:10b6:408:43::13)
 by PH0PR12MB8176.namprd12.prod.outlook.com (2603:10b6:510:290::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.31; Wed, 12 Jul
 2023 13:35:24 +0000
Received: from BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::669f:5dca:d38a:9921]) by BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::669f:5dca:d38a:9921%4]) with mapi id 15.20.6588.017; Wed, 12 Jul 2023
 13:35:23 +0000
Message-ID: <4f6e62e0-b4c2-9fca-6964-28cfea902de0@amd.com>
Date:   Wed, 12 Jul 2023 15:35:14 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: Memory providers multiplexing (Was: [PATCH net-next v4 4/5]
 page_pool: remove PP_FLAG_PAGE_FRAG flag)
Content-Language: en-US
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Mina Almasry <almasrymina@google.com>,
        David Ahern <dsahern@kernel.org>,
        Samiullah Khawaja <skhawaja@google.com>,
        Willem de Bruijn <willemb@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        John Hubbard <jhubbard@nvidia.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Jesper Dangaard Brouer <jbrouer@redhat.com>,
        brouer@redhat.com, Alexander Duyck <alexander.duyck@gmail.com>,
        Yunsheng Lin <linyunsheng@huawei.com>, davem@davemloft.net,
        pabeni@redhat.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Yisen Zhuang <yisen.zhuang@huawei.com>,
        Salil Mehta <salil.mehta@huawei.com>,
        Eric Dumazet <edumazet@google.com>,
        Sunil Goutham <sgoutham@marvell.com>,
        Geetha sowjanya <gakula@marvell.com>,
        Subbaraya Sundeep <sbhatta@marvell.com>,
        hariprasad <hkelam@marvell.com>,
        Saeed Mahameed <saeedm@nvidia.com>,
        Leon Romanovsky <leon@kernel.org>,
        Felix Fietkau <nbd@nbd.name>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Shayne Chen <shayne.chen@mediatek.com>,
        Sean Wang <sean.wang@mediatek.com>,
        Kalle Valo <kvalo@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        linux-rdma@vger.kernel.org, linux-wireless@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Jonathan Lemon <jonathan.lemon@gmail.com>, logang@deltatee.com,
        Bjorn Helgaas <bhelgaas@google.com>
References: <20230711050445.GA19323@lst.de> <ZK1FbjG+VP/zxfO1@ziepe.ca>
 <20230711090047.37d7fe06@kernel.org>
 <04187826-8dad-d17b-2469-2837bafd3cd5@kernel.org>
 <20230711093224.1bf30ed5@kernel.org>
 <CAHS8izNHkLF0OowU=p=mSNZss700HKAzv1Oxqu2bvvfX_HxttA@mail.gmail.com>
 <20230711133915.03482fdc@kernel.org>
 <2263ae79-690e-8a4d-fca2-31aacc5c9bc6@kernel.org>
 <CAHS8izP=k8CqUZk7bGUx4ctm4m2kRC2MyEJv+N4+b0cHVkTQmA@mail.gmail.com>
 <20f6cbda-e361-9a81-de51-b395ec13841a@amd.com> <ZK6ktnwIjXIobFIM@ziepe.ca>
From:   =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
In-Reply-To: <ZK6ktnwIjXIobFIM@ziepe.ca>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR2P281CA0186.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9f::20) To BN8PR12MB3587.namprd12.prod.outlook.com
 (2603:10b6:408:43::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8PR12MB3587:EE_|PH0PR12MB8176:EE_
X-MS-Office365-Filtering-Correlation-Id: c717c573-c3bc-4b5b-6c92-08db82dcd7ed
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gCu1P4YhB5vkIS9hHGwaChzMaPDXw2dws2zI1jh+OQ6rKY0TLjZd4N0+h1Wt0zqYTcCCKpO74owWyP9GBOGtFkijlkVR0NaY8zkU76C5xIluxG/xWVAui5wePyFDrGj9uY/OXlFmTOBmqU/4zEXi1xqBbzGBzTE9KdSRfVRwL4p7xoA3SWEbvDTWBHhrzq3hRazl/zyI2Hk5HaiaTJAdfD5oDsntnQfL+sLU1oBWINQZb0TL3ia+3iBCr4ItM6v7t3ZU5g5j+k9L354L2bPXHD9OGfZyoC8SEdf2OLTUoprlq5VLIMsEl1NheiDq+IFSHyOr20pSD22J3NkBDQXcCozZSF4sf7XH/MvJwjXXbHj5JmZZGKhyuO1hYVOY5LcqdrgQAkiGvOZmZfPjONao5tSsTLKL0T3WTQn9yybChaf7RQ8ab2gjd7P0r+VFw1f9ueufuIEl0pIaWPbfmlhHCUeA/YL4DMGSO5yBwciqJKCA6N1pU0gZpbBYMCeM2mrdt8eLJwtQ2o/+T9FKgoGq/MFdG6syThH4CIlUD4rlqbNxUwEssAV6yrqV2ij85aptrVwWx0i0p6Q101Z2S+9nZI1F9lcK2cw5c5KsvdGApfSasFl/dx8xzo5RUgs2zSSjKVbLfMKeQT75djIiUQCCgw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB3587.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(39860400002)(396003)(346002)(136003)(366004)(451199021)(5660300002)(7416002)(7406005)(8676002)(66946007)(66476007)(66556008)(6916009)(316002)(4326008)(2906002)(31686004)(8936002)(6512007)(6486002)(54906003)(6506007)(186003)(41300700001)(2616005)(6666004)(38100700002)(478600001)(36756003)(86362001)(31696002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?M3ZGcUNrYUhGMlRLT3FFaTNJVW9GZmVRY2lzQ1pQZnVORGQzSlFRVTRxVmEw?=
 =?utf-8?B?ZngvcnZ1dkRFek51UUYwdXQrbFVzUVNNVnNUZWM4blg5b3QwZnJsVTd0Qnc0?=
 =?utf-8?B?Mkw1Mk9peXZMaUdRbEJUbmlWS3lRV3ErRWM5aVFFbDJIaC9KTDRXNXJPdEZx?=
 =?utf-8?B?T1RGWURGaGJ6dW9LVXRpN01nRFhvQkxQa2pRWU9IYnJjelRBNEVvNUZZbWsw?=
 =?utf-8?B?dWk1elBCb21kblp2aVZ3akR6Y3FNd2k3L0tVV0JSZytKWFFSMmRXbCtMeTQ2?=
 =?utf-8?B?bjdPU0dCZis3TzJFQzhUM2FrNHVQaE03NEt5bkZnOHU3OThFUzNKeFJ5Ukp3?=
 =?utf-8?B?Y0hINm1rNmFkeXFMa1dVb041cXY1QkhrS3RLaENVNGZNZlZ2Mm1SOVR5UGVh?=
 =?utf-8?B?c25aQndjeDFHbEhITmFTZ1UrekRLMlBLTjQ4RzV3UEwzSUsrZ0M4UGFvaS92?=
 =?utf-8?B?bnEramE5bGRUeHlZTTl5UXh5K2xSM1orY3FNdktycEsxRlYvK1hVN29BdFZY?=
 =?utf-8?B?Q0xQS3ZjKzAweUxzMEZHZXZJcmtVdGVmTHVpRkVIeXcwcUZ4d1I2S05tSVBR?=
 =?utf-8?B?RWRNR0s1S2dncEN2cndvL05BS3BQR3ljemNLSmoyYkZ3dDg0THQvZUM1V1c4?=
 =?utf-8?B?YU9SL2k3cXFXUnhJQlZ3UnNSK1FMWmJuTWVGcXAram5jMm1TMnJlK3I1dUo3?=
 =?utf-8?B?SWlqd1AyaWdOcUZBbzlkc051VFBGeWxmTm9PTlR6amZGdmlyNzBQbVZYVG16?=
 =?utf-8?B?a01USW9YSGlUTS8vWTFNY3R6ZXJENGVJZER5Ry9DbUZaelFYYndrVDBKNGhI?=
 =?utf-8?B?L2lQUUI3MGdlb1orOXdMemIyS1pUdUZLSXByRUxkS2Y5V3VRUVBFeWNaS3JC?=
 =?utf-8?B?TGlTNUdnWm11bURiUC9CSXBCWC9GWnhMaEdOZG5QYWllZEdwMENBWEZobkhJ?=
 =?utf-8?B?b1V3MVpCWHd2dUp4Y25DTHljRkFnR0swQVo5K3IwYmRVNGtEZExXcHlkeUd2?=
 =?utf-8?B?YWdEYXFQZldCMEJZM0ZKSGlDN2p1TzZVNko0UjUzVGZRUDFFS3FjbkJvRGxw?=
 =?utf-8?B?WnNrSU50bWFBOUFBSGxmRUJHYnk5WlRWQ2d4eUpLeEsrTjk5VzdoN1hNMmx2?=
 =?utf-8?B?dCtjblJqcTMybUtRTlg0dVcxcFdIdGxBaFRhekluUThxZHpXOC82S3o4b09B?=
 =?utf-8?B?VHlZSGpCRmYvcTdpMWFqQ0hCMTlObzRlbEFaaDhPMFk0SHJLcXhKRVJLNG9X?=
 =?utf-8?B?SDUwY0JZUGFXMW9aZWh2QzJFS2UyU2d3bUlRZ3kvK1QzUHZPcEVSNDlzbW4z?=
 =?utf-8?B?bUxoYy9sbmtyVnRJcUgwNXdJT2Vtak1zb0NWQ3FGUlVFYlRMcDJlVlNFR2JC?=
 =?utf-8?B?ejVhSDQ5aS96cnBpQnFpVW1NN3R2Tm51WW9Va3BDVzc1T3dPNHdoRHVHTnBa?=
 =?utf-8?B?RWFlcHAvcTVGTTE4S2M3SEI4a01yREpkYjhqdzN1cmhwT1UyQ1NIWHNnS0Jw?=
 =?utf-8?B?bTAzTG15T2FPbG1JMytHcXBXRGtGeXd1a0xpRTF6K0VvMndkNWdaQUlaN1pn?=
 =?utf-8?B?MTE2dmN4bGRSd3FhOTFPdHhpa1dxR05ac3BKclNzVGt4cDRDTHl0WFl3UEMw?=
 =?utf-8?B?d2JLZDFuazRwSll0N2c0QU45OXU1TW5iL3YvVmpTWGcwKzVyN1lHSWtWREsz?=
 =?utf-8?B?eUp2U0Y2enZaSTg5RElMRWJFUnpKdGNnMytCUGVsb0VudjkveUE1enVEa09T?=
 =?utf-8?B?SEtud1BWNGhzR3F0NXJWVG1UM3U1QlY4ODFiOXV4YXNaVDcrTjhtZ2NaemxJ?=
 =?utf-8?B?OVAxeVI5alBTZmdKSjNLdmZsQTZxV05QakRYMTdNMHFxQVJMV2FpbTRJU2oy?=
 =?utf-8?B?NVlmRzVwOEFTV213emZRdGM0R1JxVFZERHFTYTJ5VUtYcmxtSjhtb1Rqb1hq?=
 =?utf-8?B?WW4rakNnYUxHZXBXRCtOMnZmczc5VmNmTVQ0TERCOFNSdkxCK3QzaWIvcFRj?=
 =?utf-8?B?dUZ5SGNtZHdhZGt2SGdIMG4wL2ZyWWFTQTJEWHhFRTV5SVV6Y1VSWGFYV0d5?=
 =?utf-8?B?TDdzREJDbGI3WEtxNVVrdzFNZW9TT0tJZXh1bFUrRHh6bGpYek9zN1M0UTR5?=
 =?utf-8?B?czRqNTdNYnM5YlkraGkwb2xpdzBOeUhJU2xMUU4zOTY0cXBtNWdqeFJXQ1hU?=
 =?utf-8?Q?kRZQK+tfzhVqGr1m+GVX/KuRg6LhMW4WMTl/0v+NgxJZ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c717c573-c3bc-4b5b-6c92-08db82dcd7ed
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3587.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2023 13:35:23.3507
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UMfo3fYuZ3sTEsKLt9cEM06pCt/TNbq8m3e4r+IvZexo7pZGVJE0QjrYOK47OQ6/
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8176
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Am 12.07.23 um 15:03 schrieb Jason Gunthorpe:
> On Wed, Jul 12, 2023 at 09:55:51AM +0200, Christian König wrote:
>
>>> Anyone see any glaring issues with this approach? I plan on trying to
>>> implement a PoC and sending an RFC v2.
>> Well we already have DMA-buf as user API for this use case, which is
>> perfectly supported by RDMA if I'm not completely mistaken.
>>
>> So what problem do you try to solve here actually?
> In a nutshell, netdev's design currently needs struct pages to do DMA
> to it's packet buffers.
>
> So it cannot consume the scatterlist that dmabuf puts out
>
> RDMA doesn't need struct pages at all, so it is fine.
>
> If Mina can go down the path of changing netdev to avoid needing
> struct pages then no changes to DRM side things.
>
> Otherwise a P2P struct page and a co-existance with netmem on a
> ZONE_DEVICE page would be required. :\

Uff, depending on why netdev needs struct page (I think I have a good 
idea why) this isn't really going to work generically either way.

What we maybe able to do is to allow copy_file_range() between DMA-buf 
file descriptor and a TCP socket.

If I'm not completely mistaken that should then end up in DMA-bufs 
file_operations->copy_file_range callback (maybe with some minor change 
to allows this).

The DMA-buf framework could then forward this to the exporter of the 
memory which owns the backing memory could then do the necessary steps.

Regards,
Christian.

>
> Jason

