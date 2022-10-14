Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4E535FEE5B
	for <lists+linux-rdma@lfdr.de>; Fri, 14 Oct 2022 15:08:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229550AbiJNNIo (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 14 Oct 2022 09:08:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229504AbiJNNIo (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 14 Oct 2022 09:08:44 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2050.outbound.protection.outlook.com [40.107.220.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 155671CBAA6
        for <linux-rdma@vger.kernel.org>; Fri, 14 Oct 2022 06:08:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fzFB99RuxR3+vJ7YD5p6vrCP1qOK8B4my/I0TugOnIVTnxs0KZvM3WXGW+wLqRtkZFT1Y4T4G8Srm/wYENeA6oj0kkGUJG9cUQtPm06MLCsjEc3U5VGQobjwTW9ewzYJysdr4wxIO7UxxZWKCq6eftpDg8L6Wo/xuJU2c2kBr/BLgxP9VOcAv0kzXpDFxZ4yvlDt0kmr7HCmEz6Jn874QVzAjqH+iSgrdLwtPQNxiRTR9wCZCw1CRL6ErP0zjM9PmETlwq9orKEDGtM2hoxo7Ui6KO/ZNtNzfCSv3iBKm9uIZw4/h0VXfHvxQdy/Qa6W7AldInkI0IG1fzM4eqNfVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7gWmJ1YOQIOLDB5K1s+ID+3p/gaBnsy6oYGKI1cy0g0=;
 b=auvUOyqAhJIEUMhWWUrV9/OAliJoBcWtMDOCRIwxZseYEwhpwv15F+Ci47wYCW+iAOb27cHuH1zEBkadaZ0XYUTNlqNBEVlNCMWkL2/f9vdloaAb/t3NNJyMO6AKcW75+/BGrChbw6lOr8HQ+yf1Paqb2R+TCurJEvq6SgmiQPgKglI2g33pQ0RHUxXFWQ/xOL+kcoKt1dEZGR+w6zdQ6C5g3kSyK17D9Jb6L6aQL8i+pC7zhJokOz3qpogyPwo/FWomrRraQgMhKtJQGfRu3LtmhbBJlm/XtA3/UK3W+EmA4VlKyA4RwL6X7C+dVrmpLgTEEspqt8qDSkcgHJutbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7gWmJ1YOQIOLDB5K1s+ID+3p/gaBnsy6oYGKI1cy0g0=;
 b=LEkFoWglGH8HuqD4fqH9Z9aXkPJ8WX8gurX+ykTy+3/dpy6R8MIvQyQ6xGB9nbfG7TXaztsPpgIgumeV2q3A4JEfwr8+GGWUfVhUN74COoHnQM4Ta6rPYuVjWMyEtZj/FWqQe8o7p/wjyKQS/yEQIo+Lcr8e/5R5p8FIDA4Mm3j7zGqTe3WKovlfDYeJExHLjH29tzc/5fV0/+6qWWlm0zXXL3lD93aEO0vghINaY+wXwNebrxX1CVw7wznTPwHIkO1uE1GqNn6RLtvA21+gTCkzC7QUARA6moxiFjywvXIEwFF73SZW/iotyGNmzVpS2y2brolL2qomNXz1durNOw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by DM6PR12MB4340.namprd12.prod.outlook.com (2603:10b6:5:2a8::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.29; Fri, 14 Oct
 2022 13:08:40 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::7a81:a4e4:bb9c:d1de]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::7a81:a4e4:bb9c:d1de%5]) with mapi id 15.20.5676.032; Fri, 14 Oct 2022
 13:08:40 +0000
Date:   Fri, 14 Oct 2022 10:08:39 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
Cc:     Dean Luick <dean.luick@cornelisnetworks.com>,
        linux-rdma@vger.kernel.org
Subject: Re: FIXME in hfi1/user_exp_rcv.c
Message-ID: <Y0lfV7rX9NOOo1Bj@nvidia.com>
References: <c56dbce1-7d63-df20-fd2c-577ca103d8de@cornelisnetworks.com>
 <Y0gQwwaHGq2Uj5f/@nvidia.com>
 <b2274301-bf82-f3cf-20ff-0fc19b2014fd@cornelisnetworks.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b2274301-bf82-f3cf-20ff-0fc19b2014fd@cornelisnetworks.com>
X-ClientProxiedBy: BL1PR13CA0090.namprd13.prod.outlook.com
 (2603:10b6:208:2b8::35) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|DM6PR12MB4340:EE_
X-MS-Office365-Filtering-Correlation-Id: f9087d1a-a431-40b0-bf79-08daade536c8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dOq2McKvZUEAF7cGX/G7xRgzrSZH8HsEXqAZfZ8mGyDszKxQhB9cUtkGvKzDSGTQlcN+kPocoT10f6OdwLlJyW4bAb+CzBxhB+LBwkVvXCZfv+KvIE32wkMl12R3fQGk9TKKp3z93gctG2rE0RbWp5Q7pIl+gq5f01daJNUEcE0kLvhi0IZi/V+9yJciws2mqqKe4U/HTF1C2gjq71jH7dRvYwx4xOao3kd2rU2SytZVqad8uRSLh7kCDgvkEz5XCB3FNR/HSN7wBb8aT+z08Qmp798jIh0nvHWzVEBJxlIfRJq+rlHGKVt9FUqGVlnQOpZKuPBUTA5ztFU/FO2VaTH6RP8h3UjhD6wDzr0BssB2W/4+5fkgIR7FchPN1+79zTKr3CDTH4kGCkBR3bK83uYOKDnpFJLHBJ0G1azNGZ4g9JGnju7gS2Z4pHh5w/orK3TDKl6SVrx4GGQJ5ejigQoYldwA8zlKnXEW/7/nF48bb4Lx/9uoOmwqEWW+9+Y7Lh7Sqcl9pq6sBTg7NwnZe0WOJaVWYBkALmZhhdcwL84PEC/DhHv3Kclx0/flNyNE4Qc94pbHaNL9NIJdkzn1wSM10/Ir1HiW94eQOCotGUPp/8wB1AroY/HabsBRba9GveQtH3+9IOAacEv51FAnbomNtB11v5jxmcH/3AXk7zNkxEkiMrTPKVztzP0CeU2sTkjibAbO3yltNWTDPrE57Pb8zzauimaXasGEtkZIP4tMrXn7QWBwc5DqGTeGfPS8LF445F+wadAjFVgoIiD0Z+0tU2U2/PK2VaHPgSmIoS4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(346002)(136003)(396003)(366004)(39860400002)(451199015)(83380400001)(66556008)(66476007)(8676002)(4326008)(316002)(66946007)(186003)(8936002)(5660300002)(6916009)(38100700002)(36756003)(478600001)(53546011)(2906002)(26005)(6512007)(6486002)(41300700001)(966005)(2616005)(6506007)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?dSYbXgt7hikYR8pFMD4Zm8egm3Ehx0eGidx2B3oxqBofbfL2t9vqX2W1U2A/?=
 =?us-ascii?Q?RH3+xrG3fmkW9EyT3bIPx/GpLELBGwCZ9mJHS9HBbterpIXmyXzNs8jLonQr?=
 =?us-ascii?Q?qFhGrfL5YV0v/ecV00wftR4xOAmfj1IQe1zGWzNpaCr6ohD6/4nwBrW3PXEo?=
 =?us-ascii?Q?mNEGLoS6939jOQ5qO9fYdmbgEoQxMRV+PNU7Vu6eN5z7t78IkGysZQaCIeQc?=
 =?us-ascii?Q?qR+FDGN4Nl3moBu32E+9Q4FCAxkOFC/5mpfg/0FT43AS8Wa1qubitEGpiYxF?=
 =?us-ascii?Q?m1xv9fLIL+7Z6GLDDr1cOQIu/1/iwoNf0b5+1b1OhBh29yzr8JxRgQGbr8BY?=
 =?us-ascii?Q?1vMTUTLQvqbZbZ/7O5CoknSUl4xJ5LEMPHz7ylOb823yHqJTFCfkJHgbNZh/?=
 =?us-ascii?Q?myKwP2Z3g70I64fnQND3D8G+ZG+pSMMs83lx3jCPhTeXOTg5FOuyTpQNGFE6?=
 =?us-ascii?Q?ovXCeUUG0VJ8WfuXGJgsiA1XBDUo6q1+VnQke8fGBfG5b8zlUJ5VRIDsUVa9?=
 =?us-ascii?Q?6wJXYnvj/bhYEf2BtbipnCaHNKr6LZPIY5X40GbtfwRdYqj5oF0BEAMU/Ngp?=
 =?us-ascii?Q?DPuGxVsEjcflVYR3u2xkU5djt7jnGCNAFK9w3Jaq37/NgD2GWdU8JBJGWRvx?=
 =?us-ascii?Q?s2frsw+PMbTCGu2QNg9lGogQUppKMKBs85wuXc983i5Gh5ghqTN1VemEauI8?=
 =?us-ascii?Q?N+Ylm+poshb9fZlig/M9pE0rDCQMju6RrHUEqD39tvhC84e7xQrTwSnSgAm5?=
 =?us-ascii?Q?UklhIxkl9Wp43KqLoLktXRLAzERV3p2V+kWFR2L5SSkw1sYmAPl0rD7U+rrb?=
 =?us-ascii?Q?ivSmHCUnGQhgYccYzK6LmYxcGjjPwhcPZj3RBzbViEPym6ADMxNwgRm2bHHG?=
 =?us-ascii?Q?0/UlEB1Mkgxz6R8ePbPX/hAFSZsBW6F2QpqzgQMDFzMy5LTduBgpAA4MuLIx?=
 =?us-ascii?Q?x57JIQmBLHCtgFE6jM5cdz+uwrXWcC82VfStHsV/KXnleHj/L9DXhYYSKhoR?=
 =?us-ascii?Q?DGQ1qUgcNXlGTo93J0BqLVGaiPr8JtYG+Z/AbkuKtCbdpvyV1vnIP3LxF8wm?=
 =?us-ascii?Q?hY78DKYt1n9E0joEyTDY9EfDBigRL38FOL/RRr6iznJoYc0BTX8d8KVuqXSt?=
 =?us-ascii?Q?Yjl2jC+CWJuWVpit4ps9ShnsyzkS/AZ5hh9QUUnEVeskHyDgTMCXgCd/7t33?=
 =?us-ascii?Q?9zIbGsLNxulwre2qB1xuarSmmirS4+W3YbOchyE0o5hq1ZMjgVCsrujxtnJP?=
 =?us-ascii?Q?JV2x/k4e4e6psRq2j3vRDNsGsQVjgokDVjT479QQ8UwXUYiyO8Xi8wGFK9mT?=
 =?us-ascii?Q?RRqoKKeuIkpgkEtPBs95oE1Q8fCLaV1lDp53kLPVNnO4Q2cdfI2zAWBpBAcv?=
 =?us-ascii?Q?y1qW6YMz/ZUOu+iI8eQe5kdR4Jjz6+zTEGsXc0aF5lsipxYTzTCPjwOLPIhU?=
 =?us-ascii?Q?eldlJcxO6UjHy31NFSMcZOjTjaMPbt/l6RXrj8hBffEDqPX7euYo6sZdM3Gd?=
 =?us-ascii?Q?BtADV7+iPVTNPxAyE64PK8aHul/IurN+bYFOzhZ9T9r4NW2Wb8a6dcTamLs3?=
 =?us-ascii?Q?TPxIOV2Hiq/V6zdocu4=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f9087d1a-a431-40b0-bf79-08daade536c8
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2022 13:08:40.5994
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vpTQfHaM3mXJ3PIxtelc9W4wOijBs8aIpX+eRHceAaIpggrtUERwoV/Cfj92iLtl
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4340
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Oct 13, 2022 at 09:48:29AM -0400, Dennis Dalessandro wrote:
> On 10/13/22 9:21 AM, Jason Gunthorpe wrote:
> > On Thu, Oct 13, 2022 at 07:59:52AM -0500, Dean Luick wrote:
> >> Hi Jason,
> >>
> >> I am looking at the FIXME you left in hfi1/user_exp_rcv.c with git commit 3889551db212
> >>
> >> Link: https://lore.kernel.org/r/20191112202231.3856-7-jgg@ziepe.ca
> >>
> >> Can you please explain in more detail what made you add the FIXME and what may be "racy"?
> > 
> > The comment seems self explanatory, the ordering is upposed to have
> > mmu_interval_read_begin() done before the page tables are read, not
> > after - since we already have a page list at this point it can't be
> > right.
> 
> Is the race you are worried about here when a user proc tries to free the memory
> before we get done handling the IOCTL to set up the recvs?

The mechanism of mmu notifiers allows coherently reading the page
table with a notification when the read becomes invalid. If you don't
order things properly then it just doesn't work as advertised.

Jason
