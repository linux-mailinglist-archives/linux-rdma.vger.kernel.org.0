Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B2EF2FC5E4
	for <lists+linux-rdma@lfdr.de>; Wed, 20 Jan 2021 01:35:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728534AbhATAdQ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 19 Jan 2021 19:33:16 -0500
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:8914 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726023AbhATAdF (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 19 Jan 2021 19:33:05 -0500
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B60077a180006>; Tue, 19 Jan 2021 16:32:24 -0800
Received: from HQMAIL109.nvidia.com (172.20.187.15) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 20 Jan
 2021 00:32:23 +0000
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.175)
 by HQMAIL109.nvidia.com (172.20.187.15) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Wed, 20 Jan 2021 00:32:23 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hLvy9RnyXLjfLSibq0rp0u6N72PYytxFqayRy4CaunpuKcXY4FECKp6Di1g7J7KCKjueAfaQr0suDKncDJs1R1sJZ4aGWX058KnPdH9OzJYBlL2UOnLtzE6GeEJfq9zynb6s1w8IZBhIGTnYrK8MmTJ8u9lEfDUYKggbt008o2UmrbF7P7avwPEW6ni9h+6kzgL8lHmoYscoKm7PAYedFJy6A4uCRj3Z/7/YeuxMGeEnUtkmClVy9XqABOAwNz7HnE2iuEFyOQLrNOh2XiMbPoYxyntY1zLiYKFhIcFnJu0uq4JgzWc8P2m3TwhcsroFAcbCbqP9NXn8+mhNk2ph1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2FDQpZqc6k44lNzc+h2+vFJGEthCb/krNZCTKdaS2YA=;
 b=GMbUB71jhgMVVA/evo2Yjj8oa6tjNy67M82hLrmUUwjW/PjpPCx2VZ5bBwfLu+rU0K+WnMwDe2NaTebfeEMddbx6jc3a+AlJgVJab8YQ8fTcWDQnHjyWCXpXBWHcMMbsEpTPewN5dErZqfXP5efxsgFt8/IJt0iWY1EQN1JqwYKXL61yLFOHdrOXESrAMLJVL4mUzr7p7H82ilCCDlqveYK9/sGqXhqxLo6Vv7yIpzuFFjekME2PGwgnIH8x/g+VRGtBK3TTMcIw/leFtuC5tSKj/D0sKGVhz/iU3PNQdjXRhUABWH+I+iZhlTmnvrJzZdl7tOdJWfUfrkMqQl7R7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM5PR1201MB0105.namprd12.prod.outlook.com (2603:10b6:4:54::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3763.14; Wed, 20 Jan
 2021 00:32:22 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::546d:512c:72fa:4727]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::546d:512c:72fa:4727%7]) with mapi id 15.20.3784.011; Wed, 20 Jan 2021
 00:32:21 +0000
Date:   Tue, 19 Jan 2021 20:32:19 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Joe Perches <joe@perches.com>
CC:     James Bottomley <James.Bottomley@HansenPartnership.com>,
        "Christian Benvenuti" <benve@cisco.com>,
        Nelson Escobar <neescoba@cisco.com>,
        "Doug Ledford" <dledford@redhat.com>, <linux-rdma@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, Greg KH <greg@kroah.com>
Subject: Re: [PATCH V2] RDMA: usnic: Fix misuse of sysfs_emit_at
Message-ID: <20210120003219.GA968146@nvidia.com>
References: <f4ce30f297be4678634b5be4917401767ee6ebc5.camel@perches.com>
 <6af0a6562b67a24e6233ed360189ba8071243035.camel@HansenPartnership.com>
 <5eb794b9c9bca0494d94b2b209f1627fa4e7b555.camel@perches.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <5eb794b9c9bca0494d94b2b209f1627fa4e7b555.camel@perches.com>
X-ClientProxiedBy: BL0PR02CA0126.namprd02.prod.outlook.com
 (2603:10b6:208:35::31) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (142.162.115.133) by BL0PR02CA0126.namprd02.prod.outlook.com (2603:10b6:208:35::31) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3763.10 via Frontend Transport; Wed, 20 Jan 2021 00:32:20 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1l21Q3-0043ry-6V; Tue, 19 Jan 2021 20:32:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1611102745; bh=2FDQpZqc6k44lNzc+h2+vFJGEthCb/krNZCTKdaS2YA=;
        h=ARC-Seal:ARC-Message-Signature:ARC-Authentication-Results:Date:
         From:To:CC:Subject:Message-ID:References:Content-Type:
         Content-Disposition:In-Reply-To:X-ClientProxiedBy:MIME-Version:
         X-MS-Exchange-MessageSentRepresentingType;
        b=QXvV6ai49oGDuQ2iBFy/DpBgnCKV35azmmrXOPOHV2BaSeaq5rt2ZUDndaYTaFXmS
         Bzv3wUFZoilYpQpUrUPPQeEFIiknH3Ct/IuD63XXw1oyd40uZfjt2DMzGbigzc5w/E
         Ml5TNUNShEncr+QKisUrYrtis3wZAI+2gLLoWjS88iC8fSVKPnmV7nnYfL+wUg4yXF
         6ff3zMZ+wue0jGsVk29uq3lvVwjUZOpSx0+UyovsDcb0K61uqN8F1uj3zsJdkpz1c1
         sOUwiAycmhNWmC/LiNFZLTSc8cAFySh3WqA9ba0fcxxB9MhlB4YP884a8EOBjJGaXF
         As/VBGMRZMVgg==
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Jan 15, 2021 at 04:36:50PM -0800, Joe Perches wrote:
> In commit e28bf1f03b01 ("RDMA: Convert various random sprintf sysfs _show
> uses to sysfs_emit") I mistakenly used len = sysfs_emit_at to overwrite
> the last trailing space of potentially multiple entry output.
> 
> Instead use a more common style by removing the trailing space from the
> output formats and adding a prefixing space to the contination formats and
> converting the final terminating output newline from the defective
> 	len = sysfs_emit_at(buf, len, "\n");
> to the now appropriate and typical
> 	len += sysfs_emit_at(buf, len, "\n");
> 
> Fixes: e28bf1f03b01 ("RDMA: Convert various random sprintf sysfs _show uses to sysfs_emit")
> 
> Reported-by: James Bottomley <James.Bottomley@HansenPartnership.com>
> Signed-off-by: Joe Perches <joe@perches.com>
> ---
>  drivers/infiniband/hw/usnic/usnic_ib_sysfs.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)

Applied to for-rc, thanks

Jason
