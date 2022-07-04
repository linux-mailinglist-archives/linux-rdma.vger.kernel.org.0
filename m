Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 723F2565639
	for <lists+linux-rdma@lfdr.de>; Mon,  4 Jul 2022 14:55:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231418AbiGDMzi (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 4 Jul 2022 08:55:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231691AbiGDMzY (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 4 Jul 2022 08:55:24 -0400
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DF2612AB5
        for <linux-rdma@vger.kernel.org>; Mon,  4 Jul 2022 05:54:35 -0700 (PDT)
Received: by mail-qt1-x831.google.com with SMTP id h19so9738239qtp.6
        for <linux-rdma@vger.kernel.org>; Mon, 04 Jul 2022 05:54:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=vr0yfDJh/txpOCmBya5f4nooMrLbefEfgqyOpOQFICI=;
        b=Bo9El22zQ+6MQYWGUACM7TYZzTBQN5cg+lMEi2djpkq2cWsiKsWgb4VsULF2aPj6f1
         3GJfPRYTBa86qGnY4lic5hpN/J93lB1Ai8I7cDRtlRlyvi62JNqGUJF7e5+MC3uLfkqc
         JKRaSXdeDQpm6bR4ol00iioNjcD6RXqfRrXc1//pWBfJ9h2LwNUDUaDtdlGhCC3j81uN
         FTNAK/CZr4CrKVUTqOz7/TLOVIMYKm9tGfUI5hSnsrUVkTiReYafmSECs4pub0yrjU+1
         EGwi+3iRXdhCX+xCLVLzu8brS2aVl3zub123EA/Nohl2aHXMiCEiZq4djj7JLlj2NTKU
         xzGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=vr0yfDJh/txpOCmBya5f4nooMrLbefEfgqyOpOQFICI=;
        b=3LKlUhgjTq+a+J1HX5CYO5FLwjq20/zeZs/O6d1XPIAHbz2fCIAPbyQv+c8x/p8k1L
         WxAiLfjQmXW7Yq0n2ANJrM2kH1IicEwXeJigHo73gkegNUKl/S8x0r0RJZ0XNDOGm+h8
         vnLuGh6NEolBQzteOxYWSyI7F355R54aLwb1aJ3++Lhzz7L5ntYZYDX+FkUp6Gv2TjxL
         c0WQA4pwKbXpi60zVP7bdPJNqPTgPmNLEDrE/6CRdr0l1GNDTZEt38a1Csa9M/eWIG7B
         Y/IDCEAn8zC//3ve3JqziXOJVJEK7KTMq/Sr81fIKA/J0wSFe9H9dXV+ODAh0KkvhPRT
         zTYw==
X-Gm-Message-State: AJIora/tcZnuERHA0v7GRosRB+c9w67ZGcB0bZ+FT9JBbYrrFcmMKPNX
        EBFQ/sP54wfz6yW8ye47IFr+Lw==
X-Google-Smtp-Source: AGRyM1uukKRmWfJVSo6EXo43DpRNCOuX/tbNq4Rbb+lzobMwktQY6dPNtol6AC2CojOH0nThEAsMQg==
X-Received: by 2002:a05:6214:ca6:b0:472:e7e6:13a2 with SMTP id s6-20020a0562140ca600b00472e7e613a2mr8136087qvs.69.1656939272178;
        Mon, 04 Jul 2022 05:54:32 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-162-113-129.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.113.129])
        by smtp.gmail.com with ESMTPSA id bn32-20020a05620a2ae000b006b26790293bsm7458297qkb.100.2022.07.04.05.54.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Jul 2022 05:54:31 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1o8Law-005tUR-JC; Mon, 04 Jul 2022 09:54:30 -0300
Date:   Mon, 4 Jul 2022 09:54:30 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     yanjun.zhu@linux.dev
Cc:     leon@kernel.org, linux-rdma@vger.kernel.org
Subject: Re: [PATCH 1/1] RDMA/rxe: Fix BUG: KASAN: null-ptr-deref in
 rxe_qp_do_cleanup
Message-ID: <20220704125430.GA23621@ziepe.ca>
References: <20220705012212.294534-1-yanjun.zhu@linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220705012212.294534-1-yanjun.zhu@linux.dev>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Jul 04, 2022 at 09:22:12PM -0400, yanjun.zhu@linux.dev wrote:
> From: Zhu Yanjun <yanjun.zhu@linux.dev>
> 
> In some error handlers, both scq and rcq are set to NULL before
> calling rxe_qp_do_cleanup.

Describe the error flows in the commit message please

Jason
