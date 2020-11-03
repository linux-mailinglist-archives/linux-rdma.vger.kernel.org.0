Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C5602A5A31
	for <lists+linux-rdma@lfdr.de>; Tue,  3 Nov 2020 23:41:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729961AbgKCWlQ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 3 Nov 2020 17:41:16 -0500
Received: from mail-co1nam11on2062.outbound.protection.outlook.com ([40.107.220.62]:49889
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729342AbgKCWlP (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 3 Nov 2020 17:41:15 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LuEDX3jXise1dRWP6xsMcLKFug5E4HnlzK5W91G0cB6Bb5UcQXKr1aVMlUs3uNx7jKTMp+xB5GqAg3F0ZWMcKjHILBexgM662GpCwoner7gVkH4mkrwoiACHu+jR41GWmVaSjD7K4PiE9Rdjs4onounx+bL1y7j4A6rNejLrb/AtWymTQTnhi1GhgiHikhCXVEMomJ3LCp6zJh1dcy0VaZPQZnzFvc57cOg9USLo2AOiahsdixB2PjEkuGplWh7kVACwh5+uI2qqEi4l7MIBIWKWe8c/47uWTaAAkCH0Tlnv5SuLnfCs9oB2Sjrs+GncKp/BEoFOnOiksQ0LabmL0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ejrU3/RVL9wEhuUCTzdAkUXjthUyCRR1MRIIbF+nGRE=;
 b=CL1d+yzEGBcjeOqMMfEvrpOoo2WKl4+b9ymLeNFylIzdcv4CM4CTCYgmmaVvUlXzGL2dCyqOPkHt6i7wp8jYu2aLHW1RHesEw4Smqs6lSGzwvUIgkPmVjaTZVs5FkVcSSXw0bK9H8PfClwMb102w7Ivx9Mhdf2P+tjULIaMnB+/oFOV29/SmWrpgqVG5aufOPsGNS/qlfezdzmF5m0pECAfh4aU0faMY67Omsn9qvyK2m5wQvKeAFQ8Q56bc6+r5uvmK6Sp7k8DqRkGRiHwfQxQLU5v4xDT0naybRwrYykrIzLAaFsvvNQE5nM3FkPvwkeFRddfq5oXuFHslsMRi5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vmware.com; dmarc=pass action=none header.from=vmware.com;
 dkim=pass header.d=vmware.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ejrU3/RVL9wEhuUCTzdAkUXjthUyCRR1MRIIbF+nGRE=;
 b=nnGwPMER4EyR2zHYTgIOsXqav51f0ad4jK008HJRKEfDfiauNtPX94LCn/wkGVNaJdiG8UYxflc8xPHq3Zp46yIz8i24ECJdAWChWYW3ERw1IIlzljKVV42qb9rLFx3lsjNRVWV87rHsrFTaQoWCSGWr6ASjpPCXgECVt+35NHU=
Authentication-Results: vmware.com; dkim=none (message not signed)
 header.d=none;vmware.com; dmarc=none action=none header.from=vmware.com;
Received: from BYAPR05MB5511.namprd05.prod.outlook.com (2603:10b6:a03:1a::28)
 by BYAPR05MB5527.namprd05.prod.outlook.com (2603:10b6:a03:7f::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.15; Tue, 3 Nov
 2020 22:41:09 +0000
Received: from BYAPR05MB5511.namprd05.prod.outlook.com
 ([fe80::958b:64f6:b2f9:97e0]) by BYAPR05MB5511.namprd05.prod.outlook.com
 ([fe80::958b:64f6:b2f9:97e0%7]) with mapi id 15.20.3541.011; Tue, 3 Nov 2020
 22:41:08 +0000
Subject: Re: [Suspected Spam] Re: [PATCH for-rc] RDMA/vmw_pvrdma: Fix the
 active_speed and phys_state value
To:     Leon Romanovsky <leon@kernel.org>, Jason Gunthorpe <jgg@nvidia.com>
Cc:     dledford@redhat.com, linux-rdma@vger.kernel.org,
        pv-drivers@vmware.com
References: <20201028231945.6533-1-aditr@vmware.com>
 <20201029115733.GA2620339@nvidia.com>
 <e0a834a1-e5ee-4838-4718-d6ded1e954be@vmware.com>
 <38f4a89a-c443-2cb2-a3de-89481a86e192@vmware.com>
 <20201102180256.GG2620339@nvidia.com>
 <f8b16c37-14ef-5663-048c-75def55968b1@vmware.com>
 <20201102182714.GI2620339@nvidia.com>
 <14c28229-3a5e-88f4-f57a-eddbe7145231@vmware.com>
 <20201102184640.GJ2620339@nvidia.com> <20201103065641.GI5429@unreal>
From:   Adit Ranadive <aditr@vmware.com>
Message-ID: <51b30bf6-e7b1-1478-a244-ac8ef5af2b3b@vmware.com>
Date:   Tue, 3 Nov 2020 14:41:06 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.4.0
In-Reply-To: <20201103065641.GI5429@unreal>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [107.3.164.70]
X-ClientProxiedBy: SJ0PR03CA0171.namprd03.prod.outlook.com
 (2603:10b6:a03:338::26) To BYAPR05MB5511.namprd05.prod.outlook.com
 (2603:10b6:a03:1a::28)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from vmwin-005.intranet.hyperic.net (107.3.164.70) by SJ0PR03CA0171.namprd03.prod.outlook.com (2603:10b6:a03:338::26) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.19 via Frontend Transport; Tue, 3 Nov 2020 22:41:07 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b72f90c1-8387-410a-f75d-08d880498e46
X-MS-TrafficTypeDiagnostic: BYAPR05MB5527:
X-LD-Processed: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0,ExtAddr
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR05MB552796E51805E10A3F243812C5110@BYAPR05MB5527.namprd05.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1417;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DSrUmSN8XMC+26TZH5i+agHmUn9EdieZQi4uEg0MBxpqa70pnNv5QDJxn5FD2EOcuMB6kacgL+ATrSDjqieziQKXd4AM/BbhDZ/5uYkQ145xidIoSaC01yAiLN1no5pbPXQZBBtX7QW69mOOn96xqqcZ0YKHdkWPHKb0n4wmztWz9o8sCVPjJQIrisobiGFN0r0IsO/69nigRc6P1f7dQ5Yg7fgcxeeSBd/G1EPInC13mc/5jbxG3Rst5ropZC4YgrYF39VLwtBvuyfRSOtkBaKxVusIwE+1lSMehWvet4//W01JTwazejtq9WSYoITFfzNaLbuDNLSVKi/UWFO6Jximnr8L2/SPQiE8V2dwpbj5l/EtB41suLyB0CSebe7x
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR05MB5511.namprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(366004)(39860400002)(346002)(376002)(136003)(6486002)(2906002)(186003)(16526019)(66946007)(31696002)(2616005)(31686004)(956004)(110136005)(6512007)(26005)(5660300002)(66556008)(66476007)(83380400001)(86362001)(36756003)(53546011)(4326008)(6506007)(8676002)(478600001)(107886003)(316002)(8936002)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: Xnf/kRj2qRD+1VNh/W10WSV7aeYxgd29kT0TqW7LOBMWWjG69t+T4rl+hey1rx4XbTcOU3+vh6vRjIhZRLGoJeQDBVFesQNLzMtMoos5kMBoxF5BXxHXreoZfVuggVM68oI4bisx3BFnqGPpZMbHSsALFus6zLHZrVp5z7Q7eNucRRpZxbypOhwQDnp3py8b0X7GVK50ALDGz8KfRB/AaAfDmmfe3mFG7ph5lfEsDRDK7pZZv3LhDNxyjIZy2QC3rr1myyQlaHQrNO0eeoGMUytG+6Mw6qPMwhv5KtQMAkE2gXr/yeKh7xzwIOOLkUB7ckOGTKQQndJMvEoCFPwhJisVnkvp0ikRZrXpKfJI4LV6NRJ6dw6tIFe6l42AuvRxZASKovYcHs9/Vvq8vhhRBhrGmOBFqjTZtPkhek3Sdk6bpfkirgN9uzP7vdnJyRFm+skzWu9YmwXvfAugUPwZNszKw0OwF5qj/ugcNQATwLim4QE9GYaMfjMiCtNpRq2fKOZFod2BrjowCWZi+9P6SiHDVJnTVEjAwSUC6SzCjHft71KYTN/y+57YOQRAYo11OLnMgXkxsetqiTnutE5gU2PZm2MwZUx5ck1repoVXBwXYB+ZqQA0atscXow/CiKvqLJIKF59YKqaGOXUWzm6LA==
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b72f90c1-8387-410a-f75d-08d880498e46
X-MS-Exchange-CrossTenant-AuthSource: BYAPR05MB5511.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2020 22:41:08.7524
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fIF6pZoUepnq6JBEghSHFt69T+w9x5DLLRlzqUbPlrv/ChB/a7jtU6D1B5NNEpfc2q0zU34b1E5WCw1bew2TGw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR05MB5527
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 11/2/20 10:56 PM, Leon Romanovsky wrote:
> On Mon, Nov 02, 2020 at 02:46:40PM -0400, Jason Gunthorpe wrote:
>> On Mon, Nov 02, 2020 at 10:38:19AM -0800, Adit Ranadive wrote:
>>> On 11/2/20 10:27 AM, Jason Gunthorpe wrote:
>>>> On Mon, Nov 02, 2020 at 10:21:21AM -0800, Adit Ranadive wrote:
>>>>> On 11/2/20 10:02 AM, Jason Gunthorpe wrote:
>>>>>> On Mon, Nov 02, 2020 at 09:55:25AM -0800, Adit Ranadive wrote:
>>>>>>> On 10/29/20 9:16 AM, Adit Ranadive wrote:
>>>>>>>> On 10/29/20 4:57 AM, Jason Gunthorpe wrote:
>>>>>>>>> On Wed, Oct 28, 2020 at 11:19:45PM +0000, Adit Ranadive wrote:
>>>>>>>>>> The PVRDMA device still reports the active_speed in u8.
>>>>>>>>>> Lets use the ib_eth_get_speed to report the speed and
>>>>>>>>>> width. Unfortunately, phys_state gets stored as msb of
>>>>>>>>>> the new u16 active_speed.
>>>>>>>>>
>>>>>>>>> This explanation is not clear, I have no idea what this is fixing
>>>>>>>>
>>>>>>>> It seemed more clear to me in my head, I guess :).
>>>>>>>>
>>>>>>>> After commit 376ceb31ff87 changed the active_speed attribute to
>>>>>>>> u16, both the active_speed and phys_state attributes in the
>>>>>>>> pvrdma_port_attr struct are getting stored in this u16. As a
>>>>>>>> result, these show up as invalid values in ibv_devinfo.
>>>>>>>>
>>>>>>>> Our device still gives us back a u8 active_speed so both these
>>>>>>>> are getting stored in the u16. This fix I proposed simply gets
>>>>>>>> the active_speed from the netdev while the phys_state still
>>>>>>>> needs to come from the pvrdma device, i.e. the msb the of the
>>>>>>>> u16. I also removed some unused functions as a result.
>>>>>>>>
>>>>>>>> Alternatively, I could change the u8 active_width and u16
>>>>>>>> active_speed to reserved now that we're getting the active_speed
>>>>>>>> and active_width from the ib_get_eth_speed function.
>>>>>>>
>>>>>>> Jason, did you have any comments on this or did you want me
>>>>>>> to just send v1 with an updated description?
>>>>>>
>>>>>> I still haven't figured out what this is fixing.
>>>>>>
>>>>>> Is 'struct pvrdma_port_attr' some kind of ABI? If so why isn't the fix
>>>>>> to revert the type?
>>>>>
>>>>> I can revert it but I thought that it had to a u16 based on the IBTA, no?
>>>>> Or does that not apply to device-level stuff?
>>>>
>>>> You didn't answer the question, it it ABI to some kind of FW interface
>>>> or something?
>>>>
>>>> *HOW* did two fields get overlapped onto a single u16?? The compiler
>>>> won't do this..
>>>>
>>>
>>> It is an ABI to the device for port attributes. The device gives us back
>>> this structure for query port verb. The response from the device is
>>> memcopied into this pvrdma_port_attr structure. So both the bytes
>>> representing active_speed and phys_state from the device are copied
>>> into the single u16 in this structure.
>>
>> So it is ABI and it shouldn't have been changed, point at the stuff
>> that made it ABI and revert the structure layout change..
> 
> How will it work for the new IBTA speed?

Hopefully that should be addressed in another patch I'll send out
that uses the ib_get_eth_speed api?

> 
> Thanks
> 
>>
>> Jason
