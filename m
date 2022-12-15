Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 719A764DDD7
	for <lists+linux-rdma@lfdr.de>; Thu, 15 Dec 2022 16:32:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229603AbiLOPck (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 15 Dec 2022 10:32:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229737AbiLOPcj (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 15 Dec 2022 10:32:39 -0500
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2075.outbound.protection.outlook.com [40.107.101.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4C4527936
        for <linux-rdma@vger.kernel.org>; Thu, 15 Dec 2022 07:32:37 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZUZEAwP5i8QzbMjC/j7dQKJh1sKGvcOQGa3E7Gn5+/lLcyalado8E8NK+twRIUwOK4F/zgoa1kliB/wtw0aPNrHngoD/nPlcVIiYYSfmmRMcmOvo2WEIz2yxPg84AZWLWxDItgzIsB5W+rcRryblsNioLogKuy15w/n+U55db8LCtzlVcPQM608pv/U3E4W9OIymSwDO1GN6OBg7YY8Q2pPAdRUq3ai4gE0mEl420m+AuKEiEhPhGRg8o9BoxZTVHH8+5sgzM4yQrwjD4zADEj3bIrF3dFCEbA4MwwaJyf20TKLyXXO1FqJ4Gjr/JXohXKYQ3FDap5/LGy9YJ83S0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kMbAMFqOEjRUX6H/w5wNWWyIatEfBfSmC1MIpm7Euc8=;
 b=SAF3YMKxC8UKZWLONdfH3NL5nOpanDPNzUY6DEyvymgHtFRC4P2JyHU//raSFgE5Bxbzjly8sKBggRBbSqS4OwWuOcseJ+XTQBjxEMzFeesP9/ev8IZZrvOnYtTMKU5kSdOBB8D6GADx6LJI7gWfbg/3M1iaasmyE5IoCEucw6BRPW79Nr2eU61IWQo5zHc26RynWaNn/sBMFntCYid2O8p2xC6eLzJXHdjGpOT5KE6UqiYp6gICfKn3M4HV6o9nblWpy5ARj4tQ5H/jv4EgESBuLlzYGZ0KXJBnkUlaqN2PvgjuloYVU0H4wU6NCqxXE43OnZLAJj9+GsHD49vH7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kMbAMFqOEjRUX6H/w5wNWWyIatEfBfSmC1MIpm7Euc8=;
 b=UYMlOA70J80jmfuwX9o1SLdx3kweTw9Sku2ev7XkFh4GP/ea5ubovlUlQF1o8wcI4C4y4Z+c+EINXpZSHCOZnB2ZUfHkGD668z8w3W1gxfVc//p0Q/8DPcbcRpUK6URbVl5mHOjJQwxw3PomZxAdKYRUa1Q3YkkFPD7SrwHXKhkcielQiFRAhET9w+sH0QkrPAnbD+fmTDbBcDZ2RBQWv0JkAsXFJb4Cf68jO8KE7Wriem7JBnJ87wKCVfm8T8Rs2yRmh4n3o/BhPbJkFYS0TdwGAmoLGgyEG2rMhpaCTUhtQqTk8bfQxmgFiLsE3Ux/XRSbAlD4NjWObkPvjpRiZQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by CY8PR12MB8215.namprd12.prod.outlook.com (2603:10b6:930:77::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5924.11; Thu, 15 Dec
 2022 15:32:34 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f8b0:df13:5f8d:12a]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f8b0:df13:5f8d:12a%8]) with mapi id 15.20.5880.019; Thu, 15 Dec 2022
 15:32:34 +0000
Date:   Thu, 15 Dec 2022 11:32:33 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Xiao Yang <yangx.jy@fujitsu.com>, linux-rdma@vger.kernel.org,
        rpearsonhpe@gmail.com, leon@kernel.org, lizhijian@fujitsu.com,
        y-goto@fujitsu.com, zyjzyj2000@gmail.com
Subject: Re: [PATCH v7 6/8] RDMA/rxe: Make responder support atomic write on
 RC service
Message-ID: <Y5s+EVE7eLWQqOwv@nvidia.com>
References: <1669905568-62-1-git-send-email-yangx.jy@fujitsu.com>
 <1669905568-62-2-git-send-email-yangx.jy@fujitsu.com>
 <20221215151924.GA2574647@roeck-us.net>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221215151924.GA2574647@roeck-us.net>
X-ClientProxiedBy: BL1PR13CA0448.namprd13.prod.outlook.com
 (2603:10b6:208:2c3::33) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|CY8PR12MB8215:EE_
X-MS-Office365-Filtering-Correlation-Id: 0fa82b99-0a7e-4e48-06b2-08dadeb196cf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NMbwITQn1rrodsfNQYDCsAY/ULUhGVEPHVQ5P35i//7dD8eArE2vw5BfPTVixuedb3fuFEiM7ASkhxcSV0lxDrpH5+sd71QNDgVnHRTsRI2xj5e7B/zLRgZqYaMB6ogXVJdC5Zl7aDEoMbFTZ8D6nyaU7PzmWMkTHBG9ZqBL41nvq5R4HNw/rv2w3hW227tSFRyqx3M5MYopfJ7nRvKjLA5DI4fhmA3nb+x9mUVxthcWiw6dVhF/LYDv3FLxaxHu1MYchDg4RRtac0Xor+BsKJ7fHbEf13BjWYcZ0xV/c79JKMlhNTpDB+W8hsUKJSz/+2ZHXC7ueZ28gtiKkLcQ1NLYoJ1BSv8Ed+sPRm3WiHUjj21MT6iPlpcEgOrC/oFdDn74rUlFXgMRjdKmOgY6kgFR2H9oxa+/sTIjMEW7RqWVt0go/kmnkTZiJhj6y12NIAvS+Mb1lUcJQWhpAh9z5GSCzNn8cI4xRt0GDqXIkxYysZ7RsBpaCyf+s0qQ1QgPQX18gkwbfXDY19y/7Y/UDFHh5F0zPGV8S6mh2nxECl7LHqr6wsA3omNweZHXGhTHRttayQl/KcTvQfbtXvA80F3y6LjNJuuEoAF7gXiXRG9T+kKHTuyppuAJdZv+CVjPoxpI3z/v+9S/FjuOuAEuPmZ/crXIgjQ4N6Ol8LeF4Lwg40pDFu3NRUXb9mUPFlqx
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(39860400002)(396003)(366004)(376002)(136003)(451199015)(2616005)(83380400001)(38100700002)(86362001)(5660300002)(2906002)(8936002)(4326008)(41300700001)(26005)(6512007)(6486002)(53546011)(478600001)(66946007)(66476007)(8676002)(45080400002)(66556008)(6506007)(6916009)(186003)(316002)(36756003)(67856001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?pH/ulrzHdQ2rR1FWHWesr2yMSiNMcVEz0IYcENJ1CCQ5gjnnRYEyBsok77lc?=
 =?us-ascii?Q?mTl2jMsYr9IN/mBmtH4Bnd1EsaNmM2MfqMKer462PwB6aZ3XVSowGNmGZdqt?=
 =?us-ascii?Q?BGH3BmGnADEXtWeB0UJCWyZYttD1CQX5e6iLvAnORXeYIR0cj8ew4ok0I1pN?=
 =?us-ascii?Q?kBpsBGMy59+ONbd4Bo49cfGB3Chf7POldjwyPuqSobJP+arAD+zKMaNu+ct6?=
 =?us-ascii?Q?aDoK2CmXq2a21EvP19lv1ZU53qcIttFYI+BeWGUyivr4p4x9wm7hB8rCpdHe?=
 =?us-ascii?Q?U12gozieMmOB2+vjkqiQ0QjsxibcaRmdwJsOF0YBoD1eAJRglBKFWUtfQZVX?=
 =?us-ascii?Q?/VPz1/OAHjfX7XUoG+f1P6iJ8MIJzrW6qowojuMDJdoqwR5Kn/GWpZaKunoQ?=
 =?us-ascii?Q?Z2KZ88C2X+2fm3AiqLndoy4WZno+JT1ZGJwCcODwiX0ZqJBOvJDquP+G0G6o?=
 =?us-ascii?Q?Olm1ZIf02Wsen3bkle6hKwiZybAJZk0eKa+pwdkObv9cgUoxowPrJ+4pq653?=
 =?us-ascii?Q?ab2iymNyjNS92hX5AahnsJmMSC85YuIYaiIv/SGbCy+MP9LrwJZVU0/wLAOk?=
 =?us-ascii?Q?w89FJPIZ2Y69CqXdwCRsB6z3b+6RRH+5jHke/phYKLn2P0f50wluTS5ZywGA?=
 =?us-ascii?Q?YO+pcnBcC1YLOgpEvoM9NLGs/hCO+RejSzmcQhhU+dUluzlWS4itr8z353Ic?=
 =?us-ascii?Q?nitYFxvxfeol713lAxw9vShaBjp8fHg0jOuoesx14igePFjalrhmDtfk0nTP?=
 =?us-ascii?Q?jzjOJltsvNkrKvLc5A/DajHI1D/hn5dBTqbIzZca57/WtPHB1X9AYUP21Elk?=
 =?us-ascii?Q?mWN0mRo0EE628CwQAVCAg2+e1gwhXAy3qRheYkDs0CnVOX0T/CO6JMKR33JS?=
 =?us-ascii?Q?rR8kOjSnWGio7CTO5780cf5k7vCngZEx3CjOlD6nm89W+NQ5sQFGDgMtnBjh?=
 =?us-ascii?Q?TuAEBjrxAoU3t7iYG8RFLITZREY9htWcYya2VjENMSJHKDvYKbEdBav2jUiQ?=
 =?us-ascii?Q?vt06WxeVZCT/xjNqGKvbzPJ+5jrvMukmXk2lIj4N/nEB/LdOfK6+U8UrK6/3?=
 =?us-ascii?Q?GtUlFEIYWGrTEkuCthZ3Umusaga52+Nonj3RnafK46tUA7IBkyhiKVal36LA?=
 =?us-ascii?Q?0XoOSynGJ9Mb361oBMh37EwpcLl+9X2Ag28S73SnbLwP293ozGImduN7KFy1?=
 =?us-ascii?Q?WQ/ASnCAZpuKfLkUDVBQGrmc+9zx0KQ4OXMmuAGwWAp1x0JWGEmTmSm15Oku?=
 =?us-ascii?Q?w06I0Vxq9ZR3vwzz+13Xb3heKRyVGb80HlaDJ6lT6zH1E4+4Qx5QKaUiS8kv?=
 =?us-ascii?Q?K3j6uTb4goNb5P0+hPMlg9gXpXfuC9C893QAW5CXFA2eOJL2upMLpUXGXUZf?=
 =?us-ascii?Q?xp8fLik6ad6CoYcjq2CrWtAdxstNvFDBrU5+3gsuz4V97jsqbGWkF1eGof3k?=
 =?us-ascii?Q?E5TuIp3vpPW+yf0KpI7qOMr1P5tsCDJLEA8WIWhtiPF99KeBZNb9STcKOw9y?=
 =?us-ascii?Q?VgYRRl8+ppbotdvHDFxQdW5Fwo9Z/HoPAdrBiFBA0VAKJEjpBYc6EzIiZdVy?=
 =?us-ascii?Q?hYLMt5e74gqcrYtp7/OIn64EvvxtLJ9QFS3/40+g?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0fa82b99-0a7e-4e48-06b2-08dadeb196cf
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Dec 2022 15:32:34.8480
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 41VXi0pK5+YzI3iiG/L3FTXWgodKMiVWR8FA2CApI9OA3uMwLYku75ZbBaQFVcmo
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8215
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Dec 15, 2022 at 07:19:24AM -0800, Guenter Roeck wrote:
> On Thu, Dec 01, 2022 at 02:39:26PM +0000, Xiao Yang wrote:
> > Make responder process an atomic write request and send a read response
> > on RC service.
> > 
> > Signed-off-by: Xiao Yang <yangx.jy@fujitsu.com>
> > ---
> 
> On all 32-bit builds with CONFIG_WERROR enabled:

Why are we only just seeing this now? It has been in linux-next for
long enough?

From 7e708569f7bb5dba6df8342bc2402deda4e2414e Mon Sep 17 00:00:00 2001
From: Jason Gunthorpe <jgg@nvidia.com>
Date: Thu, 15 Dec 2022 11:29:25 -0400
Subject: [PATCH] RDMA/rxe: Fix compile warnings on 32-bit

Move the conditional code into a function, with two varients so it is
harder to make these kinds of mistakes.

 drivers/infiniband/sw/rxe/rxe_resp.c: In function 'atomic_write_reply':
 drivers/infiniband/sw/rxe/rxe_resp.c:794:13: error: unused variable 'payload' [-Werror=unused-variable]
   794 |         int payload = payload_size(pkt);
       |             ^~~~~~~
 drivers/infiniband/sw/rxe/rxe_resp.c:793:24: error: unused variable 'mr' [-Werror=unused-variable]
   793 |         struct rxe_mr *mr = qp->resp.mr;
       |                        ^~
 drivers/infiniband/sw/rxe/rxe_resp.c:791:19: error: unused variable 'dst' [-Werror=unused-variable]
   791 |         u64 src, *dst;
       |                   ^~~
 drivers/infiniband/sw/rxe/rxe_resp.c:791:13: error: unused variable 'src' [-Werror=unused-variable]
   791 |         u64 src, *dst;

Fixes: 034e285f8b99 ("RDMA/rxe: Make responder support atomic write on RC service")
Reported-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/infiniband/sw/rxe/rxe_resp.c | 72 +++++++++++++++-------------
 1 file changed, 40 insertions(+), 32 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_resp.c b/drivers/infiniband/sw/rxe/rxe_resp.c
index 7a60c7709da045..c74972244f08f5 100644
--- a/drivers/infiniband/sw/rxe/rxe_resp.c
+++ b/drivers/infiniband/sw/rxe/rxe_resp.c
@@ -785,53 +785,61 @@ static enum resp_states atomic_reply(struct rxe_qp *qp,
 	return ret;
 }
 
-static enum resp_states atomic_write_reply(struct rxe_qp *qp,
-						struct rxe_pkt_info *pkt)
+#ifdef CONFIG_64BIT
+static enum resp_states do_atomic_write(struct rxe_qp *qp,
+					struct rxe_pkt_info *pkt)
 {
-	u64 src, *dst;
-	struct resp_res *res = qp->resp.res;
 	struct rxe_mr *mr = qp->resp.mr;
 	int payload = payload_size(pkt);
+	u64 src, *dst;
 
-	if (!res) {
-		res = rxe_prepare_res(qp, pkt, RXE_ATOMIC_WRITE_MASK);
-		qp->resp.res = res;
-	}
-
-	if (!res->replay) {
-#ifdef CONFIG_64BIT
-		if (mr->state != RXE_MR_STATE_VALID)
-			return RESPST_ERR_RKEY_VIOLATION;
-
-		memcpy(&src, payload_addr(pkt), payload);
+	if (mr->state != RXE_MR_STATE_VALID)
+		return RESPST_ERR_RKEY_VIOLATION;
 
-		dst = iova_to_vaddr(mr, qp->resp.va + qp->resp.offset, payload);
-		/* check vaddr is 8 bytes aligned. */
-		if (!dst || (uintptr_t)dst & 7)
-			return RESPST_ERR_MISALIGNED_ATOMIC;
+	memcpy(&src, payload_addr(pkt), payload);
 
-		/* Do atomic write after all prior operations have completed */
-		smp_store_release(dst, src);
+	dst = iova_to_vaddr(mr, qp->resp.va + qp->resp.offset, payload);
+	/* check vaddr is 8 bytes aligned. */
+	if (!dst || (uintptr_t)dst & 7)
+		return RESPST_ERR_MISALIGNED_ATOMIC;
 
-		/* decrease resp.resid to zero */
-		qp->resp.resid -= sizeof(payload);
+	/* Do atomic write after all prior operations have completed */
+	smp_store_release(dst, src);
 
-		qp->resp.msn++;
+	/* decrease resp.resid to zero */
+	qp->resp.resid -= sizeof(payload);
 
-		/* next expected psn, read handles this separately */
-		qp->resp.psn = (pkt->psn + 1) & BTH_PSN_MASK;
-		qp->resp.ack_psn = qp->resp.psn;
+	qp->resp.msn++;
 
-		qp->resp.opcode = pkt->opcode;
-		qp->resp.status = IB_WC_SUCCESS;
+	/* next expected psn, read handles this separately */
+	qp->resp.psn = (pkt->psn + 1) & BTH_PSN_MASK;
+	qp->resp.ack_psn = qp->resp.psn;
 
-		return RESPST_ACKNOWLEDGE;
+	qp->resp.opcode = pkt->opcode;
+	qp->resp.status = IB_WC_SUCCESS;
+	return RESPST_ACKNOWLEDGE;
+}
 #else
-		return RESPST_ERR_UNSUPPORTED_OPCODE;
+static enum resp_states do_atomic_write(struct rxe_qp *qp,
+					struct rxe_pkt_info *pkt)
+{
+	return RESPST_ERR_UNSUPPORTED_OPCODE;
+}
 #endif /* CONFIG_64BIT */
+
+static enum resp_states atomic_write_reply(struct rxe_qp *qp,
+					   struct rxe_pkt_info *pkt)
+{
+	struct resp_res *res = qp->resp.res;
+
+	if (!res) {
+		res = rxe_prepare_res(qp, pkt, RXE_ATOMIC_WRITE_MASK);
+		qp->resp.res = res;
 	}
 
-	return RESPST_ACKNOWLEDGE;
+	if (res->replay)
+		return RESPST_ACKNOWLEDGE;
+	return do_atomic_write(qp, pkt);
 }
 
 static struct sk_buff *prepare_ack_packet(struct rxe_qp *qp,
-- 
2.38.2

