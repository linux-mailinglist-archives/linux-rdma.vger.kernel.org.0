Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BEF5B39EDA8
	for <lists+linux-rdma@lfdr.de>; Tue,  8 Jun 2021 06:26:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229518AbhFHE2V (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 8 Jun 2021 00:28:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbhFHE2U (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 8 Jun 2021 00:28:20 -0400
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com [IPv6:2607:f8b0:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54464C061574
        for <linux-rdma@vger.kernel.org>; Mon,  7 Jun 2021 21:26:13 -0700 (PDT)
Received: by mail-ot1-x332.google.com with SMTP id o17-20020a9d76510000b02903eabfc221a9so5351128otl.0
        for <linux-rdma@vger.kernel.org>; Mon, 07 Jun 2021 21:26:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Z3nBU4nWuFXzPDNwaCUYYXL4sxtZG5/eFNOVVA6Idok=;
        b=j3+ARyvtwOVgL3Hp/cVbyosE4HhARZEsAx+zxMI/73P/2NKFEKpr9h+cP+t8JrHGF5
         bLtFFKbv3IZ+rdqva1pYxjJJqu/P7ZaSIRzj0VC/LCwO+jEKfPtptsoj83tKbsdNv0p2
         Pu5FXEKAisAkdHzJO1LR5qOtZ5rh3ry5Sxrx69XTTEcCpVbLxewnCh5OWh5FlGfu5ymm
         /evGV6HTj4MFCvPdccOOUJHh5o3Jh67xy4fzHraIvR7bcfACA6v5SsFTftflColzLjnY
         +X3yeZSzIbUan7twhYvx68wfLDlg+HFLjHFgYsJR6DdiSDUl9gAV8av2KLUWn4bKaipO
         oh9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Z3nBU4nWuFXzPDNwaCUYYXL4sxtZG5/eFNOVVA6Idok=;
        b=WdHLKNS/Y/PalF90EYNGBXK9ezDr8AYdg8AiCjULlHSMlBOexIDJ6vnq4CpNzH5Luo
         9FS7Tioy7PA5oLBi/Dty4VqK7L5dzBX05vLCU7XiqQf68f0Sc2UgeqZkKuAQt3W4F2UU
         uZcevciqP2WTiRoU1uoX75DXmvl6NTUm2TA4MMEYfAh3QsHZIl/6pE5G0qqpEtQS7iFx
         CgnWxVIODH5qOc3pKJyzwk76fvAPnME/p0SKbW5a18OuPdTVaFWJVIzJ93LRlWaglhTx
         YmNhKDmId6qksvCzvAn4lBMWws3m5um3fNK5t0YRbs40IthUGpECiu/vtBY6fKXWSrmj
         uLSg==
X-Gm-Message-State: AOAM5324wgVPxlAeaRdxNkydcSDC2jOUtfPadxy8TKkQJwn/28H4eoKM
        4J9itHirDYka7e0a37D/j3k=
X-Google-Smtp-Source: ABdhPJwwt5Om4bmoscvY0rtfDvZeabPja0WffyPpZ1BrdYblpm24zdjMl7z3+rrl0yp+fcoZGuPyDQ==
X-Received: by 2002:a05:6830:2117:: with SMTP id i23mr9193632otc.279.1623126372590;
        Mon, 07 Jun 2021 21:26:12 -0700 (PDT)
Received: from localhost (2603-8081-140c-1a00-cb25-4f27-0965-41cc.res6.spectrum.com. [2603:8081:140c:1a00:cb25:4f27:965:41cc])
        by smtp.gmail.com with ESMTPSA id a14sm2805088otl.52.2021.06.07.21.26.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Jun 2021 21:26:12 -0700 (PDT)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, monis@mellanox.com,
        linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH for-next v9 1/9] RDMA/rxe: Add bind MW fields to rxe_send_wr
Date:   Mon,  7 Jun 2021 23:25:44 -0500
Message-Id: <20210608042552.33275-2-rpearsonhpe@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210608042552.33275-1-rpearsonhpe@gmail.com>
References: <20210608042552.33275-1-rpearsonhpe@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Add fields to struct rxe_send_wr in rdma_user_rxe.h to support bind MW
work requests

Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
---
v8:
  Dropped the flags field in wr.mw which was no longer needed.
  The size of the mw struct broke binary compatibility because
  it extended the size of the wr union beyond 40 bytes.
Reported-by: Zhu Yanjun <zyjzyj2000@gmail.com>
---
 include/uapi/rdma/rdma_user_rxe.h | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/include/uapi/rdma/rdma_user_rxe.h b/include/uapi/rdma/rdma_user_rxe.h
index 068433e2229d..e283c2220aba 100644
--- a/include/uapi/rdma/rdma_user_rxe.h
+++ b/include/uapi/rdma/rdma_user_rxe.h
@@ -99,7 +99,16 @@ struct rxe_send_wr {
 			__u32	remote_qkey;
 			__u16	pkey_index;
 		} ud;
+		struct {
+			__aligned_u64	addr;
+			__aligned_u64	length;
+			__u32		mr_lkey;
+			__u32		mw_rkey;
+			__u32		rkey;
+			__u32		access;
+		} mw;
 		/* reg is only used by the kernel and is not part of the uapi */
+#ifdef __KERNEL__
 		struct {
 			union {
 				struct ib_mr *mr;
@@ -108,6 +117,7 @@ struct rxe_send_wr {
 			__u32	     key;
 			__u32	     access;
 		} reg;
+#endif
 	} wr;
 };
 
-- 
2.30.2

