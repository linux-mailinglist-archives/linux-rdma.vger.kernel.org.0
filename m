Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A35429FD70
	for <lists+linux-rdma@lfdr.de>; Fri, 30 Oct 2020 06:51:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725825AbgJ3FvE (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 30 Oct 2020 01:51:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725773AbgJ3FvD (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 30 Oct 2020 01:51:03 -0400
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com [IPv6:2607:f8b0:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5851EC0613D3
        for <linux-rdma@vger.kernel.org>; Thu, 29 Oct 2020 22:41:14 -0700 (PDT)
Received: by mail-ot1-x335.google.com with SMTP id f97so4610004otb.7
        for <linux-rdma@vger.kernel.org>; Thu, 29 Oct 2020 22:41:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:from:cc:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=HxHLJWXOKNlmJZ+T92UNlf7JoSJGfmAjsmDo72ghODA=;
        b=sH8BmIqZ32ALh3ixsKdz/F59OurJ67oL2AZqMYvQIuQbpN/l/jyBA2Y5QNQzX1V7YW
         IysYGukwBanZNKk+DyDTsyJacxKXTOnUlj7+6Ck97lX3CYe8gFIiwkDfS97Q/ji/J8jq
         cnZ6blW/mItqE37N1M7kNPl1vt4uPjjNzRHxDKgMpHCowQ6KIMsaF1TYjlls9CHGnuCn
         8rMbBonQlawGEZ7lY6sb6SAcci1fAQFLTKHIYfNpo5PwRgrS+CCeEneWdJfsgepPcUF+
         lOUL7QePuYJdH/OvMVQDHGPLLccPVGZAMiqbmIRabk3Qk7o6V0U0U6m6qrkbVBXyOxkW
         Q4Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:from:cc:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=HxHLJWXOKNlmJZ+T92UNlf7JoSJGfmAjsmDo72ghODA=;
        b=eTkAF/98otu5/sbXdIXMbkmmnwg0GUmgfyzEojjNr6AX1ijEtyF+j5Ot9kbY+0ausn
         3e6kygJOW2NlhUY8P1uI9IW1Mk1uQ6hPwMq3GhpW7BGeKCusfFYI5f3GGZFbEBjJgroV
         zD7o2Xe/G7hQg6jdpVpOz8TIK53mqAzxuOrII5rkoMw9nQiKYcpI249hslx3rQyQzNWd
         +DyXynZgwsHHDGJsv4yWNIJK6gXT4nSMOc3LKzcktLwH3AtZ+9Vf6Ov/IRyfr8luRyMo
         uw5gciiqDDXrh7FI+IGIUj3WS1xrsBeXlC0xRSWB6yVcNso9ECa1w2T5IpbFPMVPji26
         ApFQ==
X-Gm-Message-State: AOAM5332N/jGD7s5SrksGLSWPnZwQWdY3m0w8SaBs7YfYM264vry4gq3
        VknDWYxJlRCuntdgXPp/9ILBneChwec=
X-Google-Smtp-Source: ABdhPJxzIy9zZBabgMqS22fwL8cyJMeFADiCe3kwuxyPJ4vci6bvh7v3JL4iuydG0App4btvPq+g2A==
X-Received: by 2002:a9d:4504:: with SMTP id w4mr453395ote.36.1604036473683;
        Thu, 29 Oct 2020 22:41:13 -0700 (PDT)
Received: from ?IPv6:2603:8081:140c:1a00:b6dc:62b4:e209:78d4? (2603-8081-140c-1a00-b6dc-62b4-e209-78d4.res6.spectrum.com. [2603:8081:140c:1a00:b6dc:62b4:e209:78d4])
        by smtp.gmail.com with ESMTPSA id 8sm1215805oii.45.2020.10.29.22.41.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Oct 2020 22:41:13 -0700 (PDT)
To:     Jason Gunthorpe <jgg@nvidia.com>
From:   Bob Pearson <rpearsonhpe@gmail.com>
Cc:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: another change breaks rxe
Message-ID: <32fa9c9f-5816-7474-b821-ccccd4cb5af0@gmail.com>
Date:   Fri, 30 Oct 2020 00:41:12 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.2
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Jason,

commit 628c02bf38aa42c09c3dde61284ba348290e6650
Author: Jason Gunthorpe <jgg@ziepe.ca>
Date:   Sat Oct 3 20:20:10 2020 -0300

    RDMA: Remove uverbs cmds from drivers that don't use them
    
    Allowing userspace to invoke these commands is probably going to crash
    these drivers as they are not tested and not expecting to use them on a
    user object.
    
    For example pvrdma touches cq->ring_state which is not initialized for
    user QPs.
    
    These commands are effected:
    
    - IB_USER_VERBS_CMD_REQ_NOTIFY_CQ is ibv_cmd_req_notify_cq() in
      rdma-core, only hfi1, ipath and rxe calls it.
    
    - IB_USER_VERBS_CMD_POLL_CQ is ibv_cmd_poll_cq() in rdma-core, only
      ipath and hfi1 calls it.
    
    - IB_USER_VERBS_CMD_POST_SEND/RECV is ibv_cmd_post_send/recv() in
      rdma-core, only ipath and hfi1 call them.

breaks rxe because it does use IB_USER_VERBS_CMD_POST_SEND. rxe posts wqes to a work queue in shared memory and then calls ibv_post_send with zero wqes as a doorbell to the kernel which uses this as a hint to go read the shared memory.

Bob
