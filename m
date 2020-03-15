Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 06FC1185FCF
	for <lists+linux-rdma@lfdr.de>; Sun, 15 Mar 2020 21:40:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729153AbgCOUkh (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 15 Mar 2020 16:40:37 -0400
Received: from mail-eopbgr60066.outbound.protection.outlook.com ([40.107.6.66]:24435
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729152AbgCOUkg (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Sun, 15 Mar 2020 16:40:36 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cX7qwY3HV5tEBLweWPrZHNk864wnDpx6jKR/EKTUvWpDhapYyrbRqkeXcKCHhpSBWyYB10b8Xo5GOi7opZE37EQj8ifHUB7d4I9pPymQgU3yL4L/dLMCzGW9/NOR2E20U0bxiPogvmrxC5IdxqkOvxWz1KiSMhE1oJg/LF9QVg4Z2typd8j6SlaabTbEvUEainRwyhYBg/oSlLT0mHwvxK5TsUx/79G9HA/HhpnfKpnTHArXxEmqe8yMt0NzFsOXHeob3HQIN18SNdLWjnHCWMspiHg2b49n2uCLWe/KypP9eYAo//dMOBwl9SzN8fjvS07ZhLvUVg5PE5LAETkAeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4cmA85FlUPXJdTpLA/1Hbzzry3eq0DDvdggZpGeGE94=;
 b=A+qb34yJIEYaXk4iJDjzXSpy96p2OZG8nDOfWVfBEoFEHrT5z5x4jD8tI0of7m6Irb2fuBlAoXAItB8m99/ItXKyfl3RusN9eQ3tbDtOJxPzutW3kzP1LuWj6SXCGQBlNlyr2kqOK0qh+dckB4kJh1YSyW2pyIhqcsWzBzw0ZWziPKYGQrlDM3CwgKptL/UQgYRtPaKf/oCuUbpjcksvS/B+uiI+qWavrWQJXHbzD0J96mKZ284zstP1NY4jSmHb7uNx4iAH04yJB/21bb/7SuQk/blRpqxbCUHaE6zAaqataYeU8e9bUNF5vhPlKLVjH/zKpvCQ6l4ZSnA+tMX4JQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 193.47.165.251) smtp.rcpttodomain=redhat.com smtp.mailfrom=mellanox.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=mellanox.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4cmA85FlUPXJdTpLA/1Hbzzry3eq0DDvdggZpGeGE94=;
 b=HjqMgI+4NVzrOxWlFX++z7olk14236yv4Uhwkz3fd/eAcfCOZTZJF1OHN7aLiblEjW9ijUZyZoA57DWM6Ll9AsC1fZfV5w8hd1nHpPFmZoRpxk42VjqGZmsv+9V95amJlzmq1CbkLO5dgIMe3DJD8nJG05AGLN8LwtKFACLgbvg=
Received: from VI1PR09CA0127.eurprd09.prod.outlook.com (2603:10a6:803:12c::11)
 by VI1PR05MB5821.eurprd05.prod.outlook.com (2603:10a6:803:d9::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2814.22; Sun, 15 Mar
 2020 20:40:30 +0000
Received: from VE1EUR03FT012.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:803:12c:cafe::f3) by VI1PR09CA0127.outlook.office365.com
 (2603:10a6:803:12c::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2814.16 via Frontend
 Transport; Sun, 15 Mar 2020 20:40:30 +0000
Authentication-Results: spf=pass (sender IP is 193.47.165.251)
 smtp.mailfrom=mellanox.com; redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=pass action=none header.from=mellanox.com;
Received-SPF: Pass (protection.outlook.com: domain of mellanox.com designates
 193.47.165.251 as permitted sender) receiver=protection.outlook.com;
 client-ip=193.47.165.251; helo=mtlcas13.mtl.com;
Received: from mtlcas13.mtl.com (193.47.165.251) by
 VE1EUR03FT012.mail.protection.outlook.com (10.152.18.211) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.2814.13 via Frontend Transport; Sun, 15 Mar 2020 20:40:29 +0000
Received: from MTLCAS13.mtl.com (10.0.8.78) by mtlcas13.mtl.com (10.0.8.78)
 with Microsoft SMTP Server (TLS) id 15.0.1178.4; Sun, 15 Mar 2020 22:40:27
 +0200
Received: from MTLCAS01.mtl.com (10.0.8.71) by MTLCAS13.mtl.com (10.0.8.78)
 with Microsoft SMTP Server (TLS) id 15.0.1178.4 via Frontend Transport; Sun,
 15 Mar 2020 22:40:27 +0200
Received: from [172.27.12.224] (172.27.12.224) by MTLCAS01.mtl.com (10.0.8.71)
 with Microsoft SMTP Server (TLS) id 14.3.468.0; Sun, 15 Mar 2020 22:40:26
 +0200
Subject: Re: commit ab118da4c10a70b8437f5c90ab77adae1835963e causes ib_srpt to
 fail connections served by target LIO
To:     Laurence Oberman <loberman@redhat.com>,
        rdmadev <rdma-dev-team@redhat.com>, <linux-rdma@vger.kernel.org>,
        linux-scsi <linux-scsi@vger.kernel.org>,
        "Van Assche, Bart" <bvanassche@acm.org>,
        "Leon Romanovsky" <leonro@mellanox.com>
CC:     Rupesh Girase <rgirase@redhat.com>
References: <88bab94d2fd72f3145835b4518bc63dda587add6.camel@redhat.com>
 <0bef0089-0c46-8fb7-9e44-61654c641cbd@mellanox.com>
 <e57c1763dd99ea958c9834a53ae5688a775c9444.camel@redhat.com>
 <6d5415e3-9314-331a-fade-7593c6a27290@mellanox.com>
 <8695fb0f34588616aded629127cc3fa2799fa7cb.camel@redhat.com>
From:   Max Gurtovoy <maxg@mellanox.com>
Message-ID: <918bc803-41d6-6eea-34e2-9e40f959a982@mellanox.com>
Date:   Sun, 15 Mar 2020 22:40:26 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <8695fb0f34588616aded629127cc3fa2799fa7cb.camel@redhat.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [172.27.12.224]
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:193.47.165.251;IPV:;CTRY:IL;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(39860400002)(396003)(376002)(136003)(346002)(199004)(46966005)(36906005)(316002)(8936002)(81166006)(81156014)(8676002)(31686004)(2906002)(356004)(26005)(16576012)(110136005)(47076004)(478600001)(336012)(186003)(16526019)(2616005)(4326008)(36756003)(53546011)(6636002)(5660300002)(31696002)(70206006)(70586007)(86362001)(3940600001);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR05MB5821;H:mtlcas13.mtl.com;FPR:;SPF:Pass;LANG:en;PTR:InfoDomainNonexistent;A:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0dcd3494-96cb-4be3-4483-08d7c92119b7
X-MS-TrafficTypeDiagnostic: VI1PR05MB5821:
X-Microsoft-Antispam-PRVS: <VI1PR05MB58212B3F29206D4227A9216AB6F80@VI1PR05MB5821.eurprd05.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-Forefront-PRVS: 0343AC1D30
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: p/kFwYSAzbYMiI7M3oA3z/WvUJMbRmCMpjHOtO+PlAj30IYpapeO+cRPAiQSbDtHKDrbaT/9M7YYNs9JccPJc4P1NgKx1jfhMGb0lUs18owiUEvBe9/xvuT5Q0tMkhO3j8WdzcgIGtsJQFpoWo5wVkoD43nnw/MPrJLSHXLmK/1yGo0jPYriG3Do6bFxpbpf+ol3Mos7EPI90UXToAYXpCAK0VEvPtLd0IXPbQtHCnOr5FyplOt1MIpg9XQ58nGl3T2scm1X6kmRFePtSfcJEEVfP43bPk9mHodRciBrO5R1G8H97X4nkjN2Q/0UzzJ0Es0vfYt3nXG1TV/QEdhmn+vOwPxVvxloN+DpnWdwn9u+/ZFDENxGwdYxWqbWrobhUeIMa7twWSP2uoZRiQ/gUkXwnVSVdWIkNVhBUPcvCbTvZod31eBNzb80wEcpl4N4p6dv7UbW1aqWCfTz/CIYVwaRTWmlO1poWdICD/TrqDmngsk4vro9zsh1949RN+nzI4+l6Vcsa3DzLtv3c6FvcTMaJKfvX74ey8BuUjpB6Ms=
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Mar 2020 20:40:29.6132
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0dcd3494-96cb-4be3-4483-08d7c92119b7
X-MS-Exchange-CrossTenant-Id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=a652971c-7d2e-4d9b-a6a4-d149256f461b;Ip=[193.47.165.251];Helo=[mtlcas13.mtl.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR05MB5821
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


On 3/15/2020 8:36 PM, Laurence Oberman wrote:
> On Sun, 2020-03-15 at 20:20 +0200, Max Gurtovoy wrote:
>> On 3/15/2020 7:59 PM, Laurence Oberman wrote:
>>> On Sun, 2020-03-15 at 18:47 +0200, Max Gurtovoy wrote:
>>>> On 3/14/2020 11:30 PM, Laurence Oberman wrote:
>>>>> Hello Bart, Leon and Max
>>>> Hi Laurence,
>>>>
>>>> thanks for the great analysis and the fast response !!
>>>>
>>>>> Max had reached out to me to test a new set of patches for SRQ.
>>>>> I had not tested upstream ib_srpt on an LIO target for quite a
>>>>> while,
>>>>> only ib_srp client tests had been run of late.
>>>>> During a baseline test before applying Max's patches it was
>>>>> apparent
>>>>> that something had broken ib_srpt connections within LIO target
>>>>> since
>>>>> 5.5.
>>>>>
>>>>> Note thet ib_srp client connectivity with the commit functions
>>>>> fine,
>>>>> it's just the target that breaks with this commit.
>>>>>
>>>>> After a long bisect this is the commit that seems to break it.
>>>>> While it's not directly code in ib_srpt, its code in mlx5 vport
>>>>> ethernet connectivity that then breaks ib_srpt connectivity
>>>>> over
>>>>> mlx5
>>>>> IB RDMA with LIO.
>>>> I was able to connect in loopback and also from remote initiator
>>>> with
>>>> this commit.
>>>>
>>>> So I'm not sure that this commit is broken.
>>>>
>>>> I used Bart's scripts to configure the target and to connect to
>>>> it
>>>> in
>>>> loopback (after some modifications for the updated
>>>> kernel/sysfs/configfs
>>>> interface).
>>>>
>>>> I did see an issue to connect from remote initiator, but after
>>>> reloading
>>>> openibd in the initiator side I was able to connect.
>>>>
>>>> So I suspect you had the same issue - that also should be
>>>> debugged.
>>>>
>>>>> I will let Leon and others decide but reverting the below
>>>>> commit
>>>>> allows
>>>>> SRP connectivity to an LIO target to work again.
>>>> I added prints to "mlx5_core_modify_hca_vport_context" function
>>>> and
>>>> found that we don't call it in "pure" mlx5 mode with PFs.
>>>>
>>>> Maybe you can try it too...
>>>>
>>>> I was able to check my patches on my system and I'll send them
>>>> soon.
>>>>
>>>> Thanks again Laurence and Bart.
>>>>
>>>>> Max, I will test your new patches once we have a decision on
>>>>> this.
>>>>>
>>>>> Client
>>>>> Linux ibclient.lab.eng.bos.redhat.com 5.6.0-rc5+ #1 SMP Thu Mar
>>>>> 12
>>>>> 16:58:19 EDT 2020 x86_64 x86_64 x86_64 GNU/Linux
>>>>>
>>>>> Server with reverted commit
>>>>> Linux fedstorage.bos.redhat.com 5.6.0-rc5+ #1 SMP Sat Mar 14
>>>>> 16:39:35
>>>>> EDT 2020 x86_64 x86_64 x86_64 GNU/Linux
>>>>>
>>>>> commit ab118da4c10a70b8437f5c90ab77adae1835963e
>>>>> Author: Leon Romanovsky <leonro@mellanox.com>
>>>>> Date:   Wed Nov 13 12:03:47 2019 +0200
>>>>>
>>>>>        net/mlx5: Don't write read-only fields in
>>>>> MODIFY_HCA_VPORT_CONTEXT
>>>>> command
>>>>>        
>>>>>        The MODIFY_HCA_VPORT_CONTEXT uses field_selector to mask
>>>>> fields
>>>>> needed
>>>>>        to be written, other fields are required to be zero
>>>>> according
>>>>> to
>>>>> the
>>>>>        HW specification. The supported fields are controlled by
>>>>> bitfield
>>>>>        and limited to vport state, node and port GUIDs.
>>>>>        
>>>>>        Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
>>>>>        Signed-off-by: Saeed Mahameed <saeedm@mellanox.com>
>>>>>
>>>>> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/vport.c
>>>>> b/drivers/net/ethernet/mellanox/mlx5
>>>>> index 30f7848..1faac31f 100644
>>>>> --- a/drivers/net/ethernet/mellanox/mlx5/core/vport.c
>>>>> +++ b/drivers/net/ethernet/mellanox/mlx5/core/vport.c
>>>>> @@ -1064,26 +1064,13 @@ int
>>>>> mlx5_core_modify_hca_vport_context(struct
>>>>> mlx5_core_dev *dev,
>>>>>     
>>>>>            ctx = MLX5_ADDR_OF(modify_hca_vport_context_in, in,
>>>>> hca_vport_context);
>>>>>            MLX5_SET(hca_vport_context, ctx, field_select, req-
>>>>>> field_select);
>>>>> -       MLX5_SET(hca_vport_context, ctx, sm_virt_aware, req-
>>>>>> sm_virt_aware);
>>>>> -       MLX5_SET(hca_vport_context, ctx, has_smi, req-
>>>>>> has_smi);
>>>>> -       MLX5_SET(hca_vport_context, ctx, has_raw, req-
>>>>>> has_raw);
>>>>> -       MLX5_SET(hca_vport_context, ctx, vport_state_policy,
>>>>> req-
>>>>>> policy);
>>>>> -       MLX5_SET(hca_vport_context, ctx, port_physical_state,
>>>>> req-
>>>>>> phys_state);
>>>>> -       MLX5_SET(hca_vport_context, ctx, vport_state, req-
>>>>>> vport_state);
>>>>> -       MLX5_SET64(hca_vport_context, ctx, port_guid, req-
>>>>>> port_guid);
>>>>> -       MLX5_SET64(hca_vport_context, ctx, node_guid, req-
>>>>>> node_guid);
>>>>> -       MLX5_SET(hca_vport_context, ctx, cap_mask1, req-
>>>>>> cap_mask1);
>>>>> -       MLX5_SET(hca_vport_context, ctx,
>>>>> cap_mask1_field_select,
>>>>> req-
>>>>>> cap_mask1_perm);
>>>>> -       MLX5_SET(hca_vport_context, ctx, cap_mask2, req-
>>>>>> cap_mask2);
>>>>> -       MLX5_SET(hca_vport_context, ctx,
>>>>> cap_mask2_field_select,
>>>>> req-
>>>>>> cap_mask2_perm);
>>>>> -       MLX5_SET(hca_vport_context, ctx, lid, req->lid);
>>>>> -       MLX5_SET(hca_vport_context, ctx, init_type_reply, req-
>>>>>> init_type_reply);
>>>>> -       MLX5_SET(hca_vport_context, ctx, lmc, req->lmc);
>>>>> -       MLX5_SET(hca_vport_context, ctx, subnet_timeout, req-
>>>>>> subnet_timeout);
>>>>> -       MLX5_SET(hca_vport_context, ctx, sm_lid, req->sm_lid);
>>>>> -       MLX5_SET(hca_vport_context, ctx, sm_sl, req->sm_sl);
>>>>> -       MLX5_SET(hca_vport_context, ctx,
>>>>> qkey_violation_counter,
>>>>> req-
>>>>>> qkey_violation_counter);
>>>>> -       MLX5_SET(hca_vport_context, ctx,
>>>>> pkey_violation_counter,
>>>>> req-
>>>>>> pkey_violation_counter);
>>>>> +       if (req->field_select &
>>>>> MLX5_HCA_VPORT_SEL_STATE_POLICY)
>>>>> +               MLX5_SET(hca_vport_context, ctx,
>>>>> vport_state_policy,
>>>>> +                        req->policy);
>>>>> +       if (req->field_select & MLX5_HCA_VPORT_SEL_PORT_GUID)
>>>>> +               MLX5_SET64(hca_vport_context, ctx, port_guid,
>>>>> req-
>>>>>> port_guid);
>>>>> +       if (req->field_select & MLX5_HCA_VPORT_SEL_NODE_GUID)
>>>>> +               MLX5_SET64(hca_vport_context, ctx, node_guid,
>>>>> req-
>>>>>> node_guid);
>>>>>            err = mlx5_cmd_exec(dev, in, in_sz, out,
>>>>> sizeof(out));
>>>>>     ex:
>>>>>            kfree(in);
>>>>>     
>>>>>
>>> Hi Max
>>> Re:
>>>
>>> "
>>> So I'm not sure that this commit is broken.
>>> ..
>>> ..
>>> I added prints to "mlx5_core_modify_hca_vport_context" function and
>>> found that we don't call it in "pure" mlx5 mode with PFs.
>>>
>>> Maybe you can try it too...
>>> "
>>>
>>> The thing is without this commit we connect immediately, no delay
>>> no
>>> issue and I am changing nothing else other than reverting here.
>>>
>>> So this clearly has a bearing directly on the functionality.
>>>
>>> I will look at adding more debug, but with this commit in there is
>>> nor
>>> evidence even of an attempt to connect and fail.
>>>
>>> Its silently faling.
>> please send me all the configuration steps you run after booting the
>> target + steps in the initiator (can be also in attached file).
>>
>> I'll try to follow this.
>>
>> Btw, did you try loopback initiator ?
>>
>> -Max.
>>
>>
>>> Regards
>>> Laurence
>>>
>>>
>>>
>>>
>>
> Hi Max
>
> Did not try loopback because here we have actual physical connectity as
> that is what our customers use.
>
> Connected back to back with MLX5 cx4 HCA dual ports at EDR 100
> Thi sis my standard configuration used for all upstream and Red Hat
> kernel testing.
>
> Reboot server and client and then first prepare server
>
> Server
> ----------
>
> the prepare.sh script run is after boot on the server
>
>
> #!/bin/bash
> ./load_modules.sh
> ./create_ramdisk.sh
> targetcli restoreconfig
> # Set the srp_sq_size
> for i in
> /sys/kernel/config/target/srpt/0xfe800000000000007cfe900300726e4e
> /sys/kernel/config/target/srpt/0xfe800000000000007cfe900300726e4f
> do
> 	echo 16384 > $i/tpgt_1/attrib/srp_sq_size
> done
>
> [root@fedstorage ~]# cat load_modules.sh
> #!/bin/bash
> modprobe mlx5_ib
> modprobe ib_srpt
> modprobe ib_srp
> modprobe ib_umad
>
> [root@fedstorage ~]# cat ./create_ramdisk.sh
> #!/bin/bash
> mount -t tmpfs -o size=130g tmpfs /mnt
> cd /mnt
> for i in `seq 1 30`; do dd if=/dev/zero of=block-$i bs=1024k count=4000
> ; done
>
>
>
> Client
> --------
>
> Once server is ready
>
> Run ./start_opensm.sh on client (I sont use the SM on a switch as we
> are back to back)
>
> [root@ibclient ~]# cat ./start_opensm.sh
> #!/bin/bash
> rmmod ib_srpt
> opensm -F opensm.1.conf &
> opensm -F opensm.2.conf &
>
> I will semail the conf only to you as well as the targecli config as th
> eout is long.
>
>
> Then run start_srp.sh
>
> [root@ibclient ~]# cat ./start_srp.sh
> run_srp_daemon  -V -f /etc/ddn/srp_daemon.conf -R 30 -T 10 -t 7000
> -ance -i mlx5_0 -p 1 1>/root/srp1.log 2>&1 &
> run_srp_daemon  -V -f /etc/ddn/srp_daemon.conf -R 30 -T 10 -t 7000
> -ance -i mlx5_1 -p 1 1>/root/srp2.log 2>&1 &
>
> [root@ibclient ~]# cat /etc/ddn/srp_daemon.conf
> a      queue_size=128,max_cmd_per_lun=32,max_sect=32768
>
>
I see that you're link is IB.

I was working on RoCE link layer with rdma_cm.

I'll try to find some free IB setup tomorrow in my lab..

Can you try login using rdma_cm ? need to load ib_ipoib for that in IB 
network.

I'm trying to understand whether it's related to the link layer.

p.s. I think the target configuration file didn't arrive.

>
>
