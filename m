Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CD666E2EAB
	for <lists+linux-rdma@lfdr.de>; Thu, 24 Oct 2019 12:19:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407546AbfJXKTU (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 24 Oct 2019 06:19:20 -0400
Received: from mail-ed1-f53.google.com ([209.85.208.53]:34030 "EHLO
        mail-ed1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2407344AbfJXKTU (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 24 Oct 2019 06:19:20 -0400
Received: by mail-ed1-f53.google.com with SMTP id b72so9248665edf.1
        for <linux-rdma@vger.kernel.org>; Thu, 24 Oct 2019 03:19:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=message-id:subject:from:to:date:user-agent:mime-version
         :content-transfer-encoding;
        bh=uIkiLurxAG15B3r6RxO2ycm67eznuWcRvb08KCsAuRM=;
        b=Lb9CnPqmaM7ZTnrwqi/T9wxqB2y2znvxCc2JVIBLBINY6beXKa+nW1MSdxba7ughjl
         5oCtcCOEVhGreYJUUDHdCC646I3fbqcOCmMBxgM3MJhflbVI43u209PcajR24bVqjpg4
         jtLbXT/oTJMTxHV2T1Pa+P+Tqp5xuWyRp5L5/LpusWKHQD9RQG8G/mdf5RT2Hk2CM4PP
         s3JtiFahnCSEtfH99psn14tg6zGfAZ5/+oJnx/EeVNQ9DF0SbH490b85cG+nBGx+NjYV
         tgifhjySURVq57mRoyZFAeH4xqM04idnXn8k7Nbc3qPp6KhtTlU8mqyg8ThhE0HEj/Ye
         hZVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:date:user-agent
         :mime-version:content-transfer-encoding;
        bh=uIkiLurxAG15B3r6RxO2ycm67eznuWcRvb08KCsAuRM=;
        b=FxkNgkRfzganPzePh7VCKPouEs5dFq9+1/9vddv9uOau4LbxpdyK3jzCY2xawKSlu1
         ZcqhO1qXcKPrAfN8fhyWEyffx0kooSz1mKIVQge5LeKT9inxcZb07zCM/ywpUC8LBeXZ
         Wvr8YpWgi89rWnUWhjGoyF4RYU5my+KnyjkYXupAEiiTbiIpbMNZiIxxLuEuVyUAQGNS
         opsRUAkwLTQOyXdTixIH0I3oVkf8EQjqmIpmLPtHI11HaV9kuBXPrQrH1AkNGls27iX5
         QFv89/sc22JhU/dai56GNUqmAaVY7+zRU8qaRkEWIddweKsmy40V9rid5hwN4yiDLXwV
         98qQ==
X-Gm-Message-State: APjAAAXbdspbqXyBy1U4Ra6C9Zpg928rTao/tFg3xdXlmPeq9xSUQkT5
        G/A8/FmABlyiXaHgVzc3HOH+IbMBYDo=
X-Google-Smtp-Source: APXvYqxlt/yEyuQiXiFnhovdpRGtsvZr6u9PG0SqAv0LVehCNmZNgCDnX8WYSkkgm6sIsY1ZuMwWow==
X-Received: by 2002:a05:6402:8c9:: with SMTP id d9mr30530364edz.16.1571912358259;
        Thu, 24 Oct 2019 03:19:18 -0700 (PDT)
Received: from fiftytwodotfive ([2001:1438:4010:2558:9033:8018:ecb0:7d65])
        by smtp.gmail.com with ESMTPSA id i63sm845581edi.65.2019.10.24.03.19.17
        for <linux-rdma@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Oct 2019 03:19:17 -0700 (PDT)
Message-ID: <41d360c7e2a6db457f3d139a1b35507bc62ae321.camel@cloud.ionos.com>
Subject: srp_daemon and ibacm in wrong man section
From:   Benjamin Drung <benjamin.drung@cloud.ionos.com>
To:     linux-rdma@vger.kernel.org
Date:   Thu, 24 Oct 2019 12:19:23 +0200
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Hi,

srp_daemon and ibacm are both installed in /usr/sbin. lintian complains
about command-in-sbin-has-manpage-in-incorrect-section:

The command in /sbin or /usr/sbin are system administration commands;
their manpages thus belong in section 8, not section 1.

Please check whether the command is actually useful to non-privileged
user in which case it should be moved to /bin or /usr/bin, or
alternatively the manual page should be moved to section 8 instead,
ie. /usr/share/man/man8.

Refer to the hier(7) manual page for details.

-- 
Benjamin Drung

Debian & Ubuntu Developer
Platform Engineering Compute (Enterprise Cloud)

1&1 IONOS SE | Greifswalder Str. 207 | 10405 Berlin | Germany
E-mail: benjamin.drung@cloud.ionos.com | Web: www.ionos.de

Hauptsitz Montabaur, Amtsgericht Montabaur, HRB 24498
Vorstand: Dr. Christian Böing, Hüseyin Dogan, Hans-Henning Kettler,
Matthias Steinberg, Achim Weiß
Aufsichtsratsvorsitzender: Markus Kadelke
Member of United Internet

