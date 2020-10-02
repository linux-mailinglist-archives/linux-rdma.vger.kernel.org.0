Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A8407280BAA
	for <lists+linux-rdma@lfdr.de>; Fri,  2 Oct 2020 02:31:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731525AbgJBAby (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 1 Oct 2020 20:31:54 -0400
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:7756 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727053AbgJBAby (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 1 Oct 2020 20:31:54 -0400
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5f7674c50000>; Thu, 01 Oct 2020 17:31:01 -0700
Received: from HQMAIL111.nvidia.com (172.20.187.18) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 2 Oct
 2020 00:31:53 +0000
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.100)
 by HQMAIL111.nvidia.com (172.20.187.18) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Fri, 2 Oct 2020 00:31:53 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FkLqjNft1VUGtGFR272dnP4ynLIz0lU4ah8Gch6zMhUeyKVPvjNHilcb2wQ34UzNtgVdkP6iNfLXkI0VEynHW/+ILWDheFZoQ3/qIGQSJsrNscrz84YwBU/AA8Txfg/cFquGUw+ORR9mpv58/jzolRnpVCd7kILmE+GagOJ7VECROT2TnOH0NO8oOmEkaV2xmbKZagsktD3StaxNJ+UkaPv85xYIqfEEEtwfslZv2IFsIRkAK2qY5fnCMxJgq2C6P8e1Uu8BXfP5HudmlD/f4tF1voJWYI+AizkTdE9WuMyKfFBBGj8Wark/MAu0eWAKVVOEkRWShq/Uwey3QzAVmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wzCB6TBO+8GHcrOrgmO8WEzmJJI6yTAwk+MglEf6XZE=;
 b=lzU0Su7N72HP5tE8SbJQYscBghCVId1Lyn8KHxPhcctiyOrBWU9SDQBiBltmyz/JyBre+5geb5m4VJoepSCdj2LnxefnWspIRtw9c8cpjfYCkZZN4O4gK9JfOdoNimt7M2hFxRNBX9uljVfPI1m8bJsvV2zxiWKtMrVmQ1hdTHpTPIseBUU0QkgI0g14sls0s1Xhmg2LU1QQqnbve+MwlyWrD7JMCa6OZZwFWP0U6RMzFiv71NE26Q8LYrWPkJRNPbFMebxEKjG85O43XuEqGS2yc2XX13h2o4JN9D+NMjqSUQGFMUoKwkgn+N9X0GPLhWA/Y5OamFiQZjE6LS8AZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM5PR12MB1433.namprd12.prod.outlook.com (2603:10b6:3:73::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3433.37; Fri, 2 Oct
 2020 00:31:51 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::cdbe:f274:ad65:9a78]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::cdbe:f274:ad65:9a78%7]) with mapi id 15.20.3433.032; Fri, 2 Oct 2020
 00:31:51 +0000
Date:   Thu, 1 Oct 2020 21:31:50 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Leon Romanovsky <leon@kernel.org>
CC:     Doug Ledford <dledford@redhat.com>,
        Leon Romanovsky <leonro@nvidia.com>,
        Kees Cook <keescook@chromium.org>,
        <linux-kernel@vger.kernel.org>,
        RDMA mailing list <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH rdma-next] overflow: Include header file with SIZE_MAX
 declaration
Message-ID: <20201002003150.GA1286456@nvidia.com>
References: <20200913102928.134985-1-leon@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20200913102928.134985-1-leon@kernel.org>
X-ClientProxiedBy: MN2PR10CA0014.namprd10.prod.outlook.com
 (2603:10b6:208:120::27) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (156.34.48.30) by MN2PR10CA0014.namprd10.prod.outlook.com (2603:10b6:208:120::27) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3433.37 via Frontend Transport; Fri, 2 Oct 2020 00:31:51 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1kO8zG-005Og5-69; Thu, 01 Oct 2020 21:31:50 -0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1601598661; bh=wzCB6TBO+8GHcrOrgmO8WEzmJJI6yTAwk+MglEf6XZE=;
        h=ARC-Seal:ARC-Message-Signature:ARC-Authentication-Results:Date:
         From:To:CC:Subject:Message-ID:References:Content-Type:
         Content-Disposition:In-Reply-To:X-ClientProxiedBy:MIME-Version:
         X-MS-Exchange-MessageSentRepresentingType;
        b=CjneiHoqkrgj9f88iYn632lCkpO8TfJjmspqpLlfVm7SKBD96hFcUS07Ovxz3hoIA
         eXnWuBID8KYCsfhDsvf59Xgrpt1pnxPZqlXoTwn7f9AkWrBJO4Atevamf2wAdFnYUA
         xaRjRhiEt+qUcSw7+zg7wOyuZmCU2EICaSYFPORKFAP/ihxEZnvAuQ3cN9gK/1cm5g
         jrlI0GixZYw/chAHFKddsZjqCy+5sICIZkuSXDDAmYaHJtN0+Nq7CsRVoOlvv9FAMs
         UEbTQIOFzZsnPDCGwjET+oZJVVeY6JWNfte7k/T+B9xBamlBXhMI0/Dwrs7XQzLbZR
         f2CfxoUb7JgjQ==
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sun, Sep 13, 2020 at 01:29:28PM +0300, Leon Romanovsky wrote:
> From: Leon Romanovsky <leonro@nvidia.com>
> 
> The various array_size functions use SIZE_MAX define, but missed limits.h
> causes to failure to compile code that needs overflow.h.
> 
>  In file included from drivers/infiniband/core/uverbs_std_types_device.c:6:
>  ./include/linux/overflow.h: In function 'array_size':
>  ./include/linux/overflow.h:258:10: error: 'SIZE_MAX' undeclared (first use in this function)
>    258 |   return SIZE_MAX;
>        |          ^~~~~~~~
> 
> Fixes: 610b15c50e86 ("overflow.h: Add allocation size calculation helpers")
> Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
> ---
>  include/linux/overflow.h | 1 +
>  1 file changed, 1 insertion(+)

Applied to rdma for-next, seems other patches need this. Thanks

Jason
