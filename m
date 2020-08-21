Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F48824E397
	for <lists+linux-rdma@lfdr.de>; Sat, 22 Aug 2020 00:46:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726801AbgHUWqt (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 21 Aug 2020 18:46:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726746AbgHUWqt (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 21 Aug 2020 18:46:49 -0400
Received: from mail-oo1-xc2f.google.com (mail-oo1-xc2f.google.com [IPv6:2607:f8b0:4864:20::c2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B33BC061573
        for <linux-rdma@vger.kernel.org>; Fri, 21 Aug 2020 15:46:49 -0700 (PDT)
Received: by mail-oo1-xc2f.google.com with SMTP id z11so690524oon.5
        for <linux-rdma@vger.kernel.org>; Fri, 21 Aug 2020 15:46:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=9YPrsUvq/T0wwitmFZ67Hb5Uqkl7MpLxZVA6U+72h1c=;
        b=rozkqjRXC9bHQq7yMc6dkuu6cPaUC7S0S8eXHjLvXF6mC+MELa9MAo6MI2xd+jE5wx
         UJG1HJHxnq/5CjNbyLTKoiNrIwMttsX9ZYapAUNpbiSpbgtQYenFghVZQz2V0KOHly9y
         pvVMdRpunlQ3THUBDxLKeyf0amAF3Dz+e8dX2l42JqRuiJL1zRt5GZ1ZjFyrjo01DfE9
         N7+pB30tFqF9IZuSFF75bqdA2vHDc/GBypE+9BHcZMymaxHRfRUhSxbfLg2l4Clji+DX
         HCgY3o2X8i8q1camCiAQqCiI1xWnEJVLejb/vnInPvBClM7GAmmfYufLROKcqWfy14yp
         rgmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=9YPrsUvq/T0wwitmFZ67Hb5Uqkl7MpLxZVA6U+72h1c=;
        b=I91PO1h0pYyHC1MUhf8mKsxXYKqfyTAHd9UrTONZNN4fHuvvMgad2KU2XLDEo3n9oF
         usUwHA/lrM5j492TyqBvitr72OXrpdX5NmoO+O1mElJRNv35AWtL4pCjPhgge5VEof86
         LMuLPXscy9s/9BA9u8kfpx9+6DqmSnvoUPUfjA/Xdpo93ZaeRiivODmANyYgJYrcjnP2
         OhgrIzsJIe7fgg5F0U2ow6Aaol9dTFqOiWVKD6A+RwTNij628llYCnWrbbcxoMFK0wwq
         iATO8L1SGsOObkAR9ze3x8Cu0/rWycW1wkCbrqB2EZu/JZeUsdojlBGWQCBKZZNjybvK
         4TXA==
X-Gm-Message-State: AOAM532OFLmB7zYmFRSWwu3/3unopfmdWg3cRZcFGr8u03PjLHNdjovY
        OAjIVQ6ims6HhbyW1+bekPJHhtgfdGerxA==
X-Google-Smtp-Source: ABdhPJywQz92aKmjJnuCJacDed6FC7cvm1coXzckMqhlj07LQFZWtD6tbPXX5FloleFMGe7j16rkTQ==
X-Received: by 2002:a4a:4150:: with SMTP id x77mr3813434ooa.21.1598050007378;
        Fri, 21 Aug 2020 15:46:47 -0700 (PDT)
Received: from ?IPv6:2605:6000:8b03:f000:5efe:6594:621e:4636? ([2605:6000:8b03:f000:5efe:6594:621e:4636])
        by smtp.gmail.com with ESMTPSA id q12sm638297otm.17.2020.08.21.15.46.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Aug 2020 15:46:46 -0700 (PDT)
To:     Leon Romanovsky <leon@kernel.org>, linux-rdma@vger.kernel.org
From:   Bob Pearson <rpearsonhpe@gmail.com>
Subject: a run_tests question
Message-ID: <f3e03ee0-74e7-779d-ad89-91e7835178b9@gmail.com>
Date:   Fri, 21 Aug 2020 17:46:46 -0500
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

I think I figured out why the create/destroy_ah test cases are failing for rxe.
The test_addr.py test uses sgid_index = 0 which is supposed to "always work", but when the device is created the rdma core fills in the first entry with the link local IPV6 address based on the port guid which is the swizzled MAC address.

This doesn't match any of the interface addresses. Once RC traffic has passed the address gets replaced with a 'better' address and create_ah works. The test runs of you just pick sgid_index = 1 instead. This behavior is determined by the core not the driver. The driver doesn't manage the gid table AFAIK.
