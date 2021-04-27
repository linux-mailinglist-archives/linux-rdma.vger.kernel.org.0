Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E7B5536CB22
	for <lists+linux-rdma@lfdr.de>; Tue, 27 Apr 2021 20:32:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236651AbhD0Scr (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 27 Apr 2021 14:32:47 -0400
Received: from mail-co1nam11on2052.outbound.protection.outlook.com ([40.107.220.52]:14048
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S236571AbhD0Scq (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 27 Apr 2021 14:32:46 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ke9O4RtbC0QkAdWmZil6TkLS6BgghO0aXtNEMsSkUZQKFXBFXvpynWxw2Xj2AFWSuWIrWv6rMwOVYUthR3kA3rA/ruxu91tzyt7PoabjO+/1DXE+4+OtJ9auyVNFWMc5AqdxNK9iUHZYIYUknVO+6EM7ISWTKyHda6CebjjZO9gGbFgx4pDfViU23C6hDC0N60lSsS/eY7oCZxqmeiaGG/0jXZ+E63FX8xJeA8pyYKLt/PlHPzH1wBD3yqCHT/NXe87eepftH5dAn94K/MrNLV6Tlpj6Mju7suqgfFI3l/eweOhbtdmg8r7GAhhTjQ4q+5KFD9JBYvrt0xQBIfvnMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A52T0pykRP1JHkA7uZrF0DUt5QDSwsogHj6fXHVorf4=;
 b=gN3bAo+Xlws7TK3vBUlVek3hcOVrayVuT9ybHqU8DzBEN1MatPGgb7ioMEgaTDxO8N+VZ1q/TeuJxkvhWBNxzgmtFWpqMH/7hEVqRWpZvstCxgsfgtfjbC5WJxNNTDXW5YPUYDBAN1WPgggzyIzfQ9gV8o4ROXQfaQinm883aRLYy6uL4qrPoV4cU/9BxeXhVWNwB40czMJRLS610S5KLtTwK7aap2gjPk6Gn9QwuOvC/kHWnnYQ/n1rwIwpJ9JYND4hD5rDGtot3uSvilKndxk/t8UlJdzUpfhFAoOR60EDeBlZd+hh7ee5S+hJ8BsJlouArw/tAtu3w97UBvtaGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A52T0pykRP1JHkA7uZrF0DUt5QDSwsogHj6fXHVorf4=;
 b=QmzSg2pU944FWKj1QzcIiCVbWh0JA3T+8UegVSOfQh24rZjqqQ4vXv6TZT/qd8nl8K292aAlE0sOYiT7ybwUW62BiLsd8rEPymz6rEJI3PJkruMiCewNin52yByWcOM6P9zSgklZ5yv3VvKB4NURR1jax0s2Wb5fWcEMj7veX1tPxFV7wYVLrGdORRJz9ieTer79KtfuAQmo5cuMi8IdCEJU+9d4WElBQP9lcXZKqTRlMUYGLODF5D15iybVsXQRMysXtIqGUrnD98dxn7Bz7NIkh9L+bcCueE+iwcai9LLDlUzGtJ57mO0p4M7Yj1nKKanuBbX3aU4h/15lxilJeQ==
Authentication-Results: mail.ustc.edu.cn; dkim=none (message not signed)
 header.d=none;mail.ustc.edu.cn; dmarc=none action=none
 header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM5PR12MB1241.namprd12.prod.outlook.com (2603:10b6:3:72::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.25; Tue, 27 Apr
 2021 18:32:01 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1c62:7fa3:617b:ab87]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1c62:7fa3:617b:ab87%6]) with mapi id 15.20.4065.027; Tue, 27 Apr 2021
 18:32:01 +0000
Date:   Tue, 27 Apr 2021 15:31:59 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Lv Yunlong <lyl2019@mail.ustc.edu.cn>
Cc:     selvin.xavier@broadcom.com, devesh.sharma@broadcom.com,
        somnath.kotur@broadcom.com, sriharsha.basavapatna@broadcom.com,
        nareshkumar.pbs@broadcom.com, dledford@redhat.com,
        linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] RDMA/bnxt_re/qplib_res: Fix a double free in
 bnxt_qplib_alloc_res
Message-ID: <20210427183159.GB3246473@nvidia.com>
References: <20210426140614.6722-1-lyl2019@mail.ustc.edu.cn>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210426140614.6722-1-lyl2019@mail.ustc.edu.cn>
X-Originating-IP: [206.223.160.26]
X-ClientProxiedBy: YTXPR0101CA0025.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00::38) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (206.223.160.26) by YTXPR0101CA0025.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00::38) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.25 via Frontend Transport; Tue, 27 Apr 2021 18:32:01 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1lbSV5-00DcZC-7D; Tue, 27 Apr 2021 15:31:59 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6fe06f92-c00e-40ff-a773-08d909aabf6d
X-MS-TrafficTypeDiagnostic: DM5PR12MB1241:
X-Microsoft-Antispam-PRVS: <DM5PR12MB124130445DDF98FFACAC94B8C2419@DM5PR12MB1241.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3276;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Yq0CUyVwdaqJM4WknXOjfxg2suwaFN3TLdxsKQlKobi5Q2r0tevs9UhkfhXkhvSGRHgUhErSBRoNMa9UkvtH98JD24i4HNKlJ6sX3vpGONo7P4YFuEx9fQk0iIOG6/rtQCBdVj9tUMMbbwP2EnL9kgzlYZsfLWZwORFJntPrQyIoyl3eqN5NAwSC8G4oh7MtC3n+fvNTAt0Gbi94DGMUquUQNetm2LEVNgXbnWG0RQd2TEit3tNF2DilWdPLAwMzfSDXnpXTaKdCUtqctlyfFqCkPCCIPXaCiE8H1jGgpJkFOvGjhmOYB0htbL/XilY0vFvi/L4jfj3awb9P/UuVW6Zhsj+vkvLDX/cvSEIZ7sKi22C48txZccJXy+15RVQ2Xx0EeNJ0YL7W1gLXKhRIueA0YBjfsQAfzmj8f5WXRnouH2iItaVijMtS2cTboArC3EJcHGeZIk4OiELWHrRZqqkrl+pTJtKtCVpsYbxTTN83+FzFUckC5EdYUQkHIJ2slxMZkPiZkKZ8fDqHPQERAcaL9BTzoWD4uHp/wO6bAhb+vbTaiqIQ31tIwJEdsWuNQ2e2DhYpspkFff9/XnuHVOPQ/NpO2QyX9jxagU0FaJ4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(396003)(346002)(39860400002)(366004)(136003)(26005)(6916009)(86362001)(426003)(5660300002)(9786002)(66476007)(2616005)(66556008)(2906002)(186003)(478600001)(8676002)(38100700002)(33656002)(9746002)(36756003)(8936002)(4744005)(66946007)(1076003)(4326008)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?Ots4R6Pyp8se2SVfYJ2dvFdfMRhr/p6N08aliDLI+sh3P2m3wWZnm/848A6a?=
 =?us-ascii?Q?I8j8SuB6JMRfbphNEL/z3++j0zAGzonjID6k38KgX+PBCzcNHUgKGZNf/lIy?=
 =?us-ascii?Q?eOzEzE54N//WnfhTtw1aox6h+5d8uqJ2uFPWhfqmvpef9y3ezLVyGyFuEB6W?=
 =?us-ascii?Q?SweRMX4DBBjdK7UEQucCXrKkiP8d+RyRP3Fz7weRwcL/p21WC/CJOuGST7j4?=
 =?us-ascii?Q?ox6j/K2l921bUNw3Nl2J99HCMs08CxVRUtLAN7bg503XcNl2ZD9vZaUkjPAg?=
 =?us-ascii?Q?GVYTlZ484dgM8TZwlt6No/dhrKOrdRyjvgCoJ2h8njmBHSvSFtt2de7pnboP?=
 =?us-ascii?Q?FK3FwfjPv4CitA/ukAFVYkgcICOq2Jgak/xbXHytVePmaVVlY2Qu7blURkMz?=
 =?us-ascii?Q?WHZ/JcbMaqP4ySgXhLTObKqWvuwZiNOkx0x+PnUFj4rYlORwkMA8ifDR6f95?=
 =?us-ascii?Q?BF5dC075jFwarWbj1+gGuKII7F4599B0PI7A+DwsQyB5qoWHrRF68uGX/fXM?=
 =?us-ascii?Q?bFp5YZcIVICOnSruvVgqLG4dyR++hVcVoJhS7l6eA+MzUvqVGXBA7a95Yo5s?=
 =?us-ascii?Q?4VaRlEiA7s+0JsL9gmAoifZR7c42kpbFxsyKOH+YuJw1MUP/LZanR2zXvzS9?=
 =?us-ascii?Q?JzyaHTYhOfEPY+8qoRmDOoqPSG8uOSrR197JUIG/9Wz1Bd5VV6zos+JYxmqY?=
 =?us-ascii?Q?ASKfzHwd2qteFL842OLh5gEe/ZfPGBdv2o1Jb5PWm5z7XuaFyMG7uL5Y0dG/?=
 =?us-ascii?Q?RE+DBWEWm0d/opzvxRQJZV6njCV6KxbZ2V1DhXI/1l6MKhkdSnvHPNUpp3br?=
 =?us-ascii?Q?PPRWT1HW5j7sUp23JTJwfLnIjkPGRi4XIPXrC4ChPug8je6hbK90ep6y3ZG9?=
 =?us-ascii?Q?Nk41OQNE8ZET+HkM/FRd+8WOxS+g5ljekjgLMEgOHWJw7PKu2InbUwK8U+ff?=
 =?us-ascii?Q?SAwTwbXS5wMbE83j0SADEzsmbYO9VRJSI+zN4Pkq2bddTenMF9hr4ZgV+YOB?=
 =?us-ascii?Q?ihnbzuLzm2lq5sIUpsUaOQokawfaF76N5ysgYowSq5WXRun2AzUchvG7nfRD?=
 =?us-ascii?Q?2NW77YWeF1TawMXIOjVsXAephoViK+zOp+siB7prJ4I5ZSoQ7Cl/X0Elz/vO?=
 =?us-ascii?Q?3hLR7ElMA84tS4hBP4cfG+u11kv0wBnZIEp0kwjXWlkp1mctGcR0NARgRvRC?=
 =?us-ascii?Q?j8/au9DLkYFBsHT5uVh0S5GOwXQLTYEbykHVLO+nuA9SPBfX2cpJynut427X?=
 =?us-ascii?Q?kxl5UcyljpA4iG6fCdFV1jzI8nkBrgIBHcn4QQbQI3ubtvH26mlBSAO7lmX3?=
 =?us-ascii?Q?AfN26heD6b3qkc1ObgvwMiag?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6fe06f92-c00e-40ff-a773-08d909aabf6d
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2021 18:32:01.2329
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: H2Rp0q2/WH5mzIp0cZKMC6CH+TxANp9L5SqVYMEL3H427Q7bGeIA+YNwAhK/dATL
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1241
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Apr 26, 2021 at 07:06:14AM -0700, Lv Yunlong wrote:
> In bnxt_qplib_alloc_res, it calls bnxt_qplib_alloc_dpi_tbl().
> Inside bnxt_qplib_alloc_dpi_tbl, dpit->dbr_bar_reg_iomem is freed via
> pci_iounmap() in unmap_io error branch. After the callee returns err code,
> bnxt_qplib_alloc_res calls bnxt_qplib_free_res()->bnxt_qplib_free_dpi_tbl()
> in fail branch. Then dpit->dbr_bar_reg_iomem is freed in the second time by
> pci_iounmap().
> 
> My patch set dpit->dbr_bar_reg_iomem to NULL after it is freed by pci_iounmap()
> in the first time, to avoid the double free.
> 
> Fixes: 1ac5a40479752 ("RDMA/bnxt_re: Add bnxt_re RoCE driver")
> Signed-off-by: Lv Yunlong <lyl2019@mail.ustc.edu.cn>
> Reviewed-by: Leon Romanovsky <leonro@nvidia.com>
> Acked-By: Devesh Sharma <devesh.sharma@broadcom.com>
> ---
>  drivers/infiniband/hw/bnxt_re/qplib_res.c | 1 +
>  1 file changed, 1 insertion(+)

Applied to for-next, thanks

Jason
