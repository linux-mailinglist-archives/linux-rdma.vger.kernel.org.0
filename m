Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3B3A518A8C7
	for <lists+linux-rdma@lfdr.de>; Wed, 18 Mar 2020 23:59:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727231AbgCRW5r (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 18 Mar 2020 18:57:47 -0400
Received: from mail-ed1-f47.google.com ([209.85.208.47]:45685 "EHLO
        mail-ed1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727350AbgCRW5q (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 18 Mar 2020 18:57:46 -0400
Received: by mail-ed1-f47.google.com with SMTP id u59so178380edc.12
        for <linux-rdma@vger.kernel.org>; Wed, 18 Mar 2020 15:57:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=imatrex-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:from:date:message-id:subject:to;
        bh=LrawvO9SKelHeBqWG3UxYxrUpUZJPSeMgUg+gUx01to=;
        b=RNbukeWfLdeqdEZxbA0yYQaWfQ/5wivMNrAS5Hm7UnyfG+fVfzHPlUxUacJuQGmgC5
         EG4WBP7aqvgwdUToqiY1NEZqZBQfSIKu9edSOUn9alSI9UtcIkBTXGUv4O8llFROCLAh
         o1ImGrqXv22NdJC8YoBQ2nZQmG/X13OdHNGYBgEWcSGzJyPXC5gFB722S35uuaAWgsCh
         7a4a0/Ng9rjusoxEkWaoWejm6FPZ/u2ak2qawTV30vq3td9a+7xcmUGTeoUwFCQYAx9C
         VfRM6FUpFQMc+5zdDDTDFvsnoA6HMXRF12PlYlqxOxPArrcrry4aK36lI0c1LgDEJVJr
         x1UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=LrawvO9SKelHeBqWG3UxYxrUpUZJPSeMgUg+gUx01to=;
        b=TbC9/pRb8gKDsYUhlXiy8dJXb/cujgvyk/U//vuKbV5oqqtDhiW1+VCj0nPjEsqFMd
         4qgUwYwZndx99xfNnlfC5FJgwuDyDAP1hVEXao/6hgqJz6+++Zt3fqYV7uqckJuhTVsp
         0UJ2Xgtl+OJz++LayaPm/nGj+QJsZfyLCZXvX1vnt8RjxHmyRIP7VCVTXAgiKTc+z/S+
         6QgKn5VZ7Sn5oBGB7u+8R/zGDaBWVo0DwFul89m0jqLOPlP5ko9kaqLZFUQ+oVZgGMCq
         OEFHzD8RMB/6X1NMuG/6yRbarYwJ6wAETpo/vpT61O4uXTA9cnoJupnGpRro20+DIpKN
         7Uww==
X-Gm-Message-State: ANhLgQ1tImSe5EFMHc74kYB7b3TyIFeFAKpQiI6RdLPAftILedCo6KQ9
        +hZ/XTYCsb6xhNRfWq7AkiPgQchs41sDqLAijyU2N1dp
X-Google-Smtp-Source: ADFU+vvmQB++P9bb8F2ring4vhrvwR3uBVubMfNMDBNeMFY/Q02wr3e6ueOmFBAmGo6Puysawx3yN6Nz7lYLemIl4/E=
X-Received: by 2002:aa7:d14c:: with SMTP id r12mr6566824edo.17.1584572264961;
 Wed, 18 Mar 2020 15:57:44 -0700 (PDT)
MIME-Version: 1.0
From:   Dimitris Dimitropoulos <d.dimitropoulos@imatrex.com>
Date:   Wed, 18 Mar 2020 15:57:33 -0700
Message-ID: <CAOc41xF2xRfSpZDn-XRA=R+SegMJTPU6GJe6_6q=0j4=a-Bw9w@mail.gmail.com>
Subject: RoCE v2 packet size
To:     linux-rdma@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Hi,

In RoCE v2 there various options for the protocol packet size: 4096,
2048, etc. To what does this number refer to exactly. Is it the
payload that ends up in the QP buffers, or does it include headers
some of the headers as well ?

Thank you.

Dimitris
