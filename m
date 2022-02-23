Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 624D64C1128
	for <lists+linux-rdma@lfdr.de>; Wed, 23 Feb 2022 12:20:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235699AbiBWLUm (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 23 Feb 2022 06:20:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233823AbiBWLUl (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 23 Feb 2022 06:20:41 -0500
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2086.outbound.protection.outlook.com [40.107.243.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 166018F62C
        for <linux-rdma@vger.kernel.org>; Wed, 23 Feb 2022 03:20:14 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=exMirvzDRT0a2L1vEPbOEKlIv2+96gzbDkhgaj6UW2o5POKezYCMWG2tiq3HCtgcmk7VtMNKUsEklqaZP6BbOy6wFaTrFpZmHLyzjeeMs4zPrSJYi55G+ciz9QjRoyyOENb5IxBf4xTOhnhjdqYSb/7JeD5i4wL9ECPonAuUH2SMvleK5ePaQuTaZVHtfdgx84hHqmgJjgZi20aybzQ0ylNY3XkWNkEGV+lHxTomc7y72Ux7GJf7D5hY4HO6gVXu6011dTb/jL27OI2yjOKCtTitvuZsn3+sMmU/Xl3Db0cw2p0IiH8NXB6HShw3T3dcJ9SuzpvMiumEyIi4dgmqqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kxcFKIQUQVcNA5Z2k1pdZmwAY3iKRkCebdOXQEAAJk0=;
 b=QpVsKqMW/nCwAi2R0mdVWNEOAF+ObTKeMxJY/yIBUzgI27I9WPMs042jnv8qOR+AR7vqU5TNn2XDq1EZ29Z2qcR2EXipHsXfC6CBJcD+CYfHVrqq7IgdBYjiYAaGc3+FQ7/VXzpL3mhj2DNJZRB6UVkXifT8j2KkGJChVNvr5YHp4kp8WT5teiWVf2eJJZpYuTpOndRl2Qn5n02eemA9kT6n5u9t688ne++1BWik+6/VA5jbbL0Hz7W/+OW/o3wyCybNS1vkTQT1lAwo9/OL3iWCxKWRDqb5joWCexECJCYKnZHL77Xr5xc/mmkvkrD5B62sVYMK4TbJGcB78iTkOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.238) smtp.rcpttodomain=lists.infradead.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kxcFKIQUQVcNA5Z2k1pdZmwAY3iKRkCebdOXQEAAJk0=;
 b=P1fDRa6vhbFdbJx0wU1cwkPtw6FoSscnxCmNimSUFx+2QfLHQkVpKiTqMOUxdExuHtNmKl7O26oDFEndO975YcOd3Sjs2YDbrAVBQHMuYUH0Zz4P2aWuhTVGPf9De9DMZwb6E59w9cQ/2bDNVlNxEwhT3dXvk76bCWi22FdvAqg5+A37qoyiAQM3v1j3mowZDq4wQ5fb3nooMGpomw0jAuu4CJjQ474H1M3rjXNFI4gsUIlqyy2FUXqHyDrxhNAsJbqvJdgL0cRT4w7RtRzFdakZOV26CusCP6KK0eVTPSm9NG+fH08t++JGikfugPdfx/5YMvHqLiYvI0+kgc2TAw==
Received: from BN6PR16CA0040.namprd16.prod.outlook.com (2603:10b6:405:14::26)
 by MW2PR12MB2380.namprd12.prod.outlook.com (2603:10b6:907:4::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.26; Wed, 23 Feb
 2022 11:20:12 +0000
Received: from BN8NAM11FT031.eop-nam11.prod.protection.outlook.com
 (2603:10b6:405:14:cafe::e4) by BN6PR16CA0040.outlook.office365.com
 (2603:10b6:405:14::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.19 via Frontend
 Transport; Wed, 23 Feb 2022 11:20:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.238)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.238 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.238; helo=mail.nvidia.com;
Received: from mail.nvidia.com (12.22.5.238) by
 BN8NAM11FT031.mail.protection.outlook.com (10.13.177.25) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.5017.22 via Frontend Transport; Wed, 23 Feb 2022 11:20:11 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by DRHQMAIL105.nvidia.com
 (10.27.9.14) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Wed, 23 Feb
 2022 11:20:09 +0000
Received: from [172.27.25.101] (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.9; Wed, 23 Feb 2022
 03:20:06 -0800
Message-ID: <7c11af1c-3f18-c776-3424-35990628770b@nvidia.com>
Date:   Wed, 23 Feb 2022 13:20:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [bug report] NVMe/IB: reset_controller need more than 1min
Content-Language: en-US
To:     Sagi Grimberg <sagi@grimberg.me>, Yi Zhang <yi.zhang@redhat.com>
CC:     Haakon Bugge <haakon.bugge@oracle.com>,
        Max Gurtovoy <maxg@mellanox.com>,
        "open list:NVM EXPRESS DRIVER" <linux-nvme@lists.infradead.org>,
        "OFED mailing list" <linux-rdma@vger.kernel.org>
References: <CAHj4cs8cT23z+h2i+g6o3OQqEhWnHS88JO4jNoQo0Nww-sdkYg@mail.gmail.com>
 <3292547e-2453-0320-c2e7-e17dbc20bbdd@nvidia.com>
 <CAHj4cs9QuANriWeLrhDvkahnNzHp-4WNFoxtWi2qGH9V0L3+Rw@mail.gmail.com>
 <fcad6dac-6d40-98d7-93e2-bfa307e8e101@nvidia.com>
 <CAHj4cs_WGP9q10d9GSzKQZi3uZCF+S8qW1sirWZWkkHuepgYgQ@mail.gmail.com>
 <2D31D2FB-BC4B-476A-9717-C02E84542DFA@oracle.com>
 <CAHj4cs-yt1+Lufqgwira-YbB6PHtJ=2JA_Vora_CfarzSzoFrA@mail.gmail.com>
 <4BB6D957-6C18-4E58-A622-0880007ECD9F@oracle.com>
 <CAHj4cs_ta5WR7j0qvHyr1tSCR-U7=svY5j8Hctd7YUMNcGXsaA@mail.gmail.com>
 <a2fabeb3-5f19-11b6-8c00-a479e3759182@grimberg.me>
 <bdb675e4-1de8-400b-9d43-9f0c18147dc4@nvidia.com>
 <CAHj4cs_C=pCz41hg1AnQcEZPBRK78WTUq8HE3n_28t56iN1FuA@mail.gmail.com>
 <fe9842f1-e5c7-7569-426e-9029662bb4f3@nvidia.com>
 <CAHj4cs8fNmj2Mn7Srs547ji51x7mQ8ZWKzFOuJaENe=vKpBJ-A@mail.gmail.com>
 <6347079f-ec3b-c2e5-bb3b-43b539d6d3f1@nvidia.com>
 <06a6c0ec-3d8b-75b0-7522-bfc10c3813e3@grimberg.me>
From:   Max Gurtovoy <mgurtovoy@nvidia.com>
In-Reply-To: <06a6c0ec-3d8b-75b0-7522-bfc10c3813e3@grimberg.me>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 86327039-c038-471f-73d9-08d9f6be74cc
X-MS-TrafficTypeDiagnostic: MW2PR12MB2380:EE_
X-Microsoft-Antispam-PRVS: <MW2PR12MB2380641A0C2192B445449BBCDE3C9@MW2PR12MB2380.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uu+11nJVyp3+MPakzHvcEg2sNVbgekvanK4apJ45jZMHYM6OJzaxt5c044jyzcMVz0IztUDfLhKKVLjIxdlqmMo85tqaC/LXs2dxVAKWpnWlF0UN56wfUlz3pAsZGigmKbf9/NxaJIYIISXhGO92mUj3EByVNl50O+3Ifed6QeRTcCLkB4UzslnIhQuxsVFfLHmrBzONQG5tTwaam/y5GkA5UtR/SPfY7jMMt2CaOc1t1kVvC35FKNn4ln9OI/AXDXDCHLFNMTE1dPiTVLKejtU5MgFnME08lf3m74d+YA9YcW/HUCT1vioCq6UVE4Ik63KuITetjPwb0fgszf8WDsrtFgoiuMDagUWaf0bJ1H0yI9I9wqLoMQ8nzM9TY15YLzIRkPTI90pHqbWKONdla4edIYtP3MtFYGa7te1HduJ0d71Hwb1TkG3hTT2u7L3f8C8Ap9O3XZK6fSV6RySzgFyDG5u2+5byUPHMaXKgYSUG6dMVw9FGrhxTQr5tiSN7iMtD9mZzRBEmVL1/JLIX/1gcXVQUzNCA0IrCfsn56787hJGDXGRJUEj+L7dsKfBTwBq9fFyMbVN/WWCcguUusI73iWuaID3BT6KkWl7qVrDwTP7YimBWnXkd16khH+zg2uwQoUc8THQFXLqap+HIi5AljdkplY2r8GFqNhLVg+yBdhyRPfldvj3VmDTULNnxs8djnmAhsVLTE9AAIeJ0AnrTeCXtCREBJU4ZSzt8Tk50/K4THhKo3HXP9qD0KuUQ
X-Forefront-Antispam-Report: CIP:12.22.5.238;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230001)(4636009)(36840700001)(40470700004)(46966006)(31696002)(5660300002)(336012)(70586007)(70206006)(8936002)(316002)(81166007)(356005)(16576012)(36756003)(426003)(4326008)(8676002)(40460700003)(82310400004)(508600001)(110136005)(186003)(16526019)(54906003)(53546011)(31686004)(6666004)(2616005)(2906002)(36860700001)(86362001)(83380400001)(47076005)(26005)(36900700001)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Feb 2022 11:20:11.1848
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 86327039-c038-471f-73d9-08d9f6be74cc
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.238];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT031.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR12MB2380
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


On 2/23/2022 12:30 PM, Sagi Grimberg wrote:
>
>> Hi Yi Zhang,
>>
>> thanks for testing the patches.
>>
>> Can you provide more info on the time it took with both kernels ?
>>
>> The patches don't intend to decrease this time but re-start the KA in 
>> early stage - as soon as we create the AQ.
>
> Still not sure why this addresses the problem, because every io queue
> connect should reset the keep alive timer in the target.

Right, in the NVMf connect. Not in transport connect.

You first allocate all IO queues (takes time) and only then nvmf_connect 
all IO queues.

In this time you probably get the timeout I guess.

between nvme_rdma_alloc_io_queues and nvme_rdma_start_io_queues there is 
no reason the admin_q can't send keep-alives.

This is what I tried pushing upstream few years ago...

Anyway, we shouldn't assume anything about the target implementation. We 
need to do our best to have a working initiator logic.

>
> But if at all, just move the keep alive start to nvme_init_ctrl_finish
> don't expose it to drivers...

Yes, back then there was no nvme_init_ctrl_finish code.


