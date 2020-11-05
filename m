Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 846DF2A81FF
	for <lists+linux-rdma@lfdr.de>; Thu,  5 Nov 2020 16:17:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731060AbgKEPRa (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 5 Nov 2020 10:17:30 -0500
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:13460 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730938AbgKEPRa (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 5 Nov 2020 10:17:30 -0500
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5fa4178b0000>; Thu, 05 Nov 2020 07:17:31 -0800
Received: from HQMAIL111.nvidia.com (172.20.187.18) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 5 Nov
 2020 15:17:26 +0000
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.106)
 by HQMAIL111.nvidia.com (172.20.187.18) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Thu, 5 Nov 2020 15:17:26 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fyQypwQGehk+Vj8VdogdFLm27HbndY1d6aFLrc2Z+65g/GKxMtCVkDgpZ5hXX2OtUrjwxfmXuPbCYU5afSFEJv9zmqTuDXy6Sd5KCFsG8EGRsGVAFWjE9CPUJ+g+wPus6Rq8plthpO2/Ahh7mgG7PoPYmuqOWwVb51Xp2RmSAwcTuZNnNUZyR9HvCly+G9yU4Eaup4rqQ3jxyhoYHLoc97xlNxbDWCi57N6S8pKEwU9t4kiXrJqY6AsdKknL2Pn3pmW4Q7SWTwbENPZDyF6MjYaADW0PTtP5mxCha1bDWyCOkMPcVjVOdqZbRjBY6TTRC1hNEGUGP143/ikLfcfOvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yOUrPPJE3D8uMKxaWp1Zaqk+nMUvK2Vayjah+LQH/FY=;
 b=LAtZnI/pYW+D9FLiLUDKfhSYPYOKaJriBp6i/Pc44jWyZqQkX0ZziSBQzooBYEWZeZ+1Y08rGDmO/fs4W6PHbd+ddhzNXq/XCpURYYrOBr1RUDnulT6wrYpSL0BVloBMyf1zFv2/3cjmujn9/LcTd9cx8xWlWhN5v3reX7U0a0xPHpF3n1tPH6hUKuSABcpzJlA1Nl1tf7eehSCq8EjaAGg6qELhcjQGLukPdlvBWS0g2BUmSQgAvcLs9ithuQmXbGSPaB+lrACV7a6fmUaV3/251UxSZAMwEm0k8xUqGV9d7iyAxgcPiIWw/tVP/HmwQSenCC//MpPBPL6BMyr4mA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM5PR1201MB0204.namprd12.prod.outlook.com (2603:10b6:4:51::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.29; Thu, 5 Nov
 2020 15:17:25 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::cdbe:f274:ad65:9a78]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::cdbe:f274:ad65:9a78%7]) with mapi id 15.20.3499.032; Thu, 5 Nov 2020
 15:17:25 +0000
Date:   Thu, 5 Nov 2020 11:17:23 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Ira Weiny <ira.weiny@intel.com>
CC:     Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>,
        <dledford@redhat.com>, Jann Horn <jannh@google.com>,
        <linux-rdma@vger.kernel.org>,
        Mike Marciniszyn <mike.marciniszyn@cornelisnetworks.com>,
        <linux-mm@kvack.org>
Subject: Re: [PATCH for-rc v1] IB/hfi1: Move cached value of mm into handler
Message-ID: <20201105151723.GG2620339@nvidia.com>
References: <20201029012243.115730.93867.stgit@awfm-01.aw.intel.com>
 <20201105001245.GG1531489@iweiny-DESK2.sc.intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20201105001245.GG1531489@iweiny-DESK2.sc.intel.com>
X-ClientProxiedBy: MN2PR20CA0039.namprd20.prod.outlook.com
 (2603:10b6:208:235::8) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (156.34.48.30) by MN2PR20CA0039.namprd20.prod.outlook.com (2603:10b6:208:235::8) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3541.21 via Frontend Transport; Thu, 5 Nov 2020 15:17:25 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1kah0t-00HOhC-NJ; Thu, 05 Nov 2020 11:17:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1604589451; bh=yOUrPPJE3D8uMKxaWp1Zaqk+nMUvK2Vayjah+LQH/FY=;
        h=ARC-Seal:ARC-Message-Signature:ARC-Authentication-Results:Date:
         From:To:CC:Subject:Message-ID:References:Content-Type:
         Content-Disposition:In-Reply-To:X-ClientProxiedBy:MIME-Version:
         X-MS-Exchange-MessageSentRepresentingType;
        b=W0kRuO82beRP/ni6cD23ZHaQYuqntRZfdeeDqyY2CwrZj/kJ6lVNJhNf11eulFvXp
         dauQ5E1YkxrUaAJnbRZjBhECP/56Q7m0YW0UHtFWkHMz4KLg6j3H6bRX0HNHNuE523
         wbvJergVkI9wqI0/gnhhDlHXojtvFVWptunr9qRWmWB9NmQ6d3gWJzICLJ8y7noxcP
         DToyMDOUsrJujBEaBHQOV0sVsisbe7WWOWOZgf24w5RcmC3DlVuaDW+c2VqbFRM73z
         J65lfjoikNDlBrr0WuL0WojMT9CCpV1B96X/2qIIO2iAUbDAuegP3Hvq/ro2GewYhQ
         gnyPFnEqB7p7Q==
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Nov 04, 2020 at 04:12:45PM -0800, Ira Weiny wrote:
> > -int hfi1_mmu_rb_register(void *ops_arg, struct mm_struct *mm,
> > +int hfi1_mmu_rb_register(void *ops_arg,
> >  			 struct mmu_rb_ops *ops,
> >  			 struct workqueue_struct *wq,
> >  			 struct mmu_rb_handler **handler)
> > @@ -110,18 +98,20 @@ int hfi1_mmu_rb_register(void *ops_arg, struct mm_struct *mm,
> >  	INIT_HLIST_NODE(&handlr->mn.hlist);
> >  	spin_lock_init(&handlr->lock);
> >  	handlr->mn.ops = &mn_opts;
> > -	handlr->mm = mm;
> >  	INIT_WORK(&handlr->del_work, handle_remove);
> >  	INIT_LIST_HEAD(&handlr->del_list);
> >  	INIT_LIST_HEAD(&handlr->lru_list);
> >  	handlr->wq = wq;
> >  
> > -	ret = mmu_notifier_register(&handlr->mn, handlr->mm);
> > +	ret = mmu_notifier_register(&handlr->mn, current->mm);
> >  	if (ret) {
> >  		kfree(handlr);
> >  		return ret;
> >  	}
> >  
> > +	mmget(current->mm);
> 
> I flagged this initially but then reviewed the commit message for why you need
> this reference.  I think it is worth a comment here as well as below.
> Specifically mentioning the order of calls in do_exit().

Oh? a mmget should not be held for a long time, and a notifier already
holds a mmgrab while it is registered

If hfi later needs the mmget then the only the part that needs it
should convert the mmgrab to a mmget with mmget_not_zero

Jason
