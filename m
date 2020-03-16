Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6D3221874A6
	for <lists+linux-rdma@lfdr.de>; Mon, 16 Mar 2020 22:23:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732608AbgCPVXh (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 16 Mar 2020 17:23:37 -0400
Received: from mail-eopbgr60066.outbound.protection.outlook.com ([40.107.6.66]:42870
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1732567AbgCPVXh (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 16 Mar 2020 17:23:37 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZXnepZIwExEzqJzQGiF+KQINx6r9IUGtnNhjNIX+sLW+ibKefEZO+Jw7cOth8zRlA/jMS2i77wP+83eSg41Oxv06cmPpE0IDdX0iSTTPmyVuYNkbob6Bu45ri7zVWuYzjddy2Rb14Dl984maQ2DN+lolWorzu5AIvo0uPpBRG5xspOTrKPjQZWhhYs9OLzAnhoaZ/fQ4f24af+iM7fcDOrobbFIanWqsqtx+Rvy6olFK1Fx9cCYw0HnlszONg2tr+zZjISsZEn5LNQLwpMY/SGcgfLPIlNCBR6wrAhnJZSQT94ZbVfIo7nELb1IDZLJbC6zAnxF+VbcDKB87ly70gg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z5VAPnTpHTIo1Y9fZ+5KwdodHbNfF2pwtdsrNoLsZNs=;
 b=UaZFaVqXtmIIxIueukH3NG3qWKiQIacla4qRU8uGNKf3ZH8bfh3eHLgIPo3mxb1toMQSgW/ynk6n1yyhCmI2DjAWie65yZvCwhuJVbqfm9kuNvFfwPLxE50zXQ9jTq4kJ2TIX22wE53giHom3vr9imtFqYhLAKaGsJN93vttEBRfAfAv/uIyre5ZVI2XfapLtCMCQsZ09+9MWKAX1dLBewTQY/cxM/fQutLzhC3gzdCHNABdI53PJepnl5H/HhJ7c9iKlh4xZ/+yrnECgmlq2KGkHTGYjsyMwGjxlA0ASYELLFVQnWi/8aiuGgXMol6teyAL5gov6J9XR/T9oyi62Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 193.47.165.251) smtp.rcpttodomain=redhat.com smtp.mailfrom=mellanox.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=mellanox.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z5VAPnTpHTIo1Y9fZ+5KwdodHbNfF2pwtdsrNoLsZNs=;
 b=ZvHJUFmcz2BGNdqWmKpDlR33PK21Iw7U3/AO7dovK1aFliM3bCKn7E2dNnl3q3G2JUKgRwmSex1x+waRAiwmrRT6muc1D1aWh9vJF1p4iR0xQRTjBhlcGYvwmWtSrosgNA0ndan5YV7C1gcvt3ltC/vze1vRoIvY7GAkcsNHs2o=
Received: from DB8PR09CA0028.eurprd09.prod.outlook.com (2603:10a6:10:a0::41)
 by DB7PR05MB4218.eurprd05.prod.outlook.com (2603:10a6:5:1f::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2814.14; Mon, 16 Mar
 2020 21:23:27 +0000
Received: from DB5EUR03FT031.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:10:a0:cafe::47) by DB8PR09CA0028.outlook.office365.com
 (2603:10a6:10:a0::41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2814.16 via Frontend
 Transport; Mon, 16 Mar 2020 21:23:27 +0000
Authentication-Results: spf=pass (sender IP is 193.47.165.251)
 smtp.mailfrom=mellanox.com; redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=pass action=none header.from=mellanox.com;
Received-SPF: Pass (protection.outlook.com: domain of mellanox.com designates
 193.47.165.251 as permitted sender) receiver=protection.outlook.com;
 client-ip=193.47.165.251; helo=mtlcas13.mtl.com;
Received: from mtlcas13.mtl.com (193.47.165.251) by
 DB5EUR03FT031.mail.protection.outlook.com (10.152.20.142) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.2814.13 via Frontend Transport; Mon, 16 Mar 2020 21:23:27 +0000
Received: from MTLCAS13.mtl.com (10.0.8.78) by mtlcas13.mtl.com (10.0.8.78)
 with Microsoft SMTP Server (TLS) id 15.0.1178.4; Mon, 16 Mar 2020 23:23:26
 +0200
Received: from MTLCAS01.mtl.com (10.0.8.71) by MTLCAS13.mtl.com (10.0.8.78)
 with Microsoft SMTP Server (TLS) id 15.0.1178.4 via Frontend Transport; Mon,
 16 Mar 2020 23:23:26 +0200
Received: from [172.27.0.66] (172.27.0.66) by MTLCAS01.mtl.com (10.0.8.71)
 with Microsoft SMTP Server (TLS) id 14.3.468.0; Mon, 16 Mar 2020 23:22:53
 +0200
Subject: Re: commit ab118da4c10a70b8437f5c90ab77adae1835963e causes ib_srpt to
 fail connections served by target LIO
To:     Laurence Oberman <loberman@redhat.com>,
        Leon Romanovsky <leonro@mellanox.com>
CC:     rdmadev <rdma-dev-team@redhat.com>, <linux-rdma@vger.kernel.org>,
        linux-scsi <linux-scsi@vger.kernel.org>,
        "Van Assche, Bart" <bvanassche@acm.org>,
        Rupesh Girase <rgirase@redhat.com>
References: <88bab94d2fd72f3145835b4518bc63dda587add6.camel@redhat.com>
 <0bef0089-0c46-8fb7-9e44-61654c641cbd@mellanox.com>
 <e57c1763dd99ea958c9834a53ae5688a775c9444.camel@redhat.com>
 <6d5415e3-9314-331a-fade-7593c6a27290@mellanox.com>
 <8695fb0f34588616aded629127cc3fa2799fa7cb.camel@redhat.com>
 <918bc803-41d6-6eea-34e2-9e40f959a982@mellanox.com>
 <2a04cd1d66e6bc2edb96231b47499f4c1450e592.camel@redhat.com>
 <327df8af71afab4a2f9b6da804218d5a94cf6020.camel@redhat.com>
 <20200316072140.GD8510@unreal> <20200316073002.GE8510@unreal>
 <2e0bf1fb747a41ea817aaaa141e3410ced078548.camel@redhat.com>
From:   Max Gurtovoy <maxg@mellanox.com>
Message-ID: <c6581b28-469b-8efb-b5b4-526f6c39ddc9@mellanox.com>
Date:   Mon, 16 Mar 2020 23:22:53 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <2e0bf1fb747a41ea817aaaa141e3410ced078548.camel@redhat.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [172.27.0.66]
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:193.47.165.251;IPV:;CTRY:IL;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(346002)(376002)(396003)(39860400002)(136003)(199004)(46966005)(5660300002)(4326008)(26005)(70206006)(31686004)(31696002)(478600001)(110136005)(316002)(8936002)(81156014)(8676002)(81166006)(2616005)(30864003)(86362001)(6636002)(2906002)(186003)(54906003)(16526019)(70586007)(336012)(16576012)(356004)(53546011)(47076004)(36756003)(3940600001);DIR:OUT;SFP:1101;SCL:1;SRVR:DB7PR05MB4218;H:mtlcas13.mtl.com;FPR:;SPF:Pass;LANG:en;PTR:InfoDomainNonexistent;A:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6201294d-68f3-4520-b8a4-08d7c9f044ab
X-MS-TrafficTypeDiagnostic: DB7PR05MB4218:
X-Microsoft-Antispam-PRVS: <DB7PR05MB421894F3488B393AA28B3BB9B6F90@DB7PR05MB4218.eurprd05.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-Forefront-PRVS: 03449D5DD1
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dEwxVHV9ZPV1yce6eC19QZfH+VW7ZSIsghjsqGsv8ttsC0UTD71ioGuagEvEJdajnbfmt8JnFo88Zi85DOTLzhMi0hjzcdHH/3Ae07kO2ohz920Pff8eArEMrri0f6Tx5hTradvtFiJvTdyINMqo/iqr/bN2QKku/PDRZKc5G+OlelLOvN5bbsc1nGeJpp92y3DGXop7CXizaE/gzB+V7W0TD8FVHfyPF27vklBU0L5D+qlJtBxsUWhXilQgc99XIzhjylTmN3RuxZA9479RXotbNXgV47UDmRHV4v2vr4Yzg9xIdDD+t9WW0pE+Wsrr7ufDJnnwT172SKVGk+1mbBHDaVYirGo4TXxWEaU6xUkb+Ez/ni5zGeudeeb9/MagF2qWdAu4XXtianE0RyRQeffOgtOUP0rKVPKl/z+P3jZbqCrCKC2c2YBn/twBY1z3jFBTQrMvn2shlEMDgfU6xH6WQH/18H4+O2jJTbWWTcJqGG2nYvHR02VKTZY42D4j3jkRzNqTtJYVot/JjR8cNe/nWld8z9LsAgHcBNQ3/zg=
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Mar 2020 21:23:27.3930
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6201294d-68f3-4520-b8a4-08d7c9f044ab
X-MS-Exchange-CrossTenant-Id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=a652971c-7d2e-4d9b-a6a4-d149256f461b;Ip=[193.47.165.251];Helo=[mtlcas13.mtl.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR05MB4218
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


On 3/16/2020 9:18 PM, Laurence Oberman wrote:
> On Mon, 2020-03-16 at 09:30 +0200, Leon Romanovsky wrote:
>> On Mon, Mar 16, 2020 at 09:21:40AM +0200, Leon Romanovsky wrote:
>>> On Sun, Mar 15, 2020 at 05:56:17PM -0400, Laurence Oberman wrote:
>>>> On Sun, 2020-03-15 at 17:01 -0400, Laurence Oberman wrote:
>>>>> On Sun, 2020-03-15 at 22:40 +0200, Max Gurtovoy wrote:
>>>>>> On 3/15/2020 8:36 PM, Laurence Oberman wrote:
>>>>>>> On Sun, 2020-03-15 at 20:20 +0200, Max Gurtovoy wrote:
>>>>>>>> On 3/15/2020 7:59 PM, Laurence Oberman wrote:
>>>>>>>>> On Sun, 2020-03-15 at 18:47 +0200, Max Gurtovoy wrote:
>>>>>>>>>> On 3/14/2020 11:30 PM, Laurence Oberman wrote:
>>>>>>>>>>> Hello Bart, Leon and Max
>>>>>>>>>> Hi Laurence,
>>>>>>>>>>
>>>>>>>>>> thanks for the great analysis and the fast response
>>>>>>>>>> !!
>>>>>>>>>>
>>>>>>>>>>> Max had reached out to me to test a new set of
>>>>>>>>>>> patches
>>>>>>>>>>> for
>>>>>>>>>>> SRQ.
>>>>>>>>>>> I had not tested upstream ib_srpt on an LIO target
>>>>>>>>>>> for
>>>>>>>>>>> quite a
>>>>>>>>>>> while,
>>>>>>>>>>> only ib_srp client tests had been run of late.
>>>>>>>>>>> During a baseline test before applying Max's
>>>>>>>>>>> patches it
>>>>>>>>>>> was
>>>>>>>>>>> apparent
>>>>>>>>>>> that something had broken ib_srpt connections
>>>>>>>>>>> within LIO
>>>>>>>>>>> target
>>>>>>>>>>> since
>>>>>>>>>>> 5.5.
>>>>>>>>>>>
>>>>>>>>>>> Note thet ib_srp client connectivity with the
>>>>>>>>>>> commit
>>>>>>>>>>> functions
>>>>>>>>>>> fine,
>>>>>>>>>>> it's just the target that breaks with this commit.
>>>>>>>>>>>
>>>>>>>>>>> After a long bisect this is the commit that seems
>>>>>>>>>>> to
>>>>>>>>>>> break
>>>>>>>>>>> it.
>>>>>>>>>>> While it's not directly code in ib_srpt, its code
>>>>>>>>>>> in mlx5
>>>>>>>>>>> vport
>>>>>>>>>>> ethernet connectivity that then breaks ib_srpt
>>>>>>>>>>> connectivity
>>>>>>>>>>> over
>>>>>>>>>>> mlx5
>>>>>>>>>>> IB RDMA with LIO.
>>>>>>>>>> I was able to connect in loopback and also from
>>>>>>>>>> remote
>>>>>>>>>> initiator
>>>>>>>>>> with
>>>>>>>>>> this commit.
>>>>>>>>>>
>>>>>>>>>> So I'm not sure that this commit is broken.
>>>>>>>>>>
>>>>>>>>>> I used Bart's scripts to configure the target and to
>>>>>>>>>> connect
>>>>>>>>>> to
>>>>>>>>>> it
>>>>>>>>>> in
>>>>>>>>>> loopback (after some modifications for the updated
>>>>>>>>>> kernel/sysfs/configfs
>>>>>>>>>> interface).
>>>>>>>>>>
>>>>>>>>>> I did see an issue to connect from remote initiator,
>>>>>>>>>> but
>>>>>>>>>> after
>>>>>>>>>> reloading
>>>>>>>>>> openibd in the initiator side I was able to connect.
>>>>>>>>>>
>>>>>>>>>> So I suspect you had the same issue - that also
>>>>>>>>>> should be
>>>>>>>>>> debugged.
>>>>>>>>>>
>>>>>>>>>>> I will let Leon and others decide but reverting the
>>>>>>>>>>> below
>>>>>>>>>>> commit
>>>>>>>>>>> allows
>>>>>>>>>>> SRP connectivity to an LIO target to work again.
>>>>>>>>>> I added prints to
>>>>>>>>>> "mlx5_core_modify_hca_vport_context"
>>>>>>>>>> function
>>>>>>>>>> and
>>>>>>>>>> found that we don't call it in "pure" mlx5 mode with
>>>>>>>>>> PFs.
>>>>>>>>>>
>>>>>>>>>> Maybe you can try it too...
>>>>>>>>>>
>>>>>>>>>> I was able to check my patches on my system and I'll
>>>>>>>>>> send
>>>>>>>>>> them
>>>>>>>>>> soon.
>>>>>>>>>>
>>>>>>>>>> Thanks again Laurence and Bart.
>>>>>>>>>>
>>>>>>>>>>> Max, I will test your new patches once we have a
>>>>>>>>>>> decision
>>>>>>>>>>> on
>>>>>>>>>>> this.
>>>>>>>>>>>
>>>>>>>>>>> Client
>>>>>>>>>>> Linux ibclient.lab.eng.bos.redhat.com 5.6.0-rc5+ #1
>>>>>>>>>>> SMP
>>>>>>>>>>> Thu
>>>>>>>>>>> Mar
>>>>>>>>>>> 12
>>>>>>>>>>> 16:58:19 EDT 2020 x86_64 x86_64 x86_64 GNU/Linux
>>>>>>>>>>>
>>>>>>>>>>> Server with reverted commit
>>>>>>>>>>> Linux fedstorage.bos.redhat.com 5.6.0-rc5+ #1 SMP
>>>>>>>>>>> Sat Mar
>>>>>>>>>>> 14
>>>>>>>>>>> 16:39:35
>>>>>>>>>>> EDT 2020 x86_64 x86_64 x86_64 GNU/Linux
>>>>>>>>>>>
>>>>>>>>>>> commit ab118da4c10a70b8437f5c90ab77adae1835963e
>>>>>>>>>>> Author: Leon Romanovsky <leonro@mellanox.com>
>>>>>>>>>>> Date:   Wed Nov 13 12:03:47 2019 +0200
>>>>>>>>>>>
>>>>>>>>>>>         net/mlx5: Don't write read-only fields in
>>>>>>>>>>> MODIFY_HCA_VPORT_CONTEXT
>>>>>>>>>>> command
>>>>>>>>>>>
>>>>>>>>>>>         The MODIFY_HCA_VPORT_CONTEXT uses
>>>>>>>>>>> field_selector
>>>>>>>>>>> to
>>>>>>>>>>> mask
>>>>>>>>>>> fields
>>>>>>>>>>> needed
>>>>>>>>>>>         to be written, other fields are required to
>>>>>>>>>>> be
>>>>>>>>>>> zero
>>>>>>>>>>> according
>>>>>>>>>>> to
>>>>>>>>>>> the
>>>>>>>>>>>         HW specification. The supported fields are
>>>>>>>>>>> controlled by
>>>>>>>>>>> bitfield
>>>>>>>>>>>         and limited to vport state, node and port
>>>>>>>>>>> GUIDs.
>>>>>>>>>>>
>>>>>>>>>>>         Signed-off-by: Leon Romanovsky <
>>>>>>>>>>> leonro@mellanox.com>
>>>>>>>>>>>         Signed-off-by: Saeed Mahameed <
>>>>>>>>>>> saeedm@mellanox.com
>>>>>>>>>>> diff --git
>>>>>>>>>>> a/drivers/net/ethernet/mellanox/mlx5/core/vport.c
>>>>>>>>>>> b/drivers/net/ethernet/mellanox/mlx5
>>>>>>>>>>> index 30f7848..1faac31f 100644
>>>>>>>>>>> ---
>>>>>>>>>>> a/drivers/net/ethernet/mellanox/mlx5/core/vport.c
>>>>>>>>>>> +++
>>>>>>>>>>> b/drivers/net/ethernet/mellanox/mlx5/core/vport.c
>>>>>>>>>>> @@ -1064,26 +1064,13 @@ int
>>>>>>>>>>> mlx5_core_modify_hca_vport_context(struct
>>>>>>>>>>> mlx5_core_dev *dev,
>>>>>>>>>>>
>>>>>>>>>>>             ctx =
>>>>>>>>>>> MLX5_ADDR_OF(modify_hca_vport_context_in,
>>>>>>>>>>> in,
>>>>>>>>>>> hca_vport_context);
>>>>>>>>>>>             MLX5_SET(hca_vport_context, ctx,
>>>>>>>>>>> field_select,
>>>>>>>>>>> req-
>>>>>>>>>>>> field_select);
>>>>>>>>>>> -       MLX5_SET(hca_vport_context, ctx,
>>>>>>>>>>> sm_virt_aware,
>>>>>>>>>>> req-
>>>>>>>>>>>> sm_virt_aware);
>>>>>>>>>>> -       MLX5_SET(hca_vport_context, ctx, has_smi,
>>>>>>>>>>> req-
>>>>>>>>>>>> has_smi);
>>>>>>>>>>> -       MLX5_SET(hca_vport_context, ctx, has_raw,
>>>>>>>>>>> req-
>>>>>>>>>>>> has_raw);
>>>>>>>>>>> -       MLX5_SET(hca_vport_context, ctx,
>>>>>>>>>>> vport_state_policy,
>>>>>>>>>>> req-
>>>>>>>>>>>> policy);
>>>>>>>>>>> -       MLX5_SET(hca_vport_context, ctx,
>>>>>>>>>>> port_physical_state,
>>>>>>>>>>> req-
>>>>>>>>>>>> phys_state);
>>>>>>>>>>> -       MLX5_SET(hca_vport_context, ctx,
>>>>>>>>>>> vport_state,
>>>>>>>>>>> req-
>>>>>>>>>>>> vport_state);
>>>>>>>>>>> -       MLX5_SET64(hca_vport_context, ctx,
>>>>>>>>>>> port_guid,
>>>>>>>>>>> req-
>>>>>>>>>>>> port_guid);
>>>>>>>>>>> -       MLX5_SET64(hca_vport_context, ctx,
>>>>>>>>>>> node_guid,
>>>>>>>>>>> req-
>>>>>>>>>>>> node_guid);
>>>>>>>>>>> -       MLX5_SET(hca_vport_context, ctx, cap_mask1,
>>>>>>>>>>> req-
>>>>>>>>>>>> cap_mask1);
>>>>>>>>>>> -       MLX5_SET(hca_vport_context, ctx,
>>>>>>>>>>> cap_mask1_field_select,
>>>>>>>>>>> req-
>>>>>>>>>>>> cap_mask1_perm);
>>>>>>>>>>> -       MLX5_SET(hca_vport_context, ctx, cap_mask2,
>>>>>>>>>>> req-
>>>>>>>>>>>> cap_mask2);
>>>>>>>>>>> -       MLX5_SET(hca_vport_context, ctx,
>>>>>>>>>>> cap_mask2_field_select,
>>>>>>>>>>> req-
>>>>>>>>>>>> cap_mask2_perm);
>>>>>>>>>>> -       MLX5_SET(hca_vport_context, ctx, lid, req-
>>>>>>>>>>>> lid);
>>>>>>>>>>> -       MLX5_SET(hca_vport_context, ctx,
>>>>>>>>>>> init_type_reply,
>>>>>>>>>>> req-
>>>>>>>>>>>> init_type_reply);
>>>>>>>>>>> -       MLX5_SET(hca_vport_context, ctx, lmc, req-
>>>>>>>>>>>> lmc);
>>>>>>>>>>> -       MLX5_SET(hca_vport_context, ctx,
>>>>>>>>>>> subnet_timeout,
>>>>>>>>>>> req-
>>>>>>>>>>>> subnet_timeout);
>>>>>>>>>>> -       MLX5_SET(hca_vport_context, ctx, sm_lid,
>>>>>>>>>>> req-
>>>>>>>>>>>> sm_lid);
>>>>>>>>>>> -       MLX5_SET(hca_vport_context, ctx, sm_sl,
>>>>>>>>>>> req-
>>>>>>>>>>>> sm_sl);
>>>>>>>>>>> -       MLX5_SET(hca_vport_context, ctx,
>>>>>>>>>>> qkey_violation_counter,
>>>>>>>>>>> req-
>>>>>>>>>>>> qkey_violation_counter);
>>>>>>>>>>> -       MLX5_SET(hca_vport_context, ctx,
>>>>>>>>>>> pkey_violation_counter,
>>>>>>>>>>> req-
>>>>>>>>>>>> pkey_violation_counter);
>>>>>>>>>>> +       if (req->field_select &
>>>>>>>>>>> MLX5_HCA_VPORT_SEL_STATE_POLICY)
>>>>>>>>>>> +               MLX5_SET(hca_vport_context, ctx,
>>>>>>>>>>> vport_state_policy,
>>>>>>>>>>> +                        req->policy);
>>>>>>>>>>> +       if (req->field_select &
>>>>>>>>>>> MLX5_HCA_VPORT_SEL_PORT_GUID)
>>>>>>>>>>> +               MLX5_SET64(hca_vport_context, ctx,
>>>>>>>>>>> port_guid,
>>>>>>>>>>> req-
>>>>>>>>>>>> port_guid);
>>>>>>>>>>> +       if (req->field_select &
>>>>>>>>>>> MLX5_HCA_VPORT_SEL_NODE_GUID)
>>>>>>>>>>> +               MLX5_SET64(hca_vport_context, ctx,
>>>>>>>>>>> node_guid,
>>>>>>>>>>> req-
>>>>>>>>>>>> node_guid);
>>>>>>>>>>>             err = mlx5_cmd_exec(dev, in, in_sz, out,
>>>>>>>>>>> sizeof(out));
>>>>>>>>>>>      ex:
>>>>>>>>>>>             kfree(in);
>>>>>>>>>>>
>>>>>>>>>>>
>>>>>>>>> Hi Max
>>>>>>>>> Re:
>>>>>>>>>
>>>>>>>>> "
>>>>>>>>> So I'm not sure that this commit is broken.
>>>>>>>>> ..
>>>>>>>>> ..
>>>>>>>>> I added prints to "mlx5_core_modify_hca_vport_context"
>>>>>>>>> function
>>>>>>>>> and
>>>>>>>>> found that we don't call it in "pure" mlx5 mode with
>>>>>>>>> PFs.
>>>>>>>>>
>>>>>>>>> Maybe you can try it too...
>>>>>>>>> "
>>>>>>>>>
>>>>>>>>> The thing is without this commit we connect
>>>>>>>>> immediately, no
>>>>>>>>> delay
>>>>>>>>> no
>>>>>>>>> issue and I am changing nothing else other than
>>>>>>>>> reverting
>>>>>>>>> here.
>>>>>>>>>
>>>>>>>>> So this clearly has a bearing directly on the
>>>>>>>>> functionality.
>>>>>>>>>
>>>>>>>>> I will look at adding more debug, but with this commit
>>>>>>>>> in
>>>>>>>>> there
>>>>>>>>> is
>>>>>>>>> nor
>>>>>>>>> evidence even of an attempt to connect and fail.
>>>>>>>>>
>>>>>>>>> Its silently faling.
>>>>>>>> please send me all the configuration steps you run after
>>>>>>>> booting
>>>>>>>> the
>>>>>>>> target + steps in the initiator (can be also in attached
>>>>>>>> file).
>>>>>>>>
>>>>>>>> I'll try to follow this.
>>>>>>>>
>>>>>>>> Btw, did you try loopback initiator ?
>>>>>>>>
>>>>>>>> -Max.
>>>>>>>>
>>>>>>>>
>>>>>>>>> Regards
>>>>>>>>> Laurence
>>>>>>>>>
>>>>>>>>>
>>>>>>>>>
>>>>>>>>>
>>>>>>> Hi Max
>>>>>>>
>>>>>>> Did not try loopback because here we have actual physical
>>>>>>> connectity as
>>>>>>> that is what our customers use.
>>>>>>>
>>>>>>> Connected back to back with MLX5 cx4 HCA dual ports at EDR
>>>>>>> 100
>>>>>>> Thi sis my standard configuration used for all upstream and
>>>>>>> Red
>>>>>>> Hat
>>>>>>> kernel testing.
>>>>>>>
>>>>>>> Reboot server and client and then first prepare server
>>>>>>>
>>>>>>> Server
>>>>>>> ----------
>>>>>>>
>>>>>>> the prepare.sh script run is after boot on the server
>>>>>>>
>>>>>>>
>>>>>>> #!/bin/bash
>>>>>>> ./load_modules.sh
>>>>>>> ./create_ramdisk.sh
>>>>>>> targetcli restoreconfig
>>>>>>> # Set the srp_sq_size
>>>>>>> for i in
>>>>>>> /sys/kernel/config/target/srpt/0xfe800000000000007cfe900300
>>>>>>> 726e4e
>>>>>>> /sys/kernel/config/target/srpt/0xfe800000000000007cfe900300
>>>>>>> 726e4f
>>>>>>> do
>>>>>>> 	echo 16384 > $i/tpgt_1/attrib/srp_sq_size
>>>>>>> done
>>>>>>>
>>>>>>> [root@fedstorage ~]# cat load_modules.sh
>>>>>>> #!/bin/bash
>>>>>>> modprobe mlx5_ib
>>>>>>> modprobe ib_srpt
>>>>>>> modprobe ib_srp
>>>>>>> modprobe ib_umad
>>>>>>>
>>>>>>> [root@fedstorage ~]# cat ./create_ramdisk.sh
>>>>>>> #!/bin/bash
>>>>>>> mount -t tmpfs -o size=130g tmpfs /mnt
>>>>>>> cd /mnt
>>>>>>> for i in `seq 1 30`; do dd if=/dev/zero of=block-$i
>>>>>>> bs=1024k
>>>>>>> count=4000
>>>>>>> ; done
>>>>>>>
>>>>>>>
>>>>>>>
>>>>>>> Client
>>>>>>> --------
>>>>>>>
>>>>>>> Once server is ready
>>>>>>>
>>>>>>> Run ./start_opensm.sh on client (I sont use the SM on a
>>>>>>> switch as
>>>>>>> we
>>>>>>> are back to back)
>>>>>>>
>>>>>>> [root@ibclient ~]# cat ./start_opensm.sh
>>>>>>> #!/bin/bash
>>>>>>> rmmod ib_srpt
>>>>>>> opensm -F opensm.1.conf &
>>>>>>> opensm -F opensm.2.conf &
>>>>>>>
>>>>>>> I will semail the conf only to you as well as the targecli
>>>>>>> config
>>>>>>> as th
>>>>>>> eout is long.
>>>>>>>
>>>>>>>
>>>>>>> Then run start_srp.sh
>>>>>>>
>>>>>>> [root@ibclient ~]# cat ./start_srp.sh
>>>>>>> run_srp_daemon  -V -f /etc/ddn/srp_daemon.conf -R 30 -T 10
>>>>>>> -t
>>>>>>> 7000
>>>>>>> -ance -i mlx5_0 -p 1 1>/root/srp1.log 2>&1 &
>>>>>>> run_srp_daemon  -V -f /etc/ddn/srp_daemon.conf -R 30 -T 10
>>>>>>> -t
>>>>>>> 7000
>>>>>>> -ance -i mlx5_1 -p 1 1>/root/srp2.log 2>&1 &
>>>>>>>
>>>>>>> [root@ibclient ~]# cat /etc/ddn/srp_daemon.conf
>>>>>>> a      queue_size=128,max_cmd_per_lun=32,max_sect=32768
>>>>>>>
>>>>>>>
>>>>>> I see that you're link is IB.
>>>>>>
>>>>>> I was working on RoCE link layer with rdma_cm.
>>>>>>
>>>>>> I'll try to find some free IB setup tomorrow in my lab..
>>>>>>
>>>>>> Can you try login using rdma_cm ? need to load ib_ipoib for
>>>>>> that in
>>>>>> IB
>>>>>> network.
>>>>>>
>>>>>> I'm trying to understand whether it's related to the link
>>>>>> layer.
>>>>>>
>>>>>> p.s. I think the target configuration file didn't arrive.
>>>>>>
>>>>>>>
>>>>>>
>>>>> Max,
>>>>>
>>>>> Yes, I am, working primarily with SCSI over RDMA Protocol with
>>>>> Infiniband HCA's in IB mode.
>>>>> I am not using ROCE.
>>>>>
>>>>> Also lets not forget this is a target only issue, the latest
>>>>> 5.6
>>>>> kernel
>>>>> runs untouched with no issues on the initiator when the target
>>>>> runs
>>>>> either 5.4 or 5.6 with the revert.
>>>>> It would run fine with the target on 5.5 as well if I reverted
>>>>> the
>>>>> commit on 5.5 too.
>>>>>
>>>>> I am not able at this time to switch these adapters to Ethernet
>>>>> mode
>>>>> and ROCE
>>>>>
>>>>> The weird thing is the failure is completely silent so
>>>>> something in
>>>>> the
>>>>> Link layer with IB has to failing early.
>>>>> Thje other strange observation is that the IB interfaces come
>>>>> up with
>>>>> no issue.
>>>>> I will try add some debug after reboot into the failing kernel.
>>>>>
>>>>> Regards
>>>>> Laurence
>>>>>
>>>>>
>>>>>
>>>> Max,
>>>> Rupesh in cc here will be testing latest upstream on a
>>>> client/server
>>>> configuration with ROCE and report back here on if he sees a
>>>> similar
>>>> issue with the LIO target with that commit.
>>>>
>>>> I will continue working on the IB srpt issue by adding some
>>>> debug.
>>>>
>>>> If you think about anything related to the commit let me know.
>>> Laurence,
>>>
>>> As I said above, the most chances are that I removed some RW
>>> initialization that wasn't protected by field_select and wasn't
>>> marked in our PRM as RW field.
>>>
>>> The question is which one.
>> I think that I know what is missing.
>> Can you please try this patch?
>>
>> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/vport.c
>> b/drivers/net/ethernet/mellanox/mlx5/core/vport.c
>> index 1faac31f74d0..23f879da9104 100644
>> --- a/drivers/net/ethernet/mellanox/mlx5/core/vport.c
>> +++ b/drivers/net/ethernet/mellanox/mlx5/core/vport.c
>> @@ -1071,6 +1071,9 @@ int mlx5_core_modify_hca_vport_context(struct
>> mlx5_core_dev *dev,
>>                  MLX5_SET64(hca_vport_context, ctx, port_guid, req-
>>> port_guid);
>>          if (req->field_select & MLX5_HCA_VPORT_SEL_NODE_GUID)
>>                  MLX5_SET64(hca_vport_context, ctx, node_guid, req-
>>> node_guid);
>> +       MLX5_SET(hca_vport_context, ctx, cap_mask1, req->cap_mask1);
>> +       MLX5_SET(hca_vport_context, ctx, cap_mask1_field_select,
>> +                req->cap_mask1_perm);
>>          err = mlx5_cmd_exec(dev, in, in_sz, out, sizeof(out));
>>   ex:
>>          kfree(in);
>>
>>
>>> Thanks
>>>
>>>> Regards
>>>> Laurence
>>>>
>>
> Leon,
>
> That patch does resolve the issue.
> Tested with CX4 with mlx5 with SRP over IB to LIO target.
> Please add a fixes to that commit tag with this one when you send it.

Great Laurence !

thanks for the effort.

Eventually it was helpful that we both run on different link layers :)


>
> Reviewed-by: Laurence Oberman <loberman@redhat.com>
> Tested-by:   Laurence Oberman <loberman@redhat.com>
>
> Thanks very much
> Laurence
>
>
