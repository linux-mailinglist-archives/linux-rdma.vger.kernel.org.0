Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03F7B7493B9
	for <lists+linux-rdma@lfdr.de>; Thu,  6 Jul 2023 04:27:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232443AbjGFC1X (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 5 Jul 2023 22:27:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232319AbjGFC1W (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 5 Jul 2023 22:27:22 -0400
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2126.outbound.protection.outlook.com [40.107.117.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82869199F;
        Wed,  5 Jul 2023 19:27:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W1Y9/MEu19iu4xc2DI8ntUtL2Ya7OG0xL5k0M0XV+6sIyXj/+rtx/q3HD3Xh3LHbyqDBCVu0y8yPUHlDtFV6vhiG/+INcJauu14+e9pgOENiAwhWwgP93qDuT8D8cEGm9DWA3M0ACJwdNXD7O6j3KNyFAMWF/X3PFIGyBZbvAUXFtm2ujUx0W/Z4TVw2nc0SfYyALpVniFznVVeIgO5wp5u+YJeYfkUpcgv15uaAyyFsuuDe56ZLqtZIX4T6n87J99rhF9pbLAb5dTaF7O8U3eTjiyUGN6AYQbSMnyIVnVgfyBrapSai/lBebiRFMmQwZZBwKNLsbPf5Gf2p6b+INA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k0wsH93kGsddaTO1vVkUucZt9Mr9F2ftm2OfSkp9tDc=;
 b=Tbq7TN1stKFcNMDgrDeAgITCTHzboVze6OAaJrbXA0OhMLAmDgRB+tWTBbrQLzoQMqzWGd/O6xKl2cncLN1yPO6GY/Bh9fmooVsRPzdDZMEn1K7UG5+fP6Ei9yBNFMD4x0DC/2ByznuKCcb5IOY/ltRnf03XjtKjhfA6LUbCowPjcQOeEx3a0XcxMaN9fhZtVUPh8FGULFFA/cR4amVoabrc5+mJFk9ynQwJHtzgDEI3W7p1BnsV0y7K7S8Cywf329FgxFSdVXCgolVaGSkuxM17JeasywRQrIzQPKx/Gzs01WZMZPS//AebfOzKmsygjkDJS2MAPJ9dOewcsr2Nzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k0wsH93kGsddaTO1vVkUucZt9Mr9F2ftm2OfSkp9tDc=;
 b=R5owK67iCWuAezDKyHwrsPgsPt6bCDEdOlyT7Ajwe8tDkN+KghOY6GDAkyTYHurCtb/j2FtlsNBVzE90fr5JDWIDrxPKO0C1hSUqviZHLDMuv2zkc5ciqiLfCI6X1yAC4X0xZdjrywYsLQTWrlWRcm8OpJjSZE2ux3sOIYWW998xlHaMcu3pOkYEjY4cmQg/YiOJSCrRiyW6yxtfTc0zHXHqPOWSINclB2UjPbv6QD+vj/tygSlnjRzj69OaRsVYxj8rN8WO/Qa5wL/6UtCH0YC2qQE8yglyWBN9e4CVPvT2HYSLh1T1mL70ZlxYP7swehnRNhTb6UiytL6h53qGTQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SG2PR06MB5288.apcprd06.prod.outlook.com (2603:1096:4:1dc::9) by
 KL1PR06MB6394.apcprd06.prod.outlook.com (2603:1096:820:99::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6544.24; Thu, 6 Jul 2023 02:27:15 +0000
Received: from SG2PR06MB5288.apcprd06.prod.outlook.com
 ([fe80::c2b:41ab:3b14:f920]) by SG2PR06MB5288.apcprd06.prod.outlook.com
 ([fe80::c2b:41ab:3b14:f920%7]) with mapi id 15.20.6565.016; Thu, 6 Jul 2023
 02:27:14 +0000
From:   Minjie Du <duminjie@vivo.com>
To:     Mustafa Ismail <mustafa.ismail@intel.com>,
        Shiraz Saleem <shiraz.saleem@intel.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Leon Romanovsky <leon@kernel.org>,
        linux-rdma@vger.kernel.org (open list:INTEL ETHERNET PROTOCOL DRIVER
        FOR RDMA), linux-kernel@vger.kernel.org (open list)
Cc:     opensource.kernel@vivo.com, Minjie Du <duminjie@vivo.com>
Subject: [PATCH v1] infiniband: irdma: Remove a duplicate assignment in irdma_query_ah()
Date:   Thu,  6 Jul 2023 10:27:03 +0800
Message-Id: <20230706022704.1260-1-duminjie@vivo.com>
X-Mailer: git-send-email 2.39.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR04CA0161.apcprd04.prod.outlook.com (2603:1096:4::23)
 To SG2PR06MB5288.apcprd06.prod.outlook.com (2603:1096:4:1dc::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SG2PR06MB5288:EE_|KL1PR06MB6394:EE_
X-MS-Office365-Filtering-Correlation-Id: cc60e210-c3f8-4051-f761-08db7dc882be
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ixvrCNDc2vu1/OOOlayUHXqHqw9LgJ7UijS/TkrrM64ipsfQLaWxeN/2H47i8LlyamyWL5UDaT6So1jUUQ3n2yO5QDpLLMdzgHzuwKfYCJrx+w/n+Hx8rNnRgT0WvMCjhburzcp0CT2d66WtHb+YJfR1IRhvugqtM1AGNFBV8PouxFdmiXuW4Y6nflvi15RXCK+dCYAoFDw8eZacgf5J8CRqxeHYd2cWKagZJekLkrR5hnanKuTe6dvhZD5RAJXZzAwZ6/BlZSHUTE9cUijhY8MH/AfhBmSEcGmR9ZVGxOQB2FChsTYEX/PWqGYlRv1oWj0UqA9IWmkHCzyIrjHTX5/HrZcpLLadbeZ14c2svLdnvWA+0ooMlRi2ss8CigioEfpo4Jwdi4ZMWQ0mQ1nKuFRJ8D7BeGjDc0sbQAmKRyRCKaD21UWTcIBN1Cgat9xtM43qpenoZQF5W37Ww5v+rIQxE8+yn0p2ShTLBI9GovDx6SFp5FJxypgl0/JnPS7cNEzVh37R3VgfJCdcXRDu6Hf2/kRZ9Lcv9WDBmIhmSlPiQ4H9bXO3kBRWRLXhWygQtuDdW3QBHrmIMc+lycg+3+lran6rPWHlimUgSURnpAtkzDFIIOLf6Mgu3HbWRh0x
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SG2PR06MB5288.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(396003)(136003)(366004)(376002)(346002)(451199021)(107886003)(41300700001)(316002)(52116002)(6512007)(6486002)(186003)(83380400001)(6506007)(26005)(1076003)(2616005)(6666004)(110136005)(478600001)(38350700002)(38100700002)(66556008)(66946007)(66476007)(4326008)(5660300002)(8936002)(86362001)(8676002)(4744005)(2906002)(36756003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Cftuf3qfQ8On+TsJrkYfAvrgbC1VxHzLzjI1C+GPTuqeiHM3hsJ5ZHwxr21a?=
 =?us-ascii?Q?MxuVzunfB9EizJGSs0+c/jOTLaeY3uoJzxaUS37g+4II+e8X+zswUAocZIhZ?=
 =?us-ascii?Q?XFWSAZMdY7unpS4vcmtMKRrM3ZFtz8A0sglFNQWUDGCjf83gNeKa3KH4lFHw?=
 =?us-ascii?Q?8s51iNqBFctmsianIwfJDI+SX+x8KsfGB0xgsM+1qoYwbTHaylktUfD+DzaO?=
 =?us-ascii?Q?trJVdO20WdcWMpZPNeb/muiwCwPQRisATBV/NvVh027Slnn6RhjXqBAQO9/d?=
 =?us-ascii?Q?u3EDku3ENC7OhpCThUGZtppoHGGYvq9rE+gWn4KRCkoxNKxERGWfoFCGMhOC?=
 =?us-ascii?Q?hsNrU0Bgt9MgeXrsj75VKDUfu+fLyc43ePJdhGk/lM4lN4f5GD3PiOWdMSiC?=
 =?us-ascii?Q?xoNufC1+vqy1C2IEezn59R6/BOgSHyNr18qFPn1ts1QKlay79FVVaEzKMQbh?=
 =?us-ascii?Q?4/JpkArT3ypGm33W0yXetDBe374jnN3+E779gsb5ggUxKQkeaqJTVSf/T45R?=
 =?us-ascii?Q?7UaM99XdDTKsA+CrwnwZeHqxUX616wpBXL0gnRTACpm2QzuPqFwChUSTCX/c?=
 =?us-ascii?Q?Z9eq+/bv/oxDTSd8vs6Qyxcn5/XaGpecm9kWsI1qPQXGVzmwAEHTSO+PiB6Z?=
 =?us-ascii?Q?vwTGiqlWRD9mSgF4xbFv0G7D1JtTwlaZm1hz7sU/74sm5QpvZgoI6oYDXkXo?=
 =?us-ascii?Q?i2a9N//SNSdj7NyFd2hD800iem8O2vTCmgKwAuH3MW1hSeAetc3ktdoegd1Z?=
 =?us-ascii?Q?aTRWVtIYcF36mNrBOmXhiL/DrRfs3nThjfk+ipbKyybrskxI+Ioy4e4CPnyd?=
 =?us-ascii?Q?kr+jXtFUAjfZ4kDqWI1Zqa7Jff2zSTINodxyyO3YDX7JKXHyBamEgVgKVZ8K?=
 =?us-ascii?Q?O/W9NAKMlS96H2BZlnxpn4imay4FHU3Nf9POFmu+ySJdPV2J9/aN9C5KG/Jp?=
 =?us-ascii?Q?rxdLy97fPVcylglLjgi16M1kMJ3XkRLh7j61tX7IlbffWD35anQrW8amLLiv?=
 =?us-ascii?Q?xOwck9nZgk8aqd3TuTuH5oJ7yJRRSydI/V1RQfFqAWQBlVdFfaRbMzUHi59t?=
 =?us-ascii?Q?8F/W+0W4/+jXb07fcbruT2yKPsuSblIqPbYI5caE3VRIJ9SmB1P6CCmk/L+g?=
 =?us-ascii?Q?JuLMWUm4uX7c/p99rukaKgrhmkhI8z3xdkhZ+VRIZfmN6BuhEcVxHAaQLDMs?=
 =?us-ascii?Q?FLnWolx1azJW8WqazHB1qsCy5K6OIOla4i/6IZu40b+H7mzsHecuIbavEcOd?=
 =?us-ascii?Q?3svsuJot4xl72VOLqcZIhN9yY4EvqTaWZhNtwB7MuXZFNw25hOM2l9lJAFaG?=
 =?us-ascii?Q?89KkM8LNRS1AUTLMVO/Jk00Ugt2Iyzs7G3segZdA0RHGpuxa0u5jnzn6oE12?=
 =?us-ascii?Q?F/M5OoUtHz9qBrRRmNRDFbbXYXvYsqWAY32ZiOoP3h8LYvMutVXuD2bza7K0?=
 =?us-ascii?Q?lryZTzTjDMy/ZABx6TT1A54KAtND544ETKXRiMCYunlFGzRLggzOyhI/vMSJ?=
 =?us-ascii?Q?SJZRKp0jxE4y1GygkCDuSije9TkVSq+A1+9N6Ov6hfFi/wHnEuXVQAH/G1Zs?=
 =?us-ascii?Q?f+Iz2GiovF4I4Hud0ibjzvm3jolJkH3K9znv8fO3?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cc60e210-c3f8-4051-f761-08db7dc882be
X-MS-Exchange-CrossTenant-AuthSource: SG2PR06MB5288.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2023 02:27:14.6440
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: titPziybNmnbqqqqL2yKcecWEg7AShgwnnKaU4U8emNLPkf2OPHonaYRfWywUIUHyM2FQ1EHvyShgDtHu92piA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR06MB6394
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Delete a duplicate statement from this function implementation.

Signed-off-by: Minjie Du <duminjie@vivo.com>
---
 drivers/infiniband/hw/irdma/verbs.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/infiniband/hw/irdma/verbs.c b/drivers/infiniband/hw/irdma/verbs.c
index 9c4fe4fa9..a8326a95d 100644
--- a/drivers/infiniband/hw/irdma/verbs.c
+++ b/drivers/infiniband/hw/irdma/verbs.c
@@ -4424,7 +4424,6 @@ static int irdma_query_ah(struct ib_ah *ibah, struct rdma_ah_attr *ah_attr)
 		ah_attr->grh.traffic_class = ah->sc_ah.ah_info.tc_tos;
 		ah_attr->grh.hop_limit = ah->sc_ah.ah_info.hop_ttl;
 		ah_attr->grh.sgid_index = ah->sgid_index;
-		ah_attr->grh.sgid_index = ah->sgid_index;
 		memcpy(&ah_attr->grh.dgid, &ah->dgid,
 		       sizeof(ah_attr->grh.dgid));
 	}
-- 
2.39.0

