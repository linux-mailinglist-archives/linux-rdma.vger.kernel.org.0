Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CDDE73285D
	for <lists+linux-rdma@lfdr.de>; Fri, 16 Jun 2023 09:06:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240391AbjFPHFZ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 16 Jun 2023 03:05:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244229AbjFPHEu (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 16 Jun 2023 03:04:50 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3365268A
        for <linux-rdma@vger.kernel.org>; Fri, 16 Jun 2023 00:04:09 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id 5b1f17b1804b1-3f8d258f203so2360005e9.1
        for <linux-rdma@vger.kernel.org>; Fri, 16 Jun 2023 00:04:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686899048; x=1689491048;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=mEheVmmZKno00YKGHW7xItrFqYeydiqUmVYCZ+1Z/zQ=;
        b=EjiHj+r5R7Alb6qabtNlIP8BiZziH6PtlHcBdGKC6xMxZYcuYyW9Z9f8Cw+HVjZ2tZ
         a7FoZdClbl6nfaoYyZegjq2VAbvbqaejNyl+Rx8CsZyRtZKe/cEJiZUTk85UD26dyRSP
         MZUSGCCXdJ/mOJEgsa9B62YSLZ1nEe/0bTe1K63Jl+UL94upJIWcqFtJFoTRdscok9ry
         8AOaFybtK8Ppmxxd4yTlgqINI57pYpiXwfGYKNlSVFter+oGPC0/3JTRbHjnKQ851QqE
         i+G0dK/aaKwvlCWV7feNisvDAJJgqhqMTiw3gShdxnrnVgl33hupoqhkoSqau3H5nxIX
         Hx+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686899048; x=1689491048;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mEheVmmZKno00YKGHW7xItrFqYeydiqUmVYCZ+1Z/zQ=;
        b=ROTdzFP/AnrhU8Bpwd20XiE/nM7JyDGFoKg7xHFXDen+7weotTBaFqvuq3pwxvKifl
         mGkKsm+HLw8+5+fkSNSv+h5FNGiLS4ZMYSUvDgkrUDG3Q1Bj2KJlmsWIMjaLP7rMMfnU
         pd9zYjuykYoMIXP48hwkZSf//+9wdIDr4Zy9hYTlHT38WahTK2Mlibpl27Q3A7oW4d9G
         f4f/FPP/tNlqvhSlxpSvVDL80u91Ns538h+DJaV/LdGXeqeyEhoDnbqqC7xKDMy4nPnm
         U2hE2W4TD2G2h9LtAAsiQcWvBpj7U1URXraFLJMPDAbJRXaKZwfxeOpzNh0kAEi21HFD
         bBJw==
X-Gm-Message-State: AC+VfDxr6U1uXEuW08ow6cWlNW4OBonBoe3JA3mK5cpm4SN1J0zTd/xw
        0B0Zzanho2dhSGAK5nnuviIaTG4HM061E7+xuD0=
X-Google-Smtp-Source: ACHHUZ69x2GEowOeIEdcZAo0xjAgCeMwfsaYBE20/5avoOVSNTyNtXAaxgaBygwcxZYS2IC9OR9WmA==
X-Received: by 2002:a05:600c:2295:b0:3f7:5e3:c1f2 with SMTP id 21-20020a05600c229500b003f705e3c1f2mr927547wmf.8.1686899048229;
        Fri, 16 Jun 2023 00:04:08 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id p4-20020a5d48c4000000b0030903d44dbcsm22711525wrs.33.2023.06.16.00.04.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Jun 2023 00:04:06 -0700 (PDT)
Date:   Fri, 16 Jun 2023 10:04:02 +0300
From:   Dan Carpenter <dan.carpenter@linaro.org>
To:     Kashyap Desai <kashyap.desai@broadcom.com>
Cc:     linux-rdma@vger.kernel.org,
        Selvin Xavier <selvin.xavier@broadcom.com>
Subject: Re: [PATCH for-next 2/2] RDMA/bnxt_re: refactor code around
 bnxt_qplib_map_rc
Message-ID: <8d8a4fa2-34bb-41a1-a26c-305036c711b2@kadam.mountain>
References: <20230616061700.741769-1-kashyap.desai@broadcom.com>
 <20230616061700.741769-2-kashyap.desai@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230616061700.741769-2-kashyap.desai@broadcom.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Jun 16, 2023 at 11:47:00AM +0530, Kashyap Desai wrote:
> Updated function comment of bnxt_qplib_map_rc
> Removed intermediate return value ENXIO and directly called bnxt_qplib_map_rc
> from __send_message_basic_sanity.
> 
> Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
> Signed-off-by: Kashyap Desai <kashyap.desai@broadcom.com>
> Signed-off-by: Selvin Xavier <selvin.xavier@broadcom.com>
> ---

Probably Reported-by is giving me to much credit but I do like this
change.  It's more clear now.  Thanks, a lot!

regards,
dan carpenter

