Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B667CA7B19
	for <lists+linux-rdma@lfdr.de>; Wed,  4 Sep 2019 08:03:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726045AbfIDGDx (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 4 Sep 2019 02:03:53 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:33315 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726004AbfIDGDw (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 4 Sep 2019 02:03:52 -0400
Received: by mail-wm1-f65.google.com with SMTP id r17so1659283wme.0
        for <linux-rdma@vger.kernel.org>; Tue, 03 Sep 2019 23:03:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=y/z0hlgT57PCDtEPbb3IoLHEKNEUuUEoJM+5ocU0Lr0=;
        b=fYZyw03bg37JCEMyYALuI6ZLz5yYH+ZAybZj8FyHIvD7Too31OOxU6inIS2RlOj25b
         fZbVOsqDm1OjT+sqHTWdulZkaS7XECK9gyNhXsBH4qFdhSQP/Q3UkpwxjXsTwtk6VowN
         9yufWceLJDjbPJ288Um0odSQEVvW35HwUGYFXFDl4e1bWVQhS5IymhRXnntKn8HrIWkw
         hp0dqEuJZicxhx2gPhMQqqVbhKKMCWwohev8CPC2f/jHi1qKb5yTGLKFlWwIYqx9TsaI
         BmzQ1+5yBtNJMrMjWGrQX9JVfz9KuI6gte0GjpQxaIZMJ6xn7EiQiaEg3VKVUvMBcjdu
         8fjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=y/z0hlgT57PCDtEPbb3IoLHEKNEUuUEoJM+5ocU0Lr0=;
        b=aFo8GmksEK+uq8ljIpskDDe5s87DffSt4/7ityIfnNkzLDGQUt3q+cZqrLiSK3HSvX
         DUqG68gonkAEPni69VsSbat30j5+Ow3jZEbS6nAKSfuw89hx6e4odL5TcWrQbGwle89v
         iUsLt/NXqBFSDmiBqTBgl2XwqOv7h9+xt4OeK6GV7aFDpYVDOo2FPqg6RQUu7tvmkN0i
         jVy2nXfRVmPeqPNGpB5r+RUomhA32uc9HCaS330foXmATKxiCJp0X6ZdAvNKO3oai68Z
         6GIjXmzQaIPFpqp/ctXdHss5t/wUJfQPaamCihV+5Zm3oGN3Q0nVWTKrQPT/XezW7RIb
         mfgg==
X-Gm-Message-State: APjAAAXynDe6TersHPrzBnfvhizwqyNNQx9S2fJC2Yays6W+eUEVH967
        nZgKm9VtKshfaQpc3TCwnojodg==
X-Google-Smtp-Source: APXvYqzIDc00fhxkG0ty7LD1Q2IkZIrsWP9WrWV4gUOTvZLRa0e1BYjIoxpiDjtiQtitrK99IHCOSw==
X-Received: by 2002:a1c:ca02:: with SMTP id a2mr2957344wmg.127.1567577030768;
        Tue, 03 Sep 2019 23:03:50 -0700 (PDT)
Received: from ziepe.ca ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id f186sm4080443wmg.21.2019.09.03.23.03.50
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 03 Sep 2019 23:03:50 -0700 (PDT)
Received: from jgg by jggl.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1i5OOS-0001Bm-C7; Wed, 04 Sep 2019 03:03:48 -0300
Date:   Wed, 4 Sep 2019 03:03:48 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Mark Bloch <markb@mellanox.com>
Cc:     Sagi Grimberg <sagi@grimberg.me>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH] iwcm: don't hold the irq disabled lock on iw_rem_ref
Message-ID: <20190904060348.GB3936@ziepe.ca>
References: <20190903192223.17342-1-sagi@grimberg.me>
 <3859b00b-9963-32c5-b6ed-8433fc4ec409@mellanox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3859b00b-9963-32c5-b6ed-8433fc4ec409@mellanox.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Sep 03, 2019 at 07:33:08PM +0000, Mark Bloch wrote:
> 
> 
> On 9/3/19 12:22 PM, Sagi Grimberg wrote:
> > This may be the final put on a qp and result in freeing
> > resourcesand should not be done with interrupts disabled.
> > 
> > Produce the following warning:
> 
> Shouldn't you first do cm_id_priv->qp = NULL and only then
> unlock and destroy the qp?
> 
> Mark
> >  	}
> >  	spin_unlock_irqrestore(&cm_id_priv->lock, flags);

Would avoid the sketchy unlock too.. But does it work?

Jason
 
