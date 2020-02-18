Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E7372163387
	for <lists+linux-rdma@lfdr.de>; Tue, 18 Feb 2020 21:53:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726384AbgBRUxs (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 18 Feb 2020 15:53:48 -0500
Received: from mail-pl1-f169.google.com ([209.85.214.169]:46541 "EHLO
        mail-pl1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726383AbgBRUxs (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 18 Feb 2020 15:53:48 -0500
Received: by mail-pl1-f169.google.com with SMTP id y8so8541660pll.13
        for <linux-rdma@vger.kernel.org>; Tue, 18 Feb 2020 12:53:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pensando.io; s=google;
        h=from:content-transfer-encoding:mime-version:subject:message-id:date
         :to;
        bh=rt8nqvPfYHq39j2Y20lly/4AkMN02so+u7ebskNYDm0=;
        b=FLBIXMV25Rsa7th2mLIwK8OK32lR44DN192vcCc0l5XCXD1/Me6AVcrZBg1qNiQ/R2
         S4HmVNgECLFKzsJyJJ9n8Xkvn6oEfFhTU241Pz2j0m1HqIwtdxWRgXKa/ovclZ6t3iSp
         9SuScOuMJwbkEt7KCJBCyYdjHCXsD3b5yoLBLks+kmoIQtDKTcnWN5WL1ze270ogt2Qf
         NxQETVak9HiVQzLi2RccKtydcoyIegGzveS06K6xagoaBzDIcdYRmOHGbdsHiNjqK5LP
         1/+ewiDnLhb+wIt4RI8K2QZlsBrMu0DNcXgoDpdruj0YvW42EemmPSFMDPXuEjW8MW5Z
         yzwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:content-transfer-encoding:mime-version
         :subject:message-id:date:to;
        bh=rt8nqvPfYHq39j2Y20lly/4AkMN02so+u7ebskNYDm0=;
        b=b8vHGOzpVadQhUNwTSQfWuW/COh7kWIKMnQQa7qgcHWOPql/6nU6VE2BMSwyslL32l
         yhvCjG+D+ECpI2A7a1bLJOuPpyH44vkiM8yN5kJz/NbQRbm75Vy41K4/G8YWs7WLXHJt
         04uccjkCBSu4tPWU0kWsZE+98R71MZjB89mX7Fs2XIF9TvbyX3Z7DM3K2g0x1WiJ2iR/
         SbEwpCkBMUhoT0C3+kZteDyjyvtvZfL0GHXMxZcUNqlvTb81bCROdR7gdsnL9fzInm5P
         9z2uPHsbCjK+R8n7IbEsuddJwklk0OIWkbsPPeDPQncIUwfENqALZoucDAgYMoN/f4em
         ww2w==
X-Gm-Message-State: APjAAAUQiitM/Vth1BD8tDkaxZpo0/VSL94Mx253/AnM0Jd/mS74wo+I
        eJ92A1Dqt9KAHcojRnl/rDie4bdI95M=
X-Google-Smtp-Source: APXvYqwpa88CRzbrYktn1vug17pBO94ru+AMGcYExEo3Sd+SrTZ+Uu2gHf3CJQTWhyX+mO47rtgQNg==
X-Received: by 2002:a17:902:8c94:: with SMTP id t20mr22401955plo.170.1582059227806;
        Tue, 18 Feb 2020 12:53:47 -0800 (PST)
Received: from [192.168.4.6] ([107.13.143.123])
        by smtp.gmail.com with ESMTPSA id 200sm5192993pfz.121.2020.02.18.12.53.46
        for <linux-rdma@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 18 Feb 2020 12:53:47 -0800 (PST)
From:   Andrew Boyer <aboyer@pensando.io>
Content-Type: text/plain;
        charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: May we create roce_ud_header_unpack()?
Message-Id: <ABA12A9D-D4F4-405C-BEAA-BDBF33D50488@pensando.io>
Date:   Tue, 18 Feb 2020 15:53:45 -0500
To:     linux-rdma@vger.kernel.org
X-Mailer: Apple Mail (2.3445.104.11)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

There is an ib_ud_header_unpack() in core/ud_header.c, but it has no =
consumers.

Would I be allowed to add a roce version alongside it?
May I do that now or must it wait until a consumer is ready to be =
checked in?

Thanks,
Andrew

