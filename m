Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC61F1F0A8D
	for <lists+linux-rdma@lfdr.de>; Sun,  7 Jun 2020 10:48:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726363AbgFGIrn (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 7 Jun 2020 04:47:43 -0400
Received: from mail-eopbgr80070.outbound.protection.outlook.com ([40.107.8.70]:60384
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726192AbgFGIrn (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Sun, 7 Jun 2020 04:47:43 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eV9Nxb/mU89UsnAKadkgpOD7xaw9HbfS5hIq3exGuLQJUFwlu1DTAqzBOksY0eKRuisJXWASRqNB/KVWzQSnpFyMft4UsNSaKMlpV6i0P6Mip02q7umRpbo1ehzX9CTjN0i50YxNkJfg1r2hRTCqkQnKCROIgtzih50XpG39A+wvnJaYhkCtCtLB3XwRJjkfEIMBpkSNGWtWMdefPhFdCFpI+Q+PQyXjaNWjOjk2+Fa7SnNVzEPshnhT6dWnfvavvy+ANZ7BrtxTF/qGUK21wpRFVFfzpCqu+oOkjS+6VeFKrVy4hW43hclCn9Tc6yKYYiu8jtGiEwMrDhwChiyIMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HJ8A4AGkd1TepFIe7ytdOf1g5F0HoSB6O0Qyt5epq18=;
 b=JUtXMirdJzfBfrj2YPGjyrIwpJzu8SOBDLRuvz+aMftmS7dhc97xMiTFE8+Pyfyw+bdiJ7VgS0aSfh3bhMizS+3ri3n1nbQg1hBU4pLUIX7WTjxJwXBtm+ZtBYPQIRe/8G2e2hcCUi+6dLL8ZChwiWZGks5eTL9BkvRTh+D4fn5ELkmHJsyfoCe5t1BUunJkBGF9iG1+hmPK0sEYcKInR4w0wfHwo0a/gTpUMW+IfdCwyn+k204c9EwgzJAmpTlZhI1rjrS5Lvu72Zstiywk0lHSbQhL/3yr/yf1phDZQKiMv1Nf6VhHY6wti5J85hZefrDUdLkxO9yD7lVNOpIhCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mellanox.com; dmarc=pass action=none header.from=mellanox.com;
 dkim=pass header.d=mellanox.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HJ8A4AGkd1TepFIe7ytdOf1g5F0HoSB6O0Qyt5epq18=;
 b=c1FyKFuGY9HT6W8MDhi1cudA0bbFHmXpHRPxX4j5ZiYH6b4SyG/vJlnjZhtdJN+bf64IKfJENQ/oYFymwZYyQxtPUtt1BXIDFSS1vCCastXbH953QeL65u22H07A/qcJJrbMjNc2zmngTPRH6HFdyNfXXJv4xf4SQ87hpZ95GYQ=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=mellanox.com;
Received: from AM0PR05MB5873.eurprd05.prod.outlook.com (2603:10a6:208:125::25)
 by AM0PR05MB4787.eurprd05.prod.outlook.com (2603:10a6:208:b5::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3066.18; Sun, 7 Jun
 2020 08:47:39 +0000
Received: from AM0PR05MB5873.eurprd05.prod.outlook.com
 ([fe80::8dee:a7a1:5eb4:903d]) by AM0PR05MB5873.eurprd05.prod.outlook.com
 ([fe80::8dee:a7a1:5eb4:903d%5]) with mapi id 15.20.3066.023; Sun, 7 Jun 2020
 08:47:39 +0000
Subject: Re: [PATCH rdma-next v1 11/11] RDMA/mlx5: Add support to get MR
 resource in RAW format
To:     Leon Romanovsky <leon@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Doug Ledford <dledford@redhat.com>, linux-rdma@vger.kernel.org
References: <20200527135408.480878-1-leon@kernel.org>
 <20200527135408.480878-12-leon@kernel.org> <20200529233121.GA3296@ziepe.ca>
 <20200531095414.GE66309@unreal> <20200601122646.GA4872@ziepe.ca>
 <20200602062118.GC56352@unreal> <20200602122702.GB6578@ziepe.ca>
 <20200602132303.GC55778@unreal>
From:   Maor Gottlieb <maorg@mellanox.com>
Message-ID: <703aa4a6-9c00-34f8-ce5e-5eb54180ed70@mellanox.com>
Date:   Sun, 7 Jun 2020 11:47:11 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.1
In-Reply-To: <20200602132303.GC55778@unreal>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-ClientProxiedBy: AM0PR02CA0090.eurprd02.prod.outlook.com
 (2603:10a6:208:154::31) To AM0PR05MB5873.eurprd05.prod.outlook.com
 (2603:10a6:208:125::25)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.100.102.11] (93.173.18.107) by AM0PR02CA0090.eurprd02.prod.outlook.com (2603:10a6:208:154::31) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3066.18 via Frontend Transport; Sun, 7 Jun 2020 08:47:26 +0000
X-Originating-IP: [93.173.18.107]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 20534191-ac88-48fc-c225-08d80abf6f13
X-MS-TrafficTypeDiagnostic: AM0PR05MB4787:
X-Microsoft-Antispam-PRVS: <AM0PR05MB47878D5F188AFB47F30FFF7DD3840@AM0PR05MB4787.eurprd05.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-Forefront-PRVS: 04270EF89C
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 31i+8Mx1Ce5MRapVwmrnUmUcyw0NTmLY4fm95qASJHfub9wvD9zdFWb2n7Rt9PCgZK5apYpMo2Y53FbSl0qpyTxkBYDdVPr+Q/JNI8EbF5dk79fkfuYnK69jNpbczWiLrGY+O7Cd69/gcVsYniGmlCy/ezzGQRv3Wj8K4VFIqfQ05jT3XCF8rhT0s7jP6e0JM/HbWAhU18WBAQopDwIELV9Uuhd+ks1wfx8V82gipAndSVUt6HDrBnz0domyNOdBCoaTOOydc9bo3nlN4udbTNxi5jGBbTIFTt6fWLB8Pyh5iJW/GXoQyHh8IEww9rliGvSCYJfQcMeJ2Md24LZMV0jpP5ZvNRSW7rVrhQNhgVHTjqsMcPYAqdUphniAjrsh
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR05MB5873.eurprd05.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(346002)(39860400002)(366004)(136003)(376002)(396003)(8936002)(53546011)(86362001)(83380400001)(16526019)(31686004)(5660300002)(36756003)(8676002)(2906002)(26005)(478600001)(186003)(4326008)(6666004)(66476007)(52116002)(2616005)(16576012)(110136005)(31696002)(6486002)(66556008)(66946007)(316002)(956004)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: qb143oJH2TbPCrgUlkch0CS2tcWpsFYTmWHLK+l+LvADreZCp5EMi9iIskZnvwNEpJGSIsj1jmZpdKYNIvNxLHmJ2bnKsQCkmakewJwqYiR9jUKV95yLSVaVe23esyUNL1GBJ0mqyb8hbFVnDoaGa+jjZ82+kBVgu3w3dqh9EknOW0FnLNJ5QyTCLw9oTDYa0uz/3bqK+iYq0/pjDDi4hYomYnv38/lju1aOokadoa9BCqVgXXguPjQxV+gXuUZYBufoWBXBJkEYbcfH/fiwBGhbGrFqeAgd4Hw9SBJ9a2X9ZP00WmCu5htdLC4fXb5FUjIX5eo9Xvxc7P3t4omZ6gIlARWD36NcryK9Y2uTZ51n3sbVNtkp02zckvr8fiaZ8nHtZNaeO+Vf5vCv9TiQD3OeCizOMAQl3W3kk+ltaAL7aRyxk1vZnvAiuMcv6bqsoPNy2l2+MsXCK+mlzWIMPUmE2zuRzX9C28NKUSHsjsI=
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 20534191-ac88-48fc-c225-08d80abf6f13
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2020 08:47:39.2901
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: STeHtvqfHQpfhbPj6ps8Lq362GYT0+IqZHAKso9Nx0CIRTk/yth8P9Pli2+ZYgOCTYeCxORG1cfczgxxainHHA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR05MB4787
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


On 6/2/2020 4:23 PM, Leon Romanovsky wrote:
> On Tue, Jun 02, 2020 at 09:27:02AM -0300, Jason Gunthorpe wrote:
>> On Tue, Jun 02, 2020 at 09:21:18AM +0300, Leon Romanovsky wrote:
>>> On Mon, Jun 01, 2020 at 09:26:46AM -0300, Jason Gunthorpe wrote:
>>>> On Sun, May 31, 2020 at 12:54:14PM +0300, Leon Romanovsky wrote:
>>>>> On Fri, May 29, 2020 at 08:31:21PM -0300, Jason Gunthorpe wrote:
>>>>>> On Wed, May 27, 2020 at 04:54:08PM +0300, Leon Romanovsky wrote:
>>>>>>> From: Maor Gottlieb <maorg@mellanox.com>
>>>>>>>
>>>>>>> Add support to get MR (mkey) resource dump in RAW format.
>>>>>>>
>>>>>>> Signed-off-by: Maor Gottlieb <maorg@mellanox.com>
>>>>>>> Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
>>>>>>>   drivers/infiniband/hw/mlx5/restrack.c | 3 ++-
>>>>>>>   1 file changed, 2 insertions(+), 1 deletion(-)
>>>>>>>
>>>>>>> diff --git a/drivers/infiniband/hw/mlx5/restrack.c b/drivers/infiniband/hw/mlx5/restrack.c
>>>>>>> index 9e1389b8dd9f..834886536127 100644
>>>>>>> +++ b/drivers/infiniband/hw/mlx5/restrack.c
>>>>>>> @@ -116,7 +116,8 @@ int mlx5_ib_fill_res_mr_entry(struct sk_buff *msg,
>>>>>>>   	struct nlattr *table_attr;
>>>>>>>
>>>>>>>   	if (raw)
>>>>>>> -		return -EOPNOTSUPP;
>>>>>>> +		return fill_res_raw(msg, mr->dev, MLX5_SGMT_TYPE_PRM_QUERY_MKEY,
>>>>>>> +				    mlx5_mkey_to_idx(mr->mmkey.key));
>>>>>> None of the raw functions actually share any code with the non raw
>>>>>> part, why are the in the same function? In fact all the implemenations
>>>>>> just call some other function for raw.
>>>>>>
>>>>>> To me this looks like they should should all be a new op
>>>>>> 'fill_raw_res_mr_entry' and drop the 'bool'
>>>>> I don't think that this is right approach, we already created ops per-objects
>>>>> o remove API multiplexing. Extra de-duplication will create too much ops
>>>>> without any real benefit.
>>>> If there is no code sharing then they should not be in the same
>>>> function at all. More ops is not really a problem.
>>> Logically they are the same, user asks to get object property, driver returns.
>> I'm starting to think it is also a mistake to have the same netlink op
>> and trigger it by an inbound attribute. Are there other examples of
>> that in netlink? Feels wrong
> I have no idea, don't see it in devlink.c

Jason, do you mean trigger the raw by inbound attribute? I don't see a 
reason why not do that. Netlink attributes used for input and output. 
What regarding the driver ops, let's converge with the decision, I am 
okay with the both approaches.

>
>> Jason
