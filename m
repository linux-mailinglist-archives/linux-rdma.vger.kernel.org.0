Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A990B52A154
	for <lists+linux-rdma@lfdr.de>; Tue, 17 May 2022 14:16:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239516AbiEQMQv (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 17 May 2022 08:16:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232460AbiEQMQu (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 17 May 2022 08:16:50 -0400
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7740E47072
        for <linux-rdma@vger.kernel.org>; Tue, 17 May 2022 05:16:49 -0700 (PDT)
Received: by mail-qt1-x830.google.com with SMTP id fu47so14123193qtb.5
        for <linux-rdma@vger.kernel.org>; Tue, 17 May 2022 05:16:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=iLF/Jj6XGtMs56rxYAeYQ7aazvooOov9erMd/9bEfPQ=;
        b=fiOi4pYO3Ucyf+7FuK4zet1/Jrh5FNueHMfQsBWQeNmM+oiOJyxTdNlbr1t9VLdyhg
         9nnuVkUKb83uryRngEDhnS5o94eiJe93lwhXp+wpS27xl4TkStjDfTZ715iptprz+jW3
         MpUxDvL0fKMOFtw9rmvkf7xeoYp8nB4XyP6+DfgmKDQAuDpUcTIYTMRdjg5ZPEHMLPFv
         vEHCKfmt8hSMAxR5k6e+5RnlwzI1nEYkjjupaI3/vYVZ5H1fV95C4RMgRL4Me2GUjMyf
         7zq9XS1+bSeDTII8ZcaHbw1b1aj1fuqGvo2v1P/BppYVXOnnl6DQleSxHipNy6pGcHvr
         UzIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=iLF/Jj6XGtMs56rxYAeYQ7aazvooOov9erMd/9bEfPQ=;
        b=6tYacKuQeHLZMsnsKEs+qt823VU2Vq48Ji6QMtuHCpGGdGe5cPWmzIbOIRmXMKJ4+v
         BstmqlKmW3ink/I0kGB+uKo8JaLTkxz9C2boA2/AyXQ1Sotrz6WhVy/uIidMmQLT384y
         tSoZ2nmclRhuk0IchQb9Y2tZ737MnIo/U3eVAASie4lH7Lgqq29eG1A7MNvjRQPflctt
         8FEKsgabV/55gobRpV8pQ0lq1a5PgHwuPwKYDBHc0Gx5fwUgTmsUOLyB9bgdFpPwKUpC
         K7ZwpFVAf3UdtCAozEa/aJYTa3eZok0mF29N1ZH/DPvTO2VyoZ+j6ewAQWzrKen9M+Nl
         IUNw==
X-Gm-Message-State: AOAM5322LxeG00JbTMYVcF5yu0NuU3XzGr5et0QjFmF4of2pJk3fcFjF
        +THiihkufbsnKNlts13yBTOXwkPouTSyLg==
X-Google-Smtp-Source: ABdhPJyM0PjqPIZlBBrcOc/L+rNk+S3zVViqLlxik9IW8PIxUqbzj0SfEK7pvUwiKoa9Oml5VkNn/A==
X-Received: by 2002:a05:622a:8d:b0:2f3:ba67:a0ba with SMTP id o13-20020a05622a008d00b002f3ba67a0bamr19347798qtw.129.1652789808588;
        Tue, 17 May 2022 05:16:48 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-162-113-129.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.113.129])
        by smtp.gmail.com with ESMTPSA id o11-20020ac8554b000000b002f3ca56e6edsm625334qtr.8.2022.05.17.05.16.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 May 2022 05:16:47 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1nqw86-007z0H-QE; Tue, 17 May 2022 09:16:46 -0300
Date:   Tue, 17 May 2022 09:16:46 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Haowen Bai <baihaowen@meizu.com>
Cc:     Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>,
        Leon Romanovsky <leon@kernel.org>, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] RDMA: remove null check after call container_of()
Message-ID: <20220517121646.GE63055@ziepe.ca>
References: <1652751208-23211-1-git-send-email-baihaowen@meizu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1652751208-23211-1-git-send-email-baihaowen@meizu.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, May 17, 2022 at 09:33:28AM +0800, Haowen Bai wrote:
> container_of() will never return NULL, so remove useless code.

It is confusing here, but it can be null. If you want to do this then
you have to split out the _ib_alloc_device call and check it
seperately.

Jason
