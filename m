Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6B8B5701B2
	for <lists+linux-rdma@lfdr.de>; Mon, 11 Jul 2022 14:08:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231515AbiGKMIf (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 11 Jul 2022 08:08:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231492AbiGKMI3 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 11 Jul 2022 08:08:29 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2110.outbound.protection.outlook.com [40.107.220.110])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6264245046;
        Mon, 11 Jul 2022 05:08:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hOT0ZWhTd2HMNpviItGzusGAtFmN7ru3YtceEpq9aYKcJN35h0FKKie9M7xcdVZOnXjVhWNko7pU9/EhjV1KJHFezKFV7WWl23tozC5mmOFRCrZOsmz86G3+uZalkwAlBdc9ML8z8aQ8TFMrskx0RCqHuGHGzM79CMq0ugtdrQKSdSx4rFED/eGpRu9bJcFP+McDG606bCuC0B2cYrMyLxE4hPGlMEbFP0v+kvwrzWRpqDSpkv5bxk2auzizIlo1OjgzOoq6A4WuMmFVg2tmjZDUVDMWgfQ05k4b7rfxG2dwEyRK0Ayh3d77klEHrp79EDwB6cmZg9DBjBHSjT0TNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t/jS2/UZT4bHRkqCW/hjmeFyzj/muosh5gA1AzzmIsw=;
 b=Ye9RF5nE/zE2LUgrZyIE2PxTRGYQdS+oGi+kfZtBt666iWnywB1zkS8OWz4DjuhK3vhuTr7F3FXbi+GpljfFpWY1djpK85k22cS2lIBS8fnLszpTav8mSh9fHJoOQgz1BcztDpFdonRfv5oAJo4rdAQ0oiUPI+CIVzCsaMpnsmUTjno/9uYFwL9GxU28u49RGPb7dHTfOx1OZYXB4XY4qkhj1bu69G0hyD2YHld70/zI8Jr5VBzV0BS1X9069a/f4OOS1dHjGw1gEoG0kMKbzfPj6wL6JRtLT83AIBsBS/YwjCIXK6D9WbhMZHHeE/495XQHwOBuoUoyh2UhLt3K+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cornelisnetworks.com; dmarc=pass action=none
 header.from=cornelisnetworks.com; dkim=pass header.d=cornelisnetworks.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cornelisnetworks.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t/jS2/UZT4bHRkqCW/hjmeFyzj/muosh5gA1AzzmIsw=;
 b=Fsv02phgvzl2Stjr3vV2IxcqWiuzrTzwFmeKBccFQ0WW1Dsd3SG+hzoHE0OBzxAwgmka/fGwalhv6KWijvSM5ikjs3So++S3TA8u422Qjrx71w0yQBWKgfsEKv1qxl7w6WDNNeZYvhwIIKu29bQTv/CbNsRZh9Ib7F0G76J2zUJtTu3U5yK7b5GXvlFIaKnwV0VzXuK4nHgF9CUhKK1bQmjMLwO7BLA1PmeFbcmt8MvaVLmLKhhjNqwesExiYIGmGihVyVz0LF5dBW1DirPt5X2kXLs34x3UL6TLkbgTkl2ukzraDjeOpGNyfFPwf3pm9gfsCPg3RPGQe3ndBcW3tw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cornelisnetworks.com;
Received: from PH0PR01MB6439.prod.exchangelabs.com (2603:10b6:510:d::22) by
 MN0PR01MB7804.prod.exchangelabs.com (2603:10b6:208:37f::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5417.26; Mon, 11 Jul 2022 12:08:24 +0000
Received: from PH0PR01MB6439.prod.exchangelabs.com
 ([fe80::4000:7ba9:d4a:c339]) by PH0PR01MB6439.prod.exchangelabs.com
 ([fe80::4000:7ba9:d4a:c339%7]) with mapi id 15.20.5417.026; Mon, 11 Jul 2022
 12:08:24 +0000
Message-ID: <e4084801-0295-84c1-1bc1-dbf94483d542@cornelisnetworks.com>
Date:   Mon, 11 Jul 2022 08:08:21 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.11.0
Subject: Re: [PATCH] RDMA/qib: Use the bitmap API to allocate bitmaps
Content-Language: en-US
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Leon Romanovsky <leon@kernel.org>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-rdma@vger.kernel.org
References: <f7a8588447679e80a438b6188b0603c1a11ad877.1657300671.git.christophe.jaillet@wanadoo.fr>
From:   Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
In-Reply-To: <f7a8588447679e80a438b6188b0603c1a11ad877.1657300671.git.christophe.jaillet@wanadoo.fr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BL1PR13CA0070.namprd13.prod.outlook.com
 (2603:10b6:208:2b8::15) To PH0PR01MB6439.prod.exchangelabs.com
 (2603:10b6:510:d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7b1798f2-0372-41ca-21ee-08da63360e02
X-MS-TrafficTypeDiagnostic: MN0PR01MB7804:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NA5lz/RLhpX1yErcJ+eXKL6CHpjIWM3t2xKqGLJ6LxhHuOI+AHwltLh57ZlnQUmSbhPuow3CX7spYYLXEHUVT0uoqnhdn3t/RV7y7OP97nW0JdkUi9q/WbBW3CCnRdmFB6+cjDrD2ByBajcLsuRHMoe5Of+o/b9/WTDuHFTLlrIr7AQojl4Z6ARfDT7jGxK+mlPHCTlbadetNqJbiz7NBkDcUAo4feekFuVS55N/pRXjENIM7xPm3k07Za3aUe078kiTBlbYC+abkRcF3ExhUEzxlAuQ/hi28mtWUSigwTCAIz85RFZVSqEB1ZYap2Vj/p+zCZke9k2AYwP2ggocSVmlfsIaL0nDvVtsirLcfJBfVvONBQOTuivkTc97+a6siOJQVa9NjVxA34sZ7va6j6EBqPqHqtxB5G4MrYMZFYz9g4BdaR0zbQC3vDfGkzmf9W9s7rXfzy5lWkPDne0hY7gbuOZLsWc686EMeOIlTEiEzawHmeeTYkxggbgb5ugUZpKT+Muc+iQZy5bRiOqgkUd3e/udoHvNdGkIfSsGQqjz9YXg0tEZzo6+FrgNikheGL71g/koxV8W9K+5DqdWehgNE869R2LGchDTjt4uc2DSZfuI2g1M3Vh66dGHdDV2HmOMKTYRXgC3gl2WZKa1BCp1OEES3jTPQisTPlBeBhrQJATbGvmZDNtyiSDJU+zBeqZ/o0YPpA5BP4uJGw7RvITgD994kmMtDv2dPUuELNmav936wQMflzi9iIOb4n+qtoi9k4o4RWRxku+BcWAMYCQd7Sai57mf4YWRpEY21CkcINDjxFwv7YHvstr3bmjex9wUF2JaBldfU/jU8F0vQeMRrtBAXCvIzwhhLU7NXq0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR01MB6439.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(136003)(376002)(366004)(396003)(39830400003)(346002)(66946007)(66476007)(66556008)(6512007)(86362001)(8676002)(186003)(6666004)(53546011)(52116002)(6506007)(478600001)(4326008)(26005)(31696002)(6486002)(2616005)(110136005)(41300700001)(38100700002)(316002)(38350700002)(5660300002)(2906002)(31686004)(36756003)(44832011)(83380400001)(8936002)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SlYzZkwrNDBvcko2b0tRQnVYTGU1eFg3bmxMdHFVUnVDTDltT0p2UGxvUlpE?=
 =?utf-8?B?aHU5KzNKeWV2MkM5empvZ28xZTFFallXc2NlQjljYm84cE9mdFBHMlRRUWtm?=
 =?utf-8?B?djdBdDM3d1d1MjZycys4em9td0VQU2xBME1XRlZEUm1VR3gwaHlmdzY0ZmtL?=
 =?utf-8?B?QmhvaytORTAxTWMwb3VabUVUZTBGcXlvVmdiTm9MZEVUTzNCTzF0U1N5QkQr?=
 =?utf-8?B?VXp0Q04zcU5GWUIzRmJ3MkhrZEhCMFN3K01VTW13anREcjVDRnVQbkg3WXhl?=
 =?utf-8?B?NFdjVkNyQUhaUjFydmxJV21SNERoVlNjQk9wbGREdE5PbWZ5ekdJZmo4RlZ0?=
 =?utf-8?B?cDA0Y3UyZTJCVWM0K25ZUE9xbHg3ZEpJTFZIak1kR3hDVUZxRTE5ZFBXbXBr?=
 =?utf-8?B?bkt3cTdzVE04V2Nvd29rZW92WllOSkJCV2d0WFQ2a2lJRFNSRUVjOUo5a2k4?=
 =?utf-8?B?dFJrV0xJVzI0aTg2Sis5L2RsOGFEWWIxUElzRUZmaE5TQWhzR2hWaFRtZjFY?=
 =?utf-8?B?YThWdXZ5YWNIbzlUNkFPaVBFeHRteU5RaU04QVpaM29yejFHSFJKYWd2cWg3?=
 =?utf-8?B?Zjkrc1hBWnJTYSsvYVIrR1N6RHE5NjhyT3g5Mi9BcUJTVE9CdldaSFFlNG40?=
 =?utf-8?B?S2JjWFhaUnVvZ29BS1JFcUVlL1pJRHFqSi9zdlAvOEd3VWxNOHphYmZYNEc1?=
 =?utf-8?B?blljVnNPU29vdWhPb2U4blFMU1lVemluekVLemN3eHFaS1JrOFN0VmZVUFpE?=
 =?utf-8?B?SE9WVEFrazdNOG02ZXQxR3l5VUxzb0llWElDUUJoalBKMU45aVpRa1Q3amww?=
 =?utf-8?B?akxta0lHRFl4V3ZtUnJFNzFzNFV5aUUxanhGUDdISlNibUovWHJiYk1PY0dx?=
 =?utf-8?B?RUM5aSs2UDdTM0pCYkxiR2ZBRHZrUmdzdFY4eERXbXdTVmxDSDVkelpMdmlE?=
 =?utf-8?B?aGpacFczM2NhTW5EUEN1dVJHWHphaDJ3bUhMK3dkWnJlaHBpRG0ySzhpYTcx?=
 =?utf-8?B?cDRta1c2Y0FweW8zRThKc1lUbFd6TXZvdUtKOVMzY1hEaDNqNlhXY2N1azkr?=
 =?utf-8?B?NnNRUWJ5Q2xYUjhpYWhhWm9RYXA4enprSjEzN29sL2VwNXdGNkt6eUNYeEsy?=
 =?utf-8?B?TEdDdWJVaUw3VmNNQnVDN25qcy9iMUtuSDFuSnBjeVFKRmxBd2pBNEZIdHhL?=
 =?utf-8?B?eldhWTBtVmlweWRPRzVtRlNzYWRJTGVzVDNreG1kUkVoN0pBUlRXdzdta1JJ?=
 =?utf-8?B?ZEd2VmxhcDVJVGRic1Z2ejgyQzhNNVJtaFJuUjJ5eVNxRmxtQjMrSXk1RUdo?=
 =?utf-8?B?WVNLQzVBUUpCTTNTbCtKWmRrQWxhQWk5ZFh4NXJhZEVJL01qUHF4ZFY4U0dm?=
 =?utf-8?B?cVovTnc4a0Y5a2FXN2FubzN3R1Vab3Z5Z3BobjRjMC8yYzZzVEtIcGtpZUlE?=
 =?utf-8?B?Ui9PYXgzM21GSHk1eGtlLzRiOXBCL0VyUWsyOTFBa3pscnA1L0JwcWhibXgy?=
 =?utf-8?B?ZXBCQVVDZ1dnQmc2dm4wVDU1WGRsVU9pcysyOVpLeWNDd2Z5YlNGRVNoUzhO?=
 =?utf-8?B?cWo3amR4YXc1L0JWUGZ1VTgzc1hPYWNzZ1lFZGNlOEFOeE41Ukt1WXpTUFJr?=
 =?utf-8?B?NUhDSFViRkdtRHN3c3JRV1FXMElheEJpcG5nYjJEYW0xWnd3cmZrOVJqejNv?=
 =?utf-8?B?NFBTZzlPcWt2WVF3TXduQUxZUm51cWJkNnc1ajBrYVAzMFg2NGI3Uy9Rd040?=
 =?utf-8?B?NmZuTTBDZWtVVTJyYlQ2MWpWWjJ1V3VZbTZTbVVUQTJKZEd3Z1ZDREI5STJT?=
 =?utf-8?B?YjRqRmxId2locVA1VjcrUHllKzd6QlVRVHQyZndJWWd3cjNJTjlkdk1ndkNH?=
 =?utf-8?B?OTFHQzdFOXl3MUJiNU1wblBPRnhJRUJCWXkzMmkxNjRRcmx6MmY0bUk2UUc0?=
 =?utf-8?B?SzFiT2RzY3RuWkRhWmVkcTM0Sk43YnBkdmtMM0VCWnV6V0NZOHN1VVh4bXVs?=
 =?utf-8?B?WFhpWjhISTB0Mytmdjh3YnRGWHNCVFNRSm51Q1ppY0dFS0lTNXVQRkJTWUZ6?=
 =?utf-8?B?L1pEL2hhay9NdkFqV1Y4alFpSjRZSzFXczlWQzRORndJR01SQmdiSWY4N2Jx?=
 =?utf-8?B?UkJ4WWpTMW9EUTc2alBOcFU2ZXFOTUpOb0txcmRWTlE4bldiKzJWQms2NUVU?=
 =?utf-8?Q?6o47N2DTUv9HVgMQJHrIMVo=3D?=
X-OriginatorOrg: cornelisnetworks.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b1798f2-0372-41ca-21ee-08da63360e02
X-MS-Exchange-CrossTenant-AuthSource: PH0PR01MB6439.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2022 12:08:24.2468
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4dbdb7da-74ee-4b45-8747-ef5ce5ebe68a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cDz4zLZ7j3ZX13Rhy5EMZMipr5BdlOLAsceFJDTq7lAbW0LbbkC+1CTCuSUnp+tfiZpkMJAtb2hZlipOeAab1JXfLeFE5P3Dk2i3ntSuRvJXowoh1yGdmRvDLZ/j7dQZ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR01MB7804
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 7/8/22 1:20 PM, Christophe JAILLET wrote:
> Use bitmap_zalloc()/bitmap_free() instead of hand-writing them.
> 
> It is less verbose and it improves the semantic.
> 
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---
>  drivers/infiniband/hw/qib/qib_init.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/infiniband/hw/qib/qib_init.c b/drivers/infiniband/hw/qib/qib_init.c
> index d1a72e89e297..45211008449f 100644
> --- a/drivers/infiniband/hw/qib/qib_init.c
> +++ b/drivers/infiniband/hw/qib/qib_init.c
> @@ -1106,8 +1106,7 @@ struct qib_devdata *qib_alloc_devdata(struct pci_dev *pdev, size_t extra)
>  	if (!qib_cpulist_count) {
>  		u32 count = num_online_cpus();
>  
> -		qib_cpulist = kcalloc(BITS_TO_LONGS(count), sizeof(long),
> -				      GFP_KERNEL);
> +		qib_cpulist = bitmap_zalloc(count, GFP_KERNEL);
>  		if (qib_cpulist)
>  			qib_cpulist_count = count;
>  	}
> @@ -1279,7 +1278,7 @@ static void __exit qib_ib_cleanup(void)
>  #endif
>  
>  	qib_cpulist_count = 0;
> -	kfree(qib_cpulist);
> +	bitmap_free(qib_cpulist);
>  
>  	WARN_ON(!xa_empty(&qib_dev_table));
>  	qib_dev_cleanup();

Looks OK to me.

Reviewed-by: Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
