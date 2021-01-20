Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE8782FC56E
	for <lists+linux-rdma@lfdr.de>; Wed, 20 Jan 2021 01:12:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726638AbhATALh (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 19 Jan 2021 19:11:37 -0500
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:17380 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730062AbhATALZ (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 19 Jan 2021 19:11:25 -0500
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B600774fe0000>; Tue, 19 Jan 2021 16:10:38 -0800
Received: from HQMAIL111.nvidia.com (172.20.187.18) by HQMAIL109.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 20 Jan
 2021 00:10:38 +0000
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.175)
 by HQMAIL111.nvidia.com (172.20.187.18) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Wed, 20 Jan 2021 00:10:38 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bDqZ9bILYqJ7P86pkyDRBQD0JdDLKifLcFljviXbCc6kIJbbX6rmqpTwhTpXUb8v/fo1L2If9se/g6lmOTPr0+s/QKT1EKYNH9Dnu55U9qYp+IsIda4RI6hZvjLgrjQIAlefx9GVoKF0IiYO1GGnBDkuBYgJQ0EHbph62eO/9z8oA1/4lZ+A+7vbsvrKEBUQZY+42JTIbtA4PhcNDAMDd1i72cU+eiz3Sm5JKfm9VOI3Jq6sWFyIh2Ww3m5w/r7gAZSMmW8O4CCvpRwN60Ud6Uk49FnkRjtAf7VZRVxqLinEWqqt4bkT8/Qcuy6slFy99vcCVT/NsTLBNwI5kGv/Ew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vW/BWknj4AXAG1qPtKGJ5Z/fUWf4riOt+DwdMDehn64=;
 b=m+Q4vl8pQY2eAtqq5KlO30wWTMMXk8bWWEP4htgDm1nZD5a17Y0qGkAWPrivj5KKPcC6LBN1pfavrW7u1Uev0GhbllUk4iSO8ljqVQDP87jS4hA05ZqY3hUufKdHN4rB9sXXWkCwTWpnxccvsV2gWChA0O+pWdoKbkwFQQowpHW52SXfOX4nn5h45/BebsSjMNTcpJPoRttGW5m2PDjmuOV21so72C53/TYttRA/6LjfXoSV2vu/2JD0UqqUtzALlvA/Dvp9ve3UWrc5ugORpqf/CXJr9bXp+gLaIBADBAeRhOTOjHPzkb5zLUUpIpcKj1hq3UH3W7PG8DnDaLZpkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB3514.namprd12.prod.outlook.com (2603:10b6:5:183::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3763.12; Wed, 20 Jan
 2021 00:10:37 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::546d:512c:72fa:4727]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::546d:512c:72fa:4727%7]) with mapi id 15.20.3784.011; Wed, 20 Jan 2021
 00:10:37 +0000
Date:   Tue, 19 Jan 2021 20:10:35 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Max Gurtovoy <mgurtovoy@nvidia.com>
CC:     <linux-rdma@vger.kernel.org>, <dledford@redhat.com>,
        <leonro@nvidia.com>, <sagi@grimberg.me>, <oren@nvidia.com>,
        <nitzanc@nvidia.com>, <sergeygo@nvidia.com>, <ngottlieb@nvidia.com>
Subject: Re: [PATCH 0/4] IB/iser cleanups and fixes for 5.11
Message-ID: <20210120001035.GA944141@nvidia.com>
References: <20210111145754.56727-1-mgurtovoy@nvidia.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20210111145754.56727-1-mgurtovoy@nvidia.com>
X-ClientProxiedBy: MN2PR20CA0014.namprd20.prod.outlook.com
 (2603:10b6:208:e8::27) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (142.162.115.133) by MN2PR20CA0014.namprd20.prod.outlook.com (2603:10b6:208:e8::27) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3763.9 via Frontend Transport; Wed, 20 Jan 2021 00:10:36 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1l2151-003xd2-Ll; Tue, 19 Jan 2021 20:10:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1611101438; bh=vW/BWknj4AXAG1qPtKGJ5Z/fUWf4riOt+DwdMDehn64=;
        h=ARC-Seal:ARC-Message-Signature:ARC-Authentication-Results:Date:
         From:To:CC:Subject:Message-ID:References:Content-Type:
         Content-Disposition:In-Reply-To:X-ClientProxiedBy:MIME-Version:
         X-MS-Exchange-MessageSentRepresentingType;
        b=GCGi4PiTd2AqRBpLJQAP26QYaH9qswF8fYt5KlXoq8H6zU8tDR+HVpbU52U6nxWh9
         1K55Jn83aowRd1eZbwo4FvZbE8GOoRRBS/8jZFvQG8Q9tsTFQZhdVEbl74ul6RXp2G
         lH4ELR0HkwvNszZGsyilwdonkZugOUxnm8lWeR7BXzXLJwkREKS9ZbDgzhbxRPR2GX
         Bbn3u3sRt8GHu8vvPAv4Vx7fZME95ONYzCDMLmpHUXlmHLw51Wf34P57ymN+0Qs3M6
         RlQsHp4yMeNGYMRqgKerMEmo7ufLfM85dEzZu+/yCdX+u35JRn4XFPBHwxswyYRbmB
         Zvcukd4JNcFhA==
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Jan 11, 2021 at 02:57:50PM +0000, Max Gurtovoy wrote:
> Hi Jason/Leon/Sagi,
> This series introduce some minor code conventions cleanups and 1 module
> param fix that can cause the driver to fail in connection establishment
> (if one will set max_sectors = 0).
> 
> Please consider this for the next 5.11 PR or for 5.12 merge window.
> 
> Max Gurtovoy (4):
>   IB/iser: remove unneeded semicolons
>   IB/iser: protect iscsi_max_lun module param using callback
>   IB/iser: enforce iser_max_sectors to be greater than 0
>   IB/iser: simplify prot_caps setting

Applied to for-next, thanks

Jason
