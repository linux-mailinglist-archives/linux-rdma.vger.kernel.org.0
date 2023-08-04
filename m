Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D2837702C4
	for <lists+linux-rdma@lfdr.de>; Fri,  4 Aug 2023 16:16:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229916AbjHDOQq (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 4 Aug 2023 10:16:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231605AbjHDOQn (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 4 Aug 2023 10:16:43 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2043.outbound.protection.outlook.com [40.107.244.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3B313594
        for <linux-rdma@vger.kernel.org>; Fri,  4 Aug 2023 07:16:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YlnZQm0MjsbwD0Nm9EU3dFY7K2QxIYJY52OTIE7nrFxZyAoLDHIOQc85CcD+2sl+faDF2h+/WjKJa1cWWOgjsRhjhFjLroKh8/Kgd/j55ES+P/Sn0KB+3N7fGPcmmcH4pfU18IoSDUx4zWwe5AVAAzST9S2LYnCxfeEZffCKMgA/OeiwOvJndC+3WJ9ahZmkVRX+Lh2BN7TJSS+bvK2SlX/4c8DDzOBpuHLtjXPDMoAAxvlmKT0GnRgiGedZ4yWhUSAFwE+2xkVHObOYLywZ8KlVrJNnGsVSdCVwvhch5RTY36KzA4wUv1m3ixFkFPh+L2FBBYcz0v3WWbRbujX6wg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bUL6aj/TSscZtDuM/mcfoYWsjxgULgybdKZbsetysWE=;
 b=LaxCTRL/E8F+CaCWWEedyqhFzdUV7cVIv2Zll5Qnaw9An3+Txi12o36QFYRyGnFsyUhjojMa1OhgYveGyUx/Hcbb7YqvUX+DwfeVNPbiN1rho3K2dNptOvFKZfB5Vt4hJvVaKMOqdl/gMD2WPhHMCFwaFAJIxO0F/Lsz9kkZnEH1zAia8VuLODU0fRiqeOnNEnyfBqt10JiyuAdMjLZ+LxufFf9BDGDMFBvxShaKPbqRgTye2b/RrcPXCc4pr+LW/mJKGuDvt4acXFCvwSReZzW2FwurdzngowIjgCPKrHbljAZK4PmMujTakXLWXBCm08V66CBxsyqSeNmhir0Txg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bUL6aj/TSscZtDuM/mcfoYWsjxgULgybdKZbsetysWE=;
 b=Lj0BJfAMXOWVZcYGh2b4feR6fGimY4tgZPElilbnmoPpn5+9IYjFL2Dsr3gtnPv8sB4offBr4zv0yorbVDrUys67WAcIsMpRA12y8UH1cuQHLnOH8A6NZgEXJAGm1oEG0k85eKozf3gDY9BCjx85FTmR0JHlAnRq9m0yDx1GazoJNA3/MpEl9PDI3ua0K05mXU5fUor2WzOS6q5rMZwVzJ752oxQgx+/doU/E2oYB7++V4Q5Ln8thq2miaa25EjYIgVhMe5DTVbajArfxGh9ouJcx6Ll7Goqa7ofXXEHCPgsvsCRCs8UtOmFimmbVs/i2LdAXj1buz+4mEdw2UK8/g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by SA0PR12MB4413.namprd12.prod.outlook.com (2603:10b6:806:9e::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.21; Fri, 4 Aug
 2023 14:16:33 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::5111:16e8:5afe:1da1]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::5111:16e8:5afe:1da1%6]) with mapi id 15.20.6631.046; Fri, 4 Aug 2023
 14:16:33 +0000
Date:   Fri, 4 Aug 2023 11:16:31 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Bob Pearson <rpearsonhpe@gmail.com>
Cc:     leon@kernel.org, zyjzyj2000@gmail.com, jhack@hpe.com,
        linux-rdma@vger.kernel.org
Subject: Re: [PATCH for-next 8/9] RDMA/rxe: Report leaked objects
Message-ID: <ZM0IP/3QtXG6Dtrx@nvidia.com>
References: <20230721205021.5394-1-rpearsonhpe@gmail.com>
 <20230721205021.5394-9-rpearsonhpe@gmail.com>
 <ZMf6XBIAD0A25csR@nvidia.com>
 <ecd82fc6-0a2d-7dff-496e-5a92d115da8c@gmail.com>
 <ZMf987OeXm7bdBDP@nvidia.com>
 <4aeec08f-bd31-9cac-d121-12da5a20c2ee@gmail.com>
 <ZMgA4mNoJ9ZhunZP@nvidia.com>
 <394e5205-4bec-3a92-7c89-8966d2329946@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <394e5205-4bec-3a92-7c89-8966d2329946@gmail.com>
X-ClientProxiedBy: BL0PR02CA0139.namprd02.prod.outlook.com
 (2603:10b6:208:35::44) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|SA0PR12MB4413:EE_
X-MS-Office365-Filtering-Correlation-Id: 50a76399-a18c-4f0d-8f6a-08db94f56794
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: f7gGApkGB1cQKGlc3e+wy+a9ext2zjECriHv0ny3S0fWPmnaGCaaEvTs7d//RB8rQEB8WMTre9sSDUSGaQZhReZwKCD0gHZkB23uZlwKNbzjwxik6po1MQoz1WfaLdgTUfgDocluGpvswJdhPudQzOZh9hG/kSqsph9RsfpusArh/is+XfshtXn5Kn0TcmyQCMAoGer+uEYnnQOJo/T56SoDXzNJMR7N7OnSwef1Wjku7rOLzrcRxmQFC2LaE08qKOJtxqq2/ttSoqGtpb8qHv63JUDweRRbGiwFP3xYp7vHf3lY8BR1u4rjD8c0wxqNULhRIMMs7M3aHaNMi9trS1mEmWimMCDNdg1Ya7QlnRiGwZI1iaE+WuCa70fsXqI6s6qpGi5x2hqHmUGtsnXM8bTathqVkrl+tlT4SFEtxN01xywUTBbRgN5UpEkJkJGjjOIubq523IFQINMcfWVxicgcnCKL/FQfCLtlOxpnK882Amejcu2gIuFUMz0jIsq6d/XLYHZpyR8+JwoBtAAmAmmt1wUjdpJTsB+7kbsb43NA6Gu+X2gE3lMUNrahLwTW
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(39860400002)(136003)(366004)(346002)(396003)(451199021)(1800799003)(186006)(6486002)(6512007)(86362001)(6506007)(26005)(2616005)(36756003)(53546011)(83380400001)(38100700002)(5660300002)(41300700001)(8676002)(8936002)(6916009)(4326008)(2906002)(66556008)(66946007)(316002)(478600001)(66476007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?SNmFO9umOcYuq+x5tTa+0wONLzTdH1bJ98ePj1Uw4S3Yvw42wg+VulHAEOHB?=
 =?us-ascii?Q?+0G34D6pw6BbsP6/yyg417jUN/DfEpNMnk5JUUceco7oiGrqHRmDkFRmZ0WS?=
 =?us-ascii?Q?07Txb8YDV4Rw1nnjiAhc8W172MW08HXfjOpl8fPeNzeNJ0PezyO73ewjNtUV?=
 =?us-ascii?Q?dJu40VskATnOY09itlr82HsSLz/dLJmmm3N6xt4CgN62S5pdAL5pWzKHQH83?=
 =?us-ascii?Q?/hnbmJRKSPpjMx8XI7TcMLIbPI4JBr0x6Cg9nb8mOHoOMLH2JLIVji3hb0/q?=
 =?us-ascii?Q?ncfqgfojyhYMU7mprb2QOLfVOKi16FvZRxPOhmPJ7EtAwnNsyc41vsLqIFgG?=
 =?us-ascii?Q?tXb9fenV7oEIfqUnZ4It9ezsyDp8De0GdyqlM71lDizpwi2RqrDATcE8sUoe?=
 =?us-ascii?Q?F6yXx1vWjwq0OD5ficLI/AuKh8aNEh0M6jStdib25V6QvIpe+zQRveCtFhGj?=
 =?us-ascii?Q?YN3GRJyQK5Gg5vz2VqWOvhXox//sa/qG07nyM4rg/0W5kIBQPTUxC1PKbd+k?=
 =?us-ascii?Q?QtvAwRfUyC6xMM1oLLt/rrGJUPYKT+rX53SyD6wgjmogNM/QPvIzJ4QYK1ab?=
 =?us-ascii?Q?GUZhhkPw+n7+3WoWU0VchbllzMyF8WB5xlV2ZoDqMeJT7Ro55hUxM5RNJAXm?=
 =?us-ascii?Q?NnRA+IUge2fBQ/0P8wX/ePKu3a+HTDLoe6ew0RVLcekUDuwqGQLobvG1phmv?=
 =?us-ascii?Q?i+mMLLxZUoiWRm9UYUyxjfDFvuvkOyGrdd+NKd9kKBNBiKioR2kVFUzkZhSe?=
 =?us-ascii?Q?WytY8BOELjN4zdi+4pfbwFFef6sgdQmhvXp2nBa51IUMlsv7nBFPtqxGygID?=
 =?us-ascii?Q?NJTuwSFbHd1qq5wTu3Dttuln3AKwipBj7LCFvF4AuqYrDY92Zf8S8xlfo7Gz?=
 =?us-ascii?Q?LzKIDgnFzKGdQ0NDBcZLukOpct+wHWn05WZe1SLN1nBEk4w3cedj3aY+r4Ct?=
 =?us-ascii?Q?ehbnCWFDKpuDf57HpJI39ds1YhnWDwbjzo8RGpsBbYtRUtAxMLbO3pWT0OSq?=
 =?us-ascii?Q?seUBvqrEy4KsZArGLRM1oFW40oEEZEKM6JG7QPzxRzjkZI9CMZCP6CWjLeVK?=
 =?us-ascii?Q?ibYFsjSmHTRzGVmstW3aF5RHcc9Tnm5bX1Rplp/AAZ+/FIZjl9MoRvZPylet?=
 =?us-ascii?Q?YqoKwDIftp4qjyDe5BGSvO1GQ6mmTPR14pwxNpt6T2Oo8qlcDpraOMrXS+ZI?=
 =?us-ascii?Q?l2e7pJgt6fPp4qjNus30kBDTPOEsRlVhqFx+06Bk/XxJlitvaCgKM9bABniC?=
 =?us-ascii?Q?7PuH7wV9TXpV0aGrBVQ796YBSylvz+V+ynLr5lpcQTKhO2KvuLxeidxPBpBF?=
 =?us-ascii?Q?etWC4JXWZJbgy9j8MnUoJPWcJxhfguLCf+OWUwLYKLq9kGs0uW1iNVacds/m?=
 =?us-ascii?Q?3J3RVOqvehzSqKnXsD/2b6nhm8AJ/NAUGJMKlMk3UB4u9N7bBjrcVE+ZV/N0?=
 =?us-ascii?Q?eq0o+8t0pK0kRSTmVYTC8/EPQoByTNRqSs/oBHPb6zoAIhIIrR0q0MvELPgW?=
 =?us-ascii?Q?0VhRLSPxaBld7bgaJ8Tl019+6taS9ccGr+XSPUav3/TnmeIKzHLeJsH9LOWc?=
 =?us-ascii?Q?i06SoPhDp0vZudpiSCBx4tZ2GxYV60FIXua8QI0J?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 50a76399-a18c-4f0d-8f6a-08db94f56794
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2023 14:16:33.0222
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Jkpy7n+SdAKz+UJ2FmHIMpiRxXVWTwjCikUyqmNKc0MiGyuW5WXD/0raw5oCaUNH
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4413
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Jul 31, 2023 at 01:51:59PM -0500, Bob Pearson wrote:
> On 7/31/23 13:43, Jason Gunthorpe wrote:
> > On Mon, Jul 31, 2023 at 01:42:09PM -0500, Bob Pearson wrote:
> >> On 7/31/23 13:31, Jason Gunthorpe wrote:
> >>> On Mon, Jul 31, 2023 at 01:23:59PM -0500, Bob Pearson wrote:
> >>>> On 7/31/23 13:15, Jason Gunthorpe wrote:
> >>>>> On Fri, Jul 21, 2023 at 03:50:21PM -0500, Bob Pearson wrote:
> >>>>>> This patch gives a more detailed list of objects that are not
> >>>>>> freed in case of error before the module exits.
> >>>>>>
> >>>>>> Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
> >>>>>> ---
> >>>>>>  drivers/infiniband/sw/rxe/rxe_pool.c | 12 +++++++++++-
> >>>>>>  1 file changed, 11 insertions(+), 1 deletion(-)
> >>>>>>
> >>>>>> diff --git a/drivers/infiniband/sw/rxe/rxe_pool.c b/drivers/infiniband/sw/rxe/rxe_pool.c
> >>>>>> index cb812bd969c6..3249c2741491 100644
> >>>>>> --- a/drivers/infiniband/sw/rxe/rxe_pool.c
> >>>>>> +++ b/drivers/infiniband/sw/rxe/rxe_pool.c
> >>>>>> @@ -113,7 +113,17 @@ void rxe_pool_init(struct rxe_dev *rxe, struct rxe_pool *pool,
> >>>>>>  
> >>>>>>  void rxe_pool_cleanup(struct rxe_pool *pool)
> >>>>>>  {
> >>>>>> -	WARN_ON(!xa_empty(&pool->xa));
> >>>>>> +	unsigned long index;
> >>>>>> +	struct rxe_pool_elem *elem;
> >>>>>> +
> >>>>>> +	xa_lock(&pool->xa);
> >>>>>> +	xa_for_each(&pool->xa, index, elem) {
> >>>>>> +		rxe_err_dev(pool->rxe, "%s#%d: Leaked", pool->name,
> >>>>>> +				elem->index);
> >>>>>> +	}
> >>>>>> +	xa_unlock(&pool->xa);
> >>>>>> +
> >>>>>> +	xa_destroy(&pool->xa);
> >>>>>>  }
> >>>>>
> >>>>> Is this why? Just count the number of unfinalized objects and report
> >>>>> if there is difference, don't mess up the xarray.
> >>>>>
> >>>>> Jason
> >>>> This is why I made the last change but I really didn't like that there was no
> >>>> way to lookup the qp from its index since we were using a NULL xarray entry to
> >>>> indicate the state of the qp. Making it explicit, i.e. a variable in the struct
> >>>> seems much more straight forward. Not sure why you hated the last
> >>>> change.
> >>>
> >>> Because if you don't call finalize abort has to be deterministic, and
> >>> abort can't be that if it someone else can access the poitner and, eg,
> >>> take a reference.
> >>
> >> rxe_pool_get_index() is the only 'correct' way to look up the pointer and
> >> it checks the valid state (now). Scanning the xarray or just looking up
> >> the qp is something outside the scope of the normal flows. Like listing
> >> orphan objects on module exit.
> > 
> > Maybe at this instance, but people keep changing this and it is
> > fundamentally wrong to store a pointer to an incompletely initialized
> > memory for other threads to see.
> > 
> > Especially for some minor debugging feature.
> 
> Maybe warning comments would help. There are lots of ways to break the code, sigh.
> The typical one is someone makes a change that breaks reference
> counting.

Don't do it wrong in the first place is the most important thing.

Don't put incompletely intialized objects in global memory. It is a
very simple rule.

Jason
