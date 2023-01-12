Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA20D6686D1
	for <lists+linux-rdma@lfdr.de>; Thu, 12 Jan 2023 23:24:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234573AbjALWXk (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 12 Jan 2023 17:23:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240416AbjALWXA (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 12 Jan 2023 17:23:00 -0500
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF8931DF30
        for <linux-rdma@vger.kernel.org>; Thu, 12 Jan 2023 14:18:05 -0800 (PST)
Received: by mail-pj1-x1032.google.com with SMTP id v13-20020a17090a6b0d00b00219c3be9830so22500027pjj.4
        for <linux-rdma@vger.kernel.org>; Thu, 12 Jan 2023 14:18:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=pQuiKZTcysP+X0OflIm+diuT8xEgILcbwkQoyyI8+0o=;
        b=icewnOc84IIjF3zzON1xLWkC6RiMkayacySIOkPIsqmi6cQtvdd2hQxI3+R1O8RQDu
         6xssG6vq9iZNtd/vhg2VOo1//h0T38JpbGQGwQn3IyhXa/NsPMuhgLBnr/6c55KwHGD+
         kcXWnufqryq/ioVn+ogLnxmHf5hhSQx+6+rC8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pQuiKZTcysP+X0OflIm+diuT8xEgILcbwkQoyyI8+0o=;
        b=MvGTxYOzcvGmAoZ45akbA8RySFahJCjERR1C2JC2ODJbrfSOIMLuGjpYLxebTCrAq0
         t9m82tRcWhwsYDsWFlYE9FJ2mc2P63BCVckOV4ChWsKclCJVi4WRIkpwHUu2hJaDchzI
         laka34dFz1RJpw36SYeW/C05rhBzU8M2YOYC+23jOhZ11WtWbWrviCBqjhUW2iIB6jAw
         SW9K0rI9DvOooBD+QRBOW4tAptaoFa/YqAFNmj9zB3QBogccZoT7onP8cW3/Aae/7w+7
         eZR8izx8r1B+vkzQjWCh6o4zGrIcGAprkqEVwFt52MTmvnhOouzpUZIw5Re1aOUYEi1w
         8AFQ==
X-Gm-Message-State: AFqh2kqpIMbqkYCQylmXFEfb+E5Vas5rYqZl3YoANUP1UIIzkrPTcZwF
        2oTmysfPEWkREY4se053xJPvJQ==
X-Google-Smtp-Source: AMrXdXtXS1FFgjUUavPIWXAX+IH21ePUxx9ZCBLWfdePFzprzmAAeyLXPPq+TeOmmw8PlG9ERGp1IQ==
X-Received: by 2002:a17:902:db08:b0:194:5d2d:3c31 with SMTP id m8-20020a170902db0800b001945d2d3c31mr5929835plx.11.1673561885371;
        Thu, 12 Jan 2023 14:18:05 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id ij18-20020a170902ab5200b00176e6f553efsm12621992plb.84.2023.01.12.14.18.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Jan 2023 14:18:04 -0800 (PST)
Date:   Thu, 12 Jan 2023 14:18:04 -0800
From:   Kees Cook <keescook@chromium.org>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     Cheng Xu <chengyou@linux.alibaba.com>,
        Kai Shen <kaishen@linux.alibaba.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Leon Romanovsky <leon@kernel.org>, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH][next] RDMA/erdma: Replace zero-length arrays with
 flexible-array members
Message-ID: <202301121418.4CCEA8115@keescook>
References: <Y7zCBqwC1LtabRJ9@work>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y7zCBqwC1LtabRJ9@work>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Jan 09, 2023 at 07:40:22PM -0600, Gustavo A. R. Silva wrote:
> Zero-length arrays are deprecated[1] and we are moving towards
> adopting C99 flexible-array members instead. So, replace zero-length
> arrays, in a couple of structures, with flex-array members.
> 
> This helps with the ongoing efforts to tighten the FORTIFY_SOURCE
> routines on memcpy() and help us make progress towards globally
> enabling -fstrict-flex-arrays=3 [2].
> 
> Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#zero-length-and-one-element-arrays [1]
> Link: https://gcc.gnu.org/pipermail/gcc-patches/2022-October/602902.html [2]
> Link: https://github.com/KSPP/linux/issues/78
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
