Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C45C328FBC9
	for <lists+linux-rdma@lfdr.de>; Fri, 16 Oct 2020 01:47:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732990AbgJOXrY (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 15 Oct 2020 19:47:24 -0400
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:13177 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732988AbgJOXrY (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 15 Oct 2020 19:47:24 -0400
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5f88df5f0000>; Thu, 15 Oct 2020 16:46:39 -0700
Received: from HQMAIL107.nvidia.com (172.20.187.13) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 15 Oct
 2020 23:47:22 +0000
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.100)
 by HQMAIL107.nvidia.com (172.20.187.13) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Thu, 15 Oct 2020 23:47:22 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lsHSrrN6AVWnIdsQxFEnHQ8b4Mwkfk0i8Z40GOuS2p+Dvv+N0SH9HnDuFIWOENJFKcromFhFAKdAlDkkMruZVOLXoxvr3iSwh+EiqtwdxaoQm830Z884kIvLTByloQMIgqCCrveeT16lxq2+Gg+l3WDqS928zcceno1KXrCViFr1vhjMqU+T0HKZ3G28JHnRbekGATebaYJek8kyZ4KRXif7P2ycv5c6Ke9wQqUkTw6Vsur2xQIjZtNfWTdiFfZZ7hgMXCvVN9NbIeM9NXgIoLBpFXsMu1ZhZH/Eb6qK+NdKOFaHahElSimBcHVqHd3PNrEAB+p4OZ53QOtHY18w+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5/he1BR0apycDANF7BHH9Ee+8I5VU4qMB8TVa3yjlzs=;
 b=BTDxfltLamQVyqVxgW2Bk5FqTNC4JW68UIMphnV0PiAvLmO4QlgaZ0lKeWaBZoUWgzY2hVrD61oYP1NTPL3pGO05ohqvZ2aa4Y00znMUaxiD1Tm5ehofbADD5kpMCAsHz+An8LCWcDBqa1U9nLZbeBYt37j7BXEzDG5ChrOavmfY/18r/OW9Jijn1I9khupnkg/5dQKi8nXNCKuJqrvi9gVi9MFz9+FMf+s1gZEO+VW2jisoh6RTfUVWvV2HSdbpcsR9C5eH5rjawPwbhT6HCDlyN5FsK47s/F3X9POQ/qsrn2zUq2FWtRZ/xhAiTb+nrjjVXNaMNklX+mcZSWycIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB2859.namprd12.prod.outlook.com (2603:10b6:5:15d::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.20; Thu, 15 Oct
 2020 23:47:21 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::cdbe:f274:ad65:9a78]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::cdbe:f274:ad65:9a78%7]) with mapi id 15.20.3477.020; Thu, 15 Oct 2020
 23:47:21 +0000
Date:   Thu, 15 Oct 2020 20:47:20 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Bob Pearson <rpearsonhpe@gmail.com>
CC:     <zyjzyj2000@gmail.com>, <linux-rdma@vger.kernel.org>,
        Bob Pearson <rpearson@hpe.com>
Subject: Re: [PATCH] Provider/rxe: Fix regression to UD traffic
Message-ID: <20201015234720.GA6219@nvidia.com>
References: <20201015201750.8336-1-rpearson@hpe.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20201015201750.8336-1-rpearson@hpe.com>
X-ClientProxiedBy: BL0PR02CA0106.namprd02.prod.outlook.com
 (2603:10b6:208:51::47) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (156.34.48.30) by BL0PR02CA0106.namprd02.prod.outlook.com (2603:10b6:208:51::47) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.21 via Frontend Transport; Thu, 15 Oct 2020 23:47:21 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1kTCxs-0005WO-3w; Thu, 15 Oct 2020 20:47:20 -0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1602805599; bh=5/he1BR0apycDANF7BHH9Ee+8I5VU4qMB8TVa3yjlzs=;
        h=ARC-Seal:ARC-Message-Signature:ARC-Authentication-Results:Date:
         From:To:CC:Subject:Message-ID:References:Content-Type:
         Content-Disposition:In-Reply-To:X-ClientProxiedBy:MIME-Version:
         X-MS-Exchange-MessageSentRepresentingType;
        b=o9PXflt5uR4fTzlZOxnnz4qou9Nwm6L3deZ+IuQrupl/ALR6lY1Wt8BjMImM7AyQk
         aWPiKd31btV9iZFZSLDO9bpBlCTWgfzH0DT0r9b0XrwffNLIpN7SwCSIPaaEhvm2ta
         OrwZt4Cceb644z8/+6xN00H4Zho/pivuGsF+5C1KALUTSq+FoYTcQd61ZzrTsfRzrG
         ZMvfqDv3j0Tu6H4mevx6JMIR/Ii0+JteVfiidOP1GS2fTLqMzlgXaAkZLQXpwDoBjV
         FtEL3OFEKz8SJgNfv1K8tX5zKKd45p0vF/7/L/qKXrVSSANyG1O7Rs4nxp+O+qaiqG
         bgEeCID+T2Deg==
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Oct 15, 2020 at 03:17:51PM -0500, Bob Pearson wrote:
> Update enum rdma_network_type copy to match kernel version.
> Without this change provider/rxe will send incorrect
> network types to the kernel in send WQEs.
> 
> This fix keeps rxe functional but should be replaced by a better
> implementation.
> 
> Signed-off-by: Bob Pearson <rpearson@hpe.com>
> ---
>  providers/rxe/rxe.h | 1 +
>  1 file changed, 1 insertion(+)

Well, we can't just break user space so the kernel has to change in
some way to accommodate this.

Obviously rxe should not have uAPI stuff that is not in
include/uapi/rdma, so lets just fix that directly.

Please confirm I did this right. The PR for this merge window must be
sent Friday.

From 8b20e1ceea413c98cb98930cb549be390226320f Mon Sep 17 00:00:00 2001
From: Jason Gunthorpe <jgg@nvidia.com>
Date: Thu, 15 Oct 2020 20:42:18 -0300
Subject: [PATCH] RDMA/rxe: Move the definitions for rxe_av.network_type to
 uAPI

RXE was wrongly using an internal kernel enum as part of its uAPI, split
this out into a dedicated uAPI enum just for RXE. It only uses the IPv4
and IPv6 values.

This was exposed by changing the internal kernel enum definition which
broke RXE.

Fixes: 1c15b4f2a42f ("RDMA/core: Modify enum ib_gid_type and enum rdma_network_type")
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/infiniband/sw/rxe/rxe_net.c | 8 ++++----
 include/uapi/rdma/rdma_user_rxe.h   | 6 ++++++
 2 files changed, 10 insertions(+), 4 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_net.c b/drivers/infiniband/sw/rxe/rxe_net.c
index 31b93e7e1e2f41..575e1a4ec82121 100644
--- a/drivers/infiniband/sw/rxe/rxe_net.c
+++ b/drivers/infiniband/sw/rxe/rxe_net.c
@@ -133,14 +133,14 @@ static struct dst_entry *rxe_find_route(struct net_device *ndev,
 		if (dst)
 			dst_release(dst);
 
-		if (av->network_type == RDMA_NETWORK_IPV4) {
+		if (av->network_type == RXE_NETWORK_TYPE_IPV4) {
 			struct in_addr *saddr;
 			struct in_addr *daddr;
 
 			saddr = &av->sgid_addr._sockaddr_in.sin_addr;
 			daddr = &av->dgid_addr._sockaddr_in.sin_addr;
 			dst = rxe_find_route4(ndev, saddr, daddr);
-		} else if (av->network_type == RDMA_NETWORK_IPV6) {
+		} else if (av->network_type == RXE_NETWORK_TYPE_IPV6) {
 			struct in6_addr *saddr6;
 			struct in6_addr *daddr6;
 
@@ -442,7 +442,7 @@ struct sk_buff *rxe_init_packet(struct rxe_dev *rxe, struct rxe_av *av,
 	if (IS_ERR(attr))
 		return NULL;
 
-	if (av->network_type == RDMA_NETWORK_IPV4)
+	if (av->network_type == RXE_NETWORK_TYPE_IPV6)
 		hdr_len = ETH_HLEN + sizeof(struct udphdr) +
 			sizeof(struct iphdr);
 	else
@@ -469,7 +469,7 @@ struct sk_buff *rxe_init_packet(struct rxe_dev *rxe, struct rxe_av *av,
 	skb->dev	= ndev;
 	rcu_read_unlock();
 
-	if (av->network_type == RDMA_NETWORK_IPV4)
+	if (av->network_type == RXE_NETWORK_TYPE_IPV4)
 		skb->protocol = htons(ETH_P_IP);
 	else
 		skb->protocol = htons(ETH_P_IPV6);
diff --git a/include/uapi/rdma/rdma_user_rxe.h b/include/uapi/rdma/rdma_user_rxe.h
index d8f2e0e46daba7..e591d8c1f3cf10 100644
--- a/include/uapi/rdma/rdma_user_rxe.h
+++ b/include/uapi/rdma/rdma_user_rxe.h
@@ -39,6 +39,11 @@
 #include <linux/in.h>
 #include <linux/in6.h>
 
+enum {
+	RXE_NETWORK_TYPE_IPV4 = 1,
+	RXE_NETWORK_TYPE_IPV6 = 2,
+};
+
 union rxe_gid {
 	__u8	raw[16];
 	struct {
@@ -57,6 +62,7 @@ struct rxe_global_route {
 
 struct rxe_av {
 	__u8			port_num;
+	/* From RXE_NETWORK_TYPE_* */
 	__u8			network_type;
 	__u8			dmac[6];
 	struct rxe_global_route	grh;
-- 
2.28.0

