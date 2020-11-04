Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 748EC2A703E
	for <lists+linux-rdma@lfdr.de>; Wed,  4 Nov 2020 23:09:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730581AbgKDWJN (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 4 Nov 2020 17:09:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726777AbgKDWJN (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 4 Nov 2020 17:09:13 -0500
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47E8DC0613D3
        for <linux-rdma@vger.kernel.org>; Wed,  4 Nov 2020 14:09:12 -0800 (PST)
Received: by mail-ej1-x629.google.com with SMTP id 7so112434ejm.0
        for <linux-rdma@vger.kernel.org>; Wed, 04 Nov 2020 14:09:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=ztRHgsFTPgRlcr5rfK8E+n7uUjHKNXrGWVBi+oJkqYM=;
        b=ENWL4FHRXEulrnP8bzdCix0KHJS7+JrFweDO9pRc3AbR+c6GPB0M72Xbl2+9PCKCh3
         ttr4bP7qqU7Pnd+YnlJSmBvcp13xNxk522wsEkwPug2QCKUoAYJEiL3/0FxiwGbZiItw
         SazCyAKJIeWQXLpb0UoKSO6DdvbAGJtA/u5OPlsqx722NeQZd0KF9qpzN9PdjOtlKwh8
         5JWNXBn2NGwVVc26YnO0pnskMyp9g4H9s2zuEMKK1g571WWz5bOUvuggj/42TtjMzAb9
         PyE5c1+z05QQu6mJaAUfwqTJ+i3qewJg54lOu4lSCu81iGZhnCWeJwpYkNut5dIhIJbm
         crFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=ztRHgsFTPgRlcr5rfK8E+n7uUjHKNXrGWVBi+oJkqYM=;
        b=L0JFy4OMgKYNnQEUE16YbRTK2sWLLxWhIlKnDY7LMmE2ZWkJzi4Fyz/HszS4ItaFFt
         06oG1VaK1edNCYC2RTbhRtuI89xVFB4VyHWt8xJZW8+oODlWItocw3nBem6MlVSlQTK2
         ASnfcX/1QISeW9QEsXVZmyB2Yf+VXCrshQh/J013XOTA/f0/d9NxbQbD49Pa8ajrCDvU
         VDbTIqdrNBcOjgTkLFlrekegTzBsf0vpyZdc8XhEfReq3inHMYPcfXpWISK49ZRP4KiH
         Kl8Oy6Iq2IcHpUBPWeKoGkDMXJvqyjKZgLUz65sBAqLYD9rnPfcoVKpAzO0c8GpRInk4
         1WMA==
X-Gm-Message-State: AOAM532lFNLfVFnFUQumse1w7AWj+ejusXyGWJ7+xtg0FIr2lFIjU0a8
        jrlKNgKIzHHMe6zabPgpz8e1rNSEnORKabmldW/bIlLzbbA=
X-Google-Smtp-Source: ABdhPJxUrR54UJ9tHuYxHZP/u4jtc7dn6ttEHHAq0npK8JNYRLcnl1KlzzNaOFSYMRIzECSmuUUxX8DODEYbHz7mAt8=
X-Received: by 2002:a17:907:c14:: with SMTP id ga20mr190016ejc.526.1604527750600;
 Wed, 04 Nov 2020 14:09:10 -0800 (PST)
MIME-Version: 1.0
From:   Ryan Stone <rysto32@gmail.com>
Date:   Wed, 4 Nov 2020 17:08:59 -0500
Message-ID: <CAFMmRNx9cg--NUnZjFM8yWqFaEtsmAWV4EogKb3a0+hnjdtJFA@mail.gmail.com>
Subject: Race condition between cm_migrate() and cm_remove_one()
To:     linux-rdma@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

I believe that there is a serious bug in drivers/infiniband/core/cm.c
that can cause kernel memory corruption.  The problem arises from the
interaction between cm_remove_one() and this code in cm_migrate():

https://code.woboq.org/linux/linux/drivers/infiniband/core/cm.c.html#3968

As I understand it, this code swaps the values of
prim_send_port_not_ready and altr_send_port_not_ready when we fail
over to the alternate path.

In cm_remove_one(), prim_send_port_not_ready and
altr_send_port_not_ready are set to true for every cm_id_priv
associated with the client being removed:

https://code.woboq.org/linux/linux/drivers/infiniband/core/cm.c.html#4478

I see two problems here: first, the two functions hold different
locks.  This means that we can lose a write to
prim_send_port_not_ready or altr_send_port_not_ready if it happens
concurrently with cm_migrate().

Second, while we swap the values of prim_send_port_not_ready and
altr_send_port_not_ready, the associated cm_priv_prim_list and
cm_priv_altr_list lists are *not* swapped.  I believe that either bug
can cause a subsequent call to cm_destroy_id() to write to the
cm_device that cm_remove_one() has already freed, potentially
corrupting kernel memory.  The issue is the two list_del() calls here:

https://code.woboq.org/linux/linux/drivers/infiniband/core/cm.c.html#1103

If we lose the race with cm_migrate(), then then the list_del() call
can happen when it should not have.  Alternatively, if cm_migrate()
has been invoked an odd number of times for the cm_id_priv and only
one of the prim port/altr port has been set to not ready, then
list_del() will be called on the wrong list.

I'm not very familiar with this code so I'm unsure of the best way to
fix it.  One approach would be:

1) Hold cm.lock in cm_migrate() in addition to the cm_id_priv's lock, and
2) Also swap the contents of the two lists in cm_migrate()

If anybody could give input on my analysis and the proposed solution
I'd really appreciate it.

Thanks,
Ryan
