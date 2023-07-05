Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09792747D51
	for <lists+linux-rdma@lfdr.de>; Wed,  5 Jul 2023 08:48:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229871AbjGEGrx (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 5 Jul 2023 02:47:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231733AbjGEGrw (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 5 Jul 2023 02:47:52 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 652AE1701;
        Tue,  4 Jul 2023 23:47:51 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id ffacd0b85a97d-3143b72c5ffso2839014f8f.3;
        Tue, 04 Jul 2023 23:47:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688539670; x=1691131670;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=zPVgka7nHr5apAHt3cgYkZtaysYSA73oSGWSwDanDig=;
        b=QDchem/LTAMTPYN94EaCfWYhV0Fr4+qGoale8uFLMC7qRJsG0UZWvQlGSzOb6jddP7
         6O7JPv3FNT0xXT7hcgC77cZ8SiGrUNj9xXFSPZrXPfhtEKBv7dWmdYzmXwCbpEHZ/dWJ
         k8wRhcLpTZyX/GL+Fq5jyhfwr0UAi2J6lotVldgWmKl4IMgvb6sMSySCkoNT8BRAmHzo
         V5FnYneXuIirV03RRkfxfBG0HOtnGSoKnltDeVeMnJmeeMQbk//7nxYZDGqpwWRfEDA5
         J6gsTF/5lAFk/lM2HDj5zkUWQIl4a1nQrgrGRMIYOj5y+47TVGbrWzP4ZarnFzsewGsR
         pNKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688539670; x=1691131670;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zPVgka7nHr5apAHt3cgYkZtaysYSA73oSGWSwDanDig=;
        b=HtJJxipivz2V9RrWYE/NPqpdJMIer/k0bi0CjXZO+7XSD7GjrjjIPetffrRx06CC4p
         jJKuNi1pCWzSH9m7GqwY958K0iJBxJbfb/zDI+bABRT7qChEWKp515SJ3eJ1kOjtP4IL
         /i+yYnsriy4VhvaGEUzzbQFpAyA///TfJf8Rx/6bYspgWH33/tvRB7hprAfO8iBfjnzx
         zRiz9XgtOCFUABQyC3hNXYXH/TlXD9etod0ahMXJNaWRGAV7U+mJGdyL+kRaJNrFGuSO
         1771QKfvDyVfIZn9ikOgjgZJiU7MaNgmgRl8hAP9KACfammlqxXjBt8LhsXKVu6KeVbO
         Ox6w==
X-Gm-Message-State: ABy/qLZSxSejrz8pF+A39Zx/NYqKbZJTk0ffVCw6nZ8gCecwmlG8RsOs
        DQxNQ1cKdAqsJ2lIkELDleiKSPNZ9ZI8FxTA2DqOpnbndecbLL+C
X-Google-Smtp-Source: APBJJlEGn6z5ZHHwKeFtVe/sLPmlDkdHxuPRILmLsZJUuSNO2Dso3PevmR5Xel+OCbncZ7iDAyDdrzNSm97uUH2B8Cc=
X-Received: by 2002:adf:dfcf:0:b0:313:f783:262a with SMTP id
 q15-20020adfdfcf000000b00313f783262amr18276397wrn.21.1688539669270; Tue, 04
 Jul 2023 23:47:49 -0700 (PDT)
MIME-Version: 1.0
References: <20230628045925.5261-1-dg573847474@gmail.com> <20230704114849.GA6455@unreal>
 <CAAo+4rXkMM87OJzim=8dACdV=kWK_1yXeD=W5GZzHoJ2Gz6rtw@mail.gmail.com> <20230705055238.GG6455@unreal>
In-Reply-To: <20230705055238.GG6455@unreal>
From:   Chengfeng Ye <dg573847474@gmail.com>
Date:   Wed, 5 Jul 2023 14:47:38 +0800
Message-ID: <CAAo+4rVMH-0zmJfYHmnUF9D5e0pbSdjcdAbWkBdroedQ2JJOGA@mail.gmail.com>
Subject: Re: [PATCH] IB/hfi1: Fix potential deadlock on &sde->flushlist_lock
To:     Leon Romanovsky <leon@kernel.org>
Cc:     dennis.dalessandro@cornelisnetworks.com, jgg@ziepe.ca,
        linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

> Exactly, we already called to spin_lock_irqsave(), there is no value in
> doing it twice.

Oh yeah, I just notice that the lock acquisition of &sde->flushlist_lock
is always nested inside &sde->tail_lock due to the goto. Then it is true
that no need for irq invariant lock/unlock on &sde->flushlist_lock.

Thanks much for your reply and your time.

Best Regards,
Chengfeng
