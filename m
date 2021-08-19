Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 368F33F1A49
	for <lists+linux-rdma@lfdr.de>; Thu, 19 Aug 2021 15:23:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239995AbhHSNY0 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 19 Aug 2021 09:24:26 -0400
Received: from mail-mw2nam10on2054.outbound.protection.outlook.com ([40.107.94.54]:1504
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S239910AbhHSNYZ (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 19 Aug 2021 09:24:25 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FaGxBHYJ7nA0bRqM1YtEar5cq2Cdc/Eq1ch/iaVWKg9oSzWihzGbxQ5Rc/AqBTx0mzWaOTazl+lMGzJwQhaE3oPMMErqZFS5YTBtum/2kLNWPCHKlNbFKDA79CFIp81E5UOQWThZIDUQttsPNg74f0Xf5SKiUYnxxjRA9LG1955rdYI8OUPrM2+N6+NYaBIHxUf102T3wSAUQD+++x4HPhI/f6EKMGM9d89ufrClyU5unaQhbTd2clMCGrROSQam4rk/juj/8k3HIvbSffYL/4JqEVl7evGEWQejR06gqQEXOyVKuVvMOHmwRRJqElGeUSEQdmIWjIhZ8+0yUKPi6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cV8e3QKFXoXwwVYEJ+tvACitliGnM5SRq7TwebCwgsI=;
 b=Sw6nCzG7ZQZZsKK4Lh2SVwuUJlh77oxd4hwK/cI8Lvesaf4lMSep37Iifv8bCGOVwBGUf5A7niSobQ45tl+6sxUOUM+osMynLOnt7/8/sMRM4njYLQgzuYFDsMCUlt0hsKquNHhgjuzJnxFs4Ea90ngNWDL1YqH2mf5Ybf1XrMzKemlUo1hKe9Iy9s4uF4eJ+qTEvkv5sjqmLdjmq8bCgn2Zi+6hKOlY3LGZtpPLSZ/kMX+dJVyY+UVEg0gQOKZ7MURHYva1FJ+955IvSzQ/GEzaUqAGZijCe9R2SBKMq6z6G3c2c5e1k4QZ07UqL5ARlLLW5uSHW3VlyDGpPta9rg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cV8e3QKFXoXwwVYEJ+tvACitliGnM5SRq7TwebCwgsI=;
 b=QNIhiePrGaMdA/tbzLuhXdlMi19e4puWl3HYpqZrQ2yqWjt10ScmotE9jgoA2cxSmKgOtgAGI1dj5/DZnXhGfWBDiGvUr4UWC8am9w9XH7tq99sPDNrqBxUq1YVE+OF2979siBfEV5dtYbLzGSHAj6PvLjab7mhn5f3xBxIMd8zbsw1YrFcGwPXN+mu6zb3sRxiDaf65piYS1+E2s6qS+N2hFALm416Xt/gImeElLeX7H4T6SZ4XkeFL/C7hmfgrY0/CUWOkC/sXpafxbeh2XkXXwrvjXog4vLCGnCHJgjMJMTcpDvCuBNmGsLcgygaxHjC/Tjup3G3i11mroAPZlQ==
Authentication-Results: broadcom.com; dkim=none (message not signed)
 header.d=none;broadcom.com; dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL0PR12MB5538.namprd12.prod.outlook.com (2603:10b6:208:1c9::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.19; Thu, 19 Aug
 2021 13:23:48 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::1de1:52a9:cf66:f336]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::1de1:52a9:cf66:f336%8]) with mapi id 15.20.4436.019; Thu, 19 Aug 2021
 13:23:48 +0000
Date:   Thu, 19 Aug 2021 10:23:46 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Selvin Xavier <selvin.xavier@broadcom.com>
Cc:     dledford@redhat.com, linux-rdma@vger.kernel.org
Subject: Re: [PATCH rdma-rc v2 1/3] RDMA/bnxt_re: Disable atomic support on
 VFs
Message-ID: <20210819132346.GA279235@nvidia.com>
References: <1629343553-5843-1-git-send-email-selvin.xavier@broadcom.com>
 <1629343553-5843-2-git-send-email-selvin.xavier@broadcom.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1629343553-5843-2-git-send-email-selvin.xavier@broadcom.com>
X-ClientProxiedBy: CH0PR03CA0410.namprd03.prod.outlook.com
 (2603:10b6:610:11b::22) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (206.223.160.26) by CH0PR03CA0410.namprd03.prod.outlook.com (2603:10b6:610:11b::22) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.19 via Frontend Transport; Thu, 19 Aug 2021 13:23:48 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1mGi1K-001Aez-LQ; Thu, 19 Aug 2021 10:23:46 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 34f49f47-65b8-414b-8888-08d9631493e5
X-MS-TrafficTypeDiagnostic: BL0PR12MB5538:
X-Microsoft-Antispam-PRVS: <BL0PR12MB5538E8D461C67A2B4C09F3ACC2C09@BL0PR12MB5538.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dKalwdMP5oIjw1lMh5w+La2KrDTW7K+7dFmvIeGRB6LJVVn+h64quozp9lNPnNGO9QeuP5OgmaAJhFLibyOtBwWJaT4tCBayEnUAk1xO3gsKkoeQSEtrStuxlgVrM64QgFZrceHydD4GZqdFJuv+xKcI2v8HLOO2r6p7awANOZvLICJy6mV82Yln4gNItaYgtp6H29sL2W58xIxeRFVvnw/EELOlsP3hr+EaVk66NngKUcxMUCF2Q2qiaQAapi9nLCwqyheOzl7VKz9H9tsASH8XRyNnWWlgxjZcCfz8d7ZUfVfZSUCrazHVNV5LkB1+XZ83MNmRLGpzrxERRufcjNVz+tRZE1IqcCYQGUeOsNU1d2RAGWEgRb7QGV23zCV2gf2Z/VxlfPhVQ7xzD0tZT2lDpy8gj/jouf1V+BHNO4XSIGM3xz3+hgAK2duf62imaIGHLOXUyRYZBFUqmEcnwBNSagf5MZjyGQO3u/nWw+A81QVuquZmCoNfTV8SeJrBmQvmQesUSTxsaP/NNm+JnI6IcZznvWnRaDf4jEQAEg+Yge8sJm9AVLskhAcfG/iP6h6+Q1Ewd7PzicNqlFv5DZgPmw1F+826WNDz/uZs4V0D28HvDt724+1XMPPv2QI8jYIRpqJBAM8JsB8NGGQWVm43dbeFUP8iWYoaVE/SBQhR5VrEWRns/UqOo3Iy1M9y
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5506.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(39860400002)(396003)(346002)(376002)(366004)(36756003)(6916009)(2906002)(478600001)(66946007)(558084003)(86362001)(426003)(9786002)(66476007)(5660300002)(26005)(8936002)(9746002)(2616005)(66556008)(33656002)(38100700002)(1076003)(4326008)(316002)(186003)(8676002)(27376004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?2tBQG8HtKzK92fsDb7PAFjevgQlol99uZnU+2BDHLoB96LHb7ravej4kv2Zv?=
 =?us-ascii?Q?/z4jU3mVg+MMABDpjo4yNrCFm31H8B4eFh79P336v5txy1eI+N7oGudasfTs?=
 =?us-ascii?Q?g8rrNwuOPbJQ+rh97QMGd1dSBmg3wB8Zs5Yil5IfGrg9AC8UIEdDSp7hmIMM?=
 =?us-ascii?Q?Yr5M8EvJ+bbChZHMnFl01xlT+OTtkjcpqdjF0d5FEoC0CqLzTkXgQZ+J3ExO?=
 =?us-ascii?Q?9qo4dkJHVs5UoCxZieDhckjHtsSugs5nuUwlBPXATNZYXbClK6Gwu2st7jhi?=
 =?us-ascii?Q?xW98gupAahjiTzzqw34CvFGOiM6ZMxxXzg6fYF8ZvNJ394ArhA/gPa9XAu0i?=
 =?us-ascii?Q?8Pw14+gYiGd41Uaq5z1XX4nvfINIPbiHVpy2d0mmLZ2TlvlcX84MkpmHUYT5?=
 =?us-ascii?Q?lE3LR8+3wzj1ZG8MJJnwi8kw2qJnLoeh7TZODpTkuVcrwqTbt2hcITLmWQvw?=
 =?us-ascii?Q?f9fvZTSHaewfxSHDJOsxQSMYJtI7gEmL4IfErxcZ6reTLa/XfqCcfeDgeM1S?=
 =?us-ascii?Q?i9neIJ7g7XbquoUaxKVa7i2yTKVqdnXCpyYCRw9cgioYIQ4ue3U8LPGTdlr/?=
 =?us-ascii?Q?yycs/HDMsXkfYi8RjSzMLf6g86is4I29C0vTK1mPSzJeW9zzJqKxQBSxnh0N?=
 =?us-ascii?Q?02sFW6yIJblO8+63CFyb2ML/vXAOn9gG2GatUVg2idB43zVo1mL9Lx+4QqfQ?=
 =?us-ascii?Q?oseK/MmBGL9bG024aX1JSIfceTprPHLeWnpeWmUx8sLQ4NhMMVx1jsg/UEqO?=
 =?us-ascii?Q?UNwr5AXsrDIVEfJIiUIvr1L+obwRR8q4rvgJ6WrEFzYbTBTlFvzE8e7e0LOl?=
 =?us-ascii?Q?2ond2KRnQlo903bRNRO1G4Ac7zkLj9UNFCyjtuPLd1TZgg9+pvrGlead/FQM?=
 =?us-ascii?Q?H4Utsok9tkErJE13WlloMwD0Icm9qBR/kngtvqA1bduAA8X2QwuLUx2+Z8j5?=
 =?us-ascii?Q?cxieuxE8FiM0OM1M2o5BXARk1txaZzQTo+h+8J11ovHaMqgXRhxaGTjvXlAB?=
 =?us-ascii?Q?NVhdrh54gvwbd6eRew1/dTqkxM49IBhtJAiuNAapAJrZz1YZKPOCVUeGTQUG?=
 =?us-ascii?Q?S1tAwO80Az5dp5tFTxG/ZqL+bXT257EwLgmYSS8Q/BNGzko7BWOkGlxKqrOA?=
 =?us-ascii?Q?Qt+jYxHhrOmXnxdLyNhr5Nz/o1NOZIv+G291LchvqfUOjrC6bYjq4fOYQ9FP?=
 =?us-ascii?Q?KhGX3xX1FzkaBN+zGHZosqhMZmDOmHoQlXuCp4vSn37S7JHJyRcYPag/2hUh?=
 =?us-ascii?Q?LCEaR0swDl62hGgZRer0B5QCg8wf3ch2t4tpoSCckry+T/5WukbuSQgH6Hzp?=
 =?us-ascii?Q?n7P70fCQPMbBTQE8Cvb/FkqJ?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 34f49f47-65b8-414b-8888-08d9631493e5
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2021 13:23:48.3605
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kA6bvWllq+5kSnugMclmiOibLnEgjjhECSC4X9O9M+m9gY2flHDgvF1mk6vKPHvK
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB5538
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Aug 18, 2021 at 08:25:51PM -0700, Selvin Xavier wrote:
> Atomics is not currently supported for VFs. Enabling only
> for PFs.

Again, what is the user experience here? Does the device crash? QP
blow up?? Silently not work?

Jason
