Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 60FE23A94B2
	for <lists+linux-rdma@lfdr.de>; Wed, 16 Jun 2021 10:03:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231391AbhFPIGA (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 16 Jun 2021 04:06:00 -0400
Received: from mail-dm3nam07on2081.outbound.protection.outlook.com ([40.107.95.81]:3075
        "EHLO NAM02-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231290AbhFPIGA (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 16 Jun 2021 04:06:00 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NmwFDIdBW4Wwi3wq40GUAXpVaURpw/n7ZRojp8xsPae3hyvq8qP0vJOUNIgidXSny/UgtoJ+cpz3uewEpAN01D3dy8+ebhmPSsUbpqXK85iD66359hPcg4YPC+Lard3plfWQk+FBvkZe7nsA+2KutQ6u7GcF8NU/aKeYIjNc47n0IEFejxV/3J2o1z/qSQKgBea4QrLwjs77O3c7uNqsyU37N48V1f/czniQ0XCxcXkmLXyaAEF6BqrWWDQyxTBCfGJv4VttZVYKFES9yTVWqYJ4aKQuRnmA+jMjxJ0yIc4Wi2IkEn/xsDtjiD4/vPkr8S7aq1MF/c6H+RwQyLe5Qw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SgvsWPE31ohoJPjCpbNouT73ZuI2L+nvp13Ar4StSr4=;
 b=HHTOI9OwVlElp3ii8lvJG9Y7JSgFi7hY9skmdd4zYNNEx+xZA+BPww1VFW+5Dak0mFJ6micO/EBf/Sv3OaqRKHcyBEaoYN7VAfP3pAz57teN88QOlygmWr2brbdLKooA+k7XI9B6q473sJ4j5YUbLSdgADhYGaP/qkQ0p3BpBj09CJnbQ7zoWpxU0ccGLUD/uTSgA+jM7bAPxPW9xIbU51Sdx9qPhMEuZ67fB/w22fs+2yAx5epo1Gtx2oEXbZcIwEgXy6Dl38D0EtuNWSRPLGUMIoyrfmYVq03Wjt2EAbpt+gMXSscZO1dNhAqx4hH/izuwksD945oIo0iF95U7iQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.34) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SgvsWPE31ohoJPjCpbNouT73ZuI2L+nvp13Ar4StSr4=;
 b=mIBEeZHTyIJ0wAv8T6L83C2ovwVODQINyw+zAtBgEbt8PI1KkmPKaWEZ7OW3/b5xvbPB+ufxWpSINjEcZqPGLXVlf5cz+++B0N3b+bSssbDEe38yEGiDpQDfCPRESMSJaPuoCAKczf6ziFimVum64l8yGKClQTxC+UCrd3+Gb6ljCWO27wfifgv3Qjsn34b0a+f1oGNyEf9CrySFfFfjLG9GHPscyr0Y/VoGJ1PO3YDTlPZBrkvo1h3fqS+S52eZBV7T7yBTu21e7SzfaaLqBzLHpeN4ae2DHX9g+l9g+2oNUJZuDvhBSOGLjPVE8/yLp5U3xXGr85mIK7HSPDB0CA==
Received: from DM5PR19CA0056.namprd19.prod.outlook.com (2603:10b6:3:116::18)
 by BL1PR12MB5031.namprd12.prod.outlook.com (2603:10b6:208:31a::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.22; Wed, 16 Jun
 2021 08:03:52 +0000
Received: from DM6NAM11FT020.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:116:cafe::64) by DM5PR19CA0056.outlook.office365.com
 (2603:10b6:3:116::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.16 via Frontend
 Transport; Wed, 16 Jun 2021 08:03:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.34)
 smtp.mailfrom=nvidia.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.34 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.34; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.34) by
 DM6NAM11FT020.mail.protection.outlook.com (10.13.172.224) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4242.16 via Frontend Transport; Wed, 16 Jun 2021 08:03:52 +0000
Received: from [172.27.12.167] (172.20.187.6) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Wed, 16 Jun
 2021 08:03:50 +0000
Subject: Re: [PATCH rdma-core 2/4] mlx5: Implement
 ibv_query_qp_data_in_order() verb
From:   Yishai Hadas <yishaih@nvidia.com>
To:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
CC:     Maor Gottlieb <maorg@nvidia.com>,
        Patrisious Haddad <phaddad@nvidia.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Leon Romanovsky <leon@kernel.org>
References: <20210609155932.218005-1-yishaih@nvidia.com>
 <20210609155932.218005-3-yishaih@nvidia.com> <YMGoQ2ZmTjSun54y@unreal>
 <20210610114224.GJ1002214@nvidia.com> <YMH8mr6AWEuJceoj@unreal>
 <BN9PR12MB50522EC7EC780D64612D9668C3359@BN9PR12MB5052.namprd12.prod.outlook.com>
Message-ID: <ff380d91-6b91-9b9c-96ce-776e83ad2a70@nvidia.com>
Date:   Wed, 16 Jun 2021 11:03:48 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <BN9PR12MB50522EC7EC780D64612D9668C3359@BN9PR12MB5052.namprd12.prod.outlook.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [172.20.187.6]
X-ClientProxiedBy: HQMAIL101.nvidia.com (172.20.187.10) To
 HQMAIL107.nvidia.com (172.20.187.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f97e5d45-07e3-4466-915a-08d9309d480c
X-MS-TrafficTypeDiagnostic: BL1PR12MB5031:
X-Microsoft-Antispam-PRVS: <BL1PR12MB5031C0F947D1C293C0EB4934C30F9@BL1PR12MB5031.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rGR8+MVd0fPz1szIwXy0IxGEDfxpUtwnI8v10BeK1DTaLccTRrcYaFK5JCvS0iL/GSKyHg92uXkRubc8ghHKen3vXTnMo70/mZWdb7cBtpHlDKybZi/OEpV9/uHCC6F0pqVQB6YWcBMISDaiC3ofuuwfXGoUiPzKVGJmkJSy7u9KLvHg5ro/xAWCApA4ZNN2gej+JN1sgatUn32pIArAtIcyeZ70pbt1NCDlXriVvyDzp+G/yMaWCwWGtJYHXENL/BF/lCTQ5C98gW6eZfYpBc3SRFtM2dmwBmuUKR9cNrBGWmiAcWt8sUqkNLLZTW0OEs0/P4KYkFvsUA7zyOt3isQuyXcyYk8K7fJ6hlEaB7UGgkwkaebsvqXryvC/poB4Jcx1Vu4StG+ZqalDK5HcEvC1G96cKfjNKEJPHNcVEUYkPorxsSnvOxsvkQViIgTp3DeA2mFPVoyu82FznIvQF6R7TPCB3kl0Ubnvneuug2AP/UGXoT/aOe/RdTUOKqaMDpP0FusUJ0acWpPjssk4ir0GtEpAlpotqQOik7n3Vvqqg4JjbvK5un5z6vijiUOBEDfjEC8fAeppj+gSn4GGtWcqr5bxGmYXJQi85mOpteZwR7JtMUppCvPu30u4dYp7rB8h/rJKpbRA1XH6zRBFbZZ1Nb2tKZrGlgxt5EcOHGOMP/M4AC0tuBn7KOfsVHENitlyIlz2KZeMVuwivW9vnstW50v7MBDCVMcUN/JC5wudnuQ37/9i3kYFq37yk2KgXpJo2uz772xZCLXOd7xIDRMjWx6abF0AiRGprHpWyYEN04hxz+lmE8lCkDuTdW/y
X-Forefront-Antispam-Report: CIP:216.228.112.34;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid03.nvidia.com;CAT:NONE;SFS:(4636009)(376002)(136003)(39860400002)(346002)(396003)(36840700001)(46966006)(5660300002)(2616005)(31686004)(70206006)(83380400001)(70586007)(36860700001)(2906002)(36756003)(82740400003)(356005)(336012)(47076005)(4744005)(7636003)(8936002)(316002)(26005)(966005)(31696002)(82310400003)(478600001)(54906003)(16576012)(8676002)(4326008)(426003)(6916009)(53546011)(86362001)(186003)(36906005)(16526019)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2021 08:03:52.5398
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f97e5d45-07e3-4466-915a-08d9309d480c
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.34];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT020.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5031
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 6/10/2021 3:51 PM, Yishai Hadas wrote:
>> From: Leon Romanovsky <leon@kernel.org>
> <>
>
>>> We should probably put the above in the core code anyhow
>> Agree, it makes sense.
>>
> Thanks, the PR was updated accordingly.
> https://github.com/linux-rdma/rdma-core/pull/1009
>
> Yishai

The PR was merged.

Yishai

