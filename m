Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 79853E0CA5
	for <lists+linux-rdma@lfdr.de>; Tue, 22 Oct 2019 21:36:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729696AbfJVTgn (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 22 Oct 2019 15:36:43 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:42706 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731806AbfJVTgm (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 22 Oct 2019 15:36:42 -0400
Received: by mail-qk1-f196.google.com with SMTP id m4so501747qke.9
        for <linux-rdma@vger.kernel.org>; Tue, 22 Oct 2019 12:36:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=6PHeW2noyM32607JacjJbFVBXhG9muWeUxfWBzOFxHc=;
        b=o8bK5ielBX2sIAel4yZzotWreRLFQDr6bNDv1pahYYNZVRcRGnX57+wuHNKsuIHftV
         dZDs4YfXTDyBVKKWDdWy7sAu6eCSa+zDUWR4hLen5r0oodeMQDsnCT29WTcSr0cW4t3t
         iBa9Pb1Uo0FQSmd0BCK0VElwavHtjpRmkckoksPIqqA9nxAJkAePMGVMBl9EWmdltjvV
         Tz72Z2biz6PY9VfFFji1rEMKf3pZ3xhn2tsheU2HshM3LrdgDZMlyeBA124t7qqscKob
         BtGZ4BReEP/QK201JhhAdwQEe3YZi1VmkClfO9BSCjxajFQTu/uULMs0WJOeuxZqYtKF
         7qDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=6PHeW2noyM32607JacjJbFVBXhG9muWeUxfWBzOFxHc=;
        b=D6SSo4q04jsg8g+7ch1/vnKnDCnN7AyypcRHP7n8DKmShuwKz4J0r8LeY8h3RTrlF9
         ssNYTWgEKPZQpV1O7pMCbSbQPPyzmk/WquF4CoRI7thoGPiJQk8gmbubrhEiH8EDFYa/
         OesqXOmYj4h2T74x6PtoqmANsjIlhFDGAN78zBAdWVKWTyedyLkcH6bGs/Fla3pPpuxB
         jdanrG4FrV4CAnS3vhQjufydAGLD5WWVQRcXbbv93gGG/Xtfsb9cKMgeXhGmqVzanIuZ
         8fFlNYZfmVqXLyNl/GQ7A4/kvHCmnRq9rB8YPyQ+i6sv6ujiTeDqvUjV5MPIup9fpu0/
         G1ow==
X-Gm-Message-State: APjAAAXO2gBOCjiqKTmtjv3jA4/CWy52nXMaWSkoTuknQluER7NJDZs3
        N/Gz7Dt3esZx14KvELZ+8l9H6w==
X-Google-Smtp-Source: APXvYqxf7NzaO89nn9VWhDM5kCi4rvOzLM2GG9d6u/8J8/bOaGdg/AkXj19L4Im6ndtbexf8XSyAMA==
X-Received: by 2002:a05:620a:1492:: with SMTP id w18mr1265506qkj.167.1571773001825;
        Tue, 22 Oct 2019 12:36:41 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-162-113-180.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.113.180])
        by smtp.gmail.com with ESMTPSA id k29sm10437221qtu.70.2019.10.22.12.36.41
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 22 Oct 2019 12:36:41 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1iMzxR-00036H-0l; Tue, 22 Oct 2019 16:36:41 -0300
Date:   Tue, 22 Oct 2019 16:36:41 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Michal Kalderon <michal.kalderon@marvell.com>
Cc:     aelior@marvell.com, dledford@redhat.com,
        linux-rdma@vger.kernel.org, Ariel Elior <ariel.elior@marvell.com>
Subject: Re: [PATCH v2 rdma-next 2/2] RDMA/qedr: Fix memory leak in user qp
 and mr
Message-ID: <20191022193640.GH23952@ziepe.ca>
References: <20191016114242.10736-1-michal.kalderon@marvell.com>
 <20191016114242.10736-3-michal.kalderon@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191016114242.10736-3-michal.kalderon@marvell.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Oct 16, 2019 at 02:42:42PM +0300, Michal Kalderon wrote:
> User QPs pbl's won't freed properly.
> MR pbls won't freed properly.
> 
> Signed-off-by: Ariel Elior <ariel.elior@marvell.com>
> Signed-off-by: Michal Kalderon <michal.kalderon@marvell.com>

Fixes line?

Jason
