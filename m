Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E25A74B03FA
	for <lists+linux-rdma@lfdr.de>; Thu, 10 Feb 2022 04:34:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231208AbiBJDd5 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 9 Feb 2022 22:33:57 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:57938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230059AbiBJDd5 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 9 Feb 2022 22:33:57 -0500
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com [IPv6:2607:f8b0:4864:20::b2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D501523BDA
        for <linux-rdma@vger.kernel.org>; Wed,  9 Feb 2022 19:33:59 -0800 (PST)
Received: by mail-yb1-xb2e.google.com with SMTP id c6so11716470ybk.3
        for <linux-rdma@vger.kernel.org>; Wed, 09 Feb 2022 19:33:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to;
        bh=8JEg4KhFuqPQuTfH7upjqAwnqtPRj7eV8IyPDasMO4w=;
        b=cL4Thhpwq+RpQG0SSyBhKd0Gf/sNYNgVjGj6zBRjf2E4c+MT6QwDoRvx/pEBeyOKDm
         +XM7U2pA6izFIp/vrZQSKUTB87Axrhu9Z/U4s2kIhV2IY3lLUQUFk14h6mqVH6FZ8con
         C82ei1LNLkEKvzYcId17oy7c6+kJWOdXhrwMligfE0RlR7Pj7FonjXpHJkvKPKjLZ0Gm
         K2hnV/XpPCwYQxNG3oHQBJlGvM7Yk5WCo+PgNMXIWCH1zD+VP7dYBwTDwx8sek+Gx+Yk
         qtDNXKcgREox61s7xto7F3RMLEpLZpQzYhonColyv84yICvF1A82dYPBwdV/p33PMPib
         bBtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=8JEg4KhFuqPQuTfH7upjqAwnqtPRj7eV8IyPDasMO4w=;
        b=zmzrzxUnElfJcqHRy2bPxLx2qh5qPNm4uMPeFuPxbyNre2puNSczlXFwbGgVZD6nF7
         XZV6YxW1llO//fgb+s75qkWkommLmqvh2RPj8UttGzG/56SBlhwxyHbTrjsi/QhEXlLK
         8m8SDUYYsAgyyzJahuh9r3dHpNdiDABAJRSmxqDS+PjYc4RIqVYqGzmrK98Ki5O/D9D7
         44Ez21otppsuKTc2XIj+oabXcwRlzENAxyQ9/YplBQCmT8AQ1jPn1gjdMEOy6Y1QFOYd
         xR2iIGKJZQOC9fN3dYhJPa2aGXlezXBmHST63m7RnaInkgh7iKsQ5JcEj/2+pADcTysT
         iB5Q==
X-Gm-Message-State: AOAM531wmhy4v9utmG51RsXd2snIIu7hAu9SLeC9Jh0O2btZSk/uW0d2
        8mwSr7/vzPtpNlwaSiPLNr9uvBzBvUVkV9pI7ZNbZTyfyvw=
X-Google-Smtp-Source: ABdhPJwMBnEysyp8kh1ckMhol7vBoPqa21DnfWGvnDGUPJEwfJcwuz7euhFELiUBw1K/xqvwkIi9WmIw8oXpdkYSCwA=
X-Received: by 2002:a81:a847:: with SMTP id f68mr5389913ywh.433.1644464039050;
 Wed, 09 Feb 2022 19:33:59 -0800 (PST)
MIME-Version: 1.0
From:   Christian Blume <chr.blume@gmail.com>
Date:   Thu, 10 Feb 2022 16:33:48 +1300
Message-ID: <CAGP7Hd6PAYcX_gMMh8jbpezeSSWQxqDrYwxEq1N-zjgT7563+g@mail.gmail.com>
Subject: Soft-RoCE performance
To:     RDMA mailing list <linux-rdma@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Hello!

I am seeing that Soft-RoCE has much lower throughput than TCP. Is that
expected? If not, are there typical config parameters I can fiddle
with?

When running iperf I am getting around 300MB/s whereas it's only
around 100MB/s using ib_write_bw from perftests.

This is between two machines running Ubuntu20.04 with the 5.11 kernel.

Cheers,
Christian
