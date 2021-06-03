Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5997439A091
	for <lists+linux-rdma@lfdr.de>; Thu,  3 Jun 2021 14:10:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229818AbhFCMM1 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 3 Jun 2021 08:12:27 -0400
Received: from mail-co1nam11on2079.outbound.protection.outlook.com ([40.107.220.79]:5344
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229790AbhFCMM0 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 3 Jun 2021 08:12:26 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K/EXRn18rgsiUNazgYuB9tfJtBL4MYxW6P5hiNt/1oJ4gzhX5NM/wcaKdtrcVfho+4iybxbx4NT3uM7k8VBRktB/EM/qDkL5IAmBY55khOjorL+n1T6ud36y5QDqQs+Tq844V4YGYybWW3yfXJVxkQ1nPeCAkd8Ejf9cZr6HcCpWztkib/8iecNCd5g2mqLW6m07IrUPkTNowb1CtTgEU3aLDecN0953qfGdj9hrjnDH4zQvBWiXW2/VudVYqPtdac+pOgpllM5dABEZ0mfHdYeaOzsTqiGyyVap7ei5huNifFN097cYw1D6QIBLRWnnOGJbY38xOdstCHO3IB1DNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P5J1GSRPGM4Jfln2wsUzB0nE7kO4Whk8VDEilvdWZDs=;
 b=hKv7K2UADUKGxyf23owOUHD9e6cTdsaDuKbpFGWOYgimRI2EcpU6sovbqD7vZRp9lv85TTYfmOKTgYLJ298J55OZfrCcUxT88OgfiVtQfO8I2LpVEWWJ1+cYmHS/fIfY2t/zk/SRj+7YAAo8mmSQazl2pImydrrO3joC/WIB35aYneNctBKh7HNCqOobzNemhjwyauAj4Eszari7SxSQJpH9ueNdklae4PV4neu7PkRn/w+JmgS8D5zdrGNOmEQ9DeD95xUhW7fLM1aQcJADuNem4tutU2PMgZl6tDiaIkRHPCsHmcN2eVW72VPB6JqMYAWiVv1HYFg6fX1yAdpFNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.34) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P5J1GSRPGM4Jfln2wsUzB0nE7kO4Whk8VDEilvdWZDs=;
 b=JU+sdy8xtnlG8bP5DPwR0MUOF+wOdgnCcma2oKiRNguVef+T1bqcZzJI4k3/vV0B0Ii9zjmvLL73V1t5eNo7E0vs4FW2Tu/phXHwZSmxSCK9d9+qHUBP69R5TAltNY0Nodm/1LYQLDGr0USaq7/0boTDvwY9EiYsxHK/+kwVF+1q2bwKMZ/DbiB8OJD94sNKIe/Pq/pAfDqxNRvNDRiWkpzg1KwDA5m1Op333ncMGAVYLjnoU+o0dVgawkKaEofbolPYNpEATSOThdTm1Nx8kZ4CvDkh3tW6Zdm9QQrmtPZDenZKSnsKXd7pVQ2WTOzCvehjbX5X7zZBXQDC7nZc8w==
Received: from BN9PR03CA0974.namprd03.prod.outlook.com (2603:10b6:408:109::19)
 by DM6PR12MB4340.namprd12.prod.outlook.com (2603:10b6:5:2a8::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.22; Thu, 3 Jun
 2021 12:10:40 +0000
Received: from BN8NAM11FT003.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:109:cafe::95) by BN9PR03CA0974.outlook.office365.com
 (2603:10b6:408:109::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.22 via Frontend
 Transport; Thu, 3 Jun 2021 12:10:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.34)
 smtp.mailfrom=nvidia.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.34 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.34; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.34) by
 BN8NAM11FT003.mail.protection.outlook.com (10.13.177.90) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4195.22 via Frontend Transport; Thu, 3 Jun 2021 12:10:40 +0000
Received: from [172.27.4.140] (172.20.187.6) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Thu, 3 Jun
 2021 12:10:38 +0000
Subject: Re: [PATCH v2 3/3] IB/core: Obtain subnet_prefix from cache in IB
 devices
To:     Anand Khoje <anand.a.khoje@oracle.com>,
        <linux-rdma@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <dledford@redhat.com>, <jgg@ziepe.ca>, <haakon.bugge@oracle.com>,
        <leon@kernel.org>
References: <20210603065024.1051-1-anand.a.khoje@oracle.com>
 <20210603065024.1051-4-anand.a.khoje@oracle.com>
From:   Mark Zhang <markzhang@nvidia.com>
Message-ID: <1e7ec500-223b-2cf5-9cf4-651e31d7b072@nvidia.com>
Date:   Thu, 3 Jun 2021 20:10:35 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <20210603065024.1051-4-anand.a.khoje@oracle.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [172.20.187.6]
X-ClientProxiedBy: HQMAIL107.nvidia.com (172.20.187.13) To
 HQMAIL107.nvidia.com (172.20.187.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d27cc667-8761-4e4b-1751-08d926889ae8
X-MS-TrafficTypeDiagnostic: DM6PR12MB4340:
X-Microsoft-Antispam-PRVS: <DM6PR12MB43402DC43F1A641013514B89C73C9@DM6PR12MB4340.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jkGOOg6ja/6XSRPv0OVj6873HNmqvlKldm69+a/NYO+bXtrzfuxBOt6oMTbKUoTG67j4Ic4wfZ+y6U5ul/RsAxsjR3qgKACXj2ggQSrhnozFgxwFicCfj6drkt+zG6npVr3gp2Qgm2+LkxNX1hbtr0Jz59xiekyG762ZmxjYJm0Lle83sD7qY6YMycJLDv0C0SMeK4Mk9bh4ZVuI32ccp4ptU6rPEdmkIxAYV/OBhnCwribC2c3d9Ueay/78lII2brwKy5ufy5o29ANvkjIRJVAeZijiwl7KrFMvqDIjl1szPb2chnHht+aoWoxQlti3yFVI4hSAKnU57rdXJ69dXhtTv65W4ha83G6mPTsU2b5CCm12Oo7BZA44cFTysGkD2cwrbRzcUNNpyYSv7zSIijhvqT1CV17Fm5FoCmdcxMD46bOZlEE6FtvI2bqgLTYiBRRIKs2DAtWJqt/0aLbFqRPQOT2qR/QOGbRnlPOY0bldKonf2paVtNLf30HfStABYG3DtX/zz5Ivc+/Bo1N1t62fs72lKUyQToaX3AX2lxce6o8Isfg3xPj0TuiKZkuBnRD3MW3WwKE3qVJpY20RhZ+3RhYkCQ8Ub+6PgaoNHxIHhvIsIqDD2BTUa4i5lMWI6q4cdsKqCKGH/z9K3gvYIP2Wf9Vh/Y4iziUWpaNL9l8XhcRk/HH5/r5paDJcvgI/
X-Forefront-Antispam-Report: CIP:216.228.112.34;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid03.nvidia.com;CAT:NONE;SFS:(4636009)(376002)(39860400002)(136003)(396003)(346002)(36840700001)(46966006)(83380400001)(7636003)(356005)(426003)(2616005)(82310400003)(6666004)(36756003)(336012)(110136005)(2906002)(70586007)(31686004)(16526019)(186003)(26005)(53546011)(54906003)(5660300002)(70206006)(8676002)(316002)(16576012)(8936002)(36906005)(47076005)(82740400003)(36860700001)(478600001)(86362001)(31696002)(4326008)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2021 12:10:40.4283
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d27cc667-8761-4e4b-1751-08d926889ae8
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.34];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT003.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4340
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 6/3/2021 2:50 PM, Anand Khoje wrote:
> External email: Use caution opening links or attachments
> 
> 
> ib_query_port() calls device->ops.query_port() to get the port
> attributes. The method of querying is device driver specific.
> The same function calls device->ops.query_gid() to get the GID and
> extract the subnet_prefix (gid_prefix).
> 
> The GID and subnet_prefix are stored in a cache. But they do not get
> read from the cache if the device is an Infiniband device. The
> following change takes advantage of the cached subnet_prefix.
> Testing with RDBMS has shown a significant improvement in performance
> with this change.
> 
> The function ib_cache_is_initialised() is introduced because
> ib_query_port() gets called early in the stage when the cache is not
> built while reading port immutable property.
> 
> In that case, the default GID still gets read from HCA for IB link-
> layer devices.
> 
> Fixes: fad61ad ("IB/core: Add subnet prefix to port info")
> Signed-off-by: Anand Khoje <anand.a.khoje@oracle.com>
> Signed-off-by: Haakon Bugge <haakon.bugge@oracle.com>
> ---
>   drivers/infiniband/core/cache.c  | 7 ++++++-
>   drivers/infiniband/core/device.c | 9 +++++++++
>   include/rdma/ib_cache.h          | 6 ++++++
>   include/rdma/ib_verbs.h          | 6 ++++++
>   4 files changed, 27 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/infiniband/core/cache.c b/drivers/infiniband/core/cache.c
> index b6700ad..724ac0e 100644
> --- a/drivers/infiniband/core/cache.c
> +++ b/drivers/infiniband/core/cache.c
> @@ -1624,6 +1624,8 @@ int ib_cache_setup_one(struct ib_device *device)
>                  err = ib_cache_update(device, p, true);
>                  if (err)
>                          return err;
> +               set_bit(IB_PORT_CACHE_INITIALIZED,
> +                       &device->port_data[p].flags);
>          }
> 
>          return 0;
> @@ -1639,8 +1641,11 @@ void ib_cache_release_one(struct ib_device *device)
>           * all the device's resources when the cache could no
>           * longer be accessed.
>           */
> -       rdma_for_each_port (device, p)
> +       rdma_for_each_port (device, p) {
> +               clear_bit(IB_PORT_CACHE_INITIALIZED,
> +                        &device->port_data[p].flags);
>                  kfree(device->port_data[p].cache.pkey);
> +       }
> 
>          gid_table_release_one(device);
>   }

Do we need to clear it in gid_table_cleanup_one()?

