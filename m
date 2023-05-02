Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22B2C6F47F6
	for <lists+linux-rdma@lfdr.de>; Tue,  2 May 2023 18:08:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232096AbjEBQIr (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 2 May 2023 12:08:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231728AbjEBQIq (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 2 May 2023 12:08:46 -0400
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01olkn2080.outbound.protection.outlook.com [40.92.99.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E25CF210E
        for <linux-rdma@vger.kernel.org>; Tue,  2 May 2023 09:08:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=izNQnOwaWcYtGaHvfxUAno90cnHPuBK6dRDlwdkA8BexgwVIlBdXlmmtd5ZXgqAMVSSW59ChiCtdUtxDrmPbv4QAsGDYu5G4y8KcdCsinQ5py7PLWmXjiPvxLOmRckHPLdLuKR7g6FeJTOt83NY/eomgcOqLtY8+h5THZGtDfcSk8zx+bZ4i2gP9FEAiytjOu6D15dpbz0kxMlhHB4od9lvsBFEwX96ykResw8Jv+ynnT2LkIhzY8GvqdVGKCPowmnNHjGHDvoKIgsBa9GhrXm1w0lhDe0hVgh4f0cnx3lRn9oKLd2t8+59I3ScBPHq03HjM6zqR5KAHrmc63G/AlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QKcKskYaQ6+Rb/jCd2X3+1zTn3XHaVsyZ3ujpiz1tDM=;
 b=CR18PGSWfPjPwCVgYgnr3SRUOYnQYMcab5YEhIe5m+QF9sSEwHExc6bjsvUsWxQ+CJ2SLv/W4gPGqafs5F/BwY5pIcl2iVjFsTDn1kFs4t5wcxougfXNOVeyXuMtCz3KKUV27VqGU6xMqowiw+/S7ZB6M2WOn3aQzchfCb4CCTwsl8PnKOrCRKZuBvd80ZuULQtgYF+V61zJyj/veUwbNFD9nozK70JDELNuD7xH67r0THqbgWWvavwcRdMVh7LH4fHS3NEZy7CY7HIfjngOMqrx/9l/8zQrtLKQDrcseOI2BEdm6VQyD0IQ/KLBz5daQTNWvnP2mPKJCBR0P9+2hw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QKcKskYaQ6+Rb/jCd2X3+1zTn3XHaVsyZ3ujpiz1tDM=;
 b=fVgDrC7jSNqkzUrUeZDUY7gIzC/JwzchDPsQgPNTdGN/ltz9HvTy2b/jdV/twR84+wH2CXKlxDst7nz5TW4ffwsuFU3nW7mYdWI5YTedHEGSN5HQrGbqZbveVAZVlsiU4vvCoD6v7enWbcSdqblszpNQHM72SD+8afmKdz3zSf47vT2Oab4H5BwarX2RVLxN6XJb7MvqWL/W1IdCnrpWUzKRsZ7uFmgpp6eclDi83Sg7HliOthZnboBFjLkEjy3Qy5kdSAj5Z6oLhrx1eLBqFllUU7/pOnk1atLwiNtJcZuW6Gq1ZyQ/rVC605W1V5pKibUeufQhoM/usL7yVNa5kw==
Received: from OS3P286MB1640.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:161::10)
 by OS3P286MB2294.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:19c::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.21; Tue, 2 May
 2023 16:08:42 +0000
Received: from OS3P286MB1640.JPNP286.PROD.OUTLOOK.COM
 ([fe80::c3a8:ea02:144f:70e7]) by OS3P286MB1640.JPNP286.PROD.OUTLOOK.COM
 ([fe80::c3a8:ea02:144f:70e7%7]) with mapi id 15.20.6363.021; Tue, 2 May 2023
 16:08:42 +0000
Date:   Wed, 3 May 2023 00:08:31 +0800
From:   Changcheng Liu <changchengx.liu@outlook.com>
To:     leon@kernel.org, saeedm@nvidia.com
Cc:     linux-rdma@vger.kernel.org, changchengx.liu@outlook.com
Subject: [PATCH] mlx5: correct reserved space offset display
Message-ID: <OS3P286MB1640832E1812D661FB81925EFE6F9@OS3P286MB1640.JPNP286.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TMN:  [y0afCF4AMY6+zDbWiNcnhddCk6k4KJ6G]
X-ClientProxiedBy: FR0P281CA0154.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b3::11) To OS3P286MB1640.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:604:161::10)
X-Microsoft-Original-Message-ID: <20230502160618.GA49793@gen-mtvr-09.mtvr.labs.mlnx>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OS3P286MB1640:EE_|OS3P286MB2294:EE_
X-MS-Office365-Filtering-Correlation-Id: 0531403d-1d03-484f-47e8-08db4b277f9b
X-MS-Exchange-SLBlob-MailProps: AZnQBsB9Xmq8x+SGOkCzgiPw6QkSRilgDaoa/EDS8B6pz0hMTkhKYMCmQBefGVA9gzufn+2EDcyctswM+FJugsPOuii8qeKV5/46CAWoQJ+2f9ZvJeNVQLyiPdgozZMJ4hN/SmVKRvALxzajk3Y34DCmMHtlNzzxJPo+ezkOKXtm2dj9sli1gtncp7GKvtOCPbSEo6+yo/3bSnEKhETcCMxFqY8B6Pnkg9hDSY6IsmsX5k7+R9wTgN1F5KtLuzDKwEX7WzOfcC+cVO7L53tTtkmF+e9MoMmnUNpIx0FLnK4ivQX5zcddCLHlxchSIc9kSn2r6YsNn6ew1V7miOvROKxhU+Ox4ZXwulmYp13JxWzVFqhnTg/mO/aepfVxFxb2HYicoBrp+h3qTkCiTX1/ddM9apOt/2KeklpUU2bmBx0NJRr+oQxsRlE5T2qxx+bPMORUEvWXMwsDxgTQ2x99loEr6UU6xbDCkm/d+ynVr7gIioneAxl5HyF7qrMxsuqkqEd3oUdYiD4hDm6zzNEc7ngt34IPok5lq1xdhw38URrDumLC/ZTQvCdVkHIe+tLz2/O0XzFvBCXjSeQsZHPYSG/k3OUMh2Y3oXhPFxjdKAKwUQSqBydoIfPlbTUbLz4TeslpPQAo0MGFS2lBf4vUUv96pF45tLld7/KRCHzrUqn+NAJ5zkUTCtq5CyW51FQxePXMd3aCAizVrhonzHRhmVEw0K7eBTBYCcjqaSkBOelfCvgpQe7UYwOjCAbXnGF2eO/DdN906v0=
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kGGhMKOplYdnBQnYDKFyjbKry3gTScyTUX/B+OMaMlY4vIDCXMpK9jkEvBlND1ILJ+FWhr8SVb3kj98Xrs5VUBaVxdc2wR9o9r+53tya7Blw0sfCWeGcizRGN3LC7IVoRmjPWwbBKEuDQ6y08q4CZ11SmTzf7eVmnD+odxEFm5FV8hVp1mNuaZOHaEyDksoB8SyIvmcMJsNF86cYcav25XYYQhJXVIA7QnXQJUO6QfAZz/LTsyhNEBvIPgeWjolTGWjuFw7XsOrXWBk7QW5PjW3pldy2mFbp42+UbGGf31kPXGDWbzVhS9lEfKg3/vjS/+7VoIQQ4veklWQyGEvveAbpVFxM35qg5gy3Dw8JGR5FFTXykvs7iqksIw2XgwiWnZeSEBDMam46KX4wNMcQBvkmknluoarlklBK8sHTf/wHs8KltNnhKCc73zeeGz0jV2IuHi2g35TmvHXXKtnSxJ9cnowA2UM8PDO62wNg7e/bs2B4ALlU8ILHvbgIcv3aZjW5JGmLTrZup1E0XG4WwGr4B5Gj4JmEFbQH150PKc2ty+pajwnZXWqwAVgc0HX07AWJqBHLPV1WTlUSdbgr9X6ikEDsnbWCWGkBl5mb7enjCnfwp4KA+kFEB0HHED2t
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ztbji2Z1laCVcrOCG7LuAYau5+jAaSOv4xtdRuYlP7QkS1twXIeWBgo1s/KG?=
 =?us-ascii?Q?X3OdUfTH/ZDyUO5H8y+07b7HJ8T8RA63gtyTpFGObByuLN8uzKncQqcgGbOR?=
 =?us-ascii?Q?HQX8J2Hf0cHBN/7+aOS7/vYPbOWad8CoOHFzcdwlBN9tsTVsoKPLWUdPlac9?=
 =?us-ascii?Q?yb+M90N02DTBNJPmY+Ob1SvGp+kuqbzp3IdlM9KYueFOK65MWiYSxUnw1vuX?=
 =?us-ascii?Q?uWJQPUeAi84uTlODcPt01QWxNboDqb52VxGJvXME+tONuJ9AIL/iEQ3Z1d+Q?=
 =?us-ascii?Q?6gdjdO8yA/9a7uLWspeKON7dQanzV24NqX3gh7GyRqD/P9DdCh3PVVzvuWUc?=
 =?us-ascii?Q?MRzeFma1N0jskooc4YOYp7PIRSYvcWoGcgbW2eajFXipjJJuBLQpQ1xHMK1d?=
 =?us-ascii?Q?MufYcnZrXHbx0TiWumxWzLfWZSt48+/8sp9N8GqgdDXGCpxdvmUYMlNMUSuj?=
 =?us-ascii?Q?5CkPTLuZWSSgHouAzgfsV+iJRtpZSuCFThdDf8muYkhybkWHRW3kKTYUdRgx?=
 =?us-ascii?Q?zcfhzEfIWNDaZnKwDTLSNBdb1+6BwpfnyvdBiQleIuJG5En0sMOG3riH5fD5?=
 =?us-ascii?Q?FMrHtyrD9NpKzVLZAUnQJ+2/u8DoD86TkxtuOAI2AHnp9433BYa2f6m4BFD5?=
 =?us-ascii?Q?XtYJpX7D9/rr2Nuzwc1Csebe0Z4s6yUyTyHUUMWjG0v+jrX2D80enwEzm+Fc?=
 =?us-ascii?Q?xeQU71uySfYNsdeIOrgD6YBkXk76yRrCB3aqBlUiLrVsObIoI2p2W1csmNYx?=
 =?us-ascii?Q?mv0IDYS0HcMd/BZ62+YyLWmev/hijlVMaHBECb3rvfeGinWvL9sISNEH6BQ5?=
 =?us-ascii?Q?x8omtEvW24KPV3siToz3uKsOusuZSIeETBbUfjmT4qxHEub6/ZBU3RXV4BRb?=
 =?us-ascii?Q?KMK8p6AvrN+pBegSTgLguSUVJWYoT7kVcsqWhx9mdxN1unZgHjVQvoS5KpVz?=
 =?us-ascii?Q?MQOPP+WtzemQ17F+GYH6yhmEp/YSSLr2HfK0h5d8yaoJZSApn055tFk7FUCj?=
 =?us-ascii?Q?B1SjjZzafx/0lI2ixAitu74uFdxk/8OYibCKPOmzmrtpJ2n7rjkuIpMZZVmT?=
 =?us-ascii?Q?ZhHnEqaEbRDSrKezusb4spy0AKwvNRyM9BgZAXMdHm0BGORmetLaXI644SNi?=
 =?us-ascii?Q?V78uO65ILd1meB/xLfOIrlm/s0PzwN5w92CqDKVwEchQmmtevVStO2MOI+xQ?=
 =?us-ascii?Q?VzjhSf6SARpXzz3h59w9hcTJR1UlxzFgIWTwMxsTuSIkrZrI8LWTffKt/t8?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0531403d-1d03-484f-47e8-08db4b277f9b
X-MS-Exchange-CrossTenant-AuthSource: OS3P286MB1640.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 May 2023 16:08:42.3023
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3P286MB2294
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

the reserved_at_xx is start offset of the reserved space, update the
offset display to correct the real offset in the data structure.

Signed-off-by: Liu, Changcheng <changchengx.liu@outlook.com>

diff --git a/include/linux/mlx5/mlx5_ifc.h b/include/linux/mlx5/mlx5_ifc.h
index 66d76e97a087..d8a48e2dd5ec 100644
--- a/include/linux/mlx5/mlx5_ifc.h
+++ b/include/linux/mlx5/mlx5_ifc.h
@@ -537,7 +537,7 @@ struct mlx5_ifc_fte_match_set_lyr_2_4_bits {
 
 	u8         reserved_at_c0[0x10];
 	u8         ipv4_ihl[0x4];
-	u8         reserved_at_c4[0x4];
+	u8         reserved_at_d4[0x4];
 
 	u8         ttl_hoplimit[0x8];
 
@@ -937,7 +937,7 @@ struct mlx5_ifc_e_switch_cap_bits {
 	u8         nvgre_encap_decap[0x1];
 	u8         reserved_at_22[0x1];
 	u8         log_max_fdb_encap_uplink[0x5];
-	u8         reserved_at_21[0x3];
+	u8         reserved_at_28[0x3];
 	u8         log_max_packet_reformat_context[0x5];
 	u8         reserved_2b[0x6];
 	u8         max_encap_header_size[0xa];
@@ -1458,7 +1458,7 @@ enum {
 struct mlx5_ifc_cmd_hca_cap_bits {
 	u8         reserved_at_0[0x10];
 	u8         shared_object_to_user_object_allowed[0x1];
-	u8         reserved_at_13[0xe];
+	u8         reserved_at_11[0xe];
 	u8         vhca_resource_manager[0x1];
 
 	u8         hca_cap_2[0x1];
@@ -1618,7 +1618,7 @@ struct mlx5_ifc_cmd_hca_cap_bits {
 	u8         pci_sync_for_fw_update_event[0x1];
 	u8         reserved_at_1f2[0x6];
 	u8         init2_lag_tx_port_affinity[0x1];
-	u8         reserved_at_1fa[0x3];
+	u8         reserved_at_1f9[0x3];
 	u8         cqe_version[0x4];
 
 	u8         compact_address_vector[0x1];
@@ -1682,9 +1682,9 @@ struct mlx5_ifc_cmd_hca_cap_bits {
 	u8         reserved_at_241[0x9];
 	u8         uar_sz[0x6];
 	u8         port_selection_cap[0x1];
-	u8         reserved_at_248[0x1];
+	u8         reserved_at_251[0x1];
 	u8         umem_uid_0[0x1];
-	u8         reserved_at_250[0x5];
+	u8         reserved_at_253[0x5];
 	u8         log_pg_sz[0x8];
 
 	u8         bf[0x1];
@@ -4062,7 +4062,7 @@ struct mlx5_ifc_mkc_bits {
 
 	u8         reserved_at_1c0[0x19];
 	u8         relaxed_ordering_read[0x1];
-	u8         reserved_at_1d9[0x1];
+	u8         reserved_at_1da[0x1];
 	u8         log_page_size[0x5];
 
 	u8         reserved_at_1e0[0x20];
@@ -5279,7 +5279,7 @@ struct mlx5_ifc_query_special_contexts_out_bits {
 
 	u8	   repeated_mkey[0x20];
 
-	u8         reserved_at_a0[0x20];
+	u8         reserved_at_e0[0x20];
 };
 
 struct mlx5_ifc_query_special_contexts_in_bits {
@@ -11449,9 +11449,9 @@ struct mlx5_ifc_alloc_memic_in_bits {
 	u8         reserved_at_20[0x10];
 	u8         op_mod[0x10];
 
-	u8         reserved_at_30[0x20];
+	u8         reserved_at_40[0x20];
 
-	u8	   reserved_at_40[0x18];
+	u8	   reserved_at_60[0x18];
 	u8	   log_memic_addr_alignment[0x8];
 
 	u8         range_start_addr[0x40];
-- 
2.21.0

