Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A0A2D3ADE45
	for <lists+linux-rdma@lfdr.de>; Sun, 20 Jun 2021 14:19:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229594AbhFTMV3 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 20 Jun 2021 08:21:29 -0400
Received: from mail-bn8nam08on2084.outbound.protection.outlook.com ([40.107.100.84]:38112
        "EHLO NAM04-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229593AbhFTMV2 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Sun, 20 Jun 2021 08:21:28 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D974wtOTo79JFpT5zRccPevRh7cSMW2a+8nSbNUNg6y4MlwlEMrqs0ypUPqW4/qKrvpotvAHolgT1zD6sLCR2eG7Dir+gDXzxbwWmiu68uVDZ9KZup/g95HzQOcc+u4+l+LxxNfkHi5d/WDHyBx84Ms8UPffFywTOwk6iDSXkQlSw4flOv2UGOBrhZSbZMwHKoTTrG4jU/sCig4bgaDdKFEEDbqAYXVq+CFV3X3M3yQKLZsc1ZN5HSjxZX3gJmbZRypo8FLVbwhAKqCLsYWzD2142qCzA8uWQ6/Gy7C0ryAvW53tIgz7nU+lqZHAwBaOMj0JuwsJq8RyuH51y/diew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h5ZV+z9qPTwCW3k2MYB/2aEegNxWsEjHUhdy18qnpV0=;
 b=f3WwLI4JfTGhP2soE7kFWfKWOgnPqA5uZ2OEzaIAIJ3YzvTlna/+lsKlPzrwtLA9Gcyt9nQmyUZ0RU/vLHo9IFgTPfynldbATcPyakWYlRb+v4ViRqI6yJPxQUoDUhg066OoJowwqZzHBFG1oGA0ygF8MjPRDMWJyR+6NljuzsIbNs+WIqwUGoAOSL2LUOeAfJUWiJHIyQ+ik0ioFtfRO56VnJNRuiuVPVWJf3fNFd4NZBLAQuFlgTAh8jnJHcdDAMKNgbKmzxvSSyxmCBZSNwcNyiGHignjnanrxk0gT4YRdlHovYCrnssGxvOFyiFTdvd5kFbRnPq+vHRVH0Ehtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.34) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h5ZV+z9qPTwCW3k2MYB/2aEegNxWsEjHUhdy18qnpV0=;
 b=EYV5+wUBLfRsYP2zKPVc91lmG5IZOqhoO/7sd1/rAjmbE7pKc2Nw1SCC3TRviYqyhLL/SDiyEzm4SkjrEjzpp7voPW4RU6IFrBxdhGBbYvtqp0sEExUw6eEwvCGgKIenA5upVPdPGqbJuXHoQ/4O6wKvUVHG0v2s3urEfUfbWeRo4Q1P6M/NWdCW8nKNa14C0BBGOJEiW8f/keByTwsbJSZ1j0UUKFEX88rNNZQ7vvOjiLjA+3tTreD6YGnAZSurco2B/MG2e43PqvKXUxBgkhJK0lJtF7SW4P/NYHI1QgPF+I69JiqWyIuF3cGfh+KIOBGVCC4/LpCFJITW1FB6fA==
Received: from CO2PR04CA0127.namprd04.prod.outlook.com (2603:10b6:104:7::29)
 by MWHPR12MB1549.namprd12.prod.outlook.com (2603:10b6:301:10::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.18; Sun, 20 Jun
 2021 12:19:12 +0000
Received: from CO1NAM11FT028.eop-nam11.prod.protection.outlook.com
 (2603:10b6:104:7:cafe::8f) by CO2PR04CA0127.outlook.office365.com
 (2603:10b6:104:7::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.21 via Frontend
 Transport; Sun, 20 Jun 2021 12:19:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.34)
 smtp.mailfrom=nvidia.com; redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.34 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.34; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.34) by
 CO1NAM11FT028.mail.protection.outlook.com (10.13.175.214) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4242.16 via Frontend Transport; Sun, 20 Jun 2021 12:19:12 +0000
Received: from [172.27.4.136] (172.20.187.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Sun, 20 Jun
 2021 12:19:09 +0000
Subject: Re: [PATCH for-next] RDMA/cma: Remove unnecessary INIT->INIT
 transition
To:     =?UTF-8?Q?H=c3=a5kon_Bugge?= <haakon.bugge@oracle.com>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Leon Romanovsky <leon@kernel.org>
CC:     <linux-rdma@vger.kernel.org>
References: <1623944783-9093-1-git-send-email-haakon.bugge@oracle.com>
From:   Mark Zhang <markzhang@nvidia.com>
Message-ID: <6e6e93a7-f59e-8c67-c5d1-e6a64a556a54@nvidia.com>
Date:   Sun, 20 Jun 2021 20:19:07 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <1623944783-9093-1-git-send-email-haakon.bugge@oracle.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [172.20.187.5]
X-ClientProxiedBy: HQMAIL101.nvidia.com (172.20.187.10) To
 HQMAIL107.nvidia.com (172.20.187.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0502081b-0e65-429b-76de-08d933e59cfa
X-MS-TrafficTypeDiagnostic: MWHPR12MB1549:
X-Microsoft-Antispam-PRVS: <MWHPR12MB154954E461DA29183BCF48C4C70B9@MWHPR12MB1549.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5236;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZxNSoYJP3awUBtTHvLlHiZm+9ogKyNdtQF/vqfBlMkqEaCTLp3159mOrBS8X3vRNF0eX/LlrVuik5BIXheUNT+9H4tp0DfEPCbAtjj+v4KSSVCfLecCN7QQ9HHCsnan/QX+NLatEw30yIrlGC/8ASH0qxIjbktRqXXmdLTH9K+oF1bIAZXQyxVWIhOD5P4CZ3rkgO43tVoPfJJKmC2oZe2h39PUb1zpnVDqvy8lpAEAna5K+tXSQlJIA3LyxEGsUHGnU0AemcIqwqSfWmo0BWvo0a8X5m7xCMTzFpg/Phbpo7lq5qHF3fJTLgVRgT1yrCWLAMZwD/+I6ka8ay8KOduZT4ehDVSOv5W1hv+uAznHgipnCOn76B55ba1XkZvsRQr1V4RB5K8k9S4fPxzT1U7Up/1ZhqCqYy1Ke75y3ItOWolYxJSAuBZm+YXU2GjQhyR3hhea/PwJLNUs/A4pxrprNqSLaxAJE/aHR0Xg84VVGq07aCWD/+MEKZn0oh7HQhxTQ5YGUS+LSG6bP9GTi4ucpNb9zntsT/rA4JP2w6ucG1LoLt7nsVaZZO2OkB8Ay7Wat5nliX0HmriseOre+PjjQIhsoiHIX/QkbN1q0PDD8wUJ2jbb0q9Tg8yiKdsanTgwiVOWEpNrGOk3rSaXuuFpsPukTxxpRrUm6agIwoec=
X-Forefront-Antispam-Report: CIP:216.228.112.34;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid03.nvidia.com;CAT:NONE;SFS:(4636009)(136003)(346002)(376002)(396003)(39860400002)(46966006)(36840700001)(478600001)(47076005)(4326008)(31686004)(356005)(66574015)(5660300002)(82310400003)(83380400001)(36860700001)(82740400003)(70586007)(70206006)(31696002)(86362001)(316002)(16576012)(2906002)(26005)(426003)(7636003)(36906005)(2616005)(8936002)(110136005)(53546011)(186003)(16526019)(8676002)(336012)(36756003)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jun 2021 12:19:12.2793
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0502081b-0e65-429b-76de-08d933e59cfa
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.34];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT028.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1549
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 6/17/2021 11:46 PM, Håkon Bugge wrote:
> External email: Use caution opening links or attachments
> 
> 
> In rdma_create_qp(), a connected QP will be transitioned to the INIT
> state.
> 
> Afterwards, the QP will be transitioned to the RTR state by the
> cma_modify_qp_rtr() function. But this function starts by performing
> an ib_modify_qp() to the INIT state again, before another
> ib_modify_qp() is performed to transition the QP to the RTR state.
> 
> Hence, there is no need to transition the QP to the INIT state in
> rdma_create_qp().

The comment in cma_modify_qp_rtr() says:
     /* Need to update QP attributes from default values. */

So maybe both are needed? E.g., qp_attr->qp_access_flags maybe updated 
in cm_init_qp_init_attr()?

> Signed-off-by: Håkon Bugge <haakon.bugge@oracle.com>
> ---
>   drivers/infiniband/core/cma.c | 15 ---------------
>   1 file changed, 15 deletions(-)
> 
> diff --git a/drivers/infiniband/core/cma.c b/drivers/infiniband/core/cma.c
> index 2b9ffc2..937e44e 100644
> --- a/drivers/infiniband/core/cma.c
> +++ b/drivers/infiniband/core/cma.c
> @@ -925,19 +925,6 @@ static int cma_init_ud_qp(struct rdma_id_private *id_priv, struct ib_qp *qp)
>          return ret;
>   }
> 
> -static int cma_init_conn_qp(struct rdma_id_private *id_priv, struct ib_qp *qp)
> -{
> -       struct ib_qp_attr qp_attr;
> -       int qp_attr_mask, ret;
> -
> -       qp_attr.qp_state = IB_QPS_INIT;
> -       ret = rdma_init_qp_attr(&id_priv->id, &qp_attr, &qp_attr_mask);
> -       if (ret)
> -               return ret;
> -
> -       return ib_modify_qp(qp, &qp_attr, qp_attr_mask);
> -}
> -
>   int rdma_create_qp(struct rdma_cm_id *id, struct ib_pd *pd,
>                     struct ib_qp_init_attr *qp_init_attr)
>   {
> @@ -960,8 +947,6 @@ int rdma_create_qp(struct rdma_cm_id *id, struct ib_pd *pd,
> 
>          if (id->qp_type == IB_QPT_UD)
>                  ret = cma_init_ud_qp(id_priv, qp);
> -       else
> -               ret = cma_init_conn_qp(id_priv, qp);
>          if (ret)
>                  goto out_destroy;
> 
> --
> 1.8.3.1
> 

