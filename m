Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AAD8F3D09FD
	for <lists+linux-rdma@lfdr.de>; Wed, 21 Jul 2021 09:48:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235294AbhGUHHN (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 21 Jul 2021 03:07:13 -0400
Received: from mail-bn1nam07on2054.outbound.protection.outlook.com ([40.107.212.54]:4071
        "EHLO NAM02-BN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S235277AbhGUHHG (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 21 Jul 2021 03:07:06 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hXCYqFooWuZX+z6Vebu4lcfU5r1YiyWbN7pk9YvFPZ388gMlhB7NUKkdBiA2uK2GaX6GeUQLU3wOie1alLUMQSbyZM3iDkZhd3VM86Yzt4SKIVnXxji7KMVc1mv0CRmfSGk5BTeSUftIxJHnl1/HmSkj9NvIM0r8Xd0c1YzM6NmSLhK82+m7fuD4I9Jkmi9mmGtI6NiU05gMGyh4L1k0TEedURJBYdRK0XKlFbmBQmpD3OoiciGugxpUbLZnxIkRnQMl2wV9Ps3fU5kGG7BEkhYBZMD/FfrimkuQKVCvJ6OEHr9mtBK7mQQPIdArU+6Zaz/bpzEHQ9C5NS6Lvr0cCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1lfyzGJlpDrvE/782ZcavAe+EItWQeE3HR/p4pfiFDA=;
 b=CH2CgcU/jLpGIpA0dMjDnMFHiMCkLC62qGv/W0R8rSubqHbWM//ay7W6r5jKcLL6DENeVzvpHOT6Ouse8jinsNqBPEI+Y/yQek5dMVHJwbgqpCxFMiPvH41dukXpbDqW41GYg0vVvwoCdp8PCG7+R23vNYf7RCF8pmCP6xEtYZewtaL1ZW/9L7vmzTn5DT1qXig9rMXRpLgbFCsoIi7mKEsWp8XmUAciDqutXqBKBkzHSHcxBbyeyu5GR31zQg0K6pFA0VWimfFz8/rNt88mc1IoO4U3TMZM1DbWSCP6u0ePVam1zcrJ9u9Xk2tMNVY4iBbXYmz8EfYUNqGTQt9dQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.34) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1lfyzGJlpDrvE/782ZcavAe+EItWQeE3HR/p4pfiFDA=;
 b=fJMf24oLsXulXeuwpWiCOv/Bqvf4CxX4QVj70ks3FL1MMOe1dCgpdG+/BT6nD1RFazslvPSSJeMKMbbtimdj3V0OMdDlOAOY68sC/QcT/NocBeow6Z1+i6/G3RuEfiuvClCIKWuzBlTif7pzMkZLaSPjmpmGDrkXxcyTVY+c3ly+zbx37QyI2+AHZGI1ok3X8nb3LVhndGVldcQFtejNcEMRNUQ65M06Ds+TbaihiXPUr8JcFyj0exWaL0HEQdHeHmBPeuYXdZ3UIAi/eHk3LHH8OehR1u4UmGIDfwF3NuQSV2xjTszQOhrOFGeU1KZokIoI1mw3h4NFTQo9hzLxCQ==
Received: from BN9PR03CA0013.namprd03.prod.outlook.com (2603:10b6:408:fa::18)
 by BN6PR12MB1523.namprd12.prod.outlook.com (2603:10b6:405:10::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.25; Wed, 21 Jul
 2021 07:47:40 +0000
Received: from BN8NAM11FT040.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:fa:cafe::33) by BN9PR03CA0013.outlook.office365.com
 (2603:10b6:408:fa::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.21 via Frontend
 Transport; Wed, 21 Jul 2021 07:47:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.34)
 smtp.mailfrom=nvidia.com; redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.34 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.34; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.34) by
 BN8NAM11FT040.mail.protection.outlook.com (10.13.177.166) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4352.24 via Frontend Transport; Wed, 21 Jul 2021 07:47:39 +0000
Received: from [172.27.8.104] (172.20.187.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Wed, 21 Jul
 2021 07:47:37 +0000
Subject: Re: [PATCH rdma-next 4/7] RDMA/core: Reorganize create QP low-level
 functions
To:     Leon Romanovsky <leon@kernel.org>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>
CC:     Leon Romanovsky <leonro@nvidia.com>,
        <linux-kernel@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
        Mark Zhang <markz@mellanox.com>
References: <cover.1626846795.git.leonro@nvidia.com>
 <328963df8e30bfc040c846d2c7626becd341f3ec.1626846795.git.leonro@nvidia.com>
From:   Mark Zhang <markzhang@nvidia.com>
Message-ID: <11e8e739-99b4-8ebe-38e1-de36b21b0f25@nvidia.com>
Date:   Wed, 21 Jul 2021 15:47:34 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <328963df8e30bfc040c846d2c7626becd341f3ec.1626846795.git.leonro@nvidia.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [172.20.187.5]
X-ClientProxiedBy: HQMAIL111.nvidia.com (172.20.187.18) To
 HQMAIL107.nvidia.com (172.20.187.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b0b617a5-4770-4131-44b5-08d94c1bd0e2
X-MS-TrafficTypeDiagnostic: BN6PR12MB1523:
X-Microsoft-Antispam-PRVS: <BN6PR12MB152378BE080B7507AACDB2E2C7E39@BN6PR12MB1523.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: a59SIHnmQQSxV/nvkKZGFSbaSn8ec1r6hPmyjTwjoIVNFTMIK0GQPVgzYruG+HdgQi85xS9SpzMFj0rmSvg7YNYhdnFWxShfb9gmtY276sUSKLWPQbkiHadV6kqk/wOV0luPADwOf3wtMuYZCTvlZR/JQhyYI3Z5eMPVqE4A3m7p9N0T1n7/C3HSnMY/juaNkemZZo12I9UwPIm5tL9dSzyekP2dYGpeCHl413wZjFtZtgcM3y7h+qfqwCcrasJRfBl9mywkkLMm0/cgKl9ofTIrz6Mnve1TQSf4tLJO1cAMtoHPu4zKewo5dh5DojKuEfZ8ozpEFIx1H+ochYmyktFt8MBQOXQgdcU3zq1slutv6PZMQ2bVfsaLsh9za2K6NMMjdmYQwW0HRYRy0+nm3uB4m+IzC2kHHgXQPt0hnKeM9wnVuuE8Na7ubNzpZrlpS62KCyOU1NM6Y5bjudI6raxne/pmb12HvPQId4Qmc6WgENvFjtn+3BMpacMo14NM6Ic2w4YvvuNnAn+Lnrimo1KQASLnUlXfGgAg71pIVEgAH5yXCXCDiyuBlSjesVISeXVf3DKVIJfA+0wpDRNoJcDsPP9624HV/LCg+/PU8wZpq81BXzkr+56kldbp+RQhsmp61/xStOOEtmf4iuEYzZ0BVeSsDA5Ki9GultCvp0/jsx6RPdPgCbhxj0hxOxY0ZR0DJfCtiGQe7g/gx3VbTnO/r48Bjqz+WErEyFGdSBo=
X-Forefront-Antispam-Report: CIP:216.228.112.34;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid03.nvidia.com;CAT:NONE;SFS:(4636009)(396003)(376002)(136003)(39860400002)(346002)(46966006)(36840700001)(426003)(5660300002)(31686004)(26005)(4744005)(6636002)(2616005)(70586007)(53546011)(82310400003)(2906002)(356005)(36906005)(316002)(478600001)(16576012)(6666004)(110136005)(186003)(54906003)(16526019)(336012)(36756003)(86362001)(47076005)(4326008)(36860700001)(82740400003)(31696002)(8676002)(70206006)(107886003)(8936002)(7636003)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2021 07:47:39.8895
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b0b617a5-4770-4131-44b5-08d94c1bd0e2
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.34];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT040.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1523
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 7/21/2021 2:13 PM, Leon Romanovsky wrote:
> External email: Use caution opening links or attachments
> 
> 
> From: Leon Romanovsky <leonro@nvidia.com>
> 
> The low-level create QP function grew to be larger than any sensible
> incline function should be. The inline attribute is not really needed
> for that function and can be implemented as exported symbol.

incline -> inline?


