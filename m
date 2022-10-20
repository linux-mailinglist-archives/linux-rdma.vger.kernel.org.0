Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C3546061C3
	for <lists+linux-rdma@lfdr.de>; Thu, 20 Oct 2022 15:38:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229761AbiJTNiB (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 20 Oct 2022 09:38:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229817AbiJTNh7 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 20 Oct 2022 09:37:59 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF9EF1A2E15;
        Thu, 20 Oct 2022 06:37:58 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id 67so20250282pfz.12;
        Thu, 20 Oct 2022 06:37:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-language:content-transfer-encoding:mime-version:user-agent
         :date:message-id:cc:to:subject:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HObGkk8/50MLX1fXtg3oFVqil/SnGKf+l1zdO9y3SR8=;
        b=qlhc67dyLARvuESh0/6OU6vWyLT/K5vwlz6HxntCHddTHgjVtJIANKdW1fwRuRLdJ2
         wuNZ9QJ3Ac7VGNqzWLPRfyjVNQHNcameIWz3IuHVtt4iH5oFiYVlToG8oEw+Xm2Ird6c
         cMKRDBRGDbRbCrlWorYfyVjkY7JEFpDz+ZvZ8cMko1jMbRtfsPjk5qMljvmoV/1Rr7uk
         85o/V3UZ5e3Esi5m/PceVo7VV+w68mnBcrAiHfMvsWzm3iQN70CGZs+N+tm94OanZDKq
         0GckElRGQyaV/IWV6h9EXYo3GwaDzCptTN79wg1mKRsQFha3cmbQJ2TtQXwzxnKK4DBI
         yFGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-language:content-transfer-encoding:mime-version:user-agent
         :date:message-id:cc:to:subject:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HObGkk8/50MLX1fXtg3oFVqil/SnGKf+l1zdO9y3SR8=;
        b=KSg3Xi4n9/1DUD5KBcn7tgWXm2ZlJ7Un53cR9RTDl3MB48ph1X2KE/kOariStWExPX
         0/I8alF979tIkvPvJCNd6zqiFWMNKq30ZAF9fpj6vhy9H8G2jqNAdlB4ZiUdYLamDvDH
         2oSPUcs6luW6ji133DiN3K/MC9TcY0Sbj5Qcb1ZJr1NngByDMi/xVhizMY1hFPYwzAw0
         aR13Pngjozb4JW5fymRTNrQ/vAvF8qPodCGeH24HdTQSb65QOqcNG5yCecJ8BYr7F6HU
         4QsRafOBunNC1/k1oXi99UYadzm3Y9pYw3ihOaEVuj5me6jOOheQrRrOIyK5taHE+Lp3
         +6lw==
X-Gm-Message-State: ACrzQf3NNPWvMnfn0sMnJAucra+rfLBfL0SggrwC0x9chcIOxfyWhAQj
        1n2L/Ydjy/LlRkeZ/12xYAvw97yBZC0vmg==
X-Google-Smtp-Source: AMsMyM61LY2v/6Nt4JmFXyiKme0ueRkrE85gmZcRNgsvcAU8HafSJalFMgoD5NA2hMeyaUdKGjAonA==
X-Received: by 2002:a63:8549:0:b0:461:3995:60d1 with SMTP id u70-20020a638549000000b00461399560d1mr11766364pgd.105.1666273077593;
        Thu, 20 Oct 2022 06:37:57 -0700 (PDT)
Received: from [100.64.100.6] ([194.5.48.149])
        by smtp.gmail.com with ESMTPSA id c6-20020a170902b68600b00172e19c5f8bsm12779963pls.168.2022.10.20.06.37.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Oct 2022 06:37:57 -0700 (PDT)
From:   Jia-Ju Bai <baijiaju1990@gmail.com>
Subject: [BUG] infiniband: sw: rdmavt: possible ABBA deadlocks in
 rvt_ruc_loopback()
To:     dennis.dalessandro@cornelisnetworks.com, jgg@ziepe.ca,
        Leon Romanovsky <leon@kernel.org>
Cc:     linux-rdma@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>
Message-ID: <afe67a8e-82b8-9a47-0832-527c652cc66e@gmail.com>
Date:   Thu, 20 Oct 2022 21:37:47 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Hello,

My static analysis tool reports several possible ABBA deadlock in the 
rdmavt driver in Linux 5.18:

rvt_ruc_loopback()
   spin_lock_irqsave(&sqp->s_lock, flags); --> Line 3190 (Lock A)
   spin_lock(&sqp->r_lock); --> Line 3195 (Lock B)

rvt_qp_mr_clean()
   spin_lock_irq(&qp->r_lock); --> Line 698 (Lock B)
   spin_lock(&qp->s_lock); --> Line 700 (Lock A)

rvt_rc_timeout()
   spin_lock_irqsave(&qp->r_lock, flags); --> Line 2595 (Lock B)
   spin_lock(&qp->s_lock); --> Line 2596 (Lock A)

rvt_modify_qp()
   spin_lock_irq(&qp->r_lock); --> Line 1419 (Lock B)
   spin_lock(&qp->s_lock); --> Line 1421(Lock A)

_rvt_reset_qp()
   spin_lock_irq(&qp->r_lock); --> Line 907 (Lock B)
   spin_lock(&qp->s_lock); --> Line 909 (Lock A)

rvt_reset_qp()
   spin_lock_irq(&qp->r_lock); --> Line 936 (Lock B)
   spin_lock(&qp->s_lock); --> Line 938 (Lock A)

When rvt_ruc_loopback() is concurrently executed with rvt_qp_mr_clean(), 
rvt_rc_timeout(), rvt_modify_qp(), _rvt_reset_qp() or rvt_reset_qp(), 
the deadlocks can occur.

I am not quite sure whether these possible deadlocks are real and how to 
fix them if real.
Any feedback would be appreciated, thanks :)

Reported-by: TOTE Robot <oslab@tsinghua.edu.cn>


Best wishes,
Jia-Ju Bai
