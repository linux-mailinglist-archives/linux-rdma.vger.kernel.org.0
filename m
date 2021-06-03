Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7872239AB64
	for <lists+linux-rdma@lfdr.de>; Thu,  3 Jun 2021 22:01:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230267AbhFCUDB (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 3 Jun 2021 16:03:01 -0400
Received: from mail-mw2nam10on2079.outbound.protection.outlook.com ([40.107.94.79]:5536
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230227AbhFCUC7 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 3 Jun 2021 16:02:59 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MatOROLqcu7ugvJ7m8FKsgnPSn5IeeyQroB25dPosWagVTwiBOvxKVwd5pL+QeVdWXFAvAlJwnwAu5rbLZpE0K9RM9UhE9ya0roM3v/Oz16UlKq82txhI+4HgI8SmhzrR1DaWsjK+61qUsnWit6bmncFkvdT7KIrSzpAz4ptl6aYcLoa19sgu16VSJ6Dqq/AWGWzd9x8FFOEPHsMhNsPnq4NBfb3iYtvubMo7ryoUAlHbAZ+FGFRytEXcpiT30FnKQ+CvHWvjZkqGAM+xvlrcUy7Y46S0Oj2RZTdm4hw7e+JcDainyF08DFm/8KEY2mKtKQC+KCjokcUEJmDcy1SIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mAgw2Jakcm5Xy6RF7vm9k2vww1k8Uq7QOnxp1GPxF9o=;
 b=Lw6aZhBds4qS4WtXYPgGpLIt9k/crhImB2eNwPvZtF/oJP5l+66IR7w/hh/DtK/b74SEdJbaGEfQRy4TR5RgCljIB7tf1YfTVbn64KAWNKVwx3cue05mnBBocNIZyPKrbskNp4SfQKuvpplpZjEph/HBrGhB4DJGvZPX/L1e3rj8xTV7xzaDhS4hYhvulL7OaWTwNvg8jjq2vKqAY/WiLyhSjeyzElyZEM4ov+XLa8dbx+t+7Di5OQBOX5vGVn2jz1QmS/rvZe67Gr+xIwasUQajvOYrqM+vdo5rkoUGfuUKMjPLRBQ/9jJat4u34fsCHCBYahQ6FR+jtB1ZInuI6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mAgw2Jakcm5Xy6RF7vm9k2vww1k8Uq7QOnxp1GPxF9o=;
 b=We7SJ49QgH4iMP120gcPz3hw/oeo85PZtJqP/fx/RDai+odTwYES6meZ9ykQhuQ+BKPxS26rjcvaHMSziCATqbwZ9VS6w+jVw4l57oFaI251n+16Saiv+F3f/5vho/0M/dOInT+MlRW3K/OTFB0ptAevkSOi/5EKwpY1cf0M8l8FEj8Wm0WhT5zg5esmR1DeG7JMQy0NqSAQ69dOOBQukUrl6v2KOuvTWOY4RBMGOeeT244aPeuvxiUgsWhmT67p7KysuPjT9X+afLIJ8TcOYqIhvMQAbmw6s9eVMzR+OLk3m+HY+4BwRcvuxjN+8nfxlgHf2EHkleXGjU6FUkghcQ==
Authentication-Results: broadcom.com; dkim=none (message not signed)
 header.d=none;broadcom.com; dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL1PR12MB5237.namprd12.prod.outlook.com (2603:10b6:208:30b::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.22; Thu, 3 Jun
 2021 20:01:11 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::3d51:a3b9:8611:684e]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::3d51:a3b9:8611:684e%6]) with mapi id 15.20.4195.024; Thu, 3 Jun 2021
 20:01:11 +0000
Date:   Thu, 3 Jun 2021 17:01:10 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Devesh Sharma <devesh.sharma@broadcom.com>
Cc:     linux-rdma@vger.kernel.org
Subject: Re: [PATCH V7 for-next 0/3] Broadcom's driver add global atomics
Message-ID: <20210603200110.GA326708@nvidia.com>
References: <20210603131534.982257-1-devesh.sharma@broadcom.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210603131534.982257-1-devesh.sharma@broadcom.com>
X-Originating-IP: [47.55.113.94]
X-ClientProxiedBy: BLAPR03CA0018.namprd03.prod.outlook.com
 (2603:10b6:208:32b::23) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (47.55.113.94) by BLAPR03CA0018.namprd03.prod.outlook.com (2603:10b6:208:32b::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.15 via Frontend Transport; Thu, 3 Jun 2021 20:01:11 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1lotWg-001N0Y-E0; Thu, 03 Jun 2021 17:01:10 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2b807e13-4289-4f43-d4dc-08d926ca55b5
X-MS-TrafficTypeDiagnostic: BL1PR12MB5237:
X-Microsoft-Antispam-PRVS: <BL1PR12MB5237AF8E127CDA9711A58954C23C9@BL1PR12MB5237.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:327;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: joVUypYTxxeSL+wBtvsVuT57yoxx/RcJd3rTmrNmUh+V8Co1Jcw150L8mw08bZc9LP4gvObZTcusllDEaq9XHiPSPR+GToBbXzLO+klwIB78SYmCdJhqJc5dEy5Nbmq30zEFU9O8O7XW34G47LkHmTACz7TDrfyXFWpJn/ca4aePLYoDvedjCeZroQ7t2OPw7XEW+v1YAQrjcNGfoiiUwd9oNRTl6pduyA+xxEmNeut8Mhb3oY0fOK4JbChxgz8XVGPIDXWORJgOVjxUy84vNUhOG+AxT0ELu9EJ0D51YYYvsLHExp1OqzObHGJ4BuHkBEv/13oia9SIdTyCfZVlyUXZHw0t4qHKBV00FTisTB//I6irWkZi+eaLOpfCP3hz7zfZ36HYKyHgc+HwTJM4GSfNop/e38q0oP4uo1X4+yrxXUzNvmR+FIYCorvvqL2W4a47BdfI5UKxXPZgVUpFrgqaJb6wMKKL71IgL+6kQatiorNMq4WOaJBZnSlJutxhtHMAgkK7FxJ8qtVUi4qz4WsU3rn0QH451Hh33epYY4ZF7U7lXKRPIX9Z4T50WnMZobOe6B6TK/O7eNY8VbEMB/3D6BkvavLXbSB1qHjaeAFgUCfADDxJKGO/KJ/vqMD4C9Y8F+ijP+CgJTky7vrMCCDaVeUBnmnT0trW3wlUWa0ugvAIU2brpIe2fhbspNJBof4kwxyun+FZQeMX40qtkPrJZjPSCDXFUjgj8mPHX6VRA697tar1jFDfKq9b4kY7gMljdgTIjvq+cuKCKSyoNg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5506.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(39860400002)(366004)(396003)(376002)(346002)(5660300002)(1076003)(2906002)(66556008)(33656002)(6916009)(2616005)(4326008)(316002)(426003)(186003)(66946007)(8936002)(66476007)(36756003)(9746002)(9786002)(966005)(83380400001)(8676002)(478600001)(4744005)(86362001)(38100700002)(26005)(27376004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?zGVuXIZf2Kt2I7869TMaWylq09r4575pOard6zj4DkuflMqiwOMtdl9RmLQz?=
 =?us-ascii?Q?k7eI1k6oBeLUJ/yZfNoeXaEWH5k7u+HueaplIzTVKgH/B62jv+oz6DMhyxoO?=
 =?us-ascii?Q?+fS8e8/7MyOjTPbZ69v3O6l02HjXxO8AZq2IhAF8DKaz7O79YErZjx/pqcr5?=
 =?us-ascii?Q?UiI2jHGlZDJQD9+hwaaKLPKUq0Br0ot+ELql4Odm1AHmiMzeKNaKmUgYEIKm?=
 =?us-ascii?Q?SDBRtBSqhDcC/54r2woXDFUX89TsUDun7b6iR6vVN0JZYQTCR40k64ankUti?=
 =?us-ascii?Q?g6yCfmKDjD+g67nL1HkEdFKkc9cVRozDK/fXYghJ6nTIocp7+TNvsOZr/WZX?=
 =?us-ascii?Q?I+B0LvIG3y7Kh5TQd+FDzE7vzsBeOa65dZuQ8Ryx04WfJCYJ+ekUf6LK1mdF?=
 =?us-ascii?Q?+hXwc1XBQ2R/w9VLO/OHoh0ptR6qhkoFtBNGUPM1Ks8ykI3xRy4ycRG/CDf5?=
 =?us-ascii?Q?IN0Bm93DtAEPST9tOCnjQoKGdYmM9XmxtmCGuMYMzHcDF8VNDJq8FskKJNSH?=
 =?us-ascii?Q?S/tVQHCfbPUCoWpYZnejnqg0VgX9RK1KM43hoeRT6rZETJzvjsdcNGaYcAn6?=
 =?us-ascii?Q?WPF6/Tqme1OTaI5UWftUs0EcqqUcyQDbWk6THyaA78HyEEPfGp32B5wafk17?=
 =?us-ascii?Q?J79OBwIqNKn3eWQCbb0lvpIFRgmUcH5Q5jskYl9bTth7MxdjlOnvONsbwtT9?=
 =?us-ascii?Q?34V1m5WPmWG8eu1SbLQJF18klDWh/p+drnf1z4ov1IWzZrCC6U4JO1tk/uGF?=
 =?us-ascii?Q?qgooG/IjhughOvK1ERFy2eoY8iGe9UvbPd1sjmoJkJULvt/6zx8uppRPQyeM?=
 =?us-ascii?Q?4KyxTJXhosAIZl/GkYq5FbFggRpAdtJr1hdG3PGFJfUg7ulJoKnQzi3cTKXN?=
 =?us-ascii?Q?X6FdNFvkEWrnfFLS4sz0/M+PZEvFXfNoXoTRs6jGOrrtfNWHa+QyTXX/wqyz?=
 =?us-ascii?Q?mKLkUEUFFc35x2g3ZeGEzjeIrKpJiRj/4tf05s0h/OYiFB1PmsdVKTC3QaBv?=
 =?us-ascii?Q?h8uvwan8FNezIHPzGUvOS2RjM+n1kWp01eInQr3ZLsF80R65n+CaOmRpYVEm?=
 =?us-ascii?Q?W5Vr/3iZL9B2fo/wWuCZwcNe621wTxbd3BXgtz+6H0oNqb9eYNYRBjrcuFnd?=
 =?us-ascii?Q?VADnC5WOCG9ns5fEXtNXq6yp315Mam02Kj/gCNzDpsT79yY203RDt7qjuaaC?=
 =?us-ascii?Q?TXnIQ1xPD/Nf3mfGKofKSUTT43VY1HBErNiFMvA2E5GKk4yB54S0CBjGAGWa?=
 =?us-ascii?Q?TMwgOVp8/C0QGBFJ0dcpU50hBmDFrWrAf+mKp1jm23dAuGTVVOV7S2Npi5nH?=
 =?us-ascii?Q?eV7WaqDCMwQSDc6rbpjefo9U?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b807e13-4289-4f43-d4dc-08d926ca55b5
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2021 20:01:11.4348
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yjQN2h8Haz4tnOmqE47eS9G2Nx0i8hNAwMmuqk4gwKKbNePrVliBki+iWP9D0Asb
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5237
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Jun 03, 2021 at 06:45:31PM +0530, Devesh Sharma wrote:
> Adding automated detection and enablement of global PCI atomic
> operation support.
> Updated to ABI to pass wqe-mode to user to support rdma-core
> pull request:
> https://github.com/linux-rdma/rdma-core/pull/1007
> 
> v6->v7
>  updated error return type to -EOPNOTSUPP
> v5->v6
>  dropped fixes tag
> v4->v5
>  fixed commit msg in patch 0001
>  fixed mixing of int with bool
> v3->v4
>  removed redundant code to enable global atomics
>  refactored to honor standard error codes.
> v2->v3
>  Added additional patch to update ABI. A PR corresponding to this
>  is open.
> 
> V1->V2
>  renamed bnxt_qplib_enable_atomic_ops_to_root to
>  bnxt_qplib_determine_atomics
> 
> Devesh Sharma (3):
>   RDMA/bnxt_re: Enable global atomic ops if platform supports
>   bnxt_re: Update maintainers list

I took these two to for-next, thanks

Jason
