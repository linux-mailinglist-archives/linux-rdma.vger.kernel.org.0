Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0AC654B799F
	for <lists+linux-rdma@lfdr.de>; Tue, 15 Feb 2022 22:49:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231495AbiBOVC1 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 15 Feb 2022 16:02:27 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:35046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235440AbiBOVC0 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 15 Feb 2022 16:02:26 -0500
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43FEF27FFE
        for <linux-rdma@vger.kernel.org>; Tue, 15 Feb 2022 13:02:16 -0800 (PST)
Received: by mail-pg1-f178.google.com with SMTP id f8so40924pgc.8
        for <linux-rdma@vger.kernel.org>; Tue, 15 Feb 2022 13:02:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=TPqT1dNtuYLUYTH0eq4rnMJ+JALOnqXCTyfY1Z3KqFU=;
        b=DL4CTNXavmrMOHgDDPiQxCx+8gjCipjR9KD/ErB4Feg3xNaziXlNxL4JWIdEWFAaQt
         2P8gF3vPrNPCVPYv6AVWAVkBUesBclOQeE0lqDC774ODuuG9ZkOp2ANBZdtLPHu70g+0
         stJNwQabpJJBWAEV/2//klT9gBEuMQk5tqqQRVurEszjjWmyqE/ISAqdDoWbAn2nR+Zb
         SFANVJ3bVoooVb3xWCR0OQnmqjyMOmHAzQa1x3EveQNOCKYstzRLJB6ptmn9da6MCTDs
         taOU8fWcsSnSff7Qlu6EgmSrrEFHU68+S/boYEqMLhWlytyt9JE3iOt1VnmiORR63t55
         NYhA==
X-Gm-Message-State: AOAM533sMviwlY82Aa35n5KhuVWlkh3x9RXl4JIDAdxwKpICjcitRYuo
        hjJN6Un4DKtYhcN523hb7cYUxm3SGkj7aQ==
X-Google-Smtp-Source: ABdhPJwl8+rAlgo6KqKDkDsAAwdPWG63GFMtXgj60p5Nm4v8KKoNn+vHg3uIVDFQw+0ny1BB4y+ZkQ==
X-Received: by 2002:a05:6a00:134b:: with SMTP id k11mr739087pfu.33.1644958935619;
        Tue, 15 Feb 2022 13:02:15 -0800 (PST)
Received: from ?IPV6:2601:647:4000:d7:feaa:14ff:fe9d:6dbd? ([2601:647:4000:d7:feaa:14ff:fe9d:6dbd])
        by smtp.gmail.com with ESMTPSA id d8sm43732319pfv.64.2022.02.15.13.02.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Feb 2022 13:02:14 -0800 (PST)
Message-ID: <54f5439d-07b2-b78a-91d0-25592c0dd861@acm.org>
Date:   Tue, 15 Feb 2022 13:02:13 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [PATCH for-next] RDMA/rxe: Revert changes from irqsave to bh
 locks
Content-Language: en-US
To:     Bob Pearson <rpearsonhpe@gmail.com>, linux-rdma@vger.kernel.org,
        jgg@nvidia.com, zyjzyj2000@gmail.com, guoqing.jiang@linux.dev
References: <20220215194448.44369-1-rpearsonhpe@gmail.com>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20220215194448.44369-1-rpearsonhpe@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 2/15/22 11:44, Bob Pearson wrote:
> A previous patch replaced all irqsave locks in rxe with bh locks.
> This ran into problems because rdmacm has a bad habit of
> calling rdma verbs APIs while disabling irqs. This is not allowed
> during spin_unlock_bh() causing programs that use rdmacm to fail.
> This patch reverts the changes to locks that had this problem or
> got dragged into the same mess. After this patch blktests/check -q srp
> now runs correctly.

Tested-by: Bart Van Assche <bvanassche@acm.org>
