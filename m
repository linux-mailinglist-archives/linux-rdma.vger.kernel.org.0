Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9C1BF6729C
	for <lists+linux-rdma@lfdr.de>; Fri, 12 Jul 2019 17:41:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727033AbfGLPlb (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 12 Jul 2019 11:41:31 -0400
Received: from mail-qt1-f178.google.com ([209.85.160.178]:36015 "EHLO
        mail-qt1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726318AbfGLPla (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 12 Jul 2019 11:41:30 -0400
Received: by mail-qt1-f178.google.com with SMTP id z4so8531871qtc.3
        for <linux-rdma@vger.kernel.org>; Fri, 12 Jul 2019 08:41:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=pYpyIQhiJ9WMOZjoLQTBbnoP77ToHOVObyV+FTX7eek=;
        b=etmCSMmqdzH/RJX9Tk4hR9rhXEstx44a+nIga2cIojE25N3D0H1/z/kAftqw0k7CY7
         J2OSgFaLe1xk7DnE9tDBoHHsotqXQ7QVDwYIlQM3JRwiC8wtqcJTmzSC8ZUN+77flWPc
         j0HWNZbgP7cJ5Fzt/V79eZt/XwqvFD8j72Nc3oOQDjPFk8rseG6+HslRSm3o1gLAgO4B
         gKJf2sWAa7tAT8T7IoLvrshk7HKWR0vM3wVpUWpmOQTvu1oZgTrHgGcCBp9Q6XfiTcoB
         1/G+gyGmamRyg9Hx9VUlQdg9WpLE+WSZYUyGsL8f/I4uX9Eza1DH3UAgisf68DASnwRb
         cjaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=pYpyIQhiJ9WMOZjoLQTBbnoP77ToHOVObyV+FTX7eek=;
        b=mufPUbA1i4r1Ga52b3L9szVcrFaQoRlzZ2Ei8p9NFO7MjWWQjdaZSUP6Eg2lmXgcWI
         plv8ebl05624HyMGyKVl75yILVve9r8F1uwTFqNSAhWJgHJUnGYYl/9oLmnd7oJ3SPu2
         VzjtEWrPKjiS2ix8FSxK0rPbflMLTP8lVO+OtUZCvucG+qZPnVqGodBigQ1qhbeDzBEJ
         /3DTOVoHIB89lPTwEAAHuMsmVADz0GmHFlDKhxBlGSy0tsVQU9D/FfsJL4CnmC85v+z0
         PZMaNMStgykn7Ti/HCPZ7FKjueUDABJEIrFzU74heUMN0edDM0kCiT01zE768WXhTnep
         2UMQ==
X-Gm-Message-State: APjAAAV3pAgInKjOG5yn9v9KF8kVwXdBRQQr4TluTdh/KaIhm3DlYAsw
        BSYX/Sbm4BGg6xHCPB5nIjpatw==
X-Google-Smtp-Source: APXvYqxP2e+qQnYvrWA0mo7GuHh8nKLr/4eZS7HwBSQmnrpRfZSqcq0PkErJ1BQRu0646UPA8JkyHA==
X-Received: by 2002:ad4:5311:: with SMTP id y17mr7222101qvr.1.1562946089944;
        Fri, 12 Jul 2019 08:41:29 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-55-100.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.55.100])
        by smtp.gmail.com with ESMTPSA id 123sm3437534qkm.61.2019.07.12.08.41.29
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 12 Jul 2019 08:41:29 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1hlxft-0002x6-1w; Fri, 12 Jul 2019 12:41:29 -0300
Date:   Fri, 12 Jul 2019 12:41:29 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Honggang Li <honli@redhat.com>
Cc:     bvanassche@acm.org, linux-rdma@vger.kernel.org
Subject: Re: [rdma-core patch v2] srp_daemon: improve the debug message for
 is_enabled_by_rules_file
Message-ID: <20190712154129.GK27512@ziepe.ca>
References: <20190712143147.10414-1-honli@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190712143147.10414-1-honli@redhat.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Jul 12, 2019 at 10:31:47AM -0400, Honggang Li wrote:
> Signed-off-by: Honggang Li <honli@redhat.com>

This really needs some commit message explaining why this should be
done

Jason
