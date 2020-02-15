Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7A44115FB56
	for <lists+linux-rdma@lfdr.de>; Sat, 15 Feb 2020 01:11:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727455AbgBOALd (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 14 Feb 2020 19:11:33 -0500
Received: from mail-qv1-f67.google.com ([209.85.219.67]:40523 "EHLO
        mail-qv1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726079AbgBOALd (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 14 Feb 2020 19:11:33 -0500
Received: by mail-qv1-f67.google.com with SMTP id q9so4189445qvu.7
        for <linux-rdma@vger.kernel.org>; Fri, 14 Feb 2020 16:11:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=bt/mFk39YLL/Vo9iabNazIa7ov2bWUx1GTRZaUr59YQ=;
        b=dA9SZEW/x6czRT6eGm0jeZJgSuqKfSgKWi2sVzBvViqChBE/cxHo/kg3lRAw86h/gL
         rl6+37lH9Qw9tRmVGDfhqpTPXe+veU9yU+On8Rlb0Ttwl2hnAnT1LsueEexr1r3YRp+2
         0ltymhaIiadDBhBFuT95bj+Wc+vCI17BD2pGnL4kMVjuJ2jzdGdKCCCwpj8G077cghPY
         1ZF29Ve0x3UXqVDA2pN1WNkR3mW7VPuKlAh39XL3jDQ8OkIpy+73SGx57X1kRyEb8Bqa
         3Vvag0RQQl7EeJSSqiBZPOf4FIZvmuwoRwrllA4yQjiWed3tfzQkKXpa/pGozggRhm6U
         iuWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=bt/mFk39YLL/Vo9iabNazIa7ov2bWUx1GTRZaUr59YQ=;
        b=juXBsUn12KDLOPF00oFMtJPgwk9Lfo1MMK9Ni4GeMTSTQnVJUrv5jZUXK4DLQ3QR9Z
         C/WzcKr0kbdHT8JwL8xHIZepIaMDMQWSot3MmDyCWyggewUu4nm2RRf2FhDAwn4+mzio
         bfYzhBz/13ROdF7q9NfdWGqRMIvk5xBgtlnCRMX4I5t/8Bi0mJiRN3I1bSAnN2p6cNkG
         S9wSqZU08dpTe8WiSupUo/tj6MNU8e2TMctSDHhOf79PQMHVkWI2MCKKzVPk98khKLLp
         s1ofhn+wpKlzY5zl4Yg10SN+tzCQ6+eThw++niwZZQ1rvi/C97TmJDiCRP04pYtWkdw2
         +8iQ==
X-Gm-Message-State: APjAAAVpdqTk85tcfchhwYeXZObAzQ/N8WVmaaH8/bSwxBvkjEqHQmtv
        HWltINLNkrdWr9fDaJJcvsaNjQ==
X-Google-Smtp-Source: APXvYqysZTKxAOte76h8YkXGLdIa8IvWGOli+8wQ5M7i/cLevuL2sjc0CSwQjvKUNMtmqEb69Tfpzg==
X-Received: by 2002:a05:6214:1090:: with SMTP id o16mr4441588qvr.105.1581725491011;
        Fri, 14 Feb 2020 16:11:31 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-68-57-212.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.57.212])
        by smtp.gmail.com with ESMTPSA id h12sm4206198qtn.56.2020.02.14.16.11.30
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 14 Feb 2020 16:11:30 -0800 (PST)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1j2l3S-0003qN-4p; Fri, 14 Feb 2020 20:11:30 -0400
Date:   Fri, 14 Feb 2020 20:11:30 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Andrew Boyer <aboyer@pensando.io>,
        Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Cc:     linux-rdma@vger.kernel.org, Allen Hubbe <allenbh@pensando.io>,
        Leon Romanovsky <leonro@mellanox.com>,
        Doug Ledford <dledford@redhat.com>
Subject: Re: Which print functions to use during early device create?
Message-ID: <20200215001130.GB31668@ziepe.ca>
References: <7A6D8934-9D25-4BDF-BCBA-B37CAA064677@pensando.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7A6D8934-9D25-4BDF-BCBA-B37CAA064677@pensando.io>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Feb 14, 2020 at 05:23:29PM -0500, Andrew Boyer wrote:

> When we get a NETDEV_REGISTER event, we get a pointer to the
> existing struct netdev. If all goes well, we end up creating an
> associated struct ib_device.

New rdma drivers cannot use the hacky NETDEV_REGISTER to bind to
netdevs.

Jeff & co are working on 'virtual bus' to provide the right kind of
binding for multi-function PCI devices:

https://patchwork.kernel.org/project/linux-rdma/list/?series=240585

You should probably strike a deal to review their driver if they
review yours :)

Jason
