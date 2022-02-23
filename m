Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 763474C0FCD
	for <lists+linux-rdma@lfdr.de>; Wed, 23 Feb 2022 11:04:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239478AbiBWKEu (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 23 Feb 2022 05:04:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239473AbiBWKEu (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 23 Feb 2022 05:04:50 -0500
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2046.outbound.protection.outlook.com [40.107.243.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A5A68A329
        for <linux-rdma@vger.kernel.org>; Wed, 23 Feb 2022 02:04:22 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M1vZnjbAY8PBxWh2Tao/K6N2CTurnwAAXKM39xWi+5Up211j0OsJR80t3ycv9HyaZlCNd7erB2/1ZcsRcoeI5x3W9f+lp959Yme2k57+Yzn/Axw0WGmpL/1j3gF/cHFRmjgI2nZ0hLmL47EFrfdNcwxBRV7tlTRH7ltiSSLK7L0wdErU6p5j8m19uhWwCXASvuFJV3F0HCh/biw/Q+MmRCEw6EkMauXuGRk2g+vM4vyRneEbdjbRp9SMwa/utBkULygFw22pK0C31zh5krtyjkF1qtviihxb+7jdf6byLMbuzT0yUViezpAeDc1ylS+58V1eN9tvtZ/BeQKroDXwlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DsRPkUWYIOGP5HltC36wpLF+8yoR/fScMRNacSzdBjg=;
 b=kZuj3NPm/MaUiZX3CaHkvCM8LeUqBwBrhIib2wmonJ+qTr+tbkUzh/Tso2yFCImK07QUkbrm+vw7wdS3+CXAVdj65q22bwPDmBQm3XKJcsja5knjVHnjjDNggSckgYdW0Q21/R7NRhCDahGnaDtUbGu4sX0qOBdKzUcDn1w9k0kL8aC056m7yfLMZ02hwoF6TqjA7WiQotIa+0MUI6Ux0qKeuw0fDHNVwpb+A9HtJoVxOm+HqUKTb4jpVtqIzsz4g3FrCXeJlvDr3qFqEV7JjKw1EHvanciCUzAXvHJdyZMKZ9f+5rLujxlPeXv6tx5bY3iqxAB2iOhaO9VOVCjLrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.235) smtp.rcpttodomain=lists.infradead.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DsRPkUWYIOGP5HltC36wpLF+8yoR/fScMRNacSzdBjg=;
 b=gV45su14fw/qWJn5qmAmkMNVJ6rEHaoGK3az+LG0LGCmGm6ZkkdyACor3Kz38FMJOeeby9Js5F5xtgDu91ZGlv6BjnU2QAf1SinFCTwJHq0LXJxxQGAh7/3lj1W1oc7g5mtkj9hXfXXEfEb9QFbByWwJrOulsTmMCNuCFXX0fJTF/+W01WM3N6lI5Y/6c4n/NXoqBr7OLNq96OX++QCGdcXIEcBdyeMDCyXYoCYqqpIgGHUUuarfauIkCIkDMsdJx6XZ2isZfbO1BseR+4skqJDsxJUb5NYTwuieEaRtjuK0VEq5qZ/E3DcOfOYaz+X4TNle0NlysT4akoZ+A89Xjw==
Received: from BN9PR03CA0083.namprd03.prod.outlook.com (2603:10b6:408:fc::28)
 by SN6PR12MB2669.namprd12.prod.outlook.com (2603:10b6:805:70::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.17; Wed, 23 Feb
 2022 10:04:20 +0000
Received: from BN8NAM11FT021.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:fc:cafe::90) by BN9PR03CA0083.outlook.office365.com
 (2603:10b6:408:fc::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.21 via Frontend
 Transport; Wed, 23 Feb 2022 10:04:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.235)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.235 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.235; helo=mail.nvidia.com;
Received: from mail.nvidia.com (12.22.5.235) by
 BN8NAM11FT021.mail.protection.outlook.com (10.13.177.114) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.5017.22 via Frontend Transport; Wed, 23 Feb 2022 10:04:19 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by DRHQMAIL107.nvidia.com
 (10.27.9.16) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Wed, 23 Feb
 2022 10:04:18 +0000
Received: from [172.27.25.101] (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.9; Wed, 23 Feb 2022
 02:04:15 -0800
Message-ID: <6347079f-ec3b-c2e5-bb3b-43b539d6d3f1@nvidia.com>
Date:   Wed, 23 Feb 2022 12:04:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [bug report] NVMe/IB: reset_controller need more than 1min
Content-Language: en-US
To:     Yi Zhang <yi.zhang@redhat.com>
CC:     Sagi Grimberg <sagi@grimberg.me>,
        Haakon Bugge <haakon.bugge@oracle.com>,
        Max Gurtovoy <maxg@mellanox.com>,
        "open list:NVM EXPRESS DRIVER" <linux-nvme@lists.infradead.org>,
        OFED mailing list <linux-rdma@vger.kernel.org>
References: <CAHj4cs8cT23z+h2i+g6o3OQqEhWnHS88JO4jNoQo0Nww-sdkYg@mail.gmail.com>
 <162ec7c5-9483-3f53-bd1c-502ff5ac9f87@nvidia.com>
 <CAHj4cs_kCorBjHcvamhZLBNXP2zWE0n_e-3wLwb-ERfpJWJxUA@mail.gmail.com>
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
From:   Max Gurtovoy <mgurtovoy@nvidia.com>
In-Reply-To: <CAHj4cs8fNmj2Mn7Srs547ji51x7mQ8ZWKzFOuJaENe=vKpBJ-A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.126.230.35]
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f6c8325b-2016-4552-05e7-08d9f6b3dbdc
X-MS-TrafficTypeDiagnostic: SN6PR12MB2669:EE_
X-Microsoft-Antispam-PRVS: <SN6PR12MB26696DBADF578373EB1E8F7BDE3C9@SN6PR12MB2669.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 28wyA58pW6ENM5gFrAeQyrS9AG3Tp9/0B8qRI30l3zZLidd9xGaavHZHGrOpxPaMDrf7MJzQOgQI7HX0dT4K17od5VvHqXp+gwXNhSMGznA+Gezs+pmMXuW97yN6kAN4YxOfdEQIwEJTAlMGm5YbV13I8wSajPXUyj9n857RyAbmbd2RWcOWHtmXvBfKww0URTTekCL5C9CbehOxPjJMGn8Pi0d+NjRPlnlOKrm6wlIaTK7B5XlwcjVWicbI/HZc9S5agVDETPY7wW5utA/FTgWJvTyjfVjxx3UQzDThKJL2Zxd74qp2v81X3U2sGyOAGYAtVKfnFmW83bW1PVh8qkJ0ymQak6kf0j+lWT6taGhWNjOe0pNMtGRjGzZcMEVWfnVWtgWcy48/ouIEj2CpPO02M8MUUQ6k4ZR5xhnOQ5Nv3y8wyqbwIdmXH6pmhFzrXR3rUy6aQxuWlLwp6WYeV2IKNeD9viJzejKAKVHZrV99MZThaiUgfWdkt5dOTMtyOMXwkY0fbO1u2V9hXU1iuWl65zVrTl3a1H5X9eyDsl8mppJjjEVB0yPyCRGqXXPfmQHluu8/acb+HXwhpvD0QkPG5G/RV1iPeBAmecq+64GYp6cqcmhM7NU//YggorygYLRDAoFbe3CfeHBagMb0PIrVgPTVNWsalXmfFfptRydFLQeezF/+hXETGsHXPatL+1RwOQoo3PYH96shV6rJigN8omPvlzQjkY/D/V7cKzclqHUlvgA1S1mFHkdZ3GYU
X-Forefront-Antispam-Report: CIP:12.22.5.235;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230001)(4636009)(36840700001)(40470700004)(46966006)(4326008)(86362001)(356005)(81166007)(31686004)(31696002)(6666004)(36756003)(36860700001)(53546011)(83380400001)(70206006)(2906002)(26005)(336012)(70586007)(316002)(186003)(426003)(2616005)(508600001)(16576012)(6916009)(54906003)(82310400004)(5660300002)(47076005)(16526019)(8936002)(8676002)(40460700003)(43740500002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Feb 2022 10:04:19.5969
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f6c8325b-2016-4552-05e7-08d9f6b3dbdc
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.235];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT021.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2669
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

Hi Yi Zhang,

thanks for testing the patches.

Can you provide more info on the time it took with both kernels ?

The patches don't intend to decrease this time but re-start the KA in 
early stage - as soon as we create the AQ.

I guess we need to debug it offline.

On 2/21/2022 12:00 PM, Yi Zhang wrote:
> Hi Max
>
> The patch fixed the timeout issue when I use one non-debug kernel,
> but when I tested on debug kernel with your patches, the timeout still
> can be triggered with "nvme reset/nvme disconnect-all" operations.
>
> On Tue, Feb 15, 2022 at 10:31 PM Max Gurtovoy <mgurtovoy@nvidia.com> wrote:
>> Thanks Yi Zhang.
>>
>> Few years ago I've sent some patches that were supposed to fix the KA
>> mechanism but eventually they weren't accepted.
>>
>> I haven't tested it since but maybe you can run some tests with it.
>>
>> The attached patches are partial and include only rdma transport for
>> your testing.
>>
>> If it work for you we can work on it again and argue for correctness.
>>
>> Please don't use the workaround we suggested earlier with these patches.
>>
>> -Max.
>>
>> On 2/15/2022 3:52 PM, Yi Zhang wrote:
>>> Hi Sagi/Max
>>>
>>> Changing the value to 10 or 15 fixed the timeout issue.
>>> And the reset operation still needs more than 12s on my environment, I
>>> also tried disabling the pi_enable, the reset operation will be back
>>> to 3s, so seems the added 9s was due to the PI enabled code path.
>>>
>>> On Mon, Feb 14, 2022 at 8:12 PM Max Gurtovoy <mgurtovoy@nvidia.com> wrote:
>>>> On 2/14/2022 1:32 PM, Sagi Grimberg wrote:
>>>>>> Hi Sagi/Max
>>>>>> Here are more findings with the bisect:
>>>>>>
>>>>>> The time for reset operation changed from 3s[1] to 12s[2] after
>>>>>> commit[3], and after commit[4], the reset operation timeout at the
>>>>>> second reset[5], let me know if you need any testing for it, thanks.
>>>>> Does this at least eliminate the timeout?
>>>>> --
>>>>> diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
>>>>> index a162f6c6da6e..60e415078893 100644
>>>>> --- a/drivers/nvme/host/nvme.h
>>>>> +++ b/drivers/nvme/host/nvme.h
>>>>> @@ -25,7 +25,7 @@ extern unsigned int nvme_io_timeout;
>>>>>    extern unsigned int admin_timeout;
>>>>>    #define NVME_ADMIN_TIMEOUT     (admin_timeout * HZ)
>>>>>
>>>>> -#define NVME_DEFAULT_KATO      5
>>>>> +#define NVME_DEFAULT_KATO      10
>>>>>
>>>>>    #ifdef CONFIG_ARCH_NO_SG_CHAIN
>>>>>    #define  NVME_INLINE_SG_CNT  0
>>>>> --
>>>>>
>>>> or for the initial test you can use --keep-alive-tmo=<10 or 15> flag in
>>>> the connect command
>>>>
>>>>>> [1]
>>>>>> # time nvme reset /dev/nvme0
>>>>>>
>>>>>> real 0m3.049s
>>>>>> user 0m0.000s
>>>>>> sys 0m0.006s
>>>>>> [2]
>>>>>> # time nvme reset /dev/nvme0
>>>>>>
>>>>>> real 0m12.498s
>>>>>> user 0m0.000s
>>>>>> sys 0m0.006s
>>>>>> [3]
>>>>>> commit 5ec5d3bddc6b912b7de9e3eb6c1f2397faeca2bc (HEAD)
>>>>>> Author: Max Gurtovoy <maxg@mellanox.com>
>>>>>> Date:   Tue May 19 17:05:56 2020 +0300
>>>>>>
>>>>>>        nvme-rdma: add metadata/T10-PI support
>>>>>>
>>>>>> [4]
>>>>>> commit a70b81bd4d9d2d6c05cfe6ef2a10bccc2e04357a (HEAD)
>>>>>> Author: Hannes Reinecke <hare@suse.de>
>>>>>> Date:   Fri Apr 16 13:46:20 2021 +0200
>>>>>>
>>>>>>        nvme: sanitize KATO setting-
>>>>> This change effectively changed the keep-alive timeout
>>>>> from 15 to 5 and modified the host to send keepalives every
>>>>> 2.5 seconds instead of 5.
>>>>>
>>>>> I guess that in combination that now it takes longer to
>>>>> create and delete rdma resources (either qps or mrs)
>>>>> it starts to timeout in setups where there are a lot of
>>>>> queues.
>
>
