Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22C4F5B0BDB
	for <lists+linux-rdma@lfdr.de>; Wed,  7 Sep 2022 19:54:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229569AbiIGRyq (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 7 Sep 2022 13:54:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230147AbiIGRyp (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 7 Sep 2022 13:54:45 -0400
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2044.outbound.protection.outlook.com [40.107.95.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC6DF1EC64
        for <linux-rdma@vger.kernel.org>; Wed,  7 Sep 2022 10:54:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cE1oCFp6f3GTZvqd7BXeWjbDbcNkb79Z0GWbflqCOi1H7dfn4Tp9kOyTTmDja3Qh+SB0dWWyPOWeVb6jaewwaM31nNcpnYmKwcqfwR0Kjp6WZM4fCDgrTqYC1laAGcBR9NApVz8c3CpRUjNs9qc9xHHJLqF5b8kcFZJWd8I3rjn4yvcEOnWs0qoIZZSHwAis26MtA5FEK6NcbN5FGVvn/7tUYeV6FD44P3BwKWyKHgJLcgt/MJKqvRvEs3+SaWIpRfEqPoogTZ78SIEOuXQkddMcbyuId2Sq8wsj01+RhYK6C0dT+r3e+BQJ35asN8cy3IRcu+IByBlVS1ku/wHqyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eYgxEbt9RSLWAHWoftjxK5TXBOawW5jbww1XBgC0u3Y=;
 b=WXRvUOfAxifBwe5w6Rn05Mn3xByobxrQT0naWZ+SneSmCo3B/1BNye2GnLo+Twgog1Jk0hKnI9+Fw21rkPn3r8vTKK1SpHP5NyPKwVZrJCg0+39RLqCDKVJx7Oee6Ke+mikvbk3UxPb1hd6QodATBRa003dpzjvUvJRrFD4J3U+QRIW7Tw7jklWL7dZnjPFcKssXGiEIfIB29bMngUoJWI+nAOXoi1SA7h/dyIqjYjFs/hGP38lFxHrsY160PcGXUToFJf4DntITzst+RrhjFBJl+tbdVlJ8+5r+9IbWgrOh5/o8LrFB1I/1IZV+2uLZqnoEN2rcbmB2G0JA7g7K7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=talpey.com; dmarc=pass action=none header.from=talpey.com;
 dkim=pass header.d=talpey.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=talpey.com;
Received: from SN6PR01MB4445.prod.exchangelabs.com (2603:10b6:805:e2::33) by
 SN6PR01MB4704.prod.exchangelabs.com (2603:10b6:805:d6::25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5612.14; Wed, 7 Sep 2022 17:54:42 +0000
Received: from SN6PR01MB4445.prod.exchangelabs.com
 ([fe80::701d:e406:dcfa:118b]) by SN6PR01MB4445.prod.exchangelabs.com
 ([fe80::701d:e406:dcfa:118b%4]) with mapi id 15.20.5588.018; Wed, 7 Sep 2022
 17:54:42 +0000
Message-ID: <bd892203-8137-4ac3-6bb8-2af6c510e88b@talpey.com>
Date:   Wed, 7 Sep 2022 13:54:41 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.1
Subject: Re: [PATCH] Add missing ib_uverbs dependency from SoftiWARP
Content-Language: en-US
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Leon Romanovsky <leonro@nvidia.com>,
        Bernard Metzler <bmt@zurich.ibm.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
References: <4e7574d7-960f-9f92-e92f-630287f1903f@talpey.com>
 <Yxih3M3rym7Abt0P@nvidia.com>
 <0b035368-5da3-73c6-4d6f-1e22bcc70ecb@talpey.com>
 <YxilUf2HbA6PAo59@nvidia.com>
 <3a9fed9c-2ac5-dd78-a63c-5d9dd61d3c7a@talpey.com>
 <YxjLZFX6Akk/r+Ge@nvidia.com>
From:   Tom Talpey <tom@talpey.com>
In-Reply-To: <YxjLZFX6Akk/r+Ge@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BL0PR01CA0016.prod.exchangelabs.com (2603:10b6:208:71::29)
 To SN6PR01MB4445.prod.exchangelabs.com (2603:10b6:805:e2::33)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a91b162c-b13b-42bd-6915-08da90fa0a80
X-MS-TrafficTypeDiagnostic: SN6PR01MB4704:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dmUS1XCTMKnPxF1Kwpjrk/Xan4aYRDmSCyL4jeLMbxrLQxg8/bDkSIViIQLp0iHDNCGzQnNFRIc+UyeEx2wxnLbsC1WksiiI76xblt6cSDdXisbwKmKZq3ICwE1SfKwrWN/+zyT6iNpA6iRFiDNvrgnbyQVcr+z3zLXCL88hmCnFiSyfMa+SHZD+bQMz706cFnu7GVNvI5brPyd8JCdY1nkFTrIfJrKqLn0ufC7mSzWNkdNgKRFL3cmELdKk/f8t510/iJE2ul63jggpQH0kM7Li6UhWmVG7AozxKDG0SpXhs7J4PLbRemMZvBj8JsPwwQ7sBbe0c/sNaFGHj2rx8DNlOeg8vI/oX0wdNtF3s8sJiASFvfeooEWv8MJ4hIO3s8MkT1nWqnyxVBtoNFFXIMrRnQpqtZOvFIdMvqB04jdyqT4vZwSj9jbopKlVTufVsELqmSG/pETLs/srzj92twnyBnv7Re1PS3rG4FpSNz6x48R7KQNKr/1hT1Io7/cVwimwNeha2YBgnUDndRB3pe+MUKdtu4Y7o9TC866PaAJ0A0mJIM6tPtExUtLQqG6E982HrQSXlpTfrktcgAJlq6C7tolLLJII7RoekF82ePX+ediTgLS5eY/eXXMnbkmZjhQMj7HwV6zm8CmdKu8hscvkxeF/V67NG6CVDPKflZw1yj+f+EUnfUVIEnRHX4XJ03v8p37X3CqxSpCiHu0S8sEfx5RQOwbxrIwWxPa0Z4AUi0pZTcgyvsZtVamLyr8mfqLop+PnmDx3hyrkJHsjbUGJTTz+5VkgSkuFC8+YDv8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR01MB4445.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230016)(376002)(396003)(366004)(346002)(39830400003)(136003)(2616005)(4744005)(5660300002)(66556008)(2906002)(4326008)(8676002)(8936002)(66476007)(66946007)(52116002)(53546011)(36756003)(6506007)(31686004)(86362001)(6512007)(26005)(41300700001)(478600001)(6486002)(186003)(31696002)(6916009)(316002)(54906003)(38100700002)(38350700002)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZlNkZXRsYVdKZkxYOGRtancrbndvYnJKeWxaRmpEV0lka29FTDhHYm9DQ3JL?=
 =?utf-8?B?TEZLSzJPSUg4UXZsWStCbXZ1L2FKVDFreitNQ1cvcm5GTUh1bGt2Y1FTTTQr?=
 =?utf-8?B?aGJ3QXRyV2ZjYTU4ZTJlRWFwOE85aVh2MDhyZ3ozeDhBSFo2aUZEcGllcFVT?=
 =?utf-8?B?OHhwTTZRd1JOeHNONjhWUkNybHdXa3h0WHBQV2VneGpnYjdkeHh5WkNjb1BC?=
 =?utf-8?B?R21RNXZpWld3Z0RBa1RVZ21FU0JKY0daY250RWxqb2t6U05kbUs4d1piT3hq?=
 =?utf-8?B?VXNSdDFvbFZtRkMvNzE5K0QvZmtSakhtQkl2Y0p3S0hVMk8zZktGOHlESUFZ?=
 =?utf-8?B?NkxwL2ZZTmRmbnF1UlIzUTNadW1BdXJiVmhtTTY4MGNBcUFpUTh2S1FmRjdC?=
 =?utf-8?B?cjdEKzlTdDQzVWZ2SWtUb25YNk9jVnJhNysyMHgvZGsrTkx4ZUVKSmoxeUgr?=
 =?utf-8?B?V1NWSS9wWVJxYnpRWDMzU1RXdUJ6NUJaWUFmYS83MkZFenZzc3pIOEtTREVl?=
 =?utf-8?B?K3JjZldFSmhDa244TjJiNGdBVDNWSEZoVWhtdGhKUndCbTAyeXY4NkpZZmJ4?=
 =?utf-8?B?YnZHTW5OQ09mMkEwQWtvUXRySWltZHZ5WFRYN3paOEcxUFlnL0hYYW5TdVNO?=
 =?utf-8?B?NkV4bWdUTmd4S3lGdG0zTVB0eHI0alI4NTJ4OGpCbXBWNTI3ZUk4UUlhL2ky?=
 =?utf-8?B?VEs0UzBXY0pvTytJakRFbXcwbE9PcWg5ckUveUFDL25idk90YmF6a01XWUJH?=
 =?utf-8?B?K2JmSzlnbGw0Tk5IS011dkpGb1lPelF2VXlJdVZ5anJmZ1VrSUU4YVpQN09z?=
 =?utf-8?B?UzB5RHpnUnhwMDYxSU1qRGFCNFgrUXZwU0JSUllNZ296bGwzeTdJTHBuSnpS?=
 =?utf-8?B?Mkt5VGk3QXFndlZLc0c4dm44aG44WStJdjVuTDl5Y3NJa2xMTUJLUHdwMlQz?=
 =?utf-8?B?dGplK1J4Z3RaZkYzN28xZTdvV05nbzJQK255aGg0cVNaOXpNazl6aG5qUU1h?=
 =?utf-8?B?R0k0RlE4QmJab3ZHZHE1YVFaT0FvWm1zbGs4UmViOVU2cWpvcmNyQTN0V1lJ?=
 =?utf-8?B?aUFMRkR5a0JMRWs3bFptSmo5MFdLSGxXYkFOUGhoSGpab3N3OGJDUEo2UGE4?=
 =?utf-8?B?WDA5eGVocXdoaUhHRXd2RnBSa3NsWWNJcncwdTczaWNVdTAyRzN0R2FSZ09z?=
 =?utf-8?B?YWFGRHNDWll2ZFB2Tm9wSWlFcHl1Uy8wKzJXOUdSTURRU2szcitXS2lWcExJ?=
 =?utf-8?B?RjhXaU51cExXWmxFWnVlZmZ5TXppSnZIUWkrMnhsTUtpY0FBRGNGMFJLa2NW?=
 =?utf-8?B?SENPaVFlYndyM0NFKytWVnplU2prNEtxYWlrVUFwRk1lNi94dVphNkhvYTBB?=
 =?utf-8?B?QUpyRE1NMlRENGpNMG1TT1NQcnhZTkMyTFBZWFhPRXpvMnRkUlI2WHUyTjlX?=
 =?utf-8?B?U3d5bjluc2NLRmxEdS9qN1VQcW81cXI2SlRXTEpKM0dtNWc0cnJIMHloTnlo?=
 =?utf-8?B?ZWNPb28waG9yYTh4S1hmRjRVSmVEV25zY1VHZW9HV1Y5Z2RUdHpnTFJJRC9j?=
 =?utf-8?B?RlpRUDZsUUJkdjVQTS9vWCtpeFNqeFpWS0NrMnhxU0c3d3BZamNMb1JhZUxB?=
 =?utf-8?B?VFhJSlJBUzZIalFpVU1CT050V3NjVTFpb2o2cUsvdThnUjFlRlY5WlU1NDl0?=
 =?utf-8?B?dDZvVkNBUEhRV3pheThMb2kvNDNQVmdPZEdNdGJnbXFNWnNncUQ2UStRYVV5?=
 =?utf-8?B?MWZ1SmgyS0pRNlFTczZXZldLbEY3ZXgrY0lxVktSK29IL0xVQXlHSzNkdVpy?=
 =?utf-8?B?cnVPM3VxMnMybzFFRmZ0R0F4MEZEMjFQUXI5SENTdjA0S0I1U1lqemx3Y1Y5?=
 =?utf-8?B?NEM5aDFqR3NSUHZkK1VzMGZxekwzRXJ0K2xzbkEwdXhhNzBtRFVvWSs0K3hJ?=
 =?utf-8?B?WXh2THROMGxyUjhjMzJoSzlma0FKM2owVE9HcktMTjhhY2dFV2RtWmc0T0hj?=
 =?utf-8?B?alMzb0dqai9xODdoVEdzUm1XeUNjT0p5YzVqZ25teWdFWjh0eG9qNm9SbHpa?=
 =?utf-8?B?L0hjZXlMd0NNRmtaMXRsc0REY0JNRjI0QUU2b2lWcXlEOUd2b0RtRFZtdEsy?=
 =?utf-8?Q?9QPE=3D?=
X-OriginatorOrg: talpey.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a91b162c-b13b-42bd-6915-08da90fa0a80
X-MS-Exchange-CrossTenant-AuthSource: SN6PR01MB4445.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Sep 2022 17:54:42.2663
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 2b2dcae7-2555-4add-bc80-48756da031d5
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KnA9sRxr6iyvrHb1N2bm6R+DBkrvVPNNKV/xYx9d9j+lZt9rF4K5hdyuxzUAQOSw
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR01MB4704
X-Spam-Status: No, score=-6.1 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 9/7/2022 12:48 PM, Jason Gunthorpe wrote:
> On Wed, Sep 07, 2022 at 11:24:19AM -0400, Tom Talpey wrote:
>> That's odd - your ib_uverbs "Used by" list is empty. Did some
>> module dependency cache force-load it? On my system, it doesn't
>> load at all. With the proposed siw softdep, it does.
> 
> As I said, modern rdma-core auto-loads it on its own. There is no
> module dependency causing it to load.

Ok. I just packed up my test machines for shipping to the SDC IOLab
event next week, so I'll re-test then, and try to figure out why the
patch did change behavior.

BTW, there I'll be working on the kernel SMB3 server (ksmbd) RDMA
support, and testing over siw and rxe.

Tom.
