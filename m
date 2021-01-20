Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F281F2FD736
	for <lists+linux-rdma@lfdr.de>; Wed, 20 Jan 2021 18:42:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731290AbhATReg (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 20 Jan 2021 12:34:36 -0500
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:4942 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390308AbhATRck (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 20 Jan 2021 12:32:40 -0500
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B6008690f0002>; Wed, 20 Jan 2021 09:31:59 -0800
Received: from HQMAIL101.nvidia.com (172.20.187.10) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 20 Jan
 2021 17:31:59 +0000
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.170)
 by HQMAIL101.nvidia.com (172.20.187.10) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Wed, 20 Jan 2021 17:31:59 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NKteSEtb5pT4I7Es4rmjn/CSJbpCQ3LebFxkqSpfs2pRoplvzWocb2qhUw1R/Sfh5dLXXaZuS594g7HbTTfLxPh1+ZUHDJ41CLaHoHCXhf5g/BXeL9QiUIWO+ipll+qqJOQ2q+O/awP4dhWAT8swbw1FJG3Xxvfugp75hieOzM9FAGBBz3eaVapl/15guCxsNWVOR5Lqzs9Xz1SkuF5LtoL/z1JpT+LBYtLN9j/SaB3LAZX9eR9buloIUz7kpWrwunecJEWPY2Eh6rbIJwUeMAfL+bU3jIJZ8LRcYrJ67+TVBcFSmdOanpM5MZ3WI6cnn/CEeu2FGx1Q05fpI5Ze+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NpEpw9f05Ev6w8QWRCEyYCrqFHKFUnfcIc5kPeJ4eeE=;
 b=lV5srdgeHw8etut9sZ6ctNp+oT9H8eyS2siwe9wn+YGVLqPlSDOUHEIjMN98TLXJvfvpLWyNxaNY+vPPSql8FpOVR/l5uDVf7ovVubTrewm3fXevGKoA1UBvcQew+ZElXe7QnWjSeUGOGGSqoeW976t6ZjwM2Q4F0SsV1YEM66BPDaxiCPdkEtcISfTW24hcVSwunwcTi/cNS1VfnmX/QpsbAOEbDKCqbOtNb6hUzov9zMUQBOEQypgibWAmByhX6Ljpp7MOz1uQYrKMlyw2dxgeqmr3Vv+Vb2ApGt98dcDCfGdRvgmrci+MvUVFN6ARuGrLWJ0JOau6TDlFQKzDJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB3210.namprd12.prod.outlook.com (2603:10b6:5:185::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3784.13; Wed, 20 Jan
 2021 17:31:58 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::546d:512c:72fa:4727]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::546d:512c:72fa:4727%7]) with mapi id 15.20.3784.011; Wed, 20 Jan 2021
 17:31:58 +0000
Date:   Wed, 20 Jan 2021 13:31:56 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     <mwilck@suse.com>
CC:     <linux-rdma@vger.kernel.org>, Zhu Yanjun <zyjzyj2000@gmail.com>,
        Mohammad Heib <goody698@gmail.com>,
        Nicolas Morey-Chaisemartin <nmoreychaisemartin@suse.com>
Subject: Re: [PATCH v2] Revert "RDMA/rxe: Remove VLAN code leftovers from RXE"
Message-ID: <20210120173156.GA1103504@nvidia.com>
References: <20210120161913.7347-1-mwilck@suse.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20210120161913.7347-1-mwilck@suse.com>
X-ClientProxiedBy: MN2PR07CA0005.namprd07.prod.outlook.com
 (2603:10b6:208:1a0::15) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (206.223.160.26) by MN2PR07CA0005.namprd07.prod.outlook.com (2603:10b6:208:1a0::15) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3784.12 via Frontend Transport; Wed, 20 Jan 2021 17:31:57 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1l2HKm-004d5Z-9r; Wed, 20 Jan 2021 13:31:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1611163919; bh=NpEpw9f05Ev6w8QWRCEyYCrqFHKFUnfcIc5kPeJ4eeE=;
        h=ARC-Seal:ARC-Message-Signature:ARC-Authentication-Results:Date:
         From:To:CC:Subject:Message-ID:References:Content-Type:
         Content-Disposition:In-Reply-To:X-ClientProxiedBy:MIME-Version:
         X-MS-Exchange-MessageSentRepresentingType;
        b=fJU4zB02WB6uYh0Mom0NXgqIqDNPD5HrcD7nDNuMBYMHcg1IOK2kqOk3Z5ox/U5xb
         Yp4+7VKpCvt33LH09twDcZiTJhZ20GfgUWuRerotFzdEk/2d5T2GMqB2gq5baLzs3o
         gMpOK0Fc6Tw4Oxf3DdTMuPaFu38FqF3BPsq6r4FjyBHtuNe3BTOZWBqOemapiP7C/a
         /OzdsdOsZBDi6/LmctRq+wyaz7SJMKRxIJxqQ53paKtzgeORcTHq4gOcZ8rriYpfgH
         UCFwOR+HF+9kaEkk/dI+4qZoUCNHsFNtgsZhm0J5AqOuVE+lmZGnULsIiujeikcHjc
         vTPm+4OWYHLJw==
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Jan 20, 2021 at 05:19:13PM +0100, mwilck@suse.com wrote:
> From: Martin Wilck <mwilck@suse.com>
> 
> This reverts commit b2d2440430c0fdd5e0cad3efd6d1c9e3d3d02e5b.
> 
> It's true that creating rxe on top of 802.1q interfaces doesn't work.
> Thus, commit fd49ddaf7e26 ("RDMA/rxe: prevent rxe creation on top of vlan interface")
> was absolutely correct.
> 
> But b2d2440430c0 was incorrect assuming that with this change,
> RDMA and VLAN don't work togehter at all. It just has to be
> set up differently. Rather than creating rxe on top of the VLAN
> interface, rxe must be created on top of the physical interface.
> RDMA then works just fine through VLAN interfaces on top of that
> physical interface, via the "upper device" logic.
> 
> I've tested this mainly with NVMe over RDMA and rping, but I don't
> see why it wouldn't work just as well for other protocols. If there
> are real issues, I'd like to know.
> 
> b2d2440430c0 broke this setup deliberately and should thus be
> reverted. Also, b2d2440430c0 removed rxe_dma_device() (which is
> indeed not necessary), but not its declaration in rxe_loc.h.
> 
> Fixes: b2d2440430c0 ("RDMA/rxe: Remove VLAN code leftovers from RXE")
> 
> Cc: Zhu Yanjun <zyjzyj2000@gmail.com>
> Cc: Mohammad Heib <goody698@gmail.com>
> Cc: Nicolas Morey-Chaisemartin <nmoreychaisemartin@suse.com>
> Signed-off-by: Martin Wilck <mwilck@suse.com>
>  drivers/infiniband/sw/rxe/rxe_loc.h  | 1 -
>  drivers/infiniband/sw/rxe/rxe_net.c  | 6 ++++++
>  drivers/infiniband/sw/rxe/rxe_resp.c | 5 +++++
>  3 files changed, 11 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/infiniband/sw/rxe/rxe_loc.h b/drivers/infiniband/sw/rxe/rxe_loc.h
> index 0d758760b9ae..8adcef54e4b3 100644
> +++ b/drivers/infiniband/sw/rxe/rxe_loc.h
> @@ -116,7 +116,6 @@ struct sk_buff *rxe_init_packet(struct rxe_dev *rxe, struct rxe_av *av,
>  				int paylen, struct rxe_pkt_info *pkt);
>  int rxe_prepare(struct rxe_pkt_info *pkt, struct sk_buff *skb, u32 *crc);
>  const char *rxe_parent_name(struct rxe_dev *rxe, unsigned int port_num);
> -struct device *rxe_dma_device(struct rxe_dev *rxe);
>  int rxe_mcast_add(struct rxe_dev *rxe, union ib_gid *mgid);
>  int rxe_mcast_delete(struct rxe_dev *rxe, union ib_gid *mgid);

I can't take this hunk as a -rc patch

But I took the rest to for-rc, thanks

Jason
