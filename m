Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4CEB5D0146
	for <lists+linux-rdma@lfdr.de>; Tue,  8 Oct 2019 21:37:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728465AbfJHThF (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 8 Oct 2019 15:37:05 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:40190 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727336AbfJHThF (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 8 Oct 2019 15:37:05 -0400
Received: by mail-qk1-f195.google.com with SMTP id y144so17920959qkb.7
        for <linux-rdma@vger.kernel.org>; Tue, 08 Oct 2019 12:37:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=qrz07qV3dYOYqKT8yLzm/Q15ozQ6e+bg/kLVufAYSAs=;
        b=G4a3j1tL5eWsItD73vngNBafKfMi9vckSxgr87+OVlZqzukOKbI0qd2lDdMi7SnXT6
         il24dM4ZDxvhpatVOPm9VLH7uA+n/wczcxu7yBfJb/kfHTajqpJkboTocwE3TCYBNFO7
         gr6Y8rQ9BsXMTc9ofKx2vPYunXiS23rHBsXTQ+Ga721lcmpWzEtrggRmpl0u01pmoeFY
         Pf4vP1nV/nPa+Tc98OGls/kfDkgWvCNvoPmZq4VDBr/aw003Pvv0JxuTqNGmuh5NN/L1
         Vwb3bKc9RLmGgYUPfcOP7t8QBwPdufmr8DUWo4oDVvOCOX5qz111Cc3q7YKCiEq7I0vy
         Zr/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=qrz07qV3dYOYqKT8yLzm/Q15ozQ6e+bg/kLVufAYSAs=;
        b=mgxoa5F3RAPICVo68RG0IPdVepRviFUqVIqI7te2eYSJieDdUbWFqkTOnx6HPJFAIN
         yCXLzFSh466qYjQOZCSmqYy1xR0hK4uIgqCLc8fVB8XSDs2MWWSgLWQztWSi4SrAoTTH
         Un8KF3P01UjEHlKIyvF1ebP+PvXLm1s03gPhZPdyJ9Ok8sRjRS/yK6U9wEa9Bpyij7Xa
         Ak8T39uD3G9VtqYjuAQPY42kcBwpS10SS/QGj4Z2HI2s9c9DS9qDgqAsnKLnUka3q2vs
         Fw43S7O8t38Qk2ZtRHH4cTJfQjhoGRe1vmXonn/nAWKReokIEU9njg8b/e5obJsgv1cO
         gWLA==
X-Gm-Message-State: APjAAAX54rfsIBGX1nVi6FFfbzoubtE5Dd8bzb3IpiaaLlO6R4ui/ugy
        tkr/h6mQywxtU2oCNwdie6zTWQ==
X-Google-Smtp-Source: APXvYqz8jitd/EWfHDaM1QDafqy/3B/uJ8XvFNQHtfB7d0pTmn26NnfJPYU3S8YPQt4nEyqTth1Ohg==
X-Received: by 2002:a37:aa96:: with SMTP id t144mr31768763qke.275.1570563424126;
        Tue, 08 Oct 2019 12:37:04 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-162-113-180.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.113.180])
        by smtp.gmail.com with ESMTPSA id t63sm9352025qkf.48.2019.10.08.12.37.03
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 08 Oct 2019 12:37:03 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1iHvI7-0007Fs-6N; Tue, 08 Oct 2019 16:37:03 -0300
Date:   Tue, 8 Oct 2019 16:37:03 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Max Gurtovoy <maxg@mellanox.com>
Cc:     linux-rdma@vger.kernel.org, dledford@redhat.com,
        leonro@mellanox.com, sagi@grimberg.me
Subject: Re: [PATCH 1/1] IB/iser: use iser_err instead of pr_err for logging
Message-ID: <20191008193703.GA27863@ziepe.ca>
References: <1570366580-24097-1-git-send-email-maxg@mellanox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1570366580-24097-1-git-send-email-maxg@mellanox.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sun, Oct 06, 2019 at 03:56:20PM +0300, Max Gurtovoy wrote:
> Make sure all the debug prints in ib_iser module use the common driver
> logger.
> 
> Signed-off-by: Max Gurtovoy <maxg@mellanox.com>
> ---
>  drivers/infiniband/ulp/iser/iser_verbs.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Applied to for-next, thanks

Jason
