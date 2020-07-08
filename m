Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C4734218FF3
	for <lists+linux-rdma@lfdr.de>; Wed,  8 Jul 2020 20:49:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726883AbgGHSt1 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 8 Jul 2020 14:49:27 -0400
Received: from mail-eopbgr140083.outbound.protection.outlook.com ([40.107.14.83]:8078
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725953AbgGHSt0 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 8 Jul 2020 14:49:26 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YXJ9fhNkGS4rqWakpyb4g0gjQAKaywtv5X6Mbv02caTUgYpqXbbjZYY2345LRG0OW3NxxgXNO1J83XwU54PZXcGw1vsMv0X9+pJmOpLqplylH9KLXzRz3W8sPwqYFNHp9QlHkKX++76OuBwopSoo/lUu8Go35d6bnrlhTFQclAWe4bKERd3YqW/7Xnw8WB5LMt3yBWbapVSz1YQmxAH62dkZxtkx+CdR12IngwYQdg3X4Hr9d9PeDoHoPrGoet2i5uFI7miP/Q9YOPErNLPgYPG8l+HklBGVchrKDmsHiIAv1DIMJQtmfpHkVPGaOYxVjXrMTf4qjgvMRqQM3C0g5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wqDG+9iHIvNv5PlPXUVmtIxeeG0vbFr26l9Bo+MenXM=;
 b=BfRsqKP8aBV2/iLRW3tlyKo18t2rkQRZVNcB6dgaYdhG67O0jszhJo13qh8tsA3T1xiYfECKbSSv6JUPQ1aWq3y7lJatFBHS2QGbkjDit+t3cdON1PtBTs+Kh2yALmDW3QFX77zIrH+NaJlGdNX+SZBjCKlUdHbzJeHD2Ltap3ohRp492csEtdV8HFCuwhaMO0QJ3xkc9w5Mg+Jv7EXkEfSFvwbB9fL9ExH7ei60reNzfoaVxmusYT9ZHs7vphYz7AavHhxE6Yhor+9b1ttemOaND7zHrutZpoJqNiDaxhKi/8ApX8Z5GnaF5muVIx62r1HV4Pv3T8CVVQMHTSkssw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mellanox.com; dmarc=pass action=none header.from=mellanox.com;
 dkim=pass header.d=mellanox.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wqDG+9iHIvNv5PlPXUVmtIxeeG0vbFr26l9Bo+MenXM=;
 b=nOMYNkoI6H+ZYPq63I5JGzG2ruagAfulqCF120XPppyvB7at2G761ghvfQ/2koCmqoWCBvULpuaPqMfDySMiEX+rf/0XSj0VqOkURiFj3b6tuZeq04HZA2MfM2XEF1Q/tMigKcRhzYNrvaVu+6eCo6VySJZjXLykdy9oZj0yQKo=
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=mellanox.com;
Received: from AM6PR05MB6408.eurprd05.prod.outlook.com (2603:10a6:20b:b8::23)
 by AM6PR05MB6006.eurprd05.prod.outlook.com (2603:10a6:20b:af::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3153.27; Wed, 8 Jul
 2020 18:49:23 +0000
Received: from AM6PR05MB6408.eurprd05.prod.outlook.com
 ([fe80::15f4:b130:d907:ce72]) by AM6PR05MB6408.eurprd05.prod.outlook.com
 ([fe80::15f4:b130:d907:ce72%6]) with mapi id 15.20.3153.029; Wed, 8 Jul 2020
 18:49:23 +0000
Date:   Wed, 8 Jul 2020 21:49:19 +0300
From:   Leon Romanovsky <leonro@mellanox.com>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     linux-rdma@vger.kernel.org
Subject: Re: [PATCH rdma-next 2/2] RDMA/core: Update write interface to use
 automatic object lifetime
Message-ID: <20200708184919.GC1276673@unreal>
References: <20200708110554.1270613-1-leon@kernel.org>
 <20200708110554.1270613-3-leon@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200708110554.1270613-3-leon@kernel.org>
X-ClientProxiedBy: AM0PR04CA0053.eurprd04.prod.outlook.com
 (2603:10a6:208:1::30) To AM6PR05MB6408.eurprd05.prod.outlook.com
 (2603:10a6:20b:b8::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost (213.57.247.131) by AM0PR04CA0053.eurprd04.prod.outlook.com (2603:10a6:208:1::30) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3174.21 via Frontend Transport; Wed, 8 Jul 2020 18:49:22 +0000
X-Originating-IP: [213.57.247.131]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 5cf2373d-df5e-4f4f-4118-08d8236fa156
X-MS-TrafficTypeDiagnostic: AM6PR05MB6006:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR05MB6006E54C161406CA9A08D9BEB0670@AM6PR05MB6006.eurprd05.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3173;
X-Forefront-PRVS: 04583CED1A
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tQ8Ndd9hpAEg3dzrQCp7TnIaIfBuPHnkkOti0idDvRxhkI0H40RQA4MvS4MxPsRCuD2QnCSgtYVycyHrRslHYY1I+W+ppIFJoIMigUQuHgCnwrQt6ycsm/Ae8natIQucqpPr6IQY4XfScaNdFcjZgijEkGZpDzpxknW+uqG4QNq6TH3/DlpOl+2LaH6keS6qTio+yud6cxhH83OqI7g1zikiiOOP4DRdFvV/qJpRfaLZQ4NzY1VJF8hgtd0wDstkXd8qXmCYn3tesQLXoTcOJFv8eC6U23lKaRAkKQe6IBKVhi+WxfTaW7eBX1KfYRq/rTg8fFfFjNuXHjjHmwadbg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR05MB6408.eurprd05.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(7916004)(376002)(346002)(39860400002)(366004)(396003)(136003)(83380400001)(2906002)(33656002)(956004)(8936002)(1076003)(33716001)(4744005)(15650500001)(9686003)(16526019)(6496006)(6636002)(186003)(52116002)(66946007)(478600001)(8676002)(5660300002)(6666004)(86362001)(26005)(4326008)(66556008)(110136005)(66476007)(6486002)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: A3y5kjLGEx4VdOehZqwHMvWJxlWNf1GFIKSrbrVTgz4pOxvOA7VGJP39LBUFyjVSFVfHVCV1PK/S3FuOvXw4Q0OTbKA3zOlNRXH0Xw8LzJWDfd27M6I+U1+Q2kQeW/Drum4oHt+rdeRJZ4xHaI8prkYQs/nD0zLytt0FGrRIZ8ApZYLh7NS1VzVpm2dLNVGv5YiYxgVuBC/GkE9dE3TwAv9Epvau/da1sGkc47aWUBn1GISPoQqOysf69d4b1+tjnlNH3U9KcHzqFIM7bVxBcb/HSU4Mc3YY6VohL+c6fXKsh2iMnQRin8YuWXqfU3O2gxCTk+jT/paTMtEW6nbfI7PgJmC1gm0t5wIODqvQxclUX6ZkSMfinro+Sf3p/spqfoQjML5TSTrXfY23HK+fz3zKvAJvraoWR0RVbGhM+v9dHMfkjSGs1Ezmk3jQt6Yb9WlihKrU1pmo5BnyXEBIJkMSs4sxo375ei0a4h9pPmpCZnkcAvtXGv8TmhlYNH9u
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5cf2373d-df5e-4f4f-4118-08d8236fa156
X-MS-Exchange-CrossTenant-AuthSource: AM6PR05MB6408.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2020 18:49:22.9690
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: S5W7ox2M5LJ9YPuDNjsSHsx2HSnuZYxIS+opLencPPp0uXnzSJpkfT1ZmvxrW/Q1U1PUCLsNVFIdyptcDtQM6w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR05MB6006
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Jul 08, 2020 at 02:05:54PM +0300, Leon Romanovsky wrote:
> From: Leon Romanovsky <leonro@mellanox.com>
>
> The automatic object lifetime model allows us to change write() interface
> to have same logic as ioctl() path. Update the create/alloc functions to be
> in the following format, so code flow will be the same:
>  * Allocate objects
>  * Initialize them
>  * Call to the drivers, this is last step that is allowed to fail
>  * Finalize object
>  * Return response and allow to core code to handle abort/commit
>    respectively.
>
> Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
> ---
>  drivers/infiniband/core/uverbs_cmd.c | 299 ++++++++-------------------
>  1 file changed, 90 insertions(+), 209 deletions(-)

Please drop this patch, I came to realization that create_cq() can be
simplfied much more, I'll send v1 after will get results from the
verification.

Thanks
