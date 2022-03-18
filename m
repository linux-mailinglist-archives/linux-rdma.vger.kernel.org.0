Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A10A4DDECC
	for <lists+linux-rdma@lfdr.de>; Fri, 18 Mar 2022 17:25:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239020AbiCRQ0B (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 18 Mar 2022 12:26:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239073AbiCRQZb (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 18 Mar 2022 12:25:31 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2117.outbound.protection.outlook.com [40.107.92.117])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01BFF12CC24;
        Fri, 18 Mar 2022 09:22:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eUgVYP4SlfF35XTTUsCjhb/7X5mb3NDr+A6l218WmIxLSCT7XJ5KtTkwj2QQXfCn3bIGWw1j5qvIQNzyp3Wxj4J4bK0kq7UiwwFFOGoeU+JJ7PnKW1rbFnt6PjbavhsvIwEOsVSXuAG/ZGSNNl4Ob2ZQq4KZYm7CG9T2aAEetiLYys+sJMr54q5hu33wVmLXxzGZs9PHnoKr80m7clBqzMkpl2yHwMg0urJ76Dnl2pRhob0Z2j7ylL3M77VW7UbUJUBUEFCWLBFwW+rJoFhvBhyHCVsbOOIU9SpYOczLZYna6U/SSdfAuqL2YGWK8AROVjbPw4rHxIAZt7AiBGHuRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0nDxuCr6Ok6rFZLtCdRl3TTT8HscoeHc9UCqiAi02Rk=;
 b=k+oAyb6RU7I94FVXAaBU2dJ3fPz3wCQn4uPtsR7AAE30quQdeulmzT1BBG1Yy2zsdGapsY7ZKXNootgHIvp4m2t90DE90Vy8qdWNLd8uiPxGd+yyz3SdYu0HoEbJ8E1p0KwSOEeBRbcyqaxLbvfqxXimSuRwRWOdBVS7tUvMRap8+F6lVZsH5KWxSzrw45N70XYZZrxufOfrnBLaIVU5nhQEdUJz0EsY9FLssTLy4bgsY841tuyk6KA/KTaX9FQieVw80gaeTSLRS6mh5+Ay8gH3e9OhbmEJEvK2K8R3RuwwSQlt5V+i8H5i3FZpYUdMaG7wwfiN5wFaT0b8J+Qmpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cornelisnetworks.com; dmarc=pass action=none
 header.from=cornelisnetworks.com; dkim=pass header.d=cornelisnetworks.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cornelisnetworks.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0nDxuCr6Ok6rFZLtCdRl3TTT8HscoeHc9UCqiAi02Rk=;
 b=PCgTeG6+U4F3xBnEK4rlM/Vn/iaOzXGjKOvk1HziExJlnD47R0lHCGmpSS1nlapmZ7sHM7ETnUC9JhLFJa1No4wTU4XnLeizee7ILJ3+3ywcOovSD7QaZ5H5OeSZDg40bV2/hgc6IMi8NozYq8ASCmA0w7jQtiRQHmlluaxvHm94n77ZPjjQUJc5hKDiuztVQ6qBJUyQjlNrfASin5eYJ8fEO50YdyfIOCn0ts6YWhgWWN6/1Zs1wkWN4Jnaq/J+ULsFZqGtY7OX0K4pdaNbE0NPuOwcpI3fHDOOhKL683crLF5IAbvDWIQceyrK2Fe4y2jXwW9TQVU2YKkFVJylwQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cornelisnetworks.com;
Received: from PH0PR01MB6439.prod.exchangelabs.com (2603:10b6:510:d::22) by
 BY5PR01MB5780.prod.exchangelabs.com (2603:10b6:a03:1c9::30) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5081.14; Fri, 18 Mar 2022 16:22:11 +0000
Received: from PH0PR01MB6439.prod.exchangelabs.com
 ([fe80::4ce8:dd24:bf67:47fa]) by PH0PR01MB6439.prod.exchangelabs.com
 ([fe80::4ce8:dd24:bf67:47fa%9]) with mapi id 15.20.5081.018; Fri, 18 Mar 2022
 16:22:11 +0000
Message-ID: <0ee0082b-f298-2b63-46d8-2497690e6c46@cornelisnetworks.com>
Date:   Fri, 18 Mar 2022 12:22:07 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.7.0
Subject: Re: [PATCH] IB/hfi1: Remove useless DMA-32 fallback configuration
Content-Language: en-US
To:     cgel.zte@gmail.com
Cc:     jgg@ziepe.ca, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org, Minghao Chi <chi.minghao@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
References: <20220318010058.2142152-1-chi.minghao@zte.com.cn>
From:   Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
In-Reply-To: <20220318010058.2142152-1-chi.minghao@zte.com.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BLAPR03CA0076.namprd03.prod.outlook.com
 (2603:10b6:208:329::21) To PH0PR01MB6439.prod.exchangelabs.com
 (2603:10b6:510:d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 266f1ad1-9c51-4c3e-0296-08da08fb74ab
X-MS-TrafficTypeDiagnostic: BY5PR01MB5780:EE_
X-Microsoft-Antispam-PRVS: <BY5PR01MB5780648A19570BD9B955A292F4139@BY5PR01MB5780.prod.exchangelabs.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FDH3GckLAJIYF+xyfm2p2bqvCcRBWID+uwN/93oVds6yFxrp2PQd/F0QXST81NDQbH8EFWBkynOJ6qxxL3xyqTAG8Mwx6AH5ZbuerA7U2PIu0zY43sEb3r1K6DOK50FcXxCVM1ze29xJ4BJzS+h5RWyma2RhUYgWiTUHQyFjx+ejIx5srOT7UBd+I3u7ZeS7Xmw/5nGylPexuuyGgM9BI8i/LQXOSU4ewyQhwWZbpH3MpjPsaK/snp2AtcSEMbuN1RkQQpZjA2h2GMvNWrXwYzm0rkViHCJkiSDQoXTCvIf52j+yBAVUZ9uhRHn/vmqTrWHNwkZY4fva4/c8k1W67TD6khPwkOHhYicekpOg4H/P2Cvi1QtiRhnbqHg3dUzij8wbcWTMAzvc+at7DPF/r63NRlNhIqqN9sApG/DnFThMgOM0Y1ZrtFLtjOEHsB8xb8rt/NVZ1HSlggv1pkzmxYm00HmTX2TSSDLI9GxcmvwYKFo7wGT+vqiSnSUWLIFloKkaC9qn2E6CIUpJdlPvfk44FZFX1CrZ7eLjSe3bWN25IufolaPoH6V37qnJrssnWQAhorboYi8aPv6C67nn8g8YbVsSbtvUdrxIpqhJQxDi+WRA2NYph+kRK744SXzCEFf/HevqZxLRF/mvS73quCmh94A4FVLxF/pipp+N/gQQM3HxadnB0Ldb/1YikL4mvu5qEgBDAz7jpf9Fjbdv1oLR1IJcvZ5RIBqOHOB02D2QAuD4wdZMSwOSlKFHzQsxbZWRgE6g2MAMrgSmk5UwpWiPSqusHqmYyYqcdhEyOD6YBLOSm3qHnAW9Le6Yk1xG
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR01MB6439.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(346002)(39830400003)(396003)(366004)(136003)(376002)(2616005)(316002)(31686004)(54906003)(6916009)(36756003)(38100700002)(6512007)(66946007)(186003)(26005)(2906002)(31696002)(83380400001)(38350700002)(66556008)(52116002)(53546011)(6666004)(6506007)(86362001)(5660300002)(66476007)(44832011)(8936002)(966005)(6486002)(508600001)(4326008)(8676002)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?b25ZWFNpalZZdjg4dE4zcTAyZjg5R3NjQnJXaHZkN3dTNU80cVVoQzc3OTRw?=
 =?utf-8?B?L2NhQUpNSHk0YVRibTE3d1VYOXdLOEh3aUUrYW5ISE1OckZPS0o1VkVSVVJr?=
 =?utf-8?B?VVFGRmRIdm9CQjlqTWF0OGxmUWRUdXVzOHJ4TmE5b29mVitYOTRFYTBhNmhM?=
 =?utf-8?B?dS9QSjFrNHVtSEJyMWd6SlhEeFVLTDNPV083NkNMOGNqY2pjSElwK2tBdnVD?=
 =?utf-8?B?UEtYOXFiV3NPeDY0UFZGNTV5YkxyY2IxMlJlQlFXY1c2K1hGWXBKUWdIOGRo?=
 =?utf-8?B?NlRmUnNURDZOVHJLMXVMbHZVMnl4bjg0T3lsTUcvYVQ1Uktpa24zRHA5d0lY?=
 =?utf-8?B?MVZXSW85TjVDN0xHWGpQN2xmWWNuU1ByVDVUcnp0WmNDZ0plalpHWlRZZzVr?=
 =?utf-8?B?Q09tdGE2WHIwcHpjNkV5OFp4eEpGT29tQWEyMy9kVFhacmljSW9tcW01dEc5?=
 =?utf-8?B?amVRRnlDTmNldnNWWFY4M2dFV1FQRmttbk5aR3lpMDN4cUF6c0dXOUg1TkpC?=
 =?utf-8?B?L2MyUGJJM29mNEkzcXVZdS9ZYUtXeXJhS2svdEh1M3M4eklvZHB1cUlYYllO?=
 =?utf-8?B?NU1ia3djbXltRW1IUjAzV1A0RDZMUjBGRzA4WENLa3N3cS9PQklmOXBCWXcv?=
 =?utf-8?B?VFk4Y2VlYWNPdDNSMmRmMzZSRWVyejdUVlowV1NEZ0FzOGUyOUdEdHdBVW9G?=
 =?utf-8?B?S1RDeitGUlFqbHA5WVVMREFRV1hyZ05jTzZ2dnBWWllsa3hWNVJsbERnSG9Z?=
 =?utf-8?B?Z0JLT2g0RzFFaFp0U0VlYUZvVGxWenA0L1IyL1A0cE5XY2ZFWVpCcXA2NmFK?=
 =?utf-8?B?KyswbUFIdHhYNDF1Zkw2bGpsam9WOHRjczI1L3NGRkdOcUdGckd0bTVrNEJH?=
 =?utf-8?B?d0YyWmRmT0FMUEV4YXoyazlBWlgrS0wwR3JrNGhtcHBSN1l1N3p6VVBZcDJO?=
 =?utf-8?B?Tk9qTlJualM2UGtic0V4cUJ4bmlDU2NidHZqdkxUcUpCbWZNdjAzekhvSVla?=
 =?utf-8?B?d0hReEpTMk02QjhCRk8vbmV5bnNRTGpzdkZJTDZaRXh2WkxxM2Z6c3IzYy9m?=
 =?utf-8?B?ZTlZak1RYVJTS28zS09Idk9mbUlvTTZVV3hKdkJ5YTVCbkJEazRvTTRZanZZ?=
 =?utf-8?B?eVpmRnFLTTFOUkRRNmREdlU5bmQzcUxxYlo2Q1ZySnUrTFpKZjVtd1h2ZUpN?=
 =?utf-8?B?YUpoVzhjdUQzMVo5cERyRlViNUpZSEFObll6Rlo1UlVuSkZhQ2h3VUNpOFZU?=
 =?utf-8?B?R0FQdGZCbEZmQzZXNTZQNytOWEprRjFsck92MkhvcUxXTnVSTThyV1EvYWZs?=
 =?utf-8?B?dDBHa25IUHFpNjZLVnVZS1d2bDh0cU5zR2tLTmVhQVovV1l5b0ZzRXZqSmhH?=
 =?utf-8?B?ajlORDQxcjZXbC9qcHR2cWVib0xGSnIrQmg1WC94b0ZTOU8xcWE2TzRRVGFP?=
 =?utf-8?B?ZUVMbVlUaVlpWUw4azdTZ1pkMFFSWE1EeUQzTDhkSGoyR2doSWt0ME1JQ0I4?=
 =?utf-8?B?bGxWWEZHenJseHNkcXdKYWZibHVpTWJWM3lqakVMa3RmckQ3UWxFNW8yWGxU?=
 =?utf-8?B?M3FrY2NmZWxaSnM3aDhnYlg1VjdQUW9MVk9pbm1CSUdzdGFJR2JIOHMwSkJO?=
 =?utf-8?B?SUF3ekxFNDY1TjdZNFBmNFJXSXg2VzN0aS9TckhIU2FNa3Erb0cvKzVMWHdK?=
 =?utf-8?B?TnJyVnlZaHZzZVNBaGZFWFYranRmUTdEQ09ISDNkQTN4QmtQRnZSd2xJRDIz?=
 =?utf-8?B?aitFNFZZd0pwZnBRZFY2dVpuTVRBSDRHOGM2akUvdWhvOUhyT0VTRlZLYlVO?=
 =?utf-8?B?V1kxdFBsZWx2Mmw2SWpGWGZYQXVVQktxaVh2Yy9aTTRnWE5kcWhMZHRkQmt5?=
 =?utf-8?B?cW9lS1hTNStaeFY4Ym1QS0dkR0lUOFdzUXJTRDJ5MUJxam1Qd2V6emRZY29D?=
 =?utf-8?B?OWQ5RTB1eTc2YlNDZTZvRlFJa2RqL2g4R3RuT3A5MndVL1lILy9vQjRFWHlo?=
 =?utf-8?Q?7/2zYSHlK82PeIfpKwndHww0jyKf3Y=3D?=
X-OriginatorOrg: cornelisnetworks.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 266f1ad1-9c51-4c3e-0296-08da08fb74ab
X-MS-Exchange-CrossTenant-AuthSource: PH0PR01MB6439.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2022 16:22:11.5555
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4dbdb7da-74ee-4b45-8747-ef5ce5ebe68a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sEV3S6s2+1x5MG++QSA7RTvXNwnXt9uCnY3TvkihA4k91o8PwlnwgBttM/HDyTgXhzr5FB7EMFQhI7xiTprArZ0zH4TFiiGVSrI/gxJBTMwiVnPTzH6n+TJhm8LCVn3Q
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR01MB5780
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


On 3/17/22 9:00 PM, cgel.zte@gmail.com wrote:
> From: Minghao Chi <chi.minghao@zte.com.cn>
> 
> As stated in [1], dma_set_mask() with a 64-bit mask will never fail if
> dev->dma_mask is non-NULL.
> So, if it fails, the 32 bits case will also fail for the same reason.
> 
> Simplify code and remove some dead code accordingly.
> 
> [1]: https://lkml.org/lkml/2021/6/7/398
> 
> Reported-by: Zeal Robot <zealci@zte.com.cn>
> Signed-off-by: Minghao Chi <chi.minghao@zte.com.cn>
> ---
>  drivers/infiniband/hw/hfi1/pcie.c | 3 ---
>  1 file changed, 3 deletions(-)
> 
> diff --git a/drivers/infiniband/hw/hfi1/pcie.c b/drivers/infiniband/hw/hfi1/pcie.c
> index a0802332c8cb..b8394cd358a9 100644
> --- a/drivers/infiniband/hw/hfi1/pcie.c
> +++ b/drivers/infiniband/hw/hfi1/pcie.c
> @@ -57,11 +57,8 @@ int hfi1_pcie_init(struct hfi1_devdata *dd)
>  		 * do not setup 64 bit maps on systems with 2GB or less
>  		 * memory installed.
>  		 */

Please remove the comment also since it no longer applies.

> -		ret = dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(32));
> -		if (ret) {
>  		dd_dev_err(dd, "Unable to set DMA mask: %d\n", ret);
>  		goto bail;

Also then unindent these two lines.

> -		}
>  	}
>  
>  	pci_set_master(pdev);

-Denny
