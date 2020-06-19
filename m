Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D12E7200993
	for <lists+linux-rdma@lfdr.de>; Fri, 19 Jun 2020 15:10:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726906AbgFSNKd (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 19 Jun 2020 09:10:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725974AbgFSNKb (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 19 Jun 2020 09:10:31 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32D87C06174E;
        Fri, 19 Jun 2020 06:10:30 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id i4so4278799pjd.0;
        Fri, 19 Jun 2020 06:10:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=Mpz+FtahIGVbaWCXUqlKnR3T+YHk6o26tu6s0yCqAdA=;
        b=UuiTQ484P8miKGDp4jn4oAJ5OMcCW4IFNTRppv0vZIjCXuc2+8bDL7tLuuCvveGwNm
         JXtBsUY4wpCH5bGp4xB6z4jvD51GCFNtg1Irx8cAC4rVmWv8VgKRXSvqS7Sgo31GzoN+
         B0rDHgMGhkqFrjPRtouQ7JBLdIqxeHJSO7mtBLBSpPzXnq+7/eo2Imt/DcDnhJWg4Uqn
         LGWuZXfRQYpwciONKdtgXCd45ic4eF1ys0JKtiZCXuvIm6z4AW4NWDCvE/toaQtHnqo6
         4OwkGCYIUK2arabhNxZIA3tMDmWciRINV6mUpvGdXLn24rzmTAoD6I12zFVp2mWnRP5o
         x1HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=Mpz+FtahIGVbaWCXUqlKnR3T+YHk6o26tu6s0yCqAdA=;
        b=UeUwqHfKlN2IwgW39QJWajOzHEoi33EcPGKZKk9UMoh2tiFMn8i5+DmWYribBs/zZ3
         V+Ns6lfIpJQ8qymPbzLoktWnmewnq2IrVhfdJ7UU7Spd0fmDjDa4geVvnNcWuFFDsPsI
         AgA0XPbAfom1LC9YVYlLKX4HlkQmV4NSjzfsyhUQ/jPnZtvhBNSiY9nIr5Y8B8cRJq+B
         AQsAB9DKsLrjlUJYZL4dJ919dZZOEpN9H3/oP70cIa49csa5UbkPqTCdnoyCrAc7PhUQ
         5WYbPXI2+qAYPGNrzMKZNyjGe4dAsKq3gaad2ig8u77ZCaAxnYIVzmn1dFpCXfdoyO6f
         7FUQ==
X-Gm-Message-State: AOAM532qWnwcfxw/Cvs6T3e0OXkLqXeDrGRTmHR1xPooacVM61N7Cxeh
        majhILR3UBHTXpFxtmrLLTRLN0ycHnU=
X-Google-Smtp-Source: ABdhPJzqPs81Vxl274BtKkELFraEc0MGFOSHQD7zMxgPdkugNt7MMVOACN7G7nfOa7jQjxHFMnYTGA==
X-Received: by 2002:a17:90a:e60c:: with SMTP id j12mr3524233pjy.185.1592572229826;
        Fri, 19 Jun 2020 06:10:29 -0700 (PDT)
Received: from debian.debian-2 ([154.223.71.34])
        by smtp.gmail.com with ESMTPSA id w18sm6062762pfq.121.2020.06.19.06.10.26
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 19 Jun 2020 06:10:28 -0700 (PDT)
Date:   Fri, 19 Jun 2020 21:10:23 +0800
From:   Bo YU <tsu.yubo@gmail.com>
To:     danil.kipnis@cloud.ionos.com, jinpu.wang@cloud.ionos.com,
        ledford@redhat.com, jgg@ziepe.ca
Cc:     linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
        tsu.yubo@gmail.com
Subject: [PATCH -next] RDMA/rtrs: fix potential resources leaks
Message-ID: <20200619131017.pr7eoca2bzdtlbk4@debian.debian-2>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Dev is returned from allocation function kzalloc but it does not
free it in out_err path.

Detected by CoverityScan, CID# 1464569: (Resource leak)

Fixes: c0894b3ea69d3("RDMA/rtrs: core: lib functions shared between client and server modules")
Signed-off-by: Bo YU <tsu.yubo@gmail.com>
---
 drivers/infiniband/ulp/rtrs/rtrs.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/infiniband/ulp/rtrs/rtrs.c b/drivers/infiniband/ulp/rtrs/rtrs.c
index ff1093d6e4bc..03bdab92fa49 100644
--- a/drivers/infiniband/ulp/rtrs/rtrs.c
+++ b/drivers/infiniband/ulp/rtrs/rtrs.c
@@ -607,6 +607,7 @@ rtrs_ib_dev_find_or_add(struct ib_device *ib_dev,
 	else
 		kfree(dev);
 out_err:
+	kfree(dev);
 	return NULL;
 }
 EXPORT_SYMBOL(rtrs_ib_dev_find_or_add);
--
2.11.0

