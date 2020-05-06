Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A7CEC1C71D8
	for <lists+linux-rdma@lfdr.de>; Wed,  6 May 2020 15:41:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728353AbgEFNlO (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 6 May 2020 09:41:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728299AbgEFNlO (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 6 May 2020 09:41:14 -0400
Received: from mail-oo1-xc41.google.com (mail-oo1-xc41.google.com [IPv6:2607:f8b0:4864:20::c41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AB2BC061A0F
        for <linux-rdma@vger.kernel.org>; Wed,  6 May 2020 06:41:14 -0700 (PDT)
Received: by mail-oo1-xc41.google.com with SMTP id c83so488335oob.6
        for <linux-rdma@vger.kernel.org>; Wed, 06 May 2020 06:41:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=0s/BHraXJWKlJAdCewFa7Vl4A5TERdGFSPFNslRhneg=;
        b=oluKC9SrWOdB7udnpGaNLjBRzpzJl0BF9syrOsUyRClk71H4S4XTRFeVfHdPwCCDux
         dmJm/XhqfCm1FvEa+PKeTweUSCDXg872jgzzIl82kexnzb3SfsNpJV8bjGdi1NI1nOto
         gXIufpVHI6jTfQeQ7iQqrMPnGwdnb2DzgF1KGIq/vyn1EiDtIDDaM0OZOp7XgxMTUuzt
         8NWtXJVK7tw39VqL+PG2/QOyQGBOlApCE8ekWWRLpvFUXcbWXkCssFxTYoCBSunLcjH5
         dDG7pTEXTdtH8GQvrU5MOjZsmP2FVdw6AvSe9RvoU520yo0m1XCD5s8bEalC9DowAtW0
         KVjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=0s/BHraXJWKlJAdCewFa7Vl4A5TERdGFSPFNslRhneg=;
        b=aQu6jj8DhZMx7uzaunADgOjulyf8XN064SeIybLTyGS57wA33iUK0Oj0ltgKAyIVR3
         UYIHMYV/6mt3fEyrgMmqGa6qzaGMIuLeVOjAheZ2kzEs0HNiutk1xo1oXS5s/1wv/Bha
         zkiAQ9EkgiFJb61+cpRjRpqHe27cXohgaGBbSO6nSUqjIi8IooZ37fE2dmhUcfY+mnxZ
         ybc+q1Npma4Q+oI0inLYVB/VFvNXmISMSlqpoBUeXAZ+HExfD0laVSzutmsMHPo4f6xa
         gSczos86Nz55lggUTbSmHAREAAkpenLxmAb1eWZJzj5FHoVa/9c2Wx4uX8ndsgnEELLa
         3x3A==
X-Gm-Message-State: AGi0PubkG8n4cCg7P4s3Qne0h/F0jc0ZqUnPSdPY+WR7I8tn2mugkVNA
        WrbYE8d8MZAYGfwD0MECkHcwIJt2KbZ7YOKEHnap1scnyQOXxA==
X-Google-Smtp-Source: APiQypJCS3RNCXQaHYpg631hZgH5w06So2ZM8BFDck40qymvkVnFnuXUN+NFco65CaR/8hsr2mAtFXmufwQl7fpnZ2I=
X-Received: by 2002:a4a:e7d3:: with SMTP id y19mr7146587oov.88.1588772473684;
 Wed, 06 May 2020 06:41:13 -0700 (PDT)
MIME-Version: 1.0
From:   =?UTF-8?B?5Lq/5LiA?= <teroincn@gmail.com>
Date:   Wed, 6 May 2020 21:41:01 +0800
Message-ID: <CANTwqXDmq4OdHT=Pk7Xm6JXBp_7kwEBK7JGd=kT9pOE5gx=iLg@mail.gmail.com>
Subject: [BUG] is there a memleak in function qib_create_port_files
To:     dennis.dalessandro@intel.com
Cc:     mike.marciniszyn@intel.com, linux-rdma@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Hi all,
I notice that most of the usage of kobject_init_and_add in drivers are
wrong, and now some drivers code has maken it right,
please see commit dfb5394f804e (https://lkml.org/lkml/2020/4/11/282).

function qib_create_port_files() in /drivers/infiniband/hw/qib/qib_sysfs.c may
have the similar issue and leak kobject.
if kobject_init_and_add() failed, the ppd->pport_kobj->kobj may already
increased it's refcnt and allocated memory to store it's name,
so a kobject_put is need before return.

int qib_create_port_files(struct ib_device *ibdev, u8 port_num,
 struct kobject *kobj)
{
struct qib_pportdata *ppd;
struct qib_devdata *dd = dd_from_ibdev(ibdev);
int ret;

if (!port_num || port_num > dd->num_pports) {
    qib_dev_err(dd, "Skipping infiniband class with invalid port
%u\n", port_num);
    ret = -ENODEV;
    goto bail;
}
ppd = &dd->pport[port_num - 1];

ret = kobject_init_and_add(&ppd->pport_kobj, &qib_port_ktype, kobj,
"linkcontrol");
if (ret) {
    qib_dev_err(dd, "Skipping linkcontrol sysfs info, (err %d) port
%u\n", ret, port_num);
    goto bail;
}
...

bail:
    return ret;
}



Best regards,
Lin Yi
