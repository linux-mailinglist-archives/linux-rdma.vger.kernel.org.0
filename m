Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A92B01F3616
	for <lists+linux-rdma@lfdr.de>; Tue,  9 Jun 2020 10:27:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728104AbgFII1l (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 9 Jun 2020 04:27:41 -0400
Received: from mail-eopbgr60085.outbound.protection.outlook.com ([40.107.6.85]:54629
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727960AbgFII1k (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 9 Jun 2020 04:27:40 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NbsDJT0if/il6LOq8K3XP8RLN7tg4oVsDreH99qqUfPx1GCLRgQ4VymgU7WO4Kwk6COxvvH8k73qkRtufkOowdaJOFRtxxK/P+fE7I6kZQu/hhVhl7LNREqVfUohF9mmZSZV0BCBK5S7l28gTs05RZg+01KdZoFFtVxoL35tukTtfP6MTg/c3t44avHG+lLkNcsvW7sNejssxsGy2ws4Xn6ETXg6WOi6X23Qk9mBRu6b6TQlAj59gtVTBsQEUp181pzf0+48asQ7OQXFNj+DaaAvXhVmRSN/xRPIxLoF+OoNG77auvr8D03i4TW+MsaFo3SXddRHPHm+fWDxF5I3/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lp86TbHuYnH/mNAJLaBXhvd7L+LKjlg7Bv8p/+kfA+4=;
 b=BkyR1LUs3S+d89mUU41W7WgeAmd/ywDajUU2TfnfxpOQ5wz62T3ldyzsgR+mU6ZQ19SIBnay+mNWvJI6D55EN/vMjPVI+MLDSj3fU/MteQ9ZtfvHlroZimBEdLMrFR2SfmNAnBVxlC2/mo3JinVWyUAVe1+o8elfMdeKGSvPZkV9lmN+8d6hDoOMzVUeZ+9Sq6sYPTqOmnIk/1qFzPesV6EsLVNonTeGff4MiSpFLIqezIK4L7F6Y9A4cIhdyKNL9dK1M05DgqzVCM5vnsFAMe0Gq3ZbJq+HqgtAWATAFodGv4KXIOT0x6FUl1dDt7SIYu5KXfy1rvEyWQOtNsjmqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mellanox.com; dmarc=pass action=none header.from=mellanox.com;
 dkim=pass header.d=mellanox.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lp86TbHuYnH/mNAJLaBXhvd7L+LKjlg7Bv8p/+kfA+4=;
 b=LiJC/xOGqhpp+rZMUhQ1vwafqfi61u7np+OPr1B2ASmvS6fAEDwesTs/SwZTyfDcqHonCiHBFkFYfPn3rnKFgzpgGPxZZjt9QNiaQLtcllMHIySJeqeHAeSiNUJfLx99NwjEno5zbXCdsPuhqnQlTzgjTi+qIvSqICBHEC2gpH4=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=mellanox.com;
Received: from AM0PR05MB5873.eurprd05.prod.outlook.com (2603:10a6:208:125::25)
 by AM0PR05MB6548.eurprd05.prod.outlook.com (2603:10a6:208:13c::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3066.20; Tue, 9 Jun
 2020 08:27:36 +0000
Received: from AM0PR05MB5873.eurprd05.prod.outlook.com
 ([fe80::8dee:a7a1:5eb4:903d]) by AM0PR05MB5873.eurprd05.prod.outlook.com
 ([fe80::8dee:a7a1:5eb4:903d%5]) with mapi id 15.20.3066.023; Tue, 9 Jun 2020
 08:27:36 +0000
Subject: Re: [PATCH rdma-next v1 11/11] RDMA/mlx5: Add support to get MR
 resource in RAW format
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Leon Romanovsky <leon@kernel.org>,
        Doug Ledford <dledford@redhat.com>, linux-rdma@vger.kernel.org
References: <20200527135408.480878-1-leon@kernel.org>
 <20200527135408.480878-12-leon@kernel.org> <20200529233121.GA3296@ziepe.ca>
 <20200531095414.GE66309@unreal> <20200601122646.GA4872@ziepe.ca>
 <20200602062118.GC56352@unreal> <20200602122702.GB6578@ziepe.ca>
 <20200602132303.GC55778@unreal>
 <703aa4a6-9c00-34f8-ce5e-5eb54180ed70@mellanox.com>
 <20200608114654.GS6578@ziepe.ca>
From:   Maor Gottlieb <maorg@mellanox.com>
Message-ID: <7840e2c7-8e9a-834d-b199-b1ebfa31fee3@mellanox.com>
Date:   Tue, 9 Jun 2020 11:27:08 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.1
In-Reply-To: <20200608114654.GS6578@ziepe.ca>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-ClientProxiedBy: AM0PR04CA0003.eurprd04.prod.outlook.com
 (2603:10a6:208:122::16) To AM0PR05MB5873.eurprd05.prod.outlook.com
 (2603:10a6:208:125::25)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.100.102.11] (93.173.18.107) by AM0PR04CA0003.eurprd04.prod.outlook.com (2603:10a6:208:122::16) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3066.18 via Frontend Transport; Tue, 9 Jun 2020 08:27:26 +0000
X-Originating-IP: [93.173.18.107]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: d8bd0a39-4345-4171-4154-08d80c4ef6eb
X-MS-TrafficTypeDiagnostic: AM0PR05MB6548:
X-Microsoft-Antispam-PRVS: <AM0PR05MB6548CC88173842E6143F6DD2D3820@AM0PR05MB6548.eurprd05.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-Forefront-PRVS: 042957ACD7
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7IGrCIYhaS9rIxWF4CrVA9KcuPXAQQNPgNUNHBAI7cztvyTWFE8sSj83+kDJtzkA8NdUR+YgA7JUdEhs8r+ETQVJUpKdmOrPASRC8oRzYj7gbdXCiuSt5sz7gtKYtII5OzBV9E7Jol4+tdqv4sUDbMwp83eyShV3hudhxH5VVjGycIY6qhoMPy4c88FiVtT8+tK4gyzMDDNhaN5fi6TwOQ0kmrAgwK34i2+pZSvaADZW6raL8XMSz8CdoQY/JyTJCwqW3cU5iFI6tVGob9EQDh1u5M/kmjOkgTSg66Epjd44aa6wXXnqUIe2MaBAAOqJP6gE/dhf/SvjFrdwYajZwd3JfvrytRy003kxNsQbxisp2bi0zVLPhBbE/pr7zETN
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR05MB5873.eurprd05.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(136003)(366004)(376002)(396003)(39860400002)(346002)(31696002)(6916009)(66556008)(2906002)(66476007)(54906003)(36756003)(66946007)(316002)(6486002)(2616005)(5660300002)(6666004)(53546011)(52116002)(956004)(83380400001)(4326008)(26005)(186003)(16576012)(16526019)(31686004)(478600001)(86362001)(8936002)(8676002)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: UMdxUJi1PnJDnLnIxGsMdwBfiuVFumoLSQsCGVTH9203inlBD6Blb1qKTuIBaApgZjba2No4sWoOQpTJvtr5DyG4h0uuIyadQ0k3KGSRJgE2ohidGgbcAqNA1H9e1k5hOV17WzKVnx3GE+S4MbBzOapSfkOli48n/lTLTAktGhyQXPkhCLKqPeWs6pDdhGuvRTNjtXUKAK7M29iM6+ehDchVekPNUoQ55Iyu9XDxjCofIOVFovlxNhIKTliIFnPrRzlTuv5YtltbbLZFHaeBN0owcfl2lgCpWefevsfR/9qF8Ljw9kxpEzkOsVO+ItIjE/ZeEbu44Q3N4ABJhEW8PER/2ewLsM8LkQ8sg4Jn6KkAUM9tnmEZLzq+OcVfzrCsP8WG1eOCYsEhzTtvSZyvEuBg4XoCuYIcb5CilRXngKwbZGOeLWIKGLQgJrq5+0E6RDW2JkD12gTNEfxciNARletRI0CC1Q7ZjyC3K62bgxaJSqlswMgUrJtcz0en6bwg
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d8bd0a39-4345-4171-4154-08d80c4ef6eb
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2020 08:27:36.7337
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EskWaMUW9x5ZUzhsT4QfppdBFak2fLvcAo4NKSg3ryFaCzPSIp0S+mzvyfF1m8aNEUlPFmZwVoEm0QGwDAgoPA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR05MB6548
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


On 6/8/2020 2:46 PM, Jason Gunthorpe wrote:
> On Sun, Jun 07, 2020 at 11:47:11AM +0300, Maor Gottlieb wrote:
>> On 6/2/2020 4:23 PM, Leon Romanovsky wrote:
>>> On Tue, Jun 02, 2020 at 09:27:02AM -0300, Jason Gunthorpe wrote:
>>>> On Tue, Jun 02, 2020 at 09:21:18AM +0300, Leon Romanovsky wrote:
>>>>> On Mon, Jun 01, 2020 at 09:26:46AM -0300, Jason Gunthorpe wrote:
>>>>>> On Sun, May 31, 2020 at 12:54:14PM +0300, Leon Romanovsky wrote:
>>>>>>> On Fri, May 29, 2020 at 08:31:21PM -0300, Jason Gunthorpe wrote:
>>>>>>>> On Wed, May 27, 2020 at 04:54:08PM +0300, Leon Romanovsky wrote:
>>>>>>>>> From: Maor Gottlieb <maorg@mellanox.com>
>>>>>>>>>
>>>>>>>>> Add support to get MR (mkey) resource dump in RAW format.
>>>>>>>>>
>>>>>>>>> Signed-off-by: Maor Gottlieb <maorg@mellanox.com>
>>>>>>>>> Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
>>>>>>>>>    drivers/infiniband/hw/mlx5/restrack.c | 3 ++-
>>>>>>>>>    1 file changed, 2 insertions(+), 1 deletion(-)
>>>>>>>>>
>>>>>>>>> diff --git a/drivers/infiniband/hw/mlx5/restrack.c b/drivers/infiniband/hw/mlx5/restrack.c
>>>>>>>>> index 9e1389b8dd9f..834886536127 100644
>>>>>>>>> +++ b/drivers/infiniband/hw/mlx5/restrack.c
>>>>>>>>> @@ -116,7 +116,8 @@ int mlx5_ib_fill_res_mr_entry(struct sk_buff *msg,
>>>>>>>>>    	struct nlattr *table_attr;
>>>>>>>>>
>>>>>>>>>    	if (raw)
>>>>>>>>> -		return -EOPNOTSUPP;
>>>>>>>>> +		return fill_res_raw(msg, mr->dev, MLX5_SGMT_TYPE_PRM_QUERY_MKEY,
>>>>>>>>> +				    mlx5_mkey_to_idx(mr->mmkey.key));
>>>>>>>> None of the raw functions actually share any code with the non raw
>>>>>>>> part, why are the in the same function? In fact all the implemenations
>>>>>>>> just call some other function for raw.
>>>>>>>>
>>>>>>>> To me this looks like they should should all be a new op
>>>>>>>> 'fill_raw_res_mr_entry' and drop the 'bool'
>>>>>>> I don't think that this is right approach, we already created ops per-objects
>>>>>>> o remove API multiplexing. Extra de-duplication will create too much ops
>>>>>>> without any real benefit.
>>>>>> If there is no code sharing then they should not be in the same
>>>>>> function at all. More ops is not really a problem.
>>>>> Logically they are the same, user asks to get object property, driver returns.
>>>> I'm starting to think it is also a mistake to have the same netlink op
>>>> and trigger it by an inbound attribute. Are there other examples of
>>>> that in netlink? Feels wrong
>>> I have no idea, don't see it in devlink.c
>> Jason, do you mean trigger the raw by inbound attribute? I don't see a
>> reason why not do that. Netlink attributes used for input and
>> output.
> What examples do you have where the input attribute completely changes
> the output format?
>
> Jason

I don't have. Anyway I am planning to send v2 with new netlink ops.
