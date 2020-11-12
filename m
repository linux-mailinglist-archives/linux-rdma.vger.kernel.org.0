Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D31622B08E4
	for <lists+linux-rdma@lfdr.de>; Thu, 12 Nov 2020 16:50:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728643AbgKLPuZ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 12 Nov 2020 10:50:25 -0500
Received: from nat-hk.nvidia.com ([203.18.50.4]:14818 "EHLO nat-hk.nvidia.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728032AbgKLPuZ (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 12 Nov 2020 10:50:25 -0500
Received: from HKMAIL104.nvidia.com (Not Verified[10.18.92.9]) by nat-hk.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5fad59bb0000>; Thu, 12 Nov 2020 23:50:19 +0800
Received: from HKMAIL103.nvidia.com (10.18.16.12) by HKMAIL104.nvidia.com
 (10.18.16.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 12 Nov
 2020 15:50:18 +0000
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.168)
 by HKMAIL103.nvidia.com (10.18.16.12) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Thu, 12 Nov 2020 15:50:18 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Oxf66+QC8e/jT3Z2pggL+Om4z6fA5JjfF4JNDv07mrTlRX6C4vdf4tzHQ2KTTwYdCWgcFBjvD8WlxIn3KtcKoeyIyGdp3lye3g3V5rXhrowb+1FvNlQDwD++eno8+smGBgyuFE++rLyFLTifwlF23sq+eWoGqNZuRhwd0z04BGy9iDZXbln+5nRfuRXSJb3pHSk9XypX+vsYqFCKExoaHihFBeIv0uF/nF29DYcYTbPmGyh5DmrppUTJSZ8XHV9yzT+Bc1RGQIFWIe5QF3ngyHGuwcfhFlY5HFX1oQiiIVu1hvy2GDINZOuFV8soENlnF0HCFqHVwyWaCGSvmqbsLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PC2aeIpEGUzwuaovxLWV+khUF/SthytqPNPWiutv/9E=;
 b=TOslHumj6pRCEUsN5LsHPGhI1OkypYB2JHiqhP/xEnFQbcmxfw0lc80GFFJqnnq1YP5cuOo1q1Lcs2dI4ZPsG5RTBS7s6JCl79B3WERFT3EOPrJj7w23IFily4r3V1DnPnugR+oTLWGKbSRPWAIivzoijzKw2XKhps25CaW98m8oxof/tYu+4u/KM8gNCiVloauXP8yGs+Bub5Et/IuCrYwhYR3Uprq5zlL3ow5H8QAjq2c0G0/FbDuNe+CCw50zCrrI27XkkEHMB4CX5GNFO56x67V45uPHrNuJa6OMdsHKDDVLt3UdXMhAuSCymdi7CMHURTBUxvRE/DIVcw0kvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM5PR12MB1243.namprd12.prod.outlook.com (2603:10b6:3:74::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3541.25; Thu, 12 Nov
 2020 15:50:16 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::cdbe:f274:ad65:9a78]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::cdbe:f274:ad65:9a78%7]) with mapi id 15.20.3499.032; Thu, 12 Nov 2020
 15:50:16 +0000
Date:   Thu, 12 Nov 2020 11:50:13 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Zhu Yanjun <yanjunz@nvidia.com>
CC:     <zyjzyj2000@gmail.com>, <dledford@redhat.com>,
        <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH 1/1] RDMA/rxe: Remove VLAN code leftovers from RXE
Message-ID: <20201112155013.GA893182@nvidia.com>
References: <1604326422-18625-1-git-send-email-yanjunz@nvidia.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <1604326422-18625-1-git-send-email-yanjunz@nvidia.com>
X-ClientProxiedBy: BL1PR13CA0106.namprd13.prod.outlook.com
 (2603:10b6:208:2b9::21) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (156.34.48.30) by BL1PR13CA0106.namprd13.prod.outlook.com (2603:10b6:208:2b9::21) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3564.21 via Frontend Transport; Thu, 12 Nov 2020 15:50:15 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1kdErV-003kMt-Li; Thu, 12 Nov 2020 11:50:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1605196219; bh=PC2aeIpEGUzwuaovxLWV+khUF/SthytqPNPWiutv/9E=;
        h=ARC-Seal:ARC-Message-Signature:ARC-Authentication-Results:Date:
         From:To:CC:Subject:Message-ID:References:Content-Type:
         Content-Disposition:In-Reply-To:X-ClientProxiedBy:MIME-Version:
         X-MS-Exchange-MessageSentRepresentingType;
        b=oD9FpGHkLAdMtRXsBDMZkJ8AurKuq9q/kW/pTOYqvz58eyIuM1nyaocjMtldmosH9
         OcJ1Paqln66g30ob3pV0rM/fd39WzRcd+hJORBjjBIwhYsaHrPSRcFhqGRFY1aqizB
         VbPNB6TGkGYOYD8kqodz99Ylb1vipOIG5vmsAqaQN4xkVPihA5rK3UlxD/ZN7b96FJ
         O9MS9+fd9q3azMeynBN/TxgRo27iZ5d8hBx+SUegYsIc2vkzXsUrPT+8FPZ/rQnfsh
         ON++rJgGtnutSb/w2BmgyslxTdP+o0hprNpQFGtyVpW7bBuu4Cc0WrZ8siKpox6REp
         dk44LNOFbWw3g==
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Nov 02, 2020 at 10:13:42PM +0800, Zhu Yanjun wrote:
> Since the commit fd49ddaf7e26 ("RDMA/rxe: prevent rxe creation on
> top of vlan interface") does not permit rxe on top of vlan device,
> all the stuff related with vlan should be removed.
> 
> Fixes: fd49ddaf7e26 ("RDMA/rxe: prevent rxe creation on top of vlan interface")
> Signed-off-by: Zhu Yanjun <yanjunz@nvidia.com>
> Reviewed-by: Leon Romanovsky <leonro@nvidia.com>
> ---
>  drivers/infiniband/sw/rxe/rxe_net.c  |    9 ---------
>  drivers/infiniband/sw/rxe/rxe_resp.c |    5 -----
>  2 files changed, 0 insertions(+), 14 deletions(-)

Applied to for-next, thanks

Jason
