Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8D6CAE72B8
	for <lists+linux-rdma@lfdr.de>; Mon, 28 Oct 2019 14:38:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389575AbfJ1Ni0 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 28 Oct 2019 09:38:26 -0400
Received: from mail-yw1-f68.google.com ([209.85.161.68]:43072 "EHLO
        mail-yw1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729742AbfJ1Ni0 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 28 Oct 2019 09:38:26 -0400
Received: by mail-yw1-f68.google.com with SMTP id g77so3758049ywb.10
        for <linux-rdma@vger.kernel.org>; Mon, 28 Oct 2019 06:38:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TtJfyUrXOKHjbHAk38WsBkGYd2FzgXJEVxxLEu2ZbtU=;
        b=hUf82FEcOXTf0kHsnpjS9o25HJwpo/Rko7T4wQF0QEi6qJ0cCGbrgoeWMAVoWJei1b
         KZPU37r7bN6kIVYqTagekOlNdyQVzHDYm4+PtcSsysB+8AdkuzXd+Dgybu66Yx3qzt9g
         vlymsw3fAOrQANpd4djVf+Yov9+VPOz8C3RcS6GRZ2eyN+Nb+yL9A/HySGTph/HzKjZU
         89oEh/8cMMNpx6K4CWWkNjkUjTc/UMF424vWkoVIFxicV+iIbUbnv2tYcO8whd9ZC9F2
         2dq8N9ZCO6BVaQmT1W75t+q5NLRSR3KxCXMScaFge51f4/p1UuYbwrJCk/QHg3UOxj6h
         1RmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TtJfyUrXOKHjbHAk38WsBkGYd2FzgXJEVxxLEu2ZbtU=;
        b=ILqT2qBXGRHIAQjuvXcmwI82oll1A2ZyXQHRKbphK7mdQHbhTuQbSAAlkFtFvg770C
         qs5gekfDTxHn3MPhZQNGhoZN/83NTxFAZ4zJ3epqAvYjQ5ZVIIsDI4DH6o7v5aao2ztR
         BmV+3QSmCRXkgu9Qx97PbBClsKk8ZqqR1dX0sutABHmOfAFLQQbhM0QMX8G+WOwmSCjc
         NOHqYJkC7Ngv8ZZLpCKjxTcQ0IE2yrUBm6TSUmxvay/TYJ2/00Uh3KFrhg9dObR6A+kG
         BYQvTZ4/JJKqoQTe7PBMCv9L2kSK0Hr4vZF23IShENNI3socVYL/v2btM1maoIH4c2hW
         MHIw==
X-Gm-Message-State: APjAAAUf36MC9JByu/UAfriU57fR54fNIxpWJJ0z0UobkgN50rG/tioM
        u7K9SGbHIeqnmda5tJEApIwjFNLuXFcnxQVJ5No=
X-Google-Smtp-Source: APXvYqyBpqTLzXB8gmsh5KOgaGLdaIWl2aq7PGydQq6ajaSWFXQczMYVbkPld6Q3kOF+feMqRs8g+qvACE0jgyJA/6g=
X-Received: by 2002:a0d:f6c3:: with SMTP id g186mr12869241ywf.500.1572269905567;
 Mon, 28 Oct 2019 06:38:25 -0700 (PDT)
MIME-Version: 1.0
References: <20191027062234.10993-1-leon@kernel.org>
In-Reply-To: <20191027062234.10993-1-leon@kernel.org>
From:   Or Gerlitz <gerlitz.or@gmail.com>
Date:   Mon, 28 Oct 2019 15:38:13 +0200
Message-ID: <CAJ3xEMiV-ufcJST70i7J1UOkmx2tV=kc77GiRYKX8Yq4UyXpZQ@mail.gmail.com>
Subject: Re: [PATCH rdma-next v1] IB/mlx5: Test write combining support
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Michael Guralnik <michaelgur@mellanox.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Leon Romanovsky <leonro@mellanox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sun, Oct 27, 2019 at 8:29 AM Leon Romanovsky <leon@kernel.org> wrote:
>
> From: Michael Guralnik <michaelgur@mellanox.com>
>
> Add a test in mlx5_ib initialization process to test whether
> write-combining is supported on the machine.
> The test will run as part of the enable_driver callback to ensure that
> the test runs after the device is setup and can create and modify the
> QP needed, but runs before the device is exposed to the users.
>
> The test opens UD QP and posts NOP WQEs, the WQE written to the BlueFlame
> is differnet from the WQE in memory, requesting CQE only on the BlueFlame

nit: different

> WQE. By checking whether we received a completion on one of these WQEs we
> can know if BlueFlame succeeded and whether write-combining is supported.
>
> Change reporting of BlueFlame support to be dependent on write-combining
> support.
