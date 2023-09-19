Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6988E7A5B33
	for <lists+linux-rdma@lfdr.de>; Tue, 19 Sep 2023 09:37:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231865AbjISHh5 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 19 Sep 2023 03:37:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231868AbjISHhx (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 19 Sep 2023 03:37:53 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B1751A4;
        Tue, 19 Sep 2023 00:37:41 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84C6FC433C8;
        Tue, 19 Sep 2023 07:37:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695109061;
        bh=UfR3qr+gEqTkf5hjByDzBjQSlVzN5gSNbRNo99YRWLk=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=B7wFvb908/MFuPuMo02OH7/XjR3AqA8pTVMo465s+MIAxB9U3c94VOLmoWjK/69uN
         hZF41rRP8u8AHD9NHNdcwdZnAbcS8zgdlOOZrYtzvEtsKe11EWm52bw0l4FAQvEgzj
         nir5OOOJzFiRK8RZKesGywwakcq5UEXm0lbtLOkzAGCPnKuh06igI0aHCKmdGt2FFH
         Xy9TY9dQ2CTzaEpjC0lZ/eZ+WamzWvYeR76QIZ7CxKlVei8dzyCpbA7Lvh+rq1pOZ4
         37oY3WxLZKVQ8FzOgzKzjQ9tOCQ5xvwRE7l/Sifqav37ze3uIaJiV+1XW+cdAORPlf
         yYZmrDygcpQUw==
From:   Leon Romanovsky <leon@kernel.org>
To:     Jason Gunthorpe <jgg@ziepe.ca>, Parav Pandit <parav@mellanox.com>,
        Jack Morgenstein <jackm@mellanox.com>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
In-Reply-To: <ZQdt4NsJFwwOYxUR@work>
References: <ZQdt4NsJFwwOYxUR@work>
Subject: Re: [PATCH v3][next] RDMA/core: Use size_{add,sub,mul}() in calls to
 struct_size()
Message-Id: <169510905734.14896.2991454817672701344.b4-ty@kernel.org>
Date:   Tue, 19 Sep 2023 10:37:37 +0300
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


On Sun, 17 Sep 2023 15:21:36 -0600, Gustavo A. R. Silva wrote:
> If, for any reason, the open-coded arithmetic causes a wraparound,
> the protection that `struct_size()` provides against potential integer
> overflows is defeated. Fix this by hardening calls to `struct_size()`
> with `size_add()`, `size_sub()` and `size_mul()`.
> 
> 

Applied, thanks!

[1/1] RDMA/core: Use size_{add,sub,mul}() in calls to struct_size()
      https://git.kernel.org/rdma/rdma/c/81760bedc65194

Best regards,
-- 
Leon Romanovsky <leon@kernel.org>
