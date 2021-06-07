Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F86539DCEF
	for <lists+linux-rdma@lfdr.de>; Mon,  7 Jun 2021 14:50:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230145AbhFGMwI (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 7 Jun 2021 08:52:08 -0400
Received: from mail-dm6nam12on2058.outbound.protection.outlook.com ([40.107.243.58]:54624
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230396AbhFGMwH (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 7 Jun 2021 08:52:07 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=htw3Te87RZaFhL5Q54+puTt9regJ16TbmsEDomqNNaGqLqyQ1H2PMbu783byopWu8M93caBOO5P1tdin08D37acT1HrlTOA6egPplA8zK78/z3i/0tvbK7vqoIY5u+T5S26WrhA6JlDKvWujcsTBbqezQL86RVuo2BcQ2s2UPe1V2ZjPpUiYceAVxs5WNM+819bNHamtNIpQP7W0OAshrxjHTL/C8hEHBtcIKQBB4TvoUPfTAqqpdqj6OKze5caf7r/RIEC0KV6MYs5wRb+qFAs4HEvZ4nTS/xgfZbcyuqZYiNxOSgAez/uWHPfZ4pn6NJlElpNerrf6zZPitwgU/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h0X8ivA5RIbq1KQPqriIiFa4RMjlmtZOOxxBxMnHJjo=;
 b=nDihR0zGVqoKLFhyIvDzUDG9rnsy3UcskrNCf5hTT1uimLV8f7QjNjFB7A6gi7qb8I/GBEaSHYvaQmnV2P8YK2gYrMyWyE6lTYqfMLmVmMgg09bkiK2PEwCrLdc/4o+yzD95gQqBanhRT85qR5ACW1mPMpexOpcCRu0t4MfJVueUFO/+NDqaUOaZYVplT4FUJqJxZfckj2knDCjDoSAqIpFuw2PlbYmCOMsfAh3oYjKx570EISiJF7W+FeXyLIcxFDaW0xXjaHRfLdXfiSFom9KjXthxB1jM7qxXEDrSNy9VNR1rmVq69wUMdChbLlPAdJeILNYiOBfxyIvkFXieyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h0X8ivA5RIbq1KQPqriIiFa4RMjlmtZOOxxBxMnHJjo=;
 b=hW3N/R/xaJ+kP6FPiByM6y6LABiK0sGMrBuul2IFt84AdL2ty5lAE5Ex0YUUiuPfcNZzNPVQImlGnARpFRWofCU6z1Wbvv6Tt5CriLcslpTcxDUB7tSFxAwujXRCw2X1heOngLa/TeDLOaUThITPX/lXWLOyUSnUdFy62it9XqEWE0MTkY7WbN+mNYy9b/GrBHnOb56U1mz6hhrr5hYHRjhQiqAVvR5348X7Nw4txv/+Yhz0UJVLfKKqocP7JBCh+bC/pPjQ6PC2e4O1siaG9FKLdqotEGs2ITbBU1nHR8H646kmKUomf0OakEm7/Pz+RundVmOR19g9gA3KKvkqlQ==
Authentication-Results: linuxfoundation.org; dkim=none (message not signed)
 header.d=none;linuxfoundation.org; dmarc=none action=none
 header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL1PR12MB5270.namprd12.prod.outlook.com (2603:10b6:208:31e::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.22; Mon, 7 Jun
 2021 12:50:13 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::3d51:a3b9:8611:684e]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::3d51:a3b9:8611:684e%6]) with mapi id 15.20.4195.030; Mon, 7 Jun 2021
 12:50:13 +0000
Date:   Mon, 7 Jun 2021 09:50:12 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Leon Romanovsky <leon@kernel.org>,
        Doug Ledford <dledford@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Adit Ranadive <aditr@vmware.com>,
        Ariel Elior <aelior@marvell.com>,
        Christian Benvenuti <benve@cisco.com>,
        clang-built-linux@googlegroups.com,
        Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>,
        Devesh Sharma <devesh.sharma@broadcom.com>,
        Gal Pressman <galpress@amazon.com>,
        linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
        Michal Kalderon <mkalderon@marvell.com>,
        Mike Marciniszyn <mike.marciniszyn@cornelisnetworks.com>,
        Mustafa Ismail <mustafa.ismail@intel.com>,
        Naresh Kumar PBS <nareshkumar.pbs@broadcom.com>,
        Nelson Escobar <neescoba@cisco.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Potnuri Bharat Teja <bharat@chelsio.com>,
        Selvin Xavier <selvin.xavier@broadcom.com>,
        Shiraz Saleem <shiraz.saleem@intel.com>,
        VMware PV-Drivers <pv-drivers@vmware.com>,
        Yishai Hadas <yishaih@nvidia.com>,
        Zhu Yanjun <zyjzyj2000@gmail.com>
Subject: Re: [PATCH rdma-next v1 10/15] RDMA/cm: Use an attribute_group on
 the ib_port_attribute intead of kobj's
Message-ID: <20210607125012.GE1002214@nvidia.com>
References: <cover.1623053078.git.leonro@nvidia.com>
 <00e578937f557954d240bc0856f45b3f752d6cba.1623053078.git.leonro@nvidia.com>
 <YL3z/xpm5EYHFuZs@kroah.com>
 <20210607121411.GC1002214@nvidia.com>
 <YL4TkfVlTellmnc+@kroah.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YL4TkfVlTellmnc+@kroah.com>
X-Originating-IP: [47.55.113.94]
X-ClientProxiedBy: BL1PR13CA0072.namprd13.prod.outlook.com
 (2603:10b6:208:2b8::17) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (47.55.113.94) by BL1PR13CA0072.namprd13.prod.outlook.com (2603:10b6:208:2b8::17) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.9 via Frontend Transport; Mon, 7 Jun 2021 12:50:13 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1lqEho-003Gzl-Cd; Mon, 07 Jun 2021 09:50:12 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0c989740-9276-45ed-d109-08d929b2cabc
X-MS-TrafficTypeDiagnostic: BL1PR12MB5270:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BL1PR12MB5270FFB317CA74B731CBC4F0C2389@BL1PR12MB5270.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4125;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nXG/IKRqqB1+ziLvjZD1TXvelnv6NpEmaKj6zoYA/i+V74GcjvUA+i0AtsP0tMAqjUsCMXjQQ5UyChOpRRj0+aD5HKP3NQqpeC3W8Ay3r8QTPh1L/WiloYLt8K0FHklcaV5sE6PuxABF13Tzwx+p4cuUqsODmtyUqpPvJZUtlk8ZpMbgvYw8zJiJf1wEo9JJ6/sx20iWwjQkdvJN4dp9j7G078ZaqgIJUnNO7dA/i4/AyEme7saVjBi5A1EM6OPgjh3mxcwOXM1/sWYq3M7Z0mGh3QBEetRGoj0jKbcAB7IifvK8/9TvUmcLKfnbkwufVKlzOViBfKkaAskqf4c1bMt26477QHuR/aCdQbJGWiSS+e6XqIsAqQj6szzAY191MMo3XXMXNeS+7w49ep3HpoqfNEIOPalH8FCDHp8AWqXE6nNbhfBi+mgam0OPXWlG0mtcb5nYMhh6aBNcsoIzIJESr5IYZF8iEbPWNHiJdXSRWofuuqjeWFfbhKDEC6J61tVGhg4UNIF9K9dRSevbox3jjvA+vQLk7TfbIV1IKjKxRWEkXkh8bOhO8qwd1rfGGpFxuIKjbO5gt4avtvUlhAQMN3nRK40fcE5zKwBp2XE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5506.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(136003)(346002)(396003)(39860400002)(366004)(478600001)(2616005)(36756003)(26005)(426003)(9746002)(4326008)(7416002)(9786002)(5660300002)(33656002)(86362001)(54906003)(316002)(66476007)(66946007)(83380400001)(8936002)(66556008)(186003)(6916009)(38100700002)(8676002)(2906002)(1076003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?liVsfgCwHtF380dNal3j/MYTv4uwFYL+y9fqXIwJ+zg7ZL3PyDvljYL1QGag?=
 =?us-ascii?Q?v4YTv4/P/HOoRv8RC/iE/UrSUViSbxJ5FLgOvfqiNvmE3MRrZ16qn6VUM6CJ?=
 =?us-ascii?Q?0ql+srvifwha5AgGwLBQWAAOkzEzr0rfUOf1ckVO9fwpcwlCJTD/Kg0MKwTF?=
 =?us-ascii?Q?Yr4Up/vU6cpti+Jsw2zPCl97s8gLTrU2fUr2yAyyOrfVHih65Lb2RRd3kZGR?=
 =?us-ascii?Q?ZQd6liUtExs6nToFHCauxIhmlzstthxUx1LvNQmGOJWfWrtNmMhrRVIxo77q?=
 =?us-ascii?Q?D2O9vlJao9yMNxkJhXLRnJYFWy65xFdiMPNsnwWAL/EzJZQwL1/yV86xDaES?=
 =?us-ascii?Q?QOqyc3iypwYAQIfSPPpMSQKfXvdbEgaY0aNTjpYw2PeSzeACEU6mDsmNq3Z1?=
 =?us-ascii?Q?lfvdSR2BPPC7ddHSODudi/Trze5NQ60T/VPjn3uWFHUB5syFMwhf2zG6OHZs?=
 =?us-ascii?Q?6RrtM10khxkIJC2V6SmDCF8FcPIKZBZa0EbTlgj90gene1hZN0MJ1WknqanC?=
 =?us-ascii?Q?RELn7X5LCX3Ki6kr+N3YRMtXcczat7EF71N4NE7CnfEGHUQt8fOD4543/cE9?=
 =?us-ascii?Q?Q0V4R8yS44K9kEeE7MC3+uukjB9KdcnQCDdbkrfjOKzpw1Qmx9czExUsixwq?=
 =?us-ascii?Q?yVcWXd4DDgKbZglN08BhzlnCnJV4dZC4vHWUBmF8plisxpFWuLs0pI6kVI4Q?=
 =?us-ascii?Q?PhnXRfCoONCOR0kUeQOwIX5vcJQ7Z8HRL85he07XM1/L9N5ytIRBgS81P8xN?=
 =?us-ascii?Q?eibZM8I7H49sJBWwLRF3gNmLVx5FnuQ0bk3u8qVHCmpINRemVbW2pRZDEUMF?=
 =?us-ascii?Q?tdpb5q6a4rHJnbDSHRT+jT/99HPUsAJqxAUElGU9m1r+4I5kl8Ae8DeO2dpV?=
 =?us-ascii?Q?xuU6H9CqCJYHU6IlC65y83/FhLLyY/kJ7brqU2YY/RwHqv1uQk7KtpLuRmyk?=
 =?us-ascii?Q?SIfa9iHzgfhwN91Z2zXfltt/i1HKUc6fqrQDt+xrOdeZ9O+E5lALk+JQcIzO?=
 =?us-ascii?Q?zw0ZVFerFmYMQVrykqnR3tP+5hZ3hkQwLWYD1XGAYv4tf16J5Eo4wdE6loWU?=
 =?us-ascii?Q?KGKVxXIf7j2+6BabewX3EtuUBjZ6IwEfoMR2ddrNAvbKf864QzGIPjH12emz?=
 =?us-ascii?Q?kk7T/UU+Hta/nk8Uj2Ct/73xlC44Bf1M+ekF8V5O6Et8CmOLR4PKLB3C1NoB?=
 =?us-ascii?Q?PcFW/QtVKvA1JnLDuF0rr2eIVmuDAIuidZxFnVAJD4YygwK4KABrmhcDCNsy?=
 =?us-ascii?Q?OybNPpiL3RMc9rt/HF7L+sVfyljTRYdT4GwalM6c7fKHDNwYb4HLQgDowHNc?=
 =?us-ascii?Q?8ZWDFz3RzP9mVWplPY50RaCr?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c989740-9276-45ed-d109-08d929b2cabc
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2021 12:50:13.4513
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kxt9jfuJlYnuJus336vcM4EOIcswxKXJhi1q9gTEYe2/0zoZbv5OfXaAsQVB+1Hb
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5270
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Jun 07, 2021 at 02:39:45PM +0200, Greg KH wrote:
> On Mon, Jun 07, 2021 at 09:14:11AM -0300, Jason Gunthorpe wrote:
> > On Mon, Jun 07, 2021 at 12:25:03PM +0200, Greg KH wrote:
> > > On Mon, Jun 07, 2021 at 11:17:35AM +0300, Leon Romanovsky wrote:
> > > > From: Jason Gunthorpe <jgg@nvidia.com>
> > > > 
> > > > This code is trying to attach a list of counters grouped into 4 groups to
> > > > the ib_port sysfs. Instead of creating a bunch of kobjects simply express
> > > > everything naturally as an ib_port_attribute and add a single
> > > > attribute_groups list.
> > > > 
> > > > Remove all the naked kobject manipulations.
> > > 
> > > Much nicer.
> > > 
> > > But why do you need your counters to be atomic in the first place?  What
> > > are they counting that requires this?  
> > 
> > The write side of the counter is being updated from concurrent kernel
> > threads without locking, so this is an atomic because the write side
> > needs atomic_add().
> 
> So the atomic write forces a lock :(

Of course, but a single atomic is cheaper than the double atomic in a
full spinlock.
 
> > Making them a naked u64 will cause significant corruption on the write
> > side, and packet counters that are not accurate after quiescence are
> > not very useful things.
> 
> How "accurate" do these have to be?

They have to be accurate. They are networking packet counters. What is
the point of burning CPU cycles keeping track of inaccurate data?

> And have you all tried them?

I've used them over the years. This stuff is something like 15 years
old now.
 
> I'm pushing back here as I see a lot of atomics used for debugging
> statistics for no good reason all over the place.  Especially when
> userspace just does not care.

If userspace doesn't care then just delete the counter entirely.

Reporting a wrong/misleading debugging counter data sounds just
horrible to me.

What good is any debug result you get from the counter if it has to be
questioned because the counter is allowed to be wrong?

""The sender says it sent 7 packets, but the receivers debug counter
reports only 6! I guess my bug is a lost packet in the network.""

Jason
