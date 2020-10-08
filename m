Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 35222287B8D
	for <lists+linux-rdma@lfdr.de>; Thu,  8 Oct 2020 20:19:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726597AbgJHSS6 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 8 Oct 2020 14:18:58 -0400
Received: from nat-hk.nvidia.com ([203.18.50.4]:10941 "EHLO nat-hk.nvidia.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725857AbgJHSS6 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 8 Oct 2020 14:18:58 -0400
Received: from HKMAIL101.nvidia.com (Not Verified[10.18.92.9]) by nat-hk.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5f7f580f0002>; Fri, 09 Oct 2020 02:18:55 +0800
Received: from HKMAIL101.nvidia.com (10.18.16.10) by HKMAIL101.nvidia.com
 (10.18.16.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 8 Oct
 2020 18:18:55 +0000
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.47) by
 HKMAIL101.nvidia.com (10.18.16.10) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Thu, 8 Oct 2020 18:18:55 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=isTYAooYl612vzVrdlX9NLhBXHIZj09wN8US9LADpAw0cOsrBirPHzi9cC+HwbUGKhJ3rv4FJ50eeJATYHmAzY72hbO21iF5tvRHthLS3OeW33aUPSjautfYHoJU7R+0YVzPMY7qSK+gl5AumLCBmf6qRu4PUJV9JYGxQw9iJtbxuYLMCiZ/20xqe/QBY6y6OcmLk5aj0fdl5Yo7SdNc/9xpkYbGFqBfvIqBbhfNUdq5QMGEW8vq53eqNtxh/LncKvKliO+ntOzuYaWdXD1GGZGsidL35P4OmhPXCS9S5I9NGhEBIpj3xo0C7dmtzNZEyct0JW9GPvaphmpd+43QfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rx4y00aJGChx5Ty3rD3RbvRwLXWF48kdf0otxth2Y2M=;
 b=M4Pql7m2GOrzjkzsF7ZTAJvTFh/+qhAmsxrMCXnE7O3LudrnsXs5HcE0fLgMsnbjBLVQ2uvtwKJHvGv0GLQV4rYaV5oH04THduQFzVRk2JOZr+gYImkSHCjoCckevjd9ENtNvbM9Fgu07bLjf7yIzq41+C19F0eFIQiu7Q/7KsbLgKMUViZtVnwToCK14GoAMty45jSn9mIx1pJClJLeXku1SFkQaCbPjZLMTLeEgEBgnujznTpSmlQO0o5akpPrqOVB4LCUFogsAVcvGBX3HDAqt0NSq+VHBTWCg+8T+/hCqEE105GIhogxOkCgRROErfrcaSxbJy93sZZvtySQmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM5PR12MB1146.namprd12.prod.outlook.com (2603:10b6:3:73::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3455.24; Thu, 8 Oct
 2020 18:18:24 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::cdbe:f274:ad65:9a78]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::cdbe:f274:ad65:9a78%7]) with mapi id 15.20.3433.046; Thu, 8 Oct 2020
 18:18:24 +0000
Date:   Thu, 8 Oct 2020 15:18:22 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
CC:     <dledford@redhat.com>, <linux-rdma@vger.kernel.org>,
        Mike Marciniszyn <mike.marciniszyn@cornelisnetworks.com>
Subject: Re: [PATCH for-next] IB/hfi,rdmavt,qib,opa_vnic: Update MAINTAINERS
Message-ID: <20201008181822.GC374464@nvidia.com>
References: <20201008171803.189100.43448.stgit@awfm-01.aw.intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20201008171803.189100.43448.stgit@awfm-01.aw.intel.com>
X-ClientProxiedBy: BL0PR05CA0009.namprd05.prod.outlook.com
 (2603:10b6:208:91::19) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (156.34.48.30) by BL0PR05CA0009.namprd05.prod.outlook.com (2603:10b6:208:91::19) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.11 via Frontend Transport; Thu, 8 Oct 2020 18:18:23 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1kQaUg-001ZSt-AP; Thu, 08 Oct 2020 15:18:22 -0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1602181135; bh=rx4y00aJGChx5Ty3rD3RbvRwLXWF48kdf0otxth2Y2M=;
        h=ARC-Seal:ARC-Message-Signature:ARC-Authentication-Results:Date:
         From:To:CC:Subject:Message-ID:References:Content-Type:
         Content-Disposition:In-Reply-To:X-ClientProxiedBy:MIME-Version:
         X-MS-Exchange-MessageSentRepresentingType;
        b=loJ8/7Lw1Z7kIh89ei1DeaTHShhRmrUc9YafzNCElKz6eNeDtYXDS7z1rrrOfDGhN
         HqGcVYq91FjygnUrkkUsCvbgeM40lz9WvOYps3+s4n9+nfRt1uxOrYt39vaCVhbiWY
         aCK25toPtfP8MEc1Ytj0bhYrFl+tAnm0tCYpcOaS+pHx1iN5spB2EuuJxs7ypuXPVQ
         KG4vcwE11aK2PFS7LZZ+Jz7p/+9E6DNVdfsdqPrJYzrMGyoPfijUUm5Vc7PPzI//np
         z92u06VMBRfMwCCFfPiEXhnvB78UqdtSAO8ITmnzz66ePNa3SbTQbziVjejV+kQrsQ
         lClTWIIKdDPjg==
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Oct 08, 2020 at 01:18:03PM -0400, Dennis Dalessandro wrote:
> Intel has spun off the Omni-Path Architecture group which is now a new
> company known as Cornelis Networks. Updating the MAINTAINERS file to
> reflect this change and our new email addresses.
> 
> Signed-off-by: Mike Marciniszyn <mike.marciniszyn@cornelisnetworks.com>
> Signed-off-by: Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
> ---
>  MAINTAINERS |   16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)

Applied to for-next

Thanks,
Jason
