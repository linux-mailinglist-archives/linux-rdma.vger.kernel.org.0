Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1262C4B758E
	for <lists+linux-rdma@lfdr.de>; Tue, 15 Feb 2022 21:48:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236830AbiBOS2Z (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 15 Feb 2022 13:28:25 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:45286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229714AbiBOS2Y (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 15 Feb 2022 13:28:24 -0500
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF8BCE01A
        for <linux-rdma@vger.kernel.org>; Tue, 15 Feb 2022 10:28:14 -0800 (PST)
Received: by mail-pj1-f42.google.com with SMTP id b8so6188823pjb.4
        for <linux-rdma@vger.kernel.org>; Tue, 15 Feb 2022 10:28:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1wwYxDBS+uSZ5iBkEPzzL/S2flJEJaDhyRr6GnCsooY=;
        b=ePlYEbQ8G6VH9Bfiw1bay2jj7tpDymCgID8lIIbR72GdOZ//jQ3OYlwqXufc8WfrXv
         76tBJRoMLTYP9K5ya3U06OER97YGtsHjaUhKoXZ3XfTWG8qVpdK2mCmxyW+6A8fEiN+M
         3mx4w/kAr7zhnjC6PRSpSxFFahUMIyfy4VzeD1HPPZHEW140JWIf5XAfzsaXg+9GT7ga
         IcloAHXAeyPfW0kl/CrWTHCpoHcBkDRGqCAStGZqjWb4TWgFAUeaPZUdNVxvyGpa0Q90
         jHN+hZ3hsgs7fTlF2rX6O0HWlLniZojTHqvMTzN2yE2QpjE7kZ/y6g4J8gw25/a2M8FN
         FqIQ==
X-Gm-Message-State: AOAM530XSVGRJOHruIeOXbC8UiVrbdkYbZyOdGDkkUFd6d5F3SPQQ0ph
        FoXcV2Lgfqx1TlV7MS3zhB72S7hdzgSj3g==
X-Google-Smtp-Source: ABdhPJxX3kilpPC57gidmWHtJyQArWflzLBpq7mN3c5Ri60NLtTt5izZgz1VBONq10NVDPoEOUv3Vw==
X-Received: by 2002:a17:90b:1803:: with SMTP id lw3mr119165pjb.117.1644949694154;
        Tue, 15 Feb 2022 10:28:14 -0800 (PST)
Received: from asus.hsd1.ca.comcast.net ([2601:647:4000:d7:feaa:14ff:fe9d:6dbd])
        by smtp.gmail.com with ESMTPSA id k13sm43896746pfc.176.2022.02.15.10.28.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Feb 2022 10:28:13 -0800 (PST)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Leon Romanovsky <leonro@mellanox.com>, linux-rdma@vger.kernel.org,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH 0/3] Fix a deadlock in the ib_srp driver
Date:   Tue, 15 Feb 2022 10:26:47 -0800
Message-Id: <20220215182650.19839-1-bvanassche@acm.org>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Hi Jason,

This patch series fixes a deadlock in the ib_srp driver that was discovered
by syzbot. Please consider these patches for kernel v5.18.

Thanks,

Bart.

Bart Van Assche (3):
  ib_srp: Add more documentation
  ib_srp: Protect the target list with a mutex instead of a spinlock
  ib_srp: Fix a deadlock

 drivers/infiniband/ulp/srp/ib_srp.c | 24 +++++++++++-------------
 drivers/infiniband/ulp/srp/ib_srp.h | 13 +++++++++++--
 2 files changed, 22 insertions(+), 15 deletions(-)

