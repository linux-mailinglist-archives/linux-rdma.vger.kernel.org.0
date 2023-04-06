Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 749FB6D9E29
	for <lists+linux-rdma@lfdr.de>; Thu,  6 Apr 2023 19:08:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239909AbjDFRIX (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 6 Apr 2023 13:08:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229977AbjDFRIW (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 6 Apr 2023 13:08:22 -0400
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAAE983FC
        for <linux-rdma@vger.kernel.org>; Thu,  6 Apr 2023 10:08:21 -0700 (PDT)
Received: by mail-pj1-f48.google.com with SMTP id p3-20020a17090a74c300b0023f69bc7a68so41284440pjl.4
        for <linux-rdma@vger.kernel.org>; Thu, 06 Apr 2023 10:08:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680800901; x=1683392901;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=piygfyslisU7QxZMEAud2OXa53CZOmjNGXMPAkxpOWA=;
        b=5rnNcjlLm9PpH5lAsgTVFuoetOgEXxUwPaMhHOyv+5v8qITaef96utRfOFfi3od3/G
         3O6mGeCAbKEFGxyTiMiPEiI0DunWvNBU/8hbtYGXDDtyh10J9K3dQ80ydd2sS2N1IMqi
         oc/SQRxUg8RjKL/UtAGAMZgWKJ2DICTRTtd1baCj0SEAQ0Q6PDU7GKp1TvK1mjiUs8Jl
         YP2xQUA+1dbsbYkEcln2STFFr8ipQ6bguXM13fdEl3PuOiIC/9daX2mZ9LRyQBih0HzJ
         AniBQ2F6f4SBIDpnGobsg64+Jl0oWSgiFKgDAeBeVzav9WJX5wgGfhdc++nEQF4SGeT9
         3zuA==
X-Gm-Message-State: AAQBX9fnKUMmkpbMorMMYifgqWONV28wLMcK8xa1GWVzQwKw+y/+Nw7D
        3kDOli8xc1YEYtJZ73HwS1w=
X-Google-Smtp-Source: AKy350azEqBeDvjMQG/I8CRUpR4fdFFrxXuEUi/Z2OXLiB3ZH3HOHNFXznDAYOQOlVX+qyM48rYhZg==
X-Received: by 2002:a05:6a20:1b12:b0:da:144:92a8 with SMTP id ch18-20020a056a201b1200b000da014492a8mr226006pzb.37.1680800900904;
        Thu, 06 Apr 2023 10:08:20 -0700 (PDT)
Received: from ?IPV6:2620:15c:211:201:8af7:e62e:d5b6:a90? ([2620:15c:211:201:8af7:e62e:d5b6:a90])
        by smtp.gmail.com with ESMTPSA id u11-20020a63234b000000b00513b40f2c89sm1346918pgm.43.2023.04.06.10.08.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Apr 2023 10:08:20 -0700 (PDT)
Message-ID: <659bfef6-c6d1-0316-60aa-215d8fd67c6a@acm.org>
Date:   Thu, 6 Apr 2023 10:08:18 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v2 for-rc] RDMA/srpt: Add a check for valid 'mad_agent'
 pointer
Content-Language: en-US
To:     Saravanan Vajravel <saravanan.vajravel@broadcom.com>, jgg@ziepe.ca,
        leon@kernel.org
Cc:     linux-rdma@vger.kernel.org,
        Selvin Xavier <selvin.xavier@broadcom.com>,
        Kashyap Desai <kashyap.desai@broadcom.com>
References: <20230406042549.507328-1-saravanan.vajravel@broadcom.com>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20230406042549.507328-1-saravanan.vajravel@broadcom.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.7 required=5.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
        FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 4/5/23 21:25, Saravanan Vajravel wrote:
> +		if (IS_ERR(mad_agent)) {
>   			pr_err("%s-%d: MAD agent registration failed (%ld). Note: this is expected if SR-IOV is enabled.\n",
>   			       dev_name(&sport->sdev->device->dev), sport->port,
> -			       PTR_ERR(sport->mad_agent));
> +			       PTR_ERR(mad_agent));
>   			sport->mad_agent = NULL;
>   			memset(&port_modify, 0, sizeof(port_modify));
>   			port_modify.clr_port_cap_mask = IB_PORT_DEVICE_MGMT_SUP;
>   			ib_modify_port(sport->sdev->device, sport->port, 0,
>   				       &port_modify);
> -
> +		} else {
> +			sport->mad_agent = mad_agent;
>   		}
>   	}
>   

With an early return the 'else' clause wouldn't have been necessary. Anyway:

Reviewed-by: Bart Van Assche <bvanassche@acm.org>
