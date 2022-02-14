Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 143904B4FC2
	for <lists+linux-rdma@lfdr.de>; Mon, 14 Feb 2022 13:12:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241615AbiBNMMO (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 14 Feb 2022 07:12:14 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:46754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232654AbiBNMMN (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 14 Feb 2022 07:12:13 -0500
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2060.outbound.protection.outlook.com [40.107.236.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4F8E48E58
        for <linux-rdma@vger.kernel.org>; Mon, 14 Feb 2022 04:12:04 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bwwFrl4SjLGeVTSIQkLyD2HAOYuOChjkwloi8WTVAYrA0hqE4f1yP/R28OU176F6qx/GaLJiIr4sMrtV379xfaQAGXWrKI3HYErwT5Dgo9yzyUuRdYRJExGCeucehTVmxvaZ9fXkcI7SFHdQBnRHyq4mIQKhi2nvTOKV5q14nkyXGbnnXk9X2sl30RmU8Keom/e0bjgAsUVA5BhNUUgyFBbODEetbgp+Ax23BI065y+egYy0bBlh26u+EIk8bV7BVnZi0rsN/GMGjzPMaikFfAloNRfkPHgB5jQtg6jK9FI/NAEWnAPlCMGCjWVUpw5IRag/uDKvf4fe49S2yH2F7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VQsX46HRP+hwsuLDPRH2jF6cbmut89huVS4KXIX8g9g=;
 b=hvOwLxxdXo3B9eGroOuUOXOB4xuqbvdVAgYBrbxF5igfJw76kkcYv1f67lSQAjRT6P6NcEQrHH2CTPo7/OPSWK5i7nkgok5vHW8rR7w12oiuJlBKTyM/goWPdRjI1LNvDHRWXnQsABislI9XS96TVqNvo90P7GbXNAWPlpuZyYz23p7oNcldMtKN60BIxaUxZ77TfQ8KYIfXURvOjowGuG7ZuZtagkJ3xRpIWAcSNUyrj9whX8PuioaitClZmDDOdDKfdaqY/OmRzvp8P1/dIeZseVrkuxLFmzuU8mJ6dFaSL0ms9trzu0KdEmMO7IrajDWaLxUjV3ok0HmIZJYWIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.236) smtp.rcpttodomain=lists.infradead.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VQsX46HRP+hwsuLDPRH2jF6cbmut89huVS4KXIX8g9g=;
 b=HUfvgEsGDcGzSo7hlClAsa92S7U5mod8MdS3G4QOvd9yHetBWcMHvxnIB+t/bibbYk79x2xTW+8o2mfUKKHODlc6yf4gbXN7JZpPekmrppmbHuBHbJfWHpGSzhJKWumUcZRFwldM0d3/D7GQj+ffDipMZKgi+pc3lwez3RKJj06bvMcYXtAPtNFG5jtBH5ikYetvOCc4h4p74dgy9xX0ywc9PKRQEEZeCbx3zT3KJG6VRF0psVrQWt6z7OPfHWpiXfzvse7kRVl5sdxsu2Elw649bJfCIh/HqKu2rrMG8+E/grmf4wrRTZmIGzAitS6OQEO0gpWyWCPNyhCHBnNvVw==
Received: from MW4PR03CA0146.namprd03.prod.outlook.com (2603:10b6:303:8c::31)
 by CH0PR12MB5122.namprd12.prod.outlook.com (2603:10b6:610:bd::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.15; Mon, 14 Feb
 2022 12:12:03 +0000
Received: from CO1NAM11FT045.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8c:cafe::e4) by MW4PR03CA0146.outlook.office365.com
 (2603:10b6:303:8c::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.13 via Frontend
 Transport; Mon, 14 Feb 2022 12:12:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.236)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.236 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.236; helo=mail.nvidia.com;
Received: from mail.nvidia.com (12.22.5.236) by
 CO1NAM11FT045.mail.protection.outlook.com (10.13.175.181) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4975.11 via Frontend Transport; Mon, 14 Feb 2022 12:12:02 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by DRHQMAIL109.nvidia.com
 (10.27.9.19) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Mon, 14 Feb
 2022 12:12:01 +0000
Received: from [172.27.14.120] (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.9; Mon, 14 Feb 2022
 04:11:59 -0800
Message-ID: <bdb675e4-1de8-400b-9d43-9f0c18147dc4@nvidia.com>
Date:   Mon, 14 Feb 2022 14:11:56 +0200
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
 <CAHj4cs8wBwDGhhtEPodyBdR-sCqJLYhwLhNHuPDm+KCan0hwWg@mail.gmail.com>
 <42ccd095-b552-32f7-96b0-d34d46f7c83e@grimberg.me>
 <CAHj4cs9EazUmtbjPKp5TXO4kRPcSShiYbhmsHwfh7SOTQAeoyw@mail.gmail.com>
 <c6d43a10-44bc-e73a-8836-d75367df049b@grimberg.me>
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
From:   Max Gurtovoy <mgurtovoy@nvidia.com>
In-Reply-To: <a2fabeb3-5f19-11b6-8c00-a479e3759182@grimberg.me>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c0278a76-b4c8-4a98-cf31-08d9efb3357d
X-MS-TrafficTypeDiagnostic: CH0PR12MB5122:EE_
X-Microsoft-Antispam-PRVS: <CH0PR12MB5122CDF79970469FD8FDB1B0DE339@CH0PR12MB5122.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3276;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UfFU8xqQD24ZAM3pF37TiIH+54vZ2opUBWsX7lF6/lNaP50ssT1mnEfbp5gbYJgyykq+2DQlBZhGF/5pq0uR/uwlz91FMihmrRnE2LeeOx0S6wmDH2wiX8xvSpwGm2ATw9PpxE9nEh+wthVg+0QtibYunanDTA3Yya3UVMTJFzdAvR6nT9NnpluBjokaBbnEcjYFtscStQeeenNmpOGf//IJB81yKQz6op/LVoSfblE7ysz/NoPHKZHSrgUYS3mwyZRUhBDzdErlpgj6lov/ADpBt7SlCtkw5SwznFntweOA+T40uRephDmGq0Qq33K7s81ZiRUVVspnABNYmDI1ebIb3BRBgcjGZ5LeYPzEDeljpsNUKNB+YsSyp0KHHDHLzW1TqGYHZH+Uhfi9WX34IZmUaUYKUdOB4gvDHmo63UA8Lg+vzA0UZJ6U/irzn0Lwqz1Va5gXLAe1LqJtxr5GmiXn8zJ7GMwkpOfcDlkMETJzpX3cIsDa3tqXhGexexfKE+JPoCNMclg8hsHittjKyfZa8zDzx0x95hcUiLSgSJJVN90AVzfGdxWFx5OLYh912VAy8+6LtsbovWkBHDo5zYNydTfN4FQQvdvnnUMtQfFjA1Jo/Lzsf6E2juMa8CMsXe/rNB61arfRXuWSgCl3x1EulJImuOwNkm+wzfa0+v/U3SRIidDyEc9S/R1dJXla0ZCVwcH13uNpLCMNatZmFjWWq0w9ROtDD8+jghnKJn7OhOXYHFE7S2WfDvlU878y
X-Forefront-Antispam-Report: CIP:12.22.5.236;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230001)(4636009)(36840700001)(46966006)(40470700004)(356005)(26005)(186003)(36860700001)(53546011)(81166007)(6666004)(2616005)(16526019)(83380400001)(47076005)(82310400004)(426003)(336012)(70586007)(31696002)(5660300002)(2906002)(8936002)(86362001)(36756003)(40460700003)(31686004)(54906003)(508600001)(110136005)(16576012)(8676002)(4326008)(316002)(70206006)(43740500002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2022 12:12:02.4007
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c0278a76-b4c8-4a98-cf31-08d9efb3357d
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.236];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT045.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5122
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


On 2/14/2022 1:32 PM, Sagi Grimberg wrote:
>
>> Hi Sagi/Max
>> Here are more findings with the bisect:
>>
>> The time for reset operation changed from 3s[1] to 12s[2] after
>> commit[3], and after commit[4], the reset operation timeout at the
>> second reset[5], let me know if you need any testing for it, thanks.
>
> Does this at least eliminate the timeout?
> -- 
> diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
> index a162f6c6da6e..60e415078893 100644
> --- a/drivers/nvme/host/nvme.h
> +++ b/drivers/nvme/host/nvme.h
> @@ -25,7 +25,7 @@ extern unsigned int nvme_io_timeout;
>  extern unsigned int admin_timeout;
>  #define NVME_ADMIN_TIMEOUT     (admin_timeout * HZ)
>
> -#define NVME_DEFAULT_KATO      5
> +#define NVME_DEFAULT_KATO      10
>
>  #ifdef CONFIG_ARCH_NO_SG_CHAIN
>  #define  NVME_INLINE_SG_CNT  0
> -- 
>
or for the initial test you can use --keep-alive-tmo=<10 or 15> flag in 
the connect command

>>
>> [1]
>> # time nvme reset /dev/nvme0
>>
>> real 0m3.049s
>> user 0m0.000s
>> sys 0m0.006s
>> [2]
>> # time nvme reset /dev/nvme0
>>
>> real 0m12.498s
>> user 0m0.000s
>> sys 0m0.006s
>> [3]
>> commit 5ec5d3bddc6b912b7de9e3eb6c1f2397faeca2bc (HEAD)
>> Author: Max Gurtovoy <maxg@mellanox.com>
>> Date:   Tue May 19 17:05:56 2020 +0300
>>
>>      nvme-rdma: add metadata/T10-PI support
>>
>> [4]
>> commit a70b81bd4d9d2d6c05cfe6ef2a10bccc2e04357a (HEAD)
>> Author: Hannes Reinecke <hare@suse.de>
>> Date:   Fri Apr 16 13:46:20 2021 +0200
>>
>>      nvme: sanitize KATO setting-
>
> This change effectively changed the keep-alive timeout
> from 15 to 5 and modified the host to send keepalives every
> 2.5 seconds instead of 5.
>
> I guess that in combination that now it takes longer to
> create and delete rdma resources (either qps or mrs)
> it starts to timeout in setups where there are a lot of
> queues.
