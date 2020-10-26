Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 39AAC2999B1
	for <lists+linux-rdma@lfdr.de>; Mon, 26 Oct 2020 23:30:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394520AbgJZWae (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 26 Oct 2020 18:30:34 -0400
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:17225 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2394447AbgJZWad (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 26 Oct 2020 18:30:33 -0400
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5f974e100000>; Mon, 26 Oct 2020 15:30:40 -0700
Received: from HQMAIL107.nvidia.com (172.20.187.13) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 26 Oct
 2020 22:30:33 +0000
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.168)
 by HQMAIL107.nvidia.com (172.20.187.13) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Mon, 26 Oct 2020 22:30:33 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Bp5pJN4wPHCSCU/++KnVo4m4pY8TbJBC6gzRQr/p5VYUznoj36pAae6kL9I1ullhfXUxrvnZtw8mSzMBoWNjsvrbbBygEQu0AKZBcCj6aezemnijxhAp2Qf0vpcXE2KKYEkdX+pfhLNdBRLfzkC2XCLSEj1K8X8l4HrozogJYaWyV2Lj9Uum5lsZu7yugKlWMmp1fi+uqrgTcdA+Uwr0PRIqOgR2YsokpMNAES0GC+Sy90dPMcox3CaQINv5dmeH7TGvHXvWd8vVtk1LZz/WSqvrQfoNt9IKz2XGpYCvGf4bRl4/9An2UzIYKqPoM0lUUlXbgwwqIgXGQ7cSbgIhpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QIrycoG3jymkFzYSsJfA/uYLdOOOa3BHUXZcESTgryU=;
 b=KUetB8Uko5TsbvpiO/+gT/6S0tNehiwwERKTBbn4C+VHNKA2J/Fc5TIHkQLw9Vuhk8mF1rtBnVL7PfMpAU/uh/62SEBe5kcBljGasYqyCo1HDEez280Rdiq9KnCfxSEX7XZsUxoxBlKdn/n0NMC7iU7XeXnmBteClVVZcwfy0eTdPTVUjGL6jRFilWjCKCBPq9VI4Mi3uF13hjr3lAkKcpMmgA3U0MYnIeH9biu+qLnSDRZwx4Gni0kl3FDu1B8/ILDcMH0KaFylizhLwQZGpKnGzbjL9OKNfkADJoZVqY7x++XyoVeFHAKqHUD6j9A5LL7dfsJ989TNnwnsktqkPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM5PR12MB1433.namprd12.prod.outlook.com (2603:10b6:3:73::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.21; Mon, 26 Oct
 2020 22:30:32 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::cdbe:f274:ad65:9a78]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::cdbe:f274:ad65:9a78%7]) with mapi id 15.20.3477.028; Mon, 26 Oct 2020
 22:30:32 +0000
Date:   Mon, 26 Oct 2020 19:30:29 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Gal Pressman <galpress@amazon.com>
CC:     Doug Ledford <dledford@redhat.com>, <linux-rdma@vger.kernel.org>,
        Leon Romanovsky <leonro@nvidia.com>,
        Avihai Horon <avihaih@nvidia.com>,
        Leon Romanovsky <leon@kernel.org>
Subject: Re: [PATCH for-next] RDMA/uverbs: Fix false error in query gid IOCTL
Message-ID: <20201026223029.GA2100962@nvidia.com>
References: <20201026082621.32463-1-galpress@amazon.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20201026082621.32463-1-galpress@amazon.com>
X-ClientProxiedBy: BL0PR03CA0001.namprd03.prod.outlook.com
 (2603:10b6:208:2d::14) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (156.34.48.30) by BL0PR03CA0001.namprd03.prod.outlook.com (2603:10b6:208:2d::14) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.18 via Frontend Transport; Mon, 26 Oct 2020 22:30:31 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1kXB0X-008oxM-R5; Mon, 26 Oct 2020 19:30:29 -0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1603751440; bh=QIrycoG3jymkFzYSsJfA/uYLdOOOa3BHUXZcESTgryU=;
        h=ARC-Seal:ARC-Message-Signature:ARC-Authentication-Results:Date:
         From:To:CC:Subject:Message-ID:References:Content-Type:
         Content-Disposition:In-Reply-To:X-ClientProxiedBy:MIME-Version:
         X-MS-Exchange-MessageSentRepresentingType;
        b=WoALKZOkF1IhWIqGvzkAefW+5E2jYgJgIjGeXTOsEg822IEm7pEMbshw/MJ2I6wgd
         Cwyj67+/9BnXVKdyLeru2Oo+GE3uUI9oXZ72UjEQTaQ4WtuVrMq9MOrBoDuZky+pl5
         IwzMEnoCZjHq3jlNDC9xZn1g32sJlnU3p6zp7g3DOK+P/YFgjXpEEawmX+LGvADqg7
         GOj6xOZHP8UhixXlePmaHuolMLAz8VJ/AeIycgIbtTnpENGN4GIyEqkIn4AilP8uMd
         aIGXSFU3BGsraosrxzgRdnjtxt+oIMtG0NX/CE8TzsO6nW42+VTB/TYtaUxzjwTKxb
         8Vl1bIR91J85g==
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Oct 26, 2020 at 10:26:21AM +0200, Gal Pressman wrote:
> Some drivers (such as EFA) have a GID table, but aren't IB/RoCE devices.
> Remove the unnecessary rdma_ib_or_roce() check.
> 
> Fixes: 9f85cbe50aa0 ("RDMA/uverbs: Expose the new GID query API to user space")
> Signed-off-by: Gal Pressman <galpress@amazon.com>
> ---
>  drivers/infiniband/core/uverbs_std_types_device.c | 3 ---
>  1 file changed, 3 deletions(-)

Applied to for-rc, thanks

Jason
