Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D13457E359
	for <lists+linux-rdma@lfdr.de>; Fri, 22 Jul 2022 17:04:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235386AbiGVPEN (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 22 Jul 2022 11:04:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229519AbiGVPEL (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 22 Jul 2022 11:04:11 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2057.outbound.protection.outlook.com [40.107.92.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3302774379;
        Fri, 22 Jul 2022 08:04:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fWkhkQMCi/f5DZ+aaUx7xUSp0BCKNd1DUr9ZkM7OoUCr1KPYdLNOxWiRbTpOVvaH3bqK2AbVu5lToAh4GN0rksIJ5aVSHnOeVP2d6+43JQMVUE9GJTFjGP0qYn+pSI17yzUoXINEPUrruopBgqstZEEZNvOEj7dppDY1LkCyIuK0sA5I6/jtuUbxcCNXpUrAtpVal7F+aHCy2z+IY+qV6XRtd5ukQlNf0VqSDQp9omlWpctkEzFp4v0MFiLXyOUsb+viLw0qUNWX9svNRr0LBbu/jARCoU76yNKo10OSFnr092a+1EU9L8WLApiMTvMaFHe0xzXLI09D1fy33e2RWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qshI+pXBlly1tkst56K1ZUWCLpN52YpRBi+J+EQE8QI=;
 b=W9hnXSaAPV3K4LSeZsXLkZZExrt/LHOifNpLv/d0EBdjz2LBm6Rbb1/OE+nWtrL/mx0l54svnpF3TxwzQehZ9yoNrDdCSx5SZPVyJL2byfDi4OTuSaxzr5PjO+Di8d9dgm21Q/OPlb0K/h/n8SWVJf85RHrJc9rGrMy4AJd6EpCyIZAMiXw3Yw1TkpwUc8vOsN578G6dH/+4QiAFSHSGzXuRUSh0v7h/DfbLFJeZUAZsfJYKrqAz+413W5+NoAK7527EQjW6HsYsAKqEBy+/lrv9DGYuuC/x9Xc/uuGmTk/eGEADKb/mV/IBt4MCCI7XpmsJSlGgvz+DLT+guuHKCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qshI+pXBlly1tkst56K1ZUWCLpN52YpRBi+J+EQE8QI=;
 b=SlSZyIxYuV53UQbdpPCGqvyUq14f4xrvNRcCJQ3GpTcjv2RPWAbMhW1vzyoiRzebCdtDhAKgLjSP5ZhaNJy9UCKOslnglXX+dxItw9DdbAqJJ5iIB72kXyL/wlgbVMqxQUqbtVXCdyI41F2uiJtD4UKYMdhcyn99TDp0DXV+nrV0t7VsVqLCAYWF0L4e9FS60cJdV+nVy7BmFwLB+Iwq0U8nnAw6WuCn+8KT27hvXWU7vHG9uqCLRNdHP8R1nKYZ0zU/WK8jQrj4ATHFQByRHqxOKmqhkpxf03/GteRrj9NFfKFu6ZirwfDwCIOseTSCZKY+ousdQhneSiWk//xOoQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
 by BY5PR12MB4180.namprd12.prod.outlook.com (2603:10b6:a03:213::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.18; Fri, 22 Jul
 2022 15:04:08 +0000
Received: from MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::ac35:7c4b:3282:abfb]) by MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::ac35:7c4b:3282:abfb%3]) with mapi id 15.20.5458.018; Fri, 22 Jul 2022
 15:04:07 +0000
Date:   Fri, 22 Jul 2022 12:04:05 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Slark Xiao <slark_xiao@163.com>
Cc:     leon@kernel.org, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] IB/core: Fix typo 'the the' in comment
Message-ID: <20220722150405.GA33010@nvidia.com>
References: <20220721085232.50291-1-slark_xiao@163.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220721085232.50291-1-slark_xiao@163.com>
X-ClientProxiedBy: MW4PR03CA0280.namprd03.prod.outlook.com
 (2603:10b6:303:b5::15) To MN2PR12MB4192.namprd12.prod.outlook.com
 (2603:10b6:208:1d5::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a5a21a2c-e336-41e7-d6ed-08da6bf36cdf
X-MS-TrafficTypeDiagnostic: BY5PR12MB4180:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1LnaW/hdoAuwrDAfQ3Zlex2bDhMqoiLf502ehcPwR9TC/oT7ezMaNs3lLR0GSisoXn5ND39BRVH+ZWlxiNzdv9uvkLG+4gkcW1ERmoW1TwElKp5BC+H0TX7TjblWmQ28dNN0LCiFSiyUER/HcY6yg6KPx72G5q3Uigo/gvk/0Zb914o4+qfNoCMeZmznQPAAKKtsTFW3JwyGLdDfWMrBwMjDi4mmnNhunnKuiXpHtFeig8rYLFbGUZnPDtx60IyslGwrFa1MRQ1ANkj5UTDHrbeU7vc28hUTFDHnZCRwscd9I+timpagBBy4Nm07TmtGFQjxxbE6RtrniclZLN6v/Pw3KBX4RTMCM5rWHZ1Ms1pe3ZrJtX4hIyireje9aOTeFg1ytTuJGbVY6c4gxXRsFEfkCgEdDjn1LA46+SsTKyXRCPNj5sEOgcVs+ltPmMxu5hPcBCEQW40T61MA/8WCb552plc/6O5Avm2WlRqfoC3ZVH6qEzIuL4yxaXmEmzZZUXAwW4fW/SV46TzON2Tm16w0075754FZ9okcrstr5R58Sgxc4AOQojWodE67q3A/04T9deVdOjZVSQERyc8CxzCRiDYWGt+oaFiumuav1NT/TrHyAEzhJwaRHxVA1SJAgeK1dD+ssw7YhhHLs4QCaSBmordYMhbfakF75KA0r7GEj41qL0SD3yd19XKPV3bMzFEWfF28srF5NJOFw/BuFlWippaPe5RwPA5MOHJkKsg=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4192.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(136003)(376002)(346002)(396003)(366004)(39860400002)(316002)(66946007)(6916009)(66556008)(6512007)(26005)(8676002)(83380400001)(36756003)(2906002)(4326008)(86362001)(186003)(66476007)(6486002)(33656002)(38100700002)(41300700001)(8936002)(6506007)(5660300002)(1076003)(478600001)(4744005)(2616005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?aqMzPr8WfbHAf1PLGPu4jKS2S4H0LO5WBV1DyF4k+cL/XFXPoUOno4AS7d+p?=
 =?us-ascii?Q?awflQgDvgBlVW84glMk6StmafTT49Y/WmUEW9/wbCTDNtetMXtkUoWXtQAqE?=
 =?us-ascii?Q?j+dpmY0TK2UEiMCVJomty4cwEEEy/Mbcf+LAmJZjSMi35bQhEfEMQom2PZjk?=
 =?us-ascii?Q?qdRLgON4+xkog+jX9ucllkluU8G7JEg0eG+a51OWpyaUncGGc0MRUFH/mhPG?=
 =?us-ascii?Q?r/LzbuWQ2E8J6y0j6evBKeYg4/SzbrltuKHxw8wOI4Hc6kUXXcJW526Av0ua?=
 =?us-ascii?Q?geaILhg6/8Aq/UE065DFXSBN+LQ/QrPI5wnQ2flbV2H06E6P6O82Nod5GZY8?=
 =?us-ascii?Q?hfFnRpOx1I5qepAGJJs9jql7/QLOGZOfvNS5nCUPTle1tt4J4glQAPhHJ3Xj?=
 =?us-ascii?Q?1ovrfc/7sfGBKXsIPDqaPCQ9yVVqRxHT9W46LgyqnzMLZbLmuJ1icv42O/Ph?=
 =?us-ascii?Q?ASsRKbTDhDpsxHRId+E4iOeOyEUZm8cZEWBQYTtw5E/FPPrDPHI84QuMvkaX?=
 =?us-ascii?Q?qGUDLM+Tcj9LRu5PCLfJK5PCpYHlNxyDXvjqb6jxjJswIfHgTq4EPGw1dR5h?=
 =?us-ascii?Q?TqS50dCDKbkt6VPuwQaGVCDKpN1i5AW5j+OMnGCrekHfmPTq7lKxV9eFGJvM?=
 =?us-ascii?Q?oeqRzqLclM1b9La5YkTfyzBzFdJhxWtEJIDoqFjLksUI5Ak8IVhv85H4+XEg?=
 =?us-ascii?Q?s/P09v9PyXppHOe9iAe2MQcpghZyOibhaYVOn526ymjDu4h00f02g3Fs3RPm?=
 =?us-ascii?Q?p0xMIrKw7ZyIiExj7hPu5GE4YGUQ8lzNbkoNPXuOqUICTSlz0usYEkps2kM7?=
 =?us-ascii?Q?l1oHkEQ6mi+qTuaEJfd9UZtmTg8l+4QRnacIow0lBFYunxh4Gnc9XIDW08b7?=
 =?us-ascii?Q?MyQjOtdXwIhne8EPtUryCol6GGK3EGGtgnMtXcytMO6LeGGaKuHBTMdcIqs7?=
 =?us-ascii?Q?L3LFrwhOnkDZkNhPT1Q3Pna8wfJVkRU1aUvwK0LuMNnfASlMNaTvUv4yISDQ?=
 =?us-ascii?Q?xpxDe9W8COP91XG8pYNArGdPHjhJi1k5u68MDSKB3VIs6vAjMA/0hFSxZKV4?=
 =?us-ascii?Q?bZ3K9RvokMmW9yt1Gj7JoBmNBQ4l9bF1yL67NNoMSUN31OjructFgp2rq5K+?=
 =?us-ascii?Q?4lXRFwJz6mF4HVlDFKKmrcKv3N3iXn5+kftcY+2OQpNhSFIdT7GdytSPjxhf?=
 =?us-ascii?Q?a2acpU7jyxVtJVe2a0LiLz0Dnnlt8/90S3xRs+00+YXAql9TXtrihMojoX5f?=
 =?us-ascii?Q?ovD992gJ9dMGyI0PEEnBM/4KqRIAGi3ZqYY92Q9C4C/PZ0NXTlwCp84IfNYz?=
 =?us-ascii?Q?fu+hnwTeCsOBJ+mnDYPtXUHdTMsHz/cTUQUS1XsfcKZRYupwEWLi77dpJQTC?=
 =?us-ascii?Q?8xbKXz8vvQ5R7TbEZnbw8shqBgroNq6A6P+XQkX+5Pyj2PzgKROnjrG8hyBn?=
 =?us-ascii?Q?qHwqv1xKmjta5TpYY8ujJYd62GdwjiPPNQM6j+9dsLz1iowmJSQCv+BaTteq?=
 =?us-ascii?Q?NwZ8xDy74yxHNtLGzlBkug+SGeMyfLVq0Bh5/C1TRAv8L0Vrx73iPBM8rQUK?=
 =?us-ascii?Q?mx4Z7Wv313+7FIiRJoM=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a5a21a2c-e336-41e7-d6ed-08da6bf36cdf
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2022 15:04:07.8242
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: glDX/CsBS1UIQW3CIHpULOBva31cyVzi/jbif9x1uvB1IFCIhFwrUbKrN66078at
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4180
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Jul 21, 2022 at 04:52:32PM +0800, Slark Xiao wrote:
> Replace 'the the' with 'the' in the comment.
> 
> Signed-off-by: Slark Xiao <slark_xiao@163.com>
> ---
>  drivers/infiniband/core/roce_gid_mgmt.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

I squashed these three patches together, thanks

Jason
