Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA36E51E78B
	for <lists+linux-rdma@lfdr.de>; Sat,  7 May 2022 15:52:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235838AbiEGN4Q (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sat, 7 May 2022 09:56:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232825AbiEGN4N (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sat, 7 May 2022 09:56:13 -0400
Received: from mail-oo1-xc2b.google.com (mail-oo1-xc2b.google.com [IPv6:2607:f8b0:4864:20::c2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4852446678
        for <linux-rdma@vger.kernel.org>; Sat,  7 May 2022 06:52:27 -0700 (PDT)
Received: by mail-oo1-xc2b.google.com with SMTP id l9-20020a4abe09000000b0035eb3d4a2aeso1740565oop.0
        for <linux-rdma@vger.kernel.org>; Sat, 07 May 2022 06:52:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:content-language:to:from
         :subject:content-transfer-encoding;
        bh=8C4+33mTjZ3HWWtyq51pdoJZvdBkpLExTmtjb0//ANs=;
        b=MtE2ipD7aTRL35X61TcYJpnYTt8WxjFZRKd6MTQZg9cZSBl3xEaCjKUCpx4FjlW0pp
         0e7J/5sy7puOQXkPtXIZ4VJ8IgRWXkuE8c3zFRHfJEOAhkJL3HuQGl+tT4zbH/VM8qQJ
         pAc0FZTaxjc7of3okp6r8EOdwRMRqSgRa01Thc2G+i0h9M0UXDuZAVbjurof6AQNrxV5
         u72RtSb0MEy5C238OXkR29YgwzAASh6D+eD1K/erIKynMSSiE0/cZ1ThKZTLDIlIThmI
         675CWYCY8AtaCcCR1kbyqeEW/bwCf4bQNw2+gtifguERBOfNWte1pOE4yIZ7TetI9kVZ
         tcrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent
         :content-language:to:from:subject:content-transfer-encoding;
        bh=8C4+33mTjZ3HWWtyq51pdoJZvdBkpLExTmtjb0//ANs=;
        b=6NIVKGGhRSYr4wGGOPNkk3grGPiXll2xju9y8+Z+jTS6IszPa2jNyBjz+kpdT8U7Az
         CFrweu5uoi8kWkrjLSK2agd6OgtebVSKcN10whW1+zWnsW6l2fd67vYiJSqHTZ2BxZ4d
         WLUmOdegBVURJKibpDRzz+TsPEr5fcboTiyGZRYsrIAwUTIK173b2A+/YTQ06BJG7i4z
         tR2+AUd3eXCK7zeVxuRc+TFe6Ww1am4ScWXnVCZE+Tpxi8EOMaE0Br+s2ezPGCXIFEZE
         ZgTZv7+W+ZcOZ18uI5M7SBLLbTCnUhIQzfkYpb1US2Roj2GDKWDGWbRtt2I6tCSCLCCS
         S4dA==
X-Gm-Message-State: AOAM533sCGG4/KYJIxXUGAGgvNxtd/0D3Z1IjXS5qfdY343M4QznJnWP
        wQxFaExl8wVD6tAmNIkrHLRNAs4lnfI=
X-Google-Smtp-Source: ABdhPJyR5GY8ZTcIn5JuGtyYs3pqiuH3gVcMxYsdMokrgpk5Xopb2egftCiQWUbl3ZrafiJy3IWbrg==
X-Received: by 2002:a4a:b48d:0:b0:338:da9e:87b5 with SMTP id b13-20020a4ab48d000000b00338da9e87b5mr2765653ooo.59.1651931546673;
        Sat, 07 May 2022 06:52:26 -0700 (PDT)
Received: from ?IPV6:2603:8081:140c:1a00:d2c5:54e1:2725:1869? (2603-8081-140c-1a00-d2c5-54e1-2725-1869.res6.spectrum.com. [2603:8081:140c:1a00:d2c5:54e1:2725:1869])
        by smtp.gmail.com with ESMTPSA id a204-20020acab1d5000000b00325643bce40sm2768710oif.0.2022.05.07.06.52.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 07 May 2022 06:52:26 -0700 (PDT)
Message-ID: <a8287823-1408-4273-bc22-99a0678db640@gmail.com>
Date:   Sat, 7 May 2022 08:52:25 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Content-Language: en-US
To:     Zhu Yanjun <zyjzyj2000@gmail.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
From:   Bob Pearson <rpearsonhpe@gmail.com>
Subject: RDMA/rxe: [BUG-REPORT] Incorrect rnr retry behavior
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

(Not related to blktests at all)

When running the python test suite repeatedly (~50-100X) I occasionally see RNR retry failures.
With some tracing it turns out that the rxe driver *never* waits for the rnr_nak_timer to expire
before retrying the send queue. Something else is triggering the requester tasklet to re-run and
retry the send queue much too early so not enough time is allowed. This can be fixed by adding
a flag to qp->req indicating that the requester should wait for the rnr_nak_timer to fire
before running again. Most of the time it still works with the reduced timeout but occasionally
it fails. This will cause intermittent rnr_nak failures.

Bob
