Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E1232D2C7C
	for <lists+linux-rdma@lfdr.de>; Tue,  8 Dec 2020 15:01:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729586AbgLHOBU (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 8 Dec 2020 09:01:20 -0500
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:12282 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728546AbgLHOBT (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 8 Dec 2020 09:01:19 -0500
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5fcf87070001>; Tue, 08 Dec 2020 06:00:39 -0800
Received: from HQMAIL107.nvidia.com (172.20.187.13) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 8 Dec
 2020 14:00:39 +0000
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.172)
 by HQMAIL107.nvidia.com (172.20.187.13) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Tue, 8 Dec 2020 14:00:39 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eIeM918w97IzMumuwYli6JLHDSWDuNQPTkxAz5xpSbCQtTqPot9gUWdYbBqEwKxY8SUVv3jMfwWiBY/bxSeMjO92QaDbOMiwqFjN1XeMrR955BYduwFHxxPyR2qQ4U2cGV1G89rylDIwDCwqLr/+ndHcmCPTnkJYvSKaDLPyAIeESjMWKAAB0HWgBDbgga9bRhjkHjmJgmdxfymLRWnsVJECfx+vbZ19wOFv8AhDsbwJQyj2vvNFPXoLBp01usHv0xn47IOtwJJF7WV60FQdwwKThoWIF9jqTnaQELrrNHJm2H24aCtFSLqW5SNQHEn0riLGRud/zzcFlBmi5Bhy/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9cUBxDrPc9UWHdPJoAxK4gcR6EvOVEoCjPlREZTOaWg=;
 b=lv/kNaYIgk/aPEV9MJNKlUMtlqKey8iMZYpYnXyt3TjGxoKtCLYEVCvWnYv16UkZWkhpvGtIC2nyz4t4FwysLu6ctFsS8pojO6hr+NUXz17rcSz1rN5Xea54qtlLa2pr/Kw5xYdaKFSc7gUPZiYUObGAuAh2VMrNJjvPlun+m7JhWx5/KMPgSXyqOHm9W90a9L/jZ9OUC+mp6RCA4gAgg7Yuofbqv+BskaW4Q/0T5Rmxbcpjt+h9g0ZVmRid18dgVdXz1zPbECmfvtmrcIM/6H6lrcDIJNRjcMLltG95WeEAtZOYxcnpXwxGLjSD2LAAJAfXfBtLuBjnnbrgswUtVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB4618.namprd12.prod.outlook.com (2603:10b6:5:78::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3632.21; Tue, 8 Dec
 2020 14:00:38 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1ce9:3434:90fe:3433]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1ce9:3434:90fe:3433%3]) with mapi id 15.20.3632.023; Tue, 8 Dec 2020
 14:00:38 +0000
Date:   Tue, 8 Dec 2020 10:00:36 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Dan Carpenter <dan.carpenter@oracle.com>
CC:     Leon Romanovsky <leon@kernel.org>,
        Doug Ledford <dledford@redhat.com>,
        Avihai Horon <avihaih@nvidia.com>, <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH rdma-next 3/3] RDMA/uverbs: Fix incorrect variable type
Message-ID: <20201208140036.GJ552508@nvidia.com>
References: <20201208073545.9723-1-leon@kernel.org>
 <20201208073545.9723-4-leon@kernel.org> <20201208075539.GA2789@kadam>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20201208075539.GA2789@kadam>
X-ClientProxiedBy: MN2PR18CA0030.namprd18.prod.outlook.com
 (2603:10b6:208:23c::35) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (142.162.115.133) by MN2PR18CA0030.namprd18.prod.outlook.com (2603:10b6:208:23c::35) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3654.12 via Frontend Transport; Tue, 8 Dec 2020 14:00:37 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1kmdXg-007umr-IE; Tue, 08 Dec 2020 10:00:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1607436039; bh=9cUBxDrPc9UWHdPJoAxK4gcR6EvOVEoCjPlREZTOaWg=;
        h=ARC-Seal:ARC-Message-Signature:ARC-Authentication-Results:Date:
         From:To:CC:Subject:Message-ID:References:Content-Type:
         Content-Disposition:In-Reply-To:X-ClientProxiedBy:MIME-Version:
         X-MS-Exchange-MessageSentRepresentingType;
        b=VP3f89lpFL/H/NJDy+JjUolBFaNEkNul2Vp93/6Eg2dTAu5Kw/HaX9kp2fIt+M238
         slnZvFhQb7hk00lJVrge5k7usxDAj7k1YVWaWbSPGOp8lVtKbV0i2jrEFnyN6y6EdL
         JTaOaIhznSgGpdsdZWsmDU9lBq92jX0FzXDzAVh51wUUZPbiQE/oXXHJnMlCgBt2yT
         03LD/djYTrXpBhgPa0cUXzR2tGcQ9fDFuwPAyHzvmwSJkgIp1/Sp85vE2JVCvDmC9i
         PXQ148YGLabpMnPbpwTaw1+zxxKPSrisdzQvCOdklHhDlK2g+XREldOWoQ/5YU6SIe
         5dNsA4/wuxFrw==
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Dec 08, 2020 at 10:55:39AM +0300, Dan Carpenter wrote:
> On Tue, Dec 08, 2020 at 09:35:45AM +0200, Leon Romanovsky wrote:
> > @@ -336,19 +335,16 @@ static int UVERBS_HANDLER(UVERBS_METHOD_QUERY_GID_TABLE)(
> >  		attrs, UVERBS_ATTR_QUERY_GID_TABLE_RESP_ENTRIES,
> >  		user_entry_size);
> >  	if (max_entries <= 0)
> > -		return -EINVAL;
> > +		return max_entries ?: -EINVAL;
> >  
> >  	ucontext = ib_uverbs_get_ucontext(attrs);
> >  	if (IS_ERR(ucontext))
> >  		return PTR_ERR(ucontext);
> >  	ib_dev = ucontext->device;
> >  
> > -	if (check_mul_overflow(max_entries, sizeof(*entries), &num_bytes))
> > -		return -EINVAL;
> > -
> > -	entries = uverbs_zalloc(attrs, num_bytes);
> > -	if (!entries)
> > -		return -ENOMEM;
> > +	entries = uverbs_kcalloc(attrs, max_entries, sizeof(*entries));
> > +	if (IS_ERR(entries))
> > +		return PTR_ERR(entries);
> 
> This isn't right.  The uverbs_kcalloc() should match every other
> kcalloc() function and return NULL on error.  This actually buggy
> because it returns both is error pointers and NULL so it will lead to
> a NULL dereference.

It is abnormal, but returing the EOVERFLOW to the caller vs ENOMEM
does seem somewhat relevant for debuggability..

If anything on the uverbs_*alloc* path returns NULL it is a bug.

Jason
