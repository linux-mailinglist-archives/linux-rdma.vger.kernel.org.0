Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 240FC1AA9E2
	for <lists+linux-rdma@lfdr.de>; Wed, 15 Apr 2020 16:29:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392022AbgDOO1l (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 15 Apr 2020 10:27:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2391955AbgDOO1j (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 15 Apr 2020 10:27:39 -0400
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BACACC061A0C
        for <linux-rdma@vger.kernel.org>; Wed, 15 Apr 2020 07:27:37 -0700 (PDT)
Received: by mail-qk1-x742.google.com with SMTP id 20so9294563qkl.10
        for <linux-rdma@vger.kernel.org>; Wed, 15 Apr 2020 07:27:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=0UT8lst5nDXa5EduKqboY813zRQkbwrz0jocGjjJQg4=;
        b=M4ITrRhk7dfzvUeRdnL4el+TCzeHs3naP4MrWW4R1ebq1UIOWnrl93o0W9yRfnjzHy
         NT032XMp1hFXo56VJAe4LrTAJy3eE/dHu37RBmLt2Zl5j5aNPUg7XgPdeK5Nc0z8l935
         msisJ0cQFtktiusujfESKJ+ZOURH6tbRVKt6mnLWAQuba28l/jNyCYQCghrerFGhW0cJ
         VrTpFPgcobc3NRi5mFK/mbFhgNMIjkl6q6wtEucefdcmM++kvP83i7hObsP1GN96TDcG
         xrqPzBLivfZkOewyhTOIO+Hq3K1umGyG+P0qUutNW6Dm6RzqofYyRH65wS2ceiYOi19V
         QUIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=0UT8lst5nDXa5EduKqboY813zRQkbwrz0jocGjjJQg4=;
        b=Sm565UQMqxlzryYTnvj3JWnEXXzKeBrP4cENoURl12vB6uuX4JcyMXddp9c90w+k1c
         ery6Zy/FbjNvgss4/WSnKF2OjvsiwsXXcacPbsN7Gd7uCXtC0JD6bMqThYkeFr4DKoA/
         z/UccZf2jCzBShYu0vAZmkiok0O7aZo8GkSX8IMCDfRG8lhSSDf8ZBffwmzWGzPBB+2u
         RfTqYqK9tmgBcO2jcUmQ0jV5KfZ+OgeEkw2fn7KbX/UPd3nSSQainHrp5txDL4Ef/05f
         JOE8fb7GNB6Yj6x6yfwLUtBNQJPYysuxwarHsA9tdPQ8CV53beDI+uSKXr2uqgZM79E6
         TUkg==
X-Gm-Message-State: AGi0PuZuLCZGaPzxuK1f+Uty0NQjrhrmCttvc53oa6or9DYkZBF7zp1m
        5BsCn582TghkBTin5QWEqpFDlA==
X-Google-Smtp-Source: APiQypLaOI+L9pCKFHu2QPiB6b7nqxtp36pMRhQOjDoNH7Il0R7qpTY/S9EZXVMsSsn12k0BoKrNtQ==
X-Received: by 2002:a05:620a:5fc:: with SMTP id z28mr27276673qkg.346.1586960856921;
        Wed, 15 Apr 2020 07:27:36 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-57-212.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.57.212])
        by smtp.gmail.com with ESMTPSA id v187sm12740442qkc.29.2020.04.15.07.27.36
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 15 Apr 2020 07:27:36 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1jOj0p-0005zU-UU; Wed, 15 Apr 2020 11:27:35 -0300
Date:   Wed, 15 Apr 2020 11:27:35 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Bernard Metzler <BMT@zurich.ibm.com>
Cc:     Xiyu Yang <xiyuyang19@fudan.edu.cn>,
        Doug Ledford <dledford@redhat.com>, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org, yuanxzhang@fudan.edu.cn,
        kjlu@umn.edu, Xin Tan <tanxin.ctf@gmail.com>
Subject: Re: [PATCH] RDMA/siw: Fix potential siw_mem refcnt leak in
 nr_add_node
Message-ID: <20200415142735.GP5100@ziepe.ca>
References: <20200415140910.GN5100@ziepe.ca>
 <1586939949-69856-1-git-send-email-xiyuyang19@fudan.edu.cn>
 <OFF7AE12D1.38AFBC66-ON0025854B.004E30DB-0025854B.004E73A2@notes.na.collabserv.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <OFF7AE12D1.38AFBC66-ON0025854B.004E30DB-0025854B.004E73A2@notes.na.collabserv.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Apr 15, 2020 at 02:16:54PM +0000, Bernard Metzler wrote:
> Fine with me in principle, but we would have to return
> directly here as well - since we do not have a valid mem
> to be put back.

Woops, yes, thanks

Jason
