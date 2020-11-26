Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AFD3B2C5B84
	for <lists+linux-rdma@lfdr.de>; Thu, 26 Nov 2020 19:06:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404743AbgKZSE2 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 26 Nov 2020 13:04:28 -0500
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:1988 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404733AbgKZSE2 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 26 Nov 2020 13:04:28 -0500
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5fbfee330001>; Thu, 26 Nov 2020 10:04:35 -0800
Received: from HQMAIL111.nvidia.com (172.20.187.18) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 26 Nov
 2020 18:04:28 +0000
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.47) by
 HQMAIL111.nvidia.com (172.20.187.18) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Thu, 26 Nov 2020 18:04:28 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UZ9+gi0qOF9VVGPVEd3QY1B/ytnEatf0RRi/5xUZqdTPo6vpUdGxIwtLAHsujZe7nlGeglc8juFFEdiCIz8gcBZGZF2LB9Nqtol7XHMDrQPaFFzLz1kd91tyKUZ1KmTgIR7ukWUy8FJGcFmkRUiicaWVeA/caOkTALc13crQckFGUVF6flhj9XV72XDLjdigOwSP1B89mqlLFd5vQycimiKIlA+c/MsDwOtWPRdzhOZ6L4Noqe0oQlzmUFIBTcIM/IE6ku5F1E1i69N3BmA13LnqmbjyO8Iy8gEsN4th94X0Sm7UIs1Zz+gQsDNdXL/w+722Hrxto0q9IvaEDGdZuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bP/jacIAXara8xVvAyE4gCMNtaSv8jbWtO4yCxGpTEA=;
 b=c0uwrdHisA72WS2d8HqkfSKarAWNl/JZaCwpwbqtMLDhexTrTk5i2YBbuZa+eZq4hgMkaC6IqtJUZOE9uZiZ7F6G456Uitu7vSX1Z3D1WtpjPtanq7FfmsiVn0D7Cv9rVP7nyvXtQ0AxszZ1xXaBaVThp85hsN3zklKANizVxN8lSgYCDBbcx71USE5RzD9lqZLbxlfTQbRdRKTgv3zJrvJm4freCfc1jMEZLG2EgUBI7oVyDvvVtWK4hAn6pahHrWknLqaxP708aN4eBZbyYlgw0AtNCG3iSqEN2+XupRx7BEXe+sa+Ig+jJ/sgBmnZNFFr0EK+tJlAf3SyGDWLVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3611.23; Thu, 26 Nov
 2020 18:04:20 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1ce9:3434:90fe:3433]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1ce9:3434:90fe:3433%3]) with mapi id 15.20.3611.024; Thu, 26 Nov 2020
 18:04:20 +0000
Date:   Thu, 26 Nov 2020 14:04:18 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Leon Romanovsky <leon@kernel.org>
CC:     Doug Ledford <dledford@redhat.com>,
        Leon Romanovsky <leonro@nvidia.com>,
        Avihai Horon <avihaih@nvidia.com>,
        <linux-kernel@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
        Maor Gottlieb <maorg@nvidia.com>,
        Yishai Hadas <yishaih@nvidia.com>
Subject: Re: [PATCH rdma-next 0/2] Enable querying AH for XRC QP types
Message-ID: <20201126180418.GA541574@nvidia.com>
References: <20201115121425.139833-1-leon@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20201115121425.139833-1-leon@kernel.org>
X-ClientProxiedBy: BL0PR02CA0064.namprd02.prod.outlook.com
 (2603:10b6:207:3d::41) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (156.34.48.30) by BL0PR02CA0064.namprd02.prod.outlook.com (2603:10b6:207:3d::41) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3611.20 via Frontend Transport; Thu, 26 Nov 2020 18:04:19 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1kiLcw-002Gtk-On; Thu, 26 Nov 2020 14:04:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1606413875; bh=bP/jacIAXara8xVvAyE4gCMNtaSv8jbWtO4yCxGpTEA=;
        h=ARC-Seal:ARC-Message-Signature:ARC-Authentication-Results:Date:
         From:To:CC:Subject:Message-ID:References:Content-Type:
         Content-Disposition:In-Reply-To:X-ClientProxiedBy:MIME-Version:
         X-MS-Exchange-MessageSentRepresentingType;
        b=pWSQ2wqaSvWRjjT1Ol6sqcTXpcAI9at1F/JaINCzlyVtf11qngxhd9npuxe7cw2Hn
         Xt9lEryHwom2GuemQniHYdBZCn7qDmyx1ZiCDuBvld+63JH+fODrKnKoVpg6Rj5F0Y
         6UaM0PK6pwAJSNsBa55b2Ao43+bTuuCk8fm6Y2AHcThbRZMVaZwY56Kk1U73BrLCZO
         EGrGLdPtZn468xJE432jgIQDYqHpWl9FZILspMGDfRzvq3ThSR6HNF7bXdEAu7mB8n
         mXUcu9z9r/DFIhw9Ija7XsNyl9zUFv4Mu7l+oT8t37j1g+Hg2h/ojnRvOst1RCyeWo
         ms22zDq/FN4ug==
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sun, Nov 15, 2020 at 02:14:23PM +0200, Leon Romanovsky wrote:
> From: Leon Romanovsky <leonro@nvidia.com>
> 
> Update mlx4 and mlx5 drivers to support querying AH for XRC QP types.
> 
> Thanks
> 
> Avihai Horon (2):
>   RDMA/mlx5: Enable querying AH for XRC QP types
>   RDMA/mlx4: Enable querying AH for XRC QP types

Applied to for-next, thanks

Jason
