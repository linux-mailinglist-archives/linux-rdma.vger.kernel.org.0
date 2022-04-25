Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B84150E9C9
	for <lists+linux-rdma@lfdr.de>; Mon, 25 Apr 2022 21:53:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233020AbiDYT41 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 25 Apr 2022 15:56:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234273AbiDYT40 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 25 Apr 2022 15:56:26 -0400
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam07on2056.outbound.protection.outlook.com [40.107.95.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95BDE52B2D
        for <linux-rdma@vger.kernel.org>; Mon, 25 Apr 2022 12:53:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TQZpIvvdqRsGSkO5BgHY36uKc8zFJjQZBHYRFrTyPx+O4BrhwS5auhuo40Zb78o0wjTUEGJ1RLeRE19ZGvrjRfpEEIRcgu0YqvJRNmeB5/12VsjNmkhOpvMqaJZE5weg9JHdkgSFs6a1C67gGlRUp/ECBTbJI19Ab7H7ZAlN8K1Tqk2HKolebVg9LKv/Njj8RgV07PQEkLm8mo36r8ZuoUokL/+qne79EAozPf3uI2W/OkCfTTUTLC3G/+JVyi7vJsWYvCv/FOWZIScEHaRmS/f+o0Dg01UudlC5cJgnWFL/m+/ZN8DH/If35xw2rlwkXbJ6PhhliiGlUCcQ2HGrUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WAOKZqgH2eNOpDC8bQeNd+9h3FoX3H0WhcV2twOun1s=;
 b=hh+RgLW1TWl7ZQ3Pu9QfpoJ+bCWKEpmfjXAEkmotn6p1lywnAs9IeAqCrzdQJGSZllj8GIX6As7iUU2THiK0QwVRxzI6Xw0f1lwnwlQ4EAWfRGQmM25RWbb1yzDZEmMEtFmS1q0POsHEFFnOM7hUwDqj/OXBkPVp5CJiGWUvrpQDzqNNjOthmuahl+nr8MqYQqlkySO/mB0s4iOHGjm5ZcRVmqhSefcoW9R9P9Gk3hoWxxpL5kkX7bTEEGp4F6wacwCIR9Z6CFlLiY9w6wuAlUiZe4+hQPNIj6wN+zE4j0NtwTOTUklqctQAPcJPCLm/MmMY1tQNMvso8cU5owFs0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WAOKZqgH2eNOpDC8bQeNd+9h3FoX3H0WhcV2twOun1s=;
 b=MhGkWYcprI5uMr6MFm/7Z0XZUCiHYY4uCnMx4ynqKAPQ69Nc8SpX92ib0lthyeOzfgecOqFCZBbon/L379uIpYbmNwTQsNsCx1YteV/V7N6wTjVVBJbvmjNG3GEH1z0GRjAUtcMoZ/OCcnXBdK/GpIuPQiS+Fr0qHwGx48V62anlaQcc+1XqCC9R0EBhU3URKR5MJVaP7lpArnub/LlModwhwijQ34zb0GgIvQcs0UABcjvCaqQS1CifvQ0P7PS6u2uhVjbasmkaapXHQRYJMeS1aEuPIXw/KaKiFmHZyVHbK9/pyfSHi3Ogr9ML/uLrk7uw8lLTqwLgaZodTFZwow==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
 by BYAPR12MB3335.namprd12.prod.outlook.com (2603:10b6:a03:dd::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.13; Mon, 25 Apr
 2022 19:53:19 +0000
Received: from MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::ec2d:9167:1b47:2db2]) by MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::ec2d:9167:1b47:2db2%6]) with mapi id 15.20.5186.021; Mon, 25 Apr 2022
 19:53:19 +0000
Date:   Mon, 25 Apr 2022 16:53:18 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Cc:     Leon Romanovsky <leon@kernel.org>,
        OFED mailing list <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH v2] RDMA/core: Avoid flush_workqueue(system_unbound_wq)
 usage
Message-ID: <20220425195318.GB2255698@nvidia.com>
References: <0fadd34b-21cf-3a0d-a494-bde7b8dbc3ed@I-love.SAKURA.ne.jp>
 <20220419210134.GO64706@ziepe.ca>
 <252cefb0-a400-83f6-2032-333d69f52c1b@I-love.SAKURA.ne.jp>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <252cefb0-a400-83f6-2032-333d69f52c1b@I-love.SAKURA.ne.jp>
X-ClientProxiedBy: BL0PR02CA0075.namprd02.prod.outlook.com
 (2603:10b6:208:51::16) To MN2PR12MB4192.namprd12.prod.outlook.com
 (2603:10b6:208:1d5::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0b82ab7c-d1a9-4ff5-1971-08da26f53f0e
X-MS-TrafficTypeDiagnostic: BYAPR12MB3335:EE_
X-Microsoft-Antispam-PRVS: <BYAPR12MB3335728C7B513EA0FCDF454AC2F89@BYAPR12MB3335.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UQpEBz70Y/g/YomBiuspB+8384anOcqWpzLMIeORmm9ZznRT2g71DfwhzYRbfUaw9ONGbJthe/aiLrlK1pNSjsDElKIy0gbPzCvn2EG9xNu/EIVPDNjm3eXz47H/wY0fDeGWHxxyXKWhDl9VSflyV9x2k2WEUbNaGgww1FuJk+XHmSLXiNHTGdBh7teysU3oH6nY6bj4hSisgDTXRtrxR7bnRPavT8izSKbqHBtkg5gJh07mYO3DjPpA/Py2U2Bn0rNayaRxGW9R8swNjWVy+4wxb/Jb8rkh0M8Exxo9kxp0OiWBbu+6acSPlgYbsDqYVVaM2gBiyvbCI36BOMZ4DVT+sA7823P11YUmbvc5Aadlo3Tdm2FVNIGr5Oc1mKELEBpxzcJ9BIj9YBQ1ZzmXoFt0yvn26vPUqmDWNSlmCVPbxs99+Yg1cRAo/siX39fSc1SprR8FoHD261DGxgwaz5BgSXwLs0hIH/TPzwXFNTUuJ1DLMjYdMMZdv0krEnwqIU3yr5vr6h+ucTA72CI2HbxaPuUqi2FqFal4vmeAKY5L1CxaHiqClVWEWsS2L9gylVZ2qmZ8dN1s6mMdY7LDcJzK1z+XLOQacjr5qXl20doY2f8EtE84+vEXlI3EyFIeEe2IqfxPh27psgaEaZqaHcyn8hJNBEnDhHJg3svJwVU+LRDhZh9jauYY6noK3PE7W3g6GWWc7a3jtw2gF8CuGebwYL7A/FjnUpuMi8jZx5k=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4192.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(66556008)(86362001)(66476007)(5660300002)(4326008)(66946007)(2616005)(83380400001)(1076003)(186003)(38100700002)(8936002)(316002)(6486002)(966005)(36756003)(26005)(508600001)(8676002)(2906002)(6916009)(54906003)(6512007)(33656002)(4744005)(53546011)(6506007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?l6i1b0Qxnx4WjbRUDoZnHaS86+urqav4O3ktbAWINZJl6tHGgeUoiQJLqa8c?=
 =?us-ascii?Q?vfRBm/uzCsKcc9JWnVHXx+lxP6xQn+nqMMrt2b3vnGBnTUA9MXqIBLMCa0zf?=
 =?us-ascii?Q?7XsnLHSNh7LKaim0TFlXEmSy2sCIr7HWuc4BLxI4iXg3URQasMUqKF8OtMjt?=
 =?us-ascii?Q?OaCej8IWNI2PKm3oFITAxEwer6lsApeeOONsM0Qk1Gna4rn55LVOB715eaAn?=
 =?us-ascii?Q?b2WhZvmatgIR44MbdI0CrdrO6dXiDVxJH/uWakavsMbS6rZYPgdblzced4t9?=
 =?us-ascii?Q?CBjA/UYbQKcTH3bH+cHrVftHwipQ5vRSkUPCJexFtlAHqnDka+KsrY1VoD0W?=
 =?us-ascii?Q?kPEbVQ4pXnZwsiujQRhZNQzQcL6tcyVE17k4sPp7cUjUjzwEmRDk+cpKzvij?=
 =?us-ascii?Q?gFlA5woPOEXJnOeTpathS283JEGDEUDXr8oUcirAG9QUikkjvKc8iCoqzqz2?=
 =?us-ascii?Q?FeV+Hhjn8XlFBH4/Gb3EEqBrRxaxgEEgQzuDIn2jXZkRTwI38asaQiKP/dm+?=
 =?us-ascii?Q?AfscqWYsxFxgrT6Svlw+8HyTReUwXOCC/Z1HjTetzbZQPHHfQivcSTYu8VJL?=
 =?us-ascii?Q?c4Yz1C7/EgM0qqhJ4LZXpVPUiLXXw6slDZ4gUHrHNcqwjT0zNEzeWZjfyEXF?=
 =?us-ascii?Q?8xLHHLbgpWeoAPIIWzp9cFPm2cWANG4tuwmUSFzpo5yqAoZKJQoXZENRBbYl?=
 =?us-ascii?Q?nOhaQi3f73UUkiZBmR4CAMkYDw1+cUIxQAVYbE6hX+AZ/prRZyHZeoTiHGRm?=
 =?us-ascii?Q?kust26wgxP/UPOOpqT1JCsbS7lJpe6hA193GgvEgFTTvc6MADUmRopqXZm97?=
 =?us-ascii?Q?bOj2dQUpIhcGqz9fT3hvkDwr2vzPecW1CkIGEI2ttyNxe+5Gd7sRoCXYQQA9?=
 =?us-ascii?Q?bz/WFtlv7uN0ih14ywcGgxQkI8TM8txPLAEef8cWfdxEASyg24ZH67SMyLyS?=
 =?us-ascii?Q?vP9/OGHCG3XGadU59mShSE/RdGWEIswgz6CGe2hBS0nUfUTZbn8vzJMGAc3T?=
 =?us-ascii?Q?mlzj8cPfFroOTEx2pJsE8c6M3AW8jmOTn+EP2m6Ww1CaWXHx3nbBekUI7mUa?=
 =?us-ascii?Q?9g5Tc7aIlhKwQblEzfxKGl8mn10q5VXbjD2ssuEWMioTzt/qNCLKSfg0u1zU?=
 =?us-ascii?Q?ptXG/1IFTtYQMm7dlXyjjG/iM75yNteUAx4w+9FcxzeGH+7XPzw/qsaQX1Z7?=
 =?us-ascii?Q?kz9XG1VEjg4jixLBJYiNdnIx+cS6qij25ZZBwYPRzwG0T8Kg05Z45gc7+wQ1?=
 =?us-ascii?Q?ZcjeZdd3p5cebwWU2K9I67fhnfIb0BWn5EP2KtJ7NOStseJIz2a+tvvmsnQa?=
 =?us-ascii?Q?FQWyZwZVz3MgCbSGS7LpX46HVFyZAW8ZVkhcOH3A/rZO/I8cviXeJzzbNH0Y?=
 =?us-ascii?Q?QDLLLAHXXTS34BNPGR3nFkSToLa7+NTsFE8adHoGYNXpeFS7ikvXAYJa9EfQ?=
 =?us-ascii?Q?qgrrUZ4v3QQBLnuu2SJjYJV3CkiuPSbuYqEa621JiMAakrXmoUK5IrqvWa5y?=
 =?us-ascii?Q?5Mkftaqx13b/VgV6uhQ6nxrYNFf8ITy5DBcflvj0az6uu6rxIUJcij9h5FvM?=
 =?us-ascii?Q?vNPqWCrHNniJlEoyKsug4jiELayWc00DVOiUu1kA/ohu4XxDiFZNcPOP0zn/?=
 =?us-ascii?Q?oC98RHXWgPNkja7tCd94wonrXAtelfaRBBRQBQqNIUqna6wcABV886H23cSt?=
 =?us-ascii?Q?lpJON1GVbreYVD0Web16RKqEy7Y5GNJKrwpNq82nbOETaOO4OYQmDr6wGOk4?=
 =?us-ascii?Q?zeTdI+29rA=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b82ab7c-d1a9-4ff5-1971-08da26f53f0e
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2022 19:53:19.4484
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 01G3RcLRxe8g533gcXxyzCZbmpccROkgx+rV9dwDKppyZIOh84qAF0R3b7juG7wJ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3335
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


> >From 731f7f167a95946cac52da6cf5964a2904a9164c Mon Sep 17 00:00:00 2001
> From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
> Date: Wed, 20 Apr 2022 07:10:50 +0900
> Subject: [PATCH v2] RDMA/core: Avoid flush_workqueue(system_unbound_wq) usage
> 
> Flushing system-wide workqueues is dangerous and will be forbidden.
> Replace system_unbound_wq with local ib_unbound_wq.
> 
> Link: https://lkml.kernel.org/r/49925af7-78a8-a3dd-bce6-cfc02e1a9236@I-love.SAKURA.ne.jp
> Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
> Changes in v2:
>   Need to use local ib_unbound_wq only when unloading, pointed by Jason Gunthorpe <jgg@ziepe.ca>.
> 
>  drivers/infiniband/core/device.c | 24 ++++++++++++++----------
>  1 file changed, 14 insertions(+), 10 deletions(-)

I renamed it to ib_unreg_wq but otherwise applied, thanks

Jason
