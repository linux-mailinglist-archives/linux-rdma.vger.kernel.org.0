Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8CE2A2B5240
	for <lists+linux-rdma@lfdr.de>; Mon, 16 Nov 2020 21:17:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729744AbgKPUQU (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 16 Nov 2020 15:16:20 -0500
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:2705 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727204AbgKPUQT (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 16 Nov 2020 15:16:19 -0500
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5fb2de170000>; Mon, 16 Nov 2020 12:16:23 -0800
Received: from HQMAIL109.nvidia.com (172.20.187.15) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 16 Nov
 2020 20:16:19 +0000
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.176)
 by HQMAIL109.nvidia.com (172.20.187.15) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Mon, 16 Nov 2020 20:16:19 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MBuYbwKM7emi4zkKoQENaERDz6b8atkZCSVDtd1yY3+nun2CswcduiX+ep8nX2rTO+Is4yfpS4T3yMA575jCkxDZW/HHdgY5BsfkVQqEZn8aDTcYTdPBQr+mmQlbALWgzf9l11XN7m2NaATGdMT+LwROSvE4CB1KNX8GNSaMv8kLY76/kyD6f6EtUw3RDpJrCHyYcaj0LVhoVBcHUr1So1WDRPMFjYrJMYegQHdd5gB47ZQ9crBxm40cbwLtXXuO6rvCj2l7yHfH3Vr+yLu5r4swuO1Ecdj/ytemetwx4rxW1vnqEenpLwsgNdVgXHQRJDdAZMJAnxaIMQ87yGgowQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aV4/UkYUuW9ZruyzQVzhUOiNWRi/ddN1BL+iIQ+ms6U=;
 b=XJZcVW9HBxEyjSWu5i6Nw042fv/PPIzKbNWMEylFEcnGUk6yLRR0lTLQYQT9t506GRMOacq948Er/FpSwJsFiK1YC5NE+E5VUGRlXnls8oJg9bTCHMeBKQjOHhOufSEU2z9N7JUgjPbIbH49WUon6kAH1pkuIdTY/14Z73B5OKdakUMkl070hUL3Ymf5Bw0EWOdmqqDM9C6ZLJypoGlCOyizpEgwR0xuetoDw4rfc6itqWanicFhl4HJwJkE7pj4qvj2A/lqba6Hjnw1wRTWZ/Y8p4lb/qlY0Qqlf1nOh7zvs+paaT7qC1nsk9bdpNXn1F4uXN8MMHT5IrEBzO5lsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB4810.namprd12.prod.outlook.com (2603:10b6:5:1f7::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3564.25; Mon, 16 Nov
 2020 20:16:18 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::e40c:730c:156c:2ef9]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::e40c:730c:156c:2ef9%7]) with mapi id 15.20.3564.028; Mon, 16 Nov 2020
 20:16:18 +0000
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     <linux-rdma@vger.kernel.org>
Subject: [PATCH 3/4] iwpmd: Always copy the ss_family in copy_iwpm_sockaddr()
Date:   Mon, 16 Nov 2020 16:16:15 -0400
Message-ID: <3-v1-f03f70229014+144-fix_lto_jgg@nvidia.com>
In-Reply-To: <0-v1-f03f70229014+144-fix_lto_jgg@nvidia.com>
References: 
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: MN2PR01CA0041.prod.exchangelabs.com (2603:10b6:208:23f::10)
 To DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (156.34.48.30) by MN2PR01CA0041.prod.exchangelabs.com (2603:10b6:208:23f::10) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3564.25 via Frontend Transport; Mon, 16 Nov 2020 20:16:17 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1kekvA-006kmF-N7     for linux-rdma@vger.kernel.org; Mon, 16 Nov 2020 16:16:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1605557783; bh=mZUT2DUJm9nduciCWrQB9nPmIKLWLF2pVT9oC1VB+uk=;
        h=ARC-Seal:ARC-Message-Signature:ARC-Authentication-Results:From:To:
         Subject:Date:Message-ID:In-Reply-To:References:
         Content-Transfer-Encoding:Content-Type:X-ClientProxiedBy:
         MIME-Version:X-MS-Exchange-MessageSentRepresentingType;
        b=OOzL9pcEPWgPFHAuXzzHPQU8UkjkoyJdEMcDp4rXmVNUFfHvHzpdIjuQbJl6qDDN6
         ONa0PwCIIRLEiRYDY+r8vT7Oty2FXuQFSVaPua7h8Ce8Y1gsg5M2/1y+PxXSvGpBto
         NinVEQ22yaCshsL9amr71kkcB36TGHWIYCXQBvkn5NdvwnAcZPs6RNbuVUWn0q4Vjk
         eda7Yd3rBViIv8NlS4fmAO4U8k8M+b7AbY5ZtEZPnKoQN8OraH5JNWFPbaJWvn6Jrj
         SRVDHi1Ww1TYXu7lxceu2dvZkPoYKEKEi3TEmbHz0o4g+OuAc/mbS8j8I/0ROlOz2e
         Hqq7jQ7yFkSlw==
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

gcc10 with LTO finds a path where process_iwpm_wire_request() calls
copy_iwpm_sockaddr() and then does print_iwpm_sockaddr() against the
dst. If the case statement in copy_iwpm_sockaddr() bails then
print_iwpm_sockaddr() is still called and this triggers a read from
uninitialized memory.

Always copy the ss_family, this will cause the default case to be taken in
print_iwpm_sockaddr() as well.

Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 iwpmd/iwarp_pm_common.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/iwpmd/iwarp_pm_common.c b/iwpmd/iwarp_pm_common.c
index 8160180aee48e8..67309cbee6a057 100644
--- a/iwpmd/iwarp_pm_common.c
+++ b/iwpmd/iwarp_pm_common.c
@@ -570,6 +570,10 @@ void copy_iwpm_sockaddr(__u16 addr_family, struct sock=
addr_storage *src_sockaddr
 		*dst =3D *src;
 		break;
 	}
+	default:
+	assert(false);
+	if (dst_sockaddr)
+		dst_sockaddr->ss_family =3D addr_family;
 	}
 }
=20
--=20
2.29.2

