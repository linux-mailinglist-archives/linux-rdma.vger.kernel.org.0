Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BFBE7AAF7C
	for <lists+linux-rdma@lfdr.de>; Fri, 22 Sep 2023 12:29:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233331AbjIVKaA (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 22 Sep 2023 06:30:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232913AbjIVK35 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 22 Sep 2023 06:29:57 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA9A8A9;
        Fri, 22 Sep 2023 03:29:51 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1433C433C8;
        Fri, 22 Sep 2023 10:29:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695378591;
        bh=/P01kWffyQ8DbfOXIhAgApHORmbtWN/NPbQ6cSR4bi8=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=hgFltriUPn/ceU5dzTFyJydqBjVdasnTmTxIroX7UPxu5vvxgO3doApo8NvmC9C5k
         d+mFrguR3NSQm0NkCbopQkvW6bWdWYLHAmtel9agIOWW3BuyAliIRZmlUajkPp6u47
         w09m+AAcu2BKzo2ixklRM+D1Aj70tLjQjbrb1ogfqlMB8+qHhTrcA5AbYA5wWGldDn
         GpT3m1/jznQuqGHPxGQbXAFwVBpPpFHvQhJ92fiFMFmUDzZz7sGf3j6ocTXnC+nItw
         X8RgXSawVwupXc3mmFNHZmpqN0ph7RAREwr2dtIv1nUH4y8OG/daacqwM7T5OlzLiy
         8ZjSZHl+AsyDw==
From:   Leon Romanovsky <leon@kernel.org>
To:     Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Justin Stitt <justinstitt@google.com>
Cc:     linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
In-Reply-To: =?utf-8?q?=3C20230921-strncpy-drivers-infiniband-hw-hfi1-chip-c?=
 =?utf-8?q?-v1-1-37afcf4964d9=40google=2Ecom=3E?=
References: =?utf-8?q?=3C20230921-strncpy-drivers-infiniband-hw-hfi1-chip-c-?=
 =?utf-8?q?v1-1-37afcf4964d9=40google=2Ecom=3E?=
Subject: Re: [PATCH] IB/hfi1: replace deprecated strncpy
Message-Id: <169537858725.3339131.15264681410291677148.b4-ty@kernel.org>
Date:   Fri, 22 Sep 2023 13:29:47 +0300
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12-dev-a055d
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


On Thu, 21 Sep 2023 07:17:47 +0000, Justin Stitt wrote:
> `strncpy` is deprecated for use on NUL-terminated destination strings
> [1] and as such we should prefer more robust and less ambiguous string
> interfaces.
> 
> We see that `buf` is expected to be NUL-terminated based on it's use
> within a trace event wherein `is_misc_err_name` and `is_various_name`
> map to `is_name` through `is_table`:
> | TRACE_EVENT(hfi1_interrupt,
> | 	    TP_PROTO(struct hfi1_devdata *dd, const struct is_table *is_entry,
> | 		     int src),
> | 	    TP_ARGS(dd, is_entry, src),
> | 	    TP_STRUCT__entry(DD_DEV_ENTRY(dd)
> | 			     __array(char, buf, 64)
> | 			     __field(int, src)
> | 			     ),
> | 	    TP_fast_assign(DD_DEV_ASSIGN(dd);
> | 			   is_entry->is_name(__entry->buf, 64,
> | 					     src - is_entry->start);
> | 			   __entry->src = src;
> | 			   ),
> | 	    TP_printk("[%s] source: %s [%d]", __get_str(dev), __entry->buf,
> | 		      __entry->src)
> | );
> 
> [...]

Applied, thanks!

[1/1] IB/hfi1: replace deprecated strncpy
      https://git.kernel.org/rdma/rdma/c/c2d0c5b28a77d5

Best regards,
-- 
Leon Romanovsky <leon@kernel.org>
