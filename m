Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C1AB348E72
	for <lists+linux-rdma@lfdr.de>; Thu, 25 Mar 2021 11:57:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230228AbhCYK4g (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 25 Mar 2021 06:56:36 -0400
Received: from mail-eopbgr700085.outbound.protection.outlook.com ([40.107.70.85]:45933
        "EHLO NAM04-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230299AbhCYK4T (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 25 Mar 2021 06:56:19 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YOQ6BOFnUPF5a66vnjFvoPzjAP17HxISo7Jq4+3qbvDg5/nEXV1BfPZBLQOtA6cMtuPWwe5y7JFQ4PDMBQAHO+Yy1NKF3DvMU7NQQPGSOjV81EpdTfGZgnkOazXgVjb7Zk/q9PZVBOX0QYpwOmGCw7XlafDE5m3rwhrfEuBr0dhOGHpCCeJGNcPOPprBv0e561SWxtTEqoFlEes0wdpE/YtyGzZbIsNoaavDHy8YC75rZEF6DjScZI6hfPu9Kdrc1XiYSkaK3VS0F2MNMq3/3V+l6S9wERYAxkRgWAsN79YmpJPvIG0B82Ep7vN5XtZkCVKF5cfj7bRkYK/sOoNiJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LedYCvuORPOFHq+8WYlKzMtGus1zR1pWbGhueK7Uagg=;
 b=YUa4NUeRu7xU1aec6ZmLnD69koIGntLZCMr++rspffB55iuSrN6blKSFhhTjHr8FbXJY5PlQH1To55pLuTA+7+NoVq7bu2ldhymceCp/3Le9tMAfup/0uQJDUTTzM8HxTD8L5ZN0i7n6r/ndGeRE+b8HTmvFNHqy4ObgsTFn/oMqYiL1S8MrAXLdPlnsrQE940ocQNwPkt6OMNcksCfBhIHtnbsE32Iwcun+QOHeGFRjZPxS0XgxfQA6vFKoolCHo7V81RxDrb76gejns7yelOVYGd7lPySliX2rnK6ifSJLGOT4k8UgqBiftSfWItmTd58SGnXsu90A6aGEqkxM3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.34) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LedYCvuORPOFHq+8WYlKzMtGus1zR1pWbGhueK7Uagg=;
 b=bUHHvUwrDPJtNVbg8MhOiV760ZaEL4wasossClJ+I3qFjnBMC/bJkOlya+pr+eY2VQuIiLrrmQqMBEkNOeMoQEGMC77jbs1MtUPLu7IIAgZKcbYhYKFABst8D6iV2iX3vWAjNxOud00uoZV05f/EegenWDfYpWGquy50AOT9Qxd5pcczFBlEsnJLv+xKJwruAdvY195E47TX1SgTyhypKn/J0kqxWVsQgW4O8eCA6JVKT6yJRYVuQFWWwi1Td84PaTv+bHHChh/L+t4Wuehj+6cXjLXBFXtvtnKu0EleyNjTim8s1oxMwuAvEq/XnBYNcjGI4EaC1lsQKbU98PCtbA==
Received: from BN9PR03CA0303.namprd03.prod.outlook.com (2603:10b6:408:112::8)
 by CH2PR12MB5018.namprd12.prod.outlook.com (2603:10b6:610:65::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.24; Thu, 25 Mar
 2021 10:56:17 +0000
Received: from BN8NAM11FT005.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:112:cafe::7) by BN9PR03CA0303.outlook.office365.com
 (2603:10b6:408:112::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.28 via Frontend
 Transport; Thu, 25 Mar 2021 10:56:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.34)
 smtp.mailfrom=nvidia.com; redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.34 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.34; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.34) by
 BN8NAM11FT005.mail.protection.outlook.com (10.13.176.69) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.3955.18 via Frontend Transport; Thu, 25 Mar 2021 10:56:17 +0000
Received: from [172.27.0.10] (172.20.145.6) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Thu, 25 Mar
 2021 10:56:15 +0000
Subject: Re: [PATCH v2] infiniband: Fix a use after free in
 isert_connect_request
To:     Lv Yunlong <lyl2019@mail.ustc.edu.cn>, <sagi@grimberg.me>,
        <dledford@redhat.com>, <jgg@ziepe.ca>
CC:     <linux-rdma@vger.kernel.org>, <target-devel@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20210322161325.7491-1-lyl2019@mail.ustc.edu.cn>
From:   Max Gurtovoy <mgurtovoy@nvidia.com>
Message-ID: <413a083c-83b3-fcc8-f5e2-d9721874fad5@nvidia.com>
Date:   Thu, 25 Mar 2021 12:56:12 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210322161325.7491-1-lyl2019@mail.ustc.edu.cn>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [172.20.145.6]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 HQMAIL107.nvidia.com (172.20.187.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3c96affd-8ce5-4d60-7839-08d8ef7c9e05
X-MS-TrafficTypeDiagnostic: CH2PR12MB5018:
X-Microsoft-Antispam-PRVS: <CH2PR12MB50181F14BE77B913B0FF393EDE629@CH2PR12MB5018.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KMAbCAB9qS2DPpkVzNR2CSs7innOdBpZJhBc5KyRywUvbb528M304s2CyNdbGJqc6qcjQ0U24Bs9DU85BdI0eWxrVtupsT4b8VAD3yp6MGtYjorixywgKuaIk+Fn2UhfLTb3WnQy5p3PMGU23Nvf3QrqkdyY+QvOTeG8qAGLdnBNvAfDLE8G21p3gIlgVNLSXNpvSIXqU4W/GK8ZRnDOslU00qKekytoWAsI0pTN53mtFtGj1R1qtqTvCHmmEWkDKzeRTWnRqjNgHqRxb2LgvYspra3eEvmdFHRV19toPi2tP+YduPNMii9SGGdOMSd19/Kfj4wZUkVWVkZakoZKT18R6OJmVsdpb8iOa/L7PYkgGtTDr5SY5Snd3H2otvJ3Qjt8wxRb9dKrmBSRG7g9uyMb9/wPo6WN3ZoaNKR9GJ/ldCMa/GO96E+znvawwqgFcF/EBa3dRVmyrGjPfX6VRcPXt7I4Che+tnNMUyCBImCulRPBnVhrFAWQyCEEEEW/ufc+VRKOi0uPqridQ7wmXvkTU5dQTG1ZcC2tPdVzn1hK08Z+uOH1Pes2sA7L1fZRZa9O5g/H08m0ikCeW2qbpHR8OmAmDP4SwQd7jtYTaIl9xg16vSKhWBO4SxtjcHqmLEm7XaJ2hF7bVFtBLJyOURt28XO+NgzEGKkoQ6Xq6LyIsT3EyfSBCxZ4ZIYT5yQ5
X-Forefront-Antispam-Report: CIP:216.228.112.34;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid03.nvidia.com;CAT:NONE;SFS:(4636009)(136003)(39860400002)(396003)(346002)(376002)(36840700001)(46966006)(31686004)(4744005)(5660300002)(2616005)(2906002)(83380400001)(16526019)(8676002)(82740400003)(478600001)(82310400003)(53546011)(70586007)(70206006)(8936002)(7636003)(36756003)(426003)(316002)(356005)(186003)(47076005)(86362001)(110136005)(36906005)(54906003)(31696002)(26005)(336012)(4326008)(6666004)(36860700001)(16576012)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2021 10:56:17.6398
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c96affd-8ce5-4d60-7839-08d8ef7c9e05
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.34];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT005.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB5018
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


On 3/22/2021 6:13 PM, Lv Yunlong wrote:
> The device is got by isert_device_get() with refcount is 1,
> and is assigned to isert_conn by isert_conn->device = device.
> When isert_create_qp() failed, device will be freed with
> isert_device_put().
>
> Later, the device is used in isert_free_login_buf(isert_conn)
> by the isert_conn->device->ib_device statement. This patch
> free the device in the correct order.
>
> Signed-off-by: Lv Yunlong <lyl2019@mail.ustc.edu.cn>
> ---
>   drivers/infiniband/ulp/isert/ib_isert.c | 16 ++++++++--------
>   1 file changed, 8 insertions(+), 8 deletions(-)

looks good,

Reviewed-by: Max Gurtovoy <mgurtovoy@nvidia.com>


