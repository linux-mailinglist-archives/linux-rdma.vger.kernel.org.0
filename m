Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30F33532AB0
	for <lists+linux-rdma@lfdr.de>; Tue, 24 May 2022 14:50:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236902AbiEXMsy (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 24 May 2022 08:48:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234425AbiEXMsx (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 24 May 2022 08:48:53 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2054.outbound.protection.outlook.com [40.107.237.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA7B1205F6
        for <linux-rdma@vger.kernel.org>; Tue, 24 May 2022 05:48:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cS3xO2qL5F24Aj5Kdoa/QvZdpulS4Edhixt5F7M3odgq/blJ+eKBdz0VwxPAgYsy1q7NHeSrzs132a2oaSaR0a7XLbMtc9zyMAOyVvQHYBb+6C7Mo8HugbQ/Yad5vFaOoowZ+90odrtXXR7jEa3rprsTygQS3AickZSa8EofIPK3dC1MPZkWO7AdYMacG7Bi8n9Rza66kjADcZ1j4C4Ly9GFEJoIXG3/x7rVYR3+m8kYgmaLkMUYy7qCcJYIjax8GyhRsdDj6/loArwSnEbwzBInq+x8vUpCiybscDvr9j0Ci0AqfLNi8FMmhOrffinul6Fjtj9dTDqfql83ehPiQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NbSI3QZLFFoAo449Whd6Qjm4aROiJ4DVvUTe44lsu9c=;
 b=OhXCG0qqd84Uzan0m9ormaxMxY265T8QCCq7IeiRqo1n+Jj9JDFnjUYTqMoY+XMxfBNM4ncrkcYvzUd2G9/wVKWwOEAciPgcIQx6ix0P+OksUP/Uf8v5TTmUmFZw6ehwGXFqAodYe5TS0hAwc/udJ61xdEQthzZMON+2LBmNXDitA+yQnKc6BSlN61SeuneI7eRaTtS5JmfaKLlBC0a5QUMUZ7HjZ2Y3FH6Wdo/QKBI7XNcruojQBqNFCmeWgQ1yGdmDOzGJ+tRUqYbiQd9iPQLu5MbEGP2HzY3exNmdvt2TJ3o0hAv9zyhIt5yjqVIUNeuoERILA6HNk3o8CN99Xw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NbSI3QZLFFoAo449Whd6Qjm4aROiJ4DVvUTe44lsu9c=;
 b=m9lsroc6x2VklSRVr7k3X+mUDzjwG53TyZJiVTINMoMy9lQiZ4Rdc8AIXrzInSPt9yAXYrdMBPW853U/t6AapVpbp+IDgX8qTCwpjpCGx+DoI00o+k/GB1ejp1olIXN89de/J2b+FeL3G2JjTYtrEU6y8JpIlkyviJHCD3/syBG8ipVBH5l5C1aR9JCWBSWiqRNgaMZ/z2A1jEflgK9dQDR0wu1q4IvzMMuZDkCpagHNaz62X3nNVUJtoKgKu23avpaOVNlDdmWPtp0V0a8BSTtWtQePKVBYrny59mDis77yfixo6EbL41VuVRPC6SVIeI3du4MXKtgIn9Ol8Mnozw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
 by CY4PR12MB1573.namprd12.prod.outlook.com (2603:10b6:910:d::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.18; Tue, 24 May
 2022 12:48:50 +0000
Received: from MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::2484:51da:d56f:f1a5]) by MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::2484:51da:d56f:f1a5%7]) with mapi id 15.20.5293.013; Tue, 24 May 2022
 12:48:50 +0000
Date:   Tue, 24 May 2022 09:48:49 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Bob Pearson <rpearsonhpe@gmail.com>
Cc:     Zhu Yanjun <zyjzyj2000@gmail.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: Re: Fwd: [syzbot] INFO: trying to register non-static key in
 rxe_cleanup_task
Message-ID: <20220524124849.GQ1343366@nvidia.com>
References: <0000000000006ed46805dfaded18@google.com>
 <441e21b1-ed83-6070-e73a-97f78972e4f4@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <441e21b1-ed83-6070-e73a-97f78972e4f4@gmail.com>
X-ClientProxiedBy: BL1PR13CA0338.namprd13.prod.outlook.com
 (2603:10b6:208:2c6::13) To MN2PR12MB4192.namprd12.prod.outlook.com
 (2603:10b6:208:1d5::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 95313249-acc5-44c4-4d6c-08da3d83c029
X-MS-TrafficTypeDiagnostic: CY4PR12MB1573:EE_
X-Microsoft-Antispam-PRVS: <CY4PR12MB15736213FA5593A2DDA6704AC2D79@CY4PR12MB1573.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BgfHSTSmO0QV0SmlBLjxNwdJR7eOpps2eNlxro8zQ7EwR5YeCNy9EuNGYBzo1iSalwOYwKf0UdLxMdZdSBQlxZiV1Kg62l/vyE2Q6K2Gjpu7KVn2PQj5gsTnG8v/QH9ZgDBXOQm4MK3SydNJNAs2Jwi/UMzfidp9hnXB5zLRI0sMF1G/5uVZaYJW2e9aBz4yMsX63dqD1iuX+2V1Uwt2qQlRi+FwXO1fXeMit20MuHzUJO7TwKLmtZJOz8C1jhk5cvC9mlc1oWVEmALMckA3/wmw5PijnK3g+YNM30g7bYAuu9UGgCDrFmh+9Tr3dvAgCfnYs4YgqZSRhXuzNU39BjPmeRyv383rejsfzXQpi+KfKQz1+kJZnsLv6/o3aMd5u4r5rc7/5/MbDP3ni0N6D4dxBXJNzDh6eD4ghxS4IwE20TdY/zr3FACl4yFDcR46S0mPW/V9c7Hf13TEbOicaU5wifQQ5Pi+PM3kxgH0T/TWakrGuJ4agWGfqgM0HTn/vzFeEktXKLU3Al2FEJ05deH3c/YRdljdm36sobu4ZtGcyp5dL2P9R9X+sIZWqv/QwUCXz1Xsa7vVfb0ZcFo68X+vhPzwww1LbO82Yt4nafNy/TtThZ9yfEm/4osHhLSQI2TqEaHRNHAfqyhJQCNrFw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4192.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(36756003)(1076003)(186003)(83380400001)(66556008)(4326008)(86362001)(38100700002)(6506007)(66476007)(6916009)(508600001)(6486002)(316002)(6512007)(66946007)(2906002)(54906003)(26005)(2616005)(8676002)(5660300002)(8936002)(4744005)(33656002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?rxEzS0YvW5nL7z2ZvNM5flpT+43DwKlUgGNixakK07duPXTKvlZWfpzPndW+?=
 =?us-ascii?Q?W9hznWk3czg1nY8NHfQT4BQoHs96X0tfUeGfjGRaNWGfe8E3kXY2JEyxBg4W?=
 =?us-ascii?Q?NdqMnkSHvHK3DAghrUw+7MsTWvquhDYaNL21rCIZpmwA9G64+jbDvkq71GvN?=
 =?us-ascii?Q?NPGp1WqRXU0+iKjL4l63tzyy6mK8XlEzGiFsEASPDkN8wg/Xft7cwuvlLh/E?=
 =?us-ascii?Q?tJUgsmKnSquCh17Wjy4Qi4JXNlEMCujWXIDIAPiUD/RXrMDoYrKi5Y24uWLn?=
 =?us-ascii?Q?QjcfgaLzLpUQrsei2ELfYMu6Mzo+4PuMRRO13SpoXVSTT9nf/pgbohcVU5Fz?=
 =?us-ascii?Q?wOXY/Ja/aTBixX9qfR4R0nnJBlDVHiNSPAyo7f3DsPTLpJdI8AqMMw+wsluR?=
 =?us-ascii?Q?TuSBnvKe5iVY4mmsN311Y7t+k+t/1YZd6Xhj3O0I14jBeKrq2pGxAti5XUYa?=
 =?us-ascii?Q?fKXSvkSCEmtzEuFFPwyvSHnl9//msw1Ybyr1kYfg+nTg51Oh6BQ8M2Wtjh6w?=
 =?us-ascii?Q?t+CnZNUCAa1ta1aOX0uERCxTr0nF9ZLu5OsS8cIu8mHzktRTM9lACUy8QJrR?=
 =?us-ascii?Q?p61Sk3I0Qqxtm4E87cnbraOEmX+AtXCUrvb6iwfbPcHFHTlVilfwrCauqkbJ?=
 =?us-ascii?Q?itP6TrIl/QlMtSj/cw89XK66qEsJ86/BDZwhQc8P1mOyE+jOuRJp3ljaSnfD?=
 =?us-ascii?Q?0Qo6p9UtvS61waqww9YFLtsn/E6HbMuohduSQAPeUbECPgwAm772Rm0wodb1?=
 =?us-ascii?Q?gY5vjaUwjU3AX51y5QRDYCnzifHKCCPcr7h8Hk/YXyoGpbSiTdICKo3hvq3U?=
 =?us-ascii?Q?l6SibXVW0+9+29gkPoERUYHx5UA3+882r0UvipJxeHLcWBfYhKgjnBA5OXXx?=
 =?us-ascii?Q?bvA6AqYuvwL4uQaQjmENQhGIBJRaP/zSqIDsMehpk4laV0OzBIK4arw5A0/U?=
 =?us-ascii?Q?Ahp9p+h5tLTJYMSdo7USGVbhGyOBSvUVGjsetdUg02yhl7foIWUyrvRDRh4t?=
 =?us-ascii?Q?2whcuqaLjqCUylgYVFi/pHqCFGRuVGBmkzVvEeXmaCiiFGm1S9+4dBGC0QUY?=
 =?us-ascii?Q?ctsHn7AeMeLJDFhVqpG7kG510lArX2u2O3UviwEJTmcUBlO3HXyV6z17y3lJ?=
 =?us-ascii?Q?o2fDCBgv67LWeZft5qeO6s0e2eYM52h4J4GQ2W+Ube6SJQLNPjeJqdxRYz+W?=
 =?us-ascii?Q?XMUahQHasIQ8Ogt698Ec5HACO8DW2AHlgCKS7grxa51RWeyLdMt0685ZzG/b?=
 =?us-ascii?Q?c4Fer+oil6R9/BkKrDj/V/GIiEmMrl7kdbHEYYM1M+zl78O/AW1Y6Bya15+9?=
 =?us-ascii?Q?HDq7/QjS+4omeCCMPfsRcdK5RNzncMznYkXU3khdpBSr2hzaAs64ftF7VQYx?=
 =?us-ascii?Q?XapBfCG8TrKr4VLU1E5kx1HrYgl65209S62F9lSxGPZq/1y4yGzH99WtKf4B?=
 =?us-ascii?Q?YdwgvVpPXsQXAllZtiQ9F9gnjR1g8m7YqSA+qlYOx/QrkPMS0VrLfzbsEOxk?=
 =?us-ascii?Q?3boPJNBKFT/2UiIC+Gzyc3ckeEhVmlmoQU4FQhYm3kgYd2nOzIYo1BrEOqQF?=
 =?us-ascii?Q?hCCeIgSsaK1Mf5u7fpNnAySTwENbJcF6aSpxlPWrIII+rk/V520FfLXmR7Nx?=
 =?us-ascii?Q?6QfNgu2cBL7jznROYgs6M+saaykDKVp+aaZZ7dj0q0O86pJyR0vikkTMb98I?=
 =?us-ascii?Q?q5izBprBo5RisHRTJwoxMKQsLgJYhqRM6axzck3QBvSvfmLQei9e/Mw9+CIm?=
 =?us-ascii?Q?ZyB4xzotuQ=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 95313249-acc5-44c4-4d6c-08da3d83c029
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 May 2022 12:48:50.1864
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rAAal/pX/I8Dfs+FTr5GoBEAeG4Yrk0A4ClKbX3hEycIaPFBR3n4MsfnU9zT32Av
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1573
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, May 23, 2022 at 05:55:00PM -0500, Bob Pearson wrote:

> I am not familiar with syzbot warnings but this feels like an
> instance of our old friend the lockdep warning caused by AH bleeding
> over into the other xa_lock users.

No, this is an error unwind problem.

rxe_create_qp() failed, and did the rxe_put() which failed because the
task wasn't initialized yet.

For instance rxe_qp_init_req() failed before reaching rxe_init_task()

Jason
