Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1509A4538F6
	for <lists+linux-rdma@lfdr.de>; Tue, 16 Nov 2021 18:57:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239206AbhKPR75 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 16 Nov 2021 12:59:57 -0500
Received: from mail-co1nam11on2052.outbound.protection.outlook.com ([40.107.220.52]:23585
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S239188AbhKPR74 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 16 Nov 2021 12:59:56 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=npt+ZyNSqgQm8FlMnx+5ovaNfBLXhHN7emJ1IRmAx0uU3v4XCoApAMGIJdyRRn0XYE5Z9HjtET4+Kw7eu9FOThmAGLcAgiFUYA2eoL/DjBl3IXtJdtOxdftM3JD9aGbkRZ+GtE+sSXZDVnSRZ8s9LYKa14/oYnpDBcclTsrWBWqFFnmT6IrXa2/L8su/79MHajsgVcq11s4aNv565HZer9AFKNhclErOqrXAuG6IdDlG3qFoDeWJ6HhUt64StBi+kyLyF8HHqKM54X6sVbRNO9gEkLUhChWi4/mlkPGznZsE3KHOtbxYFJ3pfVHu1bxMCUlUeQIU3JAlmv++WgJxNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C8xkx3pULVo/wHs6p7z5dzXiuqJhvzYRV7x2BEFrQdE=;
 b=WPwU8Gj4E58uwNl2pIXBJnAgATxMc8IjthG7XakXB9tfsv8A7q6+gCfnvT0vw1fNGQLJM6neI4cxylSkHhdq+Gv0Pirrot8Bkqqk3Afa34cZ1VHKnElS1UTpGK1uMnqVYEZ6BaLpb5VOuefoTtxRhhaBbwtA3IBBXI8czLYeFxqhDenoB6KeY+iFruSGck3QEQo0rNt8sp0f1IyoXw7IvqJ43r2G62/TnUlpi49C4cnjEGVV+MAntU7lSfltkxZTKAeLxprrJeZVcXylCI2kZdFn5+fsOpTXcrQeleZR/qeAdDiIKfI+ZzpZXSs/hJ/q+bG7c+qcFX6X9/dMBqDBUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C8xkx3pULVo/wHs6p7z5dzXiuqJhvzYRV7x2BEFrQdE=;
 b=N35y1dOiu/oGgX6HSBMOvfSsjdUbINHksvF11Eqo2X8YbVX/3WYsqd3NWxiSHgM7MvKDaUYZdu6xjwplycEclrxlqMoBsYpy0sC/VrQ06Gc8OoQU7C22SYuZBgfQv5AcZP3bhkhhdjYhDKpusNBJUfhkm+m2Mg4vVO4Stk8JG2C5EqJ1IoNvko8msYb4aFPXR3ILG75gED/s8sqEcXaX+6yyW9ZMkQGuyT0UL43MVh3tUMgrjOODCaZqSH/apRcssU80ghr3TI7kCdAyDhPMsvLwkbsTXMLX8tO/4L+dXrA2qfAn7YbZyoQ+y5kvxGahHh0jB2uq+1eUFCRVUEzSOQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL1PR12MB5271.namprd12.prod.outlook.com (2603:10b6:208:315::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.19; Tue, 16 Nov
 2021 17:56:58 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::5897:83b2:a704:7909]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::5897:83b2:a704:7909%7]) with mapi id 15.20.4690.027; Tue, 16 Nov 2021
 17:56:58 +0000
Date:   Tue, 16 Nov 2021 13:56:56 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Kamal Heib <kamalheib1@gmail.com>
Cc:     linux-rdma@vger.kernel.org,
        Mustafa Ismail <mustafa.ismail@intel.com>,
        Shiraz Saleem <shiraz.saleem@intel.com>,
        Doug Ledford <dledford@redhat.com>
Subject: Re: [PATCH for-next] RDMA/irdma: Use helper function to set GUIDs
Message-ID: <20211116175656.GA2661511@nvidia.com>
References: <20211107212227.44610-1-kamalheib1@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211107212227.44610-1-kamalheib1@gmail.com>
X-ClientProxiedBy: YTXPR0101CA0039.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:1::16) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
Received: from mlx.ziepe.ca (206.223.160.26) by YTXPR0101CA0039.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:1::16) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.19 via Frontend Transport; Tue, 16 Nov 2021 17:56:58 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1mn2hU-00BAOO-K1; Tue, 16 Nov 2021 13:56:56 -0400
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d13c8aec-4b00-453e-9e62-08d9a92a7c15
X-MS-TrafficTypeDiagnostic: BL1PR12MB5271:
X-Microsoft-Antispam-PRVS: <BL1PR12MB52711B4285A59F6B26BF3C7FC2999@BL1PR12MB5271.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 24oIHCKIM8QeLqPeWKaFKZA6a4eGJ9YHBcZ0UvYoMwZbTLSIhQRccAq1WuzdRqnF3p48JCqaJ/XPAF3ieCjzdBj4MZf8A/IbVtujQkc4RKRWSB14Dvjtm+jNWb87qc8Y0aXZGYueMYWGy0kSfnpYK4uCREDXFGHHc+5TYf+r7amTvgwjrWqoEaalbOedIiZucyaIRlOSORNZzALpPMnRHDolsKeuXtGCe59MhKY3tVhzTQf3Hydk1Ji1iCuc3dSIgxH5udZJIUQE1iMZ4hVioVrQZQyf3yqmUUH+66pwke25+CRC0Z6b9QkBgENrMvL0FQ9ye0EEvJZgFxFOWee0EqzRVOUoHhIPvth9hpavzJZKRPEOHxuXU5IT/wwskB2udP13xFXA+TKqiGvzdhyDhdg3wmaeGYpjaUU34uU+NVwI0u8rNt2tttJeRYP/aaMALVxLhE1y2cEVc92La3psbz7y1RBpOPOOtWD5zD4B+gfRdBfHYqpSH42nSH8y9rHBEg8tVJ5W4FRRfeR8ERgrPg7LXohZfNkQ1K2mBfTlW3vTm9DSlfngx9XIRULc49qFyzgvwpZLiMy3yEZL8Wg3f5N53oCYLdaUS3H0FPp97BiUhFRqgTSHwRIn9AOWyyqNCIdRG/+oQLH8OQ1ylE8Lbw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5506.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(83380400001)(66476007)(426003)(186003)(66946007)(26005)(6916009)(9746002)(66556008)(1076003)(316002)(9786002)(2616005)(86362001)(4326008)(508600001)(8936002)(4744005)(54906003)(2906002)(8676002)(36756003)(5660300002)(33656002)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?VZjN1h7xwg1FU1UNDoeevdwC5+D8N30AZyKqJ8ZCgGxEuMEEGnq1jICk+p+O?=
 =?us-ascii?Q?gnnUseP/Ryp0Pn5yksTawnjF+jxOMbAd/ry4mpIBIWA0woQ3hq5Zqhe4Yprb?=
 =?us-ascii?Q?D3HM4etpmm+F8fck6Z2RWO26IrL8saeCxMERPUDvEgokCHB1quumsBgoWkgs?=
 =?us-ascii?Q?4yvJ0JbLHfDblIn8xIvgSrrR28FmxnZdLDpXXN751f/jgs2qhBoay6mCHiTn?=
 =?us-ascii?Q?IvEr2HCFAg7fxQ+Feq741b/TaigIJmAISV2K5cgxhx9VLK+LKSPJf700m6uq?=
 =?us-ascii?Q?Tyf7Eg6XB5agO8vU99RdtV9zPMPyy1gpihzmcX7HQho/O2J48YOsftUapTPY?=
 =?us-ascii?Q?i+PnniZYGwymuiHihZD3By8y39yVb2P2VGDOpEeLWQwLwSknWI9GDeIZXXDX?=
 =?us-ascii?Q?RXjYYr3H7kkkLl016XNnxAdOHuSa6Im72o2MlwzRwzKs9HNd3ltLJXtSbA10?=
 =?us-ascii?Q?UIsSrxQYmDRGlMgJotfeDcvdX4E7nzYKdv1UevGz+9r4S0KXu4qC1GrBCN26?=
 =?us-ascii?Q?qWnGbl0+GIPGQgEU5nDqAquwrrx/YD2Y+DN3alDcrSoR8oVvKt9HXOfFqtRX?=
 =?us-ascii?Q?TxF8LcWeCNDaPfWOfnHQxgIimDlpyYWw3duX4JqVEhI71VsTHOKgaZAOEJdH?=
 =?us-ascii?Q?h5sHvIrWnTgKWVVwjjAkV0ieNDf4qlZh4xmHKjZ0/6tRijdDPsW097IM73/h?=
 =?us-ascii?Q?ktjDFiOKeNckJyos8ouNVOB8Rf628gQlfljSelhJ5pV1zpymgP2Xu0PffiBs?=
 =?us-ascii?Q?ojb8Klvv05OQYBg3LjyxiZFuAgQEW+yNToAVl0LGZCJPyCdbllH9GL0vxk0R?=
 =?us-ascii?Q?JzdjQsI8YY4jaayf2mkAEvIaXnvj5IcGMmNmBexj/oE6IqU+8PAAORbieZQj?=
 =?us-ascii?Q?Ppvdf1uL6uywgiJlkEeqG8Sw2AZQHo0y5sJtr12L/zfUigHuIqT1EaoyB5MU?=
 =?us-ascii?Q?/rzQ6h6boPE98o/+gUp278iZ81lUg9sb+a5U21A0rwvBdr7R34FmQVANMWK+?=
 =?us-ascii?Q?Q7IcjFnahlziFbutqSO2MI+UFwCKE3xCUbGczraX0AfIy/cI2CjSme4IWXb0?=
 =?us-ascii?Q?yi0of6L6mfPkgqIw5KZjjFdFRxY+FC+BSBmOSUHtlJd02HbAAmhdfW3aHGyh?=
 =?us-ascii?Q?HTjN2hW/BZT0JuxDhToieeBi9/DxiX2nYWS0j+M1T/+Y1gTH+ZQkF7v3zTjQ?=
 =?us-ascii?Q?Eu2JPTT6QNp1lz1D9/GNOSspch5HnaANOk3WgxGWfsju2Frm0YBDFiZCc28u?=
 =?us-ascii?Q?hpDI0+8IydZzvX3iTF81PHH72OBiJub7VFC7kZ6rPVjXozvqC9hWTE4R8lTP?=
 =?us-ascii?Q?pkJ8/Wgy37b9boqmfHzazRtiHDSuoMqn7Q0bcKU/ri/PH4TeHtG+R3KKm8Gs?=
 =?us-ascii?Q?SGWf4VdCSGZiNHYTuf/zJ9cjfOnBQt3r0abdXIu95klxhU/Chz5NNFltYmCC?=
 =?us-ascii?Q?6shg4ADdovCFvR47jERJ88+ZwloNtsZHE6CvbwC/wUNTz9cf0SgzQNc6aEv5?=
 =?us-ascii?Q?bD7UgLJi24dD0HMh7XwhMkFL6AH+8IpemRhlWuHKE59i5kgu8K7gQC9JpHKh?=
 =?us-ascii?Q?Unl7AMafnkHdPYaXwmQ=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d13c8aec-4b00-453e-9e62-08d9a92a7c15
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2021 17:56:58.7159
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kFYDKOG3LPNqKdXrLHyBk5h4fa7mPemvgsL6ePoouz63xJYXC4llyKLRNAMkHxjV
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5271
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sun, Nov 07, 2021 at 11:22:27PM +0200, Kamal Heib wrote:
> Use the addrconf_addr_eui48() helper function to set the GUIDs for both
> RoCE and iWARP modes, Also make sure the GUIDs are valid EUI-64
> identifiers.
> 
> Signed-off-by: Kamal Heib <kamalheib1@gmail.com>
> Reviewed-by: Shiraz Saleem <shiraz.saleem@intel.com>
> ---
>  drivers/infiniband/hw/irdma/verbs.c | 27 ++++++---------------------
>  1 file changed, 6 insertions(+), 21 deletions(-)

Applied to for-next, thanks

Jason
