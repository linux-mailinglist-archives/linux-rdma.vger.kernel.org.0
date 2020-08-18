Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A4BF2248DD8
	for <lists+linux-rdma@lfdr.de>; Tue, 18 Aug 2020 20:20:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726552AbgHRSUS (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 18 Aug 2020 14:20:18 -0400
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:2595 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726435AbgHRSUQ (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 18 Aug 2020 14:20:16 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5f3c1ba50002>; Tue, 18 Aug 2020 11:19:17 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Tue, 18 Aug 2020 11:20:15 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Tue, 18 Aug 2020 11:20:15 -0700
Received: from HQMAIL111.nvidia.com (172.20.187.18) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 18 Aug
 2020 18:20:15 +0000
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.177)
 by HQMAIL111.nvidia.com (172.20.187.18) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Tue, 18 Aug 2020 18:20:15 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eHCYQoXswgfidBoBylU6nkUZb2jGKkG2t29liY4BVMCFF7z1U1T/thtf/lesX/llbs8iv3Z8lQEFN1WDGgRrbE7usfzpI2rZbErjCv/8ubNEEQ6y8BtHXLNSCcde4a3Z8WH9SUuANrBkWHVWiBVx+zMWQ0ZQqwnfwf2djJ2/Vxk3428m3kBgxVlK4RZ+NUkwaM1b+oFxbrLRrZBISygBLe/OZUlA4bJmfViasioxqYcnYAe8ayzljX0kDWj0++vAVEiEWOV606hZkXHoifMAvRvo+8+dnbVK2rKr0bILivPOGZtPn5AUzeXDMGWpZz2ih0C3ZcYN9LmE/R9nYKFkzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DwKDXBkKpYvXbNRgWGHxvMhoOA6WAM9C0mYkym/4TKg=;
 b=gw3V8h1vtN9z+UlwgRY8XC2rO5Jv8RDy9/rPxBkj95nTgvlFjZpOqPj5cpf/Yaf7fbL90i1fFnbUNg12vyhTlLqKJvQJ6klBoOyE/7O2iXLgUDQ5kW/gvSy5qBvDoGGBg7EEKTSlNNrtX4Lhzgu8udOtFuw9o02XD9pceWAowbMM/ZqTxk6W+bg0XiHpE7xJ5QP/YhiNlLIGRPnHemBiiN5UESuRKuCyKTWyJKAGT8iUJ/x6MqhS9qecLshX+y4shoJfjh/Fhd65UGPgMgrqA+L/rSLVSYhclIdpl+6/A1wBM8hLVyBOxtUr7NztZ23Re4rJTadQV2eHzgWPFoGfeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM5PR12MB1755.namprd12.prod.outlook.com (2603:10b6:3:107::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3283.20; Tue, 18 Aug
 2020 18:20:14 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::2d79:7f96:6406:6c76]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::2d79:7f96:6406:6c76%3]) with mapi id 15.20.3283.028; Tue, 18 Aug 2020
 18:20:14 +0000
Date:   Tue, 18 Aug 2020 15:20:12 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Leon Romanovsky <leon@kernel.org>
CC:     Doug Ledford <dledford@redhat.com>,
        Maor Gottlieb <maorg@mellanox.com>,
        <linux-rdma@vger.kernel.org>, Mark Bloch <markb@mellanox.com>
Subject: Re: [PATCH rdma-next] RDMA/mlx5: Enable sniffer when device is in
 switchdev mode
Message-ID: <20200818182012.GB2057810@nvidia.com>
References: <20200803060214.15328-1-leon@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20200803060214.15328-1-leon@kernel.org>
X-ClientProxiedBy: BL0PR02CA0029.namprd02.prod.outlook.com
 (2603:10b6:207:3c::42) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (156.34.48.30) by BL0PR02CA0029.namprd02.prod.outlook.com (2603:10b6:207:3c::42) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3283.15 via Frontend Transport; Tue, 18 Aug 2020 18:20:13 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1k86DU-008dME-E6; Tue, 18 Aug 2020 15:20:12 -0300
X-Originating-IP: [156.34.48.30]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9b310639-0de6-4399-5701-08d843a359c4
X-MS-TrafficTypeDiagnostic: DM5PR12MB1755:
X-Microsoft-Antispam-PRVS: <DM5PR12MB1755794F36C86AF78506C2C3C25C0@DM5PR12MB1755.namprd12.prod.outlook.com>
X-MS-Exchange-Transport-Forked: True
X-MS-Oob-TLC-OOBClassifiers: OLM:3383;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: A58uSdxkn3XkxMHb4UK4rGCf44GYSEWfmb/5JYtzlepc9deF827k2KgokE2/04vVl4kEcVx8p34myes+hwyAbEuOSCoxGn2c5bj84pp8FkhUQDWRRixSV5s2kIuqCJnZIyMDYOwSWwjESt4RLL8vb1uMRSDOIkJxCN9vt9ZezeBT0jt2HA8V8Uh8KS7KhoSZFJ4Th20P4Ss0c8OY4jtS8LS+fg4OwlG5KSUZNKO1ztXCGzx70WMH6DZRkwZk5mii79FmTK2olvT9q3382dJv3G11oQ/XoNJaTwgO34mWJYQ4hqMPJeihColYps5WYkuV
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(396003)(366004)(376002)(346002)(136003)(316002)(86362001)(8936002)(5660300002)(4326008)(4744005)(107886003)(8676002)(66476007)(66556008)(66946007)(9746002)(9786002)(1076003)(2906002)(83380400001)(478600001)(26005)(426003)(33656002)(6916009)(54906003)(186003)(36756003)(2616005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: CMg2LTvE8xhc5t/mXHt2CgeTCz03rODaskm2WjWGRgVrHEYi8YbJNh+Ag/gkcmYtgb14WLQeLeWjDgUZes356l+254SMB7EOfPhP5ntHlqIazAmkxnXKwO5Mi2o/OjVDY4ZtgdTZbROJsWpgl0h/ZsuJiIIZKRTBnOhEDmXFz2CbRTTbSe0po+/LlmHFEPPt4fGQxSmQiM+KYlr5NteGUit8PPUc+Rwd8Jloy7xGFBWFgIQAHMDn5unieWMSHWhAW1YFdrhFcMCRJZIC5VZqNloNZFQukVLqqcMsvwp9Df5f0JaSWw5wWl4zdjLMtKHSNdY9/LfzN6/oJiIH4xWuGlJuuchMCOzcjcwxNefuOZ5WDAq5xmjQcvySyRHbg6MbbHQA3dOoXtBqUoR2uQqXwSOIEPU1nYqM+lhi6lainqCncAowQMk6m5hxhPggULhA0NwdFqFzzWAFZiySwZuVBErKfafcuN5Hewpn2eAD4Mevs7+dItThj+dy6soXTHxfBvqg2dvIZmVhJ0nwlG+tbaCqTPdQHCva2A4TmPWKTROjk8bbOBo3kSLfzWnnJUaz+he/piZES0ZtFlxUY+rHpsvKEVbYwWYTFKOHUIyvJZQAeECN4UM/VTXKJVEMQmkMaIB0/ibaNxUykSTE7sRe7A==
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b310639-0de6-4399-5701-08d843a359c4
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2020 18:20:13.9633
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 45WlD3gf6kKXz/r1GKTdXPkEo/bRZAXUVk8NP/Fw6PybtiYLZdsnmkbl7CWJpDg0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1755
X-OriginatorOrg: Nvidia.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1597774758; bh=DwKDXBkKpYvXbNRgWGHxvMhoOA6WAM9C0mYkym/4TKg=;
        h=X-PGP-Universal:ARC-Seal:ARC-Message-Signature:
         ARC-Authentication-Results:Authentication-Results:Date:From:To:CC:
         Subject:Message-ID:References:Content-Type:Content-Disposition:
         In-Reply-To:X-ClientProxiedBy:MIME-Version:
         X-MS-Exchange-MessageSentRepresentingType:X-Originating-IP:
         X-MS-PublicTrafficType:X-MS-Office365-Filtering-Correlation-Id:
         X-MS-TrafficTypeDiagnostic:X-Microsoft-Antispam-PRVS:
         X-MS-Exchange-Transport-Forked:X-MS-Oob-TLC-OOBClassifiers:
         X-MS-Exchange-SenderADCheck:X-Microsoft-Antispam:
         X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
         X-MS-Exchange-AntiSpam-MessageData:
         X-MS-Exchange-CrossTenant-Network-Message-Id:
         X-MS-Exchange-CrossTenant-AuthSource:
         X-MS-Exchange-CrossTenant-AuthAs:
         X-MS-Exchange-CrossTenant-OriginalArrivalTime:
         X-MS-Exchange-CrossTenant-FromEntityHeader:
         X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
         X-MS-Exchange-CrossTenant-UserPrincipalName:
         X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg;
        b=rfGshvARuLnZzAffqNtSaF+ljSUZXb4sW4L208uJLAix1bWjwMejLJE8AQdyA79bF
         e+uppwI30AgpiILjhKDS9ucEgq2oQd1dL6uaV+JccYySVXl+z5JeC1ApLWSSlomLoe
         Y/X9ETUyT68Zslq7DRdFrSbvkjORONy/NPKHWGEol+DBEcHiaMYgMtbLg6OPTUkRrF
         fff0nq1MIGlBvJNHS0YSbx5zTpPVHcewwX4ebpevNwr4qEmBXBd5pMnxYClpU0cKMJ
         a2b6x75xP1xJmx1065ivNOiL7AjwNgDquGOb9qh5vSuUZbq5R57At4R9aVJPNZEBYe
         JCUzT2Kn9C/jw==
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Aug 03, 2020 at 09:02:14AM +0300, Leon Romanovsky wrote:
> From: Maor Gottlieb <maorg@mellanox.com>
> 
> In order to allow sniffer when the RDMA device is in switchdev mode,
> we don't need to set the source port when creating the sniffer rule.
> 
> Signed-off-by: Maor Gottlieb <maorg@mellanox.com>
> Reviewed-by: Mark Bloch <markb@mellanox.com>
> Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
> ---
>  drivers/infiniband/hw/mlx5/fs.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

Applied to for-next, thanks

Jason
