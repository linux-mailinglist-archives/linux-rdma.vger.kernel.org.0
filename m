Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D976F5FC900
	for <lists+linux-rdma@lfdr.de>; Wed, 12 Oct 2022 18:17:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229591AbiJLQR6 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 12 Oct 2022 12:17:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229527AbiJLQR5 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 12 Oct 2022 12:17:57 -0400
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com [IPv6:2607:f8b0:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74B9B9AFA4
        for <linux-rdma@vger.kernel.org>; Wed, 12 Oct 2022 09:17:56 -0700 (PDT)
Received: by mail-oi1-x233.google.com with SMTP id d64so19583962oia.9
        for <linux-rdma@vger.kernel.org>; Wed, 12 Oct 2022 09:17:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BbKpianW2150/pf+CMXb7FGKc/BNWOae7Tm5DjsUrJ0=;
        b=lvZ2vNdlnIhaMmrYuCoMXnE9esrQJcN9diLLr1/iCVhzymMy3GGLRlo5ejVPpGe8k7
         dR3/AjB6YfSG14ryWnnFSGl8ACMK1l/VqfuAIgoSKo0OhrQOZeqOwM6YgwZPjU4IMOe1
         If7WVmMatnhYn4VtrncXriECDuEA8TFNIPzWsUS0PvBBdv8sa+zLOZeHvSKBDcZHXsFF
         fCgrlC6NAMz/IXQeAt45IAOEHDhm9VvsZF6y/GXAICb9k7OK/heQz4rzM8xDO4kQWSc7
         RuxGjcRSJcw063aXnjhTheR2h0mxwCCfD/nDZATRaycZD7+JoWs7vnpygXXUltiuSxJn
         EZrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=BbKpianW2150/pf+CMXb7FGKc/BNWOae7Tm5DjsUrJ0=;
        b=J6K6gVa5inE8jbsvQL66MQ/7exQP0AlNCsdz1uARFmEPwgqyugBStIn2cV6NrC0sOv
         NPgvHebPtrs0kuQx3WPDOybfjF0q8vEXvDUyp5BVr4/rqnVIdrQcC+KIywMwOMdHcq1P
         p0XhyNgNRJVK8QGf4zn+lDamrNToEL+UxYmQy5lQGOIoWRYoouscNT48caw0sZemdpCC
         1ziT6E91YjD+6eWyDDIcoq2s+IHymUm9FszGhbuwUHAZ44BP60aM4e76jMxg3HAbnlLG
         VXckGK0wntzDB+hHY6bb9fm7lpX5Y6KLPnp9DglUmCE1AdO8Nj5OdFU6+Zz0vwa0gYaf
         /PtQ==
X-Gm-Message-State: ACrzQf2/exPiQe++CKVgabMAH1w4MbLNyZDBqDWUsdcx/ECtBHvCuhdf
        aguMboBlkXZseTsJAkqu7IqW++xHLo1cpw==
X-Google-Smtp-Source: AMsMyM5S/6PpXRfr9c5HyPBeE3fofIfCixXCAkmmcY2DGJi1jIsQrM/52t5BDdYEI0nGrBWGqLPt9g==
X-Received: by 2002:aca:180b:0:b0:352:8bda:c428 with SMTP id h11-20020aca180b000000b003528bdac428mr2484647oih.13.1665591475794;
        Wed, 12 Oct 2022 09:17:55 -0700 (PDT)
Received: from ?IPV6:2603:8081:140c:1a00:8ea3:cb1b:ceb1:d1a3? (2603-8081-140c-1a00-8ea3-cb1b-ceb1-d1a3.res6.spectrum.com. [2603:8081:140c:1a00:8ea3:cb1b:ceb1:d1a3])
        by smtp.gmail.com with ESMTPSA id g9-20020a056870d20900b0011bde9f5745sm1348661oac.23.2022.10.12.09.17.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Oct 2022 09:17:55 -0700 (PDT)
Message-ID: <3867f7a8-80ab-f3ee-e631-63756fefb82e@gmail.com>
Date:   Wed, 12 Oct 2022 11:17:53 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Content-Language: en-US
To:     Jason Gunthorpe <jgg@nvidia.com>,
        Zhu Yanjun <zyjzyj2000@gmail.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
From:   Bob Pearson <rpearsonhpe@gmail.com>
Subject: RDMA/rxe: Receive wqe flush error completions on qp error
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Currently the rxe driver flushes the send queue on a transition of the qp to the error state and completes these wqes with flush errors but does not do this for the receive queue. The IBA spec requires that this happens. Is there a reason why this wasn't done or does it just not come up in practice?

Bob
