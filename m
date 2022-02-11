Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 403834B2D4A
	for <lists+linux-rdma@lfdr.de>; Fri, 11 Feb 2022 20:10:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238169AbiBKTKg (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 11 Feb 2022 14:10:36 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:38430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234187AbiBKTKf (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 11 Feb 2022 14:10:35 -0500
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11hn2212.outbound.protection.outlook.com [52.100.171.212])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFE84CC8;
        Fri, 11 Feb 2022 11:10:32 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QJX+6InHg4luQHcK3mWmUAVMbhk61BsQ4UZs4smQsFbHRrz03te7DSk2ZhgKMzO6e7LQQxDGXooaJityM/H1WTXDdnsApqcv5FayaEuoNB6pvbvsJ8n5ZoXI+BCCsaBzo0yIeVoHmgpgSjE3M3i6Go5unNhoGWB+3TFuDgdFIZ9A0OVHy5jqdCu06ITDM++xwHwm8RDIAx69bfCEJLrlCovuCYDML6j2fhNWT5IuMYrbGFuDOJ6XVqpyM7YN0h56Ewod40EWqpzWOw7OeoQt+vnPZ3fKeQ0GNo9xXuW6Zi64wf0zSq7/EcxmfvsQHO6WFYRPsnbjAxylqIfgFgQUsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E2H7FsZvlexIms6S2eH+8pVnX5w4204YtMu7/Bk/uAQ=;
 b=d2elAubck9aA9Ocwh8vs45c7i5fiAnXmtJN1ZUmv/rTMNzUV0ZcB1f/kg0n9NRXPD9uBP2nJHjCRIUGNjQRwNAVKu/ACayT2YmxBVedKi27E9GvcgiaxSxP0IA6KrkqINHnvbozikaZb9l6NCVTYi9qnObEGYWcuaqvEDKLyD03eYxBipX7wbO39jvO1NWDhJ9VScv5svWuP4QVM8LTrDd3me2N8XQLN2RN/l2D0MkytA+uksYEZgRaJrR7pI0aJSg4sjKs7g4QftEBmnCgS1TWFpTTpNbNPV0zDDHFEzHPt3P/IQFzPMsoilNPOFShrMrGnYIVVUUfHsN1PdivP2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E2H7FsZvlexIms6S2eH+8pVnX5w4204YtMu7/Bk/uAQ=;
 b=G2uND4Za/nQJWSTxVW0CQyus7TNiGT7OoQGSHvkwuYO/VJv46XycNqujte3F8baF8C/bPGnqIsY9Ejfcory+/KsJuapRPRmFeJ1NY0GzthHHzWfQeDp975uQB1QjWYDjA7lXRI33Mfv8a/mAfgdovknfYQvLk0CUe7dOVN8wo8C1F/tW1OQkGNWCNYv9GXlZKw/THJYXnm8kfd0nk1G3L5dESTYA1Af0XLHWTXYIyRBwoD9ueROAcTWZxyFketaC3jUfgMp+05bYkyQS9/+PJHr2K7zN9cMGFucUcALozmExUWUCfPjU7ohWI+RM4EnBUk22UWqXfuw0kXmzYGy3Uw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
 by CY4PR12MB1320.namprd12.prod.outlook.com (2603:10b6:903:40::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.12; Fri, 11 Feb
 2022 19:10:29 +0000
Received: from MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::e8f4:9793:da37:1bd3]) by MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::e8f4:9793:da37:1bd3%4]) with mapi id 15.20.4975.011; Fri, 11 Feb 2022
 19:10:29 +0000
Date:   Fri, 11 Feb 2022 15:10:27 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Yury Norov <yury.norov@gmail.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Andrew Morton <akpm@linux-foundation.org>,
        =?utf-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        David Laight <David.Laight@aculab.com>,
        Joe Perches <joe@perches.com>, Dennis Zhou <dennis@kernel.org>,
        Emil Renner Berthing <kernel@esmil.dk>,
        Nicholas Piggin <npiggin@gmail.com>,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Alexey Klimov <aklimov@redhat.com>,
        linux-kernel@vger.kernel.org,
        Mike Marciniszyn <mike.marciniszyn@cornelisnetworks.com>,
        Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>,
        linux-rdma@vger.kernel.org, Leon Romanovsky <leonro@nvidia.com>
Subject: Re: [PATCH 19/49] RDMA/hfi: replace cpumask_weight with
 cpumask_empty where appropriate
Message-ID: <20220211191027.GA653986@nvidia.com>
References: <20220210224933.379149-1-yury.norov@gmail.com>
 <20220210224933.379149-20-yury.norov@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220210224933.379149-20-yury.norov@gmail.com>
X-ClientProxiedBy: BL1PR13CA0028.namprd13.prod.outlook.com
 (2603:10b6:208:256::33) To MN2PR12MB4192.namprd12.prod.outlook.com
 (2603:10b6:208:1d5::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d9ac0650-fe40-4ced-91ab-08d9ed922ad4
X-MS-TrafficTypeDiagnostic: CY4PR12MB1320:EE_
X-Microsoft-Antispam-PRVS: <CY4PR12MB1320082D107E5D5F81F155BCC2309@CY4PR12MB1320.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?7L9WwHHOzR1ldXH6Y7eCQ0CwAC+lOr3FrifUTcLKuwPkhqTCLoAUmm8fHIoj?=
 =?us-ascii?Q?uNLvEbMwpls4pOdZb1Cteo4bKFIrLx6wEijFDZzlmpNlPvewmZw9doUhuFo5?=
 =?us-ascii?Q?rqJVuZTMqusyPd1oEOJWX2vrNzvdyg1LX7fl3iqo3YYuEvVaQw2RsVUi49PO?=
 =?us-ascii?Q?65jNgPVB7VqUZBnO3k+HLaS6r5xdPtz7bw+50wJJ+dJ9xSTUmluxTVmes3qh?=
 =?us-ascii?Q?A9p8sjWmK+FAeyULr0Soq8QQlh6BQIgN+1WX3qqCUbsLsIUR9aZ0Td7vn+50?=
 =?us-ascii?Q?pYtizjH/3RyZpBLuPjT2nsJR34RWz18EdK34UCxuYtwpPU1DxnCRu+JmmEmx?=
 =?us-ascii?Q?2ejkHn0Tta85wx5fy1WuAzmxU+rjyaFyFTCEs3b98revSU+VFefjvsyskpGd?=
 =?us-ascii?Q?RIYp5dxs2aqmhWDGPtPKFZytgjCyO6RgJ9HsYD7rnVtWtNgcrnd62JpGvcs0?=
 =?us-ascii?Q?k7AWSGeoIC4syOkmSDUJ+cvlhl3XOcSiExBSz/61ExB3veluOv109t77wzRB?=
 =?us-ascii?Q?HB+BXKEazt9TkkakqEPqovSTTtwjcldTmUqo8aNE9uvCFP12fj4lRz029qqN?=
 =?us-ascii?Q?XsAKqxeVLEWi6bucqCnu8cdns0tIhVC9sw/hjDN0ov4rGnrXsU96U1vykTLU?=
 =?us-ascii?Q?2JVUVRzlxUHNRsCKunkXZMd9pKPR4rIqY3MWl0BqNrnB9okL8j5hR3u2ltVE?=
 =?us-ascii?Q?MgcA+DiM/7GhmgUkZTxxlTUU0kIG/w9vOpx8ImSYtds69S7awTIgBsA7KLgK?=
 =?us-ascii?Q?quZYGrQpHCEK+8EGfN82FVSDXpXIBDrdVPCgMKwCEOCfdV+621camFU304Vy?=
 =?us-ascii?Q?Ta8C179h14DPuQhUZ8yHKzsXKoY8zsVHA4I6UhN+PEsjZw96dAah+bloyEaG?=
 =?us-ascii?Q?jMsTRlz0fJmQk9dVtArHnx7uGhW/Y0cJKml7v5U89XmjVO3jz31m185Pd/VX?=
 =?us-ascii?Q?bVcBah1kg0qwMvH5kXmdE30JVrrTKa8+cYtstPmGJhUoanla+W9AqPj8HsTI?=
 =?us-ascii?Q?wX7Ms1PYQ4aevLzFK7UhT3EUtGfnWRTTm48LfhejfDhl4vU=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:5;SRV:;IPV:NLI;SFV:SPM;H:MN2PR12MB4192.namprd12.prod.outlook.com;PTR:;CAT:OSPM;SFS:(13230001)(4636009)(366004)(186003)(1076003)(26005)(107886003)(2616005)(86362001)(508600001)(6486002)(6512007)(2906002)(36756003)(83380400001)(8936002)(7416002)(8676002)(4326008)(4744005)(33656002)(5660300002)(6506007)(54906003)(66556008)(66476007)(66946007)(316002)(6916009)(38100700002)(27376004)(16393002);DIR:OUT;SFP:1501;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Mqun1SNBF11XtOu2+mj91leW8yLuEItiBhGbE93TQBVUeXEahIN1qtjVe7z6?=
 =?us-ascii?Q?WWcZkEzJiKySBd2eu3hgJQfGYrMRIPo8cFocaA3sLoDjc44fT18AFqn1yjqj?=
 =?us-ascii?Q?O5Z6TUALhcjqAOP7W3C17XqLF9ggz2mKLTY8obEZjx7MOS4jbRaBN/JZUiZZ?=
 =?us-ascii?Q?tYfWyIXDtMnJmnb/KAtWorp3ZhQOibu+11RWCc6CwUYfJ6qqLlSP9E9rtQ+l?=
 =?us-ascii?Q?h6DAWkSWvtVaxuW0Kz2AwB1MXeizm2zDWUJ31Vm+HojOm1isIVUIZfL5FT2j?=
 =?us-ascii?Q?DCofWsbv+l6W4hHsC3Q1Qp4BcYp0PCwZAV7oWGl8n19MHn8WHD+QVxZqP814?=
 =?us-ascii?Q?EdshKupuhIJMWaGCFuPp6e0qfnDZExeGaTNsGn++DjTiZL9GgR6SiYi/ZyO5?=
 =?us-ascii?Q?9onosGPLBI2ugXGoSXGgc70RG/4iMcb9/ftB4t6YV+dQZEltgxPeTWY9ja1q?=
 =?us-ascii?Q?cC3O3v97imbRcMPj8kyGbQYETeSiVkOhbMbceTWeg1w09F7q+j+5mJYCL3/v?=
 =?us-ascii?Q?B2IC0MlMVjpdtqVIEmvD6weVaPvy6pCMURo3gWpCyOSAJmRAMbgaIsdanbSP?=
 =?us-ascii?Q?6DU96jcIdzmx4C/iQJG3xUl4aAmlhgxySOaTq1mJjPxPzTyOm1KLkHvdpPdJ?=
 =?us-ascii?Q?p3Q44/Cul1dpxmTmnDI2K923Y3KTdqPfRpl0kNUuLLlkgWHx0ZQGAGVq81cm?=
 =?us-ascii?Q?ncMgH2XbsGEDB0QgHFKXUs1oLmlIB0VlPNWWgGR6PR+O2Fi+qRDUig4Z+Vft?=
 =?us-ascii?Q?Sy+5lrhD7yjjYkDB2GxxRw1FdyfQ0N7KacCBK+HOdzGunYGB8zQtE3lUQU/a?=
 =?us-ascii?Q?Db+gfQIAIs7aIxTf+iF6vvEF4hh53sBJ76piFtoCJ9siQpudZKIFTPVJfXaY?=
 =?us-ascii?Q?9/chhOGOZUSDDdpKsnwia0GSCJiM09igx1Aq7oQXZQZ9mI2X93QHSAKQ2XNX?=
 =?us-ascii?Q?BN+r6g8di47kev/RB0cxOj6r81j62qpWxsaXimC5P0jj5NRS7Wpx2WtfKCsU?=
 =?us-ascii?Q?VzEqjwpmimdriQwg2Z6sAMokxAp1rwpa04ZZK2SJMILv5w6WvoSKF6jXdDp9?=
 =?us-ascii?Q?8AKtacPLmnoG06WiXCYNDXHDoM7W/DeM84SJPCq/Sb+OuRbL3Jw1jq/nTWkU?=
 =?us-ascii?Q?6FwvHOu9JdBMcwRdV3F4S4Zn3xajZYid04akDDOM1QSO7J8e5+LDf3h1KSrq?=
 =?us-ascii?Q?ysyc8JdSP3tjKYL0AXF99wEpq7NyO+YFkO/cqXh77o5SEJLdu/ILAy8ZFU4M?=
 =?us-ascii?Q?CRvJ9hx7I4VvuE38RWV15gg8b6VjM1V5MDcnZYgYaEiiDiNxq234ISYN9zUp?=
 =?us-ascii?Q?24LR8BuXcishCQJJc+5PkDMMcm/dcKRvvt9meIXarue/OtylUPeGLtNRxugE?=
 =?us-ascii?Q?8dBaFxAt2QzIh8vqLEbzdmBOcr7/tyiXpYf0VeBr4US14VBHR8+seJM2gCn4?=
 =?us-ascii?Q?+c+rikDoyNz2CMl0qzRXN8gJcpqMap5ptuYJSUPRRLFlzBdDEVhuagHxASjT?=
 =?us-ascii?Q?qv7+cf3qkUry3h6Qz6ltP1GLsNAzJt9j62s2RxsVIcv1g5TO1MPjhjC2gsj4?=
 =?us-ascii?Q?JKXS+hWVs7Rxxnb2Dgw=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d9ac0650-fe40-4ced-91ab-08d9ed922ad4
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2022 19:10:29.3605
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6Ukk7AabhFipn6yDJy7vBoSPclbCTETqsOhcoaJgFyi0OUSdCzmI8pL0773JqA1a
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1320
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Feb 10, 2022 at 02:49:03PM -0800, Yury Norov wrote:
> drivers/infiniband/hw/hfi1/affinity.c code calls cpumask_weight() to check
> if any bit of a given cpumask is set. We can do it more efficiently with
> cpumask_empty() because cpumask_empty() stops traversing the cpumask as
> soon as it finds first set bit, while cpumask_weight() counts all bits
> unconditionally.
> 
> Signed-off-by: Yury Norov <yury.norov@gmail.com>
> Reviewed-by: Leon Romanovsky <leonro@nvidia.com>
> ---
>  drivers/infiniband/hw/hfi1/affinity.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Applied to the rdma tree

Thanks,
Jason
