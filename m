Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B500B1BD16E
	for <lists+linux-rdma@lfdr.de>; Wed, 29 Apr 2020 02:52:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726381AbgD2Awo (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 28 Apr 2020 20:52:44 -0400
Received: from mail-db8eur05on2061.outbound.protection.outlook.com ([40.107.20.61]:11297
        "EHLO EUR05-DB8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726353AbgD2Awn (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 28 Apr 2020 20:52:43 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NKnMX5Okg9t6N0wbMXPZs54KGuNzxJAmQBEU2KdwNxUwv36nffJ6nRqK6syEH/4h1nwqHCqFpRHrq703dNT99DQw1vepHfxpq4UmzYzh44fuWOuA9Gb3LeWTLMqDBTyMv+eWX7fopproJJSXNMYYMwmMVTcI55D+FQMNQMRYQY1uGwLRxoangquylVFsLH+mUHZ4sgBpDeuXLL68fWydoVijTPazUpAO0DgGIcTbMWFqDpcjTb6gP1fHON1wayVsICEFUBGQ9NK1BEa1prAtf+gbL5Q1iNSDIGM7KjUVoEd3ukin2maAwz/FUHRMqXOMO72ovq7L323SvZ6ZNAFOdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9wIYy5B93Wx2rgRVx6ayIjj+YmeNCsMz7ARSASxQxB0=;
 b=IT9MlMw1keRNAnPFas6cCjZMjlS5WiJCkicFj/OYA16zSypzEGHVUFJ5Sh40XGYLTNPbVG2rQfGrrl9VMmuJ2C+gMtB5uIYBqXB6Iwb+e0AIZW+aBSVIkL/xa2dhnzNIdD4W4NP79rcv14tQdYZvVHW0rG5BpqMAoRvWm4tfp6d7g78Yok7A4AVRmMQAPcxa2iJ2TgEEnMdKkKn/Mf9eZ5qoRnT6aJHl+4gM0viN1C0EJE35TE2OEKwkSwV3vWYqqm8AG2Qghnr3kjwXmejHPF2AnApEApGZekXv0rBeHAJrO0pZc2+A4upgufSsBKH/bL8Kc+8kkwDB7rbPXoBsHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mellanox.com; dmarc=pass action=none header.from=mellanox.com;
 dkim=pass header.d=mellanox.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9wIYy5B93Wx2rgRVx6ayIjj+YmeNCsMz7ARSASxQxB0=;
 b=YdVObayeyeloh6GAUoOFSupbmKfm/iiUCrHfRewxovcW26/+nGZQii7lObWf0lXJSilOWz7HYejMBuslQgqqYJjOD++6D4NU40SljRiHsC4/+Gv1GhpWGVX7lhXD1alNy976T7jOj1Zjgwi+hNSx7EebCUm7qJqy2AwSsuUmhts=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=mellanox.com;
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com (2603:10a6:803:44::15)
 by VI1PR05MB6749.eurprd05.prod.outlook.com (2603:10a6:800:134::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2937.13; Wed, 29 Apr
 2020 00:52:40 +0000
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::a47b:e3cd:7d6d:5d4e]) by VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::a47b:e3cd:7d6d:5d4e%6]) with mapi id 15.20.2937.020; Wed, 29 Apr 2020
 00:52:39 +0000
Date:   Tue, 28 Apr 2020 21:52:35 -0300
From:   Jason Gunthorpe <jgg@mellanox.com>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Doug Ledford <dledford@redhat.com>,
        Leon Romanovsky <leonro@mellanox.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Aharon Landau <aharonl@mellanox.com>,
        Eli Cohen <eli@mellanox.com>,
        Maor Gottlieb <maorg@mellanox.com>
Subject: Re: [PATCH rdma-next v1 00/36] Refactor mlx5_ib_create_qp
Message-ID: <20200429005235.GC13640@mellanox.com>
References: <20200427154636.381474-1-leon@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200427154636.381474-1-leon@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: BL0PR02CA0046.namprd02.prod.outlook.com
 (2603:10b6:207:3d::23) To VI1PR05MB4141.eurprd05.prod.outlook.com
 (2603:10a6:803:44::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (142.68.57.212) by BL0PR02CA0046.namprd02.prod.outlook.com (2603:10b6:207:3d::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2937.13 via Frontend Transport; Wed, 29 Apr 2020 00:52:39 +0000
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)     (envelope-from <jgg@mellanox.com>)      id 1jTaxn-00073U-Tv; Tue, 28 Apr 2020 21:52:35 -0300
X-Originating-IP: [142.68.57.212]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 77a985a6-5049-463d-07ae-08d7ebd79de1
X-MS-TrafficTypeDiagnostic: VI1PR05MB6749:|VI1PR05MB6749:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VI1PR05MB6749A4AF28C6EC4BBAE42185CFAD0@VI1PR05MB6749.eurprd05.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-Forefront-PRVS: 03883BD916
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR05MB4141.eurprd05.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(136003)(346002)(39850400004)(376002)(366004)(396003)(33656002)(66476007)(186003)(66556008)(6916009)(36756003)(86362001)(66946007)(2906002)(966005)(8936002)(478600001)(8676002)(107886003)(9786002)(26005)(9746002)(52116002)(54906003)(2616005)(316002)(1076003)(4326008)(5660300002)(24400500001);DIR:OUT;SFP:1101;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vfUqG9aIdQ4+/JRA8BX6i3t5JDxHtsfwSIsMvyudGMFFNmn0gr8Lo/dGVs0tteD9rD9l1H4JompO0mnMv5DbO/cVdtKpgeTXxrKIM2woRjqoA9gwmau/CNh5W93ViJv+OXo82x1+QK0rkfYvbgagwMuHgTpH/ZD35d32Pucj6d93fZfXHqj3/gWXRTg9MG1P4PQ7dMfWsli7wk/IcEc9kTyYinGnaNr1OF3gVB7rkk2LFEs6XJTe2OWBVGtzoHR+Zd2uipFDhGctU42rs3baCT1OHwbeDh1aYeiykV4z3SMpmJaM7pvPCFweIswB9z3raYXiPex/76GCbK3iqcRVthy8vPDSCwFRC/5HWUTs75HNEziqae/Vfv8qN8A40FdCzwBtlfuAMv+UlfSjXpylJeTe+AmLoSw+qEqfkiy8Zmil7zDsqo3xzan2AtEdha7IV2KS4uw8c9kJ3Ce49+XN+P4IFDY+dJndhTz95DGfGNurNg+mJG/8DwiXYP/ZBXSN9rV8/NRT7Wg+TXkT/x4R+08sqM4bl20RBtljPYFAlsFEKFf0+NGZsIPxnYooRcPwUSiqQ6IseagxCUCSHooBxQ==
X-MS-Exchange-AntiSpam-MessageData: CNElu7f3gNOYkI+CevB9A43ipp1L3EbtQDh8/SrTrUwBUlQauSzWrDSsWX+gPqi8rFO/ZV9LZygh1cJ7DTYDEBB/lLAqBL5WgvY7n9Pc2frqzv2nnYqSID9J8dy+bhYviK+VN9GWyjXXqobj7w9HBffLVpHh+XGigCqj8H7ybOP4kanm1VEZS/HdZR0iZanIrNJLj0Tf/A7At/s9Dkoyi3OiL7gy67E3aN1x8omJKFXzb+5AQ1zT1g73dKrMbSe+icsgxXmPJ76lW+VBM2ttrQRsOc1G6drgPpfH+OFyLttUWZ7JQMMX9oI6a8VCjb1gyRJUhh1I7kEQ9s1bJX8bHDvDZh2FuCpbLmewez/ZcaczPREk/4d3qdtlog5YBjU91rhUyw5k7R8VYJ8a5A1nslswEIshkrUbLDbEFaAFvTOzgPDUi/nUfk3fMZ1xKAqRB20k3dCQhsf0P39rqlM3rA2nms0Xs9iTcu4BeF1zsOQfjmWfEOJoYOf1fou/51WGlPERvFG6jSkGQ2TaGjO1JvHh+pID2VRV5QTbUrLO8xzObBFZpLrzqFD8IE0tHQU6/7DOdAJdXAhsFkJMls5vx1dRdatmVi3Tq9LgTf5mfclbNE0QtgqfSTTboW9CkFROSqY+G0GOxUXqVu1QcD2Eumgi48GU6ian3iwIW7wkLFKWLzYG9aeF1+pdqEgS+xM+IDhgcb1OLfJ3Eu/p7vvKgMGhNFTLZ3fyT9ncl6ULjt7J6gOZhEbNJzCsmtnJDDgqb1YQckPB9Lzeazo7zue9sF9W/jLxVa9BPk8yD80ygxw=
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 77a985a6-5049-463d-07ae-08d7ebd79de1
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2020 00:52:39.7159
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XOHxXhcFgxkhT7EaqpseHB9kEB2g+2PpCY1lmst1y7fAArklQcazj6mDfKa3wuvcWR+6ZbaXpH2g9yM1+1DTcA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR05MB6749
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Apr 27, 2020 at 06:46:00PM +0300, Leon Romanovsky wrote:
> From: Leon Romanovsky <leonro@mellanox.com>
> 
> Changelog
> v1: * Combined both series to easy apply
>     * Rebsed on top of rdma-next + mlx5-next
>     * Fixed create_qp flags check
> v0: https://lore.kernel.org/lkml/20200420151105.282848-1-leon@kernel.org
>     https://lore.kernel.org/lkml/20200423190303.12856-1-leon@kernel.org
> 
> 
> Hi,
> 
> This is first part of series which tries to return some sanity
> to mlx5_ib_create_qp() function. Such refactoring is required
> to make extension of that function with less worries of breaking
> driver.
> 
> Extra goal of such refactoring is to ensure that QP is allocated
> at the beginning of function and released at the end. It will allow
> us to move QP allocation to be under IB/core responsibility.
> 
> It is based on previously sent [1] "[PATCH mlx5-next 00/24] Mass
> conversion to light mlx5 command interface"
> 
> Thanks
> 
> [1]
> https://lore.kernel.org/linux-rdma/20200420114136.264924-1-leon@kernel.org
> 
> Aharon Landau (1):
>   RDMA/mlx5: Verify that QP is created with RQ or SQ
> 
> Leon Romanovsky (35):
>   RDMA/mlx5: Organize QP types checks in one place
>   RDMA/mlx5: Delete impossible GSI port check
>   RDMA/mlx5: Perform check if QP creation flow is valid
>   RDMA/mlx5: Prepare QP allocation for future removal
>   RDMA/mlx5: Avoid setting redundant NULL for XRC QPs
>   RDMA/mlx5: Set QP subtype immediately when it is known
>   RDMA/mlx5: Separate create QP flows to be based on type
>   RDMA/mlx5: Split scatter CQE configuration for DCT QP
>   RDMA/mlx5: Update all DRIVER QP places to use QP subtype
>   RDMA/mlx5: Move DRIVER QP flags check into separate function
>   RDMA/mlx5: Remove second copy from user for non RSS RAW QPs
>   RDMA/mlx5: Initial separation of RAW_PACKET QP from common flow
>   RDMA/mlx5: Delete create QP flags obfuscation
>   RDMA/mlx5: Process create QP flags in one place
>   RDMA/mlx5: Use flags_en mechanism to mark QP created with WQE
>     signature
>   RDMA/mlx5: Change scatter CQE flag to be set like other vendor flags
>   RDMA/mlx5: Return all configured create flags through query QP
>   RDMA/mlx5: Process all vendor flags in one place

I grabbed the 'part 1' of this into for-next

Thanks,
Jason
