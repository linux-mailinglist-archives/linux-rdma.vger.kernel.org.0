Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D1146CC7BA
	for <lists+linux-rdma@lfdr.de>; Tue, 28 Mar 2023 18:18:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231979AbjC1QSu (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 28 Mar 2023 12:18:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229670AbjC1QSt (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 28 Mar 2023 12:18:49 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36EC1D533
        for <linux-rdma@vger.kernel.org>; Tue, 28 Mar 2023 09:18:48 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id h12-20020a17090aea8c00b0023d1311fab3so13165063pjz.1
        for <linux-rdma@vger.kernel.org>; Tue, 28 Mar 2023 09:18:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1680020327;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=rW7JxQYvRpQny4e0VTL5HRewXQV02PFKQE4vDdP8XF0=;
        b=N4AM3zAOWfSplyzMRO3c0hxz085FIX7JNiIjLcLgUpt374MK06qC6StA3HOvhR52xW
         040+NW7SayhheDLe3l2qDr88FhNf0fw7XboLyhLf0znC0RoGbQIC6VkVLWMJS2eJM0JL
         fl1oUqfmfdvs1On4d+cvQOcJy18W5Fzm0ytqKYJbiwWBgpc3qKBSTJPS6or7z8ih8/6j
         2aDHHFMrXArfuO+DFsL9OJwcAxWTWL5U2qgT+HE2sGmeRn3vZgILN4SntBZGsGppVe4N
         55UUjz7CXtJVq0JNozx7Em8DepvLFLlKP37ZZk2zFUezbS0BxgQbEDG3txqum9GP+ELU
         Pbrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680020327;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rW7JxQYvRpQny4e0VTL5HRewXQV02PFKQE4vDdP8XF0=;
        b=R0lU0Aco7M+x8J1yjw9lQm4s5v+KrRprRJ4GbCf25kbjrh8BEOIl49ZNoyqam/qsDN
         ll1huQP7e3TxpCPz8+hMuh7vi3pTgka88KX3XqXpHwdTQwCwm3WEUl1zvwSVVcfz+uH8
         OrHPnNct+WQuLcaM3YOBjj3UI6wbkE7yx74l6MTerWmQ0FIEGCiafS8tzhCOTqNCprXN
         d2yNQapJIwognGI5n79NIb0V93rZwHf0o1MkF4Z0KRMOqBDXBAd0gd8i9MoChiE5umhv
         KT/OJZBfcpexNYdVp0a7uQOxLrq12Sdf4wCbTXZNERFY7UhYTBfAjGvhXlnbw3ICPkzQ
         SLxw==
X-Gm-Message-State: AAQBX9cBkqtYfEY0sERZnDwLKRjMNs/77zJAmEFftXCjFgIXNzwbX81z
        e35vN0MOaa6Dz4TgfXHK9p6VCg==
X-Google-Smtp-Source: AKy350bsJBKYKfyUYks2jRHh+myQAGWk5Ku1PduvHrKvz+m6fJKKmCBHnEEIOC6WMd7IkTBnYAY7fw==
X-Received: by 2002:a05:6a20:4c82:b0:e1:204e:ddd6 with SMTP id fq2-20020a056a204c8200b000e1204eddd6mr2521295pzb.6.1680020327574;
        Tue, 28 Mar 2023 09:18:47 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-25-194.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.25.194])
        by smtp.gmail.com with ESMTPSA id x48-20020a056a000bf000b005a79596c795sm21184633pfu.29.2023.03.28.09.18.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Mar 2023 09:18:47 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
        (envelope-from <jgg@ziepe.ca>)
        id 1phC21-003mGl-Nq;
        Tue, 28 Mar 2023 13:18:45 -0300
Date:   Tue, 28 Mar 2023 13:18:45 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     Bernard Metzler <bmt@zurich.ibm.com>,
        Leon Romanovsky <leon@kernel.org>,
        Ursula Braun <ubraun@linux.ibm.com>,
        OFED mailing list <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH] RDMA: don't ignore client->add() failures
Message-ID: <ZCMTZWdY7D7mxJuE@ziepe.ca>
References: <0e031582-aed6-58ee-3477-6d787f06560a@I-love.SAKURA.ne.jp>
 <ZCLOYznKQQKfoqzI@ziepe.ca>
 <a9960371-ef94-de6e-466f-0922a5e3acf3@I-love.SAKURA.ne.jp>
 <ZCLQ0XVSKVHV1MB2@ziepe.ca>
 <ec025592-3390-cf4f-ed03-c3c6c43d9310@I-love.SAKURA.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ec025592-3390-cf4f-ed03-c3c6c43d9310@I-love.SAKURA.ne.jp>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Mar 28, 2023 at 11:59:48PM +0900, Tetsuo Handa wrote:
> Without this patch, __ib_unregister_device(device) is not called because
> enable_device_and_get() returns 0 because add_client_context() returns 0
> because add_client_context() ignores client->add() faiulures. As a result,
> device's refcount remains 7, which later prevents unregister_netdevice()
>  from unregistering this device.

That is completely correct, the device was successfully registered
without one of the clients.

It seems to me all this has done done is make it so the device doesn't
register and that will hide the refcount bug because the bug is
actually something that happens during operation - and we never get to
operation now.

Jason
