Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 49D0A49FCEE
	for <lists+linux-rdma@lfdr.de>; Fri, 28 Jan 2022 16:35:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349615AbiA1Pfw (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 28 Jan 2022 10:35:52 -0500
Received: from mail-mw2nam10on2048.outbound.protection.outlook.com ([40.107.94.48]:2369
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231994AbiA1Pfv (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 28 Jan 2022 10:35:51 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V/vwkf94losDMus1M8JAqnAs7RMFnMw0fW6AglH6mbUk4jat9c9nLc6Pp1Ls2YC2srtrKPavb6fWhiVN+KRjnumX7KIUgUMHMp0y06T+plxU7PsjFbi4MHMQTDjAZ0bwRd/uucyoR2Vz0U/3lmWtrQUlSZ1lOry6AcDi6jIX8IC3pT1jggulg7/Eoa/URPcmKTe8NUerGlO33BnpXYI6SChIVHqwq6yls1WCx/7K/qRW3XFD4pu9cXuxkRWq3rOceAPQegzWEyrdXIXB+RRaLAdtiVG/d1ZrRZKNe9hDQPKrwMQigWNEgxes0gTLsGmYHHbddyPX9fwIxjw4rJqOiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K9WToRwk4o3UykiOfokvWkTb7dthwKtLH1qypdKycfo=;
 b=EoQVL7JzAycJP+K07xN7VZeKb/XvUpqv/wdrZQDZWIuXbjf5IYgWC+fiDxFV6zQF6At2Xzx7d/7tSpwIa/gF9EN5Bot4zcounN+dGyLaS4gAigJ1oSu1Uxi2iFzNhzfD0oZfUDKd1iFRg4T7z/LSo2OWlBtdf50UyiUyFzvptpKxjummv8QXQL4yCCjNmpcV6xVVJmxcXRu0Oq1v3IO3gtyCIxOpTxCYvGendx1OeWz7o1vIXx3mcR5OW6zdEZKdyELNdGoCrCwdXJnNTALyqp7heCaLEb8Wf2uQc6xlZboSirz0fMgIy22lM65x6gT/G7XJRF+6Kd17+A2gZVmmsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K9WToRwk4o3UykiOfokvWkTb7dthwKtLH1qypdKycfo=;
 b=s8Q/lT2AXzVoUYwBcfQF+10KvbxkGixHFc67FX3Hb3062QK8NUCnt61lgvEwjcWp81aBZcrF6po05EgHyIv4T6675N4ObBXZUpKKDa+71P/ypSq2IZqw1UPFS08/wQ2JHIjCGt6Afr9gXs9qiIIBAbP6v5eEu6BKMwaMyyG2cyCIze7A7l+VDR5d3xgiT9ryb6/tIGQbLK+Vme/QVJvBBM+t+SafjvfcScathCkwR2fSt2yrdElFENg6bJlQhnuZEgDySisi+bigq2K4w4u+dBvDR0sh+K8Kp2ZMHcpU0qMW7UmyhPkMJKEl1ZKBPF+AgdTo70CnYJ5FadUeMfB3MA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
 by CH2PR12MB4135.namprd12.prod.outlook.com (2603:10b6:610:7c::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.17; Fri, 28 Jan
 2022 15:35:50 +0000
Received: from MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::e8f4:9793:da37:1bd3]) by MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::e8f4:9793:da37:1bd3%4]) with mapi id 15.20.4930.020; Fri, 28 Jan 2022
 15:35:50 +0000
Date:   Fri, 28 Jan 2022 11:35:48 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Maor Gottlieb <maorg@nvidia.com>, linux-kernel@vger.kernel.org,
        linux-rdma@vger.kernel.org
Subject: Re: [PATCH rdma-next 1/3] RDMA/cma: Use correct address when leaving
 multicast group
Message-ID: <20220128153548.GA1849166@nvidia.com>
References: <cover.1642491047.git.leonro@nvidia.com>
 <913bc6783fd7a95fe71ad9454e01653ee6fb4a9a.1642491047.git.leonro@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <913bc6783fd7a95fe71ad9454e01653ee6fb4a9a.1642491047.git.leonro@nvidia.com>
X-ClientProxiedBy: BL1P221CA0021.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:208:2c5::17) To MN2PR12MB4192.namprd12.prod.outlook.com
 (2603:10b6:208:1d5::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2e5b4bef-96a0-4220-f4b9-08d9e273dc79
X-MS-TrafficTypeDiagnostic: CH2PR12MB4135:EE_
X-Microsoft-Antispam-PRVS: <CH2PR12MB4135A647557053B2B49ADE3EC2229@CH2PR12MB4135.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1923;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: y3I2UOd5w1A+DePNGN6ASjMSD+V1vuqOFpvTcI+z5QuxfxGZDRwPD7hZA8tpVM9zm04Cd+5n754ScwoZBSuyT6BXHEdw5eR6DHJ+cyhDSvfZi4cEcfJWqXzrvS8XqVmUDale5L3eP60pfe2PnJKu6VtgkB/X3w/jhQfZU3c61KJ+OAljeOF2aLYWfe31tJ4VJquhizLbfRiUJAPM156Z8Kc7omeacqnk2mKr3MfPaYvBBMjjEzN6rS2uH/sJ0TkuxEK5VCraBmGOefQPRQdcUJ9seCQL4qcHCVCxk3/8SaLZPJp3rc3iji3JztHzFIfTMAnmq/i6TZLmc4pst9ylYPyw02pxQ0uDgrFYB0/mjr4shNkrfBGNn7UIFUVEiZGLHjnVaMN73N4HdTjr/Rc0o47Cqx4x0ObtNOWpG3TgX+9WSW/Quy4qovfu/u5zAAzqNBVxxF3jP5Td03jjaHvJH+cweZB0lmNM3XbAuOs2V1cMYoskUV9OQnWyE5QtsOiMXQIRx6KnvwkLBSZVcGMhHF93prlIZqrcHxlmSFWy0vg4mxLjX36VnAZZ05X/UsyILudS7Jfgtx6/4kdkwF5hfuAjG/89eSx0ABTlHGgxCAcDJohHuGvsIn6Eo4qMb8L2JlnDwfTH60jKdeqDQT9k4w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4192.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(316002)(6916009)(2616005)(186003)(1076003)(6486002)(26005)(508600001)(5660300002)(6512007)(66476007)(66556008)(8676002)(8936002)(66946007)(4326008)(6506007)(86362001)(36756003)(38100700002)(33656002)(2906002)(83380400001)(20210929001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?sIrLVRdlMWMUU8tVyz/tayW3Dhx9c3DtsBU1//2BTN8LiCFxf42jTDq6czm8?=
 =?us-ascii?Q?SkQoKYujS+9z41zBv+zqx8egzGniq73rkgAx4ZDa8FVpw7AAPjVqDQfIUx9X?=
 =?us-ascii?Q?NohOjUR+gWcXOOoZWz1cMfkwYKei1lveLTxnro34Vz0wbGGgsENNl3iR1mag?=
 =?us-ascii?Q?V4UAPuMCxmseD9U0TYoiIWvalP2+OhePNbZ2ATwBkGPBhIcuVitttLo0zHnV?=
 =?us-ascii?Q?nA/AvD8PDhE7dNMcOU4ySM0TXPxOCw6tQhbj3lVzaK6PvNABfEde6jVan8U0?=
 =?us-ascii?Q?W7Wy5X4DEJby/bDdLgaX5vJWHEj/HmMAM2WAMsyOf8tL1M2FeHv7AXsucgci?=
 =?us-ascii?Q?h9f5n5jUh/dOfr5O5TsUY/v0dHzDmA063qDXyRyGDfl0r8Xh4BH1/ZoPS6tJ?=
 =?us-ascii?Q?oyCvslZ3Ckme8xei2yzcyCQC57UAXvfp/Wr4uB/J71WJBvPTxnTxdAang9CI?=
 =?us-ascii?Q?NPR098mRdBdomvzjrbIsKv/T43VdLZWnFJBIGugh5ZYpqJ2i5f9sNgQK9p0R?=
 =?us-ascii?Q?ZnDOfjA6KIvrQsMX8e7GNleHg1BjxM/EyTeQA94RJP/VAQ4tyQfGJykdpvT7?=
 =?us-ascii?Q?MhXTfqXNQZedE2SzNRJ6kiYrMAfhIg01TLlNcRVsBwrb2/MA9kZ0wZTtAiEX?=
 =?us-ascii?Q?nHIXq1PwhLDe/DYz314jp5Hzkdx1C3sxnY/VUnlfUtB9eRspmD4v5jCkHLop?=
 =?us-ascii?Q?GzAqTHRd/qTUtxMn0It7ZGFaal4BgJ+Zjd0EN2ngkQgvLeS8I10k+U42esMT?=
 =?us-ascii?Q?WGcwQlWGQMGYu99rTCPk+CWW2KStzKhoOKg9pKrEZVEASIwo9ib3eEiSfOXV?=
 =?us-ascii?Q?1tnezwICPRWTtXDgeEyML7mJ67YkCRzmkkmQqI2xjq4/gS1qGroLcckE1/HI?=
 =?us-ascii?Q?V7960FlOZxsEgV2ERz9CvMElJvST74LOaOY6vjD7e2HL3zmpNdtoSn97v/0e?=
 =?us-ascii?Q?AKQPJNyalRl+DZdEploVE2lG0rFLbGc6yZTtn8snljsydTcpysVC0j0O7Oxd?=
 =?us-ascii?Q?cjr0+hOgaA8JekzPrjjLhigFi40jYv/X7HUn9CzSP0m9Y6dVu1y3HFNuqD/a?=
 =?us-ascii?Q?frewgozzyq1Enf/lA2ak0HhV8FPmXRrrfVSOU2u9IETlZTCqh3T0XXYVRI6a?=
 =?us-ascii?Q?HpGc0ctmCGX9o1XHvdvRDlj0ZsYLVqjMke4rxy1q2uzL5Mfl5e3lDhShvY3Y?=
 =?us-ascii?Q?q8LjNftt+Tgx2Ib5zna0cCBmNXMQSkCbs/k/XtNz+wBu/u/V5zhcrF6KYdcs?=
 =?us-ascii?Q?r9O0GvMUFj6sknO+YA8TP495K5HG76Pb+45AeHtX39QH38caXUggw4BqSik7?=
 =?us-ascii?Q?aGGfQgNk2lV9bX/WNYt5Jyr9W5ZFMUG38JXr4FZhfaX4t4r+TUK69pTQBhoV?=
 =?us-ascii?Q?mQfL4a6rNl1rNrkc2BqzoLvEZ8E+XBjFbTK/Xi47YkiC27PopG5AF0aWnRH9?=
 =?us-ascii?Q?nkRBkI3vqp9Q8ncfdTjK+AtZrpcvb/PjOcObsbX6CeyrNKpVcasiVbtGPj9r?=
 =?us-ascii?Q?Yoe7S1vQ8tN2dhIz4RNHEDCHrR1t1G9kZWdEQSdliKdDe7cjrj/fP1UTuHQp?=
 =?us-ascii?Q?KZju99R7crNw/o1OVxI=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e5b4bef-96a0-4220-f4b9-08d9e273dc79
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jan 2022 15:35:49.9919
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iJMd6d/SeQO/kgkeEGhcTq18UPg8FaL+vOuoRB5LLBZOK7Q/bGxEHkGVYPUzPe1R
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4135
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Jan 18, 2022 at 09:35:00AM +0200, Leon Romanovsky wrote:
> From: Maor Gottlieb <maorg@nvidia.com>
> 
> In RoCE we should use cma_iboe_set_mgid and not cma_set_mgid to generate
> the mgid, otherwise we will try to remove incorrect address.
> 
> Fixes: b5de0c60cc30 ("RDMA/cma: Fix use after free race in roce multicast join")
> Signed-off-by: Maor Gottlieb <maorg@nvidia.com>
> Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
> ---
>  drivers/infiniband/core/cma.c | 61 +++++++++++++++++------------------
>  1 file changed, 30 insertions(+), 31 deletions(-)

I didn't like this one so much and changed it into this:

@@ -67,8 +67,8 @@ static const char * const cma_events[] = {
        [RDMA_CM_EVENT_TIMEWAIT_EXIT]    = "timewait exit",
 };
 
-static void cma_set_mgid(struct rdma_id_private *id_priv, struct sockaddr *addr,
-                        union ib_gid *mgid);
+static void cma_iboe_set_mgid(struct sockaddr *addr, union ib_gid *mgid,
+                             enum ib_gid_type gid_type);
 
 const char *__attribute_const__ rdma_event_msg(enum rdma_cm_event_type event)
 {
@@ -1846,17 +1846,19 @@ static void destroy_mc(struct rdma_id_private *id_priv,
                if (dev_addr->bound_dev_if)
                        ndev = dev_get_by_index(dev_addr->net,
                                                dev_addr->bound_dev_if);
-               if (ndev) {
+               if (ndev && !send_only) {
+                       enum ib_gid_type gid_type;
                        union ib_gid mgid;
 
-                       cma_set_mgid(id_priv, (struct sockaddr *)&mc->addr,
-                                    &mgid);
-
-                       if (!send_only)
-                               cma_igmp_send(ndev, &mgid, false);
-
-                       dev_put(ndev);
+                       gid_type = id_priv->cma_dev->default_gid_type
+                                          [id_priv->id.port_num -
+                                           rdma_start_port(
+                                                   id_priv->cma_dev->device)];
+                       cma_iboe_set_mgid((struct sockaddr *)&mc->addr, &mgid,
+                                         gid_type);
+                       cma_igmp_send(ndev, &mgid, false);
                }
+               dev_put(ndev);
 
                cancel_work_sync(&mc->iboe_join.work);
        }

Thanks,
Jason
