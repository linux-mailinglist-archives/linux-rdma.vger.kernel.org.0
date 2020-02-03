Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4D016150635
	for <lists+linux-rdma@lfdr.de>; Mon,  3 Feb 2020 13:31:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727112AbgBCMbX (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 3 Feb 2020 07:31:23 -0500
Received: from mail-lj1-f171.google.com ([209.85.208.171]:40734 "EHLO
        mail-lj1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726082AbgBCMbX (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 3 Feb 2020 07:31:23 -0500
Received: by mail-lj1-f171.google.com with SMTP id n18so14402896ljo.7
        for <linux-rdma@vger.kernel.org>; Mon, 03 Feb 2020 04:31:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=W83QQkdDwCkH6NXrphcTCLQ98r+bucRvvHFHjXHQt6E=;
        b=eER1J+TVpg9jVbmyveoRGfJwcG5is0ty15TfPwLnIJvB+p6p9iNS3eO04BA4TxhZ8w
         qN/c97cmvVrB5UUYovVBByiS/4yP+6WI3sVl2q2zjHD7wrWwIlIBpz/3bFvaWQe34iIL
         FhXN+TFlDpjB5ybdEOAyJS80S6H+b/uuytZ/zDO/IrUrGZJoWTEU51eYIQsfHY++JrNu
         h9RxzRgXG8a+qTWlahz0dyjV+URjwA8bdHVAvQfjF60GURjsPskepRYI6l9NdkZ4v2YE
         5I5UpgF6RLw13FPCEwc4p+hgo+yczL80DPOJXeVALhRis2jAxhiQO9mB545yo39f15jz
         L4YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=W83QQkdDwCkH6NXrphcTCLQ98r+bucRvvHFHjXHQt6E=;
        b=feDNJc6aDIPpDA1Xb966QAtn32HduUkpdsATn/XbjIRO4piVlty8jOmTtZUj2mMjlD
         FdlwVmsesK0DIxWgixN7DH21+ld26BWZ2qUfQVqbisjIz7rcDJl/G3/uZuQ0Z8tPXEo3
         8rOs6wWNZ1Xr9tALGouX8AlbfBHMzpQU3xciJFya3oI6OK9pJCV3CNxMV49vilSaEUsG
         VOzv4Y268ueH2tZrze/En+iKxWgKoIFmwy0FyOKhmE9efiryoE2x1vnfvlC3zyUWDWc/
         qvpRgZqDHnpalj7MJm+jN2EcPMNfh1zrDhc1ROA3V1UEQTCdyMLnyT5AZLrbu0AF2kfG
         BReA==
X-Gm-Message-State: APjAAAVzEv9WaGntKg0PbOboc5U5ZjA63mdw9QRRHwHksZret36U4fEC
        XfPm/snVP7/xfNlASdK5pp+AeR30uFgvx9BewRdlHTJ2
X-Google-Smtp-Source: APXvYqw1Xp5AGEDaaBHBt3zsXmtcvI8sjL2YRq3mmZyscoGdDVj7NuMH9kKI/bhIKB7bU5FEQE3f7an9h7vA6jm7Wrc=
X-Received: by 2002:a2e:88c5:: with SMTP id a5mr13986287ljk.201.1580733080783;
 Mon, 03 Feb 2020 04:31:20 -0800 (PST)
MIME-Version: 1.0
From:   Frank Huang <tigerinxm@gmail.com>
Date:   Mon, 3 Feb 2020 20:31:10 +0800
Message-ID: <CAKC_zSu1SQgNT5Yyg49qe+r+hux-3oCqzZPvH0b7pjaPz2x2Rw@mail.gmail.com>
Subject: a strange lock
To:     linux-rdma@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/tree/drivers/infiniband/core/cma.c#n1832

/*
* Wait for any active callback to finish.  New callbacks will find
* the id_priv state set to destroying and abort.
*/
mutex_lock(&id_priv->handler_mutex);
mutex_unlock(&id_priv->handler_mutex);

It does nothing between the lock, what 's the meaning of it?
