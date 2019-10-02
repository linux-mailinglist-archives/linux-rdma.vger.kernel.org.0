Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1CE49C8EF3
	for <lists+linux-rdma@lfdr.de>; Wed,  2 Oct 2019 18:51:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726267AbfJBQvD (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 2 Oct 2019 12:51:03 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:41402 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726101AbfJBQvC (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 2 Oct 2019 12:51:02 -0400
Received: by mail-qt1-f195.google.com with SMTP id d16so6638490qtq.8
        for <linux-rdma@vger.kernel.org>; Wed, 02 Oct 2019 09:51:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=TYQkCV9xVXdpSyLpTjhxHurX6ehq4VZU8Iu+BbmJg3I=;
        b=U6zAApFRZHP6SAKRMhBuQ3+Xp77wJ69s4TmNpgiWZrZkpHWUa6LaEsOcoOqvyccjtY
         /1sNHYY/Js/KZSCaFg9o9xQ7XXuJQLvIshYXHrmnvdU/Yvuh+iErULSv/ti8tnjKm7JU
         rZXpSKIjDPnBBULwLb5ZUq4KwfwR2h0h5sf2COgc/Nsmy3ALsKZjAnBLS6ztP9bXVFyn
         gLnzhLw/t8NWeO/0P18hYcg8LF6xAkY3oWcsP7EcqPtRjL+Qt94HQQbw/laDRf7QmKXh
         OxH1EvZGp+1YhkO6cSiDgdH6bH3Nm+d1T4VO+RNvElBYIRP1+SQICEdLdQtIBhTHxkCd
         AwAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=TYQkCV9xVXdpSyLpTjhxHurX6ehq4VZU8Iu+BbmJg3I=;
        b=t6cWCPuaHExc0RcTT+bqtcsmfdngJoelRfSt9bVd3/KFe28blSceYBvCw9y9bpblYV
         bcXyac+RSSzTUJykTSTOfYROW8D20lfDVoCfMRZY7O4NtYQc0q6t+ovOonM1MRYeyelj
         k7ng5VYVSh/33TRuzsntUONhzheUqZJd/Sv0/kMTsYaywIT+Bwz2tGSVmt99jGcXFp37
         08Y+UZ1/yN5ubBfukfCwvGFJqJn0xBx/7uq/P5a8+koTlkqIRfNUIKE8BOuOfwSGpnc2
         SQiwax7rmuck4nolBCblSoGJEFFf8XTgvb6QwVP/aCBcihNfrh9FYbwSVH1+ieMQA6aV
         pbhA==
X-Gm-Message-State: APjAAAUL40lbtVYogICDC/TeHQZtwD/EhjCoe7EUA9AmTnHYaRm2FbOh
        M8NeUdBdbf7i+IgoAwMOTfixKg==
X-Google-Smtp-Source: APXvYqxpprWQvSfds3HPfZiBeR4qijYTLxSAmpyn+1Qt+zqfZ1LYXVxVmM/gw6dbhEt3+wBmF/1tVw==
X-Received: by 2002:a05:6214:801:: with SMTP id df1mr3964692qvb.82.1570035061842;
        Wed, 02 Oct 2019 09:51:01 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-162-113-180.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.113.180])
        by smtp.gmail.com with ESMTPSA id z72sm9577446qka.115.2019.10.02.09.51.01
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 02 Oct 2019 09:51:01 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1iFhq8-00032K-PX; Wed, 02 Oct 2019 13:51:00 -0300
Date:   Wed, 2 Oct 2019 13:51:00 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Bart Van Assche <bvanassche@acm.org>,
        Jack Morgenstein <jackm@dev.mellanox.co.il>
Cc:     Leon Romanovsky <leonro@mellanox.com>,
        Doug Ledford <dledford@redhat.com>, linux-rdma@vger.kernel.org,
        Honggang LI <honli@redhat.com>,
        Laurence Oberman <loberman@redhat.com>
Subject: Re: [PATCH 09/15] RDMA/srpt: Fix handling of SR-IOV and iWARP ports
Message-ID: <20191002165100.GF17152@ziepe.ca>
References: <20190930231707.48259-1-bvanassche@acm.org>
 <20190930231707.48259-10-bvanassche@acm.org>
 <20191002141451.GA17152@ziepe.ca>
 <cb5c838a-4a0e-7cac-cc0a-ae218b34d50f@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cb5c838a-4a0e-7cac-cc0a-ae218b34d50f@acm.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Oct 02, 2019 at 08:21:45AM -0700, Bart Van Assche wrote:
> On 10/2/19 7:14 AM, Jason Gunthorpe wrote:
> > On Mon, Sep 30, 2019 at 04:17:01PM -0700, Bart Van Assche wrote:
> >> Management datagrams (MADs) are not supported by SR-IOV VFs nor by
> >> iWARP
> > 
> > Really? This seems surprising to me..
> 
> Hi Jason,
> 
> Last time I checked the Mellanox drivers allow MADs to be sent over a
> SR-IOV VF but do not allow MADs to be received through such a VF.

I think that is only true of mlx4, mlx5 allows receive, AFAIK

I don't know if registering a mad agent fails though. Jack?

> I haven't been able to find any reference to management datagrams in the
> iWARP RFC. Maybe that means that I overlooked something?

Iwarp makes sense

Jason
