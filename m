Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5593514DE52
	for <lists+linux-rdma@lfdr.de>; Thu, 30 Jan 2020 17:04:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727193AbgA3QEC (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 30 Jan 2020 11:04:02 -0500
Received: from mail-io1-f67.google.com ([209.85.166.67]:41884 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727186AbgA3QEC (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 30 Jan 2020 11:04:02 -0500
Received: by mail-io1-f67.google.com with SMTP id m25so4574455ioo.8
        for <linux-rdma@vger.kernel.org>; Thu, 30 Jan 2020 08:04:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6+jCj7nQiNRZWztjUxZxioqPtRk479WFgapuSteClcY=;
        b=HpDbLssJx4ugJtEvD4I2QmvpjfDDN2Ck2vF1KcG66XxpR14Nfc51zSWqFpQhjGPtkd
         psZ+AXZdkUaiVkRZx8l3NZ6e7pC2edi05DoCdhvLlNR5MIOpO7xvRYWexZ9axOokYOK1
         vqXTmMsHfZn+wEGlwRQ1dnu8Gd6oDrntOI//o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6+jCj7nQiNRZWztjUxZxioqPtRk479WFgapuSteClcY=;
        b=i+78Gn06aEPeHU3Tq7xB2CY5IY2b3BHjWjIoQroAxJ4BZGf5iBS5VNErHOS4HW+5zJ
         EVqvW/xAxXn4B0EzzZZpqLBO3ixWFsO1xPT3oy5UwVvu4CGMQ9oIDBLFu5r1Al8trRmd
         PDb9k45BlkKeiGn9GCtFZk3r5uhYUB0D/d1qJDcCkzAr8XxdDdB952gelNapnIz5cCAn
         XEUym092sNZ7pQB57GlVc8bLyJ3YgprGjv+I35CHpBsUHewQGxYgOfOHGh7qx9U0yEEk
         cbkJnejL9P8fg2HMQso3pXUljtd/85PrKwUYV13aVFwxUoj8kYdz6zahu19WnwVp8mP6
         hygw==
X-Gm-Message-State: APjAAAX8xY/+d76mZg5lj60cC6jwJhwZkoNJ7FxpbMsGLDLw3+jm6l0W
        JRz6Vqfnv5C0ll6ACExkU12iBOx2kgF/3X+6Fh7Ryg==
X-Google-Smtp-Source: APXvYqyW0eXSpb/E57lvAYwyHa0OeX4oTmwVMmK9m+v/UnsNZ+ipjTccTPLQz3nPraKG49tbIq7RmIkRIRb2VUyS7JI=
X-Received: by 2002:a6b:7113:: with SMTP id q19mr4767064iog.87.1580400241691;
 Thu, 30 Jan 2020 08:04:01 -0800 (PST)
MIME-Version: 1.0
References: <1579845165-18002-1-git-send-email-devesh.sharma@broadcom.com>
 <1579845165-18002-2-git-send-email-devesh.sharma@broadcom.com> <AM0PR05MB48669BE3D4E5939ABFCADA1FD1040@AM0PR05MB4866.eurprd05.prod.outlook.com>
In-Reply-To: <AM0PR05MB48669BE3D4E5939ABFCADA1FD1040@AM0PR05MB4866.eurprd05.prod.outlook.com>
From:   Devesh Sharma <devesh.sharma@broadcom.com>
Date:   Thu, 30 Jan 2020 21:33:25 +0530
Message-ID: <CANjDDBhO_VmZrXu_U8svXD75zvC5hHE=mcg3mr+0SAXFC14f7g@mail.gmail.com>
Subject: Re: [PATCH for-next 1/7] RDMA/bnxt_re: Refactor queue pair creation code
To:     Parav Pandit <parav@mellanox.com>
Cc:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Jason Gunthorpe <jgg@mellanox.com>,
        "dledford@redhat.com" <dledford@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Jan 30, 2020 at 7:08 PM Parav Pandit <parav@mellanox.com> wrote:
>
>
>
> > From: linux-rdma-owner@vger.kernel.org <linux-rdma-
> > owner@vger.kernel.org> On Behalf Of Devesh Sharma
>
>
> >  drivers/infiniband/hw/bnxt_re/bnxt_re.h  |  13 +-
> > drivers/infiniband/hw/bnxt_re/ib_verbs.c | 635 ++++++++++++++++++++---------
>
> [..]
> > +
> > +     /* remove from active qp list */
> > +     mutex_lock(&rdev->qp_lock);
> > +     list_del(&gsi_sqp->list);
> > +     atomic_dec(&rdev->qp_count);
>
> Atomic inc/dec/read should not be protected using qp_lock mutex.
> Please take it outside the critical section in new refactor code and in old one.

True, will change.
thnx
>
> > +     mutex_unlock(&rdev->qp_lock);
