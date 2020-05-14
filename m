Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 597711D2D65
	for <lists+linux-rdma@lfdr.de>; Thu, 14 May 2020 12:50:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726152AbgENKu5 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 14 May 2020 06:50:57 -0400
Received: from mail-eopbgr70042.outbound.protection.outlook.com ([40.107.7.42]:7894
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725955AbgENKu5 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 14 May 2020 06:50:57 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=evuyb7n2KYJKKTf6BQz/61o4fGvyezyJYhh14PVsmKMrqoM4qxjKtmiPgOfmWjQgkq32ABqYCKvIkUhpGqxsq9ReF+637yVlBxVsAYOQQ6unapKCHyLzw9mGQsHBIuujJcDwk2jCHn60YPcWBPkHgOT0cNrYK1d5qp3l+11joNPNuL59fli1ixiVq1mFx5J/0opFgm+eNtmH2k/BaPWQnPhqM1OSB7QSFB3yPChMKDhg08Rj9wXz//a5rnccJrifKW/NOYT7k6aZwojhKsP7EVkAKcyh57zVvb6d7PEXzc+9ukAqkiQjl1skeUkCCrvV533tp7u+Xj8//gEV5OFMiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=soEbRM21uEaXzXqPwBWDxZTL06GRJv80ch4ECcvA5fI=;
 b=RiYNUu6unqreU4I5adCvWhKLt6/senULh63Wa3AguvIcUXknicXkLxiWmwMc1nyhxEuoItIg68njtUL65Yr2ajkocIC2Wnp6rUronXjf/G/MuW0rXoas3rO38abvWLaHRj9SXzDHbDlIL3Dm5lw7aXNS1yN4ozQ6tr1AOXPj0pk1tXKWlKtsDN6y4rYtmy52TbGzVLBPPhoBhs/T97q3t836XHU0tcWQung97SLElDmKpDH38CWrAk+9ceDRpjxx7XH4CR8EX/o4ZWhKw0SNodeXCwkPAHdV+cZf/aRHXE8yFIj65HyluRZ5bnZRTvwkhWIG0Giu7HDPYrbChRG/1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mellanox.com; dmarc=pass action=none header.from=mellanox.com;
 dkim=pass header.d=mellanox.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=soEbRM21uEaXzXqPwBWDxZTL06GRJv80ch4ECcvA5fI=;
 b=tUWtk2uw0XsvqocQ4j7qYlKHYMlDzYD6Pigq3YdBkS5QJe5Zcn3ln/te2YFIDhY1NBLcIvxRoi/Hfx31V1HzhTC+ivF7BNBD1AGoT9YMNKcwO+xJlvREa+G6ZQwMeaYx79pgWAOrwbxOsam2UsSKRQZNmHa0ws7ifGy1c86iWzQ=
Authentication-Results: mellanox.com; dkim=none (message not signed)
 header.d=none;mellanox.com; dmarc=none action=none header.from=mellanox.com;
Received: from AM0PR05MB5810.eurprd05.prod.outlook.com (2603:10a6:208:11f::18)
 by AM0SPR01MB0054.eurprd05.prod.outlook.com (2603:10a6:208:127::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3000.20; Thu, 14 May
 2020 10:50:52 +0000
Received: from AM0PR05MB5810.eurprd05.prod.outlook.com
 ([fe80::408a:27c1:55f8:eed4]) by AM0PR05MB5810.eurprd05.prod.outlook.com
 ([fe80::408a:27c1:55f8:eed4%5]) with mapi id 15.20.2979.033; Thu, 14 May 2020
 10:50:52 +0000
Subject: Re: [PATCH] IB/iser: Remove support for FMR memory registration
To:     Alexey Lyashkov <umka@cloudlinux.com>
Cc:     Bart Van Assche <bvanassche@acm.org>,
        Leon Romanovsky <leon@kernel.org>,
        Israel Rukshin <israelr@mellanox.com>, sagi@grimberg.me,
        jgg@mellanox.com, linux-rdma@vger.kernel.org, dledford@redhat.com,
        sergeygo@mellanox.com
References: <1589299739-16570-1-git-send-email-israelr@mellanox.com>
 <20200512171633.GO4814@unreal> <5b8b0b51-83e3-06c2-9b99-dec0862c0e5b@acm.org>
 <49391e02-803b-f705-b00e-e48efd278759@mellanox.com>
 <0C22D41B-89CD-4B2D-B514-8EA06F2233D7@cloudlinux.com>
From:   Max Gurtovoy <maxg@mellanox.com>
Message-ID: <f6d970e6-2373-e070-40fb-9db82c136e4b@mellanox.com>
Date:   Thu, 14 May 2020 13:50:48 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
In-Reply-To: <0C22D41B-89CD-4B2D-B514-8EA06F2233D7@cloudlinux.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-ClientProxiedBy: AM0PR02CA0080.eurprd02.prod.outlook.com
 (2603:10a6:208:154::21) To AM0PR05MB5810.eurprd05.prod.outlook.com
 (2603:10a6:208:11f::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.0.0.3] (89.139.203.251) by AM0PR02CA0080.eurprd02.prod.outlook.com (2603:10a6:208:154::21) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3000.20 via Frontend Transport; Thu, 14 May 2020 10:50:51 +0000
X-Originating-IP: [89.139.203.251]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: b92ee799-6ee2-410f-ca39-08d7f7f4abf0
X-MS-TrafficTypeDiagnostic: AM0SPR01MB0054:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM0SPR01MB00547904CA4483F1A0F20E21B6BC0@AM0SPR01MB0054.eurprd05.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-Forefront-PRVS: 040359335D
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5dvWEyIE/K3dauuwxbCsTgyxJ3O+vQRemE3QDy2EVLMOGgOz1DCZm6vgWFycPXvr8jn131XOsaYXBR8srBeyIvQvOScbFQ+/4fFRhAdrduUUQwgl3DJrKAyfdygLFFrqFpzbb3v47b3w80TmfXT8SMHtDDVSw5ZZC1GPdACdc7NuPWB4+51TIOO/nSZDYJdaiK55vS+2rasjYrWgJXI0IrhztYCnK7QnA5dzPhcJ78iqiQBLG+6HOVEE2615B6cdWk7cceRPG1IXvta4vyzAGKg0dsPrYmw0LTfYvz1lcqF3ShcuB4TkUrqNqSv6qCkigm4MAeOVuBCOKgfTeJVXMLJpcZ2/3Z8N/Tc4+NvqBpYQu/Kh/TQDAusYnIFe/sV1j8HtH5ryRwkK+2bCoCmytct84lGxeTZKOuQc7DHw8rAS79aYNMDGL5h9wQy49p5/ME8RcFvz1y3ekM/81W1dLG9wAe3Nus2LmpZL62er1CkjTMIExfWHSdAmXksd3uK6
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR05MB5810.eurprd05.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(39860400002)(396003)(136003)(346002)(366004)(376002)(86362001)(4326008)(2616005)(8676002)(956004)(6666004)(52116002)(107886003)(5660300002)(31686004)(54906003)(16576012)(26005)(16526019)(6486002)(316002)(66556008)(66476007)(6916009)(8936002)(66946007)(2906002)(53546011)(36756003)(31696002)(186003)(478600001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: 2/j4hed8qUMjJLwVWaHSRd3R0TissHIZ8qZWfejGFa3F7q67mMiNBJde5xuXR9pqkFS2rkx/xrA0MZTOxPynuNlnLSIQG1B9U4ZM7Hy3c5oHUMni19Ibubw7V3Oh4jEtPy9fELOQbkGNYvsy0jJYcqHzjtk5Uic3WTUKRTtnqZlJoOP9aq6I1101CugtdP4YI3WNy2TFWI1oEKwwqLBv52gJNsDzcRBWfILmBL0fgpyK+ZMpTFm0s+NKVd8WND+3m3/+4i4xyBFlkI8Wujo49dOY2vcXV9qiiWWvfehv7s84QyFFx/WRVH1dZ5nDWEF2pTobfZ6A1vJKqjR96XlX8x3m5gQIj3gvmDVZksCqNe46s9IyOoK/qlZZP5Bbky0pvMnVjVuut0goikYsZLxNEO82/jXuonpxcQRQy3nF8uHq42sQVlywia5JMeUbw8Y0wXTjULoyIeSgxTcmskPAEdZv+nTq9ONhVvwwobC+/aXzgnv8fOa6m4tSZJWyon28
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b92ee799-6ee2-410f-ca39-08d7f7f4abf0
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 May 2020 10:50:52.6548
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aGJFuUPgxDwawnlhOa98cgehGveVGISSHGhrmeQi6V7xxOhpN5zi6hXvS9oKKOlBewiMt+tF6Imr4xxy1fFArA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0SPR01MB0054
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


On 5/14/2020 1:09 PM, Alexey Lyashkov wrote:
> CX3 with fast registration isn’t stable enough.
> I was make this change for Lustre for year or two ago, but it was 
> reverted by serious bugs.
>
I'm not aware of any issues there.

You can always report it on the mailing list.


> Alex
>> 13 мая 2020 г., в 11:43, Max Gurtovoy <maxg@mellanox.com 
>> <mailto:maxg@mellanox.com>> написал(а):
>>
>>
>> On 5/12/2020 11:09 PM, Bart Van Assche wrote:
>>> On 2020-05-12 10:16, Leon Romanovsky wrote:
>>>> On Tue, May 12, 2020 at 07:08:59PM +0300, Israel Rukshin wrote:
>>>>> FMR is not supported on most recent RDMA devices (that use fast memory
>>>>> registration mechanism). Also, FMR was recently removed from NFS/RDMA
>>>>> ULP.
>>>>>
>>>>> Signed-off-by: Israel Rukshin <israelr@mellanox.com 
>>>>> <mailto:israelr@mellanox.com>>
>>>>> Signed-off-by: Max Gurtovoy <maxg@mellanox.com 
>>>>> <mailto:maxg@mellanox.com>>
>>>>> ---
>>>>>  drivers/infiniband/ulp/iser/iscsi_iser.h     |  79 +----------
>>>>>  drivers/infiniband/ulp/iser/iser_initiator.c |  19 ++-
>>>>>  drivers/infiniband/ulp/iser/iser_memory.c    | 188 
>>>>> ++-------------------------
>>>>>  drivers/infiniband/ulp/iser/iser_verbs.c     | 126 +++---------------
>>>>>  4 files changed, 40 insertions(+), 372 deletions(-)
>>>> Can we do an extra step and remove FMR from srp too?
>>> Which HCA's will be affected by removing FMR support? Or in other words,
>>> when did (Mellanox) HCA's start supporting fast memory registration? I'm
>>> asking this because there is a tradition in the Linux kernel not to
>>> remove support for old hardware unless it is pretty sure that nobody is
>>> using that hardware anymore.
>>
>> ConnectX-3 and above supports fast memory registrations.
>>
>>
>>>
>>> Thanks,
>>>
>>> Bart.
>
