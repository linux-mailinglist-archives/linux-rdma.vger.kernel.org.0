Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B73B0738777
	for <lists+linux-rdma@lfdr.de>; Wed, 21 Jun 2023 16:46:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231408AbjFUOqj (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 21 Jun 2023 10:46:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231187AbjFUOqi (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 21 Jun 2023 10:46:38 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2125.outbound.protection.outlook.com [40.107.220.125])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B16C199E;
        Wed, 21 Jun 2023 07:46:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HA6wZNAbLobQp4yU4VHEcSXIU4oALnmTdUiMD+l3q+Syx9wbI7r1JBtZEcZ+QJ4XfMVxFRS/NiqJKIbxvUWobcPq4bA5qn+hmRCdOa7bcTiejdkyBpZM7CFez55MXinKZb92lL0ZT03N7PhmlNeXE0SS0lqRxNWnqjEAtV66nFTn7slIDVxqtEMmtYOv2ZRBaz8ss4JiVpeXcNw5Owm/nDWekLNTgdsntnX8lp7dlmQf4sVxK6yw7Inw/ZRJWfcm3XW+HdnRxkSM9b7d8AqgqLQp3LU9eorGlsHyzcOUqpJMStnQJoSzFco0aGF4KIsWp0q77jS5DGuieEEPTtpwZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=txOhYdUzGR0lzwIjDNXNwc4JbjgwGoTrjw/V1LKdRsI=;
 b=AaGMAbOqR878RkYcRB74A9s2ek/sv8YZPPv2bxdWSsW17g+dYrmkf55R3vPr6ouxkPpPDOWtcyD4qnhsj4daWTTF6lPS5qDqfPrHMrAMBRDXchY55bqoH/Z1SjxxNFHGKr8gUMOhhvTfcOMuR0WabU4b5PBvXmZyXFSrRJ2Sz7A/Q/k165qtqzGTVkcgzycNa/Dmaq+uz4LyMCfPmeNVKN+Gk30/J1CqkWL4GHtDaf087ewbL+K92AQYHPKZq218F0sBUtJ8ajY7gFYPspZ+Uu2zBTPTWxmEa9CwLOZpsnJ/xbtN+p++f8fc007Pt+H8mHjLrO6KH+mzLm4yBwR60A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=corigine.com; dmarc=pass action=none header.from=corigine.com;
 dkim=pass header.d=corigine.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=corigine.onmicrosoft.com; s=selector2-corigine-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=txOhYdUzGR0lzwIjDNXNwc4JbjgwGoTrjw/V1LKdRsI=;
 b=OWL9T+wTrlMu7RHpeMSD6ThxVN2mLC5zrYKWvNoWR8OJXcQSfats6tJsTq8ZfRyOXMcvzy2IYzMaNFTEOucPeXxSA9OkjkzCMa7s4gSurN4ghje2leivim4m88H9foutQjgcg0fh17iUfgqViM8w/1y7pRETgv4kpvPW7vw1K6Y=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=corigine.com;
Received: from PH0PR13MB4842.namprd13.prod.outlook.com (2603:10b6:510:78::6)
 by SJ0PR13MB5623.namprd13.prod.outlook.com (2603:10b6:a03:421::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.37; Wed, 21 Jun
 2023 14:46:31 +0000
Received: from PH0PR13MB4842.namprd13.prod.outlook.com
 ([fe80::eb8f:e482:76e0:fe6e]) by PH0PR13MB4842.namprd13.prod.outlook.com
 ([fe80::eb8f:e482:76e0:fe6e%5]) with mapi id 15.20.6521.023; Wed, 21 Jun 2023
 14:46:31 +0000
Date:   Wed, 21 Jun 2023 16:46:23 +0200
From:   Simon Horman <simon.horman@corigine.com>
To:     Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>
Cc:     linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Emmanuel Grumbach <emmanuel.grumbach@intel.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Lukas Wunner <lukas@wunner.de>,
        Saeed Mahameed <saeedm@nvidia.com>,
        Leon Romanovsky <leon@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Moshe Shemesh <moshe@mellanox.com>, netdev@vger.kernel.org,
        linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
        Dean Luick <dean.luick@cornelisnetworks.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Moshe Shemesh <moshe@nvidia.com>, stable@vger.kernel.org
Subject: Re: [PATCH v3 07/10] net/mlx5: Use RMW accessors for changing LNKCTL
Message-ID: <ZJMNPzvvRenBH1ur@corigine.com>
References: <20230620134624.99688-1-ilpo.jarvinen@linux.intel.com>
 <20230620134624.99688-8-ilpo.jarvinen@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230620134624.99688-8-ilpo.jarvinen@linux.intel.com>
X-ClientProxiedBy: AM8P190CA0025.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:20b:219::30) To PH0PR13MB4842.namprd13.prod.outlook.com
 (2603:10b6:510:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR13MB4842:EE_|SJ0PR13MB5623:EE_
X-MS-Office365-Filtering-Correlation-Id: ce8ac03c-cf95-4bf8-cf65-08db72664d52
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hMCiNbCURkUd5inbREITYweiAbnnzziZXt45t4Z/8cpXUmuwWlFGjIu9xSKG6cqIprnSMoYrvvWz3i/Wwi9qBPe8+z7HTgU4tP/a2ACsSDI7ajWR7oTC30xqKQ+LABuZz4O505RKDGVi1GeKUFzVsuyXzv0oZZUoa3L1wfcV0ezfKgBc/gcCsT0ZlUOOgCOlMVwSe3njhEWJZH+SYrDrpujo/W75ZpyTtePkPeZZIfcFvbzOVYelPTs6KvSLUl+/gWnoNOKUouqRfUkdMn/819VNL9kK9l02l+31lLTfrgwdmYQ3FeolSyy4b4sATYKD1+frLwt5qxQTR7QE6tGDWW1UteP5+6v+wcxHPx+BSFJ44m+eqEHzVtD1UUal4KPUhMdL/gvFGY6CJZof8xhG1tgvczKeSl+GX6B3lBDyt/VX10BcgxQCJMaJtzBO/irgGnIr7Sh5LKDi+BDce4aEsEKYmJbK8n0kUFGlbsq1qYYdQuUyTmtqJrZERoYlYKHhCLZanzUWNHA4bTHuaXwSjcctwV7lSSx4TE0Di5dnpl3f8u9/s0gqCA54fp+ecAn56pL3fQ4D4Rp8M60enA1owBq4l3VZ4O//mg4tU7mPOSg=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR13MB4842.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39840400004)(136003)(366004)(346002)(376002)(396003)(451199021)(7416002)(8676002)(54906003)(36756003)(2906002)(4744005)(86362001)(186003)(6506007)(6512007)(2616005)(478600001)(41300700001)(8936002)(83380400001)(6666004)(6486002)(4326008)(66476007)(66556008)(6916009)(38100700002)(316002)(66946007)(5660300002)(44832011);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?U0tQc3FmekRQK1JXdTFjZzYrWTRiV0NHWjNtZ2U2OWgrZ2xVd1FLWXhxVnc4?=
 =?utf-8?B?cnpFUlUvbGNCTHNnSytEV0xXNTJ4TWdXUUt1MGphMHU4aDQ0by9Pbk1ObE1v?=
 =?utf-8?B?bExuQnFXYnVuc1lxZytsSzgyT04zSk5hdEt5bll3YnVCTzJVUGZMNWh2VmFa?=
 =?utf-8?B?b0ZEY1pQVUdhekNoeHdSSGNkMlllci9oVjY3OFVUUDQ0elJ0WDUrNVdNNzRJ?=
 =?utf-8?B?TDJRQlYwTTBGVk9aK2UyeXplMkg3dnhBcEZMYi9aWDRhdFduSHpuUHU5eTVD?=
 =?utf-8?B?K3A5L0RxQnBhNWIxQ1NpSHRwMG1xRENTZC9nczU0V1ZWdFZJeUFmK2NDNEJZ?=
 =?utf-8?B?Z0o2cWhEVThpdVRja2ZBY3ZvTE5aSU1mMm9kSzYvWU54MklIb0U5QW53UEhz?=
 =?utf-8?B?L3hnamlxS3R4U0E3Y0xuRUFtWC9FLzg0ZFlJZjRldWpISXFWRUFRRGxvbit4?=
 =?utf-8?B?akZjdC9ldkNCeVkwQmhiTVNVSjd1NEpYb3lsS1BWam1USTU0SHRsdmttYTBU?=
 =?utf-8?B?UFNsL2U5SlV0eUVwL3ZoeUd5N25MZDUvc05qaXRhOEJJSklNY0g2aFVvSTgy?=
 =?utf-8?B?SzA4a05kcitiRWZRODRQeEtJYWxsUTAxcm9Sbnd2Z0IybmlmcFJuV0QvTVhV?=
 =?utf-8?B?YXZMUmRGQS94akNmVlVlalNGeVhwUFJPSlc3Ni9xbGxNOFY2VFV1Y3lLY2xI?=
 =?utf-8?B?WFZUTklaWW5kemIwYUZZalpFS3NmZGJpSmRWMm5MWGJZQXlSK0ZGK0Qva2Ru?=
 =?utf-8?B?aUV4NFNHbjhBRmN1UkpmRmsrem94cmthZjZtMnZaSHI0OThyeHZnbTdkQ3Vu?=
 =?utf-8?B?OWZOYklqeHdJaGR1TVNlZkoxcjJiVWJpSXF3RDFsODNZMm9qMnJnRHdZU3E5?=
 =?utf-8?B?djJ1NVVXTFp6UGYxRXN6WmZtMlEwVWlEK25nRkEzeG9VSmhQQ2g3SnRWZlho?=
 =?utf-8?B?NmJZeXNoTjRPcUZvUGpwNDl5dXJ0WlFPUVVXYm1qVzc0ODVKVUlvOWFDQ043?=
 =?utf-8?B?NUQ0Z3RMWTRIYVFuR2JIS3kvV3dwVUVrRkRoY2tmaHdvUEJTT1V5MGpjbXRz?=
 =?utf-8?B?d1ZoRjZLeDNMODZRdmJYT2k1UDVnTmpweDhwRlp1ZmpJcEsxc2RUMGVBUTNN?=
 =?utf-8?B?b0dXM2QxQmUrejZaMlc2OU44VlBwVWZHSmhmLzhZQytaVTFHSXhjRFlsbDFr?=
 =?utf-8?B?UE9rTUJnR1N5MmRSN25wZWtZcm0xaXdlbjYzMUhMMWVsV2Z1ekRLbGFmNUtM?=
 =?utf-8?B?V3JwWGVSRnN5TitRYUhramJ4OWxHd0hzTnU3N3hWWC9NSDZWcjlSZ0ltalI4?=
 =?utf-8?B?TWxzeWErR1o4b0ZNZ2t5bmN6TWV0MnN1MGtmM0dCWkcyaUJQaDFMT1VoZk5m?=
 =?utf-8?B?SXJtRTVleUJ1SnNoZDk5b3JJMC8zekJOSnMyTG5ObmU3RHJYUFdocmc2c2h3?=
 =?utf-8?B?M05sNXI5YmE0ZzU2Y2NuRE1wd0pQYlpYOGY1dm1Jbkc4TXRDcXM0ZVhaUTdN?=
 =?utf-8?B?eUtKZm1Yc1kvcVRjZ1J6OExENlFpUCtFMmJPQUZmc0pOSjBISkdQYjdZZmhX?=
 =?utf-8?B?Z1N6Zk9rTlhQWVM1MXhpZ0d6ekxsdjhxdHJrMkRpajBLcG5EcVJsNzc5K2pV?=
 =?utf-8?B?RXhWd1ZiMVZ6WUt4Z3VxaC9mTWprSWhKd09mMHVQeGdlNEdkajBjV2QwOURD?=
 =?utf-8?B?NE1uTzlIOVEwTW5MenAyN2pvMEZGWmdyYVBJZ05SOEF5RHptazFzQ3VpMDZq?=
 =?utf-8?B?Sy9WZU96MElHbjJwYzZYeklXY1BZTVp6c2wrVVpvUWJETjV3NFFtb2orNWds?=
 =?utf-8?B?YnlxTlRuRlhsSDFBWktPUENxaEZSNlNJUUpFcmNEOVY5citYcVFYUlg3Z2Z4?=
 =?utf-8?B?WmMvWWMrNDdXcUJEN2tadFVKVFkyQStuQjZxTUQzZGZFRWhzdlJFVmlqVFRs?=
 =?utf-8?B?QnhlV3phcld5M05TSkpQQVFONHU4S1RsRjRpdk1McGhteXMwb2JyWEJFNENP?=
 =?utf-8?B?N1pDWEhVMjRjaEMxTzZSZDFNa21EbjZBRytLalV2a2FnRjkyS1c2a1Fhakxv?=
 =?utf-8?B?OTJSUjZ5T3ZwaG0reWZKbU5vQy91WXR0cVFQTDNqWDlxYmNqSGNLdVk4YSsy?=
 =?utf-8?B?Mi9VMFF6QjVaZUFJUTN6RVo2eHFTWllvZVB3UTBmblg4LzdUaHF2QmpoUDNE?=
 =?utf-8?B?Q0lpNXJSSTlGK212ZzJYMTQ5Z21NK0JreCtKSGllYnZ2N1YyRzEvTCt4MHJk?=
 =?utf-8?B?TVJJV1YrUnZnTXJyNnJEanZ6ZURBPT0=?=
X-OriginatorOrg: corigine.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ce8ac03c-cf95-4bf8-cf65-08db72664d52
X-MS-Exchange-CrossTenant-AuthSource: PH0PR13MB4842.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jun 2023 14:46:31.6736
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fe128f2c-073b-4c20-818e-7246a585940c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: C14AC+VYW8JRT1V31jWS0ckQTu733REpleWczRicvidYEhMsKiQJD74kbrsdIxcQJjReYDOcMJmZ6HzNMDq+pMGQnbvC1Vfn5gEaE3Bq/wY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR13MB5623
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Jun 20, 2023 at 04:46:21PM +0300, Ilpo Järvinen wrote:
> Don't assume that only the driver would be accessing LNKCTL of the
> upstream bridge. ASPM policy changes can trigger write to LNKCTL
> outside of driver's control.
> 
> Use RMW capability accessors which do proper locking to avoid losing
> concurrent updates to the register value.
> 
> Fixes: eabe8e5e88f5 ("net/mlx5: Handle sync reset now event")
> Suggested-by: Lukas Wunner <lukas@wunner.de>
> Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> Reviewed-by: Moshe Shemesh <moshe@nvidia.com>
> Cc: stable@vger.kernel.org
> ---
>  drivers/net/ethernet/mellanox/mlx5/core/fw_reset.c | 9 ++-------
>  1 file changed, 2 insertions(+), 7 deletions(-)

Reviewed-by: Simon Horman <simon.horman@corigine.com>

