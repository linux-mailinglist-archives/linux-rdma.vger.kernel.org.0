Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36CD164A898
	for <lists+linux-rdma@lfdr.de>; Mon, 12 Dec 2022 21:17:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233535AbiLLUQS (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 12 Dec 2022 15:16:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233542AbiLLUPv (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 12 Dec 2022 15:15:51 -0500
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49E88123
        for <linux-rdma@vger.kernel.org>; Mon, 12 Dec 2022 12:15:49 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Dk+KOijMlqDykFEIOX2RDCUFe3dB0a7l2VyjVYgmJxH2qLGS0Pwj8Uk+8ewL+cqytDOLRjUOF6VzxkdFiRhPFFo5CQwNVE1gfSCkg91y0Pdqyb7u7pX90ncybgSmrYo0cDpkUOyR5LUvfwdd5VOizhKjBrzLCG/JT/shWraZ84CTRP8bEEVLsuiuzKDil6gm6eK1crva1HM5dATNJzSPkLnqqVv1tuWwaYOfTOSPOjbJRFJQBJI+SEjiudtwB3giJ6oySeAtiPhVpE6+Vh2Ao2P8kKWSu7Be/QnRZspNbV8zyAyz63GU6LwJST0we2aX6wgq8EzzLwupAzHhIbZzYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6HUkHb5Xt+GIylaU4W999Y+Ss4MxwH2CB5SEQfVS6oI=;
 b=Qw7ghYv4s0I06mDzGsy2C4rP0kVJiANj9O88HxCEV2ZQ+GCQR+prj5Ut4NxEHcK4ST1uplp1AKKyBPQwk7p87tckDLdxkau8a7Sccx4PyvZpwiQHvKhusAPsUIsFSY+WPccxusl8Sr3b7JddF3nzWaf1Y1I63IMICHlaUxxTuznla3BadiBHls5vM64Y30k5QurL7IeJhOLK1wM3IBD+US4qzlH8ExlQYRh10idkOi9F0q5y5fQm6xL9aXL679axHec+w8xzaAEbYMEYE8dZKY8orrIPM4Nmuu0qwhXnSA1WBnyvwOAUhZOtFjsXgtPQWkUspiRn7ClhjAycAH49NQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6HUkHb5Xt+GIylaU4W999Y+Ss4MxwH2CB5SEQfVS6oI=;
 b=VVAOgpJf9zq4qJPW2BA2iXfKsso2+RW+HY9I1xatbyB1HB1Ojll1mFwRW/OuszBjWczwgBrOOOqv9R0Z/PfzElww9LPF9N+WRyDJtI8QC7XKq11izvK9Yfzpo218+4hj6KtxhGu9pq6KTBi5aPAv4Rx5bo2uIGBvXy45js3CcYcputd2rES+FRRrULcR+hkvG9xDqF7D8bBpuVltOYVUryGezL2r8vIzOP+GVO/6g8TIkQyNgBRYl9vtXRyWLNwP8LdL/im5PmWduU7leDPuonmY3xSBUNs0fkkN0jFjKb8HZuzyQ127XjNF52u8XSKLejcfUI6d31vUrPWUYCKKvQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by DM4PR12MB7621.namprd12.prod.outlook.com (2603:10b6:8:10a::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.19; Mon, 12 Dec
 2022 20:15:47 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f8b0:df13:5f8d:12a]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f8b0:df13:5f8d:12a%8]) with mapi id 15.20.5880.019; Mon, 12 Dec 2022
 20:15:47 +0000
Date:   Mon, 12 Dec 2022 16:15:46 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Patrisious Haddad <phaddad@nvidia.com>
Cc:     Leon Romanovsky <leon@kernel.org>, linux-rdma@vger.kernel.org,
        Maor Gottlieb <maorg@nvidia.com>,
        Wei Chen <harperchen1110@gmail.com>
Subject: Re: [PATCH rdma-next] RDMA/core: Fix resolve_prepare_src error
 cleanup
Message-ID: <Y5eL8h2HCwaOU2xR@nvidia.com>
References: <ec81a9d50462d9b9303966176b17b85f7dfbb96a.1670749660.git.leonro@nvidia.com>
 <Y5csPTRDNOIwf49T@nvidia.com>
 <81008c63-50e0-075a-6795-71ea3d08803c@nvidia.com>
 <Y5cv+z6cYWUV3ara@nvidia.com>
 <1a852181-8b9f-5f30-2c4a-fb3cb79802af@nvidia.com>
 <Y5cz4hYrK8EqgN0h@nvidia.com>
 <486d8fe0-96ff-a670-7bf5-be04cafbaedf@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <486d8fe0-96ff-a670-7bf5-be04cafbaedf@nvidia.com>
X-ClientProxiedBy: BL1PR13CA0080.namprd13.prod.outlook.com
 (2603:10b6:208:2b8::25) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|DM4PR12MB7621:EE_
X-MS-Office365-Filtering-Correlation-Id: 0600d419-9b25-43da-14d4-08dadc7da7f4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PJKXsU4TdF0rdEfM2OTBihYCA1S1QyOrviRMB1daHxFZy05wYPxO094s2wroFLQ/fwusXcBANFstGilXRb4bEaP5W0L1Tynjga5JlVnyIzu7R75GuaQ8Lvf4Og8liVG5w28zyHpv2PbQG6oRNG8GtLZ69fO+VI73DKuarxKWedHISXEq1CphjfAzIB2l8D0EbTzpOFjVwhczj76WVX6onf2zKLLCLxy8uwCmYfLLPNu9u1EsDdc7ehURsvsLg5N1tSCivTGZtRzVGOgWqA+iJ1sK9KGCjp9taPs0UX06JCyHzmc6u08s3zRLgPGSIBynrlWOBaY+mLNjwEznR+AyK5B4jqHME4anAEKKIdg2vV8a2zhA/wVhFz/6UayrJ42rCcDS+cqNzERF6sUl5CdNYeF0ksCJAR100P2olrWc2bDgXB53jvX0ggzaOBKT7/KxQVGpzVryn8T5/eZpaheh0y58LcQakLGNQ/4L5vGSau2j8A94K5UDy6NVNg1sp+UnTYEWIaE1bBcygiU/phukZof94FN8YCapLMYSRY0+cjhpoLEQzXsyU7TaDZ+JcpZGAzgdsQH97GVu4v9VZ6WtIjiSWA32F5juhCHbJYmaYb7P/xEgveLwmUNAl3wptlQKjzKMzAzxQcxAsldLsAqGXw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(366004)(346002)(136003)(396003)(39860400002)(451199015)(83380400001)(6486002)(38100700002)(5660300002)(66946007)(36756003)(86362001)(478600001)(2616005)(6512007)(6862004)(186003)(8936002)(41300700001)(6506007)(66476007)(8676002)(4326008)(66556008)(37006003)(26005)(316002)(54906003)(2906002)(6636002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?eHjQJqTp9wpEw+C0Ey37Shv0KdjVrlxppFkSgzhw8o4TUa+jd9ROrPAzqGwq?=
 =?us-ascii?Q?tw8fifJHLEFcqDxmBhQw1DtNAvB82aDxNZEbPUfC7alCGc5+9dsAEpBcdi1d?=
 =?us-ascii?Q?NFhd4KMNSrv5IZVuCIFlwjrsA+nis67zzIdz5sFe4DeJh9VcxYl7fRBoRBI8?=
 =?us-ascii?Q?7qVg3m3vBe0CVchLhZVrNU26z9QRe6badFMlmgNdm0i9MpZScKg7LELYolw+?=
 =?us-ascii?Q?PTbzcDO309z7ak5hRWZviVftQv4/jEXTTbCBhXC2e7wcqOf9JAyg2ctYumkE?=
 =?us-ascii?Q?2hIKlZ0qpwcLDhI3FT5eFl31DMpypjMgqGHaFmVX3qSA6Ox0JF29s99N/iGn?=
 =?us-ascii?Q?Q1udn/xwvHVJKOjNv93sDNtBsiiyLtUJKJcZ56OGwK0eDPcOcc0D03o0B57Z?=
 =?us-ascii?Q?U9ucGRhipf/mfE9Z6LFgzr/ajiqJoP8n+M+hly9CvNNJRPdMVgey3UMSU4BZ?=
 =?us-ascii?Q?EjxhaAAAfO/oHqFVpTWrticc2yyA84XAQD8f+7vr4GTowIwxsicRINMnvAb9?=
 =?us-ascii?Q?0oe5WyDX+UHkkLJ6aswUO2t85gH+NBOhwXg1+Sus+JlirvT1tCnZzwSkv5cp?=
 =?us-ascii?Q?cCjeNakLjohSp9SFVrFOD94qOpr57vcW/33ZG52McminUdXDDMN+SATuBdAC?=
 =?us-ascii?Q?tLtalheht/NuuGG1gKcBLpt0POj71t7nDxhbGpn3LQMG77+8LjadUrEqh9w9?=
 =?us-ascii?Q?XFfewkEcwgwurEG4SH3nga4Z3RVIMxVJiu/6CJScbW7gr8ReeawKH3gODQqJ?=
 =?us-ascii?Q?cbzz8qBe2nn805yMn8d7s8Gw3N5BzxvvEORuVARAJmbYjVpocp2E3uWbwWyA?=
 =?us-ascii?Q?j49m2y/P2AUOQIARJatCbyReTnNwl/NsrOtWgq29l1NBd+ygAAo/BZrAo5iE?=
 =?us-ascii?Q?Ybr2I0tc3s2IDVmYvCQ31NrKnEXWxs6jyWEtHtIb9ZoSOyfyabEXKgdp7QIi?=
 =?us-ascii?Q?tXme6AsHPK9xspDfS4zcroHAbIWWziWwRX4E080ldA5PmKdQR4qenRJHTYX8?=
 =?us-ascii?Q?oDRUSNXQ0d6eI1fIobk6Oi4822No1bwgxheSamChR5VJGSSxmB/GFRe3pphf?=
 =?us-ascii?Q?xXPxld5FUjXDKaxYPv54bihvJaeIObuQcGbDe0R27cQKPXYqLwXCJ1yOH5hx?=
 =?us-ascii?Q?hhE0T7P614/vpIF/Y2FMFe4vQwe4fohcYXcfvuekECtINu79D9NGVSfyBAA/?=
 =?us-ascii?Q?mW2XYuFxZb43ImXgPKSH9kR/nEelgTq7Z4fuNwi7tY8VRCKIB1+Pqjwn0cmd?=
 =?us-ascii?Q?tBd8FqeXGAPNEGcdN/hCc0XxPx9RD3KOYgIVsnrhk8+DqTw+JLt/udDzEurP?=
 =?us-ascii?Q?+fUGXB6iZuJO2AfCt769od6b0LJVasWLp6Ww/qkOgDxichqTmaJitOPyPxJq?=
 =?us-ascii?Q?i3JnutjLQBJeAmpNJ9aWCdGtK1zQD90oEjbLE1gPXKak9mIBQJNtUKd+4TKg?=
 =?us-ascii?Q?E+8XexanwAGD3Nx73zY5dmidXPtHryMW9Mg+ptnxOqKM7smcQyjqoqbTXnS3?=
 =?us-ascii?Q?7hVel8orxHVaIPv0kVpPYyUequevbiRnu3E2bdwwKHkarnq6kiT/F3Y9C4OI?=
 =?us-ascii?Q?FO4Zpc8Q/kEtk+N1kFYmUrwHhpltSP5RpYyDN0ti?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0600d419-9b25-43da-14d4-08dadc7da7f4
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Dec 2022 20:15:47.4722
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 83DX8xKoLhq4a6iVjUkRRpRGMH0uC/YNmYrtXOwj+ESqEQaIOEpubGiQdj0v9Ple
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7621
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Dec 12, 2022 at 04:06:03PM +0200, Patrisious Haddad wrote:
> Btw there is the easy ugly fix obviously, which would be this patch +
> locking this function with the tree spin-lock(to avoid any race).
> 
> I'll check however if there is hope for a better possible design for this
> function.

The usual way I've fixed this is to avoid touching, in this case,
cma_dst_addr() in the call chain. eg we already pass in the correct
dst_addr

What you've done is made it so that in RDMA_CM_ROUTE_QUERY and beyond
the CM id's dst cannot change. The trick with this nasty code is that
it is trying to trigger auto-bind, and it has to do it blind because
of bad code structure

So, try something like this:

diff --git a/drivers/infiniband/core/cma.c b/drivers/infiniband/core/cma.c
index 13e0ab785baa24..1d1f9cd01dd38f 100644
--- a/drivers/infiniband/core/cma.c
+++ b/drivers/infiniband/core/cma.c
@@ -3547,7 +3547,7 @@ static int cma_bind_addr(struct rdma_cm_id *id, struct sockaddr *src_addr,
 	struct sockaddr_storage zero_sock = {};
 
 	if (src_addr && src_addr->sa_family)
-		return rdma_bind_addr(id, src_addr);
+		return rdma_bind_addr_dst(id, src_addr, dst_addr);
 
 	/*
 	 * When the src_addr is not specified, automatically supply an any addr
@@ -3567,7 +3567,7 @@ static int cma_bind_addr(struct rdma_cm_id *id, struct sockaddr *src_addr,
 		((struct sockaddr_ib *)&zero_sock)->sib_pkey =
 			((struct sockaddr_ib *)dst_addr)->sib_pkey;
 	}
-	return rdma_bind_addr(id, (struct sockaddr *)&zero_sock);
+	return rdma_bind_addr_dst(id, (struct sockaddr *)&zero_sock, dst_addr);
 }
 
 /*
@@ -3582,17 +3582,14 @@ static int resolve_prepare_src(struct rdma_id_private *id_priv,
 {
 	int ret;
 
-	memcpy(cma_dst_addr(id_priv), dst_addr, rdma_addr_size(dst_addr));
 	if (!cma_comp_exch(id_priv, RDMA_CM_ADDR_BOUND, RDMA_CM_ADDR_QUERY)) {
 		/* For a well behaved ULP state will be RDMA_CM_IDLE */
 		ret = cma_bind_addr(&id_priv->id, src_addr, dst_addr);
 		if (ret)
-			goto err_dst;
+			return ret;
 		if (WARN_ON(!cma_comp_exch(id_priv, RDMA_CM_ADDR_BOUND,
-					   RDMA_CM_ADDR_QUERY))) {
-			ret = -EINVAL;
-			goto err_dst;
-		}
+					   RDMA_CM_ADDR_QUERY)))
+			return -EINVAL;
 	}
 
 	if (cma_family(id_priv) != dst_addr->sa_family) {
@@ -3603,8 +3600,6 @@ static int resolve_prepare_src(struct rdma_id_private *id_priv,
 
 err_state:
 	cma_comp_exch(id_priv, RDMA_CM_ADDR_QUERY, RDMA_CM_ADDR_BOUND);
-err_dst:
-	memset(cma_dst_addr(id_priv), 0, rdma_addr_size(dst_addr));
 	return ret;
 }
 
@@ -4058,27 +4053,25 @@ int rdma_listen(struct rdma_cm_id *id, int backlog)
 }
 EXPORT_SYMBOL(rdma_listen);
 
-int rdma_bind_addr(struct rdma_cm_id *id, struct sockaddr *addr)
+static int rdma_bind_addr_dst(struct rdma_id_private *id_priv,
+			      struct sockaddr *addr, struct sockaddr *daddr)
 {
-	struct rdma_id_private *id_priv;
 	int ret;
-	struct sockaddr  *daddr;
 
 	if (addr->sa_family != AF_INET && addr->sa_family != AF_INET6 &&
 	    addr->sa_family != AF_IB)
 		return -EAFNOSUPPORT;
 
-	id_priv = container_of(id, struct rdma_id_private, id);
 	if (!cma_comp_exch(id_priv, RDMA_CM_IDLE, RDMA_CM_ADDR_BOUND))
 		return -EINVAL;
 
-	ret = cma_check_linklocal(&id->route.addr.dev_addr, addr);
+	ret = cma_check_linklocal(&id_priv->id.route.addr.dev_addr, addr);
 	if (ret)
 		goto err1;
 
 	memcpy(cma_src_addr(id_priv), addr, rdma_addr_size(addr));
 	if (!cma_any_addr(addr)) {
-		ret = cma_translate_addr(addr, &id->route.addr.dev_addr);
+		ret = cma_translate_addr(addr, &id_priv->id.route.addr.dev_addr);
 		if (ret)
 			goto err1;
 
@@ -4098,8 +4091,14 @@ int rdma_bind_addr(struct rdma_cm_id *id, struct sockaddr *addr)
 		}
 #endif
 	}
-	daddr = cma_dst_addr(id_priv);
+
+	/*
+	 * FIXME: This seems wrong, we can't just blidnly replace the sa_family
+	 * unless we know the daddr is zero. It will corrupt it.
+	 */
 	daddr->sa_family = addr->sa_family;
+	if (daddr != cma_dst_addr(id_priv))
+		memcpy(cma_dst_addr(id_priv), daddr, rdma_addr_size(addr));
 
 	ret = cma_get_port(id_priv);
 	if (ret)
@@ -4115,6 +4114,14 @@ int rdma_bind_addr(struct rdma_cm_id *id, struct sockaddr *addr)
 	cma_comp_exch(id_priv, RDMA_CM_ADDR_BOUND, RDMA_CM_IDLE);
 	return ret;
 }
+
+int rdma_bind_addr(struct rdma_cm_id *id, struct sockaddr *addr)
+{
+	struct rdma_id_private *id_priv =
+		container_of(id, struct rdma_id_private, id);
+
+	return rdma_bind_addr_dst(id_priv, addr, cma_dst_addr(id_priv));
+}
 EXPORT_SYMBOL(rdma_bind_addr);
 
 static int cma_format_hdr(void *hdr, struct rdma_id_private *id_priv)
