Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 795BD353832
	for <lists+linux-rdma@lfdr.de>; Sun,  4 Apr 2021 15:13:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229884AbhDDNNb (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 4 Apr 2021 09:13:31 -0400
Received: from mail-bn8nam12on2057.outbound.protection.outlook.com ([40.107.237.57]:52353
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229665AbhDDNNa (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Sun, 4 Apr 2021 09:13:30 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JXlv31mlZQ+zQRlabsd9ZWvMexCG9oxsmQjcVqAZ0r2D8fEkJBtY/wlWHMuZWs9GZ9w7Xs04+fy4vRpUitfYa3dpL6iLMvgLwJu0WQHYD/BbesW+Hu2Bbo1oM6Iiawvy6yDK308phY0YCo1K6A6bM6lSunWiuvr0ShETlEPVlDD4rePULIhCvI8OPNLU1zwjKGZ87RwTUhXplSBNbYZoczT9Q2m2EpMVz4DWKxMAAaI1UOiKU4qWDB9wEwHbXfaMolVg/lrSTQ+IFBYFES08ZHvzA9kqPI8b104dQWlo5LRTf35NMFHLOZJh1FFeVnuPiMybDS0Ig/NM9JOGaNjlcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AX652wdziohLaQvFpyla357/IN8BarMBqYi34C0p1j0=;
 b=jwjGhyCihfudOr1s4PtbI9EA7Iosa55ulhn72MJQyC3p7Fk+tJFvfjaPCuEiNDfTwAuoP4m4AlOdNrS6A5nsF9qeqLWMwCeu/b/mhUI2sPTozyzjECxdbmOX/43Mn5Es5NTS/kA8cGd6xso7YR4+fSRWwxUuspNrGg1OxshPaemYNztrAisYSu706mKyPoUHvsiWZWUTtDS5YBeyhKjGskrcQM08kkKb1CEORL+Y9mPuQ3RXra/dmUcd1Fd9CwqoE+x2nSxOgU1G1lSb+vVD0IaLdHsanOWU3OAFXwLf4HXWxwDa+qD8YIPYc1qCFhit08ig2Vi0RUL3PiqajLuINQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.34) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AX652wdziohLaQvFpyla357/IN8BarMBqYi34C0p1j0=;
 b=Zb7FnPPx+qiCZtuRp3GvA4618Rl3I5klyFfkPynWjiqoHv0BpXsc7pojUCjGM9+hJAF8+7oUSvBxKnWQCD8LfN/z5gz3/9ODsHsGlOnrT5DW48OxxubE9yEk1E/nQkJ4dddpqkl6sCtGMmo4pvEwnxlVqo1HMLwSQ0SzoJib07DbDZ5UfpX6qGSq6dJ3FxQO4V2xUTLJ/NFCTJCTJ/ORoKw+ufsBaKbQNLHkl+ZuWwp9xxWYrXAMeBBG4x6QJRlyfSH23JPXUV5Ogi0ZeTZ4GuNae8wh7KxGMvLtEtoxMzSkFLuQJLtAwU+/5Ui3o3UnJdT7UjMcsv7NM19J55Vlqw==
Received: from BN9PR03CA0005.namprd03.prod.outlook.com (2603:10b6:408:fa::10)
 by DM4PR12MB5037.namprd12.prod.outlook.com (2603:10b6:5:388::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.28; Sun, 4 Apr
 2021 13:13:24 +0000
Received: from BN8NAM11FT066.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:fa:cafe::6c) by BN9PR03CA0005.outlook.office365.com
 (2603:10b6:408:fa::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.26 via Frontend
 Transport; Sun, 4 Apr 2021 13:13:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.34)
 smtp.mailfrom=nvidia.com; redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.34 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.34; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.34) by
 BN8NAM11FT066.mail.protection.outlook.com (10.13.177.138) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.3999.28 via Frontend Transport; Sun, 4 Apr 2021 13:13:24 +0000
Received: from [10.26.74.19] (172.20.145.6) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Sun, 4 Apr
 2021 13:13:20 +0000
Subject: Re: [PATCH] RDMA/addr: potential uninitialized variable in
 ib_nl_process_good_ip_rsep()
To:     Leon Romanovsky <leon@kernel.org>,
        Dan Carpenter <dan.carpenter@oracle.com>
CC:     Doug Ledford <dledford@redhat.com>, Jason Gunthorpe <jgg@ziepe.ca>,
        "Mark Bloch" <markb@mellanox.com>, <linux-rdma@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <kernel-janitors@vger.kernel.org>
References: <YGcES6MsXGnh83qi@mwanda> <YGmWB4fT/8IFeiZf@unreal>
From:   Mark Bloch <mbloch@nvidia.com>
Message-ID: <1b21be94-bf14-9e73-68a3-c503bb79f683@nvidia.com>
Date:   Sun, 4 Apr 2021 16:13:17 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <YGmWB4fT/8IFeiZf@unreal>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [172.20.145.6]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 HQMAIL107.nvidia.com (172.20.187.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c65d9d2d-74cf-4fcf-6013-08d8f76b6d92
X-MS-TrafficTypeDiagnostic: DM4PR12MB5037:
X-Microsoft-Antispam-PRVS: <DM4PR12MB503794624A6C850FFC48C1EFAF789@DM4PR12MB5037.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PeNp1e1a+hk7HIg2Oj2xZriiosjtCqL2OOUa9/GJqBUVhHlPTQhVj/OIghuLqlDw11j206zynxCZFH+/3MoVq4IP9gVD8P8aGAOurI2oRKOEPq+ceWeZ7MzjfzKna/aT3K01uOuGics9uEXqE2a7JLTZagNxKljwH/meeFNFIaJXREXXpHhY4FvFQKBNbTQMUA5YtRwTBQIF1uWjjFbMtCoj+HiO2CRd1TY67z46IiXWumrlumPgBNc7nV/8Ava8owBGkBy+8b6YN5sxH1VidnBNNkQ4mio+MltytiPdpVPx+ubkPkop5NiFi6lj8BADgKrUbKOGl2tbqU0ibTouAJez5+DEbFeMz4jZByGIq4O2GtIUVW7H8uyk40gSnEFKujToV/5EhPyv1MwDHKTte6isRspR5eDnISsW0bbldR5kOLrrg63O8ciHLpd4EAberjwfDfL7sx0eBG1djilpJhhhQhbR6EqExm+XsbR89EMd+k3rAlIOGGjXWVxjw0BONVuHpSPTjvP7C8fbSD+TLhFdjgAT5Wgz8QpWFOSEYV2r4+DXLSU7Mns7surC4MzJr7IyMwElNrqagPohXP66eQVWfci2Z6TmYOZo3wnBNldUdap9aH6dKP2bxpdu9tovBdrRSv+g1HzJR3ESgaWAUJJtuOzs87et1/z3sidp628uLG8wI0LM07AP4Oz2sail
X-Forefront-Antispam-Report: CIP:216.228.112.34;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid03.nvidia.com;CAT:NONE;SFS:(4636009)(396003)(376002)(39860400002)(136003)(346002)(36840700001)(46966006)(336012)(8676002)(426003)(110136005)(8936002)(83380400001)(54906003)(70586007)(26005)(70206006)(31696002)(36860700001)(36756003)(36906005)(186003)(86362001)(316002)(16576012)(2616005)(2906002)(5660300002)(478600001)(53546011)(31686004)(7636003)(47076005)(16526019)(356005)(82310400003)(6666004)(82740400003)(4326008)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Apr 2021 13:13:24.3236
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c65d9d2d-74cf-4fcf-6013-08d8f76b6d92
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.34];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT066.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5037
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 4/4/21 1:33 PM, Leon Romanovsky wrote:
> On Fri, Apr 02, 2021 at 02:47:23PM +0300, Dan Carpenter wrote:
>> The nla_len() is less than or equal to 16.  If it's less than 16 then
>> end of the "gid" buffer is uninitialized.
>>
>> Fixes: ae43f8286730 ("IB/core: Add IP to GID netlink offload")
>> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
>> ---
>> I just spotted this in review.  I think it's a bug but I'm not 100%.
> 
> I tend to agree with you, that it is a bug.
> 
> LS_NLA_TYPE_DGID is declared as NLA_BINARY which doesn't complain if
> data is less than declared ".len". However, the fix needs to be in
> ib_nl_is_good_ip_resp(), it shouldn't return "true" if length not equal
> to 16.

What about just updating the policy? The bellow diff should work I believe.

diff --git a/drivers/infiniband/core/addr.c b/drivers/infiniband/core/addr.c
index 0abce004a959..65e3e7df8a4b 100644
--- a/drivers/infiniband/core/addr.c
+++ b/drivers/infiniband/core/addr.c
@@ -76,7 +76,9 @@ static struct workqueue_struct *addr_wq;
 
 static const struct nla_policy ib_nl_addr_policy[LS_NLA_TYPE_MAX] = {
        [LS_NLA_TYPE_DGID] = {.type = NLA_BINARY,
-               .len = sizeof(struct rdma_nla_ls_gid)},
+               .len = sizeof(struct rdma_nla_ls_gid),
+               .validation_type = NLA_VALIDATE_MIN,
+               .min = sizeof(struct rdma_nla_ls_gid)},
 };
 
 static inline bool ib_nl_is_good_ip_resp(const struct nlmsghdr *nlh)

> 
> Thanks
> 

Mark
