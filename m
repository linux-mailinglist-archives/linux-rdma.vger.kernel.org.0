Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2315A15F95A
	for <lists+linux-rdma@lfdr.de>; Fri, 14 Feb 2020 23:23:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727566AbgBNWXe (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 14 Feb 2020 17:23:34 -0500
Received: from mail-pl1-f176.google.com ([209.85.214.176]:40098 "EHLO
        mail-pl1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725991AbgBNWXe (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 14 Feb 2020 17:23:34 -0500
Received: by mail-pl1-f176.google.com with SMTP id y1so4225748plp.7
        for <linux-rdma@vger.kernel.org>; Fri, 14 Feb 2020 14:23:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pensando.io; s=google;
        h=from:content-transfer-encoding:mime-version:subject:message-id:date
         :cc:to;
        bh=T9pgMlJG/LZE1ldA70Gnf5zlFsbvDsmcwT6WuHYtAio=;
        b=Seva58tLFPHOJoBJlz0x0/TYr8LS4OPJme97BQFGj9+Uud8WgXrNU3oyO8CcHZwtrz
         xO5SvBBkMRBxKkkiQFF6n8NmNQKuv1zp6KC2ipK7fhs2J86A/vH2MYWGYpuVX+QryfIZ
         pXc67NielBVGqpyexHGjueD1FoRrV4mGljYU1aXa2baQnZCXK62zdBVXA44ojMqlx5jC
         1wKlgwDvOkcpd/pGYXAHGNn5i7MfSofj6w9HS0GEm8Qm+ZCP/Eifj8mqMgQn85jXFDEC
         fUYZxiePq9ev/Wyai9uDDuJHpinXSg6LZw11/tgQcZ5g1WI6IsF1m/fFE4M105jlYuwO
         dXDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:content-transfer-encoding:mime-version
         :subject:message-id:date:cc:to;
        bh=T9pgMlJG/LZE1ldA70Gnf5zlFsbvDsmcwT6WuHYtAio=;
        b=hHniLbo+yiaxmcGkFiineqUX+7425/FREBCbChR1m+HnwEmjKQqAnM4CLrhFaVD7xK
         mtX+y8PGw1CkvS4inAGymfZnIDizt9/IXeCnL4vf5RaQTTtfrQfPfzDT7z4v9lOnjIKU
         kmHgRJdJLJXfEt4Rp1ufhyikCASyXnNSpg3UPi/Q7NLKTE122My/mGTQrV4SwRrNDMgE
         5u9UtmOmnZuCrWTjqdn8X7IJ83GMhU2RezM868UC/P1pQL8BIM6+979sNWTqcRrecRpt
         z2N8bK/lXWJVy4qCBvzUW8HVJz+3gJmlB0QYNpOzXr0m0oBhhRhLx4dvW52yQnNWRUAA
         XqEA==
X-Gm-Message-State: APjAAAXODftyj3N9f+3ivd0LZPRHoVRpNqYFlMP3gR4GtRtPYodPfjNP
        HVgRQAm1Echxaapw+jeEEgX5O0c7xfA=
X-Google-Smtp-Source: APXvYqxhLC6NZtSFisGbPwzGPCHGHrvvWMqrdj7t9sQOD7z0vXPzUSJrlfT7Z+flwe1fmETohBKT6w==
X-Received: by 2002:a17:902:aa04:: with SMTP id be4mr5623103plb.41.1581719012943;
        Fri, 14 Feb 2020 14:23:32 -0800 (PST)
Received: from [192.168.4.6] ([107.13.143.123])
        by smtp.gmail.com with ESMTPSA id e18sm4876466pfm.24.2020.02.14.14.23.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 14 Feb 2020 14:23:32 -0800 (PST)
From:   Andrew Boyer <aboyer@pensando.io>
Content-Type: text/plain;
        charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Which print functions to use during early device create?
Message-Id: <7A6D8934-9D25-4BDF-BCBA-B37CAA064677@pensando.io>
Date:   Fri, 14 Feb 2020 17:23:29 -0500
Cc:     Allen Hubbe <allenbh@pensando.io>,
        Leon Romanovsky <leonro@mellanox.com>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>
To:     linux-rdma@vger.kernel.org
X-Mailer: Apple Mail (2.3445.104.11)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

When we get a NETDEV_REGISTER event, we get a pointer to the existing =
struct netdev. If all goes well, we end up creating an associated struct =
ib_device.

How should we log an error that happens in-between, preventing us from =
creating the ib_device?

netdev_err() on the ndev?
dev_err() on the underlying struct device?
pr_err()?

Thanks,
Andrew

