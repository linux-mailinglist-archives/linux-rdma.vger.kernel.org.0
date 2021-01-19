Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 155FE2FB89A
	for <lists+linux-rdma@lfdr.de>; Tue, 19 Jan 2021 15:31:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393018AbhASNTA (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 19 Jan 2021 08:19:00 -0500
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:16027 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2393713AbhASNBq (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 19 Jan 2021 08:01:46 -0500
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B6006d8110001>; Tue, 19 Jan 2021 05:01:05 -0800
Received: from HQMAIL101.nvidia.com (172.20.187.10) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 19 Jan
 2021 13:01:05 +0000
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.174)
 by HQMAIL101.nvidia.com (172.20.187.10) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Tue, 19 Jan 2021 13:01:05 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=di7KY2xDZI9j68jtijM+7s8gb5lX1hqw6zmsr+4lTEnrjrTbQeonFfPxQOmJdJMEofH5gDKupNfWOLwUZwdQbJ0vvcBweMjd/ERAUlhMYmLWVDSeNsDI4h3DVEfNvvrmCfQdVyCoQc93/ritxPeyC5XnKR+N7eM+nmARuEf59f7BksFYheQ6whS9Clog49fxrCmwc056EB2/uk3MXujcobQcTQMjlUDBGVYJGMsMxrQB7TT8zujuW81xMZ8WV/bKgMgAFBinVdU4GkMxn9enWhYN+eShAvRECWnfAL+u9l205t/1L2DoikjV4d2TvwYf6ZsOK66x+PBsiqqZ87l+jQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s/9XyzB4qsoMGWWD6LzBuBq9mFIxHYf5kaveKpAD1a0=;
 b=Pz550UVpiwwXXAUZqH6LVTxVWxOn2zK6UXwG6lFJHQRN5UbDudYAyfmTmvAvbWDN4y70XXAaZk9GrCi30oRkol3zlDG5SkECgm6vkrCpG0P12kS3jzu0kbY+fbu3mKzkBjHHY2YZglPx3SAwM9RsY4/ft6J/FEdPPeVg566GAqRylckuxaq7gjZzq5+p9Vvmto5LJICvpOz456gQZGXiqQgybynzkGz5qB+Eq0w6AFFoddZu/SjRm+hnZkvOJ+tKFG9SPUIWZqqdPAzwXkmgn2/0uR8t1h0Cvfg0xe1ibOoVGUzCrLY+G8shdtCvD79XslTBq6Iy4HAeXMnjzB33ew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM5PR12MB2437.namprd12.prod.outlook.com (2603:10b6:4:ba::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3763.10; Tue, 19 Jan
 2021 13:01:04 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::546d:512c:72fa:4727]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::546d:512c:72fa:4727%7]) with mapi id 15.20.3784.011; Tue, 19 Jan 2021
 13:01:04 +0000
Date:   Tue, 19 Jan 2021 09:01:02 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     "Mohamed._. Heib" <goody698@gmail.com>
CC:     Zhu Yanjun <zyjzyj2000@gmail.com>, <mwilck@suse.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Vijay Immanuel <vijayi@attalasystems.com>,
        Nicolas Morey-Chaisemartin <nmoreychaisemartin@suse.com>
Subject: Re: [PATCH] Revert "RDMA/rxe: Remove VLAN code leftovers from RXE"
Message-ID: <20210119130102.GO4147@nvidia.com>
References: <20210119105644.2658-1-mwilck@suse.com>
 <CAD=hENfrUJGeUGUfb6t6o3d8J_5ONMPfx3Gae8=xwrhq0DBKwg@mail.gmail.com>
 <CANRB76_kkvfX9Us0rSynaNxYuVdYT-SLxEmhp+ijSeP+++HGdA@mail.gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CANRB76_kkvfX9Us0rSynaNxYuVdYT-SLxEmhp+ijSeP+++HGdA@mail.gmail.com>
X-ClientProxiedBy: MN2PR06CA0016.namprd06.prod.outlook.com
 (2603:10b6:208:23d::21) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (142.162.115.133) by MN2PR06CA0016.namprd06.prod.outlook.com (2603:10b6:208:23d::21) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3763.9 via Frontend Transport; Tue, 19 Jan 2021 13:01:03 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1l1qd4-003blW-OC; Tue, 19 Jan 2021 09:01:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1611061265; bh=s/9XyzB4qsoMGWWD6LzBuBq9mFIxHYf5kaveKpAD1a0=;
        h=ARC-Seal:ARC-Message-Signature:ARC-Authentication-Results:Date:
         From:To:CC:Subject:Message-ID:References:Content-Type:
         Content-Disposition:In-Reply-To:X-ClientProxiedBy:MIME-Version:
         X-MS-Exchange-MessageSentRepresentingType;
        b=haTKPVVGpi6Q6fj4NXApvgfi4uQc9OJbSV2RbHaG7fYwbODM4XT+IIfcxCjuWuaNI
         bUgT2xIwfcH8LtsuCIK1veRTGysSjo0qplJ13kRv++/Oyxpt5VrUHg4g3lNL7rjkz2
         gS5K7hlvRLnJQ9+pJzRZftNwl7F+/hAreHOlvPaY9JfyRp58prkqsk0jdsiZandC9T
         zX1WisK5e/2f/axs5irmm9j49G1I0LDQzmQgum+V/evQAGGcMFM6kgoDTjTt3rpxk4
         1fe8NEj+ReTlUTK45D6kLj9Av2Tr+LoqQZPqcfCnz4BKNf7GPKuT0/cUzkNNmKL5HH
         GqVzhSKdz9TZA==
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Jan 19, 2021 at 02:40:52PM +0200, Mohamed._. Heib wrote:
>    Hi,
>    As far as i remember the traffic still can be encapsulated over the
>    vlan interface with vlan tag
>    by specifying the vlan interface gid index that mapped to the vlan ip
>    on the vlan parent interface gids table.
>    And by removing the vlan related functionality on rxe (commit:
>    b2d2440430c0) the rxe still can send traffic via vlan interface
>    but can't receive from vlan interface and that will break the vlan
>    functionality on rxe so i think you need keep the vlan related code on
>    rxe.

That may be, but the code here is still wrong.

Incoming packets are supposed to be matched to the gid table, which
specifies the allowed vlans, it can't just be taken raw from the skb
like this.

If someone wants to add vlan support to rxe it needs to be done right,
currently it doesn't support vlan.

Jason
