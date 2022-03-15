Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8121F4DA607
	for <lists+linux-rdma@lfdr.de>; Wed, 16 Mar 2022 00:09:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238380AbiCOXLA (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 15 Mar 2022 19:11:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239447AbiCOXK7 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 15 Mar 2022 19:10:59 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2058.outbound.protection.outlook.com [40.107.244.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89B8649FA3
        for <linux-rdma@vger.kernel.org>; Tue, 15 Mar 2022 16:09:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QZ1VJZ2v3o0MwqWLlQJ8VnaFQWemrGKL60I2V0EDub6UPdtIkSQNmpz0GpqSSYZIEDJ0w5aq7vWDtGadXSlWPoIDMM44j7hNwyBR7f3AWV0RYrX8DolUsythiMFmO4oJ/VwFr3Wrd0pd8qg/P/xsyi5Wx9/1oyuRqHkfXyes3R4Qj2Nrl0EsK20hw7y3icaBL6JH5Ch2XVcs5MB1KvgAS4T9916OiWq+dL3tqys1lyMMSrptnjoSlwIN5NmYM90mojwOpsjg7wvqlMNZH8vyobBm+qvVuNnevkww2GeLCTONWcL10bk1Kido60v6QOCqe9MOEzG3AUtztRAxCF/tfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FgYtbV7F40WlG3H5qQNLxLWPQb0du73X1Or2BGbH+Og=;
 b=nfAqVycHT5G3wbxEOa70Zi1EoIjzRkugWTQqxAWCRnvyDxHTizz4Genj0BrY3m6yjnSLJajgK2smzCFIYZ6x6HeLzmnmWG5s7jDR5cbvCLfWIkf4BS81bjZIVBu1DzZsrvEe+wwaH9In7ZaiEVO2wsY6QHAnTiJDxIv624xrkov8emPJ8Wtea/as2pKDSt+Yf6ZSZ7rJehZ4wXGrknP/caWAoSFEUwmTMdKlRXaja9tSALXnxub/r2CPCtIa4sEMYQ4Ra3feH3FnERJ0cPm4OFThEt0OPgUSzEChGoBHOUeWMF4G+PU2v22FmbzhHEq76lvKNgLevM0GY+P06D7LVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FgYtbV7F40WlG3H5qQNLxLWPQb0du73X1Or2BGbH+Og=;
 b=mPnZM+EL/HM6xbE54HEVQpuiSe6EAxt4cdttlEdpXnXHa8u2SNDSYOAOfcBynZKjopD89Ugufs092usyGqeTCvuiuiXQcgLK/dBTOnI4sTt7/TemD1KkpdeeG/GSZt58xi2EFl3UJNH9g4sbf+uxKGvZlUMuNlKBCTWnKfyjcRUiHDE4JHFolxryFehka7Z0VmpKC8H4K69AjQRUHBt/W9j5G7yF604VH4fh6yAxjBw74CFiyey9Tih2KhxEr+IqNL0L8xV6Rb+81MugLezFbcIoEdpEGjDkzZ4AfkpUs9yBy1dkhtTrxBgk54O/QrZEE1hVYMOzTRSyK2K4l8QjoA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB4181.namprd12.prod.outlook.com (2603:10b6:610:a8::16)
 by MWHPR1201MB2558.namprd12.prod.outlook.com (2603:10b6:300:e5::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5061.22; Tue, 15 Mar
 2022 23:09:45 +0000
Received: from CH2PR12MB4181.namprd12.prod.outlook.com
 ([fe80::9ce9:6278:15f:fd03]) by CH2PR12MB4181.namprd12.prod.outlook.com
 ([fe80::9ce9:6278:15f:fd03%9]) with mapi id 15.20.5061.029; Tue, 15 Mar 2022
 23:09:45 +0000
Date:   Tue, 15 Mar 2022 20:09:43 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Shiraz Saleem <shiraz.saleem@intel.com>
Cc:     linux-rdma@vger.kernel.org,
        Mustafa Ismail <mustafa.ismail@intel.com>
Subject: Re: [PATCH rdma-next v1] RDMA/irdma: Add support for address handle
 re-use
Message-ID: <20220315230943.GA258642@nvidia.com>
References: <20220228183650.290-1-shiraz.saleem@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220228183650.290-1-shiraz.saleem@intel.com>
X-ClientProxiedBy: BL1PR13CA0360.namprd13.prod.outlook.com
 (2603:10b6:208:2c6::35) To CH2PR12MB4181.namprd12.prod.outlook.com
 (2603:10b6:610:a8::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 43d3fcf8-0407-48c6-6738-08da06d8e4d4
X-MS-TrafficTypeDiagnostic: MWHPR1201MB2558:EE_
X-Microsoft-Antispam-PRVS: <MWHPR1201MB2558868F48986DFBA514BD21C2109@MWHPR1201MB2558.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: W2KZ5Lzhne+gYqxqw0gIUmus2j0RrRpO6CdIHBt+ymUoteXvRp5vFnZArrpwyr4XxPD8Q4mNdsUlABVqfwV6yUlHYKi6xtikMXZXqnnzI8ngup1Erw4SZPWWA2rsUe5qxxRK7MugPAsqxq14+JXXXgQ6no1isJ/C1ux66gaIxVzdBG6P9IfPix49hFh7dupfyt/2VXxsaQ4P6PPla9hnuPFag6vmArndRj45hZai58hKN3mZn2mdDHRLJEZd2zsfm3ce7FZSQHYF6VHbS2EfA/zd5GrSbqwWybWYLdfPkjYfD0cnGTBVIwjx/L+Z4BrcGDGGsatipYtGaUY23f11PIhgDPgTPnOTqEBPLUmqUr1vtdr1tX1X0Z994OLNmoMXxXyns4vj/rbYnSrjkYo5vnze16VT7Zstf65uVJoINaZrJcaOCe+zc3ecMfVIvt7GI5goebPZD7uBYRB+Y3aYGCuPud7kn1+4252OReiQpFZLBdgwmnYdm3JdZX35W9XSUxZh+fHt89/QaXCqfdADK6BQUikBV0cA6fJ+Q2XPIQMt8ymHBVGfoWqdFg2REcfxZp7CUARS/xDg1ht7mR52IL5ISaGRWpUiAGFhsMERWiuHDR0Qb/sG3UARNiAmfEiYoR2PATkya2KRieHFWZUAypPqBgxVdXhs/TBHOfhKeZO1J54CHZXLGVOoFVg4yzPWQEFQqXZu+a1kY/FaRvEFNQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR12MB4181.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(4326008)(66476007)(66946007)(66556008)(38100700002)(8676002)(316002)(186003)(26005)(2616005)(5660300002)(8936002)(2906002)(1076003)(86362001)(4744005)(83380400001)(6506007)(6512007)(6916009)(508600001)(6486002)(33656002)(36756003)(27376004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?+fCNhgeaBQjPOzQGW0c0F97IVSuJc0adKje0Wr0EWiDL9FB5N04rTi6+xBcu?=
 =?us-ascii?Q?td42m60jpSWOtt0ecOwf6O3nCdwxQxaee5oMLFKqf8iBG9f1hZwSfLo8Ly3r?=
 =?us-ascii?Q?yM1mWGcBUBA/yyOzL4ScoJ+IYwuAif7oiZYFk4HqEJQ6N2AUL9U12VFG8z2w?=
 =?us-ascii?Q?moBajRiOVbiRRPNMmGL/+JDtggXT3DKen4bi1IV93e6h7ArwSWpkICBzLgGK?=
 =?us-ascii?Q?kTQuHu0dqkMTQ1E/X8IuA+bzJDRCHrMYOFAUTJQIIIZ8cSzuxnEvKnh25jac?=
 =?us-ascii?Q?uSGfpnP2akclmRS0Q9mGclgYnth3owXfJ1unJ5Mp+UtGwoP4iO/CYLADZoqh?=
 =?us-ascii?Q?pK+9bWhomlcokXVkCfspw2O0rMnqwWPeie3i0MkN5k7+dNF9gkzuOXJoyTrs?=
 =?us-ascii?Q?Xug904J3HPpYh4kMxm0xMZ3vD49JPEf/oVg5/4mcn9G+hhuBeiSPPlNwJsch?=
 =?us-ascii?Q?owfa9FwKpikclmRjVYU6u1OUFBQ3ZamXOpqvO07ShQEbcluBMmRcYj//9jQo?=
 =?us-ascii?Q?uGOSEMEaPgpl7eNdlT4o+fgVafe4JodaGKNfcTUwut4OfT9Qbx5sOMnGLZmH?=
 =?us-ascii?Q?qAcWqNLcyBvm8UhnRgC55bZKa3vV/ITaJXDhczYaqReUSi4yrxjet3SSge7s?=
 =?us-ascii?Q?ezWPGXGitKz1epLfPdnOA/KLQcfFju9NBi0Q/EBS4yJYnd4NFBqBTPVTPe6g?=
 =?us-ascii?Q?LqfHzMQdjZccfFmQGFhy+Axep86inMMv4F1PEHDn+CmSeytNKDnbWkI7XhF3?=
 =?us-ascii?Q?rkGM2s9CLxGeJHT4Y1KyFG0R7VTFbX04GxDCzlLbpcUDjRu/YWV/CI5ZlU0N?=
 =?us-ascii?Q?Tr30esraDbkIevd1CTFYIrC1E9GCOG9/6gD8X9ZmTkfBBPlA1Qn1+aCjeEKg?=
 =?us-ascii?Q?HC1zv+KMi0WW8bF5xS67Qcbyev3It+MoHdN9rWBClIZyjDXwC7zpXRm75FDQ?=
 =?us-ascii?Q?PIF3l7h0JcaZDvnPsEzSuIba+v8olB6c5KNnnJPZTYeS9vROCYDAZDSSPhkk?=
 =?us-ascii?Q?f61cM52tPCo/sRGZEIZmDgF8a510EhOGeuqjlY9a1JHF4YXpxVJDGl+w8mJr?=
 =?us-ascii?Q?SnO74gojLKy+A0BOFfBZszVG093amPAjE6VslAdN2SSIH3W4GQBp2VESIYH5?=
 =?us-ascii?Q?Bac+kRiB9l+vVjUTwHGU4WHjqOBUCBSLDqEgL0eVVotGRky2XjbG1jKnKXBa?=
 =?us-ascii?Q?5NTi5UEqdCBavWoMXQ2u9uFXdOYH2wKtNezYAmBrPy1rGKp8EK7PKM0wiCUV?=
 =?us-ascii?Q?FXMc53GX3k4/95/qrL6D9xOz6mKs7cTc9L7WnxhKHPM+SE1NBywOPpkZpBUI?=
 =?us-ascii?Q?WBFaE4B6eyNjOhtoJ6tkFfmU/JYv+0/MYwnBN2mXiRz0iEa1ub42jN4kYnog?=
 =?us-ascii?Q?UYQpE/hoiGMtygDA9WCF4PhxsWmv0TpSJ7lsjjrceEVAcOeU+19KPEsCoQMM?=
 =?us-ascii?Q?j+pbn+ExNM+LNggfNSQQC7YU2qCN1wqG?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 43d3fcf8-0407-48c6-6738-08da06d8e4d4
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB4181.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Mar 2022 23:09:45.0216
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tnc9Vq8lloOC3KqQDUO7HjYCIdT8IFjC79aJ0LFTx4zipmCdhvje+nb09CFmXLGt
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1201MB2558
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Feb 28, 2022 at 12:36:50PM -0600, Shiraz Saleem wrote:
> From: Mustafa Ismail <mustafa.ismail@intel.com>
> 
> Address handles (AH) are a limited HW resource and some
> user applications may create large numbers of identical AH's.
> Avoid running out of AH's by reusing existing identical ones.
> 
> Signed-off-by: Mustafa Ismail <mustafa.ismail@intel.com>
> Signed-off-by: Shiraz Saleem <shiraz.saleem@intel.com>
> ---
> v0->v1:
> *Use a hash table instead of linear list for storing AH's
> *Remove limit on number of cached AH's
> *Remove check for RDMA_CREATE_AH_SLEEPABLE in create_user_ah
> 
>  drivers/infiniband/hw/irdma/main.c  |   2 +-
>  drivers/infiniband/hw/irdma/main.h  |   2 +
>  drivers/infiniband/hw/irdma/verbs.c | 217 ++++++++++++++++++++++++++----------
>  drivers/infiniband/hw/irdma/verbs.h |   3 +
>  4 files changed, 164 insertions(+), 60 deletions(-)

Applied to for-next

Thanks,
Jason
