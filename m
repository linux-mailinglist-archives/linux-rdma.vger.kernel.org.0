Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46091510006
	for <lists+linux-rdma@lfdr.de>; Tue, 26 Apr 2022 16:06:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242089AbiDZOJh (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 26 Apr 2022 10:09:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351592AbiDZOJa (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 26 Apr 2022 10:09:30 -0400
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01olkn2057.outbound.protection.outlook.com [40.92.99.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 568D710CF
        for <linux-rdma@vger.kernel.org>; Tue, 26 Apr 2022 07:06:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XsLaFBOXaenJ4MmOPH4dd8TWBHTFga7E7aLwSI5tejvvFCDW6of1i4ptCPjDtRlFouSP5raQC0k5Q9um6bZEaxQUAd9D6xCjDr3JtZ9xZtr84OlXY2stUKrM9DASc1KMUtq7yagx4ysS7NRfqiyNTmTORX5GUeIZ/xViRfHQUu+cUsMzKAtKZ60jP17FhPwwS02GU+loXAVJl5hCf1K+7ThtMLz83yh2OVlTxZ18SvuragmXqNYMYQT1qv/LtXyOqpSM4ii+I2bLxxlAvs1fSMJjG4CjbK0A16/aA5lL+2ZRXaM131535SlsWRPexSDyzuvwGulBN705O+HAYujKLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6aFGU1H65PwWu8KAMJ8bzCE4PenODrO3/5svx9Ro2xM=;
 b=oaGSPzw7fD5Mb5LA1nblVsFBLc+Cioy88FEnhFc4MleeiHuY5u07ZoCsJPEXo4LTl/LHqJy2XmHeWtskWYPLdx/YbHxY62us3FHUQ4gd77ywOJDHMQZW55AyfnyufEVtT2fNo/2B+BsSxKK6O7WJYfbaDsb6oTLmtupkOmXtL5FB3VY6YXNFszcGlhRrN3GfdKY8UOoqwhnL655j74KWlDPeU+sybvRqeDbJ3WRhgEvV8mO8cN6oqpu2RJ6yYQkrSNY9/800kcshMjV5xBiUjs0ag0gbJc1VRX/NsxD1NZvweRJnAJQrmt/eiglXcIKyYAp5Z09dVXFP6RClARNZZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6aFGU1H65PwWu8KAMJ8bzCE4PenODrO3/5svx9Ro2xM=;
 b=Ojq852WI3EN3ZMZh2PzVpHA8ONJbIEgMeYdxz6uo5+CCbqim/qKxffLXqLnjeU7JjaTHnBHDMnw1p1eSIiVSJ2eyk4rEUYj1e60dMxfa2mBRmntdcz9AY/IrRrhtptQD93si0BpzZhFN+LYXlscuF3+WwtNXKhozgYzmEIEFyZMcVaaVB9cfIOOfnfiCdj1kSFAjHTxoSn5eGWa8H3v/SMOS96rNypdpaTfIKctgjfucwD23oURmNsOp9Ttxf4GJWHd79Kcsw0LzfQcsjZYoxKFm+R85tBzFdvoWr1IDvx6zb6oX3y8tpIRxQbdnZh998NEGTQ4Yp87uUX6locVrpA==
Received: from OSZP286MB1629.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:1b5::13)
 by OS0P286MB0083.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:a4::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.14; Tue, 26 Apr
 2022 14:06:20 +0000
Received: from OSZP286MB1629.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2511:338a:d575:dd61]) by OSZP286MB1629.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2511:338a:d575:dd61%8]) with mapi id 15.20.5186.021; Tue, 26 Apr 2022
 14:06:20 +0000
Date:   Tue, 26 Apr 2022 22:06:11 +0800
From:   Changcheng Liu <changchengx.liu@outlook.com>
To:     leon@kernel.org
Cc:     linux-rdma@vger.kernel.org
Subject: [PATCH] net/mlx5: correct ECE offset in query qp output
Message-ID: <OSZP286MB1629E3E8563657C551711194FEFB9@OSZP286MB1629.JPNP286.PROD.OUTLOOK.COM>
Reply-To: Changcheng Liu <changchengx.liu@outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-TMN:  [2ciifU56X/cPyUiUh/ct0ykiy4WSr7RG]
X-ClientProxiedBy: FR3P281CA0028.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1c::19) To OSZP286MB1629.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:604:1b5::13)
X-Microsoft-Original-Message-ID: <Ymf8UyYakhQM855G@gen-l-vrt-307.mtl.labs.mlnx>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 12112ba0-52e3-4bff-183b-08da278df009
X-MS-TrafficTypeDiagnostic: OS0P286MB0083:EE_
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Xli7xBlyWRx9jmkdlVyLzdd3+quXmnp2gMs30RnmN5kWGvs7lvxX/xIBRFNekB1mIIIii2XrsaoXOoJEX62CYLxzLhGlgNIvuE8HFTPiuU9HQLBh7j8AE4/tf/0IMKWNEX5ZfBUoO6QqFrjDUxWDaj9DATs+X3VbHY0kq0szr/PENpn+AEj52JWE824KID8rVgaFAWxa/ckoHyWzjzRtv6hVyfzLeDMwcOd0H/faZhIWapylt0oOBt+FuaRMHnUPVH9+o3N9h+WQRIzPi+UW2Gkz5U0Tv/799x6WWVQbmKH9bUmbuggr7fcendFaDiPl72sZqYy3zx0rx8Hozl8uDhs0WD/112zjQq9FqifKRgpfeABb0+8M7Znt0ElpWk4yYwLML/tin/f61PShkVQl7WHsGtKS+2W2J/VBGApNgccdFVon3FdfJKIBEY5iqVsfdPVb3UcY6KgLILRziu1cm2Sy6k0RpBpCeppAZzMgqSYBaKNii175arr2r8JrDVc/S891IUryqkPLdQYU29q8rIXV9ZfDlabGxkks0ubMIE0yCFDUNVf8OdpNqkUXh+oln+PvvH1FQTUaVpderbYthw==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?/xr3QxDXZBFx9HDKao8KZpj+L8VRXLnbV5Vhj/0GML6kX+KEjRY8/lqMLZe7?=
 =?us-ascii?Q?s9gdjKE5ObH6gMirNA+OzduVTdtwypTQftX+FVYe5rbEQDm7lLwAOk3fVkek?=
 =?us-ascii?Q?jUjXysMyoUEc4kIVladxdKjSNnMEgQpdaRQAxrNfrp3hYV+OEJwKsF1jyNJK?=
 =?us-ascii?Q?yi4QHDQtQkt6IGlciJ8GLA04WaMVCNmnQ6f9Nxte02HJDiA9EU+Yv4xB7cVw?=
 =?us-ascii?Q?mTrn8DgJHpZO4VwWHEl7mGiH+YnqkSepKMFE+8cyiGVQ6H8jXzDZoY25SMuN?=
 =?us-ascii?Q?2VQCZcRl42l1pLOyTVAnP4jDEDVNDHxiSUmnq1IcbjoAsUzBO5A1MqObt0Hb?=
 =?us-ascii?Q?6nf5OqNoB3Va9Kzg6bK1G+P/BDHO3OoNIWKjTCD9m+oVbR2CZBLcZ7tETfCp?=
 =?us-ascii?Q?SxflYlyCl9cQxpFRNQMSEZ2L2rAqoGDE5IQFltBbPR2O27bnD4LznWEQ7AF8?=
 =?us-ascii?Q?R+eqzAhVgxZl1hUTcADL/K8U7/y07OVZlvcdCsTCV7uTat0UdWbeC0L7DBB1?=
 =?us-ascii?Q?+ZjLCUfvAc3uYqUAR/IqEEChQY3KhZmIcajNGEy0ysccAxxUk5O9wvA+jNju?=
 =?us-ascii?Q?Wt1C49/CvMfYjEDimEfG+lctKuO6MKBFomW5CmdFWj+mCyVXawUlPOEh8uvI?=
 =?us-ascii?Q?5Bwh8/M+qqYpqxIysgUTrj1Q6SvWFMhQMYRtoDtcl2TxKUbnvfDxSHaeIKMP?=
 =?us-ascii?Q?6xB+xWUeeVn4vs7hhh0xcGMV6tWdsQvUrThhQDu1tmj2CysK85xu1G6/5zST?=
 =?us-ascii?Q?Og77/2yGZaUX0KMO0vM5gPp/pf5v6ifmKb1JLHDJSpLjfBulFk5mdqGK/gOw?=
 =?us-ascii?Q?aU3qexphyzegb8Zx9YyazrArnBeM3cS2X0yBs5bmL3kG9ilTCcCNAP2uUfbF?=
 =?us-ascii?Q?eaqRmyDg8K6Ze+of6ZadGElZGe7estBwtTlbMAVORRiIW2LjH0GAFMBDFSQQ?=
 =?us-ascii?Q?HmAUYB4pblz6X0swfrEVY6tXAbEkly7iD3jfyD2hZJQeRRyU7BBOD7dfYYGw?=
 =?us-ascii?Q?lCDyerlt26PsEGwKfUZivilAcDHTbMAAlj/+8/X4uD6EggUMrqUZwX8SbhIf?=
 =?us-ascii?Q?AI0PcZvQZTtQjqxDWcya4myq7MrbO2JPOwH9cLhzhZR8zLnkUhXS0tzSBru6?=
 =?us-ascii?Q?HkwzsHiOPFYpFM69hyoRutMbpfEWEQisMD1GhQ9Ethm06sVE0p4mKjcfjBdl?=
 =?us-ascii?Q?UgpqACNw0otUBWmkPG2fP5Vp8hSCSZ3P537+7u71MoAmBFzgM0xM5Wx/MsDC?=
 =?us-ascii?Q?UkgOhCXoNlCCh9HpX6oHFCTkZdsqXyUTWUZZYycNzPV/ylHgiZ+m2Hf43kNa?=
 =?us-ascii?Q?4QothDjhAmKC4rFjyMhTimYi7ZHZoamOJ5zTRnF4zNF+czT+QLNweQH6ibI2?=
 =?us-ascii?Q?Gi9UHloqyjSHcb/zGTcbE/j46E/m4VIZ+QTjcQIEELZr+Am7gTwiQgVmOPas?=
 =?us-ascii?Q?Bt9yDxw1DscrDk8Ui8iJGI1jSokrqtZA?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 12112ba0-52e3-4bff-183b-08da278df009
X-MS-Exchange-CrossTenant-AuthSource: OSZP286MB1629.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Apr 2022 14:06:20.6250
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS0P286MB0083
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


From cd2890fc0f756d809f684768fabb34b449df6d29 Mon Sep 17 00:00:00 2001
From: Changcheng Liu <jerrliu@nvidia.com>
Date: Tue, 26 Apr 2022 21:28:14 +0800
Subject: [PATCH] net/mlx5: correct ECE offset in query qp output

ECE field should be after opt_param_mask in query qp output.

Fixes: 6b646a7e4af6 ("net/mlx5: Add ability to read and write ECE options")
Signed-off-by: Changcheng Liu <jerrliu@nvidia.com>

diff --git a/include/linux/mlx5/mlx5_ifc.h b/include/linux/mlx5/mlx5_ifc.h
index 7d2d0ba82144..2e162ec2a3d3 100644
--- a/include/linux/mlx5/mlx5_ifc.h
+++ b/include/linux/mlx5/mlx5_ifc.h
@@ -5180,12 +5180,11 @@ struct mlx5_ifc_query_qp_out_bits {
 
 	u8         syndrome[0x20];
 
-	u8         reserved_at_40[0x20];
-	u8         ece[0x20];
+	u8         reserved_at_40[0x40];
 
 	u8         opt_param_mask[0x20];
 
-	u8         reserved_at_a0[0x20];
+	u8         ece[0x20];
 
 	struct mlx5_ifc_qpc_bits qpc;
 
-- 
2.27.0

