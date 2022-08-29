Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BA2E5A43D2
	for <lists+linux-rdma@lfdr.de>; Mon, 29 Aug 2022 09:37:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229670AbiH2HhF (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 29 Aug 2022 03:37:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229526AbiH2HhD (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 29 Aug 2022 03:37:03 -0400
Received: from mail1.bemta37.messagelabs.com (mail1.bemta37.messagelabs.com [85.158.142.2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 383402E9EA
        for <linux-rdma@vger.kernel.org>; Mon, 29 Aug 2022 00:37:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fujitsu.com;
        s=170520fj; t=1661758620; i=@fujitsu.com;
        bh=IVO7AfzCF4Y/YrSYlRQrpwg0CMspdrFdaDu3QOY+zG8=;
        h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
         In-Reply-To:Content-Type:Content-Transfer-Encoding;
        b=LpZu8jyVnVdcutfdpg9mbDOgjkcuw4G51kW7MTmj5X/yOiDaZSthbqs11ivlT5KKa
         LTuLllC7gtkfR8qjj8nxi/SRzuHHhLgNg4zigfjyRVwVwzdplYkuCLghvtoxm8WEaS
         SnxA91ZsHlT+S56H0fYmAbiLBNougKc3wdqRj4E7GLkcSLF+CGkSC2pD9WE8Nr6kwz
         36v7A+4tRvwmBZMuC1tBMusHVRowmHw7mmhyoUdwgnGqPpuaWzbM3bDGM1pbPGzLxr
         /uWyqXjmtYT4tbHx0jVCgsK3WA7S4sMz8mvTN+Y3T9Qyldl9HIoFgteuTX4Sd+ei4q
         MECwo6S/SxbUA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprPKsWRWlGSWpSXmKPExsViZ8ORpDs7hyf
  Z4PplA4sr//YwWjw71Mticf5YP7sDs8fOWXfZPXqb37F5fN4kF8AcxZqZl5RfkcCaceyUcsEV
  7oojPfNYGxjPc3YxcnEICWxklPi/5QYLhLOUSeLixo9MEM52RonF6xazdjFycvAK2Ekc6+xlA
  rFZBFQlfqzeywwRF5Q4OfMJC4gtKhAh8fDRJDBbWCBS4tX87WC9zALiEreezAfrFRFwluhYMY
  0RIm4hsb/1K1hcSCBRYlvrSTYQm01AQ+Jey02wGk6g+g8rX8DVL35zkB3ClpfY/nYO2A0SAoo
  SRzr/Au3lALIrJW48ToUIq0lcPbeJeQKj8Cwkl85CctEsJFNnIZm6gJFlFaN1UlFmekZJbmJm
  jq6hgYGuoaGprqW5rqWJXmKVbqJeaqluXn5RSYauoV5iebFeanGxXnFlbnJOil5easkmRmAsp
  RQnxu1gfLjvl94hRkkOJiVR3skJPMlCfEn5KZUZicUZ8UWlOanFhxhlODiUJHifpAHlBItS01
  Mr0jJzgHENk5bg4FES4f2RBZTmLS5IzC3OTIdInWI05ji/c/9eZo5Jf67tZRZiycvPS5US52X
  PBioVACnNKM2DGwRLN5cYZaWEeRkZGBiEeApSi3IzS1DlXzGKczAqCfNWgEzhycwrgdv3CugU
  JqBTHi7hBjmlJBEhJdXAlCWhtf750RxJHbdJ/stlFr5Q3RVnNFf4YmOcpmbv2/dtZffvxrSad
  AXkyXvsbsljq/698ZjjmYnHtz/7omDkt3qF2+tGqWvvUkQW2qSI+tUpmy7JfZV/KnTrn+N8dd
  v/1F++dbFp5qTi1kzJF51nj58K6v+cHmOg36S0/f+hJnVf3m+X/wlGRW2exr5jY7PXrKMvpmQ
  +2r3dInSjv9u0Nrk5D+R+/NK3m/rdMHrpReE1SiYbZmmYXakKZ/13+5/64qPal5oM9ee3+pVP
  7zh9Zc5BPd/crwdzcn85GOx98+Nc3MPKmVXTs67YH/hl9/s1Y9ENXt/DGRcOux//cdixevUfv
  sioV0fVq22uCQkEFCqxFGckGmoxFxUnAgDX3+pRsgMAAA==
X-Env-Sender: lizhijian@fujitsu.com
X-Msg-Ref: server-8.tower-728.messagelabs.com!1661758619!143612!1
X-Originating-IP: [62.60.8.98]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.87.3; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 28584 invoked from network); 29 Aug 2022 07:36:59 -0000
Received: from unknown (HELO n03ukasimr03.n03.fujitsu.local) (62.60.8.98)
  by server-8.tower-728.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP; 29 Aug 2022 07:36:59 -0000
Received: from n03ukasimr03.n03.fujitsu.local (localhost [127.0.0.1])
        by n03ukasimr03.n03.fujitsu.local (Postfix) with ESMTP id 33D641AC;
        Mon, 29 Aug 2022 08:36:59 +0100 (BST)
Received: from R01UKEXCASM223.r01.fujitsu.local (R01UKEXCASM223 [10.182.185.121])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by n03ukasimr03.n03.fujitsu.local (Postfix) with ESMTPS id 27BA61AB;
        Mon, 29 Aug 2022 08:36:59 +0100 (BST)
Received: from [10.167.226.45] (10.167.226.45) by
 R01UKEXCASM223.r01.fujitsu.local (10.182.185.121) with Microsoft SMTP Server
 (TLS) id 15.0.1497.32; Mon, 29 Aug 2022 08:36:56 +0100
Message-ID: <708e6623-7b63-6741-a3ed-fedd4d96d1cb@fujitsu.com>
Date:   Mon, 29 Aug 2022 15:36:07 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] RDMA/rxe: Delete error messages triggered by incoming
 Read requests
Content-Language: en-US
To:     Daisuke Matsuda <matsuda-daisuke@fujitsu.com>, <jgg@nvidia.com>
CC:     <linux-rdma@vger.kernel.org>, <zyjzyj2000@gmail.com>
References: <Ywi8ZebmZv+bctrC@nvidia.com>
 <20220829054413.1630495-1-matsuda-daisuke@fujitsu.com>
From:   Li Zhijian <lizhijian@fujitsu.com>
In-Reply-To: <20220829054413.1630495-1-matsuda-daisuke@fujitsu.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.167.226.45]
X-ClientProxiedBy: G08CNEXCHPEKD08.g08.fujitsu.local (10.167.33.83) To
 R01UKEXCASM223.r01.fujitsu.local (10.182.185.121)
X-Virus-Scanned: ClamAV using ClamSMTP
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org



On 29/08/2022 13:44, Daisuke Matsuda wrote:
> An incoming Read request causes multiple Read responses. If a user MR to
> copy data from is unavailable or responder cannot send a reply, then the
> error messages can be printed for each response attempt, resulting in
> message overflow.
>
> Signed-off-by: Daisuke Matsuda <matsuda-daisuke@fujitsu.com>
> ---
>   drivers/infiniband/sw/rxe/rxe_resp.c | 6 +-----
>   1 file changed, 1 insertion(+), 5 deletions(-)
>
> diff --git a/drivers/infiniband/sw/rxe/rxe_resp.c b/drivers/infiniband/sw/rxe/rxe_resp.c
> index b36ec5c4d5e0..4b3e8aec2fb8 100644
> --- a/drivers/infiniband/sw/rxe/rxe_resp.c
> +++ b/drivers/infiniband/sw/rxe/rxe_resp.c
> @@ -811,8 +811,6 @@ static enum resp_states read_reply(struct rxe_qp *qp,
>   
>   	err = rxe_mr_copy(mr, res->read.va, payload_addr(&ack_pkt),
>   			  payload, RXE_FROM_MR_OBJ);
> -	if (err)
> -		pr_err("Failed copying memory\n");
Not relate to this patch.
I'm wondering why this err is ignored, rxe_mr_copy() does the real execution or rxe_mr_copy() would never fail ?
IMO, when err happens, responder shall notify the request anyhow.

Thanks
Zhijian

>   	if (mr)
>   		rxe_put(mr);
>   
> @@ -823,10 +821,8 @@ static enum resp_states read_reply(struct rxe_qp *qp,
>   	}
>   
>   	err = rxe_xmit_packet(qp, &ack_pkt, skb);
> -	if (err) {
> -		pr_err("Failed sending RDMA reply.\n");
> +	if (err)
>   		return RESPST_ERR_RNR;
> -	}
>   
>   	res->read.va += payload;
>   	res->read.resid -= payload;

