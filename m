Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BD8972039F
	for <lists+linux-rdma@lfdr.de>; Fri,  2 Jun 2023 15:42:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234736AbjFBNm5 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 2 Jun 2023 09:42:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234300AbjFBNm4 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 2 Jun 2023 09:42:56 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2056.outbound.protection.outlook.com [40.107.223.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AB01136
        for <linux-rdma@vger.kernel.org>; Fri,  2 Jun 2023 06:42:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NZkHOAjvEycT9cm6nxS/14AbIXxT1yKYSGREwGjI3JWh7gcO0D6Ya3vd4hqYbCxY2VThnibFTLOQIrYmGnjp6Qmhu+DOB1iisLui7coDI/d3bPvpGuj81LiY8PYHZRg826EH3vLmgYPskLZrqXV75RIk8UcL2wYIy4WuwAn0kEtbVYjRlsGtI/KVyKgFohczSzS/BMKwj0whWjTJqbizepTLl39wRjNRejWDiEsbvckKMSlwRWSt20m+tsW1E8OAn2xlVrYkYYVBqhL3zfcFkb0+3+Rx674PkJHAxP03o3N15YYNh2Vm/pq5l7jrPalTUZArqlDql0ltr1fVRqNM5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uE0jQyIpYbbl0uX9shToVKcpB0kWWNoug5SSQ90GGRY=;
 b=oYHKLwO/QSYXxH5w6OhRuuWZoNNhVYpAuokbL2tU3MnNH5AF0BZJrK++Tz//Se6MeUTaIkSPZib6fszfB1NgaRwiexe9f2v7tUqOnzWCUT/fciECeqxqRNDna/ubnwEramR4PXsEuaAq+NKswwskud5O1pFgct/uXWledC00VjV0yUzgIzte4Gol8FNNr1SWd94djMnjdBBzxDwnzHi+cpAj27ng2nOu8qit2ydNI5LIR+RdqOLn1eYX4jQuQiyZJudsC7jAPAyP38JwtJ5T3k6ZAuZr9lbZJSWes7+nKwZUqwMvKlrZTAL8YmJizuQ9/D5LwQ4AgAFlq66jGX8Tmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uE0jQyIpYbbl0uX9shToVKcpB0kWWNoug5SSQ90GGRY=;
 b=L6es1weo6gUWLLxSYDxAm+oq1ttOcFGZQXRL0Gm2rgu1Z1EJPmw9gukBh2daoUJFbsh4ixay9lxLU46o4Y6DK+GV8ukuF1ez6tZVcuWaBOaRaU9PFc+X8Xe5lcZ8pAAmlu0MzSxuGR7gBHIb/luH5wo05wWZeDvaKFG3B27c1OpQjhS95IjrGIbh79GftRdbdeWnhXXeHU4TpTM8r/pvBpgmo1aUy2ZCG+iBKWTUQURof53tZr7jwi5UIA9GvJSt5jg1q6VSvDQ6i71ToymkFMINclHHpFq/KdVXQP5iaasgQnrPhUO4loceW+53gcAKJhtdqXeL8A2jSIdDvKgehw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by SJ1PR12MB6339.namprd12.prod.outlook.com (2603:10b6:a03:454::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.22; Fri, 2 Jun
 2023 13:42:53 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f7a7:a561:87e9:5fab]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f7a7:a561:87e9:5fab%6]) with mapi id 15.20.6433.024; Fri, 2 Jun 2023
 13:42:52 +0000
Date:   Fri, 2 Jun 2023 10:42:51 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
Cc:     leonro@nvidia.com, Dean Luick <dean.luick@cornelisnetworks.com>,
        Brendan Cunningham <bcunningham@cornelisnetworks.com>,
        linux-rdma@vger.kernel.org
Subject: Re: [PATCH for-next 0/3] Updates for 6.5
Message-ID: <ZHnx2xu/AmkKFni4@nvidia.com>
References: <168451505181.3702129.3429054159823295146.stgit@awfm-02.cornelisnetworks.com>
 <ZHkhjTvi8vNAmmEC@nvidia.com>
 <d5f1df96-b06d-8708-8732-7c034f5bbd81@cornelisnetworks.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d5f1df96-b06d-8708-8732-7c034f5bbd81@cornelisnetworks.com>
X-ClientProxiedBy: CH0PR03CA0050.namprd03.prod.outlook.com
 (2603:10b6:610:b3::25) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|SJ1PR12MB6339:EE_
X-MS-Office365-Filtering-Correlation-Id: 49201715-1e56-4461-89d3-08db636f435d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qlcDcT3nLYLK8R3r4NKvWmydCRUj2j8xAVQT5GBAC0dE39xlqjvLhI9DbaUIlpI59tH/pNqTe+iWPMO+nhhUaq6w6rKzqdvoF6kCl1KKNhKtKXj3NlgVT0XO2g8n9dZd5EsEpQvv97a1m9ZHtnNMVvj6l44J4pn6iI2r7UJmQo5FavoUbSinyEI1WF47wVZlYp5TurZo6roguBb82h9df0ZH78vuuHQvmPABobfOOeJH1UdRUUgFeabuaoM2qIaFNBSnxzJuPJHlfJx997Z9IBWAXUENzuPk8jKU8q9Qo+ix3IStPnTg+meOmUK/+cxmUpuwpGHj/5UVT/KOaBhwVbo+X5SiquqWq41gAmB6vXxw7ZryBg/Sl+gWHmA7rByPhYfFD/DlzHxf2k7hMO5wQ4gcCxyG0UUxLaTL7wd1x8etp7gVe7CyYcGY4b7qyUEOlqEkBSjUoARktQrex41rYHvaboD2jmWTqUJB3DAheLCRGMpvIOaqYTsAQ64fBcFzsUOcinEfijvjKQ0OL6Qyvw1IEJPlrvcbKvu723A/gvtIvvXzIEnonnAY2tlsShsbsqPLDYLjVk8k6RLwFiLQ2+kKmaUIJyfJPt1GyKWiOPc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(346002)(396003)(39860400002)(366004)(136003)(451199021)(8676002)(8936002)(966005)(66556008)(4326008)(66476007)(66946007)(316002)(6916009)(38100700002)(41300700001)(2906002)(5660300002)(15650500001)(54906003)(6486002)(478600001)(53546011)(83380400001)(26005)(86362001)(6506007)(36756003)(2616005)(186003)(6512007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?cHiji8xQFYWhVynCD2YMwH2ZvimZCA3oiV4hB8CCsHpKqi0vkcFAsfh80BOk?=
 =?us-ascii?Q?lcINWpRbpCfnCkL4Q4TQi8qw9lxaypWOu/IyV6kYko+VaRUMT48DDc5J4VFg?=
 =?us-ascii?Q?3bMz6LBs0YIf3IIBv+RWKTG7jNvI+l8VosgmpZJc2SgX7jM3itmdBjzh+Kib?=
 =?us-ascii?Q?7B9xBYpg7FDFspsYTZ2hKwhOyKhe0WI0FQRvPmMq8bw9bMbU4/gS8o7Qc6Vg?=
 =?us-ascii?Q?eF1vsayO+if7LIWFmaaBO4IPupoImvLjgV+wmq88xDEayg4+lAyfP/zKLMae?=
 =?us-ascii?Q?4UYTFSGgicbk2vb76saEV7jHvn5ZQQ3YEHgI7Ya3V9PAbUPfyp+0OUBTaFwH?=
 =?us-ascii?Q?OFgE9kEV4Gn0pCK6syWYoXz4PJ3Waj0ctiNt6x18/pLa5RdbIOhIpee2SQ5e?=
 =?us-ascii?Q?laaSYQ1O73caC+uj+KR2lYtB6WyUAPFEwqyOGx13xJUhRache4l09klGuzb/?=
 =?us-ascii?Q?xiO+bXsP3FhfY09vDJeCK1dx6senSyhDBVENqQhZayuTxZW87GrqaElbtdpb?=
 =?us-ascii?Q?3SFQiyEs7qF/Ep27BVP7uCRtImjt8cTV3qHjk+pG1XpRvxLedPcQOEP5uL4U?=
 =?us-ascii?Q?hGatdXEtuzo1vfCaA/B19zEfmRsGSOg3EPn1zj7rAFUdXdFt2H59iMG3HEv0?=
 =?us-ascii?Q?Z28FXAxjE0P3G1IF4luo6q3dAjme8bYm1FsTY3qFvt1EylelrhxXAIyZ06CA?=
 =?us-ascii?Q?sPHOXCzRwgtPxT9UVPy9bUvYL7I5rDrnzHwWXDbjyqi2C13M9WQGCqA1Yz5C?=
 =?us-ascii?Q?aTv/C4lKswa1xRW4cpyHXb9M40LtOc9yXOPPw4VjawxF82RGqigniPzeQvyU?=
 =?us-ascii?Q?kRwLoC1w9btUYjPvuiE22VX+NypIhg/UPSs90bk8cqEkK68Adz3kYD7NvCX7?=
 =?us-ascii?Q?TjyhNWPGUeBnVWoF8QBS+1S/W15GNtSnnZad/nHY3LgAz8c6XYDjE9TSKvGJ?=
 =?us-ascii?Q?YHFITQKk0Gh8LwQidv8qmViuhfkftNUsYnlbjee6s2k+NP94qAb26n/B3C5P?=
 =?us-ascii?Q?hOfbgZlU38OOcy3VE59NFbW/Y20yQsmpWdv4sU/DJFWxTtBL1S9X/f0VtdUu?=
 =?us-ascii?Q?vryDMEviFNSz2OxdddWaSTfwQWNmKyVDuOzN77o7WfKhGOpMMbEONd1B9zGP?=
 =?us-ascii?Q?6p5HbV1CKL6Ff2/SD+K40nfv4PgYWnozzBUxCxTUs8iT7QD/aRed68/IPTO0?=
 =?us-ascii?Q?0sSujxudM2JOGQGM+q65usxlg8v/gzjEK+bpdHsdjZKrXrThbbXXwYTYR0cu?=
 =?us-ascii?Q?3l1CMAI/EhXFaL4+32XtQNf7TttNJiaq1fF78s42RCPzQ2yneMgtiZoHv8lG?=
 =?us-ascii?Q?mCKEQJfsHsTTpaWojZyClNEL1Nt2KzdnYlcqbpi/hZ6C8EdD7gfLL1BVU5nA?=
 =?us-ascii?Q?0yeGFYrxywtVIjlqTkDXWn99ZFexR7Aw+1RI00FQha2UioliPs6NFAA716N7?=
 =?us-ascii?Q?fOAkTuEj6TL2aVue/RMw867xs8ptvph7hCEDeMxjm2h8P1tjroxMftZm5SXu?=
 =?us-ascii?Q?s09HV4JG4EuzgKRtxmdFihLIcPCawZCWbL0oqm8Dwzyr/qkZOW2LyAwcsSWp?=
 =?us-ascii?Q?c3BBXpzSvjpi/FUMqM1EpLvJ1gTI1LvUBLm5jCmv?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 49201715-1e56-4461-89d3-08db636f435d
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2023 13:42:52.7861
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1mdjLZsO5mPSpSHclz3eBf7eVkX6G0NCPxIr5fMY9qzW0NPIU7UynFq844sOxVcJ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6339
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Jun 01, 2023 at 11:41:24PM -0400, Dennis Dalessandro wrote:
> On 6/1/23 6:54 PM, Jason Gunthorpe wrote:
> > On Fri, May 19, 2023 at 12:54:14PM -0400, Dennis Dalessandro wrote:
> >> Here are 3 more patches related/spawned out of the work to scale back the
> >> page pinning re-work. This series depends on [1] which was submitted for RC
> >> recently.
> >>
> >> [1] https://patchwork.kernel.org/project/linux-rdma/patch/168451393605.3700681.13493776139032178861.stgit@awfm-02.cornelisnetworks.com/
> >>
> >> ---
> >>
> >> Brendan Cunningham (2):
> >>       IB/hfi1: Add mmu_rb_node refcount to hfi1_mmu_rb_template tracepoints
> >>       IB/hfi1: Remove unused struct mmu_rb_ops fields .insert, .invalidate
> > 
> > I took these two
> > 
> >> Patrick Kelsey (1):
> >>       IB/hfi1: Separate user SDMA page-pinning from memory type
> > 
> > Don't know what to do with this one
> 
> I'm not seeing why it's a problem. It improves our existing page pinning by
> making the code easier to follow. It makes the code easier to maintain as well
> centralizing the pinning code.
> 
> > Maybe send a complete feature.
> 
> It is a complete feature. It's just a refactoring really of an existing feature.
> It makes it more flexible to extend in the future and is the current interface
> or psm2 and libfabric.

If it was refactoring it would not add new uAPI.

The commit message said this was done for 'other than system memory'
which the driver doesn't support.

So it is all very confusing what this is all for.

> Now all of this being said, this is starting to concern me. We plan to start
> sending patches for supporting new HW soon. We were going to do this
> incrementally. 

I think we said long ago that this was the last HW that can use the
hfi1 cdev.

So you will have to think carefully about is needed. It is part of why
I don't want to take uAPI changed for incomplete features. I'm
wondering how you will fit dmabuf into hfi1 when I won't be happy if
this is done by adding dmabuf support to the cdev.

> Is that going to be considered an incomplete feature? Should we
> wait until it's all done and ship it all at once? I was envisioning doing things
> the way we did for rdmavt, showing our work so to speak, making incremental
> changes overtime as opposed to how we submitted the original hfi1 code in a
> giant blob.

I think it depends, stay away from the uapi and things are easier

Jason
