Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2971548316A
	for <lists+linux-rdma@lfdr.de>; Mon,  3 Jan 2022 14:33:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233071AbiACNdp (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 3 Jan 2022 08:33:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229534AbiACNdo (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 3 Jan 2022 08:33:44 -0500
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E44AC061761
        for <linux-rdma@vger.kernel.org>; Mon,  3 Jan 2022 05:33:44 -0800 (PST)
Received: by mail-ed1-x529.google.com with SMTP id m21so137173335edc.0
        for <linux-rdma@vger.kernel.org>; Mon, 03 Jan 2022 05:33:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hYFwmqpHN3moQ1uPocgQWDv5or/Y1soalBdFtl7XAI0=;
        b=c2rQ6w/4mtHjmBQonBnOVRYY1hdBKEBe09CyZWa8Uh8HscIS7dkfItizQuC873mi6n
         cC9H/9wfnT/DZNBAuiaqbHux2am9kR9yZsD69tFG2AWX0+DERxz42BSVNm1IEXD0IBYO
         EA2pXfxFbzHq1wWLxt3Pk8MFnTCKDm9aBQB7nN1r9nDdCZ3vpjikjQuUejJoFVB29nfR
         O091M/KVeG6F4sY6c+axzVJHVN0s/1uV+icvMuoounSGapdphspBVBxJlmm0rvqm6fxu
         9t8/LNQSrULGTaDwzaavFa8KikMu/ZGZk2gJsznVF3c5BxAudRgKXaJ2zQtjcX/i8FzK
         nOVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hYFwmqpHN3moQ1uPocgQWDv5or/Y1soalBdFtl7XAI0=;
        b=CK+gVTyY/mPNjlkE2uDUB8Ad3I+p4Rmh1xr/3SOskr1F0RXm5heGTS97KDOnHuu8o2
         GBTtgrCn7ZUcnOkAzQ4SEdZPX0T9Xk48hGbOtjLDZmmqVSksFdsW+LE+eWmS0r0KEvkT
         3OeViSGuGe+NxFn8VJu/1RAZ7gxUU2F81F7Ehn9klslaFQuY82OiVw4e/Zf4Mu6bGmkq
         9kPnMJQqIxOfP2ANHiUZxNe4Kxbg+KUVYqF5UhT4OdLFxXwkz/2S0QyvygE2U5+XIit2
         n9IBX7qLD9NUcJTVNmG6FEyHHAaDNTs93EgwVBsw1roggUThbI6Zs57Cp0x0pspjJlKA
         i7QA==
X-Gm-Message-State: AOAM531yZ7C/LLIC3G9KozeSUthEUkP29ZmRvPAy+JwGD1+MKU3TYmht
        SWcWPAAsAMYmscM9r/bQBn4aufaFwC+iHQ==
X-Google-Smtp-Source: ABdhPJz3bjtRaSFZtReF8NBCpBaZGgZp+7/LoCr/eyWFrWtYOsGBc9RJmiAS2WVv6iz7TG1xmYHwRQ==
X-Received: by 2002:a05:6402:4245:: with SMTP id g5mr44380678edb.377.1641216822835;
        Mon, 03 Jan 2022 05:33:42 -0800 (PST)
Received: from jwang-Latitude-5491.fkb.profitbricks.net ([2001:16b8:456d:f000:5d30:da54:5b3e:3042])
        by smtp.gmail.com with ESMTPSA id ne2sm10702408ejc.108.2022.01.03.05.33.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Jan 2022 05:33:42 -0800 (PST)
From:   Jack Wang <jinpu.wang@ionos.com>
To:     linux-rdma@vger.kernel.org
Cc:     bvanassche@acm.org, leon@kernel.org, jgg@ziepe.ca,
        haris.iqbal@ionos.com, jinpu.wang@ionos.com
Subject: [PATCHv2 for-next 0/5] RTRS renaming
Date:   Mon,  3 Jan 2022 14:33:34 +0100
Message-Id: <20220103133339.9483-1-jinpu.wang@ionos.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Hi Jason, hi Leon,

This patchset from Vaishali, renames a few internal structures to make
the code easier to understand.

rtrs_sess is in fact a path. rtrs_clt/_srv is in fact a session.
This is a mess and makes it difficult to get into the code.

The patchset is based on rdma/for-next:
c8f476da84ad ("Merge branch 'mlx5-next' of git://git.kernel.org/pub/scm/linux/kernel/git/mellanox/linux")

v2: merge first 3 patches to one to be bisectable. (Thanks Guoqing)

v1: https://lore.kernel.org/linux-rdma/aac5544b-279d-35f5-6f19-eb0301294122@linux.dev/T/#md5be427877cbfcb1741cccea4d081df09ae18561

Happy New Year!


Vaishali Thakkar (5):
  RDMA/rtrs: Rename rtrs_sess to rtrs_path
  RDMA/rtrs-srv: Rename rtrs_srv_sess to rtrs_srv_path
  RDMA/rtrs-clt: Rename rtrs_clt_sess to rtrs_clt_path
  RDMA/rtrs-srv: Rename rtrs_srv to rtrs_srv_sess
  RDMA/rtrs-clt: Rename rtrs_clt to rtrs_clt_sess

 drivers/block/rnbd/rnbd-clt.c                |    4 +-
 drivers/block/rnbd/rnbd-clt.h                |    2 +-
 drivers/block/rnbd/rnbd-srv.c                |    8 +-
 drivers/block/rnbd/rnbd-srv.h                |    2 +-
 drivers/infiniband/ulp/rtrs/rtrs-clt-stats.c |    8 +-
 drivers/infiniband/ulp/rtrs/rtrs-clt-sysfs.c |  145 +--
 drivers/infiniband/ulp/rtrs/rtrs-clt.c       | 1083 +++++++++---------
 drivers/infiniband/ulp/rtrs/rtrs-clt.h       |   41 +-
 drivers/infiniband/ulp/rtrs/rtrs-pri.h       |   14 +-
 drivers/infiniband/ulp/rtrs/rtrs-srv-sysfs.c |  121 +-
 drivers/infiniband/ulp/rtrs/rtrs-srv.c       |  664 +++++------
 drivers/infiniband/ulp/rtrs/rtrs-srv.h       |   16 +-
 drivers/infiniband/ulp/rtrs/rtrs.c           |   98 +-
 drivers/infiniband/ulp/rtrs/rtrs.h           |   34 +-
 14 files changed, 1138 insertions(+), 1102 deletions(-)

-- 
2.25.1

