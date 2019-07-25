Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ACEC175734
	for <lists+linux-rdma@lfdr.de>; Thu, 25 Jul 2019 20:47:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726357AbfGYSrq (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 25 Jul 2019 14:47:46 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:44035 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726354AbfGYSrq (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 25 Jul 2019 14:47:46 -0400
Received: by mail-qt1-f193.google.com with SMTP id 44so19092984qtg.11
        for <linux-rdma@vger.kernel.org>; Thu, 25 Jul 2019 11:47:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=4I62MzHjfA02a4buLmCoHgxlf9ehEVrkfEadSE6IIt0=;
        b=kS/lQ/BwRybKKsNcIB8P5l3TJmz+40T6H41ntSuwSQXrKv9yGIHdDVo0Y37QI4liwg
         jlCpUcyDB2DLjt6BqNHWDJKP7Lpv8vHuvgOtY6MPFEsfdSLRniVc1eCOj0EdASvJASUK
         eDf2XChim4QoFo25l4nksOCN2mKKh0eNXtisCLt4Kn98UKDY+1Y18SkFdgr6ptYg2vIg
         Gb75NPHGr9uMD1VwDBK1YAr4N+9QMtTZUzpIOfDhfaRE3iWUYfXuzBf8dRlBkvN72wS5
         lOZ0CtMP1EXe6Kdtu7oiuTaW9sZaDjYug8JmnZ5MYe8JK3fcnMnU6+1UeLPcBhwHB0m9
         bkSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=4I62MzHjfA02a4buLmCoHgxlf9ehEVrkfEadSE6IIt0=;
        b=ZH60ShxTdZxXnf/sl/cC8hb9GJ6MFRp/KHj8FNPZjY/Ctg3zEwIceuYoSUovO7+caH
         WZuVSgG13X+Jl9hLG1maVMMMdj4b3ix/KGqx4wJhIdgBModV9gUWv74k2CNlqVXBQKll
         umvNIlEYOOOdgYn/kta/Wvz4CxBRF74W3/48OqSn7EGHYwM8FFm6C90KQ4iwAicPSn7P
         qEnMl4MXiKdlmA3pGbdjWuqPAd9bUrmQcgVEro/FaZ31hZnsKKarXmV9VTLPl1NchRZ9
         tMIle74LQxbsZkftXtTeIbjTLFycVIz8u6VpcS+zvrd3l6PTg9HM9z/G9NzeFCIEIAGG
         /CrA==
X-Gm-Message-State: APjAAAUee0wI0jqXyWei3w5To8CJkXjCXmNMCXPC3m6iatixRhsPQ3/+
        Zq2nNxl51TmjiQvCYxM5ZdNROA==
X-Google-Smtp-Source: APXvYqy5VTwXKiVJhMlgkNViAh67HygQEkdXljSTlvMHrBT5WASTmtfexjxaJbrgOzR1KNlSc+o0+Q==
X-Received: by 2002:ac8:381d:: with SMTP id q29mr63378228qtb.347.1564080465355;
        Thu, 25 Jul 2019 11:47:45 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-55-100.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.55.100])
        by smtp.gmail.com with ESMTPSA id n27sm16426673qkk.35.2019.07.25.11.47.44
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 25 Jul 2019 11:47:44 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1hqimG-0000lJ-G3; Thu, 25 Jul 2019 15:47:44 -0300
Date:   Thu, 25 Jul 2019 15:47:44 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Kamal Heib <kamalheib1@gmail.com>
Cc:     linux-rdma@vger.kernel.org, Doug Ledford <dledford@redhat.com>,
        Potnuri Bharat Teja <bharat@chelsio.com>,
        Faisal Latif <faisal.latif@intel.com>,
        Shiraz Saleem <shiraz.saleem@intel.com>
Subject: Re: [PATCH for-next 0/3] {cxgb3, cxgb4, i40iw} Report phys_state
Message-ID: <20190725184744.GC7467@ziepe.ca>
References: <20190722070550.25395-1-kamalheib1@gmail.com>
 <20190722134327.GC7607@ziepe.ca>
 <20190725083736.GB11152@kheib-workstation>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190725083736.GB11152@kheib-workstation>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Jul 25, 2019 at 11:37:37AM +0300, Kamal Heib wrote:
> On Mon, Jul 22, 2019 at 10:43:27AM -0300, Jason Gunthorpe wrote:
> > On Mon, Jul 22, 2019 at 10:05:47AM +0300, Kamal Heib wrote:
> > > This series includes three patches that add the support for reporting
> > > physical state for the cxgb3, cxgb4, and i40iw drivers via sysfs.
> > > 
> > > Kamal Heib (3):
> > >   RDMA/cxgb3: Report phys_state in query_port
> > >   RDMA/cxgb4: Report phys_state in query_port
> > >   RDMA/i40iw: Report phys_state in query_port
> > > 
> > >  drivers/infiniband/hw/cxgb3/iwch_provider.c | 16 +++++++++++-----
> > >  drivers/infiniband/hw/cxgb4/provider.c      | 16 +++++++++++-----
> > >  drivers/infiniband/hw/i40iw/i40iw_verbs.c   |  7 +++++--
> > >  3 files changed, 27 insertions(+), 12 deletions(-)
> > 
> > Lets not have this generic iwapr code open coded please.
> > 
> > The core code already knows what the netdev is for the iWarp device.
> > 
> > Jason
> 
> I'm not sure if I truly understand what you are trying to say here.
> 
> Could you please add more info?

Implement this in the core code if the port type is iwarp

Jason
