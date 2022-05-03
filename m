Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FB27518363
	for <lists+linux-rdma@lfdr.de>; Tue,  3 May 2022 13:39:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234537AbiECLmi (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 3 May 2022 07:42:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233066AbiECLmh (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 3 May 2022 07:42:37 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2077.outbound.protection.outlook.com [40.107.92.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D819D35867
        for <linux-rdma@vger.kernel.org>; Tue,  3 May 2022 04:39:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iw/yc6Yo8gKQOfMb9KxIafhNYtVXRxatjLTaRZ9LyNuk7CrjtZky+yVfxyrpUznD3JxlMpw2qd/Ep99k7dYBZeRRNYZ1iqX1ZRkCPU5YjTMUcWpFc8b+OWbtNxEj1OsxDV21KXO6TGaqdck2/vMVVMzgp9FTslvTG1lkYZjdmPNNizpyKKPlucXmYn2NO9o9o3VNxHv50aXytoass1vnLx8pJ6NlezEXqmmPMJVLjcRNJPAq3KOvkiwdR0UiB63wrZHU7Ca9jLMwN47qiq4gcyQUGEj5yRU7Evd2IS6fHNxrg9SosLs3NtJu7pK6hqVwh1mhf9+rmPBo9Wc1FXY2wQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=43lHgQ287KQhG/kKk3Ot5UxGtnSl0SjknvM95mm9TGc=;
 b=KgI4vYwYlGBHLQ10LHv46cz8CSXu8BB9WTIk9iHMTLxuU2SnLk4V0TvoSO6Nfy9x4onmdpC2RzIkl+4A3ikgv2pA5WdMgXd20RSoMUOO0R6gmXOCJZiwiRD4D7hv1iuDWvJlXxDuKi/chyROJS/1cEq1SO9Tf/m/XXRv0NvADfZKgm/il8oyTfkEcQMfqxPp8/idx1104/rBT5tzTYIYrhIp66tzSCUVKnYwJ1384dGerABS4YG9V96yph6Q3x16mtWIoPW3QqvXyJijePVM03LfvR/0SXUCu8ZkIqv7EA5JAuQC6VWhx+bJJbSuEcZc7DmO/8vzJUeaQwUaO9/OLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=43lHgQ287KQhG/kKk3Ot5UxGtnSl0SjknvM95mm9TGc=;
 b=r1yuon5VuwgXheSAs3MaD0RXw1Dhs9qvXdV/NYUm3c4ZY+AbAVpX134TmDddLfwvfB5yWEiizW36JhBC78SyoAQAGFK+gDdlEjyJIaewxlFGFKm8B57BQttLqOFcrjKWYpgZeKehDu8upCyVXGWT+L3S7Wugnh1WlcP41z2AqC0avJqbdcF887uo5gAQw2DoeqOPyWSmehfBGKu4i+O9ll0H4kDqMeD0LFritIafZEpRTbcGKdpT9mbeOHPSuP/sxg95l6nYKq2CC9ldx0BkG3+AmAzSu1s63mOOlWvAFvant3bCunPZoONPLvOIdn7D0LoKOtODtlYeuH57yEOGug==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
 by MN0PR12MB6003.namprd12.prod.outlook.com (2603:10b6:208:37f::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.24; Tue, 3 May
 2022 11:39:00 +0000
Received: from MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::ec2d:9167:1b47:2db2]) by MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::ec2d:9167:1b47:2db2%6]) with mapi id 15.20.5206.024; Tue, 3 May 2022
 11:39:00 +0000
Date:   Tue, 3 May 2022 08:38:59 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Bob Pearson <rpearsonhpe@gmail.com>
Cc:     zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
Subject: Re: [PATCH for-next] RDMA/rxe: Fix "RDMA/rxe: Cleanup rxe_mcast.c"
Message-ID: <20220503113859.GA581344@nvidia.com>
References: <20220413052937.92713-1-rpearsonhpe@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220413052937.92713-1-rpearsonhpe@gmail.com>
X-ClientProxiedBy: BL1PR13CA0091.namprd13.prod.outlook.com
 (2603:10b6:208:2b9::6) To MN2PR12MB4192.namprd12.prod.outlook.com
 (2603:10b6:208:1d5::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 00e5b1b5-5fd6-4d79-0727-08da2cf98408
X-MS-TrafficTypeDiagnostic: MN0PR12MB6003:EE_
X-Microsoft-Antispam-PRVS: <MN0PR12MB6003B4016AD499D4AA61A769C2C09@MN0PR12MB6003.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pEXXnMfo4iRrWCCuossPoK60d7HEuZXiL6J2it8Sl2jZ3vyQbFCKBBUah7b5O0RUCg4xYfE9SvtgTKsyAvtMF3ZaTSaSHoVPxAs9OW8XzOpiQhlEC3ZhRlurIbEbCDaoW5nEJZkV7kBGheJDJb7U5Pq98DPmXONW5KF1Zwc8HPvhVhctqHWAhnEB0J+rJFQrK2qDaAVzUHznAsXBA3h17KGt9gHQECf9QMHH3lOwZRqiz7kLf0M4cKjlPkNa6ROuQQ3uviL2pW0uS9OQNJ9u/UNKSa0TJjkFbyvXRFE8YRyO55uLKZ3iFVuMqQH9YFAZAjrH4ygt3PjJxjiC7cUXN97lDTAmKVkGrCb+l8AxlpK98SDYiC8sGRNnxOLS/7zSIYtIV9ktpDpORPMmINjQP/JutLn7q0kkC1f3sCRsX7WWlhmscFvgZa10bDcS58x7rnuZMOzit9ssORM5fpu/bF3jHksBU6MxQB5Bvmpt7xNZ9jhPONC82KorLFEcH6AaqZZBriItTbZanDxzEmkAU0GRAP7DxKkEZ6wv/jjLxXp9uMiFGyADj6UDc2WCGQ6hqSPG+0hu735nlbBK3l2vo6lmkElyVQGi2xER4BvLPng9cb6fIPlgrR4v5RWrWpmFIXPc4HqnOu8y6CjOtkco1PPgVILiacn41zohafG6p7XMZij7AmV5GwxE/JlreNL66Q/MyGxOj3lGzVMzngLJuQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4192.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(38100700002)(6506007)(83380400001)(26005)(5660300002)(6512007)(316002)(86362001)(186003)(4744005)(2616005)(36756003)(8936002)(1076003)(4326008)(33656002)(8676002)(6916009)(66556008)(66476007)(2906002)(508600001)(66946007)(6486002)(27376004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?xqs3psQbgs2fMA7V1Zok+vbNrVz1PBlBbhlaSmTGVBtixLlwa7GDNmqhXpJC?=
 =?us-ascii?Q?J70CG876Nl8qe3DcRRl4nFvCR4BfR5ANs1ph+G47oH3cNlp3WalIFU9szbiM?=
 =?us-ascii?Q?YzuQi8+9yCS4QuVAPjWBwiW5kmnxipEOu8fJLRX7D5ij7OqKquDzniGA9Pfz?=
 =?us-ascii?Q?etF/uq5yizncR2aPQ0OX1JHDP0lB3p0c03CyorXOKttaMJdamqCGs/a7y6id?=
 =?us-ascii?Q?g85Y+UQtEB2DeScZTYgn4IHhmn8Ltm+5AQDaLDhFgc0P491t3tK57vlUa+ld?=
 =?us-ascii?Q?7kIfOQY/uIzUHZn3V1GAEe2rJe5Uv3pLwiAs2JF4F5PANLEzlunR922z3xOw?=
 =?us-ascii?Q?MSOfm7UVzEqibRzxdJGPweCboleCuQVlikaEw15igxwBbXzvpRYX7DT3rlWX?=
 =?us-ascii?Q?Fq2tBrl2TNvhTfhM7BX7s7cCmvj7QQ+pphjc07ALQYffaEJwJ0p3eZVv9Fwx?=
 =?us-ascii?Q?ormcgb4Yx3zbA9WZKNiC3Rpf0AmDqUL9ZlL0mtgPBrC7KFNIEZjWz2pRZqaF?=
 =?us-ascii?Q?8S6aIeKFyerCzqL+yv3tNWggsyCZf7eHye5DYys7ov6V8S4jsZPA944rjCPb?=
 =?us-ascii?Q?9ZXW7daj2LYuvfj43AVPVkqtTYQS1ylpr5f/okVwOmUJCaw+gUUj5AaZOq6z?=
 =?us-ascii?Q?GR0+XRzsuvW3gkA0ihUwgTAXdk1/nDTFvee6RyQorccP82jLdtmGg7RmnWfj?=
 =?us-ascii?Q?q/cPdVA0fgQDhBDJf45HrGKiyO6WW+AuI3anF7VOhV+tFnpnQSn3lLO4JJpv?=
 =?us-ascii?Q?aGelwlWtjQ2L+vDg/gO5BydP+7QKIJue+TIRo+vzBlb1PZzBlJq4RzgAFFrp?=
 =?us-ascii?Q?5zr+qHpYEYkksyJSQZL72fAJTJmZrYZhkuctFinPgrcuANmqqtdwRktJhy/m?=
 =?us-ascii?Q?WGVKLSpse2+sTFrKlgXKjJAFoEYgiubh6Um+rKbfWuS0+kZ/D4OXu771Vfcq?=
 =?us-ascii?Q?L18vomqoXYKr6PhZLQdo/LRBmYjt14D20GtJY1auMY9aIAjLP0G3lvGYsqkp?=
 =?us-ascii?Q?oza/UURY7UrY/+RIoZTJjC5sLgfmEPRpQsjhmQwDLqBPLWbGGixrBW/Q49vU?=
 =?us-ascii?Q?X5egTt9tIkYg0qhnOlgaUH+PavhSwyDRQsRmJyXBr2nxmbBK/lByH9JXg9VF?=
 =?us-ascii?Q?NhcPhXVGcqehpRwfdqditxyr1y4KMNKAlONvOiUdr0aiZsSkfgOt2XvAw+7A?=
 =?us-ascii?Q?9FOhwW1BsYmvR/XVZGLJBL5+gJBLQ1avWU0thjtKGR2K11pR8BF83kJMFipT?=
 =?us-ascii?Q?7P5mzKDmaxQR/YPY6aD0qwuWLg+5cJ8Z8tqrm76CVX3RFVLREf5SjxLXBk1g?=
 =?us-ascii?Q?495a7IkiY2LPL4NgfHVgbXPk/uoN+sOkSDi2qor5dzYNZCh2a5/t/b081ql8?=
 =?us-ascii?Q?/5TB21TABsvTSUx5LpMrwbbxjHty/OFaFyH5SYWa/xW56JqYg0DAkGpdpWhE?=
 =?us-ascii?Q?WAO/YDVQuy6e59HsIcp5vX0s0g0JAMTYZcScQhypuOF6j7lQMwJfiCbl7Y91?=
 =?us-ascii?Q?WfPhS1jIMc4yBd8IsuK1fbEvwNEUZc6rz2n4bm1swDnyKKwvF9HW06OTSHED?=
 =?us-ascii?Q?6qUST2x2akFLmZsp41Azsdftasg06sBZVu6LJvYvoh0H9s4mTatRydbOpjcx?=
 =?us-ascii?Q?JgJzPu+Tss5Mxm5VggEy0XRUL2ghlkmOOLYyXnX6dfn/fFVBfuIDTBBmKdb0?=
 =?us-ascii?Q?lzeK31r4tJ6VdASonZZVzHO5M9RXgOOzK9NICY9B3Ou+GyrbTw/9ejyefiok?=
 =?us-ascii?Q?yPAlYrmUwg=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 00e5b1b5-5fd6-4d79-0727-08da2cf98408
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 May 2022 11:39:00.1964
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UmoHcl4ouoNITcD3qppkpN7fkMj8eZc0X3JVbWFWR63JUbZj/bACbHNJ7zxwd7W6
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6003
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Apr 13, 2022 at 12:29:38AM -0500, Bob Pearson wrote:
> rxe_mcast.c currently uses _irqsave spinlocks for rxe->mcg_lock
> while rxe_recv.c uses _bh spinlocks for the same lock. Adding
> tracing shows that the code in rxe_mcast.c is all executed in_task()
> context while the code in rxe_recv.c that refers to the lock
> executes in softirq context. This causes a lockdep warning in code
> that executes multicast I/O including blktests check srp.

What is the lockdep warning? This patch looks OK, but irqsave should
be a universal lock - so why does lockdep complain? Is there nesting?

Jason
