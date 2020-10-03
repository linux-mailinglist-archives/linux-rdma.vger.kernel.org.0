Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E16DE28275C
	for <lists+linux-rdma@lfdr.de>; Sun,  4 Oct 2020 01:21:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726087AbgJCXV4 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sat, 3 Oct 2020 19:21:56 -0400
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:14783 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726080AbgJCXV4 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sat, 3 Oct 2020 19:21:56 -0400
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5f7907870000>; Sat, 03 Oct 2020 16:21:43 -0700
Received: from HQMAIL101.nvidia.com (172.20.187.10) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Sat, 3 Oct
 2020 23:21:56 +0000
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.169)
 by HQMAIL101.nvidia.com (172.20.187.10) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Sat, 3 Oct 2020 23:21:55 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SHNR+d6kdCI8EszFmP5vWM62dke8l/k/oRJJYLM/UPsMGpYiZEs1xXWxtxi8hWgxCvRLrhBxfn0SAqD25lN88lpLlann+yYFDZhvtSujnyLxktw4wBT8Xu1RPwx2egxpjdqKU+huVXheXi6wVCMf791Hjnk8PRZjB06hSA5S7Yxl5ZGWH/f2ViEubkGi87NMukv5lSKJIDNzoZnEQaha/ncfijUE/Wj9reXezyBOtk1+LipUULVIPiGH0+cII+BBLZkljwokunxuXekWvn0mBtvIiJgFifwRM80vAxmOtifM4aL7d4SGLFxJqf2lLIwvv0PuC666nT/26fB+H2tbRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Gek/Fg5H6PeA6+Kk0MjYcJVww7xFkuKaSD7QvL/gW48=;
 b=L+pUU5AQo5Bkc/3OlXQ7eyIEtKFZ1Tj1IJ7a1RVfZp2/8MAVrR6fUr8etk0ZAaOkkYw3u26bTze2F+4wBf/KNxiPMMStcLsc+9vUAzq/VJSdWcENRiepxQAixu9Iwh7fDjQlFxz/c/vjNxgOXWUmCrXCMedRZLT4PfIPFeyQCcR515ZO9LeMrcln+Sg7CE2Hfy/SqBR7BRKtpFVJJtqJLMa46fcUbf8XwdGOy9WrF730Axv9tsNbnNiwCRlHiwc98yKcGel0HT6RngCGOzG9FfUjyJvbTuljw9pnnpKYgCGBvOdgRjpJaVVlqpIf9Po1it+8ZF+ABasQpwcMhL3Puw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM5PR12MB2582.namprd12.prod.outlook.com (2603:10b6:4:b5::37) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3433.32; Sat, 3 Oct
 2020 23:21:54 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::cdbe:f274:ad65:9a78]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::cdbe:f274:ad65:9a78%7]) with mapi id 15.20.3433.038; Sat, 3 Oct 2020
 23:21:54 +0000
Date:   Sat, 3 Oct 2020 20:21:53 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Bob Pearson <rpearsonhpe@gmail.com>
CC:     <zyjzyj2000@gmail.com>, <linux-rdma@vger.kernel.org>,
        Bob Pearson <rpearson@hpe.com>
Subject: Re: [PATCH for-next v7 10/19] rdma_rxe: Add support for
 ibv_query_device_ex
Message-ID: <20201003232153.GM816047@nvidia.com>
References: <20201001174847.4268-1-rpearson@hpe.com>
 <20201001174847.4268-11-rpearson@hpe.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20201001174847.4268-11-rpearson@hpe.com>
X-ClientProxiedBy: BL0PR02CA0131.namprd02.prod.outlook.com
 (2603:10b6:208:35::36) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (156.34.48.30) by BL0PR02CA0131.namprd02.prod.outlook.com (2603:10b6:208:35::36) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3433.36 via Frontend Transport; Sat, 3 Oct 2020 23:21:54 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1kOqqf-0075f9-8m; Sat, 03 Oct 2020 20:21:53 -0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1601767303; bh=Gek/Fg5H6PeA6+Kk0MjYcJVww7xFkuKaSD7QvL/gW48=;
        h=ARC-Seal:ARC-Message-Signature:ARC-Authentication-Results:Date:
         From:To:CC:Subject:Message-ID:References:Content-Type:
         Content-Disposition:In-Reply-To:X-ClientProxiedBy:MIME-Version:
         X-MS-Exchange-MessageSentRepresentingType;
        b=fxEnTeCNCrknkrgICQF0UXLNU54MFmdIwejwyYcpHX/rbrsmoge1fdO1Qp4vL3RtC
         AMe6eOAJmL5ZVJLDb9O4IijpL0rQAJen6n/eOZJwMRBg8qyYDIXYk2rBDMGKt4MtcF
         LI1nCr3mgy/2Jfu7fmAiN6YNjWSSfNfzW4lcAz3NyV0FLQRTBtVxu4mlPuCtBW901a
         2SrDfbDufKzC5K9kGiUlHodh/zE4D1dca9pUOcUSWGEdXefynXLPuetaESgw8LEbbI
         TEY8Y2Vj24YHGSvIcFhEWHv4bcacGQwurxRiXCEL06pZw3NzQXV/tJHjQvc/kLMzR4
         6xpmEVsJM7fAw==
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Oct 01, 2020 at 12:48:38PM -0500, Bob Pearson wrote:
> Add code to initialize new struct members in
> ib_device_attr as place holders.
> 
> Signed-off-by: Bob Pearson <rpearson@hpe.com>
> ---
>  drivers/infiniband/sw/rxe/rxe.c       | 101 ++++++++++++++++++--------
>  drivers/infiniband/sw/rxe/rxe_verbs.c |   7 +-
>  2 files changed, 75 insertions(+), 33 deletions(-)

This series should eliminate this patch and notably change the others

https://patchwork.kernel.org/project/linux-rdma/list/?series=359361

Can you take a look that it works for this?

Thanks,
Jason
