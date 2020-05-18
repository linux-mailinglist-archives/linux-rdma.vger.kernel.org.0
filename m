Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 22C0A1D75DC
	for <lists+linux-rdma@lfdr.de>; Mon, 18 May 2020 13:05:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726399AbgERLFl (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 18 May 2020 07:05:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726279AbgERLFl (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 18 May 2020 07:05:41 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEFEFC061A0C
        for <linux-rdma@vger.kernel.org>; Mon, 18 May 2020 04:05:40 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id s8so11315038wrt.9
        for <linux-rdma@vger.kernel.org>; Mon, 18 May 2020 04:05:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ABCvkBX2Acr6ldD3suSNb2oOhBzoJPxXXiYab/Tbl4g=;
        b=EY02gc7aPAgWbfEsdYyVx1DmOWDov6/jVQjYeP8Tal7YlIWa2+5lH7CSG/ybYNBaPj
         FtvEu1SXo3yK6GIaVXQRtF7mIWQNArX9uhSy69LrFF6AOl6sQUCIBOIvpIAkP4IkezJ5
         YCFA6sC07qeZ7rhXLMXGgiJb+bD++/fQUWD7dMrpRYLVrgdE0yS81JQRkCVnH+iNrjyt
         vOLq2ShLDykaBHRbSGnLKdnHLdOT01tAwmChLfgTTpoPPXAekaEor+UegZmA/jI2IPJW
         ViLQIzNKTPHrDSelqKO5iOcZJHE0upjExn9oMAvW+06c+KuBtE2mL2Wg6zTGR2U7s1aB
         TaSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ABCvkBX2Acr6ldD3suSNb2oOhBzoJPxXXiYab/Tbl4g=;
        b=e5I8VxJ4uLkG2+IiAEAtprEXJ6ZDMMyHSU2YASUBSwnvnYQqXaMvNFbcQwjP6P/4tI
         Aev8wHr/y9r8lF4eRtzc1dBwUELxxTsZxPANXnB34T2xDQ720fvvWei9mXh2n58gMNYG
         hmSzZ5xobXUWgimCpD1JdjEt1a7nsvCqRzUA/GqD3a3+S3UPVpS8gUD2OAmr/MQRTBvW
         OzzE4uW4r0CNmGbpycQxTKyL0rBeppfgZ7Q8MQ3+LvhC7WbPZjVZw/f7Suoai8ctvwos
         RTbpalFyHGJundABoONMOZ6QMSo2uWiLYA7DTXaNb/Nyx8XXfomJa4zJOzex/mXO4pje
         QuOA==
X-Gm-Message-State: AOAM531sfaPDGyXz/LT7J3wNTqehOAsGQLboi5WIMUMneos3fZjC38qy
        zYh9g9xv3lxtSQDR+JbrmBeiBOWWGscZ
X-Google-Smtp-Source: ABdhPJy8hQzE0ucGgmlheYoRPjkg4HV+mCl5SF4Zm8lTsTaa8XfHg7/vyy38w9dX/nlG78dwIHKB4Q==
X-Received: by 2002:a5d:5449:: with SMTP id w9mr19518435wrv.361.1589799939448;
        Mon, 18 May 2020 04:05:39 -0700 (PDT)
Received: from dkxps.fkb.profitbricks.net (dslb-002-204-227-207.002.204.pools.vodafone-ip.de. [2.204.227.207])
        by smtp.gmail.com with ESMTPSA id a74sm10565648wme.23.2020.05.18.04.05.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2020 04:05:38 -0700 (PDT)
From:   Danil Kipnis <danil.kipnis@cloud.ionos.com>
To:     linux-rdma@vger.kernel.org, jgg@ziepe.ca
Cc:     dledford@redhat.com, bvanassche@acm.org,
        jinpu.wang@cloud.ionos.com,
        Danil Kipnis <danil.kipnis@cloud.ionos.com>,
        kbuild test robot <lkp@intel.com>
Subject: [PATCH 1/1] rtrs-clt: silence kbuild test inconsistent intenting smatch warning
Date:   Mon, 18 May 2020 13:04:54 +0200
Message-Id: <20200518110454.427034-2-danil.kipnis@cloud.ionos.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200518110454.427034-1-danil.kipnis@cloud.ionos.com>
References: <202005181024.7TYVfk5c%lkp@intel.com>
 <20200518110454.427034-1-danil.kipnis@cloud.ionos.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Kbuild test robot reports a smatch warning:
drivers/infiniband/ulp/rtrs/rtrs-clt.c:1196 rtrs_clt_failover_req() warn: inconsistent indenting
drivers/infiniband/ulp/rtrs/rtrs-clt.c:2890 rtrs_clt_request() warn: inconsistent indenting

To get rid of the warning, move the while_each_path() macro to a newline.
Rename the macro to end_each_path() to avoid the "while should follow close
brace '}'" checkpatch error.

Reported-by: kbuild test robot <lkp@intel.com>
Signed-off-by: Danil Kipnis <danil.kipnis@cloud.ionos.com>
---
 drivers/infiniband/ulp/rtrs/rtrs-clt.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/infiniband/ulp/rtrs/rtrs-clt.c b/drivers/infiniband/ulp/rtrs/rtrs-clt.c
index 468fdd0d8713..0fa3a229d90e 100644
--- a/drivers/infiniband/ulp/rtrs/rtrs-clt.c
+++ b/drivers/infiniband/ulp/rtrs/rtrs-clt.c
@@ -734,7 +734,7 @@ struct path_it {
 			  (it)->i < (it)->clt->paths_num;		\
 	     (it)->i++)
 
-#define while_each_path(it)						\
+#define end_each_path(it)						\
 	path_it_deinit(it);						\
 	rcu_read_unlock();						\
 	}
@@ -1193,7 +1193,8 @@ static int rtrs_clt_failover_req(struct rtrs_clt *clt,
 		/* Success path */
 		rtrs_clt_inc_failover_cnt(alive_sess->stats);
 		break;
-	} while_each_path(&it);
+	}
+	end_each_path(&it);
 
 	return err;
 }
@@ -2887,7 +2888,8 @@ int rtrs_clt_request(int dir, struct rtrs_clt_req_ops *ops,
 		}
 		/* Success path */
 		break;
-	} while_each_path(&it);
+	}
+	end_each_path(&it);
 
 	return err;
 }
-- 
2.25.1

