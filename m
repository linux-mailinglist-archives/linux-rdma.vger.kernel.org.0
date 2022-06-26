Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28FDD55B435
	for <lists+linux-rdma@lfdr.de>; Sun, 26 Jun 2022 23:52:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231910AbiFZVv2 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 26 Jun 2022 17:51:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229722AbiFZVv1 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 26 Jun 2022 17:51:27 -0400
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com [IPv6:2607:f8b0:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50CFB270C;
        Sun, 26 Jun 2022 14:51:25 -0700 (PDT)
Received: by mail-ot1-x32c.google.com with SMTP id cb12-20020a056830618c00b00616b871cef3so3836323otb.5;
        Sun, 26 Jun 2022 14:51:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=rV511u1JDXv42Io5ma1kqHonKwVW2qB5lSv0jWDN0E4=;
        b=cbDKdIsMpUYg7o4ag6Hb2/DcUX804wCHBmck3WuiLtsoRSm57huKMZtPSOayCtpItB
         tyVp+/fwz/qSf8dnPIqfG/NMYBBv2GaBPY4C9Wdhoc4OCoKqc7SwmDz2av5IsKKqVHHE
         Rx9njzdziAdTKl9QzqYOSjMFtWRCMkmIp+LJm6UbN+26322hYDs4F+MGXPj2bDmAjw0l
         bzVEEC70vh15L+PiDleeHtSjfdi8peHH/7t0iXgp9C+cy/Cm3R/a5qQglH2HfPh58iV+
         CIHL0HaBblcnC9OclO8vIdJLjsBEaDDbAdpSNj9/IBsf4ZJettnMcdwTsgroOv8HnSRY
         dP+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=rV511u1JDXv42Io5ma1kqHonKwVW2qB5lSv0jWDN0E4=;
        b=ZTwooqAV0hkq6cb10p9v7a8aVOZZi1u1b+FCRDqe1z7n5Nc4RIMKkcJZjxrqsuFuGr
         PCjUrhSzxvF16SeEu9xcIAOvdO+6vvl1psHJWguWxSdvqUwtX6tuYm7l/LnYBcsXsjDj
         98o1cb0nNT+MAdMdUPCy1BdwCqdlhqe3bJuvWh0y1d8TQZcrB+iU5ifNXVD4TMySPjz5
         dc/NU1qE/6RAkdSAUxnjcU3ToioppBpsLgJ0jevx1TLwrZobFlBIGB+bToZ3VJSoUynk
         wIaFvjWCvSxIrlwHnQCLFyu/5w0JDKq1zhd0cvsromWtmrknKrMjjQwhwnkYzXuIObAS
         q4Pw==
X-Gm-Message-State: AJIora+AFM2TPGviI/ldQD2BpauElI32EvBttf/vqL9fCw1ZBPrag5w7
        AGlmPsf/zaCH8m40kO3jJWwEpHUtav4=
X-Google-Smtp-Source: AGRyM1ukFILd+2AsFlJ7rdXak/OfVSi5PcFWY+/VnOTtFujAEJDOliBo/ndAe0c158gHoqsgYfOWsw==
X-Received: by 2002:a9d:1b08:0:b0:616:b1c8:14ae with SMTP id l8-20020a9d1b08000000b00616b1c814aemr4476184otl.127.1656280284128;
        Sun, 26 Jun 2022 14:51:24 -0700 (PDT)
Received: from ?IPV6:2603:8081:140c:1a00:7f25:2769:1033:f8c1? (2603-8081-140c-1a00-7f25-2769-1033-f8c1.res6.spectrum.com. [2603:8081:140c:1a00:7f25:2769:1033:f8c1])
        by smtp.gmail.com with ESMTPSA id r23-20020a056870179700b000f2455e26acsm5895119oae.48.2022.06.26.14.51.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 26 Jun 2022 14:51:23 -0700 (PDT)
Message-ID: <1e9a8c0f-b4c3-3edf-33f1-33a2b7ca245a@gmail.com>
Date:   Sun, 26 Jun 2022 16:51:22 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v3 1/2] RDMA/rxe: Update wqe_index for each wqe error
 completion
Content-Language: en-US
To:     Li Zhijian <lizhijian@fujitsu.com>,
        Yanjun Zhu <yanjun.zhu@linux.dev>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Haakon Bugge <haakon.bugge@oracle.com>,
        Cheng Xu <chengyou@linux.alibaba.com>,
        linux-rdma@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org
References: <20220516015329.445474-1-lizhijian@fujitsu.com>
 <20220516015329.445474-2-lizhijian@fujitsu.com>
From:   Bob Pearson <rpearsonhpe@gmail.com>
In-Reply-To: <20220516015329.445474-2-lizhijian@fujitsu.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 5/15/22 20:53, Li Zhijian wrote:
> Previously, if user space keeps sending abnormal wqe, queue.prod will
> keep increasing while queue.index doesn't. Once
> queue.index==queue.prod in next round, req_next_wqe() will treat queue
> as empty. In such case, no new completion would be generated.
> 
> Update wqe_index for each wqe completion so that req_next_wqe() can get
> next wqe properly.
> 
> Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
> ---
>  drivers/infiniband/sw/rxe/rxe_req.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/infiniband/sw/rxe/rxe_req.c b/drivers/infiniband/sw/rxe/rxe_req.c
> index a0d5e57f73c1..8bdd0b6b578f 100644
> --- a/drivers/infiniband/sw/rxe/rxe_req.c
> +++ b/drivers/infiniband/sw/rxe/rxe_req.c
> @@ -773,6 +773,8 @@ int rxe_requester(void *arg)
>  	if (ah)
>  		rxe_put(ah);
>  err:
> +	/* update wqe_index for each wqe completion */
> +	qp->req.wqe_index = queue_next_index(qp->sq.queue, qp->req.wqe_index);
>  	wqe->state = wqe_state_err
>  	__rxe_do_task(&qp->comp.task);
>  

This change looks plausible, but I am not sure if it will make a difference since the qp
will get transitioned to the error state very shortly.

In order for it to matter the requester must be a ways ahead of the completer in the send queue
and someone be actively posting new wqes which will reschedule the requester. Currently it
will fail on the same wqe again unless the error described above occurs but if we post a new valid
wqe it will get executed even though we have detected an error that should have stopped the qp.

It looks like the intent was to keep the qp in the non error state until all the old
wqes get completed before making the transition. But we should disable the requester
from processing new wqes in this case. That seems like a safer solution to the problem.

Bob

