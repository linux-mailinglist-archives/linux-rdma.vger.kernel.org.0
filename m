Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D7A48230592
	for <lists+linux-rdma@lfdr.de>; Tue, 28 Jul 2020 10:38:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728249AbgG1Iig (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 28 Jul 2020 04:38:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728017AbgG1Iig (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 28 Jul 2020 04:38:36 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6822C061794
        for <linux-rdma@vger.kernel.org>; Tue, 28 Jul 2020 01:38:35 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id f14so3940887ejb.2
        for <linux-rdma@vger.kernel.org>; Tue, 28 Jul 2020 01:38:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=FLdcQvbATlWGb3q817mpG8Q2+i83wVtJgcYRlPT/aYA=;
        b=rh/1akvf40M581mlxkqXDO+9psDBBE6vF1QtmMxFTFtuZ0Evzz3otoUnh9uxiAE/Wq
         0TA+gZsVRDYeWlr6TUTpJph7crDUZFdgZkZdiV0ctGLdAvNG4jReRn17awP5gO55PCbY
         oMA+LW6t1EKSsrGyGa0ZDn7uP1gwjX2YhMQaM72t9sQZKwMSEJUK+F/mUSE9Ohrgo1RX
         MLLLSSMhUSinbsbKQXGqfZbl47S17zp6SRxGfzWLlCgMTmGFx0J0NgYKZkIg4xY5gUKP
         BMJ8GlJjQbdNvT47/8vt8su1JL7hX4l6kwKmOyP3ukJ2uvEcoCpReXtl65whcrnNIfJC
         o4yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=FLdcQvbATlWGb3q817mpG8Q2+i83wVtJgcYRlPT/aYA=;
        b=pr7O3aXAXX31DhTTk9vgB8jURvPDyrKSsus3lqPdDTXV3IpypxJwv2mb/SteLzjmln
         GPlVVavYc7p+Y4bXzJ8HOb0M+hzgaeyY/hy5ezHjvTAlWFGLD1ALBIrvo46CyRfSxbge
         7GwGZnIzQnM1kG7qkqS890FeVZZNU59aWXYrUOrZDs8wRAQ2UIgkSMjTfx6ddGbIrLsc
         CiM3viRAjTdzH2sRfcxiSFpaTxjH/IxdCJV3P7Wxd3J+0e0cdIea6nQWwoS7auGTrL6I
         Yi6HMGwrweBEf7w5Y2fJDQOvBMjXdmxmcuP6Uvegq+wEoh4tqFRuwWw90lTG8Z7bqMNT
         wrnA==
X-Gm-Message-State: AOAM530mscIxDRClgioemFYxVp5cGF3HTxP3wFrjfZZqJyZjTNO/6KDR
        Yfy4jpXbIW8xDp1DT2+Sc0zqDfBra9vSx+DobcllZ1CE
X-Google-Smtp-Source: ABdhPJyq/4g3KQAaBVdfNc0KW3zPHW6jMQfkzkI3GT9z3e9QQtB1VZF/tyIWmTA6KAcAXRaLsiGJobKiUb3oS4ihQ2I=
X-Received: by 2002:a17:906:f752:: with SMTP id jp18mr24112364ejb.538.1595925513290;
 Tue, 28 Jul 2020 01:38:33 -0700 (PDT)
MIME-Version: 1.0
From:   Anubhav Guleria <anubhav.nitsri.it@gmail.com>
Date:   Tue, 28 Jul 2020 14:08:22 +0530
Message-ID: <CAFsMY+jqLe7VTwkZjpjdkGem1=waQPMUZ=n8nw5JGRct06_hsg@mail.gmail.com>
Subject: Issues with i40iw
To:     linux-rdma@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Hi,
Both of my servers are running with kernel 4.14.178 and have Intel
Ethernet Network Adapter X722. Also the IOMMU is disabled. I was
trying to run qperf and ran into couple of issues:

1) While running any bw test, eg. rc_bw or rc_bi_bw, I see following
messages in dmesg:
i40iw_cqp_ce_handler: opcode = 0x1 maj_err_code = 0xffff min_err_code = 0x8007
i40iw_wait_event: error cqp command 0xb completion maj = 0xffff min=0x8007

2) Following rc benchmarks fail: rc_rdma_write_bw, rc_rdma_write_lat,
rc_compare_swap_mr, rc_fetch_add_mr, ver_rc_compare_swap and
ver_rc_fetch_add. For these I get error of failed to post "benchmark
name"

Am I missing something here? Any suggestions?

Thanks,
Anubhav
