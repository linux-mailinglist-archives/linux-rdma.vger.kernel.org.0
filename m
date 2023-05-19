Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 495D0709C05
	for <lists+linux-rdma@lfdr.de>; Fri, 19 May 2023 18:07:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229650AbjESQHf (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 19 May 2023 12:07:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229569AbjESQHe (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 19 May 2023 12:07:34 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2065.outbound.protection.outlook.com [40.107.94.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54D071AB
        for <linux-rdma@vger.kernel.org>; Fri, 19 May 2023 09:07:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f/kdykhUBLOrklPDL/COoSfrhU6QTtXWahrs4BDadkYxYzwEUxnPMseb3wxFpSDzxGNF6d8XKzC5Bo2EvwLvcjuEpRt7pyPThqxMrSrIMdJcbCMoapK/naLSgEO5g9MjfS5waF15Y6FIv3FjIR/2rIon/YaXbeB014sqGqLwXAXavOMiI2cqxkqS8t3MFOBJvc7zdpR1QiQxN4WT8naVpD0wW34xD1UnTiBE23yzrfOtbqs4bX3KAiot26Diy2dkxR+4k8NBz4+751l+nPwre5138BY8Z/5Nh3JARYVq+9r0b8LaA8EGPwm3iQQGQfYZmgWBjg4izWG/PCWJoaA8MA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tcW50+FX5xK0vqiyl/bddFY8Az1NY4ZMjosIUJ6hXJM=;
 b=Lb0LH1Adt4Y2Xt4SyMw8Kw9duXX8PZZNnUb+civz3iWX41z7GzTF6uObZOLjchVsZLK88lCyD1+0xL7SkjNDenJ/JdxxJSxD3bQnNT+M1bUc9ZXt5nv2L2BCxYJn0PgNkJ4VBUrWdu00tF22uVYg5Fw4wJ4Is5CmAR+iWOCM/WKVn0CqtEnG2pLBmZehwLZeOjYbQ91fpHVtIAnoOV7YPcxY8wHqj0dkwxGxix/SSO8I9bW+5q/+Ku0IOMA1CEXioC+7X4FXHRLyaxikmBbJWGrsIXFEd+ZOQJfVGufFN8nDLI0MAi9dfjhOMDyh/kJ/C6vz3Cq5QOIRgJjtFmuOIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tcW50+FX5xK0vqiyl/bddFY8Az1NY4ZMjosIUJ6hXJM=;
 b=rKtyFATk+ZF7HgqcRs0JwYqUSdbTzJEpX8tKUc+iCsZFN/t6fd9foguPCMcHXxQOgMXyO9V7PSyC1zS8DkhIRxfMf7ejwKDmj2o1iR623NsE8B8LJ4LyN2M0f3H8iVyEaDM6mN6vogtSZomI6i76vDlD17LlX8ivLKtsUN6rFVGYOOc7Dh7W7uM5ExCYJjDsWy8Ejl1GCazTJYHyDfnye1rtXKRrKUyRfRIqCEpZpFbg5s5c4OUzDm/SENqHy8f/nO7TjT8Q8WGKcJq3MvGLt9YFTbhdUB3oZLfJuWKZF4h6Yjpl2Be9mUH2+FZ/XkihwSgYOCFQC7f2RPoiK4nnvw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by IA0PR12MB8973.namprd12.prod.outlook.com (2603:10b6:208:48e::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.21; Fri, 19 May
 2023 16:07:27 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f7a7:a561:87e9:5fab]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f7a7:a561:87e9:5fab%6]) with mapi id 15.20.6411.021; Fri, 19 May 2023
 16:07:27 +0000
Date:   Fri, 19 May 2023 13:07:26 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Daisuke Matsuda <matsuda-daisuke@fujitsu.com>
Cc:     linux-rdma@vger.kernel.org, rpearsonhpe@gmail.com,
        leonro@nvidia.com, zyjzyj2000@gmail.com
Subject: Re: [PATCH jgg-for-next] RDMA/rxe: Fix comments about removed
 tasklets
Message-ID: <ZGeevkP9GLma/wJm@nvidia.com>
References: <20230518070027.942715-1-matsuda-daisuke@fujitsu.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230518070027.942715-1-matsuda-daisuke@fujitsu.com>
X-ClientProxiedBy: MN2PR13CA0006.namprd13.prod.outlook.com
 (2603:10b6:208:160::19) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|IA0PR12MB8973:EE_
X-MS-Office365-Filtering-Correlation-Id: 8f7e37a2-1848-4f9d-afdc-08db588323f4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: r3RDWWc4BenoUEZBrYRfR5BDD66PPaSsOopvS5pbZmtodqXASQ4qedqcd/oPDk30YfeX4dVIjjDw9PtUYgFwOML2N+iT5Y0+OucRzxzXQvn2GxIWleYq3PkGSFToPVsqodR3JUHwRmp6sI3gcY9caOIWUKfvFwgUebqC34G3nsPkqwOtP12nGsqSO2YbYeV3IgW3d4gHjPAhHfhut8aIUQ9DjuiEubJQs6GnRrc+6NgYFOwzyOq57h1VPFPGT8YrlpZHkvu9YrCz5BkjWFSvW0CXOvgGLims6NETBCkR8vvp97pWqjlK+UVciiuFBlY/Y4RML+n1lLyr4Qv0XjQTEv9vQqPpdDLNpL1XEKFQoaUcxVpd7pcq7bDDQM6VVJjKy4DYr4ktrb4sopcgJ8EcTzPPq2i9dgvLtTUrsZGXxg/KS8J/ds8U/ypxV39Zw2mU4/U0fUrc3TLa/BpPyaqTSRo/bkacUWfPylnIJoTxChfVAxK0+YYpnPFiVOfaZT6FDPUNWfuR79SFJKKmCXuWQRH0ilExtRGTuAjVZ8t3EXMXDEKqxhbKwN0deH9W4NWn
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(136003)(366004)(396003)(346002)(376002)(451199021)(66556008)(66946007)(6916009)(4326008)(66476007)(8936002)(8676002)(478600001)(316002)(41300700001)(6486002)(2906002)(86362001)(4744005)(6506007)(6512007)(26005)(36756003)(186003)(38100700002)(5660300002)(2616005)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?gwGUxZ06fhMsT6yfhCadBOD//Sxt9WBxpaNiOLE9ApgWRen8dCignx+VQqGP?=
 =?us-ascii?Q?qIi3vnwo1gLW6jvdC1PUE4dTBOJBL82SNNXPaETptOkZsew1IS3Sh3cdKACL?=
 =?us-ascii?Q?y+8VP1eUWYhUHEH9rZx+j/Q4htvI+bLaE5DO7aqhDywsE0ltXa77eW6cEFEn?=
 =?us-ascii?Q?Ijh8wQXNoeYdbt0ooNRgV9nulncaEoCS7z6KaXbB1NhZMu/bUKBKByvaXCL4?=
 =?us-ascii?Q?lKaqCkMiPw//OGAWQQmd0O5iM5YhZWnZIdfDUA5PpLbFjGYY5w9KnHNWBpB3?=
 =?us-ascii?Q?RVCEAF2h1B6QGU4J+d2MJo9lm6y6VOnyDQDerR0nuIYxcOLKWa4ikhJip8Ze?=
 =?us-ascii?Q?sTLH/HbopMQrq6Y2EV/UDjutqdQLldigfbbREVmqs0O9Abt1v5yvJTLusXqO?=
 =?us-ascii?Q?TCFfjrJIWXE8rVnKSrG6USRuEBgQ7LB9oKMda+lSbIRki5h0pxtJ8IkF9xlR?=
 =?us-ascii?Q?coObxDAaiEft9w1GSVAIUxAgscTN+zaBFc+/XWyASdqtx+fTNxVGsp5ogHUm?=
 =?us-ascii?Q?zm2E+3PcEvRLdXK0GXnRqwqrBxhAT8fB4JkFYeyFEr9xPBMv5lMvzf7s9pCM?=
 =?us-ascii?Q?91QEL4HltrV7x/P1wLMk22qwGRu50gXZIf/0MPYL3HwugF2XCZ3fQB2yhTKd?=
 =?us-ascii?Q?D0jNEc806UVQxD15cRwL5po0/wokwckZTYtpRwkmkFq7p33TtRGwVm4l2vCA?=
 =?us-ascii?Q?xYUhjfJuI5jcbDyvI/GIfjyRj3y1rwGXIMb0lYKLoBft8ic1tWdHhgARwHTg?=
 =?us-ascii?Q?Rze80tLIGDxTcU/aIaOhxNqQhTOeQYSW1S6Vmaer8twvvPh0epIm0D3YZn5d?=
 =?us-ascii?Q?wU7ziecPak0N2gNXHvE0D1buc/y2vytsXjPt/Xbm+/r3tL6DFbUDxRhhReHD?=
 =?us-ascii?Q?3Aqv2d0QN6tnWk9a9+Y9Vp0w1YIICZ0fDXsH+fpIXqWqQ/0oQCnxdIyqKAnq?=
 =?us-ascii?Q?uumOCna2fI3wNNjYaQfp8d0I0f5BUA9vOHHfMKgBd1ARcBYAIT/4r4mKqb23?=
 =?us-ascii?Q?6WzlTqT7sv7p+FbI/NiBs9lCE/0ALeP1xrA3/jbLGwoq1lQY/JrinA6m1ksY?=
 =?us-ascii?Q?PeLnrs5Dbix5yD7TfjloZs1sNhiqf2ZXhzbUa53V3YyZonhAm+NMBEtNVllT?=
 =?us-ascii?Q?LPAefBHNETKUytFW1/5FIv884JEzdc41BwMIS6UeqP5rdfamFMGW94lzQUUw?=
 =?us-ascii?Q?ITj1ytwi68RgemW0wnzp+CEZt3ubO6nEHclzp6Qj8yaga9dFAK+wxuSnRhwp?=
 =?us-ascii?Q?7CSxQ0KILIinGnZ+7xSKIqLUvLB1Zp4fL/+7dHRI6GwUUX7TwU8EshKL5ugJ?=
 =?us-ascii?Q?UJv+mZ4K7c1gCanBBadjGI6aE8uS28mLw2f1N0UgNz9RC4f4ue4cnelBvdep?=
 =?us-ascii?Q?LrljUuFrRa09wEu7uZj3tnEoDyWU102SjVeOSfvqtSULOBPjzr5CTk07UFYp?=
 =?us-ascii?Q?WwhOxyW643aCm6gL4WkimHCqYqBDA/LbsmVEymZupZLPOvDq+YsvG1d9HU2h?=
 =?us-ascii?Q?yOWFv1isAiNBQc186btXEtpha9t1UeEAw1HrydACCysmW607YJU4UGvv4fsN?=
 =?us-ascii?Q?rIyhW2U6XY4PKfkn18f4cItN12VA4oUlqcVu0CQQ?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f7e37a2-1848-4f9d-afdc-08db588323f4
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2023 16:07:27.1473
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UYkMWccvzr5TNOo/2DLKcMXfKvOTX0gaxwwzhu9OOQN3HQgrEUBmf/3myfWdMAc5
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8973
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, May 18, 2023 at 04:00:27PM +0900, Daisuke Matsuda wrote:
> The commit 9b4b7c1f9f54 ("RDMA/rxe: Add workqueue support for rxe tasks")
> removed tasklets and replaced them with a workqueue, but relevant comments
> are still remaining in the source code.
> 
> Fixes: 9b4b7c1f9f54 ("RDMA/rxe: Add workqueue support for rxe tasks")
> Signed-off-by: Daisuke Matsuda <matsuda-daisuke@fujitsu.com>
> Reviewed-by: Bob Pearson <rpearsonhpe@gmail.com>
> Acked-by: Zhu Yanjun <zyjzyj2000@gmail.com>
> ---
>  drivers/infiniband/sw/rxe/rxe_comp.c  | 2 +-
>  drivers/infiniband/sw/rxe/rxe_param.h | 2 +-
>  drivers/infiniband/sw/rxe/rxe_req.c   | 2 +-
>  drivers/infiniband/sw/rxe/rxe_resp.c  | 2 +-
>  4 files changed, 4 insertions(+), 4 deletions(-)

Applied to for-next, thanks

Jason
