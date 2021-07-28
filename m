Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF5123D93DE
	for <lists+linux-rdma@lfdr.de>; Wed, 28 Jul 2021 19:05:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231186AbhG1RFt (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 28 Jul 2021 13:05:49 -0400
Received: from mail-sn1anam02on2086.outbound.protection.outlook.com ([40.107.96.86]:48739
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231231AbhG1RFp (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 28 Jul 2021 13:05:45 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=afGUQCCOU/ASKl6CZx8RwgfwGoObwZYeWhvTlhZnH9eCr38L+/s5rqIADauBQbDhTXXXz93ZWFr4POhP1kdsDKsfdkgBVOsEMn4xTnIfVWQOwNCVZLIsF3adM6wWtxGQN9H1JZURZnzsMesOYyAEuJp8+uTkv8GwjeFpnXE3vrwIsAARYNErA/mSsBjjthELjjdqOBBWMRfAJE6pYfPWGvScwdpEQGw/KFHniaBb7IzQheD/5JCOcxNp7NFb/gRao5kcgYTOpgup0CClxi5QWsjRVE4sEv3zxWlca1QX1DDUkHLI3dbhRHo4gG8edDxKa7lfxPYRMfji6c1GUHGKSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u6KCG0sSCBcd1RsbxWkM9h+NpakRv6K2mDDqQWKpkCE=;
 b=XHpg1U+BHBjodyc56ng6Q2rrchToMqNCp+TxbwdfJfDZqPP/etBVrKF9/QCM95NB/6ZH87rcGUsA+pZPOH6jd+Fgs7pmUxKAzviKfgkSLl5FHoXVxVlzQLnOY4/3D1BrBRaxX1u687+/JDSJv3V7bu2CGaHHTocjDNTpWsX/e4HylEIppKzWBLiesste2c+JJWnJT3ARBcD8joQuRQMJY8T5pM4iBsK9SwEG2BURBg10xfmVqGyX81srD7aNvz0Y+cZSKO0OP7Mh1GpDS1hXbxIohQvyI53GjarlxnfZ9JNmC6augC6UT8g6uCvJFphBvyCOtEcjM6AWL6aIwwBDzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u6KCG0sSCBcd1RsbxWkM9h+NpakRv6K2mDDqQWKpkCE=;
 b=mE19gX6tqdCl/tlb3XzIekgyzwrAtAc+sAaNz4Ip1bJlFtPVW3jRiWJAzJsXTNvcz88B5eUWP9oXReTWk/rvljM0gGwHbqcIOXc8fU+6ZGe7gGCBo5tLNrIj2sRaWJrcJXiSmqdOh65V2QYqMSmdRhRjGsjJUbzeFAoRBVJvv8XbOEzphQ7+OOGVZl7peabHBed1y3EYbFyDFtZ06CL9udWM633ehoZN5TGIBWmfInyRvMeR8gcNU3T/VG19GtEtbIx3traVHmVpC8PBs5ieh8D3SsqOPtScuJDX1hJ3NqNSMd0DfTIKuPjqLvqpFAm+Pm8dOBJ4jENCnNqmborHOw==
Authentication-Results: cornelisnetworks.com; dkim=none (message not signed)
 header.d=none;cornelisnetworks.com; dmarc=none action=none
 header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL1PR12MB5032.namprd12.prod.outlook.com (2603:10b6:208:30a::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4373.18; Wed, 28 Jul
 2021 17:05:42 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::d017:af2f:7049:5482]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::d017:af2f:7049:5482%5]) with mapi id 15.20.4373.019; Wed, 28 Jul 2021
 17:05:42 +0000
Date:   Wed, 28 Jul 2021 14:05:40 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     "Marciniszyn, Mike" <mike.marciniszyn@cornelisnetworks.com>
Cc:     Doug Ledford <dledford@redhat.com>,
        Chuck Lever III <chuck.lever@oracle.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "Dalessandro, Dennis" <dennis.dalessandro@cornelisnetworks.com>,
        Leon Romanovsky <leonro@nvidia.com>,
        Haakon Bugge <haakon.bugge@oracle.com>
Subject: Re: NFS RDMA test failure as of 5.14-rc1
Message-ID: <20210728170540.GA2316423@nvidia.com>
References: <CH0PR01MB7153D5381BBC3D1D0F146E8AF2E99@CH0PR01MB7153.prod.exchangelabs.com>
 <CH0PR01MB715358BA093A504AED855CCBF2E99@CH0PR01MB7153.prod.exchangelabs.com>
 <CH0PR01MB71535949BACC7C43261EDAD2F2EA9@CH0PR01MB7153.prod.exchangelabs.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CH0PR01MB71535949BACC7C43261EDAD2F2EA9@CH0PR01MB7153.prod.exchangelabs.com>
X-ClientProxiedBy: CH0PR04CA0091.namprd04.prod.outlook.com
 (2603:10b6:610:75::6) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (206.223.160.26) by CH0PR04CA0091.namprd04.prod.outlook.com (2603:10b6:610:75::6) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4373.20 via Frontend Transport; Wed, 28 Jul 2021 17:05:42 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1m8n00-009icP-Nj; Wed, 28 Jul 2021 14:05:40 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b0f60e64-fb93-4daa-2223-08d951e9ee83
X-MS-TrafficTypeDiagnostic: BL1PR12MB5032:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BL1PR12MB503234048E9A6E0237045D2DC2EA9@BL1PR12MB5032.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: H0qgoJzj833IpsYIGhwR+hTmvqE1fZuw9rEpjfqVLDAuPTE4VwZOSvfB8wWXuNvOk0UiaPsaUYcQ9R8fDzQ8juG53OsIduDVseqjmtUgDZfV8waY9BJisw9mvjDsUgcpSrF4iWrySg7t7Wi9wmP3AM82twgH7r0i3p//rvgvasxyrebvQa9wl19t0dMrTfvWoOu0jEbX+XV8jfYmu0cJChPEGjSqcdHSOM7t6zi4pExmh559qb71Zw2xfBQpzmb1NRNkknhMBK9gVHZ6wUtMWwbExWtOhG74Qsfz1Mg2GVpMC+0CXxZAmPBsIkSbiHQiwgcJxUAGsdVryOsE0v0ZzkqhETdLOBTo0I5lbKVGZTF16p2blvc0PyWJAWWihjZgxIHnBS0GtrPgaFd2g705XEmpcnPyfEoYOQ1MJ5u09ba6V/nbNnN0mQuPFmvOPYneOMmnkPvhw5aq3juOW0eR7oXQeNvDZ0BC+ik9ClAYpxPqDRe7mY/h5WU+suFgKot1XJY0basnMByZiW0qBrM6mg1+J+LorZGHAiHIZQzB9v8YXB5Av9EB61S3S3OyKi2HoKiWPTf/VkspIGNs4tyw1Lg0Y39ye2F6ciwCLEmDvscH2AG6k/VNJT//Z4fV3huWk0CYxWyvOCaLMPtGWZIRCrZYzLUJw2RHeY4sHeT5FD3ugJsM/SBJ5G/oX6A8aYt2J4cyKzpnJStgkTbxUSvlTlRsDkrMX7RGefOzcfcpg2M=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5506.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(136003)(396003)(366004)(346002)(376002)(26005)(66556008)(86362001)(186003)(9786002)(2906002)(6916009)(66476007)(2616005)(8676002)(4326008)(478600001)(9746002)(66946007)(966005)(54906003)(36756003)(8936002)(38100700002)(5660300002)(426003)(316002)(1076003)(33656002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?wHanYhfWkji80LNWz7xr5CEtNpFJwaCzwpb9bPfQqXKETtqYvoms1eoujvA5?=
 =?us-ascii?Q?yYDSUYokRiwSObbkJBHU6C09z9e6nt94xIH7yf5g3+/IE6VG/GlrPx409RS2?=
 =?us-ascii?Q?cHmudmAgWLi4dDGLXIeDULQ2/bdthHCTqA03gplgVLlFHNtDHULW8evnZ3lz?=
 =?us-ascii?Q?916buklfCLKWNaWFlDcZ4AsRY/dH8tl7Scp04ZFZmLyOJ/18OR4sxPm8M7yV?=
 =?us-ascii?Q?F3ESydBnZMQGmLR3LA+mjs3k+wVUbzyW1GaEFX6rxkUxHo+oixKWpZJr+rj8?=
 =?us-ascii?Q?Ae0aM8Eh5aZFYay86krutvNrz8qQcK+0GD4+eTgLGXWQyDc0tsSChw6EWK6N?=
 =?us-ascii?Q?cNjSoZudDA5ER/qdDG38+4z8/2WovGINPZ3pCRcMoAb66n3+FHULrY10/DxG?=
 =?us-ascii?Q?+LeMLXldEoGX/r9e9hkrjT4J24SfbeW2dMeKF4LJBJ0ZWqTvhHU/Ef7qwskl?=
 =?us-ascii?Q?0Xrhi0sqwpW7ij2Vo7w8Ov0uhsBfJxc0EVPGSn0VbKIp3+dy1OKgpMRlCEHI?=
 =?us-ascii?Q?3AKf6GElu4A0P17RDmqkqHbkoxooWM1qUE1p7kPkfvVkPSv4qBQ+3IAOumCr?=
 =?us-ascii?Q?fwuMFH5iMKQbDT3j8VMD3OUYzjyTkFJ+FAWY2rvuv+qRsuS7X/6qKN/Hxr0P?=
 =?us-ascii?Q?XILp0g0QX8OqlvuLLhgUf9MJjO6+IXVS1i9NoD2OJZ5qzP+gIVREmvwsPiBi?=
 =?us-ascii?Q?+a5KCLqC4KtRNcAjOkOFVcjUu1bPuvGgXTOGlzoHi9QWBMTo4xTF7dqsjk2D?=
 =?us-ascii?Q?/8itWxbsUANFa143NGKBrbh/WmReeob5DkdlUldLuYjCvBBg7mmFLSi0hGNH?=
 =?us-ascii?Q?Xic5vX5rF9u28AvrDftbhq8O1rQWbwP3Cev5sZUFG0RRrWb1nzm+y7qeVEY6?=
 =?us-ascii?Q?t5oaJeYf/7G58P8Bsn8pw8qwWmblwBNyA2HcQivjMjWB+tfYUakCB7gfDxoC?=
 =?us-ascii?Q?WZ8hwT2LOXFwk546UJj1UWhRyE37zRCpCN97Oot/woo35wyuImQsJZf6LB2K?=
 =?us-ascii?Q?NYm8RssMAzouM/VXLxMQYgMjSFUdkFL82QeSwqOz2b1j4PmFUXDvgyd1/AS9?=
 =?us-ascii?Q?MFow+1sx4zM+wlioTZJ/kaWcEWPebWb2Q/aH6pJ8UXp0wU/EJnXYV7xSXvJf?=
 =?us-ascii?Q?Hm8zN3DLKAcEkeTu7+yUurjeS0jr8SaZRUK1yDRqcII1HwikeiV3rFaxHpFe?=
 =?us-ascii?Q?OeqjAlsEhVR4S0OQ5AdHzlYe0Q8G3wIyIaWJVwpea6p4y7oG4vY8s83GR6vn?=
 =?us-ascii?Q?A5LZoL9AWlJBr/KSZdANGLnzZYouwGt0tk8qrCXnvoWcKEed9JegN0UwbdFc?=
 =?us-ascii?Q?0mJO7LglBqjgm03s1HfgGngs?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b0f60e64-fb93-4daa-2223-08d951e9ee83
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2021 17:05:42.2965
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jOmJANopR1/ILuHajWVFd5kn+6KSQByPilvTg/R405NVALtCAeJHFvg//GyIMoKG
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5032
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Jul 28, 2021 at 01:50:48PM +0000, Marciniszyn, Mike wrote:
> > >
> > > commit dc70f7c3ed34b081c02a611591c5079c53b771b8
> > > Author: H kon Bugge <haakon.bugge@oracle.com>
> > > Date:   Tue Jun 22 15:39:56 2021 +0200
> > >
> > >     RDMA/cma: Remove unnecessary INIT->INIT transition
> > >
> > >     In rdma_create_qp(), a connected QP will be transitioned to the INIT
> > >     state.
> > >
> > >     Afterwards, the QP will be transitioned to the RTR state by the
> > >     cma_modify_qp_rtr() function. But this function starts by performing an
> > >     ib_modify_qp() to the INIT state again, before another ib_modify_qp() is
> > >     performed to transition the QP to the RTR state.
> > >
> > >     Hence, there is no need to transition the QP to the INIT state in
> > >     rdma_create_qp().
> > >
> > >     Link: https://lore.kernel.org/r/1624369197-24578-2-git-send-email-
> > > haakon.bugge@oracle.com
> > >     Signed-off-by: H kon Bugge <haakon.bugge@oracle.com>
> > >     Reviewed-by: Leon Romanovsky <leonro@nvidia.com>
> > >     Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
> > 
> > A brief unit test with the patch reverted in 5.14-rc3 shows that this patch may
> > be responsible for iSer CI regressions there as well.
> 
> A test of 5.15-rc3 + a revert tested clean.
> 
> Jason, do you need a patch to revert or should I send one.

Please, I would like to hear from Haakon as well

Jason
