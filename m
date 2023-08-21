Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA611782D8C
	for <lists+linux-rdma@lfdr.de>; Mon, 21 Aug 2023 17:51:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236339AbjHUPvm (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 21 Aug 2023 11:51:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236193AbjHUPvk (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 21 Aug 2023 11:51:40 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2121.outbound.protection.outlook.com [40.107.223.121])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4A1AEE
        for <linux-rdma@vger.kernel.org>; Mon, 21 Aug 2023 08:51:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ekp8pO0hcLJeONK0WIsRdrNDMg/G1VBTdqC6I5toMmNRas1O25GAhDfMF232zfzReH4jykraSuSSteNOTJAO1WVmRhJfYzwnhea4vaZW7uRqjiMk0MKM5FW46cwc6dUmnslBXlCLteG9EgsyztgG8bmcKeDsmW+0zsOxMDqnWSCViTeLh9AwrGJs7ww98XVMCIkag92U1JzZxFCsIy1sdwXbGl4RcLh39tcGYtli+yl6o6hXxbJVEoATU3hYDMxJYmZNN/Qr4uDPAckTb10jgliSsWd2ldmGWR6vmnSprHOSDKHmZrFOPiGMfXFMLMBdVYRcz/s8t5TdIcjj4IWnrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dd4D77tOOpkY/j2a1yhhp/Btu+dTbWnL0OPHp0BusNg=;
 b=ZK/zK9IoYrMt48td0Or567IUVbJsZZwJ79NCUzvV2SPeeGHnWg6sIBj4H2r0H8EFcrpuSyzO8wWG4mmHZTAE9PL+RVJBfQWNFg800yl9RHEltu5/xmczR6aU4Ta1U98iLGCbPWrQ/7QFAiMBdcNNnx0nxjymrXx56Ev2pX5IiJhmdja9kTwBaiMklaTBe0PQzKc/Y/CkDpXw8/rzQo1C/FjZox34DitqQwwF4jipfWjQ2ClbLCrJsPjhoDBiOn4E0BypAkUWhTMPOWgQgsAFhnpPUM21hwfQBw0F5gr8syLACap1VN8WmzUuwCuo87ajZBp1O4564ALiiwwWuPChww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cornelisnetworks.com; dmarc=pass action=none
 header.from=cornelisnetworks.com; dkim=pass header.d=cornelisnetworks.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cornelisnetworks.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dd4D77tOOpkY/j2a1yhhp/Btu+dTbWnL0OPHp0BusNg=;
 b=M8mnBWG+saIO8DguOs/845MC3TI/14imwjGhz/cZKXlKZSxr8DQDFK883TMyZKlQ4SLsDo41fKdomIrHq/b5YGlwdg0BiPTg+Q+xFM88uvyXF4G8/AVdH8NXhSlaIY6N7+kQ0gOgJbJEN0STz+T4qQk3J75wZ/H070HSA0r0LVof67eBifvbcYdSE3O224UPJ2AISO61WdArDi/hsVvCOguHDsmOvYrZIgPQoseS2W/VYMlvxiPPf6cm3UVCvDdE+hna0Pejcvb8JyTJAdVBn3N7QwaTjUR4pawAChGRvfxeCxjtwEjaK3jsuJW+iKXHAs6EmYJITie+qwM3YH0DlQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cornelisnetworks.com;
Received: from BL0PR01MB4099.prod.exchangelabs.com (2603:10b6:208:42::12) by
 CH3PR01MB8421.prod.exchangelabs.com (2603:10b6:610:1a6::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6699.24; Mon, 21 Aug 2023 15:51:33 +0000
Received: from BL0PR01MB4099.prod.exchangelabs.com
 ([fe80::4342:ee1b:931a:6929]) by BL0PR01MB4099.prod.exchangelabs.com
 ([fe80::4342:ee1b:931a:6929%3]) with mapi id 15.20.6699.022; Mon, 21 Aug 2023
 15:51:33 +0000
Message-ID: <d6e29395-020d-d185-9f73-c66a50bd56f1@cornelisnetworks.com>
Date:   Mon, 21 Aug 2023 11:51:26 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.13.0
Subject: Re: [PATCH -next] RDMA/hfi1: Use list_for_each_entry() helper
Content-Language: en-US
To:     Jinjie Ruan <ruanjinjie@huawei.com>, linux-rdma@vger.kernel.org,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Leon Romanovsky <leon@kernel.org>
References: <20230821133753.3131936-1-ruanjinjie@huawei.com>
From:   Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
In-Reply-To: <20230821133753.3131936-1-ruanjinjie@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN2PR11CA0007.namprd11.prod.outlook.com
 (2603:10b6:208:23b::12) To BL0PR01MB4099.prod.exchangelabs.com
 (2603:10b6:208:42::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR01MB4099:EE_|CH3PR01MB8421:EE_
X-MS-Office365-Filtering-Correlation-Id: 294c7ff1-affc-4320-6300-08dba25e7e28
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EhO7XVPOnvgLWGk4tQoy1FzaIzML8ZIxv0m1rj/z+4RiE222aHzfgzMAVirI/WLHlcZfnt/ztZgQ1NfR6RHnLC6SXcidNND5J5u1sri4EvdSMLgGoaXPXzzM/6s+VnMcJ5ghi+/NhRufPrzEa2m676rAV2SnOTcwFXG+I3uihqBqi4cZa44Ciw9lGM3l3x9vwvZ2m1J+lmOPsNd3he6V+LM9Z5V/rNGcD3wkdHnG4PvubRmdNSF4k49lioc/cac9d7t5ADe558sFL3aAHjRpKJBoQ1PZzmpu6rC8S4M3a+oUJH2FfmRFQDz0Ib9Tf6e+F+Y0a1Wh8tb65kTjjlU9fJp/RWE9+2ti7ZXFferxv7ZoBbsfymul9jImPqG83EctzRqBAwdmA86j8hJxWVIMM7yXCsZf6UHuzMXLog31loLcvC75a1DIoy8B5Z4ZXyZqHuLL8DSxoyOdyJyEDX8qMLdTCgpf0uykMfb5NoqtQkYQTWISP8J1LhoTF7QgvRQJJm008fjo0sTZuh9YJe75MZ2Mj+BchxyzUuAQatSs3q72WV67ZwzOfqpZTor54imKfucaU5ur5eh6mZch5EkDxgSRqNhJEoe7Kb107sM/XHMVynjlEK8oIvpJoNj1vi5rxz8DqCR0aU0K29h53TbQZw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR01MB4099.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(39840400004)(366004)(376002)(136003)(396003)(451199024)(186009)(1800799009)(2906002)(52116002)(38350700002)(53546011)(38100700002)(6506007)(6486002)(83380400001)(5660300002)(44832011)(26005)(86362001)(31686004)(31696002)(8676002)(2616005)(8936002)(316002)(66946007)(6512007)(66556008)(66476007)(110136005)(478600001)(6666004)(36756003)(41300700001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?c3haMkVCTjllNndYWlczZ0U5cnk4Y21sRU9RN0g3Z3dzRGpsR1cyNEVxUkFR?=
 =?utf-8?B?RUh5UHV0dU1KUElzemZEaXJmcW5pajBGdnFOYTU3eFpXbXhnWGFvOFFydU80?=
 =?utf-8?B?SllRMU9ZY1lWN3FMRUdXdjg1R1ZoUXJ2dzJHN292bTU4UDNFeWpCZzBCZnBi?=
 =?utf-8?B?QUkvK0RDYVY0cDIvaW5kSE9ZTzhlekR5U2ZtaEY3dFJReGJYM0E2L0tRdDUz?=
 =?utf-8?B?U0g1U2pER3Z5QXZkaGZiQlJvckJFOEo2NGg1QmFiK2crVXZpT1g0KzFxVkxY?=
 =?utf-8?B?WDl2LzFCUVB5dWJQOHp4Tmh6N1hTMDd5Nkx5dUc4ZHBxOXlrUk5ucmxGOWpP?=
 =?utf-8?B?cXB6dmh1NVFOdU5sWUZYdHcyUGVuRmpGR0ltTHUzNEZ5YWNFVGw3dHh6OTFm?=
 =?utf-8?B?QlovK2VJR29SNDBSRmxFL0U3VXpqZWVDcmYrNlFLcko5UTVSU0RCTGR4Ym5M?=
 =?utf-8?B?VUlKY3BOOVRDUHBVbkNsTUlUaHBRZXBsWnN2UG5TMHhGeERFYnQ2SmNoenZh?=
 =?utf-8?B?Mzd2TXprL2N6TWtTN2ZmZkhNYUIvYlpJSGVsL1J5ZGhPUFBwT0U5NktGclha?=
 =?utf-8?B?L1lnWUJtY09wYVdWR0VNalBQTUdkZnNKSGxEeXIxVHhWSHJTaVFTd0pyUGxL?=
 =?utf-8?B?eHFPSXJKUXRyaEdLdURjNUNWdjRlOW9DL1B1VVg0VkFCemUrYm50R01XSFM2?=
 =?utf-8?B?ZzNsY0pqWCsrbk9GVko5OE9KTS9ibTg1Qk9XS3I2bjc3SEROTTRrbUE1OTIz?=
 =?utf-8?B?enhZUEFQUXo1QnVaV3M4eFhXZGVOWTQyN0o2SGxlajBldGpTdnNaajN4SzBy?=
 =?utf-8?B?Y09PRVpJV2p5eTlRRnk3U2lzZzJhN3FDckJtOXVvMW5tR3QyY2FiUW9BRXNL?=
 =?utf-8?B?dkc5S0NpOUszNGQ1dVp0WFRLVDRQdytsLzBNdG9PT241eG9HWlpLS2VFZ1pJ?=
 =?utf-8?B?bUZVd2crRmkwS0dBUUNXWXBuWW9zVlUwZjRmbmxXVkpaVVg2bDlKWHI3T2Zt?=
 =?utf-8?B?V0tlK2g1c1prS2dna0xHdzZjSGVmZ3dlT0xOWDNrRnJCU2Fqa3ZUcTFxRExF?=
 =?utf-8?B?eENqS3JqRDVxMVlhUlcvaGFjb0dJNXJ0MDlzS05ISE4xQm1Td25vTzdSQXJv?=
 =?utf-8?B?d2NTeGdFbHY0K2ZlTE5xMFliTzBRZ1pudUxOWWhYN0RuK0c0TG1CVkdlWjFO?=
 =?utf-8?B?WE5OdzhubGtFR1ZBY0ZwQjI1QW9neEl3Wmtubzg3RDR1ZWFHZlI3NnprT2s2?=
 =?utf-8?B?VytmUWM4TktUYVdteWRoZVhQT0sraXRFa1J2TmJoMkN4aW5EWjZqdEtHWFNF?=
 =?utf-8?B?Sjg3QUdyTzBsZ3p5YU9meks2M3owQWNjVklDNTlGRW1vQTBXbTYxRVdvWFJx?=
 =?utf-8?B?RWkyR1ZDWUtYekVwTWlXVDAzVEFPcGZBYnNPWGZTdTV6WGdtQ09zL2dKMEpi?=
 =?utf-8?B?bzdvbytLL3Vjbm1TVGlIS2NHWEhSU1ppSkVUSk4vQkVlUGp2eEZxQ0psRkhs?=
 =?utf-8?B?L2NrRVJiNFI3dEpLeHpocGxvUFAydk05ODNvQkJBcVFCS0JlbWMxTHZyU0Vq?=
 =?utf-8?B?MS9PL1NaS3VJM042ZEtiMzgzSTJXSEoyYWVJL09FZ0VVSmJ0MGpqOHF1dEk1?=
 =?utf-8?B?TnY1RkQ2eGVYRFhHK1NlSktIVVJmUFhQOGliY3RidDQ0dHhjWm5hVVdtUUFO?=
 =?utf-8?B?alZ4Zzg1K2RDN1IySURZVkFOTytQWFJzd3djQWQyWmE4RDQ5VllsaGdxeDdr?=
 =?utf-8?B?cUhOM1U1MEFMMlFYdEpiMDlqVFpUWjNYdUU0WFVtdjNQN3h4T0JrMGsxRXZF?=
 =?utf-8?B?dVFVckdGVGlocXd6d2JnNkxGOGtxRVFuc1JjbUNzdDR3UTVPVzZJVE1CMVd6?=
 =?utf-8?B?T0ZRNkxMbjZZNE45VUVBUTI2Uk5DYkZhTGV4R3VQZnhVWGY4S2JaQTB5RlE5?=
 =?utf-8?B?WkUvdTJUV1A2TzRvZVFwbVVpUmhhVU03NGRLYy9aM1JNZ0xIMjlKdjZMRnh3?=
 =?utf-8?B?TFluS2RJTDBzTlkvZlBKZi8rb25obTJkQnR1ZWYwd3pvdGYxNWZaQUZGYkhO?=
 =?utf-8?B?Zy9LdWY1ZytyeDkzdUoxd0U3Y1hnQjMzU0NJSXJGQ3F4UUUxT0tTRTdhMmZX?=
 =?utf-8?B?Y2V4dlBTaDEwU1E0eWFXbGFDa0R4YzVyZy9kb2JKb1VFK01lSGJQZ2dmQXhm?=
 =?utf-8?Q?2FE3H+hxlbmeyi+nZARNyfM=3D?=
X-OriginatorOrg: cornelisnetworks.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 294c7ff1-affc-4320-6300-08dba25e7e28
X-MS-Exchange-CrossTenant-AuthSource: BL0PR01MB4099.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2023 15:51:33.2352
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4dbdb7da-74ee-4b45-8747-ef5ce5ebe68a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pexInx/9i6N3wcakpG/h79IfUfOjRu1C7x2cp2eNXN7+VzbKzd2r/K5bZTMWYZZqVAapA3T39Cs0KjnXCJ7CgqVPhlje8DZ3piCiFmrCWF2m0UL4S9x1i+CuKkA7JkcO
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR01MB8421
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 8/21/23 9:37 AM, Jinjie Ruan wrote:
> Convert list_for_each() to list_for_each_entry() where applicable.
> 
> No functional changed.
> 
> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
> ---
>  drivers/infiniband/hw/hfi1/affinity.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/drivers/infiniband/hw/hfi1/affinity.c b/drivers/infiniband/hw/hfi1/affinity.c
> index 77ee77d4000f..bbc957c578e1 100644
> --- a/drivers/infiniband/hw/hfi1/affinity.c
> +++ b/drivers/infiniband/hw/hfi1/affinity.c
> @@ -230,11 +230,9 @@ static void node_affinity_add_tail(struct hfi1_affinity_node *entry)
>  /* It must be called with node_affinity.lock held */
>  static struct hfi1_affinity_node *node_affinity_lookup(int node)
>  {
> -	struct list_head *pos;
>  	struct hfi1_affinity_node *entry;
>  
> -	list_for_each(pos, &node_affinity.list) {
> -		entry = list_entry(pos, struct hfi1_affinity_node, list);
> +	list_for_each_entry(entry, &node_affinity.list, list) {
>  		if (entry->node == node)
>  			return entry;
>  	}

Why is this version better? Perhaps amend commit message to indicate why you are
fixing this.

-Denny
