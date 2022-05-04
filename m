Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A06DF51AC8B
	for <lists+linux-rdma@lfdr.de>; Wed,  4 May 2022 20:14:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376860AbiEDSS1 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 4 May 2022 14:18:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376834AbiEDSSV (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 4 May 2022 14:18:21 -0400
Received: from mail-oa1-x35.google.com (mail-oa1-x35.google.com [IPv6:2001:4860:4864:20::35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82F698A7C9
        for <linux-rdma@vger.kernel.org>; Wed,  4 May 2022 10:38:53 -0700 (PDT)
Received: by mail-oa1-x35.google.com with SMTP id 586e51a60fabf-e93bbb54f9so1879620fac.12
        for <linux-rdma@vger.kernel.org>; Wed, 04 May 2022 10:38:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:content-language:to:from
         :subject:content-transfer-encoding;
        bh=DGzZSw/awxeuepH+l94VTGTJCKR5bVfYV3OiIM0dxA0=;
        b=Iehn+izQ5P3JZgmPoMQEUsLPINO6YPfnXDrNbUSwonWsF7xzQ5zNRYuAIbwvjPwCwT
         hnkT74q1C/t6xp7AI+t+vM6T/Z/b8uOdSUyyj/gzHAyeYNzNSLbeLD7J9D5xUbVEQn6E
         dcNJIPkSrSMkPTx7fHgetArLuKSMsnCVg5sYRCzO8MtNYl2iK8tbLk6mJ7Ei5DOR20qI
         tFcbVJ1SnzGKVMb/azQvTzPV7XOWDLJhg5WjY9nL5xwio/zFhnC17lGI2Zefjizyf8HK
         FZeD2mNTIFyR4wQfgaixz4F5NmK439nSsyy5OJhaYhcVPfBsZ6Ff7K/Zg4BchycXK5K4
         0B1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent
         :content-language:to:from:subject:content-transfer-encoding;
        bh=DGzZSw/awxeuepH+l94VTGTJCKR5bVfYV3OiIM0dxA0=;
        b=dzlL7ZwuPv/9rY3RrB0k7i0hZcK8oH/rtbYlgQtmhAQSfyWccyM5IrG6XKD4QhwSMV
         IEsA3GApBKhZBSv7DVTD6VT5g6P61WLhlHUSebxm0HaYsgmaWTZ1aXtX+iSLBlVRR4YM
         UejmMafMr2baZPcMfz5kJxSiipnhps349wEG3twKE4Zo5hAB943DlTCwM9H+yVx4fM3L
         DtHzp0XT+8CVaLC1UeNMiZEdCogeFUB/kV4xQQCaHV4/R3hFOa2sZIYT3CSgMWYdevgJ
         c91cMElxHJ+cSWv8YskKu+mLqsSBGIOeBJNqSz5uUbW41/a1CQzsZImkVAsQdiBEgnbj
         GRXA==
X-Gm-Message-State: AOAM533iYG/b0br75mZP4LdoBQR5/HotIh1a/HLF+GeMDErXeAe0mAQ7
        aDVH+7hjTy+jJ//yvLnp3bLkdq8euZU=
X-Google-Smtp-Source: ABdhPJyLhKvipdPQYF3lg1Xko34cPO9oBkqKkk+G+NIydel1/KTrTljeKWt7QK6AosrxqjQ3cx3L3g==
X-Received: by 2002:a05:6870:6006:b0:e5:e6f1:5f2a with SMTP id t6-20020a056870600600b000e5e6f15f2amr316685oaa.160.1651685932846;
        Wed, 04 May 2022 10:38:52 -0700 (PDT)
Received: from ?IPV6:2603:8081:140c:1a00:1840:1391:d605:ccf5? (2603-8081-140c-1a00-1840-1391-d605-ccf5.res6.spectrum.com. [2603:8081:140c:1a00:1840:1391:d605:ccf5])
        by smtp.gmail.com with ESMTPSA id l25-20020a9d7359000000b006062836c4f4sm2848528otk.71.2022.05.04.10.38.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 May 2022 10:38:52 -0700 (PDT)
Message-ID: <b2174369-07e5-1e0c-3c09-ac92cff9949d@gmail.com>
Date:   Wed, 4 May 2022 12:38:51 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Content-Language: en-US
To:     Zhu Yanjun <zyjzyj2000@gmail.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Jason Gunthorpe <jgg@nvidia.com>
From:   Bob Pearson <rpearsonhpe@gmail.com>
Subject: Suspicious code in rxe requester and completer tasklets
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

I am continuing to chase some bugs seen here at HPE which were centered on spurious retries.
In the course of this I have been looking carefully at data sharing between the request side
tasklets (requester and completer) and have noticed the following.

Under light load the two tasklets call/schedule each other so tend to run on the same cpu
most of the time. Under heavy load the completer tasklet can get scheduled from the NAPI thread
and run multiple cycles while the requester tasklet gets scheduled from the post send verbs API
and can also run multiple cycles thus you can see two different cpus remaining active. So
basically we can make no assumption about the relative timing of shared data accesses between
the two tasklets and any other threads that also access shared data.

The code is written as though protection was an afterthought. There are a few cases where
atomic_t are used and in one case a lock is added but in other cases no effort is made to
protect shared data accesses. A good example is in complete_ack() in rxe_comp.c which has

        if (wqe->has_rd_atomic) {

                wqe->has_rd_atomic = 0;

                atomic_inc(&qp->req.rd_atomic);

                if (qp->req.need_rd_atomic) {

                        qp->comp.timeout_retry = 0;

                        qp->req.need_rd_atomic = 0;

                        rxe_run_task(&qp->req.task, 0);

                }

        }


and check_init_depth() in rxe_req.c

static inline int check_init_depth(struct rxe_qp *qp, struct rxe_send_wqe *wqe)

{

        int depth;



        if (wqe->has_rd_atomic)

                return 0;



        qp->req.need_rd_atomic = 1;

        depth = atomic_dec_return(&qp->req.rd_atomic);



        if (depth >= 0) {

                qp->req.need_rd_atomic = 0;

                wqe->has_rd_atomic = 1;

                return 0;

        }



        atomic_inc(&qp->req.rd_atomic);

        return -EAGAIN;

}


It makes my head hurt trying to figure out all the combinations in this mess. Both of
these can run multiple times as well with retries with arbitrary relative timing.

This code may be perfect but it feels quite unsafe to me.

Bob 
