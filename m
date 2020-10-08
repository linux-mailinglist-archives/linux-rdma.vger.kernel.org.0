Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 20875287B8B
	for <lists+linux-rdma@lfdr.de>; Thu,  8 Oct 2020 20:18:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726792AbgJHSS6 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 8 Oct 2020 14:18:58 -0400
Received: from nat-hk.nvidia.com ([203.18.50.4]:3586 "EHLO nat-hk.nvidia.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726597AbgJHSS5 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 8 Oct 2020 14:18:57 -0400
Received: from HKMAIL104.nvidia.com (Not Verified[10.18.92.100]) by nat-hk.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5f7f580f0000>; Fri, 09 Oct 2020 02:18:55 +0800
Received: from HKMAIL101.nvidia.com (10.18.16.10) by HKMAIL104.nvidia.com
 (10.18.16.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 8 Oct
 2020 18:18:55 +0000
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.47) by
 HKMAIL101.nvidia.com (10.18.16.10) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Thu, 8 Oct 2020 18:18:54 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F6IGOyI2Ck030KxJHnD2CQgVHFGp7hFSbts07uinhrkqyB1uOnw3fB+SDhFYcRzQgvD1827EcSXm+AFObTMKAzRJZ4UlM/6mwK1DUYIf42pzG2wJ4Q4Yu7bYRZ3lWa9trgvX3XPi6rf22M6lmfTjP7uMksDTeetT5HtQkDFXIE9ybyB1aaHG0xQaHrLk/sSTpLhoc/ZYoCFonkARl61mipVR5TcBBq1hdmb5NqFEFgN/eaJxBV6MtfTo3415TDLEgmz4YuRE8aJEvpd96p5+mz4/mYQ/wXa19LmbHbBU2/DgFzyLKhgml7snH1gMYxD6Ei9p1QIaUZ8YYSPFKXRg9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wQSAsqkr8udNSx+3K8Uy+PjzhSa2tthzXxDO1Oy7aU8=;
 b=VpQMCWJZzty/Qy2JxCV3EziLcre5g7hkJBHvjr61/3EIaHFJS4VpaFmNkq+rfqGqJZJ8k76w9PfcijtLuJQrCtcBle+SGSxhB42VKD5hU6nK6+RS06S6B8YaazJXIDZyTDCX4cikT3MisL/mZEFA8YkHBfoSUBQcQyz+pSLQquMC5jCssYP/OdSpSFt60JUiJwGjzqF/OIeMJKHARJv85a8yEudLvPqACrzx48gHo2PnuxWU11Olv4T+yHnEAN2hfYfq0XqB5M8q/1haORcLyP+gfrY3YuDlyMMpT0J2Q87Phbl/zjL2bQnET2Z7Mbk/hJ+kX6W7GOufuSg+7y5U1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM5PR12MB1146.namprd12.prod.outlook.com (2603:10b6:3:73::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3455.24; Thu, 8 Oct
 2020 18:18:04 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::cdbe:f274:ad65:9a78]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::cdbe:f274:ad65:9a78%7]) with mapi id 15.20.3433.046; Thu, 8 Oct 2020
 18:18:04 +0000
Date:   Thu, 8 Oct 2020 15:18:02 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Colin King <colin.king@canonical.com>
CC:     Dennis Dalessandro <dennis.dalessandro@intel.com>,
        Mike Marciniszyn <mike.marciniszyn@intel.com>,
        Doug Ledford <dledford@redhat.com>,
        Ira Weiny <ira.weiny@intel.com>, <linux-rdma@vger.kernel.org>,
        <kernel-janitors@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] IB/rdmavt: Fix sizeof mismatch
Message-ID: <20201008181802.GB374464@nvidia.com>
References: <20201008095204.82683-1-colin.king@canonical.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20201008095204.82683-1-colin.king@canonical.com>
X-ClientProxiedBy: BL0PR0102CA0049.prod.exchangelabs.com
 (2603:10b6:208:25::26) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (156.34.48.30) by BL0PR0102CA0049.prod.exchangelabs.com (2603:10b6:208:25::26) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3455.23 via Frontend Transport; Thu, 8 Oct 2020 18:18:03 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1kQaUM-001ZSV-Kp; Thu, 08 Oct 2020 15:18:02 -0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1602181135; bh=wQSAsqkr8udNSx+3K8Uy+PjzhSa2tthzXxDO1Oy7aU8=;
        h=ARC-Seal:ARC-Message-Signature:ARC-Authentication-Results:Date:
         From:To:CC:Subject:Message-ID:References:Content-Type:
         Content-Disposition:In-Reply-To:X-ClientProxiedBy:MIME-Version:
         X-MS-Exchange-MessageSentRepresentingType;
        b=cUzTPRU6/IBg+rudA09StdOMjbM6lzDcT/vJ1lFhEAqEvSfH9NZxtS692o7v6SeJK
         huUzpGuGLCaAoRRjEetHV/LcD5t7X+bMb9fWUZ6vzTmrKV2+YKZgNSwiOOCO9BDXlV
         r7U/K5e1ooJ+YHSNM2Dg0eATOz4mBQaW4p3u7ylBzkGrT9uc3tvkyEdLGH9WsVz6YH
         pq+Bu3AiCq5w7YpOtdTUW0XX1WNZwMGq4poWGlXrAA5QwPA0VcRswgQiIMJttCig8p
         8eS2iZ+0Ik1U99fYvq32zTqNZtOh+H0Z5LbrJtZEeijbnhfnxWA3UrzW29Aq3Dp/Xw
         LqDM8RmQWVEPA==
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Oct 08, 2020 at 10:52:04AM +0100, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> An incorrect sizeof is being used, struct rvt_ibport ** is not correct,
> it should be struct rvt_ibport *. Note that since ** is the same size as
> * this is not causing any issues.  Improve this fix by using
> sizeof(*rdi->ports) as this allows us to not even reference the type
> of the pointer.  Also remove line breaks as the entire statement can
> fit on one line.
> 
> Addresses-Coverity: ("Sizeof not portable (SIZEOF_MISMATCH)")
> Fixes: ff6acd69518e ("IB/rdmavt: Add device structure allocation")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> Reviewed-by: Ira Weiny <ira.weiny@intel.com>
> Acked-by: Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
> ---
>  drivers/infiniband/sw/rdmavt/vt.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)

Applied to for-next, thanks

Jason
