Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C9E7288CD1
	for <lists+linux-rdma@lfdr.de>; Fri,  9 Oct 2020 17:35:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389334AbgJIPf0 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 9 Oct 2020 11:35:26 -0400
Received: from nat-hk.nvidia.com ([203.18.50.4]:1040 "EHLO nat-hk.nvidia.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389252AbgJIPfV (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 9 Oct 2020 11:35:21 -0400
Received: from HKMAIL101.nvidia.com (Not Verified[10.18.92.9]) by nat-hk.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5f8083370000>; Fri, 09 Oct 2020 23:35:19 +0800
Received: from HKMAIL103.nvidia.com (10.18.16.12) by HKMAIL101.nvidia.com
 (10.18.16.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 9 Oct
 2020 15:35:18 +0000
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.169)
 by HKMAIL103.nvidia.com (10.18.16.12) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Fri, 9 Oct 2020 15:35:18 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cx2yahLSGTn8l9qrB5zCsdllgv9phHaE+Omw7plsh2ho1uF4RV3d5B0DxI41Nke1ZcSqfIhMRq7rmy+PE1eK3PAu7fvtwUhcei7AEfTCtwgZPbLl3ebxOno0tojoPdq3kRzLKxOO+8w1jmOOVEsNp2yTn2KVlqFBG6lme3jJBntE8eqLqtFw62cUKrUzXwcf4BpEo+DJfIOmH5pEig+J8GvQqp6LJFW4ednwWuW+iYD8gjqG25J8x/CwolBfM0cLojLTDhAQAzuy6eadfXGpU5VA9gQqx5XIhbBKMlnNcY9a22PsoiFrAvihDxhmsoiMhDoedAbHavMhgwzQIL8jLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a8qyrZi0q7zPerJQQdrghcJ9+NAmg8UdBgZHTrBhUKM=;
 b=bWsxPkjBFlaG7d7gUQfwCKNIuSfjIGHFW2kb/8m4RLaMgdMUIlbJargAEW/L70hnFVewxep/51udi+F9qypNG9kXd3jgQ1la7zW+Tyv8Sr1Q7d6wyD9pd3S+yfhYfSzBnflRfNTQfkdNpNl2K4objDZPm+K7vfLoKn+f97pPuBQnicEXGU3YZameD27dUoCqGbDFLJbReQ5q0TRchwuXRUcHHwj9ApT8h2xkZF3xD3CRrWZXpzB7tk+yvPHPoJn/U/EkfnQinuaQrdTRXQPPLsaUMnmvmMSSO+uYOdvg0KH347ZYdIi8n9py8waXPqNvQdUbDw291AmGdHOMlKU70A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB3308.namprd12.prod.outlook.com (2603:10b6:5:182::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3455.23; Fri, 9 Oct
 2020 15:35:15 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::cdbe:f274:ad65:9a78]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::cdbe:f274:ad65:9a78%7]) with mapi id 15.20.3455.026; Fri, 9 Oct 2020
 15:35:15 +0000
Date:   Fri, 9 Oct 2020 12:35:14 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     =?utf-8?B?SMOla29u?= Bugge <haakon.bugge@oracle.com>
CC:     Yishai Hadas <yishaih@nvidia.com>,
        Doug Ledford <dledford@redhat.com>,
        <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH for-next v2] IB/mlx4: Convert rej_tmout radix-tree to
 XArray
Message-ID: <20201009153514.GA527106@nvidia.com>
References: <1602253482-6718-1-git-send-email-haakon.bugge@oracle.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <1602253482-6718-1-git-send-email-haakon.bugge@oracle.com>
X-ClientProxiedBy: MN2PR16CA0048.namprd16.prod.outlook.com
 (2603:10b6:208:234::17) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (156.34.48.30) by MN2PR16CA0048.namprd16.prod.outlook.com (2603:10b6:208:234::17) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3455.23 via Frontend Transport; Fri, 9 Oct 2020 15:35:15 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1kQuQM-002D8N-De; Fri, 09 Oct 2020 12:35:14 -0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1602257719; bh=Qr4KkfBNr1ni2mwDzKia/NLINIbCYjgc11g5/IQ+QJA=;
        h=ARC-Seal:ARC-Message-Signature:ARC-Authentication-Results:Date:
         From:To:CC:Subject:Message-ID:References:Content-Type:
         Content-Disposition:Content-Transfer-Encoding:In-Reply-To:
         X-ClientProxiedBy:MIME-Version:
         X-MS-Exchange-MessageSentRepresentingType;
        b=mes0fOjwlWObhlw44STVFN+joWmd1hC49y5YsXYxOM33zVJ28/ejT1WNNVSyhywu+
         24fX945TVWAcM9k6PZgVMFxve7e9An0tBUmdrUEWYfA1lTrpp5jfGB9DG7+ZirJbJ2
         ObbVtUzPrEoSy0QaFSsjOB8iDGNeIvAUenx/omZXZynDYJQMUBqPyWqtnVOYMQukIn
         6utrhe2CdtjUTU70Ywj6ZPFeM4c6aiuLMyx3aJxZkC7sPklmbY7j35JaTg6gO98S9G
         Rc1PsqE9QIDoErtFC3yitxCLa7MQKjKZ80YaikvW2fHx00cyhX1RriXL6VsTtIiCKf
         Gde3QLObRjXoA==
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Oct 09, 2020 at 04:24:42PM +0200, H=C3=A5kon Bugge wrote:
> Fixes: 227a0e142e37 ("IB/mlx4: Add support for REJ due to timeout")
> Signed-off-by: H=C3=A5kon Bugge <haakon.bugge@oracle.com>
> ---
>  drivers/infiniband/hw/mlx4/cm.c      | 92 ++++++++++++++++++------------=
------
>  drivers/infiniband/hw/mlx4/mlx4_ib.h |  4 +-
>  2 files changed, 48 insertions(+), 48 deletions(-)

Applied to for-next, thanks

Jason
