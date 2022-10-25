Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2CEE60CAC1
	for <lists+linux-rdma@lfdr.de>; Tue, 25 Oct 2022 13:18:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230428AbiJYLSJ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 25 Oct 2022 07:18:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231828AbiJYLSI (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 25 Oct 2022 07:18:08 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2058.outbound.protection.outlook.com [40.107.223.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D95DC11F4A0
        for <linux-rdma@vger.kernel.org>; Tue, 25 Oct 2022 04:18:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JtH1TLBP18PxeUOLABDOTDR+EJSXA6zbKPW8mV8dw+fBYkRG8biqHpBRobjn+dzDiuiFRZO26g1eOFlvI0lPFrjlm7GkLx3UAUGcGJOgXFSakpqPE3Ahy2S5YbTWP77sKDDjW2DHpLq8SCJYMEAkIEZhGnZraMmWBnhkEoB/x7UHvfsWeCDJqjfBc43Cjb0WVqVUghdf1xyMFmF5xw1Z3rKg2FBd5uSXswsqtxk5X4yuP3Z9zpELUOcqd/lYcu4u5x2u3+rOd7aMGLUoXdvST7g9Pk/HMK+cohX9ORqAWGSanS0PHRFswOq6MWFYWrPFGwazisRYnAQ4CsZeMTg9Dg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P7zPMZ6m4P4SUDWEegvx88CZwZF6qe99FwI0HE92tiU=;
 b=gyf+AA0wKWZvQFtZ9zm9qYr4WtT+0S+4R6EeMFGytwQ2xcFO1gr7PBd+6aG512cKnFc0SiTfS17GbQJ7Al6CPR1HPMt49Tm2pEoeyFSG8uflkVNhF896FnTYrYfqskncLWRV09QgQnbH7R7vEgMstZl8DcMHhh1Y5HXGQ6oaLIiVm59bga9DM0ORyKQMPkjcWvcLpHW3UUb+P4n2zTyweDusk5FliWMUub6hY05iV3WdiDiMJlHodbIP5yUlaV7JwKwShD/ubrqqU6RSwfHi5uzTUH5tJiAy4CmmsAVnZHgu0rQgMq4OjsPkuytz5xtJ/Hy+zLBpEgBWLKRmlb2kig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P7zPMZ6m4P4SUDWEegvx88CZwZF6qe99FwI0HE92tiU=;
 b=iaPbMSNfi6dUhI+N2XcIH6XzneDAc7UDQOEit9KDEvaFT7on3kbYN59Gl4E1X338qLlfISh0SpgAMAHXg00yjjiH51h//aRuSN1EDvGenOaRtHlXtk94fws0wT/0T+AnzIqs86Bo/l6rX1v2PMZU3Qz5qfUbepHZb8qQRP6CN/v0khZLHC7r+rBooaV0FV/FimwHz+RbC/T+0eq2VjUEto+tJOE9ZoQz32+XeDg6ie0yKCTKxKFB2hn0v8diwuUq3MfvettAImC34FCMOLqC+hCNWdaeZd7EEnod7LlLdqa4N4pHcx07jMwPUi6ffee+z0mcljmxfAdjiCWcn6CzeA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by BN9PR12MB5145.namprd12.prod.outlook.com (2603:10b6:408:136::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.28; Tue, 25 Oct
 2022 11:18:06 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::7a81:a4e4:bb9c:d1de]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::7a81:a4e4:bb9c:d1de%6]) with mapi id 15.20.5746.021; Tue, 25 Oct 2022
 11:18:06 +0000
Date:   Tue, 25 Oct 2022 08:18:05 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     "Daisuke Matsuda (Fujitsu)" <matsuda-daisuke@fujitsu.com>
Cc:     'Bob Pearson' <rpearsonhpe@gmail.com>,
        "zyjzyj2000@gmail.com" <zyjzyj2000@gmail.com>,
        "leon@kernel.org" <leon@kernel.org>,
        "jhack@hpe.com" <jhack@hpe.com>,
        "ian.ziemba@hpe.com" <ian.ziemba@hpe.com>,
        "lizhijian@fujitsu.com" <lizhijian@fujitsu.com>,
        "haris.phnx@gmail.com" <haris.phnx@gmail.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH for-next v2 18/18] RDMA/rxe: Add parameters to control
 task type
Message-ID: <Y1fF7UcaIcwJegvH@nvidia.com>
References: <20221021200118.2163-1-rpearsonhpe@gmail.com>
 <20221021200118.2163-19-rpearsonhpe@gmail.com>
 <TYCPR01MB845563BB1E56CFB317D4409BE5319@TYCPR01MB8455.jpnprd01.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <TYCPR01MB845563BB1E56CFB317D4409BE5319@TYCPR01MB8455.jpnprd01.prod.outlook.com>
X-ClientProxiedBy: BL0PR0102CA0020.prod.exchangelabs.com
 (2603:10b6:207:18::33) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|BN9PR12MB5145:EE_
X-MS-Office365-Filtering-Correlation-Id: 296016f9-9dad-4478-bc99-08dab67a971e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cs5EFRwxyCAYmPTnpaMn1FWvDTqZnznWSen92QShOVb6KsAyzCab+kubpHU87rxFF6BJPEMPfXdTHFd/H9NasmETB6X/ddTg09CD3LscyPbuDpcMAjvK/G7IgPiPbSVQBCRqVh8cMc+JDIRrLlqoid0g9uD6fMyfovdP/gVg1+YlLE0fmMKJ0a3Pay9244ibXyaccf/AxX0oW5eHFG6BBKS44S7LW9+TwV8II5aQBOpTVEEzQVgzZmbeMc1qkYHThrh6F29YI78waqG2b4ofPcXAmmPD8naOxViyUSxHnJVSRe5ebtv/2LR5EENuMpizIHDy8oYNTMJHMPHraLf+FO5MHljkOCxkEn9TyAHpXYS/pmP/8TXlULNWgx2QCHF/zuuG/0NFigPxU2EHlrtz0gSa+y1+r6siRuvAyI3w3uVlw0DWXFmJo8oWuPeiktX1q1C7LRtBgAYzEeP5pmi9Ay2k41YP+hNMwOvVDA37cCeJwPLeb8Xi2YsUMnnd7cB4illhrgK8TXM9LOrg8o2eWSA5UFEEWvvP0Lk/Bw/XoT2mGe9PlhjJdE/IAh4rEhrOkxMZUn5qv6Irg3ZWgqpprz7ed5ek7CGx2ruYMYXH1EC4doQlUS8FDmhjk3ncatPFRn83b2Lu2DzxRFISQkzbznIEMh4D03Ix57EtFENcy5upG9YwBQfwj7H+3RNg7Hp08HrvfGjvvlNmzH3rDQDZVw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(366004)(39860400002)(346002)(136003)(376002)(451199015)(26005)(6486002)(4326008)(8676002)(41300700001)(66476007)(6512007)(6506007)(38100700002)(478600001)(36756003)(2906002)(8936002)(86362001)(186003)(83380400001)(5660300002)(2616005)(66556008)(54906003)(6916009)(316002)(66946007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ml6/xPhOQTw2t7gTE6LRvnoXpsg+joyNuKIg4vp3gSRFw4tCBNpk4d+Gh3nQ?=
 =?us-ascii?Q?LBHQOnQuLXV7rUHUftQDawbot2/xuxb5Mz8F0X3TjV4Y06LwiuBkbjwzpcp/?=
 =?us-ascii?Q?MUPDyXHX3ZARz8vo4ChQBpl5UvBGLnc8ZzyECUmJcSJ6VqbnlRha1OL9vF0g?=
 =?us-ascii?Q?KrEnNC2o7HW+W8xRU//tcTAPL5DtBNj0WUe62t0yEQb57zQOeyJSq6SeVPpr?=
 =?us-ascii?Q?PUOQJyaNVLYrBYQrkP226YDtDysy1E+XmRpkEkaynDaALUk8EoRu8Pz03DWT?=
 =?us-ascii?Q?wHbnlSGkwDlPU8iLDFZxZooQQK8nksg0qE0w4PcVKSw2Fh/YwL96DcQeFOOo?=
 =?us-ascii?Q?7inCi0qCbzWEuDBnvjiCj4TPGwGjTZaXXn+Z+c+2DMhyTHstaDS9iDIeZk9h?=
 =?us-ascii?Q?JWKTWIWMBN+7XWn6NuoTJQKocMNbY+OUZuKfYcNFazVBTY3B+e2kwc3XL/cn?=
 =?us-ascii?Q?JNO8DMJ8GRSEbT1E+XZbg6YLIq7p95wpsXOIgwJut6p/dQWEAMlIgXqHVmD3?=
 =?us-ascii?Q?bdZ2VD119o7SXvFReQkhE5wMGvi78w6yCmopwfPquYLwSQFaD/ADGIsPi6Pm?=
 =?us-ascii?Q?M4AUWTvmTxzyyy5riTuM0nUVEZGc5EMe98/pUjd2Mqr6gOqUTipL62LkqC53?=
 =?us-ascii?Q?Jiz1Fg/16rSnd64elG6KUUhWh0CqJLFO4Wib+RNfzh8CNTcp44YN5hFKYeWb?=
 =?us-ascii?Q?YiQ4cW82j34gHTIZwSylfKrxwA0SbWUqfxIQ31eeYqO2u0jM/qvUJ72XT27q?=
 =?us-ascii?Q?FBPK5noktlOC1dmaMMpoII4jeCXFDv/jVG55lb8hJcvCLQDqXDMMiDJyDX7s?=
 =?us-ascii?Q?1JvS1XR4eJ9nmKgxqbogY3PGK8O9GKqRIcdmTnLiIFm0g8jU+EgybZQpAufX?=
 =?us-ascii?Q?XMfZiD4tEe8hoCjo5TKiDvPem18+nYk1OpecLkdIEjliZMkJwHDtKrlmJHLK?=
 =?us-ascii?Q?prR4ciGy3l2bnGPAvqNzdQ/hT8t0dI5fbAY0aV+iqEzbvwSodLpFCdGrMAmA?=
 =?us-ascii?Q?UzunP4cE+1qiR1JvqqTuCcQqavtsd4bgTFp+YwNQ44Juk03L9zE11VnQn+vl?=
 =?us-ascii?Q?zNdauUCxfubjnCwNnCX5sfcdsHKzlV5B3f19hQLjsbZTO8FcAqapzi/mUCD3?=
 =?us-ascii?Q?D/b3fbzU79k5tMECCErAdkDA5ey+oKXnUsSzY9SW15tFnk7i67luRivAZoPP?=
 =?us-ascii?Q?4MNMKTz/4gLjBKCnkNxfOiZWOxY0mH2Ps1aDnVugUEGFiP1IJNaDKpEzfGdH?=
 =?us-ascii?Q?0JqoE18gAEEjUZTkKWa9XaH3ifb/ZKXL6VpuA2B/Anbz/N6/2iTI8huug13/?=
 =?us-ascii?Q?glHlDKyrFvyFat6vWy9N+9VrjW8NwOTQ7YYqLRMH261+k0XdbGGrFUmCllIx?=
 =?us-ascii?Q?fMhz5E7kyVmmz8oRs47W12+ItrWG2rkUzrHYzn9It/V9RD/3Kqbf0B8tc9zm?=
 =?us-ascii?Q?axCrF7MdK4+hSKp/NeRaKboSwErg75zONvv18OiX5I/iAdVCrCzkVG0wJNmz?=
 =?us-ascii?Q?E3DpGE2UjSaoqfWpjL6u7yrTYgB2S+/RGE1SgphvWY9sr31X53Ze8bI9w9oH?=
 =?us-ascii?Q?SB2FAK1PGPD5oyxNnWk=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 296016f9-9dad-4478-bc99-08dab67a971e
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2022 11:18:06.5079
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: liF2p/Exz4uBCrVTdsPz0d49h6rua9WDWWeDrbgDT3mq+977eLBRnkq46NOiTf9s
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5145
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Oct 25, 2022 at 09:35:01AM +0000, Daisuke Matsuda (Fujitsu) wrote:
> On Sat, Oct 22, 2022 5:01 AM Bob Pearson:
> > 
> > Add modparams to control the task types for req, comp, and resp
> > tasks.
> > 
> > It is expected that the work queue version will take the place of
> > the tasklet version once this patch series is accepted and moved
> > upstream. However, for now it is convenient to keep the option of
> > easily switching between the versions to help benchmarking and
> > debugging.
> > 
> > Signed-off-by: Ian Ziemba <ian.ziemba@hpe.com>
> > Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
> > ---
> >  drivers/infiniband/sw/rxe/rxe_qp.c   | 6 +++---
> >  drivers/infiniband/sw/rxe/rxe_task.c | 8 ++++++++
> >  drivers/infiniband/sw/rxe/rxe_task.h | 4 ++++
> >  3 files changed, 15 insertions(+), 3 deletions(-)
> 
> <...>
> 
> > diff --git a/drivers/infiniband/sw/rxe/rxe_task.c b/drivers/infiniband/sw/rxe/rxe_task.c
> > index 9b8c9d28ee46..4568c4a05e85 100644
> > --- a/drivers/infiniband/sw/rxe/rxe_task.c
> > +++ b/drivers/infiniband/sw/rxe/rxe_task.c
> > @@ -6,6 +6,14 @@
> > 
> >  #include "rxe.h"
> > 
> > +int rxe_req_task_type = RXE_TASK_TYPE_TASKLET;
> > +int rxe_comp_task_type = RXE_TASK_TYPE_TASKLET;
> > +int rxe_resp_task_type = RXE_TASK_TYPE_TASKLET;
> 
> As the tasklet version is to be eliminated in near future, why
> don't we make the workqueue version default now?

Why don't we just get rid of the tasklet version right away?

Jason
