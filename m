Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 10424204637
	for <lists+linux-rdma@lfdr.de>; Tue, 23 Jun 2020 02:52:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732367AbgFWAwd (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 22 Jun 2020 20:52:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731750AbgFWAwd (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 22 Jun 2020 20:52:33 -0400
Received: from mail-ot1-x341.google.com (mail-ot1-x341.google.com [IPv6:2607:f8b0:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12C85C061573;
        Mon, 22 Jun 2020 17:52:32 -0700 (PDT)
Received: by mail-ot1-x341.google.com with SMTP id 72so1322651otc.3;
        Mon, 22 Jun 2020 17:52:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=E5Itn4032fFev2jN27cnxvdUZFh+vCy6bXA8UGcTnNM=;
        b=OKZq2sNqAiEPp8GHKDzonXe9/iMEt/RLwsp9GK7rxaIt+ad8981GA/krythiirtyXO
         TFtpDALvvBa6rRx+OSq0oX7aSccUE5jsBnflJA+6nVOd7KNqnGyCTtHumFH+EAFRQO4h
         Oato5fB9jOzUs02Y2IQh5ut60cvXINzYeyRrrhUH1MP+ddXTvOIxqWu5Hucjz0ukWkJP
         nrolZiOHuxHQcEJOtX97PEcgYI63cgRCuxp4gKcBoK+68GBAgT1hofIlbIYXHBYcK5Ve
         0N/nGRjZJ6aWOnMnWBkwHZJu1bJ25yVm4nJgmNFRkCwnvwhBn9Doc16IfLAtI04wzOxS
         jAxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=E5Itn4032fFev2jN27cnxvdUZFh+vCy6bXA8UGcTnNM=;
        b=iP25WV0DpA2xnum5OCvvRTeQQH+wDXnPGyAWdiEwykHzn9XrLlSWct2q93p59Pcdko
         6DNVKTs3dVotziyPAH81cAe/elUoOfMFPJsLcKChhiZxniX9/9kbEyKTZBxX3v81RddA
         /S0vHj7pe/GLEvHLL6A65aNNohSsXAlA6h5GggNEKekF86m3sVSVBjF4ynkRCvU7AnV/
         VFqIcMsBjWg6LfRS34PD3u4v+8+TVqVKBhgIPNpDJpWF7m75nJYF42rPElz6vji9vwbF
         4F9Src1ZQayvHOz84tVfBKuoPSL+eXXEygeEHweAq0zednLQs+Sv1jR3IvzR5jSZXnyW
         4rCw==
X-Gm-Message-State: AOAM531Ng9EnEehzcs0sg9byZey4ELzAGMZQb18aNSQ1xQni7yhUMnQ3
        ifpb7uA1cFP6Mr7sUVCSmgY=
X-Google-Smtp-Source: ABdhPJxGIGmfD8hK1NT+dxIFo0diAUEBWL50PzuKgZrym5gHWsdz5MIRKFaeW310/BgQAZnpXASGsA==
X-Received: by 2002:a9d:38a:: with SMTP id f10mr17175749otf.230.1592873551426;
        Mon, 22 Jun 2020 17:52:31 -0700 (PDT)
Received: from localhost.localdomain ([2604:1380:4111:8b00::3])
        by smtp.gmail.com with ESMTPSA id l195sm3629058oib.40.2020.06.22.17.52.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jun 2020 17:52:30 -0700 (PDT)
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Mike Marciniszyn <mike.marciniszyn@intel.com>,
        Dennis Dalessandro <dennis.dalessandro@intel.com>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>
Cc:     linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com,
        Nathan Chancellor <natechancellor@gmail.com>
Subject: [PATCH] IB/hfi1: Add explicit cast OPA_MTU_8192 to 'enum ib_mtu'
Date:   Mon, 22 Jun 2020 17:52:24 -0700
Message-Id: <20200623005224.492239-1-natechancellor@gmail.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Clang warns:

drivers/infiniband/hw/hfi1/qp.c:198:9: warning: implicit conversion from
enumeration type 'enum opa_mtu' to different enumeration type 'enum
ib_mtu' [-Wenum-conversion]
                mtu = OPA_MTU_8192;
                    ~ ^~~~~~~~~~~~
1 warning generated.

enum opa_mtu extends enum ib_mtu. There are typically two ways to deal
with this:

* Remove the expected types and just use 'int' for all parameters and
  types.

* Explicitly cast the enums between each other.

This driver chooses to do the later so do the same thing here.

Fixes: 6d72344cf6c4 ("IB/ipoib: Increase ipoib Datagram mode MTU's upper limit")
Link: https://github.com/ClangBuiltLinux/linux/issues/1062
Link: https://lore.kernel.org/linux-rdma/20200527040350.GA3118979@ubuntu-s3-xlarge-x86/
Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
---
 drivers/infiniband/hw/hfi1/qp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/infiniband/hw/hfi1/qp.c b/drivers/infiniband/hw/hfi1/qp.c
index 0c2ae9f7b3e8..2f3d9ce077d3 100644
--- a/drivers/infiniband/hw/hfi1/qp.c
+++ b/drivers/infiniband/hw/hfi1/qp.c
@@ -195,7 +195,7 @@ static inline int verbs_mtu_enum_to_int(struct ib_device *dev, enum ib_mtu mtu)
 {
 	/* Constraining 10KB packets to 8KB packets */
 	if (mtu == (enum ib_mtu)OPA_MTU_10240)
-		mtu = OPA_MTU_8192;
+		mtu = (enum ib_mtu)OPA_MTU_8192;
 	return opa_mtu_enum_to_int((enum opa_mtu)mtu);
 }
 

base-commit: 27f11fea33608cbd321a97cbecfa2ef97dcc1821
-- 
2.27.0

