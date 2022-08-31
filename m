Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6042E5A833F
	for <lists+linux-rdma@lfdr.de>; Wed, 31 Aug 2022 18:30:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232047AbiHaQaz (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 31 Aug 2022 12:30:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232042AbiHaQay (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 31 Aug 2022 12:30:54 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D06A64C6
        for <linux-rdma@vger.kernel.org>; Wed, 31 Aug 2022 09:30:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q49FkXSU3u3sdkFfYtvBvpEKVgUk16Up9BJ6lTofQZML0+juKiVVuAJEfdeuqXk+rOeg0pR+gm4WNnhfVg4TmP77lI1yPlttUmYH1RaBtsD6+8muVhAy7+eGEDz2r0ye9YkGDw7EeG4BgKv1DvUSQnkUxF28A2BQoef8xHChYo0icM31k2L5b/xa4Quor4dBcXUP/1WO/r76AWRLvbz5xT9+GCz14c+c1nUrR+5FBh17IWX10o8BsuLxqksJl+rC75NSFSpufVcm7+hSRpXmq0edS9EeWymbLUb5eyQPCcP1eZ1syRzYRe6wb2QivxDz0wnYAXqNHURMAYhkBZ3unA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fBC9d+Gd/gX5WOeZZ665AQkJliFTx+g8PNWNkj2m3t8=;
 b=kKvVFMeijEmhTxshyEFfy+HQGFAROJylXA24G7VK+VnN9oE3YGispoZUk1PxqgTW+bWL2BP7kZyZ1/fUOBqhPI8F8BBMD5cOHFd/+b8BCg7tfZNDDLvvGmi8tkPEUpCgCGTO7uOoyg9ZmoF6e1jOFZ2FtajUKeR93ADav6f/tCxgX8/LmaYy+SyUMAy7QqnCbjyTn0G4xO2oEmy0dPSMsXRgt6gCi1aXHVyb8SZ7NQ8YBomWgTA0dYw4x1YXO37Ix5yA66rkruB1FiKpkH8sc93Bu1RdvUK0/ddTrTbszaFSgFnaVIdhYHOePFYkffMafILkvRw9OPOjxUECIKmf/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=talpey.com; dmarc=pass action=none header.from=talpey.com;
 dkim=pass header.d=talpey.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=talpey.com;
Received: from SN6PR01MB4445.prod.exchangelabs.com (2603:10b6:805:e2::33) by
 SA0PR01MB6236.prod.exchangelabs.com (2603:10b6:806:d8::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5588.10; Wed, 31 Aug 2022 16:30:51 +0000
Received: from SN6PR01MB4445.prod.exchangelabs.com
 ([fe80::701d:e406:dcfa:118b]) by SN6PR01MB4445.prod.exchangelabs.com
 ([fe80::701d:e406:dcfa:118b%4]) with mapi id 15.20.5566.021; Wed, 31 Aug 2022
 16:30:50 +0000
Message-ID: <d366bf02-3271-754f-fc68-1a84016d0e19@talpey.com>
Date:   Wed, 31 Aug 2022 12:30:48 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Content-Language: en-US
To:     Jason Gunthorpe <jgg@nvidia.com>,
        Leon Romanovsky <leonro@nvidia.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Bernard Metzler <bmt@zurich.ibm.com>
From:   Tom Talpey <tom@talpey.com>
Subject: [PATCH] RDMA/siw: Add missing Kconfig selections
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN2PR20CA0013.namprd20.prod.outlook.com
 (2603:10b6:208:e8::26) To SN6PR01MB4445.prod.exchangelabs.com
 (2603:10b6:805:e2::33)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c3ce9604-f84d-44e3-187f-08da8b6e2ac3
X-MS-TrafficTypeDiagnostic: SA0PR01MB6236:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: V0FGlKNnfA5Db7PGrKKbnJJodRlJD9OvhGjVb5dHJvRB+8FQtnfMr7us1zNyczn5FtC+csBmvOKBsnlU51oQx1+bSaAUQxh5WAsRMYsvRxAIzUEAfBYNExKQVDGsy9XGx4iHIxmBdLatJxBGLyQgXz0GceSZ2K7Vl+zzQo9stgSUxA53U+kJtuoGfz6YMpdvmkaAg3fjaSYWu9WciiW+ZLP6uQ257iOSBQo5xDqPEbnEQ50RP0qjEVew/EMAauP1Lj9/Z4b1keKVgBjmIoLEzGtnR5RfN0odgJpX5p7anS4wBfX7ZjD4UMWWFAQb+FFV0UsO7c6lb/IPeNVtOI1PSv1jnmr4pNOMfO1+cfrQYw3yGT2/srKUUju4DeRwaMsNl4uHNKyge9UDHUGyd84L+prz3F0TzlA2TuMea1VS50mqKCQV9nzxECxk53MeCR3WKeaS8B17V+2snVlLj3bzPD7NcVbryQnT2m7p0MXwEHZUloqim5CunbE21goT+RwGRm7RSoGlD/qMuqGKhk9lOv3Iv9x8qD3PK3Vu0xHV6K1tPd0GMiT5S4m6BxR182nSk+tutRN+ZBInCzcdEi8ZzjLC91MpuyAAXxKGZPaOJXGYhNXGzmZIuZQiaR2AsLKSG7chmHk2xDKbhd9t6z+HJCWwL7Yu8APgumXodcQscM4LeBORFSDEiZPcc091CQzdq4a0Byv/kd7MrbPxTL7IUbWMIW6baG5Fl0iOi/IXckEiiHT2sZ+cMZfED2G/h8LQTPpiM/N/JQROHBUbZY5zR49ALvyZgteySA4O9IBmP9I=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR01MB4445.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230016)(39830400003)(376002)(346002)(136003)(396003)(366004)(8676002)(478600001)(66476007)(6486002)(66556008)(66946007)(2616005)(52116002)(86362001)(2906002)(6512007)(31696002)(26005)(6506007)(8936002)(41300700001)(4744005)(5660300002)(83380400001)(36756003)(186003)(316002)(38350700002)(38100700002)(31686004)(110136005)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RjhxT1B4SWZCOWxpWVlwb1dSbWRZOFRFSk5tS2FXWi9odlo1RXBqalk3OXY5?=
 =?utf-8?B?eUNlS3l2MHdZL1NpWWNFK05QeEM1YzhNOWNwSFNDK1pTeVM5TXh2L0NJc2FK?=
 =?utf-8?B?Ym5qUkd4cHdaM3VwYm5yVDRabkxISW01aXozQXNXNGp6TzBFWERQc24zZGRN?=
 =?utf-8?B?YzdxNHh4RWJnbVdrT0dxRkdUZjNhWVU0bWJFN3BkVGJYVFUyZFdhclNQbWN5?=
 =?utf-8?B?VXFMRXVpMWQvaTB5UmU5UVN6K2ZjR2YyK1podVByYTlVUTBTdmRsZmlCK2NP?=
 =?utf-8?B?ell3NG9zckIvcEtrYzRXNStTWFRodXNWOVVJdllZSmNqckViak54V29iSU5S?=
 =?utf-8?B?a2tqYWlNQS9VVXdNY2xCeWludzRMYmpPbWI4eWp5Rm5KTXc5MDZzVzZlOFQ2?=
 =?utf-8?B?MVErUVcrYzBzbGdNNmhKN3VWbEZtMk9zSzhEY2hXVm5SUzJKUVNoMXFMOFBI?=
 =?utf-8?B?Y3YvK29KOWZkaC96aU1vTG84SEZucjRDTU9KT24rVHIzQ3JCQkNDbVVjOUQ4?=
 =?utf-8?B?aFJFeWt2OVUrRGEyMWtMNW9RQTlhKzdIb3dnMmRpV09wWVZSeCtNYXZDUy9z?=
 =?utf-8?B?cUFyQWdJdHRaN1c4T1pDMWFMZlZwWFp2a2h2WGc1S0l0S1hZUDlYMXNOSTZ2?=
 =?utf-8?B?OENod0ttYVR3cVliU0M2WjFYaHJxS1RpNWNWTUk3cVU2SlBRYmxwMWZOdGNi?=
 =?utf-8?B?VG9LNXJlWFIyMTd0ZHltb3RKZ012TXNxMzhYUDc1bStMbndiMkNLbVk0THlE?=
 =?utf-8?B?eERvVG9TMk56Tis0VEowQ0RnWHowNWVWTVlMZ0lES09HWnBZdkRyQ2VGYW1H?=
 =?utf-8?B?SmExejdpeDNqTlpCVnBJUisrbXFDQTI2ZVN1YUUxWHVVMUR6dHpCNlFTNTFJ?=
 =?utf-8?B?UlRKZC9kTUM4R0MwOGJrT1pQZlhhYlJkU0x6cElVSTVBWDVabFZyaVlrTy9X?=
 =?utf-8?B?K3Nrdk1NZlgyQWxJekdEQlV0YUhpaFNKN3MxV1BQVUF1QWZMUEt3SWNjKy9a?=
 =?utf-8?B?MXFlZWp1TVBOUFZLNzZhNHRldWtVTVd4aTB3bytKUTdDNGtIZ1pzM0cwck1x?=
 =?utf-8?B?V0Qrc2N2Y2hZVWFNcEpLMXFhYm5Oc0ZqNk9HeDhyVG4wcEU3Z2Q1Rlpaa1FO?=
 =?utf-8?B?dUJGZ1EvbEdqOXhRNCsyNk9CRHdCMVNuUDMzREpRbW9kWnZiTzJPRms5YnVK?=
 =?utf-8?B?NmhWSDVyV29yeGxpOU1SLzlscVE4TlhXL0x4TU1rSTdNZUtuaTdveUFLOHh6?=
 =?utf-8?B?YUpaN0hTZDJiY2x0WC9wYUQvZDJZWm1GbU9KaWR5S2hhWGlUL2kxdWZ6ODVS?=
 =?utf-8?B?M0I2M2tZWXpNc0JQTVBIYkl6UmJXUklsNmNlcVY5bUhsSE1RT0RucjhKam1u?=
 =?utf-8?B?VUZvL01KTVZqMjB2c05DazRLZU9aUEY3ZlhuM2w5d2JJUWxlOStROHhnclhK?=
 =?utf-8?B?SW5iZnhIbmFBNHA3Q3YrMS9yZ2tLQ0VDSFlLNm90Mi9FTHRXUUZoV0NNMWlG?=
 =?utf-8?B?WVZHaEpEc3g2WkVmZ2QwNFU3NkpLRGRZdmtSYWJPeXlqbEhRMXMxTE9ubzdk?=
 =?utf-8?B?MkNpMEpBdjVCWG5jckhyV2xrdkVGMEhTUThJRTFRamRKYjlhOUdLa2RORWdr?=
 =?utf-8?B?aDVCbUlUcldqTFlrYlhucmd5VVBBOHgrVTNDUHA3UmwwRFlEQXJCbXhvbFFF?=
 =?utf-8?B?azVBdm5NZ0g3SUhxR2pQZExmNW5UaWRpK3FOWDZLUG5TMkVJaDM2c3Y2KzBZ?=
 =?utf-8?B?VVFiZ2czQmVCYWdIZThqREZ3TTE0TnNVQnVaV3Y2cjB2SHprSU4yTjA2OUJo?=
 =?utf-8?B?eUFIZVBKMTQ5ZU5KbXdIUEh4dVMwQmlNRkJjNlZkZituRTd0cFUzUWxPTXJp?=
 =?utf-8?B?eEJZTDluVUZWRmxveTlKY0NiTHNRQXI2VDZZaTZmVm5LUTI1TkpaSXY0Zzll?=
 =?utf-8?B?a01rZnVQcjh2N3duTmkvelF2UUxIdmJxZ1ZyZ09JWWFMQXRkcmpYbUJxenF0?=
 =?utf-8?B?aWZmdnVHYUhLKzNzeDNXaXRHRnd4YURxV21ySGNmazVXMmJWYXg5eDZ4eVlR?=
 =?utf-8?B?aUM4Sm5HVC9NMHU5Y3VXK0c4M1dpRmUrWHEwc1REMHRUbWpreEN3cmhPL0c2?=
 =?utf-8?Q?kN35XoU1Vz4U4vlQjTuSaCdXm?=
X-OriginatorOrg: talpey.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c3ce9604-f84d-44e3-187f-08da8b6e2ac3
X-MS-Exchange-CrossTenant-AuthSource: SN6PR01MB4445.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2022 16:30:50.8157
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 2b2dcae7-2555-4add-bc80-48756da031d5
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9GrD+nidgl6NIgKB2Gr7afylofs1l8v5Cv0WziTfvh9+WUP4ImHYAoRJIcdZ5Lai
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR01MB6236
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

The SoftiWARP Kconfig is missing "select" for CRYPTO and CRYPTO_CRC32C.

In addition, it improperly "depends on" LIBCRC32C, this should be a
"select", similar to net/sctp and others. As a dependency, SIW fails
to appear in generic configurations.

Signed-off-by: Tom Talpey <tom@talpey.com>
---
  drivers/infiniband/sw/siw/Kconfig | 5 ++++-
  1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/infiniband/sw/siw/Kconfig 
b/drivers/infiniband/sw/siw/Kconfig
index 1b5105cbabae..81b70a3eeb87 100644
--- a/drivers/infiniband/sw/siw/Kconfig
+++ b/drivers/infiniband/sw/siw/Kconfig
@@ -1,7 +1,10 @@
  config RDMA_SIW
         tristate "Software RDMA over TCP/IP (iWARP) driver"
-       depends on INET && INFINIBAND && LIBCRC32C
+       depends on INET && INFINIBAND
         depends on INFINIBAND_VIRT_DMA
+       select LIBCRC32C
+       select CRYPTO
+       select CRYPTO_CRC32C
         help
         This driver implements the iWARP RDMA transport over
         the Linux TCP/IP network stack. It enables a system with a
