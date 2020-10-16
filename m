Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1975B290A28
	for <lists+linux-rdma@lfdr.de>; Fri, 16 Oct 2020 19:01:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2409057AbgJPRBS (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 16 Oct 2020 13:01:18 -0400
Received: from nat-hk.nvidia.com ([203.18.50.4]:2496 "EHLO nat-hk.nvidia.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2408925AbgJPRBR (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 16 Oct 2020 13:01:17 -0400
Received: from HKMAIL104.nvidia.com (Not Verified[10.18.92.100]) by nat-hk.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5f89d1db0000>; Sat, 17 Oct 2020 01:01:15 +0800
Received: from HKMAIL101.nvidia.com (10.18.16.10) by HKMAIL104.nvidia.com
 (10.18.16.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 16 Oct
 2020 17:01:15 +0000
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.48) by
 HKMAIL101.nvidia.com (10.18.16.10) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Fri, 16 Oct 2020 17:01:15 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y0ltFi3EAPCxf00PpvxzR+tYi5l7ftu+gUU6J/+KvtaPkgITdaVksJT9EU/X/I0XgOaM3F5t79OE/kf/VKYMAI4XFVALx8TtjysFINq1x+e2ToIbfufrHsAjxBW+CWUMQby/WkV/MyTXyuwxD8owE0b+c3Kqi2Qp84jUCXNmzYn7vn5AnVOduZFP2aQY9oYVLfpxUUpXNJo/CMCUlvyaIAxkFhFNt2Ay1M8tkGkpFZLrT4+7lwEPV2QS3UAgzNQMwGqkHdhiFNXNx4XKe5Zv/urpQevKu092W7qVBIQDdIPQpsGlJox6wA/F4cHOuOBvKniMDBdQrp0usQ4h37ZD8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=He/SNOA2FcGyApttD8FZ01MtDk0lK12g0+c9CwbC+tc=;
 b=Sy9DAkcGvh8TsyI2/yE/JxIhPf2f4Cp2a86dmeWnDlLweof0DP6jNMhNgGB6kJJz9rQmlEo3I3KiXLW84McAIa7BqCYEWXYdTa5uZ7vOOqPsewQtcJJuSM8vE4tSF0092Rz9xLVCbnxOAa8w5Qvl4rU+LqFABGLiFux2uXEDrsIBJUosN6E8aLuZ/1RStqs4xbgSkb8cQhbsacvlpa8JAxp03KX3UlHZJhUryU/0Z33VvHzK7WoMEL6G6uxXrbI+orvmtUfJBj1iEJtd2jmcxeLTkHZs+fM/tnMciV0oU1Z0bOep+Jb1ZkQvfanFuYbb5bOmEAiWkidz0J7lW0lnLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB2940.namprd12.prod.outlook.com (2603:10b6:5:15f::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3455.22; Fri, 16 Oct
 2020 17:01:13 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::cdbe:f274:ad65:9a78]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::cdbe:f274:ad65:9a78%7]) with mapi id 15.20.3477.020; Fri, 16 Oct 2020
 17:01:13 +0000
Date:   Fri, 16 Oct 2020 14:01:11 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Bob Pearson <rpearsonhpe@gmail.com>
CC:     <zyjzyj2000@gmail.com>, <colin.king@canonical.com>,
        <linux-rdma@vger.kernel.org>, Bob Pearson <rpearson@hpe.com>
Subject: Re: [PATCH for-next] RDMA/rxe - Respond to skb_clone failure in
 rxe_recv.c
Message-ID: <20201016170111.GA160906@nvidia.com>
References: <20201013184236.5231-1-rpearson@hpe.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20201013184236.5231-1-rpearson@hpe.com>
X-ClientProxiedBy: BL1PR13CA0020.namprd13.prod.outlook.com
 (2603:10b6:208:256::25) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (156.34.48.30) by BL1PR13CA0020.namprd13.prod.outlook.com (2603:10b6:208:256::25) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.9 via Frontend Transport; Fri, 16 Oct 2020 17:01:13 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1kTT6N-000fsK-Ua; Fri, 16 Oct 2020 14:01:11 -0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1602867675; bh=He/SNOA2FcGyApttD8FZ01MtDk0lK12g0+c9CwbC+tc=;
        h=ARC-Seal:ARC-Message-Signature:ARC-Authentication-Results:Date:
         From:To:CC:Subject:Message-ID:References:Content-Type:
         Content-Disposition:In-Reply-To:X-ClientProxiedBy:MIME-Version:
         X-MS-Exchange-MessageSentRepresentingType;
        b=FtjL+A7XF/qbzz//TJKtGlTm4Fao3yvio11yIeDTJmw6gmn9O8lRdiVKPecxbqCR9
         SMj7c967FDgQObFPU+kh+9aCZZHhdJK5GXufc3Hl80pBy/KF2gmhNwE7SGDTN5iSDD
         Q2zVt2y/CXTXLbNeBvmeNuG/QUGCM+5am5ioUUl+PHLd+/1hdfspziELwgBkZGUc5y
         WEW24vcYBGapGtc3PQRPDQK/COkWP+7wTEp/jns3VVD4Z6VPt3OZmjMCPRld6iCkhe
         Q9by3EJJXNq62vkdMc1oa5BKl1a7Pxy7JsiUmKR7dl/JS/nkniB0/mKo+g1Io5cc/F
         w5Sv8V9eNLoCg==
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Oct 13, 2020 at 01:42:37PM -0500, Bob Pearson wrote:
> If skb_clone is unable to allocate memory for a new
> sk_buff this is not detected by the current code.
> 
> Check for a NULL return and continue. This is similar to
> other errors in this loop over QPs attached to the multicast address
> and consistent with the unreliable UD transport.
> 
> Fixes: e7ec96fc7932f ("RDMA/rxe: Fix skb lifetime in rxe_rcv_mcast_pkt()")
> Signed-off-by: Bob Pearson <rpearson@hpe.com>
> ---
>  drivers/infiniband/sw/rxe/rxe_recv.c | 3 +++
>  1 file changed, 3 insertions(+)

Subject should be 'RDMA/rxe:' not '-'

Place () after function names for clarity

Flow text to the full 76 lines

I fixed it all up and applied to for-next

Thanks,
Jason
