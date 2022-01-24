Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B6EE3497667
	for <lists+linux-rdma@lfdr.de>; Mon, 24 Jan 2022 01:18:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240545AbiAXASi (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 23 Jan 2022 19:18:38 -0500
Received: from mail-bn8nam11on2077.outbound.protection.outlook.com ([40.107.236.77]:26401
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S240530AbiAXASi (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Sun, 23 Jan 2022 19:18:38 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dzwEvj4ey78DJc7OJUFPNK9Wqa33mIibnIq8ZWScx3f1eSxGizC/ak5UvnDw/gv1sfOYR+dm6R3n4LKzqt9NfBDEbRSoMi2a7pNoNHwpBdHcTXT3qCS354euhs0nsYrr7jui3sLHkhihjucKLO5lJhwV3M1ZdHFA+C0+y0qXumGhEBgEaCWviHIgkjW5kvHz5lodWS3m2bnHGU5Sb+LuW8J1fazxjuD27usRePdnkVIA8ZRYzajFs4GXG1v86cAClawzN+EMiLihBWGL0UKHA/0tJosoCzZZHSp2J09pbPyd7g9UhHukHFyaVizy2cz5HdIAnA1AWmBRqj/4YNSqag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RbM1o7trbnFKNqO5+DrNgQC5CeU0Xj6PmU9C10E33Vw=;
 b=EavaqdZUjqMVPes//W4A2PwUJ9AzLU/gFN5vvHb49VLOHtjw10yHaDZMonKV08TMHErvIYOf1h+CJmRtcfCxDbwt6/X4fQuHkF6EVrnp78znJpAcNappk7tItiz0rWoUPXOuwk95elm0fEfs6EcjZy3fP68Sg0EuusGRHyUxj/Z/TokX4VNXhCGjbP9rFMaXhHLhGJE6CVyIpDZV7fSrWmkrH7t56yX6bnunSPgTtQ2eZjACfLVI2aSuJkXDymwZSlUpMAC4nO526ZPy/3EbjEkbQzlH3vPLtDVQC6wvqZ2RxUBaPWub5xYlz5vzTKOXJK+yb8i+xGjrulwkOAYHlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.234) smtp.rcpttodomain=cisco.com smtp.mailfrom=nvidia.com; dmarc=pass
 (p=reject sp=reject pct=100) action=none header.from=nvidia.com; dkim=none
 (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RbM1o7trbnFKNqO5+DrNgQC5CeU0Xj6PmU9C10E33Vw=;
 b=IcUBKzjDmevhnErF2YnH59XzrjVLGYVHubh1ZBKI48N9LfFxO/PQIOPUduEtbwcfX/ob8mG8fpTFeq50AIL+5B7gbbQv57SISQJOE2G4jw5xQ7NaoYcUUkSNBeN7GC06zfLEa/AolyDU+afabKLgASTStzQGV488ZmssHmg/VM3+vXdip9nKflZkeDBLC0jqZ7kHtr+PynLESbhZfOcsICK5V7uVthlIUwTWYuHMOUfCB/H44KQSrQTZIqi7qbsyNZzJFWP4U4a/Nj6I3ivng27SQkZpA9ETbrKRnYDOOR9+LKMISIqGvAPuwiju6zll2Fv0xciOMlJL/noNtf11gQ==
Received: from BN9PR03CA0467.namprd03.prod.outlook.com (2603:10b6:408:139::22)
 by MN2PR12MB4047.namprd12.prod.outlook.com (2603:10b6:208:1de::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.10; Mon, 24 Jan
 2022 00:18:35 +0000
Received: from BN8NAM11FT051.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:139:cafe::fa) by BN9PR03CA0467.outlook.office365.com
 (2603:10b6:408:139::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.7 via Frontend
 Transport; Mon, 24 Jan 2022 00:18:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.234)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.234 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.234; helo=mail.nvidia.com;
Received: from mail.nvidia.com (12.22.5.234) by
 BN8NAM11FT051.mail.protection.outlook.com (10.13.177.66) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4909.7 via Frontend Transport; Mon, 24 Jan 2022 00:18:35 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by DRHQMAIL101.nvidia.com
 (10.27.9.10) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Mon, 24 Jan
 2022 00:18:34 +0000
Received: from [172.27.0.119] (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.9; Sun, 23 Jan 2022
 16:18:30 -0800
Message-ID: <52cb0f32-b705-8d60-71b4-350cc26c5a4b@nvidia.com>
Date:   Mon, 24 Jan 2022 02:18:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH rdma-next 10/11] RDMA/iser: Delete useless module.h
 include
Content-Language: en-US
To:     Leon Romanovsky <leon@kernel.org>, Jason Gunthorpe <jgg@nvidia.com>
CC:     Leon Romanovsky <leonro@nvidia.com>,
        Christian Benvenuti <benve@cisco.com>,
        Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>,
        <linux-kernel@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
        Mike Marciniszyn <mike.marciniszyn@cornelisnetworks.com>,
        Nelson Escobar <neescoba@cisco.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        Yishai Hadas <yishaih@nvidia.com>,
        "Zhu Yanjun" <zyjzyj2000@gmail.com>
References: <cover.1642960861.git.leonro@nvidia.com>
 <bdbf940ca5edbbc649153fa15737b779c073c498.1642960861.git.leonro@nvidia.com>
From:   Max Gurtovoy <mgurtovoy@nvidia.com>
In-Reply-To: <bdbf940ca5edbbc649153fa15737b779c073c498.1642960861.git.leonro@nvidia.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: drhqmail202.nvidia.com (10.126.190.181) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9d8f1d4e-da8d-4862-3dcf-08d9decf0fc3
X-MS-TrafficTypeDiagnostic: MN2PR12MB4047:EE_
X-Microsoft-Antispam-PRVS: <MN2PR12MB4047C6C8915609274A2D797CDE5E9@MN2PR12MB4047.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7cpRthnOyuJdK4mWTQOI/WgpJVPBVtxNuT02F5tMZ1ucc50WD9dEQ4O5j7HoLCBLAR/a4iAHRfxxi5JCcUaF+gVB51WeJMXmiuhDJ8rN0ufzC5TGLsFbNAPmfku6QWQLvO3XxWQAq77FT15L3HBtAibops7R8hh8vQafwosgu6ulVIeigbne9Pts7j0xa25Igu3ANk47vzkwe/cYWzVHuOGKyJAw11D5pZrSR4ellS1TrtZvFC7/e0LfYS+fVDbCq+qVbF9UsB6dmYC4HfWi4xflGzLyuP61Z0b2h5KcqToPZ8Bngd03KTX+Q+x8LJgDtlvyn91fGZlqidQ+S9ThnB2wuu/+RgBSuUOmqJqGKCwmeTz6dZTcTPYN8oFKPSGpSzdPvSVuVMxDSIWPmRONJOCa5VuyaO5PExg51JqmPMH+/67mI29Qrp8e6pFyq4eFKBbj5KvMhPAJH0E5bJpF26byQHxhJDOTccSwqmKMAEfMWN/yUuFlxIF86X5GloxlSF3kAaebiKYG9ZK23shy9DeiNaFCR4bl1zC1bCuyydfA+5qC9FVrzUrRb8kH7P9lGV5BQQw9a2grYPB7nn3Q039G7xpyZBZ4QJrD4iDrVoyTNLMhBfoYBuHMXsQBMM4SQgBl5cItuBK4wgOlrq8jkVCUqvmA6QsIVDZLFcKGtEzNR8e0QEeqImmYZrMOik33LAxyPUUVbJ36DZLktHlmfSjTPZE4LAniwH97EEqZj+HMjv1qj65/+CwmphK8qnwY+2manyJLm6Ipp0dvpfpg/iitRgCKypCOJtss/4EYNPyQatuuedBdrDMqRt9Ur+Wbfw1yAbZw0Clvszd2G+1zNg==
X-Forefront-Antispam-Report: CIP:12.22.5.234;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(4636009)(40470700004)(46966006)(36840700001)(36756003)(508600001)(186003)(81166007)(86362001)(47076005)(54906003)(83380400001)(4326008)(110136005)(8936002)(70206006)(70586007)(36860700001)(316002)(31696002)(5660300002)(6636002)(16526019)(16576012)(6666004)(82310400004)(426003)(53546011)(40460700003)(8676002)(2906002)(26005)(2616005)(31686004)(336012)(356005)(36900700001)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jan 2022 00:18:35.1967
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d8f1d4e-da8d-4862-3dcf-08d9decf0fc3
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.234];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT051.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4047
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


On 1/23/2022 8:02 PM, Leon Romanovsky wrote:
> From: Leon Romanovsky <leonro@nvidia.com>
>
> There is no need in include of module.h in the following files.
>
> Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
> ---
>   drivers/infiniband/ulp/iser/iser_memory.c | 1 -
>   drivers/infiniband/ulp/iser/iser_verbs.c  | 1 -
>   2 files changed, 2 deletions(-)
>
> diff --git a/drivers/infiniband/ulp/iser/iser_memory.c b/drivers/infiniband/ulp/iser/iser_memory.c
> index 660982625488..f1fd05d8609d 100644
> --- a/drivers/infiniband/ulp/iser/iser_memory.c
> +++ b/drivers/infiniband/ulp/iser/iser_memory.c
> @@ -30,7 +30,6 @@
>    * CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
>    * SOFTWARE.
>    */
> -#include <linux/module.h>
>   #include <linux/kernel.h>
>   #include <linux/slab.h>
>   #include <linux/mm.h>
> diff --git a/drivers/infiniband/ulp/iser/iser_verbs.c b/drivers/infiniband/ulp/iser/iser_verbs.c
> index 8bf87b073d9b..8893bc27d8f5 100644
> --- a/drivers/infiniband/ulp/iser/iser_verbs.c
> +++ b/drivers/infiniband/ulp/iser/iser_verbs.c
> @@ -32,7 +32,6 @@
>    * SOFTWARE.
>    */
>   #include <linux/kernel.h>
> -#include <linux/module.h>
>   #include <linux/slab.h>
>   #include <linux/delay.h>
>   

Looks good thanks,

Acked-by: Max Gurtovoy <mgurtovoy@nvidia.com>

