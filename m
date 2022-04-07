Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3E6E4F8764
	for <lists+linux-rdma@lfdr.de>; Thu,  7 Apr 2022 20:51:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235968AbiDGSxn (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 7 Apr 2022 14:53:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233488AbiDGSxl (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 7 Apr 2022 14:53:41 -0400
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87E8D163E1E
        for <linux-rdma@vger.kernel.org>; Thu,  7 Apr 2022 11:51:39 -0700 (PDT)
Received: by mail-pj1-f45.google.com with SMTP id bx5so6416350pjb.3
        for <linux-rdma@vger.kernel.org>; Thu, 07 Apr 2022 11:51:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:cc:from:in-reply-to
         :content-transfer-encoding;
        bh=39uweEjtbnuaHQID712Wcljtid0WvHpHT/Z9/YAMuWI=;
        b=T7FE7qrn6X3QTx+ouErg37NUYWS+B+5OE9CDHr77pG7drbrTC39mEM/2w5KQW/Jwnc
         +uhj0ELbUiLIsrquei1eCe+TkMrN4BIceU8wUEy+JRmg+z3BR3YkIJwjeLVrcPcMTXfH
         qs5+pnynivLPlKFoRELhae5ywJQmJcHGkq1nX58e5HSAhLLrrrHHUEGHUR494QNA6MxM
         LZ0oD/scFFXvg/woV/r2tM86SEnaH8ZPc+FH0Vipc2A/0LDDDUcuXkEc82A9MtSxKdyo
         mMVrLxIdkW8ZUK4CdDUI88t4jscX5WLL9NNgKu9RB7+E53tRclwcI3+IQkYwVdQ71ePm
         1WjQ==
X-Gm-Message-State: AOAM530kVefQi8XWoBipB79OCYjQBdaiHKsDoYZrCSZsFeHSu1WH2Ye4
        CHklztE+aTou4UKlfcPZLU8=
X-Google-Smtp-Source: ABdhPJzs8zO32lYyI1dGfWP6O5Gjl2y/5xeGEHxOcjrf5v8/43EhB+1cXQ6Gsd5lk2o9Ctadxp0U2Q==
X-Received: by 2002:a17:90b:4c8e:b0:1c6:d1ed:f6b2 with SMTP id my14-20020a17090b4c8e00b001c6d1edf6b2mr17229077pjb.166.1649357498742;
        Thu, 07 Apr 2022 11:51:38 -0700 (PDT)
Received: from ?IPV6:2601:647:4000:d7:feaa:14ff:fe9d:6dbd? ([2601:647:4000:d7:feaa:14ff:fe9d:6dbd])
        by smtp.gmail.com with ESMTPSA id mn18-20020a17090b189200b001cac1781bb4sm9756179pjb.35.2022.04.07.11.51.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Apr 2022 11:51:38 -0700 (PDT)
Message-ID: <1c16f053-0183-8343-9b36-62027c7260a8@acm.org>
Date:   Thu, 7 Apr 2022 11:51:36 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [bug report] rdma_rxe: WARNING: inconsistent lock state,
 inconsistent {SOFTIRQ-ON-W} -> {IN-SOFTIRQ-W} usage
Content-Language: en-US
To:     Bob Pearson <rpearsonhpe@gmail.com>
References: <CAHj4cs-MT13RiEsWXUAcX_H5jEtjsebuZgSeUcfptNVuELgjYQ@mail.gmail.com>
Cc:     RDMA mailing list <linux-rdma@vger.kernel.org>,
        Yi Zhang <yi.zhang@redhat.com>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <CAHj4cs-MT13RiEsWXUAcX_H5jEtjsebuZgSeUcfptNVuELgjYQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 4/5/22 20:08, Yi Zhang wrote:
> [  296.616660] ================================
> [  296.620931] WARNING: inconsistent lock state
> [  296.625207] 5.18.0-rc1 #1 Tainted: G S        I
> [  296.630259] --------------------------------
> [  296.634531] inconsistent {SOFTIRQ-ON-W} -> {IN-SOFTIRQ-W} usage.
> [  296.640535] ksoftirqd/30/188 [HC0[0]:SC1[1]:HE0:SE0] takes:
> [  296.646106] ffff888151491468 (&xa->xa_lock#15){+.?.}-{2:2}, at:
> rxe_pool_get_index+0x72/0x1d0 [rdma_rxe]

Hi Bob,

Do you agree that the root cause of this issue is in the rdma_rxe driver?

Thanks,

Bart.
