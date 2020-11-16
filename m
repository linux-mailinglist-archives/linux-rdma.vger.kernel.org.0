Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 73A362B5242
	for <lists+linux-rdma@lfdr.de>; Mon, 16 Nov 2020 21:17:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729595AbgKPUQU (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 16 Nov 2020 15:16:20 -0500
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:14442 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729707AbgKPUQU (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 16 Nov 2020 15:16:20 -0500
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5fb2de0b0000>; Mon, 16 Nov 2020 12:16:11 -0800
Received: from HQMAIL109.nvidia.com (172.20.187.15) by HQMAIL109.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 16 Nov
 2020 20:16:19 +0000
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.176)
 by HQMAIL109.nvidia.com (172.20.187.15) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Mon, 16 Nov 2020 20:16:19 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ct3ywEdvkLYbOuCaiwnIHU/jhQrAU7dFSEjoM0BIdbf/JJWCyCfVPyZL390aaWGYngvWld6zgqCgDwm3hm/tqSvExSaY7gpe6iFbw56rgD1dgamYJx0zKHFHI+daIHhQ2t820MKhAcw9p5i4ZiQ9UmU1Dzr2fjm3eVjHc719Q3L1GMAdnBi3ioUvRjN7Yy+7n/DuuatcIJfocFDOk5dfPMeGh9jaM3XTrFQowZcYGcEgPkqCqNDbTs/pw0V6vWdx3aRaajrLP7sZsi8STF1flE9Sgb0CQDVqWticZlVHaN8PE6KiINkiRxhvB7qE1h+4Gc/8yrFCIfshd4DIPpopfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rRxkvsuynKZiwELP/GsBJcCIronelnOLN9PEF7ZShxA=;
 b=Gx46oFSUc+A42LNCUfVCwm7MwYLaibfVkqCywb/YBr7xDqyhbmj+lMcoubxGtm6eiJtJ/jBosEf/wV5gTUnSMTbcs7Pqg87IW3//3krWOVJX8uJTmUWohWv4mj8+mjP6lDHbjs0AscWAXsdWdC27NqHWJfA3jTvstlDQuqTUdf9xrcGFzk7R6MU//+v2omXJkPaQimpNRLx7iX5dgxPndKk4Zfe3+ejRyUIVbwsnaSTM+HAEWD806CEnk6Njm3j/HvK6+q896svMkuNZC/8svuyQ4yGh4uFsLpf5EAtk34gOZ3vIaOkb07R+5EaWSKay01hbWi4P+jKaMXIeIthNAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB4810.namprd12.prod.outlook.com (2603:10b6:5:1f7::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3564.25; Mon, 16 Nov
 2020 20:16:19 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::e40c:730c:156c:2ef9]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::e40c:730c:156c:2ef9%7]) with mapi id 15.20.3564.028; Mon, 16 Nov 2020
 20:16:19 +0000
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     <linux-rdma@vger.kernel.org>
Subject: [PATCH 2/4] verbs: Simplify the logic assigning vid in ibv_resolve_eth_l2_from_gid()
Date:   Mon, 16 Nov 2020 16:16:14 -0400
Message-ID: <2-v1-f03f70229014+144-fix_lto_jgg@nvidia.com>
In-Reply-To: <0-v1-f03f70229014+144-fix_lto_jgg@nvidia.com>
References: 
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: MN2PR12CA0006.namprd12.prod.outlook.com
 (2603:10b6:208:a8::19) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (156.34.48.30) by MN2PR12CA0006.namprd12.prod.outlook.com (2603:10b6:208:a8::19) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3564.25 via Frontend Transport; Mon, 16 Nov 2020 20:16:17 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1kekvA-006kmB-MH     for linux-rdma@vger.kernel.org; Mon, 16 Nov 2020 16:16:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1605557771; bh=KMbAfhl+V28GcZdSXt21UbDtqtAbXOHsI6cC0ckh0N0=;
        h=ARC-Seal:ARC-Message-Signature:ARC-Authentication-Results:From:To:
         Subject:Date:Message-ID:In-Reply-To:References:
         Content-Transfer-Encoding:Content-Type:X-ClientProxiedBy:
         MIME-Version:X-MS-Exchange-MessageSentRepresentingType;
        b=X0GPQ7NtPnJY/4CefsmyzfyRyfOgGAu3nduLfzXdzhNAUggaEk3PAYTZV30aAQiN2
         gTCZ5qUTXv3Nb+XHz+Bvfn/IhesoU/aVzIeQhJzQjcfBWIcK8ySfzuexlGtQWTztBs
         MRg9XgCZ4CbS+mB74mtURQHLOeQ5BQSiukAa993FCpQW1LdEZSGYeRfCdcv/ai03rx
         GfezeD/Qp/ztC5a4FA3wvtFXvt1j16zdvg1QA564byClnvR9V459wnI4jTWLhlSW6O
         YFRbIzMLjoTFlfeSaukmRGXLMYvu/HkqsYYANfaSYbZ2fenCjosqHOYNPnoZoNmeLy
         oUgwflPG556yQ==
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

gcc 10 with LTO reports:

../libibverbs/verbs.c:1040:8: error: 'ret_vid' may be used uninitialized in=
 this function [-Werror=3Dmaybe-uninitialized]
 1040 |   *vid =3D ret_vid;

Which seems like a compiler bug as there is obviously no way for this to
be true, nor is it clear how LTO has any impact here since
neigh_get_vlan_id_from_dev() always returns a defined value.

Nevertheless, the logic is tortured, so simplify it by combining
everything into one if.

Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 libibverbs/verbs.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/libibverbs/verbs.c b/libibverbs/verbs.c
index 7fc10240cf9def..2b0ede84e8d635 100644
--- a/libibverbs/verbs.c
+++ b/libibverbs/verbs.c
@@ -973,7 +973,6 @@ int ibv_resolve_eth_l2_from_gid(struct ibv_context *con=
text,
 	int ether_len;
 	struct peer_address src;
 	struct peer_address dst;
-	uint16_t ret_vid;
 	int ret =3D -EINVAL;
 	int err;
=20
@@ -1022,10 +1021,11 @@ int ibv_resolve_eth_l2_from_gid(struct ibv_context =
*context,
 		goto free_resources;
=20
 	if (vid) {
-		ret_vid =3D neigh_get_vlan_id_from_dev(&neigh_handler);
+		uint16_t ret_vid =3D neigh_get_vlan_id_from_dev(&neigh_handler);
=20
 		if (ret_vid <=3D 0xfff)
 			neigh_set_vlan_id(&neigh_handler, ret_vid);
+		*vid =3D ret_vid;
 	}
=20
 	/* We are using only Ethernet here */
@@ -1036,9 +1036,6 @@ int ibv_resolve_eth_l2_from_gid(struct ibv_context *c=
ontext,
 	if (ether_len <=3D 0)
 		goto free_resources;
=20
-	if (vid)
-		*vid =3D ret_vid;
-
 	ret =3D 0;
=20
 free_resources:
--=20
2.29.2

