Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B3388E31EA
	for <lists+linux-rdma@lfdr.de>; Thu, 24 Oct 2019 14:11:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439616AbfJXMLc (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 24 Oct 2019 08:11:32 -0400
Received: from mail-qk1-f169.google.com ([209.85.222.169]:46567 "EHLO
        mail-qk1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2439599AbfJXMLc (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 24 Oct 2019 08:11:32 -0400
Received: by mail-qk1-f169.google.com with SMTP id e66so23134682qkf.13
        for <linux-rdma@vger.kernel.org>; Thu, 24 Oct 2019 05:11:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=9nJ7GdDboztBKpIMLvkZZETxLlP6ZMhAopB9fsJFIak=;
        b=kzgW/Mfb6r1fBDNfpe4ebe8ycecnFHpT9WGcJ+7qYudc2GMffh5IbwGmsyywmbk1Bu
         7w0LCmpVSKWAjIgBU1QOpLIIWJ+VT5whHTElBX3ypcWYStHh8wu/Ct8Mm1uJtO9EEY5Q
         wxo5d3Mlnt9HQcyJL0zLGieJ/Fa/n01CloSgAbeCeE7u0WoLMK9Y93LaCr7csVWZ3+tL
         kZ65o/Rm9XK1wMAYtQcW4PuanGKqycrMcm6MBs1Cb1kNec/s6jqfrLTKBL3/LKTFIS3l
         O7Sa5rjFwtuxE3ww1OLV/FmtPl/ui6BXGgOXnuT/f8ojOP+2aIg7MEeBA5H2AkSkxN85
         y+AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=9nJ7GdDboztBKpIMLvkZZETxLlP6ZMhAopB9fsJFIak=;
        b=hoj0RC0L8jybqlIu2YeuS+E6soblRYgJi01wzQrworYOL+jzVJUgfSr/374gJcqQaK
         1wZcGXSR9fz2+5h/NyeyKxReXLbuMUg3JjbF0jN6lW9sFyhAWeR5EAdOP2fKsKR7Tdt7
         xpR8/DjLshTMkscTEj9pZu3h10twuAKiKxjqRbpzs3EB4oknSPlmnZzvQIITOucV7y5p
         yFLXcR2nvC55l7fcyk2PTiYuh32wUcMZHKWgR97JVvaMvKTaA2grnnUkjpiyHh3TiSVJ
         D0NEJ3YB1/XBr4n/pG0DsM/4h86iPdUT0JeKkU17NwAKzCY5hmoPT+7rqsWCaPqRUYJV
         zshw==
X-Gm-Message-State: APjAAAXafbM19AcHtcnpDdSJG4T9vcSKYzZr1w6B8/z40/7AH9bk1q16
        K8m8cvrWZunBTS1Z1CPyqQodrEmYYU0=
X-Google-Smtp-Source: APXvYqwlOJXTat7vjEMaTvUzIzpmHXbS3HUQzX9D+lIbRkg9YAlL5c7jOIX0B8XC97EO7kaLs90TaQ==
X-Received: by 2002:a05:620a:b16:: with SMTP id t22mr13747647qkg.235.1571919089548;
        Thu, 24 Oct 2019 05:11:29 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-162-113-180.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.113.180])
        by smtp.gmail.com with ESMTPSA id t4sm714259qtq.49.2019.10.24.05.11.28
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 24 Oct 2019 05:11:29 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1iNbxg-0003vn-Bt; Thu, 24 Oct 2019 09:11:28 -0300
Date:   Thu, 24 Oct 2019 09:11:28 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Benjamin Drung <benjamin.drung@cloud.ionos.com>
Cc:     linux-rdma@vger.kernel.org
Subject: Re: srp_daemon and ibacm in wrong man section
Message-ID: <20191024121128.GS23952@ziepe.ca>
References: <41d360c7e2a6db457f3d139a1b35507bc62ae321.camel@cloud.ionos.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41d360c7e2a6db457f3d139a1b35507bc62ae321.camel@cloud.ionos.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Oct 24, 2019 at 12:19:23PM +0200, Benjamin Drung wrote:
> Hi,
> 
> srp_daemon and ibacm are both installed in /usr/sbin. lintian complains
> about command-in-sbin-has-manpage-in-incorrect-section:
> 
> The command in /sbin or /usr/sbin are system administration commands;
> their manpages thus belong in section 8, not section 1.

Yes, srp_daemon should only be invoked by systemd, so it should be in
8

Jason
