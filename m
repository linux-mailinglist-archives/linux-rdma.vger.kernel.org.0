Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D78E366009
	for <lists+linux-rdma@lfdr.de>; Tue, 20 Apr 2021 21:09:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233690AbhDTTKQ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 20 Apr 2021 15:10:16 -0400
Received: from mail-dm6nam11on2047.outbound.protection.outlook.com ([40.107.223.47]:3935
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233541AbhDTTKN (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 20 Apr 2021 15:10:13 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JaP0w2Ri7b2EfEktrgpZbdS8GHy6u52Yr88i9KWKjso6cUDYcBTqGUYurW/6vumEl6xsrdiyAnKGWPEXi4QtqFu42yStt2UeKkd/DAAjihmv36Pu0tnZVomGRd0apFN7sdqXRl8UqSt5lAhnAfVRoZodQrUqacraobJ8Qj435vGzqB3poniLCGmCuYfcwKq8uzKu9CHR/S53oS0svSnNC/RWkTA4Pr2WJtNWVgFKRegNnPirLhcxh9bXYCBpYVpQpTk9t/b7pc8+8PXlzscVV6OuDb+Exp2SEqq1Q4UAPeVTxsIXg3XV9SjoPjWXY4ztUDcqTM7zb6aBPWAWY29MVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zViJqjR+37DZttIS+RRux2vE+8SuCqHlLncsnGvnuJw=;
 b=K805ebPzJJGDcqWMOXURP7r2Eif78LDmS0BAgjvtAnGT5gEIRbS/t44/QolUKqG5+svFxphDqVdH6X1RfWhvggNdKNwhtMP/cfCUK2TB5ycgBjJpr21EOA8PWNEhTKl4cKcggzYUQleFQ9SnlliHrYILGnASc6yluFkyL3SND6LNQhSoX/DsC4pmdF32j9OQz2+KjmRJTFEB3x71+yR2B+PdY1ShiMSH9h+NtS0Tw1zPaqBqQCd6+aKXtrYMbNin7kdJLyoKl5ndm6Yp6qB9SmpyCGCbFQ/b6nQBcm1TGDBZ43kaxoywHbzLuRkt4syoPvu0PwWZtsnR4lNyZN+VJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zViJqjR+37DZttIS+RRux2vE+8SuCqHlLncsnGvnuJw=;
 b=muhvy7Lb9bxBm0frlCgziqAWXvbMMs5yeodH0+aWSzyitYQUdZtuO3FrvkTIR89NOki/PBos8SXat2O6935R/1YenytNmdy70mVH97AZAOfnjNI+YOmZLDlJR6qhGKIuQptW4yWKhKPwYY35DSIgl4aZNmMi37MRKKOt8AjOW2f6HBPg1hnCHAfiCTBsCmDfqiK6TxWapNYUirkRe4EUhiYSDY96p1YJtCX77L9baorOnFf9zE1oumaSD07pW4bC+G5cjYAIj1aO49DBTVAJ4SDSuElgUzqS9nCA86+kp0xfpcxeUmrd1BAVJhnseAJ1ChDj0ClPM6zynOSPNbGcUA==
Authentication-Results: vivo.com; dkim=none (message not signed)
 header.d=none;vivo.com; dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM5PR12MB1657.namprd12.prod.outlook.com (2603:10b6:4:d::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4042.16; Tue, 20 Apr 2021 19:09:39 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1c62:7fa3:617b:ab87]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1c62:7fa3:617b:ab87%6]) with mapi id 15.20.4042.024; Tue, 20 Apr 2021
 19:09:39 +0000
Date:   Tue, 20 Apr 2021 16:09:35 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Wan Jiabing <wanjiabing@vivo.com>
Cc:     Doug Ledford <dledford@redhat.com>,
        Kamal Heib <kamalheib1@gmail.com>,
        Alaa Hleihel <alaa@mellanox.com>,
        Valentine Fatiev <valentinef@mellanox.com>,
        Christoph Lameter <cl@linux.com>, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org, kael_w@yeah.net
Subject: Re: [PATCH] infiniband: ulp: Remove unnecessary struct declaration
Message-ID: <20210420190935.GA2185150@nvidia.com>
References: <20210415092124.27684-1-wanjiabing@vivo.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210415092124.27684-1-wanjiabing@vivo.com>
X-Originating-IP: [142.162.115.133]
X-ClientProxiedBy: BL1PR13CA0009.namprd13.prod.outlook.com
 (2603:10b6:208:256::14) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (142.162.115.133) by BL1PR13CA0009.namprd13.prod.outlook.com (2603:10b6:208:256::14) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.6 via Frontend Transport; Tue, 20 Apr 2021 19:09:37 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1lYvkd-009AT3-J0; Tue, 20 Apr 2021 16:09:35 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ca8564e9-4c6b-4abd-c576-08d9042fd759
X-MS-TrafficTypeDiagnostic: DM5PR12MB1657:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB1657005F888798F491A51B2FC2489@DM5PR12MB1657.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qbtq9aV1wU0ueX6GZInLGNhJYFlajed6KhnkECmfltzCHppNz3+g+bJ25BzlR7ku00IB644rvH4L8tEhCFGmDnRU3DaVe4kBwI4WaImj7Lp1GWwIqWxRT5Bsw5EOUCy5ymzCjLvl2MuesjIpXg4Sm1tMcmFVTeeLxyuJqL5KdpbAZa/LxzlF9FBs/Y5TM6CdUIuiHA8A74pRoF9/GIN/N8EgdN/P+4P0SZ1BGYC1bDKNRVuBRTJCZL2ZaiuARSoQu5DD43hqXX7HCyO2oDkum/GHa6hbpR0X1JuEWiVeipebpQzoPanFsdTP6lkLYJuqK58fw3OBhc4h2TO3a6Ekds9VDLR79t8ZJ1/c5CH9XfrZBsdUh7V3l9phX+IdCKaWa7jpN22H7brjkNe3wm2p4uMfBe6LHK7FV9ZarH7lGGrbnymphbBGBgb8PP3SPnfzUlwo1MljijE33v3phVziUCjKUX+BPRKhjLA8Id4diAYLP5TVkgI3mrOCLoVkksSfldRqCxDtZJsCr+TyqQcHeVkQg/j9a4nOOJWp0dh0QPvdOjdz41GJkT7qDiunNxamcAfOJIe1iUxFk/LF3WbYD7Wltr9jp2AvuigJ+u4uvZo=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(346002)(396003)(376002)(136003)(39860400002)(66476007)(426003)(186003)(4326008)(9746002)(33656002)(83380400001)(5660300002)(66556008)(66946007)(316002)(38100700002)(26005)(9786002)(8936002)(86362001)(6916009)(1076003)(54906003)(4744005)(2906002)(36756003)(8676002)(2616005)(478600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?oEbPWaHUcv7+l8bJ8fQ4MayEB0/SDXASRcKfeieIAGsTTPkJVsp7mCC5YXDw?=
 =?us-ascii?Q?Tmn3t9zbL2rDziBcA3OK5Nj14jgbl0uE39qUc73l6tN4tuundR6jLYtHE6IO?=
 =?us-ascii?Q?v2ZuTklRUBvMs4OsCqWifAQ/1bqr3wH7LOmP0AleU3ve8d8T8VXQecgysv5g?=
 =?us-ascii?Q?BBtTdkMVqug+jBPaqMNWvyhWnoFA3jwxiFzJ0wWlk9wMdlyW4/CAi3+Sd74x?=
 =?us-ascii?Q?6a26iNaEWKZtQHPzZgGMKsXgVwR237HskEwmJfq722lNEwEwbxcE3bzFfOoO?=
 =?us-ascii?Q?9CI6WQlNrfk9aftuWFGaljxYvlSMaBWSMHFkDlrRSCcEjqVIRystCb0VAFe2?=
 =?us-ascii?Q?Ui4QLyst/6JUdZZTICfG4VfhCvv0L9LjHWr/MYemXsvaJzS7bshFAQKfUZY/?=
 =?us-ascii?Q?JtiBq+a1fameHTYcLWzQxNy/qSZkOt5HEtabYwyKVNjvTqGRSze3zS5eaB+E?=
 =?us-ascii?Q?lL8iIKrRJsAUvY5p+w9JEzTiU49M6GwOO5h8ikjflUm9amZi8LK1yfNg06fR?=
 =?us-ascii?Q?Hix+i8035wf7TFvk5qaKM3L6GeZ86xBuD0WflU7oP4NssqLfym6iPJt+mRT0?=
 =?us-ascii?Q?1Yv3izVpH1XGz/omwAITVzHVpLYK96y2uisbmfHjDmcUnki27vQBWFH5oMGX?=
 =?us-ascii?Q?1XehJeo/Pa0ix1gi2kH02LD3Cs9buvKMtGXABZk3IX6qaDT+BL542+8S9pzJ?=
 =?us-ascii?Q?ylkFzOG35Jf6xOFunmmoVmt0NggrZkp0h0xi6y6mIN/n6ixeYpF3fCaqOOdj?=
 =?us-ascii?Q?mA+G3BUxayM+0vuGMNcCQLkB1aaQuz5fed0LsQgQwQfAlzDLXh2xQPyF7e9k?=
 =?us-ascii?Q?YNFZqXeL/oi+dmJ21FuKVGmK9EcIB6NcVzR+0rusW+nwe++125pbUEg7fWbd?=
 =?us-ascii?Q?oBPL/V96dmYgjsRm9GY/OXDq6WeSbK/n/ism7MQOdi/OJ8mABdLUmfm9QVHs?=
 =?us-ascii?Q?mDwot/A+eKkAMy44S6BPlSDGAyPZLLyRsx/SXNHG5dIzabFIl5844Y82TPrU?=
 =?us-ascii?Q?fWNA1iUUruJnaznbUbth79W1BMUE1aXU/C+DoikH5ZM64EfsCqix9O3NZFD1?=
 =?us-ascii?Q?AUJgaaazTDkLIQvqETKCQnxOZmI8+6NPE9g5ZsgiX8SzKFifXxXtQr5lArc3?=
 =?us-ascii?Q?FV1yHW8MHFFIAvQrIoH+z4JjHi6MuvCdzGLKyl87us7ESw8jA+JDDYFrSShs?=
 =?us-ascii?Q?RxnZsKqHzXH0b+CN4NeUk9c+oE2YTAvdXAsixjeXkBrERa59RgMnvv0sOsor?=
 =?us-ascii?Q?0jHhdAMcyBeSFDc/9F15zRk88TUppzOqtdwt2F72iS/kUKVgMGI2PJ7pfsQ6?=
 =?us-ascii?Q?64iqc+alNSriz/FST7Knc3i1?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ca8564e9-4c6b-4abd-c576-08d9042fd759
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Apr 2021 19:09:39.1473
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nVapvNmW/byc4BK2mv0rKLcszWYyJcX4NF/NtyZiXFTvEtSNSVU0zr4Iqf2yUqJ8
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1657
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Apr 15, 2021 at 05:21:16PM +0800, Wan Jiabing wrote:
> struct ipoib_cm_tx is defined at 245th line.
> And the definition is independent on the MACRO.
> The declaration here is unnecessary. Remove it.
> 
> Signed-off-by: Wan Jiabing <wanjiabing@vivo.com>
> Reviewed-by: Christoph Lameter <cl@linux.com>
> ---
>  drivers/infiniband/ulp/ipoib/ipoib.h | 2 --
>  1 file changed, 2 deletions(-)

Applied to for-next, thanks

Jason
