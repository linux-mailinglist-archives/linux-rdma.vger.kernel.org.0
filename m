Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06C3F6066D1
	for <lists+linux-rdma@lfdr.de>; Thu, 20 Oct 2022 19:14:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229608AbiJTRNy (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 20 Oct 2022 13:13:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230054AbiJTRNi (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 20 Oct 2022 13:13:38 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18F001A910B;
        Thu, 20 Oct 2022 10:13:37 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id bk15so35724579wrb.13;
        Thu, 20 Oct 2022 10:13:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TUR9UP15QsroU59W9N2OvgMcXwfXPj1HigJZQ6HBl4s=;
        b=nYbt0LiN2JHu2xyzaE3qLJP8Oh7Rzry1IfknyRHx7vYRnQZwjn1ifPrJaTyN8tu7Em
         FXOJXL8JuEA6M0GUVfFPuI9rX8dl8hmCXcFWXWOHEnDmcs8NL1C4IFmcg1uRq3HQg8eL
         lxiARDBtWJ6llNb4RaV7mXfCn9xPIOThgQRTtxd13RdQlfRk28ozCXqZnfhAZ6IraMig
         BNUJXtdF5ZKWy8hdf6ShDBY/HUDEuy4uLqKu3rcXZ0tB5M1HsPkXx2Fs3ESEP/IY21b1
         bH0mgt2jp/GlRVcrf+iVsJjkN1dukXli8ayi6k3zgca6a8QQBCNXjymXY0p7PLUEMoTe
         fqng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TUR9UP15QsroU59W9N2OvgMcXwfXPj1HigJZQ6HBl4s=;
        b=UwYDFwvfHINyr7MTq6QsQFNLSXcqCD9gzGNoBZoMiNAcGwyTLKeKfV+XUE4oDvDuiV
         5Q6jtvO1nKVN4QOlzMAERCkR1CmE+c/svEpenISsUL5EtfQ8eWXW859IVQ/lU5s3yYwp
         pxN2mgLYNd86yJzfZ8zexIxQeCtG5AlY226vzl9XfT5GdVJqAnO6TZ8AajWPCAgNTubi
         kuSBa4fDI/JTuJUoFX5DYXY2cRBwgf256TSSHVT7JmrdL/5I74OVJwfb6PIjI+J96r4U
         XjKCU9t8/S3fZDo38XKPYiIK4ddUyLnUfDI5J06WNkfEe26iEV087Q9eYpY9Lu50oHCI
         9CCw==
X-Gm-Message-State: ACrzQf1mp/s0gmWIuaGvDOJ1v80QAD/T2etNUyD6Vi2TRpBtPJuM9B5h
        BhdUOYNjwoPH8uO0UmaiukktMk8By3A=
X-Google-Smtp-Source: AMsMyM78Y15sou0S6xhBnRpH9lQP6a4ksqQetLS76/lBZjZmqOFcqwGJLwBXzbJU13hwo89TjWoTlg==
X-Received: by 2002:a5d:4e4b:0:b0:22e:47b3:6b5d with SMTP id r11-20020a5d4e4b000000b0022e47b36b5dmr9408377wrt.443.1666286015593;
        Thu, 20 Oct 2022 10:13:35 -0700 (PDT)
Received: from ?IPV6:2a02:1811:cc83:eef0:7bf1:a0f8:a9aa:ac98? (ptr-dtfv0pmq82wc9dcpm6w.18120a2.ip6.access.telenet.be. [2a02:1811:cc83:eef0:7bf1:a0f8:a9aa:ac98])
        by smtp.gmail.com with ESMTPSA id z23-20020a1cf417000000b003c6b874a0dfsm221022wma.14.2022.10.20.10.13.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Oct 2022 10:13:34 -0700 (PDT)
Message-ID: <6e038fa4-563a-2690-2a62-b92df117714a@gmail.com>
Date:   Thu, 20 Oct 2022 19:13:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [BUG] infiniband: sw: rdmavt: possible ABBA deadlocks in
 rvt_ruc_loopback()
Content-Language: en-US
To:     Jia-Ju Bai <baijiaju1990@gmail.com>,
        dennis.dalessandro@cornelisnetworks.com, jgg@ziepe.ca,
        Leon Romanovsky <leon@kernel.org>
Cc:     linux-rdma@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <afe67a8e-82b8-9a47-0832-527c652cc66e@gmail.com>
From:   Niels Dossche <dossche.niels@gmail.com>
In-Reply-To: <afe67a8e-82b8-9a47-0832-527c652cc66e@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 20/10/2022 15:37, Jia-Ju Bai wrote:
> Hello,
> 
> My static analysis tool reports several possible ABBA deadlock in the rdmavt driver in Linux 5.18:
> 
> rvt_ruc_loopback()
>   spin_lock_irqsave(&sqp->s_lock, flags); --> Line 3190 (Lock A)
>   spin_lock(&sqp->r_lock); --> Line 3195 (Lock B)
> 
> rvt_qp_mr_clean()
>   spin_lock_irq(&qp->r_lock); --> Line 698 (Lock B)
>   spin_lock(&qp->s_lock); --> Line 700 (Lock A)
> 
> rvt_rc_timeout()
>   spin_lock_irqsave(&qp->r_lock, flags); --> Line 2595 (Lock B)
>   spin_lock(&qp->s_lock); --> Line 2596 (Lock A)
> 
> rvt_modify_qp()
>   spin_lock_irq(&qp->r_lock); --> Line 1419 (Lock B)
>   spin_lock(&qp->s_lock); --> Line 1421(Lock A)
> 
> _rvt_reset_qp()
>   spin_lock_irq(&qp->r_lock); --> Line 907 (Lock B)
>   spin_lock(&qp->s_lock); --> Line 909 (Lock A)
> 
> rvt_reset_qp()
>   spin_lock_irq(&qp->r_lock); --> Line 936 (Lock B)
>   spin_lock(&qp->s_lock); --> Line 938 (Lock A)
> 
> When rvt_ruc_loopback() is concurrently executed with rvt_qp_mr_clean(), rvt_rc_timeout(), rvt_modify_qp(), _rvt_reset_qp() or rvt_reset_qp(), the deadlocks can occur.
> 
> I am not quite sure whether these possible deadlocks are real and how to fix them if real.
> Any feedback would be appreciated, thanks :)
> 
> Reported-by: TOTE Robot <oslab@tsinghua.edu.cn>
> 
> 
> Best wishes,
> Jia-Ju Bai


Hi


I don't know whether this deadlock is real or not, but I wrote the offending code.
If it's a real bug, I'm sorry about that.
If that's the case the bug is also present in 2 other places of rvt_ruc_loopback() in v5.19+:

1)
spin_lock_irqsave(&sqp->s_lock, flags); --> Line 3133
spin_lock(&sqp->r_lock); --> Line 3137

2)
spin_lock_irqsave(&sqp->s_lock, flags); --> Line 3192
spin_lock(&sqp->r_lock); --> Line 3193


Kind regards
Niels
