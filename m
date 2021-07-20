Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E00063CF2DC
	for <lists+linux-rdma@lfdr.de>; Tue, 20 Jul 2021 05:47:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237423AbhGTDGv (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 19 Jul 2021 23:06:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347993AbhGTDGI (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 19 Jul 2021 23:06:08 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A7A5C061574
        for <linux-rdma@vger.kernel.org>; Mon, 19 Jul 2021 20:46:45 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id ga14so32236495ejc.6
        for <linux-rdma@vger.kernel.org>; Mon, 19 Jul 2021 20:46:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umich.edu; s=google-2016-06-03;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=o0Oi5yeeWeGPgJQbTSByp+d5PJJY97BlVbPr1WmtPR8=;
        b=Db/LJWqrz03TiqTB47MZ0JbwBBHDetv5/b1V64csKlMliqO6AUd2JOrjP0QYnjYZyO
         LeoWyHqk6DgbzppALqmm9yLFF7rcUYHYGkhoxKB2Oul8PH7jBpa3E6sml5HQ7xwB7+pP
         7V+XFhQWfttbXOs1TuIKZXf4/4NMG2JtAdrYit13vfTITL9cV60sPGjWH5rB+JxKjVi/
         ennocwV1CQrh3RWiLg6wqPoRajk99DUYGwA6HJdzhEDhnK61T5IhxpxVAUPSvGoHIdAg
         Bl6jq/+5rG8g4u5YzXadxdbgHypN/utbzGFrVRObqehsBXTjrmWc6bqoinw11AorDjFe
         Y3IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=o0Oi5yeeWeGPgJQbTSByp+d5PJJY97BlVbPr1WmtPR8=;
        b=JPLW/cbTSOiSVgMwH+UGIoPHu3Bw7S8kkvV1TBKKXhMb7/1+7kWTZgW/PrSbHY2g/I
         pNAnVc1eGUsmY9j3SjHE9Wj7BhsYQaG9e3HVbFgi/MiG30byPUZIszMOA6NMV4lggBWh
         J3IXYIJjR5eZrm770IdZrJL9EvON8SZbXuTYX7BxQFtU6BStqV+Nb8bQ6xEx3BYqapq8
         0nLFtV/xMIX2YbBywfKsc/CnDZsmSxhxaRg0s1ngghccme3nSWI82Xt7O9+1SLLS4Xp0
         Atb1irXawToEc4rgz+ebt+xexENX4gNdOA09SMm9WivEEGZt4rtw2VsSFm8DTrVyrq8X
         orlA==
X-Gm-Message-State: AOAM532l5U/kGO5nKvp8Ht/emVlMr+P4S5DHWcN1jd1Q3RX2M/3JrvqY
        a8SCjLmrv+kTC9M01++rnfmtfr7CCfMa4QTymPs=
X-Google-Smtp-Source: ABdhPJxZ21HEwW57s2C7d/vYDL5Di+VT4Z3ncyQ4mdEDIyFDP6Q0YvZy3DYZ2tDJlOjetsdPxgxlTIgh2SC3aQCK9Xc=
X-Received: by 2002:a17:906:dfc2:: with SMTP id jt2mr31686464ejc.388.1626752803619;
 Mon, 19 Jul 2021 20:46:43 -0700 (PDT)
MIME-Version: 1.0
From:   Olga Kornievskaia <aglo@umich.edu>
Date:   Mon, 19 Jul 2021 23:46:32 -0400
Message-ID: <CAN-5tyGbmTjiT+nxXB7BMp6mwpUs+HVUGy-CGXBBrC04jQ3grA@mail.gmail.com>
Subject: RDMA/rxe is broken (impacting running NFSoRDMA over softRoCE)
To:     Bob Pearson <rpearsonhpe@gmail.com>,
        Zhu Yanjun <zyjzyj2000@gmail.com>
Cc:     Jason Gunthorpe <jgg@nvidia.com>,
        linux-rdma <linux-rdma@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Hello,

I would like to report that the rxe driver got broken some time
between 5.13 and 5.14-rc1 (so basically the last git pull). It's not
just NFSoRDMA but simple rping doesn't work. I believe I found the
problematic commit: 5bcf5a59c41e19141783c7305d420a5e36c937b2
"RDMA/rxe: Protext kernel index from user space"

Server side logs: "rdma_rxe: bad ICRC from <>".
