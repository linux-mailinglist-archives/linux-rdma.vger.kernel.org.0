Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 959387D56C2
	for <lists+linux-rdma@lfdr.de>; Tue, 24 Oct 2023 17:43:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234794AbjJXPnN (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 24 Oct 2023 11:43:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234779AbjJXPnM (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 24 Oct 2023 11:43:12 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2117.outbound.protection.outlook.com [40.107.92.117])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD312122
        for <linux-rdma@vger.kernel.org>; Tue, 24 Oct 2023 08:43:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PSIZW46Yq6QENd8E0OSfaE8pL+oHYryCNGTXqZVZcZ0+YkvHk1byJ4rQGE26u6CBpOg7RxwfwzSSqc6g/vcfb9WfDD4UDg9ANQhnGeghZMBXmvJNMRfzhOaHVIEeNizNTvu49EX+VhsyCLyKyJivrSsaOc2wgsVXClUYhqAG7mAju9HqpHrFI0P3xMdVQW/MeVy9KI0fWPOBBoMKy+udp7Yah0kQ1LnA1ch6+xPIC12RFndAyuPTXZm1hXCZ692LtlfXA02hB3tAHcu5jLnk92VMR8jFtbRSgPkpgVCir5e6mbHjI53yWCPuf9Ws+TWDBMaIeo92qAnZ3IvaOCfR9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SwEY0DSUYERAVv30TnTehRjTFEPjCP3HmUaD4oaSd5k=;
 b=PNLeF0Ql8SUOGk9x03q4tGMid1Hdd0ycnU1pknymb5RnAolXD0Swa8MqMwkcuczEHOjE2RT0IoKTmI/WhqhcoehfORtZiKs+M4uy30pXb0JPu62KYK+cVTvX+Izvgecc6SqzX66BTDaa1DGjgxU6l66slBLp8WTzdSy5VNTgGHI7DiygjvPZc3ev0zGGd1VEXltqXCWXP2MyDiQWDyyDgTeauY+rD5hTg9Cbpw1BauOsZuTF9Mr2uxTxc9gyCPFTkryfhnNOq//qYHen0j65YPFUsZzjt7alKiSgMT9K9gD+mA7NWilxvBFQfnCIG/nyNJxONgZ2xiRr3NELGTRyHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cornelisnetworks.com; dmarc=pass action=none
 header.from=cornelisnetworks.com; dkim=pass header.d=cornelisnetworks.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cornelisnetworks.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SwEY0DSUYERAVv30TnTehRjTFEPjCP3HmUaD4oaSd5k=;
 b=LVBVNKiT4AsHXT229zW3EMQczwnzrlidXFgK6ymUYcI8WfCws1azcptglrbdlmcYJgA6/INFVnJoxrKd2leQbfx3B2OMR2PAR9RLHzSzKPXes50Q+obTCDTvXRIr1h3hK6yrg47a8wUnEPS9oPubZsHRffZTWFKRIcuAFSHzNil8YF17PmqsLYG24d/mEd+qdXy8UgjqHFGrWphwFgmfmrbfwxByj8L6iA3kj41LjABgDOQoReDw10ZJuylOhpQaAsLEwEmkuq9ZfsWyUTRIPkl3zkO2k36M8Nj7/O9agIX417S0Mo0PLyTKjFaswRacmjiYh0MgDULKJOuSbydNJA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cornelisnetworks.com;
Received: from BL0PR01MB4099.prod.exchangelabs.com (2603:10b6:208:42::12) by
 PH0PR01MB6438.prod.exchangelabs.com (2603:10b6:510:1e::23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6907.29; Tue, 24 Oct 2023 15:43:06 +0000
Received: from BL0PR01MB4099.prod.exchangelabs.com
 ([fe80::556:fc8b:6a09:c7be]) by BL0PR01MB4099.prod.exchangelabs.com
 ([fe80::556:fc8b:6a09:c7be%4]) with mapi id 15.20.6907.032; Tue, 24 Oct 2023
 15:43:06 +0000
Message-ID: <d50326c7-017d-1c16-8965-8f616f39b08d@cornelisnetworks.com>
Date:   Tue, 24 Oct 2023 11:43:03 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.13.0
Subject: Re: [PATCH rdma-next] RDMA/hfi1: Workaround truncation compilation
 error
Content-Language: en-US
To:     Leon Romanovsky <leon@kernel.org>, Jason Gunthorpe <jgg@nvidia.com>
Cc:     Leon Romanovsky <leonro@nvidia.com>, linux-rdma@vger.kernel.org
References: <238fa39a8fd60e87a5ad7e1ca6584fcdf32e9519.1698159993.git.leonro@nvidia.com>
From:   Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
In-Reply-To: <238fa39a8fd60e87a5ad7e1ca6584fcdf32e9519.1698159993.git.leonro@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BLAPR03CA0117.namprd03.prod.outlook.com
 (2603:10b6:208:32a::32) To BL0PR01MB4099.prod.exchangelabs.com
 (2603:10b6:208:42::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR01MB4099:EE_|PH0PR01MB6438:EE_
X-MS-Office365-Filtering-Correlation-Id: bd911ae5-4363-4113-01c7-08dbd4a7ea2c
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: H+C/aIoLQs9iu07bbBPkqFj1tkAaAOYo3VgAivjUoGDwHVRVDqWumytl1ESxZnzZpq+e8CdruitF/gvd+D0wQVgefpoUlXNvY3KO6E3WTrM6dfYlGr8+pvFZkHjhDq8l40aRZKgGDc7/R9/AAhAtaoUcg5qVtpQoDfscu5OwuTqleusDS2QivMq+v8Jgu8QmVud495k5Pl6cS2l6UqMfeTJ3uzmZKqQxLNgz4YC06M5nZ7bCU3y57IMZF545g6M5r0iXr+qQaN+xLY1oFOvdwBd/90jvKs7xKMW5Un579yNJTinzbZPxSs19OL1UpwMhlud27dRqUux5im/S7wWatAIuG6miGZKqjHANHw4RBMNy1zvFSrNm0++B1tl9Sb8r9gFzInWF6E7KPYT/0dPpEzKwpSPwy5BYXFtlXCftLuJifvzhsLXadeSnTtmqSmTbTgepJExEEhDCim+M5076mUqxm5trLlBxVNv4rHcIWGPPDFor/53WFGevZTuDjqcVqnZJrq+PISyJJGh246uilH/RoxE6RXQjzSeE3yAcKJq8wlfskvyqoQlgB7tqHp/gPdHU26gh8mKbt1QCS7WkGcdxmoc7jCs2PbDM0D3fT6D6cE24bRPZ/YClfBTgTjGVydO7c86AzBKUbA/1Ce7k/K79T2E+sp3bQbtJ9IKwNXKhjh2oDQ6CYb96o9FdewiR2rJOmx9Ow3ZQcbaWIPs2FQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR01MB4099.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(376002)(136003)(396003)(39840400004)(346002)(64100799003)(451199024)(1800799009)(186009)(41300700001)(2906002)(38100700002)(66476007)(6666004)(66946007)(316002)(66556008)(478600001)(110136005)(6506007)(53546011)(52116002)(6486002)(6512007)(83380400001)(31696002)(44832011)(86362001)(5660300002)(4326008)(2616005)(36756003)(8936002)(8676002)(38350700005)(26005)(31686004)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Y1RxTlZyRDlTMmhLMzRJODNELzNsdnVMajJiTUYwSFZPbXNlcnJiQ0h3ZFQz?=
 =?utf-8?B?bFF6ODlMUmVIUDE1YldSY3BFVitsUGtVMWlQRTFsVVg0U1JYNWJGVmtlT2dT?=
 =?utf-8?B?ZkMxVWZxcVZFbFRoWDRLR1ZBemlWempyaXFOV3A2azVaUEhxWjIvd1MvNWJ1?=
 =?utf-8?B?eTNoVkx1QUZvSnNUc05nMkdDMTA3bEVCaWRmbXhLZlFHa2Z1UkczWlRudzlx?=
 =?utf-8?B?aUZuUEsyMzUyU21EMXpubTEzTFhuWGsyMkpBckVqdktoYnpKQjc0MUZsRVAw?=
 =?utf-8?B?WXcwWWwwRloxVTA4ZGhtdENjUGtsekZ5VW9xaW1mWG52UnF4VkNxdWd1M2Zi?=
 =?utf-8?B?QUlVQmZTbk5KV0pzaGpJQ1BMYWRLc1ordEVseUthdkZtUnBNeVpXOW83T0VP?=
 =?utf-8?B?UEhGSS9uTXF1eGpLcTR2T21xVEZpYlNSN2tyTUNpN0NuOWJzdVhlMjJ1My90?=
 =?utf-8?B?bm9aYTlmYm5EM2dyVlF2T2c3Zk5BR0hWWmVhb3JMRXVKblM3OC8zZlFOa2Qv?=
 =?utf-8?B?R0l2WVA2QUtiZFVCWC9OT1hzdWFuZkRQNjBubkNrSUs1djYySXhGcGdzTFZQ?=
 =?utf-8?B?SU1HTmRtYTVNZ0pZd2JLZVBzNUkrVGpQeDQwR2xsK2daY3NzMlhpWFlCbFRH?=
 =?utf-8?B?UHJ5L0dNdDJqUTFETWNTa2hNZVh1OVhtUVRJelRQNDBmMmpCTDJLeVQ5T01a?=
 =?utf-8?B?MlBYT2x4ZUYxQmxjNSs0ZFZhZ2Q0MDFFbUN0UDJxQmJvQUgyNnVGZmVOUXdt?=
 =?utf-8?B?cWk3azdQRzJzcVc5V0tUNVBDY3pMOTM0KytzeEl2bE5KVXRIR1FiWmdyQXhp?=
 =?utf-8?B?Sk5VNmVKZ3BwMEgrNmprc0V0REwxNS9sYnNrTzFIWXIwRVBjWjlORm1aT3lG?=
 =?utf-8?B?a2JrQTJGclJtckFsOEEybk8vclVMdDZMaVgyWlcyeVdTZzZMUGUrdWhBOWFC?=
 =?utf-8?B?WG4xRVJGaEs3S05WNklwVGczNzNwRGpONE9oMlpwYUNDU1BueFQxR3hGSUpH?=
 =?utf-8?B?ejBOMHd4ekxDSDZ0VEQva1JycDkxWU5zd3oyOER4VVg2WjJiN3c0TURxVCto?=
 =?utf-8?B?L0I0Zlh5VmpldEpWSUk5VThKdk50L09sNmVxalBzdWRJRUZvenRqQW9iN0tH?=
 =?utf-8?B?VkEyME9SWEt4YjhoV2RndFByQ21mcG40OGYzcWM2L2hrU2hObEhSeUN1WGtz?=
 =?utf-8?B?d0k0aGlRaEEyOUJxQkdNbFFtQlppRkVGSXVheG9WcDNLUVVISkt3U21ONnd4?=
 =?utf-8?B?a3FWME04RUp6MExoZTZYbkx3ejRmb2ZUQkFPNDJKZUhub1Q3UE5vc1BJOUxK?=
 =?utf-8?B?VlFlT1UyWnZ1WFd1RlV0d0hXekRMWGt2ejlPKzFxM2tFK1o5MXg1SFdmNFdQ?=
 =?utf-8?B?NGF5dXBlNmMzNWNMRFB6RVB3VmhNVkgvVDBYNS8vV3MvSzI3TXI4OFFOZ2FW?=
 =?utf-8?B?TnBVNmhkR3NyWU4zUDNoWW5PUlMzUUhrZm1qZHZuTVZaR3g3YmJNVjYrOXNZ?=
 =?utf-8?B?QTJBSWplTWg2aE9GQkVnZE5HZWJWWnE5VnVqUGRwY0lsSnV2WE1xZFZveXg2?=
 =?utf-8?B?U1MvOERFMW5iUFhXMHMzZVNySHIxR09FQjUxMlRVRVpHbVRWUUkrQU1Gc2Mz?=
 =?utf-8?B?S1RKYlhEbGhFVFUvQVlDeDM0ZU1qT1kvOFNLZFhNRVJqeDZOVFl5R2FrM0ww?=
 =?utf-8?B?M0lKajVkWi91d0dxSTJISWwvanpEeGxHSmx3NkZLeGhTU3VtamJ5bytnZUtE?=
 =?utf-8?B?SlgzWHQwYmlEcEpCVk1UM3Z0U1UyS2VmazYyTm5jR0Fwc1VuSVFjWXJ1ZEdy?=
 =?utf-8?B?Mlh4UUFwR3ZuVnFWTFhDSGdhRXFTY3ZqcWZxU0RPQTlnam83bCtuNWhIcFhC?=
 =?utf-8?B?aEE1MTlUL091QjNpOVN3MllTc2pHV3U5dUUrYXRhdjNjMjluMVBmQ0tBS0pQ?=
 =?utf-8?B?TXJkOE1pc1hmWUpUOU1nU3EzS1hUckdLNUVsUnkzVGtXcjlNenFLTmZZOFRs?=
 =?utf-8?B?YXJEdmZSMGFnZzNZTnhPWVhnK1NadytoY1pQd0lLbzRIWE43Nk1HeTVqS01a?=
 =?utf-8?B?S2R4LzN0VnoyUStqdWtyT1JWVWJLek5vTmNHS0FDUXhZdjZJeFk0UnRVclRk?=
 =?utf-8?B?NXFkZXR1WHh4dXNsVDh6bElPQlJjY2wxbHN3eVN3ZW5McUlESkVWSENPbnVK?=
 =?utf-8?Q?fdR+YhNvHh/nGfe6uwz51bw=3D?=
X-OriginatorOrg: cornelisnetworks.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bd911ae5-4363-4113-01c7-08dbd4a7ea2c
X-MS-Exchange-CrossTenant-AuthSource: BL0PR01MB4099.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2023 15:43:05.7547
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4dbdb7da-74ee-4b45-8747-ef5ce5ebe68a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8mtVXilzqUmrA5hB/jvhmiFot21eEDVLgmJVSNfPfVlmyieF1x7KigCpk6GywEeTmTpo73JQ5gEfCY6lVK+wUrx4GDz8eJ4hGJajXu+dfwNd5zIPBRUUQ9YZARXpXPPY
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR01MB6438
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 10/24/23 11:07 AM, Leon Romanovsky wrote:
> From: Leon Romanovsky <leonro@nvidia.com>
> 
> Increase name array to be large enough to overcome the following
> compilation error.
> 
> drivers/infiniband/hw/hfi1/efivar.c: In function ‘read_hfi1_efi_var’:
> drivers/infiniband/hw/hfi1/efivar.c:124:44: error: ‘snprintf’ output may be truncated before the last format character [-Werror=format-truncation=]
>   124 |         snprintf(name, sizeof(name), "%s-%s", prefix_name, kind);
>       |                                            ^
> drivers/infiniband/hw/hfi1/efivar.c:124:9: note: ‘snprintf’ output 2 or more bytes (assuming 65) into a destination of size 64
>   124 |         snprintf(name, sizeof(name), "%s-%s", prefix_name, kind);
>       |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> drivers/infiniband/hw/hfi1/efivar.c:133:52: error: ‘snprintf’ output may be truncated before the last format character [-Werror=format-truncation=]
>   133 |                 snprintf(name, sizeof(name), "%s-%s", prefix_name, kind);
>       |                                                    ^
> drivers/infiniband/hw/hfi1/efivar.c:133:17: note: ‘snprintf’ output 2 or more bytes (assuming 65) into a destination of size 64
>   133 |                 snprintf(name, sizeof(name), "%s-%s", prefix_name, kind);
>       |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> cc1: all warnings being treated as errors
> make[6]: *** [scripts/Makefile.build:243: drivers/infiniband/hw/hfi1/efivar.o] Error 1
> 
> Fixes: c03c08d50b3d ("IB/hfi1: Check upper-case EFI variables")
> Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
> ---
>  drivers/infiniband/hw/hfi1/efivar.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/infiniband/hw/hfi1/efivar.c b/drivers/infiniband/hw/hfi1/efivar.c
> index fb06e86da608..9ed05e10020e 100644
> --- a/drivers/infiniband/hw/hfi1/efivar.c
> +++ b/drivers/infiniband/hw/hfi1/efivar.c
> @@ -112,7 +112,7 @@ int read_hfi1_efi_var(struct hfi1_devdata *dd, const char *kind,
>  		      unsigned long *size, void **return_data)
>  {
>  	char prefix_name[64];
> -	char name[64];
> +	char name[128];
>  	int result;
>  
>  	/* create a common prefix */

Thanks for the patch.

Acked-by: Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
