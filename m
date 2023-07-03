Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2909746642
	for <lists+linux-rdma@lfdr.de>; Tue,  4 Jul 2023 01:55:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230240AbjGCXzr (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 3 Jul 2023 19:55:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230208AbjGCXzq (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 3 Jul 2023 19:55:46 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94899187
        for <linux-rdma@vger.kernel.org>; Mon,  3 Jul 2023 16:55:45 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id a640c23a62f3a-9936b3d0286so170484666b.0
        for <linux-rdma@vger.kernel.org>; Mon, 03 Jul 2023 16:55:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1688428544; x=1691020544;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=vSdK1dgSw1SsTFoY2n1BvPJHJg9tmlm/zjsLZax/LHE=;
        b=NAYc2j3GlDShANhFW6W2coOpp8wGnL9hLpB3/K5EQnFCh3rAUW5X2jZ9QBjp5SHs6Q
         jPrjmWQ4HZes70HAS8ZS9NARQ0UbQu4p+dNDuWzy9jPXFhyNvR7Cb4IVmZXs3nKG4CyQ
         0dX6TORGy86Ux7E2M/3ccxdniw50VPGf0iO1o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688428544; x=1691020544;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vSdK1dgSw1SsTFoY2n1BvPJHJg9tmlm/zjsLZax/LHE=;
        b=k3UYFZUK+W7sLQg5VLrU1Nk0iK7XzcAxXAsZOR3cpBARRG06+yS38rjsRJK0iaIM0U
         9fsZFV1Dfxlq/n/f22aJhg3rCTGrgCnaoKEQS0v1ZfTZwBF2lsnf44Mvk1DJjDlSrgi3
         6zB/sR3rHhvHvO5qRnPwE9VKDNB+1FseQsL5eeEyzkqv8n3dT0mIw+4f5HscRNXQjrbJ
         OoHFxyEoPMrG1A6cocX5zi76p8o4jz5xDexR8gZ8RdS1ny1ZadIJCPs0M7r0T9VLRVH7
         7BOCezZZ45M4MU6lG6+2nSIl6MHpmFC/IxmThxeEn8wgV3locRl81s4HC/eV3tuz2hP4
         tqAg==
X-Gm-Message-State: ABy/qLZ+3wvVNdY3jnjitH8QtK02TwF0vZ28a6kngoeduzUpwlh+6pMO
        Nq1m5Hdwx3KaNKAHLzabbnWaH/3bTe8LFdkhzR8DFJ1t
X-Google-Smtp-Source: APBJJlF4pUzYoUeip3lYspkddeV743dAoR7CImpqM17cE46l2auLpNgsUkyrNi0CU0GDWp5BGGu+qA==
X-Received: by 2002:a17:906:29ce:b0:992:b8b6:6bcd with SMTP id y14-20020a17090629ce00b00992b8b66bcdmr10254038eje.16.1688428543999;
        Mon, 03 Jul 2023 16:55:43 -0700 (PDT)
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com. [209.85.208.46])
        by smtp.gmail.com with ESMTPSA id a3-20020a17090682c300b00992025654c4sm9025935ejy.182.2023.07.03.16.55.43
        for <linux-rdma@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Jul 2023 16:55:43 -0700 (PDT)
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-51d7f350758so6424630a12.3
        for <linux-rdma@vger.kernel.org>; Mon, 03 Jul 2023 16:55:43 -0700 (PDT)
X-Received: by 2002:aa7:d502:0:b0:51d:d1ca:eab9 with SMTP id
 y2-20020aa7d502000000b0051dd1caeab9mr8690475edq.32.1688428542685; Mon, 03 Jul
 2023 16:55:42 -0700 (PDT)
MIME-Version: 1.0
References: <20230703113025.356682-1-arnd@kernel.org> <20230703133242.GB32152@unreal>
In-Reply-To: <20230703133242.GB32152@unreal>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 3 Jul 2023 16:55:25 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiJ2S9rrz6+aVv88ct7vZjZW8O02MFxXkCUmOXcx9em6w@mail.gmail.com>
Message-ID: <CAHk-=wiJ2S9rrz6+aVv88ct7vZjZW8O02MFxXkCUmOXcx9em6w@mail.gmail.com>
Subject: Re: [PATCH] RDMA: fix INFINIBAND_USER_ACCESS dependency
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Arnd Bergmann <arnd@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>,
        Selvin Xavier <selvin.xavier@broadcom.com>,
        Arnd Bergmann <arnd@arndb.de>, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, 3 Jul 2023 at 06:32, Leon Romanovsky <leon@kernel.org> wrote:
>
> Linus, can you please apply this patch directly as it is overkill to
> send PR for one patch?

Done.

                  Linus
