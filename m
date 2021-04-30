Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9232836FF15
	for <lists+linux-rdma@lfdr.de>; Fri, 30 Apr 2021 19:01:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231124AbhD3RCl (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 30 Apr 2021 13:02:41 -0400
Received: from mail-bn7nam10on2086.outbound.protection.outlook.com ([40.107.92.86]:16032
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230428AbhD3RCk (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 30 Apr 2021 13:02:40 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MYz/JRBLmXOIeaY8h0uLHjutkFeWmW8yYFu2AY3qF4RcgiXtkpbY2h91l9N7JNQpfJM95EKQ87zFpecSvUi2xbFPSBd0y0CA+JZu+IvVPrzGiqzan1dTMPvvmAFOqg5r6HCncY3Ldxkc8d5tf50ajWtbD20pDWp8MvSRe9Z4BK6zHpqxEchEYgxT26tqGz/DRREydtoNpgQDJY4pjElvpJEwwePEC/ldP/ozSUeErxlAGBwkeBf5mQ7vn5+DAUnHX8dVYHzR7//CRFjjQ8RPPvfTprkP/R4Aki9aQdNYoQcIFHQp6xAdq6kbBo7S72zzjlTDWFP7ELz8kOXQtU3ElA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tfcv6MW3tTJBx0Gx4Cq+zI7KjeSwB9wyggiNDQe6jig=;
 b=gMEogn+gFHtQXRMmjmzqdTiNWDDkhBw+5H8LJkYTSrUA4mhVV0jhi7oRJ02X31rdP0taxTNwotelhX7qmTLKS3jtnHw08cZ3saK2cORu1HdRNofRp4fkwvQXGt5pj78agNifL/J01XPyHX8jrTIpA9QooVBJvUkwGOfj4qgaFECbbtQNF3qDbYGn/QvGjxZVZ9USuC/zjpH8E5va0UF9PEPiSRx5tFOlt9xhxjQ7z5QAilSAyJ+aA53pVnXSF8A0DZ2qN0gNMhYsY4zVhAIdiQ4Bk0S3godOshcYsrXORUD0uGQk4aYOxjJNmCcKjyjUTPAiPeVji8upG23gFhNWCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tfcv6MW3tTJBx0Gx4Cq+zI7KjeSwB9wyggiNDQe6jig=;
 b=KPAyQ6d2CEAdeWfCPi6dG7qLeeJLU3rWEqtqbOHGbP5EJ4ExkKD3pRgcswoJkXChcTu/I7iNCNzdURPTcAJ9H1tjfZynIdyPgGvhyvDFykJXFwEnbhTHHStXl/LSWGgkh3WZpKxFAM8rGkWX0ex8KZreMzyEAnchWZvXQaIJ2x1GTiSRZPoh42MHDoXLrVuEil/idEC84MX3529G9n5/vh2acKz8ktIQa9VfzvJCy170+oIRLqmMOfAycXOBMQdq7e72k0bvnaDO4DNqM9PHUYp/A5JzfkggPIcPxDPywswk/IqKGaWXmeRjvNSJELe2wcN0ex5DwDSU/ZJXSwDe7g==
Authentication-Results: linux-foundation.org; dkim=none (message not signed)
 header.d=none;linux-foundation.org; dmarc=none action=none
 header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB4513.namprd12.prod.outlook.com (2603:10b6:5:2ad::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.20; Fri, 30 Apr
 2021 17:01:50 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1c62:7fa3:617b:ab87]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1c62:7fa3:617b:ab87%6]) with mapi id 15.20.4065.027; Fri, 30 Apr 2021
 17:01:50 +0000
Date:   Fri, 30 Apr 2021 14:01:48 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Doug Ledford <dledford@redhat.com>
Cc:     linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] Please pull RDMA subsystem changes
Message-ID: <20210430170148.GA3574442@nvidia.com>
References: <20210430165527.GA3573658@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210430165527.GA3573658@nvidia.com>
X-Originating-IP: [206.223.160.26]
X-ClientProxiedBy: CH2PR12CA0020.namprd12.prod.outlook.com
 (2603:10b6:610:57::30) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (206.223.160.26) by CH2PR12CA0020.namprd12.prod.outlook.com (2603:10b6:610:57::30) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4087.27 via Frontend Transport; Fri, 30 Apr 2021 17:01:49 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1lcWWS-00EzuW-OY; Fri, 30 Apr 2021 14:01:48 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9e970868-f6ce-417f-03dc-08d90bf9a557
X-MS-TrafficTypeDiagnostic: DM6PR12MB4513:
X-Microsoft-Antispam-PRVS: <DM6PR12MB45132C772308186BD3826A5EC25E9@DM6PR12MB4513.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dY6EF72gXsE4WCH1+A6WzvLZ20SYqBncsW/17w82jS/sq7VvUwzb4EEAJe2UhQ3d/2YmXqVEtiMfe8UH1PVrYPF7xnZX5U2N4K66y4RaUc92eYhZoa6YGT0yd0A9hr0LQJO5FjFqClBVqWcVJ0KOxlcHCxFlX6WPNtYDHkQxIdnx1d0723pxyN+f55hg59Gw5byQRhLKZ6+1H2769WpYoKaTrHwtaPLOjidLodWTyZtbBW6+ryjyjjMIjWWSagBKLyFQePDp5r4gNJD6t+4enhUzKwdFHRDuyKVWZbDVRPnxeaYdsR5R4Y90GzDHwkYinyXupwwviP718xO8v50g5jmB97ozr7OATyTei4eLn5q7QT/fcFAtNMkMdaaKMHoJeCigEvT+oLx2lJQS+z/PPC/MAtO83Lt9GTbh9p0TSDC+BgrwGN9nMBGeHM1VPKpIfGKxAGVoHjlNCzs8M55z6G979S/3j1nRXyRZ7aCpXl2q6MQt9WacC1cuZfvmF3WuKhgE7zqd/jz0P2LNKQjoDPFmuWEmzak4nYBcS+hmcQK+cKzD52NpnwM4+NGivxYetZbPE5aQv0bwDQya8igCP2vKtfh8yVI8KBPlkyLkO8k=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(39860400002)(136003)(366004)(346002)(396003)(426003)(66946007)(1076003)(66476007)(4326008)(83380400001)(8936002)(36756003)(26005)(33656002)(38100700002)(5660300002)(66556008)(2906002)(8676002)(9786002)(9746002)(4744005)(316002)(186003)(86362001)(2616005)(110136005)(478600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?aUvzlh1H5+fkmk0/A5k/GFa97YTLMihwv/498CyJL9LkcwEZUU2cRknXXL9a?=
 =?us-ascii?Q?/A7m+7AABqPzkn/uvy11s90ydGE/KwMYRShNKtv0/o2BTXMcN947mHL6LUlG?=
 =?us-ascii?Q?qszSq2tHH1kCC2oy9pIUHlLZEw2j5MGH4qXjbQUmIAWkWxFKtrB6ZBygTHcl?=
 =?us-ascii?Q?OV5ZguY/8nvb7YsE7dmVBNdYv42oab9vfnq6/5IDy6J6NpamCWOIZHQtFOZ/?=
 =?us-ascii?Q?y8BJFyt/JxNRgTezJwjhqMqbXalNmn4lQ50DG5Yu0gAZN7ASw5vtlVdeZfV6?=
 =?us-ascii?Q?5y2Da6bW/P7CtwxhQM/4qoEHyWE9vydclJAsZq40QnwJQelFKF0Lbtnkcmmh?=
 =?us-ascii?Q?7IDb7QHTTClhKTmU9xx0IwANKm1Dz1p8WMPETQYz7cpz2fY+KpD/oKfwDT4T?=
 =?us-ascii?Q?aSvP7zZBEIX+A04WmTvlvALuKvJ9d44oJwOOqLynkblETbQy+Hr8VL8a3y8b?=
 =?us-ascii?Q?zCqk8BgwojtFrsxmS2QvHkLcKb3R1X/4pamXQuW7GqjihFAHitTMTdWCcDsz?=
 =?us-ascii?Q?xArMinRlHFOS3bPbxqmL1bUDGrrSTRabGAa2ZRbqLt9hqhD1WE/5ij+IhqzV?=
 =?us-ascii?Q?riF6gvzy5D17e7OCA11o0QKn7sIA9WGGcLU0kUSSKqZO9XNSJmfr2TbEoGhs?=
 =?us-ascii?Q?c3Up3D97g8lwC/IG6d5ZbHVgt8j+6Rch2veYHalez7/2MbyEoOGuMWOMx3dv?=
 =?us-ascii?Q?3oQeogubLT33ZzoO9fJ62Zrj24n4MpqOgV5D/skKOw53HnnKJmqgOgzoovct?=
 =?us-ascii?Q?aG8f8YVI65jXJV8OGTnYNRMnrbKtuEY1BTcqKtzg15m65Uic9dNArDlmbx6F?=
 =?us-ascii?Q?8znIDFk6RxT4oopIyrhEXLSTMRebwKju3wJ8cO48vSy93+d6r2dER6tIcV+m?=
 =?us-ascii?Q?cVtkwOqK2XpZCauPXYHnshrnCQLiffxYeoAhqaz9egXsR1yPWUmkJsGMJPcH?=
 =?us-ascii?Q?MRidz2YIe7Zr2/rJxzpgMqEseb3IoIJgI+OmazDawLO2I3cWUgmcu+sn45Oj?=
 =?us-ascii?Q?TF11Bd3GlHcdEV52Sc7uwyJex0yU0/XqlbrDB3fcELZUZFIBMr7oME9Q5jSE?=
 =?us-ascii?Q?/rF/AKFnzNsp5q4QNLktY3lcc7qNxSkcmqH8yyEIAHrdJdw4Q2Mqof27YQgF?=
 =?us-ascii?Q?G7q4jlO6B7xZ/dl+XZ6RD3lpFDGazvOuDxURQP5koWeQ522bJ1h+QQRwftor?=
 =?us-ascii?Q?jlHrNboqG3r46zpEQXp3hBa8yLROX1mBbPMfDfdDO7jvhANw6UDX7HsK+uxN?=
 =?us-ascii?Q?HRlk5KU4ooOUjxGq/4/8V9faKq+HXf6GG66VTiUITLBZvesoZ2DpiEQa5snh?=
 =?us-ascii?Q?3wsLSUJO7wUK6djTw4TiMhNi?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e970868-f6ce-417f-03dc-08d90bf9a557
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2021 17:01:49.9460
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VkT+f4pIiKCYYvM0LeR10Od2N6vezYIFAari34FOCgCdqYX2fw3bnUC0uhkrfSis
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4513
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Apr 30, 2021 at 01:55:27PM -0300, Jason Gunthorpe wrote:
> Hi Linus,
> 
> These are the proposed RDMA patches for 5.13.
> 
> We are continuing to see small cycles in RDMA, this may be a new
> structural normal.
> 
> This time hns and rtrs lead the pack in change volume, but must is
> cleaning not features.

Oh! I forget to include the minor conflict resolution for hfi against v5.12:

@@@ -1402,7 -1408,8 +1402,8 @@@ struct hfi1_devdata 
        /* Lock to protect IRQ SRC register access */
        spinlock_t irq_src_lock;
        int vnic_num_vports;
 -      struct net_device *dummy_netdev;
 +      struct hfi1_netdev_rx *netdev_rx;
+       struct hfi1_affinity_node *affinity_entry;
  
        /* Keeps track of IPoIB RSM rule users */
        atomic_t ipoib_rsm_usr_num;

Sorry,
Jason
