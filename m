Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3479C5A740E
	for <lists+linux-rdma@lfdr.de>; Wed, 31 Aug 2022 04:47:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230382AbiHaCrf (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 30 Aug 2022 22:47:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229608AbiHaCre (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 30 Aug 2022 22:47:34 -0400
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E389FB14FF;
        Tue, 30 Aug 2022 19:47:33 -0700 (PDT)
Received: by mail-pf1-f175.google.com with SMTP id c66so2895158pfc.10;
        Tue, 30 Aug 2022 19:47:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=p+Lbv68LAjcpQ+zqtWIGrhsKEGgpIXQeXzdCrp4/+34=;
        b=CL8PLz03AZFJCOaT+IitMfKDYKD9afitCNiaxSdFZXYcvPNUWljv1T65EMSjBfmZ0u
         VPJA6ue/orHlj11de1kpQ5m5hx1cEof15zIy6lkICzUWx3DihUtpgbYGuy4SWsRYymM2
         7DHAt94PunAMkaOidPJ7/Chay426+5LzOdoZV9oEmX5zJp2xf2vINZP5D3KC2eUfy6xu
         bee1B9F4ojsWNWd3UPzoMIMOw+8in1pbIWdyIrqA+msAnqrXoKHQdt0fYMRepcyDsVlz
         ZX3zMuUABwc/wUgZ5i0WuaF8Gk3/Y2fGPk/LKcJIOxVI7YAnlenIuYqJECy/1VJsWLpe
         jaAQ==
X-Gm-Message-State: ACgBeo3DTHtzMaiLtXOamzvg+aJADHM1eoQtOHd2lXPb+nTRTunO1bRX
        ZUFZENdM+WRnYzNq6USPFlU=
X-Google-Smtp-Source: AA6agR6Qq0a+yAa2nPUR+wwGGE72x+dcomD2lukW8QCYMCqlCAI4u07E4w7BomTImYWlNoV3Z7rM/w==
X-Received: by 2002:a05:6a00:1687:b0:518:6c6b:6a9a with SMTP id k7-20020a056a00168700b005186c6b6a9amr24487002pfc.81.1661914053256;
        Tue, 30 Aug 2022 19:47:33 -0700 (PDT)
Received: from [172.20.0.236] ([12.219.165.6])
        by smtp.gmail.com with ESMTPSA id w131-20020a627b89000000b00537dfd6e67esm8402100pfc.48.2022.08.30.19.47.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Aug 2022 19:47:32 -0700 (PDT)
Message-ID: <5daac9db-2b34-fbe5-a891-8ecf77fbe46f@acm.org>
Date:   Tue, 30 Aug 2022 19:47:25 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] RDMA/srp: Set scmnd->result only when scmnd is not NULL
Content-Language: en-US
To:     "yangx.jy@fujitsu.com" <yangx.jy@fujitsu.com>,
        "jgg@nvidia.com" <jgg@nvidia.com>,
        "leon@kernel.org" <leon@kernel.org>
Cc:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20220831014730.17566-1-yangx.jy@fujitsu.com>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20220831014730.17566-1-yangx.jy@fujitsu.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 8/30/22 18:47, yangx.jy@fujitsu.com wrote:
> diff --git a/drivers/infiniband/ulp/srp/ib_srp.c b/drivers/infiniband/ulp/srp/ib_srp.c
> index 7720ea270ed8..528cdd0daba4 100644
> --- a/drivers/infiniband/ulp/srp/ib_srp.c
> +++ b/drivers/infiniband/ulp/srp/ib_srp.c
> @@ -1961,6 +1961,7 @@ static void srp_process_rsp(struct srp_rdma_ch *ch, struct srp_rsp *rsp)
>   		if (scmnd) {
>   			req = scsi_cmd_priv(scmnd);
>   			scmnd = srp_claim_req(ch, req, NULL, scmnd);
> +			scmnd->result = rsp->status;
>   		} else {
>   			shost_printk(KERN_ERR, target->scsi_host,
>   				     "Null scmnd for RSP w/tag %#016llx received on ch %td / QP %#x\n",
> @@ -1972,7 +1973,6 @@ static void srp_process_rsp(struct srp_rdma_ch *ch, struct srp_rsp *rsp)
>   
>   			return;
>   		}
> -		scmnd->result = rsp->status;
>   
>   		if (rsp->flags & SRP_RSP_FLAG_SNSVALID) {
>   			memcpy(scmnd->sense_buffer, rsp->data +

Since there is a 'return' statement in the else branch, I don't see how 
this patch can make a difference?

Thanks,

Bart.
