Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9341370B704
	for <lists+linux-rdma@lfdr.de>; Mon, 22 May 2023 09:50:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232106AbjEVHug (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 22 May 2023 03:50:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232195AbjEVHuF (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 22 May 2023 03:50:05 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E6ACE6A
        for <linux-rdma@vger.kernel.org>; Mon, 22 May 2023 00:48:42 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id ffacd0b85a97d-3078d1c8828so5435880f8f.3
        for <linux-rdma@vger.kernel.org>; Mon, 22 May 2023 00:48:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684741657; x=1687333657;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LavY7NUAv8YJAmhCYOJU2qTjPqc9ETeO7blgXvCNSP8=;
        b=L4/yi9kJE0ratEYwO3Y2Oy0FC3+4Uo5Fhx/4wZJBMblFTwJGFxAAxBCurjzBecOlob
         RuHGzT3qB9NMEK5FEFv2FclRCyTAfN0AeGb8z6FJJ/KtZsJ65b6v1z0M5CpLUdOGuJHv
         DUP0ZiCs5l/aJpUyvt4Dt14ebCq8/4v0+b5qZ3UKqldSY3Dwe4Tm96tUXAO0KLAb2V6a
         nWU8TMC++v0VLL/fBnQbCZSaWUNNh2y2sj8d++kfkJT3+7sslvgnaoK2tZFDKvHndSyQ
         PM78bJQt/u9RWa+R7BVlvlCsSIRTt3628Yq5aoYVFe2waZBeaL/NwjxYK0Xy7yXgNWjC
         06vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684741657; x=1687333657;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LavY7NUAv8YJAmhCYOJU2qTjPqc9ETeO7blgXvCNSP8=;
        b=b6HqvGeWZbnPW0QoAz7Owla30x+/F5mz6zVJq50Rj/YWE3Xl+szb8bXoiQ/V7TfxwT
         ZKJMksrx3/iBNhCI7enCE8INeC6CL7cVpNWLaqKvqsuA1cbOYdOcjdZXMRCxqJivuZlZ
         6T3uNlvW8i3LqVBPLLXULFi0EX93JP6oWyaBAGe4giwHqM19607VAEmB/X1LbEwXx/gR
         ACjZF+30aX/HV5mS+mzp+RA8xghWZa/vcy4d97pYw8MD/iQAo3kNT8LYSk+aD7OgMYGr
         JwGEk4tU4OvbXptSAUN8rvi4LMgebtrrK0LBXAzTjxKuMYI16N8okg+fMKiY5ratsGKB
         fvNg==
X-Gm-Message-State: AC+VfDz2+IhmL8LB7g/yNkvVnKKy9/xhT3QhA0VZ+rVmlq/Y2Ns00w+6
        PmbSW/Brne577WrzWEYni0grQg==
X-Google-Smtp-Source: ACHHUZ6krnxouFIDAfXEC89C0Rd4Bx2e63TEAS4qxTiQqTfhnG3hKvYYqoz8GOI/o5ZxIibQbjyUXA==
X-Received: by 2002:a5d:5588:0:b0:2f5:aadb:4642 with SMTP id i8-20020a5d5588000000b002f5aadb4642mr6876111wrv.41.1684741656820;
        Mon, 22 May 2023 00:47:36 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id b15-20020a5d4b8f000000b00306344eaebfsm6847390wrt.28.2023.05.22.00.47.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 May 2023 00:47:35 -0700 (PDT)
Date:   Mon, 22 May 2023 10:47:32 +0300
From:   Dan Carpenter <dan.carpenter@linaro.org>
To:     aditr@vmware.com
Cc:     VMware PV-Drivers Reviewers <pv-drivers@vmware.com>,
        linux-rdma@vger.kernel.org
Subject: [bug report] IB: Add vmw_pvrdma driver
Message-ID: <07c48eee-0aca-48ee-897a-38588c341c41@kili.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Hello Adit Ranadive,

The patch 29c8d9eba550: "IB: Add vmw_pvrdma driver" from Oct 2, 2016,
leads to the following Smatch static checker warning:

	drivers/infiniband/hw/vmw_pvrdma/pvrdma_qp.c:712 pvrdma_post_send()
	warn: unsigned 'wr->opcode' is never less than zero.

drivers/infiniband/hw/vmw_pvrdma/pvrdma_qp.c
    671 int pvrdma_post_send(struct ib_qp *ibqp, const struct ib_send_wr *wr,
    672                      const struct ib_send_wr **bad_wr)
    673 {
    674         struct pvrdma_qp *qp = to_vqp(ibqp);
    675         struct pvrdma_dev *dev = to_vdev(ibqp->device);
    676         unsigned long flags;
    677         struct pvrdma_sq_wqe_hdr *wqe_hdr;
    678         struct pvrdma_sge *sge;
    679         int i, ret;
    680 
    681         /*
    682          * In states lower than RTS, we can fail immediately. In other states,
    683          * just post and let the device figure it out.
    684          */
    685         if (qp->state < IB_QPS_RTS) {
    686                 *bad_wr = wr;
    687                 return -EINVAL;
    688         }
    689 
    690         spin_lock_irqsave(&qp->sq.lock, flags);
    691 
    692         while (wr) {
    693                 unsigned int tail = 0;
    694 
    695                 if (unlikely(!pvrdma_idx_ring_has_space(
    696                                 qp->sq.ring, qp->sq.wqe_cnt, &tail))) {
    697                         dev_warn_ratelimited(&dev->pdev->dev,
    698                                              "send queue is full\n");
    699                         *bad_wr = wr;
    700                         ret = -ENOMEM;
    701                         goto out;
    702                 }
    703 
    704                 if (unlikely(wr->num_sge > qp->sq.max_sg || wr->num_sge < 0)) {
    705                         dev_warn_ratelimited(&dev->pdev->dev,
    706                                              "send SGE overflow\n");
    707                         *bad_wr = wr;
    708                         ret = -EINVAL;
    709                         goto out;
    710                 }
    711 
--> 712                 if (unlikely(wr->opcode < 0)) {
                                     ^^^^^^^^^^
wr->opcode is an enum and enum signedness is undefined in C but in this
context it's unsigned.  Just checking for negatives seems insufficient
here anyway.  Perhaps the check can be deleted?

    713                         dev_warn_ratelimited(&dev->pdev->dev,
    714                                              "invalid send opcode\n");
    715                         *bad_wr = wr;
    716                         ret = -EINVAL;
    717                         goto out;
    718                 }
    719 
    720                 /*
    721                  * Only support UD, RC.
    722                  * Need to check opcode table for thorough checking.
    723                  * opcode                _UD        _UC        _RC
    724                  * _SEND                x        x        x
    725                  * _SEND_WITH_IMM        x        x        x
    726                  * _RDMA_WRITE                        x        x
    727                  * _RDMA_WRITE_WITH_IMM                x        x
    728                  * _LOCAL_INV                        x        x
    729                  * _SEND_WITH_INV                x        x
    730                  * _RDMA_READ                                x
    731                  * _ATOMIC_CMP_AND_SWP                        x
    732                  * _ATOMIC_FETCH_AND_ADD                x
    733                  * _MASK_ATOMIC_CMP_AND_SWP                x
    734                  * _MASK_ATOMIC_FETCH_AND_ADD                x
    735                  * _REG_MR                                x
    736                  *
    737                  */
    738                 if (qp->ibqp.qp_type != IB_QPT_UD &&
    739                     qp->ibqp.qp_type != IB_QPT_RC &&
    740                         wr->opcode != IB_WR_SEND) {

regards,
dan carpenter
