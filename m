Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A2EC646592
	for <lists+linux-rdma@lfdr.de>; Thu,  8 Dec 2022 01:02:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230194AbiLHACw (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 7 Dec 2022 19:02:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230249AbiLHACm (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 7 Dec 2022 19:02:42 -0500
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2040.outbound.protection.outlook.com [40.107.92.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 226108C680
        for <linux-rdma@vger.kernel.org>; Wed,  7 Dec 2022 16:02:31 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UCZiTRI7wWUbS7xcn4Nhhrd2TZUw3qIIIRVwrqylA6RQsTznFt+2LETgx8385C3pKP+Q1mNcOzba2TGZ8P+AJ20X1s1y9LxTUW4OAy8WDFpInA6cqSH/mbH+EgY6SK+1Yk/1YYOt5MQDPhrNpfVA6Wsnmr6UAf9UMzfOvnps0Qt9oAftOmbAo/KhfbkFqS5kbvmxZvGgDanSdNealyUTdS7mVxW6gFOpIfTo/+wjUNiFROlg70j5+1YNKbo/1PiktymApwJdRVhr3DODacZZb46ZCirwTBWaOuJGoIdA6SFM21LlYNhxeBmiOZhrWloTNEwsYejP+7zo17am3GNNLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CPO/Wkp3gUW+X8uXPiTa8wrnezr8F7pm88+JBwEqgiE=;
 b=E+8wLe5fa4Q3mlVvkufexLrB/jcHSyZsVMSaAcZ04d29TMtsg6xMammeD7WjWvjLwxs831hgF5d7AnrhsECNnNGETpoLmVmJoXQJ4693/fy9Nn5h3Tf9G9RsdNF8LyEVCH/xBuis6qtSfXDyRi9hx2P0C8lF7czMcNFmm56GX2eeQea++DwFKpxKpq7+evWpZIti03Q0lPJsm2ruiyALktIqmIdxP+oEAUT0ry+dYKk0gAz/ssfpTeP+VxzT05r3NZzn5D8yZVMOLbZUx3g7SYHpewK+UEDmZi6H/w4bGvkamlr0LC7sGGz+5VVJDOsig9XURTatcUpg7JoUIqrv5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CPO/Wkp3gUW+X8uXPiTa8wrnezr8F7pm88+JBwEqgiE=;
 b=Em5u4Kgude7pfHrNggbiS/2wLBou0H1S8UV6zAyAxaq1sAphmDuVS5OeoZ5g3sdxeueydfMKoiXJ3wHkmZkEXzrklWaiwheHPFK8/G7RTHwXAKD58bEaaxPrD9ARDGFL3+wKKKF6y1onS8uX4wVyV9Gul9aS4ijLLYgxRPIUaKvClKfjCgCdVX/lvjjmoFNotN862W5KWMma1sNSwwBnMLfHV8KXeTw0cMTwN/rrpgvVKxeWmybMkDqm7g4EJgXISD4kwjmkQO88UAQFszJXBgjAwGcVKKe0Gte31dbw4eodiF8Xjx7dbUhn+aIyxSux4Rr+QgJoNzeXfl1yY1a+dw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by DS0PR12MB7655.namprd12.prod.outlook.com (2603:10b6:8:11e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.14; Thu, 8 Dec
 2022 00:02:29 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f8b0:df13:5f8d:12a]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f8b0:df13:5f8d:12a%7]) with mapi id 15.20.5880.014; Thu, 8 Dec 2022
 00:02:29 +0000
Date:   Wed, 7 Dec 2022 20:02:27 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Michael Guralnik <michaelgur@nvidia.com>
Cc:     leonro@nvidia.com, linux-rdma@vger.kernel.org, maorg@nvidia.com,
        Aharon Landau <aharonl@nvidia.com>
Subject: Re: [PATCH v2 rdma-next 2/6] RDMA/mlx5: Remove explicit ODP cache
 entry
Message-ID: <Y5Epk+nLntyjxmOr@nvidia.com>
References: <20221207085752.82458-1-michaelgur@nvidia.com>
 <20221207085752.82458-3-michaelgur@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221207085752.82458-3-michaelgur@nvidia.com>
X-ClientProxiedBy: BL0PR02CA0020.namprd02.prod.outlook.com
 (2603:10b6:207:3c::33) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|DS0PR12MB7655:EE_
X-MS-Office365-Filtering-Correlation-Id: 093a2d9e-4efa-4015-b915-08dad8af7f1f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JvkMiOqlJnWBT4QY23M4P3U7hKHkV9zVrPyRD286v3Ll7TRz8AYNod15ONbPawyP7VKsde9vFm8+H8MY6hxrAWHh3xiUN53CxjXAz0/AMlbl1h5yQWIhby99EsUIqcLz1ZuENepXJK+ryROkB+dQ55LnNMIZt25OBCe32xcjIZIu1dlcZ19moWWmeSjwnqgFdLpY3DuphzXINOxFsb6JvjpFf5pKe4pNZVdNmiVRXa3PGoT464yCOmf+Jz1Zr0AnJM0fOCuV+dhfwPB+FAUGbCAp6dGcAB6B1O+bm8npj4TJkA/p6uXKbGX51mIIeST1HJwyJ4wmvKqmqzBnIKMNV/yCg6B1VfCxcJyHX5l7dR+IraiQ5xc9gqvQ68PNJEiOyW3JMO12KSlzeuBUkNLvt8W/E2bTlisea4VAVMr6vfLTp94oEHZVmn4SKMWU6fid+Vy7ZBvYy6Nvv17ZgbRHrSR5xidvgbXiUMG+uSHUCJSNe07RhTRI1Gi147uleoWvJg0yGEq3vEUWACZLAcud7jy32JTqMhU6xqwL9E8Pf/fHu5YtV4r9z5+z4QoBM3/6rnKLkXBbpkWovhp75+tIDC+xBRF5qj7nMZaqwacIupE4T5X5RnwlysLC1UCSlydVh871dvKg4M+cmM85rJosiahLtWp2x9Rguu2fixyOE6InigW3U60U8Ax124A1EAZt
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(136003)(396003)(39860400002)(366004)(346002)(451199015)(8676002)(66476007)(66556008)(4326008)(41300700001)(66946007)(8936002)(38100700002)(478600001)(316002)(186003)(26005)(36756003)(6512007)(6486002)(37006003)(6862004)(2616005)(6506007)(6636002)(86362001)(107886003)(5660300002)(83380400001)(4744005)(2906002)(67856001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?N1PiWeQGBrLEzr2kCaKI4iezxCuOflFmOVXCQztgMB0HxmAiLcwQjvaDTMmA?=
 =?us-ascii?Q?BV4ancQE7A2RZn5foT9r+Fsd+s79SjqJH/7/simU9c8pfFwvuHfrVKIQX1pu?=
 =?us-ascii?Q?U0s/+R1Xdpd1Gw2pMoNw/vOvw9+OO6MIifsSnORw2LIHrdSqC5pWVQd7uTCL?=
 =?us-ascii?Q?r+xK3/qwf4D2Z7XIkiQFE/LHUuisLUm9MFGp+wq4SrDtUnqo6Hb2y1BlJVqO?=
 =?us-ascii?Q?s+ILz4rGVS0QhKCPnN00QqYmxv14xzGh0zg7fj8Z2IgPr7tbsuVdcgtTa86E?=
 =?us-ascii?Q?1LWWoNklvmZ/3kYj3wMJTEfA6LGYNoJXbc+K37pkUfiA9dqM1yv8XSGxIdvO?=
 =?us-ascii?Q?FWI2xic9lJX8YmGLRGdfxI7UmqSN1PMc0uLnTx2hX1tCxVPrr7bbohXz+gFD?=
 =?us-ascii?Q?YapTycy2lcuO4eJs/qdcN5KWjlI+wt9kPdqThoREXjA572/ISKGeLY+wlNVh?=
 =?us-ascii?Q?fF0hDlbh5Y79xmiBSCEOhzfrS8IaZ0XzyPynYfsW9dJ7YDIinI3ViYiqmkPX?=
 =?us-ascii?Q?3F+DadhwjALhaZdfebXSu6BBEd5ZH3GuRHFdQDLNiV0qhlKYseAZUcdpQ+Ct?=
 =?us-ascii?Q?VBuZcJW9jnH6JGZjamLl5AcH4MKjtcRRkSHJCGxVyFS89AhtzjSOxm7rdn7y?=
 =?us-ascii?Q?BiHUtkUTa7Cem4iqnfu9E8oy2Qb+yjYadmzH7ZPFMRW1miKPBrRLSDMeMihk?=
 =?us-ascii?Q?L/6WbKZwLwO/P1vZIrjEo27UBBuTk0RCkEe4ln/KqG0Yoh6zG9HPzLfwPWld?=
 =?us-ascii?Q?HELTMabyLkAFxNDvIEB1MOseZr7Bbd7GJAQZOGk9nAQ+GwV8o2lEbfowv4Vm?=
 =?us-ascii?Q?C32YWBt8ZIiRp5nTPUUsre623bLvDtZyjxXN3Cwsah6UDSRMdYve5be/Tft/?=
 =?us-ascii?Q?/xWICywID0fSzdhrqV/Xa596s5q/+vV2K3RyyLQPrBFsOyym/UfsStfxmICY?=
 =?us-ascii?Q?+nTW+l0+5LwhDTyIwKGtaB5FRMqdS1hxNAXxbJhq7nHx0zYbjrWtVbPLQFH3?=
 =?us-ascii?Q?A/zJlkQLZtLb1A06WrRxGxYKiOgOPMRCWliQ2qa1kpGAvfHo6xKv1F4fOpS7?=
 =?us-ascii?Q?pp2QEPY0ELIzutz5tZNeCLCYiL7M5W9+LFzrMc4jZazUfw7qbZyEli3V51sp?=
 =?us-ascii?Q?zp6PgxFspglNV9DbDRCMPVNCV4pM9DfP9+iJPCLvaA7GcdOqrgyP/BSTyM29?=
 =?us-ascii?Q?xJbGYKZxRvJ9W9os+iuaM1XO4OR8fzCBZwn1QJt6aG2bWUet0BzfbWafygjP?=
 =?us-ascii?Q?wh1Et7J2MlLrHF3kWYbfn3eCIgxmzTfRTJM46mjtbcUxjB6ETLh/YDwInvYu?=
 =?us-ascii?Q?pMwCS9Co+KlLUxQ0bZhdmZ3Vy7Dp9c82mN97X/bGZoDyLotZIBYuizpLUW31?=
 =?us-ascii?Q?fHldpGNb85b3TqoDpUYniO1h3DHHI2CFfnHnzBaBElLRDSna+FOlTlYv0VsI?=
 =?us-ascii?Q?4O7uvGKhvUa4oZhaddbuf4VvZzM3GGNSBAYOpWULcsOvLZx+3C4oE/SI9Vhs?=
 =?us-ascii?Q?J5r8YbeBFFRcQ2FZCWCTkOk5llyqvsnq0rK6BjRPzaNQ/gM6o5bDin1Xu/yZ?=
 =?us-ascii?Q?l+OFOYGTIJsmRF4QP3I=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 093a2d9e-4efa-4015-b915-08dad8af7f1f
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Dec 2022 00:02:29.1726
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: klg8s18/mc4QqwS2GrRV9hQsuJ9N/Tkprrdp7ZFTJVcQiP6sK9e6QQlqnYPk8a7E
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7655
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Dec 07, 2022 at 10:57:48AM +0200, Michael Guralnik wrote:
> From: Aharon Landau <aharonl@nvidia.com>
> 
> Explicit ODP mkey doesn't have unique properties. There is no need to
> devote to it a special entry. Removing it.

This isn't quite true, the purpose of this entry to is to create a
cache block of order 30, which is higher than the usual max of 22

Though, I'm not really sure we should even be caching such huge MRs, I
can understand why ODP would want this cache, at least for fairly
short term.

At the end of this do we still have caching for order 30 MRs?

Also, is the MTT vs KSM access_mode UMRable?

Jason
