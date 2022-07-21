Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8C7657D768
	for <lists+linux-rdma@lfdr.de>; Fri, 22 Jul 2022 01:40:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229539AbiGUXj7 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 21 Jul 2022 19:39:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229508AbiGUXj6 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 21 Jul 2022 19:39:58 -0400
Received: from mail-oa1-x2f.google.com (mail-oa1-x2f.google.com [IPv6:2001:4860:4864:20::2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3102F8EED7
        for <linux-rdma@vger.kernel.org>; Thu, 21 Jul 2022 16:39:58 -0700 (PDT)
Received: by mail-oa1-x2f.google.com with SMTP id 586e51a60fabf-10d9213b77aso4535859fac.5
        for <linux-rdma@vger.kernel.org>; Thu, 21 Jul 2022 16:39:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:in-reply-to:content-transfer-encoding;
        bh=VcejTIQ2Du/xEk/P1PD4DFUpDPF6YVRRu1scEWrqFlE=;
        b=Dn6FL9K0bzT/wvnK57TdXAiwcW2cw1M4num7a3VteQKUL+jak94RbpVZdufHTLEfuh
         NCrO7snjygw7dXuci5Vem6bg7QtzuWtRJtxq+zsx/HB6hkdnTOlm9D77FuxmcCBwaHGP
         raENUq4IMTYQiNROgCNHVBAIKNnHZnCqIDBzNUrzbIqH2pRyxWLN92r2NqGhP01rihAU
         eojMHJ5PvXnE5rqPWYGLfakPv4vgJOAAIs14Nl0PIIiWAhNgzw2wYfME90p9Bawy18x1
         QpueAGkm9COtTFv1autiNze6xAtMGOYVZn3MNpge8pWjOJDg4od2JGtVtWXNGItSFtV3
         3BNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=VcejTIQ2Du/xEk/P1PD4DFUpDPF6YVRRu1scEWrqFlE=;
        b=hblSrqnQG5rHne+t7X+NNFou9pIixNqM+YJr7h5eqL/Np4YQJoFt1dXu0FKA+bGTMl
         xn4Lx/KqmgLvcNd3XO3lGphbgxe3cHHc4G7239QpgeG3J7Wi8jeblc1c6eBKQjyQDMr+
         lVbszxyLhjMl8srbbi1uyzwDQdJYQKGWNhrwDEh+/OS/paDu4H7oMCiFy0TV1sBmqjRA
         fvNq8MRil4khFSzSXgjb4bkhHB8A42R33InUY4PharHpXTw7uzfENpeu28IFiE0l309b
         Tw+Ql5KVAluRiqAwdzS2AhJ118z2LFdX3djqTspqIo5wNQcFhZEQ/+FMEiDn5M5TjEAL
         jT6g==
X-Gm-Message-State: AJIora/0GOXxU2ucT9ce1BXv3tR6gUFdPJ2go5JOoqWWaP9ALgGc+4UG
        ZPMNHlpUSZZ3+tedaod/Ei4=
X-Google-Smtp-Source: AGRyM1t4t9PlPRKEwGwB0+2R9sIyDk8S9nVPfk1vyRYZbvoHDxlMdIzgRNLMoEkpSWjJQdwqYyIcAQ==
X-Received: by 2002:a05:6870:6086:b0:10b:8905:14c3 with SMTP id t6-20020a056870608600b0010b890514c3mr6311708oae.255.1658446797601;
        Thu, 21 Jul 2022 16:39:57 -0700 (PDT)
Received: from ?IPV6:2603:8081:140c:1a00:26e5:db00:e7ca:8ba1? (2603-8081-140c-1a00-26e5-db00-e7ca-8ba1.res6.spectrum.com. [2603:8081:140c:1a00:26e5:db00:e7ca:8ba1])
        by smtp.gmail.com with ESMTPSA id o31-20020a056870911f00b0010c7487aa73sm1466962oae.50.2022.07.21.16.39.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Jul 2022 16:39:56 -0700 (PDT)
Message-ID: <fcb17805-59f8-ec28-f386-92600bc692ab@gmail.com>
Date:   Thu, 21 Jul 2022 18:39:55 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH RFC] RDMA/rxe: Allow re-registration of FMRs
Content-Language: en-US
To:     lizhijian@fujitsu.com, jgg@nvidia.com, zyjzyj2000@gmail.com,
        linux-rdma@vger.kernel.org, haris.iqbal@ionos.com
References: <20220721233453.57693-1-rpearsonhpe@gmail.com>
From:   Bob Pearson <rpearsonhpe@gmail.com>
In-Reply-To: <20220721233453.57693-1-rpearsonhpe@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 7/21/22 18:34, Bob Pearson wrote:
> This patch allows the rxe driver to re-register an FMR
> with or without remapping the mr. It adds
> a state variable that shows if the mr has been remapped
> and then only swaps the map sets if the mr has been
> remapped.
> 

This is an alternative that does not require getting rid of dual map sets.
The current code assumes that map_mr_sg is always called between calls to reg_mr and invalidate_mr.
This implements a state machine that marks the mr when it has been remapped and only in that case
swaps the map sets. Otherwise it could never perform the sequence you want for rtrs.

Bob
