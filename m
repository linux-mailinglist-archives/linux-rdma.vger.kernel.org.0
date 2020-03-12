Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C174518368E
	for <lists+linux-rdma@lfdr.de>; Thu, 12 Mar 2020 17:50:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726254AbgCLQuj (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 12 Mar 2020 12:50:39 -0400
Received: from mail-pj1-f67.google.com ([209.85.216.67]:36439 "EHLO
        mail-pj1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726194AbgCLQuj (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 12 Mar 2020 12:50:39 -0400
Received: by mail-pj1-f67.google.com with SMTP id l41so2897224pjb.1
        for <linux-rdma@vger.kernel.org>; Thu, 12 Mar 2020 09:50:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=qKBVWVsugFU04YAVuhXGLDVKQxdaMcjJGlVs1Nts+OQ=;
        b=NSfBzKS7ag5ICxadRqW6xj/YtoSOMCabC6chFnU7XZMQLTiY2U/kegxt0CH0Us5TGt
         1foz2exZz0nVoPugUyAC92Cuc7M/oAo9SvgMFVQxGHM8Z01oJI3Ul0eEeWrldYrwOSpi
         N/OS7BlGZgPkIpCzpy6aqPOZIctf0VUxgLXZQYrUoev6e9Cq6Spvxw+kwL6N+Hrz/Bnv
         fMtqlnoWnEfHBX4wC5Chci8Wau1Em4i0HRtS8Qno6rCABaGnAS4YGmko9dh274ChBiV/
         SMc9L2CTSbHXiXKMAH8NsFvWjEz4svOKAOO1G71tz4mRJqSofM8YtJR5KIETW+4NCAnT
         HTxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=qKBVWVsugFU04YAVuhXGLDVKQxdaMcjJGlVs1Nts+OQ=;
        b=HMPHbNFNu2LN7WKVxzm+zsS6CITpDUTdcpSAlG53DE8FTH9yPCKzTRneWw6P8IY+BH
         RM3ITF8Vh1u3JkhnWJ3lQS5Wn5Ry5c4iIjIgFFEt38n6qJp/HjRu1cxUQzgnt590Rz4+
         N/fjp9xUoF0mmVlgH1qCGrvcA4EggNCPRptsZQEHgzp4ZijhDXr6RnXrDqdyrVCAP1cx
         wLsQtnIdT9LWL16RY0Ln5VmV0Dm8en2Mi1mXZBfq2u9t3GgcsAbgXIaMxFMozCY6hcGg
         ejpsmhlpjwA0gJ+oNQAzkz9uL05JK+NS5xzh3rYKRv44LqB1ZTN0INhkFMryp5/O39Q/
         l4lw==
X-Gm-Message-State: ANhLgQ2PnLzyIsTSsPUkBhG+Mfhbk+XwJRFMe8aGg00Dpvr6F5Cx7oAA
        14HZVX8up4JhmCxvHOclMdQ=
X-Google-Smtp-Source: ADFU+vu7yrii9DQflNygew8QhevMsz95MmfqlE440B/9X+Bfj5GOcxCZtte4afKusRam3LHU76+9yw==
X-Received: by 2002:a17:902:8c94:: with SMTP id t20mr8784280plo.170.1584031838695;
        Thu, 12 Mar 2020 09:50:38 -0700 (PDT)
Received: from R04710.localdomain ([121.207.209.132])
        by smtp.googlemail.com with ESMTPSA id y1sm51388737pgs.74.2020.03.12.09.50.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Mar 2020 09:50:38 -0700 (PDT)
From:   huangqingxin <tigerinxm@gmail.com>
To:     monis@mellanox.com
Cc:     dledford@redhat.com, jgg@ziepe.ca, zyjzyj2000@gmail.com,
        linux-rdma@vger.kernel.org,
        huangqingxin <huangqingxin@ruijie.com.cn>
Subject: [PATCH] RDMA/rxe: Advance req.wqe_index when rxe_requester meets error
Date:   Fri, 13 Mar 2020 00:50:32 +0800
Message-Id: <20200312165032.11644-1-tigerinxm@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: huangqingxin <huangqingxin@ruijie.com.cn>

In the rxe_requester, we may fail to xmit packet for missing GID entry.
We should also advance req.wqe_index too.Otherwise, we won't be able
to get the new next wqe, and completer would consume the wrong wqe.

Signed-off-by: huangqingxin <huangqingxin@ruijie.com.cn>
---
 drivers/infiniband/sw/rxe/rxe_req.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/infiniband/sw/rxe/rxe_req.c b/drivers/infiniband/sw/rxe/rxe_req.c
index e5031172c..08f4bea06 100644
--- a/drivers/infiniband/sw/rxe/rxe_req.c
+++ b/drivers/infiniband/sw/rxe/rxe_req.c
@@ -756,6 +756,7 @@ int rxe_requester(void *arg)
 err:
 	wqe->status = IB_WC_LOC_PROT_ERR;
 	wqe->state = wqe_state_error;
+	qp->req.wqe_index = next_index(qp->sq.queue, qp->req.wqe_index);
 	__rxe_do_task(&qp->comp.task);
 
 exit:
-- 
2.17.1

