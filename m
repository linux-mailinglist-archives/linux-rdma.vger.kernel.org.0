Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D8E393582AD
	for <lists+linux-rdma@lfdr.de>; Thu,  8 Apr 2021 14:04:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229837AbhDHMEf (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 8 Apr 2021 08:04:35 -0400
Received: from mail-dm6nam11on2084.outbound.protection.outlook.com ([40.107.223.84]:37335
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229964AbhDHMEd (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 8 Apr 2021 08:04:33 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lUqhnp8sITzcMcDmi0wxdCabhMOFSQqpPmwLevAzUkxdoWMtWWIA0+b+EoxSFjoLOUtdjE+gEdbk4C+zvg0YSwcpi7vFqhgPFjZz5j0SlWFp0sRSoswXgfhAO17F+kQsJoHYM7BuB23uyx1Az3yNAtAEbYcb42K9rJuFDesyvL2R+VVVkhST//vdTgU9g+NtDC9+mELd+JI5FVGfKeMgfaIfjJT+wOnlx457PstSh1Ne+L2Wt6oSkyFN0WdVqSLBtiVVnHf2dZUI+dEZXpevaupx4WcmvxOiZzqTl+D7LS5CfA56tFzjeBzymJ0ZSEoHxkanrbsYedeUyvh8PBzR3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7xcE3BcjqvF50fV8UpR/9mXgtwXpqaergATY8dZnFnE=;
 b=EJ61OVTuLzRohhky1V+ZKycvL3aSwx6VImjOsx76N45nwK7QRJTbWH6h1i0zDea4JbR2vZYDcEdruxIg/H3dsBEZhzpKObI9vWSRGpIvF3qfFbBz2iqGbAbRmVYmM/ofiP52LJl8/Wd6KUM6/UD7hTRUf1o9t/dNanj2j9lW1/m9t2t+/JjmEBtw42rbO+EvkF2oEeCSsPxe+e1cE6i7GrIYOqwO+VnDm63E+v3tUMTlnvCdCHGOkQomjENDd9c2h4IvLpLIj/t6tWDML/wX1V2qu/huhXiT07Q+3q52lwKxwhCtSlIfUNdOd/CXH5BS+ov0EOD6lWn41jg3YQaj1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7xcE3BcjqvF50fV8UpR/9mXgtwXpqaergATY8dZnFnE=;
 b=rtvI0SPbq/BAT/5V2mDTymBPRsTaZXVRxaR3xfBRqEdwH8Crgm2Jk0fcxV/wXQXXvLJMkF9YV7XP91TBV5DDonhup1567oNv9A3jLJYm4PB1dkv9dXAMABr+KuoQGXqVI5K7IB3y8CShxxW0uM6j3RcSPjZDEfdliDxe6r86lRO5pM9v3oOgFNYKgMeXiMxKqtFUeorxt2CItHs+gMPzG0hEEbnGHWB+mrM+1ZhB85tYQXNAE94zDlDAtZWTsvybWg1/jpwAjwvObtGvq95t4JQXUxoKWZTzsuAUlPJPhM6/6Fl6KE7yZ4DJmPFdyPrvP6eg4/S1oXhAS3+VdblUCw==
Authentication-Results: ionos.com; dkim=none (message not signed)
 header.d=none;ionos.com; dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB3020.namprd12.prod.outlook.com (2603:10b6:5:11f::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.18; Thu, 8 Apr
 2021 12:04:20 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1c62:7fa3:617b:ab87]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1c62:7fa3:617b:ab87%6]) with mapi id 15.20.3999.032; Thu, 8 Apr 2021
 12:04:20 +0000
Date:   Thu, 8 Apr 2021 09:04:18 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Gioh Kim <gi-oh.kim@ionos.com>
Cc:     linux-rdma@vger.kernel.org, bvanassche@acm.org, leon@kernel.org,
        Doug Ledford <dledford@redhat.com>,
        Haris Iqbal <haris.iqbal@ionos.com>,
        Jinpu Wang <jinpu.wang@ionos.com>,
        Md Haris Iqbal <haris.iqbal@cloud.ionos.com>
Subject: Re: [PATCH for-next 12/22] RDMA/rtrs-clt: Check state of the
 rtrs_clt_sess before reading its stats
Message-ID: <20210408120418.GQ7405@nvidia.com>
References: <20210325153308.1214057-1-gi-oh.kim@ionos.com>
 <20210325153308.1214057-13-gi-oh.kim@ionos.com>
 <20210401184448.GA1647065@nvidia.com>
 <CAJX1Ytao0LMYkGPy+E4XQzyxZFSytRDuwB2By2HQ6VBS7btCWg@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJX1Ytao0LMYkGPy+E4XQzyxZFSytRDuwB2By2HQ6VBS7btCWg@mail.gmail.com>
X-Originating-IP: [142.162.115.133]
X-ClientProxiedBy: MN2PR20CA0002.namprd20.prod.outlook.com
 (2603:10b6:208:e8::15) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (142.162.115.133) by MN2PR20CA0002.namprd20.prod.outlook.com (2603:10b6:208:e8::15) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.17 via Frontend Transport; Thu, 8 Apr 2021 12:04:19 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1lUTOU-002hNr-P0; Thu, 08 Apr 2021 09:04:18 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 65fa0856-db31-415d-ce5a-08d8fa8670d9
X-MS-TrafficTypeDiagnostic: DM6PR12MB3020:
X-Microsoft-Antispam-PRVS: <DM6PR12MB302063C6C7B07FB2CE1F2550C2749@DM6PR12MB3020.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1443;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: arubX5THcOre49qnZdMOnVhdTqgvirRrd/w3ErnmQ994U72qiZZm+yabtXj8ZXUDxZANDFEYoD28js0n8dRLQxXh6uKqrErdiO0jnxCrUhnMnisd3hbbvnYtwxWztz4fbb6SiqL0jaeXXNUhyesTb4tRopgwMw/4EuQQi0DG0z5Qhsb6iSY8MB7H1VpQJVCJ7XuBO3C89RQyJJJQdLRFdri+jrdaC/SK8RuuVNcYDrLr9NZJ+pA2rFoXRyjudVBWwE0JT3vcs4I6JMGJ9K7MICasPLd9q9dD9TPF/v7lmdrTk3m3ACrxslTb6Asm0IkDANbzZbP5ec4GafamRNroZzTYmnwqFKxcMtOVIpj14As9yCle12arDajakJ8SwQG8TaTRIEp52fDm9LZi3rjW5TtWtl/96RGSjoi4BvecU4UXW+qHwS6f40C9xf1+z88PrC7EPo+6piyJcDiyvWPsxZwNfZwYd6zuCYUq3PtlKmafBp+fwg2ND3w7P73mOHys3Uii1ZBDsegdiFp7tb8CUA0Kh91uEkFs7iZq/n2krrpc8rueu9AxDoCDro/hrLg1cbmqjAlELCO7oSVx48hB2LDor1YShuutzqf+sgbWtdKwDM4T9q3hEfiUcPaqcqaYGRNx+UlXmEkNYLMCsGipdLX2oQlCGPihXogpGu1bBfg=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(136003)(376002)(39860400002)(396003)(366004)(36756003)(5660300002)(6916009)(316002)(1076003)(426003)(8676002)(54906003)(2906002)(33656002)(83380400001)(2616005)(53546011)(478600001)(66556008)(66476007)(4326008)(66946007)(26005)(9786002)(9746002)(186003)(8936002)(86362001)(38100700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?P3beqCWST2gpFNAsPp9RrlHRjl/SRlHX+MU+85fpUdQdHK4otlJc4ZD7pFI+?=
 =?us-ascii?Q?ioXh3QTtglT2dccov3TfHNkUiR+pH3k2eHJS6SRlib4KGU09GYqjy55SDrBQ?=
 =?us-ascii?Q?EUXA9VQ0O7fHB7vAAu4m5CJQpNqrBjY/BbEB4CP4UBiP5Ij42IQcIfH7YmVs?=
 =?us-ascii?Q?GiTJEWxpWeLD7zKoCoKfB70xoBDPuXFh1MUKxhLJ8lfpIaOEiWfq+j6rCIot?=
 =?us-ascii?Q?6uX26XiKlkNWxjGPCmm1+XnNocZ1QMPHAQQdn2ujHk6xM1L1qSbjHl1rtrcI?=
 =?us-ascii?Q?Tw9xwiNfJa5xjRcHTpjX3xxFUthEDNbs67s4ymuEuzAcPvszfu0HKSKlCbYR?=
 =?us-ascii?Q?v9d3SjAb3Q7IfCphUorQf2ivi7EqPID5/tRoka07SOLSJFNcprqQlUopsFGW?=
 =?us-ascii?Q?oVr8jbfGp0tJLNGpIRIex8Fr2S8+VjADNicknMwnN6JOzjAGPbLe/Elz/azL?=
 =?us-ascii?Q?y/7+5QPKLJ6/eqyl/+T80oM428CZ9rF/gKok27yjWe2teKJ5yk3OH/tVbhsq?=
 =?us-ascii?Q?RfYM4FGAMxzr1aU9FdaF5QyVA7Uqn8kjDhOWwpbaYbnyhTifVMP0ivynhYNm?=
 =?us-ascii?Q?h0PVfPNrf1Lh14VtLx9qr/Ee5fCVQsxP5Oiwr2LUt/AhQEbddzjfWVwa+Yqa?=
 =?us-ascii?Q?nPHap3It9zAzjQwX4u80H9H7prUf2n+hgUicfIw/7SL5VD0jlf/ZMj2Si4dM?=
 =?us-ascii?Q?EKYGtiwVPDwNfVBW73IEFi3/B5NeIAMj9S7KyN/ZNSbvhy7Ip9oyVP6gW+lK?=
 =?us-ascii?Q?gRIBDsLYx/WV2khXSYBb9NbrU0xBIYG1m1I76JgLbrvG6j4AXEc27Hn3h8WH?=
 =?us-ascii?Q?db1adYMMC5s/6GajCYlOT/h+eOn9PtndUP2Bws2sYfFV6IEtViFXhgGfYGmQ?=
 =?us-ascii?Q?pNScowpNvGtRohBJIV9a2qvRv2b/nDN4qFsBlLHbGESXCMt/Xi0LgKfO2wjm?=
 =?us-ascii?Q?2bCvA9BH5Et2jf621LdvQ3ivliCdv/mQLpG9HtKmh2d9QHXBZ4OkTqB/+ZNQ?=
 =?us-ascii?Q?bfDAOuM5FuSshKzaO7zDhuqxC8hamXl1t7B/v16LErNY5vDC7mDmluXBOB+t?=
 =?us-ascii?Q?m6w7ot3AWJ0DVH4E8upEZ6FCVBOSPmOZSL6VVWal3qEUQKknFyott3Kg/4f1?=
 =?us-ascii?Q?oPQkthb+TPRKEs5yJgaYa3P4rpHWF8xI8eEHDEZyVq7DmKxmf2Nxusy/dKUA?=
 =?us-ascii?Q?+rpG1HurePm6ZoYFAjx06MsRz/VSFvA06FqHXXnBcLgPAgLH8cwg0l0dZk/u?=
 =?us-ascii?Q?MRVfkFd/Ub1vyRaxgSGhfc5yJQlx6BJjn2vUgRY0yVYjDCg8r7fmlQqv5od5?=
 =?us-ascii?Q?3XbsAjUAmZ6oJ286GtgzP5tVZaXm1lFCTSBx6ae0ErzIsQ=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 65fa0856-db31-415d-ce5a-08d8fa8670d9
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2021 12:04:20.0977
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1OmPeWIggzVLLbOuIJjzJcOSbUJdtI7AYbwrAYfD75vVRnkoFe4rDvOViIXUNpkJ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3020
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Apr 06, 2021 at 10:55:59AM +0200, Gioh Kim wrote:
> On Thu, Apr 1, 2021 at 8:44 PM Jason Gunthorpe <jgg@nvidia.com> wrote:
> >
> > On Thu, Mar 25, 2021 at 04:32:58PM +0100, Gioh Kim wrote:
> > > diff --git a/drivers/infiniband/ulp/rtrs/rtrs-clt.c b/drivers/infiniband/ulp/rtrs/rtrs-clt.c
> > > index 42f49208b8f7..1519191d7154 100644
> > > +++ b/drivers/infiniband/ulp/rtrs/rtrs-clt.c
> > > @@ -808,6 +808,9 @@ static struct rtrs_clt_sess *get_next_path_min_inflight(struct path_it *it)
> > >       int inflight;
> > >
> > >       list_for_each_entry_rcu(sess, &clt->paths_list, s.entry) {
> > > +             if (unlikely(READ_ONCE(sess->state) != RTRS_CLT_CONNECTED))
> > > +                     continue;
> >
> > There is no way this could be right, a READ_ONCE can't guarentee that
> > a following load is not going to happen without races.
> >
> > You need locking.
> 
> Hi Jason,
> 
> rtrs_clt_request() calls rcu_read_lock() before calling
> get_next_path_min_inflight().
> And rtrs_clt_change_state_from_to(), that changes the sess->state,
> calls spin_lock_irq() before changing it.
> I think that is enough, isn't it?

Why would that be enough?

Under RCU this check is racy and effetively does nothing.

This is an OK usage of RCU:

	list_del_rcu(&sess->s.entry);

	/* Make sure everybody observes path removal. */
	synchronize_rcu();

And you could say that observing the sess in the list is required, but
checking state is pointless.

Jason
