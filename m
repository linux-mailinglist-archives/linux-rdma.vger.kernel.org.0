Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D49724F9AA1
	for <lists+linux-rdma@lfdr.de>; Fri,  8 Apr 2022 18:30:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231481AbiDHQc4 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 8 Apr 2022 12:32:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231444AbiDHQcz (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 8 Apr 2022 12:32:55 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2081.outbound.protection.outlook.com [40.107.92.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18B33100740;
        Fri,  8 Apr 2022 09:30:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bL+azEUwqCNerrgRR5sNE/IjdWR1DdA4445d+4bpPd2gG/5z0wKmZJvEI6epYyS8fngn+7uYIAQVe6W0R2OY40QcAaadxes5GThF3nUiCChU7QCq3g0m2s/DVnL/Ke1LDeo1pA1lu/To8T5WesEoTSD+m4swa2mHyf/4XFHAotpld16TDiYT1zl82aNNQYHbudBac7bQ+INt7pwxQXgTTZX/KD46qczEeDqr1TEfIZ6HgsP7kpy16ufOlTNL3YQHNadY+XIxTp9bRN0thZZfZ1jW19Vdi/CsD6euvt5+1v343l1U1c0izaJvBBRiU8TWh4JlD2GIfZtQdk8CsCVwJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ozv3lx9gpodI5BqGm9JcwhJkNegEH3qGgq3KmiWkWLc=;
 b=gPqkt+2uH22rMfJrSN28l1MPP8dyZ7vquxqyTu8aEAkSBLkoUCn0RtSMr91p5vVIYNs6vfGM1Y80oYeYHtyKXYKlUif5l1itiHtmNOFZcpltuJGPAFKtUmXcV6WXUhgCCwsNbepHrLcVy9X3Dv8YwQERD8Y6jEaAYfqKjJKVDVxpqAxX0qiPbnwZItx1AWVPu/nw4sb0r9Cl9UTnkQVAdnJce7g8rF1o6ckhktWHNX+S7BEoH5p6rn/ML/0Rohu+csmKg5/RDBWhz1vcvxKXEy/BoR7htR3V1YMW6aDCN0hjrzJNJT0EUWDq9ItlALv7QO40KJ1HQfroGXB0LFadFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ozv3lx9gpodI5BqGm9JcwhJkNegEH3qGgq3KmiWkWLc=;
 b=R6uu9AVKLZbRsGkmdfgqJwX6lUTmGY4s/MLG+A3JQjvKjpFfmRCrOW0h1iETt7dNGcWKH1RXVYAMJ+LzqbUwIddpGlq69e5W2QB+8KA1skFtaEv1UTTv5RQNmQjoMH8bKrcW4oWg9Ue91OwjhMnwdgutPAtE/yoXjTwm+P1YELsax0e2tcl5NQ1clionXipFgyRFS5LG82ZTSUyoU7ylvboONfZlziDNal9zhfgIM7GduWKnavBwvmkZBrq9oEMJmNU2ZhWSwjp5nqIr/QyX4hPwTCww9XqXgYp+K5a1YqpliH0lHmQ1IUZkU9Wy0e2ZRoSArUyA+RG1uTI6Lyj7fw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
 by BYAPR12MB5703.namprd12.prod.outlook.com (2603:10b6:a03:a5::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.22; Fri, 8 Apr
 2022 16:30:48 +0000
Received: from MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::cdfb:f88e:410b:9374]) by MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::cdfb:f88e:410b:9374%6]) with mapi id 15.20.5144.026; Fri, 8 Apr 2022
 16:30:48 +0000
Date:   Fri, 8 Apr 2022 13:30:46 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Niels Dossche <dossche.niels@gmail.com>
Cc:     linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
        Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>,
        Mike Marciniszyn <mike.marciniszyn@cornelisnetworks.com>
Subject: Re: [PATCH] IB/rdmavt: add lock to call to rvt_error_qp to prevent a
 race condition
Message-ID: <20220408163046.GA3612436@nvidia.com>
References: <20220228165330.41546-1-dossche.niels@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220228165330.41546-1-dossche.niels@gmail.com>
X-ClientProxiedBy: BL0PR02CA0066.namprd02.prod.outlook.com
 (2603:10b6:207:3d::43) To MN2PR12MB4192.namprd12.prod.outlook.com
 (2603:10b6:208:1d5::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 55c4267c-e86d-4d22-b9e4-08da197d233c
X-MS-TrafficTypeDiagnostic: BYAPR12MB5703:EE_
X-Microsoft-Antispam-PRVS: <BYAPR12MB570330876972872B55DCC00AC2E99@BYAPR12MB5703.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: in6kvzUE8U2QS2Y1swBviJoBuGWPVULeeptKU9aqlKe0rLqehXkKRxb2a+DPLIQifJsljGeDy0YXmmRS0MJPjCAG6vw6ZhBakz1LCgsDaUQjAqG081y9kZcLSTDCKJD/blxIr01cqd/cGf+X0F7wHEJ3SgkyyBHAUYUTeIU5kcgvES3oMlx3+gxDVbsuRpH2I6hP1TiADjAZ1NdBXB8GCjPzZtgFO40QUZ7WrMlrL85yt/hBFL5yOL9iSMQHLyKjGa7ezKUBvllbVtoRpZ0DPcc/QPaQaOhl9Vm6MmOZIRImeFNSk/4qFC4LwVUTE2lpoqtCqLqx1YVdwaM19aKTgYu3xavxWL4l4FY/rEzY6cWdf/s+snvSEQ5CBPXwIXzM6pcSWYSFt05nXO7lijTsvGrMbJKYXZ6G8zzFhb4a6UvV0CYVZmyER8N24fTkRqUDbP7n5t75nLsvzhRpL8kiYhMcx/Gv+vw+nCIHOE/y4f60WHfHHMtFAQwxrWOJA0w/IvTnR1utI0nmZe+54f1h8yQOiLSvziQjYf7J34R/3CYSfTEJwgluqJEk9WBAzdygIKr3LkcRE+2SsOOIbqxJAuhz6MexqJWNMWiAMQpQQqjEwWG0pLbZGI4eHgGr6Fjd
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4192.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(4326008)(6506007)(38100700002)(86362001)(2906002)(6916009)(1076003)(83380400001)(66476007)(8676002)(66556008)(316002)(66946007)(36756003)(54906003)(5660300002)(6486002)(26005)(186003)(2616005)(6512007)(33656002)(4744005)(508600001)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ohYdTlM2xCNVbunQx1ft94NP2lcrkcEqd6pPtMI7xawW9fsnTQZPbnRUKnHX?=
 =?us-ascii?Q?19dCAIZNO17qIE9U1UvYzh9cGVwZ7qEcAZ8kMy/pUVjStulqHiYW6N5WjfrC?=
 =?us-ascii?Q?r3SjVIkTr1VD2Xz/A3ljjBhXhtKGeKpZMI41R4i16mGxUJgSgBhxdXtbrxus?=
 =?us-ascii?Q?xp4mLsLyvyOPnjeSo0gLzBcx7jDmAROvFdTrpFsIrUW+qqsf0i+QKFlwy9RO?=
 =?us-ascii?Q?yLNTGxz6HgsEJvnV5TCXM0vObQm271zOjQvEX8Xmuqv0BqxMgiU+I/0K8Y2g?=
 =?us-ascii?Q?eXxdif4LNhiXs7FJCCXAmc6HdRPly43OS9pNhxhhdN259m9LHclW6W70PDM2?=
 =?us-ascii?Q?k5CeDKSUr2QkbNxKWVVFIOYREjPkZyQ0/u2tj97SmSIF1WqBYMCmYvx8VucC?=
 =?us-ascii?Q?XCQaxz1/+iXfs9nWf6WgNSuOkPfryJk2cBo293Wkzegn7zI7gGfXPlGA+mGl?=
 =?us-ascii?Q?Zx+BPefPJhXVu8C9rB3yRdWC4WvbKege5lwuh2cSVUB/PnN8G1Iqw103Smp2?=
 =?us-ascii?Q?mgOW1lMr5RfhC91qySXGRkcF+lfX+/ufbQQ3G5h4VfEO5skZLDRDFoZ29gA6?=
 =?us-ascii?Q?bMAKXNdYR3VvUWfOEtpq1MLK3G+TBVIP3YevVmOnbwQERKZLQ5V4Iw7rviKS?=
 =?us-ascii?Q?Z1eYz9zXsWa50k+I2h91AeUp1u9pdfC7Y6Y9b5BGeqK0iQVcxYOBYI4UEqQ3?=
 =?us-ascii?Q?LGuLwrCBIatV3NO5xizzktYZ8ZXAT62WTPXqBP0QIV3OH+770BnU9UsApuu7?=
 =?us-ascii?Q?7N2W937Ar4S2XpL8ELYpik0oWN+yWDFzhw9zp5y+2KZwEXeFWFl4EunpqPOx?=
 =?us-ascii?Q?XXdgvVhFVD+pV2DYzgCujz4jm59PKrmbvFWCyJJjPoOmlDW66HQp255eWcQU?=
 =?us-ascii?Q?qgwHkuXK+MvaZrJy5wP3j9poFcPmX28ymSPKiePaPrnWAEyu65L8+gicBq3e?=
 =?us-ascii?Q?ZfaPNjUAACppTUSz9IHvNCA9upk7qxFuAqtBH5psNokUAYKsUAHwYzD5+b+E?=
 =?us-ascii?Q?dqw3hpFIsBKn1rbYMkw+PjXQ5lXk4iqMkXxptA/BdX8fJiCkfhL8y7ub0eAY?=
 =?us-ascii?Q?pmy1APufRSKdzogqgzNJdLmtHFAApWfQTlF0NckVwJt9eZtbSzfIBTqEPoc1?=
 =?us-ascii?Q?XE0R4dV9w9SuKyHNIqvOcfGIly9YNCzbxXfIQNDiEe9qzbi6fgD5V/HWS8Tw?=
 =?us-ascii?Q?JBVLdUyPZc1biptcUlRdJjKHvlpjKFUs1PugYI9SUWZNJvVGXnHmndxsayJT?=
 =?us-ascii?Q?Gp2N9SEQFId76eh2kc2jhLlDW9CbUtVvD0KbH4nnwxMYY0hES61kTfI8QG2h?=
 =?us-ascii?Q?7BZvi8Fpe+TGPJ/RybpE/FhF0V2spyWBarQSIUS4GcPMVT1F08ZkMOHo0Rzl?=
 =?us-ascii?Q?MQCOAlL/J+XUqE6vfONMAX/o7nDrYNirWLytVLbwT+z+htEU4aL0NLGOuHm3?=
 =?us-ascii?Q?y7MDby5iqCB6G/IrfFZWkZtcQ0vQ9r52Z4I0jyIREa46FrW/AIbfGL2fEdN6?=
 =?us-ascii?Q?gRa1FARWBJk8WQH+XOF/+bbsg7cpw5sJVhs+wP9sZtJJJ849PvI3qFeoGZ8J?=
 =?us-ascii?Q?NiMEOFUyBWk6jXiozJoFg6Ne3VjMmyLbXj4IdCe9JfaKS13v9rhO5b1JUXPY?=
 =?us-ascii?Q?cn0KHSX2UPfc4B4elJfQskLHRrkqKoS8nI6DA8/2v7BYSkkK3xbRHQkkxiul?=
 =?us-ascii?Q?g6E2ICDov292OlyfFtp4fcvZf9FnGMoO5WUGerktiaQoHUVVGlbpX4bTPdUK?=
 =?us-ascii?Q?K1rkxXngbA=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 55c4267c-e86d-4d22-b9e4-08da197d233c
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2022 16:30:48.3509
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: c1TKIMcdDX4pjmAFSTiPniLNHgSOdLC7M+kzYy8ZIjv9aIIT0pAMm4/SUIU8Jglw
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB5703
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Feb 28, 2022 at 05:53:30PM +0100, Niels Dossche wrote:
> The documentation of the function rvt_error_qp says both r_lock and
> s_lock need to be held when calling that function.
> It also asserts using lockdep that both of those locks are held.
> However, the commit I referenced in Fixes accidentally makes the call
> to rvt_error_qp in rvt_ruc_loopback no longer covered by r_lock.
> This results in the lockdep assertion failing and also possibly in a
> race condition.
> 
> Fixes: d757c60eca9b ("IB/rdmavt: Fix concurrency panics in QP post_send and modify to error")
> Signed-off-by: Niels Dossche <dossche.niels@gmail.com>
> ---
>  drivers/infiniband/sw/rdmavt/qp.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)

Applied to for-rc, thanks

Jason
