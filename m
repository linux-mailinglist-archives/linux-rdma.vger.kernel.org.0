Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 862066E0045
	for <lists+linux-rdma@lfdr.de>; Wed, 12 Apr 2023 23:01:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229526AbjDLVBf (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 12 Apr 2023 17:01:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjDLVBf (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 12 Apr 2023 17:01:35 -0400
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com [IPv6:2607:f8b0:4864:20::731])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 558B6C4
        for <linux-rdma@vger.kernel.org>; Wed, 12 Apr 2023 14:01:34 -0700 (PDT)
Received: by mail-qk1-x731.google.com with SMTP id bj35so4971728qkb.7
        for <linux-rdma@vger.kernel.org>; Wed, 12 Apr 2023 14:01:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681333293; x=1683925293;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=YrNz2yRHHbbfTLdcq6b1VjPmIlNp5yslYXKgOAUMRMw=;
        b=M+9ZJsamX0li3ZUnPUAE90jSQPMJwm5poP7npADeS27ZO2Efck2VuiZhG9pmgdG3+/
         cAwkqyXJUD2CZ5tx/C6hvVHLPFZgXPMsz/0P82vuTlj5js/YvyiK950Y9se6lw8LSvxP
         LWRHEM476EPsaZIACEYY5SlO+Z73RbhO/x01K1lVsoHy1qba4p+a059zodXxx03oUNQc
         xY51PcXtlRi2dY2ldOrtQQKLYfgdseUM7aW8vl44EztaLz6ilQUbmGB3L2Uqiy1VeJjE
         7N2eoDt6v7Zin62wboTud2NetUHlK9+XN0xz+xY1hh2LrdtKJbf+1dwLT9+if7KCc1WM
         UuUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681333293; x=1683925293;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YrNz2yRHHbbfTLdcq6b1VjPmIlNp5yslYXKgOAUMRMw=;
        b=i401EFGCB+cMilfSWfNvW3Euydo4y69DxShHWUF7SSWYbgsV2osEKp+Uev1m5CNliQ
         Zj4ZvHfzGQWj9Z2dKzLRH3zihXHEBabtUFAc8WeC0zKRc2vVs+8TxONSagjC5FOC13b3
         V8/h337b3c5Ih5MS5wz6m3E0yKDClI9VTQfk/ANZsCZVepRsZUklAtoC+Y91fupz1n4f
         I+f7e6CEPmoxkpQ0V8ycmRuKJhe5t2yYC6eStd0gGzPM7vROwBKCFeRaq9FkUj5EaYLq
         rUQq9LsdZr/IW2adFp6UUntwTrYK/ihSySau6nmeoR5xH75EM5QnjykOt0htvFFV3lAb
         RL0Q==
X-Gm-Message-State: AAQBX9elJ5vocWf2fuOlzisbw9XRcPQVCB7aDmc61W8qOpmsbjQiVvJc
        ywiwZwR8iK3eZOiTHk68cGRCs0s34rMu9Yl9AKs=
X-Google-Smtp-Source: AKy350bZCi8ngoTZVKwjfLq0CXoe2sP9gcVv0j0KFWy3biy9CWg+doHy1nR5Fx9rr668Up63H7pumuumwA3JLmo016s=
X-Received: by 2002:a05:620a:4251:b0:74a:bafc:84ed with SMTP id
 w17-20020a05620a425100b0074abafc84edmr1393745qko.5.1681333293470; Wed, 12 Apr
 2023 14:01:33 -0700 (PDT)
MIME-Version: 1.0
References: <20230214060634.427162-1-yanjun.zhu@intel.com> <CADvaNzUvWA56BnZqNy3niEC-B0w41TPB+YFGJbn=3bKBi9Orcg@mail.gmail.com>
In-Reply-To: <CADvaNzUvWA56BnZqNy3niEC-B0w41TPB+YFGJbn=3bKBi9Orcg@mail.gmail.com>
From:   Mark Lehrer <lehrer@gmail.com>
Date:   Wed, 12 Apr 2023 15:01:22 -0600
Message-ID: <CADvaNzUdktEg=0vhrQgaYcg=GRjnQThx8_gVz71MNeqYw3e1kQ@mail.gmail.com>
Subject: Re: [PATCHv3 0/8] Fix the problem that rxe can not work in net namespace
To:     Zhu Yanjun <yanjun.zhu@intel.com>
Cc:     jgg@ziepe.ca, leon@kernel.org, zyjzyj2000@gmail.com,
        linux-rdma@vger.kernel.org, parav@nvidia.com,
        Zhu Yanjun <yanjun.zhu@linux.dev>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

> the fabrics device and writing the host NQN etc.  Is there an easy way
> to prove that rdma_resolve_addr is working from userland?

Actually I meant "is there a way to prove that the kernel
rdma_resolve_addr() works with netns?"

It seems like this is the real problem.  If we run commands like nvme
discover & nvme connect within the netns context, the system will use
the non-netns IP & RDMA stacks to connect.  As an aside - this seems
like it would be a major security issue for container systems, doesn't
it?

I'll investigate to see if the fabrics module & nvme-cli have a way to
set and use the proper netns context.

Thanks,
Mark
