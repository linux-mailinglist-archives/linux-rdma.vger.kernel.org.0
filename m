Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48189587575
	for <lists+linux-rdma@lfdr.de>; Tue,  2 Aug 2022 04:15:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234368AbiHBCPj (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 1 Aug 2022 22:15:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235563AbiHBCPh (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 1 Aug 2022 22:15:37 -0400
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1anam02on2047.outbound.protection.outlook.com [40.107.96.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF37243E5B;
        Mon,  1 Aug 2022 19:15:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T7CEfqzM69+p37oVc+kV6tSTeiNYzhHSs33tpMEj82rC9ZSRGQFLH9u6FDhlkA0KQxyHd5LmS3lyY/lSE56bPOJ/sAEaCNf0LmbldMeY7psZgYxJZgBH59yeaU2pxQvrKvIEJfY1Fcod0l+O6av6f8s+ulqyZu/bR33nFyeAdNZRf8IusP6JR5u5YGN1tZV9uiM8ncmA+20RczL6dpV1yZW8VBs+VvWiXR8UJE1swDbULpp2qvq63b2o1iCpZXrCqK5EkE1xDWTYTuWLHZXku2x7OKQqYFlIPw9s4DcHfFjD88rAsu1A99+Ge8zA7/8hhUWFj6GLpSnsvU691gXukA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8arb2+TTqc5/pK5Tz3fEPaoa5+BFUmlx/MaDP2M7I4g=;
 b=in/ku/XeB6dKCt9mP5W4v0NFtFwIf4rVbv9PBeNQFpioVl9MJLUulHI+pG8FU0m/xTs+zZoGcT+SjschV10u5tByX7RnocJpfyOmDFQh3zoQV9z4gb/Zw0Re/quVHBwz0IJNHaLdVBWf5gDbPgIwwsokkkyDJJvysP57RXPfC8zG7/N7JVUdxHZt6LcRvwtdaz1p5Ib0YO5MDNM5/xpz11qWvn6vHNBGQJrDpt7nejlycglTsvVNFd6POR/WwP+3WdbDLNzdjtxybSYFTYHnK/d6sGYyEW+aCpkH2NOoYh/S7uDZOdprtXUiGadbwOWEPFHjSyRolVB7TZz+khyuvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8arb2+TTqc5/pK5Tz3fEPaoa5+BFUmlx/MaDP2M7I4g=;
 b=Uskxbd5TwomPTJ3p7wIydpBfOCIC3iWA5JLLBPOdFgzoTKJR0inpMIh4gRybpiW3oztvRlxmjgBC5VRwjO6szNtNxsvU2JFU0acTRXz/irqGKiqQb7j7MwhyE/PQA+ssRD9iwESokQ9Vvr5/emHTJkAyhAvjFMcTYIVeIQTYGP1oJaXLf3wLncIX7g+hGOw1zCJxIlvBdg5FnLQMde+GL8BdOhUV23eDU5vGA7EwqP2zk0fKyNgcrScCKmKy3G2rYjjpLsaKg6ZWwe9rOnaqA4kTSQTiKdJUQmBA69WPa30fDFeTyVGt1hd4+vV34JTBjweEb7C3LzuxJ8zm/mtD2w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY4PR12MB1366.namprd12.prod.outlook.com (2603:10b6:903:40::13)
 by CH2PR12MB3718.namprd12.prod.outlook.com (2603:10b6:610:2e::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5482.15; Tue, 2 Aug
 2022 02:15:34 +0000
Received: from CY4PR12MB1366.namprd12.prod.outlook.com
 ([fe80::dd48:8d3b:7eac:ea85]) by CY4PR12MB1366.namprd12.prod.outlook.com
 ([fe80::dd48:8d3b:7eac:ea85%11]) with mapi id 15.20.5482.016; Tue, 2 Aug 2022
 02:15:33 +0000
Message-ID: <fdc5931f-5794-1770-0a5d-7470965cf390@nvidia.com>
Date:   Tue, 2 Aug 2022 10:15:24 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] RDMA/cm: fix cond_no_effect.cocci warnings
Content-Language: en-US
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Jiapeng Chong <jiapeng.chong@linux.alibaba.com>, leon@kernel.org,
        linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
        Abaci Robot <abaci@linux.alibaba.com>
References: <20220610094530.28950-1-jiapeng.chong@linux.alibaba.com>
 <e187af34-d0a8-55ed-cc21-d88845ec1eb5@nvidia.com>
 <20220624201733.GA284068@nvidia.com>
From:   Mark Zhang <markzhang@nvidia.com>
In-Reply-To: <20220624201733.GA284068@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR01CA0119.apcprd01.prod.exchangelabs.com
 (2603:1096:4:40::23) To CY4PR12MB1366.namprd12.prod.outlook.com
 (2603:10b6:903:40::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7ad79284-962c-40ac-0a56-08da742ce139
X-MS-TrafficTypeDiagnostic: CH2PR12MB3718:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aerW/v6cZBzbCotX137uSyUZcPDS36CQFAE26KKykmdd7n2cKkQCtv52NIpX49BSlw2qc4qgB04a4M1nF0EbBH6x63rsuzM02+IZ/ZjgWDbNi2Ib1y+eKh6ZsOhpP6Fh0GJ1JgAG0hOilwuuXEMzsCh8JbbpQElFwUfvxcMyv3HtGySGVL8mGusUFoxLl/yByxNYhKUY/kHFWdHwRaBqA5DlGeOvOV0vxK6C9DpvZEdCIpgq2gWrWzZ8ntf/K9CODgSdNHEXhp3NmLo7OsnUu2/i54bCIO6c33plMbB2JGqArJLlw1MEo93KYdat9ycFtImvoWPen6hugsT39dLTcwXDxOvrduREZktHPpyqsyA1zaa/aTeQ2lH/5A5LUOPIRUNahm0JplVxYivrKfy9yahf5IsoYZJT+URGaInUP0+xe9TPV2BOy4WkiZOIdRNgia3D79XP4vSdJTc7XTlP38ehQEOsbuR72+yVS/bJWdgvhfc1IzQX33Cm3kc0M1UrNAh4g78MQ4DAj2y9U9Obt5KFJFvI5Hng6Yz/5zRMrPtTT6oYqcr2aFSnVThdaiFVOSmjOtwG8tu8dqcFXW8dOmEgr1emi5KQr7CCjm5GY7pk98f+VfNjreAqtA2o37GPlEporz8AoF0qaJCS42mKJHvT5n9CVOmA644GfAuoy8efv9rcXeYzqV5H0pD2EgdR9Xkg+63Jjf/2ra/jKw7jS1BK7bh8eXsKruqG3UlKw5aIrbrZmxLSf7DMF3DxoYO1KgRVjjfcgFTBLEYp/Vu8rP1gDMn0D5e+FSU1I4TeYXWd6Fpsfo3EuvU32AVbUc/zJKvasDcM8NiRBiPfnVpm6g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR12MB1366.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(346002)(136003)(376002)(396003)(39860400002)(6506007)(6512007)(26005)(38100700002)(5660300002)(186003)(36756003)(31686004)(83380400001)(31696002)(6486002)(478600001)(66946007)(86362001)(2616005)(8676002)(4326008)(66556008)(66476007)(41300700001)(6862004)(8936002)(6666004)(6636002)(316002)(54906003)(2906002)(37006003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Z3l6U1FFanBqazVuVVduR1hUejJDZmdTV2ZZK2hUWllkTG5VTmxrNGRUU2F5?=
 =?utf-8?B?OGJlZ3ljdHU5c0dUWHIxODZ4aWtvemJUNHJaZ0g1NEpIK2VMSWpvNkovYnNp?=
 =?utf-8?B?a2RwcmN4YlF1bFArNDJGZTNrL0h6dVRvbFk0VW9nVjRCOGw2K2V6Y0xHc2VZ?=
 =?utf-8?B?SVJnb3d6ekZzRGpPZnZEUk4wbldwaVhhb1NCME44TTZLMzdzaUJ3TWg5S2VQ?=
 =?utf-8?B?U1Q5R3d6K0RaL3BPUHlSbENqeERZRHFBQ21SR0VLUUpIZE1qWFVnOXZzc3RG?=
 =?utf-8?B?Wng5NzRNR2lVNWR3elAzV1p6aUhocFRyN096Tm5WV05XNm0waVRwcENjZ2E1?=
 =?utf-8?B?cHlSTnFWb2dzRHlodHlueGhKUVhJTkZwVnhCUTJldXlyNWo0RGZsLzNFcEdl?=
 =?utf-8?B?T242UlU5ei9ORXFPamRSSzgrWU9WS2hOWGdMbDh0OUVRRkdOZ0wzNlp0V0dM?=
 =?utf-8?B?My9qakZJeVhQMGE5QkVoNG1mbFgxcHhaU2hhbjVpZjUwKzZuTVMxVU4wT0Rr?=
 =?utf-8?B?WHhhekt5UGwxeHNUcEcySnd4V0d4Y2xjK2QrTVQwTXJPQy85Vm5ZcUZGR3do?=
 =?utf-8?B?eiswRWYwNVIwWTlXYVg3b3hKb1V0WnliekhHd2RoelZUUVhVb3BWRmIwYzdl?=
 =?utf-8?B?TkhNRGNaTUhZUzZ1Mk5mVzNhdWYyRVVOdnpHclMxM0ZGWndDY3YxRm0yNDJB?=
 =?utf-8?B?UXdFazRoZU9ZVHhiaXZqYXU4akljYkJBQ2ZuNC9hKzRCa0FXbXUvQ0tlRi9X?=
 =?utf-8?B?V3NKTWdvNmFtei9zeVMyQXhlMW9KaDQycWIxaHFIZ3kvckdxcUJKNWNMemFP?=
 =?utf-8?B?QWlaUFhlWlFtT05vVjFtSVMrbDJNMkQ5NlRZT1BFUFAraDhYbWFBcFhHYjRX?=
 =?utf-8?B?Y1MrT3FOV29Ma0lJT01MWUliakFVc3ZydGk1MjdYN0dTNkdEcTFaTXdpYVNt?=
 =?utf-8?B?RG8wWEN6MklKbHhYN3VYa1JueHk4YlRkV1lISXI0VnpaTEhWSFJLMVFpWGRq?=
 =?utf-8?B?eWVKQ3RaclJmcGdqa29CMzM2SzlqVUdqU1JPall6SHhiTW9yYmVGTTdLTk1P?=
 =?utf-8?B?bW1GcnBoL0oyQjJ2U3ZMY0FER0Z4RE8yQlJudXdYNjd4djNGbzFGMFZyYXVQ?=
 =?utf-8?B?ekZQSGJGMFRha3NFZFB0c2Zocjg0NGtIZCtXZDVZWFM2cWdpNkNra1ZRaGox?=
 =?utf-8?B?WkR1Ty9WSmd2a05kOExRMFl6L0lsdWc4MEJlYUxGNEVDWFBPTGJCbnR3QW1q?=
 =?utf-8?B?WURxZGdJS0hjV24xRU1BWnRaWTh2TTFqR1J3SWJydjZjWFk4OXFMcys1eGg4?=
 =?utf-8?B?UythdDhJZHpjckNodVZsUWxZRVF0WG9BY0pkYlIxY1JvTzdiSG01WkJHYkZj?=
 =?utf-8?B?VkRlVTZqU2pIL1FaU1VPaGx5RXNTNWt1SVUvTFhDOU5ObTI3SmloTHZFbDlz?=
 =?utf-8?B?ck9RN0NleTVYK1dpWXI4dWIrd3ZBYWhmQ0RvUHN2QmhwRUIvclNuY051WFJW?=
 =?utf-8?B?VGpXRk1pMzVUOS91bTQ4RjZUU05aSkxxTjhCYWk1N0ZXa2xIMVU4V29qL0R0?=
 =?utf-8?B?NFFZbTc3Rm1LeE95NE82RE5RV2VnZUo0VnJXVEdZelFXT1J5Wm1lbXViQkNt?=
 =?utf-8?B?ZTF4UVFRL2FEQ25GVHpiWUNDOHVjU2xxWmJWbi8zOERxOXdOWFBvYjlLVCtG?=
 =?utf-8?B?ZFdidUV3SExkM0NCaDl4SEp5dWhTc211YWZxRFhoMjVIWk5RUkhQc1FpT3Iy?=
 =?utf-8?B?Tml5aDBhVzcxRzJqR0NJN0FXaWVLYnpPSERvWWU2VXcyaUl3Z1NpMXV0WmhF?=
 =?utf-8?B?ZXZId0JQN3J0N3hqNmQwRzh1bE9ReFh5ZUVLUDg4L1dFQlB6MmgzSitxODll?=
 =?utf-8?B?TGN1NzZNY1JFT2FCYjEvZWI4NzYxL3RXVlBJVWQ1amhBYXZSaTQvQk5lOXg2?=
 =?utf-8?B?eGpwUjVvb1pOTHlrVkdkWVFjVWJUZkxBR1pWNHltZ1V0cGc2R2ZnOWQrN1VV?=
 =?utf-8?B?Y3dGSE8yQlI1K2xPN1NmTHBlVHlGSmxIQU5iT0ttaDV3VzNmMFdaRTgvaGYx?=
 =?utf-8?B?aXRqaGsvV3h6UXpoc3pqd0NhbitxNFI0R21FK3hkcXJaSGhhaElNNmlnVHA1?=
 =?utf-8?Q?0CTWyuBxpWAuq/vO+yEUrPGcI?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ad79284-962c-40ac-0a56-08da742ce139
X-MS-Exchange-CrossTenant-AuthSource: CY4PR12MB1366.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Aug 2022 02:15:33.5778
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yF5ADPqpKrWWNxqyQjGQpi+onFdSCB60MpUiXbD631N0xAnlYhYhctATv/lAvQveCdiluHg/nrS1+dmhwqnogw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB3718
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


> Yes, this is a standard pattern for walking tree with priority, we
> should not obfuscate it.
> 
> The final else means 'equal' and the first if should ideally be placed
> there
> 
> However this function is complicated by the use of the service_mask
> for equality checking, and it doesn't even work right if the
> service_mask is not -1.
> 
> If someone wants to clean this then please go through and eliminate
> service_mask completely. From what I can see its value is always -1.
> Three patches:
>   - Remove the service_mask parameter from ib_cm_listen(), all callers
>     use 0
>   - Remove the service_mask parameter from cm_init_listen(), all
>     callers use 0. Inspect and remove cm_id_priv->id.service_mask,
>     it is the constant value  ~cpu_to_be64(0) which is a NOP when &'d
>   - Move the test at the top of cm_find_listen() into the final else
> 

I'll do it. For the 3rd one, do you mean a patch like (similar change in 
cm_insert_listen):

diff --git a/drivers/infiniband/core/cm.c b/drivers/infiniband/core/cm.c
index a2973436b16f..8749165bbe3d 100644
--- a/drivers/infiniband/core/cm.c
+++ b/drivers/infiniband/core/cm.c
@@ -626,9 +626,15 @@ static struct cm_id_private 
*cm_insert_listen(struct cm_id_private *cm_id_priv,
                 parent = *link;
                 cur_cm_id_priv = rb_entry(parent, struct cm_id_private,
                                           service_node);
-               if ((cur_cm_id_priv->id.service_mask & service_id) ==
-                   (service_mask & cur_cm_id_priv->id.service_id) &&
-                   (cm_id_priv->id.device == cur_cm_id_priv->id.device)) {
+               if (cm_id_priv->id.device < cur_cm_id_priv->id.device)
+                       link = &(*link)->rb_left;
+               else if (cm_id_priv->id.device > cur_cm_id_priv->id.device)
+                       link = &(*link)->rb_right;
+               else if (be64_lt(service_id, cur_cm_id_priv->id.service_id))
+                       link = &(*link)->rb_left;
+               else if (be64_gt(service_id, cur_cm_id_priv->id.service_id))
+                       link = &(*link)->rb_right;
+               else {
                         /*
                          * Sharing an ib_cm_id with different handlers 
is not
                          * supported
@@ -644,17 +650,6 @@ static struct cm_id_private 
*cm_insert_listen(struct cm_id_private *cm_id_priv,
                         spin_unlock_irqrestore(&cm.lock, flags);
                         return cur_cm_id_priv;
                 }
-
-               if (cm_id_priv->id.device < cur_cm_id_priv->id.device)
-                       link = &(*link)->rb_left;
-               else if (cm_id_priv->id.device > cur_cm_id_priv->id.device)
-                       link = &(*link)->rb_right;
-               else if (be64_lt(service_id, cur_cm_id_priv->id.service_id))
-                       link = &(*link)->rb_left;
-               else if (be64_gt(service_id, cur_cm_id_priv->id.service_id))
-                       link = &(*link)->rb_right;
-               else
-                       link = &(*link)->rb_right;
         }
         cm_id_priv->listen_sharecount++;
         rb_link_node(&cm_id_priv->service_node, parent, link);
@@ -671,12 +666,6 @@ static struct cm_id_private *cm_find_listen(struct 
ib_device *device,

         while (node) {
                 cm_id_priv = rb_entry(node, struct cm_id_private, 
service_node);
-               if ((cm_id_priv->id.service_mask & service_id) ==
-                    cm_id_priv->id.service_id &&
-                   (cm_id_priv->id.device == device)) {
-                       refcount_inc(&cm_id_priv->refcount);
-                       return cm_id_priv;
-               }
                 if (device < cm_id_priv->id.device)
                         node = node->rb_left;
                 else if (device > cm_id_priv->id.device)
@@ -685,8 +674,10 @@ static struct cm_id_private *cm_find_listen(struct 
ib_device *device,
                         node = node->rb_left;
                 else if (be64_gt(service_id, cm_id_priv->id.service_id))
                         node = node->rb_right;
-               else
-                       node = node->rb_right;
+               else {
+                       refcount_inc(&cm_id_priv->refcount);
+                       return cm_id_priv;
+               }
         }
         return NULL;
  }
