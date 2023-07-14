Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 137EF753E8A
	for <lists+linux-rdma@lfdr.de>; Fri, 14 Jul 2023 17:13:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234930AbjGNPNM (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 14 Jul 2023 11:13:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236397AbjGNPNI (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 14 Jul 2023 11:13:08 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93E9E2702
        for <linux-rdma@vger.kernel.org>; Fri, 14 Jul 2023 08:13:07 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id 4fb4d7f45d1cf-51e526e0fe4so2640998a12.3
        for <linux-rdma@vger.kernel.org>; Fri, 14 Jul 2023 08:13:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689347586; x=1691939586;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=OB+se4X5g+cm9grWjqeI/FoERpPSEWo2zqNVQMFpBxs=;
        b=W+SKhPon0cLN6Y2U9+8IqYFwa21mEEzY05rYhQCIErN/U/76x9QwQbcMtqI3cIWVui
         0fvSvhsCyIjsvmPGb8ECFvIZRWfoJJEIJdOO3489D6JtF/pWObIjLoSnNK7Wfyc4tFPK
         52Dlo7L3rdI9ntIz4CgocULsClij1mBTQbQHIqfSRAtaE88pFkK4QXm8jTONJN8FU0Ix
         np6xesHsNwpVbtpvR3whnBFmhHKExyr5UncdlXzyN0W++move3FqkpJlKMBEJ3YQskvG
         j2N3eT6eD9bFpfbu668IZnF+Um+A7ROHa6u2QeC4aX+9DLdeUr4+8E2aM55VkTHyOHXl
         ADGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689347586; x=1691939586;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OB+se4X5g+cm9grWjqeI/FoERpPSEWo2zqNVQMFpBxs=;
        b=McY3l8iFX7+yjXszjlrzI3HerEACL6mhv8FOBGDOTZlatPOS4aUHcjwfSGBAJVkJHh
         fzqZOeClIw7UoouuOF8zubYpMbQkVne5FS4pKa4TJNmt/nkC/qTawz3FGYDQrTKYnIcU
         ZpczimVh9p8uQype02e1mgGEaVO8YpuL4ZAsx9XkFg6J3nb7zIBIUbPHkxC768nIIzA1
         gN2o4sKoX7mD2ZNK3+X2sCH1VRsWwzpDRKZj/kHnLVV5J2C7Hvhhm4mYlQBGVcMWqRnA
         jIEWhuRvspzlDKhwwLxuo8tNl4ohnRd6qg4Y3QjJHv7mrT4Urxjo3EwCNFdF6hax3bzT
         mK0g==
X-Gm-Message-State: ABy/qLYzSNFlBlneIBdGU0hE1oDNArLZl/6NHj+0QTacMaNigOT9ciXb
        ChTs+m8B5PaSyOvkyjDmzo+rTSHgIJQWrubShXYs1bFU9NQ=
X-Google-Smtp-Source: APBJJlHH/L4MwUXqhjZ3acZTGFx0a9aUkWfAJ8MxWbOZLTOj5szLvL9FEkbhH7wlE5O5mp7bdJ1S//Hi2+2OQHPb8k0=
X-Received: by 2002:aa7:d499:0:b0:51e:472a:4fc with SMTP id
 b25-20020aa7d499000000b0051e472a04fcmr3678650edr.42.1689347585568; Fri, 14
 Jul 2023 08:13:05 -0700 (PDT)
MIME-Version: 1.0
From:   Arka Sharma <arka.sw1988@gmail.com>
Date:   Fri, 14 Jul 2023 20:42:54 +0530
Message-ID: <CAPO=kN3kRV1wGvkJazRWtt1LA-QtOP2Ja3C+GtLxgMJXoxeSJw@mail.gmail.com>
Subject: Check if an MR is deregistered
To:     linux-rdma@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Hi All,

I am having two dual port mlx_5 and I am on Ubuntu 22.04. My use case
is as follows
1. I allocated a large buffer using posix_memalign and registered it.
2. From the registered buffer I carved out smaller buffers and used
them for usual RDMA communication over RC QP.
3. I have 4 cq, each corresponding to 2x2 RNIC interfaces. And these
cq's can be shared across 1,2,3,4 QPs.
4. The communication works fine but when I run some load, I observe
IBV_WC_LOC_PROT_ERR after some time while processing a cq entry
corresponding to a receive WR. The size of the cq I sent to
ibv_create_cq is 1024 but I checked the cqe field, it is 2047.
I checked the buffers and the lkeys and found no discrepancies there
so I doubt if by any chance the MRs got deregistered in the RNIC.
Normally I deregister the MR and free the buffer while tearing down
the entire connection, but I was wondering is there any way to find if
the MR is valid through some IB API ? I can get the affected process
in gdb and if any data item need to be looked at in userland I could
do that.

Regards,
Arka
