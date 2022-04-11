Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44A224FB26B
	for <lists+linux-rdma@lfdr.de>; Mon, 11 Apr 2022 05:34:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244577AbiDKDhA (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 10 Apr 2022 23:37:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244567AbiDKDgy (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 10 Apr 2022 23:36:54 -0400
Received: from mail-oa1-x2c.google.com (mail-oa1-x2c.google.com [IPv6:2001:4860:4864:20::2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 441B62BF6
        for <linux-rdma@vger.kernel.org>; Sun, 10 Apr 2022 20:34:38 -0700 (PDT)
Received: by mail-oa1-x2c.google.com with SMTP id 586e51a60fabf-d39f741ba0so15831537fac.13
        for <linux-rdma@vger.kernel.org>; Sun, 10 Apr 2022 20:34:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:content-language:to:from
         :subject:content-transfer-encoding;
        bh=/D73zSNwDoFgLHtRvKEK63Im0YhA/WU+8IPKBnWOpgI=;
        b=A3Q9+BNm/5quPCX8EillbNfOW8ptkqyvMK4c/ms31au2x/bD4KfK/k0Rs2MNG8m3/8
         8hzAAEpmf+7iXmilunTt2pj2jvdHCd7wimbMVRBeNcCZ7oR8Z9NFR1FDVt9v8mlxXlNa
         5bMdx7PgDV0ZEGyps3mQHrJzIRhqJbNtRXJcN1nmZ5hy2Ale1cjh/6WA9SKkrK2qwuv3
         tnMmW9s3eV8YEhhQvIVuaQUGyJ/wcZ4J4jr6QnFIaHiUMOk0LtCo4+Wr/yOopuB9/Lz2
         bUYdk3QOcXDy+zQ7SHRFKVroaJ9+tfMnCMcwjtEv/8DvHnwlcrjWdeftNUI4o/ZrL3lE
         pMjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent
         :content-language:to:from:subject:content-transfer-encoding;
        bh=/D73zSNwDoFgLHtRvKEK63Im0YhA/WU+8IPKBnWOpgI=;
        b=oewMG8xoT4++ic+5ezRfAhp1BlaEGqEdm1Po18mfr+L2gGZwJMUkCDodn+kZ27nqUP
         pHmI4Jf/XGmY2jAV/WIc7MeIFreQCryWDp1cRoODCd4lTjUsS3cOeUK5VSP1EdTixffA
         HIEgjWglhJHg4kIWFQtW/vh7REgv/9v6OagYbf23t0EU9lneZpPZzN1ImAXllrZ0AI9U
         N1n+FER/+xxtNAoHAH52cQK/zVntynb7acchwF/q+Ro5uPE4o0SagpVWFp6/zdSBNtNt
         NA0w56MB8TJyIFh6SUZoPjT5cUt2ZypI2ocvEr8Pgpl+tGdDGeowu8GwUQCRp1iQgP/X
         Djkw==
X-Gm-Message-State: AOAM531xoB/Zg/CLdpbbtgE8SDYo2+CJGcxVpcTAq1LJKbs6pcvAENFa
        v7a3p0/YAy4hk4ATBJHjzhpc7+MH2Vw=
X-Google-Smtp-Source: ABdhPJybdSgtRU8S0L7n+Nhyyi+rzL4y7gpB5vUNmQDJcdZJKaLIk/6DhPdQtL0iujTEMPP2YJ7ZUA==
X-Received: by 2002:a05:6870:5802:b0:de:ce5e:33ea with SMTP id r2-20020a056870580200b000dece5e33eamr12768187oap.57.1649648078027;
        Sun, 10 Apr 2022 20:34:38 -0700 (PDT)
Received: from ?IPV6:2603:8081:140c:1a00:8884:2210:b4d7:3f81? (2603-8081-140c-1a00-8884-2210-b4d7-3f81.res6.spectrum.com. [2603:8081:140c:1a00:8884:2210:b4d7:3f81])
        by smtp.gmail.com with ESMTPSA id o17-20020a9d5c11000000b005b2611a13edsm12022726otk.61.2022.04.10.20.34.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 10 Apr 2022 20:34:37 -0700 (PDT)
Message-ID: <1b0ae089-ff3f-7e84-4c07-a5d97554e3c0@gmail.com>
Date:   Sun, 10 Apr 2022 22:34:37 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Content-Language: en-US
To:     Zhu Yanjun <zyjzyj2000@gmail.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
From:   Bob Pearson <rpearsonhpe@gmail.com>
Subject: null pointer in rxe_mr_copy()
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Zhu,

Since checking for mr == NULL in rxe_mr_copy fixes the problem you were seeing in rping.
Perhaps it would be a good idea to apply the following patch which would tell us which of
the three calls to rxe_mr_copy is failing. My suspicion is the one in read_reply() in rxe_resp.c
This could be caused by a race between shutting down the qp and finishing up an RDMA read.
The responder resources state machine is completely unprotected from simultaneous access by
verbs code and bh code in rxe_resp.c. rxe_resp is a tasklet so all the accesses from there are
serialized but if anyone makes a verbs call that touches the responder resources it could
cause problems. The most likely (only?) place this could happen is qp shutdown.

Bob



diff --git a/drivers/infiniband/sw/rxe/rxe_mr.c b/drivers/infiniband/sw/rxe/rxe_mr.c

index 60a31b718774..66184f5a4ddf 100644

--- a/drivers/infiniband/sw/rxe/rxe_mr.c

+++ b/drivers/infiniband/sw/rxe/rxe_mr.c

@@ -489,6 +489,7 @@ int copy_data(

 		if (bytes > 0) {

 			iova = sge->addr + offset;

 

+			WARN_ON(!mr);

 			err = rxe_mr_copy(mr, iova, addr, bytes, dir);

 			if (err)

 				goto err2;

diff --git a/drivers/infiniband/sw/rxe/rxe_resp.c b/drivers/infiniband/sw/rxe/rxe_resp.c

index 1d95fab606da..6e3e86bdccd7 100644

--- a/drivers/infiniband/sw/rxe/rxe_resp.c

+++ b/drivers/infiniband/sw/rxe/rxe_resp.c

@@ -536,6 +536,7 @@ static enum resp_states write_data_in(struct rxe_qp *qp,

 	int	err;

 	int data_len = payload_size(pkt);

 

+	WARN_ON(!qp->resp.mr);

 	err = rxe_mr_copy(qp->resp.mr, qp->resp.va + qp->resp.offset,

 			  payload_addr(pkt), data_len, RXE_TO_MR_OBJ);

 	if (err) {

@@ -772,6 +773,7 @@ static enum resp_states read_reply(struct rxe_qp *qp,

 	if (!skb)

 		return RESPST_ERR_RNR;

 

+	WARN_ON(!mr);

 	err = rxe_mr_copy(mr, res->read.va, payload_addr(&ack_pkt),

 			  payload, RXE_FROM_MR_OBJ);

 	if (err)

