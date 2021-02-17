Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 32D4831D411
	for <lists+linux-rdma@lfdr.de>; Wed, 17 Feb 2021 03:53:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229734AbhBQCw4 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 16 Feb 2021 21:52:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229707AbhBQCwz (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 16 Feb 2021 21:52:55 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 955B5C061574;
        Tue, 16 Feb 2021 18:52:15 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id u14so15795879wri.3;
        Tue, 16 Feb 2021 18:52:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:sender:from:mime-version:content-transfer-encoding
         :content-description:subject:to:date:reply-to;
        bh=EtgVAmMZmRbpHi/fUwmACsED6bFm70nAWWTosG/q2KU=;
        b=nAw8zVDykvvMh4gtufdKmYdX2NbXJDQ5BwjZsD0CiME7bQZfsi305Da8FouMK5uC8J
         nT54jidnKhjIz7hIWa4T/dcKz7IilwmnbaOtiLXOmQobWon4t1m8tsAA1muAauuS8/34
         NkDIzC4loV/5wG8kFeq2Ts+NZs7bTDYb1Ia/XlNRyrHVBsPSxiO8VghAGtcNKmMVnNDH
         Igvl4gPeeYzf3pbF66vl26WDILNh2yn3jk9ljRic1H3o1QF2YgPuk5Zt+pdpas2rEWNg
         5XbLW2CL4AOoIlO+0X4izEmjJiMObN2vS1jsrgNTApawEHyn90tK7lq4fHu/fC0+WkpU
         fMaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:sender:from:mime-version
         :content-transfer-encoding:content-description:subject:to:date
         :reply-to;
        bh=EtgVAmMZmRbpHi/fUwmACsED6bFm70nAWWTosG/q2KU=;
        b=mu4QndQkKRyzKzbdzmV0WpSauIDEd3RnI75duJMdHlcguQiK14UF+2UwevDtMGBJ7K
         nBsup7v8m5ESmdwy5c7+D5rfHr9xEQlHwdsY7Pfyd0vHtd6e210MsyHyVU5i2d9HpJ67
         gMmXw7SCfoTd3Z47UCSFkbVC8EpPcDpqRYbFtuRG9N+jK3iLAXJ0qgrIjU3MWKsa9TQt
         XVHLidk/gEqt2l3+x2F97P6Hy7TiDrrJJLCAqktNcTrWspGwy0JfSwMQ6a5MUJK8Ao3z
         pgngfGxqXPEvhnZk3z6b7mPdMz2CrKjdTFgwXKh9okEWcbMi7vpfCr0Db9EyfIoXsSpA
         BDXg==
X-Gm-Message-State: AOAM532MePorexp/cRJEsI9TLVEcYLAf00vZzkIUsLIgACNU8DzsU+9Q
        u4MZxs9v9zp14BPjHvPXBf8RMjUBPb8=
X-Google-Smtp-Source: ABdhPJwF5eUCQApSteIJoeOuXGqz/H0MIPeBrJRlpbKXxIIECN2fbdK9792HW2Wn3SYHdX/p9l6OZw==
X-Received: by 2002:a5d:680e:: with SMTP id w14mr23948193wru.322.1613530334256;
        Tue, 16 Feb 2021 18:52:14 -0800 (PST)
Received: from [192.168.1.5] ([41.82.185.62])
        by smtp.gmail.com with ESMTPSA id w3sm1231218wrr.62.2021.02.16.18.52.12
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Tue, 16 Feb 2021 18:52:13 -0800 (PST)
Message-ID: <602c84dd.1c69fb81.ab39.27c3@mx.google.com>
Sender: Anderson skylar <gakoukine@gmail.com>
From:   Calantha CAMARA <sgtandersonskylar1@gmail.com>
X-Google-Original-From: Calantha CAMARA
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Description: Mail message body
Subject: Hi dear
To:     Recipients <Calantha@vger.kernel.org>
Date:   Wed, 17 Feb 2021 02:52:11 +0000
Reply-To: calanthac20@gmail.com
X-Mailer: cdcaafe51be8cdb99a1c85906066cad3d0e60e273541515a58395093a7c4e1f0eefb01d7fc4e6278706e9fb8c4dad093c3263345202970888b6b4d817f9e998c032e7d59
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Do you speak English
