Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3135568BE0D
	for <lists+linux-rdma@lfdr.de>; Mon,  6 Feb 2023 14:23:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229740AbjBFNXR (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 6 Feb 2023 08:23:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229884AbjBFNXN (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 6 Feb 2023 08:23:13 -0500
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2044.outbound.protection.outlook.com [40.107.96.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4894323C47
        for <linux-rdma@vger.kernel.org>; Mon,  6 Feb 2023 05:22:36 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Zwi4hxrERFSEOLT50qT2ekH3XnIgVl9axQp1NofxQ090IowSHT/tau4+llWOjY1ycQRN9jKJit3+VB2sMnIJWtR36feIWIr1zkFqJinGqkci1q+JIYl8Ft71bs8W23TIvjZL+CZZ/vTnn9sSOOFsT+jJKL20Tt+tth+4D+ESZGgV8vTjKTzoZzQhKdpsY1/U+iZkXiUquZml1yXigq6gCXLLtOggS9Rh8WzeB6hwkufN1i8/y7v2W+/szIy4MgnFjDiQwlEK3/5JuPAROOrO4ZtL7xFSm8NNVWPPWLomBjyfnPu4OS8VvJCyWNZOpvTI6bUUGn6k/f0y3Q47QwNgZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9Er4Cb2sdBaQS4Jk19mxH4dhZTtSh9hYE+51Lwe3No0=;
 b=GprsZ3z+uMlsdAXQROvwvq38E1bKJRIVyGijIWEejuX0699uA5tBnZfJWMqzlec4EUh5/yDQyeUyCqZsCm5hhKPYfc9BjhOmVa8LvDnysMsIuAnay3z9VjRzb7JLmjaSDdScPVbhBEKLgDhqqOo4e493QAgdPWAanIcmG62TUa/WQs1mCj6sjAcXJtJFQ0/DgfpcMniD7hSQtFSWzpFoMJDwO5q0d9Yg8IZeQSTZXETf3oRjIuIu9qUoPIRZhs/3pYkQOpShwUIUhIG621hizp9CNKJHMHPqoN7L2sD9I/7xrGzDY+au2XrqdrFfpJW0uHtclqbjZpUwo9l2gTCZSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9Er4Cb2sdBaQS4Jk19mxH4dhZTtSh9hYE+51Lwe3No0=;
 b=Kg0yFGkhGH5VmT9TWeYtOlzeB95qu3Ceqr6rnYNawnvXR3CjAwcEvdhFaThQi1AEKMHCgkQClzuWi1MqWCZ2Pwp5qbk1I5AdZUFish734XxTe6YljB9co2UIrZ8rkMgbzw2v4YcBZcIME5svoEpwN2RIxsTnJb4eKGffvVisAiTozJA6+Y+WRHJSbPD4yzHxi97EbCiKcTJcTlLJR9C0gT7arvszaMCvgQh7eaZOwHVqnjh1z6opP1uz1cGYGsR9bzNFFejkgCb3v6NGIWId4zNtZDtM4SGXg1jruU/+P5Yv8JrS0KlI9ILnIKxLxy0or2KqRjN15rcFGekc2p6kJQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by DS0PR12MB7582.namprd12.prod.outlook.com (2603:10b6:8:13c::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.34; Mon, 6 Feb
 2023 13:21:40 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3cb3:2fce:5c8f:82ee]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3cb3:2fce:5c8f:82ee%4]) with mapi id 15.20.6064.031; Mon, 6 Feb 2023
 13:21:40 +0000
Date:   Mon, 6 Feb 2023 09:21:39 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Leon Romanovsky <leonro@nvidia.com>
Cc:     Bernard Metzler <BMT@zurich.ibm.com>,
        Alistair Popple <apopple@nvidia.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: Re: Re: [PATCH] RDMA/siw: Fix user page pinning accounting
Message-ID: <Y+D+4ztAWOYTlXKf@nvidia.com>
References: <20230201115540.360353-1-bmt@zurich.ibm.com>
 <875yckmrx0.fsf@nvidia.com>
 <SA0PR15MB3919BA817A04C53AEC8B66FA99D69@SA0PR15MB3919.namprd15.prod.outlook.com>
 <Y9+psKn6GrceGeG3@unreal>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y9+psKn6GrceGeG3@unreal>
X-ClientProxiedBy: MN2PR08CA0022.namprd08.prod.outlook.com
 (2603:10b6:208:239::27) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|DS0PR12MB7582:EE_
X-MS-Office365-Filtering-Correlation-Id: 4be89835-6a22-4569-4168-08db084514eb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ilh0oDG8W2CCGG5vj+ZqGEXTo1sG9EP182LSdcorJFZfz55DNJl7nkSNz0Hv7UVLYkouDhXLhGP9ZWaDbTgH5ChpWQQfezsECbUreke+qXYn977kWdDT3YsZenpt10XtLyPQ7hgn7Xi5rbEbacXvpHJZP8d93x/h1FzKCntTIEB1odnhiKZWOnAcbJtSU/00EBhshilrB2DVVP1oqs4RflfLg5pS1/NVIGrCFGA8FfdRWO7ZGetZ5P9+VDyRgAQMhFzd0IUv6u/7XC0qciX3dcN0pEPWQ2t/WF9vcalY4VbTTzNwr+Jg95/Mms8mS5q113kosABQsbO3/lfjb1FuDoMmXvSa3e5LGbJzFuM6KKLyblMi5i2b9qIYtpV1oDTVmHttYKuH7GN/9NvQgiNTBWhYtb7u5WGWD9sooKVmqHiBmeeCqCbt08r7qL8aeD541z7dKIUrqvkLqzWwY3YEqP0gY8BEEhCQAL22DKK+zvqOSSSbk7XQ416hdbythrlBxcg0DMU9i/NhXzLHSBwln0J06hJu0SAd3jUx8Fl9Un8B+IhbgJeqn5XL6Fe1eydIQjKG3DUGDNi49AZ874DP7xZLw1bu6sQjN72C4ks87LdSBSNVZA2pmofRsYcAaIDHMs4zrXfQqRgZ48ci+foqPg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(376002)(346002)(136003)(366004)(396003)(39860400002)(451199018)(6636002)(54906003)(478600001)(6486002)(2906002)(37006003)(38100700002)(86362001)(36756003)(2616005)(316002)(53546011)(66556008)(15650500001)(66946007)(83380400001)(8676002)(4744005)(4326008)(66476007)(8936002)(6862004)(41300700001)(6506007)(5660300002)(6512007)(186003)(26005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?hdyJ1moI5S/0anglnIS2C2H8MND0PJaGFzYNjUTBUGnD2eja/jVDGUuxCxDZ?=
 =?us-ascii?Q?IGKL9sX5J+ES0dtFk/a5S0tLuwRrt3AmJVZhWkGkVYTTFQh7OVpGYiRmoTBL?=
 =?us-ascii?Q?C60WausIHplvho+vadq1XtrnrEzGrTy8WuC1WLDtwzTCGQlsuIPosqNYQKHb?=
 =?us-ascii?Q?42cHaWAZ5GHIDbe086WpNJjoPI8GoJOUGAMmE+H1eFGAib3xTkSTX+LLCJM9?=
 =?us-ascii?Q?jsEzxgQE7FJ4plUqDDCscbzm5f7m6xZ2oHu25tLcFac3W/mBvGtrJxfQxaxG?=
 =?us-ascii?Q?xXjRyK8rQ0soPGRlihJuzW4KG5J5e+QrRF/OtV9kdfAk38CbRsiUE4nRbamk?=
 =?us-ascii?Q?D33/Hq+c5R9syjkckVtmRVrpQQZc5BFWJFL/KZC+jB8A0l6fl36waSCwdTWg?=
 =?us-ascii?Q?VRJYnA0FWhSp03Tu3uKeeyKxkMvrgGam6blSk50iX5CVmjXDgXWmYr4A+tIS?=
 =?us-ascii?Q?jEFmQvh5k0Jbl2nxhGfTVTpwRFQAB/5o01TIl+98djvZKDTKMWdogZ6KqgG9?=
 =?us-ascii?Q?Q/C5fzpFJprjWmVfzdn0PEyilFetdNjwYHibYGI3/bZfYxih5eJPoecFOmc2?=
 =?us-ascii?Q?n29dhsSk/cSJDQuDMp2DUgLIXM8sj8JRs9IVS/12TmjdpZXF8h6vC6uDNuFS?=
 =?us-ascii?Q?2oOAQlC+4AipREJlTN8mmhYAtTk/EZPgrkaEaCIyoF8rdQOyXYaDGNyKE+Z3?=
 =?us-ascii?Q?AuYTvKVECFiNM8oHRRc8dTPVjvuGjx6/gPQkG7cwb8e9UkFneZvR46BLJKDg?=
 =?us-ascii?Q?emLtNT+UcFYU2C+aTyWpsNGV4W9xnD8DXu/jFQiSFeBZH5fEOI2osPLBbPIR?=
 =?us-ascii?Q?f7g9jXPFvr+1DjzKBcjgtltO4zygDe7YAUMfN6JQhUlZEjwUP7sZ7Qt3U/3y?=
 =?us-ascii?Q?LX7/3VgOw9UU2eaD69ugKFtfBi7pExE5eZXEnUukQiu8V75rXFmhHZ+J24cS?=
 =?us-ascii?Q?5b3n2JnPuIEgUGbjH7NmM0hdtKnamPLWqCdegi8fc/4QoX9l8n/qqP18IXpH?=
 =?us-ascii?Q?uuiR+KxpmtEn0KxaljiWDiT4DaeJAjrII8+be6/7wL1GUArxveMYp5sZXygQ?=
 =?us-ascii?Q?nu29dQG1MsN23/oPCZhrw39WW932oLkr3AjK3odx6zscn9CFd5YYhyqPhFoI?=
 =?us-ascii?Q?UDAuLCRvlCxJepUdP7yrXa2975tVlJDv6B0neo4DEn3uxhDNsfZkl1rSqiEk?=
 =?us-ascii?Q?qRiuEuHg7c4q2OYgHNtNx5ffm2TvvQ2SSIentkdJJoOmakLgWbWMIbinNiv+?=
 =?us-ascii?Q?T45VH5bWQ90T8zXpF+96p2gzLzSdzZkI9chzgfeHdVgBvex85yNMt1GemPvX?=
 =?us-ascii?Q?M+QKEkgNad9KNZjcI4B755dV2PzEn9PVI/uE8okAPkjrGFGHsl44DpkN8u2/?=
 =?us-ascii?Q?92eQGjdZW6gHQbTHkcfDuqVDmy5oPYrgtweYF1xB4iulfT1FzihJOwq9WNmd?=
 =?us-ascii?Q?vtlUBpUI4RQSFRTk4Ll0wcjN4dVCjPn77aH0WcStybrQe34J3LkpaP97MdtW?=
 =?us-ascii?Q?fmqXJ48fvRxVbp5w6hI8SlyCe0iJRUzV49qZ/19JYZIpzDNymvpv4RcPxHlf?=
 =?us-ascii?Q?rcmDIDBZgjsAZnVz9gTVYMIhp5CCogWEz1ZXi5B6?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4be89835-6a22-4569-4168-08db084514eb
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2023 13:21:40.1190
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pl4jyU0+3YeOxpYAKsnkfZgTf6uG9or0aaj265FqVBh/gZsIpmK0RrE+3tUxsPCK
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7582
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sun, Feb 05, 2023 at 03:05:52PM +0200, Leon Romanovsky wrote:
> On Thu, Feb 02, 2023 at 09:04:06AM +0000, Bernard Metzler wrote:
> > 
> > 
> > > -----Original Message-----
> > > From: Alistair Popple <apopple@nvidia.com>
> > > Sent: Thursday, 2 February 2023 08:44
> > > To: Bernard Metzler <BMT@zurich.ibm.com>
> > > Cc: linux-rdma@vger.kernel.org; jgg@nvidia.com; leonro@nvidia.com
> > > Subject: [EXTERNAL] Re: [PATCH] RDMA/siw: Fix user page pinning
> > > accounting
> > > 
> > > 
> > > Thanks for cleaning this up, will make any potential follow on I do
> > > much easier. Feel free to add:
> > > 
> > > Reviewed-by: Alistair Popple <apopple@nvidia.com>
> > > 
> > 
> > Thanks a lot! I'll resend for the last time (I hope), having you
> > as a reviewer.
> 
> You don't need to resend for this. Patchworks catches all *-by tags and
> allows us to add them automatically.
> 
> However, it will be great if you write target rdma-next/rdma-rc in
> subject of the patch.

And use version numbers..

Jason
