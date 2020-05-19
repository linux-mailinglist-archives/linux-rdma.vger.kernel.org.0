Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA6201D954E
	for <lists+linux-rdma@lfdr.de>; Tue, 19 May 2020 13:29:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728690AbgESL34 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 19 May 2020 07:29:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726949AbgESL34 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 19 May 2020 07:29:56 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A583FC08C5C1
        for <linux-rdma@vger.kernel.org>; Tue, 19 May 2020 04:29:55 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id n18so3097112wmj.5
        for <linux-rdma@vger.kernel.org>; Tue, 19 May 2020 04:29:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8ZfvggmvQu85nIN1LaIoXlz/9OYnyPQMzR24y6/lbLM=;
        b=BV69TgNyfOp7ZqcP3ZFgX7XYRnKuJ9Knrsxt/70a/rYvAEOk+6azknhcDduyBWI2S6
         ei4vVgeFGDZu+xWYHnWH1XUYyfWaWg3HrCQFIl5fkNZG4AajgK1A8zg2PxqH0mcK5QkN
         X/4EywONFwdSKjJHn/kFoYLQadtMn9lMkFWVJjB5uQBnqzwPb8PDaTcQ3CO+HyAZZTxO
         dRvHc1504ytvTJ9dfow4zsCZC/VHn0NhqXYAphDZNy8Wa8KU0q8Tc0ccU+igZy4HeDxB
         E786v+RcjUiQf1sbxoYE0QA2iHo3TsSZUv7auczVjxtsC0YrDCPDk+/prANiOniKV3fE
         F7dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8ZfvggmvQu85nIN1LaIoXlz/9OYnyPQMzR24y6/lbLM=;
        b=ujzKVt9vFICUcODJPd6bJAaDAMsb93gFPdlpQMEgnL1LnNGP2q77qA6xv5PIlU/+Pm
         gYqllHrhOlFJMDdh+u6hlljA14GtSBUuNd3LaOQIGmHtTG7PrtvzlYd9AzBtUXU2QPDz
         aW7ayot92yr05+aO0GmZS/pHTM21hEdrg9VUw889wfDNAUYX+Wj724A3zawxpocgdGfw
         9FTOWBXnxJWsgtbjy10re5tAsZPkgT4uT5dgr+ju1sHH6pfqGYf4IXBVNVJpWgPh66u8
         rAaoj0rD2nwf2OLX/CEGIna0zt+cPDYYGpEQuoW8vfbq/0YMBYyVa681RADSaLmKukGQ
         GClg==
X-Gm-Message-State: AOAM531EnFUlmRQVeMItrB5TS9yP14nUCg3IWPBtF+v1R7PjPua/k++3
        +cxWCXc0+W3fbhl3UHzltAuw
X-Google-Smtp-Source: ABdhPJx3xt6DGqbiQhh4L3B/c7SN2vEUehC//YMkBQU1F6d2WujaUpm9Vypwu+ikpf2Z4dDrczaXvw==
X-Received: by 2002:a1c:c309:: with SMTP id t9mr4813047wmf.113.1589887794181;
        Tue, 19 May 2020 04:29:54 -0700 (PDT)
Received: from dkxps.fkb.profitbricks.net (dslb-002-204-227-207.002.204.pools.vodafone-ip.de. [2.204.227.207])
        by smtp.gmail.com with ESMTPSA id n9sm3635898wmj.5.2020.05.19.04.29.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2020 04:29:53 -0700 (PDT)
From:   Danil Kipnis <danil.kipnis@cloud.ionos.com>
To:     linux-block@vger.kernel.org, linux-rdma@vger.kernel.org,
        linux-next@vger.kernel.org, axboe@kernel.dk, dledford@redhat.com,
        jgg@ziepe.ca
Cc:     bvanassche@acm.org, leon@kernel.org, danil.kipnis@cloud.ionos.com,
        jinpu.wang@cloud.ionos.com, kbuild test robot <lkp@intel.com>
Subject: [PATCH v2] rtrs-clt: silence kbuild test inconsistent intenting smatch warning
Date:   Tue, 19 May 2020 13:29:36 +0200
Message-Id: <20200519112936.928185-1-danil.kipnis@cloud.ionos.com>
X-Mailer: git-send-email 2.25.1
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

Fixes: 6a98d71daea1 ("RDMA/rtrs: client: main functionality")

Signed-off-by: Danil Kipnis <danil.kipnis@cloud.ionos.com>
Reported-by: kbuild test robot <lkp@intel.com>
---
 v1->v2 Add fixes line
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

