Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 80B1D42CA60
	for <lists+linux-rdma@lfdr.de>; Wed, 13 Oct 2021 21:45:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239159AbhJMTrO (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 13 Oct 2021 15:47:14 -0400
Received: from mail-sn1anam02on2048.outbound.protection.outlook.com ([40.107.96.48]:56641
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S239103AbhJMTrH (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 13 Oct 2021 15:47:07 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aC30MCULTqQ91yDbJttesI7Zshxf9+I8FmN35NCmglU0EbGrYi7jLUuZVI1vy9xKSDtlWDSRlC8F31T6DasUmHEmAnm0o1pP5JiURWBRuDJKmjxOyPLVQY9FgbKNiH48FtgHMIdG/CzFC5CiN0EKmfHI5iowqFnIE0P+LMqt8DHMN4/X3vgR+c740V9b0TuLOy4mi9rDaf/E2sL8UoPfEQokjPuKHVE8FLROF3SLK6HC0BSUOLWFncvMNhCwOstixHiYsF0VzHephkEXX8nYg3kPggPkw4b9J1Bzxw5Mij1l7WEJd+tH8yMrdjPoxCxUufINv9Ted0JUZ6cYVF8Okg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=my4TCSz1X24KsYVpxqvOroGVmMws0oXIw1icSJg6kjY=;
 b=n3w+utxjHbJ0n9qFCBIUNlzFqj4Z/5bSWbau/t5ENObeJy7kR5inwTiuLZI1jKBVRe7zBi6IHsDDyt2AgXwgyR+Ia/5mUA4+SLUO6UGSn0B6EFCsJfZGvxNpKIyFot9ZHurmc5pQWc7hFywSO/xs9KrGNE9e3UuTzzS88H8jZC+mLQKDCmvhPcHkcBlk1j+pPfvJ7D0k4yVRJHzfwyeCnd4jc+Q0UxhO8OAZMrqjqrw01/hGWS1ZI592l7isFXo1+wjns/h2fQ57cF5S7jylPQYz42OAjjY7+1NKAI+hhmymjomHXMRdRbnkq2pY4hGDbE3MvwNj2Xsx8W0QA6VWvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=my4TCSz1X24KsYVpxqvOroGVmMws0oXIw1icSJg6kjY=;
 b=kPJn7npCZWSNKIzTh6dyjXnDlB5bLHzEaCCUwhhsCg0Nl48ryI3TwL98MHafWK8wzOZS7BCPfPc2LGcTX4ZTkv7j+Qx6AysXEisLsUR5SvYaI15SvVpiKCxFgY/Zdk9d9qRV4su4xw9A6URfqhSCa/9+C+z37ug96hu5OkDTQp0lbKo6h5MtGZIV6vBdupTwu7EMTG1J0/QizdeAtOmIYER8ViNZiMuuTXfNQZCKvvMIv9SP8trcyQ9ylih18yjlQjQBqPqe8mC4rafeRoInhOMyb+0plyeQ1u0H+Xz5yXV6vIMwYPGe3zJgBuqq7po12WovWBGi1vII/fGCXooIHw==
Authentication-Results: deltatee.com; dkim=none (message not signed)
 header.d=none;deltatee.com; dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL1PR12MB5254.namprd12.prod.outlook.com (2603:10b6:208:31e::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.22; Wed, 13 Oct
 2021 19:45:01 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::e8af:232:915e:2f95]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::e8af:232:915e:2f95%6]) with mapi id 15.20.4608.016; Wed, 13 Oct 2021
 19:45:01 +0000
Date:   Wed, 13 Oct 2021 16:45:00 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Logan Gunthorpe <logang@deltatee.com>
Cc:     linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
        Doug Ledford <dledford@redhat.com>,
        Bart Van Assche <bvanassche@acm.org>
Subject: Re: [PATCH] RDMA/core: Set sgtable nents when using
 ib_dma_virt_map_sg()
Message-ID: <20211013194500.GA3494942@nvidia.com>
References: <20211013165942.89806-1-logang@deltatee.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211013165942.89806-1-logang@deltatee.com>
X-ClientProxiedBy: BL0PR0102CA0068.prod.exchangelabs.com
 (2603:10b6:208:25::45) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
Received: from mlx.ziepe.ca (142.162.113.129) by BL0PR0102CA0068.prod.exchangelabs.com (2603:10b6:208:25::45) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.26 via Frontend Transport; Wed, 13 Oct 2021 19:45:00 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1makBQ-00EfCk-66; Wed, 13 Oct 2021 16:45:00 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a58de165-59fc-4c6b-65c8-08d98e81f1d9
X-MS-TrafficTypeDiagnostic: BL1PR12MB5254:
X-Microsoft-Antispam-PRVS: <BL1PR12MB52543EE25011F52E7BB52F7DC2B79@BL1PR12MB5254.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3513;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rMIwvuxju2h/+IFnVc0VPprKTPneNvGuw8JHSSv59enDFMg6Ns2U0rTusLklAnKj4j7sbuaXkWl2SpmYUnw2WBP++G54Rq/M2zzfuAUHeLJNNmwhxlf9KA9irZ0aLTzTBYdPwfQgHeUWlXbrT0+dOdp+6I9ORRpIQ3VgjhELLmtRusi05DHqHcNsWBuIlnNxURlRx0kQkVWHPcx/yW520rHVpfp6DPeZ0ZvjhEoSOQLvZ6Rfu1spzzCrB7JLRlm6t2njeHEW9qNxIabLwA15wOSNFukfI3fIn8DbI4Gif/fE6/7Vjg/fCrpAP580Zm90aSruQqiFgY2J/dYAkzLBG8tWDSJtt7j1Iqlx5TIblEUoeiw+wcNO3D5yUPUFPTnnle9dDFi5q8iFS2hFjmMoon6hFh8ysacdFluVIOiM5IxEOtIvASi9rv6esGLc4d0DOX6t4kjp8ePkoYPcvSw8J9jNBOpYIMMqxP8KNn8g8prc8+3bzuP93nJ37/lxS/aK9hvcWdKKoRLC+9dUhr3LdBq7vT8n3scw5i/BDiAoC5EWtVEdb/hNzUeqEgVwfreZlsB/PX4yo8Nm4t0z4/sXSRUl8WP5tkARxp8Pzx9PsGjVfu0fcs+Q9dMIzCy65wpnku4gfPP5m/hLJtMecdr5MF5V61YGvjzD8Qzht/HXvJwPxtBYaIaIjRqwc6xdhYGYVGi5c2mp7NKDBcPUBfrQ0Ay8Kt63d6g23ngpnTiJ97w=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5506.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(26005)(2906002)(1076003)(38100700002)(186003)(966005)(8936002)(36756003)(86362001)(54906003)(6916009)(83380400001)(66946007)(66556008)(66476007)(33656002)(4744005)(9746002)(426003)(5660300002)(4326008)(8676002)(316002)(9786002)(508600001)(2616005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?hlj+KruDWjcqHGQ0d6PMkimzIoVmVBAz6n9/AanqzcUqXeD06b0p235mJ/0z?=
 =?us-ascii?Q?KyMbg0pFRrGaxCLUWu9E7VUh+gsoOHfJ77FxxV6tKc/0ncQRxfLTPTQCWHM5?=
 =?us-ascii?Q?rXxmcJXJPM64+X6BCmhQZDc3ArJNqzp2knt+TT4pGI2V/rK+Fhfr/6AOsOEo?=
 =?us-ascii?Q?XuF562MtUB5O7ZTcMK5kkH8vDHh0nbf3x4fRvRpHUqQ8aJfe851rllSY4nPG?=
 =?us-ascii?Q?jldzMU7UGXKbMCcD7LhA8FRHizznmjBxxcQjfWHMcFo1/8rQ6IWLVhVvr5O3?=
 =?us-ascii?Q?lC8fPlNziIuii1Sp5yiKQkBW05oD5TNU9D8pQMMwrxgpndtCyHClmrs8TZSm?=
 =?us-ascii?Q?/+uIl0wGSG9HKIoxOJK+PQWdEu5vPOcfJb1vDDYSQyr6O5R4y17WY3qxqD1x?=
 =?us-ascii?Q?SI3Ly1CcuokV43vvyc+5tyQeuzRtM1PiwIQ2TkP6P3gGRAI7n7aTi5K0jntK?=
 =?us-ascii?Q?i2tQ2BqwAitTWXxM8aFjgXPqgtjcjhjqKVjju+xVRZinN7pWwELz6orAkavL?=
 =?us-ascii?Q?dk+A2iQhIOWnxHKs5yHQdABJx0PuFJXP1AYNtCfxD+P68nTDkHAbXYd3+6ms?=
 =?us-ascii?Q?VevNMhDgJdgxiNj0yCaJMMfGjTuCJU7EbTg73NXSdWpppT8cEeqcUk0QEffa?=
 =?us-ascii?Q?Ai4rnVbeTsnZPjqPX/59Lbgyx9R0Qa9Gn6WFb8ApFLY4HtgFovHBpSmahCvo?=
 =?us-ascii?Q?lT+xRjd1SSvKZ4vpNuZjOops0PjVbvDC9+3wbyoc/DJZh3IQBQfTgR9B5Ag5?=
 =?us-ascii?Q?8LbJA/nK3EtJC4hFuI8PpM61C7JivzcZHOwIuN3s/f/574WgYya4EgzDjDWT?=
 =?us-ascii?Q?ghqzGAzXoYvqTYBoqPKipao7RxTVI0HU2f+aFqu7SMj8LtssxkF3BLc9uWjX?=
 =?us-ascii?Q?l2KGYPDXXS3PHWwI0w8Urwkt6X6PflVytfOC1bYyfZFYRUtu7CfzaI3h/Ip7?=
 =?us-ascii?Q?8i0TqbdakE++ulaZhP8yaCRJ8hFBEhKu7TWQIMacbo5pAWymO4W9JkzPWNOL?=
 =?us-ascii?Q?tZD/FTuKEOaHuuw/wPL1VKxngipmX00YIswCD/3yr1I4KnNThlHL/D3KcHcz?=
 =?us-ascii?Q?+6GWn/WD4owbTPte5LoygvuuTR4FZXGEcw5BA2tG5Qz827cK4E4wU4xcUf7T?=
 =?us-ascii?Q?nj3ZeNZc+GSPlMvtLvZmuKaweon+9cHe07I/ks8apQE72wH3cT/7pZe3I6p4?=
 =?us-ascii?Q?HQ/ssnSZVQyJnMayUQYWjsMMZ03qCZFgBzBKQzsApo5N08hfZ0fH5UbZ9G0b?=
 =?us-ascii?Q?S2LLTT79XzL58JsSeUYPtY+pALts5/Jt0Stn1P5ZmGSGgj51qTiJFZK31tqf?=
 =?us-ascii?Q?ZQ4HvufwspbuGiINZjWMxuon8FMcK+ebxW5/tzr1f4B3+g=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a58de165-59fc-4c6b-65c8-08d98e81f1d9
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2021 19:45:01.1696
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kUTAYwnUm5xVBgoHlxRybsGPIEcgU6TM32rhNznhRXCaKEiHzN3YE8NEgRs6zEPh
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5254
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Oct 13, 2021 at 10:59:42AM -0600, Logan Gunthorpe wrote:
> ib_dma_map_sgtable_attrs() should be mapping the sgls and setting nents
> but the ib_uses_virt_dma() path falls back to ib_dma_virt_map_sg()
> which will not set the nents in the sgtable.
> 
> Check the return value (per the map_sg calling convention) and set
> sgt->nents appropriately on success.
> 
> Link: https://lore.kernel.org/all/996fa723-18ef-d35b-c565-c9cb9dc2d5e1@acm.org/T/#u
> Reported-by: Bart Van Assche <bvanassche@acm.org>
> Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
> Tested-by: Bart Van Assche <bvanassche@acm.org>
> ---
>  include/rdma/ib_verbs.h | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)

Applied to for-next, thanks

Jason
