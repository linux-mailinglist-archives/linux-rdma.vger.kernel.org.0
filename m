Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F2E230FDEC
	for <lists+linux-rdma@lfdr.de>; Thu,  4 Feb 2021 21:19:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238539AbhBDUQm (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 4 Feb 2021 15:16:42 -0500
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:18377 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239686AbhBDTys (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 4 Feb 2021 14:54:48 -0500
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B601c50db0003>; Thu, 04 Feb 2021 11:54:03 -0800
Received: from HKMAIL104.nvidia.com (10.18.16.13) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 4 Feb
 2021 19:54:02 +0000
Received: from HKMAIL102.nvidia.com (10.18.16.11) by HKMAIL104.nvidia.com
 (10.18.16.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 4 Feb
 2021 19:54:00 +0000
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.169)
 by HKMAIL102.nvidia.com (10.18.16.11) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Thu, 4 Feb 2021 19:53:59 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YXSPiQdHY2tviRDkWOG4tRXZrCF1X6Qul/cJh2Ecx24mBu7yprHzx08K85x81RCIQB+GvE6thP6CO5m3sBl2aoqEtDXCJ9sdKl7tBqdOS4aGtGjnRa2wLSxcIzd+ZAj+tdQvvq8NYmqX/9m8l9Y4hEL2A8/TDo+/dMrGOSe6hrZSUELsAqBIcy5ZvhXr69LzIycGvo/HSmqAmebPia2tysAjYajtuLcLeZ7zOHWuP993DV2prfRFY5mdA5hpG5YlkutiIs3rIRR9NZVCUupGbaIBopQaz+hFSz+HFa+pgR7HCxRjdUyiomXKrOnsIogmLpoOxxCkpT8oknuQuYhj4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vog3C+ozn5IGqHkEIcJj0R/cWKg/4JFMiLXZ4zVvRvE=;
 b=nClMa8rrwceCyvunK6VgLZFhfJyVCVuHNCYv7GwihoueTBz+hJEJwdyNgXk2zwrhrGmrJ5qEBgS4EE+1nnvG5tVrMuVC7eBOO/82rbbjJWBhZJEgcIlFhO04mjCsdi8KmO2h7A2HFBiflU0p5JOuOz49w2JwTJLovo4uQxRPTUvsdEaSuPjgcJNOEELyeB77Xd3G+DjCWtsQusbygySNAkjyV/x97dWH7gj1p5rpQ6TX5yMlTBtohYW1JuO/xfBFZgpD/9+0e5iiyDPzkFfapRl0FnPfqNB4NktQecvdcQ7+t06lPpNoyW6OgN7L4vrjY0gh4cxmm9E1kYYezU5esw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB3211.namprd12.prod.outlook.com (2603:10b6:5:15c::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3805.17; Thu, 4 Feb
 2021 19:53:57 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::d6b:736:fa28:5e4]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::d6b:736:fa28:5e4%7]) with mapi id 15.20.3805.033; Thu, 4 Feb 2021
 19:53:57 +0000
Date:   Thu, 4 Feb 2021 15:53:55 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     John Hubbard <jhubbard@nvidia.com>
CC:     Joao Martins <joao.m.martins@oracle.com>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Doug Ledford <dledford@redhat.com>,
        "Matthew Wilcox" <willy@infradead.org>
Subject: Re: [PATCH 1/4] mm/gup: add compound page list iterator
Message-ID: <20210204195355.GO4247@nvidia.com>
References: <20210203220025.8568-1-joao.m.martins@oracle.com>
 <20210203220025.8568-2-joao.m.martins@oracle.com>
 <955dbe68-7302-a8bc-f0b5-e9032d7f190e@nvidia.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <955dbe68-7302-a8bc-f0b5-e9032d7f190e@nvidia.com>
X-ClientProxiedBy: MN2PR15CA0016.namprd15.prod.outlook.com
 (2603:10b6:208:1b4::29) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (142.162.115.133) by MN2PR15CA0016.namprd15.prod.outlook.com (2603:10b6:208:1b4::29) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3825.20 via Frontend Transport; Thu, 4 Feb 2021 19:53:57 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1l7khP-003afx-Qh; Thu, 04 Feb 2021 15:53:55 -0400
X-Header: ProcessedBy-CMR-outbound
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1612468443; bh=Vog3C+ozn5IGqHkEIcJj0R/cWKg/4JFMiLXZ4zVvRvE=;
        h=ARC-Seal:ARC-Message-Signature:ARC-Authentication-Results:Date:
         From:To:CC:Subject:Message-ID:References:Content-Type:
         Content-Disposition:In-Reply-To:X-ClientProxiedBy:MIME-Version:
         X-MS-Exchange-MessageSentRepresentingType:X-Header;
        b=ma3XZqsc73QwreG+4FOlgjiY0b1YNeIh4n8vf3yMdSH4yo+dXNHG9zX8gegWxcwBU
         Jki0TaQWGMC5JkA5bjMku5A/WaQa/Zmbh1+u7YxsDZJspz8xZpjpKf0NAI3nr4DCZJ
         xBpQmFvOPgMj4eknXD9tG9xDDgGJSrdQFKvFJEeeiSa++T0hIb2s+4egbrYlq1pPFW
         7c0eMTDrW9ojgC55zEetqYlz1c8HrDh3JqTf6l+j+uy8XLpKIWxD1cNog1Bm2FlII8
         eshWRSZIvq0/jVGdj8TSOWIBxGXY060lE3JJP9x/71HKHRgh9XmndkDE0m4oYdVnd3
         SVTASjO0R83bw==
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Feb 03, 2021 at 03:00:01PM -0800, John Hubbard wrote:
> > +static inline void compound_next(unsigned long i, unsigned long npages,
> > +				 struct page **list, struct page **head,
> > +				 unsigned int *ntails)
> > +{
> > +	if (i >= npages)
> > +		return;
> > +
> > +	*ntails = count_ntails(list + i, npages - i);
> > +	*head = compound_head(list[i]);
> > +}
> > +
> > +#define for_each_compound_head(i, list, npages, head, ntails) \
> 
> When using macros, which are dangerous in general, you have to worry about
> things like name collisions. I really dislike that C has forced this unsafe
> pattern upon us, but of course we are stuck with it, for iterator helpers.
> 
> Given that we're stuck, you should probably use names such as __i, __list, etc,
> in the the above #define. Otherwise you could stomp on existing variables.

Not this macro, it after cpp gets through with it all the macro names
vanish, it can't collide with variables.

The usual worry is you might collide with other #defines, but we don't
seem to worry about that in the kernel

Jason
