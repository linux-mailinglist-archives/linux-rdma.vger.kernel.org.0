Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD932258ECB
	for <lists+linux-rdma@lfdr.de>; Tue,  1 Sep 2020 15:00:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727109AbgIANA2 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 1 Sep 2020 09:00:28 -0400
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:3957 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727796AbgIANAS (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 1 Sep 2020 09:00:18 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5f4e45cc0005>; Tue, 01 Sep 2020 05:59:56 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Tue, 01 Sep 2020 06:00:10 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Tue, 01 Sep 2020 06:00:10 -0700
Received: from HQMAIL107.nvidia.com (172.20.187.13) by HQMAIL109.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 1 Sep
 2020 13:00:09 +0000
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.36.50) by
 HQMAIL107.nvidia.com (172.20.187.13) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Tue, 1 Sep 2020 13:00:09 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MX1HB0leu3t3zimSDKvtuZdKA5hbRwQfDmYxiHM5hFueVMhHucGStMnlL1Nxw0/N4ZgUjU+l264KP/HAq08eiz1UD2a630lJ5lpT0y4QcyQtq4Bnglrbtw6QoKM90pOQFHQmt8iS2ebCD8P0HwpRmv5AIxCzfqfheimHyLjU7e7fnFu1oZnTbWDOmn+l+RbOfIz4zzp6OGuROohcAlHnnMDzABVvhzbnb87NpZlXgYD726rPAqA4B7uqmy0XvWbFWfh6EppQTatnHiDmkl/o3ba2T5kCfysvFAWfb2fFd/C6OPetzDGY2GV9cgR7NcZdzZKag9lT1kTnWtsmzJ49og==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/4H2+GOYw2AL+kZJIC4g5w+9n3GdNbJvDYiXPydffCE=;
 b=GE8jX8L+PLcy4fEmQZ+t8TPPFOYQ8QPUSh3kDvc6k5ue+ct0BYQppPQ6klTts5DDDqvaD0wn4xMR/FLTt/C9R/qCcPM2j5IMf9aS8LgvoZStmF5UWwWahQ3+Jznii47PJBFxV60uhxQYm/4z/5qxACcRRkXSA1B6xRQ0TyTS0Iscs5ashBaZ6w4z9PqFiIziGif6z+jGWnzRtgPSlj5mEQDVrAggKsM5LedF+O3ZUrNIT5T8WB2VJr/hWeeZYorff3CJFmhooXNuUwl3QxNB2ptW9TnKzG+4W1bQBx1wghLravks9Jhan+++dpqSiNO5Ccm2f+tgT5SouLoxXCRwDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Authentication-Results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB3515.namprd12.prod.outlook.com (2603:10b6:5:15f::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3326.24; Tue, 1 Sep
 2020 13:00:08 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::2d79:7f96:6406:6c76]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::2d79:7f96:6406:6c76%3]) with mapi id 15.20.3326.025; Tue, 1 Sep 2020
 13:00:08 +0000
Date:   Tue, 1 Sep 2020 10:00:07 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Dennis Dalessandro <dennis.dalessandro@intel.com>
CC:     Jann Horn <jannh@google.com>,
        Mike Marciniszyn <mike.marciniszyn@intel.com>,
        Ira Weiny <ira.weiny@intel.com>, Linux-MM <linux-mm@kvack.org>,
        Doug Ledford <dledford@redhat.com>,
        <linux-rdma@vger.kernel.org>, Dean Luick <dean.luick@intel.com>
Subject: Re: buggy-looking mm_struct refcounting in HFI1 infiniband driver
Message-ID: <20200901130007.GN1152540@nvidia.com>
References: <CAG48ez2EFXnDEue=bOs6n01FHGa4rUnwET6hBVNjcKoMjR9Y_Q@mail.gmail.com>
 <20200901002109.GG1152540@nvidia.com>
 <624472c4-b585-e950-78b2-eff860f24d64@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <624472c4-b585-e950-78b2-eff860f24d64@intel.com>
X-ClientProxiedBy: MN2PR06CA0016.namprd06.prod.outlook.com
 (2603:10b6:208:23d::21) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from 255.255.255.255 (255.255.255.255) by MN2PR06CA0016.namprd06.prod.outlook.com (2603:10b6:208:23d::21) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3326.19 via Frontend Transport; Tue, 1 Sep 2020 13:00:08 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1kD5tP-0049zY-5w; Tue, 01 Sep 2020 10:00:07 -0300
X-Originating-IP: [156.34.48.30]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5ecbfed2-0203-47be-f6fe-08d84e76f445
X-MS-TrafficTypeDiagnostic: DM6PR12MB3515:
X-Microsoft-Antispam-PRVS: <DM6PR12MB35153F92019A8634A984350EC22E0@DM6PR12MB3515.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Wk54Hm6nlvmNs0SMwv+A/j6io9AkCxNLYvpGgoEckHhjUC3OPoMTPwdn+U3htTyq5GXXCV9WrsCGHXc42cfg2kJwcCCH5KvrtRedgIeFNt2flMTfeSLN7EUgZBsKSmGmNNhvHaYDDFoLRYT9ySSkpuXwdpB3r/s3bFHNUP/USrucenhZZDjZS/dT7eT0+lMazuW6CsOEPpGNAxMR0aJ9vDfszKMH+pic+J+uUdHEtKd9xY3n7tfw0LYqjaB9qexpSXAY7FnH6k7g/dSzXIytKu6QjG1AgFO/cUSIzof7PSNJoC5YN8jUt76y+o7mVfV/y11Ivzg/KU2bo7Uwqn4gSg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(376002)(136003)(346002)(396003)(366004)(1076003)(8936002)(8676002)(5660300002)(26005)(426003)(316002)(186003)(53546011)(2616005)(54906003)(36756003)(9746002)(9786002)(66946007)(4326008)(2906002)(478600001)(83380400001)(66556008)(86362001)(66476007)(33656002)(6916009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: hWe7Rcpz8ywxA2eYTwzXL6tRZC9/843z53dwVDdVM8MnpCcI1DokTf1jjOR07Qghg8tIdFhlDtQX5n4GavN2/gOh3smpFLhMmtfj1uVkf6KgHzBXSoSpmQGmWnL1lsgU6MsW5XBdeg+F7saliTMCFcmBfRakgu/LyxABiUlP6hidDzMef+DobV+tPzSy0/fO9EUG0e2Y1ePxHUytHdRP3pR6bZCkgtGdO6XSISuYaS/4XmWDT6Fv1GvyAjxfo+Iylf1aOU7Rnap5QU7XtXGIE9NpG4pIpbN8dA1l1UQsRgBvD7sLOad/p5SEK4e5GcGVG/S1v2ugGCwatI17BCSDcBGBKrGryrBgQyIfweANkftTkYCoxMeR92FvtcweYDtnCNuxuYOEoNKYomebWUVYy3g4nZpfXRyw50J3QargO6JQAGOXVsCryK2HdK4auzBbLucTm/49yxWJa2ULIXM856PVaLYEDSLPO9vRgaat1uEDzdbHunkM2UtKJW4/BcskBWdeLYUxhYID5sKtXwlcFcB7Bk4O/aN1sF4De6nOcW6plNUpXUxhJoin1QXAol3d5IdZEvZBnZfoNc8gAkTadPCV1CtBElaA58GKpsEzHGIfF6QugL/OvSnWIfS5+0ZKv2SxY7H9617n3ggipGsa/A==
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ecbfed2-0203-47be-f6fe-08d84e76f445
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2020 13:00:08.6797
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KyuhAFytEuBeazVe2sSbFeotnL3oTNd/aVXS4w3nHO74Tuf6dkSo5xMvLzFpGFxP
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3515
X-OriginatorOrg: Nvidia.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1598965196; bh=/4H2+GOYw2AL+kZJIC4g5w+9n3GdNbJvDYiXPydffCE=;
        h=X-PGP-Universal:ARC-Seal:ARC-Message-Signature:
         ARC-Authentication-Results:Authentication-Results:Date:From:To:CC:
         Subject:Message-ID:References:Content-Type:Content-Disposition:
         In-Reply-To:X-ClientProxiedBy:MIME-Version:
         X-MS-Exchange-MessageSentRepresentingType:X-Originating-IP:
         X-MS-PublicTrafficType:X-MS-Office365-Filtering-Correlation-Id:
         X-MS-TrafficTypeDiagnostic:X-Microsoft-Antispam-PRVS:
         X-MS-Oob-TLC-OOBClassifiers:X-MS-Exchange-SenderADCheck:
         X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
         X-Forefront-Antispam-Report:X-MS-Exchange-AntiSpam-MessageData:
         X-MS-Exchange-CrossTenant-Network-Message-Id:
         X-MS-Exchange-CrossTenant-AuthSource:
         X-MS-Exchange-CrossTenant-AuthAs:
         X-MS-Exchange-CrossTenant-OriginalArrivalTime:
         X-MS-Exchange-CrossTenant-FromEntityHeader:
         X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
         X-MS-Exchange-CrossTenant-UserPrincipalName:
         X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg;
        b=OQtuZj2oWhxlItilqP5ow2vJ1ldO9ro3a62UT0Rs+lirdAV6f53zviRQEJf20DTrM
         FUb2YJfpGBl/hRllZF5J9QXF4ssirPFh4CGeq+rq03AC4fwjTO2HgM7F00HlpYT5jn
         5VSnANMgB/0wcTFiF9xo5Kv5UdW5t4Vj/c7Ta8Eqnpd03TMbiP1cZltE4FQee12e2l
         SKp313Vi2ZTnZAxwnmWvqcushIzKpJO2A9XJg2N9b8hla0N3tq+CTt+d6yWXwkdIZy
         Jmsle2kX5fSO9wAhv7rGD1eUgI5gbWrE/bPP/AG7TSUv13asaJO2Tx3tesITxQge93
         4pGoK4/jFJHBw==
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Sep 01, 2020 at 08:58:18AM -0400, Dennis Dalessandro wrote:
> On 8/31/2020 8:21 PM, Jason Gunthorpe wrote:
> > On Tue, Sep 01, 2020 at 01:45:06AM +0200, Jann Horn wrote:
> > 
> > > struct hfi1_filedata has a member ->mm that holds a ->mm_count reference:
> > > 
> > > static int hfi1_file_open(struct inode *inode, struct file *fp)
> > > {
> > >          struct hfi1_filedata *fd;
> > > [...]
> > >          fd->mm = current->mm;
> > >          mmgrab(fd->mm); // increments ->mm_count
> > > [...]
> > > }
> > 
> > Yikes, gross.
> > > However, e.g. the call chain hfi1_file_ioctl() -> user_exp_rcv_setup()
> > > -> hfi1_user_exp_rcv_setup() -> pin_rcv_pages() ->
> > > hfi1_acquire_user_pages() -> pin_user_pages_fast() can end up
> > > traversing VMAs without holding any ->mm_users reference, as far as I
> > > can tell. That will probably result in kernel memory corruption if
> > > that races the wrong way with an exiting task (with the ioctl() call
> > > coming from a task whose ->mm is different from fd->mm).
> > 
> > It looks like this path should be using current and storing the grab'd
> > mm in the tidbuf for later use by hfi1_release_user_pages()
> > 
> > The only other use of file->mm is to setup a notifier, but this is
> > also under hfi1_user_exp_rcv_setup() so it should just use tidbuf->mm
> > == current anyhow.
> > 
> > The pq->mm looks similar, looks like the pq should use current->mm,
> > and it sets up an old-style notifier, but I didn't check carefully if
> > all the call paths are linked back to an ioctl..
> > 
> > It doesn't make sense that a RDMA driver would do any page pinning
> > outside an ioctl, so it should always use current.
> 
> I sort of recall a bug where we were trusting current and it wasn't correct.
> I'll have to see if I can dig up the details and figure out what's going on
> here.

The trouble with not using current is it opens a security issue where
a process can access memory it shouldn't be allowed to access.

Jason
