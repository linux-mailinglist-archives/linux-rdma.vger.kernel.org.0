Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFB877D1314
	for <lists+linux-rdma@lfdr.de>; Fri, 20 Oct 2023 17:45:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377663AbjJTPpb (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 20 Oct 2023 11:45:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377691AbjJTPpb (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 20 Oct 2023 11:45:31 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D9E7AB
        for <linux-rdma@vger.kernel.org>; Fri, 20 Oct 2023 08:45:25 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id 5b1f17b1804b1-40651a726acso7954125e9.1
        for <linux-rdma@vger.kernel.org>; Fri, 20 Oct 2023 08:45:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1697816724; x=1698421524; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hCC4GbCl1igM+d+1yQcvX15F/ZhBXwUvkevjs8cUpCs=;
        b=e3idob4UKgtDOYf/21lvePd3Ula0M0pvS1UQlne+VbpizQDSwJzE/zx2M43U4QRDOj
         JnOPTDnAgCpusUNu/bQeUMPAQEnzoQ2XGM/ZsSEDiz/8wWnUPcxNnsqQNwg8GmJO7MjY
         yJAZPoDXrWLlYe+/BsYHkIZka+F/cPAIwCXIniTzSt23CPZl18zU9HpOylwnYhrudnmC
         eC6Xp30Yl5yoGyBxVRE9YjpR3lAq5LtCRGZhLNNzM6ZjBfS2LGAKHNjW7dTZDldRwCTa
         ECueKNRsICw4foQL+RyKDKdYshgqv9tElYypE8qP+duLG6twK+qim/wX+CWoflcCtUM+
         3yGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697816724; x=1698421524;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hCC4GbCl1igM+d+1yQcvX15F/ZhBXwUvkevjs8cUpCs=;
        b=gef06Lqx+NNoRSS0R31yoS1eUpIroeaXqeKzy6+bqwB+LPcbuE2JCu+hwYVvYho6iO
         45DUqGnMFdc1NwWAiLEa6c4VAWL/TM1XK/mqb3O6e72LfBSrtt+rDFJzwKFfM/rfkYmP
         4Qn7wEQ5Muegb+EhtELe7YfGXATc+mbMMbT7AXU9ZvY/LmB2YcBrg8snvHLIevP9nS53
         CFgrsErn/JDOxAkixctzzmFghB7kZRBVM2Te4UMyGqwTthszDlZDw8pQZnRJ9qHjiOqK
         nyW4HMEDN6dFt7w+Ntu3KKf5FrCL+UCMLXQWzt8Pp7j3GsDyWyya3afSIMIO10zFKwqq
         nSaA==
X-Gm-Message-State: AOJu0Yz+Q5vNkQMp2lr/HRHgfpRwTjJpbdTj/10/MnZu7VBk/kdUyt9Z
        WwVZ1R7c1LmEToaCD7+2oPu8zg==
X-Google-Smtp-Source: AGHT+IE5Dk7tHupJCNqhQPosvWL+Kp+QeIyVILKjUhGDomRWGklFxVWsTubLvJakqAKq7hsrUaqj3A==
X-Received: by 2002:adf:f8d1:0:b0:32d:aa11:2219 with SMTP id f17-20020adff8d1000000b0032daa112219mr1575321wrq.1.1697816723800;
        Fri, 20 Oct 2023 08:45:23 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id w15-20020a5d608f000000b0032dbf32bd56sm1927380wrt.37.2023.10.20.08.45.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Oct 2023 08:45:23 -0700 (PDT)
Date:   Fri, 20 Oct 2023 18:45:19 +0300
From:   Dan Carpenter <dan.carpenter@linaro.org>
To:     hariprasad@chelsio.com, Ganesh Goudar <ganeshgr@chelsio.com>
Cc:     linux-rdma@vger.kernel.org
Subject: [bug report] RDMA/iw_cxgb4: Low resource fixes for Completion queue
Message-ID: <73451d77-8612-4e14-9695-ad455b84f673@moroto.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Hello,

The patch dd6b0241260d: "RDMA/iw_cxgb4: Low resource fixes for
Completion queue" from Jun 10, 2016 (linux-next), leads to the
following Smatch static checker warning:

	drivers/infiniband/hw/cxgb4/cq.c:1153 c4iw_create_cq()
	error: double free of 'chp->destroy_skb'

drivers/infiniband/hw/cxgb4/cq.c
    1138         pr_debug("cqid 0x%0x chp %p size %u memsize %zu, dma_addr %pad\n",
    1139                  chp->cq.cqid, chp, chp->cq.size, chp->cq.memsize,
    1140                  &chp->cq.dma_addr);
    1141         return 0;
    1142 err_free_mm2:
    1143         kfree(mm2);
    1144 err_free_mm:
    1145         kfree(mm);
    1146 err_remove_handle:
    1147         xa_erase_irq(&rhp->cqs, chp->cq.cqid);
    1148 err_destroy_cq:
    1149         destroy_cq(&chp->rhp->rdev, &chp->cq,
    1150                    ucontext ? &ucontext->uctx : &rhp->rdev.uctx,
    1151                    chp->destroy_skb, chp->wr_waitp);

destroy_cq() calls kfree_skb(chp->destroy_skb).  The call tree is:

destroy_cq()
-> c4iw_ref_send_wait()
   -> c4iw_ofld_send()
      -> kfree_skb()

    1152 err_free_skb:
--> 1153         kfree_skb(chp->destroy_skb);

Probably we can just delete this kfree_skb()?

    1154 err_free_wr_wait:
    1155         c4iw_put_wr_wait(chp->wr_waitp);
    1156 err_free_chp:
    1157         return ret;
    1158 }

regards,
dan carpenter
