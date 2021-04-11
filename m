Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA17D35B43E
	for <lists+linux-rdma@lfdr.de>; Sun, 11 Apr 2021 14:33:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231405AbhDKMds (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 11 Apr 2021 08:33:48 -0400
Received: from mail-dm6nam12on2083.outbound.protection.outlook.com ([40.107.243.83]:47744
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229804AbhDKMds (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Sun, 11 Apr 2021 08:33:48 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UNhgn3t9Cwk469w2cnFfzOxArpLEzqsmwBnydZPUOra/+NKDqZegqoA4JaiZg2YVAzKPfcUxG//8hMPBe/ysiC/WfB0ifJwWGB+UCcEr7h8kpqwjMfWCLAE2V9WF0OvH0lDeymJzEXQvrC0oYR2A9fKeEAVtUt3nbN1xqCn0mCiBWt1PZXFvhuYmKGHearqHT4PPdrHCYN/D2BTN+dkRGlvU/KvZFurgNRvawd87L5bsyPdJWvZr8ajvCfDJd0ikWuruyT/YVUX0AP2pdusMIhb/n0NMWNkzNRiA2wKuFRKvRQPeNZbJItlOSQ4X22TCcYbad/3Yan46VrBBiyYZdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4W1YL/QEh88dJJNY3S6TZ67icl9fbk6s1HGuf7VF3gM=;
 b=aB1aps5VvC3ky563JfwD/EfLc1UWDxIMVJFrvz2TK9gJGCgz91ZqJTyeOlkbIfcaxfSUkm6AYh2CMB2BFH3GUeApXuxlS/NF/wu8IbolwgJj5psjXvKVCLCcMcAf1kOfqn3iTT2cMfAK/04LM0+LBuk5XuDG8avzGic0B8eo3J7Oc50mAQcijZJJyMUzNVAkPz6VGaWrxaRhAZPIQaVjPYVVKUEKZlJFtbeGJKnU5JrXmmBcy8EBoxH6JMM1jGfEARIl4RAsmhqXTsLJbMJb3QI7F9iSQDx/Cln6JxSTktF9DiBu2JyUeWNci8JX4XpvoWVxFprUCs43PJfpQ85JAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.34) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4W1YL/QEh88dJJNY3S6TZ67icl9fbk6s1HGuf7VF3gM=;
 b=FdSJKrJv12K4PFX7nLSoVL2K8nvSHfL4YJX2pBPvSUPeBIw5ZqtZxq6mMpJ09R21GzdLCwAWCV5aGMisbBWLUIR39GD/aKyGdRvYb/ByaPm6uKtfXMQrLOeOEU2wRXbr+v1xUpOIsvAj+DgWBNO8VZ3WfArKdt1DU1LmW2o24/pubFAwAppI+6eyrkybEov1pBfdusumwjb0WLpbumlb0XXeLeYQxkAbFSRijcxuNEAQo31yTUVBOvBI3OE6sXlMW4pyglF4WcOIhXFCNEC2DJ8QR5E/mq4q37ydbiM+4pAvNvZKaE8X/BsdJbo58rYLdCrqKhWcq6d/Ttyv+Tlimw==
Received: from BN9PR03CA0660.namprd03.prod.outlook.com (2603:10b6:408:13b::35)
 by BN8PR12MB3202.namprd12.prod.outlook.com (2603:10b6:408:9c::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.22; Sun, 11 Apr
 2021 12:33:30 +0000
Received: from BN8NAM11FT039.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:13b:cafe::84) by BN9PR03CA0660.outlook.office365.com
 (2603:10b6:408:13b::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.17 via Frontend
 Transport; Sun, 11 Apr 2021 12:33:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.34)
 smtp.mailfrom=nvidia.com; redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.34 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.34; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.34) by
 BN8NAM11FT039.mail.protection.outlook.com (10.13.177.169) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4020.17 via Frontend Transport; Sun, 11 Apr 2021 12:33:30 +0000
Received: from [172.27.12.228] (172.20.145.6) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Sun, 11 Apr
 2021 12:33:27 +0000
Subject: Re: [PATCH rdma-next v2] RDMA/mlx5: Expose private query port
To:     Leon Romanovsky <leon@kernel.org>, Jason Gunthorpe <jgg@nvidia.com>
CC:     Doug Ledford <dledford@redhat.com>, Mark Bloch <mbloch@nvidia.com>,
        <linux-api@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
        Maor Gottlieb <maorg@nvidia.com>
References: <20210401085004.577338-1-leon@kernel.org>
 <20210408185412.GA678376@nvidia.com> <YHLg+1vkClbhGMod@unreal>
From:   Yishai Hadas <yishaih@nvidia.com>
Message-ID: <7127b73e-b5f5-15be-b87c-11bbbd149c0b@nvidia.com>
Date:   Sun, 11 Apr 2021 15:33:24 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <YHLg+1vkClbhGMod@unreal>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [172.20.145.6]
X-ClientProxiedBy: HQMAIL111.nvidia.com (172.20.187.18) To
 HQMAIL107.nvidia.com (172.20.187.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9383a33b-4083-42db-3689-08d8fce603aa
X-MS-TrafficTypeDiagnostic: BN8PR12MB3202:
X-Microsoft-Antispam-PRVS: <BN8PR12MB32028B4CC98CAC8475EA805CC3719@BN8PR12MB3202.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4714;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oGF2ZiiVYONEy/iikzjFpNqPD9w5aRV9m3WWTALucyBodvV0YFDeGIEfLnpEz/q1Rj3EYqXSkYsZMX/5UkB1lQpFIiHU8dM8MqBimgaH3cse1zcJmlSMtKgaa6erKa+E1rI9cBiyqKyOOaWQzzmcmBhRMWZSNwxT760wNlmzLIG3FjiaA6b6BtscSIQRNa1I8LfYO0EqAIvASgYXn2jGBj6Ty7HFggWio3m1g4/74HBDBOjAm5QH8LJGpNj3Ojp/e0bWlRT6RvPUHJskJl3kkaeBmIH8+OMYgq5OBpVGcLXsO6OqzSREe+36poROP1GFO9avr4Vfb/SI9UVUvO5pDeb564whk2pnPI5i9HKpbm+a2JYxobc7BTs2hN0AjnlHceP3TIPO1+Ju7IUQzkh1eMvOm2jIn6itpykMXIzcwjnTSSavb9PZCTHPs8J7nGU4Q6MZZ04Qkvqe3ACmiv3oUdrBBfVuZmnEA7kwNjWoZ5DLLXIsvYQ2cHTICJRt3MFyERViH10n8S+wG7N2u6feoev9lyVehKPMH0G3MqYfLbAf+9IlJVDJKAUvx98wivHfX/SnXNBBRaAAfC1I68O+tEYsVpgkQpNnUyvARU3TUFAP393pFFwHvftliDjKy5EPzhCt1dDVVj5R6Sx4ErOZ8GPuSs3KYT2xb/tv6PPmEwzlsCuwa92d/YCQMzGR3O8ZPaDYHW/GFTzJeEPniESS918+cE6yYcms0A/zO5JBkES+pCrO31MdVMTdVCcJKtVZ64tKAo38rj6zeqMMXpJ62Q==
X-Forefront-Antispam-Report: CIP:216.228.112.34;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid03.nvidia.com;CAT:NONE;SFS:(4636009)(346002)(376002)(39860400002)(396003)(136003)(36840700001)(46966006)(316002)(31696002)(2906002)(36906005)(16576012)(54906003)(110136005)(36756003)(70586007)(31686004)(70206006)(4326008)(26005)(5660300002)(82740400003)(107886003)(8676002)(2616005)(336012)(53546011)(426003)(16526019)(186003)(478600001)(36860700001)(8936002)(966005)(86362001)(6666004)(82310400003)(7636003)(83380400001)(6636002)(356005)(47076005)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2021 12:33:30.5310
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9383a33b-4083-42db-3689-08d8fce603aa
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.34];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT039.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB3202
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 4/11/2021 2:43 PM, Leon Romanovsky wrote:
> On Thu, Apr 08, 2021 at 03:54:12PM -0300, Jason Gunthorpe wrote:
>> On Thu, Apr 01, 2021 at 11:50:04AM +0300, Leon Romanovsky wrote:
>>> From: Mark Bloch <mbloch@nvidia.com>
>>>
>>> Expose a non standard query port via IOCTL that will be used to expose
>>> port attributes that are specific to mlx5 devices.
>>>
>>> The new interface receives a port number to query and returns a
>>> structure that contains the available attributes for that port.
>>> This will be used to fill the gap between pure DEVX use cases
>>> and use cases where a kernel needs to inform userspace about
>>> various kernel driver configurations that userspace must use
>>> in order to work correctly.
>>>
>>> Flags is used to indicate which fields are valid on return.
>>>
>>> MLX5_IB_UAPI_QUERY_PORT_VPORT:
>>> 	The vport number of the queered port.
>>>
>>> MLX5_IB_UAPI_QUERY_PORT_VPORT_VHCA_ID:
>>> 	The VHCA ID of the vport of the queered port.
>>>
>>> MLX5_IB_UAPI_QUERY_PORT_VPORT_STEERING_ICM_RX:
>>> 	The vport's RX ICM address used for sw steering.
>>>
>>> MLX5_IB_UAPI_QUERY_PORT_VPORT_STEERING_ICM_TX:
>>> 	The vport's TX ICM address used for sw steering.
>>>
>>> MLX5_IB_UAPI_QUERY_PORT_VPORT_REG_C0:
>>> 	The metadata used to tag egress packets of the vport.
>>>
>>> MLX5_IB_UAPI_QUERY_PORT_ESW_OWNER_VHCA_ID:
>>> 	The E-Switch owner vhca id of the vport.
>>>
>>> Reviewed-by: Maor Gottlieb <maorg@nvidia.com>
>>> Signed-off-by: Mark Bloch <mbloch@nvidia.com>
>>> Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
>>> ---
>>> Changelog:
>>> v2:
>>>   * Changed __u64 to be __aligned_u64 in the uapi header
>>> v1: https://lore.kernel.org/linux-api/20210322093932.398466-1-leon@kernel.org
>>>   * Missed sw_owner check for CX-6 device, fixed it.
>>> v0: https://lore.kernel.org/linux-api/20210318135221.681014-1-leon@kernel.org
>>> ---
>>>   drivers/infiniband/hw/mlx5/std_types.c    | 177 ++++++++++++++++++++++
>>>   include/uapi/rdma/mlx5_user_ioctl_cmds.h  |   9 ++
>>>   include/uapi/rdma/mlx5_user_ioctl_verbs.h |  25 +++
>>>   3 files changed, 211 insertions(+)
>> Where is the rdma-core part of this? Did I miss it someplace?
> Ne, the rdma-core series wasn't sent because of requestedchanges
> in the PR https://github.com/linux-rdma/rdma-core/pull/958.
>

The matching PR is now available here [1].

[1] https://github.com/linux-rdma/rdma-core/pull/977

Yishai

