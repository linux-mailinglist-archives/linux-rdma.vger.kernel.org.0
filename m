Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A4B32FAE01
	for <lists+linux-rdma@lfdr.de>; Tue, 19 Jan 2021 01:18:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728956AbhASASM (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 18 Jan 2021 19:18:12 -0500
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:14754 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725968AbhASASM (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 18 Jan 2021 19:18:12 -0500
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B6006251b0000>; Mon, 18 Jan 2021 16:17:31 -0800
Received: from HQMAIL109.nvidia.com (172.20.187.15) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 19 Jan
 2021 00:17:31 +0000
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.175)
 by HQMAIL109.nvidia.com (172.20.187.15) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Tue, 19 Jan 2021 00:17:30 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ErNUAEGn3EtaZaHlxCJHk5anWHdexDZ85ReDBxkpCp0AQFGdvRZjV+Nf1CfERVtEnehb+d8E56STVwjX3WUoOUevNAG4I8JUY24adR/gFNCQYe1DPU0F6Yt4diRoM0nfkW/+0XjOFPnTnO9Cb0iNkAtDYv6s8+ZNz/5x3rzyuWMsSj5nw6M/+/i3D3BZ0tVxqP9sp4IvE/NEu8iezmhoLCEO1uiY2Rp8m5/ptoxd3tormS2VVX/aEn8n+8qm5v9VVf9O5qz05tPQES8VJoOIFgMaQedS/xCc4ZqgQCB8SsTNGimmlr+ypq8GxfBjYdgsIDPL2UTAM/PqWhk78quDXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nxxBTneuvGVaqCWlspPMLz9cNmBoz4EyqLcAD45kvrM=;
 b=YDJSzuvPcRHeZgvoDYCaHnd7VhPOg8gSgKuAmnG8Cvj4XMEhEuljBFviUpyoPp/ihkIyIqTNVWDnfVz1zR6/+MENH848cnjiPSQXDxBqUXeWiJmjPCCYiI2vsFeMa1oWeq0pC3wF0iwr6gV9ihB3dlWO0gvdKaILszTiyy5L+EJDicEcd8RWFe4t2qh2BssR3FTKgDplM1T4D7IIqJMZecxpeNe+pg44d78P/XX3Y+4vq7c5qZQ7s/DMOpizJB4KQgEjoFEobDVDkA+y5VPKB74tA1+mABrv6Idh0DE/nXG98h5MQ9p5yynjMUiRpbGZTF+f6OvM7uV+GrUYWOuOzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB4973.namprd12.prod.outlook.com (2603:10b6:5:1b7::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3763.9; Tue, 19 Jan
 2021 00:17:29 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::546d:512c:72fa:4727]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::546d:512c:72fa:4727%7]) with mapi id 15.20.3763.014; Tue, 19 Jan 2021
 00:17:29 +0000
Date:   Mon, 18 Jan 2021 20:17:28 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Kamal Heib <kamalheib1@gmail.com>
CC:     <linux-rdma@vger.kernel.org>, Doug Ledford <dledford@redhat.com>,
        Potnuri Bharat Teja <bharat@chelsio.com>
Subject: Re: [PATCH for-rc] RDMA/cxgb4: Fix the reported max_recv_sge value
Message-ID: <20210119001728.GA801964@nvidia.com>
References: <20210114191423.423529-1-kamalheib1@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20210114191423.423529-1-kamalheib1@gmail.com>
X-ClientProxiedBy: MN2PR13CA0003.namprd13.prod.outlook.com
 (2603:10b6:208:160::16) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (142.162.115.133) by MN2PR13CA0003.namprd13.prod.outlook.com (2603:10b6:208:160::16) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3784.4 via Frontend Transport; Tue, 19 Jan 2021 00:17:29 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1l1ei8-003PWe-8k; Mon, 18 Jan 2021 20:17:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1611015451; bh=nxxBTneuvGVaqCWlspPMLz9cNmBoz4EyqLcAD45kvrM=;
        h=ARC-Seal:ARC-Message-Signature:ARC-Authentication-Results:Date:
         From:To:CC:Subject:Message-ID:References:Content-Type:
         Content-Disposition:In-Reply-To:X-ClientProxiedBy:MIME-Version:
         X-MS-Exchange-MessageSentRepresentingType;
        b=BKzFXJbecvL5shR9ddOp5lkDHHF1+hX13v8h6UZd8E8ivoSgfLgYqiHUeDzHDThsn
         0BvkOcViRSTWt4vZZMMKHL2DUwjzXTLl8F90Pwb323At/8l36hcgD/ikGuYvX31C6r
         T7vb4hQY9RHgmk5wpJoUsrN7yy1e6PDwftcLoM4eYp829VNPLgdh7zp5+yMjzGRsbU
         QOuRhlKFucUclEsQjFKdUf03psbMlmjuZ6wgrLdoHnsrbPX99STeY2bVReTRgQUEUd
         p0DWuo6UEVi5GGf7wQ8IeBMVf0XMhdL3769ih/9rwLzF5+NS7X92OPynoGciiSnX8C
         g21x315doAq1w==
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Jan 14, 2021 at 09:14:23PM +0200, Kamal Heib wrote:
> The max_recv_sge value is wrongly reported when calling query_qp, This
> is happening due to a typo when assigning the max_recv_sge value, the
> value of sq_max_sges was assigned instead of rq_max_sges.
> 
> Fixes: 3e5c02c9ef9a ("iw_cxgb4: Support query_qp() verb")
> Signed-off-by: Kamal Heib <kamalheib1@gmail.com>
> Reviewed-by: Potnuri Bharat Teja <bharat@chelsio.com>
> ---
>  drivers/infiniband/hw/cxgb4/qp.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied to for-rc, thanks

Jason
