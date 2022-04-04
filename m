Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECF254F1698
	for <lists+linux-rdma@lfdr.de>; Mon,  4 Apr 2022 15:56:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352793AbiDDN6v (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 4 Apr 2022 09:58:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242856AbiDDN6u (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 4 Apr 2022 09:58:50 -0400
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam08on2086.outbound.protection.outlook.com [40.107.101.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 836F23EAAF
        for <linux-rdma@vger.kernel.org>; Mon,  4 Apr 2022 06:56:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KvHqRQ1vyzaqdYNDnRibgXJA5OPXSyAQ2LqjWbYORuzfWKjzxRiLIcrbMmhQhQnUbosKZSiI26oPeq+esnzsGWoOuv3lAurK2GUVyd7Md8y+b44eAhciOp8U0AY1gOH8G3xT9tzDbMI6IfRrZdNqvY6Gy7SZv8s3JsmQCEdf/SK70yuexOWcmQjruTEM+mP1M0i4yQ4U/Gu7ppuQiTH3+L+HvydPrJFMta8GdPC4P9VSYnzK9zeusxWOcmqyo2jI/kc4A7BuFEuL2B09nFcOE5R65FbclpVlpxitUL9fO6VoQ04W37auXP9U3g22BcWvRwE1usFQLehZtHjoJ9omvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6VJuPhUkN6GvNzrwcu36JgLlPFGSo5c6/8sREv307VE=;
 b=HScw+RzvR72SODcjLL2Qn6WMwS9dUOQsqbu9LAHmsO8PeQedKse+qJNKmuxtaltBYHvEt3TnPM95cfwdcx90X9CDwvhMah1EemTJ5ACpQEZVpNhJRUU7IrwlxFf+3IvBH5W3E35P2sNMT7nIdjcrKp6cW/wZpnZ9MB61y1UVWOlSfb7Orw+WblLvc8nMg4xLNgMxIzUcIQP6BJltma0qnMmy++Xap3r8/AChK4sQmbeANfafCR1ipITD2AIFBc65EYs6AA7zht9mAu/EFQPq9KHYvP+1R7d46NIiyQ9vVPy2N9XrC7CBWHx6UE1FL4Zw7PoVqj8h6REujazZlZFuvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6VJuPhUkN6GvNzrwcu36JgLlPFGSo5c6/8sREv307VE=;
 b=L0mVmFYzsw6UBwDMX6zgWkv4e7yy1RwwRzDAV6JkbsTZPUEPZuN7NbHRXaF+qPWe2OWADza+N45/m3TRkD9tdMDsJMjEqBlOgi/ZGEtyPF2iso2wtFV3wXqlD6mUYeo/dUko+2Uqw7H6uA/6piNlcx6ooJl7OGAGCjVmSgdn0r3TCfos8Oo39pbKGq5asTDSAa5SaD9wfRfXHHE1pEOKSC1g7vNsQfzPysxkvRoJFbpTh96lYY37zOwiaIxfVNCIAZwE4ZdzX1V8TuVdMb8n70HTVHw6irD0inwy/BjpUldqnxOB7xlm7KC1pff+c+zwrGrYHt9ehnOlYWVWuRgC2w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
 by MN2PR12MB4424.namprd12.prod.outlook.com (2603:10b6:208:26a::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.31; Mon, 4 Apr
 2022 13:56:53 +0000
Received: from MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::cdfb:f88e:410b:9374]) by MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::cdfb:f88e:410b:9374%5]) with mapi id 15.20.5123.031; Mon, 4 Apr 2022
 13:56:53 +0000
Date:   Mon, 4 Apr 2022 10:56:52 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Zhu Yanjun <yanjun.zhu@intel.com>
Cc:     mustafa.ismail@intel.com, shiraz.saleem@intel.com,
        linux-rdma@vger.kernel.org, yanjun.zhu@linux.dev
Subject: Re: [PATCH 1/1] RDMA/irdma: Remove the redundant variable
Message-ID: <20220404135652.GA2911188@nvidia.com>
References: <20220323230135.291813-1-yanjun.zhu@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220323230135.291813-1-yanjun.zhu@intel.com>
X-ClientProxiedBy: MN2PR04CA0004.namprd04.prod.outlook.com
 (2603:10b6:208:d4::17) To MN2PR12MB4192.namprd12.prod.outlook.com
 (2603:10b6:208:1d5::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a8a7c0ca-17ef-44e9-c794-08da1642f937
X-MS-TrafficTypeDiagnostic: MN2PR12MB4424:EE_
X-Microsoft-Antispam-PRVS: <MN2PR12MB44244FB167F9776276371690C2E59@MN2PR12MB4424.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SgQtUBZ52FWqeAYuB7eqD6DP3zmSvGLs6UeEyQOpkd7pm7HQjP5V3i1HGAeY3B0KpvEJguwK+nayo9YW4XHi7wHEpqmgOcCEbg3m2IMAy4CgyeLKro7yKXNRQmgF7CDz8jWJIHzXaVIBNYadxjxGME7R505gkH7kNACe+Ke5yKJ1PRRPmo3ti91KuwDKLnw99p7gXNZkWyhnbQsCQcIdPSxvi4s4BrFgaLk5wpJUAyUscBY4csQLOj5bO3n02dlCkfwUYERQGTmapmvjG0v27xM6im9vEOrEgHjf030eGhWs8sXl5p3w6bG31FfSTLyJ9M8txsE6JSHfu0JnFaSSnAk97NFtk5fbKBxe0dFedBpLw+AVgdE0B53f4kvwuygVFF7su4hMcOw6eqPv+L1cuMnON2UJX4BbqVDtfyT2nFcXlrPg9iN5qHiDkPyMaJ3b6VMQaC+hZtMUEEUOhkMGC/nfLO9WVUBnTrHCEgHIkbHzTo9nlUJOWJb6XtiMV4BYdvcRGSQrnbg3LGa1li9/loD7RinjeaSSIfWf4Kmma3DJYMlpZGcLXHPHHTJ2CKRCk4zxP/vHuaWpJpkE9CBo5y00+qZIcMzp64pfAirhNCKV4Lz2SuqCGCY0QQ4uq0vMQUYQzQiJYD/4NETo9ZGYIQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4192.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(508600001)(66556008)(6486002)(66476007)(6506007)(4326008)(83380400001)(6916009)(316002)(86362001)(6512007)(66946007)(8676002)(33656002)(8936002)(38100700002)(26005)(186003)(5660300002)(4744005)(2906002)(36756003)(1076003)(2616005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?JllQy+XfJ9O3GxPHes+PZe8afQUCgoxz6LMnrS68zB6QLmQUtFMAHMCPNALZ?=
 =?us-ascii?Q?D7GyCkRbc2OhLNuKpCVompb9faROpN8f7/NBGrMTRpBgIgnVCH5OPwbd8jWF?=
 =?us-ascii?Q?Tl3jTucGjdR4v4z6wXW0pI2DYf5e8icrUED7Krv2F9/GWILNUYvrAOb5FZlH?=
 =?us-ascii?Q?agIR6P2rlD+dUbg+PWkC919e5XHpZIdAYACj08lpzto/CawTJ4dDegbyib1M?=
 =?us-ascii?Q?pi1EUT9VJivom0YNwt2xw+VLQGPaviYvXPRtbBAvBqMyxRvs6W2V/4wF/sgK?=
 =?us-ascii?Q?Dsb1q9Mddn9YzDUx6KZwSmjkQFVQ3jhI9+I491Z6aH3BvV39gHwCnBn9xekY?=
 =?us-ascii?Q?Ap54hnjI7MZZWdkLSuHE4yGi44UUJVmAr3PPXWq3Q4xd/pQg5WvoVKDxnNpz?=
 =?us-ascii?Q?VbYgQJY9D8QLcgATARwOtWUiiM9bJH2Qg7WJ5Rhwk8BSWgYnZRnc+MmQ7poc?=
 =?us-ascii?Q?rap2NbrisIqC2heF2Pnc137b5sKAo2zkdOF8BO4F+OBpbADe4yzMrfEKFb0r?=
 =?us-ascii?Q?xUnUWOF3tJd8zBYwPfLPxAC3Kyqfiwk+m44qf/culSECM526wI3D6fzoY9KA?=
 =?us-ascii?Q?K69WGf+cb3k+OqTek5z1D9x7wDVhr3/kk/uaLgP/GWxeqxIWFwDHKLp6T0mX?=
 =?us-ascii?Q?1hXHmeDLIRbNr+Yb2lqfQsfGqd3xNwpB/AJTFGHnogBFzEqNPUe5RJx2eF+t?=
 =?us-ascii?Q?o0oXsob0EQHlNAltDlaoUNSbua7BgSoM9dXYKTKSy83450NtWm7uErWQZnNW?=
 =?us-ascii?Q?6U80JyTGxRfxPTfofb705ApkiyZzvpSqtVK70GBOPw0pRpT/oz1oLU4fVYWx?=
 =?us-ascii?Q?XyvW9Sbr5mkpPh0H+3Lww36gs2Ze0lEQ77jv3WW8x+qpfXKCHZQMlZ+Towfi?=
 =?us-ascii?Q?875sE4P4XWyQAewK+/L7gSQnph62BMNSAvobzWl7V61m1v0y8lRY9Upwisn4?=
 =?us-ascii?Q?DnWiYzw1jj36VmVtBSXIdglyTf4o2t0OT06044BmLZucOm6i6dQsQARI+zwK?=
 =?us-ascii?Q?N8gT4CHy7GvT+EWFg8ZcIH+DHWeGuciDPkon48nLndbx2mB2BEs2dCHZ/QHy?=
 =?us-ascii?Q?V80Jkg4ZLH/DNt5j/chz9yWds6xZydxTBnYBL9KNjCXk1G6ilA2ltv2wux00?=
 =?us-ascii?Q?YmbPaWThBqvzpTxcK8iidxIdJY+8sPw6bx3hq0qKsFlORMDgt1t2eVGr0urI?=
 =?us-ascii?Q?sK0ZWnF/UzKTqMkrFzxSQhK8L4SPE/q7zQns3G0uXz3z57+35kHxtuJEXlwt?=
 =?us-ascii?Q?sgG2xnFihxerbXUAZsq6+OGhlVJGnw197tqt6ZhrV1NIjg9330vD2vPEMNAg?=
 =?us-ascii?Q?fknjgcmWDNBz9p3ga5IbkCexng04IalD1ShvdxoHvMBaTr4+GcwJUiw1nKa7?=
 =?us-ascii?Q?C576GSZ0HlNSTwom5z5Z8IKjeHGU5tOgdKLw0XMVYlIlq8cPQhCxNeEqPcvA?=
 =?us-ascii?Q?dGI9RTE2fgTclY6yNTtPaZ1T8vaJrgt4fR2jhOSPMJeFHZ84SCkfn+FNIkQY?=
 =?us-ascii?Q?dTRL7h8vPlPZnVSHWq80P9EN5CYtAFQo90lIxmgtsSdcZGtyMlUJ5oMU2P+v?=
 =?us-ascii?Q?kX3n1xHFT44RAJm6Y9DuVq1c766ZR6X1D8a6ITqlGYvintSD/iIxi7+WHT1k?=
 =?us-ascii?Q?blzs2NK6MU5DLAOu54cErBenKDO9PfyejIy4h0gNc0ODNQgaTWzZoGkhXrll?=
 =?us-ascii?Q?dFSINs/NXGfpi/jQicuvpDl9QZr4vSDLkb6veqVZZWzI/+xWneFtrbQDMWrC?=
 =?us-ascii?Q?rQrAFdZnLA=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a8a7c0ca-17ef-44e9-c794-08da1642f937
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Apr 2022 13:56:53.3369
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: O+9UAUOnC+vI8K1Zj52uPY6wWlIQ7n/BbQEAsrqgOLRrHqREzJ1TH9Nh2F9ALgAh
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4424
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Mar 23, 2022 at 07:01:35PM -0400, Zhu Yanjun wrote:
> From: Zhu Yanjun <yanjun.zhu@linux.dev>
> 
> In the function irdma_puda_get_next_send_wqe, the variable wqe
> is not necessary. So remove it.
> 
> Signed-off-by: Zhu Yanjun <yanjun.zhu@linux.dev>
> Reviewed-by: Leon Romanovsky <leonro@nvidia.com>
> ---
>  drivers/infiniband/hw/irdma/puda.c | 7 ++-----
>  1 file changed, 2 insertions(+), 5 deletions(-)

Applied to for-next, thanks

Jason
