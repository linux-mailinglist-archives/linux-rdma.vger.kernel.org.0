Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66EB14A9C8B
	for <lists+linux-rdma@lfdr.de>; Fri,  4 Feb 2022 16:59:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230211AbiBDP7G (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 4 Feb 2022 10:59:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234808AbiBDP7F (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 4 Feb 2022 10:59:05 -0500
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D688C061714
        for <linux-rdma@vger.kernel.org>; Fri,  4 Feb 2022 07:59:05 -0800 (PST)
Received: by mail-ej1-x629.google.com with SMTP id m4so20795150ejb.9
        for <linux-rdma@vger.kernel.org>; Fri, 04 Feb 2022 07:59:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to;
        bh=0WvPIjvJySmeyGBuurh091SczFdPjzfvwwQjXNn6vDw=;
        b=EkgC5S/fmK1svpM+1D2oULRB7R+hc1ipLVH9jDjq8SdCyTW4ynKO8NxPimBFGTLC74
         0Ryu2gWpKHhYyTsaRvopTNpZaBHCblIkWtg7KA7gOg1GRvm66/7xHtbQqWGurwr5uU1o
         bZvDsNZcwb93BnRnaEB51TM++qLP4Fm+bnpykuqLxzTakPl/KIX7e+NT5NQIXJ51y/4U
         05se9VUkvVSqBqZonN2zlMKT1JR3KOA6Urv7UpejTlSewAY3HW5P+b+EGmfI0aLVAh/D
         JoX8CHHg1M2zBENgxVcvuvEe+OodLuZ6pZCWn4kiN431AAIjKJcugtVvyUGFXMzs06Id
         Oc6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to;
        bh=0WvPIjvJySmeyGBuurh091SczFdPjzfvwwQjXNn6vDw=;
        b=0iI6E/YXBSAoVEGzr0qNTOvEsNX9n8rhuyaWsZeY36YDGgj9XxY5+ESJajr5HvbhKL
         JytMguo5Q20y/4YZbY+RbUIz2A/H0phZXUZDztuwiEUQwEI3lD442GWpl2iZzFy3X7uL
         UNFPxEZM+1Aoh9VGkVTQ7YvqIup58pPUdreC+lXERPdxqYnfR3GjyNsRQ068+avn79SC
         mVQhopLh2+SPzA3ixahvFzfNmN3Wxjir737hV0ZZykb1P9XqMCAqYz4715ppR6eOEv8N
         cLldOo9VjnNEtAI4K/JXDrEpzPkuK3q4XSxAKA/EwxzAoLsWvbHdrxQNi4/n8HJBTNRw
         opUA==
X-Gm-Message-State: AOAM530RfGFMPLK14kSVyoUS96tx/uce2LlUb77Kyg7EBzy+x/DrCIZh
        d1mgYd+8yWKA+CrXeo3rVx/eHEn9c8VQ67mahu4=
X-Google-Smtp-Source: ABdhPJy02ujTJZkpxvm2NyeIpOVKD1UjeHotqJtA14FSJEgBXYzj79flyWMxLRQcKSXsr1SwzbcEIfLPOcKj79eXsQw=
X-Received: by 2002:a17:907:961b:: with SMTP id gb27mr2913158ejc.444.1643990343546;
 Fri, 04 Feb 2022 07:59:03 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a17:906:a45a:0:0:0:0 with HTTP; Fri, 4 Feb 2022 07:59:02
 -0800 (PST)
Reply-To: fionahill.usa@hotmail.com
From:   Fiona Hill <dr.sophia.moore@gmail.com>
Date:   Fri, 4 Feb 2022 07:59:02 -0800
Message-ID: <CAJUx1i_RH3f-Khh=YUrp5OfFpRA0iujaCxf0MtwfO_hoWeM1ig@mail.gmail.com>
Subject: 
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

-- 
How are you and your family you receive my message?
