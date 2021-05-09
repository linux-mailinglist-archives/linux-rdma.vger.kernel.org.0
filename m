Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D1713775E5
	for <lists+linux-rdma@lfdr.de>; Sun,  9 May 2021 10:31:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229616AbhEIIc5 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 9 May 2021 04:32:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229605AbhEIIc5 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 9 May 2021 04:32:57 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0596FC061573;
        Sun,  9 May 2021 01:31:54 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id cl24-20020a17090af698b0290157efd14899so8604011pjb.2;
        Sun, 09 May 2021 01:31:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=bq9TTG4WifnywdMVbI6XigdykptN9YPEmuxbdUawLyM=;
        b=Eq73xFA7pAj+Z/rQ4Vwp4uOXwhK9vm5REU2YIjTx0rmewbUMOrjHw27MMDQH8Abfhh
         nPfdcQM8voejhMfKT3nxqgOTmoV1Q4biPyvJDAbvzGJ4mSSLSwQxwG2GXb1lVOdTK54L
         FjuCiFsx4llp/dTGMjNgUTHs8ORZnsvzQDOpvoVYBIA61QHv0WJSE32MBl0I0nvQNXnT
         TND4X1vQp32Fuanx+5dItfirlDUGbCrrQRzA0xcfD2A7ZM0jC1apATT0QT/FAVdQPYMP
         zqh3Gs5ic+Bf4UvaThuB8ys03a4iZKlX9rAW7rWn/IvLRLFHQ1dgxRLTCs0ijHHkBexW
         qP1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=bq9TTG4WifnywdMVbI6XigdykptN9YPEmuxbdUawLyM=;
        b=fFOLmgSxp1EGR7nOEnh+eQdV+y5UzG6rvAjgRLsFFw3bkH4cV4NrXcskcUCmc/UadN
         0HEsNYt6Rj2nOLYpU2vHTwj+PQkncEkwA9GLhkwoBdVfj/m9UMd4qDPjcD4FoCBo7jKo
         cBcDWq3ZqcY2qsvSOeMlDxNUmS/StbOfMHKnEoJLfdqNOcuB055UHhef72hcDc2yF9GB
         UxaMyzEvSaolQ9OfwuPj81mIBr0vjWilHmq7FT47LWYzA8IZy1lGmzDa2jOgiP3sJXZJ
         5kFHsbtBOpNWTl00ye+yMi8BjA5qdFazagcXcVnHpNtAEn9R7CWFRHalngkasBcx635F
         /QZQ==
X-Gm-Message-State: AOAM531sv17/1ir8Re2onzGlgd0DCz9vK5rxIsuVxPXxrfsPRM2opV5E
        epWI6sfePwsXbG0zPcebGFZ0VaMXWeUCeqz/
X-Google-Smtp-Source: ABdhPJxBWqrGIeBjflmG9lKjQ4xrlzgFnc1GMg9nWSwJrR2lA3c6DKNEQ3f/Rj0xXBINAY92yvme6w==
X-Received: by 2002:a17:90b:17c7:: with SMTP id me7mr32501393pjb.96.1620549113495;
        Sun, 09 May 2021 01:31:53 -0700 (PDT)
Received: from localhost.localdomain (host-219-71-67-82.dynamic.kbtelecom.net. [219.71.67.82])
        by smtp.gmail.com with ESMTPSA id e1sm8443730pgl.25.2021.05.09.01.31.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 May 2021 01:31:53 -0700 (PDT)
From:   Wei Ming Chen <jj251510319013@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-rdma@vger.kernel.org,
        Wei Ming Chen <jj251510319013@gmail.com>
Subject: [PATCH] i40iw: Use fallthrough pseudo-keyword
Date:   Sun,  9 May 2021 16:31:35 +0800
Message-Id: <20210509083135.14575-1-jj251510319013@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Add pseudo-keyword macro fallthrough[1]

[1] https://www.kernel.org/doc/html/latest/process/deprecated.html?highlight=fallthrough#implicit-switch-case-fall-through

Signed-off-by: Wei Ming Chen <jj251510319013@gmail.com>
---
 drivers/infiniband/hw/i40iw/i40iw_ctrl.c | 1 +
 drivers/infiniband/hw/i40iw/i40iw_uk.c   | 1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/infiniband/hw/i40iw/i40iw_ctrl.c b/drivers/infiniband/hw/i40iw/i40iw_ctrl.c
index eaea5d545eb8..c6081283217c 100644
--- a/drivers/infiniband/hw/i40iw/i40iw_ctrl.c
+++ b/drivers/infiniband/hw/i40iw/i40iw_ctrl.c
@@ -2454,6 +2454,7 @@ static enum i40iw_status_code i40iw_sc_qp_init(struct i40iw_sc_qp *qp,
 			return ret_code;
 		break;
 	case 5: /* fallthrough until next ABI version */
+		fallthrough;
 	default:
 		if (qp->qp_uk.max_rq_frag_cnt > I40IW_MAX_WQ_FRAGMENT_COUNT)
 			return I40IW_ERR_INVALID_FRAG_COUNT;
diff --git a/drivers/infiniband/hw/i40iw/i40iw_uk.c b/drivers/infiniband/hw/i40iw/i40iw_uk.c
index f521be16bf31..e1c318c291c0 100644
--- a/drivers/infiniband/hw/i40iw/i40iw_uk.c
+++ b/drivers/infiniband/hw/i40iw/i40iw_uk.c
@@ -1004,6 +1004,7 @@ enum i40iw_status_code i40iw_qp_uk_init(struct i40iw_qp_uk *qp,
 			i40iw_get_wqe_shift(info->max_rq_frag_cnt, 0, &rqshift);
 			break;
 		case 5: /* fallthrough until next ABI version */
+			fallthrough;
 		default:
 			rqshift = I40IW_MAX_RQ_WQE_SHIFT;
 			break;
-- 
2.25.1

