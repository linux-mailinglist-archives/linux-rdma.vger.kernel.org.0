Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B35745A3E2D
	for <lists+linux-rdma@lfdr.de>; Sun, 28 Aug 2022 16:52:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229517AbiH1Own (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 28 Aug 2022 10:52:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbiH1Own (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 28 Aug 2022 10:52:43 -0400
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B81C2A952
        for <linux-rdma@vger.kernel.org>; Sun, 28 Aug 2022 07:52:41 -0700 (PDT)
Received: by mail-wm1-f53.google.com with SMTP id z14-20020a7bc7ce000000b003a5db0388a8so5107978wmk.1
        for <linux-rdma@vger.kernel.org>; Sun, 28 Aug 2022 07:52:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=oMpzjQUolQg27wY37PlFFYph4RGUvIKvEmebRWeMngE=;
        b=VbzlIshON27NyjNEl44GUwtincGfn+iykvfl+2gmZpj9eCDBMfxsToPImqYnlWSryw
         48DQkde6kqrVjVEed+D2gnhlD8os7TgAuoXlHBt69/eZSASxIHpLMEm1T8EOzs7KKyCG
         gPIOxlTVe3WQOR9WrRm8SVk/v0a+ddrGaCCmIW+UCtv+YK3cOBaPJLV5In5Xg+3/wcby
         IhTSGozrvhLAAPC3L5i/ctbaj5+9g6YVYCZp4hucV1laPgPDC1BDM5EXtooXPWyGGeEt
         8WlQUyfw8SKdw4wO415EzJefIZz1PC6XWoFdYLkdvpChFBUljeFxZUo5xFA0SxCTdqcq
         ijvw==
X-Gm-Message-State: ACgBeo1TZCcwzuQaDZHx6iCqc7y/hlmyoQZH6EclDU0zaBebYFkCjdcx
        6UzkcUryYu4eAchGgTu6lzE=
X-Google-Smtp-Source: AA6agR5oKwHTnjKIbt/Wx6XIcz7N05gfddK76GPD7sxfMsY+vEjZwYeHFc6FEES8rVII6NCTexGJXQ==
X-Received: by 2002:a1c:f60f:0:b0:3a0:3e0c:1de1 with SMTP id w15-20020a1cf60f000000b003a03e0c1de1mr4736933wmc.56.1661698360013;
        Sun, 28 Aug 2022 07:52:40 -0700 (PDT)
Received: from [192.168.64.104] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id bx7-20020a5d5b07000000b00226dba960b4sm457039wrb.3.2022.08.28.07.52.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 28 Aug 2022 07:52:32 -0700 (PDT)
Message-ID: <c2d7e7cb-d0f6-672c-a1c0-db170fff9cc8@grimberg.me>
Date:   Sun, 28 Aug 2022 17:52:29 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH RFC] IB/iser: add task reference counter for tx commands
Content-Language: en-US
To:     Max Gurtovoy <mgurtovoy@nvidia.com>,
        Kashyap Desai <kashyap.desai@broadcom.com>,
        linux-rdma@vger.kernel.org
Cc:     selvin.xavier@broadcom.com, andrew.gospodarek@broadcom.com,
        Jason Gunthorpe <jgg@nvidia.com>
References: <20220824124236.812395-1-kashyap.desai@broadcom.com>
 <8288a63a-d708-4e41-78fb-e3ed7d6fd9c2@nvidia.com>
From:   Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <8288a63a-d708-4e41-78fb-e3ed7d6fd9c2@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


> Hi Kashyap Desai,
> 
> Unfortunately, there is a wider problem in iser that we do the local 
> invalidation if any, after we complete the iscsi task.
> So the right solution is to do the logic we have in NVMe/RDMA that 
> checks if remote invalidation happened and if not, it does local 
> invalidation.
> And the task is released after getting the send_completion and 
> local_invalidation/remote invalidation.
> 
> There is some infrastructure work needed to be done there.
> 
> Sagi,
> 
> Please remind me few things regarding the iSCSI bidir cmds.
> 
> In case of bidir IO cmd, if we need to use a reg_mr for it - I see a 
> potential problem there.

Not surprising.

> Is this scenario possible ?

There is no longer bidi support in scsi.
See patch: ae3d56d81507 ("scsi: remove bidirectional command support")

> I'm asking because if it is possible, so what happens in remote 
> invalidation ? what key is invalidated ? the read_key or the write_key ? 
> in ib_isert there is a priority to the read_key (is it by the spec ?).

The spec never addressed this. It wasn't well defined what to do with
remote invalidation for bidi commands.

> We don't consider this in the iser recv completion and the remote 
> invalidation checker logic.
> If it's not possible we should re-design few components in the code and 
> fix the issue that we do local_invalidation of cmd N during the send of 
> cmd N + 1.

We shouldn't bother, no consumer of this is left.
