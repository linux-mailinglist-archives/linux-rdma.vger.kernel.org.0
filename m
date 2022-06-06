Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 331A453E7B7
	for <lists+linux-rdma@lfdr.de>; Mon,  6 Jun 2022 19:07:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236063AbiFFL6k (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 6 Jun 2022 07:58:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236143AbiFFL6L (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 6 Jun 2022 07:58:11 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2124.outbound.protection.outlook.com [40.107.92.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 441EC386;
        Mon,  6 Jun 2022 04:57:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mOwYiR2EHwzycFjzTx/aEcldlL0nhxsxdSQctL/k5SMgSXAhbFSkqLX4FQr5zvC4DqQ0zEWHWZRTzWFAfpf+e0rmdlI641wBte+uWwSEqUXucJI1z2wATcbQr4UqL0HCrpznlWJq2G831H87C/ujFOjqhfFMkQ3tlQrKXk2O5DC+VUiobg5ZMS4q+dynqRn2J3M4fsgeM+G9F3BG6urVZmCI+gxCTwe60LqowSLPltG0CL/TDKmsHSCUuDbalnP412oFH4yAyGUFxnwSEF7mgTVjS/IGQnG9w0lSJkrZayE3QHAKHcnWqGJ/QYDhBieh3E1V84aw6p9PoR8ZPLm6rA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iujoaCyOWou+9ZXTZ6H6rJwyuLxzDQ+J9htUPFHXmHg=;
 b=fnSToye7QfopktG7nsRNf43Zl+UuBAt+DyVN3YBwM0iJ47Qz5lqOnVAbNb6VZvf0myGS+OEaEBFV8FqnYUhUQHmdTyek9+AcMTlL1vpO3O+EjMbcz0uYro1cDz1XQ3m8EVdvXA9B2ize/LyJAPe4pRITg++Nd73iRKU3aIf/KW241blvCStGRQDUt372lnPIfsbrfh/Y1kB5cLckHHMonWE5ByzF310yGjAjg/eUkWNcKShQY2SF/BCYBlCU1qmppR/BN695CEupB67yipzQr2IbZaZf7iQyQ3E8Iiynz/HSEh4HRxQ4nUJ1Kpn6g4ejQrs9pYYaWA9xgrAbElbi4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cornelisnetworks.com; dmarc=pass action=none
 header.from=cornelisnetworks.com; dkim=pass header.d=cornelisnetworks.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cornelisnetworks.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iujoaCyOWou+9ZXTZ6H6rJwyuLxzDQ+J9htUPFHXmHg=;
 b=f9Wygmb255doeYFtWh7i+OK9CZx9ax9tyKtRA24R3e8vqpTJNyy9xmnKlmR37u3U6yCVbFK0YoEI33fQqoMu4h+2/5H+msHpNQr6nJ4GQwMUVkj6PDGHB3xkBplxzAFA+jwJG/EUKbBC9KMfGClktbKwFeYbIr580DLpuxzSLnyIKDhuBGU1vTPiseR2/gcEW+3PnOLzyxXq+aDT8vBV9OCF7emT+oPph4Ls6uoS9xGJXIjgTpSVRLWPgJq96NpaaHhlMhGIbX7Oiq8P4eXJe18K9dHXB9qVe+ruSe+gtHfUnhas6WZGAdErIH1HJAasws6Pl2k3QXNUMbEIo5vDCg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cornelisnetworks.com;
Received: from PH0PR01MB6439.prod.exchangelabs.com (2603:10b6:510:d::22) by
 BL0PR01MB4145.prod.exchangelabs.com (2603:10b6:208:47::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5314.15; Mon, 6 Jun 2022 11:57:29 +0000
Received: from PH0PR01MB6439.prod.exchangelabs.com
 ([fe80::bd41:9ade:6b17:e6d]) by PH0PR01MB6439.prod.exchangelabs.com
 ([fe80::bd41:9ade:6b17:e6d%5]) with mapi id 15.20.5314.019; Mon, 6 Jun 2022
 11:57:28 +0000
Message-ID: <44f9d01f-d928-c430-00fa-229d6bb5550d@cornelisnetworks.com>
Date:   Mon, 6 Jun 2022 07:57:24 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.9.1
Subject: Re: [PATCH] RDMA/hw/hfi1/pio_copy: Fix syntax errors in comments
Content-Language: en-US
To:     Xiang wangx <wangxiang@cdjrlc.com>, jgg@ziepe.ca, leon@kernel.org,
        linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220605090508.12124-1-wangxiang@cdjrlc.com>
From:   Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
In-Reply-To: <20220605090508.12124-1-wangxiang@cdjrlc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BL1PR13CA0411.namprd13.prod.outlook.com
 (2603:10b6:208:2c2::26) To PH0PR01MB6439.prod.exchangelabs.com
 (2603:10b6:510:d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ea10930b-b4b7-4df9-2252-08da47b3baea
X-MS-TrafficTypeDiagnostic: BL0PR01MB4145:EE_
X-Microsoft-Antispam-PRVS: <BL0PR01MB4145A206FAD6F30C75763496F4A29@BL0PR01MB4145.prod.exchangelabs.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VSQv857efsZ1z7ZIWRugavc2i1+25Hs2y2DWONShrjhJceQK6NxesclF/z/wL5dre7IYMFiaEhzJ6a6z74tIVc7yPFl1hsuST916En9vtkDYCfok3KF5ADQRfZ984hbmsilrOlEovgrwEKPMwNYQOV/iLlXTWUEhmqNPoPa5zROya+9Lz2auCcNQhHVh+ZelT1W8WXh/n5pDDyUM7uP/YdlSkBSCjr6h8UiBjIM6NiP0DtIfH3jyTiA+iT9EqKkzis5G8x7h2qjMhtfD7tZcTS/3NnAzy1DOV2VxCcSzP1atKwJhVZ14KXq/9CbOejo1l1wCpVKSkNPwqj4qAhph7pHHRVWYaMa1AdgRSBtbwj/jtBS2EZWIE92xgUoQOT2gEkx78hiZoQHPMMDy4H2WAjI8T/6XwRMwonZBqJiA/g4LEp3JgsIrXSkbNEL/ClekXa8J+ZepTIRTFA858B5rJ6Mf7edH+IOnX3m4r/lWxGGXtcQ8pUBnY9CjE+QfCS4uodbVffkP5teJ8cR5KEV5PQCBLYgFbBWMGmwnIBS4xj3THrBOz+FYD3CwkbpYgoGGKeINSXHv7oQhwPO7sGmqLpK4800+WKVFaISx3rtsbCoU5vx1IRRyNUbFaxfxXPJf2uUovmY3dP9sy5gAWjDxMlg4GhLKce5M0L1X9qIW5h6LsFDStAkspkeci4ErvHWsbM7jb+DO0b2rtQPoD9fQzxr9rLT+34gNykGYJbIrgO4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR01MB6439.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(39830400003)(366004)(136003)(346002)(396003)(376002)(2616005)(38100700002)(186003)(6486002)(38350700002)(41300700001)(8676002)(36756003)(66476007)(66946007)(66556008)(31686004)(83380400001)(316002)(53546011)(52116002)(31696002)(6506007)(8936002)(4744005)(44832011)(5660300002)(508600001)(26005)(6512007)(86362001)(6666004)(2906002)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WG5Odi90OUUzaVlQdTdZc2NRcnNiaWRTWUVUNUlpZnpQLzhWRzFPR3hDYk5W?=
 =?utf-8?B?bnNldnYyQm5oWjU0SWhuN1BOOVVndmFickxWMWFidnlQQ0JRYVExeG1PZ3BO?=
 =?utf-8?B?WGF2Ym94NzZyMFFpcXI3cW5WT3Q5MWo0VnBUYWN0ejNhaEk4UUJpWEo3OUcz?=
 =?utf-8?B?b05la2VzTjF6UjVPYXVvSjlWeFlGYmF4WGlrNmhhNWdIVXNnSG9mQnpjZ1Jx?=
 =?utf-8?B?MWYrRzNBRitvUjJOODdSZ09hRDJJeDFjRGN4c09kNll2SFpMY0NLajRkZE1Z?=
 =?utf-8?B?YVgvMVkvT05xd3J6OTcxZXNiTncvNnRLS1diSjJvNHlXNXhXUmJkQmNETFYz?=
 =?utf-8?B?YkRteTV0NFRUWWZjeUQ5bU9Nd2RGZnBLOVhSVjdiM2NWMHJyUzUrVDV1Q3hz?=
 =?utf-8?B?UFdwcUhDK0FISDRGMG5nUVFsM00yY1U1bzh2MC9BbUs3ekpFSjhVem5xSXFt?=
 =?utf-8?B?bURTK2todDdEWGtWbWxCZnNydjdPN2w3cUh3aFhnNlNGTDJIM08vSWFpdkpq?=
 =?utf-8?B?YmJuMGplWTFVeXZoSmJKUFBramh0SlU5UzlWRUhyQ3BkRTZCSTBQaUI5SXdx?=
 =?utf-8?B?ZFhSSFdqL2lZYXBCVW9ISDlKQkQ4NE9BTU9Td2J0ZEZYck0zb3ByN2VPcVJn?=
 =?utf-8?B?Uy8rTkhxaEFIYXRPbHVYS0xUY3A2cDR1M25CTjhnQXhiWFhKUGNFUGZaMGIv?=
 =?utf-8?B?dm8zNWZUcHdtSG44MHJIZlVYWEhyVjkyMEJacVZ5cXdMTUdVbS84VG5STkVI?=
 =?utf-8?B?N2k0Zm9HTTR6SXJwSHdENVB0MnBVQ00wTGo2QWI5d0w5TS9hUlVnOE1BVWs2?=
 =?utf-8?B?RVhJUEVaSXh2cElGZndsUmk3QWRiYXdNTSttd1dNTWMxVU91Mm1NYlhoV2dI?=
 =?utf-8?B?bHU2YzRmbWFuWk9YVVdtS1hHbGlDQm1KMDhKWmF5RkdQaHRtemhkSFZYdDNk?=
 =?utf-8?B?S1RKTUNGTklSUUNTZmc3OE9ZaHE2dTZKSHhodjR5d0xpbUVaOWtoeTRzMjVO?=
 =?utf-8?B?YVkyS0pMU3I1S3NYN0hlZkFqYUt1S1VObzVOVm5PVDI3b2Z5NGdLVC9id1ZZ?=
 =?utf-8?B?ZVhYWEY5VFpmWW4rekxtdmUvTm5HOFJnOXNFUEVjTU9yeUJZTWd2MlUya1o2?=
 =?utf-8?B?V2hmUTFJWWNndWFQNlBkcmorQ3BZaGx0RGhTa05JRjZpeDhrbEd6MGVIZ01j?=
 =?utf-8?B?UUVxK3dGLzBkM1F2YlRBYmNSWTlHS0FtNWQrby9CTlhVV0ptczU4bDliLy9W?=
 =?utf-8?B?eTF0bnNhTWhTeEVyaklSNXpiQ3VkZm1GajduZGc0RkFYeWVjVE5zS3p2ZFVG?=
 =?utf-8?B?ODRVc1hydUxqODNyVnNqNUJxc0dsZ0xlSUswMnNDdzY1Wit3dWswTTlNbmtL?=
 =?utf-8?B?QzE2a2V3a25JVHdvN3NYQnJiUllZM1h3WTc2VUMyU3ViT2psZzNFQ25kbDNY?=
 =?utf-8?B?SVJMMVhnZjVsR1BuT2JlRHB2Qy9TWXpsemtWckZMZysyeTN3NVU4QlQ4WlEv?=
 =?utf-8?B?MTNlSVhWUms2Y1V3czlCYWZvWDgzNDFTOGZYM1E4S01od3BFek5TT0xlNUcv?=
 =?utf-8?B?Mkg1TzVURWFsbFdHajlUODlNelBrTTJsd0tpTFRxYUJOTFFGeDJDMHlZeU93?=
 =?utf-8?B?Ukx0TkNrdkd1eDR5TXZlaExDZDVMSkJQQWdsNXlveDRhQ1hhNjhCRkhkWWRX?=
 =?utf-8?B?ZTBsWHdiSVhxdHNnMEdSN1FoRjVHa2VZSDlLcUk0NXNpS2hrM2JBdTZ2RGM0?=
 =?utf-8?B?SkE3V2NkTmhWL2x3dWxlSmp3Y2d2ZDAyM2xybjNvYi95U0ZzcGVqbCtGY1M5?=
 =?utf-8?B?VnM5UmNNSDI4Z2J4bndyQ2M1WkJNY3c1S3hYRjlXZWZ2NHVkZkM1Mnd6a0dI?=
 =?utf-8?B?OGxBUURpa2NDVnFNR2duR2VocTl3ZDdLcFlFRWhLU290dzVTZGgvRXpIb01h?=
 =?utf-8?B?YTBDVWZ6M3pHbFJ5TURya1lHbC82UmUrVm1HQTNnMmNGUFZ5a2RPeXNJWUlw?=
 =?utf-8?B?aDcyTUYvcmQ2ODEwc3VPMm5QQVZwOWNKZEZJQloxOFdrWUFtRWs1VmdsWG4x?=
 =?utf-8?B?Tzh3VjE4VzQ4U2xtME4yUmFKQ1N0MS94dWlzUnlvaFpaSzV4U1RaV3Y0bita?=
 =?utf-8?B?RDMrMXh4b0trYW1tdU5DTFllNnI3ZTJ0TnFrUGU4YzlNZFhXa29MTkFVakxQ?=
 =?utf-8?B?TG1VM1REaGZnTTNsWHprZHNnRkkxajZsTUxtN09ZWktKSmtxYUowT3BqdG9T?=
 =?utf-8?B?cW1pU1NLbXdaN2hhSkc4KzFjK1FaTTRPK0I3TS9odlBqT1YrSm9rdlJkWmJn?=
 =?utf-8?B?WCtLLzczS2dXMktKNzBRTXBtdUtIMlAzYXE4ZUpJUUlpUnNiK1JvcXYzY0hU?=
 =?utf-8?Q?vwea4MynnmxfKlmro0b7GGypko7cR1WEQOcSw?=
X-OriginatorOrg: cornelisnetworks.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ea10930b-b4b7-4df9-2252-08da47b3baea
X-MS-Exchange-CrossTenant-AuthSource: PH0PR01MB6439.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2022 11:57:28.9001
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4dbdb7da-74ee-4b45-8747-ef5ce5ebe68a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: z3346C7cPwYOyPlrIr6gd9TUwzS51kWFrwvS/QLvfcreLn4dx3oA7wrSunhn9617R4TBzPn3mj4L7NUhF6bqD0EKrxtqut94w2GgbQs9npyvnnMqZyOII4ZS6J0AmfO9
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR01MB4145
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 6/5/22 5:05 AM, Xiang wangx wrote:
> Delete the redundant word 'and'.
> 
> Signed-off-by: Xiang wangx <wangxiang@cdjrlc.com>
> ---
>  drivers/infiniband/hw/hfi1/pio_copy.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/infiniband/hw/hfi1/pio_copy.c b/drivers/infiniband/hw/hfi1/pio_copy.c
> index 136f9a99e1e0..7690f996d5e3 100644
> --- a/drivers/infiniband/hw/hfi1/pio_copy.c
> +++ b/drivers/infiniband/hw/hfi1/pio_copy.c
> @@ -172,7 +172,7 @@ static inline void jcopy(u8 *dest, const u8 *src, u32 n)
>  }
>  
>  /*
> - * Read nbytes from "from" and and place them in the low bytes
> + * Read nbytes from "from" and place them in the low bytes
>   * of pbuf->carry.  Other bytes are left as-is.  Any previous
>   * value in pbuf->carry is lost.
>   *

Don't know that I would call this a "syntax" error. Perhaps change subject to
say "Fix typo in comment"

-Denny
