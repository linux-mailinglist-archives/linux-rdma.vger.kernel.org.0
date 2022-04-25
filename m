Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC7E850E8AD
	for <lists+linux-rdma@lfdr.de>; Mon, 25 Apr 2022 20:50:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244544AbiDYSvf (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 25 Apr 2022 14:51:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231680AbiDYSvb (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 25 Apr 2022 14:51:31 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2043.outbound.protection.outlook.com [40.107.223.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D14B47EA22;
        Mon, 25 Apr 2022 11:48:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YnpdXTNXrzXxQ5rk/ey+8nCVK0TkiGptjcbXEFd92q1Td5C9+PB6hNMNMAZci8+fmh2fXgrFM/XmiP9RQlNgpfDYZESsE8O0XAM+x1NJr9gsiXrlrkkdJ13yQnBjzOFvshl1hqwwH8oBKoYZ2/4vuO10v2XCMyQyyf2p5Dz0/gxdHYV3NOnWSm+aEF9s2xq9DU8v/t/4b19tyde+bP/KXxknDOUrYfOw8SNZtlZudgUSccw+gy+FNsU+Wg5GLSRKx/Rra6qjB0Gb5eJtb3/a6FHsY/FIzmduuVPD8nAG3kICl2nwWe3qZAsR3khG5IRsEyPlA/mGbqS4kzUSoYWZzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RvfnSIJnMWZxCDdX/h2Qh0l4Cb+RCDaJd0f3OqXMsRk=;
 b=YOu/wz72SYSKivsiXv2mNZxXLTwYi1yzLtBpOqSTyrE7R9Bg3L7QYFVPur8VSLSvdulJVaXAiuNvMbxFPfrZMdsHLfYss4Rbwhgzb3Dy/rVyAu40ynkOLkuEoVf9ozxLwJrQIv5FoEKtBl2+wVsTfIZsgWZqbxH0gXuUHa1qNCCOlWFnD11WapPU7Ze+Od6EnUaY629HNe3osC6CqzbOjsV06w9l9DSMvUP4SDRgchNOOGFtRHY7vV2JCJtdQpABrFjrg70PiMEC2XvC9gItXZIARWi3sepamEkW4gz3BCoEYUEPohEIn286Ha4Na0ZIHa15k8bZ855YGW81iW7ing==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RvfnSIJnMWZxCDdX/h2Qh0l4Cb+RCDaJd0f3OqXMsRk=;
 b=hNuLrPmDRpDJiqZPYqGldJhPilgrIoj58WBBnjwAA/7b4/2A7yltS2xLiJyBE0ohndf8Br7SycAc9j1dPyks4FlOn8ppGLPfOF4ChKmHVPiZgPmw9wdtZYfrTQQFZhb+U/r7Jmiy7cSl1B1ZlBFDUxzKOXYMArZ+6wdq+IFxuMmVog1MUSdpM9p4Li0yPZZHSeMfRgl83JBqFYn0oclDg8HW12BL61zAUCHkGSx+w/hK/bfnziL2CKrA6Y565zag5886UNYOk5e9NQSJty6jy+J1nFLna49UXp6a+skEOSMBwk+IKhXYaC+OzjcTmnp8MStg2bFmmEhF+1sLZ1zyXg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
 by CY4PR12MB1144.namprd12.prod.outlook.com (2603:10b6:903:3f::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.13; Mon, 25 Apr
 2022 18:48:25 +0000
Received: from MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::ec2d:9167:1b47:2db2]) by MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::ec2d:9167:1b47:2db2%6]) with mapi id 15.20.5186.021; Mon, 25 Apr 2022
 18:48:25 +0000
Date:   Mon, 25 Apr 2022 15:48:24 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Leon Romanovsky <leonro@nvidia.com>,
        Aharon Landau <aharonl@nvidia.com>,
        linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
        Michael Guralnik <michaelgur@nvidia.com>
Subject: Re: [PATCH rdma-next 00/12] Refactor UMR post send logic
Message-ID: <20220425184824.GA2247544@nvidia.com>
References: <cover.1649747695.git.leonro@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1649747695.git.leonro@nvidia.com>
X-ClientProxiedBy: MN2PR17CA0020.namprd17.prod.outlook.com
 (2603:10b6:208:15e::33) To MN2PR12MB4192.namprd12.prod.outlook.com
 (2603:10b6:208:1d5::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0696f06c-a1ad-4532-df29-08da26ec2dfc
X-MS-TrafficTypeDiagnostic: CY4PR12MB1144:EE_
X-Microsoft-Antispam-PRVS: <CY4PR12MB1144004BA29717B31AF2B2A3C2F89@CY4PR12MB1144.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XnGIPGLyq1/5hLrG7OY+POHVPNcHg0RSRDyD2kHaz73lXD45IjDsEAOOf2R1CrWpeHks+HHmk13x0hIjvzCsZ+Uup5+k/PAFx4BEtR7wzsutv+22M+arWnqUrFWPnWybroDF25EMGCtVno/4f3IsaYh84T//OXRkWTGylIMFTVFKma3L3jdjnYslz5ydd03LYB1mDERGnrsJTIY6uWD7FaDxEXmKdQpVsHqe/90joSnH6So4EC+KkCTPQ9my+Ni/UFqgbuRCzBLRwoHynqQr8Z+uYH9ODv36yb717UZJysbq5dQNcaBgsKLoxqd74QtyOTao0ClHIT7bh6ZrkaGfqX0Ye3lEo9TdV+5QdBwAH271rrNobYdIO3NbFLJW0inQFbunEobtBUpjUqaotdSG90xTnUcDt8CRN8v1MfAmhP6XcBSW+yyKJH+jxlf2W7OFF9Vd037Plnj0ZeuapmVQAl8HrvacZXiDlm6EdtRM1oYVpYCHDWKxhnjJAJdMS4zKpQKob+8cwiMwkwGihjCl9ixkjqlLTOTicxILqOAGMor2wp2y5jYkFOKuhkQLfXVR2TQ+BD8TLl1NpAiPZoESqUqNUZOadj2L6Hi9JSolw8jRncogoDTqe75j6o/yWD09n5D0b+txoijlrcVsT4fc8g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4192.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(6506007)(316002)(36756003)(26005)(6512007)(2906002)(8936002)(86362001)(2616005)(1076003)(107886003)(5660300002)(38100700002)(66556008)(66476007)(4326008)(8676002)(66946007)(33656002)(83380400001)(186003)(508600001)(54906003)(6916009)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?AHbvSBrBTT5wq5w49FAGI8KLhm6SSdAollnshPI6ecnmyOHYx+K2muVHNzfE?=
 =?us-ascii?Q?PczqlejL3LJqSQ37lbyR2brnx3AkuOpHzg3AWxQlBccFFdfDGLXu5qxtXGwz?=
 =?us-ascii?Q?JoCJ9/NU3f4Nn6Zfr46gFfv/4R3nMUqEnyQ1AMpuUT9lHdQzzkgkQ0GmTvi3?=
 =?us-ascii?Q?fDqJ7tY7MtDnvGNYuMhPXPcTF9VFTvlxatyXiP2Wsci4yCnzeCLnO02ZIKu/?=
 =?us-ascii?Q?/wCSWgilQVOL9m+EGXQ0hKTQs996yWiV+K1thBAkHzL3fxQDUqBCDsZtxGyD?=
 =?us-ascii?Q?PjNIn8IRmI//MShWNkopGcxcUslhvr0/nFxZnK47l33xDhsE4z+MOjbhmo3q?=
 =?us-ascii?Q?D+tqgmag0S5ucswOiiIBNfxoESoQ04VyqxR0rAi01pbwe7iGWTcj5X2lMEdW?=
 =?us-ascii?Q?1fG+UC0fwD14K+MhYWJnYeSTwaM5srr6nZ0MXDPG/uXZ18idx/gTskUfWxkX?=
 =?us-ascii?Q?7LAVAi/nrEU+z9MbsqzdWSPdjiqeSzDVJTXC7DurNyE14Hfdf2eOAvwtrT8y?=
 =?us-ascii?Q?wNL7yCsyzT2qLqI6Lh2UA2gcycL0mGiYKNlXeUJSQ7lwPA7NVcD+TxsjqaNy?=
 =?us-ascii?Q?k25mjCoVGZ/cBzYx67iUPq/T78YNS/PYrxi0fC/Nz/PU5jy1oc1h9Xz2yG9A?=
 =?us-ascii?Q?s2NKKFKjvkhHSKoIRIPWJuxmftM3kicBBQomdlwC+yt7iO303vqyRdZowLw1?=
 =?us-ascii?Q?pmJC2O6ZfHhehlT0OTnN+tmXcIUQhqT5GMD2C2t7gRLAKekwUXX89rvxtaur?=
 =?us-ascii?Q?ynr1FS4r/BX/OLrXZN+6vjhaI+uH3nFHBtlsjiDQ+aAFbc6vN0PfdDeJeHsU?=
 =?us-ascii?Q?1eSXS+KcjecD7yR1tlIxPMdi9Wy8Zpp8+VQvq/I05JME331ZEZ4JrrK1jd/a?=
 =?us-ascii?Q?B56nu4Izck6NeygP4gcjdJxXhNriHgp/uOaf3kVlWIU5UXwlx9himzKKKE6z?=
 =?us-ascii?Q?S6ZbnUDGsq2mGdwkrsFqKUM1uZQWnnPTjNtm/F47r17FdCEM4lIxEDFh7hVX?=
 =?us-ascii?Q?9AqLBdawpKspsum0960ee5UjYhiN6UoZM6p+0j9jjeyroj9ZgEm13YPoDnV6?=
 =?us-ascii?Q?xlmNMeZZPfy2j93gxyrhg8/C4ESBAKMFKdfHlHziLcWyXoEMw3TD2mH9dinN?=
 =?us-ascii?Q?UDLdS+CzGSwaOYTLaz2aCiNg7bF88vNCy2V923KYdNiaZbnVBBWK076P+tDr?=
 =?us-ascii?Q?9MeTYfBvC9yqfL6zWz7b2CoJjnHc5CpS5tGYT/MJc7K79Hlq7HZCCydW68Rl?=
 =?us-ascii?Q?816/mkt+aJV3t2WuU6bp4DaJ19TrlmgRGVt1tg/0WVcY5T4VkC35xNQnDufm?=
 =?us-ascii?Q?7a5ZUi+wXBYqtF6ONZ1y3oMF8S+45/LPA/dcrkVv3L/LaV2ym+JPCcCLbnxs?=
 =?us-ascii?Q?6Jxf4hv1vj3AcIEML2pYrVB0RQT9H3nuy/5DhotGIa4pt1QS/9319n/KRsio?=
 =?us-ascii?Q?fnsBWWD8aexf2m03cQvUpGKl/ez1d1B8R+iV1CfvmDpQWDlU+q4uub3Ext5z?=
 =?us-ascii?Q?n2vZsEnCqNFNxMwc00Jpc9YQw6k/4K2EsYIO8chotLwNjhfJ6+dMVrzTsLBg?=
 =?us-ascii?Q?iCyYCJsszu5JuYBclkslANqYzDtKzkzepz9sYJPhDObwkrkslQUp7fGU7a3I?=
 =?us-ascii?Q?pCwqhKI3Sfc+/Pkn+yaVJirtZcfsfAM79Ygj4WsaiEMnGvK1JeNOmg/CZIY5?=
 =?us-ascii?Q?VdYSIwXqG+tc461Xvz6dr0rCKh3X9siKO8S5rhxLS+MZXNraCOU+a0QX9+wI?=
 =?us-ascii?Q?FLTAcfQwzg=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0696f06c-a1ad-4532-df29-08da26ec2dfc
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2022 18:48:25.3593
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HcPPfQ5DaGRWMyY7sBB8lBErCKv1/ULQgdM5xZ/NZzv/j5TVPUy7MPJc1OdZxW5c
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1144
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Apr 12, 2022 at 10:23:55AM +0300, Leon Romanovsky wrote:
> From: Leon Romanovsky <leonro@nvidia.com>
> 
> Hi,
> 
> UMR are special QPs that require slightly different logic than other
> QPs. This series from Aharon refactors the logic around UMR QP to
> separate file and functions to clean the post send flow.
> 
> Thanks
> 
> Aharon Landau (12):
>   RDMA/mlx5: Move init and cleanup of UMR to umr.c
>   RDMA/mlx5: Move umr checks to umr.h
>   RDMA/mlx5: Move mkey ctrl segment logic to umr.c
>   RDMA/mlx5: Simplify get_umr_update_access_mask()
>   RDMA/mlx5: Expose wqe posting helpers outside of wr.c
>   RDMA/mlx5: Introduce mlx5_umr_post_send_wait()
>   RDMA/mlx5: Use mlx5_umr_post_send_wait() to revoke MRs
>   RDMA/mlx5: Use mlx5_umr_post_send_wait() to rereg pd access
>   RDMA/mlx5: Move creation and free of translation tables to umr.c
>   RDMA/mlx5: Use mlx5_umr_post_send_wait() to update MR pas
>   RDMA/mlx5: Use mlx5_umr_post_send_wait() to update xlt
>   RDMA/mlx5: Clean UMR QP type flow from mlx5_ib_post_send()

I moved the static to the earlier patch, but otherwise applied to
for-next, thanks

Jason
