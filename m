Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7879E71A36E
	for <lists+linux-rdma@lfdr.de>; Thu,  1 Jun 2023 17:57:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233854AbjFAP5x (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 1 Jun 2023 11:57:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233597AbjFAP5w (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 1 Jun 2023 11:57:52 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on20615.outbound.protection.outlook.com [IPv6:2a01:111:f400:7e8a::615])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04BB0E4;
        Thu,  1 Jun 2023 08:57:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fId7G87212luVeEW5cJekrNTBxbO3niveRn3nnsyDjOtOYWV3dVc934cwltC62Gct3gm0ORZC7LqaShCEs+QEwUEUcT82UFlPyDzjUFCoPuVcckxKDu0S+0DT/MJnhOkPJnr1AgoXdhomv7pVM3N2rLyylthWIk/PPAug3CzfLThi9hOrDs7IqJLjxYLHVXoO8n3rnmHVW/lGRJ9Rpmi5JcegrReV5d7OuOu4+95rgMKcgD9ajT29x7eRIlcrx3AunhAh/oEfno1YJrz8OAMBrtIUcUH4SCtu4bFX9K/2hxpX/f6ziliaydfydSrTbguzP6/IvAo48gPX9D4plO4kQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S2YqANhTLDJOYeMZlneKccad+O5gdZcphUP6HH2fBW8=;
 b=CfpPTPVYN0TFpynjXoz9zy79/1ZEvJnq5r8sRXq+P0ufplUEdJ0dsegV8R4HAfPtFQeIVMVI/UIrfvNtecXgsCH8g9uoDl3XI5HDzygrk3nrfLr20nK0up44XFoJqyU88/A3KEV5qbp4QyzTkI3D5LgrLAZzwc+TFgZnTbSZAyvhXSyGQYUE8Y8bMocQmIV8Qbe1eI6sY0aUV1thEM9Lnc4NLMjjrGUxB0G9lQLJYOx3rly/V5XSjBE7wFCBGRCxrMu4sM+A7oMfKLcxjYznCA+hIiJgPCrQJ6OqVI7yTJ2kZXEF2lq/qNzEWMtdt9yJXYOAb1n61oWfNlK25YqbsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S2YqANhTLDJOYeMZlneKccad+O5gdZcphUP6HH2fBW8=;
 b=cCaIWyn4VEl/UEV4D2Wo5pIUhjU26ebinam+yei0YAEREC09n2yLg1qqefe8TrmpjaKbDiLL+nE7bGx3n82tG+wBnHQQ3CYZey69kG9rJz87CgBYvVIgcHsyZv2R9FISDYzA+F207/KZmTOLr5zGOrI4FFcGElYpJfe8ITwH84o00id4QdcmYR5TqWvn+HvS0NjZGkf622KEGLyJG4tYve9ZZ45bg4yTieu/iygPqOzb28u71p033TNt5Ien6SuRij4/AMA/LNohLlOC9hXjSwzhmxz9CTiiMxWGDHjFy+sAqiM7/z4LISMrE2WSy4zvwikrQUjPXihF3pHganj31w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by CH3PR12MB8257.namprd12.prod.outlook.com (2603:10b6:610:121::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.23; Thu, 1 Jun
 2023 15:57:45 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f7a7:a561:87e9:5fab]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f7a7:a561:87e9:5fab%6]) with mapi id 15.20.6433.024; Thu, 1 Jun 2023
 15:57:45 +0000
Date:   Thu, 1 Jun 2023 12:57:41 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Junxian Huang <huangjunxian6@hisilicon.com>
Cc:     leon@kernel.org, linux-rdma@vger.kernel.org, linuxarm@huawei.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH for-next] RDMA/core: Get IB width and speed from netdev
Message-ID: <ZHi/9SjEiHy8fBf0@nvidia.com>
References: <20230522012502.1529035-1-huangjunxian6@hisilicon.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230522012502.1529035-1-huangjunxian6@hisilicon.com>
X-ClientProxiedBy: SJ0PR03CA0100.namprd03.prod.outlook.com
 (2603:10b6:a03:333::15) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|CH3PR12MB8257:EE_
X-MS-Office365-Filtering-Correlation-Id: 5487f6e6-bf96-4a52-6aa8-08db62b8f073
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wXSIjNKtGlIK9lOwVR0KzF+wHcKvBjj3I7VgrhqaAnVlmSxcdHvlCKA+RGK0DOeOv5TdkLNbex7MpmI+NrvpfPuE86PtqZGROhZc6DdtGxaompaKWWPqSsEyLmTceW4z6hdTc7cDurnb/P36HfW0JZiiMew96dlk8uUPOT1z1OoxMWDzLcBOH6rAzL4EyGKEuSnKKYNqRT4ujBLaVFAapvaKOKSAcEEtC6M9vMKAyXPl6+ZEyK4BkH6VN35t4e6pZDFzl9A7qMOqvod2BCyrbj4sn0Nw9TnVDUDp/dQWXH8vyLa4oA0LsXGlHjvwsqPjS4f3YhtUhk4x41GUHE8nxdHySfAFtgPkFdFlsAQgA4o8HPJ+sn0jaZxS+7NVf/vLPfXE6NwOb/M4K4AyniRi2eEchzPzEV//DqZ7ft2OCfhDcKQ79aOla2QGUJXXliGnMl4kKh/6Uq6ywUw6sL2sFon4Q5w/l/q9YlSvUFTEuRu8XJg966QrasAJVNWh+S9YZ3jmTWJcWPKRCMwAMLR4dnW++CQ/bLYuyGyF9z9du0ClZCHhI7WJ8Ge14A3BTcUh
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(376002)(396003)(346002)(39860400002)(366004)(451199021)(8936002)(83380400001)(186003)(4744005)(2906002)(2616005)(4326008)(6916009)(66556008)(66946007)(6486002)(66476007)(6666004)(316002)(478600001)(6506007)(5660300002)(26005)(6512007)(41300700001)(8676002)(38100700002)(36756003)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?an4VgOK9iUgQytmJixGSgUaqGpIM82UOLBRUX60+o3UYlUukzhR9Lia4vt1+?=
 =?us-ascii?Q?O1FAT2bOhuZcErImJ5XuxGqmIIoSFMrND3cew6kZliP03CEZt5MwGfkyPojr?=
 =?us-ascii?Q?IhriDYflAMo3r2jBYIR/2HiBBrWqemY5Jh6Q2U4WlShuMtR6Aa6VCR8juRgF?=
 =?us-ascii?Q?xNzS3WeYOi4L1fpC2yJsTsxBTJEuErAoB9gVVwVBM+OG98GklB5huF6lhvuz?=
 =?us-ascii?Q?TFmmyf/drlxtb1xERPQO7Dqoy1smbhfJZ1MAOP2e9UBz99kvQIKNfRPJIjBW?=
 =?us-ascii?Q?yBixk89oIyl6gmlvISGhf85zdinuVZRGnq1b0Z4j2cLcgF1b92gSqSleElMm?=
 =?us-ascii?Q?mf5h4EOhmD5vbj1ry8pzWLWXbdpggvpND7zaof0UXR/KdLPwpCzXdJf5mG33?=
 =?us-ascii?Q?B97SI8pC0eFo/fu5KYba0G0PXlmqKgN5+0MsFFTt3WIhIC9hJLOxvHqpwdP/?=
 =?us-ascii?Q?Sei7xNOjTUd7pYUJdYyuQV26gr9SsIQ0a2EfXdkN67qKbInUI2An4pjkCxzx?=
 =?us-ascii?Q?CCwCXK+jJgnnvdPhfbCVJQ8FGJhoTGYcf5yXASCQvmh87FLaDIA7ou/nDnaF?=
 =?us-ascii?Q?5cO1sI1fzkajzFyZZwWUAlzqxLQ07LmJzM8wUsfC1pQWfRx5km44LB8VENjZ?=
 =?us-ascii?Q?hMPrXdTQl9Szwk6xSC1MUvFaiQDI0EPz7hSSitkaAdZ6b+Tz6g+1oZ3pHybH?=
 =?us-ascii?Q?/mMP9XljfmAuaJKM9LdaXreg9ixOqsSqC+FdCLIZDCpsmvqLlYcV3o7ozVRQ?=
 =?us-ascii?Q?YJGwH3iXldzjsbxub+5qXKOsNKK5irn4AdXKQe7nBqiCamj4RvbWJXrRlHYt?=
 =?us-ascii?Q?+6Nhq6UDjKMmRvgsTnp5Zjwojpm+wChivFZ9s/IJrANT4WWXSAQ0Y2vlf5To?=
 =?us-ascii?Q?BFsh64WWqj4aOIlJLzut5KrMEmay3K+4U/bCZI2ULIVWtrqMXDUNaUYGNZI6?=
 =?us-ascii?Q?13LM6Cc3m5jHMfXZuMrGz/fbcZzkqVAE6ZGCoMvyASgCzkhjUR8D1IlNOLbd?=
 =?us-ascii?Q?BsHVTLTJ9Iqn3cP6Lcyx789CPLZRV3rv/9rgtYg/sbBQxLhdv9tvx682hgPa?=
 =?us-ascii?Q?0eW/DgptH2eGusrbtZ7Aw7KIIby9fDL03qUmLNKJ6Z//QyRNsefC0YlookwN?=
 =?us-ascii?Q?/+q0dvacoysYsZMnzJ25M6DXNfBYT2N9wfERYnWHsMOU5XfhngnHn/M0Vtk/?=
 =?us-ascii?Q?mmUKtRH50xILVX5Qn76oX6XvNlDOFdMZenxKkIuuw3sWesau0Bl7Imoq2Eib?=
 =?us-ascii?Q?upGRr3l4n3OcHif8595vqsAyYVNQs7P2XSJnZsPAb1ktwxGVHq5MI+SxAKUY?=
 =?us-ascii?Q?q8SfY9gHsFf5L2gxOiOiz9ds+8RmlqQuTdzEVQCmEO3pBS7RGVm56+peJedf?=
 =?us-ascii?Q?KZcu6m84+9ly3fMHqW9PkWqLAt6Nvhg3roVn+fWt03FSEaEusDzFqizZ5Wt0?=
 =?us-ascii?Q?B5a7wc+qs+me/REaFSNVamXO8G5+m3xS58HOaETtf06MVv5U0QNUZmTLYm6N?=
 =?us-ascii?Q?4SHrpObAyf4AIepbKbQGqLmYomQuYuO+55LhjP31p90H7kPFxMX7fXWRHl+U?=
 =?us-ascii?Q?OpejhmR8z+fCitEaIAYi5D7GPYcd9Zs2od+jPyMi?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5487f6e6-bf96-4a52-6aa8-08db62b8f073
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2023 15:57:45.2090
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2RwCaLRqyTGhnURdMw2kDV6grQlD3R/oVVLYVPn9s11Pq/JgzX4H4nVFN6USQ1Nq
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8257
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, May 22, 2023 at 09:25:02AM +0800, Junxian Huang wrote:
> From: Haoyue Xu <xuhaoyue1@hisilicon.com>
> 
> Logic of retrieving netdev lanes and speed from net_device and
> translating it to IB width and speed. Also, add a generic function
> to translating netdev speed to IB speed.
> 
> Signed-off-by: Haoyue Xu <xuhaoyue1@hisilicon.com>
> Signed-off-by: Luoyouming <luoyouming@huawei.com>
> Signed-off-by: Junxian Huang <huangjunxian6@hisilicon.com>
> ---
>  drivers/infiniband/core/verbs.c | 19 +++++++++++++++++--
>  include/rdma/ib_verbs.h         | 26 ++++++++++++++++++++++++++
>  2 files changed, 43 insertions(+), 2 deletions(-)

Can you explain in the commit message why we'd want to do this?

Jason
