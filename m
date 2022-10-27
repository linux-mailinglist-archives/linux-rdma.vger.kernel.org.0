Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A42F460F3B1
	for <lists+linux-rdma@lfdr.de>; Thu, 27 Oct 2022 11:29:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235308AbiJ0J3x (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 27 Oct 2022 05:29:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235063AbiJ0J3o (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 27 Oct 2022 05:29:44 -0400
Received: from mail1.bemta37.messagelabs.com (mail1.bemta37.messagelabs.com [85.158.142.112])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CE6FDFC9
        for <linux-rdma@vger.kernel.org>; Thu, 27 Oct 2022 02:29:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fujitsu.com;
        s=170520fj; t=1666862981; i=@fujitsu.com;
        bh=w83NfTQRfI2vweucaYmMQTZhcn/cZIp2q1DqwWOG++U=;
        h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
         In-Reply-To:Content-Type:Content-Transfer-Encoding;
        b=mFx9yMC/jhG948Hnt3Gw5r62W6OyzoTNYRLTFcRJWCietIlGqEP37Yinm/LJjGckz
         L7kFG9ommEQJtRS95lM1D83ATWFKwPqRhEtp4ZYiFq+XuT6ec26XkgeiH23XhzN1wb
         4YhMbpEP7FF4+xLm46jtb/tlY9Qr7sYBBuO4d3wu0Mp+LCZLwQJvGiuFDRhGNN8Kv2
         7N8fChreEECEltXV0AiSa7Gt0yZqeKAc9KYIioQp9NoZF0BoWyScvUPUppT5yMGgCu
         oMIkcywlbBbiQYZNq1MazwLhpovTtT/NP9292tw3pajL/LsBI1mP3rvEJSN8xrYZM2
         Mn5/jrdoWUB+Q==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprMKsWRWlGSWpSXmKPExsViZ8ORpNvqH5V
  s8P8wh8XMGScYLab8Wsps8exQL4sDs8emVZ1sHp83yXls/XybJYA5ijUzLym/IoE1Y8W/Y6wF
  j9kqlj2Qa2B8yNrFyMUhJLCRUeJs23xGCGcxk8TtKReYIJxtjBKn/65j7mLk5OAVsJNYtm4LU
  BUHB4uAqsTCwwIQYUGJkzOfsIDYogIREg8fTQKzhQUCJE73XGIHsZkFxCVuPZnPBNIqIuAkcW
  OpN0RYVeLCrDNMILYQULj1RRfYJjYBDYl7LTcZQWxOAWeJdzf6WCHqLSQWvzkINVJeYvvbOWD
  1EgKKEkc6/7JA2BUSs2a1MUHYahJXz21insAoPAvJpbOQXDQLydhZSMYuYGRZxWhWnFpUllqk
  a6GXVJSZnlGSm5iZo5dYpZuol1qqm5dfVJKha6iXWF6sl1pcrFdcmZuck6KXl1qyiREYPynFK
  e47GI8v+6N3iFGSg0lJlDeRKSpZiC8pP6UyI7E4I76oNCe1+BCjBgeHwIxzc6czSbHk5eelKk
  nw3vMGqhMsSk1PrUjLzAHGOEypBAePkgjvRk+gNG9xQWJucWY6ROoUo6KUOO8WH6CEAEgiozQ
  Prg2WVi4xykoJ8zIyMDAI8RSkFuVmlqDKv2IU52BUEubdCzKFJzOvBG76K6DFTECL18wNA1lc
  koiQkmpgKoluPHG+p9t7spx0eGJP6hKZAzIJf5suvpi8+L60I/vc/SVvZvytvX52FbfXodTo3
  xKvZy922B19zWYxi0lOPeO8Kwt3PM5c33R/xj4fByYBIb+Mc/sj37M909h35oJ1dkTE2bdumw
  907jTR2/lSxFBkWWWrA9c8wVvZE+L/nb6RfTc4e1+83JycmPelEp/OFT1ze1V7JfBUaPf3Ldd
  1a6TWRzVIWH5ZaHTFTPVgns6UVm+zJ6/3tRysu75m+yf5Ja/OadRfF+Oy+xjKc1Z46c3nDRu8
  3fMDnwj6Xls4+U2pwZQJtgpG3DvqHvx/wDrX/93R+SwOkx5e5EySCzdiTDyYmPi2XflLhXTdS
  6YFHEosxRmJhlrMRcWJAHYSwhWmAwAA
X-Env-Sender: lizhijian@fujitsu.com
X-Msg-Ref: server-3.tower-728.messagelabs.com!1666862980!508412!1
X-Originating-IP: [62.60.8.98]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.100.1; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 5040 invoked from network); 27 Oct 2022 09:29:41 -0000
Received: from unknown (HELO n03ukasimr03.n03.fujitsu.local) (62.60.8.98)
  by server-3.tower-728.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP; 27 Oct 2022 09:29:41 -0000
Received: from n03ukasimr03.n03.fujitsu.local (localhost [127.0.0.1])
        by n03ukasimr03.n03.fujitsu.local (Postfix) with ESMTP id 942AB1AB;
        Thu, 27 Oct 2022 10:29:40 +0100 (BST)
Received: from R01UKEXCASM126.r01.fujitsu.local (R01UKEXCASM126 [10.183.43.178])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by n03ukasimr03.n03.fujitsu.local (Postfix) with ESMTPS id 894A873;
        Thu, 27 Oct 2022 10:29:40 +0100 (BST)
Received: from [10.167.226.45] (10.167.226.45) by
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178) with Microsoft SMTP Server
 (TLS) id 15.0.1497.32; Thu, 27 Oct 2022 10:29:38 +0100
Message-ID: <abd2f99a-c6b8-137a-4fca-62632e80bce7@fujitsu.com>
Date:   Thu, 27 Oct 2022 17:29:28 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] RDMA/rxe: Remove the duplicate assignment of
 mr->map_shift
Content-Language: en-US
To:     Xiao Yang <yangx.jy@fujitsu.com>, <linux-rdma@vger.kernel.org>
CC:     <leon@kernel.org>, <jgg@ziepe.ca>
References: <1666855893-145-1-git-send-email-yangx.jy@fujitsu.com>
From:   Li Zhijian <lizhijian@fujitsu.com>
In-Reply-To: <1666855893-145-1-git-send-email-yangx.jy@fujitsu.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.167.226.45]
X-ClientProxiedBy: G08CNEXCHPEKD07.g08.fujitsu.local (10.167.33.80) To
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178)
X-Virus-Scanned: ClamAV using ClamSMTP
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org



On 27/10/2022 15:31, Xiao Yang wrote:
> mr->map_shift is set to ilog2(RXE_BUF_PER_MAP) in both rxe_mr_init()
> and rxe_mr_alloc() so remove the duplicate one in rxe_mr_init().
>
> Signed-off-by: Xiao Yang <yangx.jy@fujitsu.com>
> ---
>   drivers/infiniband/sw/rxe/rxe_mr.c | 1 -
>   1 file changed, 1 deletion(-)
>
> diff --git a/drivers/infiniband/sw/rxe/rxe_mr.c b/drivers/infiniband/sw/rxe/rxe_mr.c
> index d4f10c2d1aa7..279fac4c21d0 100644
> --- a/drivers/infiniband/sw/rxe/rxe_mr.c
> +++ b/drivers/infiniband/sw/rxe/rxe_mr.c
> @@ -62,7 +62,6 @@ static void rxe_mr_init(int access, struct rxe_mr *mr)
>   	mr->rkey = mr->ibmr.rkey = rkey;
>   
>   	mr->state = RXE_MR_STATE_INVALID;
> -	mr->map_shift = ilog2(RXE_BUF_PER_MAP);

Good catch.

Reviewed-by: Li Zhijian <lizhijian@fujitsu.com>


>   }
>   
>   static int rxe_mr_alloc(struct rxe_mr *mr, int num_buf)

