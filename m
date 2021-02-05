Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C6816310F68
	for <lists+linux-rdma@lfdr.de>; Fri,  5 Feb 2021 19:03:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233543AbhBEQVN (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 5 Feb 2021 11:21:13 -0500
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:10084 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233632AbhBEQPb (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 5 Feb 2021 11:15:31 -0500
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B601d86f20006>; Fri, 05 Feb 2021 09:57:06 -0800
Received: from HQMAIL107.nvidia.com (172.20.187.13) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 5 Feb
 2021 17:57:05 +0000
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.176)
 by HQMAIL107.nvidia.com (172.20.187.13) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Fri, 5 Feb 2021 17:57:05 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X/t4JkP+V7tVMqIWOnWIh6DkPNQfrGJhIvmmIZTqLPncNd5PfwiGZgBgtTZp7ZIRUgVSzkjgwOvrZfGyHXRbCeirzpz3RziqxW1wwePRKGIW7UAguidXIBXma1texlKZdAB2dK4PNb0XPAL9elgCiSsQOcAGNhFzqQtUED1bk67OR2LRdVEWpsRJtbHjHF7eXA9PqjuUMgmpfNOkRAhDZR52gAckDzg+7CIjUfiTyQcypm/DsosmhHbJK1/+Xn2PpBFT/e2IudK6r5HZOpQqRU3MjijdDbPQzVyDaUqPvp8Q8yniCC7ByEEO6V7Uu2bMw+qlNQzk2g9L1ZAqkqP8Iw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SGvMi04ZRtkWhNZ1dV9lRzvYuTtqluJ985Mfrea99S4=;
 b=OILrUZ3vMr6KnUAhz4qBVUdRrSHruSTSZXiLuHm8SjwX3hZdrvk7JTNBIkHNE8+b7OcFNZ1yRK/jmLdsCGiwO12KlXN12bNjrgTJV4jctooPy9MpjyHRnrffl+IwLpNy9nDAC6fawq+aWQ0GF3Nb98lU0tGwmAVxyZx+CvWPe9joeA1zR6Iz8NKPq8Cg06Ns59T17yPaNxlujFZ5ko07dZfx2q+FJqNDmWLhbbtiKjcGSZb/VKo9RD7URU5rd70L02mgWJUhJQxeSMS2EQYAeRuf1QoMa99SxZax0s5fenOL2ZYHx6o1ro08/xDBbKEoiVVnK/LnuzC1b0fLvS7j2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM5PR1201MB0201.namprd12.prod.outlook.com (2603:10b6:4:5b::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3825.19; Fri, 5 Feb
 2021 17:57:04 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::d6b:736:fa28:5e4]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::d6b:736:fa28:5e4%7]) with mapi id 15.20.3825.025; Fri, 5 Feb 2021
 17:57:04 +0000
Date:   Fri, 5 Feb 2021 13:57:01 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Bob Pearson <rpearsonhpe@gmail.com>
CC:     <zyjzyj2000@gmail.com>, <linux-rdma@vger.kernel.org>,
        Bob Pearson <rpearson@hpe.com>
Subject: Re: [PATCH for-next] RDMA/rxe: Fix coding error in rxe_recv.c
Message-ID: <20210205175701.GA968475@nvidia.com>
References: <20210127214500.3707-1-rpearson@hpe.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20210127214500.3707-1-rpearson@hpe.com>
X-ClientProxiedBy: BL0PR02CA0115.namprd02.prod.outlook.com
 (2603:10b6:208:35::20) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (142.162.115.133) by BL0PR02CA0115.namprd02.prod.outlook.com (2603:10b6:208:35::20) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3825.17 via Frontend Transport; Fri, 5 Feb 2021 17:57:03 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1l85Lp-0043ya-T2; Fri, 05 Feb 2021 13:57:01 -0400
X-Header: ProcessedBy-CMR-outbound
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1612547826; bh=SGvMi04ZRtkWhNZ1dV9lRzvYuTtqluJ985Mfrea99S4=;
        h=ARC-Seal:ARC-Message-Signature:ARC-Authentication-Results:Date:
         From:To:CC:Subject:Message-ID:References:Content-Type:
         Content-Disposition:In-Reply-To:X-ClientProxiedBy:MIME-Version:
         X-MS-Exchange-MessageSentRepresentingType:X-Header;
        b=DgzG+ZT95/45wKri8mtfOqzmpMaGr02EBmrOo3WWRfA6h2tcwm9F1ESOIkWl3YWWN
         MwujoCYg/H0DfBPa+gESZsl7qu+1GqUVtUtKTKTPZiinNWBBZFKQKHMQfZU8VYervG
         tNeyLX01sVP5Vsb2HD+mJhk9xZZCtJmdTyk+mVtd3MlWl+PgLkYy+JlZkqFsaxIZQr
         cyoKetWIUNYu/gZ499X5F4DMJRJ/Xr80CSHDtGrDuDtbpA2IH2aXr0X/7XEvalATzR
         t6DO7BO3gAB8MkhjBusRZstSsYZ2iYIUokFDxMyBmb0okk2Yj/HTodF181xrNjSnC+
         yoTEwViwcwILw==
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Jan 27, 2021 at 03:45:01PM -0600, Bob Pearson wrote:
> check_type_state() in rxe_recv.c is written as if the type bits in
> the packet opcode were a bit mask which is not correct. This patch
> corrects this code to compare all 3 type bits to the required type.
> 
> Fixes: 8700e3e7c485 ("Soft RoCE driver")
> Signed-off-by: Bob Pearson <rpearson@hpe.com>
> ---
>  drivers/infiniband/sw/rxe/rxe_recv.c | 11 ++++++++---
>  1 file changed, 8 insertions(+), 3 deletions(-)

Applied to for-next, thanks
 
> diff --git a/drivers/infiniband/sw/rxe/rxe_recv.c b/drivers/infiniband/sw/rxe/rxe_recv.c
> index c9984a28eecc..0c9b857194fe 100644
> --- a/drivers/infiniband/sw/rxe/rxe_recv.c
> +++ b/drivers/infiniband/sw/rxe/rxe_recv.c
> @@ -9,21 +9,26 @@
>  #include "rxe.h"
>  #include "rxe_loc.h"
>  
> +/* check that QP matches packet opcode type and is in a valid state */
>  static int check_type_state(struct rxe_dev *rxe, struct rxe_pkt_info *pkt,
>  			    struct rxe_qp *qp)
>  {
> +	int pkt_type;

I fixed this to 'unsigned int'

Jason
