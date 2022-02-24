Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DBC54C20B9
	for <lists+linux-rdma@lfdr.de>; Thu, 24 Feb 2022 01:40:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229542AbiBXAlD (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 23 Feb 2022 19:41:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbiBXAlB (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 23 Feb 2022 19:41:01 -0500
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2047.outbound.protection.outlook.com [40.107.92.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F7F12A723
        for <linux-rdma@vger.kernel.org>; Wed, 23 Feb 2022 16:40:26 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a5KtO1Ss2V2+Ef00DhLGUWpBey+k2D1eJhHYrzjOx1owIGOvFo0PEcwdXCapcN8jzmXpdRi3UcofCP6B9jeqM6g1dL1O2jmYxg23GrEZCC/cNGxErtAmJLGWlCtrUAeqzWf8YCPNC3sUjI67AwYQDB295EZ3t2/nNO4vtkZ1b7fNGcoeYE1a/7CylDVRXU8Gz12ZdHfSQKsGz/i2BlcgqdeAqR92yBx/Wi2Gx4vJZmxFE07vzy3wYfURnQmaMPFZYNEYkYFfyGvYgwJceQrk7RHdILZaUYmT/j3cTEVk+uqKyvRnXhOUXk3brcwtfEJA+entYIAshQgRSUnJur/g8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GTla2966OFjHxmUZi0aTwNxnV5kmPkPCA4ubKRI8sNQ=;
 b=Yyil3WYL0QHWvgG9jIUo6IqWGPP9RsYaSHC95Sc5T2qA7vNtO7GWbCLkEsU6zAi3HYA0Ru1a8WfwYm6CEMNBa5kqi2ZiHdDAxdFLFpNo8DnralpdcoDQiD21G78gNUz2kRgjQqGeUm4kllSn2iMfZXP8iFVZIpzMDnn7csDRbesNL6W+m9pI9PXUdrEUEbt5EkQbJ31r5/GhnVv3AtxoZ78UC+KUnV09QH8In8dygb2ykbUqwx8ts9OYnxqV4J5d3mqL+fP6kDhZxwzhg+ICWQY0sYaPUCW2i7FM5Rl+13/Ni1y0apMYNoBUOXcNfYH4dG3/xzWxAoS7YU/hpvMrOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GTla2966OFjHxmUZi0aTwNxnV5kmPkPCA4ubKRI8sNQ=;
 b=glr3R7Gg5ZI9cM2HwTDuPwAbwvWhD2lvULk8Ne5JfbsQQuJbx4n9yRTmq5jdRpau/9vc9+w4mmTEo86jXS3weAKoH01U07DCVES5Rq109lqTqjrDYHwad5KSYHGimUMbIXKSfxvCMulkVjYOxkk0Bqq1nEmUHkpuL/S+xaDfZU8wfqxQ4rabOGIOfe+Sf1+GqkztpGaMlHZu+OWsKu5aEYhm2XFfSgnZKvzOiEXeMWex3z/gbwutEWN3lKD6hEnFmR+NEbydwPPShwprxZ1NNT5dupxP97ssT2malCO3AFgBgjPG0fwxjUvdjE2CYMnImk/2HhymbzLboH7igCLW/g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
 by BL0PR12MB2548.namprd12.prod.outlook.com (2603:10b6:207:41::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.21; Thu, 24 Feb
 2022 00:40:23 +0000
Received: from MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::e8f4:9793:da37:1bd3]) by MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::e8f4:9793:da37:1bd3%4]) with mapi id 15.20.5017.022; Thu, 24 Feb 2022
 00:40:23 +0000
Date:   Wed, 23 Feb 2022 20:40:22 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     yanjun.zhu@linux.dev
Cc:     mustafa.ismail@intel.com, shiraz.saleem@intel.com,
        linux-rdma@vger.kernel.org, leon@kernel.org
Subject: Re: [PATCHv2 0/3] Use net_type to check network type
Message-ID: <20220224004022.GA448545@nvidia.com>
References: <20220223024252.3873736-1-yanjun.zhu@linux.dev>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220223024252.3873736-1-yanjun.zhu@linux.dev>
X-ClientProxiedBy: BL0PR0102CA0014.prod.exchangelabs.com
 (2603:10b6:207:18::27) To MN2PR12MB4192.namprd12.prod.outlook.com
 (2603:10b6:208:1d5::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b10faef4-dfbf-459e-7e12-08d9f72e3e33
X-MS-TrafficTypeDiagnostic: BL0PR12MB2548:EE_
X-Microsoft-Antispam-PRVS: <BL0PR12MB254872118645AC8093D5E476C23D9@BL0PR12MB2548.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZUmR91+uNSTEUPFY+0PHj7TenOQW/8NZ/TzJ+JlMZhxGa0klEHjMDN1I8EgCs+zIhh8NGXG3G2cTTlSsnScotXG5TtviadWaB30w1LdIR62goYQq2HyMMvQNvFxvEZOJl2cJwIZ7/hhqvhWzpy/cNWCrYeH+T0ygqWHXDoWQ9x/ZY3uoDKEvkJ6th+WEHEI1/zxuH/VnVoFRqSUN/bA531nwzfzdQ6+0wR3OAMdYaH1HF1uSq3BC4RRartgIFZAZ6+SS9hM3qWtjIiv4yEyHXdhj+5t8I4RI7tEXrRhmpo6ObPzUFodT0YkjlKexNOo5FPINKyLNt5T54jtjzIhnuYBrq8Lm6MjXjFA0G8eyIX1ASWn7yY34fTvcc9e7jSPu3dRwOnFHUkWEUFr7fNfHriadw6+dOONlQp1+5BNeSnmrPJWjHNl+V3xdukY9VB4udNsa3uQm/LhTImqt+mYRayZnQFXfy/diR+2Ifs9y7n9FsB5J4pKc3DIjBqX24S74nf0JlivxQA0OBu20clYpMK+gi0qxW41H8/f+X5Ys9f6ZtEe7oschQBo/WGcNKklheob8Oce1SbK70BUByKPR3CArcDB1vHi8qf8LzvbC/vdWxUbnZFm4ESZ6mRBl+czCxJvI+VJBpeFSXO/91CwJVwWLsrkvBQ5IGzICRqf0UB8YjzIbMDZSUn0wM9Qs/7MQBLoJ7K6B0IyyZDaPT/bIig==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4192.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(86362001)(2906002)(8676002)(4744005)(186003)(2616005)(316002)(26005)(6916009)(5660300002)(4326008)(6506007)(66476007)(508600001)(66556008)(38100700002)(6512007)(33656002)(36756003)(6486002)(8936002)(66946007)(1076003)(27376004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?3nKG4bnVqNoK9xSAZOLcwLVyuJ4ljGXwVhoi0N/VxH+djOgvbJaMZnlrr96E?=
 =?us-ascii?Q?MnlcUIyMUzE+OZ0yJ9RLj9Hvn0tyr5YxLyDdyG1geuuzqCvr0kXe1kn5ZZSc?=
 =?us-ascii?Q?uDsccF1NvlpTBXcst1N86MIe2xehc/9wfzp3Pae35dCN2Tyk4xO67JoVEAe5?=
 =?us-ascii?Q?vgB3AhDB2gxRgs30FFWxwQo36SfOjf65r+Sh3mJFMPG7M8FJ/ApJktlaw2w/?=
 =?us-ascii?Q?fsh9nv1gI3547pe/dq9n4N1/P02XCf4XDI8uHkT8sSch8EAx/CMyGVuMYzCK?=
 =?us-ascii?Q?k6dnE1CbR22ceBMMH8+Y4mTY4sj9AxFMNthxJXGSuthKcJL2Garz6mpCe27J?=
 =?us-ascii?Q?TnYdzlV99FkX4lJOolgITuBi8I0CxRBmTjj0d92a+8H0qvySjIVkRLp4iRhQ?=
 =?us-ascii?Q?iLZPBxZMnog0+VAGqW3JWS4FCmS+Es38fPMHGHSIgHQXjKIU5s1nLZ8kyY71?=
 =?us-ascii?Q?dRauSsnlbHrxtznS0hpQKFeGgATrOdWWECQIMvwnQi1rkJ2qdpzpxGe9hj5x?=
 =?us-ascii?Q?YlwCGfL0dGYQ6WiGZX5TOCeXAmtp8RrIvwqEh/Wmi0Vbd+3wRgnh6U4tTk1g?=
 =?us-ascii?Q?BBSg1ac3ZyDK1yFHtgYWcuSzJCMV90hhpqzkfOyuVPvhb7X5qcRk1zCJxA5m?=
 =?us-ascii?Q?Vj0WpUeyXNJ7wcaMyXwvVT7QdaRryzs+10rW6nKWijpaNbxoOKMN7vxu4BsN?=
 =?us-ascii?Q?/drnCOOaXETzqncCObaVvX1pnqSnYH34bYbtxG/G/OlWIowUNkh4Gah82ZFz?=
 =?us-ascii?Q?MgVpFDTf0H4IkI/fgXzAgvq968HKHrAVSjRbvcjYWYYJ2iAKfgsb6wNqOetu?=
 =?us-ascii?Q?OgQ1uFyC58Bv167lgRtgVzRWwbR9c1I7709VeHDzpsrUQMGra/5c/MmkD8c1?=
 =?us-ascii?Q?2t9Bb/d3/pGUUZj26Ecqn/dh+T4c4ZzX2cDygVL4f0W/2HuJX+bpq7/Xy0eF?=
 =?us-ascii?Q?bvDbmTu63qLNbhKUqyx51Xy2um/iLzIFb7vuMf6zSJdguhbDfF5QNm+fW0AB?=
 =?us-ascii?Q?Zh4/mWHRrYKuwJ/CU/2AzsVoJW8fQ2ePji6h0UIs5jZQtlV8MpEz4Ild57Ff?=
 =?us-ascii?Q?e2OgSdxuUH8mrX2ms/l7xabNnj2wzh46AcJm3nEHSRstCvSF1AGuOx85nDZM?=
 =?us-ascii?Q?Ul7UGga0Ds6rvlTTvHkrhM9unHspeJWZoGmTpKERiqMuxkdRre58RUufBnn3?=
 =?us-ascii?Q?4L5adTC3uktQiVWcLe2LPSRsXjatwMLxo8RdK6CrqPevn5AWqJKR1PBVFoDU?=
 =?us-ascii?Q?+jTj17f0+j2PP+MWGygew7Cb7WGUZQ1CsPHVujC/T+1V999VSzRpbNNdcdCQ?=
 =?us-ascii?Q?JJ6d/1EZtUUB2N4WDZg37vu6ymjonVcxqF5FQfGe1Q5LXUxzt6gJDbjTtnoM?=
 =?us-ascii?Q?XeFZS1Gaf/Vx6jJZZ5AWJE1RepGyptfID/d9b5HbuRdsLv3kolKkYTTmqGiB?=
 =?us-ascii?Q?T4YTfLEDuKMAQePEwIbtR4x6obmSlFJ/s8cT15C0jJ+tEOl9WHHNgXE9jGOV?=
 =?us-ascii?Q?toI4fd2TrHVh3MC9NRA3rMLKUp/174/Xy9pxbB4PSuYrfgbwIsWAvhJ91X2N?=
 =?us-ascii?Q?63TyeS0+b+GgLFVUXo8=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b10faef4-dfbf-459e-7e12-08d9f72e3e33
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2022 00:40:23.5628
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tVfjSa+GCc3mchc93wf0Fxz2W5QpC/Ek/+hQ1K29vQm9zCYaUWnsvk3gbaVBhnTX
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB2548
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Feb 22, 2022 at 09:42:49PM -0500, yanjun.zhu@linux.dev wrote:
> From: Zhu Yanjun <yanjun.zhu@linux.dev>
> 
> The member variable net_type already exists. Now it is used
> to check network type. As such, the variable saddr is redundant.
> So it is removed.
> 
> The union irdma_sockaddr is used in several functions. So it is
> moved into header file.
> 
> Zhu Yanjun (3):
>   RDMA/irdma: Use net_type to check network type
>   RDMA/irdma: Remove the unnecessary variable saddr
>   RDMA/irdma: Move union irdma_sockaddr to header file

Applied to for-next, thanks

Jason
