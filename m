Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9BCBE1D1812
	for <lists+linux-rdma@lfdr.de>; Wed, 13 May 2020 16:57:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389111AbgEMO5b (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 13 May 2020 10:57:31 -0400
Received: from mail-eopbgr130053.outbound.protection.outlook.com ([40.107.13.53]:34377
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2389056AbgEMO5b (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 13 May 2020 10:57:31 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NosMkPIjBSjHQ/S8A6V3T/md9OpWXrSRwnXheqZDWGGXuxrMqcuBT0ULZNJMR9AqvEuRbUEA+0F2FHDVPWwWgpj0kbFqeZXohc0kKUbwALXglL4BA3a1j/N0Dl8ibfCAv9yiwfYHAyPuNIHKAYUSD02idgLWfmFK9jEhrbIklnQgMCIO9Ihnq3EN/Xr5yXRsOPJZyQ1Lr94wVOMpy23s3KlQvAwfYcDdXrlzX1LkDEnQYar3JXJZ4Jm5NaCBfTxBczFUpz8kkTtfntF3RIRP/j3nd8Mff1xRtGGVtkbvaNIzCj8zeAjfTsMajVI4tRg0RigLoF1FQSFthBDoWM8qtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3or3Gho5pR6HrPjsU0IHHufk9rp/xpdnt0upm7+2AQA=;
 b=Owqerk1h9VKCA8wg1y+51nvCyvjRqKTh0LL9QuDKsP1wb/lKRf4MKUPX9EOi2Dwa6JPqT3J9VHW9UsX5pmZGrib+/OvEUlqANn0uLZkXDJ7MRNvAdoLcbHzrBnWLEIQOX6n2VaKe2oPRtWAI9fR7+mn+8Qz1QCZ5OqU4AGoJKvnyKgCQZMbsjnGHAdg3tWLUwI0SaOjcYFnA+2D+8R4RUq4M1LTUEfVv9VZkozwCah2kbLluV8lImWwRdB2n6V0iw2HTdqwyLEI85lt2P0ulLxIlnt5yhGLLtgcWxMzxsYKKshXSxEHZjnf1HIAaTth8lwl9z7Eqqrbzm+WvPOpZTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mellanox.com; dmarc=pass action=none header.from=mellanox.com;
 dkim=pass header.d=mellanox.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3or3Gho5pR6HrPjsU0IHHufk9rp/xpdnt0upm7+2AQA=;
 b=qxWluq8CzijlZpyhpjApq62UkoZGJfuOA7JlOIc3uELshextm5p/S6XOSAmKRI5hiS39LXB4IuTgez1Xyg04DnOqhECu85SdzcDENJZmLA0iXKAfTFmx4UK3v3Kxs/iJHysZQEfGzRnpOe3TQTvtNGureo1PsbHNiIqkHmzYxo0=
Authentication-Results: mellanox.com; dkim=none (message not signed)
 header.d=none;mellanox.com; dmarc=none action=none header.from=mellanox.com;
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com (2603:10a6:803:44::15)
 by VI1PR05MB6334.eurprd05.prod.outlook.com (2603:10a6:803:ff::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2979.26; Wed, 13 May
 2020 14:57:26 +0000
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::a47b:e3cd:7d6d:5d4e]) by VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::a47b:e3cd:7d6d:5d4e%6]) with mapi id 15.20.2979.033; Wed, 13 May 2020
 14:57:26 +0000
Date:   Wed, 13 May 2020 11:57:22 -0300
From:   Jason Gunthorpe <jgg@mellanox.com>
To:     Max Gurtovoy <maxg@mellanox.com>
Cc:     bvanassche@acm.org, linux-rdma@vger.kernel.org,
        dledford@redhat.com, leon@kernel.org, sagi@grimberg.me,
        israelr@mellanox.com
Subject: Re: [PATCH 1/1] IB/srp: remove support for FMR memory registration
Message-ID: <20200513145722.GH19158@mellanox.com>
References: <20200513144930.150601-1-maxg@mellanox.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200513144930.150601-1-maxg@mellanox.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: MN2PR17CA0024.namprd17.prod.outlook.com
 (2603:10b6:208:15e::37) To VI1PR05MB4141.eurprd05.prod.outlook.com
 (2603:10a6:803:44::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (156.34.48.30) by MN2PR17CA0024.namprd17.prod.outlook.com (2603:10b6:208:15e::37) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2979.27 via Frontend Transport; Wed, 13 May 2020 14:57:25 +0000
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)     (envelope-from <jgg@mellanox.com>)      id 1jYsp0-0002MJ-47; Wed, 13 May 2020 11:57:22 -0300
X-Originating-IP: [156.34.48.30]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: d8f01a4a-c93a-4fac-9765-08d7f74df308
X-MS-TrafficTypeDiagnostic: VI1PR05MB6334:|VI1PR05MB6334:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VI1PR05MB633414828192EB925EDC194ACFBF0@VI1PR05MB6334.eurprd05.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-Forefront-PRVS: 0402872DA1
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: S0yCOHneHWdCTRFdZojwwqqiHY8qWtIGrxPmeHsja6vGX8VKvZwckHxELKFRxDqpTaDe6lxCU1bRPaYrRKp9uRKOWq0u+dDmTqtte0fCzhTqQ5alBrPyzFlMdycUB3PTZDyKldZY870hkMa1pSiggS1poxz/VeEMk/m4FwdXAtoLxvGGtq7jqoNXCpg5+u/2TJmd2hktpk6nP6hG450Th7LUkOMcuxmFIrvZCtQnx/SWa38EOGf2G8/hSyAtdstc2rsxqE6OtbeNEgEbzoAjUqlf9kzBTd+C4eLAinZFz1EJe/dRWO9AmtMFuNrm8EoCw02jqE7RYfSc5Kfz3W0P2+VV+1SSATYEXGiv704UUmrDqdm4Bc0Qm7W4bbgBI8ZTg16Ik0zNCI3QlCJ1wmLYXpG9f2d8Mygdg9FSkOgoTBTMrrmy86FQe3cOmHCmiM0afqmOHfrOQpFzMYooadRqm1hWc6cnLF2SDLIEuY8zrzlDKIcwmxN09rsmxJr4G6chO+ewuYImFbQbJubmBHDNMtgtJrAjj+RIsHdjUEpEMCiv29KL1TPAG5Z8mrl65zG/
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR05MB4141.eurprd05.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(136003)(396003)(39860400002)(366004)(346002)(376002)(33430700001)(186003)(66556008)(9746002)(5660300002)(1076003)(66946007)(36756003)(66476007)(86362001)(9786002)(4326008)(26005)(8936002)(6636002)(33440700001)(316002)(478600001)(107886003)(8676002)(33656002)(6862004)(37006003)(2616005)(2906002)(52116002)(24400500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: otBmqc+tDG9ej+FPn6zKIDa0HMhamzPcGPZhtpMmHhKnzgbIQsBPd/I1unoHr6iDrf/RouMHIGQzvZDy+QSKWpCmXof+05paP+ESu4bt3tG+RHMOSMoRLYjDQZZQ/NOpLccg6zOcM37qd+SRdXQqMiC8BhxLVKx9M51pEVxNrEnk8KB7iQVvj4Qbs5KLiRko7zgHk6Yw9b+HidClxNlze3lPcJ96dkDW4mkZ0jdhdpd4M2Ysa/7TeYay5tqXF66CRmAXloj3S7FWBb33359sSiIuj46eV5zJRGJINeMjsWkUFvAVh3E2H33fJ6hL/7elqDgIapWnHMe/5p0iV6YGjNKEmRFDYUuYfa8yX5lquhVHqN8akhr0jvKY2CV5lwaGWqTdZXq3gzq6dbhzFSL91ydBVZTzLkBVmgSh89HI1pVV7vmSUfKYjRq879S+hRdqbDTiICMaGga3bS7U44eA8nRUQa8snAwfS5nVJYWQ6J0=
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d8f01a4a-c93a-4fac-9765-08d7f74df308
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2020 14:57:26.0372
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nbiKiEQzd76rXtlOdU8TOVkd9Nf5huRsVQSQGIEIT+ZjC3qC9hEMF8evqCiTVrrO7xnvvE0Aboqp5uZaYPuGeg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR05MB6334
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, May 13, 2020 at 05:49:30PM +0300, Max Gurtovoy wrote:
> FMR is not supported on most recent RDMA devices (that use fast memory
> registration mechanism). Also, FMR was recently removed from NFS/RDMA
> ULP.
> 
> Signed-off-by: Max Gurtovoy <maxg@mellanox.com>
> Reviewed-by: Israel Rukshin <israelr@mellanox.com>
>  drivers/infiniband/ulp/srp/ib_srp.c | 221 +++---------------------------------
>  drivers/infiniband/ulp/srp/ib_srp.h |  27 +----
>  2 files changed, 24 insertions(+), 224 deletions(-)
> 
> diff --git a/drivers/infiniband/ulp/srp/ib_srp.c b/drivers/infiniband/ulp/srp/ib_srp.c
> index cd1181c..73ffb00 100644
> +++ b/drivers/infiniband/ulp/srp/ib_srp.c
> @@ -71,7 +71,7 @@
>  static unsigned int cmd_sg_entries;
>  static unsigned int indirect_sg_entries;
>  static bool allow_ext_sg;
> -static bool prefer_fr = true;
> +static bool prefer_fr;
>  static bool register_always = true;
>  static bool never_register;
>  static int topspin_workarounds = 1;
> @@ -97,7 +97,7 @@
>  
>  module_param(prefer_fr, bool, 0444);
>  MODULE_PARM_DESC(prefer_fr,
> -"Whether to use fast registration if both FMR and fast registration are supported");
> +"Whether to use fast registration if both FMR and fast registration are supported [deprecated]");

Why are we not just deleting this?

iser and srp are the only remaining users of FMR?

Please send this as a series including additional patches to remove
all things related to fmr, eg the drivers/infiniband/core/fmr_pool.c,
headers, ops, verbs, driver support, etc.

Jason
