Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (unknown [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CC32533C70
	for <lists+linux-rdma@lfdr.de>; Wed, 25 May 2022 14:14:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230193AbiEYMNf (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 25 May 2022 08:13:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241046AbiEYMNa (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 25 May 2022 08:13:30 -0400
Received: from gentwo.de (gentwo.de [IPv6:2a02:c206:2048:5042::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF1BD22B04
        for <linux-rdma@vger.kernel.org>; Wed, 25 May 2022 05:13:26 -0700 (PDT)
Received: by gentwo.de (Postfix, from userid 1001)
        id A7923B0035C; Wed, 25 May 2022 14:13:21 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gentwo.de; s=default;
        t=1653480801; bh=Fq16UZ1v+C37broll+FK8E2Ic3ww8fn1p1Rm+5QGtKE=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=P6DVcRK+wnuCgIxm+luzdt7AO6wTGH2efsCx3ycDz1cESGQ+k3xWE2LCbB+46a3+R
         inZLW07dl0FRV+dkhX1SVVC+KPT6MWybZpZ1Qb4cRfoAfGqJPxYHZ1dFX4vjG2D0GO
         vUVMWmIJalRk7Wsk5lE5nSQqNrG9R/iZKfMuSk8TteKIrlEhut1/8RQvNrQ6XahDYE
         8IiAkA8lmRlHf+8l1M5IM7KXUxiCff7TCEsEjzs9BWp79cQknki6U5yl+jZFLkt7Ga
         JPQWt3Z6UQLPJv8ZhoNAi6Td00Zas08LwWkRFS/M3d/2AZ1cCUmsH0V30Zla+Qa2Ah
         pSqyEckrEQr5A==
Received: from localhost (localhost [127.0.0.1])
        by gentwo.de (Postfix) with ESMTP id A5F7FB00190;
        Wed, 25 May 2022 14:13:21 +0200 (CEST)
Date:   Wed, 25 May 2022 14:13:21 +0200 (CEST)
From:   Christoph Lameter <cl@gentwo.de>
To:     Doug Ledford <dledford@redhat.com>
cc:     Bob Pearson <rpearsonhpe@gmail.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        zyjzyj2000@gmail.com, Jason Gunthorpe <jgg@nvidia.com>
Subject: Re: Redhat 9 removes RXE (SoftROCE) support
In-Reply-To: <CAGbH50sExgSNfgcaaa_s1DWbOu88Rr1=qYmh1A9Ynpo7TMj5SA@mail.gmail.com>
Message-ID: <alpine.DEB.2.22.394.2205251412380.1109616@gentwo.de>
References: <alpine.DEB.2.22.394.2205131542300.2577@gentwo.de> <CAGbH50sExgSNfgcaaa_s1DWbOu88Rr1=qYmh1A9Ynpo7TMj5SA@mail.gmail.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, 18 May 2022, Doug Ledford wrote:

> We had too many issues with it in the past.  It might be getting better, I
> haven't been watching closely, but it had issues before.

We have been using it without issues in  Redhat 7 but now in Redhat 8 its gone.

