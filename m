Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED9A5310F62
	for <lists+linux-rdma@lfdr.de>; Fri,  5 Feb 2021 19:03:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233681AbhBEQUQ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 5 Feb 2021 11:20:16 -0500
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:10515 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229981AbhBEQSO (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 5 Feb 2021 11:18:14 -0500
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B601d879c0000>; Fri, 05 Feb 2021 09:59:56 -0800
Received: from HKMAIL104.nvidia.com (10.18.16.13) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 5 Feb
 2021 17:59:55 +0000
Received: from HKMAIL103.nvidia.com (10.18.16.12) by HKMAIL104.nvidia.com
 (10.18.16.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 5 Feb
 2021 17:59:13 +0000
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.177)
 by HKMAIL103.nvidia.com (10.18.16.12) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Fri, 5 Feb 2021 17:59:12 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hLmt2GF3dDu47+UXKD+CSYWgjGDWrzzr/owMR2d7h72BI9UV6KWSHtC23dl5j7VD8U8ajzhptVVg/qgfg7v3dSpn7K0/cwVyJS6Ru23ocOZ6OmHy3ra6koycdzb3JXHbXj8k9wT8cZW3qGY5s85LcsFlfngbXnY0mGMx/a+HufypPScmVDJKsFJmqeqhMa9X0PPH54g81L8tWYiMK2E463ghfuuThw0na3gqw8J+fy//kMZy7R+tn26j7iAOkuFIS98C7ZzSFf2WhWXGIo60rU88u2lFqyl9aqj9VSh87TkUvvyzPHl8G1cPXoMow0kl0InQNsTfpO9TQ5SXYwy/vQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wgfkpcd0KZlOKVCLKh3wmsXi/4Yf7nx04CfAJeYU7Q8=;
 b=Lf9L3VYag6JofFLU9DSU7mnDifMp4fCTiH9FICnOUQQGCqLXRRRGW+Gdn/hSMWQjh7yXPKuuuUR2K7SN3bk+Pny6mbdB3ABwNxrAqHNhGSDjSWQUTrQt8cpiaEyDhKSkX4R8beqalBlLjZHTf4+DwxTdUkWbpxkgu9ZPco4u8UHyEJSLGDx4uj1gLlJw6XCaNizZAMNbqdq86zkqg2gWiJ8ktigENHVS6Z7z5Pw/613MBWmoWnWcxBAdzwh0Tu0KInLABtX6Tss3zWMVbts+gRiCuhLi8jFxrd08OA+vR6p4U646A9tvmFAxM8rZsQJTPl0uxbvZ0Zw1dV/TdXxWFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM5PR1201MB0201.namprd12.prod.outlook.com (2603:10b6:4:5b::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3825.19; Fri, 5 Feb
 2021 17:59:10 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::d6b:736:fa28:5e4]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::d6b:736:fa28:5e4%7]) with mapi id 15.20.3825.025; Fri, 5 Feb 2021
 17:59:10 +0000
Date:   Fri, 5 Feb 2021 13:59:08 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Bob Pearson <rpearsonhpe@gmail.com>
CC:     <zyjzyj2000@gmail.com>, <linux-rdma@vger.kernel.org>,
        Bob Pearson <rpearson@hpe.com>
Subject: Re: [PATCH for-next] RDMA/rxe: Fix FIXME in rxe_udp_encap_recv()
Message-ID: <20210205175908.GE968475@nvidia.com>
References: <20210128233318.2591-1-rpearson@hpe.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20210128233318.2591-1-rpearson@hpe.com>
X-ClientProxiedBy: BLAPR03CA0057.namprd03.prod.outlook.com
 (2603:10b6:208:32d::32) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (142.162.115.133) by BLAPR03CA0057.namprd03.prod.outlook.com (2603:10b6:208:32d::32) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3825.21 via Frontend Transport; Fri, 5 Feb 2021 17:59:09 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1l85Ns-00441k-Fo; Fri, 05 Feb 2021 13:59:08 -0400
X-Header: ProcessedBy-CMR-outbound
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1612547996; bh=wgfkpcd0KZlOKVCLKh3wmsXi/4Yf7nx04CfAJeYU7Q8=;
        h=ARC-Seal:ARC-Message-Signature:ARC-Authentication-Results:Date:
         From:To:CC:Subject:Message-ID:References:Content-Type:
         Content-Disposition:In-Reply-To:X-ClientProxiedBy:MIME-Version:
         X-MS-Exchange-MessageSentRepresentingType:X-Header;
        b=DBENfgEWs3+3l24naUYN6Lj1xvOkrYLEkZaBDs96QUQknVSi1Yg28/WU7scE2SAXK
         1iLrEVfhI4CSW75opidkPjurohsriToBLSZ6GWuYzco2NLcJuxmFgdVUTAvGBuyJiV
         0NKo00agFL+tHXXBIiVpJnyxYy2jCJmRQSWaFK5Z6Tl1wdqJfjOPbmJXG/QexJqaMl
         DuYVkmq/WO6SvQRcYqfbB1mM0pippfLj6aR9HanKnZcQAExbBHnQx1RbfVnNjHk49U
         XDZflg3u3ZJo9eSp3JCX0s5S71MB7WdsTZXzNPCcFG5srWOTMcwQGLJYVqy/x1q0zP
         E+6MlY+nzzsnw==
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Jan 28, 2021 at 05:33:19PM -0600, Bob Pearson wrote:
> rxe_udp_encap_recv() drops the reference to rxe->ib_dev taken by
> rxe_get_dev_from_net() which should be held until each received
> skb is freed. This patch moves the calls to ib_device_put() to
> each place a received skb is freed. It also takes references to
> the ib_device for each cloned skb created to process received
> multicast packets.
> 
> Fixes: 4c173f596b3ff ("RDMA/rxe: Use ib_device_get_by_netdev()
>                 instead of open coding")

Do not line wrap fixes lines

> diff --git a/drivers/infiniband/sw/rxe/rxe_recv.c b/drivers/infiniband/sw/rxe/rxe_recv.c
> index c9984a28eecc..8e60d9eaf79a 100644
> --- a/drivers/infiniband/sw/rxe/rxe_recv.c
> +++ b/drivers/infiniband/sw/rxe/rxe_recv.c
> @@ -266,10 +266,19 @@ static void rxe_rcv_mcast_pkt(struct rxe_dev *rxe, struct sk_buff *skb)
>  		/* for all but the last qp create a new clone of the
>  		 * skb and pass to the qp.
>  		 */
> -		if (mce->qp_list.next != &mcg->qp_list)
> +		if (mce->qp_list.next != &mcg->qp_list) {
>  			per_qp_skb = skb_clone(skb, GFP_ATOMIC);
> -		else
> +			if (!ib_device_try_get(&rxe->ib_dev)) {
> +				/* shouldn't happen we already have
> +				 * one ref for skb.
> +				 */
> +				pr_warn("ib_device_try_get failed\n");
> +				kfree_skb(per_qp_skb);

I fixed this to just

+                       if (WARN_ON(!ib_device_try_get(&rxe->ib_dev))) {
+                               kfree_skb(per_qp_skb);
+                               continue;
+                       }

> +				continue;
> +			}
> +		} else {
>  			per_qp_skb = skb;
> +		}

And this had a merge collision with the mcast patch, I fixed it up

Applied to for-next, thanks

Jason
