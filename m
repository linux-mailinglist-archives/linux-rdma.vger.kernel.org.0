Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F9B03D15DE
	for <lists+linux-rdma@lfdr.de>; Wed, 21 Jul 2021 20:05:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230346AbhGURZI (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 21 Jul 2021 13:25:08 -0400
Received: from mail-dm6nam08on2092.outbound.protection.outlook.com ([40.107.102.92]:30816
        "EHLO NAM04-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230498AbhGURZH (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 21 Jul 2021 13:25:07 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BtYgzQPz11ODBe2MYI5PpNgLNeWSSyzUwsDxxykOZSqJTmsxNvXC5d8+8xlXcdB+W+GwIvQvJifcMkwfHPezhZX0Aezsl67MCYQn60g6YctSm8GT3vWvaeQYGrsgzhuwCxMgXODNBJi7VEtsdeHd2NELkpFIX+nWPJ9jTH4dpyQy8pOthbph30lkNrv0Twed+Zo8aQ0jFJRizKu1UQU+nCtfPvmXOT0RT/z/ZaoXu23wHxhz9K+MvzQiGxLbR66WyeSNvPxYEkfdcBfS8CB0hHc5oNi58xB3Gr/WCwCyio8fFYxA1lrg9ddyPnPqExEVmdJh/pTytOWKnfltYLCAPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l5cD0BSMUIOzQDOjEi8UFUmeQWbLWSGCpxtE+PbtrX4=;
 b=Rf23N2uR6wonqFkbo61m1WKwnkMae6qqjtcE1wJ4i34nHK36M3yKk9XtgYxHbvjW7veCi09trUHH3AB84o7DquFnk2ggl9teyjfSBrPx+li4eW2jL5mSjY74hQmu7ApwWhifWOMKz5Kp9I6hYpIueF6RWxcLRg2shckQ2GmUyTU7KcdsRl07DHnrhUbFwWKfGaL2g2a9yXJE6o57cXFY6le7Nf9jPbCFI3Wg1YdrcJIqmZpxGkgr/RMqU/CFUy6/sPbJ1s/4c0TGMm6dzP1K1tkT1gcRAQuWcswIm0hb0YBSxguqFL+VVPtq9RCBAeEjb6Tlyi/SJTJdBNODroBTmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cornelisnetworks.com; dmarc=pass action=none
 header.from=cornelisnetworks.com; dkim=pass header.d=cornelisnetworks.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cornelisnetworks.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l5cD0BSMUIOzQDOjEi8UFUmeQWbLWSGCpxtE+PbtrX4=;
 b=mf+CRuSmF4mmcFp8TUuQPWB1HrT29OCtB3s4MTd4E5lBzfJMlPIDnbN2O1Z16pspChYvDsiQeCUaJSekUZlWGrk8sLgYpQ04hp1C8iQ5sFTUuAErYH7ktDB2QjglAGko77hHDDYfihUSTXmvXLUi4AXW5duphpsUC2mUqRjnO8uvWzW0NDPnLIit0CbMR7okp0+FIxEvW8g6i9icj78s5v1nm2pXvZi43pHY2slf2vCci8ci/cCURbdlEcjsN8iMCI/s4lQZjgOL+JnZ9bcO9mfRdnc9cS6e4hkUnFbxRAszHQRg0svUtX6oxq7K+L6viAgmR38gpewQyhTs0k6WIQ==
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none
 header.from=cornelisnetworks.com;
Received: from PH0PR01MB6439.prod.exchangelabs.com (2603:10b6:510:d::22) by
 PH0PR01MB6454.prod.exchangelabs.com (2603:10b6:510:1b::9) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4331.24; Wed, 21 Jul 2021 18:05:40 +0000
Received: from PH0PR01MB6439.prod.exchangelabs.com
 ([fe80::5c02:2146:2b1:f1eb]) by PH0PR01MB6439.prod.exchangelabs.com
 ([fe80::5c02:2146:2b1:f1eb%7]) with mapi id 15.20.4352.025; Wed, 21 Jul 2021
 18:05:39 +0000
Subject: Re: [PATCH rdma-next 8/9] RDMA: Globally allocate and release QP
 memory
To:     Leon Romanovsky <leon@kernel.org>,
        Gal Pressman <galpress@amazon.com>
Cc:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Adit Ranadive <aditr@vmware.com>,
        Ariel Elior <aelior@marvell.com>,
        Bernard Metzler <bmt@zurich.ibm.com>,
        Christian Benvenuti <benve@cisco.com>,
        linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
        Michal Kalderon <mkalderon@marvell.com>,
        Mike Marciniszyn <mike.marciniszyn@cornelisnetworks.com>,
        Mustafa Ismail <mustafa.ismail@intel.com>,
        Naresh Kumar PBS <nareshkumar.pbs@broadcom.com>,
        Nelson Escobar <neescoba@cisco.com>,
        Potnuri Bharat Teja <bharat@chelsio.com>,
        Selvin Xavier <selvin.xavier@broadcom.com>,
        Shiraz Saleem <shiraz.saleem@intel.com>,
        Steve Wise <larrystevenwise@gmail.com>,
        VMware PV-Drivers <pv-drivers@vmware.com>,
        Weihang Li <liweihang@huawei.com>,
        Wenpeng Liang <liangwenpeng@huawei.com>,
        Yishai Hadas <yishaih@nvidia.com>,
        Zhu Yanjun <zyjzyj2000@gmail.com>
References: <cover.1626609283.git.leonro@nvidia.com>
 <5b3bff16da4b6f925c872594262cd8ed72b301cd.1626609283.git.leonro@nvidia.com>
 <abfc0d32-eab8-97d4-5734-508b6c46fe98@amazon.com> <YPaKu4ppS0Bz6fW1@unreal>
From:   Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
Message-ID: <5539c203-0d3b-6296-7554-143e7afb6e34@cornelisnetworks.com>
Date:   Wed, 21 Jul 2021 14:05:34 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.12.0
In-Reply-To: <YPaKu4ppS0Bz6fW1@unreal>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BN6PR13CA0059.namprd13.prod.outlook.com
 (2603:10b6:404:11::21) To PH0PR01MB6439.prod.exchangelabs.com
 (2603:10b6:510:d::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from Denniss-MacBook-Pro.local (24.154.216.5) by BN6PR13CA0059.namprd13.prod.outlook.com (2603:10b6:404:11::21) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4373.7 via Frontend Transport; Wed, 21 Jul 2021 18:05:36 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3cd50f7d-0a72-4b5c-8996-08d94c7225c7
X-MS-TrafficTypeDiagnostic: PH0PR01MB6454:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <PH0PR01MB645449E59A7987670D9891D5F4E39@PH0PR01MB6454.prod.exchangelabs.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: i7sc8gJs/NeAujUiiExecfWEhxf0S2QwM9xscOKZJPX7TpdJwIohnLzgqQBzmr32nDNclN1nNj4iyAi+RWMlj+ShOCvDge7IG9m/e/kMrGcwsUg9nkYoLGb947vzh6hx/YZ8v+Db2Dn80NcyQNstgmXzEqapfKRcAG2Q3GDrWPGsG7mcihN3JmIiBRuJaS4TXqByAubi14wXSeofwfHGv6MEeUzyNBd35tuArMSkTKirNCwoCfDdSDGBk9U1HcIcjjkxhQhetvVPps+H7I6uALyZQ6Gd4r/k0xVVSEyh0F2PTIkMZxzsoA9csvhCeSAvutpiZId2W/Aay0EJ7EYsMxkbEETFbkWzmNp8ON7DpK14rqYHqbsiZ6cFqWTn3bNc8VhmqaicM5jk6ReGibS/t+aI6h2eWZn7nWHtiedLxaqtDMeZT0JNYtPWbBvLjAGzfxaiQ9sGG3ig0J5YBcgJU1SLPJ2pAwm29xbyVGACp23f4VNTVwoO/eA8h4PMvW7GvXijgFUGgxJRxtrEo4cD+RkqwVDbEL5AtXLy2IrCWtWiKd1OeG7zmLOkgU/xFS4EUUj8LAwQc/jakxo2mOPz/dZLhGQfacF4nAs4S7+Ma024xga0axoSc0SJY32/AOXmLWXokRghHdNE28rohJeAVjXBMEkBymOd7j6VHtp705MYr0J+G0cVv3o1PXJmxc+hCJpZnATAIICdmIeyMISJ/y4jJm5ddDcCwQ1xkbhXv9RnJTSExMxYViGGLaBA8GrpMyehQdD++G13qj4Eyz81yg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR01MB6439.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(39840400004)(346002)(136003)(376002)(366004)(7416002)(86362001)(38100700002)(66476007)(31696002)(36756003)(44832011)(54906003)(83380400001)(5660300002)(38350700002)(26005)(2906002)(316002)(8676002)(66946007)(8936002)(52116002)(186003)(6486002)(2616005)(31686004)(6512007)(110136005)(66556008)(956004)(478600001)(6506007)(53546011)(4326008)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OVBvMWNMRzZJTkFLZ28zWnJOME9ESjVFZDFlZXVnYjdRZWgvYVFucVllNDZz?=
 =?utf-8?B?eHM4cVdScFRMWTJxcGZ5cXFNTnhNWVRjam9qR1lzUm41M1E5UjBiaU1tcW9D?=
 =?utf-8?B?UFpRRXQ3UTIrQlo0ZWlVd1U2UmxYdkJZeFZOby9jWENXaVdMSkR2MjdRV0Vz?=
 =?utf-8?B?WWJPWnVNVjAwanhsUGJyTXBSMndrZFFibzh2RjFOWXRxOEYwS05PTmZWalRk?=
 =?utf-8?B?dko3V3FqNU9HLzlYOGZzM2w5SkNVMFNtQ01LRWxnMFFUYzlHaDhNVHBvMGVV?=
 =?utf-8?B?NHhORjErWkJCV0FXSmZENjYwczFoMFZXdURTak5QRzRFcmxlUFp0dUdUYVYx?=
 =?utf-8?B?ZUJvdDZhZkQya0h5blZXQXV0TC9RNUJXYTdMUk82V1QrcGxpS2dUL3E2NDkw?=
 =?utf-8?B?S2ljN0RvUklFVk05ZVhXT2VtdWdMY0x5NjM3S295ZEY4SnlpSlRQMHJCT1p5?=
 =?utf-8?B?RWZ3R3d1OWlIRE5GbEFPSVh4SGV5bVVtdWxiUVNReVU0OVZjOGlScGNNcWVC?=
 =?utf-8?B?ZG9Gb2kzYVJzbmtocUJQMUdVaXlVQWJSWTh6bStVS0FqR1Vtd0ROdXhiOUlR?=
 =?utf-8?B?aVZqUG1nSzlka1dRd2FUZXhDQ3dSV2pNeXFzN0xvVUMrVXFvaW1XZUVxdmkv?=
 =?utf-8?B?RCtwbFJqNVRBVUZQaGlrS3htcGltN2RBcGxqM0VwQlROV0dhV3kwRzVYS2V2?=
 =?utf-8?B?N2hJSkRQdzRUdTJnSkRERHkwWnEwOEVhcVVoaVlqaVZZYU5qKytiTHpjMEJL?=
 =?utf-8?B?aDgydkxUT2kvakl4TWdjbllEaEJKdGhMS25KSEFVd1RwVkNkWE1oR1cyR1Ux?=
 =?utf-8?B?TE1mQUUwRklOaklxM2ZyYjY1cVpuRWo0Ky81a1o2NXFIc2RPYkZkaWJXdGxN?=
 =?utf-8?B?U055VCtlNjRCUkJhQmJGd25xTm5jY1F3SDdKVDczREc4YlRmUlpLKzB1SHQ5?=
 =?utf-8?B?cTVtZnVYODNKZ0dtRjJGbVFxT0tEM09rV0UvWHVDbUxEaDB5cGJHWXoyaXQr?=
 =?utf-8?B?VktrVm96cVV1SXBFTlFsR3FyN1cwY0RVNm8yRTJpWlRQRFV4dFY3UFJValkv?=
 =?utf-8?B?WjZJTVU4RHgwd3BJQVdaOG9yT051K2JBOTdJbUoxcU9NYUErbkp0Z0RsSnor?=
 =?utf-8?B?MWVWbHYzalZsL21YQVNIOU9UY1Bic2lQSk9rd1lNYk8yMHRNZ2VrTDN5b2lw?=
 =?utf-8?B?aml3U1pWWCt6bWZJVHAvbzR2dkJsM2w5aXBZNHVUZzgyYkZiTWRqamxHYlJk?=
 =?utf-8?B?TU55eWVxK21XR0tuT0xYRjExYmpOQVBUVHBpaVo1a25rbjRWektsemVTc1Nh?=
 =?utf-8?B?dDlzcDNqMXI1RzhER0RGYllYbGQ0Uk5uRUs2VDJxcW9tL0ZCcWJuMFh2K2xn?=
 =?utf-8?B?Z3A4TWErREhBK0pJY1hTV3FCRW8rZmh4clNzOUhyY1NTTmZCMER2RHp4RTJ3?=
 =?utf-8?B?THNTTzZkejJTRXY5cHdpd0h5OGNYOVBPY01lblkzN2tFaVd1TG0wZVo4cUtS?=
 =?utf-8?B?b25aejlBT0JtakVnL1NJaXpTM1hjb2ZHSGlLUzN4Q205VTYrc0syZDBqcGFk?=
 =?utf-8?B?Q0d4cDE0SDVaTGtLSGowdTdEeUp5TFNLN1JGMzNaUGN1a252U2VCaFdTdU4x?=
 =?utf-8?B?ZThrSm9lajFxSnk3cGlwVjhoaG4yaVFzUUY3L3JhaElQdDRvSFdOWUoxVkdI?=
 =?utf-8?B?d3NZcEtXNGk1TGhUWkwwRmFJUUdHZnI4N3dEd1ZrUVljSjE3cGdYV3loQ1VN?=
 =?utf-8?Q?4nDcYCCy0NwaMu4Ncq5BLmyZjqiPwjSE/A3yHer?=
X-OriginatorOrg: cornelisnetworks.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3cd50f7d-0a72-4b5c-8996-08d94c7225c7
X-MS-Exchange-CrossTenant-AuthSource: PH0PR01MB6439.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2021 18:05:39.6558
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4dbdb7da-74ee-4b45-8747-ef5ce5ebe68a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zVminO7+3BM6IFVLuiqHnxa/BqTvr++4al2R0cDPIWwSZOgXBoTC2dWNpydK67Ra3nwpUPctIjw2+HkM16LDNJZMyWAw0Qqim2LXTS312soyiBXMlafUAqeOfFvKFuFh
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR01MB6454
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 7/20/21 4:35 AM, Leon Romanovsky wrote:
> On Mon, Jul 19, 2021 at 04:42:11PM +0300, Gal Pressman wrote:
>> On 18/07/2021 15:00, Leon Romanovsky wrote:
>>> From: Leon Romanovsky <leonro@nvidia.com>
>>>
>>> Convert QP object to follow IB/core general allocation scheme.
>>> That change allows us to make sure that restrack properly kref
>>> the memory.
>>>
>>> Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
>>
>> EFA and core parts look good to me.
>> Reviewed-by: Gal Pressman <galpress@amazon.com>
>> Tested-by: Gal Pressman <galpress@amazon.com>

Leon, I pulled your tree and tested, things look good so far.

For rdmavt and core:
Reviewed-by: Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
Tested-by: Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>


> Thanks a lot.
> 
>>
>>> +static inline void *rdma_zalloc_obj(struct ib_device *dev, size_t size,
>>> +				    gfp_t gfp, bool is_numa_aware)
>>> +{
>>> +	if (is_numa_aware && dev->ops.get_numa_node)
>>
>> Honestly I think it's better to return an error if a numa aware allocation is
>> requested and get_numa_node is not provided.
> 
> We don't want any driver to use and implement ".get_numa_node()" callback.
> 
> Initially, I thought about adding WARN_ON(driver_id != HFI && .get_numa_node)
> to the device.c, but decided to stay with comment in ib_verbs.h only.

Maybe you could update that comment and add that it's for performance? This way
its clear we are different for a reason. I'd be fine adding a WARN_ON_ONCE like
you mention here. I don't think we need to fail the call but drawing attention
to it would not necessarily be a bad thing. Either way, RB/TB for me stands.

-Denny


