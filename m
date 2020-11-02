Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E7E5F2A3319
	for <lists+linux-rdma@lfdr.de>; Mon,  2 Nov 2020 19:38:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725797AbgKBSiZ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 2 Nov 2020 13:38:25 -0500
Received: from mail-co1nam11on2054.outbound.protection.outlook.com ([40.107.220.54]:60928
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725789AbgKBSiY (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 2 Nov 2020 13:38:24 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FEqpoSc4od8RiNTLaB4zyTJunpAAM11JVIL7RQvxvw9SG8sG0lTHSAKw7kpmwn+bVdX4t9P+cmZGQiQua2JIzsX+DWVUbYH1PBTFgTcfb4CgsT5eOLE4BJjCSpvglbqlefyUOem11FEWgVKBx+T5aUfxS+ZAFLp4ZzoeYJSpXcli2k42O/aaPaiGTFXNWTkcY3ZsO0dIi+Wg8ME8P+/6t1Egz/R+oUH/PzxCDQC1ar/1yG7P44Anq7Ov4YjI1k8nKMr7tm8C/s6DUBkegP4lvn9+cuCiu7/Fh3UoEItlDnqLh7mWgMj4QvLLjRwRvsuyveyncbuLoJBRQHES6gIYzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7rzb+ivdtw8nptf+SeZv/Qw5wDxoKYvw6tyB0QWpmjY=;
 b=Egok4AAoi6dp7pRUHQJDSeP5mX1corZdyjBzK2/DrPEKF18xK+hq0CN2P1D/JTluL2Wc6Lj6W09EHfsQKAQS4++Z1cu+yEqI1nqUPsXP3NwuA6tbO+cfXPs+55gw/v1tqAxbqZMR9iQFbTMc4c1GJHo9WKsdAmakX2oSjf2j+t9sLYklwV0MSMZTqcaN8H4qIJSB1/jGEaAFkkclgHzPOBI/VhjfRREYb3peUck5/mdtTRUnoKbPAkoLwbTXOF1LdJfsPapfAf+8YZxgwSCvSHtx7qOIpRYk2D3m0KwLgj0QWoSDoj1jLGjrMAXULWfiPPwjLDvydaLo2wDz+v2/hA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vmware.com; dmarc=pass action=none header.from=vmware.com;
 dkim=pass header.d=vmware.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7rzb+ivdtw8nptf+SeZv/Qw5wDxoKYvw6tyB0QWpmjY=;
 b=BsMir+fK4go4SB5b2oo2Jm8zlGMb9/8lScavh3Q2/Wtd1GIVDC8t9951yCctFdhj9PnBKpM3nUu8MxO7koXtsaIIpsmoCuMtjlGBVRV7wkqJsUfZJ9FIS/i0pySFm2PJ/Q696BhnfOMnVVF8R4JEj3DfEcYN0rNvtyKpe6OfWgk=
Authentication-Results: vmware.com; dkim=none (message not signed)
 header.d=none;vmware.com; dmarc=none action=none header.from=vmware.com;
Received: from BYAPR05MB5511.namprd05.prod.outlook.com (2603:10b6:a03:1a::28)
 by SJ0PR05MB7373.namprd05.prod.outlook.com (2603:10b6:a03:27a::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.14; Mon, 2 Nov
 2020 18:38:21 +0000
Received: from BYAPR05MB5511.namprd05.prod.outlook.com
 ([fe80::958b:64f6:b2f9:97e0]) by BYAPR05MB5511.namprd05.prod.outlook.com
 ([fe80::958b:64f6:b2f9:97e0%7]) with mapi id 15.20.3541.011; Mon, 2 Nov 2020
 18:38:21 +0000
Subject: Re: [Suspected Spam] Re: [PATCH for-rc] RDMA/vmw_pvrdma: Fix the
 active_speed and phys_state value
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     dledford@redhat.com, linux-rdma@vger.kernel.org,
        pv-drivers@vmware.com
References: <20201028231945.6533-1-aditr@vmware.com>
 <20201029115733.GA2620339@nvidia.com>
 <e0a834a1-e5ee-4838-4718-d6ded1e954be@vmware.com>
 <38f4a89a-c443-2cb2-a3de-89481a86e192@vmware.com>
 <20201102180256.GG2620339@nvidia.com>
 <f8b16c37-14ef-5663-048c-75def55968b1@vmware.com>
 <20201102182714.GI2620339@nvidia.com>
From:   Adit Ranadive <aditr@vmware.com>
Message-ID: <14c28229-3a5e-88f4-f57a-eddbe7145231@vmware.com>
Date:   Mon, 2 Nov 2020 10:38:19 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.4.0
In-Reply-To: <20201102182714.GI2620339@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [107.3.164.70]
X-ClientProxiedBy: SJ0PR03CA0144.namprd03.prod.outlook.com
 (2603:10b6:a03:33c::29) To BYAPR05MB5511.namprd05.prod.outlook.com
 (2603:10b6:a03:1a::28)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from vmwin-005.intranet.hyperic.net (107.3.164.70) by SJ0PR03CA0144.namprd03.prod.outlook.com (2603:10b6:a03:33c::29) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.19 via Frontend Transport; Mon, 2 Nov 2020 18:38:21 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1d55014e-0914-4bef-521a-08d87f5e7960
X-MS-TrafficTypeDiagnostic: SJ0PR05MB7373:
X-LD-Processed: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0,ExtAddr
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SJ0PR05MB737328D32E4E221EB1AEFE66C5100@SJ0PR05MB7373.namprd05.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:800;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: F9FJ2Zzq7kyhZXOE0jcBu4bVnB9bSrEiFACieEG/tZhbL1TTlSLxH7XxjnQ9HYo4l8E4O6bqgzgdnv8yY+sjyWlKdUtGBfKDGKMjyXt2bN7AW3YM/TJ1TyLsBohFvAhCFgQ7/CmGgjBunLvNf+vOc4cMmyul9rHVk2QibVpgzvDpz/Pjdp5iL/S3wxiFwgfho4G+ofrxcHQvD8vT5PjbQ9PhTQVi1oNh6CJYLxjVsMNUoWKd/+MNXazV/qQqbRxT/nbLobyIBzhh1o9ft6zXt+7h2GKazmiX+EP9CPV3ALaRyHnSj0wt2psVx6qetu950UpyoB+HAtbO0efpzwePPWj2RfzKXcnVGDqhT8MGjZQJo2XcVHkRISEwJ5/4bELu
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR05MB5511.namprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(396003)(136003)(376002)(346002)(39860400002)(2616005)(5660300002)(66556008)(6486002)(8676002)(83380400001)(956004)(107886003)(8936002)(26005)(31696002)(66476007)(186003)(6506007)(6512007)(53546011)(86362001)(31686004)(66946007)(6916009)(16526019)(36756003)(4326008)(316002)(478600001)(2906002)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: zCHde7nEDFcnWfiXDRpiz2uVe67LL1KbRI79DssPGPkMT/z1/ZW/qIZvf7TdH8bgtO5dHmfK2MlESLgv/+WpL/JINVNsDMpVJHwXIhzImjtNBXtp7FH3P8XQ8pVK5vf24/bmedkYX7olU3lH+Va6h2Hije6740dB+nVgCS6VGFNJwxOAhg6AIrcVzbhpjXPbfiaW84yVrU74I/96ZhuUxmFUxYKjxImYdADuClkOE+LNpPyV1wQWB3B9gFHW+Mj/dQsAnCuUjtOJTkSIm2mn5DZm0IjpZDB9i9iiiauft9gNy/sCitrRHqVd5kmOJVsaYjthHiyLxgNha4y7qBIe2OgiSunxxIcbtttixL1gGS0A1ZOfW4NU1Wx6PzNWkRAZsbuEBMK60zmGWMhACyQ9l8tvrpkeswP65dCG2e3101F6fnaJHi95F/sWQGxzE5KtUDEd/gPWBlMpNij8UK88z3f6Fia9B8EaIUaEeE73CqZ9i2HFUqCHKFU6cjvtIWsjJZ61Lfl4CwPQGL1IDtnYl+LHTHFJpcv0pjirsXXRBDIPFOzbvIIQoFLqufPrxfH2bX9bZHNivqrydckt8/epHcCcV/6z9qsT4i1DUIZFgolfEvx2Onh5b6aTEUBfA4fKQG8gqVVZAuDxcaMPEX8sAw==
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d55014e-0914-4bef-521a-08d87f5e7960
X-MS-Exchange-CrossTenant-AuthSource: BYAPR05MB5511.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Nov 2020 18:38:21.5882
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sMBkh4sbIYveqvTXOZvfijSbnro0Mwcv3Lnm002SGbc+t6Tp7LblsAaYeMKlCxh6xPdqx+1m8lXTqUuFfjrtoA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR05MB7373
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 11/2/20 10:27 AM, Jason Gunthorpe wrote:
> On Mon, Nov 02, 2020 at 10:21:21AM -0800, Adit Ranadive wrote:
>> On 11/2/20 10:02 AM, Jason Gunthorpe wrote:
>>> On Mon, Nov 02, 2020 at 09:55:25AM -0800, Adit Ranadive wrote:
>>>> On 10/29/20 9:16 AM, Adit Ranadive wrote:
>>>>> On 10/29/20 4:57 AM, Jason Gunthorpe wrote:
>>>>>> On Wed, Oct 28, 2020 at 11:19:45PM +0000, Adit Ranadive wrote:
>>>>>>> The PVRDMA device still reports the active_speed in u8.
>>>>>>> Lets use the ib_eth_get_speed to report the speed and
>>>>>>> width. Unfortunately, phys_state gets stored as msb of
>>>>>>> the new u16 active_speed.
>>>>>>
>>>>>> This explanation is not clear, I have no idea what this is fixing
>>>>>
>>>>> It seemed more clear to me in my head, I guess :).
>>>>>
>>>>> After commit 376ceb31ff87 changed the active_speed attribute to
>>>>> u16, both the active_speed and phys_state attributes in the
>>>>> pvrdma_port_attr struct are getting stored in this u16. As a 
>>>>> result, these show up as invalid values in ibv_devinfo.
>>>>>
>>>>> Our device still gives us back a u8 active_speed so both these
>>>>> are getting stored in the u16. This fix I proposed simply gets 
>>>>> the active_speed from the netdev while the phys_state still 
>>>>> needs to come from the pvrdma device, i.e. the msb the of the
>>>>> u16. I also removed some unused functions as a result.
>>>>>
>>>>> Alternatively, I could change the u8 active_width and u16 
>>>>> active_speed to reserved now that we're getting the active_speed
>>>>> and active_width from the ib_get_eth_speed function.
>>>>
>>>> Jason, did you have any comments on this or did you want me
>>>> to just send v1 with an updated description?
>>>
>>> I still haven't figured out what this is fixing.
>>>
>>> Is 'struct pvrdma_port_attr' some kind of ABI? If so why isn't the fix
>>> to revert the type?
>>
>> I can revert it but I thought that it had to a u16 based on the IBTA, no?
>> Or does that not apply to device-level stuff?
> 
> You didn't answer the question, it it ABI to some kind of FW interface
> or something?
> 
> *HOW* did two fields get overlapped onto a single u16?? The compiler
> won't do this..
> 

It is an ABI to the device for port attributes. The device gives us back
this structure for query port verb. The response from the device is
memcopied into this pvrdma_port_attr structure. So both the bytes 
representing active_speed and phys_state from the device are copied 
into the single u16 in this structure.
