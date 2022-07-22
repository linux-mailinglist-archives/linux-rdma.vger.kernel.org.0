Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B69F757E8C2
	for <lists+linux-rdma@lfdr.de>; Fri, 22 Jul 2022 23:14:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229629AbiGVVOv (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 22 Jul 2022 17:14:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229572AbiGVVOu (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 22 Jul 2022 17:14:50 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2078.outbound.protection.outlook.com [40.107.94.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBB42B507A
        for <linux-rdma@vger.kernel.org>; Fri, 22 Jul 2022 14:14:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q5w67Okfv48vT3myu/nJRf/ufAUdGjg7ro8CYjgUOMfDc8tWE6DGoAKPhzwhtIf9FXjmYCAEHXkD/f1/Yqxr64xrZDrup37oN50ZVKUyB7VvsiGIOJDe+Z+b0UF8C/eneTMeynxAIINdZkwOvD4kjvRtpNQLjosbhuZq7sG2Sh3+JcR0cP51y464iYDAWVNpW18T8WaMhJLTJqoiq+BMsONoSV8XBnIGONYQAEpNCMW034noKLt8acAf5DV64L2FC/u/AsIIzKYkrz6bVVc1LTeq4yl1/okH09XxzwnbBHvIG0ZbNUXTSAhmKPSVq/VUwIxIUPEYEejMmQCaiEkK2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mR/LGTkZi0tNmrtzRNQ+T//Y9WDbMpYHqTVUaFk/K00=;
 b=DUw+odRW+2I/nRHhIREaPA3aiVAy6tmOrDBJ0rtok2sr2tIQwLdNH4eKln06C0Gnyk+qZEQLrZS4FvhJdDUl1G5gu48K8+4zjaKGUBeYjjDFBdttucAYH9ByV3Ddkdy4/E1f4PTI6jE5Y3xu7OsO4j7/kIYxMDv5Jws9qk3TUhzidWjcEA+DamMYJ1GQCcJtDBpglB5YRnvqlkIkzCQVXs1ZGGuK5gRLcV2rFif0WXnMZJus4ww5b07b3goOIJdP7EVXx/zbHIWrByqXjsM6ZuF38MQDM7jD4crqLGRZtF3DgrH+sVk1HYT6Sef8KmEdfSfd0ZpfZsSHGhL0b/LoVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mR/LGTkZi0tNmrtzRNQ+T//Y9WDbMpYHqTVUaFk/K00=;
 b=jzqU+64XFRuaXcirwKZ4aedNxTi15Xs64lnecZ3XqHHxcxoUvulsfC5HAEIzXrAAFxJnMQB/5Z2tKgzrfnaTEqlCRQvyToPz8M3jIzf15yo7odG5TWp7nFIbno2LqP+BfAiYxOI5fzWgSTDTMuFPg3UDbtQM6ksBVdLwNwGXzBjHqI2dbJKACRy0XLYNhcnFrZcNQrWTSpT6mveJOCjayrucLQ/IT/eywOc5iXHbChfDvIhfOTyOBxd1WpL0mkjrKO2n6YVK5QhP8gDDqYQ7uxNkkUKYqxIg1ZQzwbLQyu5Tyhv5dlhWNW1FdMlCuX589bsuP3GKQPBQLydqVHoRbA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
 by CH2PR12MB3880.namprd12.prod.outlook.com (2603:10b6:610:2b::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.19; Fri, 22 Jul
 2022 21:14:47 +0000
Received: from MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::ac35:7c4b:3282:abfb]) by MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::ac35:7c4b:3282:abfb%3]) with mapi id 15.20.5458.018; Fri, 22 Jul 2022
 21:14:47 +0000
Date:   Fri, 22 Jul 2022 18:14:44 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Bob Pearson <rpearsonhpe@gmail.com>
Cc:     zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
Subject: Re: [PATCH for-next v2 0/9] RDMA/rxe: Various fixes
Message-ID: <20220722211444.GA75988@nvidia.com>
References: <20220630190425.2251-1-rpearsonhpe@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220630190425.2251-1-rpearsonhpe@gmail.com>
X-ClientProxiedBy: MW4P220CA0015.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:303:115::20) To MN2PR12MB4192.namprd12.prod.outlook.com
 (2603:10b6:208:1d5::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0d325652-e18a-441a-8cc7-08da6c2734c0
X-MS-TrafficTypeDiagnostic: CH2PR12MB3880:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Iwp646fAddZi1raCqxxgtDY6O5XIdGfnrcbHRsAl3OTRRsmfK8BX0xT7CXEMoVpdiw7NWMVe44/yG1sSjcIiLYbQ4j3rFTyUFCAKAHDNZ8xNJhAv1/lUpAmviq/KBLDfH08Zjz53tlpw45c0k9ZzvrmVIgKsdR/YvpYzN1hT/ygzKBauCPGXwxbRz1YyiZ3nFuzYbGFQ/SK1I5Le5UyeDP/lt8n7GXssjIk7ZoO8mnQyqleQMtwvOi/OhDOqBTKBeZ0efFXccEYwRFU3GW5/MrkJI4gwVoBEhwQAp/L8WKOc8AG4avIX6BdFpdcYhad0cwpKf6NRcf020hji5GyUpX+9XHviQ0zDuhX/RJA4WMgBIptxsCD9Eg0rxQ2Eie5D9Yx6Toh4KH+V0o8Sl3sSkqg7g5JGCIKB0fTfr41vUIEz/vYANm78/XnvPrbkEzJOu2JiQrCFk921toQm1UdF7wuvIEz7daKkb73IJGQghogtFpZH9ZilSjKK7AafUNWe54khwXb+kqnICCQHohMhHuGiLSiN77ILd7E5ofgHCzbnRkM7Xgt7z/gMaKLALTWu12/DLZwc5pGzjSInbaLyUkKOPfx+n4Q3zp1VFyFov52j5TQ3KXltMAUt2SYwwUjKHn/gM6kb6/Rz4ullmmsi2OKGWsKBfwEwYOAo1CY+tLh7Y4z+lq1Rmiw7PIQCPkPWFqWrvrdjysr4seSeTkfZbaJVQz26haZGtZusEOXLO2s6MFNRYxWvPTOagD+jA+3K
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4192.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(346002)(376002)(366004)(39860400002)(396003)(136003)(6512007)(26005)(5660300002)(6666004)(4744005)(6506007)(2906002)(36756003)(33656002)(1076003)(186003)(478600001)(2616005)(41300700001)(8936002)(6486002)(38100700002)(83380400001)(86362001)(8676002)(316002)(6916009)(66476007)(4326008)(66556008)(66946007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?pb3MVIuN1ln8ZZqyu9qF1Rw04NEF19eUhKeGS6CoATuASGoSkWn2BH18vhPb?=
 =?us-ascii?Q?n3wgznZdjRVeRK+2B+LqfleFc0pJ4QIib7JTwjbbiB+9PWZq/LF0NmGN7pkc?=
 =?us-ascii?Q?Nv7cjQmgqZ+qdieGXHuzl86ukcds9fPVtwi+mycoCZTyP+GMRDpwA/WtsZTP?=
 =?us-ascii?Q?U7QGJfDW2EXeBLMH8hEgVYsog92PUcyEEQauF4dcbMKljotG+FP0hlmoNN6m?=
 =?us-ascii?Q?a68cXvu3VGe+CX44UnmZ8RRYKRFjCJqsd9ft7Td6ZNwi2kwbIhQ0fhoUr/HE?=
 =?us-ascii?Q?dy5nffpd++F5DKhVJqtm4StFkqVKdKe0IUa1ydy8mpAmiVeuR+tt3gXUlfUa?=
 =?us-ascii?Q?7VkzW3M/b42FKcnb3Eo8zcdQT7itVzjXgcDuRR+dWIu80FqPsgSdp8WFOO1R?=
 =?us-ascii?Q?vAxJmxwgmxF3Au1BuT5gj13BaZS3SP2sg0wwTxOoPMzbYuMyGYJPrg6yPNmw?=
 =?us-ascii?Q?ZgoJpH4xQxiflNcepificc6fB+89379m7It8RPSpbb0G9mKfoMLVZV0u6ixb?=
 =?us-ascii?Q?RflRJlfnsKpEEFoUuFtjci/LjgWMyWZ5FnFMctxcqhyisEM350HR9iE/DiJc?=
 =?us-ascii?Q?W/Fkik+4BOeDvmfGAWwQhZ0taSvpm3ApmWVEyc58cFlJRSPOiyBqZEbtMnI/?=
 =?us-ascii?Q?bolN5SgHQoSGQ/+h6LBzKsGXJwPUYvstxMS9i0kXGsSOn70l81hM+E2430uF?=
 =?us-ascii?Q?kbmUHwROuolvdrBMWa2qD9qM2MmHGVJ2rp4lKNcfTiQ2Q740FFCdXA/CVVyo?=
 =?us-ascii?Q?H7Ub4ZcOFXw/NmQwo1mq7BhSLCvERHafbo0d8OZ1JQz8LNGfT3y3ZJkpp4gt?=
 =?us-ascii?Q?XzHjE8yJ6RLKAFoHFSbbJJDVlGHZomeGqoLNcqks/FXgEr0nRSNxmFy6jZaZ?=
 =?us-ascii?Q?cMD5+oo3vwsuCXK1YuUcsKeN20EXfqkj0FSzIJu8h17bg2Q3IYx2E7dAj6cE?=
 =?us-ascii?Q?iJNqPUzOMqe5x3KsHTO4OfmgSDwORt2ZF00LkPZ08JuNyJ5IYj/Bu7WgMlJk?=
 =?us-ascii?Q?b4M/I1+2JqXh2NAsjr8Cr6GpYTzdmhu/b5Sk2l/DqeYpLIdcB4mLft/2Iniv?=
 =?us-ascii?Q?Nc2Gio/G4ZX5DH+IaHAEfUXTMezTZQwGIahxW+6W0qFtzuCfjlExpJjS3ebE?=
 =?us-ascii?Q?JCqCjG4Up/zZST0yXGJ6UXvwUzSkeXKO0avWD+cmbcPOlvVnYTBUlNOO+3WW?=
 =?us-ascii?Q?PnDWegfQi3neN0KcrnwazPjKe6sSBAS5FNMcIw74brmCt4ujyGJtqoL+gd1j?=
 =?us-ascii?Q?kaqggOT9V7WfH5+iheo+WVNyUco5GMlcfui2YcGz1cA0XzeG5PTGGxts+wMx?=
 =?us-ascii?Q?NIohpG/eL4NkNzipx5896nIPpQq6PDhE2W0anJ1a4RCB42eulZJzZtYd+UpL?=
 =?us-ascii?Q?PZuv1WltuAzmyIFjxMjCO3ij2OpkXB4OTr0pXNiGivW+I+hd89vKQciDpY7b?=
 =?us-ascii?Q?SDZDlSH0kvE/DfOsizdc2GcVimpTFokLPTIHYzn8uvYeu/ex7HK6p2WybsOM?=
 =?us-ascii?Q?/ekR3uDgsMS/7yMsQFulkGUiVFTa15rXODw0+7lGj3UUHoiwiYDyErIsDv6E?=
 =?us-ascii?Q?QHEiG4JhVaLELf1FwWs=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d325652-e18a-441a-8cc7-08da6c2734c0
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2022 21:14:47.1998
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: R2yYuWycCWdap5Uly/yF+x8XHJGg10NiH06dG5cwY/UPlcDtHoKmXGJbcNQutK1O
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB3880
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Jun 30, 2022 at 02:04:17PM -0500, Bob Pearson wrote:
> This patch series is a collection of fixes to the rdma_rxe driver.
> Some are new and some are replacements of eariler patches that are
> rebased and improved.
> 
> These patches apply cleanly to current wip/jgg-for-next.
> 
> Bob Pearson (9):
>   RDMA/rxe: Add rxe_is_fenced() subroutine
>   RDMA/rxe: Convert pr_warn/err to pr_debug in pyverbs
>   RDMA/rxe: Remove unnecessary include statement
>   RDMA/rxe: Replace include statement
>   RDMA/rxe: Fix rnr retry behavior
>   RDMA/rxe: Fix deadlock in rxe_do_local_ops()
>   RDMA/rxe: Make the tasklet exits the same
>   RDMA/rxe: Limit the number of calls to each tasklet
>   RDMA/rxe: Replace __rxe_do_task by rxe_run_task

Applied to for-next, thanks

Jason
