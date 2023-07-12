Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7927F75007C
	for <lists+linux-rdma@lfdr.de>; Wed, 12 Jul 2023 09:56:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230344AbjGLH4K (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 12 Jul 2023 03:56:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbjGLH4J (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 12 Jul 2023 03:56:09 -0400
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2062.outbound.protection.outlook.com [40.107.102.62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D10CE6F;
        Wed, 12 Jul 2023 00:56:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mLIy4AFzTaFIKvJ4k5uaT1wEof7Ku/l9vQGK86mqNfv+eGbULCKPcQNIJ/gHp0/LQGEQbkq8gzkExtQweRF/0gzfCrfSdv/XuTxRrfwfAdU1WY4MDLtxtuQYxKJLjaXjRPvatMUsHvsHoW1RufKDQcCm3C1qhqmJ6Dyvf3zIMmBrLz+6ndsqi2R5WiZ0oiHNwebcI0f/M8yaSYLkveEvfZTRFNFJp//HP0aEl2Z7/QkkoX+hTChrW6Ngz8NLA3S8URxfNBkwNgSlkIwsAadZW/IBxAE8FbCBsutFcl/if5s3V/EoHT6I2iWjZnFkmceGs2CZZN9Cw5CtmqcrhL7Ajg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zxu1LjXWjU/21kD7tQ8ruVeJPHyCbbPIaVK5zNep/wk=;
 b=F2Z7vKsZbYhfJ54T/V2YCz602iVyXnYKJC/0vmZCPTRIttfyDCyD21E7E/JtB185lSLUxqI3DLM6FqIFjfk9nQtpjsaDno41S8qcFTyY5AHeh1ZgnoFWY0h7BWZKccHKrC4RtYH6egx6QdFmcDugYqGK25/QcR659r2kD5LamJAsrB+c+KgkVHn+DbQvd5cqeDUW6I4T2S5NJwfrHfWYBiTXm3n/ZR6Sb7+rfcftikklTFcxAiFzN2JnFHjl3gTiyI266B2cuRZ+3ayg07/OLzTGrSQYWQH8+KhdnDnGui9B4PpDxNAledBoCm48fbCQ4ODDzLDuEDzuYydBXfj3iA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zxu1LjXWjU/21kD7tQ8ruVeJPHyCbbPIaVK5zNep/wk=;
 b=UlxCZvoBJDaxt4JoNws6bA4DyWDe4IomkM/e26a7shbBjJDZXnsjGiTms9lJtngk7WaCwLOwWywYS2liITVRQvNjxJgGlHMCEqKF9GbDGoqrvwwu6smnJQXSGnkqt55+u+vMQP0930dDQfgcgNIAhQO6y/DD3f/V1EQX2agLExg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3587.namprd12.prod.outlook.com (2603:10b6:408:43::13)
 by DM8PR12MB5461.namprd12.prod.outlook.com (2603:10b6:8:3a::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.34; Wed, 12 Jul
 2023 07:56:01 +0000
Received: from BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::669f:5dca:d38a:9921]) by BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::669f:5dca:d38a:9921%4]) with mapi id 15.20.6588.017; Wed, 12 Jul 2023
 07:56:00 +0000
Message-ID: <20f6cbda-e361-9a81-de51-b395ec13841a@amd.com>
Date:   Wed, 12 Jul 2023 09:55:51 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: Memory providers multiplexing (Was: [PATCH net-next v4 4/5]
 page_pool: remove PP_FLAG_PAGE_FRAG flag)
Content-Language: en-US
To:     Mina Almasry <almasrymina@google.com>,
        David Ahern <dsahern@kernel.org>,
        Samiullah Khawaja <skhawaja@google.com>,
        Willem de Bruijn <willemb@google.com>
Cc:     Jakub Kicinski <kuba@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>,
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
References: <5e0ac5bb-2cfa-3b58-9503-1e161f3c9bd5@kernel.org>
 <CAHS8izP2fPS56uXKMCnbKnPNn=xhTd0SZ1NRUgnAvyuSeSSjGA@mail.gmail.com>
 <ZKNA9Pkg2vMJjHds@ziepe.ca>
 <CAHS8izNB0qNaU8OTcwDYmeVPtCrEjTTOhwCHtVsLiyhXmPLsXQ@mail.gmail.com>
 <ZKxDZfVAbVHgNgIM@ziepe.ca>
 <CAHS8izO3h3yh=CLJgzhLwCVM4SLgf64nnmBtGrXs=vxuJQHnMQ@mail.gmail.com>
 <ZKyZBbKEpmkFkpWV@ziepe.ca> <20230711042708.GA18658@lst.de>
 <20230710215906.49514550@kernel.org> <20230711050445.GA19323@lst.de>
 <ZK1FbjG+VP/zxfO1@ziepe.ca> <20230711090047.37d7fe06@kernel.org>
 <04187826-8dad-d17b-2469-2837bafd3cd5@kernel.org>
 <20230711093224.1bf30ed5@kernel.org>
 <CAHS8izNHkLF0OowU=p=mSNZss700HKAzv1Oxqu2bvvfX_HxttA@mail.gmail.com>
 <20230711133915.03482fdc@kernel.org>
 <2263ae79-690e-8a4d-fca2-31aacc5c9bc6@kernel.org>
 <CAHS8izP=k8CqUZk7bGUx4ctm4m2kRC2MyEJv+N4+b0cHVkTQmA@mail.gmail.com>
From:   =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
In-Reply-To: <CAHS8izP=k8CqUZk7bGUx4ctm4m2kRC2MyEJv+N4+b0cHVkTQmA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR2P281CA0153.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:98::20) To BN8PR12MB3587.namprd12.prod.outlook.com
 (2603:10b6:408:43::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8PR12MB3587:EE_|DM8PR12MB5461:EE_
X-MS-Office365-Filtering-Correlation-Id: 13dad3d9-3bb1-4fb2-ad3b-08db82ad6e5a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iWYfIRVRNN/OLGWh4qir717GkJmZvQxIjHLTXvMraOxjygkXAyscm6E2Ic0O3flz6iDtLVWTlPEYxbxp2N1FbX3E3gmShLPpA9M0BMG3rwqvKBAGr6kcV9LEULwDHrjprO0tpzk7UrXvzkvjC/W75qDJ049HLSoKl3xwohd4OOAiQ64l6mT1uNFaMu4EsdjBZsHDkuzEyQ68QbWFrtFEO4EuiSKmxrgaoPJ6WAj+RnluHSK9G14zwuG3DJIL3D9R0IOhyvnKT1Gzi8Cc7txVzYAF167gBCG8pH8VvCBYRg8tDe5cbGTbhv5D5NgEokoJqDrE/PIQZ1DcEuWlt6oAi8kzM4q7iIk6osrljov/kqGFEDd9DyPggu9fS9WbV1KZqV06KUi3532yWkpU6DzgxKT4soOgyKB5V473Sg732Z3VmctYf/Eq3utly0uzH/58SjLCIxfIUxBUqJodAfzpUiqdbVg0P+LdNNrygqWT9YnzboqoXbV7J0ZQcz4lDWobSR52ZQ6/408BZlxpQZqn2hachYQ5+gQH/2Gsav7H3a0hcVodhwqKvd+Owgv5StX4nKOrXpF8Wg30VJ4DfNf59cPfXAul9aFCqMZHhIgpTQxaoQdRh0JMCZbgxN4coVPagfX/xXGPbmiXXva5nxt4ew==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB3587.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(376002)(346002)(39860400002)(396003)(136003)(451199021)(6486002)(6512007)(6666004)(186003)(6506007)(53546011)(83380400001)(36756003)(2616005)(86362001)(31696002)(38100700002)(4326008)(66946007)(66556008)(66476007)(41300700001)(2906002)(316002)(7406005)(7416002)(31686004)(5660300002)(8676002)(8936002)(54906003)(110136005)(478600001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ejQrai9ydTVjcmZqekJ5SnQ4ZmJyZzlTcGFnVG9wZ2p1dHlLc094b09yT1dF?=
 =?utf-8?B?a3FxcHUzZkppMXEvV1pwb0xEcTE2SFIvRTdRMXhBbERMbmFUU0daM2JWakhG?=
 =?utf-8?B?Q0VqYys4MS96cWoxdHh3b0FqRENndFNXSTY3MjBZMFI0bkliM3FzczdHZVFx?=
 =?utf-8?B?ZnhGaisySTVMdDNyYUtQWVRUekd6c3FzTGxwRnRyOHpuT1haaCtLbHAvWVZM?=
 =?utf-8?B?ei9FaDZLK2dXK0JNemJ2bFB3SzdYaUh6QzI2K3p0NG1CRmVETlVFVEE4RW53?=
 =?utf-8?B?SUZYcVY2OEpSSEY4SG5WdzNHRUp0d1FkZGdNSWRGdFY3bjdRS09kQXRMemVs?=
 =?utf-8?B?OHlhZDR0eGVoOHRWQVFkMXE5cjNxRzk5bFJOL2h2NEk1OVlHNlFUczMrYnBP?=
 =?utf-8?B?aDRYY0J0SngyTFY2L3RxT1M4OENIQmZXSU1lMjlaVHhmMjM3M2ZnZEVHNklB?=
 =?utf-8?B?RnlFTTdXTFBEaGJneVFNOVF6T1JtT2ZBODJROHhmYVNhKy9xKy84ay80Q0x6?=
 =?utf-8?B?VUIrUEFYSDdtU0RkVmFpR3Q4ZEE0Y0lUNExCdXZna0d5TmtNa1VXM2Jlc2Fp?=
 =?utf-8?B?bTZGN3RyM0xqcDVuNUNkUkt0RUZ5akJBQXN2Q0d0Slk3azJ6VkNOMytRY2pK?=
 =?utf-8?B?N0JCMEhiWFgwaUxjNWhCaHF3d2FvdENVL2hONXlNclBML0pDMEYzSHJaa3Nh?=
 =?utf-8?B?ZjROanRDY0c4cXR3UDcwbnpkOGY2V2FxYlpLRmFKSzlQbmZsaWJhOFFrMndO?=
 =?utf-8?B?b3NHdkFtbm5MOTExWTV3Y1NaeGhQbnltOTJhMUVDZVN0VHp4ZitnTkdxaUhT?=
 =?utf-8?B?QzZLbGNORTVtUGVRNmc4U1EvK21yK1l5bVc2MlNhN1g0bDZhRW5nTkhxaUxi?=
 =?utf-8?B?cFJjUVpPRDFYK0lXL1JiSGNGWStYeHFwazRmZkNPKzhrNFdCUmh0dnNLZ0oz?=
 =?utf-8?B?eDM0Znk3ak1EREg2TGdrL0h6VlNBVk9oNm14RFpXNFJpM0VUbFlFTEY4Vkc1?=
 =?utf-8?B?K1JMZnlJYXRmc3dUdXk2SWRsTlJXbW8zbERVK3c2ZjUycnFuK09rVG9LcUtN?=
 =?utf-8?B?d1NrSVFkNVY3M2lOWnpCUTc2eklwNzU2WStBK1JuSHJsOVlTcG1TUnhWWm9J?=
 =?utf-8?B?NG91L3JIOVh3QU52Y3lKV0h0Y1VCOXRid1dzSjkwblh2Y3NWdEJWSUk5cUF5?=
 =?utf-8?B?eUE2MGhvTG5LbFZCdXlEVmJGRXBDMjgydkx3ZVB0cnJFS0FqUkhlckoxNGJx?=
 =?utf-8?B?N3dkVWJleFFpS2toUE5GNFVkc2VTNDVnV2Z2eHNFTWxyZEZpQlFSSlNRNy9L?=
 =?utf-8?B?ZWVRVzNGR3RsUmNzMGpNckJNTDVyeGhqYW9CSURIb2dZTGxjUklCdGxtRUZR?=
 =?utf-8?B?VzZtSWJ1OVJyRWRTUWk1eUU3L3k3NzM3bVdnZG1RYWhDbFBSemY2R2JSek1K?=
 =?utf-8?B?bzJSS0crUHN4UUE3bktGTGhnTXo0WmI5TVlUSjY4ZERjaTY1NWZYSFNOZlZJ?=
 =?utf-8?B?VndPVlo3UEFkTURHYjM5S1hjb3N2TlhWckVpVEJiNzh4MFZTZXBCa3hETCtp?=
 =?utf-8?B?SUt4UkJKR1FsbThudG1VdXdBZXBXU0VMNU14VGhreTBYKzFUV3RWNWlNRm50?=
 =?utf-8?B?VDFkNTRUdkR5NmN1eHEzaWltR1BMN0NwU2dhY3E4MW1ueGFTeng5d3ZualFN?=
 =?utf-8?B?cXVtTzFvSDBEUHJqRVp4TEVrWkg1LzFLL3lmalU1Y2JweUN0MEwxZ2I5OXYw?=
 =?utf-8?B?aUxhTlhETzJvMEZ4UWxZQmhHOUM4ZnY1UVZFWFgzb2tkM0o4dVY3ZjNCYVJO?=
 =?utf-8?B?Mmt3OHduMHp2OWY5VEdTOURuVlJBYTZJUnVBWUVXcWxMcVhnU2VNb3ZocTZB?=
 =?utf-8?B?S0lGdmdycWtHY2ZPZmc0VDVIdjJYaXV0Z3JVdlhyVFROTnV2am10Z3orQlBy?=
 =?utf-8?B?cENtb3MxbWJFZVp1Mk5mZ3VyQlRKNzU4VUFXYng5L09xK1VnYnRUb2JReVhl?=
 =?utf-8?B?ajBCUk96UWpWS0I3UmZZZjNoNm5CWUQxQzdldDFrZTBWbHE0VVF3bkxXRjBZ?=
 =?utf-8?B?NTk3bUdKNWlST01iL1IyeEdZM1ZXWEYyTVhNc09STFZPRWhvV1p2WExtSnJ5?=
 =?utf-8?B?cWxHVFVWWGJXb2w2eTdUQU5hMUlXa1dIU2NMakRiVG15TGFxeXV5Nk0rM1Qv?=
 =?utf-8?Q?AzrtZ6K8+axPfE51FqXwp3SElMiLeWjkiJktR/OpYQY4?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 13dad3d9-3bb1-4fb2-ad3b-08db82ad6e5a
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3587.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2023 07:55:59.8406
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Z5ysuSHHzlL1RdE+ciXn6UTbwI0cbg03s8D795ZDjzQm5TMOgCSebA4gmrjTn++a
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR12MB5461
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

Am 12.07.23 um 05:42 schrieb Mina Almasry:
> On Tue, Jul 11, 2023 at 2:39 PM David Ahern <dsahern@kernel.org> wrote:
>> On 7/11/23 2:39 PM, Jakub Kicinski wrote:
>>> On Tue, 11 Jul 2023 10:06:28 -0700 Mina Almasry wrote:
>>>>>> Any reason not to allow an alternative representation for skb frags than
>>>>>> struct page?
>>>>> I don't think there's a hard technical reason. We can make it work.
>>>> I also think we can switch the representation for skb frags to
>>>> something else. However - please do correct me if I'm wrong - I don't
>>>> think that is sufficient for device memory TCP. My understanding is
>>>> that we also need to modify any NIC drivers that want to use device
>>>> memory TCP to understand a new memory type, and the page pool as well
>>>> if that's involved. I think in particular modifying the memory type in
>>>> all the NIC drivers that want to do device memory TCP is difficult. Do
>>>> you think this is feasible?
>>> That's why I was thinking about adding an abstraction between
>>> the page pool and the driver. Instead of feeding driver pages
>>> a new abstraction could feed the driver just an identifier and a PA.
>> skb frag is currently a bio_vec. Overloading the 'struct page' address
>> in that struct with another address is easy to do. Requiring a certain
>> alignment on the address gives you a few low bits to use a flags / magic
>> / etc.
>>
>> Overloading len and offset is not really possible - way too much code is
>> affected (e.g., iov walking and MSS / TSO segmenting).
>>
>> ie., you could overload page address with a pointer to an object in your
>> new abstraction layer and the struct has the other meta data.
>>
>> typedef struct skb_frag {
>>          union {
>>                  struct bio_vec bvec;
>>                  struct new_abstraction abs;
>>          };
>> } skb_frag_t;
>>
>> where
>>
>> struct new_abstraction {
>>          void *addr,
>>          unsigned int len;
>>          unsigned int offset;
>> };
>>
>> I have been playing with a similar and it co-exists with the existing
>> code quite well with the constraint on location of len and offset.
>>
>>> Whether we want to support fragmentation in that model or not would
>>> have to be decided.
>>>
>>> We can take pages from the page pool and feed them to drivers via
>>> such an API, but drivers need to stop expecting pages.
>> yes, drivers would have to be updated to understand the new format. A
>> downside, but again relatively easy to manage.
>>
> I'm glad to see that you're open to this approach. As far as I
> understand, getting device memory in a struct page form would still be
> preferred, no? And the approach you point to would be a backup plan I
> presume?

Well yes and no, if you need struct pages depends on what you want to do.

struct pages are an approach to manage memory regions, but P2PDMA is 
essentially about pumping data between devices.

If your data is for example organized in files on a filesystem then 
having struct pages is a must have because you need to be able to manage 
references, address spaces and so one.

If a pages was acquired with alloc_pages() in a driver then you have 
struct pages, but you can't necessary use them the way you want to use 
them because the first few dwords have different meaning depending on 
the use case.

And then you have the use case where you have for example micro 
controllers using P2PDMA to talk with each other. In this case your DMA 
address might not be memory at all, but rather MMIO. E.g. doorbells on 
graphics hw is such a case as well as cameras and encoders which 
communicate directly with each other.

> Since the good folks on this thread have pointed me to p2pdma to
> address my use case, I've been doing some homework to see if it can
> apply. AFACT so far, it applies, and Willem actually had a prototype
> of it working a while back. The rough approach Willem and I are
> thinking of would be something like:
>
> 1. The device memory driver would be the p2pdma provider. It would
> expose a user API which allocates a device memory region, calls
> pci_p2pdma_add_resource() and pci_p2pmem_publish() on it, and returns
> a reference to it to the userspace.
>
> 2. The NIC driver would be the p2pdma client and orchestrator. It
> would expose a user API which binds an rxq to a pci device. Prior to
> the bind the user API would check that the pci device has published
> p2p memory (pci_has_p2pmem()), and check the the p2p mem is accessible
> to the driver (pci_p2pdma_distance() I think), etc.
>
> 3. The NIC would allocate pages from the p2pdma provider for incoming
> packets, and create devmem skbs, and deliver the devmem skbs to the
> user using the support in my RFC. AFACT all that code need not be
> changed.
>
> AFAICT, all the concerns brought up in this thread are sidestepped by
> using p2pdma. I need not allocate struct pages in the core dma-buf
> code anymore (or anywhere), and I need not allocate pgmaps. I would
> just re-use the p2pdma support.
>
> Anyone see any glaring issues with this approach? I plan on trying to
> implement a PoC and sending an RFC v2.

Well we already have DMA-buf as user API for this use case, which is 
perfectly supported by RDMA if I'm not completely mistaken.

So what problem do you try to solve here actually?

Regards,
Christian.

>
> The only pending concern is integration with the page pool, but we
> already have some ideas on how to solve that.
>
>>> That's for data buffers only, obviously. We can keep using pages
>>> and raw page pool for headers.
>> yes.
>
>

