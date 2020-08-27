Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0132A253BF9
	for <lists+linux-rdma@lfdr.de>; Thu, 27 Aug 2020 04:51:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726794AbgH0Cvn (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 26 Aug 2020 22:51:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726790AbgH0Cvn (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 26 Aug 2020 22:51:43 -0400
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com [IPv6:2607:f8b0:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05233C0612A3
        for <linux-rdma@vger.kernel.org>; Wed, 26 Aug 2020 19:51:43 -0700 (PDT)
Received: by mail-oi1-x234.google.com with SMTP id z22so3426921oid.1
        for <linux-rdma@vger.kernel.org>; Wed, 26 Aug 2020 19:51:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=m/djqVmrqxAtEEUgcInarY38xQ5SQWIIYsfkXM6vejs=;
        b=QR49c/LQ6HtMl29gNHSPMSI+Ro2Nc6RrJXsY86rPVf82tmNVk43h4S94YwWWwVqt5z
         qViQPinyNkbdlDu0Unx3jvFuZvKDzoqQXzy5djipEJdy2rCXfeuGHS0gidOjbdKDryIs
         x7kWJx6x0pGCUL/s0nWp9Sbt9gobBhUr4MzQwK5nfiBS11PG3OL9dq/tv99hhf8z4llc
         hGOo/7gE8ccMmdbfRpXOQxpPcQi4hkEVutDdbfNyusUyfrdgscMjGfpXN/LI5qxilPg8
         xqkP2Jpmx3arCLyWz7GNBJhaHN1qn2dOiKiBRD3Ybrd2FNRj5jSaA/w6aAVN43B9zeoo
         pZXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=m/djqVmrqxAtEEUgcInarY38xQ5SQWIIYsfkXM6vejs=;
        b=O5elbydFGC9xhGY0pIdzr15KAqqn0xrp7GM3gwHiPfiXYPeKA/dT0m5INCFaO9Abjd
         H5PhhqP1stlTj45pMKuYLjzlbuM668grF6HeiniDN014+PgdFJEH66GNuzk1bBE5SpWW
         OE+LXYUKcB8238jCYHv3R4CT8WW7YWblx3C34xglKZdmoSPvtqs5pe65gS53Ch5UzTI/
         VuGqFRDTDwRIvFOHhp/zvz7tauyEZ1vIQKuRi00tjMLQ7W2qDiKvqMDaL9EaMaGusU7+
         PYUGLVUUfFk0iFwMEtZk99FexOLk16e5AQQ2AIy9ivcs+Sp7y/KM5ysql6WYv209elDd
         p1SA==
X-Gm-Message-State: AOAM531Lm/5Mvm/5h2foN3a/II4HX2aJZPHzPe1DP9kPM9M9HKUNnkD9
        diCgZRnqSM3Dxubn+ZqGvKsQeHNL+MUJYA==
X-Google-Smtp-Source: ABdhPJzgnv7jQY6kI+GO2OeP8eZz/Ld7SmWrEp0q0ES60K4JtPhIRFAVcN1OATgD2HM44cY1n3Bi8A==
X-Received: by 2002:a05:6808:8e5:: with SMTP id d5mr5374803oic.64.1598496701584;
        Wed, 26 Aug 2020 19:51:41 -0700 (PDT)
Received: from ?IPv6:2605:6000:8b03:f000:872d:55b6:c324:4146? ([2605:6000:8b03:f000:872d:55b6:c324:4146])
        by smtp.gmail.com with ESMTPSA id l6sm210562otd.20.2020.08.26.19.51.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Aug 2020 19:51:41 -0700 (PDT)
To:     Jason Gunthorpe <jgg@nvidia.com>, linux-rdma@vger.kernel.org
From:   Bob Pearson <rpearsonhpe@gmail.com>
Subject: git repo changes
Message-ID: <2748fbb3-f443-f6e7-bb8e-92ac33bcc19b@gmail.com>
Date:   Wed, 26 Aug 2020 21:51:40 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

The git master branch has vanished since a day or two ago. Should I be tracking for_next now or will master reappear?
