Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7EE023DBB1
	for <lists+linux-rdma@lfdr.de>; Tue, 11 Jun 2019 22:12:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405799AbfFKUL7 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 11 Jun 2019 16:11:59 -0400
Received: from mail-ua1-f65.google.com ([209.85.222.65]:36498 "EHLO
        mail-ua1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405476AbfFKUL7 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 11 Jun 2019 16:11:59 -0400
Received: by mail-ua1-f65.google.com with SMTP id 94so5037870uam.3
        for <linux-rdma@vger.kernel.org>; Tue, 11 Jun 2019 13:11:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=3bPeK+CLQa8N7YbQMrJKIkMaWwhASd3cxSvc0yjCu6s=;
        b=UVRZSI74ejRvkf1aZO/n1V2sCKsv8eBZiw1oTfe7B3hZBKFSyvvChE+CbHieT3wA7a
         WirZ21xAaFM4gFPd26o12mliIjtO5hjPWRl13ziq0OaMUpzcQ8xEuTDUXHUsXPncPSVL
         LX5nWYTM1MozGSl7PhjYOqfNcTHGbY3T5VWubpSi5iIKulW6YX+xUGbR9Ne4LpyZiEhO
         Fs9/0hylwVnZwFQZVvC9TCOvEqGbhQKnLEy51Qd1nrMUhMA1eQeXLrJifKyvhd74sLff
         Ml6t7KxNMRJmIYgdqLUw8NJq8n7gaPAtP2e3RF0FTTw9gQ4aFdO8EPfA/ICK28kdr9WR
         3p/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=3bPeK+CLQa8N7YbQMrJKIkMaWwhASd3cxSvc0yjCu6s=;
        b=Um9iCi1wu57akeRI1lf7ZPQfahOQbBm7IFvtbcBjf4L6Vgo81VHZZ1y8RXseNnmSMT
         phEA912km4ucrp2CoZ8jpOfqPWwkOKU+aX7QIe9nDc6sY3OTE0r3qZ6gmD3cS+ITThS+
         z5XcfmbBuCG5virEJuCJQfvLyODP+P+XZX2AtvwRKhU7jJXJOFmekB/giRIzFDOzQuxR
         bvx2IIWWA/qlN+Y2xlcI1QF+0fEEmnru4xHT0x9bdeacyaLIabWtt5P1VaOVWBfDEABj
         Zc+9saerCb81dIVB5Omuabtgvj4buHK9BEO+KClxW55SN1zkjwkMw9O8ExAHQonkKXu1
         beYg==
X-Gm-Message-State: APjAAAWX0L1pALG82dzPfabS3XRSYlUlouu1oALPgVaE04H+GFEO7Imz
        0uOn+cPpaOBcZ5qT1ETj79GQLw==
X-Google-Smtp-Source: APXvYqzR7pCuJzmMYzbO629Y6vy6d3ESbvCwTN8N7tu6JsNPd/gSZutBm+L3CBRBx39IF/fKHh4pDw==
X-Received: by 2002:ab0:138e:: with SMTP id m14mr3062252uae.71.1560283916898;
        Tue, 11 Jun 2019 13:11:56 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-55-100.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.55.100])
        by smtp.gmail.com with ESMTPSA id 126sm4925038vkt.14.2019.06.11.13.11.56
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 11 Jun 2019 13:11:56 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1han7c-0006ud-0q; Tue, 11 Jun 2019 17:11:56 -0300
Date:   Tue, 11 Jun 2019 17:11:56 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Dennis Dalessandro <dennis.dalessandro@intel.com>
Cc:     dledford@redhat.com, linux-rdma@vger.kernel.org
Subject: Re: [PATCH for-rc 0/3] IB/hfi1: Fixes for 5.2 RC cycle
Message-ID: <20190611201155.GB26457@ziepe.ca>
References: <20190607113807.157915.48581.stgit@awfm-01.aw.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190607113807.157915.48581.stgit@awfm-01.aw.intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Jun 07, 2019 at 07:39:05AM -0400, Dennis Dalessandro wrote:
> We have a couple of fixes we'd like to try and get into the rc cycle. These 3
> are all targeted to stable as well. One fixes an issue of not validating user
> input that was reported by Dan C. We have a race condition that leads to a
> hung SDMA engine as well as a fix for a problem when verbs and kdeth packets
> get processed on different cpus for the same qp.
> 
> 
> Kaike Wan (1):
>       IB/hfi1: Validate fault injection opcode user input
> 
> Mike Marciniszyn (2):
>       IB/hfi1: Close PSM sdma_progress sleep window
>       IB/hfi1: Correct tid qp rcd to match verbs context

Applied to for-rc, thanks

Jason
