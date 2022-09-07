Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 121075B0599
	for <lists+linux-rdma@lfdr.de>; Wed,  7 Sep 2022 15:46:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229750AbiIGNqR (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 7 Sep 2022 09:46:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229747AbiIGNpu (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 7 Sep 2022 09:45:50 -0400
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2058.outbound.protection.outlook.com [40.107.100.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F480277
        for <linux-rdma@vger.kernel.org>; Wed,  7 Sep 2022 06:45:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aO9NeeHe1sPJ80V/tq4CnICwYa8fS3eZXDEoVDzbP3Hy5TtBd0pw1C/sSy0bFpSOQUXcRrA26xbxtnClLj3jWxe/fquVNd5M7hcpihBQnEeWteuxx0hCE8AErrNO78I0VcXXSDf7HIrdcetH+KLMm8Ndvfor1x+HlZPYXb45p6oOmiX9iYvVV5fmwqqTvcCQT9eqkmWqv+Z/ZxrnkLZDbfaEQMwCIOKfm2ARLzJ0Rkx9CAPYxHa2O/LQVz8ZR5I8lWpo855Ba5JWBA7coJC0WmWL/lyIrBDjDzcC5LW6x8QjSNWvo3DGvbGZVv2F35J7Yv3zdoHG+YeV6AzScozI+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ClFRrXXNwYj3osJFi9D/Tu1K94DMDk5Pw9rxnoWE1y8=;
 b=Sf+MHiRnTJckUX0BTMoH7K+NSdImIzjHGU+pS8SlLmXqwaPl+D8qbHYcsW1fPezbFsVwn20zq8ExoEX0+vbPQC3N1cad0vcaAFDbIIfggu57PGDMsIjLZADCqiSfqPnuHCsODd/k3s1PyqKZK+IS3CG6BhD7csEdnk+ekV78qlo5V2DqWo+qAgWK3kJY2/qv+cyELT1uG2rCr8YyuW7Yhs2OU/ePkKoN8lMCZkD4ueAntGqItWo0c/hjunQ4NOdLx0wpav2KhPIWf0PriMgw+n5ePPZdpXuhsDIDZzgeSPS1GEj+NxK4TBMHabGAG5tG9CibrABOdNhqMS+igcFSYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=talpey.com; dmarc=pass action=none header.from=talpey.com;
 dkim=pass header.d=talpey.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=talpey.com;
Received: from SN6PR01MB4445.prod.exchangelabs.com (2603:10b6:805:e2::33) by
 SN6PR01MB3645.prod.exchangelabs.com (2603:10b6:805:19::32) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5588.14; Wed, 7 Sep 2022 13:45:10 +0000
Received: from SN6PR01MB4445.prod.exchangelabs.com
 ([fe80::701d:e406:dcfa:118b]) by SN6PR01MB4445.prod.exchangelabs.com
 ([fe80::701d:e406:dcfa:118b%4]) with mapi id 15.20.5588.018; Wed, 7 Sep 2022
 13:45:08 +0000
Message-ID: <4e7574d7-960f-9f92-e92f-630287f1903f@talpey.com>
Date:   Wed, 7 Sep 2022 09:45:07 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.1
Content-Language: en-US
To:     Jason Gunthorpe <jgg@nvidia.com>,
        Leon Romanovsky <leonro@nvidia.com>,
        Bernard Metzler <bmt@zurich.ibm.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
From:   Tom Talpey <tom@talpey.com>
Subject: [PATCH] Add missing ib_uverbs dependency from SoftiWARP
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN2PR16CA0005.namprd16.prod.outlook.com
 (2603:10b6:208:134::18) To SN6PR01MB4445.prod.exchangelabs.com
 (2603:10b6:805:e2::33)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 282fa774-e1f5-49fd-fada-08da90d72da3
X-MS-TrafficTypeDiagnostic: SN6PR01MB3645:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AUm6tix9lJ0AByOe9Xw4lpyISKkAZ7h3R4RdyZDUs2sYks8rbDfMnRkVBuMxaR7eWX9J4yOjqrhOaz8eh0Z7hIPts4ytUHTUxU7FV5CbsezgVLIxG9nGBJ/tBJZAyHTv0IRthre9RU5A+TwROfulaWrOd7o1RDPbK9SQfTeSIFoeiELFf0K8xz+iMa0YWM/tHtvv+pfufQihOTusifwz/1HRFtLWa9XG+HO3BbM9vxrbqyY/bOAMG3el3G326LKKW3Hm1gQQwz8UQGboskfHH240feO69HRRgIkJXMDoIRLeeoWo/m8JT3xIr/2zmL9Q108oftLGVYvg/ZI7mp7AKQRljOjyeSMRbT7u547VZi2OlBHRBO9PuT8k/JvPEq8ZnPfQzzj8Fbp9JsE2fk2oNOkfsCRhM822q9U/Gc1poxj9DFaoT3vsgugM+/388Gi2Aa5EM7Pf86huNiCQSGsWmp3Ui7Xy9aHCWbHoqfZLcxGUx+LCvGJIn2K+KrrUTWxGr6Uno/hJ/oz/Zf0deJo90KjQLA7Lm0HxJNmTbRur37aekc2j4P8WmEKo/vP7BL1yIT3Ya/jXjFtp7ChCf+1zZh/ZE5LkLnlGOPWUar/gpBuo2RQ5XtTlga7dQTAMV26PnJqpKYy1AnHGakar0Bjl6GkCflA/lyBu2NNSt622l1pXpENaRzXpe/Z8RsADt522C2bVlRNrWvYrZQWIBzRETUvz2brzwi1cUNXiHZ8HQk6o8Z8+29na3xN1fde/uE58UidQLOnS01sS0RmvClp1sBEbwR+KSFDPEsISL0DZ5xE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR01MB4445.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230016)(39830400003)(376002)(366004)(396003)(346002)(136003)(26005)(316002)(66556008)(4744005)(5660300002)(36756003)(2906002)(8936002)(110136005)(8676002)(66946007)(66476007)(31686004)(6506007)(478600001)(41300700001)(186003)(31696002)(38100700002)(6486002)(2616005)(38350700002)(6512007)(83380400001)(52116002)(86362001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VGNPOEFkYVl3VkVSNGtJemNUQmgyZDVmZFI0cnhuQjBoUkZNbFkrRytTZVBr?=
 =?utf-8?B?aFU4WDJIWkNGZlVIcU9yZlllSjFyakJQZGZYdVFkTi9mWWNmVklaVGFLRHd6?=
 =?utf-8?B?eFNHVFl0M3had2FXMXN6NHEyY1VJRTViMFZsazE3TExFWld0ZnhwamtBdnNa?=
 =?utf-8?B?bHgzUmVGK2ZmRHZKTDN5VFhMaEFRRE5sbVBpUnJwR1BJa3dVOE9xZUpRb2cz?=
 =?utf-8?B?S3B3QVJlUVNkYmNMUEpPWDNSVUlYN0lNZnlmL05nc1VjekFSc1NtMDRvQStx?=
 =?utf-8?B?Nml2TlZ0YUFETDUwZWo5c2FiSy80RXZWSTFqQlZmVVRLN0N0bWEwRncxN0JU?=
 =?utf-8?B?bHZsSVZzaGZiZWJ2SXNxY1JyZkh1U1RMcjFOQ2t0QTBYN3M1NnZPbUMwWkg5?=
 =?utf-8?B?Nk9YdXYzSllDeEdsNjZHRVYxNk05T3JkclV2MUh1dlRjbWI3L1NRUEE3Rm51?=
 =?utf-8?B?U3hVOTVham1YWVUvdUNXczRPOGpHUWlsdFBrbE5ZQ1RGb1RPNlBjZUUvb1cx?=
 =?utf-8?B?Ung0cUp3NEpEL096ejhUT0wyeVZWZkVFM2I1UHN5V0I4ZjBSRlpxOHJoaTdS?=
 =?utf-8?B?ZTBBbnBQanMzdkd0eXBDckRwUWRlSmcrT3F1akVPbzJBSmdzTUgwY2IwU1h5?=
 =?utf-8?B?NUptUDl0dnpYSExhbFdYMktybVU0QlZsN2Y3ZWRRNSsraWRaN3VnWTRiZ3g2?=
 =?utf-8?B?RzJCRHJHTU1kNC9zeC85Ni9wYkM4Zyt0Si9qME9EVVFISGxaTUc1SlhzOU5o?=
 =?utf-8?B?ZkhycHRJWTM1ekoxVmZGbU1hd1NqQXVCdjVEdE5VZkM0OEdlL29YTGgrUjVG?=
 =?utf-8?B?MkhZV3FUMWZ6djhjU2tselhCRVVoSGNrY0FVdUkrQmt0em5rdHNDOGN6L0NY?=
 =?utf-8?B?TVI3blRodDNSeUdZL1EvOXZIa2gyVCtNS2ExQ0RKK2RhbVM1MWZ0UEhkMlRN?=
 =?utf-8?B?UnFLaEE1Umo4ejhRZXBVS0xYT0h5NURvOTRPekpDZlNPU2NYMmFtbllESHQ3?=
 =?utf-8?B?OWxUZnNuUXB2K08zd2JJZGFQOXNSdXNSOVJIaEptV1VlZit4T08yb2psNG9F?=
 =?utf-8?B?RUlxS0RLcy9JZ2N3NXN0UFYyRGN4R3d6WHlwRmxkbGVUS0Ntd0R1MXoydTBR?=
 =?utf-8?B?RDcyV3h4amRZaFZ1c0s5T1BYWXpjNGNic2VHd2NGMDgyY2ZLc3ZpNmw0Nmla?=
 =?utf-8?B?c1hqMEhZaXdyTUZnOXpiNW5vN2NGZWgwUGZFd3o2UGRwWHJNSVhMRDM5aEo5?=
 =?utf-8?B?QllTNCtFb0U2TnJhamZKRVVuanJyM0ZiSkJQUjlES1p4Q0dzQmJobWZGTFdG?=
 =?utf-8?B?VVJrbHpkTmtBaTRZQjZ4cDl1ZXhhZExPTXg1OENadGNRU29MMU5tNlB1Tllp?=
 =?utf-8?B?VnBlVnUyYkt4bGdsTUVnQnVFZmxYdTJybmZ6Zy94K05YdGYvdzVXY0d5SjZE?=
 =?utf-8?B?N3UwUUdIUjZVeEtFMUFhdXh1STUzSnUrZ3E5a3g0aUVteU5nWFJTSC9xZU1L?=
 =?utf-8?B?OFBBYTZhbXB6ek9oYzl4NEN5Z2x2ZG5TN3hHUzV0TnhqVkptbUpnVFI4cDIr?=
 =?utf-8?B?ZXdRckViaWFXMzl6Sk5ITnFGaUJXRldLVmQraW5nUDFzelU0TkdadTlkUHlq?=
 =?utf-8?B?cjU0UkpRY0htaGRnN3RYWnRpenk4ek13TVdMWm50ZWJ4SE1MSXZNWmZ5Mjc4?=
 =?utf-8?B?WEVvWUdENVY3VEwvdkVyTE1JNG1uT2lXYjdURXlCY3VNNG9jamhtSjhRWHc3?=
 =?utf-8?B?S0pFTVhlL0xhWVJqbXdPejFFM3NOVFN0cVRtNlRCQnhTaU1zUDM2Y2FiSXNj?=
 =?utf-8?B?Rm9KSUpTdUp6VGtQWlNxeVNvdGF5K2UxcVV1UGdNRklBeW40Z0FMZTBMNXBD?=
 =?utf-8?B?S2RuTjd6c3puUjA3YnVPZmpFNGlNNlArY0NVemdERlNjS2ErbEVaS1Q2Nno1?=
 =?utf-8?B?ckpWTTFBbnA2b29xclc4U1YraFFVRjJYenRXWkFjTFJzWFFwZldwWFVic3pN?=
 =?utf-8?B?WmRDUU01N2Y0Nk5wcUpibU4vbUZqZ09WL2E4emp6RTBTaDNLeElYUVpwOUFC?=
 =?utf-8?B?TVREanpZdlVNYWY1NjBhcFVJUThEaGtwakM0b2cxWi9HYzdqNSsvd3Jiczln?=
 =?utf-8?Q?+z1QT60Z+gX6ePdGEoQbTpMqy?=
X-OriginatorOrg: talpey.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 282fa774-e1f5-49fd-fada-08da90d72da3
X-MS-Exchange-CrossTenant-AuthSource: SN6PR01MB4445.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Sep 2022 13:45:08.5529
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 2b2dcae7-2555-4add-bc80-48756da031d5
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hyKIbqXQiMNr0NxFh0vfzhiWquvUlaQ1AsZo/sCbrO79LihiwsAXGtAbScgDwRP8
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR01MB3645
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

When loading the siw module, ib_uverbs is needed so that consumers may
access it. However, siw references only inline functions in ib_uverbs.h,
so the kernel linker can not detect this, and the module is not loaded
automatically. Add a module dependency to ensure ib_uverbs is present.

Signed-off-by: Tom Talpey <tom@talpey.com>
---
  drivers/infiniband/sw/siw/siw_main.c | 1 +
  1 file changed, 1 insertion(+)

diff --git a/drivers/infiniband/sw/siw/siw_main.c 
b/drivers/infiniband/sw/siw/siw_main.c
index dacc174604bf..372b37b18bac 100644
--- a/drivers/infiniband/sw/siw/siw_main.c
+++ b/drivers/infiniband/sw/siw/siw_main.c
@@ -628,3 +628,4 @@ module_init(siw_init_module);
  module_exit(siw_exit_module);

  MODULE_ALIAS_RDMA_LINK("siw");
+MODULE_SOFTDEP("ib_uverbs");
-- 
2.34.1
