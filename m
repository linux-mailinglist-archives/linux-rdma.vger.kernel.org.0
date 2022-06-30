Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C13FF56225A
	for <lists+linux-rdma@lfdr.de>; Thu, 30 Jun 2022 20:52:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236741AbiF3Swc (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 30 Jun 2022 14:52:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236066AbiF3Sw2 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 30 Jun 2022 14:52:28 -0400
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2078.outbound.protection.outlook.com [40.107.100.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F6172BB3A
        for <linux-rdma@vger.kernel.org>; Thu, 30 Jun 2022 11:52:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IV0nNxzaAQyPfjx05y2QKBvglI8jghXfRImsgzI44lz0nzxIjLbxWFzlk5wFA7kDdtpNZh/6G3Dfrl/FhTC2r/lVMRWVIchj9wrz4NgPsarw6/WNmFSlTgPbz7uJA5APad1928eK0u8oUwvJ1s42R7KTi4nNy8TiUvHWgxG3Mw07RdOCXpgHxXQYlq65jJdtXgZCr2dohG7s25O+mr2WnZNrec3srBds3AzPem0vzgpTG+vFAh7EqaX2fTVbGtijW6FVHQAX6ZBUu6In8OPB8JyWxHs/6ZA85Sib7YWBDFC691Ln9UsJfZqWNf5y3fkWKb8aJaxZ+Q9uyHA07Eedeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bq5VArHApvAkDRxKGUG/lkVUBFZarh005fEONLvfeMc=;
 b=gnaIEerRLlf/Vi6TQmWAHJvANclZ9zWEeUsG1nBycgBqMtwHAuieTOBCykYdzNGXQRHwqhe8+vN5EYG4whEg4M9d9OeD0281ABX+tqcouq6NjyzRg/11RePojnlao8iQ32JnrMRJdAu2R6eeYQG1qabaQI3B9kB1sYKf3P7O7TY0zCgihBMv1vyHPvZLlbrVKa7iEw0aYyDZk46rgHm62QSK5xD91M3xE8xsaico4L+4M0XulleQtku+SaTLyQbTjXfe39INb63JFST6jI0uSRLIO/MWEZXMOzZUCXU9sFynvmQds9CUP/zmv+X4iFcMruvjIHbPNALBdlkABlrf4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bq5VArHApvAkDRxKGUG/lkVUBFZarh005fEONLvfeMc=;
 b=DX/bd+gxPdz15MAaui5JimpYGmPx+BZndGjPO0DgxWp81ykpqqeAmwy+aXjZQI+vi9jlxvtgHA7JZrMAdtE/qRRluewLYJ/yoRBBquV4OeVmG0oFsdiuJLUayJXS3dWxgRMRwFT+onuaNZmkmGY8AGW5CH+dur9tJMl9cydPDnvmk4nhIwYacZFvCESrlczhB/sCxytwB51ZOufbZBqRdoo7LzHwPE4CWPTfqtiLrRqBK56yPpaBwn7weGQIxum7WGz9LkBmSOx9nphQ1GSIpx4vcoP/D5Cpvr5ybuGEB5MTioR524b3qqS1BAokI06+6j3k22yih2xPx28UUH+3dg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
 by MWHPR1201MB0176.namprd12.prod.outlook.com (2603:10b6:301:59::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.15; Thu, 30 Jun
 2022 18:52:25 +0000
Received: from MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::ac35:7c4b:3282:abfb]) by MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::ac35:7c4b:3282:abfb%3]) with mapi id 15.20.5395.015; Thu, 30 Jun 2022
 18:52:25 +0000
Date:   Thu, 30 Jun 2022 15:52:24 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Bob Pearson <rpearsonhpe@gmail.com>
Cc:     zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org,
        frank.zago@hpe.com, jhack@hpe.com
Subject: Re: [PATCH for-next 0/5] Fix incorrect atomic retry behavior
Message-ID: <20220630185224.GA1055414@nvidia.com>
References: <20220606143836.3323-1-rpearsonhpe@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220606143836.3323-1-rpearsonhpe@gmail.com>
X-ClientProxiedBy: MN2PR01CA0059.prod.exchangelabs.com (2603:10b6:208:23f::28)
 To MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: da546be3-080e-46a9-b17c-08da5ac9ac32
X-MS-TrafficTypeDiagnostic: MWHPR1201MB0176:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DZkEIo5j1uAHOGxkKu8QLIAedD7bLjgnDyYEyD9Qj1yguSXyxEBtBCw+T37Eigv6X+iqpP6b1NS4C/xlw0mRv+bHUXfC7ExgjijVGdTJu/uz3ZWXPRaCYQBmxNt/xFRMbba6ipoihvhl4RR9GATv+L2DjnIkEFddj1xcnKHV4mnLuk6RWrTcJMuM5u+Iu9o/xRUnP93Vhh1ECgjHMIKwnV64MnIrVLeGSA7r14mrUM63O+Y/GUw7x6ROSO5WOux5UhY0EeJRZm/phAT28URMIk3CBCt5hWWj0HlrVz8GcXMhVD86twdBY7zWNjnlYNG6gywLE2YG/S9EufV1bb8YeBGuW2dJybWOntUsdUkMpFJiNiSprLgoLtD8L6rROQknYBMsZ+OfG2DAKGfcmrIFfr71bwKa+sdMRcCsgyexxU9Au5AS8kAS5A7IZcGag2S51JRFZv1UWLGIAV7TP2XCRgTMmbwM3bC9tY9zNzXXtTP0FzWRGtA8xMPn8uGWteK0tDs1IfH8dwbAEZ9hfIZFuU0jw6fZFzShadS6Wd6fUKPEXkC1z0Ru8mEdvuu1RZ395cw5GDsBJ+FxXnYLPMX7iQ+rmJNdqv7Vb/4rRU1JTLdZbKXw2cVOf5wNHfzaxmZJaA1FCAvM9g2k7crEUTwIgQ8rwWZUi9G7fDEkoolMsBI5f6zOlfls5uGMHG7akpTpoSGtrB48rTR52YaslHOUEVC/iDOVnY+kaW9O2bsIMsBjVK+dtKiRELZRr/76TiD23A1PzitEIT50NPcc99Brqg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4192.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(136003)(346002)(396003)(366004)(376002)(39860400002)(38100700002)(316002)(186003)(2616005)(83380400001)(1076003)(36756003)(26005)(8936002)(6512007)(6486002)(2906002)(66476007)(5660300002)(66946007)(66556008)(478600001)(8676002)(4326008)(6916009)(33656002)(6506007)(41300700001)(86362001)(4744005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?FVEwdfM0AfGcZreKi8hlzWOg/04hDdMJ573RzLgy6LSkrrGhVn7jrQEqofU5?=
 =?us-ascii?Q?IlxjeVsfIinLSRFg61pS/EqIhotV6J+vExFv0E7nFHJNp+CX2ITIUce7mMeH?=
 =?us-ascii?Q?uGPVfWih0Hj/MLjC9lNDGthNgmpnSIOXVktA37Uub7Pd36TH846UtOlmPx8F?=
 =?us-ascii?Q?2OuFUnJ4irxYusqJ8y75r8tceV9cZh/7giWM/6D6k7bI+tYiUphMmdQT/Ijx?=
 =?us-ascii?Q?YppOYB5Zz28kAYciIzRoFoX+sG33POxr6CWX2M757YQTX+/F1IK1f7oFqRDd?=
 =?us-ascii?Q?McjgTDWRBuzUDlIP4KM09Ra8qRkGTSNZkmKlFIqsetjlWZopbllP3ReH7WwS?=
 =?us-ascii?Q?bcEtpyy84NaNjBd+ag44ViDzGLjrBjsUiWtMDLKswkmIeOZvKuAA0frtGhrZ?=
 =?us-ascii?Q?QUGT701pf85R+N4RJWAF61mJ7lfiyqUKASHRTjvau2qQ87iL+0+2HdoamgV/?=
 =?us-ascii?Q?1VP0+Ssr7GOKmsVJ2VLDhO+smrIUGUWfpBioLifiaHwCW97d1KjHaf/bzWnG?=
 =?us-ascii?Q?ogzBCrsJklod/qTicf66FwZ9CLrU6zi4hQUsPxGLhLpHX+lyKkC6kfJPwgek?=
 =?us-ascii?Q?OGrIuxNvHhA/0aVuVvJTJdauZ9MCZcJK0sFN0RKwQ6aDsd9MIaKv6wAIMBK+?=
 =?us-ascii?Q?lJuIQKA+TMIazckh7hrz6JY6dFiIc6TivrIcrWtLo5fjkdKP4u0ulGwmgFqa?=
 =?us-ascii?Q?HxVFNS/6FGjli2KUn6vVIT06drLoIFuX+VySonMRsyp4owJW/xvHLcSTL9pX?=
 =?us-ascii?Q?VJBEkyn0yG1y4zo3sT+G1cLqUkCixg9KWToWZ72KwnWqtPbcW2iGl9RTNH4b?=
 =?us-ascii?Q?H9gZ72RnQN4YaMRzDhIeiDPaJkdmNN/jpkhUoRg7o+91ywGcR4TccLKJyDFH?=
 =?us-ascii?Q?yABGrP62IuW5ujK/MlAfKZmYm3m8U2pa1cBn19R6TJEtTDg3227gv6WOo6H9?=
 =?us-ascii?Q?TMAMDoQZUeS9V4qchO9yR0moC3sKoBYp6unlzxadEDc33W0FiH2W5xYfrkbv?=
 =?us-ascii?Q?3Kl5yU2HLF3bewJ3VeSur6O/VEO7Rd1vp1jTwbsT2Kwb/tgfMEbUCev4dKeU?=
 =?us-ascii?Q?caPhHFNFCCKh122CrQ8gLN+urY0ihgzpLX7D76tcQYtRJZnvSpSxy8+U408S?=
 =?us-ascii?Q?V7uJ9kyEW9AAp2grBSKAcjI6OdYhJcUJ1ZveBCR8/OKuZ1KpOBVwE81B8h4i?=
 =?us-ascii?Q?mdcjx2QZIyVSy6zIGQv3nZnoflGKihq8c+/M6wCQog5F2GBsMnIP3y9UBvJj?=
 =?us-ascii?Q?F8QiFE4X/0axKuSot4ERx17N2PciMCO5GwnVIBoB+HsRcxc+lM4JaFoTLg+J?=
 =?us-ascii?Q?ubSjjReSvEvBy++13qdcVDRVgc2wCY2kfHhNF3VNzmQtyl4HdTSo7JA9QEXH?=
 =?us-ascii?Q?bR2k2BpxeaQeitqvCttJDFGPp1Y/D603EqbGImTkHyC/CIoLYzuNGZab1MpX?=
 =?us-ascii?Q?771bGlbRtNhRH1E3w/VmwanZRKn/LVzfydIAxueEzeXrqptyxd8FRR9IRqGM?=
 =?us-ascii?Q?D2uKpUFHyCWKNqcra8hyetuGy7tCDRvT5rW0Q2hxPq9i4itEHZTmESvBnXgs?=
 =?us-ascii?Q?CjjaCxQPqhXq6kElA88nLwzQzcWYbD+hDxovF+e2?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: da546be3-080e-46a9-b17c-08da5ac9ac32
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2022 18:52:25.1994
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RAU/4pztwEjKMWpG+/p9wiUu3viSed4qalAsC5K+ROyQu4Tc8rDrRo6458JuewH3
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1201MB0176
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Jun 06, 2022 at 09:38:32AM -0500, Bob Pearson wrote:
> Restructure the design of the atomic retries in rxe_resp.c modeled
> on the design of RDMA read reply. This fixes failures which
> occur when an atomic ack packet is lost as observed in the
> pyverbs test suite with a patch to randomly drop packets.

Applied to for-next

Thanks,
Jason
