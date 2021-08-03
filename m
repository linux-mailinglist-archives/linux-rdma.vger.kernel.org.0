Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9CBBF3DF1E5
	for <lists+linux-rdma@lfdr.de>; Tue,  3 Aug 2021 17:57:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237057AbhHCP5S (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 3 Aug 2021 11:57:18 -0400
Received: from mail-dm6nam10on2081.outbound.protection.outlook.com ([40.107.93.81]:7648
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S237196AbhHCP5R (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 3 Aug 2021 11:57:17 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hzUQpZbbwDFkTA2nsRyacq+NGy6/O8mh1uljUrPdWFokRjlSpuaSMGG/XDJnGlojVxFbJfg6qQpPfj+CYJkAUR73GtK4gSB5kqFbbI4IefxGj29XezTErnozFJZiBVVMDiPdCmfh9pyhJAxatbHHv9nwLyGD41yPL6zq2bIu6J8eGckVwgrklNst5QUxz/Z+spwug+WSXND5UfRaPc9nwlQB2Zslht0QE9C+6hAjua/um+HgVIViMGSIv3Z7pT0AxwUmXEcPBhxFbfYAWJS8jqHgQVE6bDLQglClTXlisgE76W1KoyrIN8Ssx7g/Ymg35KdXAbdahReZ441LMLf8tw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+ajtpiEiLnUMrn16PJcV0PQzMDdnOCEwTqOk9DGuu5g=;
 b=Tne571a9RB3qjLaFFGVbjYylf0AVIAQjhWmwgjUR2pytvpOsT7Dl74cPTn5/FOkhboVg9t2JRKQY0LenfkmxTG8HsrY1C3Nc0aneqZza1JY/PcI3s3ZingQpA5vrvI2BgKvmsZEh+8QNFcXhB6xRfFCW39RzZfQlb/82biT29kRMXUDtlH3P4WYIMAJ0KAMXd35kwfg3oMPqdb5zc1wSkDfMSpLCByzcV0/AT1R04d6sOpNrR43WT87c9Zezm4hV1XfBbV6bPU8HVT5YQDDe76FyennpxG2X9P+lHtPGhrgXFymSeukzjPRT8Te6T+GRG9B+XSnfaCMYpdfO1vdwEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+ajtpiEiLnUMrn16PJcV0PQzMDdnOCEwTqOk9DGuu5g=;
 b=Oi7RlAPgVz9AHTPUKnbAK29CILH1xp8m4QarXz21MD8cDPAUsfZW8Ww8YfBjr1HlpiTu199yWuJrw2Jtm2Hv6CD80RkTBn4EdAsKRpKhMC6nfLilHrt0K6gGtaFOs9htkMUeGHrmMe1+TEpv8WvMX0xbkdH7lVQVxlOiCVN1+ZQ77lutkpsd6X8Z7Jw2zz6YG7bIXvYUsNr/EdaJs+i0ykjPrGghjpgFM5LLlVZhh2CA12pAFEOY2dS6oJMaOJzz+9v1LWq1/FnjH1yanyC6rfo87gObDfvwHmsK3vGH4OlFLxuaGJAWSedLEUs5Uzydnl6bptFFqvJ2pwff5wh4qw==
Authentication-Results: cornelisnetworks.com; dkim=none (message not signed)
 header.d=none;cornelisnetworks.com; dmarc=none action=none
 header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL1PR12MB5126.namprd12.prod.outlook.com (2603:10b6:208:312::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4373.19; Tue, 3 Aug
 2021 15:57:04 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::d017:af2f:7049:5482]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::d017:af2f:7049:5482%5]) with mapi id 15.20.4373.026; Tue, 3 Aug 2021
 15:57:04 +0000
Date:   Tue, 3 Aug 2021 12:57:03 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     mike.marciniszyn@cornelisnetworks.com
Cc:     dledford@redhat.com, linux-rdma@vger.kernel.org,
        Haakon Bugge <haakon.bugge@oracle.com>,
        Chuck Lever III <chuck.lever@oracle.com>
Subject: Re: [PATCH for-rc] RDMA/cma: Revert INIT-INIT patch
Message-ID: <20210803155703.GB2886223@nvidia.com>
References: <1627583182-81330-1-git-send-email-mike.marciniszyn@cornelisnetworks.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1627583182-81330-1-git-send-email-mike.marciniszyn@cornelisnetworks.com>
X-ClientProxiedBy: MN2PR18CA0020.namprd18.prod.outlook.com
 (2603:10b6:208:23c::25) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (142.162.113.129) by MN2PR18CA0020.namprd18.prod.outlook.com (2603:10b6:208:23c::25) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4373.18 via Frontend Transport; Tue, 3 Aug 2021 15:57:04 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1mAwmt-00C6rN-20; Tue, 03 Aug 2021 12:57:03 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9de0417d-573e-46db-1ce8-08d956975694
X-MS-TrafficTypeDiagnostic: BL1PR12MB5126:
X-Microsoft-Antispam-PRVS: <BL1PR12MB51263C60CB585F61FE6931E7C2F09@BL1PR12MB5126.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nQ5QzWnctUPfNkJ6WVsh7xZ6DI56uh83q/dPXgfXsY9Vqpm+R4KQ8gZQehxekQpKebJtksaWI/ph3g7EoPrsPE0mWE31J3sSbxVKeT6i//nlIO0jGc+nwQ2kVHNDRYBnsg1SCELLJpop+KKhZZjYQtWa2u7fXUXhjCrNTq/VBvMlRzC0ziZwXAP3r7PkNRMEELHfqefMVmTkdxFWjWk3MsdR86NZcSovY3DmB+mij15CrEScxql6Ha6Le8cWH3eTyRz0TU4UTnLEy4t3OwE3pds4c6PqpboKZDDMcErp/zFOOFxF6CyjsKtf8/1R4B0MqbPlwOpyLq5jXiz8klkFiu/jMw0Em5HRa0A/01yaoDrcpVHendAQxBPo5umC+nTQ9fCzCT3GJLS9Rbi4KDC7pJ5xI4UMzQAEVzhayvTY2EAOK2PihhltcBIcRZuPbUhyUeiiQr7r55cmbsfbLmVwqTQV05TY6ExShnptyNlGl9BDOObQCxLG72MTHt45/rLA66i8ICjNb/a+7vJytCczMVRAvNmmCEE+dRId1gbd7X9EW3xpVZ6HDKkJabyFE9shv9oWSZjAmr7WOjanfujqDhAcRMs4J60fvLi+JWoEdclUc7E1Y3ZskMSkgK45xEyxXpESalkJAq264QLebXhxXw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5506.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(396003)(136003)(346002)(39860400002)(376002)(33656002)(1076003)(9746002)(8936002)(8676002)(5660300002)(4326008)(6916009)(36756003)(38100700002)(2616005)(9786002)(66476007)(426003)(66946007)(2906002)(54906003)(26005)(316002)(478600001)(83380400001)(66556008)(186003)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?wA1B0ntQy60KFJMH259mg0EIhMDu67x0AP7d4uEuD8IbJg5D7+i4fSkvctCc?=
 =?us-ascii?Q?W2oFm92eNI7uEc2ats+x3qdMrOYOJvoxP37T4WdAJzpVMvuggjNvXALN3Tzj?=
 =?us-ascii?Q?jQGX+VusQ3jI0a0jKFKiuAxrmjKwvOCd8WL8zgzDf8VbArJ0Yy8cQKFg62hc?=
 =?us-ascii?Q?XROQzSbZV58cUU+AC8VI0lrWB3oErxMo1addqRvjQ/DA1dOpNKytymlyuLSu?=
 =?us-ascii?Q?c8MY/JbQlxhjtoRFx1z4FECfPPEuX+vN9k5oo8NYQmVlhXitJKV1X1b+jrHz?=
 =?us-ascii?Q?V/iz/EyXMhgBsQ8aov0H6wM4UxUKsrPAatdVIermdZ8OP/lDTkNHYbL+LDFs?=
 =?us-ascii?Q?cQs58j0ykdbEfeM0ytvaOJ1KWnqqPz5gNMssjcc8l+kEsXjM8AHrSCM+xxEI?=
 =?us-ascii?Q?m+Rd7YAi7g8kaqqA48DTIUpWnNbDVP/w0uY2B7oSGikuVpKPLKNKMgLdHgFL?=
 =?us-ascii?Q?auTlbMPyjLES/pyvC9Exk5sdjepaGI2TbaBbcaOnvLljq98HfcNtK1RD8/mR?=
 =?us-ascii?Q?4ceW3vzI574v/MPdq1Vj45DzOfKV9avFcIqzQ+Xuurc5t7ZRukmtOEt/F41u?=
 =?us-ascii?Q?TZ7eb9YKSrpoOD3v0sBCtiY1DWX0z06oYUUtj7Pspq1GA1GM1NojeHp9cBfp?=
 =?us-ascii?Q?xpYLV9Lyn2bLUEHVBWQBkalL45Om1/kiVXz1zuviw6BVeJGcRcY9+bRpzu5T?=
 =?us-ascii?Q?/cNyhloyFKbF9WFNW1X3riEYkG+0f4CELjACn3z6LY718C24KfD4+qtgum6R?=
 =?us-ascii?Q?fpLccJVU+dzmt2EK9/5rWTczocNg4Dm7yGFV7Ldt/dSI87m6Zr+YjBD3TzpH?=
 =?us-ascii?Q?i+rhjZYBH73/S0MMwKWcpkbs/BfPLtDmRVIvF3Bb60FZiVcepfDrI6hc2leU?=
 =?us-ascii?Q?a2XLM+FpgLutFhG5StGH95GnmxKqwXs1PydLTf8AoXZmamziQvTMATfZAUK8?=
 =?us-ascii?Q?ZZadP1uC2pwuktnG9PAujiMh9Yoy/EYlBM/7kIaxNgw1X3If/Bc9FkUX6OSJ?=
 =?us-ascii?Q?woJSbvT7ljjbZggxczQsUIVThnaYSC2OlvBKp5NJp+a15nLDKjCfNlfOVk6H?=
 =?us-ascii?Q?Nd/j7S9bAxoDNCK8PmGus9wKbM8JzlegoYSqM6+FfXGwi0IOHjj57ABHCk/3?=
 =?us-ascii?Q?cD0SP0qLwBd2DDP2y/4JDYri9mfEPkzji+1vRHFX0OCmzJXapEzZubxrrWlp?=
 =?us-ascii?Q?gxl/YwAp0eWOY47gob3Vswm/GGVSQo17juhlz+rmL53DCkg80OoWioIiJPEn?=
 =?us-ascii?Q?wnHxvdnaSx4vuuA7JG5AWFDcgn0/T1jYDllhVBn6XNN32rV70GeC+zqjk/bc?=
 =?us-ascii?Q?YDGhcOu+67zZtYJeD/7u34ty?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9de0417d-573e-46db-1ce8-08d956975694
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Aug 2021 15:57:04.5568
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nGsJbvDOt4Z8mgAi7ZXux6YmxsengZW3RkWnpeE6NnH0VNz0pGs4aSGkKFomiU83
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5126
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Jul 29, 2021 at 02:26:22PM -0400, mike.marciniszyn@cornelisnetworks.com wrote:
> From: Mike Marciniszyn <mike.marciniszyn@cornelisnetworks.com>
> 
> The net/sunrpc/xprtrdma module creates its QP using rdma_create_qp() and
> immediately post receives, implicitly assuming the QP is in the INIT
> state and thus valid for ib_post_recv().
> 
> The patch noted in Fixes: removed the RESET->INIT modifiy from
> rdma_create_qp(), breaking NFS rdma for verbs providers that fail the
> ib_post_recv() for a bad state.
> 
> This situation was proven using kprobes in rvt_post_recv() and
> rvt_modify_qp(). The traces showed that the rvt_post_recv() failed before
> ANY modify QP and that the current state was RESET.
> 
> Fix by reverting the patch below.
> 
> Fixes: dc70f7c3ed34 ("RDMA/cma: Remove unnecessary INIT->INIT transition")
> Cc: Haakon Bugge <haakon.bugge@oracle.com>
> Cc: Chuck Lever III <chuck.lever@oracle.com>
> Signed-off-by: Mike Marciniszyn <mike.marciniszyn@cornelisnetworks.com>
> ---
>  drivers/infiniband/core/cma.c | 17 ++++++++++++++++-
>  1 file changed, 16 insertions(+), 1 deletion(-)

Applied to for-rc, thanks

Jason
