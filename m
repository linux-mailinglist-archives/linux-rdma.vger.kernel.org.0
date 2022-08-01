Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB9D3586EF9
	for <lists+linux-rdma@lfdr.de>; Mon,  1 Aug 2022 18:46:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233958AbiHAQqO (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 1 Aug 2022 12:46:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234243AbiHAQqM (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 1 Aug 2022 12:46:12 -0400
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79A7EEE01;
        Mon,  1 Aug 2022 09:46:10 -0700 (PDT)
Received: by mail-pf1-f169.google.com with SMTP id w185so11145486pfb.4;
        Mon, 01 Aug 2022 09:46:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=oaCyo7hq+RU/dygb1CTSCLcZe9XahWnlD8COP0KgBlQ=;
        b=qBAlWnSaEAraDzdpMhVqhX/c2M3Ni2uUnvZ+Kblu7OocNLvNzE5Mh/njJoI+je/92R
         c9I6XzsggpMbwNMEQDK5YI1f6KrvZ9dg4eV9gaMsTT0oAzqhG03Z+y4AUZn+oPYP7vKa
         mTg2LeNvZkDCYrGF4ojJ/YWTSWz6g9Ry1m4u3QskpD5h5tet4Gz3/7+SpE0p7fgFxmcY
         V/OBOKKgvdPM0vayWtecNq6PPOtz8TvAs4sFs5dt9AEHiNhYjbIFhiGH4WpnsnbN6c4Q
         8ZT13Xiz+c42TQilzf3ZEd8tDIUjVquc/7EW3ur2p5tqklVXjITOjnQTw4XcD0rtYYZN
         Z7Fg==
X-Gm-Message-State: AJIora+jv1hs9t9asOLXCwMwDQm+czsyO62iIKKbA0CSt/tC+ATDobl4
        ICL9Gp9c41i4fX/jLM3hPTyoAvXw6yY=
X-Google-Smtp-Source: AGRyM1tEQdPHp6rR+jB3N6XySraP/FcpHP+ZmIsTfItKq17AXBqA6+vqkHB25vBFYLeHTVfD9aerbQ==
X-Received: by 2002:a63:f90d:0:b0:419:b112:91ea with SMTP id h13-20020a63f90d000000b00419b11291eamr14172722pgi.592.1659372370212;
        Mon, 01 Aug 2022 09:46:10 -0700 (PDT)
Received: from ?IPV6:2620:15c:211:201:6496:b2a7:616f:954d? ([2620:15c:211:201:6496:b2a7:616f:954d])
        by smtp.gmail.com with ESMTPSA id o15-20020a17090a55cf00b001f333fab3d6sm7617838pjm.18.2022.08.01.09.46.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Aug 2022 09:46:09 -0700 (PDT)
Message-ID: <bb20de72-fc15-feb1-541a-91454593e043@acm.org>
Date:   Mon, 1 Aug 2022 09:46:07 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] RDMA/ib_srpt: unify checking rdma_cm_id condition in
 srpt_cm_req_recv()
Content-Language: en-US
To:     Li Zhijian <lizhijian@fujitsu.com>, Jason Gunthorpe <jgg@ziepe.ca>,
        Leon Romanovsky <leon@kernel.org>, linux-rdma@vger.kernel.org,
        target-devel@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org
References: <1659336226-2-1-git-send-email-lizhijian@fujitsu.com>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <1659336226-2-1-git-send-email-lizhijian@fujitsu.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 7/31/22 23:43, Li Zhijian wrote:
> Although rdma_cm_id and ib_cm_id passing to srpt_cm_req_recv() are
> exclusive currently, all other checking condition are using rdma_cm_id.
> So unify the 'if' condition to make the code more clear.
> 
> Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
> ---
>   drivers/infiniband/ulp/srpt/ib_srpt.c | 8 ++++----
>   1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/infiniband/ulp/srpt/ib_srpt.c b/drivers/infiniband/ulp/srpt/ib_srpt.c
> index c3036aeac89e..21cbe30d526f 100644
> --- a/drivers/infiniband/ulp/srpt/ib_srpt.c
> +++ b/drivers/infiniband/ulp/srpt/ib_srpt.c
> @@ -2218,13 +2218,13 @@ static int srpt_cm_req_recv(struct srpt_device *const sdev,
>   	ch->zw_cqe.done = srpt_zerolength_write_done;
>   	INIT_WORK(&ch->release_work, srpt_release_channel_work);
>   	ch->sport = sport;
> -	if (ib_cm_id) {
> -		ch->ib_cm.cm_id = ib_cm_id;
> -		ib_cm_id->context = ch;
> -	} else {
> +	if (rdma_cm_id) {
>   		ch->using_rdma_cm = true;
>   		ch->rdma_cm.cm_id = rdma_cm_id;
>   		rdma_cm_id->context = ch;
> +	} else {
> +		ch->ib_cm.cm_id = ib_cm_id;
> +		ib_cm_id->context = ch;
>   	}
>   	/*
>   	 * ch->rq_size should be at least as large as the initiator queue

Although the above patch looks fine to me, I'm not sure this kind of 
changes should be considered as useful or as churn?

Bart.
