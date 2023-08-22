Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85239784250
	for <lists+linux-rdma@lfdr.de>; Tue, 22 Aug 2023 15:46:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234965AbjHVNqi (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 22 Aug 2023 09:46:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233232AbjHVNqi (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 22 Aug 2023 09:46:38 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2135.outbound.protection.outlook.com [40.107.92.135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D49418B
        for <linux-rdma@vger.kernel.org>; Tue, 22 Aug 2023 06:46:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WNtSJSZG4zobyUW1hsXdxpzEtiXycP+diF6pu/DcsFTjg5FH5q/v9oKdJLLMN2djX6CZPF0olE/W6k9/Ro2p3mN8jslvL+eHfzS2NGSZY+GXgG8iCvTrPgl9Klw3JldTYMAMczt+ttwMGqtaQfUm/lnsybFtIh+gJeb8YeMpuj3dB6LRpVxj9xbq74gyob27pAcX1q+6zPCoA3R+D1oDrHPWggYXBpQ6M1Xcpvnq7YUvOlb3pITTFFFAVPoHET7o+aVxgdk05H6Mntux0sSL3MXdFOnLFERLzJyKy7bomY0NWmQ/a8mGv+PldlgKVubeJHOQK6J8kUveLha8rvvWpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N7dBTDtUnXsQFvcGnH26Dc+K0hbhrRMOasfVzku6m40=;
 b=N9E56QHLZ/j6aWKfho7UNNXzVJFpg6gnsus5cdx4vldPWysUBG/P3JYxyWGwfDybDeWnJXpsWssSyfiM7L6F6oJVI2OvHwjBfvsWcY+Gd1A3YEYTf63ZPiBZ4A5YxlRot7jwbQdeg9zcEXnqqlVo66nbWgayaiRIFgp1bHHPhxhtZq8SvL5WaVaRsbCAqQhUvB5tiAeBQ4QHo3yVVqOYQ0lXx9lltzQyVipDZBEKsri8PJBBABI5bg0Q5MOuF+9VKBa43WWQgGdigP+x9B60O36tgjfDLiQ6zFng7/OvcoiOJd6Ky8s3oZLaJ+fSagIHbU6ekU9w47EagqS8c5TbTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cornelisnetworks.com; dmarc=pass action=none
 header.from=cornelisnetworks.com; dkim=pass header.d=cornelisnetworks.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cornelisnetworks.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N7dBTDtUnXsQFvcGnH26Dc+K0hbhrRMOasfVzku6m40=;
 b=dEN0bG+eQHIrtMTHXP/YSxJ1jHwCBTirjymRak7g0ORBk9uwo1vJyd1IBQx8DVg9XGXVOGUHDMQLHFoB1RuU/5v34Qj3puDjRf0fZQu5w8VEwVC1kB1zR2eSYWQ8AXhV+3hiWxLdOEk/5b34/8wfEdpTWz16Cz1S37W5pPgT1Dh75ukTDeW30uLnSHx4i+mNddoqH++C+spiAMZST54vI/fYUT4zl1nXI//FLY7b3PVgI0GTH4hdYg2iV9rItlZDgrdHFVjPWTYlPG0/N8KTYGufSBIZ46E/6gcZA5Rvb6x3c90oJh3YjJ+8Cb30ZEGQgIUUWIPL/a8VxmblbBcCgg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cornelisnetworks.com;
Received: from BL0PR01MB4099.prod.exchangelabs.com (2603:10b6:208:42::12) by
 IA0PR01MB8240.prod.exchangelabs.com (2603:10b6:208:482::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6678.31; Tue, 22 Aug 2023 13:46:32 +0000
Received: from BL0PR01MB4099.prod.exchangelabs.com
 ([fe80::4342:ee1b:931a:6929]) by BL0PR01MB4099.prod.exchangelabs.com
 ([fe80::4342:ee1b:931a:6929%3]) with mapi id 15.20.6699.022; Tue, 22 Aug 2023
 13:46:32 +0000
Message-ID: <96342ab3-247b-e95f-1a21-2d725f5617e3@cornelisnetworks.com>
Date:   Tue, 22 Aug 2023 09:46:30 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.13.0
Subject: Re: [PATCH -next v2] RDMA/hfi1: Use list_for_each_entry() helper
Content-Language: en-US
To:     Jinjie Ruan <ruanjinjie@huawei.com>, linux-rdma@vger.kernel.org,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Leon Romanovsky <leon@kernel.org>
References: <20230822033539.3692453-1-ruanjinjie@huawei.com>
From:   Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
In-Reply-To: <20230822033539.3692453-1-ruanjinjie@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN2PR05CA0002.namprd05.prod.outlook.com
 (2603:10b6:208:c0::15) To BL0PR01MB4099.prod.exchangelabs.com
 (2603:10b6:208:42::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR01MB4099:EE_|IA0PR01MB8240:EE_
X-MS-Office365-Filtering-Correlation-Id: 8c2f2c58-b3c7-42de-93c4-08dba31631b5
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /Udm8eJGicnMQ6Gz+vBda3sVHSuFvSJQjn8QiklLQc8jTxGEJen4ayNZVQ4HMyO2QLMqVmMO7N9zSWuq/1CDYbEZ0G2Hckruj3pF6inwJtEXtkjZroKFHex3HIGcrYunjGx2oR6T668D9PULmkJKE0JiQ/n10vURP5nPKP/xvYpxcQn03VeaePHjQM7rJ4Ht5nkRXEf5vjn79dW8yx11+J2VGJ6vaCeYxAeyjAXJ3PPKP4P0FLhyykLrrdBuZV2UzysFaTX4TfnfhBZ/pd4hOA//QmOQ+wQajlMsikiNuHcl4NyFtKbTnYIwNspKIebe6FopEt57hexmFdejVoIwluURDNwSOiqwbYoOQrGjqIZ7DpL/xvQi8lJXOmsUG8J76msQfVZVvFumYbSBbg6pLK8TSs2S+CveC/lzM1444GsgzMFO4oXR4ZSRm4dVywelbYOWaaHQSRiht4IkR60cwMhsv94jyfz2Rp0F0LuaMCDNCGjymLqKgK8Hp0JMvKUQK4oEaQqw3NulD7NfyYRmCpXqJLGGgEOZ0DG+1q6VsA3aAPzepBYR6gHme/9bCnZnKHYtD5QOjOszyMO/7u4IQ5RcAEzFWoaKqg/k6ZeWHx0vrah3sOlMw8ykns7uuwLCyMe+5VFZFoO32YK1BIIlLQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR01MB4099.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(376002)(136003)(39840400004)(396003)(366004)(1800799009)(451199024)(186009)(2616005)(26005)(6512007)(53546011)(52116002)(6506007)(6486002)(83380400001)(8676002)(44832011)(8936002)(5660300002)(2906002)(110136005)(478600001)(41300700001)(66476007)(66556008)(316002)(38350700002)(38100700002)(66946007)(36756003)(86362001)(31696002)(31686004)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UHNEOVRJdjRVSVh0TzZJclpxQ3V1R2dUZkZQME52dFFrWWlKL0dNN1c3VEgr?=
 =?utf-8?B?azU5MjlhTTNTZ1ZpeTFLeTRPMUI3S3BqdWl3dDhtdmpqdnRoYm81dVRuOGMy?=
 =?utf-8?B?a3FiYUdsL1Vva3pIUkNRN0U5YmJ2YkovcnB1eC8ya2lBSWF6TXhtL0J0SGJQ?=
 =?utf-8?B?cHk5WVo5OUxQOG9qWTdBMDdDVEhac3hzQ1VGL01oa3hzRXRTMmppaU9sRG1o?=
 =?utf-8?B?U29iemVXSGtZYmlTWEd0WUhkc2tRQkFYY3RrTGpUMTB3WHZhK3B4Y01lS0cr?=
 =?utf-8?B?VG91VUl6aHR0UXNkTmZ0TTN1TGdJZ1FQOWpMRTlqMk1qWDlKK1huSkwzNEtr?=
 =?utf-8?B?bjNSdjhQYTdhdE9YV0RSRWpMRjErSXRIU3JQZ0oxdVdtVWJkSERDUGZCQytq?=
 =?utf-8?B?MzJOZHFTOHdBcWF4Zlk0TzRPd3FST3RCNURDcHR0V2IzcXpTQnZCYmZVeHRz?=
 =?utf-8?B?TUhxcFE3VW5ZSWpXNTBMbDZjUGZDczBCT0NTNkdSU3krYThKcFJTdmpwNkM5?=
 =?utf-8?B?WFV3L25OL0drS3J3UW9RZFZ2RERBbzhSeXo5TlNZMGtKMldycklpRGxkaEI3?=
 =?utf-8?B?MEVWYmNyMEFsVTJsQXIyKzdLajdOaUlkNFljRzNab3VMeENxREZ1akxGY0N0?=
 =?utf-8?B?cDh3eTQ1aVc5b0FZYVozOHBzOXVjOVB4ZVR0L0s0QW1jWDlJWkhTVnJPSnds?=
 =?utf-8?B?RStnTHlQMGJQc0ZuTXBkd2RoZTc1dXFBUlFTWm5HVk5JYlVUSHJ0NGE0RFdR?=
 =?utf-8?B?dDh0WU1tbDAyRFJYTEVEZFhKR1JTL0djQUJkTi93RUs1cGRwWlQvZEs4M1dU?=
 =?utf-8?B?bkp1a2lwRVEyR0V3dlFnUXNmMllzczl0em5nVFFjTms1bmZUc2QzOTBXdm5l?=
 =?utf-8?B?MUdDa0l2SVVkSjlDUVZ0NWgyODA0T3ZnZ1FXUElKZ25JbE4vQS91TGpoTUdC?=
 =?utf-8?B?dm53ODg4ZitKTy82b2lvaTdmUG9BeTZqQWR6SU5tc1dTZGUxM3BudGhTUkNq?=
 =?utf-8?B?VXloY3VTa0NYWDFVVC9DZ1RGQThvNTFzTDhRMk1HbE9yTDlLdVJ2cmplWWUy?=
 =?utf-8?B?ZDZsY2ZFYXBEV1l1YXU2SHNGSE5FL0VCUFVTS2luUkp5KzZ5VEZLNkdFSTNG?=
 =?utf-8?B?RGZhQTJJalZhZitNbm1lOFZGR3RVa3RXUmcvSU0yczV0US9PRVBhTzc3TXE0?=
 =?utf-8?B?L3FCYWJ2R0NHR2VhMXVaZy9VcklCOE1zU09CVFJIcVVmMjNMcGgvWnhhWDJt?=
 =?utf-8?B?U2dtWG9oeUROdG9tNjhLbXB0QVhidDFtaGs0RGdlYldYMTErZFJ4QnRjcVdk?=
 =?utf-8?B?V3dFRkl6SWNxaldadVV2c2FzaUd6TGtmYi9sSEd5Vm5HbUZQdjZHNUNRZ1g4?=
 =?utf-8?B?QWliQjhPRDJ2SjBwSWNndjNlYjRrc2IxT0FTSWF2SGRTUXdJOGhhNG1vd2Iy?=
 =?utf-8?B?REVpUEFHbUtXQnc2OU5TRWdNeXE1TFkrQVArU3EvUGpOMmY1T01iSUFYRlVv?=
 =?utf-8?B?NTRxVmNwVU5NcGxiVEJNUW56aG1paHdHdTNyN3FpY3BvcnBCQkgvR20yS0ZV?=
 =?utf-8?B?aTZFaHBoaHQvV2F0SVpMR0FMaXozbzJlVk93OWp4VnBpaFA2WG1lZFhlVkJ0?=
 =?utf-8?B?RHpsa05qT2lud3pTSFN2VEhCdnhwR1Y0Z3VvSlpXWGozdHhnbGk3N3ZBZDVq?=
 =?utf-8?B?aTlXaXhIK2NiQ3hkRWVUL0k1TXFwVTNnaXlDZlQvbSt5NjFJeWxJSlRYc2pu?=
 =?utf-8?B?Y0VQVUVsbEVzdnpSRDhKRGZOSzJ5R1B5enFLVVBqOWV1R2ovQ1hidCtOVEZq?=
 =?utf-8?B?WEVQSE1BVWY2NlUvY3RJV0M5OTlYN29QWndCZzJxUURKOGlpZldJcGtUcW5k?=
 =?utf-8?B?ODRyZWhTTitxc1l5NDRoTlJxdlBJMWhlNEptZmxIQ0Zid0ZTZW8xM2k4eTdi?=
 =?utf-8?B?QXY2YWRHUUdsZS9QOXcvSFFYTkdVSzl2VTRVRnhSRk9wRFRDWmlMZkIyVnpD?=
 =?utf-8?B?MVk5SnozVGRVTE5KWnRXMUVJaVp3Tks3bFJXaUdYelJKZFlES29XbmxxUFZT?=
 =?utf-8?B?M3gwV09UZDZ4Q055S3RaM1I0emJta2tMTmd3NXBJYTdqOStqbWtPU2praDF5?=
 =?utf-8?B?RDg3Mjk0VFo1emtMVXcwNDBMT3JzcGRVNkhaWEdwUitxUTN0cEU3eUdBK05S?=
 =?utf-8?Q?+smAQ/6OoLfPjVfNtBP18tk=3D?=
X-OriginatorOrg: cornelisnetworks.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c2f2c58-b3c7-42de-93c4-08dba31631b5
X-MS-Exchange-CrossTenant-AuthSource: BL0PR01MB4099.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2023 13:46:32.4243
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4dbdb7da-74ee-4b45-8747-ef5ce5ebe68a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Xhg71HXqWXn45RN8PWu16ohgbr8asG1v4P0+oJ/XdPKdEotUkW+a9lTifLl93IKyYcG+xJ/SUXgTdnNmhhViY10t0v4jFaQmV5qRifmaGc1QrLRUXZyQHBjWfmYDBr5i
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR01MB8240
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 8/21/23 11:35 PM, Jinjie Ruan wrote:
> Convert list_for_each() to list_for_each_entry() so that the pos list_head
> pointer and list_entry() call are no longer needed, which can
> reduce a few lines of code. No functional changed.
> 
> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
> ---
> v2:
> - Update the commit message to clarify the purpose of the patch.
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

Acked-by: Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
